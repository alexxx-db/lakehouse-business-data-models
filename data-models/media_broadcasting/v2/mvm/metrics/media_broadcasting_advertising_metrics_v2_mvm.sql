-- Metric views for domain: advertising | Business: Media_Broadcasting | Version: 2 | Generated on: 2026-06-30 06:47:57

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`advertising_campaign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core advertising campaign performance metrics including budget utilization, pacing, and target achievement rates"
  source: "`vibe_media_broadcasting_v1`.`advertising`.`advertising_campaign`"
  dimensions:
    - name: "campaign_name"
      expr: campaign_name
      comment: "Name of the advertising campaign"
    - name: "campaign_status"
      expr: campaign_status
      comment: "Current status of the campaign (active, paused, completed, etc.)"
    - name: "campaign_type"
      expr: campaign_type
      comment: "Type of advertising campaign (brand, direct response, etc.)"
    - name: "optimization_goal"
      expr: optimization_goal
      comment: "Primary optimization objective for the campaign"
    - name: "pacing_type"
      expr: pacing_type
      comment: "Budget pacing strategy (even, ASAP, custom)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for campaign budgets and targets"
    - name: "campaign_start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month when campaign started, for cohort analysis"
    - name: "campaign_start_year"
      expr: YEAR(start_date)
      comment: "Year when campaign started"
  measures:
    - name: "total_campaign_budget"
      expr: SUM(CAST(total_budget_amount AS DOUBLE))
      comment: "Total budget allocated across all campaigns"
    - name: "total_daily_budget"
      expr: SUM(CAST(daily_budget_amount AS DOUBLE))
      comment: "Sum of daily budget caps across campaigns"
    - name: "avg_campaign_budget"
      expr: AVG(CAST(total_budget_amount AS DOUBLE))
      comment: "Average budget per campaign"
    - name: "total_target_impressions"
      expr: SUM(CAST(target_impressions AS DOUBLE))
      comment: "Total impression targets across campaigns"
    - name: "total_target_clicks"
      expr: SUM(CAST(target_clicks AS DOUBLE))
      comment: "Total click targets across campaigns"
    - name: "total_target_conversions"
      expr: SUM(CAST(target_conversions AS DOUBLE))
      comment: "Total conversion targets across campaigns"
    - name: "avg_target_cpm"
      expr: AVG(CAST(target_cpm AS DOUBLE))
      comment: "Average target cost per thousand impressions"
    - name: "avg_target_cpc"
      expr: AVG(CAST(target_cpc AS DOUBLE))
      comment: "Average target cost per click"
    - name: "avg_target_cpa"
      expr: AVG(CAST(target_cpa AS DOUBLE))
      comment: "Average target cost per acquisition"
    - name: "campaign_count"
      expr: COUNT(DISTINCT advertising_campaign_id)
      comment: "Number of distinct advertising campaigns"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`advertising_impression`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Impression delivery, viewability, fraud detection, and cost metrics for advertising performance analysis"
  source: "`vibe_media_broadcasting_v1`.`advertising`.`impression`"
  dimensions:
    - name: "device_type"
      expr: device_type
      comment: "Type of device where impression was served (mobile, desktop, tablet, CTV)"
    - name: "platform"
      expr: platform
      comment: "Platform where impression was delivered"
    - name: "geo_country"
      expr: geo_country
      comment: "Country where impression was served"
    - name: "geo_region"
      expr: geo_region
      comment: "Region or state where impression was served"
    - name: "geo_dma"
      expr: geo_dma
      comment: "Designated Market Area for impression delivery"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for impression costs"
    - name: "is_fraud"
      expr: is_fraud_flag
      comment: "Whether impression was flagged as fraudulent"
    - name: "is_viewable"
      expr: viewable_flag
      comment: "Whether impression met viewability standards"
    - name: "viewability_measured"
      expr: viewability_measured_flag
      comment: "Whether viewability was measured for this impression"
    - name: "impression_date"
      expr: DATE_TRUNC('DAY', impression_timestamp)
      comment: "Date of impression delivery"
    - name: "impression_month"
      expr: DATE_TRUNC('MONTH', impression_timestamp)
      comment: "Month of impression delivery"
    - name: "impression_hour"
      expr: HOUR(impression_timestamp)
      comment: "Hour of day when impression was served"
  measures:
    - name: "total_impressions"
      expr: COUNT(impression_id)
      comment: "Total number of ad impressions delivered"
    - name: "total_impression_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost of all impressions delivered"
    - name: "avg_impression_cost"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average cost per impression"
    - name: "total_bid_value"
      expr: SUM(CAST(bid_price AS DOUBLE))
      comment: "Total bid value across all impressions"
    - name: "avg_bid_price"
      expr: AVG(CAST(bid_price AS DOUBLE))
      comment: "Average bid price per impression"
    - name: "viewable_impressions"
      expr: SUM(CASE WHEN viewable_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of impressions that met viewability standards"
    - name: "fraud_impressions"
      expr: SUM(CASE WHEN is_fraud_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of impressions flagged as fraudulent"
    - name: "measured_impressions"
      expr: SUM(CASE WHEN viewability_measured_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of impressions where viewability was measured"
    - name: "total_viewable_seconds"
      expr: SUM(CAST(viewable_seconds AS DOUBLE))
      comment: "Total seconds of viewable impression time"
    - name: "avg_viewable_seconds"
      expr: AVG(CAST(viewable_seconds AS DOUBLE))
      comment: "Average viewable seconds per impression"
    - name: "avg_viewable_percent"
      expr: AVG(CAST(viewable_percent AS DOUBLE))
      comment: "Average percentage of impression that was viewable"
    - name: "unique_campaigns"
      expr: COUNT(DISTINCT advertising_campaign_id)
      comment: "Number of distinct campaigns with impressions"
    - name: "unique_creatives"
      expr: COUNT(DISTINCT creative_id)
      comment: "Number of distinct creatives served"
    - name: "unique_subscribers"
      expr: COUNT(DISTINCT subscriber_id)
      comment: "Number of unique subscribers reached"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`advertising_click`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Click-through performance metrics including fraud detection and engagement timing analysis"
  source: "`vibe_media_broadcasting_v1`.`advertising`.`click`"
  dimensions:
    - name: "device_type"
      expr: device_type
      comment: "Type of device where click occurred"
    - name: "platform"
      expr: platform
      comment: "Platform where click was registered"
    - name: "geo_country"
      expr: geo_country
      comment: "Country where click originated"
    - name: "geo_region"
      expr: geo_region
      comment: "Region or state where click originated"
    - name: "is_fraud"
      expr: is_fraud_flag
      comment: "Whether click was flagged as fraudulent"
    - name: "click_date"
      expr: DATE_TRUNC('DAY', click_timestamp)
      comment: "Date of click event"
    - name: "click_month"
      expr: DATE_TRUNC('MONTH', click_timestamp)
      comment: "Month of click event"
    - name: "click_hour"
      expr: HOUR(click_timestamp)
      comment: "Hour of day when click occurred"
  measures:
    - name: "total_clicks"
      expr: COUNT(click_id)
      comment: "Total number of ad clicks"
    - name: "valid_clicks"
      expr: SUM(CASE WHEN is_fraud_flag = FALSE THEN 1 ELSE 0 END)
      comment: "Count of clicks not flagged as fraudulent"
    - name: "fraud_clicks"
      expr: SUM(CASE WHEN is_fraud_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of clicks flagged as fraudulent"
    - name: "avg_time_to_click"
      expr: AVG(CAST(time_to_click_seconds AS DOUBLE))
      comment: "Average time in seconds from impression to click"
    - name: "total_time_to_click"
      expr: SUM(CAST(time_to_click_seconds AS DOUBLE))
      comment: "Total engagement time from impression to click across all clicks"
    - name: "unique_campaigns_clicked"
      expr: COUNT(DISTINCT advertising_campaign_id)
      comment: "Number of distinct campaigns that received clicks"
    - name: "unique_creatives_clicked"
      expr: COUNT(DISTINCT creative_id)
      comment: "Number of distinct creatives that were clicked"
    - name: "unique_subscribers_clicking"
      expr: COUNT(DISTINCT subscriber_id)
      comment: "Number of unique subscribers who clicked"
    - name: "unique_impressions_clicked"
      expr: COUNT(DISTINCT impression_id)
      comment: "Number of distinct impressions that resulted in clicks"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`advertising_conversion`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Conversion and attribution metrics tracking campaign effectiveness and customer acquisition value"
  source: "`vibe_media_broadcasting_v1`.`advertising`.`conversion`"
  dimensions:
    - name: "conversion_type"
      expr: conversion_type
      comment: "Type of conversion event (purchase, signup, download, etc.)"
    - name: "attribution_type"
      expr: attribution_type
      comment: "Attribution model used (first-touch, last-touch, multi-touch, etc.)"
    - name: "attribution_window_hours"
      expr: attribution_window_hours
      comment: "Attribution window in hours for conversion credit"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for conversion value"
    - name: "is_deduplicated"
      expr: is_deduplicated_flag
      comment: "Whether conversion was deduplicated across channels"
    - name: "conversion_date"
      expr: DATE_TRUNC('DAY', conversion_timestamp)
      comment: "Date of conversion event"
    - name: "conversion_month"
      expr: DATE_TRUNC('MONTH', conversion_timestamp)
      comment: "Month of conversion event"
    - name: "conversion_hour"
      expr: HOUR(conversion_timestamp)
      comment: "Hour of day when conversion occurred"
  measures:
    - name: "total_conversions"
      expr: COUNT(conversion_id)
      comment: "Total number of conversion events"
    - name: "deduplicated_conversions"
      expr: SUM(CASE WHEN is_deduplicated_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of conversions after deduplication"
    - name: "total_conversion_value"
      expr: SUM(CAST(value AS DOUBLE))
      comment: "Total monetary value of all conversions"
    - name: "avg_conversion_value"
      expr: AVG(CAST(value AS DOUBLE))
      comment: "Average value per conversion event"
    - name: "unique_campaigns_converting"
      expr: COUNT(DISTINCT advertising_campaign_id)
      comment: "Number of distinct campaigns that drove conversions"
    - name: "unique_subscribers_converting"
      expr: COUNT(DISTINCT subscriber_id)
      comment: "Number of unique subscribers who converted"
    - name: "unique_clicks_converting"
      expr: COUNT(DISTINCT click_id)
      comment: "Number of distinct clicks that led to conversions"
    - name: "unique_impressions_converting"
      expr: COUNT(DISTINCT impression_id)
      comment: "Number of distinct impressions that led to conversions"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`advertising_ad_inventory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ad inventory availability, pricing, and audience targeting metrics for yield optimization and sales planning"
  source: "`vibe_media_broadcasting_v1`.`advertising`.`ad_inventory`"
  dimensions:
    - name: "inventory_status"
      expr: inventory_status
      comment: "Current status of inventory (available, sold, held, expired)"
    - name: "inventory_type"
      expr: inventory_type
      comment: "Type of ad inventory (guaranteed, preemptible, programmatic, etc.)"
    - name: "pricing_tier"
      expr: pricing_tier
      comment: "Pricing tier classification for inventory"
    - name: "sales_category"
      expr: sales_category
      comment: "Sales category or package classification"
    - name: "brand_safety_tier"
      expr: brand_safety_tier
      comment: "Brand safety classification tier"
    - name: "content_rating"
      expr: content_rating
      comment: "Content rating for brand suitability"
    - name: "contextual_category"
      expr: contextual_category
      comment: "Contextual category for targeting"
    - name: "ad_pod_position"
      expr: ad_pod_position
      comment: "Position within ad pod (first, mid, last)"
    - name: "is_preemptible"
      expr: preemptible
      comment: "Whether inventory can be preempted"
    - name: "is_makegood_eligible"
      expr: makegood_eligible
      comment: "Whether inventory is eligible for makegood"
    - name: "is_programmatic_eligible"
      expr: programmatic_eligible_flag
      comment: "Whether inventory can be sold programmatically"
    - name: "is_first_party_data_eligible"
      expr: first_party_data_eligible_flag
      comment: "Whether first-party data targeting is available"
    - name: "inventory_date"
      expr: DATE_TRUNC('DAY', inventory_date)
      comment: "Date of inventory availability"
    - name: "inventory_month"
      expr: DATE_TRUNC('MONTH', inventory_date)
      comment: "Month of inventory availability"
    - name: "effective_date"
      expr: DATE_TRUNC('DAY', effective_date)
      comment: "Date when inventory becomes effective"
  measures:
    - name: "total_inventory_units"
      expr: COUNT(ad_inventory_id)
      comment: "Total count of inventory records"
    - name: "total_estimated_impressions"
      expr: SUM(CAST(estimated_impressions AS DOUBLE))
      comment: "Total estimated impressions across inventory"
    - name: "total_estimated_reach"
      expr: SUM(CAST(estimated_reach AS DOUBLE))
      comment: "Total estimated unique reach across inventory"
    - name: "avg_estimated_impressions"
      expr: AVG(CAST(estimated_impressions AS DOUBLE))
      comment: "Average estimated impressions per inventory unit"
    - name: "total_estimated_grp"
      expr: SUM(CAST(estimated_grp AS DOUBLE))
      comment: "Total estimated Gross Rating Points"
    - name: "total_estimated_trp"
      expr: SUM(CAST(estimated_trp AS DOUBLE))
      comment: "Total estimated Target Rating Points"
    - name: "avg_floor_price_cpm"
      expr: AVG(CAST(floor_price_cpm AS DOUBLE))
      comment: "Average floor price CPM across inventory"
    - name: "avg_rate_card_cpm"
      expr: AVG(CAST(rate_card_cpm AS DOUBLE))
      comment: "Average rate card CPM"
    - name: "avg_rate_card_cprp"
      expr: AVG(CAST(rate_card_cprp AS DOUBLE))
      comment: "Average rate card cost per rating point"
    - name: "avg_viewability_threshold"
      expr: AVG(CAST(viewability_threshold AS DOUBLE))
      comment: "Average viewability threshold requirement"
    - name: "unique_channels"
      expr: COUNT(DISTINCT channel_id)
      comment: "Number of distinct channels in inventory"
    - name: "unique_delivery_channels"
      expr: COUNT(DISTINCT delivery_channel_id)
      comment: "Number of distinct delivery channels"
$$;