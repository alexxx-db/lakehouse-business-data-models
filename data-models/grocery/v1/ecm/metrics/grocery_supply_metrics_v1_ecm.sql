-- Metric views for domain: supply | Business: Grocery | Version: 1 | Generated on: 2026-05-04 18:32:13

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`supply_allocation_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key performance indicators for allocation planning efficiency and effectiveness"
  source: "`grocery_ecm`.`supply`.`allocation_plan`"
  dimensions:
    - name: "allocation_method"
      expr: allocation_method
      comment: "Method used to allocate inventory (e.g., manual, automated)"
    - name: "allocation_type"
      expr: allocation_type
      comment: "Type of allocation (e.g., replenishment, promotional)"
    - name: "priority_level"
      expr: priority_level
      comment: "Business priority assigned to the allocation plan"
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the allocation plan"
    - name: "cold_chain_required_flag"
      expr: cold_chain_required_flag
      comment: "Indicates if cold‑chain handling is required"
    - name: "dc_facility_id"
      expr: dc_facility_id
      comment: "Distribution center facility identifier"
    - name: "plan_created_month"
      expr: DATE_TRUNC('month', plan_created_date)
      comment: "Month the allocation plan was created"
  measures:
    - name: "total_allocation_plans"
      expr: COUNT(1)
      comment: "Count of allocation plans created"
    - name: "avg_actual_fill_rate_pct"
      expr: AVG(CAST(actual_fill_rate_pct AS DOUBLE))
      comment: "Average actual fill rate percentage across allocation plans"
    - name: "avg_fill_rate_target_pct"
      expr: AVG(CAST(fill_rate_target_pct AS DOUBLE))
      comment: "Average target fill rate percentage set in allocation plans"
    - name: "avg_fill_rate_gap_pct"
      expr: AVG(actual_fill_rate_pct - fill_rate_target_pct)
      comment: "Average gap between actual and target fill rates (positive indicates under‑performance)"
$$;


CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`supply_demand_forecast`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic demand forecasting health metrics to guide inventory and promotion planning"
  source: "`grocery_ecm`.`supply`.`demand_forecast`"
  dimensions:
    - name: "store_location_id"
      expr: store_location_id
      comment: "Store location identifier"
    - name: "product_item_id"
      expr: product_item_id
      comment: "Product item identifier"
    - name: "forecast_method"
      expr: forecast_method
      comment: "Method used for forecasting (e.g., statistical, ML)"
    - name: "forecast_status"
      expr: forecast_status
      comment: "Current status of the forecast"
    - name: "new_product_indicator"
      expr: new_product_indicator
      comment: "Flag indicating if the product is newly introduced"
    - name: "forecast_month"
      expr: DATE_TRUNC('month', forecast_period_start_date)
      comment: "Month of the forecast period start"
  measures:
    - name: "total_forecast_units"
      expr: SUM(CAST(total_forecast_units AS DOUBLE))
      comment: "Total forecasted units across all SKUs and stores"
    - name: "avg_forecast_bias_pct"
      expr: AVG(CAST(forecast_bias_percentage AS DOUBLE))
      comment: "Average forecast bias percentage (positive = over‑forecast)"
    - name: "avg_mape"
      expr: AVG(CAST(mean_absolute_percentage_error AS DOUBLE))
      comment: "Mean absolute percentage error across forecasts"
    - name: "avg_confidence_score"
      expr: AVG(CAST(forecast_confidence_score AS DOUBLE))
      comment: "Average confidence score assigned by the forecasting model"
$$;


CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`supply_purchase_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial and logistics KPIs for procurement effectiveness"
  source: "`grocery_ecm`.`supply`.`purchase_order`"
  dimensions:
    - name: "supplier_id"
      expr: supplier_id
      comment: "Supplier identifier"
    - name: "store_location_id"
      expr: store_location_id
      comment: "Store location where the purchase order is destined"
    - name: "po_status"
      expr: po_status
      comment: "Current status of the purchase order"
    - name: "po_type"
      expr: po_type
      comment: "Type of purchase order (e.g., regular, emergency)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the purchase order"
    - name: "cold_chain_required_flag"
      expr: cold_chain_required_flag
      comment: "Indicates if cold‑chain handling is required for the PO"
    - name: "order_month"
      expr: DATE_TRUNC('month', order_date)
      comment: "Month the purchase order was created"
  measures:
    - name: "total_purchase_order_value"
      expr: SUM(CAST(total_po_value AS DOUBLE))
      comment: "Total monetary value of purchase orders"
    - name: "avg_order_value"
      expr: AVG(CAST(total_order_amount AS DOUBLE))
      comment: "Average total order amount per purchase order"
    - name: "total_freight_amount"
      expr: SUM(CAST(freight_amount AS DOUBLE))
      comment: "Aggregate freight cost across purchase orders"
    - name: "avg_freight_per_order"
      expr: AVG(CAST(freight_amount AS DOUBLE))
      comment: "Average freight cost per purchase order"
