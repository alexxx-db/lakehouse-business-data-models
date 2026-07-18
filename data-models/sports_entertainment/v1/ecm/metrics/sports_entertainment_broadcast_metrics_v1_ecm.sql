-- Metric views for domain: broadcast | Business: Sports Entertainment | Version: 1 | Generated on: 2026-05-09 01:40:32

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`broadcast_ad_placement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ad Placement business metrics"
  source: "`sports_entertainment_ecm`.`broadcast`.`ad_placement`"
  dimensions:
    - name: "Actual Duration Seconds"
      expr: actual_duration_seconds
    - name: "Ad Break Position"
      expr: ad_break_position
    - name: "Ad Server Confirmation Code"
      expr: ad_server_confirmation_code
    - name: "Audience Demographic Target"
      expr: audience_demographic_target
    - name: "Blackout Applied"
      expr: blackout_applied
    - name: "Cdn Delivery Profile"
      expr: cdn_delivery_profile
    - name: "Competitive Separation Flag"
      expr: competitive_separation_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Drm Policy Applied"
      expr: drm_policy_applied
    - name: "Language Code"
      expr: language_code
    - name: "Make Good Flag"
      expr: make_good_flag
    - name: "Placement Datetime"
      expr: placement_datetime
    - name: "Placement End Datetime"
      expr: placement_end_datetime
    - name: "Placement Reference Code"
      expr: placement_reference_code
    - name: "Placement Status"
      expr: placement_status
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Ad Placement"
      expr: COUNT(DISTINCT ad_placement_id)
    - name: "Total Agency Commission Amount"
      expr: SUM(agency_commission_amount)
    - name: "Average Agency Commission Amount"
      expr: AVG(agency_commission_amount)
    - name: "Total Cpm Achieved"
      expr: SUM(cpm_achieved)
    - name: "Average Cpm Achieved"
      expr: AVG(cpm_achieved)
    - name: "Total Cpm Contracted"
      expr: SUM(cpm_contracted)
    - name: "Average Cpm Contracted"
      expr: AVG(cpm_contracted)
    - name: "Total Gross Revenue Amount"
      expr: SUM(gross_revenue_amount)
    - name: "Average Gross Revenue Amount"
      expr: AVG(gross_revenue_amount)
    - name: "Total Grp Delivered"
      expr: SUM(grp_delivered)
    - name: "Average Grp Delivered"
      expr: AVG(grp_delivered)
    - name: "Total Impressions Delivered"
      expr: SUM(impressions_delivered)
    - name: "Average Impressions Delivered"
      expr: AVG(impressions_delivered)
    - name: "Total Net Revenue Amount"
      expr: SUM(net_revenue_amount)
    - name: "Average Net Revenue Amount"
      expr: AVG(net_revenue_amount)
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`broadcast_audience_rating`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Audience Rating business metrics"
  source: "`sports_entertainment_ecm`.`broadcast`.`audience_rating`"
  dimensions:
    - name: "Blackout Applied"
      expr: blackout_applied
    - name: "Broadcast Date"
      expr: broadcast_date
    - name: "Content Genre"
      expr: content_genre
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Demo Age Band"
      expr: demo_age_band
    - name: "Demo Gender"
      expr: demo_gender
    - name: "Demo Income Band"
      expr: demo_income_band
    - name: "Drm Protected"
      expr: drm_protected
    - name: "Guarantee Met"
      expr: guarantee_met
    - name: "Market Name"
      expr: market_name
    - name: "Measurement Methodology"
      expr: measurement_methodology
    - name: "Measurement Reference Code"
      expr: measurement_reference_code
    - name: "Measurement Source"
      expr: measurement_source
    - name: "Measurement Status"
      expr: measurement_status
    - name: "Rating Type"
      expr: rating_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Audience Rating"
      expr: COUNT(DISTINCT audience_rating_id)
    - name: "Total Ama Viewers"
      expr: SUM(ama_viewers)
    - name: "Average Ama Viewers"
      expr: AVG(ama_viewers)
    - name: "Total Audience Guarantee Target"
      expr: SUM(audience_guarantee_target)
    - name: "Average Audience Guarantee Target"
      expr: AVG(audience_guarantee_target)
    - name: "Total Avg Viewing Duration Mins"
      expr: SUM(avg_viewing_duration_mins)
    - name: "Average Avg Viewing Duration Mins"
      expr: AVG(avg_viewing_duration_mins)
    - name: "Total Cpm Rate"
      expr: SUM(cpm_rate)
    - name: "Average Cpm Rate"
      expr: AVG(cpm_rate)
    - name: "Total Demo Viewers Count"
      expr: SUM(demo_viewers_count)
    - name: "Average Demo Viewers Count"
      expr: AVG(demo_viewers_count)
    - name: "Total Frequency"
      expr: SUM(frequency)
    - name: "Average Frequency"
      expr: AVG(frequency)
    - name: "Total Grp Value"
      expr: SUM(grp_value)
    - name: "Average Grp Value"
      expr: AVG(grp_value)
    - name: "Total Live Viewers"
      expr: SUM(live_viewers)
    - name: "Average Live Viewers"
      expr: AVG(live_viewers)
    - name: "Total Peak Concurrent Viewers"
      expr: SUM(peak_concurrent_viewers)
    - name: "Average Peak Concurrent Viewers"
      expr: AVG(peak_concurrent_viewers)
    - name: "Total Rating Pct"
      expr: SUM(rating_pct)
    - name: "Average Rating Pct"
      expr: AVG(rating_pct)
    - name: "Total Reach"
      expr: SUM(reach)
    - name: "Average Reach"
      expr: AVG(reach)
    - name: "Total Share Pct"
      expr: SUM(share_pct)
    - name: "Average Share Pct"
      expr: AVG(share_pct)
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`broadcast_blackout_rule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Blackout Rule business metrics"
  source: "`sports_entertainment_ecm`.`broadcast`.`blackout_rule`"
  dimensions:
    - name: "Applies To Highlights"
      expr: applies_to_highlights
    - name: "Applies To Replay"
      expr: applies_to_replay
    - name: "Approval Date"
      expr: approval_date
    - name: "Approved By"
      expr: approved_by
    - name: "Blackout Lift Condition"
      expr: blackout_lift_condition
    - name: "Blackout Type"
      expr: blackout_type
    - name: "Blackout Window Hours"
      expr: blackout_window_hours
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Distribution Platform"
      expr: distribution_platform
    - name: "Effective From"
      expr: effective_from
    - name: "Effective Until"
      expr: effective_until
    - name: "Enforcement Mechanism"
      expr: enforcement_mechanism
    - name: "Geo Precision Level"
      expr: geo_precision_level
    - name: "Last Reviewed Date"
      expr: last_reviewed_date
    - name: "League Code"
      expr: league_code
    - name: "Mandate Source"
      expr: mandate_source
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Blackout Rule"
      expr: COUNT(DISTINCT blackout_rule_id)
    - name: "Total Ticket Sales Threshold Pct"
      expr: SUM(ticket_sales_threshold_pct)
    - name: "Average Ticket Sales Threshold Pct"
      expr: AVG(ticket_sales_threshold_pct)
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`broadcast_broadcast_ad_inventory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Broadcast Ad Inventory business metrics"
  source: "`sports_entertainment_ecm`.`broadcast`.`broadcast_ad_inventory`"
  dimensions:
    - name: "Actual Air Timestamp"
      expr: actual_air_timestamp
    - name: "Ad Category"
      expr: ad_category
    - name: "Audience Demographic Target"
      expr: audience_demographic_target
    - name: "Blackout Applicable"
      expr: blackout_applicable
    - name: "Break Number"
      expr: break_number
    - name: "Cdn Delivery Endpoint"
      expr: cdn_delivery_endpoint
    - name: "Content Rating"
      expr: content_rating
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Is Makegood"
      expr: is_makegood
    - name: "Is Programmatic"
      expr: is_programmatic
    - name: "Is Sold"
      expr: is_sold
    - name: "Is Sponsorship Exclusive"
      expr: is_sponsorship_exclusive
    - name: "Market Region"
      expr: market_region
    - name: "Notes"
      expr: notes
    - name: "Order Reference Number"
      expr: order_reference_number
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Broadcast Ad Inventory"
      expr: COUNT(DISTINCT broadcast_ad_inventory_id)
    - name: "Total Actual Cpm Achieved"
      expr: SUM(actual_cpm_achieved)
    - name: "Average Actual Cpm Achieved"
      expr: AVG(actual_cpm_achieved)
    - name: "Total Agency Commission Pct"
      expr: SUM(agency_commission_pct)
    - name: "Average Agency Commission Pct"
      expr: AVG(agency_commission_pct)
    - name: "Total Cpm Floor Rate"
      expr: SUM(cpm_floor_rate)
    - name: "Average Cpm Floor Rate"
      expr: AVG(cpm_floor_rate)
    - name: "Total Gross Revenue Amount"
      expr: SUM(gross_revenue_amount)
    - name: "Average Gross Revenue Amount"
      expr: AVG(gross_revenue_amount)
    - name: "Total Grp Value"
      expr: SUM(grp_value)
    - name: "Average Grp Value"
      expr: AVG(grp_value)
    - name: "Total Impressions Delivered"
      expr: SUM(impressions_delivered)
    - name: "Average Impressions Delivered"
      expr: AVG(impressions_delivered)
    - name: "Total Impressions Guaranteed"
      expr: SUM(impressions_guaranteed)
    - name: "Average Impressions Guaranteed"
      expr: AVG(impressions_guaranteed)
    - name: "Total Net Revenue Amount"
      expr: SUM(net_revenue_amount)
    - name: "Average Net Revenue Amount"
      expr: AVG(net_revenue_amount)
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`broadcast_broadcast_drm_policy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Broadcast Drm Policy business metrics"
  source: "`sports_entertainment_ecm`.`broadcast`.`broadcast_drm_policy`"
  dimensions:
    - name: "Analytics Tracking Enabled"
      expr: analytics_tracking_enabled
    - name: "Approved By"
      expr: approved_by
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Blackout Rule Enabled"
      expr: blackout_rule_enabled
    - name: "Cdn Profile Code"
      expr: cdn_profile_code
    - name: "Compliance Standard"
      expr: compliance_standard
    - name: "Concurrent Stream Limit"
      expr: concurrent_stream_limit
    - name: "Content Tier"
      expr: content_tier
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Device Authentication Required"
      expr: device_authentication_required
    - name: "Download Permitted"
      expr: download_permitted
    - name: "Drm Technology"
      expr: drm_technology
    - name: "Effective From"
      expr: effective_from
    - name: "Effective Until"
      expr: effective_until
    - name: "Encryption Standard"
      expr: encryption_standard
    - name: "Geo Blocked Territories"
      expr: geo_blocked_territories
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Broadcast Drm Policy"
      expr: COUNT(DISTINCT broadcast_drm_policy_id)
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`broadcast_broadcast_rights_window`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Broadcast Rights Window business metrics"
  source: "`sports_entertainment_ecm`.`broadcast`.`broadcast_rights_window`"
  dimensions:
    - name: "Advertising Rights Included"
      expr: advertising_rights_included
    - name: "Blackout Applicable"
      expr: blackout_applicable
    - name: "Broadcast Window Type"
      expr: broadcast_window_type
    - name: "Catchup Window Days"
      expr: catchup_window_days
    - name: "Concurrent Stream Limit"
      expr: concurrent_stream_limit
    - name: "Conflict Resolution Status"
      expr: conflict_resolution_status
    - name: "Content Type"
      expr: content_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective From"
      expr: effective_from
    - name: "Effective Until"
      expr: effective_until
    - name: "Exclusivity Flag"
      expr: exclusivity_flag
    - name: "Language Code"
      expr: language_code
    - name: "Max Broadcast Count"
      expr: max_broadcast_count
    - name: "Min Lead Time Hours"
      expr: min_lead_time_hours
    - name: "Notes"
      expr: notes
    - name: "Payment Schedule Type"
      expr: payment_schedule_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Broadcast Rights Window"
      expr: COUNT(DISTINCT broadcast_rights_window_id)
    - name: "Total Revenue Share Pct"
      expr: SUM(revenue_share_pct)
    - name: "Average Revenue Share Pct"
      expr: AVG(revenue_share_pct)
    - name: "Total Rights Fee Allocation Pct"
      expr: SUM(rights_fee_allocation_pct)
    - name: "Average Rights Fee Allocation Pct"
      expr: AVG(rights_fee_allocation_pct)
    - name: "Total Rights Fee Amount"
      expr: SUM(rights_fee_amount)
    - name: "Average Rights Fee Amount"
      expr: AVG(rights_fee_amount)
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`broadcast_broadcast_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Broadcast Schedule business metrics"
  source: "`sports_entertainment_ecm`.`broadcast`.`broadcast_schedule`"
  dimensions:
    - name: "Actual End Time"
      expr: actual_end_time
    - name: "Actual Start Time"
      expr: actual_start_time
    - name: "Ad Break Count"
      expr: ad_break_count
    - name: "Ad Break Duration Minutes"
      expr: ad_break_duration_minutes
    - name: "Air Date"
      expr: air_date
    - name: "Audio Description Required"
      expr: audio_description_required
    - name: "Blackout Applicable"
      expr: blackout_applicable
    - name: "Broadcast Type"
      expr: broadcast_type
    - name: "Cdn Profile Code"
      expr: cdn_profile_code
    - name: "Closed Caption Required"
      expr: closed_caption_required
    - name: "Commentary Language Code"
      expr: commentary_language_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Feed Format"
      expr: feed_format
    - name: "International Feed"
      expr: international_feed
    - name: "Language Code"
      expr: language_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Broadcast Schedule"
      expr: COUNT(DISTINCT broadcast_schedule_id)
    - name: "Total Ppv Price"
      expr: SUM(ppv_price)
    - name: "Average Ppv Price"
      expr: AVG(ppv_price)
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`broadcast_channel`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Channel business metrics"
  source: "`sports_entertainment_ecm`.`broadcast`.`channel`"
  dimensions:
    - name: "Ad Insertion Enabled"
      expr: ad_insertion_enabled
    - name: "Audio Format"
      expr: audio_format
    - name: "Bitrate Kbps"
      expr: bitrate_kbps
    - name: "Blackout Rule Code"
      expr: blackout_rule_code
    - name: "Broadcast Format"
      expr: broadcast_format
    - name: "Channel Code"
      expr: channel_code
    - name: "Channel Name"
      expr: channel_name
    - name: "Channel Number"
      expr: channel_number
    - name: "Channel Status"
      expr: channel_status
    - name: "Channel Type"
      expr: channel_type
    - name: "Closed Caption Supported"
      expr: closed_caption_supported
    - name: "Content Category"
      expr: content_category
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Decommission Date"
      expr: decommission_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Channel"
      expr: COUNT(DISTINCT channel_id)
    - name: "Total Frame Rate"
      expr: SUM(frame_rate)
    - name: "Average Frame Rate"
      expr: AVG(frame_rate)
    - name: "Total Monthly Rights Fee"
      expr: SUM(monthly_rights_fee)
    - name: "Average Monthly Rights Fee"
      expr: AVG(monthly_rights_fee)
    - name: "Total Revenue Share Pct"
      expr: SUM(revenue_share_pct)
    - name: "Average Revenue Share Pct"
      expr: AVG(revenue_share_pct)
    - name: "Total Subscriber Count"
      expr: SUM(subscriber_count)
    - name: "Average Subscriber Count"
      expr: AVG(subscriber_count)
    - name: "Total Uptime Sla Pct"
      expr: SUM(uptime_sla_pct)
    - name: "Average Uptime Sla Pct"
      expr: AVG(uptime_sla_pct)
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`broadcast_distributor`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Distributor business metrics"
  source: "`sports_entertainment_ecm`.`broadcast`.`distributor`"
  dimensions:
    - name: "Auto Renewal Enabled"
      expr: auto_renewal_enabled
    - name: "Blackout Rules Enabled"
      expr: blackout_rules_enabled
    - name: "Code"
      expr: distributor_code
    - name: "Content Delivery Network"
      expr: content_delivery_network
    - name: "Contract End Date"
      expr: contract_end_date
    - name: "Contract Start Date"
      expr: contract_start_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Distribution Technology"
      expr: distribution_technology
    - name: "Drm Platform"
      expr: drm_platform
    - name: "Headquarters Address Line1"
      expr: headquarters_address_line1
    - name: "Headquarters Address Line2"
      expr: headquarters_address_line2
    - name: "Headquarters City"
      expr: headquarters_city
    - name: "Headquarters Country Code"
      expr: headquarters_country_code
    - name: "Headquarters Postal Code"
      expr: headquarters_postal_code
    - name: "Headquarters State Province"
      expr: headquarters_state_province
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Distributor"
      expr: COUNT(DISTINCT distributor_id)
    - name: "Total Minimum Guarantee Amount"
      expr: SUM(minimum_guarantee_amount)
    - name: "Average Minimum Guarantee Amount"
      expr: AVG(minimum_guarantee_amount)
    - name: "Total Revenue Share Percentage"
      expr: SUM(revenue_share_percentage)
    - name: "Average Revenue Share Percentage"
      expr: AVG(revenue_share_percentage)
    - name: "Total Subscriber Count"
      expr: SUM(subscriber_count)
    - name: "Average Subscriber Count"
      expr: AVG(subscriber_count)
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`broadcast_licensee`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Licensee business metrics"
  source: "`sports_entertainment_ecm`.`broadcast`.`licensee`"
  dimensions:
    - name: "Auto Renewal Enabled"
      expr: auto_renewal_enabled
    - name: "Blackout Rules Applicable"
      expr: blackout_rules_applicable
    - name: "Business Address Line1"
      expr: business_address_line1
    - name: "Business Address Line2"
      expr: business_address_line2
    - name: "Business City"
      expr: business_city
    - name: "Business Country Code"
      expr: business_country_code
    - name: "Business Postal Code"
      expr: business_postal_code
    - name: "Business State Province"
      expr: business_state_province
    - name: "Cdn Provider"
      expr: cdn_provider
    - name: "Compliance Certification Date"
      expr: compliance_certification_date
    - name: "Content Format Supported"
      expr: content_format_supported
    - name: "Contract End Date"
      expr: contract_end_date
    - name: "Contract Start Date"
      expr: contract_start_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Distribution Channel"
      expr: distribution_channel
    - name: "Drm Policy Required"
      expr: drm_policy_required
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Licensee"
      expr: COUNT(DISTINCT licensee_id)
    - name: "Total Credit Limit Amount"
      expr: SUM(credit_limit_amount)
    - name: "Average Credit Limit Amount"
      expr: AVG(credit_limit_amount)
    - name: "Total Subscriber Count"
      expr: SUM(subscriber_count)
    - name: "Average Subscriber Count"
      expr: AVG(subscriber_count)
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`broadcast_live_feed`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Live Feed business metrics"
  source: "`sports_entertainment_ecm`.`broadcast`.`live_feed`"
  dimensions:
    - name: "Actual End Time"
      expr: actual_end_time
    - name: "Actual Start Time"
      expr: actual_start_time
    - name: "Aspect Ratio"
      expr: aspect_ratio
    - name: "Audio Format"
      expr: audio_format
    - name: "Audio Track Count"
      expr: audio_track_count
    - name: "Bitrate Kbps"
      expr: bitrate_kbps
    - name: "Blackout Rule Applied"
      expr: blackout_rule_applied
    - name: "Blackout Territory"
      expr: blackout_territory
    - name: "Cdn Origin Endpoint"
      expr: cdn_origin_endpoint
    - name: "Commentary Language"
      expr: commentary_language
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Distribution Tier"
      expr: distribution_tier
    - name: "Encoding Format"
      expr: encoding_format
    - name: "Failover Activated"
      expr: failover_activated
    - name: "Failover Timestamp"
      expr: failover_timestamp
    - name: "Feed Code"
      expr: feed_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Live Feed"
      expr: COUNT(DISTINCT live_feed_id)
    - name: "Total Frame Rate"
      expr: SUM(frame_rate)
    - name: "Average Frame Rate"
      expr: AVG(frame_rate)
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`broadcast_media_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Media Asset business metrics"
  source: "`sports_entertainment_ecm`.`broadcast`.`media_asset`"
  dimensions:
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Archive Location"
      expr: archive_location
    - name: "Archive Tier"
      expr: archive_tier
    - name: "Aspect Ratio"
      expr: aspect_ratio
    - name: "Asset Status"
      expr: asset_status
    - name: "Asset Type"
      expr: asset_type
    - name: "Audio Channels"
      expr: audio_channels
    - name: "Blackout Rule Applicable"
      expr: blackout_rule_applicable
    - name: "Broadcast Date"
      expr: broadcast_date
    - name: "Cdn Delivery Url"
      expr: cdn_delivery_url
    - name: "Checksum"
      expr: checksum
    - name: "Codec"
      expr: codec
    - name: "Content Rating"
      expr: content_rating
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Distribution Channel"
      expr: distribution_channel
    - name: "Duration Seconds"
      expr: duration_seconds
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Media Asset"
      expr: COUNT(DISTINCT media_asset_id)
    - name: "Total File Size Mb"
      expr: SUM(file_size_mb)
    - name: "Average File Size Mb"
      expr: AVG(file_size_mb)
    - name: "Total Frame Rate"
      expr: SUM(frame_rate)
    - name: "Average Frame Rate"
      expr: AVG(frame_rate)
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`broadcast_media_rights_deal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Media Rights Deal business metrics"
  source: "`sports_entertainment_ecm`.`broadcast`.`media_rights_deal`"
  dimensions:
    - name: "Blackout Rules Applicable"
      expr: blackout_rules_applicable
    - name: "Blackout Territory Codes"
      expr: blackout_territory_codes
    - name: "Cdn Provider Name"
      expr: cdn_provider_name
    - name: "Currency Code"
      expr: currency_code
    - name: "Dalet Contract Ref"
      expr: dalet_contract_ref
    - name: "Data Privacy Compliance Flag"
      expr: data_privacy_compliance_flag
    - name: "Deal Created Timestamp"
      expr: deal_created_timestamp
    - name: "Deal Name"
      expr: deal_name
    - name: "Deal Number"
      expr: deal_number
    - name: "Deal Status"
      expr: deal_status
    - name: "Deal Type"
      expr: deal_type
    - name: "Deal Updated Timestamp"
      expr: deal_updated_timestamp
    - name: "Digital Streaming Rights Included"
      expr: digital_streaming_rights_included
    - name: "Dispute Resolution Mechanism"
      expr: dispute_resolution_mechanism
    - name: "Effective Date"
      expr: effective_date
    - name: "Exclusivity Type"
      expr: exclusivity_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Media Rights Deal"
      expr: COUNT(DISTINCT media_rights_deal_id)
    - name: "Total Annual Rights Fee Usd"
      expr: SUM(annual_rights_fee_usd)
    - name: "Average Annual Rights Fee Usd"
      expr: AVG(annual_rights_fee_usd)
    - name: "Total Deal Value Usd"
      expr: SUM(deal_value_usd)
    - name: "Average Deal Value Usd"
      expr: AVG(deal_value_usd)
    - name: "Total Revenue Share Pct"
      expr: SUM(revenue_share_pct)
    - name: "Average Revenue Share Pct"
      expr: AVG(revenue_share_pct)
    - name: "Total Rsn Affiliate Code"
      expr: SUM(rsn_affiliate_code)
    - name: "Average Rsn Affiliate Code"
      expr: AVG(rsn_affiliate_code)
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`broadcast_platform_rights_grant`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Platform Rights Grant business metrics"
  source: "`sports_entertainment_ecm`.`broadcast`.`platform_rights_grant`"
  dimensions:
    - name: "Effective From"
      expr: effective_from
    - name: "Effective Until"
      expr: effective_until
    - name: "Exclusivity Flag"
      expr: exclusivity_flag
    - name: "Grant Status"
      expr: grant_status
    - name: "Platform Rights Type"
      expr: platform_rights_type
    - name: "Territory Code"
      expr: territory_code
    - name: "Effective From Month"
      expr: DATE_TRUNC('MONTH', effective_from)
    - name: "Effective Until Month"
      expr: DATE_TRUNC('MONTH', effective_until)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Platform Rights Grant"
      expr: COUNT(DISTINCT platform_rights_grant_id)
    - name: "Total Revenue Share Pct"
      expr: SUM(revenue_share_pct)
    - name: "Average Revenue Share Pct"
      expr: AVG(revenue_share_pct)
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`broadcast_ppv_package`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ppv Package business metrics"
  source: "`sports_entertainment_ecm`.`broadcast`.`ppv_package`"
  dimensions:
    - name: "Approved By"
      expr: approved_by
    - name: "Approved Date"
      expr: approved_date
    - name: "Blackout Rule Code"
      expr: blackout_rule_code
    - name: "Broadcast Language Code"
      expr: broadcast_language_code
    - name: "Bundle Description"
      expr: bundle_description
    - name: "Bundle Flag"
      expr: bundle_flag
    - name: "Cdn Profile Code"
      expr: cdn_profile_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Distribution Window End"
      expr: distribution_window_end
    - name: "Distribution Window Start"
      expr: distribution_window_start
    - name: "Is Ppv Exclusive"
      expr: is_ppv_exclusive
    - name: "League Or Org Code"
      expr: league_or_org_code
    - name: "Max Concurrent Streams"
      expr: max_concurrent_streams
    - name: "Max Purchase Capacity"
      expr: max_purchase_capacity
    - name: "Package Code"
      expr: package_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Ppv Package"
      expr: COUNT(DISTINCT ppv_package_id)
    - name: "Total Consumer Price"
      expr: SUM(consumer_price)
    - name: "Average Consumer Price"
      expr: AVG(consumer_price)
    - name: "Total International Price"
      expr: SUM(international_price)
    - name: "Average International Price"
      expr: AVG(international_price)
    - name: "Total Promotional Discount Pct"
      expr: SUM(promotional_discount_pct)
    - name: "Average Promotional Discount Pct"
      expr: AVG(promotional_discount_pct)
    - name: "Total Revenue Share Pct"
      expr: SUM(revenue_share_pct)
    - name: "Average Revenue Share Pct"
      expr: AVG(revenue_share_pct)
    - name: "Total Wholesale Price"
      expr: SUM(wholesale_price)
    - name: "Average Wholesale Price"
      expr: AVG(wholesale_price)
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`broadcast_ppv_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ppv Transaction business metrics"
  source: "`sports_entertainment_ecm`.`broadcast`.`ppv_transaction`"
  dimensions:
    - name: "Access Token"
      expr: access_token
    - name: "Access Token Expiry"
      expr: access_token_expiry
    - name: "Access Window Hours"
      expr: access_window_hours
    - name: "Arpu Segment"
      expr: arpu_segment
    - name: "Blackout Applied"
      expr: blackout_applied
    - name: "Buyer Type"
      expr: buyer_type
    - name: "Cdn Provider"
      expr: cdn_provider
    - name: "Concurrent Stream Limit"
      expr: concurrent_stream_limit
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Device Code"
      expr: device_code
    - name: "Fulfillment Status"
      expr: fulfillment_status
    - name: "Gdpr Consent Flag"
      expr: gdpr_consent_flag
    - name: "Geo Country Code"
      expr: geo_country_code
    - name: "Ip Address"
      expr: ip_address
    - name: "Is Replay Purchase"
      expr: is_replay_purchase
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Ppv Transaction"
      expr: COUNT(DISTINCT ppv_transaction_id)
    - name: "Total Discount Amount"
      expr: SUM(discount_amount)
    - name: "Average Discount Amount"
      expr: AVG(discount_amount)
    - name: "Total Gross Amount"
      expr: SUM(gross_amount)
    - name: "Average Gross Amount"
      expr: AVG(gross_amount)
    - name: "Total Net Amount"
      expr: SUM(net_amount)
    - name: "Average Net Amount"
      expr: AVG(net_amount)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`broadcast_production`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Production business metrics"
  source: "`sports_entertainment_ecm`.`broadcast`.`production`"
  dimensions:
    - name: "Actual End Timestamp"
      expr: actual_end_timestamp
    - name: "Actual Start Timestamp"
      expr: actual_start_timestamp
    - name: "Broadcast Language"
      expr: broadcast_language
    - name: "Cdn Origin Endpoint"
      expr: cdn_origin_endpoint
    - name: "Color Analyst Name"
      expr: color_analyst_name
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Distribution Platform"
      expr: distribution_platform
    - name: "Equipment Manifest Reference"
      expr: equipment_manifest_reference
    - name: "Graphics Package Version"
      expr: graphics_package_version
    - name: "Is Ppv"
      expr: is_ppv
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "Market Designation"
      expr: market_designation
    - name: "Notes"
      expr: notes
    - name: "Ob Unit Identifier"
      expr: ob_unit_identifier
    - name: "Play By Play Announcer"
      expr: play_by_play_announcer
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Production"
      expr: COUNT(DISTINCT production_id)
    - name: "Total Frame Rate"
      expr: SUM(frame_rate)
    - name: "Average Frame Rate"
      expr: AVG(frame_rate)
    - name: "Total Ppv Price"
      expr: SUM(ppv_price)
    - name: "Average Ppv Price"
      expr: AVG(ppv_price)
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`broadcast_production_team`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Production Team business metrics"
  source: "`sports_entertainment_ecm`.`broadcast`.`production_team`"
  dimensions:
    - name: "Certifications"
      expr: certifications
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Crew Size"
      expr: crew_size
    - name: "Disbanded Date"
      expr: disbanded_date
    - name: "Established Date"
      expr: established_date
    - name: "Four K Capable"
      expr: four_k_capable
    - name: "Hdr Capable"
      expr: hdr_capable
    - name: "Insurance Expiry Date"
      expr: insurance_expiry_date
    - name: "Insurance Policy Number"
      expr: insurance_policy_number
    - name: "Languages Supported"
      expr: languages_supported
    - name: "Last Assignment Date"
      expr: last_assignment_date
    - name: "Lead Producer Name"
      expr: lead_producer_name
    - name: "Live Streaming Capable"
      expr: live_streaming_capable
    - name: "Mobile Unit Capable"
      expr: mobile_unit_capable
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Multi Camera Capable"
      expr: multi_camera_capable
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Production Team"
      expr: COUNT(DISTINCT production_team_id)
    - name: "Total Average Setup Time Hours"
      expr: SUM(average_setup_time_hours)
    - name: "Average Average Setup Time Hours"
      expr: AVG(average_setup_time_hours)
    - name: "Total Cost Per Event"
      expr: SUM(cost_per_event)
    - name: "Average Cost Per Event"
      expr: AVG(cost_per_event)
    - name: "Total Equipment Package Code"
      expr: SUM(equipment_package_code)
    - name: "Average Equipment Package Code"
      expr: AVG(equipment_package_code)
    - name: "Total Performance Rating"
      expr: SUM(performance_rating)
    - name: "Average Performance Rating"
      expr: AVG(performance_rating)
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`broadcast_rights_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rights Agreement business metrics"
  source: "`sports_entertainment_ecm`.`broadcast`.`rights_agreement`"
  dimensions:
    - name: "Broadcast Rights Tier"
      expr: broadcast_rights_tier
    - name: "Effective From"
      expr: effective_from
    - name: "Effective Until"
      expr: effective_until
    - name: "Exclusivity Type"
      expr: exclusivity_type
    - name: "Primary Flag"
      expr: primary_flag
    - name: "Rights Tier"
      expr: rights_tier
    - name: "Rights Window End"
      expr: rights_window_end
    - name: "Rights Window Start"
      expr: rights_window_start
    - name: "Territory Code"
      expr: territory_code
    - name: "Effective From Month"
      expr: DATE_TRUNC('MONTH', effective_from)
    - name: "Effective Until Month"
      expr: DATE_TRUNC('MONTH', effective_until)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Rights Agreement"
      expr: COUNT(DISTINCT rights_agreement_id)
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`broadcast_rights_holder`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rights Holder business metrics"
  source: "`sports_entertainment_ecm`.`broadcast`.`rights_holder`"
  dimensions:
    - name: "Bank Account Name"
      expr: bank_account_name
    - name: "Bank Account Number"
      expr: bank_account_number
    - name: "Bank Routing Number"
      expr: bank_routing_number
    - name: "Bank Swift Code"
      expr: bank_swift_code
    - name: "Business Registration Number"
      expr: business_registration_number
    - name: "Content Category"
      expr: content_category
    - name: "Contract End Date"
      expr: contract_end_date
    - name: "Contract Start Date"
      expr: contract_start_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Credit Rating"
      expr: credit_rating
    - name: "Currency Code"
      expr: currency_code
    - name: "Exclusivity Flag"
      expr: exclusivity_flag
    - name: "Headquarters Address Line1"
      expr: headquarters_address_line1
    - name: "Headquarters Address Line2"
      expr: headquarters_address_line2
    - name: "Headquarters City"
      expr: headquarters_city
    - name: "Headquarters Country Code"
      expr: headquarters_country_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Rights Holder"
      expr: COUNT(DISTINCT rights_holder_id)
    - name: "Total Minimum Guarantee Amount"
      expr: SUM(minimum_guarantee_amount)
    - name: "Average Minimum Guarantee Amount"
      expr: AVG(minimum_guarantee_amount)
    - name: "Total Revenue Share Percentage"
      expr: SUM(revenue_share_percentage)
    - name: "Average Revenue Share Percentage"
      expr: AVG(revenue_share_percentage)
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`broadcast_rights_royalty`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rights Royalty business metrics"
  source: "`sports_entertainment_ecm`.`broadcast`.`rights_royalty`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Approved By"
      expr: approved_by
    - name: "Audit Trail Notes"
      expr: audit_trail_notes
    - name: "Content Category"
      expr: content_category
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Dispute Reference"
      expr: dispute_reference
    - name: "Distribution Platform"
      expr: distribution_platform
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "League Code"
      expr: league_code
    - name: "Payment Direction"
      expr: payment_direction
    - name: "Payment Due Date"
      expr: payment_due_date
    - name: "Payment Method"
      expr: payment_method
    - name: "Payment Period End Date"
      expr: payment_period_end_date
    - name: "Payment Period Start Date"
      expr: payment_period_start_date
    - name: "Payment Received Date"
      expr: payment_received_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Rights Royalty"
      expr: COUNT(DISTINCT rights_royalty_id)
    - name: "Total Adjustment Amount"
      expr: SUM(adjustment_amount)
    - name: "Average Adjustment Amount"
      expr: AVG(adjustment_amount)
    - name: "Total Calculated Royalty Amount"
      expr: SUM(calculated_royalty_amount)
    - name: "Average Calculated Royalty Amount"
      expr: AVG(calculated_royalty_amount)
    - name: "Total Exchange Rate"
      expr: SUM(exchange_rate)
    - name: "Average Exchange Rate"
      expr: AVG(exchange_rate)
    - name: "Total Functional Currency Amount"
      expr: SUM(functional_currency_amount)
    - name: "Average Functional Currency Amount"
      expr: AVG(functional_currency_amount)
    - name: "Total Late Payment Penalty Amount"
      expr: SUM(late_payment_penalty_amount)
    - name: "Average Late Payment Penalty Amount"
      expr: AVG(late_payment_penalty_amount)
    - name: "Total Minimum Guarantee Amount"
      expr: SUM(minimum_guarantee_amount)
    - name: "Average Minimum Guarantee Amount"
      expr: AVG(minimum_guarantee_amount)
    - name: "Total Net Royalty Amount"
      expr: SUM(net_royalty_amount)
    - name: "Average Net Royalty Amount"
      expr: AVG(net_royalty_amount)
    - name: "Total Royalty Basis Value"
      expr: SUM(royalty_basis_value)
    - name: "Average Royalty Basis Value"
      expr: AVG(royalty_basis_value)
    - name: "Total Royalty Rate"
      expr: SUM(royalty_rate)
    - name: "Average Royalty Rate"
      expr: AVG(royalty_rate)
    - name: "Total Withholding Tax Amount"
      expr: SUM(withholding_tax_amount)
    - name: "Average Withholding Tax Amount"
      expr: AVG(withholding_tax_amount)
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`broadcast_rights_violation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rights Violation business metrics"
  source: "`sports_entertainment_ecm`.`broadcast`.`rights_violation`"
  dimensions:
    - name: "Content Type"
      expr: content_type
    - name: "Counter Notice Date"
      expr: counter_notice_date
    - name: "Counter Notice Received"
      expr: counter_notice_received
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Detected Timestamp"
      expr: detected_timestamp
    - name: "Detection Method"
      expr: detection_method
    - name: "Detection Tool"
      expr: detection_tool
    - name: "Enforcement Action"
      expr: enforcement_action
    - name: "Enforcement Action Date"
      expr: enforcement_action_date
    - name: "Evidence Reference"
      expr: evidence_reference
    - name: "Gdpr Data Subject Notified"
      expr: gdpr_data_subject_notified
    - name: "Infringing Content Duration Seconds"
      expr: infringing_content_duration_seconds
    - name: "Infringing Party Name"
      expr: infringing_party_name
    - name: "Infringing Party Type"
      expr: infringing_party_type
    - name: "Infringing Url"
      expr: infringing_url
    - name: "Is Repeat Infringer"
      expr: is_repeat_infringer
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Rights Violation"
      expr: COUNT(DISTINCT rights_violation_id)
    - name: "Total Estimated Audience Reach"
      expr: SUM(estimated_audience_reach)
    - name: "Average Estimated Audience Reach"
      expr: AVG(estimated_audience_reach)
    - name: "Total Estimated Revenue Impact"
      expr: SUM(estimated_revenue_impact)
    - name: "Average Estimated Revenue Impact"
      expr: AVG(estimated_revenue_impact)
    - name: "Total Financial Penalty Amount"
      expr: SUM(financial_penalty_amount)
    - name: "Average Financial Penalty Amount"
      expr: AVG(financial_penalty_amount)
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`broadcast_rights_window_channel_authorization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rights Window Channel Authorization business metrics"
  source: "`sports_entertainment_ecm`.`broadcast`.`rights_window_channel_authorization`"
  dimensions:
    - name: "Authorization End"
      expr: authorization_end
    - name: "Authorization Start"
      expr: authorization_start
    - name: "Authorization Status"
      expr: authorization_status
    - name: "Concurrent Stream Limit"
      expr: concurrent_stream_limit
    - name: "Exclusivity Flag"
      expr: exclusivity_flag
    - name: "Platform Type"
      expr: platform_type
    - name: "Territory Code"
      expr: territory_code
    - name: "Authorization End Month"
      expr: DATE_TRUNC('MONTH', authorization_end)
    - name: "Authorization Start Month"
      expr: DATE_TRUNC('MONTH', authorization_start)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Rights Window Channel Authorization"
      expr: COUNT(DISTINCT rights_window_channel_authorization_id)
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`broadcast_streaming_subscription`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Streaming Subscription business metrics"
  source: "`sports_entertainment_ecm`.`broadcast`.`streaming_subscription`"
  dimensions:
    - name: "Acquisition Channel"
      expr: acquisition_channel
    - name: "Auto Renewal Flag"
      expr: auto_renewal_flag
    - name: "Billing Cycle"
      expr: billing_cycle
    - name: "Billing Cycle Day"
      expr: billing_cycle_day
    - name: "Blackout Region Code"
      expr: blackout_region_code
    - name: "Cancellation Date"
      expr: cancellation_date
    - name: "Cancellation Reason"
      expr: cancellation_reason
    - name: "Concurrent Stream Limit"
      expr: concurrent_stream_limit
    - name: "Consent Data Sharing Flag"
      expr: consent_data_sharing_flag
    - name: "Consent Marketing Flag"
      expr: consent_marketing_flag
    - name: "Consent Timestamp"
      expr: consent_timestamp
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Device Code"
      expr: device_code
    - name: "Download Enabled Flag"
      expr: download_enabled_flag
    - name: "Drm Profile Code"
      expr: drm_profile_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Streaming Subscription"
      expr: COUNT(DISTINCT streaming_subscription_id)
    - name: "Total Promotional Rate"
      expr: SUM(promotional_rate)
    - name: "Average Promotional Rate"
      expr: AVG(promotional_rate)
    - name: "Total Subscription Charge"
      expr: SUM(subscription_charge)
    - name: "Average Subscription Charge"
      expr: AVG(subscription_charge)
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`broadcast_sublicense_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sublicense Agreement business metrics"
  source: "`sports_entertainment_ecm`.`broadcast`.`sublicense_agreement`"
  dimensions:
    - name: "Agreement Reference Code"
      expr: agreement_reference_code
    - name: "Agreement Status"
      expr: agreement_status
    - name: "Agreement Title"
      expr: agreement_title
    - name: "Agreement Type"
      expr: agreement_type
    - name: "Anti Piracy Obligations"
      expr: anti_piracy_obligations
    - name: "Auto Renewal Flag"
      expr: auto_renewal_flag
    - name: "Content Rights Type"
      expr: content_rights_type
    - name: "Content Scope Description"
      expr: content_scope_description
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Dispute Resolution Mechanism"
      expr: dispute_resolution_mechanism
    - name: "Effective From"
      expr: effective_from
    - name: "Effective Until"
      expr: effective_until
    - name: "Exclusivity Type"
      expr: exclusivity_type
    - name: "Execution Date"
      expr: execution_date
    - name: "Fee Currency Code"
      expr: fee_currency_code
    - name: "Fee Payment Schedule"
      expr: fee_payment_schedule
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Sublicense Agreement"
      expr: COUNT(DISTINCT sublicense_agreement_id)
    - name: "Total Minimum Guarantee Amount"
      expr: SUM(minimum_guarantee_amount)
    - name: "Average Minimum Guarantee Amount"
      expr: AVG(minimum_guarantee_amount)
    - name: "Total Revenue Share Pct"
      expr: SUM(revenue_share_pct)
    - name: "Average Revenue Share Pct"
      expr: AVG(revenue_share_pct)
    - name: "Total Sublicense Fee"
      expr: SUM(sublicense_fee)
    - name: "Average Sublicense Fee"
      expr: AVG(sublicense_fee)
    - name: "Total Sublicense Fee Paid To Date"
      expr: SUM(sublicense_fee_paid_to_date)
    - name: "Average Sublicense Fee Paid To Date"
      expr: AVG(sublicense_fee_paid_to_date)
    - name: "Total Sublicense Term Years"
      expr: SUM(sublicense_term_years)
    - name: "Average Sublicense Term Years"
      expr: AVG(sublicense_term_years)
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`broadcast_subscription_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Subscription Plan business metrics"
  source: "`sports_entertainment_ecm`.`broadcast`.`subscription_plan`"
  dimensions:
    - name: "Ad Supported"
      expr: ad_supported
    - name: "Auto Renewal Enabled"
      expr: auto_renewal_enabled
    - name: "Billing Frequency"
      expr: billing_frequency
    - name: "Blackout Rules Apply"
      expr: blackout_rules_apply
    - name: "Cancellation Policy"
      expr: cancellation_policy
    - name: "Content Library Access"
      expr: content_library_access
    - name: "Contract Term Months"
      expr: contract_term_months
    - name: "Corporate License Eligible"
      expr: corporate_license_eligible
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Description"
      expr: subscription_plan_description
    - name: "Dvr Enabled"
      expr: dvr_enabled
    - name: "Dvr Storage Hours"
      expr: dvr_storage_hours
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Family Sharing Enabled"
      expr: family_sharing_enabled
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Subscription Plan"
      expr: COUNT(DISTINCT subscription_plan_id)
    - name: "Total Base Price"
      expr: SUM(base_price)
    - name: "Average Base Price"
      expr: AVG(base_price)
    - name: "Total Ppv Discount Percentage"
      expr: SUM(ppv_discount_percentage)
    - name: "Average Ppv Discount Percentage"
      expr: AVG(ppv_discount_percentage)
$$;