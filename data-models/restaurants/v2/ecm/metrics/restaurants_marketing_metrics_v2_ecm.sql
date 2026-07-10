-- Metric views for domain: marketing | Business: Restaurants | Version: 2 | Generated on: 2026-07-10 18:21:26

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`marketing_campaign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic campaign-level KPIs tracking spend efficiency, sales lift, and budget utilization across all marketing campaigns. Used by CMO and VP Marketing to steer campaign investment decisions."
  source: "`vibe_restaurants_v1`.`marketing`.`campaign`"
  dimensions:
    - name: "campaign_type"
      expr: campaign_type
      comment: "Type of marketing campaign (e.g. LTO, brand, promotional) for segmenting performance by campaign category."
    - name: "campaign_status"
      expr: campaign_status
      comment: "Current lifecycle status of the campaign (active, completed, paused) for filtering live vs. historical analysis."
    - name: "owning_brand"
      expr: owning_brand
      comment: "Brand that owns the campaign, enabling cross-brand performance comparison."
    - name: "channel_mix"
      expr: channel_mix
      comment: "Media channel mix used for the campaign, supporting channel-level ROI analysis."
    - name: "target_market"
      expr: target_market
      comment: "Geographic or demographic target market for the campaign."
    - name: "target_daypart"
      expr: target_daypart
      comment: "Daypart targeted by the campaign (breakfast, lunch, dinner) for daypart-level effectiveness analysis."
    - name: "is_lto"
      expr: is_lto
      comment: "Flag indicating whether the campaign supports a Limited Time Offer, enabling LTO vs. evergreen campaign comparison."
    - name: "is_test_campaign"
      expr: is_test_campaign
      comment: "Flag to separate test campaigns from production campaigns in reporting."
    - name: "objective"
      expr: objective
      comment: "Primary business objective of the campaign (e.g. traffic, awareness, conversion)."
    - name: "planned_start_date"
      expr: DATE_TRUNC('month', planned_start_date)
      comment: "Month of planned campaign start date for time-series trending."
    - name: "actual_start_date"
      expr: DATE_TRUNC('month', actual_start_date)
      comment: "Month of actual campaign start date for comparing planned vs. actual timing."
  measures:
    - name: "total_campaigns"
      expr: COUNT(1)
      comment: "Total number of campaigns. Baseline volume metric for portfolio sizing and trend analysis."
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total planned budget allocated across campaigns. Core investment sizing metric for CMO budget reviews."
    - name: "total_actual_spend"
      expr: SUM(CAST(actual_spend AS DOUBLE))
      comment: "Total actual spend incurred across campaigns. Compared against budget to assess spend discipline."
    - name: "budget_utilization_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_spend AS DOUBLE)) / NULLIF(SUM(CAST(budget_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of budget actually spent. Measures spend pacing and budget discipline; under-spend may signal execution issues, over-spend signals budget risk."
    - name: "avg_actual_adt_lift_pct"
      expr: AVG(CAST(actual_adt_lift_pct AS DOUBLE))
      comment: "Average actual Average Daily Transaction (ADT) lift percentage across campaigns. Key traffic effectiveness KPI used in QBRs to evaluate campaign-driven traffic impact."
    - name: "avg_actual_comp_sales_lift_pct"
      expr: AVG(CAST(actual_comp_sales_lift_pct AS DOUBLE))
      comment: "Average actual comparable sales lift percentage. Core revenue effectiveness KPI — directly measures campaign contribution to comp sales growth."
    - name: "avg_expected_adt_lift_pct"
      expr: AVG(CAST(expected_adt_lift_pct AS DOUBLE))
      comment: "Average expected ADT lift percentage at campaign planning time. Used alongside actual lift to assess forecast accuracy."
    - name: "avg_expected_comp_sales_lift_pct"
      expr: AVG(CAST(expected_comp_sales_lift_pct AS DOUBLE))
      comment: "Average expected comparable sales lift at planning time. Paired with actual comp sales lift to measure planning accuracy."
    - name: "adt_lift_vs_plan_pct"
      expr: ROUND(AVG(CAST(actual_adt_lift_pct AS DOUBLE)) - AVG(CAST(expected_adt_lift_pct AS DOUBLE)), 2)
      comment: "Difference between actual and expected ADT lift (actual minus expected). Positive values indicate outperformance; negative values trigger investigation into execution gaps."
    - name: "comp_sales_lift_vs_plan_pct"
      expr: ROUND(AVG(CAST(actual_comp_sales_lift_pct AS DOUBLE)) - AVG(CAST(expected_comp_sales_lift_pct AS DOUBLE)), 2)
      comment: "Difference between actual and expected comp sales lift. Directly informs whether campaigns are delivering promised revenue impact."
    - name: "lto_campaign_count"
      expr: COUNT(CASE WHEN is_lto = TRUE THEN 1 END)
      comment: "Count of LTO-supporting campaigns. Tracks LTO pipeline volume, a key driver of traffic and news in QSR marketing strategy."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`marketing_campaign_roi`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Campaign return-on-investment KPIs measuring incremental revenue, profit, and spend efficiency per campaign measurement period. Primary source of truth for marketing ROI reporting to the CFO and CMO."
  source: "`vibe_restaurants_v1`.`marketing`.`campaign_roi`"
  dimensions:
    - name: "channel"
      expr: channel
      comment: "Media channel for which ROI is measured, enabling channel-level ROI comparison."
    - name: "attribution_methodology"
      expr: attribution_methodology
      comment: "Attribution model used (last-touch, multi-touch, etc.) for contextualizing ROI figures."
    - name: "market_dma"
      expr: market_dma
      comment: "Designated Market Area for geographic ROI analysis."
    - name: "campaign_roi_status"
      expr: campaign_roi_status
      comment: "Status of the ROI record (final, preliminary, revised) for data quality filtering."
    - name: "confidence_level"
      expr: confidence_level
      comment: "Statistical confidence level of the ROI measurement, important for executive decision-making on campaign continuation."
    - name: "is_test_roi"
      expr: is_test_roi
      comment: "Flag to exclude test ROI records from production reporting."
    - name: "measurement_period_start_month"
      expr: DATE_TRUNC('month', measurement_period_start)
      comment: "Month of measurement period start for time-series ROI trending."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the ROI figures for multi-currency reporting."
  measures:
    - name: "total_incremental_revenue"
      expr: SUM(CAST(incremental_revenue AS DOUBLE))
      comment: "Total incremental revenue attributed to campaigns. The primary top-line marketing effectiveness metric used in board decks."
    - name: "total_net_incremental_profit"
      expr: SUM(CAST(net_incremental_profit AS DOUBLE))
      comment: "Total net incremental profit after COGS impact. The definitive bottom-line marketing ROI metric for CFO and CMO reporting."
    - name: "total_spend_amount"
      expr: SUM(CAST(spend_amount AS DOUBLE))
      comment: "Total marketing spend across measured campaigns. Denominator for ROI ratio calculations."
    - name: "total_cogs_impact"
      expr: SUM(CAST(cogs_impact_amount AS DOUBLE))
      comment: "Total COGS impact from campaign-driven incremental volume. Needed to assess true profit contribution of marketing investment."
    - name: "avg_roi_percent"
      expr: AVG(CAST(roi_percent AS DOUBLE))
      comment: "Average ROI percentage across campaign measurement records. Core efficiency KPI — if this drops below threshold, leadership reallocates budget."
    - name: "revenue_per_spend_dollar"
      expr: ROUND(SUM(CAST(incremental_revenue AS DOUBLE)) / NULLIF(SUM(CAST(spend_amount AS DOUBLE)), 0), 4)
      comment: "Incremental revenue generated per dollar of marketing spend. The most actionable efficiency ratio for budget allocation decisions."
    - name: "profit_per_spend_dollar"
      expr: ROUND(SUM(CAST(net_incremental_profit AS DOUBLE)) / NULLIF(SUM(CAST(spend_amount AS DOUBLE)), 0), 4)
      comment: "Net incremental profit per dollar of marketing spend. Preferred over revenue-based ROI for true economic efficiency assessment."
    - name: "campaign_roi_record_count"
      expr: COUNT(1)
      comment: "Number of campaign ROI measurement records. Used to assess measurement coverage and completeness."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`marketing_campaign_spend`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Granular campaign spend tracking KPIs covering budget vs. actual, variance analysis, and spend categorization. Used by Finance and Marketing Operations to manage marketing P&L."
  source: "`vibe_restaurants_v1`.`marketing`.`campaign_spend`"
  dimensions:
    - name: "channel"
      expr: channel
      comment: "Media channel for the spend record, enabling channel-level spend analysis."
    - name: "spend_category"
      expr: spend_category
      comment: "Category of spend (production, media, agency, etc.) for spend mix analysis."
    - name: "media_type"
      expr: media_type
      comment: "Media type for the spend (TV, digital, OOH, etc.) for media mix reporting."
    - name: "campaign_phase"
      expr: campaign_phase
      comment: "Phase of the campaign (planning, launch, sustain, close) for phase-level spend tracking."
    - name: "campaign_spend_status"
      expr: campaign_spend_status
      comment: "Approval and payment status of the spend record."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the spend record for compliance and governance reporting."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the spend for annual budget vs. actual reporting."
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter of the spend for quarterly budget pacing analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the spend record."
    - name: "is_estimated"
      expr: is_estimated
      comment: "Flag indicating whether the spend is an estimate vs. actuals, for data quality filtering."
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status (paid, pending, overdue) for cash flow and AP management."
  measures:
    - name: "total_spend_amount"
      expr: SUM(CAST(spend_amount AS DOUBLE))
      comment: "Total gross marketing spend. Primary spend volume metric for budget management and P&L reporting."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net spend after discounts and adjustments. The true economic cost of marketing activity."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total vendor/agency discounts received. Tracks negotiated savings on marketing procurement."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax on marketing spend. Required for accurate P&L and tax reporting."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total variance between planned and actual spend. Negative variance indicates over-spend; positive indicates under-delivery. Key budget control metric."
    - name: "avg_variance_percent"
      expr: AVG(CAST(variance_percent AS DOUBLE))
      comment: "Average spend variance percentage. Measures budget discipline across spend line items; high variance triggers finance review."
    - name: "spend_record_count"
      expr: COUNT(1)
      comment: "Number of spend records. Used for spend fragmentation analysis and vendor invoice volume tracking."
    - name: "avg_tax_rate"
      expr: AVG(CAST(tax_rate AS DOUBLE))
      comment: "Average effective tax rate on marketing spend. Used for tax planning and cross-market tax rate comparison."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`marketing_digital_campaign_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Digital channel performance KPIs covering impressions, clicks, conversions, cost efficiency, and ROI. Primary dashboard for the Digital Marketing team and CMO to optimize digital spend allocation."
  source: "`vibe_restaurants_v1`.`marketing`.`digital_campaign_performance`"
  dimensions:
    - name: "channel"
      expr: channel
      comment: "Digital channel (paid search, social, display, etc.) for channel-level performance comparison."
    - name: "platform"
      expr: platform
      comment: "Specific platform (Google, Meta, TikTok, etc.) for platform-level ROI analysis."
    - name: "ad_format"
      expr: ad_format
      comment: "Ad format (video, static, carousel, etc.) for creative format effectiveness analysis."
    - name: "device_type"
      expr: device_type
      comment: "Device type (mobile, desktop, tablet) for device-level performance optimization."
    - name: "audience_segment"
      expr: audience_segment
      comment: "Target audience segment for segment-level digital performance analysis."
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region for regional digital performance comparison."
    - name: "daypart"
      expr: daypart
      comment: "Daypart targeting for time-of-day performance analysis, critical for QSR digital strategy."
    - name: "campaign_goal"
      expr: campaign_goal
      comment: "Campaign objective (awareness, traffic, conversion) for goal-based performance segmentation."
    - name: "attribution_model"
      expr: attribution_model
      comment: "Attribution model applied to conversion data for methodology-aware analysis."
    - name: "is_lto"
      expr: is_lto
      comment: "Flag for LTO-supporting digital campaigns, enabling LTO digital performance isolation."
    - name: "event_date_month"
      expr: DATE_TRUNC('month', event_date)
      comment: "Month of the performance event for time-series digital performance trending."
    - name: "digital_campaign_performance_status"
      expr: digital_campaign_performance_status
      comment: "Status of the performance record for data quality filtering."
  measures:
    - name: "total_impressions"
      expr: SUM(CAST(impressions AS DOUBLE))
      comment: "Total ad impressions delivered. Top-of-funnel reach metric used to assess campaign awareness scale."
    - name: "total_clicks"
      expr: SUM(CAST(clicks AS DOUBLE))
      comment: "Total clicks on digital ads. Mid-funnel engagement metric indicating audience interest and creative effectiveness."
    - name: "total_conversions"
      expr: SUM(CAST(conversions AS DOUBLE))
      comment: "Total conversions attributed to digital campaigns. Bottom-of-funnel metric directly tied to revenue outcomes."
    - name: "total_video_views"
      expr: SUM(CAST(video_views AS DOUBLE))
      comment: "Total video ad views. Key metric for video creative effectiveness and brand storytelling reach."
    - name: "total_actual_spend"
      expr: SUM(CAST(actual_spend AS DOUBLE))
      comment: "Total actual digital spend. Core budget consumption metric for digital channel P&L."
    - name: "total_revenue_attributed"
      expr: SUM(CAST(revenue_attributed AS DOUBLE))
      comment: "Total revenue attributed to digital campaigns. Directly links digital investment to revenue outcomes for CFO reporting."
    - name: "avg_click_through_rate"
      expr: AVG(CAST(click_through_rate AS DOUBLE))
      comment: "Average click-through rate (CTR) across digital placements. Primary creative effectiveness KPI — low CTR triggers creative refresh decisions."
    - name: "avg_conversion_rate"
      expr: AVG(CAST(conversion_rate AS DOUBLE))
      comment: "Average conversion rate from click to action. Measures landing page and offer effectiveness; drives CRO investment decisions."
    - name: "avg_cost_per_click"
      expr: AVG(CAST(cost_per_click AS DOUBLE))
      comment: "Average cost per click across digital placements. Efficiency metric for paid media bidding strategy optimization."
    - name: "avg_cost_per_acquisition"
      expr: AVG(CAST(cost_per_acquisition AS DOUBLE))
      comment: "Average cost per acquisition (CPA). The definitive digital efficiency metric — if CPA exceeds customer value threshold, budget is reallocated."
    - name: "avg_cost_per_mille"
      expr: AVG(CAST(cost_per_mille AS DOUBLE))
      comment: "Average CPM (cost per thousand impressions). Used for media buying efficiency benchmarking across platforms."
    - name: "avg_roi_percent"
      expr: AVG(CAST(roi_percent AS DOUBLE))
      comment: "Average digital campaign ROI percentage. Executive-level efficiency metric for digital vs. traditional media investment decisions."
    - name: "avg_frequency"
      expr: AVG(CAST(frequency_average AS DOUBLE))
      comment: "Average ad frequency (exposures per unique user). High frequency indicates audience fatigue risk; used to optimize reach vs. frequency trade-off."
    - name: "total_estimated_reach"
      expr: SUM(CAST(estimated_reach AS DOUBLE))
      comment: "Total estimated unique reach across digital campaigns. Awareness scale metric for brand health and media planning."
    - name: "revenue_per_spend_dollar"
      expr: ROUND(SUM(CAST(revenue_attributed AS DOUBLE)) / NULLIF(SUM(CAST(actual_spend AS DOUBLE)), 0), 4)
      comment: "Digital revenue generated per dollar of spend. The most actionable digital efficiency ratio for channel budget allocation."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`marketing_campaign_execution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Campaign execution performance KPIs tracking delivery accuracy, channel spend efficiency, and lift vs. plan at the execution level. Used by Marketing Operations to manage campaign delivery quality."
  source: "`vibe_restaurants_v1`.`marketing`.`campaign_execution`"
  dimensions:
    - name: "execution_channel"
      expr: execution_channel
      comment: "Channel through which the campaign was executed for channel-level execution performance analysis."
    - name: "campaign_execution_status"
      expr: campaign_execution_status
      comment: "Execution status (launched, paused, completed, cancelled) for operational pipeline management."
    - name: "market_dma"
      expr: market_dma
      comment: "Designated Market Area for geographic execution performance analysis."
    - name: "media_vendor"
      expr: media_vendor
      comment: "Media vendor used for execution, enabling vendor performance benchmarking."
    - name: "target_audience"
      expr: target_audience
      comment: "Target audience for the execution, for audience-level performance segmentation."
    - name: "target_segment"
      expr: target_segment
      comment: "Target guest segment for the execution."
    - name: "launch_date_month"
      expr: DATE_TRUNC('month', launch_date)
      comment: "Month of campaign launch for time-series execution volume trending."
    - name: "deviation_reason"
      expr: deviation_reason
      comment: "Reason for execution deviation from plan, for root cause analysis of underperformance."
  measures:
    - name: "total_executions"
      expr: COUNT(1)
      comment: "Total number of campaign executions. Baseline volume metric for execution pipeline management."
    - name: "total_channel_spend"
      expr: SUM(CAST(channel_spend_amount AS DOUBLE))
      comment: "Total spend across campaign executions by channel. Core spend tracking metric for execution-level budget management."
    - name: "avg_actual_adt_lift_pct"
      expr: AVG(CAST(actual_adt_lift_percent AS DOUBLE))
      comment: "Average actual ADT lift percentage at execution level. Measures traffic impact of individual campaign executions."
    - name: "avg_actual_comp_sales_lift_pct"
      expr: AVG(CAST(actual_comp_sales_lift_percent AS DOUBLE))
      comment: "Average actual comp sales lift at execution level. Measures revenue impact of individual campaign executions."
    - name: "avg_expected_adt_lift_pct"
      expr: AVG(CAST(expected_adt_lift_percent AS DOUBLE))
      comment: "Average expected ADT lift at execution planning time. Paired with actual to measure execution forecast accuracy."
    - name: "avg_expected_comp_sales_lift_pct"
      expr: AVG(CAST(expected_comp_sales_lift_percent AS DOUBLE))
      comment: "Average expected comp sales lift at execution planning time."
    - name: "avg_roi_percent"
      expr: AVG(CAST(roi_percent AS DOUBLE))
      comment: "Average ROI percentage at execution level. Enables identification of high- and low-performing execution channels and markets."
    - name: "avg_cost_per_click"
      expr: AVG(CAST(cost_per_click AS DOUBLE))
      comment: "Average cost per click at execution level. Efficiency metric for digital execution optimization."
    - name: "avg_cost_per_impression"
      expr: AVG(CAST(cost_per_impression AS DOUBLE))
      comment: "Average cost per impression at execution level. Media buying efficiency metric for execution-level optimization."
    - name: "adt_lift_vs_plan"
      expr: ROUND(AVG(CAST(actual_adt_lift_percent AS DOUBLE)) - AVG(CAST(expected_adt_lift_percent AS DOUBLE)), 2)
      comment: "Execution-level ADT lift vs. plan (actual minus expected). Identifies executions that over- or under-delivered on traffic goals."
    - name: "comp_sales_lift_vs_plan"
      expr: ROUND(AVG(CAST(actual_comp_sales_lift_percent AS DOUBLE)) - AVG(CAST(expected_comp_sales_lift_percent AS DOUBLE)), 2)
      comment: "Execution-level comp sales lift vs. plan. Identifies executions that over- or under-delivered on revenue goals."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`marketing_promotion_redemption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Promotion redemption KPIs measuring discount impact, redemption volume, and order value effects. Used by Marketing and Finance to evaluate promotion economics and guest response rates."
  source: "`vibe_restaurants_v1`.`marketing`.`promotion_redemption`"
  dimensions:
    - name: "channel"
      expr: channel
      comment: "Redemption channel (app, in-store, drive-thru, web) for channel-level promotion effectiveness analysis."
    - name: "daypart"
      expr: daypart
      comment: "Daypart of redemption for time-of-day promotion performance analysis."
    - name: "discount_type"
      expr: discount_type
      comment: "Type of discount applied (BOGO, percent-off, dollar-off) for discount mechanics effectiveness comparison."
    - name: "promotion_redemption_status"
      expr: promotion_redemption_status
      comment: "Status of the redemption record for data quality filtering."
    - name: "loyalty_member_flag"
      expr: loyalty_member_flag
      comment: "Flag indicating whether the redemption was by a loyalty member. Enables loyalty vs. non-loyalty promotion economics comparison."
    - name: "is_test_redemption"
      expr: is_test_redemption
      comment: "Flag to exclude test redemptions from production reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the redemption transaction."
    - name: "redemption_month"
      expr: DATE_TRUNC('month', redemption_timestamp)
      comment: "Month of redemption for time-series promotion performance trending."
  measures:
    - name: "total_redemptions"
      expr: COUNT(1)
      comment: "Total number of promotion redemptions. Primary volume metric for promotion uptake measurement."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount value given to guests. Measures the gross cost of promotion to the business — key P&L impact metric."
    - name: "total_order_value_before_discount"
      expr: SUM(CAST(order_value_before_discount AS DOUBLE))
      comment: "Total order value before discount application. Used to assess whether promotions are driving incremental basket size."
    - name: "total_order_value_after_discount"
      expr: SUM(CAST(order_value_after_discount AS DOUBLE))
      comment: "Total order value after discount. Net revenue contribution from promoted transactions."
    - name: "avg_discount_amount"
      expr: AVG(CAST(discount_amount AS DOUBLE))
      comment: "Average discount per redemption. Measures promotion generosity and its relationship to redemption volume."
    - name: "avg_discount_percent"
      expr: AVG(CAST(discount_percent AS DOUBLE))
      comment: "Average discount percentage per redemption. Enables comparison of promotion depth across different promotion types."
    - name: "avg_order_value_before_discount"
      expr: AVG(CAST(order_value_before_discount AS DOUBLE))
      comment: "Average order value before discount. Baseline basket size metric for promoted transactions."
    - name: "avg_order_value_after_discount"
      expr: AVG(CAST(order_value_after_discount AS DOUBLE))
      comment: "Average net order value after discount. Measures the true revenue yield per promoted transaction."
    - name: "discount_to_order_value_ratio"
      expr: ROUND(SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(order_value_before_discount AS DOUBLE)), 0), 4)
      comment: "Ratio of total discount given to total pre-discount order value. Measures the economic cost of promotions as a share of gross sales — critical for promotion profitability assessment."
    - name: "loyalty_redemption_count"
      expr: COUNT(CASE WHEN loyalty_member_flag = TRUE THEN 1 END)
      comment: "Number of redemptions by loyalty members. Measures loyalty program engagement with promotions and informs loyalty-exclusive offer strategy."
    - name: "loyalty_redemption_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN loyalty_member_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of redemptions made by loyalty members. Tracks loyalty program penetration of promotional activity."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`marketing_media_buy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Media buying efficiency KPIs tracking contracted vs. actual delivery, CPM performance, and spend reconciliation. Used by Media Planning and Finance to optimize media investment and vendor negotiations."
  source: "`vibe_restaurants_v1`.`marketing`.`media_buy`"
  dimensions:
    - name: "ad_format"
      expr: ad_format
      comment: "Ad format for the media buy (TV spot, digital banner, radio, etc.) for format-level efficiency analysis."
    - name: "market_dma"
      expr: market_dma
      comment: "Designated Market Area for geographic media buy analysis."
    - name: "media_buy_status"
      expr: media_buy_status
      comment: "Status of the media buy (contracted, live, completed, cancelled) for pipeline management."
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status for AP management and cash flow forecasting."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status between contracted and delivered media for billing dispute management."
    - name: "is_programmatic"
      expr: is_programmatic
      comment: "Flag for programmatic vs. direct media buys, enabling programmatic efficiency benchmarking."
    - name: "publisher_name"
      expr: publisher_name
      comment: "Publisher or media vendor for vendor-level performance and spend analysis."
    - name: "audience_segment"
      expr: audience_segment
      comment: "Target audience segment for the media buy."
    - name: "flight_start_month"
      expr: DATE_TRUNC('month', flight_start_date)
      comment: "Month of media flight start for time-series media spend trending."
  measures:
    - name: "total_contracted_amount"
      expr: SUM(CAST(contracted_amount AS DOUBLE))
      comment: "Total contracted media spend. Baseline commitment metric for media budget management and vendor obligation tracking."
    - name: "total_net_spend"
      expr: SUM(CAST(net_spend AS DOUBLE))
      comment: "Total net media spend after adjustments. Actual economic cost of media investment."
    - name: "total_actual_impressions"
      expr: SUM(CAST(actual_impressions AS DOUBLE))
      comment: "Total actual impressions delivered. Measures media delivery fulfillment against contracted volume."
    - name: "total_contracted_impressions"
      expr: SUM(CAST(contracted_impressions AS DOUBLE))
      comment: "Total contracted impressions. Denominator for delivery fulfillment rate calculation."
    - name: "impression_delivery_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_impressions AS DOUBLE)) / NULLIF(SUM(CAST(contracted_impressions AS DOUBLE)), 0), 2)
      comment: "Percentage of contracted impressions actually delivered. Measures vendor fulfillment quality; under-delivery triggers make-good negotiations."
    - name: "avg_actual_cpm"
      expr: AVG(CAST(actual_cpm AS DOUBLE))
      comment: "Average actual CPM (cost per thousand impressions). Core media buying efficiency metric for benchmarking and negotiation."
    - name: "avg_cpm_rate"
      expr: AVG(CAST(cpm_rate AS DOUBLE))
      comment: "Average contracted CPM rate. Compared against actual CPM to assess negotiation effectiveness."
    - name: "total_actual_grps"
      expr: SUM(CAST(actual_grps AS DOUBLE))
      comment: "Total actual Gross Rating Points delivered. Traditional broadcast media effectiveness metric used in TV and radio planning."
    - name: "total_contracted_grps"
      expr: SUM(CAST(contracted_grps AS DOUBLE))
      comment: "Total contracted GRPs. Paired with actual GRPs to measure broadcast media delivery fulfillment."
    - name: "grp_delivery_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_grps AS DOUBLE)) / NULLIF(SUM(CAST(contracted_grps AS DOUBLE)), 0), 2)
      comment: "Percentage of contracted GRPs actually delivered. Broadcast media fulfillment KPI used in agency performance reviews."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total billing adjustments on media buys. Tracks make-goods, credits, and billing corrections — high values indicate vendor delivery issues."
    - name: "media_buy_count"
      expr: COUNT(1)
      comment: "Total number of media buy records. Used for media plan fragmentation and vendor concentration analysis."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`marketing_fund_contribution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Marketing fund contribution KPIs tracking franchisee contribution rates, collection performance, and fund health. Used by Finance and Franchise Operations to manage cooperative marketing fund compliance."
  source: "`vibe_restaurants_v1`.`marketing`.`fund_contribution`"
  dimensions:
    - name: "contribution_type"
      expr: contribution_type
      comment: "Type of contribution (national, local, co-op) for fund type analysis."
    - name: "contribution_period_type"
      expr: contribution_period_type
      comment: "Period type (weekly, monthly, quarterly) for contribution cadence analysis."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Lifecycle status of the contribution record (pending, collected, disputed) for collection management."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status for financial close and audit purposes."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the contribution for multi-currency fund reporting."
    - name: "contribution_period_start_month"
      expr: DATE_TRUNC('month', period_start_date)
      comment: "Month of contribution period start for time-series fund contribution trending."
  measures:
    - name: "total_contribution_amount"
      expr: SUM(CAST(contribution_amount AS DOUBLE))
      comment: "Total marketing fund contributions collected. Primary fund health metric — directly determines available marketing budget for the system."
    - name: "total_gross_sales_amount"
      expr: SUM(CAST(gross_sales_amount AS DOUBLE))
      comment: "Total gross sales on which contributions are based. Used to validate contribution rate compliance across franchisees."
    - name: "avg_contribution_rate"
      expr: AVG(CAST(contribution_rate AS DOUBLE))
      comment: "Average contribution rate applied. Monitors rate compliance and identifies franchisees applying incorrect rates."
    - name: "effective_contribution_rate"
      expr: ROUND(SUM(CAST(contribution_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_sales_amount AS DOUBLE)), 0), 4)
      comment: "Actual effective contribution rate (contributions / gross sales). Compared against contracted rate to identify under-contribution — a key franchise compliance metric."
    - name: "contributing_unit_count"
      expr: COUNT(DISTINCT fund_restaurant_unit_id)
      comment: "Number of distinct restaurant units contributing to the fund. Measures fund participation breadth and identifies non-contributing units."
    - name: "contribution_record_count"
      expr: COUNT(1)
      comment: "Total number of contribution records. Used for contribution frequency and completeness analysis."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`marketing_influencer_activation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Influencer marketing activation KPIs measuring engagement delivery, earned media value, and cost efficiency. Used by the Social and Digital Marketing team to evaluate influencer program ROI."
  source: "`vibe_restaurants_v1`.`marketing`.`influencer_activation`"
  dimensions:
    - name: "platform"
      expr: platform
      comment: "Social platform (Instagram, TikTok, YouTube, etc.) for platform-level influencer performance analysis."
    - name: "influencer_category"
      expr: influencer_category
      comment: "Category of influencer (food, lifestyle, family, etc.) for category-level effectiveness analysis."
    - name: "influencer_region"
      expr: influencer_region
      comment: "Geographic region of the influencer for regional influencer strategy analysis."
    - name: "activation_type"
      expr: activation_type
      comment: "Type of influencer activation (sponsored post, story, video, event) for format effectiveness comparison."
    - name: "influencer_activation_status"
      expr: influencer_activation_status
      comment: "Status of the activation (contracted, live, completed, cancelled) for pipeline management."
    - name: "compliance_status"
      expr: compliance_status
      comment: "FTC and brand compliance status of the activation. Non-compliant activations represent legal and brand risk."
    - name: "ftc_disclosure_flag"
      expr: ftc_disclosure_flag
      comment: "Flag indicating FTC disclosure compliance. Required for regulatory compliance reporting."
    - name: "content_go_live_month"
      expr: DATE_TRUNC('month', content_go_live_date)
      comment: "Month content went live for time-series influencer program performance trending."
  measures:
    - name: "total_activations"
      expr: COUNT(1)
      comment: "Total number of influencer activations. Baseline volume metric for influencer program scale."
    - name: "total_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total fees paid to influencers. Core cost metric for influencer program P&L management."
    - name: "total_earned_media_value"
      expr: SUM(CAST(earned_media_value AS DOUBLE))
      comment: "Total earned media value generated by influencer activations. Measures the equivalent paid media value of organic influencer content — key ROI metric."
    - name: "total_actual_impressions"
      expr: SUM(CAST(actual_impressions AS DOUBLE))
      comment: "Total impressions delivered by influencer content. Reach metric for influencer program awareness impact."
    - name: "total_actual_likes"
      expr: SUM(CAST(actual_likes AS DOUBLE))
      comment: "Total likes on influencer content. Engagement volume metric for content resonance measurement."
    - name: "total_actual_comments"
      expr: SUM(CAST(actual_comments AS DOUBLE))
      comment: "Total comments on influencer content. High-quality engagement metric indicating audience conversation and brand affinity."
    - name: "total_actual_shares"
      expr: SUM(CAST(actual_shares AS DOUBLE))
      comment: "Total shares of influencer content. Viral amplification metric — shares extend reach beyond paid audience."
    - name: "total_engagement"
      expr: SUM(CAST(total_engagement AS DOUBLE))
      comment: "Total engagement (likes + comments + shares) across all influencer activations. Composite engagement volume metric."
    - name: "avg_engagement_rate"
      expr: AVG(CAST(influencer_engagement_rate AS DOUBLE))
      comment: "Average engagement rate across influencer activations. Primary influencer quality metric — low engagement rate indicates audience mismatch or content fatigue."
    - name: "earned_media_value_per_dollar_spent"
      expr: ROUND(SUM(CAST(earned_media_value AS DOUBLE)) / NULLIF(SUM(CAST(payment_amount AS DOUBLE)), 0), 4)
      comment: "Earned media value generated per dollar paid to influencers. The definitive influencer ROI metric for budget allocation decisions."
    - name: "cost_per_thousand_impressions"
      expr: ROUND(1000.0 * SUM(CAST(payment_amount AS DOUBLE)) / NULLIF(SUM(CAST(actual_impressions AS DOUBLE)), 0), 4)
      comment: "Effective CPM for influencer content. Enables apples-to-apples comparison of influencer vs. paid media efficiency."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`marketing_local_store_marketing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Local Store Marketing (LSM) KPIs tracking initiative spend, lift performance, and LMF fund utilization at the restaurant unit level. Used by Field Marketing and Franchise Operations to optimize local marketing investment."
  source: "`vibe_restaurants_v1`.`marketing`.`local_store_marketing`"
  dimensions:
    - name: "initiative_type"
      expr: initiative_type
      comment: "Type of LSM initiative (sponsorship, community event, local media, etc.) for initiative category effectiveness analysis."
    - name: "channel"
      expr: channel
      comment: "Channel used for the LSM initiative for channel-level local marketing analysis."
    - name: "market_dma"
      expr: market_dma
      comment: "Designated Market Area for geographic LSM performance comparison."
    - name: "local_store_marketing_status"
      expr: local_store_marketing_status
      comment: "Status of the LSM initiative for pipeline and compliance management."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the LSM initiative for governance and compliance reporting."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Flag indicating whether the initiative is compliant with brand standards."
    - name: "start_date_month"
      expr: DATE_TRUNC('month', start_date)
      comment: "Month of LSM initiative start for time-series local marketing trending."
  measures:
    - name: "total_lsm_initiatives"
      expr: COUNT(1)
      comment: "Total number of LSM initiatives. Measures local marketing activity volume across the restaurant system."
    - name: "total_actual_spend"
      expr: SUM(CAST(actual_spend AS DOUBLE))
      comment: "Total actual LSM spend. Core cost metric for local marketing P&L management."
    - name: "total_planned_spend"
      expr: SUM(CAST(planned_spend AS DOUBLE))
      comment: "Total planned LSM spend. Paired with actual spend for budget discipline measurement."
    - name: "total_lmf_fund_used"
      expr: SUM(CAST(lmf_fund_used AS DOUBLE))
      comment: "Total Local Marketing Fund (LMF) dollars utilized. Measures fund utilization efficiency — low utilization may indicate franchisee engagement issues."
    - name: "total_lmf_fund_amount"
      expr: SUM(CAST(lmf_fund_amount AS DOUBLE))
      comment: "Total LMF fund amount allocated to LSM initiatives. Denominator for LMF utilization rate."
    - name: "lmf_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(lmf_fund_used AS DOUBLE)) / NULLIF(SUM(CAST(lmf_fund_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of allocated LMF funds actually utilized. Key franchise marketing compliance metric — low utilization triggers franchisee coaching."
    - name: "avg_actual_adt_lift_pct"
      expr: AVG(CAST(actual_adt_lift_percent AS DOUBLE))
      comment: "Average actual ADT lift from LSM initiatives. Measures local marketing traffic effectiveness at the unit level."
    - name: "avg_actual_comp_sales_lift_pct"
      expr: AVG(CAST(actual_comp_sales_lift_percent AS DOUBLE))
      comment: "Average actual comp sales lift from LSM initiatives. Measures local marketing revenue effectiveness."
    - name: "spend_variance_amount"
      expr: ROUND(SUM(CAST(actual_spend AS DOUBLE)) - SUM(CAST(planned_spend AS DOUBLE)), 2)
      comment: "Total variance between actual and planned LSM spend. Positive indicates over-spend; negative indicates under-delivery. Budget control metric."
    - name: "active_unit_count"
      expr: COUNT(DISTINCT local_unit_id)
      comment: "Number of distinct restaurant units with active LSM initiatives. Measures local marketing program penetration across the system."
$$;