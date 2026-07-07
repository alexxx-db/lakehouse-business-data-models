-- Metric views for domain: inventory | Business: Consumer Goods | Version: 2 | Generated on: 2026-06-28 00:14:33

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`inventory_intransit_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "In-transit inventory pipeline metrics tracking shipment volumes, freight costs, on-time performance, and exception rates. Supports supply chain visibility and logistics cost management decisions."
  source: "`vibe_consumer_goods_v1`.`inventory`.`intransit_shipment`"
  dimensions:
    - name: "carrier_id"
      expr: carrier_id
      comment: "Carrier identifier for carrier performance benchmarking."
    - name: "sku_id"
      expr: sku_id
      comment: "SKU identifier for product-level pipeline analysis."
    - name: "from_warehouse_id"
      expr: from_warehouse_id
      comment: "Origin warehouse for lane-level shipment analysis."
    - name: "to_warehouse_id"
      expr: to_warehouse_id
      comment: "Destination warehouse for lane-level shipment analysis."
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport (road, rail, air, sea) for modal cost and performance analysis."
    - name: "carrier_service_level"
      expr: carrier_service_level
      comment: "Carrier service level (express, standard, economy) for service-cost trade-off analysis."
    - name: "intransit_shipment_status"
      expr: intransit_shipment_status
      comment: "Current shipment status for pipeline visibility and exception management."
    - name: "exception_flag"
      expr: exception_flag
      comment: "Flag indicating a shipment exception for exception rate monitoring."
    - name: "on_time_flag"
      expr: on_time_flag
      comment: "Flag indicating on-time arrival for carrier on-time delivery performance."
    - name: "otif_flag"
      expr: otif_flag
      comment: "On-time in-full flag for OTIF performance measurement — a key retail customer KPI."
    - name: "temperature_controlled_flag"
      expr: temperature_controlled_flag
      comment: "Flag for temperature-controlled shipments requiring cold chain compliance monitoring."
    - name: "hazmat_flag"
      expr: hazmat_flag
      comment: "Hazardous materials flag for regulatory compliance and risk management."
    - name: "ship_date"
      expr: ship_date
      comment: "Shipment date for time-series transit pipeline analysis."
  measures:
    - name: "total_intransit_shipments"
      expr: COUNT(1)
      comment: "Total number of in-transit shipments. Measures pipeline volume and logistics activity."
    - name: "total_intransit_quantity"
      expr: SUM(CAST(in_transit_quantity AS DOUBLE))
      comment: "Total quantity currently in transit. Measures pipeline inventory available for near-term replenishment."
    - name: "total_transit_value"
      expr: SUM(CAST(transit_value AS DOUBLE))
      comment: "Total financial value of in-transit inventory. Working capital exposure in the logistics pipeline."
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost_amount AS DOUBLE))
      comment: "Total freight cost across all in-transit shipments. Primary logistics cost KPI for transportation budget management."
    - name: "avg_freight_cost_per_shipment"
      expr: AVG(CAST(freight_cost_amount AS DOUBLE))
      comment: "Average freight cost per shipment. Benchmarks carrier and lane cost efficiency."
    - name: "on_time_delivery_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN on_time_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of shipments arriving on time. Critical carrier performance KPI and customer service level indicator."
    - name: "otif_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN otif_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "On-time in-full rate. The primary retail customer compliance KPI — failure triggers financial penalties from major retailers."
    - name: "exception_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN exception_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of shipments with exceptions. Measures logistics reliability and supply chain disruption frequency."
    - name: "total_shipment_weight_kg"
      expr: SUM(CAST(shipment_weight_kg AS DOUBLE))
      comment: "Total weight of in-transit shipments in kg. Used for freight cost per kg efficiency analysis."
    - name: "total_shipment_volume_m3"
      expr: SUM(CAST(shipment_volume_m3 AS DOUBLE))
      comment: "Total volume of in-transit shipments in cubic meters. Used for load factor and capacity utilization analysis."
    - name: "in_full_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN in_full_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of shipments delivered in full quantity. Measures order completeness and supply reliability."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`inventory_cycle_count`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory accuracy metrics derived from cycle count results. Tracks count variance rates, accuracy percentages, and recount frequencies to drive inventory accuracy improvement programs."
  source: "`vibe_consumer_goods_v1`.`inventory`.`inventory_cycle_count`"
  dimensions:
    - name: "warehouse_id"
      expr: warehouse_id
      comment: "Warehouse where cycle count was performed for facility-level accuracy benchmarking."
    - name: "manufacturing_facility_id"
      expr: manufacturing_facility_id
      comment: "Manufacturing facility for plant-level inventory accuracy analysis."
    - name: "sku_id"
      expr: sku_id
      comment: "SKU identifier for product-level accuracy analysis."
    - name: "count_type"
      expr: count_type
      comment: "Type of count (full, cycle, spot) for count methodology analysis."
    - name: "count_method"
      expr: count_method
      comment: "Counting method used (manual, RF scan, RFID) for process efficiency analysis."
    - name: "abc_classification"
      expr: abc_classification
      comment: "ABC classification of counted items to prioritize accuracy improvement on high-value SKUs."
    - name: "count_status"
      expr: count_status
      comment: "Current status of the cycle count (in progress, completed, approved) for workflow monitoring."
    - name: "recount_required_flag"
      expr: recount_required_flag
      comment: "Flag indicating a recount was required, used to measure first-count accuracy rates."
    - name: "adjustment_posted_flag"
      expr: adjustment_posted_flag
      comment: "Flag indicating whether a stock adjustment was posted as a result of this count."
    - name: "count_date"
      expr: count_date
      comment: "Date the count was performed for time-series accuracy trending."
  measures:
    - name: "total_cycle_counts"
      expr: COUNT(1)
      comment: "Total number of cycle count records. Measures counting program coverage and activity."
    - name: "total_variance_quantity"
      expr: SUM(CAST(variance_quantity AS DOUBLE))
      comment: "Total net quantity variance between system and physical count. Primary inventory accuracy KPI."
    - name: "total_variance_value"
      expr: SUM(CAST(variance_value AS DOUBLE))
      comment: "Total financial value of count variances. Quantifies the monetary impact of inventory inaccuracies."
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average variance percentage across cycle counts. Benchmark KPI for inventory accuracy program performance."
    - name: "recount_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN recount_required_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of counts requiring a recount. High rates indicate counting process quality issues or systemic accuracy problems."
    - name: "adjustment_posting_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN adjustment_posted_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cycle counts resulting in a stock adjustment posting. Measures the rate at which counts reveal real discrepancies."
    - name: "total_inventory_value_at_count"
      expr: SUM(CAST(inventory_value_at_count AS DOUBLE))
      comment: "Total inventory value at time of count. Provides financial context for variance analysis."
    - name: "avg_counted_quantity"
      expr: AVG(CAST(counted_quantity AS DOUBLE))
      comment: "Average physical count quantity per count record. Baseline for count volume benchmarking."
    - name: "zero_variance_count_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN variance_quantity = 0 THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cycle counts with zero variance (perfect accuracy). Primary inventory accuracy rate KPI for operational excellence programs."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`inventory_replenishment_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Replenishment order metrics tracking order volumes, fulfillment performance, and supply reliability. Supports procurement and supply planning decisions on replenishment efficiency and supplier performance."
  source: "`vibe_consumer_goods_v1`.`inventory`.`inventory_replenishment_order`"
  dimensions:
    - name: "sku_id"
      expr: sku_id
      comment: "SKU identifier for product-level replenishment analysis."
    - name: "warehouse_id"
      expr: warehouse_id
      comment: "Destination warehouse for facility-level replenishment performance analysis."
    - name: "supplier_id"
      expr: supplier_id
      comment: "Supplier for supplier replenishment performance benchmarking."
    - name: "order_type"
      expr: order_type
      comment: "Type of replenishment order (planned, emergency, VMI) for order category analysis."
    - name: "order_status"
      expr: order_status
      comment: "Current order status for pipeline and fulfillment monitoring."
    - name: "priority"
      expr: priority
      comment: "Order priority level for urgency-based replenishment management."
    - name: "cost_center_id"
      expr: cost_center_id
      comment: "Cost center for financial allocation of replenishment costs."
    - name: "order_date"
      expr: order_date
      comment: "Order placement date for time-series replenishment trend analysis."
  measures:
    - name: "total_replenishment_orders"
      expr: COUNT(1)
      comment: "Total number of replenishment orders. Measures replenishment activity volume and planning system utilization."
    - name: "total_order_quantity"
      expr: SUM(CAST(order_quantity AS DOUBLE))
      comment: "Total quantity ordered for replenishment. Measures inbound supply pipeline volume."
    - name: "total_requested_quantity"
      expr: SUM(CAST(requested_quantity AS DOUBLE))
      comment: "Total quantity requested for replenishment. Compared against order quantity to measure fulfillment completeness."
    - name: "total_replenishment_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total financial value of replenishment orders. Measures procurement spend on inventory replenishment."
    - name: "avg_replenishment_order_value"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average value per replenishment order. Benchmarks order sizing efficiency."
    - name: "total_target_stock_level"
      expr: SUM(CAST(target_stock_level AS DOUBLE))
      comment: "Total target stock level across replenishment orders. Measures the inventory investment target being pursued."
    - name: "total_reorder_point"
      expr: SUM(CAST(reorder_point AS DOUBLE))
      comment: "Total reorder point quantity across orders. Measures the aggregate trigger threshold for replenishment actions."
    - name: "distinct_supplier_count"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of distinct suppliers used for replenishment. Measures supply base breadth and concentration risk."
    - name: "distinct_sku_replenished_count"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs being replenished. Measures active replenishment coverage across the portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`inventory_vmi_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "VMI agreement metrics tracking vendor-managed inventory coverage, stock level compliance, and agreement performance. Supports supply chain collaboration and VMI program management decisions."
  source: "`vibe_consumer_goods_v1`.`inventory`.`inventory_vmi_agreement`"
  dimensions:
    - name: "sku_id"
      expr: sku_id
      comment: "SKU identifier for product-level VMI coverage analysis."
    - name: "warehouse_id"
      expr: warehouse_id
      comment: "Warehouse for facility-level VMI program analysis."
    - name: "trade_account_id"
      expr: trade_account_id
      comment: "Trade account for customer-level VMI agreement analysis."
    - name: "retail_store_id"
      expr: retail_store_id
      comment: "Retail store for store-level VMI performance analysis."
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of VMI agreement for program segmentation analysis."
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current agreement status (active, expired, suspended) for program health monitoring."
    - name: "replenishment_frequency"
      expr: replenishment_frequency
      comment: "Replenishment frequency under the VMI agreement for operational planning."
    - name: "ownership_transfer_point"
      expr: ownership_transfer_point
      comment: "Point at which inventory ownership transfers for financial and legal analysis."
  measures:
    - name: "total_vmi_agreements"
      expr: COUNT(1)
      comment: "Total number of VMI agreements. Measures VMI program scale and customer collaboration breadth."
    - name: "active_vmi_agreements"
      expr: COUNT(CASE WHEN agreement_status = 'ACTIVE' THEN 1 END)
      comment: "Number of currently active VMI agreements. Measures active VMI program coverage."
    - name: "total_target_stock_level"
      expr: SUM(CAST(target_stock_level AS DOUBLE))
      comment: "Total target stock level across VMI agreements. Measures the inventory investment committed under VMI programs."
    - name: "avg_min_inventory_level"
      expr: AVG(CAST(min_inventory_level AS DOUBLE))
      comment: "Average minimum inventory level across VMI agreements. Measures the floor commitment in VMI contracts."
    - name: "avg_max_inventory_level"
      expr: AVG(CAST(max_inventory_level AS DOUBLE))
      comment: "Average maximum inventory level across VMI agreements. Measures the ceiling cap in VMI contracts."
    - name: "distinct_trade_account_vmi_count"
      expr: COUNT(DISTINCT trade_account_id)
      comment: "Number of distinct trade accounts with VMI agreements. Measures VMI program customer penetration."
    - name: "distinct_sku_vmi_count"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs under VMI management. Measures VMI portfolio coverage."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`inventory_lot_batch`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lot and batch traceability metrics covering quality status, shelf life, recall exposure, and compliance rates. Supports quality management, regulatory compliance, and supply chain traceability decisions."
  source: "`vibe_consumer_goods_v1`.`inventory`.`lot_batch`"
  dimensions:
    - name: "sku_id"
      expr: sku_id
      comment: "SKU identifier for product-level batch quality analysis."
    - name: "manufacturing_facility_id"
      expr: manufacturing_facility_id
      comment: "Manufacturing facility for plant-level batch quality benchmarking."
    - name: "batch_status"
      expr: batch_status
      comment: "Current batch status (released, blocked, quarantine) for quality pipeline monitoring."
    - name: "quality_status"
      expr: quality_status
      comment: "Quality disposition status for compliance and release rate analysis."
    - name: "gmp_status"
      expr: gmp_status
      comment: "GMP compliance status for regulatory audit readiness."
    - name: "quarantine_status"
      expr: quarantine_status
      comment: "Quarantine status for blocked inventory management."
    - name: "hold_flag"
      expr: hold_flag
      comment: "Flag indicating batch is on hold for quality or regulatory reasons."
    - name: "is_recalled"
      expr: is_recalled
      comment: "Flag indicating batch is subject to a recall for recall exposure analysis."
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Flag indicating regulatory compliance status for compliance rate reporting."
    - name: "quality_grade"
      expr: quality_grade
      comment: "Quality grade assigned to the batch for grade distribution analysis."
    - name: "manufacture_date"
      expr: manufacture_date
      comment: "Manufacturing date for batch age and shelf life analysis."
    - name: "marketing_brand_id"
      expr: marketing_brand_id
      comment: "Brand associated with the batch for brand-level quality performance analysis."
  measures:
    - name: "total_batches"
      expr: COUNT(1)
      comment: "Total number of lot/batch records. Measures production volume and traceability coverage."
    - name: "total_quantity_produced"
      expr: SUM(CAST(quantity_produced AS DOUBLE))
      comment: "Total quantity produced across batches. Primary production output KPI for supply planning."
    - name: "recalled_batch_count"
      expr: COUNT(CASE WHEN is_recalled = TRUE THEN 1 END)
      comment: "Number of recalled batches. Critical quality and regulatory risk KPI with direct financial and brand impact."
    - name: "hold_batch_count"
      expr: COUNT(CASE WHEN hold_flag = TRUE THEN 1 END)
      comment: "Number of batches currently on hold. Measures quality pipeline blockage and potential supply disruption."
    - name: "regulatory_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN regulatory_compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of batches meeting regulatory compliance requirements. Key GMP and regulatory audit KPI."
    - name: "hold_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN hold_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of batches placed on hold. Measures quality release efficiency and supply risk."
    - name: "distinct_sku_batch_count"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs with active batch records. Measures traceability coverage across the product portfolio."
    - name: "distinct_facility_batch_count"
      expr: COUNT(DISTINCT manufacturing_facility_id)
      comment: "Number of distinct manufacturing facilities with batch activity. Measures production network utilization."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`inventory_oos_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Out-of-stock event metrics tracking frequency, duration, financial impact, and root causes of stockouts. Critical KPIs for supply chain reliability, customer service, and lost sales management."
  source: "`vibe_consumer_goods_v1`.`inventory`.`oos_event`"
  dimensions:
    - name: "sku_id"
      expr: sku_id
      comment: "SKU identifier for product-level OOS analysis."
    - name: "warehouse_id"
      expr: warehouse_id
      comment: "Warehouse where OOS event occurred for facility-level service level analysis."
    - name: "oos_type"
      expr: oos_type
      comment: "Type of OOS event (phantom, true, near-miss) for root cause categorization."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category of the OOS event to drive systemic corrective actions."
    - name: "root_cause_code"
      expr: root_cause_code
      comment: "Specific root cause code for detailed OOS analysis and supplier/logistics accountability."
    - name: "impact_severity"
      expr: impact_severity
      comment: "Severity of the OOS impact (critical, high, medium, low) for prioritization."
    - name: "channel_type"
      expr: channel_type
      comment: "Sales channel where OOS was detected for channel-specific service level management."
    - name: "product_category"
      expr: product_category
      comment: "Product category for category-level OOS analysis and portfolio management."
    - name: "event_status"
      expr: event_status
      comment: "Current status of the OOS event (open, resolved, escalated) for operational monitoring."
    - name: "recurrence_flag"
      expr: recurrence_flag
      comment: "Flag indicating whether this is a recurring OOS event for chronic issue identification."
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Flag indicating SLA breach due to OOS event for customer commitment tracking."
    - name: "customer_impact_flag"
      expr: customer_impact_flag
      comment: "Flag indicating customer-facing impact for customer service escalation prioritization."
  measures:
    - name: "total_oos_events"
      expr: COUNT(1)
      comment: "Total number of out-of-stock events. Primary frequency KPI for supply chain reliability management."
    - name: "total_estimated_lost_sales_value"
      expr: SUM(CAST(estimated_lost_sales_value AS DOUBLE))
      comment: "Total estimated revenue lost due to OOS events. Direct financial impact KPI for executive decision-making on inventory investment."
    - name: "total_lost_sales_quantity"
      expr: SUM(CAST(lost_sales_quantity AS DOUBLE))
      comment: "Total units of lost sales due to OOS. Measures demand that could not be fulfilled."
    - name: "avg_oos_duration_hours"
      expr: AVG(CAST(oos_duration_hours AS DOUBLE))
      comment: "Average duration of OOS events in hours. Measures responsiveness of replenishment processes."
    - name: "total_oos_duration_hours"
      expr: SUM(CAST(oos_duration_hours AS DOUBLE))
      comment: "Total cumulative OOS duration in hours. Measures overall supply chain reliability exposure."
    - name: "avg_osa_actual_pct"
      expr: AVG(CAST(osa_actual_percent AS DOUBLE))
      comment: "Average on-shelf availability percentage. Key retail execution KPI directly linked to revenue and customer satisfaction."
    - name: "osa_gap_pct"
      expr: AVG(CAST(osa_target_percent AS DOUBLE) - CAST(osa_actual_percent AS DOUBLE))
      comment: "Average gap between target and actual on-shelf availability. Measures performance shortfall against service level commitments."
    - name: "recurring_oos_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN recurrence_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of OOS events that are recurring. High rates indicate systemic supply chain failures requiring structural intervention."
    - name: "sla_breach_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sla_breach_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of OOS events resulting in SLA breach. Measures customer commitment risk from inventory failures."
    - name: "avg_forecast_accuracy_pct"
      expr: AVG(CAST(forecast_accuracy_percent AS DOUBLE))
      comment: "Average demand forecast accuracy at time of OOS event. Links forecast quality to stockout risk for planning improvement."
    - name: "distinct_sku_oos_count"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs experiencing OOS events. Measures breadth of supply chain reliability issues across the portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`inventory_recall_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product recall metrics tracking recall scope, financial impact, recovery effectiveness, and regulatory compliance. Critical KPIs for quality leadership, regulatory affairs, and brand risk management."
  source: "`vibe_consumer_goods_v1`.`inventory`.`recall_event`"
  dimensions:
    - name: "sku_id"
      expr: sku_id
      comment: "SKU identifier for product-level recall analysis."
    - name: "warehouse_id"
      expr: warehouse_id
      comment: "Warehouse where recalled inventory is held for logistics and disposition planning."
    - name: "marketing_brand_id"
      expr: marketing_brand_id
      comment: "Brand affected by the recall for brand risk and reputation impact analysis."
    - name: "recall_class"
      expr: recall_class
      comment: "Regulatory recall class (Class I, II, III) indicating severity and required response speed."
    - name: "recall_type"
      expr: recall_type
      comment: "Type of recall (voluntary, mandatory, market withdrawal) for regulatory reporting."
    - name: "recall_reason"
      expr: recall_reason
      comment: "Primary reason for the recall for root cause and prevention analysis."
    - name: "recall_status"
      expr: recall_status
      comment: "Current recall status (active, closed, monitoring) for operational tracking."
    - name: "recall_scope_geographic"
      expr: recall_scope_geographic
      comment: "Geographic scope of the recall for regulatory jurisdiction and logistics planning."
    - name: "recall_scope_channel"
      expr: recall_scope_channel
      comment: "Channel scope of the recall for targeted consumer notification and product retrieval."
    - name: "recall_date"
      expr: recall_date
      comment: "Date recall was initiated for time-to-response analysis."
  measures:
    - name: "total_recall_events"
      expr: COUNT(1)
      comment: "Total number of recall events. Measures frequency of quality failures reaching market — a critical brand and regulatory risk KPI."
    - name: "total_affected_quantity"
      expr: SUM(CAST(affected_quantity AS DOUBLE))
      comment: "Total quantity of product affected by recalls. Measures the scale of supply chain quality failures."
    - name: "total_quantity_recalled"
      expr: SUM(CAST(quantity_recalled AS DOUBLE))
      comment: "Total quantity formally recalled from market. Measures the operational scope of recall execution."
    - name: "total_quantity_recovered"
      expr: SUM(CAST(quantity_recovered AS DOUBLE))
      comment: "Total quantity successfully recovered from market. Measures recall execution effectiveness."
    - name: "avg_recall_effectiveness_pct"
      expr: AVG(CAST(recall_effectiveness_percentage AS DOUBLE))
      comment: "Average recall effectiveness percentage. Regulatory compliance KPI — FDA/EFSA require demonstrable recovery rates."
    - name: "total_estimated_financial_impact"
      expr: SUM(CAST(estimated_financial_impact AS DOUBLE))
      comment: "Total estimated financial impact of recall events. Quantifies P&L exposure from quality failures for executive risk reporting."
    - name: "total_quantity_distributed"
      expr: SUM(CAST(quantity_distributed AS DOUBLE))
      comment: "Total quantity distributed before recall. Measures market exposure and consumer risk scope."
    - name: "recovery_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(quantity_recovered AS DOUBLE)) / NULLIF(SUM(CAST(quantity_recalled AS DOUBLE)), 0), 2)
      comment: "Percentage of recalled quantity successfully recovered. Primary recall execution effectiveness KPI for regulatory compliance."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`inventory_reservation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory reservation metrics tracking committed supply, fulfilment rates, and reservation pressure. Supports order promising, allocation management, and customer commitment reliability decisions."
  source: "`vibe_consumer_goods_v1`.`inventory`.`reservation`"
  dimensions:
    - name: "warehouse_id"
      expr: warehouse_id
      comment: "Warehouse holding the reserved inventory for facility-level allocation analysis."
    - name: "sku_id"
      expr: sku_id
      comment: "SKU reserved for product-level allocation and commitment analysis."
    - name: "reservation_type"
      expr: reservation_type
      comment: "Type of reservation (e.g. sales order, production, transfer) for demand source analysis."
    - name: "reservation_status"
      expr: reservation_status
      comment: "Current reservation status (e.g. open, fulfilled, cancelled) for pipeline management."
    - name: "priority"
      expr: priority
      comment: "Reservation priority for allocation triage and conflict resolution."
    - name: "priority_level"
      expr: priority_level
      comment: "Detailed priority level for fine-grained allocation management."
    - name: "committed_to_customer_flag"
      expr: committed_to_customer_flag
      comment: "Boolean flag indicating customer-committed reservations, highest priority for fulfilment."
    - name: "blocked_flag"
      expr: blocked_flag
      comment: "Boolean flag indicating blocked reservations for exception management."
    - name: "vmi_replenishment_flag"
      expr: vmi_replenishment_flag
      comment: "Boolean flag identifying VMI-driven reservations for vendor-managed inventory analysis."
    - name: "fulfillment_method"
      expr: fulfillment_method
      comment: "Fulfilment method (e.g. pick from stock, cross-dock) for operational planning."
    - name: "reservation_date"
      expr: reservation_date
      comment: "Date the reservation was created for aging and lead time analysis."
    - name: "required_delivery_date"
      expr: required_delivery_date
      comment: "Required delivery date for SLA and on-time fulfilment analysis."
  measures:
    - name: "total_reserved_quantity"
      expr: SUM(CAST(reserved_quantity AS DOUBLE))
      comment: "Total quantity reserved across all active reservations. Measures committed supply demand against available inventory."
    - name: "total_fulfilled_quantity"
      expr: SUM(CAST(fulfilled_quantity AS DOUBLE))
      comment: "Total quantity fulfilled against reservations. Measures reservation execution effectiveness."
    - name: "reservation_fulfilment_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(fulfilled_quantity AS DOUBLE)) / NULLIF(SUM(CAST(reserved_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of reserved quantity that has been fulfilled. Core order fulfilment reliability KPI."
    - name: "customer_committed_reserved_quantity"
      expr: SUM(CASE WHEN committed_to_customer_flag = TRUE THEN reserved_quantity ELSE 0 END)
      comment: "Total quantity reserved with customer commitment. Highest-priority supply commitment metric for customer service management."
    - name: "blocked_reservation_count"
      expr: COUNT(CASE WHEN blocked_flag = TRUE THEN reservation_id END)
      comment: "Number of blocked reservations. Blocked reservations signal fulfilment risk and require operational intervention."
    - name: "total_reservations"
      expr: COUNT(1)
      comment: "Total number of reservation records. Measures demand commitment volume for capacity and allocation planning."
    - name: "distinct_sku_reserved_count"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs with active reservations. Breadth of committed demand across the product range."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`inventory_safety_stock_policy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Safety stock policy metrics tracking buffer inventory levels, service level targets, and policy coverage. Supports supply chain planning decisions on inventory investment vs. service level trade-offs."
  source: "`vibe_consumer_goods_v1`.`inventory`.`safety_stock_policy`"
  dimensions:
    - name: "sku_id"
      expr: sku_id
      comment: "SKU identifier for product-level safety stock policy analysis."
    - name: "warehouse_id"
      expr: warehouse_id
      comment: "Warehouse for facility-level safety stock investment analysis."
    - name: "policy_type"
      expr: policy_type
      comment: "Type of safety stock policy (fixed, dynamic, statistical) for methodology analysis."
    - name: "replenishment_strategy"
      expr: replenishment_strategy
      comment: "Replenishment strategy (min-max, reorder point, VMI) for strategy effectiveness analysis."
    - name: "abc_classification"
      expr: abc_classification
      comment: "ABC classification for prioritized safety stock investment analysis."
    - name: "xyz_classification"
      expr: xyz_classification
      comment: "XYZ demand variability classification for safety stock sizing methodology selection."
    - name: "criticality_level"
      expr: criticality_level
      comment: "Criticality level of the SKU for risk-based safety stock prioritization."
    - name: "system_generated_flag"
      expr: system_generated_flag
      comment: "Flag indicating whether policy was system-generated vs. manually set for automation coverage analysis."
    - name: "effective_date"
      expr: effective_date
      comment: "Effective date of the policy for policy currency analysis."
  measures:
    - name: "total_safety_stock_quantity"
      expr: SUM(CAST(safety_stock_quantity AS DOUBLE))
      comment: "Total safety stock quantity mandated by policy. Measures total buffer inventory investment across the network."
    - name: "avg_service_level_target_pct"
      expr: AVG(CAST(service_level_target_pct AS DOUBLE))
      comment: "Average service level target across policies. Measures the ambition of the inventory service strategy."
    - name: "avg_reorder_point"
      expr: AVG(CAST(reorder_point AS DOUBLE))
      comment: "Average reorder point quantity. Measures the trigger level for replenishment actions across the portfolio."
    - name: "total_min_stock_level"
      expr: SUM(CAST(min_stock_level AS DOUBLE))
      comment: "Total minimum stock level across all policies. Measures the floor inventory investment required by policy."
    - name: "total_max_stock_level"
      expr: SUM(CAST(max_stock_level AS DOUBLE))
      comment: "Total maximum stock level across all policies. Measures the ceiling inventory investment cap."
    - name: "avg_demand_variability"
      expr: AVG(CAST(demand_variability AS DOUBLE))
      comment: "Average demand variability coefficient across policies. Higher values indicate greater safety stock requirements and supply chain risk."
    - name: "avg_carrying_cost_rate_pct"
      expr: AVG(CAST(carrying_cost_rate_percent AS DOUBLE))
      comment: "Average inventory carrying cost rate. Used to calculate the financial cost of safety stock investment decisions."
    - name: "distinct_sku_policy_count"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs with active safety stock policies. Measures policy coverage across the product portfolio."
    - name: "avg_stockout_cost_per_unit"
      expr: AVG(CAST(stockout_cost_per_unit AS DOUBLE))
      comment: "Average cost per unit of stockout. Used to justify safety stock investment levels against stockout risk."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`inventory_stock_adjustment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory accuracy and adjustment metrics tracking the volume, value, and reasons for stock adjustments. Supports inventory accuracy management, audit compliance, and loss prevention decisions."
  source: "`vibe_consumer_goods_v1`.`inventory`.`stock_adjustment`"
  dimensions:
    - name: "sku_id"
      expr: sku_id
      comment: "SKU identifier for product-level adjustment analysis."
    - name: "warehouse_id"
      expr: warehouse_id
      comment: "Warehouse where adjustment was posted for facility-level accuracy analysis."
    - name: "adjustment_type"
      expr: adjustment_type
      comment: "Type of adjustment (write-off, count correction, damage, etc.) for root cause categorization."
    - name: "adjustment_reason_code"
      expr: adjustment_reason_code
      comment: "Reason code for the adjustment, enabling systematic root cause analysis."
    - name: "adjustment_status"
      expr: adjustment_status
      comment: "Current status of the adjustment (pending, approved, posted) for workflow monitoring."
    - name: "cost_center_id"
      expr: cost_center_id
      comment: "Cost center absorbing the adjustment value for financial accountability."
    - name: "company_code_id"
      expr: company_code_id
      comment: "Company code for legal entity-level adjustment reporting."
    - name: "posting_date"
      expr: posting_date
      comment: "Accounting posting date for period-aligned financial reporting."
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Flag indicating whether this adjustment was subsequently reversed."
    - name: "stock_type"
      expr: stock_type
      comment: "Stock type affected by the adjustment for inventory category analysis."
  measures:
    - name: "total_adjustment_quantity"
      expr: SUM(CAST(adjustment_quantity AS DOUBLE))
      comment: "Total net quantity adjusted. Measures the scale of inventory discrepancies requiring correction."
    - name: "total_adjustment_value"
      expr: SUM(CAST(adjustment_value AS DOUBLE))
      comment: "Total financial value of inventory adjustments. Key P&L impact metric for inventory shrinkage and loss reporting."
    - name: "total_adjusted_value"
      expr: SUM(CAST(adjusted_value AS DOUBLE))
      comment: "Total adjusted inventory value after corrections. Measures the financial magnitude of inventory accuracy issues."
    - name: "total_adjustment_transactions"
      expr: COUNT(1)
      comment: "Total number of adjustment transactions. High frequency indicates systemic inventory accuracy problems."
    - name: "distinct_sku_adjusted_count"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs requiring adjustment. Breadth indicator for inventory accuracy issues across the portfolio."
    - name: "avg_adjustment_value_per_transaction"
      expr: AVG(CAST(adjustment_value AS DOUBLE))
      comment: "Average financial value per adjustment transaction. Identifies whether adjustments are high-value isolated events or systemic low-value issues."
    - name: "total_value_impact"
      expr: SUM(CAST(value_impact AS DOUBLE))
      comment: "Total P&L value impact of all stock adjustments. Direct measure of inventory shrinkage cost to the business."
    - name: "reversal_count"
      expr: COUNT(CASE WHEN reversal_indicator = TRUE THEN 1 END)
      comment: "Number of reversed adjustments. Indicates rework and process quality issues in inventory management."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`inventory_stock_hold`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Stock hold metrics tracking the volume, value, and duration of inventory placed on quality or regulatory hold. Supports quality management and supply risk decisions."
  source: "`vibe_consumer_goods_v1`.`inventory`.`stock_hold`"
  dimensions:
    - name: "sku_id"
      expr: sku_id
      comment: "SKU identifier for product-level hold analysis."
    - name: "warehouse_id"
      expr: warehouse_id
      comment: "Warehouse where held inventory is located for facility-level hold management."
    - name: "hold_type"
      expr: hold_type
      comment: "Type of hold (quality, regulatory, recall, supplier) for root cause categorization."
    - name: "hold_reason_code"
      expr: hold_reason_code
      comment: "Specific reason code for the hold to drive targeted corrective actions."
    - name: "hold_status"
      expr: hold_status
      comment: "Current hold status (active, released, disposed) for hold pipeline monitoring."
    - name: "hold_priority"
      expr: hold_priority
      comment: "Priority level of the hold for resolution urgency management."
    - name: "is_quality_hold"
      expr: is_quality_hold
      comment: "Flag indicating quality-related hold for quality management reporting."
    - name: "is_recall_related"
      expr: is_recall_related
      comment: "Flag indicating recall-related hold for recall management reporting."
    - name: "supplier_id"
      expr: supplier_id
      comment: "Supplier associated with the held inventory for supplier quality performance analysis."
    - name: "hold_start_date"
      expr: hold_start_date
      comment: "Date hold was placed for hold duration and aging analysis."
  measures:
    - name: "total_stock_holds"
      expr: COUNT(1)
      comment: "Total number of active stock holds. Measures quality and compliance issue frequency."
    - name: "total_held_quantity"
      expr: SUM(CAST(held_quantity AS DOUBLE))
      comment: "Total quantity currently on hold. Measures supply availability risk from quality and compliance issues."
    - name: "total_hold_value"
      expr: SUM(CAST(hold_value_amount AS DOUBLE))
      comment: "Total financial value of inventory on hold. Quantifies working capital at risk from quality and compliance issues."
    - name: "quality_hold_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_quality_hold = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of holds that are quality-related. Measures quality system effectiveness and supplier quality performance."
    - name: "recall_related_hold_value"
      expr: SUM(CASE WHEN is_recall_related = TRUE THEN hold_value_amount ELSE 0 END)
      comment: "Total value of inventory held due to recall events. Measures financial exposure from product safety issues."
    - name: "distinct_sku_on_hold_count"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs with active holds. Measures breadth of supply availability risk across the portfolio."
    - name: "distinct_supplier_hold_count"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of distinct suppliers with inventory on hold. Identifies suppliers with systemic quality issues."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`inventory_stock_movement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory flow and throughput metrics derived from stock movement transactions. Tracks movement volumes, values, and reversal rates to support supply chain efficiency and audit compliance decisions."
  source: "`vibe_consumer_goods_v1`.`inventory`.`stock_movement`"
  dimensions:
    - name: "sku_id"
      expr: sku_id
      comment: "SKU identifier for product-level movement analysis."
    - name: "warehouse_id"
      expr: warehouse_id
      comment: "Warehouse where movement occurred for facility throughput analysis."
    - name: "movement_type"
      expr: movement_type
      comment: "Type of stock movement (goods receipt, goods issue, transfer, etc.) for movement category analysis."
    - name: "movement_type_code"
      expr: movement_type_code
      comment: "SAP-style movement type code for detailed transaction classification."
    - name: "movement_category"
      expr: movement_category
      comment: "High-level movement category for executive-level flow reporting."
    - name: "stock_type"
      expr: stock_type
      comment: "Stock type affected by the movement for inventory category tracking."
    - name: "cost_center_id"
      expr: cost_center_id
      comment: "Cost center for financial allocation of movement costs."
    - name: "supplier_id"
      expr: supplier_id
      comment: "Supplier associated with inbound movements for supplier performance analysis."
    - name: "posting_date"
      expr: posting_date
      comment: "Accounting posting date for period-aligned financial reporting."
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Flag indicating whether this movement is a reversal, used to measure correction rates."
    - name: "carrier_id"
      expr: carrier_id
      comment: "Carrier associated with the movement for logistics performance analysis."
  measures:
    - name: "total_movement_quantity"
      expr: SUM(CAST(movement_quantity AS DOUBLE))
      comment: "Total quantity moved across all movement types. Primary throughput KPI for warehouse and supply chain operations."
    - name: "total_movement_value"
      expr: SUM(CAST(total_value AS DOUBLE))
      comment: "Total financial value of inventory movements. Drives COGS and inventory flow reporting for finance leadership."
    - name: "total_movement_transactions"
      expr: COUNT(1)
      comment: "Total number of stock movement transactions. Measures operational throughput and system activity volume."
    - name: "reversal_transaction_count"
      expr: COUNT(CASE WHEN reversal_indicator = TRUE THEN 1 END)
      comment: "Number of reversal transactions. High reversal rates indicate data quality or process compliance issues requiring investigation."
    - name: "reversal_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN reversal_indicator = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of movements that are reversals. KPI for process quality — high rates signal systemic posting errors."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost of moved inventory. Tracks cost consistency across movement types and periods."
    - name: "total_quantity_issued"
      expr: SUM(CASE WHEN movement_category = 'GOODS_ISSUE' THEN movement_quantity ELSE 0 END)
      comment: "Total quantity issued from stock. Measures consumption and outbound flow for demand fulfillment analysis."
    - name: "total_quantity_received"
      expr: SUM(CASE WHEN movement_category = 'GOODS_RECEIPT' THEN movement_quantity ELSE 0 END)
      comment: "Total quantity received into stock. Measures inbound supply flow for replenishment performance analysis."
    - name: "distinct_sku_count"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs with stock movements. Measures breadth of inventory activity across the portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`inventory_stock_position`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core inventory health metrics derived from stock position snapshots. Tracks on-hand quantities, availability, safety stock coverage, and inventory value to support replenishment decisions and working capital management."
  source: "`vibe_consumer_goods_v1`.`inventory`.`stock_position`"
  dimensions:
    - name: "sku_id"
      expr: sku_id
      comment: "SKU identifier for product-level inventory analysis."
    - name: "warehouse_id"
      expr: warehouse_id
      comment: "Warehouse where stock is held, enabling location-level inventory analysis."
    - name: "manufacturing_facility_id"
      expr: manufacturing_facility_id
      comment: "Manufacturing facility associated with the stock position, for plant-level analysis."
    - name: "stock_type"
      expr: stock_type
      comment: "Type of stock (unrestricted, blocked, quality inspection, etc.) for stock category analysis."
    - name: "inventory_status"
      expr: inventory_status
      comment: "Current inventory status to filter active vs. blocked or obsolete stock."
    - name: "valuation_type"
      expr: valuation_type
      comment: "Valuation method applied (standard cost, moving average, etc.) for financial analysis."
    - name: "snapshot_date"
      expr: snapshot_date
      comment: "Date of the stock position snapshot, enabling time-series trending of inventory levels."
    - name: "oos_risk_flag"
      expr: oos_risk_flag
      comment: "Flag indicating whether this SKU/location is at risk of going out of stock."
    - name: "slow_moving_flag"
      expr: slow_moving_flag
      comment: "Flag indicating slow-moving inventory, useful for write-down and clearance decisions."
    - name: "obsolete_flag"
      expr: obsolete_flag
      comment: "Flag indicating obsolete inventory requiring write-off action."
    - name: "vmi_replenishment_flag"
      expr: vmi_replenishment_flag
      comment: "Indicates whether this position is managed under a VMI replenishment agreement."
    - name: "supplier_id"
      expr: supplier_id
      comment: "Supplier associated with the stock position for supplier performance analysis."
  measures:
    - name: "total_on_hand_quantity"
      expr: SUM(CAST(on_hand_quantity AS DOUBLE))
      comment: "Total on-hand inventory quantity across selected dimensions. Primary inventory availability KPI used in replenishment and supply planning decisions."
    - name: "total_available_quantity"
      expr: SUM(CAST(available_quantity AS DOUBLE))
      comment: "Total available-to-sell quantity (on-hand minus reserved/blocked). Drives order fulfillment and ATP calculations."
    - name: "total_reserved_quantity"
      expr: SUM(CAST(reserved_quantity AS DOUBLE))
      comment: "Total quantity reserved against open orders or promotions. Indicates committed inventory not available for new demand."
    - name: "total_atp_quantity"
      expr: SUM(CAST(available_to_promise_quantity AS DOUBLE))
      comment: "Total available-to-promise quantity. Critical for customer service and order promising decisions."
    - name: "total_safety_stock_quantity"
      expr: SUM(CAST(safety_stock_quantity AS DOUBLE))
      comment: "Total safety stock quantity held across locations. Measures buffer inventory investment against demand variability."
    - name: "total_in_transit_quantity"
      expr: SUM(CAST(in_transit_quantity AS DOUBLE))
      comment: "Total quantity currently in transit to warehouses. Represents pipeline inventory for supply continuity planning."
    - name: "total_blocked_quantity"
      expr: SUM(CAST(blocked_quantity AS DOUBLE))
      comment: "Total quantity blocked (quality hold, recall, etc.). Measures inventory at risk and potential write-off exposure."
    - name: "total_quality_inspection_quantity"
      expr: SUM(CAST(quality_inspection_quantity AS DOUBLE))
      comment: "Total quantity under quality inspection. Indicates throughput bottleneck in quality release process."
    - name: "total_inventory_value"
      expr: SUM(CAST(total_value AS DOUBLE))
      comment: "Total inventory value at current cost. Core working capital KPI for finance and supply chain leadership."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost across stock positions. Used to monitor cost trends and valuation accuracy."
    - name: "total_unrestricted_quantity"
      expr: SUM(CAST(unrestricted_quantity AS DOUBLE))
      comment: "Total unrestricted (freely available) stock quantity. Primary measure of usable inventory for order fulfillment."
    - name: "oos_risk_sku_location_count"
      expr: COUNT(DISTINCT CASE WHEN oos_risk_flag = TRUE THEN stock_position_id END)
      comment: "Number of distinct SKU-location combinations flagged as OOS risk. Drives urgent replenishment prioritization."
    - name: "slow_moving_inventory_value"
      expr: SUM(CASE WHEN slow_moving_flag = TRUE THEN total_value ELSE 0 END)
      comment: "Total value of slow-moving inventory. Quantifies working capital tied up in slow-moving stock requiring clearance action."
    - name: "obsolete_inventory_value"
      expr: SUM(CASE WHEN obsolete_flag = TRUE THEN total_value ELSE 0 END)
      comment: "Total value of obsolete inventory. Represents write-off exposure and drives disposal decisions."
    - name: "avg_days_inventory_outstanding"
      expr: AVG(CAST(days_inventory_outstanding AS DOUBLE))
      comment: "Average days inventory outstanding across stock positions. Key efficiency metric for inventory turnover management."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`inventory_stock_valuation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial inventory valuation metrics covering total stock value, cost accuracy, turnover, and write-down exposure. Supports finance and supply chain leadership in working capital and cost management decisions."
  source: "`vibe_consumer_goods_v1`.`inventory`.`stock_valuation`"
  dimensions:
    - name: "sku_id"
      expr: sku_id
      comment: "SKU identifier for product-level valuation analysis."
    - name: "warehouse_id"
      expr: warehouse_id
      comment: "Warehouse location for facility-level valuation reporting."
    - name: "cost_center_id"
      expr: cost_center_id
      comment: "Cost center for financial allocation and P&L reporting."
    - name: "profit_center_id"
      expr: profit_center_id
      comment: "Profit center for margin and profitability analysis."
    - name: "valuation_method"
      expr: valuation_method
      comment: "Valuation method (standard cost, moving average, FIFO, etc.) for cost accounting analysis."
    - name: "valuation_type"
      expr: valuation_type
      comment: "Valuation type classification for inventory accounting segmentation."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for period-over-period financial comparison."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual inventory valuation reporting."
    - name: "valuation_date"
      expr: valuation_date
      comment: "Date of valuation snapshot for time-series financial analysis."
    - name: "slow_moving_flag"
      expr: slow_moving_flag
      comment: "Slow-moving inventory flag for targeted write-down analysis."
    - name: "obsolete_flag"
      expr: obsolete_flag
      comment: "Obsolete inventory flag for write-off exposure quantification."
    - name: "valuation_status"
      expr: valuation_status
      comment: "Current valuation status (active, closed, pending) for period-end reporting."
  measures:
    - name: "total_stock_value"
      expr: SUM(CAST(total_stock_value AS DOUBLE))
      comment: "Total inventory stock value at current valuation. Primary balance sheet inventory KPI for finance leadership."
    - name: "total_quantity_valued"
      expr: SUM(CAST(quantity_valued AS DOUBLE))
      comment: "Total quantity included in valuation. Used to validate completeness of inventory valuation coverage."
    - name: "avg_moving_average_cost"
      expr: AVG(CAST(moving_average_cost AS DOUBLE))
      comment: "Average moving average cost per unit. Tracks cost trend and identifies cost variances requiring investigation."
    - name: "avg_standard_cost"
      expr: AVG(CAST(standard_cost AS DOUBLE))
      comment: "Average standard cost per unit. Baseline for variance analysis against actual costs."
    - name: "avg_actual_unit_cost"
      expr: AVG(CAST(actual_unit_cost AS DOUBLE))
      comment: "Average actual unit cost. Compared against standard cost to measure cost efficiency."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total cost variance (actual vs. standard). Drives manufacturing and procurement cost improvement actions."
    - name: "total_write_down_amount"
      expr: SUM(CAST(write_down_amount AS DOUBLE))
      comment: "Total inventory write-down amount. Measures financial impact of slow-moving and obsolete inventory decisions."
    - name: "total_revaluation_amount"
      expr: SUM(CAST(revaluation_amount AS DOUBLE))
      comment: "Total revaluation adjustments applied to inventory. Tracks financial impact of cost standard updates."
    - name: "total_cogs_allocation"
      expr: SUM(CAST(cogs_allocation_amount AS DOUBLE))
      comment: "Total COGS allocated from inventory. Links inventory consumption to income statement for gross margin analysis."
    - name: "avg_inventory_turnover_ratio"
      expr: AVG(CAST(inventory_turnover_ratio AS DOUBLE))
      comment: "Average inventory turnover ratio. Key efficiency KPI — higher turnover indicates leaner, more efficient inventory management."
    - name: "avg_days_inventory_outstanding"
      expr: AVG(CAST(days_inventory_outstanding AS DOUBLE))
      comment: "Average days inventory outstanding. Measures how many days of supply are held, directly impacting working capital."
    - name: "total_safety_stock_value"
      expr: SUM(CAST(safety_stock_value AS DOUBLE))
      comment: "Total value of safety stock held. Quantifies the working capital cost of buffer inventory strategy."
    - name: "total_net_realizable_value"
      expr: SUM(CAST(net_realizable_value AS DOUBLE))
      comment: "Total net realizable value of inventory. Used for lower-of-cost-or-NRV write-down assessments per accounting standards."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`inventory_warehouse`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Warehouse network metrics tracking capacity, operational status, and geographic coverage. Supports network design, capacity planning, and operational efficiency decisions."
  source: "`vibe_consumer_goods_v1`.`inventory`.`warehouse`"
  dimensions:
    - name: "warehouse_type"
      expr: warehouse_type
      comment: "Type of warehouse (e.g. DC, plant warehouse, 3PL) for network segmentation analysis."
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the warehouse for network availability monitoring."
    - name: "country_code"
      expr: country_code
      comment: "Country where the warehouse is located for geographic network analysis."
    - name: "region"
      expr: region
      comment: "Region for regional network capacity and coverage analysis."
    - name: "climate_zone"
      expr: climate_zone
      comment: "Climate zone for temperature-sensitive storage planning."
    - name: "temperature_controlled_flag"
      expr: temperature_controlled_flag
      comment: "Boolean flag identifying temperature-controlled warehouses for cold chain network analysis."
    - name: "is_primary"
      expr: is_primary
      comment: "Boolean flag identifying primary warehouses for network hierarchy analysis."
    - name: "security_level"
      expr: security_level
      comment: "Security level classification for high-value or controlled substance storage analysis."
    - name: "wms_system"
      expr: wms_system
      comment: "Warehouse management system in use for technology landscape and integration planning."
    - name: "opening_date"
      expr: opening_date
      comment: "Warehouse opening date for network age and lifecycle analysis."
  measures:
    - name: "total_warehouses"
      expr: COUNT(1)
      comment: "Total number of warehouses in the network. Network scale metric for capacity and coverage planning."
    - name: "total_capacity_sqft"
      expr: SUM(CAST(capacity_sqft AS DOUBLE))
      comment: "Total warehouse capacity in square feet. Network capacity metric for storage planning and expansion decisions."
    - name: "total_total_capacity"
      expr: SUM(CAST(total_capacity AS DOUBLE))
      comment: "Total capacity across all warehouses in capacity units. Aggregate network storage capacity for supply chain design decisions."
    - name: "temperature_controlled_warehouse_count"
      expr: COUNT(CASE WHEN temperature_controlled_flag = TRUE THEN warehouse_id END)
      comment: "Number of temperature-controlled warehouses. Cold chain network capacity metric for perishable and pharmaceutical product planning."
    - name: "temperature_controlled_capacity_sqft"
      expr: SUM(CASE WHEN temperature_controlled_flag = TRUE THEN capacity_sqft ELSE 0 END)
      comment: "Total capacity of temperature-controlled warehouses. Cold chain storage capacity metric for network design."
    - name: "active_warehouse_count"
      expr: COUNT(CASE WHEN operational_status = 'Active' THEN warehouse_id END)
      comment: "Number of operationally active warehouses. Effective network capacity metric for supply chain planning."
    - name: "avg_warehouse_capacity_sqft"
      expr: AVG(CAST(capacity_sqft AS DOUBLE))
      comment: "Average warehouse size in square feet. Benchmarks facility scale for network design and consolidation decisions."
    - name: "distinct_country_count"
      expr: COUNT(DISTINCT country_code)
      comment: "Number of countries with warehouse presence. Geographic network coverage metric for international supply chain management."
$$;
