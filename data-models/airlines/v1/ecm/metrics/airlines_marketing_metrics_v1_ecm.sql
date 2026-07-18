-- Metric views for domain: marketing | Business: Airlines | Version: 1 | Generated on: 2026-05-07 12:47:29

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`marketing_campaign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core campaign performance metrics tracking budget utilization, campaign lifecycle, and strategic alignment across channels and markets"
  source: "`airlines_ecm`.`marketing`.`campaign`"
  dimensions:
    - name: "campaign_code"
      expr: campaign_code
      comment: "Unique campaign identifier code"
    - name: "campaign_name"
      expr: campaign_name
      comment: "Campaign name for reporting"
    - name: "campaign_type"
      expr: campaign_type
      comment: "Type of campaign (e.g., brand, promotional, seasonal)"
    - name: "campaign_status"
      expr: campaign_status
      comment: "Current campaign status (e.g., planned, active, completed, cancelled)"
    - name: "target_market"
      expr: target_market
      comment: "Geographic or demographic target market"
    - name: "cabin_class_focus"
      expr: cabin_class_focus
      comment: "Targeted cabin class (economy, business, first)"
    - name: "ffp_tier_focus"
      expr: ffp_tier_focus
      comment: "Targeted frequent flyer program tier"
    - name: "owning_team"
      expr: owning_team
      comment: "Team responsible for campaign execution"
    - name: "approval_status"
      expr: approval_status
      comment: "Campaign approval status"
    - name: "iata_season"
      expr: iata_season
      comment: "IATA season code for travel industry seasonality"
    - name: "planned_start_year"
      expr: YEAR(planned_start_date)
      comment: "Year of planned campaign start"
    - name: "planned_start_month"
      expr: DATE_TRUNC('MONTH', planned_start_date)
      comment: "Month of planned campaign start"
    - name: "actual_start_year"
      expr: YEAR(actual_start_date)
      comment: "Year of actual campaign start"
    - name: "actual_start_month"
      expr: DATE_TRUNC('MONTH', actual_start_date)
      comment: "Month of actual campaign start"
  measures:
    - name: "total_campaign_count"
      expr: COUNT(1)
      comment: "Total number of campaigns"
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budgeted amount across all campaigns"
    - name: "avg_budget_per_campaign"
      expr: AVG(CAST(budget_amount AS DOUBLE))
      comment: "Average budget per campaign"
    - name: "distinct_campaign_types"
      expr: COUNT(DISTINCT campaign_type)
      comment: "Number of distinct campaign types"
    - name: "distinct_target_markets"
      expr: COUNT(DISTINCT target_market)
      comment: "Number of distinct target markets"
$$;


CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`marketing_campaign_execution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Campaign execution performance metrics tracking delivery, engagement, conversion, and ROI across channels and audiences"
  source: "`airlines_ecm`.`marketing`.`campaign_execution`"
  dimensions:
    - name: "execution_status"
      expr: execution_status
      comment: "Status of campaign execution (scheduled, in-progress, completed, failed)"
    - name: "channel_type"
      expr: channel_type
      comment: "Type of marketing channel used"
    - name: "deployment_platform"
      expr: deployment_platform
      comment: "Platform used for campaign deployment"
    - name: "ab_test_variant"
      expr: ab_test_variant
      comment: "A/B test variant identifier"
    - name: "scheduled_year"
      expr: YEAR(CAST(scheduled_timestamp AS DATE))
      comment: "Year of scheduled execution"
    - name: "scheduled_month"
      expr: DATE_TRUNC('MONTH', CAST(scheduled_timestamp AS DATE))
      comment: "Month of scheduled execution"
    - name: "actual_start_year"
      expr: YEAR(CAST(actual_start_timestamp AS DATE))
      comment: "Year of actual execution start"
    - name: "actual_start_month"
      expr: DATE_TRUNC('MONTH', CAST(actual_start_timestamp AS DATE))
      comment: "Month of actual execution start"
  measures:
    - name: "total_execution_count"
      expr: COUNT(1)
      comment: "Total number of campaign executions"
    - name: "total_send_volume"
      expr: SUM(CAST(send_volume AS DOUBLE))
      comment: "Total volume of messages/contacts sent"
    - name: "total_contacts_reached"
      expr: SUM(CAST(contacts_reached AS DOUBLE))
      comment: "Total number of contacts successfully reached"
    - name: "total_delivered_count"
      expr: SUM(CAST(delivered_count AS DOUBLE))
      comment: "Total number of messages delivered"
    - name: "total_opened_count"
      expr: SUM(CAST(opened_count AS DOUBLE))
      comment: "Total number of messages opened"
    - name: "total_clicked_count"
      expr: SUM(CAST(clicked_count AS DOUBLE))
      comment: "Total number of clicks"
    - name: "total_converted_count"
      expr: SUM(CAST(converted_count AS DOUBLE))
      comment: "Total number of conversions"
    - name: "total_bounced_count"
      expr: SUM(CAST(bounced_count AS DOUBLE))
      comment: "Total number of bounced messages"
    - name: "total_unsubscribed_count"
      expr: SUM(CAST(unsubscribed_count AS DOUBLE))
      comment: "Total number of unsubscribes"
    - name: "total_execution_cost"
      expr: SUM(CAST(execution_cost_amount AS DOUBLE))
      comment: "Total cost of campaign executions"
    - name: "total_attributed_revenue"
      expr: SUM(CAST(attributed_revenue_amount AS DOUBLE))
      comment: "Total revenue attributed to campaign executions"
    - name: "avg_delivery_rate"
      expr: AVG(CAST(delivery_rate_percent AS DOUBLE))
      comment: "Average delivery rate percentage across executions"
    - name: "avg_open_rate"
      expr: AVG(CAST(open_rate_percent AS DOUBLE))
      comment: "Average open rate percentage across executions"
    - name: "avg_click_through_rate"
      expr: AVG(CAST(click_through_rate_percent AS DOUBLE))
      comment: "Average click-through rate percentage across executions"
    - name: "avg_conversion_rate"
      expr: AVG(CAST(conversion_rate_percent AS DOUBLE))
      comment: "Average conversion rate percentage across executions"
    - name: "avg_bounce_rate"
      expr: AVG(CAST(bounce_rate_percent AS DOUBLE))
      comment: "Average bounce rate percentage across executions"
    - name: "avg_unsubscribe_rate"
      expr: AVG(CAST(unsubscribe_rate_percent AS DOUBLE))
      comment: "Average unsubscribe rate percentage across executions"
