-- Metric views for domain: supply | Business: Consumer Goods | Version: 2 | Generated on: 2026-06-28 00:14:33

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`supply_atp_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Available-to-Promise (ATP) KPIs measuring supply availability commitments, backorder exposure, and allocation performance. Used by commercial and supply chain teams to manage customer order promising and allocation."
  source: "`vibe_consumer_goods_v1`.`supply`.`atp_record`"
  dimensions:
    - name: "sku_id"
      expr: sku_id
      comment: "SKU identifier for product-level ATP analysis."
    - name: "atp_supply_network_node_id"
      expr: atp_supply_network_node_id
      comment: "Network node for location-level ATP analysis."
    - name: "atp_record_status"
      expr: atp_record_status
      comment: "Status of the ATP record for pipeline tracking."
    - name: "atp_calculation_method"
      expr: atp_calculation_method
      comment: "Method used to calculate ATP (simple, cumulative, CTP) for methodology comparison."
    - name: "customer_priority_tier"
      expr: customer_priority_tier
      comment: "Customer priority tier for tiered allocation management."
    - name: "planning_bucket"
      expr: planning_bucket
      comment: "Time bucket for ATP horizon analysis."
    - name: "atp_date"
      expr: DATE_TRUNC('month', atp_date)
      comment: "Month of ATP date for availability trending."
    - name: "product_allocation_group"
      expr: product_allocation_group
      comment: "Product allocation group for allocation pool management."
  measures:
    - name: "total_atp_quantity"
      expr: SUM(CAST(atp_quantity AS DOUBLE))
      comment: "Total Available-to-Promise quantity. Primary commercial KPI for customer order commitment management."
    - name: "total_available_quantity"
      expr: SUM(CAST(available_quantity AS DOUBLE))
      comment: "Total available inventory quantity. Baseline supply availability measure used to validate ATP calculations."
    - name: "total_committed_quantity"
      expr: SUM(CAST(committed_quantity AS DOUBLE))
      comment: "Total quantity committed to customer orders. Compared to ATP to measure allocation utilization."
    - name: "total_backorder_quantity"
      expr: SUM(CAST(backorder_quantity AS DOUBLE))
      comment: "Total backorder quantity. Measures unfulfilled demand exposure and customer service risk."
    - name: "total_on_hand_inventory"
      expr: SUM(CAST(on_hand_inventory AS DOUBLE))
      comment: "Total on-hand inventory quantity. Physical inventory baseline for ATP calculation validation."
    - name: "total_cumulative_atp_quantity"
      expr: SUM(CAST(cumulative_atp_quantity AS DOUBLE))
      comment: "Total cumulative ATP quantity across the planning horizon. Used for rolling availability commitment management."
    - name: "total_forecast_consumption_quantity"
      expr: SUM(CAST(forecast_consumption_quantity AS DOUBLE))
      comment: "Total forecast consumption quantity reducing ATP availability. Measures the impact of demand forecasts on available supply."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`supply_consensus_demand`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "S&OP consensus demand KPIs tracking the agreed demand signal across commercial, statistical, and finance inputs. Used by supply chain and commercial leadership to govern the monthly demand review cycle."
  source: "`vibe_consumer_goods_v1`.`supply`.`consensus_demand`"
  dimensions:
    - name: "sku_id"
      expr: sku_id
      comment: "SKU identifier for product-level demand analysis."
    - name: "supply_network_node_id"
      expr: supply_network_node_id
      comment: "Network node for geographic/facility demand segmentation."
    - name: "planning_bucket"
      expr: planning_bucket
      comment: "Time bucket (week, month, quarter) for demand horizon analysis."
    - name: "demand_category"
      expr: demand_category
      comment: "Category of demand (baseline, promotional, new product launch) for structured demand decomposition."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the consensus demand record, enabling governance tracking."
    - name: "constrained_flag"
      expr: constrained_flag
      comment: "Indicates whether the consensus demand is supply-constrained, highlighting gaps between unconstrained demand and supply capability."
    - name: "promotion_flag"
      expr: promotion_flag
      comment: "Flags records with promotional demand uplift for promotion effectiveness analysis."
    - name: "planning_horizon_type"
      expr: planning_horizon_type
      comment: "Horizon type (short, medium, long) for planning cycle governance."
    - name: "agreed_date"
      expr: DATE_TRUNC('month', agreed_date)
      comment: "Month of consensus agreement for S&OP cycle trending."
    - name: "consensus_demand_status"
      expr: consensus_demand_status
      comment: "Lifecycle status of the consensus demand record."
  measures:
    - name: "total_consensus_quantity"
      expr: SUM(CAST(consensus_quantity AS DOUBLE))
      comment: "Total agreed consensus demand volume. The primary S&OP output quantity used to drive supply planning, procurement, and production scheduling."
    - name: "total_statistical_forecast_quantity"
      expr: SUM(CAST(statistical_forecast_quantity AS DOUBLE))
      comment: "Total statistical baseline forecast volume before commercial overlays. Compared to consensus to measure the magnitude of human judgment adjustments."
    - name: "total_commercial_overlay_quantity"
      expr: SUM(CAST(commercial_overlay_quantity AS DOUBLE))
      comment: "Total commercial team overlay applied on top of the statistical forecast. Large overlays signal high commercial confidence or significant event-driven demand."
    - name: "total_unconstrained_demand_quantity"
      expr: SUM(CAST(unconstrained_demand_quantity AS DOUBLE))
      comment: "Total unconstrained demand before supply limitations are applied. The gap between this and consensus_quantity represents supply-constrained lost opportunity."
    - name: "total_promotion_uplift_quantity"
      expr: SUM(CAST(marketing_event_uplift_quantity AS DOUBLE))
      comment: "Total demand uplift attributed to marketing events and promotions. Used to evaluate promotional ROI and plan promotional inventory."
    - name: "avg_demand_volatility_index"
      expr: AVG(CAST(demand_volatility_index AS DOUBLE))
      comment: "Average demand volatility index across consensus records. High volatility drives safety stock requirements and signals planning risk."
    - name: "avg_variance_to_statistical_pct"
      expr: AVG(CAST(variance_to_statistical AS DOUBLE))
      comment: "Average percentage variance between consensus and statistical forecast. Measures the degree of human override in the S&OP process; large persistent variances indicate model or process issues."
    - name: "total_new_product_launch_quantity"
      expr: SUM(CAST(new_product_launch_quantity AS DOUBLE))
      comment: "Total demand volume attributed to new product launches. Critical for NPD pipeline planning and launch readiness assessment."
    - name: "consensus_record_count"
      expr: COUNT(1)
      comment: "Number of consensus demand records. Used to assess S&OP coverage across SKU-node-period combinations."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`supply_constraint`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supply constraint KPIs measuring capacity limitations, financial impact, and mitigation effectiveness across the supply network. Used by supply chain and operations leadership to identify and resolve bottlenecks."
  source: "`vibe_consumer_goods_v1`.`supply`.`constraint`"
  dimensions:
    - name: "sku_id"
      expr: sku_id
      comment: "SKU identifier for product-level constraint analysis."
    - name: "constraint_supply_network_node_id"
      expr: constraint_supply_network_node_id
      comment: "Network node where the constraint is located."
    - name: "constraint_type"
      expr: constraint_type
      comment: "Type of constraint (capacity, material, regulatory, transportation) for structured constraint management."
    - name: "resource_type"
      expr: resource_type
      comment: "Type of constrained resource (machine, labor, storage, transport) for resource-level analysis."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity of the constraint for prioritized resolution."
    - name: "constraint_status"
      expr: constraint_status
      comment: "Current status of the constraint (active, mitigated, resolved)."
    - name: "is_hard_constraint"
      expr: is_hard_constraint
      comment: "Distinguishes hard constraints (cannot be overridden) from soft constraints (can be relaxed with cost)."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category for systemic constraint identification."
    - name: "start_date"
      expr: DATE_TRUNC('month', start_date)
      comment: "Month of constraint start for constraint emergence trending."
  measures:
    - name: "total_constraint_count"
      expr: COUNT(1)
      comment: "Total number of supply constraints. Measures the breadth of supply network bottlenecks."
    - name: "total_financial_impact_amount"
      expr: SUM(CAST(financial_impact_amount AS DOUBLE))
      comment: "Total financial impact of supply constraints. Quantifies the revenue and cost exposure from supply bottlenecks, driving investment prioritization."
    - name: "total_quantity_shortfall"
      expr: SUM(CAST(quantity_shortfall AS DOUBLE))
      comment: "Total volume shortfall caused by supply constraints. Directly measures the supply gap requiring mitigation or demand reallocation."
    - name: "avg_mitigation_effectiveness_score"
      expr: AVG(CAST(mitigation_effectiveness_score AS DOUBLE))
      comment: "Average mitigation effectiveness score across constraints. Measures how well mitigation actions are resolving supply bottlenecks."
    - name: "total_capacity_limit"
      expr: SUM(CAST(capacity_limit AS DOUBLE))
      comment: "Total capacity limit across all constrained resources. Used to assess aggregate supply network capacity ceiling."
    - name: "customer_impacting_constraint_count"
      expr: COUNT(CASE WHEN customer_impact_flag = TRUE THEN 1 END)
      comment: "Number of constraints with direct customer impact. Prioritizes constraints requiring immediate commercial escalation."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`supply_demand_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic demand planning KPIs tracking forecast volumes, accuracy, bias, and plan health across SKUs, channels, and planning horizons. Used by S&OP leaders and demand planners to steer consensus planning cycles."
  source: "`vibe_consumer_goods_v1`.`supply`.`demand_plan`"
  dimensions:
    - name: "demand_plan_status"
      expr: demand_plan_status
      comment: "Current lifecycle status of the demand plan (e.g. Draft, Approved, Locked) for filtering active vs. historical plans."
    - name: "demand_type"
      expr: demand_type
      comment: "Classification of demand type (e.g. Baseline, Promotional, NPD) enabling segmented analysis of demand drivers."
    - name: "planning_bucket"
      expr: planning_bucket
      comment: "Time granularity bucket (Weekly, Monthly) at which the demand plan is expressed."
    - name: "demand_pattern_type"
      expr: demand_pattern_type
      comment: "Characterization of demand pattern (e.g. Seasonal, Intermittent, Stable) for model selection and risk assessment."
    - name: "lifecycle_stage"
      expr: lifecycle_stage
      comment: "Product lifecycle stage (Launch, Growth, Mature, Decline) to contextualize demand plan assumptions."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status of the demand plan, used to track governance compliance."
    - name: "plan_horizon_start"
      expr: DATE_TRUNC('month', plan_horizon_start)
      comment: "Start of the planning horizon truncated to month for time-series trending."
    - name: "risk_category"
      expr: risk_category
      comment: "Risk classification associated with the demand plan for risk-adjusted planning."
    - name: "version_type"
      expr: version_type
      comment: "Type of plan version (Statistical, Commercial, Consensus) to distinguish planning stages."
    - name: "is_consensus_version"
      expr: is_consensus_version
      comment: "Flag indicating whether this is the official consensus version used for supply planning."
  measures:
    - name: "total_planned_quantity"
      expr: SUM(CAST(planned_quantity AS DOUBLE))
      comment: "Total planned demand volume across all demand plans. Core volumetric KPI for capacity and supply planning."
    - name: "total_consensus_quantity"
      expr: SUM(CAST(consensus_quantity AS DOUBLE))
      comment: "Total consensus-agreed demand quantity representing the official S&OP demand signal."
    - name: "total_statistical_baseline_quantity"
      expr: SUM(CAST(statistical_baseline_quantity AS DOUBLE))
      comment: "Total statistical baseline demand before commercial overlays, used to measure overlay impact."
    - name: "total_promotional_overlay_quantity"
      expr: SUM(CAST(promotional_overlay_quantity AS DOUBLE))
      comment: "Total promotional volume uplift added on top of baseline, quantifying trade promotion demand impact."
    - name: "total_commercial_overlay_quantity"
      expr: SUM(CAST(commercial_overlay_quantity AS DOUBLE))
      comment: "Total commercial team overlay quantity reflecting market intelligence adjustments to statistical forecast."
    - name: "avg_forecast_accuracy_pct"
      expr: AVG(CAST(forecast_accuracy_percentage AS DOUBLE))
      comment: "Average forecast accuracy percentage across demand plans. Key S&OP KPI — low accuracy triggers model or process review."
    - name: "avg_forecast_bias_pct"
      expr: AVG(CAST(forecast_bias_percentage AS DOUBLE))
      comment: "Average forecast bias percentage indicating systematic over- or under-forecasting. Persistent bias drives inventory imbalance."
    - name: "total_npd_launch_volume"
      expr: SUM(CAST(npd_launch_volume_quantity AS DOUBLE))
      comment: "Total new product demand volume planned, used to assess NPD pipeline demand readiness."
    - name: "total_variance_to_baseline"
      expr: SUM(CAST(variance_to_baseline_quantity AS DOUBLE))
      comment: "Total variance between consensus and statistical baseline, quantifying the magnitude of human overlay adjustments."
    - name: "active_demand_plan_count"
      expr: COUNT(DISTINCT demand_plan_id)
      comment: "Number of distinct active demand plans, used to monitor planning coverage and governance."
    - name: "risk_flagged_plan_count"
      expr: SUM(CASE WHEN risk_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of demand plans flagged as high-risk, used to prioritize S&OP review and mitigation actions."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`supply_drp_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Distribution Requirements Planning run KPIs tracking planned order generation, demand-supply balance, cost performance, and run quality. Used by supply planners to evaluate DRP execution effectiveness and identify planning issues."
  source: "`vibe_consumer_goods_v1`.`supply`.`drp_run`"
  dimensions:
    - name: "drp_run_status"
      expr: drp_run_status
      comment: "Current status of the DRP run (Completed, Failed, In-Progress) for run quality monitoring."
    - name: "run_type"
      expr: run_type
      comment: "Type of DRP run (Full, Incremental, Simulation) for run-type performance benchmarking."
    - name: "run_status"
      expr: run_status
      comment: "Operational run status for execution monitoring and failure analysis."
    - name: "scenario_name"
      expr: scenario_name
      comment: "Scenario name for what-if DRP runs, used to compare scenario outcomes."
    - name: "is_automated"
      expr: is_automated
      comment: "Indicates whether the DRP run was automated or manually triggered — used to track automation adoption."
    - name: "compliance_check_passed"
      expr: compliance_check_passed
      comment: "Indicates whether the DRP run passed compliance validation — failed runs require investigation."
    - name: "data_snapshot_date"
      expr: DATE_TRUNC('month', data_snapshot_date)
      comment: "Data snapshot date truncated to month for DRP run frequency and quality trending."
    - name: "region_code"
      expr: region_code
      comment: "Region for which the DRP run was executed, used for regional planning performance analysis."
  measures:
    - name: "total_demand_quantity"
      expr: SUM(CAST(total_demand_quantity AS DOUBLE))
      comment: "Total demand quantity processed in DRP runs — primary volume KPI for DRP coverage assessment."
    - name: "total_supply_quantity"
      expr: SUM(CAST(total_supply_quantity AS DOUBLE))
      comment: "Total supply quantity planned in DRP runs, used to assess demand-supply balance across the network."
    - name: "total_planned_cost"
      expr: SUM(CAST(total_planned_cost AS DOUBLE))
      comment: "Total planned replenishment cost from DRP runs — key financial KPI for supply chain cost management."
    - name: "total_actual_cost"
      expr: SUM(CAST(total_actual_cost AS DOUBLE))
      comment: "Total actual replenishment cost from DRP runs, used to measure cost variance against plan."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across DRP runs — high scores indicate supply plans with elevated execution risk."
    - name: "compliance_pass_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN compliance_check_passed = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(drp_run_id), 0), 2)
      comment: "Percentage of DRP runs passing compliance validation — measures planning process quality and governance adherence."
    - name: "total_drp_run_count"
      expr: COUNT(DISTINCT drp_run_id)
      comment: "Total number of DRP runs executed, used to monitor planning cadence and automation coverage."
    - name: "demand_supply_gap"
      expr: SUM((total_demand_quantity) - (total_supply_quantity))
      comment: "Aggregate demand-supply gap from DRP runs — positive values indicate supply shortfalls requiring intervention."
    - name: "cost_variance"
      expr: SUM((total_actual_cost) - (total_planned_cost))
      comment: "Total cost variance between actual and planned replenishment costs — measures DRP plan accuracy and cost control."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`supply_forecast_accuracy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Forecast accuracy and bias KPIs measuring how well demand forecasts predict actual consumption. Core S&OP steering metric used by supply chain leadership to evaluate planning quality and drive model improvements."
  source: "`vibe_consumer_goods_v1`.`supply`.`forecast_accuracy`"
  dimensions:
    - name: "sku_id"
      expr: sku_id
      comment: "SKU identifier for slicing forecast accuracy by product."
    - name: "supply_network_node_id"
      expr: supply_network_node_id
      comment: "Network node (DC, plant, store) where forecast accuracy is measured."
    - name: "measurement_period"
      expr: measurement_period
      comment: "Planning period label (e.g. week, month) for trending accuracy over time."
    - name: "measurement_level"
      expr: measurement_level
      comment: "Aggregation level at which accuracy is measured (SKU, category, node)."
    - name: "forecast_model_type"
      expr: forecast_model_type
      comment: "Statistical model used to generate the forecast, enabling model comparison."
    - name: "planning_period_start_date"
      expr: DATE_TRUNC('month', planning_period_start_date)
      comment: "Month bucket of the planning period start date for time-series trending."
    - name: "product_lifecycle_stage"
      expr: product_lifecycle_stage
      comment: "Lifecycle stage of the product (launch, growth, mature, decline) to contextualize accuracy expectations."
    - name: "new_product_flag"
      expr: new_product_flag
      comment: "Flags new product introductions where forecast accuracy is typically lower."
    - name: "promotional_period_flag"
      expr: promotional_period_flag
      comment: "Flags promotional periods where baseline accuracy models are less reliable."
    - name: "demand_sensing_applied_flag"
      expr: demand_sensing_applied_flag
      comment: "Indicates whether demand sensing signals were applied, enabling A/B comparison of sensing vs. statistical-only forecasts."
  measures:
    - name: "avg_mape_pct"
      expr: AVG(CAST(mape AS DOUBLE))
      comment: "Average Mean Absolute Percentage Error across all forecast records. Primary forecast accuracy KPI used in S&OP reviews; lower is better. Drives model selection and planner accountability."
    - name: "avg_wmape_pct"
      expr: AVG(CAST(wmape AS DOUBLE))
      comment: "Average Weighted MAPE, which weights errors by volume. More representative than simple MAPE for high-volume SKUs. Used by supply chain VPs to assess overall planning quality."
    - name: "avg_bias_pct"
      expr: AVG(CAST(bias_pct AS DOUBLE))
      comment: "Average forecast bias percentage. Positive bias = over-forecasting (excess inventory risk); negative = under-forecasting (stockout risk). Critical for identifying systematic planner or model bias."
    - name: "total_forecast_quantity"
      expr: SUM(CAST(forecast_quantity AS DOUBLE))
      comment: "Total forecasted volume across all records in scope. Baseline denominator for volume-weighted accuracy analysis."
    - name: "total_actual_quantity"
      expr: SUM(CAST(actual_quantity AS DOUBLE))
      comment: "Total actual demand quantity realized. Compared against forecast quantity to assess aggregate over/under-forecast."
    - name: "total_forecast_error_volume"
      expr: SUM(CAST(forecast_error AS DOUBLE))
      comment: "Sum of absolute forecast errors in volume units. Quantifies the total planning gap that must be absorbed by safety stock or expediting."
    - name: "avg_tracking_signal"
      expr: AVG(CAST(tracking_signal AS DOUBLE))
      comment: "Average tracking signal across records. Values outside ±4 indicate a biased forecast model requiring recalibration. Used by demand planners to trigger model reviews."
    - name: "avg_sensing_uplift_pct"
      expr: AVG(CAST(sensing_uplift_percent AS DOUBLE))
      comment: "Average percentage uplift delivered by demand sensing signals over the statistical baseline. Quantifies the ROI of demand sensing investments."
    - name: "forecast_record_count"
      expr: COUNT(1)
      comment: "Number of forecast accuracy measurement records. Used to assess coverage and statistical significance of accuracy KPIs."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`supply_inventory_policy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory policy KPIs measuring service level targets, reorder parameters, and policy compliance across the supply network. Used by supply chain leadership to govern inventory investment and service level commitments."
  source: "`vibe_consumer_goods_v1`.`supply`.`inventory_policy`"
  dimensions:
    - name: "sku_id"
      expr: sku_id
      comment: "SKU identifier for product-level policy analysis."
    - name: "inventory_supply_network_node_id"
      expr: inventory_supply_network_node_id
      comment: "Network node for location-level policy analysis."
    - name: "policy_type"
      expr: policy_type
      comment: "Type of inventory policy (min-max, reorder point, periodic review) for policy mix analysis."
    - name: "replenishment_method"
      expr: replenishment_method
      comment: "Replenishment method (MRP, DRP, VMI, manual) for method effectiveness comparison."
    - name: "inventory_policy_status"
      expr: inventory_policy_status
      comment: "Status of the inventory policy record."
    - name: "retailer_mandated_target_flag"
      expr: retailer_mandated_target_flag
      comment: "Flags retailer-mandated policies with contractual service level obligations."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the policy for governance tracking."
    - name: "effective_start_date"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month of policy effective start for policy change trending."
  measures:
    - name: "avg_service_level_target_pct"
      expr: AVG(CAST(service_level_target_pct AS DOUBLE))
      comment: "Average service level target percentage across all active policies. Primary customer commitment KPI governing inventory investment levels."
    - name: "avg_fill_rate_target_pct"
      expr: AVG(CAST(fill_rate_target_percent AS DOUBLE))
      comment: "Average fill rate target percentage. Measures the in-full component of customer service level commitments."
    - name: "avg_otif_composite_target_pct"
      expr: AVG(CAST(otif_composite_target_percent AS DOUBLE))
      comment: "Average composite OTIF target percentage embedded in inventory policies. Aligns inventory investment to customer delivery commitments."
    - name: "avg_safety_stock_days_of_supply"
      expr: AVG(CAST(safety_stock_days_of_supply AS DOUBLE))
      comment: "Average safety stock days-of-supply target across policies. Measures the working capital cost of service level commitments."
    - name: "avg_reorder_point"
      expr: AVG(CAST(reorder_point AS DOUBLE))
      comment: "Average reorder point quantity across policies. Used to benchmark replenishment trigger levels against demand and lead time parameters."
    - name: "total_max_stock_level"
      expr: SUM(CAST(max_stock_level AS DOUBLE))
      comment: "Total maximum stock level across all policies. Represents the upper bound of planned inventory investment."
    - name: "inventory_policy_count"
      expr: COUNT(1)
      comment: "Number of active inventory policies. Used to assess policy coverage across the SKU-node portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`supply_inventory_projection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Forward-looking inventory projection KPIs measuring projected on-hand, stockout risk, and days-of-supply across the supply network. Used by supply chain planners and operations leadership to identify and resolve projected inventory gaps."
  source: "`vibe_consumer_goods_v1`.`supply`.`inventory_projection`"
  dimensions:
    - name: "sku_id"
      expr: sku_id
      comment: "SKU identifier for product-level inventory projection analysis."
    - name: "inventory_supply_network_node_id"
      expr: inventory_supply_network_node_id
      comment: "Network node for location-level inventory projection."
    - name: "projection_type"
      expr: projection_type
      comment: "Type of projection (unconstrained, constrained, consensus) for scenario comparison."
    - name: "projection_status"
      expr: projection_status
      comment: "Status of the projection record for pipeline governance."
    - name: "planning_bucket"
      expr: planning_bucket
      comment: "Time bucket for projection horizon analysis."
    - name: "projection_date"
      expr: DATE_TRUNC('month', projection_date)
      comment: "Month of projection date for time-series inventory trending."
    - name: "stockout_flag"
      expr: stockout_flag
      comment: "Flags projected stockout records for at-risk SKU-node identification."
    - name: "excess_inventory_flag"
      expr: excess_inventory_flag
      comment: "Flags projected excess inventory records for working capital risk identification."
    - name: "oos_risk_flag"
      expr: oos_risk_flag
      comment: "Flags out-of-stock risk records requiring expediting or reallocation."
  measures:
    - name: "total_projected_on_hand_quantity"
      expr: SUM(CAST(projected_on_hand_quantity AS DOUBLE))
      comment: "Total projected on-hand inventory quantity. Primary inventory health KPI used to validate supply plan adequacy."
    - name: "total_projected_demand_quantity"
      expr: SUM(CAST(projected_demand_quantity AS DOUBLE))
      comment: "Total projected demand quantity in the planning horizon. Compared to projected on-hand to identify supply gaps."
    - name: "total_projected_receipt_quantity"
      expr: SUM(CAST(projected_receipt_quantity AS DOUBLE))
      comment: "Total projected inbound receipts. Validates that planned supply orders will arrive in time to cover demand."
    - name: "total_projected_available_balance"
      expr: SUM(CAST(projected_available_balance AS DOUBLE))
      comment: "Total projected available balance (on-hand + receipts - demand). Negative values indicate projected stockouts requiring immediate action."
    - name: "avg_days_of_supply"
      expr: AVG(CAST(days_of_supply AS DOUBLE))
      comment: "Average projected days of supply across all records. Key operational KPI; values below safety stock threshold trigger replenishment actions."
    - name: "stockout_record_count"
      expr: COUNT(CASE WHEN stockout_flag = TRUE THEN 1 END)
      comment: "Number of projected stockout records. Directly measures supply plan failure risk and drives expediting prioritization."
    - name: "avg_supply_risk_score"
      expr: AVG(CAST(supply_risk_score AS DOUBLE))
      comment: "Average supply risk score across projection records. Composite risk indicator used by supply chain leadership to prioritize intervention."
    - name: "total_atp_quantity"
      expr: SUM(CAST(atp_quantity AS DOUBLE))
      comment: "Total Available-to-Promise quantity from inventory projections. Used by commercial teams to manage customer order commitments."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`supply_network_lane`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supply network lane KPIs tracking lead times, capacity, cost, and service levels across the replenishment network. Used by supply chain network designers and logistics managers to optimize lane selection and network configuration."
  source: "`vibe_consumer_goods_v1`.`supply`.`network_lane`"
  dimensions:
    - name: "network_lane_status"
      expr: network_lane_status
      comment: "Current status of the network lane (Active, Inactive, Under Review) for filtering operational lanes."
    - name: "lane_type"
      expr: lane_type
      comment: "Type of network lane (Primary, Secondary, Emergency) for lane strategy analysis."
    - name: "lane_mode"
      expr: lane_mode
      comment: "Transport mode of the lane (Road, Rail, Air, Sea) for modal cost and lead time benchmarking."
    - name: "transport_mode"
      expr: transport_mode
      comment: "Transportation mode for the lane, used for modal split analysis and cost optimization."
    - name: "is_primary_lane"
      expr: is_primary_lane
      comment: "Indicates whether this is the primary replenishment lane — used to assess primary vs. backup lane performance."
    - name: "risk_category"
      expr: risk_category
      comment: "Risk category of the lane (Low, Medium, High) for supply chain resilience analysis."
    - name: "is_active"
      expr: is_active
      comment: "Active status flag for filtering operational lanes in network analysis."
    - name: "effective_start_date"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Lane effective start date truncated to month for network evolution trending."
  measures:
    - name: "avg_lead_time_days"
      expr: AVG(CAST(lead_time_days AS DOUBLE))
      comment: "Average lead time in days across network lanes — primary supply chain responsiveness KPI."
    - name: "avg_standard_lead_time_days"
      expr: AVG(CAST(standard_lead_time_days AS DOUBLE))
      comment: "Average standard lead time across lanes, used as the baseline for lead time performance measurement."
    - name: "avg_transportation_lead_time_days"
      expr: AVG(CAST(transportation_lead_time_days AS DOUBLE))
      comment: "Average transportation lead time component, used to isolate transit time from total lead time."
    - name: "avg_cost_per_unit"
      expr: AVG(CAST(cost_per_unit AS DOUBLE))
      comment: "Average replenishment cost per unit across lanes — key supply chain cost efficiency KPI."
    - name: "total_capacity_quantity"
      expr: SUM(CAST(capacity_quantity AS DOUBLE))
      comment: "Total capacity across all network lanes — used to assess aggregate supply network throughput capability."
    - name: "avg_otif_target_pct"
      expr: AVG(CAST(otif_target_pct AS DOUBLE))
      comment: "Average OTIF target percentage across lanes — measures the service level ambition of the replenishment network."
    - name: "avg_safety_stock_days"
      expr: AVG(CAST(safety_stock_days AS DOUBLE))
      comment: "Average safety stock days associated with network lanes, used to assess pipeline buffer requirements."
    - name: "avg_minimum_order_quantity"
      expr: AVG(CAST(minimum_order_quantity AS DOUBLE))
      comment: "Average minimum order quantity across lanes — impacts replenishment flexibility and working capital efficiency."
    - name: "active_lane_count"
      expr: SUM(CASE WHEN is_active = TRUE THEN 1 ELSE 0 END)
      comment: "Count of active network lanes — measures supply network connectivity and redundancy."
    - name: "avg_service_level_target_pct"
      expr: AVG(CAST(service_level_target_pct AS DOUBLE))
      comment: "Average service level target across network lanes, used to benchmark lane performance commitments."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`supply_network_node`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supply network node KPIs tracking node capacity, throughput, storage utilization, and network configuration. Used by supply chain network designers and operations managers to optimize the physical supply network."
  source: "`vibe_consumer_goods_v1`.`supply`.`network_node`"
  dimensions:
    - name: "network_node_status"
      expr: network_node_status
      comment: "Current operational status of the network node (Active, Inactive, Under Construction) for network coverage analysis."
    - name: "node_type"
      expr: node_type
      comment: "Type of network node (Manufacturing Plant, DC, Cross-Dock, Retail) for node-type performance benchmarking."
    - name: "echelon_level"
      expr: echelon_level
      comment: "Supply chain echelon level (Tier 1, Tier 2, Tier 3) for multi-echelon network analysis."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership type of the node (Owned, Leased, 3PL) for make-vs-buy and network strategy decisions."
    - name: "country_code"
      expr: country_code
      comment: "Country of the network node for geographic supply network analysis and regulatory compliance."
    - name: "region"
      expr: region
      comment: "Geographic region of the network node for regional supply chain performance analysis."
    - name: "temperature_controlled_flag"
      expr: temperature_controlled_flag
      comment: "Indicates cold chain capability — critical for consumer goods requiring temperature-controlled storage."
    - name: "vmi_enabled_flag"
      expr: vmi_enabled_flag
      comment: "Indicates whether the node supports VMI operations, used for VMI network coverage analysis."
    - name: "is_active"
      expr: is_active
      comment: "Active status flag for filtering operational nodes in network analysis."
  measures:
    - name: "total_storage_capacity_units"
      expr: SUM(CAST(storage_capacity_units AS DOUBLE))
      comment: "Total storage capacity across the supply network — key network capacity KPI for investment and expansion planning."
    - name: "avg_throughput_capacity_daily"
      expr: AVG(CAST(throughput_capacity_daily AS DOUBLE))
      comment: "Average daily throughput capacity per node, used to identify bottlenecks in the supply network."
    - name: "total_throughput_capacity_daily"
      expr: SUM(CAST(throughput_capacity_daily AS DOUBLE))
      comment: "Total daily throughput capacity across the network, used to assess aggregate supply chain processing capability."
    - name: "active_node_count"
      expr: SUM(CASE WHEN is_active = TRUE THEN 1 ELSE 0 END)
      comment: "Count of active supply network nodes — measures network coverage and operational footprint."
    - name: "temperature_controlled_node_count"
      expr: SUM(CASE WHEN temperature_controlled_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of temperature-controlled nodes — measures cold chain network coverage for perishable consumer goods."
    - name: "vmi_enabled_node_count"
      expr: SUM(CASE WHEN vmi_enabled_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of VMI-enabled nodes — measures VMI program network reach and capability."
    - name: "total_node_count"
      expr: COUNT(DISTINCT network_node_id)
      comment: "Total number of distinct supply network nodes, used to monitor network size and geographic coverage."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`supply_otif_target`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "OTIF (On-Time In-Full) target KPIs measuring customer service level commitments and penalty exposure. Used by supply chain and commercial leadership to govern customer delivery performance agreements."
  source: "`vibe_consumer_goods_v1`.`supply`.`otif_target`"
  dimensions:
    - name: "sku_id"
      expr: sku_id
      comment: "SKU identifier for product-level OTIF target analysis."
    - name: "trade_account_id"
      expr: trade_account_id
      comment: "Trade account (customer) for customer-specific OTIF commitment tracking."
    - name: "otif_supply_network_node_id"
      expr: otif_supply_network_node_id
      comment: "Network node for location-level OTIF target analysis."
    - name: "measurement_frequency"
      expr: measurement_frequency
      comment: "Frequency of OTIF measurement (weekly, monthly) for governance cadence alignment."
    - name: "priority_tier"
      expr: priority_tier
      comment: "Customer priority tier for tiered service level management."
    - name: "otif_target_status"
      expr: otif_target_status
      comment: "Status of the OTIF target record (active, expired, under review)."
    - name: "retailer_mandated_target_flag"
      expr: retailer_mandated_target_flag
      comment: "Flags retailer-mandated OTIF targets with penalty clauses, requiring highest priority management."
    - name: "penalty_clause_flag"
      expr: penalty_clause_flag
      comment: "Flags OTIF targets with financial penalty clauses for risk exposure tracking."
    - name: "effective_start_date"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month of target effective start for contract period analysis."
  measures:
    - name: "avg_otif_composite_target_pct"
      expr: AVG(CAST(otif_composite_target_percent AS DOUBLE))
      comment: "Average composite OTIF target percentage across all active commitments. Primary customer service level KPI used in commercial and supply chain reviews."
    - name: "avg_on_time_target_pct"
      expr: AVG(CAST(on_time_delivery_target_percent AS DOUBLE))
      comment: "Average on-time delivery target percentage. Measures the timeliness component of OTIF commitments."
    - name: "avg_in_full_target_pct"
      expr: AVG(CAST(in_full_fill_rate_target_percent AS DOUBLE))
      comment: "Average in-full fill rate target percentage. Measures the completeness component of OTIF commitments."
    - name: "avg_penalty_rate_pct"
      expr: AVG(CAST(penalty_rate_percent AS DOUBLE))
      comment: "Average penalty rate percentage for OTIF failures. Quantifies the financial exposure per unit of OTIF shortfall."
    - name: "avg_escalation_threshold_pct"
      expr: AVG(CAST(escalation_threshold_percent AS DOUBLE))
      comment: "Average escalation threshold percentage below which OTIF failures trigger formal escalation. Used to calibrate alert thresholds."
    - name: "otif_target_count"
      expr: COUNT(1)
      comment: "Number of active OTIF target commitments. Used to assess the breadth of customer service level obligations."
    - name: "penalty_clause_target_count"
      expr: COUNT(CASE WHEN penalty_clause_flag = TRUE THEN 1 END)
      comment: "Number of OTIF targets with financial penalty clauses. Quantifies the scope of penalty exposure in the customer portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`supply_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supply plan KPIs covering planned production, replenishment, and inventory quantities across the supply network. Used by supply chain planners and operations leadership to govern supply execution against demand."
  source: "`vibe_consumer_goods_v1`.`supply`.`plan`"
  dimensions:
    - name: "sku_id"
      expr: sku_id
      comment: "SKU identifier for product-level supply plan analysis."
    - name: "plan_supply_network_node_id"
      expr: plan_supply_network_node_id
      comment: "Destination network node for the supply plan record."
    - name: "plan_type"
      expr: plan_type
      comment: "Type of supply plan (production, replenishment, distribution) for plan category analysis."
    - name: "plan_status"
      expr: plan_status
      comment: "Execution status of the plan record for pipeline tracking."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the plan for governance and release tracking."
    - name: "planning_bucket"
      expr: planning_bucket
      comment: "Time bucket for plan horizon analysis."
    - name: "horizon_start"
      expr: DATE_TRUNC('month', horizon_start)
      comment: "Month of plan horizon start for time-series supply plan trending."
    - name: "supplier_id"
      expr: supplier_id
      comment: "Supplier identifier for supplier-level supply plan analysis."
    - name: "manufacturing_facility_id"
      expr: manufacturing_facility_id
      comment: "Manufacturing facility for production plan analysis."
    - name: "distribution_facility_id"
      expr: distribution_facility_id
      comment: "Distribution facility for replenishment plan analysis."
  measures:
    - name: "total_planned_quantity"
      expr: SUM(CAST(planned_quantity AS DOUBLE))
      comment: "Total planned supply quantity across all plan records. Primary supply plan output used to validate supply coverage against consensus demand."
    - name: "total_planned_production_quantity"
      expr: SUM(CAST(planned_production_quantity AS DOUBLE))
      comment: "Total planned production volume. Used by manufacturing leadership to validate plant loading and capacity utilization."
    - name: "total_planned_replenishment_quantity"
      expr: SUM(CAST(planned_replenishment_quantity AS DOUBLE))
      comment: "Total planned replenishment volume across the distribution network. Drives warehouse and transportation capacity planning."
    - name: "total_atp_quantity"
      expr: SUM(CAST(atp_quantity AS DOUBLE))
      comment: "Total Available-to-Promise quantity from the supply plan. Used by commercial teams to commit to customer orders and manage allocation."
    - name: "total_safety_stock_quantity"
      expr: SUM(CAST(safety_stock_quantity AS DOUBLE))
      comment: "Total safety stock quantity embedded in the supply plan. Represents the working capital cost of supply uncertainty buffers."
    - name: "avg_supply_risk_score"
      expr: AVG(CAST(supply_risk_score AS DOUBLE))
      comment: "Average supply risk score across plan records. High scores indicate plans with elevated execution risk requiring leadership attention."
    - name: "total_demand_forecast_quantity"
      expr: SUM(CAST(demand_forecast_quantity AS DOUBLE))
      comment: "Total demand forecast quantity embedded in the supply plan. Compared to planned_quantity to identify supply-demand gaps."
    - name: "total_projected_inventory_balance"
      expr: SUM(CAST(projected_inventory_balance AS DOUBLE))
      comment: "Total projected inventory balance resulting from the supply plan. Negative values indicate projected stockouts requiring plan revision."
    - name: "plan_record_count"
      expr: COUNT(1)
      comment: "Number of supply plan records. Used to assess planning coverage across SKU-node-period combinations."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`supply_planning_exception`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supply planning exception KPIs measuring the volume, severity, and resolution of planning alerts. Used by supply chain planners and operations leadership to prioritize exception management and measure planning process health."
  source: "`vibe_consumer_goods_v1`.`supply`.`planning_exception`"
  dimensions:
    - name: "sku_id"
      expr: sku_id
      comment: "SKU identifier for product-level exception analysis."
    - name: "planning_supply_network_node_id"
      expr: planning_supply_network_node_id
      comment: "Network node for location-level exception analysis."
    - name: "exception_type"
      expr: exception_type
      comment: "Type of planning exception (stockout risk, excess inventory, lead time breach) for structured exception management."
    - name: "exception_severity"
      expr: exception_severity
      comment: "Severity level of the exception for prioritized resolution."
    - name: "exception_status"
      expr: exception_status
      comment: "Current status of the exception (open, in-progress, resolved) for workload management."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category for systemic issue identification and process improvement."
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Flags escalated exceptions requiring leadership attention."
    - name: "detected_date"
      expr: DATE_TRUNC('month', detected_date)
      comment: "Month of exception detection for trend analysis and process health monitoring."
    - name: "planning_exception_status"
      expr: planning_exception_status
      comment: "Lifecycle status of the planning exception record."
  measures:
    - name: "total_exception_count"
      expr: COUNT(1)
      comment: "Total number of planning exceptions. Primary planning process health KPI; high counts indicate supply plan instability."
    - name: "open_exception_count"
      expr: COUNT(CASE WHEN exception_status = 'Open' THEN 1 END)
      comment: "Number of unresolved open exceptions. Measures current planning backlog and risk exposure."
    - name: "escalated_exception_count"
      expr: COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END)
      comment: "Number of escalated exceptions requiring leadership intervention. High counts signal systemic supply chain issues."
    - name: "total_business_impact_amount"
      expr: SUM(CAST(business_impact_amount AS DOUBLE))
      comment: "Total financial impact of planning exceptions. Quantifies the cost of supply plan failures and drives prioritization of resolution resources."
    - name: "total_exception_quantity"
      expr: SUM(CAST(exception_quantity AS DOUBLE))
      comment: "Total volume affected by planning exceptions. Used to assess the scale of supply-demand imbalances requiring resolution."
    - name: "avg_resolution_duration_hours"
      expr: AVG(CAST(resolution_duration_hours AS DOUBLE))
      comment: "Average time to resolve planning exceptions in hours. Measures planning team responsiveness and process efficiency."
    - name: "total_gap_quantity"
      expr: SUM(CAST(gap_quantity AS DOUBLE))
      comment: "Total supply-demand gap quantity across all exceptions. Directly measures the volume at risk of stockout or service failure."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`supply_risk_register`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supply chain risk register KPIs measuring risk exposure, mitigation effectiveness, and financial impact. Used by supply chain leadership and risk management to govern supply chain resilience and business continuity."
  source: "`vibe_consumer_goods_v1`.`supply`.`risk_register`"
  dimensions:
    - name: "sku_id"
      expr: sku_id
      comment: "SKU identifier for product-level supply risk analysis."
    - name: "risk_supply_network_node_id"
      expr: risk_supply_network_node_id
      comment: "Network node for location-level risk analysis."
    - name: "risk_category"
      expr: risk_category
      comment: "Category of supply risk (supplier, logistics, demand, regulatory) for structured risk portfolio management."
    - name: "risk_subcategory"
      expr: risk_subcategory
      comment: "Sub-category for granular risk classification and root cause analysis."
    - name: "impact_severity"
      expr: impact_severity
      comment: "Severity of risk impact (critical, high, medium, low) for prioritized mitigation."
    - name: "risk_register_status"
      expr: risk_register_status
      comment: "Current status of the risk record (open, mitigated, closed) for risk lifecycle tracking."
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Flags risks that have been escalated to senior leadership."
    - name: "supplier_id"
      expr: supplier_id
      comment: "Supplier identifier for supplier-specific risk concentration analysis."
    - name: "identified_date"
      expr: DATE_TRUNC('month', identified_date)
      comment: "Month of risk identification for risk emergence trending."
  measures:
    - name: "total_risk_count"
      expr: COUNT(1)
      comment: "Total number of supply chain risks in the register. Measures the breadth of the risk portfolio requiring management attention."
    - name: "open_risk_count"
      expr: COUNT(CASE WHEN risk_register_status = 'Open' THEN 1 END)
      comment: "Number of open, unmitigated supply chain risks. Primary risk exposure KPI used in executive risk reviews."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average composite risk score (probability × impact) across all risks. Used to benchmark overall supply chain risk level against targets."
    - name: "avg_residual_risk_score"
      expr: AVG(CAST(residual_risk_score AS DOUBLE))
      comment: "Average residual risk score after mitigation actions. Compared to inherent risk score to measure mitigation effectiveness."
    - name: "total_contingency_cost_estimate"
      expr: SUM(CAST(contingency_cost_estimate AS DOUBLE))
      comment: "Total estimated contingency cost across all supply chain risks. Quantifies the financial reserve required for risk management."
    - name: "avg_probability_score"
      expr: AVG(CAST(probability_score AS DOUBLE))
      comment: "Average risk probability score. Used to prioritize mitigation investment toward highest-likelihood risks."
    - name: "avg_impact_score"
      expr: AVG(CAST(impact_score AS DOUBLE))
      comment: "Average risk impact score. Used to prioritize mitigation investment toward highest-consequence risks."
    - name: "total_contingency_stock_quantity"
      expr: SUM(CAST(contingency_stock_quantity AS DOUBLE))
      comment: "Total contingency stock quantity held against supply chain risks. Represents the working capital cost of risk mitigation buffers."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`supply_safety_stock`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Safety stock KPIs measuring inventory buffer levels, service level targets, and working capital implications. Used by supply chain and finance leadership to balance service level commitments against inventory investment."
  source: "`vibe_consumer_goods_v1`.`supply`.`safety_stock`"
  dimensions:
    - name: "sku_id"
      expr: sku_id
      comment: "SKU identifier for product-level safety stock analysis."
    - name: "safety_supply_network_node_id"
      expr: safety_supply_network_node_id
      comment: "Network node where safety stock is held."
    - name: "abc_classification"
      expr: abc_classification
      comment: "ABC classification of the SKU for prioritized safety stock management."
    - name: "xyz_classification"
      expr: xyz_classification
      comment: "XYZ demand variability classification for safety stock method selection."
    - name: "calculation_method"
      expr: calculation_method
      comment: "Method used to calculate safety stock (statistical, days-of-supply, manual) for methodology benchmarking."
    - name: "demand_classification"
      expr: demand_classification
      comment: "Demand pattern classification (regular, intermittent, lumpy) driving safety stock policy."
    - name: "safety_stock_status"
      expr: safety_stock_status
      comment: "Current status of the safety stock record (active, under review, expired)."
    - name: "effective_date"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month of safety stock effective date for policy change trending."
  measures:
    - name: "total_safety_stock_quantity"
      expr: SUM(CAST(safety_stock_quantity AS DOUBLE))
      comment: "Total safety stock quantity across all records. Primary working capital KPI for inventory investment governance."
    - name: "total_approved_safety_stock_units"
      expr: SUM(CAST(approved_safety_stock_units AS DOUBLE))
      comment: "Total approved safety stock units after management review. Compared to calculated units to measure override magnitude."
    - name: "total_calculated_safety_stock_units"
      expr: SUM(CAST(calculated_safety_stock_units AS DOUBLE))
      comment: "Total statistically calculated safety stock units before management override. Baseline for policy compliance assessment."
    - name: "avg_service_level_pct"
      expr: AVG(CAST(service_level_pct AS DOUBLE))
      comment: "Average target service level percentage across safety stock records. Directly linked to customer fill rate commitments and OTIF performance."
    - name: "avg_days_of_supply_target"
      expr: AVG(CAST(days_of_supply_target AS DOUBLE))
      comment: "Average days-of-supply safety stock target. Used by supply chain leadership to benchmark inventory coverage policies."
    - name: "avg_demand_variability_coefficient"
      expr: AVG(CAST(demand_variability_coefficient AS DOUBLE))
      comment: "Average demand variability coefficient driving safety stock calculations. High values indicate volatile demand requiring larger buffers."
    - name: "avg_lead_time_variability_days"
      expr: AVG(CAST(lead_time_variability_days AS DOUBLE))
      comment: "Average supplier lead time variability in days. Key driver of safety stock levels; high variability increases required buffer."
    - name: "total_holding_cost"
      expr: SUM(CAST(holding_cost_per_unit AS DOUBLE))
      comment: "Total holding cost per unit across safety stock records. Quantifies the financial cost of maintaining safety stock buffers."
    - name: "safety_stock_record_count"
      expr: COUNT(1)
      comment: "Number of active safety stock records. Used to assess policy coverage across the SKU-node portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`supply_sop_cycle`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "S&OP cycle KPIs measuring the health and outcomes of the monthly Sales & Operations Planning process. Used by supply chain and commercial leadership to govern the S&OP cadence and track consensus achievement."
  source: "`vibe_consumer_goods_v1`.`supply`.`sop_cycle`"
  dimensions:
    - name: "cycle_type"
      expr: cycle_type
      comment: "Type of S&OP cycle (monthly, quarterly, annual) for cycle cadence analysis."
    - name: "cycle_phase"
      expr: cycle_phase
      comment: "Current phase of the S&OP cycle (demand review, supply review, pre-S&OP, executive) for process stage tracking."
    - name: "cycle_status"
      expr: cycle_status
      comment: "Overall status of the S&OP cycle for governance tracking."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the S&OP cycle for financial calendar alignment."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual S&OP performance trending."
    - name: "demand_consensus_achieved_flag"
      expr: demand_consensus_achieved_flag
      comment: "Flags cycles where demand consensus was achieved, measuring S&OP process effectiveness."
    - name: "supply_consensus_achieved_flag"
      expr: supply_consensus_achieved_flag
      comment: "Flags cycles where supply consensus was achieved."
    - name: "executive_approval_flag"
      expr: executive_approval_flag
      comment: "Flags cycles that received executive approval, measuring governance compliance."
    - name: "cycle_start_date"
      expr: DATE_TRUNC('month', cycle_start_date)
      comment: "Month of S&OP cycle start for time-series process health trending."
  measures:
    - name: "total_consensus_demand_volume"
      expr: SUM(CAST(consensus_demand_volume AS DOUBLE))
      comment: "Total consensus demand volume agreed in S&OP cycles. Primary S&OP output volume KPI used to validate commercial and supply alignment."
    - name: "total_constrained_supply_volume"
      expr: SUM(CAST(constrained_supply_volume AS DOUBLE))
      comment: "Total constrained supply volume committed in S&OP cycles. Compared to consensus demand to measure supply-demand gap."
    - name: "total_supply_gap_volume"
      expr: SUM(CAST(supply_gap_volume AS DOUBLE))
      comment: "Total supply gap volume (demand minus constrained supply) across S&OP cycles. Directly measures unmet demand risk requiring executive decision."
    - name: "total_baseline_demand_volume"
      expr: SUM(CAST(baseline_demand_volume AS DOUBLE))
      comment: "Total baseline demand volume before S&OP adjustments. Compared to consensus to measure the magnitude of S&OP-driven demand shaping."
    - name: "sop_cycle_count"
      expr: COUNT(1)
      comment: "Number of S&OP cycles completed. Used to assess S&OP cadence compliance."
    - name: "consensus_achieved_cycle_count"
      expr: COUNT(CASE WHEN demand_consensus_achieved_flag = TRUE AND supply_consensus_achieved_flag = TRUE THEN 1 END)
      comment: "Number of S&OP cycles where both demand and supply consensus were achieved. Measures S&OP process effectiveness and cross-functional alignment."
    - name: "executive_approved_cycle_count"
      expr: COUNT(CASE WHEN executive_approval_flag = TRUE THEN 1 END)
      comment: "Number of S&OP cycles that received executive approval. Measures governance compliance and leadership engagement in the S&OP process."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`supply_replenishment_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supply replenishment order KPIs measuring order fulfillment performance, lead time adherence, and replenishment cost. Used by supply chain and procurement leadership to govern the replenishment execution cycle."
  source: "`vibe_consumer_goods_v1`.`supply`.`supply_replenishment_order`"
  dimensions:
    - name: "sku_id"
      expr: sku_id
      comment: "SKU identifier for product-level replenishment analysis."
    - name: "primary_supply_network_node_id"
      expr: primary_supply_network_node_id
      comment: "Destination network node for replenishment order analysis."
    - name: "order_type"
      expr: order_type
      comment: "Type of replenishment order (planned, firm, emergency) for order mix analysis."
    - name: "order_status"
      expr: order_status
      comment: "Current status of the replenishment order for pipeline tracking."
    - name: "transportation_mode"
      expr: transportation_mode
      comment: "Mode of transport for cost and lead time analysis by transport type."
    - name: "carrier_id"
      expr: carrier_id
      comment: "Carrier identifier for carrier performance benchmarking."
    - name: "planned_ship_date"
      expr: DATE_TRUNC('month', planned_ship_date)
      comment: "Month of planned ship date for replenishment volume trending."
    - name: "safety_stock_trigger_flag"
      expr: safety_stock_trigger_flag
      comment: "Flags orders triggered by safety stock breach, indicating reactive vs. planned replenishment."
    - name: "priority"
      expr: priority
      comment: "Order priority level for expediting and resource allocation analysis."
  measures:
    - name: "total_order_quantity"
      expr: SUM(CAST(order_quantity AS DOUBLE))
      comment: "Total replenishment order quantity. Primary volume KPI for supply chain throughput and capacity planning."
    - name: "total_confirmed_quantity"
      expr: SUM(CAST(confirmed_quantity AS DOUBLE))
      comment: "Total confirmed replenishment quantity. Compared to order quantity to measure supplier confirmation rate."
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total quantity actually received. Compared to order quantity to measure in-full delivery performance."
    - name: "total_order_cost_amount"
      expr: SUM(CAST(order_cost_amount AS DOUBLE))
      comment: "Total replenishment order cost. Key supply chain cost KPI used by finance and supply chain leadership to manage logistics spend."
    - name: "replenishment_order_count"
      expr: COUNT(1)
      comment: "Total number of replenishment orders. Used to assess order frequency and identify opportunities for order consolidation."
    - name: "safety_stock_triggered_order_count"
      expr: COUNT(CASE WHEN safety_stock_trigger_flag = TRUE THEN 1 END)
      comment: "Number of orders triggered by safety stock breach. High counts indicate reactive planning and potential service level risk."
    - name: "avg_requested_quantity"
      expr: AVG(CAST(requested_quantity AS DOUBLE))
      comment: "Average requested replenishment quantity per order. Used to benchmark order sizing against minimum order quantity policies."
    - name: "total_shipped_quantity"
      expr: SUM(CAST(shipped_quantity AS DOUBLE))
      comment: "Total quantity shipped by suppliers. Compared to confirmed quantity to measure supplier execution reliability."
$$;
