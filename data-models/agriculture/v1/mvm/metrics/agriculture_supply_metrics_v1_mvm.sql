-- Metric views for domain: supply | Business: Agriculture | Version: 1 | Generated on: 2026-05-01 18:41:06

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`supply_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core shipment execution KPIs covering freight cost efficiency, weight throughput, on-time performance, cold-chain compliance, and FSMA traceability. Primary steering dashboard for supply chain operations leadership."
  source: "`agriculture_ecm`.`supply`.`shipment`"
  dimensions:
    - name: "shipment_status"
      expr: shipment_status
      comment: "Current lifecycle status of the shipment (e.g. In Transit, Delivered, Cancelled) — used to filter active vs. completed shipments."
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport (e.g. Truck, Rail, Ocean, Air) — key dimension for cost and performance benchmarking."
    - name: "origin_country_code"
      expr: origin_country_code
      comment: "Country of shipment origin — enables geographic lane analysis."
    - name: "destination_country_code"
      expr: destination_country_code
      comment: "Country of shipment destination — enables geographic lane analysis."
    - name: "freight_terms"
      expr: freight_terms
      comment: "Freight payment terms (e.g. Prepaid, Collect, Third Party) — affects cost allocation and carrier negotiation."
    - name: "requires_cold_chain"
      expr: requires_cold_chain
      comment: "Boolean flag indicating whether the shipment requires temperature-controlled transport — critical for perishable commodity compliance."
    - name: "fsma_compliant"
      expr: fsma_compliant
      comment: "Boolean flag indicating FSMA Sanitary Transport Rule compliance — regulatory dimension for food safety audits."
    - name: "exception_type"
      expr: exception_type
      comment: "Category of shipment exception (e.g. Delay, Damage, Temperature Breach) — used to triage operational disruptions."
    - name: "scheduled_departure_month"
      expr: DATE_TRUNC('MONTH', scheduled_departure_date)
      comment: "Month of scheduled departure — enables trend analysis of shipment volumes and costs over time."
    - name: "scheduled_arrival_month"
      expr: DATE_TRUNC('MONTH', scheduled_arrival_date)
      comment: "Month of scheduled arrival — used for demand planning and delivery performance trending."
  measures:
    - name: "total_shipments"
      expr: COUNT(1)
      comment: "Total number of shipment records — baseline volume KPI for throughput and capacity planning."
    - name: "total_freight_cost_usd"
      expr: SUM(CAST(freight_cost_usd AS DOUBLE))
      comment: "Total freight expenditure in USD — primary cost KPI for logistics budget management and carrier spend analysis."
    - name: "avg_freight_cost_per_shipment_usd"
      expr: AVG(CAST(freight_cost_usd AS DOUBLE))
      comment: "Average freight cost per shipment in USD — benchmarking KPI for carrier rate negotiations and cost efficiency tracking."
    - name: "total_gross_weight_mt"
      expr: SUM(CAST(gross_weight_mt AS DOUBLE))
      comment: "Total gross weight shipped in metric tonnes — throughput KPI for capacity utilization and logistics network sizing."
    - name: "total_net_weight_mt"
      expr: SUM(CAST(net_weight_mt AS DOUBLE))
      comment: "Total net commodity weight shipped in metric tonnes — revenue-linked volume KPI for commodity flow analysis."
    - name: "avg_freight_cost_per_mt"
      expr: SUM(CAST(freight_cost_usd AS DOUBLE)) / NULLIF(SUM(CAST(net_weight_mt AS DOUBLE)), 0)
      comment: "Freight cost per metric tonne (USD/MT) — efficiency ratio used by logistics and procurement to benchmark carrier rates against commodity volume."
    - name: "total_quantity_bu"
      expr: SUM(CAST(quantity_bu AS DOUBLE))
      comment: "Total commodity quantity shipped in bushels — grain-specific volume KPI for elevator and grain merchandising operations."
    - name: "cold_chain_shipment_count"
      expr: COUNT(CASE WHEN requires_cold_chain = TRUE THEN 1 END)
      comment: "Number of shipments requiring cold-chain transport — used to size refrigerated fleet capacity and monitor perishable commodity flows."
    - name: "fsma_non_compliant_shipment_count"
      expr: COUNT(CASE WHEN fsma_compliant = FALSE THEN 1 END)
      comment: "Number of shipments not meeting FSMA Sanitary Transport compliance — regulatory risk KPI; elevated counts trigger corrective action and potential FDA exposure."
    - name: "fsma_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN fsma_compliant = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of shipments that are FSMA-compliant — headline regulatory KPI for food safety governance and audit readiness."
    - name: "shipments_with_exceptions"
      expr: COUNT(CASE WHEN exception_type IS NOT NULL THEN 1 END)
      comment: "Number of shipments with a recorded exception (delay, damage, temperature breach, etc.) — operational quality KPI; high counts signal carrier or route performance issues."
    - name: "exception_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN exception_type IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of shipments with exceptions — service quality ratio used in carrier scorecards and QBRs to drive corrective action."
    - name: "electronic_signature_capture_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN electronic_signature_captured = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of shipments with electronic proof-of-delivery signature captured — traceability and compliance KPI for FSMA and customer SLA adherence."
    - name: "distinct_carriers_used"
      expr: COUNT(DISTINCT carrier_id)
      comment: "Number of distinct carriers used — carrier diversification KPI; low counts indicate single-source risk, high counts may indicate fragmented spend."
$$;


CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`supply_freight_booking`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Freight booking pipeline KPIs covering booked volume, freight spend commitments, booking status distribution, and cold-chain/hazmat compliance. Used by logistics planners and procurement to manage carrier capacity and cost commitments."
  source: "`agriculture_ecm`.`supply`.`freight_booking`"
  dimensions:
    - name: "booking_status"
      expr: booking_status
      comment: "Current status of the freight booking (e.g. Confirmed, Pending, Cancelled) — used to track booking pipeline health."
    - name: "mode_of_transport"
      expr: mode_of_transport
      comment: "Transport mode for the booking (e.g. Truck, Rail, Ocean) — key dimension for modal cost and capacity analysis."
    - name: "service_level"
      expr: service_level
      comment: "Service level agreed for the booking (e.g. Standard, Expedited, Premium) — used to analyze cost vs. service trade-offs."
    - name: "incoterm_code"
      expr: incoterm_code
      comment: "International commercial terms (e.g. FOB, CIF, DAP) — determines risk and cost transfer point; critical for trade finance and logistics cost allocation."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the freight booking — used for multi-currency spend consolidation and FX exposure analysis."
    - name: "is_food_grade"
      expr: is_food_grade
      comment: "Boolean flag indicating whether the booking requires food-grade transport — compliance dimension for food safety governance."
    - name: "is_hazmat"
      expr: is_hazmat
      comment: "Boolean flag indicating hazardous materials shipment — regulatory compliance dimension for DOT/IATA hazmat reporting."
    - name: "rate_basis"
      expr: rate_basis
      comment: "Basis on which the freight rate is calculated (e.g. Per MT, Per Load, Per KM) — used to normalize cost comparisons across carriers."
    - name: "booking_month"
      expr: DATE_TRUNC('MONTH', booking_timestamp)
      comment: "Month the booking was created — enables trend analysis of booking volumes and freight spend commitments over time."
  measures:
    - name: "total_bookings"
      expr: COUNT(1)
      comment: "Total number of freight bookings — baseline volume KPI for logistics pipeline monitoring."
    - name: "total_freight_amount"
      expr: SUM(CAST(total_freight_amount AS DOUBLE))
      comment: "Total committed freight spend across all bookings — primary cost commitment KPI for logistics budget forecasting."
    - name: "total_base_freight_amount"
      expr: SUM(CAST(base_freight_amount AS DOUBLE))
      comment: "Total base freight charges excluding accessorials — used to isolate core transport cost from surcharges."
    - name: "total_accessorial_amount"
      expr: SUM(CAST(accessorial_amount AS DOUBLE))
      comment: "Total accessorial charges (detention, lumper, fuel surcharge, etc.) — KPI for identifying hidden cost drivers beyond base freight rates."
    - name: "accessorial_as_pct_of_total_freight"
      expr: ROUND(100.0 * SUM(CAST(accessorial_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_freight_amount AS DOUBLE)), 0), 2)
      comment: "Accessorial charges as a percentage of total freight spend — efficiency ratio; high values indicate operational inefficiencies (excessive detention, re-deliveries) that inflate logistics costs."
    - name: "total_booked_weight_kg"
      expr: SUM(CAST(booked_weight_kg AS DOUBLE))
      comment: "Total weight committed across freight bookings in kilograms — capacity utilization KPI for fleet and network planning."
    - name: "total_booked_volume_m3"
      expr: SUM(CAST(booked_volume_m3 AS DOUBLE))
      comment: "Total cubic volume committed across freight bookings — used alongside weight to assess load density and trailer utilization."
    - name: "avg_freight_rate"
      expr: AVG(CAST(freight_rate AS DOUBLE))
      comment: "Average freight rate per booking — carrier rate benchmarking KPI used in contract negotiations and market rate comparisons."
    - name: "avg_freight_cost_per_kg"
      expr: SUM(CAST(total_freight_amount AS DOUBLE)) / NULLIF(SUM(CAST(booked_weight_kg AS DOUBLE)), 0)
      comment: "Average freight cost per kilogram — normalized cost efficiency KPI enabling cross-modal and cross-carrier cost comparisons."
    - name: "cancelled_booking_count"
      expr: COUNT(CASE WHEN booking_status = 'Cancelled' THEN 1 END)
      comment: "Number of cancelled freight bookings — operational risk KPI; high cancellation rates indicate carrier reliability issues or demand volatility."
    - name: "cancellation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN booking_status = 'Cancelled' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of freight bookings that were cancelled — service reliability KPI used in carrier performance reviews and capacity planning."
    - name: "food_grade_booking_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_food_grade = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of bookings requiring food-grade transport — compliance mix KPI for food safety fleet sizing and certification management."
    - name: "distinct_carriers_booked"
      expr: COUNT(DISTINCT carrier_id)
      comment: "Number of distinct carriers engaged across bookings — carrier diversification KPI for supply chain resilience and spend concentration risk."
$$;


CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`supply_carrier`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Carrier performance, compliance, and risk KPIs for the approved carrier network. Used by logistics procurement and compliance teams to manage carrier qualification, scorecarding, and contract decisions."
  source: "`agriculture_ecm`.`supply`.`carrier`"
  dimensions:
    - name: "carrier_status"
      expr: carrier_status
      comment: "Current operational status of the carrier (e.g. Active, Suspended, Inactive) — used to filter the qualified carrier pool."
    - name: "carrier_type"
      expr: carrier_type
      comment: "Type of carrier (e.g. TL, LTL, Intermodal, Ocean) — primary segmentation for modal performance benchmarking."
    - name: "performance_tier"
      expr: performance_tier
      comment: "Carrier performance tier classification (e.g. Preferred, Standard, Probationary) — used to prioritize carrier assignments and contract renewals."
    - name: "country_code"
      expr: country_code
      comment: "Country where the carrier is domiciled — geographic dimension for regional carrier network analysis."
    - name: "cold_chain_capable"
      expr: cold_chain_capable
      comment: "Boolean flag indicating whether the carrier has cold-chain transport capability — critical filter for perishable commodity lane assignments."
    - name: "fsma_sanitary_transport_certified"
      expr: fsma_sanitary_transport_certified
      comment: "Boolean flag indicating FSMA Sanitary Transport Rule certification — regulatory compliance dimension for food-grade carrier qualification."
    - name: "hazmat_certified"
      expr: hazmat_certified
      comment: "Boolean flag indicating DOT hazmat certification — compliance dimension for agrochemical and fertilizer transport qualification."
    - name: "approval_status"
      expr: approval_status
      comment: "Carrier approval status in the vendor qualification process — used to manage the approved carrier list and onboarding pipeline."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Boolean flag indicating an open corrective action against the carrier — risk management dimension for carrier oversight."
  measures:
    - name: "total_carriers"
      expr: COUNT(1)
      comment: "Total number of carriers in the network — baseline KPI for carrier pool sizing and diversification assessment."
    - name: "approved_carrier_count"
      expr: COUNT(CASE WHEN approval_status = 'Approved' THEN 1 END)
      comment: "Number of currently approved carriers — qualified carrier pool size KPI; declining counts signal capacity risk."
    - name: "cold_chain_capable_carrier_count"
      expr: COUNT(CASE WHEN cold_chain_capable = TRUE THEN 1 END)
      comment: "Number of carriers with verified cold-chain capability — fleet capacity KPI for perishable and temperature-sensitive commodity logistics."
    - name: "fsma_certified_carrier_count"
      expr: COUNT(CASE WHEN fsma_sanitary_transport_certified = TRUE THEN 1 END)
      comment: "Number of FSMA Sanitary Transport certified carriers — regulatory compliance KPI; insufficient certified carriers create food safety and FDA audit risk."
    - name: "fsma_certification_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN fsma_sanitary_transport_certified = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of carriers with FSMA Sanitary Transport certification — network-level regulatory compliance rate used in food safety governance reporting."
    - name: "avg_on_time_delivery_rate"
      expr: AVG(CAST(on_time_delivery_rate AS DOUBLE))
      comment: "Average on-time delivery rate across all carriers — headline service performance KPI for carrier scorecarding and SLA management."
    - name: "avg_on_time_pickup_rate"
      expr: AVG(CAST(on_time_pickup_rate AS DOUBLE))
      comment: "Average on-time pickup rate across all carriers — upstream service reliability KPI; low rates cause downstream delivery delays and customer service failures."
    - name: "avg_temperature_excursion_rate"
      expr: AVG(CAST(temperature_excursion_rate AS DOUBLE))
      comment: "Average temperature excursion rate across carriers — cold-chain quality KPI; elevated rates indicate systemic equipment or process failures risking commodity spoilage and food safety violations."
    - name: "avg_damage_claim_rate"
      expr: AVG(CAST(damage_claim_rate AS DOUBLE))
      comment: "Average cargo damage claim rate across carriers — cargo quality KPI used in carrier performance reviews and insurance cost management."
    - name: "avg_compliance_score"
      expr: AVG(CAST(compliance_score AS DOUBLE))
      comment: "Average carrier compliance score — composite regulatory and operational compliance KPI used to rank carriers and trigger qualification reviews."
    - name: "avg_performance_rating"
      expr: AVG(CAST(performance_rating_at_site AS DOUBLE))
      comment: "Average carrier performance rating at site — operational quality KPI from facility-level assessments used in carrier tier classification decisions."
    - name: "carriers_with_corrective_action"
      expr: COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END)
      comment: "Number of carriers with an open corrective action requirement — risk management KPI; high counts indicate systemic carrier quality issues requiring procurement intervention."
    - name: "avg_insurance_coverage_amount"
      expr: AVG(CAST(insurance_coverage_amount AS DOUBLE))
      comment: "Average cargo insurance coverage amount across carriers — risk management KPI ensuring carrier insurance levels are adequate relative to commodity values being transported."
$$;


CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`supply_delivery_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Real-time delivery execution and exception KPIs derived from delivery event tracking. Used by operations and customer service teams to monitor delivery performance, cold-chain integrity, and FSMA traceability compliance."
  source: "`agriculture_ecm`.`supply`.`delivery_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of delivery event (e.g. Pickup, In Transit, Delivered, Exception) — primary dimension for delivery lifecycle stage analysis."
    - name: "event_status"
      expr: event_status
      comment: "Current status of the delivery event — used to identify open, completed, or failed events requiring action."
    - name: "exception_type"
      expr: exception_type
      comment: "Category of delivery exception (e.g. Delay, Temperature Breach, Damage, Customs Hold) — used to triage and prioritize exception resolution."
    - name: "cold_chain_breach"
      expr: cold_chain_breach
      comment: "Boolean flag indicating a cold-chain temperature breach during the delivery event — critical food safety and quality compliance dimension."
    - name: "fsma_compliant"
      expr: fsma_compliant
      comment: "Boolean flag indicating FSMA traceability compliance for the delivery event — regulatory dimension for food safety audit trails."
    - name: "customs_clearance_status"
      expr: customs_clearance_status
      comment: "Customs clearance status for cross-border delivery events — trade compliance dimension affecting delivery lead times and regulatory risk."
    - name: "pod_captured"
      expr: pod_captured
      comment: "Boolean flag indicating proof-of-delivery was captured — customer service and billing compliance dimension."
    - name: "geofence_compliant"
      expr: geofence_compliant
      comment: "Boolean flag indicating the delivery event occurred within the expected geofence boundary — route compliance and security dimension."
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', event_timestamp)
      comment: "Month of the delivery event — time dimension for trend analysis of delivery volumes and exception rates."
  measures:
    - name: "total_delivery_events"
      expr: COUNT(1)
      comment: "Total number of delivery events recorded — baseline throughput KPI for delivery network activity monitoring."
    - name: "cold_chain_breach_count"
      expr: COUNT(CASE WHEN cold_chain_breach = TRUE THEN 1 END)
      comment: "Number of delivery events with a cold-chain temperature breach — food safety KPI; each breach represents potential commodity spoilage, regulatory violation, and customer claim."
    - name: "cold_chain_breach_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN cold_chain_breach = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of delivery events with a cold-chain breach — headline cold-chain integrity KPI for perishable commodity supply chains; drives carrier corrective actions and equipment investment decisions."
    - name: "fsma_non_compliant_event_count"
      expr: COUNT(CASE WHEN fsma_compliant = FALSE THEN 1 END)
      comment: "Number of delivery events not meeting FSMA traceability requirements — regulatory risk KPI; non-compliant events create FDA audit exposure and potential recall liability."
    - name: "fsma_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN fsma_compliant = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of delivery events meeting FSMA traceability compliance — regulatory governance KPI for food safety program management."
    - name: "exception_event_count"
      expr: COUNT(CASE WHEN exception_type IS NOT NULL THEN 1 END)
      comment: "Number of delivery events with a recorded exception — operational quality KPI; high counts indicate systemic carrier, route, or facility performance issues."
    - name: "exception_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN exception_type IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of delivery events with exceptions — service quality ratio used in carrier scorecards and operational steering reviews."
    - name: "pod_capture_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN pod_captured = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of delivery events with proof-of-delivery captured — customer service and billing compliance KPI; low rates create invoice disputes and revenue leakage."
    - name: "avg_temperature_reading_c"
      expr: AVG(CAST(temperature_reading_c AS DOUBLE))
      comment: "Average temperature reading at delivery events in Celsius — cold-chain monitoring KPI for identifying systemic temperature management issues across carriers and routes."
    - name: "geofence_non_compliance_count"
      expr: COUNT(CASE WHEN geofence_compliant = FALSE THEN 1 END)
      comment: "Number of delivery events outside expected geofence boundaries — route compliance and security KPI; elevated counts may indicate unauthorized route deviations or GPS tracking failures."
    - name: "distinct_shipments_with_events"
      expr: COUNT(DISTINCT shipment_id)
      comment: "Number of distinct shipments with at least one delivery event recorded — traceability coverage KPI; gaps indicate shipments without adequate tracking visibility."
