-- Metric views for domain: order | Business: Retail | Version: 2 | Generated on: 2026-07-12 15:23:39

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`order_header`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core order-level KPIs including revenue, order volume, fulfillment performance, and channel mix for strategic business steering"
  source: "`vibe_retail_v1`.`order`.`header`"
  dimensions:
    - name: "order_date"
      expr: DATE(order_date)
      comment: "Date the order was placed, primary time dimension for order trend analysis"
    - name: "order_month"
      expr: DATE_TRUNC('MONTH', order_date)
      comment: "Month of order placement for monthly performance tracking"
    - name: "order_status"
      expr: order_status
      comment: "Current status of the order (e.g., pending, shipped, delivered, cancelled) for funnel analysis"
    - name: "order_type"
      expr: order_type
      comment: "Type of order (e.g., standard, subscription, bulk) for segmentation"
    - name: "channel"
      expr: channel
      comment: "Sales channel (e.g., online, in-store, mobile) for channel performance analysis"
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status (e.g., paid, pending, failed) for revenue recognition and risk management"
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used (e.g., credit card, digital wallet, cash) for payment mix analysis"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the transaction for multi-currency reporting"
    - name: "billing_country_code"
      expr: billing_country_code
      comment: "Billing country for geographic revenue analysis"
    - name: "shipping_country_code"
      expr: shipping_country_code
      comment: "Shipping destination country for fulfillment geography analysis"
    - name: "carrier_code"
      expr: carrier_code
      comment: "Shipping carrier code for carrier performance analysis"
    - name: "delivery_performance"
      expr: CASE WHEN actual_delivery_date IS NOT NULL AND promised_delivery_date IS NOT NULL THEN CASE WHEN actual_delivery_date <= promised_delivery_date THEN 'On Time' WHEN actual_delivery_date > promised_delivery_date THEN 'Late' ELSE 'Unknown' END ELSE 'Pending' END
      comment: "Delivery performance classification (On Time, Late, Pending) for SLA tracking"
  measures:
    - name: "total_orders"
      expr: COUNT(1)
      comment: "Total number of orders placed, primary volume KPI for demand tracking"
    - name: "unique_customers"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique customers who placed orders, key for customer acquisition and retention analysis"
    - name: "gross_merchandise_value"
      expr: SUM(CAST(grand_total_amount AS DOUBLE))
      comment: "Total GMV (grand total including tax and shipping), primary revenue KPI for business performance"
    - name: "total_subtotal_amount"
      expr: SUM(CAST(subtotal_amount AS DOUBLE))
      comment: "Sum of order subtotals before tax and shipping, core product revenue metric"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected across orders for tax remittance and compliance reporting"
    - name: "total_shipping_amount"
      expr: SUM(CAST(shipping_amount AS DOUBLE))
      comment: "Total shipping revenue collected, key for shipping profitability analysis"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts applied to orders, critical for promotional effectiveness and margin analysis"
    - name: "avg_order_value"
      expr: AVG(CAST(grand_total_amount AS DOUBLE))
      comment: "Average order value (AOV), key metric for pricing strategy and customer value optimization"
    - name: "avg_subtotal_per_order"
      expr: AVG(CAST(subtotal_amount AS DOUBLE))
      comment: "Average product subtotal per order, measures basket size before fees"
    - name: "discount_penetration_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN CAST(discount_amount AS DOUBLE) > 0 THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of orders with discounts applied, measures promotional reach and dependency"
    - name: "avg_discount_per_discounted_order"
      expr: AVG(CASE WHEN CAST(discount_amount AS DOUBLE) > 0 THEN CAST(discount_amount AS DOUBLE) END)
      comment: "Average discount amount for orders that received discounts, measures promotional depth"
    - name: "on_time_delivery_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN actual_delivery_date IS NOT NULL AND promised_delivery_date IS NOT NULL AND actual_delivery_date <= promised_delivery_date THEN 1 END) / NULLIF(COUNT(CASE WHEN actual_delivery_date IS NOT NULL AND promised_delivery_date IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of delivered orders that met promised delivery date, critical SLA and customer satisfaction metric"
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`order_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-item level KPIs for product performance, margin analysis, fulfillment efficiency, and inventory management"
  source: "`vibe_retail_v1`.`order`.`order_line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Status of the order line (e.g., pending, shipped, cancelled) for fulfillment funnel analysis"
    - name: "fulfillment_method"
      expr: fulfillment_method
      comment: "Fulfillment method (e.g., ship from DC, ship from store, pickup) for operational efficiency analysis"
    - name: "sku"
      expr: sku
      comment: "Product SKU for product-level performance analysis"
    - name: "backorder_flag"
      expr: backorder_flag
      comment: "Indicates if line item is on backorder, critical for inventory availability analysis"
    - name: "gift_flag"
      expr: gift_flag
      comment: "Indicates if line item is a gift, useful for gift program analysis"
    - name: "substitution_flag"
      expr: substitution_flag
      comment: "Indicates if product was substituted, measures fulfillment flexibility and customer impact"
    - name: "return_reason_code"
      expr: return_reason_code
      comment: "Reason code for returns, critical for quality and customer satisfaction root cause analysis"
    - name: "cancellation_reason_code"
      expr: cancellation_reason_code
      comment: "Reason code for cancellations, key for operational issue identification"
    - name: "order_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month the order line was created for time-series analysis"
  measures:
    - name: "total_order_lines"
      expr: COUNT(1)
      comment: "Total number of order lines, measures order complexity and operational volume"
    - name: "total_units_ordered"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total units ordered across all lines, primary volume metric for demand planning"
    - name: "total_units_shipped"
      expr: SUM(CAST(shipped_quantity AS DOUBLE))
      comment: "Total units successfully shipped, key fulfillment performance metric"
    - name: "total_units_cancelled"
      expr: SUM(CAST(cancelled_quantity AS DOUBLE))
      comment: "Total units cancelled, measures fulfillment failure and customer dissatisfaction"
    - name: "total_units_returned"
      expr: SUM(CAST(returned_quantity AS DOUBLE))
      comment: "Total units returned, critical for quality issues and reverse logistics cost"
    - name: "gross_line_revenue"
      expr: SUM(CAST(extended_price AS DOUBLE))
      comment: "Total extended price (quantity × unit price) before discounts, gross product revenue"
    - name: "total_line_discount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts applied at line level, measures promotional impact on margin"
    - name: "net_line_revenue"
      expr: SUM(CAST(total AS DOUBLE))
      comment: "Net revenue after discounts and adjustments, true realized product revenue"
    - name: "total_cogs"
      expr: SUM(CAST(cost_of_goods_sold AS DOUBLE))
      comment: "Total cost of goods sold, essential for gross margin calculation"
    - name: "gross_margin_amount"
      expr: SUM(CAST(margin_amount AS DOUBLE))
      comment: "Total gross margin (revenue minus COGS), primary profitability KPI"
    - name: "total_line_tax"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected at line level for tax compliance reporting"
    - name: "avg_unit_retail_price"
      expr: AVG(CAST(unit_retail_price AS DOUBLE))
      comment: "Average unit retail price across lines, measures pricing trends"
    - name: "fill_rate"
      expr: ROUND(100.0 * SUM(CAST(shipped_quantity AS DOUBLE)) / NULLIF(SUM(CAST(ordered_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of ordered units successfully shipped, critical inventory availability and fulfillment KPI"
    - name: "cancellation_rate"
      expr: ROUND(100.0 * SUM(CAST(cancelled_quantity AS DOUBLE)) / NULLIF(SUM(CAST(ordered_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of ordered units cancelled, measures fulfillment failure rate"
    - name: "return_rate"
      expr: ROUND(100.0 * SUM(CAST(returned_quantity AS DOUBLE)) / NULLIF(SUM(CAST(shipped_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of shipped units returned, key quality and customer satisfaction metric"
    - name: "backorder_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN backorder_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of lines on backorder, measures inventory availability issues"
    - name: "substitution_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN substitution_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of lines requiring product substitution, measures inventory accuracy and customer impact"
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`order_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment processing KPIs including authorization rates, fraud detection, payment method mix, and settlement performance"
  source: "`vibe_retail_v1`.`order`.`payment`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status (authorized, captured, failed, refunded) for payment funnel analysis"
    - name: "method_type"
      expr: method_type
      comment: "Payment method type (credit card, debit, digital wallet, BNPL) for payment mix analysis"
    - name: "card_brand"
      expr: card_brand
      comment: "Card brand (Visa, Mastercard, Amex) for card network performance analysis"
    - name: "digital_wallet_type"
      expr: digital_wallet_type
      comment: "Digital wallet provider (Apple Pay, Google Pay) for digital payment adoption tracking"
    - name: "bnpl_provider"
      expr: bnpl_provider
      comment: "Buy-now-pay-later provider for BNPL program performance"
    - name: "channel"
      expr: channel
      comment: "Payment channel (online, in-store, mobile) for channel-specific payment analysis"
    - name: "fraud_decision"
      expr: fraud_decision
      comment: "Fraud screening decision (approved, declined, review) for fraud management"
    - name: "currency_code"
      expr: currency_code
      comment: "Payment currency for multi-currency payment analysis"
    - name: "three_ds_authentication_result"
      expr: three_ds_authentication_result
      comment: "3D Secure authentication result for security and liability shift analysis"
    - name: "authorization_month"
      expr: DATE_TRUNC('MONTH', authorization_timestamp)
      comment: "Month of payment authorization for time-series payment analysis"
  measures:
    - name: "total_payment_transactions"
      expr: COUNT(1)
      comment: "Total number of payment transactions processed, primary payment volume metric"
    - name: "total_payment_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total payment amount processed, gross payment volume for revenue recognition"
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total refunds issued, critical for net revenue calculation and customer satisfaction"
    - name: "net_payment_amount"
      expr: SUM((CAST(amount AS DOUBLE)) - (CAST(refund_amount AS DOUBLE)))
      comment: "Net payment amount after refunds, true realized payment revenue"
    - name: "avg_payment_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average payment transaction size, measures typical transaction value"
    - name: "authorization_success_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN authorization_code IS NOT NULL AND authorization_timestamp IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of payments successfully authorized, critical payment acceptance KPI"
    - name: "fraud_decline_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN fraud_decision = 'declined' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of payments declined due to fraud, balances fraud prevention with false positives"
    - name: "refund_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN CAST(refund_amount AS DOUBLE) > 0 THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of payments that resulted in refunds, measures return and cancellation impact"
    - name: "avg_fraud_score"
      expr: AVG(CAST(fraud_score AS DOUBLE))
      comment: "Average fraud risk score across transactions, monitors fraud risk trends"
    - name: "three_ds_authentication_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN three_ds_authentication_result IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of transactions using 3D Secure authentication, measures security adoption"
    - name: "digital_wallet_adoption_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN digital_wallet_type IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of payments using digital wallets, tracks modern payment method adoption"
    - name: "bnpl_adoption_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN bnpl_provider IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of payments using buy-now-pay-later, measures alternative financing adoption"
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`order_cancellation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Order and line cancellation KPIs for operational issue identification, revenue leakage analysis, and customer experience improvement"
  source: "`vibe_retail_v1`.`order`.`cancellation`"
  dimensions:
    - name: "cancellation_status"
      expr: cancellation_status
      comment: "Status of the cancellation request (pending, approved, completed) for cancellation workflow tracking"
    - name: "reason_code"
      expr: reason_code
      comment: "Cancellation reason code for root cause analysis and operational improvement"
    - name: "reason_description"
      expr: reason_description
      comment: "Detailed cancellation reason for qualitative analysis"
    - name: "initiator_type"
      expr: initiator_type
      comment: "Who initiated the cancellation (customer, system, agent) for process analysis"
    - name: "channel"
      expr: channel
      comment: "Channel where cancellation occurred for channel-specific issue identification"
    - name: "refund_eligible_flag"
      expr: refund_eligible_flag
      comment: "Whether cancellation is eligible for refund, impacts financial exposure"
    - name: "refund_method"
      expr: refund_method
      comment: "Method of refund (original payment, store credit, gift card) for refund process analysis"
    - name: "fraud_flag"
      expr: fraud_flag
      comment: "Indicates if cancellation was fraud-related, critical for fraud pattern detection"
    - name: "approval_required_flag"
      expr: approval_required_flag
      comment: "Whether cancellation required management approval, measures policy compliance"
    - name: "cancellation_month"
      expr: DATE_TRUNC('MONTH', cancellation_timestamp)
      comment: "Month of cancellation for time-series cancellation trend analysis"
  measures:
    - name: "total_cancellations"
      expr: COUNT(1)
      comment: "Total number of cancellation events, primary cancellation volume metric"
    - name: "total_cancelled_amount"
      expr: SUM(CAST(cancelled_amount AS DOUBLE))
      comment: "Total revenue lost to cancellations, critical revenue leakage KPI"
    - name: "total_cancelled_quantity"
      expr: SUM(CAST(cancelled_quantity AS DOUBLE))
      comment: "Total units cancelled, measures demand fulfillment failure volume"
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total refunds issued for cancellations, cash flow and working capital impact"
    - name: "total_restocking_fee"
      expr: SUM(CAST(restocking_fee_amount AS DOUBLE))
      comment: "Total restocking fees collected, offsets cancellation processing costs"
    - name: "total_fee_amount"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total fees associated with cancellations, measures cancellation cost recovery"
    - name: "avg_cancelled_amount"
      expr: AVG(CAST(cancelled_amount AS DOUBLE))
      comment: "Average revenue per cancellation, measures typical cancellation impact"
    - name: "fraud_cancellation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN fraud_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cancellations due to fraud, measures fraud detection effectiveness"
    - name: "customer_initiated_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN initiator_type = 'customer' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cancellations initiated by customers, measures customer satisfaction issues"
    - name: "refund_eligible_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN refund_eligible_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cancellations eligible for refund, financial exposure metric"
    - name: "approval_required_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN approval_required_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cancellations requiring approval, measures policy exception frequency"
    - name: "avg_fraud_score"
      expr: AVG(CAST(fraud_score AS DOUBLE))
      comment: "Average fraud score for cancellations, monitors fraud risk in cancellation patterns"
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`order_subscription`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Subscription business KPIs including recurring revenue, churn, retention, and subscription lifecycle performance"
  source: "`vibe_retail_v1`.`order`.`subscription`"
  dimensions:
    - name: "subscription_status"
      expr: subscription_status
      comment: "Current subscription status (active, paused, cancelled, expired) for lifecycle analysis"
    - name: "subscription_type"
      expr: subscription_type
      comment: "Type of subscription (product, service, bundle) for product mix analysis"
    - name: "billing_cycle"
      expr: billing_cycle
      comment: "Billing frequency (monthly, quarterly, annual) for revenue recognition and cash flow planning"
    - name: "delivery_frequency"
      expr: delivery_frequency
      comment: "Delivery frequency for subscription fulfillment planning"
    - name: "channel"
      expr: channel
      comment: "Acquisition channel for subscription for channel effectiveness analysis"
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Whether subscription auto-renews, impacts retention and churn prediction"
    - name: "gift_subscription_flag"
      expr: gift_subscription_flag
      comment: "Whether subscription is a gift, measures gift program contribution"
    - name: "cancellation_reason_code"
      expr: cancellation_reason_code
      comment: "Reason for subscription cancellation, critical for churn root cause analysis"
    - name: "start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month subscription started for cohort analysis"
    - name: "cancellation_month"
      expr: DATE_TRUNC('MONTH', cancellation_date)
      comment: "Month subscription was cancelled for churn trend analysis"
  measures:
    - name: "total_subscriptions"
      expr: COUNT(1)
      comment: "Total number of subscriptions, primary subscription volume metric"
    - name: "active_subscriptions"
      expr: COUNT(CASE WHEN subscription_status = 'active' THEN 1 END)
      comment: "Number of currently active subscriptions, key recurring revenue base metric"
    - name: "unique_subscribers"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique customers with subscriptions, measures subscriber base size"
    - name: "monthly_recurring_revenue"
      expr: SUM(CASE WHEN subscription_status = 'active' AND billing_cycle = 'monthly' THEN CAST(amount AS DOUBLE) ELSE 0 END)
      comment: "Total MRR from active monthly subscriptions, primary recurring revenue KPI"
    - name: "total_subscription_value"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total subscription contract value across all subscriptions and billing cycles"
    - name: "avg_subscription_value"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average subscription value, measures typical subscription size"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts applied to subscriptions, measures promotional impact on recurring revenue"
    - name: "churn_count"
      expr: COUNT(CASE WHEN subscription_status = 'cancelled' THEN 1 END)
      comment: "Number of cancelled subscriptions, primary churn volume metric"
    - name: "churn_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN subscription_status = 'cancelled' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of subscriptions that have churned, critical retention KPI"
    - name: "auto_renewal_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN auto_renewal_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of subscriptions with auto-renewal enabled, predicts future retention"
    - name: "avg_deliveries_completed"
      expr: AVG(CAST(total_deliveries_completed AS DOUBLE))
      comment: "Average number of deliveries completed per subscription, measures subscription maturity"
    - name: "delivery_skip_rate"
      expr: ROUND(100.0 * SUM(CAST(total_deliveries_skipped AS DOUBLE)) / NULLIF(SUM(CAST(total_deliveries_completed AS DOUBLE)) + SUM(CAST(total_deliveries_skipped AS DOUBLE)), 0), 2)
      comment: "Percentage of scheduled deliveries that were skipped, early churn indicator"
    - name: "gift_subscription_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN gift_subscription_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of subscriptions that are gifts, measures gift program contribution to subscriber acquisition"
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`order_pos_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Point-of-sale transaction KPIs for in-store performance, basket analysis, payment mix, and operational efficiency"
  source: "`vibe_retail_v1`.`order`.`pos_transaction`"
  dimensions:
    - name: "business_date"
      expr: business_date
      comment: "Business date of transaction for daily sales reporting and comp analysis"
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of transaction (sale, return, exchange, void) for transaction mix analysis"
    - name: "transaction_status"
      expr: transaction_status
      comment: "Transaction status (completed, voided, suspended) for completion rate analysis"
    - name: "primary_payment_method"
      expr: primary_payment_method
      comment: "Primary payment method used for payment mix analysis"
    - name: "fulfillment_type"
      expr: fulfillment_type
      comment: "Fulfillment type (immediate, ship-from-store, pickup) for omnichannel analysis"
    - name: "manager_override_flag"
      expr: manager_override_flag
      comment: "Whether transaction required manager override, measures policy exception frequency"
    - name: "training_mode_flag"
      expr: training_mode_flag
      comment: "Whether transaction was in training mode, filters out non-revenue transactions"
    - name: "return_reason_code"
      expr: return_reason_code
      comment: "Reason for return transactions, critical for quality and satisfaction analysis"
    - name: "void_reason_code"
      expr: void_reason_code
      comment: "Reason for voided transactions, identifies operational issues"
    - name: "transaction_month"
      expr: DATE_TRUNC('MONTH', transaction_timestamp)
      comment: "Month of transaction for time-series POS analysis"
  measures:
    - name: "total_transactions"
      expr: COUNT(1)
      comment: "Total number of POS transactions, primary store traffic and volume metric"
    - name: "completed_transactions"
      expr: COUNT(CASE WHEN transaction_status = 'completed' THEN 1 END)
      comment: "Number of successfully completed transactions, measures checkout efficiency"
    - name: "unique_customers"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique customers transacting in-store, measures customer traffic"
    - name: "total_sales_amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total sales amount including tax, primary in-store revenue KPI"
    - name: "total_subtotal_amount"
      expr: SUM(CAST(subtotal_amount AS DOUBLE))
      comment: "Total subtotal before tax and discounts, gross product revenue"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts applied at POS, measures promotional effectiveness in-store"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected at POS for tax remittance"
    - name: "avg_transaction_value"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average transaction value, key basket size metric for in-store performance"
    - name: "avg_items_per_transaction"
      expr: AVG(CAST(item_count AS DOUBLE))
      comment: "Average number of items per transaction, measures basket depth"
    - name: "avg_units_per_transaction"
      expr: AVG(CAST(total_quantity AS DOUBLE))
      comment: "Average units sold per transaction, measures purchase volume per visit"
    - name: "total_loyalty_points_earned"
      expr: SUM(CAST(loyalty_points_earned AS DOUBLE))
      comment: "Total loyalty points earned by customers, measures loyalty program engagement"
    - name: "total_loyalty_points_redeemed"
      expr: SUM(CAST(loyalty_points_redeemed AS DOUBLE))
      comment: "Total loyalty points redeemed, measures loyalty program liability and usage"
    - name: "loyalty_participation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN loyalty_card_number IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of transactions with loyalty card used, measures program penetration"
    - name: "return_transaction_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN transaction_type = 'return' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of transactions that are returns, measures product quality and satisfaction"
    - name: "void_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN transaction_status = 'voided' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of transactions voided, measures operational errors and training needs"
    - name: "manager_override_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN manager_override_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of transactions requiring manager override, measures policy compliance and training"
    - name: "discount_penetration_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN CAST(discount_amount AS DOUBLE) > 0 THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of transactions with discounts, measures promotional reach in-store"
$$;