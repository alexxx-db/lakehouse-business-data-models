-- Metric views for domain: merchandise | Business: Sports Entertainment | Version: 1 | Generated on: 2026-05-09 01:35:39

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`merchandise_merch_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core merchandise order metrics tracking revenue, order volume, fulfillment performance, and customer behavior across all sales channels"
  source: "`sports_entertainment_ecm`.`merchandise`.`merch_order`"
  dimensions:
    - name: "order_date"
      expr: DATE(order_date)
      comment: "Date the order was placed"
    - name: "order_month"
      expr: DATE_TRUNC('MONTH', order_date)
      comment: "Month the order was placed"
    - name: "channel_type"
      expr: channel_type
      comment: "Primary sales channel (e.g., online, retail, mobile)"
    - name: "channel_subtype"
      expr: channel_subtype
      comment: "Detailed channel classification"
    - name: "order_status"
      expr: order_status
      comment: "Current status of the order"
    - name: "payment_status"
      expr: payment_status
      comment: "Payment processing status"
    - name: "fulfillment_status"
      expr: fulfillment_status
      comment: "Order fulfillment status"
    - name: "shipping_country_code"
      expr: shipping_country_code
      comment: "Destination country for order shipment"
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency"
    - name: "device_type"
      expr: device_type
      comment: "Device used to place order"
    - name: "gift_order_flag"
      expr: gift_order_flag
      comment: "Whether order is a gift"
  measures:
    - name: "total_orders"
      expr: COUNT(1)
      comment: "Total number of merchandise orders"
    - name: "gross_merchandise_value"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross order value before discounts and taxes"
    - name: "net_revenue"
      expr: SUM(CAST(net_total AS DOUBLE))
      comment: "Total net revenue after discounts and taxes"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount value applied to orders"
    - name: "total_shipping_revenue"
      expr: SUM(CAST(shipping_amount AS DOUBLE))
      comment: "Total shipping charges collected"
    - name: "total_tax_collected"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount collected on orders"
    - name: "avg_order_value"
      expr: AVG(CAST(net_total AS DOUBLE))
      comment: "Average net order value per transaction"
    - name: "discount_rate"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of gross value discounted"
    - name: "unique_customers"
      expr: COUNT(DISTINCT fan_profile_id)
      comment: "Number of unique customers placing orders"
$$;


CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`merchandise_order_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-item level merchandise metrics for product mix analysis, fulfillment efficiency, and SKU performance"
  source: "`sports_entertainment_ecm`.`merchandise`.`order_line`"
  dimensions:
    - name: "fulfillment_status"
      expr: fulfillment_status
      comment: "Line item fulfillment status"
    - name: "return_status"
      expr: return_status
      comment: "Return status of the line item"
    - name: "sales_channel"
      expr: sales_channel
      comment: "Sales channel for the line item"
    - name: "product_name"
      expr: product_name
      comment: "Name of the product sold"
    - name: "is_personalized"
      expr: is_personalized
      comment: "Whether item is personalized"
    - name: "is_gift"
      expr: is_gift
      comment: "Whether item is a gift"
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency"
  measures:
    - name: "total_line_items"
      expr: COUNT(1)
      comment: "Total number of order line items"
    - name: "total_units_ordered"
      expr: SUM(CAST(quantity_ordered AS DOUBLE))
      comment: "Total quantity of units ordered"
    - name: "total_units_fulfilled"
      expr: SUM(CAST(quantity_fulfilled AS DOUBLE))
      comment: "Total quantity of units fulfilled"
    - name: "total_units_returned"
      expr: SUM(CAST(quantity_returned AS DOUBLE))
      comment: "Total quantity of units returned"
    - name: "line_revenue"
      expr: SUM(CAST(line_total AS DOUBLE))
      comment: "Total line item revenue including tax"
    - name: "line_subtotal"
      expr: SUM(CAST(line_subtotal AS DOUBLE))
      comment: "Total line item subtotal before tax"
    - name: "total_royalty_amount"
      expr: SUM(CAST(royalty_amount AS DOUBLE))
      comment: "Total royalty obligations on line items"
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price across line items"
    - name: "fulfillment_rate"
      expr: ROUND(100.0 * SUM(CAST(quantity_fulfilled AS DOUBLE)) / NULLIF(SUM(CAST(quantity_ordered AS DOUBLE)), 0), 2)
      comment: "Percentage of ordered units successfully fulfilled"
    - name: "return_rate"
      expr: ROUND(100.0 * SUM(CAST(quantity_returned AS DOUBLE)) / NULLIF(SUM(CAST(quantity_fulfilled AS DOUBLE)), 0), 2)
      comment: "Percentage of fulfilled units returned"
    - name: "unique_skus_sold"
      expr: COUNT(DISTINCT sku_sku_catalog_id)
      comment: "Number of unique SKUs sold"