$$;


CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`supply_lot_trace`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Commodity lot traceability and food safety KPIs covering FSMA compliance, recall exposure, cold-chain requirements, and PHI (Pre-Harvest Interval) adherence. Critical for food safety governance, regulatory reporting, and recall readiness."
  source: "`agriculture_ecm`.`supply`.`lot_trace`"
  dimensions:
    - name: "lot_status"
      expr: lot_status
      comment: "Current status of the commodity lot (e.g. Active, Quarantined, Disposed, Released) — primary dimension for lot lifecycle management."
    - name: "lot_event_type"
      expr: lot_event_type
      comment: "Type of lot traceability event (e.g. Harvest, Transfer, Processing, Shipment) — used to analyze commodity flow stages."
    - name: "final_disposition"
      expr: final_disposition
      comment: "Final disposition of the lot (e.g. Sold, Destroyed, Returned, Donated) — used for inventory reconciliation and loss analysis."
    - name: "origin_country_code"
      expr: origin_country_code
      comment: "Country of origin for the commodity lot — regulatory and trade compliance dimension for import/export documentation."
    - name: "recall_flag"
      expr: recall_flag
      comment: "Boolean flag indicating the lot is subject to a recall — critical food safety risk dimension for recall management and regulatory reporting."
    - name: "requires_cold_chain"
      expr: requires_cold_chain
      comment: "Boolean flag indicating the lot requires cold-chain handling — compliance dimension for temperature-sensitive commodity management."
    - name: "phi_compliant"
      expr: phi_compliant
      comment: "Boolean flag indicating Pre-Harvest Interval compliance for pesticide application — food safety regulatory dimension for MRL (Maximum Residue Limit) compliance."
    - name: "harvest_month"
      expr: DATE_TRUNC('MONTH', harvest_date)
      comment: "Month of commodity harvest — seasonal production dimension for crop year analysis and supply planning."
    - name: "custody_transfer_month"
      expr: DATE_TRUNC('MONTH', custody_transfer_timestamp)
      comment: "Month of custody transfer — time dimension for tracking commodity flow velocity through the supply chain."
  measures:
    - name: "total_lot_trace_records"
      expr: COUNT(1)
      comment: "Total number of lot traceability records — baseline KPI for FSMA traceability coverage and supply chain visibility."
    - name: "total_quantity_mt"
      expr: SUM(CAST(quantity_mt AS DOUBLE))
      comment: "Total commodity quantity in metric tonnes across all traced lots — volume KPI for supply chain throughput and inventory reconciliation."
    - name: "total_quantity_bu"
      expr: SUM(CAST(quantity_bu AS DOUBLE))
      comment: "Total commodity quantity in bushels across all traced lots — grain-specific volume KPI for elevator and merchandising operations."
    - name: "recall_affected_lot_count"
      expr: COUNT(CASE WHEN recall_flag = TRUE THEN 1 END)
      comment: "Number of lots subject to an active recall — food safety risk KPI; directly drives recall scope, consumer notification, and regulatory reporting obligations."
    - name: "recall_affected_quantity_mt"
      expr: SUM(CASE WHEN recall_flag = TRUE THEN CAST(quantity_mt AS DOUBLE) ELSE 0 END)
      comment: "Total quantity in metric tonnes subject to recall — recall scope KPI used to assess financial exposure, logistics cost of recall execution, and regulatory reporting."
    - name: "phi_non_compliant_lot_count"
      expr: COUNT(CASE WHEN phi_compliant = FALSE THEN 1 END)
      comment: "Number of lots with Pre-Harvest Interval non-compliance — food safety KPI; PHI violations risk MRL exceedances, market rejection, and regulatory penalties."
    - name: "phi_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN phi_compliant = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of lots meeting Pre-Harvest Interval compliance — agrochemical food safety KPI for crop protection program governance."
    - name: "avg_moisture_content_pct"
      expr: AVG(CAST(moisture_content_pct AS DOUBLE))
      comment: "Average moisture content percentage across commodity lots — grain quality KPI; moisture levels directly affect storage risk, grading, and commodity pricing."
    - name: "cold_chain_required_lot_count"
      expr: COUNT(CASE WHEN requires_cold_chain = TRUE THEN 1 END)
      comment: "Number of lots requiring cold-chain handling — logistics capacity planning KPI for refrigerated storage and transport resource allocation."
    - name: "distinct_commodities_traced"
      expr: COUNT(DISTINCT commodity_id)
      comment: "Number of distinct commodities with active lot traceability records — traceability program breadth KPI for FSMA compliance coverage assessment."
    - name: "distinct_origin_fields_traced"
      expr: COUNT(DISTINCT field_id)
      comment: "Number of distinct origin fields represented in lot traces — farm-to-fork traceability depth KPI; broader field coverage reduces recall scope and improves food safety response speed."
