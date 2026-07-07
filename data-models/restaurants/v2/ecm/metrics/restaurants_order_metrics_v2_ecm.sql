-- Metric views for domain: order | Business: Restaurants | Version: 2 | Generated on: 2026-07-02 03:10:25

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`order_guest_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core order-level KPIs covering revenue, volume, discounting, tipping, and fulfillment performance. Primary steering dashboard for operations and finance leadership."
  source: "`vibe_restaurants_v1`.`order`.`guest_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current lifecycle status of the order (e.g., placed, fulfilled, cancelled, voided) for funnel and completion analysis."
    - name: "order_type"
      expr: order_type
      comment: "Type of order (dine-in, takeout, delivery, drive-thru) enabling channel-mix and format analysis."
    - name: "daypart"
      expr: daypart
      comment: "Meal period (breakfast, lunch, dinner, late-night) for time-of-day performance segmentation."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code for multi-currency revenue reporting."
    - name: "tender_type"
      expr: tender_type
      comment: "Payment tender type (cash, credit, mobile pay) for payment-mix analysis."
    - name: "order_date"
      expr: DATE_TRUNC('day', placed_at)
      comment: "Calendar date the order was placed, used for daily trend analysis."
    - name: "order_week"
      expr: DATE_TRUNC('week', placed_at)
      comment: "ISO week the order was placed for weekly trend reporting."
    - name: "order_month"
      expr: DATE_TRUNC('month', placed_at)
      comment: "Calendar month the order was placed for monthly and period-over-period analysis."
    - name: "is_lto"
      expr: is_lto
      comment: "Flag indicating whether the order included a limited-time offer item, used to measure LTO lift."
    - name: "is_voided"
      expr: is_voided
      comment: "Flag indicating the order was voided, used to filter or segment void analysis."
    - name: "delivery_provider"
      expr: delivery_provider
      comment: "Third-party delivery provider name for platform-level performance comparison."
  measures:
    - name: "total_orders"
      expr: COUNT(1)
      comment: "Total number of orders placed. Baseline volume KPI for traffic and throughput analysis."
    - name: "completed_orders"
      expr: COUNT(CASE WHEN order_status = 'fulfilled' THEN 1 END)
      comment: "Count of successfully fulfilled orders. Measures operational completion rate."
    - name: "voided_orders"
      expr: COUNT(CASE WHEN is_voided = TRUE THEN 1 END)
      comment: "Count of voided orders. Elevated void rates signal POS errors, fraud, or operational issues."
    - name: "void_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_voided = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of orders that were voided. A key fraud and operational quality indicator."
    - name: "total_gross_revenue"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Sum of total order amounts including tax and tip. Top-line revenue KPI for financial reporting."
    - name: "total_subtotal_revenue"
      expr: SUM(CAST(subtotal_amount AS DOUBLE))
      comment: "Sum of pre-tax, pre-tip order subtotals. Net food and beverage revenue before taxes."
    - name: "total_tax_collected"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected across all orders. Required for tax remittance and compliance reporting."
    - name: "total_tip_amount"
      expr: SUM(CAST(tip_amount AS DOUBLE))
      comment: "Total tip dollars collected. Informs labor cost models and employee compensation analysis."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount dollars applied across all orders. Measures promotional spend and margin erosion."
    - name: "discount_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(subtotal_amount AS DOUBLE)), 0), 2)
      comment: "Discount as a percentage of subtotal revenue. Tracks promotional intensity and margin impact."
    - name: "avg_order_value"
      expr: ROUND(AVG(CAST(total_amount AS DOUBLE)), 2)
      comment: "Average total order value (AOV). Core revenue-per-transaction KPI used in pricing and upsell strategy."
    - name: "avg_subtotal_value"
      expr: ROUND(AVG(CAST(subtotal_amount AS DOUBLE)), 2)
      comment: "Average pre-tax subtotal per order. Cleaner AOV signal excluding tax and tip variability."
    - name: "lto_orders"
      expr: COUNT(CASE WHEN is_lto = TRUE THEN 1 END)
      comment: "Count of orders containing a limited-time offer item. Measures LTO adoption and campaign effectiveness."
    - name: "lto_order_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_lto = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of orders that included an LTO item. Tracks LTO penetration for marketing ROI."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`order_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Item-level sales and profitability KPIs. Enables product mix analysis, menu engineering, and item-level margin management."
  source: "`vibe_restaurants_v1`.`order`.`order_item`"
  dimensions:
    - name: "daypart_code"
      expr: daypart_code
      comment: "Meal period code for the order item, enabling daypart-level product mix analysis."
    - name: "item_status"
      expr: item_status
      comment: "Current status of the order item (e.g., prepared, voided, refunded) for quality and exception tracking."
    - name: "service_channel"
      expr: service_channel
      comment: "Channel through which the item was ordered (dine-in, drive-thru, delivery) for channel-mix analysis."
    - name: "pmix_category"
      expr: pmix_category
      comment: "Product mix category for menu engineering and category-level sales reporting."
    - name: "is_lto"
      expr: is_lto
      comment: "Flag indicating the item is a limited-time offer. Used to measure LTO item-level performance."
    - name: "is_combo_component"
      expr: is_combo_component
      comment: "Flag indicating the item is part of a combo meal. Used to analyze combo attachment and bundling."
    - name: "refund_flag"
      expr: refund_flag
      comment: "Flag indicating the item was refunded. Used to track item-level refund rates and quality issues."
    - name: "waste_flag"
      expr: waste_flag
      comment: "Flag indicating the item was wasted. Used to track item-level waste rates and food cost impact."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code for multi-currency item revenue reporting."
    - name: "item_created_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Date the order item was created, used for daily item sales trend analysis."
  measures:
    - name: "total_items_sold"
      expr: COUNT(1)
      comment: "Total number of order item lines. Baseline volume KPI for product mix and throughput analysis."
    - name: "total_item_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Sum of item quantities sold. Accounts for multi-quantity line items in volume reporting."
    - name: "total_gross_item_revenue"
      expr: SUM(CAST(line_gross_amount AS DOUBLE))
      comment: "Sum of gross line amounts before discounts. Measures full-price revenue potential."
    - name: "total_net_item_revenue"
      expr: SUM(CAST(line_net_amount AS DOUBLE))
      comment: "Sum of net line amounts after discounts. Core item-level revenue KPI for P&L reporting."
    - name: "total_item_discount_amount"
      expr: SUM(CAST(line_discount_amount AS DOUBLE))
      comment: "Total discount dollars applied at the item level. Measures promotional spend per item."
    - name: "item_discount_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(line_discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(line_gross_amount AS DOUBLE)), 0), 2)
      comment: "Item-level discount as a percentage of gross revenue. Tracks per-item promotional intensity."
    - name: "total_item_cost"
      expr: SUM(CAST(cost AS DOUBLE))
      comment: "Total cost of goods for items sold. Core input for food cost percentage and margin calculations."
    - name: "item_gross_margin_amount"
      expr: SUM(CAST(line_net_amount AS DOUBLE) - CAST(cost AS DOUBLE))
      comment: "Gross margin dollars at the item level (net revenue minus COGS). Key profitability KPI for menu engineering."
    - name: "item_gross_margin_pct"
      expr: ROUND(100.0 * SUM(CAST(line_net_amount AS DOUBLE) - CAST(cost AS DOUBLE)) / NULLIF(SUM(CAST(line_net_amount AS DOUBLE)), 0), 2)
      comment: "Gross margin percentage at the item level. Used in menu engineering to classify stars, plowhorses, puzzles, and dogs."
    - name: "avg_unit_price"
      expr: ROUND(AVG(CAST(unit_price AS DOUBLE)), 2)
      comment: "Average selling price per item unit. Tracks pricing realization and price-mix effects."
    - name: "total_item_tax"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected at the item level. Required for item-level tax compliance reporting."
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total refund dollars at the item level. Elevated refunds signal quality or service issues."
    - name: "refund_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN refund_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of items that were refunded. Quality and guest satisfaction indicator."
    - name: "waste_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN waste_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of items flagged as waste. Drives food cost and sustainability improvement initiatives."
    - name: "lto_item_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_lto = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of items sold that are LTO items. Measures LTO penetration at the item level."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`order_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment transaction KPIs covering tender mix, tip performance, settlement, and fraud/void rates. Used by finance and operations leadership for cash management and payment strategy."
  source: "`vibe_restaurants_v1`.`order`.`payment`"
  dimensions:
    - name: "tender_type"
      expr: tender_type
      comment: "Payment tender type (cash, credit card, debit, mobile pay, gift card) for payment-mix analysis."
    - name: "card_type"
      expr: card_type
      comment: "Card network type (Visa, Mastercard, Amex) for interchange cost analysis."
    - name: "card_entry_method"
      expr: card_entry_method
      comment: "How the card was entered (swipe, chip, tap, manual) for fraud and security analysis."
    - name: "payment_status"
      expr: CAST(payment_status AS STRING)
      comment: "Current status of the payment transaction for settlement and exception tracking."
    - name: "daypart"
      expr: daypart
      comment: "Meal period during which the payment was made for time-of-day tender-mix analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code for multi-currency payment reporting."
    - name: "is_split_tender"
      expr: is_split_tender
      comment: "Flag indicating the order used split tender. Tracks complexity and split-pay behavior."
    - name: "settlement_date"
      expr: settlement_date
      comment: "Date the payment was settled. Used for cash flow and settlement reconciliation reporting."
    - name: "payment_date"
      expr: DATE_TRUNC('day', captured_timestamp)
      comment: "Date the payment was captured for daily payment volume trending."
  measures:
    - name: "total_payments"
      expr: COUNT(1)
      comment: "Total number of payment transactions. Baseline volume KPI for payment processing analysis."
    - name: "total_tendered_amount"
      expr: SUM(CAST(tendered_amount AS DOUBLE))
      comment: "Total amount tendered by guests. Measures gross cash flow before change."
    - name: "total_applied_amount"
      expr: SUM(CAST(applied_amount AS DOUBLE))
      comment: "Total payment amount applied to orders. Core revenue collection KPI."
    - name: "total_tip_amount"
      expr: SUM(CAST(tip_amount AS DOUBLE))
      comment: "Total tip dollars collected. Informs labor cost models and tipped-employee compensation."
    - name: "avg_tip_amount"
      expr: ROUND(AVG(CAST(tip_amount AS DOUBLE)), 2)
      comment: "Average tip per payment transaction. Tracks tipping behavior trends by channel and daypart."
    - name: "tip_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(tip_amount AS DOUBLE)) / NULLIF(SUM(CAST(applied_amount AS DOUBLE)), 0), 2)
      comment: "Tip as a percentage of applied payment amount. Measures tipping generosity and service quality signal."
    - name: "total_interchange_fees"
      expr: SUM(CAST(interchange_fee_amount AS DOUBLE))
      comment: "Total interchange fees paid to card networks. Key cost-of-acceptance metric for payment strategy."
    - name: "interchange_fee_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(interchange_fee_amount AS DOUBLE)) / NULLIF(SUM(CAST(applied_amount AS DOUBLE)), 0), 2)
      comment: "Interchange fees as a percentage of total applied payments. Tracks cost of card acceptance."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount dollars applied at payment time. Measures payment-level promotional spend."
    - name: "voided_payments"
      expr: COUNT(CASE WHEN is_voided = TRUE THEN 1 END)
      comment: "Count of voided payment transactions. Elevated voids signal POS errors or fraud."
    - name: "void_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_voided = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of payments that were voided. Key fraud and operational integrity indicator."
    - name: "total_change_due"
      expr: SUM(CAST(change_due_amount AS DOUBLE))
      comment: "Total change returned to guests. Tracks cash handling volume and cash drawer management."
    - name: "total_tax_collected"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected at payment level. Required for tax remittance reconciliation."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`order_drive_thru_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Drive-thru speed-of-service (SOS) and throughput KPIs. Critical operational dashboard for QSR drive-thru performance management and SOS target compliance."
  source: "`vibe_restaurants_v1`.`order`.`drive_thru_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of drive-thru event (arrival, order, payment, pickup) for stage-level SOS analysis."
    - name: "daypart"
      expr: daypart
      comment: "Meal period of the drive-thru event for peak vs. off-peak SOS comparison."
    - name: "lane_number"
      expr: lane_number
      comment: "Drive-thru lane identifier for multi-lane performance comparison."
    - name: "weather_condition"
      expr: weather_condition
      comment: "Weather condition at time of event. Used to analyze weather impact on drive-thru throughput."
    - name: "exception_flag"
      expr: exception_flag
      comment: "Flag indicating an exception occurred during this drive-thru event for exception rate analysis."
    - name: "pull_forward_flag"
      expr: pull_forward_flag
      comment: "Flag indicating the vehicle was pulled forward to wait. Tracks pull-forward rate as an SOS management tactic."
    - name: "franchise_flag"
      expr: franchise_flag
      comment: "Flag indicating the unit is franchised vs. company-owned for comparative SOS benchmarking."
    - name: "business_date"
      expr: business_date
      comment: "Business date of the drive-thru event for daily SOS trend analysis."
    - name: "event_week"
      expr: DATE_TRUNC('week', event_timestamp)
      comment: "ISO week of the drive-thru event for weekly SOS trend reporting."
  measures:
    - name: "total_drive_thru_events"
      expr: COUNT(1)
      comment: "Total number of drive-thru events recorded. Baseline throughput volume KPI."
    - name: "avg_elapsed_time_seconds"
      expr: ROUND(AVG(CAST(elapsed_time_seconds AS DOUBLE)), 1)
      comment: "Average elapsed time per drive-thru stage in seconds. Core SOS performance metric."
    - name: "avg_cumulative_time_seconds"
      expr: ROUND(AVG(CAST(cumulative_time_seconds AS DOUBLE)), 1)
      comment: "Average total cumulative time from arrival to completion. End-to-end drive-thru SOS KPI."
    - name: "avg_sos_target_seconds"
      expr: ROUND(AVG(CAST(sos_target_seconds AS DOUBLE)), 1)
      comment: "Average SOS target in seconds for the events measured. Provides context for variance analysis."
    - name: "avg_sos_variance_seconds"
      expr: ROUND(AVG(CAST(sos_variance_seconds AS DOUBLE)), 1)
      comment: "Average variance between actual and target SOS in seconds. Negative = faster than target; positive = slower."
    - name: "sos_breach_count"
      expr: COUNT(CASE WHEN sos_variance_seconds > 0 THEN 1 END)
      comment: "Count of events where actual time exceeded the SOS target. Measures SOS compliance failures."
    - name: "sos_breach_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sos_variance_seconds > 0 THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of drive-thru events that breached the SOS target. Key operational quality KPI."
    - name: "exception_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN exception_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of drive-thru events with an exception. Tracks operational disruption frequency."
    - name: "pull_forward_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN pull_forward_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of vehicles pulled forward. High pull-forward rates indicate kitchen throughput constraints."
    - name: "total_order_revenue"
      expr: SUM(CAST(order_total_amount AS DOUBLE))
      comment: "Total order revenue from drive-thru transactions. Measures drive-thru channel revenue contribution."
    - name: "avg_order_value"
      expr: ROUND(AVG(CAST(order_total_amount AS DOUBLE)), 2)
      comment: "Average order value for drive-thru transactions. Tracks upsell effectiveness in the drive-thru channel."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`order_kds_ticket`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Kitchen Display System (KDS) ticket throughput and performance KPIs. Measures kitchen speed, re-fire rates, and SOS compliance at the station level for operational excellence."
  source: "`vibe_restaurants_v1`.`order`.`kds_ticket`"
  dimensions:
    - name: "ticket_status"
      expr: ticket_status
      comment: "Current status of the KDS ticket (open, bumped, completed, voided) for kitchen throughput analysis."
    - name: "daypart"
      expr: daypart
      comment: "Meal period of the KDS ticket for peak-period kitchen performance analysis."
    - name: "order_channel"
      expr: order_channel
      comment: "Order channel (dine-in, drive-thru, delivery) for channel-level kitchen performance comparison."
    - name: "priority_level"
      expr: priority_level
      comment: "Ticket priority level for analyzing how priority routing affects kitchen throughput."
    - name: "re_fire_flag"
      expr: re_fire_flag
      comment: "Flag indicating the ticket was re-fired. Used to track re-fire rates as a quality indicator."
    - name: "void_flag"
      expr: void_flag
      comment: "Flag indicating the KDS ticket was voided. Used to track kitchen void rates."
    - name: "sos_met_flag"
      expr: sos_met_flag
      comment: "Flag indicating whether the SOS target was met for this ticket. Core kitchen SOS compliance dimension."
    - name: "ticket_created_date"
      expr: DATE_TRUNC('day', ticket_created_timestamp)
      comment: "Date the KDS ticket was created for daily kitchen performance trending."
  measures:
    - name: "total_kds_tickets"
      expr: COUNT(1)
      comment: "Total number of KDS tickets. Baseline kitchen throughput volume KPI."
    - name: "sos_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sos_met_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of KDS tickets completed within the SOS target. Primary kitchen performance KPI."
    - name: "re_fire_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN re_fire_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of tickets that required a re-fire. Elevated re-fire rates indicate quality or prep issues."
    - name: "void_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN void_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of KDS tickets voided. Tracks kitchen waste and order cancellation rates."
    - name: "completed_tickets"
      expr: COUNT(CASE WHEN ticket_status = 'completed' THEN 1 END)
      comment: "Count of successfully completed KDS tickets. Measures kitchen throughput completion."
    - name: "avg_items_per_ticket"
      expr: ROUND(AVG(CAST(item_count AS DOUBLE)), 2)
      comment: "Average number of items per KDS ticket. Tracks ticket complexity and its impact on kitchen speed."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`order_delivery_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Delivery channel performance KPIs covering delivery time, platform economics, customer satisfaction, and exception rates. Used by operations and digital leadership to manage third-party delivery partnerships."
  source: "`vibe_restaurants_v1`.`order`.`delivery_order`"
  dimensions:
    - name: "delivery_status"
      expr: delivery_status
      comment: "Current status of the delivery order (pending, in-transit, delivered, failed) for funnel analysis."
    - name: "delivery_exception_type"
      expr: delivery_exception_type
      comment: "Type of delivery exception (late, missing item, wrong order) for root cause analysis."
    - name: "is_contactless_delivery"
      expr: is_contactless_delivery
      comment: "Flag indicating contactless delivery was requested. Tracks contactless adoption trends."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code for multi-currency delivery revenue reporting."
    - name: "delivery_city"
      expr: delivery_city
      comment: "City of delivery destination for geographic performance analysis."
    - name: "delivery_date"
      expr: DATE_TRUNC('day', order_placed_timestamp)
      comment: "Date the delivery order was placed for daily delivery volume trending."
    - name: "delivery_week"
      expr: DATE_TRUNC('week', order_placed_timestamp)
      comment: "ISO week the delivery order was placed for weekly delivery performance reporting."
  measures:
    - name: "total_delivery_orders"
      expr: COUNT(1)
      comment: "Total number of delivery orders. Baseline delivery channel volume KPI."
    - name: "avg_actual_delivery_time_minutes"
      expr: ROUND(AVG(CAST(total_ticket_time_minutes AS DOUBLE)), 1)
      comment: "Average total delivery time in minutes from order placement to delivery. Core delivery SLA KPI."
    - name: "avg_delivery_distance_km"
      expr: ROUND(AVG(CAST(delivery_distance_km AS DOUBLE)), 2)
      comment: "Average delivery distance in kilometers. Informs delivery zone optimization and cost modeling."
    - name: "total_delivery_fees"
      expr: SUM(CAST(delivery_fee_amount AS DOUBLE))
      comment: "Total delivery fees collected. Measures delivery fee revenue contribution."
    - name: "total_platform_commission"
      expr: SUM(CAST(platform_commission_amount AS DOUBLE))
      comment: "Total commission paid to delivery platforms. Key cost-of-delivery metric for platform economics."
    - name: "avg_platform_commission_rate_pct"
      expr: ROUND(AVG(CAST(platform_commission_rate AS DOUBLE)), 2)
      comment: "Average platform commission rate percentage. Used in delivery platform contract negotiations."
    - name: "total_tip_amount"
      expr: SUM(CAST(tip_amount AS DOUBLE))
      comment: "Total tip dollars collected on delivery orders. Informs driver compensation and satisfaction."
    - name: "avg_customer_rating"
      expr: ROUND(AVG(CAST(customer_feedback AS DOUBLE)), 2)
      comment: "Average customer satisfaction rating for delivery orders. Key delivery quality KPI."
    - name: "delivery_exception_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN delivery_exception_type IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of delivery orders with an exception. Tracks delivery reliability and quality."
    - name: "net_delivery_revenue"
      expr: SUM(CAST(delivery_fee_amount AS DOUBLE) - CAST(platform_commission_amount AS DOUBLE))
      comment: "Net delivery revenue after deducting platform commissions. Measures true delivery channel profitability."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`order_discount`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Discount and promotional spend KPIs. Enables marketing and finance leadership to measure promotional effectiveness, margin erosion, and discount policy compliance."
  source: "`vibe_restaurants_v1`.`order`.`discount`"
  dimensions:
    - name: "discount_type"
      expr: CAST(discount_type AS STRING)
      comment: "Type of discount applied (employee, promotional, loyalty, manager override) for discount-mix analysis."
    - name: "daypart_restriction"
      expr: daypart_restriction
      comment: "Daypart restriction on the discount for time-of-day promotional analysis."
    - name: "channel_restriction"
      expr: channel_restriction
      comment: "Channel restriction on the discount for channel-level promotional spend analysis."
    - name: "is_voided"
      expr: is_voided
      comment: "Flag indicating the discount was voided. Used to track discount reversal rates."
    - name: "authorization_required"
      expr: authorization_required
      comment: "Flag indicating manager authorization was required. Tracks controlled vs. automatic discount usage."
    - name: "is_stackable"
      expr: is_stackable
      comment: "Flag indicating the discount can be stacked with other discounts. Used in promotional policy analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code for multi-currency discount reporting."
    - name: "discount_date"
      expr: DATE_TRUNC('day', applied_at)
      comment: "Date the discount was applied for daily promotional spend trending."
  measures:
    - name: "total_discounts_applied"
      expr: COUNT(1)
      comment: "Total number of discount transactions. Baseline promotional activity volume KPI."
    - name: "total_discount_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total discount dollars applied. Primary promotional spend KPI for marketing ROI analysis."
    - name: "total_revenue_impact"
      expr: SUM(CAST(revenue_impact_amount AS DOUBLE))
      comment: "Total revenue impact of discounts. Measures top-line revenue erosion from promotional activity."
    - name: "total_cogs_impact"
      expr: SUM(CAST(cogs_impact_amount AS DOUBLE))
      comment: "Total COGS impact of discounts. Measures cost-side effect of promotional pricing."
    - name: "avg_discount_amount"
      expr: ROUND(AVG(CAST(amount AS DOUBLE)), 2)
      comment: "Average discount amount per transaction. Tracks discount depth and generosity trends."
    - name: "avg_discount_percentage"
      expr: ROUND(AVG(CAST(percentage AS DOUBLE)), 2)
      comment: "Average discount percentage applied. Measures promotional depth relative to original price."
    - name: "voided_discount_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_voided = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of discounts that were voided. Tracks discount reversal rates and policy compliance."
    - name: "authorized_discount_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN authorization_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of discounts requiring manager authorization. Measures controlled discount policy adherence."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`order_refund`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Refund and chargeback KPIs. Tracks refund volume, value, fraud risk, and guest satisfaction impact. Used by operations and finance to manage refund policy and guest recovery."
  source: "`vibe_restaurants_v1`.`order`.`refund`"
  dimensions:
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for the refund (wrong order, quality issue, late delivery) for root cause analysis."
    - name: "refund_status"
      expr: CAST(refund_status AS STRING)
      comment: "Current status of the refund (pending, approved, processed, voided) for refund pipeline tracking."
    - name: "refund_type"
      expr: CAST(refund_type AS STRING)
      comment: "Type of refund (full, partial, loyalty points) for refund-mix analysis."
    - name: "order_channel"
      expr: order_channel
      comment: "Order channel where the refund originated for channel-level refund rate analysis."
    - name: "daypart"
      expr: daypart
      comment: "Meal period of the original order for daypart-level refund analysis."
    - name: "is_fraudulent"
      expr: is_fraudulent
      comment: "Flag indicating the refund was identified as fraudulent. Used for fraud rate monitoring."
    - name: "csat_impact_flag"
      expr: csat_impact_flag
      comment: "Flag indicating the refund had a CSAT impact. Links refund activity to guest satisfaction outcomes."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code for multi-currency refund reporting."
    - name: "refund_date"
      expr: DATE_TRUNC('day', refunded_at)
      comment: "Date the refund was processed for daily refund trend analysis."
  measures:
    - name: "total_refunds"
      expr: COUNT(1)
      comment: "Total number of refund transactions. Baseline refund volume KPI."
    - name: "total_refund_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total refund dollars processed. Measures financial exposure from refund activity."
    - name: "total_tax_refunded"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax refunded. Required for tax liability reconciliation."
    - name: "total_loyalty_points_refunded"
      expr: SUM(CAST(loyalty_points_refunded AS DOUBLE))
      comment: "Total loyalty points refunded to guests. Measures loyalty liability from refund activity."
    - name: "avg_refund_amount"
      expr: ROUND(AVG(CAST(amount AS DOUBLE)), 2)
      comment: "Average refund amount per transaction. Tracks refund depth and policy generosity."
    - name: "fraud_refund_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_fraudulent = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of refunds identified as fraudulent. Key fraud risk KPI for loss prevention."
    - name: "csat_impact_refund_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN csat_impact_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of refunds with a CSAT impact. Links refund activity to guest satisfaction degradation."
    - name: "total_refund_subtotal"
      expr: SUM(CAST(subtotal AS DOUBLE))
      comment: "Total pre-tax refund subtotal. Measures net food and beverage revenue reversed through refunds."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`order_ingredient_usage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ingredient usage and food cost KPIs at the order level. Enables food cost management, theoretical vs. actual variance analysis, and waste reduction initiatives."
  source: "`vibe_restaurants_v1`.`order`.`order_ingredient_usage`"
  dimensions:
    - name: "usage_type"
      expr: usage_type
      comment: "Type of ingredient usage (standard, waste, comp) for usage-mix analysis."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the ingredient quantity (oz, g, each) for standardized usage reporting."
    - name: "waste_flag"
      expr: waste_flag
      comment: "Flag indicating the usage was classified as waste. Used to segment waste from productive usage."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code for multi-currency cost reporting."
    - name: "usage_date"
      expr: DATE_TRUNC('day', usage_timestamp)
      comment: "Date of ingredient usage for daily food cost trending."
    - name: "usage_week"
      expr: DATE_TRUNC('week', usage_timestamp)
      comment: "ISO week of ingredient usage for weekly food cost period reporting."
  measures:
    - name: "total_usage_records"
      expr: COUNT(1)
      comment: "Total number of ingredient usage records. Baseline volume KPI for usage tracking completeness."
    - name: "total_actual_quantity"
      expr: SUM(CAST(actual_quantity AS DOUBLE))
      comment: "Total actual ingredient quantity used. Measures real consumption for food cost analysis."
    - name: "total_theoretical_quantity"
      expr: SUM(CAST(theoretical_quantity AS DOUBLE))
      comment: "Total theoretical ingredient quantity expected based on recipes. Baseline for variance analysis."
    - name: "total_quantity_variance"
      expr: SUM(CAST(variance_quantity AS DOUBLE))
      comment: "Total variance between actual and theoretical ingredient usage. Positive = over-usage; negative = under-usage."
    - name: "usage_variance_pct"
      expr: ROUND(100.0 * SUM(CAST(variance_quantity AS DOUBLE)) / NULLIF(SUM(CAST(theoretical_quantity AS DOUBLE)), 0), 2)
      comment: "Ingredient usage variance as a percentage of theoretical. Key food cost control KPI."
    - name: "total_cost_amount"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total ingredient cost for all usage records. Core food cost KPI for P&L management."
    - name: "total_extended_cost"
      expr: SUM(CAST(extended_cost AS DOUBLE))
      comment: "Total extended cost (quantity × unit cost). Measures total food cost exposure."
    - name: "avg_unit_cost"
      expr: ROUND(AVG(CAST(unit_cost AS DOUBLE)), 4)
      comment: "Average unit cost of ingredients used. Tracks ingredient cost inflation over time."
    - name: "waste_quantity_total"
      expr: SUM(CASE WHEN waste_flag = TRUE THEN CAST(actual_quantity AS DOUBLE) ELSE 0 END)
      comment: "Total quantity of ingredients classified as waste. Drives waste reduction and sustainability initiatives."
    - name: "waste_cost_amount"
      expr: SUM(CASE WHEN waste_flag = TRUE THEN CAST(cost_amount AS DOUBLE) ELSE 0 END)
      comment: "Total cost of wasted ingredients. Measures financial impact of food waste for cost reduction programs."
    - name: "waste_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN waste_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of usage records classified as waste. Tracks waste frequency for operational improvement."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`order_catering_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Catering order pipeline and revenue KPIs. Used by catering sales leadership to manage pipeline, track conversion, and measure catering channel revenue performance."
  source: "`vibe_restaurants_v1`.`order`.`catering_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the catering order (inquiry, confirmed, fulfilled, cancelled) for pipeline stage analysis."
    - name: "fulfillment_mode"
      expr: fulfillment_mode
      comment: "Fulfillment mode (delivery, pickup, on-site) for catering channel-mix analysis."
    - name: "order_channel"
      expr: order_channel
      comment: "Channel through which the catering order was placed for channel attribution."
    - name: "payment_status"
      expr: CAST(payment_status AS STRING)
      comment: "Payment status of the catering order (deposit paid, balance due, paid in full) for AR management."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code for multi-currency catering revenue reporting."
    - name: "event_date"
      expr: event_date
      comment: "Date of the catering event for event-calendar and capacity planning analysis."
    - name: "event_month"
      expr: DATE_TRUNC('month', event_date)
      comment: "Month of the catering event for monthly catering revenue forecasting."
    - name: "setup_required"
      expr: setup_required
      comment: "Flag indicating setup service is required. Used for labor and logistics planning."
  measures:
    - name: "total_catering_orders"
      expr: COUNT(1)
      comment: "Total number of catering orders. Baseline catering pipeline volume KPI."
    - name: "confirmed_catering_orders"
      expr: COUNT(CASE WHEN order_status = 'confirmed' THEN 1 END)
      comment: "Count of confirmed catering orders. Measures pipeline conversion from inquiry to confirmed."
    - name: "cancelled_catering_orders"
      expr: COUNT(CASE WHEN cancellation_reason IS NOT NULL THEN 1 END)
      comment: "Count of cancelled catering orders. Tracks cancellation rate and revenue at risk."
    - name: "total_quoted_revenue"
      expr: SUM(CAST(quoted_price AS DOUBLE))
      comment: "Total quoted revenue across all catering orders. Measures pipeline value for sales forecasting."
    - name: "total_catering_revenue"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total actual catering revenue. Core catering channel revenue KPI."
    - name: "total_deposit_collected"
      expr: SUM(CAST(deposit_amount AS DOUBLE))
      comment: "Total deposits collected on catering orders. Measures cash flow from catering pipeline."
    - name: "total_balance_due"
      expr: SUM(CAST(balance_due AS DOUBLE))
      comment: "Total outstanding balance due on catering orders. Tracks accounts receivable exposure."
    - name: "total_gratuity"
      expr: SUM(CAST(gratuity_amount AS DOUBLE))
      comment: "Total gratuity collected on catering orders. Informs catering staff compensation."
    - name: "avg_catering_order_value"
      expr: ROUND(AVG(CAST(total_amount AS DOUBLE)), 2)
      comment: "Average catering order value. Tracks deal size trends and upsell effectiveness."
    - name: "cancellation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN cancellation_reason IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of catering orders that were cancelled. Key pipeline health and revenue risk KPI."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`order_tax`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tax collection and compliance KPIs. Used by finance and tax teams to monitor tax liability, exemption rates, and remittance status across jurisdictions."
  source: "`vibe_restaurants_v1`.`order`.`tax`"
  dimensions:
    - name: "tax_type"
      expr: CAST(tax_type AS STRING)
      comment: "Type of tax (sales tax, VAT, excise) for tax-type breakdown in compliance reporting."
    - name: "authority_level"
      expr: authority_level
      comment: "Tax authority level (federal, state, local) for jurisdictional tax analysis."
    - name: "authority_name"
      expr: authority_name
      comment: "Name of the tax authority for jurisdiction-level tax liability reporting."
    - name: "country_code"
      expr: country_code
      comment: "Country code for multi-country tax compliance reporting."
    - name: "state_code"
      expr: state_code
      comment: "State or province code for state-level tax remittance analysis."
    - name: "is_exempt"
      expr: is_exempt
      comment: "Flag indicating the transaction was tax-exempt. Used to track exemption rates and validate certificates."
    - name: "is_refunded"
      expr: is_refunded
      comment: "Flag indicating the tax was refunded. Used for tax liability reconciliation."
    - name: "remittance_status"
      expr: remittance_status
      comment: "Tax remittance status (pending, remitted, overdue) for compliance monitoring."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code for multi-currency tax reporting."
    - name: "tax_period_date"
      expr: period_date
      comment: "Tax period date for period-level tax liability and remittance reporting."
  measures:
    - name: "total_tax_records"
      expr: COUNT(1)
      comment: "Total number of tax line records. Baseline volume KPI for tax transaction completeness."
    - name: "total_tax_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total tax collected across all transactions. Primary tax liability KPI for remittance."
    - name: "total_taxable_amount"
      expr: SUM(CAST(taxable_amount AS DOUBLE))
      comment: "Total taxable base amount. Used to validate effective tax rates and audit compliance."
    - name: "effective_tax_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(amount AS DOUBLE)) / NULLIF(SUM(CAST(taxable_amount AS DOUBLE)), 0), 2)
      comment: "Effective tax rate as a percentage of taxable amount. Validates tax engine accuracy and rate compliance."
    - name: "total_refunded_tax"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total tax refunded. Required for net tax liability calculation and remittance reconciliation."
    - name: "net_tax_liability"
      expr: SUM(CAST(amount AS DOUBLE) - CAST(refund_amount AS DOUBLE))
      comment: "Net tax liability after refunds. Core tax remittance KPI for finance and compliance teams."
    - name: "exempt_transaction_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_exempt = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of tax records that are exempt. Tracks exemption certificate compliance and audit risk."
    - name: "avg_tax_rate"
      expr: ROUND(AVG(CAST(rate AS DOUBLE)), 4)
      comment: "Average tax rate applied across transactions. Monitors rate consistency and jurisdiction-level rate changes."
$$;