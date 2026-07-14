-- Metric views for domain: logistics | Business: Automotive | Version: 2 | Generated on: 2026-07-14 04:28:06

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`logistics_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core shipment performance metrics tracking on-time delivery, freight costs, volume, and weight across transport modes and lanes"
  source: "`vibe_automotive_v1`.`logistics`.`shipment`"
  dimensions:
    - name: "shipment_status"
      expr: shipment_status
      comment: "Current status of the shipment (e.g., in-transit, delivered, delayed)"
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transportation (e.g., road, rail, sea, air)"
    - name: "origin_location"
      expr: origin_location
      comment: "Shipment origin location"
    - name: "destination_location"
      expr: destination_location
      comment: "Shipment destination location"
    - name: "load_type"
      expr: load_type
      comment: "Type of load (e.g., FTL, LTL, container)"
    - name: "incoterms_code"
      expr: incoterms_code
      comment: "International commercial terms governing shipment responsibility"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Regulatory compliance status of the shipment"
    - name: "planned_departure_month"
      expr: DATE_TRUNC('MONTH', planned_departure_date)
      comment: "Month of planned departure for time-series analysis"
    - name: "is_on_time_delivery"
      expr: otd_flag
      comment: "Boolean flag indicating whether shipment met on-time delivery target"
    - name: "is_hazardous"
      expr: hazardous_material_flag
      comment: "Boolean flag indicating whether shipment contains hazardous materials"
    - name: "is_temperature_controlled"
      expr: temperature_control_flag
      comment: "Boolean flag indicating whether shipment requires temperature control"
    - name: "is_export_import"
      expr: export_import_flag
      comment: "Boolean flag indicating cross-border shipment"
  measures:
    - name: "total_shipments"
      expr: COUNT(1)
      comment: "Total number of shipments"
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost AS DOUBLE))
      comment: "Total freight cost across all shipments"
    - name: "total_net_cost"
      expr: SUM(CAST(net_cost AS DOUBLE))
      comment: "Total net cost after discounts"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount applied to shipments"
    - name: "total_volume_cbm"
      expr: SUM(CAST(volume_cbm AS DOUBLE))
      comment: "Total shipment volume in cubic meters"
    - name: "total_weight_kg"
      expr: SUM(CAST(weight_kg AS DOUBLE))
      comment: "Total shipment weight in kilograms"
    - name: "avg_freight_cost_per_shipment"
      expr: AVG(CAST(freight_cost AS DOUBLE))
      comment: "Average freight cost per shipment"
    - name: "avg_volume_per_shipment"
      expr: AVG(CAST(volume_cbm AS DOUBLE))
      comment: "Average volume per shipment in cubic meters"
    - name: "avg_weight_per_shipment"
      expr: AVG(CAST(weight_kg AS DOUBLE))
      comment: "Average weight per shipment in kilograms"
    - name: "on_time_delivery_count"
      expr: SUM(CAST(CASE WHEN otd_flag = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Count of shipments delivered on time"
    - name: "on_time_delivery_rate"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN otd_flag = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of shipments delivered on time - key logistics performance indicator"
    - name: "freight_cost_per_kg"
      expr: ROUND(SUM(CAST(freight_cost AS DOUBLE)) / NULLIF(SUM(CAST(weight_kg AS DOUBLE)), 0), 4)
      comment: "Average freight cost per kilogram - efficiency metric for cost optimization"
    - name: "discount_rate"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(freight_cost AS DOUBLE)), 0), 2)
      comment: "Percentage discount rate applied to freight costs"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`logistics_freight_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Freight invoice financial metrics tracking invoiced amounts, payment status, variances, and approval rates for cost control"
  source: "`vibe_automotive_v1`.`logistics`.`freight_invoice`"
  dimensions:
    - name: "freight_invoice_status"
      expr: freight_invoice_status
      comment: "Current status of the freight invoice"
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of the invoice (e.g., paid, pending, overdue)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the invoice"
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transportation for the invoiced shipment"
    - name: "cost_type"
      expr: cost_type
      comment: "Type of cost being invoiced"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for the invoice amount"
    - name: "incoterms_code"
      expr: incoterms_code
      comment: "International commercial terms for the shipment"
    - name: "invoice_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month of invoice date for time-series analysis"
    - name: "payment_due_month"
      expr: DATE_TRUNC('MONTH', payment_due_date)
      comment: "Month of payment due date for cash flow analysis"
    - name: "is_on_time_delivery"
      expr: otd_flag
      comment: "Boolean flag indicating whether the shipment was delivered on time"
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
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on freight invoices"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount applied to invoices"
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total variance between agreed rate and invoiced amount - key cost control metric"
    - name: "total_weight_kg"
      expr: SUM(CAST(weight_kg AS DOUBLE))
      comment: "Total weight in kilograms across all invoiced shipments"
    - name: "total_volume_cbm"
      expr: SUM(CAST(volume_cbm AS DOUBLE))
      comment: "Total volume in cubic meters across all invoiced shipments"
    - name: "avg_invoiced_amount"
      expr: AVG(CAST(invoiced_amount AS DOUBLE))
      comment: "Average invoiced amount per freight invoice"
    - name: "paid_invoice_count"
      expr: SUM(CAST(CASE WHEN payment_status = 'Paid' THEN 1 ELSE 0 END AS INT))
      comment: "Count of paid invoices"
    - name: "approved_invoice_count"
      expr: SUM(CAST(CASE WHEN approval_status = 'Approved' THEN 1 ELSE 0 END AS INT))
      comment: "Count of approved invoices"
    - name: "invoice_approval_rate"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN approval_status = 'Approved' THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of invoices approved - indicates invoice quality and process efficiency"
    - name: "payment_completion_rate"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN payment_status = 'Paid' THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of invoices paid - key cash flow and supplier relationship metric"
    - name: "variance_rate"
      expr: ROUND(100.0 * SUM(CAST(variance_amount AS DOUBLE)) / NULLIF(SUM(CAST(invoiced_amount AS DOUBLE)), 0), 2)
      comment: "Percentage variance between agreed and invoiced amounts - critical cost control KPI"
    - name: "cost_per_kg"
      expr: ROUND(SUM(CAST(net_amount AS DOUBLE)) / NULLIF(SUM(CAST(weight_kg AS DOUBLE)), 0), 4)
      comment: "Average cost per kilogram - efficiency metric for freight cost optimization"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`logistics_carrier`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Carrier performance and capacity metrics tracking cost efficiency, on-time delivery, safety ratings, and fleet utilization"
  source: "`vibe_automotive_v1`.`logistics`.`carrier`"
  dimensions:
    - name: "carrier_status"
      expr: carrier_status
      comment: "Current operational status of the carrier"
    - name: "carrier_type"
      expr: carrier_type
      comment: "Type of carrier (e.g., asset-based, broker, 3PL)"
    - name: "tier"
      expr: tier
      comment: "Carrier tier classification (e.g., Tier 1, Tier 2, Tier 3)"
    - name: "safety_rating"
      expr: safety_rating
      comment: "Safety rating of the carrier"
    - name: "equipment_type"
      expr: equipment_type
      comment: "Type of equipment operated by the carrier"
    - name: "transport_modes"
      expr: transport_modes
      comment: "Transport modes supported by the carrier"
    - name: "country"
      expr: country
      comment: "Country where carrier is registered"
    - name: "operating_regions"
      expr: operating_regions
      comment: "Geographic regions where carrier operates"
    - name: "environmental_certification"
      expr: environmental_certification
      comment: "Environmental certifications held by carrier"
    - name: "iatf_compliance_status"
      expr: iatf_compliance_status
      comment: "IATF 16949 automotive quality compliance status"
  measures:
    - name: "total_carriers"
      expr: COUNT(1)
      comment: "Total number of carriers in the network"
    - name: "active_carriers"
      expr: SUM(CAST(CASE WHEN carrier_status = 'Active' THEN 1 ELSE 0 END AS INT))
      comment: "Count of active carriers available for shipments"
    - name: "avg_cost_per_mile"
      expr: AVG(CAST(average_cost_per_mile AS DOUBLE))
      comment: "Average cost per mile across all carriers - key cost benchmark metric"
    - name: "avg_on_time_delivery_pct"
      expr: AVG(CAST(average_on_time_delivery_pct AS DOUBLE))
      comment: "Average on-time delivery percentage across carriers - critical service quality KPI"
    - name: "avg_performance_rating"
      expr: AVG(CAST(performance_rating AS DOUBLE))
      comment: "Average performance rating across carriers - overall carrier quality indicator"
    - name: "total_cost_per_mile"
      expr: SUM(CAST(average_cost_per_mile AS DOUBLE))
      comment: "Sum of average cost per mile across all carriers"
    - name: "carrier_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN carrier_status = 'Active' THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of carriers actively utilized - indicates network efficiency and capacity management"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`logistics_vehicle_transport_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vehicle transport order metrics tracking delivery performance, transport costs, emissions, and expedited shipment rates"
  source: "`vibe_automotive_v1`.`logistics`.`vehicle_transport_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the vehicle transport order"
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transportation for vehicle delivery"
    - name: "priority"
      expr: priority
      comment: "Priority level of the transport order"
    - name: "container_type"
      expr: container_type
      comment: "Type of container used for vehicle transport"
    - name: "fuel_type"
      expr: fuel_type
      comment: "Fuel type used for transport"
    - name: "order_created_month"
      expr: DATE_TRUNC('MONTH', order_created_timestamp)
      comment: "Month when transport order was created"
    - name: "requested_pickup_month"
      expr: DATE_TRUNC('MONTH', requested_pickup_date)
      comment: "Month of requested pickup date"
    - name: "delivery_month"
      expr: DATE_TRUNC('MONTH', delivery_date)
      comment: "Month of actual delivery date"
    - name: "is_on_time_delivery"
      expr: on_time_delivery_flag
      comment: "Boolean flag indicating on-time delivery achievement"
    - name: "is_expedited"
      expr: is_expedited
      comment: "Boolean flag indicating expedited transport order"
    - name: "is_hazardous"
      expr: is_hazardous
      comment: "Boolean flag indicating hazardous material transport"
    - name: "is_export_import"
      expr: export_import_flag
      comment: "Boolean flag indicating cross-border transport"
  measures:
    - name: "total_transport_orders"
      expr: COUNT(1)
      comment: "Total number of vehicle transport orders"
    - name: "total_transport_cost_gross"
      expr: SUM(CAST(transport_cost_gross AS DOUBLE))
      comment: "Total gross transport cost across all orders"
    - name: "total_transport_cost_net"
      expr: SUM(CAST(transport_cost_net AS DOUBLE))
      comment: "Total net transport cost after adjustments"
    - name: "total_transport_cost_tax"
      expr: SUM(CAST(transport_cost_tax AS DOUBLE))
      comment: "Total tax amount on transport costs"
    - name: "total_distance_km"
      expr: SUM(CAST(distance_km AS DOUBLE))
      comment: "Total distance traveled in kilometers"
    - name: "total_weight_tons"
      expr: SUM(CAST(weight_tons AS DOUBLE))
      comment: "Total weight transported in tons"
    - name: "total_emission_co2_kg"
      expr: SUM(CAST(emission_co2_kg AS DOUBLE))
      comment: "Total CO2 emissions in kilograms - key environmental sustainability metric"
    - name: "avg_transport_cost_per_order"
      expr: AVG(CAST(transport_cost_net AS DOUBLE))
      comment: "Average net transport cost per order"
    - name: "avg_distance_km"
      expr: AVG(CAST(distance_km AS DOUBLE))
      comment: "Average distance per transport order in kilometers"
    - name: "on_time_delivery_count"
      expr: SUM(CAST(CASE WHEN on_time_delivery_flag = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Count of orders delivered on time"
    - name: "expedited_order_count"
      expr: SUM(CAST(CASE WHEN is_expedited = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Count of expedited transport orders"
    - name: "on_time_delivery_rate"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN on_time_delivery_flag = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of vehicle transport orders delivered on time - critical customer satisfaction KPI"
    - name: "expedited_order_rate"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN is_expedited = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of orders requiring expedited transport - indicates demand urgency and planning effectiveness"
    - name: "cost_per_km"
      expr: ROUND(SUM(CAST(transport_cost_net AS DOUBLE)) / NULLIF(SUM(CAST(distance_km AS DOUBLE)), 0), 4)
      comment: "Average transport cost per kilometer - efficiency metric for cost optimization"
    - name: "emission_per_km"
      expr: ROUND(SUM(CAST(emission_co2_kg AS DOUBLE)) / NULLIF(SUM(CAST(distance_km AS DOUBLE)), 0), 4)
      comment: "Average CO2 emissions per kilometer - environmental efficiency KPI for sustainability reporting"
    - name: "cost_per_ton"
      expr: ROUND(SUM(CAST(transport_cost_net AS DOUBLE)) / NULLIF(SUM(CAST(weight_tons AS DOUBLE)), 0), 2)
      comment: "Average transport cost per ton - weight-based efficiency metric"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`logistics_in_transit_inventory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "In-transit inventory metrics tracking transit times, delays, transport costs, and environmental impact for supply chain visibility"
  source: "`vibe_automotive_v1`.`logistics`.`in_transit_inventory`"
  dimensions:
    - name: "transit_status"
      expr: transit_status
      comment: "Current status of in-transit inventory"
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transportation for in-transit goods"
    - name: "customs_status"
      expr: customs_status
      comment: "Customs clearance status for cross-border shipments"
    - name: "load_type"
      expr: load_type
      comment: "Type of load being transported"
    - name: "current_location"
      expr: current_location
      comment: "Current geographic location of in-transit inventory"
    - name: "origin_facility_code"
      expr: origin_facility_code
      comment: "Origin facility code"
    - name: "destination_facility_code"
      expr: destination_facility_code
      comment: "Destination facility code"
    - name: "estimated_arrival_month"
      expr: DATE_TRUNC('MONTH', estimated_arrival_date)
      comment: "Month of estimated arrival for planning analysis"
    - name: "is_hazardous"
      expr: hazardous_material_flag
      comment: "Boolean flag indicating hazardous material in transit"
    - name: "is_temperature_controlled"
      expr: temperature_control_flag
      comment: "Boolean flag indicating temperature-controlled transport"
  measures:
    - name: "total_in_transit_items"
      expr: COUNT(1)
      comment: "Total number of in-transit inventory items"
    - name: "total_transport_cost"
      expr: SUM(CAST(transport_cost_amount AS DOUBLE))
      comment: "Total transport cost for in-transit inventory"
    - name: "total_weight_tons"
      expr: SUM(CAST(weight_tons AS DOUBLE))
      comment: "Total weight of in-transit inventory in tons"
    - name: "total_volume_cubic_meters"
      expr: SUM(CAST(volume_cubic_meters AS DOUBLE))
      comment: "Total volume of in-transit inventory in cubic meters"
    - name: "total_emissions_kg_co2"
      expr: SUM(CAST(emissions_kg_co2 AS DOUBLE))
      comment: "Total CO2 emissions for in-transit inventory - environmental impact metric"
    - name: "total_fuel_consumption_liters"
      expr: SUM(CAST(fuel_consumption_liters AS DOUBLE))
      comment: "Total fuel consumption in liters for in-transit transport"
    - name: "avg_transport_cost"
      expr: AVG(CAST(transport_cost_amount AS DOUBLE))
      comment: "Average transport cost per in-transit item"
    - name: "avg_weight_tons"
      expr: AVG(CAST(weight_tons AS DOUBLE))
      comment: "Average weight per in-transit item in tons"
    - name: "cost_per_ton"
      expr: ROUND(SUM(CAST(transport_cost_amount AS DOUBLE)) / NULLIF(SUM(CAST(weight_tons AS DOUBLE)), 0), 2)
      comment: "Average transport cost per ton - efficiency metric for in-transit cost management"
    - name: "emission_per_ton"
      expr: ROUND(SUM(CAST(emissions_kg_co2 AS DOUBLE)) / NULLIF(SUM(CAST(weight_tons AS DOUBLE)), 0), 4)
      comment: "Average CO2 emissions per ton - environmental efficiency KPI for sustainability"
    - name: "fuel_efficiency_liters_per_ton"
      expr: ROUND(SUM(CAST(fuel_consumption_liters AS DOUBLE)) / NULLIF(SUM(CAST(weight_tons AS DOUBLE)), 0), 4)
      comment: "Fuel consumption per ton - operational efficiency metric for transport optimization"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`logistics_vehicle_handover`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vehicle handover metrics tracking handover completion rates, costs, environmental impact, and on-time delivery for final-mile logistics"
  source: "`vibe_automotive_v1`.`logistics`.`vehicle_handover`"
  dimensions:
    - name: "handover_status"
      expr: handover_status
      comment: "Current status of the vehicle handover"
    - name: "handover_type"
      expr: handover_type
      comment: "Type of handover (e.g., dealer delivery, customer pickup, trade-in)"
    - name: "handover_condition"
      expr: handover_condition
      comment: "Condition of vehicle at handover"
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transportation used for handover"
    - name: "receiving_party_type"
      expr: receiving_party_type
      comment: "Type of receiving party (e.g., dealer, customer, supplier)"
    - name: "handover_location"
      expr: handover_location
      comment: "Location where handover occurred"
    - name: "acceptance_signature_status"
      expr: acceptance_signature_status
      comment: "Status of acceptance signature"
    - name: "handover_month"
      expr: DATE_TRUNC('MONTH', handover_timestamp)
      comment: "Month of handover for time-series analysis"
    - name: "is_on_time_delivery"
      expr: otd_flag
      comment: "Boolean flag indicating on-time delivery at handover"
    - name: "is_export_import"
      expr: export_import_flag
      comment: "Boolean flag indicating cross-border handover"
    - name: "is_hazardous"
      expr: hazardous_material_flag
      comment: "Boolean flag indicating hazardous material involved"
    - name: "is_temperature_controlled"
      expr: temperature_control_flag
      comment: "Boolean flag indicating temperature-controlled handover"
  measures:
    - name: "total_handovers"
      expr: COUNT(1)
      comment: "Total number of vehicle handovers"
    - name: "total_handover_fee_amount"
      expr: SUM(CAST(handover_fee_amount AS DOUBLE))
      comment: "Total handover fee amount charged"
    - name: "total_handover_fee_net"
      expr: SUM(CAST(handover_fee_net_amount AS DOUBLE))
      comment: "Total net handover fee after tax"
    - name: "total_handover_fee_tax"
      expr: SUM(CAST(handover_fee_tax_amount AS DOUBLE))
      comment: "Total tax on handover fees"
    - name: "total_emissions_kg_co2"
      expr: SUM(CAST(emissions_kg_co2 AS DOUBLE))
      comment: "Total CO2 emissions during handover transport - environmental metric"
    - name: "total_fuel_consumption_liters"
      expr: SUM(CAST(fuel_consumption_liters AS DOUBLE))
      comment: "Total fuel consumption during handover transport"
    - name: "total_odometer_reading_km"
      expr: SUM(CAST(odometer_reading_km AS DOUBLE))
      comment: "Total odometer reading across all handovers in kilometers"
    - name: "avg_handover_fee"
      expr: AVG(CAST(handover_fee_net_amount AS DOUBLE))
      comment: "Average net handover fee per vehicle"
    - name: "avg_odometer_reading_km"
      expr: AVG(CAST(odometer_reading_km AS DOUBLE))
      comment: "Average odometer reading at handover in kilometers"
    - name: "on_time_handover_count"
      expr: SUM(CAST(CASE WHEN otd_flag = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Count of handovers completed on time"
    - name: "on_time_handover_rate"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN otd_flag = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of handovers completed on time - critical final-mile delivery KPI"
    - name: "emission_per_handover"
      expr: ROUND(SUM(CAST(emissions_kg_co2 AS DOUBLE)) / NULLIF(COUNT(1), 0), 4)
      comment: "Average CO2 emissions per handover - environmental efficiency metric for sustainability"
$$;