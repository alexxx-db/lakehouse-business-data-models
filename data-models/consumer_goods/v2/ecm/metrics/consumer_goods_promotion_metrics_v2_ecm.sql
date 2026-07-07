-- Metric views for domain: promotion | Business: Consumer Goods | Version: 2 | Generated on: 2026-06-28 00:14:33

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`promotion_baseline_volume`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Baseline volume KPIs — tracks the accuracy, confidence, and coverage of baseline volume models used to measure promotional incrementality and set promotion targets."
  source: "`vibe_consumer_goods_v1`.`promotion`.`baseline_volume`"
  dimensions:
    - name: "baseline_volume_status"
      expr: baseline_volume_status
      comment: "Current status of the baseline volume record (e.g. Draft, Approved, Superseded)."
    - name: "baseline_status"
      expr: baseline_status
      comment: "Normalized baseline status for workflow tracking."
    - name: "baseline_method"
      expr: baseline_method
      comment: "Method used to calculate the baseline (e.g. Moving Average, Regression, Causal) for methodology benchmarking."
    - name: "calculation_method"
      expr: calculation_method
      comment: "Calculation method for the baseline volume for model comparison analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which baseline financials are denominated."
    - name: "analyst_override"
      expr: analyst_override_flag
      comment: "Whether an analyst manually overrode the model baseline. Tracks model override frequency for model quality assessment."
    - name: "baseline_period_start_month"
      expr: DATE_TRUNC('month', baseline_period_start_date)
      comment: "Month the baseline period starts for time-series analysis of baseline coverage."
    - name: "outlier_exclusion"
      expr: outlier_exclusion_flag
      comment: "Whether outliers were excluded from the baseline calculation. Tracks data quality adjustments."
  measures:
    - name: "total_baseline_records"
      expr: COUNT(1)
      comment: "Total number of baseline volume records. Baseline for model coverage analysis."
    - name: "total_baseline_volume_units"
      expr: SUM(CAST(baseline_volume_units AS DOUBLE))
      comment: "Total baseline volume units across all records. Measures the non-promoted volume foundation for incrementality calculations."
    - name: "total_baseline_revenue"
      expr: SUM(CAST(baseline_revenue_amount AS DOUBLE))
      comment: "Total baseline revenue amount. Measures the non-promoted revenue foundation for ROI calculations."
    - name: "avg_model_accuracy_score"
      expr: AVG(CAST(model_accuracy_score AS DOUBLE))
      comment: "Average model accuracy score across baseline records. Measures quality of the baseline modeling program — low scores indicate need for model improvement."
    - name: "avg_seasonality_adjustment_factor"
      expr: AVG(CAST(seasonality_adjustment_factor AS DOUBLE))
      comment: "Average seasonality adjustment factor applied to baselines. Measures seasonal correction intensity in the baseline model."
    - name: "avg_trend_adjustment_factor"
      expr: AVG(CAST(trend_adjustment_factor AS DOUBLE))
      comment: "Average trend adjustment factor applied to baselines. Measures trend correction intensity in the baseline model."
    - name: "analyst_override_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN analyst_override_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of baseline records with analyst overrides. High rates indicate model quality issues requiring investment in better algorithms."
    - name: "avg_confidence_level_pct"
      expr: AVG(CAST(confidence_level_percent AS DOUBLE))
      comment: "Average confidence level percentage across baseline models. Measures statistical reliability of the baseline volume program."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`promotion_consumer_offer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Consumer offer KPIs — tracks offer portfolio health, budget utilization, redemption economics, and offer design effectiveness to optimize consumer promotion investment."
  source: "`vibe_consumer_goods_v1`.`promotion`.`consumer_offer`"
  dimensions:
    - name: "consumer_offer_status"
      expr: consumer_offer_status
      comment: "Current status of the consumer offer (e.g. Draft, Active, Expired, Cancelled)."
    - name: "offer_type"
      expr: offer_type
      comment: "Type of consumer offer (e.g. Coupon, Rebate, BOGO, Free Gift) for mechanic mix analysis."
    - name: "offer_status"
      expr: offer_status
      comment: "Operational status of the offer for pipeline management."
    - name: "distribution_channel"
      expr: distribution_channel
      comment: "Channel through which the offer is distributed (e.g. FSI, Digital, In-Store) for channel effectiveness analysis."
    - name: "redemption_channel"
      expr: redemption_channel
      comment: "Channel through which the offer can be redeemed for channel strategy analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which offer financials are denominated."
    - name: "offer_start_month"
      expr: DATE_TRUNC('month', offer_start_date)
      comment: "Month the offer becomes active for time-series analysis of offer launches."
    - name: "stackable"
      expr: stackable_flag
      comment: "Whether the offer can be stacked with other promotions. Identifies offers with higher liability risk."
  measures:
    - name: "total_offers"
      expr: COUNT(1)
      comment: "Total number of consumer offers in the portfolio. Baseline for offer portfolio management."
    - name: "total_budget_allocated"
      expr: SUM(CAST(total_budget_allocated AS DOUBLE))
      comment: "Total budget allocated to consumer offers. Core financial commitment metric for consumer promotion planning."
    - name: "total_actual_cost_incurred"
      expr: SUM(CAST(actual_cost_incurred AS DOUBLE))
      comment: "Total actual cost incurred from consumer offers. Measures realized consumer promotion spend."
    - name: "total_offer_value"
      expr: SUM(CAST(offer_value AS DOUBLE))
      comment: "Total face value of consumer offers issued. Measures maximum potential liability from the offer portfolio."
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage across consumer offers. Measures promotional depth and price erosion risk."
    - name: "avg_estimated_cost_per_redemption"
      expr: AVG(CAST(estimated_cost_per_redemption AS DOUBLE))
      comment: "Average estimated cost per redemption. Key efficiency metric for comparing offer mechanics and channels."
    - name: "budget_utilization_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_cost_incurred AS DOUBLE)) / NULLIF(SUM(CAST(total_budget_allocated AS DOUBLE)), 0), 2)
      comment: "Percentage of allocated budget actually spent on consumer offers. Measures execution efficiency of consumer promotion programs."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`promotion_deduction_settlement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Deduction settlement KPIs — measures settlement cycle efficiency, write-off rates, SLA compliance, and financial resolution quality to optimize the order-to-cash deduction process."
  source: "`vibe_consumer_goods_v1`.`promotion`.`deduction_settlement`"
  dimensions:
    - name: "deduction_settlement_status"
      expr: deduction_settlement_status
      comment: "Current status of the settlement record (e.g. Pending, Approved, Paid, Written Off)."
    - name: "settlement_method"
      expr: settlement_method
      comment: "Method used to settle the deduction (e.g. Credit Memo, Check, Offset) for process analysis."
    - name: "settlement_reason_code"
      expr: settlement_reason_code
      comment: "Reason code for the settlement outcome for root cause categorization."
    - name: "dispute_resolution_method"
      expr: dispute_resolution_method
      comment: "Method used to resolve disputes within the settlement for process benchmarking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which settlement financials are denominated."
    - name: "sla_compliance"
      expr: sla_compliance_flag
      comment: "Whether the settlement was completed within SLA. Tracks operational compliance with service level commitments."
    - name: "is_partial_settlement"
      expr: is_partial_settlement
      comment: "Whether the settlement is partial. Identifies incomplete resolutions requiring follow-up."
    - name: "settlement_date_month"
      expr: DATE_TRUNC('month', settlement_date)
      comment: "Month of settlement for time-series trending of resolution throughput."
  measures:
    - name: "total_settlements"
      expr: COUNT(1)
      comment: "Total number of deduction settlements processed. Baseline for settlement throughput management."
    - name: "total_deduction_claimed_amount"
      expr: SUM(CAST(deduction_claimed_amount AS DOUBLE))
      comment: "Total deduction amount claimed by retailers. Gross exposure before settlement review."
    - name: "total_approved_amount"
      expr: SUM(CAST(approved_amount AS DOUBLE))
      comment: "Total approved settlement amount. Validated trade liability after review and approval."
    - name: "total_settled_amount"
      expr: SUM(CAST(settled_amount AS DOUBLE))
      comment: "Total amount settled. Measures cash outflow from deduction resolution."
    - name: "total_disputed_amount"
      expr: SUM(CAST(disputed_amount AS DOUBLE))
      comment: "Total amount under dispute within settlements. Measures contested exposure requiring resolution resources."
    - name: "total_write_off_amount"
      expr: SUM(CAST(write_off_amount AS DOUBLE))
      comment: "Total amount written off. Measures irrecoverable trade spend losses — a key P&L risk metric."
    - name: "write_off_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(write_off_amount AS DOUBLE)) / NULLIF(SUM(CAST(deduction_claimed_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of claimed deductions written off. High rates indicate systemic issues with deduction validity or recovery processes."
    - name: "sla_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN sla_compliance_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of settlements completed within SLA. Measures operational efficiency of the deduction resolution process."
    - name: "approval_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(approved_amount AS DOUBLE)) / NULLIF(SUM(CAST(deduction_claimed_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of claimed deduction amount approved. Measures deduction validity and retailer claim accuracy."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`promotion_event_sku`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Event SKU execution KPIs — tracks SKU-level promotional volume, pricing, compliance, and financial performance within promotion events to optimize SKU selection and promotional mechanics."
  source: "`vibe_consumer_goods_v1`.`promotion`.`event_sku`"
  dimensions:
    - name: "event_sku_status"
      expr: event_sku_status
      comment: "Current status of the event SKU record (e.g. Active, Settled, Cancelled)."
    - name: "display_type"
      expr: display_type
      comment: "Type of in-store display used (e.g. End Cap, Pallet, Shelf Talker) for display effectiveness analysis."
    - name: "feature_type"
      expr: feature_type
      comment: "Type of feature/ad placement (e.g. Front Page, Interior, Digital) for feature ROI analysis."
    - name: "promoted_price_type"
      expr: promoted_price_type
      comment: "Type of promoted price (e.g. TPR, EDLP, Hi-Lo) for pricing strategy analysis."
    - name: "settlement_status"
      expr: settlement_status
      comment: "Settlement status of the event SKU for deduction management."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which event SKU financials are denominated."
    - name: "is_featured_sku"
      expr: is_featured_sku
      comment: "Whether the SKU is featured in the promotion. Enables featured vs non-featured performance comparison."
    - name: "compliance_check_status"
      expr: compliance_check_status
      comment: "Status of compliance verification for the event SKU."
  measures:
    - name: "total_event_skus"
      expr: COUNT(1)
      comment: "Total number of event SKU records. Baseline for promotional SKU portfolio management."
    - name: "total_planned_promotional_volume_units"
      expr: SUM(CAST(planned_promotional_volume_units AS DOUBLE))
      comment: "Total planned promotional volume units across event SKUs. Drives supply chain and inventory planning."
    - name: "total_actual_promotional_volume_units"
      expr: SUM(CAST(actual_promotional_volume_units AS DOUBLE))
      comment: "Total actual promotional volume units sold. Measures volume attainment against promotional plan."
    - name: "total_incremental_lift_volume_units"
      expr: SUM(CAST(incremental_lift_volume_units AS DOUBLE))
      comment: "Total incremental volume units driven by promotions above baseline. Measures net new volume from trade investment."
    - name: "total_trade_spend_amount"
      expr: SUM(CAST(total_trade_spend_amount AS DOUBLE))
      comment: "Total trade spend associated with event SKUs. Core financial metric for SKU-level trade investment tracking."
    - name: "total_accrual_amount"
      expr: SUM(CAST(accrual_amount AS DOUBLE))
      comment: "Total accrued trade spend for event SKUs. Tracks running liability for financial close."
    - name: "avg_incremental_lift_pct"
      expr: AVG(CAST(incremental_lift_percent AS DOUBLE))
      comment: "Average incremental lift percentage across event SKUs. Measures promotional effectiveness at SKU level."
    - name: "avg_price_reduction_depth_pct"
      expr: AVG(CAST(price_reduction_depth_percent AS DOUBLE))
      comment: "Average price reduction depth percentage. Measures promotional intensity and price erosion risk at SKU level."
    - name: "avg_promotional_roi_pct"
      expr: AVG(CAST(promotional_roi_percent AS DOUBLE))
      comment: "Average promotional ROI percentage at SKU level. Primary metric for evaluating SKU-level trade investment returns."
    - name: "avg_promotional_gmroi"
      expr: AVG(CAST(promotional_gmroi AS DOUBLE))
      comment: "Average promotional GMROI at SKU level. Measures retailer profitability of promoted SKUs."
    - name: "volume_attainment_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_promotional_volume_units AS DOUBLE)) / NULLIF(SUM(CAST(planned_promotional_volume_units AS DOUBLE)), 0), 2)
      comment: "Percentage of planned promotional volume actually achieved at SKU level. Key execution effectiveness metric."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`promotion_flight_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Campaign flight allocation KPIs — tracks how promotion budgets are allocated across campaign flights, measuring spend efficiency, volume attainment, and allocation accuracy."
  source: "`vibe_consumer_goods_v1`.`promotion`.`flight_allocation`"
  dimensions:
    - name: "flight_allocation_status"
      expr: flight_allocation_status
      comment: "Current status of the flight allocation (e.g. Planned, Active, Settled, Cancelled)."
    - name: "allocation_method"
      expr: allocation_method
      comment: "Method used to allocate spend to flights (e.g. Equal Split, Volume-Weighted, Manual) for methodology analysis."
    - name: "allocation_status"
      expr: allocation_status
      comment: "Operational status of the allocation for workflow management."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which flight allocation financials are denominated."
    - name: "flight_start_month"
      expr: DATE_TRUNC('month', flight_start_date)
      comment: "Month the campaign flight starts for time-series analysis of flight spend deployment."
  measures:
    - name: "total_flight_allocations"
      expr: COUNT(1)
      comment: "Total number of flight allocations. Baseline for campaign flight portfolio management."
    - name: "total_allocated_budget"
      expr: SUM(CAST(allocated_budget_amount AS DOUBLE))
      comment: "Total budget allocated to campaign flights. Core financial commitment metric for campaign planning."
    - name: "total_allocated_spend"
      expr: SUM(CAST(allocated_spend_amount AS DOUBLE))
      comment: "Total spend allocated across campaign flights. Measures trade investment deployment into media flights."
    - name: "total_actual_spend"
      expr: SUM(CAST(actual_spend_amount AS DOUBLE))
      comment: "Total actual spend incurred across flight allocations. Compared against allocated spend for variance analysis."
    - name: "total_planned_volume_units"
      expr: SUM(CAST(planned_volume_units AS DOUBLE))
      comment: "Total planned volume units across flight allocations. Drives supply chain planning for campaign periods."
    - name: "total_actual_volume_units"
      expr: SUM(CAST(actual_volume_units AS DOUBLE))
      comment: "Total actual volume units during flight periods. Measures volume attainment against flight plan."
    - name: "spend_execution_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_spend_amount AS DOUBLE)) / NULLIF(SUM(CAST(allocated_budget_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of allocated budget actually spent across flights. Measures campaign execution efficiency."
    - name: "avg_allocation_pct"
      expr: AVG(CAST(allocation_pct AS DOUBLE))
      comment: "Average allocation percentage across flight allocations. Measures how evenly spend is distributed across flights."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`promotion_funding_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Funding agreement KPIs — tracks committed trade funding, accrual rates, payment performance, and agreement health to manage trade fund liability and retailer partnership terms."
  source: "`vibe_consumer_goods_v1`.`promotion`.`funding_agreement`"
  dimensions:
    - name: "funding_agreement_status"
      expr: funding_agreement_status
      comment: "Current status of the funding agreement (e.g. Active, Expired, Terminated) for portfolio health monitoring."
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of funding agreement (e.g. Lump Sum, Scan Back, Off-Invoice) for fund type mix analysis."
    - name: "fund_type"
      expr: fund_type
      comment: "Fund category (e.g. Fixed, Variable, Performance-Based) for accrual methodology stratification."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status of the funding agreement for governance tracking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which agreement financials are denominated."
    - name: "payment_frequency"
      expr: payment_frequency
      comment: "Frequency of payments under the agreement (e.g. Monthly, Quarterly, Annual) for cash flow planning."
    - name: "effective_start_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the funding agreement becomes effective, for time-series analysis of agreement portfolio."
    - name: "auto_renewal"
      expr: auto_renewal_flag
      comment: "Whether the agreement auto-renews. Identifies agreements requiring proactive renewal management."
  measures:
    - name: "total_agreements"
      expr: COUNT(1)
      comment: "Total number of funding agreements. Baseline for agreement portfolio management."
    - name: "total_committed_amount"
      expr: SUM(CAST(total_committed_amount AS DOUBLE))
      comment: "Total committed trade funding across all agreements. Core liability metric for financial planning and P&L management."
    - name: "total_fund_amount"
      expr: SUM(CAST(total_fund_amount AS DOUBLE))
      comment: "Total fund amount authorized across agreements. Measures total trade investment envelope."
    - name: "total_accrued_to_date"
      expr: SUM(CAST(accrued_to_date_amount AS DOUBLE))
      comment: "Total amount accrued to date across funding agreements. Tracks running trade liability for financial close."
    - name: "total_paid_to_date"
      expr: SUM(CAST(paid_to_date_amount AS DOUBLE))
      comment: "Total amount paid to date across funding agreements. Measures cash outflow against commitments."
    - name: "total_remaining_balance"
      expr: SUM(CAST(remaining_balance_amount AS DOUBLE))
      comment: "Total remaining uncommitted balance across funding agreements. Identifies available trade fund capacity."
    - name: "avg_accrual_rate_pct"
      expr: AVG(CAST(accrual_rate_pct AS DOUBLE))
      comment: "Average accrual rate percentage across funding agreements. Benchmarks trade fund accrual intensity."
    - name: "avg_roi_target_pct"
      expr: AVG(CAST(roi_target_percentage AS DOUBLE))
      comment: "Average ROI target percentage set in funding agreements. Measures ambition level of trade investment commitments."
    - name: "fund_utilization_pct"
      expr: ROUND(100.0 * SUM(CAST(paid_to_date_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_committed_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of committed trade funds actually paid out. Measures fund execution efficiency; low values indicate under-execution risk."
    - name: "avg_gmroi_target"
      expr: AVG(CAST(gmroi_target AS DOUBLE))
      comment: "Average GMROI target set in funding agreements. Measures retailer profitability expectations embedded in trade contracts."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`promotion_lift_measurement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Statistical lift measurement KPIs — quantifies incremental volume, revenue, and cannibalization effects of promotions with confidence intervals for evidence-based promotion investment decisions."
  source: "`vibe_consumer_goods_v1`.`promotion`.`lift_measurement`"
  dimensions:
    - name: "lift_measurement_status"
      expr: lift_measurement_status
      comment: "Status of the lift measurement record (e.g. Preliminary, Validated, Final)."
    - name: "measurement_method"
      expr: measurement_method
      comment: "Methodology used to measure lift (e.g. Control Group, Matched Market, Regression) for methodology benchmarking."
    - name: "lift_source"
      expr: lift_source
      comment: "Source of lift data (e.g. POS, Panel, Syndicated) for data quality stratification."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which lift financials are denominated."
    - name: "measurement_week_start"
      expr: DATE_TRUNC('week', measurement_week_start_date)
      comment: "Week the measurement period starts, for time-series trending of lift results."
    - name: "statistical_significance"
      expr: statistical_significance_flag
      comment: "Whether the lift measurement is statistically significant. Filters for reliable results in decision-making."
    - name: "measurement_status"
      expr: measurement_status
      comment: "Operational status of the measurement process."
  measures:
    - name: "total_measurements"
      expr: COUNT(1)
      comment: "Total number of lift measurements. Baseline for measurement coverage analysis."
    - name: "avg_lift_pct"
      expr: AVG(CAST(lift_pct AS DOUBLE))
      comment: "Average promotional lift percentage across measurements. Primary KPI for promotion effectiveness benchmarking."
    - name: "avg_incremental_lift_pct"
      expr: AVG(CAST(incremental_lift_percentage AS DOUBLE))
      comment: "Average incremental lift percentage. Measures net new volume driven by promotions above baseline."
    - name: "total_incremental_lift_units"
      expr: SUM(CAST(incremental_lift_units AS DOUBLE))
      comment: "Total incremental volume units generated by promotions. Quantifies absolute volume uplift contribution."
    - name: "total_incremental_revenue"
      expr: SUM(CAST(incremental_revenue AS DOUBLE))
      comment: "Total incremental revenue generated by promotions. Measures top-line value creation from trade investment."
    - name: "avg_cannibalization_rate"
      expr: AVG(CAST(cannibalization_rate AS DOUBLE))
      comment: "Average cannibalization rate across promotions. Measures how much promoted volume displaces non-promoted SKUs — critical for net incrementality assessment."
    - name: "avg_halo_effect_units"
      expr: AVG(CAST(halo_effect_units AS DOUBLE))
      comment: "Average halo effect units (positive spillover to non-promoted SKUs). Captures full portfolio impact of promotions."
    - name: "avg_post_promotion_dip_units"
      expr: AVG(CAST(post_promotion_dip_units AS DOUBLE))
      comment: "Average post-promotion volume dip. Measures demand pull-forward effect to assess true net incrementality."
    - name: "statistically_significant_measurements"
      expr: SUM(CASE WHEN statistical_significance_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of statistically significant lift measurements. Measures quality and reliability of the measurement portfolio."
    - name: "statistical_significance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN statistical_significance_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of lift measurements that are statistically significant. Measures rigor of the promotion measurement program."
    - name: "avg_confidence_level_pct"
      expr: AVG(CAST(confidence_level_percentage AS DOUBLE))
      comment: "Average statistical confidence level across lift measurements. Indicates overall measurement reliability."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`promotion_pos_redemption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "POS redemption KPIs — tracks consumer offer redemption volumes, values, and channel performance to measure consumer promotion effectiveness and optimize offer design."
  source: "`vibe_consumer_goods_v1`.`promotion`.`pos_redemption`"
  dimensions:
    - name: "pos_redemption_status"
      expr: pos_redemption_status
      comment: "Status of the POS redemption (e.g. Valid, Rejected, Pending) for redemption quality analysis."
    - name: "redemption_channel"
      expr: redemption_channel
      comment: "Channel through which the offer was redeemed (e.g. In-Store, Digital, Mail-In) for channel effectiveness analysis."
    - name: "offer_type"
      expr: offer_type
      comment: "Type of consumer offer redeemed (e.g. Coupon, Rebate, BOGO) for offer mechanic performance analysis."
    - name: "channel"
      expr: channel
      comment: "Sales channel of the redemption transaction for channel-level performance analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which redemption financials are denominated."
    - name: "redemption_date_month"
      expr: DATE_TRUNC('month', redemption_date)
      comment: "Month of redemption for time-series trending of consumer offer performance."
    - name: "redemption_status"
      expr: redemption_status
      comment: "Operational status of the redemption for processing pipeline management."
  measures:
    - name: "total_redemptions"
      expr: COUNT(1)
      comment: "Total number of POS redemption transactions. Baseline for consumer offer reach and engagement."
    - name: "total_redemption_value"
      expr: SUM(CAST(redemption_value_amount AS DOUBLE))
      comment: "Total value of consumer offer redemptions. Measures consumer promotion financial liability."
    - name: "total_settlement_amount"
      expr: SUM(CAST(settlement_amount AS DOUBLE))
      comment: "Total settlement amount for redemptions. Measures actual cash outflow from consumer promotion program."
    - name: "total_handling_fee_amount"
      expr: SUM(CAST(handling_fee_amount AS DOUBLE))
      comment: "Total handling fees paid to clearinghouses. Measures administrative cost of consumer promotion execution."
    - name: "total_redemption_quantity"
      expr: SUM(CAST(redemption_quantity AS DOUBLE))
      comment: "Total units redeemed across all POS redemptions. Measures consumer engagement volume."
    - name: "total_transaction_amount"
      expr: SUM(CAST(transaction_total_amount AS DOUBLE))
      comment: "Total transaction value at point of redemption. Measures basket size associated with promotional redemptions."
    - name: "avg_unit_discount_amount"
      expr: AVG(CAST(unit_discount_amount AS DOUBLE))
      comment: "Average discount per unit at redemption. Measures promotional price depth delivered to consumers."
    - name: "avg_promoted_unit_price"
      expr: AVG(CAST(promoted_unit_price AS DOUBLE))
      comment: "Average promoted unit price at redemption. Benchmarks actual shelf price during promotions."
    - name: "validation_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN validation_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of redemptions that passed validation. Measures redemption data quality and fraud prevention effectiveness."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`promotion_post_event_analysis`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Post-event learning KPIs — measures actual vs planned promotion performance, ROI realization, compliance, and incremental revenue to drive continuous improvement in trade promotion strategy."
  source: "`vibe_consumer_goods_v1`.`promotion`.`post_event_analysis`"
  dimensions:
    - name: "analysis_status"
      expr: analysis_status
      comment: "Status of the post-event analysis (e.g. Draft, In Review, Approved) for workflow tracking."
    - name: "post_event_analysis_status"
      expr: post_event_analysis_status
      comment: "Normalized status of the post-event analysis record."
    - name: "learning_classification"
      expr: learning_classification
      comment: "Classification of the learning outcome (e.g. Best Practice, Needs Improvement, Neutral) for knowledge management."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which analysis financials are denominated."
    - name: "analysis_period_start_month"
      expr: DATE_TRUNC('month', analysis_period_start_date)
      comment: "Month the analysis period starts, for time-series trending of post-event results."
    - name: "feature_compliance"
      expr: feature_compliance_flag
      comment: "Whether feature/ad execution was compliant during the promotion event."
    - name: "pricing_compliance"
      expr: pricing_compliance_flag
      comment: "Whether pricing was compliant during the promotion event."
  measures:
    - name: "total_analyses"
      expr: COUNT(1)
      comment: "Total number of post-event analyses completed. Baseline for learning loop coverage."
    - name: "total_actual_trade_spend"
      expr: SUM(CAST(actual_trade_spend_amount AS DOUBLE))
      comment: "Total actual trade spend across analyzed events. Reconciles financial exposure post-promotion."
    - name: "total_planned_trade_spend"
      expr: SUM(CAST(planned_trade_spend_amount AS DOUBLE))
      comment: "Total planned trade spend for analyzed events. Baseline for spend variance calculation."
    - name: "total_trade_spend_variance"
      expr: SUM(CAST(trade_spend_variance_amount AS DOUBLE))
      comment: "Total variance between actual and planned trade spend. Identifies systematic over/under-spend patterns."
    - name: "total_incremental_revenue"
      expr: SUM(CAST(incremental_revenue_amount AS DOUBLE))
      comment: "Total incremental revenue generated by promotions above baseline. Primary measure of promotion value creation."
    - name: "total_incremental_volume_units"
      expr: SUM(CAST(incremental_volume_units AS DOUBLE))
      comment: "Total incremental volume units driven by promotions. Measures volume uplift contribution to market share."
    - name: "avg_actual_roi_pct"
      expr: AVG(CAST(actual_roi_percentage AS DOUBLE))
      comment: "Average actual ROI percentage across post-event analyses. Core metric for evaluating promotion profitability realization."
    - name: "avg_incremental_lift_pct"
      expr: AVG(CAST(incremental_lift_percentage AS DOUBLE))
      comment: "Average incremental lift percentage achieved. Measures promotion effectiveness vs baseline volume."
    - name: "avg_actual_lift_pct"
      expr: AVG(CAST(actual_lift_pct AS DOUBLE))
      comment: "Average actual lift percentage realized. Compared against planned lift to assess forecast accuracy."
    - name: "avg_retailer_compliance_score"
      expr: AVG(CAST(retailer_compliance_score AS DOUBLE))
      comment: "Average retailer compliance score across post-event analyses. Measures execution quality and retailer partnership health."
    - name: "avg_gmroi"
      expr: AVG(CAST(gmroi AS DOUBLE))
      comment: "Average Gross Margin Return on Investment across analyzed promotions. Measures retailer profitability of the promotion portfolio."
    - name: "avg_cost_per_incremental_case"
      expr: AVG(CAST(cost_per_incremental_case AS DOUBLE))
      comment: "Average cost to generate one incremental case of volume. Key efficiency metric for comparing promotion mechanics."
    - name: "total_profitability"
      expr: SUM(CAST(profitability_amount AS DOUBLE))
      comment: "Total profitability generated across analyzed promotion events. Bottom-line measure of trade promotion value."
    - name: "avg_sell_through_rate"
      expr: AVG(CAST(sell_through_rate AS DOUBLE))
      comment: "Average sell-through rate during promotion events. Measures inventory efficiency and demand fulfillment quality."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`promotion_promoted_price`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Promoted price KPIs — tracks promotional pricing depth, margin impact, and price strategy execution to optimize promotional price points and protect brand equity."
  source: "`vibe_consumer_goods_v1`.`promotion`.`promoted_price`"
  dimensions:
    - name: "promoted_price_status"
      expr: promoted_price_status
      comment: "Current status of the promoted price record (e.g. Pending, Approved, Active, Expired)."
    - name: "price_type"
      expr: price_type
      comment: "Type of promoted price (e.g. TPR, EDLP, Feature) for pricing strategy analysis."
    - name: "pricing_strategy_type"
      expr: pricing_strategy_type
      comment: "Pricing strategy applied (e.g. Hi-Lo, EDLP, Value) for strategy effectiveness benchmarking."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the promoted price for governance tracking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which price records are denominated."
    - name: "is_advertised"
      expr: is_advertised
      comment: "Whether the promoted price is advertised. Enables advertised vs non-advertised price performance comparison."
    - name: "effective_start_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the promoted price becomes effective for time-series analysis of pricing activity."
  measures:
    - name: "total_promoted_price_records"
      expr: COUNT(1)
      comment: "Total number of promoted price records. Baseline for promotional pricing portfolio management."
    - name: "avg_promoted_price_amount"
      expr: AVG(CAST(promoted_price_amount AS DOUBLE))
      comment: "Average promoted price amount. Benchmarks promotional price points across SKUs and accounts."
    - name: "avg_regular_price"
      expr: AVG(CAST(regular_price AS DOUBLE))
      comment: "Average regular shelf price. Baseline for calculating promotional price depth."
    - name: "avg_price_reduction_pct"
      expr: AVG(CAST(price_reduction_percentage AS DOUBLE))
      comment: "Average price reduction percentage. Measures promotional depth and price erosion risk across the portfolio."
    - name: "avg_discount_pct"
      expr: AVG(CAST(discount_pct AS DOUBLE))
      comment: "Average discount percentage applied. Monitors promotional intensity and brand equity protection."
    - name: "avg_retailer_margin_pct"
      expr: AVG(CAST(retailer_margin_percentage AS DOUBLE))
      comment: "Average retailer margin percentage at promoted price. Measures retailer profitability of promotional pricing."
    - name: "avg_estimated_volume_lift"
      expr: AVG(CAST(estimated_volume_lift AS DOUBLE))
      comment: "Average estimated volume lift from promoted prices. Measures expected demand elasticity response to promotional pricing."
    - name: "total_promotional_allowance"
      expr: SUM(CAST(promotional_allowance_amount AS DOUBLE))
      comment: "Total promotional allowance amount. Measures trade fund commitment embedded in promotional pricing."
    - name: "avg_scan_back_rate"
      expr: AVG(CAST(scan_back_rate AS DOUBLE))
      comment: "Average scan-back rate across promoted prices. Measures per-unit trade fund rate for scan-based promotions."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`promotion_accrual`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Promotion accrual KPIs — tracks trade spend accrual accuracy, reversal rates, and accrual liability by type to ensure P&L accuracy and financial close quality."
  source: "`vibe_consumer_goods_v1`.`promotion`.`promotion_accrual`"
  dimensions:
    - name: "promotion_accrual_status"
      expr: promotion_accrual_status
      comment: "Current status of the promotion accrual (e.g. Open, Reversed, Settled)."
    - name: "accrual_type"
      expr: accrual_type
      comment: "Type of accrual (e.g. Scan Back, Off-Invoice, Lump Sum) for accrual methodology analysis."
    - name: "accrual_status"
      expr: accrual_status
      comment: "Operational status of the accrual for financial close tracking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which accrual financials are denominated."
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Whether the accrual has been reversed. Identifies reversed accruals for financial accuracy monitoring."
    - name: "accrual_date_month"
      expr: DATE_TRUNC('month', accrual_date)
      comment: "Month of accrual for time-series trending of trade spend liability build-up."
  measures:
    - name: "total_accruals"
      expr: COUNT(1)
      comment: "Total number of promotion accrual records. Baseline for accrual portfolio management."
    - name: "total_accrual_amount"
      expr: SUM(CAST(accrual_amount AS DOUBLE))
      comment: "Total accrued trade spend amount. Core P&L liability metric for financial close and trade spend management."
    - name: "avg_accrual_rate"
      expr: AVG(CAST(accrual_rate AS DOUBLE))
      comment: "Average accrual rate across promotion accruals. Benchmarks trade fund accrual intensity."
    - name: "reversal_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN reversal_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of accruals that have been reversed. High reversal rates indicate accrual accuracy issues requiring process improvement."
    - name: "total_reversed_accrual_amount"
      expr: SUM(CASE WHEN reversal_flag = TRUE THEN CAST(accrual_amount AS DOUBLE) ELSE 0 END)
      comment: "Total accrual amount that has been reversed. Measures the scale of accrual corrections impacting P&L accuracy."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`promotion_deduction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Deduction management KPIs — tracks deduction volumes, dispute rates, settlement efficiency, and financial exposure to manage retailer deduction risk and accelerate resolution cycles."
  source: "`vibe_consumer_goods_v1`.`promotion`.`promotion_deduction`"
  dimensions:
    - name: "deduction_status"
      expr: deduction_status
      comment: "Current status of the deduction (e.g. Open, Disputed, Settled, Written Off) for aging and resolution tracking."
    - name: "deduction_type"
      expr: deduction_type
      comment: "Type of deduction (e.g. Promotional, Shortage, Pricing) for root cause analysis and dispute strategy."
    - name: "deduction_reason_code"
      expr: deduction_reason_code
      comment: "Reason code for the deduction for systematic root cause categorization."
    - name: "dispute_status"
      expr: dispute_status
      comment: "Status of any dispute raised against the deduction for dispute resolution pipeline management."
    - name: "settlement_method"
      expr: settlement_method
      comment: "Method used to settle the deduction (e.g. Credit Memo, Check, Offset) for process efficiency analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which deduction financials are denominated."
    - name: "deduction_date_month"
      expr: DATE_TRUNC('month', deduction_date)
      comment: "Month the deduction was taken, for time-series trending of deduction volumes."
    - name: "promotion_deduction_status"
      expr: promotion_deduction_status
      comment: "Normalized promotion deduction status for workflow reporting."
  measures:
    - name: "total_deductions"
      expr: COUNT(1)
      comment: "Total number of promotion deductions. Baseline for deduction volume management."
    - name: "total_deduction_amount"
      expr: SUM(CAST(deduction_amount AS DOUBLE))
      comment: "Total deduction amount claimed by retailers. Core financial exposure metric for trade spend management."
    - name: "total_approved_amount"
      expr: SUM(CAST(approved_amount AS DOUBLE))
      comment: "Total approved deduction amount. Measures validated trade liability after review."
    - name: "total_disputed_amount"
      expr: SUM(CAST(disputed_amount AS DOUBLE))
      comment: "Total amount under dispute. Measures contested deduction exposure requiring resolution resources."
    - name: "total_settled_amount"
      expr: SUM(CAST(settled_amount AS DOUBLE))
      comment: "Total amount settled across deductions. Measures resolution throughput and cash flow impact."
    - name: "dispute_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(disputed_amount AS DOUBLE)) / NULLIF(SUM(CAST(deduction_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of total deduction amount under dispute. High rates indicate systemic compliance or process issues requiring intervention."
    - name: "settlement_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(settled_amount AS DOUBLE)) / NULLIF(SUM(CAST(deduction_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of total deduction amount that has been settled. Measures resolution efficiency of the deduction management process."
    - name: "avg_roi_impact_amount"
      expr: AVG(CAST(roi_impact_amount AS DOUBLE))
      comment: "Average ROI impact per deduction. Quantifies the profitability drag of unresolved deductions."
    - name: "total_gmroi_impact_pct"
      expr: AVG(CAST(gmroi_impact_percentage AS DOUBLE))
      comment: "Average GMROI impact percentage from deductions. Measures how deductions erode retailer profitability metrics."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`promotion_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational KPIs for individual promotion events — tracks event execution, spend performance, volume lift, and ROI at the event level for post-event learning and in-flight management."
  source: "`vibe_consumer_goods_v1`.`promotion`.`promotion_event`"
  dimensions:
    - name: "event_status"
      expr: event_status
      comment: "Current status of the promotion event (e.g. Planned, Active, Completed, Cancelled) for pipeline tracking."
    - name: "event_type"
      expr: event_type
      comment: "Type of promotion event (e.g. TPR, Display, Feature, BOGO) for mechanic-level performance benchmarking."
    - name: "promotion_event_status"
      expr: promotion_event_status
      comment: "Normalized promotion event status field for workflow state reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which event financials are denominated."
    - name: "geography_code"
      expr: geography_code
      comment: "Geographic scope of the promotion event for regional performance analysis."
    - name: "event_start_month"
      expr: DATE_TRUNC('month', start_date)
      comment: "Month the promotion event starts, enabling time-series analysis of event cadence and spend."
    - name: "post_event_analysis_completed"
      expr: post_event_analysis_completed_flag
      comment: "Flag indicating whether post-event analysis has been completed. Tracks learning loop closure rate."
    - name: "settlement_status"
      expr: settlement_status
      comment: "Settlement status of the promotion event for accounts payable and deduction management."
  measures:
    - name: "total_events"
      expr: COUNT(1)
      comment: "Total number of promotion events. Baseline count for event portfolio management."
    - name: "total_planned_trade_spend"
      expr: SUM(CAST(planned_trade_spend_amount AS DOUBLE))
      comment: "Total planned trade spend committed across promotion events. Core budget planning metric."
    - name: "total_actual_trade_spend"
      expr: SUM(CAST(actual_trade_spend_amount AS DOUBLE))
      comment: "Total actual trade spend incurred across promotion events. Compared against plan for variance analysis."
    - name: "trade_spend_variance"
      expr: SUM((CAST(actual_trade_spend_amount AS DOUBLE)) - (CAST(planned_trade_spend_amount AS DOUBLE)))
      comment: "Variance between actual and planned trade spend at event level. Identifies over/under-execution for corrective action."
    - name: "total_planned_volume_units"
      expr: SUM(CAST(planned_volume_units AS DOUBLE))
      comment: "Total planned promotional volume units across events. Drives demand planning and inventory allocation."
    - name: "total_actual_volume_units"
      expr: SUM(CAST(actual_volume_units AS DOUBLE))
      comment: "Total actual volume units sold during promotion events. Measures volume attainment against plan."
    - name: "volume_attainment_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_volume_units AS DOUBLE)) / NULLIF(SUM(CAST(planned_volume_units AS DOUBLE)), 0), 2)
      comment: "Percentage of planned volume units actually achieved. Key execution effectiveness metric for promotion events."
    - name: "avg_promotional_lift_pct"
      expr: AVG(CAST(promotional_lift_percentage AS DOUBLE))
      comment: "Average promotional volume lift percentage across events. Core measure of promotion effectiveness used in ROI models."
    - name: "avg_roi_pct"
      expr: AVG(CAST(roi_percentage AS DOUBLE))
      comment: "Average ROI percentage across promotion events. Primary metric for evaluating promotion profitability."
    - name: "total_accrual_amount"
      expr: SUM(CAST(accrual_amount AS DOUBLE))
      comment: "Total accrued trade spend liability from promotion events. Critical for financial close and P&L accuracy."
    - name: "total_deduction_amount"
      expr: SUM(CAST(deduction_amount AS DOUBLE))
      comment: "Total deduction amount from promotion events. Tracks retailer deduction exposure for cash flow management."
    - name: "total_rebate_amount"
      expr: SUM(CAST(rebate_amount AS DOUBLE))
      comment: "Total rebate amount associated with promotion events. Tracks rebate liability for financial planning."
    - name: "avg_planned_lift_pct"
      expr: AVG(CAST(planned_lift_pct AS DOUBLE))
      comment: "Average planned lift percentage across events. Benchmark for comparing planned vs actual lift performance."
    - name: "avg_gmroi_ratio"
      expr: AVG(CAST(gmroi_ratio AS DOUBLE))
      comment: "Average Gross Margin Return on Investment ratio across promotion events. Measures retailer profitability of promotions."
    - name: "post_event_analysis_completion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN post_event_analysis_completed_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of completed promotion events that have a post-event analysis. Measures organizational learning discipline."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`promotion_rebate_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rebate agreement KPIs — tracks rebate program structure, tier thresholds, accrual performance, and outstanding balances to manage rebate liability and program effectiveness."
  source: "`vibe_consumer_goods_v1`.`promotion`.`promotion_rebate_agreement`"
  dimensions:
    - name: "promotion_rebate_agreement_status"
      expr: promotion_rebate_agreement_status
      comment: "Current status of the rebate agreement (e.g. Active, Expired, Pending Approval)."
    - name: "rebate_type"
      expr: rebate_type
      comment: "Type of rebate (e.g. Volume, Growth, Compliance) for program mix analysis."
    - name: "tier_structure"
      expr: tier_structure
      comment: "Tier structure of the rebate program (e.g. Single, Multi-Tier) for complexity and liability analysis."
    - name: "payment_frequency"
      expr: payment_frequency
      comment: "Frequency of rebate payments for cash flow planning."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which rebate agreement financials are denominated."
    - name: "measurement_period_type"
      expr: measurement_period_type
      comment: "Period type for rebate measurement (e.g. Monthly, Quarterly, Annual) for program design analysis."
    - name: "effective_start_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the rebate agreement becomes effective for portfolio vintage analysis."
  measures:
    - name: "total_agreements"
      expr: COUNT(1)
      comment: "Total number of rebate agreements. Baseline for rebate program portfolio management."
    - name: "total_accrued_amount"
      expr: SUM(CAST(total_accrued_amount AS DOUBLE))
      comment: "Total accrued rebate amount across agreements. Core liability metric for financial close and P&L management."
    - name: "total_paid_amount"
      expr: SUM(CAST(total_paid_amount AS DOUBLE))
      comment: "Total rebate amount paid out. Measures cash outflow from rebate program execution."
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total outstanding rebate balance unpaid. Measures current rebate liability exposure."
    - name: "avg_rebate_rate_pct"
      expr: AVG(CAST(rebate_rate_pct AS DOUBLE))
      comment: "Average rebate rate percentage across agreements. Benchmarks trade investment intensity through rebate programs."
    - name: "avg_threshold_amount"
      expr: AVG(CAST(threshold_amount AS DOUBLE))
      comment: "Average qualifying threshold amount across rebate agreements. Measures program entry barrier and volume commitment levels."
    - name: "payment_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(total_paid_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_accrued_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of accrued rebates that have been paid. Measures settlement velocity and cash flow execution."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`promotion_rebate_settlement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rebate settlement KPIs — tracks earned rebates, settlement accuracy, qualifying revenue thresholds, and tier achievement to manage rebate program performance and cash flow."
  source: "`vibe_consumer_goods_v1`.`promotion`.`rebate_settlement`"
  dimensions:
    - name: "rebate_settlement_status"
      expr: rebate_settlement_status
      comment: "Current status of the rebate settlement (e.g. Pending, Approved, Paid, Disputed)."
    - name: "settlement_status"
      expr: settlement_status
      comment: "Normalized settlement status for workflow reporting."
    - name: "payment_method"
      expr: payment_method
      comment: "Method of rebate payment (e.g. Check, Credit, Wire) for cash flow planning."
    - name: "tier_achieved"
      expr: tier_achieved
      comment: "Rebate tier achieved by the trade account. Measures program performance and tier attainment distribution."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which rebate financials are denominated."
    - name: "settlement_period"
      expr: settlement_period
      comment: "Settlement period (e.g. Q1 2024) for period-over-period rebate performance analysis."
    - name: "settlement_date_month"
      expr: DATE_TRUNC('month', settlement_date)
      comment: "Month of rebate settlement for time-series cash flow analysis."
  measures:
    - name: "total_settlements"
      expr: COUNT(1)
      comment: "Total number of rebate settlements. Baseline for rebate program activity tracking."
    - name: "total_earned_rebate_amount"
      expr: SUM(CAST(earned_rebate_amount AS DOUBLE))
      comment: "Total earned rebate amount across settlements. Core measure of rebate program liability and retailer incentive realization."
    - name: "total_net_settlement_amount"
      expr: SUM(CAST(net_settlement_amount AS DOUBLE))
      comment: "Total net settlement amount after adjustments. Actual cash outflow from rebate program."
    - name: "total_qualifying_revenue"
      expr: SUM(CAST(qualifying_revenue AS DOUBLE))
      comment: "Total qualifying revenue that earned rebates. Measures the revenue base driving rebate program performance."
    - name: "total_qualifying_volume"
      expr: SUM(CAST(qualifying_volume AS DOUBLE))
      comment: "Total qualifying volume that earned rebates. Measures volume contribution to rebate threshold attainment."
    - name: "avg_rebate_rate"
      expr: AVG(CAST(rebate_rate AS DOUBLE))
      comment: "Average rebate rate across settlements. Benchmarks rebate intensity and program generosity."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total adjustment amount applied to rebate settlements. Measures correction volume indicating data quality or process issues."
    - name: "rebate_as_pct_of_revenue"
      expr: ROUND(100.0 * SUM(CAST(earned_rebate_amount AS DOUBLE)) / NULLIF(SUM(CAST(qualifying_revenue AS DOUBLE)), 0), 2)
      comment: "Earned rebate as a percentage of qualifying revenue. Measures effective rebate rate — key metric for trade investment efficiency."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`promotion_retailer_compliance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Retailer compliance KPIs — measures execution quality of promotional commitments (display, feature, pricing) at store level to identify compliance gaps and recover funding from non-compliant retailers."
  source: "`vibe_consumer_goods_v1`.`promotion`.`retailer_compliance`"
  dimensions:
    - name: "retailer_compliance_status"
      expr: retailer_compliance_status
      comment: "Current status of the compliance record (e.g. Compliant, Non-Compliant, Disputed)."
    - name: "compliance_type"
      expr: compliance_type
      comment: "Type of compliance being measured (e.g. Display, Feature, Pricing, OSA) for execution gap analysis."
    - name: "non_compliance_category"
      expr: non_compliance_category
      comment: "Category of non-compliance for root cause analysis and corrective action targeting."
    - name: "audit_method"
      expr: audit_method
      comment: "Method used to audit compliance (e.g. Field Audit, Photo, POS Data) for data quality stratification."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which compliance financials are denominated."
    - name: "compliance_check_month"
      expr: DATE_TRUNC('month', compliance_check_date)
      comment: "Month of compliance check for time-series trending of execution quality."
    - name: "display_compliant"
      expr: display_compliant_flag
      comment: "Whether display execution was compliant. Enables display-specific compliance analysis."
    - name: "price_compliant"
      expr: price_compliant_flag
      comment: "Whether pricing was compliant. Enables pricing compliance analysis."
  measures:
    - name: "total_compliance_checks"
      expr: COUNT(1)
      comment: "Total number of retailer compliance checks. Baseline for compliance audit coverage."
    - name: "avg_compliance_score"
      expr: AVG(CAST(compliance_score AS DOUBLE))
      comment: "Average retailer compliance score. Primary KPI for measuring execution quality of promotional commitments."
    - name: "avg_compliance_score_pct"
      expr: AVG(CAST(compliance_score_percentage AS DOUBLE))
      comment: "Average compliance score as a percentage. Normalized compliance metric for cross-retailer benchmarking."
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total penalty amount assessed for non-compliance. Measures financial consequence of execution failures."
    - name: "total_funding_adjustment_amount"
      expr: SUM(CAST(funding_adjustment_amount AS DOUBLE))
      comment: "Total funding adjustment from compliance issues. Measures trade fund recovery from non-compliant retailers."
    - name: "display_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN display_compliant_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of checks where display execution was compliant. Measures in-store display execution quality."
    - name: "price_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN price_compliant_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of checks where pricing was compliant. Measures adherence to agreed promotional pricing."
    - name: "ad_feature_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN ad_feature_compliant_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of checks where ad/feature execution was compliant. Measures media and feature execution quality."
    - name: "dispute_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN dispute_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of compliance checks with disputes raised. Measures retailer pushback on compliance assessments."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`promotion_tpo_scenario`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Trade Promotion Optimization scenario KPIs — evaluates scenario planning quality, projected ROI, spend efficiency, and volume projections to support data-driven promotion investment decisions."
  source: "`vibe_consumer_goods_v1`.`promotion`.`tpo_scenario`"
  dimensions:
    - name: "tpo_scenario_status"
      expr: tpo_scenario_status
      comment: "Current status of the TPO scenario (e.g. Draft, Approved, Rejected, Implemented)."
    - name: "scenario_type"
      expr: scenario_type
      comment: "Type of TPO scenario (e.g. Baseline, Optimized, What-If) for scenario mix analysis."
    - name: "scenario_status"
      expr: scenario_status
      comment: "Operational status of the scenario for workflow management."
    - name: "optimization_objective"
      expr: optimization_objective
      comment: "Optimization objective of the scenario (e.g. Maximize ROI, Maximize Volume, Minimize Spend) for strategy alignment."
    - name: "is_recommended"
      expr: is_recommended
      comment: "Whether the scenario is the recommended option. Enables recommended vs alternative scenario comparison."
    - name: "is_baseline_scenario"
      expr: is_baseline_scenario
      comment: "Whether the scenario is the baseline. Enables baseline vs optimized scenario benchmarking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which scenario financials are denominated."
    - name: "planning_horizon_start_month"
      expr: DATE_TRUNC('month', planning_horizon_start_date)
      comment: "Month the planning horizon starts for time-series analysis of scenario planning cycles."
  measures:
    - name: "total_scenarios"
      expr: COUNT(1)
      comment: "Total number of TPO scenarios. Baseline for scenario planning activity and coverage."
    - name: "total_predicted_spend"
      expr: SUM(CAST(predicted_spend_amount AS DOUBLE))
      comment: "Total predicted trade spend across TPO scenarios. Measures planned trade investment in optimization pipeline."
    - name: "total_scenario_spend"
      expr: SUM(CAST(total_scenario_spend AS DOUBLE))
      comment: "Total scenario spend across all TPO scenarios. Comprehensive view of trade investment being evaluated."
    - name: "avg_predicted_roi_pct"
      expr: AVG(CAST(predicted_roi_percentage AS DOUBLE))
      comment: "Average predicted ROI percentage across TPO scenarios. Primary metric for evaluating optimization scenario quality."
    - name: "avg_projected_gmroi"
      expr: AVG(CAST(projected_gmroi AS DOUBLE))
      comment: "Average projected GMROI across scenarios. Measures expected retailer profitability from optimized promotions."
    - name: "total_projected_incremental_revenue"
      expr: SUM(CAST(projected_incremental_revenue AS DOUBLE))
      comment: "Total projected incremental revenue from TPO scenarios. Measures expected top-line value creation from optimized trade investment."
    - name: "total_projected_incremental_volume"
      expr: SUM(CAST(projected_incremental_volume AS DOUBLE))
      comment: "Total projected incremental volume from TPO scenarios. Measures expected volume uplift from optimized promotions."
    - name: "avg_projected_promotional_lift_pct"
      expr: AVG(CAST(projected_promotional_lift_percentage AS DOUBLE))
      comment: "Average projected promotional lift percentage across scenarios. Benchmarks expected effectiveness of optimized promotions."
    - name: "recommended_scenario_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_recommended = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of scenarios marked as recommended. Measures decisiveness of the TPO process."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`promotion_trade_calendar`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for trade calendar planning covering planned spend, event counts, and calendar utilization. Used by Trade Marketing and Sales planning teams to manage annual promotional calendars."
  source: "`vibe_consumer_goods_v1`.`promotion`.`trade_calendar`"
  dimensions:
    - name: "calendar_status"
      expr: calendar_status
      comment: "Current status of the trade calendar (draft, approved, locked) for planning governance."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the calendar for annual planning and year-over-year comparison."
    - name: "calendar_year"
      expr: calendar_year
      comment: "Calendar year for time-based planning analysis."
    - name: "planning_cycle"
      expr: planning_cycle
      comment: "Planning cycle (annual, mid-year, quarterly) for planning process management."
    - name: "event_window_type"
      expr: event_window_type
      comment: "Type of event window (seasonal, everyday, holiday) for promotional timing analysis."
    - name: "season"
      expr: season
      comment: "Season associated with the calendar period for seasonal promotional planning."
    - name: "pricing_strategy"
      expr: pricing_strategy
      comment: "Pricing strategy for the calendar period for strategy-level planning analysis."
    - name: "is_baseline_calendar"
      expr: is_baseline_calendar
      comment: "Flag identifying baseline calendars for comparison against revised plans."
    - name: "region_code"
      expr: region_code
      comment: "Region code for geographic calendar planning analysis."
  measures:
    - name: "total_planned_trade_spend"
      expr: SUM(CAST(total_planned_trade_spend AS DOUBLE))
      comment: "Total planned trade spend across calendars. Primary budget planning KPI for annual trade investment management."
    - name: "calendar_count"
      expr: COUNT(1)
      comment: "Total number of trade calendars. Tracks planning coverage across accounts and regions."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`promotion_trade_promotion`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for trade promotion planning and execution — tracks planned vs actual spend, ROI targets, and promotion portfolio health across brands, accounts, and categories."
  source: "`vibe_consumer_goods_v1`.`promotion`.`trade_promotion`"
  dimensions:
    - name: "trade_promotion_status"
      expr: trade_promotion_status
      comment: "Current lifecycle status of the trade promotion (e.g. Draft, Active, Closed, Cancelled) for pipeline and funnel analysis."
    - name: "promotion_type"
      expr: promotion_type
      comment: "Type of trade promotion mechanic (e.g. TPR, Display, Feature, Coupon) for spend mix analysis."
    - name: "channel_type"
      expr: channel_type
      comment: "Sales channel targeted by the promotion (e.g. Grocery, Mass, Drug) for channel-level ROI benchmarking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which promotion financials are denominated."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status of the promotion for governance and compliance tracking."
    - name: "funding_type"
      expr: funding_type
      comment: "Source of funding for the promotion (e.g. Manufacturer, Co-op, Retailer) to attribute spend correctly."
    - name: "promotion_start_date"
      expr: DATE_TRUNC('month', start_date)
      comment: "Month the promotion starts, used for time-series trending of promotion launches."
    - name: "promotion_end_date"
      expr: DATE_TRUNC('month', end_date)
      comment: "Month the promotion ends, used for cohort analysis of promotion duration."
  measures:
    - name: "total_promotions"
      expr: COUNT(1)
      comment: "Total number of trade promotions in the portfolio. Baseline volume metric for promotion pipeline management."
    - name: "total_planned_spend"
      expr: SUM(CAST(planned_spend AS DOUBLE))
      comment: "Total planned trade spend across all promotions. Core budget commitment metric used in annual trade planning."
    - name: "total_actual_spend"
      expr: SUM(CAST(actual_spend AS DOUBLE))
      comment: "Total actual trade spend incurred. Compared against planned spend to assess budget adherence."
    - name: "total_authorized_budget"
      expr: SUM(CAST(authorized_budget_amount AS DOUBLE))
      comment: "Total authorized budget allocated to trade promotions. Governance ceiling for spend approval."
    - name: "spend_variance"
      expr: SUM((CAST(actual_spend AS DOUBLE)) - (CAST(planned_spend AS DOUBLE)))
      comment: "Difference between actual and planned trade spend. Positive values indicate overspend; negative values indicate underspend. Key financial control metric."
    - name: "avg_expected_roi_pct"
      expr: AVG(CAST(expected_roi_percentage AS DOUBLE))
      comment: "Average expected ROI percentage across promotions. Used in pre-event planning to screen promotions against ROI thresholds."
    - name: "total_planned_volume"
      expr: SUM(CAST(planned_volume AS DOUBLE))
      comment: "Total planned volume units committed across trade promotions. Drives supply chain and inventory planning."
    - name: "total_target_volume_units"
      expr: SUM(CAST(target_volume_units AS DOUBLE))
      comment: "Total target volume units set for trade promotions. Benchmark for measuring promotional volume attainment."
    - name: "total_deduction_amount"
      expr: SUM(CAST(deduction_amount AS DOUBLE))
      comment: "Total deduction amount associated with trade promotions. Tracks retailer deduction exposure for cash flow management."
    - name: "total_accrual_amount"
      expr: SUM(CAST(accrual_amount AS DOUBLE))
      comment: "Total accrued trade spend liability. Critical for P&L accuracy and financial close processes."
    - name: "spend_utilization_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_spend AS DOUBLE)) / NULLIF(SUM(CAST(authorized_budget_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of authorized budget actually spent. Measures budget utilization efficiency; low values indicate under-execution, high values indicate budget risk."
    - name: "avg_discount_pct"
      expr: AVG(CAST(discount_pct AS DOUBLE))
      comment: "Average promotional discount depth across trade promotions. Monitors price erosion risk and promotional intensity."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`promotion_trade_spend_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Trade spend allocation KPIs — tracks how trade funds are allocated, committed, and spent across promotions, brands, and accounts to ensure optimal fund deployment and financial control."
  source: "`vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation`"
  dimensions:
    - name: "trade_spend_allocation_status"
      expr: trade_spend_allocation_status
      comment: "Current status of the trade spend allocation (e.g. Planned, Committed, Settled)."
    - name: "allocation_type"
      expr: allocation_type
      comment: "Type of trade spend allocation (e.g. Fixed, Variable, Performance) for fund type analysis."
    - name: "spend_category"
      expr: spend_category
      comment: "Category of trade spend (e.g. Display, Feature, TPR, Slotting) for spend mix analysis."
    - name: "spend_type"
      expr: spend_type
      comment: "Type of spend (e.g. Accrual, Fixed, Scan) for accounting treatment analysis."
    - name: "fund_type"
      expr: fund_type
      comment: "Fund type for the allocation (e.g. Co-op, Promotional, Slotting) for fund source analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which allocation financials are denominated."
    - name: "allocation_date_month"
      expr: DATE_TRUNC('month', allocation_date)
      comment: "Month of allocation for time-series trending of trade spend deployment."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the allocation for period-over-period financial analysis."
  measures:
    - name: "total_allocations"
      expr: COUNT(1)
      comment: "Total number of trade spend allocations. Baseline for allocation portfolio management."
    - name: "total_allocated_amount"
      expr: SUM(CAST(allocated_amount AS DOUBLE))
      comment: "Total trade spend allocated. Core budget commitment metric for trade fund management."
    - name: "total_committed_amount"
      expr: SUM(CAST(committed_amount AS DOUBLE))
      comment: "Total committed trade spend. Measures firm financial obligations from trade allocations."
    - name: "total_actual_amount"
      expr: SUM(CAST(actual_amount AS DOUBLE))
      comment: "Total actual trade spend incurred. Compared against allocated amount for variance analysis."
    - name: "total_spent_amount"
      expr: SUM(CAST(spent_amount AS DOUBLE))
      comment: "Total amount spent from trade allocations. Measures execution of committed trade funds."
    - name: "total_settlement_amount"
      expr: SUM(CAST(settlement_amount AS DOUBLE))
      comment: "Total settlement amount from trade spend allocations. Measures cash outflow from trade fund execution."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total variance between allocated and actual trade spend. Identifies systematic over/under-execution patterns."
    - name: "total_accrual_amount"
      expr: SUM(CAST(accrual_amount AS DOUBLE))
      comment: "Total accrued trade spend from allocations. Critical for P&L accuracy and financial close."
    - name: "spend_execution_pct"
      expr: ROUND(100.0 * SUM(CAST(spent_amount AS DOUBLE)) / NULLIF(SUM(CAST(allocated_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of allocated trade spend actually executed. Measures fund utilization efficiency — low values indicate under-execution risk."
    - name: "avg_roi_pct"
      expr: AVG(CAST(roi_percentage AS DOUBLE))
      comment: "Average ROI percentage across trade spend allocations. Measures return on trade investment at allocation level."
    - name: "avg_gmroi_pct"
      expr: AVG(CAST(gmroi_percentage AS DOUBLE))
      comment: "Average GMROI percentage across trade spend allocations. Measures retailer profitability of allocated trade funds."
$$;
