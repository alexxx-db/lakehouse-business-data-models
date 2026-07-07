-- Metric views for domain: marketing | Business: Travel Hospitality | Version: 2 | Generated on: 2026-06-28 00:14:33

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`marketing_attribution_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Marketing attribution and conversion analytics. Measures touchpoint effectiveness, conversion rates, and attributed revenue to optimize channel mix and campaign investment allocation."
  source: "`vibe_travel_hospitality_v1`.`marketing`.`attribution_event`"
  dimensions:
    - name: "attribution_model"
      expr: attribution_model
      comment: "Attribution model used (last-click, first-click, linear, data-driven) for model comparison analysis."
    - name: "touchpoint_type"
      expr: touchpoint_type
      comment: "Type of marketing touchpoint (ad impression, email open, click) for touchpoint effectiveness analysis."
    - name: "channel"
      expr: channel
      comment: "Marketing channel of the attribution event for channel-level conversion and revenue attribution."
    - name: "device_type"
      expr: device_type
      comment: "Device type (mobile, desktop, tablet) for device-level conversion optimization."
    - name: "geo_country_code"
      expr: geo_country_code
      comment: "Country of the attribution event for geographic performance analysis."
    - name: "utm_medium"
      expr: utm_medium
      comment: "UTM medium parameter for paid vs. organic channel attribution analysis."
    - name: "utm_source"
      expr: utm_source
      comment: "UTM source parameter for source-level attribution and traffic quality analysis."
    - name: "utm_campaign"
      expr: utm_campaign
      comment: "UTM campaign tag for campaign-level attribution tracking."
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', event_timestamp)
      comment: "Month of the attribution event for trend analysis of conversion performance over time."
    - name: "conversion_flag"
      expr: conversion_flag
      comment: "Whether the touchpoint resulted in a conversion. Used to filter conversion vs. non-conversion events."
    - name: "ad_platform"
      expr: ad_platform
      comment: "Advertising platform (Google, Meta, programmatic) for platform-level ROI comparison."
  measures:
    - name: "total_attribution_credit"
      expr: SUM(CAST(attribution_credit AS DOUBLE))
      comment: "Total attribution credit assigned across touchpoints. Measures how revenue credit is distributed across the marketing funnel."
    - name: "total_conversion_value"
      expr: SUM(CAST(conversion_value AS DOUBLE))
      comment: "Total monetary value of conversions attributed to marketing touchpoints. Primary revenue attribution KPI."
    - name: "avg_time_to_conversion_hours"
      expr: AVG(CAST(time_to_conversion_hours AS DOUBLE))
      comment: "Average hours from first touchpoint to conversion. Measures funnel velocity and informs retargeting window decisions."
    - name: "conversion_event_count"
      expr: COUNT(CASE WHEN conversion_flag = TRUE THEN attribution_event_id END)
      comment: "Total number of converting touchpoint events. Core conversion volume KPI for campaign effectiveness."
    - name: "total_touchpoint_count"
      expr: COUNT(1)
      comment: "Total number of attribution touchpoints recorded. Measures marketing reach and funnel activity volume."
    - name: "distinct_converting_profiles"
      expr: COUNT(DISTINCT CASE WHEN conversion_flag = TRUE THEN profile_id END)
      comment: "Number of distinct guest profiles that converted. Measures unique customer acquisition from marketing activity."
    - name: "avg_conversion_value"
      expr: AVG(CAST(conversion_value AS DOUBLE))
      comment: "Average conversion value per converting event. Benchmarks revenue quality per conversion for channel mix optimization."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`marketing_campaign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Campaign financial performance and budget management metrics. Tracks spend efficiency, budget utilization, and variance across campaigns to steer marketing investment decisions."
  source: "`vibe_travel_hospitality_v1`.`marketing`.`campaign`"
  dimensions:
    - name: "campaign_type"
      expr: campaign_type
      comment: "Type of marketing campaign (e.g., email, paid search, display) for performance segmentation."
    - name: "campaign_status"
      expr: campaign_status
      comment: "Current lifecycle status of the campaign (active, completed, paused) for operational filtering."
    - name: "brand_scope"
      expr: brand_scope
      comment: "Brand(s) targeted by the campaign, enabling brand-level budget and performance analysis."
    - name: "property_scope"
      expr: property_scope
      comment: "Property scope of the campaign for property-level marketing investment analysis."
    - name: "target_segment"
      expr: target_segment
      comment: "Guest segment targeted by the campaign for segment-level ROI analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the campaign budget for governance and compliance tracking."
    - name: "budget_period"
      expr: budget_period
      comment: "Budget period (e.g., Q1 2024) for time-based budget cycle analysis."
    - name: "campaign_start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the campaign started, for trend analysis of campaign launches over time."
    - name: "objective"
      expr: objective
      comment: "Strategic objective of the campaign (e.g., acquisition, retention, upsell) for objective-based performance grouping."
  measures:
    - name: "total_campaign_budget"
      expr: SUM(CAST(total_budget_amount AS DOUBLE))
      comment: "Total approved marketing budget across campaigns. Core financial planning KPI for CMO and finance review."
    - name: "total_actual_spend"
      expr: SUM(CAST(actual_spend_amount AS DOUBLE))
      comment: "Total actual marketing spend incurred. Compared against budget to assess spend execution."
    - name: "total_committed_spend"
      expr: SUM(CAST(committed_spend_amount AS DOUBLE))
      comment: "Total committed (obligated but not yet invoiced) spend. Critical for cash flow and budget forecasting."
    - name: "total_remaining_budget"
      expr: SUM(CAST(remaining_budget_amount AS DOUBLE))
      comment: "Total remaining unspent budget across campaigns. Indicates available marketing investment capacity."
    - name: "total_budget_variance"
      expr: SUM(CAST(budget_variance_amount AS DOUBLE))
      comment: "Total variance between planned and actual spend. Negative variance signals overspend requiring executive intervention."
    - name: "total_email_budget"
      expr: SUM(CAST(email_budget_amount AS DOUBLE))
      comment: "Total budget allocated to email channel campaigns. Supports channel mix optimization decisions."
    - name: "total_paid_search_budget"
      expr: SUM(CAST(paid_search_budget_amount AS DOUBLE))
      comment: "Total budget allocated to paid search campaigns. Key input for digital acquisition investment decisions."
    - name: "total_social_budget"
      expr: SUM(CAST(social_budget_amount AS DOUBLE))
      comment: "Total budget allocated to social media campaigns. Supports social channel investment decisions."
    - name: "total_display_budget"
      expr: SUM(CAST(display_budget_amount AS DOUBLE))
      comment: "Total budget allocated to display advertising campaigns. Supports programmatic investment decisions."
    - name: "active_campaign_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN campaign_id END)
      comment: "Number of currently active campaigns. Operational KPI for marketing capacity and workload management."
    - name: "avg_campaign_budget"
      expr: AVG(CAST(total_budget_amount AS DOUBLE))
      comment: "Average budget per campaign. Benchmarks investment level per campaign initiative for portfolio planning."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`marketing_campaign_execution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Campaign execution performance metrics covering delivery, engagement, conversion, and cost efficiency. The primary operational KPI layer for marketing channel performance and ROI measurement."
  source: "`vibe_travel_hospitality_v1`.`marketing`.`campaign_execution`"
  dimensions:
    - name: "channel"
      expr: channel
      comment: "Marketing delivery channel (email, SMS, push, display) for channel-level performance analysis."
    - name: "channel_category"
      expr: channel_category
      comment: "Broader channel category grouping for portfolio-level channel mix analysis."
    - name: "execution_status"
      expr: execution_status
      comment: "Current status of the execution (sent, completed, failed) for operational monitoring."
    - name: "channel_cost_model"
      expr: channel_cost_model
      comment: "Cost model for the channel (CPM, CPC, CPA) for cost efficiency benchmarking."
    - name: "spend_category"
      expr: spend_category
      comment: "Spend category classification for budget allocation and cost center reporting."
    - name: "attribution_model_type"
      expr: attribution_model_type
      comment: "Attribution model applied (last-click, first-click, linear) for revenue attribution analysis."
    - name: "execution_month"
      expr: DATE_TRUNC('MONTH', execution_timestamp)
      comment: "Month of campaign execution for trend analysis of marketing activity over time."
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of the execution invoice for financial reconciliation tracking."
  measures:
    - name: "total_execution_cost"
      expr: SUM(CAST(execution_cost AS DOUBLE))
      comment: "Total cost incurred across all campaign executions. Primary marketing spend KPI for budget vs. actuals reporting."
    - name: "total_revenue_attributed"
      expr: SUM(CAST(revenue_attributed AS DOUBLE))
      comment: "Total revenue attributed to campaign executions. Core ROI numerator for marketing effectiveness measurement."
    - name: "avg_execution_cost"
      expr: AVG(CAST(execution_cost AS DOUBLE))
      comment: "Average cost per campaign execution. Benchmarks execution efficiency across channels and campaigns."
    - name: "avg_revenue_attributed"
      expr: AVG(CAST(revenue_attributed AS DOUBLE))
      comment: "Average revenue attributed per execution. Indicates revenue productivity per marketing activation."
    - name: "execution_count"
      expr: COUNT(1)
      comment: "Total number of campaign executions. Measures marketing activity volume for capacity and throughput analysis."
    - name: "distinct_campaign_count"
      expr: COUNT(DISTINCT campaign_id)
      comment: "Number of distinct campaigns with executions. Measures breadth of active marketing program."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`marketing_campaign_offer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Campaign offer economics and configuration metrics. Tracks offer discount depth, bonus points structures, and booking window parameters to optimize promotional offer design and yield management."
  source: "`vibe_travel_hospitality_v1`.`marketing`.`campaign_offer`"
  dimensions:
    - name: "offer_type"
      expr: offer_type
      comment: "Type of offer (rate discount, bonus points, complimentary upgrade) for offer category performance analysis."
    - name: "offer_status"
      expr: offer_status
      comment: "Current status of the offer (active, expired, draft) for offer portfolio management."
    - name: "discount_type"
      expr: discount_type
      comment: "Discount mechanism (percentage, flat amount, points multiplier) for offer structure analysis."
    - name: "member_exclusive_flag"
      expr: member_exclusive_flag
      comment: "Whether the offer is exclusive to loyalty members. Measures loyalty program offer value proposition."
    - name: "enrollment_required_flag"
      expr: enrollment_required_flag
      comment: "Whether enrollment is required to access the offer. Tracks enrollment-driving offer strategy."
    - name: "valid_from_month"
      expr: DATE_TRUNC('MONTH', valid_from_date)
      comment: "Month the offer becomes valid for seasonal offer portfolio analysis."
  measures:
    - name: "avg_discount_value"
      expr: AVG(CAST(discount_value AS DOUBLE))
      comment: "Average discount value per offer. Benchmarks offer generosity and informs promotional pricing strategy."
    - name: "total_discount_value"
      expr: SUM(CAST(discount_value AS DOUBLE))
      comment: "Total discount value across all offers. Measures aggregate promotional liability and margin exposure."
    - name: "avg_bonus_points_multiplier"
      expr: AVG(CAST(bonus_points_multiplier AS DOUBLE))
      comment: "Average bonus points multiplier across offers. Measures loyalty currency generosity in promotional offers."
    - name: "avg_tier_credit_multiplier"
      expr: AVG(CAST(tier_credit_multiplier AS DOUBLE))
      comment: "Average tier credit multiplier across offers. Measures tier acceleration generosity in promotional campaigns."
    - name: "avg_minimum_spend"
      expr: AVG(CAST(minimum_spend_amount AS DOUBLE))
      comment: "Average minimum spend threshold per offer. Informs offer qualification design and revenue floor setting."
    - name: "active_offer_count"
      expr: COUNT(CASE WHEN offer_status = 'active' THEN campaign_offer_id END)
      comment: "Number of currently active offers. Measures promotional offer portfolio depth for campaign planning."
    - name: "member_exclusive_offer_count"
      expr: COUNT(CASE WHEN member_exclusive_flag = TRUE THEN campaign_offer_id END)
      comment: "Number of member-exclusive offers. Measures loyalty program offer differentiation strategy."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`marketing_campaign_treatment_promotion`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Campaign Treatment Promotion business metrics"
  source: "`travel_hospitality_ecm`.`marketing`.`campaign_treatment_promotion`"
  dimensions:
    - name: "Booking Count"
      expr: booking_count
    - name: "Campaign End Date"
      expr: campaign_end_date
    - name: "Campaign Start Date"
      expr: campaign_start_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Featured Position"
      expr: featured_position
    - name: "Promo Code"
      expr: promo_code
    - name: "Promotion Status"
      expr: promotion_status
    - name: "Campaign End Date Month"
      expr: DATE_TRUNC('MONTH', campaign_end_date)
    - name: "Campaign Start Date Month"
      expr: DATE_TRUNC('MONTH', campaign_start_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Campaign Treatment Promotion"
      expr: COUNT(DISTINCT campaign_treatment_promotion_id)
    - name: "Total Discount Percentage"
      expr: SUM(discount_percentage)
    - name: "Average Discount Percentage"
      expr: AVG(discount_percentage)
    - name: "Total Promotional Price"
      expr: SUM(promotional_price)
    - name: "Average Promotional Price"
      expr: AVG(promotional_price)
    - name: "Total Revenue Generated"
      expr: SUM(revenue_generated)
    - name: "Average Revenue Generated"
      expr: AVG(revenue_generated)
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`marketing_communication_template`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Communication Template business metrics"
  source: "`travel_hospitality_ecm`.`marketing`.`communication_template`"
  dimensions:
    - name: "A B Test Enabled"
      expr: a_b_test_enabled
    - name: "A B Test Variant"
      expr: a_b_test_variant
    - name: "Approved By"
      expr: approved_by
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Body Content"
      expr: body_content
    - name: "Call To Action Text"
      expr: call_to_action_text
    - name: "Call To Action Url"
      expr: call_to_action_url
    - name: "Compliance Approved"
      expr: compliance_approved
    - name: "Compliance Notes"
      expr: compliance_notes
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Description"
      expr: description
    - name: "Design Version"
      expr: design_version
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Footer Text"
      expr: footer_text
    - name: "Html Content"
      expr: html_content
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Communication Template"
      expr: COUNT(DISTINCT communication_template_id)
    - name: "Total Usage Count"
      expr: SUM(usage_count)
    - name: "Average Usage Count"
      expr: AVG(usage_count)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`marketing_consent`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Marketing consent and preference management metrics. Tracks opt-in rates, consent health, and compliance posture across guest communication programs. Critical for GDPR/CCPA compliance and addressable audience sizing."
  source: "`vibe_travel_hospitality_v1`.`marketing`.`consent`"
  dimensions:
    - name: "consent_type"
      expr: consent_type
      comment: "Type of consent (email marketing, SMS, data processing) for consent category compliance tracking."
    - name: "consent_status"
      expr: consent_status
      comment: "Current consent status (active, withdrawn, expired) for addressable audience sizing."
    - name: "legal_basis"
      expr: legal_basis
      comment: "Legal basis for data processing (consent, legitimate interest, contract) for regulatory compliance reporting."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Regulatory jurisdiction (EU, US, APAC) for jurisdiction-level compliance monitoring."
    - name: "is_active"
      expr: is_active
      comment: "Whether the consent record is currently active. Used to size the addressable marketing audience."
    - name: "double_opt_in_confirmed"
      expr: double_opt_in_confirmed
      comment: "Whether double opt-in was confirmed. Measures consent quality and deliverability compliance."
    - name: "consent_month"
      expr: DATE_TRUNC('MONTH', consent_date)
      comment: "Month consent was granted for trend analysis of opt-in growth and churn."
  measures:
    - name: "active_consent_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN consent_id END)
      comment: "Number of active consents. Defines the addressable marketing audience size for campaign planning."
    - name: "total_consent_records"
      expr: COUNT(1)
      comment: "Total consent records across all statuses. Measures consent database size for compliance audit purposes."
    - name: "double_opt_in_confirmed_count"
      expr: COUNT(CASE WHEN double_opt_in_confirmed = TRUE THEN consent_id END)
      comment: "Number of consents with confirmed double opt-in. Measures high-quality consent coverage for deliverability and compliance."
    - name: "distinct_consenting_guests"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of distinct guest profiles with consent records. Measures consent program reach across the guest database."
    - name: "minor_consent_required_count"
      expr: COUNT(CASE WHEN minor_consent_required = TRUE THEN consent_id END)
      comment: "Number of consent records requiring parental/minor consent. Tracks compliance exposure for underage data processing."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`marketing_content_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Content Asset business metrics"
  source: "`travel_hospitality_ecm`.`marketing`.`content_asset`"
  dimensions:
    - name: "Alt Text"
      expr: alt_text
    - name: "Approval Date"
      expr: approval_date
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved By"
      expr: approved_by
    - name: "Asset Code"
      expr: asset_code
    - name: "Asset Name"
      expr: asset_name
    - name: "Asset Type"
      expr: asset_type
    - name: "Content Asset Description"
      expr: content_asset_description
    - name: "Content Theme"
      expr: content_theme
    - name: "Copyright Holder"
      expr: copyright_holder
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Creator Name"
      expr: creator_name
    - name: "Download Count"
      expr: download_count
    - name: "File Format"
      expr: file_format
    - name: "File Url"
      expr: file_url
    - name: "Is Active"
      expr: is_active
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Content Asset"
      expr: COUNT(DISTINCT content_asset_id)
    - name: "Total File Size Kb"
      expr: SUM(file_size_kb)
    - name: "Average File Size Kb"
      expr: AVG(file_size_kb)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`marketing_experiment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Marketing experimentation and A/B test performance metrics. Tracks test outcomes, statistical significance, and estimated business impact to guide data-driven marketing decisions."
  source: "`vibe_travel_hospitality_v1`.`marketing`.`experiment`"
  dimensions:
    - name: "experiment_type"
      expr: experiment_type
      comment: "Type of experiment (A/B test, multivariate, holdout) for experiment methodology analysis."
    - name: "experiment_status"
      expr: experiment_status
      comment: "Current status of the experiment (running, completed, stopped) for experiment pipeline management."
    - name: "channel"
      expr: channel
      comment: "Marketing channel being tested for channel-level experimentation analysis."
    - name: "primary_metric"
      expr: primary_metric
      comment: "Primary success metric of the experiment (conversion rate, revenue, NPS) for outcome-based grouping."
    - name: "winning_variant"
      expr: winning_variant
      comment: "Winning variant of the experiment for implementation tracking and learning capture."
    - name: "implementation_flag"
      expr: implementation_flag
      comment: "Whether the winning variant has been implemented. Tracks experiment-to-implementation conversion rate."
    - name: "experiment_start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the experiment started for trend analysis of experimentation cadence."
  measures:
    - name: "total_estimated_annual_impact"
      expr: SUM(CAST(estimated_annual_impact_amount AS DOUBLE))
      comment: "Total estimated annual revenue impact from experiments. Quantifies the business value of the experimentation program for executive investment decisions."
    - name: "avg_estimated_annual_impact"
      expr: AVG(CAST(estimated_annual_impact_amount AS DOUBLE))
      comment: "Average estimated annual impact per experiment. Benchmarks experiment value and prioritizes test roadmap."
    - name: "avg_lift_percentage"
      expr: AVG(CAST(lift_percentage AS DOUBLE))
      comment: "Average percentage lift achieved by winning variants. Measures experimentation program effectiveness and optimization velocity."
    - name: "avg_confidence_level"
      expr: AVG(CAST(confidence_level_percentage AS DOUBLE))
      comment: "Average statistical confidence level across experiments. Ensures decision quality and guards against false positives."
    - name: "total_experiment_count"
      expr: COUNT(1)
      comment: "Total number of experiments run. Measures experimentation program cadence and innovation velocity."
    - name: "implemented_experiment_count"
      expr: COUNT(CASE WHEN implementation_flag = TRUE THEN experiment_id END)
      comment: "Number of experiments where winning variants were implemented. Measures experiment-to-action conversion rate."
    - name: "avg_p_value"
      expr: AVG(CAST(p_value AS DOUBLE))
      comment: "Average p-value across experiments. Statistical quality KPI ensuring experimentation rigor and decision reliability."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`marketing_guest_communication`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Guest communication delivery and engagement metrics. Tracks email and messaging performance including delivery rates, open rates, click rates, and conversion outcomes to optimize CRM and lifecycle marketing."
  source: "`vibe_travel_hospitality_v1`.`marketing`.`guest_communication`"
  dimensions:
    - name: "channel"
      expr: channel
      comment: "Communication channel (email, SMS, push notification) for channel-level engagement analysis."
    - name: "communication_type"
      expr: communication_type
      comment: "Type of communication (transactional, promotional, service) for message type performance segmentation."
    - name: "delivery_status"
      expr: delivery_status
      comment: "Delivery outcome (delivered, bounced, suppressed) for deliverability monitoring."
    - name: "opt_in_status"
      expr: opt_in_status
      comment: "Guest opt-in status for consent-based communication compliance tracking."
    - name: "conversion_flag"
      expr: conversion_flag
      comment: "Whether the communication resulted in a booking conversion. Used to isolate high-performing message types."
    - name: "language_code"
      expr: language_code
      comment: "Language of the communication for multilingual campaign performance analysis."
    - name: "sent_month"
      expr: DATE_TRUNC('MONTH', sent_timestamp)
      comment: "Month the communication was sent for trend analysis of CRM activity and engagement over time."
  measures:
    - name: "total_communications_sent"
      expr: COUNT(1)
      comment: "Total number of guest communications sent. Measures CRM program reach and communication volume."
    - name: "total_conversion_value"
      expr: SUM(CAST(conversion_value AS DOUBLE))
      comment: "Total revenue value from communications that converted to bookings. Primary CRM revenue attribution KPI."
    - name: "avg_conversion_value"
      expr: AVG(CAST(conversion_value AS DOUBLE))
      comment: "Average conversion value per communication. Benchmarks revenue productivity of CRM messages."
    - name: "converting_communication_count"
      expr: COUNT(CASE WHEN conversion_flag = TRUE THEN guest_communication_id END)
      comment: "Number of communications that resulted in a conversion. Measures CRM program effectiveness."
    - name: "distinct_reached_guests"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of distinct guests reached by communications. Measures unique audience coverage of CRM programs."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`marketing_guest_segment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Guest segment sizing and targeting metrics. Tracks segment scale, ADR targets, LTV thresholds, and satisfaction benchmarks to guide audience strategy and personalization investment."
  source: "`vibe_travel_hospitality_v1`.`marketing`.`guest_segment`"
  dimensions:
    - name: "segment_type"
      expr: segment_type
      comment: "Type of guest segment (behavioral, demographic, value-based) for segmentation strategy analysis."
    - name: "segment_status"
      expr: segment_status
      comment: "Current status of the segment (active, archived, draft) for segment portfolio management."
    - name: "segment_creation_method"
      expr: segment_creation_method
      comment: "How the segment was created (rules-based, ML model, manual) for segment quality and methodology tracking."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the segment for regional audience strategy analysis."
    - name: "campaign_eligibility_flag"
      expr: campaign_eligibility_flag
      comment: "Whether the segment is eligible for campaign targeting. Measures addressable segment universe."
    - name: "refresh_frequency"
      expr: refresh_frequency
      comment: "How frequently the segment is refreshed (daily, weekly, monthly) for data freshness governance."
  measures:
    - name: "total_estimated_audience_size"
      expr: SUM(CAST(estimated_size AS DOUBLE))
      comment: "Total estimated audience size across all segments. Measures addressable marketing universe for campaign reach planning."
    - name: "avg_segment_size"
      expr: AVG(CAST(estimated_size AS DOUBLE))
      comment: "Average size per guest segment. Benchmarks segment granularity for personalization vs. scale trade-off decisions."
    - name: "avg_target_adr_max"
      expr: AVG(CAST(target_adr_max AS DOUBLE))
      comment: "Average maximum ADR target across segments. Informs rate strategy and revenue management alignment with marketing segments."
    - name: "avg_target_ltv_min"
      expr: AVG(CAST(target_ltv_min AS DOUBLE))
      comment: "Average minimum LTV threshold across segments. Measures value-based segmentation standards for high-value guest targeting."
    - name: "avg_target_gss_min"
      expr: AVG(CAST(target_gss_min AS DOUBLE))
      comment: "Average minimum GSS target across segments. Aligns marketing segments with guest satisfaction quality thresholds."
    - name: "active_segment_count"
      expr: COUNT(CASE WHEN segment_status = 'active' THEN guest_segment_id END)
      comment: "Number of active guest segments. Measures segmentation program breadth for personalization capability assessment."
    - name: "ml_segment_count"
      expr: COUNT(CASE WHEN segment_creation_method = 'ML' THEN guest_segment_id END)
      comment: "Number of ML-generated segments. Tracks AI/ML adoption in audience strategy for innovation investment decisions."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`marketing_marketing_calendar`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Marketing Calendar business metrics"
  source: "`travel_hospitality_ecm`.`marketing`.`marketing_calendar`"
  dimensions:
    - name: "Actual Campaign Count"
      expr: actual_campaign_count
    - name: "Approval Required Flag"
      expr: approval_required_flag
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Blackout Reason"
      expr: blackout_reason
    - name: "Brand Moment Description"
      expr: brand_moment_description
    - name: "Brand Scope"
      expr: brand_scope
    - name: "Collision Risk Flag"
      expr: collision_risk_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Cross Functional Dependencies"
      expr: cross_functional_dependencies
    - name: "Duration Days"
      expr: duration_days
    - name: "End Date"
      expr: end_date
    - name: "Entry Code"
      expr: entry_code
    - name: "Entry Name"
      expr: entry_name
    - name: "Entry Status"
      expr: entry_status
    - name: "Entry Type"
      expr: entry_type
    - name: "Expected Campaign Count"
      expr: expected_campaign_count
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Marketing Calendar"
      expr: COUNT(DISTINCT marketing_calendar_id)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`marketing_offer_redemption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Offer redemption performance metrics tracking discount economics, redemption volume, and revenue impact. Critical for evaluating promotional ROI and offer strategy effectiveness."
  source: "`vibe_travel_hospitality_v1`.`marketing`.`offer_redemption`"
  dimensions:
    - name: "discount_type"
      expr: discount_type
      comment: "Type of discount applied (percentage, flat, points) for offer type performance comparison."
    - name: "redemption_channel"
      expr: redemption_channel
      comment: "Channel through which the offer was redeemed (web, mobile, OTA, front desk) for channel redemption analysis."
    - name: "market_segment_code"
      expr: market_segment_code
      comment: "Market segment of the redeeming guest for segment-level offer effectiveness analysis."
    - name: "offer_code"
      expr: offer_code
      comment: "Specific offer code redeemed for offer-level performance tracking."
    - name: "validation_status"
      expr: validation_status
      comment: "Validation outcome of the redemption (valid, rejected, expired) for redemption quality monitoring."
    - name: "booking_month"
      expr: DATE_TRUNC('MONTH', booking_date)
      comment: "Month of booking associated with the redemption for seasonal offer performance analysis."
    - name: "device_type"
      expr: device_type
      comment: "Device used for redemption for digital channel optimization."
  measures:
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount value granted through offer redemptions. Measures promotional cost and margin impact."
    - name: "total_final_rate_revenue"
      expr: SUM(CAST(final_rate_amount AS DOUBLE))
      comment: "Total revenue realized after discount application. Net revenue KPI for promotional campaign profitability."
    - name: "total_original_rate_revenue"
      expr: SUM(CAST(original_rate_amount AS DOUBLE))
      comment: "Total revenue at rack/original rate before discount. Used to compute discount depth and revenue displacement."
    - name: "avg_discount_amount"
      expr: AVG(CAST(discount_amount AS DOUBLE))
      comment: "Average discount per redemption. Benchmarks offer generosity and informs discount strategy calibration."
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage per redemption. Key metric for offer depth analysis and yield management."
    - name: "redemption_count"
      expr: COUNT(1)
      comment: "Total number of offer redemptions. Measures promotional uptake and campaign reach."
    - name: "distinct_redeeming_guests"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of distinct guests who redeemed an offer. Measures unique guest engagement with promotional campaigns."
    - name: "avg_final_rate"
      expr: AVG(CAST(final_rate_amount AS DOUBLE))
      comment: "Average net rate per redemption after discount. Indicates revenue quality of promotional bookings."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`marketing_social_post`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Social media performance metrics tracking engagement, reach, and content effectiveness across platforms. Informs social channel investment and content strategy decisions."
  source: "`vibe_travel_hospitality_v1`.`marketing`.`social_post`"
  dimensions:
    - name: "platform"
      expr: platform
      comment: "Social media platform (Instagram, Facebook, LinkedIn, Twitter) for platform-level performance benchmarking."
    - name: "post_type"
      expr: post_type
      comment: "Type of social post (image, video, story, carousel) for content format effectiveness analysis."
    - name: "post_status"
      expr: post_status
      comment: "Current status of the post (published, scheduled, deleted) for content pipeline management."
    - name: "is_boosted"
      expr: is_boosted
      comment: "Whether the post was boosted with paid spend. Enables organic vs. paid performance comparison."
    - name: "approval_status"
      expr: approval_status
      comment: "Content approval status for governance and brand compliance tracking."
    - name: "content_language"
      expr: content_language
      comment: "Language of the post content for multilingual content performance analysis."
    - name: "publish_month"
      expr: DATE_TRUNC('MONTH', actual_publish_timestamp)
      comment: "Month the post was published for trend analysis of social media activity and performance."
  measures:
    - name: "total_impressions"
      expr: SUM(CAST(impressions_count AS DOUBLE))
      comment: "Total impressions across all social posts. Measures brand awareness reach from social media activity."
    - name: "total_engagement"
      expr: SUM(CAST(engagement_count AS DOUBLE))
      comment: "Total engagement actions (likes, comments, shares, saves) across posts. Core social performance KPI."
    - name: "total_reach"
      expr: SUM(CAST(reach_count AS DOUBLE))
      comment: "Total unique accounts reached by social posts. Measures unduplicated audience exposure for brand campaigns."
    - name: "total_link_clicks"
      expr: SUM(CAST(link_clicks_count AS DOUBLE))
      comment: "Total link clicks from social posts. Measures traffic driven to booking engine or campaign landing pages."
    - name: "total_video_views"
      expr: SUM(CAST(video_views_count AS DOUBLE))
      comment: "Total video views across social posts. Key metric for video content investment decisions."
    - name: "total_boost_spend"
      expr: SUM(CAST(boost_budget_amount AS DOUBLE))
      comment: "Total paid boost spend on social posts. Measures paid social investment for ROI calculation."
    - name: "avg_engagement_rate"
      expr: AVG(CAST(engagement_rate AS DOUBLE))
      comment: "Average engagement rate per post. Primary content effectiveness KPI for social media strategy decisions."
    - name: "avg_sentiment_score"
      expr: AVG(CAST(sentiment_score AS DOUBLE))
      comment: "Average sentiment score of social posts. Tracks brand perception trends from social content."
    - name: "total_post_count"
      expr: COUNT(1)
      comment: "Total number of social posts published. Measures content production volume and publishing cadence."
    - name: "total_likes"
      expr: SUM(CAST(likes_count AS DOUBLE))
      comment: "Total likes across social posts. Measures positive audience affinity with brand content."
    - name: "total_shares"
      expr: SUM(CAST(shares_count AS DOUBLE))
      comment: "Total shares across social posts. Measures organic amplification and earned media value."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`marketing_survey_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Survey program configuration and target metrics. Tracks response rate targets, satisfaction score goals, and program coverage to govern the guest feedback collection strategy."
  source: "`vibe_travel_hospitality_v1`.`marketing`.`survey_program`"
  dimensions:
    - name: "survey_type"
      expr: survey_type
      comment: "Type of survey (post-stay, in-stay, event) for survey program portfolio analysis."
    - name: "survey_category"
      expr: survey_category
      comment: "Category of the survey program (GSS, NPS, CSAT) for satisfaction measurement framework tracking."
    - name: "distribution_channel"
      expr: distribution_channel
      comment: "Channel used to distribute the survey (email, SMS, in-app) for distribution effectiveness analysis."
    - name: "survey_program_status"
      expr: survey_program_status
      comment: "Current status of the survey program (active, paused, archived) for program portfolio management."
    - name: "active_flag"
      expr: active_flag
      comment: "Whether the survey program is currently active. Used to filter active programs for operational reporting."
    - name: "incentive_offered_flag"
      expr: incentive_offered_flag
      comment: "Whether an incentive is offered for survey completion. Measures incentive strategy impact on response rates."
  measures:
    - name: "avg_target_response_rate_pct"
      expr: AVG(CAST(target_response_rate_pct AS DOUBLE))
      comment: "Average target response rate across survey programs. Benchmarks ambition level of feedback collection programs."
    - name: "avg_target_nps_score"
      expr: AVG(CAST(target_nps_score AS DOUBLE))
      comment: "Average NPS target across survey programs. Measures the ambition level of guest satisfaction goals."
    - name: "avg_target_gss_score"
      expr: AVG(CAST(target_gss_score AS DOUBLE))
      comment: "Average GSS target across survey programs. Tracks satisfaction score ambition for brand standards governance."
    - name: "avg_service_recovery_threshold"
      expr: AVG(CAST(service_recovery_threshold_score AS DOUBLE))
      comment: "Average service recovery trigger threshold across programs. Governs when automatic case creation fires for guest recovery."
    - name: "active_program_count"
      expr: COUNT(CASE WHEN active_flag = TRUE THEN survey_program_id END)
      comment: "Number of active survey programs. Measures feedback collection program coverage across the portfolio."
    - name: "incentivized_program_count"
      expr: COUNT(CASE WHEN incentive_offered_flag = TRUE THEN survey_program_id END)
      comment: "Number of survey programs offering incentives. Tracks incentive strategy adoption for response rate optimization."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`marketing_survey_response`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Guest satisfaction and survey response analytics. Tracks NPS, GSS, CSAT scores and response rates to steer service quality investments and identify recovery opportunities."
  source: "`vibe_travel_hospitality_v1`.`marketing`.`survey_response`"
  dimensions:
    - name: "response_channel"
      expr: response_channel
      comment: "Channel through which the survey was completed (email, in-app, kiosk) for channel response quality analysis."
    - name: "guest_type"
      expr: guest_type
      comment: "Type of guest respondent (leisure, business, group) for segment-level satisfaction analysis."
    - name: "loyalty_tier"
      expr: loyalty_tier
      comment: "Loyalty tier of the responding guest for tier-level satisfaction benchmarking."
    - name: "nps_classification"
      expr: nps_classification
      comment: "NPS classification (Promoter, Passive, Detractor) for Net Promoter Score distribution analysis."
    - name: "sentiment_classification"
      expr: sentiment_classification
      comment: "Sentiment classification of verbatim feedback (positive, neutral, negative) for qualitative trend analysis."
    - name: "booking_channel"
      expr: booking_channel
      comment: "Channel used to book the stay for channel-level satisfaction correlation."
    - name: "response_month"
      expr: DATE_TRUNC('MONTH', response_timestamp)
      comment: "Month of survey response for trend analysis of satisfaction scores over time."
    - name: "follow_up_required_flag"
      expr: follow_up_required_flag
      comment: "Whether a service recovery follow-up is required. Used to track unresolved guest issues."
  measures:
    - name: "avg_gss_score"
      expr: AVG(CAST(gss_score AS DOUBLE))
      comment: "Average Guest Satisfaction Score across survey responses. Primary guest experience KPI for executive dashboards and brand standards compliance."
    - name: "avg_csat_score"
      expr: AVG(CAST(csat_score AS DOUBLE))
      comment: "Average Customer Satisfaction Score. Operational quality KPI used to trigger service recovery and staff coaching."
    - name: "avg_sentiment_score"
      expr: AVG(CAST(sentiment_score AS DOUBLE))
      comment: "Average sentiment score from verbatim feedback analysis. Tracks qualitative guest perception trends."
    - name: "total_survey_responses"
      expr: COUNT(1)
      comment: "Total number of survey responses received. Measures survey program reach and statistical validity of satisfaction scores."
    - name: "follow_up_required_count"
      expr: COUNT(CASE WHEN follow_up_required_flag = TRUE THEN survey_response_id END)
      comment: "Number of responses requiring service recovery follow-up. Operational KPI for guest recovery workload management."
    - name: "total_spend_amount"
      expr: SUM(CAST(total_spend_amount AS DOUBLE))
      comment: "Total guest spend associated with survey responses. Enables correlation of satisfaction scores with revenue contribution."
    - name: "avg_total_spend"
      expr: AVG(CAST(total_spend_amount AS DOUBLE))
      comment: "Average spend per responding guest. Benchmarks revenue value of satisfied vs. dissatisfied guests."
    - name: "distinct_responding_guests"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of distinct guests who responded to surveys. Measures unique guest voice coverage for satisfaction programs."
$$;
