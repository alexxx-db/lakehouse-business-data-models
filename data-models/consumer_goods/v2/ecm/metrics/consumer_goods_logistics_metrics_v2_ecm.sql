-- Metric views for domain: logistics | Business: Consumer_Goods | Version: 2 | Generated on: 2026-07-10 13:28:51

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`logistics_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core shipment performance metrics tracking on-time delivery, freight costs, and operational efficiency across all logistics movements"
  source: "`vibe_consumer_goods_v1`.`logistics`.`logistics_shipment`"
  dimensions:
    - name: "shipment_status"
      expr: shipment_status
      comment: "Current status of the shipment (e.g., in-transit, delivered, cancelled)"
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transportation (e.g., truck, rail, air, ocean)"
    - name: "service_level"
      expr: service_level
      comment: "Service level agreement tier (e.g., standard, expedited, next-day)"
    - name: "direction"
      expr: direction
      comment: "Shipment direction (inbound, outbound, inter-facility)"
    - name: "cold_chain_required"
      expr: cold_chain_required
      comment: "Whether shipment requires temperature-controlled logistics"
    - name: "hazmat_flag"
      expr: hazmat_flag
      comment: "Whether shipment contains hazardous materials"
    - name: "incoterms_code"
      expr: incoterms_code
      comment: "International commercial terms defining delivery responsibilities"
    - name: "shipment_month"
      expr: DATE_TRUNC('MONTH', actual_ship_date)
      comment: "Month when shipment was dispatched"
    - name: "delivery_month"
      expr: DATE_TRUNC('MONTH', actual_delivery_date)
      comment: "Month when shipment was delivered"
  measures:
    - name: "total_shipments"
      expr: COUNT(1)
      comment: "Total number of shipments"
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost_amount AS DOUBLE))
      comment: "Total freight cost across all shipments"
    - name: "avg_freight_cost_per_shipment"
      expr: AVG(CAST(freight_cost_amount AS DOUBLE))
      comment: "Average freight cost per shipment"
    - name: "total_weight_kg"
      expr: SUM(CAST(total_weight_kg AS DOUBLE))
      comment: "Total weight shipped in kilograms"
    - name: "total_volume_m3"
      expr: SUM(CAST(total_volume_m3 AS DOUBLE))
      comment: "Total volume shipped in cubic meters"
    - name: "otif_shipment_count"
      expr: SUM(CASE WHEN otif_on_time = TRUE AND otif_in_full = TRUE THEN 1 ELSE 0 END)
      comment: "Count of shipments delivered on-time and in-full"
    - name: "on_time_shipment_count"
      expr: SUM(CASE WHEN otif_on_time = TRUE THEN 1 ELSE 0 END)
      comment: "Count of shipments delivered on-time"
    - name: "in_full_shipment_count"
      expr: SUM(CASE WHEN otif_in_full = TRUE THEN 1 ELSE 0 END)
      comment: "Count of shipments delivered in-full"
    - name: "cold_chain_shipment_count"
      expr: SUM(CASE WHEN cold_chain_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of shipments requiring cold chain logistics"
    - name: "hazmat_shipment_count"
      expr: SUM(CASE WHEN hazmat_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of shipments containing hazardous materials"
    - name: "total_fuel_surcharge"
      expr: SUM(CAST(fuel_surcharge_amount AS DOUBLE))
      comment: "Total fuel surcharge costs across all shipments"
    - name: "total_pallets"
      expr: SUM(CAST(total_pallets AS DOUBLE))
      comment: "Total number of pallets shipped"
    - name: "total_cases"
      expr: SUM(CAST(total_cases AS DOUBLE))
      comment: "Total number of cases shipped"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`logistics_carrier_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Carrier performance scorecard metrics tracking on-time delivery rates, tender acceptance, damage rates, and overall service quality by carrier and period"
  source: "`vibe_consumer_goods_v1`.`logistics`.`carrier_performance`"
  dimensions:
    - name: "performance_tier"
      expr: performance_tier
      comment: "Carrier performance tier classification (e.g., platinum, gold, silver, bronze)"
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transportation for this performance record"
    - name: "service_level"
      expr: service_level
      comment: "Service level agreement tier"
    - name: "network_region"
      expr: network_region
      comment: "Geographic network region for performance measurement"
    - name: "measurement_period_type"
      expr: measurement_period_type
      comment: "Type of measurement period (e.g., monthly, quarterly, annual)"
    - name: "scorecard_status"
      expr: scorecard_status
      comment: "Status of the performance scorecard (e.g., draft, finalized, published)"
    - name: "improvement_plan_flag"
      expr: improvement_plan_flag
      comment: "Whether carrier is on a performance improvement plan"
    - name: "period_start_month"
      expr: DATE_TRUNC('MONTH', period_start_date)
      comment: "Month when performance measurement period started"
  measures:
    - name: "total_scorecards"
      expr: COUNT(1)
      comment: "Total number of carrier performance scorecards"
    - name: "avg_on_time_delivery_rate"
      expr: AVG(CAST(on_time_delivery_rate_pct AS DOUBLE))
      comment: "Average on-time delivery rate percentage across carriers"
    - name: "avg_otif_rate"
      expr: AVG(CAST(otif_rate_pct AS DOUBLE))
      comment: "Average on-time in-full rate percentage across carriers"
    - name: "avg_tender_acceptance_rate"
      expr: AVG(CAST(tender_acceptance_rate_pct AS DOUBLE))
      comment: "Average tender acceptance rate percentage across carriers"
    - name: "avg_damage_rate"
      expr: AVG(CAST(damage_rate_pct AS DOUBLE))
      comment: "Average damage rate percentage across carriers"
    - name: "avg_claims_rate"
      expr: AVG(CAST(claims_rate_pct AS DOUBLE))
      comment: "Average claims rate percentage across carriers"
    - name: "avg_composite_score"
      expr: AVG(CAST(composite_score AS DOUBLE))
      comment: "Average composite performance score across carriers"
    - name: "total_freight_spend"
      expr: SUM(CAST(total_freight_spend AS DOUBLE))
      comment: "Total freight spend across all carrier performance records"
    - name: "total_claims_amount"
      expr: SUM(CAST(total_claims_amount AS DOUBLE))
      comment: "Total claims amount across all carriers"
    - name: "avg_transit_days"
      expr: AVG(CAST(avg_transit_days AS DOUBLE))
      comment: "Average transit days across carriers"
    - name: "avg_invoice_accuracy_rate"
      expr: AVG(CAST(invoice_accuracy_rate_pct AS DOUBLE))
      comment: "Average invoice accuracy rate percentage across carriers"
    - name: "carriers_on_improvement_plan"
      expr: SUM(CASE WHEN improvement_plan_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of carriers currently on performance improvement plans"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`logistics_freight_cost`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Freight cost analytics tracking actual vs standard costs, variances, and cost allocation across shipments, lanes, and cost centers"
  source: "`vibe_consumer_goods_v1`.`logistics`.`freight_cost`"
  dimensions:
    - name: "cost_category"
      expr: cost_category
      comment: "Primary cost category (e.g., line haul, accessorial, fuel surcharge)"
    - name: "cost_sub_category"
      expr: cost_sub_category
      comment: "Detailed cost sub-category"
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transportation"
    - name: "service_level"
      expr: service_level
      comment: "Service level agreement tier"
    - name: "shipment_direction"
      expr: shipment_direction
      comment: "Direction of shipment (inbound, outbound, inter-facility)"
    - name: "cost_status"
      expr: cost_status
      comment: "Status of the cost record (e.g., accrued, invoiced, paid, disputed)"
    - name: "freight_audit_status"
      expr: freight_audit_status
      comment: "Audit status of the freight cost"
    - name: "incoterms_code"
      expr: incoterms_code
      comment: "International commercial terms code"
    - name: "accrual_flag"
      expr: accrual_flag
      comment: "Whether this cost is accrued"
    - name: "cost_recognition_month"
      expr: DATE_TRUNC('MONTH', cost_recognition_date)
      comment: "Month when cost was recognized"
  measures:
    - name: "total_cost_records"
      expr: COUNT(1)
      comment: "Total number of freight cost records"
    - name: "total_freight_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total freight cost in local currency"
    - name: "total_freight_cost_usd"
      expr: SUM(CAST(cost_amount_usd AS DOUBLE))
      comment: "Total freight cost in USD"
    - name: "total_standard_cost"
      expr: SUM(CAST(standard_cost_amount AS DOUBLE))
      comment: "Total standard cost amount"
    - name: "total_variance"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total variance between actual and standard cost"
    - name: "total_cold_chain_premium"
      expr: SUM(CAST(cold_chain_premium_amount AS DOUBLE))
      comment: "Total cold chain premium charges"
    - name: "total_hazmat_surcharge"
      expr: SUM(CAST(hazmat_surcharge_amount AS DOUBLE))
      comment: "Total hazardous materials surcharge"
    - name: "total_audit_discrepancy"
      expr: SUM(CAST(audit_discrepancy_amount AS DOUBLE))
      comment: "Total audit discrepancy amount"
    - name: "total_weight_kg"
      expr: SUM(CAST(weight_kg AS DOUBLE))
      comment: "Total weight in kilograms"
    - name: "total_volume_m3"
      expr: SUM(CAST(volume_m3 AS DOUBLE))
      comment: "Total volume in cubic meters"
    - name: "avg_cost_per_kg"
      expr: AVG(CAST(rate_per_kg AS DOUBLE))
      comment: "Average cost rate per kilogram"
    - name: "avg_cost_per_km"
      expr: AVG(CAST(rate_per_km AS DOUBLE))
      comment: "Average cost rate per kilometer"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`logistics_freight_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Freight invoice and audit metrics tracking invoiced amounts, variances, payment status, and audit outcomes for freight billing"
  source: "`vibe_consumer_goods_v1`.`logistics`.`freight_invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the freight invoice (e.g., received, audited, approved, paid, disputed)"
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of freight invoice"
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transportation"
    - name: "service_level"
      expr: service_level
      comment: "Service level agreement tier"
    - name: "invoice_source"
      expr: invoice_source
      comment: "Source system or method of invoice receipt (e.g., EDI, email, portal)"
    - name: "dispute_reason_code"
      expr: dispute_reason_code
      comment: "Reason code for invoice dispute"
    - name: "is_cold_chain"
      expr: is_cold_chain
      comment: "Whether invoice is for cold chain shipment"
    - name: "is_hazmat"
      expr: is_hazmat
      comment: "Whether invoice is for hazardous materials shipment"
    - name: "invoice_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month when invoice was issued"
    - name: "service_month"
      expr: DATE_TRUNC('MONTH', service_date)
      comment: "Month when service was provided"
  measures:
    - name: "total_invoices"
      expr: COUNT(1)
      comment: "Total number of freight invoices"
    - name: "total_invoiced_amount"
      expr: SUM(CAST(invoiced_total_amount AS DOUBLE))
      comment: "Total invoiced amount across all invoices"
    - name: "total_approved_amount"
      expr: SUM(CAST(approved_amount AS DOUBLE))
      comment: "Total approved amount after audit"
    - name: "total_contracted_amount"
      expr: SUM(CAST(contracted_amount AS DOUBLE))
      comment: "Total contracted amount based on carrier contracts"
    - name: "total_variance"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total variance between invoiced and approved amounts"
    - name: "total_line_haul"
      expr: SUM(CAST(line_haul_amount AS DOUBLE))
      comment: "Total line haul charges"
    - name: "total_accessorial"
      expr: SUM(CAST(accessorial_amount AS DOUBLE))
      comment: "Total accessorial charges"
    - name: "total_fuel_surcharge"
      expr: SUM(CAST(fuel_surcharge_amount AS DOUBLE))
      comment: "Total fuel surcharge amounts"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amounts on invoices"
    - name: "total_shipment_weight_kg"
      expr: SUM(CAST(shipment_weight_kg AS DOUBLE))
      comment: "Total shipment weight in kilograms across invoices"
    - name: "disputed_invoice_count"
      expr: SUM(CASE WHEN dispute_reason_code IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of disputed invoices"
    - name: "paid_invoice_count"
      expr: SUM(CASE WHEN paid_date IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of paid invoices"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`logistics_route`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Route execution and optimization metrics tracking planned vs actual performance, OTIF compliance, fuel consumption, and route efficiency"
  source: "`vibe_consumer_goods_v1`.`logistics`.`route`"
  dimensions:
    - name: "route_status"
      expr: route_status
      comment: "Current status of the route (e.g., planned, in-progress, completed, cancelled)"
    - name: "route_type"
      expr: route_type
      comment: "Type of route (e.g., delivery, pickup, milk-run)"
    - name: "is_dsd"
      expr: is_dsd
      comment: "Whether route is direct store delivery"
    - name: "is_cold_chain"
      expr: is_cold_chain
      comment: "Whether route requires cold chain logistics"
    - name: "hazmat_indicator"
      expr: hazmat_indicator
      comment: "Whether route includes hazardous materials"
    - name: "otif_compliant"
      expr: otif_compliant
      comment: "Whether route achieved on-time in-full delivery"
    - name: "optimization_algorithm"
      expr: optimization_algorithm
      comment: "Algorithm used for route optimization"
    - name: "route_month"
      expr: DATE_TRUNC('MONTH', route_date)
      comment: "Month when route was executed"
  measures:
    - name: "total_routes"
      expr: COUNT(1)
      comment: "Total number of routes"
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost AS DOUBLE))
      comment: "Total freight cost across all routes"
    - name: "total_actual_distance_km"
      expr: SUM(CAST(actual_distance_km AS DOUBLE))
      comment: "Total actual distance traveled in kilometers"
    - name: "total_planned_distance_km"
      expr: SUM(CAST(planned_distance_km AS DOUBLE))
      comment: "Total planned distance in kilometers"
    - name: "total_fuel_consumption_liters"
      expr: SUM(CAST(fuel_consumption_liters AS DOUBLE))
      comment: "Total fuel consumed in liters"
    - name: "total_co2_emissions_kg"
      expr: SUM(CAST(co2_emissions_kg AS DOUBLE))
      comment: "Total CO2 emissions in kilograms"
    - name: "total_weight_kg"
      expr: SUM(CAST(total_weight_kg AS DOUBLE))
      comment: "Total weight transported in kilograms"
    - name: "total_volume_m3"
      expr: SUM(CAST(total_volume_m3 AS DOUBLE))
      comment: "Total volume transported in cubic meters"
    - name: "avg_vehicle_capacity_utilization"
      expr: AVG(CAST(vehicle_capacity_utilization_pct AS DOUBLE))
      comment: "Average vehicle capacity utilization percentage"
    - name: "otif_route_count"
      expr: SUM(CASE WHEN otif_compliant = TRUE THEN 1 ELSE 0 END)
      comment: "Count of routes that achieved OTIF compliance"
    - name: "total_stops_planned"
      expr: SUM(CAST(total_stops_planned AS DOUBLE))
      comment: "Total number of planned stops"
    - name: "total_stops_completed"
      expr: SUM(CAST(total_stops_completed AS DOUBLE))
      comment: "Total number of completed stops"
    - name: "total_cases_delivered"
      expr: SUM(CAST(total_cases_delivered AS DOUBLE))
      comment: "Total number of cases delivered"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`logistics_cold_chain_log`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cold chain monitoring and compliance metrics tracking temperature excursions, sensor readings, and quality assurance for temperature-sensitive shipments"
  source: "`vibe_consumer_goods_v1`.`logistics`.`cold_chain_log`"
  dimensions:
    - name: "excursion_flag"
      expr: excursion_flag
      comment: "Whether a temperature excursion was detected"
    - name: "excursion_severity"
      expr: excursion_severity
      comment: "Severity level of temperature excursion (e.g., minor, major, critical)"
    - name: "excursion_type"
      expr: excursion_type
      comment: "Type of excursion (e.g., high temperature, low temperature, humidity)"
    - name: "alert_triggered"
      expr: alert_triggered
      comment: "Whether an alert was triggered for this reading"
    - name: "qa_disposition"
      expr: qa_disposition
      comment: "Quality assurance disposition (e.g., approved, rejected, quarantine)"
    - name: "product_temperature_class"
      expr: product_temperature_class
      comment: "Temperature class of the product (e.g., frozen, refrigerated, ambient)"
    - name: "sensor_model"
      expr: sensor_model
      comment: "Model of temperature sensor used"
    - name: "sensor_placement"
      expr: sensor_placement
      comment: "Physical placement of sensor in transport unit"
    - name: "regulatory_report_required"
      expr: regulatory_report_required
      comment: "Whether regulatory reporting is required for this event"
    - name: "reading_month"
      expr: DATE_TRUNC('MONTH', reading_timestamp)
      comment: "Month when temperature reading was recorded"
  measures:
    - name: "total_readings"
      expr: COUNT(1)
      comment: "Total number of cold chain temperature readings"
    - name: "excursion_count"
      expr: SUM(CASE WHEN excursion_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of temperature excursion events"
    - name: "alert_count"
      expr: SUM(CASE WHEN alert_triggered = TRUE THEN 1 ELSE 0 END)
      comment: "Count of alerts triggered"
    - name: "avg_temperature_c"
      expr: AVG(CAST(temperature_c AS DOUBLE))
      comment: "Average temperature in Celsius"
    - name: "avg_humidity_pct"
      expr: AVG(CAST(humidity_pct AS DOUBLE))
      comment: "Average humidity percentage"
    - name: "avg_mean_kinetic_temp_c"
      expr: AVG(CAST(mean_kinetic_temp_c AS DOUBLE))
      comment: "Average mean kinetic temperature in Celsius"
    - name: "avg_sensor_battery_pct"
      expr: AVG(CAST(sensor_battery_pct AS DOUBLE))
      comment: "Average sensor battery percentage"
    - name: "regulatory_report_required_count"
      expr: SUM(CASE WHEN regulatory_report_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of events requiring regulatory reporting"
    - name: "corrective_action_count"
      expr: SUM(CASE WHEN corrective_action_taken IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of events where corrective action was taken"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`logistics_delivery`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Last-mile delivery performance metrics tracking on-time delivery, in-full delivery, OTIF compliance, and delivery exceptions"
  source: "`vibe_consumer_goods_v1`.`logistics`.`delivery`"
  dimensions:
    - name: "delivery_status"
      expr: delivery_status
      comment: "Current status of the delivery (e.g., scheduled, in-transit, delivered, failed)"
    - name: "delivery_type"
      expr: delivery_type
      comment: "Type of delivery (e.g., standard, express, same-day)"
    - name: "on_time_flag"
      expr: on_time_flag
      comment: "Whether delivery was on-time"
    - name: "in_full_flag"
      expr: in_full_flag
      comment: "Whether delivery was in-full"
    - name: "otif_flag"
      expr: otif_flag
      comment: "Whether delivery achieved on-time in-full"
    - name: "cold_chain_required"
      expr: cold_chain_required
      comment: "Whether delivery required cold chain logistics"
    - name: "exception_code"
      expr: exception_code
      comment: "Exception code if delivery failed or had issues"
    - name: "goods_condition_code"
      expr: goods_condition_code
      comment: "Condition of goods upon delivery"
    - name: "electronic_signature_flag"
      expr: electronic_signature_flag
      comment: "Whether electronic signature was captured"
    - name: "country_code"
      expr: country_code
      comment: "Country code of delivery destination"
    - name: "scheduled_delivery_month"
      expr: DATE_TRUNC('MONTH', scheduled_delivery_date)
      comment: "Month when delivery was scheduled"
  measures:
    - name: "total_deliveries"
      expr: COUNT(1)
      comment: "Total number of deliveries"
    - name: "on_time_delivery_count"
      expr: SUM(CASE WHEN on_time_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of on-time deliveries"
    - name: "in_full_delivery_count"
      expr: SUM(CASE WHEN in_full_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of in-full deliveries"
    - name: "otif_delivery_count"
      expr: SUM(CASE WHEN otif_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of on-time in-full deliveries"
    - name: "total_ordered_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total ordered quantity across all deliveries"
    - name: "total_delivered_quantity"
      expr: SUM(CAST(delivered_quantity AS DOUBLE))
      comment: "Total delivered quantity across all deliveries"
    - name: "total_refused_quantity"
      expr: SUM(CAST(refused_quantity AS DOUBLE))
      comment: "Total refused quantity across all deliveries"
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost_amount AS DOUBLE))
      comment: "Total freight cost for deliveries"
    - name: "exception_count"
      expr: SUM(CASE WHEN exception_code IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of deliveries with exceptions"
    - name: "electronic_signature_count"
      expr: SUM(CASE WHEN electronic_signature_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of deliveries with electronic signature captured"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`logistics_transport_exception`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Transport exception and incident management metrics tracking exception types, severity, financial impact, and resolution performance"
  source: "`vibe_consumer_goods_v1`.`logistics`.`transport_exception`"
  dimensions:
    - name: "exception_type"
      expr: exception_type
      comment: "Type of transport exception (e.g., delay, damage, loss, temperature excursion)"
    - name: "exception_subtype"
      expr: exception_subtype
      comment: "Detailed subtype of exception"
    - name: "exception_status"
      expr: exception_status
      comment: "Current status of exception (e.g., open, investigating, resolved, closed)"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of exception (e.g., low, medium, high, critical)"
    - name: "root_cause_code"
      expr: root_cause_code
      comment: "Root cause code for the exception"
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transportation when exception occurred"
    - name: "cold_chain_breach_flag"
      expr: cold_chain_breach_flag
      comment: "Whether exception involved cold chain breach"
    - name: "hazmat_involved_flag"
      expr: hazmat_involved_flag
      comment: "Whether hazardous materials were involved"
    - name: "otif_impact_flag"
      expr: otif_impact_flag
      comment: "Whether exception impacted OTIF performance"
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether exception was escalated"
    - name: "regulatory_notification_required"
      expr: regulatory_notification_required
      comment: "Whether regulatory notification is required"
    - name: "claim_status"
      expr: claim_status
      comment: "Status of insurance or carrier claim"
    - name: "exception_month"
      expr: DATE_TRUNC('MONTH', exception_timestamp)
      comment: "Month when exception occurred"
  measures:
    - name: "total_exceptions"
      expr: COUNT(1)
      comment: "Total number of transport exceptions"
    - name: "total_financial_impact"
      expr: SUM(CAST(financial_impact_amount AS DOUBLE))
      comment: "Total financial impact of exceptions"
    - name: "total_claim_amount"
      expr: SUM(CAST(claim_amount AS DOUBLE))
      comment: "Total claim amount for exceptions"
    - name: "avg_delay_duration_hours"
      expr: AVG(CAST(delay_duration_hours AS DOUBLE))
      comment: "Average delay duration in hours"
    - name: "cold_chain_breach_count"
      expr: SUM(CASE WHEN cold_chain_breach_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of cold chain breach exceptions"
    - name: "hazmat_exception_count"
      expr: SUM(CASE WHEN hazmat_involved_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of exceptions involving hazardous materials"
    - name: "otif_impact_count"
      expr: SUM(CASE WHEN otif_impact_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of exceptions impacting OTIF performance"
    - name: "escalated_exception_count"
      expr: SUM(CASE WHEN escalation_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of escalated exceptions"
    - name: "regulatory_notification_count"
      expr: SUM(CASE WHEN regulatory_notification_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of exceptions requiring regulatory notification"
    - name: "resolved_exception_count"
      expr: SUM(CASE WHEN resolution_timestamp IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of resolved exceptions"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`logistics_lane`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Logistics lane performance and cost metrics tracking lane utilization, benchmark rates, transit times, and OTIF targets by origin-destination pair"
  source: "`vibe_consumer_goods_v1`.`logistics`.`lane`"
  dimensions:
    - name: "lane_status"
      expr: lane_status
      comment: "Current status of the lane (e.g., active, inactive, pending)"
    - name: "classification"
      expr: classification
      comment: "Lane classification (e.g., strategic, tactical, spot)"
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transportation for this lane"
    - name: "service_level"
      expr: service_level
      comment: "Service level agreement tier"
    - name: "equipment_type"
      expr: equipment_type
      comment: "Type of equipment required"
    - name: "origin_country_code"
      expr: origin_country_code
      comment: "Origin country code"
    - name: "destination_country_code"
      expr: destination_country_code
      comment: "Destination country code"
    - name: "cross_border"
      expr: cross_border
      comment: "Whether lane crosses international borders"
    - name: "cold_chain_required"
      expr: cold_chain_required
      comment: "Whether lane requires cold chain logistics"
    - name: "hazmat_required"
      expr: hazmat_required
      comment: "Whether lane requires hazmat certification"
    - name: "dsd_eligible"
      expr: dsd_eligible
      comment: "Whether lane is eligible for direct store delivery"
    - name: "network_region"
      expr: network_region
      comment: "Network region for the lane"
  measures:
    - name: "total_lanes"
      expr: COUNT(1)
      comment: "Total number of logistics lanes"
    - name: "total_distance_km"
      expr: SUM(CAST(distance_km AS DOUBLE))
      comment: "Total distance across all lanes in kilometers"
    - name: "avg_distance_km"
      expr: AVG(CAST(distance_km AS DOUBLE))
      comment: "Average lane distance in kilometers"
    - name: "total_annual_volume_weight_kg"
      expr: SUM(CAST(annual_volume_weight_kg AS DOUBLE))
      comment: "Total annual volume weight in kilograms"
    - name: "avg_benchmark_rate_per_km"
      expr: AVG(CAST(benchmark_rate_per_km AS DOUBLE))
      comment: "Average benchmark rate per kilometer"
    - name: "avg_benchmark_rate_flat"
      expr: AVG(CAST(benchmark_rate_flat AS DOUBLE))
      comment: "Average flat benchmark rate"
    - name: "avg_otif_target_pct"
      expr: AVG(CAST(otif_target_pct AS DOUBLE))
      comment: "Average OTIF target percentage"
    - name: "avg_carbon_emission_factor"
      expr: AVG(CAST(carbon_emission_factor AS DOUBLE))
      comment: "Average carbon emission factor"
    - name: "cross_border_lane_count"
      expr: SUM(CASE WHEN cross_border = TRUE THEN 1 ELSE 0 END)
      comment: "Count of cross-border lanes"
    - name: "cold_chain_lane_count"
      expr: SUM(CASE WHEN cold_chain_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of lanes requiring cold chain"
    - name: "hazmat_lane_count"
      expr: SUM(CASE WHEN hazmat_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of lanes requiring hazmat certification"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`logistics_shipment_leg`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shipment leg operational and environmental KPIs"
  source: "`vibe_consumer_goods_v1`.`logistics`.`shipment_leg`"
  dimensions:
    - name: "carrier_id"
      expr: carrier_id
      comment: "Carrier handling the leg"
    - name: "transport_mode"
      expr: transport_mode
      comment: "Transport mode for the leg"
    - name: "origin_country_code"
      expr: origin_country_code
      comment: "Origin country code of the leg"
    - name: "destination_country_code"
      expr: destination_country_code
      comment: "Destination country code of the leg"
    - name: "leg_status"
      expr: leg_status
      comment: "Current status of the leg"
    - name: "is_cold_chain"
      expr: is_cold_chain
      comment: "Flag indicating if the leg requires cold chain"
    - name: "is_hazmat"
      expr: is_hazmat
      comment: "Flag indicating if the leg involves hazardous material"
  measures:
    - name: "total_legs"
      expr: COUNT(1)
      comment: "Number of shipment legs"
    - name: "total_gross_weight_kg"
      expr: SUM(CAST(gross_weight_kg AS DOUBLE))
      comment: "Total gross weight across legs"
    - name: "total_freight_cost_amount"
      expr: SUM(CAST(freight_cost_amount AS DOUBLE))
      comment: "Total freight cost amount for legs"
    - name: "avg_actual_transit_hours"
      expr: AVG(CAST(actual_transit_hours AS DOUBLE))
      comment: "Average actual transit time in hours per leg"
    - name: "total_carbon_emissions_kg"
      expr: SUM(CAST(carbon_emissions_kg AS DOUBLE))
      comment: "Total carbon emissions for shipment legs"
$$;