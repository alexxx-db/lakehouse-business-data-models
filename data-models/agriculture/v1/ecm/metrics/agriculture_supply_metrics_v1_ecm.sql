-- Metric views for domain: supply | Business: Agriculture | Version: 1 | Generated on: 2026-05-01 16:21:15

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`supply_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key shipment performance and cost metrics"
  source: "`agriculture_ecm`.`supply`.`shipment`"
  dimensions:
    - name: "carrier_id"
      expr: carrier_id
      comment: "Identifier of the carrier handling the shipment"
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport (e.g., truck, rail, ocean)"
    - name: "shipment_status"
      expr: shipment_status
      comment: "Current status of the shipment"
    - name: "origin_country_code"
      expr: origin_country_code
      comment: "ISO country code of origin"
    - name: "destination_country_code"
      expr: destination_country_code
      comment: "ISO country code of destination"
    - name: "requires_cold_chain"
      expr: requires_cold_chain
      comment: "Flag indicating if cold chain handling is required"
    - name: "freight_terms"
      expr: freight_terms
      comment: "Freight terms applied to the shipment"
    - name: "scheduled_arrival_date"
      expr: scheduled_arrival_date
      comment: "Planned arrival date"
    - name: "scheduled_departure_date"
      expr: scheduled_departure_date
      comment: "Planned departure date"
  measures:
    - name: "total_shipments"
      expr: COUNT(1)
      comment: "Total number of shipment records"
    - name: "total_freight_cost_usd"
      expr: SUM(CAST(freight_cost_usd AS DOUBLE))
      comment: "Sum of freight cost in USD across shipments"
    - name: "total_gross_weight_mt"
      expr: SUM(CAST(gross_weight_mt AS DOUBLE))
      comment: "Total gross weight (metric tons) shipped"
    - name: "avg_freight_cost_usd"
      expr: AVG(CAST(freight_cost_usd AS DOUBLE))
      comment: "Average freight cost per shipment in USD"
    - name: "on_time_deliveries"
      expr: SUM(CASE WHEN actual_arrival_timestamp <= TIMESTAMP(scheduled_arrival_date) THEN 1 ELSE 0 END)
      comment: "Count of shipments that arrived on or before the scheduled arrival date"
    - name: "on_time_pickups"
      expr: SUM(CASE WHEN actual_departure_timestamp <= TIMESTAMP(scheduled_departure_date) THEN 1 ELSE 0 END)
      comment: "Count of shipments that departed on or before the scheduled departure date"
$$;


CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`supply_carrier`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Carrier performance and compliance overview"
  source: "`agriculture_ecm`.`supply`.`carrier`"
  dimensions:
    - name: "carrier_type"
      expr: carrier_type
      comment: "Type/category of the carrier"
    - name: "country_code"
      expr: country_code
      comment: "Country where the carrier is registered"
    - name: "cold_chain_capable"
      expr: cold_chain_capable
      comment: "Indicates if carrier can handle cold‑chain shipments"
    - name: "gps_tracking_capable"
      expr: gps_tracking_capable
      comment: "Indicates if carrier has GPS tracking capability"
    - name: "hazmat_certified"
      expr: hazmat_certified
      comment: "Indicates if carrier is certified for hazardous material transport"
    - name: "performance_tier"
      expr: performance_tier
      comment: "Performance tier assigned to the carrier"
    - name: "carrier_status"
      expr: carrier_status
      comment: "Current operational status of the carrier"
  measures:
    - name: "total_carriers"
      expr: COUNT(1)
      comment: "Total number of carrier records"
    - name: "avg_on_time_delivery_rate"
      expr: AVG(CAST(on_time_delivery_rate AS DOUBLE))
      comment: "Average on‑time delivery rate across carriers"
    - name: "avg_on_time_pickup_rate"
      expr: AVG(CAST(on_time_pickup_rate AS DOUBLE))
      comment: "Average on‑time pickup rate across carriers"
    - name: "avg_temperature_excursion_rate"
      expr: AVG(CAST(temperature_excursion_rate AS DOUBLE))
      comment: "Average temperature excursion rate across carriers"
    - name: "avg_compliance_score"
      expr: AVG(CAST(compliance_score AS DOUBLE))
      comment: "Average compliance score across carriers"
$$;


CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`supply_freight_booking`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial and operational metrics for freight bookings"
  source: "`agriculture_ecm`.`supply`.`freight_booking`"
  dimensions:
    - name: "carrier_id"
      expr: carrier_id
      comment: "Carrier associated with the booking"
    - name: "commodity_id"
      expr: commodity_id
      comment: "Commodity being shipped"
    - name: "facility_id"
      expr: facility_id
      comment: "Facility receiving the shipment"
    - name: "booking_status"
      expr: booking_status
      comment: "Current status of the booking"
    - name: "is_food_grade"
      expr: is_food_grade
      comment: "Flag indicating if the booking is for food‑grade cargo"
    - name: "is_hazmat"
      expr: is_hazmat
      comment: "Flag indicating if the booking involves hazardous material"
    - name: "booking_timestamp"
      expr: booking_timestamp
      comment: "Timestamp when the booking was created"
    - name: "delivery_appointment_timestamp"
      expr: delivery_appointment_timestamp
      comment: "Scheduled delivery appointment timestamp"
  measures:
    - name: "total_bookings"
      expr: COUNT(1)
      comment: "Total number of freight bookings"
    - name: "total_freight_amount"
      expr: SUM(CAST(total_freight_amount AS DOUBLE))
      comment: "Sum of total freight amount across bookings"
    - name: "avg_freight_rate"
      expr: AVG(CAST(freight_rate AS DOUBLE))
      comment: "Average freight rate per booking"
    - name: "total_booked_weight_kg"
      expr: SUM(CAST(booked_weight_kg AS DOUBLE))
      comment: "Total booked weight in kilograms"
    - name: "total_booked_volume_m3"
      expr: SUM(CAST(booked_volume_m3 AS DOUBLE))
      comment: "Total booked volume in cubic meters"
    - name: "total_accessorial_amount"
      expr: SUM(CAST(accessorial_amount AS DOUBLE))
      comment: "Sum of accessorial charges across bookings"
$$;


CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`supply_transport_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core transport order KPIs for planning and cost control"
  source: "`agriculture_ecm`.`supply`.`transport_order`"
  dimensions:
    - name: "carrier_id"
      expr: carrier_id
      comment: "Carrier assigned to the transport order"
    - name: "route_id"
      expr: route_id
      comment: "Route identifier for the order"
    - name: "order_status"
      expr: order_status
      comment: "Current status of the transport order"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level assigned to the order"
    - name: "requested_delivery_date"
      expr: requested_delivery_date
      comment: "Requested delivery date and time"
    - name: "requested_pickup_date"
      expr: requested_pickup_date
      comment: "Requested pickup date and time"
  measures:
    - name: "total_orders"
      expr: COUNT(1)
      comment: "Total number of transport orders"
    - name: "total_booked_weight_kg"
      expr: SUM(CAST(booked_weight_kg AS DOUBLE))
      comment: "Sum of booked weight (kg) across transport orders"
    - name: "total_booked_volume_m3"
      expr: SUM(CAST(booked_volume_m3 AS DOUBLE))
      comment: "Sum of booked volume (m³) across transport orders"
    - name: "avg_freight_rate"
      expr: AVG(CAST(freight_rate AS DOUBLE))
      comment: "Average freight rate per transport order"
    - name: "total_freight_rate"
      expr: SUM(CAST(freight_rate AS DOUBLE))
      comment: "Sum of freight rates across transport orders"
$$;
