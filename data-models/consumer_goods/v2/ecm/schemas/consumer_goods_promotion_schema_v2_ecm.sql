-- Schema for Domain: promotion | Business:  | Version: v2_ecm
-- Generated on: 2026-06-27 05:32:09

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_consumer_goods_v1`.`promotion` COMMENT 'Owns trade promotion planning, execution, and optimization (TPM/TPO). Manages promotional calendars, trade spend allocation, retailer funding agreements, promotional pricing (Hi-Lo, EDLP), accruals, deductions, post-event analysis, promotional lift measurement, ROI/GMROI analysis, and retailer rebate settlements. Integrates with Salesforce TPM.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` (
    `trade_promotion_id` BIGINT COMMENT 'Unique identifier for the trade promotion program. Primary key for the trade promotion entity.',
    `category_id` BIGINT COMMENT 'Identifier of the product category covered by this trade promotion. Links to the product category master entity.',
    `marketing_brand_id` BIGINT COMMENT 'Identifier of the brand participating in this trade promotion. Links to the brand master entity.',
    `employee_id` BIGINT COMMENT 'The owner employee id of the trade promotion record',
    `owner_user_employee_id` BIGINT COMMENT 'Identifier of the business user responsible for planning, executing, and analyzing this trade promotion. Typically a trade marketing manager or category manager. Links to the user or employee master entity.',
    `primary_trade_employee_id` BIGINT COMMENT 'Identifier of the business user who approved this trade promotion. Links to the user or employee master entity.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: REQUIRED: Supplier‑funded trade promotions need a link for budgeting and compliance; experts expect a sponsor supplier on each promotion.',
    `trade_account_id` BIGINT COMMENT 'Identifier of the retail trade account (customer) participating in this promotion. Links to the trade account master entity.',
    `accrual_amount` DECIMAL(18,2) COMMENT 'Total accrued trade spend liability for this promotion, representing funds reserved or committed but not yet paid to the retailer.',
    `actual_spend` DECIMAL(18,2) COMMENT 'The actual spend of the trade promotion record',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the trade promotion record',
    `approval_date` DATE COMMENT 'Date when the trade promotion was formally approved by authorized business stakeholders and authorized for execution.',
    `approval_status` STRING COMMENT 'The approval status of the trade promotion record',
    `authorized_budget_amount` DECIMAL(18,2) COMMENT 'Total authorized trade spend budget allocated for this promotion, including all funding mechanisms (off-invoice, scan-back, display allowances, etc.). Expressed in the companys reporting currency.',
    `baseline_volume_units` DECIMAL(18,2) COMMENT 'Expected sales volume in units without the promotion, used as the baseline for calculating incremental lift and ROI.',
    `channel_type` STRING COMMENT 'Retail channel classification where this promotion is executed. Grocery (supermarkets), mass merchandiser (Walmart/Target), drug (pharmacy chains), convenience (c-stores), club (warehouse clubs), ecommerce (online retail).. Valid values are `grocery|mass_merchandiser|drug|convenience|club|ecommerce`',
    `trade_promotion_code` STRING COMMENT 'The trade promotion code of the trade promotion record',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code where this promotion is executed.. Valid values are `^[A-Z]{3}$`',
    `coupon_flag` BOOLEAN COMMENT 'Indicates whether this promotion includes manufacturer or retailer coupons (print, digital, or mobile). True if coupons are part of the promotion, false otherwise.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this trade promotion record was first created in the system. Represents the business event time of promotion planning initiation.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this promotion record.. Valid values are `^[A-Z]{3}$`',
    `deduction_amount` DECIMAL(18,2) COMMENT 'Total deductions taken by the retailer against invoices for this promotion. Used for reconciliation and settlement tracking.',
    `trade_promotion_description` STRING COMMENT 'The trade promotion description of the trade promotion record',
    `discount_pct` DECIMAL(18,2) COMMENT 'The discount pct of the trade promotion record',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Percentage discount offered to the retailer or consumer as part of this promotion. Expressed as a percentage (e.g., 15.00 for 15% off).',
    `display_type` STRING COMMENT 'Type of in-store merchandising display associated with this promotion. End-cap (end of aisle), free-standing (floor display), shelf-talker (shelf signage), pallet (bulk display), cooler (refrigerated display), none (no special display).. Valid values are `end_cap|free_standing|shelf_talker|pallet|cooler|none`',
    `effective_from` DATE COMMENT 'The effective from of the trade promotion record',
    `effective_until` DATE COMMENT 'The effective until of the trade promotion record',
    `end_date` DATE COMMENT 'The date when the trade promotion concludes and promotional pricing/terms expire at retail.',
    `expected_roi_percentage` DECIMAL(18,2) COMMENT 'Expected return on investment for this promotion, calculated as (incremental profit / trade spend) * 100. Used for pre-event planning and approval.',
    `feature_ad_flag` BOOLEAN COMMENT 'Indicates whether this promotion includes feature advertising in retailer circulars, flyers, or digital media. True if featured, false otherwise.',
    `funding_type` STRING COMMENT 'Mechanism by which trade funds are provided to the retailer. Off-invoice (deducted at purchase), scan-back (reimbursed based on POS sales), bill-back (invoiced after event), lump-sum (fixed payment), accrual (reserved funds).. Valid values are `off_invoice|scan_back|bill_back|lump_sum|accrual`',
    `geographic_scope` STRING COMMENT 'Geographic coverage of the trade promotion. National (entire country), regional (multi-state or territory), local (city or metro area), store-specific (individual retail locations).. Valid values are `national|regional|local|store_specific`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this trade promotion record was last updated. Used for change tracking and audit trail purposes.',
    `maximum_purchase_quantity` STRING COMMENT 'Maximum number of units a consumer can purchase at the promotional price. Null if no maximum limit applies.',
    `mechanic_type` STRING COMMENT 'The mechanic type of the trade promotion record',
    `minimum_purchase_quantity` STRING COMMENT 'Minimum number of units a consumer must purchase to qualify for the promotional offer. Null if no minimum applies.',
    `trade_promotion_name` STRING COMMENT 'The trade promotion name of the trade promotion record',
    `notes` STRING COMMENT 'Free-text field for additional business context, special terms, execution notes, or post-event observations related to this trade promotion.',
    `planned_spend` DECIMAL(18,2) COMMENT 'The planned spend of the trade promotion record',
    `planned_volume` DECIMAL(18,2) COMMENT 'The planned volume of the trade promotion record',
    `pricing_strategy` STRING COMMENT 'Retailer pricing strategy context for this promotion. Hi-Lo (high-low promotional pricing with deep discounts), EDLP (everyday low price with minimal promotions), hybrid (combination approach).. Valid values are `hi_lo|edlp|hybrid`',
    `promotion_name` STRING COMMENT 'Descriptive name of the trade promotion program for business user identification and reporting purposes.',
    `promotion_number` STRING COMMENT 'Business-facing unique identifier for the trade promotion program, typically generated by the TPM system. Format: TPM-YYYYNNNN where YYYY is year and NNNN is sequence.. Valid values are `^TPM-[0-9]{8}$`',
    `promotion_objective` STRING COMMENT 'Primary business objective driving the trade promotion strategy. Volume growth (increase unit sales), market share gain (capture competitor share), new product launch (trial generation), competitive defense (respond to competitor activity), inventory clearance (reduce excess stock), seasonal event (holiday/event-driven).. Valid values are `volume_growth|market_share_gain|new_product_launch|competitive_defense|inventory_clearance|seasonal_event`',
    `promotion_status` STRING COMMENT 'Current lifecycle status of the trade promotion. Planned (in design), approved (authorized for execution), active (currently running), closed (completed with results finalized), cancelled (terminated before completion), on-hold (temporarily suspended).. Valid values are `planned|approved|active|closed|cancelled|on_hold`',
    `promotion_type` STRING COMMENT 'Classification of the trade promotion mechanism. Temporary price reduction (Hi-Lo), feature ad (retailer circular), display (end-cap/shelf), BOGO (buy-one-get-one), multi-buy (quantity discount), scan-back (post-sale rebate). [ENUM-REF-CANDIDATE: temporary_price_reduction|feature_ad|display|bogo|multi_buy|scan_back|off_invoice|coupon|loyalty_reward|edlp|slotting_allowance|markdown_allowance — promote to reference product]. Valid values are `temporary_price_reduction|feature_ad|display|bogo|multi_buy|scan_back`',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the trade promotion record',
    `settlement_status` STRING COMMENT 'Status of financial settlement and reconciliation for trade promotion deductions and accruals. Pending (awaiting settlement), in-progress (reconciliation underway), settled (fully reconciled and paid), disputed (discrepancies under review).. Valid values are `pending|in_progress|settled|disputed`',
    `source_system_code` STRING COMMENT 'The source system code of the trade promotion record',
    `start_date` DATE COMMENT 'The date when the trade promotion becomes active and promotional pricing/terms take effect at retail.',
    `target_volume_units` DECIMAL(18,2) COMMENT 'Target sales volume in units expected to be achieved during the promotion period, including baseline and incremental lift.',
    `tpm_system_reference_code` STRING COMMENT 'External reference identifier from the source Trade Promotion Management system (e.g., Salesforce Consumer Goods Cloud TPM module). Used for system integration and traceability.',
    `trade_promotion_status` STRING COMMENT 'The trade promotion status of the trade promotion record',
    `uom` STRING COMMENT 'The uom of the trade promotion record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the trade promotion record',
    CONSTRAINT pk_trade_promotion PRIMARY KEY(`trade_promotion_id`)
) COMMENT 'Core master entity for trade promotion programs. Captures the full definition of a trade promotion including name, type (Hi-Lo, EDLP, display, coupon, scan-back, off-invoice), promotional period, owning brand/category, status (planned, active, closed, cancelled), total authorized trade spend budget, promotion objectives, promotion type classification (temporary price reduction, feature ad, display, BOGO, multi-buy, scan-back, coupon, loyalty reward), applicable channels, and integration reference to Salesforce TPM. Serves as the SSOT for all trade promotion definitions and the parent entity for all promotion events, spend allocations, and post-event analyses.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_event` (
    `promotion_event_id` BIGINT COMMENT 'Unique identifier for the promotion event. Primary key for this entity.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Required for integrated ROI reporting: each trade promotion event is executed as part of a marketing campaign, enabling campaign‑level performance analysis.',
    `capa_id` BIGINT COMMENT 'Foreign key linking to quality.capa. Business justification: Promotion event scheduling must consider any open CAPA for the product; linking ensures corrective actions are addressed before promotional activities.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Required for promotion spend accounting reports linking each event to the responsible cost center for budgeting and variance analysis.',
    `employee_id` BIGINT COMMENT 'Reference to the user who approved this promotional event for execution.',
    `esg_commitment_id` BIGINT COMMENT 'Foreign key linking to sustainability.esg_commitment. Business justification: Event‑level sustainability reports require linking each promotion event to the ESG commitment it supports for impact tracking.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Enables profit‑center level reporting of promotion performance and ROI, a standard finance requirement.',
    `retail_store_id` BIGINT COMMENT 'Reference to the specific retail store, distribution center, or ship-to location where the promotional event is executed.',
    `trade_account_id` BIGINT COMMENT 'Reference to the retailer or distributor account participating in this promotional event.',
    `trade_promotion_id` BIGINT COMMENT 'Reference to the parent trade promotion program under which this event is executed. A single program may have multiple events across different retailers or time windows.',
    `marketing_event_id` BIGINT COMMENT 'References authoritative SSOT record in marketing.marketing_event.',
    `accrual_amount` DECIMAL(18,2) COMMENT 'The financial accrual amount reserved for this promotional event, representing the estimated liability for trade promotion obligations.',
    `actual_trade_spend_amount` DECIMAL(18,2) COMMENT 'The realized trade spend for this promotional event, representing the total investment actually incurred by the manufacturer.',
    `actual_volume_units` DECIMAL(18,2) COMMENT 'The realized sales volume in units achieved during the promotional event, used for post-event analysis and lift measurement.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the promotion event record',
    `approval_date` DATE COMMENT 'The date when this promotional event was approved for execution by the authorized business stakeholder.',
    `baseline_volume_units` DECIMAL(18,2) COMMENT 'The expected sales volume in units without promotional activity, used as the baseline for calculating promotional lift.',
    `cancellation_date` DATE COMMENT 'The date when this promotional event was cancelled, if applicable.',
    `cancellation_reason` STRING COMMENT 'Textual explanation for why this promotional event was cancelled, if applicable.',
    `promotion_event_code` STRING COMMENT 'The promotion event code of the promotion event record',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this promotional event record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this promotional event record.. Valid values are `^[A-Z]{3}$`',
    `deduction_amount` DECIMAL(18,2) COMMENT 'The total deductions claimed by the retailer against invoices for this promotional event, representing retailer-initiated trade spend recovery.',
    `promotion_event_description` STRING COMMENT 'The promotion event description of the promotion event record',
    `effective_from` DATE COMMENT 'The effective from of the promotion event record',
    `effective_until` DATE COMMENT 'The effective until of the promotion event record',
    `end_date` DATE COMMENT 'The date when the promotional event concludes execution at retail or distribution level.',
    `event_description` STRING COMMENT 'Detailed textual description of the promotional event, including objectives, mechanics, and special conditions.',
    `event_name` STRING COMMENT 'Descriptive name of the promotional event for business user identification and reporting.',
    `event_number` STRING COMMENT 'Business-facing unique identifier for the promotion event, used for external communication and reporting.. Valid values are `^[A-Z0-9]{8,20}$`',
    `event_status` STRING COMMENT 'Current lifecycle status of the promotional event. Planned: event scheduled but not yet approved; Approved: event approved for execution; In Execution: event currently active; Completed: event finished; Cancelled: event terminated before completion.. Valid values are `planned|approved|in_execution|completed|cancelled`',
    `event_type` STRING COMMENT 'Classification of the promotional event mechanism. Feature Ad: product featured in retailer circular; Display: in-store display placement; Temporary Price Reduction (TPR): short-term price discount; BOGO: Buy One Get One offer; Scan-Back: post-sale rebate based on scanned sales; Coupon: manufacturer or retailer coupon redemption.. Valid values are `feature_ad|display|temporary_price_reduction|bogo|scan_back|coupon`',
    `funding_source` STRING COMMENT 'The primary source of funding for this promotional event. Manufacturer: fully funded by manufacturer; Retailer: fully funded by retailer; Cooperative: jointly funded by both parties.. Valid values are `manufacturer|retailer|cooperative`',
    `geography_code` STRING COMMENT 'Three-letter ISO country code representing the geographic market where the event is executed.. Valid values are `^[A-Z]{3}$`',
    `gmroi_ratio` DECIMAL(18,2) COMMENT 'The gross margin return on investment for this promotional event, calculated as Gross Margin / Average Inventory Investment, measuring profitability efficiency.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the promotion event record',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this promotional event record was last modified in the system.',
    `promotion_event_name` STRING COMMENT 'The promotion event name of the promotion event record',
    `notes` STRING COMMENT 'The notes of the promotion event record',
    `planned_lift_pct` DECIMAL(18,2) COMMENT 'The planned lift pct of the promotion event record',
    `planned_trade_spend_amount` DECIMAL(18,2) COMMENT 'The budgeted trade spend allocation for this promotional event, representing the total investment planned by the manufacturer.',
    `planned_volume_units` DECIMAL(18,2) COMMENT 'The forecasted sales volume in units expected during the promotional event, used for planning and ROI estimation.',
    `post_event_analysis_completed_flag` BOOLEAN COMMENT 'Boolean indicator of whether post-event analysis has been completed for this promotional event, including lift measurement and ROI calculation.',
    `post_event_analysis_date` DATE COMMENT 'The date when post-event analysis was completed for this promotional event.',
    `pricing_strategy` STRING COMMENT 'The pricing approach applied during this event. Hi-Lo: high-low promotional pricing with deep temporary discounts; EDLP: Everyday Low Price with minimal promotional variation; Hybrid: combination of both strategies.. Valid values are `hi_lo|edlp|hybrid`',
    `promotion_event_status` STRING COMMENT 'The promotion event status of the promotion event record',
    `promotional_lift_percentage` DECIMAL(18,2) COMMENT 'The percentage increase in sales volume attributable to the promotional event, calculated as (Actual Volume - Baseline Volume) / Baseline Volume * 100.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the promotion event record',
    `rebate_amount` DECIMAL(18,2) COMMENT 'The total rebate amount paid to the retailer for this promotional event, typically calculated post-event based on performance metrics.',
    `roi_percentage` DECIMAL(18,2) COMMENT 'The return on investment for this promotional event, calculated as (Incremental Profit - Trade Spend) / Trade Spend * 100, measuring promotional effectiveness.',
    `salesforce_tpm_event_code` STRING COMMENT 'The unique identifier from Salesforce Consumer Goods Cloud Trade Promotion Management system for this event record, used for system integration and data lineage.. Valid values are `^[a-zA-Z0-9]{15,18}$`',
    `settlement_date` DATE COMMENT 'The date when financial settlement for this promotional event was completed and all trade spend obligations were resolved.',
    `settlement_status` STRING COMMENT 'The current status of financial settlement for this promotional event. Pending: settlement not yet initiated; In Progress: settlement calculations underway; Settled: all financial obligations resolved; Disputed: settlement under dispute resolution.. Valid values are `pending|in_progress|settled|disputed`',
    `source_system_code` STRING COMMENT 'The source system code of the promotion event record',
    `start_date` DATE COMMENT 'The date when the promotional event begins execution at retail or distribution level.',
    `uom` STRING COMMENT 'The uom of the promotion event record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the promotion event record',
    CONSTRAINT pk_promotion_event PRIMARY KEY(`promotion_event_id`)
) COMMENT 'Represents a discrete promotional execution event tied to a trade promotion program. A single trade promotion may have multiple events across different retailers, geographies, or time windows. Captures event-level details: event type (feature ad, display, temporary price reduction, BOGO, scan-back), event start/end dates, retailer account, ship-to location, participating SKUs, planned vs. actual event status, and event-level trade spend allocation. Integrates with Salesforce TPM event records. [SSOT] Superseded by authoritative table marketing.marketing_event for concept event. SSOT: canonical table is marketing.marketing_event. [SSOT for concept event.]';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` (
    `event_sku_id` BIGINT COMMENT 'Unique identifier for the promotion event SKU association record. Primary key for this entity.',
    `channel_classification_id` BIGINT COMMENT 'Reference to the distribution channel (e.g., grocery, mass, club, DTC, e-commerce) where this promotional SKU is offered.',
    `employee_id` BIGINT COMMENT 'Name or identifier of the person who approved the promotional pricing for this SKU.',
    `promotion_event_id` BIGINT COMMENT 'Reference to the parent promotion event to which this SKU is associated.',
    `funding_agreement_id` BIGINT COMMENT 'Reference to the retailer funding agreement or trade contract governing the promotional terms for this SKU.',
    `sku_id` BIGINT COMMENT 'Reference to the product SKU participating in this promotion event.',
    `trade_account_id` BIGINT COMMENT 'Reference to the retailer or trade account for which this promotional SKU pricing applies.',
    `accrual_amount` DECIMAL(18,2) COMMENT 'Accrued trade spend liability for this promotional SKU. Represents the estimated financial obligation based on planned volume and discount.',
    `actual_promotional_volume_cases` DECIMAL(18,2) COMMENT 'Actual volume of cases sold during the promotion period for this SKU. Captured post-event from POS or shipment data.',
    `actual_promotional_volume_units` DECIMAL(18,2) COMMENT 'Actual volume of consumer units sold during the promotion period for this SKU. Used for promotional lift and ROI analysis.',
    `actual_volume_units` DECIMAL(18,2) COMMENT 'The actual volume units of the event sku record',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the event sku record',
    `baseline_volume_estimate_units` DECIMAL(18,2) COMMENT 'Estimated volume of units that would have been sold without the promotion. Used to calculate incremental lift. Typically derived from historical sales trends.',
    `event_sku_code` STRING COMMENT 'The event sku code of the event sku record',
    `compliance_check_status` STRING COMMENT 'Status of promotional pricing compliance verification for this SKU. Ensures promotional pricing was executed as agreed with the retailer.. Valid values are `Not Checked|Compliant|Non-Compliant|Under Review`',
    `compliance_verified_date` DATE COMMENT 'Date when promotional pricing compliance was verified for this SKU through retail execution audits or POS data validation.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this promotion event SKU record was first created in the system.',
    `currency_code` STRING COMMENT 'The currency code of the event sku record',
    `deduction_amount` DECIMAL(18,2) COMMENT 'Actual deduction amount claimed by the retailer for this promotional SKU. Used for trade spend reconciliation and settlement.',
    `event_sku_description` STRING COMMENT 'The event sku description of the event sku record',
    `discount_amount` DECIMAL(18,2) COMMENT 'The discount amount of the event sku record',
    `display_location_type` STRING COMMENT 'Type of in-store display location where this promotional SKU is merchandised. Impacts visibility and promotional lift. [ENUM-REF-CANDIDATE: Shelf|End Cap|Free Standing Display|Pallet|Cooler|Checkout|Secondary Placement — 7 candidates stripped; promote to reference product]',
    `display_type` STRING COMMENT 'The display type of the event sku record',
    `effective_from` DATE COMMENT 'The effective from of the event sku record',
    `effective_until` DATE COMMENT 'The effective until of the event sku record',
    `event_sku_status` STRING COMMENT 'The event sku status of the event sku record',
    `expected_units` DECIMAL(18,2) COMMENT 'The expected units of the event sku record',
    `feature_flag` BOOLEAN COMMENT 'The feature flag of the event sku record',
    `feature_type` STRING COMMENT 'Type of promotional feature or advertising support provided for this SKU during the promotion event. [ENUM-REF-CANDIDATE: Circular Ad|Digital Ad|In-Store Signage|Shelf Talker|Coupon|Loyalty Offer|None — 7 candidates stripped; promote to reference product]',
    `forecast_volume_units` DECIMAL(18,2) COMMENT 'The forecast volume units of the event sku record',
    `gtin` STRING COMMENT 'Global Trade Item Number uniquely identifying the product SKU in the promotion. Supports EAN-8, EAN-13, UPC-A, UPC-E, and GTIN-14 formats.. Valid values are `^[0-9]{8,14}$`',
    `incremental_lift_percent` DECIMAL(18,2) COMMENT 'Percentage lift in volume due to the promotion. Calculated as (incremental_lift_volume_units / baseline_volume_estimate_units) * 100.',
    `incremental_lift_volume_units` DECIMAL(18,2) COMMENT 'Incremental volume of units sold above baseline due to the promotion. Calculated as actual_promotional_volume_units - baseline_volume_estimate_units.',
    `is_featured_sku` BOOLEAN COMMENT 'Indicates whether this SKU is a featured hero product in the promotion event. Featured SKUs typically receive premium merchandising and advertising support.',
    `modified_by` STRING COMMENT 'Name or identifier of the user who last modified this promotion event SKU record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this promotion event SKU record was last modified.',
    `event_sku_name` STRING COMMENT 'The event sku name of the event sku record',
    `notes` STRING COMMENT 'Free-form text field for additional notes, comments, or special instructions related to this promotional SKU.',
    `planned_promotional_volume_cases` DECIMAL(18,2) COMMENT 'Forecasted volume of cases expected to be sold during the promotion period for this SKU. Used for trade spend budgeting and supply planning.',
    `planned_promotional_volume_units` DECIMAL(18,2) COMMENT 'Forecasted volume of consumer units expected to be sold during the promotion period for this SKU.',
    `price_reduction_depth_percent` DECIMAL(18,2) COMMENT 'Percentage discount from regular shelf price to promoted price. Calculated as ((regular_shelf_price - promoted_price) / regular_shelf_price) * 100.',
    `pricing_approval_status` STRING COMMENT 'Current approval status of the promotional pricing for this SKU. Tracks the workflow state from draft through execution to completion. [ENUM-REF-CANDIDATE: Draft|Pending Approval|Approved|Rejected|Active|Completed|Cancelled — 7 candidates stripped; promote to reference product]',
    `pricing_approved_timestamp` TIMESTAMP COMMENT 'Date and time when the promotional pricing for this SKU was approved.',
    `promoted_price` DECIMAL(18,2) COMMENT 'The temporary promotional price offered to consumers during the promotion event. Expressed in the base currency of the business.',
    `promoted_price_type` STRING COMMENT 'Type of promotional pricing mechanism applied to this SKU. Hi-Lo: temporary price reduction; EDLP: everyday low price; Multi-Buy: quantity discount; BOGO: buy-one-get-one; Scan-Back: retailer scanned rebate; Off-Invoice: deduction at invoice; Bill-Back: post-event settlement. [ENUM-REF-CANDIDATE: Hi-Lo|EDLP|Multi-Buy|BOGO|Scan-Back|Off-Invoice|Bill-Back — 7 candidates stripped; promote to reference product]',
    `promotion_effective_end_date` DATE COMMENT 'The date when the promotional pricing for this SKU expires and regular pricing resumes.',
    `promotion_effective_start_date` DATE COMMENT 'The date when the promotional pricing for this SKU becomes effective at retail.',
    `promotional_discount_per_unit` DECIMAL(18,2) COMMENT 'Absolute discount amount per unit (regular_shelf_price - promoted_price). Represents the per-unit trade spend investment.',
    `promotional_gmroi` DECIMAL(18,2) COMMENT 'Gross margin return on investment for this promotional SKU. Calculated as incremental_gross_margin / total_trade_spend_amount.',
    `promotional_roi_percent` DECIMAL(18,2) COMMENT 'Return on investment for this promotional SKU. Calculated as (incremental_gross_profit - total_trade_spend_amount) / total_trade_spend_amount * 100.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the event sku record',
    `rebate_amount` DECIMAL(18,2) COMMENT 'Rebate amount paid to the retailer for this promotional SKU. Typically settled post-event based on actual sales performance.',
    `regular_price` DECIMAL(18,2) COMMENT 'The regular price of the event sku record',
    `regular_shelf_price` DECIMAL(18,2) COMMENT 'The standard everyday shelf price (RSP/MSRP) for this SKU before promotional discount. Used to calculate price reduction depth.',
    `settlement_date` DATE COMMENT 'Date when the financial settlement for this promotional SKU was completed with the retailer.',
    `settlement_status` STRING COMMENT 'Current status of the financial settlement process for this promotional SKU with the retailer.. Valid values are `Not Started|In Progress|Reconciled|Settled|Disputed`',
    `source_system_code` STRING COMMENT 'The source system code of the event sku record',
    `total_trade_spend_amount` DECIMAL(18,2) COMMENT 'Total trade spend investment for this SKU in this promotion event. Calculated as promotional_discount_per_unit * actual_promotional_volume_units.',
    `uom` STRING COMMENT 'The uom of the event sku record',
    `upc` STRING COMMENT 'Universal Product Code for the SKU participating in the promotion event. Standard 12-digit UPC-A format.. Valid values are `^[0-9]{12}$`',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the event sku record',
    CONSTRAINT pk_event_sku PRIMARY KEY(`event_sku_id`)
) COMMENT 'Association entity linking individual SKUs (GTINs/UPCs) to a specific promotion event with full promotional pricing authority. Captures SKU-level promotional details including promoted price, promoted price type (Hi-Lo temporary price reduction, EDLP, multi-buy, BOGO, scan-back, off-invoice, bill-back), price reduction depth (%), regular shelf price (RSP/MSRP), effective date range, planned promotional volume (cases/units), actual promotional volume, baseline volume estimate, incremental lift volume, promotional discount amount per unit, retailer account, channel, and pricing approval status. Serves as the SSOT for SKU-level promotional pricing within trade events — distinct from standard list pricing owned by the product domain. Enables SKU-level trade spend, lift analysis, and promotional price compliance per event.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` (
    `trade_calendar_id` BIGINT COMMENT 'Primary key for trade_calendar',
    `category_id` BIGINT COMMENT 'Identifier of the product category this promotional calendar covers. Links to the product category entity.',
    `channel_classification_id` BIGINT COMMENT 'Identifier of the sales or distribution channel this promotional calendar applies to (e.g., retail, wholesale, e-commerce). Links to the channel classification entity.',
    `marketing_brand_id` BIGINT COMMENT 'Identifier of the brand this promotional calendar is associated with. Links to the brand master entity.',
    `parent_calendar_trade_calendar_id` BIGINT COMMENT 'Identifier of the parent promotional calendar if this is a sub-calendar or regional variant. Links to another promotional calendar entity.',
    `employee_id` BIGINT COMMENT 'Identifier of the brand manager, category manager, or trade marketing manager who owns and is accountable for this promotional calendar. Links to the employee entity.',
    `tertiary_trade_created_by_employee_id` BIGINT COMMENT 'Identifier of the user or system that created this promotional calendar record. Links to the employee or system user entity.',
    `trade_account_id` BIGINT COMMENT 'Identifier of the retailer or trade account this promotional calendar is scoped to. Links to the trade account entity.',
    `actual_event_count` STRING COMMENT 'The actual number of promotional events executed or in-flight within this calendar period.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the trade calendar record',
    `approval_date` DATE COMMENT 'The date when this promotional calendar was formally approved by management or finance.',
    `calendar_code` STRING COMMENT 'Short alphanumeric code for the promotional calendar used in reporting and system integration (e.g., FY24Q1-RET, CAL-2024-BRX).',
    `calendar_name` STRING COMMENT 'Business name of the promotional calendar (e.g., FY2024 Q1 Retail Promo Calendar, Annual Brand X Trade Plan).',
    `calendar_status` STRING COMMENT 'Current lifecycle status of the promotional calendar (draft, submitted, approved, locked, active, closed).. Valid values are `draft|submitted|approved|locked|active|closed`',
    `calendar_year` STRING COMMENT 'The calendar year of the trade calendar record',
    `closed_date` DATE COMMENT 'The date when this promotional calendar was closed after all events completed and post-event analysis was finalized.',
    `trade_calendar_code` STRING COMMENT 'The trade calendar code of the trade calendar record',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code where this promotional calendar is executed (e.g., USA, GBR, DEU).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this promotional calendar record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the planned trade spend (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `trade_calendar_description` STRING COMMENT 'Detailed business description or purpose of this promotional calendar, including strategic objectives and key initiatives.',
    `effective_end_date` DATE COMMENT 'The date when this promotional calendar ends and no further promotional events are planned under this calendar.',
    `effective_from` DATE COMMENT 'The effective from of the trade calendar record',
    `effective_start_date` DATE COMMENT 'The date when this promotional calendar becomes effective and promotional events can begin execution.',
    `effective_until` DATE COMMENT 'The effective until of the trade calendar record',
    `event_window_type` STRING COMMENT 'The event window type of the trade calendar record',
    `fiscal_year` STRING COMMENT 'The fiscal year this promotional calendar covers (e.g., 2024, 2025).',
    `is_baseline_calendar` BOOLEAN COMMENT 'Flag indicating whether this is the baseline or master promotional calendar for the fiscal year (true) or a variant/supplemental calendar (false).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this promotional calendar record was last updated or modified.',
    `locked_date` DATE COMMENT 'The date when this promotional calendar was locked to prevent further changes, typically after approval and before execution.',
    `trade_calendar_name` STRING COMMENT 'The trade calendar name of the trade calendar record',
    `notes` STRING COMMENT 'Additional notes, comments, or special instructions related to this promotional calendar for internal reference.',
    `period_end` DATE COMMENT 'The period end of the trade calendar record',
    `period_end_date` DATE COMMENT 'The period end date of the trade calendar record',
    `period_name` STRING COMMENT 'The period name of the trade calendar record',
    `period_start` DATE COMMENT 'The period start of the trade calendar record',
    `period_start_date` DATE COMMENT 'The period start date of the trade calendar record',
    `planned_event_count` STRING COMMENT 'The total number of promotional events planned within this calendar period.',
    `planning_cycle` STRING COMMENT 'The planning frequency or cycle for this promotional calendar (annual, semi-annual, quarterly, monthly).. Valid values are `annual|semi-annual|quarterly|monthly`',
    `pricing_strategy` STRING COMMENT 'The primary pricing strategy employed in this promotional calendar: Hi-Lo (High-Low Pricing Strategy), EDLP (Everyday Low Price), hybrid, promotional, or premium.. Valid values are `hi-lo|edlp|hybrid|promotional|premium`',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the trade calendar record',
    `region_code` STRING COMMENT 'Geographic region or market code this promotional calendar applies to (e.g., NA-EAST, EU-WEST, APAC).',
    `season` STRING COMMENT 'The season of the trade calendar record',
    `source_system_code` STRING COMMENT 'The source system code of the trade calendar record',
    `total_planned_trade_spend` DECIMAL(18,2) COMMENT 'The total budgeted trade spend envelope allocated for all promotional events within this calendar, in the base currency.',
    `tpm_system_code` STRING COMMENT 'External system identifier from the Trade Promotion Management (TPM) or Trade Promotion Optimization (TPO) system (e.g., Salesforce TPM, TradeEdge).',
    `trade_calendar_status` STRING COMMENT 'The trade calendar status of the trade calendar record',
    `uom` STRING COMMENT 'The uom of the trade calendar record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the trade calendar record',
    `version_number` STRING COMMENT 'Version number of this promotional calendar, incremented with each major revision or replan cycle.',
    CONSTRAINT pk_trade_calendar PRIMARY KEY(`trade_calendar_id`)
) COMMENT 'Master entity representing the annual or periodic trade promotional calendar for a brand, category, or retailer account. Captures calendar name, fiscal year, planning cycle, owning brand/category manager, retailer account scope, calendar status (draft, approved, locked), total planned trade spend envelope, and number of planned promotion events. Serves as the planning container for all trade promotion events within a given period and account relationship.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` (
    `trade_spend_allocation_id` BIGINT COMMENT 'Unique identifier for the trade spend allocation record. Primary key for this transactional entity capturing budget allocation to promotion events.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Needed to allocate trade spend per marketing campaign, supporting budgeting, spend efficiency tracking, and campaign‑level spend reconciliation.',
    `cost_center_id` BIGINT COMMENT 'The cost center id of the trade spend allocation record',
    `employee_id` BIGINT COMMENT 'Reference to the user who approved this trade spend allocation. Provides audit trail for governance and compliance.',
    `funding_agreement_id` BIGINT COMMENT 'The funding agreement id of the trade spend allocation record',
    `marketing_brand_id` BIGINT COMMENT 'Reference to the brand for which trade spend is allocated. Enables brand-level spend tracking and ROI analysis.',
    `promotion_event_id` BIGINT COMMENT 'Reference to the specific promotion event or campaign to which this trade spend is allocated. Links to the promotion master record in TPM system.',
    `sku_group_id` BIGINT COMMENT 'Reference to the SKU group or product category included in this trade spend allocation. May be null if allocation is at brand level only.',
    `trade_account_id` BIGINT COMMENT 'Reference to the retailer or distributor account receiving the trade spend funding. Identifies the counterparty in the promotional agreement.',
    `trade_promotion_id` BIGINT COMMENT 'The trade promotion id of the trade spend allocation record',
    `accrual_amount` DECIMAL(18,2) COMMENT 'The amount accrued for this trade spend allocation in the financial period. Used for matching expenses to the period in which the promotional activity occurs, per accrual accounting principles.',
    `actual_amount` DECIMAL(18,2) COMMENT 'The actual amount of trade spend executed or paid out. Populated post-event for variance analysis and reconciliation with accounts payable.',
    `actual_volume` DECIMAL(18,2) COMMENT 'The actual sales volume achieved during the promotion period. Populated post-event from POS or shipment data for lift analysis and ROI calculation.',
    `allocated_amount` DECIMAL(18,2) COMMENT 'The monetary amount of trade spend allocated to this promotion event, account, brand, or SKU group. Represents the planned or budgeted spend.',
    `allocation_date` DATE COMMENT 'The business date when the trade spend allocation was created or committed. Principal business event timestamp for this transaction.',
    `allocation_number` STRING COMMENT 'Business-readable unique identifier for the trade spend allocation. Used for external communication, audit trails, and reconciliation with finance systems.. Valid values are `^TSA-[0-9]{8}-[A-Z0-9]{6}$`',
    `allocation_period` STRING COMMENT 'The allocation period of the trade spend allocation record',
    `allocation_status` STRING COMMENT 'Current lifecycle status of the trade spend allocation. Tracks progression from planning through approval, execution, and final settlement with retailer. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|committed|executed|settled|cancelled|rejected — 8 candidates stripped; promote to reference product]',
    `allocation_type` STRING COMMENT 'The allocation type of the trade spend allocation record',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the trade spend allocation record',
    `approval_date` DATE COMMENT 'The date when this trade spend allocation was formally approved by the authorized approver. Marks transition from draft to committed status.',
    `baseline_volume` DECIMAL(18,2) COMMENT 'The expected sales volume without promotional activity, used as the baseline for measuring promotional lift. Expressed in units or cases.',
    `trade_spend_allocation_code` STRING COMMENT 'The trade spend allocation code of the trade spend allocation record',
    `committed_amount` DECIMAL(18,2) COMMENT 'The amount of trade spend formally committed after approval. May differ from allocated amount due to negotiation or budget adjustments.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this trade spend allocation record was first created in the system. Audit field for data lineage and compliance.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this allocation record. Supports multi-currency trade spend management for global operations.. Valid values are `^[A-Z]{3}$`',
    `deduction_amount` DECIMAL(18,2) COMMENT 'The amount deducted by the retailer from invoice payments as part of this trade spend allocation. Tracks retailer-initiated deductions for reconciliation and dispute resolution.',
    `trade_spend_allocation_description` STRING COMMENT 'The trade spend allocation description of the trade spend allocation record',
    `effective_from` DATE COMMENT 'The effective from of the trade spend allocation record',
    `effective_until` DATE COMMENT 'The effective until of the trade spend allocation record',
    `fiscal_period` STRING COMMENT 'The fiscal period (month or quarter) within the fiscal year to which this allocation is assigned. Used for period-level spend tracking and variance analysis.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this trade spend allocation is assigned for budgeting and financial reporting purposes.',
    `fund_type` STRING COMMENT 'The fund type of the trade spend allocation record',
    `gl_account_code` STRING COMMENT 'The general ledger account code to which this trade spend allocation is posted. Maps trade spend to the appropriate expense or COGS account for financial reporting.. Valid values are `^[0-9]{6,10}$`',
    `gmroi_percentage` DECIMAL(18,2) COMMENT 'The gross margin return on investment for this trade spend allocation. Measures gross margin dollars generated per dollar of trade spend invested.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether this trade spend allocation is currently active. False indicates the allocation has been cancelled or superseded.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this trade spend allocation record was last modified. Audit field for change tracking and data governance.',
    `trade_spend_allocation_name` STRING COMMENT 'The trade spend allocation name of the trade spend allocation record',
    `notes` STRING COMMENT 'Free-text notes or comments regarding this trade spend allocation. Captures special conditions, negotiation details, or post-event observations.',
    `pricing_strategy` STRING COMMENT 'The pricing strategy employed for this trade spend allocation. Distinguishes between Hi-Lo promotional pricing, Everyday Low Price (EDLP), and other strategic approaches.. Valid values are `hi_lo|edlp|hybrid|premium|penetration|competitive`',
    `profit_center_code` STRING COMMENT 'The profit center to which this trade spend is attributed for profitability analysis. Supports P&L reporting by business unit or product line.. Valid values are `^PC[0-9]{6}$`',
    `promotion_end_date` DATE COMMENT 'The end date of the promotion event to which this spend is allocated. Defines the promotional activity window for ROI measurement and post-event analysis.',
    `promotion_start_date` DATE COMMENT 'The start date of the promotion event to which this spend is allocated. Used for temporal analysis and matching spend to promotional activity periods.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the trade spend allocation record',
    `roi_percentage` DECIMAL(18,2) COMMENT 'The calculated return on investment for this trade spend allocation, expressed as a percentage. Measures incremental profit generated per dollar of trade spend.',
    `settlement_amount` DECIMAL(18,2) COMMENT 'The final settled amount paid to the retailer after reconciliation of accruals, deductions, and actual performance. Represents the true cost of the promotion.',
    `settlement_date` DATE COMMENT 'The date when final settlement with the retailer was completed. Marks closure of the allocation lifecycle and reconciliation with accounts payable.',
    `source_system_code` STRING COMMENT 'The source system code of the trade spend allocation record',
    `spend_category` STRING COMMENT 'High-level classification of trade spend for strategic analysis and reporting. Groups spend types into broader business categories for executive dashboards.. Valid values are `price_discount|merchandising|marketing|listing|performance_incentive|other`',
    `spend_type` STRING COMMENT 'Classification of the trade spend mechanism. [ENUM-REF-CANDIDATE: off_invoice_discount|scan_back|bill_back|lump_sum|coop_advertising|slotting_fee|display_allowance|free_goods|volume_rebate|growth_incentive — promote to reference product]. Valid values are `off_invoice_discount|scan_back|bill_back|lump_sum|coop_advertising|slotting_fee`',
    `spent_amount` DECIMAL(18,2) COMMENT 'The spent amount of the trade spend allocation record',
    `target_volume` DECIMAL(18,2) COMMENT 'The target sales volume expected with this trade spend allocation. Used for performance measurement and ROI calculation.',
    `trade_spend_allocation_status` STRING COMMENT 'The trade spend allocation status of the trade spend allocation record',
    `uom` STRING COMMENT 'The uom of the trade spend allocation record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the trade spend allocation record',
    `variance_amount` DECIMAL(18,2) COMMENT 'The difference between committed and actual spend amounts. Positive variance indicates under-spend; negative indicates over-spend. Used for budget control and post-event analysis.',
    `volume_uom` STRING COMMENT 'The unit of measure for baseline, target, and actual volume fields. Ensures consistent interpretation of volume metrics across different product categories.. Valid values are `units|cases|pallets|kg|liters`',
    CONSTRAINT pk_trade_spend_allocation PRIMARY KEY(`trade_spend_allocation_id`)
) COMMENT 'Transactional record capturing the allocation of trade spend budget to a specific promotion event, retailer account, brand, or SKU group. Tracks allocated amount, spend type (off-invoice discount, scan-back, bill-back, lump sum, co-op advertising, slotting fee, display allowance, free goods), spend category classification, GL account mapping, fiscal period, cost center, approval status, and variance between planned and committed spend. Feeds into COGS and trade spend reporting for S&OP and finance reconciliation.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` (
    `funding_agreement_id` BIGINT COMMENT 'Unique identifier for the funding agreement record. Primary key.',
    `previous_agreement_funding_agreement_id` BIGINT COMMENT 'Reference to the prior funding agreement that this agreement renews or replaces, if applicable.',
    `trade_account_id` BIGINT COMMENT 'Reference to the retail trade account (customer) that is party to this funding agreement.',
    `accrual_method` STRING COMMENT 'Method used to accrue trade spend liability over the agreement period: straight-line (evenly over time), event-based (per promotional event), scan-based (per unit sold), or milestone-based (upon achievement of targets).. Valid values are `straight_line|event_based|scan_based|milestone_based`',
    `accrual_rate_pct` DECIMAL(18,2) COMMENT 'The accrual rate pct of the funding agreement record',
    `accrued_to_date_amount` DECIMAL(18,2) COMMENT 'Cumulative amount of trade spend accrued under this agreement as of the current date, based on the accrual method.',
    `agreement_name` STRING COMMENT 'Human-readable name or title of the funding agreement, often including retailer name and fiscal year.',
    `agreement_number` STRING COMMENT 'Externally-known unique business identifier for the funding agreement, typically formatted as prefix-numeric sequence.. Valid values are `^[A-Z]{3}-[0-9]{6,10}$`',
    `agreement_status` STRING COMMENT 'Current lifecycle status of the funding agreement: draft (being prepared), pending approval (submitted for review), approved (signed but not yet active), active (in effect), suspended (temporarily paused), terminated (ended early), or expired (reached end date). [ENUM-REF-CANDIDATE: draft|pending_approval|approved|active|suspended|terminated|expired — 7 candidates stripped; promote to reference product]',
    `agreement_type` STRING COMMENT 'Classification of the funding agreement structure: annual lump sum (fixed payment), scan-back (per-unit sold), co-op (shared marketing), slotting (shelf placement fee), performance-based (conditional on metrics), or volume rebate (tiered discount).. Valid values are `annual_lump_sum|scan_back|co_op|slotting|performance_based|volume_rebate`',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the funding agreement record',
    `approval_status` STRING COMMENT 'Current approval workflow status: not submitted (draft), pending review (awaiting decision), approved (authorized), rejected (denied), or revision required (needs changes before resubmission).. Valid values are `not_submitted|pending_review|approved|rejected|revision_required`',
    `approved_by` STRING COMMENT 'Name or identifier of the individual who approved the funding agreement (typically a sales director, finance manager, or VP of trade marketing).',
    `approved_date` DATE COMMENT 'Date when the funding agreement was formally approved by the authorized signatory.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether this agreement automatically renews at the end of the funding period (true) or requires explicit renewal (false).',
    `funding_agreement_code` STRING COMMENT 'The funding agreement code of the funding agreement record',
    `contract_document_url` STRING COMMENT 'URL or file path to the signed contract document stored in the document management system (e.g., Salesforce Files, SharePoint, Veeva Vault).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the funding agreement record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this agreement (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `deduction_settlement_terms` STRING COMMENT 'Terms and conditions governing how retailer deductions are validated, matched, and settled against this funding agreement (e.g., backup documentation requirements, dispute resolution process, settlement timeline).',
    `funding_agreement_description` STRING COMMENT 'The funding agreement description of the funding agreement record',
    `effective_date` DATE COMMENT 'The effective date of the funding agreement record',
    `effective_from` DATE COMMENT 'The effective from of the funding agreement record',
    `effective_until` DATE COMMENT 'The effective until of the funding agreement record',
    `end_date` DATE COMMENT 'The end date of the funding agreement record',
    `expiry_date` DATE COMMENT 'The expiry date of the funding agreement record',
    `fund_type` STRING COMMENT 'The fund type of the funding agreement record',
    `funding_agreement_status` STRING COMMENT 'The funding agreement status of the funding agreement record',
    `funding_amount` DECIMAL(18,2) COMMENT 'The funding amount of the funding agreement record',
    `funding_period_end_date` DATE COMMENT 'The date when the funding agreement expires and the funding period ends. Nullable for open-ended agreements.',
    `funding_period_start_date` DATE COMMENT 'The date when the funding agreement becomes effective and the funding period begins.',
    `funding_type` STRING COMMENT 'The funding type of the funding agreement record',
    `gmroi_target` DECIMAL(18,2) COMMENT 'Target gross margin return on investment for this funding agreement, measuring gross profit generated per dollar of trade spend invested.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the funding agreement record was most recently updated.',
    `manufacturer_signatory_name` STRING COMMENT 'Full name of the manufacturer representative who signed the funding agreement on behalf of the CPG company.',
    `manufacturer_signatory_title` STRING COMMENT 'Job title or role of the manufacturer signatory (e.g., VP of Sales, Director of Trade Marketing, Key Account Manager).',
    `manufacturer_signature_date` DATE COMMENT 'Date when the manufacturer signatory signed the funding agreement.',
    `funding_agreement_name` STRING COMMENT 'The funding agreement name of the funding agreement record',
    `notes` STRING COMMENT 'Free-form text field for additional notes, comments, or special conditions related to the funding agreement.',
    `paid_to_date_amount` DECIMAL(18,2) COMMENT 'Cumulative amount of funding actually paid out to the retailer under this agreement as of the current date.',
    `payment_frequency` STRING COMMENT 'Frequency at which payments are made under this agreement: one-time (lump sum), monthly, quarterly, semi-annual, annual, or event-based (triggered by specific promotional events).. Valid values are `one_time|monthly|quarterly|semi_annual|annual|event_based`',
    `payment_terms` STRING COMMENT 'Detailed description of payment terms, including timing, method, and conditions for fund disbursement (e.g., quarterly installments, post-event settlement, net 30 days).',
    `performance_conditions` STRING COMMENT 'Detailed description of performance metrics, targets, or conditions that must be met for funding to be released or for rebates to be earned (e.g., minimum sales volume, market share targets, display compliance).',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the funding agreement record',
    `remaining_balance_amount` DECIMAL(18,2) COMMENT 'Remaining uncommitted or unpaid funding balance available under this agreement (total committed minus paid to date).',
    `renewal_flag` BOOLEAN COMMENT 'Indicates whether this funding agreement is a renewal of a previous agreement (true) or a new agreement (false).',
    `retailer_signatory_name` STRING COMMENT 'Full name of the retailer representative who signed the funding agreement on behalf of the retail account.',
    `retailer_signatory_title` STRING COMMENT 'Job title or role of the retailer signatory (e.g., Category Manager, Buyer, VP of Merchandising).',
    `retailer_signature_date` DATE COMMENT 'Date when the retailer signatory signed the funding agreement.',
    `roi_target_percentage` DECIMAL(18,2) COMMENT 'Target return on investment percentage for this funding agreement, used to measure promotional effectiveness and justify trade spend allocation.',
    `source_system_code` STRING COMMENT 'The source system code of the funding agreement record',
    `start_date` DATE COMMENT 'The start date of the funding agreement record',
    `termination_date` DATE COMMENT 'Actual date when the agreement was terminated early, if applicable. Null if the agreement was not terminated.',
    `termination_notice_days` STRING COMMENT 'Number of days advance notice required by either party to terminate the agreement prior to the end date.',
    `termination_reason` STRING COMMENT 'Explanation or reason code for early termination of the agreement (e.g., breach of contract, mutual agreement, business restructuring, poor performance).',
    `total_committed_amount` DECIMAL(18,2) COMMENT 'Total funding amount committed by the manufacturer to the retailer under this agreement, in the agreement currency.',
    `total_fund_amount` DECIMAL(18,2) COMMENT 'The total fund amount of the funding agreement record',
    `uom` STRING COMMENT 'The uom of the funding agreement record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the funding agreement record',
    CONSTRAINT pk_funding_agreement PRIMARY KEY(`funding_agreement_id`)
) COMMENT 'Master entity representing a formal retailer funding agreement (RFA) or joint business plan (JBP) between the CPG manufacturer and a retail account. Captures agreement name, retailer account, agreement type (annual lump sum, scan-back, co-op, slotting, performance-based), total committed funding amount, funding period, payment terms, performance conditions, approval status, and signatory details. Serves as the contractual basis for trade spend commitments and deduction settlements.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_accrual` (
    `promotion_accrual_id` BIGINT COMMENT 'Unique identifier for the promotion accrual record. Primary key.',
    `employee_id` BIGINT COMMENT 'Name or identifier of the user who approved the accrual. Nullable for unapproved accruals.',
    `finance_accrual_id` BIGINT COMMENT 'FK to authoritative SSOT table finance.finance_accrual (cross-domain duplicate resolution).',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Accrual posting needs a GL account reference; replaces denormalized gl_account_code for proper ledger integration.',
    `promotion_event_id` BIGINT COMMENT 'Reference to the associated trade promotion event for which this accrual is recognized.',
    `sku_id` BIGINT COMMENT 'Reference to the specific product SKU included in the promotional accrual. Nullable for lump-sum accruals not tied to specific SKUs.',
    `trade_account_id` BIGINT COMMENT 'Reference to the retailer or customer account receiving the promotional funding.',
    `trade_promotion_id` BIGINT COMMENT 'The trade promotion id of the promotion accrual record',
    `accrual_amount` DECIMAL(18,2) COMMENT 'The accrual amount of the promotion accrual record',
    `accrual_date` DATE COMMENT 'The accrual date of the promotion accrual record',
    `accrual_rate` DECIMAL(18,2) COMMENT 'The accrual rate of the promotion accrual record',
    `accrual_status` STRING COMMENT 'The accrual status of the promotion accrual record',
    `accrual_type` STRING COMMENT 'The accrual type of the promotion accrual record',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the promotion accrual record',
    `promotion_accrual_code` STRING COMMENT 'The promotion accrual code of the promotion accrual record',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the promotion accrual record',
    `currency_code` STRING COMMENT 'The currency code of the promotion accrual record',
    `promotion_accrual_description` STRING COMMENT 'The promotion accrual description of the promotion accrual record',
    `effective_from` DATE COMMENT 'The effective from of the promotion accrual record',
    `effective_until` DATE COMMENT 'The effective until of the promotion accrual record',
    `promotion_accrual_name` STRING COMMENT 'The promotion accrual name of the promotion accrual record',
    `notes` STRING COMMENT 'The notes of the promotion accrual record',
    `promotion_accrual_status` STRING COMMENT 'The promotion accrual status of the promotion accrual record',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the promotion accrual record',
    `reversal_flag` BOOLEAN COMMENT 'The reversal flag of the promotion accrual record',
    `source_system_code` STRING COMMENT 'The source system code of the promotion accrual record',
    `uom` STRING COMMENT 'The uom of the promotion accrual record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the promotion accrual record',
    CONSTRAINT pk_promotion_accrual PRIMARY KEY(`promotion_accrual_id`)
) COMMENT 'Transactional record capturing trade promotion accruals — the financial liability recognized for promotional spend commitments not yet paid. Tracks accrual type (scan-back, bill-back, off-invoice, lump sum), accrual amount, accrual period, associated promotion event, retailer account, SKU, accrual status (open, reversed, settled), GL account, and SAP FI/CO posting reference. Critical for accurate COGS and P&L reporting under trade promotion accounting standards. [SSOT: authoritative table is finance.finance_accrual; this table is a deprecated duplicate.] [SSOT] Superseded by authoritative table finance.finance_accrual for concept accrual. SSOT: canonical table is finance.finance_accrual. [SSOT: authoritative table is finance.finance_accrual; this is a deprecated duplicate for concept accrual.] [Non-authoritative; defers to SSOT finance.finance_accrual for concept accrual.]';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_deduction` (
    `promotion_deduction_id` BIGINT COMMENT 'Unique identifier for the promotion deduction record. Primary key for the promotion deduction entity representing the complete lifecycle from initial short-payment through final settlement.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Links each deduction to the cost center responsible for the expense, required for cost allocation and reporting.',
    `funding_agreement_id` BIGINT COMMENT 'Identifier of the trade promotion funding agreement under which this deduction was claimed. Links to the funding agreement master.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Deduction entries must be posted to a specific GL account; removes redundant gl_account_code column.',
    `invoice_id` BIGINT COMMENT 'Identifier of the invoice against which the deduction was taken. Links to the originating invoice record.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee or user who approved the deduction settlement. Links to the workforce employee master.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Provides profit‑center level visibility of deduction impact, supporting profit analysis and KPI tracking.',
    `promotion_event_id` BIGINT COMMENT 'Identifier of the originating promotion event that triggered this deduction. Links to the promotion event master.',
    `tertiary_promotion_modified_by_user_employee_id` BIGINT COMMENT 'Identifier of the user who last modified this deduction record. Links to the workforce employee master for audit purposes.',
    `trade_account_id` BIGINT COMMENT 'Identifier of the retailer or trade account that initiated the deduction. Links to the customer trade account master.',
    `trade_promotion_id` BIGINT COMMENT 'The trade promotion id of the promotion deduction record',
    `sales_deduction_id` BIGINT COMMENT 'FK to SSOT owner sales.sales_deduction.sales_deduction_id (cross-domain duplicate entity deduction references the designated SSOT).',
    `accrual_impact_flag` BOOLEAN COMMENT 'Boolean indicator of whether this deduction impacts trade promotion accruals. True indicates the deduction should be reconciled against accrued trade spend, false indicates it is outside accrual scope.',
    `aging_days` STRING COMMENT 'Number of days the deduction has been open since the deduction date. Used for aging analysis and prioritization of dispute resolution activities.',
    `amount` DECIMAL(18,2) COMMENT 'Total monetary amount deducted by the retailer from the invoice payment. Represents the initial claim amount before dispute resolution.',
    `approval_date` DATE COMMENT 'Date on which the deduction settlement was approved by the authorized approver. Represents the decision point in the workflow.',
    `approved_amount` DECIMAL(18,2) COMMENT 'Monetary amount of the deduction that was approved and accepted by the manufacturer after dispute resolution. May be less than, equal to, or zero relative to the original deduction amount.',
    `business_unit_code` STRING COMMENT 'Business unit or division code responsible for managing this deduction. Used for organizational reporting and accountability.',
    `claim_reference_number` STRING COMMENT 'External reference number provided by the retailer for their deduction claim. Used for cross-referencing with retailer systems and documentation.',
    `promotion_deduction_code` STRING COMMENT 'The promotion deduction code of the promotion deduction record',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this deduction record was first created in the system. Represents the audit trail creation point.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the deduction amount. Indicates the currency in which the deduction was taken.. Valid values are `^[A-Z]{3}$`',
    `deduction_amount` DECIMAL(18,2) COMMENT 'The deduction amount of the promotion deduction record',
    `deduction_date` DATE COMMENT 'Date on which the retailer took the deduction from the invoice payment. Represents the business event timestamp for the deduction.',
    `deduction_number` STRING COMMENT 'Business-facing unique deduction number assigned by the retailer or internal system. Used for external communication and dispute tracking.',
    `deduction_reason` STRING COMMENT 'The deduction reason of the promotion deduction record',
    `deduction_reason_code` STRING COMMENT 'The deduction reason code of the promotion deduction record',
    `deduction_source` STRING COMMENT 'Source system or channel through which the deduction was received. Retailer portal indicates web-based submission, EDI 846 indicates electronic data interchange, manual entry indicates internal creation, bank reconciliation indicates discovery during payment matching, and automated matching indicates system-generated from remittance data.. Valid values are `retailer_portal|edi_846|manual_entry|bank_reconciliation|automated_matching`',
    `deduction_status` STRING COMMENT 'The deduction status of the promotion deduction record',
    `deduction_type` STRING COMMENT 'Classification of the deduction based on the reason for the short-payment. Promotional deductions relate to trade promotions, pricing deductions to price discrepancies, shortage to quantity issues, compliance to retailer policy violations, quality to product defects, freight to shipping issues, and administrative to processing errors. [ENUM-REF-CANDIDATE: promotional|pricing|shortage|compliance|quality|freight|administrative — 7 candidates stripped; promote to reference product]',
    `promotion_deduction_description` STRING COMMENT 'The promotion deduction description of the promotion deduction record',
    `dispute_reason` STRING COMMENT 'Detailed textual explanation of why the manufacturer disputed all or part of the deduction. Provides context for dispute resolution and audit trail.',
    `dispute_status` STRING COMMENT 'Current lifecycle status of the deduction in the dispute resolution workflow. Open indicates initial receipt, approved indicates full acceptance, disputed indicates challenge by manufacturer, partially_approved indicates partial acceptance, written_off indicates unrecoverable amount, and pending_review indicates under investigation.. Valid values are `open|approved|disputed|partially_approved|written_off|pending_review`',
    `disputed_amount` DECIMAL(18,2) COMMENT 'Monetary amount of the deduction that is currently under dispute or was rejected by the manufacturer. Represents the portion of the deduction not accepted.',
    `effective_from` DATE COMMENT 'The effective from of the promotion deduction record',
    `effective_until` DATE COMMENT 'The effective until of the promotion deduction record',
    `gmroi_impact_percentage` DECIMAL(18,2) COMMENT 'Percentage impact of this deduction on the gross margin return on investment for the associated promotion. Used for profitability analysis and promotional effectiveness measurement.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this deduction record was last modified. Used for audit trail and change tracking.',
    `promotion_deduction_name` STRING COMMENT 'The promotion deduction name of the promotion deduction record',
    `notes` STRING COMMENT 'The notes of the promotion deduction record',
    `priority_level` STRING COMMENT 'Priority classification for dispute resolution based on deduction amount, retailer relationship, and aging. Critical indicates immediate attention required, high indicates urgent resolution needed, medium indicates standard processing, and low indicates routine handling.. Valid values are `critical|high|medium|low`',
    `product_category_code` STRING COMMENT 'Product category or brand code associated with the deduction. Used for category-level trade spend analysis and promotional effectiveness measurement.',
    `promotion_deduction_status` STRING COMMENT 'The promotion deduction status of the promotion deduction record',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the promotion deduction record',
    `resolution_notes` STRING COMMENT 'Free-text notes documenting the resolution process, communications with the retailer, and final settlement rationale. Provides audit trail and knowledge base for future similar deductions.',
    `retailer_claim_date` DATE COMMENT 'Date on which the retailer filed the deduction claim in their system. May differ from the deduction date.',
    `retailer_contact_email` STRING COMMENT 'Email address of the retailer contact person for this deduction. Used for electronic communication during dispute resolution.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `retailer_contact_name` STRING COMMENT 'Name of the retailer contact person responsible for this deduction claim. Used for communication and relationship management during dispute resolution.',
    `roi_impact_amount` DECIMAL(18,2) COMMENT 'Calculated impact of this deduction on the promotional return on investment. Represents the reduction in promotional effectiveness due to the deduction. Used for post-event analysis and promotional optimization.',
    `settled_amount` DECIMAL(18,2) COMMENT 'Final monetary amount settled between the manufacturer and retailer after all dispute resolution activities. Represents the actual financial impact of the deduction.',
    `settlement_date` DATE COMMENT 'Date on which the deduction was fully settled and closed. Represents the completion of the deduction lifecycle.',
    `settlement_method` STRING COMMENT 'Method by which the deduction was settled. Credit memo indicates issuance of a credit note, check indicates physical or electronic check payment, offset_future_invoice indicates deduction from future invoices, write_off indicates unrecoverable amount expensed, and bank_transfer indicates direct electronic payment.. Valid values are `credit_memo|check|offset_future_invoice|write_off|bank_transfer`',
    `settlement_reason_code` STRING COMMENT 'Standardized code indicating the reason for the settlement decision. Used for categorization and analysis of settlement patterns.',
    `sla_resolution_date` DATE COMMENT 'Target date by which the deduction should be resolved based on internal service level agreements or retailer contractual terms. Used for performance tracking and escalation management.',
    `source_system_code` STRING COMMENT 'The source system code of the promotion deduction record',
    `supporting_document_url` STRING COMMENT 'URL or file path to supporting documentation for the deduction claim, such as proof of performance, promotional materials, or retailer correspondence. Used for audit and dispute resolution.',
    `uom` STRING COMMENT 'The uom of the promotion deduction record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the promotion deduction record',
    CONSTRAINT pk_promotion_deduction PRIMARY KEY(`promotion_deduction_id`)
) COMMENT 'Transactional record representing the full lifecycle of a retailer deduction from initial short-payment through final settlement. Captures deduction number, retailer account, invoice reference, deduction amount, deduction type (promotional, pricing, shortage, compliance), deduction date, dispute status (open, approved, disputed, written-off), and complete settlement details: settlement date, settlement method (credit memo, check, offset against future invoice, write-off), settled amount, approved amount, disputed amount, settlement reason code, approver, and linkage to originating promotion event and funding agreement. Serves as the single entity for the entire deduction management workflow — no separate settlement record exists. Central to trade spend reconciliation, dispute resolution, and retailer relationship management.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` (
    `deduction_settlement_id` BIGINT COMMENT 'Unique identifier for the deduction settlement record. Primary key for the deduction settlement entity.',
    `funding_agreement_id` BIGINT COMMENT 'Reference to the trade promotion funding agreement or contract that governs the terms under which this deduction was taken and settled.',
    `parent_settlement_deduction_settlement_id` BIGINT COMMENT 'Reference to a parent settlement record if this is a follow-up or partial settlement. Enables tracking of multi-stage settlement processes for complex deductions.',
    `employee_id` BIGINT COMMENT 'Reference to the employee or user who approved this deduction settlement. Provides accountability and audit trail for settlement decisions.',
    `promotion_deduction_id` BIGINT COMMENT 'Reference to the originating retailer deduction that this settlement resolves. Links to the deduction record in the trade promotion management system.',
    `tertiary_deduction_last_modified_by_user_employee_id` BIGINT COMMENT 'Reference to the user who last modified this settlement record. Provides accountability for changes and supports audit requirements.',
    `trade_account_id` BIGINT COMMENT 'Reference to the retail customer account associated with this deduction settlement. Identifies the retailer or distributor party.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the deduction settlement record',
    `approval_date` DATE COMMENT 'The date on which the settlement was formally approved by the authorized approver. Marks the transition from under review to approved status.',
    `approved_amount` DECIMAL(18,2) COMMENT 'The amount approved by the manufacturer for settlement after review and validation. May differ from the claimed amount due to disputes or partial approvals.',
    `business_unit_code` STRING COMMENT 'The business unit or division responsible for this settlement. Used for organizational reporting and trade spend allocation.. Valid values are `^[A-Z0-9]{2,10}$`',
    `deduction_settlement_code` STRING COMMENT 'The deduction settlement code of the deduction settlement record',
    `cost_center_code` STRING COMMENT 'The cost center responsible for this settlement expense. Used for internal cost allocation and profitability analysis by organizational unit.. Valid values are `^[A-Z0-9]{4,12}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this settlement record was first created in the system. Provides audit trail for record creation.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this settlement record. Ensures consistent currency interpretation across multi-currency operations.. Valid values are `^[A-Z]{3}$`',
    `deduction_claimed_amount` DECIMAL(18,2) COMMENT 'The original amount claimed by the retailer in the deduction. Represents the initial disputed or taken amount before settlement negotiation.',
    `deduction_settlement_status` STRING COMMENT 'The deduction settlement status of the deduction settlement record',
    `deduction_settlement_description` STRING COMMENT 'The deduction settlement description of the deduction settlement record',
    `dispute_resolution_method` STRING COMMENT 'The approach used to resolve any disputes between the claimed and approved amounts. Documents the resolution process for compliance and process improvement.. Valid values are `negotiation|arbitration|escalation|partial_approval|full_approval|write_off`',
    `disputed_amount` DECIMAL(18,2) COMMENT 'The portion of the deduction claimed amount that was disputed or rejected by the manufacturer. Represents the difference between claimed and approved amounts when not fully approved.',
    `effective_from` DATE COMMENT 'The effective from of the deduction settlement record',
    `effective_until` DATE COMMENT 'The effective until of the deduction settlement record',
    `fiscal_period` STRING COMMENT 'The fiscal period (month or quarter) within the fiscal year in which this settlement was recorded. Enables period-based trade spend tracking.',
    `fiscal_year` STRING COMMENT 'The fiscal year in which this settlement was recorded. Used for period-based financial reporting and year-over-year trade spend analysis.',
    `gl_account_code` STRING COMMENT 'The general ledger account code to which this settlement transaction was posted. Ensures proper financial classification and reporting of trade spend.. Valid values are `^[0-9]{4,10}$`',
    `is_partial_settlement` BOOLEAN COMMENT 'Boolean flag indicating whether this settlement represents a partial resolution of the deduction. True if the deduction requires additional settlements; false if fully resolved.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this settlement record was last updated. Tracks the most recent change for audit and data quality purposes.',
    `deduction_settlement_name` STRING COMMENT 'The deduction settlement name of the deduction settlement record',
    `notes` STRING COMMENT 'The notes of the deduction settlement record',
    `payment_date` DATE COMMENT 'The date on which the settlement payment was issued or credited to the retailer. Represents the actual financial transaction date.',
    `payment_reference_number` STRING COMMENT 'External reference number for the payment transaction, such as check number, wire transfer confirmation, or credit memo number. Used for reconciliation with financial systems.',
    `profit_center_code` STRING COMMENT 'The profit center associated with this settlement. Enables profitability reporting and analysis by business segment or product line.. Valid values are `^[A-Z0-9]{4,12}$`',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the deduction settlement record',
    `resolution_code` STRING COMMENT 'The resolution code of the deduction settlement record',
    `settled_amount` DECIMAL(18,2) COMMENT 'The final amount paid or credited to the retailer as part of this settlement. This is the actual financial transaction amount and may include adjustments beyond the approved amount.',
    `settlement_amount` DECIMAL(18,2) COMMENT 'The settlement amount of the deduction settlement record',
    `settlement_cycle_time_days` STRING COMMENT 'The number of days elapsed from deduction claim date to settlement completion. Used for process efficiency measurement and Service Level Agreement (SLA) tracking.',
    `settlement_date` DATE COMMENT 'The date on which the deduction settlement was finalized and agreed upon by both parties. Represents the business event date for settlement completion.',
    `settlement_method` STRING COMMENT 'The mechanism used to resolve and pay the deduction. Indicates how the settlement amount was transferred or credited to the retailer.. Valid values are `credit_memo|check|wire_transfer|offset_invoice|write_off|accrual_adjustment`',
    `settlement_notes` STRING COMMENT 'Free-form text field for additional comments, negotiation details, or special circumstances related to the settlement. Provides context for future reference and audit.',
    `settlement_number` STRING COMMENT 'Business-readable unique identifier for the settlement transaction. Used for external communication and audit trails. Format: STL- followed by 8-12 digits.. Valid values are `^STL-[0-9]{8,12}$`',
    `settlement_reason_code` STRING COMMENT 'Standardized code indicating the business reason or category for the settlement. Used for classification and root cause analysis of deductions.. Valid values are `^[A-Z0-9]{2,10}$`',
    `settlement_reason_description` STRING COMMENT 'Detailed textual explanation of the reason for the settlement, including any specific circumstances, negotiations, or justifications documented during the settlement process.',
    `settlement_status` STRING COMMENT 'Current lifecycle status of the deduction settlement. Tracks the settlement through approval, payment, and closure workflows. [ENUM-REF-CANDIDATE: pending|approved|rejected|paid|cancelled|under_review|disputed — 7 candidates stripped; promote to reference product]',
    `sla_compliance_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this settlement was completed within the agreed Service Level Agreement (SLA) timeframe. Used for performance monitoring and retailer relationship management.',
    `source_system_code` STRING COMMENT 'Identifier for the operational system from which this settlement record originated. Supports data lineage and multi-system integration scenarios.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `source_system_record_code` STRING COMMENT 'The unique identifier of this settlement record in the source operational system. Enables traceability back to the system of record for reconciliation and troubleshooting.',
    `uom` STRING COMMENT 'The uom of the deduction settlement record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the deduction settlement record',
    `write_off_amount` DECIMAL(18,2) COMMENT 'The write off amount of the deduction settlement record',
    CONSTRAINT pk_deduction_settlement PRIMARY KEY(`deduction_settlement_id`)
) COMMENT 'Transactional record capturing the resolution and settlement of a retailer deduction. Tracks settlement date, settlement method (credit memo, check, offset against future invoice, write-off), settled amount, approved amount, disputed amount, settlement reason code, approver, and linkage to the originating deduction and funding agreement. Enables closed-loop deduction management and accurate trade spend reconciliation.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_rebate_agreement` (
    `promotion_rebate_agreement_id` BIGINT COMMENT 'Unique identifier for the promotion rebate agreement. Primary key for this entity.',
    `category_id` BIGINT COMMENT 'Reference to the product category covered by this rebate agreement. Null if agreement covers all categories.',
    `channel_classification_id` BIGINT COMMENT 'Reference to the distribution channel (e.g., grocery, drug, mass, club, e-commerce) covered by this agreement. Null if agreement covers all channels.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Rebate expenses are allocated to a cost center for budgeting and expense control, a standard finance practice.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Rebate settlements require posting to a GL account; creates a direct link for accurate ledger entries.',
    `marketing_brand_id` BIGINT COMMENT 'Reference to the brand or brand portfolio covered by this rebate agreement. Null if agreement covers all brands.',
    `employee_id` BIGINT COMMENT 'Reference to the employee or manager who approved this rebate agreement.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Tracks rebate impact on profit centers, enabling profit‑center performance reporting and rebate ROI analysis.',
    `sales_rebate_agreement_id` BIGINT COMMENT 'FK to SSOT owner sales.sales_rebate_agreement.sales_rebate_agreement_id (cross-domain duplicate entity rebate_agreement references the designated SSOT).',
    `tertiary_promotion_created_by_employee_id` BIGINT COMMENT 'Reference to the user who created this rebate agreement record.',
    `trade_account_id` BIGINT COMMENT 'Reference to the retailer or distributor account that is party to this rebate agreement.',
    `agreement_name` STRING COMMENT 'Descriptive name of the rebate agreement for easy identification and reporting purposes.',
    `agreement_number` STRING COMMENT 'Externally-known unique business identifier for the rebate agreement, used in communications with retailers and in financial systems.. Valid values are `^[A-Z0-9]{8,20}$`',
    `agreement_status` STRING COMMENT 'Current lifecycle status of the rebate agreement. Draft is being negotiated, pending approval awaits internal sign-off, active is in force, suspended is temporarily paused, terminated is ended early, and expired has reached its end date.. Valid values are `draft|pending_approval|active|suspended|terminated|expired`',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the promotion rebate agreement record',
    `approval_date` DATE COMMENT 'Date when the rebate agreement was approved by authorized signatories and became binding.',
    `auto_settlement_enabled` BOOLEAN COMMENT 'Indicates whether rebate settlements are calculated and processed automatically at the end of each measurement period (true) or require manual review and approval (false).',
    `calculation_basis` STRING COMMENT 'Method used to calculate the rebate amount. Percent of net sales applies a percentage to net revenue, dollar per case applies a fixed amount per shipping case, dollar per unit applies per individual unit, percent of gross sales applies to pre-discount revenue, and fixed amount is a predetermined lump sum.. Valid values are `percent_net_sales|dollar_per_case|dollar_per_unit|percent_gross_sales|fixed_amount`',
    `promotion_rebate_agreement_code` STRING COMMENT 'The promotion rebate agreement code of the promotion rebate agreement record',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this rebate agreement record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this agreement (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `promotion_rebate_agreement_description` STRING COMMENT 'The promotion rebate agreement description of the promotion rebate agreement record',
    `dispute_resolution_terms` STRING COMMENT 'Contractual terms defining the process for resolving disputes over rebate calculations, including escalation procedures and arbitration clauses.',
    `effective_date` DATE COMMENT 'The effective date of the promotion rebate agreement record',
    `effective_end_date` DATE COMMENT 'Date when the rebate agreement expires and performance measurement ends. Null for open-ended agreements.',
    `effective_from` DATE COMMENT 'The effective from of the promotion rebate agreement record',
    `effective_start_date` DATE COMMENT 'Date when the rebate agreement becomes active and performance measurement begins.',
    `effective_until` DATE COMMENT 'The effective until of the promotion rebate agreement record',
    `end_date` DATE COMMENT 'The end date of the promotion rebate agreement record',
    `expiry_date` DATE COMMENT 'The expiry date of the promotion rebate agreement record',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this rebate agreement record was last updated.',
    `measurement_period_type` STRING COMMENT 'Frequency at which performance is measured for rebate calculation. Monthly measures each calendar month, quarterly each fiscal quarter, semi-annual every six months, annual each fiscal year, and custom uses specific date ranges.. Valid values are `monthly|quarterly|semi_annual|annual|custom`',
    `promotion_rebate_agreement_name` STRING COMMENT 'The promotion rebate agreement name of the promotion rebate agreement record',
    `notes` STRING COMMENT 'Free-form text field for additional context, special terms, negotiation history, or operational notes about the rebate agreement.',
    `outstanding_balance` DECIMAL(18,2) COMMENT 'Current unpaid rebate balance (total accrued minus total paid). Represents liability owed to the retailer.',
    `payment_frequency` STRING COMMENT 'How often rebate payments are made to the retailer. May differ from measurement period (e.g., measured monthly but paid quarterly).. Valid values are `monthly|quarterly|semi_annual|annual|upon_achievement`',
    `payment_method` STRING COMMENT 'Method by which rebate payments are remitted. Check is physical check, ACH is Automated Clearing House electronic transfer, wire transfer is same-day bank transfer, credit memo is applied to customer account balance, and offset invoice reduces future invoices.. Valid values are `check|ach|wire_transfer|credit_memo|offset_invoice`',
    `payment_terms_days` STRING COMMENT 'Number of days after settlement calculation when payment is due to the retailer. Standard terms are 30, 45, or 60 days.',
    `promotion_rebate_agreement_status` STRING COMMENT 'The promotion rebate agreement status of the promotion rebate agreement record',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the promotion rebate agreement record',
    `rebate_rate` DECIMAL(18,2) COMMENT 'The percentage rate or dollar amount used in rebate calculation. For percentage-based rebates, this is the percentage (e.g., 2.5000 for 2.5%). For dollar-based rebates, this is the dollar amount per unit of measure.',
    `rebate_rate_pct` DECIMAL(18,2) COMMENT 'The rebate rate pct of the promotion rebate agreement record',
    `rebate_type` STRING COMMENT 'Classification of the rebate agreement based on the performance criteria or strategic objective. Volume tier rewards purchase volume thresholds, growth incentive rewards year-over-year growth, category captain rewards merchandising leadership, compliance bonus rewards adherence to terms, market development funds new market expansion, and promotional support funds joint promotional activities.. Valid values are `volume_tier|growth_incentive|category_captain|compliance_bonus|market_development|promotional_support`',
    `region_code` STRING COMMENT 'Three-letter code for the geographic region covered by this agreement (e.g., USA, CAN, MEX). Null if agreement is not region-specific.. Valid values are `^[A-Z]{3}$`',
    `sap_rebate_agreement_number` STRING COMMENT 'SAP SD rebate agreement number for financial integration and payment processing. Links to SAP FI/CO for accrual and settlement posting.',
    `source_system_code` STRING COMMENT 'The source system code of the promotion rebate agreement record',
    `start_date` DATE COMMENT 'The start date of the promotion rebate agreement record',
    `threshold_amount` DECIMAL(18,2) COMMENT 'The threshold amount of the promotion rebate agreement record',
    `threshold_unit` STRING COMMENT 'Unit of measure for tier thresholds. Cases refers to shipping cases, units to individual consumer units, dollars to net sales revenue, and physical measures to product weight or volume.. Valid values are `cases|units|dollars|kilograms|liters`',
    `tier_1_rate` DECIMAL(18,2) COMMENT 'Rebate rate applicable when tier 1 threshold is achieved. Format matches calculation_basis (percentage or dollar amount).',
    `tier_1_threshold` DECIMAL(18,2) COMMENT 'Minimum qualifying volume or revenue required to earn the first tier rebate rate. Unit of measure defined by threshold_unit field.',
    `tier_2_rate` DECIMAL(18,2) COMMENT 'Rebate rate applicable when tier 2 threshold is achieved. Null if agreement has only one tier.',
    `tier_2_threshold` DECIMAL(18,2) COMMENT 'Minimum qualifying volume or revenue required to earn the second tier rebate rate. Null if agreement has only one tier.',
    `tier_3_rate` DECIMAL(18,2) COMMENT 'Rebate rate applicable when tier 3 threshold is achieved. Null if agreement has fewer than three tiers.',
    `tier_3_threshold` DECIMAL(18,2) COMMENT 'Minimum qualifying volume or revenue required to earn the third tier rebate rate. Null if agreement has fewer than three tiers.',
    `tier_structure` STRING COMMENT 'Defines how rebate tiers are applied. Single tier has one rate for all qualifying volume, multi-tier has different rates at different thresholds, progressive applies higher rates only to incremental volume above each threshold, and retroactive applies the highest achieved rate to all volume.. Valid values are `single_tier|multi_tier|progressive|retroactive`',
    `total_accrued_amount` DECIMAL(18,2) COMMENT 'Cumulative rebate amount accrued across all settlement periods to date. Updated with each settlement calculation.',
    `total_paid_amount` DECIMAL(18,2) COMMENT 'Cumulative rebate amount paid to the retailer across all settlement periods to date. Updated when payments are processed.',
    `tpm_system_code` STRING COMMENT 'External system identifier from the source Trade Promotion Management system (e.g., Salesforce TPM, TradeEdge) for integration and reconciliation purposes.',
    `uom` STRING COMMENT 'The uom of the promotion rebate agreement record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the promotion rebate agreement record',
    CONSTRAINT pk_promotion_rebate_agreement PRIMARY KEY(`promotion_rebate_agreement_id`)
) COMMENT 'Master entity representing a retailer rebate agreement including its periodic settlement history. Captures agreement terms: retailer account, rebate type (volume tier, growth incentive, category captain, compliance), calculation basis (% of net sales, $ per case), tier thresholds, measurement period, payment frequency, and agreement status. Contains embedded settlement records: settlement period, earned rebate amount, qualifying volume/revenue, tier achieved, payment method, payment date, settlement status (calculated, approved, paid, disputed), and SAP FI payment reference. Distinct from funding agreements in that rebates are earned retrospectively based on performance. Serves as the SSOT for both rebate agreement terms and their periodic settlement calculations.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`promotion`.`rebate_settlement` (
    `rebate_settlement_id` BIGINT COMMENT 'Unique identifier for the rebate settlement transaction. Primary key for the rebate settlement record.',
    `employee_id` BIGINT COMMENT 'Reference to the user or employee who approved this rebate settlement for payment. Nullable until approval is completed.',
    `promotion_rebate_agreement_id` BIGINT COMMENT 'Reference to the parent rebate agreement under which this settlement is calculated. Links to the master rebate agreement that defines terms, tiers, and conditions.',
    `trade_account_id` BIGINT COMMENT 'Reference to the retailer or trade partner receiving the rebate payment. Identifies the counterparty in the rebate settlement transaction.',
    `accrual_reversal_flag` BOOLEAN COMMENT 'Indicates whether this settlement reverses a previously accrued rebate liability. True if the settlement clears an accrual; False if it represents a new liability.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Manual adjustment applied to the calculated rebate amount. May represent corrections, dispute resolutions, or contractual modifications. Positive or negative value.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the rebate settlement record',
    `approval_date` DATE COMMENT 'Date on which the rebate settlement was approved for payment by authorized personnel. Nullable until approval workflow is completed.',
    `calculation_date` DATE COMMENT 'Date on which the rebate settlement amount was calculated. Represents the business event timestamp when the system computed earned rebate based on qualifying performance.',
    `rebate_settlement_code` STRING COMMENT 'The rebate settlement code of the rebate settlement record',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this rebate settlement record was first created in the system. Audit field for data lineage and compliance.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this settlement record. Defines the currency in which rebate is calculated and paid.. Valid values are `^[A-Z]{3}$`',
    `rebate_settlement_description` STRING COMMENT 'The rebate settlement description of the rebate settlement record',
    `dispute_date` DATE COMMENT 'Date on which the trade partner raised a dispute against this settlement. Nullable unless a dispute has been filed.',
    `dispute_reason` STRING COMMENT 'Reason code or description if the settlement is disputed by the trade partner. Nullable unless settlement_status is disputed.',
    `earned_rebate_amount` DECIMAL(18,2) COMMENT 'Total rebate amount earned by the trade partner for the settlement period. Calculated based on qualifying revenue/volume and applicable rebate rate or tier.',
    `effective_from` DATE COMMENT 'The effective from of the rebate settlement record',
    `effective_until` DATE COMMENT 'The effective until of the rebate settlement record',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this rebate settlement record was last updated. Audit field for tracking changes and data lineage.',
    `rebate_settlement_name` STRING COMMENT 'The rebate settlement name of the rebate settlement record',
    `net_settlement_amount` DECIMAL(18,2) COMMENT 'Final net amount to be paid to the trade partner after all adjustments. Equals earned_rebate_amount plus adjustment_amount.',
    `notes` STRING COMMENT 'Free-text notes or comments related to this rebate settlement. May include calculation details, dispute notes, or special instructions.',
    `payment_date` DATE COMMENT 'Date on which the rebate payment was issued to the trade partner. Nullable until payment execution is completed.',
    `payment_method` STRING COMMENT 'Method by which the rebate payment is issued to the trade partner. Defines the financial instrument used for settlement.. Valid values are `ach|wire_transfer|check|credit_memo|offset`',
    `payment_reference_number` STRING COMMENT 'External reference number from the payment system or financial institution. Links this settlement to the actual payment transaction in SAP FI or banking system.',
    `qualifying_revenue` DECIMAL(18,2) COMMENT 'Total revenue amount that qualifies for rebate calculation during the settlement period. Represents the base upon which rebate percentage or tier is applied.',
    `qualifying_volume` DECIMAL(18,2) COMMENT 'Total volume (units, cases, or other measure) that qualifies for rebate calculation during the settlement period. Used for volume-based rebate agreements.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the rebate settlement record',
    `rebate_amount` DECIMAL(18,2) COMMENT 'The rebate amount of the rebate settlement record',
    `rebate_rate` DECIMAL(18,2) COMMENT 'Percentage rate applied to qualifying revenue or volume to calculate the earned rebate amount. Expressed as a decimal (e.g., 0.0250 for 2.5%).',
    `rebate_settlement_status` STRING COMMENT 'The rebate settlement status of the rebate settlement record',
    `resolution_date` DATE COMMENT 'Date on which a disputed settlement was resolved. Nullable until dispute resolution is completed.',
    `sap_fi_document_number` STRING COMMENT 'SAP FI document number for the accounting entry related to this rebate settlement. Links to the general ledger posting for rebate expense and liability.',
    `settled_amount` DECIMAL(18,2) COMMENT 'The settled amount of the rebate settlement record',
    `settlement_date` DATE COMMENT 'The settlement date of the rebate settlement record',
    `settlement_number` STRING COMMENT 'Business identifier for the rebate settlement. Externally-known unique code used in communications with trade partners and in financial systems. Format: RBS-YYYYMMDD-NNNN.. Valid values are `^RBS-[0-9]{8}-[0-9]{4}$`',
    `settlement_period` STRING COMMENT 'The settlement period of the rebate settlement record',
    `settlement_period_end_date` DATE COMMENT 'End date of the performance period for which this rebate settlement is calculated. Defines the close of the qualifying transaction window.',
    `settlement_period_start_date` DATE COMMENT 'Start date of the performance period for which this rebate settlement is calculated. Defines the beginning of the qualifying transaction window.',
    `settlement_status` STRING COMMENT 'Current lifecycle status of the rebate settlement. Tracks progression from initial calculation through approval, payment, and potential dispute resolution.. Valid values are `calculated|approved|paid|disputed|cancelled|reversed`',
    `source_system_code` STRING COMMENT 'The source system code of the rebate settlement record',
    `tier_achieved` STRING COMMENT 'Rebate tier level achieved by the trade partner during the settlement period. Identifies which performance threshold was met (e.g., Bronze, Silver, Gold, Platinum).',
    `tpm_system_code` STRING COMMENT 'External system identifier from the Trade Promotion Management system (e.g., Salesforce TPM, TradeEdge). Links this settlement to the source TPM system record.',
    `uom` STRING COMMENT 'The uom of the rebate settlement record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the rebate settlement record',
    `volume_uom` STRING COMMENT 'Unit of measure for the qualifying volume. Defines how volume is quantified for rebate calculation purposes.. Valid values are `cases|units|pallets|kilograms|liters`',
    CONSTRAINT pk_rebate_settlement PRIMARY KEY(`rebate_settlement_id`)
) COMMENT 'Transactional record capturing the periodic calculation and payment settlement of retailer rebates under a rebate agreement. Tracks settlement period, earned rebate amount, qualifying volume/revenue, tier achieved, payment method, payment date, settlement status (calculated, approved, paid, disputed), and SAP FI payment reference. Enables accurate rebate liability tracking and cash flow forecasting for the trade finance function.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`promotion`.`post_event_analysis` (
    `post_event_analysis_id` BIGINT COMMENT 'Unique identifier for the post-event analysis record. Primary key for this analytical entity capturing promotion performance measurement at SKU-retailer-period granularity.',
    `employee_id` BIGINT COMMENT 'Reference to the trade marketing analyst or data scientist who conducted this post-event analysis. Enables accountability and quality tracking.',
    `promotion_event_id` BIGINT COMMENT 'Reference to the completed promotion event being analyzed. Links to the source promotion execution record in the TPM system.',
    `sku_id` BIGINT COMMENT 'Reference to the specific SKU that was promoted during this event. Enables SKU-level performance analysis and lift measurement.',
    `trade_account_id` BIGINT COMMENT 'Reference to the retailer or trade partner where the promotion was executed. Enables retailer-level performance comparison and compliance tracking.',
    `trade_promotion_id` BIGINT COMMENT 'The trade promotion id of the post event analysis record',
    `actual_lift_pct` DECIMAL(18,2) COMMENT 'The actual lift pct of the post event analysis record',
    `actual_promoted_volume_units` DECIMAL(18,2) COMMENT 'Actual sales volume in units achieved during the promotional period. Core metric for calculating incremental lift and ROI.',
    `actual_roi_percentage` DECIMAL(18,2) COMMENT 'The actual roi percentage of the post event analysis record',
    `actual_trade_spend_amount` DECIMAL(18,2) COMMENT 'Total trade spend actually incurred for this promotion event, including all accruals, deductions, and settlements. Used for actual ROI and GMROI calculation.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the post event analysis record',
    `analysis_completed_timestamp` TIMESTAMP COMMENT 'Date and time when the post-event analysis was completed and results finalized. Marks the transition to approved or archived status.',
    `analysis_date` DATE COMMENT 'The analysis date of the post event analysis record',
    `analysis_period_end_date` DATE COMMENT 'End date of the promotional period being analyzed. Completes the temporal boundary for performance measurement window.',
    `analysis_period_start_date` DATE COMMENT 'Start date of the promotional period being analyzed. Defines the temporal boundary for lift measurement and baseline comparison.',
    `analysis_status` STRING COMMENT 'Current lifecycle status of the post-event analysis. Tracks progression from initial draft through approval and archival.. Valid values are `draft|in_progress|completed|approved|rejected|archived`',
    `analyst_notes` STRING COMMENT 'Free-text commentary from the analyst conducting the post-event review. Captures qualitative insights, contextual factors, and recommendations for future planning.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when this post-event analysis was formally approved. Locks the record for reporting and TPO model training.',
    `baseline_confidence_interval_lower` DECIMAL(18,2) COMMENT 'Lower bound of the statistical confidence interval for baseline estimate. Quantifies uncertainty in baseline calculation.',
    `baseline_confidence_interval_upper` DECIMAL(18,2) COMMENT 'Upper bound of the statistical confidence interval for baseline estimate. Completes the uncertainty quantification for baseline.',
    `baseline_data_source` STRING COMMENT 'Primary data source used for baseline estimation. Identifies whether baseline was derived from POS scan data, syndicated panels, or internal systems.. Valid values are `pos_scan|nielsen_iq|tradeedge_secondary|internal_shipment|syndicated_panel|custom`',
    `baseline_estimation_methodology` STRING COMMENT 'Statistical or analytical method used to calculate the baseline volume estimate. Critical for understanding confidence and reproducibility of lift measurements. [ENUM-REF-CANDIDATE: moving_average|exponential_smoothing|regression|causal_model|nielsen_iq|tradeedge|custom — 7 candidates stripped; promote to reference product]',
    `baseline_volume_units` DECIMAL(18,2) COMMENT 'Estimated baseline sales volume in units that would have occurred without the promotion. Foundation for incremental lift calculation.',
    `post_event_analysis_code` STRING COMMENT 'The post event analysis code of the post event analysis record',
    `cost_per_incremental_case` DECIMAL(18,2) COMMENT 'Trade spend divided by incremental lift in case-equivalent units. Measures cost efficiency of generating incremental volume.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this post-event analysis record was first created in the system. Audit trail for record lifecycle.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this record. Ensures consistent financial reporting across markets.. Valid values are `^[A-Z]{3}$`',
    `data_vintage_date` DATE COMMENT 'As-of date for the sales data used in this analysis. Important for understanding data latency and potential for future revisions.',
    `post_event_analysis_description` STRING COMMENT 'The post event analysis description of the post event analysis record',
    `display_compliance_flag` BOOLEAN COMMENT 'Indicates whether the retailer executed the agreed in-store display (end cap, shipper, pallet) as planned. True if compliant, False if not.',
    `effective_from` DATE COMMENT 'The effective from of the post event analysis record',
    `effective_until` DATE COMMENT 'The effective until of the post event analysis record',
    `feature_compliance_flag` BOOLEAN COMMENT 'Indicates whether the retailer executed the agreed feature advertising (circular, flyer, digital ad) as planned. True if compliant, False if not.',
    `gmroi` DECIMAL(18,2) COMMENT 'Gross margin return on investment, calculated as incremental gross margin divided by actual trade spend. Measures profitability efficiency of promotional investment.',
    `incremental_lift_percentage` DECIMAL(18,2) COMMENT 'Percentage lift over baseline, calculated as (incremental lift units / baseline volume units) * 100. Enables comparison across SKUs and events of different scales.',
    `incremental_lift_units` DECIMAL(18,2) COMMENT 'Incremental sales volume in units attributable to the promotion, calculated as actual promoted volume minus baseline volume. Primary measure of promotional effectiveness.',
    `incremental_revenue_amount` DECIMAL(18,2) COMMENT 'The incremental revenue amount of the post event analysis record',
    `incremental_volume` DECIMAL(18,2) COMMENT 'The incremental volume of the post event analysis record',
    `incremental_volume_units` DECIMAL(18,2) COMMENT 'The incremental volume units of the post event analysis record',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this post-event analysis record was last updated. Tracks iterative refinement during analysis workflow.',
    `learning_classification` STRING COMMENT 'Categorical assessment of promotion performance used to feed TPO learning loops. Enables pattern recognition and future optimization.. Valid values are `best_practice|acceptable|underperformer|failure|outlier`',
    `lift_measurement_methodology` STRING COMMENT 'Analytical approach used to isolate and measure promotional lift. Determines rigor and defensibility of lift claims.. Valid values are `simple_difference|control_group|matched_market|time_series|causal_impact|machine_learning`',
    `lift_measurement_source` STRING COMMENT 'Primary data source used to measure actual promoted volume and calculate lift. Critical for understanding data quality and measurement reliability.. Valid values are `pos_scan|nielsen_iq_panel|tradeedge_secondary|internal_shipment|syndicated_data|blended`',
    `lift_percentage` DECIMAL(18,2) COMMENT 'The lift percentage of the post event analysis record',
    `post_event_analysis_name` STRING COMMENT 'The post event analysis name of the post event analysis record',
    `notes` STRING COMMENT 'The notes of the post event analysis record',
    `oos_impact_estimated_units` DECIMAL(18,2) COMMENT 'Estimated sales volume lost due to out-of-stock incidents during the promotion. Quantifies the opportunity cost of poor availability.',
    `oos_incident_count` STRING COMMENT 'Number of out-of-stock incidents detected during the promotional period. Critical for understanding lost sales opportunity and execution quality.',
    `planned_trade_spend_amount` DECIMAL(18,2) COMMENT 'Total trade spend budgeted for this promotion event at planning time. Baseline for variance analysis and ROI calculation.',
    `post_event_analysis_status` STRING COMMENT 'The post event analysis status of the post event analysis record',
    `pre_promotion_trend` STRING COMMENT 'Observed sales trend in the period immediately preceding the promotion. Contextualizes baseline and helps explain lift performance.. Valid values are `increasing|stable|decreasing|seasonal|volatile`',
    `pricing_compliance_flag` BOOLEAN COMMENT 'Indicates whether the retailer maintained the agreed promotional price throughout the event period. True if compliant, False if not.',
    `profitability_amount` DECIMAL(18,2) COMMENT 'The profitability amount of the post event analysis record',
    `promotional_roi` DECIMAL(18,2) COMMENT 'Return on investment for this promotion, calculated as (incremental gross profit - actual trade spend) / actual trade spend. Primary financial effectiveness metric.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the post event analysis record',
    `recommendation_for_future` STRING COMMENT 'Strategic recommendation for how this promotion type should be treated in future planning cycles based on performance results.. Valid values are `repeat|modify|avoid|test_further|scale_up`',
    `retailer_compliance_score` DECIMAL(18,2) COMMENT 'Composite score (0-100) measuring retailer adherence to promotional execution requirements including pricing, display, feature, and inventory. Higher scores indicate better execution quality.',
    `roi_pct` DECIMAL(18,2) COMMENT 'The roi pct of the post event analysis record',
    `sell_through_rate` DECIMAL(18,2) COMMENT 'Percentage of promoted inventory that sold through to consumers during the promotional period. Indicates promotional velocity and inventory efficiency.',
    `source_system_code` STRING COMMENT 'The source system code of the post event analysis record',
    `total_spend_amount` DECIMAL(18,2) COMMENT 'The total spend amount of the post event analysis record',
    `trade_spend_variance_amount` DECIMAL(18,2) COMMENT 'Difference between actual and planned trade spend (actual minus planned). Highlights budget adherence and cost control effectiveness.',
    `uom` STRING COMMENT 'The uom of the post event analysis record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the post event analysis record',
    CONSTRAINT pk_post_event_analysis PRIMARY KEY(`post_event_analysis_id`)
) COMMENT 'Comprehensive analytical record capturing post-event review (PER) results for a completed promotion event at SKU-retailer-period granularity. Stores baseline volume estimates (methodology, confidence interval, data source, pre-promotion trend), actual promoted volume, incremental lift measurements (units, percentage, lift source — POS scan data, Nielsen IQ panel, TradeEdge secondary sales), measurement methodology, data vintage, planned vs. actual trade spend, promotional ROI, GMROI, cost per incremental case, sell-through rate, OOS incidents, retailer compliance score, and analyst notes. Serves as the single analytical SSOT for all promotion performance measurement including baseline estimation, lift calculation, and ROI analysis. Feeds TPO optimization models, learning loops, and future planning decisions.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` (
    `promoted_price_id` BIGINT COMMENT 'Primary key for promoted_price',
    `channel_classification_id` BIGINT COMMENT 'Reference to the distribution or sales channel (e.g., grocery, mass, club, e-commerce, DTC) where this promotional price is applicable.',
    `event_sku_id` BIGINT COMMENT 'The event sku id of the promoted price record',
    `employee_id` BIGINT COMMENT 'Reference to the user or manager who approved this promotional price. Used for audit trail and accountability in trade spend governance.',
    `promotion_event_id` BIGINT COMMENT 'Reference to the parent promotion event or campaign under which this promotional price is defined. Links to the broader trade promotion execution context.',
    `sku_id` BIGINT COMMENT 'Reference to the SKU (Stock Keeping Unit) for which this promotional price is defined. Identifies the specific product variant being promoted.',
    `tertiary_promoted_last_modified_by_employee_id` BIGINT COMMENT 'Reference to the user who last modified this promotional pricing record. Used for change tracking and audit trail purposes.',
    `trade_account_id` BIGINT COMMENT 'Reference to the retailer or trade account for which this promotional price applies. Enables account-specific promotional pricing strategies.',
    `trade_promotion_id` BIGINT COMMENT 'The trade promotion id of the promoted price record',
    `accrual_method` STRING COMMENT 'The method used to accrue and settle trade promotion funds for this promotional price. Scan-back (per unit sold), bill-back (post-event invoice), off-invoice (upfront discount), lump-sum (fixed payment), or performance-based (tied to metrics).. Valid values are `scan_back|bill_back|off_invoice|lump_sum|performance_based`',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the promoted price record',
    `approval_date` DATE COMMENT 'The date when this promotional price was formally approved for execution. Part of the audit trail for trade promotion compliance.',
    `approval_status` STRING COMMENT 'Current lifecycle status of the promotional price record. Tracks the approval workflow from draft through execution to expiration. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|rejected|active|expired|cancelled — 7 candidates stripped; promote to reference product]',
    `promoted_price_code` STRING COMMENT 'The promoted price code of the promoted price record',
    `cost_of_goods_sold` DECIMAL(18,2) COMMENT 'The manufacturers cost of goods sold per unit for the SKU at the time this promotional price was defined. Used for promotional ROI and GMROI analysis.',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code where this promotional price is valid. Supports multi-country promotional planning and compliance.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this promotional pricing record was first created in the system. Part of the audit trail for data lineage and compliance.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the promotional price amount and regular shelf price (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `promoted_price_description` STRING COMMENT 'The promoted price description of the promoted price record',
    `discount_pct` DECIMAL(18,2) COMMENT 'The discount pct of the promoted price record',
    `effective_date` DATE COMMENT 'The effective date of the promoted price record',
    `effective_end_date` DATE COMMENT 'The date when this promotional price expires and is no longer valid. Nullable for open-ended or evergreen promotional pricing programs.',
    `effective_from` DATE COMMENT 'The effective from of the promoted price record',
    `effective_start_date` DATE COMMENT 'The date when this promotional price becomes active and available for use in retail execution and point-of-sale systems.',
    `effective_until` DATE COMMENT 'The effective until of the promoted price record',
    `estimated_volume_lift` DECIMAL(18,2) COMMENT 'The projected percentage increase in sales volume expected from this promotional price compared to baseline sales. Used for demand planning and promotional forecasting.',
    `expiry_date` DATE COMMENT 'The expiry date of the promoted price record',
    `funding_source` STRING COMMENT 'Identifies the party responsible for funding this promotional price discount. Manufacturer-funded, retailer-funded, co-op (shared), vendor-funded, or third-party funded.. Valid values are `manufacturer|retailer|co_op|vendor|third_party`',
    `is_advertised` BOOLEAN COMMENT 'Boolean flag indicating whether this promotional price is featured in retailer advertising, circulars, or marketing campaigns. True if advertised, False if unadvertised in-store promotion.',
    `is_stackable` BOOLEAN COMMENT 'Boolean flag indicating whether this promotional price can be combined (stacked) with other promotions, coupons, or discounts. True if stackable, False if exclusive.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this promotional pricing record was last updated or modified. Used for change tracking and audit purposes.',
    `maximum_purchase_quantity` STRING COMMENT 'The maximum number of units eligible for this promotional price per transaction or per customer. Used to cap promotional exposure and manage trade spend. Nullable if no cap applies.',
    `minimum_purchase_quantity` STRING COMMENT 'The minimum number of units a consumer or retailer must purchase to qualify for this promotional price. Used for multi-buy and volume-based promotions. Nullable if no minimum applies.',
    `promoted_price_name` STRING COMMENT 'The promoted price name of the promoted price record',
    `notes` STRING COMMENT 'The notes of the promoted price record',
    `price_reduction_percentage` DECIMAL(18,2) COMMENT 'The percentage discount from the regular shelf price, calculated as ((regular_shelf_price - promotional_price_amount) / regular_shelf_price) * 100. Represents the depth of the promotional discount.',
    `price_start_date` DATE COMMENT 'The price start date of the promoted price record',
    `price_type` STRING COMMENT 'The price type of the promoted price record',
    `pricing_strategy_type` STRING COMMENT 'Classification of the promotional pricing strategy. Hi-Lo (High-Low temporary price reduction), EDLP (Everyday Low Price), multi-buy (e.g., 2 for $5), BOGO (Buy One Get One), scan-back (retailer scans at checkout for discount), temporary price reduction, rebate, or coupon-based pricing. [ENUM-REF-CANDIDATE: hi_lo|edlp|multi_buy|bogo|scan_back|temporary_price_reduction|rebate|coupon — 8 candidates stripped; promote to reference product]',
    `promo_price` DECIMAL(18,2) COMMENT 'The promo price of the promoted price record',
    `promoted_price_status` STRING COMMENT 'The promoted price status of the promoted price record',
    `promotional_allowance_amount` DECIMAL(18,2) COMMENT 'The per-unit allowance or funding provided by the manufacturer to the retailer to support this promotional price. Used for trade spend accrual and settlement calculations.',
    `promotional_price_amount` DECIMAL(18,2) COMMENT 'The promoted price point for the SKU during the promotional period. This is the actual selling price offered to consumers or retailers during the promotion.',
    `promotional_price_code` STRING COMMENT 'Business identifier or code for this promotional price record. Used for external reference and integration with TPM systems.. Valid values are `^[A-Z0-9_-]{4,20}$`',
    `promotional_price_description` STRING COMMENT 'Detailed description of the promotional price offer, including terms, conditions, and any special instructions for retail execution or consumer communication.',
    `promotional_price_name` STRING COMMENT 'Human-readable name or label for this promotional price configuration, used for identification and reporting purposes.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the promoted price record',
    `region_code` STRING COMMENT 'Geographic region code where this promotional price is applicable. Enables regional pricing strategies and localized trade promotions.. Valid values are `^[A-Z]{2,10}$`',
    `regular_price` DECIMAL(18,2) COMMENT 'The regular price of the promoted price record',
    `regular_price_amount` DECIMAL(18,2) COMMENT 'The regular price amount of the promoted price record',
    `regular_shelf_price` DECIMAL(18,2) COMMENT 'The standard or recommended selling price (RSP/MSRP) for the SKU before the promotional discount is applied. Used as the baseline for calculating price reduction depth.',
    `retailer_margin_percentage` DECIMAL(18,2) COMMENT 'The target or agreed-upon margin percentage for the retailer when selling at this promotional price. Used for trade negotiation and pricing strategy analysis.',
    `scan_back_rate` DECIMAL(18,2) COMMENT 'The per-unit reimbursement rate paid to the retailer for each unit sold at the promotional price under a scan-back pricing model. Nullable if not a scan-back promotion.',
    `source_system_code` STRING COMMENT 'The source system code of the promoted price record',
    `tpm_system_code` STRING COMMENT 'External system identifier from the source Trade Promotion Management system (e.g., Salesforce TPM, SAP TPM). Used for data lineage and system integration.',
    `uom` STRING COMMENT 'The uom of the promoted price record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the promoted price record',
    CONSTRAINT pk_promoted_price PRIMARY KEY(`promoted_price_id`)
) COMMENT 'Master entity capturing the promotional price points defined for SKUs within a promotion event or pricing program. Tracks promoted price type (Hi-Lo temporary price reduction, EDLP, multi-buy, BOGO, scan-back price), promoted price amount, regular shelf price (RSP/MSRP), price reduction depth (%), effective date range, retailer account, channel, and approval status. Distinct from standard list pricing — this entity owns the promotional price layer used during trade events.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`promotion`.`lift_measurement` (
    `lift_measurement_id` BIGINT COMMENT 'Unique identifier for the promotional lift measurement record.',
    `employee_id` BIGINT COMMENT 'Reference to the user who performed or validated the lift measurement analysis.',
    `promotion_event_id` BIGINT COMMENT 'The promotion event id of the lift measurement record',
    `retail_store_id` BIGINT COMMENT 'Reference to the specific retail store location where lift was measured, if applicable.',
    `sku_id` BIGINT COMMENT 'Reference to the specific SKU for which promotional lift is measured.',
    `trade_account_id` BIGINT COMMENT 'Reference to the retailer or trade account where the promotion was executed.',
    `trade_promotion_id` BIGINT COMMENT 'Reference to the trade promotion event for which lift is being measured.',
    `actual_promoted_volume_units` DECIMAL(18,2) COMMENT 'The actual volume in units sold during the promotional period.',
    `actual_volume` DECIMAL(18,2) COMMENT 'The actual volume of the lift measurement record',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the lift measurement record',
    `baseline_calculation_method` STRING COMMENT 'The specific method used to calculate the baseline volume for comparison.. Valid values are `moving_average|exponential_smoothing|linear_regression|seasonal_decomposition|custom_model`',
    `baseline_period_weeks` STRING COMMENT 'The number of weeks of historical data used to establish the baseline trend.',
    `baseline_volume` DECIMAL(18,2) COMMENT 'The baseline volume of the lift measurement record',
    `baseline_volume_units` DECIMAL(18,2) COMMENT 'The expected volume in units based on pre-promotion trend analysis, representing what would have sold without the promotion.',
    `cannibalization_rate` DECIMAL(18,2) COMMENT 'The percentage of incremental lift that came from other SKUs within the same brand or category, indicating internal sales transfer.',
    `lift_measurement_code` STRING COMMENT 'The lift measurement code of the lift measurement record',
    `confidence_interval_lower` DECIMAL(18,2) COMMENT 'The lower bound of the confidence interval for the lift measurement, typically at 95% confidence level.',
    `confidence_interval_upper` DECIMAL(18,2) COMMENT 'The upper bound of the confidence interval for the lift measurement, typically at 95% confidence level.',
    `confidence_level_percentage` DECIMAL(18,2) COMMENT 'The statistical confidence level of the lift measurement, typically 90%, 95%, or 99%.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this lift measurement record was first created in the system.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for all monetary values in this record.. Valid values are `^[A-Z]{3}$`',
    `data_vintage_date` DATE COMMENT 'The date when the source data used for this lift measurement was extracted or made available.',
    `lift_measurement_description` STRING COMMENT 'The lift measurement description of the lift measurement record',
    `discount_percentage` DECIMAL(18,2) COMMENT 'The percentage discount offered during the promotion, calculated as ((regular price - promotional price) / regular price) * 100.',
    `effective_from` DATE COMMENT 'The effective from of the lift measurement record',
    `effective_until` DATE COMMENT 'The effective until of the lift measurement record',
    `halo_effect_units` DECIMAL(18,2) COMMENT 'The additional volume lift observed in related non-promoted SKUs due to the promotion, representing positive spillover effects.',
    `incremental_lift_percentage` DECIMAL(18,2) COMMENT 'The percentage lift over baseline, calculated as (incremental lift units / baseline volume units) * 100.',
    `incremental_lift_units` DECIMAL(18,2) COMMENT 'The incremental volume in units attributable to the promotion, calculated as actual promoted volume minus baseline volume.',
    `incremental_revenue` DECIMAL(18,2) COMMENT 'The incremental revenue generated by the promotion, calculated as incremental lift units multiplied by promotional price.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this lift measurement record was last updated.',
    `lift_measurement_status` STRING COMMENT 'The lift measurement status of the lift measurement record',
    `lift_pct` DECIMAL(18,2) COMMENT 'The lift pct of the lift measurement record',
    `lift_percentage` DECIMAL(18,2) COMMENT 'The lift percentage of the lift measurement record',
    `lift_source` STRING COMMENT 'The data source used to measure promotional lift.. Valid values are `pos_scan_data|nielsen_iq_panel|tradeedge_secondary_sales|iri_panel|internal_shipment_data|syndicated_data`',
    `lift_units` DECIMAL(18,2) COMMENT 'The lift units of the lift measurement record',
    `measurement_date` DATE COMMENT 'The measurement date of the lift measurement record',
    `measurement_method` STRING COMMENT 'The measurement method of the lift measurement record',
    `measurement_methodology` STRING COMMENT 'The statistical methodology used to calculate baseline and incremental lift.. Valid values are `pre_post_comparison|control_group|time_series_regression|matched_market|causal_impact`',
    `measurement_notes` STRING COMMENT 'Free-text notes documenting any anomalies, data quality issues, or special considerations for this lift measurement.',
    `measurement_period` STRING COMMENT 'The measurement period of the lift measurement record',
    `measurement_status` STRING COMMENT 'The current status of the lift measurement in the validation and approval workflow.. Valid values are `preliminary|validated|final|revised|rejected`',
    `measurement_week_end_date` DATE COMMENT 'The end date of the week for which lift is measured.',
    `measurement_week_start_date` DATE COMMENT 'The start date of the week for which lift is measured, typically aligned with retailer calendar weeks.',
    `lift_measurement_name` STRING COMMENT 'The lift measurement name of the lift measurement record',
    `notes` STRING COMMENT 'The notes of the lift measurement record',
    `p_value` DECIMAL(18,2) COMMENT 'The p-value from the statistical test of lift significance, where values below 0.05 typically indicate statistical significance.',
    `post_promotion_dip_units` DECIMAL(18,2) COMMENT 'The volume decline observed in the weeks immediately following the promotion, indicating pantry loading or forward buying effects.',
    `promoted_volume` DECIMAL(18,2) COMMENT 'The promoted volume of the lift measurement record',
    `promotional_price` DECIMAL(18,2) COMMENT 'The actual selling price during the promotional period.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the lift measurement record',
    `regular_price` DECIMAL(18,2) COMMENT 'The regular non-promotional selling price used as baseline for price comparison.',
    `source_system_code` STRING COMMENT 'The source system code of the lift measurement record',
    `statistical_significance_flag` BOOLEAN COMMENT 'Indicates whether the measured lift is statistically significant at the specified confidence level.',
    `tpm_system_reference_code` STRING COMMENT 'The unique identifier for this lift measurement record in the source TPM system (Salesforce Consumer Goods Cloud).',
    `uom` STRING COMMENT 'The uom of the lift measurement record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the lift measurement record',
    `validated_timestamp` TIMESTAMP COMMENT 'The date and time when the lift measurement was validated and approved for use in ROI calculations.',
    CONSTRAINT pk_lift_measurement PRIMARY KEY(`lift_measurement_id`)
) COMMENT 'Transactional record capturing incremental volume lift measurements for a promotion event at the SKU-retailer-week level. Stores baseline volume (pre-promotion trend), actual promoted volume, incremental lift units, incremental lift percentage, lift source (POS scan data, Nielsen IQ panel, TradeEdge secondary sales), measurement methodology, confidence interval, and data vintage. Feeds TPO optimization models and post-event ROI calculations.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`promotion`.`tpo_scenario` (
    `tpo_scenario_id` BIGINT COMMENT 'Reference to the baseline or control TPO scenario against which this scenario is compared for incremental analysis.',
    `category_id` BIGINT COMMENT 'Reference to the product category this TPO scenario focuses on, if scenario is category-specific.',
    `channel_classification_id` BIGINT COMMENT 'Reference to the distribution channel this TPO scenario applies to, if scenario is channel-specific.',
    `marketing_brand_id` BIGINT COMMENT 'Reference to the primary brand this TPO scenario focuses on, if scenario is brand-specific.',
    `parent_scenario_tpo_scenario_id` BIGINT COMMENT 'Reference to the parent TPO scenario if this scenario is a variant or iteration derived from another scenario.',
    `employee_id` BIGINT COMMENT 'Reference to the trade marketing analyst or manager who owns and is responsible for this TPO scenario.',
    `rd_project_id` BIGINT COMMENT 'Foreign key linking to research.rd_project. Business justification: Optimization scenarios use the R&D projects launch forecast and assumptions as inputs.',
    `tertiary_tpo_approved_by_user_employee_id` BIGINT COMMENT 'Reference to the user who approved this TPO scenario for execution or further analysis.',
    `trade_account_id` BIGINT COMMENT 'Reference to the specific retail account this TPO scenario targets, if scenario is account-specific.',
    `trade_calendar_id` BIGINT COMMENT 'Reference to the promotional calendar that defines the planning period and promotional events covered by this scenario.',
    `trade_promotion_id` BIGINT COMMENT 'The trade promotion id of the tpo scenario record',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the tpo scenario record',
    `approval_date` DATE COMMENT 'Date when the TPO scenario was formally approved for execution or implementation.',
    `tpo_scenario_code` STRING COMMENT 'The tpo scenario code of the tpo scenario record',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the primary country this scenario applies to.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this TPO scenario record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary values in this scenario.. Valid values are `^[A-Z]{3}$`',
    `tpo_scenario_description` STRING COMMENT 'The tpo scenario description of the tpo scenario record',
    `effective_from` DATE COMMENT 'The effective from of the tpo scenario record',
    `effective_until` DATE COMMENT 'The effective until of the tpo scenario record',
    `evaluation_date` DATE COMMENT 'Date when the TPO scenario was evaluated and optimization calculations were completed.',
    `geographic_scope` STRING COMMENT 'Geographic coverage level of the TPO scenario: national, regional, local, or global.. Valid values are `national|regional|local|global`',
    `is_baseline_scenario` BOOLEAN COMMENT 'Boolean flag indicating whether this scenario serves as the baseline control scenario for comparison purposes.',
    `is_recommended` BOOLEAN COMMENT 'The is recommended of the tpo scenario record',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this TPO scenario record was most recently updated.',
    `tpo_scenario_name` STRING COMMENT 'The tpo scenario name of the tpo scenario record',
    `notes` STRING COMMENT 'Free-text field for additional comments, assumptions, constraints, or context relevant to this TPO scenario.',
    `optimization_objective` STRING COMMENT 'Primary business goal the TPO scenario is designed to achieve: maximize volume, maximize ROI, maximize GMROI, minimize out-of-stock events, maximize profit, or balanced growth.. Valid values are `maximize_volume|maximize_roi|maximize_gmroi|minimize_oos|maximize_profit|balanced_growth`',
    `planning_horizon_end_date` DATE COMMENT 'Last date of the planning period covered by this TPO scenario.',
    `planning_horizon_start_date` DATE COMMENT 'First date of the planning period covered by this TPO scenario.',
    `predicted_roi_percentage` DECIMAL(18,2) COMMENT 'The predicted roi percentage of the tpo scenario record',
    `predicted_spend_amount` DECIMAL(18,2) COMMENT 'The predicted spend amount of the tpo scenario record',
    `predicted_volume_units` DECIMAL(18,2) COMMENT 'The predicted volume units of the tpo scenario record',
    `projected_baseline_revenue` DECIMAL(18,2) COMMENT 'Forecasted gross revenue expected without promotional activity, serving as the baseline for incremental revenue calculation.',
    `projected_baseline_volume` DECIMAL(18,2) COMMENT 'Forecasted sales volume in units expected without any promotional activity, serving as the baseline for lift calculation.',
    `projected_gmroi` DECIMAL(18,2) COMMENT 'Expected gross margin return on investment, calculated as gross margin dollars generated per dollar of trade spend invested.',
    `projected_gross_profit` DECIMAL(18,2) COMMENT 'Forecasted gross profit (revenue minus COGS) expected from this TPO scenario after accounting for trade spend.',
    `projected_incremental_revenue` DECIMAL(18,2) COMMENT 'Additional gross revenue expected to be generated by the promotional activities in this scenario, above the baseline.',
    `projected_incremental_volume` DECIMAL(18,2) COMMENT 'Additional sales volume in units expected to be generated by the promotional activities defined in this TPO scenario, above the baseline.',
    `projected_promotional_lift_percentage` DECIMAL(18,2) COMMENT 'Expected percentage increase in sales volume compared to baseline, calculated as (incremental volume / baseline volume) * 100.',
    `projected_roi_pct` DECIMAL(18,2) COMMENT 'The projected roi pct of the tpo scenario record',
    `projected_roi_percentage` DECIMAL(18,2) COMMENT 'Expected return on investment expressed as a percentage, calculated as (incremental profit / total scenario spend) * 100.',
    `projected_total_revenue` DECIMAL(18,2) COMMENT 'Total forecasted gross revenue including both baseline and incremental revenue for this scenario.',
    `projected_total_volume` DECIMAL(18,2) COMMENT 'Total forecasted sales volume in units including both baseline and incremental volume for this scenario.',
    `projected_volume` DECIMAL(18,2) COMMENT 'The projected volume of the tpo scenario record',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the tpo scenario record',
    `region_code` STRING COMMENT 'Internal region code identifying the sales or geographic region this scenario covers.',
    `scenario_description` STRING COMMENT 'Detailed narrative describing the purpose, assumptions, and strategic intent of the TPO scenario.',
    `scenario_name` STRING COMMENT 'Descriptive name assigned to the TPO scenario for easy identification and reference by trade marketing teams.',
    `scenario_number` STRING COMMENT 'Business-facing unique identifier for the TPO scenario, typically system-generated with a TPO prefix.. Valid values are `^TPO-[0-9]{6,10}$`',
    `scenario_status` STRING COMMENT 'Current lifecycle state of the TPO scenario indicating its readiness for execution or decision-making.. Valid values are `draft|evaluated|approved|rejected|archived|in_review`',
    `scenario_type` STRING COMMENT 'The scenario type of the tpo scenario record',
    `source_system_code` STRING COMMENT 'The source system code of the tpo scenario record',
    `total_scenario_spend` DECIMAL(18,2) COMMENT 'Total trade promotion investment allocated across all promotions and accounts in this TPO scenario.',
    `tpm_system_reference_code` STRING COMMENT 'External identifier linking this TPO scenario to the source Trade Promotion Management system (e.g., Salesforce TPM, SAP TPM).',
    `tpo_scenario_status` STRING COMMENT 'The tpo scenario status of the tpo scenario record',
    `uom` STRING COMMENT 'The uom of the tpo scenario record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the tpo scenario record',
    `version_number` STRING COMMENT 'Sequential version number tracking iterations and revisions of this TPO scenario.',
    `volume_unit_of_measure` STRING COMMENT 'Unit of measure for all volume metrics in this scenario (units, cases, pallets, kg, liters).. Valid values are `units|cases|pallets|kg|liters`',
    CONSTRAINT pk_tpo_scenario PRIMARY KEY(`tpo_scenario_id`)
) COMMENT 'Master entity representing a Trade Promotion Optimization (TPO) scenario — a modeled alternative promotion plan generated to optimize trade spend ROI. Captures scenario name, optimization objective (maximize volume, maximize ROI, maximize GMROI, minimize OOS), scenario status (draft, evaluated, approved, rejected), total scenario spend, projected incremental volume, projected ROI, comparison baseline scenario reference, and analyst owner. Enables what-if planning and scenario comparison for trade investment decisions.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`promotion`.`retailer_compliance` (
    `retailer_compliance_id` BIGINT COMMENT 'Unique identifier for the retailer compliance record. Primary key for this transactional compliance audit entity.',
    `employee_id` BIGINT COMMENT 'Reference to the field sales representative or auditor who performed the compliance check. Enables accountability and audit trail for compliance assessments.',
    `promotion_event_id` BIGINT COMMENT 'The promotion event id of the retailer compliance record',
    `rd_project_id` BIGINT COMMENT 'Foreign key linking to research.rd_project. Business justification: Compliance checks for new product promotions are linked to the originating R&D project for traceability.',
    `retail_store_id` BIGINT COMMENT 'Reference to the specific retail store location where compliance was audited. Enables store-level compliance tracking and analysis.',
    `trade_account_id` BIGINT COMMENT 'Reference to the retailer or trade account whose compliance is being measured. Identifies the party responsible for executing the promotional mechanics.',
    `trade_promotion_id` BIGINT COMMENT 'Reference to the trade promotion event being audited for compliance. Links this compliance record to the parent promotional campaign.',
    `actual_retail_price` DECIMAL(18,2) COMMENT 'The actual price observed at the retail location during the compliance audit. Compared against agreed promotional price to determine price compliance.',
    `ad_feature_compliant_flag` BOOLEAN COMMENT 'Indicates whether the retailer included the promoted product in their feature advertisement or circular as agreed. True = compliant, False = non-compliant.',
    `agreed_promotional_price` DECIMAL(18,2) COMMENT 'The promotional price point that was contractually agreed between the manufacturer and retailer. Used as the benchmark for price compliance verification.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the retailer compliance record',
    `audit_date` DATE COMMENT 'The audit date of the retailer compliance record',
    `audit_method` STRING COMMENT 'The method used to verify compliance. Field rep visit = in-person store check by manufacturer sales team, third-party audit = independent compliance service, POS data analysis = automated analysis of retailer sales data, photo verification = photographic evidence submitted digitally, retailer self-report = retailer-provided compliance attestation.. Valid values are `field_rep_visit|third_party_audit|pos_data_analysis|photo_verification|retailer_self_report`',
    `auditor_name` STRING COMMENT 'The name of the field representative or third-party auditor who conducted the compliance check. Provides human-readable reference for audit accountability.',
    `retailer_compliance_code` STRING COMMENT 'The retailer compliance code of the retailer compliance record',
    `compliance_check_date` DATE COMMENT 'The date when the compliance audit or field check was performed. Represents the business event timestamp for this compliance observation.',
    `compliance_score` DECIMAL(18,2) COMMENT 'The compliance score of the retailer compliance record',
    `compliance_score_percentage` DECIMAL(18,2) COMMENT 'The overall compliance score expressed as a percentage (0.00 to 100.00). Represents the degree to which the retailer met the agreed promotional execution terms. Used for funding adjustments and future negotiation leverage.',
    `compliance_status` STRING COMMENT 'The overall compliance determination for this audit record. Compliant = all mechanics met, non-compliant = one or more mechanics failed, partial compliant = some mechanics met, pending review = audit submitted but not yet adjudicated, disputed = retailer has challenged the compliance finding.. Valid values are `compliant|non_compliant|partial_compliant|pending_review|disputed`',
    `compliance_type` STRING COMMENT 'The category of promotional mechanic being audited. Ad feature = retailer circular/flyer inclusion, display = in-store promotional display presence, price compliance = agreed promotional price point adherence, OSA = On Shelf Availability during promotion, POG placement = planogram compliance, multi-mechanic = combined audit.. Valid values are `ad_feature|display|price_compliance|osa|pog_placement|multi_mechanic`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this compliance record was first created in the system. Audit trail for data lineage and compliance reporting.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this compliance record (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `data_source` STRING COMMENT 'The system or channel from which this compliance record originated. SFA field audit = Salesforce mobile app, third-party service = external compliance vendor, POS integration = retailer point-of-sale data feed, retailer portal = retailer self-service submission, manual entry = back-office data entry.. Valid values are `sfa_field_audit|third_party_service|pos_integration|retailer_portal|manual_entry`',
    `data_source_reference_code` STRING COMMENT 'The unique identifier from the originating system (e.g., SFA visit ID, third-party audit ticket number, POS transaction batch ID). Enables traceability back to source system for dispute resolution.',
    `retailer_compliance_description` STRING COMMENT 'The retailer compliance description of the retailer compliance record',
    `display_compliant_flag` BOOLEAN COMMENT 'Indicates whether the retailer set up the agreed in-store promotional display (end cap, floor stand, shipper display). True = compliant, False = non-compliant.',
    `display_executed` BOOLEAN COMMENT 'The display executed of the retailer compliance record',
    `dispute_flag` BOOLEAN COMMENT 'Indicates whether the retailer has formally disputed this compliance assessment. True = dispute filed, False = no dispute. Disputed records feed deduction dispute resolution workflows.',
    `dispute_reason` STRING COMMENT 'Free-text explanation provided by the retailer for why they are disputing the compliance finding. Captures retailer perspective and supporting evidence for dispute resolution.',
    `effective_from` DATE COMMENT 'The effective from of the retailer compliance record',
    `effective_until` DATE COMMENT 'The effective until of the retailer compliance record',
    `funding_adjustment_amount` DECIMAL(18,2) COMMENT 'The net adjustment to trade spend funding based on compliance performance. Positive values indicate additional funding earned through over-compliance; negative values indicate funding clawback due to non-compliance.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this compliance record was last updated. Tracks changes due to dispute resolution, data corrections, or status updates.',
    `retailer_compliance_name` STRING COMMENT 'The retailer compliance name of the retailer compliance record',
    `non_compliance_category` STRING COMMENT 'Standardized classification of the non-compliance root cause. Enables aggregated analysis of compliance failure patterns across retailers and promotions.. Valid values are `inventory_shortage|pricing_error|display_not_built|ad_omission|operational_failure|system_error`',
    `non_compliance_reason` STRING COMMENT 'Free-text explanation of why the retailer failed to meet compliance requirements. Captures root cause details such as inventory shortage, operational error, pricing system failure, or deliberate non-execution.',
    `notes` STRING COMMENT 'Additional free-text observations or context from the auditor. May include qualitative details about store conditions, retailer cooperation, or extenuating circumstances affecting compliance.',
    `osa_compliant_flag` BOOLEAN COMMENT 'Indicates whether the promoted product was in stock and available on shelf during the promotional period. True = compliant (in stock), False = non-compliant (out of stock).',
    `penalty_amount` DECIMAL(18,2) COMMENT 'The financial penalty or funding adjustment applied due to non-compliance. May be deducted from retailer rebate or future funding allocations. Null if fully compliant.',
    `photo_evidence_url` STRING COMMENT 'URL or file path to photographic evidence captured during the compliance audit. Supports visual verification of display presence, pricing signage, shelf placement, and ad feature inclusion.',
    `pog_placement_compliant_flag` BOOLEAN COMMENT 'Indicates whether the product was placed according to the agreed planogram specifications (shelf position, facings, adjacency). True = compliant, False = non-compliant.',
    `price_compliant` BOOLEAN COMMENT 'The price compliant of the retailer compliance record',
    `price_compliant_flag` BOOLEAN COMMENT 'Indicates whether the retailer honored the agreed promotional price point (Hi-Lo or EDLP pricing strategy). True = compliant, False = non-compliant.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the retailer compliance record',
    `resolution_date` DATE COMMENT 'The date when a disputed compliance record was resolved or when final compliance determination was made. Null if still pending or not disputed.',
    `resolution_outcome` STRING COMMENT 'The final outcome of a disputed compliance record. Upheld = original non-compliance finding stands, overturned = retailer dispute accepted and compliance restored, partial adjustment = compromise reached with reduced penalty, withdrawn = manufacturer withdrew the compliance claim.. Valid values are `upheld|overturned|partial_adjustment|withdrawn`',
    `retailer_compliance_status` STRING COMMENT 'The retailer compliance status of the retailer compliance record',
    `source_system_code` STRING COMMENT 'The source system code of the retailer compliance record',
    `uom` STRING COMMENT 'The uom of the retailer compliance record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the retailer compliance record',
    CONSTRAINT pk_retailer_compliance PRIMARY KEY(`retailer_compliance_id`)
) COMMENT 'Transactional record capturing retailer execution compliance for a promotion event — whether the retailer delivered the agreed promotional mechanics (feature ad, display, price point, shelf placement per POG). Tracks compliance check date, compliance type (ad feature, display, price compliance, OSA), compliance score (%), non-compliance reason, penalty amount applied, auditor/field rep reference, and data source (SFA field audit, third-party compliance service). Feeds deduction dispute resolution and future funding negotiations.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`promotion`.`baseline_volume` (
    `baseline_volume_id` BIGINT COMMENT 'Unique identifier for the baseline volume record. Primary key for this entity.',
    `category_id` BIGINT COMMENT 'Foreign key reference to the product category for which baseline volume is calculated.',
    `channel_classification_id` BIGINT COMMENT 'Foreign key reference to the distribution channel for which the baseline volume is calculated (e.g., grocery, drug, mass, club, e-commerce).',
    `marketing_brand_id` BIGINT COMMENT 'Foreign key reference to the brand associated with the SKU for which baseline volume is calculated.',
    `employee_id` BIGINT COMMENT 'Foreign key reference to the user who performed the manual override of the baseline estimate.',
    `sku_id` BIGINT COMMENT 'Foreign key reference to the SKU for which baseline volume is calculated.',
    `tertiary_baseline_created_by_user_employee_id` BIGINT COMMENT 'Foreign key reference to the user who created this baseline volume record.',
    `trade_account_id` BIGINT COMMENT 'Foreign key reference to the retailer or trade account for which baseline volume is calculated.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the baseline volume record',
    `analyst_override_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the baseline volume estimate was manually overridden by an analyst (True) or is system-generated (False).',
    `approval_date` DATE COMMENT 'The date when the baseline volume estimate was approved for use in promotional lift calculations.',
    `baseline_method` STRING COMMENT 'The baseline method of the baseline volume record',
    `baseline_methodology` STRING COMMENT 'The statistical methodology used to calculate the baseline volume estimate (e.g., moving average, regression, Nielsen IQ panel, Bayesian structural time series).. Valid values are `moving_average|regression|nielsen_iq_panel|bayesian_structural_time_series|exponential_smoothing|seasonal_decomposition`',
    `baseline_period` STRING COMMENT 'The baseline period of the baseline volume record',
    `baseline_period_end_date` DATE COMMENT 'The end date of the period for which this baseline volume estimate applies.',
    `baseline_period_start_date` DATE COMMENT 'The start date of the period for which this baseline volume estimate applies.',
    `baseline_revenue_amount` DECIMAL(18,2) COMMENT 'The estimated baseline revenue for the SKU-retailer-period combination at regular pricing, absent promotional activity.',
    `baseline_status` STRING COMMENT 'The current lifecycle status of the baseline volume record (e.g., draft, approved, active, archived, superseded, rejected).. Valid values are `draft|approved|active|archived|superseded|rejected`',
    `baseline_units` DECIMAL(18,2) COMMENT 'The baseline units of the baseline volume record',
    `baseline_volume_status` STRING COMMENT 'The baseline volume status of the baseline volume record',
    `calculation_method` STRING COMMENT 'The calculation method of the baseline volume record',
    `calculation_timestamp` TIMESTAMP COMMENT 'The date and time when the baseline volume calculation was performed.',
    `cases` DECIMAL(18,2) COMMENT 'The estimated baseline sales volume in cases, representing expected sales absent any promotional activity.',
    `baseline_volume_code` STRING COMMENT 'The baseline volume code of the baseline volume record',
    `confidence_interval_lower` DECIMAL(18,2) COMMENT 'The lower bound of the confidence interval for the baseline volume estimate, representing statistical uncertainty.',
    `confidence_interval_upper` DECIMAL(18,2) COMMENT 'The upper bound of the confidence interval for the baseline volume estimate, representing statistical uncertainty.',
    `confidence_level_percent` DECIMAL(18,2) COMMENT 'The confidence level percentage for the confidence interval (e.g., 95.00 for 95% confidence).',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this baseline volume record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the baseline revenue amount.. Valid values are `^[A-Z]{3}$`',
    `data_source` STRING COMMENT 'The source system or data provider from which the baseline calculation data was obtained (e.g., POS, Nielsen IQ, IRI, internal sales, TradeEdge).. Valid values are `pos|nielsen_iq|iri|internal_sales|trade_edge|syndicated_panel`',
    `baseline_volume_description` STRING COMMENT 'The baseline volume description of the baseline volume record',
    `effective_from` DATE COMMENT 'The effective from of the baseline volume record',
    `effective_until` DATE COMMENT 'The effective until of the baseline volume record',
    `geography_code` STRING COMMENT 'Three-letter ISO country code or geographic region code for which the baseline volume applies.. Valid values are `^[A-Z]{3}$`',
    `historical_lookback_weeks` STRING COMMENT 'The number of historical weeks of data used in the baseline volume calculation methodology.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this baseline volume record was last modified.',
    `last_refresh_date` DATE COMMENT 'The date when the baseline volume estimate was last refreshed or recalculated.',
    `model_accuracy_score` DECIMAL(18,2) COMMENT 'A statistical measure of the baseline model accuracy, such as R-squared or Mean Absolute Percentage Error (MAPE), represented as a decimal value.',
    `model_version` STRING COMMENT 'The version identifier of the baseline calculation model or algorithm used to generate this estimate.',
    `baseline_volume_name` STRING COMMENT 'The baseline volume name of the baseline volume record',
    `notes` STRING COMMENT 'Free-text field for additional comments, observations, or context related to the baseline volume calculation.',
    `outlier_exclusion_flag` BOOLEAN COMMENT 'Boolean flag indicating whether statistical outliers were excluded from the baseline calculation (True) or included (False).',
    `override_reason` STRING COMMENT 'The business justification or reason provided by the analyst for manually overriding the system-generated baseline estimate.',
    `override_timestamp` TIMESTAMP COMMENT 'The date and time when the analyst override was applied to the baseline estimate.',
    `period_end_date` DATE COMMENT 'The period end date of the baseline volume record',
    `period_start` DATE COMMENT 'The period start of the baseline volume record',
    `period_start_date` DATE COMMENT 'The period start date of the baseline volume record',
    `promotional_periods_excluded_count` STRING COMMENT 'The number of promotional periods that were excluded from the historical data when calculating the baseline volume.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the baseline volume record',
    `seasonality_adjustment_factor` DECIMAL(18,2) COMMENT 'The multiplicative factor applied to adjust for seasonal patterns in the baseline volume calculation.',
    `source_system_code` STRING COMMENT 'The source system code of the baseline volume record',
    `tpm_system_reference_code` STRING COMMENT 'External reference identifier from the source Trade Promotion Management system (e.g., Salesforce TPM) for traceability.',
    `trend_adjustment_factor` DECIMAL(18,2) COMMENT 'The multiplicative factor applied to adjust for long-term trend patterns in the baseline volume calculation.',
    `units` DECIMAL(18,2) COMMENT 'The estimated baseline sales volume in units, representing expected sales absent any promotional activity.',
    `uom` STRING COMMENT 'The uom of the baseline volume record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the baseline volume record',
    CONSTRAINT pk_baseline_volume PRIMARY KEY(`baseline_volume_id`)
) COMMENT 'Transactional record capturing the statistical baseline volume estimate for a SKU-retailer-period combination, representing expected sales absent any promotional activity. Stores baseline volume (units/cases), baseline revenue, baseline methodology (moving average, regression, Nielsen IQ panel, Bayesian structural time series), data source, baseline period, confidence interval, last refresh date, analyst override flag, and model version. Serves as the reusable baseline denominator consumed by post_event_analysis for incremental lift calculation across all promotion events. Maintained independently of any single promotion event to enable consistent cross-event comparison and baseline trend monitoring.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`promotion`.`pos_redemption` (
    `pos_redemption_id` BIGINT COMMENT 'Unique identifier for the point-of-sale redemption transaction record.',
    `consumer_offer_id` BIGINT COMMENT 'The consumer offer id of the pos redemption record',
    `employee_id` BIGINT COMMENT 'Identifier for the cashier or associate who processed the redemption transaction.',
    `loyalty_account_id` BIGINT COMMENT 'Identifier for the retailer or manufacturer loyalty account used during redemption.',
    `promotion_event_id` BIGINT COMMENT 'Identifier linking this redemption to the specific promotion event that authorized the offer.',
    `retail_store_id` BIGINT COMMENT 'Identifier for the specific retail store location where the redemption took place.',
    `shopper_id` BIGINT COMMENT 'Identifier for the shopper who redeemed the offer, if captured through loyalty program or digital account.',
    `sku_id` BIGINT COMMENT 'Identifier for the SKU that was purchased with the promotional offer.',
    `trade_account_id` BIGINT COMMENT 'Identifier for the retail trade account where the redemption occurred.',
    `trade_promotion_id` BIGINT COMMENT 'The trade promotion id of the pos redemption record',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the pos redemption record',
    `channel` STRING COMMENT 'The channel of the pos redemption record',
    `clearinghouse_name` STRING COMMENT 'Name of the coupon clearinghouse that processed the manufacturer coupon redemption, if applicable.',
    `clearinghouse_transaction_code` STRING COMMENT 'Transaction identifier assigned by the coupon clearinghouse for tracking and settlement.',
    `pos_redemption_code` STRING COMMENT 'The pos redemption code of the pos redemption record',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code where the redemption occurred.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this redemption record was first created in the data product.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the redemption value amount.. Valid values are `^[A-Z]{3}$`',
    `data_received_timestamp` TIMESTAMP COMMENT 'Timestamp when the redemption data was received from the source system or data feed.',
    `data_source` STRING COMMENT 'Source system or data feed from which the redemption record was received.. Valid values are `edi_844|edi_849|retailer_pos_feed|coupon_clearinghouse|tpm_system|e_commerce_platform`',
    `pos_redemption_description` STRING COMMENT 'The pos redemption description of the pos redemption record',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Percentage discount applied to the regular price through the promotional offer.',
    `effective_from` DATE COMMENT 'The effective from of the pos redemption record',
    `effective_until` DATE COMMENT 'The effective until of the pos redemption record',
    `gtin` STRING COMMENT 'Global Trade Item Number identifying the product redeemed, may be GTIN-8, GTIN-12, GTIN-13, or GTIN-14 format.. Valid values are `^[0-9]{8,14}$`',
    `handling_fee_amount` DECIMAL(18,2) COMMENT 'Handling fee paid to the retailer or clearinghouse for processing the coupon redemption.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this redemption record was last updated or modified.',
    `pos_redemption_name` STRING COMMENT 'The pos redemption name of the pos redemption record',
    `notes` STRING COMMENT 'Additional notes or comments regarding the redemption transaction, validation, or settlement.',
    `offer_code` STRING COMMENT 'Unique code identifying the specific promotional offer redeemed (coupon code, digital offer ID, loyalty reward code).',
    `offer_type` STRING COMMENT 'Classification of the promotional offer type that was redeemed.. Valid values are `manufacturer_coupon|retailer_coupon|digital_offer|loyalty_reward|scan_back_discount|instant_rebate`',
    `pos_redemption_status` STRING COMMENT 'The pos redemption status of the pos redemption record',
    `pos_terminal_code` STRING COMMENT 'Identifier for the POS terminal or register where the redemption was processed.',
    `promoted_unit_price` DECIMAL(18,2) COMMENT 'Final unit price paid by the consumer after the promotional discount was applied.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the pos redemption record',
    `redemption_channel` STRING COMMENT 'The sales channel through which the redemption occurred.. Valid values are `in_store|e_commerce|dtc|mobile_app|call_center`',
    `redemption_count` STRING COMMENT 'The redemption count of the pos redemption record',
    `redemption_date` DATE COMMENT 'The date when the promotional offer was redeemed at point of sale.',
    `redemption_quantity` DECIMAL(18,2) COMMENT 'Number of units of the SKU purchased with the promotional offer applied.',
    `redemption_status` STRING COMMENT 'Current processing status of the redemption record in the settlement workflow.. Valid values are `validated|pending_validation|rejected|settled|disputed`',
    `redemption_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the redemption occurred at the point of sale, including time zone information.',
    `redemption_transaction_number` STRING COMMENT 'Business identifier for the redemption transaction, typically sourced from retailer POS system or coupon clearinghouse.',
    `redemption_value` DECIMAL(18,2) COMMENT 'The redemption value of the pos redemption record',
    `redemption_value_amount` DECIMAL(18,2) COMMENT 'Total monetary value of the discount or savings provided through the redemption.',
    `region_code` STRING COMMENT 'Geographic region or market code where the redemption took place.',
    `regular_unit_price` DECIMAL(18,2) COMMENT 'Regular shelf price per unit before the promotional discount was applied.',
    `rejection_reason` STRING COMMENT 'Explanation for why the redemption was rejected during validation, if applicable.',
    `settlement_amount` DECIMAL(18,2) COMMENT 'Amount paid by the manufacturer to the retailer or clearinghouse for this redemption.',
    `settlement_date` DATE COMMENT 'Date when the redemption was financially settled between manufacturer and retailer or clearinghouse.',
    `source_system_code` STRING COMMENT 'The source system code of the pos redemption record',
    `transaction_total_amount` DECIMAL(18,2) COMMENT 'Total transaction amount for the basket or order containing the redeemed offer.',
    `unit_discount_amount` DECIMAL(18,2) COMMENT 'Discount amount applied per unit of the SKU redeemed.',
    `uom` STRING COMMENT 'The uom of the pos redemption record',
    `upc` STRING COMMENT '12-digit Universal Product Code scanned at point of sale for the redeemed product.. Valid values are `^[0-9]{12}$`',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the pos redemption record',
    `validation_flag` BOOLEAN COMMENT 'Indicates whether the redemption has been validated against promotion rules and eligibility criteria.',
    `validation_timestamp` TIMESTAMP COMMENT 'Timestamp when the redemption record was validated or rejected.',
    CONSTRAINT pk_pos_redemption PRIMARY KEY(`pos_redemption_id`)
) COMMENT 'Transactional record capturing point-of-sale redemption data for consumer-facing promotional offers (coupons, scan-back discounts, loyalty rewards, digital offers). Tracks redemption date, retailer store, SKU, redemption quantity, redemption value, offer type (manufacturer coupon, retailer coupon, digital offer, loyalty reward), redemption channel (in-store, e-commerce, DTC), and data source (EDI 844/849, retailer POS feed, coupon clearinghouse). Enables consumer promotion ROI and redemption rate tracking.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`promotion`.`consumer_offer` (
    `consumer_offer_id` BIGINT COMMENT 'Unique identifier for the consumer-facing promotional offer. Primary key.',
    `campaign_id` BIGINT COMMENT 'Identifier of the broader marketing campaign that this consumer offer supports. Links to the marketing campaign entity. Null if not part of a campaign.',
    `category_id` BIGINT COMMENT 'Identifier of the product category associated with this consumer offer. Links to the product category master data entity.',
    `marketing_brand_id` BIGINT COMMENT 'Identifier of the brand associated with this consumer offer. Links to the brand master data entity.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who approved this consumer offer. Links to the user or employee master data entity. Null if not yet approved.',
    `promotion_event_id` BIGINT COMMENT 'The promotion event id of the consumer offer record',
    `segment_id` BIGINT COMMENT 'Foreign key linking to consumer.consumer_segment. Business justification: Required for Offer‑to‑Segment targeting report; marketers need to join offers with consumer segments to measure lift and compliance.',
    `trade_promotion_id` BIGINT COMMENT 'Identifier of the parent trade promotion program that this consumer offer is part of. Links to the trade promotion entity. Null if offer is standalone.',
    `actual_cost_incurred` DECIMAL(18,2) COMMENT 'Actual total cost incurred from all redemptions of this offer to date. Used for budget variance analysis and financial reconciliation.',
    `actual_redemption_count` STRING COMMENT 'Actual number of times this offer has been redeemed by consumers to date. Updated in near real-time from POS (Point of Sale) and e-commerce systems.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the consumer offer record',
    `approval_status` STRING COMMENT 'Current approval status of the consumer offer in the governance workflow. Pending = awaiting review; Approved = authorized for activation; Rejected = not approved.. Valid values are `pending|approved|rejected`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the consumer offer was approved. Null if not yet approved.',
    `barcode` STRING COMMENT 'Barcode value associated with the consumer offer for scanning at POS (Point of Sale). May be UPC (Universal Product Code), EAN (European Article Number), or proprietary coupon barcode format.',
    `consumer_offer_code` STRING COMMENT 'The consumer offer code of the consumer offer record',
    `consumer_offer_status` STRING COMMENT 'The consumer offer status of the consumer offer record',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code where the offer is valid (e.g., USA, CAN, GBR).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this consumer offer record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the discount value (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `consumer_offer_description` STRING COMMENT 'Detailed description of the consumer offer including terms, conditions, and value proposition. Used for consumer communication and internal reference.',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Percentage discount applied to qualifying purchase. Null if discount is fixed-value based. Expressed as decimal (e.g., 15.00 for 15% off).',
    `discount_value` DECIMAL(18,2) COMMENT 'Fixed monetary discount amount provided by the offer in the specified currency. Null if discount is percentage-based.',
    `distribution_channel` STRING COMMENT 'Primary channel through which the consumer offer is distributed. FSI = Free Standing Insert (newspaper); Digital = online/web; In-Store = physical retail location; DTC App = Direct-to-Consumer mobile application; Email = email marketing; Social Media = social platforms; POS = Point of Sale display. [ENUM-REF-CANDIDATE: fsi|digital|in_store|dtc_app|email|social_media|pos — 7 candidates stripped; promote to reference product]',
    `effective_from` DATE COMMENT 'The effective from of the consumer offer record',
    `effective_until` DATE COMMENT 'The effective until of the consumer offer record',
    `end_date` DATE COMMENT 'The end date of the consumer offer record',
    `estimated_cost_per_redemption` DECIMAL(18,2) COMMENT 'Projected cost to the business for each redemption of this offer, including discount value and administrative costs. Used for budget planning and ROI (Return on Investment) analysis.',
    `funding_source` STRING COMMENT 'Entity responsible for funding the consumer offer discount. Brand = manufacturer-funded; Trade = trade promotion budget; Co-op = cooperative funding between manufacturer and retailer; Retailer = retailer-funded.. Valid values are `brand|trade|co_op|retailer`',
    `geographic_scope` STRING COMMENT 'Geographic reach of the consumer offer. National = available across entire country; Regional = specific regions or states; Local = specific cities or markets; Store-Specific = individual retail locations.. Valid values are `national|regional|local|store_specific`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this consumer offer record was last modified in the system.',
    `max_redemptions` STRING COMMENT 'The max redemptions of the consumer offer record',
    `maximum_redemption_per_customer` STRING COMMENT 'Maximum number of times a single customer can redeem this offer during the validity period. Null indicates unlimited redemptions.',
    `minimum_purchase_amount` DECIMAL(18,2) COMMENT 'Minimum purchase value required to qualify for the offer. Null if no minimum purchase requirement exists.',
    `minimum_purchase_quantity` STRING COMMENT 'Minimum number of qualifying units or SKUs (Stock Keeping Units) that must be purchased to redeem the offer. Null if no quantity requirement exists.',
    `consumer_offer_name` STRING COMMENT 'The consumer offer name of the consumer offer record',
    `notes` STRING COMMENT 'The notes of the consumer offer record',
    `offer_code` STRING COMMENT 'Unique alphanumeric code assigned to the consumer offer for redemption tracking and identification. Used by consumers at point of sale or digital checkout.. Valid values are `^[A-Z0-9]{6,20}$`',
    `offer_end_date` DATE COMMENT 'The offer end date of the consumer offer record',
    `offer_name` STRING COMMENT 'Marketing name or title of the consumer offer as displayed to consumers in promotional materials and digital channels.',
    `offer_start_date` DATE COMMENT 'The offer start date of the consumer offer record',
    `offer_status` STRING COMMENT 'Current lifecycle status of the consumer offer. Draft = under development; Approved = ready for activation; Active = currently redeemable; Paused = temporarily suspended; Expired = validity period ended; Cancelled = terminated before expiration.. Valid values are `draft|approved|active|paused|expired|cancelled`',
    `offer_type` STRING COMMENT 'Classification of the consumer offer mechanism. Coupon = physical or digital coupon; Digital Offer = app-based or online promotion; Loyalty Reward = points-based redemption; Instant Rebate = immediate price reduction; Free Goods = complimentary product with purchase; BOGO = Buy One Get One; Bundle Discount = multi-product savings. [ENUM-REF-CANDIDATE: coupon|digital_offer|loyalty_reward|instant_rebate|free_goods|bogo|bundle_discount — 7 candidates stripped; promote to reference product]',
    `offer_value` DECIMAL(18,2) COMMENT 'The offer value of the consumer offer record',
    `qualifying_sku_list` STRING COMMENT 'Comma-separated list of SKU identifiers or product codes that qualify for this offer. May reference specific products, product families, or categories. Null if offer applies to all products.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the consumer offer record',
    `redemption_channel` STRING COMMENT 'Channel where the consumer can redeem the offer. In-Store = physical retail; Online = e-commerce website; Mobile App = DTC (Direct-to-Consumer) mobile application; Call Center = phone order; Any = omnichannel redemption allowed.. Valid values are `in_store|online|mobile_app|call_center|any`',
    `redemption_limit` STRING COMMENT 'The redemption limit of the consumer offer record',
    `source_system_code` STRING COMMENT 'The source system code of the consumer offer record',
    `stackable_flag` BOOLEAN COMMENT 'Indicates whether this offer can be combined with other offers or promotions. True = can be stacked; False = exclusive offer.',
    `start_date` DATE COMMENT 'The start date of the consumer offer record',
    `terms_and_conditions` STRING COMMENT 'Full legal terms and conditions governing the use and redemption of this consumer offer. Includes restrictions, exclusions, and compliance requirements.',
    `total_budget_allocated` DECIMAL(18,2) COMMENT 'Total budget amount allocated for this consumer offer across all redemptions. Used for financial planning and spend tracking.',
    `total_redemption_limit` STRING COMMENT 'Maximum total number of redemptions allowed across all customers for this offer. Null indicates no aggregate limit.',
    `transferable_flag` BOOLEAN COMMENT 'Indicates whether the offer can be transferred or shared between consumers. True = transferable; False = non-transferable, tied to original recipient.',
    `uom` STRING COMMENT 'The uom of the consumer offer record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the consumer offer record',
    `valid_from_date` DATE COMMENT 'Start date when the consumer offer becomes active and redeemable. Consumers cannot redeem the offer before this date.',
    `valid_to_date` DATE COMMENT 'End date when the consumer offer expires and is no longer redeemable. Consumers cannot redeem the offer after this date.',
    CONSTRAINT pk_consumer_offer PRIMARY KEY(`consumer_offer_id`)
) COMMENT 'Master entity defining consumer-facing promotional offers (coupons, digital offers, loyalty rewards, instant rebates, free goods with purchase) that are part of a trade promotion or brand marketing program. Captures offer code, offer type, offer description, discount value/percentage, qualifying SKUs, minimum purchase requirement, offer validity period, distribution channel (FSI, digital, in-store, DTC app), maximum redemption limit, and offer status. Distinct from trade funding — this entity owns the consumer-facing offer definition.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`promotion`.`flight_allocation` (
    `flight_allocation_id` BIGINT COMMENT 'Primary key for the promotion_flight_allocation association',
    `campaign_flight_id` BIGINT COMMENT 'Foreign key linking to the campaign_flight',
    `promotion_event_id` BIGINT COMMENT 'Foreign key linking to the promotion_event',
    `trade_account_id` BIGINT COMMENT 'The trade account id of the flight allocation record',
    `trade_promotion_id` BIGINT COMMENT 'The trade promotion id of the flight allocation record',
    `actual_spend_amount` DECIMAL(18,2) COMMENT 'The actual spend amount of the flight allocation record',
    `actual_volume_units` DECIMAL(18,2) COMMENT 'Realized sales volume for the promotion_event under this campaign_flight',
    `allocated_amount` DECIMAL(18,2) COMMENT 'The allocated amount of the flight allocation record',
    `allocated_budget_amount` DECIMAL(18,2) COMMENT 'The allocated budget amount of the flight allocation record',
    `allocated_spend_amount` DECIMAL(18,2) COMMENT 'Spend allocated to this promotion_event within the specific campaign_flight',
    `allocated_volume_units` DECIMAL(18,2) COMMENT 'The allocated volume units of the flight allocation record',
    `allocation_end_date` DATE COMMENT 'The allocation end date of the flight allocation record',
    `allocation_method` STRING COMMENT 'The allocation method of the flight allocation record',
    `allocation_name` STRING COMMENT 'The allocation name of the flight allocation record',
    `allocation_pct` DECIMAL(18,2) COMMENT 'The allocation pct of the flight allocation record',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'The allocation percentage of the flight allocation record',
    `allocation_start_date` DATE COMMENT 'The allocation start date of the flight allocation record',
    `allocation_status` STRING COMMENT 'The allocation status of the flight allocation record',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the flight allocation record',
    `flight_allocation_code` STRING COMMENT 'The flight allocation code of the flight allocation record',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the flight allocation record',
    `currency_code` STRING COMMENT 'The currency code of the flight allocation record',
    `flight_allocation_description` STRING COMMENT 'The flight allocation description of the flight allocation record',
    `effective_from` DATE COMMENT 'The effective from of the flight allocation record',
    `effective_until` DATE COMMENT 'The effective until of the flight allocation record',
    `flight_allocation_status` STRING COMMENT 'The flight allocation status of the flight allocation record',
    `flight_end_date` DATE COMMENT 'The flight end date of the flight allocation record',
    `flight_name` STRING COMMENT 'The flight name of the flight allocation record',
    `flight_sequence` STRING COMMENT 'The flight sequence of the flight allocation record',
    `flight_start_date` DATE COMMENT 'The flight start date of the flight allocation record',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The last updated timestamp of the flight allocation record',
    `flight_allocation_name` STRING COMMENT 'The flight allocation name of the flight allocation record',
    `notes` STRING COMMENT 'The notes of the flight allocation record',
    `planned_volume_units` DECIMAL(18,2) COMMENT 'Forecasted sales volume for the promotion_event under this campaign_flight',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the flight allocation record',
    `source_system_code` STRING COMMENT 'The source system code of the flight allocation record',
    `uom` STRING COMMENT 'The uom of the flight allocation record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the flight allocation record',
    CONSTRAINT pk_flight_allocation PRIMARY KEY(`flight_allocation_id`)
) COMMENT 'This association captures the allocation of a promotion_event to a campaign_flight, including spend and volume metrics that are specific to the event‑flight pairing. Each record links one promotion_event to one campaign_flight and stores attributes that exist only in the context of this relationship.. Existence Justification: A promotion_event represents a specific trade promotion execution at a retailer/store, while a campaign_flight represents a media flight for a marketing campaign. In practice, a single promotion_event can be linked to multiple campaign_flights (e.g., the same in‑store promotion is supported by TV, digital, and print flights), and a single campaign_flight can include many promotion_events across different retailers. The business tracks allocation of spend and volume per promotion_event‑flight pair, which is managed by planners as a distinct record.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_event` ADD CONSTRAINT `fk_promotion_promotion_event_trade_promotion_id` FOREIGN KEY (`trade_promotion_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`trade_promotion`(`trade_promotion_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ADD CONSTRAINT `fk_promotion_event_sku_promotion_event_id` FOREIGN KEY (`promotion_event_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`promotion_event`(`promotion_event_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ADD CONSTRAINT `fk_promotion_event_sku_funding_agreement_id` FOREIGN KEY (`funding_agreement_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`funding_agreement`(`funding_agreement_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ADD CONSTRAINT `fk_promotion_trade_calendar_parent_calendar_trade_calendar_id` FOREIGN KEY (`parent_calendar_trade_calendar_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`trade_calendar`(`trade_calendar_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ADD CONSTRAINT `fk_promotion_trade_spend_allocation_funding_agreement_id` FOREIGN KEY (`funding_agreement_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`funding_agreement`(`funding_agreement_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ADD CONSTRAINT `fk_promotion_trade_spend_allocation_promotion_event_id` FOREIGN KEY (`promotion_event_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`promotion_event`(`promotion_event_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ADD CONSTRAINT `fk_promotion_trade_spend_allocation_trade_promotion_id` FOREIGN KEY (`trade_promotion_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`trade_promotion`(`trade_promotion_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ADD CONSTRAINT `fk_promotion_funding_agreement_previous_agreement_funding_agreement_id` FOREIGN KEY (`previous_agreement_funding_agreement_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`funding_agreement`(`funding_agreement_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_accrual` ADD CONSTRAINT `fk_promotion_promotion_accrual_promotion_event_id` FOREIGN KEY (`promotion_event_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`promotion_event`(`promotion_event_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_accrual` ADD CONSTRAINT `fk_promotion_promotion_accrual_trade_promotion_id` FOREIGN KEY (`trade_promotion_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`trade_promotion`(`trade_promotion_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_deduction` ADD CONSTRAINT `fk_promotion_promotion_deduction_funding_agreement_id` FOREIGN KEY (`funding_agreement_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`funding_agreement`(`funding_agreement_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_deduction` ADD CONSTRAINT `fk_promotion_promotion_deduction_promotion_event_id` FOREIGN KEY (`promotion_event_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`promotion_event`(`promotion_event_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_deduction` ADD CONSTRAINT `fk_promotion_promotion_deduction_trade_promotion_id` FOREIGN KEY (`trade_promotion_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`trade_promotion`(`trade_promotion_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ADD CONSTRAINT `fk_promotion_deduction_settlement_funding_agreement_id` FOREIGN KEY (`funding_agreement_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`funding_agreement`(`funding_agreement_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ADD CONSTRAINT `fk_promotion_deduction_settlement_parent_settlement_deduction_settlement_id` FOREIGN KEY (`parent_settlement_deduction_settlement_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement`(`deduction_settlement_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ADD CONSTRAINT `fk_promotion_deduction_settlement_promotion_deduction_id` FOREIGN KEY (`promotion_deduction_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`promotion_deduction`(`promotion_deduction_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`rebate_settlement` ADD CONSTRAINT `fk_promotion_rebate_settlement_promotion_rebate_agreement_id` FOREIGN KEY (`promotion_rebate_agreement_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`promotion_rebate_agreement`(`promotion_rebate_agreement_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`post_event_analysis` ADD CONSTRAINT `fk_promotion_post_event_analysis_promotion_event_id` FOREIGN KEY (`promotion_event_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`promotion_event`(`promotion_event_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`post_event_analysis` ADD CONSTRAINT `fk_promotion_post_event_analysis_trade_promotion_id` FOREIGN KEY (`trade_promotion_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`trade_promotion`(`trade_promotion_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ADD CONSTRAINT `fk_promotion_promoted_price_event_sku_id` FOREIGN KEY (`event_sku_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`event_sku`(`event_sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ADD CONSTRAINT `fk_promotion_promoted_price_promotion_event_id` FOREIGN KEY (`promotion_event_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`promotion_event`(`promotion_event_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ADD CONSTRAINT `fk_promotion_promoted_price_trade_promotion_id` FOREIGN KEY (`trade_promotion_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`trade_promotion`(`trade_promotion_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`lift_measurement` ADD CONSTRAINT `fk_promotion_lift_measurement_promotion_event_id` FOREIGN KEY (`promotion_event_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`promotion_event`(`promotion_event_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`lift_measurement` ADD CONSTRAINT `fk_promotion_lift_measurement_trade_promotion_id` FOREIGN KEY (`trade_promotion_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`trade_promotion`(`trade_promotion_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`tpo_scenario` ADD CONSTRAINT `fk_promotion_tpo_scenario_parent_scenario_tpo_scenario_id` FOREIGN KEY (`parent_scenario_tpo_scenario_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`tpo_scenario`(`tpo_scenario_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`tpo_scenario` ADD CONSTRAINT `fk_promotion_tpo_scenario_trade_calendar_id` FOREIGN KEY (`trade_calendar_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`trade_calendar`(`trade_calendar_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`tpo_scenario` ADD CONSTRAINT `fk_promotion_tpo_scenario_trade_promotion_id` FOREIGN KEY (`trade_promotion_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`trade_promotion`(`trade_promotion_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`retailer_compliance` ADD CONSTRAINT `fk_promotion_retailer_compliance_promotion_event_id` FOREIGN KEY (`promotion_event_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`promotion_event`(`promotion_event_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`retailer_compliance` ADD CONSTRAINT `fk_promotion_retailer_compliance_trade_promotion_id` FOREIGN KEY (`trade_promotion_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`trade_promotion`(`trade_promotion_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`pos_redemption` ADD CONSTRAINT `fk_promotion_pos_redemption_consumer_offer_id` FOREIGN KEY (`consumer_offer_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`consumer_offer`(`consumer_offer_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`pos_redemption` ADD CONSTRAINT `fk_promotion_pos_redemption_promotion_event_id` FOREIGN KEY (`promotion_event_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`promotion_event`(`promotion_event_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`pos_redemption` ADD CONSTRAINT `fk_promotion_pos_redemption_trade_promotion_id` FOREIGN KEY (`trade_promotion_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`trade_promotion`(`trade_promotion_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`consumer_offer` ADD CONSTRAINT `fk_promotion_consumer_offer_promotion_event_id` FOREIGN KEY (`promotion_event_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`promotion_event`(`promotion_event_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`consumer_offer` ADD CONSTRAINT `fk_promotion_consumer_offer_trade_promotion_id` FOREIGN KEY (`trade_promotion_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`trade_promotion`(`trade_promotion_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`flight_allocation` ADD CONSTRAINT `fk_promotion_flight_allocation_promotion_event_id` FOREIGN KEY (`promotion_event_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`promotion_event`(`promotion_event_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`flight_allocation` ADD CONSTRAINT `fk_promotion_flight_allocation_trade_promotion_id` FOREIGN KEY (`trade_promotion_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`trade_promotion`(`trade_promotion_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_consumer_goods_v1`.`promotion` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_consumer_goods_v1`.`promotion` SET TAGS ('dbx_domain' = 'promotion');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` SET TAGS ('dbx_subdomain' = 'trade_planning');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `trade_promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Promotion ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Product Category ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `owner_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Owner User ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `owner_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `owner_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `primary_trade_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `primary_trade_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `primary_trade_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Account ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `accrual_amount` SET TAGS ('dbx_business_glossary_term' = 'Trade Promotion Accrual Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `accrual_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `actual_spend` SET TAGS ('dbx_business_glossary_term' = 'Actual Spend');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Promotion Approval Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `authorized_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Authorized Trade Spend Budget Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `authorized_budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `baseline_volume_units` SET TAGS ('dbx_business_glossary_term' = 'Baseline Volume Units');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `baseline_volume_units` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `channel_type` SET TAGS ('dbx_business_glossary_term' = 'Retail Channel Type');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `channel_type` SET TAGS ('dbx_value_regex' = 'grocery|mass_merchandiser|drug|convenience|club|ecommerce');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `trade_promotion_code` SET TAGS ('dbx_business_glossary_term' = 'Trade Promotion Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `coupon_flag` SET TAGS ('dbx_business_glossary_term' = 'Coupon Included Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `deduction_amount` SET TAGS ('dbx_business_glossary_term' = 'Trade Promotion Deduction Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `deduction_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `trade_promotion_description` SET TAGS ('dbx_business_glossary_term' = 'Trade Promotion Description');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `discount_pct` SET TAGS ('dbx_business_glossary_term' = 'Discount Pct');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Promotional Discount Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `display_type` SET TAGS ('dbx_business_glossary_term' = 'In-Store Display Type');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `display_type` SET TAGS ('dbx_value_regex' = 'end_cap|free_standing|shelf_talker|pallet|cooler|none');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Promotion End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `expected_roi_percentage` SET TAGS ('dbx_business_glossary_term' = 'Expected Return on Investment (ROI) Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `expected_roi_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `feature_ad_flag` SET TAGS ('dbx_business_glossary_term' = 'Feature Advertisement Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `funding_type` SET TAGS ('dbx_business_glossary_term' = 'Trade Promotion Funding Type');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `funding_type` SET TAGS ('dbx_value_regex' = 'off_invoice|scan_back|bill_back|lump_sum|accrual');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_value_regex' = 'national|regional|local|store_specific');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `maximum_purchase_quantity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Purchase Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `mechanic_type` SET TAGS ('dbx_business_glossary_term' = 'Mechanic Type');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `minimum_purchase_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Purchase Quantity (MOQ)');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `trade_promotion_name` SET TAGS ('dbx_business_glossary_term' = 'Trade Promotion Name');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Promotion Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `planned_spend` SET TAGS ('dbx_business_glossary_term' = 'Planned Spend');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `planned_volume` SET TAGS ('dbx_business_glossary_term' = 'Planned Volume');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `pricing_strategy` SET TAGS ('dbx_business_glossary_term' = 'Pricing Strategy Classification');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `pricing_strategy` SET TAGS ('dbx_value_regex' = 'hi_lo|edlp|hybrid');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `promotion_name` SET TAGS ('dbx_business_glossary_term' = 'Trade Promotion Name');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `promotion_number` SET TAGS ('dbx_business_glossary_term' = 'Trade Promotion Number');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `promotion_number` SET TAGS ('dbx_value_regex' = '^TPM-[0-9]{8}$');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `promotion_objective` SET TAGS ('dbx_business_glossary_term' = 'Trade Promotion Objective');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `promotion_objective` SET TAGS ('dbx_value_regex' = 'volume_growth|market_share_gain|new_product_launch|competitive_defense|inventory_clearance|seasonal_event');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `promotion_status` SET TAGS ('dbx_business_glossary_term' = 'Trade Promotion Status');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `promotion_status` SET TAGS ('dbx_value_regex' = 'planned|approved|active|closed|cancelled|on_hold');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `promotion_type` SET TAGS ('dbx_business_glossary_term' = 'Trade Promotion Type');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `promotion_type` SET TAGS ('dbx_value_regex' = 'temporary_price_reduction|feature_ad|display|bogo|multi_buy|scan_back');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `settlement_status` SET TAGS ('dbx_business_glossary_term' = 'Financial Settlement Status');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `settlement_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|settled|disputed');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Promotion Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `target_volume_units` SET TAGS ('dbx_business_glossary_term' = 'Target Volume Units');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `target_volume_units` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `tpm_system_reference_code` SET TAGS ('dbx_business_glossary_term' = 'Trade Promotion Management (TPM) System Reference ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `trade_promotion_status` SET TAGS ('dbx_business_glossary_term' = 'Trade Promotion Status');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_event` SET TAGS ('dbx_subdomain' = 'trade_planning');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_event` SET TAGS ('dbx_ssot_authoritative' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_event` SET TAGS ('dbx_ssot_concept' = 'event');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_event` SET TAGS ('dbx_ssot' = 'secondary');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_event` SET TAGS ('dbx_ssot_canonical' = 'marketing.marketing_event');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_event` SET TAGS ('dbx_ssot_role' = 'primary');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_event` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_event` SET TAGS ('dbx_ssot_status' = 'authoritative');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_event` ALTER COLUMN `promotion_event_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Event ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_event` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_event` ALTER COLUMN `capa_id` SET TAGS ('dbx_business_glossary_term' = 'Capa Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_event` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_event` ALTER COLUMN `esg_commitment_id` SET TAGS ('dbx_business_glossary_term' = 'Esg Commitment Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_event` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_event` ALTER COLUMN `retail_store_id` SET TAGS ('dbx_business_glossary_term' = 'Ship-To Location ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_event` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Account ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_event` ALTER COLUMN `trade_promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Program ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_event` ALTER COLUMN `marketing_event_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Event Id');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_event` ALTER COLUMN `marketing_event_id` SET TAGS ('dbx_ssot_reference' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_event` ALTER COLUMN `accrual_amount` SET TAGS ('dbx_business_glossary_term' = 'Accrual Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_event` ALTER COLUMN `actual_trade_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Trade Spend Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_event` ALTER COLUMN `actual_volume_units` SET TAGS ('dbx_business_glossary_term' = 'Actual Volume Units');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_event` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_event` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_event` ALTER COLUMN `baseline_volume_units` SET TAGS ('dbx_business_glossary_term' = 'Baseline Volume Units');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_event` ALTER COLUMN `cancellation_date` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_event` ALTER COLUMN `cancellation_date` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_event` ALTER COLUMN `cancellation_date` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_event` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_event` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_event` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_event` ALTER COLUMN `promotion_event_code` SET TAGS ('dbx_business_glossary_term' = 'Promotion Event Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_event` ALTER COLUMN `deduction_amount` SET TAGS ('dbx_business_glossary_term' = 'Deduction Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_event` ALTER COLUMN `promotion_event_description` SET TAGS ('dbx_business_glossary_term' = 'Promotion Event Description');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_event` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_event` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_event` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Event End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_event` ALTER COLUMN `event_description` SET TAGS ('dbx_business_glossary_term' = 'Event Description');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_event` ALTER COLUMN `event_name` SET TAGS ('dbx_business_glossary_term' = 'Event Name');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_event` ALTER COLUMN `event_number` SET TAGS ('dbx_business_glossary_term' = 'Event Number');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_event` ALTER COLUMN `event_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_event` ALTER COLUMN `event_status` SET TAGS ('dbx_business_glossary_term' = 'Event Status');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_event` ALTER COLUMN `event_status` SET TAGS ('dbx_value_regex' = 'planned|approved|in_execution|completed|cancelled');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_event` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'feature_ad|display|temporary_price_reduction|bogo|scan_back|coupon');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_event` ALTER COLUMN `funding_source` SET TAGS ('dbx_business_glossary_term' = 'Funding Source');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_event` ALTER COLUMN `funding_source` SET TAGS ('dbx_value_regex' = 'manufacturer|retailer|cooperative');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_event` ALTER COLUMN `geography_code` SET TAGS ('dbx_business_glossary_term' = 'Geography Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_event` ALTER COLUMN `geography_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_event` ALTER COLUMN `geography_code` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_event` ALTER COLUMN `geography_code` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_event` ALTER COLUMN `gmroi_ratio` SET TAGS ('dbx_business_glossary_term' = 'Gross Margin Return on Investment (GMROI) Ratio');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_event` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_event` ALTER COLUMN `promotion_event_name` SET TAGS ('dbx_business_glossary_term' = 'Promotion Event Name');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_event` ALTER COLUMN `planned_lift_pct` SET TAGS ('dbx_business_glossary_term' = 'Planned Lift Pct');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_event` ALTER COLUMN `planned_trade_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Planned Trade Spend Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_event` ALTER COLUMN `planned_volume_units` SET TAGS ('dbx_business_glossary_term' = 'Planned Volume Units');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_event` ALTER COLUMN `post_event_analysis_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Post-Event Analysis Completed Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_event` ALTER COLUMN `post_event_analysis_date` SET TAGS ('dbx_business_glossary_term' = 'Post-Event Analysis Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_event` ALTER COLUMN `pricing_strategy` SET TAGS ('dbx_business_glossary_term' = 'Pricing Strategy');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_event` ALTER COLUMN `pricing_strategy` SET TAGS ('dbx_value_regex' = 'hi_lo|edlp|hybrid');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_event` ALTER COLUMN `promotion_event_status` SET TAGS ('dbx_business_glossary_term' = 'Promotion Event Status');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_event` ALTER COLUMN `promotional_lift_percentage` SET TAGS ('dbx_business_glossary_term' = 'Promotional Lift Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_event` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_event` ALTER COLUMN `rebate_amount` SET TAGS ('dbx_business_glossary_term' = 'Rebate Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_event` ALTER COLUMN `roi_percentage` SET TAGS ('dbx_business_glossary_term' = 'Return on Investment (ROI) Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_event` ALTER COLUMN `salesforce_tpm_event_code` SET TAGS ('dbx_business_glossary_term' = 'Salesforce Trade Promotion Management (TPM) Event ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_event` ALTER COLUMN `salesforce_tpm_event_code` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9]{15,18}$');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_event` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_event` ALTER COLUMN `settlement_status` SET TAGS ('dbx_business_glossary_term' = 'Settlement Status');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_event` ALTER COLUMN `settlement_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|settled|disputed');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_event` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_event` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Event Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_event` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` SET TAGS ('dbx_subdomain' = 'trade_planning');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `event_sku_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Event SKU (Stock Keeping Unit) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `channel_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Channel ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Approved By');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `promotion_event_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Event ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `funding_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Retailer Funding Agreement ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'SKU (Stock Keeping Unit) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Account ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `accrual_amount` SET TAGS ('dbx_business_glossary_term' = 'Accrual Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `actual_promotional_volume_cases` SET TAGS ('dbx_business_glossary_term' = 'Actual Promotional Volume (Cases)');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `actual_promotional_volume_units` SET TAGS ('dbx_business_glossary_term' = 'Actual Promotional Volume (Units)');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `actual_volume_units` SET TAGS ('dbx_business_glossary_term' = 'Actual Volume Units');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `baseline_volume_estimate_units` SET TAGS ('dbx_business_glossary_term' = 'Baseline Volume Estimate (Units)');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `event_sku_code` SET TAGS ('dbx_business_glossary_term' = 'Event Sku Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `compliance_check_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Check Status');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `compliance_check_status` SET TAGS ('dbx_value_regex' = 'Not Checked|Compliant|Non-Compliant|Under Review');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `compliance_verified_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Verified Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `deduction_amount` SET TAGS ('dbx_business_glossary_term' = 'Deduction Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `event_sku_description` SET TAGS ('dbx_business_glossary_term' = 'Event Sku Description');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `display_location_type` SET TAGS ('dbx_business_glossary_term' = 'Display Location Type');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `display_type` SET TAGS ('dbx_business_glossary_term' = 'Display Type');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `event_sku_status` SET TAGS ('dbx_business_glossary_term' = 'Event Sku Status');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `expected_units` SET TAGS ('dbx_business_glossary_term' = 'Expected Units');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `feature_flag` SET TAGS ('dbx_business_glossary_term' = 'Feature Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `feature_type` SET TAGS ('dbx_business_glossary_term' = 'Feature Type');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `forecast_volume_units` SET TAGS ('dbx_business_glossary_term' = 'Forecast Volume Units');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `gtin` SET TAGS ('dbx_business_glossary_term' = 'GTIN (Global Trade Item Number)');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `gtin` SET TAGS ('dbx_value_regex' = '^[0-9]{8,14}$');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `incremental_lift_percent` SET TAGS ('dbx_business_glossary_term' = 'Incremental Lift Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `incremental_lift_volume_units` SET TAGS ('dbx_business_glossary_term' = 'Incremental Lift Volume (Units)');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `is_featured_sku` SET TAGS ('dbx_business_glossary_term' = 'Is Featured SKU Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `event_sku_name` SET TAGS ('dbx_business_glossary_term' = 'Event Sku Name');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `planned_promotional_volume_cases` SET TAGS ('dbx_business_glossary_term' = 'Planned Promotional Volume (Cases)');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `planned_promotional_volume_units` SET TAGS ('dbx_business_glossary_term' = 'Planned Promotional Volume (Units)');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `price_reduction_depth_percent` SET TAGS ('dbx_business_glossary_term' = 'Price Reduction Depth Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `pricing_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Pricing Approval Status');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `pricing_approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Pricing Approved Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `promoted_price` SET TAGS ('dbx_business_glossary_term' = 'Promoted Price');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `promoted_price_type` SET TAGS ('dbx_business_glossary_term' = 'Promoted Price Type');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `promotion_effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Promotion Effective End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `promotion_effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Promotion Effective Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `promotional_discount_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Promotional Discount Per Unit');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `promotional_gmroi` SET TAGS ('dbx_business_glossary_term' = 'Promotional GMROI (Gross Margin Return on Investment)');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `promotional_roi_percent` SET TAGS ('dbx_business_glossary_term' = 'Promotional ROI (Return on Investment) Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `rebate_amount` SET TAGS ('dbx_business_glossary_term' = 'Rebate Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `regular_price` SET TAGS ('dbx_business_glossary_term' = 'Regular Price');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `regular_shelf_price` SET TAGS ('dbx_business_glossary_term' = 'Regular Shelf Price (RSP)');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `settlement_status` SET TAGS ('dbx_business_glossary_term' = 'Settlement Status');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `settlement_status` SET TAGS ('dbx_value_regex' = 'Not Started|In Progress|Reconciled|Settled|Disputed');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `total_trade_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Trade Spend Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `upc` SET TAGS ('dbx_business_glossary_term' = 'UPC (Universal Product Code)');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `upc` SET TAGS ('dbx_value_regex' = '^[0-9]{12}$');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` SET TAGS ('dbx_subdomain' = 'trade_planning');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ALTER COLUMN `trade_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Calendar Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ALTER COLUMN `channel_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Channel ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ALTER COLUMN `parent_calendar_trade_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Calendar ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owning Manager ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ALTER COLUMN `tertiary_trade_created_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ALTER COLUMN `tertiary_trade_created_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ALTER COLUMN `tertiary_trade_created_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Account ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ALTER COLUMN `actual_event_count` SET TAGS ('dbx_business_glossary_term' = 'Actual Event Count');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ALTER COLUMN `calendar_code` SET TAGS ('dbx_business_glossary_term' = 'Calendar Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ALTER COLUMN `calendar_name` SET TAGS ('dbx_business_glossary_term' = 'Calendar Name');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ALTER COLUMN `calendar_status` SET TAGS ('dbx_business_glossary_term' = 'Calendar Status');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ALTER COLUMN `calendar_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|locked|active|closed');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ALTER COLUMN `calendar_year` SET TAGS ('dbx_business_glossary_term' = 'Calendar Year');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ALTER COLUMN `closed_date` SET TAGS ('dbx_business_glossary_term' = 'Closed Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ALTER COLUMN `trade_calendar_code` SET TAGS ('dbx_business_glossary_term' = 'Trade Calendar Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ALTER COLUMN `trade_calendar_description` SET TAGS ('dbx_business_glossary_term' = 'Calendar Description');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ALTER COLUMN `event_window_type` SET TAGS ('dbx_business_glossary_term' = 'Event Window Type');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ALTER COLUMN `is_baseline_calendar` SET TAGS ('dbx_business_glossary_term' = 'Is Baseline Calendar');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ALTER COLUMN `locked_date` SET TAGS ('dbx_business_glossary_term' = 'Locked Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ALTER COLUMN `trade_calendar_name` SET TAGS ('dbx_business_glossary_term' = 'Trade Calendar Name');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Calendar Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ALTER COLUMN `period_end` SET TAGS ('dbx_business_glossary_term' = 'Period End');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Period End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ALTER COLUMN `period_name` SET TAGS ('dbx_business_glossary_term' = 'Period Name');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ALTER COLUMN `period_start` SET TAGS ('dbx_business_glossary_term' = 'Period Start');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Period Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ALTER COLUMN `planned_event_count` SET TAGS ('dbx_business_glossary_term' = 'Planned Event Count');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ALTER COLUMN `planning_cycle` SET TAGS ('dbx_business_glossary_term' = 'Planning Cycle');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ALTER COLUMN `planning_cycle` SET TAGS ('dbx_value_regex' = 'annual|semi-annual|quarterly|monthly');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ALTER COLUMN `pricing_strategy` SET TAGS ('dbx_business_glossary_term' = 'Pricing Strategy');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ALTER COLUMN `pricing_strategy` SET TAGS ('dbx_value_regex' = 'hi-lo|edlp|hybrid|promotional|premium');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ALTER COLUMN `season` SET TAGS ('dbx_business_glossary_term' = 'Season');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ALTER COLUMN `total_planned_trade_spend` SET TAGS ('dbx_business_glossary_term' = 'Total Planned Trade Spend');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ALTER COLUMN `total_planned_trade_spend` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ALTER COLUMN `tpm_system_code` SET TAGS ('dbx_business_glossary_term' = 'Trade Promotion Management (TPM) System ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ALTER COLUMN `trade_calendar_status` SET TAGS ('dbx_business_glossary_term' = 'Trade Calendar Status');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` SET TAGS ('dbx_subdomain' = 'spend_settlement');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `trade_spend_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Spend Allocation ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `funding_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Funding Agreement Id');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `promotion_event_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Event ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `sku_group_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Group ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Account ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `trade_promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Promotion Id');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `accrual_amount` SET TAGS ('dbx_business_glossary_term' = 'Accrual Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `actual_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Spend Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `actual_volume` SET TAGS ('dbx_business_glossary_term' = 'Actual Volume');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `allocated_amount` SET TAGS ('dbx_business_glossary_term' = 'Allocated Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `allocation_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `allocation_number` SET TAGS ('dbx_business_glossary_term' = 'Trade Spend Allocation Number');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `allocation_number` SET TAGS ('dbx_value_regex' = '^TSA-[0-9]{8}-[A-Z0-9]{6}$');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `allocation_period` SET TAGS ('dbx_business_glossary_term' = 'Allocation Period');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `allocation_type` SET TAGS ('dbx_business_glossary_term' = 'Allocation Type');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `baseline_volume` SET TAGS ('dbx_business_glossary_term' = 'Baseline Volume');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `trade_spend_allocation_code` SET TAGS ('dbx_business_glossary_term' = 'Trade Spend Allocation Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `committed_amount` SET TAGS ('dbx_business_glossary_term' = 'Committed Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `deduction_amount` SET TAGS ('dbx_business_glossary_term' = 'Deduction Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `trade_spend_allocation_description` SET TAGS ('dbx_business_glossary_term' = 'Trade Spend Allocation Description');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `fund_type` SET TAGS ('dbx_business_glossary_term' = 'Fund Type');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `gmroi_percentage` SET TAGS ('dbx_business_glossary_term' = 'Gross Margin Return on Investment (GMROI) Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `trade_spend_allocation_name` SET TAGS ('dbx_business_glossary_term' = 'Trade Spend Allocation Name');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Allocation Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `pricing_strategy` SET TAGS ('dbx_business_glossary_term' = 'Pricing Strategy');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `pricing_strategy` SET TAGS ('dbx_value_regex' = 'hi_lo|edlp|hybrid|premium|penetration|competitive');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_value_regex' = '^PC[0-9]{6}$');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `promotion_end_date` SET TAGS ('dbx_business_glossary_term' = 'Promotion End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `promotion_start_date` SET TAGS ('dbx_business_glossary_term' = 'Promotion Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `roi_percentage` SET TAGS ('dbx_business_glossary_term' = 'Return on Investment (ROI) Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `settlement_amount` SET TAGS ('dbx_business_glossary_term' = 'Settlement Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `spend_category` SET TAGS ('dbx_business_glossary_term' = 'Trade Spend Category');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `spend_category` SET TAGS ('dbx_value_regex' = 'price_discount|merchandising|marketing|listing|performance_incentive|other');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `spend_type` SET TAGS ('dbx_business_glossary_term' = 'Trade Spend Type');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `spend_type` SET TAGS ('dbx_value_regex' = 'off_invoice_discount|scan_back|bill_back|lump_sum|coop_advertising|slotting_fee');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `spent_amount` SET TAGS ('dbx_business_glossary_term' = 'Spent Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `target_volume` SET TAGS ('dbx_business_glossary_term' = 'Target Volume');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `trade_spend_allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Trade Spend Allocation Status');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `volume_uom` SET TAGS ('dbx_business_glossary_term' = 'Volume Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `volume_uom` SET TAGS ('dbx_value_regex' = 'units|cases|pallets|kg|liters');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` SET TAGS ('dbx_subdomain' = 'spend_settlement');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `funding_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Funding Agreement ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `previous_agreement_funding_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Agreement ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Account ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `accrual_method` SET TAGS ('dbx_business_glossary_term' = 'Accrual Method');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `accrual_method` SET TAGS ('dbx_value_regex' = 'straight_line|event_based|scan_based|milestone_based');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `accrual_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Accrual Rate Pct');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `accrued_to_date_amount` SET TAGS ('dbx_business_glossary_term' = 'Accrued To Date Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `agreement_name` SET TAGS ('dbx_business_glossary_term' = 'Agreement Name');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Number');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}-[0-9]{6,10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'annual_lump_sum|scan_back|co_op|slotting|performance_based|volume_rebate');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'not_submitted|pending_review|approved|rejected|revision_required');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Renewal Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `funding_agreement_code` SET TAGS ('dbx_business_glossary_term' = 'Funding Agreement Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `contract_document_url` SET TAGS ('dbx_business_glossary_term' = 'Contract Document URL');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `deduction_settlement_terms` SET TAGS ('dbx_business_glossary_term' = 'Deduction Settlement Terms');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `funding_agreement_description` SET TAGS ('dbx_business_glossary_term' = 'Funding Agreement Description');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `fund_type` SET TAGS ('dbx_business_glossary_term' = 'Fund Type');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `funding_agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Funding Agreement Status');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `funding_amount` SET TAGS ('dbx_business_glossary_term' = 'Funding Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `funding_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Funding Period End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `funding_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Funding Period Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `funding_type` SET TAGS ('dbx_business_glossary_term' = 'Funding Type');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `gmroi_target` SET TAGS ('dbx_business_glossary_term' = 'Gross Margin Return on Investment (GMROI) Target');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `manufacturer_signatory_name` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Signatory Name');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `manufacturer_signatory_title` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Signatory Title');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `manufacturer_signature_date` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Signature Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `funding_agreement_name` SET TAGS ('dbx_business_glossary_term' = 'Funding Agreement Name');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `paid_to_date_amount` SET TAGS ('dbx_business_glossary_term' = 'Paid To Date Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Payment Frequency');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_value_regex' = 'one_time|monthly|quarterly|semi_annual|annual|event_based');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `performance_conditions` SET TAGS ('dbx_business_glossary_term' = 'Performance Conditions');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `remaining_balance_amount` SET TAGS ('dbx_business_glossary_term' = 'Remaining Balance Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `retailer_signatory_name` SET TAGS ('dbx_business_glossary_term' = 'Retailer Signatory Name');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `retailer_signatory_title` SET TAGS ('dbx_business_glossary_term' = 'Retailer Signatory Title');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `retailer_signature_date` SET TAGS ('dbx_business_glossary_term' = 'Retailer Signature Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `roi_target_percentage` SET TAGS ('dbx_business_glossary_term' = 'Return on Investment (ROI) Target Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `termination_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Days');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `total_committed_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Committed Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `total_fund_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Fund Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_accrual` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_accrual` SET TAGS ('dbx_subdomain' = 'spend_settlement');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_accrual` SET TAGS ('dbx_deprecated_ssot_duplicate' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_accrual` SET TAGS ('dbx_ssot_alias_of' = 'finance.finance_accrual');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_accrual` SET TAGS ('dbx_ssot' = 'secondary');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_accrual` SET TAGS ('dbx_ssot_role' = 'secondary');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_accrual` SET TAGS ('dbx_ssot_canonical' = 'finance.finance_accrual');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_accrual` SET TAGS ('dbx_deprecated_duplicate' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_accrual` SET TAGS ('dbx_ssot_concept' = 'accrual');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_accrual` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_accrual` SET TAGS ('dbx_ssot_duplicate_of' = 'finance.finance_accrual');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_accrual` SET TAGS ('dbx_ssot_status' = 'deprecated_duplicate');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_accrual` SET TAGS ('dbx_ssot_authoritative' = 'finance.finance_accrual');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_accrual` ALTER COLUMN `promotion_accrual_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Accrual ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_accrual` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_accrual` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_accrual` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_accrual` ALTER COLUMN `finance_accrual_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Accrual Id');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_accrual` ALTER COLUMN `finance_accrual_id` SET TAGS ('dbx_ssot_resolution' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_accrual` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_accrual` ALTER COLUMN `promotion_event_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Event ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_accrual` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_accrual` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Account ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_accrual` ALTER COLUMN `trade_promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Promotion Id');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_accrual` ALTER COLUMN `accrual_amount` SET TAGS ('dbx_business_glossary_term' = 'Accrual Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_accrual` ALTER COLUMN `accrual_date` SET TAGS ('dbx_business_glossary_term' = 'Accrual Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_accrual` ALTER COLUMN `accrual_rate` SET TAGS ('dbx_business_glossary_term' = 'Accrual Rate');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_accrual` ALTER COLUMN `accrual_status` SET TAGS ('dbx_business_glossary_term' = 'Accrual Status');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_accrual` ALTER COLUMN `accrual_type` SET TAGS ('dbx_business_glossary_term' = 'Accrual Type');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_accrual` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_accrual` ALTER COLUMN `promotion_accrual_code` SET TAGS ('dbx_business_glossary_term' = 'Promotion Accrual Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_accrual` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_accrual` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_accrual` ALTER COLUMN `promotion_accrual_description` SET TAGS ('dbx_business_glossary_term' = 'Promotion Accrual Description');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_accrual` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_accrual` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_accrual` ALTER COLUMN `promotion_accrual_name` SET TAGS ('dbx_business_glossary_term' = 'Promotion Accrual Name');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_accrual` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_accrual` ALTER COLUMN `promotion_accrual_status` SET TAGS ('dbx_business_glossary_term' = 'Promotion Accrual Status');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_accrual` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_accrual` ALTER COLUMN `reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Reversal Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_accrual` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_accrual` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_accrual` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_deduction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_deduction` SET TAGS ('dbx_subdomain' = 'spend_settlement');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_deduction` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_deduction` ALTER COLUMN `promotion_deduction_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Deduction ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_deduction` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_deduction` ALTER COLUMN `funding_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Funding Agreement ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_deduction` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_deduction` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_deduction` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_deduction` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_deduction` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_deduction` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_deduction` ALTER COLUMN `promotion_event_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Event ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_deduction` ALTER COLUMN `tertiary_promotion_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_deduction` ALTER COLUMN `tertiary_promotion_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_deduction` ALTER COLUMN `tertiary_promotion_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_deduction` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Account ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_deduction` ALTER COLUMN `trade_promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Promotion Id');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_deduction` ALTER COLUMN `accrual_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Accrual Impact Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_deduction` ALTER COLUMN `aging_days` SET TAGS ('dbx_business_glossary_term' = 'Aging Days');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_deduction` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Deduction Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_deduction` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_deduction` ALTER COLUMN `approved_amount` SET TAGS ('dbx_business_glossary_term' = 'Approved Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_deduction` ALTER COLUMN `business_unit_code` SET TAGS ('dbx_business_glossary_term' = 'Business Unit Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_deduction` ALTER COLUMN `claim_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Claim Reference Number');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_deduction` ALTER COLUMN `promotion_deduction_code` SET TAGS ('dbx_business_glossary_term' = 'Promotion Deduction Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_deduction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_deduction` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_deduction` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_deduction` ALTER COLUMN `deduction_amount` SET TAGS ('dbx_business_glossary_term' = 'Deduction Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_deduction` ALTER COLUMN `deduction_date` SET TAGS ('dbx_business_glossary_term' = 'Deduction Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_deduction` ALTER COLUMN `deduction_number` SET TAGS ('dbx_business_glossary_term' = 'Deduction Number');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_deduction` ALTER COLUMN `deduction_reason` SET TAGS ('dbx_business_glossary_term' = 'Deduction Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_deduction` ALTER COLUMN `deduction_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Deduction Reason Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_deduction` ALTER COLUMN `deduction_source` SET TAGS ('dbx_business_glossary_term' = 'Deduction Source');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_deduction` ALTER COLUMN `deduction_source` SET TAGS ('dbx_value_regex' = 'retailer_portal|edi_846|manual_entry|bank_reconciliation|automated_matching');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_deduction` ALTER COLUMN `deduction_status` SET TAGS ('dbx_business_glossary_term' = 'Deduction Status');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_deduction` ALTER COLUMN `deduction_type` SET TAGS ('dbx_business_glossary_term' = 'Deduction Type');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_deduction` ALTER COLUMN `promotion_deduction_description` SET TAGS ('dbx_business_glossary_term' = 'Promotion Deduction Description');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_deduction` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_deduction` ALTER COLUMN `dispute_status` SET TAGS ('dbx_business_glossary_term' = 'Dispute Status');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_deduction` ALTER COLUMN `dispute_status` SET TAGS ('dbx_value_regex' = 'open|approved|disputed|partially_approved|written_off|pending_review');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_deduction` ALTER COLUMN `disputed_amount` SET TAGS ('dbx_business_glossary_term' = 'Disputed Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_deduction` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_deduction` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_deduction` ALTER COLUMN `gmroi_impact_percentage` SET TAGS ('dbx_business_glossary_term' = 'Gross Margin Return on Investment (GMROI) Impact Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_deduction` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_deduction` ALTER COLUMN `promotion_deduction_name` SET TAGS ('dbx_business_glossary_term' = 'Promotion Deduction Name');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_deduction` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_deduction` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_deduction` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_deduction` ALTER COLUMN `product_category_code` SET TAGS ('dbx_business_glossary_term' = 'Product Category Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_deduction` ALTER COLUMN `promotion_deduction_status` SET TAGS ('dbx_business_glossary_term' = 'Promotion Deduction Status');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_deduction` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_deduction` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_deduction` ALTER COLUMN `retailer_claim_date` SET TAGS ('dbx_business_glossary_term' = 'Retailer Claim Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_deduction` ALTER COLUMN `retailer_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Retailer Contact Email');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_deduction` ALTER COLUMN `retailer_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_deduction` ALTER COLUMN `retailer_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_deduction` ALTER COLUMN `retailer_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_deduction` ALTER COLUMN `retailer_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Retailer Contact Name');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_deduction` ALTER COLUMN `retailer_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_deduction` ALTER COLUMN `retailer_contact_name` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_deduction` ALTER COLUMN `retailer_contact_name` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_deduction` ALTER COLUMN `roi_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Return on Investment (ROI) Impact Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_deduction` ALTER COLUMN `settled_amount` SET TAGS ('dbx_business_glossary_term' = 'Settled Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_deduction` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_deduction` ALTER COLUMN `settlement_method` SET TAGS ('dbx_business_glossary_term' = 'Settlement Method');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_deduction` ALTER COLUMN `settlement_method` SET TAGS ('dbx_value_regex' = 'credit_memo|check|offset_future_invoice|write_off|bank_transfer');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_deduction` ALTER COLUMN `settlement_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Settlement Reason Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_deduction` ALTER COLUMN `sla_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Resolution Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_deduction` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_deduction` ALTER COLUMN `supporting_document_url` SET TAGS ('dbx_business_glossary_term' = 'Supporting Document URL');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_deduction` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_deduction` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` SET TAGS ('dbx_subdomain' = 'spend_settlement');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ALTER COLUMN `deduction_settlement_id` SET TAGS ('dbx_business_glossary_term' = 'Deduction Settlement Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ALTER COLUMN `funding_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Funding Agreement Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ALTER COLUMN `parent_settlement_deduction_settlement_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Settlement Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ALTER COLUMN `promotion_deduction_id` SET TAGS ('dbx_business_glossary_term' = 'Deduction Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ALTER COLUMN `tertiary_deduction_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ALTER COLUMN `tertiary_deduction_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ALTER COLUMN `tertiary_deduction_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Account Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ALTER COLUMN `approved_amount` SET TAGS ('dbx_business_glossary_term' = 'Approved Settlement Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ALTER COLUMN `business_unit_code` SET TAGS ('dbx_business_glossary_term' = 'Business Unit Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ALTER COLUMN `business_unit_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ALTER COLUMN `deduction_settlement_code` SET TAGS ('dbx_business_glossary_term' = 'Deduction Settlement Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ALTER COLUMN `deduction_claimed_amount` SET TAGS ('dbx_business_glossary_term' = 'Deduction Claimed Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ALTER COLUMN `deduction_settlement_status` SET TAGS ('dbx_business_glossary_term' = 'Deduction Settlement Status');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ALTER COLUMN `deduction_settlement_description` SET TAGS ('dbx_business_glossary_term' = 'Deduction Settlement Description');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ALTER COLUMN `dispute_resolution_method` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Method');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ALTER COLUMN `dispute_resolution_method` SET TAGS ('dbx_value_regex' = 'negotiation|arbitration|escalation|partial_approval|full_approval|write_off');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ALTER COLUMN `disputed_amount` SET TAGS ('dbx_business_glossary_term' = 'Disputed Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ALTER COLUMN `is_partial_settlement` SET TAGS ('dbx_business_glossary_term' = 'Is Partial Settlement Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ALTER COLUMN `deduction_settlement_name` SET TAGS ('dbx_business_glossary_term' = 'Deduction Settlement Name');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ALTER COLUMN `resolution_code` SET TAGS ('dbx_business_glossary_term' = 'Resolution Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ALTER COLUMN `settled_amount` SET TAGS ('dbx_business_glossary_term' = 'Settled Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ALTER COLUMN `settlement_amount` SET TAGS ('dbx_business_glossary_term' = 'Settlement Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ALTER COLUMN `settlement_cycle_time_days` SET TAGS ('dbx_business_glossary_term' = 'Settlement Cycle Time in Days');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ALTER COLUMN `settlement_method` SET TAGS ('dbx_business_glossary_term' = 'Settlement Method');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ALTER COLUMN `settlement_method` SET TAGS ('dbx_value_regex' = 'credit_memo|check|wire_transfer|offset_invoice|write_off|accrual_adjustment');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ALTER COLUMN `settlement_notes` SET TAGS ('dbx_business_glossary_term' = 'Settlement Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ALTER COLUMN `settlement_number` SET TAGS ('dbx_business_glossary_term' = 'Settlement Number');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ALTER COLUMN `settlement_number` SET TAGS ('dbx_value_regex' = '^STL-[0-9]{8,12}$');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ALTER COLUMN `settlement_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Settlement Reason Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ALTER COLUMN `settlement_reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ALTER COLUMN `settlement_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Settlement Reason Description');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ALTER COLUMN `settlement_status` SET TAGS ('dbx_business_glossary_term' = 'Settlement Status');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ALTER COLUMN `sla_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Compliance Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ALTER COLUMN `write_off_amount` SET TAGS ('dbx_business_glossary_term' = 'Write Off Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_rebate_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_rebate_agreement` SET TAGS ('dbx_subdomain' = 'spend_settlement');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_rebate_agreement` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_rebate_agreement` ALTER COLUMN `promotion_rebate_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Rebate Agreement ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_rebate_agreement` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_rebate_agreement` ALTER COLUMN `channel_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Channel ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_rebate_agreement` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_rebate_agreement` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_rebate_agreement` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_rebate_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_rebate_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_rebate_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_rebate_agreement` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_rebate_agreement` ALTER COLUMN `tertiary_promotion_created_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_rebate_agreement` ALTER COLUMN `tertiary_promotion_created_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_rebate_agreement` ALTER COLUMN `tertiary_promotion_created_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_rebate_agreement` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Account ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_rebate_agreement` ALTER COLUMN `agreement_name` SET TAGS ('dbx_business_glossary_term' = 'Agreement Name');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_rebate_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Number');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_rebate_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_rebate_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_rebate_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|active|suspended|terminated|expired');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_rebate_agreement` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_rebate_agreement` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_rebate_agreement` ALTER COLUMN `auto_settlement_enabled` SET TAGS ('dbx_business_glossary_term' = 'Auto Settlement Enabled Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_rebate_agreement` ALTER COLUMN `calculation_basis` SET TAGS ('dbx_business_glossary_term' = 'Calculation Basis');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_rebate_agreement` ALTER COLUMN `calculation_basis` SET TAGS ('dbx_value_regex' = 'percent_net_sales|dollar_per_case|dollar_per_unit|percent_gross_sales|fixed_amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_rebate_agreement` ALTER COLUMN `calculation_basis` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_rebate_agreement` ALTER COLUMN `calculation_basis` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_rebate_agreement` ALTER COLUMN `promotion_rebate_agreement_code` SET TAGS ('dbx_business_glossary_term' = 'Promotion Rebate Agreement Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_rebate_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_rebate_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_rebate_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_rebate_agreement` ALTER COLUMN `promotion_rebate_agreement_description` SET TAGS ('dbx_business_glossary_term' = 'Promotion Rebate Agreement Description');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_rebate_agreement` ALTER COLUMN `dispute_resolution_terms` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Terms');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_rebate_agreement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_rebate_agreement` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_rebate_agreement` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_rebate_agreement` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_rebate_agreement` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_rebate_agreement` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_rebate_agreement` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_rebate_agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_rebate_agreement` ALTER COLUMN `measurement_period_type` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period Type');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_rebate_agreement` ALTER COLUMN `measurement_period_type` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual|custom');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_rebate_agreement` ALTER COLUMN `promotion_rebate_agreement_name` SET TAGS ('dbx_business_glossary_term' = 'Promotion Rebate Agreement Name');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_rebate_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Agreement Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_rebate_agreement` ALTER COLUMN `outstanding_balance` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Balance');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_rebate_agreement` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Payment Frequency');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_rebate_agreement` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual|upon_achievement');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_rebate_agreement` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_rebate_agreement` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'check|ach|wire_transfer|credit_memo|offset_invoice');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_rebate_agreement` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Days');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_rebate_agreement` ALTER COLUMN `promotion_rebate_agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Promotion Rebate Agreement Status');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_rebate_agreement` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_rebate_agreement` ALTER COLUMN `rebate_rate` SET TAGS ('dbx_business_glossary_term' = 'Rebate Rate');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_rebate_agreement` ALTER COLUMN `rebate_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Rebate Rate Pct');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_rebate_agreement` ALTER COLUMN `rebate_type` SET TAGS ('dbx_business_glossary_term' = 'Rebate Type');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_rebate_agreement` ALTER COLUMN `rebate_type` SET TAGS ('dbx_value_regex' = 'volume_tier|growth_incentive|category_captain|compliance_bonus|market_development|promotional_support');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_rebate_agreement` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_rebate_agreement` ALTER COLUMN `region_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_rebate_agreement` ALTER COLUMN `sap_rebate_agreement_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Rebate Agreement Number');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_rebate_agreement` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_rebate_agreement` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_rebate_agreement` ALTER COLUMN `threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Threshold Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_rebate_agreement` ALTER COLUMN `threshold_unit` SET TAGS ('dbx_business_glossary_term' = 'Threshold Unit of Measure');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_rebate_agreement` ALTER COLUMN `threshold_unit` SET TAGS ('dbx_value_regex' = 'cases|units|dollars|kilograms|liters');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_rebate_agreement` ALTER COLUMN `tier_1_rate` SET TAGS ('dbx_business_glossary_term' = 'Tier 1 Rate');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_rebate_agreement` ALTER COLUMN `tier_1_threshold` SET TAGS ('dbx_business_glossary_term' = 'Tier 1 Threshold');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_rebate_agreement` ALTER COLUMN `tier_2_rate` SET TAGS ('dbx_business_glossary_term' = 'Tier 2 Rate');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_rebate_agreement` ALTER COLUMN `tier_2_threshold` SET TAGS ('dbx_business_glossary_term' = 'Tier 2 Threshold');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_rebate_agreement` ALTER COLUMN `tier_3_rate` SET TAGS ('dbx_business_glossary_term' = 'Tier 3 Rate');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_rebate_agreement` ALTER COLUMN `tier_3_threshold` SET TAGS ('dbx_business_glossary_term' = 'Tier 3 Threshold');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_rebate_agreement` ALTER COLUMN `tier_structure` SET TAGS ('dbx_business_glossary_term' = 'Tier Structure');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_rebate_agreement` ALTER COLUMN `tier_structure` SET TAGS ('dbx_value_regex' = 'single_tier|multi_tier|progressive|retroactive');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_rebate_agreement` ALTER COLUMN `total_accrued_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Accrued Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_rebate_agreement` ALTER COLUMN `total_paid_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Paid Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_rebate_agreement` ALTER COLUMN `tpm_system_code` SET TAGS ('dbx_business_glossary_term' = 'Trade Promotion Management (TPM) System ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_rebate_agreement` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_rebate_agreement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`rebate_settlement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`rebate_settlement` SET TAGS ('dbx_subdomain' = 'spend_settlement');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`rebate_settlement` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`rebate_settlement` ALTER COLUMN `rebate_settlement_id` SET TAGS ('dbx_business_glossary_term' = 'Rebate Settlement ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`rebate_settlement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`rebate_settlement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`rebate_settlement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`rebate_settlement` ALTER COLUMN `promotion_rebate_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Rebate Agreement ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`rebate_settlement` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Account ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`rebate_settlement` ALTER COLUMN `accrual_reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Accrual Reversal Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`rebate_settlement` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`rebate_settlement` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`rebate_settlement` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`rebate_settlement` ALTER COLUMN `calculation_date` SET TAGS ('dbx_business_glossary_term' = 'Calculation Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`rebate_settlement` ALTER COLUMN `calculation_date` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`rebate_settlement` ALTER COLUMN `calculation_date` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`rebate_settlement` ALTER COLUMN `rebate_settlement_code` SET TAGS ('dbx_business_glossary_term' = 'Rebate Settlement Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`rebate_settlement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`rebate_settlement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`rebate_settlement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`rebate_settlement` ALTER COLUMN `rebate_settlement_description` SET TAGS ('dbx_business_glossary_term' = 'Rebate Settlement Description');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`rebate_settlement` ALTER COLUMN `dispute_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`rebate_settlement` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`rebate_settlement` ALTER COLUMN `earned_rebate_amount` SET TAGS ('dbx_business_glossary_term' = 'Earned Rebate Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`rebate_settlement` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`rebate_settlement` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`rebate_settlement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`rebate_settlement` ALTER COLUMN `rebate_settlement_name` SET TAGS ('dbx_business_glossary_term' = 'Rebate Settlement Name');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`rebate_settlement` ALTER COLUMN `net_settlement_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Settlement Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`rebate_settlement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Settlement Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`rebate_settlement` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`rebate_settlement` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`rebate_settlement` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'ach|wire_transfer|check|credit_memo|offset');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`rebate_settlement` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`rebate_settlement` ALTER COLUMN `qualifying_revenue` SET TAGS ('dbx_business_glossary_term' = 'Qualifying Revenue');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`rebate_settlement` ALTER COLUMN `qualifying_volume` SET TAGS ('dbx_business_glossary_term' = 'Qualifying Volume');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`rebate_settlement` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`rebate_settlement` ALTER COLUMN `rebate_amount` SET TAGS ('dbx_business_glossary_term' = 'Rebate Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`rebate_settlement` ALTER COLUMN `rebate_rate` SET TAGS ('dbx_business_glossary_term' = 'Rebate Rate');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`rebate_settlement` ALTER COLUMN `rebate_settlement_status` SET TAGS ('dbx_business_glossary_term' = 'Rebate Settlement Status');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`rebate_settlement` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`rebate_settlement` ALTER COLUMN `sap_fi_document_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Financial Accounting (FI) Document Number');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`rebate_settlement` ALTER COLUMN `settled_amount` SET TAGS ('dbx_business_glossary_term' = 'Settled Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`rebate_settlement` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`rebate_settlement` ALTER COLUMN `settlement_number` SET TAGS ('dbx_business_glossary_term' = 'Settlement Number');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`rebate_settlement` ALTER COLUMN `settlement_number` SET TAGS ('dbx_value_regex' = '^RBS-[0-9]{8}-[0-9]{4}$');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`rebate_settlement` ALTER COLUMN `settlement_period` SET TAGS ('dbx_business_glossary_term' = 'Settlement Period');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`rebate_settlement` ALTER COLUMN `settlement_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Period End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`rebate_settlement` ALTER COLUMN `settlement_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Period Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`rebate_settlement` ALTER COLUMN `settlement_status` SET TAGS ('dbx_business_glossary_term' = 'Settlement Status');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`rebate_settlement` ALTER COLUMN `settlement_status` SET TAGS ('dbx_value_regex' = 'calculated|approved|paid|disputed|cancelled|reversed');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`rebate_settlement` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`rebate_settlement` ALTER COLUMN `tier_achieved` SET TAGS ('dbx_business_glossary_term' = 'Tier Achieved');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`rebate_settlement` ALTER COLUMN `tpm_system_code` SET TAGS ('dbx_business_glossary_term' = 'Trade Promotion Management (TPM) System ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`rebate_settlement` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`rebate_settlement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`rebate_settlement` ALTER COLUMN `volume_uom` SET TAGS ('dbx_business_glossary_term' = 'Volume Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`rebate_settlement` ALTER COLUMN `volume_uom` SET TAGS ('dbx_value_regex' = 'cases|units|pallets|kilograms|liters');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`post_event_analysis` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`post_event_analysis` SET TAGS ('dbx_subdomain' = 'performance_measurement');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`post_event_analysis` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`post_event_analysis` ALTER COLUMN `post_event_analysis_id` SET TAGS ('dbx_business_glossary_term' = 'Post Event Analysis ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`post_event_analysis` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Analyst ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`post_event_analysis` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`post_event_analysis` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`post_event_analysis` ALTER COLUMN `promotion_event_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Event ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`post_event_analysis` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`post_event_analysis` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Account ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`post_event_analysis` ALTER COLUMN `trade_promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Promotion Id');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`post_event_analysis` ALTER COLUMN `actual_lift_pct` SET TAGS ('dbx_business_glossary_term' = 'Actual Lift Pct');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`post_event_analysis` ALTER COLUMN `actual_promoted_volume_units` SET TAGS ('dbx_business_glossary_term' = 'Actual Promoted Volume Units');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`post_event_analysis` ALTER COLUMN `actual_roi_percentage` SET TAGS ('dbx_business_glossary_term' = 'Actual Roi Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`post_event_analysis` ALTER COLUMN `actual_trade_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Trade Spend Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`post_event_analysis` ALTER COLUMN `actual_trade_spend_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`post_event_analysis` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`post_event_analysis` ALTER COLUMN `analysis_completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Analysis Completed Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`post_event_analysis` ALTER COLUMN `analysis_date` SET TAGS ('dbx_business_glossary_term' = 'Analysis Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`post_event_analysis` ALTER COLUMN `analysis_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Analysis Period End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`post_event_analysis` ALTER COLUMN `analysis_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Analysis Period Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`post_event_analysis` ALTER COLUMN `analysis_status` SET TAGS ('dbx_business_glossary_term' = 'Analysis Status');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`post_event_analysis` ALTER COLUMN `analysis_status` SET TAGS ('dbx_value_regex' = 'draft|in_progress|completed|approved|rejected|archived');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`post_event_analysis` ALTER COLUMN `analyst_notes` SET TAGS ('dbx_business_glossary_term' = 'Analyst Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`post_event_analysis` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`post_event_analysis` ALTER COLUMN `baseline_confidence_interval_lower` SET TAGS ('dbx_business_glossary_term' = 'Baseline Confidence Interval Lower Bound');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`post_event_analysis` ALTER COLUMN `baseline_confidence_interval_upper` SET TAGS ('dbx_business_glossary_term' = 'Baseline Confidence Interval Upper Bound');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`post_event_analysis` ALTER COLUMN `baseline_data_source` SET TAGS ('dbx_business_glossary_term' = 'Baseline Data Source');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`post_event_analysis` ALTER COLUMN `baseline_data_source` SET TAGS ('dbx_value_regex' = 'pos_scan|nielsen_iq|tradeedge_secondary|internal_shipment|syndicated_panel|custom');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`post_event_analysis` ALTER COLUMN `baseline_estimation_methodology` SET TAGS ('dbx_business_glossary_term' = 'Baseline Estimation Methodology');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`post_event_analysis` ALTER COLUMN `baseline_volume_units` SET TAGS ('dbx_business_glossary_term' = 'Baseline Volume Units');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`post_event_analysis` ALTER COLUMN `post_event_analysis_code` SET TAGS ('dbx_business_glossary_term' = 'Post Event Analysis Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`post_event_analysis` ALTER COLUMN `cost_per_incremental_case` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Incremental Case');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`post_event_analysis` ALTER COLUMN `cost_per_incremental_case` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`post_event_analysis` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`post_event_analysis` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`post_event_analysis` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`post_event_analysis` ALTER COLUMN `data_vintage_date` SET TAGS ('dbx_business_glossary_term' = 'Data Vintage Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`post_event_analysis` ALTER COLUMN `post_event_analysis_description` SET TAGS ('dbx_business_glossary_term' = 'Post Event Analysis Description');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`post_event_analysis` ALTER COLUMN `display_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Display Compliance Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`post_event_analysis` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`post_event_analysis` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`post_event_analysis` ALTER COLUMN `feature_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Feature Compliance Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`post_event_analysis` ALTER COLUMN `gmroi` SET TAGS ('dbx_business_glossary_term' = 'Gross Margin Return on Investment (GMROI)');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`post_event_analysis` ALTER COLUMN `gmroi` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`post_event_analysis` ALTER COLUMN `incremental_lift_percentage` SET TAGS ('dbx_business_glossary_term' = 'Incremental Lift Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`post_event_analysis` ALTER COLUMN `incremental_lift_units` SET TAGS ('dbx_business_glossary_term' = 'Incremental Lift Units');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`post_event_analysis` ALTER COLUMN `incremental_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Incremental Revenue Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`post_event_analysis` ALTER COLUMN `incremental_volume` SET TAGS ('dbx_business_glossary_term' = 'Incremental Volume');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`post_event_analysis` ALTER COLUMN `incremental_volume_units` SET TAGS ('dbx_business_glossary_term' = 'Incremental Volume Units');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`post_event_analysis` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`post_event_analysis` ALTER COLUMN `learning_classification` SET TAGS ('dbx_business_glossary_term' = 'Learning Classification');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`post_event_analysis` ALTER COLUMN `learning_classification` SET TAGS ('dbx_value_regex' = 'best_practice|acceptable|underperformer|failure|outlier');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`post_event_analysis` ALTER COLUMN `lift_measurement_methodology` SET TAGS ('dbx_business_glossary_term' = 'Lift Measurement Methodology');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`post_event_analysis` ALTER COLUMN `lift_measurement_methodology` SET TAGS ('dbx_value_regex' = 'simple_difference|control_group|matched_market|time_series|causal_impact|machine_learning');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`post_event_analysis` ALTER COLUMN `lift_measurement_source` SET TAGS ('dbx_business_glossary_term' = 'Lift Measurement Source');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`post_event_analysis` ALTER COLUMN `lift_measurement_source` SET TAGS ('dbx_value_regex' = 'pos_scan|nielsen_iq_panel|tradeedge_secondary|internal_shipment|syndicated_data|blended');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`post_event_analysis` ALTER COLUMN `lift_percentage` SET TAGS ('dbx_business_glossary_term' = 'Lift Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`post_event_analysis` ALTER COLUMN `post_event_analysis_name` SET TAGS ('dbx_business_glossary_term' = 'Post Event Analysis Name');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`post_event_analysis` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`post_event_analysis` ALTER COLUMN `oos_impact_estimated_units` SET TAGS ('dbx_business_glossary_term' = 'Out of Stock (OOS) Impact Estimated Units');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`post_event_analysis` ALTER COLUMN `oos_incident_count` SET TAGS ('dbx_business_glossary_term' = 'Out of Stock (OOS) Incident Count');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`post_event_analysis` ALTER COLUMN `planned_trade_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Planned Trade Spend Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`post_event_analysis` ALTER COLUMN `planned_trade_spend_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`post_event_analysis` ALTER COLUMN `post_event_analysis_status` SET TAGS ('dbx_business_glossary_term' = 'Post Event Analysis Status');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`post_event_analysis` ALTER COLUMN `pre_promotion_trend` SET TAGS ('dbx_business_glossary_term' = 'Pre-Promotion Trend');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`post_event_analysis` ALTER COLUMN `pre_promotion_trend` SET TAGS ('dbx_value_regex' = 'increasing|stable|decreasing|seasonal|volatile');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`post_event_analysis` ALTER COLUMN `pricing_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Pricing Compliance Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`post_event_analysis` ALTER COLUMN `profitability_amount` SET TAGS ('dbx_business_glossary_term' = 'Profitability Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`post_event_analysis` ALTER COLUMN `promotional_roi` SET TAGS ('dbx_business_glossary_term' = 'Promotional Return on Investment (ROI)');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`post_event_analysis` ALTER COLUMN `promotional_roi` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`post_event_analysis` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`post_event_analysis` ALTER COLUMN `recommendation_for_future` SET TAGS ('dbx_business_glossary_term' = 'Recommendation for Future Promotions');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`post_event_analysis` ALTER COLUMN `recommendation_for_future` SET TAGS ('dbx_value_regex' = 'repeat|modify|avoid|test_further|scale_up');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`post_event_analysis` ALTER COLUMN `retailer_compliance_score` SET TAGS ('dbx_business_glossary_term' = 'Retailer Compliance Score');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`post_event_analysis` ALTER COLUMN `roi_pct` SET TAGS ('dbx_business_glossary_term' = 'Roi Pct');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`post_event_analysis` ALTER COLUMN `sell_through_rate` SET TAGS ('dbx_business_glossary_term' = 'Sell-Through Rate');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`post_event_analysis` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`post_event_analysis` ALTER COLUMN `total_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Spend Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`post_event_analysis` ALTER COLUMN `trade_spend_variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Trade Spend Variance Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`post_event_analysis` ALTER COLUMN `trade_spend_variance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`post_event_analysis` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`post_event_analysis` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` SET TAGS ('dbx_subdomain' = 'trade_planning');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ALTER COLUMN `promoted_price_id` SET TAGS ('dbx_business_glossary_term' = 'Promoted Price Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ALTER COLUMN `channel_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Channel ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ALTER COLUMN `event_sku_id` SET TAGS ('dbx_business_glossary_term' = 'Event Sku Id');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ALTER COLUMN `promotion_event_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Event ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ALTER COLUMN `tertiary_promoted_last_modified_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ALTER COLUMN `tertiary_promoted_last_modified_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ALTER COLUMN `tertiary_promoted_last_modified_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Account ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ALTER COLUMN `trade_promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Promotion Id');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ALTER COLUMN `accrual_method` SET TAGS ('dbx_business_glossary_term' = 'Accrual Method');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ALTER COLUMN `accrual_method` SET TAGS ('dbx_value_regex' = 'scan_back|bill_back|off_invoice|lump_sum|performance_based');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ALTER COLUMN `promoted_price_code` SET TAGS ('dbx_business_glossary_term' = 'Promoted Price Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ALTER COLUMN `cost_of_goods_sold` SET TAGS ('dbx_business_glossary_term' = 'Cost of Goods Sold (COGS)');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ALTER COLUMN `cost_of_goods_sold` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ALTER COLUMN `promoted_price_description` SET TAGS ('dbx_business_glossary_term' = 'Promoted Price Description');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ALTER COLUMN `discount_pct` SET TAGS ('dbx_business_glossary_term' = 'Discount Pct');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ALTER COLUMN `estimated_volume_lift` SET TAGS ('dbx_business_glossary_term' = 'Estimated Volume Lift Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ALTER COLUMN `funding_source` SET TAGS ('dbx_business_glossary_term' = 'Funding Source');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ALTER COLUMN `funding_source` SET TAGS ('dbx_value_regex' = 'manufacturer|retailer|co_op|vendor|third_party');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ALTER COLUMN `is_advertised` SET TAGS ('dbx_business_glossary_term' = 'Is Advertised Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ALTER COLUMN `is_stackable` SET TAGS ('dbx_business_glossary_term' = 'Is Stackable Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ALTER COLUMN `maximum_purchase_quantity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Purchase Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ALTER COLUMN `minimum_purchase_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Purchase Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ALTER COLUMN `promoted_price_name` SET TAGS ('dbx_business_glossary_term' = 'Promoted Price Name');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ALTER COLUMN `price_reduction_percentage` SET TAGS ('dbx_business_glossary_term' = 'Price Reduction Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ALTER COLUMN `price_start_date` SET TAGS ('dbx_business_glossary_term' = 'Price Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ALTER COLUMN `price_type` SET TAGS ('dbx_business_glossary_term' = 'Price Type');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ALTER COLUMN `pricing_strategy_type` SET TAGS ('dbx_business_glossary_term' = 'Pricing Strategy Type');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ALTER COLUMN `promo_price` SET TAGS ('dbx_business_glossary_term' = 'Promo Price');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ALTER COLUMN `promoted_price_status` SET TAGS ('dbx_business_glossary_term' = 'Promoted Price Status');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ALTER COLUMN `promotional_allowance_amount` SET TAGS ('dbx_business_glossary_term' = 'Promotional Allowance Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ALTER COLUMN `promotional_price_amount` SET TAGS ('dbx_business_glossary_term' = 'Promotional Price Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ALTER COLUMN `promotional_price_code` SET TAGS ('dbx_business_glossary_term' = 'Promotional Price Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ALTER COLUMN `promotional_price_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{4,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ALTER COLUMN `promotional_price_description` SET TAGS ('dbx_business_glossary_term' = 'Promotional Price Description');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ALTER COLUMN `promotional_price_name` SET TAGS ('dbx_business_glossary_term' = 'Promotional Price Name');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ALTER COLUMN `region_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ALTER COLUMN `regular_price` SET TAGS ('dbx_business_glossary_term' = 'Regular Price');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ALTER COLUMN `regular_price_amount` SET TAGS ('dbx_business_glossary_term' = 'Regular Price Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ALTER COLUMN `regular_shelf_price` SET TAGS ('dbx_business_glossary_term' = 'Regular Shelf Price (RSP)');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ALTER COLUMN `retailer_margin_percentage` SET TAGS ('dbx_business_glossary_term' = 'Retailer Margin Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ALTER COLUMN `scan_back_rate` SET TAGS ('dbx_business_glossary_term' = 'Scan-Back Rate');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ALTER COLUMN `tpm_system_code` SET TAGS ('dbx_business_glossary_term' = 'Trade Promotion Management (TPM) System ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`lift_measurement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`lift_measurement` SET TAGS ('dbx_subdomain' = 'performance_measurement');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`lift_measurement` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`lift_measurement` ALTER COLUMN `lift_measurement_id` SET TAGS ('dbx_business_glossary_term' = 'Lift Measurement ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`lift_measurement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Analyst ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`lift_measurement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`lift_measurement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`lift_measurement` ALTER COLUMN `promotion_event_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Event Id');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`lift_measurement` ALTER COLUMN `retail_store_id` SET TAGS ('dbx_business_glossary_term' = 'Retail Store ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`lift_measurement` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`lift_measurement` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Account ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`lift_measurement` ALTER COLUMN `trade_promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Promotion ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`lift_measurement` ALTER COLUMN `actual_promoted_volume_units` SET TAGS ('dbx_business_glossary_term' = 'Actual Promoted Volume Units');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`lift_measurement` ALTER COLUMN `actual_volume` SET TAGS ('dbx_business_glossary_term' = 'Actual Volume');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`lift_measurement` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`lift_measurement` ALTER COLUMN `baseline_calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Baseline Calculation Method');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`lift_measurement` ALTER COLUMN `baseline_calculation_method` SET TAGS ('dbx_value_regex' = 'moving_average|exponential_smoothing|linear_regression|seasonal_decomposition|custom_model');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`lift_measurement` ALTER COLUMN `baseline_calculation_method` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`lift_measurement` ALTER COLUMN `baseline_calculation_method` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`lift_measurement` ALTER COLUMN `baseline_period_weeks` SET TAGS ('dbx_business_glossary_term' = 'Baseline Period Weeks');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`lift_measurement` ALTER COLUMN `baseline_volume` SET TAGS ('dbx_business_glossary_term' = 'Baseline Volume');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`lift_measurement` ALTER COLUMN `baseline_volume_units` SET TAGS ('dbx_business_glossary_term' = 'Baseline Volume Units');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`lift_measurement` ALTER COLUMN `cannibalization_rate` SET TAGS ('dbx_business_glossary_term' = 'Cannibalization Rate');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`lift_measurement` ALTER COLUMN `lift_measurement_code` SET TAGS ('dbx_business_glossary_term' = 'Lift Measurement Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`lift_measurement` ALTER COLUMN `confidence_interval_lower` SET TAGS ('dbx_business_glossary_term' = 'Confidence Interval Lower Bound');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`lift_measurement` ALTER COLUMN `confidence_interval_upper` SET TAGS ('dbx_business_glossary_term' = 'Confidence Interval Upper Bound');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`lift_measurement` ALTER COLUMN `confidence_level_percentage` SET TAGS ('dbx_business_glossary_term' = 'Confidence Level Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`lift_measurement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`lift_measurement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`lift_measurement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`lift_measurement` ALTER COLUMN `data_vintage_date` SET TAGS ('dbx_business_glossary_term' = 'Data Vintage Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`lift_measurement` ALTER COLUMN `lift_measurement_description` SET TAGS ('dbx_business_glossary_term' = 'Lift Measurement Description');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`lift_measurement` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`lift_measurement` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`lift_measurement` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`lift_measurement` ALTER COLUMN `halo_effect_units` SET TAGS ('dbx_business_glossary_term' = 'Halo Effect Units');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`lift_measurement` ALTER COLUMN `incremental_lift_percentage` SET TAGS ('dbx_business_glossary_term' = 'Incremental Lift Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`lift_measurement` ALTER COLUMN `incremental_lift_units` SET TAGS ('dbx_business_glossary_term' = 'Incremental Lift Units');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`lift_measurement` ALTER COLUMN `incremental_revenue` SET TAGS ('dbx_business_glossary_term' = 'Incremental Revenue');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`lift_measurement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`lift_measurement` ALTER COLUMN `lift_measurement_status` SET TAGS ('dbx_business_glossary_term' = 'Lift Measurement Status');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`lift_measurement` ALTER COLUMN `lift_pct` SET TAGS ('dbx_business_glossary_term' = 'Lift Pct');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`lift_measurement` ALTER COLUMN `lift_percentage` SET TAGS ('dbx_business_glossary_term' = 'Lift Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`lift_measurement` ALTER COLUMN `lift_source` SET TAGS ('dbx_business_glossary_term' = 'Lift Source');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`lift_measurement` ALTER COLUMN `lift_source` SET TAGS ('dbx_value_regex' = 'pos_scan_data|nielsen_iq_panel|tradeedge_secondary_sales|iri_panel|internal_shipment_data|syndicated_data');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`lift_measurement` ALTER COLUMN `lift_units` SET TAGS ('dbx_business_glossary_term' = 'Lift Units');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`lift_measurement` ALTER COLUMN `measurement_date` SET TAGS ('dbx_business_glossary_term' = 'Measurement Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`lift_measurement` ALTER COLUMN `measurement_method` SET TAGS ('dbx_business_glossary_term' = 'Measurement Method');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`lift_measurement` ALTER COLUMN `measurement_methodology` SET TAGS ('dbx_business_glossary_term' = 'Measurement Methodology');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`lift_measurement` ALTER COLUMN `measurement_methodology` SET TAGS ('dbx_value_regex' = 'pre_post_comparison|control_group|time_series_regression|matched_market|causal_impact');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`lift_measurement` ALTER COLUMN `measurement_notes` SET TAGS ('dbx_business_glossary_term' = 'Measurement Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`lift_measurement` ALTER COLUMN `measurement_period` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`lift_measurement` ALTER COLUMN `measurement_status` SET TAGS ('dbx_business_glossary_term' = 'Measurement Status');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`lift_measurement` ALTER COLUMN `measurement_status` SET TAGS ('dbx_value_regex' = 'preliminary|validated|final|revised|rejected');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`lift_measurement` ALTER COLUMN `measurement_week_end_date` SET TAGS ('dbx_business_glossary_term' = 'Measurement Week End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`lift_measurement` ALTER COLUMN `measurement_week_start_date` SET TAGS ('dbx_business_glossary_term' = 'Measurement Week Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`lift_measurement` ALTER COLUMN `lift_measurement_name` SET TAGS ('dbx_business_glossary_term' = 'Lift Measurement Name');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`lift_measurement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`lift_measurement` ALTER COLUMN `p_value` SET TAGS ('dbx_business_glossary_term' = 'P-Value');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`lift_measurement` ALTER COLUMN `post_promotion_dip_units` SET TAGS ('dbx_business_glossary_term' = 'Post-Promotion Dip Units');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`lift_measurement` ALTER COLUMN `promoted_volume` SET TAGS ('dbx_business_glossary_term' = 'Promoted Volume');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`lift_measurement` ALTER COLUMN `promotional_price` SET TAGS ('dbx_business_glossary_term' = 'Promotional Price');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`lift_measurement` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`lift_measurement` ALTER COLUMN `regular_price` SET TAGS ('dbx_business_glossary_term' = 'Regular Price');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`lift_measurement` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`lift_measurement` ALTER COLUMN `statistical_significance_flag` SET TAGS ('dbx_business_glossary_term' = 'Statistical Significance Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`lift_measurement` ALTER COLUMN `tpm_system_reference_code` SET TAGS ('dbx_business_glossary_term' = 'Trade Promotion Management (TPM) System Reference ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`lift_measurement` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`lift_measurement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`lift_measurement` ALTER COLUMN `validated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Validated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`tpo_scenario` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`tpo_scenario` SET TAGS ('dbx_subdomain' = 'trade_planning');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`tpo_scenario` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`tpo_scenario` ALTER COLUMN `tpo_scenario_id` SET TAGS ('dbx_business_glossary_term' = 'Baseline Scenario ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`tpo_scenario` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`tpo_scenario` ALTER COLUMN `channel_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Channel ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`tpo_scenario` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`tpo_scenario` ALTER COLUMN `parent_scenario_tpo_scenario_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Scenario ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`tpo_scenario` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Scenario Owner User ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`tpo_scenario` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`tpo_scenario` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`tpo_scenario` ALTER COLUMN `rd_project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`tpo_scenario` ALTER COLUMN `tertiary_tpo_approved_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`tpo_scenario` ALTER COLUMN `tertiary_tpo_approved_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`tpo_scenario` ALTER COLUMN `tertiary_tpo_approved_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`tpo_scenario` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Account ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`tpo_scenario` ALTER COLUMN `trade_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Calendar ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`tpo_scenario` ALTER COLUMN `trade_promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Promotion Id');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`tpo_scenario` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`tpo_scenario` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`tpo_scenario` ALTER COLUMN `tpo_scenario_code` SET TAGS ('dbx_business_glossary_term' = 'Tpo Scenario Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`tpo_scenario` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`tpo_scenario` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`tpo_scenario` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`tpo_scenario` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`tpo_scenario` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`tpo_scenario` ALTER COLUMN `tpo_scenario_description` SET TAGS ('dbx_business_glossary_term' = 'Tpo Scenario Description');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`tpo_scenario` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`tpo_scenario` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`tpo_scenario` ALTER COLUMN `evaluation_date` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`tpo_scenario` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`tpo_scenario` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_value_regex' = 'national|regional|local|global');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`tpo_scenario` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`tpo_scenario` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`tpo_scenario` ALTER COLUMN `is_baseline_scenario` SET TAGS ('dbx_business_glossary_term' = 'Is Baseline Scenario Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`tpo_scenario` ALTER COLUMN `is_recommended` SET TAGS ('dbx_business_glossary_term' = 'Is Recommended');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`tpo_scenario` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`tpo_scenario` ALTER COLUMN `tpo_scenario_name` SET TAGS ('dbx_business_glossary_term' = 'Tpo Scenario Name');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`tpo_scenario` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Scenario Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`tpo_scenario` ALTER COLUMN `optimization_objective` SET TAGS ('dbx_business_glossary_term' = 'Optimization Objective');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`tpo_scenario` ALTER COLUMN `optimization_objective` SET TAGS ('dbx_value_regex' = 'maximize_volume|maximize_roi|maximize_gmroi|minimize_oos|maximize_profit|balanced_growth');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`tpo_scenario` ALTER COLUMN `planning_horizon_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`tpo_scenario` ALTER COLUMN `planning_horizon_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`tpo_scenario` ALTER COLUMN `predicted_roi_percentage` SET TAGS ('dbx_business_glossary_term' = 'Predicted Roi Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`tpo_scenario` ALTER COLUMN `predicted_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Predicted Spend Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`tpo_scenario` ALTER COLUMN `predicted_volume_units` SET TAGS ('dbx_business_glossary_term' = 'Predicted Volume Units');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`tpo_scenario` ALTER COLUMN `projected_baseline_revenue` SET TAGS ('dbx_business_glossary_term' = 'Projected Baseline Revenue');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`tpo_scenario` ALTER COLUMN `projected_baseline_volume` SET TAGS ('dbx_business_glossary_term' = 'Projected Baseline Volume');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`tpo_scenario` ALTER COLUMN `projected_gmroi` SET TAGS ('dbx_business_glossary_term' = 'Projected Gross Margin Return on Investment (GMROI)');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`tpo_scenario` ALTER COLUMN `projected_gross_profit` SET TAGS ('dbx_business_glossary_term' = 'Projected Gross Profit');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`tpo_scenario` ALTER COLUMN `projected_incremental_revenue` SET TAGS ('dbx_business_glossary_term' = 'Projected Incremental Revenue');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`tpo_scenario` ALTER COLUMN `projected_incremental_volume` SET TAGS ('dbx_business_glossary_term' = 'Projected Incremental Volume');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`tpo_scenario` ALTER COLUMN `projected_promotional_lift_percentage` SET TAGS ('dbx_business_glossary_term' = 'Projected Promotional Lift Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`tpo_scenario` ALTER COLUMN `projected_roi_pct` SET TAGS ('dbx_business_glossary_term' = 'Projected Roi Pct');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`tpo_scenario` ALTER COLUMN `projected_roi_percentage` SET TAGS ('dbx_business_glossary_term' = 'Projected Return on Investment (ROI) Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`tpo_scenario` ALTER COLUMN `projected_total_revenue` SET TAGS ('dbx_business_glossary_term' = 'Projected Total Revenue');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`tpo_scenario` ALTER COLUMN `projected_total_volume` SET TAGS ('dbx_business_glossary_term' = 'Projected Total Volume');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`tpo_scenario` ALTER COLUMN `projected_volume` SET TAGS ('dbx_business_glossary_term' = 'Projected Volume');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`tpo_scenario` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`tpo_scenario` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`tpo_scenario` ALTER COLUMN `scenario_description` SET TAGS ('dbx_business_glossary_term' = 'Scenario Description');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`tpo_scenario` ALTER COLUMN `scenario_name` SET TAGS ('dbx_business_glossary_term' = 'Scenario Name');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`tpo_scenario` ALTER COLUMN `scenario_number` SET TAGS ('dbx_business_glossary_term' = 'Scenario Number');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`tpo_scenario` ALTER COLUMN `scenario_number` SET TAGS ('dbx_value_regex' = '^TPO-[0-9]{6,10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`tpo_scenario` ALTER COLUMN `scenario_status` SET TAGS ('dbx_business_glossary_term' = 'Scenario Status');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`tpo_scenario` ALTER COLUMN `scenario_status` SET TAGS ('dbx_value_regex' = 'draft|evaluated|approved|rejected|archived|in_review');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`tpo_scenario` ALTER COLUMN `scenario_type` SET TAGS ('dbx_business_glossary_term' = 'Scenario Type');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`tpo_scenario` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`tpo_scenario` ALTER COLUMN `total_scenario_spend` SET TAGS ('dbx_business_glossary_term' = 'Total Scenario Spend');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`tpo_scenario` ALTER COLUMN `tpm_system_reference_code` SET TAGS ('dbx_business_glossary_term' = 'Trade Promotion Management (TPM) System Reference ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`tpo_scenario` ALTER COLUMN `tpo_scenario_status` SET TAGS ('dbx_business_glossary_term' = 'Tpo Scenario Status');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`tpo_scenario` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`tpo_scenario` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`tpo_scenario` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`tpo_scenario` ALTER COLUMN `volume_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Volume Unit of Measure');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`tpo_scenario` ALTER COLUMN `volume_unit_of_measure` SET TAGS ('dbx_value_regex' = 'units|cases|pallets|kg|liters');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`retailer_compliance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`retailer_compliance` SET TAGS ('dbx_subdomain' = 'performance_measurement');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`retailer_compliance` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`retailer_compliance` ALTER COLUMN `retailer_compliance_id` SET TAGS ('dbx_business_glossary_term' = 'Retailer Compliance ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`retailer_compliance` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Auditor User ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`retailer_compliance` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`retailer_compliance` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`retailer_compliance` ALTER COLUMN `promotion_event_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Event Id');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`retailer_compliance` ALTER COLUMN `rd_project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`retailer_compliance` ALTER COLUMN `retail_store_id` SET TAGS ('dbx_business_glossary_term' = 'Retail Store ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`retailer_compliance` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Account ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`retailer_compliance` ALTER COLUMN `trade_promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Promotion ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`retailer_compliance` ALTER COLUMN `actual_retail_price` SET TAGS ('dbx_business_glossary_term' = 'Actual Retail Price');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`retailer_compliance` ALTER COLUMN `ad_feature_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Ad Feature Compliant Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`retailer_compliance` ALTER COLUMN `agreed_promotional_price` SET TAGS ('dbx_business_glossary_term' = 'Agreed Promotional Price');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`retailer_compliance` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`retailer_compliance` ALTER COLUMN `audit_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`retailer_compliance` ALTER COLUMN `audit_method` SET TAGS ('dbx_business_glossary_term' = 'Audit Method');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`retailer_compliance` ALTER COLUMN `audit_method` SET TAGS ('dbx_value_regex' = 'field_rep_visit|third_party_audit|pos_data_analysis|photo_verification|retailer_self_report');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`retailer_compliance` ALTER COLUMN `auditor_name` SET TAGS ('dbx_business_glossary_term' = 'Auditor Name');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`retailer_compliance` ALTER COLUMN `retailer_compliance_code` SET TAGS ('dbx_business_glossary_term' = 'Retailer Compliance Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`retailer_compliance` ALTER COLUMN `compliance_check_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Check Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`retailer_compliance` ALTER COLUMN `compliance_score` SET TAGS ('dbx_business_glossary_term' = 'Compliance Score');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`retailer_compliance` ALTER COLUMN `compliance_score_percentage` SET TAGS ('dbx_business_glossary_term' = 'Compliance Score Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`retailer_compliance` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`retailer_compliance` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|partial_compliant|pending_review|disputed');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`retailer_compliance` ALTER COLUMN `compliance_type` SET TAGS ('dbx_business_glossary_term' = 'Compliance Type');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`retailer_compliance` ALTER COLUMN `compliance_type` SET TAGS ('dbx_value_regex' = 'ad_feature|display|price_compliance|osa|pog_placement|multi_mechanic');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`retailer_compliance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`retailer_compliance` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`retailer_compliance` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`retailer_compliance` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`retailer_compliance` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'sfa_field_audit|third_party_service|pos_integration|retailer_portal|manual_entry');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`retailer_compliance` ALTER COLUMN `data_source_reference_code` SET TAGS ('dbx_business_glossary_term' = 'Data Source Reference ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`retailer_compliance` ALTER COLUMN `retailer_compliance_description` SET TAGS ('dbx_business_glossary_term' = 'Retailer Compliance Description');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`retailer_compliance` ALTER COLUMN `display_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Display Compliant Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`retailer_compliance` ALTER COLUMN `display_executed` SET TAGS ('dbx_business_glossary_term' = 'Display Executed');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`retailer_compliance` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`retailer_compliance` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`retailer_compliance` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`retailer_compliance` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`retailer_compliance` ALTER COLUMN `funding_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Funding Adjustment Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`retailer_compliance` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`retailer_compliance` ALTER COLUMN `retailer_compliance_name` SET TAGS ('dbx_business_glossary_term' = 'Retailer Compliance Name');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`retailer_compliance` ALTER COLUMN `non_compliance_category` SET TAGS ('dbx_business_glossary_term' = 'Non-Compliance Category');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`retailer_compliance` ALTER COLUMN `non_compliance_category` SET TAGS ('dbx_value_regex' = 'inventory_shortage|pricing_error|display_not_built|ad_omission|operational_failure|system_error');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`retailer_compliance` ALTER COLUMN `non_compliance_reason` SET TAGS ('dbx_business_glossary_term' = 'Non-Compliance Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`retailer_compliance` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`retailer_compliance` ALTER COLUMN `osa_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'On Shelf Availability (OSA) Compliant Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`retailer_compliance` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`retailer_compliance` ALTER COLUMN `photo_evidence_url` SET TAGS ('dbx_business_glossary_term' = 'Photo Evidence URL');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`retailer_compliance` ALTER COLUMN `pog_placement_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Planogram (POG) Placement Compliant Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`retailer_compliance` ALTER COLUMN `price_compliant` SET TAGS ('dbx_business_glossary_term' = 'Price Compliant');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`retailer_compliance` ALTER COLUMN `price_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Price Compliant Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`retailer_compliance` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`retailer_compliance` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`retailer_compliance` ALTER COLUMN `resolution_outcome` SET TAGS ('dbx_business_glossary_term' = 'Resolution Outcome');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`retailer_compliance` ALTER COLUMN `resolution_outcome` SET TAGS ('dbx_value_regex' = 'upheld|overturned|partial_adjustment|withdrawn');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`retailer_compliance` ALTER COLUMN `retailer_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Retailer Compliance Status');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`retailer_compliance` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`retailer_compliance` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`retailer_compliance` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`baseline_volume` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`baseline_volume` SET TAGS ('dbx_subdomain' = 'performance_measurement');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`baseline_volume` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`baseline_volume` ALTER COLUMN `baseline_volume_id` SET TAGS ('dbx_business_glossary_term' = 'Baseline Volume ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`baseline_volume` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`baseline_volume` ALTER COLUMN `channel_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Channel ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`baseline_volume` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`baseline_volume` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Overridden By User ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`baseline_volume` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`baseline_volume` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`baseline_volume` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`baseline_volume` ALTER COLUMN `tertiary_baseline_created_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`baseline_volume` ALTER COLUMN `tertiary_baseline_created_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`baseline_volume` ALTER COLUMN `tertiary_baseline_created_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`baseline_volume` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Account ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`baseline_volume` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`baseline_volume` ALTER COLUMN `analyst_override_flag` SET TAGS ('dbx_business_glossary_term' = 'Analyst Override Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`baseline_volume` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`baseline_volume` ALTER COLUMN `baseline_method` SET TAGS ('dbx_business_glossary_term' = 'Baseline Method');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`baseline_volume` ALTER COLUMN `baseline_methodology` SET TAGS ('dbx_business_glossary_term' = 'Baseline Methodology');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`baseline_volume` ALTER COLUMN `baseline_methodology` SET TAGS ('dbx_value_regex' = 'moving_average|regression|nielsen_iq_panel|bayesian_structural_time_series|exponential_smoothing|seasonal_decomposition');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`baseline_volume` ALTER COLUMN `baseline_period` SET TAGS ('dbx_business_glossary_term' = 'Baseline Period');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`baseline_volume` ALTER COLUMN `baseline_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Period End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`baseline_volume` ALTER COLUMN `baseline_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Period Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`baseline_volume` ALTER COLUMN `baseline_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Baseline Revenue Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`baseline_volume` ALTER COLUMN `baseline_status` SET TAGS ('dbx_business_glossary_term' = 'Baseline Status');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`baseline_volume` ALTER COLUMN `baseline_status` SET TAGS ('dbx_value_regex' = 'draft|approved|active|archived|superseded|rejected');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`baseline_volume` ALTER COLUMN `baseline_units` SET TAGS ('dbx_business_glossary_term' = 'Baseline Units');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`baseline_volume` ALTER COLUMN `baseline_volume_status` SET TAGS ('dbx_business_glossary_term' = 'Baseline Volume Status');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`baseline_volume` ALTER COLUMN `calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Calculation Method');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`baseline_volume` ALTER COLUMN `calculation_method` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`baseline_volume` ALTER COLUMN `calculation_method` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`baseline_volume` ALTER COLUMN `calculation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Calculation Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`baseline_volume` ALTER COLUMN `calculation_timestamp` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`baseline_volume` ALTER COLUMN `calculation_timestamp` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`baseline_volume` ALTER COLUMN `cases` SET TAGS ('dbx_business_glossary_term' = 'Baseline Volume Cases');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`baseline_volume` ALTER COLUMN `baseline_volume_code` SET TAGS ('dbx_business_glossary_term' = 'Baseline Volume Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`baseline_volume` ALTER COLUMN `confidence_interval_lower` SET TAGS ('dbx_business_glossary_term' = 'Confidence Interval Lower Bound');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`baseline_volume` ALTER COLUMN `confidence_interval_upper` SET TAGS ('dbx_business_glossary_term' = 'Confidence Interval Upper Bound');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`baseline_volume` ALTER COLUMN `confidence_level_percent` SET TAGS ('dbx_business_glossary_term' = 'Confidence Level Percent');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`baseline_volume` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`baseline_volume` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`baseline_volume` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`baseline_volume` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`baseline_volume` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'pos|nielsen_iq|iri|internal_sales|trade_edge|syndicated_panel');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`baseline_volume` ALTER COLUMN `baseline_volume_description` SET TAGS ('dbx_business_glossary_term' = 'Baseline Volume Description');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`baseline_volume` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`baseline_volume` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`baseline_volume` ALTER COLUMN `geography_code` SET TAGS ('dbx_business_glossary_term' = 'Geography Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`baseline_volume` ALTER COLUMN `geography_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`baseline_volume` ALTER COLUMN `geography_code` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`baseline_volume` ALTER COLUMN `geography_code` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`baseline_volume` ALTER COLUMN `historical_lookback_weeks` SET TAGS ('dbx_business_glossary_term' = 'Historical Lookback Weeks');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`baseline_volume` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`baseline_volume` ALTER COLUMN `last_refresh_date` SET TAGS ('dbx_business_glossary_term' = 'Last Refresh Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`baseline_volume` ALTER COLUMN `model_accuracy_score` SET TAGS ('dbx_business_glossary_term' = 'Model Accuracy Score');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`baseline_volume` ALTER COLUMN `model_version` SET TAGS ('dbx_business_glossary_term' = 'Model Version');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`baseline_volume` ALTER COLUMN `baseline_volume_name` SET TAGS ('dbx_business_glossary_term' = 'Baseline Volume Name');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`baseline_volume` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`baseline_volume` ALTER COLUMN `outlier_exclusion_flag` SET TAGS ('dbx_business_glossary_term' = 'Outlier Exclusion Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`baseline_volume` ALTER COLUMN `override_reason` SET TAGS ('dbx_business_glossary_term' = 'Override Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`baseline_volume` ALTER COLUMN `override_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Override Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`baseline_volume` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Period End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`baseline_volume` ALTER COLUMN `period_start` SET TAGS ('dbx_business_glossary_term' = 'Period Start');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`baseline_volume` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Period Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`baseline_volume` ALTER COLUMN `promotional_periods_excluded_count` SET TAGS ('dbx_business_glossary_term' = 'Promotional Periods Excluded Count');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`baseline_volume` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`baseline_volume` ALTER COLUMN `seasonality_adjustment_factor` SET TAGS ('dbx_business_glossary_term' = 'Seasonality Adjustment Factor');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`baseline_volume` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`baseline_volume` ALTER COLUMN `tpm_system_reference_code` SET TAGS ('dbx_business_glossary_term' = 'Trade Promotion Management (TPM) System Reference ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`baseline_volume` ALTER COLUMN `trend_adjustment_factor` SET TAGS ('dbx_business_glossary_term' = 'Trend Adjustment Factor');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`baseline_volume` ALTER COLUMN `units` SET TAGS ('dbx_business_glossary_term' = 'Baseline Volume Units');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`baseline_volume` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`baseline_volume` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`pos_redemption` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`pos_redemption` SET TAGS ('dbx_subdomain' = 'performance_measurement');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`pos_redemption` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`pos_redemption` ALTER COLUMN `pos_redemption_id` SET TAGS ('dbx_business_glossary_term' = 'Point-of-Sale (POS) Redemption ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`pos_redemption` ALTER COLUMN `consumer_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Consumer Offer Id');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`pos_redemption` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Cashier ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`pos_redemption` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`pos_redemption` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`pos_redemption` ALTER COLUMN `loyalty_account_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Account ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`pos_redemption` ALTER COLUMN `loyalty_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`pos_redemption` ALTER COLUMN `loyalty_account_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`pos_redemption` ALTER COLUMN `promotion_event_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Event ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`pos_redemption` ALTER COLUMN `retail_store_id` SET TAGS ('dbx_business_glossary_term' = 'Retail Store ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`pos_redemption` ALTER COLUMN `shopper_id` SET TAGS ('dbx_business_glossary_term' = 'Shopper ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`pos_redemption` ALTER COLUMN `shopper_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`pos_redemption` ALTER COLUMN `shopper_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`pos_redemption` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`pos_redemption` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Account ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`pos_redemption` ALTER COLUMN `trade_promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Promotion Id');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`pos_redemption` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`pos_redemption` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Channel');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`pos_redemption` ALTER COLUMN `clearinghouse_name` SET TAGS ('dbx_business_glossary_term' = 'Clearinghouse Name');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`pos_redemption` ALTER COLUMN `clearinghouse_transaction_code` SET TAGS ('dbx_business_glossary_term' = 'Clearinghouse Transaction ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`pos_redemption` ALTER COLUMN `pos_redemption_code` SET TAGS ('dbx_business_glossary_term' = 'Pos Redemption Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`pos_redemption` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`pos_redemption` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`pos_redemption` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`pos_redemption` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`pos_redemption` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`pos_redemption` ALTER COLUMN `data_received_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Data Received Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`pos_redemption` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`pos_redemption` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'edi_844|edi_849|retailer_pos_feed|coupon_clearinghouse|tpm_system|e_commerce_platform');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`pos_redemption` ALTER COLUMN `pos_redemption_description` SET TAGS ('dbx_business_glossary_term' = 'Pos Redemption Description');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`pos_redemption` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`pos_redemption` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`pos_redemption` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`pos_redemption` ALTER COLUMN `gtin` SET TAGS ('dbx_business_glossary_term' = 'Global Trade Item Number (GTIN)');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`pos_redemption` ALTER COLUMN `gtin` SET TAGS ('dbx_value_regex' = '^[0-9]{8,14}$');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`pos_redemption` ALTER COLUMN `handling_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Handling Fee Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`pos_redemption` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`pos_redemption` ALTER COLUMN `pos_redemption_name` SET TAGS ('dbx_business_glossary_term' = 'Pos Redemption Name');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`pos_redemption` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`pos_redemption` ALTER COLUMN `offer_code` SET TAGS ('dbx_business_glossary_term' = 'Offer Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`pos_redemption` ALTER COLUMN `offer_type` SET TAGS ('dbx_business_glossary_term' = 'Offer Type');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`pos_redemption` ALTER COLUMN `offer_type` SET TAGS ('dbx_value_regex' = 'manufacturer_coupon|retailer_coupon|digital_offer|loyalty_reward|scan_back_discount|instant_rebate');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`pos_redemption` ALTER COLUMN `pos_redemption_status` SET TAGS ('dbx_business_glossary_term' = 'Pos Redemption Status');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`pos_redemption` ALTER COLUMN `pos_terminal_code` SET TAGS ('dbx_business_glossary_term' = 'Point-of-Sale (POS) Terminal ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`pos_redemption` ALTER COLUMN `promoted_unit_price` SET TAGS ('dbx_business_glossary_term' = 'Promoted Unit Price');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`pos_redemption` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`pos_redemption` ALTER COLUMN `redemption_channel` SET TAGS ('dbx_business_glossary_term' = 'Redemption Channel');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`pos_redemption` ALTER COLUMN `redemption_channel` SET TAGS ('dbx_value_regex' = 'in_store|e_commerce|dtc|mobile_app|call_center');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`pos_redemption` ALTER COLUMN `redemption_count` SET TAGS ('dbx_business_glossary_term' = 'Redemption Count');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`pos_redemption` ALTER COLUMN `redemption_date` SET TAGS ('dbx_business_glossary_term' = 'Redemption Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`pos_redemption` ALTER COLUMN `redemption_quantity` SET TAGS ('dbx_business_glossary_term' = 'Redemption Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`pos_redemption` ALTER COLUMN `redemption_status` SET TAGS ('dbx_business_glossary_term' = 'Redemption Status');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`pos_redemption` ALTER COLUMN `redemption_status` SET TAGS ('dbx_value_regex' = 'validated|pending_validation|rejected|settled|disputed');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`pos_redemption` ALTER COLUMN `redemption_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Redemption Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`pos_redemption` ALTER COLUMN `redemption_transaction_number` SET TAGS ('dbx_business_glossary_term' = 'Redemption Transaction Number');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`pos_redemption` ALTER COLUMN `redemption_value` SET TAGS ('dbx_business_glossary_term' = 'Redemption Value');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`pos_redemption` ALTER COLUMN `redemption_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Redemption Value Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`pos_redemption` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`pos_redemption` ALTER COLUMN `regular_unit_price` SET TAGS ('dbx_business_glossary_term' = 'Regular Unit Price');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`pos_redemption` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`pos_redemption` ALTER COLUMN `settlement_amount` SET TAGS ('dbx_business_glossary_term' = 'Settlement Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`pos_redemption` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`pos_redemption` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`pos_redemption` ALTER COLUMN `transaction_total_amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Total Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`pos_redemption` ALTER COLUMN `unit_discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Unit Discount Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`pos_redemption` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`pos_redemption` ALTER COLUMN `upc` SET TAGS ('dbx_business_glossary_term' = 'Universal Product Code (UPC)');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`pos_redemption` ALTER COLUMN `upc` SET TAGS ('dbx_value_regex' = '^[0-9]{12}$');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`pos_redemption` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`pos_redemption` ALTER COLUMN `validation_flag` SET TAGS ('dbx_business_glossary_term' = 'Validation Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`pos_redemption` ALTER COLUMN `validation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Validation Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`consumer_offer` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`consumer_offer` SET TAGS ('dbx_subdomain' = 'trade_planning');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`consumer_offer` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`consumer_offer` ALTER COLUMN `consumer_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Consumer Offer ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`consumer_offer` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Campaign ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`consumer_offer` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`consumer_offer` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`consumer_offer` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`consumer_offer` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`consumer_offer` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`consumer_offer` ALTER COLUMN `promotion_event_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Event Id');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`consumer_offer` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Target Segment Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`consumer_offer` ALTER COLUMN `trade_promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Promotion ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`consumer_offer` ALTER COLUMN `actual_cost_incurred` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost Incurred');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`consumer_offer` ALTER COLUMN `actual_redemption_count` SET TAGS ('dbx_business_glossary_term' = 'Actual Redemption Count');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`consumer_offer` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`consumer_offer` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`consumer_offer` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`consumer_offer` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`consumer_offer` ALTER COLUMN `barcode` SET TAGS ('dbx_business_glossary_term' = 'Offer Barcode');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`consumer_offer` ALTER COLUMN `consumer_offer_code` SET TAGS ('dbx_business_glossary_term' = 'Consumer Offer Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`consumer_offer` ALTER COLUMN `consumer_offer_status` SET TAGS ('dbx_business_glossary_term' = 'Consumer Offer Status');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`consumer_offer` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`consumer_offer` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`consumer_offer` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`consumer_offer` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`consumer_offer` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`consumer_offer` ALTER COLUMN `consumer_offer_description` SET TAGS ('dbx_business_glossary_term' = 'Offer Description');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`consumer_offer` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`consumer_offer` ALTER COLUMN `discount_value` SET TAGS ('dbx_business_glossary_term' = 'Discount Value');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`consumer_offer` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`consumer_offer` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`consumer_offer` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`consumer_offer` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`consumer_offer` ALTER COLUMN `estimated_cost_per_redemption` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost Per Redemption');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`consumer_offer` ALTER COLUMN `funding_source` SET TAGS ('dbx_business_glossary_term' = 'Funding Source');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`consumer_offer` ALTER COLUMN `funding_source` SET TAGS ('dbx_value_regex' = 'brand|trade|co_op|retailer');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`consumer_offer` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`consumer_offer` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_value_regex' = 'national|regional|local|store_specific');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`consumer_offer` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`consumer_offer` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`consumer_offer` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`consumer_offer` ALTER COLUMN `max_redemptions` SET TAGS ('dbx_business_glossary_term' = 'Max Redemptions');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`consumer_offer` ALTER COLUMN `maximum_redemption_per_customer` SET TAGS ('dbx_business_glossary_term' = 'Maximum Redemption Per Customer');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`consumer_offer` ALTER COLUMN `minimum_purchase_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Purchase Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`consumer_offer` ALTER COLUMN `minimum_purchase_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Purchase Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`consumer_offer` ALTER COLUMN `consumer_offer_name` SET TAGS ('dbx_business_glossary_term' = 'Consumer Offer Name');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`consumer_offer` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`consumer_offer` ALTER COLUMN `offer_code` SET TAGS ('dbx_business_glossary_term' = 'Offer Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`consumer_offer` ALTER COLUMN `offer_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`consumer_offer` ALTER COLUMN `offer_end_date` SET TAGS ('dbx_business_glossary_term' = 'Offer End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`consumer_offer` ALTER COLUMN `offer_name` SET TAGS ('dbx_business_glossary_term' = 'Offer Name');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`consumer_offer` ALTER COLUMN `offer_start_date` SET TAGS ('dbx_business_glossary_term' = 'Offer Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`consumer_offer` ALTER COLUMN `offer_status` SET TAGS ('dbx_business_glossary_term' = 'Offer Status');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`consumer_offer` ALTER COLUMN `offer_status` SET TAGS ('dbx_value_regex' = 'draft|approved|active|paused|expired|cancelled');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`consumer_offer` ALTER COLUMN `offer_type` SET TAGS ('dbx_business_glossary_term' = 'Offer Type');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`consumer_offer` ALTER COLUMN `offer_value` SET TAGS ('dbx_business_glossary_term' = 'Offer Value');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`consumer_offer` ALTER COLUMN `qualifying_sku_list` SET TAGS ('dbx_business_glossary_term' = 'Qualifying SKU (Stock Keeping Unit) List');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`consumer_offer` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`consumer_offer` ALTER COLUMN `redemption_channel` SET TAGS ('dbx_business_glossary_term' = 'Redemption Channel');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`consumer_offer` ALTER COLUMN `redemption_channel` SET TAGS ('dbx_value_regex' = 'in_store|online|mobile_app|call_center|any');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`consumer_offer` ALTER COLUMN `redemption_limit` SET TAGS ('dbx_business_glossary_term' = 'Redemption Limit');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`consumer_offer` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`consumer_offer` ALTER COLUMN `stackable_flag` SET TAGS ('dbx_business_glossary_term' = 'Stackable Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`consumer_offer` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`consumer_offer` ALTER COLUMN `terms_and_conditions` SET TAGS ('dbx_business_glossary_term' = 'Terms and Conditions');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`consumer_offer` ALTER COLUMN `total_budget_allocated` SET TAGS ('dbx_business_glossary_term' = 'Total Budget Allocated');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`consumer_offer` ALTER COLUMN `total_redemption_limit` SET TAGS ('dbx_business_glossary_term' = 'Total Redemption Limit');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`consumer_offer` ALTER COLUMN `transferable_flag` SET TAGS ('dbx_business_glossary_term' = 'Transferable Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`consumer_offer` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`consumer_offer` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`consumer_offer` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`consumer_offer` ALTER COLUMN `valid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Valid To Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`flight_allocation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`flight_allocation` SET TAGS ('dbx_subdomain' = 'trade_planning');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`flight_allocation` SET TAGS ('dbx_association_edges' = 'promotion.promotion_event,marketing.campaign_flight');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`flight_allocation` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`flight_allocation` ALTER COLUMN `flight_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Flight Allocation - Promotion Flight Allocation Id');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`flight_allocation` ALTER COLUMN `campaign_flight_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Flight Allocation - Campaign Flight Id');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`flight_allocation` ALTER COLUMN `promotion_event_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Flight Allocation - Promotion Event Id');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`flight_allocation` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Account Id');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`flight_allocation` ALTER COLUMN `trade_promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Promotion Id');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`flight_allocation` ALTER COLUMN `actual_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Spend Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`flight_allocation` ALTER COLUMN `actual_volume_units` SET TAGS ('dbx_business_glossary_term' = 'Actual Volume');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`flight_allocation` ALTER COLUMN `allocated_amount` SET TAGS ('dbx_business_glossary_term' = 'Allocated Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`flight_allocation` ALTER COLUMN `allocated_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Allocated Budget Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`flight_allocation` ALTER COLUMN `allocated_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Allocated Spend');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`flight_allocation` ALTER COLUMN `allocated_volume_units` SET TAGS ('dbx_business_glossary_term' = 'Allocated Volume Units');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`flight_allocation` ALTER COLUMN `allocation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`flight_allocation` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Allocation Method');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`flight_allocation` ALTER COLUMN `allocation_name` SET TAGS ('dbx_business_glossary_term' = 'Allocation Name');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`flight_allocation` ALTER COLUMN `allocation_pct` SET TAGS ('dbx_business_glossary_term' = 'Allocation Pct');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`flight_allocation` ALTER COLUMN `allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Allocation Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`flight_allocation` ALTER COLUMN `allocation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`flight_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`flight_allocation` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`flight_allocation` ALTER COLUMN `flight_allocation_code` SET TAGS ('dbx_business_glossary_term' = 'Flight Allocation Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`flight_allocation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`flight_allocation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`flight_allocation` ALTER COLUMN `flight_allocation_description` SET TAGS ('dbx_business_glossary_term' = 'Flight Allocation Description');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`flight_allocation` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`flight_allocation` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`flight_allocation` ALTER COLUMN `flight_allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Flight Allocation Status');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`flight_allocation` ALTER COLUMN `flight_end_date` SET TAGS ('dbx_business_glossary_term' = 'Flight End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`flight_allocation` ALTER COLUMN `flight_name` SET TAGS ('dbx_business_glossary_term' = 'Flight Name');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`flight_allocation` ALTER COLUMN `flight_sequence` SET TAGS ('dbx_business_glossary_term' = 'Flight Sequence');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`flight_allocation` ALTER COLUMN `flight_start_date` SET TAGS ('dbx_business_glossary_term' = 'Flight Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`flight_allocation` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`flight_allocation` ALTER COLUMN `flight_allocation_name` SET TAGS ('dbx_business_glossary_term' = 'Flight Allocation Name');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`flight_allocation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`flight_allocation` ALTER COLUMN `planned_volume_units` SET TAGS ('dbx_business_glossary_term' = 'Planned Volume');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`flight_allocation` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`flight_allocation` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`flight_allocation` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`flight_allocation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
