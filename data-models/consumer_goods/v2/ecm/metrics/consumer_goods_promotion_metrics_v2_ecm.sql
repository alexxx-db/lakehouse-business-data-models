-- Metric views for domain: promotion | Business: Consumer_Goods | Version: 2 | Generated on: 2026-07-10 13:28:51

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`promotion_trade_promotion`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for trade promotion planning and financial performance. Covers authorized budget, accruals, deductions, discount depth, and ROI targets across promotions by brand, account, channel, and status."
  source: "`vibe_consumer_goods_v1`.`promotion`.`trade_promotion`"
  dimensions:
    - name: "promotion_status"
      expr: promotion_status
      comment: "Current lifecycle status of the trade promotion (e.g. planned, active, closed, cancelled)."
    - name: "promotion_type"
      expr: promotion_type
      comment: "Type of trade promotion (e.g. scan-back, off-invoice, display allowance)."
    - name: "channel_type"
      expr: channel_type
      comment: "Retail channel type targeted by the promotion (e.g. grocery, mass, club)."
    - name: "funding_type"
      expr: funding_type
      comment: "Source of funding for the promotion (e.g. manufacturer-funded, co-funded)."
    - name: "pricing_strategy"
      expr: pricing_strategy
      comment: "Pricing strategy applied in the promotion (e.g. EDLP, hi-lo)."
    - name: "country_code"
      expr: country_code
      comment: "Country where the promotion is executed."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the promotion (e.g. national, regional)."
    - name: "start_date"
      expr: start_date
      comment: "Promotion start date for time-series analysis."
    - name: "end_date"
      expr: end_date
      comment: "Promotion end date for duration and period analysis."
    - name: "coupon_flag"
      expr: coupon_flag
      comment: "Indicates whether the promotion includes a coupon mechanic."
    - name: "feature_ad_flag"
      expr: feature_ad_flag
      comment: "Indicates whether the promotion includes a feature advertisement."
    - name: "settlement_status"
      expr: settlement_status
      comment: "Current settlement status of the trade promotion."
  measures:
    - name: "total_promotions"
      expr: COUNT(DISTINCT trade_promotion_id)
      comment: "Total number of distinct trade promotions. Baseline volume metric for promotion portfolio sizing."
    - name: "total_authorized_budget"
      expr: SUM(CAST(authorized_budget_amount AS DOUBLE))
      comment: "Total authorized trade spend budget across promotions. Core financial planning KPI for trade investment governance."
    - name: "total_accrual_amount"
      expr: SUM(CAST(accrual_amount AS DOUBLE))
      comment: "Total accrued trade spend liability. Tracks financial exposure and liability recognition for promotions."
    - name: "total_deduction_amount"
      expr: SUM(CAST(deduction_amount AS DOUBLE))
      comment: "Total deduction amount claimed against trade promotions. Drives cash flow and settlement management decisions."
    - name: "total_target_volume_units"
      expr: SUM(CAST(target_volume_units AS DOUBLE))
      comment: "Total planned volume units targeted across trade promotions. Used to assess promotional volume ambition vs. actuals."
    - name: "total_baseline_volume_units"
      expr: SUM(CAST(baseline_volume_units AS DOUBLE))
      comment: "Total baseline (non-promoted) volume units used as the benchmark for incremental lift measurement."
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average promotional discount depth across promotions. Monitors price reduction intensity and margin risk."
    - name: "avg_expected_roi_percentage"
      expr: AVG(CAST(expected_roi_percentage AS DOUBLE))
      comment: "Average expected ROI percentage across trade promotions. Key planning KPI for evaluating promotion investment quality."
    - name: "budget_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(accrual_amount AS DOUBLE)) / NULLIF(SUM(CAST(authorized_budget_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of authorized budget that has been accrued. Measures trade spend execution efficiency and budget consumption pace."
    - name: "deduction_to_budget_ratio"
      expr: ROUND(100.0 * SUM(CAST(deduction_amount AS DOUBLE)) / NULLIF(SUM(CAST(authorized_budget_amount AS DOUBLE)), 0), 2)
      comment: "Deduction amount as a percentage of authorized budget. Signals deduction leakage risk relative to planned investment."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`promotion_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and financial KPIs for individual promotion events. Covers planned vs. actual trade spend, volume lift, ROI, accruals, and settlement performance at the event level."
  source: "`vibe_consumer_goods_v1`.`promotion`.`promotion_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of promotion event (e.g. display, feature, price reduction, BOGO)."
    - name: "event_status"
      expr: event_status
      comment: "Current lifecycle status of the promotion event."
    - name: "settlement_status"
      expr: settlement_status
      comment: "Settlement status of the promotion event."
    - name: "funding_source"
      expr: funding_source
      comment: "Funding source for the promotion event (e.g. manufacturer, retailer co-fund)."
    - name: "pricing_strategy"
      expr: pricing_strategy
      comment: "Pricing strategy applied during the event."
    - name: "geography_code"
      expr: geography_code
      comment: "Geographic code where the event is executed."
    - name: "start_date"
      expr: start_date
      comment: "Event start date for time-series and period analysis."
    - name: "end_date"
      expr: end_date
      comment: "Event end date for duration analysis."
    - name: "post_event_analysis_completed_flag"
      expr: post_event_analysis_completed_flag
      comment: "Indicates whether post-event analysis has been completed for this event."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which financial amounts are denominated."
  measures:
    - name: "total_events"
      expr: COUNT(DISTINCT promotion_event_id)
      comment: "Total number of distinct promotion events. Baseline measure for event portfolio volume."
    - name: "total_planned_trade_spend"
      expr: SUM(CAST(planned_trade_spend_amount AS DOUBLE))
      comment: "Total planned trade spend investment across promotion events. Core financial planning KPI."
    - name: "total_actual_trade_spend"
      expr: SUM(CAST(actual_trade_spend_amount AS DOUBLE))
      comment: "Total actual trade spend incurred across promotion events. Tracks realized financial investment."
    - name: "trade_spend_variance"
      expr: SUM((CAST(actual_trade_spend_amount AS DOUBLE)) - (CAST(planned_trade_spend_amount AS DOUBLE)))
      comment: "Absolute variance between actual and planned trade spend. Negative values indicate underspend; positive values indicate overspend."
    - name: "trade_spend_variance_pct"
      expr: ROUND(100.0 * (SUM(CAST(actual_trade_spend_amount AS DOUBLE)) - SUM(CAST(planned_trade_spend_amount AS DOUBLE))) / NULLIF(SUM(CAST(planned_trade_spend_amount AS DOUBLE)), 0), 2)
      comment: "Percentage variance of actual vs. planned trade spend. Key budget control KPI for trade investment governance."
    - name: "total_planned_volume_units"
      expr: SUM(CAST(planned_volume_units AS DOUBLE))
      comment: "Total planned promotional volume units across events."
    - name: "total_actual_volume_units"
      expr: SUM(CAST(actual_volume_units AS DOUBLE))
      comment: "Total actual promotional volume units sold during events."
    - name: "volume_attainment_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_volume_units AS DOUBLE)) / NULLIF(SUM(CAST(planned_volume_units AS DOUBLE)), 0), 2)
      comment: "Actual volume as a percentage of planned volume. Measures promotional volume execution effectiveness."
    - name: "total_accrual_amount"
      expr: SUM(CAST(accrual_amount AS DOUBLE))
      comment: "Total accrued trade liability across promotion events."
    - name: "total_deduction_amount"
      expr: SUM(CAST(deduction_amount AS DOUBLE))
      comment: "Total deduction amount associated with promotion events."
    - name: "total_rebate_amount"
      expr: SUM(CAST(rebate_amount AS DOUBLE))
      comment: "Total rebate amount earned or paid across promotion events."
    - name: "avg_roi_percentage"
      expr: AVG(CAST(roi_percentage AS DOUBLE))
      comment: "Average return on investment percentage across promotion events. Strategic KPI for evaluating promotion profitability."
    - name: "avg_gmroi_ratio"
      expr: AVG(CAST(gmroi_ratio AS DOUBLE))
      comment: "Average Gross Margin Return on Investment ratio across events. Measures trade spend efficiency relative to gross margin generated."
    - name: "avg_promotional_lift_percentage"
      expr: AVG(CAST(promotional_lift_percentage AS DOUBLE))
      comment: "Average incremental volume lift percentage driven by promotion events. Core effectiveness KPI."
    - name: "post_event_analysis_completion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN post_event_analysis_completed_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of promotion events with completed post-event analysis. Measures organizational learning discipline."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`promotion_event_sku`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SKU-level promotion execution KPIs. Covers promotional volume, pricing, trade spend, lift, ROI, and compliance at the event-SKU intersection — the most granular level of promotion performance."
  source: "`vibe_consumer_goods_v1`.`promotion`.`event_sku`"
  dimensions:
    - name: "compliance_check_status"
      expr: compliance_check_status
      comment: "Compliance check status for the promoted SKU (e.g. compliant, non-compliant, pending)."
    - name: "settlement_status"
      expr: settlement_status
      comment: "Settlement status for the event-SKU record."
    - name: "display_location_type"
      expr: display_location_type
      comment: "Type of in-store display location used for the promoted SKU."
    - name: "feature_type"
      expr: feature_type
      comment: "Type of feature advertisement associated with the promoted SKU."
    - name: "promoted_price_type"
      expr: promoted_price_type
      comment: "Type of promoted price mechanic applied (e.g. scan-back, off-invoice, TPR)."
    - name: "pricing_approval_status"
      expr: pricing_approval_status
      comment: "Approval status of the promoted price for this SKU."
    - name: "is_featured_sku"
      expr: is_featured_sku
      comment: "Indicates whether this SKU is a featured item in the promotion."
    - name: "promotion_effective_start_date"
      expr: promotion_effective_start_date
      comment: "Effective start date of the promotion for this SKU."
    - name: "promotion_effective_end_date"
      expr: promotion_effective_end_date
      comment: "Effective end date of the promotion for this SKU."
  measures:
    - name: "total_event_sku_records"
      expr: COUNT(DISTINCT event_sku_id)
      comment: "Total number of distinct event-SKU combinations. Measures breadth of SKU participation in promotions."
    - name: "total_actual_promotional_volume_units"
      expr: SUM(CAST(actual_promotional_volume_units AS DOUBLE))
      comment: "Total actual promotional volume in units sold across event-SKU records. Core volume execution KPI."
    - name: "total_planned_promotional_volume_units"
      expr: SUM(CAST(planned_promotional_volume_units AS DOUBLE))
      comment: "Total planned promotional volume in units across event-SKU records."
    - name: "total_actual_promotional_volume_cases"
      expr: SUM(CAST(actual_promotional_volume_cases AS DOUBLE))
      comment: "Total actual promotional volume in cases. Used for logistics and supply chain planning."
    - name: "volume_attainment_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_promotional_volume_units AS DOUBLE)) / NULLIF(SUM(CAST(planned_promotional_volume_units AS DOUBLE)), 0), 2)
      comment: "Actual promotional volume as a percentage of planned volume at SKU level. Measures SKU-level execution effectiveness."
    - name: "total_incremental_lift_volume_units"
      expr: SUM(CAST(incremental_lift_volume_units AS DOUBLE))
      comment: "Total incremental volume units generated above baseline by the promotion. Core measure of promotional effectiveness."
    - name: "avg_incremental_lift_percent"
      expr: AVG(CAST(incremental_lift_percent AS DOUBLE))
      comment: "Average incremental lift percentage across promoted SKUs. Strategic KPI for evaluating promotion ROI at SKU level."
    - name: "total_trade_spend_amount"
      expr: SUM(CAST(total_trade_spend_amount AS DOUBLE))
      comment: "Total trade spend invested at the event-SKU level. Drives trade investment allocation decisions."
    - name: "total_deduction_amount"
      expr: SUM(CAST(deduction_amount AS DOUBLE))
      comment: "Total deduction amount at the event-SKU level."
    - name: "total_accrual_amount"
      expr: SUM(CAST(accrual_amount AS DOUBLE))
      comment: "Total accrual amount at the event-SKU level."
    - name: "total_rebate_amount"
      expr: SUM(CAST(rebate_amount AS DOUBLE))
      comment: "Total rebate amount at the event-SKU level."
    - name: "avg_promotional_gmroi"
      expr: AVG(CAST(promotional_gmroi AS DOUBLE))
      comment: "Average Gross Margin Return on Investment for promoted SKUs. Measures trade spend efficiency per SKU."
    - name: "avg_promotional_roi_percent"
      expr: AVG(CAST(promotional_roi_percent AS DOUBLE))
      comment: "Average promotional ROI percentage at the SKU level. Key profitability KPI for SKU-level trade investment decisions."
    - name: "avg_price_reduction_depth_percent"
      expr: AVG(CAST(price_reduction_depth_percent AS DOUBLE))
      comment: "Average price reduction depth percentage across promoted SKUs. Monitors margin erosion risk from promotional pricing."
    - name: "avg_promotional_discount_per_unit"
      expr: AVG(CAST(promotional_discount_per_unit AS DOUBLE))
      comment: "Average per-unit promotional discount amount. Used to assess unit economics of trade promotions."
    - name: "compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN compliance_check_status = 'compliant' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of event-SKU records with compliant status. Measures retailer execution compliance for promoted SKUs."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`promotion_deduction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial KPIs for trade promotion deductions. Covers deduction volume, dispute rates, settlement efficiency, and financial impact — critical for accounts receivable and trade spend governance."
  source: "`vibe_consumer_goods_v1`.`promotion`.`promotion_deduction`"
  dimensions:
    - name: "deduction_type"
      expr: deduction_type
      comment: "Type of deduction (e.g. promotional allowance, shortage, pricing dispute)."
    - name: "deduction_source"
      expr: deduction_source
      comment: "Source system or channel from which the deduction originated."
    - name: "dispute_status"
      expr: dispute_status
      comment: "Current dispute status of the deduction (e.g. open, resolved, escalated)."
    - name: "settlement_method"
      expr: settlement_method
      comment: "Method used to settle the deduction (e.g. credit memo, check, offset)."
    - name: "settlement_reason_code"
      expr: settlement_reason_code
      comment: "Reason code for the deduction settlement."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level assigned to the deduction for resolution workflow."
    - name: "deduction_date"
      expr: deduction_date
      comment: "Date the deduction was claimed, for time-series analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which deduction amounts are denominated."
    - name: "accrual_impact_flag"
      expr: accrual_impact_flag
      comment: "Indicates whether the deduction has an accrual accounting impact."
  measures:
    - name: "total_deductions"
      expr: COUNT(DISTINCT promotion_deduction_id)
      comment: "Total number of distinct deduction records. Baseline measure for deduction volume management."
    - name: "total_deduction_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total gross deduction amount claimed. Core financial exposure KPI for trade spend governance."
    - name: "total_approved_amount"
      expr: SUM(CAST(approved_amount AS DOUBLE))
      comment: "Total approved deduction amount. Measures validated trade liability."
    - name: "total_disputed_amount"
      expr: SUM(CAST(disputed_amount AS DOUBLE))
      comment: "Total amount under dispute. Tracks financial risk in the deduction portfolio."
    - name: "total_settled_amount"
      expr: SUM(CAST(settled_amount AS DOUBLE))
      comment: "Total amount that has been settled. Measures deduction resolution throughput."
    - name: "dispute_rate"
      expr: ROUND(100.0 * SUM(CAST(disputed_amount AS DOUBLE)) / NULLIF(SUM(CAST(amount AS DOUBLE)), 0), 2)
      comment: "Disputed amount as a percentage of total deduction amount. Key risk KPI — high dispute rates signal process or relationship issues with retailers."
    - name: "settlement_rate"
      expr: ROUND(100.0 * SUM(CAST(settled_amount AS DOUBLE)) / NULLIF(SUM(CAST(amount AS DOUBLE)), 0), 2)
      comment: "Settled amount as a percentage of total deduction amount. Measures deduction resolution efficiency."
    - name: "approval_rate"
      expr: ROUND(100.0 * SUM(CAST(approved_amount AS DOUBLE)) / NULLIF(SUM(CAST(amount AS DOUBLE)), 0), 2)
      comment: "Approved amount as a percentage of total claimed deduction amount. Measures validity of retailer deduction claims."
    - name: "avg_gmroi_impact_percentage"
      expr: AVG(CAST(gmroi_impact_percentage AS DOUBLE))
      comment: "Average GMROI impact percentage from deductions. Quantifies the margin erosion effect of deduction activity."
    - name: "total_roi_impact_amount"
      expr: SUM(CAST(roi_impact_amount AS DOUBLE))
      comment: "Total ROI impact amount from deductions. Measures the financial drag on promotion ROI from deduction activity."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`promotion_deduction_settlement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for deduction settlement processing. Tracks settlement cycle times, approval rates, dispute resolution, and financial throughput — critical for cash flow and trade spend closure."
  source: "`vibe_consumer_goods_v1`.`promotion`.`deduction_settlement`"
  dimensions:
    - name: "settlement_status"
      expr: settlement_status
      comment: "Current status of the deduction settlement (e.g. pending, approved, rejected, paid)."
    - name: "settlement_method"
      expr: settlement_method
      comment: "Method used to settle the deduction (e.g. credit memo, wire transfer, offset)."
    - name: "settlement_reason_code"
      expr: settlement_reason_code
      comment: "Reason code categorizing the settlement outcome."
    - name: "dispute_resolution_method"
      expr: dispute_resolution_method
      comment: "Method used to resolve disputes within the settlement process."
    - name: "is_partial_settlement"
      expr: is_partial_settlement
      comment: "Indicates whether the settlement is partial (not full resolution of the deduction)."
    - name: "sla_compliance_flag"
      expr: sla_compliance_flag
      comment: "Indicates whether the settlement was completed within SLA timeframes."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the settlement for period-based financial reporting."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the settlement for granular financial reporting."
    - name: "settlement_date"
      expr: settlement_date
      comment: "Date the settlement was completed."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which settlement amounts are denominated."
  measures:
    - name: "total_settlements"
      expr: COUNT(DISTINCT deduction_settlement_id)
      comment: "Total number of deduction settlements processed. Baseline throughput measure."
    - name: "total_deduction_claimed_amount"
      expr: SUM(CAST(deduction_claimed_amount AS DOUBLE))
      comment: "Total deduction amount claimed by retailers. Gross financial exposure measure."
    - name: "total_approved_amount"
      expr: SUM(CAST(approved_amount AS DOUBLE))
      comment: "Total approved settlement amount. Measures validated trade liability resolved."
    - name: "total_settled_amount"
      expr: SUM(CAST(settled_amount AS DOUBLE))
      comment: "Total amount actually settled and paid. Core cash flow KPI for trade spend closure."
    - name: "total_disputed_amount"
      expr: SUM(CAST(disputed_amount AS DOUBLE))
      comment: "Total amount under dispute in settlements. Tracks unresolved financial risk."
    - name: "settlement_approval_rate"
      expr: ROUND(100.0 * SUM(CAST(approved_amount AS DOUBLE)) / NULLIF(SUM(CAST(deduction_claimed_amount AS DOUBLE)), 0), 2)
      comment: "Approved amount as a percentage of claimed amount. Measures the validity acceptance rate of retailer deduction claims."
    - name: "dispute_rate"
      expr: ROUND(100.0 * SUM(CAST(disputed_amount AS DOUBLE)) / NULLIF(SUM(CAST(deduction_claimed_amount AS DOUBLE)), 0), 2)
      comment: "Disputed amount as a percentage of total claimed amount. High rates signal retailer relationship or process issues."
    - name: "sla_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN sla_compliance_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of settlements completed within SLA. Operational efficiency KPI for the deduction management process."
    - name: "partial_settlement_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_partial_settlement = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of settlements that are partial. High rates indicate unresolved deduction balances and cash flow risk."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`promotion_accrual`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial KPIs for trade promotion accruals. Tracks accrual amounts, ROI, GMROI, volume, and dispute rates — essential for accurate P&L recognition and trade liability management."
  source: "`vibe_consumer_goods_v1`.`promotion`.`promotion_accrual`"
  dimensions:
    - name: "accrual_type"
      expr: accrual_type
      comment: "Type of accrual (e.g. scan-back, off-invoice, lump sum)."
    - name: "accrual_status"
      expr: accrual_status
      comment: "Current status of the accrual record (e.g. open, reversed, settled)."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the accrual."
    - name: "is_disputed"
      expr: is_disputed
      comment: "Indicates whether the accrual is under dispute."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the accrual for period-based financial reporting."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the accrual for granular P&L analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which accrual amounts are denominated."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for volume-based accrual calculations."
    - name: "recognition_date"
      expr: recognition_date
      comment: "Date the accrual was recognized in the P&L."
  measures:
    - name: "total_accruals"
      expr: COUNT(DISTINCT promotion_accrual_id)
      comment: "Total number of accrual records. Baseline measure for accrual portfolio volume."
    - name: "total_accrual_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total accrued trade spend amount. Core P&L liability KPI for trade investment recognition."
    - name: "total_incremental_volume"
      expr: SUM(CAST(incremental_volume AS DOUBLE))
      comment: "Total incremental volume units attributed to accrued promotions."
    - name: "total_baseline_volume"
      expr: SUM(CAST(baseline_volume AS DOUBLE))
      comment: "Total baseline volume units used as the benchmark for accrual-linked promotions."
    - name: "total_quantity_sold"
      expr: SUM(CAST(quantity_sold AS DOUBLE))
      comment: "Total quantity sold under accrual-linked promotions."
    - name: "avg_roi_percentage"
      expr: AVG(CAST(roi_percentage AS DOUBLE))
      comment: "Average ROI percentage across accrual records. Measures the return generated per dollar of accrued trade spend."
    - name: "avg_gmroi"
      expr: AVG(CAST(gmroi AS DOUBLE))
      comment: "Average Gross Margin Return on Investment across accruals. Strategic KPI for trade investment profitability."
    - name: "avg_accrual_rate"
      expr: AVG(CAST(rate AS DOUBLE))
      comment: "Average accrual rate applied across records. Used to benchmark rate consistency and identify outliers."
    - name: "dispute_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_disputed = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of accrual records under dispute. High rates signal process or retailer relationship issues."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`promotion_lift_measurement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Statistical KPIs for promotional lift measurement. Covers incremental volume, revenue lift, cannibalization, halo effects, and statistical significance — the scientific backbone of promotion effectiveness evaluation."
  source: "`vibe_consumer_goods_v1`.`promotion`.`lift_measurement`"
  dimensions:
    - name: "measurement_methodology"
      expr: measurement_methodology
      comment: "Methodology used to measure promotional lift (e.g. matched market, regression, test-control)."
    - name: "lift_source"
      expr: lift_source
      comment: "Data source used for lift measurement (e.g. POS scanner, panel data, syndicated)."
    - name: "measurement_status"
      expr: measurement_status
      comment: "Current status of the lift measurement (e.g. preliminary, validated, final)."
    - name: "statistical_significance_flag"
      expr: statistical_significance_flag
      comment: "Indicates whether the measured lift is statistically significant."
    - name: "baseline_calculation_method"
      expr: baseline_calculation_method
      comment: "Method used to calculate the baseline volume for lift comparison."
    - name: "measurement_week_start_date"
      expr: measurement_week_start_date
      comment: "Start date of the measurement week for time-series analysis."
    - name: "measurement_week_end_date"
      expr: measurement_week_end_date
      comment: "End date of the measurement week."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which revenue measures are denominated."
  measures:
    - name: "total_lift_measurements"
      expr: COUNT(DISTINCT lift_measurement_id)
      comment: "Total number of lift measurement records. Baseline measure for measurement coverage."
    - name: "total_incremental_lift_units"
      expr: SUM(CAST(incremental_lift_units AS DOUBLE))
      comment: "Total incremental volume units generated above baseline across all measured promotions. Core effectiveness KPI."
    - name: "total_incremental_revenue"
      expr: SUM(CAST(incremental_revenue AS DOUBLE))
      comment: "Total incremental revenue generated by promotions above baseline. Strategic financial KPI for promotion ROI."
    - name: "total_actual_promoted_volume_units"
      expr: SUM(CAST(actual_promoted_volume_units AS DOUBLE))
      comment: "Total actual promoted volume units sold during measured promotion periods."
    - name: "total_baseline_volume_units"
      expr: SUM(CAST(baseline_volume_units AS DOUBLE))
      comment: "Total baseline volume units used as the non-promoted benchmark."
    - name: "avg_incremental_lift_percentage"
      expr: AVG(CAST(incremental_lift_percentage AS DOUBLE))
      comment: "Average incremental lift percentage across measured promotions. Primary KPI for promotion effectiveness benchmarking."
    - name: "avg_cannibalization_rate"
      expr: AVG(CAST(cannibalization_rate AS DOUBLE))
      comment: "Average cannibalization rate across promotions. Measures the degree to which promoted SKUs cannibalize other products."
    - name: "total_halo_effect_units"
      expr: SUM(CAST(halo_effect_units AS DOUBLE))
      comment: "Total halo effect volume units — incremental volume on non-promoted items driven by the promotion."
    - name: "total_post_promotion_dip_units"
      expr: SUM(CAST(post_promotion_dip_units AS DOUBLE))
      comment: "Total post-promotion volume dip units — demand pulled forward from future periods. Measures pantry-loading risk."
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average promotional discount depth across measured events."
    - name: "statistical_significance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN statistical_significance_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of lift measurements that are statistically significant. Measures the scientific rigor of the promotion measurement program."
    - name: "avg_p_value"
      expr: AVG(CAST(p_value AS DOUBLE))
      comment: "Average p-value across lift measurements. Lower values indicate stronger statistical evidence of promotional lift."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`promotion_post_event_analysis`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Post-event analysis KPIs for completed promotions. Covers actual vs. planned trade spend, volume attainment, ROI, GMROI, compliance, and sell-through — the definitive scorecard for promotion performance."
  source: "`vibe_consumer_goods_v1`.`promotion`.`post_event_analysis`"
  dimensions:
    - name: "analysis_status"
      expr: analysis_status
      comment: "Current status of the post-event analysis (e.g. draft, completed, approved)."
    - name: "learning_classification"
      expr: learning_classification
      comment: "Classification of the key learning from the post-event analysis (e.g. winner, loser, neutral)."
    - name: "baseline_estimation_methodology"
      expr: baseline_estimation_methodology
      comment: "Methodology used to estimate the baseline volume for the post-event analysis."
    - name: "lift_measurement_methodology"
      expr: lift_measurement_methodology
      comment: "Methodology used to measure lift in the post-event analysis."
    - name: "display_compliance_flag"
      expr: display_compliance_flag
      comment: "Indicates whether display compliance was achieved during the promotion."
    - name: "feature_compliance_flag"
      expr: feature_compliance_flag
      comment: "Indicates whether feature ad compliance was achieved."
    - name: "pricing_compliance_flag"
      expr: pricing_compliance_flag
      comment: "Indicates whether pricing compliance was achieved."
    - name: "analysis_period_start_date"
      expr: analysis_period_start_date
      comment: "Start date of the post-event analysis period."
    - name: "analysis_period_end_date"
      expr: analysis_period_end_date
      comment: "End date of the post-event analysis period."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which financial amounts are denominated."
  measures:
    - name: "total_analyses"
      expr: COUNT(DISTINCT post_event_analysis_id)
      comment: "Total number of post-event analyses completed. Measures organizational learning coverage."
    - name: "total_actual_trade_spend"
      expr: SUM(CAST(actual_trade_spend_amount AS DOUBLE))
      comment: "Total actual trade spend incurred across analyzed promotion events."
    - name: "total_planned_trade_spend"
      expr: SUM(CAST(planned_trade_spend_amount AS DOUBLE))
      comment: "Total planned trade spend for analyzed promotion events."
    - name: "trade_spend_variance"
      expr: SUM((CAST(actual_trade_spend_amount AS DOUBLE)) - (CAST(planned_trade_spend_amount AS DOUBLE)))
      comment: "Absolute variance between actual and planned trade spend across post-event analyses."
    - name: "trade_spend_variance_pct"
      expr: ROUND(100.0 * (SUM(CAST(actual_trade_spend_amount AS DOUBLE)) - SUM(CAST(planned_trade_spend_amount AS DOUBLE))) / NULLIF(SUM(CAST(planned_trade_spend_amount AS DOUBLE)), 0), 2)
      comment: "Percentage variance of actual vs. planned trade spend. Key budget accuracy KPI."
    - name: "total_incremental_lift_units"
      expr: SUM(CAST(incremental_lift_units AS DOUBLE))
      comment: "Total incremental volume units generated above baseline across analyzed events."
    - name: "avg_incremental_lift_percentage"
      expr: AVG(CAST(incremental_lift_percentage AS DOUBLE))
      comment: "Average incremental lift percentage across post-event analyses. Core effectiveness benchmark."
    - name: "avg_promotional_roi"
      expr: AVG(CAST(promotional_roi AS DOUBLE))
      comment: "Average promotional ROI across analyzed events. Primary financial performance KPI for promotion portfolio."
    - name: "avg_gmroi"
      expr: AVG(CAST(gmroi AS DOUBLE))
      comment: "Average Gross Margin Return on Investment across analyzed events."
    - name: "avg_sell_through_rate"
      expr: AVG(CAST(sell_through_rate AS DOUBLE))
      comment: "Average sell-through rate across analyzed promotions. Measures inventory efficiency during promotional periods."
    - name: "avg_retailer_compliance_score"
      expr: AVG(CAST(retailer_compliance_score AS DOUBLE))
      comment: "Average retailer compliance score across post-event analyses. Measures retailer execution quality."
    - name: "avg_cost_per_incremental_case"
      expr: AVG(CAST(cost_per_incremental_case AS DOUBLE))
      comment: "Average cost per incremental case generated. Efficiency KPI for trade spend — lower values indicate better ROI."
    - name: "display_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN display_compliance_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of analyzed events with display compliance achieved."
    - name: "pricing_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN pricing_compliance_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of analyzed events with pricing compliance achieved. Measures retailer adherence to agreed promotional prices."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`promotion_retailer_compliance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Retailer execution compliance KPIs for trade promotions. Tracks compliance scores, penalty amounts, dispute rates, and compliance by type — essential for managing retailer accountability and funding adjustments."
  source: "`vibe_consumer_goods_v1`.`promotion`.`retailer_compliance`"
  dimensions:
    - name: "compliance_type"
      expr: compliance_type
      comment: "Type of compliance being assessed (e.g. display, pricing, feature ad, OSA)."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Overall compliance status for the audit record (e.g. compliant, non-compliant, partial)."
    - name: "non_compliance_category"
      expr: non_compliance_category
      comment: "Category of non-compliance identified (e.g. pricing, placement, timing)."
    - name: "audit_method"
      expr: audit_method
      comment: "Method used to conduct the compliance audit (e.g. field audit, syndicated data, photo)."
    - name: "ad_feature_compliant_flag"
      expr: ad_feature_compliant_flag
      comment: "Indicates whether the retailer was compliant with the feature ad requirement."
    - name: "display_compliant_flag"
      expr: display_compliant_flag
      comment: "Indicates whether the retailer was compliant with the display requirement."
    - name: "price_compliant_flag"
      expr: price_compliant_flag
      comment: "Indicates whether the retailer was compliant with the agreed promotional price."
    - name: "osa_compliant_flag"
      expr: osa_compliant_flag
      comment: "Indicates whether the retailer was compliant with on-shelf availability requirements."
    - name: "pog_placement_compliant_flag"
      expr: pog_placement_compliant_flag
      comment: "Indicates whether the retailer was compliant with planogram placement requirements."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Indicates whether the compliance finding is under dispute."
    - name: "compliance_check_date"
      expr: compliance_check_date
      comment: "Date the compliance check was conducted."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which financial amounts are denominated."
  measures:
    - name: "total_compliance_audits"
      expr: COUNT(DISTINCT retailer_compliance_id)
      comment: "Total number of retailer compliance audit records. Baseline measure for audit coverage."
    - name: "avg_compliance_score_percentage"
      expr: AVG(CAST(compliance_score_percentage AS DOUBLE))
      comment: "Average retailer compliance score percentage. Primary KPI for retailer execution quality management."
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total penalty amount assessed for non-compliance. Measures financial consequences of retailer execution failures."
    - name: "total_funding_adjustment_amount"
      expr: SUM(CAST(funding_adjustment_amount AS DOUBLE))
      comment: "Total funding adjustment amount applied due to compliance outcomes. Tracks trade spend recovery from non-compliant retailers."
    - name: "overall_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN compliance_status = 'compliant' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audit records with full compliance status. Top-line retailer execution KPI."
    - name: "display_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN display_compliant_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits with display compliance. Measures in-store display execution quality."
    - name: "price_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN price_compliant_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits with pricing compliance. Measures retailer adherence to agreed promotional prices."
    - name: "osa_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN osa_compliant_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits with on-shelf availability compliance. Measures in-stock execution during promotions."
    - name: "dispute_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN dispute_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of compliance audits under dispute. High rates signal retailer relationship friction."
    - name: "avg_price_variance"
      expr: AVG(CAST(actual_retail_price AS DOUBLE) - CAST(agreed_promotional_price AS DOUBLE))
      comment: "Average price variance between actual retail price and agreed promotional price. Measures pricing compliance gap."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`promotion_rebate_settlement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for rebate settlement performance. Tracks earned rebates, qualifying revenue and volume, settlement rates, and tier achievement — critical for managing rebate agreement execution and cash flow."
  source: "`vibe_consumer_goods_v1`.`promotion`.`rebate_settlement`"
  dimensions:
    - name: "settlement_status"
      expr: settlement_status
      comment: "Current status of the rebate settlement (e.g. pending, approved, paid, disputed)."
    - name: "payment_method"
      expr: payment_method
      comment: "Method used to pay the rebate settlement (e.g. check, credit memo, wire)."
    - name: "tier_achieved"
      expr: tier_achieved
      comment: "Rebate tier achieved by the retailer in the settlement period."
    - name: "accrual_reversal_flag"
      expr: accrual_reversal_flag
      comment: "Indicates whether the settlement triggered an accrual reversal."
    - name: "settlement_period_start_date"
      expr: settlement_period_start_date
      comment: "Start date of the rebate settlement period."
    - name: "settlement_period_end_date"
      expr: settlement_period_end_date
      comment: "End date of the rebate settlement period."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which settlement amounts are denominated."
    - name: "volume_uom"
      expr: volume_uom
      comment: "Unit of measure for qualifying volume in the settlement."
  measures:
    - name: "total_settlements"
      expr: COUNT(DISTINCT rebate_settlement_id)
      comment: "Total number of rebate settlements processed."
    - name: "total_earned_rebate_amount"
      expr: SUM(CAST(earned_rebate_amount AS DOUBLE))
      comment: "Total earned rebate amount across settlements. Core financial KPI for rebate program performance."
    - name: "total_net_settlement_amount"
      expr: SUM(CAST(net_settlement_amount AS DOUBLE))
      comment: "Total net settlement amount after adjustments. Measures actual cash outflow from rebate programs."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total adjustment amount applied to rebate settlements. Tracks corrections and true-ups."
    - name: "total_qualifying_revenue"
      expr: SUM(CAST(qualifying_revenue AS DOUBLE))
      comment: "Total qualifying revenue used as the basis for rebate calculations."
    - name: "total_qualifying_volume"
      expr: SUM(CAST(qualifying_volume AS DOUBLE))
      comment: "Total qualifying volume used as the basis for volume-based rebate calculations."
    - name: "avg_rebate_rate"
      expr: AVG(CAST(rebate_rate AS DOUBLE))
      comment: "Average rebate rate achieved across settlements. Benchmarks rebate program generosity and competitiveness."
    - name: "rebate_as_pct_of_qualifying_revenue"
      expr: ROUND(100.0 * SUM(CAST(earned_rebate_amount AS DOUBLE)) / NULLIF(SUM(CAST(qualifying_revenue AS DOUBLE)), 0), 2)
      comment: "Earned rebate as a percentage of qualifying revenue. Measures the effective rebate rate and trade investment intensity."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`promotion_funding_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for trade funding agreement management. Tracks committed funding, accruals, payments, remaining balances, and ROI targets — essential for trade investment governance and retailer partnership management."
  source: "`vibe_consumer_goods_v1`.`promotion`.`funding_agreement`"
  dimensions:
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of funding agreement (e.g. lump sum, scan-back, performance-based)."
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the funding agreement (e.g. active, expired, terminated)."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the funding agreement."
    - name: "accrual_method"
      expr: accrual_method
      comment: "Accrual method used for the funding agreement (e.g. scan-based, fixed)."
    - name: "payment_frequency"
      expr: payment_frequency
      comment: "Frequency of payments under the funding agreement (e.g. monthly, quarterly, annual)."
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Indicates whether the agreement auto-renews."
    - name: "renewal_flag"
      expr: renewal_flag
      comment: "Indicates whether the agreement has been renewed."
    - name: "funding_period_start_date"
      expr: funding_period_start_date
      comment: "Start date of the funding period."
    - name: "funding_period_end_date"
      expr: funding_period_end_date
      comment: "End date of the funding period."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which agreement amounts are denominated."
  measures:
    - name: "total_agreements"
      expr: COUNT(DISTINCT funding_agreement_id)
      comment: "Total number of active funding agreements. Baseline measure for trade partnership portfolio size."
    - name: "total_committed_amount"
      expr: SUM(CAST(total_committed_amount AS DOUBLE))
      comment: "Total committed trade funding amount across agreements. Core financial commitment KPI."
    - name: "total_accrued_to_date_amount"
      expr: SUM(CAST(accrued_to_date_amount AS DOUBLE))
      comment: "Total amount accrued to date across funding agreements. Tracks P&L liability recognition progress."
    - name: "total_paid_to_date_amount"
      expr: SUM(CAST(paid_to_date_amount AS DOUBLE))
      comment: "Total amount paid to date across funding agreements. Measures cash outflow from trade investment."
    - name: "total_remaining_balance_amount"
      expr: SUM(CAST(remaining_balance_amount AS DOUBLE))
      comment: "Total remaining uncommitted balance across funding agreements. Tracks available trade investment capacity."
    - name: "accrual_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(accrued_to_date_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_committed_amount AS DOUBLE)), 0), 2)
      comment: "Accrued amount as a percentage of total committed amount. Measures trade investment execution pace."
    - name: "payment_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(paid_to_date_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_committed_amount AS DOUBLE)), 0), 2)
      comment: "Paid amount as a percentage of total committed amount. Measures cash disbursement progress against commitments."
    - name: "avg_roi_target_percentage"
      expr: AVG(CAST(roi_target_percentage AS DOUBLE))
      comment: "Average ROI target percentage across funding agreements. Benchmarks the expected return on trade investment commitments."
    - name: "avg_gmroi_target"
      expr: AVG(CAST(gmroi_target AS DOUBLE))
      comment: "Average GMROI target across funding agreements. Measures the gross margin return expected from trade investment."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`promotion_tpo_scenario`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Trade Promotion Optimization (TPO) scenario planning KPIs. Covers projected revenue, volume, ROI, GMROI, and gross profit across planning scenarios — supports strategic trade investment optimization decisions."
  source: "`vibe_consumer_goods_v1`.`promotion`.`tpo_scenario`"
  dimensions:
    - name: "scenario_status"
      expr: scenario_status
      comment: "Current status of the TPO scenario (e.g. draft, approved, baseline, archived)."
    - name: "optimization_objective"
      expr: optimization_objective
      comment: "Business objective being optimized in the scenario (e.g. revenue, volume, ROI, GMROI)."
    - name: "is_baseline_scenario"
      expr: is_baseline_scenario
      comment: "Indicates whether this scenario is the designated baseline for comparison."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the TPO scenario."
    - name: "country_code"
      expr: country_code
      comment: "Country for which the scenario is planned."
    - name: "planning_horizon_start_date"
      expr: planning_horizon_start_date
      comment: "Start date of the planning horizon for the scenario."
    - name: "planning_horizon_end_date"
      expr: planning_horizon_end_date
      comment: "End date of the planning horizon for the scenario."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which scenario financial projections are denominated."
    - name: "volume_unit_of_measure"
      expr: volume_unit_of_measure
      comment: "Unit of measure for volume projections in the scenario."
  measures:
    - name: "total_scenarios"
      expr: COUNT(DISTINCT tpo_scenario_id)
      comment: "Total number of TPO scenarios. Baseline measure for planning scenario portfolio."
    - name: "total_projected_total_revenue"
      expr: SUM(CAST(projected_total_revenue AS DOUBLE))
      comment: "Total projected revenue across all TPO scenarios. Top-line revenue planning KPI."
    - name: "total_projected_incremental_revenue"
      expr: SUM(CAST(projected_incremental_revenue AS DOUBLE))
      comment: "Total projected incremental revenue above baseline across scenarios."
    - name: "total_projected_total_volume"
      expr: SUM(CAST(projected_total_volume AS DOUBLE))
      comment: "Total projected volume units across TPO scenarios."
    - name: "total_projected_incremental_volume"
      expr: SUM(CAST(projected_incremental_volume AS DOUBLE))
      comment: "Total projected incremental volume above baseline across scenarios."
    - name: "total_scenario_spend"
      expr: SUM(CAST(total_scenario_spend AS DOUBLE))
      comment: "Total planned trade spend across TPO scenarios. Core investment planning KPI."
    - name: "total_projected_gross_profit"
      expr: SUM(CAST(projected_gross_profit AS DOUBLE))
      comment: "Total projected gross profit across TPO scenarios. Measures profitability of planned trade investment."
    - name: "avg_projected_roi_percentage"
      expr: AVG(CAST(projected_roi_percentage AS DOUBLE))
      comment: "Average projected ROI percentage across TPO scenarios. Primary KPI for evaluating trade investment quality in planning."
    - name: "avg_projected_gmroi"
      expr: AVG(CAST(projected_gmroi AS DOUBLE))
      comment: "Average projected GMROI across TPO scenarios. Measures expected gross margin return on planned trade investment."
    - name: "avg_projected_promotional_lift_percentage"
      expr: AVG(CAST(projected_promotional_lift_percentage AS DOUBLE))
      comment: "Average projected promotional lift percentage across scenarios. Benchmarks volume uplift ambition in trade planning."
    - name: "incremental_revenue_to_spend_ratio"
      expr: ROUND(SUM(CAST(projected_incremental_revenue AS DOUBLE)) / NULLIF(SUM(CAST(total_scenario_spend AS DOUBLE)), 0), 4)
      comment: "Projected incremental revenue per dollar of trade spend. Efficiency KPI for trade investment optimization."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`promotion_pos_redemption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Point-of-sale coupon and offer redemption KPIs. Tracks redemption volumes, values, discount economics, and validation rates — essential for consumer offer ROI and promotional mechanics evaluation."
  source: "`vibe_consumer_goods_v1`.`promotion`.`pos_redemption`"
  dimensions:
    - name: "offer_type"
      expr: offer_type
      comment: "Type of offer redeemed (e.g. coupon, instant rebate, BOGO)."
    - name: "redemption_channel"
      expr: redemption_channel
      comment: "Channel through which the offer was redeemed (e.g. in-store, digital, mail-in)."
    - name: "redemption_status"
      expr: redemption_status
      comment: "Status of the redemption (e.g. valid, rejected, pending)."
    - name: "validation_flag"
      expr: validation_flag
      comment: "Indicates whether the redemption was validated."
    - name: "country_code"
      expr: country_code
      comment: "Country where the redemption occurred."
    - name: "region_code"
      expr: region_code
      comment: "Region where the redemption occurred."
    - name: "redemption_date"
      expr: redemption_date
      comment: "Date of the redemption for time-series analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which redemption values are denominated."
  measures:
    - name: "total_redemptions"
      expr: COUNT(DISTINCT pos_redemption_id)
      comment: "Total number of POS redemption events. Baseline measure for consumer offer uptake."
    - name: "total_redemption_value_amount"
      expr: SUM(CAST(redemption_value_amount AS DOUBLE))
      comment: "Total value of all redemptions. Core financial KPI for consumer offer cost management."
    - name: "total_redemption_quantity"
      expr: SUM(CAST(redemption_quantity AS DOUBLE))
      comment: "Total quantity of units redeemed across all redemption events."
    - name: "total_settlement_amount"
      expr: SUM(CAST(settlement_amount AS DOUBLE))
      comment: "Total settlement amount paid to retailers/clearinghouses for redemptions."
    - name: "total_handling_fee_amount"
      expr: SUM(CAST(handling_fee_amount AS DOUBLE))
      comment: "Total handling fees paid for redemption processing."
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage applied across redemptions. Monitors promotional depth."
    - name: "avg_unit_discount_amount"
      expr: AVG(CAST(unit_discount_amount AS DOUBLE))
      comment: "Average per-unit discount amount across redemptions. Measures unit economics of consumer offers."
    - name: "validation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN validation_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of redemptions that passed validation. Measures offer integrity and fraud prevention effectiveness."
    - name: "avg_transaction_total_amount"
      expr: AVG(CAST(transaction_total_amount AS DOUBLE))
      comment: "Average transaction total amount at redemption. Measures basket size associated with offer redemptions."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`promotion_baseline_volume`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Baseline volume modeling KPIs. Tracks model accuracy, baseline revenue, volume estimates, and statistical confidence — foundational for measuring true promotional incrementality and ROI."
  source: "`vibe_consumer_goods_v1`.`promotion`.`baseline_volume`"
  dimensions:
    - name: "baseline_status"
      expr: baseline_status
      comment: "Current status of the baseline volume record (e.g. approved, draft, superseded)."
    - name: "baseline_methodology"
      expr: baseline_methodology
      comment: "Methodology used to calculate the baseline volume (e.g. regression, moving average, causal model)."
    - name: "data_source"
      expr: data_source
      comment: "Source of data used for baseline modeling (e.g. POS, panel, syndicated)."
    - name: "analyst_override_flag"
      expr: analyst_override_flag
      comment: "Indicates whether an analyst manually overrode the model-generated baseline."
    - name: "outlier_exclusion_flag"
      expr: outlier_exclusion_flag
      comment: "Indicates whether outliers were excluded from the baseline calculation."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which baseline revenue amounts are denominated."
    - name: "baseline_period_start_date"
      expr: baseline_period_start_date
      comment: "Start date of the baseline measurement period."
    - name: "baseline_period_end_date"
      expr: baseline_period_end_date
      comment: "End date of the baseline measurement period."
    - name: "geography_code"
      expr: geography_code
      comment: "Geographic code for the baseline volume record."
  measures:
    - name: "total_baseline_records"
      expr: COUNT(DISTINCT baseline_volume_id)
      comment: "Total number of baseline volume records. Measures coverage of the baseline modeling program."
    - name: "total_baseline_units"
      expr: SUM(CAST(units AS DOUBLE))
      comment: "Total baseline volume in units. Core non-promoted demand benchmark."
    - name: "total_baseline_cases"
      expr: SUM(CAST(cases AS DOUBLE))
      comment: "Total baseline volume in cases. Used for supply chain and logistics planning."
    - name: "total_baseline_revenue_amount"
      expr: SUM(CAST(baseline_revenue_amount AS DOUBLE))
      comment: "Total baseline revenue amount. Measures the non-promoted revenue base for ROI calculations."
    - name: "avg_model_accuracy_score"
      expr: AVG(CAST(model_accuracy_score AS DOUBLE))
      comment: "Average model accuracy score across baseline records. Measures the quality and reliability of baseline models — critical for valid lift measurement."
    - name: "avg_seasonality_adjustment_factor"
      expr: AVG(CAST(seasonality_adjustment_factor AS DOUBLE))
      comment: "Average seasonality adjustment factor applied to baselines. Monitors the magnitude of seasonal corrections in baseline modeling."
    - name: "avg_trend_adjustment_factor"
      expr: AVG(CAST(trend_adjustment_factor AS DOUBLE))
      comment: "Average trend adjustment factor applied to baselines. Measures the degree of trend correction in baseline models."
    - name: "analyst_override_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN analyst_override_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of baseline records with analyst overrides. High rates may indicate model quality issues requiring investigation."
    - name: "avg_confidence_level_percent"
      expr: AVG(CAST(confidence_level_percent AS DOUBLE))
      comment: "Average statistical confidence level across baseline models. Measures the statistical rigor of the baseline modeling program."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`promotion_trade_spend_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Trade spend allocation KPIs. Tracks allocated vs. actual spend, variance, ROI, GMROI, and settlement performance — essential for trade investment governance and budget management."
  source: "`vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation`"
  dimensions:
    - name: "allocation_status"
      expr: allocation_status
      comment: "Current status of the trade spend allocation (e.g. planned, committed, settled)."
    - name: "spend_category"
      expr: spend_category
      comment: "Category of trade spend (e.g. display, feature, scan-back, lump sum)."
    - name: "spend_type"
      expr: spend_type
      comment: "Type of trade spend (e.g. fixed, variable, performance-based)."
    - name: "pricing_strategy"
      expr: pricing_strategy
      comment: "Pricing strategy associated with the trade spend allocation."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the allocation for period-based financial reporting."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the allocation for granular financial reporting."
    - name: "is_active"
      expr: is_active
      comment: "Indicates whether the allocation is currently active."
    - name: "allocation_date"
      expr: allocation_date
      comment: "Date the allocation was created."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which allocation amounts are denominated."
  measures:
    - name: "total_allocations"
      expr: COUNT(DISTINCT trade_spend_allocation_id)
      comment: "Total number of trade spend allocation records."
    - name: "total_allocated_amount"
      expr: SUM(CAST(allocated_amount AS DOUBLE))
      comment: "Total allocated trade spend amount. Core budget planning KPI."
    - name: "total_committed_amount"
      expr: SUM(CAST(committed_amount AS DOUBLE))
      comment: "Total committed trade spend amount. Measures firm financial obligations."
    - name: "total_actual_amount"
      expr: SUM(CAST(actual_amount AS DOUBLE))
      comment: "Total actual trade spend incurred. Measures realized investment."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total variance between allocated and actual trade spend. Measures budget execution accuracy."
    - name: "total_accrual_amount"
      expr: SUM(CAST(accrual_amount AS DOUBLE))
      comment: "Total accrued trade spend amount across allocations."
    - name: "total_settlement_amount"
      expr: SUM(CAST(settlement_amount AS DOUBLE))
      comment: "Total settled trade spend amount across allocations."
    - name: "spend_execution_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_amount AS DOUBLE)) / NULLIF(SUM(CAST(allocated_amount AS DOUBLE)), 0), 2)
      comment: "Actual spend as a percentage of allocated spend. Measures trade investment execution efficiency."
    - name: "avg_roi_percentage"
      expr: AVG(CAST(roi_percentage AS DOUBLE))
      comment: "Average ROI percentage across trade spend allocations. Primary financial performance KPI for trade investment."
    - name: "avg_gmroi_percentage"
      expr: AVG(CAST(gmroi_percentage AS DOUBLE))
      comment: "Average GMROI percentage across trade spend allocations. Measures gross margin return on trade investment."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`promotion_rebate_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rebate agreement portfolio KPIs. Tracks accrued vs. paid rebates, outstanding balances, tier structures, and agreement performance — essential for managing retailer rebate programs and financial liabilities."
  source: "`vibe_consumer_goods_v1`.`promotion`.`promotion_rebate_agreement`"
  dimensions:
    - name: "rebate_type"
      expr: rebate_type
      comment: "Type of rebate agreement (e.g. volume-based, revenue-based, tiered)."
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the rebate agreement (e.g. active, expired, terminated)."
    - name: "calculation_basis"
      expr: calculation_basis
      comment: "Basis for rebate calculation (e.g. net revenue, gross revenue, units)."
    - name: "payment_frequency"
      expr: payment_frequency
      comment: "Frequency of rebate payments (e.g. monthly, quarterly, annual)."
    - name: "tier_structure"
      expr: tier_structure
      comment: "Tier structure type of the rebate agreement (e.g. flat, tiered, progressive)."
    - name: "auto_settlement_enabled"
      expr: auto_settlement_enabled
      comment: "Indicates whether automatic settlement is enabled for the agreement."
    - name: "effective_start_date"
      expr: effective_start_date
      comment: "Effective start date of the rebate agreement."
    - name: "effective_end_date"
      expr: effective_end_date
      comment: "Effective end date of the rebate agreement."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which rebate amounts are denominated."
  measures:
    - name: "total_agreements"
      expr: COUNT(DISTINCT promotion_rebate_agreement_id)
      comment: "Total number of rebate agreements. Baseline measure for rebate program portfolio size."
    - name: "total_accrued_amount"
      expr: SUM(CAST(total_accrued_amount AS DOUBLE))
      comment: "Total accrued rebate amount across agreements. Core P&L liability KPI."
    - name: "total_paid_amount"
      expr: SUM(CAST(total_paid_amount AS DOUBLE))
      comment: "Total rebate amount paid to retailers. Measures cash outflow from rebate programs."
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total outstanding rebate balance across agreements. Tracks unpaid rebate obligations."
    - name: "avg_rebate_rate"
      expr: AVG(CAST(rebate_rate AS DOUBLE))
      comment: "Average rebate rate across agreements. Benchmarks rebate program generosity."
    - name: "payment_completion_rate"
      expr: ROUND(100.0 * SUM(CAST(total_paid_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_accrued_amount AS DOUBLE)), 0), 2)
      comment: "Paid amount as a percentage of accrued amount. Measures rebate settlement completion and cash flow management."
    - name: "avg_tier_1_rate"
      expr: AVG(CAST(tier_1_rate AS DOUBLE))
      comment: "Average tier 1 rebate rate across tiered agreements. Benchmarks entry-level rebate incentives."
    - name: "avg_tier_3_rate"
      expr: AVG(CAST(tier_3_rate AS DOUBLE))
      comment: "Average tier 3 (highest) rebate rate across tiered agreements. Benchmarks maximum rebate incentives for top-performing retailers."
$$;