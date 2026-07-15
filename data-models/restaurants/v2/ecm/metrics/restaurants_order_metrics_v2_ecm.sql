-- Metric views for domain: order | Business: Restaurants | Version: 2 | Generated on: 2026-07-10 18:21:26

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`order_guest_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core order-level KPIs covering revenue, volume, discounting, tipping, and tax performance across channels, dayparts, order types, and fulfillment modes. Primary steering dashboard for restaurant operations and finance."
  source: "`vibe_restaurants_v1`.`order`.`guest_order`"
  dimensions:
    - name: "order_type"
      expr: order_type
      comment: "Fulfillment type of the order (e.g. dine-in, takeout, delivery, catering)."
    - name: "daypart"
      expr: daypart
      comment: "Time-window segment of the order (e.g. breakfast, lunch, dinner, late-night)."
    - name: "order_status"
      expr: order_status
      comment: "Current lifecycle status of the order (e.g. placed, fulfilled, voided, cancelled)."
    - name: "payment_status"
      expr: payment_status
      comment: "Payment collection status of the order (e.g. paid, pending, refunded)."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code for the order, enabling multi-currency analysis."
    - name: "tender_type"
      expr: tender_type
      comment: "Primary payment tender used (e.g. cash, credit, mobile pay, gift card)."
    - name: "is_lto"
      expr: is_lto
      comment: "Flag indicating whether the order included a limited-time offer item."
    - name: "is_voided"
      expr: is_voided
      comment: "Flag indicating whether the order was voided, used to filter or segment void analysis."
    - name: "placed_date"
      expr: DATE_TRUNC('day', placed_at)
      comment: "Calendar date the order was placed, for daily trend analysis."
    - name: "placed_month"
      expr: DATE_TRUNC('month', placed_at)
      comment: "Calendar month the order was placed, for monthly trend analysis."
    - name: "delivery_provider"
      expr: delivery_provider
      comment: "Third-party delivery provider associated with the order (e.g. DoorDash, Uber Eats)."
  measures:
    - name: "total_orders"
      expr: COUNT(1)
      comment: "Total number of orders placed. Baseline volume KPI for operational throughput and capacity planning."
    - name: "total_revenue"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total gross revenue across all orders. Primary top-line financial KPI for executive reporting and P&L steering."
    - name: "total_subtotal"
      expr: SUM(CAST(subtotal_amount AS DOUBLE))
      comment: "Sum of pre-tax, pre-discount subtotals. Used to isolate food revenue from tax and fee components."
    - name: "total_tax"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected across all orders. Required for tax remittance reporting and compliance."
    - name: "total_discount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount value applied across orders. Tracks promotional spend and its impact on net revenue."
    - name: "total_tip"
      expr: SUM(CAST(tip_amount AS DOUBLE))
      comment: "Total tip amount collected. Relevant for workforce compensation analysis and service quality benchmarking."
    - name: "avg_order_value"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average ticket size per order. Core KPI for menu engineering, upsell effectiveness, and revenue-per-transaction benchmarking."
    - name: "avg_discount_per_order"
      expr: AVG(CAST(discount_amount AS DOUBLE))
      comment: "Average discount applied per order. Measures promotional generosity and its effect on net revenue per transaction."
    - name: "voided_order_count"
      expr: COUNT(CASE WHEN is_voided = TRUE THEN 1 END)
      comment: "Number of voided orders. Elevated void rates signal operational issues, fraud risk, or training gaps."
    - name: "void_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_voided = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of orders that were voided. A key operational quality and loss-prevention metric."
    - name: "lto_order_count"
      expr: COUNT(CASE WHEN is_lto = TRUE THEN 1 END)
      comment: "Number of orders containing a limited-time offer item. Measures LTO adoption and promotional campaign reach."
    - name: "lto_attach_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_lto = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of orders that included an LTO item. Directly measures promotional campaign effectiveness."
    - name: "loyalty_orders"
      expr: COUNT(CASE WHEN member_id IS NOT NULL THEN 1 END)
      comment: "Number of orders placed by loyalty program members. Tracks loyalty program engagement and its contribution to order volume."
    - name: "loyalty_attach_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN member_id IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of orders linked to a loyalty member. Measures loyalty program penetration across total order volume."
    - name: "distinct_guests"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique guests placing orders. Used to distinguish volume growth from guest frequency growth."
    - name: "revenue_per_guest"
      expr: ROUND(SUM(CAST(total_amount AS DOUBLE)) / NULLIF(COUNT(DISTINCT profile_id), 0), 2)
      comment: "Average revenue generated per unique guest. Measures guest monetization and lifetime value contribution per visit cycle."
    - name: "discount_to_revenue_pct"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_amount AS DOUBLE)), 0), 2)
      comment: "Discounts as a percentage of gross revenue. Measures promotional cost burden on top-line revenue."
    - name: "tip_to_revenue_pct"
      expr: ROUND(100.0 * SUM(CAST(tip_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_amount AS DOUBLE)), 0), 2)
      comment: "Tips as a percentage of gross revenue. Benchmarks service quality and gratuity culture across channels and units."
$$;


CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`order_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Item-level sales and profitability KPIs covering revenue, cost, margin, waste, and refund performance per menu item. Drives menu engineering, COGS management, and product mix (PMIX) analysis."
  source: "`vibe_restaurants_v1`.`order`.`order_item`"
  dimensions:
    - name: "daypart_code"
      expr: daypart_code
      comment: "Daypart code associated with the order item (e.g. BK=breakfast, LN=lunch, DN=dinner)."
    - name: "pmix_category"
      expr: pmix_category
      comment: "Product mix category for the item, used to group items for menu engineering analysis (e.g. star, plow-horse, puzzle, dog)."
    - name: "service_channel"
      expr: service_channel
      comment: "Service channel through which the item was ordered (e.g. drive-thru, counter, kiosk, delivery)."
    - name: "item_status"
      expr: item_status
      comment: "Current status of the order item (e.g. prepared, voided, refunded, wasted)."
    - name: "is_combo_component"
      expr: is_combo_component
      comment: "Flag indicating whether the item is part of a combo meal, enabling combo vs. a-la-carte revenue split."
    - name: "is_lto"
      expr: is_lto
      comment: "Flag indicating whether the item is a limited-time offer, for LTO performance tracking."
    - name: "refund_flag"
      expr: refund_flag
      comment: "Flag indicating whether the item was refunded, for quality and loss analysis."
    - name: "waste_flag"
      expr: waste_flag
      comment: "Flag indicating whether the item was wasted, for food cost and waste management reporting."
    - name: "tax_exempt_flag"
      expr: tax_exempt_flag
      comment: "Flag indicating whether the item is tax-exempt, for tax compliance and reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code for the item transaction."
    - name: "created_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Calendar date the order item was created, for daily sales trend analysis."
    - name: "created_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Calendar month the order item was created, for monthly PMIX and revenue trend analysis."
  measures:
    - name: "total_items_sold"
      expr: COUNT(1)
      comment: "Total number of order item lines. Baseline volume KPI for product mix and throughput analysis."
    - name: "total_quantity_sold"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity of items sold (accounts for multi-quantity line items). Core PMIX volume metric."
    - name: "total_gross_revenue"
      expr: SUM(CAST(line_gross_amount AS DOUBLE))
      comment: "Total gross revenue from order items before discounts. Used for menu item revenue ranking and engineering."
    - name: "total_net_revenue"
      expr: SUM(CAST(line_net_amount AS DOUBLE))
      comment: "Total net revenue from order items after discounts. Measures actual realized revenue per item."
    - name: "total_cogs"
      expr: SUM(CAST(cost AS DOUBLE))
      comment: "Total cost of goods sold for order items. Core input for gross margin and food cost percentage calculations."
    - name: "total_line_discount"
      expr: SUM(CAST(line_discount_amount AS DOUBLE))
      comment: "Total discount applied at the item line level. Measures item-level promotional cost."
    - name: "total_tax"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected on order items. Required for tax compliance and remittance reporting."
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total refund value issued at the item level. Tracks quality failures and their financial impact."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average selling price per item unit. Used for price realization analysis and menu pricing strategy."
    - name: "avg_item_cost"
      expr: AVG(CAST(cost AS DOUBLE))
      comment: "Average cost per order item line. Benchmarks COGS efficiency across menu categories."
    - name: "gross_margin_amount"
      expr: SUM((CAST(line_gross_amount AS DOUBLE)) - (CAST(cost AS DOUBLE)))
      comment: "Total gross margin (gross revenue minus COGS) across order items. Primary profitability KPI for menu engineering."
    - name: "gross_margin_pct"
      expr: ROUND(100.0 * (SUM(CAST(line_gross_amount AS DOUBLE)) - SUM(CAST(cost AS DOUBLE))) / NULLIF(SUM(CAST(line_gross_amount AS DOUBLE)), 0), 2)
      comment: "Gross margin as a percentage of gross revenue. Measures item-level profitability for menu portfolio decisions."
    - name: "refund_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN refund_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of order items that were refunded. Elevated rates signal quality, preparation, or fulfillment issues."
    - name: "waste_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN waste_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of order items flagged as wasted. Drives food cost reduction and sustainability initiatives."
    - name: "lto_item_count"
      expr: COUNT(CASE WHEN is_lto = TRUE THEN 1 END)
      comment: "Number of LTO item lines sold. Measures limited-time offer adoption at the item level."
    - name: "lto_revenue"
      expr: SUM(CASE WHEN is_lto = TRUE THEN CAST(line_gross_amount AS DOUBLE) ELSE 0 END)
      comment: "Gross revenue attributable to LTO items. Quantifies the financial contribution of limited-time promotions."
    - name: "combo_component_revenue"
      expr: SUM(CASE WHEN is_combo_component = TRUE THEN CAST(line_gross_amount AS DOUBLE) ELSE 0 END)
      comment: "Revenue from items sold as part of combo meals. Measures combo meal contribution to total item revenue."
    - name: "discount_to_gross_revenue_pct"
      expr: ROUND(100.0 * SUM(CAST(line_discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(line_gross_amount AS DOUBLE)), 0), 2)
      comment: "Item-level discount as a percentage of gross revenue. Measures promotional cost burden at the item level."
