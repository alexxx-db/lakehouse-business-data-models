-- Metric views for domain: supply | Business: Consumer_Goods | Version: 2 | Generated on: 2026-07-10 13:28:51

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`supply_forecast_accuracy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks forecast quality KPIs including MAPE, bias, and demand-sensing effectiveness — core S&OP steering metrics used by supply chain leadership to evaluate planning model performance and drive corrective action."
  source: "`vibe_consumer_goods_v1`.`supply`.`forecast_accuracy`"
  dimensions:
    - name: "sku_id"
      expr: sku_id
      comment: "Product SKU identifier — enables accuracy analysis by individual SKU."
    - name: "forecast_model_type"
      expr: forecast_model_type
      comment: "Statistical model type used for the forecast — enables comparison of model performance."
    - name: "measurement_cycle"
      expr: measurement_cycle
      comment: "Measurement cycle (weekly, monthly, etc.) — enables trending over planning horizons."
    - name: "planning_level"
      expr: planning_level
      comment: "Aggregation level at which forecast was measured — enables drill-down from aggregate to SKU level."
    - name: "product_lifecycle_stage"
      expr: product_lifecycle_stage
      comment: "Product lifecycle stage — enables accuracy benchmarking by maturity (launch vs. mature vs. end-of-life)."
    - name: "accuracy_status"
      expr: accuracy_status
      comment: "Status of the accuracy record — enables filtering to active or approved measurements."
    - name: "new_product_flag"
      expr: new_product_flag
      comment: "Indicates whether the SKU is a new product — new products typically have lower forecast accuracy."
    - name: "promotional_period_flag"
      expr: promotional_period_flag
      comment: "Indicates a promotional period — promotional periods distort baseline accuracy and should be segmented."
    - name: "demand_sensing_applied_flag"
      expr: demand_sensing_applied_flag
      comment: "Whether demand sensing was applied — enables comparison of sensing vs. non-sensing accuracy."
    - name: "planning_period_start_date"
      expr: DATE_TRUNC('month', planning_period_start_date)
      comment: "Planning period start month — enables time-series trending of forecast accuracy."
  measures:
    - name: "avg_mape"
      expr: AVG(CAST(mape AS DOUBLE))
      comment: "Average Mean Absolute Percentage Error across all forecast records — primary KPI for forecast accuracy; lower is better. Executives use this to assess planning model health."
    - name: "avg_wmape"
      expr: AVG(CAST(wmape AS DOUBLE))
      comment: "Average Weighted MAPE — volume-weighted accuracy metric that reduces distortion from low-volume SKUs. More reliable than simple MAPE for portfolio-level steering."
    - name: "avg_bias_percent"
      expr: AVG(CAST(bias_percent AS DOUBLE))
      comment: "Average forecast bias percentage — positive bias means over-forecasting (excess inventory risk); negative means under-forecasting (stockout risk). Critical for S&OP balance."
    - name: "avg_absolute_percent_error"
      expr: AVG(CAST(absolute_percent_error AS DOUBLE))
      comment: "Average absolute percentage error — unsigned error metric used to benchmark model performance without bias cancellation."
    - name: "avg_sensing_uplift_percent"
      expr: AVG(CAST(sensing_uplift_percent AS DOUBLE))
      comment: "Average demand sensing uplift percentage — measures the incremental accuracy gain from demand sensing signals. Justifies investment in sensing technology."
    - name: "avg_sensing_confidence_score"
      expr: AVG(CAST(sensing_confidence_score AS DOUBLE))
      comment: "Average confidence score of demand sensing signals — low confidence indicates unreliable sensing inputs that may degrade accuracy."
    - name: "total_forecast_quantity"
      expr: SUM(CAST(forecast_quantity AS DOUBLE))
      comment: "Total forecasted volume — baseline volume measure for weighting accuracy metrics and assessing planning scale."
    - name: "total_actual_quantity"
      expr: SUM(CAST(actual_quantity AS DOUBLE))
      comment: "Total actual demand volume — used alongside forecast quantity to compute realized error at aggregate level."
    - name: "total_forecast_error"
      expr: SUM(CAST(forecast_error AS DOUBLE))
      comment: "Sum of forecast errors (actual minus forecast) — aggregate error volume; persistent positive or negative totals signal systemic bias."
    - name: "forecast_record_count"
      expr: COUNT(1)
      comment: "Number of forecast accuracy records — denominator for coverage analysis and statistical significance assessment."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`supply_demand_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Demand planning KPIs covering forecast volumes, accuracy, bias, and plan quality — used by S&OP leaders to evaluate demand signal reliability and commercial overlay impact."
  source: "`vibe_consumer_goods_v1`.`supply`.`demand_plan`"
  dimensions:
    - name: "sku_id"
      expr: sku_id
      comment: "Product SKU — enables demand analysis by individual product."
    - name: "trade_account_id"
      expr: trade_account_id
      comment: "Trade account (customer) — enables demand analysis by customer/retailer."
    - name: "sop_cycle_id"
      expr: sop_cycle_id
      comment: "S&OP cycle — enables comparison of demand plans across planning cycles."
    - name: "version_type"
      expr: version_type
      comment: "Version type (statistical, consensus, final) — enables comparison of plan stages."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the demand plan — enables filtering to approved vs. draft plans."
    - name: "demand_pattern_type"
      expr: demand_pattern_type
      comment: "Demand pattern classification (seasonal, trend, flat) — enables segmentation by demand behavior."
    - name: "lifecycle_stage"
      expr: lifecycle_stage
      comment: "Product lifecycle stage at time of planning — enables accuracy benchmarking by maturity."
    - name: "risk_category"
      expr: risk_category
      comment: "Risk category assigned to the demand plan — enables prioritization of high-risk plans for review."
    - name: "is_consensus_version"
      expr: is_consensus_version
      comment: "Whether this is the consensus version — enables isolation of the agreed-upon plan for reporting."
    - name: "planning_period_start_date"
      expr: DATE_TRUNC('month', planning_period_start_date)
      comment: "Planning period start month — enables time-series trending of demand volumes."
    - name: "planning_bucket"
      expr: planning_bucket
      comment: "Planning time bucket (weekly, monthly) — enables analysis at different planning granularities."
  measures:
    - name: "total_statistical_baseline_quantity"
      expr: SUM(CAST(statistical_baseline_quantity AS DOUBLE))
      comment: "Total statistical baseline demand volume — the model-generated baseline before any overlays. Benchmark for measuring human adjustment impact."
    - name: "total_consensus_quantity"
      expr: SUM(CAST(consensus_quantity AS DOUBLE))
      comment: "Total consensus demand volume — the agreed-upon demand plan after all reviews. Primary volume KPI for supply planning input."
    - name: "total_commercial_overlay_quantity"
      expr: SUM(CAST(commercial_overlay_quantity AS DOUBLE))
      comment: "Total commercial overlay volume — measures the magnitude of human adjustments to the statistical baseline. Large overlays signal model distrust."
    - name: "total_promotional_overlay_quantity"
      expr: SUM(CAST(promotional_overlay_quantity AS DOUBLE))
      comment: "Total promotional overlay volume — incremental demand attributed to promotions. Used to assess promotional lift planning accuracy."
    - name: "total_npd_launch_volume_quantity"
      expr: SUM(CAST(npd_launch_volume_quantity AS DOUBLE))
      comment: "Total new product launch volume planned — critical for supply readiness and capacity reservation for innovation pipeline."
    - name: "avg_forecast_accuracy_percentage"
      expr: AVG(CAST(forecast_accuracy_percentage AS DOUBLE))
      comment: "Average forecast accuracy percentage across demand plans — S&OP scorecard KPI; drives model improvement investment decisions."
    - name: "avg_forecast_bias_percentage"
      expr: AVG(CAST(forecast_bias_percentage AS DOUBLE))
      comment: "Average forecast bias percentage — persistent positive bias signals over-planning (inventory risk); negative signals under-planning (service risk)."
    - name: "total_variance_to_baseline_quantity"
      expr: SUM(CAST(variance_to_baseline_quantity AS DOUBLE))
      comment: "Total variance between consensus and statistical baseline — measures the aggregate human adjustment to the model. Executives use this to assess planner intervention scale."
    - name: "demand_plan_count"
      expr: COUNT(1)
      comment: "Number of demand plan records — used to assess planning coverage and version proliferation."
    - name: "risk_flagged_plan_count"
      expr: COUNT(CASE WHEN risk_flag = TRUE THEN 1 END)
      comment: "Number of demand plans flagged as high-risk — drives S&OP escalation and contingency planning decisions."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`supply_safety_stock`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Safety stock KPIs covering stock levels, service targets, and calculation quality — used by supply planners and operations leaders to ensure adequate buffer stock while minimizing excess inventory costs."
  source: "`vibe_consumer_goods_v1`.`supply`.`safety_stock`"
  dimensions:
    - name: "sku_id"
      expr: sku_id
      comment: "Product SKU — enables safety stock analysis by individual product."
    - name: "abc_classification"
      expr: abc_classification
      comment: "ABC classification of the SKU — A-class items require tighter safety stock management."
    - name: "xyz_classification"
      expr: xyz_classification
      comment: "XYZ demand variability classification — X=stable, Z=highly variable; drives safety stock method selection."
    - name: "calculation_method"
      expr: calculation_method
      comment: "Safety stock calculation method — enables comparison of method effectiveness."
    - name: "demand_classification"
      expr: demand_classification
      comment: "Demand classification (regular, intermittent, lumpy) — drives appropriate safety stock policy."
    - name: "review_status"
      expr: review_status
      comment: "Review status of the safety stock record — enables filtering to approved vs. pending records."
    - name: "is_active"
      expr: is_active
      comment: "Whether the safety stock record is currently active — filters to live planning parameters."
    - name: "effective_date"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Effective date month — enables trending of safety stock levels over time."
  measures:
    - name: "total_approved_safety_stock_units"
      expr: SUM(CAST(approved_safety_stock_units AS DOUBLE))
      comment: "Total approved safety stock units across all SKU-location combinations — primary inventory buffer KPI; directly tied to working capital and service level commitments."
    - name: "total_calculated_safety_stock_units"
      expr: SUM(CAST(calculated_safety_stock_units AS DOUBLE))
      comment: "Total model-calculated safety stock units — baseline before human override. Comparison with approved units reveals override magnitude."
    - name: "avg_target_service_level_percent"
      expr: AVG(CAST(target_service_level_percent AS DOUBLE))
      comment: "Average target service level percentage — measures the ambition of service commitments embedded in safety stock policy."
    - name: "avg_days_of_supply_target"
      expr: AVG(CAST(days_of_supply_target AS DOUBLE))
      comment: "Average days of supply target — operational KPI for inventory coverage; executives use this to balance service vs. working capital."
    - name: "avg_demand_variability_coefficient"
      expr: AVG(CAST(demand_variability_coefficient AS DOUBLE))
      comment: "Average demand variability coefficient — higher values indicate more volatile demand requiring larger safety buffers."
    - name: "avg_lead_time_variability_days"
      expr: AVG(CAST(lead_time_variability_days AS DOUBLE))
      comment: "Average lead time variability in days — supply-side uncertainty driver for safety stock; high variability signals supplier reliability issues."
    - name: "avg_supply_risk_score"
      expr: AVG(CAST(supply_risk_score AS DOUBLE))
      comment: "Average supply risk score — composite risk indicator; high scores trigger safety stock increases and contingency planning."
    - name: "total_holding_cost"
      expr: SUM(CAST(holding_cost_per_unit AS DOUBLE))
      comment: "Total holding cost per unit across all safety stock records — financial impact of buffer inventory; used to optimize safety stock levels against service targets."
    - name: "safety_stock_override_count"
      expr: COUNT(CASE WHEN override_reason_code IS NOT NULL THEN 1 END)
      comment: "Number of safety stock records with manual overrides — high override rates signal model distrust or exceptional business conditions requiring investigation."
    - name: "safety_stock_record_count"
      expr: COUNT(1)
      comment: "Total number of active safety stock records — measures planning coverage across SKU-location combinations."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`supply_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supply plan KPIs covering planned production, replenishment, inventory projections, and supply risk — the master supply planning scorecard used by S&OP and operations leadership."
  source: "`vibe_consumer_goods_v1`.`supply`.`plan`"
  dimensions:
    - name: "sku_id"
      expr: sku_id
      comment: "Product SKU — enables supply plan analysis by individual product."
    - name: "trade_account_id"
      expr: trade_account_id
      comment: "Trade account — enables supply plan analysis by customer commitment."
    - name: "plan_type"
      expr: plan_type
      comment: "Plan type (production, replenishment, distribution) — enables segmentation by supply action type."
    - name: "plan_status"
      expr: plan_status
      comment: "Plan status (draft, approved, executed) — enables filtering to actionable plans."
    - name: "planning_bucket"
      expr: planning_bucket
      comment: "Planning time bucket — enables analysis at weekly or monthly granularity."
    - name: "planning_group"
      expr: planning_group
      comment: "Planning group — enables segmentation by organizational planning unit."
    - name: "supply_source"
      expr: supply_source
      comment: "Source of supply (make, buy, transfer) — enables analysis by supply strategy."
    - name: "capacity_constraint_flag"
      expr: capacity_constraint_flag
      comment: "Whether the plan is capacity-constrained — identifies plans at risk of non-execution."
    - name: "material_constraint_flag"
      expr: material_constraint_flag
      comment: "Whether the plan has material constraints — identifies supply risk from raw material shortages."
    - name: "planned_order_release_date"
      expr: DATE_TRUNC('month', planned_order_release_date)
      comment: "Planned order release month — enables time-series analysis of supply plan volumes."
  measures:
    - name: "total_planned_production_quantity"
      expr: SUM(CAST(planned_production_quantity AS DOUBLE))
      comment: "Total planned production volume — primary manufacturing output KPI; used to assess capacity utilization and production scheduling."
    - name: "total_planned_replenishment_quantity"
      expr: SUM(CAST(planned_replenishment_quantity AS DOUBLE))
      comment: "Total planned replenishment volume — distribution network replenishment KPI; drives logistics capacity planning."
    - name: "total_demand_forecast_quantity"
      expr: SUM(CAST(demand_forecast_quantity AS DOUBLE))
      comment: "Total demand forecast volume embedded in the supply plan — baseline for measuring supply-demand balance."
    - name: "total_atp_quantity"
      expr: SUM(CAST(atp_quantity AS DOUBLE))
      comment: "Total Available-to-Promise quantity — customer commitment capacity; directly tied to order fulfillment and revenue realization."
    - name: "total_ctp_quantity"
      expr: SUM(CAST(ctp_quantity AS DOUBLE))
      comment: "Total Capable-to-Promise quantity — production-constrained commitment capacity; used for customer promise accuracy."
    - name: "total_projected_inventory_balance"
      expr: SUM(CAST(projected_inventory_balance AS DOUBLE))
      comment: "Total projected inventory balance — forward-looking inventory position; negative values signal stockout risk requiring immediate action."
    - name: "total_safety_stock_quantity"
      expr: SUM(CAST(safety_stock_quantity AS DOUBLE))
      comment: "Total safety stock quantity in the supply plan — buffer inventory commitment; used to assess working capital tied to risk mitigation."
    - name: "avg_supply_risk_score"
      expr: AVG(CAST(supply_risk_score AS DOUBLE))
      comment: "Average supply risk score across plan records — composite risk indicator; high scores trigger executive escalation and contingency activation."
    - name: "constrained_plan_count"
      expr: COUNT(CASE WHEN capacity_constraint_flag = TRUE OR material_constraint_flag = TRUE OR transportation_constraint_flag = TRUE THEN 1 END)
      comment: "Number of supply plan records with any active constraint — measures the breadth of supply constraints requiring resolution."
    - name: "supply_plan_record_count"
      expr: COUNT(1)
      comment: "Total supply plan records — measures planning coverage and version scale."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`supply_atp_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Available-to-Promise KPIs covering ATP/CTP quantities, backorders, and allocation status — used by order management and supply chain leadership to manage customer commitments and identify fulfillment risk."
  source: "`vibe_consumer_goods_v1`.`supply`.`atp_record`"
  dimensions:
    - name: "sku_id"
      expr: sku_id
      comment: "Product SKU — enables ATP analysis by individual product."
    - name: "atp_status"
      expr: atp_status
      comment: "ATP record status — enables filtering to confirmed, pending, or backorder records."
    - name: "atp_calculation_method"
      expr: atp_calculation_method
      comment: "ATP calculation method — enables comparison of method effectiveness."
    - name: "customer_priority_tier"
      expr: customer_priority_tier
      comment: "Customer priority tier — enables ATP allocation analysis by customer importance."
    - name: "product_allocation_group"
      expr: product_allocation_group
      comment: "Product allocation group — enables analysis of allocation policy effectiveness."
    - name: "planning_version"
      expr: planning_version
      comment: "Planning version — enables comparison of ATP across plan versions."
    - name: "atp_date"
      expr: DATE_TRUNC('week', atp_date)
      comment: "ATP date week — enables time-series analysis of availability commitments."
  measures:
    - name: "total_atp_quantity"
      expr: SUM(CAST(atp_quantity AS DOUBLE))
      comment: "Total Available-to-Promise quantity — primary customer commitment KPI; directly tied to order fulfillment capacity and revenue realization."
    - name: "total_ctp_quantity"
      expr: SUM(CAST(ctp_quantity AS DOUBLE))
      comment: "Total Capable-to-Promise quantity — production-constrained availability; used for customer promise accuracy in make-to-order scenarios."
    - name: "total_cumulative_atp_quantity"
      expr: SUM(CAST(cumulative_atp_quantity AS DOUBLE))
      comment: "Total cumulative ATP quantity — rolling availability position; used to assess sustained fulfillment capacity over the planning horizon."
    - name: "total_backorder_quantity"
      expr: SUM(CAST(backorder_quantity AS DOUBLE))
      comment: "Total backorder quantity — unfulfilled demand volume; high backorders signal supply shortfalls and customer service risk."
    - name: "total_allocated_quantity"
      expr: SUM(CAST(allocated_quantity AS DOUBLE))
      comment: "Total allocated quantity — committed supply already assigned to demand; measures allocation utilization."
    - name: "total_on_hand_inventory"
      expr: SUM(CAST(on_hand_inventory AS DOUBLE))
      comment: "Total on-hand inventory in ATP records — current physical stock position; baseline for ATP calculation."
    - name: "total_intransit_quantity"
      expr: SUM(CAST(intransit_quantity AS DOUBLE))
      comment: "Total in-transit quantity — supply pipeline volume; critical for short-horizon ATP accuracy."
    - name: "total_safety_stock_quantity"
      expr: SUM(CAST(safety_stock_quantity AS DOUBLE))
      comment: "Total safety stock quantity reserved in ATP — buffer inventory not available for commitment; measures the cost of service level protection."
    - name: "total_forecast_consumption_quantity"
      expr: SUM(CAST(forecast_consumption_quantity AS DOUBLE))
      comment: "Total forecast consumption quantity — demand already consumed against the forecast; measures forecast burn-down rate."
    - name: "atp_record_count"
      expr: COUNT(1)
      comment: "Total ATP records — measures ATP calculation coverage across SKU-location-date combinations."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`supply_replenishment_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Replenishment order KPIs covering order quantities, fulfillment rates, and lead time performance — used by distribution and supply chain leaders to manage inventory replenishment efficiency and supplier performance."
  source: "`vibe_consumer_goods_v1`.`supply`.`supply_replenishment_order`"
  dimensions:
    - name: "sku_id"
      expr: sku_id
      comment: "Product SKU — enables replenishment analysis by individual product."
    - name: "primary_supply_network_node_id"
      expr: primary_supply_network_node_id
      comment: "Source supply network node — enables analysis by replenishment origin."
    - name: "order_type"
      expr: order_type
      comment: "Replenishment order type — enables segmentation by replenishment strategy."
    - name: "order_status"
      expr: order_status
      comment: "Order status (planned, confirmed, shipped, received) — enables pipeline analysis."
    - name: "transportation_mode"
      expr: transportation_mode
      comment: "Transportation mode — enables cost and lead time analysis by mode."
    - name: "safety_stock_trigger_flag"
      expr: safety_stock_trigger_flag
      comment: "Whether the order was triggered by safety stock breach — measures reactive vs. planned replenishment ratio."
    - name: "planned_ship_date"
      expr: DATE_TRUNC('week', planned_ship_date)
      comment: "Planned ship date week — enables time-series analysis of replenishment flow."
  measures:
    - name: "total_requested_quantity"
      expr: SUM(CAST(requested_quantity AS DOUBLE))
      comment: "Total requested replenishment quantity — gross demand on the replenishment network; baseline for fill rate calculation."
    - name: "total_confirmed_quantity"
      expr: SUM(CAST(confirmed_quantity AS DOUBLE))
      comment: "Total confirmed replenishment quantity — supply committed by the source; gap vs. requested quantity signals supply constraints."
    - name: "total_shipped_quantity"
      expr: SUM(CAST(shipped_quantity AS DOUBLE))
      comment: "Total shipped replenishment quantity — actual supply dispatched; used to measure execution vs. plan."
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total received replenishment quantity — supply actually received at destination; primary fulfillment KPI."
    - name: "total_order_cost_amount"
      expr: SUM(CAST(order_cost_amount AS DOUBLE))
      comment: "Total replenishment order cost — financial KPI for distribution cost management; used to optimize replenishment frequency and lot sizes."
    - name: "total_available_to_promise_quantity"
      expr: SUM(CAST(available_to_promise_quantity AS DOUBLE))
      comment: "Total ATP quantity from replenishment orders — forward supply commitment; used to update customer-facing availability."
    - name: "total_forecast_demand_quantity"
      expr: SUM(CAST(forecast_demand_quantity AS DOUBLE))
      comment: "Total forecast demand quantity driving replenishment — measures the demand signal quality feeding the DRP engine."
    - name: "replenishment_order_count"
      expr: COUNT(1)
      comment: "Total replenishment orders — measures replenishment activity volume and order frequency."
    - name: "safety_stock_triggered_order_count"
      expr: COUNT(CASE WHEN safety_stock_trigger_flag = TRUE THEN 1 END)
      comment: "Number of orders triggered by safety stock breach — high counts signal chronic supply shortfalls or under-sized safety stock policies."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`supply_planning_exception`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Planning exception KPIs covering exception volumes, severity, resolution rates, and business impact — used by supply planners and S&OP leaders to prioritize exception resolution and measure planning process health."
  source: "`vibe_consumer_goods_v1`.`supply`.`planning_exception`"
  dimensions:
    - name: "sku_id"
      expr: sku_id
      comment: "Product SKU — enables exception analysis by individual product."
    - name: "exception_type"
      expr: exception_type
      comment: "Exception type (stockout risk, excess inventory, lead time breach) — primary segmentation for exception management."
    - name: "exception_severity"
      expr: exception_severity
      comment: "Exception severity level — enables prioritization of critical exceptions requiring immediate action."
    - name: "exception_status"
      expr: exception_status
      comment: "Exception status (open, in-progress, resolved) — enables pipeline management of exception resolution."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category — enables systemic analysis of exception drivers for process improvement."
    - name: "constraint_type"
      expr: constraint_type
      comment: "Constraint type driving the exception — enables targeted resolution by constraint category."
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether the exception has been escalated — measures the volume of issues requiring leadership attention."
    - name: "exception_date"
      expr: DATE_TRUNC('week', exception_date)
      comment: "Exception date week — enables time-series trending of exception volumes."
  measures:
    - name: "total_business_impact_amount"
      expr: SUM(CAST(business_impact_amount AS DOUBLE))
      comment: "Total financial business impact of planning exceptions — primary financial KPI for exception management; executives use this to prioritize resolution investment."
    - name: "total_exception_quantity"
      expr: SUM(CAST(exception_quantity AS DOUBLE))
      comment: "Total exception volume in units — measures the scale of supply-demand imbalances requiring resolution."
    - name: "total_gap_quantity"
      expr: SUM(CAST(gap_quantity AS DOUBLE))
      comment: "Total supply-demand gap quantity — aggregate shortfall or excess volume; directly tied to service level and inventory cost risk."
    - name: "avg_resolution_duration_hours"
      expr: AVG(CAST(resolution_duration_hours AS DOUBLE))
      comment: "Average exception resolution time in hours — operational efficiency KPI; long resolution times signal process bottlenecks or resource constraints."
    - name: "open_exception_count"
      expr: COUNT(CASE WHEN exception_status != 'RESOLVED' THEN 1 END)
      comment: "Number of unresolved planning exceptions — real-time workload KPI for supply planning teams; high counts signal planning process stress."
    - name: "escalated_exception_count"
      expr: COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END)
      comment: "Number of escalated exceptions — measures the volume of issues requiring leadership intervention; high escalation rates signal systemic planning failures."
    - name: "auto_resolved_exception_count"
      expr: COUNT(CASE WHEN auto_resolution_flag = TRUE THEN 1 END)
      comment: "Number of automatically resolved exceptions — measures planning automation effectiveness; higher auto-resolution reduces planner workload."
    - name: "total_exception_count"
      expr: COUNT(1)
      comment: "Total planning exceptions — baseline volume KPI for exception management; trending upward signals deteriorating planning health."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`supply_risk_register`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supply chain risk KPIs covering risk scores, financial exposure, mitigation status, and escalation rates — used by supply chain leadership and risk management to prioritize risk mitigation investments."
  source: "`vibe_consumer_goods_v1`.`supply`.`risk_register`"
  dimensions:
    - name: "risk_category"
      expr: risk_category
      comment: "Risk category (supply, demand, logistics, regulatory) — primary segmentation for risk management."
    - name: "risk_subcategory"
      expr: risk_subcategory
      comment: "Risk subcategory — enables granular analysis within risk categories."
    - name: "risk_status"
      expr: risk_status
      comment: "Risk status (open, mitigated, closed) — enables pipeline management of risk resolution."
    - name: "impact_severity"
      expr: impact_severity
      comment: "Impact severity level — enables prioritization of high-impact risks."
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether the risk has been escalated — measures the volume of risks requiring executive attention."
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region of the risk — enables geopolitical and regional risk analysis."
    - name: "identified_date"
      expr: DATE_TRUNC('month', identified_date)
      comment: "Risk identification month — enables trending of risk emergence over time."
  measures:
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average composite risk score — primary risk portfolio KPI; executives use this to assess overall supply chain vulnerability."
    - name: "avg_impact_score"
      expr: AVG(CAST(impact_score AS DOUBLE))
      comment: "Average impact score — measures the potential severity of supply disruptions; high scores trigger contingency planning."
    - name: "avg_probability_score"
      expr: AVG(CAST(probability_score AS DOUBLE))
      comment: "Average probability score — measures the likelihood of risk materialization; combined with impact score for risk prioritization."
    - name: "total_contingency_cost_estimate"
      expr: SUM(CAST(contingency_cost_estimate AS DOUBLE))
      comment: "Total contingency cost estimate — financial exposure from supply chain risks; used to justify risk mitigation investment and insurance decisions."
    - name: "total_contingency_stock_quantity"
      expr: SUM(CAST(contingency_stock_quantity AS DOUBLE))
      comment: "Total contingency stock quantity — buffer inventory held against identified risks; measures the working capital cost of risk mitigation."
    - name: "open_risk_count"
      expr: COUNT(CASE WHEN risk_status != 'CLOSED' THEN 1 END)
      comment: "Number of open supply chain risks — real-time risk exposure count; trending upward signals deteriorating supply chain resilience."
    - name: "escalated_risk_count"
      expr: COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END)
      comment: "Number of escalated risks — measures the volume of risks requiring executive intervention; high counts signal systemic supply chain fragility."
    - name: "total_risk_count"
      expr: COUNT(1)
      comment: "Total risk register entries — baseline risk portfolio size; used to assess risk management coverage and process maturity."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`supply_sop_cycle`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "S&OP cycle KPIs covering demand/supply consensus volumes, gaps, and process milestone adherence — used by S&OP leadership to evaluate planning cycle effectiveness and executive decision quality."
  source: "`vibe_consumer_goods_v1`.`supply`.`sop_cycle`"
  dimensions:
    - name: "cycle_type"
      expr: cycle_type
      comment: "S&OP cycle type — enables comparison across different planning cycle types."
    - name: "cycle_phase"
      expr: cycle_phase
      comment: "Current phase of the S&OP cycle (demand review, supply review, pre-S&OP, executive) — enables phase-level analysis."
    - name: "phase_status"
      expr: phase_status
      comment: "Status of the current cycle phase — enables identification of delayed or at-risk cycles."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year — enables year-over-year comparison of S&OP performance."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period — enables period-level S&OP performance analysis."
    - name: "demand_consensus_achieved_flag"
      expr: demand_consensus_achieved_flag
      comment: "Whether demand consensus was achieved — measures S&OP process effectiveness."
    - name: "supply_consensus_achieved_flag"
      expr: supply_consensus_achieved_flag
      comment: "Whether supply consensus was achieved — measures supply planning alignment."
    - name: "executive_approval_flag"
      expr: executive_approval_flag
      comment: "Whether executive approval was obtained — measures governance compliance of the S&OP process."
    - name: "cycle_locked_flag"
      expr: cycle_locked_flag
      comment: "Whether the cycle is locked — locked cycles are frozen for execution; unlocked cycles are still in planning."
    - name: "planning_month"
      expr: DATE_TRUNC('month', planning_month)
      comment: "Planning month — enables time-series analysis of S&OP cycle performance."
  measures:
    - name: "total_baseline_demand_volume"
      expr: SUM(CAST(baseline_demand_volume AS DOUBLE))
      comment: "Total baseline demand volume across S&OP cycles — statistical demand baseline before consensus adjustments; benchmark for measuring overlay impact."
    - name: "total_consensus_demand_volume"
      expr: SUM(CAST(consensus_demand_volume AS DOUBLE))
      comment: "Total consensus demand volume — the agreed-upon demand plan output from S&OP; primary volume input to supply planning."
    - name: "total_constrained_supply_volume"
      expr: SUM(CAST(constrained_supply_volume AS DOUBLE))
      comment: "Total constrained supply volume — supply capacity after applying all constraints; gap vs. consensus demand drives escalation decisions."
    - name: "total_supply_gap_volume"
      expr: SUM(CAST(supply_gap_volume AS DOUBLE))
      comment: "Total supply gap volume — the unmet demand after supply constraints; the most critical S&OP KPI for executive decision-making on capacity investment."
    - name: "sop_cycle_count"
      expr: COUNT(1)
      comment: "Total S&OP cycles — measures planning cadence and process coverage."
    - name: "consensus_achieved_cycle_count"
      expr: COUNT(CASE WHEN demand_consensus_achieved_flag = TRUE AND supply_consensus_achieved_flag = TRUE THEN 1 END)
      comment: "Number of cycles where both demand and supply consensus were achieved — measures S&OP process effectiveness; low counts signal alignment failures requiring process intervention."
    - name: "executive_approved_cycle_count"
      expr: COUNT(CASE WHEN executive_approval_flag = TRUE THEN 1 END)
      comment: "Number of cycles with executive approval — measures governance compliance; unapproved cycles signal process breakdowns."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`supply_inventory_policy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory policy KPIs covering service level targets, safety stock parameters, and policy compliance — used by supply chain and finance leadership to govern inventory investment and service commitments."
  source: "`vibe_consumer_goods_v1`.`supply`.`inventory_policy`"
  dimensions:
    - name: "sku_id"
      expr: sku_id
      comment: "Product SKU — enables policy analysis by individual product."
    - name: "replenishment_method"
      expr: replenishment_method
      comment: "Replenishment method (min-max, reorder point, kanban) — enables comparison of policy effectiveness by method."
    - name: "approval_status"
      expr: approval_status
      comment: "Policy approval status — enables filtering to approved vs. draft policies."
    - name: "policy_status"
      expr: policy_status
      comment: "Policy status (active, expired, pending) — enables filtering to live policies."
    - name: "safety_stock_calculation_method"
      expr: safety_stock_calculation_method
      comment: "Safety stock calculation method — enables comparison of method effectiveness."
    - name: "retailer_mandated_target_flag"
      expr: retailer_mandated_target_flag
      comment: "Whether the target is retailer-mandated — retailer-mandated targets carry penalty risk and require higher compliance priority."
    - name: "effective_start_date"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Policy effective start month — enables analysis of policy evolution over time."
  measures:
    - name: "avg_service_level_target_percent"
      expr: AVG(CAST(service_level_target_percent AS DOUBLE))
      comment: "Average service level target percentage — measures the ambition of customer service commitments embedded in inventory policy."
    - name: "avg_fill_rate_target_percent"
      expr: AVG(CAST(fill_rate_target_percent AS DOUBLE))
      comment: "Average fill rate target percentage — order fill rate commitment; directly tied to customer satisfaction and retailer compliance."
    - name: "avg_otif_composite_target_percent"
      expr: AVG(CAST(otif_composite_target_percent AS DOUBLE))
      comment: "Average OTIF composite target percentage — on-time-in-full commitment; the primary retailer scorecard metric with direct financial penalty implications."
    - name: "avg_customer_otif_commitment_percent"
      expr: AVG(CAST(customer_otif_commitment_percent AS DOUBLE))
      comment: "Average customer OTIF commitment percentage — customer-specific OTIF targets; used to assess commitment portfolio risk."
    - name: "avg_safety_stock_target_units"
      expr: AVG(CAST(safety_stock_target_units AS DOUBLE))
      comment: "Average safety stock target units — measures the average buffer inventory commitment per SKU-location policy."
    - name: "avg_safety_stock_days_of_supply"
      expr: AVG(CAST(safety_stock_days_of_supply AS DOUBLE))
      comment: "Average safety stock days of supply — normalized buffer metric; enables comparison across SKUs with different velocity profiles."
    - name: "avg_demand_variability_coefficient"
      expr: AVG(CAST(demand_variability_coefficient AS DOUBLE))
      comment: "Average demand variability coefficient across policies — measures the demand uncertainty driving safety stock requirements."
    - name: "penalty_clause_policy_count"
      expr: COUNT(CASE WHEN penalty_clause_indicator = TRUE THEN 1 END)
      comment: "Number of policies with penalty clauses — measures financial exposure from service level failures; high counts signal significant contractual risk."
    - name: "inventory_policy_count"
      expr: COUNT(1)
      comment: "Total inventory policy records — measures policy coverage across SKU-location combinations."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`supply_constraint`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supply constraint KPIs covering financial impact, severity, resolution rates, and constraint types — used by operations and supply chain leadership to prioritize constraint resolution and capacity investment."
  source: "`vibe_consumer_goods_v1`.`supply`.`constraint`"
  dimensions:
    - name: "sku_id"
      expr: sku_id
      comment: "Product SKU — enables constraint analysis by individual product."
    - name: "constraint_type"
      expr: constraint_type
      comment: "Constraint type (capacity, material, labor, regulatory) — primary segmentation for constraint management."
    - name: "constraint_status"
      expr: constraint_status
      comment: "Constraint status (open, mitigated, resolved) — enables pipeline management of constraint resolution."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level — enables prioritization of critical constraints."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category — enables systemic analysis of constraint drivers."
    - name: "escalation_level"
      expr: escalation_level
      comment: "Escalation level — measures the organizational level at which the constraint is being managed."
    - name: "customer_impact_flag"
      expr: customer_impact_flag
      comment: "Whether the constraint has customer impact — customer-impacting constraints require highest priority resolution."
    - name: "start_date"
      expr: DATE_TRUNC('month', start_date)
      comment: "Constraint start month — enables time-series analysis of constraint emergence."
  measures:
    - name: "total_financial_impact_amount"
      expr: SUM(CAST(financial_impact_amount AS DOUBLE))
      comment: "Total financial impact of supply constraints — primary financial KPI for constraint management; executives use this to prioritize resolution investment and capacity decisions."
    - name: "total_quantity_shortfall"
      expr: SUM(CAST(quantity_shortfall AS DOUBLE))
      comment: "Total quantity shortfall from constraints — aggregate supply gap volume; directly tied to service level risk and lost revenue."
    - name: "total_quantity_required"
      expr: SUM(CAST(quantity_required AS DOUBLE))
      comment: "Total quantity required — gross demand on constrained resources; baseline for measuring constraint severity."
    - name: "total_quantity_available"
      expr: SUM(CAST(quantity_available AS DOUBLE))
      comment: "Total quantity available despite constraints — actual supply capacity; gap vs. required quantity drives escalation."
    - name: "avg_mitigation_effectiveness_score"
      expr: AVG(CAST(mitigation_effectiveness_score AS DOUBLE))
      comment: "Average mitigation effectiveness score — measures how well mitigation actions are resolving constraints; low scores signal ineffective responses."
    - name: "customer_impacting_constraint_count"
      expr: COUNT(CASE WHEN customer_impact_flag = TRUE THEN 1 END)
      comment: "Number of constraints with direct customer impact — highest-priority KPI for service level protection; each customer-impacting constraint is a potential revenue and relationship risk."
    - name: "open_constraint_count"
      expr: COUNT(CASE WHEN constraint_status != 'RESOLVED' THEN 1 END)
      comment: "Number of open supply constraints — real-time constraint backlog; trending upward signals deteriorating supply chain capacity."
    - name: "total_constraint_count"
      expr: COUNT(1)
      comment: "Total constraint records — baseline volume KPI for constraint management process coverage."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`supply_drp_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Distribution Requirements Planning run KPIs covering plan quality, cost performance, and execution efficiency — used by supply chain operations to evaluate DRP engine effectiveness and planning automation maturity."
  source: "`vibe_consumer_goods_v1`.`supply`.`drp_run`"
  dimensions:
    - name: "run_type"
      expr: run_type
      comment: "DRP run type (full, incremental, simulation) — enables comparison of run type performance."
    - name: "drp_run_status"
      expr: drp_run_status
      comment: "DRP run status (completed, failed, in-progress) — enables filtering to successful runs for analysis."
    - name: "is_automated"
      expr: is_automated
      comment: "Whether the run was automated — enables comparison of automated vs. manual run performance."
    - name: "compliance_check_passed"
      expr: compliance_check_passed
      comment: "Whether the compliance check passed — failed compliance checks indicate regulatory or policy violations in the plan."
    - name: "scenario_name"
      expr: scenario_name
      comment: "Scenario name — enables comparison of different planning scenarios."
    - name: "region_code"
      expr: region_code
      comment: "Region code — enables geographic analysis of DRP performance."
    - name: "data_snapshot_date"
      expr: DATE_TRUNC('month', data_snapshot_date)
      comment: "Data snapshot month — enables time-series analysis of DRP run performance."
  measures:
    - name: "total_planned_cost"
      expr: SUM(CAST(total_planned_cost AS DOUBLE))
      comment: "Total planned distribution cost across DRP runs — primary financial output of DRP; used to assess distribution cost efficiency and budget adherence."
    - name: "total_actual_cost"
      expr: SUM(CAST(total_actual_cost AS DOUBLE))
      comment: "Total actual distribution cost — realized cost vs. planned; variance drives cost management decisions."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score of DRP runs — composite plan quality indicator; high risk scores trigger manual review and scenario analysis."
    - name: "drp_run_count"
      expr: COUNT(1)
      comment: "Total DRP runs — measures planning cadence and automation activity."
    - name: "failed_compliance_run_count"
      expr: COUNT(CASE WHEN compliance_check_passed = FALSE THEN 1 END)
      comment: "Number of DRP runs that failed compliance checks — measures regulatory and policy adherence of automated planning; failures require manual intervention."
    - name: "automated_run_count"
      expr: COUNT(CASE WHEN is_automated = TRUE THEN 1 END)
      comment: "Number of automated DRP runs — measures planning automation adoption; higher automation reduces planner workload and improves planning frequency."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`supply_otif_target`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "OTIF target KPIs covering on-time, in-full, and composite service level commitments — used by customer service and supply chain leadership to manage retailer compliance and penalty risk."
  source: "`vibe_consumer_goods_v1`.`supply`.`otif_target`"
  dimensions:
    - name: "trade_account_id"
      expr: trade_account_id
      comment: "Trade account (retailer/customer) — enables OTIF target analysis by customer."
    - name: "channel_code"
      expr: channel_code
      comment: "Channel code — enables OTIF target analysis by sales channel."
    - name: "customer_segment_code"
      expr: customer_segment_code
      comment: "Customer segment — enables OTIF target analysis by customer tier."
    - name: "priority_tier"
      expr: priority_tier
      comment: "Priority tier — enables segmentation of OTIF targets by customer importance."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status — enables filtering to approved OTIF commitments."
    - name: "retailer_mandated_target_flag"
      expr: retailer_mandated_target_flag
      comment: "Whether the target is retailer-mandated — mandated targets carry penalty risk and require highest compliance priority."
    - name: "penalty_clause_flag"
      expr: penalty_clause_flag
      comment: "Whether a penalty clause exists — penalty-bearing targets require proactive monitoring and escalation."
    - name: "effective_start_date"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Target effective start month — enables analysis of OTIF commitment evolution over time."
  measures:
    - name: "avg_otif_composite_target_percent"
      expr: AVG(CAST(otif_composite_target_percent AS DOUBLE))
      comment: "Average OTIF composite target percentage — the primary retailer scorecard KPI; measures the average service level commitment across all customer agreements."
    - name: "avg_on_time_delivery_target_percent"
      expr: AVG(CAST(on_time_delivery_target_percent AS DOUBLE))
      comment: "Average on-time delivery target percentage — measures the timeliness commitment component of OTIF."
    - name: "avg_in_full_fill_rate_target_percent"
      expr: AVG(CAST(in_full_fill_rate_target_percent AS DOUBLE))
      comment: "Average in-full fill rate target percentage — measures the completeness commitment component of OTIF."
    - name: "avg_penalty_rate_percent"
      expr: AVG(CAST(penalty_rate_percent AS DOUBLE))
      comment: "Average penalty rate percentage — financial exposure per unit of OTIF shortfall; used to prioritize high-penalty customer accounts."
    - name: "avg_escalation_threshold_percent"
      expr: AVG(CAST(escalation_threshold_percent AS DOUBLE))
      comment: "Average escalation threshold percentage — the OTIF level below which escalation is triggered; measures the tightness of service level governance."
    - name: "penalty_bearing_target_count"
      expr: COUNT(CASE WHEN penalty_clause_flag = TRUE THEN 1 END)
      comment: "Number of OTIF targets with penalty clauses — measures the breadth of financial exposure from service level commitments."
    - name: "retailer_mandated_target_count"
      expr: COUNT(CASE WHEN retailer_mandated_target_flag = TRUE THEN 1 END)
      comment: "Number of retailer-mandated OTIF targets — measures the volume of externally imposed service commitments that cannot be negotiated."
    - name: "otif_target_count"
      expr: COUNT(1)
      comment: "Total OTIF target records — measures the breadth of service level commitments across the customer portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`supply_inventory_projection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory projection metrics used for stock positioning and service level planning"
  source: "`vibe_consumer_goods_v1`.`supply`.`inventory_projection`"
  dimensions:
    - name: "projection_date"
      expr: projection_date
      comment: "Date of the inventory projection"
    - name: "sku_id"
      expr: sku_id
      comment: "SKU identifier"
    - name: "projection_type"
      expr: projection_type
      comment: "Type of projection (e.g., baseline, scenario)"
  measures:
    - name: "total_projected_on_hand_quantity"
      expr: SUM(CAST(projected_on_hand_quantity AS DOUBLE))
      comment: "Projected on‑hand inventory at projection date"
    - name: "total_projected_demand_quantity"
      expr: SUM(CAST(projected_demand_quantity AS DOUBLE))
      comment: "Projected demand quantity for the period"
    - name: "total_projected_available_balance"
      expr: SUM(CAST(projected_available_balance AS DOUBLE))
      comment: "Projected available inventory balance after demand"
    - name: "average_days_of_supply"
      expr: AVG(CAST(days_of_supply AS DOUBLE))
      comment: "Average days of supply across projected records"
    - name: "projection_record_count"
      expr: COUNT(1)
      comment: "Number of inventory projection records"
$$;