$$;


CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`marketing_campaign_response`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Campaign response and conversion metrics tracking customer engagement, attribution, and revenue impact by channel and device"
  source: "`airlines_ecm`.`marketing`.`campaign_response`"
  dimensions:
    - name: "response_type"
      expr: response_type
      comment: "Type of response (click, open, conversion, complaint, unsubscribe)"
    - name: "channel"
      expr: channel
      comment: "Marketing channel through which response occurred"
    - name: "device_type"
      expr: device_type
      comment: "Device type used for response (mobile, desktop, tablet)"
    - name: "browser"
      expr: browser
      comment: "Browser used for response"
    - name: "operating_system"
      expr: operating_system
      comment: "Operating system of device"
    - name: "country_code"
      expr: country_code
      comment: "Country code of responder"
    - name: "city"
      expr: city
      comment: "City of responder"
    - name: "utm_source"
      expr: utm_source
      comment: "UTM source parameter"
    - name: "utm_medium"
      expr: utm_medium
      comment: "UTM medium parameter"
    - name: "utm_campaign"
      expr: utm_campaign
      comment: "UTM campaign parameter"
    - name: "ab_test_variant"
      expr: ab_test_variant
      comment: "A/B test variant identifier"
    - name: "conversion_flag"
      expr: conversion_flag
      comment: "Whether response resulted in conversion"
    - name: "response_year"
      expr: YEAR(CAST(response_timestamp AS DATE))
      comment: "Year of response"
    - name: "response_month"
      expr: DATE_TRUNC('MONTH', CAST(response_timestamp AS DATE))
      comment: "Month of response"
  measures:
    - name: "total_response_count"
      expr: COUNT(1)
      comment: "Total number of campaign responses"
    - name: "total_conversions"
      expr: SUM(CASE WHEN conversion_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Total number of conversions"
    - name: "total_attributed_revenue"
      expr: SUM(CAST(attributed_revenue_amount AS DOUBLE))
      comment: "Total revenue attributed to campaign responses"
    - name: "avg_attributed_revenue_per_response"
      expr: AVG(CAST(attributed_revenue_amount AS DOUBLE))
      comment: "Average attributed revenue per response"
    - name: "avg_engagement_score"
      expr: AVG(CAST(engagement_score AS DOUBLE))
      comment: "Average engagement score across responses"
    - name: "distinct_campaigns"
      expr: COUNT(DISTINCT campaign_execution_id)
      comment: "Number of distinct campaign executions generating responses"
    - name: "distinct_passengers"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of distinct passengers responding"
$$;


CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`marketing_spend`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Marketing spend and budget variance metrics tracking actual vs planned expenditure by campaign, channel, and vendor"
  source: "`airlines_ecm`.`marketing`.`spend`"
  dimensions:
    - name: "spend_type"
      expr: spend_type
      comment: "Type of marketing spend (media, creative, agency, event, etc.)"
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status (pending, paid, overdue)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of spend"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of spend"
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter of spend"
    - name: "fiscal_month"
      expr: fiscal_month
      comment: "Fiscal month of spend"
    - name: "market_region"
      expr: market_region
      comment: "Market region for spend"
    - name: "passenger_segment"
      expr: passenger_segment
      comment: "Passenger segment targeted by spend"
    - name: "route_group"
      expr: route_group
      comment: "Route group targeted by spend"
    - name: "invoice_year"
      expr: YEAR(invoice_date)
      comment: "Year of invoice"
    - name: "invoice_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month of invoice"
  measures:
    - name: "total_spend_count"
      expr: COUNT(1)
      comment: "Total number of spend records"
    - name: "total_actual_spend"
      expr: SUM(CAST(actual_spend_amount AS DOUBLE))
      comment: "Total actual spend amount"
    - name: "total_planned_spend"
      expr: SUM(CAST(planned_spend_amount AS DOUBLE))
      comment: "Total planned spend amount"
    - name: "avg_actual_spend"
      expr: AVG(CAST(actual_spend_amount AS DOUBLE))
      comment: "Average actual spend per record"
    - name: "avg_planned_spend"
      expr: AVG(CAST(planned_spend_amount AS DOUBLE))
      comment: "Average planned spend per record"
    - name: "distinct_campaigns"
      expr: COUNT(DISTINCT campaign_id)
      comment: "Number of distinct campaigns with spend"
    - name: "distinct_channels"
      expr: COUNT(DISTINCT channel_id)
      comment: "Number of distinct channels with spend"
    - name: "distinct_vendors"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of distinct vendors paid"
$$;


CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`marketing_audience_segment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Audience segment size and performance metrics tracking segment health, refresh cadence, and targeting effectiveness"
  source: "`airlines_ecm`.`marketing`.`audience_segment`"
  dimensions:
    - name: "segment_code"
      expr: segment_code
      comment: "Unique segment code"
    - name: "segment_name"
      expr: segment_name
      comment: "Segment name for reporting"
    - name: "segment_type"
      expr: segment_type
      comment: "Type of segment (behavioral, demographic, predictive, etc.)"
    - name: "audience_segment_status"
      expr: audience_segment_status
      comment: "Current status of segment (active, inactive, archived)"
    - name: "derivation_method"
      expr: derivation_method
      comment: "Method used to derive segment (rule-based, ML, manual)"
    - name: "business_objective"
      expr: business_objective
      comment: "Business objective for segment"
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of segment"
    - name: "loyalty_tier_filter"
      expr: loyalty_tier_filter
      comment: "Loyalty tier filter applied to segment"
    - name: "owning_team"
      expr: owning_team
      comment: "Team owning the segment"
    - name: "refresh_frequency"
      expr: refresh_frequency
      comment: "Frequency of segment refresh"
    - name: "gdpr_compliant_flag"
      expr: gdpr_compliant_flag
      comment: "Whether segment is GDPR compliant"
    - name: "consent_required_flag"
      expr: consent_required_flag
      comment: "Whether consent is required for segment use"
    - name: "activation_year"
      expr: YEAR(activation_date)
      comment: "Year of segment activation"
    - name: "activation_month"
      expr: DATE_TRUNC('MONTH', activation_date)
      comment: "Month of segment activation"
  measures:
    - name: "total_segment_count"
      expr: COUNT(1)
      comment: "Total number of audience segments"
    - name: "total_segment_size"
      expr: SUM(CAST(segment_size AS DOUBLE))
      comment: "Total size across all segments (sum of member counts)"
    - name: "avg_segment_size"
      expr: AVG(CAST(segment_size AS DOUBLE))
      comment: "Average segment size"
    - name: "distinct_segment_types"
      expr: COUNT(DISTINCT segment_type)
      comment: "Number of distinct segment types"
    - name: "distinct_owning_teams"
      expr: COUNT(DISTINCT owning_team)
      comment: "Number of distinct teams owning segments"
$$;


CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`marketing_ab_test`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "A/B test performance and statistical significance metrics tracking test outcomes, confidence, and winning variants"
  source: "`airlines_ecm`.`marketing`.`ab_test`"
  dimensions:
    - name: "test_code"
      expr: test_code
      comment: "Unique test code"
    - name: "test_name"
      expr: test_name
      comment: "Test name for reporting"
    - name: "test_type"
      expr: test_type
      comment: "Type of test (A/B, multivariate, etc.)"
    - name: "test_status"
      expr: test_status
      comment: "Current status of test (draft, running, completed, cancelled)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of test"
    - name: "primary_success_metric"
      expr: primary_success_metric
      comment: "Primary metric used to evaluate test success"
    - name: "test_platform"
      expr: test_platform
      comment: "Platform used for test execution"
    - name: "digital_channel"
      expr: digital_channel
      comment: "Digital channel where test is run"
    - name: "target_audience_segment"
      expr: target_audience_segment
      comment: "Audience segment targeted by test"
    - name: "cabin_class_focus"
      expr: cabin_class_focus
      comment: "Cabin class focus of test"
    - name: "ffp_tier_focus"
      expr: ffp_tier_focus
      comment: "FFP tier focus of test"
    - name: "statistical_significance_achieved"
      expr: statistical_significance_achieved
      comment: "Whether test achieved statistical significance"
    - name: "winning_variant"
      expr: winning_variant
      comment: "Winning variant identifier"
    - name: "owning_team"
      expr: owning_team
      comment: "Team owning the test"
    - name: "planned_start_year"
      expr: YEAR(planned_start_date)
      comment: "Year of planned test start"
    - name: "planned_start_month"
      expr: DATE_TRUNC('MONTH', planned_start_date)
      comment: "Month of planned test start"
  measures:
    - name: "total_test_count"
      expr: COUNT(1)
      comment: "Total number of A/B tests"
    - name: "total_significant_tests"
      expr: SUM(CASE WHEN statistical_significance_achieved = TRUE THEN 1 ELSE 0 END)
      comment: "Total number of tests achieving statistical significance"
    - name: "avg_p_value"
      expr: AVG(CAST(p_value AS DOUBLE))
      comment: "Average p-value across tests"
    - name: "avg_minimum_detectable_effect"
      expr: AVG(CAST(minimum_detectable_effect AS DOUBLE))
      comment: "Average minimum detectable effect across tests"
    - name: "avg_statistical_confidence_threshold"
      expr: AVG(CAST(statistical_confidence_threshold AS DOUBLE))
      comment: "Average statistical confidence threshold across tests"
    - name: "distinct_test_platforms"
      expr: COUNT(DISTINCT test_platform)
      comment: "Number of distinct test platforms used"
    - name: "distinct_campaigns"
      expr: COUNT(DISTINCT campaign_id)
      comment: "Number of distinct campaigns with A/B tests"
$$;


CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`marketing_promotional_fare`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Promotional fare performance metrics tracking discount effectiveness, seat utilization, and revenue impact by route and cabin"
  source: "`airlines_ecm`.`marketing`.`promotional_fare`"
  dimensions:
    - name: "promotion_code"
      expr: promotion_code
      comment: "Unique promotion code"
    - name: "promotion_name"
      expr: promotion_name
      comment: "Promotion name for reporting"
    - name: "promotion_type"
      expr: promotion_type
      comment: "Type of promotion (flash sale, seasonal, loyalty, etc.)"
    - name: "promotional_fare_status"
      expr: promotional_fare_status
      comment: "Current status of promotional fare"
    - name: "cabin_class"
      expr: cabin_class
      comment: "Cabin class for promotional fare"
    - name: "booking_class"
      expr: booking_class
      comment: "Booking class for promotional fare"
    - name: "origin_airport_code"
      expr: origin_airport_code
      comment: "Origin airport code"
    - name: "destination_airport_code"
      expr: destination_airport_code
      comment: "Destination airport code"
    - name: "route_scope"
      expr: route_scope
      comment: "Scope of routes covered (domestic, international, regional)"
    - name: "region_code"
      expr: region_code
      comment: "Region code for promotion"
    - name: "ffp_tier_eligibility"
      expr: ffp_tier_eligibility
      comment: "FFP tier eligibility for promotion"
    - name: "refundable_flag"
      expr: refundable_flag
      comment: "Whether fare is refundable"
    - name: "changeable_flag"
      expr: changeable_flag
      comment: "Whether fare is changeable"
    - name: "gds_distribution_flag"
      expr: gds_distribution_flag
      comment: "Whether fare is distributed via GDS"
    - name: "owning_team"
      expr: owning_team
      comment: "Team owning the promotion"
    - name: "booking_window_start_year"
      expr: YEAR(booking_window_start_date)
      comment: "Year of booking window start"
    - name: "booking_window_start_month"
      expr: DATE_TRUNC('MONTH', booking_window_start_date)
      comment: "Month of booking window start"
  measures:
    - name: "total_promotion_count"
      expr: COUNT(1)
      comment: "Total number of promotional fares"
    - name: "total_fare_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total promotional fare amount"
    - name: "avg_fare_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average promotional fare amount"
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage across promotions"
    - name: "avg_change_fee"
      expr: AVG(CAST(change_fee_amount AS DOUBLE))
      comment: "Average change fee amount"
    - name: "avg_mileage_accrual_percentage"
      expr: AVG(CAST(mileage_accrual_percentage AS DOUBLE))
      comment: "Average mileage accrual percentage"
    - name: "distinct_origin_airports"
      expr: COUNT(DISTINCT origin_airport_code)
      comment: "Number of distinct origin airports"
    - name: "distinct_destination_airports"
      expr: COUNT(DISTINCT destination_airport_code)
      comment: "Number of distinct destination airports"
    - name: "distinct_campaigns"
      expr: COUNT(DISTINCT campaign_id)
      comment: "Number of distinct campaigns with promotional fares"
$$;


CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`marketing_survey_response`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer feedback and satisfaction metrics tracking NPS, CSAT, CES scores and sentiment by route, cabin, and loyalty tier"
  source: "`airlines_ecm`.`marketing`.`survey_response`"
  dimensions:
    - name: "nps_category"
      expr: nps_category
      comment: "NPS category (promoter, passive, detractor)"
    - name: "response_channel"
      expr: response_channel
      comment: "Channel through which survey was responded"
    - name: "response_language"
      expr: response_language
      comment: "Language of survey response"
    - name: "cabin_class"
      expr: cabin_class
      comment: "Cabin class of flight surveyed"
    - name: "ffp_tier"
      expr: ffp_tier
      comment: "FFP tier of respondent"
    - name: "origin_airport_code"
      expr: origin_airport_code
      comment: "Origin airport code"
    - name: "destination_airport_code"
      expr: destination_airport_code
      comment: "Destination airport code"
    - name: "route_type"
      expr: route_type
      comment: "Type of route (domestic, international, regional)"
    - name: "sentiment_category"
      expr: sentiment_category
      comment: "Sentiment category (positive, neutral, negative)"
    - name: "device_type"
      expr: device_type
      comment: "Device type used for response"
    - name: "is_verified_passenger"
      expr: is_verified_passenger
      comment: "Whether respondent is verified passenger"
    - name: "incentive_offered"
      expr: incentive_offered
      comment: "Whether incentive was offered for response"
    - name: "service_recovery_triggered"
      expr: service_recovery_triggered
      comment: "Whether response triggered service recovery"
    - name: "flight_year"
      expr: YEAR(flight_date)
      comment: "Year of flight"
    - name: "flight_month"
      expr: DATE_TRUNC('MONTH', flight_date)
      comment: "Month of flight"
    - name: "response_year"
      expr: YEAR(CAST(response_timestamp AS DATE))
      comment: "Year of response"
    - name: "response_month"
      expr: DATE_TRUNC('MONTH', CAST(response_timestamp AS DATE))
      comment: "Month of response"
  measures:
    - name: "total_response_count"
      expr: COUNT(1)
      comment: "Total number of survey responses"
    - name: "total_promoters"
      expr: SUM(CASE WHEN nps_category = 'promoter' THEN 1 ELSE 0 END)
      comment: "Total number of promoters (NPS 9-10)"
    - name: "total_detractors"
      expr: SUM(CASE WHEN nps_category = 'detractor' THEN 1 ELSE 0 END)
      comment: "Total number of detractors (NPS 0-6)"
    - name: "avg_sentiment_score"
      expr: AVG(CAST(sentiment_score AS DOUBLE))
      comment: "Average sentiment score across responses"
    - name: "avg_survey_completion_rate"
      expr: AVG(CAST(survey_completion_rate AS DOUBLE))
      comment: "Average survey completion rate"
    - name: "total_service_recovery_triggered"
      expr: SUM(CASE WHEN service_recovery_triggered = TRUE THEN 1 ELSE 0 END)
      comment: "Total number of responses triggering service recovery"
    - name: "distinct_surveys"
      expr: COUNT(DISTINCT nps_survey_id)
      comment: "Number of distinct surveys with responses"
    - name: "distinct_passengers"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of distinct passengers responding"
    - name: "distinct_flights"
      expr: COUNT(DISTINCT flight_leg_id)
      comment: "Number of distinct flights surveyed"
$$;


CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`marketing_social_media_post`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Social media engagement and reach metrics tracking post performance, sentiment, and audience interaction by platform and content type"
  source: "`airlines_ecm`.`marketing`.`social_media_post`"
  dimensions:
    - name: "platform"
      expr: platform
      comment: "Social media platform (Facebook, Twitter, Instagram, LinkedIn, etc.)"
    - name: "post_type"
      expr: post_type
      comment: "Type of post (image, video, link, text, carousel)"
    - name: "post_status"
      expr: post_status
      comment: "Status of post (draft, scheduled, published, deleted)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of post"
    - name: "language_code"
      expr: language_code
      comment: "Language code of post content"
    - name: "market_region"
      expr: market_region
      comment: "Market region targeted by post"
    - name: "target_audience_segment"
      expr: target_audience_segment
      comment: "Audience segment targeted by post"
    - name: "account_handle"
      expr: account_handle
      comment: "Social media account handle"
    - name: "scheduled_publish_year"
      expr: YEAR(CAST(scheduled_publish_timestamp AS DATE))
      comment: "Year of scheduled publish"
    - name: "scheduled_publish_month"
      expr: DATE_TRUNC('MONTH', CAST(scheduled_publish_timestamp AS DATE))
      comment: "Month of scheduled publish"
    - name: "actual_publish_year"
      expr: YEAR(CAST(actual_publish_timestamp AS DATE))
      comment: "Year of actual publish"
    - name: "actual_publish_month"
      expr: DATE_TRUNC('MONTH', CAST(actual_publish_timestamp AS DATE))
      comment: "Month of actual publish"
  measures:
    - name: "total_post_count"
      expr: COUNT(1)
      comment: "Total number of social media posts"
    - name: "total_impressions"
      expr: SUM(CAST(impressions AS DOUBLE))
      comment: "Total impressions across all posts"
    - name: "total_reach"
      expr: SUM(CAST(reach AS DOUBLE))
      comment: "Total reach across all posts"
    - name: "total_likes"
      expr: SUM(CAST(likes AS DOUBLE))
      comment: "Total likes across all posts"
    - name: "total_comments"
      expr: SUM(CAST(comments AS DOUBLE))
      comment: "Total comments across all posts"
    - name: "total_shares"
      expr: SUM(CAST(shares AS DOUBLE))
      comment: "Total shares across all posts"
    - name: "total_saves"
      expr: SUM(CAST(saves AS DOUBLE))
      comment: "Total saves across all posts"
    - name: "total_link_clicks"
      expr: SUM(CAST(link_clicks AS DOUBLE))
      comment: "Total link clicks across all posts"
    - name: "total_video_views"
      expr: SUM(CAST(video_views AS DOUBLE))
      comment: "Total video views across all posts"
    - name: "total_boosted_spend"
      expr: SUM(CAST(boosted_spend_amount AS DOUBLE))
      comment: "Total spend on boosted posts"
    - name: "avg_engagement_rate"
      expr: AVG(CAST(engagement_rate AS DOUBLE))
      comment: "Average engagement rate across posts"
    - name: "avg_sentiment_score"
      expr: AVG(CAST(sentiment_score AS DOUBLE))
      comment: "Average sentiment score across posts"
    - name: "distinct_platforms"
      expr: COUNT(DISTINCT platform)
      comment: "Number of distinct platforms used"
    - name: "distinct_campaigns"
      expr: COUNT(DISTINCT campaign_id)
      comment: "Number of distinct campaigns with social posts"
$$;


CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`marketing_email_send`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Email campaign delivery and engagement metrics tracking send success, open rates, click behavior, and deliverability by device and client"
  source: "`airlines_ecm`.`marketing`.`email_send`"
  dimensions:
    - name: "delivery_status"
      expr: delivery_status
      comment: "Delivery status (delivered, bounced, failed)"
    - name: "bounce_type"
      expr: bounce_type
      comment: "Type of bounce (hard, soft, technical)"
    - name: "device_type"
      expr: device_type
      comment: "Device type used to open email"
    - name: "email_client"
      expr: email_client
      comment: "Email client used to open email"
    - name: "operating_system"
      expr: operating_system
      comment: "Operating system of device"
    - name: "esp_provider"
      expr: esp_provider
      comment: "Email service provider"
    - name: "open_country_code"
      expr: open_country_code
      comment: "Country code where email was opened"
    - name: "open_city"
      expr: open_city
      comment: "City where email was opened"
    - name: "ab_test_variant"
      expr: ab_test_variant
      comment: "A/B test variant identifier"
    - name: "open_flag"
      expr: open_flag
      comment: "Whether email was opened"
    - name: "click_flag"
      expr: click_flag
      comment: "Whether email was clicked"
    - name: "unsubscribe_flag"
      expr: unsubscribe_flag
      comment: "Whether recipient unsubscribed"
    - name: "spam_complaint_flag"
      expr: spam_complaint_flag
      comment: "Whether recipient marked as spam"
    - name: "personalization_flag"
      expr: personalization_flag
      comment: "Whether email was personalized"
    - name: "send_year"
      expr: YEAR(CAST(send_timestamp AS DATE))
      comment: "Year of email send"
    - name: "send_month"
      expr: DATE_TRUNC('MONTH', CAST(send_timestamp AS DATE))
      comment: "Month of email send"
  measures:
    - name: "total_send_count"
      expr: COUNT(1)
      comment: "Total number of email sends"
    - name: "total_delivered"
      expr: SUM(CASE WHEN delivery_status = 'delivered' THEN 1 ELSE 0 END)
      comment: "Total number of emails delivered"
    - name: "total_opened"
      expr: SUM(CASE WHEN open_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Total number of emails opened"
    - name: "total_clicked"
      expr: SUM(CASE WHEN click_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Total number of emails clicked"
    - name: "total_unsubscribed"
      expr: SUM(CASE WHEN unsubscribe_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Total number of unsubscribes"
    - name: "total_spam_complaints"
      expr: SUM(CASE WHEN spam_complaint_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Total number of spam complaints"
    - name: "distinct_campaigns"
      expr: COUNT(DISTINCT campaign_execution_id)
      comment: "Number of distinct campaign executions"
    - name: "distinct_passengers"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of distinct passengers receiving emails"
    - name: "distinct_creatives"
      expr: COUNT(DISTINCT digital_campaign_creative_id)
      comment: "Number of distinct email creatives used"
$$;
