-- Metric views for domain: order | Business: Semiconductors | Version: 2 | Generated on: 2026-07-10 14:15:10

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core order performance metrics tracking order value, volume, and strategic program participation across customer segments and product families"
  source: "`vibe_semiconductors_v1`.`order`.`order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the order (e.g., confirmed, shipped, cancelled)"
    - name: "order_type"
      expr: order_type
      comment: "Type of order (e.g., standard, NRE, MPW, die bank)"
    - name: "end_market_segment"
      expr: end_market_segment
      comment: "Target end market segment for the order (e.g., automotive, industrial, consumer)"
    - name: "distribution_channel"
      expr: distribution_channel
      comment: "Sales distribution channel through which the order was placed"
    - name: "ship_to_country_code"
      expr: ship_to_country_code
      comment: "Destination country code for shipment"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the order is denominated"
    - name: "allocation_status"
      expr: allocation_status
      comment: "Current allocation status of the order"
    - name: "priority"
      expr: priority
      comment: "Order priority level"
    - name: "order_year"
      expr: YEAR(order_date)
      comment: "Year the order was placed"
    - name: "order_month"
      expr: DATE_TRUNC('MONTH', order_date)
      comment: "Month the order was placed"
    - name: "chips_act_eligible"
      expr: chips_act_eligible
      comment: "Whether the order is eligible under CHIPS Act incentives"
    - name: "itar_controlled"
      expr: itar_controlled
      comment: "Whether the order contains ITAR-controlled items"
    - name: "backlog_flag"
      expr: backlog_flag
      comment: "Whether the order is currently in backlog"
    - name: "export_license_required"
      expr: export_license_required
      comment: "Whether export license is required for this order"
  measures:
    - name: "total_order_count"
      expr: COUNT(DISTINCT order_id)
      comment: "Total number of unique orders"
    - name: "total_gross_order_value"
      expr: SUM(CAST(gross_order_value AS DOUBLE))
      comment: "Total gross order value across all orders"
    - name: "total_net_order_value"
      expr: SUM(CAST(net_order_value AS DOUBLE))
      comment: "Total net order value (after discounts and adjustments)"
    - name: "total_nre_amount"
      expr: SUM(CAST(nre_amount AS DOUBLE))
      comment: "Total non-recurring engineering revenue across orders"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount collected across orders"
    - name: "avg_gross_order_value"
      expr: AVG(CAST(gross_order_value AS DOUBLE))
      comment: "Average gross order value per order"
    - name: "avg_net_order_value"
      expr: AVG(CAST(net_order_value AS DOUBLE))
      comment: "Average net order value per order"
    - name: "distinct_customers"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique customers placing orders"
    - name: "distinct_product_families"
      expr: COUNT(DISTINCT family_id)
      comment: "Number of unique product families ordered"
    - name: "chips_act_order_count"
      expr: COUNT(DISTINCT CASE WHEN chips_act_eligible = TRUE THEN order_id END)
      comment: "Number of orders eligible under CHIPS Act"
    - name: "itar_controlled_order_count"
      expr: COUNT(DISTINCT CASE WHEN itar_controlled = TRUE THEN order_id END)
      comment: "Number of orders containing ITAR-controlled items"
    - name: "backlog_order_count"
      expr: COUNT(DISTINCT CASE WHEN backlog_flag = TRUE THEN order_id END)
      comment: "Number of orders currently in backlog"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`order_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Order line-level metrics tracking revenue, quantity, fulfillment performance, and product mix at the SKU level"
  source: "`vibe_semiconductors_v1`.`order`.`line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Current status of the order line"
    - name: "item_category"
      expr: item_category
      comment: "Category of the line item"
    - name: "allocation_type"
      expr: allocation_type
      comment: "Type of allocation for this line"
    - name: "ship_to_country"
      expr: ship_to_country
      comment: "Destination country for this line item"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for line pricing"
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for quantities"
    - name: "temperature_grade"
      expr: temperature_grade
      comment: "Temperature grade specification of the product"
    - name: "speed_grade"
      expr: speed_grade
      comment: "Speed grade specification of the product"
    - name: "die_bank_order"
      expr: die_bank_order
      comment: "Whether this is a die bank order"
    - name: "mpw_order"
      expr: mpw_order
      comment: "Whether this is a multi-project wafer order"
    - name: "rohs_compliant"
      expr: rohs_compliant
      comment: "Whether the product is RoHS compliant"
    - name: "reach_compliant"
      expr: reach_compliant
      comment: "Whether the product is REACH compliant"
    - name: "order_year"
      expr: YEAR(date_entered)
      comment: "Year the line was entered"
    - name: "order_month"
      expr: DATE_TRUNC('MONTH', date_entered)
      comment: "Month the line was entered"
  measures:
    - name: "total_line_count"
      expr: COUNT(DISTINCT line_id)
      comment: "Total number of unique order lines"
    - name: "total_line_net_value"
      expr: SUM(CAST(net_value AS DOUBLE))
      comment: "Total net value across all order lines"
    - name: "total_ordered_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total quantity ordered across all lines"
    - name: "total_confirmed_quantity"
      expr: SUM(CAST(confirmed_quantity AS DOUBLE))
      comment: "Total quantity confirmed for fulfillment"
    - name: "total_shipped_quantity"
      expr: SUM(CAST(shipped_quantity AS DOUBLE))
      comment: "Total quantity shipped to customers"
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price across order lines"
    - name: "avg_line_value"
      expr: AVG(CAST(net_value AS DOUBLE))
      comment: "Average net value per order line"
    - name: "distinct_skus"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of unique SKUs ordered"
    - name: "distinct_orders"
      expr: COUNT(DISTINCT order_id)
      comment: "Number of unique orders containing these lines"
    - name: "lines_with_partial_shipment"
      expr: COUNT(DISTINCT CASE WHEN partial_shipment_allowed = TRUE THEN line_id END)
      comment: "Number of lines allowing partial shipment"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`order_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supply allocation and fulfillment metrics tracking allocation efficiency, constrained supply, and quality disposition across production lots"
  source: "`vibe_semiconductors_v1`.`order`.`allocation_record`"
  dimensions:
    - name: "allocation_type"
      expr: allocation_type
      comment: "Type of allocation (e.g., firm, soft, forecast)"
    - name: "allocation_source"
      expr: allocation_source
      comment: "Source system or process that created the allocation"
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current assignment status of the allocation"
    - name: "quality_disposition"
      expr: quality_disposition
      comment: "Quality disposition status (e.g., approved, hold, rejected)"
    - name: "lot_type"
      expr: lot_type
      comment: "Type of production lot allocated"
    - name: "process_node"
      expr: process_node
      comment: "Semiconductor process node (e.g., 7nm, 14nm)"
    - name: "end_market_segment"
      expr: end_market_segment
      comment: "Target end market segment for the allocation"
    - name: "priority_rank"
      expr: priority_rank
      comment: "Priority ranking of the allocation"
    - name: "osat_site_code"
      expr: osat_site_code
      comment: "OSAT (Outsourced Assembly and Test) site code"
    - name: "quantity_unit_of_measure"
      expr: quantity_unit_of_measure
      comment: "Unit of measure for allocated quantities"
    - name: "backlog_flag"
      expr: backlog_flag
      comment: "Whether the allocation is in backlog"
    - name: "constrained_supply_flag"
      expr: constrained_supply_flag
      comment: "Whether supply is constrained for this allocation"
    - name: "chips_act_eligible"
      expr: chips_act_eligible
      comment: "Whether the allocation is CHIPS Act eligible"
    - name: "itar_controlled"
      expr: itar_controlled
      comment: "Whether the allocation contains ITAR-controlled items"
    - name: "allocation_year"
      expr: YEAR(allocation_date)
      comment: "Year the allocation was made"
    - name: "allocation_month"
      expr: DATE_TRUNC('MONTH', allocation_date)
      comment: "Month the allocation was made"
  measures:
    - name: "total_allocation_count"
      expr: COUNT(DISTINCT allocation_record_id)
      comment: "Total number of unique allocation records"
    - name: "total_allocated_quantity"
      expr: SUM(CAST(allocated_quantity AS DOUBLE))
      comment: "Total quantity allocated across all records"
    - name: "total_confirmed_quantity"
      expr: SUM(CAST(confirmed_quantity AS DOUBLE))
      comment: "Total quantity confirmed for allocation"
    - name: "total_shipped_quantity"
      expr: SUM(CAST(shipped_quantity AS DOUBLE))
      comment: "Total quantity shipped from allocations"
    - name: "avg_allocated_quantity"
      expr: AVG(CAST(allocated_quantity AS DOUBLE))
      comment: "Average quantity per allocation record"
    - name: "distinct_customers"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique customers with allocations"
    - name: "distinct_skus"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of unique SKUs allocated"
    - name: "distinct_fab_facilities"
      expr: COUNT(DISTINCT fab_facility_id)
      comment: "Number of unique fab facilities involved in allocations"
    - name: "constrained_allocation_count"
      expr: COUNT(DISTINCT CASE WHEN constrained_supply_flag = TRUE THEN allocation_record_id END)
      comment: "Number of allocations with constrained supply"
    - name: "backlog_allocation_count"
      expr: COUNT(DISTINCT CASE WHEN backlog_flag = TRUE THEN allocation_record_id END)
      comment: "Number of allocations currently in backlog"
    - name: "chips_act_allocation_count"
      expr: COUNT(DISTINCT CASE WHEN chips_act_eligible = TRUE THEN allocation_record_id END)
      comment: "Number of CHIPS Act eligible allocations"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`order_backlog`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Backlog health and aging metrics tracking unfulfilled demand, commitment status, and backlog value across customer segments"
  source: "`vibe_semiconductors_v1`.`order`.`backlog_position`"
  dimensions:
    - name: "backlog_status"
      expr: backlog_status
      comment: "Current status of the backlog position"
    - name: "allocation_status"
      expr: allocation_status
      comment: "Allocation status for the backlog position"
    - name: "backlog_aging_days"
      expr: backlog_aging_days
      comment: "Number of days the position has been in backlog"
    - name: "order_type"
      expr: order_type
      comment: "Type of order in backlog"
    - name: "end_market_segment"
      expr: end_market_segment
      comment: "Target end market segment"
    - name: "sales_region"
      expr: sales_region
      comment: "Sales region for the backlog position"
    - name: "ship_to_country_code"
      expr: ship_to_country_code
      comment: "Destination country code"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for backlog value"
    - name: "priority_rank"
      expr: priority_rank
      comment: "Priority ranking of the backlog position"
    - name: "hold_code"
      expr: hold_code
      comment: "Hold code if position is on hold"
    - name: "push_out_reason_code"
      expr: push_out_reason_code
      comment: "Reason code for delivery push-out"
    - name: "design_win_flag"
      expr: design_win_flag
      comment: "Whether this backlog is associated with a design win"
    - name: "export_control_flag"
      expr: export_control_flag
      comment: "Whether export controls apply"
    - name: "snapshot_year"
      expr: YEAR(snapshot_date)
      comment: "Year of the backlog snapshot"
    - name: "snapshot_month"
      expr: DATE_TRUNC('MONTH', snapshot_date)
      comment: "Month of the backlog snapshot"
  measures:
    - name: "total_backlog_positions"
      expr: COUNT(DISTINCT backlog_position_id)
      comment: "Total number of unique backlog positions"
    - name: "total_backlog_value"
      expr: SUM(CAST(backlog_value AS DOUBLE))
      comment: "Total value of backlog across all positions"
    - name: "total_original_order_quantity"
      expr: SUM(CAST(original_order_quantity AS DOUBLE))
      comment: "Total originally ordered quantity in backlog"
    - name: "total_committed_quantity"
      expr: SUM(CAST(committed_quantity AS DOUBLE))
      comment: "Total quantity committed for fulfillment"
    - name: "total_allocated_quantity"
      expr: SUM(CAST(allocated_quantity AS DOUBLE))
      comment: "Total quantity allocated from backlog"
    - name: "total_shipped_quantity"
      expr: SUM(CAST(shipped_quantity AS DOUBLE))
      comment: "Total quantity shipped from backlog"
    - name: "total_cancelled_quantity"
      expr: SUM(CAST(cancelled_quantity AS DOUBLE))
      comment: "Total quantity cancelled from backlog"
    - name: "avg_backlog_value"
      expr: AVG(CAST(backlog_value AS DOUBLE))
      comment: "Average backlog value per position"
    - name: "avg_net_selling_price"
      expr: AVG(CAST(net_selling_price AS DOUBLE))
      comment: "Average net selling price in backlog"
    - name: "distinct_customers"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique customers with backlog"
    - name: "distinct_skus"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of unique SKUs in backlog"
    - name: "design_win_backlog_count"
      expr: COUNT(DISTINCT CASE WHEN design_win_flag = TRUE THEN backlog_position_id END)
      comment: "Number of backlog positions associated with design wins"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`order_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shipment execution and logistics metrics tracking on-time delivery, freight costs, and shipment quality across carriers and destinations"
  source: "`vibe_semiconductors_v1`.`order`.`shipment`"
  dimensions:
    - name: "shipment_status"
      expr: shipment_status
      comment: "Current status of the shipment"
    - name: "carrier_name"
      expr: carrier_name
      comment: "Name of the shipping carrier"
    - name: "service_level"
      expr: service_level
      comment: "Service level for the shipment (e.g., express, standard)"
    - name: "destination_country_code"
      expr: destination_country_code
      comment: "Destination country code"
    - name: "incoterms_code"
      expr: incoterms_code
      comment: "Incoterms code defining delivery terms"
    - name: "package_type"
      expr: package_type
      comment: "Type of packaging used"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for shipment costs"
    - name: "export_control_classification"
      expr: export_control_classification
      comment: "Export control classification (e.g., ECCN)"
    - name: "damaged_goods_flag"
      expr: damaged_goods_flag
      comment: "Whether damaged goods were reported"
    - name: "quantity_shortage_flag"
      expr: quantity_shortage_flag
      comment: "Whether quantity shortage was reported"
    - name: "wrong_part_flag"
      expr: wrong_part_flag
      comment: "Whether wrong part was shipped"
    - name: "is_multi_leg"
      expr: is_multi_leg
      comment: "Whether shipment involves multiple legs"
    - name: "rohs_compliant"
      expr: rohs_compliant
      comment: "Whether shipment is RoHS compliant"
    - name: "reach_compliant"
      expr: reach_compliant
      comment: "Whether shipment is REACH compliant"
    - name: "ship_year"
      expr: YEAR(ship_date)
      comment: "Year the shipment was dispatched"
    - name: "ship_month"
      expr: DATE_TRUNC('MONTH', ship_date)
      comment: "Month the shipment was dispatched"
  measures:
    - name: "total_shipment_count"
      expr: COUNT(DISTINCT shipment_id)
      comment: "Total number of unique shipments"
    - name: "total_shipped_quantity"
      expr: SUM(CAST(shipped_quantity AS DOUBLE))
      comment: "Total quantity shipped across all shipments"
    - name: "total_pod_confirmed_quantity"
      expr: SUM(CAST(pod_confirmed_quantity AS DOUBLE))
      comment: "Total quantity confirmed via proof of delivery"
    - name: "total_freight_cost_usd"
      expr: SUM(CAST(freight_cost_usd AS DOUBLE))
      comment: "Total freight cost in USD across all shipments"
    - name: "total_declared_value_usd"
      expr: SUM(CAST(declared_value_usd AS DOUBLE))
      comment: "Total declared value in USD for insurance purposes"
    - name: "total_gross_weight_kg"
      expr: SUM(CAST(gross_weight_kg AS DOUBLE))
      comment: "Total gross weight in kilograms shipped"
    - name: "avg_freight_cost_usd"
      expr: AVG(CAST(freight_cost_usd AS DOUBLE))
      comment: "Average freight cost per shipment in USD"
    - name: "avg_gross_weight_kg"
      expr: AVG(CAST(gross_weight_kg AS DOUBLE))
      comment: "Average gross weight per shipment in kilograms"
    - name: "distinct_customers"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique customers receiving shipments"
    - name: "distinct_carriers"
      expr: COUNT(DISTINCT carrier_name)
      comment: "Number of unique carriers used"
    - name: "damaged_shipment_count"
      expr: COUNT(DISTINCT CASE WHEN damaged_goods_flag = TRUE THEN shipment_id END)
      comment: "Number of shipments with damaged goods reported"
    - name: "shortage_shipment_count"
      expr: COUNT(DISTINCT CASE WHEN quantity_shortage_flag = TRUE THEN shipment_id END)
      comment: "Number of shipments with quantity shortages"
    - name: "wrong_part_shipment_count"
      expr: COUNT(DISTINCT CASE WHEN wrong_part_flag = TRUE THEN shipment_id END)
      comment: "Number of shipments with wrong parts"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`order_rma`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Return merchandise authorization metrics tracking return volume, credit amounts, root cause analysis, and warranty claims for quality improvement"
  source: "`vibe_semiconductors_v1`.`order`.`rma`"
  dimensions:
    - name: "rma_status"
      expr: rma_status
      comment: "Current status of the RMA"
    - name: "return_reason_code"
      expr: return_reason_code
      comment: "Reason code for the return"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category identified during analysis"
    - name: "disposition_instruction"
      expr: disposition_instruction
      comment: "Disposition instruction for returned goods"
    - name: "inspection_result"
      expr: inspection_result
      comment: "Result of inspection upon receipt"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for credit amounts"
    - name: "return_shipping_carrier"
      expr: return_shipping_carrier
      comment: "Carrier used for return shipment"
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for returned quantities"
    - name: "warranty_claim_flag"
      expr: warranty_claim_flag
      comment: "Whether this is a warranty claim"
    - name: "failure_analysis_requested"
      expr: failure_analysis_requested
      comment: "Whether failure analysis was requested"
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Whether corrective action is required"
    - name: "dppm_impact_flag"
      expr: dppm_impact_flag
      comment: "Whether this RMA impacts DPPM (defects per million) metrics"
    - name: "export_control_flag"
      expr: export_control_flag
      comment: "Whether export controls apply to the return"
    - name: "request_year"
      expr: YEAR(request_date)
      comment: "Year the RMA was requested"
    - name: "request_month"
      expr: DATE_TRUNC('MONTH', request_date)
      comment: "Month the RMA was requested"
  measures:
    - name: "total_rma_count"
      expr: COUNT(DISTINCT rma_id)
      comment: "Total number of unique RMA records"
    - name: "total_credit_amount"
      expr: SUM(CAST(credit_amount AS DOUBLE))
      comment: "Total credit amount issued for returns"
    - name: "avg_credit_amount"
      expr: AVG(CAST(credit_amount AS DOUBLE))
      comment: "Average credit amount per RMA"
    - name: "distinct_customers"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique customers with RMAs"
    - name: "distinct_skus"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of unique SKUs returned"
    - name: "warranty_claim_count"
      expr: COUNT(DISTINCT CASE WHEN warranty_claim_flag = TRUE THEN rma_id END)
      comment: "Number of RMAs that are warranty claims"
    - name: "failure_analysis_requested_count"
      expr: COUNT(DISTINCT CASE WHEN failure_analysis_requested = TRUE THEN rma_id END)
      comment: "Number of RMAs with failure analysis requested"
    - name: "corrective_action_required_count"
      expr: COUNT(DISTINCT CASE WHEN corrective_action_required = TRUE THEN rma_id END)
      comment: "Number of RMAs requiring corrective action"
    - name: "dppm_impact_count"
      expr: COUNT(DISTINCT CASE WHEN dppm_impact_flag = TRUE THEN rma_id END)
      comment: "Number of RMAs impacting DPPM quality metrics"
    - name: "distinct_return_carriers"
      expr: COUNT(DISTINCT return_shipping_carrier)
      comment: "Number of unique carriers used for returns"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`order_delivery_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Delivery schedule performance metrics tracking on-time delivery, schedule adherence, and delivery quantity fulfillment across order types"
  source: "`vibe_semiconductors_v1`.`order`.`delivery_schedule`"
  dimensions:
    - name: "schedule_line_status"
      expr: schedule_line_status
      comment: "Current status of the delivery schedule line"
    - name: "sap_schedule_line_category"
      expr: sap_schedule_line_category
      comment: "SAP schedule line category"
    - name: "allocation_priority"
      expr: allocation_priority
      comment: "Allocation priority for the schedule line"
    - name: "incoterms_code"
      expr: incoterms_code
      comment: "Incoterms code for delivery terms"
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country of origin for the goods"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for schedule line value"
    - name: "quantity_unit"
      expr: quantity_unit
      comment: "Unit of measure for quantities"
    - name: "packaging_type"
      expr: packaging_type
      comment: "Type of packaging for delivery"
    - name: "export_control_status"
      expr: export_control_status
      comment: "Export control status for the delivery"
    - name: "last_reschedule_reason"
      expr: last_reschedule_reason
      comment: "Reason for the last schedule change"
    - name: "backlog_flag"
      expr: backlog_flag
      comment: "Whether the schedule line is in backlog"
    - name: "blanket_order_flag"
      expr: blanket_order_flag
      comment: "Whether this is part of a blanket order"
    - name: "mpw_order_flag"
      expr: mpw_order_flag
      comment: "Whether this is a multi-project wafer order"
    - name: "rohs_compliant_flag"
      expr: rohs_compliant_flag
      comment: "Whether the delivery is RoHS compliant"
    - name: "requested_delivery_year"
      expr: YEAR(requested_delivery_date)
      comment: "Year of requested delivery"
    - name: "requested_delivery_month"
      expr: DATE_TRUNC('MONTH', requested_delivery_date)
      comment: "Month of requested delivery"
  measures:
    - name: "total_schedule_line_count"
      expr: COUNT(DISTINCT delivery_schedule_id)
      comment: "Total number of unique delivery schedule lines"
    - name: "total_ordered_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total quantity ordered across schedule lines"
    - name: "total_confirmed_quantity"
      expr: SUM(CAST(confirmed_quantity AS DOUBLE))
      comment: "Total quantity confirmed for delivery"
    - name: "total_delivered_quantity"
      expr: SUM(CAST(delivered_quantity AS DOUBLE))
      comment: "Total quantity actually delivered"
    - name: "total_net_value"
      expr: SUM(CAST(net_value AS DOUBLE))
      comment: "Total net value of scheduled deliveries"
    - name: "avg_net_value"
      expr: AVG(CAST(net_value AS DOUBLE))
      comment: "Average net value per schedule line"
    - name: "distinct_customers"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique customers with delivery schedules"
    - name: "distinct_skus"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of unique SKUs scheduled for delivery"
    - name: "distinct_orders"
      expr: COUNT(DISTINCT order_id)
      comment: "Number of unique orders with delivery schedules"
    - name: "backlog_schedule_count"
      expr: COUNT(DISTINCT CASE WHEN backlog_flag = TRUE THEN delivery_schedule_id END)
      comment: "Number of schedule lines in backlog"
    - name: "blanket_order_schedule_count"
      expr: COUNT(DISTINCT CASE WHEN blanket_order_flag = TRUE THEN delivery_schedule_id END)
      comment: "Number of schedule lines from blanket orders"
$$;