$$;


CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`order_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment transaction KPIs covering tender mix, tip performance, split tender usage, void rates, and interchange cost. Drives treasury, fraud, and payment operations decisions."
  source: "`vibe_restaurants_v1`.`order`.`payment`"
  dimensions:
    - name: "tender_type"
      expr: tender_type
      comment: "Payment tender type (e.g. cash, credit card, debit card, mobile pay, gift card). Core dimension for tender mix analysis."
    - name: "card_type"
      expr: card_type
      comment: "Card network type (e.g. Visa, Mastercard, Amex). Used for interchange cost analysis."
    - name: "payment_status"
      expr: payment_status
      comment: "Current status of the payment transaction (e.g. captured, pending, voided, refunded)."
    - name: "channel"
      expr: channel
      comment: "Sales channel associated with the payment (e.g. drive-thru, kiosk, online)."
    - name: "daypart"
      expr: daypart
      comment: "Daypart during which the payment was captured, for time-of-day tender mix analysis."
    - name: "is_split_tender"
      expr: is_split_tender
      comment: "Flag indicating whether the payment was part of a split-tender transaction."
    - name: "is_voided"
      expr: is_voided
      comment: "Flag indicating whether the payment was voided."
    - name: "offline_authorization_flag"
      expr: offline_authorization_flag
      comment: "Flag indicating whether the payment was authorized offline, a risk indicator for payment operations."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code for the payment."
    - name: "settlement_date"
      expr: settlement_date
      comment: "Date the payment was settled, for cash flow and reconciliation analysis."
    - name: "captured_month"
      expr: DATE_TRUNC('month', captured_timestamp)
      comment: "Month the payment was captured, for monthly payment volume and mix trend analysis."
    - name: "processor_name"
      expr: processor_name
      comment: "Payment processor used (e.g. Stripe, Adyen, Square). Used for processor performance and cost benchmarking."
  measures:
    - name: "total_payments"
      expr: COUNT(1)
      comment: "Total number of payment transactions. Baseline volume KPI for payment operations."
    - name: "total_tendered_amount"
      expr: SUM(CAST(tendered_amount AS DOUBLE))
      comment: "Total amount tendered by guests. Measures gross payment inflow before change."
    - name: "total_applied_amount"
      expr: SUM(CAST(applied_amount AS DOUBLE))
      comment: "Total payment amount actually applied to orders. Core revenue collection KPI."
    - name: "total_tip_amount"
      expr: SUM(CAST(tip_amount AS DOUBLE))
      comment: "Total tip amount collected across all payments. Measures gratuity revenue and service quality signal."
    - name: "total_interchange_fee"
      expr: SUM(CAST(interchange_fee_amount AS DOUBLE))
      comment: "Total interchange fees paid to card networks. Directly impacts payment processing cost and net revenue."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount applied at the payment level. Tracks payment-level promotional cost."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected through payments. Required for tax remittance reconciliation."
    - name: "avg_tip_per_payment"
      expr: AVG(CAST(tip_amount AS DOUBLE))
      comment: "Average tip amount per payment transaction. Benchmarks gratuity culture and service quality across channels."
    - name: "tip_attach_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN CAST(tip_amount AS DOUBLE) > 0 THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of payments that included a tip. Measures tip adoption rate across channels and tender types."
    - name: "voided_payment_count"
      expr: COUNT(CASE WHEN is_voided = TRUE THEN 1 END)
      comment: "Number of voided payment transactions. Elevated counts signal fraud risk or operational errors."
    - name: "void_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_voided = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of payments that were voided. Key fraud and operational quality indicator."
    - name: "split_tender_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_split_tender = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of payments using split tender. Measures complexity of payment operations and guest payment behavior."
    - name: "offline_auth_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN offline_authorization_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of payments authorized offline. High rates indicate connectivity issues and elevated chargeback risk."
    - name: "interchange_cost_pct"
      expr: ROUND(100.0 * SUM(CAST(interchange_fee_amount AS DOUBLE)) / NULLIF(SUM(CAST(applied_amount AS DOUBLE)), 0), 2)
      comment: "Interchange fees as a percentage of applied payment amount. Measures payment processing cost efficiency."
$$;


CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`order_refund`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Refund KPIs covering refund volume, value, fraud risk, and guest impact. Drives quality management, fraud prevention, and guest recovery strategy."
  source: "`vibe_restaurants_v1`.`order`.`refund`"
  dimensions:
    - name: "refund_type"
      expr: refund_type
      comment: "Type of refund issued (e.g. full, partial, loyalty points). Used to categorize refund causes and financial impact."
    - name: "reason_code"
      expr: reason_code
      comment: "Coded reason for the refund (e.g. wrong item, quality issue, late delivery). Drives root cause analysis."
    - name: "refund_status"
      expr: refund_status
      comment: "Current status of the refund (e.g. approved, pending, voided)."
    - name: "order_channel"
      expr: order_channel
      comment: "Sales channel of the original order associated with the refund."
    - name: "daypart"
      expr: daypart
      comment: "Daypart of the original order, for time-of-day refund pattern analysis."
    - name: "method"
      expr: method
      comment: "Refund method used (e.g. original payment method, cash, gift card)."
    - name: "is_fraudulent"
      expr: is_fraudulent
      comment: "Flag indicating whether the refund was flagged as fraudulent."
    - name: "is_voided"
      expr: is_voided
      comment: "Flag indicating whether the refund was voided."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code for the refund."
    - name: "refunded_month"
      expr: DATE_TRUNC('month', refunded_at)
      comment: "Month the refund was issued, for monthly refund trend analysis."
    - name: "third_party_delivery_provider"
      expr: third_party_delivery_provider
      comment: "Third-party delivery provider associated with the refund, for delivery partner quality benchmarking."
  measures:
    - name: "total_refunds"
      expr: COUNT(1)
      comment: "Total number of refund transactions. Baseline volume KPI for quality and guest recovery operations."
    - name: "total_refund_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total monetary value of refunds issued. Measures financial exposure from quality failures and guest recovery."
    - name: "total_refund_subtotal"
      expr: SUM(CAST(subtotal AS DOUBLE))
      comment: "Total pre-tax refund subtotal. Used to isolate food cost impact of refunds from tax components."
    - name: "total_refund_tax"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax refunded. Required for tax remittance adjustments and compliance reporting."
    - name: "avg_refund_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average refund value per transaction. Benchmarks refund severity and guides recovery policy thresholds."
    - name: "fraudulent_refund_count"
      expr: COUNT(CASE WHEN is_fraudulent = TRUE THEN 1 END)
      comment: "Number of refunds flagged as fraudulent. Key fraud risk KPI for loss prevention and policy enforcement."
    - name: "fraud_refund_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_fraudulent = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of refunds flagged as fraudulent. Measures fraud exposure in the refund process."
    - name: "fraudulent_refund_amount"
      expr: SUM(CASE WHEN is_fraudulent = TRUE THEN CAST(amount AS DOUBLE) ELSE 0 END)
      comment: "Total monetary value of fraudulent refunds. Quantifies financial loss from refund fraud."
    - name: "csat_impact_refund_count"
      expr: COUNT(CASE WHEN csat_impact_flag = TRUE THEN 1 END)
      comment: "Number of refunds flagged as having a guest satisfaction impact. Measures quality failures affecting guest loyalty."
    - name: "nps_survey_sent_count"
      expr: COUNT(CASE WHEN nps_survey_sent = TRUE THEN 1 END)
      comment: "Number of refunds where an NPS recovery survey was sent. Measures guest recovery outreach coverage."
    - name: "nps_survey_coverage_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN nps_survey_sent = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of refunds where an NPS survey was sent. Measures completeness of guest recovery follow-up."
$$;


CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`order_drive_thru_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Drive-thru speed-of-service (SOS) and operational KPIs covering throughput, SOS variance, exception rates, and pull-forward usage. Primary dashboard for drive-thru operations management and brand SOS compliance."
  source: "`vibe_restaurants_v1`.`order`.`drive_thru_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of drive-thru event (e.g. arrival, order, payment, pickup). Used to analyze each stage of the drive-thru journey."
    - name: "daypart"
      expr: daypart
      comment: "Daypart of the drive-thru event (e.g. breakfast, lunch, dinner). Enables SOS analysis by time of day."
    - name: "order_channel"
      expr: order_channel
      comment: "Order channel for the drive-thru event (e.g. drive-thru, mobile order ahead)."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used at the drive-thru window."
    - name: "exception_flag"
      expr: exception_flag
      comment: "Flag indicating whether an exception occurred during this drive-thru event."
    - name: "pull_forward_flag"
      expr: pull_forward_flag
      comment: "Flag indicating whether the vehicle was pulled forward (out of the lane) to wait for their order."
    - name: "franchise_flag"
      expr: franchise_flag
      comment: "Flag indicating whether the unit is franchise-operated, for franchise vs. company-owned SOS benchmarking."
    - name: "weather_condition"
      expr: weather_condition
      comment: "Weather condition at the time of the event. Used to contextualize SOS variance due to external factors."
    - name: "business_date"
      expr: business_date
      comment: "Business date of the drive-thru event, for daily SOS trend analysis."
    - name: "business_month"
      expr: DATE_TRUNC('month', event_timestamp)
      comment: "Month of the drive-thru event, for monthly SOS trend analysis."
    - name: "lane_number"
      expr: lane_number
      comment: "Drive-thru lane number, for multi-lane unit performance comparison."
  measures:
    - name: "total_drive_thru_events"
      expr: COUNT(1)
      comment: "Total number of drive-thru events recorded. Baseline throughput volume KPI."
    - name: "total_order_amount"
      expr: SUM(CAST(order_total_amount AS DOUBLE))
      comment: "Total revenue from drive-thru orders. Measures drive-thru channel revenue contribution."
    - name: "avg_order_amount"
      expr: AVG(CAST(order_total_amount AS DOUBLE))
      comment: "Average ticket size for drive-thru orders. Benchmarks upsell effectiveness in the drive-thru channel."
    - name: "avg_elapsed_time_seconds"
      expr: AVG(CAST(elapsed_time_seconds AS DOUBLE))
      comment: "Average elapsed time per drive-thru event stage. Core SOS measurement for operational efficiency."
    - name: "avg_cumulative_time_seconds"
      expr: AVG(CAST(cumulative_time_seconds AS DOUBLE))
      comment: "Average cumulative time from arrival through current event stage. Measures total drive-thru journey time."
    - name: "avg_sos_target_seconds"
      expr: AVG(CAST(sos_target_seconds AS DOUBLE))
      comment: "Average SOS target in seconds for drive-thru events. Used as the benchmark denominator for SOS compliance."
    - name: "avg_sos_variance_seconds"
      expr: AVG(CAST(sos_variance_seconds AS DOUBLE))
      comment: "Average variance between actual and target SOS. Negative values indicate faster-than-target service; positive values indicate delays."
    - name: "exception_event_count"
      expr: COUNT(CASE WHEN exception_flag = TRUE THEN 1 END)
      comment: "Number of drive-thru events with exceptions. Measures operational disruptions in the drive-thru lane."
    - name: "exception_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN exception_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of drive-thru events with exceptions. Key operational quality KPI for drive-thru management."
    - name: "pull_forward_count"
      expr: COUNT(CASE WHEN pull_forward_flag = TRUE THEN 1 END)
      comment: "Number of vehicles pulled forward out of the drive-thru lane. High counts indicate kitchen throughput bottlenecks."
    - name: "pull_forward_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN pull_forward_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of drive-thru orders requiring a pull-forward. Measures kitchen throughput pressure and SOS inflation risk."
    - name: "sos_breach_count"
      expr: COUNT(CASE WHEN CAST(sos_variance_seconds AS DOUBLE) > 0 THEN 1 END)
      comment: "Number of drive-thru events where actual time exceeded the SOS target. Measures SOS compliance failures."
    - name: "sos_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN CAST(sos_variance_seconds AS DOUBLE) <= 0 THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of drive-thru events meeting or beating the SOS target. Primary brand SOS compliance KPI."
