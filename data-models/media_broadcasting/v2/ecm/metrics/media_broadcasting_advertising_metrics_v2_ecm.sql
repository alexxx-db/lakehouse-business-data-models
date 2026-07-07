-- Metric views for domain: advertising | Business: Media_Broadcasting | Version: 2 | Generated on: 2026-06-30 04:55:25

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`advertising_ad_campaign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Campaign-level KPIs for budget planning, pacing, and portfolio management across advertisers."
  source: "`vibe_media_broadcasting_v1`.`advertising`.`campaign`"
  dimensions:
    - name: "pacing_type"
      expr: pacing_type
      comment: "Pacing strategy (even, accelerated) to evaluate delivery control."
    - name: "start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Campaign start month for time-series planning."
  measures:
    - name: "campaign_count"
      expr: COUNT(1)
      comment: "Number of campaigns; baseline volume of advertising commitments."
    - name: "active_advertiser_count"
      expr: COUNT(DISTINCT advertiser_id)
      comment: "Distinct advertisers running campaigns; client breadth indicator for sales leadership."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`advertising_ad_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Delivery and effectiveness KPIs (CTR, VCR, viewability, spend efficiency) for campaign optimization."
  source: "`vibe_media_broadcasting_v1`.`advertising`.`ad_performance`"
  dimensions:
    - name: "report_month"
      expr: DATE_TRUNC('MONTH', report_date)
      comment: "Reporting month for performance trend analysis."
    - name: "spend_currency"
      expr: spend_currency
      comment: "Currency of recorded spend for normalization across markets."
  measures:
    - name: "total_impressions"
      expr: SUM(CAST(impressions AS DOUBLE))
      comment: "Total delivered impressions; core delivery KPI for guarantee reconciliation."
    - name: "total_clicks"
      expr: SUM(CAST(clicks AS DOUBLE))
      comment: "Total clicks; engagement volume driving conversion funnel."
    - name: "total_completions"
      expr: SUM(CAST(completions AS DOUBLE))
      comment: "Total video completions; quality-of-delivery indicator for CTV."
    - name: "total_spend"
      expr: SUM(CAST(spend_amount AS DOUBLE))
      comment: "Total media spend; primary cost/revenue tracking metric."
    - name: "click_through_rate"
      expr: ROUND(100.0 * SUM(CAST(clicks AS DOUBLE)) / NULLIF(SUM(CAST(impressions AS DOUBLE)), 0), 4)
      comment: "Clicks per 100 impressions; campaign effectiveness KPI that triggers creative optimization."
    - name: "video_completion_rate"
      expr: ROUND(100.0 * SUM(CAST(completions AS DOUBLE)) / NULLIF(SUM(CAST(impressions AS DOUBLE)), 0), 2)
      comment: "Completed views per 100 impressions; CTV/OTT quality KPI for upfront guarantees."
    - name: "avg_viewability_rate"
      expr: AVG(CAST(viewability_rate AS DOUBLE))
      comment: "Average viewability rate; MRC/IAB compliance KPI for guarantee reconciliation."
    - name: "avg_cpm"
      expr: AVG(CAST(cpm AS DOUBLE))
      comment: "Average effective CPM; pricing yield benchmark for revenue management."
    - name: "effective_cpm"
      expr: ROUND(1000.0 * SUM(CAST(spend_amount AS DOUBLE)) / NULLIF(SUM(CAST(impressions AS DOUBLE)), 0), 2)
      comment: "Spend per thousand delivered impressions; true monetization yield steering pricing decisions."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`advertising_impression`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Impression-level telemetry KPIs for viewability, fraud/IVT, and cost monitoring in programmatic delivery."
  source: "`vibe_media_broadcasting_v1`.`advertising`.`impression`"
  dimensions:
    - name: "device_type"
      expr: device_type
      comment: "Device type (CTV, mobile, desktop) for channel-mix yield analysis."
    - name: "platform"
      expr: platform
      comment: "Delivery platform for distribution performance segmentation."
    - name: "geo_country"
      expr: geo_country
      comment: "Country of impression for geographic delivery distribution."
    - name: "geo_dma"
      expr: geo_dma
      comment: "DMA of impression for local-market delivery and blackout monitoring."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of impression cost for normalization."
    - name: "impression_month"
      expr: DATE_TRUNC('MONTH', impression_timestamp)
      comment: "Month of impression for delivery trend analysis."
  measures:
    - name: "impression_count"
      expr: COUNT(1)
      comment: "Total impressions served; baseline programmatic delivery volume."
    - name: "total_impression_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total impression cost; programmatic media-cost tracking metric."
    - name: "avg_bid_price"
      expr: AVG(CAST(bid_price AS DOUBLE))
      comment: "Average winning bid price; OpenRTB clearing-price benchmark for yield."
    - name: "fraud_impression_count"
      expr: SUM(CASE WHEN is_fraud_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of fraudulent/IVT impressions; risk metric triggering supply-path intervention."
    - name: "fraud_impression_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_fraud_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of impressions flagged fraud/IVT; quality KPI for supply-source decisions."
    - name: "viewable_impression_count"
      expr: SUM(CASE WHEN viewable_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of viewable impressions; basis for viewability guarantee delivery."
    - name: "viewability_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN viewable_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of impressions viewable; MRC/IAB KPI for guarantee reconciliation."
    - name: "avg_viewable_percent"
      expr: AVG(CAST(viewable_percent AS DOUBLE))
      comment: "Average viewable pixel percentage; granular viewability quality metric."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`advertising_click`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Click-event KPIs for engagement quality and click fraud detection."
  source: "`vibe_media_broadcasting_v1`.`advertising`.`click`"
  dimensions:
    - name: "device_type"
      expr: device_type
      comment: "Device type of click for channel engagement analysis."
    - name: "platform"
      expr: platform
      comment: "Platform of click for distribution engagement segmentation."
    - name: "geo_country"
      expr: geo_country
      comment: "Country of click for geographic engagement distribution."
    - name: "click_month"
      expr: DATE_TRUNC('MONTH', click_timestamp)
      comment: "Month of click for engagement trend analysis."
  measures:
    - name: "click_count"
      expr: COUNT(1)
      comment: "Total clicks; baseline engagement volume."
    - name: "fraud_click_count"
      expr: SUM(CASE WHEN is_fraud_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Fraudulent clicks; risk metric triggering traffic-source review."
    - name: "click_fraud_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_fraud_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of clicks flagged fraud; quality KPI driving partner accountability."
    - name: "avg_time_to_click_seconds"
      expr: AVG(CAST(time_to_click_seconds AS DOUBLE))
      comment: "Average latency to click; engagement-intent indicator for creative tuning."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`advertising_conversion`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Conversion KPIs for attributed value and campaign ROI measurement."
  source: "`vibe_media_broadcasting_v1`.`advertising`.`conversion`"
  dimensions:
    - name: "conversion_type"
      expr: conversion_type
      comment: "Type of conversion (purchase, signup) for funnel-outcome segmentation."
    - name: "attribution_type"
      expr: attribution_type
      comment: "Attribution model (last-touch, multi-touch) for measurement consistency."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of conversion value for normalization."
    - name: "conversion_month"
      expr: DATE_TRUNC('MONTH', conversion_timestamp)
      comment: "Month of conversion for outcome trend analysis."
  measures:
    - name: "conversion_count"
      expr: COUNT(1)
      comment: "Total conversions; core outcome volume tied to campaign success."
    - name: "total_conversion_value"
      expr: SUM(CAST(value AS DOUBLE))
      comment: "Total attributed conversion value; revenue-outcome metric for ROI/ROAS analysis."
    - name: "avg_conversion_value"
      expr: AVG(CAST(value AS DOUBLE))
      comment: "Average value per conversion; deal-quality benchmark."
    - name: "deduplicated_conversion_count"
      expr: SUM(CASE WHEN is_deduplicated_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of deduplicated conversions; clean-attribution count for accurate ROI reporting."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`advertising_ad_inventory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory availability, sell-through, and pricing yield KPIs for ad sales revenue management."
  source: "`vibe_media_broadcasting_v1`.`advertising`.`ad_inventory`"
  dimensions:
    - name: "inventory_type"
      expr: inventory_type
      comment: "Inventory type (linear, CTV, programmatic) for supply-mix yield analysis."
    - name: "inventory_status"
      expr: inventory_status
      comment: "Inventory status (available, sold, held) for sell-through monitoring."
    - name: "pricing_tier"
      expr: pricing_tier
      comment: "Pricing tier for rate-yield segmentation."
    - name: "sales_category"
      expr: sales_category
      comment: "Sales category for revenue attribution."
    - name: "brand_safety_tier"
      expr: brand_safety_tier
      comment: "Brand-safety tier for premium inventory positioning."
    - name: "inventory_month"
      expr: DATE_TRUNC('MONTH', inventory_date)
      comment: "Inventory month for availability planning."
  measures:
    - name: "inventory_count"
      expr: COUNT(1)
      comment: "Number of inventory units; baseline supply volume."
    - name: "programmatic_eligible_count"
      expr: SUM(CASE WHEN programmatic_eligible_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of programmatic-eligible units; CTV-programmatic supply readiness KPI."
    - name: "total_estimated_impressions"
      expr: SUM(CAST(estimated_impressions AS DOUBLE))
      comment: "Total forecasted impressions; demand-planning capacity metric."
    - name: "avg_floor_price_cpm"
      expr: AVG(CAST(floor_price_cpm AS DOUBLE))
      comment: "Average programmatic floor CPM; pricing-policy yield benchmark."
    - name: "avg_rate_card_cpm"
      expr: AVG(CAST(rate_card_cpm AS DOUBLE))
      comment: "Average rate-card CPM; published-price benchmark for revenue management."
    - name: "total_estimated_grp"
      expr: SUM(CAST(estimated_grp AS DOUBLE))
      comment: "Total estimated gross rating points; linear audience-delivery planning metric."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`advertising_rate_card`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rate-card pricing KPIs for gross/net rate spread, premiums, and yield governance."
  source: "`vibe_media_broadcasting_v1`.`advertising`.`rate_card`"
  dimensions:
    - name: "rate_type"
      expr: rate_type
      comment: "Rate type (fixed, floating) for pricing structure segmentation."
    - name: "inventory_type"
      expr: inventory_type
      comment: "Inventory type covered by the rate card for supply-mix pricing."
    - name: "daypart"
      expr: daypart
      comment: "Daypart for time-of-day yield analysis."
    - name: "geographic_market"
      expr: geographic_market
      comment: "Geographic market for regional pricing strategy."
    - name: "rate_card_status"
      expr: rate_card_status
      comment: "Rate-card status (active, draft, expired) for governance."
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Effective start month for rate-versioning trend analysis."
  measures:
    - name: "rate_card_count"
      expr: COUNT(1)
      comment: "Number of rate-card entries; baseline pricing-rule volume."
    - name: "avg_gross_rate"
      expr: AVG(CAST(gross_rate AS DOUBLE))
      comment: "Average gross rate; published-pricing benchmark for revenue management."
    - name: "avg_net_rate"
      expr: AVG(CAST(net_rate AS DOUBLE))
      comment: "Average net rate; realized-pricing benchmark after discounts."
    - name: "avg_ctv_rate_premium"
      expr: AVG(CAST(ctv_rate_premium AS DOUBLE))
      comment: "Average CTV rate premium; pricing-power KPI for the CTV-programmatic story."
    - name: "avg_programmatic_floor_cpm"
      expr: AVG(CAST(programmatic_floor_cpm AS DOUBLE))
      comment: "Average programmatic floor CPM; yield-protection benchmark for PMP/exchange deals."
    - name: "avg_seasonality_factor"
      expr: AVG(CAST(seasonality_factor AS DOUBLE))
      comment: "Average seasonality factor; demand-driven price-adjustment indicator."
$$;