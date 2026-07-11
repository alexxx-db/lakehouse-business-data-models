-- Metric views for domain: marketing | Business: Travel_Hospitality | Version: 2 | Generated on: 2026-07-10 20:28:13

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`marketing_attribution_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Attribution Event business metrics"
  source: "`vibe_travel_hospitality_v1`.`marketing`.`attribution_event`"
  dimensions:
    - name: "Ad Platform"
      expr: ad_platform
    - name: "Attribution Model"
      expr: attribution_model
    - name: "Browser"
      expr: browser
    - name: "Channel"
      expr: channel
    - name: "Conversion Currency Code"
      expr: conversion_currency_code
    - name: "Conversion Flag"
      expr: conversion_flag
    - name: "Cookie Code"
      expr: cookie_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Device Code"
      expr: device_code
    - name: "Device Type"
      expr: device_type
    - name: "Event Source System"
      expr: event_source_system
    - name: "Event Status"
      expr: event_status
    - name: "Event Timestamp"
      expr: event_timestamp
    - name: "Geo City"
      expr: geo_city
    - name: "Geo Country Code"
      expr: geo_country_code
    - name: "Geo Region"
      expr: geo_region
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Attribution Event"
      expr: COUNT(DISTINCT attribution_event_id)
    - name: "Total Attribution Credit"
      expr: SUM(attribution_credit)
    - name: "Average Attribution Credit"
      expr: AVG(attribution_credit)
    - name: "Total Conversion Value"
      expr: SUM(conversion_value)
    - name: "Average Conversion Value"
      expr: AVG(conversion_value)
    - name: "Total Time To Conversion Hours"
      expr: SUM(time_to_conversion_hours)
    - name: "Average Time To Conversion Hours"
      expr: AVG(time_to_conversion_hours)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`marketing_brand`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Brand business metrics"
  source: "`vibe_travel_hospitality_v1`.`marketing`.`brand`"
  dimensions:
    - name: "Brand Status"
      expr: brand_status
    - name: "Brand Tier"
      expr: brand_tier
    - name: "Brand Code"
      expr: brand_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Brand Description"
      expr: brand_description
    - name: "Geographic Focus"
      expr: geographic_focus
    - name: "Guidelines Url"
      expr: guidelines_url
    - name: "Is Featured Brand"
      expr: is_featured_brand
    - name: "Launch Date"
      expr: launch_date
    - name: "Logo Url"
      expr: logo_url
    - name: "Loyalty Program Name"
      expr: loyalty_program_name
    - name: "Brand Name"
      expr: brand_name
    - name: "Parent Company"
      expr: parent_company
    - name: "Positioning Statement"
      expr: positioning_statement
    - name: "Primary Color Hex"
      expr: primary_color_hex
    - name: "Property Count"
      expr: property_count
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Brand"
      expr: COUNT(DISTINCT brand_id)
    - name: "Total Average Daily Rate Target"
      expr: SUM(average_daily_rate_target)
    - name: "Average Average Daily Rate Target"
      expr: AVG(average_daily_rate_target)
    - name: "Total Guest Satisfaction Score Target"
      expr: SUM(guest_satisfaction_score_target)
    - name: "Average Guest Satisfaction Score Target"
      expr: AVG(guest_satisfaction_score_target)
    - name: "Total Marketing Budget Annual"
      expr: SUM(marketing_budget_annual)
    - name: "Average Marketing Budget Annual"
      expr: AVG(marketing_budget_annual)
    - name: "Total Net Promoter Score Target"
      expr: SUM(net_promoter_score_target)
    - name: "Average Net Promoter Score Target"
      expr: AVG(net_promoter_score_target)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`marketing_campaign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Campaign business metrics"
  source: "`vibe_travel_hospitality_v1`.`marketing`.`campaign`"
  dimensions:
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved By"
      expr: approved_by
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Brand Scope"
      expr: brand_scope
    - name: "Budget Currency Code"
      expr: budget_currency_code
    - name: "Budget Owner"
      expr: budget_owner
    - name: "Budget Period"
      expr: budget_period
    - name: "Campaign Status"
      expr: campaign_status
    - name: "Campaign Type"
      expr: campaign_type
    - name: "Campaign Code"
      expr: campaign_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Crm Campaign Code"
      expr: crm_campaign_code
    - name: "Campaign Description"
      expr: campaign_description
    - name: "End Date"
      expr: end_date
    - name: "Is Active"
      expr: is_active
    - name: "Modified Timestamp"
      expr: modified_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Campaign"
      expr: COUNT(DISTINCT campaign_id)
    - name: "Total Actual Spend Amount"
      expr: SUM(actual_spend_amount)
    - name: "Average Actual Spend Amount"
      expr: AVG(actual_spend_amount)
    - name: "Total Budget Variance Amount"
      expr: SUM(budget_variance_amount)
    - name: "Average Budget Variance Amount"
      expr: AVG(budget_variance_amount)
    - name: "Total Committed Spend Amount"
      expr: SUM(committed_spend_amount)
    - name: "Average Committed Spend Amount"
      expr: AVG(committed_spend_amount)
    - name: "Total Display Budget Amount"
      expr: SUM(display_budget_amount)
    - name: "Average Display Budget Amount"
      expr: AVG(display_budget_amount)
    - name: "Total Email Budget Amount"
      expr: SUM(email_budget_amount)
    - name: "Average Email Budget Amount"
      expr: AVG(email_budget_amount)
    - name: "Total Other Channel Budget Amount"
      expr: SUM(other_channel_budget_amount)
    - name: "Average Other Channel Budget Amount"
      expr: AVG(other_channel_budget_amount)
    - name: "Total Paid Search Budget Amount"
      expr: SUM(paid_search_budget_amount)
    - name: "Average Paid Search Budget Amount"
      expr: AVG(paid_search_budget_amount)
    - name: "Total Remaining Budget Amount"
      expr: SUM(remaining_budget_amount)
    - name: "Average Remaining Budget Amount"
      expr: AVG(remaining_budget_amount)
    - name: "Total Social Budget Amount"
      expr: SUM(social_budget_amount)
    - name: "Average Social Budget Amount"
      expr: AVG(social_budget_amount)
    - name: "Total Total Budget Amount"
      expr: SUM(total_budget_amount)
    - name: "Average Total Budget Amount"
      expr: AVG(total_budget_amount)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`marketing_campaign_execution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Campaign Execution business metrics"
  source: "`vibe_travel_hospitality_v1`.`marketing`.`campaign_execution`"
  dimensions:
    - name: "Ab Test Variant"
      expr: ab_test_variant
    - name: "Attribution Model Type"
      expr: attribution_model_type
    - name: "Audience Size"
      expr: audience_size
    - name: "Bounce Count"
      expr: bounce_count
    - name: "Channel"
      expr: channel
    - name: "Channel Category"
      expr: channel_category
    - name: "Channel Code"
      expr: channel_code
    - name: "Channel Cost Model"
      expr: channel_cost_model
    - name: "Click Count"
      expr: click_count
    - name: "Completed Timestamp"
      expr: completed_timestamp
    - name: "Conversion Count"
      expr: conversion_count
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Creative Version"
      expr: creative_version
    - name: "Currency Code"
      expr: currency_code
    - name: "Delivery Count"
      expr: delivery_count
    - name: "Execution Name"
      expr: execution_name
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Campaign Execution"
      expr: COUNT(DISTINCT campaign_execution_id)
    - name: "Total Execution Cost"
      expr: SUM(execution_cost)
    - name: "Average Execution Cost"
      expr: AVG(execution_cost)
    - name: "Total Revenue Attributed"
      expr: SUM(revenue_attributed)
    - name: "Average Revenue Attributed"
      expr: AVG(revenue_attributed)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`marketing_campaign_offer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Campaign Offer business metrics"
  source: "`vibe_travel_hospitality_v1`.`marketing`.`campaign_offer`"
  dimensions:
    - name: "Advance Booking Days"
      expr: advance_booking_days
    - name: "Blackout Dates"
      expr: blackout_dates
    - name: "Bonus Points Flat"
      expr: bonus_points_flat
    - name: "Booking Window End Date"
      expr: booking_window_end_date
    - name: "Booking Window Start Date"
      expr: booking_window_start_date
    - name: "Channel Restrictions"
      expr: channel_restrictions
    - name: "Combinable With Other Offers Flag"
      expr: combinable_with_other_offers_flag
    - name: "Created By User"
      expr: created_by_user
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Discount Type"
      expr: discount_type
    - name: "Eligible Property Codes"
      expr: eligible_property_codes
    - name: "Eligible Property Scope"
      expr: eligible_property_scope
    - name: "Eligible Rate Plans"
      expr: eligible_rate_plans
    - name: "Eligible Room Types"
      expr: eligible_room_types
    - name: "Eligible Tier Levels"
      expr: eligible_tier_levels
    - name: "Enrollment Required Flag"
      expr: enrollment_required_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Campaign Offer"
      expr: COUNT(DISTINCT campaign_offer_id)
    - name: "Total Bonus Points Multiplier"
      expr: SUM(bonus_points_multiplier)
    - name: "Average Bonus Points Multiplier"
      expr: AVG(bonus_points_multiplier)
    - name: "Total Discount Value"
      expr: SUM(discount_value)
    - name: "Average Discount Value"
      expr: AVG(discount_value)
    - name: "Total Minimum Spend Amount"
      expr: SUM(minimum_spend_amount)
    - name: "Average Minimum Spend Amount"
      expr: AVG(minimum_spend_amount)
    - name: "Total Tier Credit Multiplier"
      expr: SUM(tier_credit_multiplier)
    - name: "Average Tier Credit Multiplier"
      expr: AVG(tier_credit_multiplier)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`marketing_campaign_treatment_promotion`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Campaign Treatment Promotion business metrics"
  source: "`vibe_travel_hospitality_v1`.`marketing`.`campaign_treatment_promotion`"
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

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`marketing_communication_template`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Communication Template business metrics"
  source: "`vibe_travel_hospitality_v1`.`marketing`.`communication_template`"
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
    - name: "Communication Template Description"
      expr: communication_template_description
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
  comment: "Consent business metrics"
  source: "`vibe_travel_hospitality_v1`.`marketing`.`consent`"
  dimensions:
    - name: "Communication Frequency Preference"
      expr: communication_frequency_preference
    - name: "Consent Date"
      expr: consent_date
    - name: "Consent Status"
      expr: consent_status
    - name: "Consent Type"
      expr: consent_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Processing Agreement Accepted"
      expr: data_processing_agreement_accepted
    - name: "Double Opt In Confirmed"
      expr: double_opt_in_confirmed
    - name: "Double Opt In Date"
      expr: double_opt_in_date
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Ip Address"
      expr: ip_address
    - name: "Is Active"
      expr: is_active
    - name: "Jurisdiction"
      expr: jurisdiction
    - name: "Language"
      expr: language
    - name: "Last Communication Date"
      expr: last_communication_date
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Legal Basis"
      expr: legal_basis
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Consent"
      expr: COUNT(DISTINCT consent_id)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`marketing_content_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Content Asset business metrics"
  source: "`vibe_travel_hospitality_v1`.`marketing`.`content_asset`"
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
    - name: "Content Theme"
      expr: content_theme
    - name: "Copyright Holder"
      expr: copyright_holder
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Creator Name"
      expr: creator_name
    - name: "Content Asset Description"
      expr: content_asset_description
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
  comment: "Experiment business metrics"
  source: "`vibe_travel_hospitality_v1`.`marketing`.`experiment`"
  dimensions:
    - name: "Actual Duration Days"
      expr: actual_duration_days
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Channel"
      expr: channel
    - name: "Experiment Code"
      expr: experiment_code
    - name: "Conclusion Notes"
      expr: conclusion_notes
    - name: "Control Variant Description"
      expr: control_variant_description
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "End Date"
      expr: end_date
    - name: "Experiment Status"
      expr: experiment_status
    - name: "Experiment Type"
      expr: experiment_type
    - name: "Hypothesis"
      expr: hypothesis
    - name: "Impact Currency Code"
      expr: impact_currency_code
    - name: "Implementation Date"
      expr: implementation_date
    - name: "Implementation Flag"
      expr: implementation_flag
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Experiment Name"
      expr: experiment_name
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Experiment"
      expr: COUNT(DISTINCT experiment_id)
    - name: "Total Confidence Level Percentage"
      expr: SUM(confidence_level_percentage)
    - name: "Average Confidence Level Percentage"
      expr: AVG(confidence_level_percentage)
    - name: "Total Control Allocation Percentage"
      expr: SUM(control_allocation_percentage)
    - name: "Average Control Allocation Percentage"
      expr: AVG(control_allocation_percentage)
    - name: "Total Estimated Annual Impact Amount"
      expr: SUM(estimated_annual_impact_amount)
    - name: "Average Estimated Annual Impact Amount"
      expr: AVG(estimated_annual_impact_amount)
    - name: "Total Lift Percentage"
      expr: SUM(lift_percentage)
    - name: "Average Lift Percentage"
      expr: AVG(lift_percentage)
    - name: "Total P Value"
      expr: SUM(p_value)
    - name: "Average P Value"
      expr: AVG(p_value)
    - name: "Total Statistical Significance Threshold"
      expr: SUM(statistical_significance_threshold)
    - name: "Average Statistical Significance Threshold"
      expr: AVG(statistical_significance_threshold)
    - name: "Total Traffic Allocation Percentage"
      expr: SUM(traffic_allocation_percentage)
    - name: "Average Traffic Allocation Percentage"
      expr: AVG(traffic_allocation_percentage)
    - name: "Total Treatment Allocation Percentage"
      expr: SUM(treatment_allocation_percentage)
    - name: "Average Treatment Allocation Percentage"
      expr: AVG(treatment_allocation_percentage)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`marketing_guest_communication`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Guest Communication business metrics"
  source: "`vibe_travel_hospitality_v1`.`marketing`.`guest_communication`"
  dimensions:
    - name: "Ab Test Variant"
      expr: ab_test_variant
    - name: "Body Content"
      expr: body_content
    - name: "Bounce Reason"
      expr: bounce_reason
    - name: "Bounced Timestamp"
      expr: bounced_timestamp
    - name: "Channel"
      expr: channel
    - name: "Clicked Timestamp"
      expr: clicked_timestamp
    - name: "Communication Type"
      expr: communication_type
    - name: "Conversion Flag"
      expr: conversion_flag
    - name: "Conversion Timestamp"
      expr: conversion_timestamp
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Crm Activity Code"
      expr: crm_activity_code
    - name: "Delivered Timestamp"
      expr: delivered_timestamp
    - name: "Delivery Status"
      expr: delivery_status
    - name: "Language Code"
      expr: language_code
    - name: "Locale Code"
      expr: locale_code
    - name: "Opened Timestamp"
      expr: opened_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Guest Communication"
      expr: COUNT(DISTINCT guest_communication_id)
    - name: "Total Conversion Value"
      expr: SUM(conversion_value)
    - name: "Average Conversion Value"
      expr: AVG(conversion_value)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`marketing_guest_segment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Guest Segment business metrics"
  source: "`vibe_travel_hospitality_v1`.`marketing`.`guest_segment`"
  dimensions:
    - name: "Approved By"
      expr: approved_by
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Campaign Eligibility Flag"
      expr: campaign_eligibility_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Source"
      expr: data_source
    - name: "Definition Criteria"
      expr: definition_criteria
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Geographic Scope"
      expr: geographic_scope
    - name: "Last Refresh Date"
      expr: last_refresh_date
    - name: "Loyalty Tier Scope"
      expr: loyalty_tier_scope
    - name: "Ml Model Name"
      expr: ml_model_name
    - name: "Ml Model Version"
      expr: ml_model_version
    - name: "Modified By"
      expr: modified_by
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Next Refresh Date"
      expr: next_refresh_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Guest Segment"
      expr: COUNT(DISTINCT guest_segment_id)
    - name: "Total Estimated Size"
      expr: SUM(estimated_size)
    - name: "Average Estimated Size"
      expr: AVG(estimated_size)
    - name: "Total Target Adr Max"
      expr: SUM(target_adr_max)
    - name: "Average Target Adr Max"
      expr: AVG(target_adr_max)
    - name: "Total Target Adr Min"
      expr: SUM(target_adr_min)
    - name: "Average Target Adr Min"
      expr: AVG(target_adr_min)
    - name: "Total Target Gss Min"
      expr: SUM(target_gss_min)
    - name: "Average Target Gss Min"
      expr: AVG(target_gss_min)
    - name: "Total Target Ltv Min"
      expr: SUM(target_ltv_min)
    - name: "Average Target Ltv Min"
      expr: AVG(target_ltv_min)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`marketing_marketing_calendar`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Marketing Calendar business metrics"
  source: "`vibe_travel_hospitality_v1`.`marketing`.`marketing_calendar`"
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
  comment: "Offer Redemption business metrics"
  source: "`vibe_travel_hospitality_v1`.`marketing`.`offer_redemption`"
  dimensions:
    - name: "Attribution Source"
      expr: attribution_source
    - name: "Booking Date"
      expr: booking_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Device Type"
      expr: device_type
    - name: "Discount Type"
      expr: discount_type
    - name: "Ip Address"
      expr: ip_address
    - name: "Length Of Stay"
      expr: length_of_stay
    - name: "Market Segment Code"
      expr: market_segment_code
    - name: "Offer Code"
      expr: offer_code
    - name: "Points Earned"
      expr: points_earned
    - name: "Points Redeemed"
      expr: points_redeemed
    - name: "Promo Terms Accepted Flag"
      expr: promo_terms_accepted_flag
    - name: "Rate Plan Code"
      expr: rate_plan_code
    - name: "Redemption Channel"
      expr: redemption_channel
    - name: "Redemption Timestamp"
      expr: redemption_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Offer Redemption"
      expr: COUNT(DISTINCT offer_redemption_id)
    - name: "Total Discount Amount"
      expr: SUM(discount_amount)
    - name: "Average Discount Amount"
      expr: AVG(discount_amount)
    - name: "Total Discount Percentage"
      expr: SUM(discount_percentage)
    - name: "Average Discount Percentage"
      expr: AVG(discount_percentage)
    - name: "Total Final Rate Amount"
      expr: SUM(final_rate_amount)
    - name: "Average Final Rate Amount"
      expr: AVG(final_rate_amount)
    - name: "Total Original Rate Amount"
      expr: SUM(original_rate_amount)
    - name: "Average Original Rate Amount"
      expr: AVG(original_rate_amount)
    - name: "Total Redemption Location Latitude"
      expr: SUM(redemption_location_latitude)
    - name: "Average Redemption Location Latitude"
      expr: AVG(redemption_location_latitude)
    - name: "Total Redemption Location Longitude"
      expr: SUM(redemption_location_longitude)
    - name: "Average Redemption Location Longitude"
      expr: AVG(redemption_location_longitude)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`marketing_social_post`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Social Post business metrics"
  source: "`vibe_travel_hospitality_v1`.`marketing`.`social_post`"
  dimensions:
    - name: "Actual Publish Timestamp"
      expr: actual_publish_timestamp
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Boost Currency Code"
      expr: boost_currency_code
    - name: "Content Language"
      expr: content_language
    - name: "Content Text"
      expr: content_text
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Deleted Reason"
      expr: deleted_reason
    - name: "Deleted Timestamp"
      expr: deleted_timestamp
    - name: "Hashtags"
      expr: hashtags
    - name: "Is Boosted"
      expr: is_boosted
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "Metrics Last Refreshed Timestamp"
      expr: metrics_last_refreshed_timestamp
    - name: "Platform"
      expr: platform
    - name: "Post External Code"
      expr: post_external_code
    - name: "Post Status"
      expr: post_status
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Social Post"
      expr: COUNT(DISTINCT social_post_id)
    - name: "Total Boost Budget Amount"
      expr: SUM(boost_budget_amount)
    - name: "Average Boost Budget Amount"
      expr: AVG(boost_budget_amount)
    - name: "Total Comments Count"
      expr: SUM(comments_count)
    - name: "Average Comments Count"
      expr: AVG(comments_count)
    - name: "Total Engagement Count"
      expr: SUM(engagement_count)
    - name: "Average Engagement Count"
      expr: AVG(engagement_count)
    - name: "Total Engagement Rate"
      expr: SUM(engagement_rate)
    - name: "Average Engagement Rate"
      expr: AVG(engagement_rate)
    - name: "Total Impressions Count"
      expr: SUM(impressions_count)
    - name: "Average Impressions Count"
      expr: AVG(impressions_count)
    - name: "Total Likes Count"
      expr: SUM(likes_count)
    - name: "Average Likes Count"
      expr: AVG(likes_count)
    - name: "Total Link Clicks Count"
      expr: SUM(link_clicks_count)
    - name: "Average Link Clicks Count"
      expr: AVG(link_clicks_count)
    - name: "Total Reach Count"
      expr: SUM(reach_count)
    - name: "Average Reach Count"
      expr: AVG(reach_count)
    - name: "Total Saves Count"
      expr: SUM(saves_count)
    - name: "Average Saves Count"
      expr: AVG(saves_count)
    - name: "Total Sentiment Score"
      expr: SUM(sentiment_score)
    - name: "Average Sentiment Score"
      expr: AVG(sentiment_score)
    - name: "Total Shares Count"
      expr: SUM(shares_count)
    - name: "Average Shares Count"
      expr: AVG(shares_count)
    - name: "Total Video Views Count"
      expr: SUM(video_views_count)
    - name: "Average Video Views Count"
      expr: AVG(video_views_count)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`marketing_survey_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Survey Program business metrics"
  source: "`vibe_travel_hospitality_v1`.`marketing`.`survey_program`"
  dimensions:
    - name: "Active Flag"
      expr: active_flag
    - name: "Auto Case Creation Flag"
      expr: auto_case_creation_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Retention Days"
      expr: data_retention_days
    - name: "Distribution Channel"
      expr: distribution_channel
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Estimated Completion Minutes"
      expr: estimated_completion_minutes
    - name: "Incentive Description"
      expr: incentive_description
    - name: "Incentive Offered Flag"
      expr: incentive_offered_flag
    - name: "Language Codes"
      expr: language_codes
    - name: "Max Reminders"
      expr: max_reminders
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Privacy Notice Version"
      expr: privacy_notice_version
    - name: "Property Scope"
      expr: property_scope
    - name: "Question Count"
      expr: question_count
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Survey Program"
      expr: COUNT(DISTINCT survey_program_id)
    - name: "Total Service Recovery Threshold Score"
      expr: SUM(service_recovery_threshold_score)
    - name: "Average Service Recovery Threshold Score"
      expr: AVG(service_recovery_threshold_score)
    - name: "Total Target Gss Score"
      expr: SUM(target_gss_score)
    - name: "Average Target Gss Score"
      expr: AVG(target_gss_score)
    - name: "Total Target Nps Score"
      expr: SUM(target_nps_score)
    - name: "Average Target Nps Score"
      expr: AVG(target_nps_score)
    - name: "Total Target Response Rate Pct"
      expr: SUM(target_response_rate_pct)
    - name: "Average Target Response Rate Pct"
      expr: AVG(target_response_rate_pct)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`marketing_survey_response`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Survey Response business metrics"
  source: "`vibe_travel_hospitality_v1`.`marketing`.`survey_response`"
  dimensions:
    - name: "Booking Channel"
      expr: booking_channel
    - name: "Checkout Date"
      expr: checkout_date
    - name: "Contact Permission Flag"
      expr: contact_permission_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Follow Up Required Flag"
      expr: follow_up_required_flag
    - name: "Guest Type"
      expr: guest_type
    - name: "Length Of Stay"
      expr: length_of_stay
    - name: "Loyalty Tier"
      expr: loyalty_tier
    - name: "Medallia Response Code"
      expr: medallia_response_code
    - name: "Nps Classification"
      expr: nps_classification
    - name: "Nps Score"
      expr: nps_score
    - name: "Rate Plan Code"
      expr: rate_plan_code
    - name: "Response Channel"
      expr: response_channel
    - name: "Response Status"
      expr: response_status
    - name: "Response Time Hours"
      expr: response_time_hours
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Survey Response"
      expr: COUNT(DISTINCT survey_response_id)
    - name: "Total Csat Score"
      expr: SUM(csat_score)
    - name: "Average Csat Score"
      expr: AVG(csat_score)
    - name: "Total Gss Score"
      expr: SUM(gss_score)
    - name: "Average Gss Score"
      expr: AVG(gss_score)
    - name: "Total Sentiment Score"
      expr: SUM(sentiment_score)
    - name: "Average Sentiment Score"
      expr: AVG(sentiment_score)
    - name: "Total Total Spend Amount"
      expr: SUM(total_spend_amount)
    - name: "Average Total Spend Amount"
      expr: AVG(total_spend_amount)
$$;