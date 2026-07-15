-- Metric views for domain: shipment | Business: Transport Shipping | Version: 1 | Generated on: 2026-05-08 22:31:03

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`shipment_consignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core shipment consignment metrics tracking volume, weight, value, and service performance across booking channels, service types, and geographic corridors"
  source: "`transport_shipping_ecm`.`shipment`.`consignment`"
  dimensions:
    - name: "booking_channel"
      expr: booking_channel
      comment: "Channel through which the consignment was booked (e.g., web, API, agent)"
    - name: "origin_country"
      expr: origin_country_code
      comment: "ISO country code of shipment origin"
    - name: "destination_country"
      expr: destination_country_code
      comment: "ISO country code of shipment destination"
    - name: "priority_level"
      expr: priority_level
      comment: "Service priority level (e.g., express, standard, economy)"
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle status of the consignment"
    - name: "incoterms"
      expr: incoterms_code
      comment: "International commercial terms governing delivery responsibility"
    - name: "is_dangerous_goods"
      expr: is_dangerous_goods
      comment: "Flag indicating whether consignment contains hazardous materials"
    - name: "is_cod"
      expr: is_cod
      comment: "Flag indicating cash-on-delivery service"
    - name: "booking_year_month"
      expr: DATE_TRUNC('month', booking_date)
      comment: "Booking month for time-series analysis"
    - name: "committed_delivery_year_month"
      expr: DATE_TRUNC('month', committed_delivery_date)
      comment: "Committed delivery month for capacity planning"
  measures:
    - name: "total_consignments"
      expr: COUNT(1)
      comment: "Total number of consignments booked"
    - name: "total_chargeable_weight_kg"
      expr: SUM(CAST(chargeable_weight_kg AS DOUBLE))
      comment: "Total chargeable weight in kilograms across all consignments"
    - name: "total_declared_value"
      expr: SUM(CAST(declared_value_amount AS DOUBLE))
      comment: "Total declared value of goods across all consignments"
    - name: "total_cod_amount"
      expr: SUM(CAST(cod_amount AS DOUBLE))
      comment: "Total cash-on-delivery amount to be collected"
    - name: "avg_chargeable_weight_kg"
      expr: AVG(CAST(chargeable_weight_kg AS DOUBLE))
      comment: "Average chargeable weight per consignment"
    - name: "total_volume_cbm"
      expr: SUM(CAST(volume_cbm AS DOUBLE))
      comment: "Total volume in cubic meters"
    - name: "avg_declared_value"
      expr: AVG(CAST(declared_value_amount AS DOUBLE))
      comment: "Average declared value per consignment"
    - name: "unique_shippers"
      expr: COUNT(DISTINCT shipper_profile_id)
      comment: "Number of unique shipper profiles"
    - name: "unique_consignees"
      expr: COUNT(DISTINCT consignee_profile_id)
      comment: "Number of unique consignee profiles"
    - name: "dangerous_goods_consignments"
      expr: SUM(CASE WHEN is_dangerous_goods = TRUE THEN 1 ELSE 0 END)
      comment: "Count of consignments containing dangerous goods"
$$;


CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`shipment_leg`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shipment leg performance metrics tracking transit efficiency, delays, costs, and carbon emissions across transport modes and corridors"
  source: "`transport_shipping_ecm`.`shipment`.`shipment_leg`"
  dimensions:
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport (air, ocean, road, rail)"
    - name: "leg_status"
      expr: leg_status
      comment: "Current status of the shipment leg"
    - name: "origin_location"
      expr: origin_location_code
      comment: "Origin location code for the leg"
    - name: "destination_location"
      expr: destination_location_code
      comment: "Destination location code for the leg"
    - name: "customs_clearance_required"
      expr: customs_clearance_required_flag
      comment: "Flag indicating whether customs clearance is required"
    - name: "hazmat_flag"
      expr: hazmat_flag
      comment: "Flag indicating hazardous materials on this leg"
    - name: "temperature_controlled"
      expr: temperature_controlled_flag
      comment: "Flag indicating temperature-controlled transport"
    - name: "planned_departure_month"
      expr: DATE_TRUNC('month', planned_departure_timestamp)
      comment: "Planned departure month for capacity planning"
  measures:
    - name: "total_legs"
      expr: COUNT(1)
      comment: "Total number of shipment legs"
    - name: "total_distance_km"
      expr: SUM(CAST(distance_km AS DOUBLE))
      comment: "Total distance traveled across all legs in kilometers"
    - name: "total_leg_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost across all shipment legs"
    - name: "total_carbon_emissions_kg"
      expr: SUM(CAST(carbon_emissions_kg AS DOUBLE))
      comment: "Total carbon emissions in kilograms"
    - name: "avg_distance_km"
      expr: AVG(CAST(distance_km AS DOUBLE))
      comment: "Average distance per leg in kilometers"
    - name: "avg_leg_cost"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average cost per shipment leg"
    - name: "legs_with_delays"
      expr: COUNT(CASE WHEN delay_duration_minutes IS NOT NULL AND delay_duration_minutes != '' THEN 1 END)
      comment: "Number of legs experiencing delays"
    - name: "customs_clearance_legs"
      expr: SUM(CASE WHEN customs_clearance_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of legs requiring customs clearance"
    - name: "unique_carriers"
      expr: COUNT(DISTINCT carrier_id)
      comment: "Number of unique carriers used"
    - name: "avg_carbon_emissions_kg"
      expr: AVG(CAST(carbon_emissions_kg AS DOUBLE))
      comment: "Average carbon emissions per leg in kilograms"
$$;


CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`shipment_exception_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Exception and disruption metrics tracking service failures, root causes, financial impact, and resolution performance to drive operational improvement"
  source: "`transport_shipping_ecm`.`shipment`.`exception_event`"
  dimensions:
    - name: "exception_type"
      expr: exception_type
      comment: "Type of exception (e.g., delay, damage, loss, address issue)"
    - name: "exception_status"
      expr: exception_status
      comment: "Current status of the exception (open, in progress, resolved, closed)"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the exception"
    - name: "root_cause_code"
      expr: root_cause_code
      comment: "Root cause code for the exception"
    - name: "responsible_party"
      expr: responsible_party
      comment: "Party responsible for the exception (carrier, customer, warehouse, etc.)"
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Flag indicating whether exception caused SLA breach"
    - name: "preventable_flag"
      expr: preventable_flag
      comment: "Flag indicating whether exception was preventable"
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Flag indicating whether exception was escalated"
    - name: "exception_raised_month"
      expr: DATE_TRUNC('month', exception_raised_timestamp)
      comment: "Month when exception was raised"
  measures:
    - name: "total_exceptions"
      expr: COUNT(1)
      comment: "Total number of exception events"
    - name: "total_financial_impact"
      expr: SUM(CAST(financial_impact_amount AS DOUBLE))
      comment: "Total financial impact of all exceptions"
    - name: "avg_financial_impact"
      expr: AVG(CAST(financial_impact_amount AS DOUBLE))
      comment: "Average financial impact per exception"
    - name: "total_delay_hours"
      expr: SUM(CAST(delay_duration_hours AS DOUBLE))
      comment: "Total delay duration in hours across all exceptions"
    - name: "avg_delay_hours"
      expr: AVG(CAST(delay_duration_hours AS DOUBLE))
      comment: "Average delay duration per exception in hours"
    - name: "sla_breach_exceptions"
      expr: SUM(CASE WHEN sla_breach_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of exceptions that caused SLA breaches"
    - name: "preventable_exceptions"
      expr: SUM(CASE WHEN preventable_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of preventable exceptions"
    - name: "escalated_exceptions"
      expr: SUM(CASE WHEN escalation_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of exceptions that were escalated"
    - name: "claim_eligible_exceptions"
      expr: SUM(CASE WHEN claim_eligible_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of exceptions eligible for claims"
    - name: "unique_consignments_with_exceptions"
      expr: COUNT(DISTINCT consignment_id)
      comment: "Number of unique consignments experiencing exceptions"
$$;


CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`shipment_pod`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Proof of delivery metrics tracking delivery completion, cash collection performance, disputes, and remittance efficiency for last-mile operations"
  source: "`transport_shipping_ecm`.`shipment`.`pod`"
  dimensions:
    - name: "pod_status"
      expr: pod_status
      comment: "Status of proof of delivery (completed, pending, disputed)"
    - name: "delivery_type"
      expr: delivery_type
      comment: "Type of delivery (direct, neighbor, safe place, locker)"
    - name: "delivery_country"
      expr: delivery_country_code
      comment: "Country code where delivery occurred"
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used for COD collection"
    - name: "remittance_status"
      expr: remittance_status
      comment: "Status of cash remittance to shipper"
    - name: "dispute_raised"
      expr: dispute_raised_flag
      comment: "Flag indicating whether delivery was disputed"
    - name: "delivery_month"
      expr: DATE_TRUNC('month', delivery_timestamp)
      comment: "Month when delivery occurred"
  measures:
    - name: "total_deliveries"
      expr: COUNT(1)
      comment: "Total number of proof of delivery records"
    - name: "total_cod_collected"
      expr: SUM(CAST(amount_collected AS DOUBLE))
      comment: "Total cash-on-delivery amount collected"
    - name: "total_cod_due"
      expr: SUM(CAST(cod_amount AS DOUBLE))
      comment: "Total cash-on-delivery amount due"
    - name: "total_collection_variance"
      expr: SUM(CAST(collection_variance_amount AS DOUBLE))
      comment: "Total variance between collected and due amounts"
    - name: "avg_cod_collected"
      expr: AVG(CAST(amount_collected AS DOUBLE))
      comment: "Average cash-on-delivery amount collected per delivery"
    - name: "disputed_deliveries"
      expr: SUM(CASE WHEN dispute_raised_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of deliveries with disputes raised"
    - name: "unique_consignees"
      expr: COUNT(DISTINCT consignee_profile_id)
      comment: "Number of unique consignees receiving deliveries"
    - name: "unique_delivery_agents"
      expr: COUNT(DISTINCT agent_id)
      comment: "Number of unique delivery agents"
    - name: "deliveries_with_signature"
      expr: COUNT(CASE WHEN recipient_signature IS NOT NULL AND recipient_signature != '' THEN 1 END)
      comment: "Number of deliveries with captured signatures"
$$;


CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`shipment_charge`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shipment revenue and cost metrics tracking charges, discounts, taxes, disputes, and waivers across charge categories and service providers"
  source: "`transport_shipping_ecm`.`shipment`.`shipment_charge`"
  dimensions:
    - name: "charge_category"
      expr: charge_category
      comment: "Category of charge (freight, fuel surcharge, accessorial, customs, insurance)"
    - name: "charge_status"
      expr: charge_status
      comment: "Status of the charge (pending, approved, invoiced, paid, disputed)"
    - name: "application_level"
      expr: application_level
      comment: "Level at which charge is applied (consignment, leg, package)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for the charge"
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Flag indicating whether charge is disputed"
    - name: "waived_flag"
      expr: waived_flag
      comment: "Flag indicating whether charge was waived"
    - name: "approval_required"
      expr: approval_required_flag
      comment: "Flag indicating whether charge requires approval"
    - name: "revenue_recognition_month"
      expr: DATE_TRUNC('month', revenue_recognition_date)
      comment: "Month for revenue recognition"
  measures:
    - name: "total_charges"
      expr: COUNT(1)
      comment: "Total number of charge line items"
    - name: "total_charge_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total gross charge amount before discounts and taxes"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount applied"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount"
    - name: "total_net_charge"
      expr: SUM(CAST(net_charge_amount AS DOUBLE))
      comment: "Total net charge amount after discounts and taxes"
    - name: "avg_charge_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average charge amount per line item"
    - name: "disputed_charges"
      expr: SUM(CASE WHEN dispute_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of disputed charges"
    - name: "waived_charges"
      expr: SUM(CASE WHEN waived_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of waived charges"
    - name: "total_waived_amount"
      expr: SUM(CASE WHEN waived_flag = TRUE THEN CAST(amount AS DOUBLE) ELSE 0 END)
      comment: "Total amount of waived charges"
    - name: "unique_consignments_charged"
      expr: COUNT(DISTINCT consignment_id)
      comment: "Number of unique consignments with charges"
$$;


CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`shipment_eta_milestone`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "ETA prediction and milestone performance metrics tracking prediction accuracy, SLA compliance, delays, and notification effectiveness"
  source: "`transport_shipping_ecm`.`shipment`.`eta_milestone`"
  dimensions:
    - name: "milestone_type"
      expr: milestone_type
      comment: "Type of milestone (pickup, departure, arrival, customs, delivery)"
    - name: "sla_status"
      expr: sla_status
      comment: "SLA compliance status (on-time, at-risk, breached)"
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport for this milestone"
    - name: "customs_clearance_status"
      expr: customs_clearance_status
      comment: "Status of customs clearance"
    - name: "exception_flag"
      expr: exception_flag
      comment: "Flag indicating exception at this milestone"
    - name: "notification_sent"
      expr: notification_sent_flag
      comment: "Flag indicating whether notification was sent"
    - name: "prediction_source"
      expr: prediction_source
      comment: "Source of ETA prediction (ML model, carrier, manual)"
    - name: "planned_month"
      expr: DATE_TRUNC('month', original_committed_datetime)
      comment: "Month of original committed milestone"
  measures:
    - name: "total_milestones"
      expr: COUNT(1)
      comment: "Total number of ETA milestone records"
    - name: "avg_prediction_confidence"
      expr: AVG(CAST(prediction_confidence_score AS DOUBLE))
      comment: "Average confidence score of ETA predictions"
    - name: "avg_data_quality_score"
      expr: AVG(CAST(data_quality_score AS DOUBLE))
      comment: "Average data quality score for milestone tracking"
    - name: "avg_variance_hours"
      expr: AVG(CAST(variance_hours AS DOUBLE))
      comment: "Average variance in hours between predicted and actual milestone times"
    - name: "avg_distance_remaining_km"
      expr: AVG(CAST(distance_remaining_km AS DOUBLE))
      comment: "Average remaining distance in kilometers at milestone"
    - name: "milestones_with_exceptions"
      expr: SUM(CASE WHEN exception_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of milestones with exceptions"
    - name: "notifications_sent"
      expr: SUM(CASE WHEN notification_sent_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of milestones where notifications were sent"
    - name: "customs_required_milestones"
      expr: SUM(CASE WHEN customs_clearance_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of milestones requiring customs clearance"
    - name: "unique_consignments_tracked"
      expr: COUNT(DISTINCT consignment_id)
      comment: "Number of unique consignments being tracked"
$$;


CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`shipment_freight_manifest`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Freight manifest and consolidation metrics tracking load utilization, on-time performance, costs, and carbon efficiency across transport modes"
  source: "`transport_shipping_ecm`.`shipment`.`freight_manifest`"
  dimensions:
    - name: "manifest_status"
      expr: manifest_status
      comment: "Status of the freight manifest (open, closed, in-transit, completed)"
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport (air, ocean, road, rail)"
    - name: "equipment_type"
      expr: equipment_type_code
      comment: "Type of equipment used (container, trailer, aircraft)"
    - name: "origin_facility"
      expr: facility_id
      comment: "Origin facility identifier"
    - name: "destination_facility"
      expr: destination_facility_code
      comment: "Destination facility code"
    - name: "dangerous_goods"
      expr: dangerous_goods_flag
      comment: "Flag indicating dangerous goods on manifest"
    - name: "temperature_controlled"
      expr: temperature_controlled_flag
      comment: "Flag indicating temperature-controlled transport"
    - name: "customs_clearance_required"
      expr: customs_clearance_required_flag
      comment: "Flag indicating customs clearance requirement"
    - name: "planned_departure_month"
      expr: DATE_TRUNC('month', planned_departure_timestamp)
      comment: "Planned departure month"
  measures:
    - name: "total_manifests"
      expr: COUNT(1)
      comment: "Total number of freight manifests"
    - name: "total_manifest_weight_kg"
      expr: SUM(CAST(total_weight_kg AS DOUBLE))
      comment: "Total weight across all manifests in kilograms"
    - name: "total_chargeable_weight_kg"
      expr: SUM(CAST(total_chargeable_weight_kg AS DOUBLE))
      comment: "Total chargeable weight in kilograms"
    - name: "total_volume_cbm"
      expr: SUM(CAST(total_volume_cbm AS DOUBLE))
      comment: "Total volume in cubic meters"
    - name: "total_manifest_cost"
      expr: SUM(CAST(manifest_cost_amount AS DOUBLE))
      comment: "Total cost of all manifests"
    - name: "total_carbon_emissions_kg"
      expr: SUM(CAST(carbon_emissions_kg AS DOUBLE))
      comment: "Total carbon emissions in kilograms"
    - name: "avg_manifest_weight_kg"
      expr: AVG(CAST(total_weight_kg AS DOUBLE))
      comment: "Average weight per manifest in kilograms"
    - name: "avg_manifest_cost"
      expr: AVG(CAST(manifest_cost_amount AS DOUBLE))
      comment: "Average cost per manifest"
    - name: "avg_carbon_emissions_kg"
      expr: AVG(CAST(carbon_emissions_kg AS DOUBLE))
      comment: "Average carbon emissions per manifest in kilograms"
    - name: "manifests_with_delays"
      expr: COUNT(CASE WHEN delay_duration_minutes IS NOT NULL AND delay_duration_minutes != '' THEN 1 END)
      comment: "Number of manifests experiencing delays"
    - name: "unique_carriers"
      expr: COUNT(DISTINCT carrier_id)
      comment: "Number of unique carriers used"
$$;
