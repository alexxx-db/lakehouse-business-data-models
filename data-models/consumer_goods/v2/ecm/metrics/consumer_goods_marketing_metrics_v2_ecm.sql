-- Metric views for domain: marketing | Business: Consumer_Goods | Version: 2 | Generated on: 2026-07-10 13:28:51

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`marketing_campaign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core campaign performance metrics tracking spend efficiency, ROI, and execution variance across marketing campaigns"
  source: "`vibe_consumer_goods_v1`.`marketing`.`campaign`"
  dimensions:
    - name: "campaign_status"
      expr: campaign_status
      comment: "Current status of the campaign (active, completed, cancelled, etc.)"
    - name: "campaign_type"
      expr: campaign_type
      comment: "Type of campaign (brand awareness, product launch, seasonal, etc.)"
    - name: "channel_mix"
      expr: channel_mix
      comment: "Mix of channels used in the campaign (digital, TV, print, etc.)"
    - name: "geography_scope"
      expr: geography_scope
      comment: "Geographic scope of the campaign (national, regional, local)"
    - name: "objective"
      expr: objective
      comment: "Primary business objective of the campaign"
    - name: "planned_start_year"
      expr: YEAR(planned_start_date)
      comment: "Year the campaign was planned to start"
    - name: "planned_start_quarter"
      expr: CONCAT('Q', QUARTER(planned_start_date))
      comment: "Quarter the campaign was planned to start"
    - name: "actual_start_year"
      expr: YEAR(actual_start_date)
      comment: "Year the campaign actually started"
  measures:
    - name: "total_campaigns"
      expr: COUNT(DISTINCT campaign_id)
      comment: "Total number of distinct campaigns"
    - name: "total_planned_media_spend"
      expr: SUM(CAST(planned_media_spend_amount AS DOUBLE))
      comment: "Total planned media spend across campaigns"
    - name: "total_actual_media_spend"
      expr: SUM(CAST(actual_media_spend_amount AS DOUBLE))
      comment: "Total actual media spend across campaigns"
    - name: "total_planned_production_cost"
      expr: SUM(CAST(planned_production_cost_amount AS DOUBLE))
      comment: "Total planned production costs across campaigns"
    - name: "total_actual_production_cost"
      expr: SUM(CAST(actual_production_cost_amount AS DOUBLE))
      comment: "Total actual production costs across campaigns"
    - name: "avg_planned_media_spend"
      expr: AVG(CAST(planned_media_spend_amount AS DOUBLE))
      comment: "Average planned media spend per campaign"
    - name: "avg_actual_media_spend"
      expr: AVG(CAST(actual_media_spend_amount AS DOUBLE))
      comment: "Average actual media spend per campaign"
    - name: "media_spend_variance_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_media_spend_amount AS DOUBLE) - CAST(planned_media_spend_amount AS DOUBLE)) / NULLIF(SUM(CAST(planned_media_spend_amount AS DOUBLE)), 0), 2)
      comment: "Percentage variance between actual and planned media spend - key budget control metric"
    - name: "production_cost_variance_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_production_cost_amount AS DOUBLE) - CAST(planned_production_cost_amount AS DOUBLE)) / NULLIF(SUM(CAST(planned_production_cost_amount AS DOUBLE)), 0), 2)
      comment: "Percentage variance between actual and planned production costs - key budget control metric"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`marketing_campaign_flight`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tactical campaign flight performance metrics tracking impressions, engagement, conversion, and media efficiency at the flight level"
  source: "`vibe_consumer_goods_v1`.`marketing`.`campaign_flight`"
  dimensions:
    - name: "flight_status"
      expr: flight_status
      comment: "Current status of the campaign flight"
    - name: "channel"
      expr: channel
      comment: "Media channel for this flight (digital, TV, social, etc.)"
    - name: "platform"
      expr: platform
      comment: "Specific platform within the channel (Facebook, Google, etc.)"
    - name: "placement_type"
      expr: placement_type
      comment: "Type of ad placement (banner, video, native, etc.)"
    - name: "market_geography"
      expr: market_geography
      comment: "Geographic market for this flight"
    - name: "target_audience"
      expr: target_audience
      comment: "Target audience segment for this flight"
    - name: "attribution_model"
      expr: attribution_model
      comment: "Attribution model used for this flight (last-click, multi-touch, etc.)"
    - name: "measurement_year"
      expr: YEAR(measurement_date)
      comment: "Year of measurement"
    - name: "measurement_month"
      expr: DATE_TRUNC('MONTH', measurement_date)
      comment: "Month of measurement"
  measures:
    - name: "total_flights"
      expr: COUNT(DISTINCT campaign_flight_id)
      comment: "Total number of distinct campaign flights"
    - name: "total_budget_allocated"
      expr: SUM(CAST(budget_allocated_amount AS DOUBLE))
      comment: "Total budget allocated across flights"
    - name: "total_budget_spent"
      expr: SUM(CAST(budget_spent_amount AS DOUBLE))
      comment: "Total budget spent across flights"
    - name: "total_impressions"
      expr: SUM(CAST(actual_impressions AS DOUBLE))
      comment: "Total impressions delivered across flights"
    - name: "total_clicks"
      expr: SUM(CAST(clicks AS DOUBLE))
      comment: "Total clicks generated across flights"
    - name: "total_conversions"
      expr: SUM(CAST(conversions AS DOUBLE))
      comment: "Total conversions attributed to flights"
    - name: "total_reach"
      expr: SUM(CAST(reach AS DOUBLE))
      comment: "Total unique reach across flights"
    - name: "total_video_views"
      expr: SUM(CAST(video_views AS DOUBLE))
      comment: "Total video views across flights"
    - name: "avg_ctr"
      expr: AVG(CAST(ctr AS DOUBLE))
      comment: "Average click-through rate across flights - key engagement metric"
    - name: "avg_conversion_rate"
      expr: AVG(CAST(conversion_rate AS DOUBLE))
      comment: "Average conversion rate across flights - key performance metric"
    - name: "avg_cpc"
      expr: AVG(CAST(cpc AS DOUBLE))
      comment: "Average cost per click - key efficiency metric"
    - name: "avg_cpa"
      expr: AVG(CAST(cpa AS DOUBLE))
      comment: "Average cost per acquisition - key efficiency metric"
    - name: "avg_roas"
      expr: AVG(CAST(roas AS DOUBLE))
      comment: "Average return on ad spend - key ROI metric for steering investment decisions"
    - name: "avg_frequency"
      expr: AVG(CAST(frequency AS DOUBLE))
      comment: "Average frequency of exposure per user - key reach efficiency metric"
    - name: "avg_video_completion_rate"
      expr: AVG(CAST(video_completion_rate AS DOUBLE))
      comment: "Average video completion rate - key video engagement metric"
    - name: "budget_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(budget_spent_amount AS DOUBLE)) / NULLIF(SUM(CAST(budget_allocated_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of allocated budget actually spent - key budget efficiency metric"
    - name: "impression_delivery_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_impressions AS DOUBLE)) / NULLIF(SUM(CAST(target_impressions AS DOUBLE)), 0), 2)
      comment: "Percentage of target impressions delivered - key media delivery metric"
    - name: "blended_ctr"
      expr: ROUND(100.0 * SUM(CAST(clicks AS DOUBLE)) / NULLIF(SUM(CAST(actual_impressions AS DOUBLE)), 0), 2)
      comment: "Blended click-through rate across all flights - key engagement efficiency metric"
    - name: "blended_conversion_rate"
      expr: ROUND(100.0 * SUM(CAST(conversions AS DOUBLE)) / NULLIF(SUM(CAST(clicks AS DOUBLE)), 0), 2)
      comment: "Blended conversion rate from clicks to conversions - key funnel efficiency metric"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`marketing_digital_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Digital marketing performance metrics tracking channel efficiency, conversion funnel, and ROI across digital platforms"
  source: "`vibe_consumer_goods_v1`.`marketing`.`digital_performance`"
  dimensions:
    - name: "channel"
      expr: channel
      comment: "Digital marketing channel (paid search, display, social, etc.)"
    - name: "platform"
      expr: platform
      comment: "Specific digital platform (Google Ads, Facebook, etc.)"
    - name: "device_type"
      expr: device_type
      comment: "Device type (mobile, desktop, tablet)"
    - name: "ad_format"
      expr: ad_format
      comment: "Ad format (banner, video, native, etc.)"
    - name: "placement_type"
      expr: placement_type
      comment: "Placement type within platform"
    - name: "geography"
      expr: geography
      comment: "Geographic market"
    - name: "target_audience"
      expr: target_audience
      comment: "Target audience segment"
    - name: "attribution_model"
      expr: attribution_model
      comment: "Attribution model used"
    - name: "measurement_year"
      expr: YEAR(measurement_date)
      comment: "Year of measurement"
    - name: "measurement_month"
      expr: DATE_TRUNC('MONTH', measurement_date)
      comment: "Month of measurement"
  measures:
    - name: "total_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total digital marketing cost"
    - name: "total_revenue"
      expr: SUM(CAST(revenue_amount AS DOUBLE))
      comment: "Total revenue attributed to digital marketing"
    - name: "total_impressions"
      expr: SUM(CAST(impressions AS DOUBLE))
      comment: "Total impressions delivered"
    - name: "total_clicks"
      expr: SUM(CAST(clicks AS DOUBLE))
      comment: "Total clicks generated"
    - name: "total_conversions"
      expr: SUM(CAST(conversions AS DOUBLE))
      comment: "Total conversions attributed"
    - name: "total_reach"
      expr: SUM(CAST(reach AS DOUBLE))
      comment: "Total unique reach"
    - name: "total_video_views"
      expr: SUM(CAST(video_views AS DOUBLE))
      comment: "Total video views"
    - name: "total_view_through_conversions"
      expr: SUM(CAST(view_through_conversions AS DOUBLE))
      comment: "Total view-through conversions"
    - name: "avg_ctr"
      expr: AVG(CAST(ctr AS DOUBLE))
      comment: "Average click-through rate"
    - name: "avg_conversion_rate"
      expr: AVG(CAST(conversion_rate AS DOUBLE))
      comment: "Average conversion rate"
    - name: "avg_cpc"
      expr: AVG(CAST(cpc AS DOUBLE))
      comment: "Average cost per click"
    - name: "avg_cpm"
      expr: AVG(CAST(cpm AS DOUBLE))
      comment: "Average cost per thousand impressions"
    - name: "avg_cpa"
      expr: AVG(CAST(cpa AS DOUBLE))
      comment: "Average cost per acquisition"
    - name: "avg_roas"
      expr: AVG(CAST(roas AS DOUBLE))
      comment: "Average return on ad spend"
    - name: "avg_frequency"
      expr: AVG(CAST(frequency AS DOUBLE))
      comment: "Average frequency of exposure"
    - name: "avg_video_completion_rate"
      expr: AVG(CAST(video_completion_rate AS DOUBLE))
      comment: "Average video completion rate"
    - name: "blended_roas"
      expr: ROUND(SUM(CAST(revenue_amount AS DOUBLE)) / NULLIF(SUM(CAST(cost_amount AS DOUBLE)), 0), 2)
      comment: "Blended return on ad spend across all digital activity - critical ROI steering metric"
    - name: "blended_ctr"
      expr: ROUND(100.0 * SUM(CAST(clicks AS DOUBLE)) / NULLIF(SUM(CAST(impressions AS DOUBLE)), 0), 2)
      comment: "Blended click-through rate - key engagement metric"
    - name: "blended_conversion_rate"
      expr: ROUND(100.0 * SUM(CAST(conversions AS DOUBLE)) / NULLIF(SUM(CAST(clicks AS DOUBLE)), 0), 2)
      comment: "Blended conversion rate - key funnel efficiency metric"
    - name: "blended_cpa"
      expr: ROUND(SUM(CAST(cost_amount AS DOUBLE)) / NULLIF(SUM(CAST(conversions AS DOUBLE)), 0), 2)
      comment: "Blended cost per acquisition - key efficiency metric for investment decisions"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`marketing_brand`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Brand health and equity metrics tracking awareness, consideration, preference, market share, and brand value"
  source: "`vibe_consumer_goods_v1`.`marketing`.`marketing_brand`"
  dimensions:
    - name: "brand_status"
      expr: brand_status
      comment: "Current status of the brand"
    - name: "brand_category"
      expr: brand_category
      comment: "Category the brand operates in"
    - name: "architecture_tier"
      expr: architecture_tier
      comment: "Brand architecture tier (master, sub-brand, endorsed, etc.)"
    - name: "lifecycle_stage"
      expr: lifecycle_stage
      comment: "Lifecycle stage of the brand (launch, growth, mature, decline)"
    - name: "geographic_market_scope"
      expr: geographic_market_scope
      comment: "Geographic scope of the brand (global, regional, local)"
    - name: "primary_distribution_channel"
      expr: primary_distribution_channel
      comment: "Primary distribution channel for the brand"
    - name: "target_consumer_segment"
      expr: target_consumer_segment
      comment: "Target consumer segment for the brand"
    - name: "launch_year"
      expr: YEAR(launch_date)
      comment: "Year the brand was launched"
  measures:
    - name: "total_brands"
      expr: COUNT(DISTINCT marketing_brand_id)
      comment: "Total number of distinct brands"
    - name: "total_brand_valuation"
      expr: SUM(CAST(valuation_amount AS DOUBLE))
      comment: "Total brand valuation across portfolio"
    - name: "total_annual_marketing_budget"
      expr: SUM(CAST(annual_marketing_budget AS DOUBLE))
      comment: "Total annual marketing budget across brands"
    - name: "total_annual_revenue_target"
      expr: SUM(CAST(annual_revenue_target AS DOUBLE))
      comment: "Total annual revenue target across brands"
    - name: "avg_brand_valuation"
      expr: AVG(CAST(valuation_amount AS DOUBLE))
      comment: "Average brand valuation"
    - name: "avg_awareness_percent"
      expr: AVG(CAST(awareness_percent AS DOUBLE))
      comment: "Average brand awareness percentage - key brand health metric"
    - name: "avg_consideration_percent"
      expr: AVG(CAST(consideration_percent AS DOUBLE))
      comment: "Average brand consideration percentage - key funnel metric"
    - name: "avg_preference_percent"
      expr: AVG(CAST(preference_percent AS DOUBLE))
      comment: "Average brand preference percentage - key competitive positioning metric"
    - name: "avg_equity_score"
      expr: AVG(CAST(equity_score AS DOUBLE))
      comment: "Average brand equity score - key brand strength metric"
    - name: "avg_nps_score"
      expr: AVG(CAST(nps_score AS DOUBLE))
      comment: "Average Net Promoter Score - key loyalty and advocacy metric"
    - name: "avg_som_percent"
      expr: AVG(CAST(som_percent AS DOUBLE))
      comment: "Average share of market percentage - key competitive performance metric"
    - name: "avg_sov_percent"
      expr: AVG(CAST(sov_percent AS DOUBLE))
      comment: "Average share of voice percentage - key media presence metric"
    - name: "avg_target_som_percent"
      expr: AVG(CAST(target_som_percent AS DOUBLE))
      comment: "Average target share of market percentage"
    - name: "avg_target_sov_percent"
      expr: AVG(CAST(target_sov_percent AS DOUBLE))
      comment: "Average target share of voice percentage"
    - name: "consideration_conversion_rate"
      expr: ROUND(100.0 * AVG(CAST(consideration_percent AS DOUBLE)) / NULLIF(AVG(CAST(awareness_percent AS DOUBLE)), 0), 2)
      comment: "Rate at which awareness converts to consideration - key funnel efficiency metric"
    - name: "preference_conversion_rate"
      expr: ROUND(100.0 * AVG(CAST(preference_percent AS DOUBLE)) / NULLIF(AVG(CAST(consideration_percent AS DOUBLE)), 0), 2)
      comment: "Rate at which consideration converts to preference - key funnel efficiency metric"
    - name: "som_to_sov_ratio"
      expr: ROUND(AVG(CAST(som_percent AS DOUBLE)) / NULLIF(AVG(CAST(sov_percent AS DOUBLE)), 0), 2)
      comment: "Ratio of market share to voice share - key media efficiency metric (>1 indicates efficient spend)"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`marketing_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Marketing budget performance metrics tracking spend variance, utilization, and allocation efficiency"
  source: "`vibe_consumer_goods_v1`.`marketing`.`marketing_budget`"
  dimensions:
    - name: "budget_status"
      expr: budget_status
      comment: "Current status of the budget"
    - name: "budget_type"
      expr: budget_type
      comment: "Type of budget (annual, campaign, project, etc.)"
    - name: "campaign_type"
      expr: campaign_type
      comment: "Type of campaign this budget supports"
    - name: "channel"
      expr: channel
      comment: "Marketing channel for this budget"
    - name: "geography_scope"
      expr: geography_scope
      comment: "Geographic scope of the budget"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the budget"
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter of the budget"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the budget"
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost center code for the budget"
  measures:
    - name: "total_budgets"
      expr: COUNT(DISTINCT marketing_budget_id)
      comment: "Total number of distinct budget records"
    - name: "total_budget_amount"
      expr: SUM(CAST(total_budget_amount AS DOUBLE))
      comment: "Total budget amount allocated"
    - name: "total_actual_spend"
      expr: SUM(CAST(actual_spend_amount AS DOUBLE))
      comment: "Total actual spend against budgets"
    - name: "total_committed_spend"
      expr: SUM(CAST(committed_spend_amount AS DOUBLE))
      comment: "Total committed spend (obligated but not yet spent)"
    - name: "total_working_media_budget"
      expr: SUM(CAST(working_media_budget_amount AS DOUBLE))
      comment: "Total working media budget (media spend that reaches consumers)"
    - name: "total_non_working_budget"
      expr: SUM(CAST(non_working_budget_amount AS DOUBLE))
      comment: "Total non-working budget (production, agency fees, etc.)"
    - name: "total_production_budget"
      expr: SUM(CAST(production_budget_amount AS DOUBLE))
      comment: "Total production budget"
    - name: "total_agency_fee"
      expr: SUM(CAST(agency_fee_amount AS DOUBLE))
      comment: "Total agency fees"
    - name: "total_research_budget"
      expr: SUM(CAST(research_budget_amount AS DOUBLE))
      comment: "Total research budget"
    - name: "total_contingency_budget"
      expr: SUM(CAST(contingency_budget_amount AS DOUBLE))
      comment: "Total contingency budget"
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average variance percentage between budget and actual"
    - name: "budget_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_spend_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_budget_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of total budget actually spent - key budget efficiency metric"
    - name: "committed_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(committed_spend_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_budget_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of total budget committed - key budget planning metric"
    - name: "working_media_ratio"
      expr: ROUND(100.0 * SUM(CAST(working_media_budget_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_budget_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of budget allocated to working media - key efficiency metric (higher is better)"
    - name: "non_working_ratio"
      expr: ROUND(100.0 * SUM(CAST(non_working_budget_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_budget_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of budget allocated to non-working costs - key efficiency metric (lower is better)"
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total variance amount between budget and actual"
    - name: "budget_variance_rate"
      expr: ROUND(100.0 * SUM(CAST(variance_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_budget_amount AS DOUBLE)), 0), 2)
      comment: "Overall budget variance rate - key budget control metric for steering decisions"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`marketing_media_spend`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Media spend reconciliation and efficiency metrics tracking planned vs actual spend, payment status, and channel allocation"
  source: "`vibe_consumer_goods_v1`.`marketing`.`media_spend`"
  dimensions:
    - name: "media_channel"
      expr: media_channel
      comment: "Media channel (TV, digital, print, radio, OOH, etc.)"
    - name: "media_subchannel"
      expr: media_subchannel
      comment: "Media subchannel within the channel"
    - name: "buy_type"
      expr: buy_type
      comment: "Type of media buy (programmatic, direct, etc.)"
    - name: "placement_type"
      expr: placement_type
      comment: "Type of placement"
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status (pending, paid, disputed, etc.)"
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status between planned and actual"
    - name: "geography_scope"
      expr: geography_scope
      comment: "Geographic scope of the spend"
    - name: "market_name"
      expr: market_name
      comment: "Market name"
    - name: "agency_name"
      expr: agency_name
      comment: "Agency managing the spend"
    - name: "spend_year"
      expr: YEAR(spend_date)
      comment: "Year of spend"
    - name: "spend_month"
      expr: DATE_TRUNC('MONTH', spend_date)
      comment: "Month of spend"
    - name: "spend_period"
      expr: spend_period
      comment: "Spend period"
  measures:
    - name: "total_spend_records"
      expr: COUNT(DISTINCT media_spend_id)
      comment: "Total number of distinct media spend records"
    - name: "total_planned_spend"
      expr: SUM(CAST(planned_spend_amount AS DOUBLE))
      comment: "Total planned media spend"
    - name: "total_invoiced_spend"
      expr: SUM(CAST(invoiced_spend_amount AS DOUBLE))
      comment: "Total invoiced media spend"
    - name: "total_working_spend"
      expr: SUM(CAST(working_spend_amount AS DOUBLE))
      comment: "Total working media spend (actual media cost)"
    - name: "total_non_working_spend"
      expr: SUM(CAST(non_working_spend_amount AS DOUBLE))
      comment: "Total non-working spend (production, fees, etc.)"
    - name: "total_production_cost"
      expr: SUM(CAST(production_cost_amount AS DOUBLE))
      comment: "Total production costs"
    - name: "total_agency_fee"
      expr: SUM(CAST(agency_fee_amount AS DOUBLE))
      comment: "Total agency fees"
    - name: "total_impressions_delivered"
      expr: SUM(CAST(impressions_delivered AS DOUBLE))
      comment: "Total impressions delivered"
    - name: "total_clicks_delivered"
      expr: SUM(CAST(clicks_delivered AS DOUBLE))
      comment: "Total clicks delivered"
    - name: "total_video_views_delivered"
      expr: SUM(CAST(video_views_delivered AS DOUBLE))
      comment: "Total video views delivered"
    - name: "avg_cpm_actual"
      expr: AVG(CAST(cpm_actual AS DOUBLE))
      comment: "Average actual cost per thousand impressions"
    - name: "avg_cpc_actual"
      expr: AVG(CAST(cpc_actual AS DOUBLE))
      comment: "Average actual cost per click"
    - name: "avg_cpv_actual"
      expr: AVG(CAST(cpv_actual AS DOUBLE))
      comment: "Average actual cost per video view"
    - name: "spend_variance_amount"
      expr: SUM(CAST(variance_to_plan_amount AS DOUBLE))
      comment: "Total variance between planned and invoiced spend"
    - name: "spend_variance_rate"
      expr: ROUND(100.0 * SUM(CAST(variance_to_plan_amount AS DOUBLE)) / NULLIF(SUM(CAST(planned_spend_amount AS DOUBLE)), 0), 2)
      comment: "Percentage variance between planned and invoiced spend - key budget control metric"
    - name: "working_spend_ratio"
      expr: ROUND(100.0 * SUM(CAST(working_spend_amount AS DOUBLE)) / NULLIF(SUM(CAST(invoiced_spend_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of invoiced spend that is working media - key efficiency metric"
    - name: "blended_cpm"
      expr: ROUND(1000.0 * SUM(CAST(working_spend_amount AS DOUBLE)) / NULLIF(SUM(CAST(impressions_delivered AS DOUBLE)), 0), 2)
      comment: "Blended cost per thousand impressions - key media efficiency metric"
    - name: "blended_cpc"
      expr: ROUND(SUM(CAST(working_spend_amount AS DOUBLE)) / NULLIF(SUM(CAST(clicks_delivered AS DOUBLE)), 0), 2)
      comment: "Blended cost per click - key engagement efficiency metric"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`marketing_brand_health_tracker`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Brand health tracking metrics measuring awareness, consideration, preference, NPS, sentiment, and competitive positioning"
  source: "`vibe_consumer_goods_v1`.`marketing`.`brand_health_tracker`"
  dimensions:
    - name: "market_geography"
      expr: market_geography
      comment: "Geographic market for brand health measurement"
    - name: "channel_type"
      expr: channel_type
      comment: "Channel type for brand health measurement"
    - name: "data_source"
      expr: data_source
      comment: "Source of brand health data"
    - name: "tracking_year"
      expr: YEAR(tracking_period_start_date)
      comment: "Year of tracking period"
    - name: "tracking_quarter"
      expr: CONCAT('Q', QUARTER(tracking_period_start_date))
      comment: "Quarter of tracking period"
  measures:
    - name: "total_tracking_records"
      expr: COUNT(DISTINCT brand_health_tracker_id)
      comment: "Total number of brand health tracking records"
    - name: "avg_spontaneous_awareness"
      expr: AVG(CAST(spontaneous_awareness_pct AS DOUBLE))
      comment: "Average spontaneous brand awareness percentage - key top-of-mind metric"
    - name: "avg_aided_awareness"
      expr: AVG(CAST(aided_awareness_pct AS DOUBLE))
      comment: "Average aided brand awareness percentage - key brand recognition metric"
    - name: "avg_consideration"
      expr: AVG(CAST(consideration_pct AS DOUBLE))
      comment: "Average brand consideration percentage - key funnel metric"
    - name: "avg_preference"
      expr: AVG(CAST(preference_pct AS DOUBLE))
      comment: "Average brand preference percentage - key competitive positioning metric"
    - name: "avg_purchase_intent"
      expr: AVG(CAST(purchase_intent_pct AS DOUBLE))
      comment: "Average purchase intent percentage - key conversion likelihood metric"
    - name: "avg_nps_score"
      expr: AVG(CAST(nps_score AS DOUBLE))
      comment: "Average Net Promoter Score - key loyalty and advocacy metric"
    - name: "avg_brand_equity_index"
      expr: AVG(CAST(brand_equity_index AS DOUBLE))
      comment: "Average brand equity index - key overall brand strength metric"
    - name: "avg_quality_perception"
      expr: AVG(CAST(quality_perception_score AS DOUBLE))
      comment: "Average quality perception score - key product perception metric"
    - name: "avg_value_perception"
      expr: AVG(CAST(value_perception_score AS DOUBLE))
      comment: "Average value perception score - key pricing perception metric"
    - name: "avg_innovation_perception"
      expr: AVG(CAST(innovation_perception_score AS DOUBLE))
      comment: "Average innovation perception score - key differentiation metric"
    - name: "avg_trust_perception"
      expr: AVG(CAST(trust_perception_score AS DOUBLE))
      comment: "Average trust perception score - key brand integrity metric"
    - name: "avg_sustainability_perception"
      expr: AVG(CAST(sustainability_perception_score AS DOUBLE))
      comment: "Average sustainability perception score - key ESG brand metric"
    - name: "avg_som_value"
      expr: AVG(CAST(som_value_pct AS DOUBLE))
      comment: "Average share of market by value - key competitive performance metric"
    - name: "avg_som_volume"
      expr: AVG(CAST(som_volume_pct AS DOUBLE))
      comment: "Average share of market by volume - key competitive performance metric"
    - name: "avg_sov_total"
      expr: AVG(CAST(sov_total_pct AS DOUBLE))
      comment: "Average total share of voice - key media presence metric"
    - name: "avg_net_sentiment"
      expr: AVG(CAST(net_sentiment_score AS DOUBLE))
      comment: "Average net sentiment score - key brand perception metric"
    - name: "total_social_mentions"
      expr: SUM(CAST(social_mention_volume AS DOUBLE))
      comment: "Total social media mention volume"
    - name: "avg_social_positive_sentiment"
      expr: AVG(CAST(social_sentiment_positive_pct AS DOUBLE))
      comment: "Average positive social sentiment percentage"
    - name: "avg_social_negative_sentiment"
      expr: AVG(CAST(social_sentiment_negative_pct AS DOUBLE))
      comment: "Average negative social sentiment percentage"
    - name: "awareness_to_consideration_rate"
      expr: ROUND(100.0 * AVG(CAST(consideration_pct AS DOUBLE)) / NULLIF(AVG(CAST(aided_awareness_pct AS DOUBLE)), 0), 2)
      comment: "Rate at which awareness converts to consideration - key funnel efficiency metric"
    - name: "consideration_to_preference_rate"
      expr: ROUND(100.0 * AVG(CAST(preference_pct AS DOUBLE)) / NULLIF(AVG(CAST(consideration_pct AS DOUBLE)), 0), 2)
      comment: "Rate at which consideration converts to preference - key funnel efficiency metric"
    - name: "som_to_sov_efficiency"
      expr: ROUND(AVG(CAST(som_value_pct AS DOUBLE)) / NULLIF(AVG(CAST(sov_total_pct AS DOUBLE)), 0), 2)
      comment: "Ratio of market share to voice share - key media efficiency metric (>1 indicates efficient spend)"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`marketing_market_share_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Market share performance metrics tracking competitive positioning, share trends, and category dynamics"
  source: "`vibe_consumer_goods_v1`.`marketing`.`market_share_record`"
  dimensions:
    - name: "geography_level"
      expr: geography_level
      comment: "Level of geographic aggregation (national, regional, local)"
    - name: "geography_name"
      expr: geography_name
      comment: "Name of the geographic market"
    - name: "channel"
      expr: channel
      comment: "Sales channel (retail, e-commerce, foodservice, etc.)"
    - name: "market_definition"
      expr: market_definition
      comment: "Definition of the market being measured"
    - name: "period_type"
      expr: period_type
      comment: "Type of measurement period (weekly, monthly, quarterly, annual)"
    - name: "data_source"
      expr: data_source
      comment: "Source of market share data (Nielsen, IRI, etc.)"
    - name: "measurement_year"
      expr: YEAR(measurement_date)
      comment: "Year of measurement"
    - name: "measurement_quarter"
      expr: CONCAT('Q', QUARTER(measurement_date))
      comment: "Quarter of measurement"
  measures:
    - name: "total_share_records"
      expr: COUNT(DISTINCT market_share_record_id)
      comment: "Total number of market share records"
    - name: "total_brand_value"
      expr: SUM(CAST(brand_value_amount AS DOUBLE))
      comment: "Total brand sales value"
    - name: "total_brand_volume"
      expr: SUM(CAST(brand_volume_quantity AS DOUBLE))
      comment: "Total brand sales volume"
    - name: "total_category_value"
      expr: SUM(CAST(category_total_value_amount AS DOUBLE))
      comment: "Total category sales value"
    - name: "total_category_volume"
      expr: SUM(CAST(category_total_volume_quantity AS DOUBLE))
      comment: "Total category sales volume"
    - name: "avg_value_share"
      expr: AVG(CAST(value_share_percent AS DOUBLE))
      comment: "Average value share percentage - key competitive performance metric"
    - name: "avg_volume_share"
      expr: AVG(CAST(volume_share_percent AS DOUBLE))
      comment: "Average volume share percentage - key competitive performance metric"
    - name: "avg_acv"
      expr: AVG(CAST(acv_percent AS DOUBLE))
      comment: "Average all commodity volume (distribution) percentage - key availability metric"
    - name: "avg_share_point_change"
      expr: AVG(CAST(share_point_change AS DOUBLE))
      comment: "Average share point change - key momentum metric"
    - name: "avg_yoy_change"
      expr: AVG(CAST(year_over_year_change_percent AS DOUBLE))
      comment: "Average year-over-year change percentage - key growth metric"
    - name: "blended_value_share"
      expr: ROUND(100.0 * SUM(CAST(brand_value_amount AS DOUBLE)) / NULLIF(SUM(CAST(category_total_value_amount AS DOUBLE)), 0), 2)
      comment: "Blended value share across all records - key competitive positioning metric"
    - name: "blended_volume_share"
      expr: ROUND(100.0 * SUM(CAST(brand_volume_quantity AS DOUBLE)) / NULLIF(SUM(CAST(category_total_volume_quantity AS DOUBLE)), 0), 2)
      comment: "Blended volume share across all records - key competitive positioning metric"
    - name: "value_to_volume_share_ratio"
      expr: ROUND(AVG(CAST(value_share_percent AS DOUBLE)) / NULLIF(AVG(CAST(volume_share_percent AS DOUBLE)), 0), 2)
      comment: "Ratio of value share to volume share - key premium positioning metric (>1 indicates premium pricing)"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`marketing_attribution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Marketing attribution metrics tracking touchpoint contribution, conversion paths, and channel effectiveness"
  source: "`vibe_consumer_goods_v1`.`marketing`.`attribution`"
  dimensions:
    - name: "channel"
      expr: channel
      comment: "Marketing channel for this touchpoint"
    - name: "platform"
      expr: platform
      comment: "Platform within the channel"
    - name: "device_type"
      expr: device_type
      comment: "Device type for this touchpoint"
    - name: "model_type"
      expr: model_type
      comment: "Attribution model type (last-click, first-click, linear, time-decay, etc.)"
    - name: "conversion_type"
      expr: conversion_type
      comment: "Type of conversion (purchase, signup, download, etc.)"
    - name: "geography"
      expr: geography
      comment: "Geographic market"
    - name: "market_segment"
      expr: market_segment
      comment: "Market segment"
    - name: "attribution_status"
      expr: attribution_status
      comment: "Status of attribution record"
    - name: "conversion_year"
      expr: YEAR(conversion_timestamp)
      comment: "Year of conversion"
    - name: "conversion_month"
      expr: DATE_TRUNC('MONTH', conversion_timestamp)
      comment: "Month of conversion"
  measures:
    - name: "total_attribution_records"
      expr: COUNT(DISTINCT attribution_id)
      comment: "Total number of attribution records"
    - name: "total_attributed_revenue"
      expr: SUM(CAST(attributed_revenue_amount AS DOUBLE))
      comment: "Total revenue attributed to marketing touchpoints"
    - name: "total_attributed_conversions"
      expr: SUM(CAST(attributed_conversions AS DOUBLE))
      comment: "Total conversions attributed to marketing touchpoints"
    - name: "total_media_spend_attributed"
      expr: SUM(CAST(media_spend_attributed_amount AS DOUBLE))
      comment: "Total media spend attributed to conversions"
    - name: "avg_cpa"
      expr: AVG(CAST(cpa AS DOUBLE))
      comment: "Average cost per acquisition"
    - name: "avg_roas"
      expr: AVG(CAST(roas AS DOUBLE))
      comment: "Average return on ad spend"
    - name: "avg_time_to_conversion_hours"
      expr: AVG(CAST(time_to_conversion_hours AS DOUBLE))
      comment: "Average time from touchpoint to conversion in hours - key conversion velocity metric"
    - name: "avg_weight"
      expr: AVG(CAST(weight AS DOUBLE))
      comment: "Average attribution weight assigned to touchpoints"
    - name: "blended_roas"
      expr: ROUND(SUM(CAST(attributed_revenue_amount AS DOUBLE)) / NULLIF(SUM(CAST(media_spend_attributed_amount AS DOUBLE)), 0), 2)
      comment: "Blended return on ad spend across all attributed touchpoints - critical ROI metric"
    - name: "blended_cpa"
      expr: ROUND(SUM(CAST(media_spend_attributed_amount AS DOUBLE)) / NULLIF(SUM(CAST(attributed_conversions AS DOUBLE)), 0), 2)
      comment: "Blended cost per acquisition across all attributed touchpoints - key efficiency metric"
    - name: "avg_revenue_per_conversion"
      expr: ROUND(SUM(CAST(attributed_revenue_amount AS DOUBLE)) / NULLIF(SUM(CAST(attributed_conversions AS DOUBLE)), 0), 2)
      comment: "Average revenue per attributed conversion - key value metric"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`marketing_social_listening_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Social listening metrics tracking brand mentions, sentiment, share of voice, and conversation themes across social platforms"
  source: "`vibe_consumer_goods_v1`.`marketing`.`social_listening_record`"
  dimensions:
    - name: "monitoring_topic"
      expr: monitoring_topic
      comment: "Topic being monitored (brand, product, campaign, competitor, etc.)"
    - name: "geography_scope"
      expr: geography_scope
      comment: "Geographic scope of monitoring"
    - name: "data_source_provider"
      expr: data_source_provider
      comment: "Social listening data provider"
    - name: "sentiment_analysis_model"
      expr: sentiment_analysis_model
      comment: "Sentiment analysis model used"
    - name: "observation_year"
      expr: YEAR(observation_period_start_date)
      comment: "Year of observation period"
    - name: "observation_month"
      expr: DATE_TRUNC('MONTH', observation_period_start_date)
      comment: "Month of observation period"
  measures:
    - name: "total_listening_records"
      expr: COUNT(DISTINCT social_listening_record_id)
      comment: "Total number of social listening records"
    - name: "total_mention_volume"
      expr: SUM(CAST(total_mention_volume AS DOUBLE))
      comment: "Total social media mention volume"
    - name: "total_positive_mentions"
      expr: SUM(CAST(positive_mention_count AS DOUBLE))
      comment: "Total positive mentions"
    - name: "total_negative_mentions"
      expr: SUM(CAST(negative_mention_count AS DOUBLE))
      comment: "Total negative mentions"
    - name: "total_neutral_mentions"
      expr: SUM(CAST(neutral_mention_count AS DOUBLE))
      comment: "Total neutral mentions"
    - name: "total_engagement"
      expr: SUM(CAST(engagement_count AS DOUBLE))
      comment: "Total engagement (likes, shares, comments, etc.)"
    - name: "total_reach_estimate"
      expr: SUM(CAST(reach_estimate AS DOUBLE))
      comment: "Total estimated reach"
    - name: "total_impressions_estimate"
      expr: SUM(CAST(impressions_estimate AS DOUBLE))
      comment: "Total estimated impressions"
    - name: "total_influencer_mentions"
      expr: SUM(CAST(influencer_mention_count AS DOUBLE))
      comment: "Total mentions by influencers"
    - name: "total_twitter_mentions"
      expr: SUM(CAST(twitter_mention_count AS DOUBLE))
      comment: "Total Twitter mentions"
    - name: "total_facebook_mentions"
      expr: SUM(CAST(facebook_mention_count AS DOUBLE))
      comment: "Total Facebook mentions"
    - name: "total_instagram_mentions"
      expr: SUM(CAST(instagram_mention_count AS DOUBLE))
      comment: "Total Instagram mentions"
    - name: "total_tiktok_mentions"
      expr: SUM(CAST(tiktok_mention_count AS DOUBLE))
      comment: "Total TikTok mentions"
    - name: "total_youtube_mentions"
      expr: SUM(CAST(youtube_mention_count AS DOUBLE))
      comment: "Total YouTube mentions"
    - name: "total_reddit_mentions"
      expr: SUM(CAST(reddit_mention_count AS DOUBLE))
      comment: "Total Reddit mentions"
    - name: "avg_net_sentiment_score"
      expr: AVG(CAST(net_sentiment_score AS DOUBLE))
      comment: "Average net sentiment score - key brand perception metric"
    - name: "avg_share_of_conversation"
      expr: AVG(CAST(share_of_conversation_percent AS DOUBLE))
      comment: "Average share of conversation percentage - key competitive voice metric"
    - name: "positive_sentiment_rate"
      expr: ROUND(100.0 * SUM(CAST(positive_mention_count AS DOUBLE)) / NULLIF(SUM(CAST(total_mention_volume AS DOUBLE)), 0), 2)
      comment: "Percentage of mentions that are positive - key sentiment health metric"
    - name: "negative_sentiment_rate"
      expr: ROUND(100.0 * SUM(CAST(negative_mention_count AS DOUBLE)) / NULLIF(SUM(CAST(total_mention_volume AS DOUBLE)), 0), 2)
      comment: "Percentage of mentions that are negative - key risk monitoring metric"
    - name: "engagement_rate"
      expr: ROUND(100.0 * SUM(CAST(engagement_count AS DOUBLE)) / NULLIF(SUM(CAST(total_mention_volume AS DOUBLE)), 0), 2)
      comment: "Engagement rate per mention - key content resonance metric"
    - name: "influencer_amplification_rate"
      expr: ROUND(100.0 * SUM(CAST(influencer_mention_count AS DOUBLE)) / NULLIF(SUM(CAST(total_mention_volume AS DOUBLE)), 0), 2)
      comment: "Percentage of mentions from influencers - key amplification metric"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`marketing_brand_health`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key health indicators for marketing brands."
  source: "`vibe_consumer_goods_v1`.`marketing`.`brand_health_tracker`"
  dimensions:
    - name: "measurement_month"
      expr: DATE_TRUNC('month', measurement_timestamp)
      comment: "Month of the measurement."
    - name: "market_geography"
      expr: market_geography
      comment: "Geographic market scope."
    - name: "channel_type"
      expr: channel_type
      comment: "Channel type (digital, TV, OOH, etc.)."
  measures:
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of brand health records."
    - name: "avg_brand_equity_index"
      expr: AVG(CAST(brand_equity_index AS DOUBLE))
      comment: "Average brand equity index."
    - name: "avg_nps_score"
      expr: AVG(CAST(nps_score AS DOUBLE))
      comment: "Average Net Promoter Score."
    - name: "avg_sov_total_pct"
      expr: AVG(CAST(sov_total_pct AS DOUBLE))
      comment: "Average Share of Voice total percent."
    - name: "avg_share_of_conversation_pct"
      expr: AVG(CAST(share_of_conversation_pct AS DOUBLE))
      comment: "Average share of conversation percent."
    - name: "avg_sustainability_perception_score"
      expr: AVG(CAST(sustainability_perception_score AS DOUBLE))
      comment: "Average sustainability perception score."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`marketing_campaign_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Campaign level spend performance metrics."
  source: "`vibe_consumer_goods_v1`.`marketing`.`campaign`"
  dimensions:
    - name: "campaign_name"
      expr: campaign_name
      comment: "Name of the campaign."
    - name: "campaign_status"
      expr: campaign_status
      comment: "Current status of the campaign."
    - name: "campaign_type"
      expr: campaign_type
      comment: "Type/category of the campaign."
    - name: "channel_mix"
      expr: channel_mix
      comment: "Channel mix description."
    - name: "country_codes"
      expr: country_codes
      comment: "Comma‑separated list of target country codes."
    - name: "is_active"
      expr: is_active
      comment: "Flag indicating if the campaign is active."
    - name: "campaign_start_month"
      expr: DATE_TRUNC('month', actual_start_date)
      comment: "Month of campaign start."
  measures:
    - name: "campaign_count"
      expr: COUNT(1)
      comment: "Number of campaign records."
    - name: "total_actual_media_spend"
      expr: SUM(CAST(actual_media_spend_amount AS DOUBLE))
      comment: "Sum of actual media spend."
    - name: "total_planned_media_spend"
      expr: SUM(CAST(planned_media_spend_amount AS DOUBLE))
      comment: "Sum of planned media spend."
    - name: "spend_variance_amount"
      expr: SUM(actual_media_spend_amount - planned_media_spend_amount)
      comment: "Variance between actual and planned spend (positive = overspend)."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`marketing_campaign_flight_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Performance metrics at the flight (flight) level."
  source: "`vibe_consumer_goods_v1`.`marketing`.`campaign_flight`"
  dimensions:
    - name: "flight_name"
      expr: flight_name
      comment: "Descriptive name of the flight."
    - name: "channel"
      expr: channel
      comment: "Marketing channel for the flight."
    - name: "platform"
      expr: platform
      comment: "Platform (e.g., TV, digital) used."
    - name: "market_geography"
      expr: market_geography
      comment: "Geographic market targeted."
    - name: "flight_status"
      expr: flight_status
      comment: "Current status of the flight."
    - name: "flight_start_month"
      expr: DATE_TRUNC('month', actual_start_date)
      comment: "Month the flight started."
  measures:
    - name: "flight_count"
      expr: COUNT(1)
      comment: "Number of flight records."
    - name: "total_impressions"
      expr: SUM(CAST(actual_impressions AS DOUBLE))
      comment: "Sum of actual impressions delivered."
    - name: "total_clicks"
      expr: SUM(CAST(clicks AS DOUBLE))
      comment: "Sum of clicks delivered."
    - name: "total_conversions"
      expr: SUM(CAST(conversions AS DOUBLE))
      comment: "Sum of conversions recorded."
    - name: "avg_ctr"
      expr: AVG(CAST(ctr AS DOUBLE))
      comment: "Average click‑through rate across flights."
    - name: "avg_cpa"
      expr: AVG(CAST(cpa AS DOUBLE))
      comment: "Average cost per acquisition across flights."
    - name: "total_budget_allocated_amount"
      expr: SUM(CAST(budget_allocated_amount AS DOUBLE))
      comment: "Total budget allocated to flights."
    - name: "total_budget_spent_amount"
      expr: SUM(CAST(budget_spent_amount AS DOUBLE))
      comment: "Total budget actually spent by flights."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`marketing_market_share`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Market share metrics by brand, SKU and geography."
  source: "`vibe_consumer_goods_v1`.`marketing`.`market_share_record`"
  dimensions:
    - name: "marketing_brand_id"
      expr: marketing_brand_id
      comment: "Marketing brand identifier."
    - name: "sku_id"
      expr: sku_id
      comment: "SKU identifier."
    - name: "category_id"
      expr: category_id
      comment: "Product category identifier."
    - name: "geography_name"
      expr: geography_name
      comment: "Geography name."
    - name: "measurement_date"
      expr: measurement_date
      comment: "Date of measurement."
    - name: "channel"
      expr: channel
      comment: "Channel associated with the market share record."
  measures:
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of market share records."
    - name: "total_brand_volume"
      expr: SUM(CAST(brand_volume_quantity AS DOUBLE))
      comment: "Total brand volume quantity."
    - name: "total_brand_value"
      expr: SUM(CAST(brand_value_amount AS DOUBLE))
      comment: "Total brand value amount."
    - name: "avg_volume_share_percent"
      expr: AVG(CAST(volume_share_percent AS DOUBLE))
      comment: "Average volume share percent."
    - name: "avg_value_share_percent"
      expr: AVG(CAST(value_share_percent AS DOUBLE))
      comment: "Average value share percent."
    - name: "avg_acv_percent"
      expr: AVG(CAST(acv_percent AS DOUBLE))
      comment: "Average ACV percent."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`marketing_social_listening`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Social listening and sentiment metrics for brands."
  source: "`vibe_consumer_goods_v1`.`marketing`.`social_listening_record`"
  dimensions:
    - name: "marketing_brand_id"
      expr: marketing_brand_id
      comment: "Identifier of the marketing brand."
    - name: "observation_month"
      expr: DATE_TRUNC('month', observation_period_start_date)
      comment: "Month of the observation period start."
    - name: "geography_scope"
      expr: geography_scope
      comment: "Geographic scope of the listening data."
  measures:
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of social listening records."
    - name: "total_mention_volume"
      expr: SUM(CAST(total_mention_volume AS DOUBLE))
      comment: "Total volume of brand mentions across social platforms."
    - name: "avg_sentiment_score"
      expr: AVG(CAST(net_sentiment_score AS DOUBLE))
      comment: "Average net sentiment score."
    - name: "total_engagement_count"
      expr: SUM(CAST(engagement_count AS DOUBLE))
      comment: "Total engagement count (likes, shares, comments)."
    - name: "avg_share_of_conversation_percent"
      expr: AVG(CAST(share_of_conversation_percent AS DOUBLE))
      comment: "Average share of conversation percent."
$$;