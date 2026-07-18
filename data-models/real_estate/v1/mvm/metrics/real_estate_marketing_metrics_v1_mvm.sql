-- Metric views for domain: marketing | Business: Real Estate | Version: 1 | Generated on: 2026-05-02 04:45:11

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`marketing_campaign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Campaign performance and budget utilization metrics for strategic marketing investment decisions"
  source: "`real_estate_ecm`.`marketing`.`campaign`"
  dimensions:
    - name: "campaign_name"
      expr: campaign_name
      comment: "Name of the marketing campaign"
    - name: "campaign_type"
      expr: campaign_type
      comment: "Type of campaign (e.g., brand awareness, lead generation, conversion)"
    - name: "campaign_status"
      expr: campaign_status
      comment: "Current status of the campaign (active, paused, completed)"
    - name: "property_type"
      expr: property_type_id
      comment: "Property type targeted by the campaign"
    - name: "transaction_type"
      expr: transaction_type_id
      comment: "Transaction type (sale, lease) targeted by the campaign"
    - name: "campaign_start_year"
      expr: YEAR(planned_start_date)
      comment: "Year the campaign was planned to start"
    - name: "campaign_start_month"
      expr: DATE_TRUNC('MONTH', planned_start_date)
      comment: "Month the campaign was planned to start"
    - name: "esg_aligned"
      expr: esg_aligned_flag
      comment: "Whether the campaign is aligned with ESG principles"
    - name: "fair_housing_compliant"
      expr: fair_housing_compliant_flag
      comment: "Whether the campaign complies with fair housing regulations"
  measures:
    - name: "total_campaigns"
      expr: COUNT(1)
      comment: "Total number of campaigns"
    - name: "total_approved_budget"
      expr: SUM(CAST(approved_budget_amount AS DOUBLE))
      comment: "Total approved budget across campaigns for investment planning"
    - name: "total_spend_to_date"
      expr: SUM(CAST(total_spend_to_date AS DOUBLE))
      comment: "Total actual spend to date across campaigns for budget tracking"
    - name: "avg_campaign_budget"
      expr: AVG(CAST(approved_budget_amount AS DOUBLE))
      comment: "Average approved budget per campaign for benchmarking"
    - name: "budget_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(total_spend_to_date AS DOUBLE)) / NULLIF(SUM(CAST(approved_budget_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of approved budget spent to date - key efficiency metric for marketing ROI"
    - name: "total_target_impressions"
      expr: SUM(CAST(target_impression_count AS DOUBLE))
      comment: "Total target impressions across campaigns for reach planning"
$$;


CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`marketing_campaign_flight`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Campaign flight execution metrics for tactical marketing performance and cost efficiency analysis"
  source: "`real_estate_ecm`.`marketing`.`campaign_flight`"
  dimensions:
    - name: "flight_name"
      expr: flight_name
      comment: "Name of the campaign flight"
    - name: "flight_status"
      expr: flight_status
      comment: "Current status of the flight (scheduled, active, completed, cancelled)"
    - name: "creative_format"
      expr: creative_format
      comment: "Format of the creative used in the flight"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for flight costs"
    - name: "flight_start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the flight started"
    - name: "flight_start_year"
      expr: YEAR(start_date)
      comment: "Year the flight started"
    - name: "property_type"
      expr: property_type_id
      comment: "Property type targeted by the flight"
    - name: "transaction_type"
      expr: transaction_type_id
      comment: "Transaction type targeted by the flight"
    - name: "esg_aligned"
      expr: esg_aligned
      comment: "Whether the flight is ESG-aligned"
    - name: "fair_housing_compliant"
      expr: fair_housing_compliant
      comment: "Whether the flight complies with fair housing regulations"
  measures:
    - name: "total_flights"
      expr: COUNT(1)
      comment: "Total number of campaign flights"
    - name: "total_flight_budget"
      expr: SUM(CAST(flight_budget AS DOUBLE))
      comment: "Total budgeted amount for flights"
    - name: "total_actual_spend"
      expr: SUM(CAST(actual_spend AS DOUBLE))
      comment: "Total actual spend across flights for cost control"
    - name: "total_impressions_delivered"
      expr: SUM(CAST(impressions_delivered AS DOUBLE))
      comment: "Total impressions delivered across flights for reach measurement"
    - name: "total_clicks"
      expr: SUM(CAST(clicks AS DOUBLE))
      comment: "Total clicks generated across flights for engagement measurement"
    - name: "avg_cpm"
      expr: AVG(CAST(cpm_rate AS DOUBLE))
      comment: "Average cost per thousand impressions for media efficiency benchmarking"
    - name: "avg_cpc"
      expr: AVG(CAST(cpc_rate AS DOUBLE))
      comment: "Average cost per click for performance benchmarking"
    - name: "click_through_rate"
      expr: ROUND(100.0 * SUM(CAST(clicks AS DOUBLE)) / NULLIF(SUM(CAST(impressions_delivered AS DOUBLE)), 0), 2)
      comment: "Percentage of impressions that resulted in clicks - key engagement metric"
    - name: "cost_per_impression"
      expr: ROUND(SUM(CAST(actual_spend AS DOUBLE)) / NULLIF(SUM(CAST(impressions_delivered AS DOUBLE)), 0), 4)
      comment: "Actual cost per impression delivered for media efficiency analysis"
    - name: "flight_budget_variance"
      expr: SUM((CAST(flight_budget AS DOUBLE)) - (CAST(actual_spend AS DOUBLE)))
      comment: "Total budget variance (budget minus actual spend) for financial control"
$$;


CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`marketing_lead`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lead generation and conversion metrics for sales pipeline and marketing effectiveness analysis"
  source: "`real_estate_ecm`.`marketing`.`lead`"
  dimensions:
    - name: "lead_status"
      expr: lead_status
      comment: "Current status of the lead in the sales funnel"
    - name: "lead_type"
      expr: lead_type
      comment: "Type of lead (e.g., inbound, outbound, referral)"
    - name: "lead_source"
      expr: lead_source
      comment: "Source of the lead (e.g., website, event, referral)"
    - name: "lead_grade"
      expr: grade
      comment: "Quality grade assigned to the lead"
    - name: "property_type"
      expr: property_type_id
      comment: "Property type the lead is interested in"
    - name: "transaction_type"
      expr: transaction_type_id
      comment: "Transaction type the lead is interested in (sale, lease)"
    - name: "lead_created_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month the lead was created"
    - name: "lead_created_year"
      expr: YEAR(created_timestamp)
      comment: "Year the lead was created"
    - name: "is_duplicate"
      expr: is_duplicate
      comment: "Whether the lead is a duplicate"
    - name: "gdpr_consent"
      expr: gdpr_consent
      comment: "Whether the lead has given GDPR consent"
    - name: "utm_source"
      expr: utm_source
      comment: "UTM source parameter for attribution"
    - name: "utm_medium"
      expr: utm_medium
      comment: "UTM medium parameter for attribution"
    - name: "utm_campaign"
      expr: utm_campaign
      comment: "UTM campaign parameter for attribution"
  measures:
    - name: "total_leads"
      expr: COUNT(1)
      comment: "Total number of leads generated"
    - name: "unique_leads"
      expr: COUNT(DISTINCT lead_id)
      comment: "Count of unique leads excluding duplicates"
    - name: "converted_leads"
      expr: COUNT(DISTINCT CASE WHEN investor_id IS NOT NULL THEN lead_id END)
      comment: "Number of leads that converted to investors"
    - name: "lead_conversion_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN investor_id IS NOT NULL THEN lead_id END) / NULLIF(COUNT(DISTINCT lead_id), 0), 2)
      comment: "Percentage of leads that converted to investors - critical sales effectiveness metric"
    - name: "avg_budget_max"
      expr: AVG(CAST(budget_max AS DOUBLE))
      comment: "Average maximum budget across leads for deal sizing"
    - name: "avg_budget_min"
      expr: AVG(CAST(budget_min AS DOUBLE))
      comment: "Average minimum budget across leads for qualification"
    - name: "total_budget_potential_max"
      expr: SUM(CAST(budget_max AS DOUBLE))
      comment: "Total maximum budget potential across all leads for pipeline value estimation"
$$;


CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`marketing_lead_activity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lead engagement and activity metrics for nurture effectiveness and conversion funnel analysis"
  source: "`real_estate_ecm`.`marketing`.`lead_activity`"
  dimensions:
    - name: "activity_type"
      expr: activity_type
      comment: "Type of lead activity (email, call, form, page view, etc.)"
    - name: "activity_status"
      expr: activity_status
      comment: "Status of the activity (completed, scheduled, cancelled)"
    - name: "activity_direction"
      expr: activity_direction
      comment: "Direction of activity (inbound, outbound)"
    - name: "funnel_stage"
      expr: funnel_stage
      comment: "Funnel stage at time of activity"
    - name: "is_conversion_event"
      expr: is_conversion_event
      comment: "Whether the activity was a conversion event"
    - name: "conversion_type"
      expr: conversion_type
      comment: "Type of conversion if applicable"
    - name: "activity_month"
      expr: DATE_TRUNC('MONTH', activity_timestamp)
      comment: "Month the activity occurred"
    - name: "activity_year"
      expr: YEAR(activity_timestamp)
      comment: "Year the activity occurred"
    - name: "device_type"
      expr: device_type
      comment: "Device type used for the activity"
    - name: "content_type"
      expr: content_type
      comment: "Type of content engaged with"
    - name: "utm_source"
      expr: utm_source
      comment: "UTM source for attribution"
    - name: "utm_medium"
      expr: utm_medium
      comment: "UTM medium for attribution"
    - name: "utm_campaign"
      expr: utm_campaign
      comment: "UTM campaign for attribution"
  measures:
    - name: "total_activities"
      expr: COUNT(1)
      comment: "Total number of lead activities"
    - name: "unique_leads_engaged"
      expr: COUNT(DISTINCT lead_id)
      comment: "Number of unique leads with activity"
    - name: "conversion_events"
      expr: COUNT(CASE WHEN is_conversion_event = TRUE THEN 1 END)
      comment: "Number of conversion events for funnel analysis"
    - name: "conversion_event_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_conversion_event = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of activities that are conversion events - key funnel efficiency metric"
    - name: "total_attribution_weight"
      expr: SUM(CAST(attribution_weight AS DOUBLE))
      comment: "Total attribution weight across activities for multi-touch attribution modeling"
    - name: "avg_attribution_weight"
      expr: AVG(CAST(attribution_weight AS DOUBLE))
      comment: "Average attribution weight per activity"
