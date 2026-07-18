-- Metric views for domain: order | Business: Apparel Fashion | Version: 1 | Generated on: 2026-05-05 18:03:30

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`order_sales_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core sales order metrics tracking revenue, order volume, fulfillment performance, and customer value across channels and segments"
  source: "`apparel_fashion_ecm`.`order`.`sales_order`"
  dimensions:
    - name: "order_date"
      expr: order_date
      comment: "Date the order was placed"
    - name: "order_month"
      expr: DATE_TRUNC('MONTH', order_date)
      comment: "Month of order placement for trend analysis"
    - name: "order_quarter"
      expr: DATE_TRUNC('QUARTER', order_date)
      comment: "Quarter of order placement for seasonal analysis"
    - name: "order_status"
      expr: order_status
      comment: "Current status of the sales order"
    - name: "order_type"
      expr: order_type
      comment: "Type of sales order (e.g., standard, rush, wholesale)"
    - name: "order_channel"
      expr: order_channel
      comment: "Sales channel through which order was placed"
    - name: "fulfillment_status"
      expr: fulfillment_status
      comment: "Current fulfillment status of the order"
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of the order"
    - name: "priority_tier"
      expr: priority_tier
      comment: "Priority tier assigned to the order"
    - name: "division"
      expr: division
      comment: "Business division responsible for the order"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the order was placed"
    - name: "is_gift"
      expr: is_gift
      comment: "Flag indicating whether order is a gift"
  measures:
    - name: "total_order_count"
      expr: COUNT(1)
      comment: "Total number of sales orders"
    - name: "total_revenue"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total revenue from all sales orders"
    - name: "total_subtotal_amount"
      expr: SUM(CAST(subtotal_amount AS DOUBLE))
      comment: "Total subtotal amount before shipping and tax"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount applied to orders"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount collected on orders"
    - name: "total_shipping_amount"
      expr: SUM(CAST(shipping_amount AS DOUBLE))
      comment: "Total shipping charges collected"
    - name: "avg_order_value"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average order value (AOV) - key customer value metric"
    - name: "avg_subtotal_amount"
      expr: AVG(CAST(subtotal_amount AS DOUBLE))
      comment: "Average subtotal amount per order"
    - name: "discount_rate"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(subtotal_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of subtotal given as discounts - measures promotional intensity"
    - name: "tax_rate"
      expr: ROUND(100.0 * SUM(CAST(tax_amount AS DOUBLE)) / NULLIF(SUM(CAST(subtotal_amount AS DOUBLE)), 0), 2)
      comment: "Effective tax rate across orders"
    - name: "shipping_to_subtotal_ratio"
      expr: ROUND(100.0 * SUM(CAST(shipping_amount AS DOUBLE)) / NULLIF(SUM(CAST(subtotal_amount AS DOUBLE)), 0), 2)
      comment: "Shipping cost as percentage of subtotal - logistics efficiency indicator"
    - name: "unique_customers"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique customers placing orders"
    - name: "unique_wholesale_accounts"
      expr: COUNT(DISTINCT wholesale_account_id)
      comment: "Number of unique wholesale accounts ordering"
    - name: "unique_retail_stores"
      expr: COUNT(DISTINCT retail_store_id)
      comment: "Number of unique retail stores with orders"
$$;


CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`order_sales_order_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-level order metrics for product performance, margin analysis, and inventory efficiency"
  source: "`apparel_fashion_ecm`.`order`.`sales_order_line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Status of the order line item"
    - name: "order_source"
      expr: order_source
      comment: "Source system or channel of the order"
    - name: "discount_type"
      expr: discount_type
      comment: "Type of discount applied to the line"
    - name: "colorway_code"
      expr: colorway_code
      comment: "Product colorway code"
    - name: "size_code"
      expr: size_code
      comment: "Product size code"
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for quantity"
    - name: "atp_confirmed_flag"
      expr: atp_confirmed_flag
      comment: "Available-to-promise confirmation flag"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the line item"
    - name: "order_month"
      expr: DATE_TRUNC('MONTH', CAST(created_timestamp AS DATE))
      comment: "Month the line was created"
  measures:
    - name: "total_line_count"
      expr: COUNT(1)
      comment: "Total number of order line items"
    - name: "total_line_revenue"
      expr: SUM(CAST(line_total AS DOUBLE))
      comment: "Total revenue from all order lines"
    - name: "total_line_subtotal"
      expr: SUM(CAST(line_subtotal AS DOUBLE))
      comment: "Total subtotal before discounts and tax"
    - name: "total_quantity_ordered"
      expr: SUM(CAST(quantity_ordered AS DOUBLE))
      comment: "Total units ordered across all lines"
    - name: "total_quantity_shipped"
      expr: SUM(CAST(quantity_shipped AS DOUBLE))
      comment: "Total units shipped"
    - name: "total_quantity_backordered"
      expr: SUM(CAST(quantity_backordered AS DOUBLE))
      comment: "Total units on backorder"
    - name: "total_quantity_cancelled"
      expr: SUM(CAST(quantity_cancelled AS DOUBLE))
      comment: "Total units cancelled"
    - name: "total_cogs"
      expr: SUM(CAST(cost_of_goods_sold AS DOUBLE))
      comment: "Total cost of goods sold"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount on lines"
    - name: "gross_margin"
      expr: SUM((CAST(line_total AS DOUBLE)) - (CAST(cost_of_goods_sold AS DOUBLE)))
      comment: "Gross margin (revenue minus COGS) - key profitability metric"
    - name: "gross_margin_percentage"
      expr: ROUND(100.0 * (SUM(CAST(line_total AS DOUBLE)) - SUM(CAST(cost_of_goods_sold AS DOUBLE))) / NULLIF(SUM(CAST(line_total AS DOUBLE)), 0), 2)
      comment: "Gross margin as percentage of revenue - profitability indicator"
    - name: "avg_imu_percentage"
      expr: AVG(CAST(imu_percentage AS DOUBLE))
      comment: "Average initial markup percentage - pricing strategy metric"
    - name: "fill_rate"
      expr: ROUND(100.0 * SUM(CAST(quantity_shipped AS DOUBLE)) / NULLIF(SUM(CAST(quantity_ordered AS DOUBLE)), 0), 2)
      comment: "Percentage of ordered quantity successfully shipped - inventory availability metric"
    - name: "backorder_rate"
      expr: ROUND(100.0 * SUM(CAST(quantity_backordered AS DOUBLE)) / NULLIF(SUM(CAST(quantity_ordered AS DOUBLE)), 0), 2)
      comment: "Percentage of ordered quantity on backorder - inventory shortage indicator"
    - name: "cancellation_rate"
      expr: ROUND(100.0 * SUM(CAST(quantity_cancelled AS DOUBLE)) / NULLIF(SUM(CAST(quantity_ordered AS DOUBLE)), 0), 2)
      comment: "Percentage of ordered quantity cancelled - order quality metric"
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price across order lines"
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage applied"
    - name: "unique_skus"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of unique SKUs ordered"
    - name: "unique_orders"
      expr: COUNT(DISTINCT sales_order_id)
      comment: "Number of unique sales orders represented"