$$;


CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`merchandise_inventory_position`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory health and valuation metrics for stock management, turnover analysis, and working capital optimization"
  source: "`sports_entertainment_ecm`.`merchandise`.`inventory_position`"
  dimensions:
    - name: "snapshot_date"
      expr: DATE(snapshot_timestamp)
      comment: "Date of inventory snapshot"
    - name: "location_type"
      expr: location_type
      comment: "Type of inventory location"
    - name: "location_code"
      expr: location_code
      comment: "Inventory location identifier"
    - name: "position_status"
      expr: position_status
      comment: "Status of inventory position"
    - name: "valuation_method"
      expr: valuation_method
      comment: "Inventory valuation method used"
    - name: "is_consignment"
      expr: is_consignment
      comment: "Whether inventory is on consignment"
    - name: "is_event_allocated"
      expr: is_event_allocated
      comment: "Whether inventory is allocated to specific event"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for inventory valuation"
  measures:
    - name: "total_inventory_positions"
      expr: COUNT(1)
      comment: "Total number of inventory positions tracked"
    - name: "total_on_hand_qty"
      expr: SUM(CAST(on_hand_qty AS DOUBLE))
      comment: "Total units physically on hand"
    - name: "total_available_to_sell_qty"
      expr: SUM(CAST(available_to_sell_qty AS DOUBLE))
      comment: "Total units available for sale"
    - name: "total_reserved_qty"
      expr: SUM(CAST(reserved_qty AS DOUBLE))
      comment: "Total units reserved for orders"
    - name: "total_in_transit_qty"
      expr: SUM(CAST(in_transit_qty AS DOUBLE))
      comment: "Total units in transit between locations"
    - name: "total_blocked_qty"
      expr: SUM(CAST(blocked_qty AS DOUBLE))
      comment: "Total units blocked from sale"
    - name: "total_shrinkage_qty"
      expr: SUM(CAST(shrinkage_qty AS DOUBLE))
      comment: "Total units lost to shrinkage"
    - name: "total_inventory_value"
      expr: SUM(CAST(inventory_value AS DOUBLE))
      comment: "Total value of inventory on hand"
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost across inventory positions"
    - name: "stock_availability_rate"
      expr: ROUND(100.0 * SUM(CAST(available_to_sell_qty AS DOUBLE)) / NULLIF(SUM(CAST(on_hand_qty AS DOUBLE)), 0), 2)
      comment: "Percentage of on-hand inventory available for sale"
    - name: "shrinkage_rate"
      expr: ROUND(100.0 * SUM(CAST(shrinkage_qty AS DOUBLE)) / NULLIF(SUM(CAST(on_hand_qty AS DOUBLE)), 0), 2)
      comment: "Percentage of inventory lost to shrinkage"
    - name: "unique_skus_in_stock"
      expr: COUNT(DISTINCT sku_sku_catalog_id)
      comment: "Number of unique SKUs in inventory"
$$;


CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`merchandise_return_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product return and refund metrics for quality monitoring, policy effectiveness, and customer satisfaction analysis"
  source: "`sports_entertainment_ecm`.`merchandise`.`return_request`"
  dimensions:
    - name: "request_date"
      expr: DATE(request_date)
      comment: "Date return was requested"
    - name: "request_month"
      expr: DATE_TRUNC('MONTH', request_date)
      comment: "Month return was requested"
    - name: "request_status"
      expr: request_status
      comment: "Current status of return request"
    - name: "return_reason_code"
      expr: return_reason_code
      comment: "Coded reason for return"
    - name: "return_channel"
      expr: return_channel
      comment: "Channel through which return was initiated"
    - name: "return_method"
      expr: return_method
      comment: "Method used for return"
    - name: "resolution_type"
      expr: resolution_type
      comment: "Type of resolution provided"
    - name: "refund_method"
      expr: refund_method
      comment: "Method used for refund"
    - name: "item_condition"
      expr: item_condition
      comment: "Condition of returned item"
    - name: "restock_eligible"
      expr: restock_eligible
      comment: "Whether item can be restocked"
    - name: "policy_exception"
      expr: policy_exception
      comment: "Whether return required policy exception"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for refund amounts"
  measures:
    - name: "total_return_requests"
      expr: COUNT(1)
      comment: "Total number of return requests"
    - name: "total_units_returned"
      expr: SUM(CAST(quantity_returned AS DOUBLE))
      comment: "Total quantity of units returned"
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total refund amount issued"
    - name: "total_net_refund_amount"
      expr: SUM(CAST(net_refund_amount AS DOUBLE))
      comment: "Total net refund after restocking fees"
    - name: "total_restocking_fees"
      expr: SUM(CAST(restocking_fee AS DOUBLE))
      comment: "Total restocking fees collected"
    - name: "avg_refund_amount"
      expr: AVG(CAST(refund_amount AS DOUBLE))
      comment: "Average refund amount per return"
    - name: "avg_unit_price_returned"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price of returned items"
    - name: "restock_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN restock_eligible = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of returns eligible for restocking"
    - name: "policy_exception_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN policy_exception = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of returns requiring policy exception"
    - name: "unique_customers_returning"
      expr: COUNT(DISTINCT fan_profile_id)
      comment: "Number of unique customers making returns"
$$;


CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`merchandise_royalty_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Licensing royalty and IP payment metrics for compliance tracking, licensor relationship management, and revenue share analysis"
  source: "`sports_entertainment_ecm`.`merchandise`.`royalty_payment`"
  dimensions:
    - name: "reporting_period_start"
      expr: reporting_period_start_date
      comment: "Start date of royalty reporting period"
    - name: "reporting_period_end"
      expr: reporting_period_end_date
      comment: "End date of royalty reporting period"
    - name: "reporting_month"
      expr: DATE_TRUNC('MONTH', reporting_period_start_date)
      comment: "Month of royalty reporting period"
    - name: "payment_status"
      expr: payment_status
      comment: "Status of royalty payment"
    - name: "payment_method"
      expr: payment_method
      comment: "Method used for payment"
    - name: "licensor_type"
      expr: licensor_type
      comment: "Type of licensor (league, athlete, brand, etc.)"
    - name: "ip_rights_type"
      expr: ip_rights_type
      comment: "Type of intellectual property rights"
    - name: "sales_channel"
      expr: sales_channel
      comment: "Sales channel for royalty-bearing sales"
    - name: "territory_code"
      expr: territory_code
      comment: "Geographic territory for royalty"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for royalty payment"
    - name: "audit_flag"
      expr: audit_flag
      comment: "Whether payment is flagged for audit"
  measures:
    - name: "total_royalty_payments"
      expr: COUNT(1)
      comment: "Total number of royalty payment records"
    - name: "gross_sales_subject_to_royalty"
      expr: SUM(CAST(gross_sales_amount AS DOUBLE))
      comment: "Total gross sales subject to royalty"
    - name: "net_sales_subject_to_royalty"
      expr: SUM(CAST(net_sales_amount AS DOUBLE))
      comment: "Total net sales subject to royalty after returns and allowances"
    - name: "total_royalty_due"
      expr: SUM(CAST(royalty_due_amount AS DOUBLE))
      comment: "Total royalty amount due before adjustments"
    - name: "total_royalty_paid"
      expr: SUM(CAST(net_royalty_paid_amount AS DOUBLE))
      comment: "Total net royalty amount paid"
    - name: "total_adjustments"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total royalty adjustments applied"
    - name: "total_advance_offsets"
      expr: SUM(CAST(advance_offset_amount AS DOUBLE))
      comment: "Total advance payments offset against royalties"
    - name: "total_returns_allowances"
      expr: SUM(CAST(returns_allowances_amount AS DOUBLE))
      comment: "Total returns and allowances reducing royalty base"
    - name: "avg_royalty_rate"
      expr: AVG(CAST(royalty_rate AS DOUBLE))
      comment: "Average royalty rate percentage"
    - name: "effective_royalty_rate"
      expr: ROUND(100.0 * SUM(CAST(net_royalty_paid_amount AS DOUBLE)) / NULLIF(SUM(CAST(net_sales_amount AS DOUBLE)), 0), 2)
      comment: "Effective royalty rate as percentage of net sales"
    - name: "unique_licensing_agreements"
      expr: COUNT(DISTINCT licensing_agreement_id)
      comment: "Number of unique licensing agreements with royalty activity"
