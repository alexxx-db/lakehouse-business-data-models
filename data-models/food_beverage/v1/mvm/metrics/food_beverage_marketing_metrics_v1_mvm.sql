-- Metric views for domain: marketing | Business: Food Beverage | Version: 1 | Generated on: 2026-05-05 23:12:43

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`marketing_brand_equity_tracker`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Brand health and equity KPIs tracking awareness, consideration, preference, NPS, and perception scores across markets and consumer segments"
  source: "`food_beverage_ecm`.`marketing`.`brand_equity_tracker`"
  dimensions:
    - name: "measurement_period_start_date"
      expr: measurement_period_start_date
      comment: "Start date of the brand equity measurement period"
    - name: "measurement_period_end_date"
      expr: measurement_period_end_date
      comment: "End date of the brand equity measurement period"
    - name: "measurement_year"
      expr: YEAR(measurement_period_start_date)
      comment: "Year of brand equity measurement"
    - name: "measurement_quarter"
      expr: CONCAT('Q', QUARTER(measurement_period_start_date))
      comment: "Quarter of brand equity measurement"
    - name: "wave_label"
      expr: wave_label
      comment: "Wave identifier for tracking study"
    - name: "wave_type"
      expr: wave_type
      comment: "Type of tracking wave"
    - name: "market_country_code"
      expr: market_country_code
      comment: "Country code for the market measured"
    - name: "competitive_set_label"
      expr: competitive_set_label
      comment: "Competitive set definition for benchmarking"
    - name: "data_collection_method"
      expr: data_collection_method
      comment: "Method used to collect brand equity data"
    - name: "research_vendor_name"
      expr: research_vendor_name
      comment: "Vendor conducting the brand equity research"
    - name: "brand_equity_status"
      expr: brand_equity_status
      comment: "Status of the brand equity measurement record"
  measures:
    - name: "total_brand_equity_measurements"
      expr: COUNT(1)
      comment: "Total number of brand equity measurement records"
    - name: "avg_unaided_awareness_pct"
      expr: AVG(CAST(unaided_awareness_pct AS DOUBLE))
      comment: "Average unaided brand awareness percentage across measurements"
    - name: "avg_aided_awareness_pct"
      expr: AVG(CAST(aided_awareness_pct AS DOUBLE))
      comment: "Average aided brand awareness percentage across measurements"
    - name: "avg_consideration_pct"
      expr: AVG(CAST(consideration_pct AS DOUBLE))
      comment: "Average brand consideration percentage across measurements"
    - name: "avg_brand_preference_pct"
      expr: AVG(CAST(brand_preference_pct AS DOUBLE))
      comment: "Average brand preference percentage across measurements"
    - name: "avg_purchase_intent_pct"
      expr: AVG(CAST(purchase_intent_pct AS DOUBLE))
      comment: "Average purchase intent percentage across measurements"
    - name: "avg_trial_pct"
      expr: AVG(CAST(trial_pct AS DOUBLE))
      comment: "Average trial rate percentage across measurements"
    - name: "avg_repeat_purchase_pct"
      expr: AVG(CAST(repeat_purchase_pct AS DOUBLE))
      comment: "Average repeat purchase rate percentage across measurements"
    - name: "avg_nps_score"
      expr: AVG(CAST(nps_score AS DOUBLE))
      comment: "Average Net Promoter Score across measurements"
    - name: "avg_promoter_pct"
      expr: AVG(CAST(promoter_pct AS DOUBLE))
      comment: "Average promoter percentage across measurements"
    - name: "avg_detractor_pct"
      expr: AVG(CAST(detractor_pct AS DOUBLE))
      comment: "Average detractor percentage across measurements"
    - name: "avg_brand_health_index"
      expr: AVG(CAST(brand_health_index AS DOUBLE))
      comment: "Average composite brand health index score"
    - name: "avg_brand_love_score"
      expr: AVG(CAST(brand_love_score AS DOUBLE))
      comment: "Average brand love score across measurements"
    - name: "avg_brand_trust_score"
      expr: AVG(CAST(brand_trust_score AS DOUBLE))
      comment: "Average brand trust score across measurements"
    - name: "avg_brand_quality_perception_score"
      expr: AVG(CAST(brand_quality_perception_score AS DOUBLE))
      comment: "Average brand quality perception score"
    - name: "avg_brand_value_perception_score"
      expr: AVG(CAST(brand_value_perception_score AS DOUBLE))
      comment: "Average brand value perception score"
    - name: "avg_sustainability_perception_score"
      expr: AVG(CAST(sustainability_perception_score AS DOUBLE))
      comment: "Average sustainability perception score"
    - name: "avg_clean_label_perception_score"
      expr: AVG(CAST(clean_label_perception_score AS DOUBLE))
      comment: "Average clean label perception score"
    - name: "avg_social_media_sentiment_score"
      expr: AVG(CAST(social_media_sentiment_score AS DOUBLE))
      comment: "Average social media sentiment score"
    - name: "avg_advertising_recall_pct"
      expr: AVG(CAST(advertising_recall_pct AS DOUBLE))
      comment: "Average advertising recall percentage"
    - name: "distinct_brands_measured"
      expr: COUNT(DISTINCT brand_id)
      comment: "Number of distinct brands measured"
    - name: "distinct_markets_measured"
      expr: COUNT(DISTINCT market_id)
      comment: "Number of distinct markets measured"
    - name: "distinct_consumer_segments_measured"
      expr: COUNT(DISTINCT segment_id)
      comment: "Number of distinct consumer segments measured"
