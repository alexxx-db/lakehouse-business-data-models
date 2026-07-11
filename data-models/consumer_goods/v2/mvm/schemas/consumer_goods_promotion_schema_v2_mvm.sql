-- Schema for Domain: promotion | Business: Consumer_Goods | Version: v2_mvm
-- Generated on: 2026-07-10 14:48:28

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_consumer_goods_v1`.`promotion` COMMENT 'Owns trade promotion planning, execution, and optimization (TPM/TPO). Manages promotional calendars, trade spend allocation, retailer funding agreements, promotional pricing (Hi-Lo, EDLP), accruals, deductions, post-event analysis, promotional lift measurement, ROI/GMROI analysis, and retailer rebate settlements. Integrates with Salesforce TPM.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` (
    `trade_promotion_id` BIGINT COMMENT 'Unique identifier for the trade promotion program. Primary key for the trade promotion entity.',
    `brand_id` BIGINT COMMENT 'Foreign key linking to product.product_brand. Business justification: Trade promotions in consumer goods are planned and budgeted at the brand level (e.g., annual Dove brand trade spend). Brand-level TPM planning, brand P&L reporting, and retailer joint business plannin',
    `gl_account_id` BIGINT COMMENT 'Identifier of the brand participating in this trade promotion. Links to the brand master entity.',
    `product_category_id` BIGINT COMMENT 'Foreign key linking to product.product_category. Business justification: Trade promotions are scoped to the product category hierarchy (Hair Care, Skin Care) for TPM planning and category P&L reporting. Existing category_id links to the flat product.category; product_categ',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: REQUIRED: Supplier‑funded trade promotions need a link for budgeting and compliance; experts expect a sponsor supplier on each promotion.',
    `trade_account_id` BIGINT COMMENT 'Identifier of the retail trade account (customer) participating in this promotion. Links to the trade account master entity.',
    `trade_calendar_id` BIGINT COMMENT 'Foreign key linking to promotion.trade_calendar. Business justification: A trade promotion is planned and executed within a specific trade calendar cycle (annual or periodic). This FK normalizes the relationship between the promotion program and its governing calendar, ena',
    `accrual_amount` DECIMAL(18,2) COMMENT 'Total accrued trade spend liability for this promotion, representing funds reserved or committed but not yet paid to the retailer.',
    `approval_date` DATE COMMENT 'Date when the trade promotion was formally approved by authorized business stakeholders and authorized for execution.',
    `authorized_budget_amount` DECIMAL(18,2) COMMENT 'Total authorized trade spend budget allocated for this promotion, including all funding mechanisms (off-invoice, scan-back, display allowances, etc.). Expressed in the companys reporting currency.',
    `baseline_volume_units` DECIMAL(18,2) COMMENT 'Expected sales volume in units without the promotion, used as the baseline for calculating incremental lift and ROI.',
    `channel_type` STRING COMMENT 'Retail channel classification where this promotion is executed. Grocery (supermarkets), mass merchandiser (Walmart/Target), drug (pharmacy chains), convenience (c-stores), club (warehouse clubs), ecommerce (online retail).. Valid values are `grocery|mass_merchandiser|drug|convenience|club|ecommerce`',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code where this promotion is executed.. Valid values are `^[A-Z]{3}$`',
    `coupon_flag` BOOLEAN COMMENT 'Indicates whether this promotion includes manufacturer or retailer coupons (print, digital, or mobile). True if coupons are part of the promotion, false otherwise.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this trade promotion record was first created in the system. Represents the business event time of promotion planning initiation.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this promotion record.. Valid values are `^[A-Z]{3}$`',
    `deduction_amount` DECIMAL(18,2) COMMENT 'Total deductions taken by the retailer against invoices for this promotion. Used for reconciliation and settlement tracking.',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Percentage discount offered to the retailer or consumer as part of this promotion. Expressed as a percentage (e.g., 15.00 for 15% off).',
    `display_type` STRING COMMENT 'Type of in-store merchandising display associated with this promotion. End-cap (end of aisle), free-standing (floor display), shelf-talker (shelf signage), pallet (bulk display), cooler (refrigerated display), none (no special display).. Valid values are `end_cap|free_standing|shelf_talker|pallet|cooler|none`',
    `end_date` DATE COMMENT 'The date when the trade promotion concludes and promotional pricing/terms expire at retail.',
    `expected_roi_percentage` DECIMAL(18,2) COMMENT 'Expected return on investment for this promotion, calculated as (incremental profit / trade spend) * 100. Used for pre-event planning and approval.',
    `feature_ad_flag` BOOLEAN COMMENT 'Indicates whether this promotion includes feature advertising in retailer circulars, flyers, or digital media. True if featured, false otherwise.',
    `funding_type` STRING COMMENT 'Mechanism by which trade funds are provided to the retailer. Off-invoice (deducted at purchase), scan-back (reimbursed based on POS sales), bill-back (invoiced after event), lump-sum (fixed payment), accrual (reserved funds).. Valid values are `off_invoice|scan_back|bill_back|lump_sum|accrual`',
    `geographic_scope` STRING COMMENT 'Geographic coverage of the trade promotion. National (entire country), regional (multi-state or territory), local (city or metro area), store-specific (individual retail locations).. Valid values are `national|regional|local|store_specific`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this trade promotion record was last updated. Used for change tracking and audit trail purposes.',
    `maximum_purchase_quantity` STRING COMMENT 'Maximum number of units a consumer can purchase at the promotional price. Null if no maximum limit applies.',
    `minimum_purchase_quantity` STRING COMMENT 'Minimum number of units a consumer must purchase to qualify for the promotional offer. Null if no minimum applies.',
    `notes` STRING COMMENT 'Free-text field for additional business context, special terms, execution notes, or post-event observations related to this trade promotion.',
    `pricing_strategy` STRING COMMENT 'Retailer pricing strategy context for this promotion. Hi-Lo (high-low promotional pricing with deep discounts), EDLP (everyday low price with minimal promotions), hybrid (combination approach).. Valid values are `hi_lo|edlp|hybrid`',
    `promotion_name` STRING COMMENT 'Descriptive name of the trade promotion program for business user identification and reporting purposes.',
    `promotion_number` STRING COMMENT 'Business-facing unique identifier for the trade promotion program, typically generated by the TPM system. Format: TPM-YYYYNNNN where YYYY is year and NNNN is sequence.. Valid values are `^TPM-[0-9]{8}$`',
    `promotion_objective` STRING COMMENT 'Primary business objective driving the trade promotion strategy. Volume growth (increase unit sales), market share gain (capture competitor share), new product launch (trial generation), competitive defense (respond to competitor activity), inventory clearance (reduce excess stock), seasonal event (holiday/event-driven).. Valid values are `volume_growth|market_share_gain|new_product_launch|competitive_defense|inventory_clearance|seasonal_event`',
    `promotion_status` STRING COMMENT 'Current lifecycle status of the trade promotion. Planned (in design), approved (authorized for execution), active (currently running), closed (completed with results finalized), cancelled (terminated before completion), on-hold (temporarily suspended).. Valid values are `planned|approved|active|closed|cancelled|on_hold`',
    `promotion_type` STRING COMMENT 'Classification of the trade promotion mechanism. Temporary price reduction (Hi-Lo), feature ad (retailer circular), display (end-cap/shelf), BOGO (buy-one-get-one), multi-buy (quantity discount), scan-back (post-sale rebate). [ENUM-REF-CANDIDATE: temporary_price_reduction|feature_ad|display|bogo|multi_buy|scan_back|off_invoice|coupon|loyalty_reward|edlp|slotting_allowance|markdown_allowance — promote to reference product]. Valid values are `temporary_price_reduction|feature_ad|display|bogo|multi_buy|scan_back`',
    `settlement_status` STRING COMMENT 'Status of financial settlement and reconciliation for trade promotion deductions and accruals. Pending (awaiting settlement), in-progress (reconciliation underway), settled (fully reconciled and paid), disputed (discrepancies under review).. Valid values are `pending|in_progress|settled|disputed`',
    `start_date` DATE COMMENT 'The date when the trade promotion becomes active and promotional pricing/terms take effect at retail.',
    `target_volume_units` DECIMAL(18,2) COMMENT 'Target sales volume in units expected to be achieved during the promotion period, including baseline and incremental lift.',
    `tpm_system_reference_code` STRING COMMENT 'External reference identifier from the source Trade Promotion Management system (e.g., Salesforce Consumer Goods Cloud TPM module). Used for system integration and traceability.',
    CONSTRAINT pk_trade_promotion PRIMARY KEY(`trade_promotion_id`)
) COMMENT 'Core master entity for trade promotion programs. Captures the full definition of a trade promotion including name, type (Hi-Lo, EDLP, display, coupon, scan-back, off-invoice), promotional period, owning brand/category, status (planned, active, closed, cancelled), total authorized trade spend budget, promotion objectives, promotion type classification (temporary price reduction, feature ad, display, BOGO, multi-buy, scan-back, coupon, loyalty reward), applicable channels, and integration reference to Salesforce TPM. Serves as the SSOT for all trade promotion definitions and the parent entity for all promotion events, spend allocations, and post-event analyses.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`promotion`.`event` (
    `event_id` BIGINT COMMENT 'Unique identifier for the promotion event. Primary key for this entity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Required for promotion spend accounting reports linking each event to the responsible cost center for budgeting and variance analysis.',
    `funding_agreement_id` BIGINT COMMENT 'Foreign key linking to promotion.funding_agreement. Business justification: A promotion event is funded through a specific retailer funding agreement. While event_sku already has retailer_funding_agreement_id, the promotion_event itself lacks a direct FK to the governing fund',
    `product_category_id` BIGINT COMMENT 'Foreign key linking to product.product_category. Business justification: Promotion events are scheduled against a specific product launch R&D project to ensure timing and KPI consistency.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Enables profit‑center level reporting of promotion performance and ROI, a standard finance requirement.',
    `retail_store_id` BIGINT COMMENT 'Reference to the specific retail store, distribution center, or ship-to location where the promotional event is executed.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Required for integrated ROI reporting: each trade promotion event is executed as part of a marketing campaign, enabling campaign‑level performance analysis.',
    `network_node_id` BIGINT COMMENT 'Foreign key linking to supply.network_node. Business justification: Promotion events execute at specific distribution nodes for promotional inventory staging, fulfillment, and logistics coordination. Critical for aligning promotional execution with supply network capa',
    `trade_account_id` BIGINT COMMENT 'Reference to the retailer or distributor account participating in this promotional event.',
    `trade_calendar_id` BIGINT COMMENT 'Foreign key linking to promotion.trade_calendar. Business justification: A promotion event is scheduled within a trade calendar period. This direct FK supports calendar-level event scheduling queries and promotional calendar reporting without requiring a join through trade',
    `trade_promotion_id` BIGINT COMMENT 'Reference to the parent trade promotion program under which this event is executed. A single program may have multiple events across different retailers or time windows.',
    `accrual_amount` DECIMAL(18,2) COMMENT 'The financial accrual amount reserved for this promotional event, representing the estimated liability for trade promotion obligations.',
    `actual_trade_spend_amount` DECIMAL(18,2) COMMENT 'The realized trade spend for this promotional event, representing the total investment actually incurred by the manufacturer.',
    `actual_volume_units` DECIMAL(18,2) COMMENT 'The realized sales volume in units achieved during the promotional event, used for post-event analysis and lift measurement.',
    `approval_date` DATE COMMENT 'The date when this promotional event was approved for execution by the authorized business stakeholder.',
    `baseline_volume_units` DECIMAL(18,2) COMMENT 'The expected sales volume in units without promotional activity, used as the baseline for calculating promotional lift.',
    `cancellation_date` DATE COMMENT 'The date when this promotional event was cancelled, if applicable.',
    `cancellation_reason` STRING COMMENT 'Textual explanation for why this promotional event was cancelled, if applicable.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this promotional event record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this promotional event record.. Valid values are `^[A-Z]{3}$`',
    `deduction_amount` DECIMAL(18,2) COMMENT 'The total deductions claimed by the retailer against invoices for this promotional event, representing retailer-initiated trade spend recovery.',
    `event_description` STRING COMMENT 'Detailed textual description of the promotional event, including objectives, mechanics, and special conditions.',
    `end_date` DATE COMMENT 'The date when the promotional event concludes execution at retail or distribution level.',
    `event_number` STRING COMMENT 'Business-facing unique identifier for the promotion event, used for external communication and reporting.. Valid values are `^[A-Z0-9]{8,20}$`',
    `event_status` STRING COMMENT 'Current lifecycle status of the promotional event. Planned: event scheduled but not yet approved; Approved: event approved for execution; In Execution: event currently active; Completed: event finished; Cancelled: event terminated before completion.. Valid values are `planned|approved|in_execution|completed|cancelled`',
    `event_type` STRING COMMENT 'Classification of the promotional event mechanism. Feature Ad: product featured in retailer circular; Display: in-store display placement; Temporary Price Reduction (TPR): short-term price discount; BOGO: Buy One Get One offer; Scan-Back: post-sale rebate based on scanned sales; Coupon: manufacturer or retailer coupon redemption.. Valid values are `feature_ad|display|temporary_price_reduction|bogo|scan_back|coupon`',
    `funding_source` STRING COMMENT 'The primary source of funding for this promotional event. Manufacturer: fully funded by manufacturer; Retailer: fully funded by retailer; Cooperative: jointly funded by both parties.. Valid values are `manufacturer|retailer|cooperative`',
    `geography_code` STRING COMMENT 'Three-letter ISO country code representing the geographic market where the event is executed.. Valid values are `^[A-Z]{3}$`',
    `gmroi_ratio` DECIMAL(18,2) COMMENT 'The gross margin return on investment for this promotional event, calculated as Gross Margin / Average Inventory Investment, measuring profitability efficiency.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this promotional event record was last modified in the system.',
    `event_name` STRING COMMENT 'Descriptive name of the promotional event for business user identification and reporting.',
    `planned_trade_spend_amount` DECIMAL(18,2) COMMENT 'The budgeted trade spend allocation for this promotional event, representing the total investment planned by the manufacturer.',
    `planned_volume_units` DECIMAL(18,2) COMMENT 'The forecasted sales volume in units expected during the promotional event, used for planning and ROI estimation.',
    `post_event_analysis_completed_flag` BOOLEAN COMMENT 'Boolean indicator of whether post-event analysis has been completed for this promotional event, including lift measurement and ROI calculation.',
    `post_event_analysis_date` DATE COMMENT 'The date when post-event analysis was completed for this promotional event.',
    `pricing_strategy` STRING COMMENT 'The pricing approach applied during this event. Hi-Lo: high-low promotional pricing with deep temporary discounts; EDLP: Everyday Low Price with minimal promotional variation; Hybrid: combination of both strategies.. Valid values are `hi_lo|edlp|hybrid`',
    `promotional_lift_percentage` DECIMAL(18,2) COMMENT 'The percentage increase in sales volume attributable to the promotional event, calculated as (Actual Volume - Baseline Volume) / Baseline Volume * 100.',
    `rebate_amount` DECIMAL(18,2) COMMENT 'The total rebate amount paid to the retailer for this promotional event, typically calculated post-event based on performance metrics.',
    `roi_percentage` DECIMAL(18,2) COMMENT 'The return on investment for this promotional event, calculated as (Incremental Profit - Trade Spend) / Trade Spend * 100, measuring promotional effectiveness.',
    `salesforce_tpm_event_code` STRING COMMENT 'The unique identifier from Salesforce Consumer Goods Cloud Trade Promotion Management system for this event record, used for system integration and data lineage.. Valid values are `^[a-zA-Z0-9]{15,18}$`',
    `settlement_date` DATE COMMENT 'The date when financial settlement for this promotional event was completed and all trade spend obligations were resolved.',
    `settlement_status` STRING COMMENT 'The current status of financial settlement for this promotional event. Pending: settlement not yet initiated; In Progress: settlement calculations underway; Settled: all financial obligations resolved; Disputed: settlement under dispute resolution.. Valid values are `pending|in_progress|settled|disputed`',
    `start_date` DATE COMMENT 'The date when the promotional event begins execution at retail or distribution level.',
    CONSTRAINT pk_event PRIMARY KEY(`event_id`)
) COMMENT 'Represents a discrete promotional execution event tied to a trade promotion program. A single trade promotion may have multiple events across different retailers, geographies, or time windows. Captures event-level details: event type (feature ad, display, temporary price reduction, BOGO, scan-back), event start/end dates, retailer account, ship-to location, participating SKUs, planned vs. actual event status, and event-level trade spend allocation. Integrates with Salesforce TPM event records.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` (
    `event_sku_id` BIGINT COMMENT 'Unique identifier for the promotion event SKU association record. Primary key for this entity.',
    `demand_plan_id` BIGINT COMMENT 'Foreign key linking to supply.demand_plan. Business justification: Event SKUs must reconcile with demand plans to validate promotional forecast accuracy, measure promotional lift against baseline, and close the loop between promotional planning and execution for cont',
    `event_id` BIGINT COMMENT 'Reference to the parent promotion event to which this SKU is associated.',
    `manufacturing_bom_id` BIGINT COMMENT 'Foreign key linking to manufacturing.manufacturing_bom. Business justification: Promotional SKUs often use variant BOMs for special packaging (bonus packs, bundled sets, promotional inserts). Linking event_sku to manufacturing_bom enables accurate cost tracking, material planning',
    `manufacturing_facility_id` BIGINT COMMENT '',
    `promoted_price_id` BIGINT COMMENT 'Foreign key linking to promotion.promoted_price. Business justification: event_sku has a denormalized promoted_price DECIMAL column that duplicates data from the promoted_price master entity. Adding a FK to promoted_price.promoted_price_id normalizes this relationship, all',
    `funding_agreement_id` BIGINT COMMENT 'Reference to the retailer funding agreement or trade contract governing the promotional terms for this SKU.',
    `routing_id` BIGINT COMMENT 'Foreign key linking to manufacturing.routing. Business justification: Promotional SKUs frequently require specific routing versions for special packaging, bonus pack configurations, or promotional labeling operations. Manufacturing must execute the correct routing to pr',
    `sku_id` BIGINT COMMENT 'Reference to the product SKU participating in this promotion event.',
    `trade_account_id` BIGINT COMMENT 'Reference to the retailer or trade account for which this promotional SKU pricing applies.',
    `accrual_amount` DECIMAL(18,2) COMMENT 'Accrued trade spend liability for this promotional SKU. Represents the estimated financial obligation based on planned volume and discount.',
    `actual_promotional_volume_cases` DECIMAL(18,2) COMMENT 'Actual volume of cases sold during the promotion period for this SKU. Captured post-event from POS or shipment data.',
    `actual_promotional_volume_units` DECIMAL(18,2) COMMENT 'Actual volume of consumer units sold during the promotion period for this SKU. Used for promotional lift and ROI analysis.',
    `baseline_volume_estimate_units` DECIMAL(18,2) COMMENT 'Estimated volume of units that would have been sold without the promotion. Used to calculate incremental lift. Typically derived from historical sales trends.',
    `compliance_check_status` STRING COMMENT 'Status of promotional pricing compliance verification for this SKU. Ensures promotional pricing was executed as agreed with the retailer.. Valid values are `Not Checked|Compliant|Non-Compliant|Under Review`',
    `compliance_verified_date` DATE COMMENT 'Date when promotional pricing compliance was verified for this SKU through retail execution audits or POS data validation.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this promotion event SKU record was first created in the system.',
    `deduction_amount` DECIMAL(18,2) COMMENT 'Actual deduction amount claimed by the retailer for this promotional SKU. Used for trade spend reconciliation and settlement.',
    `display_location_type` STRING COMMENT 'Type of in-store display location where this promotional SKU is merchandised. Impacts visibility and promotional lift. [ENUM-REF-CANDIDATE: Shelf|End Cap|Free Standing Display|Pallet|Cooler|Checkout|Secondary Placement — 7 candidates stripped; promote to reference product]',
    `feature_type` STRING COMMENT 'Type of promotional feature or advertising support provided for this SKU during the promotion event. [ENUM-REF-CANDIDATE: Circular Ad|Digital Ad|In-Store Signage|Shelf Talker|Coupon|Loyalty Offer|None — 7 candidates stripped; promote to reference product]',
    `gtin` STRING COMMENT 'Global Trade Item Number uniquely identifying the product SKU in the promotion. Supports EAN-8, EAN-13, UPC-A, UPC-E, and GTIN-14 formats.. Valid values are `^[0-9]{8,14}$`',
    `incremental_lift_percent` DECIMAL(18,2) COMMENT 'Percentage lift in volume due to the promotion. Calculated as (incremental_lift_volume_units / baseline_volume_estimate_units) * 100.',
    `incremental_lift_volume_units` DECIMAL(18,2) COMMENT 'Incremental volume of units sold above baseline due to the promotion. Calculated as actual_promotional_volume_units - baseline_volume_estimate_units.',
    `is_featured_sku` BOOLEAN COMMENT 'Indicates whether this SKU is a featured hero product in the promotion event. Featured SKUs typically receive premium merchandising and advertising support.',
    `modified_by` STRING COMMENT 'Name or identifier of the user who last modified this promotion event SKU record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this promotion event SKU record was last modified.',
    `notes` STRING COMMENT 'Free-form text field for additional notes, comments, or special instructions related to this promotional SKU.',
    `planned_promotional_volume_cases` DECIMAL(18,2) COMMENT 'Forecasted volume of cases expected to be sold during the promotion period for this SKU. Used for trade spend budgeting and supply planning.',
    `planned_promotional_volume_units` DECIMAL(18,2) COMMENT 'Forecasted volume of consumer units expected to be sold during the promotion period for this SKU.',
    `price_reduction_depth_percent` DECIMAL(18,2) COMMENT 'Percentage discount from regular shelf price to promoted price. Calculated as ((regular_shelf_price - promoted_price) / regular_shelf_price) * 100.',
    `pricing_approval_status` STRING COMMENT 'Current approval status of the promotional pricing for this SKU. Tracks the workflow state from draft through execution to completion. [ENUM-REF-CANDIDATE: Draft|Pending Approval|Approved|Rejected|Active|Completed|Cancelled — 7 candidates stripped; promote to reference product]',
    `pricing_approved_timestamp` TIMESTAMP COMMENT 'Date and time when the promotional pricing for this SKU was approved.',
    `promoted_price_type` STRING COMMENT 'Type of promotional pricing mechanism applied to this SKU. Hi-Lo: temporary price reduction; EDLP: everyday low price; Multi-Buy: quantity discount; BOGO: buy-one-get-one; Scan-Back: retailer scanned rebate; Off-Invoice: deduction at invoice; Bill-Back: post-event settlement. [ENUM-REF-CANDIDATE: Hi-Lo|EDLP|Multi-Buy|BOGO|Scan-Back|Off-Invoice|Bill-Back — 7 candidates stripped; promote to reference product]',
    `promotion_effective_end_date` DATE COMMENT 'The date when the promotional pricing for this SKU expires and regular pricing resumes.',
    `promotion_effective_start_date` DATE COMMENT 'The date when the promotional pricing for this SKU becomes effective at retail.',
    `promotional_discount_per_unit` DECIMAL(18,2) COMMENT 'Absolute discount amount per unit (regular_shelf_price - promoted_price). Represents the per-unit trade spend investment.',
    `promotional_gmroi` DECIMAL(18,2) COMMENT 'Gross margin return on investment for this promotional SKU. Calculated as incremental_gross_margin / total_trade_spend_amount.',
    `promotional_roi_percent` DECIMAL(18,2) COMMENT 'Return on investment for this promotional SKU. Calculated as (incremental_gross_profit - total_trade_spend_amount) / total_trade_spend_amount * 100.',
    `rebate_amount` DECIMAL(18,2) COMMENT 'Rebate amount paid to the retailer for this promotional SKU. Typically settled post-event based on actual sales performance.',
    `regular_shelf_price` DECIMAL(18,2) COMMENT 'The standard everyday shelf price (RSP/MSRP) for this SKU before promotional discount. Used to calculate price reduction depth.',
    `settlement_date` DATE COMMENT 'Date when the financial settlement for this promotional SKU was completed with the retailer.',
    `settlement_status` STRING COMMENT 'Current status of the financial settlement process for this promotional SKU with the retailer.. Valid values are `Not Started|In Progress|Reconciled|Settled|Disputed`',
    `total_trade_spend_amount` DECIMAL(18,2) COMMENT 'Total trade spend investment for this SKU in this promotion event. Calculated as promotional_discount_per_unit * actual_promotional_volume_units.',
    `upc` STRING COMMENT 'Universal Product Code for the SKU participating in the promotion event. Standard 12-digit UPC-A format.. Valid values are `^[0-9]{12}$`',
    CONSTRAINT pk_event_sku PRIMARY KEY(`event_sku_id`)
) COMMENT 'Association entity linking individual SKUs (GTINs/UPCs) to a specific promotion event with full promotional pricing authority. Captures SKU-level promotional details including promoted price, promoted price type (Hi-Lo temporary price reduction, EDLP, multi-buy, BOGO, scan-back, off-invoice, bill-back), price reduction depth (%), regular shelf price (RSP/MSRP), effective date range, planned promotional volume (cases/units), actual promotional volume, baseline volume estimate, incremental lift volume, promotional discount amount per unit, retailer account, channel, and pricing approval status. Serves as the SSOT for SKU-level promotional pricing within trade events — distinct from standard list pricing owned by the product domain. Enables SKU-level trade spend, lift analysis, and promotional price compliance per event.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` (
    `trade_calendar_id` BIGINT COMMENT 'Primary key for trade_calendar',
    `brand_id` BIGINT COMMENT 'Foreign key linking to product.product_brand. Business justification: Trade promotion calendars in consumer goods are organized by brand (e.g., annual Pantene promotional calendar). Brand-level calendar planning, brand investment tracking, and retailer brand activation ',
    `parent_calendar_trade_calendar_id` BIGINT COMMENT 'Identifier of the parent promotional calendar if this is a sub-calendar or regional variant. Links to another promotional calendar entity.',
    `product_category_id` BIGINT COMMENT 'Foreign key linking to product.product_category. Business justification: Trade calendars in consumer goods are planned against the product category hierarchy for category-level investment planning and retailer category captaincy reporting. Existing category_id links to fla',
    `trade_account_id` BIGINT COMMENT 'Identifier of the retailer or trade account this promotional calendar is scoped to. Links to the trade account entity.',
    `actual_event_count` STRING COMMENT 'The actual number of promotional events executed or in-flight within this calendar period.',
    `approval_date` DATE COMMENT 'The date when this promotional calendar was formally approved by management or finance.',
    `calendar_code` STRING COMMENT 'Short alphanumeric code for the promotional calendar used in reporting and system integration (e.g., FY24Q1-RET, CAL-2024-BRX).',
    `calendar_name` STRING COMMENT 'Business name of the promotional calendar (e.g., FY2024 Q1 Retail Promo Calendar, Annual Brand X Trade Plan).',
    `calendar_status` STRING COMMENT 'Current lifecycle status of the promotional calendar (draft, submitted, approved, locked, active, closed).. Valid values are `draft|submitted|approved|locked|active|closed`',
    `closed_date` DATE COMMENT 'The date when this promotional calendar was closed after all events completed and post-event analysis was finalized.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code where this promotional calendar is executed (e.g., USA, GBR, DEU).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this promotional calendar record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the planned trade spend (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `trade_calendar_description` STRING COMMENT 'Detailed business description or purpose of this promotional calendar, including strategic objectives and key initiatives.',
    `effective_end_date` DATE COMMENT 'The date when this promotional calendar ends and no further promotional events are planned under this calendar.',
    `effective_start_date` DATE COMMENT 'The date when this promotional calendar becomes effective and promotional events can begin execution.',
    `fiscal_year` STRING COMMENT 'The fiscal year this promotional calendar covers (e.g., 2024, 2025).',
    `is_baseline_calendar` BOOLEAN COMMENT 'Flag indicating whether this is the baseline or master promotional calendar for the fiscal year (true) or a variant/supplemental calendar (false).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this promotional calendar record was last updated or modified.',
    `locked_date` DATE COMMENT 'The date when this promotional calendar was locked to prevent further changes, typically after approval and before execution.',
    `notes` STRING COMMENT 'Additional notes, comments, or special instructions related to this promotional calendar for internal reference.',
    `planned_event_count` STRING COMMENT 'The total number of promotional events planned within this calendar period.',
    `planning_cycle` STRING COMMENT 'The planning frequency or cycle for this promotional calendar (annual, semi-annual, quarterly, monthly).. Valid values are `annual|semi-annual|quarterly|monthly`',
    `pricing_strategy` STRING COMMENT 'The primary pricing strategy employed in this promotional calendar: Hi-Lo (High-Low Pricing Strategy), EDLP (Everyday Low Price), hybrid, promotional, or premium.. Valid values are `hi-lo|edlp|hybrid|promotional|premium`',
    `region_code` STRING COMMENT 'Geographic region or market code this promotional calendar applies to (e.g., NA-EAST, EU-WEST, APAC).',
    `total_planned_trade_spend` DECIMAL(18,2) COMMENT 'The total budgeted trade spend envelope allocated for all promotional events within this calendar, in the base currency.',
    `tpm_system_code` STRING COMMENT 'External system identifier from the Trade Promotion Management (TPM) or Trade Promotion Optimization (TPO) system (e.g., Salesforce TPM, TradeEdge).',
    `version_number` STRING COMMENT 'Version number of this promotional calendar, incremented with each major revision or replan cycle.',
    CONSTRAINT pk_trade_calendar PRIMARY KEY(`trade_calendar_id`)
) COMMENT 'Master entity representing the annual or periodic trade promotional calendar for a brand, category, or retailer account. Captures calendar name, fiscal year, planning cycle, owning brand/category manager, retailer account scope, calendar status (draft, approved, locked), total planned trade spend envelope, and number of planned promotion events. Serves as the planning container for all trade promotion events within a given period and account relationship.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` (
    `trade_spend_allocation_id` BIGINT COMMENT 'Unique identifier for the trade spend allocation record. Primary key for this transactional entity capturing budget allocation to promotion events.',
    `demand_plan_id` BIGINT COMMENT 'Foreign key linking to supply.demand_plan. Business justification: Trade spend allocations must link to demand plans to validate promotional volume assumptions, calculate promotional ROI against forecasted incremental volume, and reconcile trade spending efficiency w',
    `event_id` BIGINT COMMENT 'Reference to the specific promotion event or campaign to which this trade spend is allocated. Links to the promotion master record in TPM system.',
    `funding_agreement_id` BIGINT COMMENT 'Foreign key linking to promotion.funding_agreement. Business justification: Trade spend allocations are authorized and governed by retailer funding agreements. The spend_type and spend_category on trade_spend_allocation correspond to funding terms defined in the agreement. Th',
    `gl_account_id` BIGINT COMMENT 'Reference to the brand for which trade spend is allocated. Enables brand-level spend tracking and ROI analysis.',
    `product_category_id` BIGINT COMMENT 'Foreign key linking to product.product_category. Business justification: Trade spend allocations are reported and analyzed at the product category level for category P&L, trade ROI reporting, and TPM financial reconciliation. trade_spend_allocation has sku_id but no produc',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Needed to allocate trade spend per marketing campaign, supporting budgeting, spend efficiency tracking, and campaign‑level spend reconciliation.',
    `trade_account_id` BIGINT COMMENT 'Reference to the retailer or distributor account receiving the trade spend funding. Identifies the counterparty in the promotional agreement.',
    `trade_calendar_id` BIGINT COMMENT 'Foreign key linking to promotion.trade_calendar. Business justification: Trade spend allocations are planned within specific trade calendar periods. The fiscal_year and fiscal_period on trade_spend_allocation align with the trade_calendars effective_start_date/effective_e',
    `trade_promotion_id` BIGINT COMMENT 'Foreign key linking to promotion.trade_promotion. Business justification: Trade spend allocations are authorized at the trade promotion program level. While the existing promotion_event_id FK provides event-level linkage, a direct FK to trade_promotion enables program-level',
    `accrual_amount` DECIMAL(18,2) COMMENT 'The amount accrued for this trade spend allocation in the financial period. Used for matching expenses to the period in which the promotional activity occurs, per accrual accounting principles.',
    `actual_amount` DECIMAL(18,2) COMMENT 'The actual amount of trade spend executed or paid out. Populated post-event for variance analysis and reconciliation with accounts payable.',
    `actual_volume` DECIMAL(18,2) COMMENT 'The actual sales volume achieved during the promotion period. Populated post-event from POS or shipment data for lift analysis and ROI calculation.',
    `allocated_amount` DECIMAL(18,2) COMMENT 'The monetary amount of trade spend allocated to this promotion event, account, brand, or SKU group. Represents the planned or budgeted spend.',
    `allocation_date` DATE COMMENT 'The business date when the trade spend allocation was created or committed. Principal business event timestamp for this transaction.',
    `allocation_number` STRING COMMENT 'Business-readable unique identifier for the trade spend allocation. Used for external communication, audit trails, and reconciliation with finance systems.. Valid values are `^TSA-[0-9]{8}-[A-Z0-9]{6}$`',
    `allocation_status` STRING COMMENT 'Current lifecycle status of the trade spend allocation. Tracks progression from planning through approval, execution, and final settlement with retailer. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|committed|executed|settled|cancelled|rejected — 8 candidates stripped; promote to reference product]',
    `approval_date` DATE COMMENT 'The date when this trade spend allocation was formally approved by the authorized approver. Marks transition from draft to committed status.',
    `baseline_volume` DECIMAL(18,2) COMMENT 'The expected sales volume without promotional activity, used as the baseline for measuring promotional lift. Expressed in units or cases.',
    `committed_amount` DECIMAL(18,2) COMMENT 'The amount of trade spend formally committed after approval. May differ from allocated amount due to negotiation or budget adjustments.',
    `cost_center_code` STRING COMMENT 'The cost center responsible for this trade spend allocation. Enables organizational unit-level spend tracking and accountability.. Valid values are `^CC[0-9]{6}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this trade spend allocation record was first created in the system. Audit field for data lineage and compliance.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this allocation record. Supports multi-currency trade spend management for global operations.. Valid values are `^[A-Z]{3}$`',
    `deduction_amount` DECIMAL(18,2) COMMENT 'The amount deducted by the retailer from invoice payments as part of this trade spend allocation. Tracks retailer-initiated deductions for reconciliation and dispute resolution.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month or quarter) within the fiscal year to which this allocation is assigned. Used for period-level spend tracking and variance analysis.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this trade spend allocation is assigned for budgeting and financial reporting purposes.',
    `gmroi_percentage` DECIMAL(18,2) COMMENT 'The gross margin return on investment for this trade spend allocation. Measures gross margin dollars generated per dollar of trade spend invested.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether this trade spend allocation is currently active. False indicates the allocation has been cancelled or superseded.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this trade spend allocation record was last modified. Audit field for change tracking and data governance.',
    `notes` STRING COMMENT 'Free-text notes or comments regarding this trade spend allocation. Captures special conditions, negotiation details, or post-event observations.',
    `pricing_strategy` STRING COMMENT 'The pricing strategy employed for this trade spend allocation. Distinguishes between Hi-Lo promotional pricing, Everyday Low Price (EDLP), and other strategic approaches.. Valid values are `hi_lo|edlp|hybrid|premium|penetration|competitive`',
    `profit_center_code` STRING COMMENT 'The profit center to which this trade spend is attributed for profitability analysis. Supports P&L reporting by business unit or product line.. Valid values are `^PC[0-9]{6}$`',
    `promotion_end_date` DATE COMMENT 'The end date of the promotion event to which this spend is allocated. Defines the promotional activity window for ROI measurement and post-event analysis.',
    `promotion_start_date` DATE COMMENT 'The start date of the promotion event to which this spend is allocated. Used for temporal analysis and matching spend to promotional activity periods.',
    `roi_percentage` DECIMAL(18,2) COMMENT 'The calculated return on investment for this trade spend allocation, expressed as a percentage. Measures incremental profit generated per dollar of trade spend.',
    `settlement_amount` DECIMAL(18,2) COMMENT 'The final settled amount paid to the retailer after reconciliation of accruals, deductions, and actual performance. Represents the true cost of the promotion.',
    `settlement_date` DATE COMMENT 'The date when final settlement with the retailer was completed. Marks closure of the allocation lifecycle and reconciliation with accounts payable.',
    `spend_category` STRING COMMENT 'High-level classification of trade spend for strategic analysis and reporting. Groups spend types into broader business categories for executive dashboards.. Valid values are `price_discount|merchandising|marketing|listing|performance_incentive|other`',
    `spend_type` STRING COMMENT 'Classification of the trade spend mechanism. [ENUM-REF-CANDIDATE: off_invoice_discount|scan_back|bill_back|lump_sum|coop_advertising|slotting_fee|display_allowance|free_goods|volume_rebate|growth_incentive — promote to reference product]. Valid values are `off_invoice_discount|scan_back|bill_back|lump_sum|coop_advertising|slotting_fee`',
    `target_volume` DECIMAL(18,2) COMMENT 'The target sales volume expected with this trade spend allocation. Used for performance measurement and ROI calculation.',
    `variance_amount` DECIMAL(18,2) COMMENT 'The difference between committed and actual spend amounts. Positive variance indicates under-spend; negative indicates over-spend. Used for budget control and post-event analysis.',
    `volume_uom` STRING COMMENT 'The unit of measure for baseline, target, and actual volume fields. Ensures consistent interpretation of volume metrics across different product categories.. Valid values are `units|cases|pallets|kg|liters`',
    CONSTRAINT pk_trade_spend_allocation PRIMARY KEY(`trade_spend_allocation_id`)
) COMMENT 'Transactional record capturing the allocation of trade spend budget to a specific promotion event, retailer account, brand, or SKU group. Tracks allocated amount, spend type (off-invoice discount, scan-back, bill-back, lump sum, co-op advertising, slotting fee, display allowance, free goods), spend category classification, GL account mapping, fiscal period, cost center, approval status, and variance between planned and committed spend. Feeds into COGS and trade spend reporting for S&OP and finance reconciliation.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` (
    `funding_agreement_id` BIGINT COMMENT 'Unique identifier for the funding agreement record. Primary key.',
    `brand_id` BIGINT COMMENT 'Foreign key linking to product.product_brand. Business justification: Retailer funding agreements in consumer goods are frequently negotiated at the brand level (e.g., brand-level co-op advertising, brand block commitments). Brand-level funding agreement reporting and b',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Funding agreements are legal contracts between manufacturer and retailer that must be associated with a specific legal entity (company code) for contract enforceability, financial statement consolidat',
    `previous_agreement_funding_agreement_id` BIGINT COMMENT 'Reference to the prior funding agreement that this agreement renews or replaces, if applicable.',
    `product_category_id` BIGINT COMMENT 'Foreign key linking to product.product_category. Business justification: Funding agreements for promotions are often sourced from the budget of the related R&D project.',
    `trade_account_id` BIGINT COMMENT 'Reference to the retail trade account (customer) that is party to this funding agreement.',
    `accrual_method` STRING COMMENT 'Method used to accrue trade spend liability over the agreement period: straight-line (evenly over time), event-based (per promotional event), scan-based (per unit sold), or milestone-based (upon achievement of targets).. Valid values are `straight_line|event_based|scan_based|milestone_based`',
    `accrued_to_date_amount` DECIMAL(18,2) COMMENT 'Cumulative amount of trade spend accrued under this agreement as of the current date, based on the accrual method.',
    `agreement_name` STRING COMMENT 'Human-readable name or title of the funding agreement, often including retailer name and fiscal year.',
    `agreement_number` STRING COMMENT 'Externally-known unique business identifier for the funding agreement, typically formatted as prefix-numeric sequence.. Valid values are `^[A-Z]{3}-[0-9]{6,10}$`',
    `agreement_status` STRING COMMENT 'Current lifecycle status of the funding agreement: draft (being prepared), pending approval (submitted for review), approved (signed but not yet active), active (in effect), suspended (temporarily paused), terminated (ended early), or expired (reached end date). [ENUM-REF-CANDIDATE: draft|pending_approval|approved|active|suspended|terminated|expired — 7 candidates stripped; promote to reference product]',
    `agreement_type` STRING COMMENT 'Classification of the funding agreement structure: annual lump sum (fixed payment), scan-back (per-unit sold), co-op (shared marketing), slotting (shelf placement fee), performance-based (conditional on metrics), or volume rebate (tiered discount).. Valid values are `annual_lump_sum|scan_back|co_op|slotting|performance_based|volume_rebate`',
    `approval_status` STRING COMMENT 'Current approval workflow status: not submitted (draft), pending review (awaiting decision), approved (authorized), rejected (denied), or revision required (needs changes before resubmission).. Valid values are `not_submitted|pending_review|approved|rejected|revision_required`',
    `approved_by` STRING COMMENT 'Name or identifier of the individual who approved the funding agreement (typically a sales director, finance manager, or VP of trade marketing).',
    `approved_date` DATE COMMENT 'Date when the funding agreement was formally approved by the authorized signatory.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether this agreement automatically renews at the end of the funding period (true) or requires explicit renewal (false).',
    `contract_document_url` STRING COMMENT 'URL or file path to the signed contract document stored in the document management system (e.g., Salesforce Files, SharePoint, Veeva Vault).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the funding agreement record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this agreement (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `deduction_settlement_terms` STRING COMMENT 'Terms and conditions governing how retailer deductions are validated, matched, and settled against this funding agreement (e.g., backup documentation requirements, dispute resolution process, settlement timeline).',
    `funding_period_end_date` DATE COMMENT 'The date when the funding agreement expires and the funding period ends. Nullable for open-ended agreements.',
    `funding_period_start_date` DATE COMMENT 'The date when the funding agreement becomes effective and the funding period begins.',
    `gmroi_target` DECIMAL(18,2) COMMENT 'Target gross margin return on investment for this funding agreement, measuring gross profit generated per dollar of trade spend invested.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the funding agreement record was most recently updated.',
    `manufacturer_signatory_name` STRING COMMENT 'Full name of the manufacturer representative who signed the funding agreement on behalf of the CPG company.',
    `manufacturer_signatory_title` STRING COMMENT 'Job title or role of the manufacturer signatory (e.g., VP of Sales, Director of Trade Marketing, Key Account Manager).',
    `manufacturer_signature_date` DATE COMMENT 'Date when the manufacturer signatory signed the funding agreement.',
    `notes` STRING COMMENT 'Free-form text field for additional notes, comments, or special conditions related to the funding agreement.',
    `paid_to_date_amount` DECIMAL(18,2) COMMENT 'Cumulative amount of funding actually paid out to the retailer under this agreement as of the current date.',
    `payment_frequency` STRING COMMENT 'Frequency at which payments are made under this agreement: one-time (lump sum), monthly, quarterly, semi-annual, annual, or event-based (triggered by specific promotional events).. Valid values are `one_time|monthly|quarterly|semi_annual|annual|event_based`',
    `payment_terms` STRING COMMENT 'Detailed description of payment terms, including timing, method, and conditions for fund disbursement (e.g., quarterly installments, post-event settlement, net 30 days).',
    `performance_conditions` STRING COMMENT 'Detailed description of performance metrics, targets, or conditions that must be met for funding to be released or for rebates to be earned (e.g., minimum sales volume, market share targets, display compliance).',
    `remaining_balance_amount` DECIMAL(18,2) COMMENT 'Remaining uncommitted or unpaid funding balance available under this agreement (total committed minus paid to date).',
    `renewal_flag` BOOLEAN COMMENT 'Indicates whether this funding agreement is a renewal of a previous agreement (true) or a new agreement (false).',
    `retailer_signatory_name` STRING COMMENT 'Full name of the retailer representative who signed the funding agreement on behalf of the retail account.',
    `retailer_signatory_title` STRING COMMENT 'Job title or role of the retailer signatory (e.g., Category Manager, Buyer, VP of Merchandising).',
    `retailer_signature_date` DATE COMMENT 'Date when the retailer signatory signed the funding agreement.',
    `roi_target_percentage` DECIMAL(18,2) COMMENT 'Target return on investment percentage for this funding agreement, used to measure promotional effectiveness and justify trade spend allocation.',
    `termination_date` DATE COMMENT 'Actual date when the agreement was terminated early, if applicable. Null if the agreement was not terminated.',
    `termination_notice_days` STRING COMMENT 'Number of days advance notice required by either party to terminate the agreement prior to the end date.',
    `termination_reason` STRING COMMENT 'Explanation or reason code for early termination of the agreement (e.g., breach of contract, mutual agreement, business restructuring, poor performance).',
    `total_committed_amount` DECIMAL(18,2) COMMENT 'Total funding amount committed by the manufacturer to the retailer under this agreement, in the agreement currency.',
    CONSTRAINT pk_funding_agreement PRIMARY KEY(`funding_agreement_id`)
) COMMENT 'Master entity representing a formal retailer funding agreement (RFA) or joint business plan (JBP) between the CPG manufacturer and a retail account. Captures agreement name, retailer account, agreement type (annual lump sum, scan-back, co-op, slotting, performance-based), total committed funding amount, funding period, payment terms, performance conditions, approval status, and signatory details. Serves as the contractual basis for trade spend commitments and deduction settlements.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`promotion`.`accrual` (
    `accrual_id` BIGINT COMMENT 'Unique identifier for the promotion accrual record. Primary key.',
    `event_id` BIGINT COMMENT 'Reference to the associated trade promotion event for which this accrual is recognized.',
    `funding_agreement_id` BIGINT COMMENT 'Foreign key linking to promotion.funding_agreement. Business justification: Promotion accruals are governed by the terms of a retailer funding agreement (RFA/JBP). The accrual_method, rate, and payment_reference_number on promotion_accrual are defined by the funding agreement',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Accrual posting needs a GL account reference; replaces denormalized gl_account_code for proper ledger integration.',
    `product_category_id` BIGINT COMMENT 'Foreign key linking to product.product_category. Business justification: Accrual records must be allocated to the R&D project that generated the promoted SKU for financial reporting.',
    `sku_id` BIGINT COMMENT 'Reference to the specific product SKU included in the promotional accrual. Nullable for lump-sum accruals not tied to specific SKUs.',
    `trade_account_id` BIGINT COMMENT 'Reference to the retailer or customer account receiving the promotional funding.',
    `trade_promotion_id` BIGINT COMMENT 'Foreign key linking to promotion.trade_promotion. Business justification: Promotion accruals represent financial liabilities at the program level. While the existing promotion_event_id provides event-level linkage, a direct FK to trade_promotion enables program-level accrua',
    `accrual_number` STRING COMMENT 'Business-readable unique identifier for the accrual record, used for tracking and reconciliation.. Valid values are `^ACR-[0-9]{10}$`',
    `accrual_status` STRING COMMENT 'Current lifecycle status of the accrual: open (recognized but not yet settled), pending approval, approved, settled (paid out), reversed (accounting adjustment), or cancelled.. Valid values are `open|pending_approval|approved|settled|reversed|cancelled`',
    `accrual_type` STRING COMMENT 'Classification of the promotional accrual mechanism: scan-back (retailer submits proof of sale), bill-back (post-event invoice deduction), off-invoice (immediate discount), lump-sum (fixed payment), volume rebate, or performance bonus.. Valid values are `scan_back|bill_back|off_invoice|lump_sum|volume_rebate|performance_bonus`',
    `amount` DECIMAL(18,2) COMMENT 'Total monetary value of the promotional liability recognized in the accrual, expressed in the functional currency.',
    `approval_status` STRING COMMENT 'Approval workflow status for the accrual: pending (awaiting review), approved (authorized for settlement), or rejected (denied).. Valid values are `pending|approved|rejected`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the accrual was approved. Nullable for unapproved accruals.',
    `baseline_volume` DECIMAL(18,2) COMMENT 'Expected sales volume without the promotion, used to calculate incremental lift and accrual accuracy. Nullable for non-lift-based accruals.',
    `cost_center_code` STRING COMMENT 'Cost center responsible for the promotional spend, used for internal cost allocation and P&L reporting.. Valid values are `^CC[0-9]{6}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the accrual record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the accrual amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `deduction_claim_number` STRING COMMENT 'Reference number for the retailer deduction claim associated with this accrual, used for deduction management and reconciliation. Nullable if no claim submitted.. Valid values are `^DED-[0-9]{10}$`',
    `dispute_reason` STRING COMMENT 'Explanation of why the accrual is disputed. Nullable if not disputed.',
    `fiscal_period` STRING COMMENT 'Fiscal period (month or quarter) within the fiscal year in which the accrual is recognized.',
    `fiscal_year` STRING COMMENT 'Fiscal year in which the accrual is recognized, used for annual financial reporting and compliance.',
    `gmroi` DECIMAL(18,2) COMMENT 'Gross margin return on investment for the promotional spend, measuring profitability efficiency. Nullable if not yet calculated.',
    `incremental_volume` DECIMAL(18,2) COMMENT 'Additional sales volume generated by the promotion above the baseline, used for ROI and GMROI analysis. Nullable for non-lift-based accruals.',
    `is_disputed` BOOLEAN COMMENT 'Flag indicating whether the accrual is under dispute with the retailer or customer (true if disputed, false otherwise).',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the accrual record was last modified.',
    `notes` STRING COMMENT 'Free-text field for additional comments, explanations, or special instructions related to the accrual.',
    `payment_reference_number` STRING COMMENT 'Reference number for the payment transaction that settled this accrual. Nullable for unsettled accruals.. Valid values are `^PAY-[0-9]{10}$`',
    `period_end_date` DATE COMMENT 'End date of the accounting period during which the promotional liability is recognized.',
    `period_start_date` DATE COMMENT 'Start date of the accounting period during which the promotional liability is recognized.',
    `profit_center_code` STRING COMMENT 'Profit center associated with the promotional accrual, used for segment profitability analysis.. Valid values are `^PC[0-9]{6}$`',
    `quantity_sold` DECIMAL(18,2) COMMENT 'Total quantity of product units sold during the promotional period that triggered the accrual. Nullable for non-volume-based accruals.',
    `rate` DECIMAL(18,2) COMMENT 'Rate or percentage applied to calculate the accrual amount (e.g., discount percentage, rebate rate per unit). Nullable for lump-sum accruals.',
    `recognition_date` DATE COMMENT 'Date on which the accrual was initially recognized in the financial system.',
    `reversal_date` DATE COMMENT 'Date on which the accrual was reversed due to adjustment or cancellation. Nullable for non-reversed accruals.',
    `roi_percentage` DECIMAL(18,2) COMMENT 'Calculated return on investment for the promotional spend, expressed as a percentage. Nullable if not yet calculated.',
    `sap_co_document_number` STRING COMMENT 'SAP CO document number for the controlling posting of the accrual, used for cost allocation and internal reporting.. Valid values are `^[0-9]{10}$`',
    `sap_fi_document_number` STRING COMMENT 'SAP FI document number for the financial posting of the accrual, used for audit trail and reconciliation.. Valid values are `^[0-9]{10}$`',
    `settlement_date` DATE COMMENT 'Date on which the accrual was settled (paid out to the retailer or customer). Nullable for unsettled accruals.',
    `source_system_code` STRING COMMENT 'Unique identifier of the accrual record in the source system, used for data lineage and reconciliation.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the quantity sold (e.g., each, case, pallet, kilogram, liter).. Valid values are `each|case|pallet|kilogram|liter`',
    CONSTRAINT pk_accrual PRIMARY KEY(`accrual_id`)
) COMMENT 'Transactional record capturing trade promotion accruals — the financial liability recognized for promotional spend commitments not yet paid. Tracks accrual type (scan-back, bill-back, off-invoice, lump sum), accrual amount, accrual period, associated promotion event, retailer account, SKU, accrual status (open, reversed, settled), GL account, and SAP FI/CO posting reference. Critical for accurate COGS and P&L reporting under trade promotion accounting standards.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction` (
    `deduction_id` BIGINT COMMENT 'Unique identifier for the promotion deduction record. Primary key for the promotion deduction entity representing the complete lifecycle from initial short-payment through final settlement.',
    `accrual_id` BIGINT COMMENT 'Foreign key linking to promotion.promotion_accrual. Business justification: Retailer deductions are matched against pre-established accruals in the deduction management process. The accrual_impact_flag on promotion_deduction explicitly signals this relationship. Linking deduc',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Links each deduction to the cost center responsible for the expense, required for cost allocation and reporting.',
    `event_id` BIGINT COMMENT 'Identifier of the originating promotion event that triggered this deduction. Links to the promotion event master.',
    `funding_agreement_id` BIGINT COMMENT 'Identifier of the trade promotion funding agreement under which this deduction was claimed. Links to the funding agreement master.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Deduction entries must be posted to a specific GL account; removes redundant gl_account_code column.',
    `invoice_id` BIGINT COMMENT 'Identifier of the invoice against which the deduction was taken. Links to the originating invoice record.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Provides profit‑center level visibility of deduction impact, supporting profit analysis and KPI tracking.',
    `trade_account_id` BIGINT COMMENT 'Identifier of the retailer or trade account that initiated the deduction. Links to the customer trade account master.',
    `accrual_impact_flag` BOOLEAN COMMENT 'Boolean indicator of whether this deduction impacts trade promotion accruals. True indicates the deduction should be reconciled against accrued trade spend, false indicates it is outside accrual scope.',
    `aging_days` STRING COMMENT 'Number of days the deduction has been open since the deduction date. Used for aging analysis and prioritization of dispute resolution activities.',
    `amount` DECIMAL(18,2) COMMENT 'Total monetary amount deducted by the retailer from the invoice payment. Represents the initial claim amount before dispute resolution.',
    `approval_date` DATE COMMENT 'Date on which the deduction settlement was approved by the authorized approver. Represents the decision point in the workflow.',
    `approved_amount` DECIMAL(18,2) COMMENT 'Monetary amount of the deduction that was approved and accepted by the manufacturer after dispute resolution. May be less than, equal to, or zero relative to the original deduction amount.',
    `business_unit_code` STRING COMMENT 'Business unit or division code responsible for managing this deduction. Used for organizational reporting and accountability.',
    `claim_reference_number` STRING COMMENT 'External reference number provided by the retailer for their deduction claim. Used for cross-referencing with retailer systems and documentation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this deduction record was first created in the system. Represents the audit trail creation point.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the deduction amount. Indicates the currency in which the deduction was taken.. Valid values are `^[A-Z]{3}$`',
    `deduction_date` DATE COMMENT 'Date on which the retailer took the deduction from the invoice payment. Represents the business event timestamp for the deduction.',
    `deduction_number` STRING COMMENT 'Business-facing unique deduction number assigned by the retailer or internal system. Used for external communication and dispute tracking.',
    `deduction_type` STRING COMMENT 'Classification of the deduction based on the reason for the short-payment. Promotional deductions relate to trade promotions, pricing deductions to price discrepancies, shortage to quantity issues, compliance to retailer policy violations, quality to product defects, freight to shipping issues, and administrative to processing errors. [ENUM-REF-CANDIDATE: promotional|pricing|shortage|compliance|quality|freight|administrative — 7 candidates stripped; promote to reference product]',
    `dispute_reason` STRING COMMENT 'Detailed textual explanation of why the manufacturer disputed all or part of the deduction. Provides context for dispute resolution and audit trail.',
    `dispute_status` STRING COMMENT 'Current lifecycle status of the deduction in the dispute resolution workflow. Open indicates initial receipt, approved indicates full acceptance, disputed indicates challenge by manufacturer, partially_approved indicates partial acceptance, written_off indicates unrecoverable amount, and pending_review indicates under investigation.. Valid values are `open|approved|disputed|partially_approved|written_off|pending_review`',
    `disputed_amount` DECIMAL(18,2) COMMENT 'Monetary amount of the deduction that is currently under dispute or was rejected by the manufacturer. Represents the portion of the deduction not accepted.',
    `gmroi_impact_percentage` DECIMAL(18,2) COMMENT 'Percentage impact of this deduction on the gross margin return on investment for the associated promotion. Used for profitability analysis and promotional effectiveness measurement.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this deduction record was last modified. Used for audit trail and change tracking.',
    `priority_level` STRING COMMENT 'Priority classification for dispute resolution based on deduction amount, retailer relationship, and aging. Critical indicates immediate attention required, high indicates urgent resolution needed, medium indicates standard processing, and low indicates routine handling.. Valid values are `critical|high|medium|low`',
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
    `source` STRING COMMENT 'Source system or channel through which the deduction was received. Retailer portal indicates web-based submission, EDI 846 indicates electronic data interchange, manual entry indicates internal creation, bank reconciliation indicates discovery during payment matching, and automated matching indicates system-generated from remittance data.. Valid values are `retailer_portal|edi_846|manual_entry|bank_reconciliation|automated_matching`',
    `supporting_document_url` STRING COMMENT 'URL or file path to supporting documentation for the deduction claim, such as proof of performance, promotional materials, or retailer correspondence. Used for audit and dispute resolution.',
    CONSTRAINT pk_deduction PRIMARY KEY(`deduction_id`)
) COMMENT 'Transactional record representing the full lifecycle of a retailer deduction from initial short-payment through final settlement. Captures deduction number, retailer account, invoice reference, deduction amount, deduction type (promotional, pricing, shortage, compliance), deduction date, dispute status (open, approved, disputed, written-off), and complete settlement details: settlement date, settlement method (credit memo, check, offset against future invoice, write-off), settled amount, approved amount, disputed amount, settlement reason code, approver, and linkage to originating promotion event and funding agreement. Serves as the single entity for the entire deduction management workflow — no separate settlement record exists. Central to trade spend reconciliation, dispute resolution, and retailer relationship management.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` (
    `deduction_settlement_id` BIGINT COMMENT 'Unique identifier for the deduction settlement record. Primary key for the deduction settlement entity.',
    `accrual_id` BIGINT COMMENT 'Foreign key linking to promotion.promotion_accrual. Business justification: When a deduction is settled, the settlement must be matched against the originating accrual to close the financial liability. This FK completes the accrual-deduction-settlement lifecycle chain, enabli',
    `deduction_id` BIGINT COMMENT 'Reference to the originating retailer deduction that this settlement resolves. Links to the deduction record in the trade promotion management system.',
    `funding_agreement_id` BIGINT COMMENT 'Reference to the trade promotion funding agreement or contract that governs the terms under which this deduction was taken and settled.',
    `parent_settlement_deduction_settlement_id` BIGINT COMMENT 'Reference to a parent settlement record if this is a follow-up or partial settlement. Enables tracking of multi-stage settlement processes for complex deductions.',
    `trade_account_id` BIGINT COMMENT 'Reference to the retail customer account associated with this deduction settlement. Identifies the retailer or distributor party.',
    `approval_date` DATE COMMENT 'The date on which the settlement was formally approved by the authorized approver. Marks the transition from under review to approved status.',
    `approved_amount` DECIMAL(18,2) COMMENT 'The amount approved by the manufacturer for settlement after review and validation. May differ from the claimed amount due to disputes or partial approvals.',
    `business_unit_code` STRING COMMENT 'The business unit or division responsible for this settlement. Used for organizational reporting and trade spend allocation.. Valid values are `^[A-Z0-9]{2,10}$`',
    `cost_center_code` STRING COMMENT 'The cost center responsible for this settlement expense. Used for internal cost allocation and profitability analysis by organizational unit.. Valid values are `^[A-Z0-9]{4,12}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this settlement record was first created in the system. Provides audit trail for record creation.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this settlement record. Ensures consistent currency interpretation across multi-currency operations.. Valid values are `^[A-Z]{3}$`',
    `deduction_claimed_amount` DECIMAL(18,2) COMMENT 'The original amount claimed by the retailer in the deduction. Represents the initial disputed or taken amount before settlement negotiation.',
    `dispute_resolution_method` STRING COMMENT 'The approach used to resolve any disputes between the claimed and approved amounts. Documents the resolution process for compliance and process improvement.. Valid values are `negotiation|arbitration|escalation|partial_approval|full_approval|write_off`',
    `disputed_amount` DECIMAL(18,2) COMMENT 'The portion of the deduction claimed amount that was disputed or rejected by the manufacturer. Represents the difference between claimed and approved amounts when not fully approved.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month or quarter) within the fiscal year in which this settlement was recorded. Enables period-based trade spend tracking.',
    `fiscal_year` STRING COMMENT 'The fiscal year in which this settlement was recorded. Used for period-based financial reporting and year-over-year trade spend analysis.',
    `gl_account_code` STRING COMMENT 'The general ledger account code to which this settlement transaction was posted. Ensures proper financial classification and reporting of trade spend.. Valid values are `^[0-9]{4,10}$`',
    `is_partial_settlement` BOOLEAN COMMENT 'Boolean flag indicating whether this settlement represents a partial resolution of the deduction. True if the deduction requires additional settlements; false if fully resolved.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this settlement record was last updated. Tracks the most recent change for audit and data quality purposes.',
    `payment_date` DATE COMMENT 'The date on which the settlement payment was issued or credited to the retailer. Represents the actual financial transaction date.',
    `payment_reference_number` STRING COMMENT 'External reference number for the payment transaction, such as check number, wire transfer confirmation, or credit memo number. Used for reconciliation with financial systems.',
    `profit_center_code` STRING COMMENT 'The profit center associated with this settlement. Enables profitability reporting and analysis by business segment or product line.. Valid values are `^[A-Z0-9]{4,12}$`',
    `settled_amount` DECIMAL(18,2) COMMENT 'The final amount paid or credited to the retailer as part of this settlement. This is the actual financial transaction amount and may include adjustments beyond the approved amount.',
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
    CONSTRAINT pk_deduction_settlement PRIMARY KEY(`deduction_settlement_id`)
) COMMENT 'Transactional record capturing the resolution and settlement of a retailer deduction. Tracks settlement date, settlement method (credit memo, check, offset against future invoice, write-off), settled amount, approved amount, disputed amount, settlement reason code, approver, and linkage to the originating deduction and funding agreement. Enables closed-loop deduction management and accurate trade spend reconciliation.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` (
    `promoted_price_id` BIGINT COMMENT 'Primary key for promoted_price',
    `event_id` BIGINT COMMENT 'Reference to the parent promotion event or campaign under which this promotional price is defined. Links to the broader trade promotion execution context.',
    `funding_agreement_id` BIGINT COMMENT 'Foreign key linking to promotion.funding_agreement. Business justification: Promoted prices — particularly scan_back_rate and promotional_allowance_amount — are funded through specific retailer funding agreements. This FK links the price point to the contractual funding sourc',
    `sku_id` BIGINT COMMENT 'Reference to the SKU (Stock Keeping Unit) for which this promotional price is defined. Identifies the specific product variant being promoted.',
    `trade_account_id` BIGINT COMMENT 'Reference to the retailer or trade account for which this promotional price applies. Enables account-specific promotional pricing strategies.',
    `trade_promotion_id` BIGINT COMMENT 'Foreign key linking to promotion.trade_promotion. Business justification: Promoted prices are defined within the context of a trade promotion program. While the existing promotion_event_id provides event-level linkage, a direct FK to trade_promotion supports program-level p',
    `accrual_method` STRING COMMENT 'The method used to accrue and settle trade promotion funds for this promotional price. Scan-back (per unit sold), bill-back (post-event invoice), off-invoice (upfront discount), lump-sum (fixed payment), or performance-based (tied to metrics).. Valid values are `scan_back|bill_back|off_invoice|lump_sum|performance_based`',
    `approval_date` DATE COMMENT 'The date when this promotional price was formally approved for execution. Part of the audit trail for trade promotion compliance.',
    `approval_status` STRING COMMENT 'Current lifecycle status of the promotional price record. Tracks the approval workflow from draft through execution to expiration. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|rejected|active|expired|cancelled — 7 candidates stripped; promote to reference product]',
    `cost_of_goods_sold` DECIMAL(18,2) COMMENT 'The manufacturers cost of goods sold per unit for the SKU at the time this promotional price was defined. Used for promotional ROI and GMROI analysis.',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code where this promotional price is valid. Supports multi-country promotional planning and compliance.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this promotional pricing record was first created in the system. Part of the audit trail for data lineage and compliance.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the promotional price amount and regular shelf price (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `effective_end_date` DATE COMMENT 'The date when this promotional price expires and is no longer valid. Nullable for open-ended or evergreen promotional pricing programs.',
    `effective_start_date` DATE COMMENT 'The date when this promotional price becomes active and available for use in retail execution and point-of-sale systems.',
    `estimated_volume_lift` DECIMAL(18,2) COMMENT 'The projected percentage increase in sales volume expected from this promotional price compared to baseline sales. Used for demand planning and promotional forecasting.',
    `funding_source` STRING COMMENT 'Identifies the party responsible for funding this promotional price discount. Manufacturer-funded, retailer-funded, co-op (shared), vendor-funded, or third-party funded.. Valid values are `manufacturer|retailer|co_op|vendor|third_party`',
    `is_advertised` BOOLEAN COMMENT 'Boolean flag indicating whether this promotional price is featured in retailer advertising, circulars, or marketing campaigns. True if advertised, False if unadvertised in-store promotion.',
    `is_stackable` BOOLEAN COMMENT 'Boolean flag indicating whether this promotional price can be combined (stacked) with other promotions, coupons, or discounts. True if stackable, False if exclusive.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this promotional pricing record was last updated or modified. Used for change tracking and audit purposes.',
    `maximum_purchase_quantity` STRING COMMENT 'The maximum number of units eligible for this promotional price per transaction or per customer. Used to cap promotional exposure and manage trade spend. Nullable if no cap applies.',
    `minimum_purchase_quantity` STRING COMMENT 'The minimum number of units a consumer or retailer must purchase to qualify for this promotional price. Used for multi-buy and volume-based promotions. Nullable if no minimum applies.',
    `price_reduction_percentage` DECIMAL(18,2) COMMENT 'The percentage discount from the regular shelf price, calculated as ((regular_shelf_price - promotional_price_amount) / regular_shelf_price) * 100. Represents the depth of the promotional discount.',
    `pricing_strategy_type` STRING COMMENT 'Classification of the promotional pricing strategy. Hi-Lo (High-Low temporary price reduction), EDLP (Everyday Low Price), multi-buy (e.g., 2 for $5), BOGO (Buy One Get One), scan-back (retailer scans at checkout for discount), temporary price reduction, rebate, or coupon-based pricing. [ENUM-REF-CANDIDATE: hi_lo|edlp|multi_buy|bogo|scan_back|temporary_price_reduction|rebate|coupon — 8 candidates stripped; promote to reference product]',
    `promotional_allowance_amount` DECIMAL(18,2) COMMENT 'The per-unit allowance or funding provided by the manufacturer to the retailer to support this promotional price. Used for trade spend accrual and settlement calculations.',
    `promotional_price_amount` DECIMAL(18,2) COMMENT 'The promoted price point for the SKU during the promotional period. This is the actual selling price offered to consumers or retailers during the promotion.',
    `promotional_price_code` STRING COMMENT 'Business identifier or code for this promotional price record. Used for external reference and integration with TPM systems.. Valid values are `^[A-Z0-9_-]{4,20}$`',
    `promotional_price_description` STRING COMMENT 'Detailed description of the promotional price offer, including terms, conditions, and any special instructions for retail execution or consumer communication.',
    `promotional_price_name` STRING COMMENT 'Human-readable name or label for this promotional price configuration, used for identification and reporting purposes.',
    `region_code` STRING COMMENT 'Geographic region code where this promotional price is applicable. Enables regional pricing strategies and localized trade promotions.. Valid values are `^[A-Z]{2,10}$`',
    `regular_shelf_price` DECIMAL(18,2) COMMENT 'The standard or recommended selling price (RSP/MSRP) for the SKU before the promotional discount is applied. Used as the baseline for calculating price reduction depth.',
    `retailer_margin_percentage` DECIMAL(18,2) COMMENT 'The target or agreed-upon margin percentage for the retailer when selling at this promotional price. Used for trade negotiation and pricing strategy analysis.',
    `scan_back_rate` DECIMAL(18,2) COMMENT 'The per-unit reimbursement rate paid to the retailer for each unit sold at the promotional price under a scan-back pricing model. Nullable if not a scan-back promotion.',
    `tpm_system_code` STRING COMMENT 'External system identifier from the source Trade Promotion Management system (e.g., Salesforce TPM, SAP TPM). Used for data lineage and system integration.',
    CONSTRAINT pk_promoted_price PRIMARY KEY(`promoted_price_id`)
) COMMENT 'Master entity capturing the promotional price points defined for SKUs within a promotion event or pricing program. Tracks promoted price type (Hi-Lo temporary price reduction, EDLP, multi-buy, BOGO, scan-back price), promoted price amount, regular shelf price (RSP/MSRP), price reduction depth (%), effective date range, retailer account, channel, and approval status. Distinct from standard list pricing — this entity owns the promotional price layer used during trade events.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ADD CONSTRAINT `fk_promotion_trade_promotion_trade_calendar_id` FOREIGN KEY (`trade_calendar_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`trade_calendar`(`trade_calendar_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event` ADD CONSTRAINT `fk_promotion_event_funding_agreement_id` FOREIGN KEY (`funding_agreement_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`funding_agreement`(`funding_agreement_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event` ADD CONSTRAINT `fk_promotion_event_trade_calendar_id` FOREIGN KEY (`trade_calendar_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`trade_calendar`(`trade_calendar_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event` ADD CONSTRAINT `fk_promotion_event_trade_promotion_id` FOREIGN KEY (`trade_promotion_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`trade_promotion`(`trade_promotion_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ADD CONSTRAINT `fk_promotion_event_sku_event_id` FOREIGN KEY (`event_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`event`(`event_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ADD CONSTRAINT `fk_promotion_event_sku_promoted_price_id` FOREIGN KEY (`promoted_price_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`promoted_price`(`promoted_price_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ADD CONSTRAINT `fk_promotion_event_sku_funding_agreement_id` FOREIGN KEY (`funding_agreement_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`funding_agreement`(`funding_agreement_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ADD CONSTRAINT `fk_promotion_trade_calendar_parent_calendar_trade_calendar_id` FOREIGN KEY (`parent_calendar_trade_calendar_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`trade_calendar`(`trade_calendar_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ADD CONSTRAINT `fk_promotion_trade_spend_allocation_event_id` FOREIGN KEY (`event_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`event`(`event_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ADD CONSTRAINT `fk_promotion_trade_spend_allocation_funding_agreement_id` FOREIGN KEY (`funding_agreement_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`funding_agreement`(`funding_agreement_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ADD CONSTRAINT `fk_promotion_trade_spend_allocation_trade_calendar_id` FOREIGN KEY (`trade_calendar_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`trade_calendar`(`trade_calendar_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ADD CONSTRAINT `fk_promotion_trade_spend_allocation_trade_promotion_id` FOREIGN KEY (`trade_promotion_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`trade_promotion`(`trade_promotion_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ADD CONSTRAINT `fk_promotion_funding_agreement_previous_agreement_funding_agreement_id` FOREIGN KEY (`previous_agreement_funding_agreement_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`funding_agreement`(`funding_agreement_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`accrual` ADD CONSTRAINT `fk_promotion_accrual_event_id` FOREIGN KEY (`event_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`event`(`event_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`accrual` ADD CONSTRAINT `fk_promotion_accrual_funding_agreement_id` FOREIGN KEY (`funding_agreement_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`funding_agreement`(`funding_agreement_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`accrual` ADD CONSTRAINT `fk_promotion_accrual_trade_promotion_id` FOREIGN KEY (`trade_promotion_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`trade_promotion`(`trade_promotion_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction` ADD CONSTRAINT `fk_promotion_deduction_accrual_id` FOREIGN KEY (`accrual_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`accrual`(`accrual_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction` ADD CONSTRAINT `fk_promotion_deduction_event_id` FOREIGN KEY (`event_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`event`(`event_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction` ADD CONSTRAINT `fk_promotion_deduction_funding_agreement_id` FOREIGN KEY (`funding_agreement_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`funding_agreement`(`funding_agreement_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ADD CONSTRAINT `fk_promotion_deduction_settlement_accrual_id` FOREIGN KEY (`accrual_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`accrual`(`accrual_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ADD CONSTRAINT `fk_promotion_deduction_settlement_deduction_id` FOREIGN KEY (`deduction_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`deduction`(`deduction_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ADD CONSTRAINT `fk_promotion_deduction_settlement_funding_agreement_id` FOREIGN KEY (`funding_agreement_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`funding_agreement`(`funding_agreement_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ADD CONSTRAINT `fk_promotion_deduction_settlement_parent_settlement_deduction_settlement_id` FOREIGN KEY (`parent_settlement_deduction_settlement_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement`(`deduction_settlement_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ADD CONSTRAINT `fk_promotion_promoted_price_event_id` FOREIGN KEY (`event_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`event`(`event_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ADD CONSTRAINT `fk_promotion_promoted_price_funding_agreement_id` FOREIGN KEY (`funding_agreement_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`funding_agreement`(`funding_agreement_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ADD CONSTRAINT `fk_promotion_promoted_price_trade_promotion_id` FOREIGN KEY (`trade_promotion_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`trade_promotion`(`trade_promotion_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_consumer_goods_v1`.`promotion` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_consumer_goods_v1`.`promotion` SET TAGS ('dbx_domain' = 'promotion');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` SET TAGS ('dbx_subdomain' = 'campaign_management');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `trade_promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Promotion ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Product Brand Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Brand ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `product_category_id` SET TAGS ('dbx_business_glossary_term' = 'Product Category Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Account ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `trade_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Calendar Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `accrual_amount` SET TAGS ('dbx_business_glossary_term' = 'Trade Promotion Accrual Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `accrual_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Promotion Approval Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `authorized_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Authorized Trade Spend Budget Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `authorized_budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `baseline_volume_units` SET TAGS ('dbx_business_glossary_term' = 'Baseline Volume Units');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `baseline_volume_units` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `channel_type` SET TAGS ('dbx_business_glossary_term' = 'Retail Channel Type');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `channel_type` SET TAGS ('dbx_value_regex' = 'grocery|mass_merchandiser|drug|convenience|club|ecommerce');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `coupon_flag` SET TAGS ('dbx_business_glossary_term' = 'Coupon Included Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `deduction_amount` SET TAGS ('dbx_business_glossary_term' = 'Trade Promotion Deduction Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `deduction_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Promotional Discount Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `display_type` SET TAGS ('dbx_business_glossary_term' = 'In-Store Display Type');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `display_type` SET TAGS ('dbx_value_regex' = 'end_cap|free_standing|shelf_talker|pallet|cooler|none');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Promotion End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `expected_roi_percentage` SET TAGS ('dbx_business_glossary_term' = 'Expected Return on Investment (ROI) Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `expected_roi_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `feature_ad_flag` SET TAGS ('dbx_business_glossary_term' = 'Feature Advertisement Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `funding_type` SET TAGS ('dbx_business_glossary_term' = 'Trade Promotion Funding Type');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `funding_type` SET TAGS ('dbx_value_regex' = 'off_invoice|scan_back|bill_back|lump_sum|accrual');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_value_regex' = 'national|regional|local|store_specific');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `maximum_purchase_quantity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Purchase Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `minimum_purchase_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Purchase Quantity (MOQ)');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Promotion Notes');
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
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `settlement_status` SET TAGS ('dbx_business_glossary_term' = 'Financial Settlement Status');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `settlement_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|settled|disputed');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Promotion Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `target_volume_units` SET TAGS ('dbx_business_glossary_term' = 'Target Volume Units');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `target_volume_units` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ALTER COLUMN `tpm_system_reference_code` SET TAGS ('dbx_business_glossary_term' = 'Trade Promotion Management (TPM) System Reference ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event` SET TAGS ('dbx_subdomain' = 'campaign_management');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event` ALTER COLUMN `event_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Event ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event` ALTER COLUMN `funding_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Funding Agreement Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event` ALTER COLUMN `product_category_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event` ALTER COLUMN `retail_store_id` SET TAGS ('dbx_business_glossary_term' = 'Ship-To Location ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Network Node Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Account ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event` ALTER COLUMN `trade_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Calendar Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event` ALTER COLUMN `trade_promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Program ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event` ALTER COLUMN `accrual_amount` SET TAGS ('dbx_business_glossary_term' = 'Accrual Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event` ALTER COLUMN `actual_trade_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Trade Spend Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event` ALTER COLUMN `actual_volume_units` SET TAGS ('dbx_business_glossary_term' = 'Actual Volume Units');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event` ALTER COLUMN `baseline_volume_units` SET TAGS ('dbx_business_glossary_term' = 'Baseline Volume Units');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event` ALTER COLUMN `cancellation_date` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event` ALTER COLUMN `deduction_amount` SET TAGS ('dbx_business_glossary_term' = 'Deduction Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event` ALTER COLUMN `event_description` SET TAGS ('dbx_business_glossary_term' = 'Event Description');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Event End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event` ALTER COLUMN `event_number` SET TAGS ('dbx_business_glossary_term' = 'Event Number');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event` ALTER COLUMN `event_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event` ALTER COLUMN `event_status` SET TAGS ('dbx_business_glossary_term' = 'Event Status');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event` ALTER COLUMN `event_status` SET TAGS ('dbx_value_regex' = 'planned|approved|in_execution|completed|cancelled');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'feature_ad|display|temporary_price_reduction|bogo|scan_back|coupon');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event` ALTER COLUMN `funding_source` SET TAGS ('dbx_business_glossary_term' = 'Funding Source');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event` ALTER COLUMN `funding_source` SET TAGS ('dbx_value_regex' = 'manufacturer|retailer|cooperative');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event` ALTER COLUMN `geography_code` SET TAGS ('dbx_business_glossary_term' = 'Geography Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event` ALTER COLUMN `geography_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event` ALTER COLUMN `gmroi_ratio` SET TAGS ('dbx_business_glossary_term' = 'Gross Margin Return on Investment (GMROI) Ratio');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event` ALTER COLUMN `event_name` SET TAGS ('dbx_business_glossary_term' = 'Event Name');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event` ALTER COLUMN `planned_trade_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Planned Trade Spend Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event` ALTER COLUMN `planned_volume_units` SET TAGS ('dbx_business_glossary_term' = 'Planned Volume Units');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event` ALTER COLUMN `post_event_analysis_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Post-Event Analysis Completed Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event` ALTER COLUMN `post_event_analysis_date` SET TAGS ('dbx_business_glossary_term' = 'Post-Event Analysis Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event` ALTER COLUMN `pricing_strategy` SET TAGS ('dbx_business_glossary_term' = 'Pricing Strategy');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event` ALTER COLUMN `pricing_strategy` SET TAGS ('dbx_value_regex' = 'hi_lo|edlp|hybrid');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event` ALTER COLUMN `promotional_lift_percentage` SET TAGS ('dbx_business_glossary_term' = 'Promotional Lift Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event` ALTER COLUMN `rebate_amount` SET TAGS ('dbx_business_glossary_term' = 'Rebate Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event` ALTER COLUMN `roi_percentage` SET TAGS ('dbx_business_glossary_term' = 'Return on Investment (ROI) Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event` ALTER COLUMN `salesforce_tpm_event_code` SET TAGS ('dbx_business_glossary_term' = 'Salesforce Trade Promotion Management (TPM) Event ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event` ALTER COLUMN `salesforce_tpm_event_code` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9]{15,18}$');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event` ALTER COLUMN `settlement_status` SET TAGS ('dbx_business_glossary_term' = 'Settlement Status');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event` ALTER COLUMN `settlement_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|settled|disputed');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Event Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` SET TAGS ('dbx_subdomain' = 'campaign_management');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `event_sku_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Event SKU (Stock Keeping Unit) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `demand_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Demand Plan Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `event_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Event ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `manufacturing_bom_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Bom Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `promoted_price_id` SET TAGS ('dbx_business_glossary_term' = 'Promoted Price Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `funding_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Retailer Funding Agreement ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `routing_id` SET TAGS ('dbx_business_glossary_term' = 'Routing Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'SKU (Stock Keeping Unit) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Account ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `accrual_amount` SET TAGS ('dbx_business_glossary_term' = 'Accrual Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `actual_promotional_volume_cases` SET TAGS ('dbx_business_glossary_term' = 'Actual Promotional Volume (Cases)');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `actual_promotional_volume_units` SET TAGS ('dbx_business_glossary_term' = 'Actual Promotional Volume (Units)');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `baseline_volume_estimate_units` SET TAGS ('dbx_business_glossary_term' = 'Baseline Volume Estimate (Units)');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `compliance_check_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Check Status');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `compliance_check_status` SET TAGS ('dbx_value_regex' = 'Not Checked|Compliant|Non-Compliant|Under Review');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `compliance_verified_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Verified Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `deduction_amount` SET TAGS ('dbx_business_glossary_term' = 'Deduction Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `display_location_type` SET TAGS ('dbx_business_glossary_term' = 'Display Location Type');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `feature_type` SET TAGS ('dbx_business_glossary_term' = 'Feature Type');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `gtin` SET TAGS ('dbx_business_glossary_term' = 'GTIN (Global Trade Item Number)');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `gtin` SET TAGS ('dbx_value_regex' = '^[0-9]{8,14}$');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `incremental_lift_percent` SET TAGS ('dbx_business_glossary_term' = 'Incremental Lift Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `incremental_lift_volume_units` SET TAGS ('dbx_business_glossary_term' = 'Incremental Lift Volume (Units)');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `is_featured_sku` SET TAGS ('dbx_business_glossary_term' = 'Is Featured SKU Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `planned_promotional_volume_cases` SET TAGS ('dbx_business_glossary_term' = 'Planned Promotional Volume (Cases)');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `planned_promotional_volume_units` SET TAGS ('dbx_business_glossary_term' = 'Planned Promotional Volume (Units)');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `price_reduction_depth_percent` SET TAGS ('dbx_business_glossary_term' = 'Price Reduction Depth Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `pricing_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Pricing Approval Status');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `pricing_approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Pricing Approved Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `promoted_price_type` SET TAGS ('dbx_business_glossary_term' = 'Promoted Price Type');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `promotion_effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Promotion Effective End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `promotion_effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Promotion Effective Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `promotional_discount_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Promotional Discount Per Unit');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `promotional_gmroi` SET TAGS ('dbx_business_glossary_term' = 'Promotional GMROI (Gross Margin Return on Investment)');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `promotional_roi_percent` SET TAGS ('dbx_business_glossary_term' = 'Promotional ROI (Return on Investment) Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `rebate_amount` SET TAGS ('dbx_business_glossary_term' = 'Rebate Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `regular_shelf_price` SET TAGS ('dbx_business_glossary_term' = 'Regular Shelf Price (RSP)');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `settlement_status` SET TAGS ('dbx_business_glossary_term' = 'Settlement Status');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `settlement_status` SET TAGS ('dbx_value_regex' = 'Not Started|In Progress|Reconciled|Settled|Disputed');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `total_trade_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Trade Spend Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `upc` SET TAGS ('dbx_business_glossary_term' = 'UPC (Universal Product Code)');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ALTER COLUMN `upc` SET TAGS ('dbx_value_regex' = '^[0-9]{12}$');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` SET TAGS ('dbx_subdomain' = 'campaign_management');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ALTER COLUMN `trade_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Calendar Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Product Brand Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ALTER COLUMN `parent_calendar_trade_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Calendar ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ALTER COLUMN `product_category_id` SET TAGS ('dbx_business_glossary_term' = 'Product Category Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Account ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ALTER COLUMN `actual_event_count` SET TAGS ('dbx_business_glossary_term' = 'Actual Event Count');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ALTER COLUMN `calendar_code` SET TAGS ('dbx_business_glossary_term' = 'Calendar Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ALTER COLUMN `calendar_name` SET TAGS ('dbx_business_glossary_term' = 'Calendar Name');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ALTER COLUMN `calendar_status` SET TAGS ('dbx_business_glossary_term' = 'Calendar Status');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ALTER COLUMN `calendar_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|locked|active|closed');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ALTER COLUMN `closed_date` SET TAGS ('dbx_business_glossary_term' = 'Closed Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ALTER COLUMN `trade_calendar_description` SET TAGS ('dbx_business_glossary_term' = 'Calendar Description');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ALTER COLUMN `is_baseline_calendar` SET TAGS ('dbx_business_glossary_term' = 'Is Baseline Calendar');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ALTER COLUMN `locked_date` SET TAGS ('dbx_business_glossary_term' = 'Locked Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Calendar Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ALTER COLUMN `planned_event_count` SET TAGS ('dbx_business_glossary_term' = 'Planned Event Count');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ALTER COLUMN `planning_cycle` SET TAGS ('dbx_business_glossary_term' = 'Planning Cycle');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ALTER COLUMN `planning_cycle` SET TAGS ('dbx_value_regex' = 'annual|semi-annual|quarterly|monthly');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ALTER COLUMN `pricing_strategy` SET TAGS ('dbx_business_glossary_term' = 'Pricing Strategy');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ALTER COLUMN `pricing_strategy` SET TAGS ('dbx_value_regex' = 'hi-lo|edlp|hybrid|promotional|premium');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ALTER COLUMN `total_planned_trade_spend` SET TAGS ('dbx_business_glossary_term' = 'Total Planned Trade Spend');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ALTER COLUMN `total_planned_trade_spend` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ALTER COLUMN `tpm_system_code` SET TAGS ('dbx_business_glossary_term' = 'Trade Promotion Management (TPM) System ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` SET TAGS ('dbx_subdomain' = 'financial_settlement');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `trade_spend_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Spend Allocation ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `demand_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Demand Plan Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `event_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Event ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `funding_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Funding Agreement Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Brand ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `product_category_id` SET TAGS ('dbx_business_glossary_term' = 'Product Category Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Account ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `trade_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Calendar Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `trade_promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Promotion Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `accrual_amount` SET TAGS ('dbx_business_glossary_term' = 'Accrual Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `actual_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Spend Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `actual_volume` SET TAGS ('dbx_business_glossary_term' = 'Actual Volume');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `allocated_amount` SET TAGS ('dbx_business_glossary_term' = 'Allocated Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `allocation_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `allocation_number` SET TAGS ('dbx_business_glossary_term' = 'Trade Spend Allocation Number');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `allocation_number` SET TAGS ('dbx_value_regex' = '^TSA-[0-9]{8}-[A-Z0-9]{6}$');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `baseline_volume` SET TAGS ('dbx_business_glossary_term' = 'Baseline Volume');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `committed_amount` SET TAGS ('dbx_business_glossary_term' = 'Committed Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^CC[0-9]{6}$');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `deduction_amount` SET TAGS ('dbx_business_glossary_term' = 'Deduction Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `gmroi_percentage` SET TAGS ('dbx_business_glossary_term' = 'Gross Margin Return on Investment (GMROI) Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Allocation Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `pricing_strategy` SET TAGS ('dbx_business_glossary_term' = 'Pricing Strategy');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `pricing_strategy` SET TAGS ('dbx_value_regex' = 'hi_lo|edlp|hybrid|premium|penetration|competitive');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_value_regex' = '^PC[0-9]{6}$');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `promotion_end_date` SET TAGS ('dbx_business_glossary_term' = 'Promotion End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `promotion_start_date` SET TAGS ('dbx_business_glossary_term' = 'Promotion Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `roi_percentage` SET TAGS ('dbx_business_glossary_term' = 'Return on Investment (ROI) Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `settlement_amount` SET TAGS ('dbx_business_glossary_term' = 'Settlement Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `spend_category` SET TAGS ('dbx_business_glossary_term' = 'Trade Spend Category');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `spend_category` SET TAGS ('dbx_value_regex' = 'price_discount|merchandising|marketing|listing|performance_incentive|other');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `spend_type` SET TAGS ('dbx_business_glossary_term' = 'Trade Spend Type');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `spend_type` SET TAGS ('dbx_value_regex' = 'off_invoice_discount|scan_back|bill_back|lump_sum|coop_advertising|slotting_fee');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `target_volume` SET TAGS ('dbx_business_glossary_term' = 'Target Volume');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `volume_uom` SET TAGS ('dbx_business_glossary_term' = 'Volume Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ALTER COLUMN `volume_uom` SET TAGS ('dbx_value_regex' = 'units|cases|pallets|kg|liters');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` SET TAGS ('dbx_subdomain' = 'financial_settlement');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `funding_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Funding Agreement ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Product Brand Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `previous_agreement_funding_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Agreement ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `product_category_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Account ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `accrual_method` SET TAGS ('dbx_business_glossary_term' = 'Accrual Method');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `accrual_method` SET TAGS ('dbx_value_regex' = 'straight_line|event_based|scan_based|milestone_based');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `accrued_to_date_amount` SET TAGS ('dbx_business_glossary_term' = 'Accrued To Date Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `agreement_name` SET TAGS ('dbx_business_glossary_term' = 'Agreement Name');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Number');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}-[0-9]{6,10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'annual_lump_sum|scan_back|co_op|slotting|performance_based|volume_rebate');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'not_submitted|pending_review|approved|rejected|revision_required');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Renewal Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `contract_document_url` SET TAGS ('dbx_business_glossary_term' = 'Contract Document URL');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `deduction_settlement_terms` SET TAGS ('dbx_business_glossary_term' = 'Deduction Settlement Terms');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `funding_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Funding Period End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `funding_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Funding Period Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `gmroi_target` SET TAGS ('dbx_business_glossary_term' = 'Gross Margin Return on Investment (GMROI) Target');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `manufacturer_signatory_name` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Signatory Name');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `manufacturer_signatory_title` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Signatory Title');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `manufacturer_signature_date` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Signature Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `paid_to_date_amount` SET TAGS ('dbx_business_glossary_term' = 'Paid To Date Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Payment Frequency');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_value_regex' = 'one_time|monthly|quarterly|semi_annual|annual|event_based');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `performance_conditions` SET TAGS ('dbx_business_glossary_term' = 'Performance Conditions');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `remaining_balance_amount` SET TAGS ('dbx_business_glossary_term' = 'Remaining Balance Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `retailer_signatory_name` SET TAGS ('dbx_business_glossary_term' = 'Retailer Signatory Name');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `retailer_signatory_title` SET TAGS ('dbx_business_glossary_term' = 'Retailer Signatory Title');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `retailer_signature_date` SET TAGS ('dbx_business_glossary_term' = 'Retailer Signature Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `roi_target_percentage` SET TAGS ('dbx_business_glossary_term' = 'Return on Investment (ROI) Target Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `termination_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Days');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ALTER COLUMN `total_committed_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Committed Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`accrual` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`accrual` SET TAGS ('dbx_subdomain' = 'financial_settlement');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`accrual` ALTER COLUMN `accrual_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Accrual ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`accrual` ALTER COLUMN `event_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Event ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`accrual` ALTER COLUMN `funding_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Funding Agreement Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`accrual` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`accrual` ALTER COLUMN `product_category_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`accrual` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`accrual` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Account ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`accrual` ALTER COLUMN `trade_promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Promotion Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`accrual` ALTER COLUMN `accrual_number` SET TAGS ('dbx_business_glossary_term' = 'Accrual Number');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`accrual` ALTER COLUMN `accrual_number` SET TAGS ('dbx_value_regex' = '^ACR-[0-9]{10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`accrual` ALTER COLUMN `accrual_status` SET TAGS ('dbx_business_glossary_term' = 'Accrual Status');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`accrual` ALTER COLUMN `accrual_status` SET TAGS ('dbx_value_regex' = 'open|pending_approval|approved|settled|reversed|cancelled');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`accrual` ALTER COLUMN `accrual_type` SET TAGS ('dbx_business_glossary_term' = 'Accrual Type');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`accrual` ALTER COLUMN `accrual_type` SET TAGS ('dbx_value_regex' = 'scan_back|bill_back|off_invoice|lump_sum|volume_rebate|performance_bonus');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`accrual` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Accrual Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`accrual` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`accrual` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`accrual` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`accrual` ALTER COLUMN `baseline_volume` SET TAGS ('dbx_business_glossary_term' = 'Baseline Volume');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`accrual` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`accrual` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^CC[0-9]{6}$');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`accrual` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`accrual` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`accrual` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`accrual` ALTER COLUMN `deduction_claim_number` SET TAGS ('dbx_business_glossary_term' = 'Deduction Claim Number');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`accrual` ALTER COLUMN `deduction_claim_number` SET TAGS ('dbx_value_regex' = '^DED-[0-9]{10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`accrual` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`accrual` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`accrual` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`accrual` ALTER COLUMN `gmroi` SET TAGS ('dbx_business_glossary_term' = 'Gross Margin Return on Investment (GMROI)');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`accrual` ALTER COLUMN `incremental_volume` SET TAGS ('dbx_business_glossary_term' = 'Incremental Volume');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`accrual` ALTER COLUMN `is_disputed` SET TAGS ('dbx_business_glossary_term' = 'Is Disputed');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`accrual` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`accrual` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`accrual` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`accrual` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_value_regex' = '^PAY-[0-9]{10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`accrual` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Accrual Period End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`accrual` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Accrual Period Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`accrual` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`accrual` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_value_regex' = '^PC[0-9]{6}$');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`accrual` ALTER COLUMN `quantity_sold` SET TAGS ('dbx_business_glossary_term' = 'Quantity Sold');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`accrual` ALTER COLUMN `rate` SET TAGS ('dbx_business_glossary_term' = 'Accrual Rate');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`accrual` ALTER COLUMN `recognition_date` SET TAGS ('dbx_business_glossary_term' = 'Recognition Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`accrual` ALTER COLUMN `reversal_date` SET TAGS ('dbx_business_glossary_term' = 'Reversal Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`accrual` ALTER COLUMN `roi_percentage` SET TAGS ('dbx_business_glossary_term' = 'Return on Investment (ROI) Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`accrual` ALTER COLUMN `sap_co_document_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Controlling (CO) Document Number');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`accrual` ALTER COLUMN `sap_co_document_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`accrual` ALTER COLUMN `sap_fi_document_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Financial Accounting (FI) Document Number');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`accrual` ALTER COLUMN `sap_fi_document_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`accrual` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`accrual` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`accrual` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`accrual` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'each|case|pallet|kilogram|liter');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction` SET TAGS ('dbx_subdomain' = 'financial_settlement');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction` ALTER COLUMN `deduction_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Deduction ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction` ALTER COLUMN `accrual_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Accrual Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction` ALTER COLUMN `event_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Event ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction` ALTER COLUMN `funding_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Funding Agreement ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Account ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction` ALTER COLUMN `accrual_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Accrual Impact Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction` ALTER COLUMN `aging_days` SET TAGS ('dbx_business_glossary_term' = 'Aging Days');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Deduction Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction` ALTER COLUMN `approved_amount` SET TAGS ('dbx_business_glossary_term' = 'Approved Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction` ALTER COLUMN `business_unit_code` SET TAGS ('dbx_business_glossary_term' = 'Business Unit Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction` ALTER COLUMN `claim_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Claim Reference Number');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction` ALTER COLUMN `deduction_date` SET TAGS ('dbx_business_glossary_term' = 'Deduction Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction` ALTER COLUMN `deduction_number` SET TAGS ('dbx_business_glossary_term' = 'Deduction Number');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction` ALTER COLUMN `deduction_type` SET TAGS ('dbx_business_glossary_term' = 'Deduction Type');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction` ALTER COLUMN `dispute_status` SET TAGS ('dbx_business_glossary_term' = 'Dispute Status');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction` ALTER COLUMN `dispute_status` SET TAGS ('dbx_value_regex' = 'open|approved|disputed|partially_approved|written_off|pending_review');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction` ALTER COLUMN `disputed_amount` SET TAGS ('dbx_business_glossary_term' = 'Disputed Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction` ALTER COLUMN `gmroi_impact_percentage` SET TAGS ('dbx_business_glossary_term' = 'Gross Margin Return on Investment (GMROI) Impact Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction` ALTER COLUMN `retailer_claim_date` SET TAGS ('dbx_business_glossary_term' = 'Retailer Claim Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction` ALTER COLUMN `retailer_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Retailer Contact Email');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction` ALTER COLUMN `retailer_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction` ALTER COLUMN `retailer_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction` ALTER COLUMN `retailer_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction` ALTER COLUMN `retailer_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Retailer Contact Name');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction` ALTER COLUMN `retailer_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction` ALTER COLUMN `roi_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Return on Investment (ROI) Impact Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction` ALTER COLUMN `settled_amount` SET TAGS ('dbx_business_glossary_term' = 'Settled Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction` ALTER COLUMN `settlement_method` SET TAGS ('dbx_business_glossary_term' = 'Settlement Method');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction` ALTER COLUMN `settlement_method` SET TAGS ('dbx_value_regex' = 'credit_memo|check|offset_future_invoice|write_off|bank_transfer');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction` ALTER COLUMN `settlement_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Settlement Reason Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction` ALTER COLUMN `sla_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Resolution Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction` ALTER COLUMN `source` SET TAGS ('dbx_business_glossary_term' = 'Deduction Source');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction` ALTER COLUMN `source` SET TAGS ('dbx_value_regex' = 'retailer_portal|edi_846|manual_entry|bank_reconciliation|automated_matching');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction` ALTER COLUMN `supporting_document_url` SET TAGS ('dbx_business_glossary_term' = 'Supporting Document URL');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` SET TAGS ('dbx_subdomain' = 'financial_settlement');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ALTER COLUMN `deduction_settlement_id` SET TAGS ('dbx_business_glossary_term' = 'Deduction Settlement Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ALTER COLUMN `accrual_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Accrual Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ALTER COLUMN `deduction_id` SET TAGS ('dbx_business_glossary_term' = 'Deduction Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ALTER COLUMN `funding_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Funding Agreement Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ALTER COLUMN `parent_settlement_deduction_settlement_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Settlement Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Account Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ALTER COLUMN `approved_amount` SET TAGS ('dbx_business_glossary_term' = 'Approved Settlement Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ALTER COLUMN `business_unit_code` SET TAGS ('dbx_business_glossary_term' = 'Business Unit Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ALTER COLUMN `business_unit_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ALTER COLUMN `deduction_claimed_amount` SET TAGS ('dbx_business_glossary_term' = 'Deduction Claimed Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ALTER COLUMN `dispute_resolution_method` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Method');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ALTER COLUMN `dispute_resolution_method` SET TAGS ('dbx_value_regex' = 'negotiation|arbitration|escalation|partial_approval|full_approval|write_off');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ALTER COLUMN `disputed_amount` SET TAGS ('dbx_business_glossary_term' = 'Disputed Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ALTER COLUMN `is_partial_settlement` SET TAGS ('dbx_business_glossary_term' = 'Is Partial Settlement Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ALTER COLUMN `settled_amount` SET TAGS ('dbx_business_glossary_term' = 'Settled Amount');
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
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` SET TAGS ('dbx_subdomain' = 'campaign_management');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ALTER COLUMN `promoted_price_id` SET TAGS ('dbx_business_glossary_term' = 'Promoted Price Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ALTER COLUMN `event_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Event ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ALTER COLUMN `funding_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Funding Agreement Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Account ID');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ALTER COLUMN `trade_promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Promotion Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ALTER COLUMN `accrual_method` SET TAGS ('dbx_business_glossary_term' = 'Accrual Method');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ALTER COLUMN `accrual_method` SET TAGS ('dbx_value_regex' = 'scan_back|bill_back|off_invoice|lump_sum|performance_based');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ALTER COLUMN `cost_of_goods_sold` SET TAGS ('dbx_business_glossary_term' = 'Cost of Goods Sold (COGS)');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ALTER COLUMN `cost_of_goods_sold` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ALTER COLUMN `estimated_volume_lift` SET TAGS ('dbx_business_glossary_term' = 'Estimated Volume Lift Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ALTER COLUMN `funding_source` SET TAGS ('dbx_business_glossary_term' = 'Funding Source');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ALTER COLUMN `funding_source` SET TAGS ('dbx_value_regex' = 'manufacturer|retailer|co_op|vendor|third_party');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ALTER COLUMN `is_advertised` SET TAGS ('dbx_business_glossary_term' = 'Is Advertised Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ALTER COLUMN `is_stackable` SET TAGS ('dbx_business_glossary_term' = 'Is Stackable Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ALTER COLUMN `maximum_purchase_quantity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Purchase Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ALTER COLUMN `minimum_purchase_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Purchase Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ALTER COLUMN `price_reduction_percentage` SET TAGS ('dbx_business_glossary_term' = 'Price Reduction Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ALTER COLUMN `pricing_strategy_type` SET TAGS ('dbx_business_glossary_term' = 'Pricing Strategy Type');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ALTER COLUMN `promotional_allowance_amount` SET TAGS ('dbx_business_glossary_term' = 'Promotional Allowance Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ALTER COLUMN `promotional_price_amount` SET TAGS ('dbx_business_glossary_term' = 'Promotional Price Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ALTER COLUMN `promotional_price_code` SET TAGS ('dbx_business_glossary_term' = 'Promotional Price Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ALTER COLUMN `promotional_price_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{4,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ALTER COLUMN `promotional_price_description` SET TAGS ('dbx_business_glossary_term' = 'Promotional Price Description');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ALTER COLUMN `promotional_price_name` SET TAGS ('dbx_business_glossary_term' = 'Promotional Price Name');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ALTER COLUMN `region_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ALTER COLUMN `regular_shelf_price` SET TAGS ('dbx_business_glossary_term' = 'Regular Shelf Price (RSP)');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ALTER COLUMN `retailer_margin_percentage` SET TAGS ('dbx_business_glossary_term' = 'Retailer Margin Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ALTER COLUMN `scan_back_rate` SET TAGS ('dbx_business_glossary_term' = 'Scan-Back Rate');
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ALTER COLUMN `tpm_system_code` SET TAGS ('dbx_business_glossary_term' = 'Trade Promotion Management (TPM) System ID');
