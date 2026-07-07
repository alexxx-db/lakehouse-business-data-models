-- Metric views for domain: audience | Business: Media_Broadcasting | Version: 2 | Generated on: 2026-06-30 06:47:57

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`audience_audience_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Audience Profile business metrics"
  source: "`vibe_media_broadcasting_v1`.`audience`.`audience_profile`"
  dimensions:
    - name: "Aep Profile Code"
      expr: aep_profile_code
    - name: "Aep Segment Membership"
      expr: aep_segment_membership
    - name: "Ccpa Opt Out"
      expr: ccpa_opt_out
    - name: "Consent Last Updated Timestamp"
      expr: consent_last_updated_timestamp
    - name: "Content Affinity Genre"
      expr: content_affinity_genre
    - name: "Coppa Protected"
      expr: coppa_protected
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Clean Room Eligible"
      expr: data_clean_room_eligible
    - name: "Device Graph Code"
      expr: device_graph_code
    - name: "Enrichment Source Version"
      expr: enrichment_source_version
    - name: "Gdpr Consent Status"
      expr: gdpr_consent_status
    - name: "Household Size"
      expr: household_size
    - name: "Hut Eligible"
      expr: hut_eligible
    - name: "Identity Hash"
      expr: identity_hash
    - name: "Identity Source"
      expr: identity_source
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Audience Profile"
      expr: COUNT(DISTINCT audience_profile_id)
    - name: "Total Ad Receptivity Score"
      expr: SUM(ad_receptivity_score)
    - name: "Average Ad Receptivity Score"
      expr: AVG(ad_receptivity_score)
    - name: "Total Avg Session Duration Minutes"
      expr: SUM(avg_session_duration_minutes)
    - name: "Average Avg Session Duration Minutes"
      expr: AVG(avg_session_duration_minutes)
    - name: "Total Identity Confidence Score"
      expr: SUM(identity_confidence_score)
    - name: "Average Identity Confidence Score"
      expr: AVG(identity_confidence_score)
    - name: "Total Nielsen Grp Index"
      expr: SUM(nielsen_grp_index)
    - name: "Average Nielsen Grp Index"
      expr: AVG(nielsen_grp_index)
    - name: "Total Panel Weight Factor"
      expr: SUM(panel_weight_factor)
    - name: "Average Panel Weight Factor"
      expr: AVG(panel_weight_factor)
    - name: "Total Trp Index"
      expr: SUM(trp_index)
    - name: "Average Trp Index"
      expr: AVG(trp_index)
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`audience_cross_platform_measurement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cross Platform Measurement business metrics"
  source: "`vibe_media_broadcasting_v1`.`audience`.`cross_platform_measurement`"
  dimensions:
    - name: "Content Genre"
      expr: content_genre
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Version"
      expr: currency_version
    - name: "Data Source Systems"
      expr: data_source_systems
    - name: "Distribution Type"
      expr: distribution_type
    - name: "Is Data Suppressed"
      expr: is_data_suppressed
    - name: "Is Mrc Accredited"
      expr: is_mrc_accredited
    - name: "Is Sweeps Period"
      expr: is_sweeps_period
    - name: "Isan Code"
      expr: isan_code
    - name: "Measurement Period End"
      expr: measurement_period_end
    - name: "Measurement Period Start"
      expr: measurement_period_start
    - name: "Measurement Reference Number"
      expr: measurement_reference_number
    - name: "Measurement Status"
      expr: measurement_status
    - name: "Measurement Timestamp"
      expr: measurement_timestamp
    - name: "Panel Sample Size"
      expr: panel_sample_size
    - name: "Updated Timestamp"
      expr: updated_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Cross Platform Measurement"
      expr: COUNT(DISTINCT cross_platform_measurement_id)
    - name: "Total Audience Share"
      expr: SUM(audience_share)
    - name: "Average Audience Share"
      expr: AVG(audience_share)
    - name: "Total Average Frequency"
      expr: SUM(average_frequency)
    - name: "Average Average Frequency"
      expr: AVG(average_frequency)
    - name: "Total Co Viewing Adjustment Factor"
      expr: SUM(co_viewing_adjustment_factor)
    - name: "Average Co Viewing Adjustment Factor"
      expr: AVG(co_viewing_adjustment_factor)
    - name: "Total Cross Platform Grp"
      expr: SUM(cross_platform_grp)
    - name: "Average Cross Platform Grp"
      expr: AVG(cross_platform_grp)
    - name: "Total Cross Platform Trp"
      expr: SUM(cross_platform_trp)
    - name: "Average Cross Platform Trp"
      expr: AVG(cross_platform_trp)
    - name: "Total Deduplicated Reach"
      expr: SUM(deduplicated_reach)
    - name: "Average Deduplicated Reach"
      expr: AVG(deduplicated_reach)
    - name: "Total Fast Channel Impressions"
      expr: SUM(fast_channel_impressions)
    - name: "Average Fast Channel Impressions"
      expr: AVG(fast_channel_impressions)
    - name: "Total Hut Rating"
      expr: SUM(hut_rating)
    - name: "Average Hut Rating"
      expr: AVG(hut_rating)
    - name: "Total Linear Impressions"
      expr: SUM(linear_impressions)
    - name: "Average Linear Impressions"
      expr: AVG(linear_impressions)
    - name: "Total Mvpd Impressions"
      expr: SUM(mvpd_impressions)
    - name: "Average Mvpd Impressions"
      expr: AVG(mvpd_impressions)
    - name: "Total Nielsen Rating"
      expr: SUM(nielsen_rating)
    - name: "Average Nielsen Rating"
      expr: AVG(nielsen_rating)
    - name: "Total Ott Streaming Impressions"
      expr: SUM(ott_streaming_impressions)
    - name: "Average Ott Streaming Impressions"
      expr: AVG(ott_streaming_impressions)
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`audience_demographic_segment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Demographic Segment business metrics"
  source: "`vibe_media_broadcasting_v1`.`audience`.`demographic_segment`"
  dimensions:
    - name: "Adobe Segment Code"
      expr: adobe_segment_code
    - name: "Age Range Max"
      expr: age_range_max
    - name: "Age Range Min"
      expr: age_range_min
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Daypart Relevance"
      expr: daypart_relevance
    - name: "Effective From"
      expr: effective_from
    - name: "Effective Until"
      expr: effective_until
    - name: "Ethnicity Classification"
      expr: ethnicity_classification
    - name: "Gdpr Special Category"
      expr: gdpr_special_category
    - name: "Gender Qualifier"
      expr: gender_qualifier
    - name: "Geographic Scope"
      expr: geographic_scope
    - name: "Household Composition"
      expr: household_composition
    - name: "Iab Audience Code"
      expr: iab_audience_code
    - name: "Income Quintile"
      expr: income_quintile
    - name: "Is Children Segment"
      expr: is_children_segment
    - name: "Is Key Demo"
      expr: is_key_demo
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Demographic Segment"
      expr: COUNT(DISTINCT demographic_segment_id)
    - name: "Total Cpm Index"
      expr: SUM(cpm_index)
    - name: "Average Cpm Index"
      expr: AVG(cpm_index)
    - name: "Total Grp Weight Factor"
      expr: SUM(grp_weight_factor)
    - name: "Average Grp Weight Factor"
      expr: AVG(grp_weight_factor)
    - name: "Total Reach Potential Pct"
      expr: SUM(reach_potential_pct)
    - name: "Average Reach Potential Pct"
      expr: AVG(reach_potential_pct)
    - name: "Total Universe Estimate"
      expr: SUM(universe_estimate)
    - name: "Average Universe Estimate"
      expr: AVG(universe_estimate)
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`audience_engagement_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Engagement Event business metrics"
  source: "`vibe_media_broadcasting_v1`.`audience`.`engagement_event`"
  dimensions:
    - name: "Ad Pod Position"
      expr: ad_pod_position
    - name: "App Version"
      expr: app_version
    - name: "Bitrate Kbps"
      expr: bitrate_kbps
    - name: "Blackout Applied"
      expr: blackout_applied
    - name: "Buffering Duration Ms"
      expr: buffering_duration_ms
    - name: "Content Rating"
      expr: content_rating
    - name: "Data Privacy Consent"
      expr: data_privacy_consent
    - name: "Daypart"
      expr: daypart
    - name: "Device Os"
      expr: device_os
    - name: "Device Type"
      expr: device_type
    - name: "Drm Scheme"
      expr: drm_scheme
    - name: "Event Status"
      expr: event_status
    - name: "Event Timestamp"
      expr: event_timestamp
    - name: "Event Type"
      expr: event_type
    - name: "Geo Country Code"
      expr: geo_country_code
    - name: "Geo Region Code"
      expr: geo_region_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Engagement Event"
      expr: COUNT(DISTINCT engagement_event_id)
    - name: "Total Content Duration Ms"
      expr: SUM(content_duration_ms)
    - name: "Average Content Duration Ms"
      expr: AVG(content_duration_ms)
    - name: "Total Content Position Ms"
      expr: SUM(content_position_ms)
    - name: "Average Content Position Ms"
      expr: AVG(content_position_ms)
    - name: "Total Engagement Depth Score"
      expr: SUM(engagement_depth_score)
    - name: "Average Engagement Depth Score"
      expr: AVG(engagement_depth_score)
    - name: "Total Seek From Position Ms"
      expr: SUM(seek_from_position_ms)
    - name: "Average Seek From Position Ms"
      expr: AVG(seek_from_position_ms)
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`audience_nielsen_rating`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Nielsen Rating business metrics"
  source: "`vibe_media_broadcasting_v1`.`audience`.`nielsen_rating`"
  dimensions:
    - name: "Air Date"
      expr: air_date
    - name: "Air End Time"
      expr: air_end_time
    - name: "Air Start Time"
      expr: air_start_time
    - name: "Ingested Timestamp"
      expr: ingested_timestamp
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "Nielsen Program Code"
      expr: nielsen_program_code
    - name: "Nielsen Report Date"
      expr: nielsen_report_date
    - name: "Nielsen Report Week"
      expr: nielsen_report_week
    - name: "Rating Status"
      expr: rating_status
    - name: "Source System Record Code"
      expr: source_system_record_code
    - name: "Sweeps Period Flag"
      expr: sweeps_period_flag
    - name: "Created At Month"
      expr: DATE_TRUNC('MONTH', created_at)
    - name: "Updated At Month"
      expr: DATE_TRUNC('MONTH', updated_at)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Nielsen Rating"
      expr: COUNT(DISTINCT nielsen_rating_id)
    - name: "Total Audience Composition Pct"
      expr: SUM(audience_composition_pct)
    - name: "Average Audience Composition Pct"
      expr: AVG(audience_composition_pct)
    - name: "Total Average Audience"
      expr: SUM(average_audience)
    - name: "Average Average Audience"
      expr: AVG(average_audience)
    - name: "Total Cume Audience"
      expr: SUM(cume_audience)
    - name: "Average Cume Audience"
      expr: AVG(cume_audience)
    - name: "Total Demo A18 49 Rating"
      expr: SUM(demo_a18_49_rating)
    - name: "Average Demo A18 49 Rating"
      expr: AVG(demo_a18_49_rating)
    - name: "Total Demo A25 54 Rating"
      expr: SUM(demo_a25_54_rating)
    - name: "Average Demo A25 54 Rating"
      expr: AVG(demo_a25_54_rating)
    - name: "Total Demo K2 11 Rating"
      expr: SUM(demo_k2_11_rating)
    - name: "Average Demo K2 11 Rating"
      expr: AVG(demo_k2_11_rating)
    - name: "Total Demo M18 49 Rating"
      expr: SUM(demo_m18_49_rating)
    - name: "Average Demo M18 49 Rating"
      expr: AVG(demo_m18_49_rating)
    - name: "Total Demo W18 49 Rating"
      expr: SUM(demo_w18_49_rating)
    - name: "Average Demo W18 49 Rating"
      expr: AVG(demo_w18_49_rating)
    - name: "Total Frequency"
      expr: SUM(frequency)
    - name: "Average Frequency"
      expr: AVG(frequency)
    - name: "Total Grp"
      expr: SUM(grp)
    - name: "Average Grp"
      expr: AVG(grp)
    - name: "Total Household Rating"
      expr: SUM(household_rating)
    - name: "Average Household Rating"
      expr: AVG(household_rating)
    - name: "Total Household Share"
      expr: SUM(household_share)
    - name: "Average Household Share"
      expr: AVG(household_share)
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`audience_reach_frequency_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reach Frequency Report business metrics"
  source: "`vibe_media_broadcasting_v1`.`audience`.`reach_frequency_report`"
  dimensions:
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Effective Reach Threshold"
      expr: effective_reach_threshold
    - name: "Is Makegood Required"
      expr: is_makegood_required
    - name: "Is Sweeps Period"
      expr: is_sweeps_period
    - name: "Measurement Period End Date"
      expr: measurement_period_end_date
    - name: "Measurement Period Start Date"
      expr: measurement_period_start_date
    - name: "Measurement Type"
      expr: measurement_type
    - name: "Nielsen Report Code"
      expr: nielsen_report_code
    - name: "Platform Type"
      expr: platform_type
    - name: "Report Generated Timestamp"
      expr: report_generated_timestamp
    - name: "Report Number"
      expr: report_number
    - name: "Report Status"
      expr: report_status
    - name: "Report Version"
      expr: report_version
    - name: "Updated Timestamp"
      expr: updated_timestamp
    - name: "Created At Month"
      expr: DATE_TRUNC('MONTH', created_at)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Reach Frequency Report"
      expr: COUNT(DISTINCT reach_frequency_report_id)
    - name: "Total Audience Share Pct"
      expr: SUM(audience_share_pct)
    - name: "Average Audience Share Pct"
      expr: AVG(audience_share_pct)
    - name: "Total Average Frequency"
      expr: SUM(average_frequency)
    - name: "Average Average Frequency"
      expr: AVG(average_frequency)
    - name: "Total Cpm"
      expr: SUM(cpm)
    - name: "Average Cpm"
      expr: AVG(cpm)
    - name: "Total Cprp"
      expr: SUM(cprp)
    - name: "Average Cprp"
      expr: AVG(cprp)
    - name: "Total Delivery Variance Pct"
      expr: SUM(delivery_variance_pct)
    - name: "Average Delivery Variance Pct"
      expr: AVG(delivery_variance_pct)
    - name: "Total Effective Reach 1plus"
      expr: SUM(effective_reach_1plus)
    - name: "Average Effective Reach 1plus"
      expr: AVG(effective_reach_1plus)
    - name: "Total Effective Reach 3plus"
      expr: SUM(effective_reach_3plus)
    - name: "Average Effective Reach 3plus"
      expr: AVG(effective_reach_3plus)
    - name: "Total Effective Reach Nplus"
      expr: SUM(effective_reach_nplus)
    - name: "Average Effective Reach Nplus"
      expr: AVG(effective_reach_nplus)
    - name: "Total Grp"
      expr: SUM(grp)
    - name: "Average Grp"
      expr: AVG(grp)
    - name: "Total Hut Rating"
      expr: SUM(hut_rating)
    - name: "Average Hut Rating"
      expr: AVG(hut_rating)
    - name: "Total Put Rating"
      expr: SUM(put_rating)
    - name: "Average Put Rating"
      expr: AVG(put_rating)
    - name: "Total Reach Pct"
      expr: SUM(reach_pct)
    - name: "Average Reach Pct"
      expr: AVG(reach_pct)
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`audience_viewership_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Viewership Record business metrics"
  source: "`vibe_media_broadcasting_v1`.`audience`.`viewership_record`"
  dimensions:
    - name: "Acr Source"
      expr: acr_source
    - name: "Ad Break Count"
      expr: ad_break_count
    - name: "Ads Viewed Count"
      expr: ads_viewed_count
    - name: "Blackout Applied"
      expr: blackout_applied
    - name: "Broadcast Date"
      expr: broadcast_date
    - name: "Cdn Edge Node"
      expr: cdn_edge_node
    - name: "Content Duration Seconds"
      expr: content_duration_seconds
    - name: "Country Code"
      expr: country_code
    - name: "Data Source System"
      expr: data_source_system
    - name: "Daypart"
      expr: daypart
    - name: "Device Type"
      expr: device_type
    - name: "Drm Protected"
      expr: drm_protected
    - name: "Duration Viewed Seconds"
      expr: duration_viewed_seconds
    - name: "Ingestion Timestamp"
      expr: ingestion_timestamp
    - name: "Is Authenticated"
      expr: is_authenticated
    - name: "Is Sweeps Period"
      expr: is_sweeps_period
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Viewership Record"
      expr: COUNT(DISTINCT viewership_record_id)
    - name: "Total Audience Share"
      expr: SUM(audience_share)
    - name: "Average Audience Share"
      expr: AVG(audience_share)
    - name: "Total Completion Rate"
      expr: SUM(completion_rate)
    - name: "Average Completion Rate"
      expr: AVG(completion_rate)
    - name: "Total Nielsen Program Rating"
      expr: SUM(nielsen_program_rating)
    - name: "Average Nielsen Program Rating"
      expr: AVG(nielsen_program_rating)
$$;