$$;


CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`merchandise_fulfillment_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shipment and delivery performance metrics for logistics efficiency, carrier performance, and customer experience optimization"
  source: "`sports_entertainment_ecm`.`merchandise`.`fulfillment_shipment`"
  dimensions:
    - name: "ship_date"
      expr: ship_date
      comment: "Date shipment was dispatched"
    - name: "ship_month"
      expr: DATE_TRUNC('MONTH', ship_date)
      comment: "Month shipment was dispatched"
    - name: "shipment_status"
      expr: shipment_status
      comment: "Current status of shipment"
    - name: "fulfillment_channel"
      expr: fulfillment_channel
      comment: "Channel used for fulfillment"
    - name: "fulfillment_type"
      expr: fulfillment_type
      comment: "Type of fulfillment"
    - name: "carrier_service_level"
      expr: carrier_service_level
      comment: "Carrier service level selected"
    - name: "shipping_country_code"
      expr: shipping_country_code
      comment: "Destination country"
    - name: "is_international"
      expr: is_international
      comment: "Whether shipment is international"
    - name: "is_partial_fulfillment"
      expr: is_partial_fulfillment
      comment: "Whether shipment is partial fulfillment"
    - name: "requires_signature"
      expr: requires_signature
      comment: "Whether delivery requires signature"
    - name: "sla_breach"
      expr: sla_breach
      comment: "Whether shipment breached SLA"
  measures:
    - name: "total_shipments"
      expr: COUNT(1)
      comment: "Total number of shipments"
    - name: "total_packages"
      expr: SUM(CAST(package_count AS DOUBLE))
      comment: "Total number of packages shipped"
    - name: "total_shipping_cost"
      expr: SUM(CAST(shipping_cost AS DOUBLE))
      comment: "Total shipping cost incurred"
    - name: "total_shipping_revenue"
      expr: SUM(CAST(shipping_cost_charged_to_fan AS DOUBLE))
      comment: "Total shipping charges collected from customers"
    - name: "total_weight_kg"
      expr: SUM(CAST(weight_kg AS DOUBLE))
      comment: "Total weight shipped in kilograms"
    - name: "avg_shipping_cost"
      expr: AVG(CAST(shipping_cost AS DOUBLE))
      comment: "Average shipping cost per shipment"
    - name: "avg_weight_kg"
      expr: AVG(CAST(weight_kg AS DOUBLE))
      comment: "Average shipment weight in kilograms"
    - name: "on_time_delivery_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN sla_breach = FALSE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of shipments delivered within SLA"
    - name: "international_shipment_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_international = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of shipments that are international"
    - name: "shipping_margin"
      expr: SUM((CAST(shipping_cost_charged_to_fan AS DOUBLE)) - (CAST(shipping_cost AS DOUBLE)))
      comment: "Net margin on shipping (revenue minus cost)"
    - name: "unique_customers_shipped"
      expr: COUNT(DISTINCT fan_profile_id)
      comment: "Number of unique customers receiving shipments"
$$;


CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`merchandise_licensing_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Licensing agreement portfolio metrics for IP monetization, contract compliance, and partnership performance tracking"
  source: "`sports_entertainment_ecm`.`merchandise`.`licensing_agreement`"
  dimensions:
    - name: "effective_start_date"
      expr: effective_start_date
      comment: "Agreement effective start date"
    - name: "effective_end_date"
      expr: effective_end_date
      comment: "Agreement effective end date"
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of agreement"
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of licensing agreement"
    - name: "is_exclusive"
      expr: is_exclusive
      comment: "Whether agreement is exclusive"
    - name: "territory_code"
      expr: territory_code
      comment: "Geographic territory covered"
    - name: "distribution_channel"
      expr: distribution_channel
      comment: "Distribution channels permitted"
    - name: "product_category_scope"
      expr: product_category_scope
      comment: "Product categories covered by agreement"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for financial terms"
    - name: "is_nil_agreement"
      expr: is_nil_agreement
      comment: "Whether this is a name/image/likeness agreement"
  measures:
    - name: "total_agreements"
      expr: COUNT(1)
      comment: "Total number of licensing agreements"
    - name: "active_agreements"
      expr: COUNT(CASE WHEN agreement_status = 'Active' THEN 1 END)
      comment: "Number of currently active agreements"
    - name: "total_minimum_guarantees"
      expr: SUM(CAST(minimum_guaranteed_royalty AS DOUBLE))
      comment: "Total minimum guaranteed royalty commitments"
    - name: "total_advance_payments"
      expr: SUM(CAST(advance_payment AS DOUBLE))
      comment: "Total advance payments received"
    - name: "avg_royalty_rate"
      expr: AVG(CAST(royalty_rate_pct AS DOUBLE))
      comment: "Average royalty rate percentage across agreements"
    - name: "exclusive_agreement_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_exclusive = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of agreements that are exclusive"
    - name: "unique_licensors"
      expr: COUNT(DISTINCT corporate_entity_id)
      comment: "Number of unique licensor entities"