$$;


CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`supply_transport_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Transport order execution KPIs covering freight cost, weight and volume utilization, booking status, and FSMA compliance. Used by TMS operations and logistics management to optimize load planning and carrier execution."
  source: "`agriculture_ecm`.`supply`.`transport_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the transport order (e.g. Planned, In Execution, Completed, Cancelled) — primary dimension for order pipeline management."
    - name: "order_type"
      expr: order_type
      comment: "Type of transport order (e.g. Outbound, Inbound, Transfer) — used to segment freight flows by direction and purpose."
    - name: "load_type"
      expr: load_type
      comment: "Load configuration type (e.g. FTL, LTL, Bulk) — key dimension for freight cost benchmarking and carrier assignment optimization."
    - name: "temperature_zone"
      expr: temperature_zone
      comment: "Temperature zone requirement for the transport order (e.g. Ambient, Chilled, Frozen) — compliance dimension for cold-chain fleet assignment."
    - name: "freight_terms"
      expr: freight_terms
      comment: "Freight payment terms for the transport order — cost allocation dimension for logistics spend management."
    - name: "fsma_compliance_status"
      expr: fsma_compliance_status
      comment: "FSMA compliance status of the transport order — regulatory dimension for food safety governance and audit readiness."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the transport order (e.g. Critical, High, Standard) — used to manage execution sequencing and resource allocation."
    - name: "booking_status"
      expr: booking_status
      comment: "Carrier booking confirmation status — used to identify unconfirmed orders at risk of missing pickup windows."
    - name: "order_month"
      expr: DATE_TRUNC('MONTH', order_date)
      comment: "Month the transport order was created — time dimension for volume trend analysis and capacity planning."
  measures:
    - name: "total_transport_orders"
      expr: COUNT(1)
      comment: "Total number of transport orders — baseline volume KPI for TMS workload and logistics network throughput."
    - name: "total_booked_weight_kg"
      expr: SUM(CAST(booked_weight_kg AS DOUBLE))
      comment: "Total weight committed across transport orders in kilograms — capacity utilization KPI for fleet sizing and load planning."
    - name: "total_booked_volume_m3"
      expr: SUM(CAST(booked_volume_m3 AS DOUBLE))
      comment: "Total cubic volume committed across transport orders — used with weight to assess load density and trailer space utilization."
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_rate AS DOUBLE))
      comment: "Total freight rate cost committed across transport orders — logistics spend KPI for budget management and carrier cost tracking."
    - name: "avg_freight_rate_per_order"
      expr: AVG(CAST(freight_rate AS DOUBLE))
      comment: "Average freight rate per transport order — carrier rate benchmarking KPI used in contract negotiations and cost efficiency analysis."
    - name: "avg_freight_cost_per_kg"
      expr: SUM(CAST(freight_rate AS DOUBLE)) / NULLIF(SUM(CAST(booked_weight_kg AS DOUBLE)), 0)
      comment: "Average freight cost per kilogram across transport orders — normalized cost efficiency KPI for cross-carrier and cross-modal cost benchmarking."
    - name: "fsma_non_compliant_order_count"
      expr: COUNT(CASE WHEN fsma_compliance_status != 'Compliant' THEN 1 END)
      comment: "Number of transport orders not meeting FSMA compliance status — regulatory risk KPI; non-compliant orders create food safety audit exposure and potential FDA enforcement risk."
    - name: "unconfirmed_booking_count"
      expr: COUNT(CASE WHEN booking_status != 'Confirmed' THEN 1 END)
      comment: "Number of transport orders without a confirmed carrier booking — operational risk KPI; unconfirmed bookings risk missed pickup windows and customer delivery failures."
    - name: "distinct_routes_utilized"
      expr: COUNT(DISTINCT route_id)
      comment: "Number of distinct routes utilized across transport orders — network utilization KPI for route rationalization and lane optimization decisions."
    - name: "distinct_carriers_assigned"
      expr: COUNT(DISTINCT carrier_id)
      comment: "Number of distinct carriers assigned to transport orders — carrier diversification KPI for supply chain resilience and spend concentration risk management."
