-- Schema for Domain: order | Business:  | Version: v2_ecm
-- Generated on: 2026-07-10 18:45:42

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_restaurants_v1`.`order` COMMENT 'Core transactional domain managing order capture, fulfillment, and delivery across all service channels including POS (Oracle MICROS), drive-thru (DT), online ordering (OLO), third-party delivery (3PD), and catering. Tracks order lifecycle, KDS routing, ticket time, speed of service (SOS), average transaction count (ATC), and average check value (ACV).';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`order`.`guest_order` (
    `guest_order_id` BIGINT COMMENT 'Unique surrogate identifier for each guest order record in the lakehouse Silver layer. Primary key for the guest_order data product.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Required for campaign performance reporting: each order is tagged with the marketing campaign that drove the purchase, enabling ROI analysis.',
    `channel_id` BIGINT COMMENT 'Foreign key linking to order.order_channel. Business justification: guest_order currently stores channel as a string; linking to order_channel lookup provides referential integrity and removes redundant column.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Required for Cost Center expense allocation per order, enabling finances Cost Center reporting and profitability analysis.',
    `coupon_id` BIGINT COMMENT 'Foreign key linking to marketing.coupon. Business justification: Needed for coupon redemption audit: linking an order to the coupon entity allows accurate discount accounting and fraud detection.',
    `franchisee_id` BIGINT COMMENT 'Foreign key linking to franchise.franchisee. Business justification: Required for franchisee royalty reporting and performance dashboards that aggregate orders by the owning franchisee; each order must be tied to the franchisee operating the restaurant.',
    `profile_id` BIGINT COMMENT 'Identifier of the guest (customer) who placed the order. Nullable for anonymous walk-in transactions where no loyalty or digital profile is associated. Serves as the PARTY_REFERENCE for this transaction header.',
    `illness_report_id` BIGINT COMMENT 'Foreign key linking to foodsafety.illness_report. Business justification: Illness investigation requires linking the specific order to the reported foodborne illness case for traceability and root‑cause analysis.',
    `local_store_marketing_id` BIGINT COMMENT 'Foreign key linking to marketing.local_store_marketing. Business justification: Enables attribution of orders to store‑level marketing initiatives, required for local ROI and budget allocation reports.',
    `member_id` BIGINT COMMENT 'Foreign key linking to loyalty.member. Business justification: Needed for loyalty points accrual and member order history report linking each order to the member who placed it.',
    `program_id` BIGINT COMMENT 'Identifier of the loyalty program associated with this order, if the guest is enrolled. Used to link loyalty point accrual and redemption events to the order transaction.',
    `marketing_guest_segment_id` BIGINT COMMENT 'Foreign key linking to marketing.marketing_guest_segment. Business justification: Supports segment‑based sales analysis: orders are associated with the guest segment targeted by marketing campaigns for segmentation reporting.',
    `menu_id` BIGINT COMMENT 'Foreign key linking to menu.menu. Business justification: Required for Menu Performance Reporting: each order must be linked to the specific menu version presented to the guest to analyze sales per menu and ensure compliance with menu engineering.',
    `primary_guest_profile_id` BIGINT COMMENT 'Identifier of the guest (customer) who placed the order. Nullable for anonymous walk-in transactions where no loyalty or digital profile is associated. Serves as the PARTY_REFERENCE for this transaction header.',
    `promotion_id` BIGINT COMMENT 'Identifier of the marketing promotion, coupon, or Limited Time Offer (LTO) applied to this order. Null if no promotion was applied. Used for promotional campaign effectiveness and discount attribution analysis.',
    `employee_id` BIGINT COMMENT 'Identifier of the Front of House (FOH) server or cashier employee who took or managed the order. Used for labor performance tracking, tip allocation, and service quality analysis.',
    `site_id` BIGINT COMMENT 'Identifier of the restaurant location where the order was placed or fulfilled. Links to the restaurant master record.',
    `territory_id` BIGINT COMMENT 'Foreign key linking to franchise.territory. Business justification: Needed for territory‑level sales and compliance reporting; orders are aggregated by the franchise territory that the restaurant belongs to.',
    `unit_id` BIGINT COMMENT 'Identifier of the restaurant location where the order was placed or fulfilled. Links to the restaurant master record.',
    `cancelled_at` TIMESTAMP COMMENT 'Timestamp when the order was cancelled or voided. Null for orders that were fulfilled. Used for cancellation rate reporting and operational analysis.',
    `created_at` TIMESTAMP COMMENT 'Timestamp when this guest_order record was first created in the lakehouse Silver layer. Serves as the RECORD_AUDIT_CREATED field for this transaction header. Distinct from placed_at which captures the business event time.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the monetary amounts in this order (e.g., USD, CAD, GBP). Required for multi-currency international restaurant operations. Part of the MONETARY_TRIPLET currency component.. Valid values are `^[A-Z]{3}$`',
    `daypart` STRING COMMENT 'Operational daypart segment during which the order was placed. Dayparts are defined by the restaurants operating schedule and used for Product Mix (PMIX) analysis, labor scheduling, and sales reporting. Standard segments: breakfast, lunch, afternoon, dinner, late_night.. Valid values are `breakfast|lunch|afternoon|dinner|late_night`',
    `delivery_address_line1` STRING COMMENT 'Primary street address line for delivery orders. Contains personally identifiable location information for the guest. Null for non-delivery order types.',
    `delivery_postal_code` STRING COMMENT 'Postal or ZIP code of the delivery address. Used for delivery zone analysis, geographic sales reporting, and logistics optimization. Contains guest location data classified as PII.',
    `delivery_provider` STRING COMMENT 'Name of the third-party delivery (3PD) provider fulfilling the delivery order. Null or none for non-delivery orders. Used for 3PD commission cost analysis and delivery performance benchmarking.. Valid values are `doordash|uber_eats|grubhub|postmates|internal|none`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total monetary value of all discounts, promotions, coupons, and loyalty redemptions applied to the order. Represents the adjustment component of the MONETARY_TRIPLET. Used for promotional effectiveness and Cost of Goods Sold (COGS) analysis.',
    `fulfilled_at` TIMESTAMP COMMENT 'Timestamp when the order was handed to the guest or dispatched for delivery, marking the completion of the service transaction. Used for end-to-end Speed of Service (SOS) measurement.',
    `is_lto` BOOLEAN COMMENT 'Indicates whether the order contains at least one Limited Time Offer (LTO) menu item. Used for LTO performance tracking, promotional sales attribution, and menu engineering analysis.',
    `is_voided` BOOLEAN COMMENT 'Indicates whether the order was voided by a manager after tender. Voided orders are retained for audit and loss prevention purposes but excluded from revenue reporting. Distinct from cancelled orders (cancelled before preparation).',
    `item_count` STRING COMMENT 'Total number of individual menu items (including modifiers and add-ons) included in the order. Used for throughput analysis, kitchen capacity planning, and Average Transaction Count (ATC) benchmarking.',
    `kds_routed_at` TIMESTAMP COMMENT 'Timestamp when the order was routed to the Kitchen Display System (KDS) for preparation. Used to calculate kitchen queue time and Back of House (BOH) throughput metrics.',
    `loyalty_points_earned` STRING COMMENT 'Number of loyalty reward points earned by the guest for this order transaction. Used for loyalty program accrual tracking and guest engagement analytics.',
    `loyalty_points_redeemed` STRING COMMENT 'Number of loyalty reward points redeemed by the guest as part of this order transaction. Used for loyalty liability accounting and promotional cost analysis.',
    `olo_order_ref` STRING COMMENT 'External order reference number assigned by the Olo Digital Ordering Platform for orders placed through digital channels (web, mobile app). Null for in-store POS orders.',
    `order_status` STRING COMMENT 'Current lifecycle state of the guest order. Tracks the order from placement through fulfillment or cancellation. placed = order received; in_preparation = KDS routing active; ready = food ready for pickup/delivery; fulfilled = order handed to guest; cancelled = cancelled before preparation; voided = voided post-tender by manager.. Valid values are `placed|in_preparation|ready|fulfilled|cancelled|voided`',
    `order_type` STRING COMMENT 'Fulfillment type of the order indicating how the guest intends to receive their food. Distinct from order_channel (which captures the ordering interface). Used for kitchen routing, packaging, and service time analytics.. Valid values are `dine_in|takeout|drive_thru|delivery|curbside|catering`',
    `party_size` STRING COMMENT 'Number of guests in the dining party associated with this order. Applicable for dine-in orders. Used for cover count reporting, table turn analysis, and per-cover revenue calculations.',
    `payment_status` STRING COMMENT 'Current status of the payment transaction associated with this order. Distinct from order_status which tracks fulfillment lifecycle. Used for financial reconciliation and exception management.. Valid values are `pending|authorized|captured|refunded|voided|failed`',
    `placed_at` TIMESTAMP COMMENT 'The principal real-world event timestamp when the guest order was placed and confirmed in the POS or digital ordering system. Serves as the BUSINESS_EVENT_TIMESTAMP for this transaction header. Used for Speed of Service (SOS) calculations and daypart assignment.',
    `pos_transaction_ref` STRING COMMENT 'Native transaction reference or check number generated by the Oracle MICROS POS system. Used for reconciliation between the lakehouse and the POS system of record.',
    `ready_at` TIMESTAMP COMMENT 'Timestamp when the order was marked ready for pickup or delivery by kitchen staff. Used to calculate ticket time (time from order placement to food ready) and Speed of Service (SOS) metrics.',
    `sos_seconds` STRING COMMENT 'Total elapsed time in seconds from order placement (placed_at) to order fulfillment (fulfilled_at). Represents the end-to-end guest experience time. A primary operational KPI for Quick-Service Restaurants (QSR) and Drive-Thru (DT) performance benchmarking.',
    `special_instructions` STRING COMMENT 'Free-text field capturing guest-specific preparation instructions, allergy notes, or customization requests entered at the time of ordering. Used by kitchen staff for order fulfillment and food safety compliance (HACCP allergen awareness).',
    `subtotal_amount` DECIMAL(18,2) COMMENT 'Gross pre-tax, pre-discount monetary value of all items in the order. Represents the base order value before adjustments. Part of the MONETARY_TRIPLET for this transaction header.',
    `table_number` STRING COMMENT 'Table or seat identifier assigned to the dine-in order within the restaurant floor plan. Null for takeout, drive-thru, and delivery orders. Used for table turn analysis and Front of House (FOH) service management.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total sales tax amount applied to the order based on applicable local, state, and federal tax rates. Part of the MONETARY_TRIPLET adjustment. Used for tax remittance reporting and financial reconciliation.',
    `tender_type` STRING COMMENT 'Primary payment instrument used to settle the order. Supports payment mix analysis and PCI DSS compliance reporting. [ENUM-REF-CANDIDATE: cash|credit_card|debit_card|mobile_pay|gift_card|loyalty_points|voucher|comp — promote to reference product]. Valid values are `cash|credit_card|debit_card|mobile_pay|gift_card|loyalty_points`',
    `ticket_number` STRING COMMENT 'Human-readable, externally visible order ticket number assigned by the Point of Sale (POS) system (Oracle MICROS). Printed on receipts and displayed on the Kitchen Display System (KDS). Serves as the BUSINESS_IDENTIFIER for this transaction. Format varies by restaurant configuration (e.g., sequential daily number).',
    `ticket_time_seconds` STRING COMMENT 'Elapsed time in seconds from order placement (placed_at) to order ready (ready_at). Represents the kitchen preparation time, a key Speed of Service (SOS) and throughput KPI in restaurant operations. Stored as a raw operational field captured by the POS/KDS system.',
    `tip_amount` DECIMAL(18,2) COMMENT 'Gratuity amount added by the guest at the time of payment. Applicable for casual and fine-dining service models. Used for labor compensation reporting and financial reconciliation.',
    `total_amount` DECIMAL(18,2) COMMENT 'Final net monetary amount charged to the guest after applying discounts and adding taxes (subtotal_amount - discount_amount + tax_amount). Represents the Average Check Value (ACV) for this transaction. Net total component of the MONETARY_TRIPLET.',
    `updated_at` TIMESTAMP COMMENT 'Timestamp when this guest_order record was last modified in the lakehouse Silver layer. Serves as the RECORD_AUDIT_UPDATED field for this transaction header. Used for incremental data processing and change data capture (CDC) pipelines.',
    `void_reason` STRING COMMENT 'Reason code for why the order was voided. Null for non-voided orders. Used for loss prevention, operational exception reporting, and manager accountability tracking.. Valid values are `guest_request|error_correction|system_error|manager_comp|other`',
    CONSTRAINT pk_guest_order PRIMARY KEY(`guest_order_id`)
) COMMENT 'Core transactional header record for every guest order placed across all service channels (POS/MICROS, drive-thru, OLO, 3PD, catering, kiosk). Captures order-level attributes: ticket number, order type, service channel, daypart, order status, guest count, total amount, tax total, discount total, timestamps (placed, promised, completed), and source system reference. This is the authoritative SSOT for all order transactions — every order_item, order_payment, order_status_event, and kds_ticket FKs back to this record.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`order`.`order_item` (
    `order_item_id` BIGINT COMMENT 'Unique surrogate identifier for each line item within a guest order. Primary key for the order_item entity in the Silver Layer lakehouse.',
    `discount_id` BIGINT COMMENT 'Reference to the promotional discount, coupon, or loyalty reward applied to this line item. Null when no discount is applied. Links to the marketing domain for promotional effectiveness analysis.',
    `guest_order_id` BIGINT COMMENT 'Reference to the parent guest order (TRANSACTION_HEADER) to which this line item belongs. Establishes the header/detail relationship for order fulfillment and revenue reporting.',
    `ingredient_id` BIGINT COMMENT 'Foreign key linking to supply.ingredient. Business justification: REQUIRED: Ingredient‑level sales and nutrition reporting needs each order_item linked to its ingredient for cost, menu analysis, and regulatory nutrition disclosure.',
    `ingredient_lot_id` BIGINT COMMENT 'Foreign key linking to supply.ingredient_lot. Business justification: REQUIRED: Food‑safety traceability and recall reports must map each sold item to the specific ingredient lot used in its preparation.',
    `kitchen_station_id` BIGINT COMMENT 'Reference to the Kitchen Display System (KDS) station to which this line item was routed for preparation. Supports kitchen throughput and ticket time analysis.',
    `menu_item_id` BIGINT COMMENT 'Reference to the menu item ordered, linking to the menu domain for Product Mix (PMIX) analysis, recipe costing, and allergen reporting.',
    `menu_lto_id` BIGINT COMMENT 'Foreign key linking to menu.lto. Business justification: Needed for Limited‑Time Offer (LTO) effectiveness tracking: linking each order line to its LTO campaign enables calculation of lift, cost, and ROI for promotional items.',
    `menu_modifier_id` BIGINT COMMENT 'Reference to the modifier applied to this line item (e.g., extra cheese, no onions, upsize). Nullable when no modifier is applied. Supports modifier-level PMIX and upsell analysis.',
    `combo_meal_id` BIGINT COMMENT 'Reference to the combo meal or bundle to which this line item belongs. Null when is_combo_component is False. Groups combo components for bundle-level revenue and PMIX reporting.',
    `order_combo_meal_id` BIGINT COMMENT 'Reference to the combo meal or bundle to which this line item belongs. Null when is_combo_component is False. Groups combo components for bundle-level revenue and PMIX reporting.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Labor costing & food‑safety audit need to know which employee prepared each menu item; supports per‑item labor allocation and accountability.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Assigns each sold menu item to a profit center for granular P&L analysis per restaurant segment.',
    `allergen_override_flag` BOOLEAN COMMENT 'Indicates whether a manager or authorized staff member overrode an allergen warning for this line item at the Point of Sale (POS). True triggers an audit trail for food safety compliance and liability management.',
    `calorie_count` STRING COMMENT 'Total calorie count for this line item as required by FDA menu labeling regulations. Reflects the calorie value at the ordered quantity and modifier combination. Supports regulatory compliance and guest nutrition transparency.',
    `cost` DECIMAL(18,2) COMMENT 'Standard cost of goods for this line item at the time of the transaction, sourced from the recipe/Bill of Materials (BOM). Used to calculate Cost of Goods Sold Percentage (COGS%) and gross margin at the item level.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this order item record was first captured in the source system (Oracle MICROS POS or Olo). Represents the moment the line item was added to the order. Used for audit trail and data lineage in the Silver Layer.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary amounts on this line item (e.g., USD, CAD, GBP). Supports multi-currency operations across global restaurant markets.. Valid values are `^[A-Z]{3}$`',
    `daypart_code` STRING COMMENT 'Operational daypart during which this line item was ordered (e.g., breakfast, lunch, dinner, late_night). Supports daypart-level PMIX analysis, labor scheduling alignment, and revenue management by time segment.. Valid values are `breakfast|lunch|afternoon|dinner|late_night`',
    `is_combo_component` BOOLEAN COMMENT 'Indicates whether this line item is a component of a combo meal or bundle (True) or a standalone item (False). Supports combo meal PMIX analysis and bundle pricing validation.',
    `is_lto` BOOLEAN COMMENT 'Indicates whether the ordered menu item is a Limited Time Offer (LTO) at the time of the transaction. Supports LTO performance tracking, PMIX contribution analysis, and promotional campaign reporting.',
    `item_status` STRING COMMENT 'Current fulfillment lifecycle status of this line item as tracked through the Kitchen Display System (KDS) and Point of Sale (POS). Drives kitchen throughput reporting and Speed of Service (SOS) measurement.. Valid values are `ordered|in_preparation|ready|served|voided|comped`',
    `kds_bump_timestamp` TIMESTAMP COMMENT 'Timestamp when the kitchen staff bumped (completed) this line item on the Kitchen Display System (KDS), indicating preparation is complete. Core metric for ticket time and kitchen throughput reporting.',
    `kds_sent_timestamp` TIMESTAMP COMMENT 'Timestamp when this line item was transmitted to the Kitchen Display System (KDS) station for preparation. Used to calculate ticket time and Speed of Service (SOS) from order placement to kitchen receipt.',
    `line_discount_amount` DECIMAL(18,2) COMMENT 'Total discount applied at the line-item level, including promotional discounts, coupon redemptions, loyalty rewards, and employee meal discounts. Supports promotional effectiveness and margin analysis.',
    `line_gross_amount` DECIMAL(18,2) COMMENT 'Gross extended amount for this line item before discounts and taxes, calculated as quantity × (unit_price + modifier_price). Used as the basis for COGS% and revenue reporting.',
    `line_net_amount` DECIMAL(18,2) COMMENT 'Net revenue amount for this line item after all line-level discounts, before tax. Equals line_gross_amount minus line_discount_amount. Core metric for Average Check Value (ACV) and P&L reporting.',
    `line_sequence` STRING COMMENT 'Sequential position of this line item within the parent order, starting at 1. Used to preserve the order of items as entered at the Point of Sale (POS) and for receipt printing.',
    `loyalty_points_earned` STRING COMMENT 'Number of loyalty program points earned by the guest for this line item, based on the loyalty program rules in effect at the time of the transaction. Supports loyalty program accrual tracking and CRM analytics.',
    `modifier_price` DECIMAL(18,2) COMMENT 'Incremental price charged for the applied modifier (e.g., upsize surcharge, premium add-on). Zero or null when no modifier price applies. Contributes to line-level revenue and Average Check Value (ACV) analysis.',
    `pmix_category` STRING COMMENT 'Menu engineering classification of this item within the Product Mix (PMIX) framework (e.g., Star, Plow Horse, Puzzle, Dog per the BCG matrix). Supports menu engineering decisions and item lifecycle management. [ENUM-REF-CANDIDATE: star|plow_horse|puzzle|dog — promote to reference product]',
    `preparation_instructions` STRING COMMENT 'Free-text special preparation instructions entered by the guest or cashier for this line item (e.g., well done, no salt, extra crispy). Transmitted to the Kitchen Display System (KDS) for Back of House (BOH) execution.',
    `promo_code` STRING COMMENT 'Alphanumeric promotional or coupon code entered at the Point of Sale (POS) or Online Ordering (OLO) platform that triggered the line-level discount. Supports campaign attribution and redemption tracking.',
    `quantity` DECIMAL(18,2) COMMENT 'Number of units of the menu item ordered on this line. Supports decimal precision for weight-based or fractional items (e.g., bulk catering). Used in PMIX analysis and COGS% calculation.',
    `refund_amount` DECIMAL(18,2) COMMENT 'Monetary amount refunded for this line item when refund_flag is True. May be a partial or full refund of line_net_amount. Used for financial reconciliation and guest recovery reporting.',
    `refund_flag` BOOLEAN COMMENT 'Indicates whether this line item has been refunded (True). Supports refund rate tracking, guest satisfaction (CSAT) analysis, and financial reconciliation in SAP S/4HANA.',
    `service_channel` STRING COMMENT 'The service channel through which this line item was ordered: dine-in, Drive-Thru (DT), Online Ordering (OLO), Third-Party Delivery (3PD), catering, or self-service kiosk. Supports channel-level PMIX and revenue analysis.. Valid values are `dine_in|drive_thru|online|third_party_delivery|catering|kiosk`',
    `source_system_item_ref` STRING COMMENT 'Native item identifier from the originating Point of Sale (POS) or Online Ordering (OLO) system (e.g., Oracle MICROS detail line ID, Olo order item UUID). Supports data lineage, reconciliation, and cross-system traceability in the Silver Layer.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax amount assessed on this line item based on applicable jurisdiction tax rules and menu item tax category. Supports tax remittance reporting and compliance with local tax authorities.',
    `tax_exempt_flag` BOOLEAN COMMENT 'Indicates whether this line item is exempt from sales tax (True), such as for qualifying food items under state/local tax law or institutional catering orders. Supports tax compliance and remittance reporting.',
    `ticket_time_seconds` STRING COMMENT 'Elapsed time in seconds from kds_sent_timestamp to kds_bump_timestamp, representing the preparation time for this line item. Key Speed of Service (SOS) metric for kitchen throughput and operational performance benchmarking.',
    `unit_price` DECIMAL(18,2) COMMENT 'Selling price per single unit of the menu item at the time of order, before modifiers, discounts, or taxes. Reflects the menu price in effect during the transaction for historical accuracy.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this order item record, such as a quantity change, void, or status update. Supports change data capture (CDC) and audit trail requirements in the Silver Layer.',
    `void_reason_code` STRING COMMENT 'Coded reason for voiding this line item (e.g., GUEST_CHANGE, PREP_ERROR, OUT_OF_STOCK, MANAGER_COMP). Null when item is not voided. Supports waste tracking and operational exception reporting. [ENUM-REF-CANDIDATE: GUEST_CHANGE|PREP_ERROR|OUT_OF_STOCK|MANAGER_COMP|ALLERGY|DUPLICATE — promote to reference product]',
    `waste_flag` BOOLEAN COMMENT 'Indicates whether this line item was recorded as food waste (True) rather than served to a guest. Supports Food Waste Percentage (Waste%) tracking, inventory reconciliation, and sustainability reporting.',
    `waste_reason_code` STRING COMMENT 'Coded reason for food waste on this line item when waste_flag is True. Supports root-cause analysis for Waste% reduction initiatives and HACCP compliance reporting.. Valid values are `overproduction|spoilage|prep_error|dropped|expired|quality_reject`',
    CONSTRAINT pk_order_item PRIMARY KEY(`order_item_id`)
) COMMENT 'Line-item detail for each menu item within a guest order. Captures the ordered menu item, quantity, unit price, modifiers applied, line-level discounts, PMIX contribution, preparation instructions, KDS station routing, and item-level fulfillment status. Supports PMIX analysis, COGS% calculation, and kitchen throughput reporting.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`order`.`order_modifier` (
    `order_modifier_id` BIGINT COMMENT 'Unique surrogate identifier for each order modifier record applied to an order line item. Primary key for the order_modifier data product in the Silver Layer lakehouse.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Compliance audit requires recording which employee applied a modifier (e.g., discount, special request) to ensure authorization and traceability.',
    `guest_order_id` BIGINT COMMENT 'Reference to the parent order transaction header. Enables direct order-level aggregation and reporting without requiring a join through the order item. Sourced from Oracle MICROS POS transaction records.',
    `modifier_group_id` BIGINT COMMENT 'Reference to the modifier group to which this modifier belongs (e.g., Protein Options, Sauce Selection, Temperature). Supports modifier group-level reporting and menu engineering analysis. Links to the menu domain modifier_group catalog.',
    `order_item_id` BIGINT COMMENT 'Reference to the parent order line item to which this modifier is applied. Establishes the header-detail relationship between the order item and its customizations. Aligns with Oracle MICROS POS order item detail records.',
    `menu_modifier_id` BIGINT COMMENT 'Reference to the menu modifier master record defining the base modifier configuration, pricing rules, and preparation instructions. Links to the menu domain modifier catalog.',
    `promotion_id` BIGINT COMMENT 'Reference to the promotional campaign or Limited Time Offer (LTO) that triggered or discounted this modifier. Supports marketing campaign attribution and promotional CoGS% impact analysis.',
    `source_modifier_menu_modifier_id` BIGINT COMMENT 'The native modifier transaction identifier from the originating operational system (e.g., Oracle MICROS POS modifier line ID, Olo modifier ID). Enables exact record traceability and reconciliation between the Silver Layer and the system of record.',
    `unit_id` BIGINT COMMENT 'Reference to the restaurant location where this modifier was applied. Enables location-level modifier adoption analysis, Product Mix (PMIX) reporting, and kitchen execution fidelity tracking.',
    `allergen_flag` BOOLEAN COMMENT 'Indicates whether this modifier introduces or removes an allergen from the order item (True). Triggers allergen advisory workflows and supports FDA food labeling compliance and HACCP allergen control point tracking.',
    `allergen_notes` STRING COMMENT 'Descriptive notes identifying the specific allergen(s) introduced or removed by this modifier (e.g., Contains: Tree Nuts, Removes: Gluten). Supports FDA FALCPA compliance, HACCP Hazard Analysis Critical Control Points documentation, and guest safety communication.',
    `applied_timestamp` TIMESTAMP COMMENT 'The date and time when this modifier was applied to the order item at the Point of Sale (POS) or digital ordering channel. Principal business event timestamp for Speed of Service (SOS) and Ticket Time analysis. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `calorie_delta` STRING COMMENT 'The incremental calorie change (positive or negative) contributed by this modifier to the parent order item. Required for FDA menu labeling compliance (Section 4205 of the ACA) and supports guest nutritional transparency.',
    `cogs_delta` DECIMAL(18,2) COMMENT 'The incremental raw food cost impact of this modifier on the order item, expressed in the local currency. Used for Cost of Goods Sold Percentage (CoGS%) calculation, menu engineering, and P&L reporting. Sourced from MarketMan Inventory Management BOM costing.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this order modifier record was first created in the Silver Layer lakehouse. Audit trail timestamp for data lineage and ETL reconciliation. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code applicable to the price delta of this modifier (e.g., USD, CAD, GBP). Supports multi-currency operations across global franchise and company-owned restaurant locations.. Valid values are `^[A-Z]{3}$`',
    `daypart` STRING COMMENT 'The meal period or daypart during which this modifier was applied (e.g., breakfast, lunch, dinner, late_night). Supports daypart-level PMIX analysis, modifier adoption trends, and targeted menu engineering decisions.. Valid values are `breakfast|lunch|afternoon|dinner|late_night`',
    `group_name` STRING COMMENT 'Name of the modifier group as displayed at the time of order capture (e.g., Add-Ons, Sauce, Cooking Preference). Snapshot value for historical reporting and PMIX analysis independent of menu restructuring.',
    `initiation_source` STRING COMMENT 'Indicates whether the modifier was explicitly requested by the guest, automatically applied as a system default (e.g., standard condiment), suggested by crew, or triggered by a loyalty or promotional rule. Critical for distinguishing guest-driven customization from operational defaults in PMIX and CoGS% analysis.. Valid values are `guest|system_default|crew_suggested|loyalty_rule|promotional_rule`',
    `is_comped` BOOLEAN COMMENT 'Indicates whether the price delta for this modifier was comped (complimentary, zero-charged) as part of a guest recovery, promotional offer, or manager override. Supports comp tracking for P&L and guest satisfaction (CSAT) analysis.',
    `is_default` BOOLEAN COMMENT 'Indicates whether this modifier was pre-selected as the system default configuration for the menu item (True) or was explicitly chosen/changed by the guest or crew (False). Used to distinguish standard preparation from customization in PMIX and kitchen execution analysis.',
    `is_voided` BOOLEAN COMMENT 'Indicates whether this modifier was voided after initial capture (True). Supports void analysis, kitchen error tracking, and accurate financial reconciliation. Distinct from modifier_status to enable fast boolean filtering in analytics.',
    `kds_acknowledged_timestamp` TIMESTAMP COMMENT 'The date and time when the kitchen crew acknowledged this modifier on the Kitchen Display System (KDS). Used to calculate kitchen execution latency and Ticket Time for Speed of Service (SOS) reporting. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `kds_routed` BOOLEAN COMMENT 'Indicates whether this modifier was successfully routed to the Kitchen Display System (KDS) for preparation execution (True). Supports kitchen execution fidelity tracking and Speed of Service (SOS) analysis.',
    `kds_station_name` STRING COMMENT 'The name of the Back of House (BOH) kitchen station to which this modifier was routed on the Kitchen Display System (KDS) (e.g., Grill, Fryer, Assembly, Beverage). Supports station-level throughput and execution fidelity analysis.',
    `loyalty_redemption_flag` BOOLEAN COMMENT 'Indicates whether this modifier was applied as part of a loyalty program redemption (True), such as a free add-on reward. Supports loyalty program ROI analysis and modifier-level redemption tracking.',
    `lto_flag` BOOLEAN COMMENT 'Indicates whether this modifier is associated with a Limited Time Offer (LTO) promotion (True). Supports LTO performance tracking, promotional PMIX analysis, and campaign effectiveness measurement.',
    `modifier_name` STRING COMMENT 'Human-readable name of the modifier as displayed on the Point of Sale (POS) screen, guest receipt, and Kitchen Display System (KDS) at the time the order was placed. Captured as a snapshot to preserve historical accuracy independent of menu changes.',
    `modifier_status` STRING COMMENT 'Current lifecycle state of the modifier on the order item. applied indicates the modifier was successfully executed; voided indicates it was removed post-capture; pending indicates awaiting kitchen confirmation; rejected indicates the modifier could not be fulfilled.. Valid values are `applied|voided|pending|rejected`',
    `modifier_type` STRING COMMENT 'Categorical classification of the modifier action applied to the order item. Drives Cost of Goods Sold Percentage (CoGS%) impact analysis and kitchen execution routing. [ENUM-REF-CANDIDATE: add_on|substitution|removal|upsize|downsize|special_request — promote to reference product if additional types are required]. Valid values are `add_on|substitution|removal|upsize|downsize|special_request`',
    `olo_modifier_code` STRING COMMENT 'The modifier code assigned by the Olo Digital Ordering Platform for online and third-party delivery orders. Enables cross-channel modifier reconciliation between POS and digital ordering channels.',
    `order_channel` STRING COMMENT 'The service channel through which the order containing this modifier was placed. Supports channel-level modifier adoption analysis across Point of Sale (POS), Drive-Thru (DT), Online Ordering (OLO), Third-Party Delivery (3PD), kiosk, and catering channels.. Valid values are `pos|drive_thru|online|third_party_delivery|kiosk|catering`',
    `pos_modifier_code` STRING COMMENT 'The native modifier code assigned by the Oracle MICROS POS system. Used for reconciliation between the Silver Layer lakehouse and the POS system of record, and for menu management synchronization.',
    `prep_instruction` STRING COMMENT 'Free-text or structured preparation instruction associated with this modifier as displayed on the KDS and printed order ticket (e.g., Extra crispy, No ice, On the side). Captures special preparation requests for kitchen execution fidelity and Standard Operating Procedure (SOP) compliance.',
    `price_delta` DECIMAL(18,2) COMMENT 'The incremental price adjustment applied to the order item as a result of this modifier. Positive values represent upcharges (e.g., premium add-ons); negative values represent discounts or removals that reduce item price. Essential for accurate revenue and Cost of Goods Sold Percentage (CoGS%) calculation.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the modifier applied to the order item (e.g., 2 extra shots of espresso, 0.5 for half portion). Supports fractional quantities for portion-based modifiers and accurate COGS% tracking.',
    `sequence_number` STRING COMMENT 'Ordinal position of this modifier within the set of modifiers applied to the parent order item. Used to preserve the display and preparation order on the Kitchen Display System (KDS) and printed receipts.',
    `unit_of_measure` STRING COMMENT 'The unit of measure for the modifier quantity (e.g., each for discrete add-ons, oz for liquid modifiers, g for weight-based modifiers). Supports accurate Bill of Materials (BOM) costing and inventory depletion via MarketMan. [ENUM-REF-CANDIDATE: each|oz|ml|g|portion|pump|slice|scoop — 8 candidates stripped; promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this order modifier record was last updated in the Silver Layer lakehouse. Supports change data capture (CDC) and incremental processing in the Databricks Lakehouse pipeline. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `voided_timestamp` TIMESTAMP COMMENT 'The date and time when this modifier was voided, if applicable. Null if the modifier was not voided. Supports void rate analysis and kitchen error tracking. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    CONSTRAINT pk_order_modifier PRIMARY KEY(`order_modifier_id`)
) COMMENT 'Records all customizations and modifiers applied to individual order items, including add-ons, substitutions, removals, and special preparation requests. Captures modifier name, modifier group, price delta, and whether the modifier was guest-initiated or system-defaulted. Essential for accurate COGS% tracking and kitchen execution fidelity.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`order`.`payment` (
    `payment_id` BIGINT COMMENT 'Unique surrogate identifier for each payment tender record associated with a guest order. Serves as the primary key for the order_payment data product in the Silver Layer lakehouse.',
    `employee_id` BIGINT COMMENT 'Reference to the FOH (Front of House) employee who processed this payment transaction at the POS terminal. Used for cash accountability, tip reporting, and labor performance analysis.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Needed to post each payment to the appropriate revenue GL account for accurate financial statements.',
    `guest_order_id` BIGINT COMMENT 'Reference to the parent guest order for which this payment tender was captured. Supports split-tender scenarios where multiple payment records link to a single order.',
    `member_id` BIGINT COMMENT 'Reference to the guest loyalty account from which points or rewards were redeemed as a payment tender. Applicable when tender_type is loyalty_redemption. Links to the loyalty domain for redemption tracking.',
    `pos_terminal_id` BIGINT COMMENT 'The identifier of the specific POS terminal or payment device on which this transaction was processed. Used for terminal-level reconciliation, hardware fault analysis, and PCI DSS scope management.',
    `profile_id` BIGINT COMMENT 'Foreign key linking to guest.profile. Business justification: Required for payment reconciliation reports linking each payment to the guest profile; essential for fraud detection and loyalty crediting.',
    `refund_id` BIGINT COMMENT 'The identifier of the original payment transaction being refunded or reversed. Populated only when payment_status is refunded or voided. Enables linkage between the original charge and its corresponding credit for reconciliation.',
    `site_id` BIGINT COMMENT 'Reference to the restaurant location where the payment was captured. Used for site-level financial reconciliation and AUV (Average Unit Volume) reporting.',
    `unit_id` BIGINT COMMENT 'Reference to the restaurant location where the payment was captured. Used for site-level financial reconciliation and AUV (Average Unit Volume) reporting.',
    `applied_amount` DECIMAL(18,2) COMMENT 'The net amount actually applied from this tender toward the order balance. In split-tender scenarios, this may be less than the tendered_amount. Represents the actual financial obligation satisfied by this tender line.',
    `authorization_code` STRING COMMENT 'The alphanumeric approval code returned by the payment processor or card network upon successful authorization of a card-based tender. Used for chargeback resolution, settlement reconciliation, and audit purposes.',
    `captured_timestamp` TIMESTAMP COMMENT 'The real-world date and time when the payment tender was captured at the Point of Sale (POS) or digital ordering channel. Principal business event timestamp for the payment record. Stored in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    `card_entry_method` STRING COMMENT 'The method by which card data was captured at the point of interaction. Impacts interchange rates, fraud liability, and PCI DSS compliance scope. Contactless includes NFC/tap-to-pay and mobile wallet transactions.. Valid values are `swipe|chip|contactless|manual_entry|token`',
    `card_type` STRING COMMENT 'The card network or brand associated with the payment card used for this tender (e.g., Visa, Mastercard, Amex). Used for interchange fee analysis and payment mix reporting.. Valid values are `visa|mastercard|amex|discover|unionpay|other`',
    `change_due_amount` DECIMAL(18,2) COMMENT 'The amount of change to be returned to the guest when the tendered_amount exceeds the applied_amount. Applicable primarily to cash tender transactions. Zero for card and digital payment types.',
    `channel` STRING COMMENT 'The service channel through which the payment was initiated. Distinct from tender_type (the instrument). Enables channel-level revenue analysis across POS (Point of Sale), DT (Drive-Thru), OLO (Online Ordering), 3PD (Third-Party Delivery), and catering. [ENUM-REF-CANDIDATE: pos|drive_thru|online|mobile_app|kiosk|3pd|catering — 7 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Audit timestamp recording when this payment record was first written to the data platform. Distinct from captured_timestamp which reflects the real-world payment event time.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the payment transaction (e.g., USD, CAD, GBP). Supports multi-currency operations across international restaurant markets.. Valid values are `^[A-Z]{3}$`',
    `daypart` STRING COMMENT 'The meal period or daypart during which the payment was captured. A key dimension in foodservice analytics for revenue distribution, staffing optimization, and promotional performance measurement across breakfast, lunch, dinner, and late-night periods.. Valid values are `breakfast|lunch|afternoon|dinner|late_night`',
    `discount_amount` DECIMAL(18,2) COMMENT 'The total monetary discount applied to this payment tender, including promotional discounts, coupon redemptions, and employee meal discounts. Part of the MONETARY_TRIPLET adjustment component for net revenue calculation.',
    `gift_card_number_masked` STRING COMMENT 'Masked identifier for the restaurant-issued gift card used in this tender transaction. Retains only partial digits for identification while protecting the full card value. Applicable when tender_type is gift_card.',
    `interchange_fee_amount` DECIMAL(18,2) COMMENT 'The fee charged by the card-issuing bank for processing this card payment, expressed in the transaction currency. A key component of payment processing cost analysis and COGS% (Cost of Goods Sold Percentage) calculations.',
    `is_split_tender` BOOLEAN COMMENT 'Flag indicating whether this payment record is part of a split-tender transaction where multiple payment instruments were used to satisfy a single order. True when the order has more than one associated payment tender record.',
    `is_voided` BOOLEAN COMMENT 'Flag indicating whether this payment tender record has been voided prior to settlement. A voided transaction was authorized but cancelled before batch close, distinguishing it from a post-settlement refund.',
    `loyalty_points_redeemed` STRING COMMENT 'The number of loyalty program points redeemed as part of this payment tender. Applicable when tender_type is loyalty_redemption. Used for loyalty liability accounting and program performance analytics.',
    `masked_card_number` STRING COMMENT 'PCI DSS-compliant masked representation of the payment card number, retaining only the first 4 and last 4 digits (e.g., 4111********1111). Full PANs (Primary Account Numbers) are never stored in the lakehouse per PCI DSS Requirement 3.3.. Valid values are `^[0-9]{4}*{8}[0-9]{4}$`',
    `offline_authorization_flag` BOOLEAN COMMENT 'Indicates whether this payment was authorized in offline mode due to network connectivity loss at the restaurant. Offline authorizations carry elevated fraud and chargeback risk and require special reconciliation handling.',
    `payment_status` STRING COMMENT 'Current lifecycle state of the payment tender record. Tracks the payment workflow from authorization through settlement or failure. [ENUM-REF-CANDIDATE: authorized|captured|settled|declined|voided|refunded|pending — promote to reference product if additional states are needed]. Valid values are `authorized|captured|settled|declined|voided|refunded`',
    `pos_transaction_number` STRING COMMENT 'The externally-known transaction number assigned by the Oracle MICROS POS system at the time of payment capture. Used for end-of-day reconciliation, chargeback research, and audit trails.',
    `processor_name` STRING COMMENT 'The name of the payment processing service provider that handled authorization and settlement for this tender (e.g., Worldpay, Heartland, Stripe, Square). Used for processor-level performance and fee analysis.',
    `processor_reference_code` STRING COMMENT 'The unique transaction identifier assigned by the external payment processor (e.g., Stripe, Worldpay, Heartland) for this tender. Used for cross-system reconciliation between POS and payment gateway records.',
    `promo_code_applied` STRING COMMENT 'The promotional or discount code entered by the guest at the time of payment, if applicable. Used to link payment records to marketing campaign performance and LTO (Limited Time Offer) redemption analytics.',
    `refund_reason` STRING COMMENT 'Categorical reason code explaining why a refund or void was issued for this payment. Used for operational quality analysis, CSAT (Customer Satisfaction) root cause investigation, and fraud monitoring.. Valid values are `guest_complaint|order_error|duplicate_charge|item_unavailable|other`',
    `response_code` STRING COMMENT 'The ISO 8583 or processor-specific response code returned by the payment network for this authorization attempt (e.g., 00 = Approved, 05 = Do Not Honor, 51 = Insufficient Funds). Used for decline analysis and payment success rate monitoring.',
    `settlement_batch_code` STRING COMMENT 'The batch identifier assigned by the payment processor during end-of-day settlement processing. Groups all captured transactions submitted together for bank funding. Used for daily cash reconciliation and SAP S/4HANA AR posting.',
    `settlement_date` DATE COMMENT 'The date on which the payment processor settled funds to the restaurants bank account. Distinct from captured_timestamp. Used for cash flow forecasting, bank reconciliation, and financial close processes in SAP S/4HANA.',
    `split_tender_sequence` STRING COMMENT 'Sequential line number identifying the order of tender application within a split-tender transaction. For example, a guest paying part cash and part credit card would have sequence 1 (cash) and sequence 2 (credit card). Enables correct reconstruction of multi-tender payment scenarios.',
    `tax_amount` DECIMAL(18,2) COMMENT 'The total sales tax or VAT amount included in this payment tender, as calculated by the POS system based on applicable jurisdiction tax rules. Required for tax remittance reporting and SAP S/4HANA tax posting.',
    `tender_type` STRING COMMENT 'Classification of the payment instrument used for this tender. Supports split-tender scenarios. Key dimension for payment mix analysis and financial settlement routing. 3PD (Third-Party Delivery) settlement represents aggregated remittance from delivery partners. [ENUM-REF-CANDIDATE: cash|credit_card|debit_card|gift_card|loyalty_redemption|3pd_settlement|mobile_wallet|voucher — promote to reference product if additional tender types are needed]. Valid values are `cash|credit_card|debit_card|gift_card|loyalty_redemption|3pd_settlement`',
    `tendered_amount` DECIMAL(18,2) COMMENT 'The gross amount presented by the guest for this specific tender line. In cash scenarios, this may exceed the order total, resulting in change due. In card scenarios, this equals the charged amount. Core component of the MONETARY_TRIPLET for payment-level financial analysis.',
    `third_party_delivery_partner` STRING COMMENT 'Identifies the 3PD (Third-Party Delivery) aggregator platform responsible for payment settlement when tender_type is 3pd_settlement. Used for partner-level remittance reconciliation and commission tracking.. Valid values are `doordash|uber_eats|grubhub|instacart|other`',
    `third_party_order_reference` STRING COMMENT 'The order identifier assigned by the 3PD (Third-Party Delivery) partner platform (e.g., DoorDash order ID, Uber Eats order ID). Used to cross-reference restaurant POS records with delivery partner settlement reports.',
    `tip_amount` DECIMAL(18,2) COMMENT 'Gratuity amount added by the guest to this payment tender. Tracked separately from the order total for labor distribution, tax reporting, and server tip-out calculations. Applicable in casual and fine-dining service models.',
    `token` STRING COMMENT 'A network-issued or processor-issued token that replaces the actual card PAN (Primary Account Number) for secure storage and recurring payment processing. Enables PCI DSS scope reduction through tokenization.',
    `updated_timestamp` TIMESTAMP COMMENT 'Audit timestamp recording when this payment record was last modified in the data platform, such as when a status transitions from authorized to settled or a refund is processed.',
    CONSTRAINT pk_payment PRIMARY KEY(`payment_id`)
) COMMENT 'Captures all payment tender records associated with a guest order, supporting split-tender scenarios. Includes tender type (cash, credit, debit, gift card, loyalty redemption, 3PD settlement), amount tendered, change due, authorization code, PCI-compliant masked card data, payment processor reference, and payment status. Authoritative SSOT for order-level payment capture; financial settlement lives in the finance domain.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`order`.`status_event` (
    `status_event_id` BIGINT COMMENT 'Unique surrogate identifier for each immutable order lifecycle state transition event record in the Silver layer. Primary key of this append-only event log.',
    `employee_id` BIGINT COMMENT 'Reference to the employee (FOH cashier, BOH cook, or manager) who manually triggered this state transition. Null when the transition was system- or device-initiated. Supports labor accountability and SOS coaching.',
    `guest_order_id` BIGINT COMMENT 'Reference to the parent guest order for which this status transition event was recorded. Links all lifecycle events back to the originating order.',
    `pos_terminal_id` BIGINT COMMENT 'Identifier of the Oracle MICROS POS terminal or kiosk that captured or processed this state transition event. Used for terminal-level performance diagnostics and audit trails.',
    `source_status_event_id` BIGINT COMMENT 'The native event or transaction identifier assigned by the originating source system (e.g., MICROS transaction ID, OLO event UUID, KDS bump ID). Enables exact-match deduplication and cross-system reconciliation during Silver layer ingestion.',
    `unit_id` BIGINT COMMENT 'Reference to the restaurant location where the order was placed and fulfilled. Used to segment Speed of Service (SOS) and ticket time analytics by location.',
    `business_date` DATE COMMENT 'The operational business date to which this event is attributed for financial and operational reporting purposes. May differ from event_date for late-night orders that cross midnight but belong to the prior business days P&L period.',
    `cumulative_elapsed_seconds` STRING COMMENT 'Total number of seconds elapsed from the initial received event to this event, representing the running ticket time for the order up to this point. Used to measure end-to-end Speed of Service (SOS) at any point in the lifecycle.',
    `current_state` STRING COMMENT 'The order lifecycle state that this event transitions the order INTO. Drives Speed of Service (SOS) analytics, KDS routing, and fulfillment tracking. [ENUM-REF-CANDIDATE: received|acknowledged|in_preparation|ready|dispatched|delivered|cancelled|voided — promote to reference product]',
    `data_quality_flag` BOOLEAN COMMENT 'Silver layer data quality classification for this event record. Values: valid (passed all checks), suspect (failed one or more quality rules), duplicate (identified as a duplicate of another event), late_arriving (received significantly after event_timestamp), corrected (overrides a prior suspect record).',
    `daypart` STRING COMMENT 'The operational daypart segment during which this event occurred (e.g., breakfast, lunch, dinner, late_night). Used to segment Speed of Service (SOS) and throughput analytics by time-of-day business period.. Valid values are `breakfast|lunch|afternoon|dinner|late_night|overnight`',
    `delivery_zone` STRING COMMENT 'Geographic delivery zone or radius tier assigned to this order for third-party delivery (3PD) or direct delivery fulfillment. Used for delivery time SOS benchmarking and zone-level fulfillment analytics.',
    `drive_thru_lane` STRING COMMENT 'Identifies the specific drive-thru (DT) lane associated with this order event for multi-lane drive-thru configurations. Null or none for non-drive-thru channels. Enables per-lane SOS and throughput analytics.. Valid values are `lane_1|lane_2|lane_3|express|none`',
    `elapsed_seconds_in_prior_state` STRING COMMENT 'Number of seconds the order spent in the prior_state before transitioning to the current_state. Computed at ingestion time from consecutive event timestamps. Core input for Speed of Service (SOS) and ticket time analytics.',
    `event_date` DATE COMMENT 'Calendar date (yyyy-MM-dd) on which this event occurred, derived from event_timestamp. Stored as a discrete DATE column to support efficient date-based partitioning, daily SOS reporting, and Same-Store Sales (SSS) period alignment.',
    `event_sequence` STRING COMMENT 'Monotonically increasing integer representing the ordinal position of this event within the full lifecycle of a single order. Enables reconstruction of the complete state machine path (e.g., 1=received, 2=acknowledged, 3=in_preparation).',
    `event_timestamp` TIMESTAMP COMMENT 'Precise date and time (ISO 8601 with timezone offset) at which the order transitioned into the current state. The principal real-world event time used for Speed of Service (SOS) and ticket time calculations.',
    `exception_reason_code` STRING COMMENT 'Structured code indicating why an exceptional transition occurred (e.g., ITEM_OUT_OF_STOCK, GUEST_CANCEL, PAYMENT_FAILED, EQUIPMENT_DOWN, DUPLICATE_ORDER). Null for normal lifecycle transitions. Drives exception reporting and root-cause analytics. [ENUM-REF-CANDIDATE: promote to reference product for full code list]',
    `exception_reason_description` STRING COMMENT 'Free-text narrative describing the exception or anomaly that caused this state transition, as entered by staff or returned by the triggering system. Supplements the structured exception_reason_code for operational context.',
    `fiscal_period` STRING COMMENT 'The fiscal reporting period (e.g., 2024-P04-W02) to which this event belongs, aligned to the companys internal fiscal calendar. Enables period-over-period SOS and throughput comparisons in financial reporting.',
    `fulfillment_mode` STRING COMMENT 'Indicates whether the order was placed for immediate fulfillment, scheduled for a future time (advance order), or ASAP (as-soon-as-possible with a requested window). Affects SOS target calculation and kitchen scheduling.. Valid values are `immediate|scheduled|asap`',
    `ingestion_timestamp` TIMESTAMP COMMENT 'The date and time this event record was first written into the Silver layer of the Databricks Lakehouse. Distinct from event_timestamp (real-world event time). Used for data latency monitoring, pipeline SLA tracking, and audit trail.',
    `is_cancellation_event` BOOLEAN COMMENT 'Flag indicating whether this event represents an order cancellation (current_state = cancelled). Enables rapid filtering for cancellation rate analytics, refund processing triggers, and guest recovery workflows.',
    `is_sos_breach` BOOLEAN COMMENT 'Flag indicating whether the cumulative elapsed time at this event exceeded the configured SOS target for the channel and daypart. True = SOS breach detected. Drives SOS compliance dashboards and operational alerts.',
    `is_terminal_state` BOOLEAN COMMENT 'Flag indicating whether the current_state is a terminal (end-of-lifecycle) state for the order (i.e., delivered, cancelled, or voided). Simplifies filtering for completed order analytics without requiring state enumeration logic.',
    `is_void_event` BOOLEAN COMMENT 'Flag indicating whether this event represents an order void (current_state = voided). Voids differ from cancellations in that they are typically manager-initiated post-tender corrections. Supports POS audit and loss prevention reporting.',
    `kds_station_code` BIGINT COMMENT 'Identifier of the KDS (Kitchen Display System) station that acknowledged or bumped this order event. Populated only when the triggering actor is KDS. Enables BOH (Back of House) station-level ticket time analysis.',
    `manager_override` BOOLEAN COMMENT 'Flag indicating whether this state transition required a manager authorization override (e.g., void, post-close cancellation, or exception state). Supports loss prevention, audit compliance, and operational accountability reporting.',
    `olo_order_reference` STRING COMMENT 'External order reference number assigned by the Olo Digital Ordering Platform for online and mobile orders. Populated only for OLO-originated events. Enables cross-system reconciliation between the lakehouse and the OLO platform.',
    `order_type` STRING COMMENT 'Classification of the order by business purpose. Values: standard (regular guest order), lto (Limited Time Offer promotional order), catering, group, loyalty_redemption, comp (complimentary). Enables type-specific SOS benchmarking and PMIX analysis.. Valid values are `standard|lto|catering|group|loyalty_redemption|comp`',
    `partition_date` DATE COMMENT 'The date value used as the physical partition key for this table in the Databricks Lakehouse Delta Lake storage layer. Typically aligned to business_date to optimize time-range query performance for SOS and throughput analytics.',
    `prior_state` STRING COMMENT 'The order lifecycle state immediately before this transition event. Null for the first event (initial placement). Enables detection of invalid state transitions and rollback analysis. [ENUM-REF-CANDIDATE: received|acknowledged|in_preparation|ready|dispatched|delivered|cancelled|voided — promote to reference product]',
    `promise_time_timestamp` TIMESTAMP COMMENT 'The date and time communicated to the guest as the expected ready or delivery time at the moment of order placement. Used to measure promise-time accuracy and guest satisfaction (CSAT) correlation.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The date and time this event record was last modified in the Silver layer (e.g., due to late-arriving corrections or enrichment). For a truly immutable event log this should rarely change; tracked for data quality auditing.',
    `scheduled_fulfillment_timestamp` TIMESTAMP COMMENT 'The date and time the guest requested or the system scheduled for order fulfillment. Populated only for scheduled/advance orders. Used to calculate on-time fulfillment rate and schedule adherence.',
    `service_channel` STRING COMMENT 'The order fulfillment channel through which the guest placed the order. Drives channel-specific SOS benchmarks and throughput analytics. Values: dine_in, drive_thru (DT), online (OLO), third_party_delivery (3PD), catering, kiosk, curbside. [ENUM-REF-CANDIDATE: dine_in|drive_thru|online|third_party_delivery|catering|kiosk|curbside — 7 candidates stripped; promote to reference product]',
    `sos_target_seconds` STRING COMMENT 'The configured Speed of Service (SOS) target in seconds for this service channel and daypart combination at the time of the event. Enables real-time and historical SOS compliance measurement against operational benchmarks.',
    `third_party_delivery_provider` STRING COMMENT 'Name of the third-party delivery (3PD) aggregator that submitted the webhook triggering this event (e.g., doordash, uber_eats, grubhub). Null or none for non-3PD channels. Enables 3PD-specific SOS and fulfillment analytics.. Valid values are `doordash|uber_eats|grubhub|instacart|other|none`',
    `third_party_event_reference` STRING COMMENT 'External event or webhook identifier provided by the third-party delivery (3PD) provider for this specific state transition. Used for cross-system reconciliation and dispute resolution with 3PD partners.',
    `triggering_actor` STRING COMMENT 'The system or human actor that initiated this state transition. Values include POS (Oracle MICROS Point of Sale), KDS (Kitchen Display System), OLO (Online Ordering platform), 3PD (Third-Party Delivery webhook), CATERING, STAFF (manual override), SYSTEM (automated rule), or GUEST (self-service cancellation). [ENUM-REF-CANDIDATE: POS|KDS|OLO|3PD|CATERING|STAFF|SYSTEM|GUEST — 8 candidates stripped; promote to reference product]',
    CONSTRAINT pk_status_event PRIMARY KEY(`status_event_id`)
) COMMENT 'Immutable event log tracking every lifecycle state transition of a guest order from placement through fulfillment or cancellation. States include: received, acknowledged, in_preparation, ready, dispatched, delivered, cancelled, voided. Captures the state, prior state, transition timestamp, triggering actor (POS, KDS, OLO, 3PD webhook), and any exception reason. Enables SOS (Speed of Service) and ticket time analytics.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`order`.`channel` (
    `channel_id` BIGINT COMMENT 'Unique identifier for the order channel. Primary key for the order_channel reference master.',
    `brand_id` BIGINT COMMENT 'add column brand_id (BIGINT) with FK to restaurant.brand.brand_id - order channels should be scoped to brands since different brands may support different channels',
    `activation_date` DATE COMMENT 'Date when this order channel was first activated and made available for order placement across the restaurant network.',
    `average_ticket_time_seconds` STRING COMMENT 'Benchmark average ticket time (order placement to fulfillment) in seconds for this channel, used for Speed of Service (SOS) performance tracking. Null if not applicable.',
    `channel_category` STRING COMMENT 'High-level classification of the channel by service model: dine_in (FOH counter, table service), takeout (DT, counter pickup), delivery (3PD, own delivery), catering (bulk orders), hybrid (multi-mode channels like kiosk).. Valid values are `dine_in|takeout|delivery|catering|hybrid`',
    `channel_type` STRING COMMENT 'Ownership classification of the channel: owned (company-operated channels like POS, DT, proprietary OLO), third_party (external platforms like 3PD aggregators), hybrid (co-branded or white-label solutions).. Valid values are `owned|third_party|hybrid`',
    `channel_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the order channel (e.g., POS, DT, OLO, 3PD, KIOSK, MOBILE, CATERING). Used as the business identifier for integration and reporting.. Valid values are `^[A-Z0-9_]{2,10}$`',
    `commission_rate_percent` DECIMAL(18,2) COMMENT 'Commission or transaction fee percentage charged by the channel provider (applicable to 3PD channels). Null for owned channels. Used for COGS and P&L analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this order channel record was first created in the system.',
    `deactivation_date` DATE COMMENT 'Date when this order channel was deactivated or retired. Null if the channel is still active.',
    `default_daypart` STRING COMMENT 'Default daypart (e.g., breakfast, lunch, dinner, late_night) typically associated with this channel. Null if the channel operates across all dayparts equally.',
    `channel_description` STRING COMMENT 'Detailed description of the order channel, including its purpose, typical use cases, and any special operational considerations.',
    `display_order` STRING COMMENT 'Numeric sort order for displaying this channel in reporting dashboards and user interfaces. Lower numbers appear first.',
    `fulfillment_mode` STRING COMMENT 'Primary method by which orders placed through this channel are fulfilled: dine_in (guest consumes on-premise), takeout (guest picks up), delivery (delivered to guest location), curbside (pickup at designated area), catering (scheduled bulk delivery).. Valid values are `dine_in|takeout|delivery|curbside|catering`',
    `integration_platform` STRING COMMENT 'Name of the technology platform or system that powers this channel (e.g., Oracle MICROS, Olo, DoorDash, Uber Eats, Grubhub, proprietary mobile app). Null for native POS channels.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether this channel is currently active and available for order placement. False indicates the channel has been retired or temporarily disabled.',
    `is_digital` BOOLEAN COMMENT 'Boolean flag indicating whether this is a digital channel (true for OLO, mobile app, kiosk, 3PD; false for traditional POS, DT counter service).',
    `kds_routing_enabled` BOOLEAN COMMENT 'Boolean flag indicating whether orders from this channel are routed to the Kitchen Display System (KDS) for BOH preparation tracking. True for most channels; may be false for catering orders prepared off-site.',
    `channel_name` STRING COMMENT 'Full descriptive name of the order channel (e.g., Point of Sale, Drive-Thru, Online Ordering, Third-Party Delivery, Kiosk, Mobile App, Catering).',
    `requires_restaurant_assignment` BOOLEAN COMMENT 'Boolean flag indicating whether orders from this channel must be assigned to a specific restaurant location at order time (true for delivery, catering; false for walk-in POS).',
    `supports_guest_data_capture` BOOLEAN COMMENT 'Boolean flag indicating whether this channel captures guest identification and contact information (true for OLO, mobile, 3PD; false for anonymous POS transactions).',
    `supports_loyalty_integration` BOOLEAN COMMENT 'Boolean flag indicating whether this channel supports integration with the customer loyalty program for points accrual and redemption.',
    `supports_payment_at_order` BOOLEAN COMMENT 'Boolean flag indicating whether payment is collected at the time of order placement (true for OLO, 3PD, mobile; false for traditional counter service where payment occurs at pickup).',
    `supports_scheduled_orders` BOOLEAN COMMENT 'Boolean flag indicating whether this channel allows customers to schedule orders for future fulfillment (true for catering, some OLO platforms; false for immediate-service channels like DT).',
    `target_sos_seconds` STRING COMMENT 'Target Speed of Service (SOS) threshold in seconds for this channel, representing the operational goal for order fulfillment time. Used for performance benchmarking and SOP compliance.',
    `third_party_provider` STRING COMMENT 'Name of the third-party delivery service provider if this channel is a 3PD channel (e.g., DoorDash, Uber Eats, Grubhub, Postmates). Null for non-3PD channels.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this order channel record was last modified.',
    CONSTRAINT pk_channel PRIMARY KEY(`channel_id`)
) COMMENT 'Reference master defining all service channels through which guest orders are placed: POS (dine-in, counter), drive-thru (DT), online ordering (OLO), third-party delivery (3PD — DoorDash, Uber Eats, Grubhub), catering, kiosk, and mobile app. Captures channel code, channel category, integration platform, fulfillment mode (dine-in, takeout, delivery, curbside), and active status. Serves as the FK target for guest_order channel attribution, channel-mix reporting, and ACV benchmarking.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`order`.`daypart` (
    `daypart_id` BIGINT COMMENT 'Unique identifier for the order_daypart data product (auto-inserted pre-linking).',
    `guest_order_id` BIGINT COMMENT 'Foreign key linking to order.guest_order. Business justification: order_daypart represents the assignment of a daypart to an order; the child table should hold the FK to the parent order.',
    `unit_id` BIGINT COMMENT 'add column restaurant_unit_id (BIGINT) with FK to restaurant.unit.unit_id - daypart references a guest_order but should also link to the unit for scheduling context',
    CONSTRAINT pk_daypart PRIMARY KEY(`daypart_id`)
) COMMENT 'Reference entity defining the standard trading periods used to segment restaurant operations and sales: breakfast, morning snack, lunch, afternoon, dinner, late night. Captures daypart name, start time, end time, daypart category, and whether it is a primary or secondary daypart. Foundational dimension for PMIX analysis, labor scheduling, and ATC/ACV benchmarking by time-of-day.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`order`.`kds_ticket` (
    `kds_ticket_id` BIGINT COMMENT 'Unique identifier for the KDS ticket. Primary key for the kds_ticket product.',
    `employee_id` BIGINT COMMENT 'Reference to the BOH employee who was assigned to or completed this ticket. Used for individual performance tracking and labor productivity analysis.',
    `guest_order_id` BIGINT COMMENT 'Reference to the parent guest order that generated this KDS ticket. Links the ticket to the originating transaction captured at the POS.',
    `kitchen_station_id` BIGINT COMMENT 'Reference to the specific BOH kitchen station (grill, fryer, assembly, expo, beverage) to which this ticket was routed. Critical for station-level performance tracking.',
    `shift_id` BIGINT COMMENT 'Reference to the workforce shift during which this ticket was processed. Enables shift-level throughput and labor efficiency analysis.',
    `unit_id` BIGINT COMMENT 'Reference to the restaurant location where this KDS ticket was generated. Enables location-level throughput and SOS analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'Audit timestamp indicating when this record was first inserted into the data platform. Used for data lineage and ETL tracking.',
    `daypart` STRING COMMENT 'Time-of-day segment when the ticket was created. Used for daypart-specific throughput analysis and labor planning. Common values: breakfast, lunch, dinner, late_night, snack.. Valid values are `breakfast|lunch|dinner|late_night|snack`',
    `item_count` STRING COMMENT 'Total number of menu items included on this KDS ticket. Used to analyze ticket complexity and its impact on preparation time.',
    `modifier_count` STRING COMMENT 'Total number of modifiers (customizations, substitutions, add-ons) applied to items on this ticket. Higher modifier counts typically increase ticket time.',
    `order_channel` STRING COMMENT 'Service channel through which the originating order was placed. Values include dine_in (FOH table service), drive_thru (DT), online (OLO direct), third_party_delivery (3PD platforms), catering, kiosk.. Valid values are `dine_in|drive_thru|online|third_party_delivery|catering|kiosk`',
    `priority_level` STRING COMMENT 'Priority classification assigned to the ticket. Rush and VIP orders receive expedited handling. Catering orders may have extended preparation windows.. Valid values are `standard|rush|vip|catering`',
    `re_fire_count` STRING COMMENT 'Number of times this ticket was re-fired. Multiple re-fires indicate recurring quality or accuracy issues. Zero indicates no remakes were required.',
    `re_fire_flag` BOOLEAN COMMENT 'Boolean indicator of whether this ticket was re-fired (sent back to the kitchen for remake) due to quality issues, order errors, or customer complaints. True indicates a remake event occurred.',
    `re_fire_reason` STRING COMMENT 'Free-text description of why the ticket was re-fired. Common reasons include incorrect preparation, quality defect, missing items, customer request, order entry error.',
    `sos_met_flag` BOOLEAN COMMENT 'Boolean indicator of whether the ticket was completed within the SOS target time. True if ticket_time_seconds <= sos_target_seconds, False otherwise. Critical for operational compliance reporting.',
    `sos_target_seconds` STRING COMMENT 'Target ticket time in seconds defined by restaurant operations standards for this station and order channel. Used to determine SOS compliance.',
    `special_instructions` STRING COMMENT 'Free-text field containing customer special requests, preparation notes, or allergy warnings that BOH staff must follow when preparing this ticket.',
    `ticket_bumped_timestamp` TIMESTAMP COMMENT 'Date and time when the ticket was bumped (cleared) from the KDS screen by BOH staff, indicating the order was sent to the customer or next station.',
    `ticket_completed_timestamp` TIMESTAMP COMMENT 'Date and time when all items on the ticket were finished and ready for service or pickup. Used to calculate total ticket time.',
    `ticket_created_timestamp` TIMESTAMP COMMENT 'Exact date and time when the KDS ticket was generated and routed to the station. Start point for ticket time calculation and SOS measurement.',
    `ticket_number` STRING COMMENT 'Human-readable ticket number displayed on the KDS screen and printed on kitchen receipts. Used by BOH staff to identify and track production items.. Valid values are `^[A-Z0-9]{6,12}$`',
    `ticket_sequence_number` STRING COMMENT 'Sequential order number of this ticket within the parent order. Multi-station orders generate multiple tickets; this field tracks the sequence.',
    `ticket_started_timestamp` TIMESTAMP COMMENT 'Date and time when BOH staff began actively preparing the items on this ticket. Marks transition from new to in_progress status.',
    `ticket_status` STRING COMMENT 'Current lifecycle status of the KDS ticket. Tracks progression from new (just routed) through in_progress (being prepared), completed (finished), bumped (cleared from screen), voided (cancelled), or re_fired (sent back for remake).. Valid values are `new|in_progress|completed|bumped|voided|re_fired`',
    `ticket_time_seconds` STRING COMMENT 'Total elapsed time in seconds from ticket creation to ticket completion. Core KPI for kitchen throughput and speed of service (SOS) performance measurement.',
    `updated_timestamp` TIMESTAMP COMMENT 'Audit timestamp indicating when this record was last modified in the data platform. Used for change tracking and data freshness monitoring.',
    `void_flag` BOOLEAN COMMENT 'Boolean indicator of whether this ticket was voided (cancelled) before completion. True indicates the ticket was cancelled and items were not prepared.',
    `void_reason` STRING COMMENT 'Free-text description of why the ticket was voided. Common reasons include customer cancellation, order entry error, system error, duplicate ticket.',
    CONSTRAINT pk_kds_ticket PRIMARY KEY(`kds_ticket_id`)
) COMMENT 'Represents a kitchen display system (KDS) production ticket generated from a guest order, routed to a specific BOH station (grill, fryer, assembly, expo). Captures ticket creation time, station assignment, bump time, re-fire events, ticket time (seconds), SOS target compliance flag, and fulfillment handoff timestamp. Core operational record for kitchen throughput, ticket time compliance, BOH performance management, and FOH handoff coordination.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`order`.`drive_thru_event` (
    `drive_thru_event_id` BIGINT COMMENT 'Unique identifier for each drive-thru event record. Primary key for the drive_thru_event product.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who served the customer at the time of the event (e.g., order taker, cashier, or expediter).',
    `guest_order_id` BIGINT COMMENT 'Identifier of the order associated with this drive-thru event, linking to the order captured in Oracle MICROS POS.',
    `pos_terminal_id` BIGINT COMMENT 'Identifier of the Oracle MICROS POS terminal that processed the order associated with this drive-thru event.',
    `site_id` BIGINT COMMENT 'Identifier of the restaurant location where the drive-thru event occurred.',
    `unit_id` BIGINT COMMENT 'Identifier of the restaurant location where the drive-thru event occurred.',
    `business_date` DATE COMMENT 'The operational business date for the drive-thru event, which may differ from the calendar date for late-night operations (e.g., 2 AM transaction may belong to the previous business day).',
    `cumulative_time_seconds` DECIMAL(18,2) COMMENT 'Total time in seconds from the vehicles initial menu board arrival to the current event. Represents the running total ticket time for the vehicle.',
    `daypart` STRING COMMENT 'Time-of-day segment when the drive-thru event occurred: breakfast, lunch, afternoon, dinner, or late_night. Used for daypart-specific Speed of Service (SOS) benchmarking and throughput analysis.. Valid values are `breakfast|lunch|afternoon|dinner|late_night`',
    `elapsed_time_seconds` DECIMAL(18,2) COMMENT 'Time elapsed in seconds from the previous event in the drive-thru sequence for this vehicle. Used to calculate stage-specific Speed of Service (SOS) metrics such as menu board time, window time, and total ticket time.',
    `event_timestamp` TIMESTAMP COMMENT 'Precise date and time when the drive-thru event occurred, captured by drive-thru timer sensors integrated with Oracle MICROS POS. Used for Speed of Service (SOS) calculation.',
    `event_type` STRING COMMENT 'Type of drive-thru event being recorded: menu_board_arrival (vehicle arrives at menu board), order_placed (order confirmed), pull_forward (vehicle directed to wait), window_arrival (vehicle reaches service window), payment_complete (payment transaction finalized), food_handoff (order delivered to customer), departure (vehicle exits drive-thru lane). [ENUM-REF-CANDIDATE: menu_board_arrival|order_placed|pull_forward|window_arrival|payment_complete|food_handoff|departure — 7 candidates stripped; promote to reference product]',
    `exception_flag` BOOLEAN COMMENT 'Indicates whether this drive-thru event represents an exception or anomaly (e.g., sensor malfunction, manual override, system error). True if exception occurred, False for normal operation.',
    `exception_reason` STRING COMMENT 'Description of the reason for the exception if exception_flag is True (e.g., sensor malfunction, customer service recovery, order modification, system timeout).',
    `franchise_flag` BOOLEAN COMMENT 'Indicates whether the restaurant location is franchise-owned (True) or company-owned (False). Used for comparative Speed of Service (SOS) analysis between franchise and company-owned locations.',
    `kds_ticket_number` STRING COMMENT 'Ticket number assigned by the Kitchen Display System (KDS) for the order associated with this drive-thru event, used to correlate drive-thru timing with kitchen preparation timing.',
    `lane_number` STRING COMMENT 'Identifier for the specific drive-thru lane where the event occurred (e.g., 1 for single-lane, 1 or 2 for dual-lane configurations).',
    `order_channel` STRING COMMENT 'Channel through which the order was originally placed: drive_thru (ordered at menu board), mobile_order_ahead (pre-ordered via mobile app for drive-thru pickup), or third_party_delivery (3PD order picked up via drive-thru).. Valid values are `drive_thru|mobile_order_ahead|third_party_delivery`',
    `order_item_count` STRING COMMENT 'Number of individual items in the order associated with this drive-thru event. Used to analyze the relationship between order complexity and Speed of Service (SOS).',
    `order_total_amount` DECIMAL(18,2) COMMENT 'Total monetary value of the order associated with this drive-thru event, used for Average Check Value (ACV) calculation and revenue analysis by Speed of Service (SOS) performance.',
    `payment_method` STRING COMMENT 'Method of payment used for the order associated with this drive-thru event: cash, credit_card, debit_card, mobile_payment, or gift_card. Used to analyze the impact of payment method on Speed of Service (SOS).. Valid values are `cash|credit_card|debit_card|mobile_payment|gift_card`',
    `pull_forward_flag` BOOLEAN COMMENT 'Indicates whether the vehicle was asked to pull forward to a waiting area during this drive-thru sequence. True if pull-forward occurred, False otherwise. Pull-forwards impact Speed of Service (SOS) metrics and throughput.',
    `queue_length` STRING COMMENT 'Number of vehicles in the drive-thru lane at the time of this event, used to analyze the relationship between queue depth and Speed of Service (SOS) performance.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this drive-thru event record was first created in the system. Used for data lineage and audit trail purposes.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this drive-thru event record was last updated in the system. Used for data lineage and audit trail purposes.',
    `sensor_code` STRING COMMENT 'Unique identifier of the physical sensor or timer device that captured this event (e.g., menu board sensor, window sensor, exit sensor).',
    `sos_target_seconds` DECIMAL(18,2) COMMENT 'Brand-defined target time in seconds for this specific drive-thru event type or stage (e.g., 25 seconds for menu board to order placed, 180 seconds for total ticket time). Used for performance benchmarking.',
    `sos_variance_seconds` DECIMAL(18,2) COMMENT 'Difference in seconds between the actual elapsed time and the SOS target for this event. Positive values indicate slower-than-target service; negative values indicate faster-than-target service.',
    `vehicle_sequence_number` BIGINT COMMENT 'Sequential number assigned to each vehicle entering the drive-thru lane during the business day, used for tracking vehicle progression and throughput analysis.',
    `weather_condition` STRING COMMENT 'Weather condition at the time of the drive-thru event, captured to analyze the impact of weather on Speed of Service (SOS) and throughput. Values include clear, rain, snow, fog, wind, extreme_heat, extreme_cold. [ENUM-REF-CANDIDATE: clear|rain|snow|fog|wind|extreme_heat|extreme_cold — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_drive_thru_event PRIMARY KEY(`drive_thru_event_id`)
) COMMENT 'Captures timestamped sensor and timer events for each vehicle progressing through the drive-thru (DT) lane: arrival at menu board, order placed, pull-forward, window arrival, payment complete, food handoff, departure. Enables Speed of Service (SOS) measurement at each DT stage, throughput analysis, and benchmarking against brand SOS targets. Sourced from DT timer systems integrated with Oracle MICROS POS.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`order`.`delivery_order` (
    `delivery_order_id` BIGINT COMMENT 'Unique identifier for the delivery order record. Primary key.',
    `delivery_platform_id` BIGINT COMMENT 'Reference to the third-party delivery (3PD) platform or first-party delivery service provider (DoorDash, Uber Eats, Grubhub, proprietary fleet).',
    `employee_id` BIGINT COMMENT 'Reference to the courier or driver assigned to deliver the order. May be null if not yet assigned.',
    `guest_order_id` BIGINT COMMENT 'Reference to the parent order being fulfilled via delivery. Links to the core order transaction.',
    `site_id` BIGINT COMMENT 'Reference to the restaurant location fulfilling the delivery order.',
    `unit_id` BIGINT COMMENT 'Reference to the restaurant location fulfilling the delivery order.',
    `actual_delivery_time_minutes` STRING COMMENT 'Actual time in minutes taken by the courier to deliver the order from pickup to guest, calculated from picked up timestamp to actual delivery timestamp.',
    `actual_delivery_timestamp` TIMESTAMP COMMENT 'Actual date and time when the order was delivered to the guest, as confirmed by the courier or delivery platform.',
    `actual_prep_time_minutes` STRING COMMENT 'Actual time in minutes taken by the restaurant to prepare the order, calculated from order confirmation to ready for pickup.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this delivery order record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for all monetary amounts in this delivery order (e.g., USD, CAD, MXN).. Valid values are `^[A-Z]{3}$`',
    `customer_feedback` STRING COMMENT 'Free-text feedback provided by the guest about the delivery experience. Used for quality improvement and service recovery.',
    `customer_rating` STRING COMMENT 'Guest rating for the delivery experience on a scale of 1 to 5. Used for Net Promoter Score (NPS) and Customer Satisfaction (CSAT) tracking.',
    `delivery_address_line1` STRING COMMENT 'Primary street address line for the delivery destination. Contains personally identifiable information (PII).',
    `delivery_address_line2` STRING COMMENT 'Secondary address line for apartment, suite, or unit number. Contains personally identifiable information (PII).',
    `delivery_city` STRING COMMENT 'City name for the delivery destination. Contains personally identifiable information (PII).',
    `delivery_country_code` STRING COMMENT 'Three-letter ISO country code for the delivery destination (e.g., USA, CAN, MEX).. Valid values are `^[A-Z]{3}$`',
    `delivery_distance_km` DECIMAL(18,2) COMMENT 'Calculated distance in kilometers from the restaurant to the delivery destination. Used for delivery fee calculation and logistics analysis.',
    `delivery_exception_type` STRING COMMENT 'Type of exception or issue encountered during delivery fulfillment. Used for quality tracking and Customer Satisfaction (CSAT) analysis. [ENUM-REF-CANDIDATE: none|late_delivery|missing_items|wrong_address|customer_unavailable|order_damaged|cancelled_by_customer|cancelled_by_restaurant — 8 candidates stripped; promote to reference product]',
    `delivery_fee_amount` DECIMAL(18,2) COMMENT 'Delivery fee charged to the guest for the delivery service. Excludes taxes and tips.',
    `delivery_instructions` STRING COMMENT 'Special instructions provided by the guest for delivery (e.g., gate code, building entrance, leave at door). May contain personally identifiable information (PII).',
    `delivery_latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the delivery destination. Used for routing optimization and distance calculation. Contains location PII.',
    `delivery_longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the delivery destination. Used for routing optimization and distance calculation. Contains location PII.',
    `delivery_postal_code` STRING COMMENT 'Postal or ZIP code for the delivery destination. Contains personally identifiable information (PII).',
    `delivery_state_province` STRING COMMENT 'State or province code for the delivery destination. Contains personally identifiable information (PII).',
    `delivery_status` STRING COMMENT 'Current lifecycle status of the delivery order. Tracks progression from order placement through final delivery or cancellation. [ENUM-REF-CANDIDATE: pending|confirmed|preparing|ready_for_pickup|picked_up|in_transit|delivered|cancelled|failed — 9 candidates stripped; promote to reference product]',
    `estimated_delivery_time_minutes` STRING COMMENT 'Estimated time in minutes for the courier to deliver the order from pickup to guest, as provided by the delivery platform routing algorithm.',
    `estimated_delivery_timestamp` TIMESTAMP COMMENT 'Estimated date and time for delivery to the guest, as communicated by the delivery platform or internal routing system.',
    `estimated_prep_time_minutes` STRING COMMENT 'Estimated time in minutes for the restaurant to prepare the order, as communicated to the delivery platform.',
    `exception_notes` STRING COMMENT 'Free-text notes describing the delivery exception or issue. Captured by courier, restaurant staff, or customer service.',
    `is_contactless_delivery` BOOLEAN COMMENT 'Indicates whether the delivery was requested as contactless (leave at door). True if contactless, False otherwise.',
    `order_confirmed_timestamp` TIMESTAMP COMMENT 'Date and time when the restaurant confirmed acceptance of the delivery order.',
    `order_placed_timestamp` TIMESTAMP COMMENT 'Date and time when the delivery order was placed by the guest via the online ordering (OLO) or third-party delivery (3PD) platform.',
    `picked_up_timestamp` TIMESTAMP COMMENT 'Date and time when the courier picked up the order from the restaurant location.',
    `platform_commission_amount` DECIMAL(18,2) COMMENT 'Total commission amount paid to the third-party delivery platform for this order. Business-confidential financial information.',
    `platform_commission_rate` DECIMAL(18,2) COMMENT 'Commission rate (as a decimal) charged by the third-party delivery platform on the order subtotal. Business-confidential pricing information.',
    `platform_order_reference` STRING COMMENT 'External order identifier provided by the third-party delivery platform. Used for reconciliation and support inquiries with 3PD providers.',
    `proof_of_delivery_url` STRING COMMENT 'URL to the proof of delivery image or document (e.g., photo of order at doorstep). Used for dispute resolution.',
    `ready_for_pickup_timestamp` TIMESTAMP COMMENT 'Date and time when the order was marked as ready for courier pickup in the Kitchen Display System (KDS) or Point of Sale (POS).',
    `tip_amount` DECIMAL(18,2) COMMENT 'Tip amount provided by the guest to the courier. May be pre-tip or post-delivery adjustment.',
    `total_ticket_time_minutes` STRING COMMENT 'Total elapsed time in minutes from order placement to actual delivery. Key Speed of Service (SOS) metric for delivery orders.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this delivery order record was last modified.',
    CONSTRAINT pk_delivery_order PRIMARY KEY(`delivery_order_id`)
) COMMENT 'Manages the delivery fulfillment record for orders dispatched via third-party delivery (3PD) platforms (DoorDash, Uber Eats, Grubhub) or first-party delivery. Captures 3PD platform reference ID, courier assignment, estimated and actual delivery times, delivery distance, delivery fee, platform commission rate, delivery status, and any delivery exception (late, missing item, cancelled). Bridges the Olo digital ordering platform data with internal order records.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`order`.`catering_order` (
    `catering_order_id` BIGINT COMMENT 'Unique identifier for the catering order. Primary key.',
    `profile_id` BIGINT COMMENT 'Identifier of the guest or corporate account placing the catering order.',
    `catering_package_id` BIGINT COMMENT 'Identifier of the pre-defined catering package selected by the guest, if applicable.',
    `catering_profile_id` BIGINT COMMENT 'Identifier of the guest or corporate account placing the catering order.',
    `corporate_account_id` BIGINT COMMENT 'Identifier of the corporate billing account if the catering order is billed to a corporate customer.',
    `guest_order_id` BIGINT COMMENT 'add column guest_order_id (BIGINT) with FK to order.guest_order.guest_order_id - catering orders should link to the core order entity for unified order tracking and financial reconciliation',
    `employee_id` BIGINT COMMENT 'Identifier of the sales representative or catering coordinator who managed this order.',
    `unit_id` BIGINT COMMENT 'Identifier of the restaurant location fulfilling this catering order.',
    `balance_due` DECIMAL(18,2) COMMENT 'Remaining balance due after deposit, to be paid before or at event delivery.',
    `cancellation_reason` STRING COMMENT 'Reason provided for catering order cancellation, if applicable.',
    `cancelled_at` TIMESTAMP COMMENT 'Timestamp when the catering order was cancelled, if applicable.',
    `catering_order_number` STRING COMMENT 'Externally-visible unique business identifier for the catering order, used for guest communication and tracking.. Valid values are `^CAT-[0-9]{8,12}$`',
    `confirmed_at` TIMESTAMP COMMENT 'Timestamp when the catering order was confirmed by restaurant staff or system.',
    `contact_email` STRING COMMENT 'Email address of the primary contact person for order confirmation and updates.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_name` STRING COMMENT 'Name of the primary contact person for the catering event.',
    `contact_phone` STRING COMMENT 'Phone number of the primary contact person for day-of-event coordination.',
    `created_at` TIMESTAMP COMMENT 'Timestamp when this catering order record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for all monetary amounts in this catering order.. Valid values are `^[A-Z]{3}$`',
    `delivery_address_line1` STRING COMMENT 'Primary street address line for catering delivery location.',
    `delivery_address_line2` STRING COMMENT 'Secondary address line (suite, floor, building) for catering delivery location.',
    `delivery_city` STRING COMMENT 'City for catering delivery location.',
    `delivery_country_code` STRING COMMENT 'Three-letter ISO country code for catering delivery location.. Valid values are `^[A-Z]{3}$`',
    `delivery_postal_code` STRING COMMENT 'Postal or ZIP code for catering delivery location.',
    `delivery_state_province` STRING COMMENT 'State or province code for catering delivery location.',
    `deposit_amount` DECIMAL(18,2) COMMENT 'Deposit amount paid at time of order confirmation to secure the catering reservation.',
    `dietary_accommodations` STRING COMMENT 'Special dietary requirements or accommodations requested for the catering event (e.g., vegetarian, gluten-free, allergen restrictions).',
    `event_date` DATE COMMENT 'Date on which the catering event is scheduled to occur.',
    `event_start_time` TIMESTAMP COMMENT 'Scheduled start time for the catering event, used for delivery or pickup timing.',
    `fulfilled_at` TIMESTAMP COMMENT 'Timestamp when the catering order was delivered or picked up and marked as fulfilled.',
    `fulfillment_mode` STRING COMMENT 'Method by which the catering order will be fulfilled: delivery to event location, guest pickup, or on-site service with staff.. Valid values are `delivery|pickup|on_site_service`',
    `gratuity_amount` DECIMAL(18,2) COMMENT 'Gratuity or service charge amount included in the catering order total.',
    `headcount` STRING COMMENT 'Expected number of guests to be served at the catering event.',
    `lead_time_days` STRING COMMENT 'Number of days in advance the catering order was placed before the event date.',
    `order_channel` STRING COMMENT 'Channel through which the catering order was placed.. Valid values are `phone|web|mobile_app|in_store|sales_rep`',
    `order_status` STRING COMMENT 'Current lifecycle status of the catering order in the fulfillment workflow. [ENUM-REF-CANDIDATE: draft|confirmed|in_preparation|ready|delivered|completed|cancelled — 7 candidates stripped; promote to reference product]',
    `payment_method` STRING COMMENT 'Payment instrument used for the catering order transaction.. Valid values are `credit_card|debit_card|corporate_account|invoice|cash|check`',
    `payment_status` STRING COMMENT 'Current payment status of the catering order.. Valid values are `pending|deposit_paid|paid_in_full|refunded|cancelled`',
    `placed_at` TIMESTAMP COMMENT 'Timestamp when the catering order was initially placed by the guest.',
    `quoted_price` DECIMAL(18,2) COMMENT 'Total price quoted to the guest for the catering order, including all items and services.',
    `setup_instructions` STRING COMMENT 'Detailed instructions for on-site setup, including table arrangement, buffet layout, and service requirements.',
    `setup_required` BOOLEAN COMMENT 'Indicates whether on-site setup service is required for the catering order.',
    `special_instructions` STRING COMMENT 'Additional guest instructions or notes for order preparation and fulfillment.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount applied to the catering order based on delivery location and applicable tax rates.',
    `total_amount` DECIMAL(18,2) COMMENT 'Final total amount for the catering order including all items, services, tax, and gratuity.',
    `updated_at` TIMESTAMP COMMENT 'Timestamp when this catering order record was last modified.',
    CONSTRAINT pk_catering_order PRIMARY KEY(`catering_order_id`)
) COMMENT 'Manages large-format catering orders placed by corporate, event, or group guests. Captures catering event date, headcount, delivery or pickup mode, setup requirements, special dietary accommodations, catering package selected, quoted price, deposit amount, balance due, and fulfillment status. Distinct from standard guest orders due to advance booking lead time, custom BOM requirements, and dedicated fulfillment workflow.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`order`.`discount` (
    `discount_id` BIGINT COMMENT 'Unique identifier for the order discount record. Primary key.',
    `employee_id` BIGINT COMMENT 'Reference to the employee who authorized or applied the discount, particularly for manager comps and exception-based discounts.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Tracks discount expense against a designated GL account, supporting discount expense reporting.',
    `guest_order_id` BIGINT COMMENT 'Reference to the parent guest order to which this discount was applied.',
    `menu_item_id` BIGINT COMMENT 'Reference to the specific menu item to which this discount was applied. Null if discount applies to entire order.',
    `pos_terminal_id` BIGINT COMMENT 'Identifier of the POS terminal or workstation where the discount was applied.',
    `profile_id` BIGINT COMMENT 'Foreign key linking to guest.profile. Business justification: Needed for discount usage analytics per guest, supporting marketing ROI analysis and compliance with promotional eligibility rules.',
    `promotion_id` BIGINT COMMENT 'Reference to the marketing promotion or Limited Time Offer (LTO) campaign that generated this discount.',
    `site_id` BIGINT COMMENT 'Reference to the restaurant location where this discount was applied.',
    `unit_id` BIGINT COMMENT 'Reference to the restaurant location where this discount was applied.',
    `amount` DECIMAL(18,2) COMMENT 'Absolute monetary value of the discount applied, in the transaction currency. Used for Cost of Goods Sold (COGS) impact analysis.',
    `applied_at` TIMESTAMP COMMENT 'The date and time when the discount was applied to the order or item at the Point of Sale (POS).',
    `authorization_required` BOOLEAN COMMENT 'Indicates whether manager or supervisor authorization was required to apply this discount.',
    `channel_restriction` STRING COMMENT 'Specifies the order channel(s) for which this discount is valid (e.g., dine_in, drive_thru, online_ordering, third_party_delivery). Null if no restriction.',
    `discount_code` STRING COMMENT 'The coupon code, promo code, or loyalty redemption code entered or scanned at the Point of Sale (POS).',
    `cogs_impact_amount` DECIMAL(18,2) COMMENT 'The calculated impact of this discount on Cost of Goods Sold (COGS) for financial and profitability analysis.',
    `created_at` TIMESTAMP COMMENT 'The date and time when this discount record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the discount amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `daypart_restriction` STRING COMMENT 'Specifies the daypart(s) during which this discount is valid (e.g., breakfast, lunch, dinner, late_night). Null if no restriction.',
    `discount_type` STRING COMMENT 'Classification of the discount mechanism applied to the order or item.. Valid values are `coupon|loyalty_redemption|employee_meal|manager_comp|promotional_lto|bundle_deal`',
    `final_price` DECIMAL(18,2) COMMENT 'The final price after the discount was applied to the item or order.',
    `is_pre_approved` BOOLEAN COMMENT 'Indicates whether the discount was pre-approved through a promotional campaign (true) or applied as an exception at the Point of Sale (false).',
    `is_stackable` BOOLEAN COMMENT 'Indicates whether this discount can be combined with other discounts on the same order or item.',
    `is_voided` BOOLEAN COMMENT 'Indicates whether this discount was voided or removed from the order after initial application.',
    `loyalty_points_redeemed` STRING COMMENT 'Number of loyalty program points redeemed to obtain this discount. Null if discount is not loyalty-based.',
    `max_discount_amount` DECIMAL(18,2) COMMENT 'The maximum allowable discount amount for this promotion or discount type, as configured in the promotion rules.',
    `min_purchase_amount` DECIMAL(18,2) COMMENT 'The minimum order subtotal required to qualify for this discount.',
    `discount_name` STRING COMMENT 'Human-readable name or description of the discount as displayed on the receipt and Kitchen Display System (KDS).',
    `original_price` DECIMAL(18,2) COMMENT 'The original price of the item or order subtotal before the discount was applied.',
    `percentage` DECIMAL(18,2) COMMENT 'Percentage discount applied to the item or order subtotal. Null if discount is a fixed amount.',
    `reason` STRING COMMENT 'Free-text explanation or reason code for the discount, particularly for manager comps and exception-based adjustments.',
    `revenue_impact_amount` DECIMAL(18,2) COMMENT 'The calculated impact of this discount on gross revenue for Profit and Loss (P&L) reporting and Same-Store Sales (SSS) analysis.',
    `scope` STRING COMMENT 'Defines the scope at which the discount is applied: entire order, individual item, menu category, or combo meal.. Valid values are `order_level|item_level|category_level|combo_level`',
    `tax_treatment` STRING COMMENT 'Indicates whether the discount is applied before tax calculation, after tax calculation, or results in a tax-exempt transaction.. Valid values are `pre_tax|post_tax|tax_exempt`',
    `updated_at` TIMESTAMP COMMENT 'The date and time when this discount record was last modified in the system.',
    `valid_from_date` DATE COMMENT 'The start date from which this discount or promotion is valid and can be applied.',
    `valid_to_date` DATE COMMENT 'The end date after which this discount or promotion is no longer valid.',
    `void_reason` STRING COMMENT 'Explanation or reason code for why the discount was voided. Null if discount was not voided.',
    `voided_at` TIMESTAMP COMMENT 'The date and time when the discount was voided or removed from the order. Null if discount was not voided.',
    CONSTRAINT pk_discount PRIMARY KEY(`discount_id`)
) COMMENT 'Records all discounts, promotions, coupons, and comp adjustments applied to a guest order or individual order items. Captures discount type (coupon, loyalty redemption, employee meal, manager comp, promotional LTO, bundle/combo deal), discount amount or percentage, promotion reference, authorization employee, and pre-approved vs. exception-based flag. Supports COGS% impact analysis, promotional ROI tracking, and combo savings attribution.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`order`.`refund` (
    `refund_id` BIGINT COMMENT 'Unique identifier for the refund transaction. Primary key for the order_refund product.',
    `employee_id` BIGINT COMMENT 'Identifier of the manager or supervisor who approved and authorized the refund transaction.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Posts refund amounts to a specific GL account to reflect refund expense in financials.',
    `guest_order_id` BIGINT COMMENT 'Reference to the original guest order against which this refund was issued. Links to the parent order transaction.',
    `pos_terminal_id` BIGINT COMMENT 'Identifier of the Point of Sale (POS) terminal or workstation where the refund was processed.',
    `primary_refund_employee_id` BIGINT COMMENT 'Identifier of the manager or supervisor who approved and authorized the refund transaction.',
    `profile_id` BIGINT COMMENT 'Identifier of the guest who received the refund, if known and captured in the Customer Relationship Management (CRM) system.',
    `refund_profile_id` BIGINT COMMENT 'Identifier of the guest who received the refund, if known and captured in the Customer Relationship Management (CRM) system.',
    `site_id` BIGINT COMMENT 'Identifier of the restaurant location where the refund was processed.',
    `tertiary_refund_voided_by_employee_id` BIGINT COMMENT 'Identifier of the employee who voided or reversed the refund transaction.',
    `unit_id` BIGINT COMMENT 'Identifier of the restaurant location where the refund was processed.',
    `amount` DECIMAL(18,2) COMMENT 'Total monetary value refunded to the guest, including tax adjustments.',
    `approved_at` TIMESTAMP COMMENT 'Date and time when the refund was approved by the authorizing manager.',
    `batch_code` STRING COMMENT 'Identifier for the financial batch in which this refund was grouped for accounting reconciliation and settlement.',
    `channel` STRING COMMENT 'Channel through which the refund was initiated and processed, indicating the customer touchpoint.. Valid values are `pos|online|mobile_app|call_center|third_party_delivery`',
    `created_at` TIMESTAMP COMMENT 'Timestamp when the refund record was first created in the system.',
    `csat_impact_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this refund is associated with a Customer Satisfaction (CSAT) incident requiring follow-up or root-cause analysis.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code indicating the currency in which the refund was issued.. Valid values are `^[A-Z]{3}$`',
    `daypart` STRING COMMENT 'Time-of-day segment during which the original order and refund occurred, used for operational and sales analysis.. Valid values are `breakfast|lunch|dinner|late_night|snack`',
    `fraud_review_notes` STRING COMMENT 'Internal notes from fraud review or investigation related to this refund transaction.',
    `gl_posting_date` DATE COMMENT 'Date on which the refund transaction was posted to the General Ledger (GL) for financial reporting.',
    `guest_contact_method` STRING COMMENT 'Method by which the guest communicated the refund request or complaint to the restaurant.. Valid values are `in_person|phone|email|chat|mobile_app`',
    `is_fraudulent` BOOLEAN COMMENT 'Boolean flag indicating whether this refund was flagged as potentially fraudulent during review or audit.',
    `is_voided` BOOLEAN COMMENT 'Boolean flag indicating whether this refund transaction was subsequently voided or reversed.',
    `loyalty_points_refunded` STRING COMMENT 'Number of loyalty program points returned to the guest as part of the refund, if applicable.',
    `method` STRING COMMENT 'Method by which the refund value was returned to the guest, indicating the tender type used for reimbursement.. Valid values are `original_tender|cash|gift_card|loyalty_points|store_credit|check`',
    `nps_survey_sent` BOOLEAN COMMENT 'Boolean flag indicating whether a Net Promoter Score (NPS) survey was sent to the guest following the refund.',
    `order_channel` STRING COMMENT 'Service channel through which the original order was placed, retained for refund analysis by channel.. Valid values are `dine_in|drive_thru|takeout|delivery|curbside|catering`',
    `original_payment_method` STRING COMMENT 'Payment method used in the original order transaction, retained for reconciliation and audit purposes.. Valid values are `credit_card|debit_card|cash|gift_card|mobile_payment|loyalty_points`',
    `payment_processor_ref` STRING COMMENT 'External reference number from the payment processor for the refund transaction, used for reconciliation with payment gateway.',
    `reason_code` STRING COMMENT 'Standardized code categorizing the primary reason for issuing the refund. Used for root-cause analysis and Customer Satisfaction (CSAT) improvement initiatives. [ENUM-REF-CANDIDATE: wrong_item|quality_complaint|missing_item|guest_dissatisfaction|order_error|temperature_issue|allergy_concern|long_wait_time|incorrect_price|duplicate_charge|other — 11 candidates stripped; promote to reference product]',
    `reason_description` STRING COMMENT 'Free-text detailed explanation of the refund reason provided by the manager or customer service representative.',
    `refund_number` STRING COMMENT 'Business-facing unique refund transaction number displayed on receipts and used for customer service tracking.. Valid values are `^RF[0-9]{10,12}$`',
    `refund_status` STRING COMMENT 'Current lifecycle status of the refund transaction indicating processing state.. Valid values are `pending|approved|completed|rejected|reversed|cancelled`',
    `refund_type` STRING COMMENT 'Classification indicating whether the refund covers the entire order or only specific items.. Valid values are `full|partial|item_level|order_level`',
    `refunded_at` TIMESTAMP COMMENT 'Date and time when the refund transaction was completed and funds were returned to the guest.',
    `requested_at` TIMESTAMP COMMENT 'Date and time when the refund was initially requested by the guest or identified by staff.',
    `subtotal` DECIMAL(18,2) COMMENT 'Pre-tax amount of the refund, representing the base value of items or services refunded.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax portion of the refund amount, calculated based on applicable sales tax rates.',
    `third_party_delivery_provider` STRING COMMENT 'Name of the third-party delivery service provider if the original order was fulfilled through Third-Party Delivery (3PD).',
    `updated_at` TIMESTAMP COMMENT 'Timestamp when the refund record was last modified in the system.',
    `void_reason` STRING COMMENT 'Explanation for why the refund transaction was voided or reversed.',
    `voided_at` TIMESTAMP COMMENT 'Date and time when the refund was voided or reversed, if applicable.',
    CONSTRAINT pk_refund PRIMARY KEY(`refund_id`)
) COMMENT 'Captures refund and void transactions issued against a completed or in-progress guest order. Records refund reason (wrong item, quality complaint, missing item, guest dissatisfaction), refund amount, refund method (original tender, gift card, loyalty points), authorizing manager, refund timestamp, and whether the refund was full or partial. Supports CSAT root-cause analysis and exception management.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`order`.`sos_target` (
    `sos_target_id` BIGINT COMMENT 'Unique identifier for the Speed of Service target record.',
    `brand_id` BIGINT COMMENT 'Reference to the brand (QSR, casual, fine-dining) for which this SOS target is defined.',
    `site_id` BIGINT COMMENT 'Reference to the restaurant location to which this SOS target applies. May be null if the target is a brand-wide standard.',
    `superseded_by_target_sos_target_id` BIGINT COMMENT 'Reference to the SOS target that supersedes this target. Null if this is the current active target.',
    `unit_id` BIGINT COMMENT 'Reference to the restaurant location to which this SOS target applies. May be null if the target is a brand-wide standard.',
    `applies_to_order_type` STRING COMMENT 'The order type to which this SOS target applies: dine_in, takeout, delivery, or all order types.. Valid values are `dine_in|takeout|delivery|all`',
    `approved_by` STRING COMMENT 'The username or employee identifier of the person who approved this SOS target for operational use.',
    `approved_timestamp` TIMESTAMP COMMENT 'The timestamp when this SOS target was approved for operational use.',
    `compliance_threshold_percent` DECIMAL(18,2) COMMENT 'The minimum percentage of orders that must meet this SOS target for the restaurant to be considered compliant (e.g., 85.00 means 85% of orders must meet the target).',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this SOS target record was first created in the system.',
    `daypart` STRING COMMENT 'The daypart (time segment of the day) to which this SOS target applies: breakfast, lunch, dinner, late_night, or all_day.. Valid values are `breakfast|lunch|dinner|late_night|all_day`',
    `effective_end_date` DATE COMMENT 'The date on which this SOS target expires or is superseded by a new target. Null indicates an open-ended target.',
    `effective_start_date` DATE COMMENT 'The date from which this SOS target becomes effective and should be used for performance evaluation.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether this SOS target is currently active and should be used for performance measurement and KDS compliance evaluation.',
    `measurement_unit` STRING COMMENT 'The unit of measure for SOS target times: seconds or minutes. Typically seconds for QSR and fast-casual, minutes for fine-dining.. Valid values are `seconds|minutes`',
    `modified_by` STRING COMMENT 'The username or employee identifier of the person who last modified this SOS target record.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this SOS target record was last modified.',
    `notes` STRING COMMENT 'Free-text notes providing additional context, rationale, or special instructions for this SOS target.',
    `peak_hours_only` BOOLEAN COMMENT 'Boolean flag indicating whether this SOS target applies only during peak hours (true) or throughout the entire daypart (false).',
    `priority_level` STRING COMMENT 'The priority level of this SOS target for operational compliance and performance evaluation: critical, high, medium, or low.. Valid values are `critical|high|medium|low`',
    `restaurant_format` STRING COMMENT 'The restaurant format type to which this SOS target applies: QSR (Quick-Service Restaurant), casual, fine_dining, fast_casual, or food_court.. Valid values are `QSR|casual|fine_dining|fast_casual|food_court`',
    `service_channel` STRING COMMENT 'The service channel to which this SOS target applies: DT (Drive-Thru), counter (Front of House counter service), OLO (Online Ordering), 3PD (Third-Party Delivery), catering, or kiosk.. Valid values are `DT|counter|OLO|3PD|catering|kiosk`',
    `target_code` STRING COMMENT 'Business identifier code for the SOS target, used for external reference and reporting (e.g., DT_LUNCH_QSR, COUNTER_DINNER_CASUAL).. Valid values are `^[A-Z0-9_]{3,20}$`',
    `target_handoff_time_seconds` STRING COMMENT 'The target time in seconds from order ready (on KDS) to order handoff to guest or delivery driver.',
    `target_name` STRING COMMENT 'Human-readable name for the SOS target (e.g., Drive-Thru Lunch Target, Counter Service Dinner Target).',
    `target_queue_time_seconds` STRING COMMENT 'The target time in seconds a guest should wait in queue before placing an order, applicable to counter and drive-thru channels.',
    `target_ticket_time_seconds` STRING COMMENT 'The target time in seconds from order placement to order ready on the Kitchen Display System (KDS), representing the kitchen preparation speed target.',
    `target_total_order_time_seconds` STRING COMMENT 'The target total time in seconds from order placement to order fulfillment (handed to guest or delivered), representing the complete Speed of Service (SOS) target.',
    `target_type` STRING COMMENT 'Classification of the SOS target: brand_standard (corporate-mandated), local_goal (restaurant-specific operational goal), franchise_goal (franchisee-defined target), or regulatory (mandated by health or safety regulations).. Valid values are `brand_standard|local_goal|franchise_goal|regulatory`',
    `version_number` STRING COMMENT 'The version number of this SOS target, incremented each time the target is revised or updated.',
    `warning_threshold_percent` DECIMAL(18,2) COMMENT 'The percentage threshold below which a warning alert is triggered for operational management (e.g., 80.00 triggers a warning if compliance falls below 80%).',
    `weather_adjusted` BOOLEAN COMMENT 'Boolean flag indicating whether this SOS target should be adjusted based on adverse weather conditions that impact throughput.',
    `created_by` STRING COMMENT 'The username or employee identifier of the person who created this SOS target record.',
    CONSTRAINT pk_sos_target PRIMARY KEY(`sos_target_id`)
) COMMENT 'Reference entity defining brand-mandated Speed of Service (SOS) targets segmented by service channel, daypart, and restaurant format (QSR, casual, fine-dining). Captures daypart definitions (name, start time, end time, category — breakfast, lunch, dinner, late night), target ticket time in seconds, target total order time, channel applicability, effective date range, and whether the target is a brand standard or local operational goal. Serves as the authoritative daypart and SOS benchmark reference for KDS ticket compliance evaluation, drive-thru SOS benchmarking, PMIX time-of-day analysis, ATC/ACV benchmarking, and labor scheduling alignment.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`order`.`tax` (
    `tax_id` BIGINT COMMENT 'Unique surrogate identifier for each tax line record applied to a guest order. Primary key for the order_tax data product in the Databricks Silver Layer.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Ensures tax liabilities from each order are posted to the correct tax GL account for compliance and reporting.',
    `guest_order_id` BIGINT COMMENT 'Reference to the parent guest order to which this tax line belongs. Establishes the header-to-line relationship between guest_order and order_tax.',
    `site_id` BIGINT COMMENT 'Identifier of the restaurant location where the order was placed. Used to resolve the applicable tax jurisdiction and for location-level financial reconciliation.',
    `unit_id` BIGINT COMMENT 'Identifier of the restaurant location where the order was placed. Used to resolve the applicable tax jurisdiction and for location-level financial reconciliation.',
    `adjusted_timestamp` TIMESTAMP COMMENT 'The date and time (yyyy-MM-ddTHH:mm:ss.SSSXXX) when a post-transaction tax adjustment was applied to this line. Populated only when tax_status = adjusted. Supports audit trail for tax corrections.',
    `adjustment_reason` STRING COMMENT 'The reason code for a post-transaction tax adjustment when tax_status = adjusted (e.g., rate_correction, jurisdiction_change, exemption_applied, refund, audit_correction, other). Required for audit trail and regulatory compliance.. Valid values are `rate_correction|jurisdiction_change|exemption_applied|refund|audit_correction|other`',
    `amount` DECIMAL(18,2) COMMENT 'The computed tax amount for this tax line in the transaction currency (taxable_amount × tax_rate, or as overridden by the tax engine). Core field for financial reconciliation, P&L reporting, and tax remittance.',
    `applied_timestamp` TIMESTAMP COMMENT 'The date and time (yyyy-MM-ddTHH:mm:ss.SSSXXX) when this tax line was computed and applied to the order by the tax engine or POS system. Represents the principal business event time for this tax line record.',
    `authority_code` STRING COMMENT 'Standardized code identifying the tax authority or jurisdiction as defined by the tax engine or ERP (SAP S/4HANA Tax Condition). Used for automated tax remittance and reconciliation.',
    `authority_level` STRING COMMENT 'The governmental jurisdiction level that imposes this tax line. Supports multi-jurisdiction tax compliance across all restaurant locations. Values: federal, state, county, city, district, special.. Valid values are `federal|state|county|city|district|special`',
    `authority_name` STRING COMMENT 'The full name of the tax authority or jurisdiction imposing this tax (e.g., California State Board of Equalization, Cook County Revenue Department, City of Chicago). Used for regulatory reporting and remittance.',
    `tax_code` STRING COMMENT 'The internal or POS-assigned tax code identifying the specific tax rule applied (e.g., TX_CA_SALES, TX_CHI_BEV). Maps to the tax condition record in SAP S/4HANA and Oracle MICROS POS tax configuration.',
    `cost_center_code` STRING COMMENT 'The SAP S/4HANA cost center code associated with the restaurant location for this tax line. Used for internal cost allocation, P&L reporting by location, and management accounting.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the tax jurisdiction (e.g., USA, CAN, GBR). Required for international operations, VAT compliance, and cross-border tax reporting.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time (yyyy-MM-ddTHH:mm:ss.SSSXXX) when this tax line record was first created in the data platform. Audit trail field for data lineage and Silver Layer ingestion tracking.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary amounts on this tax line (e.g., USD, CAD, GBP). Required for multi-currency operations and financial reporting under GAAP/IFRS.. Valid values are `^[A-Z]{3}$`',
    `daypart` STRING COMMENT 'The meal period or daypart during which the order was placed (breakfast, lunch, dinner, late_night, snack). Used for daypart-level tax and revenue analysis in foodservice operations.. Valid values are `breakfast|lunch|dinner|late_night|snack`',
    `engine_source` STRING COMMENT 'Identifies the system or engine that calculated and applied this tax line (e.g., pos = Oracle MICROS POS built-in tax, vertex = Vertex O Series, avalara = Avalara AvaTax, sap_tax = SAP S/4HANA tax engine, manual = manually entered). Used for reconciliation and audit.. Valid values are `pos|vertex|avalara|sap_tax|manual`',
    `exemption_certificate_ref` STRING COMMENT 'Reference number or identifier of the tax exemption certificate presented by the guest or organization. Required for audit documentation when is_exempt is True. Null when no exemption applies.',
    `exemption_reason` STRING COMMENT 'The reason code for a tax exemption when is_exempt is True (e.g., government, non_profit, resale, diplomatic, employee_meal, other). Required for audit trail and regulatory compliance. Null when is_exempt is False.. Valid values are `government|non_profit|resale|diplomatic|employee_meal|other`',
    `is_exempt` BOOLEAN COMMENT 'Indicates whether this tax line was flagged as exempt (True) due to a guest exemption certificate, government order, or qualifying non-profit status. When True, tax_amount should be zero and exemption_reason should be populated.',
    `is_refunded` BOOLEAN COMMENT 'Indicates whether the tax amount on this line has been refunded to the guest (True) as part of an order refund or cancellation. Used for refund reconciliation and tax reversal tracking.',
    `is_tax_inclusive` BOOLEAN COMMENT 'Indicates whether this tax was already included in the menu price (True) or added at checkout on top of the menu price (False). Critical for VAT/GST jurisdictions and for accurate revenue recognition and tax remittance calculations.',
    `line_sequence` STRING COMMENT 'Sequential number ordering multiple tax lines within the same order (e.g., 1 = state sales tax, 2 = county tax, 3 = city beverage tax). Ensures deterministic ordering for receipt display and financial reporting.',
    `tax_name` STRING COMMENT 'Human-readable name of the tax as displayed on the guest receipt or financial report (e.g., Illinois Sales Tax, Chicago Beverage Tax, CA Bag Fee). Required for receipt compliance and guest transparency.',
    `order_channel` STRING COMMENT 'The service channel through which the order was placed (pos = in-store Point of Sale, drive_thru = Drive-Thru (DT), olo = Online Ordering (OLO), third_party_delivery = Third-Party Delivery (3PD), kiosk = self-service kiosk, catering). Used for channel-level tax analysis and compliance.. Valid values are `pos|drive_thru|olo|third_party_delivery|kiosk|catering`',
    `original_tax_amount` DECIMAL(18,2) COMMENT 'The tax amount as originally computed at the time of order placement, before any post-transaction adjustments. Populated when tax_status = adjusted to preserve the audit trail of the original calculation.',
    `period_date` DATE COMMENT 'The business date (yyyy-MM-dd) to which this tax line is attributed for tax remittance and financial period reporting. May differ from the transaction timestamp for end-of-day batch processing or period adjustments.',
    `pos_tax_line_ref` STRING COMMENT 'The native tax line identifier or sequence number assigned by Oracle MICROS POS for this tax entry. Used for cross-system reconciliation between the POS transaction log and the lakehouse Silver Layer.',
    `rate` DECIMAL(18,2) COMMENT 'The applicable tax rate expressed as a decimal fraction (e.g., 0.0875 for 8.75%). Sourced from the tax engine or POS tax configuration at the time of the transaction. Used for tax amount validation and audit.',
    `refund_amount` DECIMAL(18,2) COMMENT 'The tax amount refunded to the guest when is_refunded is True. May be a partial refund (less than tax_amount) for partial order refunds. Used for financial reconciliation and tax reversal reporting.',
    `remittance_period` STRING COMMENT 'The fiscal period (e.g., 2024-Q1, 2024-03) in which this tax amount is scheduled for remittance to the tax authority. Used for tax filing calendar management and period-end close.',
    `remittance_status` STRING COMMENT 'Indicates whether this tax amount has been remitted to the applicable tax authority (pending = not yet remitted, remitted = successfully paid to authority, not_applicable = exempt or zero-rate, failed = remittance attempt failed). Supports tax compliance tracking.. Valid values are `pending|remitted|not_applicable|failed`',
    `sap_tax_document_ref` STRING COMMENT 'The SAP S/4HANA FI-TX tax document number associated with this tax line for GL posting and tax remittance. Enables end-to-end traceability from POS transaction to ERP financial posting.',
    `state_code` STRING COMMENT 'Two-letter US state code (or equivalent provincial code) of the tax jurisdiction where the restaurant is located (e.g., IL, CA, TX). Used for state-level tax rate lookup, remittance routing, and regulatory reporting.. Valid values are `^[A-Z]{2}$`',
    `tax_status` STRING COMMENT 'Current lifecycle status of this tax line record. applied = tax successfully computed and applied; voided = tax line cancelled due to order void; adjusted = tax amount corrected post-transaction; pending = awaiting tax engine resolution; reversed = tax reversed for refund.. Valid values are `applied|voided|adjusted|pending|reversed`',
    `tax_type` STRING COMMENT 'The category of tax applied to this line (e.g., sales_tax, vat, beverage_tax, bag_fee, excise_tax, service_tax). Supports differentiated tax reporting and compliance across jurisdictions. [ENUM-REF-CANDIDATE: sales_tax|vat|beverage_tax|bag_fee|excise_tax|service_tax|surcharge|environmental_fee — promote to reference product if additional types are needed]. Valid values are `sales_tax|vat|beverage_tax|bag_fee|excise_tax|service_tax`',
    `taxable_amount` DECIMAL(18,2) COMMENT 'The portion of the order subtotal that is subject to this specific tax line, expressed in the transaction currency. Excludes non-taxable items, exempt amounts, and tax-inclusive components. Used for tax calculation validation.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time (yyyy-MM-ddTHH:mm:ss.SSSXXX) when this tax line record was last modified in the data platform. Used for change data capture (CDC), incremental loads, and audit trail.',
    `voided_timestamp` TIMESTAMP COMMENT 'The date and time (yyyy-MM-ddTHH:mm:ss.SSSXXX) when this tax line was voided, if applicable. Populated only when tax_status = voided. Used for void audit trail and financial reversal processing.',
    CONSTRAINT pk_tax PRIMARY KEY(`tax_id`)
) COMMENT 'Records tax line details applied to a guest order, supporting multi-jurisdiction tax compliance. Captures tax authority (federal, state, county, city), tax type (sales tax, VAT, beverage tax, bag fee), tax rate, taxable amount, tax amount, and whether the tax was included in the menu price or added at checkout. Supports financial reconciliation and regulatory tax reporting across all restaurant locations.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`order`.`order_ingredient_usage` (
    `order_ingredient_usage_id` BIGINT COMMENT 'Primary key for the ingredient_usage association',
    `order_item_id` BIGINT COMMENT 'Foreign key linking to the order line item',
    `stock_item_id` BIGINT COMMENT 'Foreign key linking to the inventory stock item',
    `quantity_used` DECIMAL(18,2) COMMENT 'Amount of the stock item consumed by the order line',
    `unit_cost` DECIMAL(18,2) COMMENT 'Cost per unit of the stock item at the time of consumption',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the quantity used (e.g., grams, ounces)',
    `waste_flag` BOOLEAN COMMENT 'Indicates if the consumed quantity was recorded as waste',
    `waste_reason` STRING COMMENT 'Reason for waste (e.g., spoilage, over‑prep)',
    CONSTRAINT pk_order_ingredient_usage PRIMARY KEY(`order_ingredient_usage_id`)
) COMMENT 'Association between order_item and stock_item that records the amount of each inventory item consumed by a specific line item, including cost and waste information. Each record links one order_item to one stock_item with attributes that exist only in the context of this consumption.. Existence Justification: Each order line (order_item) consumes one or more inventory stock items (ingredients) and each stock item can be consumed by many order lines. The restaurant tracks the quantity used, unit cost, waste flag and waste reason for every such consumption to support costing, waste analysis and traceability. This relationship is actively created and maintained by the kitchen and back‑office systems.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`order`.`catering_package` (
    `catering_package_id` BIGINT COMMENT 'Primary key for catering_package',
    `parent_catering_package_id` BIGINT COMMENT 'Self-referencing FK on catering_package (parent_catering_package_id)',
    `availability_end_date` DATE COMMENT 'Date when the catering package is no longer available for ordering.',
    `availability_start_date` DATE COMMENT 'Date when the catering package becomes available for ordering.',
    `calories` STRING COMMENT 'Total calories per serving of the catering package.',
    `catering_package_category` STRING COMMENT 'Category classification of the catering package.',
    `catering_package_code` STRING COMMENT 'External code used to reference the catering package in POS and ordering systems.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the catering package record was created.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the price.',
    `delivery_zone_codes` STRING COMMENT 'Comma-separated list of delivery zone codes where the package is offered.',
    `catering_package_description` STRING COMMENT 'Detailed description of the items and services included in the package.',
    `dietary_restriction` STRING COMMENT 'Dietary restriction tags applicable to the catering package.',
    `image_url` STRING COMMENT 'Link to the image representing the catering package.',
    `is_customizable` BOOLEAN COMMENT 'Indicates whether the catering package can be customized by the customer.',
    `lead_time_days` STRING COMMENT 'Number of days required to prepare the catering package before delivery.',
    `max_custom_items` STRING COMMENT 'Maximum number of additional items that can be added to the package when customized.',
    `min_order_quantity` STRING COMMENT 'Minimum number of packages required per order.',
    `catering_package_name` STRING COMMENT 'Descriptive name of the catering package offered to customers.',
    `portion_size` STRING COMMENT 'Standard portion size classification for the catering package.',
    `price` DECIMAL(18,2) COMMENT 'Base price of the catering package before taxes and discounts.',
    `catering_package_status` STRING COMMENT 'Current lifecycle status of the catering package.',
    `surcharge_amount` DECIMAL(18,2) COMMENT 'Additional surcharge applied to the package for special handling.',
    `tax_exempt` BOOLEAN COMMENT 'Indicates if the catering package is exempt from sales tax.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the catering package record.',
    `weight_kg` DECIMAL(18,2) COMMENT 'Total weight of the catering package in kilograms.',
    CONSTRAINT pk_catering_package PRIMARY KEY(`catering_package_id`)
) COMMENT 'Master reference table for catering_package. Referenced by catering_package_id.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`order`.`delivery_platform` (
    `delivery_platform_id` BIGINT COMMENT 'Primary key for delivery_platform',
    `parent_delivery_platform_id` BIGINT COMMENT 'Self-referencing FK on delivery_platform (parent_delivery_platform_id)',
    `average_delivery_time_minutes` STRING COMMENT 'Typical time in minutes from order acceptance to delivery completion for this platform.',
    `delivery_platform_code` STRING COMMENT 'Short alphanumeric code used to reference the platform in internal systems.',
    `contract_end_date` DATE COMMENT 'Date when the contractual agreement with the platform expires or is terminated (nullable for open‑ended contracts).',
    `contract_start_date` DATE COMMENT 'Date when the contractual agreement with the platform became effective.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the delivery platform record was first created in the system.',
    `fee_percentage` DECIMAL(18,2) COMMENT 'Standard commission fee charged by the platform as a percentage of order value.',
    `integration_method` STRING COMMENT 'Technical method used to exchange data with the platform.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the delivery platform record.',
    `delivery_platform_name` STRING COMMENT 'Official name of the delivery platform (e.g., DoorDash, UberEats).',
    `notes` STRING COMMENT 'Free‑form field for any supplemental information or remarks about the platform.',
    `onboarding_date` DATE COMMENT 'Date the platform was first integrated and made available for order routing.',
    `platform_type` STRING COMMENT 'Classification of the platform based on ownership and integration model.',
    `delivery_platform_status` STRING COMMENT 'Current operational status of the delivery platform.',
    `support_contact_email` STRING COMMENT 'Primary email address for technical or operational support contacts at the platform.',
    `support_phone_number` STRING COMMENT 'Primary phone number for technical or operational support contacts at the platform.',
    CONSTRAINT pk_delivery_platform PRIMARY KEY(`delivery_platform_id`)
) COMMENT 'Master reference table for delivery_platform. Referenced by delivery_platform_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ADD CONSTRAINT `fk_order_guest_order_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_restaurants_v1`.`order`.`channel`(`channel_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ADD CONSTRAINT `fk_order_order_item_discount_id` FOREIGN KEY (`discount_id`) REFERENCES `vibe_restaurants_v1`.`order`.`discount`(`discount_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ADD CONSTRAINT `fk_order_order_item_guest_order_id` FOREIGN KEY (`guest_order_id`) REFERENCES `vibe_restaurants_v1`.`order`.`guest_order`(`guest_order_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ADD CONSTRAINT `fk_order_order_modifier_guest_order_id` FOREIGN KEY (`guest_order_id`) REFERENCES `vibe_restaurants_v1`.`order`.`guest_order`(`guest_order_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ADD CONSTRAINT `fk_order_order_modifier_order_item_id` FOREIGN KEY (`order_item_id`) REFERENCES `vibe_restaurants_v1`.`order`.`order_item`(`order_item_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ADD CONSTRAINT `fk_order_payment_guest_order_id` FOREIGN KEY (`guest_order_id`) REFERENCES `vibe_restaurants_v1`.`order`.`guest_order`(`guest_order_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ADD CONSTRAINT `fk_order_payment_refund_id` FOREIGN KEY (`refund_id`) REFERENCES `vibe_restaurants_v1`.`order`.`refund`(`refund_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` ADD CONSTRAINT `fk_order_status_event_guest_order_id` FOREIGN KEY (`guest_order_id`) REFERENCES `vibe_restaurants_v1`.`order`.`guest_order`(`guest_order_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` ADD CONSTRAINT `fk_order_status_event_source_status_event_id` FOREIGN KEY (`source_status_event_id`) REFERENCES `vibe_restaurants_v1`.`order`.`status_event`(`status_event_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`daypart` ADD CONSTRAINT `fk_order_daypart_guest_order_id` FOREIGN KEY (`guest_order_id`) REFERENCES `vibe_restaurants_v1`.`order`.`guest_order`(`guest_order_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`kds_ticket` ADD CONSTRAINT `fk_order_kds_ticket_guest_order_id` FOREIGN KEY (`guest_order_id`) REFERENCES `vibe_restaurants_v1`.`order`.`guest_order`(`guest_order_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`drive_thru_event` ADD CONSTRAINT `fk_order_drive_thru_event_guest_order_id` FOREIGN KEY (`guest_order_id`) REFERENCES `vibe_restaurants_v1`.`order`.`guest_order`(`guest_order_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_order` ADD CONSTRAINT `fk_order_delivery_order_delivery_platform_id` FOREIGN KEY (`delivery_platform_id`) REFERENCES `vibe_restaurants_v1`.`order`.`delivery_platform`(`delivery_platform_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_order` ADD CONSTRAINT `fk_order_delivery_order_guest_order_id` FOREIGN KEY (`guest_order_id`) REFERENCES `vibe_restaurants_v1`.`order`.`guest_order`(`guest_order_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_order` ADD CONSTRAINT `fk_order_catering_order_catering_package_id` FOREIGN KEY (`catering_package_id`) REFERENCES `vibe_restaurants_v1`.`order`.`catering_package`(`catering_package_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_order` ADD CONSTRAINT `fk_order_catering_order_guest_order_id` FOREIGN KEY (`guest_order_id`) REFERENCES `vibe_restaurants_v1`.`order`.`guest_order`(`guest_order_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`discount` ADD CONSTRAINT `fk_order_discount_guest_order_id` FOREIGN KEY (`guest_order_id`) REFERENCES `vibe_restaurants_v1`.`order`.`guest_order`(`guest_order_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`refund` ADD CONSTRAINT `fk_order_refund_guest_order_id` FOREIGN KEY (`guest_order_id`) REFERENCES `vibe_restaurants_v1`.`order`.`guest_order`(`guest_order_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`sos_target` ADD CONSTRAINT `fk_order_sos_target_superseded_by_target_sos_target_id` FOREIGN KEY (`superseded_by_target_sos_target_id`) REFERENCES `vibe_restaurants_v1`.`order`.`sos_target`(`sos_target_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`tax` ADD CONSTRAINT `fk_order_tax_guest_order_id` FOREIGN KEY (`guest_order_id`) REFERENCES `vibe_restaurants_v1`.`order`.`guest_order`(`guest_order_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_ingredient_usage` ADD CONSTRAINT `fk_order_order_ingredient_usage_order_item_id` FOREIGN KEY (`order_item_id`) REFERENCES `vibe_restaurants_v1`.`order`.`order_item`(`order_item_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_package` ADD CONSTRAINT `fk_order_catering_package_parent_catering_package_id` FOREIGN KEY (`parent_catering_package_id`) REFERENCES `vibe_restaurants_v1`.`order`.`catering_package`(`catering_package_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_platform` ADD CONSTRAINT `fk_order_delivery_platform_parent_delivery_platform_id` FOREIGN KEY (`parent_delivery_platform_id`) REFERENCES `vibe_restaurants_v1`.`order`.`delivery_platform`(`delivery_platform_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_restaurants_v1`.`order` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_restaurants_v1`.`order` SET TAGS ('dbx_domain' = 'order');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` SET TAGS ('dbx_subdomain' = 'transaction_core');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `guest_order_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Order ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Order Channel Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `coupon_id` SET TAGS ('dbx_business_glossary_term' = 'Coupon Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisee Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `illness_report_id` SET TAGS ('dbx_business_glossary_term' = 'Illness Report Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `local_store_marketing_id` SET TAGS ('dbx_business_glossary_term' = 'Local Store Marketing Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Member Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `marketing_guest_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Guest Segment Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `menu_id` SET TAGS ('dbx_business_glossary_term' = 'Menu Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `primary_guest_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Server Employee ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `cancelled_at` SET TAGS ('dbx_business_glossary_term' = 'Order Cancelled Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `created_at` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `daypart` SET TAGS ('dbx_business_glossary_term' = 'Daypart');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `daypart` SET TAGS ('dbx_value_regex' = 'breakfast|lunch|afternoon|dinner|late_night');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `delivery_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Delivery Address Line 1');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `delivery_address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `delivery_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `delivery_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Delivery Postal Code');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `delivery_postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `delivery_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `delivery_provider` SET TAGS ('dbx_business_glossary_term' = 'Third-Party Delivery (3PD) Provider');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `delivery_provider` SET TAGS ('dbx_value_regex' = 'doordash|uber_eats|grubhub|postmates|internal|none');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Order Discount Amount');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `discount_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `discount_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `fulfilled_at` SET TAGS ('dbx_business_glossary_term' = 'Order Fulfilled Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `is_lto` SET TAGS ('dbx_business_glossary_term' = 'Limited Time Offer (LTO) Flag');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `is_voided` SET TAGS ('dbx_business_glossary_term' = 'Order Voided Flag');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `item_count` SET TAGS ('dbx_business_glossary_term' = 'Item Count');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `kds_routed_at` SET TAGS ('dbx_business_glossary_term' = 'Kitchen Display System (KDS) Routed Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `loyalty_points_earned` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Earned');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `loyalty_points_redeemed` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Redeemed');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `olo_order_ref` SET TAGS ('dbx_business_glossary_term' = 'Online Ordering (OLO) Order Reference');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Order Status');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `order_status` SET TAGS ('dbx_value_regex' = 'placed|in_preparation|ready|fulfilled|cancelled|voided');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Order Type');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `order_type` SET TAGS ('dbx_value_regex' = 'dine_in|takeout|drive_thru|delivery|curbside|catering');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `party_size` SET TAGS ('dbx_business_glossary_term' = 'Party Size');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'pending|authorized|captured|refunded|voided|failed');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `placed_at` SET TAGS ('dbx_business_glossary_term' = 'Order Placed Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `pos_transaction_ref` SET TAGS ('dbx_business_glossary_term' = 'Point of Sale (POS) Transaction Reference');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `ready_at` SET TAGS ('dbx_business_glossary_term' = 'Order Ready Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `sos_seconds` SET TAGS ('dbx_business_glossary_term' = 'Speed of Service (SOS) Seconds');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `special_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Instructions');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `subtotal_amount` SET TAGS ('dbx_business_glossary_term' = 'Order Subtotal Amount');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `subtotal_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `subtotal_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `table_number` SET TAGS ('dbx_business_glossary_term' = 'Table Number');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Order Tax Amount');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `tax_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `tax_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `tender_type` SET TAGS ('dbx_business_glossary_term' = 'Tender Type');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `tender_type` SET TAGS ('dbx_value_regex' = 'cash|credit_card|debit_card|mobile_pay|gift_card|loyalty_points');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `ticket_number` SET TAGS ('dbx_business_glossary_term' = 'Ticket Number');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `ticket_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Ticket Time (Seconds)');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `tip_amount` SET TAGS ('dbx_business_glossary_term' = 'Tip Amount');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `tip_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `tip_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Order Total Amount');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `total_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `total_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `updated_at` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `void_reason` SET TAGS ('dbx_business_glossary_term' = 'Void Reason');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `void_reason` SET TAGS ('dbx_value_regex' = 'guest_request|error_correction|system_error|manager_comp|other');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` SET TAGS ('dbx_subdomain' = 'transaction_core');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ALTER COLUMN `order_item_id` SET TAGS ('dbx_business_glossary_term' = 'Order Item ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ALTER COLUMN `discount_id` SET TAGS ('dbx_business_glossary_term' = 'Discount ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ALTER COLUMN `guest_order_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ALTER COLUMN `ingredient_id` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ALTER COLUMN `ingredient_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Lot Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ALTER COLUMN `kitchen_station_id` SET TAGS ('dbx_business_glossary_term' = 'Kitchen Display System (KDS) Station ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ALTER COLUMN `menu_item_id` SET TAGS ('dbx_business_glossary_term' = 'Menu Item ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ALTER COLUMN `menu_lto_id` SET TAGS ('dbx_business_glossary_term' = 'Lto Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ALTER COLUMN `menu_modifier_id` SET TAGS ('dbx_business_glossary_term' = 'Modifier ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ALTER COLUMN `combo_meal_id` SET TAGS ('dbx_business_glossary_term' = 'Combo Meal ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ALTER COLUMN `order_combo_meal_id` SET TAGS ('dbx_business_glossary_term' = 'Combo Meal ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Prep Employee Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ALTER COLUMN `allergen_override_flag` SET TAGS ('dbx_business_glossary_term' = 'Allergen Override Flag');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ALTER COLUMN `calorie_count` SET TAGS ('dbx_business_glossary_term' = 'Calorie Count');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ALTER COLUMN `cost` SET TAGS ('dbx_business_glossary_term' = 'Item Cost (Cost of Goods Sold)');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ALTER COLUMN `cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ALTER COLUMN `daypart_code` SET TAGS ('dbx_business_glossary_term' = 'Daypart Code');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ALTER COLUMN `daypart_code` SET TAGS ('dbx_value_regex' = 'breakfast|lunch|afternoon|dinner|late_night');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ALTER COLUMN `is_combo_component` SET TAGS ('dbx_business_glossary_term' = 'Combo Component Flag');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ALTER COLUMN `is_lto` SET TAGS ('dbx_business_glossary_term' = 'Limited Time Offer (LTO) Flag');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ALTER COLUMN `item_status` SET TAGS ('dbx_business_glossary_term' = 'Item Fulfillment Status');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ALTER COLUMN `item_status` SET TAGS ('dbx_value_regex' = 'ordered|in_preparation|ready|served|voided|comped');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ALTER COLUMN `kds_bump_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Kitchen Display System (KDS) Bump Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ALTER COLUMN `kds_sent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Kitchen Display System (KDS) Sent Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ALTER COLUMN `line_discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Line Discount Amount');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ALTER COLUMN `line_gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Line Gross Amount');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ALTER COLUMN `line_net_amount` SET TAGS ('dbx_business_glossary_term' = 'Line Net Amount');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ALTER COLUMN `line_sequence` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence Number');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ALTER COLUMN `loyalty_points_earned` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Earned');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ALTER COLUMN `modifier_price` SET TAGS ('dbx_business_glossary_term' = 'Modifier Price');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ALTER COLUMN `pmix_category` SET TAGS ('dbx_business_glossary_term' = 'Product Mix (PMIX) Category');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ALTER COLUMN `preparation_instructions` SET TAGS ('dbx_business_glossary_term' = 'Preparation Instructions');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ALTER COLUMN `promo_code` SET TAGS ('dbx_business_glossary_term' = 'Promotional Code');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Item Quantity');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ALTER COLUMN `refund_amount` SET TAGS ('dbx_business_glossary_term' = 'Refund Amount');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ALTER COLUMN `refund_flag` SET TAGS ('dbx_business_glossary_term' = 'Refund Flag');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ALTER COLUMN `service_channel` SET TAGS ('dbx_business_glossary_term' = 'Service Channel');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ALTER COLUMN `service_channel` SET TAGS ('dbx_value_regex' = 'dine_in|drive_thru|online|third_party_delivery|catering|kiosk');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ALTER COLUMN `source_system_item_ref` SET TAGS ('dbx_business_glossary_term' = 'Source System Item Reference');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ALTER COLUMN `tax_exempt_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Flag');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ALTER COLUMN `ticket_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Ticket Time (Seconds)');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ALTER COLUMN `void_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Void Reason Code');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ALTER COLUMN `waste_flag` SET TAGS ('dbx_business_glossary_term' = 'Waste Flag');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ALTER COLUMN `waste_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Waste Reason Code');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ALTER COLUMN `waste_reason_code` SET TAGS ('dbx_value_regex' = 'overproduction|spoilage|prep_error|dropped|expired|quality_reject');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` SET TAGS ('dbx_subdomain' = 'transaction_core');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ALTER COLUMN `order_modifier_id` SET TAGS ('dbx_business_glossary_term' = 'Order Modifier ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Applied By Employee Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ALTER COLUMN `guest_order_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ALTER COLUMN `modifier_group_id` SET TAGS ('dbx_business_glossary_term' = 'Modifier Group ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ALTER COLUMN `order_item_id` SET TAGS ('dbx_business_glossary_term' = 'Order Item ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ALTER COLUMN `menu_modifier_id` SET TAGS ('dbx_business_glossary_term' = 'Modifier ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ALTER COLUMN `promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ALTER COLUMN `source_modifier_menu_modifier_id` SET TAGS ('dbx_business_glossary_term' = 'Source System Modifier ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ALTER COLUMN `allergen_flag` SET TAGS ('dbx_business_glossary_term' = 'Allergen Flag');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ALTER COLUMN `allergen_notes` SET TAGS ('dbx_business_glossary_term' = 'Allergen Notes');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ALTER COLUMN `applied_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modifier Applied Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ALTER COLUMN `calorie_delta` SET TAGS ('dbx_business_glossary_term' = 'Modifier Calorie Delta');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ALTER COLUMN `cogs_delta` SET TAGS ('dbx_business_glossary_term' = 'Modifier Cost of Goods Sold (COGS) Delta');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ALTER COLUMN `cogs_delta` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ALTER COLUMN `daypart` SET TAGS ('dbx_business_glossary_term' = 'Daypart');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ALTER COLUMN `daypart` SET TAGS ('dbx_value_regex' = 'breakfast|lunch|afternoon|dinner|late_night');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ALTER COLUMN `group_name` SET TAGS ('dbx_business_glossary_term' = 'Modifier Group Name');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ALTER COLUMN `initiation_source` SET TAGS ('dbx_business_glossary_term' = 'Modifier Initiation Source');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ALTER COLUMN `initiation_source` SET TAGS ('dbx_value_regex' = 'guest|system_default|crew_suggested|loyalty_rule|promotional_rule');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ALTER COLUMN `is_comped` SET TAGS ('dbx_business_glossary_term' = 'Is Comped Modifier Flag');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ALTER COLUMN `is_default` SET TAGS ('dbx_business_glossary_term' = 'Is Default Modifier Flag');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ALTER COLUMN `is_voided` SET TAGS ('dbx_business_glossary_term' = 'Is Voided Flag');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ALTER COLUMN `kds_acknowledged_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Kitchen Display System (KDS) Acknowledged Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ALTER COLUMN `kds_routed` SET TAGS ('dbx_business_glossary_term' = 'Kitchen Display System (KDS) Routed Flag');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ALTER COLUMN `kds_station_name` SET TAGS ('dbx_business_glossary_term' = 'Kitchen Display System (KDS) Station Name');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ALTER COLUMN `loyalty_redemption_flag` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Redemption Flag');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ALTER COLUMN `lto_flag` SET TAGS ('dbx_business_glossary_term' = 'Limited Time Offer (LTO) Flag');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ALTER COLUMN `modifier_name` SET TAGS ('dbx_business_glossary_term' = 'Modifier Name');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ALTER COLUMN `modifier_status` SET TAGS ('dbx_business_glossary_term' = 'Modifier Status');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ALTER COLUMN `modifier_status` SET TAGS ('dbx_value_regex' = 'applied|voided|pending|rejected');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ALTER COLUMN `modifier_type` SET TAGS ('dbx_business_glossary_term' = 'Modifier Type');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ALTER COLUMN `modifier_type` SET TAGS ('dbx_value_regex' = 'add_on|substitution|removal|upsize|downsize|special_request');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ALTER COLUMN `olo_modifier_code` SET TAGS ('dbx_business_glossary_term' = 'Online Ordering (OLO) Modifier Code');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ALTER COLUMN `order_channel` SET TAGS ('dbx_business_glossary_term' = 'Order Channel');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ALTER COLUMN `order_channel` SET TAGS ('dbx_value_regex' = 'pos|drive_thru|online|third_party_delivery|kiosk|catering');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ALTER COLUMN `pos_modifier_code` SET TAGS ('dbx_business_glossary_term' = 'Point of Sale (POS) Modifier Code');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ALTER COLUMN `prep_instruction` SET TAGS ('dbx_business_glossary_term' = 'Modifier Preparation Instruction');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ALTER COLUMN `price_delta` SET TAGS ('dbx_business_glossary_term' = 'Modifier Price Delta');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Modifier Quantity');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ALTER COLUMN `sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Modifier Sequence Number');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Modifier Unit of Measure');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ALTER COLUMN `voided_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modifier Voided Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` SET TAGS ('dbx_subdomain' = 'transaction_core');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `payment_id` SET TAGS ('dbx_business_glossary_term' = 'Order Payment ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Cashier Employee ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `guest_order_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Account ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `pos_terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Point of Sale (POS) Terminal ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Profile Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `refund_id` SET TAGS ('dbx_business_glossary_term' = 'Refund Reference ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `applied_amount` SET TAGS ('dbx_business_glossary_term' = 'Applied Amount');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `applied_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `applied_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `authorization_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Authorization Code');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `captured_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Payment Captured Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `card_entry_method` SET TAGS ('dbx_business_glossary_term' = 'Card Entry Method');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `card_entry_method` SET TAGS ('dbx_value_regex' = 'swipe|chip|contactless|manual_entry|token');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `card_type` SET TAGS ('dbx_business_glossary_term' = 'Card Network Type');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `card_type` SET TAGS ('dbx_value_regex' = 'visa|mastercard|amex|discover|unionpay|other');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `change_due_amount` SET TAGS ('dbx_business_glossary_term' = 'Change Due Amount');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Payment Channel');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `daypart` SET TAGS ('dbx_business_glossary_term' = 'Daypart');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `daypart` SET TAGS ('dbx_value_regex' = 'breakfast|lunch|afternoon|dinner|late_night');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `gift_card_number_masked` SET TAGS ('dbx_business_glossary_term' = 'Masked Gift Card Number');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `gift_card_number_masked` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `gift_card_number_masked` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `interchange_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Interchange Fee Amount');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `interchange_fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `is_split_tender` SET TAGS ('dbx_business_glossary_term' = 'Is Split Tender Indicator');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `is_voided` SET TAGS ('dbx_business_glossary_term' = 'Is Voided Indicator');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `loyalty_points_redeemed` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Redeemed');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `masked_card_number` SET TAGS ('dbx_business_glossary_term' = 'Masked Card Number (PCI-Compliant)');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `masked_card_number` SET TAGS ('dbx_value_regex' = '^[0-9]{4}*{8}[0-9]{4}$');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `masked_card_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `masked_card_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `offline_authorization_flag` SET TAGS ('dbx_business_glossary_term' = 'Offline Authorization Flag');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'authorized|captured|settled|declined|voided|refunded');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `pos_transaction_number` SET TAGS ('dbx_business_glossary_term' = 'Point of Sale (POS) Transaction Number');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `processor_name` SET TAGS ('dbx_business_glossary_term' = 'Payment Processor Name');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `processor_reference_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Processor Reference ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `promo_code_applied` SET TAGS ('dbx_business_glossary_term' = 'Promotional Code Applied');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `refund_reason` SET TAGS ('dbx_business_glossary_term' = 'Refund Reason');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `refund_reason` SET TAGS ('dbx_value_regex' = 'guest_complaint|order_error|duplicate_charge|item_unavailable|other');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `response_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Processor Response Code');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `settlement_batch_code` SET TAGS ('dbx_business_glossary_term' = 'Settlement Batch ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `split_tender_sequence` SET TAGS ('dbx_business_glossary_term' = 'Split Tender Sequence Number');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `tender_type` SET TAGS ('dbx_business_glossary_term' = 'Tender Type');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `tender_type` SET TAGS ('dbx_value_regex' = 'cash|credit_card|debit_card|gift_card|loyalty_redemption|3pd_settlement');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `tendered_amount` SET TAGS ('dbx_business_glossary_term' = 'Tendered Amount');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `tendered_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `tendered_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `third_party_delivery_partner` SET TAGS ('dbx_business_glossary_term' = 'Third-Party Delivery (3PD) Partner');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `third_party_delivery_partner` SET TAGS ('dbx_value_regex' = 'doordash|uber_eats|grubhub|instacart|other');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `third_party_order_reference` SET TAGS ('dbx_business_glossary_term' = 'Third-Party Delivery (3PD) Order Reference');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `tip_amount` SET TAGS ('dbx_business_glossary_term' = 'Tip Amount');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `tip_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `tip_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `token` SET TAGS ('dbx_business_glossary_term' = 'Payment Network Token');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `token` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `token` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` SET TAGS ('dbx_subdomain' = 'fulfillment_operations');
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` ALTER COLUMN `status_event_id` SET TAGS ('dbx_business_glossary_term' = 'Order Status Event ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` ALTER COLUMN `guest_order_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` ALTER COLUMN `pos_terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Point of Sale (POS) Terminal ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` ALTER COLUMN `source_status_event_id` SET TAGS ('dbx_business_glossary_term' = 'Source System Event ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` ALTER COLUMN `business_date` SET TAGS ('dbx_business_glossary_term' = 'Business Date');
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` ALTER COLUMN `cumulative_elapsed_seconds` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Elapsed Seconds');
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` ALTER COLUMN `current_state` SET TAGS ('dbx_business_glossary_term' = 'Current Order State');
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` ALTER COLUMN `daypart` SET TAGS ('dbx_business_glossary_term' = 'Daypart');
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` ALTER COLUMN `daypart` SET TAGS ('dbx_value_regex' = 'breakfast|lunch|afternoon|dinner|late_night|overnight');
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` ALTER COLUMN `delivery_zone` SET TAGS ('dbx_business_glossary_term' = 'Delivery Zone');
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` ALTER COLUMN `drive_thru_lane` SET TAGS ('dbx_business_glossary_term' = 'Drive-Thru (DT) Lane');
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` ALTER COLUMN `drive_thru_lane` SET TAGS ('dbx_value_regex' = 'lane_1|lane_2|lane_3|express|none');
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` ALTER COLUMN `elapsed_seconds_in_prior_state` SET TAGS ('dbx_business_glossary_term' = 'Elapsed Seconds in Prior State');
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` ALTER COLUMN `event_date` SET TAGS ('dbx_business_glossary_term' = 'Event Date');
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` ALTER COLUMN `event_sequence` SET TAGS ('dbx_business_glossary_term' = 'Event Sequence Number');
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` ALTER COLUMN `exception_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Exception Reason Code');
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` ALTER COLUMN `exception_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Exception Reason Description');
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` ALTER COLUMN `fulfillment_mode` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Mode');
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` ALTER COLUMN `fulfillment_mode` SET TAGS ('dbx_value_regex' = 'immediate|scheduled|asap');
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` ALTER COLUMN `ingestion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Ingestion Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` ALTER COLUMN `is_cancellation_event` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Event Indicator');
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` ALTER COLUMN `is_sos_breach` SET TAGS ('dbx_business_glossary_term' = 'Speed of Service (SOS) Breach Indicator');
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` ALTER COLUMN `is_terminal_state` SET TAGS ('dbx_business_glossary_term' = 'Terminal State Indicator');
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` ALTER COLUMN `is_void_event` SET TAGS ('dbx_business_glossary_term' = 'Void Event Indicator');
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` ALTER COLUMN `kds_station_code` SET TAGS ('dbx_business_glossary_term' = 'Kitchen Display System (KDS) Station ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` ALTER COLUMN `manager_override` SET TAGS ('dbx_business_glossary_term' = 'Manager Override Indicator');
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` ALTER COLUMN `olo_order_reference` SET TAGS ('dbx_business_glossary_term' = 'Online Ordering (OLO) Order Reference');
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Order Type');
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` ALTER COLUMN `order_type` SET TAGS ('dbx_value_regex' = 'standard|lto|catering|group|loyalty_redemption|comp');
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` ALTER COLUMN `partition_date` SET TAGS ('dbx_business_glossary_term' = 'Partition Date');
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` ALTER COLUMN `prior_state` SET TAGS ('dbx_business_glossary_term' = 'Prior Order State');
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` ALTER COLUMN `promise_time_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Promise Time Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` ALTER COLUMN `scheduled_fulfillment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Fulfillment Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` ALTER COLUMN `service_channel` SET TAGS ('dbx_business_glossary_term' = 'Service Channel');
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` ALTER COLUMN `sos_target_seconds` SET TAGS ('dbx_business_glossary_term' = 'Speed of Service (SOS) Target Seconds');
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` ALTER COLUMN `third_party_delivery_provider` SET TAGS ('dbx_business_glossary_term' = 'Third-Party Delivery (3PD) Provider');
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` ALTER COLUMN `third_party_delivery_provider` SET TAGS ('dbx_value_regex' = 'doordash|uber_eats|grubhub|instacart|other|none');
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` ALTER COLUMN `third_party_event_reference` SET TAGS ('dbx_business_glossary_term' = 'Third-Party Delivery (3PD) Event Reference');
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` ALTER COLUMN `triggering_actor` SET TAGS ('dbx_business_glossary_term' = 'Triggering Actor');
ALTER TABLE `vibe_restaurants_v1`.`order`.`channel` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_restaurants_v1`.`order`.`channel` SET TAGS ('dbx_subdomain' = 'service_reference');
ALTER TABLE `vibe_restaurants_v1`.`order`.`channel` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Order Channel ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`channel` ALTER COLUMN `activation_date` SET TAGS ('dbx_business_glossary_term' = 'Activation Date');
ALTER TABLE `vibe_restaurants_v1`.`order`.`channel` ALTER COLUMN `average_ticket_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Average Ticket Time (Seconds)');
ALTER TABLE `vibe_restaurants_v1`.`order`.`channel` ALTER COLUMN `channel_category` SET TAGS ('dbx_business_glossary_term' = 'Channel Category');
ALTER TABLE `vibe_restaurants_v1`.`order`.`channel` ALTER COLUMN `channel_category` SET TAGS ('dbx_value_regex' = 'dine_in|takeout|delivery|catering|hybrid');
ALTER TABLE `vibe_restaurants_v1`.`order`.`channel` ALTER COLUMN `channel_type` SET TAGS ('dbx_business_glossary_term' = 'Channel Type');
ALTER TABLE `vibe_restaurants_v1`.`order`.`channel` ALTER COLUMN `channel_type` SET TAGS ('dbx_value_regex' = 'owned|third_party|hybrid');
ALTER TABLE `vibe_restaurants_v1`.`order`.`channel` ALTER COLUMN `channel_code` SET TAGS ('dbx_business_glossary_term' = 'Channel Code');
ALTER TABLE `vibe_restaurants_v1`.`order`.`channel` ALTER COLUMN `channel_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,10}$');
ALTER TABLE `vibe_restaurants_v1`.`order`.`channel` ALTER COLUMN `commission_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Commission Rate Percentage');
ALTER TABLE `vibe_restaurants_v1`.`order`.`channel` ALTER COLUMN `commission_rate_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`channel` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`order`.`channel` ALTER COLUMN `deactivation_date` SET TAGS ('dbx_business_glossary_term' = 'Deactivation Date');
ALTER TABLE `vibe_restaurants_v1`.`order`.`channel` ALTER COLUMN `default_daypart` SET TAGS ('dbx_business_glossary_term' = 'Default Daypart');
ALTER TABLE `vibe_restaurants_v1`.`order`.`channel` ALTER COLUMN `channel_description` SET TAGS ('dbx_business_glossary_term' = 'Channel Description');
ALTER TABLE `vibe_restaurants_v1`.`order`.`channel` ALTER COLUMN `display_order` SET TAGS ('dbx_business_glossary_term' = 'Display Order');
ALTER TABLE `vibe_restaurants_v1`.`order`.`channel` ALTER COLUMN `fulfillment_mode` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Mode');
ALTER TABLE `vibe_restaurants_v1`.`order`.`channel` ALTER COLUMN `fulfillment_mode` SET TAGS ('dbx_value_regex' = 'dine_in|takeout|delivery|curbside|catering');
ALTER TABLE `vibe_restaurants_v1`.`order`.`channel` ALTER COLUMN `integration_platform` SET TAGS ('dbx_business_glossary_term' = 'Integration Platform');
ALTER TABLE `vibe_restaurants_v1`.`order`.`channel` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_restaurants_v1`.`order`.`channel` ALTER COLUMN `is_digital` SET TAGS ('dbx_business_glossary_term' = 'Is Digital Channel');
ALTER TABLE `vibe_restaurants_v1`.`order`.`channel` ALTER COLUMN `kds_routing_enabled` SET TAGS ('dbx_business_glossary_term' = 'Kitchen Display System (KDS) Routing Enabled');
ALTER TABLE `vibe_restaurants_v1`.`order`.`channel` ALTER COLUMN `channel_name` SET TAGS ('dbx_business_glossary_term' = 'Channel Name');
ALTER TABLE `vibe_restaurants_v1`.`order`.`channel` ALTER COLUMN `requires_restaurant_assignment` SET TAGS ('dbx_business_glossary_term' = 'Requires Restaurant Assignment');
ALTER TABLE `vibe_restaurants_v1`.`order`.`channel` ALTER COLUMN `supports_guest_data_capture` SET TAGS ('dbx_business_glossary_term' = 'Supports Guest Data Capture');
ALTER TABLE `vibe_restaurants_v1`.`order`.`channel` ALTER COLUMN `supports_loyalty_integration` SET TAGS ('dbx_business_glossary_term' = 'Supports Loyalty Integration');
ALTER TABLE `vibe_restaurants_v1`.`order`.`channel` ALTER COLUMN `supports_payment_at_order` SET TAGS ('dbx_business_glossary_term' = 'Supports Payment at Order');
ALTER TABLE `vibe_restaurants_v1`.`order`.`channel` ALTER COLUMN `supports_scheduled_orders` SET TAGS ('dbx_business_glossary_term' = 'Supports Scheduled Orders');
ALTER TABLE `vibe_restaurants_v1`.`order`.`channel` ALTER COLUMN `target_sos_seconds` SET TAGS ('dbx_business_glossary_term' = 'Target Speed of Service (SOS) in Seconds');
ALTER TABLE `vibe_restaurants_v1`.`order`.`channel` ALTER COLUMN `third_party_provider` SET TAGS ('dbx_business_glossary_term' = 'Third-Party Delivery (3PD) Provider');
ALTER TABLE `vibe_restaurants_v1`.`order`.`channel` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`order`.`daypart` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_restaurants_v1`.`order`.`daypart` SET TAGS ('dbx_subdomain' = 'service_reference');
ALTER TABLE `vibe_restaurants_v1`.`order`.`daypart` ALTER COLUMN `daypart_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Key for order_daypart');
ALTER TABLE `vibe_restaurants_v1`.`order`.`daypart` ALTER COLUMN `guest_order_id` SET TAGS ('dbx_business_glossary_term' = 'Order Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`order`.`kds_ticket` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`order`.`kds_ticket` SET TAGS ('dbx_subdomain' = 'fulfillment_operations');
ALTER TABLE `vibe_restaurants_v1`.`order`.`kds_ticket` ALTER COLUMN `kds_ticket_id` SET TAGS ('dbx_business_glossary_term' = 'Kitchen Display System (KDS) Ticket ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`kds_ticket` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`kds_ticket` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`kds_ticket` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`kds_ticket` ALTER COLUMN `guest_order_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`kds_ticket` ALTER COLUMN `kitchen_station_id` SET TAGS ('dbx_business_glossary_term' = 'Kitchen Station ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`kds_ticket` ALTER COLUMN `shift_id` SET TAGS ('dbx_business_glossary_term' = 'Shift ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`kds_ticket` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`kds_ticket` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`order`.`kds_ticket` ALTER COLUMN `daypart` SET TAGS ('dbx_business_glossary_term' = 'Daypart');
ALTER TABLE `vibe_restaurants_v1`.`order`.`kds_ticket` ALTER COLUMN `daypart` SET TAGS ('dbx_value_regex' = 'breakfast|lunch|dinner|late_night|snack');
ALTER TABLE `vibe_restaurants_v1`.`order`.`kds_ticket` ALTER COLUMN `item_count` SET TAGS ('dbx_business_glossary_term' = 'Item Count');
ALTER TABLE `vibe_restaurants_v1`.`order`.`kds_ticket` ALTER COLUMN `modifier_count` SET TAGS ('dbx_business_glossary_term' = 'Modifier Count');
ALTER TABLE `vibe_restaurants_v1`.`order`.`kds_ticket` ALTER COLUMN `order_channel` SET TAGS ('dbx_business_glossary_term' = 'Order Channel');
ALTER TABLE `vibe_restaurants_v1`.`order`.`kds_ticket` ALTER COLUMN `order_channel` SET TAGS ('dbx_value_regex' = 'dine_in|drive_thru|online|third_party_delivery|catering|kiosk');
ALTER TABLE `vibe_restaurants_v1`.`order`.`kds_ticket` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_restaurants_v1`.`order`.`kds_ticket` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'standard|rush|vip|catering');
ALTER TABLE `vibe_restaurants_v1`.`order`.`kds_ticket` ALTER COLUMN `re_fire_count` SET TAGS ('dbx_business_glossary_term' = 'Re-Fire Count');
ALTER TABLE `vibe_restaurants_v1`.`order`.`kds_ticket` ALTER COLUMN `re_fire_flag` SET TAGS ('dbx_business_glossary_term' = 'Re-Fire Flag');
ALTER TABLE `vibe_restaurants_v1`.`order`.`kds_ticket` ALTER COLUMN `re_fire_reason` SET TAGS ('dbx_business_glossary_term' = 'Re-Fire Reason');
ALTER TABLE `vibe_restaurants_v1`.`order`.`kds_ticket` ALTER COLUMN `sos_met_flag` SET TAGS ('dbx_business_glossary_term' = 'Speed of Service (SOS) Met Flag');
ALTER TABLE `vibe_restaurants_v1`.`order`.`kds_ticket` ALTER COLUMN `sos_target_seconds` SET TAGS ('dbx_business_glossary_term' = 'Speed of Service (SOS) Target (Seconds)');
ALTER TABLE `vibe_restaurants_v1`.`order`.`kds_ticket` ALTER COLUMN `special_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Instructions');
ALTER TABLE `vibe_restaurants_v1`.`order`.`kds_ticket` ALTER COLUMN `ticket_bumped_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Ticket Bumped Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`order`.`kds_ticket` ALTER COLUMN `ticket_completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Ticket Completed Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`order`.`kds_ticket` ALTER COLUMN `ticket_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Ticket Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`order`.`kds_ticket` ALTER COLUMN `ticket_number` SET TAGS ('dbx_business_glossary_term' = 'Ticket Number');
ALTER TABLE `vibe_restaurants_v1`.`order`.`kds_ticket` ALTER COLUMN `ticket_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `vibe_restaurants_v1`.`order`.`kds_ticket` ALTER COLUMN `ticket_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Ticket Sequence Number');
ALTER TABLE `vibe_restaurants_v1`.`order`.`kds_ticket` ALTER COLUMN `ticket_started_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Ticket Started Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`order`.`kds_ticket` ALTER COLUMN `ticket_status` SET TAGS ('dbx_business_glossary_term' = 'Ticket Status');
ALTER TABLE `vibe_restaurants_v1`.`order`.`kds_ticket` ALTER COLUMN `ticket_status` SET TAGS ('dbx_value_regex' = 'new|in_progress|completed|bumped|voided|re_fired');
ALTER TABLE `vibe_restaurants_v1`.`order`.`kds_ticket` ALTER COLUMN `ticket_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Ticket Time (Seconds)');
ALTER TABLE `vibe_restaurants_v1`.`order`.`kds_ticket` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`order`.`kds_ticket` ALTER COLUMN `void_flag` SET TAGS ('dbx_business_glossary_term' = 'Void Flag');
ALTER TABLE `vibe_restaurants_v1`.`order`.`kds_ticket` ALTER COLUMN `void_reason` SET TAGS ('dbx_business_glossary_term' = 'Void Reason');
ALTER TABLE `vibe_restaurants_v1`.`order`.`drive_thru_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`order`.`drive_thru_event` SET TAGS ('dbx_subdomain' = 'fulfillment_operations');
ALTER TABLE `vibe_restaurants_v1`.`order`.`drive_thru_event` ALTER COLUMN `drive_thru_event_id` SET TAGS ('dbx_business_glossary_term' = 'Drive-Thru (DT) Event ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`drive_thru_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`drive_thru_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`drive_thru_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`drive_thru_event` ALTER COLUMN `guest_order_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`drive_thru_event` ALTER COLUMN `pos_terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Point of Sale (POS) Terminal ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`drive_thru_event` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`drive_thru_event` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`drive_thru_event` ALTER COLUMN `business_date` SET TAGS ('dbx_business_glossary_term' = 'Business Date');
ALTER TABLE `vibe_restaurants_v1`.`order`.`drive_thru_event` ALTER COLUMN `cumulative_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Time (Seconds)');
ALTER TABLE `vibe_restaurants_v1`.`order`.`drive_thru_event` ALTER COLUMN `daypart` SET TAGS ('dbx_business_glossary_term' = 'Daypart');
ALTER TABLE `vibe_restaurants_v1`.`order`.`drive_thru_event` ALTER COLUMN `daypart` SET TAGS ('dbx_value_regex' = 'breakfast|lunch|afternoon|dinner|late_night');
ALTER TABLE `vibe_restaurants_v1`.`order`.`drive_thru_event` ALTER COLUMN `elapsed_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Elapsed Time (Seconds)');
ALTER TABLE `vibe_restaurants_v1`.`order`.`drive_thru_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`order`.`drive_thru_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type');
ALTER TABLE `vibe_restaurants_v1`.`order`.`drive_thru_event` ALTER COLUMN `exception_flag` SET TAGS ('dbx_business_glossary_term' = 'Exception Flag');
ALTER TABLE `vibe_restaurants_v1`.`order`.`drive_thru_event` ALTER COLUMN `exception_reason` SET TAGS ('dbx_business_glossary_term' = 'Exception Reason');
ALTER TABLE `vibe_restaurants_v1`.`order`.`drive_thru_event` ALTER COLUMN `franchise_flag` SET TAGS ('dbx_business_glossary_term' = 'Franchise Flag');
ALTER TABLE `vibe_restaurants_v1`.`order`.`drive_thru_event` ALTER COLUMN `kds_ticket_number` SET TAGS ('dbx_business_glossary_term' = 'Kitchen Display System (KDS) Ticket Number');
ALTER TABLE `vibe_restaurants_v1`.`order`.`drive_thru_event` ALTER COLUMN `lane_number` SET TAGS ('dbx_business_glossary_term' = 'Lane Number');
ALTER TABLE `vibe_restaurants_v1`.`order`.`drive_thru_event` ALTER COLUMN `order_channel` SET TAGS ('dbx_business_glossary_term' = 'Order Channel');
ALTER TABLE `vibe_restaurants_v1`.`order`.`drive_thru_event` ALTER COLUMN `order_channel` SET TAGS ('dbx_value_regex' = 'drive_thru|mobile_order_ahead|third_party_delivery');
ALTER TABLE `vibe_restaurants_v1`.`order`.`drive_thru_event` ALTER COLUMN `order_item_count` SET TAGS ('dbx_business_glossary_term' = 'Order Item Count');
ALTER TABLE `vibe_restaurants_v1`.`order`.`drive_thru_event` ALTER COLUMN `order_total_amount` SET TAGS ('dbx_business_glossary_term' = 'Order Total Amount');
ALTER TABLE `vibe_restaurants_v1`.`order`.`drive_thru_event` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_restaurants_v1`.`order`.`drive_thru_event` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'cash|credit_card|debit_card|mobile_payment|gift_card');
ALTER TABLE `vibe_restaurants_v1`.`order`.`drive_thru_event` ALTER COLUMN `pull_forward_flag` SET TAGS ('dbx_business_glossary_term' = 'Pull Forward Flag');
ALTER TABLE `vibe_restaurants_v1`.`order`.`drive_thru_event` ALTER COLUMN `queue_length` SET TAGS ('dbx_business_glossary_term' = 'Queue Length');
ALTER TABLE `vibe_restaurants_v1`.`order`.`drive_thru_event` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`order`.`drive_thru_event` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`order`.`drive_thru_event` ALTER COLUMN `sensor_code` SET TAGS ('dbx_business_glossary_term' = 'Sensor ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`drive_thru_event` ALTER COLUMN `sos_target_seconds` SET TAGS ('dbx_business_glossary_term' = 'Speed of Service (SOS) Target (Seconds)');
ALTER TABLE `vibe_restaurants_v1`.`order`.`drive_thru_event` ALTER COLUMN `sos_variance_seconds` SET TAGS ('dbx_business_glossary_term' = 'Speed of Service (SOS) Variance (Seconds)');
ALTER TABLE `vibe_restaurants_v1`.`order`.`drive_thru_event` ALTER COLUMN `vehicle_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Sequence Number');
ALTER TABLE `vibe_restaurants_v1`.`order`.`drive_thru_event` ALTER COLUMN `weather_condition` SET TAGS ('dbx_business_glossary_term' = 'Weather Condition');
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_order` SET TAGS ('dbx_subdomain' = 'fulfillment_operations');
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_order` ALTER COLUMN `delivery_order_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Order ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_order` ALTER COLUMN `delivery_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Platform ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Courier ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_order` ALTER COLUMN `guest_order_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_order` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_order` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_order` ALTER COLUMN `actual_delivery_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Time (Minutes)');
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_order` ALTER COLUMN `actual_delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_order` ALTER COLUMN `actual_prep_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Actual Preparation Time (Minutes)');
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_order` ALTER COLUMN `customer_feedback` SET TAGS ('dbx_business_glossary_term' = 'Customer Feedback');
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_order` ALTER COLUMN `customer_rating` SET TAGS ('dbx_business_glossary_term' = 'Customer Rating');
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_order` ALTER COLUMN `delivery_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Delivery Address Line 1');
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_order` ALTER COLUMN `delivery_address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_order` ALTER COLUMN `delivery_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_order` ALTER COLUMN `delivery_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Delivery Address Line 2');
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_order` ALTER COLUMN `delivery_address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_order` ALTER COLUMN `delivery_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_order` ALTER COLUMN `delivery_city` SET TAGS ('dbx_business_glossary_term' = 'Delivery City');
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_order` ALTER COLUMN `delivery_city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_order` ALTER COLUMN `delivery_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_order` ALTER COLUMN `delivery_country_code` SET TAGS ('dbx_business_glossary_term' = 'Delivery Country Code');
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_order` ALTER COLUMN `delivery_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_order` ALTER COLUMN `delivery_distance_km` SET TAGS ('dbx_business_glossary_term' = 'Delivery Distance (Kilometers)');
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_order` ALTER COLUMN `delivery_exception_type` SET TAGS ('dbx_business_glossary_term' = 'Delivery Exception Type');
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_order` ALTER COLUMN `delivery_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Delivery Fee Amount');
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_order` ALTER COLUMN `delivery_instructions` SET TAGS ('dbx_business_glossary_term' = 'Delivery Instructions');
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_order` ALTER COLUMN `delivery_instructions` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_order` ALTER COLUMN `delivery_instructions` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_order` ALTER COLUMN `delivery_latitude` SET TAGS ('dbx_business_glossary_term' = 'Delivery Latitude');
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_order` ALTER COLUMN `delivery_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_order` ALTER COLUMN `delivery_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_order` ALTER COLUMN `delivery_longitude` SET TAGS ('dbx_business_glossary_term' = 'Delivery Longitude');
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_order` ALTER COLUMN `delivery_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_order` ALTER COLUMN `delivery_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_order` ALTER COLUMN `delivery_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Delivery Postal Code');
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_order` ALTER COLUMN `delivery_postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_order` ALTER COLUMN `delivery_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_order` ALTER COLUMN `delivery_state_province` SET TAGS ('dbx_business_glossary_term' = 'Delivery State or Province');
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_order` ALTER COLUMN `delivery_state_province` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_order` ALTER COLUMN `delivery_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_order` ALTER COLUMN `delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Delivery Status');
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_order` ALTER COLUMN `estimated_delivery_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Estimated Delivery Time (Minutes)');
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_order` ALTER COLUMN `estimated_delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Estimated Delivery Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_order` ALTER COLUMN `estimated_prep_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Estimated Preparation Time (Minutes)');
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_order` ALTER COLUMN `exception_notes` SET TAGS ('dbx_business_glossary_term' = 'Exception Notes');
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_order` ALTER COLUMN `is_contactless_delivery` SET TAGS ('dbx_business_glossary_term' = 'Is Contactless Delivery');
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_order` ALTER COLUMN `order_confirmed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Order Confirmed Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_order` ALTER COLUMN `order_placed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Order Placed Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_order` ALTER COLUMN `picked_up_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Picked Up Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_order` ALTER COLUMN `platform_commission_amount` SET TAGS ('dbx_business_glossary_term' = 'Third-Party Delivery (3PD) Platform Commission Amount');
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_order` ALTER COLUMN `platform_commission_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_order` ALTER COLUMN `platform_commission_rate` SET TAGS ('dbx_business_glossary_term' = 'Third-Party Delivery (3PD) Platform Commission Rate');
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_order` ALTER COLUMN `platform_commission_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_order` ALTER COLUMN `platform_order_reference` SET TAGS ('dbx_business_glossary_term' = 'Third-Party Delivery (3PD) Platform Order Reference');
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_order` ALTER COLUMN `proof_of_delivery_url` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery URL');
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_order` ALTER COLUMN `ready_for_pickup_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Ready for Pickup Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_order` ALTER COLUMN `tip_amount` SET TAGS ('dbx_business_glossary_term' = 'Tip Amount');
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_order` ALTER COLUMN `total_ticket_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Total Ticket Time (Minutes)');
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_order` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_order` SET TAGS ('dbx_subdomain' = 'fulfillment_operations');
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_order` ALTER COLUMN `catering_order_id` SET TAGS ('dbx_business_glossary_term' = 'Catering Order ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_order` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_order` ALTER COLUMN `catering_package_id` SET TAGS ('dbx_business_glossary_term' = 'Catering Package ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_order` ALTER COLUMN `catering_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_order` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative Employee ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_order` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_order` ALTER COLUMN `balance_due` SET TAGS ('dbx_business_glossary_term' = 'Balance Due');
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_order` ALTER COLUMN `cancelled_at` SET TAGS ('dbx_business_glossary_term' = 'Cancelled Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_order` ALTER COLUMN `catering_order_number` SET TAGS ('dbx_business_glossary_term' = 'Catering Order Number');
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_order` ALTER COLUMN `catering_order_number` SET TAGS ('dbx_value_regex' = '^CAT-[0-9]{8,12}$');
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_order` ALTER COLUMN `confirmed_at` SET TAGS ('dbx_business_glossary_term' = 'Order Confirmed Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_order` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Event Contact Email');
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_order` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_order` ALTER COLUMN `contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_order` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_order` ALTER COLUMN `contact_name` SET TAGS ('dbx_business_glossary_term' = 'Event Contact Name');
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_order` ALTER COLUMN `contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_order` ALTER COLUMN `contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_order` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Event Contact Phone');
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_order` ALTER COLUMN `contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_order` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_order` ALTER COLUMN `created_at` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_order` ALTER COLUMN `delivery_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Delivery Address Line 1');
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_order` ALTER COLUMN `delivery_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_order` ALTER COLUMN `delivery_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_order` ALTER COLUMN `delivery_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Delivery Address Line 2');
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_order` ALTER COLUMN `delivery_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_order` ALTER COLUMN `delivery_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_order` ALTER COLUMN `delivery_city` SET TAGS ('dbx_business_glossary_term' = 'Delivery City');
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_order` ALTER COLUMN `delivery_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_order` ALTER COLUMN `delivery_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_order` ALTER COLUMN `delivery_country_code` SET TAGS ('dbx_business_glossary_term' = 'Delivery Country Code');
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_order` ALTER COLUMN `delivery_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_order` ALTER COLUMN `delivery_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Delivery Postal Code');
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_order` ALTER COLUMN `delivery_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_order` ALTER COLUMN `delivery_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_order` ALTER COLUMN `delivery_state_province` SET TAGS ('dbx_business_glossary_term' = 'Delivery State or Province');
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_order` ALTER COLUMN `deposit_amount` SET TAGS ('dbx_business_glossary_term' = 'Deposit Amount');
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_order` ALTER COLUMN `dietary_accommodations` SET TAGS ('dbx_business_glossary_term' = 'Dietary Accommodations');
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_order` ALTER COLUMN `event_date` SET TAGS ('dbx_business_glossary_term' = 'Catering Event Date');
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_order` ALTER COLUMN `event_start_time` SET TAGS ('dbx_business_glossary_term' = 'Event Start Time');
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_order` ALTER COLUMN `fulfilled_at` SET TAGS ('dbx_business_glossary_term' = 'Fulfilled Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_order` ALTER COLUMN `fulfillment_mode` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Mode');
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_order` ALTER COLUMN `fulfillment_mode` SET TAGS ('dbx_value_regex' = 'delivery|pickup|on_site_service');
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_order` ALTER COLUMN `gratuity_amount` SET TAGS ('dbx_business_glossary_term' = 'Gratuity Amount');
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_order` ALTER COLUMN `headcount` SET TAGS ('dbx_business_glossary_term' = 'Guest Headcount');
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_order` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_order` ALTER COLUMN `order_channel` SET TAGS ('dbx_business_glossary_term' = 'Order Channel');
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_order` ALTER COLUMN `order_channel` SET TAGS ('dbx_value_regex' = 'phone|web|mobile_app|in_store|sales_rep');
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Catering Order Status');
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_order` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_order` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'credit_card|debit_card|corporate_account|invoice|cash|check');
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_order` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_order` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'pending|deposit_paid|paid_in_full|refunded|cancelled');
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_order` ALTER COLUMN `placed_at` SET TAGS ('dbx_business_glossary_term' = 'Order Placed Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_order` ALTER COLUMN `quoted_price` SET TAGS ('dbx_business_glossary_term' = 'Quoted Price');
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_order` ALTER COLUMN `setup_instructions` SET TAGS ('dbx_business_glossary_term' = 'Setup Instructions');
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_order` ALTER COLUMN `setup_required` SET TAGS ('dbx_business_glossary_term' = 'Setup Required Flag');
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_order` ALTER COLUMN `special_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Instructions');
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_order` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_order` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Amount');
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_order` ALTER COLUMN `updated_at` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`order`.`discount` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`order`.`discount` SET TAGS ('dbx_subdomain' = 'transaction_core');
ALTER TABLE `vibe_restaurants_v1`.`order`.`discount` ALTER COLUMN `discount_id` SET TAGS ('dbx_business_glossary_term' = 'Order Discount ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`discount` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Authorization Employee ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`discount` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`discount` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`discount` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Discount Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`order`.`discount` ALTER COLUMN `guest_order_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Order ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`discount` ALTER COLUMN `menu_item_id` SET TAGS ('dbx_business_glossary_term' = 'Menu Item ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`discount` ALTER COLUMN `pos_terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Point of Sale (POS) Terminal ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`discount` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Profile Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`order`.`discount` ALTER COLUMN `promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`discount` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`discount` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`discount` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `vibe_restaurants_v1`.`order`.`discount` ALTER COLUMN `applied_at` SET TAGS ('dbx_business_glossary_term' = 'Applied At Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`order`.`discount` ALTER COLUMN `authorization_required` SET TAGS ('dbx_business_glossary_term' = 'Authorization Required Flag');
ALTER TABLE `vibe_restaurants_v1`.`order`.`discount` ALTER COLUMN `channel_restriction` SET TAGS ('dbx_business_glossary_term' = 'Channel Restriction');
ALTER TABLE `vibe_restaurants_v1`.`order`.`discount` ALTER COLUMN `discount_code` SET TAGS ('dbx_business_glossary_term' = 'Discount Code');
ALTER TABLE `vibe_restaurants_v1`.`order`.`discount` ALTER COLUMN `cogs_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost of Goods Sold (COGS) Impact Amount');
ALTER TABLE `vibe_restaurants_v1`.`order`.`discount` ALTER COLUMN `cogs_impact_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`discount` ALTER COLUMN `created_at` SET TAGS ('dbx_business_glossary_term' = 'Created At Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`order`.`discount` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`order`.`discount` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_restaurants_v1`.`order`.`discount` ALTER COLUMN `daypart_restriction` SET TAGS ('dbx_business_glossary_term' = 'Daypart Restriction');
ALTER TABLE `vibe_restaurants_v1`.`order`.`discount` ALTER COLUMN `discount_type` SET TAGS ('dbx_business_glossary_term' = 'Discount Type');
ALTER TABLE `vibe_restaurants_v1`.`order`.`discount` ALTER COLUMN `discount_type` SET TAGS ('dbx_value_regex' = 'coupon|loyalty_redemption|employee_meal|manager_comp|promotional_lto|bundle_deal');
ALTER TABLE `vibe_restaurants_v1`.`order`.`discount` ALTER COLUMN `final_price` SET TAGS ('dbx_business_glossary_term' = 'Final Price');
ALTER TABLE `vibe_restaurants_v1`.`order`.`discount` ALTER COLUMN `is_pre_approved` SET TAGS ('dbx_business_glossary_term' = 'Pre-Approved Discount Flag');
ALTER TABLE `vibe_restaurants_v1`.`order`.`discount` ALTER COLUMN `is_stackable` SET TAGS ('dbx_business_glossary_term' = 'Stackable Discount Flag');
ALTER TABLE `vibe_restaurants_v1`.`order`.`discount` ALTER COLUMN `is_voided` SET TAGS ('dbx_business_glossary_term' = 'Voided Flag');
ALTER TABLE `vibe_restaurants_v1`.`order`.`discount` ALTER COLUMN `loyalty_points_redeemed` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Redeemed');
ALTER TABLE `vibe_restaurants_v1`.`order`.`discount` ALTER COLUMN `max_discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Discount Amount');
ALTER TABLE `vibe_restaurants_v1`.`order`.`discount` ALTER COLUMN `min_purchase_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Purchase Amount');
ALTER TABLE `vibe_restaurants_v1`.`order`.`discount` ALTER COLUMN `discount_name` SET TAGS ('dbx_business_glossary_term' = 'Discount Name');
ALTER TABLE `vibe_restaurants_v1`.`order`.`discount` ALTER COLUMN `original_price` SET TAGS ('dbx_business_glossary_term' = 'Original Price');
ALTER TABLE `vibe_restaurants_v1`.`order`.`discount` ALTER COLUMN `percentage` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `vibe_restaurants_v1`.`order`.`discount` ALTER COLUMN `reason` SET TAGS ('dbx_business_glossary_term' = 'Discount Reason');
ALTER TABLE `vibe_restaurants_v1`.`order`.`discount` ALTER COLUMN `revenue_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Revenue Impact Amount');
ALTER TABLE `vibe_restaurants_v1`.`order`.`discount` ALTER COLUMN `revenue_impact_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`discount` ALTER COLUMN `scope` SET TAGS ('dbx_business_glossary_term' = 'Discount Scope');
ALTER TABLE `vibe_restaurants_v1`.`order`.`discount` ALTER COLUMN `scope` SET TAGS ('dbx_value_regex' = 'order_level|item_level|category_level|combo_level');
ALTER TABLE `vibe_restaurants_v1`.`order`.`discount` ALTER COLUMN `tax_treatment` SET TAGS ('dbx_business_glossary_term' = 'Tax Treatment');
ALTER TABLE `vibe_restaurants_v1`.`order`.`discount` ALTER COLUMN `tax_treatment` SET TAGS ('dbx_value_regex' = 'pre_tax|post_tax|tax_exempt');
ALTER TABLE `vibe_restaurants_v1`.`order`.`discount` ALTER COLUMN `tax_treatment` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`discount` ALTER COLUMN `tax_treatment` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`discount` ALTER COLUMN `updated_at` SET TAGS ('dbx_business_glossary_term' = 'Updated At Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`order`.`discount` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date');
ALTER TABLE `vibe_restaurants_v1`.`order`.`discount` ALTER COLUMN `valid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Valid To Date');
ALTER TABLE `vibe_restaurants_v1`.`order`.`discount` ALTER COLUMN `void_reason` SET TAGS ('dbx_business_glossary_term' = 'Void Reason');
ALTER TABLE `vibe_restaurants_v1`.`order`.`discount` ALTER COLUMN `voided_at` SET TAGS ('dbx_business_glossary_term' = 'Voided At Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`order`.`refund` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`order`.`refund` SET TAGS ('dbx_subdomain' = 'transaction_core');
ALTER TABLE `vibe_restaurants_v1`.`order`.`refund` ALTER COLUMN `refund_id` SET TAGS ('dbx_business_glossary_term' = 'Order Refund ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`refund` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Authorizing Manager ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`refund` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`refund` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`refund` ALTER COLUMN `employee_id` SET TAGS ('dbx_renamed_from' = 'employee_id');
ALTER TABLE `vibe_restaurants_v1`.`order`.`refund` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Refund Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`order`.`refund` ALTER COLUMN `guest_order_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Order ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`refund` ALTER COLUMN `pos_terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Point of Sale (POS) Terminal ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`refund` ALTER COLUMN `primary_refund_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Authorizing Manager ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`refund` ALTER COLUMN `primary_refund_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`refund` ALTER COLUMN `primary_refund_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`refund` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`refund` ALTER COLUMN `refund_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`refund` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`refund` ALTER COLUMN `tertiary_refund_voided_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Voided By Employee ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`refund` ALTER COLUMN `tertiary_refund_voided_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`refund` ALTER COLUMN `tertiary_refund_voided_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`refund` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`refund` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Refund Amount');
ALTER TABLE `vibe_restaurants_v1`.`order`.`refund` ALTER COLUMN `approved_at` SET TAGS ('dbx_business_glossary_term' = 'Approved At Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`order`.`refund` ALTER COLUMN `batch_code` SET TAGS ('dbx_business_glossary_term' = 'Refund Batch ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`refund` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Refund Channel');
ALTER TABLE `vibe_restaurants_v1`.`order`.`refund` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'pos|online|mobile_app|call_center|third_party_delivery');
ALTER TABLE `vibe_restaurants_v1`.`order`.`refund` ALTER COLUMN `created_at` SET TAGS ('dbx_business_glossary_term' = 'Created At Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`order`.`refund` ALTER COLUMN `csat_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Satisfaction (CSAT) Impact Flag');
ALTER TABLE `vibe_restaurants_v1`.`order`.`refund` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`order`.`refund` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_restaurants_v1`.`order`.`refund` ALTER COLUMN `daypart` SET TAGS ('dbx_business_glossary_term' = 'Daypart');
ALTER TABLE `vibe_restaurants_v1`.`order`.`refund` ALTER COLUMN `daypart` SET TAGS ('dbx_value_regex' = 'breakfast|lunch|dinner|late_night|snack');
ALTER TABLE `vibe_restaurants_v1`.`order`.`refund` ALTER COLUMN `fraud_review_notes` SET TAGS ('dbx_business_glossary_term' = 'Fraud Review Notes');
ALTER TABLE `vibe_restaurants_v1`.`order`.`refund` ALTER COLUMN `gl_posting_date` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Posting Date');
ALTER TABLE `vibe_restaurants_v1`.`order`.`refund` ALTER COLUMN `guest_contact_method` SET TAGS ('dbx_business_glossary_term' = 'Guest Contact Method');
ALTER TABLE `vibe_restaurants_v1`.`order`.`refund` ALTER COLUMN `guest_contact_method` SET TAGS ('dbx_value_regex' = 'in_person|phone|email|chat|mobile_app');
ALTER TABLE `vibe_restaurants_v1`.`order`.`refund` ALTER COLUMN `is_fraudulent` SET TAGS ('dbx_business_glossary_term' = 'Is Fraudulent Flag');
ALTER TABLE `vibe_restaurants_v1`.`order`.`refund` ALTER COLUMN `is_voided` SET TAGS ('dbx_business_glossary_term' = 'Is Voided Flag');
ALTER TABLE `vibe_restaurants_v1`.`order`.`refund` ALTER COLUMN `loyalty_points_refunded` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Refunded');
ALTER TABLE `vibe_restaurants_v1`.`order`.`refund` ALTER COLUMN `method` SET TAGS ('dbx_business_glossary_term' = 'Refund Method');
ALTER TABLE `vibe_restaurants_v1`.`order`.`refund` ALTER COLUMN `method` SET TAGS ('dbx_value_regex' = 'original_tender|cash|gift_card|loyalty_points|store_credit|check');
ALTER TABLE `vibe_restaurants_v1`.`order`.`refund` ALTER COLUMN `nps_survey_sent` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS) Survey Sent Flag');
ALTER TABLE `vibe_restaurants_v1`.`order`.`refund` ALTER COLUMN `order_channel` SET TAGS ('dbx_business_glossary_term' = 'Order Channel');
ALTER TABLE `vibe_restaurants_v1`.`order`.`refund` ALTER COLUMN `order_channel` SET TAGS ('dbx_value_regex' = 'dine_in|drive_thru|takeout|delivery|curbside|catering');
ALTER TABLE `vibe_restaurants_v1`.`order`.`refund` ALTER COLUMN `original_payment_method` SET TAGS ('dbx_business_glossary_term' = 'Original Payment Method');
ALTER TABLE `vibe_restaurants_v1`.`order`.`refund` ALTER COLUMN `original_payment_method` SET TAGS ('dbx_value_regex' = 'credit_card|debit_card|cash|gift_card|mobile_payment|loyalty_points');
ALTER TABLE `vibe_restaurants_v1`.`order`.`refund` ALTER COLUMN `payment_processor_ref` SET TAGS ('dbx_business_glossary_term' = 'Payment Processor Reference');
ALTER TABLE `vibe_restaurants_v1`.`order`.`refund` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Refund Reason Code');
ALTER TABLE `vibe_restaurants_v1`.`order`.`refund` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Refund Reason Description');
ALTER TABLE `vibe_restaurants_v1`.`order`.`refund` ALTER COLUMN `refund_number` SET TAGS ('dbx_business_glossary_term' = 'Refund Number');
ALTER TABLE `vibe_restaurants_v1`.`order`.`refund` ALTER COLUMN `refund_number` SET TAGS ('dbx_value_regex' = '^RF[0-9]{10,12}$');
ALTER TABLE `vibe_restaurants_v1`.`order`.`refund` ALTER COLUMN `refund_status` SET TAGS ('dbx_business_glossary_term' = 'Refund Status');
ALTER TABLE `vibe_restaurants_v1`.`order`.`refund` ALTER COLUMN `refund_status` SET TAGS ('dbx_value_regex' = 'pending|approved|completed|rejected|reversed|cancelled');
ALTER TABLE `vibe_restaurants_v1`.`order`.`refund` ALTER COLUMN `refund_type` SET TAGS ('dbx_business_glossary_term' = 'Refund Type');
ALTER TABLE `vibe_restaurants_v1`.`order`.`refund` ALTER COLUMN `refund_type` SET TAGS ('dbx_value_regex' = 'full|partial|item_level|order_level');
ALTER TABLE `vibe_restaurants_v1`.`order`.`refund` ALTER COLUMN `refunded_at` SET TAGS ('dbx_business_glossary_term' = 'Refunded At Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`order`.`refund` ALTER COLUMN `requested_at` SET TAGS ('dbx_business_glossary_term' = 'Requested At Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`order`.`refund` ALTER COLUMN `subtotal` SET TAGS ('dbx_business_glossary_term' = 'Refund Subtotal');
ALTER TABLE `vibe_restaurants_v1`.`order`.`refund` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Refund Tax Amount');
ALTER TABLE `vibe_restaurants_v1`.`order`.`refund` ALTER COLUMN `third_party_delivery_provider` SET TAGS ('dbx_business_glossary_term' = 'Third-Party Delivery (3PD) Provider');
ALTER TABLE `vibe_restaurants_v1`.`order`.`refund` ALTER COLUMN `updated_at` SET TAGS ('dbx_business_glossary_term' = 'Updated At Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`order`.`refund` ALTER COLUMN `void_reason` SET TAGS ('dbx_business_glossary_term' = 'Void Reason');
ALTER TABLE `vibe_restaurants_v1`.`order`.`refund` ALTER COLUMN `voided_at` SET TAGS ('dbx_business_glossary_term' = 'Voided At Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`order`.`sos_target` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_restaurants_v1`.`order`.`sos_target` SET TAGS ('dbx_subdomain' = 'service_reference');
ALTER TABLE `vibe_restaurants_v1`.`order`.`sos_target` ALTER COLUMN `sos_target_id` SET TAGS ('dbx_business_glossary_term' = 'Speed of Service (SOS) Target ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`sos_target` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`sos_target` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`sos_target` ALTER COLUMN `superseded_by_target_sos_target_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Target ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`sos_target` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`sos_target` ALTER COLUMN `applies_to_order_type` SET TAGS ('dbx_business_glossary_term' = 'Applies to Order Type');
ALTER TABLE `vibe_restaurants_v1`.`order`.`sos_target` ALTER COLUMN `applies_to_order_type` SET TAGS ('dbx_value_regex' = 'dine_in|takeout|delivery|all');
ALTER TABLE `vibe_restaurants_v1`.`order`.`sos_target` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_restaurants_v1`.`order`.`sos_target` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`order`.`sos_target` ALTER COLUMN `compliance_threshold_percent` SET TAGS ('dbx_business_glossary_term' = 'Compliance Threshold Percentage');
ALTER TABLE `vibe_restaurants_v1`.`order`.`sos_target` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`order`.`sos_target` ALTER COLUMN `daypart` SET TAGS ('dbx_business_glossary_term' = 'Daypart');
ALTER TABLE `vibe_restaurants_v1`.`order`.`sos_target` ALTER COLUMN `daypart` SET TAGS ('dbx_value_regex' = 'breakfast|lunch|dinner|late_night|all_day');
ALTER TABLE `vibe_restaurants_v1`.`order`.`sos_target` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_restaurants_v1`.`order`.`sos_target` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_restaurants_v1`.`order`.`sos_target` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_restaurants_v1`.`order`.`sos_target` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_business_glossary_term' = 'Measurement Unit');
ALTER TABLE `vibe_restaurants_v1`.`order`.`sos_target` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_value_regex' = 'seconds|minutes');
ALTER TABLE `vibe_restaurants_v1`.`order`.`sos_target` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `vibe_restaurants_v1`.`order`.`sos_target` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`order`.`sos_target` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_restaurants_v1`.`order`.`sos_target` ALTER COLUMN `peak_hours_only` SET TAGS ('dbx_business_glossary_term' = 'Peak Hours Only');
ALTER TABLE `vibe_restaurants_v1`.`order`.`sos_target` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_restaurants_v1`.`order`.`sos_target` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_restaurants_v1`.`order`.`sos_target` ALTER COLUMN `restaurant_format` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Format');
ALTER TABLE `vibe_restaurants_v1`.`order`.`sos_target` ALTER COLUMN `restaurant_format` SET TAGS ('dbx_value_regex' = 'QSR|casual|fine_dining|fast_casual|food_court');
ALTER TABLE `vibe_restaurants_v1`.`order`.`sos_target` ALTER COLUMN `service_channel` SET TAGS ('dbx_business_glossary_term' = 'Service Channel');
ALTER TABLE `vibe_restaurants_v1`.`order`.`sos_target` ALTER COLUMN `service_channel` SET TAGS ('dbx_value_regex' = 'DT|counter|OLO|3PD|catering|kiosk');
ALTER TABLE `vibe_restaurants_v1`.`order`.`sos_target` ALTER COLUMN `target_code` SET TAGS ('dbx_business_glossary_term' = 'Speed of Service (SOS) Target Code');
ALTER TABLE `vibe_restaurants_v1`.`order`.`sos_target` ALTER COLUMN `target_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{3,20}$');
ALTER TABLE `vibe_restaurants_v1`.`order`.`sos_target` ALTER COLUMN `target_handoff_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Target Handoff Time (Seconds)');
ALTER TABLE `vibe_restaurants_v1`.`order`.`sos_target` ALTER COLUMN `target_name` SET TAGS ('dbx_business_glossary_term' = 'Speed of Service (SOS) Target Name');
ALTER TABLE `vibe_restaurants_v1`.`order`.`sos_target` ALTER COLUMN `target_queue_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Target Queue Time (Seconds)');
ALTER TABLE `vibe_restaurants_v1`.`order`.`sos_target` ALTER COLUMN `target_ticket_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Target Ticket Time (Seconds)');
ALTER TABLE `vibe_restaurants_v1`.`order`.`sos_target` ALTER COLUMN `target_total_order_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Target Total Order Time (Seconds)');
ALTER TABLE `vibe_restaurants_v1`.`order`.`sos_target` ALTER COLUMN `target_type` SET TAGS ('dbx_business_glossary_term' = 'Target Type');
ALTER TABLE `vibe_restaurants_v1`.`order`.`sos_target` ALTER COLUMN `target_type` SET TAGS ('dbx_value_regex' = 'brand_standard|local_goal|franchise_goal|regulatory');
ALTER TABLE `vibe_restaurants_v1`.`order`.`sos_target` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_restaurants_v1`.`order`.`sos_target` ALTER COLUMN `warning_threshold_percent` SET TAGS ('dbx_business_glossary_term' = 'Warning Threshold Percentage');
ALTER TABLE `vibe_restaurants_v1`.`order`.`sos_target` ALTER COLUMN `weather_adjusted` SET TAGS ('dbx_business_glossary_term' = 'Weather Adjusted');
ALTER TABLE `vibe_restaurants_v1`.`order`.`sos_target` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_restaurants_v1`.`order`.`tax` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`order`.`tax` SET TAGS ('dbx_subdomain' = 'transaction_core');
ALTER TABLE `vibe_restaurants_v1`.`order`.`tax` ALTER COLUMN `tax_id` SET TAGS ('dbx_business_glossary_term' = 'Order Tax ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`tax` ALTER COLUMN `tax_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`tax` ALTER COLUMN `tax_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`tax` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`order`.`tax` ALTER COLUMN `guest_order_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`tax` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`tax` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`tax` ALTER COLUMN `adjusted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Tax Adjusted Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`order`.`tax` ALTER COLUMN `adjustment_reason` SET TAGS ('dbx_business_glossary_term' = 'Tax Adjustment Reason');
ALTER TABLE `vibe_restaurants_v1`.`order`.`tax` ALTER COLUMN `adjustment_reason` SET TAGS ('dbx_value_regex' = 'rate_correction|jurisdiction_change|exemption_applied|refund|audit_correction|other');
ALTER TABLE `vibe_restaurants_v1`.`order`.`tax` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_restaurants_v1`.`order`.`tax` ALTER COLUMN `applied_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Tax Applied Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`order`.`tax` ALTER COLUMN `authority_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Authority Code');
ALTER TABLE `vibe_restaurants_v1`.`order`.`tax` ALTER COLUMN `authority_level` SET TAGS ('dbx_business_glossary_term' = 'Tax Authority Level');
ALTER TABLE `vibe_restaurants_v1`.`order`.`tax` ALTER COLUMN `authority_level` SET TAGS ('dbx_value_regex' = 'federal|state|county|city|district|special');
ALTER TABLE `vibe_restaurants_v1`.`order`.`tax` ALTER COLUMN `authority_name` SET TAGS ('dbx_business_glossary_term' = 'Tax Authority Name');
ALTER TABLE `vibe_restaurants_v1`.`order`.`tax` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `vibe_restaurants_v1`.`order`.`tax` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_restaurants_v1`.`order`.`tax` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_restaurants_v1`.`order`.`tax` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_restaurants_v1`.`order`.`tax` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`order`.`tax` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`order`.`tax` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_restaurants_v1`.`order`.`tax` ALTER COLUMN `daypart` SET TAGS ('dbx_business_glossary_term' = 'Daypart');
ALTER TABLE `vibe_restaurants_v1`.`order`.`tax` ALTER COLUMN `daypart` SET TAGS ('dbx_value_regex' = 'breakfast|lunch|dinner|late_night|snack');
ALTER TABLE `vibe_restaurants_v1`.`order`.`tax` ALTER COLUMN `engine_source` SET TAGS ('dbx_business_glossary_term' = 'Tax Engine Source');
ALTER TABLE `vibe_restaurants_v1`.`order`.`tax` ALTER COLUMN `engine_source` SET TAGS ('dbx_value_regex' = 'pos|vertex|avalara|sap_tax|manual');
ALTER TABLE `vibe_restaurants_v1`.`order`.`tax` ALTER COLUMN `exemption_certificate_ref` SET TAGS ('dbx_business_glossary_term' = 'Tax Exemption Certificate Reference');
ALTER TABLE `vibe_restaurants_v1`.`order`.`tax` ALTER COLUMN `exemption_reason` SET TAGS ('dbx_business_glossary_term' = 'Tax Exemption Reason');
ALTER TABLE `vibe_restaurants_v1`.`order`.`tax` ALTER COLUMN `exemption_reason` SET TAGS ('dbx_value_regex' = 'government|non_profit|resale|diplomatic|employee_meal|other');
ALTER TABLE `vibe_restaurants_v1`.`order`.`tax` ALTER COLUMN `is_exempt` SET TAGS ('dbx_business_glossary_term' = 'Is Tax Exempt Flag');
ALTER TABLE `vibe_restaurants_v1`.`order`.`tax` ALTER COLUMN `is_refunded` SET TAGS ('dbx_business_glossary_term' = 'Is Tax Refunded Flag');
ALTER TABLE `vibe_restaurants_v1`.`order`.`tax` ALTER COLUMN `is_tax_inclusive` SET TAGS ('dbx_business_glossary_term' = 'Is Tax Inclusive Flag');
ALTER TABLE `vibe_restaurants_v1`.`order`.`tax` ALTER COLUMN `line_sequence` SET TAGS ('dbx_business_glossary_term' = 'Tax Line Sequence Number');
ALTER TABLE `vibe_restaurants_v1`.`order`.`tax` ALTER COLUMN `tax_name` SET TAGS ('dbx_business_glossary_term' = 'Tax Name');
ALTER TABLE `vibe_restaurants_v1`.`order`.`tax` ALTER COLUMN `order_channel` SET TAGS ('dbx_business_glossary_term' = 'Order Channel');
ALTER TABLE `vibe_restaurants_v1`.`order`.`tax` ALTER COLUMN `order_channel` SET TAGS ('dbx_value_regex' = 'pos|drive_thru|olo|third_party_delivery|kiosk|catering');
ALTER TABLE `vibe_restaurants_v1`.`order`.`tax` ALTER COLUMN `original_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Original Tax Amount');
ALTER TABLE `vibe_restaurants_v1`.`order`.`tax` ALTER COLUMN `period_date` SET TAGS ('dbx_business_glossary_term' = 'Tax Period Date');
ALTER TABLE `vibe_restaurants_v1`.`order`.`tax` ALTER COLUMN `pos_tax_line_ref` SET TAGS ('dbx_business_glossary_term' = 'Point of Sale (POS) Tax Line Reference');
ALTER TABLE `vibe_restaurants_v1`.`order`.`tax` ALTER COLUMN `rate` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate');
ALTER TABLE `vibe_restaurants_v1`.`order`.`tax` ALTER COLUMN `refund_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Refund Amount');
ALTER TABLE `vibe_restaurants_v1`.`order`.`tax` ALTER COLUMN `remittance_period` SET TAGS ('dbx_business_glossary_term' = 'Tax Remittance Period');
ALTER TABLE `vibe_restaurants_v1`.`order`.`tax` ALTER COLUMN `remittance_status` SET TAGS ('dbx_business_glossary_term' = 'Tax Remittance Status');
ALTER TABLE `vibe_restaurants_v1`.`order`.`tax` ALTER COLUMN `remittance_status` SET TAGS ('dbx_value_regex' = 'pending|remitted|not_applicable|failed');
ALTER TABLE `vibe_restaurants_v1`.`order`.`tax` ALTER COLUMN `sap_tax_document_ref` SET TAGS ('dbx_business_glossary_term' = 'SAP Tax Document Reference');
ALTER TABLE `vibe_restaurants_v1`.`order`.`tax` ALTER COLUMN `state_code` SET TAGS ('dbx_business_glossary_term' = 'State Code');
ALTER TABLE `vibe_restaurants_v1`.`order`.`tax` ALTER COLUMN `state_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_restaurants_v1`.`order`.`tax` ALTER COLUMN `tax_status` SET TAGS ('dbx_business_glossary_term' = 'Tax Line Status');
ALTER TABLE `vibe_restaurants_v1`.`order`.`tax` ALTER COLUMN `tax_status` SET TAGS ('dbx_value_regex' = 'applied|voided|adjusted|pending|reversed');
ALTER TABLE `vibe_restaurants_v1`.`order`.`tax` ALTER COLUMN `tax_type` SET TAGS ('dbx_business_glossary_term' = 'Tax Type');
ALTER TABLE `vibe_restaurants_v1`.`order`.`tax` ALTER COLUMN `tax_type` SET TAGS ('dbx_value_regex' = 'sales_tax|vat|beverage_tax|bag_fee|excise_tax|service_tax');
ALTER TABLE `vibe_restaurants_v1`.`order`.`tax` ALTER COLUMN `taxable_amount` SET TAGS ('dbx_business_glossary_term' = 'Taxable Amount');
ALTER TABLE `vibe_restaurants_v1`.`order`.`tax` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`order`.`tax` ALTER COLUMN `voided_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Tax Voided Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_ingredient_usage` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_ingredient_usage` SET TAGS ('dbx_subdomain' = 'fulfillment_operations');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_ingredient_usage` SET TAGS ('dbx_association_edges' = 'order.order_item,inventory.stock_item');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_ingredient_usage` ALTER COLUMN `order_ingredient_usage_id` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Usage - Ingredient Usage Id');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_ingredient_usage` ALTER COLUMN `order_item_id` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Usage - Order Item Id');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_ingredient_usage` ALTER COLUMN `stock_item_id` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Usage - Stock Item Id');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_ingredient_usage` ALTER COLUMN `quantity_used` SET TAGS ('dbx_business_glossary_term' = 'Quantity Used');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_ingredient_usage` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_ingredient_usage` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_ingredient_usage` ALTER COLUMN `waste_flag` SET TAGS ('dbx_business_glossary_term' = 'Waste Flag');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_ingredient_usage` ALTER COLUMN `waste_reason` SET TAGS ('dbx_business_glossary_term' = 'Waste Reason');
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_package` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_package` SET TAGS ('dbx_subdomain' = 'fulfillment_operations');
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_package` ALTER COLUMN `catering_package_id` SET TAGS ('dbx_business_glossary_term' = 'Catering Package Identifier');
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_package` ALTER COLUMN `parent_catering_package_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Catering Package Id');
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_package` ALTER COLUMN `parent_catering_package_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_package` ALTER COLUMN `availability_end_date` SET TAGS ('dbx_business_glossary_term' = 'Availability End Date');
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_package` ALTER COLUMN `availability_start_date` SET TAGS ('dbx_business_glossary_term' = 'Availability Start Date');
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_package` ALTER COLUMN `calories` SET TAGS ('dbx_business_glossary_term' = 'Calories');
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_package` ALTER COLUMN `catering_package_category` SET TAGS ('dbx_business_glossary_term' = 'Category');
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_package` ALTER COLUMN `catering_package_code` SET TAGS ('dbx_business_glossary_term' = 'Code');
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_package` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_package` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_package` ALTER COLUMN `delivery_zone_codes` SET TAGS ('dbx_business_glossary_term' = 'Delivery Zone Codes');
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_package` ALTER COLUMN `catering_package_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_package` ALTER COLUMN `dietary_restriction` SET TAGS ('dbx_business_glossary_term' = 'Dietary Restriction');
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_package` ALTER COLUMN `image_url` SET TAGS ('dbx_business_glossary_term' = 'Image Url');
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_package` ALTER COLUMN `is_customizable` SET TAGS ('dbx_business_glossary_term' = 'Is Customizable');
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_package` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_package` ALTER COLUMN `max_custom_items` SET TAGS ('dbx_business_glossary_term' = 'Max Custom Items');
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_package` ALTER COLUMN `min_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Min Order Quantity');
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_package` ALTER COLUMN `catering_package_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_package` ALTER COLUMN `portion_size` SET TAGS ('dbx_business_glossary_term' = 'Portion Size');
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_package` ALTER COLUMN `price` SET TAGS ('dbx_business_glossary_term' = 'Price');
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_package` ALTER COLUMN `catering_package_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_package` ALTER COLUMN `surcharge_amount` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Amount');
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_package` ALTER COLUMN `tax_exempt` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt');
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_package` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_package` ALTER COLUMN `weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight Kg');
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_platform` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_platform` SET TAGS ('dbx_subdomain' = 'service_reference');
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_platform` ALTER COLUMN `delivery_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Platform Identifier');
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_platform` ALTER COLUMN `parent_delivery_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Delivery Platform Id');
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_platform` ALTER COLUMN `parent_delivery_platform_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_platform` ALTER COLUMN `average_delivery_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Average Delivery Time Minutes');
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_platform` ALTER COLUMN `delivery_platform_code` SET TAGS ('dbx_business_glossary_term' = 'Code');
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_platform` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_platform` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_platform` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_platform` ALTER COLUMN `fee_percentage` SET TAGS ('dbx_business_glossary_term' = 'Fee Percentage');
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_platform` ALTER COLUMN `integration_method` SET TAGS ('dbx_business_glossary_term' = 'Integration Method');
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_platform` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_platform` ALTER COLUMN `delivery_platform_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_platform` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_platform` ALTER COLUMN `onboarding_date` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Date');
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_platform` ALTER COLUMN `platform_type` SET TAGS ('dbx_business_glossary_term' = 'Platform Type');
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_platform` ALTER COLUMN `delivery_platform_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_platform` ALTER COLUMN `support_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Support Contact Email');
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_platform` ALTER COLUMN `support_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_platform` ALTER COLUMN `support_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_platform` ALTER COLUMN `support_phone_number` SET TAGS ('dbx_business_glossary_term' = 'Support Phone Number');
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_platform` ALTER COLUMN `support_phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_platform` ALTER COLUMN `support_phone_number` SET TAGS ('dbx_pii_phone' = 'true');
