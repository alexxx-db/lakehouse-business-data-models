-- Metric views for domain: marketing | Business: Ecommerce | Version: 1 | Generated on: 2026-05-04 23:19:28

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`marketing_campaign_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core performance KPIs for marketing campaigns"
  source: "`ecommerce_ecm`.`marketing`.`campaign_performance`"
  dimensions:
    - name: "campaign_id"
      expr: campaign_id
      comment: "Unique identifier of the campaign"
    - name: "channel"
      expr: channel
      comment: "Marketing channel used for the campaign"
    - name: "campaign_performance_status"
      expr: campaign_performance_status
      comment: "Current status of the campaign performance record"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of monetary values"
    - name: "created_timestamp"
      expr: created_timestamp
      comment: "Timestamp when the performance record was created"
  measures:
    - name: "total_spend_amount"
      expr: SUM(CAST(spend_amount AS DOUBLE))
      comment: "Total spend amount for the campaign performance period"
    - name: "total_impressions"
      expr: SUM(CAST(impressions AS DOUBLE))
      comment: "Total number of impressions delivered"
    - name: "total_clicks"
      expr: SUM(CAST(clicks AS DOUBLE))
      comment: "Total number of clicks recorded"
    - name: "total_conversions"
      expr: SUM(CAST(conversions AS DOUBLE))
      comment: "Total number of conversions achieved"
    - name: "total_net_revenue"
      expr: SUM(CAST(net_revenue AS DOUBLE))
      comment: "Total net revenue generated"
    - name: "avg_cpc"
      expr: AVG(CAST(cpc AS DOUBLE))
      comment: "Average cost per click"
    - name: "avg_ctr"
      expr: AVG(CAST(ctr AS DOUBLE))
      comment: "Average click-through rate"
    - name: "avg_cvr"
      expr: AVG(CAST(cvr AS DOUBLE))
      comment: "Average conversion rate"
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of performance records"
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`marketing_campaign_execution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Execution-level financial and performance metrics for campaigns"
  source: "`ecommerce_ecm`.`marketing`.`campaign_execution`"
  dimensions:
    - name: "campaign_name"
      expr: campaign_name
      comment: "Human‑readable name of the campaign"
    - name: "ad_group_id"
      expr: ad_group_id
      comment: "Ad group associated with the execution"
    - name: "channel"
      expr: channel
      comment: "Channel where the execution ran"
    - name: "execution_timestamp"
      expr: execution_timestamp
      comment: "Timestamp of the execution event"
    - name: "device_target"
      expr: device_target
      comment: "Targeted device type"
    - name: "geo_target"
      expr: geo_target
      comment: "Geographic targeting criteria"
    - name: "status"
      expr: campaign_execution_status
      comment: "Execution status"
  measures:
    - name: "total_actual_spend"
      expr: SUM(CAST(actual_spend AS DOUBLE))
      comment: "Total actual spend for the execution"
    - name: "total_impressions"
      expr: SUM(CAST(impressions AS DOUBLE))
      comment: "Total impressions served"
    - name: "total_clicks"
      expr: SUM(CAST(clicks AS DOUBLE))
      comment: "Total clicks generated"
    - name: "total_conversions"
      expr: SUM(CAST(conversions AS DOUBLE))
      comment: "Total conversions recorded"
    - name: "avg_cpc"
      expr: AVG(CAST(cpc AS DOUBLE))
      comment: "Average cost per click across executions"
    - name: "avg_cpm"
      expr: AVG(CAST(cpm AS DOUBLE))
      comment: "Average cost per thousand impressions"
    - name: "avg_roas"
      expr: AVG(CAST(roas AS DOUBLE))
      comment: "Average return on ad spend"
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of execution records"
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`marketing_attribution_touchpoint`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Attribution metrics tying revenue and cost to marketing touchpoints"
  source: "`ecommerce_ecm`.`marketing`.`attribution_touchpoint`"
  dimensions:
    - name: "campaign_id"
      expr: campaign_id
      comment: "Campaign identifier"
    - name: "channel_id"
      expr: channel_id
      comment: "Channel identifier"
    - name: "customer_profile_id"
      expr: customer_profile_id
      comment: "Customer profile linked to the touchpoint"
    - name: "device_type"
      expr: device_type
      comment: "Device type used during interaction"
    - name: "interaction_type"
      expr: interaction_type
      comment: "Type of interaction (click, view, etc.)"
    - name: "conversion_timestamp"
      expr: conversion_timestamp
      comment: "Timestamp of conversion event"
    - name: "country_code"
      expr: country_code
      comment: "Country code of the interaction"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of monetary values"
  measures:
    - name: "total_revenue_attributed"
      expr: SUM(CAST(revenue_attributed AS DOUBLE))
      comment: "Total revenue attributed to touchpoints"
    - name: "total_cost_attributed"
      expr: SUM(CAST(cost_attributed AS DOUBLE))
      comment: "Total cost attributed to touchpoints"
    - name: "avg_attribution_score"
      expr: AVG(CAST(attribution_score AS DOUBLE))
      comment: "Average attribution score across touchpoints"
    - name: "attributed_touchpoints"
      expr: COUNT(DISTINCT CASE WHEN is_attributed THEN attribution_touchpoint_id END)
      comment: "Count of distinct touchpoints that were attributed"
    - name: "converted_touchpoints"
      expr: COUNT(DISTINCT CASE WHEN is_converted THEN attribution_touchpoint_id END)
      comment: "Count of distinct touchpoints that resulted in conversion"
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of attribution touchpoint records"
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`marketing_lead`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lead generation and conversion performance metrics"
  source: "`ecommerce_ecm`.`marketing`.`lead`"
  dimensions:
    - name: "campaign_id"
      expr: campaign_id
      comment: "Campaign that generated the lead"
    - name: "lead_source"
      expr: lead_source
      comment: "Source channel of the lead"
    - name: "lead_status"
      expr: lead_status
      comment: "Current status of the lead"
    - name: "lead_type"
      expr: lead_type
      comment: "Classification of the lead"
    - name: "created_timestamp"
      expr: created_timestamp
      comment: "Timestamp when the lead was created"
  measures:
    - name: "total_estimated_deal_value"
      expr: SUM(CAST(estimated_deal_value AS DOUBLE))
      comment: "Sum of estimated deal values for leads"
    - name: "total_leads"
      expr: COUNT(1)
      comment: "Total number of lead records"
    - name: "converted_leads"
      expr: COUNT(DISTINCT CASE WHEN conversion_flag THEN lead_id END)
      comment: "Count of distinct leads that converted"
    - name: "avg_score"
      expr: AVG(CAST(score AS DOUBLE))
      comment: "Average lead scoring value"
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of lead records"
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`marketing_email_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Email engagement metrics for campaign executions"
  source: "`ecommerce_ecm`.`marketing`.`email_event`"
  dimensions:
    - name: "campaign_execution_id"
      expr: campaign_execution_id
      comment: "Execution identifier for the email campaign"
    - name: "email_client"
      expr: email_client
      comment: "Email client used by the recipient"
    - name: "event_type"
      expr: event_type
      comment: "Type of email event (send, click, etc.)"
    - name: "event_timestamp"
      expr: event_timestamp
      comment: "Timestamp of the email event"
    - name: "is_test"
      expr: is_test
      comment: "Flag indicating if the event is from a test email"
    - name: "language_code"
      expr: language_code
      comment: "Language code of the email content"
  measures:
    - name: "total_events"
      expr: COUNT(1)
      comment: "Total number of email events recorded"
    - name: "bounce_events"
      expr: COUNT(DISTINCT CASE WHEN event_outcome = 'bounce' THEN email_event_id END)
      comment: "Distinct bounce events"
    - name: "open_events"
      expr: COUNT(DISTINCT CASE WHEN event_outcome = 'open' THEN email_event_id END)
      comment: "Distinct open events"
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`marketing_keyword`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Keyword performance and cost metrics"
  source: "`ecommerce_ecm`.`marketing`.`keyword`"
  dimensions:
    - name: "campaign_id"
      expr: campaign_id
      comment: "Campaign associated with the keyword"
    - name: "ad_group_id"
      expr: ad_group_id
      comment: "Ad group containing the keyword"
    - name: "keyword_text"
      expr: keyword_text
      comment: "Text of the keyword"
    - name: "match_type"
      expr: match_type
      comment: "Match type (exact, phrase, broad)"
    - name: "country"
      expr: country
      comment: "Target country for the keyword"
    - name: "language"
      expr: language
      comment: "Language of the keyword"
    - name: "created_timestamp"
      expr: created_timestamp
      comment: "Timestamp when the keyword record was created"
  measures:
    - name: "total_actual_clicks"
      expr: SUM(CAST(actual_clicks AS DOUBLE))
      comment: "Total actual clicks for the keyword"
    - name: "total_actual_impressions"
      expr: SUM(CAST(actual_impressions AS DOUBLE))
      comment: "Total actual impressions for the keyword"
    - name: "total_actual_spend"
      expr: SUM(CAST(actual_spend AS DOUBLE))
      comment: "Total spend associated with the keyword"
    - name: "avg_cpc_bid"
      expr: AVG(CAST(cpc_bid AS DOUBLE))
      comment: "Average CPC bid for the keyword"
    - name: "avg_estimated_cpc"
      expr: AVG(CAST(estimated_cpc AS DOUBLE))
      comment: "Average estimated CPC"
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of keyword records"
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`marketing_seo_page`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SEO performance metrics tied to marketing campaigns"
  source: "`ecommerce_ecm`.`marketing`.`seo_page`"
  dimensions:
    - name: "campaign_id"
      expr: campaign_id
      comment: "Campaign linked to the SEO page"
    - name: "country_target"
      expr: country_target
      comment: "Target country for the SEO page"
    - name: "language"
      expr: language
      comment: "Language of the SEO page"
    - name: "url"
      expr: url
      comment: "URL of the SEO page"
    - name: "created_timestamp"
      expr: created_timestamp
      comment: "Timestamp when the SEO page record was created"
  measures:
    - name: "total_organic_clicks"
      expr: SUM(CAST(organic_clicks AS DOUBLE))
      comment: "Total organic clicks captured"
    - name: "total_organic_impressions"
      expr: SUM(CAST(organic_impressions AS DOUBLE))
      comment: "Total organic impressions captured"
    - name: "avg_ctr"
      expr: AVG(CAST(ctr AS DOUBLE))
      comment: "Average click‑through rate for SEO pages"
    - name: "avg_seo_score"
      expr: AVG(CAST(seo_score AS DOUBLE))
      comment: "Average SEO quality score"
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of SEO page records"
$$;