$$;


CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`order_kds_ticket`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Kitchen Display System (KDS) ticket KPIs covering kitchen throughput, re-fire rates, SOS compliance, and void rates. Drives kitchen operations management and food quality assurance."
  source: "`vibe_restaurants_v1`.`order`.`kds_ticket`"
  dimensions:
    - name: "daypart"
      expr: daypart
      comment: "Daypart of the KDS ticket (e.g. breakfast, lunch, dinner). Enables kitchen throughput analysis by time of day."
    - name: "order_channel"
      expr: order_channel
      comment: "Order channel associated with the KDS ticket. Used to compare kitchen performance across channels."
    - name: "ticket_status"
      expr: ticket_status
      comment: "Current status of the KDS ticket (e.g. open, bumped, completed, voided)."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level assigned to the KDS ticket. Used to analyze high-priority order handling performance."
    - name: "re_fire_flag"
      expr: re_fire_flag
      comment: "Flag indicating whether the ticket was re-fired (remade). Measures quality failures requiring remakes."
    - name: "sos_met_flag"
      expr: sos_met_flag
      comment: "Flag indicating whether the ticket met its SOS target. Core kitchen SOS compliance dimension."
    - name: "void_flag"
      expr: void_flag
      comment: "Flag indicating whether the KDS ticket was voided."
    - name: "created_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Calendar date the KDS ticket was created, for daily kitchen throughput trend analysis."
    - name: "created_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Calendar month the KDS ticket was created, for monthly kitchen performance trend analysis."
  measures:
    - name: "total_kds_tickets"
      expr: COUNT(1)
      comment: "Total number of KDS tickets. Baseline kitchen throughput volume KPI."
    - name: "sos_met_count"
      expr: COUNT(CASE WHEN sos_met_flag = TRUE THEN 1 END)
      comment: "Number of KDS tickets that met the SOS target. Measures kitchen speed-of-service compliance."
    - name: "sos_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sos_met_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of KDS tickets meeting the SOS target. Primary kitchen SOS compliance KPI for operations management."
    - name: "re_fire_count"
      expr: COUNT(CASE WHEN re_fire_flag = TRUE THEN 1 END)
      comment: "Number of KDS tickets that were re-fired (remade). Measures food quality failures requiring remakes."
    - name: "re_fire_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN re_fire_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of KDS tickets requiring a re-fire. Key food quality and waste KPI for kitchen management."
    - name: "voided_ticket_count"
      expr: COUNT(CASE WHEN void_flag = TRUE THEN 1 END)
      comment: "Number of voided KDS tickets. Elevated counts signal order accuracy or operational issues."
    - name: "void_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN void_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of KDS tickets that were voided. Measures order accuracy and kitchen operational quality."
