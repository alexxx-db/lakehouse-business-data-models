-- Metric views for domain: order | Business: Retail | Version: 2 | Generated on: 2026-07-12 14:06:09

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`order_header`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core order volume, revenue, and fulfilment KPIs derived from the order header. Used by merchandising, finance, and operations leadership to monitor sales performance, average order value, and fulfilment health across channels and locations."
  source: "`vibe_retail_v1`.`order`.`header`"
  dimensions:
    - name: "order_channel"
      expr: channel
      comment: "Sales channel through which the order was placed (e.g. in-store, online, mobile), enabling channel-mix analysis."
    - name: "order_type"
      expr: order_type
      comment: "Classification of the order (e.g. standard, subscription, B2B), used to segment revenue and volume reporting."
    - name: "order_status"
      expr: order_status
      comment: "Current lifecycle status of the order, used to monitor fulfilment pipeline health and identify bottlenecks."
    - name: "payment_status"
      expr: payment_status
      comment: "Payment collection status of the order, used to track outstanding receivables and payment failure rates."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the order was transacted, required for multi-currency revenue normalisation."
    - name: "order_date_day"
      expr: DATE_TRUNC('DAY', order_date)
      comment: "Order placement date truncated to day, enabling daily trend analysis."
    - name: "order_date_month"
      expr: DATE_TRUNC('MONTH', order_date)
      comment: "Order placement date truncated to month, enabling monthly and seasonal trend analysis."
    - name: "billing_country"
      expr: billing_country_code
      comment: "Country of the billing address, used for geographic revenue analysis and tax jurisdiction reporting."
    - name: "shipping_country"
      expr: shipping_country_code
      comment: "Country of the shipping destination, used for logistics cost and geographic demand analysis."
    - name: "payment_method"
      expr: payment_method
      comment: "Primary payment method used on the order (e.g. credit card, gift card, wallet), used for tender-mix analysis."
  measures:
    - name: "total_orders"
      expr: COUNT(1)
      comment: "Total number of orders placed. Baseline volume KPI used in all order performance dashboards."
    - name: "total_gross_revenue"
      expr: SUM(CAST(grand_total_amount AS DOUBLE))
      comment: "Sum of grand total amounts across all orders. Primary top-line revenue KPI for executive and finance reporting."
    - name: "total_subtotal_revenue"
      expr: SUM(CAST(subtotal_amount AS DOUBLE))
      comment: "Sum of pre-tax, pre-shipping subtotals. Used to isolate merchandise revenue from fulfilment and tax components."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount value applied across all orders. Tracks promotional spend and markdown impact on revenue."
    - name: "total_tax_collected"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected across all orders. Required for tax remittance reconciliation and compliance reporting."
    - name: "total_shipping_revenue"
      expr: SUM(CAST(shipping_amount AS DOUBLE))
      comment: "Total shipping charges collected. Used to assess shipping revenue contribution and carrier cost coverage."
    - name: "avg_order_value"
      expr: AVG(CAST(grand_total_amount AS DOUBLE))
      comment: "Average grand total per order. A primary retail KPI used to track basket size trends and the impact of promotions or assortment changes."
    - name: "avg_discount_per_order"
      expr: AVG(CAST(discount_amount AS DOUBLE))
      comment: "Average discount applied per order. Used to monitor promotional intensity and its effect on margin."
    - name: "distinct_customers"
      expr: COUNT(DISTINCT profile_id)
      comment: "Count of unique customers who placed orders. Used to measure customer reach and repeat-purchase behaviour."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`order_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Item-level order metrics covering units sold, revenue, margin, returns, and fulfilment performance. Used by merchandising, supply chain, and finance to evaluate SKU-level profitability and operational efficiency."
  source: "`vibe_retail_v1`.`order`.`order_line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Current status of the order line (e.g. shipped, cancelled, returned), used to monitor fulfilment pipeline at item level."
    - name: "fulfillment_method"
      expr: fulfillment_method
      comment: "Method used to fulfil the line (e.g. ship-from-store, DC, drop-ship), used for fulfilment cost and speed analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for the line item, required for multi-currency margin analysis."
    - name: "backorder_flag"
      expr: backorder_flag
      comment: "Indicates whether the line was placed on backorder, used to quantify inventory availability gaps."
    - name: "substitution_flag"
      expr: substitution_flag
      comment: "Indicates whether the original SKU was substituted, used to measure assortment availability and substitution rates."
    - name: "gift_flag"
      expr: gift_flag
      comment: "Indicates whether the line item is a gift, used for gifting trend analysis and packaging cost planning."
    - name: "actual_ship_date_month"
      expr: DATE_TRUNC('MONTH', actual_ship_date)
      comment: "Month in which the line was shipped, used for monthly shipment volume and revenue recognition reporting."
    - name: "tax_jurisdiction_code"
      expr: tax_jurisdiction_code
      comment: "Tax jurisdiction applicable to the line, used for tax liability analysis by geography."
  measures:
    - name: "total_units_ordered"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total units ordered across all lines. Core volume KPI for demand planning and inventory replenishment."
    - name: "total_units_shipped"
      expr: SUM(CAST(shipped_quantity AS DOUBLE))
      comment: "Total units shipped. Used to measure fulfilment execution against ordered demand."
    - name: "total_units_returned"
      expr: SUM(CAST(returned_quantity AS DOUBLE))
      comment: "Total units returned. Used to calculate return rates and assess product quality or customer satisfaction issues."
    - name: "total_units_cancelled"
      expr: SUM(CAST(cancelled_quantity AS DOUBLE))
      comment: "Total units cancelled. Used to measure demand leakage and inventory release requirements."
    - name: "total_extended_revenue"
      expr: SUM(CAST(extended_price AS DOUBLE))
      comment: "Total extended price (unit price × quantity) across all lines. Primary item-level revenue measure for merchandising P&L."
    - name: "total_line_discount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount applied at line level. Used to measure promotional markdown depth by SKU and category."
    - name: "total_cogs"
      expr: SUM(CAST(cost_of_goods_sold AS DOUBLE))
      comment: "Total cost of goods sold across all order lines. Essential for gross margin calculation and profitability reporting."
    - name: "total_gross_margin"
      expr: SUM(CAST(margin_amount AS DOUBLE))
      comment: "Total gross margin dollars across all order lines. Primary profitability KPI for merchandising and finance leadership."
    - name: "total_tax_on_lines"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax charged at line level. Used for tax reconciliation and jurisdiction-level liability reporting."
    - name: "avg_unit_retail_price"
      expr: AVG(CAST(unit_retail_price AS DOUBLE))
      comment: "Average selling price per unit across order lines. Used to track price realisation and the impact of promotions on ASP."
    - name: "distinct_skus_ordered"
      expr: COUNT(DISTINCT sku_id)
      comment: "Count of distinct SKUs ordered. Used to measure assortment breadth contributing to revenue."
    - name: "total_order_lines"
      expr: COUNT(1)
      comment: "Total number of order lines. Used as a baseline volume measure for line-level operational metrics."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`order_pos_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Point-of-sale transaction metrics covering in-store revenue, basket size, tender mix, and loyalty engagement. Used by store operations, finance, and marketing leadership to evaluate store performance and customer engagement at the register."
  source: "`vibe_retail_v1`.`order`.`pos_transaction`"
  dimensions:
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of POS transaction (e.g. sale, return, exchange), used to segment revenue from return activity."
    - name: "transaction_status"
      expr: transaction_status
      comment: "Status of the POS transaction (e.g. completed, voided), used to filter valid transactions from voids."
    - name: "fulfillment_type"
      expr: fulfillment_type
      comment: "Fulfilment method associated with the transaction (e.g. in-store pickup, ship-from-store), used for omnichannel analysis."
    - name: "primary_payment_method"
      expr: primary_payment_method
      comment: "Primary tender type used in the transaction, used for tender-mix analysis and cash management planning."
    - name: "business_date_day"
      expr: DATE_TRUNC('DAY', business_date)
      comment: "Business date of the transaction truncated to day, used for daily sales reporting."
    - name: "business_date_month"
      expr: DATE_TRUNC('MONTH', business_date)
      comment: "Business date truncated to month, used for monthly comparable sales analysis."
    - name: "manager_override_flag"
      expr: manager_override_flag
      comment: "Indicates whether a manager override was applied, used to monitor exception frequency and loss prevention risk."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the transaction, required for multi-currency store revenue reporting."
  measures:
    - name: "total_pos_transactions"
      expr: COUNT(1)
      comment: "Total number of POS transactions. Baseline store traffic and throughput KPI for store operations."
    - name: "total_pos_revenue"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total revenue from POS transactions. Primary in-store top-line KPI for store and regional performance reporting."
    - name: "total_pos_subtotal"
      expr: SUM(CAST(subtotal_amount AS DOUBLE))
      comment: "Total pre-tax merchandise subtotal from POS transactions. Used to isolate merchandise revenue from tax."
    - name: "total_pos_discount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount applied at POS. Used to measure in-store promotional spend and markdown impact."
    - name: "total_pos_tax"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected at POS. Required for tax remittance and compliance reporting."
    - name: "total_tender_amount"
      expr: SUM(CAST(tender_amount AS DOUBLE))
      comment: "Total tender collected at POS. Used for cash management, reconciliation, and tender-mix analysis."
    - name: "avg_transaction_value"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average transaction value at POS. Key basket-size KPI used to evaluate upsell effectiveness and promotional impact."
    - name: "avg_pos_discount_per_transaction"
      expr: AVG(CAST(discount_amount AS DOUBLE))
      comment: "Average discount per POS transaction. Used to monitor promotional intensity at store level."
    - name: "total_pos_quantity"
      expr: SUM(CAST(total_quantity AS DOUBLE))
      comment: "Total units sold across POS transactions. Used for units-per-transaction analysis and inventory depletion tracking."
    - name: "distinct_customers_at_pos"
      expr: COUNT(DISTINCT profile_id)
      comment: "Count of distinct identified customers transacting at POS. Used to measure loyalty programme penetration and identified-customer rate."
    - name: "void_transaction_count"
      expr: COUNT(CASE WHEN transaction_status = 'voided' THEN 1 END)
      comment: "Count of voided POS transactions. Used by loss prevention and store operations to monitor exception activity."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`order_pos_transaction_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Item-level POS metrics covering units sold, revenue, margin, and return activity at the scan line. Used by merchandising, category management, and store operations to evaluate SKU performance at the register."
  source: "`vibe_retail_v1`.`order`.`pos_transaction_line`"
  dimensions:
    - name: "department_code"
      expr: department_code
      comment: "Department classification of the scanned item, used for department-level sales and margin analysis."
    - name: "category_code"
      expr: category_code
      comment: "Category classification of the scanned item, used for category management and assortment performance reporting."
    - name: "fulfillment_type"
      expr: fulfillment_type
      comment: "Fulfilment method for the line (e.g. in-store, pickup), used for omnichannel line-level analysis."
    - name: "return_flag"
      expr: return_flag
      comment: "Indicates whether the line is a return transaction, used to separate sales from return activity in revenue reporting."
    - name: "voided_flag"
      expr: voided_flag
      comment: "Indicates whether the line was voided, used to exclude voided lines from revenue and unit calculations."
    - name: "private_label_flag"
      expr: private_label_flag
      comment: "Indicates whether the item is a private-label product, used to track own-brand penetration and margin contribution."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the sold quantity (e.g. each, kg), required for accurate unit volume reporting."
  measures:
    - name: "total_pos_line_units_sold"
      expr: SUM(CAST(quantity_sold AS DOUBLE))
      comment: "Total units sold across POS transaction lines. Core volume KPI for category and SKU performance at the register."
    - name: "total_pos_line_revenue"
      expr: SUM(CAST(total_line_amount AS DOUBLE))
      comment: "Total revenue from POS transaction lines. Used for item-level revenue attribution in category management."
    - name: "total_pos_line_net_revenue"
      expr: SUM(CAST(net_line_amount AS DOUBLE))
      comment: "Total net revenue after discounts at line level. Used for net sales reporting and margin analysis."
    - name: "total_pos_line_cogs"
      expr: SUM(CAST(cost_of_goods_sold AS DOUBLE))
      comment: "Total cost of goods sold at POS line level. Used to calculate gross margin by category and department."
    - name: "total_pos_line_markdown"
      expr: SUM(CAST(markdown_amount AS DOUBLE))
      comment: "Total markdown dollars applied at POS line level. Used to measure markdown depth and its impact on margin."
    - name: "total_pos_line_tax"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected at POS line level. Used for tax reconciliation by category and jurisdiction."
    - name: "avg_unit_selling_price"
      expr: AVG(CAST(unit_retail_price AS DOUBLE))
      comment: "Average unit selling price at POS. Used to track average selling price trends and promotional price realisation."
    - name: "distinct_skus_sold_at_pos"
      expr: COUNT(DISTINCT sku_id)
      comment: "Count of distinct SKUs sold at POS. Used to measure active assortment breadth and identify slow-moving items."
    - name: "total_pos_lines"
      expr: COUNT(1)
      comment: "Total number of POS transaction lines. Baseline measure for items-per-transaction and line-level operational metrics."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`order_cancellation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Order cancellation metrics covering cancellation volume, financial impact, refund processing, and fraud signals. Used by operations, finance, and risk leadership to monitor cancellation rates, refund liability, and fraud exposure."
  source: "`vibe_retail_v1`.`order`.`cancellation`"
  dimensions:
    - name: "cancellation_status"
      expr: cancellation_status
      comment: "Current status of the cancellation request, used to track cancellations through the approval and processing pipeline."
    - name: "cancellation_channel"
      expr: channel
      comment: "Channel through which the cancellation was initiated, used to identify channel-specific cancellation patterns."
    - name: "initiator_type"
      expr: initiator_type
      comment: "Who initiated the cancellation (e.g. customer, associate, system), used to distinguish customer-driven from operational cancellations."
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for the cancellation, used to identify root causes and drive corrective action."
    - name: "refund_method"
      expr: refund_method
      comment: "Method used to issue the refund (e.g. original payment, store credit), used for refund liability and cash flow planning."
    - name: "fraud_flag"
      expr: fraud_flag
      comment: "Indicates whether the cancellation was flagged as potentially fraudulent, used for fraud loss monitoring."
    - name: "refund_eligible_flag"
      expr: refund_eligible_flag
      comment: "Indicates whether the cancellation qualifies for a refund, used to track refund eligibility and liability."
    - name: "cancellation_date_month"
      expr: DATE_TRUNC('MONTH', cancellation_timestamp)
      comment: "Month of cancellation, used for monthly cancellation trend analysis."
  measures:
    - name: "total_cancellations"
      expr: COUNT(1)
      comment: "Total number of cancellation records. Baseline cancellation volume KPI for operations and customer experience monitoring."
    - name: "total_cancelled_amount"
      expr: SUM(CAST(cancelled_amount AS DOUBLE))
      comment: "Total monetary value of cancelled orders. Used to quantify revenue at risk and the financial impact of cancellations."
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total refund value issued for cancellations. Used for cash flow planning and refund liability management."
    - name: "total_restocking_fees"
      expr: SUM(CAST(restocking_fee_amount AS DOUBLE))
      comment: "Total restocking fees collected on cancellations. Used to assess fee revenue recovery against cancellation processing costs."
    - name: "total_cancellation_fees"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total cancellation fees charged. Used to evaluate fee policy effectiveness in deterring unnecessary cancellations."
    - name: "avg_cancelled_amount"
      expr: AVG(CAST(cancelled_amount AS DOUBLE))
      comment: "Average value of cancelled orders. Used to assess whether high-value orders are disproportionately cancelled."
    - name: "fraud_flagged_cancellations"
      expr: COUNT(CASE WHEN fraud_flag = TRUE THEN 1 END)
      comment: "Count of cancellations flagged as potentially fraudulent. Used by risk and loss prevention to monitor fraud exposure."
    - name: "avg_fraud_score"
      expr: AVG(CAST(fraud_score AS DOUBLE))
      comment: "Average fraud score across cancellations. Used to track overall fraud risk level in the cancellation pipeline."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`order_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment transaction metrics covering payment volume, tender mix, fraud signals, and refund activity. Used by finance, treasury, and risk leadership to monitor payment health, fraud exposure, and refund liability."
  source: "`vibe_retail_v1`.`order`.`payment`"
  dimensions:
    - name: "payment_method_type"
      expr: method_type
      comment: "Type of payment method used (e.g. credit_card, debit_card, wallet, gift_card), used for tender-mix analysis."
    - name: "payment_status"
      expr: payment_status
      comment: "Current status of the payment (e.g. authorised, captured, refunded, failed), used to monitor payment pipeline health."
    - name: "payment_channel"
      expr: channel
      comment: "Channel through which the payment was processed, used for channel-level payment performance analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the payment, required for multi-currency treasury and reconciliation reporting."
    - name: "fraud_decision"
      expr: fraud_decision
      comment: "Fraud screening decision for the payment (e.g. approved, declined, review), used for fraud management reporting."
    - name: "digital_wallet_type"
      expr: digital_wallet_type
      comment: "Type of digital wallet used (if applicable), used for wallet adoption and tender-mix analysis."
    - name: "payment_date_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month the payment was created, used for monthly payment volume and revenue recognition reporting."
  measures:
    - name: "total_payments"
      expr: COUNT(1)
      comment: "Total number of payment transactions. Baseline payment volume KPI for treasury and finance operations."
    - name: "total_payment_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total payment amount collected. Primary cash collection KPI for treasury and accounts receivable management."
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total refund amount issued. Used to monitor refund liability and net cash position."
    - name: "avg_payment_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average payment amount per transaction. Used to track average transaction size and detect anomalies."
    - name: "avg_fraud_score"
      expr: AVG(CAST(fraud_score AS DOUBLE))
      comment: "Average fraud score across payment transactions. Used to monitor overall fraud risk level in the payment pipeline."
    - name: "fraud_reviewed_payments"
      expr: COUNT(CASE WHEN fraud_decision = 'review' THEN 1 END)
      comment: "Count of payments flagged for fraud review. Used by risk teams to monitor manual review queue volume and capacity."
    - name: "distinct_customers_paying"
      expr: COUNT(DISTINCT header_id)
      comment: "Count of distinct orders with payments. Used to reconcile payment coverage against order volume."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`order_discount`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Discount and promotional metrics covering discount depth, type mix, and approval patterns. Used by merchandising, marketing, and finance leadership to evaluate promotional effectiveness, markdown spend, and discount policy compliance."
  source: "`vibe_retail_v1`.`order`.`discount`"
  dimensions:
    - name: "discount_type"
      expr: discount_type
      comment: "Type of discount applied (e.g. promotional, loyalty, employee, clearance), used to segment discount spend by programme."
    - name: "applied_at_level"
      expr: applied_at_level
      comment: "Level at which the discount was applied (e.g. order, line, item), used to understand discount structure and stacking behaviour."
    - name: "discount_channel"
      expr: channel
      comment: "Channel through which the discount was applied, used for channel-level promotional spend analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the discount (e.g. approved, pending, rejected), used to monitor discount authorisation compliance."
    - name: "stackable_flag"
      expr: stackable_flag
      comment: "Indicates whether the discount can be stacked with other discounts, used to analyse stacking exposure and margin risk."
    - name: "discount_date_month"
      expr: DATE_TRUNC('MONTH', applied_timestamp)
      comment: "Month the discount was applied, used for monthly promotional spend trend analysis."
    - name: "valid_from_date_month"
      expr: DATE_TRUNC('MONTH', valid_from_date)
      comment: "Month the discount validity period started, used for promotional calendar analysis."
  measures:
    - name: "total_discounts_applied"
      expr: COUNT(1)
      comment: "Total number of discount records applied. Baseline measure for promotional activity volume."
    - name: "total_discount_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total discount value applied across all records. Primary promotional spend KPI for finance and merchandising."
    - name: "total_taxable_amount_adjustment"
      expr: SUM(CAST(taxable_amount_adjustment AS DOUBLE))
      comment: "Total taxable amount adjustment from discounts. Used for tax liability reconciliation when discounts affect taxable base."
    - name: "avg_discount_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average discount value per application. Used to assess typical discount depth and identify outliers."
    - name: "avg_discount_percentage"
      expr: AVG(CAST(percentage AS DOUBLE))
      comment: "Average discount percentage applied. Used to monitor promotional depth and its impact on margin."
    - name: "total_original_price"
      expr: SUM(CAST(original_price AS DOUBLE))
      comment: "Total original price before discounts. Used as the denominator for discount rate calculations in BI."
    - name: "total_final_price"
      expr: SUM(CAST(final_price AS DOUBLE))
      comment: "Total final price after discounts. Used to measure net revenue realisation after promotional activity."
    - name: "distinct_campaigns_active"
      expr: COUNT(DISTINCT promo_campaign_id)
      comment: "Count of distinct promotional campaigns generating discounts. Used to measure campaign reach and activity breadth."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`order_subscription`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Subscription programme metrics covering active subscriptions, recurring revenue, churn, and delivery performance. Used by e-commerce, finance, and customer retention leadership to monitor subscription health and recurring revenue streams."
  source: "`vibe_retail_v1`.`order`.`subscription`"
  dimensions:
    - name: "subscription_status"
      expr: subscription_status
      comment: "Current status of the subscription (e.g. active, paused, cancelled), used to segment the subscription base by lifecycle stage."
    - name: "subscription_type"
      expr: subscription_type
      comment: "Type of subscription (e.g. replenishment, curated box, service), used to analyse revenue mix by subscription programme."
    - name: "billing_cycle"
      expr: billing_cycle
      comment: "Billing frequency of the subscription (e.g. monthly, quarterly, annual), used for recurring revenue forecasting."
    - name: "delivery_frequency"
      expr: delivery_frequency
      comment: "Delivery cadence of the subscription, used for fulfilment planning and capacity management."
    - name: "subscription_channel"
      expr: channel
      comment: "Channel through which the subscription was acquired, used for channel-level subscription acquisition analysis."
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Indicates whether the subscription auto-renews, used to forecast renewal revenue and identify churn risk."
    - name: "gift_subscription_flag"
      expr: gift_subscription_flag
      comment: "Indicates whether the subscription is a gift, used to segment gifted vs self-purchased subscriptions."
    - name: "start_date_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the subscription started, used for cohort-based subscription acquisition and retention analysis."
    - name: "cancellation_reason_code"
      expr: cancellation_reason_code
      comment: "Reason code for subscription cancellation, used to identify churn drivers and inform retention strategy."
  measures:
    - name: "total_subscriptions"
      expr: COUNT(1)
      comment: "Total number of subscription records. Baseline measure for subscription programme scale."
    - name: "active_subscriptions"
      expr: COUNT(CASE WHEN subscription_status = 'active' THEN 1 END)
      comment: "Count of currently active subscriptions. Primary KPI for subscription programme health and recurring revenue base."
    - name: "cancelled_subscriptions"
      expr: COUNT(CASE WHEN subscription_status = 'cancelled' THEN 1 END)
      comment: "Count of cancelled subscriptions. Used to calculate churn rate and identify retention intervention opportunities."
    - name: "total_subscription_revenue"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total subscription revenue value. Primary recurring revenue KPI for finance and e-commerce leadership."
    - name: "total_subscription_discount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount applied to subscriptions. Used to measure promotional investment in subscriber acquisition and retention."
    - name: "avg_subscription_value"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average subscription value. Used to track average revenue per subscriber and the impact of pricing changes."
    - name: "distinct_subscribing_customers"
      expr: COUNT(DISTINCT profile_id)
      comment: "Count of distinct customers with subscriptions. Used to measure subscriber base size and penetration."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`order_promise`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Delivery promise accuracy and SLA performance metrics. Used by supply chain, fulfilment, and customer experience leadership to monitor promise reliability, SLA breach rates, and the accuracy of delivery date commitments."
  source: "`vibe_retail_v1`.`order`.`promise`"
  dimensions:
    - name: "promise_status"
      expr: promise_status
      comment: "Current status of the delivery promise (e.g. active, fulfilled, breached), used to monitor promise lifecycle."
    - name: "promise_type"
      expr: promise_type
      comment: "Type of delivery promise (e.g. standard, express, same-day), used to analyse performance by service level."
    - name: "fulfillment_method"
      expr: fulfillment_method
      comment: "Fulfilment method associated with the promise, used to compare promise accuracy across fulfilment channels."
    - name: "order_channel"
      expr: order_channel
      comment: "Channel through which the order was placed, used to analyse promise performance by acquisition channel."
    - name: "carrier_service_level"
      expr: carrier_service_level
      comment: "Carrier service level used for the promise, used to evaluate carrier-level delivery performance."
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Indicates whether the delivery promise breached its SLA, used to quantify SLA failure rates."
    - name: "accuracy_flag"
      expr: accuracy_flag
      comment: "Indicates whether the promise was accurate (delivered within promised window), used to measure promise accuracy rate."
    - name: "peak_season_flag"
      expr: peak_season_flag
      comment: "Indicates whether the promise was made during peak season, used to compare peak vs non-peak delivery performance."
    - name: "weather_impact_flag"
      expr: weather_impact_flag
      comment: "Indicates whether weather impacted the promise, used to isolate weather-driven SLA breaches from operational failures."
    - name: "promise_created_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month the promise was created, used for monthly promise volume and accuracy trend analysis."
  measures:
    - name: "total_promises"
      expr: COUNT(1)
      comment: "Total number of delivery promises made. Baseline measure for promise volume and fulfilment commitment tracking."
    - name: "sla_breached_promises"
      expr: COUNT(CASE WHEN sla_breach_flag = TRUE THEN 1 END)
      comment: "Count of promises that breached their SLA. Used to quantify fulfilment SLA failures and drive corrective action."
    - name: "accurate_promises"
      expr: COUNT(CASE WHEN accuracy_flag = TRUE THEN 1 END)
      comment: "Count of promises delivered within the committed window. Used to calculate promise accuracy rate in BI."
    - name: "avg_delivery_variance_hours"
      expr: AVG(CAST(variance_hours AS DOUBLE))
      comment: "Average variance in hours between promised and actual delivery. Used to measure systematic over- or under-promising."
    - name: "avg_promise_confidence_score"
      expr: AVG(CAST(confidence_score AS DOUBLE))
      comment: "Average confidence score assigned to delivery promises. Used to evaluate the reliability of the promise calculation engine."
    - name: "total_promise_revisions"
      expr: COUNT(CASE WHEN revised_promise_id IS NOT NULL THEN 1 END)
      comment: "Count of promises that were revised after initial commitment. Used to measure promise instability and its customer experience impact."
    - name: "distinct_orders_with_promises"
      expr: COUNT(DISTINCT header_id)
      comment: "Count of distinct orders with delivery promises. Used to measure promise coverage across the order base."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`order_gift_card`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Gift card programme metrics covering issuance, redemption, outstanding liability, and fraud. Used by finance, treasury, and marketing leadership to monitor gift card programme health, breakage revenue, and escheatment liability."
  source: "`vibe_retail_v1`.`order`.`gift_card`"
  dimensions:
    - name: "card_status"
      expr: card_status
      comment: "Current status of the gift card (e.g. active, redeemed, expired, blocked), used to segment the gift card portfolio."
    - name: "card_type"
      expr: card_type
      comment: "Type of gift card (e.g. physical, digital, promotional), used to analyse programme mix and cost structure."
    - name: "issuing_channel"
      expr: issuing_channel
      comment: "Channel through which the gift card was issued, used for channel-level issuance and liability analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the gift card, required for multi-currency liability reporting."
    - name: "reloadable_flag"
      expr: reloadable_flag
      comment: "Indicates whether the card can be reloaded, used to segment reloadable vs single-use card liability."
    - name: "escheatment_eligible_flag"
      expr: escheatment_eligible_flag
      comment: "Indicates whether the card is eligible for escheatment, used to monitor unclaimed property liability."
    - name: "fraud_flag"
      expr: fraud_flag
      comment: "Indicates whether the card has been flagged for fraud, used for fraud loss monitoring and programme risk assessment."
    - name: "issue_date_month"
      expr: DATE_TRUNC('MONTH', issue_date)
      comment: "Month the gift card was issued, used for monthly issuance volume and liability trend analysis."
  measures:
    - name: "total_gift_cards_issued"
      expr: COUNT(1)
      comment: "Total number of gift cards issued. Baseline measure for gift card programme scale."
    - name: "total_initial_balance_issued"
      expr: SUM(CAST(initial_balance AS DOUBLE))
      comment: "Total initial value loaded onto gift cards at issuance. Used to measure programme revenue and deferred liability."
    - name: "total_current_balance"
      expr: SUM(CAST(current_balance AS DOUBLE))
      comment: "Total outstanding balance across all active gift cards. Primary gift card liability KPI for treasury and finance."
    - name: "total_redeemed_amount"
      expr: SUM(CAST(total_redeemed_amount AS DOUBLE))
      comment: "Total value redeemed from gift cards. Used to measure redemption velocity and breakage estimation."
    - name: "total_reloaded_amount"
      expr: SUM(CAST(total_reloaded_amount AS DOUBLE))
      comment: "Total value reloaded onto reloadable gift cards. Used to measure reload programme engagement and incremental liability."
    - name: "total_fees_charged"
      expr: SUM(CAST(total_fees_charged AS DOUBLE))
      comment: "Total fees charged on gift cards (e.g. inactivity fees). Used to measure fee revenue and assess fee policy impact."
    - name: "avg_initial_balance"
      expr: AVG(CAST(initial_balance AS DOUBLE))
      comment: "Average initial balance per gift card. Used to track typical gift card denomination and gifting value trends."
    - name: "fraud_flagged_cards"
      expr: COUNT(CASE WHEN fraud_flag = TRUE THEN 1 END)
      comment: "Count of gift cards flagged for fraud. Used by loss prevention to monitor gift card fraud exposure."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`order_hold`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Order hold metrics covering hold volume, SLA compliance, fraud-driven holds, and resolution efficiency. Used by operations, risk, and customer experience leadership to monitor hold queue health and resolution performance."
  source: "`vibe_retail_v1`.`order`.`hold`"
  dimensions:
    - name: "hold_type"
      expr: hold_type
      comment: "Type of hold applied to the order (e.g. fraud, payment, inventory, compliance), used to segment hold volume by root cause."
    - name: "hold_status"
      expr: hold_status
      comment: "Current status of the hold (e.g. active, released, escalated), used to monitor hold resolution pipeline."
    - name: "fraud_decision"
      expr: fraud_decision
      comment: "Fraud screening decision associated with the hold, used to analyse fraud-driven hold patterns."
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Indicates whether the hold exceeded its SLA target, used to quantify SLA compliance in hold resolution."
    - name: "manual_review_required_flag"
      expr: manual_review_required_flag
      comment: "Indicates whether the hold requires manual review, used to monitor manual review queue volume and staffing needs."
    - name: "auto_release_eligible_flag"
      expr: auto_release_eligible_flag
      comment: "Indicates whether the hold is eligible for automatic release, used to measure automation coverage in hold management."
    - name: "hold_created_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month the hold was created, used for monthly hold volume trend analysis."
  measures:
    - name: "total_holds"
      expr: COUNT(1)
      comment: "Total number of order holds. Baseline measure for hold queue volume and operational workload."
    - name: "sla_breached_holds"
      expr: COUNT(CASE WHEN sla_breach_flag = TRUE THEN 1 END)
      comment: "Count of holds that breached their SLA target. Used to measure hold resolution SLA compliance and escalation risk."
    - name: "fraud_holds"
      expr: COUNT(CASE WHEN hold_type = 'fraud' THEN 1 END)
      comment: "Count of holds triggered by fraud screening. Used to monitor fraud-driven operational impact on order fulfilment."
    - name: "avg_fraud_score_on_holds"
      expr: AVG(CAST(fraud_score AS DOUBLE))
      comment: "Average fraud score on held orders. Used to calibrate fraud model thresholds and assess hold queue risk level."
    - name: "distinct_orders_on_hold"
      expr: COUNT(DISTINCT header_id)
      comment: "Count of distinct orders currently or historically on hold. Used to measure hold impact on order fulfilment throughput."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`order_gift_card_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Gift Card Transaction business metrics"
  source: "`vibe_retail_v1`.`order`.`gift_card_transaction`"
  dimensions:
    - name: "Authorization Code"
      expr: authorization_code
    - name: "Business Date"
      expr: business_date
    - name: "Channel"
      expr: channel
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Escheatment Flag"
      expr: escheatment_flag
    - name: "Escheatment Jurisdiction"
      expr: escheatment_jurisdiction
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Fraud Decision"
      expr: fraud_decision
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Notes"
      expr: notes
    - name: "Payment Method Type"
      expr: payment_method_type
    - name: "Processor Reference Code"
      expr: processor_reference_code
    - name: "Reversal Flag"
      expr: reversal_flag
    - name: "Reversal Reason Code"
      expr: reversal_reason_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Gift Card Transaction"
      expr: COUNT(DISTINCT gift_card_transaction_id)
    - name: "Total Activation Fee Amount"
      expr: SUM(activation_fee_amount)
    - name: "Average Activation Fee Amount"
      expr: AVG(activation_fee_amount)
    - name: "Total Balance After"
      expr: SUM(balance_after)
    - name: "Average Balance After"
      expr: AVG(balance_after)
    - name: "Total Balance Before"
      expr: SUM(balance_before)
    - name: "Average Balance Before"
      expr: AVG(balance_before)
    - name: "Total Fraud Score"
      expr: SUM(fraud_score)
    - name: "Average Fraud Score"
      expr: AVG(fraud_score)
    - name: "Total Transaction Amount"
      expr: SUM(transaction_amount)
    - name: "Average Transaction Amount"
      expr: AVG(transaction_amount)
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`order_line_status_history`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line Status History business metrics"
  source: "`vibe_retail_v1`.`order`.`line_status_history`"
  dimensions:
    - name: "Actual Delivery Timestamp"
      expr: actual_delivery_timestamp
    - name: "Carrier Service Level"
      expr: carrier_service_level
    - name: "Current Status"
      expr: current_status
    - name: "Estimated Delivery Date"
      expr: estimated_delivery_date
    - name: "Exception Category"
      expr: exception_category
    - name: "Exception Flag"
      expr: exception_flag
    - name: "Fulfillment Node Type"
      expr: fulfillment_node_type
    - name: "Line Sequence Number"
      expr: line_sequence_number
    - name: "Notes"
      expr: notes
    - name: "Previous Status"
      expr: previous_status
    - name: "Record Created Timestamp"
      expr: record_created_timestamp
    - name: "Record Updated Timestamp"
      expr: record_updated_timestamp
    - name: "Sku"
      expr: sku
    - name: "Sla Met Flag"
      expr: sla_met_flag
    - name: "Sla Target Timestamp"
      expr: sla_target_timestamp
    - name: "Status Reason Code"
      expr: status_reason_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Line Status History"
      expr: COUNT(DISTINCT line_status_history_id)
    - name: "Total Quantity Affected"
      expr: SUM(quantity_affected)
    - name: "Average Quantity Affected"
      expr: AVG(quantity_affected)
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`order_order_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Order Line business metrics"
  source: "`vibe_retail_v1`.`order`.`order_line`"
  dimensions:
    - name: "Actual Ship Date"
      expr: actual_ship_date
    - name: "Backorder Flag"
      expr: backorder_flag
    - name: "Cancellation Reason Code"
      expr: cancellation_reason_code
    - name: "Carrier Code"
      expr: carrier_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Expected Ship Date"
      expr: expected_ship_date
    - name: "Fulfillment Method"
      expr: fulfillment_method
    - name: "Gift Flag"
      expr: gift_flag
    - name: "Gift Message"
      expr: gift_message
    - name: "Gtin"
      expr: gtin
    - name: "Line Number"
      expr: line_number
    - name: "Line Status"
      expr: line_status
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Original Sku"
      expr: original_sku
    - name: "Personalization Notes"
      expr: personalization_notes
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Order Line"
      expr: COUNT(DISTINCT order_line_id)
    - name: "Total Cancelled Quantity"
      expr: SUM(cancelled_quantity)
    - name: "Average Cancelled Quantity"
      expr: AVG(cancelled_quantity)
    - name: "Total Cost Of Goods Sold"
      expr: SUM(cost_of_goods_sold)
    - name: "Average Cost Of Goods Sold"
      expr: AVG(cost_of_goods_sold)
    - name: "Total Discount Amount"
      expr: SUM(discount_amount)
    - name: "Average Discount Amount"
      expr: AVG(discount_amount)
    - name: "Total Extended Price"
      expr: SUM(extended_price)
    - name: "Average Extended Price"
      expr: AVG(extended_price)
    - name: "Total Margin Amount"
      expr: SUM(margin_amount)
    - name: "Average Margin Amount"
      expr: AVG(margin_amount)
    - name: "Total Ordered Quantity"
      expr: SUM(ordered_quantity)
    - name: "Average Ordered Quantity"
      expr: AVG(ordered_quantity)
    - name: "Total Returned Quantity"
      expr: SUM(returned_quantity)
    - name: "Average Returned Quantity"
      expr: AVG(returned_quantity)
    - name: "Total Shipped Quantity"
      expr: SUM(shipped_quantity)
    - name: "Average Shipped Quantity"
      expr: AVG(shipped_quantity)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
    - name: "Total Tax Rate"
      expr: SUM(tax_rate)
    - name: "Average Tax Rate"
      expr: AVG(tax_rate)
    - name: "Total Total"
      expr: SUM(total)
    - name: "Average Total"
      expr: AVG(total)
    - name: "Total Unit Retail Price"
      expr: SUM(unit_retail_price)
    - name: "Average Unit Retail Price"
      expr: AVG(unit_retail_price)
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`order_status_history`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Status History business metrics"
  source: "`vibe_retail_v1`.`order`.`status_history`"
  dimensions:
    - name: "Actual Delivery Timestamp"
      expr: actual_delivery_timestamp
    - name: "Assigned To Team Code"
      expr: assigned_to_team_code
    - name: "Carrier Code"
      expr: carrier_code
    - name: "Created By Process"
      expr: created_by_process
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Customer Notification Channel"
      expr: customer_notification_channel
    - name: "Customer Notification Sent Flag"
      expr: customer_notification_sent_flag
    - name: "Duration In Previous Status Minutes"
      expr: duration_in_previous_status_minutes
    - name: "Estimated Delivery Date"
      expr: estimated_delivery_date
    - name: "Event Sequence Number"
      expr: event_sequence_number
    - name: "Exception Category"
      expr: exception_category
    - name: "Exception Flag"
      expr: exception_flag
    - name: "Fulfillment Node Type"
      expr: fulfillment_node_type
    - name: "Notes"
      expr: notes
    - name: "Order Type"
      expr: order_type
    - name: "Previous Status Code"
      expr: previous_status_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Status History"
      expr: COUNT(DISTINCT status_history_id)
$$;