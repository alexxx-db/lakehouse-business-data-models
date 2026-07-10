-- Metric views for domain: distribution | Business: Consumer_Goods | Version: 2 | Generated on: 2026-07-10 13:28:51

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`distribution_otif_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "On-Time In-Full (OTIF) performance metrics — the primary KPI for distribution service level compliance. Tracks delivery accuracy, penalty exposure, and fill-rate adherence by customer, facility, and carrier."
  source: "`vibe_consumer_goods_v1`.`distribution`.`otif_event`"
  dimensions:
    - name: "delivery_channel"
      expr: delivery_channel
      comment: "Channel through which the delivery was made (e.g., DSD, DC, e-commerce) — used to segment OTIF performance by route-to-market."
    - name: "failure_category"
      expr: failure_category
      comment: "High-level category of OTIF failure (e.g., carrier, warehouse, demand) — used to assign accountability and drive corrective action."
    - name: "sla_tier"
      expr: sla_tier
      comment: "Service level agreement tier governing the delivery commitment — used to benchmark performance against contractual obligations."
    - name: "event_status"
      expr: event_status
      comment: "Current status of the OTIF event (e.g., compliant, non-compliant, disputed) — used to filter active vs. resolved events."
    - name: "measurement_date"
      expr: DATE_TRUNC('month', measurement_date)
      comment: "Month of OTIF measurement — used for trend analysis and period-over-period comparisons."
    - name: "on_time_flag"
      expr: on_time_flag
      comment: "Whether the delivery arrived on or before the committed date — primary dimension for on-time segmentation."
    - name: "in_full_flag"
      expr: in_full_flag
      comment: "Whether the delivery was fulfilled at the committed quantity — primary dimension for in-full segmentation."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Whether the OTIF event is under dispute — used to separate clean performance from contested records."
  measures:
    - name: "total_otif_events"
      expr: COUNT(1)
      comment: "Total number of OTIF measurement events — baseline denominator for all OTIF rate calculations."
    - name: "otif_compliant_events"
      expr: SUM(CASE WHEN otif_score = TRUE THEN 1 ELSE 0 END)
      comment: "Count of delivery events that were both on-time and in-full — numerator for OTIF compliance rate."
    - name: "on_time_events"
      expr: SUM(CASE WHEN on_time_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of deliveries that arrived on or before the committed date — numerator for on-time rate."
    - name: "in_full_events"
      expr: SUM(CASE WHEN in_full_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of deliveries fulfilled at the committed quantity — numerator for in-full rate."
    - name: "total_retailer_penalty_amount"
      expr: SUM(CAST(retailer_penalty_amount AS DOUBLE))
      comment: "Total financial penalties charged by retailers for OTIF non-compliance — direct P&L impact metric used by finance and supply chain leadership."
    - name: "total_committed_quantity"
      expr: SUM(CAST(committed_quantity AS DOUBLE))
      comment: "Total quantity committed for delivery across all OTIF events — denominator for fill-rate calculations."
    - name: "total_delivered_quantity"
      expr: SUM(CAST(delivered_quantity AS DOUBLE))
      comment: "Total quantity actually delivered — used with committed quantity to compute fill rate."
    - name: "total_quantity_variance"
      expr: SUM(CAST(quantity_variance AS DOUBLE))
      comment: "Aggregate quantity shortfall or overage across all delivery events — signals systemic supply or planning gaps."
    - name: "avg_quantity_variance_percent"
      expr: AVG(CAST(quantity_variance_percent AS DOUBLE))
      comment: "Average percentage variance between committed and delivered quantities — used to assess severity of fill-rate misses."
    - name: "disputed_events"
      expr: SUM(CASE WHEN dispute_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of OTIF events under active dispute — high dispute volume signals data quality or relationship issues with retail partners."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`distribution_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Distribution shipment execution metrics — tracks freight cost, service level compliance, shipment volume, and on-time delivery performance across the outbound distribution network."
  source: "`vibe_consumer_goods_v1`.`distribution`.`distribution_shipment`"
  dimensions:
    - name: "shipment_status"
      expr: shipment_status
      comment: "Current status of the shipment (e.g., in-transit, delivered, cancelled) — used to filter active vs. completed shipments."
    - name: "shipment_type"
      expr: shipment_type
      comment: "Type of shipment (e.g., full-truckload, LTL, parcel) — used to segment freight cost and service level by mode."
    - name: "carrier_service_level"
      expr: carrier_service_level
      comment: "Service level contracted with the carrier (e.g., standard, expedited) — used to benchmark cost vs. service trade-offs."
    - name: "destination_country_code"
      expr: destination_country_code
      comment: "Country of the delivery destination — used for geographic performance analysis and trade compliance reporting."
    - name: "destination_type"
      expr: destination_type
      comment: "Type of destination (e.g., retail DC, store, customer) — used to segment shipment performance by customer class."
    - name: "scheduled_ship_date"
      expr: DATE_TRUNC('month', scheduled_ship_date)
      comment: "Month of scheduled ship date — used for trend analysis of shipment volumes and freight costs."
    - name: "temperature_controlled_flag"
      expr: temperature_controlled_flag
      comment: "Whether the shipment required temperature-controlled transport — used to segment cold-chain vs. ambient freight costs."
    - name: "hazmat_flag"
      expr: hazmat_flag
      comment: "Whether the shipment contained hazardous materials — used for compliance reporting and cost surcharge analysis."
    - name: "on_time_flag"
      expr: on_time_flag
      comment: "Whether the shipment was delivered on or before the committed date — primary on-time performance dimension."
    - name: "in_full_flag"
      expr: in_full_flag
      comment: "Whether the shipment was delivered in full — primary fill-rate performance dimension."
  measures:
    - name: "total_shipments"
      expr: COUNT(1)
      comment: "Total number of distribution shipments — baseline volume metric for network capacity and throughput analysis."
    - name: "total_freight_charge_amount"
      expr: SUM(CAST(freight_charge_amount AS DOUBLE))
      comment: "Total freight cost across all shipments — primary cost metric for distribution P&L and carrier contract negotiations."
    - name: "avg_freight_charge_per_shipment"
      expr: AVG(CAST(freight_charge_amount AS DOUBLE))
      comment: "Average freight cost per shipment — used to benchmark carrier efficiency and identify cost outliers."
    - name: "total_weight_kg"
      expr: SUM(CAST(total_weight_kg AS DOUBLE))
      comment: "Total weight shipped in kilograms — used for freight cost normalization and carrier capacity planning."
    - name: "total_volume_cubic_meters"
      expr: SUM(CAST(total_volume_cubic_meters AS DOUBLE))
      comment: "Total cubic volume shipped — used for trailer utilization analysis and network capacity planning."
    - name: "on_time_shipments"
      expr: SUM(CASE WHEN on_time_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of shipments delivered on or before the committed date — numerator for on-time delivery rate."
    - name: "in_full_shipments"
      expr: SUM(CASE WHEN in_full_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of shipments delivered at full committed quantity — numerator for in-full rate."
    - name: "avg_freight_cost_per_kg"
      expr: AVG(CAST(freight_charge_amount AS DOUBLE) / NULLIF(CAST(total_weight_kg AS DOUBLE), 0))
      comment: "Average freight cost per kilogram shipped — key efficiency ratio for benchmarking carrier rates and identifying cost reduction opportunities."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`distribution_outbound_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Outbound order fulfillment metrics — tracks order volume, value, fill rates, and service level compliance for all outbound distribution orders. Core operational KPI view for distribution center performance."
  source: "`vibe_consumer_goods_v1`.`distribution`.`outbound_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current fulfillment status of the outbound order (e.g., open, shipped, cancelled) — used to monitor order pipeline health."
    - name: "order_type"
      expr: order_type
      comment: "Type of outbound order (e.g., replenishment, promotional, DSD) — used to segment fulfillment performance by order class."
    - name: "service_level"
      expr: service_level
      comment: "Service level commitment for the order (e.g., standard, priority, same-day) — used to benchmark fulfillment against SLA tiers."
    - name: "shipping_method"
      expr: shipping_method
      comment: "Method of shipment (e.g., LTL, FTL, parcel) — used to segment freight cost and lead time by mode."
    - name: "order_date"
      expr: DATE_TRUNC('month', order_date)
      comment: "Month of order placement — used for trend analysis of order volumes and fulfillment performance."
    - name: "backorder_flag"
      expr: backorder_flag
      comment: "Whether the order is on backorder — used to quantify supply shortfall impact on customer service."
    - name: "otif_commitment_flag"
      expr: otif_commitment_flag
      comment: "Whether the order carries an OTIF contractual commitment — used to prioritize fulfillment and track penalty exposure."
    - name: "temperature_controlled_flag"
      expr: temperature_controlled_flag
      comment: "Whether the order requires cold-chain handling — used to segment cold-chain fulfillment performance."
  measures:
    - name: "total_outbound_orders"
      expr: COUNT(1)
      comment: "Total number of outbound orders — baseline volume metric for distribution center throughput."
    - name: "total_order_value"
      expr: SUM(CAST(total_order_value AS DOUBLE))
      comment: "Total value of all outbound orders — primary revenue-at-risk metric for distribution operations."
    - name: "avg_order_value"
      expr: AVG(CAST(total_order_value AS DOUBLE))
      comment: "Average value per outbound order — used to track order mix and identify shifts in customer ordering patterns."
    - name: "total_order_quantity"
      expr: SUM(CAST(total_order_quantity AS DOUBLE))
      comment: "Total units ordered across all outbound orders — used for capacity planning and throughput analysis."
    - name: "total_order_weight_kg"
      expr: SUM(CAST(total_order_weight_kg AS DOUBLE))
      comment: "Total weight of all outbound orders in kilograms — used for freight planning and carrier capacity allocation."
    - name: "total_order_volume_m3"
      expr: SUM(CAST(total_order_volume_m3 AS DOUBLE))
      comment: "Total cubic volume of all outbound orders — used for trailer utilization and warehouse throughput planning."
    - name: "avg_fill_rate_percentage"
      expr: AVG(CAST(fill_rate_percentage AS DOUBLE))
      comment: "Average fill rate across all outbound orders — key service level KPI indicating the percentage of ordered quantity successfully fulfilled."
    - name: "backorder_orders"
      expr: SUM(CASE WHEN backorder_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of orders currently on backorder — signals supply shortfalls and customer service risk."
    - name: "cancelled_orders"
      expr: SUM(CASE WHEN order_status = 'CANCELLED' THEN 1 ELSE 0 END)
      comment: "Count of cancelled outbound orders — used to track order attrition and identify fulfillment failure root causes."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`distribution_inbound_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inbound receiving performance metrics — tracks receipt accuracy, quality compliance, and throughput for all inbound shipments at distribution facilities. Used by DC operations and procurement to manage supplier delivery performance."
  source: "`vibe_consumer_goods_v1`.`distribution`.`inbound_receipt`"
  dimensions:
    - name: "receipt_status"
      expr: receipt_status
      comment: "Current status of the inbound receipt (e.g., complete, partial, rejected) — used to monitor receiving pipeline."
    - name: "receipt_type"
      expr: receipt_type
      comment: "Type of inbound receipt (e.g., purchase order, transfer, return) — used to segment receiving volume by source type."
    - name: "quality_inspection_status"
      expr: quality_inspection_status
      comment: "Status of quality inspection for the receipt (e.g., passed, failed, pending) — used to track quality compliance at receiving."
    - name: "scheduled_receipt_date"
      expr: DATE_TRUNC('month', scheduled_receipt_date)
      comment: "Month of scheduled receipt — used for trend analysis of inbound volume and supplier delivery performance."
    - name: "discrepancy_flag"
      expr: discrepancy_flag
      comment: "Whether a quantity or condition discrepancy was identified at receiving — used to track supplier accuracy."
    - name: "otif_compliant_flag"
      expr: otif_compliant_flag
      comment: "Whether the inbound receipt met OTIF requirements — used to score supplier delivery performance."
    - name: "temperature_compliant_flag"
      expr: temperature_compliant_flag
      comment: "Whether the received goods met temperature compliance requirements — critical for food safety and regulatory compliance."
  measures:
    - name: "total_receipts"
      expr: COUNT(1)
      comment: "Total number of inbound receipts — baseline throughput metric for receiving operations."
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total quantity received across all inbound receipts — used for inventory replenishment tracking and supplier performance."
    - name: "total_accepted_quantity"
      expr: SUM(CAST(accepted_quantity AS DOUBLE))
      comment: "Total quantity accepted after inspection — used with received quantity to compute acceptance rate."
    - name: "total_rejected_quantity"
      expr: SUM(CAST(rejected_quantity AS DOUBLE))
      comment: "Total quantity rejected at receiving — high rejection volume signals supplier quality issues and drives corrective action."
    - name: "total_expected_quantity"
      expr: SUM(CAST(expected_quantity AS DOUBLE))
      comment: "Total quantity expected per advance shipping notices — denominator for receipt accuracy calculations."
    - name: "discrepancy_receipts"
      expr: SUM(CASE WHEN discrepancy_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of receipts with quantity or condition discrepancies — used to measure supplier delivery accuracy."
    - name: "otif_compliant_receipts"
      expr: SUM(CASE WHEN otif_compliant_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of inbound receipts meeting OTIF requirements — numerator for supplier OTIF compliance rate."
    - name: "avg_received_quantity"
      expr: AVG(CAST(received_quantity AS DOUBLE))
      comment: "Average quantity received per receipt — used to track order size trends and receiving workload planning."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`distribution_cycle_count`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory cycle count accuracy metrics — tracks variance, adjustment rates, and count compliance across distribution storage locations. Used by DC operations and finance to manage inventory accuracy and shrinkage."
  source: "`vibe_consumer_goods_v1`.`distribution`.`distribution_cycle_count`"
  dimensions:
    - name: "count_status"
      expr: count_status
      comment: "Current status of the cycle count (e.g., in-progress, complete, approved) — used to filter active vs. finalized counts."
    - name: "count_type"
      expr: count_type
      comment: "Type of cycle count (e.g., full, spot, ABC) — used to segment accuracy by count methodology."
    - name: "count_method"
      expr: count_method
      comment: "Method used for counting (e.g., RF scan, manual, blind) — used to assess accuracy by counting approach."
    - name: "abc_classification"
      expr: abc_classification
      comment: "ABC inventory classification of the counted SKU — used to prioritize count frequency and analyze accuracy by inventory value tier."
    - name: "scheduled_date"
      expr: DATE_TRUNC('month', scheduled_date)
      comment: "Month of scheduled cycle count — used for trend analysis of count frequency and accuracy over time."
    - name: "adjustment_required_flag"
      expr: adjustment_required_flag
      comment: "Whether an inventory adjustment was required based on count results — used to quantify inventory accuracy gaps."
    - name: "adjustment_approved_flag"
      expr: adjustment_approved_flag
      comment: "Whether the inventory adjustment was approved — used to track adjustment authorization compliance."
    - name: "recount_required_flag"
      expr: recount_required_flag
      comment: "Whether a recount was required due to variance exceeding tolerance — used to measure first-count accuracy."
  measures:
    - name: "total_cycle_counts"
      expr: COUNT(1)
      comment: "Total number of cycle count records — baseline metric for count program coverage and frequency."
    - name: "total_variance_quantity"
      expr: SUM(CAST(variance_quantity AS DOUBLE))
      comment: "Total absolute quantity variance between system and physical counts — primary inventory accuracy KPI driving shrinkage and write-off decisions."
    - name: "total_inventory_value_variance"
      expr: SUM(CAST(inventory_value_variance_amount AS DOUBLE))
      comment: "Total financial value of inventory variances — used by finance to quantify shrinkage exposure and book inventory adjustments."
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average percentage variance between system and physical counts — key accuracy KPI benchmarked against tolerance thresholds."
    - name: "counts_requiring_adjustment"
      expr: SUM(CASE WHEN adjustment_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of cycle counts requiring inventory adjustments — used to measure the prevalence of inventory inaccuracy."
    - name: "counts_requiring_recount"
      expr: SUM(CASE WHEN recount_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of cycle counts requiring a recount — high recount rate signals process or system accuracy issues."
    - name: "total_counted_quantity"
      expr: SUM(CAST(counted_quantity AS DOUBLE))
      comment: "Total physical quantity counted — used to normalize variance metrics and assess count program scale."
    - name: "total_system_quantity"
      expr: SUM(CAST(system_quantity AS DOUBLE))
      comment: "Total system-recorded quantity at time of count — used with counted quantity to compute aggregate accuracy."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`distribution_wave`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Warehouse wave execution metrics — tracks wave throughput, on-time performance, and operational efficiency for pick/pack/ship waves. Used by DC operations managers to optimize labor allocation and order fulfillment velocity."
  source: "`vibe_consumer_goods_v1`.`distribution`.`wave`"
  dimensions:
    - name: "wave_status"
      expr: wave_status
      comment: "Current execution status of the wave (e.g., planned, in-progress, complete) — used to monitor active wave pipeline."
    - name: "wave_type"
      expr: wave_type
      comment: "Type of wave (e.g., replenishment, promotional, DSD) — used to segment throughput and performance by wave category."
    - name: "strategy"
      expr: strategy
      comment: "Wave release strategy (e.g., FIFO, priority-based) — used to evaluate the effectiveness of different wave planning approaches."
    - name: "priority"
      expr: priority
      comment: "Priority level assigned to the wave — used to ensure high-priority waves are executed first and meet OTIF commitments."
    - name: "is_critical"
      expr: is_critical
      comment: "Whether the wave is flagged as critical (e.g., OTIF-committed orders) — used to track critical wave completion rates."
    - name: "scheduled_start_date"
      expr: DATE_TRUNC('month', scheduled_start_timestamp)
      comment: "Month of scheduled wave start — used for trend analysis of wave volume and throughput over time."
  measures:
    - name: "total_waves"
      expr: COUNT(1)
      comment: "Total number of waves executed — baseline throughput metric for warehouse operations."
    - name: "avg_on_time_pct"
      expr: AVG(CAST(on_time_pct AS DOUBLE))
      comment: "Average on-time completion percentage across all waves — primary wave execution KPI used by DC managers to assess fulfillment velocity."
    - name: "critical_waves"
      expr: SUM(CASE WHEN is_critical = TRUE THEN 1 ELSE 0 END)
      comment: "Count of critical waves — used to track the volume of high-priority fulfillment commitments and ensure adequate resource allocation."
    - name: "completed_waves"
      expr: SUM(CASE WHEN wave_status = 'COMPLETE' THEN 1 ELSE 0 END)
      comment: "Count of fully completed waves — used to measure wave execution throughput and identify bottlenecks."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`distribution_dsd_delivery`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Direct Store Delivery (DSD) execution metrics — tracks delivery performance, merchandising compliance, and return rates for DSD routes. Used by field sales and distribution leadership to manage last-mile delivery effectiveness."
  source: "`vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_delivery`"
  dimensions:
    - name: "delivery_status"
      expr: delivery_status
      comment: "Current status of the DSD delivery (e.g., completed, partial, failed) — used to monitor delivery execution."
    - name: "delivery_exception_code"
      expr: delivery_exception_code
      comment: "Exception code for delivery failures or issues — used to categorize and resolve DSD delivery problems."
    - name: "merchandising_activity_type"
      expr: merchandising_activity_type
      comment: "Type of merchandising activity performed at the store (e.g., shelf reset, display build) — used to track in-store execution compliance."
    - name: "visit_date"
      expr: DATE_TRUNC('month', visit_date)
      comment: "Month of DSD store visit — used for trend analysis of delivery volume and performance."
    - name: "on_time_flag"
      expr: on_time_flag
      comment: "Whether the delivery arrived within the scheduled delivery window — primary on-time KPI for DSD."
    - name: "in_full_flag"
      expr: in_full_flag
      comment: "Whether the delivery was completed in full — primary fill-rate KPI for DSD."
    - name: "otif_compliance_flag"
      expr: otif_compliance_flag
      comment: "Whether the delivery met both on-time and in-full requirements — composite OTIF compliance flag."
    - name: "merchandising_performed_flag"
      expr: merchandising_performed_flag
      comment: "Whether merchandising activities were performed during the delivery visit — used to track in-store execution compliance."
    - name: "temperature_compliant_flag"
      expr: temperature_compliant_flag
      comment: "Whether the delivery maintained required temperature compliance — critical for cold-chain product integrity."
  measures:
    - name: "total_dsd_deliveries"
      expr: COUNT(1)
      comment: "Total number of DSD delivery visits — baseline volume metric for DSD route coverage and throughput."
    - name: "total_delivery_value"
      expr: SUM(CAST(delivery_value_amount AS DOUBLE))
      comment: "Total value of goods delivered via DSD — primary revenue metric for the DSD channel."
    - name: "total_net_delivery_amount"
      expr: SUM(CAST(net_delivery_amount AS DOUBLE))
      comment: "Total net delivery amount after returns and credits — used to measure realized DSD revenue."
    - name: "total_return_credit_amount"
      expr: SUM(CAST(return_credit_amount AS DOUBLE))
      comment: "Total credit issued for returned goods — used to track return rates and their financial impact on DSD revenue."
    - name: "total_cases_delivered"
      expr: SUM(CAST(total_cases_delivered AS DOUBLE))
      comment: "Total cases delivered across all DSD visits — used for route productivity and capacity planning."
    - name: "total_cases_returned"
      expr: SUM(CAST(total_cases_returned AS DOUBLE))
      comment: "Total cases returned at DSD delivery — high return volume signals product quality, freshness, or demand planning issues."
    - name: "otif_compliant_deliveries"
      expr: SUM(CASE WHEN otif_compliance_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of DSD deliveries meeting OTIF requirements — numerator for DSD OTIF compliance rate."
    - name: "merchandising_compliant_deliveries"
      expr: SUM(CASE WHEN merchandising_performed_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of deliveries where merchandising was performed — used to track in-store execution compliance rate."
    - name: "avg_delivery_value"
      expr: AVG(CAST(delivery_value_amount AS DOUBLE))
      comment: "Average delivery value per DSD visit — used to track route productivity and identify underperforming routes."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`distribution_inventory_position`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Distribution inventory position metrics — tracks on-hand stock levels, availability, allocation, and inventory value across distribution facilities and storage locations. Used by supply chain and DC operations to manage stock health and replenishment triggers."
  source: "`vibe_consumer_goods_v1`.`distribution`.`inventory_position`"
  dimensions:
    - name: "inventory_status"
      expr: inventory_status
      comment: "Current status of the inventory (e.g., available, allocated, quarantine, hold) — used to segment usable vs. restricted stock."
    - name: "inventory_condition"
      expr: inventory_condition
      comment: "Physical condition of the inventory (e.g., good, damaged, expired) — used to assess stock quality and write-off exposure."
    - name: "storage_zone"
      expr: storage_zone
      comment: "Storage zone within the facility (e.g., ambient, chilled, frozen) — used to segment inventory by temperature requirement."
    - name: "owner_type"
      expr: owner_type
      comment: "Ownership type of the inventory (e.g., owned, consignment, VMI) — used to segment inventory by ownership for financial reporting."
    - name: "snapshot_date"
      expr: DATE_TRUNC('month', snapshot_timestamp)
      comment: "Month of inventory snapshot — used for trend analysis of stock levels and inventory value over time."
    - name: "replenishment_flag"
      expr: replenishment_flag
      comment: "Whether the inventory position has triggered a replenishment signal — used to monitor stock health and supply chain responsiveness."
    - name: "catch_weight_flag"
      expr: catch_weight_flag
      comment: "Whether the inventory is managed by catch weight — used to segment weight-based inventory for accurate valuation."
  measures:
    - name: "total_quantity_on_hand"
      expr: SUM(CAST(quantity_on_hand AS DOUBLE))
      comment: "Total on-hand inventory quantity across all positions — primary stock level KPI for supply chain and DC operations."
    - name: "total_quantity_available"
      expr: SUM(CAST(quantity_available AS DOUBLE))
      comment: "Total available (unallocated, unreserved) inventory quantity — used to assess fulfillment capacity and identify stock-out risk."
    - name: "total_quantity_allocated"
      expr: SUM(CAST(quantity_allocated AS DOUBLE))
      comment: "Total quantity allocated to open orders — used to track committed inventory and available-to-promise calculations."
    - name: "total_quantity_hold"
      expr: SUM(CAST(quantity_hold AS DOUBLE))
      comment: "Total quantity on hold (quality, regulatory, or operational hold) — used to quantify restricted inventory and its impact on availability."
    - name: "total_quantity_quarantine"
      expr: SUM(CAST(quantity_quarantine AS DOUBLE))
      comment: "Total quantity in quarantine — used to track quality-related inventory restrictions and their supply impact."
    - name: "total_inventory_value"
      expr: SUM(CAST(total_inventory_value AS DOUBLE))
      comment: "Total financial value of inventory on hand — primary balance sheet metric for inventory asset management."
    - name: "avg_cost_per_unit"
      expr: AVG(CAST(cost_per_unit AS DOUBLE))
      comment: "Average cost per inventory unit — used for inventory valuation benchmarking and margin analysis."
    - name: "replenishment_triggered_positions"
      expr: SUM(CASE WHEN replenishment_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of inventory positions with active replenishment signals — used to monitor supply chain responsiveness and prevent stock-outs."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`distribution_returns_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Returns processing metrics — tracks return volumes, credit values, disposition outcomes, and recall-related returns. Used by supply chain, finance, and quality teams to manage reverse logistics costs and product recall exposure."
  source: "`vibe_consumer_goods_v1`.`distribution`.`returns_receipt`"
  dimensions:
    - name: "return_status"
      expr: return_status
      comment: "Current status of the return (e.g., received, inspected, disposed) — used to monitor returns pipeline."
    - name: "return_type"
      expr: return_type
      comment: "Type of return (e.g., customer return, recall, expired, damaged) — used to segment return volume by root cause."
    - name: "return_reason_code"
      expr: return_reason_code
      comment: "Reason code for the return — used to identify systemic quality, demand, or service issues driving returns."
    - name: "disposition_decision"
      expr: disposition_decision
      comment: "Final disposition of returned goods (e.g., resale, rework, destroy) — used to track recovery rates and write-off exposure."
    - name: "receipt_date"
      expr: DATE_TRUNC('month', receipt_timestamp)
      comment: "Month of return receipt — used for trend analysis of return volumes and financial impact."
    - name: "recall_flag"
      expr: recall_flag
      comment: "Whether the return is associated with a product recall — used to track recall-driven return volumes and costs."
    - name: "temperature_compliant_flag"
      expr: temperature_compliant_flag
      comment: "Whether the returned goods maintained temperature compliance — used for cold-chain return quality assessment."
  measures:
    - name: "total_returns"
      expr: COUNT(1)
      comment: "Total number of return receipts — baseline volume metric for reverse logistics operations."
    - name: "total_quantity_returned"
      expr: SUM(CAST(quantity_returned AS DOUBLE))
      comment: "Total quantity of goods returned — primary volume metric for reverse logistics and return rate calculations."
    - name: "total_resalable_quantity"
      expr: SUM(CAST(resalable_quantity AS DOUBLE))
      comment: "Total quantity of returned goods deemed resalable — used to measure recovery rate and offset return costs."
    - name: "total_destroy_quantity"
      expr: SUM(CAST(destroy_quantity AS DOUBLE))
      comment: "Total quantity of returned goods destroyed — used to quantify write-off exposure from returns."
    - name: "total_rework_quantity"
      expr: SUM(CAST(rework_quantity AS DOUBLE))
      comment: "Total quantity of returned goods sent for rework — used to track rework costs and recovery opportunities."
    - name: "total_credit_amount"
      expr: SUM(CAST(credit_amount AS DOUBLE))
      comment: "Total credit value issued for returned goods — primary financial metric for reverse logistics cost management."
    - name: "recall_returns"
      expr: SUM(CASE WHEN recall_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of returns associated with product recalls — used to track recall execution completeness and regulatory compliance."
    - name: "avg_credit_per_return"
      expr: AVG(CAST(credit_amount AS DOUBLE))
      comment: "Average credit value per return receipt — used to benchmark return cost and identify high-value return patterns."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`distribution_dock_appointment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dock appointment scheduling and compliance metrics — tracks appointment adherence, detention time, and dock utilization. Used by DC operations to optimize dock throughput and reduce carrier detention costs."
  source: "`vibe_consumer_goods_v1`.`distribution`.`dock_appointment`"
  dimensions:
    - name: "appointment_status"
      expr: appointment_status
      comment: "Current status of the dock appointment (e.g., scheduled, completed, no-show, cancelled) — used to monitor dock scheduling compliance."
    - name: "appointment_type"
      expr: appointment_type
      comment: "Type of dock appointment (e.g., inbound, outbound, DSD) — used to segment dock utilization by activity type."
    - name: "scheduled_arrival_date"
      expr: DATE_TRUNC('month', scheduled_arrival_date)
      comment: "Month of scheduled dock appointment — used for trend analysis of dock utilization and appointment compliance."
    - name: "otif_compliant_flag"
      expr: otif_compliant_flag
      comment: "Whether the dock appointment met OTIF requirements — used to track dock-level OTIF compliance."
    - name: "hazmat_flag"
      expr: hazmat_flag
      comment: "Whether the appointment involves hazardous materials — used for compliance reporting and dock resource planning."
    - name: "temperature_controlled_flag"
      expr: temperature_controlled_flag
      comment: "Whether the appointment requires temperature-controlled dock handling — used to plan cold-chain dock resources."
    - name: "cross_dock_flag"
      expr: cross_dock_flag
      comment: "Whether the appointment is for cross-docking — used to track cross-dock utilization and throughput."
  measures:
    - name: "total_dock_appointments"
      expr: COUNT(1)
      comment: "Total number of dock appointments — baseline metric for dock scheduling volume and utilization analysis."
    - name: "otif_compliant_appointments"
      expr: SUM(CASE WHEN otif_compliant_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of dock appointments meeting OTIF requirements — numerator for dock OTIF compliance rate."
    - name: "total_actual_weight_kg"
      expr: SUM(CAST(actual_weight_kg AS DOUBLE))
      comment: "Total actual weight processed through dock appointments — used for dock throughput and capacity planning."
    - name: "total_expected_weight_kg"
      expr: SUM(CAST(expected_weight_kg AS DOUBLE))
      comment: "Total expected weight per dock appointments — used with actual weight to compute receiving accuracy."
    - name: "no_show_appointments"
      expr: SUM(CASE WHEN appointment_status = 'NO_SHOW' THEN 1 ELSE 0 END)
      comment: "Count of dock appointments where the carrier did not arrive — used to track carrier reliability and dock idle time."
    - name: "cancelled_appointments"
      expr: SUM(CASE WHEN appointment_status = 'CANCELLED' THEN 1 ELSE 0 END)
      comment: "Count of cancelled dock appointments — used to measure scheduling volatility and dock utilization loss."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`distribution_pack_task`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Packaging throughput and performance metrics"
  source: "`vibe_consumer_goods_v1`.`distribution`.`pack_task`"
  dimensions:
    - name: "outbound_order_id"
      expr: outbound_order_id
      comment: "Outbound order linked to the pack task"
    - name: "pack_status"
      expr: pack_status
      comment: "Current status of the pack task"
    - name: "pack_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Date the pack task was created (day bucket)"
  measures:
    - name: "total_pack_tasks"
      expr: COUNT(1)
      comment: "Total pack task records"
    - name: "average_pack_duration"
      expr: AVG(CAST(pack_duration_minutes AS DOUBLE))
      comment: "Average pack duration in minutes"
    - name: "total_units_packed"
      expr: SUM(CAST(total_unit_quantity AS DOUBLE))
      comment: "Total units packed across tasks"
    - name: "total_gross_weight"
      expr: SUM(CAST(gross_weight_kg AS DOUBLE))
      comment: "Total gross weight of packed items"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`distribution_pick_task`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pick task efficiency and accuracy metrics"
  source: "`vibe_consumer_goods_v1`.`distribution`.`pick_task`"
  dimensions:
    - name: "distribution_facility_id"
      expr: distribution_facility_id
      comment: "Facility where picking occurs"
    - name: "outbound_order_id"
      expr: outbound_order_id
      comment: "Outbound order associated with the pick task"
    - name: "sku_id"
      expr: sku_id
      comment: "SKU being picked"
    - name: "task_status"
      expr: task_status
      comment: "Current status of the pick task"
    - name: "pick_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Date the pick task was created (day bucket)"
  measures:
    - name: "total_pick_tasks"
      expr: COUNT(1)
      comment: "Total pick task records"
    - name: "pick_accuracy_count"
      expr: SUM(CASE WHEN pick_accuracy_flag THEN 1 ELSE 0 END)
      comment: "Number of pick tasks marked as accurate"
    - name: "total_pick_quantity"
      expr: SUM(CAST(pick_quantity AS DOUBLE))
      comment: "Sum of quantity requested for picking"
    - name: "total_picked_quantity"
      expr: SUM(CAST(picked_quantity AS DOUBLE))
      comment: "Sum of quantity actually picked"
    - name: "average_gross_weight"
      expr: AVG(CAST(gross_weight_kg AS DOUBLE))
      comment: "Average gross weight per pick task"
$$;