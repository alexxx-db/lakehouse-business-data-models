-- Metric views for domain: planning | Business: Chemical Mfg | Version: 1 | Generated on: 2026-05-06 14:33:25

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`planning_demand_forecast`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Demand forecasting KPIs tracking forecast accuracy, volume, and confidence for strategic planning and supply chain optimization"
  source: "`chemical_mfg_ecm`.`planning`.`demand_forecast`"
  dimensions:
    - name: "forecast_status"
      expr: forecast_status
      comment: "Current status of the demand forecast (draft, approved, final, etc.)"
    - name: "forecast_type"
      expr: forecast_type
      comment: "Type of forecast (statistical, consensus, promotional, etc.)"
    - name: "forecast_method"
      expr: forecast_method
      comment: "Forecasting methodology used (time series, regression, machine learning, etc.)"
    - name: "demand_source"
      expr: demand_source
      comment: "Source of demand signal (customer orders, market analysis, sales input, etc.)"
    - name: "forecast_category"
      expr: forecast_category
      comment: "Business category of the forecast (new product, existing product, promotional, etc.)"
    - name: "planning_bucket"
      expr: planning_bucket
      comment: "Time bucket granularity (daily, weekly, monthly, quarterly)"
    - name: "forecast_period_month"
      expr: DATE_TRUNC('MONTH', forecast_period_start)
      comment: "Forecast period start month for time-series analysis"
    - name: "forecast_period_quarter"
      expr: DATE_TRUNC('QUARTER', forecast_period_start)
      comment: "Forecast period start quarter for executive reporting"
    - name: "is_final"
      expr: is_final
      comment: "Whether this is the final approved forecast version"
    - name: "is_locked"
      expr: is_locked
      comment: "Whether the forecast is locked from further changes"
  measures:
    - name: "total_baseline_quantity"
      expr: SUM(CAST(baseline_quantity AS DOUBLE))
      comment: "Total baseline forecast quantity before adjustments - foundation for demand planning"
    - name: "total_adjusted_quantity"
      expr: SUM(CAST(adjusted_quantity AS DOUBLE))
      comment: "Total adjusted forecast quantity after business overrides - actual planning input"
    - name: "avg_forecast_accuracy"
      expr: AVG(CAST(forecast_accuracy AS DOUBLE))
      comment: "Average forecast accuracy percentage - critical KPI for forecast quality and planning reliability"
    - name: "avg_confidence_level"
      expr: AVG(CAST(confidence_level AS DOUBLE))
      comment: "Average statistical confidence level - measures forecast reliability for risk management"
    - name: "forecast_adjustment_rate"
      expr: ROUND(100.0 * SUM(CAST(adjusted_quantity AS DOUBLE) - CAST(baseline_quantity AS DOUBLE)) / NULLIF(SUM(CAST(baseline_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage adjustment from baseline to final forecast - indicates business judgment override level"
    - name: "distinct_products_forecasted"
      expr: COUNT(DISTINCT chemical_product_id)
      comment: "Number of unique chemical products with active forecasts - portfolio coverage metric"
    - name: "distinct_customers_forecasted"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique customer accounts in forecast - customer base planning coverage"
    - name: "forecast_count"
      expr: COUNT(1)
      comment: "Total number of forecast records - planning activity volume"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`planning_production_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Production planning KPIs tracking capacity utilization, production volume, cost efficiency, and regulatory compliance for manufacturing optimization"
  source: "`chemical_mfg_ecm`.`planning`.`production_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the production plan (draft, approved, active, completed, cancelled)"
    - name: "plan_type"
      expr: plan_type
      comment: "Type of production plan (master, campaign, make-to-order, make-to-stock, etc.)"
    - name: "plan_category"
      expr: plan_category
      comment: "Business category of the plan (regular, promotional, trial, etc.)"
    - name: "production_method"
      expr: production_method
      comment: "Manufacturing method (batch, continuous, semi-continuous, etc.)"
    - name: "demand_source"
      expr: demand_source
      comment: "Source driving production demand (forecast, customer order, inventory replenishment, etc.)"
    - name: "planning_period"
      expr: planning_period
      comment: "Planning time period (weekly, monthly, quarterly, annual)"
    - name: "planning_horizon_month"
      expr: DATE_TRUNC('MONTH', planning_horizon_start)
      comment: "Planning horizon start month for time-series analysis"
    - name: "planning_horizon_quarter"
      expr: DATE_TRUNC('QUARTER', planning_horizon_start)
      comment: "Planning horizon start quarter for executive reporting"
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Whether the plan meets all regulatory compliance requirements"
    - name: "ehs_impact_flag"
      expr: ehs_impact_flag
      comment: "Whether the plan has environmental, health, or safety impact considerations"
    - name: "freeze_horizon_flag"
      expr: freeze_horizon_flag
      comment: "Whether the plan is within the freeze horizon (locked from changes)"
  measures:
    - name: "total_planned_quantity"
      expr: SUM(CAST(planned_quantity AS DOUBLE))
      comment: "Total planned production quantity - primary production volume KPI for capacity and supply planning"
    - name: "avg_capacity_utilization_target"
      expr: AVG(CAST(capacity_utilization_target AS DOUBLE))
      comment: "Average target capacity utilization percentage - critical efficiency KPI for asset optimization"
    - name: "total_cost_estimate"
      expr: SUM(CAST(cost_estimate AS DOUBLE))
      comment: "Total estimated production cost - financial planning and profitability KPI"
    - name: "avg_lot_size"
      expr: AVG(CAST(lot_size AS DOUBLE))
      comment: "Average production lot size - manufacturing efficiency and changeover optimization metric"
    - name: "total_safety_stock"
      expr: SUM(CAST(safety_stock AS DOUBLE))
      comment: "Total safety stock planned - inventory investment and service level KPI"
    - name: "avg_min_inventory_level"
      expr: AVG(CAST(min_inventory_level AS DOUBLE))
      comment: "Average minimum inventory level - working capital and service level balance metric"
    - name: "avg_max_inventory_level"
      expr: AVG(CAST(max_inventory_level AS DOUBLE))
      comment: "Average maximum inventory level - inventory carrying cost and storage capacity metric"
    - name: "distinct_products_planned"
      expr: COUNT(DISTINCT chemical_product_id)
      comment: "Number of unique chemical products in production plans - portfolio complexity metric"
    - name: "distinct_facilities_planned"
      expr: COUNT(DISTINCT facility_id)
      comment: "Number of unique facilities with production plans - manufacturing footprint utilization"
    - name: "production_plan_count"
      expr: COUNT(1)
      comment: "Total number of production plans - planning activity volume"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`planning_supply_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supply planning KPIs tracking supply-demand balance, gap analysis, cost efficiency, and compliance for integrated supply chain optimization"
  source: "`chemical_mfg_ecm`.`planning`.`supply_plan`"
  dimensions:
    - name: "supply_plan_status"
      expr: supply_plan_status
      comment: "Current status of the supply plan (draft, approved, active, executed, cancelled)"
    - name: "plan_type"
      expr: plan_type
      comment: "Type of supply plan (integrated, procurement, production, distribution, etc.)"
    - name: "supply_source"
      expr: supply_source
      comment: "Source of supply (internal production, external procurement, transfer, etc.)"
    - name: "demand_source"
      expr: demand_source
      comment: "Source driving supply demand (forecast, customer order, inventory target, etc.)"
    - name: "planning_methodology"
      expr: planning_methodology
      comment: "Planning methodology used (MRP, constraint-based, optimization, etc.)"
    - name: "constraint_type"
      expr: constraint_type
      comment: "Primary constraint type (capacity, material, regulatory, financial, etc.)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the supply plan (pending, approved, rejected)"
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Whether the plan meets all compliance requirements (regulatory, quality, EHS)"
    - name: "planning_horizon_month"
      expr: DATE_TRUNC('MONTH', planning_horizon_start_date)
      comment: "Planning horizon start month for time-series analysis"
    - name: "planning_horizon_quarter"
      expr: DATE_TRUNC('QUARTER', planning_horizon_start_date)
      comment: "Planning horizon start quarter for executive reporting"
    - name: "priority"
      expr: priority
      comment: "Priority level of the supply plan (critical, high, medium, low)"
  measures:
    - name: "total_planned_supply_quantity"
      expr: SUM(CAST(planned_supply_quantity AS DOUBLE))
      comment: "Total planned supply quantity - primary supply volume KPI for capacity and procurement planning"
    - name: "total_confirmed_supply_quantity"
      expr: SUM(CAST(confirmed_supply_quantity AS DOUBLE))
      comment: "Total confirmed supply quantity - committed supply for service level and reliability analysis"
    - name: "total_supply_gap_quantity"
      expr: SUM(CAST(supply_gap_quantity AS DOUBLE))
      comment: "Total supply gap quantity - critical KPI for supply-demand imbalance and risk management"
    - name: "supply_fulfillment_rate"
      expr: ROUND(100.0 * SUM(CAST(confirmed_supply_quantity AS DOUBLE)) / NULLIF(SUM(CAST(planned_supply_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of planned supply confirmed - supply chain reliability and execution KPI"
    - name: "supply_gap_rate"
      expr: ROUND(100.0 * SUM(CAST(supply_gap_quantity AS DOUBLE)) / NULLIF(SUM(CAST(planned_supply_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of planned supply with gaps - supply risk and shortage exposure metric"
    - name: "total_cost_estimate"
      expr: SUM(CAST(cost_estimate AS DOUBLE))
      comment: "Total estimated supply cost - financial planning and cost optimization KPI"
    - name: "avg_ehs_impact_score"
      expr: AVG(CAST(ehs_impact_score AS DOUBLE))
      comment: "Average environmental, health, and safety impact score - sustainability and compliance metric"
    - name: "distinct_products_planned"
      expr: COUNT(DISTINCT chemical_product_id)
      comment: "Number of unique chemical products in supply plans - portfolio coverage metric"
    - name: "distinct_vendors_planned"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique vendors in supply plans - supplier base diversification metric"
    - name: "supply_plan_count"
      expr: COUNT(1)
      comment: "Total number of supply plans - planning activity volume"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`planning_customer_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer allocation KPIs tracking allocation fulfillment, consumption, compliance, and customer service levels for constrained supply management"
  source: "`chemical_mfg_ecm`.`planning`.`customer_allocation`"
  dimensions:
    - name: "allocation_status"
      expr: allocation_status
      comment: "Current status of the customer allocation (pending, approved, active, consumed, expired, cancelled)"
    - name: "allocation_type"
      expr: allocation_type
      comment: "Type of allocation (quota, priority, fair-share, contract-based, etc.)"
    - name: "allocation_source"
      expr: allocation_source
      comment: "Source of the allocation decision (supply plan, allocation rule, manual override, etc.)"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the allocation (critical, high, medium, low)"
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Whether the allocation meets compliance requirements (regulatory, quality, contract)"
    - name: "regulatory_status"
      expr: regulatory_status
      comment: "Regulatory compliance status of the allocation"
    - name: "ehs_category"
      expr: ehs_category
      comment: "Environmental, health, and safety category of the allocated material"
    - name: "allocation_month"
      expr: DATE_TRUNC('MONTH', allocation_start_date)
      comment: "Allocation start month for time-series analysis"
    - name: "allocation_quarter"
      expr: DATE_TRUNC('QUARTER', allocation_start_date)
      comment: "Allocation start quarter for executive reporting"
    - name: "is_locked"
      expr: is_locked
      comment: "Whether the allocation is locked from changes"
  measures:
    - name: "total_allocated_quantity"
      expr: SUM(CAST(allocated_quantity AS DOUBLE))
      comment: "Total quantity allocated to customers - primary allocation volume KPI for supply distribution"
    - name: "total_consumed_quantity"
      expr: SUM(CAST(consumed_quantity AS DOUBLE))
      comment: "Total quantity consumed by customers - actual demand fulfillment metric"
    - name: "total_remaining_quantity"
      expr: SUM(CAST(remaining_quantity AS DOUBLE))
      comment: "Total remaining allocated quantity - available supply for customer service"
    - name: "allocation_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(consumed_quantity AS DOUBLE)) / NULLIF(SUM(CAST(allocated_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of allocation consumed - critical KPI for allocation accuracy and customer demand patterns"
    - name: "total_allocated_value"
      expr: SUM(CAST(allocated_value AS DOUBLE))
      comment: "Total value of allocated supply - financial impact and revenue potential metric"
    - name: "avg_allocated_value_per_customer"
      expr: AVG(CAST(allocated_value AS DOUBLE))
      comment: "Average allocation value per customer - customer value and allocation equity metric"
    - name: "distinct_customers_allocated"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique customers with allocations - customer base coverage and service breadth"
    - name: "distinct_products_allocated"
      expr: COUNT(DISTINCT chemical_product_id)
      comment: "Number of unique products allocated - portfolio allocation complexity"
    - name: "allocation_count"
      expr: COUNT(1)
      comment: "Total number of customer allocations - allocation activity volume"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`planning_capacity_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capacity planning KPIs tracking utilization, bottlenecks, available vs required capacity for manufacturing optimization and investment decisions"
  source: "`chemical_mfg_ecm`.`planning`.`capacity_plan`"
  dimensions:
    - name: "capacity_plan_status"
      expr: capacity_plan_status
      comment: "Current status of the capacity plan (draft, approved, active, completed)"
    - name: "plan_type"
      expr: plan_type
      comment: "Type of capacity plan (strategic, tactical, operational, scenario)"
    - name: "planning_scenario"
      expr: planning_scenario
      comment: "Planning scenario (base case, optimistic, pessimistic, constraint-based, etc.)"
    - name: "capacity_source"
      expr: capacity_source
      comment: "Source of capacity (internal, external, contracted, etc.)"
    - name: "capacity_unit"
      expr: capacity_unit
      comment: "Unit of capacity measurement (hours, kg, tons, batches, etc.)"
    - name: "bottleneck_flag"
      expr: bottleneck_flag
      comment: "Whether this capacity is a bottleneck constraint - critical for investment prioritization"
    - name: "leveling_status"
      expr: leveling_status
      comment: "Status of capacity leveling (balanced, overloaded, underutilized)"
    - name: "planning_horizon_month"
      expr: DATE_TRUNC('MONTH', planning_horizon_start)
      comment: "Planning horizon start month for time-series analysis"
    - name: "planning_horizon_quarter"
      expr: DATE_TRUNC('QUARTER', planning_horizon_start)
      comment: "Planning horizon start quarter for executive reporting"
  measures:
    - name: "total_available_capacity_hours"
      expr: SUM(CAST(available_capacity_hours AS DOUBLE))
      comment: "Total available capacity in hours - primary capacity supply metric for scheduling and investment"
    - name: "total_required_capacity_hours"
      expr: SUM(CAST(required_capacity_hours AS DOUBLE))
      comment: "Total required capacity in hours - demand on capacity for load balancing"
    - name: "total_available_capacity_kg"
      expr: SUM(CAST(available_capacity_kg AS DOUBLE))
      comment: "Total available capacity in kg - volume-based capacity metric for chemical manufacturing"
    - name: "total_required_capacity_kg"
      expr: SUM(CAST(required_capacity_kg AS DOUBLE))
      comment: "Total required capacity in kg - volume-based demand on capacity"
    - name: "avg_utilization_percentage"
      expr: AVG(CAST(utilization_percentage AS DOUBLE))
      comment: "Average capacity utilization percentage - critical KPI for asset efficiency and investment decisions"
    - name: "capacity_gap_hours"
      expr: SUM(CAST(required_capacity_hours AS DOUBLE) - CAST(available_capacity_hours AS DOUBLE))
      comment: "Total capacity gap in hours - shortfall metric for capacity expansion and outsourcing decisions"
    - name: "capacity_fulfillment_rate"
      expr: ROUND(100.0 * SUM(CAST(available_capacity_hours AS DOUBLE)) / NULLIF(SUM(CAST(required_capacity_hours AS DOUBLE)), 0), 2)
      comment: "Percentage of required capacity available - capacity adequacy KPI for service level and investment"
    - name: "distinct_work_centers_planned"
      expr: COUNT(DISTINCT work_center_id)
      comment: "Number of unique work centers in capacity plans - manufacturing footprint complexity"
    - name: "distinct_equipment_planned"
      expr: COUNT(DISTINCT equipment_id)
      comment: "Number of unique equipment units in capacity plans - asset utilization breadth"
    - name: "capacity_plan_count"
      expr: COUNT(1)
      comment: "Total number of capacity plans - planning activity volume"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`planning_planned_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Planned order KPIs tracking MRP output, procurement vs production mix, lead times, and conversion efficiency for supply execution"
  source: "`chemical_mfg_ecm`.`planning`.`planned_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the planned order (open, firmed, converted, cancelled)"
    - name: "order_type"
      expr: order_type
      comment: "Type of planned order (production, purchase, transfer, subcontract, etc.)"
    - name: "procurement_type"
      expr: procurement_type
      comment: "Procurement type (make, buy, transfer, outsource)"
    - name: "source_of_supply"
      expr: source_of_supply
      comment: "Source of supply for the planned order (internal, external, specific vendor, etc.)"
    - name: "firming_status"
      expr: firming_status
      comment: "Whether the planned order is firmed (locked from MRP changes)"
    - name: "conversion_status"
      expr: conversion_status
      comment: "Status of conversion to actual order (not converted, in progress, converted)"
    - name: "scheduling_status"
      expr: scheduling_status
      comment: "Scheduling status (scheduled, rescheduled, delayed, on-time)"
    - name: "priority"
      expr: priority
      comment: "Priority level of the planned order (critical, high, medium, low)"
    - name: "scheduled_start_month"
      expr: DATE_TRUNC('MONTH', scheduled_start_date)
      comment: "Scheduled start month for time-series analysis"
    - name: "scheduled_start_quarter"
      expr: DATE_TRUNC('QUARTER', scheduled_start_date)
      comment: "Scheduled start quarter for executive reporting"
  measures:
    - name: "total_planned_quantity"
      expr: SUM(CAST(planned_quantity AS DOUBLE))
      comment: "Total planned order quantity - primary MRP output volume for supply execution"
    - name: "total_demand_quantity"
      expr: SUM(CAST(demand_quantity AS DOUBLE))
      comment: "Total demand quantity driving planned orders - demand signal for supply planning"
    - name: "total_supply_quantity"
      expr: SUM(CAST(supply_quantity AS DOUBLE))
      comment: "Total supply quantity from planned orders - supply response to demand"
    - name: "total_cost_estimate"
      expr: SUM(CAST(cost_estimate AS DOUBLE))
      comment: "Total estimated cost of planned orders - financial impact and budget planning KPI"
    - name: "avg_lot_size"
      expr: AVG(CAST(lot_size AS DOUBLE))
      comment: "Average lot size of planned orders - manufacturing efficiency and inventory optimization metric"
    - name: "distinct_materials_planned"
      expr: COUNT(DISTINCT material_master_id)
      comment: "Number of unique materials in planned orders - portfolio complexity and planning breadth"
    - name: "distinct_vendors_planned"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique vendors in planned orders - supplier base utilization"
    - name: "distinct_mrp_runs"
      expr: COUNT(DISTINCT mrp_run_id)
      comment: "Number of unique MRP runs generating planned orders - planning frequency and stability"
    - name: "planned_order_count"
      expr: COUNT(1)
      comment: "Total number of planned orders - MRP output volume and planning activity"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`planning_production_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Production scheduling KPIs tracking schedule adherence, capacity utilization, campaign efficiency, and changeover optimization for shop floor execution"
  source: "`chemical_mfg_ecm`.`planning`.`production_schedule`"
  dimensions:
    - name: "production_schedule_status"
      expr: production_schedule_status
      comment: "Current status of the production schedule (planned, released, in-progress, completed, cancelled)"
    - name: "schedule_type"
      expr: schedule_type
      comment: "Type of production schedule (master, detailed, campaign, maintenance, etc.)"
    - name: "priority"
      expr: priority
      comment: "Priority level of the schedule (critical, high, medium, low)"
    - name: "campaign_flag"
      expr: campaign_flag
      comment: "Whether this is a campaign production schedule (multi-batch, extended run)"
    - name: "freeze_status"
      expr: freeze_status
      comment: "Whether the schedule is frozen (locked from changes)"
    - name: "scheduled_start_month"
      expr: DATE_TRUNC('MONTH', scheduled_start_timestamp)
      comment: "Scheduled start month for time-series analysis"
    - name: "scheduled_start_quarter"
      expr: DATE_TRUNC('QUARTER', scheduled_start_timestamp)
      comment: "Scheduled start quarter for executive reporting"
    - name: "scheduled_start_week"
      expr: DATE_TRUNC('WEEK', scheduled_start_timestamp)
      comment: "Scheduled start week for operational scheduling analysis"
  measures:
    - name: "total_batch_size"
      expr: SUM(CAST(batch_size AS DOUBLE))
      comment: "Total batch size scheduled - primary production volume KPI for throughput and capacity planning"
    - name: "avg_capacity_utilization_percent"
      expr: AVG(CAST(capacity_utilization_percent AS DOUBLE))
      comment: "Average capacity utilization percentage - critical efficiency KPI for asset optimization and investment"
    - name: "avg_batch_size"
      expr: AVG(CAST(batch_size AS DOUBLE))
      comment: "Average batch size - manufacturing efficiency and scale optimization metric"
    - name: "distinct_products_scheduled"
      expr: COUNT(DISTINCT chemical_product_id)
      comment: "Number of unique products scheduled - portfolio complexity and changeover frequency"
    - name: "distinct_work_centers_scheduled"
      expr: COUNT(DISTINCT work_center_id)
      comment: "Number of unique work centers scheduled - manufacturing footprint utilization"
    - name: "distinct_equipment_scheduled"
      expr: COUNT(DISTINCT equipment_id)
      comment: "Number of unique equipment units scheduled - asset utilization breadth"
    - name: "distinct_facilities_scheduled"
      expr: COUNT(DISTINCT facility_id)
      comment: "Number of unique facilities scheduled - site utilization and network optimization"
    - name: "production_schedule_count"
      expr: COUNT(1)
      comment: "Total number of production schedules - scheduling activity volume and complexity"
$$;
