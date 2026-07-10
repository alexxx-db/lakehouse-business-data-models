-- Metric views for domain: order | Business: Manufacturing | Version: 2 | Generated on: 2026-07-10 14:41:14

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`order_delivery`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Delivery business metrics"
  source: "`vibe_manufacturing_v1`.`order`.`delivery`"
  dimensions:
    - name: "Actual Delivery Date"
      expr: actual_delivery_date
    - name: "Actual Goods Issue Timestamp"
      expr: actual_goods_issue_timestamp
    - name: "Carrier Code"
      expr: carrier_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Delivery Number"
      expr: delivery_number
    - name: "Delivery Status"
      expr: delivery_status
    - name: "Delivery Type"
      expr: delivery_type
    - name: "Handling Instructions"
      expr: handling_instructions
    - name: "Hazardous Material Flag"
      expr: hazardous_material_flag
    - name: "Is Backorder"
      expr: is_backorder
    - name: "Is Partial Delivery"
      expr: is_partial_delivery
    - name: "Number Of Items"
      expr: number_of_items
    - name: "Planned Delivery Date"
      expr: planned_delivery_date
    - name: "Planned Goods Issue Date"
      expr: planned_goods_issue_date
    - name: "Priority"
      expr: priority
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Delivery"
      expr: COUNT(DISTINCT delivery_id)
    - name: "Total Freight Cost Amount"
      expr: SUM(freight_cost_amount)
    - name: "Average Freight Cost Amount"
      expr: AVG(freight_cost_amount)
    - name: "Total Freight Tax Amount"
      expr: SUM(freight_tax_amount)
    - name: "Average Freight Tax Amount"
      expr: AVG(freight_tax_amount)
    - name: "Total Freight Total Amount"
      expr: SUM(freight_total_amount)
    - name: "Average Freight Total Amount"
      expr: AVG(freight_total_amount)
    - name: "Total Total Gross Weight Kg"
      expr: SUM(total_gross_weight_kg)
    - name: "Average Total Gross Weight Kg"
      expr: AVG(total_gross_weight_kg)
    - name: "Total Total Volume M3"
      expr: SUM(total_volume_m3)
    - name: "Average Total Volume M3"
      expr: AVG(total_volume_m3)
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`order_delivery_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Delivery Item business metrics"
  source: "`vibe_manufacturing_v1`.`order`.`delivery_item`"
  dimensions:
    - name: "Actual Goods Issue Timestamp"
      expr: actual_goods_issue_timestamp
    - name: "Carrier Code"
      expr: carrier_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Delivery Date"
      expr: delivery_date
    - name: "Goods Movement Status"
      expr: goods_movement_status
    - name: "Handling Unit Number"
      expr: handling_unit_number
    - name: "Inventory Management Indicator"
      expr: inventory_management_indicator
    - name: "Item Category"
      expr: item_category
    - name: "Material Description"
      expr: material_description
    - name: "Movement Reason"
      expr: movement_reason
    - name: "Movement Type"
      expr: movement_type
    - name: "Pallet Number"
      expr: pallet_number
    - name: "Picking Status"
      expr: picking_status
    - name: "Plant"
      expr: plant
    - name: "Promised Delivery Date"
      expr: promised_delivery_date
    - name: "Route"
      expr: route
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Delivery Item"
      expr: COUNT(DISTINCT delivery_item_id)
    - name: "Total Quantity Delivered"
      expr: SUM(quantity_delivered)
    - name: "Average Quantity Delivered"
      expr: AVG(quantity_delivered)
    - name: "Total Quantity Ordered"
      expr: SUM(quantity_ordered)
    - name: "Average Quantity Ordered"
      expr: AVG(quantity_ordered)
    - name: "Total Quantity Picked"
      expr: SUM(quantity_picked)
    - name: "Average Quantity Picked"
      expr: AVG(quantity_picked)
    - name: "Total Volume M3"
      expr: SUM(volume_m3)
    - name: "Average Volume M3"
      expr: AVG(volume_m3)
    - name: "Total Weight Kg"
      expr: SUM(weight_kg)
    - name: "Average Weight Kg"
      expr: AVG(weight_kg)
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`order_goods_issue`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Goods Issue business metrics"
  source: "`vibe_manufacturing_v1`.`order`.`goods_issue`"
  dimensions:
    - name: "Actual Delivery Date"
      expr: actual_delivery_date
    - name: "Cost Center"
      expr: cost_center
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Delivery Date"
      expr: delivery_date
    - name: "Expected Delivery Date"
      expr: expected_delivery_date
    - name: "External Reference"
      expr: external_reference
    - name: "Goods Issue Status"
      expr: goods_issue_status
    - name: "Handling Unit"
      expr: handling_unit
    - name: "Incoterms"
      expr: incoterms
    - name: "Inventory Account"
      expr: inventory_account
    - name: "Is Automated"
      expr: is_automated
    - name: "Issue Number"
      expr: issue_number
    - name: "Movement Type"
      expr: movement_type
    - name: "Plant"
      expr: plant
    - name: "Posting Reason"
      expr: posting_reason
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Goods Issue"
      expr: COUNT(DISTINCT goods_issue_id)
    - name: "Total Net Amount"
      expr: SUM(net_amount)
    - name: "Average Net Amount"
      expr: AVG(net_amount)
    - name: "Total Quantity"
      expr: SUM(quantity)
    - name: "Average Quantity"
      expr: AVG(quantity)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
    - name: "Total Total Value Cost"
      expr: SUM(total_value_cost)
    - name: "Average Total Value Cost"
      expr: AVG(total_value_cost)
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`order_header`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Header business metrics"
  source: "`vibe_manufacturing_v1`.`order`.`header`"
  dimensions:
    - name: "Billing Block"
      expr: billing_block
    - name: "Credit Status"
      expr: credit_status
    - name: "Customer Account Group"
      expr: customer_account_group
    - name: "Customer Purchase Order Date"
      expr: customer_purchase_order_date
    - name: "Delivery Block"
      expr: delivery_block
    - name: "Distribution Channel"
      expr: distribution_channel
    - name: "Division"
      expr: division
    - name: "Freight Terms"
      expr: freight_terms
    - name: "Incoterms"
      expr: incoterms
    - name: "Internal Comments"
      expr: internal_comments
    - name: "Order Currency"
      expr: order_currency
    - name: "Order Number"
      expr: order_number
    - name: "Order Placed Timestamp"
      expr: order_placed_timestamp
    - name: "Order Priority"
      expr: order_priority
    - name: "Order Reason"
      expr: order_reason
    - name: "Order Status"
      expr: order_status
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Header"
      expr: COUNT(DISTINCT header_id)
    - name: "Total Currency Rate"
      expr: SUM(currency_rate)
    - name: "Average Currency Rate"
      expr: AVG(currency_rate)
    - name: "Total Gross Weight Kg"
      expr: SUM(gross_weight_kg)
    - name: "Average Gross Weight Kg"
      expr: AVG(gross_weight_kg)
    - name: "Total Net Weight Kg"
      expr: SUM(net_weight_kg)
    - name: "Average Net Weight Kg"
      expr: AVG(net_weight_kg)
    - name: "Total Total Gross Amount"
      expr: SUM(total_gross_amount)
    - name: "Average Total Gross Amount"
      expr: AVG(total_gross_amount)
    - name: "Total Total Net Amount"
      expr: SUM(total_net_amount)
    - name: "Average Total Net Amount"
      expr: AVG(total_net_amount)
    - name: "Total Total Tax Amount"
      expr: SUM(total_tax_amount)
    - name: "Average Total Tax Amount"
      expr: AVG(total_tax_amount)
    - name: "Total Volume M3"
      expr: SUM(volume_m3)
    - name: "Average Volume M3"
      expr: AVG(volume_m3)
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`order_order_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Order Line business metrics"
  source: "`vibe_manufacturing_v1`.`order`.`order_line`"
  dimensions:
    - name: "Actual Delivery Date"
      expr: actual_delivery_date
    - name: "Backorder Indicator"
      expr: backorder_indicator
    - name: "Batch Number"
      expr: batch_number
    - name: "Blanket Release Number"
      expr: blanket_release_number
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency"
      expr: currency
    - name: "Delivery Date"
      expr: delivery_date
    - name: "Delivery Status"
      expr: delivery_status
    - name: "Distribution Channel"
      expr: distribution_channel
    - name: "Division"
      expr: division
    - name: "Inspection Status"
      expr: inspection_status
    - name: "Lead Time Days"
      expr: lead_time_days
    - name: "Line Number"
      expr: line_number
    - name: "Plant"
      expr: plant
    - name: "Pricing Condition"
      expr: pricing_condition
    - name: "Product Description"
      expr: product_description
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Order Line"
      expr: COUNT(DISTINCT order_line_id)
    - name: "Total Confirmed Quantity"
      expr: SUM(confirmed_quantity)
    - name: "Average Confirmed Quantity"
      expr: AVG(confirmed_quantity)
    - name: "Total Discount Amount"
      expr: SUM(discount_amount)
    - name: "Average Discount Amount"
      expr: AVG(discount_amount)
    - name: "Total Gross Price"
      expr: SUM(gross_price)
    - name: "Average Gross Price"
      expr: AVG(gross_price)
    - name: "Total Gross Weight"
      expr: SUM(gross_weight)
    - name: "Average Gross Weight"
      expr: AVG(gross_weight)
    - name: "Total Net Price"
      expr: SUM(net_price)
    - name: "Average Net Price"
      expr: AVG(net_price)
    - name: "Total Net Weight"
      expr: SUM(net_weight)
    - name: "Average Net Weight"
      expr: AVG(net_weight)
    - name: "Total Quality Score"
      expr: SUM(quality_score)
    - name: "Average Quality Score"
      expr: AVG(quality_score)
    - name: "Total Requested Quantity"
      expr: SUM(requested_quantity)
    - name: "Average Requested Quantity"
      expr: AVG(requested_quantity)
    - name: "Total Sales Price"
      expr: SUM(sales_price)
    - name: "Average Sales Price"
      expr: AVG(sales_price)
    - name: "Total Sales Quantity"
      expr: SUM(sales_quantity)
    - name: "Average Sales Quantity"
      expr: AVG(sales_quantity)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
    - name: "Total Volume"
      expr: SUM(volume)
    - name: "Average Volume"
      expr: AVG(volume)
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`order_pricing_condition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pricing Condition business metrics"
  source: "`vibe_manufacturing_v1`.`order`.`pricing_condition`"
  dimensions:
    - name: "Calculation Base"
      expr: calculation_base
    - name: "Condition Description"
      expr: condition_description
    - name: "Condition Effective Timestamp"
      expr: condition_effective_timestamp
    - name: "Condition Expiration Timestamp"
      expr: condition_expiration_timestamp
    - name: "Condition Group"
      expr: condition_group
    - name: "Condition Note"
      expr: condition_note
    - name: "Condition Origin"
      expr: condition_origin
    - name: "Condition Priority"
      expr: condition_priority
    - name: "Condition Rate Unit"
      expr: condition_rate_unit
    - name: "Condition Sequence"
      expr: condition_sequence
    - name: "Condition Status"
      expr: condition_status
    - name: "Condition Type"
      expr: condition_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "External Condition Reference"
      expr: external_condition_reference
    - name: "Is Active"
      expr: is_active
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Pricing Condition"
      expr: COUNT(DISTINCT pricing_condition_id)
    - name: "Total Condition Rate"
      expr: SUM(condition_rate)
    - name: "Average Condition Rate"
      expr: AVG(condition_rate)
    - name: "Total Condition Value"
      expr: SUM(condition_value)
    - name: "Average Condition Value"
      expr: AVG(condition_value)
    - name: "Total Discount Amount"
      expr: SUM(discount_amount)
    - name: "Average Discount Amount"
      expr: AVG(discount_amount)
    - name: "Total Net Amount"
      expr: SUM(net_amount)
    - name: "Average Net Amount"
      expr: AVG(net_amount)
    - name: "Total Scale Quantity"
      expr: SUM(scale_quantity)
    - name: "Average Scale Quantity"
      expr: AVG(scale_quantity)
    - name: "Total Surcharge Amount"
      expr: SUM(surcharge_amount)
    - name: "Average Surcharge Amount"
      expr: AVG(surcharge_amount)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
    - name: "Total Tax Rate"
      expr: SUM(tax_rate)
    - name: "Average Tax Rate"
      expr: AVG(tax_rate)
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`order_rma`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rma business metrics"
  source: "`vibe_manufacturing_v1`.`order`.`rma`"
  dimensions:
    - name: "Actual Return Date"
      expr: actual_return_date
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Authorized Quantity"
      expr: authorized_quantity
    - name: "Carrier Name"
      expr: carrier_name
    - name: "Credit Memo Indicator"
      expr: credit_memo_indicator
    - name: "Currency Code"
      expr: currency_code
    - name: "Expected Return Date"
      expr: expected_return_date
    - name: "Inspection Required"
      expr: inspection_required
    - name: "Is Damaged"
      expr: is_damaged
    - name: "Is Repairable"
      expr: is_repairable
    - name: "Is Warranty Claim"
      expr: is_warranty_claim
    - name: "Is Wrong Item"
      expr: is_wrong_item
    - name: "Notes"
      expr: notes
    - name: "Order Rma Status"
      expr: order_rma_status
    - name: "Record Audit Created"
      expr: record_audit_created
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Rma"
      expr: COUNT(DISTINCT rma_id)
    - name: "Total Credit Amount"
      expr: SUM(credit_amount)
    - name: "Average Credit Amount"
      expr: AVG(credit_amount)
    - name: "Total Handling Fee"
      expr: SUM(handling_fee)
    - name: "Average Handling Fee"
      expr: AVG(handling_fee)
    - name: "Total Net Amount"
      expr: SUM(net_amount)
    - name: "Average Net Amount"
      expr: AVG(net_amount)
    - name: "Total Refund Amount"
      expr: SUM(refund_amount)
    - name: "Average Refund Amount"
      expr: AVG(refund_amount)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`order_schedule_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Schedule Line business metrics"
  source: "`vibe_manufacturing_v1`.`order`.`schedule_line`"
  dimensions:
    - name: "Backorder Indicator"
      expr: backorder_indicator
    - name: "Batch Number"
      expr: batch_number
    - name: "Confirmed Delivery Date"
      expr: confirmed_delivery_date
    - name: "Confirmed Quantity Uom"
      expr: confirmed_quantity_uom
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Goods Issue Date"
      expr: goods_issue_date
    - name: "Handling Unit"
      expr: handling_unit
    - name: "Incoterms"
      expr: incoterms
    - name: "Mrp Confirmed Availability Date"
      expr: mrp_confirmed_availability_date
    - name: "Plant"
      expr: plant
    - name: "Priority Code"
      expr: priority_code
    - name: "Requested Delivery Date"
      expr: requested_delivery_date
    - name: "Requested Quantity Uom"
      expr: requested_quantity_uom
    - name: "Route"
      expr: route
    - name: "Schedule Line Number"
      expr: schedule_line_number
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Schedule Line"
      expr: COUNT(DISTINCT schedule_line_id)
    - name: "Total Confirmed Quantity"
      expr: SUM(confirmed_quantity)
    - name: "Average Confirmed Quantity"
      expr: AVG(confirmed_quantity)
    - name: "Total Line Net Amount"
      expr: SUM(line_net_amount)
    - name: "Average Line Net Amount"
      expr: AVG(line_net_amount)
    - name: "Total Requested Quantity"
      expr: SUM(requested_quantity)
    - name: "Average Requested Quantity"
      expr: AVG(requested_quantity)
$$;