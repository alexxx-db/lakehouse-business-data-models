-- Metric views for domain: supply | Business: Consumer_Goods | Version: 2 | Generated on: 2026-06-27 07:41:37

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`supply_atp_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Available-to-Promise (ATP) metrics tracking supply availability, committed quantities, backorders, and fulfillment health across planning buckets and SKUs. Core KPI layer for supply commitment and order promising decisions."
  source: "`vibe_consumer_goods_v1`.`supply`.`atp_record`"
  dimensions:
    - name: "planning_bucket"
      expr: planning_bucket
      comment: "Planning time bucket (e.g., week, month) used to group ATP records for horizon-based analysis."
    - name: "atp_status"
      expr: atp_status
      comment: "Current ATP status of the record (e.g., confirmed, partial, backorder) for filtering and segmentation."
    - name: "atp_record_status"
      expr: atp_record_status
      comment: "Lifecycle status of the ATP record for operational filtering."
    - name: "atp_calculation_method"
      expr: atp_calculation_method
      comment: "Method used to calculate ATP (e.g., discrete, cumulative) enabling methodology-based comparison."
    - name: "customer_priority_tier"
      expr: customer_priority_tier
      comment: "Customer priority tier to segment ATP allocation by customer importance."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the ATP record amount for multi-currency financial analysis."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for quantity fields enabling consistent volume analysis."
    - name: "atp_date"
      expr: DATE_TRUNC('month', atp_date)
      comment: "ATP date truncated to month for time-series trending of supply availability."
    - name: "available_date"
      expr: DATE_TRUNC('month', available_date)
      comment: "Date when supply becomes available, truncated to month for horizon planning."
    - name: "planning_version"
      expr: planning_version
      comment: "Planning version identifier to compare ATP across different plan iterations."
    - name: "product_allocation_group"
      expr: product_allocation_group
      comment: "Product allocation group for segmenting ATP by allocation policy."
  measures:
    - name: "total_atp_quantity"
      expr: SUM(CAST(atp_quantity AS DOUBLE))
      comment: "Total available-to-promise quantity across all records. Primary supply availability KPI used in order promising and supply review meetings."
    - name: "total_committed_quantity"
      expr: SUM(CAST(committed_quantity AS DOUBLE))
      comment: "Total quantity committed to customer orders. Measures supply obligation and drives fulfillment risk assessment."
    - name: "total_backorder_quantity"
      expr: SUM(CAST(backorder_quantity AS DOUBLE))
      comment: "Total quantity in backorder status. A rising backorder quantity signals supply shortfalls requiring executive intervention."
    - name: "total_on_hand_quantity"
      expr: SUM(CAST(on_hand_quantity AS DOUBLE))
      comment: "Total on-hand inventory quantity available for promising. Baseline inventory health KPI."
    - name: "total_available_quantity"
      expr: SUM(CAST(available_quantity AS DOUBLE))
      comment: "Total available quantity (on-hand plus planned receipts minus commitments). Core supply availability measure."
    - name: "total_safety_stock_quantity"
      expr: SUM(CAST(safety_stock_quantity AS DOUBLE))
      comment: "Total safety stock quantity held across all ATP records. Indicates buffer inventory investment level."
    - name: "total_intransit_quantity"
      expr: SUM(CAST(intransit_quantity AS DOUBLE))
      comment: "Total quantity currently in transit. Measures supply pipeline depth and inbound supply visibility."
    - name: "total_planned_receipt_quantity"
      expr: SUM(CAST(planned_receipt_quantity AS DOUBLE))
      comment: "Total planned inbound supply receipts. Forward-looking supply pipeline KPI for capacity and demand alignment."
    - name: "total_cumulative_atp_quantity"
      expr: SUM(CAST(cumulative_atp_quantity AS DOUBLE))
      comment: "Cumulative ATP quantity across the planning horizon. Used in rolling supply commitment analysis."
    - name: "total_forecast_consumption_quantity"
      expr: SUM(CAST(forecast_consumption_quantity AS DOUBLE))
      comment: "Total forecast quantity consumed against ATP. Measures how much of the demand forecast has been absorbed by supply commitments."
    - name: "avg_atp_quantity_per_record"
      expr: AVG(CAST(atp_quantity AS DOUBLE))
      comment: "Average ATP quantity per record. Useful for identifying outlier SKU/node combinations with abnormally low or high availability."
    - name: "total_ctp_quantity"
      expr: SUM(CAST(ctp_quantity AS DOUBLE))
      comment: "Total capable-to-promise (CTP) quantity. Measures supply that can be committed based on production capacity, beyond on-hand stock."
    - name: "total_supply_quantity"
      expr: SUM(CAST(supply_quantity AS DOUBLE))
      comment: "Total supply quantity across all sources (on-hand, in-transit, planned). Comprehensive supply position KPI."
    - name: "total_allocated_quantity"
      expr: SUM(CAST(allocated_quantity AS DOUBLE))
      comment: "Total quantity allocated to specific customers or channels. Measures allocation policy execution and fairness."
    - name: "atp_record_count"
      expr: COUNT(1)
      comment: "Count of ATP records. Used as a denominator for ratio calculations and to monitor planning coverage completeness."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`supply_consensus_demand`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Consensus demand metrics capturing the agreed demand signal from S&OP cycles, including statistical baselines, commercial overlays, and forecast accuracy. Drives supply planning alignment and demand review governance."
  source: "`vibe_consumer_goods_v1`.`supply`.`consensus_demand`"
  dimensions:
    - name: "planning_bucket"
      expr: planning_bucket
      comment: "Planning time bucket (week/month/quarter) for demand aggregation and horizon analysis."
    - name: "demand_category"
      expr: demand_category
      comment: "Category of demand (e.g., base, promotional, new product) for segmented demand analysis."
    - name: "consensus_demand_status"
      expr: consensus_demand_status
      comment: "Status of the consensus demand record (e.g., draft, approved, locked) for governance tracking."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the demand consensus for S&OP governance and escalation tracking."
    - name: "planning_horizon_type"
      expr: planning_horizon_type
      comment: "Horizon type (short/medium/long term) for demand planning segmentation."
    - name: "demand_driver_code"
      expr: demand_driver_code
      comment: "Code identifying the primary demand driver (e.g., seasonality, promotion, NPD) for root cause analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for financial demand value analysis."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for volume-based demand metrics."
    - name: "agreed_date"
      expr: DATE_TRUNC('month', agreed_date)
      comment: "Month of demand agreement for time-series tracking of consensus demand evolution."
    - name: "constrained_flag"
      expr: constrained_flag
      comment: "Indicates whether the demand is supply-constrained, enabling constrained vs. unconstrained demand comparison."
    - name: "promotion_flag"
      expr: promotion_flag
      comment: "Flags promotional demand for isolating base vs. incremental demand volumes."
    - name: "confidence_level"
      expr: confidence_level
      comment: "Confidence level of the demand forecast for risk-weighted planning."
    - name: "forecast_model_code"
      expr: forecast_model_code
      comment: "Statistical model used to generate the baseline forecast for model performance benchmarking."
  measures:
    - name: "total_consensus_quantity"
      expr: SUM(CAST(consensus_quantity AS DOUBLE))
      comment: "Total agreed consensus demand quantity. The primary S&OP demand signal used to drive supply planning and capacity decisions."
    - name: "total_statistical_forecast_quantity"
      expr: SUM(CAST(statistical_forecast_quantity AS DOUBLE))
      comment: "Total statistical baseline forecast quantity before commercial overlays. Benchmark for measuring human adjustment impact."
    - name: "total_commercial_overlay_quantity"
      expr: SUM(CAST(commercial_overlay_quantity AS DOUBLE))
      comment: "Total commercial overlay applied on top of statistical forecast. Measures the magnitude of human judgment adjustments."
    - name: "total_unconstrained_demand_quantity"
      expr: SUM(CAST(unconstrained_demand_quantity AS DOUBLE))
      comment: "Total unconstrained demand quantity before supply limitations are applied. Reveals true market demand potential."
    - name: "total_approved_quantity"
      expr: SUM(CAST(approved_quantity AS DOUBLE))
      comment: "Total demand quantity that has received formal S&OP approval. Governance KPI for demand sign-off completeness."
    - name: "total_marketing_event_uplift_quantity"
      expr: SUM(CAST(marketing_event_uplift_quantity AS DOUBLE))
      comment: "Total demand uplift attributed to marketing events. Measures marketing-driven incremental volume."
    - name: "total_new_product_launch_quantity"
      expr: SUM(CAST(new_product_launch_quantity AS DOUBLE))
      comment: "Total demand volume from new product launches. Tracks NPD contribution to overall demand plan."
    - name: "avg_forecast_accuracy_previous_period"
      expr: AVG(CAST(forecast_accuracy_previous_period AS DOUBLE))
      comment: "Average forecast accuracy from the prior period. Core S&OP KPI for measuring demand planning quality and driving process improvement."
    - name: "avg_demand_volatility_index"
      expr: AVG(CAST(demand_volatility_index AS DOUBLE))
      comment: "Average demand volatility index across SKUs/nodes. High volatility signals need for increased safety stock or more frequent replanning."
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average variance percentage between consensus and statistical forecast. Measures the degree of human override and potential bias."
    - name: "total_finance_input_quantity"
      expr: SUM(CAST(finance_input_quantity AS DOUBLE))
      comment: "Total finance-submitted demand quantity. Enables reconciliation between commercial and financial demand views."
    - name: "total_customer_commitment_quantity"
      expr: SUM(CAST(customer_commitment_quantity AS DOUBLE))
      comment: "Total quantity committed to customers within the consensus demand. Measures firm demand obligations."
    - name: "avg_seasonality_factor"
      expr: AVG(CAST(seasonality_factor AS DOUBLE))
      comment: "Average seasonality factor applied to demand. Indicates the degree of seasonal demand variation across the portfolio."
    - name: "consensus_demand_record_count"
      expr: COUNT(1)
      comment: "Count of consensus demand records. Used to assess S&OP planning coverage and completeness."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`supply_demand_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Demand plan metrics covering planned volumes, forecast accuracy, bias, and overlay adjustments. Supports demand review governance, plan quality assessment, and supply-demand alignment decisions."
  source: "`vibe_consumer_goods_v1`.`supply`.`demand_plan`"
  dimensions:
    - name: "demand_plan_status"
      expr: demand_plan_status
      comment: "Current status of the demand plan (e.g., draft, approved, locked) for governance and workflow tracking."
    - name: "demand_type"
      expr: demand_type
      comment: "Type of demand (e.g., base, promotional, NPD) for segmented plan analysis."
    - name: "demand_pattern_type"
      expr: demand_pattern_type
      comment: "Demand pattern classification (e.g., seasonal, intermittent, trend) for model selection and accuracy benchmarking."
    - name: "planning_bucket"
      expr: planning_bucket
      comment: "Planning time bucket for demand aggregation."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the demand plan for S&OP governance."
    - name: "lifecycle_stage"
      expr: lifecycle_stage
      comment: "Product lifecycle stage (e.g., launch, growth, decline) for lifecycle-adjusted demand analysis."
    - name: "risk_category"
      expr: risk_category
      comment: "Risk category of the demand plan for risk-weighted supply planning."
    - name: "risk_flag"
      expr: risk_flag
      comment: "Boolean flag indicating high-risk demand plans requiring executive attention."
    - name: "is_consensus_version"
      expr: is_consensus_version
      comment: "Flags the official consensus version of the demand plan for filtering to approved S&OP baseline."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for financial demand value analysis."
    - name: "plan_horizon_start"
      expr: DATE_TRUNC('month', plan_horizon_start)
      comment: "Start of the planning horizon truncated to month for time-series demand analysis."
    - name: "version_type"
      expr: version_type
      comment: "Version type (e.g., baseline, revised, final) for plan version comparison."
    - name: "demand_sensing_signal"
      expr: demand_sensing_signal
      comment: "Demand sensing signal source for evaluating short-term demand signal quality."
  measures:
    - name: "total_planned_quantity"
      expr: SUM(CAST(planned_quantity AS DOUBLE))
      comment: "Total planned demand quantity. Primary demand plan volume KPI used in S&OP supply alignment."
    - name: "total_consensus_quantity"
      expr: SUM(CAST(consensus_quantity AS DOUBLE))
      comment: "Total consensus-agreed demand quantity from the demand plan. Represents the official demand signal for supply planning."
    - name: "total_statistical_baseline_quantity"
      expr: SUM(CAST(statistical_baseline_quantity AS DOUBLE))
      comment: "Total statistical baseline demand before overlays. Benchmark for measuring the impact of human adjustments."
    - name: "total_commercial_overlay_quantity"
      expr: SUM(CAST(commercial_overlay_quantity AS DOUBLE))
      comment: "Total commercial overlay volume applied to the statistical baseline. Measures the scale of commercial judgment in the plan."
    - name: "total_promotional_overlay_quantity"
      expr: SUM(CAST(promotional_overlay_quantity AS DOUBLE))
      comment: "Total promotional volume overlay. Tracks promotional demand contribution to the overall plan."
    - name: "total_npd_launch_volume_quantity"
      expr: SUM(CAST(npd_launch_volume_quantity AS DOUBLE))
      comment: "Total new product development launch volume in the demand plan. Measures NPD pipeline contribution."
    - name: "total_marketing_event_uplift_quantity"
      expr: SUM(CAST(marketing_event_uplift_quantity AS DOUBLE))
      comment: "Total marketing event uplift volume. Quantifies marketing-driven incremental demand."
    - name: "avg_forecast_accuracy_percentage"
      expr: AVG(CAST(forecast_accuracy_percentage AS DOUBLE))
      comment: "Average forecast accuracy percentage across demand plans. Core S&OP KPI for demand planning quality."
    - name: "avg_forecast_bias_percentage"
      expr: AVG(CAST(forecast_bias_percentage AS DOUBLE))
      comment: "Average forecast bias percentage. Persistent positive or negative bias indicates systematic over/under-forecasting requiring process correction."
    - name: "total_variance_to_baseline_quantity"
      expr: SUM(CAST(variance_to_baseline_quantity AS DOUBLE))
      comment: "Total variance between planned and baseline quantities. Measures the aggregate impact of planning adjustments."
    - name: "demand_plan_count"
      expr: COUNT(1)
      comment: "Count of demand plan records. Used to assess planning coverage and as a denominator for average calculations."
    - name: "risk_flagged_plan_count"
      expr: COUNT(CASE WHEN risk_flag = TRUE THEN 1 END)
      comment: "Count of demand plans flagged as high-risk. Executives use this to prioritize S&OP risk review and mitigation actions."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`supply_forecast_version`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Forecast version metrics tracking forecast accuracy, bias, model performance, and version lifecycle. Enables benchmarking of forecasting methods and drives continuous improvement in demand sensing."
  source: "`vibe_consumer_goods_v1`.`supply`.`forecast_version`"
  dimensions:
    - name: "forecast_version_status"
      expr: forecast_version_status
      comment: "Status of the forecast version (e.g., draft, approved, archived) for lifecycle governance."
    - name: "forecast_method"
      expr: forecast_method
      comment: "Forecasting method used (e.g., exponential smoothing, ARIMA, ML) for method performance benchmarking."
    - name: "algorithm_used"
      expr: algorithm_used
      comment: "Specific algorithm applied in the forecast model for granular model performance analysis."
    - name: "aggregation_level"
      expr: aggregation_level
      comment: "Aggregation level of the forecast (e.g., SKU, category, brand) for hierarchical accuracy analysis."
    - name: "planning_bucket"
      expr: planning_bucket
      comment: "Planning time bucket for forecast aggregation."
    - name: "is_active_version"
      expr: is_active_version
      comment: "Flags the currently active forecast version for filtering to live plan."
    - name: "is_baseline"
      expr: is_baseline
      comment: "Flags the baseline forecast version for comparison against revised versions."
    - name: "is_consensus_version"
      expr: is_consensus_version
      comment: "Flags the consensus-approved forecast version."
    - name: "is_final_approved_version"
      expr: is_final_approved_version
      comment: "Flags the final approved forecast version for S&OP sign-off tracking."
    - name: "demand_sensing_applied"
      expr: demand_sensing_applied
      comment: "Indicates whether demand sensing was applied, enabling comparison of sensing vs. non-sensing forecast accuracy."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the forecast version for governance tracking."
    - name: "snapshot_date"
      expr: DATE_TRUNC('month', snapshot_date)
      comment: "Month of forecast snapshot for time-series accuracy trending."
    - name: "version_type"
      expr: version_type
      comment: "Version type (e.g., statistical, consensus, final) for version comparison analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for financial forecast value analysis."
  measures:
    - name: "total_forecast_quantity"
      expr: SUM(CAST(forecast_quantity AS DOUBLE))
      comment: "Total forecasted demand quantity. Primary forecast volume KPI for supply planning alignment."
    - name: "avg_forecast_accuracy_percentage"
      expr: AVG(CAST(forecast_accuracy_percentage AS DOUBLE))
      comment: "Average forecast accuracy percentage. The most critical demand planning KPI — directly drives safety stock levels and supply plan confidence."
    - name: "avg_mean_absolute_percentage_error"
      expr: AVG(CAST(mean_absolute_percentage_error AS DOUBLE))
      comment: "Average MAPE across forecast versions. Standard industry measure of forecast error used in S&OP performance reviews."
    - name: "avg_bias_percentage"
      expr: AVG(CAST(bias_percentage AS DOUBLE))
      comment: "Average forecast bias percentage. Systematic bias (consistently over or under) indicates model or process issues requiring correction."
    - name: "active_forecast_version_count"
      expr: COUNT(CASE WHEN is_active_version = TRUE THEN 1 END)
      comment: "Count of currently active forecast versions. Multiple active versions may indicate governance gaps."
    - name: "approved_forecast_version_count"
      expr: COUNT(CASE WHEN is_final_approved_version = TRUE THEN 1 END)
      comment: "Count of final approved forecast versions. Measures S&OP approval completeness across the planning portfolio."
    - name: "total_forecast_version_count"
      expr: COUNT(1)
      comment: "Total count of forecast versions. Used to assess planning iteration frequency and version proliferation."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`supply_inventory_policy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory policy metrics covering safety stock targets, service level commitments, reorder parameters, and fill rate objectives. Drives inventory investment decisions and customer service level governance."
  source: "`vibe_consumer_goods_v1`.`supply`.`inventory_policy`"
  dimensions:
    - name: "policy_type"
      expr: policy_type
      comment: "Inventory policy type (e.g., min-max, reorder point, VMI) for policy segmentation and benchmarking."
    - name: "inventory_policy_status"
      expr: inventory_policy_status
      comment: "Status of the inventory policy (e.g., active, draft, expired) for governance filtering."
    - name: "replenishment_method"
      expr: replenishment_method
      comment: "Replenishment method (e.g., MRP, DRP, kanban) for method performance comparison."
    - name: "safety_stock_calculation_method"
      expr: safety_stock_calculation_method
      comment: "Method used to calculate safety stock for methodology benchmarking."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the inventory policy for governance tracking."
    - name: "penalty_clause_indicator"
      expr: penalty_clause_indicator
      comment: "Flags policies with contractual penalty clauses, prioritizing service level compliance monitoring."
    - name: "retailer_mandated_target_flag"
      expr: retailer_mandated_target_flag
      comment: "Flags retailer-mandated service level targets requiring strict compliance monitoring."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for financial policy value analysis."
    - name: "effective_start_date"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Policy effective start date truncated to month for policy lifecycle analysis."
    - name: "policy_status"
      expr: policy_status
      comment: "Operational status of the policy for active policy filtering."
  measures:
    - name: "avg_safety_stock_target_units"
      expr: AVG(CAST(safety_stock_target_units AS DOUBLE))
      comment: "Average safety stock target in units. Baseline inventory buffer investment KPI used in working capital optimization."
    - name: "total_safety_stock_target_units"
      expr: SUM(CAST(safety_stock_target_units AS DOUBLE))
      comment: "Total safety stock target units across all policies. Measures aggregate buffer inventory investment."
    - name: "avg_service_level_target_pct"
      expr: AVG(CAST(service_level_target_pct AS DOUBLE))
      comment: "Average service level target percentage. Core customer service commitment KPI used in OTIF and fill rate governance."
    - name: "avg_fill_rate_target_percent"
      expr: AVG(CAST(fill_rate_target_percent AS DOUBLE))
      comment: "Average fill rate target percentage. Measures the ambition level of inventory policies for customer order fulfillment."
    - name: "avg_on_time_delivery_target_percent"
      expr: AVG(CAST(on_time_delivery_target_percent AS DOUBLE))
      comment: "Average on-time delivery target percentage. Drives logistics and supply planning to meet customer delivery commitments."
    - name: "avg_otif_composite_target_percent"
      expr: AVG(CAST(otif_composite_target_percent AS DOUBLE))
      comment: "Average OTIF (On-Time In-Full) composite target. The primary retailer scorecard KPI for consumer goods supply chains."
    - name: "avg_safety_stock_days_of_supply"
      expr: AVG(CAST(safety_stock_days_of_supply AS DOUBLE))
      comment: "Average safety stock expressed in days of supply. Normalizes buffer inventory across SKUs for portfolio-level comparison."
    - name: "avg_reorder_point"
      expr: AVG(CAST(reorder_point AS DOUBLE))
      comment: "Average reorder point across policies. Indicates the average inventory trigger level for replenishment actions."
    - name: "avg_lead_time_variability_days"
      expr: AVG(CAST(lead_time_variability_days AS DOUBLE))
      comment: "Average lead time variability in days. High variability drives higher safety stock requirements and supply risk."
    - name: "avg_demand_variability_coefficient"
      expr: AVG(CAST(demand_variability_coefficient AS DOUBLE))
      comment: "Average demand variability coefficient. Measures demand uncertainty driving safety stock calculations."
    - name: "avg_customer_otif_commitment_percent"
      expr: AVG(CAST(customer_otif_commitment_percent AS DOUBLE))
      comment: "Average customer OTIF commitment percentage. Represents contractual service obligations to retail customers."
    - name: "inventory_policy_count"
      expr: COUNT(1)
      comment: "Count of inventory policies. Used to assess policy coverage across the SKU/node portfolio."
    - name: "penalty_clause_policy_count"
      expr: COUNT(CASE WHEN penalty_clause_indicator = TRUE THEN 1 END)
      comment: "Count of policies with penalty clauses. Executives use this to prioritize compliance monitoring and risk mitigation."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`supply_replenishment_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Replenishment order metrics tracking order volumes, fulfillment performance, lead times, and supply execution. Core operational KPI layer for distribution resource planning (DRP) and supply execution governance."
  source: "`vibe_consumer_goods_v1`.`supply`.`replenishment_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the replenishment order (e.g., planned, released, in-transit, received) for pipeline visibility."
    - name: "order_type"
      expr: order_type
      comment: "Type of replenishment order (e.g., DRP, safety stock triggered, manual) for order origin analysis."
    - name: "supply_replenishment_order_status"
      expr: supply_replenishment_order_status
      comment: "Supply-side status of the replenishment order for supply execution tracking."
    - name: "transportation_mode"
      expr: transportation_mode
      comment: "Transportation mode (e.g., road, rail, air) for logistics cost and lead time analysis."
    - name: "priority"
      expr: priority
      comment: "Order priority level for expedite and escalation management."
    - name: "safety_stock_trigger_flag"
      expr: safety_stock_trigger_flag
      comment: "Flags orders triggered by safety stock breach. Measures frequency of buffer stock depletion events."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for financial order value analysis."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for volume-based replenishment metrics."
    - name: "planned_ship_date"
      expr: DATE_TRUNC('month', planned_ship_date)
      comment: "Planned ship date truncated to month for replenishment pipeline time-series analysis."
    - name: "planned_receipt_date"
      expr: DATE_TRUNC('month', planned_receipt_date)
      comment: "Planned receipt date truncated to month for inbound supply horizon analysis."
    - name: "cancellation_reason"
      expr: cancellation_reason
      comment: "Reason for order cancellation for root cause analysis of supply plan disruptions."
  measures:
    - name: "total_order_quantity"
      expr: SUM(CAST(order_quantity AS DOUBLE))
      comment: "Total replenishment order quantity. Primary supply execution volume KPI for DRP performance."
    - name: "total_confirmed_quantity"
      expr: SUM(CAST(confirmed_quantity AS DOUBLE))
      comment: "Total confirmed replenishment quantity. Measures supplier commitment against planned orders."
    - name: "total_shipped_quantity"
      expr: SUM(CAST(shipped_quantity AS DOUBLE))
      comment: "Total quantity shipped. Measures actual supply execution against plan."
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total quantity received at destination. Measures completed supply replenishment."
    - name: "total_requested_quantity"
      expr: SUM(CAST(requested_quantity AS DOUBLE))
      comment: "Total requested replenishment quantity. Represents gross demand signal to the supply network."
    - name: "total_order_cost_amount"
      expr: SUM(CAST(order_cost_amount AS DOUBLE))
      comment: "Total cost of replenishment orders. Drives supply chain cost management and make-vs-buy decisions."
    - name: "total_available_to_promise_quantity"
      expr: SUM(CAST(available_to_promise_quantity AS DOUBLE))
      comment: "Total ATP quantity from replenishment orders. Measures supply pipeline contribution to order promising."
    - name: "total_forecast_demand_quantity"
      expr: SUM(CAST(forecast_demand_quantity AS DOUBLE))
      comment: "Total forecast demand quantity driving replenishment orders. Enables comparison of forecast-driven vs. actual order volumes."
    - name: "replenishment_order_count"
      expr: COUNT(1)
      comment: "Total count of replenishment orders. Measures supply planning activity volume and DRP execution frequency."
    - name: "safety_stock_triggered_order_count"
      expr: COUNT(CASE WHEN safety_stock_trigger_flag = TRUE THEN 1 END)
      comment: "Count of orders triggered by safety stock breach. High frequency indicates chronic supply shortfalls requiring policy review."
    - name: "avg_order_quantity"
      expr: AVG(CAST(order_quantity AS DOUBLE))
      comment: "Average replenishment order quantity. Used to assess order sizing efficiency and lot size optimization."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`supply_safety_stock`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Safety stock metrics tracking buffer inventory levels, service level targets, lead time and demand variability, and holding costs. Drives working capital optimization and supply risk management decisions."
  source: "`vibe_consumer_goods_v1`.`supply`.`safety_stock`"
  dimensions:
    - name: "safety_stock_status"
      expr: safety_stock_status
      comment: "Status of the safety stock record (e.g., active, under review, expired) for governance filtering."
    - name: "calculation_method"
      expr: calculation_method
      comment: "Method used to calculate safety stock (e.g., statistical, days-of-supply, fixed) for methodology benchmarking."
    - name: "abc_classification"
      expr: abc_classification
      comment: "ABC classification of the SKU for value-based inventory segmentation and prioritization."
    - name: "xyz_classification"
      expr: xyz_classification
      comment: "XYZ classification based on demand variability for volatility-based safety stock segmentation."
    - name: "demand_classification"
      expr: demand_classification
      comment: "Demand classification (e.g., fast-moving, slow-moving, intermittent) for inventory policy differentiation."
    - name: "review_status"
      expr: review_status
      comment: "Review status of the safety stock record for governance and approval workflow tracking."
    - name: "is_active"
      expr: is_active
      comment: "Flags active safety stock records for filtering to current operational buffer levels."
    - name: "override_reason_code"
      expr: override_reason_code
      comment: "Reason code for manual safety stock overrides for root cause analysis of policy exceptions."
    - name: "effective_date"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Effective date of the safety stock record truncated to month for time-series buffer level analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for financial safety stock value analysis."
  measures:
    - name: "total_calculated_safety_stock_units"
      expr: SUM(CAST(calculated_safety_stock_units AS DOUBLE))
      comment: "Total calculated safety stock units. Primary buffer inventory KPI for working capital and supply risk management."
    - name: "total_approved_safety_stock_units"
      expr: SUM(CAST(approved_safety_stock_units AS DOUBLE))
      comment: "Total approved safety stock units. Represents the formally sanctioned buffer inventory level."
    - name: "avg_service_level_pct"
      expr: AVG(CAST(service_level_pct AS DOUBLE))
      comment: "Average service level percentage targeted by safety stock policies. Core customer service KPI."
    - name: "avg_target_service_level_percent"
      expr: AVG(CAST(target_service_level_percent AS DOUBLE))
      comment: "Average target service level percentage. Measures the ambition of safety stock policies across the portfolio."
    - name: "avg_days_of_supply_target"
      expr: AVG(CAST(days_of_supply_target AS DOUBLE))
      comment: "Average days of supply target for safety stock. Normalizes buffer levels across SKUs for portfolio comparison."
    - name: "avg_lead_time_days"
      expr: AVG(CAST(lead_time_days AS DOUBLE))
      comment: "Average lead time in days. Longer lead times drive higher safety stock requirements and supply risk."
    - name: "avg_lead_time_variability_days"
      expr: AVG(CAST(lead_time_variability_days AS DOUBLE))
      comment: "Average lead time variability in days. High variability is a primary driver of excess safety stock investment."
    - name: "avg_demand_variability"
      expr: AVG(CAST(demand_variability AS DOUBLE))
      comment: "Average demand variability. Measures demand uncertainty driving safety stock calculations."
    - name: "avg_forecast_accuracy_percent"
      expr: AVG(CAST(forecast_accuracy_percent AS DOUBLE))
      comment: "Average forecast accuracy percentage at the safety stock level. Lower accuracy requires higher buffer inventory."
    - name: "avg_supply_risk_score"
      expr: AVG(CAST(supply_risk_score AS DOUBLE))
      comment: "Average supply risk score. Composite risk indicator used to prioritize supply risk mitigation actions."
    - name: "total_holding_cost_per_unit"
      expr: SUM(CAST(holding_cost_per_unit AS DOUBLE))
      comment: "Total holding cost per unit across safety stock records. Measures the financial cost of buffer inventory investment."
    - name: "avg_z_score"
      expr: AVG(CAST(z_score AS DOUBLE))
      comment: "Average Z-score used in safety stock calculation. Reflects the statistical service level ambition of the inventory policy."
    - name: "safety_stock_record_count"
      expr: COUNT(1)
      comment: "Count of safety stock records. Used to assess safety stock policy coverage across the SKU/node portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`supply_sop_cycle`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "S&OP cycle metrics tracking demand and supply consensus volumes, supply gaps, cycle governance, and executive approval status. Drives S&OP process performance and executive decision-making."
  source: "`vibe_consumer_goods_v1`.`supply`.`sop_cycle`"
  dimensions:
    - name: "cycle_status"
      expr: cycle_status
      comment: "Current status of the S&OP cycle (e.g., in-progress, completed, locked) for cycle governance tracking."
    - name: "cycle_type"
      expr: cycle_type
      comment: "Type of S&OP cycle (e.g., monthly, quarterly) for cycle frequency analysis."
    - name: "cycle_phase"
      expr: cycle_phase
      comment: "Current phase of the S&OP cycle (e.g., demand review, supply review, executive review) for phase-level performance tracking."
    - name: "sop_cycle_status"
      expr: sop_cycle_status
      comment: "Operational status of the S&OP cycle for filtering to active or completed cycles."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the S&OP cycle for annual performance trending."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the S&OP cycle for period-over-period comparison."
    - name: "demand_consensus_achieved_flag"
      expr: demand_consensus_achieved_flag
      comment: "Flags cycles where demand consensus was achieved. Measures S&OP process effectiveness."
    - name: "supply_consensus_achieved_flag"
      expr: supply_consensus_achieved_flag
      comment: "Flags cycles where supply consensus was achieved. Measures supply planning alignment quality."
    - name: "executive_approval_flag"
      expr: executive_approval_flag
      comment: "Flags cycles with executive approval. Measures governance completeness of the S&OP process."
    - name: "cycle_locked_flag"
      expr: cycle_locked_flag
      comment: "Flags locked S&OP cycles where the plan is frozen for execution."
    - name: "planning_month"
      expr: DATE_TRUNC('month', planning_month)
      comment: "Planning month of the S&OP cycle for time-series S&OP performance analysis."
    - name: "cycle_start_date"
      expr: DATE_TRUNC('month', cycle_start_date)
      comment: "Start date of the S&OP cycle truncated to month for cycle timeline analysis."
  measures:
    - name: "total_consensus_demand_volume"
      expr: SUM(CAST(consensus_demand_volume AS DOUBLE))
      comment: "Total consensus demand volume agreed in S&OP cycles. Primary S&OP output KPI for supply planning alignment."
    - name: "total_baseline_demand_volume"
      expr: SUM(CAST(baseline_demand_volume AS DOUBLE))
      comment: "Total baseline demand volume before S&OP adjustments. Benchmark for measuring S&OP value-add."
    - name: "total_constrained_supply_volume"
      expr: SUM(CAST(constrained_supply_volume AS DOUBLE))
      comment: "Total supply volume after applying capacity and supply constraints. Measures the supply-constrained plan."
    - name: "total_supply_gap_volume"
      expr: SUM(CAST(supply_gap_volume AS DOUBLE))
      comment: "Total supply gap volume (demand minus constrained supply). The most critical S&OP KPI — drives executive decisions on capacity investment, sourcing, and demand shaping."
    - name: "avg_supply_gap_volume"
      expr: AVG(CAST(supply_gap_volume AS DOUBLE))
      comment: "Average supply gap volume per S&OP cycle. Tracks trend in supply-demand imbalance over time."
    - name: "sop_cycle_count"
      expr: COUNT(1)
      comment: "Total count of S&OP cycles. Used to assess S&OP cadence and process completeness."
    - name: "demand_consensus_achieved_count"
      expr: COUNT(CASE WHEN demand_consensus_achieved_flag = TRUE THEN 1 END)
      comment: "Count of S&OP cycles where demand consensus was achieved. Measures S&OP process effectiveness and cross-functional alignment."
    - name: "supply_consensus_achieved_count"
      expr: COUNT(CASE WHEN supply_consensus_achieved_flag = TRUE THEN 1 END)
      comment: "Count of S&OP cycles where supply consensus was achieved. Measures supply planning alignment quality."
    - name: "executive_approved_cycle_count"
      expr: COUNT(CASE WHEN executive_approval_flag = TRUE THEN 1 END)
      comment: "Count of S&OP cycles with executive approval. Measures governance completeness and executive engagement in the S&OP process."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`supply_network_node`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supply network node metrics tracking node capacity, throughput, and operational characteristics. Supports network design decisions, capacity investment planning, and supply network optimization."
  source: "`vibe_consumer_goods_v1`.`supply`.`network_node`"
  dimensions:
    - name: "node_type"
      expr: node_type
      comment: "Type of network node (e.g., DC, factory, cross-dock, store) for network topology analysis."
    - name: "node_status"
      expr: node_status
      comment: "Operational status of the network node for active network filtering."
    - name: "network_node_status"
      expr: network_node_status
      comment: "Status of the network node in the supply planning system."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership type (e.g., owned, leased, 3PL) for make-vs-buy and network strategy analysis."
    - name: "echelon_level"
      expr: echelon_level
      comment: "Echelon level in the supply network hierarchy (e.g., tier 1, tier 2) for multi-echelon inventory analysis."
    - name: "country_code"
      expr: country_code
      comment: "Country of the network node for geographic supply network analysis."
    - name: "region"
      expr: region
      comment: "Region of the network node for regional supply network performance analysis."
    - name: "capacity_class"
      expr: capacity_class
      comment: "Capacity class of the node (e.g., small, medium, large) for capacity tier analysis."
    - name: "is_active"
      expr: is_active
      comment: "Flags active network nodes for filtering to operational network."
    - name: "temperature_controlled_flag"
      expr: temperature_controlled_flag
      comment: "Flags temperature-controlled nodes for cold chain network analysis."
    - name: "cross_dock_enabled_flag"
      expr: cross_dock_enabled_flag
      comment: "Flags cross-dock enabled nodes for flow-through supply chain analysis."
    - name: "effective_start_date"
      expr: DATE_TRUNC('year', effective_start_date)
      comment: "Year the network node became effective for network evolution analysis."
  measures:
    - name: "total_storage_capacity_units"
      expr: SUM(CAST(storage_capacity_units AS DOUBLE))
      comment: "Total storage capacity units across the supply network. Primary network capacity KPI for investment and utilization decisions."
    - name: "avg_storage_capacity_units"
      expr: AVG(CAST(storage_capacity_units AS DOUBLE))
      comment: "Average storage capacity per network node. Benchmarks node sizing for network design optimization."
    - name: "total_throughput_capacity_daily"
      expr: SUM(CAST(throughput_capacity_daily AS DOUBLE))
      comment: "Total daily throughput capacity across the network. Measures the network's ability to process supply volumes."
    - name: "avg_throughput_capacity_daily"
      expr: AVG(CAST(throughput_capacity_daily AS DOUBLE))
      comment: "Average daily throughput capacity per node. Used to identify bottleneck nodes in the supply network."
    - name: "active_node_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Count of active supply network nodes. Measures operational network footprint size."
    - name: "total_node_count"
      expr: COUNT(1)
      comment: "Total count of supply network nodes including inactive. Used for network coverage and governance analysis."
    - name: "temperature_controlled_node_count"
      expr: COUNT(CASE WHEN temperature_controlled_flag = TRUE THEN 1 END)
      comment: "Count of temperature-controlled nodes. Measures cold chain network capacity for perishable goods."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`supply_network_lane`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supply network lane metrics tracking lane capacity, lead times, costs, and service level targets. Supports transportation network optimization, sourcing strategy, and supply lane risk management."
  source: "`vibe_consumer_goods_v1`.`supply`.`network_lane`"
  dimensions:
    - name: "lane_type"
      expr: lane_type
      comment: "Type of supply lane (e.g., primary, backup, cross-dock) for lane strategy analysis."
    - name: "lane_mode"
      expr: lane_mode
      comment: "Transportation mode of the lane (e.g., road, rail, sea, air) for modal cost and lead time analysis."
    - name: "transport_mode"
      expr: transport_mode
      comment: "Transport mode for the lane for logistics cost benchmarking."
    - name: "network_lane_status"
      expr: network_lane_status
      comment: "Operational status of the network lane for active lane filtering."
    - name: "is_active"
      expr: is_active
      comment: "Flags active network lanes for filtering to operational supply routes."
    - name: "is_primary_lane"
      expr: is_primary_lane
      comment: "Flags primary supply lanes for primary vs. backup lane performance comparison."
    - name: "risk_category"
      expr: risk_category
      comment: "Risk category of the lane for supply risk prioritization and mitigation."
    - name: "sourcing_priority"
      expr: sourcing_priority
      comment: "Sourcing priority of the lane for multi-source supply strategy analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for lane cost analysis."
    - name: "effective_start_date"
      expr: DATE_TRUNC('year', effective_start_date)
      comment: "Year the lane became effective for network evolution analysis."
  measures:
    - name: "total_capacity_quantity"
      expr: SUM(CAST(capacity_quantity AS DOUBLE))
      comment: "Total capacity quantity across all supply lanes. Measures aggregate supply network throughput capacity."
    - name: "avg_lead_time_days"
      expr: AVG(CAST(lead_time_days AS DOUBLE))
      comment: "Average lead time in days across supply lanes. Core supply chain responsiveness KPI driving safety stock and customer service levels."
    - name: "avg_standard_lead_time_days"
      expr: AVG(CAST(standard_lead_time_days AS DOUBLE))
      comment: "Average standard lead time in days. Benchmark for measuring actual vs. standard lead time performance."
    - name: "avg_transportation_lead_time_days"
      expr: AVG(CAST(transportation_lead_time_days AS DOUBLE))
      comment: "Average transportation lead time in days. Measures transit time component of total supply lead time."
    - name: "avg_cost_per_unit"
      expr: AVG(CAST(cost_per_unit AS DOUBLE))
      comment: "Average cost per unit across supply lanes. Drives lane selection and transportation cost optimization decisions."
    - name: "total_lane_cost_per_unit"
      expr: SUM(CAST(lane_cost_per_unit AS DOUBLE))
      comment: "Total lane cost per unit across all lanes. Measures aggregate transportation cost investment in the supply network."
    - name: "avg_distance_km"
      expr: AVG(CAST(distance_km AS DOUBLE))
      comment: "Average lane distance in kilometers. Used in carbon footprint analysis and transportation cost modeling."
    - name: "avg_otif_target_pct"
      expr: AVG(CAST(otif_target_pct AS DOUBLE))
      comment: "Average OTIF target percentage across supply lanes. Measures the service level ambition of the supply network."
    - name: "avg_service_level_target_pct"
      expr: AVG(CAST(service_level_target_pct AS DOUBLE))
      comment: "Average service level target percentage for supply lanes. Drives lane selection for high-service-level customer commitments."
    - name: "active_lane_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Count of active supply lanes. Measures operational supply network connectivity."
    - name: "primary_lane_count"
      expr: COUNT(CASE WHEN is_primary_lane = TRUE THEN 1 END)
      comment: "Count of primary supply lanes. Used in network resilience analysis to assess backup lane coverage."
    - name: "total_lane_count"
      expr: COUNT(1)
      comment: "Total count of supply lanes. Measures supply network breadth and connectivity."
$$;