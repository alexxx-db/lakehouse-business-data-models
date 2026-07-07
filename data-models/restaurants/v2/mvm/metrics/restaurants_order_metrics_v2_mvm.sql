-- Metric views for domain: order | Business: Restaurants | Version: 2 | Generated on: 2026-07-02 03:59:48

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`order_guest_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core order-level KPIs covering revenue, volume, discounting, tipping, and order mix. Primary steering dashboard for restaurant GMs, ops VPs, and finance leadership."
  source: "`vibe_restaurants_v1`.`order`.`guest_order`"
  dimensions:
    - name: "order_date"
      expr: CAST(placed_at AS DATE)
      comment: "Calendar date the order was placed, used for daily/weekly/monthly trend analysis."
    - name: "order_month"
      expr: DATE_TRUNC('MONTH', placed_at)
      comment: "Month the order was placed, used for period-over-period revenue and volume comparisons."
    - name: "order_type"
      expr: order_type
      comment: "Type of order (e.g. dine-in, takeout, delivery), used to segment revenue and volume by service mode."
    - name: "order_status"
      expr: order_status
      comment: "Current fulfillment status of the order (e.g. completed, cancelled, voided), used to filter or segment performance."
    - name: "channel_id"
      expr: channel_id
      comment: "Foreign key to the ordering channel (e.g. POS, mobile app, third-party), used to segment KPIs by channel."
    - name: "unit_id"
      expr: unit_id
      comment: "Restaurant unit identifier, used to compare performance across locations."
    - name: "daypart_id"
      expr: daypart_id
      comment: "Daypart identifier (e.g. breakfast, lunch, dinner), used to analyze performance by time-of-day segment."
    - name: "tender_type"
      expr: tender_type
      comment: "Payment tender type (e.g. cash, credit, mobile pay), used to understand payment mix."
    - name: "delivery_provider"
      expr: delivery_provider
      comment: "Third-party delivery provider name, used to compare delivery channel performance and commission exposure."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code for the order, used for multi-currency reporting."
    - name: "is_lto"
      expr: is_lto
      comment: "Flag indicating whether the order contained a limited-time offer item, used to measure LTO program impact."
    - name: "is_voided"
      expr: is_voided
      comment: "Flag indicating whether the order was voided, used to monitor void rates and potential fraud."
    - name: "loyalty_program_id"
      expr: loyalty_program_id
      comment: "Loyalty program associated with the order, used to measure loyalty-driven order volume and revenue."
  measures:
    - name: "total_orders"
      expr: COUNT(1)
      comment: "Total number of guest orders placed. Baseline volume KPI used in all operational and executive dashboards."
    - name: "total_gross_revenue"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Sum of total order amounts including tax and tip. Primary top-line revenue KPI for financial reporting and steering."
    - name: "total_subtotal_revenue"
      expr: SUM(CAST(subtotal_amount AS DOUBLE))
      comment: "Sum of pre-tax, pre-tip order subtotals. Used to measure net food and beverage revenue before tax and gratuity."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount dollars applied across all orders. Tracks promotional and coupon cost to the business."
    - name: "total_tax_collected"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount collected across all orders. Required for tax remittance reporting and compliance."
    - name: "total_tip_amount"
      expr: SUM(CAST(tip_amount AS DOUBLE))
      comment: "Total tip dollars collected. Tracks gratuity trends and informs labor compensation analysis."
    - name: "avg_order_value"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average total order value (AOV). Core KPI for menu engineering, upsell effectiveness, and revenue per transaction benchmarking."
    - name: "avg_subtotal_per_order"
      expr: AVG(CAST(subtotal_amount AS DOUBLE))
      comment: "Average pre-tax subtotal per order. Used to track ticket size trends excluding tax and tip."
    - name: "avg_discount_per_order"
      expr: AVG(CAST(discount_amount AS DOUBLE))
      comment: "Average discount amount per order. Measures promotional generosity and its impact on net revenue per transaction."
    - name: "avg_tip_per_order"
      expr: AVG(CAST(tip_amount AS DOUBLE))
      comment: "Average tip per order. Tracks guest generosity trends and informs front-of-house service quality assessment."
    - name: "completed_orders"
      expr: COUNT(CASE WHEN order_status = 'completed' THEN 1 END)
      comment: "Count of successfully completed orders. Used to measure fulfillment success rate and operational throughput."
    - name: "voided_orders"
      expr: COUNT(CASE WHEN is_voided = TRUE THEN 1 END)
      comment: "Count of voided orders. Elevated void rates signal operational issues, fraud risk, or training gaps."
    - name: "cancelled_orders"
      expr: COUNT(CASE WHEN cancelled_at IS NOT NULL THEN 1 END)
      comment: "Count of cancelled orders. Tracks cancellation volume which impacts revenue and guest satisfaction."
    - name: "loyalty_orders"
      expr: COUNT(CASE WHEN loyalty_member_id IS NOT NULL THEN 1 END)
      comment: "Count of orders placed by loyalty program members. Measures loyalty program engagement and its contribution to order volume."
    - name: "distinct_guests"
      expr: COUNT(DISTINCT primary_guest_profile_id)
      comment: "Count of unique guests placing orders. Used to measure guest reach, repeat visit rates, and customer base size."
    - name: "distinct_units_with_orders"
      expr: COUNT(DISTINCT unit_id)
      comment: "Number of distinct restaurant units generating orders in the period. Used to assess network-wide activity and identify dark stores."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`order_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Item-level KPIs covering product mix, revenue contribution, cost, margin, waste, and refund performance. Used by menu engineers, ops leaders, and finance for product portfolio decisions."
  source: "`vibe_restaurants_v1`.`order`.`order_item`"
  dimensions:
    - name: "order_date"
      expr: CAST(created_timestamp AS DATE)
      comment: "Date the order item was created, used for daily and period trend analysis."
    - name: "order_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month the order item was created, used for monthly product mix and revenue trend reporting."
    - name: "menu_item_id"
      expr: menu_item_id
      comment: "Menu item identifier, used to analyze performance by individual product."
    - name: "daypart_id"
      expr: daypart_id
      comment: "Daypart in which the item was ordered, used to understand product mix by time-of-day segment."
    - name: "kitchen_station_id"
      expr: kitchen_station_id
      comment: "Kitchen station responsible for preparing the item, used to analyze throughput and load by station."
    - name: "item_status"
      expr: item_status
      comment: "Current status of the order item (e.g. prepared, voided, refunded), used to filter and segment item-level KPIs."
    - name: "service_channel"
      expr: service_channel
      comment: "Channel through which the item was ordered (e.g. POS, online, kiosk), used to compare product mix across channels."
    - name: "pmix_category"
      expr: pmix_category
      comment: "Product mix category for the item, used to group items into menu categories for mix analysis."
    - name: "is_combo_component"
      expr: is_combo_component
      comment: "Flag indicating whether the item is part of a combo meal, used to measure combo attachment and bundle revenue."
    - name: "is_lto"
      expr: is_lto
      comment: "Flag indicating whether the item is a limited-time offer, used to measure LTO sales velocity and contribution."
    - name: "refund_flag"
      expr: refund_flag
      comment: "Flag indicating whether the item was refunded, used to monitor item-level refund rates."
    - name: "waste_flag"
      expr: waste_flag
      comment: "Flag indicating whether the item was wasted, used to track food waste by product and station."
    - name: "tax_exempt_flag"
      expr: tax_exempt_flag
      comment: "Flag indicating whether the item is tax-exempt, used for tax compliance and reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code for the item, used for multi-currency reporting."
  measures:
    - name: "total_items_sold"
      expr: COUNT(1)
      comment: "Total number of order item lines. Core product mix volume KPI used in menu engineering and operations."
    - name: "total_quantity_sold"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity of items sold across all order lines. Used for product velocity, inventory planning, and demand forecasting."
    - name: "total_gross_item_revenue"
      expr: SUM(CAST(line_gross_amount AS DOUBLE))
      comment: "Sum of gross line amounts before discounts. Measures full-price revenue potential of the product mix."
    - name: "total_net_item_revenue"
      expr: SUM(CAST(line_net_amount AS DOUBLE))
      comment: "Sum of net line amounts after discounts. Primary item-level revenue KPI used in product profitability analysis."
    - name: "total_item_discount_amount"
      expr: SUM(CAST(line_discount_amount AS DOUBLE))
      comment: "Total discount dollars applied at the item level. Tracks promotional cost by product and category."
    - name: "total_item_cost"
      expr: SUM(CAST(cost AS DOUBLE))
      comment: "Total cost of goods sold at the item level. Used to compute item-level gross margin and food cost percentage."
    - name: "total_item_tax"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected at the item level. Used for tax compliance and item-level tax rate validation."
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total refund dollars issued at the item level. Elevated refunds signal quality issues or guest dissatisfaction."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit selling price across all item lines. Used to track price realization and menu pricing effectiveness."
    - name: "avg_item_cost"
      expr: AVG(CAST(cost AS DOUBLE))
      comment: "Average cost per item line. Used to benchmark COGS per unit and identify cost outliers by product."
    - name: "avg_net_revenue_per_item"
      expr: AVG(CAST(line_net_amount AS DOUBLE))
      comment: "Average net revenue per item line after discounts. Used to compare revenue yield across menu items and categories."
    - name: "refunded_item_count"
      expr: COUNT(CASE WHEN refund_flag = TRUE THEN 1 END)
      comment: "Count of order item lines that were refunded. Used to identify high-refund products and quality issues."
    - name: "wasted_item_count"
      expr: COUNT(CASE WHEN waste_flag = TRUE THEN 1 END)
      comment: "Count of order item lines flagged as waste. Used to monitor food waste by product, station, and daypart."
    - name: "distinct_menu_items_sold"
      expr: COUNT(DISTINCT menu_item_id)
      comment: "Number of distinct menu items sold in the period. Used to measure menu breadth and identify slow-moving items."
    - name: "total_modifier_revenue"
      expr: SUM(CAST(modifier_price AS DOUBLE))
      comment: "Total revenue from item modifiers (add-ons, customizations). Measures upsell and customization revenue contribution."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`order_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment transaction KPIs covering tender mix, processing costs, split tender behavior, tip collection, and settlement performance. Used by finance, treasury, and operations leadership."
  source: "`vibe_restaurants_v1`.`order`.`payment`"
  dimensions:
    - name: "payment_date"
      expr: CAST(created_timestamp AS DATE)
      comment: "Date the payment was captured, used for daily payment volume and revenue reconciliation."
    - name: "payment_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month the payment was captured, used for monthly financial close and tender mix trend analysis."
    - name: "tender_type"
      expr: tender_type
      comment: "Payment tender type (e.g. cash, credit card, gift card, mobile pay), used to analyze payment mix and processing cost exposure."
    - name: "card_type"
      expr: card_type
      comment: "Card network type (e.g. Visa, Mastercard, Amex), used to analyze interchange fee exposure by card brand."
    - name: "card_entry_method"
      expr: card_entry_method
      comment: "Method of card entry (e.g. swipe, chip, tap, keyed), used to monitor fraud risk and processing cost by entry method."
    - name: "processor_name"
      expr: processor_name
      comment: "Payment processor name, used to compare processing costs and performance across processor relationships."
    - name: "unit_id"
      expr: unit_id
      comment: "Restaurant unit identifier, used to compare payment performance and tender mix across locations."
    - name: "channel"
      expr: channel
      comment: "Order channel associated with the payment, used to analyze payment behavior by ordering channel."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code for the payment, used for multi-currency financial reporting."
    - name: "settlement_date"
      expr: settlement_date
      comment: "Date the payment was settled with the processor, used for cash flow and reconciliation reporting."
    - name: "is_split_tender"
      expr: is_split_tender
      comment: "Flag indicating whether the payment is part of a split tender transaction, used to analyze split payment behavior."
    - name: "is_voided"
      expr: is_voided
      comment: "Flag indicating whether the payment was voided, used to monitor void rates and potential fraud."
    - name: "offline_authorization_flag"
      expr: offline_authorization_flag
      comment: "Flag indicating whether the payment was authorized offline, used to monitor offline payment risk exposure."
    - name: "third_party_delivery_partner"
      expr: third_party_delivery_partner
      comment: "Third-party delivery partner associated with the payment, used to analyze payment flows from delivery platforms."
  measures:
    - name: "total_payments"
      expr: COUNT(1)
      comment: "Total number of payment transactions. Baseline volume KPI for payment operations and reconciliation."
    - name: "total_applied_amount"
      expr: SUM(CAST(applied_amount AS DOUBLE))
      comment: "Total payment amount applied to orders. Primary payment revenue KPI used in daily financial close and cash management."
    - name: "total_tendered_amount"
      expr: SUM(CAST(tendered_amount AS DOUBLE))
      comment: "Total amount tendered by guests. Used to reconcile cash drawers and measure over-tender (change due) exposure."
    - name: "total_change_due"
      expr: SUM(CAST(change_due_amount AS DOUBLE))
      comment: "Total change returned to guests. Used to monitor cash handling efficiency and over-tender frequency."
    - name: "total_tip_collected"
      expr: SUM(CAST(tip_amount AS DOUBLE))
      comment: "Total tip dollars collected across all payment transactions. Used for tip pooling, labor cost analysis, and service quality benchmarking."
    - name: "total_interchange_fees"
      expr: SUM(CAST(interchange_fee_amount AS DOUBLE))
      comment: "Total interchange fees paid to card networks. Key cost-of-acceptance KPI used by finance to optimize payment mix and negotiate processor rates."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount applied at the payment level. Used to reconcile payment-level promotions and coupon redemptions."
    - name: "avg_payment_amount"
      expr: AVG(CAST(applied_amount AS DOUBLE))
      comment: "Average payment amount per transaction. Used to benchmark transaction size and detect anomalies."
    - name: "avg_tip_per_payment"
      expr: AVG(CAST(tip_amount AS DOUBLE))
      comment: "Average tip per payment transaction. Used to track tipping behavior trends and front-of-house service quality."
    - name: "avg_interchange_fee"
      expr: AVG(CAST(interchange_fee_amount AS DOUBLE))
      comment: "Average interchange fee per payment. Used to benchmark processing cost per transaction and evaluate processor performance."
    - name: "voided_payments"
      expr: COUNT(CASE WHEN is_voided = TRUE THEN 1 END)
      comment: "Count of voided payment transactions. Elevated void counts signal fraud risk, training issues, or system errors."
    - name: "split_tender_payments"
      expr: COUNT(CASE WHEN is_split_tender = TRUE THEN 1 END)
      comment: "Count of split tender payment transactions. Used to understand multi-tender behavior and its impact on checkout speed."
    - name: "offline_authorized_payments"
      expr: COUNT(CASE WHEN offline_authorization_flag = TRUE THEN 1 END)
      comment: "Count of payments authorized offline. Used to monitor connectivity risk and potential authorization loss exposure."
    - name: "distinct_units_processing_payments"
      expr: COUNT(DISTINCT unit_id)
      comment: "Number of distinct restaurant units processing payments in the period. Used to monitor network-wide payment activity."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`order_delivery_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Delivery-specific KPIs covering fulfillment speed, delivery distance, platform commission costs, customer satisfaction, and exception rates. Used by delivery ops, finance, and guest experience teams."
  source: "`vibe_restaurants_v1`.`order`.`delivery_order`"
  dimensions:
    - name: "delivery_date"
      expr: CAST(order_placed_timestamp AS DATE)
      comment: "Date the delivery order was placed, used for daily delivery volume and performance trend analysis."
    - name: "delivery_month"
      expr: DATE_TRUNC('MONTH', order_placed_timestamp)
      comment: "Month the delivery order was placed, used for monthly delivery performance and cost reporting."
    - name: "unit_id"
      expr: unit_id
      comment: "Restaurant unit fulfilling the delivery, used to compare delivery performance across locations."
    - name: "delivery_status"
      expr: delivery_status
      comment: "Current status of the delivery (e.g. delivered, failed, cancelled), used to segment delivery outcomes."
    - name: "delivery_exception_type"
      expr: delivery_exception_type
      comment: "Type of delivery exception (e.g. late, wrong address, missing item), used to categorize and prioritize exception resolution."
    - name: "delivery_city"
      expr: delivery_city
      comment: "City of the delivery address, used to analyze delivery performance and demand by geography."
    - name: "delivery_state_province"
      expr: delivery_state_province
      comment: "State or province of the delivery address, used for regional delivery performance analysis."
    - name: "is_contactless_delivery"
      expr: is_contactless_delivery
      comment: "Flag indicating contactless delivery, used to track contactless adoption and its impact on customer satisfaction."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code for the delivery order, used for multi-currency financial reporting."
  measures:
    - name: "total_delivery_orders"
      expr: COUNT(1)
      comment: "Total number of delivery orders. Baseline delivery volume KPI used in operations and channel mix reporting."
    - name: "total_delivery_fee_revenue"
      expr: SUM(CAST(delivery_fee_amount AS DOUBLE))
      comment: "Total delivery fee revenue collected. Used to assess delivery fee contribution to total revenue and fee strategy effectiveness."
    - name: "total_platform_commission"
      expr: SUM(CAST(platform_commission_amount AS DOUBLE))
      comment: "Total commission paid to third-party delivery platforms. Critical cost KPI for evaluating delivery channel profitability and platform negotiation."
    - name: "total_tip_amount"
      expr: SUM(CAST(tip_amount AS DOUBLE))
      comment: "Total tip dollars collected on delivery orders. Used to track driver compensation and guest generosity on delivery channel."
    - name: "avg_delivery_distance_km"
      expr: AVG(CAST(delivery_distance_km AS DOUBLE))
      comment: "Average delivery distance in kilometers. Used to optimize delivery zone boundaries and assess delivery cost efficiency."
    - name: "avg_platform_commission_rate"
      expr: AVG(CAST(platform_commission_rate AS DOUBLE))
      comment: "Average platform commission rate across delivery orders. Used to benchmark and negotiate platform fee structures."
    - name: "avg_customer_feedback_score"
      expr: AVG(CAST(customer_feedback AS DOUBLE))
      comment: "Average customer feedback score on delivery orders. Key guest satisfaction KPI used to evaluate delivery quality and driver performance."
    - name: "avg_total_ticket_time_minutes"
      expr: AVG(CAST(total_ticket_time_minutes AS DOUBLE))
      comment: "Average total ticket time from order placement to delivery completion. Core delivery speed KPI used to set SLA targets and identify bottlenecks."
    - name: "delivery_orders_with_exceptions"
      expr: COUNT(CASE WHEN delivery_exception_type IS NOT NULL THEN 1 END)
      comment: "Count of delivery orders with a recorded exception. Used to monitor exception rates and drive operational improvement."
    - name: "contactless_delivery_orders"
      expr: COUNT(CASE WHEN is_contactless_delivery = TRUE THEN 1 END)
      comment: "Count of contactless delivery orders. Used to track contactless adoption trends and guest preference shifts."
    - name: "distinct_delivery_units"
      expr: COUNT(DISTINCT unit_id)
      comment: "Number of distinct restaurant units fulfilling delivery orders. Used to measure delivery network coverage."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`order_discount`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Discount and promotional KPIs covering discount volume, value, void rates, loyalty redemption, and authorization patterns. Used by marketing, finance, and operations to govern promotional spend."
  source: "`vibe_restaurants_v1`.`order`.`discount`"
  dimensions:
    - name: "discount_date"
      expr: CAST(applied_at AS DATE)
      comment: "Date the discount was applied, used for daily and period promotional spend trend analysis."
    - name: "discount_month"
      expr: DATE_TRUNC('MONTH', applied_at)
      comment: "Month the discount was applied, used for monthly promotional cost reporting and budget tracking."
    - name: "unit_id"
      expr: unit_id
      comment: "Restaurant unit where the discount was applied, used to compare promotional activity across locations."
    - name: "channel_restriction"
      expr: channel_restriction
      comment: "Channel restriction on the discount (e.g. digital-only, in-store), used to analyze channel-specific promotional effectiveness."
    - name: "daypart_restriction"
      expr: daypart_restriction
      comment: "Daypart restriction on the discount, used to analyze time-of-day promotional patterns and effectiveness."
    - name: "reason"
      expr: reason
      comment: "Reason for the discount (e.g. loyalty reward, manager comp, promotional offer), used to categorize discount spend by purpose."
    - name: "is_voided"
      expr: is_voided
      comment: "Flag indicating whether the discount was voided, used to monitor discount void rates and potential misuse."
    - name: "is_pre_approved"
      expr: is_pre_approved
      comment: "Flag indicating whether the discount was pre-approved, used to distinguish system-authorized vs. manager-override discounts."
    - name: "is_stackable"
      expr: is_stackable
      comment: "Flag indicating whether the discount can be stacked with other promotions, used to assess multi-discount exposure."
    - name: "authorization_required"
      expr: authorization_required
      comment: "Flag indicating whether manager authorization was required for the discount, used to monitor authorization compliance."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code for the discount, used for multi-currency promotional cost reporting."
  measures:
    - name: "total_discounts_applied"
      expr: COUNT(1)
      comment: "Total number of discount transactions applied. Baseline promotional activity volume KPI."
    - name: "total_discount_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total discount dollars applied. Primary promotional cost KPI used by marketing and finance to govern promotional spend."
    - name: "total_revenue_impact"
      expr: SUM(CAST(revenue_impact_amount AS DOUBLE))
      comment: "Total revenue impact of discounts. Measures the net revenue reduction attributable to promotional activity."
    - name: "total_cogs_impact"
      expr: SUM(CAST(cogs_impact_amount AS DOUBLE))
      comment: "Total COGS impact of discounts. Used to assess whether discounts are eroding margin at the cost level."
    - name: "avg_discount_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average discount amount per transaction. Used to benchmark promotional generosity and detect outlier discounts."
    - name: "avg_original_price"
      expr: AVG(CAST(original_price AS DOUBLE))
      comment: "Average original price before discount. Used to contextualize discount depth relative to full price."
    - name: "avg_final_price"
      expr: AVG(CAST(final_price AS DOUBLE))
      comment: "Average final price after discount. Used to measure effective price realization after promotional activity."
    - name: "avg_discount_percentage"
      expr: AVG(CAST(percentage AS DOUBLE))
      comment: "Average discount percentage applied. Used to monitor promotional depth and ensure discounts stay within policy guardrails."
    - name: "voided_discounts"
      expr: COUNT(CASE WHEN is_voided = TRUE THEN 1 END)
      comment: "Count of voided discount transactions. Elevated void counts may indicate misuse, fraud, or system errors."
    - name: "manager_authorized_discounts"
      expr: COUNT(CASE WHEN authorization_required = TRUE THEN 1 END)
      comment: "Count of discounts requiring manager authorization. Used to monitor authorization compliance and manager override frequency."
    - name: "distinct_orders_discounted"
      expr: COUNT(DISTINCT guest_order_id)
      comment: "Number of distinct orders receiving a discount. Used to calculate order-level discount penetration rate."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`order_refund`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Refund KPIs covering refund volume, value, loyalty point reversals, fraud flags, and guest contact patterns. Used by guest experience, finance, and fraud teams to manage refund risk and cost."
  source: "`vibe_restaurants_v1`.`order`.`refund`"
  dimensions:
    - name: "refund_date"
      expr: CAST(refunded_at AS DATE)
      comment: "Date the refund was processed, used for daily refund volume and cost trend analysis."
    - name: "refund_month"
      expr: DATE_TRUNC('MONTH', refunded_at)
      comment: "Month the refund was processed, used for monthly refund cost reporting and financial close."
    - name: "unit_id"
      expr: unit_id
      comment: "Restaurant unit where the refund originated, used to identify high-refund locations and root causes."
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for the refund (e.g. wrong item, quality issue, late delivery), used to categorize refunds and drive corrective action."
    - name: "order_channel"
      expr: order_channel
      comment: "Order channel associated with the refund, used to compare refund rates across channels."
    - name: "third_party_delivery_provider"
      expr: third_party_delivery_provider
      comment: "Third-party delivery provider associated with the refund, used to assess delivery partner quality and refund liability."
    - name: "is_fraudulent"
      expr: is_fraudulent
      comment: "Flag indicating whether the refund was flagged as fraudulent, used to monitor fraud exposure and trigger investigations."
    - name: "is_voided"
      expr: is_voided
      comment: "Flag indicating whether the refund was voided, used to track refund reversal activity."
    - name: "csat_impact_flag"
      expr: csat_impact_flag
      comment: "Flag indicating whether the refund had a CSAT impact, used to link refund events to guest satisfaction outcomes."
    - name: "guest_contact_method"
      expr: guest_contact_method
      comment: "Method used by the guest to request the refund (e.g. app, phone, in-store), used to analyze refund channel patterns."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code for the refund, used for multi-currency financial reporting."
  measures:
    - name: "total_refunds"
      expr: COUNT(1)
      comment: "Total number of refund transactions. Baseline refund volume KPI used in guest experience and financial reporting."
    - name: "total_refund_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total refund dollars issued. Primary refund cost KPI used by finance and guest experience to monitor refund liability."
    - name: "total_refund_subtotal"
      expr: SUM(CAST(subtotal AS DOUBLE))
      comment: "Total subtotal amount refunded. Used to measure the food and beverage revenue reversal from refunds."
    - name: "total_refund_tax"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount refunded. Used for tax remittance adjustments and compliance reporting."
    - name: "total_loyalty_points_refunded"
      expr: SUM(CAST(loyalty_points_refunded AS DOUBLE))
      comment: "Total loyalty points reversed due to refunds. Used to track loyalty liability adjustments from refund activity."
    - name: "avg_refund_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average refund amount per transaction. Used to benchmark refund size and detect outlier refund events."
    - name: "fraudulent_refunds"
      expr: COUNT(CASE WHEN is_fraudulent = TRUE THEN 1 END)
      comment: "Count of refunds flagged as fraudulent. Used by fraud teams to monitor refund fraud exposure and trigger investigations."
    - name: "csat_impacting_refunds"
      expr: COUNT(CASE WHEN csat_impact_flag = TRUE THEN 1 END)
      comment: "Count of refunds with a CSAT impact flag. Used to quantify the guest satisfaction cost of refund events."
    - name: "distinct_orders_refunded"
      expr: COUNT(DISTINCT guest_order_id)
      comment: "Number of distinct orders with at least one refund. Used to calculate order-level refund rate."
    - name: "distinct_units_with_refunds"
      expr: COUNT(DISTINCT unit_id)
      comment: "Number of distinct restaurant units generating refunds. Used to identify high-refund locations for targeted intervention."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`order_kds_ticket`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Kitchen Display System (KDS) ticket KPIs covering speed of service, re-fire rates, SOS compliance, and kitchen throughput. Used by kitchen ops, GMs, and ops VPs to manage kitchen performance."
  source: "`vibe_restaurants_v1`.`order`.`kds_ticket`"
  dimensions:
    - name: "ticket_date"
      expr: CAST(ticket_created_timestamp AS DATE)
      comment: "Date the KDS ticket was created, used for daily kitchen performance trend analysis."
    - name: "ticket_month"
      expr: DATE_TRUNC('MONTH', ticket_created_timestamp)
      comment: "Month the KDS ticket was created, used for monthly kitchen throughput and SOS compliance reporting."
    - name: "unit_id"
      expr: unit_id
      comment: "Restaurant unit where the KDS ticket was generated, used to compare kitchen performance across locations."
    - name: "kitchen_station_id"
      expr: kitchen_station_id
      comment: "Kitchen station that processed the ticket, used to analyze throughput and SOS compliance by station."
    - name: "daypart_id"
      expr: daypart_id
      comment: "Daypart in which the ticket was created, used to analyze kitchen performance by time-of-day segment."
    - name: "order_channel"
      expr: order_channel
      comment: "Order channel that generated the KDS ticket, used to compare kitchen load and speed by channel."
    - name: "ticket_status"
      expr: ticket_status
      comment: "Current status of the KDS ticket (e.g. completed, voided, in-progress), used to filter and segment kitchen KPIs."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level assigned to the ticket, used to analyze whether high-priority tickets meet SOS targets."
    - name: "sos_met_flag"
      expr: sos_met_flag
      comment: "Flag indicating whether the ticket met the speed-of-service target, used to measure SOS compliance rate."
    - name: "re_fire_flag"
      expr: re_fire_flag
      comment: "Flag indicating whether the ticket was re-fired, used to monitor re-fire rates as a quality and waste indicator."
    - name: "void_flag"
      expr: void_flag
      comment: "Flag indicating whether the KDS ticket was voided, used to monitor kitchen void rates."
  measures:
    - name: "total_kds_tickets"
      expr: COUNT(1)
      comment: "Total number of KDS tickets generated. Baseline kitchen throughput volume KPI."
    - name: "sos_compliant_tickets"
      expr: COUNT(CASE WHEN sos_met_flag = TRUE THEN 1 END)
      comment: "Count of KDS tickets that met the speed-of-service target. Used to measure SOS compliance and kitchen efficiency."
    - name: "sos_breached_tickets"
      expr: COUNT(CASE WHEN sos_met_flag = FALSE THEN 1 END)
      comment: "Count of KDS tickets that breached the speed-of-service target. Used to identify kitchen bottlenecks and staffing gaps."
    - name: "re_fired_tickets"
      expr: COUNT(CASE WHEN re_fire_flag = TRUE THEN 1 END)
      comment: "Count of KDS tickets that were re-fired. Elevated re-fire rates signal quality issues, incorrect orders, or kitchen errors."
    - name: "voided_kds_tickets"
      expr: COUNT(CASE WHEN void_flag = TRUE THEN 1 END)
      comment: "Count of voided KDS tickets. Used to monitor kitchen void rates and their impact on throughput and waste."
    - name: "distinct_kitchen_stations_active"
      expr: COUNT(DISTINCT kitchen_station_id)
      comment: "Number of distinct kitchen stations processing tickets in the period. Used to assess kitchen station utilization."
    - name: "distinct_units_with_kds_activity"
      expr: COUNT(DISTINCT unit_id)
      comment: "Number of distinct restaurant units with KDS ticket activity. Used to monitor KDS adoption and coverage across the network."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`order_tax`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tax collection and compliance KPIs covering tax amounts, exemptions, refunds, and remittance status by authority and jurisdiction. Used by finance and tax compliance teams."
  source: "`vibe_restaurants_v1`.`order`.`tax`"
  dimensions:
    - name: "tax_date"
      expr: period_date
      comment: "Tax period date, used for daily and period tax collection trend analysis."
    - name: "tax_month"
      expr: DATE_TRUNC('MONTH', period_date)
      comment: "Month of the tax period, used for monthly tax remittance and compliance reporting."
    - name: "unit_id"
      expr: unit_id
      comment: "Restaurant unit where the tax was collected, used to compare tax collection across locations and jurisdictions."
    - name: "authority_level"
      expr: authority_level
      comment: "Tax authority level (e.g. federal, state, local), used to segment tax collection by jurisdiction tier."
    - name: "authority_name"
      expr: authority_name
      comment: "Name of the tax authority, used to report tax collection by specific taxing jurisdiction."
    - name: "country_code"
      expr: country_code
      comment: "Country code for the tax jurisdiction, used for multi-country tax compliance reporting."
    - name: "state_code"
      expr: state_code
      comment: "State code for the tax jurisdiction, used for state-level tax remittance reporting."
    - name: "order_channel"
      expr: order_channel
      comment: "Order channel associated with the tax line, used to analyze tax collection by channel (e.g. marketplace nexus analysis)."
    - name: "remittance_status"
      expr: remittance_status
      comment: "Current remittance status of the tax (e.g. pending, remitted, overdue), used to monitor tax remittance compliance."
    - name: "is_exempt"
      expr: is_exempt
      comment: "Flag indicating whether the tax line is exempt, used to monitor exemption volume and validate exemption certificates."
    - name: "is_refunded"
      expr: is_refunded
      comment: "Flag indicating whether the tax was refunded, used to track tax refund activity and its impact on remittance."
    - name: "is_tax_inclusive"
      expr: is_tax_inclusive
      comment: "Flag indicating whether the tax is included in the item price, used to distinguish inclusive vs. exclusive tax treatment."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code for the tax line, used for multi-currency tax reporting."
  measures:
    - name: "total_tax_collected"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total tax amount collected. Primary tax compliance KPI used for remittance reporting and regulatory filings."
    - name: "total_taxable_amount"
      expr: SUM(CAST(taxable_amount AS DOUBLE))
      comment: "Total taxable sales amount. Used to validate effective tax rates and ensure correct tax base calculation."
    - name: "total_tax_refunded"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total tax amount refunded. Used to adjust net tax remittance and track refund-driven tax reversals."
    - name: "total_original_tax_amount"
      expr: SUM(CAST(original_tax_amount AS DOUBLE))
      comment: "Total original tax amount before adjustments. Used to reconcile tax adjustments and identify correction patterns."
    - name: "avg_tax_rate"
      expr: AVG(CAST(rate AS DOUBLE))
      comment: "Average effective tax rate across all tax lines. Used to benchmark tax rates by jurisdiction and detect rate anomalies."
    - name: "exempt_tax_lines"
      expr: COUNT(CASE WHEN is_exempt = TRUE THEN 1 END)
      comment: "Count of tax-exempt transaction lines. Used to monitor exemption volume and validate exemption certificate compliance."
    - name: "refunded_tax_lines"
      expr: COUNT(CASE WHEN is_refunded = TRUE THEN 1 END)
      comment: "Count of tax lines that were refunded. Used to track refund-driven tax reversals and their remittance impact."
    - name: "distinct_tax_authorities"
      expr: COUNT(DISTINCT authority_name)
      comment: "Number of distinct tax authorities collecting tax in the period. Used to monitor multi-jurisdiction tax complexity and compliance scope."
    - name: "distinct_units_collecting_tax"
      expr: COUNT(DISTINCT unit_id)
      comment: "Number of distinct restaurant units collecting tax. Used to ensure all active units are correctly remitting tax."
$$;