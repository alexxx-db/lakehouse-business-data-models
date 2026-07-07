-- Metric views for domain: marketing | Business: Consumer Goods | Version: 2 | Generated on: 2026-06-28 00:14:33

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`marketing_attribution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Marketing attribution KPIs — attributed revenue, conversions, ROAS, and CPA by channel and model. Used by performance marketing and analytics teams to optimize spend allocation."
  source: "`vibe_consumer_goods_v1`.`marketing`.`attribution`"
  dimensions:
    - name: "channel"
      expr: channel
      comment: "Marketing channel for attribution analysis (search, social, email, display, etc.)."
    - name: "model_type"
      expr: model_type
      comment: "Attribution model type (last-click, first-click, linear, data-driven) for model comparison."
    - name: "conversion_type"
      expr: conversion_type
      comment: "Type of conversion event (purchase, lead, signup) for funnel analysis."
    - name: "device_type"
      expr: device_type
      comment: "Device type for cross-device attribution analysis."
    - name: "platform"
      expr: platform
      comment: "Platform for channel-level attribution breakdown."
    - name: "attribution_status"
      expr: attribution_status
      comment: "Status of the attribution record."
    - name: "is_direct_conversion"
      expr: is_direct_conversion
      comment: "Flag indicating direct vs assisted conversion."
    - name: "is_view_through"
      expr: is_view_through
      comment: "Flag indicating view-through vs click-through attribution."
    - name: "conversion_timestamp"
      expr: conversion_timestamp
      comment: "Timestamp of the conversion event for time-based attribution analysis."
  measures:
    - name: "total_attributed_revenue"
      expr: SUM(CAST(attributed_revenue_amount AS DOUBLE))
      comment: "Total attributed revenue — primary revenue impact KPI for marketing investment justification."
    - name: "total_attributed_conversions"
      expr: SUM(CAST(attributed_conversions AS DOUBLE))
      comment: "Total attributed conversions — measures marketing-driven conversion volume."
    - name: "total_media_spend_attributed"
      expr: SUM(CAST(media_spend_attributed_amount AS DOUBLE))
      comment: "Total media spend attributed to conversions — measures productive spend."
    - name: "avg_attribution_weight"
      expr: AVG(CAST(attribution_weight AS DOUBLE))
      comment: "Average attribution weight — measures relative contribution of touchpoints."
    - name: "avg_roas"
      expr: AVG(CAST(roas AS DOUBLE))
      comment: "Average ROAS — primary efficiency KPI for attributed spend."
    - name: "avg_cpa"
      expr: AVG(CAST(cpa AS DOUBLE))
      comment: "Average cost per acquisition — measures efficiency of converting spend to customers."
    - name: "avg_time_to_conversion_hours"
      expr: AVG(CAST(time_to_conversion_hours AS DOUBLE))
      comment: "Average time to conversion in hours — measures purchase journey length for funnel optimization."
    - name: "aggregate_roas"
      expr: ROUND(SUM(CAST(attributed_revenue_amount AS DOUBLE)) / NULLIF(SUM(CAST(media_spend_attributed_amount AS DOUBLE)), 0), 2)
      comment: "Aggregate ROAS — total attributed revenue per dollar of attributed spend; executive-level efficiency KPI."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`marketing_brand_health`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key health indicators for marketing brands."
  source: "`consumer_goods_ecm`.`marketing`.`brand_health_tracker`"
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

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`marketing_brand_health_tracker`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Brand health tracking KPIs — awareness, consideration, preference, NPS, SOV, and sentiment. Used by brand managers and CMO for brand equity steering."
  source: "`vibe_consumer_goods_v1`.`marketing`.`brand_health_tracker`"
  dimensions:
    - name: "measurement_period"
      expr: measurement_period
      comment: "Measurement period (monthly, quarterly, annual) for trend analysis."
    - name: "channel_type"
      expr: channel_type
      comment: "Channel type for channel-specific brand health analysis."
    - name: "market_geography"
      expr: market_geography
      comment: "Geographic market for regional brand health comparison."
    - name: "region"
      expr: region
      comment: "Region for geographic brand health segmentation."
    - name: "brand_health_tracker_status"
      expr: brand_health_tracker_status
      comment: "Status of the brand health tracking record."
    - name: "measurement_date"
      expr: measurement_date
      comment: "Date of brand health measurement for trend tracking."
    - name: "tracking_period_start_date"
      expr: tracking_period_start_date
      comment: "Start date of the tracking period."
    - name: "tracking_period_end_date"
      expr: tracking_period_end_date
      comment: "End date of the tracking period."
  measures:
    - name: "avg_awareness_pct"
      expr: AVG(CAST(awareness_pct AS DOUBLE))
      comment: "Average brand awareness percentage — measures top-of-mind brand salience."
    - name: "avg_aided_awareness_pct"
      expr: AVG(CAST(aided_awareness_pct AS DOUBLE))
      comment: "Average aided awareness percentage — measures prompted brand recognition."
    - name: "avg_spontaneous_awareness_pct"
      expr: AVG(CAST(spontaneous_awareness_pct AS DOUBLE))
      comment: "Average spontaneous (unaided) awareness — measures organic brand salience."
    - name: "avg_consideration_pct"
      expr: AVG(CAST(consideration_pct AS DOUBLE))
      comment: "Average brand consideration percentage — measures purchase funnel conversion from awareness."
    - name: "avg_preference_pct"
      expr: AVG(CAST(preference_pct AS DOUBLE))
      comment: "Average brand preference percentage — measures competitive differentiation."
    - name: "avg_purchase_intent_pct"
      expr: AVG(CAST(purchase_intent_pct AS DOUBLE))
      comment: "Average purchase intent percentage — leading indicator of sales performance."
    - name: "avg_nps_score"
      expr: AVG(CAST(nps_score AS DOUBLE))
      comment: "Average NPS score — measures consumer loyalty and advocacy strength."
    - name: "avg_brand_equity_index"
      expr: AVG(CAST(brand_equity_index AS DOUBLE))
      comment: "Average brand equity index — composite brand strength metric for executive steering."
    - name: "avg_net_sentiment_score"
      expr: AVG(CAST(net_sentiment_score AS DOUBLE))
      comment: "Average net sentiment score — measures overall consumer sentiment balance."
    - name: "avg_sov_total_pct"
      expr: AVG(CAST(sov_total_pct AS DOUBLE))
      comment: "Average total share of voice — measures brand visibility vs category competitors."
    - name: "avg_som_value_pct"
      expr: AVG(CAST(som_value_pct AS DOUBLE))
      comment: "Average share of market by value — measures revenue market position."
    - name: "avg_trust_perception_score"
      expr: AVG(CAST(trust_perception_score AS DOUBLE))
      comment: "Average trust perception score — measures brand credibility with consumers."
    - name: "avg_sustainability_perception_score"
      expr: AVG(CAST(sustainability_perception_score AS DOUBLE))
      comment: "Average sustainability perception score — measures ESG brand equity component."
    - name: "total_social_mention_volume"
      expr: SUM(CAST(social_mention_volume AS DOUBLE))
      comment: "Total social media mention volume — measures brand conversation scale."
    - name: "avg_share_of_conversation_pct"
      expr: AVG(CAST(share_of_conversation_pct AS DOUBLE))
      comment: "Average share of conversation — measures brand dominance in social discourse."
    - name: "sov_som_gap"
      expr: ROUND(AVG(CAST(sov_total_pct AS DOUBLE)) - AVG(CAST(som_value_pct AS DOUBLE)), 2)
      comment: "SOV minus SOM gap — investment efficiency signal; large positive gap indicates over-spending relative to share."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`marketing_campaign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for marketing campaigns — budget efficiency, spend pacing, ROI, and reach targeting. Used by CMO and brand VPs to steer campaign investment decisions."
  source: "`vibe_consumer_goods_v1`.`marketing`.`campaign`"
  dimensions:
    - name: "campaign_type"
      expr: campaign_type
      comment: "Type of campaign (e.g., digital, trade, brand) for performance segmentation."
    - name: "campaign_status"
      expr: campaign_status
      comment: "Current lifecycle status of the campaign (active, completed, paused)."
    - name: "primary_channel"
      expr: primary_channel
      comment: "Primary media channel for the campaign (TV, digital, OOH, etc.)."
    - name: "campaign_objective"
      expr: campaign_objective
      comment: "Strategic objective of the campaign (awareness, conversion, retention)."
    - name: "geography_scope"
      expr: geography_scope
      comment: "Geographic scope of the campaign for regional performance analysis."
    - name: "planned_start_date"
      expr: planned_start_date
      comment: "Planned campaign start date for timeline analysis."
    - name: "planned_end_date"
      expr: planned_end_date
      comment: "Planned campaign end date for timeline analysis."
    - name: "actual_start_date"
      expr: actual_start_date
      comment: "Actual campaign start date for schedule adherence tracking."
    - name: "is_active"
      expr: is_active
      comment: "Flag indicating whether the campaign is currently active."
  measures:
    - name: "total_campaigns"
      expr: COUNT(1)
      comment: "Total number of campaigns — baseline volume metric for portfolio sizing."
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total planned budget across all campaigns — primary investment sizing KPI for CMO."
    - name: "total_actual_spend"
      expr: SUM(CAST(actual_spend AS DOUBLE))
      comment: "Total actual spend incurred — tracks realized investment vs plan."
    - name: "total_planned_media_spend"
      expr: SUM(CAST(planned_media_spend_amount AS DOUBLE))
      comment: "Total planned media spend — working media investment commitment."
    - name: "total_actual_media_spend"
      expr: SUM(CAST(actual_media_spend_amount AS DOUBLE))
      comment: "Total actual media spend delivered — measures media execution fidelity."
    - name: "total_planned_production_cost"
      expr: SUM(CAST(planned_production_cost_amount AS DOUBLE))
      comment: "Total planned production cost — non-working spend commitment."
    - name: "total_actual_production_cost"
      expr: SUM(CAST(actual_production_cost_amount AS DOUBLE))
      comment: "Total actual production cost — non-working spend realization."
    - name: "avg_campaign_roi_pct"
      expr: AVG(CAST(roi_pct AS DOUBLE))
      comment: "Average campaign ROI percentage — key efficiency KPI for investment justification."
    - name: "avg_budget_per_campaign"
      expr: AVG(CAST(budget_amount AS DOUBLE))
      comment: "Average budget per campaign — used to benchmark campaign investment sizing."
    - name: "total_target_reach"
      expr: SUM(CAST(target_reach AS DOUBLE))
      comment: "Total planned audience reach across campaigns — measures scale of marketing effort."
    - name: "budget_utilization_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_spend AS DOUBLE)) / NULLIF(SUM(CAST(budget_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of budget consumed — critical pacing KPI; triggers reallocation if significantly under or over."
    - name: "media_spend_utilization_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_media_spend_amount AS DOUBLE)) / NULLIF(SUM(CAST(planned_media_spend_amount AS DOUBLE)), 0), 2)
      comment: "Actual vs planned media spend ratio — measures media execution efficiency."
    - name: "active_campaign_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Number of currently active campaigns — operational portfolio health indicator."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`marketing_campaign_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Campaign level spend performance metrics."
  source: "`consumer_goods_ecm`.`marketing`.`campaign`"
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

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`marketing_campaign_flight`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Flight-level media execution KPIs — impressions delivery, click performance, conversion efficiency, and ROAS. Used by media planners and performance marketing teams."
  source: "`vibe_consumer_goods_v1`.`marketing`.`campaign_flight`"
  dimensions:
    - name: "campaign_flight_status"
      expr: campaign_flight_status
      comment: "Current status of the flight (live, completed, paused)."
    - name: "channel"
      expr: channel
      comment: "Media channel for the flight (digital, TV, social, etc.)."
    - name: "platform"
      expr: platform
      comment: "Specific platform where the flight runs (Google, Meta, YouTube, etc.)."
    - name: "placement_type"
      expr: placement_type
      comment: "Ad placement type (banner, video, native, etc.)."
    - name: "market_geography"
      expr: market_geography
      comment: "Geographic market for the flight."
    - name: "target_audience"
      expr: target_audience
      comment: "Target audience segment for the flight."
    - name: "scheduled_start_date"
      expr: scheduled_start_date
      comment: "Scheduled start date of the flight."
    - name: "scheduled_end_date"
      expr: scheduled_end_date
      comment: "Scheduled end date of the flight."
    - name: "attribution_model"
      expr: attribution_model
      comment: "Attribution model applied to measure conversions for this flight."
  measures:
    - name: "total_flights"
      expr: COUNT(1)
      comment: "Total number of campaign flights — baseline volume for media execution portfolio."
    - name: "total_impressions_planned"
      expr: SUM(CAST(planned_impressions AS DOUBLE))
      comment: "Total planned impressions — measures intended media reach commitment."
    - name: "total_impressions_actual"
      expr: SUM(CAST(actual_impressions AS DOUBLE))
      comment: "Total actual impressions delivered — primary media delivery KPI."
    - name: "total_clicks"
      expr: SUM(CAST(clicks AS DOUBLE))
      comment: "Total clicks generated — measures audience engagement with ads."
    - name: "total_conversions"
      expr: SUM(CAST(conversions AS DOUBLE))
      comment: "Total conversions attributed to flights — direct revenue-driving outcome."
    - name: "total_video_views"
      expr: SUM(CAST(video_views AS DOUBLE))
      comment: "Total video views — measures video content consumption."
    - name: "total_budget_allocated"
      expr: SUM(CAST(budget_allocated_amount AS DOUBLE))
      comment: "Total budget allocated to flights — investment commitment tracking."
    - name: "total_budget_spent"
      expr: SUM(CAST(budget_spent_amount AS DOUBLE))
      comment: "Total budget spent on flights — actual investment realization."
    - name: "avg_ctr"
      expr: AVG(CAST(ctr AS DOUBLE))
      comment: "Average click-through rate — measures ad creative and targeting effectiveness."
    - name: "avg_conversion_rate"
      expr: AVG(CAST(conversion_rate AS DOUBLE))
      comment: "Average conversion rate across flights — measures bottom-funnel efficiency."
    - name: "avg_roas"
      expr: AVG(CAST(roas AS DOUBLE))
      comment: "Average return on ad spend — primary media efficiency KPI for investment decisions."
    - name: "avg_cpa"
      expr: AVG(CAST(cpa AS DOUBLE))
      comment: "Average cost per acquisition — measures efficiency of converting spend to customers."
    - name: "avg_cpc"
      expr: AVG(CAST(cpc AS DOUBLE))
      comment: "Average cost per click — measures paid media click efficiency."
    - name: "impressions_delivery_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_impressions AS DOUBLE)) / NULLIF(SUM(CAST(planned_impressions AS DOUBLE)), 0), 2)
      comment: "Impressions delivery rate vs plan — critical pacing KPI; triggers media optimization if below threshold."
    - name: "budget_spend_pct"
      expr: ROUND(100.0 * SUM(CAST(budget_spent_amount AS DOUBLE)) / NULLIF(SUM(CAST(budget_allocated_amount AS DOUBLE)), 0), 2)
      comment: "Budget spend rate — measures how efficiently allocated flight budget is being consumed."
    - name: "avg_video_completion_rate"
      expr: AVG(CAST(video_completion_rate AS DOUBLE))
      comment: "Average video completion rate — measures video ad quality and audience engagement depth."
    - name: "avg_frequency"
      expr: AVG(CAST(frequency AS DOUBLE))
      comment: "Average ad frequency — monitors overexposure risk to target audiences."
    - name: "avg_grp"
      expr: AVG(CAST(grp AS DOUBLE))
      comment: "Average gross rating points — traditional broadcast media weight measurement."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`marketing_campaign_flight_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Performance metrics at the flight (flight) level."
  source: "`consumer_goods_ecm`.`marketing`.`campaign_flight`"
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

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`marketing_consumer_segment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Consumer segment sizing and value KPIs — segment size, CLTV, NPS, and engagement profiles. Used by brand and insights teams to prioritize consumer investment."
  source: "`vibe_consumer_goods_v1`.`marketing`.`consumer_segment`"
  dimensions:
    - name: "segment_type"
      expr: segment_type
      comment: "Segment type (demographic, behavioral, psychographic) for segmentation methodology analysis."
    - name: "segmentation_model_type"
      expr: segmentation_model_type
      comment: "Segmentation model type for methodology comparison."
    - name: "strategic_priority_tier"
      expr: strategic_priority_tier
      comment: "Strategic priority tier for investment prioritization."
    - name: "price_sensitivity_level"
      expr: price_sensitivity_level
      comment: "Price sensitivity level for pricing strategy alignment."
    - name: "digital_engagement_level"
      expr: digital_engagement_level
      comment: "Digital engagement level for channel strategy."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the segment."
    - name: "consumer_segment_status"
      expr: consumer_segment_status
      comment: "Current status of the consumer segment."
    - name: "is_active"
      expr: is_active
      comment: "Flag indicating whether the segment is currently active."
    - name: "sustainability_consciousness_level"
      expr: sustainability_consciousness_level
      comment: "Sustainability consciousness level for ESG-aligned targeting."
  measures:
    - name: "total_segments"
      expr: COUNT(1)
      comment: "Total number of consumer segments — baseline portfolio sizing metric."
    - name: "total_segment_size"
      expr: SUM(CAST(segment_size_estimate AS DOUBLE))
      comment: "Total estimated segment size — measures total addressable consumer universe."
    - name: "avg_cltv_estimate"
      expr: AVG(CAST(cltv_estimate_usd AS DOUBLE))
      comment: "Average customer lifetime value estimate — primary segment value KPI for investment prioritization."
    - name: "avg_basket_size"
      expr: AVG(CAST(average_basket_size_usd AS DOUBLE))
      comment: "Average basket size in USD — measures spend per occasion by segment."
    - name: "avg_nps_score"
      expr: AVG(CAST(nps_score_average AS DOUBLE))
      comment: "Average NPS score by segment — measures loyalty and advocacy strength."
    - name: "avg_value_index"
      expr: AVG(CAST(value_index AS DOUBLE))
      comment: "Average value index — measures relative segment value vs average consumer."
    - name: "active_segment_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Number of active consumer segments — operational segmentation health indicator."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`marketing_creative_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Creative asset portfolio KPIs — production cost, asset volume by type, and compliance status. Used by creative and brand teams to manage creative investment and governance."
  source: "`vibe_consumer_goods_v1`.`marketing`.`creative_asset`"
  dimensions:
    - name: "asset_type"
      expr: asset_type
      comment: "Asset type (video, image, copy, audio) for creative portfolio analysis."
    - name: "content_format"
      expr: content_format
      comment: "Content format for format-level performance analysis."
    - name: "publishing_channel"
      expr: publishing_channel
      comment: "Publishing channel for channel-specific creative analysis."
    - name: "creative_asset_status"
      expr: creative_asset_status
      comment: "Current status of the creative asset."
    - name: "compliance_review_status"
      expr: compliance_review_status
      comment: "Compliance review status — critical for regulatory risk management."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the creative asset."
    - name: "language_code"
      expr: language_code
      comment: "Language of the creative asset for localization analysis."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the creative asset."
    - name: "is_master_version"
      expr: is_master_version
      comment: "Flag indicating whether this is the master version of the asset."
    - name: "planned_publish_date"
      expr: planned_publish_date
      comment: "Planned publish date for creative calendar management."
  measures:
    - name: "total_assets"
      expr: COUNT(1)
      comment: "Total number of creative assets — baseline creative portfolio sizing metric."
    - name: "total_production_cost"
      expr: SUM(CAST(production_cost_amount AS DOUBLE))
      comment: "Total creative production cost — primary non-working spend KPI for creative investment governance."
    - name: "avg_production_cost"
      expr: AVG(CAST(production_cost_amount AS DOUBLE))
      comment: "Average production cost per asset — measures creative production efficiency."
    - name: "total_file_size_bytes"
      expr: SUM(CAST(file_size_bytes AS DOUBLE))
      comment: "Total file size in bytes — measures DAM storage requirements and asset scale."
    - name: "compliant_asset_count"
      expr: COUNT(CASE WHEN compliance_review_status = 'Approved' THEN 1 END)
      comment: "Number of compliance-approved assets — measures regulatory readiness of creative portfolio."
    - name: "compliance_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_review_status = 'Approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Compliance approval rate — measures creative regulatory compliance; low rate triggers review process intervention."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`marketing_digital_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Digital channel performance KPIs — impressions, clicks, conversions, ROAS, and cost efficiency. Primary dashboard for performance marketing and digital media teams."
  source: "`vibe_consumer_goods_v1`.`marketing`.`digital_performance`"
  dimensions:
    - name: "channel"
      expr: channel
      comment: "Digital media channel (search, social, display, video, etc.)."
    - name: "platform"
      expr: platform
      comment: "Specific digital platform (Google, Meta, TikTok, YouTube, etc.)."
    - name: "placement_type"
      expr: placement_type
      comment: "Ad placement type for granular performance analysis."
    - name: "device_type"
      expr: device_type
      comment: "Device type (mobile, desktop, tablet) for device-level optimization."
    - name: "ad_format"
      expr: ad_format
      comment: "Ad format (video, carousel, static, etc.) for creative performance analysis."
    - name: "attribution_model"
      expr: attribution_model
      comment: "Attribution model used for conversion measurement."
    - name: "geography"
      expr: geography
      comment: "Geographic market for digital performance segmentation."
    - name: "performance_date"
      expr: performance_date
      comment: "Date of performance measurement for trend analysis."
    - name: "digital_performance_status"
      expr: digital_performance_status
      comment: "Status of the digital performance record."
    - name: "is_active"
      expr: is_active
      comment: "Flag indicating whether the digital placement is currently active."
  measures:
    - name: "total_impressions"
      expr: SUM(CAST(impressions AS DOUBLE))
      comment: "Total digital impressions delivered — primary reach metric for digital media."
    - name: "total_clicks"
      expr: SUM(CAST(clicks AS DOUBLE))
      comment: "Total clicks — measures audience engagement and intent signals."
    - name: "total_conversions"
      expr: SUM(CAST(conversions AS DOUBLE))
      comment: "Total conversions — direct measure of digital campaign revenue impact."
    - name: "total_video_views"
      expr: SUM(CAST(video_views AS DOUBLE))
      comment: "Total video views — measures video content consumption at scale."
    - name: "total_view_through_conversions"
      expr: SUM(CAST(view_through_conversions AS DOUBLE))
      comment: "Total view-through conversions — measures latent conversion impact of video/display."
    - name: "total_spend"
      expr: SUM(CAST(spend AS DOUBLE))
      comment: "Total digital media spend — primary cost metric for digital investment tracking."
    - name: "total_revenue"
      expr: SUM(CAST(revenue_amount AS DOUBLE))
      comment: "Total attributed revenue from digital channels — measures revenue generation efficiency."
    - name: "total_reach"
      expr: SUM(CAST(reach AS DOUBLE))
      comment: "Total unique reach — measures unduplicated audience exposure."
    - name: "avg_ctr"
      expr: AVG(CAST(ctr AS DOUBLE))
      comment: "Average click-through rate — measures ad relevance and creative effectiveness."
    - name: "avg_conversion_rate"
      expr: AVG(CAST(conversion_rate AS DOUBLE))
      comment: "Average conversion rate — measures bottom-funnel digital efficiency."
    - name: "avg_roas"
      expr: AVG(CAST(roas AS DOUBLE))
      comment: "Average return on ad spend — primary digital investment efficiency KPI."
    - name: "avg_cpa"
      expr: AVG(CAST(cpa AS DOUBLE))
      comment: "Average cost per acquisition — measures digital channel acquisition efficiency."
    - name: "avg_cpc"
      expr: AVG(CAST(cpc AS DOUBLE))
      comment: "Average cost per click — measures paid search and social click efficiency."
    - name: "avg_cpm"
      expr: AVG(CAST(cpm AS DOUBLE))
      comment: "Average cost per thousand impressions — measures media buying efficiency."
    - name: "avg_video_completion_rate"
      expr: AVG(CAST(video_completion_rate AS DOUBLE))
      comment: "Average video completion rate — measures video creative quality and audience engagement."
    - name: "avg_frequency"
      expr: AVG(CAST(frequency AS DOUBLE))
      comment: "Average ad frequency — monitors audience fatigue and overexposure risk."
    - name: "roas_efficiency_ratio"
      expr: ROUND(SUM(CAST(revenue_amount AS DOUBLE)) / NULLIF(SUM(CAST(spend AS DOUBLE)), 0), 2)
      comment: "Aggregate ROAS ratio — total revenue generated per dollar of digital spend; primary executive efficiency KPI."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`marketing_event_participation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Marketing event participation KPIs — attendance rates, engagement scores, and lead generation. Used by events and brand teams to measure event marketing ROI."
  source: "`vibe_consumer_goods_v1`.`marketing`.`event_participation`"
  dimensions:
    - name: "participation_type"
      expr: participation_type
      comment: "Type of participation (attendee, speaker, sponsor) for role-based analysis."
    - name: "participant_role"
      expr: participant_role
      comment: "Participant role for engagement analysis."
    - name: "attendance_status"
      expr: attendance_status
      comment: "Attendance status for event completion analysis."
    - name: "event_participation_status"
      expr: event_participation_status
      comment: "Status of the participation record."
    - name: "participation_date"
      expr: participation_date
      comment: "Date of participation for trend analysis."
    - name: "registration_date"
      expr: registration_date
      comment: "Registration date for lead time analysis."
  measures:
    - name: "total_registrations"
      expr: COUNT(1)
      comment: "Total event registrations — baseline event demand metric."
    - name: "total_attendees"
      expr: COUNT(CASE WHEN attended = TRUE THEN 1 END)
      comment: "Total confirmed attendees — measures actual event reach."
    - name: "total_leads_captured"
      expr: COUNT(CASE WHEN lead_captured = TRUE THEN 1 END)
      comment: "Total leads captured at events — measures event marketing pipeline contribution."
    - name: "total_participation_hours"
      expr: SUM(CAST(participation_hours AS DOUBLE))
      comment: "Total participation hours — measures depth of engagement at events."
    - name: "avg_engagement_score"
      expr: AVG(CAST(engagement_score AS DOUBLE))
      comment: "Average engagement score — measures quality of event participation."
    - name: "attendance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN attended = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Attendance rate — percentage of registrants who attended; measures event conversion and interest quality."
    - name: "lead_capture_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN lead_captured = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN attended = TRUE THEN 1 END), 0), 2)
      comment: "Lead capture rate among attendees — measures event marketing pipeline efficiency."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`marketing_influencer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Influencer marketing KPIs — engagement rates, follower reach, contract value, and performance ratings. Used by brand and social teams to manage influencer investment."
  source: "`vibe_consumer_goods_v1`.`marketing`.`influencer`"
  dimensions:
    - name: "influencer_tier"
      expr: influencer_tier
      comment: "Influencer tier (nano, micro, macro, mega) for investment segmentation."
    - name: "primary_platform"
      expr: primary_platform
      comment: "Primary social platform for platform-level influencer analysis."
    - name: "influencer_category"
      expr: influencer_category
      comment: "Content category of the influencer for brand alignment analysis."
    - name: "contract_status"
      expr: contract_status
      comment: "Current contract status for portfolio management."
    - name: "influencer_status"
      expr: influencer_status
      comment: "Operational status of the influencer relationship."
    - name: "is_active"
      expr: is_active
      comment: "Flag indicating whether the influencer is currently active."
    - name: "exclusivity_clause"
      expr: exclusivity_clause
      comment: "Flag indicating whether an exclusivity clause is in effect."
    - name: "contract_start_date"
      expr: contract_start_date
      comment: "Contract start date for relationship timeline management."
    - name: "contract_end_date"
      expr: contract_end_date
      comment: "Contract end date for renewal planning."
  measures:
    - name: "total_influencers"
      expr: COUNT(1)
      comment: "Total number of influencers in the program — baseline portfolio sizing metric."
    - name: "total_follower_count"
      expr: SUM(CAST(follower_count AS DOUBLE))
      comment: "Total follower count across influencers — measures aggregate potential reach of influencer program."
    - name: "total_contract_fee"
      expr: SUM(CAST(contract_fee AS DOUBLE))
      comment: "Total influencer contract fees — primary investment cost KPI for influencer program."
    - name: "avg_engagement_rate"
      expr: AVG(CAST(engagement_rate AS DOUBLE))
      comment: "Average engagement rate — measures influencer audience quality and content effectiveness."
    - name: "avg_performance_rating"
      expr: AVG(CAST(performance_rating AS DOUBLE))
      comment: "Average influencer performance rating — measures program quality and ROI delivery."
    - name: "avg_brand_safety_score"
      expr: AVG(CAST(brand_safety_score AS DOUBLE))
      comment: "Average brand safety score — measures risk exposure of influencer partnerships."
    - name: "avg_post_impressions"
      expr: AVG(CAST(average_post_impressions AS DOUBLE))
      comment: "Average post impressions per influencer — measures content reach efficiency."
    - name: "avg_post_reach"
      expr: AVG(CAST(average_post_reach AS DOUBLE))
      comment: "Average post reach per influencer — measures unique audience exposure per post."
    - name: "cost_per_follower"
      expr: ROUND(SUM(CAST(contract_fee AS DOUBLE)) / NULLIF(SUM(CAST(follower_count AS DOUBLE)), 0), 4)
      comment: "Cost per follower — measures efficiency of influencer investment relative to audience size."
    - name: "active_influencer_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Number of active influencers — operational program health indicator."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`marketing_market_research_study`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Market research investment and insight KPIs — study investment, brand metrics, and consumer behavior findings. Used by insights and strategy teams to govern research investment."
  source: "`vibe_consumer_goods_v1`.`marketing`.`market_research_study`"
  dimensions:
    - name: "research_type"
      expr: research_type
      comment: "Type of research (quantitative, qualitative, syndicated) for methodology analysis."
    - name: "study_type"
      expr: study_type
      comment: "Study type for research portfolio categorization."
    - name: "methodology"
      expr: methodology
      comment: "Research methodology for quality and comparability assessment."
    - name: "market_research_study_status"
      expr: market_research_study_status
      comment: "Current status of the research study."
    - name: "subscription_type"
      expr: subscription_type
      comment: "Subscription type for syndicated research cost management."
    - name: "is_active"
      expr: is_active
      comment: "Flag indicating whether the study is currently active."
    - name: "fieldwork_start_date"
      expr: fieldwork_start_date
      comment: "Fieldwork start date for study timeline management."
    - name: "fieldwork_end_date"
      expr: fieldwork_end_date
      comment: "Fieldwork end date for study timeline management."
  measures:
    - name: "total_studies"
      expr: COUNT(1)
      comment: "Total number of market research studies — baseline research portfolio sizing."
    - name: "total_study_investment"
      expr: SUM(CAST(study_investment_amount AS DOUBLE))
      comment: "Total research investment — primary cost KPI for insights budget governance."
    - name: "avg_brand_awareness_pct"
      expr: AVG(CAST(brand_awareness_pct AS DOUBLE))
      comment: "Average brand awareness percentage from research — measures brand salience."
    - name: "avg_brand_consideration_pct"
      expr: AVG(CAST(brand_consideration_pct AS DOUBLE))
      comment: "Average brand consideration percentage — measures purchase funnel health."
    - name: "avg_brand_preference_pct"
      expr: AVG(CAST(brand_preference_pct AS DOUBLE))
      comment: "Average brand preference percentage — measures competitive differentiation."
    - name: "avg_household_penetration_pct"
      expr: AVG(CAST(household_penetration_pct AS DOUBLE))
      comment: "Average household penetration percentage — measures brand reach in target households."
    - name: "avg_purchase_frequency"
      expr: AVG(CAST(purchase_frequency AS DOUBLE))
      comment: "Average purchase frequency from research — measures buying behavior intensity."
    - name: "avg_repeat_rate_pct"
      expr: AVG(CAST(repeat_rate_pct AS DOUBLE))
      comment: "Average repeat purchase rate — measures brand loyalty from research data."
    - name: "avg_basket_size"
      expr: AVG(CAST(average_basket_size AS DOUBLE))
      comment: "Average basket size from research — measures spend per occasion."
    - name: "avg_switching_behavior_index"
      expr: AVG(CAST(switching_behavior_index AS DOUBLE))
      comment: "Average brand switching behavior index — measures loyalty erosion risk."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`marketing_market_share`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Market share metrics by brand, SKU and geography."
  source: "`consumer_goods_ecm`.`marketing`.`market_share_record`"
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

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`marketing_market_share_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Market share KPIs — value share, volume share, share trends, and competitive position. Used by strategy and brand teams to track competitive standing."
  source: "`vibe_consumer_goods_v1`.`marketing`.`market_share_record`"
  dimensions:
    - name: "channel"
      expr: channel
      comment: "Sales channel for channel-specific market share analysis."
    - name: "geography"
      expr: geography
      comment: "Geographic market for regional share analysis."
    - name: "geography_level"
      expr: geography_level
      comment: "Geographic granularity level (national, regional, local)."
    - name: "period_type"
      expr: period_type
      comment: "Period type (weekly, monthly, quarterly) for trend analysis."
    - name: "market_definition"
      expr: market_definition
      comment: "Market definition used for share calculation."
    - name: "measurement_date"
      expr: measurement_date
      comment: "Date of market share measurement."
    - name: "measurement_period_start_date"
      expr: measurement_period_start_date
      comment: "Start of measurement period."
    - name: "measurement_period_end_date"
      expr: measurement_period_end_date
      comment: "End of measurement period."
    - name: "market_share_record_status"
      expr: market_share_record_status
      comment: "Status of the market share record."
    - name: "is_projected"
      expr: is_projected
      comment: "Flag indicating whether the share figure is projected vs actual."
  measures:
    - name: "avg_value_share_pct"
      expr: AVG(CAST(value_share_pct AS DOUBLE))
      comment: "Average value market share percentage — primary competitive position KPI for brand and strategy teams."
    - name: "avg_volume_share_pct"
      expr: AVG(CAST(volume_share_pct AS DOUBLE))
      comment: "Average volume market share percentage — measures unit-level competitive position."
    - name: "total_brand_value"
      expr: SUM(CAST(brand_value_amount AS DOUBLE))
      comment: "Total brand value sales — measures absolute revenue contribution in the market."
    - name: "total_brand_volume"
      expr: SUM(CAST(brand_volume_quantity AS DOUBLE))
      comment: "Total brand volume sold — measures unit-level market presence."
    - name: "total_category_value"
      expr: SUM(CAST(category_total_value_amount AS DOUBLE))
      comment: "Total category value — denominator for share calculations and market sizing."
    - name: "avg_share_change_pct"
      expr: AVG(CAST(share_change_pct AS DOUBLE))
      comment: "Average share change percentage — measures momentum in competitive position."
    - name: "avg_share_point_change"
      expr: AVG(CAST(share_point_change AS DOUBLE))
      comment: "Average share point change — measures absolute competitive position movement."
    - name: "avg_yoy_change_pct"
      expr: AVG(CAST(year_over_year_change_percent AS DOUBLE))
      comment: "Average year-over-year share change — measures annual competitive trajectory."
    - name: "value_to_volume_share_ratio"
      expr: ROUND(AVG(CAST(value_share_pct AS DOUBLE)) / NULLIF(AVG(CAST(volume_share_pct AS DOUBLE)), 0), 2)
      comment: "Value share to volume share ratio — measures price premium realization; ratio > 1 indicates premium positioning."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`marketing_brand`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Brand portfolio health and investment KPIs — brand equity, market share, SOV, and budget sizing. Used by brand leadership to manage brand portfolio strategy."
  source: "`vibe_consumer_goods_v1`.`marketing`.`marketing_brand`"
  dimensions:
    - name: "brand_tier"
      expr: brand_tier
      comment: "Brand tier (premium, mainstream, value) for portfolio segmentation."
    - name: "brand_status"
      expr: brand_status
      comment: "Current lifecycle status of the brand."
    - name: "brand_category"
      expr: brand_category
      comment: "Product category the brand competes in."
    - name: "lifecycle_stage"
      expr: lifecycle_stage
      comment: "Brand lifecycle stage (launch, growth, mature, decline) for strategic planning."
    - name: "architecture_tier"
      expr: architecture_tier
      comment: "Brand architecture tier (masterbrand, sub-brand, endorsed) for portfolio management."
    - name: "geographic_market_scope"
      expr: geographic_market_scope
      comment: "Geographic scope of the brand (global, regional, local)."
    - name: "primary_distribution_channel"
      expr: primary_distribution_channel
      comment: "Primary channel through which the brand is sold."
    - name: "global_brand_flag"
      expr: global_brand_flag
      comment: "Flag indicating whether the brand is a global brand."
    - name: "is_private_label"
      expr: is_private_label
      comment: "Flag indicating whether the brand is a private label."
    - name: "marketing_brand_status"
      expr: marketing_brand_status
      comment: "Operational status of the brand in the marketing system."
  measures:
    - name: "total_brands"
      expr: COUNT(1)
      comment: "Total number of brands in the portfolio — baseline for portfolio sizing decisions."
    - name: "total_annual_marketing_budget"
      expr: SUM(CAST(annual_marketing_budget AS DOUBLE))
      comment: "Total annual marketing budget across all brands — primary investment allocation KPI."
    - name: "total_annual_revenue_target"
      expr: SUM(CAST(annual_revenue_target AS DOUBLE))
      comment: "Total annual revenue target across brands — measures portfolio revenue ambition."
    - name: "total_brand_valuation"
      expr: SUM(CAST(valuation_amount AS DOUBLE))
      comment: "Total brand portfolio valuation — measures intangible asset value for investor reporting."
    - name: "avg_brand_equity_score"
      expr: AVG(CAST(brand_equity_score AS DOUBLE))
      comment: "Average brand equity score — measures overall portfolio health; triggers brand investment review."
    - name: "avg_brand_health_index"
      expr: AVG(CAST(brand_health_index AS DOUBLE))
      comment: "Average brand health index — composite health metric for portfolio steering."
    - name: "avg_market_share_pct"
      expr: AVG(CAST(market_share_pct AS DOUBLE))
      comment: "Average market share percentage across brands — measures competitive position."
    - name: "avg_sov_percent"
      expr: AVG(CAST(sov_percent AS DOUBLE))
      comment: "Average share of voice percentage — measures brand visibility vs competitors."
    - name: "avg_nps_score"
      expr: AVG(CAST(nps_score AS DOUBLE))
      comment: "Average NPS score across brands — measures consumer loyalty and advocacy."
    - name: "avg_awareness_percent"
      expr: AVG(CAST(awareness_percent AS DOUBLE))
      comment: "Average brand awareness percentage — measures brand salience in target markets."
    - name: "avg_consideration_percent"
      expr: AVG(CAST(consideration_percent AS DOUBLE))
      comment: "Average brand consideration percentage — measures purchase funnel health."
    - name: "sov_som_gap"
      expr: ROUND(AVG(CAST(sov_percent AS DOUBLE)) - AVG(CAST(som_percent AS DOUBLE)), 2)
      comment: "Average SOV minus SOM gap — positive gap indicates over-investment; negative indicates under-investment vs share."
    - name: "active_brand_count"
      expr: COUNT(CASE WHEN brand_status = 'Active' THEN 1 END)
      comment: "Number of active brands — operational portfolio health indicator."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`marketing_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Marketing budget allocation and utilization KPIs — budget vs committed vs spent. Used by CFO and CMO to govern marketing investment and financial discipline."
  source: "`vibe_consumer_goods_v1`.`marketing`.`marketing_budget`"
  dimensions:
    - name: "budget_category"
      expr: budget_category
      comment: "Budget category (media, production, events, etc.) for spend mix analysis."
    - name: "budget_period"
      expr: budget_period
      comment: "Budget period for temporal investment analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual budget governance."
    - name: "marketing_budget_status"
      expr: marketing_budget_status
      comment: "Current status of the budget record."
    - name: "effective_from"
      expr: effective_from
      comment: "Effective start date of the budget."
    - name: "effective_until"
      expr: effective_until
      comment: "Effective end date of the budget."
  measures:
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total marketing budget — primary investment envelope KPI for CMO and CFO."
    - name: "total_allocated_amount"
      expr: SUM(CAST(allocated_amount AS DOUBLE))
      comment: "Total allocated budget — measures how much of the budget has been assigned to activities."
    - name: "total_committed_amount"
      expr: SUM(CAST(committed_amount AS DOUBLE))
      comment: "Total committed spend — measures financial obligations already incurred."
    - name: "total_spent_amount"
      expr: SUM(CAST(spent_amount AS DOUBLE))
      comment: "Total spent amount — measures actual budget consumption."
    - name: "total_remaining_amount"
      expr: SUM(CAST(remaining_amount AS DOUBLE))
      comment: "Total remaining budget — measures available investment capacity."
    - name: "budget_allocation_pct"
      expr: ROUND(100.0 * SUM(CAST(allocated_amount AS DOUBLE)) / NULLIF(SUM(CAST(budget_amount AS DOUBLE)), 0), 2)
      comment: "Budget allocation rate — measures how fully the budget has been assigned; low rate triggers reallocation."
    - name: "budget_utilization_pct"
      expr: ROUND(100.0 * SUM(CAST(spent_amount AS DOUBLE)) / NULLIF(SUM(CAST(budget_amount AS DOUBLE)), 0), 2)
      comment: "Budget utilization rate — primary financial discipline KPI; triggers intervention if significantly off-plan."
    - name: "commitment_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(committed_amount AS DOUBLE)) / NULLIF(SUM(CAST(budget_amount AS DOUBLE)), 0), 2)
      comment: "Commitment rate — measures financial exposure as percentage of total budget."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`marketing_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Marketing event metrics tracking budget, attendance, and event portfolio performance to optimize experiential marketing investment decisions."
  source: "`vibe_consumer_goods_v1`.`marketing`.`marketing_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of marketing event (trade show, consumer activation, press event) for portfolio analysis."
    - name: "marketing_event_status"
      expr: marketing_event_status
      comment: "Current status of the event for active portfolio management."
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', event_date)
      comment: "Month of the event for seasonal and trend analysis."
    - name: "location"
      expr: location
      comment: "Event location for geographic investment analysis."
  measures:
    - name: "total_events"
      expr: COUNT(1)
      comment: "Total number of marketing events; baseline for experiential marketing portfolio sizing."
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budget allocated to marketing events; primary investment metric for experiential marketing."
    - name: "total_event_budget"
      expr: SUM(CAST(event_budget AS DOUBLE))
      comment: "Total event-level budget; used for per-event cost analysis and benchmarking."
    - name: "avg_budget_per_event"
      expr: AVG(CAST(budget_amount AS DOUBLE))
      comment: "Average budget per marketing event; benchmarks event investment sizing for planning."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`marketing_offset_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Marketing carbon offset allocation KPIs — CO2e emissions, offset quantities, and allocation efficiency. Used by sustainability and marketing teams to track campaign carbon neutrality."
  source: "`vibe_consumer_goods_v1`.`marketing`.`marketing_offset_allocation`"
  dimensions:
    - name: "emission_scope"
      expr: emission_scope
      comment: "Emission scope (Scope 1, 2, 3) for carbon accounting classification."
    - name: "allocation_method"
      expr: allocation_method
      comment: "Offset allocation method for methodology governance."
    - name: "allocation_basis"
      expr: allocation_basis
      comment: "Basis for offset allocation (campaign, brand, channel)."
    - name: "verification_status"
      expr: verification_status
      comment: "Verification status of the carbon offset — critical for ESG reporting credibility."
    - name: "marketing_offset_allocation_status"
      expr: marketing_offset_allocation_status
      comment: "Status of the offset allocation record."
    - name: "allocation_date"
      expr: allocation_date
      comment: "Date of offset allocation for temporal carbon accounting."
    - name: "reporting_period"
      expr: reporting_period
      comment: "Reporting period for ESG disclosure alignment."
  measures:
    - name: "total_emission_quantity_tco2e"
      expr: SUM(CAST(emission_quantity_tco2e AS DOUBLE))
      comment: "Total campaign emissions in tCO2e — primary carbon footprint KPI for marketing ESG reporting."
    - name: "total_offset_quantity_tonnes"
      expr: SUM(CAST(offset_quantity_tonnes AS DOUBLE))
      comment: "Total carbon offsets allocated in tonnes — measures offset coverage of campaign emissions."
    - name: "total_allocated_co2e"
      expr: SUM(CAST(allocated_co2e_tonnes AS DOUBLE))
      comment: "Total allocated CO2e tonnes — measures scope of carbon neutrality commitment."
    - name: "total_purchase_cost"
      expr: SUM(CAST(purchase_cost AS DOUBLE))
      comment: "Total carbon offset purchase cost — measures financial investment in carbon neutrality."
    - name: "total_allocated_amount"
      expr: SUM(CAST(allocated_amount AS DOUBLE))
      comment: "Total allocated offset amount — measures financial commitment to carbon offsetting."
    - name: "offset_coverage_ratio"
      expr: ROUND(SUM(CAST(offset_quantity_tonnes AS DOUBLE)) / NULLIF(SUM(CAST(emission_quantity_tco2e AS DOUBLE)), 0), 2)
      comment: "Offset coverage ratio — tonnes offset per tonne emitted; ratio >= 1 indicates carbon neutrality achievement."
    - name: "avg_cost_per_tonne"
      expr: ROUND(SUM(CAST(purchase_cost AS DOUBLE)) / NULLIF(SUM(CAST(offset_quantity_tonnes AS DOUBLE)), 0), 2)
      comment: "Average cost per tonne of carbon offset — measures procurement efficiency of carbon credits."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`marketing_media_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Media planning KPIs — planned reach, GRP, impressions, frequency, and budget allocation. Used by media planners and CMO to govern media investment strategy."
  source: "`vibe_consumer_goods_v1`.`marketing`.`media_plan`"
  dimensions:
    - name: "media_type"
      expr: media_type
      comment: "Media type (TV, digital, print, OOH, radio) for channel mix analysis."
    - name: "media_channel"
      expr: media_channel
      comment: "Specific media channel for granular planning analysis."
    - name: "media_subchannel"
      expr: media_subchannel
      comment: "Media sub-channel for detailed investment breakdown."
    - name: "plan_type"
      expr: plan_type
      comment: "Plan type for media strategy categorization."
    - name: "media_plan_status"
      expr: media_plan_status
      comment: "Current status of the media plan."
    - name: "target_audience"
      expr: target_audience
      comment: "Target audience for the media plan."
    - name: "market"
      expr: market
      comment: "Market for the media plan."
    - name: "planning_period_start_date"
      expr: planning_period_start_date
      comment: "Start of the planning period."
    - name: "planning_period_end_date"
      expr: planning_period_end_date
      comment: "End of the planning period."
  measures:
    - name: "total_plans"
      expr: COUNT(1)
      comment: "Total number of media plans — baseline planning portfolio metric."
    - name: "total_planned_budget"
      expr: SUM(CAST(planned_budget AS DOUBLE))
      comment: "Total planned media budget — primary investment commitment KPI."
    - name: "total_planned_spend"
      expr: SUM(CAST(planned_spend_amount AS DOUBLE))
      comment: "Total planned spend amount — measures investment commitment across plans."
    - name: "total_planned_impressions"
      expr: SUM(CAST(planned_impressions AS DOUBLE))
      comment: "Total planned impressions — measures intended media reach scale."
    - name: "total_planned_reach"
      expr: SUM(CAST(planned_reach AS DOUBLE))
      comment: "Total planned unique reach — measures intended unduplicated audience coverage."
    - name: "avg_planned_grp"
      expr: AVG(CAST(planned_grp AS DOUBLE))
      comment: "Average planned GRP — measures intended media weight per plan."
    - name: "avg_planned_frequency"
      expr: AVG(CAST(planned_frequency AS DOUBLE))
      comment: "Average planned frequency — measures intended exposure per target audience member."
    - name: "avg_planned_cpm"
      expr: AVG(CAST(planned_cpm AS DOUBLE))
      comment: "Average planned CPM — measures media buying efficiency target."
    - name: "avg_target_reach_pct"
      expr: AVG(CAST(target_reach_pct AS DOUBLE))
      comment: "Average target reach percentage — measures intended audience coverage ambition."
    - name: "avg_budget_allocation_pct"
      expr: AVG(CAST(budget_allocation_percent AS DOUBLE))
      comment: "Average budget allocation percentage — measures how budget is distributed across plans."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`marketing_media_spend`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Media investment KPIs — planned vs actual spend, working vs non-working media ratio, and channel efficiency. Used by CFO and CMO to govern media investment allocation."
  source: "`vibe_consumer_goods_v1`.`marketing`.`media_spend`"
  dimensions:
    - name: "media_channel"
      expr: media_channel
      comment: "Media channel (TV, digital, print, OOH, radio) for spend allocation analysis."
    - name: "media_subchannel"
      expr: media_subchannel
      comment: "Sub-channel for granular media mix analysis."
    - name: "channel"
      expr: channel
      comment: "Broad channel category for spend segmentation."
    - name: "placement_type"
      expr: placement_type
      comment: "Ad placement type for spend efficiency analysis."
    - name: "buy_type"
      expr: buy_type
      comment: "Media buy type (programmatic, direct, reserved) for procurement analysis."
    - name: "country_code"
      expr: country_code
      comment: "Country of media spend for geographic investment analysis."
    - name: "spend_date"
      expr: spend_date
      comment: "Date of media spend for trend and pacing analysis."
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of media invoices for financial reconciliation."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status for financial close accuracy."
    - name: "media_spend_status"
      expr: media_spend_status
      comment: "Status of the media spend record."
    - name: "is_active"
      expr: is_active
      comment: "Flag indicating whether the spend record is active."
  measures:
    - name: "total_spend_amount"
      expr: SUM(CAST(spend_amount AS DOUBLE))
      comment: "Total media spend — primary investment tracking KPI for CMO and CFO."
    - name: "total_planned_spend"
      expr: SUM(CAST(planned_spend_amount AS DOUBLE))
      comment: "Total planned media spend — investment commitment baseline."
    - name: "total_working_spend"
      expr: SUM(CAST(working_spend_amount AS DOUBLE))
      comment: "Total working media spend (directly reaching consumers) — measures productive investment."
    - name: "total_non_working_spend"
      expr: SUM(CAST(non_working_spend_amount AS DOUBLE))
      comment: "Total non-working spend (production, agency fees) — measures overhead investment."
    - name: "total_agency_fee"
      expr: SUM(CAST(agency_fee_amount AS DOUBLE))
      comment: "Total agency fees — measures agency cost burden on media investment."
    - name: "total_invoiced_spend"
      expr: SUM(CAST(invoiced_spend_amount AS DOUBLE))
      comment: "Total invoiced spend — measures financial commitment for accrual and payment tracking."
    - name: "total_production_cost"
      expr: SUM(CAST(production_cost_amount AS DOUBLE))
      comment: "Total production cost — non-working spend component for efficiency analysis."
    - name: "total_impressions"
      expr: SUM(CAST(impressions AS DOUBLE))
      comment: "Total impressions delivered — measures media reach achieved per spend."
    - name: "total_clicks"
      expr: SUM(CAST(clicks AS DOUBLE))
      comment: "Total clicks delivered — measures engagement generated by media spend."
    - name: "avg_cpm"
      expr: AVG(CAST(cpm AS DOUBLE))
      comment: "Average CPM — measures media buying efficiency across channels."
    - name: "avg_cpc"
      expr: AVG(CAST(cpc AS DOUBLE))
      comment: "Average CPC — measures cost efficiency of click-generating media."
    - name: "spend_variance_to_plan"
      expr: SUM(CAST(variance_to_plan_amount AS DOUBLE))
      comment: "Total spend variance vs plan — measures budget discipline and forecasting accuracy."
    - name: "working_media_ratio_pct"
      expr: ROUND(100.0 * SUM(CAST(working_spend_amount AS DOUBLE)) / NULLIF(SUM(CAST(spend_amount AS DOUBLE)), 0), 2)
      comment: "Working media as percentage of total spend — key efficiency ratio; higher = more consumer-facing investment."
    - name: "spend_pacing_pct"
      expr: ROUND(100.0 * SUM(CAST(spend_amount AS DOUBLE)) / NULLIF(SUM(CAST(planned_spend_amount AS DOUBLE)), 0), 2)
      comment: "Actual vs planned spend pacing — triggers reallocation decisions when significantly off-plan."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`marketing_nielsen_panel_insight`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Nielsen panel consumer behavior KPIs — household penetration, purchase frequency, basket size, and brand switching. Used by category management and brand teams for shopper strategy."
  source: "`vibe_consumer_goods_v1`.`marketing`.`nielsen_panel_insight`"
  dimensions:
    - name: "market"
      expr: market
      comment: "Market geography for panel insight analysis."
    - name: "market_geography"
      expr: market_geography
      comment: "Specific market geography for regional consumer behavior analysis."
    - name: "buyer_age_group"
      expr: buyer_age_group
      comment: "Buyer age group for demographic segmentation."
    - name: "buyer_income_bracket"
      expr: buyer_income_bracket
      comment: "Buyer income bracket for socioeconomic segmentation."
    - name: "buyer_household_size"
      expr: buyer_household_size
      comment: "Household size for family-based segmentation."
    - name: "buyer_presence_of_children"
      expr: buyer_presence_of_children
      comment: "Flag indicating presence of children in household — key shopper segment."
    - name: "buyer_profile_segment"
      expr: buyer_profile_segment
      comment: "Buyer profile segment for targeted marketing analysis."
    - name: "panel_period_start_date"
      expr: panel_period_start_date
      comment: "Start of panel measurement period."
    - name: "panel_period_end_date"
      expr: panel_period_end_date
      comment: "End of panel measurement period."
    - name: "nielsen_panel_insight_status"
      expr: nielsen_panel_insight_status
      comment: "Status of the panel insight record."
    - name: "is_active"
      expr: is_active
      comment: "Flag indicating whether the panel insight is active."
  measures:
    - name: "avg_household_penetration_rate"
      expr: AVG(CAST(household_penetration_rate AS DOUBLE))
      comment: "Average household penetration rate — measures brand reach within the shopper universe."
    - name: "avg_purchase_frequency"
      expr: AVG(CAST(purchase_frequency AS DOUBLE))
      comment: "Average purchase frequency — measures repeat buying behavior; key loyalty indicator."
    - name: "avg_basket_size"
      expr: AVG(CAST(average_basket_size AS DOUBLE))
      comment: "Average basket size — measures spend per shopping occasion; drives revenue per buyer."
    - name: "avg_market_share_pct"
      expr: AVG(CAST(market_share_pct AS DOUBLE))
      comment: "Average market share percentage from panel data — measures competitive position."
    - name: "avg_brand_switching_rate"
      expr: AVG(CAST(brand_switching_rate AS DOUBLE))
      comment: "Average brand switching rate — measures loyalty erosion risk; triggers retention investment."
    - name: "avg_loyalty_index"
      expr: AVG(CAST(loyalty_index AS DOUBLE))
      comment: "Average loyalty index — measures brand loyalty strength vs category average."
    - name: "avg_repeat_purchase_rate"
      expr: AVG(CAST(repeat_purchase_rate AS DOUBLE))
      comment: "Average repeat purchase rate — measures buyer retention and brand stickiness."
    - name: "total_dollar_sales"
      expr: SUM(CAST(dollar_sales AS DOUBLE))
      comment: "Total dollar sales from panel — measures absolute revenue contribution."
    - name: "total_unit_sales"
      expr: SUM(CAST(unit_sales AS DOUBLE))
      comment: "Total unit sales from panel — measures volume contribution."
    - name: "total_buying_households"
      expr: SUM(CAST(buying_households_count AS DOUBLE))
      comment: "Total buying households — measures absolute buyer base size."
    - name: "avg_price_per_unit"
      expr: AVG(CAST(average_price_per_unit AS DOUBLE))
      comment: "Average price per unit — measures realized price point vs category."
    - name: "avg_distribution_acv_pct"
      expr: AVG(CAST(distribution_acv_pct AS DOUBLE))
      comment: "Average ACV-weighted distribution percentage — measures product availability in the market."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`marketing_social_listening`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Social listening and sentiment metrics for brands."
  source: "`consumer_goods_ecm`.`marketing`.`social_listening_record`"
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
    - name: "source_system"
      expr: source_system
      comment: "Source system providing the social data."
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

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`marketing_social_listening_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Social listening and sentiment KPIs — mention volume, sentiment scores, share of conversation, and platform reach. Used by brand and communications teams to monitor brand health in real time."
  source: "`vibe_consumer_goods_v1`.`marketing`.`social_listening_record`"
  dimensions:
    - name: "platform"
      expr: platform
      comment: "Social media platform (Twitter, Instagram, TikTok, etc.) for platform-level analysis."
    - name: "sentiment_label"
      expr: sentiment_label
      comment: "Sentiment classification (positive, neutral, negative) for sentiment distribution analysis."
    - name: "monitoring_topic"
      expr: monitoring_topic
      comment: "Topic being monitored for issue-specific brand analysis."
    - name: "geography_scope"
      expr: geography_scope
      comment: "Geographic scope of social listening data."
    - name: "crisis_alert_flag"
      expr: crisis_alert_flag
      comment: "Flag indicating a crisis-level social event — triggers immediate brand response."
    - name: "competitive_brand_mention_flag"
      expr: competitive_brand_mention_flag
      comment: "Flag indicating competitive brand mentions for competitive intelligence."
    - name: "observation_period_start_date"
      expr: observation_period_start_date
      comment: "Start of observation period for trend analysis."
    - name: "observation_period_end_date"
      expr: observation_period_end_date
      comment: "End of observation period for trend analysis."
    - name: "social_listening_record_status"
      expr: social_listening_record_status
      comment: "Status of the social listening record."
  measures:
    - name: "total_mention_volume"
      expr: SUM(CAST(total_mention_volume AS DOUBLE))
      comment: "Total social mention volume — measures brand conversation scale across platforms."
    - name: "total_engagement"
      expr: SUM(CAST(engagement_count AS DOUBLE))
      comment: "Total social engagement — measures audience interaction with brand content."
    - name: "total_reach_estimate"
      expr: SUM(CAST(reach_estimate AS DOUBLE))
      comment: "Total estimated reach — measures potential audience exposed to brand mentions."
    - name: "total_positive_mentions"
      expr: SUM(CAST(positive_mention_count AS DOUBLE))
      comment: "Total positive mentions — measures positive brand sentiment volume."
    - name: "total_negative_mentions"
      expr: SUM(CAST(negative_mention_count AS DOUBLE))
      comment: "Total negative mentions — measures negative brand sentiment volume; triggers crisis response."
    - name: "total_influencer_mentions"
      expr: SUM(CAST(influencer_mention_count AS DOUBLE))
      comment: "Total influencer mentions — measures earned media from influencer community."
    - name: "avg_sentiment_score"
      expr: AVG(CAST(sentiment_score AS DOUBLE))
      comment: "Average sentiment score — measures overall brand sentiment health."
    - name: "avg_net_sentiment_score"
      expr: AVG(CAST(net_sentiment_score AS DOUBLE))
      comment: "Average net sentiment score — measures net positive vs negative sentiment balance."
    - name: "avg_share_of_conversation_pct"
      expr: AVG(CAST(share_of_conversation_percent AS DOUBLE))
      comment: "Average share of conversation — measures brand dominance in category social discourse."
    - name: "positive_sentiment_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(positive_mention_count AS DOUBLE)) / NULLIF(SUM(CAST(total_mention_volume AS DOUBLE)), 0), 2)
      comment: "Positive sentiment rate — percentage of mentions that are positive; key brand health KPI."
    - name: "crisis_alert_count"
      expr: COUNT(CASE WHEN crisis_alert_flag = TRUE THEN 1 END)
      comment: "Number of crisis alert events — measures brand risk exposure requiring immediate response."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`marketing_sov_measurement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Share of voice measurement KPIs — brand SOV, SOM, competitive spend, and SOV-SOM gap. Used by brand strategy and media teams to optimize competitive investment."
  source: "`vibe_consumer_goods_v1`.`marketing`.`sov_measurement`"
  dimensions:
    - name: "channel"
      expr: channel
      comment: "Media channel for SOV measurement (TV, digital, print, OOH)."
    - name: "media_channel"
      expr: media_channel
      comment: "Specific media channel for granular SOV analysis."
    - name: "market_geography"
      expr: market_geography
      comment: "Geographic market for regional SOV comparison."
    - name: "measurement_period"
      expr: measurement_period
      comment: "Measurement period for trend analysis."
    - name: "measurement_methodology"
      expr: measurement_methodology
      comment: "Methodology used for SOV measurement."
    - name: "measurement_date"
      expr: measurement_date
      comment: "Date of SOV measurement."
    - name: "measurement_period_start_date"
      expr: measurement_period_start_date
      comment: "Start of measurement period."
    - name: "measurement_period_end_date"
      expr: measurement_period_end_date
      comment: "End of measurement period."
    - name: "sov_measurement_status"
      expr: sov_measurement_status
      comment: "Status of the SOV measurement record."
    - name: "is_active"
      expr: is_active
      comment: "Flag indicating whether the SOV measurement is active."
  measures:
    - name: "avg_brand_sov_pct"
      expr: AVG(CAST(brand_sov_percentage AS DOUBLE))
      comment: "Average brand share of voice percentage — primary competitive visibility KPI."
    - name: "avg_brand_som_pct"
      expr: AVG(CAST(brand_som_percentage AS DOUBLE))
      comment: "Average brand share of market percentage — measures revenue competitive position."
    - name: "total_brand_spend"
      expr: SUM(CAST(brand_spend_amount AS DOUBLE))
      comment: "Total brand media spend — investment driving SOV."
    - name: "total_category_spend"
      expr: SUM(CAST(total_category_spend_amount AS DOUBLE))
      comment: "Total category media spend — denominator for SOV calculation and market sizing."
    - name: "avg_sov_percent"
      expr: AVG(CAST(sov_percent AS DOUBLE))
      comment: "Average SOV percentage — measures brand voice dominance in category."
    - name: "avg_sov_som_gap"
      expr: AVG(CAST(sov_som_gap AS DOUBLE))
      comment: "Average SOV-SOM gap — investment efficiency signal; positive = over-investing vs share earned."
    - name: "avg_share_of_spend_pct"
      expr: AVG(CAST(share_of_spend_pct AS DOUBLE))
      comment: "Average share of category spend — measures investment weight vs competitors."
    - name: "avg_reach_percentage"
      expr: AVG(CAST(reach_percentage AS DOUBLE))
      comment: "Average reach percentage — measures audience coverage achieved."
    - name: "avg_grp"
      expr: AVG(CAST(grp AS DOUBLE))
      comment: "Average gross rating points — measures total media weight delivered."
    - name: "brand_spend_share_pct"
      expr: ROUND(100.0 * SUM(CAST(brand_spend_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_category_spend_amount AS DOUBLE)), 0), 2)
      comment: "Brand spend as percentage of total category spend — measures investment share vs category."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`marketing_sponsorship`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sponsorship investment and ROI KPIs — contract value, activation budget, and ROI targets. Used by brand and finance teams to govern sponsorship portfolio decisions."
  source: "`vibe_consumer_goods_v1`.`marketing`.`sponsorship`"
  dimensions:
    - name: "sponsorship_type"
      expr: sponsorship_type
      comment: "Type of sponsorship (sports, entertainment, cultural, etc.) for portfolio analysis."
    - name: "property_type"
      expr: property_type
      comment: "Sponsorship property type for category-level investment analysis."
    - name: "sponsorship_status"
      expr: sponsorship_status
      comment: "Current status of the sponsorship (active, expired, negotiating)."
    - name: "territory_scope"
      expr: territory_scope
      comment: "Geographic territory scope of the sponsorship."
    - name: "tier"
      expr: tier
      comment: "Sponsorship tier (title, presenting, supporting) for investment level analysis."
    - name: "is_active"
      expr: is_active
      comment: "Flag indicating whether the sponsorship is currently active."
    - name: "exclusivity_flag"
      expr: exclusivity_flag
      comment: "Flag indicating exclusive sponsorship rights."
    - name: "contract_start_date"
      expr: contract_start_date
      comment: "Contract start date for portfolio timeline management."
    - name: "contract_end_date"
      expr: contract_end_date
      comment: "Contract end date for renewal planning."
  measures:
    - name: "total_sponsorships"
      expr: COUNT(1)
      comment: "Total number of sponsorships — baseline portfolio sizing metric."
    - name: "total_contract_value"
      expr: SUM(CAST(contract_value_amount AS DOUBLE))
      comment: "Total sponsorship contract value — primary investment commitment KPI."
    - name: "total_annual_value"
      expr: SUM(CAST(annual_value_amount AS DOUBLE))
      comment: "Total annual sponsorship value — measures annual investment run rate."
    - name: "total_activation_budget"
      expr: SUM(CAST(activation_budget AS DOUBLE))
      comment: "Total activation budget — measures investment in activating sponsorship rights."
    - name: "total_rights_fee"
      expr: SUM(CAST(rights_fee AS DOUBLE))
      comment: "Total rights fees paid — measures cost of acquiring sponsorship rights."
    - name: "avg_roi_target_pct"
      expr: AVG(CAST(roi_target_percent AS DOUBLE))
      comment: "Average ROI target percentage — measures expected return on sponsorship investment."
    - name: "avg_contract_duration_years"
      expr: AVG(CAST(contract_duration_years AS DOUBLE))
      comment: "Average contract duration in years — measures portfolio commitment horizon."
    - name: "activation_to_rights_ratio"
      expr: ROUND(SUM(CAST(activation_budget AS DOUBLE)) / NULLIF(SUM(CAST(rights_fee AS DOUBLE)), 0), 2)
      comment: "Activation to rights fee ratio — measures investment in activating vs acquiring rights; industry benchmark is 1:1 minimum."
    - name: "active_sponsorship_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Number of active sponsorships — operational portfolio health indicator."
$$;