$$;


CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`supply_inbound_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational KPIs for inbound logistics performance"
  source: "`grocery_ecm`.`supply`.`inbound_shipment`"
  dimensions:
    - name: "supplier_id"
      expr: supplier_id
      comment: "Supplier identifier"
    - name: "dc_facility_id"
      expr: dc_facility_id
      comment: "Distribution center receiving the shipment"
    - name: "carrier_id"
      expr: carrier_id
      comment: "Carrier handling the inbound shipment"
    - name: "shipment_status"
      expr: shipment_status
      comment: "Current status of the inbound shipment"
    - name: "temperature_requirement"
      expr: temperature_requirement
      comment: "Temperature requirement for the shipment"
    - name: "priority_level"
      expr: priority_level
      comment: "Business priority assigned to the shipment"
    - name: "scheduled_arrival_month"
      expr: DATE_TRUNC('month', scheduled_arrival_date)
      comment: "Month the shipment was scheduled to arrive"
  measures:
    - name: "total_inbound_weight_lbs"
      expr: SUM(CAST(total_weight_lbs AS DOUBLE))
      comment: "Total inbound weight in pounds"
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost_amount AS DOUBLE))
      comment: "Total freight cost for inbound shipments"
    - name: "shipment_count"
      expr: COUNT(1)
      comment: "Number of inbound shipments"
$$;


CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`supply_replenishment_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs that measure replenishment effectiveness and supplier performance"
  source: "`grocery_ecm`.`supply`.`replenishment_order`"
  dimensions:
    - name: "destination_store_location_id"
      expr: store_location_id
      comment: "Destination store location identifier"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the replenishment order"
    - name: "order_status"
      expr: order_status
      comment: "Current status of the replenishment order"
    - name: "order_type"
      expr: order_type
      comment: "Type of replenishment order (e.g., regular, emergency)"
    - name: "order_month"
      expr: DATE_TRUNC('month', order_date)
      comment: "Month the replenishment order was created"
  measures:
    - name: "total_ordered_quantity"
      expr: SUM(CAST(total_ordered_quantity AS DOUBLE))
      comment: "Total quantity ordered across replenishment orders"
    - name: "total_received_quantity"
      expr: SUM(CAST(total_received_quantity AS DOUBLE))
      comment: "Total quantity actually received"
    - name: "avg_fill_rate_percentage"
      expr: AVG(CAST(fill_rate_percentage AS DOUBLE))
      comment: "Average fill rate percentage for replenishment orders"
    - name: "avg_total_weight_lbs"
      expr: AVG(CAST(total_weight AS DOUBLE))
      comment: "Average total weight (lbs) per replenishment order"
$$;


CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`supply_transport_route`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic logistics KPIs to evaluate route efficiency and cost effectiveness"
  source: "`grocery_ecm`.`supply`.`transport_route`"
  dimensions:
    - name: "carrier_id"
      expr: carrier_id
      comment: "Carrier responsible for the route"
    - name: "route_type"
      expr: route_type
      comment: "Classification of the route (e.g., regional, long‑haul)"
    - name: "route_status"
      expr: route_status
      comment: "Current operational status of the route"
    - name: "temperature_zone_required"
      expr: temperature_zone_required
      comment: "Temperature zone requirement for the route"
    - name: "effective_start_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the route became effective"
  measures:
    - name: "avg_fill_rate_target_pct"
      expr: AVG(CAST(fill_rate_target_pct AS DOUBLE))
      comment: "Average fill‑rate target percentage for routes"
    - name: "avg_on_time_delivery_target_pct"
      expr: AVG(CAST(on_time_delivery_target_pct AS DOUBLE))
      comment: "Average on‑time delivery target percentage"
    - name: "avg_route_cost_per_mile"
      expr: AVG(CAST(route_cost_per_mile AS DOUBLE))
      comment: "Average cost per mile for the route"
    - name: "total_route_distance_miles"
      expr: SUM(CAST(total_route_distance_miles AS DOUBLE))
      comment: "Cumulative distance of all active routes"
$$;