$$;


CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`order_discount`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Discount and promotional KPIs covering discount volume, value, authorization patterns, void rates, and revenue impact. Drives promotional effectiveness, loss prevention, and pricing strategy decisions."
  source: "`vibe_restaurants_v1`.`order`.`discount`"
  dimensions:
    - name: "discount_type"
      expr: discount_type
      comment: "Type of discount applied (e.g. employee meal, coupon, loyalty redemption, manager comp). Used to categorize discount causes."
    - name: "scope"
      expr: scope
      comment: "Scope of the discount (e.g. order-level, item-level). Used to analyze discount application patterns."
    - name: "daypart_restriction"
      expr: daypart_restriction
      comment: "Daypart restriction associated with the discount. Used to analyze time-of-day promotional effectiveness."
    - name: "channel_restriction"
      expr: channel_restriction
      comment: "Channel restriction for the discount. Used to analyze channel-specific promotional performance."
    - name: "is_pre_approved"
      expr: is_pre_approved
      comment: "Flag indicating whether the discount was pre-approved (vs. requiring manager authorization at time of use)."
    - name: "is_stackable"
      expr: is_stackable
      comment: "Flag indicating whether the discount can be stacked with other discounts."
    - name: "is_voided"
      expr: is_voided
      comment: "Flag indicating whether the discount was voided."
    - name: "tax_treatment"
      expr: tax_treatment
      comment: "Tax treatment applied to the discount (e.g. pre-tax, post-tax). Used for tax compliance analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code for the discount."
    - name: "applied_date"
      expr: DATE_TRUNC('day', applied_at)
      comment: "Calendar date the discount was applied, for daily promotional spend trend analysis."
    - name: "applied_month"
      expr: DATE_TRUNC('month', applied_at)
      comment: "Calendar month the discount was applied, for monthly promotional effectiveness analysis."
  measures:
    - name: "total_discounts"
      expr: COUNT(1)
      comment: "Total number of discount transactions. Baseline volume KPI for promotional activity."
    - name: "total_discount_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total monetary value of discounts applied. Measures total promotional spend and its impact on net revenue."
    - name: "total_revenue_impact"
      expr: SUM(CAST(revenue_impact_amount AS DOUBLE))
      comment: "Total revenue impact of discounts. Quantifies the net revenue effect of promotional activity."
    - name: "total_cogs_impact"
      expr: SUM(CAST(cogs_impact_amount AS DOUBLE))
      comment: "Total COGS impact of discounts. Measures the food cost effect of promotional giveaways."
    - name: "avg_discount_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average discount value per transaction. Benchmarks discount generosity and guides policy thresholds."
    - name: "avg_discount_percentage"
      expr: AVG(CAST(percentage AS DOUBLE))
      comment: "Average discount percentage applied. Measures the depth of discounting across promotional events."
    - name: "voided_discount_count"
      expr: COUNT(CASE WHEN is_voided = TRUE THEN 1 END)
      comment: "Number of voided discounts. Elevated counts may indicate misuse or fraud in the discount process."
    - name: "void_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_voided = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of discounts that were voided. Key loss prevention and discount integrity KPI."
    - name: "manager_auth_required_count"
      expr: COUNT(CASE WHEN authorization_required = TRUE THEN 1 END)
      comment: "Number of discounts requiring manager authorization. Measures the volume of high-risk discount events requiring oversight."
    - name: "manager_auth_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN authorization_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of discounts requiring manager authorization. Measures the proportion of high-risk discount activity."
    - name: "discount_to_original_price_pct"
      expr: ROUND(100.0 * SUM(CAST(amount AS DOUBLE)) / NULLIF(SUM(CAST(original_price AS DOUBLE)), 0), 2)
      comment: "Total discount as a percentage of original price. Measures the effective discount depth across all promotional activity."
