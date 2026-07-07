-- Metric views for domain: order | Business: Manufacturing | Version: 2 | Generated on: 2026-07-03 07:48:32

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
    - name: "Address Line1"
      expr: address_line1
    - name: "Carrier Code"
      expr: carrier_code
    - name: "Carrier Name"
      expr: carrier_name
    - name: "City"
      expr: city
    - name: "Country"
      expr: country
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Delivery Date"
      expr: delivery_date
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
    - name: "Inspection Result"
      expr: inspection_result
    - name: "Inventory Management Indicator"
      expr: inventory_management_indicator
    - name: "Item Category"
      expr: item_category
    - name: "Item Number"
      expr: item_number
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
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Delivery Item"
      expr: COUNT(DISTINCT delivery_item_id)
    - name: "Total Delivered Quantity"
      expr: SUM(delivered_quantity)
    - name: "Average Delivered Quantity"
      expr: AVG(delivered_quantity)
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

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`order_fulfillment_sla`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fulfillment Sla business metrics"
  source: "`vibe_manufacturing_v1`.`order`.`fulfillment_sla`"
  dimensions:
    - name: "Actual Days"
      expr: actual_days
    - name: "Applicable Product Category Code"
      expr: applicable_product_category_code
    - name: "Breach Action"
      expr: breach_action
    - name: "Breach Reason"
      expr: breach_reason
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Description"
      expr: description
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Expedite Eligible"
      expr: expedite_eligible
    - name: "Fulfillment Sla Status"
      expr: fulfillment_sla_status
    - name: "Last Review Date"
      expr: last_review_date
    - name: "Max Order Quantity"
      expr: max_order_quantity
    - name: "Measurement Window Days"
      expr: measurement_window_days
    - name: "Min Order Quantity"
      expr: min_order_quantity
    - name: "Order Confirmation Turnaround Hours"
      expr: order_confirmation_turnaround_hours
    - name: "Penalty Terms"
      expr: penalty_terms
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Fulfillment Sla"
      expr: COUNT(DISTINCT fulfillment_sla_id)
    - name: "Total On Time Delivery Threshold Pct"
      expr: SUM(on_time_delivery_threshold_pct)
    - name: "Average On Time Delivery Threshold Pct"
      expr: AVG(on_time_delivery_threshold_pct)
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
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Delivery Date"
      expr: delivery_date
    - name: "Delivery Doc Number"
      expr: delivery_doc_number
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
    - name: "Issued By User"
      expr: issued_by_user
    - name: "Material Document Number"
      expr: material_document_number
    - name: "Movement Type"
      expr: movement_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Goods Issue"
      expr: COUNT(DISTINCT goods_issue_id)
    - name: "Total Cost Center"
      expr: SUM(cost_center)
    - name: "Average Cost Center"
      expr: AVG(cost_center)
    - name: "Total Issued Quantity"
      expr: SUM(issued_quantity)
    - name: "Average Issued Quantity"
      expr: AVG(issued_quantity)
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
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
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
    - name: "Incoterms"
      expr: incoterms
    - name: "Internal Comments"
      expr: internal_comments
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Order Currency"
      expr: order_currency
    - name: "Order Date"
      expr: order_date
    - name: "Order Number"
      expr: order_number
    - name: "Order Placed Timestamp"
      expr: order_placed_timestamp
    - name: "Order Priority"
      expr: order_priority
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Header"
      expr: COUNT(DISTINCT header_id)
    - name: "Total Credit Status"
      expr: SUM(credit_status)
    - name: "Average Credit Status"
      expr: AVG(credit_status)
    - name: "Total Currency Rate"
      expr: SUM(currency_rate)
    - name: "Average Currency Rate"
      expr: AVG(currency_rate)
    - name: "Total Freight Terms"
      expr: SUM(freight_terms)
    - name: "Average Freight Terms"
      expr: AVG(freight_terms)
    - name: "Total Gross Weight Kg"
      expr: SUM(gross_weight_kg)
    - name: "Average Gross Weight Kg"
      expr: AVG(gross_weight_kg)
    - name: "Total Net Weight Kg"
      expr: SUM(net_weight_kg)
    - name: "Average Net Weight Kg"
      expr: AVG(net_weight_kg)
    - name: "Total Payment Terms"
      expr: SUM(payment_terms)
    - name: "Average Payment Terms"
      expr: AVG(payment_terms)
    - name: "Total Price Group"
      expr: SUM(price_group)
    - name: "Average Price Group"
      expr: AVG(price_group)
    - name: "Total Price List"
      expr: SUM(price_list)
    - name: "Average Price List"
      expr: AVG(price_list)
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

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`order_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line business metrics"
  source: "`vibe_manufacturing_v1`.`order`.`line`"
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
    - name: "Line Status"
      expr: line_status
    - name: "Plant"
      expr: plant
    - name: "Pricing Condition"
      expr: pricing_condition
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Line"
      expr: COUNT(DISTINCT line_id)
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
    - name: "Total Net Amount"
      expr: SUM(net_amount)
    - name: "Average Net Amount"
      expr: AVG(net_amount)
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
    - name: "Total Quantity"
      expr: SUM(quantity)
    - name: "Average Quantity"
      expr: AVG(quantity)
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
    - name: "Is Expedited"
      expr: is_expedited
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Pricing Condition"
      expr: COUNT(DISTINCT pricing_condition_id)
    - name: "Total Condition Rate"
      expr: SUM(condition_rate)
    - name: "Average Condition Rate"
      expr: AVG(condition_rate)
    - name: "Total Condition Rate Percent"
      expr: SUM(condition_rate_percent)
    - name: "Average Condition Rate Percent"
      expr: AVG(condition_rate_percent)
    - name: "Total Condition Rate Unit"
      expr: SUM(condition_rate_unit)
    - name: "Average Condition Rate Unit"
      expr: AVG(condition_rate_unit)
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
    - name: "Authorized Date"
      expr: authorized_date
    - name: "Authorized Quantity"
      expr: authorized_quantity
    - name: "Carrier Name"
      expr: carrier_name
    - name: "Created Timestamp"
      expr: created_timestamp
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
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Rma"
      expr: COUNT(DISTINCT rma_id)
    - name: "Total Credit Amount"
      expr: SUM(credit_amount)
    - name: "Average Credit Amount"
      expr: AVG(credit_amount)
    - name: "Total Credit Memo Indicator"
      expr: SUM(credit_memo_indicator)
    - name: "Average Credit Memo Indicator"
      expr: AVG(credit_memo_indicator)
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

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`order_rma_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rma Line business metrics"
  source: "`vibe_manufacturing_v1`.`order`.`rma_line`"
  dimensions:
    - name: "Condition Code"
      expr: condition_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Disposition"
      expr: disposition
    - name: "Disposition Action"
      expr: disposition_action
    - name: "Disposition Reason"
      expr: disposition_reason
    - name: "Inspection Required Flag"
      expr: inspection_required_flag
    - name: "Inspection Status"
      expr: inspection_status
    - name: "Material Description"
      expr: material_description
    - name: "Notes"
      expr: notes
    - name: "Original Delivery Date"
      expr: original_delivery_date
    - name: "Received Date"
      expr: received_date
    - name: "Replace Flag"
      expr: replace_flag
    - name: "Replacement Part Number"
      expr: replacement_part_number
    - name: "Restock Status"
      expr: restock_status
    - name: "Restock Warehouse"
      expr: restock_warehouse
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Rma Line"
      expr: COUNT(DISTINCT rma_line_id)
    - name: "Total Credit Amount"
      expr: SUM(credit_amount)
    - name: "Average Credit Amount"
      expr: AVG(credit_amount)
    - name: "Total Refund Amount"
      expr: SUM(refund_amount)
    - name: "Average Refund Amount"
      expr: AVG(refund_amount)
    - name: "Total Restock Quantity"
      expr: SUM(restock_quantity)
    - name: "Average Restock Quantity"
      expr: AVG(restock_quantity)
    - name: "Total Return Quantity"
      expr: SUM(return_quantity)
    - name: "Average Return Quantity"
      expr: AVG(return_quantity)
    - name: "Total Returned Quantity"
      expr: SUM(returned_quantity)
    - name: "Average Returned Quantity"
      expr: AVG(returned_quantity)
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
    - name: "Confirmed Delivery Date"
      expr: confirmed_delivery_date
    - name: "Confirmed Quantity Uom"
      expr: confirmed_quantity_uom
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Delivery Date"
      expr: delivery_date
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
    - name: "Total Committed Quantity"
      expr: SUM(committed_quantity)
    - name: "Average Committed Quantity"
      expr: AVG(committed_quantity)
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