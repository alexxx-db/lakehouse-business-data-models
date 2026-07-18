-- Metric views for domain: campaign | Business: Advertising | Version: 1 | Generated on: 2026-05-08 02:25:38

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`campaign_ad`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ad business metrics"
  source: "`advertising_ecm`.`campaign`.`ad`"
  dimensions:
    - name: "Ad Name"
      expr: ad_name
    - name: "Ad Status"
      expr: ad_status
    - name: "Ad Type"
      expr: ad_type
    - name: "Approval Date"
      expr: approval_date
    - name: "Approved By"
      expr: approved_by
    - name: "Brand Safety Verified"
      expr: brand_safety_verified
    - name: "Ccpa Opt Out Honored"
      expr: ccpa_opt_out_honored
    - name: "Click Through Url"
      expr: click_through_url
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "End Date"
      expr: end_date
    - name: "Format"
      expr: format
    - name: "Frequency Cap"
      expr: frequency_cap
    - name: "Frequency Cap Period"
      expr: frequency_cap_period
    - name: "Gdpr Consent Required"
      expr: gdpr_consent_required
    - name: "Go Live Date"
      expr: go_live_date
    - name: "Impression Tracker Url"
      expr: impression_tracker_url
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Ad"
      expr: COUNT(DISTINCT ad_id)
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`campaign_ad_placement_rotation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ad Placement Rotation business metrics"
  source: "`advertising_ecm`.`campaign`.`ad_placement_rotation`"
  dimensions:
    - name: "Created Date"
      expr: created_date
    - name: "End Date"
      expr: end_date
    - name: "Last Modified Date"
      expr: last_modified_date
    - name: "Rotation Weight"
      expr: rotation_weight
    - name: "Start Date"
      expr: start_date
    - name: "Trafficking Status"
      expr: trafficking_status
    - name: "Created Date Month"
      expr: DATE_TRUNC('MONTH', created_date)
    - name: "End Date Month"
      expr: DATE_TRUNC('MONTH', end_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Ad Placement Rotation"
      expr: COUNT(DISTINCT ad_placement_rotation_id)
    - name: "Total Click Count"
      expr: SUM(click_count)
    - name: "Average Click Count"
      expr: AVG(click_count)
    - name: "Total Impression Count"
      expr: SUM(impression_count)
    - name: "Average Impression Count"
      expr: AVG(impression_count)
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`campaign_approval`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Approval business metrics"
  source: "`advertising_ecm`.`campaign`.`approval`"
  dimensions:
    - name: "Approval Status"
      expr: approval_status
    - name: "Approval Type"
      expr: approval_type
    - name: "Assigned Reviewer Name"
      expr: assigned_reviewer_name
    - name: "Authority Level"
      expr: authority_level
    - name: "Compliance Framework"
      expr: compliance_framework
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Decision Date"
      expr: decision_date
    - name: "Decision Notes"
      expr: decision_notes
    - name: "Document Reference"
      expr: document_reference
    - name: "Escalated To Name"
      expr: escalated_to_name
    - name: "Escalation Date"
      expr: escalation_date
    - name: "Escalation Flag"
      expr: escalation_flag
    - name: "Escalation Reason"
      expr: escalation_reason
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Notification Sent Date"
      expr: notification_sent_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Approval"
      expr: COUNT(DISTINCT approval_id)
    - name: "Total Amount Threshold"
      expr: SUM(amount_threshold)
    - name: "Average Amount Threshold"
      expr: AVG(amount_threshold)
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`campaign_booking`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Booking business metrics"
  source: "`advertising_ecm`.`campaign`.`booking`"
  dimensions:
    - name: "Booking Code"
      expr: booking_code
    - name: "Created Date"
      expr: created_date
    - name: "Delivery Status"
      expr: delivery_status
    - name: "End Date"
      expr: end_date
    - name: "Start Date"
      expr: start_date
    - name: "Trafficking Status"
      expr: trafficking_status
    - name: "Created Date Month"
      expr: DATE_TRUNC('MONTH', created_date)
    - name: "End Date Month"
      expr: DATE_TRUNC('MONTH', end_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Booking"
      expr: COUNT(DISTINCT booking_id)
    - name: "Total Booked Clicks"
      expr: SUM(booked_clicks)
    - name: "Average Booked Clicks"
      expr: AVG(booked_clicks)
    - name: "Total Booked Impressions"
      expr: SUM(booked_impressions)
    - name: "Average Booked Impressions"
      expr: AVG(booked_impressions)
    - name: "Total Rate Amount"
      expr: SUM(rate_amount)
    - name: "Average Rate Amount"
      expr: AVG(rate_amount)
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`campaign_budget_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Budget Allocation business metrics"
  source: "`advertising_ecm`.`campaign`.`budget_allocation`"
  dimensions:
    - name: "Allocation Method"
      expr: allocation_method
    - name: "Allocation Reference"
      expr: allocation_reference
    - name: "Allocation Status"
      expr: allocation_status
    - name: "Auto Optimization Enabled"
      expr: auto_optimization_enabled
    - name: "Budget Period Type"
      expr: budget_period_type
    - name: "Budget Source"
      expr: budget_source
    - name: "Channel Type"
      expr: channel_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Last Reconciliation Date"
      expr: last_reconciliation_date
    - name: "Notes"
      expr: notes
    - name: "Optimization Algorithm Reference"
      expr: optimization_algorithm_reference
    - name: "Over Delivery Action"
      expr: over_delivery_action
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Budget Allocation"
      expr: COUNT(DISTINCT budget_allocation_id)
    - name: "Total Actual Spend"
      expr: SUM(actual_spend)
    - name: "Average Actual Spend"
      expr: AVG(actual_spend)
    - name: "Total Committed Spend"
      expr: SUM(committed_spend)
    - name: "Average Committed Spend"
      expr: AVG(committed_spend)
    - name: "Total Daily Impression Goal"
      expr: SUM(daily_impression_goal)
    - name: "Average Daily Impression Goal"
      expr: AVG(daily_impression_goal)
    - name: "Total Daily Spend Cap"
      expr: SUM(daily_spend_cap)
    - name: "Average Daily Spend Cap"
      expr: AVG(daily_spend_cap)
    - name: "Total Over Delivery Tolerance Pct"
      expr: SUM(over_delivery_tolerance_pct)
    - name: "Average Over Delivery Tolerance Pct"
      expr: AVG(over_delivery_tolerance_pct)
    - name: "Total Pacing Alert Threshold Pct"
      expr: SUM(pacing_alert_threshold_pct)
    - name: "Average Pacing Alert Threshold Pct"
      expr: AVG(pacing_alert_threshold_pct)
    - name: "Total Planned Budget Amount"
      expr: SUM(planned_budget_amount)
    - name: "Average Planned Budget Amount"
      expr: AVG(planned_budget_amount)
    - name: "Total Remaining Budget"
      expr: SUM(remaining_budget)
    - name: "Average Remaining Budget"
      expr: AVG(remaining_budget)
    - name: "Total Revised Budget Amount"
      expr: SUM(revised_budget_amount)
    - name: "Average Revised Budget Amount"
      expr: AVG(revised_budget_amount)
    - name: "Total Under Delivery Tolerance Pct"
      expr: SUM(under_delivery_tolerance_pct)
    - name: "Average Under Delivery Tolerance Pct"
      expr: AVG(under_delivery_tolerance_pct)
    - name: "Total Weekly Impression Goal"
      expr: SUM(weekly_impression_goal)
    - name: "Average Weekly Impression Goal"
      expr: AVG(weekly_impression_goal)
    - name: "Total Weekly Spend Cap"
      expr: SUM(weekly_spend_cap)
    - name: "Average Weekly Spend Cap"
      expr: AVG(weekly_spend_cap)
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`campaign_campaign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Campaign business metrics"
  source: "`advertising_ecm`.`campaign`.`campaign`"
  dimensions:
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved By"
      expr: approved_by
    - name: "Approved Date"
      expr: approved_date
    - name: "Attribution Model"
      expr: attribution_model
    - name: "Brand Safety Level"
      expr: brand_safety_level
    - name: "Brief Reference"
      expr: brief_reference
    - name: "Campaign Code"
      expr: campaign_code
    - name: "Campaign Name"
      expr: campaign_name
    - name: "Campaign Status"
      expr: campaign_status
    - name: "Campaign Tier"
      expr: campaign_tier
    - name: "Campaign Type"
      expr: campaign_type
    - name: "Conversion Window Days"
      expr: conversion_window_days
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Device Targeting"
      expr: device_targeting
    - name: "End Date"
      expr: end_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Campaign"
      expr: COUNT(DISTINCT campaign_id)
    - name: "Total Budget Amount"
      expr: SUM(budget_amount)
    - name: "Average Budget Amount"
      expr: AVG(budget_amount)
    - name: "Total Target Cpa"
      expr: SUM(target_cpa)
    - name: "Average Target Cpa"
      expr: AVG(target_cpa)
    - name: "Total Target Cpm"
      expr: SUM(target_cpm)
    - name: "Average Target Cpm"
      expr: AVG(target_cpm)
    - name: "Total Target Ctr"
      expr: SUM(target_ctr)
    - name: "Average Target Ctr"
      expr: AVG(target_ctr)
    - name: "Total Target Roas"
      expr: SUM(target_roas)
    - name: "Average Target Roas"
      expr: AVG(target_roas)
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`campaign_campaign_brief`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Campaign Brief business metrics"
  source: "`advertising_ecm`.`campaign`.`campaign_brief`"
  dimensions:
    - name: "Agency Lead Email"
      expr: agency_lead_email
    - name: "Agency Lead Name"
      expr: agency_lead_name
    - name: "Approved By Client Flag"
      expr: approved_by_client_flag
    - name: "Brief Number"
      expr: brief_number
    - name: "Brief Status"
      expr: brief_status
    - name: "Budget Currency Code"
      expr: budget_currency_code
    - name: "Channel Preferences"
      expr: channel_preferences
    - name: "Client Approval Date"
      expr: client_approval_date
    - name: "Client Approver Name"
      expr: client_approver_name
    - name: "Competitive Context"
      expr: competitive_context
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Creative Format Requirements"
      expr: creative_format_requirements
    - name: "Geographic Scope"
      expr: geographic_scope
    - name: "Issued Date"
      expr: issued_date
    - name: "Key Message"
      expr: key_message
    - name: "Language Requirements"
      expr: language_requirements
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Campaign Brief"
      expr: COUNT(DISTINCT campaign_brief_id)
    - name: "Total Budget Envelope Amount"
      expr: SUM(budget_envelope_amount)
    - name: "Average Budget Envelope Amount"
      expr: AVG(budget_envelope_amount)
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`campaign_campaign_kpi_target`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Campaign Kpi Target business metrics"
  source: "`advertising_ecm`.`campaign`.`campaign_kpi_target`"
  dimensions:
    - name: "Benchmark Source"
      expr: benchmark_source
    - name: "Channel Scope"
      expr: channel_scope
    - name: "Confidence Level"
      expr: confidence_level
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Geographic Scope"
      expr: geographic_scope
    - name: "Is Primary Kpi"
      expr: is_primary_kpi
    - name: "Kpi Type"
      expr: kpi_type
    - name: "Measurement Methodology"
      expr: measurement_methodology
    - name: "Measurement Source"
      expr: measurement_source
    - name: "Modified By"
      expr: modified_by
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Notes"
      expr: notes
    - name: "Optimization Priority"
      expr: optimization_priority
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Campaign Kpi Target"
      expr: COUNT(DISTINCT campaign_kpi_target_id)
    - name: "Total Alert Threshold Percentage"
      expr: SUM(alert_threshold_percentage)
    - name: "Average Alert Threshold Percentage"
      expr: AVG(alert_threshold_percentage)
    - name: "Total Baseline Value"
      expr: SUM(baseline_value)
    - name: "Average Baseline Value"
      expr: AVG(baseline_value)
    - name: "Total Benchmark Value"
      expr: SUM(benchmark_value)
    - name: "Average Benchmark Value"
      expr: AVG(benchmark_value)
    - name: "Total Stretch Target Value"
      expr: SUM(stretch_target_value)
    - name: "Average Stretch Target Value"
      expr: AVG(stretch_target_value)
    - name: "Total Target Value"
      expr: SUM(target_value)
    - name: "Average Target Value"
      expr: AVG(target_value)
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`campaign_campaign_spokesperson`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Campaign Spokesperson business metrics"
  source: "`advertising_ecm`.`campaign`.`campaign_spokesperson`"
  dimensions:
    - name: "Appearance Count"
      expr: appearance_count
    - name: "Approval Status"
      expr: approval_status
    - name: "Assignment End Date"
      expr: assignment_end_date
    - name: "Assignment Start Date"
      expr: assignment_start_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Media Formats"
      expr: media_formats
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Role In Campaign"
      expr: role_in_campaign
    - name: "Usage Rights Period"
      expr: usage_rights_period
    - name: "Assignment End Date Month"
      expr: DATE_TRUNC('MONTH', assignment_end_date)
    - name: "Assignment Start Date Month"
      expr: DATE_TRUNC('MONTH', assignment_start_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Campaign Spokesperson"
      expr: COUNT(DISTINCT campaign_spokesperson_id)
    - name: "Total Compensation Amount"
      expr: SUM(compensation_amount)
    - name: "Average Compensation Amount"
      expr: AVG(compensation_amount)
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`campaign_competitive_targeting`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Competitive Targeting business metrics"
  source: "`advertising_ecm`.`campaign`.`competitive_targeting`"
  dimensions:
    - name: "Competitive Response Type"
      expr: competitive_response_type
    - name: "Competitive Threat Level"
      expr: competitive_threat_level
    - name: "Counter Strategy Notes"
      expr: counter_strategy_notes
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Monitoring Start Date"
      expr: monitoring_start_date
    - name: "Targeting Status"
      expr: targeting_status
    - name: "Updated Timestamp"
      expr: updated_timestamp
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
    - name: "Monitoring Start Date Month"
      expr: DATE_TRUNC('MONTH', monitoring_start_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Competitive Targeting"
      expr: COUNT(DISTINCT competitive_targeting_id)
    - name: "Total Budget Allocated Vs Competitor"
      expr: SUM(budget_allocated_vs_competitor)
    - name: "Average Budget Allocated Vs Competitor"
      expr: AVG(budget_allocated_vs_competitor)
    - name: "Total Share Of Voice Target Vs Competitor"
      expr: SUM(share_of_voice_target_vs_competitor)
    - name: "Average Share Of Voice Target Vs Competitor"
      expr: AVG(share_of_voice_target_vs_competitor)
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`campaign_creative_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Creative Assignment business metrics"
  source: "`advertising_ecm`.`campaign`.`creative_assignment`"
  dimensions:
    - name: "Assignment Created Date"
      expr: assignment_created_date
    - name: "End Date"
      expr: end_date
    - name: "Last Modified Date"
      expr: last_modified_date
    - name: "Priority Rank"
      expr: priority_rank
    - name: "Start Date"
      expr: start_date
    - name: "Trafficking Status"
      expr: trafficking_status
    - name: "Assignment Created Date Month"
      expr: DATE_TRUNC('MONTH', assignment_created_date)
    - name: "End Date Month"
      expr: DATE_TRUNC('MONTH', end_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Creative Assignment"
      expr: COUNT(DISTINCT creative_assignment_id)
    - name: "Total Click Count"
      expr: SUM(click_count)
    - name: "Average Click Count"
      expr: AVG(click_count)
    - name: "Total Conversion Count"
      expr: SUM(conversion_count)
    - name: "Average Conversion Count"
      expr: AVG(conversion_count)
    - name: "Total Ctr"
      expr: SUM(ctr)
    - name: "Average Ctr"
      expr: AVG(ctr)
    - name: "Total Impression Count"
      expr: SUM(impression_count)
    - name: "Average Impression Count"
      expr: AVG(impression_count)
    - name: "Total Rotation Weight"
      expr: SUM(rotation_weight)
    - name: "Average Rotation Weight"
      expr: AVG(rotation_weight)
    - name: "Total View Count"
      expr: SUM(view_count)
    - name: "Average View Count"
      expr: AVG(view_count)
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`campaign_creative_usage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Creative Usage business metrics"
  source: "`advertising_ecm`.`campaign`.`creative_usage`"
  dimensions:
    - name: "Channel"
      expr: channel
    - name: "Platform"
      expr: platform
    - name: "Usage End Date"
      expr: usage_end_date
    - name: "Usage Start Date"
      expr: usage_start_date
    - name: "Usage Status"
      expr: usage_status
    - name: "Usage Type"
      expr: usage_type
    - name: "Created At Month"
      expr: DATE_TRUNC('MONTH', created_at)
    - name: "Updated At Month"
      expr: DATE_TRUNC('MONTH', updated_at)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Creative Usage"
      expr: COUNT(DISTINCT creative_usage_id)
    - name: "Total Click Count"
      expr: SUM(click_count)
    - name: "Average Click Count"
      expr: AVG(click_count)
    - name: "Total Conversion Count"
      expr: SUM(conversion_count)
    - name: "Average Conversion Count"
      expr: AVG(conversion_count)
    - name: "Total Ctr"
      expr: SUM(ctr)
    - name: "Average Ctr"
      expr: AVG(ctr)
    - name: "Total Impression Count"
      expr: SUM(impression_count)
    - name: "Average Impression Count"
      expr: AVG(impression_count)
    - name: "Total Spend Amount"
      expr: SUM(spend_amount)
    - name: "Average Spend Amount"
      expr: AVG(spend_amount)
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`campaign_flight`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Flight business metrics"
  source: "`advertising_ecm`.`campaign`.`flight`"
  dimensions:
    - name: "Audience Segments"
      expr: audience_segments
    - name: "Budget Currency Code"
      expr: budget_currency_code
    - name: "Channel Mix"
      expr: channel_mix
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Creative Rotation"
      expr: creative_rotation
    - name: "Daypart Restrictions"
      expr: daypart_restrictions
    - name: "Device Targeting"
      expr: device_targeting
    - name: "End Date"
      expr: end_date
    - name: "Flight Code"
      expr: flight_code
    - name: "Flight Name"
      expr: flight_name
    - name: "Flight Status"
      expr: flight_status
    - name: "Frequency Cap"
      expr: frequency_cap
    - name: "Frequency Cap Period"
      expr: frequency_cap_period
    - name: "Geo Targeting"
      expr: geo_targeting
    - name: "Modified By"
      expr: modified_by
    - name: "Modified Timestamp"
      expr: modified_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Flight"
      expr: COUNT(DISTINCT flight_id)
    - name: "Total Budget Allocated"
      expr: SUM(budget_allocated)
    - name: "Average Budget Allocated"
      expr: AVG(budget_allocated)
    - name: "Total Target Frequency"
      expr: SUM(target_frequency)
    - name: "Average Target Frequency"
      expr: AVG(target_frequency)
    - name: "Total Target Grp"
      expr: SUM(target_grp)
    - name: "Average Target Grp"
      expr: AVG(target_grp)
    - name: "Total Target Impressions"
      expr: SUM(target_impressions)
    - name: "Average Target Impressions"
      expr: AVG(target_impressions)
    - name: "Total Target Reach"
      expr: SUM(target_reach)
    - name: "Average Target Reach"
      expr: AVG(target_reach)
    - name: "Total Target Trp"
      expr: SUM(target_trp)
    - name: "Average Target Trp"
      expr: AVG(target_trp)
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`campaign_line_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line Item business metrics"
  source: "`advertising_ecm`.`campaign`.`line_item`"
  dimensions:
    - name: "Ad Format"
      expr: ad_format
    - name: "Brand Safety Tier"
      expr: brand_safety_tier
    - name: "Channel Type"
      expr: channel_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Creative Assignment Status"
      expr: creative_assignment_status
    - name: "Currency Code"
      expr: currency_code
    - name: "Delivery Status"
      expr: delivery_status
    - name: "End Date"
      expr: end_date
    - name: "Frequency Cap Impressions"
      expr: frequency_cap_impressions
    - name: "Frequency Cap Period"
      expr: frequency_cap_period
    - name: "Is Programmatic"
      expr: is_programmatic
    - name: "Line Item Code"
      expr: line_item_code
    - name: "Line Item Name"
      expr: line_item_name
    - name: "Line Sequence"
      expr: line_sequence
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Pacing Status"
      expr: pacing_status
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Line Item"
      expr: COUNT(DISTINCT line_item_id)
    - name: "Total Agency Commission Rate"
      expr: SUM(agency_commission_rate)
    - name: "Average Agency Commission Rate"
      expr: AVG(agency_commission_rate)
    - name: "Total Booked Clicks"
      expr: SUM(booked_clicks)
    - name: "Average Booked Clicks"
      expr: AVG(booked_clicks)
    - name: "Total Booked Conversions"
      expr: SUM(booked_conversions)
    - name: "Average Booked Conversions"
      expr: AVG(booked_conversions)
    - name: "Total Booked Impressions"
      expr: SUM(booked_impressions)
    - name: "Average Booked Impressions"
      expr: AVG(booked_impressions)
    - name: "Total Booked Views"
      expr: SUM(booked_views)
    - name: "Average Booked Views"
      expr: AVG(booked_views)
    - name: "Total Gross Cost"
      expr: SUM(gross_cost)
    - name: "Average Gross Cost"
      expr: AVG(gross_cost)
    - name: "Total Net Cost"
      expr: SUM(net_cost)
    - name: "Average Net Cost"
      expr: AVG(net_cost)
    - name: "Total Rate Amount"
      expr: SUM(rate_amount)
    - name: "Average Rate Amount"
      expr: AVG(rate_amount)
    - name: "Total Viewability Target Percentage"
      expr: SUM(viewability_target_percentage)
    - name: "Average Viewability Target Percentage"
      expr: AVG(viewability_target_percentage)
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`campaign_optimization_algorithm`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Optimization Algorithm business metrics"
  source: "`advertising_ecm`.`campaign`.`optimization_algorithm`"
  dimensions:
    - name: "Algorithm Category"
      expr: algorithm_category
    - name: "Algorithm Code"
      expr: algorithm_code
    - name: "Algorithm Name"
      expr: algorithm_name
    - name: "Algorithm Type"
      expr: algorithm_type
    - name: "Applicable Channels"
      expr: applicable_channels
    - name: "Applicable Formats"
      expr: applicable_formats
    - name: "Created By User"
      expr: created_by_user
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Deprecation Reason"
      expr: deprecation_reason
    - name: "Description"
      expr: optimization_algorithm_description
    - name: "Documentation Url"
      expr: documentation_url
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Is Proprietary"
      expr: is_proprietary
    - name: "License Type"
      expr: license_type
    - name: "Lookback Window Hours"
      expr: lookback_window_hours
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Optimization Algorithm"
      expr: COUNT(DISTINCT optimization_algorithm_id)
    - name: "Total Average Performance Lift Percent"
      expr: SUM(average_performance_lift_percent)
    - name: "Average Average Performance Lift Percent"
      expr: AVG(average_performance_lift_percent)
    - name: "Total Confidence Threshold"
      expr: SUM(confidence_threshold)
    - name: "Average Confidence Threshold"
      expr: AVG(confidence_threshold)
    - name: "Total Cost Per Use"
      expr: SUM(cost_per_use)
    - name: "Average Cost Per Use"
      expr: AVG(cost_per_use)
    - name: "Total Learning Rate"
      expr: SUM(learning_rate)
    - name: "Average Learning Rate"
      expr: AVG(learning_rate)
    - name: "Total Minimum Budget Amount"
      expr: SUM(minimum_budget_amount)
    - name: "Average Minimum Budget Amount"
      expr: AVG(minimum_budget_amount)
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`campaign_optimization_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Optimization Event business metrics"
  source: "`advertising_ecm`.`campaign`.`optimization_event`"
  dimensions:
    - name: "Actual Impact"
      expr: actual_impact
    - name: "Affected Entity Count"
      expr: affected_entity_count
    - name: "Approval Required Flag"
      expr: approval_required_flag
    - name: "Approval Timestamp"
      expr: approval_timestamp
    - name: "Client Visible Flag"
      expr: client_visible_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Expected Impact"
      expr: expected_impact
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Notes"
      expr: notes
    - name: "Optimization Scope"
      expr: optimization_scope
    - name: "Optimization Status"
      expr: optimization_status
    - name: "Optimization Timestamp"
      expr: optimization_timestamp
    - name: "Optimization Type"
      expr: optimization_type
    - name: "Performed By System"
      expr: performed_by_system
    - name: "Priority Level"
      expr: priority_level
    - name: "Rollback Flag"
      expr: rollback_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Optimization Event"
      expr: COUNT(DISTINCT optimization_event_id)
    - name: "Total Confidence Score"
      expr: SUM(confidence_score)
    - name: "Average Confidence Score"
      expr: AVG(confidence_score)
    - name: "Total New Value"
      expr: SUM(new_value)
    - name: "Average New Value"
      expr: AVG(new_value)
    - name: "Total Previous Value"
      expr: SUM(previous_value)
    - name: "Average Previous Value"
      expr: AVG(previous_value)
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`campaign_optimization_rule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Optimization Rule business metrics"
  source: "`advertising_ecm`.`campaign`.`optimization_rule`"
  dimensions:
    - name: "Action Type"
      expr: action_type
    - name: "Action Unit"
      expr: action_unit
    - name: "Applies To Scope"
      expr: applies_to_scope
    - name: "Auto Apply"
      expr: auto_apply
    - name: "Channel Filter"
      expr: channel_filter
    - name: "Condition Logic"
      expr: condition_logic
    - name: "Cooldown Period Hours"
      expr: cooldown_period_hours
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Days Of Week"
      expr: days_of_week
    - name: "Description"
      expr: optimization_rule_description
    - name: "Device Filter"
      expr: device_filter
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Evaluation Window Hours"
      expr: evaluation_window_hours
    - name: "Execution Count"
      expr: execution_count
    - name: "Execution Frequency"
      expr: execution_frequency
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Optimization Rule"
      expr: COUNT(DISTINCT optimization_rule_id)
    - name: "Total Action Value"
      expr: SUM(action_value)
    - name: "Average Action Value"
      expr: AVG(action_value)
    - name: "Total Threshold Value"
      expr: SUM(threshold_value)
    - name: "Average Threshold Value"
      expr: AVG(threshold_value)
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`campaign_pacing_rule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pacing Rule business metrics"
  source: "`advertising_ecm`.`campaign`.`pacing_rule`"
  dimensions:
    - name: "Auto Optimization Enabled"
      expr: auto_optimization_enabled
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Custom Curve Definition"
      expr: custom_curve_definition
    - name: "Dayparting Enabled"
      expr: dayparting_enabled
    - name: "Dayparting Schedule"
      expr: dayparting_schedule
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Notes"
      expr: notes
    - name: "Over Delivery Action"
      expr: over_delivery_action
    - name: "Pacing Check Frequency"
      expr: pacing_check_frequency
    - name: "Pacing Status"
      expr: pacing_status
    - name: "Pacing Type"
      expr: pacing_type
    - name: "Parent Entity Type"
      expr: parent_entity_type
    - name: "Priority Level"
      expr: priority_level
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Pacing Rule"
      expr: COUNT(DISTINCT pacing_rule_id)
    - name: "Total Daily Impression Goal"
      expr: SUM(daily_impression_goal)
    - name: "Average Daily Impression Goal"
      expr: AVG(daily_impression_goal)
    - name: "Total Daily Spend Cap"
      expr: SUM(daily_spend_cap)
    - name: "Average Daily Spend Cap"
      expr: AVG(daily_spend_cap)
    - name: "Total Pacing Alert Threshold Pct"
      expr: SUM(pacing_alert_threshold_pct)
    - name: "Average Pacing Alert Threshold Pct"
      expr: AVG(pacing_alert_threshold_pct)
    - name: "Total Weekly Impression Goal"
      expr: SUM(weekly_impression_goal)
    - name: "Average Weekly Impression Goal"
      expr: AVG(weekly_impression_goal)
    - name: "Total Weekly Spend Cap"
      expr: SUM(weekly_spend_cap)
    - name: "Average Weekly Spend Cap"
      expr: AVG(weekly_spend_cap)
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`campaign_status_history`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Status History business metrics"
  source: "`advertising_ecm`.`campaign`.`status_history`"
  dimensions:
    - name: "Approval Required Flag"
      expr: approval_required_flag
    - name: "Changed By System"
      expr: changed_by_system
    - name: "Changed By User Name"
      expr: changed_by_user_name
    - name: "Client Visible Flag"
      expr: client_visible_flag
    - name: "Compliance Review Completed Flag"
      expr: compliance_review_completed_flag
    - name: "Compliance Review Required Flag"
      expr: compliance_review_required_flag
    - name: "Effective Date"
      expr: effective_date
    - name: "Ip Address"
      expr: ip_address
    - name: "New Status"
      expr: new_status
    - name: "Notes"
      expr: notes
    - name: "Notification Sent Flag"
      expr: notification_sent_flag
    - name: "Notification Timestamp"
      expr: notification_timestamp
    - name: "Previous Status"
      expr: previous_status
    - name: "Record Created Timestamp"
      expr: record_created_timestamp
    - name: "Rollback Flag"
      expr: rollback_flag
    - name: "Rollback Reason"
      expr: rollback_reason
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Status History"
      expr: COUNT(DISTINCT status_history_id)
    - name: "Total Duration In Previous Status Hours"
      expr: SUM(duration_in_previous_status_hours)
    - name: "Average Duration In Previous Status Hours"
      expr: AVG(duration_in_previous_status_hours)
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`campaign_targeting_rule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Targeting Rule business metrics"
  source: "`advertising_ecm`.`campaign`.`targeting_rule`"
  dimensions:
    - name: "Brand Safety Tier"
      expr: brand_safety_tier
    - name: "Browser Type"
      expr: browser_type
    - name: "Ccpa Opt Out Flag"
      expr: ccpa_opt_out_flag
    - name: "Connection Type"
      expr: connection_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Source"
      expr: data_source
    - name: "Daypart Schedule"
      expr: daypart_schedule
    - name: "Device Type"
      expr: device_type
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Frequency Cap Limit"
      expr: frequency_cap_limit
    - name: "Frequency Cap Unit"
      expr: frequency_cap_unit
    - name: "Frequency Cap Window"
      expr: frequency_cap_window
    - name: "Gdpr Consent Required"
      expr: gdpr_consent_required
    - name: "Geo Level"
      expr: geo_level
    - name: "Is Active"
      expr: is_active
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Targeting Rule"
      expr: COUNT(DISTINCT targeting_rule_id)
    - name: "Total Fraud Prevention Threshold"
      expr: SUM(fraud_prevention_threshold)
    - name: "Average Fraud Prevention Threshold"
      expr: AVG(fraud_prevention_threshold)
    - name: "Total Targeting Value"
      expr: SUM(targeting_value)
    - name: "Average Targeting Value"
      expr: AVG(targeting_value)
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`campaign_trafficking_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Trafficking Order business metrics"
  source: "`advertising_ecm`.`campaign`.`trafficking_order`"
  dimensions:
    - name: "Actual Live Timestamp"
      expr: actual_live_timestamp
    - name: "Ad Server Order Code"
      expr: ad_server_order_code
    - name: "Ad Server Platform"
      expr: ad_server_platform
    - name: "Ads Trafficked Count"
      expr: ads_trafficked_count
    - name: "Completion Timestamp"
      expr: completion_timestamp
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Go Live Date"
      expr: go_live_date
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Line Items Trafficked Count"
      expr: line_items_trafficked_count
    - name: "Pixel Firing Validation Status"
      expr: pixel_firing_validation_status
    - name: "Priority Level"
      expr: priority_level
    - name: "Qa Completed Timestamp"
      expr: qa_completed_timestamp
    - name: "Qa Status"
      expr: qa_status
    - name: "Rejection Reason"
      expr: rejection_reason
    - name: "Revision Number"
      expr: revision_number
    - name: "Sla Met Flag"
      expr: sla_met_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Trafficking Order"
      expr: COUNT(DISTINCT trafficking_order_id)
$$;
