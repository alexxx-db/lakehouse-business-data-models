-- Metric views for domain: supplychain | Business: Retail | Version: 2 | Generated on: 2026-07-12 14:06:09

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`supplychain_purchase_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for purchase order management covering order value, fill rates, lead times, and supplier delivery performance. Used by supply chain leadership to evaluate procurement efficiency and vendor reliability."
  source: "`vibe_retail_v1`.`supplychain`.`purchase_order`"
  dimensions:
    - name: "po_status"
      expr: po_status
      comment: "Current status of the purchase order (e.g. open, confirmed, received, cancelled) for pipeline analysis."
    - name: "po_type"
      expr: po_type
      comment: "Type of purchase order (e.g. standard, blanket, drop-ship) for procurement mix analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status of the purchase order for governance and bottleneck tracking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the purchase order is denominated for multi-currency spend analysis."
    - name: "incoterms_code"
      expr: incoterms_code
      comment: "International commercial terms governing delivery responsibility for logistics cost attribution."
    - name: "is_cross_dock"
      expr: is_cross_dock
      comment: "Indicates whether the order is designated for cross-docking to bypass DC storage."
    - name: "is_drop_ship"
      expr: is_drop_ship
      comment: "Indicates whether the order is fulfilled via direct vendor-to-customer drop shipment."
    - name: "order_date"
      expr: order_date
      comment: "Date the purchase order was placed, used for time-series trend analysis."
    - name: "expected_delivery_date"
      expr: expected_delivery_date
      comment: "Expected delivery date for on-time delivery performance tracking."
    - name: "payment_terms_code"
      expr: payment_terms_code
      comment: "Payment terms agreed with the vendor for cash flow and working capital analysis."
  measures:
    - name: "total_purchase_order_count"
      expr: COUNT(1)
      comment: "Total number of purchase orders. Baseline volume metric for procurement activity tracking."
    - name: "total_order_amount"
      expr: SUM(CAST(total_order_amount AS DOUBLE))
      comment: "Total committed spend across all purchase orders. Core procurement spend KPI used in budget vs. actuals analysis."
    - name: "avg_order_amount"
      expr: AVG(CAST(total_order_amount AS DOUBLE))
      comment: "Average purchase order value. Indicates order sizing trends and negotiation effectiveness."
    - name: "total_ordered_units"
      expr: SUM(CAST(total_ordered_units AS DOUBLE))
      comment: "Total units ordered across all purchase orders. Used for volume planning and vendor capacity assessment."
    - name: "total_received_units"
      expr: SUM(CAST(total_received_units AS DOUBLE))
      comment: "Total units actually received against purchase orders. Compared to ordered units to compute receipt completeness."
    - name: "avg_fill_rate_pct"
      expr: AVG(CAST(fill_rate_pct AS DOUBLE))
      comment: "Average supplier fill rate percentage across purchase orders. Key vendor performance indicator — low fill rate signals supply risk."
    - name: "total_net_payable_amount"
      expr: SUM(CAST(net_payable_amount AS DOUBLE))
      comment: "Total net payable amount after discounts across all purchase orders. Used for accounts payable forecasting and cash management."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount captured on purchase orders. Measures procurement negotiation savings."
    - name: "receipt_fill_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(total_received_units AS DOUBLE)) / NULLIF(SUM(CAST(total_ordered_units AS DOUBLE)), 0), 2)
      comment: "Computed receipt fill rate: received units as a percentage of ordered units. Directly measures supplier delivery completeness and is a primary vendor scorecard KPI."
    - name: "cancelled_order_count"
      expr: COUNT(CASE WHEN po_status = 'cancelled' THEN 1 END)
      comment: "Number of cancelled purchase orders. Elevated cancellation rates signal supply disruption or demand volatility."
    - name: "pending_approval_order_count"
      expr: COUNT(CASE WHEN approval_status = 'pending' THEN 1 END)
      comment: "Number of purchase orders awaiting approval. Tracks procurement workflow bottlenecks that delay supply."
    - name: "distinct_vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of distinct vendors with active purchase orders. Measures supplier base breadth and concentration risk."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`supplychain_po_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-level purchase order KPIs covering unit economics, cost performance, and receipt accuracy. Used by buyers and supply planners to manage item-level procurement efficiency."
  source: "`vibe_retail_v1`.`supplychain`.`po_line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Status of the individual PO line (e.g. open, confirmed, received, cancelled) for line-level pipeline tracking."
    - name: "destination_type"
      expr: destination_type
      comment: "Destination type for the PO line (e.g. DC, store, drop-ship) for routing analysis."
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country where the ordered goods originate. Used for trade compliance and sourcing diversification analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the PO line for multi-currency cost analysis."
    - name: "incoterms"
      expr: incoterms
      comment: "Delivery terms for the PO line governing cost and risk transfer point."
    - name: "moq_compliant"
      expr: moq_compliant
      comment: "Indicates whether the ordered quantity meets the minimum order quantity requirement."
    - name: "requested_delivery_date"
      expr: requested_delivery_date
      comment: "Requested delivery date for the line item, used for on-time delivery analysis."
    - name: "actual_delivery_date"
      expr: actual_delivery_date
      comment: "Actual delivery date for the line item, compared to requested date for lead time variance."
  measures:
    - name: "total_po_line_count"
      expr: COUNT(1)
      comment: "Total number of PO lines. Baseline volume metric for procurement line activity."
    - name: "total_ordered_qty"
      expr: SUM(CAST(ordered_qty AS DOUBLE))
      comment: "Total quantity ordered across all PO lines. Core volume metric for supply planning."
    - name: "total_received_qty"
      expr: SUM(CAST(received_qty AS DOUBLE))
      comment: "Total quantity received against PO lines. Compared to ordered quantity to measure receipt completeness."
    - name: "total_shipped_qty"
      expr: SUM(CAST(shipped_qty AS DOUBLE))
      comment: "Total quantity shipped by vendors against PO lines. Used to identify in-transit inventory."
    - name: "total_extended_cost"
      expr: SUM(CAST(extended_cost AS DOUBLE))
      comment: "Total extended cost (unit cost × quantity) across all PO lines. Primary procurement spend metric at item level."
    - name: "total_net_cost"
      expr: SUM(CAST(net_cost AS DOUBLE))
      comment: "Total net cost after allowances across all PO lines. Measures true landed cost of goods."
    - name: "total_allowance_amount"
      expr: SUM(CAST(allowance_amount AS DOUBLE))
      comment: "Total vendor allowances captured on PO lines. Measures trade deal and promotional funding captured."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost across PO lines. Tracks cost inflation or deflation trends by item."
    - name: "line_receipt_fill_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(received_qty AS DOUBLE)) / NULLIF(SUM(CAST(ordered_qty AS DOUBLE)), 0), 2)
      comment: "Receipt fill rate at line level: received quantity as a percentage of ordered quantity. Granular vendor performance KPI used in buyer scorecards."
    - name: "total_otb_consumed"
      expr: SUM(CAST(otb_consumed AS DOUBLE))
      comment: "Total open-to-buy budget consumed by PO lines. Critical for merchandise financial planning and budget adherence."
    - name: "moq_non_compliant_line_count"
      expr: COUNT(CASE WHEN moq_compliant = FALSE THEN 1 END)
      comment: "Number of PO lines that do not meet minimum order quantity requirements. Non-compliance drives excess freight costs and vendor penalties."
    - name: "distinct_sku_count"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs on purchase order lines. Measures assortment breadth being procured."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`supplychain_demand_forecast`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Demand forecasting accuracy and volume KPIs used by supply planners and merchandising leadership to evaluate forecast quality, identify bias, and drive replenishment decisions."
  source: "`vibe_retail_v1`.`supplychain`.`demand_forecast`"
  dimensions:
    - name: "forecast_type"
      expr: forecast_type
      comment: "Type of forecast (e.g. statistical, consensus, promotional) for forecast method performance comparison."
    - name: "forecast_status"
      expr: forecast_status
      comment: "Current status of the forecast record (e.g. draft, approved, published) for workflow tracking."
    - name: "planning_channel"
      expr: planning_channel
      comment: "Sales channel for which the forecast was generated (e.g. store, e-commerce, wholesale) for channel-level demand analysis."
    - name: "demand_category"
      expr: demand_category
      comment: "Category of demand being forecasted (e.g. base, promotional, seasonal) for demand decomposition."
    - name: "is_promotional_period"
      expr: is_promotional_period
      comment: "Indicates whether the forecast covers a promotional period, enabling promotional vs. base demand comparison."
    - name: "is_new_item"
      expr: is_new_item
      comment: "Indicates whether the forecast is for a new item without historical sales data."
    - name: "is_override_applied"
      expr: is_override_applied
      comment: "Indicates whether a planner override was applied to the statistical forecast."
    - name: "is_latest_version"
      expr: is_latest_version
      comment: "Indicates whether this is the most current forecast version for a given item/location/period."
    - name: "forecast_period_start_date"
      expr: forecast_period_start_date
      comment: "Start date of the forecast period for time-series trend analysis."
    - name: "time_bucket_granularity"
      expr: time_bucket_granularity
      comment: "Granularity of the forecast time bucket (e.g. weekly, daily) for planning horizon analysis."
    - name: "statistical_model_code"
      expr: statistical_model_code
      comment: "Code identifying the statistical model used to generate the forecast for model performance benchmarking."
  measures:
    - name: "total_forecast_records"
      expr: COUNT(1)
      comment: "Total number of forecast records. Baseline volume metric for forecast coverage assessment."
    - name: "total_forecasted_units"
      expr: SUM(CAST(forecasted_units AS DOUBLE))
      comment: "Total forecasted demand units. Primary volume planning metric used to size inventory and replenishment orders."
    - name: "total_baseline_forecast_units"
      expr: SUM(CAST(baseline_forecast_units AS DOUBLE))
      comment: "Total baseline (pre-override) forecasted units. Compared to final forecast to measure planner override impact."
    - name: "total_promotional_lift_units"
      expr: SUM(CAST(promotional_lift_units AS DOUBLE))
      comment: "Total incremental units attributed to promotional activity. Measures promotional demand uplift for event planning."
    - name: "total_override_units"
      expr: SUM(CAST(override_units AS DOUBLE))
      comment: "Total units added or removed via planner overrides. High override volumes may indicate model quality issues."
    - name: "total_forecasted_revenue"
      expr: SUM(CAST(forecasted_revenue AS DOUBLE))
      comment: "Total forecasted revenue across all forecast records. Used for financial planning and budget alignment."
    - name: "avg_mape"
      expr: AVG(CAST(mape AS DOUBLE))
      comment: "Average Mean Absolute Percentage Error across forecasts. Primary forecast accuracy KPI — lower MAPE indicates better model performance."
    - name: "avg_wmape"
      expr: AVG(CAST(wmape AS DOUBLE))
      comment: "Average Weighted Mean Absolute Percentage Error. Volume-weighted forecast accuracy metric preferred for high-velocity SKUs."
    - name: "avg_forecast_bias"
      expr: AVG(CAST(forecast_bias AS DOUBLE))
      comment: "Average forecast bias (systematic over- or under-forecasting). Persistent bias drives excess inventory or stockouts."
    - name: "avg_confidence_level_pct"
      expr: AVG(CAST(confidence_level_pct AS DOUBLE))
      comment: "Average statistical confidence level of forecasts. Low confidence signals high demand uncertainty requiring safety stock buffers."
    - name: "avg_weeks_of_supply"
      expr: AVG(CAST(weeks_of_supply AS DOUBLE))
      comment: "Average projected weeks of supply based on forecast. Key inventory health metric — too high signals overstock, too low signals stockout risk."
    - name: "avg_seasonality_index"
      expr: AVG(CAST(seasonality_index AS DOUBLE))
      comment: "Average seasonality index across forecasts. Measures the degree of seasonal demand variation for inventory positioning."
    - name: "total_replenishment_recommendation_units"
      expr: SUM(CAST(replenishment_recommendation_units AS DOUBLE))
      comment: "Total units recommended for replenishment based on forecast. Directly drives purchase order generation and supply chain execution."
    - name: "override_applied_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_override_applied = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of forecasts where a planner override was applied. High override rates indicate low model trust and manual intervention costs."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`supplychain_replenishment_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Replenishment planning KPIs covering order quantities, inventory health, service level targets, and cost efficiency. Used by supply planners and inventory managers to optimize stock levels and minimize stockouts."
  source: "`vibe_retail_v1`.`supplychain`.`replenishment_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the replenishment plan (e.g. draft, approved, executed) for workflow tracking."
    - name: "plan_type"
      expr: plan_type
      comment: "Type of replenishment plan (e.g. min-max, demand-driven, vendor-managed) for method performance comparison."
    - name: "replenishment_method"
      expr: replenishment_method
      comment: "Replenishment algorithm or method used (e.g. reorder point, periodic review) for methodology analysis."
    - name: "node_type"
      expr: node_type
      comment: "Type of inventory node being replenished (e.g. DC, store, cross-dock) for network-level analysis."
    - name: "buyer_override_flag"
      expr: buyer_override_flag
      comment: "Indicates whether a buyer manually overrode the system-generated replenishment recommendation."
    - name: "moq_compliance_flag"
      expr: moq_compliance_flag
      comment: "Indicates whether the planned order quantity meets the minimum order quantity requirement."
    - name: "promotion_flag"
      expr: promotion_flag
      comment: "Indicates whether the replenishment plan accounts for a promotional event."
    - name: "order_release_date"
      expr: order_release_date
      comment: "Planned date for releasing the replenishment order to the vendor."
    - name: "safety_stock_method"
      expr: safety_stock_method
      comment: "Method used to calculate safety stock (e.g. fixed days, statistical) for inventory policy analysis."
  measures:
    - name: "total_replenishment_plan_count"
      expr: COUNT(1)
      comment: "Total number of replenishment plan records. Baseline volume metric for planning activity."
    - name: "total_planned_order_qty"
      expr: SUM(CAST(planned_order_qty AS DOUBLE))
      comment: "Total units planned for replenishment orders. Primary supply volume metric driving purchase order generation."
    - name: "total_approved_order_qty"
      expr: SUM(CAST(approved_order_qty AS DOUBLE))
      comment: "Total units approved for replenishment. Compared to planned quantity to measure approval rate and buyer intervention."
    - name: "total_planned_order_value"
      expr: SUM(CAST(planned_order_value AS DOUBLE))
      comment: "Total monetary value of planned replenishment orders. Used for open-to-buy budget management and cash flow planning."
    - name: "total_safety_stock_qty"
      expr: SUM(CAST(safety_stock_qty AS DOUBLE))
      comment: "Total safety stock quantity across all replenishment plans. Measures inventory buffer investment to protect service levels."
    - name: "total_current_on_hand_qty"
      expr: SUM(CAST(current_on_hand_qty AS DOUBLE))
      comment: "Total current on-hand inventory quantity across replenishment nodes. Baseline inventory position metric."
    - name: "total_forecasted_demand_qty"
      expr: SUM(CAST(forecasted_demand_qty AS DOUBLE))
      comment: "Total forecasted demand quantity driving replenishment plans. Measures demand signal volume feeding the supply plan."
    - name: "avg_fill_rate_target_pct"
      expr: AVG(CAST(fill_rate_target_pct AS DOUBLE))
      comment: "Average fill rate target set for replenishment plans. Reflects service level ambition across the supply network."
    - name: "avg_service_level_target_pct"
      expr: AVG(CAST(service_level_target_pct AS DOUBLE))
      comment: "Average service level target across replenishment plans. Key supply chain performance commitment metric."
    - name: "avg_weeks_of_supply_target"
      expr: AVG(CAST(weeks_of_supply_target AS DOUBLE))
      comment: "Average target weeks of supply across replenishment plans. Measures intended inventory coverage policy."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost across replenishment plans. Used for inventory valuation and cost trend analysis."
    - name: "buyer_override_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN buyer_override_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of replenishment plans where a buyer manually overrode the system recommendation. High rates indicate low planner confidence in the system."
    - name: "moq_non_compliant_plan_count"
      expr: COUNT(CASE WHEN moq_compliance_flag = FALSE THEN 1 END)
      comment: "Number of replenishment plans that do not meet minimum order quantity requirements. Non-compliance leads to vendor penalties and excess freight costs."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`supplychain_inbound_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inbound shipment performance KPIs covering on-time arrival, weight accuracy, freight cost, and temperature compliance. Used by DC operations and supply chain leadership to manage inbound logistics efficiency."
  source: "`vibe_retail_v1`.`supplychain`.`inbound_shipment`"
  dimensions:
    - name: "shipment_status"
      expr: shipment_status
      comment: "Current status of the inbound shipment (e.g. in-transit, arrived, receiving, complete) for pipeline visibility."
    - name: "shipment_type"
      expr: shipment_type
      comment: "Type of inbound shipment (e.g. vendor, transfer, return) for volume mix analysis."
    - name: "on_time_arrival_flag"
      expr: on_time_arrival_flag
      comment: "Indicates whether the shipment arrived on or before the expected arrival date. Core carrier and vendor performance dimension."
    - name: "cross_dock_flag"
      expr: cross_dock_flag
      comment: "Indicates whether the shipment is designated for cross-docking rather than DC storage."
    - name: "temperature_controlled_flag"
      expr: temperature_controlled_flag
      comment: "Indicates whether the shipment requires temperature-controlled handling."
    - name: "temperature_compliant_flag"
      expr: temperature_compliant_flag
      comment: "Indicates whether the shipment maintained required temperature throughout transit."
    - name: "hazmat_flag"
      expr: hazmat_flag
      comment: "Indicates whether the shipment contains hazardous materials requiring special handling."
    - name: "expected_arrival_date"
      expr: expected_arrival_date
      comment: "Expected arrival date for time-series on-time delivery trend analysis."
    - name: "actual_arrival_date"
      expr: actual_arrival_date
      comment: "Actual arrival date for delivery performance measurement."
    - name: "freight_currency_code"
      expr: freight_currency_code
      comment: "Currency of the freight cost for multi-currency logistics spend analysis."
  measures:
    - name: "total_inbound_shipment_count"
      expr: COUNT(1)
      comment: "Total number of inbound shipments. Baseline volume metric for inbound logistics activity."
    - name: "on_time_arrival_count"
      expr: COUNT(CASE WHEN on_time_arrival_flag = TRUE THEN 1 END)
      comment: "Number of shipments that arrived on time. Numerator for on-time arrival rate calculation."
    - name: "on_time_arrival_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN on_time_arrival_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inbound shipments arriving on or before the expected date. Primary carrier and vendor delivery performance KPI."
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost_amount AS DOUBLE))
      comment: "Total inbound freight cost across all shipments. Key logistics spend metric for cost management and carrier negotiation."
    - name: "avg_freight_cost"
      expr: AVG(CAST(freight_cost_amount AS DOUBLE))
      comment: "Average freight cost per inbound shipment. Used to benchmark carrier rates and identify cost outliers."
    - name: "total_actual_weight_kg"
      expr: SUM(CAST(actual_weight_kg AS DOUBLE))
      comment: "Total actual weight received across inbound shipments. Used for freight cost validation and dock capacity planning."
    - name: "total_expected_weight_kg"
      expr: SUM(CAST(expected_weight_kg AS DOUBLE))
      comment: "Total expected weight across inbound shipments. Compared to actual weight to identify weight discrepancies."
    - name: "weight_variance_kg"
      expr: ROUND(SUM(CAST(actual_weight_kg AS DOUBLE)) - SUM(CAST(expected_weight_kg AS DOUBLE)), 2)
      comment: "Total weight variance (actual minus expected) across inbound shipments. Positive variance indicates overages; negative indicates shortages."
    - name: "temperature_non_compliant_count"
      expr: COUNT(CASE WHEN temperature_controlled_flag = TRUE AND temperature_compliant_flag = FALSE THEN 1 END)
      comment: "Number of temperature-controlled shipments that failed to maintain required temperature. Critical food safety and product quality KPI."
    - name: "temperature_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN temperature_controlled_flag = TRUE AND temperature_compliant_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN temperature_controlled_flag = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of temperature-controlled shipments that maintained required temperature. Regulatory compliance and product quality KPI."
    - name: "total_expected_cube_m3"
      expr: SUM(CAST(expected_cube_m3 AS DOUBLE))
      comment: "Total expected cubic volume of inbound shipments. Used for dock door scheduling and DC capacity planning."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`supplychain_outbound_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Outbound order fulfillment KPIs covering fill rates, on-time shipment, and order volume. Used by DC operations and supply chain leadership to manage outbound logistics performance and store replenishment effectiveness."
  source: "`vibe_retail_v1`.`supplychain`.`outbound_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the outbound order (e.g. planned, released, shipped, delivered) for pipeline visibility."
    - name: "order_type"
      expr: order_type
      comment: "Type of outbound order (e.g. replenishment, transfer, promotional) for volume mix analysis."
    - name: "destination_type"
      expr: destination_type
      comment: "Type of destination (e.g. store, DC, customer) for network flow analysis."
    - name: "replenishment_type"
      expr: replenishment_type
      comment: "Replenishment method driving the outbound order (e.g. push, pull, vendor-managed) for supply strategy analysis."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the outbound order for operational urgency and resource allocation analysis."
    - name: "is_cross_dock"
      expr: is_cross_dock
      comment: "Indicates whether the order flows through cross-docking rather than DC storage."
    - name: "is_drop_ship"
      expr: is_drop_ship
      comment: "Indicates whether the order is fulfilled via direct vendor drop shipment."
    - name: "is_hazmat"
      expr: is_hazmat
      comment: "Indicates whether the order contains hazardous materials."
    - name: "order_date"
      expr: order_date
      comment: "Date the outbound order was created for time-series trend analysis."
    - name: "carrier_service_level"
      expr: carrier_service_level
      comment: "Carrier service level selected for the outbound order (e.g. ground, express) for service mix and cost analysis."
  measures:
    - name: "total_outbound_order_count"
      expr: COUNT(1)
      comment: "Total number of outbound orders. Baseline volume metric for outbound logistics activity."
    - name: "avg_fill_rate_pct"
      expr: AVG(CAST(fill_rate_pct AS DOUBLE))
      comment: "Average fill rate percentage across outbound orders. Measures how completely orders are fulfilled — low fill rate signals inventory or picking failures."
    - name: "total_cube_m3"
      expr: SUM(CAST(total_cube_m3 AS DOUBLE))
      comment: "Total cubic volume shipped across outbound orders. Used for trailer utilization and freight cost analysis."
    - name: "total_weight_kg"
      expr: SUM(CAST(total_weight_kg AS DOUBLE))
      comment: "Total weight shipped across outbound orders. Used for freight cost validation and carrier capacity planning."
    - name: "cancelled_order_count"
      expr: COUNT(CASE WHEN order_status = 'cancelled' THEN 1 END)
      comment: "Number of cancelled outbound orders. Elevated cancellations signal demand volatility or inventory availability issues."
    - name: "cross_dock_order_count"
      expr: COUNT(CASE WHEN is_cross_dock = TRUE THEN 1 END)
      comment: "Number of outbound orders flowing through cross-docking. Measures cross-dock utilization as a DC efficiency strategy."
    - name: "cross_dock_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_cross_dock = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of outbound orders processed via cross-docking. Higher rates indicate more efficient flow-through operations reducing DC handling costs."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`supplychain_outbound_order_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-level outbound order KPIs covering pick accuracy, short shipments, and unit economics. Used by warehouse operations and supply chain analysts to manage picking efficiency and order completeness."
  source: "`vibe_retail_v1`.`supplychain`.`outbound_order_line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Status of the outbound order line (e.g. allocated, picked, packed, shipped) for fulfillment pipeline tracking."
    - name: "substitution_flag"
      expr: substitution_flag
      comment: "Indicates whether a substitute SKU was used to fulfill the line. High substitution rates signal inventory availability issues."
    - name: "is_hazmat"
      expr: is_hazmat
      comment: "Indicates whether the line item contains hazardous materials."
    - name: "is_temperature_controlled"
      expr: is_temperature_controlled
      comment: "Indicates whether the line item requires temperature-controlled handling."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the line item cost for multi-currency analysis."
    - name: "short_ship_reason_code"
      expr: short_ship_reason_code
      comment: "Reason code for short shipment on the line. Used to diagnose root causes of fulfillment failures."
    - name: "expiry_date"
      expr: expiry_date
      comment: "Expiry date of the product on the line for freshness and waste management analysis."
  measures:
    - name: "total_order_line_count"
      expr: COUNT(1)
      comment: "Total number of outbound order lines. Baseline volume metric for line-level fulfillment activity."
    - name: "total_ordered_qty"
      expr: SUM(CAST(ordered_qty AS DOUBLE))
      comment: "Total quantity ordered across all outbound order lines. Baseline demand volume metric."
    - name: "total_allocated_qty"
      expr: SUM(CAST(allocated_qty AS DOUBLE))
      comment: "Total quantity allocated from inventory to outbound order lines. Measures inventory commitment."
    - name: "total_picked_qty"
      expr: SUM(CAST(picked_qty AS DOUBLE))
      comment: "Total quantity picked from warehouse locations. Measures warehouse picking throughput."
    - name: "total_packed_qty"
      expr: SUM(CAST(packed_qty AS DOUBLE))
      comment: "Total quantity packed for shipment. Measures packing throughput and identifies pick-to-pack gaps."
    - name: "total_shipped_qty"
      expr: SUM(CAST(shipped_qty AS DOUBLE))
      comment: "Total quantity shipped on outbound order lines. Primary fulfillment volume metric."
    - name: "total_short_ship_qty"
      expr: SUM(CAST(short_ship_qty AS DOUBLE))
      comment: "Total quantity short-shipped (ordered but not fulfilled). Directly measures fulfillment failures impacting store in-stock levels."
    - name: "short_ship_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(short_ship_qty AS DOUBLE)) / NULLIF(SUM(CAST(ordered_qty AS DOUBLE)), 0), 2)
      comment: "Short shipment rate: short-shipped quantity as a percentage of ordered quantity. Key fulfillment quality KPI — high rates drive store stockouts."
    - name: "total_extended_cost"
      expr: SUM(CAST(extended_cost AS DOUBLE))
      comment: "Total extended cost of outbound order lines. Used for inventory valuation and cost of goods shipped analysis."
    - name: "substitution_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN substitution_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of order lines fulfilled with a substitute SKU. High substitution rates indicate inventory availability problems."
    - name: "pick_accuracy_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(picked_qty AS DOUBLE)) / NULLIF(SUM(CAST(allocated_qty AS DOUBLE)), 0), 2)
      comment: "Pick accuracy rate: picked quantity as a percentage of allocated quantity. Measures warehouse picking precision and labor efficiency."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`supplychain_sla_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor and carrier SLA performance KPIs covering breach rates, fill rates, chargeback exposure, and corrective action status. Used by supply chain leadership and vendor management teams to enforce contractual commitments."
  source: "`vibe_retail_v1`.`supplychain`.`sla_performance`"
  dimensions:
    - name: "sla_type"
      expr: sla_type
      comment: "Type of SLA being measured (e.g. on-time delivery, fill rate, EDI compliance) for performance category analysis."
    - name: "performance_status"
      expr: performance_status
      comment: "Overall performance status against the SLA (e.g. compliant, at-risk, breached) for vendor scorecard reporting."
    - name: "breach_flag"
      expr: breach_flag
      comment: "Indicates whether the SLA was breached in the measurement period. Primary breach indicator for vendor management."
    - name: "breach_severity"
      expr: breach_severity
      comment: "Severity classification of the SLA breach (e.g. minor, major, critical) for escalation prioritization."
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Indicates whether the breach has been escalated for executive attention."
    - name: "chargeback_eligible_flag"
      expr: chargeback_eligible_flag
      comment: "Indicates whether the breach qualifies for a vendor chargeback under contract terms."
    - name: "chargeback_status"
      expr: chargeback_status
      comment: "Current status of the chargeback process (e.g. pending, issued, disputed, resolved)."
    - name: "corrective_action_status"
      expr: corrective_action_status
      comment: "Status of the corrective action plan associated with the SLA breach."
    - name: "measurement_period_start_date"
      expr: measurement_period_start_date
      comment: "Start date of the SLA measurement period for time-series performance trending."
    - name: "measurement_frequency"
      expr: measurement_frequency
      comment: "Frequency at which the SLA is measured (e.g. weekly, monthly) for reporting cadence analysis."
  measures:
    - name: "total_sla_measurement_count"
      expr: COUNT(1)
      comment: "Total number of SLA performance measurements. Baseline volume metric for SLA monitoring coverage."
    - name: "total_breach_count"
      expr: COUNT(CASE WHEN breach_flag = TRUE THEN 1 END)
      comment: "Total number of SLA breaches. Primary vendor compliance KPI — high breach counts trigger contract review and penalties."
    - name: "sla_breach_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN breach_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of SLA measurements resulting in a breach. Core vendor performance scorecard metric used in quarterly business reviews."
    - name: "avg_actual_value"
      expr: AVG(CAST(actual_value AS DOUBLE))
      comment: "Average actual performance value across SLA measurements. Compared to target value to assess overall compliance level."
    - name: "avg_target_value"
      expr: AVG(CAST(target_value AS DOUBLE))
      comment: "Average SLA target value across measurements. Provides context for interpreting actual performance levels."
    - name: "avg_variance_value"
      expr: AVG(CAST(variance_value AS DOUBLE))
      comment: "Average variance between actual and target SLA values. Negative variance indicates underperformance; positive indicates overperformance."
    - name: "avg_fill_rate_pct"
      expr: AVG(CAST(fill_rate_pct AS DOUBLE))
      comment: "Average fill rate percentage across SLA performance records. Key vendor delivery completeness metric."
    - name: "total_chargeback_amount"
      expr: SUM(CAST(chargeback_amount AS DOUBLE))
      comment: "Total chargeback amount assessed against vendors for SLA breaches. Measures financial recovery from non-compliant suppliers."
    - name: "chargeback_eligible_breach_count"
      expr: COUNT(CASE WHEN breach_flag = TRUE AND chargeback_eligible_flag = TRUE THEN 1 END)
      comment: "Number of breaches eligible for vendor chargeback. Measures financial recovery opportunity from SLA non-compliance."
    - name: "escalated_breach_count"
      expr: COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END)
      comment: "Number of SLA breaches escalated for executive attention. Measures severity of vendor performance issues requiring leadership intervention."
    - name: "total_ordered_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total ordered quantity across SLA performance records. Used as denominator for fill rate and receipt rate calculations."
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total received quantity across SLA performance records. Used with ordered quantity to compute receipt fill rate."
    - name: "distinct_vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of distinct vendors with SLA performance records. Measures vendor monitoring coverage breadth."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`supplychain_quality_hold`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality hold KPIs covering hold volumes, disposition outcomes, chargeback recovery, and resolution cycle times. Used by quality assurance and supply chain leadership to manage product quality risk and vendor accountability."
  source: "`vibe_retail_v1`.`supplychain`.`quality_hold`"
  dimensions:
    - name: "hold_status"
      expr: hold_status
      comment: "Current status of the quality hold (e.g. active, released, disposed) for hold pipeline management."
    - name: "hold_type"
      expr: hold_type
      comment: "Type of quality hold (e.g. damage, temperature excursion, labeling, regulatory) for root cause analysis."
    - name: "hold_reason_code"
      expr: hold_reason_code
      comment: "Specific reason code for the quality hold for detailed defect categorization."
    - name: "disposition_decision"
      expr: disposition_decision
      comment: "Final disposition of held inventory (e.g. return to vendor, destroy, rework, release) for waste and recovery analysis."
    - name: "chargeback_eligible_flag"
      expr: chargeback_eligible_flag
      comment: "Indicates whether the quality hold qualifies for a vendor chargeback."
    - name: "is_hazmat"
      expr: is_hazmat
      comment: "Indicates whether the held inventory contains hazardous materials."
    - name: "hold_date"
      expr: hold_date
      comment: "Date the quality hold was initiated for time-series quality trend analysis."
    - name: "affected_entity_type"
      expr: affected_entity_type
      comment: "Type of entity affected by the hold (e.g. SKU, lot, handling unit) for scope analysis."
  measures:
    - name: "total_quality_hold_count"
      expr: COUNT(1)
      comment: "Total number of quality holds initiated. Baseline quality incident volume metric."
    - name: "total_affected_quantity"
      expr: SUM(CAST(affected_quantity AS DOUBLE))
      comment: "Total quantity of inventory placed on quality hold. Measures the scale of quality incidents impacting available inventory."
    - name: "total_chargeback_amount"
      expr: SUM(CAST(chargeback_amount AS DOUBLE))
      comment: "Total chargeback amount assessed against vendors for quality failures. Measures financial recovery from defective goods."
    - name: "chargeback_eligible_hold_count"
      expr: COUNT(CASE WHEN chargeback_eligible_flag = TRUE THEN 1 END)
      comment: "Number of quality holds eligible for vendor chargeback. Measures financial recovery opportunity from quality non-compliance."
    - name: "active_hold_count"
      expr: COUNT(CASE WHEN hold_status = 'active' THEN 1 END)
      comment: "Number of currently active quality holds. Measures current quality risk exposure in the supply chain."
    - name: "avg_temperature_reading_celsius"
      expr: AVG(CAST(temperature_reading_celsius AS DOUBLE))
      comment: "Average temperature reading at time of quality hold. Used to assess cold chain compliance failures."
    - name: "distinct_vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of distinct vendors with quality holds. Measures vendor quality risk concentration."
    - name: "distinct_sku_count"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs affected by quality holds. Measures breadth of quality issues across the assortment."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`supplychain_receiving_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "DC receiving event KPIs covering receipt accuracy, damage rates, temperature compliance, and discrepancy management. Used by DC operations managers to measure inbound receiving quality and labor efficiency."
  source: "`vibe_retail_v1`.`supplychain`.`receiving_event`"
  dimensions:
    - name: "receiving_status"
      expr: receiving_status
      comment: "Status of the receiving event (e.g. in-progress, complete, exception) for receiving pipeline tracking."
    - name: "receiving_type"
      expr: receiving_type
      comment: "Type of receiving event (e.g. vendor, transfer, return) for volume mix analysis."
    - name: "damage_flag"
      expr: damage_flag
      comment: "Indicates whether damaged goods were identified during receiving. Key quality and vendor accountability dimension."
    - name: "shortage_flag"
      expr: shortage_flag
      comment: "Indicates whether a shortage was identified versus the expected quantity."
    - name: "overage_flag"
      expr: overage_flag
      comment: "Indicates whether an overage was identified versus the expected quantity."
    - name: "temperature_compliant_flag"
      expr: temperature_compliant_flag
      comment: "Indicates whether the received shipment maintained required temperature."
    - name: "quality_inspection_required_flag"
      expr: quality_inspection_required_flag
      comment: "Indicates whether a quality inspection was required for the received goods."
    - name: "seal_intact_flag"
      expr: seal_intact_flag
      comment: "Indicates whether the trailer seal was intact upon arrival, a key security and tamper-evidence indicator."
    - name: "hazmat_flag"
      expr: hazmat_flag
      comment: "Indicates whether the received shipment contains hazardous materials."
  measures:
    - name: "total_receiving_event_count"
      expr: COUNT(1)
      comment: "Total number of receiving events. Baseline volume metric for DC inbound activity."
    - name: "damage_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN damage_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of receiving events with damaged goods identified. High damage rates signal carrier or vendor packaging issues."
    - name: "shortage_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN shortage_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of receiving events with quantity shortages. Measures vendor delivery completeness at the DC level."
    - name: "overage_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN overage_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of receiving events with quantity overages. Overages create inventory discrepancies and compliance issues."
    - name: "temperature_non_compliant_count"
      expr: COUNT(CASE WHEN temperature_compliant_flag = FALSE THEN 1 END)
      comment: "Number of receiving events where temperature compliance failed. Critical food safety and product quality KPI."
    - name: "seal_breach_count"
      expr: COUNT(CASE WHEN seal_intact_flag = FALSE THEN 1 END)
      comment: "Number of receiving events where the trailer seal was not intact. Measures cargo security incidents requiring investigation."
    - name: "putaway_task_generation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN putaway_task_generated_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of receiving events that successfully generated putaway tasks. Low rates indicate WMS integration failures delaying inventory availability."
    - name: "temperature_reading_avg_celsius"
      expr: AVG(CAST(temperature_reading AS DOUBLE))
      comment: "Average temperature reading recorded at receiving. Used to monitor cold chain integrity across inbound shipments."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`supplychain_wave`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Warehouse wave management KPIs covering picking productivity, labor efficiency, fill rates, and wave execution performance. Used by DC operations managers to optimize outbound fulfillment throughput."
  source: "`vibe_retail_v1`.`supplychain`.`wave`"
  dimensions:
    - name: "wave_status"
      expr: wave_status
      comment: "Current status of the wave (e.g. planned, released, picking, complete) for execution pipeline tracking."
    - name: "wave_type"
      expr: wave_type
      comment: "Type of wave (e.g. replenishment, promotional, e-commerce) for throughput mix analysis."
    - name: "channel"
      expr: channel
      comment: "Fulfillment channel the wave serves (e.g. store, direct-to-consumer) for channel-level productivity analysis."
    - name: "carrier_service_level"
      expr: carrier_service_level
      comment: "Carrier service level for the wave (e.g. ground, express) for service mix and cost analysis."
    - name: "is_promotional"
      expr: is_promotional
      comment: "Indicates whether the wave contains promotional merchandise requiring priority handling."
    - name: "is_hazmat"
      expr: is_hazmat
      comment: "Indicates whether the wave contains hazardous materials."
    - name: "is_temperature_controlled"
      expr: is_temperature_controlled
      comment: "Indicates whether the wave contains temperature-controlled products."
    - name: "generation_method"
      expr: generation_method
      comment: "Method used to generate the wave (e.g. automatic, manual) for automation effectiveness analysis."
    - name: "temperature_zone"
      expr: temperature_zone
      comment: "Temperature zone of the wave (e.g. ambient, chilled, frozen) for cold chain operations analysis."
  measures:
    - name: "total_wave_count"
      expr: COUNT(1)
      comment: "Total number of waves executed. Baseline volume metric for warehouse outbound activity."
    - name: "avg_fill_rate_pct"
      expr: AVG(CAST(fill_rate_pct AS DOUBLE))
      comment: "Average fill rate percentage across waves. Measures how completely waves fulfill allocated orders — low rates signal inventory or picking failures."
    - name: "total_labor_hours_actual"
      expr: SUM(CAST(labor_hours_actual AS DOUBLE))
      comment: "Total actual labor hours consumed across waves. Primary warehouse labor cost driver for workforce planning."
    - name: "total_labor_hours_planned"
      expr: SUM(CAST(labor_hours_planned AS DOUBLE))
      comment: "Total planned labor hours across waves. Compared to actual hours to measure labor efficiency and planning accuracy."
    - name: "labor_efficiency_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(labor_hours_planned AS DOUBLE)) / NULLIF(SUM(CAST(labor_hours_actual AS DOUBLE)), 0), 2)
      comment: "Labor efficiency rate: planned hours as a percentage of actual hours. Values above 100% indicate better-than-planned productivity; below 100% indicates inefficiency."
    - name: "avg_units_per_hour"
      expr: AVG(CAST(units_per_hour AS DOUBLE))
      comment: "Average picking productivity in units per labor hour. Primary warehouse labor efficiency KPI used in staffing and incentive planning."
    - name: "promotional_wave_count"
      expr: COUNT(CASE WHEN is_promotional = TRUE THEN 1 END)
      comment: "Number of waves containing promotional merchandise. Used to measure promotional fulfillment capacity and prioritization."
    - name: "automated_wave_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN generation_method = 'automatic' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of waves generated automatically by the WMS. Higher automation rates reduce planner workload and improve consistency."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`supplychain_warehouse_task`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Warehouse task execution KPIs covering task completion rates, labor productivity, exception rates, and quantity accuracy. Used by DC operations managers to optimize warehouse labor and identify process failures."
  source: "`vibe_retail_v1`.`supplychain`.`warehouse_task`"
  dimensions:
    - name: "task_status"
      expr: task_status
      comment: "Current status of the warehouse task (e.g. assigned, in-progress, complete, exception) for task pipeline tracking."
    - name: "task_type"
      expr: task_type
      comment: "Type of warehouse task (e.g. pick, putaway, replenishment, cycle count) for labor mix and productivity analysis."
    - name: "task_priority"
      expr: task_priority
      comment: "Priority level of the task for resource allocation and SLA compliance analysis."
    - name: "exception_flag"
      expr: exception_flag
      comment: "Indicates whether the task encountered an exception requiring intervention."
    - name: "exception_reason_code"
      expr: exception_reason_code
      comment: "Reason code for task exceptions for root cause analysis and process improvement."
    - name: "substitution_flag"
      expr: substitution_flag
      comment: "Indicates whether a substitute SKU was used to complete the task."
    - name: "equipment_type"
      expr: equipment_type
      comment: "Type of material handling equipment used for the task for equipment utilization analysis."
    - name: "source_zone"
      expr: source_zone
      comment: "Source warehouse zone for the task for zone-level productivity and slotting analysis."
    - name: "target_zone"
      expr: target_zone
      comment: "Target warehouse zone for the task for flow path and slotting optimization."
  measures:
    - name: "total_task_count"
      expr: COUNT(1)
      comment: "Total number of warehouse tasks. Baseline volume metric for warehouse activity."
    - name: "total_actual_quantity"
      expr: SUM(CAST(actual_quantity AS DOUBLE))
      comment: "Total actual quantity processed across warehouse tasks. Measures warehouse throughput volume."
    - name: "total_planned_quantity"
      expr: SUM(CAST(planned_quantity AS DOUBLE))
      comment: "Total planned quantity across warehouse tasks. Compared to actual quantity to measure task accuracy."
    - name: "total_variance_quantity"
      expr: SUM(CAST(variance_quantity AS DOUBLE))
      comment: "Total quantity variance (actual minus planned) across warehouse tasks. Persistent variance indicates inventory accuracy issues."
    - name: "avg_task_duration_minutes"
      expr: AVG(CAST(task_duration_minutes AS DOUBLE))
      comment: "Average task duration in minutes. Compared to standard labor minutes to measure individual task efficiency."
    - name: "avg_standard_labor_minutes"
      expr: AVG(CAST(standard_labor_minutes AS DOUBLE))
      comment: "Average standard labor minutes per task. Used as the benchmark for labor efficiency measurement."
    - name: "labor_efficiency_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(standard_labor_minutes AS DOUBLE)) / NULLIF(SUM(CAST(task_duration_minutes AS DOUBLE)), 0), 2)
      comment: "Labor efficiency rate: standard minutes as a percentage of actual minutes. Values above 100% indicate above-standard productivity."
    - name: "exception_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN exception_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of warehouse tasks that encountered exceptions. High exception rates signal process failures, equipment issues, or inventory inaccuracies."
    - name: "avg_travel_distance_feet"
      expr: AVG(CAST(travel_distance_feet AS DOUBLE))
      comment: "Average travel distance per warehouse task in feet. Used for slotting optimization — reducing travel distance improves picking productivity."
    - name: "substitution_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN substitution_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of warehouse tasks completed with a substitute SKU. High rates indicate inventory availability failures at the pick location."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`supplychain_cross_dock_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cross-docking plan KPIs covering dwell time, fill rates, and plan execution accuracy. Used by DC operations and supply chain planners to optimize flow-through efficiency and reduce DC handling costs."
  source: "`vibe_retail_v1`.`supplychain`.`plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the cross-dock plan (e.g. planned, in-progress, complete) for execution pipeline tracking."
  measures:
    - name: "total_cross_dock_plan_count"
      expr: COUNT(1)
      comment: "Total number of cross-dock plans. Baseline volume metric for cross-docking activity."
    - name: "distinct_vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of distinct vendors with cross-dock plans. Measures vendor participation in flow-through operations."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`supplychain_edi_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "EDI transaction processing KPIs covering compliance scores, processing success rates, SLA breach rates, and error volumes. Used by supply chain IT and vendor management teams to ensure electronic trading partner connectivity and data quality."
  source: "`vibe_retail_v1`.`supplychain`.`supplychain_edi_transaction`"
  dimensions:
    - name: "processing_status"
      expr: processing_status
      comment: "Current processing status of the EDI transaction (e.g. received, processed, failed, acknowledged) for pipeline monitoring."
    - name: "transaction_set_code"
      expr: transaction_set_code
      comment: "EDI transaction set code (e.g. 850 PO, 856 ASN, 810 invoice) for transaction type volume analysis."
    - name: "direction"
      expr: direction
      comment: "Direction of the EDI transaction (inbound or outbound) for flow analysis."
    - name: "edi_standard"
      expr: edi_standard
      comment: "EDI standard used (e.g. ANSI X12, EDIFACT) for standards compliance analysis."
    - name: "functional_ack_status"
      expr: functional_ack_status
      comment: "Status of the functional acknowledgement (e.g. accepted, rejected, pending) for trading partner connectivity monitoring."
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Indicates whether the EDI transaction breached its processing SLA."
    - name: "transmission_protocol"
      expr: transmission_protocol
      comment: "Protocol used for EDI transmission (e.g. AS2, SFTP, VAN) for connectivity analysis."
  measures:
    - name: "total_edi_transaction_count"
      expr: COUNT(1)
      comment: "Total number of EDI transactions processed. Baseline volume metric for electronic trading partner activity."
    - name: "avg_compliance_score"
      expr: AVG(CAST(compliance_score AS DOUBLE))
      comment: "Average EDI compliance score across transactions. Measures overall trading partner data quality and standards adherence."
    - name: "sla_breach_count"
      expr: COUNT(CASE WHEN sla_breach_flag = TRUE THEN 1 END)
      comment: "Number of EDI transactions that breached processing SLA. High breach counts indicate connectivity or processing capacity issues."
    - name: "sla_breach_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sla_breach_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of EDI transactions breaching processing SLA. Key trading partner performance KPI used in vendor scorecards."
    - name: "processing_failure_count"
      expr: COUNT(CASE WHEN processing_status = 'failed' THEN 1 END)
      comment: "Number of EDI transactions that failed processing. Processing failures disrupt order and shipment workflows."
    - name: "processing_success_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN processing_status = 'processed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of EDI transactions successfully processed. Core EDI system reliability KPI."
    - name: "avg_sla_target_hours"
      expr: AVG(CAST(sla_target_hours AS DOUBLE))
      comment: "Average SLA target processing time in hours across EDI transactions. Provides context for SLA breach analysis."
    - name: "total_document_size_bytes"
      expr: SUM(CAST(document_size_bytes AS DOUBLE))
      comment: "Total document size in bytes across EDI transactions. Used for network capacity planning and transmission cost analysis."
    - name: "distinct_trading_partner_count"
      expr: COUNT(DISTINCT supplychain_vendor_id)
      comment: "Number of distinct trading partners with EDI transactions. Measures electronic connectivity breadth across the vendor base."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`supplychain_dc_facility`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Distribution center capacity and capability KPIs for network planning, site selection, and facility investment decisions"
  source: "`vibe_retail_v1`.`supplychain`.`dc_facility`"
  dimensions:
    - name: "facility_status"
      expr: facility_status
      comment: "Facility status for tracking operational network footprint"
    - name: "facility_type"
      expr: facility_type
      comment: "Facility type for segmenting DC capabilities and strategies"
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership type for lease vs own financial analysis"
    - name: "automation_level"
      expr: automation_level
      comment: "Automation level for technology investment and productivity benchmarking"
    - name: "bonded_warehouse_flag"
      expr: bonded_warehouse_flag
      comment: "Bonded warehouse flag for customs and import capability"
    - name: "hazmat_certified_flag"
      expr: hazmat_certified_flag
      comment: "Hazmat certified flag for compliance capability tracking"
    - name: "twenty_four_seven_operation_flag"
      expr: twenty_four_seven_operation_flag
      comment: "24/7 operation flag for capacity and service level capability"
    - name: "temperature_zone_frozen_flag"
      expr: temperature_zone_frozen_flag
      comment: "Frozen temperature zone flag for cold chain capability"
  measures:
    - name: "total_storage_capacity_cubic_feet"
      expr: SUM(CAST(storage_capacity_cubic_feet AS DOUBLE))
      comment: "Total storage capacity in cubic feet for network capacity planning and expansion decisions"
    - name: "total_warehouse_square_footage"
      expr: SUM(CAST(warehouse_square_footage AS DOUBLE))
      comment: "Total warehouse square footage for facility footprint and real estate investment tracking"
    - name: "avg_latitude"
      expr: AVG(CAST(latitude AS DOUBLE))
      comment: "Average latitude for geographic network center-of-gravity analysis"
    - name: "avg_longitude"
      expr: AVG(CAST(longitude AS DOUBLE))
      comment: "Average longitude for geographic network center-of-gravity analysis"
    - name: "facility_count"
      expr: COUNT(1)
      comment: "Count of DC facilities for network footprint and complexity management"
$$;