$$;


CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`supply_freight_rate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Freight rate structure and competitiveness KPIs for carrier rate management. Used by logistics procurement to benchmark rates, manage rate expiry risk, and optimize lane economics."
  source: "`agriculture_ecm`.`supply`.`freight_rate`"
  dimensions:
    - name: "rate_status"
      expr: rate_status
      comment: "Current status of the freight rate (e.g. Active, Expired, Pending) — used to manage the active rate card and identify expiry risk."
    - name: "rate_type"
      expr: rate_type
      comment: "Type of freight rate (e.g. Spot, Contract, Tariff) — key dimension for rate strategy analysis and cost predictability management."
    - name: "transport_mode"
      expr: transport_mode
      comment: "Transport mode for the rate (e.g. Truck, Rail, Ocean) — modal cost benchmarking dimension."
    - name: "equipment_type"
      expr: equipment_type
      comment: "Equipment type required for the rate (e.g. Dry Van, Reefer, Flatbed) — used to analyze rate differentials by equipment category."
    - name: "origin_country_code"
      expr: origin_country_code
      comment: "Origin country for the freight rate lane — geographic dimension for lane cost analysis."
    - name: "destination_country_code"
      expr: destination_country_code
      comment: "Destination country for the freight rate lane — geographic dimension for lane cost analysis."
    - name: "freight_terms"
      expr: freight_terms
      comment: "Freight payment terms associated with the rate — cost allocation dimension."
    - name: "fsma_compliant"
      expr: fsma_compliant
      comment: "Boolean flag indicating whether the rate is associated with FSMA-compliant transport — regulatory compliance dimension for food-grade rate management."
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the freight rate became effective — time dimension for rate trend analysis and contract cycle management."
  measures:
    - name: "total_active_rates"
      expr: COUNT(CASE WHEN rate_status = 'Active' THEN 1 END)
      comment: "Number of currently active freight rates — rate card coverage KPI; gaps in active rates for key lanes create spot market dependency and cost volatility."
    - name: "avg_base_rate"
      expr: AVG(CAST(base_rate AS DOUBLE))
      comment: "Average base freight rate across the rate card — market rate benchmarking KPI for carrier contract negotiations."
    - name: "avg_fuel_surcharge_rate"
      expr: AVG(CAST(fuel_surcharge_rate AS DOUBLE))
      comment: "Average fuel surcharge rate — cost volatility KPI; fuel surcharges are a major variable cost driver in agricultural logistics."
    - name: "avg_detention_rate_per_hour"
      expr: AVG(CAST(detention_rate_per_hour AS DOUBLE))
      comment: "Average detention rate per hour — operational cost KPI; high detention rates amplify the financial impact of loading/unloading delays at grain elevators and processing facilities."
    - name: "avg_lane_distance_miles"
      expr: AVG(CAST(lane_distance_miles AS DOUBLE))
      comment: "Average lane distance in miles across the rate card — network geography KPI used to normalize rate comparisons and assess haul length economics."
    - name: "avg_commitment_discount_pct"
      expr: AVG(CAST(commitment_discount_pct AS DOUBLE))
      comment: "Average commitment discount percentage negotiated with carriers — procurement effectiveness KPI; higher discounts reflect stronger volume commitments and negotiating leverage."
    - name: "expiring_rates_within_90_days"
      expr: COUNT(CASE WHEN rate_status = 'Active' AND expiry_date <= DATE_ADD(CURRENT_DATE(), 90) THEN 1 END)
      comment: "Number of active freight rates expiring within 90 days — contract renewal risk KPI; unrenewed rates default to spot market pricing, increasing freight cost unpredictability."
    - name: "avg_minimum_charge"
      expr: AVG(CAST(minimum_charge AS DOUBLE))
      comment: "Average minimum freight charge across rates — cost floor KPI for small-shipment economics; high minimums make LTL and partial loads uneconomical."
    - name: "distinct_carriers_with_rates"
      expr: COUNT(DISTINCT carrier_id)
      comment: "Number of distinct carriers with negotiated rates — rate card coverage KPI for carrier diversification and competitive rate benchmarking."
$$;


CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`supply_shipment_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shipment line-level commodity KPIs covering weight, value, moisture quality, and compliance at the SKU/lot level. Used by commodity merchandising, quality, and logistics teams to manage line-level performance and compliance."
  source: "`agriculture_ecm`.`supply`.`shipment_line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Current status of the shipment line (e.g. Shipped, Cancelled, On Hold) — used to filter active vs. completed or problematic lines."
    - name: "temperature_zone"
      expr: temperature_zone
      comment: "Temperature zone requirement for the shipment line — cold-chain compliance dimension for perishable commodity management."
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country of origin for the commodity on the shipment line — trade compliance and COOL (Country of Origin Labeling) regulatory dimension."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the shipment line quantity — used to normalize volume comparisons across commodity types."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the shipment line value — multi-currency analysis dimension for international trade flows."
    - name: "harmonized_tariff_code"
      expr: harmonized_tariff_code
      comment: "Harmonized Tariff Schedule code for the commodity — trade compliance dimension for customs duty calculation and import/export reporting."
    - name: "shipment_line_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month the shipment line was created — time dimension for commodity flow trend analysis."
  measures:
    - name: "total_shipment_lines"
      expr: COUNT(1)
      comment: "Total number of shipment lines — baseline volume KPI for order fulfillment throughput."
    - name: "total_line_value"
      expr: SUM(CAST(line_value AS DOUBLE))
      comment: "Total commodity value across all shipment lines — revenue-linked KPI for shipment value tracking and trade finance documentation."
    - name: "avg_line_value"
      expr: AVG(CAST(line_value AS DOUBLE))
      comment: "Average value per shipment line — commodity pricing KPI used to monitor realized prices against contract benchmarks."
    - name: "total_gross_weight_kg"
      expr: SUM(CAST(gross_weight_kg AS DOUBLE))
      comment: "Total gross weight across shipment lines in kilograms — logistics throughput KPI for freight billing reconciliation."
    - name: "total_net_weight_kg"
      expr: SUM(CAST(net_weight_kg AS DOUBLE))
      comment: "Total net commodity weight across shipment lines in kilograms — revenue-linked volume KPI for commodity settlement and yield analysis."
    - name: "total_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity shipped across all lines — commodity volume KPI for supply chain throughput and inventory reconciliation."
    - name: "avg_moisture_content_pct"
      expr: AVG(CAST(moisture_content_pct AS DOUBLE))
      comment: "Average moisture content percentage across shipment lines — grain quality KPI; moisture levels affect grading, storage risk, and commodity pricing discounts."
    - name: "value_per_net_kg"
      expr: SUM(CAST(line_value AS DOUBLE)) / NULLIF(SUM(CAST(net_weight_kg AS DOUBLE)), 0)
      comment: "Average commodity value per net kilogram — realized price KPI used to benchmark against market prices and contract terms."
    - name: "distinct_commodities_shipped"
      expr: COUNT(DISTINCT commodity_id)
      comment: "Number of distinct commodities shipped — product mix KPI for supply chain diversification and commodity portfolio analysis."