$$;


CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`order_delivery_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Delivery channel KPIs covering delivery performance, platform commission costs, customer ratings, and exception rates. Drives third-party delivery partner management and delivery operations decisions."
  source: "`vibe_restaurants_v1`.`order`.`delivery_order`"
  dimensions:
    - name: "delivery_status"
      expr: delivery_status
      comment: "Current status of the delivery order (e.g. dispatched, delivered, failed, cancelled)."
    - name: "delivery_exception_type"
      expr: delivery_exception_type
      comment: "Type of delivery exception (e.g. late delivery, wrong address, missing item). Used for root cause analysis."
    - name: "is_contactless_delivery"
      expr: is_contactless_delivery
      comment: "Flag indicating whether the delivery was contactless. Used for contactless adoption and safety compliance tracking."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code for the delivery order."
    - name: "delivery_country_code"
      expr: delivery_country_code
      comment: "Country code of the delivery address, for geographic delivery performance analysis."
    - name: "order_placed_date"
      expr: DATE_TRUNC('day', order_placed_timestamp)
      comment: "Calendar date the delivery order was placed, for daily delivery volume trend analysis."
    - name: "order_placed_month"
      expr: DATE_TRUNC('month', order_placed_timestamp)
      comment: "Calendar month the delivery order was placed, for monthly delivery performance trend analysis."
  measures:
    - name: "total_delivery_orders"
      expr: COUNT(1)
      comment: "Total number of delivery orders. Baseline delivery channel volume KPI."
    - name: "total_delivery_fee_revenue"
      expr: SUM(CAST(delivery_fee_amount AS DOUBLE))
      comment: "Total delivery fees collected. Measures delivery fee revenue contribution and guest cost burden."
    - name: "total_platform_commission"
      expr: SUM(CAST(platform_commission_amount AS DOUBLE))
      comment: "Total commission paid to delivery platforms. Measures the cost of third-party delivery channel usage."
    - name: "total_tip_amount"
      expr: SUM(CAST(tip_amount AS DOUBLE))
      comment: "Total tip amount collected on delivery orders. Measures driver gratuity and service quality signal."
    - name: "avg_delivery_distance_km"
      expr: AVG(CAST(delivery_distance_km AS DOUBLE))
      comment: "Average delivery distance in kilometers. Used for delivery zone optimization and cost modeling."
    - name: "avg_platform_commission_rate"
      expr: AVG(CAST(platform_commission_rate AS DOUBLE))
      comment: "Average platform commission rate. Benchmarks delivery platform cost efficiency for contract negotiations."
    - name: "platform_commission_pct_of_fee"
      expr: ROUND(100.0 * SUM(CAST(platform_commission_amount AS DOUBLE)) / NULLIF(SUM(CAST(delivery_fee_amount AS DOUBLE)), 0), 2)
      comment: "Platform commission as a percentage of delivery fee revenue. Measures delivery channel profitability after platform costs."
    - name: "exception_order_count"
      expr: COUNT(CASE WHEN delivery_exception_type IS NOT NULL THEN 1 END)
      comment: "Number of delivery orders with exceptions. Measures delivery quality failures and their frequency."
    - name: "exception_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN delivery_exception_type IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of delivery orders with exceptions. Key delivery quality KPI for platform and operations management."
    - name: "contactless_delivery_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_contactless_delivery = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of delivery orders fulfilled contactlessly. Measures contactless adoption and safety compliance."
$$;


CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`order_ingredient_usage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ingredient usage and waste KPIs at the order item level. Drives food cost management, waste reduction, and inventory accuracy decisions."
  source: "`vibe_restaurants_v1`.`order`.`order_ingredient_usage`"
  dimensions:
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for ingredient usage (e.g. oz, g, ml). Used for standardized usage comparison across ingredients."
    - name: "waste_flag"
      expr: waste_flag
      comment: "Flag indicating whether the ingredient usage was classified as waste."
    - name: "waste_reason"
      expr: waste_reason
      comment: "Reason for ingredient waste (e.g. overproduction, spoilage, prep error). Drives waste root cause analysis."
  measures:
    - name: "total_ingredient_usage_lines"
      expr: COUNT(1)
      comment: "Total number of ingredient usage records. Baseline volume KPI for ingredient consumption tracking."
    - name: "total_quantity_used"
      expr: SUM(CAST(quantity_used AS DOUBLE))
      comment: "Total quantity of ingredients consumed across all order items. Core input for food cost and inventory depletion analysis."
    - name: "total_ingredient_cost"
      expr: SUM(CAST(unit_cost AS DOUBLE))
      comment: "Total ingredient cost across all usage records. Measures raw material cost contribution to COGS."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost per ingredient usage record. Benchmarks ingredient cost efficiency and supplier pricing."
    - name: "waste_line_count"
      expr: COUNT(CASE WHEN waste_flag = TRUE THEN 1 END)
      comment: "Number of ingredient usage records flagged as waste. Measures waste event frequency."
    - name: "waste_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN waste_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of ingredient usage records classified as waste. Key food cost and sustainability KPI."
    - name: "waste_quantity"
      expr: SUM(CASE WHEN waste_flag = TRUE THEN CAST(quantity_used AS DOUBLE) ELSE 0 END)
      comment: "Total quantity of ingredients wasted. Measures the volume of food waste for sustainability and cost reduction initiatives."
    - name: "waste_cost"
      expr: SUM(CASE WHEN waste_flag = TRUE THEN CAST(unit_cost AS DOUBLE) ELSE 0 END)
      comment: "Total cost of wasted ingredients. Quantifies the financial impact of food waste on COGS."
    - name: "waste_cost_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN waste_flag = TRUE THEN CAST(unit_cost AS DOUBLE) ELSE 0 END) / NULLIF(SUM(CAST(unit_cost AS DOUBLE)), 0), 2)
      comment: "Waste cost as a percentage of total ingredient cost. Measures the financial burden of waste on food cost."