$$;


CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`merchandise_compliance_check`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Brand compliance and quality control metrics for IP protection, vendor oversight, and regulatory adherence monitoring"
  source: "`sports_entertainment_ecm`.`merchandise`.`compliance_check`"
  dimensions:
    - name: "inspection_date"
      expr: inspection_date
      comment: "Date of compliance inspection"
    - name: "inspection_month"
      expr: DATE_TRUNC('MONTH', inspection_date)
      comment: "Month of compliance inspection"
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of compliance inspection"
    - name: "inspection_method"
      expr: inspection_method
      comment: "Method used for inspection"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Overall compliance status result"
    - name: "channel"
      expr: channel
      comment: "Sales channel inspected"
    - name: "violation_severity"
      expr: violation_severity
      comment: "Severity level of violations found"
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Whether corrective action is required"
    - name: "counterfeit_risk_flag"
      expr: counterfeit_risk_flag
      comment: "Whether counterfeit risk was identified"
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether issue was escalated"
  measures:
    - name: "total_compliance_checks"
      expr: COUNT(1)
      comment: "Total number of compliance checks performed"
    - name: "passed_checks"
      expr: COUNT(CASE WHEN compliance_status = 'Passed' THEN 1 END)
      comment: "Number of checks that passed"
    - name: "failed_checks"
      expr: COUNT(CASE WHEN compliance_status = 'Failed' THEN 1 END)
      comment: "Number of checks that failed"
    - name: "compliance_pass_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_status = 'Passed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of compliance checks passed"
    - name: "counterfeit_detection_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN counterfeit_risk_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of checks identifying counterfeit risk"
    - name: "corrective_action_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of checks requiring corrective action"
    - name: "escalation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of checks escalated for further review"
    - name: "unique_suppliers_inspected"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of unique suppliers inspected"
$$;
