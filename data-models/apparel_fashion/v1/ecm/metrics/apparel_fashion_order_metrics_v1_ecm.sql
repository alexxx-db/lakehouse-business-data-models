-- Metric views for domain: order | Business: Apparel Fashion | Version: 1 | Generated on: 2026-05-05 15:42:09

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`order_sales_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core sales order metrics tracking revenue, order volume, and fulfillment performance across channels and customer segments"
  source: "`apparel_fashion_ecm`.`order`.`sales_order`"
  dimensions:
    - name: "order_date"
      expr: order_date
      comment: "Date the order was placed"
    - name: "order_month"
      expr: DATE_TRUNC('MONTH', order_date)
      comment: "Month of order placement for trend analysis"
    - name: "order_channel"
      expr: order_channel
      comment: "Sales channel (e-commerce, retail, wholesale, etc.)"
    - name: "order_type"
      expr: order_type
      comment: "Type of order (standard, rush, pre-order, etc.)"
    - name: "order_status"
      expr: order_status
      comment: "Current status of the order"
    - name: "fulfillment_status"
      expr: fulfillment_status
      comment: "Fulfillment progress status"
    - name: "payment_status"
      expr: payment_status
      comment: "Payment completion status"
    - name: "distribution_channel"
      expr: distribution_channel
      comment: "Distribution channel for the order"
    - name: "priority_tier"
      expr: priority_tier
      comment: "Order priority level"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the order"
    - name: "is_gift"
      expr: is_gift
      comment: "Whether the order is a gift"
  measures:
    - name: "total_orders"
      expr: COUNT(1)
      comment: "Total number of sales orders"
    - name: "total_revenue"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total order revenue including tax and shipping"
    - name: "total_subtotal"
      expr: SUM(CAST(subtotal_amount AS DOUBLE))
      comment: "Total order subtotal before tax and shipping"
    - name: "total_tax"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected across orders"
    - name: "total_shipping"
      expr: SUM(CAST(shipping_amount AS DOUBLE))
      comment: "Total shipping charges across orders"
    - name: "total_discounts"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount applied to orders"
    - name: "avg_order_value"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average order value (AOV) - key revenue efficiency metric"
    - name: "avg_discount_per_order"
      expr: AVG(CAST(discount_amount AS DOUBLE))
      comment: "Average discount amount per order"
    - name: "discount_rate"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(subtotal_amount AS DOUBLE)), 0), 2)
      comment: "Discount rate as percentage of subtotal - measures promotional intensity"
    - name: "unique_customers"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique customers placing orders"
    - name: "gift_order_count"
      expr: SUM(CASE WHEN is_gift = TRUE THEN 1 ELSE 0 END)
      comment: "Number of orders marked as gifts"
    - name: "gift_order_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_gift = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of orders that are gifts - seasonal and marketing indicator"
$$;


CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`order_sales_order_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-level order metrics for product performance, margin analysis, and inventory efficiency"
  source: "`apparel_fashion_ecm`.`order`.`sales_order_line`"
  dimensions:
    - name: "order_date"
      expr: DATE_TRUNC('DAY', created_timestamp)
      comment: "Date the order line was created"
    - name: "order_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month of order line creation"
    - name: "line_status"
      expr: line_status
      comment: "Status of the order line"
    - name: "order_source"
      expr: order_source
      comment: "Source system or channel of the order"
    - name: "colorway_code"
      expr: colorway_code
      comment: "Product colorway"
    - name: "size_code"
      expr: size_code
      comment: "Product size"
    - name: "discount_type"
      expr: discount_type
      comment: "Type of discount applied"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the line item"
    - name: "atp_confirmed_flag"
      expr: atp_confirmed_flag
      comment: "Whether available-to-promise was confirmed"
  measures:
    - name: "total_order_lines"
      expr: COUNT(1)
      comment: "Total number of order lines"
    - name: "total_line_revenue"
      expr: SUM(CAST(line_total AS DOUBLE))
      comment: "Total revenue from order lines"
    - name: "total_line_subtotal"
      expr: SUM(CAST(line_subtotal AS DOUBLE))
      comment: "Total line subtotal before discounts and tax"
    - name: "total_cogs"
      expr: SUM(CAST(cost_of_goods_sold AS DOUBLE))
      comment: "Total cost of goods sold - critical for margin analysis"
    - name: "gross_profit"
      expr: SUM((CAST(line_total AS DOUBLE)) - (CAST(cost_of_goods_sold AS DOUBLE)))
      comment: "Gross profit (revenue minus COGS) - primary profitability metric"
    - name: "gross_margin_pct"
      expr: ROUND(100.0 * (SUM(CAST(line_total AS DOUBLE)) - SUM(CAST(cost_of_goods_sold AS DOUBLE))) / NULLIF(SUM(CAST(line_total AS DOUBLE)), 0), 2)
      comment: "Gross margin percentage - key profitability indicator for pricing and merchandising decisions"
    - name: "total_units_ordered"
      expr: SUM(CAST(quantity_ordered AS DOUBLE))
      comment: "Total units ordered"
    - name: "total_units_shipped"
      expr: SUM(CAST(quantity_shipped AS DOUBLE))
      comment: "Total units shipped"
    - name: "total_units_backordered"
      expr: SUM(CAST(quantity_backordered AS DOUBLE))
      comment: "Total units on backorder"
    - name: "total_units_cancelled"
      expr: SUM(CAST(quantity_cancelled AS DOUBLE))
      comment: "Total units cancelled"
    - name: "fill_rate"
      expr: ROUND(100.0 * SUM(CAST(quantity_shipped AS DOUBLE)) / NULLIF(SUM(CAST(quantity_ordered AS DOUBLE)), 0), 2)
      comment: "Order fill rate - percentage of ordered units successfully shipped, critical supply chain KPI"
    - name: "backorder_rate"
      expr: ROUND(100.0 * SUM(CAST(quantity_backordered AS DOUBLE)) / NULLIF(SUM(CAST(quantity_ordered AS DOUBLE)), 0), 2)
      comment: "Backorder rate - percentage of ordered units on backorder, inventory health indicator"
    - name: "cancellation_rate"
      expr: ROUND(100.0 * SUM(CAST(quantity_cancelled AS DOUBLE)) / NULLIF(SUM(CAST(quantity_ordered AS DOUBLE)), 0), 2)
      comment: "Cancellation rate - percentage of ordered units cancelled, customer satisfaction and inventory planning metric"
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price across order lines"
    - name: "avg_discount_pct"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage applied"
    - name: "avg_imu_pct"
      expr: AVG(CAST(imu_percentage AS DOUBLE))
      comment: "Average initial markup percentage - pricing strategy metric"
    - name: "unique_skus"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of unique SKUs ordered"
    - name: "atp_confirmation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN atp_confirmed_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of lines with ATP confirmation - inventory availability metric"
