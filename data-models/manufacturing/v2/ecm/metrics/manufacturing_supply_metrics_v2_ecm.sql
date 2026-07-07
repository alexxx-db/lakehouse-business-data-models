-- Metric views for domain: supply | Business: Manufacturing | Version: 2 | Generated on: 2026-07-03 05:35:52

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`supply_mrp_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational KPIs for MRP planning runs — tracks planning throughput, exception rates, and order churn to steer planning quality and system health."
  source: "`vibe_manufacturing_v1`.`supply`.`mrp_run`"
  dimensions:
    - name: "run_type"
      expr: run_type
      comment: "Type of MRP run (regenerative, net-change, etc.) for segmenting planning performance."
    - name: "run_status"
      expr: run_status
      comment: "Completion status of the MRP run (completed, failed, in-progress) for operational monitoring."
    - name: "planning_mode"
      expr: planning_mode
      comment: "Planning mode used (MRP, MPS, etc.) to compare planning approaches."
    - name: "plant_code"
      expr: plant_code
      comment: "Plant for which the MRP run was executed, enabling plant-level performance comparison."
    - name: "planning_horizon_start_date"
      expr: DATE_TRUNC('month', planning_horizon_start_date)
      comment: "Month of planning horizon start for trend analysis of MRP run frequency."
    - name: "scheduling_method"
      expr: scheduling_method
      comment: "Scheduling method applied (forward/backward) to compare planning strategies."
  measures:
    - name: "total_mrp_runs"
      expr: COUNT(1)
      comment: "Total number of MRP runs executed — baseline volume metric for planning cadence monitoring."
    - name: "avg_run_duration_minutes"
      expr: AVG(CAST(run_duration_minutes AS DOUBLE))
      comment: "Average MRP run duration in minutes — system performance KPI; spikes indicate data or configuration issues requiring intervention."
    - name: "total_planned_orders_created"
      expr: SUM(CAST(planned_orders_created_count AS DOUBLE))
      comment: "Total planned orders created across MRP runs — measures planning output volume and demand coverage."
    - name: "total_planned_orders_cancelled"
      expr: SUM(CAST(planned_orders_cancelled_count AS DOUBLE))
      comment: "Total planned orders cancelled — high cancellation rates signal demand volatility or planning instability."
    - name: "total_planned_orders_rescheduled"
      expr: SUM(CAST(planned_orders_rescheduled_count AS DOUBLE))
      comment: "Total planned orders rescheduled — rescheduling churn is a key indicator of planning nervousness and supply instability."
    - name: "total_exception_messages"
      expr: SUM(CAST(exception_messages_count AS DOUBLE))
      comment: "Total exception messages generated — directly measures planning quality; high counts require planner intervention and drive operational cost."
    - name: "total_materials_processed"
      expr: SUM(CAST(materials_processed_count AS DOUBLE))
      comment: "Total materials processed across MRP runs — scope indicator for planning coverage and system load."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`supply_demand_forecast`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Demand planning accuracy and bias KPIs — measures forecast quality to drive S&OP decisions, inventory investment, and customer service levels."
  source: "`vibe_manufacturing_v1`.`supply`.`demand_forecast`"
  dimensions:
    - name: "forecast_status"
      expr: forecast_status
      comment: "Status of the forecast record (approved, draft, superseded) for filtering active forecasts."
    - name: "demand_class"
      expr: demand_class
      comment: "Demand class (make-to-stock, make-to-order, etc.) for segmenting forecast accuracy by fulfillment strategy."
    - name: "demand_pattern"
      expr: demand_pattern
      comment: "Demand pattern (seasonal, trend, intermittent) to compare forecast model effectiveness by pattern type."
    - name: "forecast_model_name"
      expr: forecast_model_name
      comment: "Forecasting model used — enables model performance benchmarking to guide algorithm selection."
    - name: "planning_period_start_month"
      expr: DATE_TRUNC('month', planning_period_start_date)
      comment: "Planning period month for time-series trend analysis of forecast accuracy."
    - name: "version_type"
      expr: version_type
      comment: "Forecast version type (baseline, consensus, statistical) for comparing planning stages."
    - name: "promotional_flag"
      expr: promotional_flag
      comment: "Whether the forecast includes a promotional uplift — isolates promotional vs. baseline demand accuracy."
    - name: "product_lifecycle_stage"
      expr: product_lifecycle_stage
      comment: "Product lifecycle stage (launch, growth, mature, decline) to assess forecast difficulty by stage."
  measures:
    - name: "avg_forecast_accuracy_percent"
      expr: AVG(CAST(forecast_accuracy_percent AS DOUBLE))
      comment: "Average forecast accuracy percentage — primary S&OP KPI; below target triggers model review and demand sensing investment."
    - name: "avg_mape"
      expr: AVG(CAST(mean_absolute_percentage_error AS DOUBLE))
      comment: "Average Mean Absolute Percentage Error (MAPE) — industry-standard forecast quality metric used in QBRs and S&OP reviews."
    - name: "avg_bias_percent"
      expr: AVG(CAST(bias_percent AS DOUBLE))
      comment: "Average forecast bias percentage — systematic over/under-forecasting drives excess inventory or stockouts; requires corrective action when non-zero."
    - name: "total_forecast_quantity"
      expr: SUM(CAST(forecast_quantity AS DOUBLE))
      comment: "Total forecasted demand quantity — baseline volume for capacity and supply planning decisions."
    - name: "total_sales_adjustment_quantity"
      expr: SUM(CAST(sales_adjustment_quantity AS DOUBLE))
      comment: "Total sales team adjustments to statistical forecasts — large adjustments indicate statistical model gaps or market intelligence not captured in the model."
    - name: "avg_promotional_uplift_percent"
      expr: AVG(CAST(promotional_uplift_percent AS DOUBLE))
      comment: "Average promotional uplift percentage applied — informs trade promotion ROI analysis and inventory pre-build decisions."
    - name: "outlier_forecast_count"
      expr: COUNT(CASE WHEN outlier_flag = TRUE THEN 1 END)
      comment: "Number of forecast records flagged as outliers — high counts indicate data quality issues or exceptional demand events requiring review."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`supply_planned_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Planned order pipeline KPIs — tracks supply coverage, firming rates, and exception exposure to steer procurement and production planning decisions."
  source: "`vibe_manufacturing_v1`.`supply`.`planned_order`"
  dimensions:
    - name: "order_type"
      expr: order_type
      comment: "Planned order type (production, purchase, transfer) for segmenting supply strategy mix."
    - name: "proposal_status"
      expr: proposal_status
      comment: "Current status of the planned order (open, firmed, converted, cancelled) for pipeline visibility."
    - name: "plant_code"
      expr: plant_code
      comment: "Plant associated with the planned order for plant-level supply coverage analysis."
    - name: "requirement_month"
      expr: DATE_TRUNC('month', requirement_date)
      comment: "Month of material requirement date for time-phased supply pipeline analysis."
    - name: "priority_code"
      expr: priority_code
      comment: "Planning priority code to focus attention on high-priority supply gaps."
    - name: "firming_indicator"
      expr: firming_indicator
      comment: "Whether the planned order has been firmed — tracks planning stability and planner intervention rate."
  measures:
    - name: "total_planned_orders"
      expr: COUNT(1)
      comment: "Total planned orders in the pipeline — baseline supply coverage volume metric."
    - name: "total_planned_quantity"
      expr: SUM(CAST(planned_quantity AS DOUBLE))
      comment: "Total planned supply quantity — measures supply pipeline volume against demand requirements."
    - name: "total_planner_override_quantity"
      expr: SUM(CAST(planner_override_quantity AS DOUBLE))
      comment: "Total quantity overridden by planners — high override volumes indicate MRP parameter quality issues or exceptional supply conditions."
    - name: "avg_supply_risk_score"
      expr: AVG(CAST(supply_risk_score AS DOUBLE))
      comment: "Average supply risk score across planned orders — elevated scores trigger risk mitigation actions and safety stock reviews."
    - name: "firmed_order_count"
      expr: COUNT(CASE WHEN firming_indicator = TRUE THEN 1 END)
      comment: "Number of firmed planned orders — firming rate measures planning stability and execution readiness."
    - name: "total_required_capacity_hours"
      expr: SUM(CAST(required_capacity_hours AS DOUBLE))
      comment: "Total capacity hours required by planned orders — critical input for capacity planning and bottleneck identification."
    - name: "total_available_capacity_hours"
      expr: SUM(CAST(available_capacity_hours AS DOUBLE))
      comment: "Total available capacity hours for planned orders — compared against required hours to identify capacity gaps."
    - name: "multi_tier_supplier_order_count"
      expr: COUNT(CASE WHEN multi_tier_supplier_flag = TRUE THEN 1 END)
      comment: "Count of planned orders with multi-tier supplier exposure — measures supply chain complexity and risk concentration."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`supply_capacity_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capacity planning KPIs — measures utilization, overload, and efficiency to drive production scheduling, investment, and workforce decisions."
  source: "`vibe_manufacturing_v1`.`supply`.`plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Status of the capacity plan (active, draft, approved) for filtering actionable plans."
    - name: "planning_period_start_month"
      expr: DATE_TRUNC('month', planning_period_start_date)
      comment: "Planning period month for time-series capacity trend analysis."
  measures:
    - name: "Row Count"
      expr: COUNT(1)
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`supply_inventory_position`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory health and availability KPIs — measures stock coverage, stockout risk, and ATP to steer inventory investment and service level decisions."
  source: "`vibe_manufacturing_v1`.`supply`.`inventory_position`"
  dimensions:
    - name: "abc_classification"
      expr: abc_classification
      comment: "ABC classification of the material — enables differentiated inventory policy by value tier."
    - name: "xyz_classification"
      expr: xyz_classification
      comment: "XYZ demand variability classification — combined with ABC drives safety stock and replenishment strategy."
    - name: "mrp_type"
      expr: mrp_type
      comment: "MRP planning type (MRP, MPS, consumption-based) for segmenting inventory by planning approach."
    - name: "procurement_type"
      expr: procurement_type
      comment: "Procurement type (in-house, external) to compare inventory positions by supply source."
    - name: "plant_code"
      expr: plant_code
      comment: "Plant location for plant-level inventory health monitoring."
    - name: "snapshot_date"
      expr: DATE_TRUNC('week', snapshot_date)
      comment: "Week of inventory snapshot for time-series inventory trend analysis."
    - name: "stock_out_risk_flag"
      expr: stock_out_risk_flag
      comment: "Stockout risk indicator — critical filter for prioritizing replenishment actions."
    - name: "excess_stock_flag"
      expr: excess_stock_flag
      comment: "Excess stock indicator — identifies working capital tied up in surplus inventory."
  measures:
    - name: "total_on_hand_quantity"
      expr: SUM(CAST(on_hand_quantity AS DOUBLE))
      comment: "Total on-hand stock quantity — baseline inventory volume for working capital and coverage analysis."
    - name: "total_available_to_promise_quantity"
      expr: SUM(CAST(available_to_promise_quantity AS DOUBLE))
      comment: "Total available-to-promise quantity — directly drives order fulfillment commitments and customer service level."
    - name: "avg_days_of_supply"
      expr: AVG(CAST(days_of_supply AS DOUBLE))
      comment: "Average days of supply on hand — primary inventory coverage KPI; below safety threshold triggers emergency replenishment."
    - name: "total_net_requirement_quantity"
      expr: SUM(CAST(net_requirement_quantity AS DOUBLE))
      comment: "Total net material requirements — measures uncovered demand requiring supply action."
    - name: "total_safety_stock_quantity"
      expr: SUM(CAST(safety_stock_quantity AS DOUBLE))
      comment: "Total safety stock quantity held — measures buffer inventory investment and policy compliance."
    - name: "stockout_risk_item_count"
      expr: COUNT(CASE WHEN stock_out_risk_flag = TRUE THEN 1 END)
      comment: "Number of items at stockout risk — critical service level KPI; drives emergency procurement and allocation decisions."
    - name: "excess_stock_item_count"
      expr: COUNT(CASE WHEN excess_stock_flag = TRUE THEN 1 END)
      comment: "Number of items with excess stock — measures working capital inefficiency and drives inventory reduction programs."
    - name: "total_open_planned_order_quantity"
      expr: SUM(CAST(open_planned_order_quantity AS DOUBLE))
      comment: "Total quantity on open planned orders — measures inbound supply pipeline to assess future coverage."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`supply_risk_register`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supply chain risk KPIs — measures risk exposure, financial impact, and mitigation effectiveness to steer supply resilience and continuity investments."
  source: "`vibe_manufacturing_v1`.`supply`.`risk_register`"
  dimensions:
    - name: "risk_category"
      expr: risk_category
      comment: "Risk category (supplier, logistics, geopolitical, demand) for segmenting risk portfolio by type."
    - name: "risk_status"
      expr: risk_status
      comment: "Current risk status (open, mitigated, closed, escalated) for tracking risk lifecycle."
    - name: "risk_severity"
      expr: risk_severity
      comment: "Risk severity level (critical, high, medium, low) for prioritizing mitigation resources."
    - name: "mitigation_status"
      expr: mitigation_status
      comment: "Status of mitigation actions — measures risk response effectiveness."
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region of risk origin — identifies regional concentration and geopolitical exposure."
    - name: "identified_month"
      expr: DATE_TRUNC('month', identified_date)
      comment: "Month risk was identified for trend analysis of risk emergence rate."
    - name: "escalation_required_flag"
      expr: escalation_required_flag
      comment: "Whether escalation is required — filters for risks needing executive attention."
  measures:
    - name: "total_open_risks"
      expr: COUNT(CASE WHEN risk_status = 'open' THEN 1 END)
      comment: "Total open supply chain risks — primary risk portfolio size KPI for executive risk reviews."
    - name: "total_financial_impact_amount"
      expr: SUM(CAST(financial_impact_amount AS DOUBLE))
      comment: "Total financial impact of supply chain risks — quantifies risk exposure in monetary terms for CFO and board reporting."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across the supply risk register — portfolio-level risk health indicator for S&OP and executive reviews."
    - name: "total_mitigation_cost"
      expr: SUM(CAST(mitigation_cost AS DOUBLE))
      comment: "Total cost of risk mitigation actions — measures investment in supply resilience and informs risk-vs-cost trade-off decisions."
    - name: "total_potential_supply_impact_quantity"
      expr: SUM(CAST(potential_supply_impact_quantity AS DOUBLE))
      comment: "Total potential supply quantity at risk — measures volume exposure to guide safety stock and alternate sourcing decisions."
    - name: "avg_safety_stock_recommendation"
      expr: AVG(CAST(safety_stock_recommendation AS DOUBLE))
      comment: "Average safety stock quantity recommended by risk assessments — drives inventory buffer investment decisions."
    - name: "escalated_risk_count"
      expr: COUNT(CASE WHEN escalation_required_flag = TRUE THEN 1 END)
      comment: "Number of risks requiring escalation — measures severity of unresolved supply threats needing leadership intervention."
    - name: "alternative_supplier_identified_count"
      expr: COUNT(CASE WHEN alternative_supplier_identified_flag = TRUE THEN 1 END)
      comment: "Number of risks where an alternative supplier has been identified — measures supply resilience and dual-sourcing coverage."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`supply_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supply allocation KPIs — measures fulfillment coverage, constraint exposure, and allocation fairness to steer constrained supply distribution decisions."
  source: "`vibe_manufacturing_v1`.`supply`.`allocation`"
  dimensions:
    - name: "allocation_status"
      expr: allocation_status
      comment: "Status of the allocation (approved, pending, rejected) for pipeline visibility."
    - name: "method"
      expr: method
      comment: "Allocation method (proportional, priority-based, FIFO) to compare strategy effectiveness."
    - name: "customer_tier"
      expr: customer_tier
      comment: "Customer tier for analyzing allocation fairness and priority compliance across customer segments."
    - name: "priority"
      expr: priority
      comment: "Allocation priority level — ensures high-priority customers and orders receive supply first."
    - name: "period_start_month"
      expr: DATE_TRUNC('month', period_start_date)
      comment: "Allocation period month for time-series analysis of supply constraint trends."
    - name: "constraint_reason_code"
      expr: constraint_reason_code
      comment: "Reason code for supply constraint — identifies root causes of allocation shortfalls."
    - name: "recipient_type"
      expr: recipient_type
      comment: "Type of allocation recipient (customer, plant, distribution center) for supply distribution analysis."
  measures:
    - name: "total_allocated_quantity"
      expr: SUM(CAST(allocated_quantity AS DOUBLE))
      comment: "Total quantity allocated to customers and plants — measures supply distribution volume."
    - name: "total_requested_quantity"
      expr: SUM(CAST(requested_quantity AS DOUBLE))
      comment: "Total quantity requested — baseline demand against which allocation coverage is measured."
    - name: "total_available_supply_quantity"
      expr: SUM(CAST(available_supply_quantity AS DOUBLE))
      comment: "Total available supply quantity — measures supply pool size relative to demand requests."
    - name: "avg_fulfillment_percentage"
      expr: AVG(CAST(fulfillment_percentage AS DOUBLE))
      comment: "Average fulfillment percentage across allocations — primary allocation effectiveness KPI; below target triggers supply escalation."
    - name: "escalated_allocation_count"
      expr: COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END)
      comment: "Number of allocations requiring escalation — measures severity of supply constraint impact on customers."
    - name: "contractual_commitment_count"
      expr: COUNT(CASE WHEN contractual_commitment_flag = TRUE THEN 1 END)
      comment: "Number of allocations with contractual commitments — tracks legal obligation exposure in constrained supply situations."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`supply_sop_cycle`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "S&OP cycle performance KPIs — measures planning process health, demand-supply balance, and financial alignment to steer executive S&OP decisions."
  source: "`vibe_manufacturing_v1`.`supply`.`sop_cycle`"
  dimensions:
    - name: "cycle_status"
      expr: cycle_status
      comment: "S&OP cycle status (in-progress, completed, approved) for tracking process completion."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the S&OP cycle for year-over-year planning performance comparison."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly S&OP cycle performance tracking."
    - name: "supply_risk_level"
      expr: supply_risk_level
      comment: "Supply risk level assessed during the S&OP cycle — segments cycles by risk severity."
    - name: "demand_review_status"
      expr: demand_review_status
      comment: "Status of the demand review stage — tracks S&OP process milestone completion."
    - name: "supply_review_status"
      expr: supply_review_status
      comment: "Status of the supply review stage — tracks S&OP process milestone completion."
    - name: "financial_reconciliation_status"
      expr: financial_reconciliation_status
      comment: "Status of financial reconciliation — measures alignment between operational and financial plans."
  measures:
    - name: "total_sop_cycles"
      expr: COUNT(1)
      comment: "Total S&OP cycles executed — baseline process cadence metric."
    - name: "total_demand_supply_gap_quantity"
      expr: SUM(CAST(demand_supply_gap_quantity AS DOUBLE))
      comment: "Total demand-supply gap quantity across S&OP cycles — primary imbalance KPI driving executive supply decisions."
    - name: "total_demand_supply_gap_value"
      expr: SUM(CAST(demand_supply_gap_value AS DOUBLE))
      comment: "Total financial value of demand-supply gaps — quantifies revenue at risk from supply constraints for CFO review."
    - name: "total_revenue_plan_amount"
      expr: SUM(CAST(revenue_plan_amount AS DOUBLE))
      comment: "Total planned revenue across S&OP cycles — measures financial ambition and tracks plan vs. actual alignment."
    - name: "total_cost_plan_amount"
      expr: SUM(CAST(cost_plan_amount AS DOUBLE))
      comment: "Total planned cost across S&OP cycles — measures cost commitment and margin planning."
    - name: "avg_capacity_utilization_target"
      expr: AVG(CAST(capacity_utilization_target_percentage AS DOUBLE))
      comment: "Average capacity utilization target set in S&OP cycles — measures planning ambition vs. actual utilization."
    - name: "total_inventory_plan_value"
      expr: SUM(CAST(inventory_plan_value AS DOUBLE))
      comment: "Total planned inventory value across S&OP cycles — measures working capital commitment in the supply plan."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`supply_safety_stock_policy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Safety stock policy KPIs — measures buffer inventory adequacy, service level targets, and policy coverage to steer inventory investment and risk mitigation."
  source: "`vibe_manufacturing_v1`.`supply`.`supply_safety_stock_policy`"
  dimensions:
    - name: "abc_classification"
      expr: abc_classification
      comment: "ABC classification for segmenting safety stock policy by material value tier."
    - name: "xyz_classification"
      expr: xyz_classification
      comment: "XYZ demand variability classification for analyzing safety stock adequacy by demand pattern."
    - name: "calculation_method"
      expr: calculation_method
      comment: "Safety stock calculation method (statistical, fixed, days-of-supply) for comparing policy approaches."
    - name: "mrp_type"
      expr: mrp_type
      comment: "MRP planning type for segmenting safety stock policies by planning approach."
    - name: "policy_status"
      expr: policy_status
      comment: "Policy status (active, expired, under-review) for filtering current policies."
    - name: "plant_code"
      expr: plant_code
      comment: "Plant for plant-level safety stock policy analysis."
    - name: "criticality_code"
      expr: criticality_code
      comment: "Material criticality code — prioritizes safety stock review for critical components."
  measures:
    - name: "total_safety_stock_quantity"
      expr: SUM(CAST(safety_stock_quantity AS DOUBLE))
      comment: "Total safety stock quantity mandated by policy — measures aggregate buffer inventory investment."
    - name: "avg_service_level_target_percent"
      expr: AVG(CAST(service_level_target_percent AS DOUBLE))
      comment: "Average service level target across safety stock policies — primary customer service commitment KPI."
    - name: "avg_demand_variability_coefficient"
      expr: AVG(CAST(demand_variability_coefficient AS DOUBLE))
      comment: "Average demand variability coefficient — measures demand uncertainty driving safety stock requirements."
    - name: "avg_lead_time_variability_days"
      expr: AVG(CAST(lead_time_variability_days AS DOUBLE))
      comment: "Average lead time variability in days — measures supply uncertainty component of safety stock calculation."
    - name: "total_reorder_point_quantity"
      expr: SUM(CAST(reorder_point_quantity AS DOUBLE))
      comment: "Total reorder point quantity across policies — measures aggregate replenishment trigger levels."
    - name: "avg_stockout_cost_per_unit"
      expr: AVG(CAST(stockout_cost_per_unit AS DOUBLE))
      comment: "Average stockout cost per unit — quantifies the financial consequence of safety stock policy failures."
    - name: "avg_holding_cost_percent_annual"
      expr: AVG(CAST(holding_cost_percent_annual AS DOUBLE))
      comment: "Average annual holding cost percentage — measures carrying cost burden of safety stock investment."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`supply_aps_scenario`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "APS scenario planning KPIs — compares supply chain scenarios on cost, service, and capacity to drive strategic planning decisions and scenario selection."
  source: "`vibe_manufacturing_v1`.`supply`.`aps_scenario`"
  dimensions:
    - name: "scenario_type"
      expr: scenario_type
      comment: "Scenario type (baseline, optimistic, pessimistic, what-if) for comparing planning assumptions."
    - name: "scenario_status"
      expr: scenario_status
      comment: "Scenario status (draft, approved, archived) for filtering active planning scenarios."
    - name: "planning_algorithm"
      expr: planning_algorithm
      comment: "Optimization algorithm used — enables algorithm performance benchmarking."
    - name: "optimization_objective"
      expr: optimization_objective
      comment: "Optimization objective (minimize cost, maximize service, minimize lead time) for comparing scenario trade-offs."
    - name: "approved_flag"
      expr: approved_flag
      comment: "Whether the scenario has been approved for execution — filters for actionable scenarios."
    - name: "effective_start_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the scenario becomes effective for time-series scenario planning analysis."
  measures:
    - name: "total_scenarios"
      expr: COUNT(1)
      comment: "Total APS scenarios created — measures planning scenario breadth and analytical rigor."
    - name: "avg_total_cost_amount"
      expr: AVG(CAST(total_cost_amount AS DOUBLE))
      comment: "Average total supply chain cost across scenarios — primary financial KPI for scenario comparison and selection."
    - name: "avg_service_level_percent"
      expr: AVG(CAST(service_level_percent AS DOUBLE))
      comment: "Average service level percentage across scenarios — measures customer service trade-off in scenario planning."
    - name: "avg_capacity_utilization_percent"
      expr: AVG(CAST(capacity_utilization_percent AS DOUBLE))
      comment: "Average capacity utilization across scenarios — measures resource efficiency trade-off in scenario selection."
    - name: "avg_on_time_delivery_percent"
      expr: AVG(CAST(on_time_delivery_percent AS DOUBLE))
      comment: "Average on-time delivery percentage across scenarios — customer service KPI for scenario evaluation."
    - name: "avg_solver_run_duration_minutes"
      expr: AVG(CAST(solver_run_duration_minutes AS DOUBLE))
      comment: "Average solver run duration — measures computational efficiency and planning system performance."
    - name: "total_late_orders_count"
      expr: SUM(CAST(total_late_orders_count AS DOUBLE))
      comment: "Total late orders projected across scenarios — measures service risk exposure in each planning scenario."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`supply_planning_exception`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Planning exception KPIs — measures exception volume, financial impact, and resolution effectiveness to drive planner prioritization and MRP parameter improvement."
  source: "`vibe_manufacturing_v1`.`supply`.`planning_exception`"
  dimensions:
    - name: "exception_type"
      expr: exception_type
      comment: "Type of planning exception (reschedule-in, reschedule-out, cancel, new order) for root cause analysis."
    - name: "exception_status"
      expr: exception_status
      comment: "Exception status (open, resolved, escalated) for tracking resolution progress."
    - name: "severity_level"
      expr: severity_level
      comment: "Exception severity level for prioritizing planner attention and escalation."
    - name: "plant_code"
      expr: plant_code
      comment: "Plant where the exception occurred for plant-level exception analysis."
    - name: "exception_month"
      expr: DATE_TRUNC('month', exception_date)
      comment: "Month of exception for trend analysis of planning quality over time."
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether the exception has been escalated — filters for high-priority unresolved issues."
    - name: "demand_source"
      expr: demand_source
      comment: "Source of demand driving the exception (sales order, forecast, safety stock) for root cause segmentation."
  measures:
    - name: "total_exceptions"
      expr: COUNT(1)
      comment: "Total planning exceptions generated — primary planning quality KPI; high volumes indicate MRP parameter or data quality issues."
    - name: "total_estimated_cost_impact"
      expr: SUM(CAST(estimated_cost_impact AS DOUBLE))
      comment: "Total estimated financial cost impact of planning exceptions — quantifies business risk from unresolved exceptions."
    - name: "total_exception_quantity"
      expr: SUM(CAST(exception_quantity AS DOUBLE))
      comment: "Total quantity affected by planning exceptions — measures supply coverage risk from exception backlog."
    - name: "escalated_exception_count"
      expr: COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END)
      comment: "Number of escalated exceptions — measures severity of unresolved planning issues requiring management intervention."
    - name: "resolved_exception_count"
      expr: COUNT(CASE WHEN exception_status = 'resolved' THEN 1 END)
      comment: "Number of resolved exceptions — measures planner productivity and exception management effectiveness."
    - name: "avg_available_stock_quantity"
      expr: AVG(CAST(available_stock_quantity AS DOUBLE))
      comment: "Average available stock at time of exception — measures inventory buffer adequacy when exceptions occur."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`supply_replenishment_proposal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Replenishment proposal KPIs — measures proposal conversion, lead time performance, and planner override rates to optimize replenishment execution."
  source: "`vibe_manufacturing_v1`.`supply`.`replenishment_proposal`"
  dimensions:
    - name: "proposal_type"
      expr: proposal_type
      comment: "Type of replenishment proposal (purchase order, production order, transfer) for segmenting supply strategy."
    - name: "proposal_status"
      expr: proposal_status
      comment: "Current status of the proposal (open, firmed, converted, rejected) for pipeline tracking."
    - name: "procurement_type"
      expr: procurement_type
      comment: "Procurement type for analyzing make-vs-buy replenishment balance."
    - name: "proposed_order_month"
      expr: DATE_TRUNC('month', proposed_order_date)
      comment: "Month of proposed order date for time-phased replenishment pipeline analysis."
    - name: "priority_code"
      expr: priority_code
      comment: "Priority code for focusing on high-priority replenishment actions."
    - name: "firmed_flag"
      expr: firmed_flag
      comment: "Whether the proposal has been firmed — measures planning stability and execution readiness."
  measures:
    - name: "total_proposals"
      expr: COUNT(1)
      comment: "Total replenishment proposals generated — baseline supply pipeline volume metric."
    - name: "total_proposed_quantity"
      expr: SUM(CAST(proposed_quantity AS DOUBLE))
      comment: "Total proposed replenishment quantity — measures supply pipeline volume against demand requirements."
    - name: "total_planner_override_quantity"
      expr: SUM(CAST(planner_override_quantity AS DOUBLE))
      comment: "Total quantity overridden by planners — high override rates indicate MRP parameter quality issues."
    - name: "total_minimum_order_quantity"
      expr: SUM(CAST(minimum_order_quantity AS DOUBLE))
      comment: "Total minimum order quantity constraints across proposals — measures MOQ-driven inventory inflation."
    - name: "firmed_proposal_count"
      expr: COUNT(CASE WHEN firmed_flag = TRUE THEN 1 END)
      comment: "Number of firmed replenishment proposals — measures planning stability and execution commitment."
    - name: "total_safety_stock_quantity"
      expr: SUM(CAST(safety_stock_quantity AS DOUBLE))
      comment: "Total safety stock quantity referenced in replenishment proposals — measures buffer inventory driving replenishment actions."
$$;