$$;


CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`marketing_campaign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Campaign performance KPIs tracking budget utilization, spend efficiency, and campaign execution across brands and channels"
  source: "`food_beverage_ecm`.`marketing`.`campaign`"
  dimensions:
    - name: "campaign_status"
      expr: campaign_status
      comment: "Current status of the campaign"
    - name: "campaign_type"
      expr: campaign_type
      comment: "Type of marketing campaign"
    - name: "channel"
      expr: channel
      comment: "Marketing channel for the campaign"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the campaign"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the campaign"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the campaign"
    - name: "start_year"
      expr: YEAR(start_date)
      comment: "Year the campaign started"
    - name: "start_quarter"
      expr: CONCAT('Q', QUARTER(start_date))
      comment: "Quarter the campaign started"
    - name: "start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the campaign started"
    - name: "target_geography"
      expr: target_geography
      comment: "Geographic target for the campaign"
    - name: "objective"
      expr: objective
      comment: "Primary objective of the campaign"
    - name: "trade_promotion_flag"
      expr: trade_promotion_flag
      comment: "Indicates if campaign includes trade promotion"
    - name: "shopper_marketing_flag"
      expr: shopper_marketing_flag
      comment: "Indicates if campaign includes shopper marketing"
    - name: "influencer_partnership"
      expr: influencer_partnership
      comment: "Indicates if campaign includes influencer partnership"
    - name: "fda_claims_compliant"
      expr: fda_claims_compliant
      comment: "Indicates if campaign claims are FDA compliant"
    - name: "ftc_claims_reviewed"
      expr: ftc_claims_reviewed
      comment: "Indicates if campaign claims were FTC reviewed"
  measures:
    - name: "total_campaigns"
      expr: COUNT(1)
      comment: "Total number of campaigns"
    - name: "total_planned_budget_usd"
      expr: SUM(CAST(planned_budget_usd AS DOUBLE))
      comment: "Total planned campaign budget in USD"
    - name: "total_actual_spend_usd"
      expr: SUM(CAST(actual_spend_usd AS DOUBLE))
      comment: "Total actual campaign spend in USD"
    - name: "avg_planned_budget_usd"
      expr: AVG(CAST(planned_budget_usd AS DOUBLE))
      comment: "Average planned budget per campaign in USD"
    - name: "avg_actual_spend_usd"
      expr: AVG(CAST(actual_spend_usd AS DOUBLE))
      comment: "Average actual spend per campaign in USD"
    - name: "budget_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_spend_usd AS DOUBLE)) / NULLIF(SUM(CAST(planned_budget_usd AS DOUBLE)), 0), 2)
      comment: "Percentage of planned budget actually spent across campaigns"
    - name: "total_media_impressions_target"
      expr: SUM(CAST(media_impressions_target AS DOUBLE))
      comment: "Total target media impressions across campaigns"
    - name: "total_reach_target_households"
      expr: SUM(CAST(reach_target_households AS DOUBLE))
      comment: "Total target household reach across campaigns"
    - name: "avg_media_impressions_target"
      expr: AVG(CAST(media_impressions_target AS DOUBLE))
      comment: "Average media impressions target per campaign"
    - name: "avg_reach_target_households"
      expr: AVG(CAST(reach_target_households AS DOUBLE))
      comment: "Average household reach target per campaign"
    - name: "distinct_brands_campaigned"
      expr: COUNT(DISTINCT brand_id)
      comment: "Number of distinct brands with campaigns"
    - name: "distinct_categories_campaigned"
      expr: COUNT(DISTINCT category_id)
      comment: "Number of distinct categories with campaigns"
    - name: "distinct_segments_targeted"
      expr: COUNT(DISTINCT segment_id)
      comment: "Number of distinct consumer segments targeted"
$$;


CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`marketing_campaign_execution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Campaign execution performance KPIs tracking media delivery, engagement, spend efficiency, and ROI across channels and placements"
  source: "`food_beverage_ecm`.`marketing`.`campaign_execution`"
  dimensions:
    - name: "execution_status"
      expr: execution_status
      comment: "Status of the campaign execution"
    - name: "channel_type"
      expr: channel_type
      comment: "Type of marketing channel"
    - name: "channel_platform"
      expr: channel_platform
      comment: "Specific platform within the channel"
    - name: "ad_format"
      expr: ad_format
      comment: "Format of the advertisement"
    - name: "buying_type"
      expr: buying_type
      comment: "Media buying type"
    - name: "flight_start_date"
      expr: flight_start_date
      comment: "Start date of the media flight"
    - name: "flight_end_date"
      expr: flight_end_date
      comment: "End date of the media flight"
    - name: "flight_year"
      expr: YEAR(flight_start_date)
      comment: "Year of the media flight"
    - name: "flight_quarter"
      expr: CONCAT('Q', QUARTER(flight_start_date))
      comment: "Quarter of the media flight"
    - name: "flight_month"
      expr: DATE_TRUNC('MONTH', flight_start_date)
      comment: "Month of the media flight"
    - name: "target_region"
      expr: target_region
      comment: "Target region for the execution"
    - name: "target_geography_code"
      expr: target_geography_code
      comment: "Geographic code for targeting"
    - name: "target_audience_segment"
      expr: target_audience_segment
      comment: "Target audience segment"
    - name: "target_retailer_name"
      expr: target_retailer_name
      comment: "Target retailer for execution"
    - name: "agency_name"
      expr: agency_name
      comment: "Agency executing the campaign"
    - name: "influencer_partnership_flag"
      expr: influencer_partnership_flag
      comment: "Indicates if execution includes influencer partnership"
    - name: "claim_compliance_status"
      expr: claim_compliance_status
      comment: "Compliance status of marketing claims"
  measures:
    - name: "total_executions"
      expr: COUNT(1)
      comment: "Total number of campaign executions"
    - name: "total_planned_spend_amount"
      expr: SUM(CAST(planned_spend_amount AS DOUBLE))
      comment: "Total planned spend across executions"
    - name: "total_actual_spend_amount"
      expr: SUM(CAST(actual_spend_amount AS DOUBLE))
      comment: "Total actual spend across executions"
    - name: "avg_planned_spend_amount"
      expr: AVG(CAST(planned_spend_amount AS DOUBLE))
      comment: "Average planned spend per execution"
    - name: "avg_actual_spend_amount"
      expr: AVG(CAST(actual_spend_amount AS DOUBLE))
      comment: "Average actual spend per execution"
    - name: "execution_spend_efficiency"
      expr: ROUND(100.0 * SUM(CAST(actual_spend_amount AS DOUBLE)) / NULLIF(SUM(CAST(planned_spend_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of planned spend actually utilized"
    - name: "total_impressions_delivered"
      expr: SUM(CAST(impressions_delivered AS DOUBLE))
      comment: "Total impressions delivered across executions"
    - name: "total_clicks_delivered"
      expr: SUM(CAST(clicks_delivered AS DOUBLE))
      comment: "Total clicks delivered across executions"
    - name: "total_reach"
      expr: SUM(CAST(reach AS DOUBLE))
      comment: "Total reach across executions"
    - name: "total_video_views"
      expr: SUM(CAST(video_views AS DOUBLE))
      comment: "Total video views across executions"
    - name: "avg_impressions_delivered"
      expr: AVG(CAST(impressions_delivered AS DOUBLE))
      comment: "Average impressions delivered per execution"
    - name: "avg_clicks_delivered"
      expr: AVG(CAST(clicks_delivered AS DOUBLE))
      comment: "Average clicks delivered per execution"
    - name: "avg_reach"
      expr: AVG(CAST(reach AS DOUBLE))
      comment: "Average reach per execution"
    - name: "avg_frequency"
      expr: AVG(CAST(frequency AS DOUBLE))
      comment: "Average frequency per execution"
    - name: "avg_cpm"
      expr: AVG(CAST(cost_per_thousand_impressions AS DOUBLE))
      comment: "Average cost per thousand impressions"
    - name: "avg_video_completion_rate"
      expr: AVG(CAST(video_completion_rate AS DOUBLE))
      comment: "Average video completion rate percentage"
    - name: "click_through_rate"
      expr: ROUND(100.0 * SUM(CAST(clicks_delivered AS DOUBLE)) / NULLIF(SUM(CAST(impressions_delivered AS DOUBLE)), 0), 2)
      comment: "Overall click-through rate percentage across executions"
    - name: "cost_per_click"
      expr: ROUND(SUM(CAST(actual_spend_amount AS DOUBLE)) / NULLIF(SUM(CAST(clicks_delivered AS DOUBLE)), 0), 2)
      comment: "Average cost per click across executions"
    - name: "distinct_campaigns_executed"
      expr: COUNT(DISTINCT campaign_id)
      comment: "Number of distinct campaigns executed"
    - name: "distinct_brands_executed"
      expr: COUNT(DISTINCT brand_id)
      comment: "Number of distinct brands with executions"
    - name: "distinct_media_plans_executed"
      expr: COUNT(DISTINCT media_plan_id)
      comment: "Number of distinct media plans executed"
$$;


CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`marketing_media_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Media planning KPIs tracking budget allocation, channel mix, planned reach and frequency, and spend variance across campaigns"
  source: "`food_beverage_ecm`.`marketing`.`media_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Status of the media plan"
    - name: "plan_type"
      expr: plan_type
      comment: "Type of media plan"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the media plan"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the media plan"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the media plan"
    - name: "plan_start_date"
      expr: plan_start_date
      comment: "Start date of the media plan"
    - name: "plan_end_date"
      expr: plan_end_date
      comment: "End date of the media plan"
    - name: "plan_year"
      expr: YEAR(plan_start_date)
      comment: "Year of the media plan"
    - name: "plan_quarter"
      expr: CONCAT('Q', QUARTER(plan_start_date))
      comment: "Quarter of the media plan"
    - name: "primary_channel"
      expr: primary_channel
      comment: "Primary media channel for the plan"
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the media plan"
    - name: "target_audience"
      expr: target_audience
      comment: "Target audience for the media plan"
    - name: "media_mix_strategy"
      expr: media_mix_strategy
      comment: "Media mix strategy employed"
    - name: "budget_owner"
      expr: budget_owner
      comment: "Owner of the media plan budget"
    - name: "fda_claims_compliant"
      expr: fda_claims_compliant
      comment: "Indicates if plan claims are FDA compliant"
    - name: "ftc_claims_reviewed"
      expr: ftc_claims_reviewed
      comment: "Indicates if plan claims were FTC reviewed"
  measures:
    - name: "total_media_plans"
      expr: COUNT(1)
      comment: "Total number of media plans"
    - name: "total_approved_budget_amount"
      expr: SUM(CAST(approved_budget_amount AS DOUBLE))
      comment: "Total approved budget across media plans"
    - name: "total_committed_spend_amount"
      expr: SUM(CAST(committed_spend_amount AS DOUBLE))
      comment: "Total committed spend across media plans"
    - name: "total_actual_spend_amount"
      expr: SUM(CAST(actual_spend_amount AS DOUBLE))
      comment: "Total actual spend across media plans"
    - name: "total_budget_variance_amount"
      expr: SUM(CAST(budget_variance_amount AS DOUBLE))
      comment: "Total budget variance across media plans"
    - name: "avg_approved_budget_amount"
      expr: AVG(CAST(approved_budget_amount AS DOUBLE))
      comment: "Average approved budget per media plan"
    - name: "avg_actual_spend_amount"
      expr: AVG(CAST(actual_spend_amount AS DOUBLE))
      comment: "Average actual spend per media plan"
    - name: "budget_commitment_rate"
      expr: ROUND(100.0 * SUM(CAST(committed_spend_amount AS DOUBLE)) / NULLIF(SUM(CAST(approved_budget_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of approved budget committed"
    - name: "budget_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_spend_amount AS DOUBLE)) / NULLIF(SUM(CAST(approved_budget_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of approved budget actually spent"
    - name: "total_tv_budget_amount"
      expr: SUM(CAST(tv_budget_amount AS DOUBLE))
      comment: "Total TV budget allocation"
    - name: "total_digital_budget_amount"
      expr: SUM(CAST(digital_budget_amount AS DOUBLE))
      comment: "Total digital budget allocation"
    - name: "total_social_budget_amount"
      expr: SUM(CAST(social_budget_amount AS DOUBLE))
      comment: "Total social media budget allocation"
    - name: "total_streaming_budget_amount"
      expr: SUM(CAST(streaming_budget_amount AS DOUBLE))
      comment: "Total streaming budget allocation"
    - name: "total_ooh_budget_amount"
      expr: SUM(CAST(ooh_budget_amount AS DOUBLE))
      comment: "Total out-of-home budget allocation"
    - name: "total_shopper_budget_amount"
      expr: SUM(CAST(shopper_budget_amount AS DOUBLE))
      comment: "Total shopper marketing budget allocation"
    - name: "total_production_cost_amount"
      expr: SUM(CAST(production_cost_amount AS DOUBLE))
      comment: "Total production cost across media plans"
    - name: "total_agency_fee_amount"
      expr: SUM(CAST(agency_fee_amount AS DOUBLE))
      comment: "Total agency fees across media plans"
    - name: "avg_planned_reach_pct"
      expr: AVG(CAST(planned_reach_pct AS DOUBLE))
      comment: "Average planned reach percentage"
    - name: "avg_planned_frequency"
      expr: AVG(CAST(planned_frequency AS DOUBLE))
      comment: "Average planned frequency"
    - name: "avg_planned_grp"
      expr: AVG(CAST(planned_grp AS DOUBLE))
      comment: "Average planned gross rating points"
    - name: "avg_working_media_pct"
      expr: AVG(CAST(working_media_pct AS DOUBLE))
      comment: "Average working media percentage"
    - name: "distinct_campaigns_planned"
      expr: COUNT(DISTINCT campaign_id)
      comment: "Number of distinct campaigns with media plans"
    - name: "distinct_brands_planned"
      expr: COUNT(DISTINCT brand_id)
      comment: "Number of distinct brands with media plans"
    - name: "distinct_markets_planned"
      expr: COUNT(DISTINCT market_id)
      comment: "Number of distinct markets with media plans"
$$;


CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`marketing_media_spend`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Media spend performance KPIs tracking actual spend, media efficiency, ROI, and delivery metrics by channel, market, and campaign"
  source: "`food_beverage_ecm`.`marketing`.`media_spend`"
  dimensions:
    - name: "spend_status"
      expr: spend_status
      comment: "Status of the media spend record"
    - name: "media_type"
      expr: media_type
      comment: "Type of media"
    - name: "media_channel"
      expr: media_channel
      comment: "Media channel"
    - name: "media_format"
      expr: media_format
      comment: "Format of the media"
    - name: "buying_type"
      expr: buying_type
      comment: "Media buying type"
    - name: "spend_date"
      expr: spend_date
      comment: "Date of the media spend"
    - name: "spend_year"
      expr: YEAR(spend_date)
      comment: "Year of the media spend"
    - name: "spend_quarter"
      expr: CONCAT('Q', QUARTER(spend_date))
      comment: "Quarter of the media spend"
    - name: "spend_month"
      expr: DATE_TRUNC('MONTH', spend_date)
      comment: "Month of the media spend"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the spend"
    - name: "flight_start_date"
      expr: flight_start_date
      comment: "Start date of the media flight"
    - name: "flight_end_date"
      expr: flight_end_date
      comment: "End date of the media flight"
    - name: "geo_market_code"
      expr: geo_market_code
      comment: "Geographic market code"
    - name: "dma_code"
      expr: dma_code
      comment: "Designated Market Area code"
    - name: "target_audience"
      expr: target_audience
      comment: "Target audience for the spend"
    - name: "working_media_flag"
      expr: working_media_flag
      comment: "Indicates if spend is working media"
    - name: "shopper_marketing_flag"
      expr: shopper_marketing_flag
      comment: "Indicates if spend is shopper marketing"
    - name: "ftc_compliant"
      expr: ftc_compliant
      comment: "Indicates if spend is FTC compliant"
    - name: "data_source"
      expr: data_source
      comment: "Source of the spend data"
  measures:
    - name: "total_spend_records"
      expr: COUNT(1)
      comment: "Total number of media spend records"
    - name: "total_planned_spend_amount"
      expr: SUM(CAST(planned_spend_amount AS DOUBLE))
      comment: "Total planned spend amount"
    - name: "total_actual_spend_amount"
      expr: SUM(CAST(actual_spend_amount AS DOUBLE))
      comment: "Total actual spend amount"
    - name: "total_committed_spend_amount"
      expr: SUM(CAST(committed_spend_amount AS DOUBLE))
      comment: "Total committed spend amount"
    - name: "total_agency_fee_amount"
      expr: SUM(CAST(agency_fee_amount AS DOUBLE))
      comment: "Total agency fees"
    - name: "avg_actual_spend_amount"
      expr: AVG(CAST(actual_spend_amount AS DOUBLE))
      comment: "Average actual spend per record"
    - name: "spend_vs_plan_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_spend_amount AS DOUBLE)) / NULLIF(SUM(CAST(planned_spend_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of planned spend actually incurred"
    - name: "total_impressions"
      expr: SUM(CAST(impressions AS DOUBLE))
      comment: "Total impressions delivered"
    - name: "total_clicks"
      expr: SUM(CAST(clicks AS DOUBLE))
      comment: "Total clicks delivered"
    - name: "total_reach"
      expr: SUM(CAST(reach AS DOUBLE))
      comment: "Total reach delivered"
    - name: "total_grp"
      expr: SUM(CAST(grp AS DOUBLE))
      comment: "Total gross rating points delivered"
    - name: "avg_impressions"
      expr: AVG(CAST(impressions AS DOUBLE))
      comment: "Average impressions per spend record"
    - name: "avg_clicks"
      expr: AVG(CAST(clicks AS DOUBLE))
      comment: "Average clicks per spend record"
    - name: "avg_reach"
      expr: AVG(CAST(reach AS DOUBLE))
      comment: "Average reach per spend record"
    - name: "avg_cpm"
      expr: AVG(CAST(cpm AS DOUBLE))
      comment: "Average cost per thousand impressions"
    - name: "avg_cpc"
      expr: AVG(CAST(cpc AS DOUBLE))
      comment: "Average cost per click"
    - name: "avg_roi_index"
      expr: AVG(CAST(roi_index AS DOUBLE))
      comment: "Average return on investment index"
    - name: "blended_cpm"
      expr: ROUND(1000.0 * SUM(CAST(actual_spend_amount AS DOUBLE)) / NULLIF(SUM(CAST(impressions AS DOUBLE)), 0), 2)
      comment: "Blended cost per thousand impressions across all spend"
    - name: "blended_cpc"
      expr: ROUND(SUM(CAST(actual_spend_amount AS DOUBLE)) / NULLIF(SUM(CAST(clicks AS DOUBLE)), 0), 2)
      comment: "Blended cost per click across all spend"
    - name: "click_through_rate"
      expr: ROUND(100.0 * SUM(CAST(clicks AS DOUBLE)) / NULLIF(SUM(CAST(impressions AS DOUBLE)), 0), 2)
      comment: "Overall click-through rate percentage"
    - name: "distinct_campaigns_spent"
      expr: COUNT(DISTINCT campaign_id)
      comment: "Number of distinct campaigns with spend"
    - name: "distinct_brands_spent"
      expr: COUNT(DISTINCT brand_id)
      comment: "Number of distinct brands with spend"
    - name: "distinct_markets_spent"
      expr: COUNT(DISTINCT market_id)
      comment: "Number of distinct markets with spend"
    - name: "distinct_suppliers"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of distinct media suppliers"
$$;


CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`marketing_syndicated_market_data`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Market performance KPIs tracking sales, share, distribution, pricing, and promotional effectiveness from syndicated retail data"
  source: "`food_beverage_ecm`.`marketing`.`syndicated_market_data`"
  dimensions:
    - name: "reporting_period_type"
      expr: reporting_period_type
      comment: "Type of reporting period"
    - name: "period_start_date"
      expr: period_start_date
      comment: "Start date of the reporting period"
    - name: "period_end_date"
      expr: period_end_date
      comment: "End date of the reporting period"
    - name: "period_year"
      expr: YEAR(period_start_date)
      comment: "Year of the reporting period"
    - name: "period_quarter"
      expr: CONCAT('Q', QUARTER(period_start_date))
      comment: "Quarter of the reporting period"
    - name: "period_month"
      expr: DATE_TRUNC('MONTH', period_start_date)
      comment: "Month of the reporting period"
    - name: "retail_channel"
      expr: retail_channel
      comment: "Retail channel"
    - name: "segment_name"
      expr: segment_name
      comment: "Market segment name"
    - name: "subcategory_name"
      expr: subcategory_name
      comment: "Market subcategory name"
    - name: "manufacturer_name"
      expr: manufacturer_name
      comment: "Manufacturer name"
    - name: "is_own_brand"
      expr: is_own_brand
      comment: "Indicates if the brand is owned by the company"
    - name: "is_private_label"
      expr: is_private_label
      comment: "Indicates if the product is private label"
    - name: "pack_size"
      expr: pack_size
      comment: "Pack size of the product"
    - name: "data_aggregation_level"
      expr: data_aggregation_level
      comment: "Level of data aggregation"
    - name: "source_system"
      expr: source_system
      comment: "Source system of the syndicated data"
  measures:
    - name: "total_data_records"
      expr: COUNT(1)
      comment: "Total number of syndicated data records"
    - name: "total_dollar_sales"
      expr: SUM(CAST(dollar_sales AS DOUBLE))
      comment: "Total dollar sales"
    - name: "total_unit_sales"
      expr: SUM(CAST(unit_sales AS DOUBLE))
      comment: "Total unit sales"
    - name: "total_equivalent_unit_sales"
      expr: SUM(CAST(equivalent_unit_sales AS DOUBLE))
      comment: "Total equivalent unit sales"
    - name: "total_promoted_dollar_sales"
      expr: SUM(CAST(promoted_dollar_sales AS DOUBLE))
      comment: "Total dollar sales on promotion"
    - name: "total_promoted_unit_sales"
      expr: SUM(CAST(promoted_unit_sales AS DOUBLE))
      comment: "Total unit sales on promotion"
    - name: "avg_dollar_sales"
      expr: AVG(CAST(dollar_sales AS DOUBLE))
      comment: "Average dollar sales per record"
    - name: "avg_unit_sales"
      expr: AVG(CAST(unit_sales AS DOUBLE))
      comment: "Average unit sales per record"
    - name: "avg_selling_price"
      expr: AVG(CAST(avg_selling_price AS DOUBLE))
      comment: "Average selling price"
    - name: "avg_base_price"
      expr: AVG(CAST(avg_base_price AS DOUBLE))
      comment: "Average base price"
    - name: "weighted_avg_dollar_share_pct"
      expr: AVG(CAST(dollar_share_pct AS DOUBLE))
      comment: "Weighted average dollar share percentage"
    - name: "weighted_avg_unit_share_pct"
      expr: AVG(CAST(unit_share_pct AS DOUBLE))
      comment: "Weighted average unit share percentage"
    - name: "avg_acv_distribution_pct"
      expr: AVG(CAST(acv_distribution_pct AS DOUBLE))
      comment: "Average ACV distribution percentage"
    - name: "avg_numeric_distribution_pct"
      expr: AVG(CAST(numeric_distribution_pct AS DOUBLE))
      comment: "Average numeric distribution percentage"
    - name: "avg_velocity_per_store_per_week"
      expr: AVG(CAST(velocity_per_store_per_week AS DOUBLE))
      comment: "Average velocity per store per week"
    - name: "avg_feature_pct"
      expr: AVG(CAST(feature_pct AS DOUBLE))
      comment: "Average feature percentage"
    - name: "avg_display_pct"
      expr: AVG(CAST(display_pct AS DOUBLE))
      comment: "Average display percentage"
    - name: "avg_tdp"
      expr: AVG(CAST(tdp AS DOUBLE))
      comment: "Average total distribution points"
    - name: "avg_price_reduction_pct"
      expr: AVG(CAST(price_reduction_pct AS DOUBLE))
      comment: "Average price reduction percentage"
    - name: "avg_dollar_sales_change_pct"
      expr: AVG(CAST(dollar_sales_change_pct AS DOUBLE))
      comment: "Average dollar sales change percentage"
    - name: "avg_unit_sales_change_pct"
      expr: AVG(CAST(unit_sales_change_pct AS DOUBLE))
      comment: "Average unit sales change percentage"
    - name: "promotional_sales_mix"
      expr: ROUND(100.0 * SUM(CAST(promoted_dollar_sales AS DOUBLE)) / NULLIF(SUM(CAST(dollar_sales AS DOUBLE)), 0), 2)
      comment: "Percentage of total sales that were promoted"
    - name: "distinct_brands_tracked"
      expr: COUNT(DISTINCT brand_id)
      comment: "Number of distinct brands tracked"
    - name: "distinct_categories_tracked"
      expr: COUNT(DISTINCT category_id)
      comment: "Number of distinct categories tracked"
    - name: "distinct_skus_tracked"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs tracked"
    - name: "distinct_markets_tracked"
      expr: COUNT(DISTINCT market_id)
      comment: "Number of distinct markets tracked"
$$;


CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`marketing_consumer_insight`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Consumer research KPIs tracking study performance, concept testing, sensory scores, NPS, and research investment ROI"
  source: "`food_beverage_ecm`.`marketing`.`consumer_insight`"
  dimensions:
    - name: "study_status"
      expr: study_status
      comment: "Status of the consumer insight study"
    - name: "study_type"
      expr: study_type
      comment: "Type of consumer insight study"
    - name: "research_methodology"
      expr: research_methodology
      comment: "Research methodology employed"
    - name: "insight_category"
      expr: insight_category
      comment: "Category of the insight"
    - name: "insight_priority"
      expr: insight_priority
      comment: "Priority level of the insight"
    - name: "fielding_start_date"
      expr: fielding_start_date
      comment: "Start date of fielding"
    - name: "fielding_end_date"
      expr: fielding_end_date
      comment: "End date of fielding"
    - name: "fielding_year"
      expr: YEAR(fielding_start_date)
      comment: "Year of fielding"
    - name: "fielding_quarter"
      expr: CONCAT('Q', QUARTER(fielding_start_date))
      comment: "Quarter of fielding"
    - name: "deliverable_date"
      expr: deliverable_date
      comment: "Date the insight deliverable was provided"
    - name: "geography_scope"
      expr: geography_scope
      comment: "Geographic scope of the study"
    - name: "target_segment"
      expr: target_segment
      comment: "Target consumer segment"
    - name: "research_vendor"
      expr: research_vendor
      comment: "Vendor conducting the research"
    - name: "npd_pipeline_flag"
      expr: npd_pipeline_flag
      comment: "Indicates if insight is related to NPD pipeline"
    - name: "regulatory_claim_flag"
      expr: regulatory_claim_flag
      comment: "Indicates if insight relates to regulatory claims"
    - name: "allergen_relevance"
      expr: allergen_relevance
      comment: "Indicates if insight is relevant to allergens"
    - name: "clean_label_relevance"
      expr: clean_label_relevance
      comment: "Indicates if insight is relevant to clean label"
    - name: "sustainability_relevance"
      expr: sustainability_relevance
      comment: "Indicates if insight is relevant to sustainability"
    - name: "private_label_relevance"
      expr: private_label_relevance
      comment: "Indicates if insight is relevant to private label"
  measures:
    - name: "total_consumer_insights"
      expr: COUNT(1)
      comment: "Total number of consumer insight records"
    - name: "total_study_budget_usd"
      expr: SUM(CAST(study_budget_usd AS DOUBLE))
      comment: "Total study budget in USD"
    - name: "total_actual_spend_usd"
      expr: SUM(CAST(actual_spend_usd AS DOUBLE))
      comment: "Total actual spend on studies in USD"
    - name: "avg_study_budget_usd"
      expr: AVG(CAST(study_budget_usd AS DOUBLE))
      comment: "Average study budget per insight in USD"
    - name: "avg_actual_spend_usd"
      expr: AVG(CAST(actual_spend_usd AS DOUBLE))
      comment: "Average actual spend per insight in USD"
    - name: "research_budget_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_spend_usd AS DOUBLE)) / NULLIF(SUM(CAST(study_budget_usd AS DOUBLE)), 0), 2)
      comment: "Percentage of study budget actually spent"
    - name: "avg_concept_test_score"
      expr: AVG(CAST(concept_test_score AS DOUBLE))
      comment: "Average concept test score"
    - name: "avg_sensory_score"
      expr: AVG(CAST(sensory_score AS DOUBLE))
      comment: "Average sensory score"
    - name: "avg_nps_score"
      expr: AVG(CAST(nps_score AS DOUBLE))
      comment: "Average Net Promoter Score from consumer insights"
    - name: "avg_confidence_level_pct"
      expr: AVG(CAST(confidence_level_pct AS DOUBLE))
      comment: "Average confidence level percentage"
    - name: "distinct_brands_researched"
      expr: COUNT(DISTINCT brand_id)
      comment: "Number of distinct brands researched"
    - name: "distinct_categories_researched"
      expr: COUNT(DISTINCT category_id)
      comment: "Number of distinct categories researched"
    - name: "distinct_skus_researched"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs researched"
    - name: "distinct_markets_researched"
      expr: COUNT(DISTINCT market_id)
      comment: "Number of distinct markets researched"
    - name: "distinct_campaigns_researched"
      expr: COUNT(DISTINCT campaign_id)
      comment: "Number of distinct campaigns researched"
$$;
