-- Metric views for domain: logistics | Business: Consumer_Goods | Version: 2 | Generated on: 2026-06-27 07:41:37

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`logistics_carrier_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Carrier performance scorecard metrics tracking OTIF, on-time delivery, tender acceptance, damage rates, and freight spend efficiency. Used by logistics leadership to evaluate, tier, and manage carrier relationships."
  source: "`vibe_consumer_goods_v1`.`logistics`.`carrier_performance`"
  dimensions:
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport (e.g., road, rail, air, ocean) for segmenting carrier performance by transport type."
    - name: "performance_tier"
      expr: performance_tier
      comment: "Carrier performance tier classification (e.g., Gold, Silver, Bronze) assigned based on composite scorecard results."
    - name: "scorecard_rating"
      expr: scorecard_rating
      comment: "Overall scorecard rating label for the carrier in the evaluation period."
    - name: "measurement_period_type"
      expr: measurement_period_type
      comment: "Type of measurement period (e.g., monthly, quarterly, annual) for time-based performance segmentation."
    - name: "network_region"
      expr: network_region
      comment: "Geographic network region covered by the carrier, enabling regional performance benchmarking."
    - name: "service_level"
      expr: service_level
      comment: "Service level commitment (e.g., standard, express, overnight) for performance analysis by service tier."
    - name: "evaluation_period_start"
      expr: evaluation_period_start
      comment: "Start date of the carrier evaluation period for time-series trending."
    - name: "evaluation_period_end"
      expr: evaluation_period_end
      comment: "End date of the carrier evaluation period for time-series trending."
    - name: "carrier_performance_status"
      expr: carrier_performance_status
      comment: "Current status of the carrier performance record (e.g., active, under review, closed)."
  measures:
    - name: "avg_otif_rate_pct"
      expr: AVG(CAST(otif_rate_pct AS DOUBLE))
      comment: "Average On-Time In-Full (OTIF) delivery rate across carriers in the period. Core KPI for supply chain reliability — directly impacts retailer compliance penalties and customer satisfaction."
    - name: "avg_on_time_delivery_rate_pct"
      expr: AVG(CAST(on_time_delivery_rate_pct AS DOUBLE))
      comment: "Average on-time delivery rate across carrier scorecards. Measures punctuality of carrier deliveries against committed schedules."
    - name: "avg_in_full_rate_pct"
      expr: AVG(CAST(in_full_rate_pct AS DOUBLE))
      comment: "Average in-full delivery rate — measures whether carriers deliver complete ordered quantities, impacting fill rate and revenue recognition."
    - name: "avg_tender_acceptance_rate_pct"
      expr: AVG(CAST(tender_acceptance_rate_pct AS DOUBLE))
      comment: "Average tender acceptance rate across carriers. Low acceptance rates signal capacity risk and may require routing guide adjustments or carrier diversification."
    - name: "avg_damage_rate_pct"
      expr: AVG(CAST(damage_rate_pct AS DOUBLE))
      comment: "Average cargo damage rate across carriers. Elevated damage rates drive claims costs, customer chargebacks, and brand risk."
    - name: "total_freight_spend"
      expr: SUM(CAST(total_freight_spend AS DOUBLE))
      comment: "Total freight spend across all carrier performance records in the period. Primary cost driver for logistics budget management."
    - name: "avg_cost_per_shipment"
      expr: AVG(CAST(average_cost_per_shipment AS DOUBLE))
      comment: "Average freight cost per shipment across carriers. Used to benchmark carrier cost efficiency and identify outliers for renegotiation."
    - name: "total_claims_amount"
      expr: SUM(CAST(total_claims_amount AS DOUBLE))
      comment: "Total value of freight claims filed against carriers. High claims amounts indicate carrier quality issues and drive insurance and recovery cost escalation."
    - name: "avg_composite_score"
      expr: AVG(CAST(composite_score AS DOUBLE))
      comment: "Average composite carrier performance score across all scorecards. Holistic KPI used to rank carriers, drive contract renewals, and allocate freight volume."
    - name: "avg_invoice_accuracy_rate_pct"
      expr: AVG(CAST(invoice_accuracy_rate_pct AS DOUBLE))
      comment: "Average invoice accuracy rate across carriers. Billing errors create AP reconciliation overhead and erode carrier trust — a key operational efficiency metric."
    - name: "avg_otif_target_pct"
      expr: AVG(CAST(otif_target_pct AS DOUBLE))
      comment: "Average OTIF target threshold set for carriers. Used alongside actual OTIF rate to measure gap-to-target and trigger performance improvement plans."
    - name: "carrier_scorecard_count"
      expr: COUNT(1)
      comment: "Total number of carrier performance scorecards in the period. Baseline volume metric for normalizing performance aggregates."
    - name: "carriers_under_improvement_plan"
      expr: COUNT(CASE WHEN improvement_plan_flag = TRUE THEN 1 END)
      comment: "Number of carriers currently on a formal performance improvement plan. Indicates the scale of carrier quality risk requiring active management."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`logistics_delivery`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Last-mile and customer delivery performance metrics covering OTIF, on-time, in-full, and exception rates. Used by logistics and customer service leadership to manage delivery quality and customer experience."
  source: "`vibe_consumer_goods_v1`.`logistics`.`delivery`"
  dimensions:
    - name: "delivery_status"
      expr: delivery_status
      comment: "Current status of the delivery (e.g., delivered, failed, pending, in-transit) for operational monitoring."
    - name: "delivery_type"
      expr: delivery_type
      comment: "Type of delivery (e.g., direct store delivery, home delivery, warehouse) for channel-level performance analysis."
    - name: "planned_delivery_date"
      expr: planned_delivery_date
      comment: "Planned delivery date for time-series trending of delivery volumes and performance."
    - name: "actual_delivery_date"
      expr: actual_delivery_date
      comment: "Actual delivery date for comparing against planned dates and computing on-time performance."
    - name: "cold_chain_required"
      expr: cold_chain_required
      comment: "Indicates whether the delivery required cold chain handling — critical for temperature-sensitive consumer goods compliance."
    - name: "exception_code"
      expr: exception_code
      comment: "Exception code recorded at delivery (e.g., refused, damaged, address error) for root cause analysis of delivery failures."
    - name: "goods_condition_code"
      expr: goods_condition_code
      comment: "Condition of goods at delivery (e.g., intact, damaged, partial) for quality and claims analysis."
    - name: "rejection_reason"
      expr: rejection_reason
      comment: "Reason for delivery rejection, used to identify systemic issues in order fulfillment or carrier handling."
  measures:
    - name: "total_deliveries"
      expr: COUNT(1)
      comment: "Total number of delivery records. Baseline volume metric for normalizing all delivery performance rates."
    - name: "otif_deliveries"
      expr: COUNT(CASE WHEN otif_flag = TRUE THEN 1 END)
      comment: "Count of deliveries that were both on-time and in-full. Numerator for OTIF rate calculation — the primary delivery quality KPI."
    - name: "on_time_deliveries"
      expr: COUNT(CASE WHEN is_on_time = TRUE THEN 1 END)
      comment: "Count of deliveries completed on or before the scheduled delivery date. Drives customer satisfaction and retailer compliance scores."
    - name: "in_full_deliveries"
      expr: COUNT(CASE WHEN is_in_full = TRUE THEN 1 END)
      comment: "Count of deliveries where the full ordered quantity was delivered. Impacts revenue recognition and customer fill rate metrics."
    - name: "total_delivered_quantity"
      expr: SUM(CAST(delivered_quantity AS DOUBLE))
      comment: "Total quantity of goods delivered across all delivery records. Used to measure throughput and compare against ordered quantities."
    - name: "total_ordered_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total quantity ordered across all deliveries. Denominator for fill rate calculations and demand fulfillment analysis."
    - name: "total_refused_quantity"
      expr: SUM(CAST(refused_quantity AS DOUBLE))
      comment: "Total quantity refused at delivery. High refusal volumes indicate product quality, documentation, or scheduling issues requiring investigation."
    - name: "total_rejection_quantity"
      expr: SUM(CAST(rejection_quantity AS DOUBLE))
      comment: "Total quantity rejected at delivery. Drives reverse logistics costs and signals upstream quality or compliance failures."
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost_amount AS DOUBLE))
      comment: "Total freight cost incurred across all deliveries. Key cost driver for last-mile logistics budget management."
    - name: "exception_deliveries"
      expr: COUNT(CASE WHEN exception_code IS NOT NULL THEN 1 END)
      comment: "Count of deliveries with a recorded exception. Exception rate is a leading indicator of delivery quality degradation and customer escalation risk."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`logistics_freight_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Freight invoice financial metrics covering spend, variance, dispute rates, and payment performance. Used by finance and logistics teams to manage freight cost control, audit accuracy, and carrier billing compliance."
  source: "`vibe_consumer_goods_v1`.`logistics`.`freight_invoice`"
  dimensions:
    - name: "freight_invoice_status"
      expr: freight_invoice_status
      comment: "Current status of the freight invoice (e.g., pending, approved, disputed, paid) for AP workflow monitoring."
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport on the invoice for cost analysis by transport type."
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of freight invoice (e.g., line haul, accessorial, fuel surcharge) for cost category analysis."
    - name: "service_level"
      expr: service_level
      comment: "Service level associated with the freight invoice for cost-per-service-tier benchmarking."
    - name: "invoice_date"
      expr: invoice_date
      comment: "Date the freight invoice was issued, used for time-series spend trending and aging analysis."
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of the invoice (e.g., unpaid, paid, overdue) for cash flow and AP aging management."
    - name: "origin_country_code"
      expr: origin_country_code
      comment: "Country of shipment origin for geographic freight cost analysis."
    - name: "destination_country_code"
      expr: destination_country_code
      comment: "Country of shipment destination for lane-level cost analysis."
    - name: "audit_status"
      expr: audit_status
      comment: "Freight audit status (e.g., pending, completed, disputed) for tracking invoice accuracy review progress."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms on the invoice for cash flow forecasting and early payment discount analysis."
  measures:
    - name: "total_invoiced_amount"
      expr: SUM(CAST(invoiced_total_amount AS DOUBLE))
      comment: "Total freight invoiced amount across all invoices. Primary freight spend metric for budget tracking and cost control."
    - name: "total_approved_amount"
      expr: SUM(CAST(approved_amount AS DOUBLE))
      comment: "Total approved freight invoice amount after audit. Represents validated freight liability for AP processing."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total variance between contracted and invoiced freight amounts. High variance signals billing errors or contract non-compliance requiring carrier dispute action."
    - name: "total_fuel_surcharge_amount"
      expr: SUM(CAST(fuel_surcharge_amount AS DOUBLE))
      comment: "Total fuel surcharge billed across all freight invoices. Monitored against contracted surcharge schedules to detect overbilling."
    - name: "total_accessorial_amount"
      expr: SUM(CAST(accessorial_amount AS DOUBLE))
      comment: "Total accessorial charges billed (e.g., detention, liftgate, residential). Accessorial spend is a key cost leakage area in freight management."
    - name: "total_line_haul_amount"
      expr: SUM(CAST(line_haul_amount AS DOUBLE))
      comment: "Total line haul freight charges. Core transportation cost component used for rate benchmarking and carrier negotiations."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on freight invoices. Required for accurate freight cost accounting and tax compliance reporting."
    - name: "disputed_invoices"
      expr: COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END)
      comment: "Count of freight invoices flagged for dispute. High dispute volumes indicate systemic billing accuracy issues with carriers."
    - name: "total_invoices"
      expr: COUNT(1)
      comment: "Total number of freight invoices processed. Baseline volume metric for normalizing dispute rates and audit throughput."
    - name: "avg_invoice_amount"
      expr: AVG(CAST(invoiced_total_amount AS DOUBLE))
      comment: "Average freight invoice amount. Used to benchmark per-invoice cost trends and detect anomalous billing patterns."
    - name: "total_contracted_amount"
      expr: SUM(CAST(contracted_amount AS DOUBLE))
      comment: "Total contracted freight amount across invoices. Compared against invoiced amounts to measure carrier billing compliance and contract adherence."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`logistics_freight_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Freight order execution metrics covering cost, weight, volume, and tender performance. Used by logistics operations and procurement to manage freight execution efficiency, cost-to-serve, and carrier tender compliance."
  source: "`vibe_consumer_goods_v1`.`logistics`.`freight_order`"
  dimensions:
    - name: "freight_order_status"
      expr: freight_order_status
      comment: "Current status of the freight order (e.g., tendered, accepted, in-transit, delivered, cancelled) for pipeline monitoring."
    - name: "mode_of_transport"
      expr: mode_of_transport
      comment: "Mode of transport for the freight order (e.g., road, rail, air, ocean) for cost and volume analysis by mode."
    - name: "service_level"
      expr: service_level
      comment: "Service level commitment on the freight order for cost-per-service-tier analysis."
    - name: "load_type"
      expr: load_type
      comment: "Load type (e.g., FTL, LTL, parcel) for freight cost and utilization benchmarking."
    - name: "tender_status"
      expr: tender_status
      comment: "Tender status of the freight order (e.g., accepted, rejected, pending) for routing guide compliance analysis."
    - name: "incoterms_code"
      expr: incoterms_code
      comment: "Incoterms code governing freight responsibility and cost allocation for trade compliance analysis."
    - name: "requested_delivery_date"
      expr: requested_delivery_date
      comment: "Requested delivery date for demand-driven freight planning and on-time performance measurement."
    - name: "order_type"
      expr: order_type
      comment: "Type of freight order (e.g., outbound, inbound, return, transfer) for directional cost analysis."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the freight order for expedite cost analysis and service level compliance."
    - name: "is_cold_chain"
      expr: is_cold_chain
      comment: "Indicates whether the freight order requires cold chain handling — used to segment temperature-sensitive freight costs."
  measures:
    - name: "total_freight_orders"
      expr: COUNT(1)
      comment: "Total number of freight orders. Baseline volume metric for normalizing cost and performance rates."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost_amount AS DOUBLE))
      comment: "Total actual freight cost incurred across all freight orders. Primary cost metric for logistics budget management and variance analysis."
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost_amount AS DOUBLE))
      comment: "Total estimated freight cost at order creation. Compared against actual cost to measure freight cost forecast accuracy."
    - name: "total_fuel_surcharge"
      expr: SUM(CAST(fuel_surcharge_amount AS DOUBLE))
      comment: "Total fuel surcharge across freight orders. Monitored to assess fuel cost exposure and evaluate surcharge contract terms."
    - name: "total_accessorial_charges"
      expr: SUM(CAST(accessorial_charges_amount AS DOUBLE))
      comment: "Total accessorial charges across freight orders. Key cost leakage metric — high accessorials indicate operational inefficiencies (e.g., detention, re-delivery)."
    - name: "total_gross_weight_kg"
      expr: SUM(CAST(gross_weight_kg AS DOUBLE))
      comment: "Total gross weight shipped across all freight orders. Used for carrier capacity planning and cost-per-kg benchmarking."
    - name: "total_volume_m3"
      expr: SUM(CAST(total_volume_m3 AS DOUBLE))
      comment: "Total shipment volume in cubic meters across freight orders. Used for load utilization analysis and volumetric rate benchmarking."
    - name: "avg_actual_cost_per_order"
      expr: AVG(CAST(actual_cost_amount AS DOUBLE))
      comment: "Average actual freight cost per order. Used to benchmark cost efficiency across carriers, lanes, and modes."
    - name: "pod_received_orders"
      expr: COUNT(CASE WHEN pod_received = TRUE THEN 1 END)
      comment: "Count of freight orders with proof of delivery received. POD compliance is a contractual requirement and a prerequisite for invoice payment and revenue recognition."
    - name: "total_agreed_freight_rate"
      expr: SUM(CAST(agreed_freight_rate AS DOUBLE))
      comment: "Total agreed contracted freight rate value across orders. Used to measure contracted vs. actual spend and assess rate compliance."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`logistics_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "End-to-end logistics shipment execution metrics covering cost, weight, volume, OTIF, and cold chain compliance. Used by supply chain leadership to monitor shipment throughput, cost-to-serve, and service quality."
  source: "`vibe_consumer_goods_v1`.`logistics`.`logistics_shipment`"
  dimensions:
    - name: "logistics_shipment_status"
      expr: logistics_shipment_status
      comment: "Current status of the logistics shipment (e.g., planned, in-transit, delivered, exception) for pipeline visibility."
    - name: "mode_of_transport"
      expr: mode_of_transport
      comment: "Mode of transport for the shipment (e.g., road, rail, air, ocean) for cost and performance analysis by mode."
    - name: "service_level"
      expr: service_level
      comment: "Service level of the shipment (e.g., standard, express) for cost-per-service-tier benchmarking."
    - name: "shipment_type"
      expr: shipment_type
      comment: "Type of shipment (e.g., outbound, inbound, return, transfer) for directional flow analysis."
    - name: "planned_ship_date"
      expr: planned_ship_date
      comment: "Planned ship date for time-series shipment volume trending and schedule adherence analysis."
    - name: "actual_ship_date"
      expr: actual_ship_date
      comment: "Actual ship date for on-time departure performance measurement."
    - name: "is_cold_chain"
      expr: is_cold_chain
      comment: "Indicates whether the shipment required cold chain handling — critical for temperature-sensitive product compliance."
    - name: "incoterms_code"
      expr: incoterms_code
      comment: "Incoterms code governing freight responsibility for trade compliance and cost allocation analysis."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the shipment for expedite cost analysis and service level compliance."
    - name: "direction"
      expr: direction
      comment: "Shipment direction (e.g., inbound, outbound) for supply chain flow analysis."
  measures:
    - name: "total_shipments"
      expr: COUNT(1)
      comment: "Total number of logistics shipments. Baseline throughput metric for supply chain capacity and operational planning."
    - name: "otif_shipments"
      expr: COUNT(CASE WHEN otif_on_time = TRUE AND otif_in_full = TRUE THEN 1 END)
      comment: "Count of shipments that were both on-time and in-full. Numerator for OTIF rate — the primary supply chain service level KPI."
    - name: "on_time_shipments"
      expr: COUNT(CASE WHEN otif_on_time = TRUE THEN 1 END)
      comment: "Count of shipments delivered on or before the planned delivery date. Drives customer service levels and retailer compliance scores."
    - name: "in_full_shipments"
      expr: COUNT(CASE WHEN otif_in_full = TRUE THEN 1 END)
      comment: "Count of shipments delivered with complete ordered quantities. Impacts revenue recognition and customer fill rate."
    - name: "total_freight_cost"
      expr: SUM(CAST(total_freight_cost AS DOUBLE))
      comment: "Total freight cost across all logistics shipments. Primary cost-to-serve metric for logistics budget management."
    - name: "total_weight_kg"
      expr: SUM(CAST(total_weight_kg AS DOUBLE))
      comment: "Total shipment weight in kilograms. Used for carrier capacity planning and cost-per-kg efficiency benchmarking."
    - name: "total_volume_m3"
      expr: SUM(CAST(total_volume_m3 AS DOUBLE))
      comment: "Total shipment volume in cubic meters. Used for load utilization analysis and volumetric freight rate benchmarking."
    - name: "avg_freight_cost_per_shipment"
      expr: AVG(CAST(freight_cost_amount AS DOUBLE))
      comment: "Average freight cost per shipment. Key efficiency metric for benchmarking cost-to-serve across carriers, lanes, and modes."
    - name: "pod_received_shipments"
      expr: COUNT(CASE WHEN pod_received = TRUE THEN 1 END)
      comment: "Count of shipments with proof of delivery received. POD compliance is required for invoice payment, revenue recognition, and dispute resolution."
    - name: "exception_shipments"
      expr: COUNT(CASE WHEN exception_code IS NOT NULL THEN 1 END)
      comment: "Count of shipments with a recorded exception code. Exception rate is a leading indicator of service quality degradation and customer escalation risk."
    - name: "total_fuel_surcharge"
      expr: SUM(CAST(fuel_surcharge_amount AS DOUBLE))
      comment: "Total fuel surcharge incurred across shipments. Monitored to assess fuel cost exposure and evaluate surcharge contract terms."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`logistics_shipment_leg`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shipment leg-level transit performance and cost metrics covering transit time, carbon emissions, and freight cost by leg. Used by network design and logistics operations teams to optimize routing, reduce emissions, and manage leg-level costs."
  source: "`vibe_consumer_goods_v1`.`logistics`.`shipment_leg`"
  dimensions:
    - name: "shipment_leg_status"
      expr: shipment_leg_status
      comment: "Current status of the shipment leg (e.g., planned, in-transit, completed, delayed) for real-time network visibility."
    - name: "mode_of_transport"
      expr: mode_of_transport
      comment: "Mode of transport for the leg (e.g., road, rail, air, ocean) for cost and emissions analysis by mode."
    - name: "leg_type"
      expr: leg_type
      comment: "Type of shipment leg (e.g., first mile, middle mile, last mile) for network segment performance analysis."
    - name: "transport_service_type"
      expr: transport_service_type
      comment: "Transport service type (e.g., FTL, LTL, express) for cost benchmarking by service category."
    - name: "origin_country_code"
      expr: origin_country_code
      comment: "Country of origin for the shipment leg for cross-border and lane-level analysis."
    - name: "destination_country_code"
      expr: destination_country_code
      comment: "Country of destination for the shipment leg for lane-level cost and transit time analysis."
    - name: "is_cold_chain"
      expr: is_cold_chain
      comment: "Indicates whether the leg required cold chain handling for temperature-sensitive product compliance analysis."
    - name: "customs_clearance_required"
      expr: customs_clearance_required
      comment: "Indicates whether customs clearance was required for the leg — used to analyze cross-border transit time and cost impacts."
    - name: "freight_audit_status"
      expr: freight_audit_status
      comment: "Freight audit status for the leg (e.g., pending, completed, disputed) for billing accuracy monitoring."
  measures:
    - name: "total_shipment_legs"
      expr: COUNT(1)
      comment: "Total number of shipment legs. Baseline volume metric for network complexity and routing analysis."
    - name: "total_leg_freight_cost"
      expr: SUM(CAST(leg_cost_amount AS DOUBLE))
      comment: "Total freight cost across all shipment legs. Used to identify high-cost network segments and prioritize lane optimization."
    - name: "total_carbon_emissions_kg"
      expr: SUM(CAST(carbon_emissions_kg AS DOUBLE))
      comment: "Total carbon emissions in kilograms across all shipment legs. Critical sustainability KPI for ESG reporting and carbon reduction target tracking."
    - name: "avg_actual_transit_hours"
      expr: AVG(CAST(actual_transit_hours AS DOUBLE))
      comment: "Average actual transit time in hours per shipment leg. Used to benchmark carrier transit performance against planned times and SLA commitments."
    - name: "avg_planned_transit_hours"
      expr: AVG(CAST(planned_transit_hours AS DOUBLE))
      comment: "Average planned transit time in hours per leg. Baseline for transit time variance analysis and network planning."
    - name: "total_distance_km"
      expr: SUM(CAST(leg_distance_km AS DOUBLE))
      comment: "Total distance covered across all shipment legs in kilometers. Used for cost-per-km benchmarking and network footprint analysis."
    - name: "avg_freight_cost_per_leg"
      expr: AVG(CAST(leg_cost_amount AS DOUBLE))
      comment: "Average freight cost per shipment leg. Used to benchmark leg-level cost efficiency across carriers and transport modes."
    - name: "total_accessorial_charges"
      expr: SUM(CAST(accessorial_charges_amount AS DOUBLE))
      comment: "Total accessorial charges across shipment legs. Accessorial cost leakage at the leg level signals operational inefficiencies such as detention or re-routing."
    - name: "total_gross_weight_kg"
      expr: SUM(CAST(gross_weight_kg AS DOUBLE))
      comment: "Total gross weight shipped across all legs. Used for carrier capacity utilization and cost-per-kg efficiency analysis."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`logistics_lane`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Freight lane network metrics covering cost benchmarks, transit times, volume commitments, and carbon intensity. Used by network design and procurement teams to optimize lane assignments, negotiate carrier rates, and reduce emissions."
  source: "`vibe_consumer_goods_v1`.`logistics`.`lane`"
  dimensions:
    - name: "lane_status"
      expr: lane_status
      comment: "Current status of the lane (e.g., active, inactive, under review) for network coverage management."
    - name: "lane_type"
      expr: lane_type
      comment: "Type of lane (e.g., primary, backup, spot) for routing guide and carrier assignment analysis."
    - name: "mode_of_transport"
      expr: mode_of_transport
      comment: "Mode of transport for the lane for cost and transit time benchmarking by mode."
    - name: "origin_country_code"
      expr: origin_country_code
      comment: "Country of origin for the lane for geographic network analysis."
    - name: "destination_country_code"
      expr: destination_country_code
      comment: "Country of destination for the lane for geographic network and cross-border analysis."
    - name: "network_region"
      expr: network_region
      comment: "Network region of the lane for regional cost and performance benchmarking."
    - name: "cross_border"
      expr: cross_border
      comment: "Indicates whether the lane crosses international borders — used to segment cross-border vs. domestic freight costs and compliance requirements."
    - name: "cold_chain_required"
      expr: cold_chain_required
      comment: "Indicates whether the lane requires cold chain handling for temperature-sensitive product routing analysis."
    - name: "service_level"
      expr: service_level
      comment: "Service level commitment on the lane for cost-per-service-tier benchmarking."
    - name: "effective_date"
      expr: effective_date
      comment: "Effective date of the lane for tracking network changes and rate validity periods."
  measures:
    - name: "total_active_lanes"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Total number of active freight lanes in the network. Measures network coverage breadth and routing guide completeness."
    - name: "avg_benchmark_rate_per_km"
      expr: AVG(CAST(benchmark_rate_per_km AS DOUBLE))
      comment: "Average benchmark freight rate per kilometer across lanes. Used to evaluate carrier rate competitiveness and identify overpriced lanes for renegotiation."
    - name: "avg_transit_time_hours"
      expr: AVG(CAST(avg_transit_time_hours AS DOUBLE))
      comment: "Average transit time in hours across lanes. Used to set customer delivery expectations and identify slow lanes requiring carrier or routing changes."
    - name: "total_annual_volume_weight_kg"
      expr: SUM(CAST(annual_volume_weight_kg AS DOUBLE))
      comment: "Total annual freight volume in kilograms across all lanes. Used for carrier volume commitment negotiations and network capacity planning."
    - name: "avg_co2_per_shipment_kg"
      expr: AVG(CAST(co2_per_shipment_kg AS DOUBLE))
      comment: "Average CO2 emissions per shipment across lanes. Key sustainability metric for identifying high-emission lanes and prioritizing modal shift or carrier changes."
    - name: "avg_carbon_emission_factor"
      expr: AVG(CAST(carbon_emission_factor AS DOUBLE))
      comment: "Average carbon emission factor across lanes. Used in network design to evaluate environmental impact of lane and mode selections."
    - name: "avg_distance_km"
      expr: AVG(CAST(distance_km AS DOUBLE))
      comment: "Average lane distance in kilometers. Used for cost-per-km benchmarking and network footprint analysis."
    - name: "avg_otif_target_pct"
      expr: AVG(CAST(otif_target_pct AS DOUBLE))
      comment: "Average OTIF target percentage set for lanes. Used to assess service level ambition across the network and align carrier SLA commitments."
    - name: "total_lanes"
      expr: COUNT(1)
      comment: "Total number of freight lanes defined in the network. Baseline metric for network coverage and routing guide completeness assessment."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`logistics_proof_of_delivery`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Proof of delivery compliance and quality metrics covering damage rates, discrepancy rates, cold chain compliance, and electronic capture rates. Used by logistics and customer service teams to manage delivery confirmation quality and dispute resolution."
  source: "`vibe_consumer_goods_v1`.`logistics`.`delivery`"
  dimensions:
    - name: "pod_source"
      expr: pod_source
      comment: "Source system or method that generated the POD (e.g., mobile app, EDI, manual) for data quality analysis."
    - name: "scheduled_delivery_date"
      expr: scheduled_delivery_date
      comment: "Scheduled delivery date for time-series POD compliance trending."
  measures:
    - name: "total_pod_records"
      expr: COUNT(1)
      comment: "Total number of proof of delivery records. Baseline volume metric for POD compliance rate calculations."
    - name: "electronic_pod_captures"
      expr: COUNT(CASE WHEN electronic_signature_flag = TRUE THEN 1 END)
      comment: "Count of PODs captured electronically. Electronic POD adoption rate is a key operational efficiency and dispute resolution quality metric."
    - name: "otif_pod_count"
      expr: COUNT(CASE WHEN otif_flag = TRUE THEN 1 END)
      comment: "Count of PODs confirming OTIF delivery. Used to validate OTIF performance at the point of delivery confirmation."
    - name: "total_delivered_quantity"
      expr: SUM(CAST(delivered_quantity AS DOUBLE))
      comment: "Total quantity confirmed as delivered across all POD records. Used to reconcile against ordered quantities for fill rate and revenue recognition."
$$;