-- Metric views for domain: logistics | Business: Automotive | Version: 2 | Generated on: 2026-07-14 01:46:32

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`logistics_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core shipment performance metrics tracking on-time delivery, freight costs, and shipment volumes across transport modes and lanes"
  source: "`vibe_automotive_v1`.`logistics`.`shipment`"
  dimensions:
    - name: "shipment_status"
      expr: shipment_status
      comment: "Current status of the shipment (in-transit, delivered, delayed, etc.)"
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transportation (road, rail, sea, air, multimodal)"
    - name: "origin_location"
      expr: origin_location
      comment: "Shipment origin location code or name"
    - name: "destination_location"
      expr: destination_location
      comment: "Shipment destination location code or name"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Regulatory compliance status of the shipment"
    - name: "otd_flag"
      expr: otd_flag
      comment: "On-time delivery flag (true if delivered on time)"
    - name: "hazardous_material_flag"
      expr: hazardous_material_flag
      comment: "Indicates if shipment contains hazardous materials"
    - name: "export_import_flag"
      expr: export_import_flag
      comment: "Indicates if shipment is export/import (cross-border)"
    - name: "planned_departure_month"
      expr: DATE_TRUNC('MONTH', planned_departure_date)
      comment: "Month of planned departure for time-series analysis"
    - name: "actual_arrival_month"
      expr: DATE_TRUNC('MONTH', actual_arrival_timestamp)
      comment: "Month of actual arrival for time-series analysis"
  measures:
    - name: "total_shipments"
      expr: COUNT(1)
      comment: "Total number of shipments"
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost AS DOUBLE))
      comment: "Total freight cost across all shipments"
    - name: "avg_freight_cost_per_shipment"
      expr: AVG(CAST(freight_cost AS DOUBLE))
      comment: "Average freight cost per shipment"
    - name: "total_shipment_volume_cbm"
      expr: SUM(CAST(volume_cbm AS DOUBLE))
      comment: "Total shipment volume in cubic meters"
    - name: "total_shipment_weight_kg"
      expr: SUM(CAST(weight_kg AS DOUBLE))
      comment: "Total shipment weight in kilograms"
    - name: "on_time_delivery_rate"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN otd_flag = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of shipments delivered on time"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount applied to shipments"
    - name: "net_freight_cost"
      expr: SUM(CAST(net_cost AS DOUBLE))
      comment: "Total net freight cost after discounts"
    - name: "hazmat_shipment_count"
      expr: SUM(CAST(CASE WHEN hazardous_material_flag = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Count of shipments containing hazardous materials"
    - name: "cross_border_shipment_count"
      expr: SUM(CAST(CASE WHEN export_import_flag = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Count of cross-border (export/import) shipments"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`logistics_carrier_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Carrier performance KPIs tracking on-time delivery rates, transit times, damage rates, and cost efficiency by carrier and lane"
  source: "`vibe_automotive_v1`.`logistics`.`carrier_performance`"
  dimensions:
    - name: "performance_month"
      expr: DATE_TRUNC('MONTH', performance_month)
      comment: "Month of performance measurement"
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transportation for this performance record"
    - name: "lane_code"
      expr: lane_code
      comment: "Transport lane identifier"
    - name: "lane_type"
      expr: lane_type
      comment: "Type of transport lane (domestic, international, regional)"
    - name: "overall_rating"
      expr: overall_rating
      comment: "Overall carrier performance rating"
    - name: "carrier_performance_status"
      expr: carrier_performance_status
      comment: "Status of carrier performance record"
  measures:
    - name: "total_performance_records"
      expr: COUNT(1)
      comment: "Total number of carrier performance records"
    - name: "avg_on_time_delivery_rate"
      expr: AVG(CAST(on_time_delivery_rate_pct AS DOUBLE))
      comment: "Average on-time delivery rate percentage across carriers"
    - name: "avg_otd_rate"
      expr: AVG(CAST(otd_rate_pct AS DOUBLE))
      comment: "Average OTD rate percentage"
    - name: "avg_transit_days"
      expr: AVG(CAST(average_transit_days AS DOUBLE))
      comment: "Average transit time in days"
    - name: "avg_cost_per_shipment"
      expr: AVG(CAST(cost_per_shipment_usd AS DOUBLE))
      comment: "Average cost per shipment in USD"
    - name: "total_distance_km"
      expr: SUM(CAST(total_distance_km AS DOUBLE))
      comment: "Total distance traveled in kilometers"
    - name: "avg_fuel_consumption"
      expr: AVG(CAST(fuel_consumption_l_per_100km AS DOUBLE))
      comment: "Average fuel consumption in liters per 100 km"
    - name: "avg_transit_time_compliance"
      expr: AVG(CAST(transit_time_compliance_pct AS DOUBLE))
      comment: "Average transit time compliance percentage"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`logistics_freight_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Freight invoice financial metrics tracking invoiced amounts, payment status, variances, and cost allocation by carrier and lane"
  source: "`vibe_automotive_v1`.`logistics`.`freight_invoice`"
  dimensions:
    - name: "freight_invoice_status"
      expr: freight_invoice_status
      comment: "Status of the freight invoice"
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of the invoice"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the invoice"
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transportation for invoiced shipment"
    - name: "lane_code"
      expr: lane_code
      comment: "Transport lane code"
    - name: "cost_type"
      expr: cost_type
      comment: "Type of freight cost"
    - name: "invoice_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month of invoice date"
    - name: "payment_due_month"
      expr: DATE_TRUNC('MONTH', payment_due_date)
      comment: "Month of payment due date"
  measures:
    - name: "total_invoices"
      expr: COUNT(1)
      comment: "Total number of freight invoices"
    - name: "total_invoiced_amount"
      expr: SUM(CAST(invoiced_amount AS DOUBLE))
      comment: "Total invoiced amount across all freight invoices"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net amount after discounts and adjustments"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount applied to invoices"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on freight invoices"
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total variance between agreed rate and invoiced amount"
    - name: "avg_invoiced_amount"
      expr: AVG(CAST(invoiced_amount AS DOUBLE))
      comment: "Average invoiced amount per freight invoice"
    - name: "avg_agreed_rate"
      expr: AVG(CAST(agreed_rate AS DOUBLE))
      comment: "Average agreed freight rate"
    - name: "invoice_variance_rate"
      expr: ROUND(100.0 * SUM(CAST(variance_amount AS DOUBLE)) / NULLIF(SUM(CAST(invoiced_amount AS DOUBLE)), 0), 2)
      comment: "Percentage variance between invoiced and agreed amounts"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`logistics_vehicle_transport_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vehicle transport order metrics tracking order volumes, on-time delivery, transport costs, and emissions by mode and destination"
  source: "`vibe_automotive_v1`.`logistics`.`vehicle_transport_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Status of the vehicle transport order"
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transportation for vehicle delivery"
    - name: "priority"
      expr: priority
      comment: "Priority level of the transport order"
    - name: "on_time_delivery_flag"
      expr: on_time_delivery_flag
      comment: "Flag indicating if delivery was on time"
    - name: "is_expedited"
      expr: is_expedited
      comment: "Flag indicating if order is expedited"
    - name: "is_hazardous"
      expr: is_hazardous
      comment: "Flag indicating if shipment contains hazardous materials"
    - name: "export_import_flag"
      expr: export_import_flag
      comment: "Flag indicating cross-border shipment"
    - name: "order_created_month"
      expr: DATE_TRUNC('MONTH', order_created_timestamp)
      comment: "Month when transport order was created"
    - name: "delivery_month"
      expr: DATE_TRUNC('MONTH', delivery_date)
      comment: "Month of actual delivery"
  measures:
    - name: "total_transport_orders"
      expr: COUNT(1)
      comment: "Total number of vehicle transport orders"
    - name: "total_transport_cost_gross"
      expr: SUM(CAST(transport_cost_gross AS DOUBLE))
      comment: "Total gross transport cost"
    - name: "total_transport_cost_net"
      expr: SUM(CAST(transport_cost_net AS DOUBLE))
      comment: "Total net transport cost after discounts"
    - name: "total_transport_cost_tax"
      expr: SUM(CAST(transport_cost_tax AS DOUBLE))
      comment: "Total tax on transport costs"
    - name: "avg_transport_cost_per_order"
      expr: AVG(CAST(transport_cost_net AS DOUBLE))
      comment: "Average net transport cost per order"
    - name: "total_distance_km"
      expr: SUM(CAST(distance_km AS DOUBLE))
      comment: "Total distance traveled in kilometers"
    - name: "total_co2_emissions_kg"
      expr: SUM(CAST(emission_co2_kg AS DOUBLE))
      comment: "Total CO2 emissions in kilograms"
    - name: "avg_co2_per_km"
      expr: AVG(CAST(emission_co2_kg AS DOUBLE) / NULLIF(CAST(distance_km AS DOUBLE), 0))
      comment: "Average CO2 emissions per kilometer"
    - name: "on_time_delivery_rate"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN on_time_delivery_flag = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of vehicle transport orders delivered on time"
    - name: "expedited_order_count"
      expr: SUM(CAST(CASE WHEN is_expedited = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Count of expedited transport orders"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`logistics_in_transit_inventory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "In-transit inventory metrics tracking inventory value, transit times, delays, and environmental impact of goods in motion"
  source: "`vibe_automotive_v1`.`logistics`.`in_transit_inventory`"
  dimensions:
    - name: "transit_status"
      expr: transit_status
      comment: "Current status of in-transit inventory"
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transportation"
    - name: "customs_status"
      expr: customs_status
      comment: "Customs clearance status"
    - name: "load_type"
      expr: load_type
      comment: "Type of load (full container, LCL, etc.)"
    - name: "hazardous_material_flag"
      expr: hazardous_material_flag
      comment: "Flag indicating hazardous materials"
    - name: "temperature_control_flag"
      expr: temperature_control_flag
      comment: "Flag indicating temperature-controlled shipment"
    - name: "estimated_arrival_month"
      expr: DATE_TRUNC('MONTH', estimated_arrival_date)
      comment: "Month of estimated arrival"
    - name: "actual_arrival_month"
      expr: DATE_TRUNC('MONTH', actual_arrival_date)
      comment: "Month of actual arrival"
  measures:
    - name: "total_in_transit_items"
      expr: COUNT(1)
      comment: "Total number of in-transit inventory items"
    - name: "total_transport_cost"
      expr: SUM(CAST(transport_cost_amount AS DOUBLE))
      comment: "Total transport cost for in-transit inventory"
    - name: "avg_transport_cost"
      expr: AVG(CAST(transport_cost_amount AS DOUBLE))
      comment: "Average transport cost per in-transit item"
    - name: "total_volume_cubic_meters"
      expr: SUM(CAST(volume_cubic_meters AS DOUBLE))
      comment: "Total volume of in-transit inventory in cubic meters"
    - name: "total_weight_tons"
      expr: SUM(CAST(weight_tons AS DOUBLE))
      comment: "Total weight of in-transit inventory in tons"
    - name: "total_co2_emissions_kg"
      expr: SUM(CAST(emissions_kg_co2 AS DOUBLE))
      comment: "Total CO2 emissions from in-transit inventory"
    - name: "total_fuel_consumption_liters"
      expr: SUM(CAST(fuel_consumption_liters AS DOUBLE))
      comment: "Total fuel consumption in liters"
    - name: "avg_fuel_consumption"
      expr: AVG(CAST(fuel_consumption_liters AS DOUBLE))
      comment: "Average fuel consumption per in-transit item"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`logistics_vehicle_handover`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vehicle handover metrics tracking handover volumes, on-time performance, handover fees, and environmental impact by handover type and location"
  source: "`vibe_automotive_v1`.`logistics`.`vehicle_handover`"
  dimensions:
    - name: "handover_status"
      expr: handover_status
      comment: "Status of the vehicle handover"
    - name: "handover_type"
      expr: handover_type
      comment: "Type of handover (dealer, customer, port, etc.)"
    - name: "handover_location"
      expr: handover_location
      comment: "Location where handover occurred"
    - name: "handover_condition"
      expr: handover_condition
      comment: "Condition of vehicle at handover"
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transportation to handover location"
    - name: "otd_flag"
      expr: otd_flag
      comment: "On-time delivery flag"
    - name: "export_import_flag"
      expr: export_import_flag
      comment: "Cross-border handover flag"
    - name: "hazardous_material_flag"
      expr: hazardous_material_flag
      comment: "Hazardous material flag"
    - name: "handover_month"
      expr: DATE_TRUNC('MONTH', handover_timestamp)
      comment: "Month of handover"
  measures:
    - name: "total_handovers"
      expr: COUNT(1)
      comment: "Total number of vehicle handovers"
    - name: "total_handover_fee_amount"
      expr: SUM(CAST(handover_fee_amount AS DOUBLE))
      comment: "Total handover fee amount"
    - name: "total_handover_fee_net"
      expr: SUM(CAST(handover_fee_net_amount AS DOUBLE))
      comment: "Total net handover fee after tax"
    - name: "total_handover_fee_tax"
      expr: SUM(CAST(handover_fee_tax_amount AS DOUBLE))
      comment: "Total tax on handover fees"
    - name: "avg_handover_fee"
      expr: AVG(CAST(handover_fee_amount AS DOUBLE))
      comment: "Average handover fee per vehicle"
    - name: "total_co2_emissions_kg"
      expr: SUM(CAST(emissions_kg_co2 AS DOUBLE))
      comment: "Total CO2 emissions from handover transport"
    - name: "total_fuel_consumption_liters"
      expr: SUM(CAST(fuel_consumption_liters AS DOUBLE))
      comment: "Total fuel consumption in liters"
    - name: "avg_odometer_reading_km"
      expr: AVG(CAST(odometer_reading_km AS DOUBLE))
      comment: "Average odometer reading at handover"
    - name: "on_time_handover_rate"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN otd_flag = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of handovers completed on time"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`logistics_transport_damage_claim`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Transport damage claim metrics tracking claim volumes, settlement amounts, repair costs, and claim resolution performance by carrier and damage type"
  source: "`vibe_automotive_v1`.`logistics`.`transport_damage_claim`"
  dimensions:
    - name: "claim_status"
      expr: claim_status
      comment: "Status of the damage claim"
    - name: "claim_type"
      expr: claim_type
      comment: "Type of damage claim"
    - name: "damage_category"
      expr: damage_category
      comment: "Category of damage"
    - name: "damage_severity"
      expr: damage_severity
      comment: "Severity level of damage"
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transportation when damage occurred"
    - name: "claim_priority"
      expr: claim_priority
      comment: "Priority level of the claim"
    - name: "claim_settlement_method"
      expr: claim_settlement_method
      comment: "Method used to settle the claim"
    - name: "is_fraud_flag"
      expr: is_fraud_flag
      comment: "Flag indicating suspected fraud"
    - name: "claim_submission_month"
      expr: DATE_TRUNC('MONTH', claim_submission_timestamp)
      comment: "Month when claim was submitted"
    - name: "settlement_month"
      expr: DATE_TRUNC('MONTH', settlement_date)
      comment: "Month when claim was settled"
  measures:
    - name: "total_claims"
      expr: COUNT(1)
      comment: "Total number of transport damage claims"
    - name: "total_estimated_repair_cost"
      expr: SUM(CAST(estimated_repair_cost AS DOUBLE))
      comment: "Total estimated repair cost across all claims"
    - name: "total_actual_repair_cost"
      expr: SUM(CAST(actual_repair_cost AS DOUBLE))
      comment: "Total actual repair cost across all claims"
    - name: "total_settlement_amount"
      expr: SUM(CAST(settlement_amount AS DOUBLE))
      comment: "Total settlement amount paid out"
    - name: "avg_settlement_amount"
      expr: AVG(CAST(settlement_amount AS DOUBLE))
      comment: "Average settlement amount per claim"
    - name: "avg_estimated_repair_cost"
      expr: AVG(CAST(estimated_repair_cost AS DOUBLE))
      comment: "Average estimated repair cost per claim"
    - name: "avg_actual_repair_cost"
      expr: AVG(CAST(actual_repair_cost AS DOUBLE))
      comment: "Average actual repair cost per claim"
    - name: "avg_claim_ppm_rate"
      expr: AVG(CAST(claim_ppm_rate AS DOUBLE))
      comment: "Average claim rate in parts per million"
    - name: "fraud_claim_count"
      expr: SUM(CAST(CASE WHEN is_fraud_flag = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Count of claims flagged as potential fraud"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`logistics_vessel_voyage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vessel voyage metrics tracking voyage volumes, capacity utilization, costs, and on-time performance by shipping line and route"
  source: "`vibe_automotive_v1`.`logistics`.`vessel_voyage`"
  dimensions:
    - name: "voyage_status"
      expr: voyage_status
      comment: "Status of the vessel voyage"
    - name: "voyage_type"
      expr: voyage_type
      comment: "Type of voyage (scheduled, charter, etc.)"
    - name: "origin_port_code"
      expr: origin_port_code
      comment: "Origin port code"
    - name: "destination_port_code"
      expr: destination_port_code
      comment: "Destination port code"
    - name: "vessel_name"
      expr: vessel_name
      comment: "Name of the vessel"
    - name: "voyage_status_reason"
      expr: voyage_status_reason
      comment: "Reason for current voyage status"
    - name: "planned_departure_month"
      expr: DATE_TRUNC('MONTH', planned_departure_timestamp)
      comment: "Month of planned departure"
    - name: "actual_arrival_month"
      expr: DATE_TRUNC('MONTH', actual_arrival_timestamp)
      comment: "Month of actual arrival"
  measures:
    - name: "total_voyages"
      expr: COUNT(1)
      comment: "Total number of vessel voyages"
    - name: "total_voyage_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost of all voyages"
    - name: "avg_voyage_cost"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average cost per voyage"
    - name: "avg_capacity_utilization"
      expr: AVG(CAST(booked_units AS DOUBLE) / NULLIF(CAST(vessel_capacity_units AS DOUBLE), 0) * 100.0)
      comment: "Average capacity utilization percentage across voyages"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`logistics_port_processing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Port processing metrics tracking processing volumes, customs clearance times, inspection status, and port charges by facility and compliance status"
  source: "`vibe_automotive_v1`.`logistics`.`port_processing`"
  dimensions:
    - name: "port_processing_status"
      expr: port_processing_status
      comment: "Status of port processing"
    - name: "customs_clearance_status"
      expr: customs_clearance_status
      comment: "Customs clearance status"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Regulatory compliance status"
    - name: "homologation_inspection_status"
      expr: homologation_inspection_status
      comment: "Homologation inspection status"
    - name: "pdi_completion_status"
      expr: pdi_completion_status
      comment: "Pre-delivery inspection completion status"
    - name: "port_facility_code"
      expr: port_facility_code
      comment: "Port facility code"
    - name: "export_import_indicator"
      expr: export_import_indicator
      comment: "Indicator for export or import"
    - name: "release_authorization_flag"
      expr: release_authorization_flag
      comment: "Flag indicating release authorization granted"
    - name: "arrival_month"
      expr: DATE_TRUNC('MONTH', arrival_date)
      comment: "Month of arrival at port"
    - name: "inspection_month"
      expr: DATE_TRUNC('MONTH', inspection_date)
      comment: "Month of inspection"
  measures:
    - name: "total_port_processing_records"
      expr: COUNT(1)
      comment: "Total number of port processing records"
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost_amount AS DOUBLE))
      comment: "Total freight cost at port"
    - name: "total_port_charges"
      expr: SUM(CAST(port_charges_amount AS DOUBLE))
      comment: "Total port charges"
    - name: "avg_freight_cost"
      expr: AVG(CAST(freight_cost_amount AS DOUBLE))
      comment: "Average freight cost per processing record"
    - name: "avg_port_charges"
      expr: AVG(CAST(port_charges_amount AS DOUBLE))
      comment: "Average port charges per processing record"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`logistics_carrier`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Carrier master data metrics tracking carrier performance ratings, cost efficiency, fleet capacity, and compliance status"
  source: "`vibe_automotive_v1`.`logistics`.`carrier`"
  dimensions:
    - name: "carrier_status"
      expr: carrier_status
      comment: "Status of the carrier"
    - name: "carrier_type"
      expr: carrier_type
      comment: "Type of carrier (asset-based, broker, 3PL, etc.)"
    - name: "tier"
      expr: tier
      comment: "Carrier tier classification"
    - name: "safety_rating"
      expr: safety_rating
      comment: "Safety rating of the carrier"
    - name: "iatf_compliance_status"
      expr: iatf_compliance_status
      comment: "IATF 16949 compliance status"
    - name: "environmental_certification"
      expr: environmental_certification
      comment: "Environmental certification held by carrier"
    - name: "country"
      expr: country
      comment: "Country where carrier is based"
  measures:
    - name: "total_carriers"
      expr: COUNT(1)
      comment: "Total number of carriers"
    - name: "avg_performance_rating"
      expr: AVG(CAST(performance_rating AS DOUBLE))
      comment: "Average performance rating across carriers"
    - name: "avg_cost_per_mile"
      expr: AVG(CAST(average_cost_per_mile AS DOUBLE))
      comment: "Average cost per mile across carriers"
    - name: "avg_on_time_delivery_pct"
      expr: AVG(CAST(average_on_time_delivery_pct AS DOUBLE))
      comment: "Average on-time delivery percentage across carriers"
$$;