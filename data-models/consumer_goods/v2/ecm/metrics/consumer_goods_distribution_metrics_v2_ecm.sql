-- Metric views for domain: distribution | Business: Consumer Goods | Version: 2 | Generated on: 2026-06-28 00:14:33

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`distribution_cycle_count`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Distribution cycle count accuracy metrics — measures inventory count accuracy, variance, and cycle count program effectiveness. Used by DC operations and finance to manage inventory accuracy and shrinkage."
  source: "`vibe_consumer_goods_v1`.`distribution`.`distribution_cycle_count`"
  dimensions:
    - name: "count_status"
      expr: count_status
      comment: "Status of the cycle count (e.g. pending, in-progress, complete). Used to track count program completion."
    - name: "count_type"
      expr: count_type
      comment: "Type of cycle count (e.g. ABC, random, directed). Used to analyze accuracy by count methodology."
    - name: "distribution_cycle_count_status"
      expr: distribution_cycle_count_status
      comment: "Distribution-domain cycle count status for WMS-level tracking."
    - name: "count_date"
      expr: count_date
      comment: "Date the cycle count was performed. Used for time-series inventory accuracy trending."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for variance value reporting. Required for multi-currency inventory valuation."
  measures:
    - name: "total_cycle_counts"
      expr: COUNT(1)
      comment: "Total number of cycle count records. Baseline metric for cycle count program coverage."
    - name: "total_counted_quantity"
      expr: SUM(CAST(counted_quantity AS DOUBLE))
      comment: "Total units physically counted across all cycle counts. Used to measure count program throughput."
    - name: "total_system_quantity"
      expr: SUM(CAST(system_quantity AS DOUBLE))
      comment: "Total units per system records at time of count. Denominator for inventory accuracy calculations."
    - name: "total_variance_quantity"
      expr: SUM(CAST(variance_quantity AS DOUBLE))
      comment: "Total quantity variance (counted minus system) across all cycle counts. Measures aggregate inventory discrepancy."
    - name: "total_variance_value"
      expr: SUM(CAST(variance_value AS DOUBLE))
      comment: "Total financial value of inventory variance. Direct P&L impact metric for inventory shrinkage management."
    - name: "inventory_accuracy_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN variance_quantity = 0 THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cycle count locations with zero variance. Primary inventory accuracy KPI for DC operations."
    - name: "avg_variance_quantity_per_count"
      expr: AVG(CAST(variance_quantity AS DOUBLE))
      comment: "Average quantity variance per cycle count record. Tracks systemic inventory accuracy trends."
    - name: "avg_variance_value_per_count"
      expr: AVG(CAST(variance_value AS DOUBLE))
      comment: "Average financial variance per cycle count. Used to prioritize high-value accuracy improvement initiatives."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`distribution_dsd_delivery`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Direct Store Delivery (DSD) execution metrics — measures delivery performance, OTIF compliance, and merchandising activity at the store level. Used by field sales and distribution leadership to manage DSD route efficiency and retail execution quality."
  source: "`vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_delivery`"
  dimensions:
    - name: "delivery_status"
      expr: delivery_status
      comment: "Current status of the DSD delivery (e.g. delivered, partial, failed). Used to segment completed vs. exception deliveries."
    - name: "distribution_dsd_delivery_status"
      expr: distribution_dsd_delivery_status
      comment: "Distribution-domain DSD delivery status for WMS-level tracking."
    - name: "delivery_date"
      expr: delivery_date
      comment: "Date of the DSD delivery. Used for time-series delivery volume and performance trending."
    - name: "visit_date"
      expr: visit_date
      comment: "Date of the store visit. Used to track visit frequency and coverage by route."
    - name: "on_time_flag"
      expr: on_time_flag
      comment: "Indicates whether the delivery arrived within the committed time window. Used to compute on-time delivery rate."
    - name: "in_full_flag"
      expr: in_full_flag
      comment: "Indicates whether the full ordered quantity was delivered. Used to compute in-full delivery rate."
    - name: "otif_compliance_flag"
      expr: otif_compliance_flag
      comment: "Indicates whether the delivery met both on-time and in-full criteria. Primary DSD service-level flag."
    - name: "temperature_compliant_flag"
      expr: temperature_compliant_flag
      comment: "Indicates whether the delivery maintained required temperature throughout. Critical for cold-chain DSD compliance."
    - name: "merchandising_performed_flag"
      expr: merchandising_performed_flag
      comment: "Indicates whether merchandising activities were performed during the delivery visit. Tracks retail execution compliance."
    - name: "delivery_exception_code"
      expr: delivery_exception_code
      comment: "Code describing the delivery exception (e.g. store closed, refused delivery). Used for exception root-cause analysis."
  measures:
    - name: "total_dsd_deliveries"
      expr: COUNT(1)
      comment: "Total number of DSD deliveries executed. Baseline throughput metric for DSD route capacity management."
    - name: "total_cases_delivered"
      expr: SUM(CAST(total_cases_delivered AS DOUBLE))
      comment: "Total cases delivered across all DSD stops. Primary volume metric for DSD route productivity."
    - name: "total_cases_returned"
      expr: SUM(CAST(total_cases_returned AS DOUBLE))
      comment: "Total cases returned at DSD stops. Elevated returns signal product quality, freshness, or demand issues."
    - name: "net_cases_delivered"
      expr: SUM((CAST(total_cases_delivered AS DOUBLE)) - (CAST(total_cases_returned AS DOUBLE)))
      comment: "Net cases delivered after returns. True volume throughput metric for DSD route revenue contribution."
    - name: "total_delivery_value"
      expr: SUM(CAST(delivery_value_amount AS DOUBLE))
      comment: "Total value of goods delivered across all DSD stops. Revenue contribution metric for DSD channel."
    - name: "total_invoice_amount"
      expr: SUM(CAST(invoice_amount AS DOUBLE))
      comment: "Total invoiced amount across all DSD deliveries. Used to reconcile delivery value against billing."
    - name: "total_return_credit_amount"
      expr: SUM(CAST(return_credit_amount AS DOUBLE))
      comment: "Total credit issued for returned goods. Tracks financial exposure from DSD returns."
    - name: "net_delivery_amount"
      expr: SUM(CAST(net_delivery_amount AS DOUBLE))
      comment: "Net delivery amount after returns and credits. True revenue realization metric for DSD channel."
    - name: "otif_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN otif_compliance_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of DSD deliveries meeting OTIF criteria. Primary DSD service-level KPI for retail customer compliance."
    - name: "on_time_delivery_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN on_time_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of DSD deliveries arriving within the committed time window."
    - name: "in_full_delivery_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN in_full_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of DSD deliveries fulfilling the full ordered quantity."
    - name: "merchandising_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN merchandising_performed_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of DSD visits where merchandising activities were completed. Tracks retail execution compliance."
    - name: "temperature_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN temperature_compliant_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of DSD deliveries maintaining required temperature. Critical cold-chain compliance KPI."
    - name: "return_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(total_cases_returned AS DOUBLE)) / NULLIF(SUM(CAST(total_cases_delivered AS DOUBLE)), 0), 2)
      comment: "Percentage of delivered cases returned. Elevated return rates signal product quality or demand planning issues."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`distribution_offset_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Distribution carbon offset allocation metrics — measures CO2e emissions, offset coverage, and sustainability cost for distribution operations. Used by sustainability and supply chain leadership to track progress against carbon reduction commitments."
  source: "`vibe_consumer_goods_v1`.`distribution`.`distribution_offset_allocation`"
  dimensions:
    - name: "allocation_status"
      expr: allocation_status
      comment: "Status of the offset allocation (e.g. pending, confirmed, retired). Used to track offset lifecycle."
    - name: "allocation_method"
      expr: allocation_method
      comment: "Method used to allocate offsets (e.g. activity-based, spend-based). Used to assess allocation methodology consistency."
    - name: "emission_scope"
      expr: emission_scope
      comment: "GHG Protocol scope of the emission (Scope 1, 2, or 3). Used to segment emissions by regulatory reporting category."
    - name: "allocation_period"
      expr: allocation_period
      comment: "Reporting period for the offset allocation. Used for period-over-period sustainability performance comparison."
    - name: "allocation_date"
      expr: allocation_date
      comment: "Date the offset was allocated. Used for time-series sustainability cost and coverage trending."
    - name: "allocation_currency"
      expr: allocation_currency
      comment: "Currency of the offset allocation cost. Required for multi-currency sustainability cost reporting."
  measures:
    - name: "total_offset_allocations"
      expr: COUNT(1)
      comment: "Total number of offset allocation records. Baseline metric for offset program activity."
    - name: "total_allocated_co2e_tonnes"
      expr: SUM(CAST(allocated_co2e_tonnes AS DOUBLE))
      comment: "Total CO2-equivalent tonnes allocated to offsets. Primary sustainability metric for distribution carbon footprint management."
    - name: "total_emissions_basis_tonnes"
      expr: SUM(CAST(emissions_basis_tonnes AS DOUBLE))
      comment: "Total emissions basis (gross emissions) in tonnes. Denominator for offset coverage rate calculations."
    - name: "total_offset_quantity_tonnes"
      expr: SUM(CAST(offset_quantity_tonnes AS DOUBLE))
      comment: "Total offset credits purchased/allocated in tonnes. Measures offset procurement volume."
    - name: "total_offset_cost"
      expr: SUM(CAST(offset_cost AS DOUBLE))
      comment: "Total cost of carbon offsets allocated to distribution operations. Sustainability cost metric for budget management."
    - name: "total_allocation_cost"
      expr: SUM(CAST(allocation_cost AS DOUBLE))
      comment: "Total allocation cost across all offset records. Used for sustainability program cost tracking."
    - name: "offset_coverage_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(allocated_co2e_tonnes AS DOUBLE)) / NULLIF(SUM(CAST(emissions_basis_tonnes AS DOUBLE)), 0), 2)
      comment: "Percentage of gross emissions covered by carbon offsets. Key sustainability KPI for net-zero progress tracking."
    - name: "avg_offset_cost_per_tonne"
      expr: ROUND(SUM(CAST(offset_cost AS DOUBLE)) / NULLIF(SUM(CAST(offset_quantity_tonnes AS DOUBLE)), 0), 4)
      comment: "Average cost per tonne of carbon offset. Used to benchmark offset procurement efficiency and market pricing."
    - name: "total_emission_quantity_tco2e"
      expr: SUM(CAST(emission_quantity_tco2e AS DOUBLE))
      comment: "Total emissions in tonnes CO2-equivalent. Used for regulatory reporting and sustainability target tracking."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`distribution_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Distribution shipment execution metrics — tracks freight cost, shipment volume, and delivery performance at the warehouse-outbound level. Used by logistics and supply chain leadership to manage freight spend and service levels."
  source: "`vibe_consumer_goods_v1`.`distribution`.`distribution_shipment`"
  dimensions:
    - name: "shipment_status"
      expr: shipment_status
      comment: "Current status of the shipment (e.g. in-transit, delivered, cancelled), used to filter active vs. completed shipments."
    - name: "distribution_shipment_status"
      expr: distribution_shipment_status
      comment: "Distribution-domain status of the shipment, used for WMS-level status reporting."
    - name: "ship_date"
      expr: ship_date
      comment: "Date the shipment departed the distribution facility. Used for time-series freight cost and volume trending."
    - name: "actual_delivery_date"
      expr: actual_delivery_date
      comment: "Actual date the shipment was delivered. Used to compute transit time and on-time performance."
    - name: "expected_delivery_date"
      expr: expected_delivery_date
      comment: "Expected delivery date at time of shipment. Used as the baseline for on-time delivery measurement."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which freight costs are denominated. Required for multi-currency freight cost reporting."
  measures:
    - name: "total_shipments"
      expr: COUNT(1)
      comment: "Total number of distribution shipments. Baseline volume metric for shipment throughput reporting."
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost AS DOUBLE))
      comment: "Total freight cost across all shipments. Primary cost metric for logistics budget management and carrier negotiation."
    - name: "avg_freight_cost_per_shipment"
      expr: AVG(CAST(freight_cost AS DOUBLE))
      comment: "Average freight cost per shipment. Used to benchmark carrier efficiency and detect cost anomalies."
    - name: "total_shipment_weight_kg"
      expr: SUM(CAST(total_weight_kg AS DOUBLE))
      comment: "Total weight shipped in kilograms. Used to compute cost-per-kg and assess carrier capacity utilization."
    - name: "avg_weight_per_shipment_kg"
      expr: AVG(CAST(total_weight_kg AS DOUBLE))
      comment: "Average shipment weight in kilograms. Tracks load consolidation efficiency over time."
    - name: "on_time_delivery_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN actual_delivery_date <= expected_delivery_date THEN 1 ELSE 0 END) / NULLIF(COUNT(CASE WHEN actual_delivery_date IS NOT NULL AND expected_delivery_date IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of shipments delivered on or before the expected delivery date. Key service-level KPI for distribution operations."
    - name: "total_shipment_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total units shipped across all distribution shipments. Volume throughput metric for DC capacity planning."
    - name: "freight_cost_per_kg"
      expr: ROUND(SUM(CAST(freight_cost AS DOUBLE)) / NULLIF(SUM(CAST(total_weight_kg AS DOUBLE)), 0), 4)
      comment: "Freight cost per kilogram shipped. Efficiency ratio used to benchmark carrier rates and identify cost reduction opportunities."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`distribution_dock_appointment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dock appointment scheduling and compliance metrics — measures dock utilization, appointment adherence, and detention time. Used by DC operations managers to optimize dock throughput and reduce carrier detention costs."
  source: "`vibe_consumer_goods_v1`.`distribution`.`dock_appointment`"
  dimensions:
    - name: "appointment_status"
      expr: appointment_status
      comment: "Status of the dock appointment (e.g. scheduled, arrived, completed, no-show). Used to track appointment adherence."
    - name: "appointment_type"
      expr: appointment_type
      comment: "Type of dock appointment (e.g. inbound, outbound, cross-dock). Used to segment dock utilization by flow direction."
    - name: "dock_appointment_status"
      expr: dock_appointment_status
      comment: "Distribution-domain dock appointment status for WMS-level tracking."
    - name: "scheduled_arrival_date"
      expr: scheduled_arrival_date
      comment: "Scheduled arrival date for the appointment. Used for time-series dock scheduling volume trending."
    - name: "temperature_controlled_flag"
      expr: temperature_controlled_flag
      comment: "Indicates whether the appointment requires temperature-controlled dock. Used to manage cold-chain dock capacity."
    - name: "hazmat_flag"
      expr: hazmat_flag
      comment: "Indicates whether the appointment involves hazardous materials. Used to ensure compliant dock assignment."
    - name: "cross_dock_flag"
      expr: cross_dock_flag
      comment: "Indicates whether the appointment is for cross-docking. Used to measure cross-dock program utilization."
    - name: "otif_compliant_flag"
      expr: otif_compliant_flag
      comment: "Indicates whether the appointment met OTIF criteria. Used to measure dock scheduling contribution to OTIF performance."
  measures:
    - name: "total_dock_appointments"
      expr: COUNT(1)
      comment: "Total number of dock appointments scheduled. Baseline metric for dock scheduling volume and utilization."
    - name: "otif_compliant_appointments"
      expr: SUM(CASE WHEN otif_compliant_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of dock appointments meeting OTIF criteria. Measures dock scheduling contribution to overall OTIF performance."
    - name: "otif_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN otif_compliant_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of dock appointments meeting OTIF criteria. Tracks dock scheduling effectiveness."
    - name: "total_actual_weight_kg"
      expr: SUM(CAST(actual_weight_kg AS DOUBLE))
      comment: "Total actual weight processed through dock appointments. Used for dock throughput capacity planning."
    - name: "total_expected_weight_kg"
      expr: SUM(CAST(expected_weight_kg AS DOUBLE))
      comment: "Total expected weight across dock appointments. Used to measure appointment accuracy and dock planning reliability."
    - name: "on_time_arrival_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN actual_arrival_timestamp <= scheduled_start_timestamp THEN 1 ELSE 0 END) / NULLIF(COUNT(CASE WHEN actual_arrival_timestamp IS NOT NULL AND scheduled_start_timestamp IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of dock appointments where the carrier arrived on time. Measures carrier punctuality and dock scheduling adherence."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`distribution_dsd_delivery_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "DSD delivery line-level metrics tracking SKU-level delivery performance, fill rates, and in-store execution. Enables category managers and field sales to identify product-level DSD gaps and shelf compliance issues."
  source: "`vibe_consumer_goods_v1`.`distribution`.`dsd_delivery_line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Status of the DSD delivery line (e.g., delivered, returned, rejected) for line-level fulfillment analysis."
    - name: "temperature_zone"
      expr: temperature_zone
      comment: "Temperature zone requirement for the delivered SKU for cold chain compliance tracking."
    - name: "cold_chain_compliant_flag"
      expr: cold_chain_compliant_flag
      comment: "Indicates whether cold chain requirements were met for the delivery line."
    - name: "oos_flag"
      expr: oos_flag
      comment: "Indicates whether the SKU was out-of-stock at the store during delivery for OOS rate analysis."
    - name: "planogram_compliance_flag"
      expr: planogram_compliance_flag
      comment: "Indicates whether the SKU was placed according to planogram for in-store execution compliance."
    - name: "shelf_placement_confirmed_flag"
      expr: shelf_placement_confirmed_flag
      comment: "Indicates whether shelf placement was confirmed during the delivery visit."
  measures:
    - name: "total_delivery_lines"
      expr: COUNT(1)
      comment: "Total DSD delivery lines. Baseline for line-level fill rate and SKU coverage analysis."
    - name: "total_ordered_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total quantity ordered by stores via DSD. Denominator for DSD line fill rate."
    - name: "total_delivered_quantity"
      expr: SUM(CAST(delivered_quantity AS DOUBLE))
      comment: "Total quantity delivered to stores via DSD. Numerator for DSD line fill rate."
    - name: "total_returned_quantity"
      expr: SUM(CAST(returned_quantity AS DOUBLE))
      comment: "Total quantity returned by stores during DSD delivery. Measures return rate and product acceptance."
    - name: "total_line_value"
      expr: SUM(CAST(line_value AS DOUBLE))
      comment: "Total value of DSD delivery lines. Measures revenue delivered at SKU level via DSD channel."
    - name: "total_cost_of_goods_sold"
      expr: SUM(CAST(cost_of_goods_sold AS DOUBLE))
      comment: "Total COGS for DSD delivery lines. Used for DSD gross margin analysis."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts applied on DSD delivery lines. Measures promotional and trade discount investment via DSD."
    - name: "oos_lines"
      expr: SUM(CASE WHEN oos_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of DSD lines where the SKU was out-of-stock. High OOS count signals availability and ordering failures."
    - name: "planogram_compliant_lines"
      expr: SUM(CASE WHEN planogram_compliance_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of lines where planogram compliance was confirmed. Measures in-store execution quality."
    - name: "avg_unit_selling_price"
      expr: AVG(CAST(unit_selling_price AS DOUBLE))
      comment: "Average selling price per unit on DSD delivery lines. Tracks price realization and promotional pricing trends."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`distribution_inbound_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inbound receiving performance metrics — measures receipt accuracy, quality compliance, and dock throughput. Used by DC operations managers and procurement to evaluate supplier delivery quality and receiving efficiency."
  source: "`vibe_consumer_goods_v1`.`distribution`.`inbound_receipt`"
  dimensions:
    - name: "receipt_status"
      expr: receipt_status
      comment: "Status of the inbound receipt (e.g. complete, partial, rejected). Used to track receiving completion rates."
    - name: "receipt_type"
      expr: receipt_type
      comment: "Type of inbound receipt (e.g. PO receipt, transfer, return). Used to segment receiving volume by source type."
    - name: "inbound_receipt_status"
      expr: inbound_receipt_status
      comment: "Distribution-domain receipt status for WMS-level tracking."
    - name: "receipt_date"
      expr: receipt_date
      comment: "Date goods were received at the DC. Used for time-series receiving volume and quality trending."
    - name: "quality_inspection_status"
      expr: quality_inspection_status
      comment: "Status of quality inspection for the receipt. Used to track inspection throughput and hold rates."
    - name: "temperature_compliant_flag"
      expr: temperature_compliant_flag
      comment: "Indicates whether the inbound shipment met temperature requirements. Critical for cold-chain compliance reporting."
    - name: "discrepancy_flag"
      expr: discrepancy_flag
      comment: "Indicates whether a quantity or condition discrepancy was found on receipt. Used to measure supplier delivery accuracy."
  measures:
    - name: "total_receipts"
      expr: COUNT(1)
      comment: "Total number of inbound receipts. Baseline metric for DC receiving throughput."
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total units received across all inbound receipts. Primary volume metric for inbound flow management."
    - name: "total_expected_quantity"
      expr: SUM(CAST(expected_quantity AS DOUBLE))
      comment: "Total units expected across all inbound receipts. Denominator for receipt accuracy rate calculations."
    - name: "total_accepted_quantity"
      expr: SUM(CAST(accepted_quantity AS DOUBLE))
      comment: "Total units accepted (not rejected) on receipt. Used to measure supplier quality compliance."
    - name: "total_rejected_quantity"
      expr: SUM(CAST(rejected_quantity AS DOUBLE))
      comment: "Total units rejected on receipt due to quality or condition failures. Tracks supplier quality and cold-chain compliance."
    - name: "receipt_accuracy_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(received_quantity AS DOUBLE)) / NULLIF(SUM(CAST(expected_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of expected quantity actually received. Measures supplier delivery accuracy and ASN reliability."
    - name: "rejection_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(rejected_quantity AS DOUBLE)) / NULLIF(SUM(CAST(received_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of received units rejected due to quality or condition failures. Key supplier quality KPI."
    - name: "discrepancy_receipt_count"
      expr: SUM(CASE WHEN discrepancy_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of receipts with quantity or condition discrepancies. Elevated counts trigger supplier corrective action."
    - name: "discrepancy_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN discrepancy_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of receipts with discrepancies. Tracks supplier delivery reliability over time."
    - name: "temperature_non_compliant_receipts"
      expr: SUM(CASE WHEN temperature_compliant_flag = FALSE THEN 1 ELSE 0 END)
      comment: "Count of receipts failing temperature compliance. Critical cold-chain quality metric with direct food safety implications."
    - name: "otif_compliant_receipts"
      expr: SUM(CASE WHEN otif_compliant_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of inbound receipts meeting OTIF criteria. Measures supplier on-time and in-full delivery performance."
    - name: "total_units_received"
      expr: SUM(CAST(total_units_received AS DOUBLE))
      comment: "Total individual units received across all receipts. Used for DC throughput capacity planning."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`distribution_inbound_receipt_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inbound receipt line-level metrics tracking SKU-level receiving accuracy, damage rates, and variance analysis. Enables procurement and quality teams to manage supplier fill rates and product condition at line level."
  source: "`vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Status of the receipt line (e.g., received, rejected, on-hold) for line-level receiving pipeline analysis."
    - name: "putaway_status"
      expr: putaway_status
      comment: "Putaway status of received goods for warehouse slotting and putaway efficiency tracking."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Quality inspection status at the line level for supplier quality management."
    - name: "condition_code"
      expr: condition_code
      comment: "Condition code of received goods (e.g., good, damaged, expired) for condition-based receiving analysis."
    - name: "quality_hold_flag"
      expr: quality_hold_flag
      comment: "Indicates whether the line is on quality hold for inventory availability impact assessment."
  measures:
    - name: "total_receipt_lines"
      expr: COUNT(1)
      comment: "Total number of inbound receipt lines. Baseline for line-level receiving throughput analysis."
    - name: "total_expected_quantity"
      expr: SUM(CAST(expected_quantity AS DOUBLE))
      comment: "Total quantity expected at line level. Denominator for line fill rate and variance analysis."
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total quantity received at line level. Numerator for line fill rate calculation."
    - name: "total_rejected_quantity"
      expr: SUM(CAST(rejected_quantity AS DOUBLE))
      comment: "Total quantity rejected at line level. Measures supplier quality failure volume."
    - name: "total_damaged_quantity"
      expr: SUM(CAST(damaged_quantity AS DOUBLE))
      comment: "Total quantity received in damaged condition. Drives supplier claims and packaging improvement initiatives."
    - name: "total_variance_quantity_cases"
      expr: SUM(CAST(variance_quantity_cases AS DOUBLE))
      comment: "Total case-level quantity variance between expected and received. Measures supplier delivery accuracy."
    - name: "total_extended_cost"
      expr: SUM(CAST(extended_cost AS DOUBLE))
      comment: "Total extended cost of received goods. Used for inventory valuation and cost-of-goods-received reporting."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost of received items. Tracks cost trends and validates PO pricing compliance."
    - name: "quality_hold_lines"
      expr: SUM(CASE WHEN quality_hold_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of receipt lines placed on quality hold. High hold counts signal systemic supplier quality issues."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`distribution_inventory_position`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Distribution inventory position metrics — measures on-hand stock levels, availability, and inventory health at the DC storage location level. Used by DC operations and supply chain planners to manage stock availability and prevent stockouts."
  source: "`vibe_consumer_goods_v1`.`distribution`.`inventory_position`"
  dimensions:
    - name: "inventory_status"
      expr: inventory_status
      comment: "Status of the inventory (e.g. available, on-hold, quarantine). Used to segment usable vs. restricted inventory."
    - name: "inventory_condition"
      expr: inventory_condition
      comment: "Physical condition of the inventory (e.g. good, damaged, expired). Used to assess inventory quality."
    - name: "inventory_position_status"
      expr: inventory_position_status
      comment: "Distribution-domain inventory position status for WMS-level tracking."
    - name: "stock_status"
      expr: stock_status
      comment: "Stock availability status (e.g. in-stock, low-stock, out-of-stock). Used for replenishment trigger analysis."
    - name: "storage_zone"
      expr: storage_zone
      comment: "Storage zone within the DC (e.g. ambient, refrigerated, frozen). Used to segment inventory by storage requirement."
    - name: "temperature_zone"
      expr: temperature_zone
      comment: "Temperature zone for the inventory position. Used for cold-chain inventory management."
    - name: "owner_type"
      expr: owner_type
      comment: "Type of inventory owner (e.g. company-owned, VMI, consignment). Used to segment inventory by ownership model."
    - name: "last_movement_type"
      expr: last_movement_type
      comment: "Type of last inventory movement (e.g. receipt, pick, transfer). Used to identify stagnant inventory."
  measures:
    - name: "total_on_hand_quantity"
      expr: SUM(CAST(on_hand_quantity AS DOUBLE))
      comment: "Total on-hand inventory quantity across all DC storage positions. Primary stock availability metric."
    - name: "total_available_quantity"
      expr: SUM(CAST(available_quantity AS DOUBLE))
      comment: "Total available (uncommitted) inventory quantity. Used to assess fulfillment capacity for incoming orders."
    - name: "total_allocated_quantity"
      expr: SUM(CAST(allocated_quantity AS DOUBLE))
      comment: "Total inventory quantity allocated to open orders. Used to measure order commitment against available stock."
    - name: "total_reserved_quantity"
      expr: SUM(CAST(quantity_reserved AS DOUBLE))
      comment: "Total inventory quantity reserved. Used to track committed stock that is not yet allocated to specific orders."
    - name: "total_on_hold_quantity"
      expr: SUM(CAST(on_hold_quantity AS DOUBLE))
      comment: "Total inventory quantity on quality or compliance hold. Elevated hold quantities signal quality or regulatory issues."
    - name: "total_inventory_value"
      expr: SUM(CAST(total_inventory_value AS DOUBLE))
      comment: "Total financial value of inventory across all DC positions. Primary inventory asset metric for finance and operations."
    - name: "avg_cost_per_unit"
      expr: AVG(CAST(cost_per_unit AS DOUBLE))
      comment: "Average cost per unit across inventory positions. Used for inventory valuation and margin analysis."
    - name: "availability_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(available_quantity AS DOUBLE)) / NULLIF(SUM(CAST(on_hand_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of on-hand inventory that is available (not allocated, reserved, or on hold). Measures effective inventory utilization."
    - name: "hold_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(on_hold_quantity AS DOUBLE)) / NULLIF(SUM(CAST(on_hand_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of on-hand inventory on quality or compliance hold. Elevated hold rates signal systemic quality issues."
    - name: "total_in_transit_quantity"
      expr: SUM(CAST(in_transit_quantity AS DOUBLE))
      comment: "Total inventory quantity currently in transit to the DC. Used for inbound supply visibility and receiving planning."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`distribution_load_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Load planning efficiency metrics — measures trailer utilization, freight cost estimation, and load planning effectiveness. Used by DC operations and logistics leadership to optimize outbound load consolidation and reduce freight costs."
  source: "`vibe_consumer_goods_v1`.`distribution`.`load_plan`"
  dimensions:
    - name: "load_plan_status"
      expr: load_plan_status
      comment: "Status of the load plan (e.g. planned, loaded, departed). Used to track load plan execution progress."
    - name: "load_type"
      expr: load_type
      comment: "Type of load (e.g. FTL, LTL, DSD). Used to segment freight cost and utilization by load type."
    - name: "load_status"
      expr: load_status
      comment: "Current operational status of the load. Used for real-time load tracking."
    - name: "plan_date"
      expr: plan_date
      comment: "Date the load plan was created. Used for time-series load planning volume and efficiency trending."
    - name: "temperature_controlled_flag"
      expr: temperature_controlled_flag
      comment: "Indicates whether the load requires temperature control. Used to segment cold-chain vs. ambient load planning."
    - name: "hazmat_flag"
      expr: hazmat_flag
      comment: "Indicates whether the load contains hazardous materials. Used to ensure regulatory compliance in load planning."
    - name: "trailer_type"
      expr: trailer_type
      comment: "Type of trailer used for the load. Used to analyze utilization and cost by equipment type."
  measures:
    - name: "total_load_plans"
      expr: COUNT(1)
      comment: "Total number of load plans created. Baseline metric for outbound load planning throughput."
    - name: "total_estimated_freight_cost"
      expr: SUM(CAST(estimated_freight_cost AS DOUBLE))
      comment: "Total estimated freight cost across all load plans. Used for freight budget forecasting and carrier spend management."
    - name: "avg_estimated_freight_cost"
      expr: AVG(CAST(estimated_freight_cost AS DOUBLE))
      comment: "Average estimated freight cost per load plan. Used to benchmark load planning cost efficiency."
    - name: "avg_trailer_utilization_pct"
      expr: AVG(CAST(trailer_utilization_percentage AS DOUBLE))
      comment: "Average trailer utilization percentage across load plans. Primary load consolidation efficiency KPI — low utilization drives excess freight cost."
    - name: "total_load_weight_kg"
      expr: SUM(CAST(total_weight_kg AS DOUBLE))
      comment: "Total weight across all load plans in kilograms. Used for carrier capacity planning and weight-based freight cost analysis."
    - name: "total_load_volume_m3"
      expr: SUM(CAST(total_volume_m3 AS DOUBLE))
      comment: "Total cubic volume across all load plans. Used to measure volumetric utilization and identify consolidation opportunities."
    - name: "avg_utilization_pct"
      expr: AVG(CAST(utilization_pct AS DOUBLE))
      comment: "Average overall utilization percentage per load plan. Tracks load consolidation efficiency over time."
    - name: "high_utilization_load_plans"
      expr: SUM(CASE WHEN trailer_utilization_percentage >= 90 THEN 1 ELSE 0 END)
      comment: "Count of load plans with trailer utilization at or above 90%. Measures how often loads are optimally consolidated."
    - name: "low_utilization_load_plans"
      expr: SUM(CASE WHEN trailer_utilization_percentage < 70 THEN 1 ELSE 0 END)
      comment: "Count of load plans with trailer utilization below 70%. Identifies consolidation opportunities to reduce freight cost."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`distribution_otif_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "On-Time In-Full (OTIF) performance metrics — the primary distribution service-level KPI used by supply chain executives to measure delivery compliance, penalty exposure, and fill-rate efficiency by carrier, facility, and trade account."
  source: "`vibe_consumer_goods_v1`.`distribution`.`otif_event`"
  dimensions:
    - name: "delivery_channel"
      expr: delivery_channel
      comment: "Channel through which the delivery was made (e.g. DSD, DC-to-store, e-commerce), enabling channel-level OTIF benchmarking."
    - name: "failure_category"
      expr: failure_category
      comment: "High-level category of OTIF failure (e.g. carrier, warehouse, demand spike), used to route corrective action."
    - name: "failure_reason_code"
      expr: failure_reason_code
      comment: "Granular reason code for OTIF failure, enabling root-cause drill-down."
    - name: "event_type"
      expr: event_type
      comment: "Type of OTIF event (e.g. on-time, late, short-ship), used to segment performance categories."
    - name: "sla_tier"
      expr: sla_tier
      comment: "SLA tier assigned to the delivery commitment, enabling tiered performance reporting."
    - name: "event_date"
      expr: event_date
      comment: "Date of the OTIF event, used for time-series trending of service-level performance."
    - name: "measurement_date"
      expr: measurement_date
      comment: "Date on which OTIF compliance was measured, used for period-over-period comparison."
    - name: "responsible_party"
      expr: responsible_party
      comment: "Party responsible for the OTIF outcome (carrier, warehouse, supplier), used for accountability reporting."
  measures:
    - name: "total_otif_events"
      expr: COUNT(1)
      comment: "Total number of OTIF events evaluated. Baseline denominator for all OTIF rate calculations."
    - name: "otif_compliant_events"
      expr: SUM(CASE WHEN otif_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of deliveries that were both on-time and in-full. Numerator for OTIF compliance rate."
    - name: "on_time_events"
      expr: SUM(CASE WHEN on_time_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of deliveries that arrived on or before the committed date. Used to isolate timing failures from fill-rate failures."
    - name: "in_full_events"
      expr: SUM(CASE WHEN in_full_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of deliveries where the full ordered quantity was delivered. Used to isolate fill-rate failures from timing failures."
    - name: "otif_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN otif_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deliveries that were both on-time and in-full. Primary OTIF KPI reported to retail customers and executives."
    - name: "on_time_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN on_time_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deliveries arriving on or before the committed date. Isolates timing performance from fill-rate performance."
    - name: "in_full_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN in_full_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deliveries fulfilling the full ordered quantity. Isolates fill-rate performance from timing performance."
    - name: "total_delivered_quantity"
      expr: SUM(CAST(delivered_quantity AS DOUBLE))
      comment: "Total units delivered across all OTIF events. Used to weight OTIF rates by volume."
    - name: "total_ordered_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total units ordered across all OTIF events. Denominator for volume-weighted fill-rate calculations."
    - name: "total_quantity_variance"
      expr: SUM(CAST(quantity_variance AS DOUBLE))
      comment: "Total shortfall in delivered vs. committed quantity. Measures aggregate supply gap exposed to retail customers."
    - name: "avg_fill_rate_pct"
      expr: AVG(CAST(fill_rate_pct AS DOUBLE))
      comment: "Average fill rate percentage across all OTIF events. Tracks trend in order completeness over time."
    - name: "total_retailer_penalty_amount"
      expr: SUM(CAST(retailer_penalty_amount AS DOUBLE))
      comment: "Total financial penalties charged by retailers for OTIF non-compliance. Direct P&L impact metric for executive review."
    - name: "avg_quantity_variance_pct"
      expr: AVG(CAST(quantity_variance_percent AS DOUBLE))
      comment: "Average percentage variance between ordered and delivered quantity. Tracks systemic fill-rate degradation."
    - name: "dispute_events"
      expr: SUM(CASE WHEN dispute_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of OTIF events under dispute. Elevated dispute counts signal systemic measurement or execution disagreements with customers."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`distribution_outbound_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Outbound order fulfillment metrics — measures order volume, fill rates, and fulfillment efficiency from the DC perspective. Used by distribution and sales operations leadership to manage customer order service levels."
  source: "`vibe_consumer_goods_v1`.`distribution`.`outbound_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the outbound order (e.g. open, shipped, cancelled). Used to segment active vs. completed order analysis."
    - name: "order_type"
      expr: order_type
      comment: "Type of outbound order (e.g. replenishment, promotional, DSD). Enables order-type-level performance benchmarking."
    - name: "outbound_order_status"
      expr: outbound_order_status
      comment: "Distribution-domain order status, used for WMS-level order tracking."
    - name: "shipping_method"
      expr: shipping_method
      comment: "Method of shipment (e.g. LTL, FTL, parcel). Used to analyze cost and service-level trade-offs by shipping mode."
    - name: "service_level"
      expr: service_level
      comment: "Contracted service level for the order (e.g. next-day, standard). Used to measure compliance against SLA commitments."
    - name: "order_date"
      expr: order_date
      comment: "Date the outbound order was placed. Used for time-series order volume and fill-rate trending."
    - name: "priority"
      expr: priority
      comment: "Order priority level. Used to ensure high-priority orders are fulfilled first and to measure priority-tier service levels."
    - name: "temperature_controlled_flag"
      expr: temperature_controlled_flag
      comment: "Indicates whether the order requires temperature-controlled handling. Used to segment cold-chain vs. ambient fulfillment performance."
  measures:
    - name: "total_outbound_orders"
      expr: COUNT(1)
      comment: "Total number of outbound orders. Baseline throughput metric for DC order processing capacity."
    - name: "total_order_value"
      expr: SUM(CAST(total_order_value AS DOUBLE))
      comment: "Total value of all outbound orders. Primary revenue-at-risk metric for distribution operations."
    - name: "avg_order_value"
      expr: AVG(CAST(total_order_value AS DOUBLE))
      comment: "Average value per outbound order. Used to track order size trends and identify mix shifts."
    - name: "total_order_quantity"
      expr: SUM(CAST(total_order_quantity AS DOUBLE))
      comment: "Total units ordered across all outbound orders. Volume throughput metric for DC capacity planning."
    - name: "total_shipped_quantity"
      expr: SUM(CAST(total_quantity AS DOUBLE))
      comment: "Total units shipped across all outbound orders. Used with ordered quantity to compute fill rate."
    - name: "avg_fill_rate_pct"
      expr: AVG(CAST(fill_rate_percentage AS DOUBLE))
      comment: "Average fill rate percentage across outbound orders. Measures how completely orders are fulfilled from available inventory."
    - name: "otif_committed_orders"
      expr: SUM(CASE WHEN otif_commitment_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of orders with an OTIF commitment to the customer. Used to size the OTIF-at-risk order book."
    - name: "backorder_orders"
      expr: SUM(CASE WHEN backorder_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of orders with at least one backordered line. Elevated backorder counts signal inventory or supply chain failures."
    - name: "backorder_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN backorder_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of outbound orders that have a backorder. Key service-level risk indicator for supply chain leadership."
    - name: "total_order_weight_kg"
      expr: SUM(CAST(total_order_weight_kg AS DOUBLE))
      comment: "Total weight of all outbound orders in kilograms. Used for carrier capacity planning and freight cost forecasting."
    - name: "total_order_volume_m3"
      expr: SUM(CAST(total_order_volume_m3 AS DOUBLE))
      comment: "Total cubic volume of all outbound orders. Used for trailer utilization planning and DC throughput capacity management."
    - name: "cancelled_orders"
      expr: SUM(CASE WHEN order_status = 'CANCELLED' THEN 1 ELSE 0 END)
      comment: "Count of cancelled outbound orders. Tracks demand volatility and order management process failures."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`distribution_outbound_order_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Outbound order line-level fulfillment metrics tracking pick, pack, and ship accuracy at the SKU level. Enables warehouse managers to identify short-ship patterns, line fill rates, and picking efficiency."
  source: "`vibe_consumer_goods_v1`.`distribution`.`outbound_order_line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Current status of the order line (e.g., open, picked, packed, shipped) for pipeline stage analysis."
    - name: "otif_status"
      expr: otif_status
      comment: "OTIF compliance status at the line level for granular fulfillment performance tracking."
    - name: "requested_ship_date"
      expr: requested_ship_date
      comment: "Requested ship date for the line item for on-time shipment compliance analysis."
    - name: "actual_ship_date"
      expr: actual_ship_date
      comment: "Actual ship date for the line item for delivery variance calculation."
    - name: "temperature_controlled_flag"
      expr: temperature_controlled_flag
      comment: "Indicates whether the line requires temperature-controlled handling for cold chain compliance tracking."
    - name: "dsd_flag"
      expr: dsd_flag
      comment: "Indicates whether the line is fulfilled via Direct Store Delivery for DSD vs. DC channel analysis."
  measures:
    - name: "total_order_lines"
      expr: COUNT(1)
      comment: "Total number of outbound order lines. Baseline for line fill rate and picking productivity calculations."
    - name: "total_ordered_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total quantity ordered across all lines. Denominator for line fill rate and short-ship analysis."
    - name: "total_shipped_quantity"
      expr: SUM(CAST(shipped_quantity AS DOUBLE))
      comment: "Total quantity actually shipped. Numerator for line fill rate; gap vs. ordered quantity reveals short-ships."
    - name: "total_picked_quantity"
      expr: SUM(CAST(picked_quantity AS DOUBLE))
      comment: "Total quantity picked from warehouse locations. Measures picking throughput and accuracy."
    - name: "total_packed_quantity"
      expr: SUM(CAST(packed_quantity AS DOUBLE))
      comment: "Total quantity packed for shipment. Measures packing throughput and identifies pack-to-ship gaps."
    - name: "total_allocated_quantity"
      expr: SUM(CAST(allocated_quantity AS DOUBLE))
      comment: "Total quantity allocated to order lines from inventory. Measures inventory reservation effectiveness."
    - name: "short_ship_lines"
      expr: SUM(CASE WHEN short_ship_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of order lines with short shipments. High short-ship count drives inventory and fulfillment investigations."
    - name: "total_line_value"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total monetary value of outbound order lines. Used for revenue-at-risk and fulfillment value reporting."
    - name: "total_line_weight_kg"
      expr: SUM(CAST(line_weight_kg AS DOUBLE))
      comment: "Total weight of order lines in kilograms. Used for freight cost allocation and load planning."
    - name: "total_line_volume_m3"
      expr: SUM(CAST(line_volume_m3 AS DOUBLE))
      comment: "Total cubic volume of order lines. Used for trailer utilization and cartonization optimization."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`distribution_pack_task`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Packaging throughput and performance metrics"
  source: "`consumer_goods_ecm`.`distribution`.`pack_task`"
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
  comment: "Warehouse picking performance metrics tracking pick accuracy, productivity, and throughput. Used by warehouse operations managers to optimize labor allocation, picking strategies, and order fulfillment speed."
  source: "`vibe_consumer_goods_v1`.`distribution`.`pick_task`"
  dimensions:
    - name: "task_status"
      expr: task_status
      comment: "Current status of the pick task (e.g., assigned, in-progress, completed, exception) for task pipeline visibility."
    - name: "pick_method"
      expr: pick_method
      comment: "Picking method used (e.g., batch, zone, wave, discrete) for picking strategy performance comparison."
    - name: "picking_strategy"
      expr: picking_strategy
      comment: "Picking strategy applied for the task for strategy effectiveness analysis."
    - name: "task_type"
      expr: task_type
      comment: "Type of pick task (e.g., full-case, each, pallet) for task mix and productivity analysis."
    - name: "priority"
      expr: priority
      comment: "Priority level of the pick task for queue management and SLA compliance analysis."
    - name: "dsd_flag"
      expr: dsd_flag
      comment: "Indicates whether the pick task is for a DSD order for DSD vs. DC fulfillment analysis."
    - name: "pick_accuracy_flag"
      expr: pick_accuracy_flag
      comment: "Indicates whether the pick was completed accurately for pick accuracy rate calculation."
  measures:
    - name: "total_pick_tasks"
      expr: COUNT(1)
      comment: "Total number of pick tasks. Baseline for picking throughput and labor productivity analysis."
    - name: "total_pick_quantity"
      expr: SUM(CAST(pick_quantity AS DOUBLE))
      comment: "Total quantity requested to be picked. Denominator for pick fill rate and productivity calculations."
    - name: "total_picked_quantity"
      expr: SUM(CAST(picked_quantity AS DOUBLE))
      comment: "Total quantity actually picked. Numerator for pick accuracy and fill rate metrics."
    - name: "accurate_pick_tasks"
      expr: SUM(CASE WHEN pick_accuracy_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of pick tasks completed with full accuracy. Numerator for pick accuracy rate."
    - name: "total_pick_weight_kg"
      expr: SUM(CAST(gross_weight_kg AS DOUBLE))
      comment: "Total weight picked in kilograms. Used for labor productivity (kg per hour) benchmarking."
    - name: "otif_eligible_tasks"
      expr: SUM(CASE WHEN otif_eligible_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of pick tasks flagged as OTIF-eligible. Used to assess OTIF risk from picking operations."
    - name: "distinct_skus_picked"
      expr: COUNT(DISTINCT sku_id)
      comment: "Count of distinct SKUs picked. Measures assortment breadth handled in picking operations."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`distribution_returns_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Returns processing metrics — measures return volume, disposition outcomes, and credit exposure. Used by DC operations, finance, and commercial teams to manage reverse logistics costs and product recovery value."
  source: "`vibe_consumer_goods_v1`.`distribution`.`returns_receipt`"
  dimensions:
    - name: "return_status"
      expr: return_status
      comment: "Current status of the return (e.g. received, inspected, disposed). Used to track return processing pipeline."
    - name: "return_type"
      expr: return_type
      comment: "Type of return (e.g. customer return, recall, damage). Used to segment return volume by cause."
    - name: "return_reason_code"
      expr: return_reason_code
      comment: "Reason code for the return. Used for root-cause analysis of return drivers."
    - name: "disposition"
      expr: disposition
      comment: "Disposition decision for returned goods (e.g. resalable, destroy, rework). Used to measure recovery rate."
    - name: "returns_receipt_status"
      expr: returns_receipt_status
      comment: "Distribution-domain returns receipt status for WMS-level tracking."
    - name: "received_date"
      expr: received_date
      comment: "Date returned goods were received at the DC. Used for time-series returns volume trending."
    - name: "recall_flag"
      expr: recall_flag
      comment: "Indicates whether the return is associated with a product recall. Used to segregate recall-driven returns for regulatory tracking."
    - name: "temperature_compliant_flag"
      expr: temperature_compliant_flag
      comment: "Indicates whether returned goods maintained temperature compliance. Used for cold-chain return quality assessment."
  measures:
    - name: "total_returns_receipts"
      expr: COUNT(1)
      comment: "Total number of returns receipts processed. Baseline metric for reverse logistics volume."
    - name: "total_returned_quantity"
      expr: SUM(CAST(returned_quantity AS DOUBLE))
      comment: "Total units returned across all returns receipts. Primary volume metric for reverse logistics management."
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total units physically received on return. Used to reconcile return authorizations against actual receipts."
    - name: "total_resalable_quantity"
      expr: SUM(CAST(resalable_quantity AS DOUBLE))
      comment: "Total units assessed as resalable on return. Measures product recovery value from returns."
    - name: "total_destroy_quantity"
      expr: SUM(CAST(destroy_quantity AS DOUBLE))
      comment: "Total units designated for destruction. Measures write-off volume and associated cost exposure."
    - name: "total_rework_quantity"
      expr: SUM(CAST(rework_quantity AS DOUBLE))
      comment: "Total units designated for rework. Measures rework volume and associated processing cost."
    - name: "total_credit_amount"
      expr: SUM(CAST(credit_amount AS DOUBLE))
      comment: "Total credit issued for returned goods. Direct financial exposure metric for returns management."
    - name: "resalable_recovery_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(resalable_quantity AS DOUBLE)) / NULLIF(SUM(CAST(received_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of returned units assessed as resalable. Measures product recovery efficiency in reverse logistics."
    - name: "recall_return_count"
      expr: SUM(CASE WHEN recall_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of returns associated with product recalls. Tracks recall execution completeness and regulatory compliance."
    - name: "avg_credit_per_return"
      expr: AVG(CAST(credit_amount AS DOUBLE))
      comment: "Average credit amount per returns receipt. Used to benchmark return cost and identify high-value return patterns."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`distribution_wave`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Warehouse wave management metrics — measures wave throughput, on-time performance, and order processing efficiency. Used by DC operations managers to optimize pick-and-pack labor allocation and meet outbound shipping windows."
  source: "`vibe_consumer_goods_v1`.`distribution`.`wave`"
  dimensions:
    - name: "wave_status"
      expr: wave_status
      comment: "Current status of the wave (e.g. released, in-progress, complete). Used to track wave execution progress."
    - name: "wave_type"
      expr: wave_type
      comment: "Type of wave (e.g. DSD, replenishment, promotional). Used to segment wave performance by fulfillment type."
    - name: "strategy"
      expr: strategy
      comment: "Wave picking strategy (e.g. zone, batch, cluster). Used to compare efficiency across picking methodologies."
    - name: "wave_date"
      expr: wave_date
      comment: "Date the wave was executed. Used for time-series wave throughput and on-time performance trending."
    - name: "is_critical"
      expr: is_critical
      comment: "Indicates whether the wave contains critical/priority orders. Used to ensure critical waves are prioritized in scheduling."
  measures:
    - name: "total_waves"
      expr: COUNT(1)
      comment: "Total number of waves executed. Baseline throughput metric for DC wave management."
    - name: "total_units_picked"
      expr: SUM(CAST(total_units AS DOUBLE))
      comment: "Total units processed across all waves. Primary volume throughput metric for DC labor productivity."
    - name: "avg_on_time_pct"
      expr: AVG(CAST(on_time_pct AS DOUBLE))
      comment: "Average on-time completion percentage across waves. Measures wave scheduling effectiveness and labor sufficiency."
    - name: "total_wave_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total value of orders processed through waves. Used to measure revenue throughput by wave type and strategy."
    - name: "avg_units_per_wave"
      expr: AVG(CAST(total_units AS DOUBLE))
      comment: "Average units processed per wave. Used to benchmark wave sizing and labor allocation efficiency."
    - name: "critical_wave_count"
      expr: SUM(CASE WHEN is_critical = TRUE THEN 1 ELSE 0 END)
      comment: "Count of critical/priority waves. Elevated counts signal demand spikes or order prioritization issues requiring management attention."
$$;