$$;


CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`marketing_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Marketing event performance and ROI metrics for event marketing investment decisions"
  source: "`real_estate_ecm`.`marketing`.`event`"
  dimensions:
    - name: "event_name"
      expr: event_name
      comment: "Name of the marketing event"
    - name: "event_type"
      expr: event_type
      comment: "Type of event (open house, investor meeting, webinar, etc.)"
    - name: "event_status"
      expr: event_status
      comment: "Current status of the event"
    - name: "is_virtual"
      expr: is_virtual
      comment: "Whether the event is virtual"
    - name: "is_public"
      expr: is_public
      comment: "Whether the event is open to the public"
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', event_date)
      comment: "Month the event occurred"
    - name: "event_year"
      expr: YEAR(event_date)
      comment: "Year the event occurred"
    - name: "property_type"
      expr: property_type_id
      comment: "Property type featured at the event"
    - name: "transaction_type"
      expr: transaction_type_id
      comment: "Transaction type targeted by the event"
    - name: "requires_registration"
      expr: requires_registration
      comment: "Whether the event requires registration"
  measures:
    - name: "total_events"
      expr: COUNT(1)
      comment: "Total number of marketing events"
    - name: "total_budgeted_cost"
      expr: SUM(CAST(budgeted_cost AS DOUBLE))
      comment: "Total budgeted cost for events"
    - name: "total_actual_event_cost"
      expr: SUM(CAST(total_event_cost AS DOUBLE))
      comment: "Total actual cost incurred for events"
    - name: "avg_event_cost"
      expr: AVG(CAST(total_event_cost AS DOUBLE))
      comment: "Average cost per event for benchmarking"
    - name: "event_cost_variance"
      expr: SUM((CAST(budgeted_cost AS DOUBLE)) - (CAST(total_event_cost AS DOUBLE)))
      comment: "Total cost variance (budget minus actual) for financial control"
    - name: "event_cost_efficiency_rate"
      expr: ROUND(100.0 * SUM(CAST(total_event_cost AS DOUBLE)) / NULLIF(SUM(CAST(budgeted_cost AS DOUBLE)), 0), 2)
      comment: "Percentage of budgeted cost actually spent - event cost control metric"
$$;


CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`marketing_listing_syndication`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Listing syndication performance and reach metrics for digital marketing channel optimization"
  source: "`real_estate_ecm`.`marketing`.`listing_syndication`"
  dimensions:
    - name: "platform_name"
      expr: platform_name
      comment: "Name of the syndication platform (Zillow, Trulia, etc.)"
    - name: "syndication_status"
      expr: syndication_status
      comment: "Current status of the syndication"
    - name: "feed_type"
      expr: feed_type
      comment: "Type of data feed used for syndication"
    - name: "property_type"
      expr: property_type_id
      comment: "Property type being syndicated"
    - name: "transaction_type"
      expr: transaction_type_id
      comment: "Transaction type (sale, lease) being syndicated"
    - name: "featured_listing"
      expr: featured_listing
      comment: "Whether the listing is featured on the platform"
    - name: "paid_placement"
      expr: paid_placement
      comment: "Whether the placement is paid"
    - name: "publish_month"
      expr: DATE_TRUNC('MONTH', publish_date)
      comment: "Month the listing was published"
    - name: "publish_year"
      expr: YEAR(publish_date)
      comment: "Year the listing was published"
    - name: "fair_housing_compliant"
      expr: fair_housing_compliant
      comment: "Whether the syndication is fair housing compliant"
    - name: "compliance_verified"
      expr: compliance_verified
      comment: "Whether compliance has been verified"
  measures:
    - name: "total_syndications"
      expr: COUNT(1)
      comment: "Total number of listing syndications"
    - name: "total_impressions"
      expr: SUM(CAST(impression_count AS DOUBLE))
      comment: "Total impressions across all syndicated listings for reach measurement"
    - name: "total_clicks"
      expr: SUM(CAST(click_count AS DOUBLE))
      comment: "Total clicks on syndicated listings for engagement measurement"
    - name: "avg_impressions_per_listing"
      expr: AVG(CAST(impression_count AS DOUBLE))
      comment: "Average impressions per syndicated listing"
    - name: "avg_clicks_per_listing"
      expr: AVG(CAST(click_count AS DOUBLE))
      comment: "Average clicks per syndicated listing"
    - name: "syndication_click_through_rate"
      expr: ROUND(100.0 * SUM(CAST(click_count AS DOUBLE)) / NULLIF(SUM(CAST(impression_count AS DOUBLE)), 0), 2)
      comment: "Percentage of impressions that resulted in clicks - key syndication effectiveness metric"
    - name: "total_placement_cost"
      expr: SUM(CAST(placement_cost AS DOUBLE))
      comment: "Total cost of paid placements for ROI analysis"
    - name: "cost_per_click"
      expr: ROUND(SUM(CAST(placement_cost AS DOUBLE)) / NULLIF(SUM(CAST(click_count AS DOUBLE)), 0), 2)
      comment: "Average cost per click for paid syndication efficiency"
    - name: "cost_per_impression"
      expr: ROUND(SUM(CAST(placement_cost AS DOUBLE)) / NULLIF(SUM(CAST(impression_count AS DOUBLE)), 0), 4)
      comment: "Average cost per impression for media efficiency analysis"
    - name: "avg_asking_price"
      expr: AVG(CAST(asking_price AS DOUBLE))
      comment: "Average asking price across syndicated listings"
    - name: "avg_asking_rent_psf"
      expr: AVG(CAST(asking_rent_psf AS DOUBLE))
      comment: "Average asking rent per square foot across syndicated listings"
$$;


CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`marketing_market_survey`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Market intelligence and competitive positioning metrics for strategic pricing and positioning decisions"
  source: "`real_estate_ecm`.`marketing`.`market_survey`"
  dimensions:
    - name: "survey_type"
      expr: survey_type
      comment: "Type of market survey conducted"
    - name: "survey_status"
      expr: survey_status
      comment: "Current status of the survey"
    - name: "property_type"
      expr: property_type_id
      comment: "Property type surveyed"
    - name: "lease_type"
      expr: lease_type_id
      comment: "Lease type surveyed"
    - name: "survey_period_type"
      expr: survey_period_type
      comment: "Period type of the survey (monthly, quarterly, annual)"
    - name: "survey_month"
      expr: DATE_TRUNC('MONTH', survey_date)
      comment: "Month the survey was conducted"
    - name: "survey_year"
      expr: YEAR(survey_date)
      comment: "Year the survey was conducted"
    - name: "metro_area"
      expr: metro_area
      comment: "Metropolitan area surveyed"
    - name: "state_code"
      expr: state_code
      comment: "State code of surveyed area"
    - name: "rent_basis"
      expr: rent_basis
      comment: "Basis for rent calculation (gross, net, modified gross)"
  measures:
    - name: "total_surveys"
      expr: COUNT(1)
      comment: "Total number of market surveys"
    - name: "avg_vacancy_rate"
      expr: AVG(CAST(vacancy_rate AS DOUBLE))
      comment: "Average vacancy rate across surveys for market health assessment"
    - name: "avg_availability_rate"
      expr: AVG(CAST(availability_rate AS DOUBLE))
      comment: "Average availability rate across surveys"
    - name: "avg_asking_rent_psf"
      expr: AVG(CAST(avg_asking_rent_psf AS DOUBLE))
      comment: "Average asking rent per square foot for pricing benchmarking"
    - name: "avg_effective_rent_psf"
      expr: AVG(CAST(avg_effective_rent_psf AS DOUBLE))
      comment: "Average effective rent per square foot after concessions for true pricing analysis"
    - name: "avg_cap_rate"
      expr: AVG(CAST(cap_rate AS DOUBLE))
      comment: "Average capitalization rate for investment yield benchmarking"
    - name: "total_inventory_sqft"
      expr: SUM(CAST(total_inventory_sqft AS DOUBLE))
      comment: "Total inventory square footage surveyed for market size assessment"
    - name: "total_net_absorption_sqft"
      expr: SUM(CAST(net_absorption_sqft AS DOUBLE))
      comment: "Total net absorption for demand trend analysis"
    - name: "total_new_supply_sqft"
      expr: SUM(CAST(new_supply_sqft AS DOUBLE))
      comment: "Total new supply for supply trend analysis"
    - name: "total_under_construction_sqft"
      expr: SUM(CAST(under_construction_sqft AS DOUBLE))
      comment: "Total square footage under construction for future supply forecasting"
    - name: "avg_concession_value_psf"
      expr: AVG(CAST(avg_concession_value_psf AS DOUBLE))
      comment: "Average concession value per square foot for negotiation leverage analysis"
    - name: "avg_ti_allowance_psf"
      expr: AVG(CAST(avg_ti_allowance_psf AS DOUBLE))
      comment: "Average tenant improvement allowance per square foot for deal structuring"
    - name: "avg_free_rent_months"
      expr: AVG(CAST(avg_free_rent_months AS DOUBLE))
      comment: "Average free rent months offered for market incentive benchmarking"
    - name: "avg_lease_term_months"
      expr: AVG(CAST(avg_lease_term_months AS DOUBLE))
      comment: "Average lease term in months for market norm analysis"
    - name: "rent_concession_rate"
      expr: ROUND(100.0 * AVG(CAST(avg_concession_value_psf AS DOUBLE)) / NULLIF(AVG(CAST(avg_asking_rent_psf AS DOUBLE)), 0), 2)
      comment: "Percentage of asking rent given as concessions - key market competitiveness indicator"
$$;