$$;


CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`order_fulfillment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fulfillment performance metrics tracking on-time delivery, order completeness, and logistics efficiency"
  source: "`apparel_fashion_ecm`.`order`.`fulfillment`"
  dimensions:
    - name: "fulfillment_status"
      expr: fulfillment_status
      comment: "Current status of the fulfillment"
    - name: "fulfillment_type"
      expr: fulfillment_type
      comment: "Type of fulfillment (e.g., ship-from-store, warehouse)"
    - name: "carrier_service_level"
      expr: carrier_service_level
      comment: "Carrier service level selected"
    - name: "on_time_flag"
      expr: on_time_flag
      comment: "Flag indicating on-time delivery"
    - name: "in_full_flag"
      expr: in_full_flag
      comment: "Flag indicating complete fulfillment"
    - name: "otif_flag"
      expr: otif_flag
      comment: "On-Time In-Full flag - gold standard fulfillment metric"
    - name: "ship_month"
      expr: DATE_TRUNC('MONTH', ship_date)
      comment: "Month of shipment"
    - name: "delivery_month"
      expr: DATE_TRUNC('MONTH', actual_delivery_date)
      comment: "Month of actual delivery"
    - name: "shipping_cost_currency_code"
      expr: shipping_cost_currency_code
      comment: "Currency of shipping cost"
  measures:
    - name: "total_fulfillment_count"
      expr: COUNT(1)
      comment: "Total number of fulfillments"
    - name: "total_shipping_cost"
      expr: SUM(CAST(shipping_cost_amount AS DOUBLE))
      comment: "Total shipping cost incurred"
    - name: "total_units_fulfilled"
      expr: SUM(CAST(total_units AS DOUBLE))
      comment: "Total units fulfilled across all orders"
    - name: "total_cartons_shipped"
      expr: SUM(CAST(total_cartons AS DOUBLE))
      comment: "Total cartons shipped"
    - name: "total_weight_kg"
      expr: SUM(CAST(total_weight_kg AS DOUBLE))
      comment: "Total weight shipped in kilograms"
    - name: "total_volume_m3"
      expr: SUM(CAST(total_volume_m3 AS DOUBLE))
      comment: "Total volume shipped in cubic meters"
    - name: "otif_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN otif_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "On-Time In-Full rate - critical supply chain KPI measuring perfect order fulfillment"
    - name: "on_time_delivery_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN on_time_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of orders delivered on time - customer satisfaction driver"
    - name: "in_full_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN in_full_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of orders fulfilled completely - inventory accuracy indicator"
    - name: "avg_shipping_cost_per_fulfillment"
      expr: AVG(CAST(shipping_cost_amount AS DOUBLE))
      comment: "Average shipping cost per fulfillment"
    - name: "avg_shipping_cost_per_unit"
      expr: ROUND(SUM(CAST(shipping_cost_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_units AS DOUBLE)), 0), 2)
      comment: "Average shipping cost per unit - logistics efficiency metric"
    - name: "avg_units_per_fulfillment"
      expr: AVG(CAST(total_units AS DOUBLE))
      comment: "Average units per fulfillment - order consolidation indicator"
    - name: "unique_orders_fulfilled"
      expr: COUNT(DISTINCT sales_order_id)
      comment: "Number of unique orders fulfilled"
    - name: "unique_warehouses"
      expr: COUNT(DISTINCT warehouse_location_id)
      comment: "Number of unique warehouse locations used"
    - name: "unique_carriers"
      expr: COUNT(DISTINCT carrier_id)
      comment: "Number of unique carriers used"
$$;


CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`order_rma`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Return merchandise authorization metrics tracking return rates, refund amounts, and product quality issues"
  source: "`apparel_fashion_ecm`.`order`.`rma`"
  dimensions:
    - name: "rma_status"
      expr: rma_status
      comment: "Current status of the RMA"
    - name: "return_reason_code"
      expr: return_reason_code
      comment: "Code indicating reason for return"
    - name: "return_channel"
      expr: return_channel
      comment: "Channel through which return was initiated"
    - name: "disposition_type"
      expr: disposition_type
      comment: "Disposition action for returned goods"
    - name: "return_condition"
      expr: return_condition
      comment: "Condition of returned merchandise"
    - name: "quality_defect_code"
      expr: quality_defect_code
      comment: "Quality defect code if applicable"
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Flag indicating return policy compliance"
    - name: "restocking_eligible_flag"
      expr: restocking_eligible_flag
      comment: "Flag indicating restocking eligibility"
    - name: "return_month"
      expr: DATE_TRUNC('MONTH', requested_date)
      comment: "Month the return was requested"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of refund amounts"
  measures:
    - name: "total_rma_count"
      expr: COUNT(1)
      comment: "Total number of return merchandise authorizations"
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total refund amount issued"
    - name: "total_restocking_fee"
      expr: SUM(CAST(restocking_fee_amount AS DOUBLE))
      comment: "Total restocking fees collected"
    - name: "total_return_shipping_cost"
      expr: SUM(CAST(return_shipping_cost AS DOUBLE))
      comment: "Total return shipping cost incurred"
    - name: "net_return_cost"
      expr: SUM((CAST(refund_amount AS DOUBLE)) + (CAST(return_shipping_cost AS DOUBLE)) - (CAST(restocking_fee_amount AS DOUBLE)))
      comment: "Net cost of returns after restocking fees - true return cost metric"
    - name: "avg_refund_amount"
      expr: AVG(CAST(refund_amount AS DOUBLE))
      comment: "Average refund amount per RMA"
    - name: "restocking_eligible_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN restocking_eligible_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of returns eligible for restocking - inventory recovery rate"
    - name: "compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN compliance_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of returns compliant with policy - policy effectiveness metric"
    - name: "defect_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN quality_defect_code IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of returns due to quality defects - product quality indicator"
    - name: "unique_customers_returning"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique customers initiating returns"
    - name: "unique_orders_returned"
      expr: COUNT(DISTINCT rma_sales_order_id)
      comment: "Number of unique orders with returns"
$$;


CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`order_backorder`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Backorder metrics tracking inventory shortages, fulfillment delays, and demand-supply gaps"
  source: "`apparel_fashion_ecm`.`order`.`backorder`"
  dimensions:
    - name: "backorder_status"
      expr: backorder_status
      comment: "Current status of the backorder"
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for backorder"
    - name: "resolution_action"
      expr: resolution_action
      comment: "Action taken to resolve backorder"
    - name: "priority_tier"
      expr: priority_tier
      comment: "Priority tier of the backorder"
    - name: "customer_segment"
      expr: customer_segment
      comment: "Customer segment of backordered item"
    - name: "order_channel"
      expr: order_channel
      comment: "Channel of the original order"
    - name: "nos_flag"
      expr: nos_flag
      comment: "Never-out-of-stock flag"
    - name: "notification_status"
      expr: notification_status
      comment: "Status of customer notification"
    - name: "creation_month"
      expr: DATE_TRUNC('MONTH', creation_date)
      comment: "Month the backorder was created"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of backorder amounts"
  measures:
    - name: "total_backorder_count"
      expr: COUNT(1)
      comment: "Total number of backorders"
    - name: "total_backordered_quantity"
      expr: SUM(CAST(backordered_quantity AS DOUBLE))
      comment: "Total quantity on backorder"
    - name: "total_fulfilled_quantity"
      expr: SUM(CAST(fulfilled_quantity AS DOUBLE))
      comment: "Total quantity fulfilled from backorders"
    - name: "total_original_requested_quantity"
      expr: SUM(CAST(original_requested_quantity AS DOUBLE))
      comment: "Total originally requested quantity"
    - name: "total_extended_amount"
      expr: SUM(CAST(extended_amount AS DOUBLE))
      comment: "Total extended amount of backordered items"
    - name: "backorder_fulfillment_rate"
      expr: ROUND(100.0 * SUM(CAST(fulfilled_quantity AS DOUBLE)) / NULLIF(SUM(CAST(backordered_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of backordered quantity eventually fulfilled - backorder resolution effectiveness"
    - name: "backorder_to_demand_ratio"
      expr: ROUND(100.0 * SUM(CAST(backordered_quantity AS DOUBLE)) / NULLIF(SUM(CAST(original_requested_quantity AS DOUBLE)), 0), 2)
      comment: "Backorder quantity as percentage of original demand - inventory shortage severity"
    - name: "avg_backorder_value"
      expr: AVG(CAST(extended_amount AS DOUBLE))
      comment: "Average value per backorder"
    - name: "unique_skus_backordered"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of unique SKUs on backorder"
    - name: "unique_orders_with_backorders"
      expr: COUNT(DISTINCT sales_order_id)
      comment: "Number of unique orders with backorders"
    - name: "unique_customers_affected"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique customers affected by backorders"
$$;


CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`order_purchase_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Purchase order metrics tracking procurement spend, vendor performance, and supply chain efficiency"
  source: "`apparel_fashion_ecm`.`order`.`order_purchase_order`"
  dimensions:
    - name: "po_status"
      expr: po_status
      comment: "Current status of the purchase order"
    - name: "po_type"
      expr: po_type
      comment: "Type of purchase order"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the PO"
    - name: "priority_code"
      expr: priority_code
      comment: "Priority code assigned to PO"
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms negotiated"
    - name: "incoterms"
      expr: incoterms
      comment: "International commercial terms"
    - name: "fob_terms"
      expr: fob_terms
      comment: "Free on board terms"
    - name: "moq_compliance_flag"
      expr: moq_compliance_flag
      comment: "Minimum order quantity compliance flag"
    - name: "otif_target_flag"
      expr: otif_target_flag
      comment: "On-time in-full target flag"
    - name: "edi_transmission_flag"
      expr: edi_transmission_flag
      comment: "EDI transmission flag"
    - name: "po_month"
      expr: DATE_TRUNC('MONTH', po_date)
      comment: "Month the PO was issued"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the purchase order"
  measures:
    - name: "total_po_count"
      expr: COUNT(1)
      comment: "Total number of purchase orders"
    - name: "total_po_value"
      expr: SUM(CAST(total_po_value AS DOUBLE))
      comment: "Total value of all purchase orders"
    - name: "total_landed_cost"
      expr: SUM(CAST(total_landed_cost AS DOUBLE))
      comment: "Total landed cost including freight and duties"
    - name: "total_freight_amount"
      expr: SUM(CAST(freight_amount AS DOUBLE))
      comment: "Total freight charges"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on purchase orders"
    - name: "avg_po_value"
      expr: AVG(CAST(total_po_value AS DOUBLE))
      comment: "Average purchase order value"
    - name: "freight_to_po_ratio"
      expr: ROUND(100.0 * SUM(CAST(freight_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_po_value AS DOUBLE)), 0), 2)
      comment: "Freight cost as percentage of PO value - logistics cost efficiency"
    - name: "landed_cost_premium"
      expr: ROUND(100.0 * (SUM(CAST(total_landed_cost AS DOUBLE)) - SUM(CAST(total_po_value AS DOUBLE))) / NULLIF(SUM(CAST(total_po_value AS DOUBLE)), 0), 2)
      comment: "Landed cost premium over base PO value - total cost of procurement metric"
    - name: "moq_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN moq_compliance_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of POs compliant with minimum order quantities - procurement efficiency"
    - name: "otif_target_achievement_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN otif_target_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of POs meeting OTIF targets - vendor performance metric"
    - name: "edi_adoption_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN edi_transmission_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of POs transmitted via EDI - supply chain digitization metric"
    - name: "unique_vendors"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique vendors with purchase orders"
    - name: "unique_factories"
      expr: COUNT(DISTINCT production_factory_id)
      comment: "Number of unique production factories sourced from"
