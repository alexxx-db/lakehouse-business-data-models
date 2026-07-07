-- Metric views for domain: supply | Business: Manufacturing | Version: 2 | Generated on: 2026-07-03 07:46:30

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`supply_demand_forecast`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Demand forecast accuracy, bias, and volume metrics for planning and S&OP steering decisions."
  source: "`vibe_manufacturing_v1`.`supply`.`demand_forecast`"
  dimensions:
    - name: "forecast_status"
      expr: forecast_status
      comment: "Current status of the forecast (e.g., draft, approved, rejected)."
    - name: "forecast_model_name"
      expr: forecast_model_name
      comment: "Name of the forecasting model used (e.g., ARIMA, exponential smoothing)."
    - name: "demand_class"
      expr: demand_class
      comment: "Classification of demand type (e.g., independent, dependent, service)."
    - name: "demand_pattern"
      expr: demand_pattern
      comment: "Observed demand pattern (e.g., seasonal, trend, erratic, lumpy)."
    - name: "customer_segment_code"
      expr: customer_segment_code
      comment: "Customer segment code for demand segmentation analysis."
    - name: "scenario_name"
      expr: scenario_name
      comment: "Planning scenario name (e.g., baseline, optimistic, pessimistic)."
    - name: "promotional_flag"
      expr: promotional_flag
      comment: "Indicates whether the forecast includes promotional uplift."
    - name: "outlier_flag"
      expr: outlier_flag
      comment: "Flags forecasts identified as statistical outliers."
    - name: "forecast_horizon_days"
      expr: forecast_horizon_days
      comment: "Forecast horizon in days (e.g., 30, 60, 90)."
    - name: "planning_period_month"
      expr: DATE_TRUNC('MONTH', planning_period_start_date)
      comment: "Planning period start month for time-series analysis."
    - name: "consensus_approval_month"
      expr: DATE_TRUNC('MONTH', consensus_approval_date)
      comment: "Month when consensus approval was granted."
  measures:
    - name: "total_forecast_quantity"
      expr: SUM(CAST(forecast_quantity AS DOUBLE))
      comment: "Total forecasted demand quantity across all items and periods."
    - name: "avg_forecast_accuracy_percent"
      expr: AVG(CAST(forecast_accuracy_percent AS DOUBLE))
      comment: "Average forecast accuracy percentage — key KPI for demand planning effectiveness."
    - name: "avg_bias_percent"
      expr: AVG(CAST(bias_percent AS DOUBLE))
      comment: "Average forecast bias percentage — measures systematic over/under-forecasting."
    - name: "avg_mape"
      expr: AVG(CAST(mean_absolute_percentage_error AS DOUBLE))
      comment: "Average Mean Absolute Percentage Error — standard forecast accuracy metric."
    - name: "total_sales_adjustment_quantity"
      expr: SUM(CAST(sales_adjustment_quantity AS DOUBLE))
      comment: "Total manual sales adjustments applied to statistical forecasts."
    - name: "avg_promotional_uplift_percent"
      expr: AVG(CAST(promotional_uplift_percent AS DOUBLE))
      comment: "Average promotional uplift percentage applied to base forecasts."
    - name: "forecast_count"
      expr: COUNT(1)
      comment: "Total number of forecast records."
    - name: "distinct_sku_count"
      expr: COUNT(DISTINCT sku_master_id)
      comment: "Number of distinct SKUs with active forecasts."
    - name: "outlier_forecast_count"
      expr: SUM(CASE WHEN outlier_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of forecasts flagged as outliers requiring review."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`supply_material_requirement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "MRP requirement planning metrics — net requirements, exceptions, and inventory balance KPIs for production and procurement decisions."
  source: "`vibe_manufacturing_v1`.`supply`.`material_requirement`"
  dimensions:
    - name: "requirement_status"
      expr: requirement_status
      comment: "Status of the material requirement (e.g., open, firmed, converted)."
    - name: "mrp_element_type"
      expr: mrp_element_type
      comment: "Type of MRP element (e.g., planned order, purchase requisition, stock transfer)."
    - name: "procurement_type"
      expr: procurement_type
      comment: "Procurement type (e.g., in-house production, external procurement, both)."
    - name: "abc_indicator"
      expr: abc_indicator
      comment: "ABC classification indicator for inventory prioritization."
    - name: "exception_message_code"
      expr: exception_message_code
      comment: "MRP exception message code (e.g., reschedule in, reschedule out, cancel)."
    - name: "plant_code"
      expr: plant_code
      comment: "Manufacturing plant or distribution center code."
    - name: "mrp_controller"
      expr: mrp_controller
      comment: "MRP controller responsible for the material."
    - name: "requirement_month"
      expr: DATE_TRUNC('MONTH', requirement_date)
      comment: "Month of the material requirement date."
    - name: "lot_size_key"
      expr: lot_size_key
      comment: "Lot sizing procedure key (e.g., EX=lot-for-lot, FX=fixed lot size)."
  measures:
    - name: "total_gross_requirement_quantity"
      expr: SUM(CAST(gross_requirement_quantity AS DOUBLE))
      comment: "Total gross material requirements before netting against available inventory."
    - name: "total_net_requirement_quantity"
      expr: SUM(CAST(net_requirement_quantity AS DOUBLE))
      comment: "Total net material requirements after netting — drives procurement and production decisions."
    - name: "total_planned_order_quantity"
      expr: SUM(CAST(planned_order_quantity AS DOUBLE))
      comment: "Total planned order quantity generated by MRP to cover net requirements."
    - name: "total_scheduled_receipt_quantity"
      expr: SUM(CAST(scheduled_receipt_quantity AS DOUBLE))
      comment: "Total scheduled receipts (open orders) expected to arrive."
    - name: "total_safety_stock_quantity"
      expr: SUM(CAST(safety_stock_quantity AS DOUBLE))
      comment: "Total safety stock quantity maintained across all materials."
    - name: "avg_projected_available_balance"
      expr: AVG(CAST(projected_available_balance AS DOUBLE))
      comment: "Average projected available inventory balance after requirements and receipts."
    - name: "requirement_count"
      expr: COUNT(1)
      comment: "Total number of material requirement records."
    - name: "exception_count"
      expr: SUM(CASE WHEN exception_message_code IS NOT NULL AND exception_message_code != '' THEN 1 ELSE 0 END)
      comment: "Count of requirements with MRP exceptions requiring planner action."
    - name: "distinct_material_count"
      expr: COUNT(DISTINCT material_master_id)
      comment: "Number of distinct materials with active requirements."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`supply_mrp_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "MRP execution performance metrics — run duration, throughput, exception rates, and planning effectiveness KPIs."
  source: "`vibe_manufacturing_v1`.`supply`.`mrp_run`"
  dimensions:
    - name: "run_status"
      expr: run_status
      comment: "Status of the MRP run (e.g., scheduled, running, completed, failed)."
    - name: "run_type"
      expr: run_type
      comment: "Type of MRP run (e.g., regenerative, net change, single-level)."
    - name: "planning_mode"
      expr: planning_mode
      comment: "Planning mode (e.g., make-to-stock, make-to-order, assemble-to-order)."
    - name: "plant_code"
      expr: plant_code
      comment: "Plant code for which the MRP run was executed."
    - name: "lot_sizing_rule"
      expr: lot_sizing_rule
      comment: "Lot sizing rule applied during the run (e.g., lot-for-lot, fixed lot size, period lot size)."
    - name: "safety_stock_method"
      expr: safety_stock_method
      comment: "Safety stock calculation method used (e.g., fixed, dynamic, service level)."
    - name: "scheduling_method"
      expr: scheduling_method
      comment: "Scheduling method (e.g., forward, backward, lead time scheduling)."
    - name: "run_month"
      expr: DATE_TRUNC('MONTH', actual_start_timestamp)
      comment: "Month when the MRP run was started."
    - name: "include_forecast_flag"
      expr: include_forecast_flag
      comment: "Indicates whether demand forecasts were included in the run."
    - name: "include_safety_stock_flag"
      expr: include_safety_stock_flag
      comment: "Indicates whether safety stock was considered in the run."
  measures:
    - name: "avg_run_duration_minutes"
      expr: AVG(CAST(run_duration_minutes AS DOUBLE))
      comment: "Average MRP run duration in minutes — key performance indicator for planning system efficiency."
    - name: "total_materials_processed"
      expr: SUM(CAST(materials_processed_count AS DOUBLE))
      comment: "Total number of materials processed across all MRP runs."
    - name: "total_planned_orders_created"
      expr: SUM(CAST(planned_orders_created_count AS DOUBLE))
      comment: "Total planned orders created by MRP — measures planning output volume."
    - name: "total_planned_orders_cancelled"
      expr: SUM(CAST(planned_orders_cancelled_count AS DOUBLE))
      comment: "Total planned orders cancelled by MRP — indicates demand volatility or planning instability."
    - name: "total_planned_orders_rescheduled"
      expr: SUM(CAST(planned_orders_rescheduled_count AS DOUBLE))
      comment: "Total planned orders rescheduled by MRP — measures planning nervousness."
    - name: "total_exception_messages"
      expr: SUM(CAST(exception_messages_count AS DOUBLE))
      comment: "Total exception messages generated — requires planner review and action."
    - name: "total_error_messages"
      expr: SUM(CAST(error_messages_count AS DOUBLE))
      comment: "Total error messages generated — indicates data quality or configuration issues."
    - name: "mrp_run_count"
      expr: COUNT(1)
      comment: "Total number of MRP runs executed."
    - name: "completed_run_count"
      expr: SUM(CASE WHEN run_status = 'completed' THEN 1 ELSE 0 END)
      comment: "Count of successfully completed MRP runs."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`supply_planned_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Planned order proposal metrics — volumes, lead times, capacity requirements, and conversion rates for production and procurement planning."
  source: "`vibe_manufacturing_v1`.`supply`.`planned_order`"
  dimensions:
    - name: "proposal_status"
      expr: proposal_status
      comment: "Status of the planned order proposal (e.g., proposed, firmed, converted, deleted)."
    - name: "order_type"
      expr: order_type
      comment: "Type of planned order (e.g., production order, purchase requisition, stock transfer)."
    - name: "plant_code"
      expr: plant_code
      comment: "Plant code where the order is planned."
    - name: "mrp_controller"
      expr: mrp_controller
      comment: "MRP controller responsible for the planned order."
    - name: "priority_code"
      expr: priority_code
      comment: "Priority code for order execution (e.g., high, medium, low)."
    - name: "lot_size_rule"
      expr: lot_size_rule
      comment: "Lot sizing rule applied (e.g., lot-for-lot, fixed lot size, economic order quantity)."
    - name: "firming_indicator"
      expr: firming_indicator
      comment: "Indicates whether the planned order has been firmed by a planner."
    - name: "deletion_flag"
      expr: deletion_flag
      comment: "Indicates whether the planned order is marked for deletion."
    - name: "exception_code"
      expr: exception_code
      comment: "Exception code indicating planning issues (e.g., capacity shortage, material shortage)."
    - name: "scheduled_start_month"
      expr: DATE_TRUNC('MONTH', scheduled_start_date)
      comment: "Month of the planned order scheduled start date."
    - name: "requirement_month"
      expr: DATE_TRUNC('MONTH', requirement_date)
      comment: "Month of the requirement date driving the planned order."
  measures:
    - name: "total_planned_quantity"
      expr: SUM(CAST(planned_quantity AS DOUBLE))
      comment: "Total planned order quantity — represents planned production and procurement volume."
    - name: "total_required_capacity_hours"
      expr: SUM(CAST(required_capacity_hours AS DOUBLE))
      comment: "Total capacity hours required to execute all planned orders — critical for capacity planning."
    - name: "total_available_capacity_hours"
      expr: SUM(CAST(available_capacity_hours AS DOUBLE))
      comment: "Total available capacity hours — used to calculate capacity utilization."
    - name: "avg_supply_risk_score"
      expr: AVG(CAST(supply_risk_score AS DOUBLE))
      comment: "Average supply risk score across planned orders — indicates supply chain vulnerability."
    - name: "total_safety_stock_quantity"
      expr: SUM(CAST(safety_stock_quantity AS DOUBLE))
      comment: "Total safety stock quantity associated with planned orders."
    - name: "planned_order_count"
      expr: COUNT(1)
      comment: "Total number of planned orders."
    - name: "firmed_order_count"
      expr: SUM(CASE WHEN firming_indicator = TRUE THEN 1 ELSE 0 END)
      comment: "Count of firmed planned orders — indicates planner commitment."
    - name: "converted_order_count"
      expr: SUM(CASE WHEN converted_order_number IS NOT NULL AND converted_order_number != '' THEN 1 ELSE 0 END)
      comment: "Count of planned orders converted to firm orders — measures planning execution rate."
    - name: "exception_order_count"
      expr: SUM(CASE WHEN exception_code IS NOT NULL AND exception_code != '' THEN 1 ELSE 0 END)
      comment: "Count of planned orders with exceptions requiring planner intervention."
    - name: "distinct_sku_count"
      expr: COUNT(DISTINCT sku_master_id)
      comment: "Number of distinct SKUs with planned orders."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`supply_safety_stock_policy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Safety stock policy effectiveness metrics — coverage, service levels, holding costs, and inventory optimization KPIs."
  source: "`vibe_manufacturing_v1`.`supply`.`safety_stock_policy`"
  dimensions:
    - name: "policy_status"
      expr: policy_status
      comment: "Status of the safety stock policy (e.g., active, inactive, under review)."
    - name: "calculation_method"
      expr: calculation_method
      comment: "Method used to calculate safety stock (e.g., fixed days, service level, statistical)."
    - name: "abc_classification"
      expr: abc_classification
      comment: "ABC classification for inventory prioritization (A=high value, B=medium, C=low)."
    - name: "xyz_classification"
      expr: xyz_classification
      comment: "XYZ classification for demand variability (X=stable, Y=variable, Z=erratic)."
    - name: "criticality_code"
      expr: criticality_code
      comment: "Material criticality code (e.g., critical, important, standard)."
    - name: "procurement_type"
      expr: procurement_type
      comment: "Procurement type (e.g., in-house production, external procurement)."
    - name: "mrp_type"
      expr: mrp_type
      comment: "MRP type (e.g., reorder point planning, MRP, consumption-based planning)."
    - name: "plant_code"
      expr: plant_code
      comment: "Plant code where the safety stock policy applies."
    - name: "mrp_controller"
      expr: mrp_controller
      comment: "MRP controller responsible for the policy."
    - name: "coverage_profile"
      expr: coverage_profile
      comment: "Coverage profile defining safety stock strategy (e.g., seasonal, standard, promotional)."
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_from_date)
      comment: "Month when the policy became effective."
  measures:
    - name: "total_safety_stock_quantity"
      expr: SUM(CAST(safety_stock_quantity AS DOUBLE))
      comment: "Total safety stock quantity across all materials — represents inventory investment for service level protection."
    - name: "total_reorder_point_quantity"
      expr: SUM(CAST(reorder_point_quantity AS DOUBLE))
      comment: "Total reorder point quantity — triggers replenishment when inventory falls below this level."
    - name: "avg_service_level_target_percent"
      expr: AVG(CAST(service_level_target_percent AS DOUBLE))
      comment: "Average target service level percentage — key KPI for inventory availability goals."
    - name: "avg_demand_variability_coefficient"
      expr: AVG(CAST(demand_variability_coefficient AS DOUBLE))
      comment: "Average demand variability coefficient — measures demand uncertainty driving safety stock needs."
    - name: "avg_lead_time_variability_days"
      expr: AVG(CAST(lead_time_variability_days AS DOUBLE))
      comment: "Average lead time variability in days — measures supply uncertainty."
    - name: "avg_holding_cost_percent_annual"
      expr: AVG(CAST(holding_cost_percent_annual AS DOUBLE))
      comment: "Average annual holding cost percentage — used to calculate inventory carrying costs."
    - name: "avg_stockout_cost_per_unit"
      expr: AVG(CAST(stockout_cost_per_unit AS DOUBLE))
      comment: "Average stockout cost per unit — represents business impact of inventory shortages."
    - name: "total_maximum_stock_level"
      expr: SUM(CAST(maximum_stock_level AS DOUBLE))
      comment: "Total maximum stock level across all materials — upper inventory target."
    - name: "total_minimum_stock_level"
      expr: SUM(CAST(minimum_stock_level AS DOUBLE))
      comment: "Total minimum stock level across all materials — lower inventory threshold."
    - name: "policy_count"
      expr: COUNT(1)
      comment: "Total number of safety stock policies."
    - name: "active_policy_count"
      expr: SUM(CASE WHEN policy_status = 'active' THEN 1 ELSE 0 END)
      comment: "Count of active safety stock policies."
    - name: "distinct_material_count"
      expr: COUNT(DISTINCT material_master_id)
      comment: "Number of distinct materials with safety stock policies."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`supply_sourcing_rule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sourcing strategy and supplier allocation metrics — lead times, pricing, risk levels, and procurement optimization KPIs."
  source: "`vibe_manufacturing_v1`.`supply`.`sourcing_rule`"
  dimensions:
    - name: "rule_status"
      expr: rule_status
      comment: "Status of the sourcing rule (e.g., active, inactive, pending approval)."
    - name: "sourcing_type"
      expr: sourcing_type
      comment: "Type of sourcing (e.g., single source, multi-source, preferred supplier)."
    - name: "make_or_buy_indicator"
      expr: make_or_buy_indicator
      comment: "Indicates whether the material is made in-house or purchased externally."
    - name: "preferred_supplier_flag"
      expr: preferred_supplier_flag
      comment: "Indicates whether this is a preferred supplier sourcing rule."
    - name: "supply_risk_level"
      expr: supply_risk_level
      comment: "Supply risk level (e.g., low, medium, high, critical)."
    - name: "purchasing_organization"
      expr: purchasing_organization
      comment: "Purchasing organization responsible for the sourcing rule."
    - name: "purchasing_group"
      expr: purchasing_group
      comment: "Purchasing group managing the sourcing relationship."
    - name: "lot_sizing_procedure"
      expr: lot_sizing_procedure
      comment: "Lot sizing procedure applied (e.g., lot-for-lot, fixed lot size, economic order quantity)."
    - name: "quota_arrangement_flag"
      expr: quota_arrangement_flag
      comment: "Indicates whether quota arrangement is used for multi-source allocation."
    - name: "automatic_po_flag"
      expr: automatic_po_flag
      comment: "Indicates whether purchase orders are automatically generated."
    - name: "planner_approved_flag"
      expr: planner_approved_flag
      comment: "Indicates whether the sourcing rule has been approved by a planner."
    - name: "valid_from_month"
      expr: DATE_TRUNC('MONTH', valid_from_date)
      comment: "Month when the sourcing rule became valid."
  measures:
    - name: "avg_standard_price"
      expr: AVG(CAST(standard_price AS DOUBLE))
      comment: "Average standard price across sourcing rules — key input for cost planning and variance analysis."
    - name: "avg_allocation_percentage"
      expr: AVG(CAST(allocation_percentage AS DOUBLE))
      comment: "Average supplier allocation percentage — measures sourcing diversification."
    - name: "avg_planned_delivery_time_days"
      expr: AVG(CAST(planned_delivery_time_days AS DOUBLE))
      comment: "Average planned delivery lead time in days — critical for MRP planning and inventory optimization."
    - name: "avg_moq"
      expr: AVG(CAST(moq AS DOUBLE))
      comment: "Average minimum order quantity — impacts lot sizing and inventory levels."
    - name: "avg_maximum_order_quantity"
      expr: AVG(CAST(maximum_order_quantity AS DOUBLE))
      comment: "Average maximum order quantity — constrains procurement flexibility."
    - name: "total_fixed_lot_size"
      expr: SUM(CAST(fixed_lot_size AS DOUBLE))
      comment: "Total fixed lot size across all sourcing rules."
    - name: "sourcing_rule_count"
      expr: COUNT(1)
      comment: "Total number of sourcing rules."
    - name: "active_rule_count"
      expr: SUM(CASE WHEN rule_status = 'active' THEN 1 ELSE 0 END)
      comment: "Count of active sourcing rules."
    - name: "preferred_supplier_count"
      expr: SUM(CASE WHEN preferred_supplier_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of sourcing rules with preferred supplier designation."
    - name: "high_risk_sourcing_count"
      expr: SUM(CASE WHEN supply_risk_level = 'high' OR supply_risk_level = 'critical' THEN 1 ELSE 0 END)
      comment: "Count of sourcing rules with high or critical supply risk — requires mitigation action."
    - name: "distinct_material_count"
      expr: COUNT(DISTINCT material_master_id)
      comment: "Number of distinct materials with sourcing rules."
$$;