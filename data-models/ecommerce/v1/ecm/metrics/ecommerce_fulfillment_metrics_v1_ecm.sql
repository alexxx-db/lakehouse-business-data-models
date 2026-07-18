-- Metric views for domain: fulfillment | Business: Ecommerce | Version: 1 | Generated on: 2026-05-04 23:19:28

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`fulfillment_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core fulfillment order performance metrics"
  source: "`ecommerce_ecm`.`fulfillment`.`fulfillment_order`"
  dimensions:
    - name: "order_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Date the order was created"
    - name: "fulfillment_method"
      expr: fulfillment_method
      comment: "Method used to fulfill the order (e.g., ship, pickup)"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority assigned to the order"
    - name: "order_status"
      expr: fulfillment_order_status
      comment: "Current status of the order"
    - name: "order_type"
      expr: order_type
      comment: "Type of order (e.g., standard, BOPIS)"
  measures:
    - name: "total_orders"
      expr: COUNT(1)
      comment: "Total number of fulfillment orders"
    - name: "total_fulfilled_orders"
      expr: SUM(CASE WHEN fulfillment_order_status = 'Fulfilled' THEN 1 ELSE 0 END)
      comment: "Count of orders that reached Fulfilled status"
    - name: "avg_fulfillment_cycle_minutes"
      expr: AVG((unix_timestamp(shipped_timestamp) - unix_timestamp(created_timestamp)) / 60)
      comment: "Average time from order creation to shipment in minutes"
    - name: "avg_order_weight_kg"
      expr: AVG(CAST(total_weight_kg AS DOUBLE))
      comment: "Average weight per order in kilograms"
    - name: "avg_order_volume_m3"
      expr: AVG(CAST(total_volume_m3 AS DOUBLE))
      comment: "Average volume per order in cubic meters"
    - name: "total_weight_kg"
      expr: SUM(CAST(total_weight_kg AS DOUBLE))
      comment: "Total weight of all orders in kilograms"
    - name: "total_volume_m3"
      expr: SUM(CAST(total_volume_m3 AS DOUBLE))
      comment: "Total volume of all orders in cubic meters"
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`fulfillment_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shipment cost, weight, and timeliness metrics"
  source: "`ecommerce_ecm`.`fulfillment`.`fulfillment_shipment`"
  dimensions:
    - name: "shipment_date"
      expr: DATE_TRUNC('day', ship_timestamp)
      comment: "Date the shipment was shipped"
    - name: "carrier_id"
      expr: carrier_id
      comment: "Identifier of the carrier handling the shipment"
    - name: "shipping_method"
      expr: shipping_method
      comment: "Method used for shipping (e.g., ground, air)"
    - name: "shipment_status"
      expr: fulfillment_shipment_status
      comment: "Current status of the shipment"
  measures:
    - name: "total_shipments"
      expr: COUNT(1)
      comment: "Total number of shipments"
    - name: "total_shipping_cost_gross"
      expr: SUM(CAST(shipping_cost_gross AS DOUBLE))
      comment: "Sum of gross shipping costs"
    - name: "avg_shipping_cost_gross"
      expr: AVG(CAST(shipping_cost_gross AS DOUBLE))
      comment: "Average gross shipping cost per shipment"
    - name: "total_weight_kg"
      expr: SUM(CAST(weight_kg AS DOUBLE))
      comment: "Total weight shipped in kilograms"
    - name: "avg_weight_kg"
      expr: AVG(CAST(weight_kg AS DOUBLE))
      comment: "Average weight per shipment in kilograms"
    - name: "on_time_deliveries"
      expr: SUM(CASE WHEN actual_delivery_date <= estimated_delivery_date THEN 1 ELSE 0 END)
      comment: "Count of shipments delivered on or before the estimated date"
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`fulfillment_exception`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Exception volume and severity metrics"
  source: "`ecommerce_ecm`.`fulfillment`.`fulfillment_exception`"
  dimensions:
    - name: "exception_type"
      expr: exception_type
      comment: "Category of the exception"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level assigned to the exception"
    - name: "exception_status"
      expr: exception_status
      comment: "Current processing status of the exception"
    - name: "is_critical"
      expr: is_critical
      comment: "Flag indicating if the exception is critical"
  measures:
    - name: "total_exceptions"
      expr: COUNT(1)
      comment: "Total number of fulfillment exceptions recorded"
    - name: "critical_exceptions"
      expr: SUM(CASE WHEN is_critical THEN 1 ELSE 0 END)
      comment: "Count of exceptions marked as critical"
    - name: "avg_breach_duration_minutes"
      expr: AVG(CAST(breach_duration_minutes AS DOUBLE))
      comment: "Average breach duration in minutes across exceptions"
    - name: "total_breach_duration_minutes"
      expr: SUM(CAST(breach_duration_minutes AS DOUBLE))
      comment: "Total breach duration minutes across all exceptions"
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`fulfillment_pack_station`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pack station capacity and utilization metrics"
  source: "`ecommerce_ecm`.`fulfillment`.`pack_station`"
  dimensions:
    - name: "station_type"
      expr: station_type
      comment: "Type of pack station (e.g., manual, automated)"
    - name: "is_active"
      expr: is_active
      comment: "Indicates if the station is currently active"
    - name: "city"
      expr: city
      comment: "City where the station is located"
    - name: "state"
      expr: state
      comment: "State/Province of the station location"
  measures:
    - name: "station_count"
      expr: COUNT(1)
      comment: "Number of pack stations"
    - name: "avg_utilization_pct"
      expr: AVG(CAST(utilization_pct AS DOUBLE))
      comment: "Average utilization percentage across stations"
    - name: "total_capacity_per_hour"
      expr: SUM(CAST(capacity_per_hour AS DOUBLE))
      comment: "Combined capacity per hour of all stations"
    - name: "avg_current_load_kg"
      expr: AVG(CAST(current_load_kg AS DOUBLE))
      comment: "Average current load in kilograms"
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`fulfillment_pick_wave`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pick wave throughput and efficiency metrics"
  source: "`ecommerce_ecm`.`fulfillment`.`pick_wave`"
  dimensions:
    - name: "wave_type"
      expr: wave_type
      comment: "Classification of the wave (e.g., regular, split)"
    - name: "priority"
      expr: priority
      comment: "Priority assigned to the wave"
    - name: "status"
      expr: pick_wave_status
      comment: "Current status of the wave"
    - name: "is_automated"
      expr: is_automated
      comment: "Indicates if the wave was generated automatically"
  measures:
    - name: "total_waves"
      expr: COUNT(1)
      comment: "Total number of pick waves executed"
    - name: "avg_total_items"
      expr: AVG(CAST(total_items AS DOUBLE))
      comment: "Average number of items per wave"
    - name: "avg_total_quantity"
      expr: AVG(CAST(total_quantity AS DOUBLE))
      comment: "Average total quantity of items per wave"
    - name: "avg_total_orders"
      expr: AVG(CAST(total_orders AS DOUBLE))
      comment: "Average number of orders per wave"
    - name: "sum_total_items"
      expr: SUM(CAST(total_items AS DOUBLE))
      comment: "Sum of items across all waves"
$$;