$$;


CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`order_fulfillment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fulfillment performance metrics tracking delivery speed, accuracy, and operational efficiency"
  source: "`apparel_fashion_ecm`.`order`.`fulfillment`"
  dimensions:
    - name: "ship_date"
      expr: ship_date
      comment: "Date the order was shipped"
    - name: "ship_month"
      expr: DATE_TRUNC('MONTH', ship_date)
      comment: "Month of shipment"
    - name: "fulfillment_status"
      expr: fulfillment_status
      comment: "Current fulfillment status"
    - name: "fulfillment_type"
      expr: fulfillment_type
      comment: "Type of fulfillment (standard, expedited, etc.)"
    - name: "channel"
      expr: channel
      comment: "Sales channel"
    - name: "carrier_name"
      expr: carrier_name
      comment: "Shipping carrier"
    - name: "carrier_service_level"
      expr: carrier_service_level
      comment: "Carrier service level"
    - name: "ship_to_country_code"
      expr: ship_to_country_code
      comment: "Destination country"
    - name: "on_time_flag"
      expr: on_time_flag
      comment: "Whether delivery was on time"
    - name: "in_full_flag"
      expr: in_full_flag
      comment: "Whether order was fulfilled in full"
    - name: "otif_flag"
      expr: otif_flag
      comment: "Whether order was on-time and in-full"
  measures:
    - name: "total_fulfillments"
      expr: COUNT(1)
      comment: "Total number of fulfillments"
    - name: "total_units_fulfilled"
      expr: SUM(CAST(total_units AS DOUBLE))
      comment: "Total units fulfilled"
    - name: "total_cartons"
      expr: SUM(CAST(total_cartons AS DOUBLE))
      comment: "Total cartons shipped"
    - name: "total_weight_kg"
      expr: SUM(CAST(total_weight_kg AS DOUBLE))
      comment: "Total weight shipped in kilograms"
    - name: "total_volume_m3"
      expr: SUM(CAST(total_volume_m3 AS DOUBLE))
      comment: "Total volume shipped in cubic meters"
    - name: "total_shipping_cost"
      expr: SUM(CAST(shipping_cost_amount AS DOUBLE))
      comment: "Total shipping cost"
    - name: "avg_shipping_cost"
      expr: AVG(CAST(shipping_cost_amount AS DOUBLE))
      comment: "Average shipping cost per fulfillment"
    - name: "shipping_cost_per_unit"
      expr: SUM(CAST(shipping_cost_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_units AS DOUBLE)), 0)
      comment: "Shipping cost per unit - logistics efficiency metric"
    - name: "on_time_delivery_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN on_time_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "On-time delivery rate - critical customer satisfaction and SLA metric"
    - name: "in_full_delivery_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN in_full_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "In-full delivery rate - order accuracy metric"
    - name: "otif_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN otif_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "On-Time In-Full (OTIF) rate - gold standard fulfillment performance metric for operational excellence"
    - name: "unique_carriers"
      expr: COUNT(DISTINCT carrier_name)
      comment: "Number of unique carriers used"
    - name: "unique_destinations"
      expr: COUNT(DISTINCT ship_to_country_code)
      comment: "Number of unique destination countries"
$$;


CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`order_backorder`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Backorder metrics tracking inventory shortfalls, fulfillment delays, and customer impact"
  source: "`apparel_fashion_ecm`.`order`.`backorder`"
  dimensions:
    - name: "creation_date"
      expr: creation_date
      comment: "Date the backorder was created"
    - name: "creation_month"
      expr: DATE_TRUNC('MONTH', creation_date)
      comment: "Month of backorder creation"
    - name: "backorder_status"
      expr: backorder_status
      comment: "Current status of the backorder"
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for the backorder"
    - name: "resolution_action"
      expr: resolution_action
      comment: "Action taken to resolve the backorder"
    - name: "priority_tier"
      expr: priority_tier
      comment: "Priority level of the backorder"
    - name: "customer_segment"
      expr: customer_segment
      comment: "Customer segment"
    - name: "order_channel"
      expr: order_channel
      comment: "Order channel"
    - name: "nos_flag"
      expr: nos_flag
      comment: "Never-out-of-stock flag"
    - name: "notification_status"
      expr: notification_status
      comment: "Customer notification status"
  measures:
    - name: "total_backorders"
      expr: COUNT(1)
      comment: "Total number of backorders - inventory shortage indicator"
    - name: "total_backordered_quantity"
      expr: SUM(CAST(backordered_quantity AS DOUBLE))
      comment: "Total units on backorder"
    - name: "total_fulfilled_quantity"
      expr: SUM(CAST(fulfilled_quantity AS DOUBLE))
      comment: "Total units fulfilled from backorders"
    - name: "total_backorder_value"
      expr: SUM(CAST(extended_amount AS DOUBLE))
      comment: "Total revenue value of backorders - measures revenue at risk"
    - name: "avg_backorder_value"
      expr: AVG(CAST(extended_amount AS DOUBLE))
      comment: "Average value per backorder"
    - name: "backorder_fulfillment_rate"
      expr: ROUND(100.0 * SUM(CAST(fulfilled_quantity AS DOUBLE)) / NULLIF(SUM(CAST(backordered_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of backordered units eventually fulfilled - recovery effectiveness metric"
    - name: "unique_customers_affected"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique customers with backorders - customer impact metric"
    - name: "unique_skus_backordered"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of unique SKUs on backorder - inventory planning metric"
    - name: "nos_backorder_count"
      expr: SUM(CASE WHEN nos_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of never-out-of-stock items on backorder - critical inventory policy violation"
    - name: "nos_backorder_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN nos_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of backorders that are NOS items - measures inventory policy compliance"
$$;


CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`order_rma`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Return merchandise authorization metrics tracking return volume, reasons, and financial impact"
  source: "`apparel_fashion_ecm`.`order`.`rma`"
  dimensions:
    - name: "requested_date"
      expr: requested_date
      comment: "Date the return was requested"
    - name: "requested_month"
      expr: DATE_TRUNC('MONTH', requested_date)
      comment: "Month of return request"
    - name: "rma_status"
      expr: rma_status
      comment: "Current RMA status"
    - name: "return_reason_code"
      expr: return_reason_code
      comment: "Reason code for the return"
    - name: "disposition_type"
      expr: disposition_type
      comment: "Disposition action for returned items"
    - name: "return_channel"
      expr: return_channel
      comment: "Channel through which return was initiated"
    - name: "return_condition"
      expr: return_condition
      comment: "Condition of returned items"
    - name: "quality_defect_code"
      expr: quality_defect_code
      comment: "Quality defect code if applicable"
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Whether return complies with policy"
    - name: "restocking_eligible_flag"
      expr: restocking_eligible_flag
      comment: "Whether items are eligible for restocking"
  measures:
    - name: "total_rmas"
      expr: COUNT(1)
      comment: "Total number of return authorizations"
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total refund amount issued - measures return financial impact"
    - name: "total_restocking_fees"
      expr: SUM(CAST(restocking_fee_amount AS DOUBLE))
      comment: "Total restocking fees collected"
    - name: "total_return_shipping_cost"
      expr: SUM(CAST(return_shipping_cost AS DOUBLE))
      comment: "Total cost of return shipping"
    - name: "avg_refund_amount"
      expr: AVG(CAST(refund_amount AS DOUBLE))
      comment: "Average refund per return"
    - name: "net_return_cost"
      expr: SUM((CAST(refund_amount AS DOUBLE)) + (CAST(return_shipping_cost AS DOUBLE)) - (CAST(restocking_fee_amount AS DOUBLE)))
      comment: "Net cost of returns (refunds + shipping - fees) - total return program cost"
    - name: "unique_customers_returning"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique customers with returns"
    - name: "compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN compliance_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of returns compliant with policy"
    - name: "restocking_eligible_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN restocking_eligible_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of returns eligible for restocking - inventory recovery metric"
    - name: "defect_return_count"
      expr: SUM(CASE WHEN quality_defect_code IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Number of returns due to quality defects"
    - name: "defect_return_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN quality_defect_code IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of returns due to defects - product quality indicator"
$$;


CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`order_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment processing metrics tracking transaction success, fraud, and payment method performance"
  source: "`apparel_fashion_ecm`.`order`.`order_payment`"
  dimensions:
    - name: "payment_date"
      expr: payment_date
      comment: "Date of payment"
    - name: "payment_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Month of payment"
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status"
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used"
    - name: "channel"
      expr: channel
      comment: "Sales channel"
    - name: "gateway_name"
      expr: gateway_name
      comment: "Payment gateway"
    - name: "fraud_flag"
      expr: fraud_flag
      comment: "Whether payment was flagged as fraudulent"
    - name: "installment_plan_flag"
      expr: installment_plan_flag
      comment: "Whether payment is part of installment plan"
    - name: "currency_code"
      expr: currency_code
      comment: "Payment currency"
    - name: "billing_country_code"
      expr: billing_country_code
      comment: "Billing country"
  measures:
    - name: "total_payments"
      expr: COUNT(1)
      comment: "Total number of payment transactions"
    - name: "total_payment_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total payment amount processed"
    - name: "total_net_payment"
      expr: SUM(CAST(net_payment_amount AS DOUBLE))
      comment: "Total net payment after fees"
    - name: "total_processing_fees"
      expr: SUM(CAST(processing_fee_amount AS DOUBLE))
      comment: "Total payment processing fees"
    - name: "total_refunds"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total refund amount"
    - name: "avg_payment_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average payment amount"
    - name: "avg_processing_fee"
      expr: AVG(CAST(processing_fee_amount AS DOUBLE))
      comment: "Average processing fee per transaction"
    - name: "processing_fee_rate"
      expr: ROUND(100.0 * SUM(CAST(processing_fee_amount AS DOUBLE)) / NULLIF(SUM(CAST(amount AS DOUBLE)), 0), 2)
      comment: "Processing fee as percentage of payment amount - payment cost efficiency metric"
    - name: "fraud_transaction_count"
      expr: SUM(CASE WHEN fraud_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of fraudulent transactions"
    - name: "fraud_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN fraud_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Fraud rate - critical risk and loss prevention metric"
    - name: "fraud_amount"
      expr: SUM(CASE WHEN fraud_flag = TRUE THEN CAST(amount AS DOUBLE) ELSE 0 END)
      comment: "Total amount of fraudulent transactions - financial risk exposure"
    - name: "installment_payment_count"
      expr: SUM(CASE WHEN installment_plan_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of installment payments"
    - name: "installment_payment_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN installment_plan_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of payments on installment plans - financing adoption metric"
    - name: "unique_payment_methods"
      expr: COUNT(DISTINCT payment_method)
      comment: "Number of unique payment methods used"
$$;


CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`order_purchase_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Purchase order metrics tracking procurement spend, vendor performance, and supply chain efficiency"
  source: "`apparel_fashion_ecm`.`order`.`order_purchase_order`"
  dimensions:
    - name: "po_date"
      expr: po_date
      comment: "Purchase order date"
    - name: "po_month"
      expr: DATE_TRUNC('MONTH', po_date)
      comment: "Purchase order month"
    - name: "po_status"
      expr: po_status
      comment: "Purchase order status"
    - name: "po_type"
      expr: po_type
      comment: "Purchase order type"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status"
    - name: "priority_code"
      expr: priority_code
      comment: "Priority level"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency"
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms"
    - name: "incoterms"
      expr: incoterms
      comment: "International commercial terms"
    - name: "edi_transmission_flag"
      expr: edi_transmission_flag
      comment: "Whether PO was transmitted via EDI"
    - name: "moq_compliance_flag"
      expr: moq_compliance_flag
      comment: "Minimum order quantity compliance"
  measures:
    - name: "total_purchase_orders"
      expr: COUNT(1)
      comment: "Total number of purchase orders"
    - name: "total_po_value"
      expr: SUM(CAST(total_po_value AS DOUBLE))
      comment: "Total purchase order value - procurement spend"
    - name: "total_landed_cost"
      expr: SUM(CAST(total_landed_cost AS DOUBLE))
      comment: "Total landed cost including freight and duties"
    - name: "total_freight"
      expr: SUM(CAST(freight_amount AS DOUBLE))
      comment: "Total freight cost"
    - name: "total_tax"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax on purchase orders"
    - name: "avg_po_value"
      expr: AVG(CAST(total_po_value AS DOUBLE))
      comment: "Average purchase order value"
    - name: "freight_cost_rate"
      expr: ROUND(100.0 * SUM(CAST(freight_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_po_value AS DOUBLE)), 0), 2)
      comment: "Freight as percentage of PO value - logistics cost efficiency"
    - name: "landed_cost_premium"
      expr: ROUND(100.0 * (SUM(CAST(total_landed_cost AS DOUBLE)) - SUM(CAST(total_po_value AS DOUBLE))) / NULLIF(SUM(CAST(total_po_value AS DOUBLE)), 0), 2)
      comment: "Landed cost premium over base PO value - total procurement cost metric"
    - name: "unique_vendors"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique vendors"
    - name: "edi_transmission_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN edi_transmission_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of POs transmitted via EDI - automation metric"
    - name: "moq_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN moq_compliance_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "MOQ compliance rate - vendor terms adherence"
$$;


CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`order_otif`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "On-Time In-Full performance metrics for vendor and logistics performance management"
  source: "`apparel_fashion_ecm`.`order`.`otif_metric`"
  dimensions:
    - name: "measurement_date"
      expr: measurement_date
      comment: "Date of OTIF measurement"
    - name: "measurement_month"
      expr: DATE_TRUNC('MONTH', measurement_date)
      comment: "Month of measurement"
    - name: "measurement_level"
      expr: measurement_level
      comment: "Level at which OTIF is measured (vendor, warehouse, etc.)"
    - name: "order_type"
      expr: order_type
      comment: "Type of order"
    - name: "sla_tier"
      expr: sla_tier
      comment: "Service level agreement tier"
    - name: "retailer_code"
      expr: retailer_code
      comment: "Retailer code"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category for OTIF failures"
    - name: "reporting_period"
      expr: reporting_period
      comment: "Reporting period"
    - name: "on_time_flag"
      expr: on_time_flag
      comment: "Whether delivery was on time"
    - name: "in_full_flag"
      expr: in_full_flag
      comment: "Whether delivery was in full"
    - name: "otif_compliant_flag"
      expr: otif_compliant_flag
      comment: "Whether delivery met OTIF standard"
    - name: "penalty_flag"
      expr: penalty_flag
      comment: "Whether penalty was assessed"
  measures:
    - name: "total_otif_measurements"
      expr: COUNT(1)
      comment: "Total number of OTIF measurements"
    - name: "total_ordered_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total quantity ordered"
    - name: "total_delivered_quantity"
      expr: SUM(CAST(delivered_quantity AS DOUBLE))
      comment: "Total quantity delivered"
    - name: "avg_otif_score"
      expr: AVG(CAST(otif_score AS DOUBLE))
      comment: "Average OTIF score - composite performance metric"
    - name: "avg_fill_rate"
      expr: AVG(CAST(fill_rate_percent AS DOUBLE))
      comment: "Average fill rate percentage"
    - name: "otif_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN otif_compliant_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "OTIF compliance rate - primary vendor/logistics performance KPI"
    - name: "on_time_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN on_time_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "On-time delivery rate"
    - name: "in_full_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN in_full_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "In-full delivery rate"
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total penalty amount assessed for OTIF failures"
    - name: "penalty_incidence_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN penalty_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of measurements resulting in penalties - financial risk metric"
    - name: "avg_penalty_amount"
      expr: AVG(CAST(penalty_amount AS DOUBLE))
      comment: "Average penalty per measurement"
    - name: "unique_vendors_measured"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique vendors measured"
    - name: "unique_warehouses_measured"
      expr: COUNT(DISTINCT warehouse_location_id)
      comment: "Number of unique warehouses measured"
$$;