$$;


CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`order_catering_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Catering order KPIs covering revenue, deposit collection, gratuity, cancellation rates, and fulfillment performance. Drives catering sales strategy and event operations management."
  source: "`vibe_restaurants_v1`.`order`.`catering_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the catering order (e.g. confirmed, fulfilled, cancelled, pending)."
    - name: "fulfillment_mode"
      expr: fulfillment_mode
      comment: "Fulfillment mode for the catering order (e.g. delivery, pickup, on-site). Used to analyze catering channel mix."
    - name: "payment_status"
      expr: payment_status
      comment: "Payment collection status of the catering order."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used for the catering order."
    - name: "order_channel"
      expr: order_channel
      comment: "Channel through which the catering order was placed (e.g. phone, online, in-person)."
    - name: "setup_required"
      expr: setup_required
      comment: "Flag indicating whether on-site setup is required for the catering order."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code for the catering order."
    - name: "event_month"
      expr: DATE_TRUNC('month', event_date)
      comment: "Month of the catering event, for monthly catering revenue and volume trend analysis."
    - name: "placed_month"
      expr: DATE_TRUNC('month', placed_at)
      comment: "Month the catering order was placed, for lead time and booking trend analysis."
  measures:
    - name: "total_catering_orders"
      expr: COUNT(1)
      comment: "Total number of catering orders. Baseline volume KPI for catering channel performance."
    - name: "total_catering_revenue"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total gross revenue from catering orders. Primary top-line KPI for catering channel financial performance."
    - name: "total_quoted_price"
      expr: SUM(CAST(quoted_price AS DOUBLE))
      comment: "Total quoted price across catering orders. Used to measure quote-to-close conversion and pricing accuracy."
    - name: "total_deposit_collected"
      expr: SUM(CAST(deposit_amount AS DOUBLE))
      comment: "Total deposit amount collected on catering orders. Measures advance cash collection and commitment rate."
    - name: "total_balance_due"
      expr: SUM(CAST(balance_due AS DOUBLE))
      comment: "Total outstanding balance due on catering orders. Measures accounts receivable exposure in the catering channel."
    - name: "total_gratuity"
      expr: SUM(CAST(gratuity_amount AS DOUBLE))
      comment: "Total gratuity collected on catering orders. Measures service revenue and staff compensation from catering events."
    - name: "total_tax"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected on catering orders. Required for tax remittance and compliance reporting."
    - name: "avg_catering_order_value"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average catering order value. Benchmarks catering ticket size and guides package pricing strategy."
    - name: "cancellation_count"
      expr: COUNT(CASE WHEN order_status = 'cancelled' THEN 1 END)
      comment: "Number of cancelled catering orders. Measures catering demand reliability and revenue at risk."
    - name: "cancellation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN order_status = 'cancelled' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of catering orders that were cancelled. Key catering channel reliability and revenue protection KPI."
    - name: "quote_to_revenue_ratio"
      expr: ROUND(SUM(CAST(total_amount AS DOUBLE)) / NULLIF(SUM(CAST(quoted_price AS DOUBLE)), 0), 4)
      comment: "Ratio of actual revenue to quoted price. Measures pricing accuracy and upsell/downsell patterns in catering."
    - name: "deposit_coverage_pct"
      expr: ROUND(100.0 * SUM(CAST(deposit_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_amount AS DOUBLE)), 0), 2)
      comment: "Deposit collected as a percentage of total catering order value. Measures advance payment coverage and financial risk mitigation."
$$;
