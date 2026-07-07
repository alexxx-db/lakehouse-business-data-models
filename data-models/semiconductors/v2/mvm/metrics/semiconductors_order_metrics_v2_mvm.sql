-- Metric views for domain: order | Business: Semiconductors | Version: 2 | Generated on: 2026-06-27 11:25:39

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core order performance metrics tracking order value, volume, and fulfillment efficiency across customer segments and channels"
  source: "`vibe_semiconductors_v1`.`order`.`order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the order (e.g., open, confirmed, shipped, cancelled)"
    - name: "order_type"
      expr: order_type
      comment: "Type of order (e.g., standard, expedite, consignment, MPW)"
    - name: "end_market_segment"
      expr: end_market_segment
      comment: "Target end market segment for the order (e.g., automotive, consumer, industrial, aerospace)"
    - name: "distribution_channel"
      expr: distribution_channel
      comment: "Sales distribution channel (e.g., direct, distributor, OEM)"
    - name: "ship_to_country_code"
      expr: ship_to_country_code
      comment: "ISO country code for shipment destination"
    - name: "order_year"
      expr: YEAR(order_date)
      comment: "Year the order was placed"
    - name: "order_month"
      expr: DATE_TRUNC('MONTH', order_date)
      comment: "Month the order was placed, truncated to first day of month"
    - name: "priority"
      expr: priority
      comment: "Order priority level"
    - name: "backlog_flag"
      expr: backlog_flag
      comment: "Indicates whether order is in backlog"
    - name: "chips_act_eligible"
      expr: chips_act_eligible
      comment: "Indicates whether order qualifies for CHIPS Act incentives"
    - name: "export_license_required"
      expr: export_license_required
      comment: "Indicates whether order requires export license"
    - name: "itar_controlled"
      expr: itar_controlled
      comment: "Indicates whether order is subject to ITAR export controls"
  measures:
    - name: "total_order_count"
      expr: COUNT(1)
      comment: "Total number of orders"
    - name: "unique_customers"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique customer accounts placing orders"
    - name: "gross_order_value"
      expr: SUM(CAST(gross_order_value AS DOUBLE))
      comment: "Total gross order value before discounts and adjustments"
    - name: "net_order_value"
      expr: SUM(CAST(net_order_value AS DOUBLE))
      comment: "Total net order value after discounts and adjustments"
    - name: "total_nre_amount"
      expr: SUM(CAST(nre_amount AS DOUBLE))
      comment: "Total non-recurring engineering charges across orders"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount collected on orders"
    - name: "avg_order_value"
      expr: AVG(CAST(net_order_value AS DOUBLE))
      comment: "Average net order value per order"
    - name: "backlog_order_count"
      expr: SUM(CASE WHEN backlog_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of orders currently in backlog status"
    - name: "cancelled_order_count"
      expr: SUM(CASE WHEN order_status = 'cancelled' THEN 1 ELSE 0 END)
      comment: "Number of cancelled orders"
    - name: "chips_act_eligible_order_count"
      expr: SUM(CASE WHEN chips_act_eligible = TRUE THEN 1 ELSE 0 END)
      comment: "Number of orders eligible for CHIPS Act incentives"
    - name: "export_controlled_order_count"
      expr: SUM(CASE WHEN export_license_required = TRUE OR itar_controlled = TRUE THEN 1 ELSE 0 END)
      comment: "Number of orders requiring export controls or licenses"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`order_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Order line-level revenue, margin, and fulfillment metrics for detailed product mix and performance analysis"
  source: "`vibe_semiconductors_v1`.`order`.`order_line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Current status of the order line item"
    - name: "item_category"
      expr: item_category
      comment: "Category of the line item (e.g., finished goods, die bank, wafer)"
    - name: "allocation_type"
      expr: allocation_type
      comment: "Type of inventory allocation for this line"
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country where the product was manufactured"
    - name: "ship_to_country"
      expr: ship_to_country
      comment: "Destination country for shipment"
    - name: "export_control_classification"
      expr: export_control_classification
      comment: "Export control classification number (ECCN)"
    - name: "temperature_grade"
      expr: temperature_grade
      comment: "Temperature grade specification of the product"
    - name: "speed_grade"
      expr: speed_grade
      comment: "Speed grade specification of the product"
    - name: "die_bank_order"
      expr: die_bank_order
      comment: "Indicates whether this is a die bank order"
    - name: "mpw_order"
      expr: mpw_order
      comment: "Indicates whether this is a multi-project wafer order"
    - name: "wafer_start_authorization"
      expr: wafer_start_authorization
      comment: "Indicates whether wafer start has been authorized"
    - name: "order_year"
      expr: YEAR(date_entered)
      comment: "Year the order line was entered"
    - name: "order_month"
      expr: DATE_TRUNC('MONTH', date_entered)
      comment: "Month the order line was entered"
  measures:
    - name: "total_line_count"
      expr: COUNT(1)
      comment: "Total number of order line items"
    - name: "unique_orders"
      expr: COUNT(DISTINCT order_id)
      comment: "Number of unique orders represented"
    - name: "unique_customers"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique customer accounts"
    - name: "unique_products"
      expr: COUNT(DISTINCT ic_catalog_id)
      comment: "Number of unique IC products ordered"
    - name: "total_ordered_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total quantity ordered across all line items"
    - name: "total_confirmed_quantity"
      expr: SUM(CAST(confirmed_quantity AS DOUBLE))
      comment: "Total quantity confirmed for delivery"
    - name: "total_shipped_quantity"
      expr: SUM(CAST(shipped_quantity AS DOUBLE))
      comment: "Total quantity shipped to customers"
    - name: "total_extended_amount"
      expr: SUM(CAST(extended_amount AS DOUBLE))
      comment: "Total extended line amount in local currency"
    - name: "total_extended_price_usd"
      expr: SUM(CAST(extended_price_usd AS DOUBLE))
      comment: "Total extended line amount in USD for global reporting"
    - name: "total_net_value"
      expr: SUM(CAST(net_value AS DOUBLE))
      comment: "Total net value after discounts"
    - name: "avg_unit_price_usd"
      expr: AVG(CAST(unit_price_usd AS DOUBLE))
      comment: "Average unit price in USD across line items"
    - name: "avg_discount_percent"
      expr: AVG(CAST(discount_percent AS DOUBLE))
      comment: "Average discount percentage applied to line items"
    - name: "die_bank_line_count"
      expr: SUM(CASE WHEN die_bank_order = TRUE THEN 1 ELSE 0 END)
      comment: "Number of die bank order lines"
    - name: "mpw_line_count"
      expr: SUM(CASE WHEN mpw_order = TRUE THEN 1 ELSE 0 END)
      comment: "Number of multi-project wafer order lines"
    - name: "wafer_start_authorized_line_count"
      expr: SUM(CASE WHEN wafer_start_authorization = TRUE THEN 1 ELSE 0 END)
      comment: "Number of lines with wafer start authorization"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`order_backlog_position`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Backlog health and aging metrics for demand planning and capacity allocation decisions"
  source: "`vibe_semiconductors_v1`.`order`.`backlog_position`"
  dimensions:
    - name: "backlog_status"
      expr: backlog_status
      comment: "Current status of the backlog position"
    - name: "allocation_status"
      expr: allocation_status
      comment: "Allocation status for the backlog item"
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
    - name: "priority_rank"
      expr: priority_rank
      comment: "Priority ranking for allocation"
    - name: "design_win_flag"
      expr: design_win_flag
      comment: "Indicates whether backlog is associated with a design win"
    - name: "export_control_flag"
      expr: export_control_flag
      comment: "Indicates whether export controls apply"
    - name: "snapshot_month"
      expr: DATE_TRUNC('MONTH', snapshot_date)
      comment: "Month of the backlog snapshot"
    - name: "order_entry_month"
      expr: DATE_TRUNC('MONTH', order_entry_date)
      comment: "Month the order was entered"
    - name: "promised_month"
      expr: DATE_TRUNC('MONTH', promised_date)
      comment: "Month promised for delivery"
  measures:
    - name: "total_backlog_positions"
      expr: COUNT(1)
      comment: "Total number of backlog positions"
    - name: "unique_orders_in_backlog"
      expr: COUNT(DISTINCT order_id)
      comment: "Number of unique orders in backlog"
    - name: "unique_customers_in_backlog"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique customers with backlog"
    - name: "total_backlog_quantity"
      expr: SUM(CAST(backlog_quantity AS DOUBLE))
      comment: "Total quantity in backlog"
    - name: "total_allocated_quantity"
      expr: SUM(CAST(allocated_quantity AS DOUBLE))
      comment: "Total quantity allocated from backlog"
    - name: "total_committed_quantity"
      expr: SUM(CAST(committed_quantity AS DOUBLE))
      comment: "Total quantity committed for delivery"
    - name: "total_cancelled_quantity"
      expr: SUM(CAST(cancelled_quantity AS DOUBLE))
      comment: "Total quantity cancelled from backlog"
    - name: "total_shipped_quantity"
      expr: SUM(CAST(shipped_quantity AS DOUBLE))
      comment: "Total quantity shipped from backlog"
    - name: "total_backlog_value"
      expr: SUM(CAST(backlog_value AS DOUBLE))
      comment: "Total value of backlog in local currency"
    - name: "total_backlog_value_usd"
      expr: SUM(CAST(backlog_value_usd AS DOUBLE))
      comment: "Total value of backlog in USD"
    - name: "avg_net_selling_price"
      expr: AVG(CAST(net_selling_price AS DOUBLE))
      comment: "Average net selling price per unit in backlog"
    - name: "design_win_backlog_count"
      expr: SUM(CASE WHEN design_win_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of backlog positions associated with design wins"
    - name: "export_controlled_backlog_count"
      expr: SUM(CASE WHEN export_control_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of backlog positions requiring export controls"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`order_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shipment execution and logistics performance metrics for on-time delivery and freight cost optimization"
  source: "`vibe_semiconductors_v1`.`order`.`shipment`"
  dimensions:
    - name: "shipment_status"
      expr: shipment_status
      comment: "Current status of the shipment"
    - name: "service_level"
      expr: service_level
      comment: "Shipping service level (e.g., standard, expedited, overnight)"
    - name: "destination_country_code"
      expr: destination_country_code
      comment: "ISO country code for shipment destination"
    - name: "incoterms_code"
      expr: incoterms_code
      comment: "International commercial terms governing shipment"
    - name: "export_control_classification"
      expr: export_control_classification
      comment: "Export control classification for the shipment"
    - name: "is_multi_leg"
      expr: is_multi_leg
      comment: "Indicates whether shipment involves multiple legs"
    - name: "damaged_goods_flag"
      expr: damaged_goods_flag
      comment: "Indicates whether damaged goods were reported"
    - name: "quantity_shortage_flag"
      expr: quantity_shortage_flag
      comment: "Indicates whether quantity shortage was reported"
    - name: "wrong_part_flag"
      expr: wrong_part_flag
      comment: "Indicates whether wrong part was shipped"
    - name: "reach_compliant"
      expr: reach_compliant
      comment: "Indicates REACH compliance status"
    - name: "ship_month"
      expr: DATE_TRUNC('MONTH', ship_date)
      comment: "Month the shipment was dispatched"
    - name: "delivery_month"
      expr: DATE_TRUNC('MONTH', delivery_date)
      comment: "Month the shipment was delivered"
  measures:
    - name: "total_shipment_count"
      expr: COUNT(1)
      comment: "Total number of shipments"
    - name: "unique_customers_shipped"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique customers receiving shipments"
    - name: "total_shipped_quantity"
      expr: SUM(CAST(shipped_quantity AS DOUBLE))
      comment: "Total quantity shipped across all shipments"
    - name: "total_pod_confirmed_quantity"
      expr: SUM(CAST(pod_confirmed_quantity AS DOUBLE))
      comment: "Total quantity confirmed via proof of delivery"
    - name: "total_freight_cost_usd"
      expr: SUM(CAST(freight_cost_usd AS DOUBLE))
      comment: "Total freight cost in USD"
    - name: "total_declared_value_usd"
      expr: SUM(CAST(declared_value_usd AS DOUBLE))
      comment: "Total declared value of shipments in USD"
    - name: "total_gross_weight_kg"
      expr: SUM(CAST(gross_weight_kg AS DOUBLE))
      comment: "Total gross weight of shipments in kilograms"
    - name: "total_weight_kg"
      expr: SUM(CAST(total_weight_kg AS DOUBLE))
      comment: "Total weight of shipments in kilograms"
    - name: "avg_freight_cost_per_shipment"
      expr: AVG(CAST(freight_cost_usd AS DOUBLE))
      comment: "Average freight cost per shipment in USD"
    - name: "damaged_goods_shipment_count"
      expr: SUM(CASE WHEN damaged_goods_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of shipments with damaged goods reported"
    - name: "quantity_shortage_shipment_count"
      expr: SUM(CASE WHEN quantity_shortage_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of shipments with quantity shortages"
    - name: "wrong_part_shipment_count"
      expr: SUM(CASE WHEN wrong_part_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of shipments with wrong parts"
    - name: "multi_leg_shipment_count"
      expr: SUM(CASE WHEN is_multi_leg = TRUE THEN 1 ELSE 0 END)
      comment: "Number of multi-leg shipments"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`order_rma`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Return merchandise authorization metrics for quality feedback, warranty cost, and customer satisfaction analysis"
  source: "`vibe_semiconductors_v1`.`order`.`rma`"
  dimensions:
    - name: "rma_status"
      expr: rma_status
      comment: "Current status of the RMA"
    - name: "disposition"
      expr: disposition
      comment: "Final disposition decision for returned goods"
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for the return"
    - name: "return_reason_code"
      expr: return_reason_code
      comment: "Detailed return reason code"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category identified during analysis"
    - name: "warranty_claim_flag"
      expr: warranty_claim_flag
      comment: "Indicates whether RMA is a warranty claim"
    - name: "failure_analysis_requested"
      expr: failure_analysis_requested
      comment: "Indicates whether failure analysis was requested"
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Indicates whether corrective action is required"
    - name: "dppm_impact_flag"
      expr: dppm_impact_flag
      comment: "Indicates whether RMA impacts defects per million metric"
    - name: "export_control_flag"
      expr: export_control_flag
      comment: "Indicates whether export controls apply to returned goods"
    - name: "rma_month"
      expr: DATE_TRUNC('MONTH', rma_date)
      comment: "Month the RMA was issued"
    - name: "request_month"
      expr: DATE_TRUNC('MONTH', request_date)
      comment: "Month the RMA was requested"
    - name: "received_month"
      expr: DATE_TRUNC('MONTH', received_date)
      comment: "Month the returned goods were received"
  measures:
    - name: "total_rma_count"
      expr: COUNT(1)
      comment: "Total number of RMAs issued"
    - name: "unique_customers_with_rma"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique customers with RMAs"
    - name: "unique_products_returned"
      expr: COUNT(DISTINCT ic_catalog_id)
      comment: "Number of unique IC products returned"
    - name: "total_credit_amount"
      expr: SUM(CAST(credit_amount AS DOUBLE))
      comment: "Total credit amount issued for returns"
    - name: "avg_credit_amount_per_rma"
      expr: AVG(CAST(credit_amount AS DOUBLE))
      comment: "Average credit amount per RMA"
    - name: "warranty_claim_count"
      expr: SUM(CASE WHEN warranty_claim_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of RMAs that are warranty claims"
    - name: "failure_analysis_requested_count"
      expr: SUM(CASE WHEN failure_analysis_requested = TRUE THEN 1 ELSE 0 END)
      comment: "Number of RMAs with failure analysis requested"
    - name: "corrective_action_required_count"
      expr: SUM(CASE WHEN corrective_action_required = TRUE THEN 1 ELSE 0 END)
      comment: "Number of RMAs requiring corrective action"
    - name: "dppm_impact_rma_count"
      expr: SUM(CASE WHEN dppm_impact_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of RMAs impacting defects per million metric"
    - name: "closed_rma_count"
      expr: SUM(CASE WHEN rma_status = 'closed' THEN 1 ELSE 0 END)
      comment: "Number of closed RMAs"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`order_hold`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Order hold and release metrics for risk management, compliance monitoring, and revenue recognition timing"
  source: "`vibe_semiconductors_v1`.`order`.`order_hold`"
  dimensions:
    - name: "hold_status"
      expr: hold_status
      comment: "Current status of the hold"
    - name: "hold_type"
      expr: hold_type
      comment: "Type of hold applied (e.g., credit, quality, export, engineering)"
    - name: "hold_code"
      expr: hold_code
      comment: "Specific hold code"
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for the hold"
    - name: "owner_department"
      expr: owner_department
      comment: "Department responsible for resolving the hold"
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Indicates whether hold has been escalated"
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Indicates whether hold resolution SLA was breached"
    - name: "chips_act_review_required"
      expr: chips_act_review_required
      comment: "Indicates whether CHIPS Act review is required"
    - name: "itar_controlled"
      expr: itar_controlled
      comment: "Indicates whether hold is related to ITAR controls"
    - name: "die_bank_impacted"
      expr: die_bank_impacted
      comment: "Indicates whether die bank inventory is impacted"
    - name: "wafer_start_impacted"
      expr: wafer_start_impacted
      comment: "Indicates whether wafer starts are impacted"
    - name: "hold_month"
      expr: DATE_TRUNC('MONTH', hold_date)
      comment: "Month the hold was placed"
    - name: "release_month"
      expr: DATE_TRUNC('MONTH', release_date)
      comment: "Month the hold was released"
  measures:
    - name: "total_hold_count"
      expr: COUNT(1)
      comment: "Total number of order holds"
    - name: "unique_customers_with_holds"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique customers with order holds"
    - name: "total_order_value_at_risk"
      expr: SUM(CAST(order_value_at_risk AS DOUBLE))
      comment: "Total order value at risk due to holds"
    - name: "total_credit_exposure_amount"
      expr: SUM(CAST(credit_exposure_amount AS DOUBLE))
      comment: "Total credit exposure amount for credit holds"
    - name: "total_credit_limit_amount"
      expr: SUM(CAST(credit_limit_amount AS DOUBLE))
      comment: "Total credit limit amount across credit holds"
    - name: "avg_order_value_at_risk"
      expr: AVG(CAST(order_value_at_risk AS DOUBLE))
      comment: "Average order value at risk per hold"
    - name: "escalated_hold_count"
      expr: SUM(CASE WHEN escalation_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of holds that have been escalated"
    - name: "sla_breach_hold_count"
      expr: SUM(CASE WHEN sla_breach_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of holds with SLA breaches"
    - name: "chips_act_review_hold_count"
      expr: SUM(CASE WHEN chips_act_review_required = TRUE THEN 1 ELSE 0 END)
      comment: "Number of holds requiring CHIPS Act review"
    - name: "itar_controlled_hold_count"
      expr: SUM(CASE WHEN itar_controlled = TRUE THEN 1 ELSE 0 END)
      comment: "Number of holds related to ITAR controls"
    - name: "wafer_start_impacted_hold_count"
      expr: SUM(CASE WHEN wafer_start_impacted = TRUE THEN 1 ELSE 0 END)
      comment: "Number of holds impacting wafer starts"
    - name: "released_hold_count"
      expr: SUM(CASE WHEN hold_status = 'released' THEN 1 ELSE 0 END)
      comment: "Number of holds that have been released"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`order_allocation_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory allocation and fulfillment metrics for supply-demand matching and allocation policy effectiveness"
  source: "`vibe_semiconductors_v1`.`order`.`allocation_record`"
  dimensions:
    - name: "allocation_status"
      expr: allocation_status
      comment: "Current status of the allocation"
    - name: "allocation_type"
      expr: allocation_type
      comment: "Type of allocation (e.g., firm, soft, reserved)"
    - name: "allocation_source"
      expr: allocation_source
      comment: "Source of inventory for allocation"
    - name: "allocation_priority"
      expr: allocation_priority
      comment: "Priority level for allocation"
    - name: "priority_rank"
      expr: priority_rank
      comment: "Numeric priority rank"
    - name: "assignment_status"
      expr: assignment_status
      comment: "Status of inventory assignment"
    - name: "backlog_flag"
      expr: backlog_flag
      comment: "Indicates whether allocation is for backlog"
    - name: "constrained_supply_flag"
      expr: constrained_supply_flag
      comment: "Indicates whether supply is constrained"
    - name: "end_market_segment"
      expr: end_market_segment
      comment: "Target end market segment"
    - name: "lot_type"
      expr: lot_type
      comment: "Type of lot allocated"
    - name: "fab_site_code"
      expr: fab_site_code
      comment: "Fabrication site code"
    - name: "osat_site_code"
      expr: osat_site_code
      comment: "OSAT (assembly/test) site code"
    - name: "quality_disposition"
      expr: quality_disposition
      comment: "Quality disposition status"
    - name: "chips_act_eligible"
      expr: chips_act_eligible
      comment: "Indicates CHIPS Act eligibility"
    - name: "itar_controlled"
      expr: itar_controlled
      comment: "Indicates ITAR control status"
    - name: "allocation_month"
      expr: DATE_TRUNC('MONTH', allocation_date)
      comment: "Month the allocation was made"
    - name: "scheduled_ship_month"
      expr: DATE_TRUNC('MONTH', scheduled_ship_date)
      comment: "Month scheduled for shipment"
  measures:
    - name: "total_allocation_count"
      expr: COUNT(1)
      comment: "Total number of allocation records"
    - name: "unique_customers_allocated"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique customers with allocations"
    - name: "unique_products_allocated"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of unique SKUs allocated"
    - name: "total_allocated_quantity"
      expr: SUM(CAST(allocated_quantity AS DOUBLE))
      comment: "Total quantity allocated"
    - name: "total_confirmed_quantity"
      expr: SUM(CAST(confirmed_quantity AS DOUBLE))
      comment: "Total quantity confirmed for allocation"
    - name: "total_shipped_quantity"
      expr: SUM(CAST(shipped_quantity AS DOUBLE))
      comment: "Total quantity shipped from allocations"
    - name: "avg_allocated_quantity"
      expr: AVG(CAST(allocated_quantity AS DOUBLE))
      comment: "Average quantity per allocation"
    - name: "backlog_allocation_count"
      expr: SUM(CASE WHEN backlog_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of allocations for backlog orders"
    - name: "constrained_supply_allocation_count"
      expr: SUM(CASE WHEN constrained_supply_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of allocations from constrained supply"
    - name: "chips_act_eligible_allocation_count"
      expr: SUM(CASE WHEN chips_act_eligible = TRUE THEN 1 ELSE 0 END)
      comment: "Number of CHIPS Act eligible allocations"
    - name: "itar_controlled_allocation_count"
      expr: SUM(CASE WHEN itar_controlled = TRUE THEN 1 ELSE 0 END)
      comment: "Number of ITAR-controlled allocations"
$$;