$$;


CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`order_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment metrics tracking transaction success, fraud risk, and payment method performance"
  source: "`apparel_fashion_ecm`.`order`.`order_payment`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Current status of the payment"
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used"
    - name: "channel"
      expr: channel
      comment: "Channel through which payment was made"
    - name: "fraud_flag"
      expr: fraud_flag
      comment: "Flag indicating potential fraud"
    - name: "installment_plan_flag"
      expr: installment_plan_flag
      comment: "Flag indicating installment payment plan"
    - name: "gateway_name"
      expr: gateway_name
      comment: "Payment gateway used"
    - name: "avs_response_code"
      expr: avs_response_code
      comment: "Address verification system response code"
    - name: "cvv_response_code"
      expr: cvv_response_code
      comment: "Card verification value response code"
    - name: "payment_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Month the payment was made"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the payment"
  measures:
    - name: "total_payment_count"
      expr: COUNT(1)
      comment: "Total number of payment transactions"
    - name: "total_payment_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total payment amount processed"
    - name: "total_net_payment_amount"
      expr: SUM(CAST(net_payment_amount AS DOUBLE))
      comment: "Total net payment amount after fees"
    - name: "total_processing_fee"
      expr: SUM(CAST(processing_fee_amount AS DOUBLE))
      comment: "Total payment processing fees"
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total refund amount issued"
    - name: "avg_payment_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average payment amount per transaction"
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average fraud risk score across payments"
    - name: "processing_fee_rate"
      expr: ROUND(100.0 * SUM(CAST(processing_fee_amount AS DOUBLE)) / NULLIF(SUM(CAST(amount AS DOUBLE)), 0), 2)
      comment: "Processing fee as percentage of payment amount - payment cost efficiency"
    - name: "refund_rate"
      expr: ROUND(100.0 * SUM(CAST(refund_amount AS DOUBLE)) / NULLIF(SUM(CAST(amount AS DOUBLE)), 0), 2)
      comment: "Refund amount as percentage of total payments - payment reversal rate"
    - name: "fraud_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN fraud_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of payments flagged as fraudulent - fraud risk metric"
    - name: "installment_adoption_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN installment_plan_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of payments using installment plans - payment flexibility metric"
    - name: "unique_payment_methods"
      expr: COUNT(DISTINCT payment_method_id)
      comment: "Number of unique payment methods used"
    - name: "unique_orders_paid"
      expr: COUNT(DISTINCT sales_order_id)
      comment: "Number of unique orders with payments"
$$;


CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`order_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory allocation metrics tracking ATP confirmation, allocation efficiency, and fulfillment readiness"
  source: "`apparel_fashion_ecm`.`order`.`allocation`"
  dimensions:
    - name: "allocation_status"
      expr: allocation_status
      comment: "Current status of the allocation"
    - name: "allocation_method"
      expr: allocation_method
      comment: "Method used for allocation"
    - name: "source_location_type"
      expr: source_location_type
      comment: "Type of source location"
    - name: "priority"
      expr: priority
      comment: "Priority level of the allocation"
    - name: "atp_confirmation_flag"
      expr: atp_confirmation_flag
      comment: "Available-to-promise confirmation flag"
    - name: "backorder_flag"
      expr: backorder_flag
      comment: "Flag indicating backorder status"
    - name: "preorder_flag"
      expr: preorder_flag
      comment: "Flag indicating preorder status"
    - name: "customer_segment"
      expr: customer_segment
      comment: "Customer segment for the allocation"
    - name: "allocated_quantity_uom"
      expr: allocated_quantity_uom
      comment: "Unit of measure for allocated quantity"
    - name: "allocation_month"
      expr: DATE_TRUNC('MONTH', allocation_date)
      comment: "Month the allocation was made"
  measures:
    - name: "total_allocation_count"
      expr: COUNT(1)
      comment: "Total number of allocations"
    - name: "total_allocated_quantity"
      expr: SUM(CAST(allocated_quantity AS DOUBLE))
      comment: "Total quantity allocated"
    - name: "total_fulfilled_quantity"
      expr: SUM(CAST(fulfilled_quantity AS DOUBLE))
      comment: "Total quantity fulfilled from allocations"
    - name: "total_ats_at_allocation"
      expr: SUM(CAST(ats_at_allocation AS DOUBLE))
      comment: "Total available-to-sell at time of allocation"
    - name: "allocation_fulfillment_rate"
      expr: ROUND(100.0 * SUM(CAST(fulfilled_quantity AS DOUBLE)) / NULLIF(SUM(CAST(allocated_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of allocated quantity actually fulfilled - allocation accuracy metric"
    - name: "atp_confirmation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN atp_confirmation_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of allocations with ATP confirmation - inventory availability metric"
    - name: "backorder_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN backorder_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of allocations resulting in backorders - inventory shortage indicator"
    - name: "preorder_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN preorder_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of allocations for preorders - demand forecasting metric"
    - name: "avg_allocated_quantity"
      expr: AVG(CAST(allocated_quantity AS DOUBLE))
      comment: "Average quantity per allocation"
    - name: "unique_skus_allocated"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of unique SKUs allocated"
    - name: "unique_orders_allocated"
      expr: COUNT(DISTINCT sales_order_id)
      comment: "Number of unique orders with allocations"
    - name: "unique_warehouses"
      expr: COUNT(DISTINCT warehouse_location_id)
      comment: "Number of unique warehouse locations used for allocation"
$$;
