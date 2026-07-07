-- Metric views for domain: order | Business: Semiconductors | Version: 2 | Generated on: 2026-06-28 00:14:33

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`order_allocation_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory allocation metrics for semiconductor order fulfillment, tracking allocation efficiency, supply constraints, and fulfillment coverage."
  source: "`vibe_semiconductors_v1`.`order`.`allocation_record`"
  dimensions:
    - name: "allocation_status"
      expr: allocation_status
      comment: "Current allocation status (allocated, confirmed, shipped) for supply coverage analysis."
    - name: "allocation_type"
      expr: allocation_type
      comment: "Type of allocation (standard, priority, CHIPS Act) for allocation mix analysis."
    - name: "allocation_source"
      expr: allocation_source
      comment: "Source of allocation (wafer lot, die bank, finished goods) for supply chain traceability."
    - name: "end_market_segment"
      expr: end_market_segment
      comment: "End-market segment for allocation prioritization analysis."
    - name: "process_node"
      expr: process_node
      comment: "Semiconductor process node for technology-level allocation analysis."
    - name: "allocation_date_month"
      expr: DATE_TRUNC('month', allocation_date)
      comment: "Month of allocation for trend analysis of supply commitment patterns."
    - name: "constrained_supply_flag"
      expr: constrained_supply_flag
      comment: "Indicates allocation under supply constraint; critical for supply risk reporting."
    - name: "chips_act_eligible"
      expr: chips_act_eligible
      comment: "CHIPS Act eligibility flag for government program allocation tracking."
    - name: "itar_controlled"
      expr: itar_controlled
      comment: "ITAR-controlled flag for export compliance segmentation of allocations."
    - name: "lot_type"
      expr: lot_type
      comment: "Lot type classification for supply source analysis."
    - name: "priority_rank"
      expr: priority_rank
      comment: "Priority rank of allocation for fulfillment sequencing analysis."
  measures:
    - name: "total_allocations"
      expr: COUNT(1)
      comment: "Total number of allocation records; baseline allocation activity volume."
    - name: "total_allocated_quantity"
      expr: SUM(CAST(allocated_quantity AS DOUBLE))
      comment: "Total quantity allocated to orders; primary supply commitment measure for operations."
    - name: "total_confirmed_quantity"
      expr: SUM(CAST(confirmed_quantity AS DOUBLE))
      comment: "Total quantity confirmed for shipment; firm supply commitment measure."
    - name: "total_shipped_quantity"
      expr: SUM(CAST(shipped_quantity AS DOUBLE))
      comment: "Total quantity shipped from allocations; fulfillment execution measure."
    - name: "confirmation_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(confirmed_quantity AS DOUBLE)) / NULLIF(SUM(CAST(allocated_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of allocated quantity confirmed; allocation reliability KPI for supply planning."
    - name: "shipment_fulfillment_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(shipped_quantity AS DOUBLE)) / NULLIF(SUM(CAST(allocated_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of allocated quantity actually shipped; end-to-end allocation execution KPI."
    - name: "constrained_supply_allocation_count"
      expr: COUNT(CASE WHEN constrained_supply_flag = TRUE THEN 1 END)
      comment: "Count of allocations under supply constraint; supply risk exposure indicator for executive review."
    - name: "backlog_allocation_count"
      expr: COUNT(CASE WHEN backlog_flag = TRUE THEN 1 END)
      comment: "Count of allocations contributing to open backlog; demand pipeline coverage measure."
    - name: "chips_act_allocated_quantity"
      expr: SUM(CASE WHEN chips_act_eligible = TRUE THEN CAST(allocated_quantity AS DOUBLE) ELSE 0 END)
      comment: "Total quantity allocated to CHIPS Act eligible orders; government program fulfillment tracking."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`order_amendment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Order amendment metrics tracking change frequency, revenue impact, and amendment type patterns for semiconductor order management governance."
  source: "`vibe_semiconductors_v1`.`order`.`amendment`"
  dimensions:
    - name: "amendment_status"
      expr: amendment_status
      comment: "Current amendment status (pending, approved, rejected) for change management tracking."
    - name: "amendment_type"
      expr: amendment_type
      comment: "Type of amendment (quantity, price, date, cancellation) for change pattern analysis."
    - name: "approval_level"
      expr: approval_level
      comment: "Approval level required for amendment; governance and escalation analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for multi-currency revenue impact reporting."
    - name: "chips_act_order_flag"
      expr: chips_act_order_flag
      comment: "CHIPS Act order flag for government program amendment tracking."
    - name: "customer_requested_flag"
      expr: customer_requested_flag
      comment: "Indicates customer-initiated amendment for demand volatility analysis."
    - name: "export_control_review_required"
      expr: export_control_review_required
      comment: "Export control review required flag for compliance workload analysis."
    - name: "amendment_date_month"
      expr: DATE_TRUNC('month', amendment_date)
      comment: "Month of amendment for change frequency trend analysis."
    - name: "wafer_start_impact_flag"
      expr: wafer_start_impact_flag
      comment: "Indicates amendment impacts wafer starts; fab capacity disruption indicator."
    - name: "allocation_impact_flag"
      expr: allocation_impact_flag
      comment: "Indicates amendment impacts allocations; supply chain disruption indicator."
  measures:
    - name: "total_amendments"
      expr: COUNT(1)
      comment: "Total order amendments; baseline change activity volume for order management governance."
    - name: "total_revenue_impact_amount"
      expr: SUM(CAST(revenue_impact_amount AS DOUBLE))
      comment: "Total revenue impact from amendments; financial consequence of order changes for executive reporting."
    - name: "total_quantity_revised"
      expr: SUM(CAST(quantity_revised AS DOUBLE))
      comment: "Total revised quantity across amendments; demand change volume measure for supply planning."
    - name: "total_quantity_original"
      expr: SUM(CAST(quantity_original AS DOUBLE))
      comment: "Total original quantity before amendments; baseline demand measure for change analysis."
    - name: "avg_unit_price_revised"
      expr: AVG(CAST(unit_price_revised AS DOUBLE))
      comment: "Average revised unit price across amendments; pricing change trend for margin management."
    - name: "customer_requested_amendment_count"
      expr: COUNT(CASE WHEN customer_requested_flag = TRUE THEN 1 END)
      comment: "Count of customer-initiated amendments; demand volatility indicator for sales and supply planning."
    - name: "wafer_start_impacting_amendment_count"
      expr: COUNT(CASE WHEN wafer_start_impact_flag = TRUE THEN 1 END)
      comment: "Count of amendments impacting wafer starts; fab capacity disruption measure for manufacturing planning."
    - name: "export_control_review_amendment_count"
      expr: COUNT(CASE WHEN export_control_review_required = TRUE THEN 1 END)
      comment: "Count of amendments requiring export control review; compliance workload measure."
    - name: "quantity_change_pct"
      expr: ROUND(100.0 * (SUM(CAST(quantity_revised AS DOUBLE)) - SUM(CAST(quantity_original AS DOUBLE))) / NULLIF(SUM(CAST(quantity_original AS DOUBLE)), 0), 2)
      comment: "Percentage change in quantity from amendments; demand volatility KPI for supply chain planning."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`order_backlog_position`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Backlog management metrics tracking order pipeline, aging, and allocation status"
  source: "`vibe_semiconductors_v1`.`order`.`backlog_position`"
  dimensions:
    - name: "backlog_status"
      expr: backlog_status
      comment: "Current status of the backlog position"
    - name: "allocation_status"
      expr: allocation_status
      comment: "Allocation status of the backlog item"
    - name: "end_market_segment"
      expr: end_market_segment
      comment: "Target end-market segment"
    - name: "order_type"
      expr: order_type
      comment: "Type of order in backlog"
    - name: "sales_region"
      expr: sales_region
      comment: "Sales region for the backlog item"
    - name: "ship_to_country_code"
      expr: ship_to_country_code
      comment: "Destination country"
    - name: "snapshot_year"
      expr: YEAR(snapshot_date)
      comment: "Year of the backlog snapshot"
    - name: "snapshot_month"
      expr: DATE_TRUNC('MONTH', snapshot_date)
      comment: "Month of the backlog snapshot"
    - name: "design_win_flag"
      expr: design_win_flag
      comment: "Whether this backlog item is associated with a design win"
    - name: "export_control_flag"
      expr: export_control_flag
      comment: "Whether export controls apply to this backlog item"
    - name: "revenue_recognition_flag"
      expr: revenue_recognition_flag
      comment: "Whether revenue has been recognized for this backlog item"
  measures:
    - name: "total_backlog_count"
      expr: COUNT(DISTINCT backlog_position_id)
      comment: "Total number of backlog positions"
    - name: "total_backlog_quantity"
      expr: SUM(CAST(backlog_quantity AS DOUBLE))
      comment: "Total quantity in backlog"
    - name: "total_backlog_value_usd"
      expr: SUM(CAST(backlog_value_usd AS DOUBLE))
      comment: "Total value of backlog in USD"
    - name: "total_allocated_quantity"
      expr: SUM(CAST(allocated_quantity AS DOUBLE))
      comment: "Total quantity allocated from backlog"
    - name: "total_shipped_quantity"
      expr: SUM(CAST(shipped_quantity AS DOUBLE))
      comment: "Total quantity shipped from backlog"
    - name: "total_cancelled_quantity"
      expr: SUM(CAST(cancelled_quantity AS DOUBLE))
      comment: "Total quantity cancelled from backlog"
    - name: "total_committed_quantity"
      expr: SUM(CAST(committed_quantity AS DOUBLE))
      comment: "Total quantity committed in backlog"
    - name: "avg_backlog_value_usd"
      expr: AVG(CAST(backlog_value_usd AS DOUBLE))
      comment: "Average backlog value per position in USD"
    - name: "avg_net_selling_price"
      expr: AVG(CAST(net_selling_price AS DOUBLE))
      comment: "Average net selling price across backlog items"
    - name: "backlog_allocation_rate"
      expr: ROUND(100.0 * SUM(CAST(allocated_quantity AS DOUBLE)) / NULLIF(SUM(CAST(backlog_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of backlog quantity that has been allocated"
    - name: "backlog_fulfillment_rate"
      expr: ROUND(100.0 * SUM(CAST(shipped_quantity AS DOUBLE)) / NULLIF(SUM(CAST(backlog_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of backlog quantity that has been shipped"
    - name: "backlog_cancellation_rate"
      expr: ROUND(100.0 * SUM(CAST(cancelled_quantity AS DOUBLE)) / NULLIF(SUM(CAST(backlog_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of backlog quantity that has been cancelled"
    - name: "design_win_backlog_count"
      expr: COUNT(DISTINCT CASE WHEN design_win_flag = TRUE THEN backlog_position_id END)
      comment: "Number of backlog positions associated with design wins"
    - name: "design_win_backlog_value_usd"
      expr: SUM(CASE WHEN design_win_flag = TRUE THEN CAST(backlog_value_usd AS DOUBLE) ELSE 0 END)
      comment: "Total backlog value from design wins in USD"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`order_delivery_confirmation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Delivery confirmation metrics tracking proof-of-delivery performance, discrepancy rates, and invoice release readiness for semiconductor order fulfillment."
  source: "`vibe_semiconductors_v1`.`order`.`delivery_confirmation`"
  dimensions:
    - name: "confirmation_status"
      expr: confirmation_status
      comment: "Current confirmation status (pending, confirmed, disputed) for delivery closure tracking."
    - name: "delivery_status"
      expr: delivery_status
      comment: "Delivery status for fulfillment performance segmentation."
    - name: "customer_acceptance_status"
      expr: customer_acceptance_status
      comment: "Customer acceptance status for revenue recognition readiness analysis."
    - name: "delivery_performance_code"
      expr: delivery_performance_code
      comment: "Delivery performance code (on-time, early, late) for OTIF analysis."
    - name: "discrepancy_type"
      expr: discrepancy_type
      comment: "Type of delivery discrepancy for root cause analysis."
    - name: "incoterms_code"
      expr: incoterms_code
      comment: "Delivery terms for revenue recognition timing analysis."
    - name: "receiving_country_code"
      expr: receiving_country_code
      comment: "Receiving country for geographic delivery performance analysis."
    - name: "delivery_date_month"
      expr: DATE_TRUNC('month', delivery_date)
      comment: "Month of delivery for trend analysis of fulfillment throughput."
    - name: "invoice_release_flag"
      expr: invoice_release_flag
      comment: "Invoice release flag for revenue recognition pipeline tracking."
    - name: "revenue_recognition_flag"
      expr: revenue_recognition_flag
      comment: "Revenue recognition flag for finance reporting."
  measures:
    - name: "total_confirmations"
      expr: COUNT(1)
      comment: "Total delivery confirmations; baseline delivery closure activity volume."
    - name: "total_confirmed_quantity"
      expr: SUM(CAST(confirmed_quantity AS DOUBLE))
      comment: "Total quantity confirmed received by customers; actual delivery completion measure."
    - name: "total_delivered_quantity"
      expr: SUM(CAST(delivered_quantity AS DOUBLE))
      comment: "Total quantity delivered per confirmation records; fulfillment execution measure."
    - name: "total_shipped_quantity"
      expr: SUM(CAST(shipped_quantity AS DOUBLE))
      comment: "Total quantity shipped per confirmation records; shipment volume measure."
    - name: "total_quantity_variance"
      expr: SUM(CAST(quantity_variance AS DOUBLE))
      comment: "Total quantity variance between shipped and confirmed; fulfillment accuracy measure."
    - name: "discrepancy_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN discrepancy_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deliveries with discrepancies; fulfillment accuracy KPI for operations management."
    - name: "invoice_release_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN invoice_release_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of confirmed deliveries with invoice released; revenue recognition pipeline efficiency KPI."
    - name: "discrepancy_count"
      expr: COUNT(CASE WHEN discrepancy_flag = TRUE THEN 1 END)
      comment: "Count of deliveries with discrepancies; operational quality indicator for logistics management."
    - name: "export_control_verified_count"
      expr: COUNT(CASE WHEN export_control_verified_flag = TRUE THEN 1 END)
      comment: "Count of deliveries with export control verification completed; compliance closure measure."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`order_delivery_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Delivery schedule adherence and fulfillment performance metrics for semiconductor order management, tracking on-time delivery and schedule reliability."
  source: "`vibe_semiconductors_v1`.`order`.`delivery_schedule`"
  dimensions:
    - name: "schedule_line_status"
      expr: schedule_line_status
      comment: "Current schedule line status for delivery pipeline tracking."
    - name: "schedule_status"
      expr: schedule_status
      comment: "Overall schedule status for delivery performance segmentation."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for multi-currency delivery value reporting."
    - name: "incoterms_code"
      expr: incoterms_code
      comment: "Delivery terms for revenue recognition timing analysis."
    - name: "export_control_status"
      expr: export_control_status
      comment: "Export control status for compliance-sensitive delivery tracking."
    - name: "scheduled_ship_date_month"
      expr: DATE_TRUNC('month', scheduled_ship_date)
      comment: "Month of scheduled ship date for delivery timeline analysis."
    - name: "requested_delivery_date_month"
      expr: DATE_TRUNC('month', requested_delivery_date)
      comment: "Month of customer requested delivery date for demand timing analysis."
    - name: "mpw_order_flag"
      expr: mpw_order_flag
      comment: "MPW order flag for shuttle program delivery tracking."
    - name: "backlog_flag"
      expr: backlog_flag
      comment: "Backlog flag for open demand delivery analysis."
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country of origin for trade compliance and tariff analysis."
  measures:
    - name: "total_schedule_lines"
      expr: COUNT(1)
      comment: "Total delivery schedule lines; baseline fulfillment planning volume."
    - name: "total_ordered_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total ordered quantity on schedule lines; demand volume measure for capacity planning."
    - name: "total_scheduled_quantity"
      expr: SUM(CAST(scheduled_quantity AS DOUBLE))
      comment: "Total quantity scheduled for delivery; supply commitment measure."
    - name: "total_confirmed_quantity"
      expr: SUM(CAST(confirmed_quantity AS DOUBLE))
      comment: "Total confirmed delivery quantity; firm supply commitment measure."
    - name: "total_delivered_quantity"
      expr: SUM(CAST(delivered_quantity AS DOUBLE))
      comment: "Total quantity delivered; actual fulfillment execution measure."
    - name: "total_net_value"
      expr: SUM(CAST(net_value AS DOUBLE))
      comment: "Total net value of scheduled deliveries; revenue pipeline measure."
    - name: "schedule_adherence_pct"
      expr: ROUND(100.0 * SUM(CAST(delivered_quantity AS DOUBLE)) / NULLIF(SUM(CAST(scheduled_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of scheduled quantity actually delivered; on-time delivery adherence KPI for operations."
    - name: "confirmed_coverage_pct"
      expr: ROUND(100.0 * SUM(CAST(confirmed_quantity AS DOUBLE)) / NULLIF(SUM(CAST(ordered_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of ordered quantity confirmed for delivery; supply commitment coverage KPI."
    - name: "on_time_delivery_count"
      expr: COUNT(CASE WHEN actual_delivery_date <= scheduled_delivery_date THEN 1 END)
      comment: "Count of schedule lines delivered on or before scheduled date; on-time delivery performance measure."
    - name: "late_delivery_count"
      expr: COUNT(CASE WHEN actual_delivery_date > scheduled_delivery_date THEN 1 END)
      comment: "Count of schedule lines delivered after scheduled date; delivery reliability risk indicator."
    - name: "on_time_delivery_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN actual_delivery_date <= scheduled_delivery_date THEN 1 END) / NULLIF(COUNT(CASE WHEN actual_delivery_date IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of deliveries made on or before scheduled date; primary OTIF (on-time in-full) KPI for customer satisfaction."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`order_lot_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lot assignment metrics tracking supply traceability, yield performance, and quality disposition for semiconductor order fulfillment."
  source: "`vibe_semiconductors_v1`.`order`.`lot_assignment`"
  dimensions:
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current assignment status for lot-to-order traceability tracking."
    - name: "assignment_type"
      expr: assignment_type
      comment: "Type of lot assignment (wafer, die, packaged) for supply source analysis."
    - name: "assignment_source"
      expr: assignment_source
      comment: "Source of lot assignment for supply chain traceability."
    - name: "process_node"
      expr: process_node
      comment: "Process node for assigned lot for technology-level analysis."
    - name: "quality_disposition"
      expr: quality_disposition
      comment: "Quality disposition of assigned lot for quality-driven fulfillment analysis."
    - name: "lot_type"
      expr: lot_type
      comment: "Lot type classification for supply source analysis."
    - name: "kgd_grade"
      expr: kgd_grade
      comment: "Known good die grade for KGD program quality tracking."
    - name: "chips_act_eligible"
      expr: chips_act_eligible
      comment: "CHIPS Act eligibility for government program lot tracking."
    - name: "itar_controlled"
      expr: itar_controlled
      comment: "ITAR-controlled flag for export compliance segmentation."
    - name: "assignment_date_month"
      expr: DATE_TRUNC('month', assignment_date)
      comment: "Month of lot assignment for supply commitment trend analysis."
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country of origin for trade compliance analysis."
  measures:
    - name: "total_lot_assignments"
      expr: COUNT(1)
      comment: "Total lot assignments; baseline supply traceability activity volume."
    - name: "total_assigned_quantity"
      expr: SUM(CAST(assigned_quantity AS DOUBLE))
      comment: "Total quantity assigned from lots to orders; supply commitment measure."
    - name: "total_dppm"
      expr: SUM(CAST(dppm AS DOUBLE))
      comment: "Total defects per million parts across assigned lots; quality risk exposure measure."
    - name: "avg_dppm"
      expr: AVG(CAST(dppm AS DOUBLE))
      comment: "Average DPPM across assigned lots; quality performance KPI for customer satisfaction management."
    - name: "avg_yield_percent"
      expr: AVG(CAST(yield_percent AS DOUBLE))
      comment: "Average yield percentage across assigned lots; production quality measure for cost and revenue analysis."
    - name: "kgd_assignment_count"
      expr: COUNT(CASE WHEN kgd_grade IS NOT NULL THEN 1 END)
      comment: "Count of KGD (known good die) lot assignments; premium product fulfillment measure."
    - name: "export_controlled_assignment_count"
      expr: COUNT(CASE WHEN export_license_required = TRUE THEN 1 END)
      comment: "Count of lot assignments requiring export licenses; compliance workload measure."
    - name: "chips_act_assigned_quantity"
      expr: SUM(CASE WHEN chips_act_eligible = TRUE THEN CAST(assigned_quantity AS DOUBLE) ELSE 0 END)
      comment: "Total quantity assigned to CHIPS Act eligible orders; government program fulfillment tracking."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core order performance metrics tracking order value, volume, and fulfillment efficiency across channels and customer segments"
  source: "`vibe_semiconductors_v1`.`order`.`order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the order (e.g., open, confirmed, shipped, cancelled)"
    - name: "order_type"
      expr: order_type
      comment: "Type of order (e.g., standard, blanket, NRE, MPW)"
    - name: "distribution_channel"
      expr: distribution_channel
      comment: "Sales channel through which the order was placed"
    - name: "end_market_segment"
      expr: end_market_segment
      comment: "Target end-market segment for the order"
    - name: "ship_to_country_code"
      expr: ship_to_country_code
      comment: "Destination country for shipment"
    - name: "order_year"
      expr: YEAR(order_date)
      comment: "Year the order was placed"
    - name: "order_month"
      expr: DATE_TRUNC('MONTH', order_date)
      comment: "Month the order was placed"
    - name: "order_quarter"
      expr: DATE_TRUNC('QUARTER', order_date)
      comment: "Quarter the order was placed"
    - name: "chips_act_eligible"
      expr: chips_act_eligible
      comment: "Whether the order qualifies for CHIPS Act incentives"
    - name: "itar_controlled"
      expr: itar_controlled
      comment: "Whether the order is subject to ITAR export controls"
    - name: "backlog_flag"
      expr: backlog_flag
      comment: "Whether the order is currently in backlog"
    - name: "priority"
      expr: priority
      comment: "Order priority level"
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
      comment: "Total non-recurring engineering charges across orders"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount collected on orders"
    - name: "avg_gross_order_value"
      expr: AVG(CAST(gross_order_value AS DOUBLE))
      comment: "Average gross order value per order"
    - name: "avg_net_order_value"
      expr: AVG(CAST(net_order_value AS DOUBLE))
      comment: "Average net order value per order"
    - name: "order_fulfillment_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN actual_delivery_date IS NOT NULL THEN order_id END) / NULLIF(COUNT(DISTINCT order_id), 0), 2)
      comment: "Percentage of orders that have been delivered"
    - name: "on_time_delivery_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN actual_delivery_date <= requested_delivery_date THEN order_id END) / NULLIF(COUNT(DISTINCT CASE WHEN actual_delivery_date IS NOT NULL THEN order_id END), 0), 2)
      comment: "Percentage of delivered orders that met the requested delivery date"
    - name: "backlog_order_count"
      expr: COUNT(DISTINCT CASE WHEN backlog_flag = TRUE THEN order_id END)
      comment: "Number of orders currently in backlog"
    - name: "backlog_order_value"
      expr: SUM(CASE WHEN backlog_flag = TRUE THEN CAST(net_order_value AS DOUBLE) ELSE 0 END)
      comment: "Total net value of orders in backlog"
    - name: "chips_act_order_count"
      expr: COUNT(DISTINCT CASE WHEN chips_act_eligible = TRUE THEN order_id END)
      comment: "Number of orders eligible for CHIPS Act incentives"
    - name: "chips_act_order_value"
      expr: SUM(CASE WHEN chips_act_eligible = TRUE THEN CAST(net_order_value AS DOUBLE) ELSE 0 END)
      comment: "Total value of CHIPS Act eligible orders"
    - name: "itar_controlled_order_count"
      expr: COUNT(DISTINCT CASE WHEN itar_controlled = TRUE THEN order_id END)
      comment: "Number of orders subject to ITAR export controls"
    - name: "export_license_required_order_count"
      expr: COUNT(DISTINCT CASE WHEN export_license_required = TRUE THEN order_id END)
      comment: "Number of orders requiring export licenses"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`order_blanket_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Blanket order metrics tracking long-term supply agreements, commitment utilization, and contract performance"
  source: "`vibe_semiconductors_v1`.`order`.`order`"
  dimensions:
    - name: "distribution_channel"
      expr: distribution_channel
      comment: "Distribution channel for the blanket order"
    - name: "end_market_segment"
      expr: end_market_segment
      comment: "Target end-market segment"
    - name: "ship_to_country_code"
      expr: ship_to_country_code
      comment: "Destination country"
    - name: "chips_act_eligible"
      expr: chips_act_eligible
      comment: "Whether the blanket order is eligible for CHIPS Act incentives"
    - name: "export_license_required"
      expr: export_license_required
      comment: "Whether export license is required"
  measures:
    - name: "total_blanket_order_count"
      expr: COUNT(DISTINCT blanket_order_id)
      comment: "Total number of blanket orders"
    - name: "chips_act_blanket_count"
      expr: COUNT(DISTINCT CASE WHEN chips_act_eligible = TRUE THEN blanket_order_id END)
      comment: "Number of CHIPS Act eligible blanket orders"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`order_die_bank_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Die bank order metrics tracking die inventory fulfillment, KGD program performance, and packaging order execution for semiconductor advanced packaging."
  source: "`vibe_semiconductors_v1`.`order`.`order`"
  dimensions:
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for multi-currency revenue reporting."
  measures:
    - name: "total_die_bank_orders"
      expr: COUNT(1)
      comment: "Total die bank orders; baseline die inventory demand volume."
    - name: "export_license_required_count"
      expr: COUNT(CASE WHEN export_license_required = TRUE THEN 1 END)
      comment: "Count of die bank orders requiring export licenses; compliance workload measure."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`order_mpw_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Multi-project wafer (MPW) order metrics tracking shuttle program revenue, die delivery performance, and reticle utilization for semiconductor design services."
  source: "`vibe_semiconductors_v1`.`order`.`order`"
  dimensions:
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for multi-currency MPW revenue reporting."
    - name: "order_date_month"
      expr: DATE_TRUNC('month', order_date)
      comment: "Month of MPW order for revenue booking trend analysis."
    - name: "rohs_compliant"
      expr: rohs_compliant
      comment: "RoHS compliance flag for environmental compliance reporting."
  measures:
    - name: "total_mpw_orders"
      expr: COUNT(1)
      comment: "Total MPW orders; baseline shuttle program volume measure."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`order_nre_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "NRE (non-recurring engineering) order metrics tracking design services revenue, milestone completion, and contract performance for semiconductor R&D engagements."
  source: "`vibe_semiconductors_v1`.`order`.`order`"
  dimensions:
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for multi-currency NRE revenue reporting."
    - name: "chips_act_eligible"
      expr: chips_act_eligible
      comment: "CHIPS Act eligibility for government incentive program tracking."
    - name: "itar_controlled"
      expr: itar_controlled
      comment: "ITAR-controlled flag for export compliance segmentation."
    - name: "order_date_month"
      expr: DATE_TRUNC('month', order_date)
      comment: "Month of NRE order for revenue booking trend analysis."
  measures:
    - name: "total_nre_orders"
      expr: COUNT(1)
      comment: "Total NRE orders; baseline design services engagement volume."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`order_hold`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Order hold metrics tracking revenue at risk, hold resolution performance, and compliance-driven hold patterns for semiconductor order management."
  source: "`vibe_semiconductors_v1`.`order`.`order_hold`"
  dimensions:
    - name: "hold_status"
      expr: hold_status
      comment: "Current hold status (active, released, escalated) for hold pipeline management."
    - name: "hold_type"
      expr: hold_type
      comment: "Type of hold (credit, compliance, quality, export) for root cause categorization."
    - name: "hold_reason_code"
      expr: hold_reason_code
      comment: "Specific hold reason code for operational root cause analysis."
    - name: "export_control_classification"
      expr: export_control_classification
      comment: "Export control classification for compliance hold segmentation."
    - name: "itar_controlled"
      expr: itar_controlled
      comment: "ITAR-controlled flag for export compliance hold tracking."
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Indicates hold has been escalated; urgency indicator for management attention."
    - name: "chips_act_review_required"
      expr: chips_act_review_required
      comment: "CHIPS Act review required flag for government compliance hold tracking."
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "SLA breach flag for hold resolution performance management."
    - name: "hold_date_month"
      expr: DATE_TRUNC('month', CAST(hold_date AS DATE))
      comment: "Month hold was placed for trend analysis of hold frequency."
  measures:
    - name: "total_holds"
      expr: COUNT(1)
      comment: "Total order holds placed; baseline hold activity volume for operations management."
    - name: "total_order_value_at_risk"
      expr: SUM(CAST(order_value_at_risk AS DOUBLE))
      comment: "Total order value at risk from holds; primary revenue risk KPI for executive escalation."
    - name: "total_credit_exposure_amount"
      expr: SUM(CAST(credit_exposure_amount AS DOUBLE))
      comment: "Total credit exposure amount from holds; financial risk measure for credit management."
    - name: "avg_order_value_at_risk"
      expr: AVG(CAST(order_value_at_risk AS DOUBLE))
      comment: "Average order value at risk per hold; hold severity indicator for prioritization."
    - name: "active_hold_count"
      expr: COUNT(CASE WHEN hold_status = 'Active' THEN 1 END)
      comment: "Count of currently active holds; real-time revenue blockage measure for operations."
    - name: "escalated_hold_count"
      expr: COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END)
      comment: "Count of escalated holds; management attention required indicator for order operations."
    - name: "sla_breached_hold_count"
      expr: COUNT(CASE WHEN sla_breach_flag = TRUE THEN 1 END)
      comment: "Count of holds that breached SLA; service level compliance KPI for operations leadership."
    - name: "export_control_hold_value_at_risk"
      expr: SUM(CASE WHEN hold_type = 'Export Control' THEN CAST(order_value_at_risk AS DOUBLE) ELSE 0 END)
      comment: "Order value at risk from export control holds; compliance risk financial exposure measure."
    - name: "sla_breach_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sla_breach_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of holds that breached SLA; hold resolution efficiency KPI for operations management."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`order_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Order line-level metrics tracking product mix, pricing, and fulfillment performance at the SKU level"
  source: "`vibe_semiconductors_v1`.`order`.`order_line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Current status of the order line"
    - name: "item_category"
      expr: item_category
      comment: "Category of the line item"
    - name: "ship_to_country"
      expr: ship_to_country
      comment: "Destination country for the line item"
    - name: "temperature_grade"
      expr: temperature_grade
      comment: "Temperature grade specification of the product"
    - name: "speed_grade"
      expr: speed_grade
      comment: "Speed grade specification of the product"
    - name: "rohs_compliant"
      expr: rohs_compliant
      comment: "Whether the product is RoHS compliant"
    - name: "reach_compliant"
      expr: reach_compliant
      comment: "Whether the product is REACH compliant"
    - name: "mpw_order_flag"
      expr: mpw_order
      comment: "Whether this is a multi-project wafer order"
    - name: "die_bank_order_flag"
      expr: die_bank_order
      comment: "Whether this is a die bank order"
    - name: "partial_shipment_allowed"
      expr: partial_shipment_allowed
      comment: "Whether partial shipments are allowed for this line"
  measures:
    - name: "total_line_count"
      expr: COUNT(DISTINCT order_line_id)
      comment: "Total number of unique order lines"
    - name: "total_ordered_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total quantity ordered across all lines"
    - name: "total_shipped_quantity"
      expr: SUM(CAST(shipped_quantity AS DOUBLE))
      comment: "Total quantity shipped across all lines"
    - name: "total_confirmed_quantity"
      expr: SUM(CAST(confirmed_quantity AS DOUBLE))
      comment: "Total quantity confirmed for shipment"
    - name: "total_extended_amount"
      expr: SUM(CAST(extended_amount AS DOUBLE))
      comment: "Total extended amount (quantity × unit price) across all lines"
    - name: "total_net_value"
      expr: SUM(CAST(net_value AS DOUBLE))
      comment: "Total net value after discounts across all lines"
    - name: "avg_unit_price_usd"
      expr: AVG(CAST(unit_price_usd AS DOUBLE))
      comment: "Average unit price in USD across order lines"
    - name: "avg_discount_percent"
      expr: AVG(CAST(discount_percent AS DOUBLE))
      comment: "Average discount percentage applied to order lines"
    - name: "line_fill_rate"
      expr: ROUND(100.0 * SUM(CAST(shipped_quantity AS DOUBLE)) / NULLIF(SUM(CAST(ordered_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of ordered quantity that has been shipped"
    - name: "on_time_ship_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN actual_ship_date <= requested_ship_date THEN order_line_id END) / NULLIF(COUNT(DISTINCT CASE WHEN actual_ship_date IS NOT NULL THEN order_line_id END), 0), 2)
      comment: "Percentage of shipped lines that met the requested ship date"
    - name: "rohs_compliant_line_count"
      expr: COUNT(DISTINCT CASE WHEN rohs_compliant = TRUE THEN order_line_id END)
      comment: "Number of order lines with RoHS compliant products"
    - name: "reach_compliant_line_count"
      expr: COUNT(DISTINCT CASE WHEN reach_compliant = TRUE THEN order_line_id END)
      comment: "Number of order lines with REACH compliant products"
    - name: "mpw_line_count"
      expr: COUNT(DISTINCT CASE WHEN mpw_order = TRUE THEN order_line_id END)
      comment: "Number of multi-project wafer order lines"
    - name: "die_bank_line_count"
      expr: COUNT(DISTINCT CASE WHEN die_bank_order = TRUE THEN order_line_id END)
      comment: "Number of die bank order lines"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`order_nre_milestone`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "NRE milestone execution metrics tracking delivery performance, billing progress, and revenue recognition for semiconductor design services contracts."
  source: "`vibe_semiconductors_v1`.`order`.`order_nre_milestone`"
  dimensions:
    - name: "milestone_status"
      expr: milestone_status
      comment: "Current milestone status (pending, in-progress, completed, rejected) for project tracking."
    - name: "milestone_type"
      expr: milestone_type
      comment: "Type of milestone (design, tape-out, characterization, delivery) for project phase analysis."
    - name: "billing_status"
      expr: billing_status
      comment: "Billing status of milestone for revenue recognition and invoicing pipeline."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level of milestone for project risk management reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for multi-currency milestone revenue reporting."
    - name: "planned_completion_date_month"
      expr: DATE_TRUNC('month', planned_completion_date)
      comment: "Month of planned completion for delivery schedule analysis."
    - name: "actual_completion_date_month"
      expr: DATE_TRUNC('month', actual_completion_date)
      comment: "Month of actual completion for delivery performance trend analysis."
    - name: "billing_trigger_flag"
      expr: billing_trigger_flag
      comment: "Indicates milestone triggers a billing event; revenue recognition pipeline indicator."
    - name: "rework_required_flag"
      expr: rework_required_flag
      comment: "Indicates rework was required; quality and efficiency indicator for NRE delivery."
  measures:
    - name: "total_milestones"
      expr: COUNT(1)
      comment: "Total NRE milestones; baseline project delivery activity volume."
    - name: "total_milestone_amount_usd"
      expr: SUM(CAST(milestone_amount_usd AS DOUBLE))
      comment: "Total milestone value in USD; NRE revenue pipeline measure for finance reporting."
    - name: "total_revenue_recognition_amount"
      expr: SUM(CAST(revenue_recognition_amount AS DOUBLE))
      comment: "Total revenue recognized from milestones; primary NRE revenue recognition KPI."
    - name: "total_effort_hours_planned"
      expr: SUM(CAST(effort_hours_planned AS DOUBLE))
      comment: "Total planned effort hours across milestones; resource capacity planning measure."
    - name: "total_effort_hours_actual"
      expr: SUM(CAST(effort_hours_actual AS DOUBLE))
      comment: "Total actual effort hours consumed; resource utilization and cost tracking measure."
    - name: "effort_efficiency_pct"
      expr: ROUND(100.0 * SUM(CAST(effort_hours_planned AS DOUBLE)) / NULLIF(SUM(CAST(effort_hours_actual AS DOUBLE)), 0), 2)
      comment: "Planned vs actual effort ratio; NRE project efficiency KPI for resource management."
    - name: "completed_milestone_count"
      expr: COUNT(CASE WHEN milestone_status = 'Completed' THEN 1 END)
      comment: "Count of completed milestones; project delivery progress measure."
    - name: "overdue_milestone_count"
      expr: COUNT(CASE WHEN milestone_status != 'Completed' AND planned_completion_date < CURRENT_DATE() THEN 1 END)
      comment: "Count of milestones past planned completion date; project delivery risk KPI for program management."
    - name: "rework_milestone_count"
      expr: COUNT(CASE WHEN rework_required_flag = TRUE THEN 1 END)
      comment: "Count of milestones requiring rework; NRE quality and efficiency indicator."
    - name: "billing_ready_milestone_value_usd"
      expr: SUM(CASE WHEN billing_trigger_flag = TRUE AND milestone_status = 'Completed' THEN CAST(milestone_amount_usd AS DOUBLE) ELSE 0 END)
      comment: "Total value of completed billing-trigger milestones ready for invoicing; accounts receivable pipeline measure."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`order_rma`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Return merchandise authorization metrics tracking product returns, failure analysis, and quality impact"
  source: "`vibe_semiconductors_v1`.`order`.`rma`"
  dimensions:
    - name: "rma_status"
      expr: rma_status
      comment: "Current status of the RMA"
    - name: "disposition"
      expr: disposition
      comment: "Disposition decision for the returned material"
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for the return"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category identified for the return"
    - name: "rma_year"
      expr: YEAR(rma_date)
      comment: "Year the RMA was created"
    - name: "rma_month"
      expr: DATE_TRUNC('MONTH', rma_date)
      comment: "Month the RMA was created"
    - name: "rma_quarter"
      expr: DATE_TRUNC('QUARTER', rma_date)
      comment: "Quarter the RMA was created"
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
      comment: "Whether this RMA impacts DPPM metrics"
  measures:
    - name: "total_rma_count"
      expr: COUNT(DISTINCT rma_id)
      comment: "Total number of RMAs"
    - name: "total_credit_amount"
      expr: SUM(CAST(credit_amount AS DOUBLE))
      comment: "Total credit amount issued for RMAs"
    - name: "avg_credit_amount"
      expr: AVG(CAST(credit_amount AS DOUBLE))
      comment: "Average credit amount per RMA"
    - name: "warranty_claim_count"
      expr: COUNT(DISTINCT CASE WHEN warranty_claim_flag = TRUE THEN rma_id END)
      comment: "Number of RMAs that are warranty claims"
    - name: "warranty_claim_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN warranty_claim_flag = TRUE THEN rma_id END) / NULLIF(COUNT(DISTINCT rma_id), 0), 2)
      comment: "Percentage of RMAs that are warranty claims"
    - name: "failure_analysis_request_count"
      expr: COUNT(DISTINCT CASE WHEN failure_analysis_requested = TRUE THEN rma_id END)
      comment: "Number of RMAs with failure analysis requested"
    - name: "failure_analysis_request_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN failure_analysis_requested = TRUE THEN rma_id END) / NULLIF(COUNT(DISTINCT rma_id), 0), 2)
      comment: "Percentage of RMAs requiring failure analysis"
    - name: "corrective_action_required_count"
      expr: COUNT(DISTINCT CASE WHEN corrective_action_required = TRUE THEN rma_id END)
      comment: "Number of RMAs requiring corrective action"
    - name: "dppm_impact_rma_count"
      expr: COUNT(DISTINCT CASE WHEN dppm_impact_flag = TRUE THEN rma_id END)
      comment: "Number of RMAs impacting DPPM quality metrics"
    - name: "avg_rma_cycle_time_days"
      expr: AVG(DATEDIFF(closed_date, request_date))
      comment: "Average number of days from RMA request to closure"
    - name: "avg_approval_time_days"
      expr: AVG(DATEDIFF(approved_date, request_date))
      comment: "Average number of days from RMA request to approval"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`order_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shipment performance metrics tracking delivery efficiency, freight costs, and quality issues"
  source: "`vibe_semiconductors_v1`.`order`.`shipment`"
  dimensions:
    - name: "shipment_status"
      expr: shipment_status
      comment: "Current status of the shipment"
    - name: "destination_country_code"
      expr: destination_country_code
      comment: "Destination country for the shipment"
    - name: "incoterms_code"
      expr: incoterms_code
      comment: "International commercial terms governing the shipment"
    - name: "service_level"
      expr: service_level
      comment: "Shipping service level (e.g., standard, expedited, overnight)"
    - name: "ship_year"
      expr: YEAR(ship_date)
      comment: "Year the shipment was dispatched"
    - name: "ship_month"
      expr: DATE_TRUNC('MONTH', ship_date)
      comment: "Month the shipment was dispatched"
    - name: "ship_quarter"
      expr: DATE_TRUNC('QUARTER', ship_date)
      comment: "Quarter the shipment was dispatched"
    - name: "rohs_compliant"
      expr: rohs_compliant
      comment: "Whether the shipment is RoHS compliant"
    - name: "reach_compliant"
      expr: reach_compliant
      comment: "Whether the shipment is REACH compliant"
    - name: "damaged_goods_flag"
      expr: damaged_goods_flag
      comment: "Whether damaged goods were reported in this shipment"
    - name: "quantity_shortage_flag"
      expr: quantity_shortage_flag
      comment: "Whether a quantity shortage was reported"
    - name: "wrong_part_flag"
      expr: wrong_part_flag
      comment: "Whether wrong parts were shipped"
  measures:
    - name: "total_shipment_count"
      expr: COUNT(DISTINCT shipment_id)
      comment: "Total number of unique shipments"
    - name: "total_shipped_quantity"
      expr: SUM(CAST(shipped_quantity AS DOUBLE))
      comment: "Total quantity shipped across all shipments"
    - name: "total_freight_cost_usd"
      expr: SUM(CAST(freight_cost_usd AS DOUBLE))
      comment: "Total freight cost in USD across all shipments"
    - name: "total_declared_value_usd"
      expr: SUM(CAST(declared_value_usd AS DOUBLE))
      comment: "Total declared value of shipments in USD"
    - name: "total_gross_weight_kg"
      expr: SUM(CAST(gross_weight_kg AS DOUBLE))
      comment: "Total gross weight of shipments in kilograms"
    - name: "total_weight_kg"
      expr: SUM(CAST(total_weight_kg AS DOUBLE))
      comment: "Total weight of shipments in kilograms"
    - name: "avg_freight_cost_usd"
      expr: AVG(CAST(freight_cost_usd AS DOUBLE))
      comment: "Average freight cost per shipment in USD"
    - name: "avg_shipment_weight_kg"
      expr: AVG(CAST(total_weight_kg AS DOUBLE))
      comment: "Average weight per shipment in kilograms"
    - name: "on_time_delivery_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN actual_arrival_date <= estimated_arrival_date THEN shipment_id END) / NULLIF(COUNT(DISTINCT CASE WHEN actual_arrival_date IS NOT NULL THEN shipment_id END), 0), 2)
      comment: "Percentage of shipments delivered on or before estimated arrival date"
    - name: "damaged_shipment_count"
      expr: COUNT(DISTINCT CASE WHEN damaged_goods_flag = TRUE THEN shipment_id END)
      comment: "Number of shipments with damaged goods reported"
    - name: "damaged_shipment_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN damaged_goods_flag = TRUE THEN shipment_id END) / NULLIF(COUNT(DISTINCT shipment_id), 0), 2)
      comment: "Percentage of shipments with damaged goods"
    - name: "shortage_shipment_count"
      expr: COUNT(DISTINCT CASE WHEN quantity_shortage_flag = TRUE THEN shipment_id END)
      comment: "Number of shipments with quantity shortages"
    - name: "shortage_shipment_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN quantity_shortage_flag = TRUE THEN shipment_id END) / NULLIF(COUNT(DISTINCT shipment_id), 0), 2)
      comment: "Percentage of shipments with quantity shortages"
    - name: "wrong_part_shipment_count"
      expr: COUNT(DISTINCT CASE WHEN wrong_part_flag = TRUE THEN shipment_id END)
      comment: "Number of shipments with wrong parts"
    - name: "perfect_shipment_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN damaged_goods_flag = FALSE AND quantity_shortage_flag = FALSE AND wrong_part_flag = FALSE AND actual_arrival_date <= estimated_arrival_date THEN shipment_id END) / NULLIF(COUNT(DISTINCT CASE WHEN actual_arrival_date IS NOT NULL THEN shipment_id END), 0), 2)
      comment: "Percentage of shipments with no quality issues and on-time delivery"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`order_shipment_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shipment line-level metrics for detailed fulfillment analysis, revenue recognition, and product compliance tracking in semiconductor order management."
  source: "`vibe_semiconductors_v1`.`order`.`shipment_line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Current shipment line status for fulfillment tracking."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for multi-currency revenue reporting."
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country of origin for trade compliance and tariff analysis."
    - name: "package_type"
      expr: package_type
      comment: "Package type for product format analysis."
    - name: "temperature_grade"
      expr: temperature_grade
      comment: "Device temperature grade for product mix analysis."
    - name: "eccn_code"
      expr: eccn_code
      comment: "ECCN code for export control compliance segmentation."
    - name: "itar_controlled"
      expr: itar_controlled
      comment: "ITAR-controlled flag for export compliance segmentation."
    - name: "actual_ship_date_month"
      expr: DATE_TRUNC('month', actual_ship_date)
      comment: "Month of actual shipment for fulfillment throughput trend analysis."
    - name: "partial_shipment_flag"
      expr: partial_shipment_flag
      comment: "Partial shipment flag for fulfillment completeness analysis."
    - name: "backorder_flag"
      expr: backorder_flag
      comment: "Backorder flag for unfulfilled demand tracking."
    - name: "yield_grade"
      expr: yield_grade
      comment: "Yield grade of shipped product for quality mix analysis."
  measures:
    - name: "total_shipment_lines"
      expr: COUNT(1)
      comment: "Total shipment lines; baseline fulfillment line activity volume."
    - name: "total_shipped_quantity"
      expr: SUM(CAST(shipped_quantity AS DOUBLE))
      comment: "Total units shipped at line level; primary fulfillment volume measure."
    - name: "total_ordered_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total ordered quantity at line level; demand baseline for fill rate calculation."
    - name: "total_line_net_value"
      expr: SUM(CAST(line_net_value AS DOUBLE))
      comment: "Total net value of shipment lines; revenue shipped measure for financial reporting."
    - name: "avg_unit_selling_price"
      expr: AVG(CAST(unit_selling_price AS DOUBLE))
      comment: "Average unit selling price across shipment lines; ASP trend for margin management."
    - name: "line_fill_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(shipped_quantity AS DOUBLE)) / NULLIF(SUM(CAST(ordered_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of ordered quantity shipped at line level; line-level fulfillment accuracy KPI."
    - name: "partial_shipment_line_count"
      expr: COUNT(CASE WHEN partial_shipment_flag = TRUE THEN 1 END)
      comment: "Count of partial shipment lines; fulfillment completeness indicator for customer satisfaction."
    - name: "backorder_line_count"
      expr: COUNT(CASE WHEN backorder_flag = TRUE THEN 1 END)
      comment: "Count of backordered shipment lines; unfulfilled demand measure for supply planning."
    - name: "export_controlled_line_count"
      expr: COUNT(CASE WHEN itar_controlled = TRUE THEN 1 END)
      comment: "Count of ITAR-controlled shipment lines; export compliance workload measure."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`order_wafer_start_authorization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Wafer start authorization metrics tracking fab capacity utilization, yield targets, and production efficiency"
  source: "`vibe_semiconductors_v1`.`order`.`wafer_start_authorization`"
  dimensions:
    - name: "authorization_status"
      expr: authorization_status
      comment: "Current status of the wafer start authorization"
    - name: "process_node"
      expr: process_node
      comment: "Process technology node for the wafer start"
    - name: "priority_class"
      expr: priority_class
      comment: "Priority classification of the wafer start"
    - name: "authorization_year"
      expr: YEAR(authorization_date)
      comment: "Year the wafer start was authorized"
    - name: "authorization_month"
      expr: DATE_TRUNC('MONTH', authorization_date)
      comment: "Month the wafer start was authorized"
    - name: "authorization_quarter"
      expr: DATE_TRUNC('QUARTER', authorization_date)
      comment: "Quarter the wafer start was authorized"
    - name: "is_mpw"
      expr: is_mpw
      comment: "Whether this is a multi-project wafer start"
    - name: "is_nre"
      expr: is_nre
      comment: "Whether this is a non-recurring engineering wafer start"
    - name: "chips_act_eligible"
      expr: chips_act_eligible
      comment: "Whether this wafer start is eligible for CHIPS Act incentives"
    - name: "risk_acceptance_flag"
      expr: risk_acceptance_flag
      comment: "Whether risk has been accepted for this wafer start"
  measures:
    - name: "total_wsa_count"
      expr: COUNT(DISTINCT wafer_start_authorization_id)
      comment: "Total number of wafer start authorizations"
    - name: "total_nre_charge_usd"
      expr: SUM(CAST(nre_charge_usd AS DOUBLE))
      comment: "Total NRE charges for wafer starts in USD"
    - name: "total_wafer_unit_cost_usd"
      expr: SUM(CAST(wafer_unit_cost_usd AS DOUBLE))
      comment: "Total wafer unit cost in USD"
    - name: "avg_nre_charge_usd"
      expr: AVG(CAST(nre_charge_usd AS DOUBLE))
      comment: "Average NRE charge per wafer start in USD"
    - name: "avg_wafer_unit_cost_usd"
      expr: AVG(CAST(wafer_unit_cost_usd AS DOUBLE))
      comment: "Average wafer unit cost in USD"
    - name: "avg_yield_target_pct"
      expr: AVG(CAST(yield_target_pct AS DOUBLE))
      comment: "Average yield target percentage across wafer starts"
    - name: "mpw_wsa_count"
      expr: COUNT(DISTINCT CASE WHEN is_mpw = TRUE THEN wafer_start_authorization_id END)
      comment: "Number of multi-project wafer start authorizations"
    - name: "nre_wsa_count"
      expr: COUNT(DISTINCT CASE WHEN is_nre = TRUE THEN wafer_start_authorization_id END)
      comment: "Number of NRE wafer start authorizations"
    - name: "chips_act_wsa_count"
      expr: COUNT(DISTINCT CASE WHEN chips_act_eligible = TRUE THEN wafer_start_authorization_id END)
      comment: "Number of CHIPS Act eligible wafer start authorizations"
    - name: "risk_accepted_wsa_count"
      expr: COUNT(DISTINCT CASE WHEN risk_acceptance_flag = TRUE THEN wafer_start_authorization_id END)
      comment: "Number of wafer starts with accepted risk"
    - name: "avg_cycle_time_target_days"
      expr: AVG(DATEDIFF(planned_completion_date, planned_start_date))
      comment: "Average planned cycle time from start to completion in days"
    - name: "avg_actual_cycle_time_days"
      expr: AVG(DATEDIFF(actual_start_date, planned_start_date))
      comment: "Average actual time from planned to actual start in days"
$$;
