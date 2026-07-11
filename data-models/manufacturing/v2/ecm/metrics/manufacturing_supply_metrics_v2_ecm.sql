-- Metric views for domain: supply | Business: Manufacturing | Version: 2 | Generated on: 2026-07-10 11:52:40

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`supply_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic supply planning KPIs measuring plan health, safety stock adequacy, capacity utilization, and supply risk across planning horizons. Used by supply chain VPs and S&OP leaders to steer production and procurement decisions."
  source: "`vibe_manufacturing_v1`.`supply`.`supply_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the supply plan (e.g., Draft, Approved, Released) for filtering active vs. historical plans."
    - name: "planning_method"
      expr: planning_method
      comment: "MRP/MPS/Kanban planning method used, enabling comparison of plan quality across methodologies."
    - name: "planning_strategy"
      expr: planning_strategy
      comment: "Make-to-stock, make-to-order, or assemble-to-order strategy driving the plan."
    - name: "procurement_type"
      expr: procurement_type
      comment: "In-house production vs. external procurement classification for supply sourcing analysis."
    - name: "supply_risk_level"
      expr: supply_risk_level
      comment: "Risk tier (Low/Medium/High/Critical) assigned to the supply plan for risk-stratified reporting."
    - name: "plant_code"
      expr: plant_code
      comment: "Plant identifier for plant-level supply plan performance segmentation."
    - name: "planning_period_start_date"
      expr: DATE_TRUNC('month', planning_period_start_date)
      comment: "Planning period start month for time-series trending of supply plan metrics."
    - name: "material_group_code"
      expr: material_group_code
      comment: "Material group for commodity-level supply plan analysis."
  measures:
    - name: "total_planned_supply_quantity"
      expr: SUM(CAST(planned_supply_quantity AS DOUBLE))
      comment: "Total quantity planned for supply across all plans. Core volume KPI for supply adequacy assessment."
    - name: "total_demand_forecast_quantity"
      expr: SUM(CAST(demand_forecast_quantity AS DOUBLE))
      comment: "Total forecasted demand quantity the supply plan is designed to fulfill. Compared against planned supply to identify gaps."
    - name: "total_safety_stock_quantity"
      expr: SUM(CAST(safety_stock_quantity AS DOUBLE))
      comment: "Total safety stock quantity held across all supply plans. Indicates buffer investment and risk mitigation posture."
    - name: "avg_capacity_utilization_pct"
      expr: AVG(CAST(capacity_utilization_percentage AS DOUBLE))
      comment: "Average capacity utilization percentage across supply plans. Values above 85% signal overload risk; below 60% indicate underutilization."
    - name: "avg_variance_pct"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average plan-vs-actual variance percentage. High variance indicates forecast inaccuracy or execution failures requiring corrective action."
    - name: "total_variance_quantity"
      expr: SUM(CAST(variance_quantity AS DOUBLE))
      comment: "Total quantity variance between planned and actual supply. Drives root-cause analysis for supply shortfalls or overproduction."
    - name: "total_reorder_point_quantity"
      expr: SUM(CAST(reorder_point_quantity AS DOUBLE))
      comment: "Aggregate reorder point quantity across all supply plans. Benchmarks replenishment trigger levels for inventory policy review."
    - name: "supply_plan_count"
      expr: COUNT(1)
      comment: "Total number of supply plans. Used to track planning workload and coverage across materials and plants."
    - name: "high_risk_plan_count"
      expr: COUNT(CASE WHEN supply_risk_level IN ('High', 'Critical') THEN 1 END)
      comment: "Number of supply plans flagged as high or critical risk. Directly drives executive escalation and risk mitigation investment decisions."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`supply_demand_forecast`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Demand forecasting accuracy and quality KPIs used by S&OP teams and supply chain executives to evaluate forecast reliability, bias, and planning confidence. Poor forecast accuracy directly drives excess inventory or stockouts."
  source: "`vibe_manufacturing_v1`.`supply`.`demand_forecast`"
  dimensions:
    - name: "forecast_status"
      expr: forecast_status
      comment: "Lifecycle status of the forecast record (Draft, Approved, Consumed) for filtering active forecasts."
    - name: "forecast_model_code"
      expr: forecast_model_code
      comment: "Statistical model used to generate the forecast, enabling model performance benchmarking."
    - name: "demand_class"
      expr: demand_class
      comment: "Demand classification (e.g., independent, dependent, promotional) for segmented accuracy analysis."
    - name: "demand_pattern"
      expr: demand_pattern
      comment: "Demand pattern type (seasonal, trend, intermittent) for model selection and accuracy benchmarking."
    - name: "product_lifecycle_stage"
      expr: product_lifecycle_stage
      comment: "Product lifecycle stage (Introduction, Growth, Maturity, Decline) affecting forecast methodology selection."
    - name: "planning_period_start_date"
      expr: DATE_TRUNC('month', planning_period_start_date)
      comment: "Forecast planning period start month for time-series accuracy trending."
    - name: "customer_segment_code"
      expr: customer_segment_code
      comment: "Customer segment driving the demand forecast for segment-level accuracy analysis."
    - name: "version_type"
      expr: version_type
      comment: "Forecast version type (Baseline, Consensus, Statistical) for version comparison analysis."
    - name: "promotional_flag"
      expr: promotional_flag
      comment: "Indicates whether the forecast includes a promotional uplift, enabling baseline vs. promotional accuracy comparison."
  measures:
    - name: "avg_forecast_accuracy_pct"
      expr: AVG(CAST(forecast_accuracy_percent AS DOUBLE))
      comment: "Average forecast accuracy percentage. The primary KPI for demand planning quality — directly impacts inventory investment and service levels."
    - name: "avg_mape"
      expr: AVG(CAST(mean_absolute_percentage_error AS DOUBLE))
      comment: "Average Mean Absolute Percentage Error across forecasts. Industry-standard forecast quality metric; MAPE above 30% triggers model review."
    - name: "avg_bias_pct"
      expr: AVG(CAST(bias_percent AS DOUBLE))
      comment: "Average forecast bias percentage. Persistent positive or negative bias indicates systematic over- or under-forecasting requiring model recalibration."
    - name: "total_forecast_quantity"
      expr: SUM(CAST(forecast_quantity AS DOUBLE))
      comment: "Total forecasted demand quantity across all records. Baseline volume for supply planning and capacity allocation."
    - name: "total_sales_adjustment_quantity"
      expr: SUM(CAST(sales_adjustment_quantity AS DOUBLE))
      comment: "Total manual sales adjustments applied to statistical forecasts. High values indicate low confidence in statistical models."
    - name: "avg_confidence_level_pct"
      expr: AVG(CAST(confidence_level_percent AS DOUBLE))
      comment: "Average statistical confidence level of forecasts. Low confidence drives wider safety stock buffers and higher inventory costs."
    - name: "avg_promotional_uplift_pct"
      expr: AVG(CAST(promotional_uplift_percent AS DOUBLE))
      comment: "Average promotional demand uplift percentage. Quantifies the revenue and supply impact of promotional activities for trade planning."
    - name: "outlier_forecast_count"
      expr: COUNT(CASE WHEN outlier_flag = TRUE THEN 1 END)
      comment: "Number of forecasts flagged as statistical outliers. High outlier counts indicate data quality issues or demand volatility requiring investigation."
    - name: "forecast_record_count"
      expr: COUNT(1)
      comment: "Total number of demand forecast records for coverage and completeness tracking."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`supply_inventory_position`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Real-time inventory health KPIs measuring stock availability, excess, stockout risk, and supply coverage. Used by supply chain and operations executives to manage working capital and service level commitments."
  source: "`vibe_manufacturing_v1`.`supply`.`inventory_position`"
  dimensions:
    - name: "abc_classification"
      expr: abc_classification
      comment: "ABC inventory classification (A=high value, B=medium, C=low) for prioritized inventory management."
    - name: "xyz_classification"
      expr: xyz_classification
      comment: "XYZ demand variability classification for combined ABC-XYZ inventory segmentation."
    - name: "mrp_type"
      expr: mrp_type
      comment: "MRP planning type (MRP, MPS, Kanban, etc.) for planning method performance comparison."
    - name: "procurement_type"
      expr: procurement_type
      comment: "In-house vs. external procurement type for make-vs-buy inventory analysis."
    - name: "plant_code"
      expr: plant_code
      comment: "Plant location for plant-level inventory health monitoring."
    - name: "snapshot_date"
      expr: DATE_TRUNC('week', snapshot_date)
      comment: "Weekly snapshot date for inventory position trending over time."
    - name: "planning_strategy_group"
      expr: planning_strategy_group
      comment: "Planning strategy group for strategy-level inventory performance analysis."
    - name: "stock_out_risk_flag"
      expr: stock_out_risk_flag
      comment: "Stockout risk indicator for filtering at-risk materials requiring immediate action."
    - name: "excess_stock_flag"
      expr: excess_stock_flag
      comment: "Excess stock indicator for identifying working capital tied up in overstock situations."
  measures:
    - name: "total_on_hand_quantity"
      expr: SUM(CAST(on_hand_quantity AS DOUBLE))
      comment: "Total on-hand inventory quantity. Primary stock availability KPI for service level and working capital management."
    - name: "total_available_to_promise_quantity"
      expr: SUM(CAST(available_to_promise_quantity AS DOUBLE))
      comment: "Total ATP quantity available for customer order commitment. Directly drives order fulfillment capability and customer service levels."
    - name: "total_net_requirement_quantity"
      expr: SUM(CAST(net_requirement_quantity AS DOUBLE))
      comment: "Total net material requirements after netting on-hand and scheduled receipts. Drives procurement and production planning decisions."
    - name: "total_safety_stock_quantity"
      expr: SUM(CAST(safety_stock_quantity AS DOUBLE))
      comment: "Total safety stock quantity held. Represents the working capital investment in demand and supply uncertainty buffers."
    - name: "total_blocked_stock_quantity"
      expr: SUM(CAST(blocked_stock_quantity AS DOUBLE))
      comment: "Total quantity blocked due to quality holds or other restrictions. High blocked stock indicates quality or compliance issues impacting supply."
    - name: "avg_days_of_supply"
      expr: AVG(CAST(days_of_supply AS DOUBLE))
      comment: "Average days of supply on hand. Key inventory coverage metric — below safety threshold triggers emergency replenishment."
    - name: "total_open_purchase_order_quantity"
      expr: SUM(CAST(open_purchase_order_quantity AS DOUBLE))
      comment: "Total quantity on open purchase orders. Indicates inbound supply pipeline for supply gap closure analysis."
    - name: "total_open_production_order_quantity"
      expr: SUM(CAST(open_production_order_quantity AS DOUBLE))
      comment: "Total quantity on open production orders. Measures in-progress manufacturing supply to close demand gaps."
    - name: "stockout_risk_material_count"
      expr: COUNT(CASE WHEN stock_out_risk_flag = TRUE THEN 1 END)
      comment: "Number of materials at stockout risk. Critical operational KPI — each at-risk material represents a potential customer service failure."
    - name: "excess_stock_material_count"
      expr: COUNT(CASE WHEN excess_stock_flag = TRUE THEN 1 END)
      comment: "Number of materials with excess stock. Drives working capital reduction initiatives and inventory write-down risk assessment."
    - name: "avg_average_daily_demand"
      expr: AVG(CAST(average_daily_demand AS DOUBLE))
      comment: "Average daily demand rate across inventory positions. Used to calibrate reorder points and safety stock levels."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`supply_capacity_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Manufacturing capacity planning KPIs measuring utilization, overload, underload, and efficiency across work centers and planning horizons. Used by operations VPs and plant managers to balance load and prevent bottlenecks."
  source: "`vibe_manufacturing_v1`.`supply`.`capacity_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Capacity plan status (Draft, Active, Closed) for filtering current vs. historical plans."
    - name: "plan_type"
      expr: plan_type
      comment: "Type of capacity plan (Rough-cut, Detailed, Finite) for planning granularity analysis."
    - name: "capacity_category"
      expr: capacity_category
      comment: "Capacity category (Machine, Labor, Tool) for resource-type capacity analysis."
    - name: "resource_type"
      expr: resource_type
      comment: "Resource type classification for capacity allocation and investment decisions."
    - name: "leveling_strategy"
      expr: leveling_strategy
      comment: "Capacity leveling strategy applied (Chase, Level, Hybrid) for strategy effectiveness comparison."
    - name: "is_bottleneck"
      expr: is_bottleneck
      comment: "Bottleneck indicator for prioritizing capacity expansion investments at constraint resources."
    - name: "planning_period_start_date"
      expr: DATE_TRUNC('month', planning_period_start_date)
      comment: "Planning period start month for capacity utilization trending."
  measures:
    - name: "total_available_capacity_hours"
      expr: SUM(CAST(available_capacity_hours AS DOUBLE))
      comment: "Total available capacity hours across all planned resources. Baseline for capacity sufficiency analysis."
    - name: "total_required_capacity_hours"
      expr: SUM(CAST(required_capacity_hours AS DOUBLE))
      comment: "Total capacity hours required to fulfill the production plan. Compared against available capacity to identify gaps."
    - name: "total_overload_hours"
      expr: SUM(CAST(overload_hours AS DOUBLE))
      comment: "Total capacity overload hours. Directly indicates where overtime, outsourcing, or capacity investment is needed."
    - name: "total_underload_hours"
      expr: SUM(CAST(underload_hours AS DOUBLE))
      comment: "Total capacity underload hours. Identifies idle capacity representing cost inefficiency and potential for additional work absorption."
    - name: "avg_capacity_utilization_rate"
      expr: AVG(CAST(capacity_utilization_rate AS DOUBLE))
      comment: "Average capacity utilization rate across all resources. The primary capacity efficiency KPI — target range typically 75-85%."
    - name: "avg_efficiency_rate"
      expr: AVG(CAST(efficiency_rate AS DOUBLE))
      comment: "Average resource efficiency rate. Measures actual vs. standard performance, driving productivity improvement programs."
    - name: "total_planned_downtime_hours"
      expr: SUM(CAST(planned_downtime_hours AS DOUBLE))
      comment: "Total planned downtime hours (maintenance, changeover). Quantifies scheduled capacity loss for OEE calculation."
    - name: "total_unplanned_downtime_hours"
      expr: SUM(CAST(unplanned_downtime_hours AS DOUBLE))
      comment: "Total unplanned downtime hours. Critical reliability KPI — high unplanned downtime drives maintenance investment and asset replacement decisions."
    - name: "bottleneck_resource_count"
      expr: COUNT(CASE WHEN is_bottleneck = TRUE THEN 1 END)
      comment: "Number of bottleneck resources in the capacity plan. Drives Theory of Constraints-based investment prioritization."
    - name: "avg_critical_ratio"
      expr: AVG(CAST(critical_ratio AS DOUBLE))
      comment: "Average critical ratio (time remaining / work remaining). Ratios below 1.0 indicate orders at risk of late completion."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`supply_planned_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "MRP planned order KPIs measuring supply proposal volume, firming rates, and planning exceptions. Used by supply planners and operations managers to manage the transition from planned to executable supply orders."
  source: "`vibe_manufacturing_v1`.`supply`.`planned_order`"
  dimensions:
    - name: "order_type"
      expr: order_type
      comment: "Planned order type (Production, Purchase, Transfer) for supply source mix analysis."
    - name: "proposal_status"
      expr: proposal_status
      comment: "Proposal lifecycle status (Planned, Firmed, Converted, Cancelled) for pipeline management."
    - name: "plant_code"
      expr: plant_code
      comment: "Plant code for plant-level planned order volume and firming analysis."
    - name: "priority_code"
      expr: priority_code
      comment: "Order priority code for prioritized planning exception management."
    - name: "scheduled_start_date"
      expr: DATE_TRUNC('week', scheduled_start_date)
      comment: "Scheduled start week for planned order load profile analysis."
    - name: "firming_indicator"
      expr: firming_indicator
      comment: "Firming status flag for tracking the proportion of planned orders converted to firm supply."
    - name: "deletion_flag"
      expr: deletion_flag
      comment: "Deletion flag for filtering active vs. cancelled planned orders."
  measures:
    - name: "total_planned_quantity"
      expr: SUM(CAST(planned_quantity AS DOUBLE))
      comment: "Total quantity across all planned orders. Primary supply pipeline volume KPI for capacity and procurement planning."
    - name: "total_safety_stock_quantity"
      expr: SUM(CAST(safety_stock_quantity AS DOUBLE))
      comment: "Total safety stock quantity embedded in planned orders. Quantifies buffer stock investment driven by MRP planning."
    - name: "total_available_capacity_hours"
      expr: SUM(CAST(available_capacity_hours AS DOUBLE))
      comment: "Total available capacity hours associated with planned orders. Used to validate capacity feasibility of the plan."
    - name: "total_required_capacity_hours"
      expr: SUM(CAST(required_capacity_hours AS DOUBLE))
      comment: "Total capacity hours required to execute all planned orders. Compared against available capacity to identify overload."
    - name: "avg_supply_risk_score"
      expr: AVG(CAST(supply_risk_score AS DOUBLE))
      comment: "Average supply risk score across planned orders. High scores trigger supplier diversification or safety stock increase decisions."
    - name: "firmed_order_count"
      expr: COUNT(CASE WHEN firming_indicator = TRUE THEN 1 END)
      comment: "Number of planned orders that have been firmed. Measures planning execution progress and MRP controller responsiveness."
    - name: "total_planned_order_count"
      expr: COUNT(1)
      comment: "Total number of planned orders. Indicates MRP planning workload and supply pipeline breadth."
    - name: "avg_planner_override_quantity"
      expr: AVG(CAST(planner_override_quantity AS DOUBLE))
      comment: "Average planner manual override quantity. High override volumes indicate MRP parameter quality issues requiring tuning."
    - name: "total_moq_quantity"
      expr: SUM(CAST(moq_quantity AS DOUBLE))
      comment: "Total minimum order quantity committed across planned orders. Quantifies MOQ-driven excess inventory risk."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`supply_risk_register`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supply chain risk KPIs measuring financial exposure, mitigation effectiveness, and risk concentration. Used by supply chain executives and risk officers to prioritize mitigation investments and monitor supply resilience."
  source: "`vibe_manufacturing_v1`.`supply`.`risk_register`"
  dimensions:
    - name: "risk_category"
      expr: risk_category
      comment: "Risk category (Supplier, Logistics, Geopolitical, Natural Disaster) for risk portfolio analysis."
    - name: "risk_type"
      expr: risk_type
      comment: "Specific risk type for granular risk classification and targeted mitigation planning."
    - name: "risk_severity"
      expr: risk_severity
      comment: "Risk severity level (Low/Medium/High/Critical) for prioritized risk management."
    - name: "risk_status"
      expr: risk_status
      comment: "Current risk status (Open, Mitigating, Closed) for active risk portfolio management."
    - name: "mitigation_status"
      expr: mitigation_status
      comment: "Mitigation action status for tracking risk response effectiveness."
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region of risk origin for geopolitical and regional concentration analysis."
    - name: "escalation_required_flag"
      expr: escalation_required_flag
      comment: "Escalation flag for filtering risks requiring executive attention."
    - name: "identified_date"
      expr: DATE_TRUNC('month', identified_date)
      comment: "Month risk was identified for risk emergence trending and early warning analysis."
  measures:
    - name: "total_financial_impact_amount"
      expr: SUM(CAST(financial_impact_amount AS DOUBLE))
      comment: "Total financial exposure across all supply risks. Primary executive KPI for risk-adjusted supply chain investment decisions."
    - name: "total_mitigation_cost"
      expr: SUM(CAST(mitigation_cost AS DOUBLE))
      comment: "Total cost invested in risk mitigation activities. Compared against financial impact to assess mitigation ROI."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across the supply risk register. Tracks overall supply chain risk posture over time."
    - name: "total_potential_supply_impact_quantity"
      expr: SUM(CAST(potential_supply_impact_quantity AS DOUBLE))
      comment: "Total potential supply volume at risk. Quantifies the supply disruption magnitude for contingency planning."
    - name: "total_safety_stock_recommendation"
      expr: SUM(CAST(safety_stock_recommendation AS DOUBLE))
      comment: "Total recommended safety stock increase driven by identified risks. Translates risk assessment into inventory investment requirements."
    - name: "open_risk_count"
      expr: COUNT(CASE WHEN risk_status = 'Open' THEN 1 END)
      comment: "Number of open supply risks. Tracks risk backlog and mitigation capacity requirements."
    - name: "critical_risk_count"
      expr: COUNT(CASE WHEN risk_severity = 'Critical' THEN 1 END)
      comment: "Number of critical severity risks. Directly drives executive escalation and emergency response resource allocation."
    - name: "alternative_supplier_identified_count"
      expr: COUNT(CASE WHEN alternative_supplier_identified_flag = TRUE THEN 1 END)
      comment: "Number of risks where an alternative supplier has been identified. Measures supply resilience and dual-sourcing coverage."
    - name: "total_moq_impact"
      expr: SUM(CAST(moq_impact AS DOUBLE))
      comment: "Total MOQ impact quantity from supply risks. Quantifies procurement flexibility constraints driven by risk scenarios."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`supply_sop_cycle`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sales & Operations Planning cycle KPIs measuring demand-supply balance, financial reconciliation, and planning cycle health. Used by executive S&OP teams to align supply, demand, and financial plans at the business unit level."
  source: "`vibe_manufacturing_v1`.`supply`.`sop_cycle`"
  dimensions:
    - name: "cycle_status"
      expr: cycle_status
      comment: "S&OP cycle status (In Progress, Complete, Cancelled) for active cycle monitoring."
    - name: "business_unit_code"
      expr: business_unit_code
      comment: "Business unit for BU-level S&OP performance comparison."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual S&OP performance trending."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly S&OP cycle cadence analysis."
    - name: "supply_risk_level"
      expr: supply_risk_level
      comment: "Supply risk level assessed during the S&OP cycle for risk-stratified planning analysis."
    - name: "demand_review_status"
      expr: demand_review_status
      comment: "Demand review completion status for S&OP process adherence tracking."
    - name: "supply_review_status"
      expr: supply_review_status
      comment: "Supply review completion status for S&OP process adherence tracking."
    - name: "financial_reconciliation_status"
      expr: financial_reconciliation_status
      comment: "Financial reconciliation status for integrated business planning alignment tracking."
  measures:
    - name: "total_demand_supply_gap_quantity"
      expr: SUM(CAST(demand_supply_gap_quantity AS DOUBLE))
      comment: "Total demand-supply gap quantity across S&OP cycles. The primary S&OP health KPI — persistent gaps drive capacity investment or demand shaping decisions."
    - name: "total_demand_supply_gap_value"
      expr: SUM(CAST(demand_supply_gap_value AS DOUBLE))
      comment: "Total financial value of demand-supply gaps. Translates volume gaps into revenue-at-risk for executive financial planning."
    - name: "total_revenue_plan_amount"
      expr: SUM(CAST(revenue_plan_amount AS DOUBLE))
      comment: "Total revenue planned across S&OP cycles. Baseline for financial plan vs. actual revenue performance tracking."
    - name: "total_cost_plan_amount"
      expr: SUM(CAST(cost_plan_amount AS DOUBLE))
      comment: "Total cost planned across S&OP cycles. Used for margin planning and cost performance monitoring."
    - name: "total_inventory_plan_value"
      expr: SUM(CAST(inventory_plan_value AS DOUBLE))
      comment: "Total planned inventory value across S&OP cycles. Tracks working capital investment planned vs. actual."
    - name: "avg_capacity_utilization_target_pct"
      expr: AVG(CAST(capacity_utilization_target_percentage AS DOUBLE))
      comment: "Average capacity utilization target set during S&OP. Benchmarks planned vs. actual utilization for operational performance."
    - name: "sop_cycle_count"
      expr: COUNT(1)
      comment: "Total number of S&OP cycles executed. Measures S&OP process cadence and organizational planning discipline."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`supply_replenishment_proposal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Replenishment proposal KPIs measuring MRP-driven procurement and production recommendations, firming rates, and planner override behavior. Used by supply planners and procurement managers to manage the replenishment pipeline."
  source: "`vibe_manufacturing_v1`.`supply`.`replenishment_proposal`"
  dimensions:
    - name: "proposal_type"
      expr: proposal_type
      comment: "Replenishment proposal type (Purchase Order, Production Order, Transfer Order) for supply source mix analysis."
    - name: "proposal_status"
      expr: proposal_status
      comment: "Proposal lifecycle status for pipeline management and conversion rate tracking."
    - name: "procurement_type"
      expr: procurement_type
      comment: "Make vs. buy procurement type for sourcing strategy analysis."
    - name: "priority_code"
      expr: priority_code
      comment: "Priority code for prioritized replenishment action management."
    - name: "proposed_order_date"
      expr: DATE_TRUNC('week', proposed_order_date)
      comment: "Proposed order week for replenishment load profile and buyer workload analysis."
    - name: "firmed_flag"
      expr: firmed_flag
      comment: "Firming status for tracking conversion of proposals to executable orders."
    - name: "lot_sizing_procedure"
      expr: lot_sizing_procedure
      comment: "Lot sizing procedure applied for evaluating MOQ and lot size policy effectiveness."
  measures:
    - name: "total_proposed_quantity"
      expr: SUM(CAST(proposed_quantity AS DOUBLE))
      comment: "Total quantity proposed for replenishment. Primary supply pipeline volume KPI for procurement and production planning."
    - name: "total_minimum_order_quantity"
      expr: SUM(CAST(minimum_order_quantity AS DOUBLE))
      comment: "Total MOQ commitment across replenishment proposals. Quantifies MOQ-driven excess inventory risk in the replenishment plan."
    - name: "total_safety_stock_quantity"
      expr: SUM(CAST(safety_stock_quantity AS DOUBLE))
      comment: "Total safety stock quantity embedded in replenishment proposals. Measures buffer stock investment driven by planning parameters."
    - name: "total_planner_override_quantity"
      expr: SUM(CAST(planner_override_quantity AS DOUBLE))
      comment: "Total quantity manually overridden by planners. High override volumes signal MRP parameter quality issues requiring system tuning."
    - name: "firmed_proposal_count"
      expr: COUNT(CASE WHEN firmed_flag = TRUE THEN 1 END)
      comment: "Number of firmed replenishment proposals. Measures planning execution progress and buyer responsiveness to MRP signals."
    - name: "total_proposal_count"
      expr: COUNT(1)
      comment: "Total number of replenishment proposals. Indicates MRP planning workload and replenishment pipeline breadth."
    - name: "avg_reorder_point_quantity"
      expr: AVG(CAST(reorder_point_quantity AS DOUBLE))
      comment: "Average reorder point quantity across proposals. Benchmarks replenishment trigger levels for inventory policy optimization."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`supply_aps_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Advanced Planning & Scheduling KPIs measuring schedule efficiency, capacity utilization, and production timing. Used by production planners and operations managers to optimize shop floor scheduling and reduce lead times."
  source: "`vibe_manufacturing_v1`.`supply`.`aps_schedule`"
  dimensions:
    - name: "schedule_status"
      expr: schedule_status
      comment: "APS schedule status (Planned, Released, Completed) for schedule pipeline management."
    - name: "scheduling_method"
      expr: scheduling_method
      comment: "Scheduling method (Forward, Backward, Finite) for method effectiveness comparison."
    - name: "constraint_type"
      expr: constraint_type
      comment: "Constraint type limiting the schedule for bottleneck identification and resolution."
    - name: "plant_code"
      expr: plant_code
      comment: "Plant code for plant-level scheduling performance analysis."
    - name: "priority_level"
      expr: priority_level
      comment: "Schedule priority level for prioritized production sequencing analysis."
    - name: "scheduled_start_timestamp"
      expr: DATE_TRUNC('week', scheduled_start_timestamp)
      comment: "Scheduled start week for production load profile and capacity utilization trending."
    - name: "released_to_mes_flag"
      expr: released_to_mes_flag
      comment: "MES release flag for tracking schedule execution handoff to shop floor systems."
    - name: "critical_path_flag"
      expr: critical_path_flag
      comment: "Critical path indicator for prioritizing schedule adherence monitoring on constraint operations."
  measures:
    - name: "total_planned_quantity"
      expr: SUM(CAST(planned_quantity AS DOUBLE))
      comment: "Total quantity scheduled for production. Primary production volume KPI for capacity and material planning."
    - name: "avg_capacity_utilization_pct"
      expr: AVG(CAST(capacity_utilization_percent AS DOUBLE))
      comment: "Average capacity utilization percentage across scheduled operations. Core efficiency KPI for production scheduling."
    - name: "total_run_time_minutes"
      expr: SUM(CAST(run_time_minutes AS DOUBLE))
      comment: "Total scheduled run time in minutes. Quantifies productive machine time for OEE and throughput analysis."
    - name: "total_setup_time_minutes"
      expr: SUM(CAST(setup_time_minutes AS DOUBLE))
      comment: "Total scheduled setup time in minutes. High setup time drives SMED improvement initiatives and changeover reduction programs."
    - name: "total_queue_time_minutes"
      expr: SUM(CAST(queue_time_minutes AS DOUBLE))
      comment: "Total queue time in minutes. Measures WIP waiting time — high queue time indicates scheduling bottlenecks and flow inefficiencies."
    - name: "total_slack_time_minutes"
      expr: SUM(CAST(slack_time_minutes AS DOUBLE))
      comment: "Total schedule slack time in minutes. Measures scheduling buffer — negative slack indicates at-risk orders requiring expediting."
    - name: "total_standard_cost_amount"
      expr: SUM(CAST(standard_cost_amount AS DOUBLE))
      comment: "Total standard cost of scheduled production. Enables cost-of-production planning and variance analysis against actuals."
    - name: "released_to_mes_count"
      expr: COUNT(CASE WHEN released_to_mes_flag = TRUE THEN 1 END)
      comment: "Number of schedules released to MES. Measures planning-to-execution handoff rate and shop floor readiness."
    - name: "critical_path_operation_count"
      expr: COUNT(CASE WHEN critical_path_flag = TRUE THEN 1 END)
      comment: "Number of critical path operations in the schedule. Drives focused monitoring and resource prioritization on constraint operations."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`supply_safety_stock_policy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Safety stock policy KPIs measuring inventory buffer adequacy, service level targets, and holding cost efficiency. Used by supply chain managers to optimize the trade-off between service levels and working capital investment."
  source: "`vibe_manufacturing_v1`.`supply`.`supply_safety_stock_policy`"
  dimensions:
    - name: "abc_classification"
      expr: abc_classification
      comment: "ABC classification for value-stratified safety stock policy analysis."
    - name: "xyz_classification"
      expr: xyz_classification
      comment: "XYZ demand variability classification for combined ABC-XYZ safety stock optimization."
    - name: "calculation_method"
      expr: calculation_method
      comment: "Safety stock calculation method (Statistical, Fixed, Days-of-Supply) for method effectiveness comparison."
    - name: "criticality_code"
      expr: criticality_code
      comment: "Material criticality code for risk-based safety stock prioritization."
    - name: "policy_status"
      expr: policy_status
      comment: "Policy status (Active, Under Review, Expired) for active policy management."
    - name: "procurement_type"
      expr: procurement_type
      comment: "Make vs. buy procurement type for sourcing-specific safety stock analysis."
    - name: "plant_code"
      expr: plant_code
      comment: "Plant code for plant-level safety stock policy performance analysis."
    - name: "mrp_type"
      expr: mrp_type
      comment: "MRP planning type for planning method-specific safety stock analysis."
  measures:
    - name: "total_safety_stock_quantity"
      expr: SUM(CAST(safety_stock_quantity AS DOUBLE))
      comment: "Total safety stock quantity mandated by policy. Primary working capital KPI for inventory investment management."
    - name: "avg_service_level_target_pct"
      expr: AVG(CAST(service_level_target_percent AS DOUBLE))
      comment: "Average service level target percentage across policies. Benchmarks the organization's customer service commitment level."
    - name: "avg_holding_cost_pct_annual"
      expr: AVG(CAST(holding_cost_percent_annual AS DOUBLE))
      comment: "Average annual holding cost percentage. Quantifies the carrying cost of safety stock investment for working capital optimization."
    - name: "avg_demand_variability_coefficient"
      expr: AVG(CAST(demand_variability_coefficient AS DOUBLE))
      comment: "Average demand variability coefficient across policies. High variability drives higher safety stock requirements and working capital needs."
    - name: "avg_lead_time_variability_days"
      expr: AVG(CAST(lead_time_variability_days AS DOUBLE))
      comment: "Average supplier lead time variability in days. Key driver of safety stock levels — high variability requires larger buffers."
    - name: "total_reorder_point_quantity"
      expr: SUM(CAST(reorder_point_quantity AS DOUBLE))
      comment: "Total reorder point quantity across all policies. Defines the aggregate replenishment trigger level for procurement planning."
    - name: "avg_stockout_cost_per_unit"
      expr: AVG(CAST(stockout_cost_per_unit AS DOUBLE))
      comment: "Average stockout cost per unit. Quantifies the financial penalty of stockouts to justify safety stock investment levels."
    - name: "total_maximum_stock_level"
      expr: SUM(CAST(maximum_stock_level AS DOUBLE))
      comment: "Total maximum stock level across all policies. Defines the upper bound of planned inventory investment."
    - name: "policy_count"
      expr: COUNT(1)
      comment: "Total number of active safety stock policies. Measures policy coverage across the material portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`supply_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supply allocation KPIs measuring fulfillment rates, constraint management, and allocation fairness across customers and products during supply-constrained periods. Used by supply chain and commercial executives to manage scarce supply."
  source: "`vibe_manufacturing_v1`.`supply`.`allocation`"
  dimensions:
    - name: "allocation_status"
      expr: allocation_status
      comment: "Allocation status (Pending, Approved, Released, Cancelled) for pipeline management."
    - name: "method"
      expr: method
      comment: "Allocation method (Pro-rata, Priority-based, Contractual) for fairness and policy compliance analysis."
    - name: "customer_tier"
      expr: customer_tier
      comment: "Customer tier for tier-based allocation fairness and commercial priority analysis."
    - name: "recipient_type"
      expr: recipient_type
      comment: "Recipient type (Customer, Plant, Distribution Center) for allocation destination analysis."
    - name: "constraint_reason_code"
      expr: constraint_reason_code
      comment: "Reason code for supply constraint driving the allocation for root-cause analysis."
    - name: "period_start_date"
      expr: DATE_TRUNC('month', period_start_date)
      comment: "Allocation period start month for time-series allocation performance trending."
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Escalation flag for filtering allocations requiring executive intervention."
    - name: "contractual_commitment_flag"
      expr: contractual_commitment_flag
      comment: "Contractual commitment flag for distinguishing contractually obligated vs. discretionary allocations."
  measures:
    - name: "total_allocated_quantity"
      expr: SUM(CAST(allocated_quantity AS DOUBLE))
      comment: "Total quantity allocated to customers and plants. Primary supply distribution volume KPI."
    - name: "total_requested_quantity"
      expr: SUM(CAST(requested_quantity AS DOUBLE))
      comment: "Total quantity requested by customers and plants. Compared against allocated quantity to measure supply gap."
    - name: "total_available_supply_quantity"
      expr: SUM(CAST(available_supply_quantity AS DOUBLE))
      comment: "Total available supply quantity for allocation. Baseline for allocation coverage and constraint severity analysis."
    - name: "avg_fulfillment_pct"
      expr: AVG(CAST(fulfillment_percentage AS DOUBLE))
      comment: "Average fulfillment percentage across allocations. Core service level KPI — low fulfillment drives revenue loss and customer churn risk."
    - name: "escalated_allocation_count"
      expr: COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END)
      comment: "Number of allocations requiring escalation. Measures severity of supply constraint impact on customer commitments."
    - name: "contractual_allocation_count"
      expr: COUNT(CASE WHEN contractual_commitment_flag = TRUE THEN 1 END)
      comment: "Number of contractually committed allocations. Tracks legal obligation fulfillment risk during supply-constrained periods."
    - name: "total_allocation_count"
      expr: COUNT(1)
      comment: "Total number of allocation records. Measures allocation activity volume and constraint management workload."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`supply_planning_exception`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "MRP planning exception KPIs measuring exception volume, severity, financial impact, and resolution rates. Used by supply planners and operations managers to prioritize exception resolution and improve planning quality."
  source: "`vibe_manufacturing_v1`.`supply`.`planning_exception`"
  dimensions:
    - name: "exception_type"
      expr: exception_type
      comment: "Exception type (Late Delivery, Overdue Order, Excess Stock, Shortage) for root-cause categorization."
    - name: "exception_status"
      expr: exception_status
      comment: "Exception lifecycle status (Open, In Progress, Resolved) for workload and backlog management."
    - name: "severity_level"
      expr: severity_level
      comment: "Exception severity level for prioritized resolution resource allocation."
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Escalation flag for filtering exceptions requiring management intervention."
    - name: "plant_code"
      expr: plant_code
      comment: "Plant code for plant-level exception concentration analysis."
    - name: "exception_date"
      expr: DATE_TRUNC('week', exception_date)
      comment: "Exception detection week for exception volume trending and early warning analysis."
    - name: "demand_source"
      expr: demand_source
      comment: "Demand source driving the exception for demand-side root-cause analysis."
  measures:
    - name: "total_estimated_cost_impact"
      expr: SUM(CAST(estimated_cost_impact AS DOUBLE))
      comment: "Total estimated financial cost impact of planning exceptions. Primary KPI for exception prioritization and business impact quantification."
    - name: "total_exception_quantity"
      expr: SUM(CAST(exception_quantity AS DOUBLE))
      comment: "Total quantity affected by planning exceptions. Measures supply disruption volume for capacity and procurement response planning."
    - name: "total_available_stock_quantity"
      expr: SUM(CAST(available_stock_quantity AS DOUBLE))
      comment: "Total available stock quantity at time of exception. Contextualizes exception severity relative to existing inventory buffers."
    - name: "open_exception_count"
      expr: COUNT(CASE WHEN exception_status = 'Open' THEN 1 END)
      comment: "Number of open planning exceptions. Measures planner workload and MRP signal quality — high open counts indicate systemic planning issues."
    - name: "escalated_exception_count"
      expr: COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END)
      comment: "Number of escalated exceptions requiring management attention. Drives executive visibility into critical supply disruptions."
    - name: "total_exception_count"
      expr: COUNT(1)
      comment: "Total number of planning exceptions generated. Baseline for exception rate trending and MRP parameter quality assessment."
    - name: "avg_safety_stock_quantity"
      expr: AVG(CAST(safety_stock_quantity AS DOUBLE))
      comment: "Average safety stock quantity at time of exception. Low safety stock at exception time indicates inadequate buffer policy."
$$;