$$;


CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`supply_route`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Freight route network KPIs covering lane economics, transit performance, cold-chain corridor coverage, and seasonal/regulatory constraints. Used by logistics network planners to optimize lane assignments and carrier routing strategies."
  source: "`agriculture_ecm`.`supply`.`route`"
  dimensions:
    - name: "route_status"
      expr: route_status
      comment: "Current operational status of the route (e.g. Active, Inactive, Seasonal) — used to filter the active routing network."
    - name: "route_type"
      expr: route_type
      comment: "Type of route (e.g. Direct, Multi-Stop, Cross-Border) — used to segment lane complexity and cost profiles."
    - name: "transport_mode"
      expr: transport_mode
      comment: "Primary transport mode for the route — modal analysis dimension for network optimization."
    - name: "origin_country_code"
      expr: origin_country_code
      comment: "Origin country of the route — geographic dimension for cross-border lane analysis."
    - name: "destination_country_code"
      expr: destination_country_code
      comment: "Destination country of the route — geographic dimension for cross-border lane analysis."
    - name: "is_cold_chain_corridor"
      expr: is_cold_chain_corridor
      comment: "Boolean flag indicating the route is a designated cold-chain corridor — critical dimension for perishable commodity lane planning."
    - name: "has_border_crossing"
      expr: has_border_crossing
      comment: "Boolean flag indicating the route crosses an international border — trade compliance dimension affecting transit time and customs cost."
    - name: "has_spring_weight_restriction"
      expr: has_spring_weight_restriction
      comment: "Boolean flag indicating spring weight restrictions apply — seasonal operational constraint dimension affecting load planning during thaw season."
    - name: "fsma_compliant"
      expr: fsma_compliant
      comment: "Boolean flag indicating the route meets FSMA Sanitary Transport requirements — regulatory compliance dimension for food-grade lane qualification."
  measures:
    - name: "total_routes"
      expr: COUNT(1)
      comment: "Total number of routes in the network — baseline KPI for logistics network coverage and lane portfolio size."
    - name: "avg_distance_km"
      expr: AVG(CAST(distance_km AS DOUBLE))
      comment: "Average route distance in kilometers — network geography KPI used to normalize freight cost comparisons and assess haul length economics."
    - name: "avg_estimated_transit_hours"
      expr: AVG(CAST(estimated_transit_hours AS DOUBLE))
      comment: "Average estimated transit time in hours across routes — delivery lead time KPI for customer promise management and inventory planning."
    - name: "avg_transit_delay_hours"
      expr: AVG(CAST(avg_transit_delay_hours AS DOUBLE))
      comment: "Average transit delay in hours across routes — route reliability KPI; high delay averages identify problematic lanes requiring carrier or routing changes."
    - name: "avg_freight_cost_per_km"
      expr: AVG(CAST(freight_cost_per_km AS DOUBLE))
      comment: "Average freight cost per kilometer across routes — lane economics KPI for identifying high-cost corridors and prioritizing rate renegotiation."
    - name: "cold_chain_corridor_count"
      expr: COUNT(CASE WHEN is_cold_chain_corridor = TRUE THEN 1 END)
      comment: "Number of designated cold-chain corridors in the network — perishable logistics capacity KPI; insufficient cold-chain corridors constrain fresh produce and dairy supply chains."
    - name: "fsma_compliant_route_count"
      expr: COUNT(CASE WHEN fsma_compliant = TRUE THEN 1 END)
      comment: "Number of FSMA-compliant routes — regulatory network coverage KPI for food safety governance."
    - name: "fsma_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN fsma_compliant = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of routes meeting FSMA compliance — network-level food safety regulatory KPI used in compliance program reporting."
    - name: "routes_with_spring_weight_restriction"
      expr: COUNT(CASE WHEN has_spring_weight_restriction = TRUE THEN 1 END)
      comment: "Number of routes subject to spring weight restrictions — seasonal capacity risk KPI; high counts indicate significant network capacity reduction during spring thaw, affecting harvest logistics planning."
    - name: "cross_border_route_count"
      expr: COUNT(CASE WHEN has_border_crossing = TRUE THEN 1 END)
      comment: "Number of routes with international border crossings — trade compliance complexity KPI for customs resource planning and transit time buffer management."
$$;
