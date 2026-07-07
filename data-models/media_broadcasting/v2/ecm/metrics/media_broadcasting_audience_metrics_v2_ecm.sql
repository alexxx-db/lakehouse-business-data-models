-- Metric views for domain: audience | Business: Media_Broadcasting | Version: 2 | Generated on: 2026-06-30 04:55:25

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`audience_nielsen_rating`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core linear audience measurement KPIs from Nielsen ratings used by programming, sales, and research leadership to evaluate program performance and ad-sales monetization."
  source: "`vibe_media_broadcasting_v1`.`audience`.`nielsen_rating`"
  dimensions:
    - name: "air_month"
      expr: DATE_TRUNC('MONTH', air_date)
      comment: "Month of air date for trended ratings analysis"
    - name: "rating_status"
      expr: rating_status
      comment: "Status of the Nielsen rating record (preliminary/final) for data-confidence filtering"
    - name: "nielsen_report_week"
      expr: nielsen_report_week
      comment: "Nielsen report week for weekly performance reviews"
    - name: "is_sweeps_period"
      expr: sweeps_period_flag
      comment: "Whether the rating falls within a sweeps period, which drives upfront rate-card pricing"
  measures:
    - name: "Avg Household Rating"
      expr: AVG(CAST(household_rating AS DOUBLE))
      comment: "Average household rating point — the headline currency for linear program valuation"
    - name: "Avg Household Share"
      expr: AVG(CAST(household_share AS DOUBLE))
      comment: "Average household share of viewing audience, indicating competitive program strength"
    - name: "Avg Key Demo A18-49 Rating"
      expr: AVG(CAST(demo_a18_49_rating AS DOUBLE))
      comment: "Average rating in the A18-49 advertiser-priority demo that drives ad CPM negotiations"
    - name: "Avg Key Demo A25-54 Rating"
      expr: AVG(CAST(demo_a25_54_rating AS DOUBLE))
      comment: "Average rating in the A25-54 news/sports demo used in sales guarantees"
    - name: "Total Impressions"
      expr: SUM(CAST(impressions AS DOUBLE))
      comment: "Total delivered impressions, the gross-tonnage basis for impression-based ad guarantees"
    - name: "Avg GRP"
      expr: AVG(CAST(grp AS DOUBLE))
      comment: "Average gross rating points delivered, the core planning currency for ad campaigns"
    - name: "Avg Reach"
      expr: AVG(CAST(reach AS DOUBLE))
      comment: "Average unduplicated reach, used to assess audience accumulation"
    - name: "Avg Time Spent Viewing Minutes"
      expr: AVG(CAST(time_spent_viewing_min AS DOUBLE))
      comment: "Average minutes viewed, a primary engagement/stickiness indicator"
    - name: "Programs Measured"
      expr: COUNT(1)
      comment: "Count of rating records measured, the volume baseline for the rating set"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`audience_cross_platform_measurement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cross-platform (linear + OTT + MVPD + social) deduplicated audience KPIs that underpin the 2026 unified-currency measurement story for executives and ad sales."
  source: "`vibe_media_broadcasting_v1`.`audience`.`cross_platform_measurement`"
  dimensions:
    - name: "measurement_month"
      expr: DATE_TRUNC('MONTH', measurement_period_start)
      comment: "Month bucket of the measurement window for trend analysis"
    - name: "distribution_type"
      expr: distribution_type
      comment: "Distribution platform type (linear/OTT/MVPD/social) for cross-platform comparison"
    - name: "is_mrc_accredited"
      expr: is_mrc_accredited
      comment: "Whether the measurement is MRC-accredited, a credibility gate for ad-sales usage"
    - name: "content_genre"
      expr: content_genre
      comment: "Genre of measured content for portfolio performance analysis"
  measures:
    - name: "Total Impressions"
      expr: SUM(CAST(total_impressions AS DOUBLE))
      comment: "Total deduplicated cross-platform impressions, the unified-currency monetization basis"
    - name: "Linear Impressions"
      expr: SUM(CAST(linear_impressions AS DOUBLE))
      comment: "Total linear-TV impressions for platform-mix and decline analysis"
    - name: "OTT Streaming Impressions"
      expr: SUM(CAST(ott_streaming_impressions AS DOUBLE))
      comment: "Total OTT streaming impressions tracking the shift to digital delivery"
    - name: "FAST Channel Impressions"
      expr: SUM(CAST(fast_channel_impressions AS DOUBLE))
      comment: "Total FAST-channel impressions, a fast-growing monetization surface"
    - name: "Total Deduplicated Reach"
      expr: SUM(CAST(deduplicated_reach AS DOUBLE))
      comment: "Total deduplicated reach across platforms, the headline cross-platform reach number"
    - name: "Avg Cross Platform GRP"
      expr: AVG(CAST(cross_platform_grp AS DOUBLE))
      comment: "Average cross-platform GRP, the unified planning currency"
    - name: "Avg Average Frequency"
      expr: AVG(CAST(average_frequency AS DOUBLE))
      comment: "Average exposure frequency per reached person for frequency-management decisions"
    - name: "Avg Audience Share"
      expr: AVG(CAST(audience_share AS DOUBLE))
      comment: "Average audience share across platforms indicating competitive standing"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`audience_reach_frequency_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reach/frequency and delivery-vs-guarantee KPIs used by ad-sales and finance to assess campaign delivery efficiency and makegood exposure."
  source: "`vibe_media_broadcasting_v1`.`audience`.`reach_frequency_report`"
  dimensions:
    - name: "measurement_month"
      expr: DATE_TRUNC('MONTH', measurement_period_start_date)
      comment: "Month bucket of the campaign measurement window"
    - name: "platform_type"
      expr: platform_type
      comment: "Platform type measured for cross-platform delivery analysis"
    - name: "report_status"
      expr: report_status
      comment: "Report status for filtering finalized delivery results"
    - name: "is_makegood_required"
      expr: is_makegood_required
      comment: "Whether a makegood is required, a direct revenue-risk flag"
  measures:
    - name: "Avg Reach Pct"
      expr: AVG(CAST(reach_pct AS DOUBLE))
      comment: "Average percent reach of target universe, a core campaign effectiveness KPI"
    - name: "Avg Frequency"
      expr: AVG(CAST(average_frequency AS DOUBLE))
      comment: "Average exposure frequency for over/under-exposure management"
    - name: "Avg CPM"
      expr: AVG(CAST(cpm AS DOUBLE))
      comment: "Average cost per thousand impressions, the primary ad-pricing efficiency metric"
    - name: "Avg CPRP"
      expr: AVG(CAST(cprp AS DOUBLE))
      comment: "Average cost per rating point, used in negotiated demo-guarantee deals"
    - name: "Avg Delivery Variance Pct"
      expr: AVG(CAST(delivery_variance_pct AS DOUBLE))
      comment: "Average delivery variance vs guarantee, signaling under-delivery and makegood exposure"
    - name: "Total Impressions"
      expr: SUM(CAST(total_impressions AS DOUBLE))
      comment: "Total impressions delivered across campaigns, the gross delivery volume"
    - name: "Total Effective Reach 3plus"
      expr: SUM(CAST(effective_reach_3plus AS DOUBLE))
      comment: "Total persons reached 3+ times, the effective-frequency reach standard for impact"
    - name: "Avg GRP"
      expr: AVG(CAST(grp AS DOUBLE))
      comment: "Average gross rating points delivered per report"
    - name: "Makegood Required Rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_makegood_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of reports flagged as requiring makegood — a leading indicator of revenue clawback risk"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`audience_viewability_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Digital ad viewability, invalid-traffic, and brand-safety KPIs (MRC/IAB) required for upfront guarantee reconciliation and media-quality governance."
  source: "`vibe_media_broadcasting_v1`.`audience`.`viewability_record`"
  dimensions:
    - name: "measurement_month"
      expr: DATE_TRUNC('MONTH', measurement_date)
      comment: "Month of viewability measurement for trend tracking"
    - name: "measurement_vendor"
      expr: measurement_vendor
      comment: "Third-party verification vendor (e.g. IAS/DV/MOAT) for vendor-comparison analysis"
    - name: "mrc_viewable_flag"
      expr: mrc_viewable_flag
      comment: "Whether impressions met the MRC viewability standard, a guarantee-reconciliation gate"
  measures:
    - name: "Avg Viewability Rate"
      expr: AVG(CAST(viewability_rate AS DOUBLE))
      comment: "Average viewability rate, a core media-quality KPI affecting billable impressions"
    - name: "Avg IVT Rate"
      expr: AVG(CAST(ivt_rate AS DOUBLE))
      comment: "Average invalid-traffic rate, a fraud/waste indicator that drives vendor and supply decisions"
    - name: "Avg Brand Safety Rate"
      expr: AVG(CAST(brand_safety_rate AS DOUBLE))
      comment: "Average brand-safety rate, governing where ads are allowed to run"
    - name: "Total Impressions Measured"
      expr: SUM(CAST(impressions_measured AS DOUBLE))
      comment: "Total measured impressions, the denominator base for verification rates"
    - name: "Total Impressions Viewable"
      expr: SUM(CAST(impressions_viewable AS DOUBLE))
      comment: "Total viewable impressions, the billable basis under viewability guarantees"
    - name: "Total IVT Impressions"
      expr: SUM(CAST(ivt_impressions AS DOUBLE))
      comment: "Total invalid-traffic impressions removed from billing"
    - name: "Avg Time In View Seconds"
      expr: AVG(CAST(time_in_view_seconds AS DOUBLE))
      comment: "Average seconds in view, an attention-quality metric for premium pricing"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`audience_clean_room_match`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Data clean-room match-rate and privacy-threshold KPIs (LiveRamp/InfoSum/Habu) used by ad-sales and data governance to assess addressable-targeting and measurement viability."
  source: "`vibe_media_broadcasting_v1`.`audience`.`clean_room_match`"
  dimensions:
    - name: "match_month"
      expr: DATE_TRUNC('MONTH', match_date)
      comment: "Month of the clean-room match for trend analysis"
    - name: "clean_room_provider"
      expr: clean_room_provider
      comment: "Clean-room provider for vendor-comparison of match performance"
    - name: "match_type"
      expr: match_type
      comment: "Type of identity match for methodology-level analysis"
    - name: "privacy_threshold_met_flag"
      expr: privacy_threshold_met_flag
      comment: "Whether the privacy k-anonymity threshold was met, a governance gate for activation"
  measures:
    - name: "Avg Match Rate"
      expr: AVG(CAST(match_rate AS DOUBLE))
      comment: "Average identity match rate, the core feasibility KPI for clean-room targeting and measurement"
    - name: "Avg Overlap Percentage"
      expr: AVG(CAST(overlap_percentage AS DOUBLE))
      comment: "Average audience overlap percentage informing co-targeting and dedup decisions"
    - name: "Total Input Records"
      expr: SUM(CAST(input_record_count AS DOUBLE))
      comment: "Total input records submitted to the clean room"
    - name: "Total Matched Records"
      expr: SUM(CAST(matched_record_count AS DOUBLE))
      comment: "Total successfully matched records, the addressable-audience base"
    - name: "Privacy Threshold Met Rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN privacy_threshold_met_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of matches meeting privacy thresholds — a compliance and activation-readiness KPI"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`audience_engagement_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Streaming engagement and quality-of-experience KPIs used by product, content, and distribution leadership to manage retention and viewing depth."
  source: "`vibe_media_broadcasting_v1`.`audience`.`engagement_event`"
  dimensions:
    - name: "event_day"
      expr: DATE_TRUNC('DAY', event_timestamp)
      comment: "Day of the engagement event for daily trend analysis"
    - name: "event_type"
      expr: event_type
      comment: "Type of engagement event (play/pause/seek/ad) for behavioral breakdown"
    - name: "device_type"
      expr: device_type
      comment: "Device type for device-mix engagement analysis"
    - name: "content_genre"
      expr: content_genre
      comment: "Genre of viewed content for content-strategy insights"
    - name: "subscription_tier"
      expr: subscription_tier
      comment: "Subscription tier for tier-level engagement comparison"
  measures:
    - name: "Avg Engagement Depth Score"
      expr: AVG(CAST(engagement_depth_score AS DOUBLE))
      comment: "Average engagement-depth score, the headline stickiness KPI for retention strategy"
    - name: "Total Content Duration Ms"
      expr: SUM(CAST(content_duration_ms AS DOUBLE))
      comment: "Total content duration consumed, a streaming-consumption volume metric"
    - name: "Ad Event Rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_ad_event = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of events that are ad events, informing ad-load and monetization balance"
    - name: "Concurrent Stream Rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_concurrent_stream = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of concurrent-stream events, signaling password-sharing and capacity pressure"
    - name: "Engagement Events"
      expr: COUNT(1)
      comment: "Total engagement events, the activity volume baseline"
    - name: "Distinct Viewers Engaged"
      expr: COUNT(DISTINCT viewer_profile_id)
      comment: "Distinct viewer profiles generating engagement, a unique-audience reach indicator"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`audience_viewership_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Granular viewing-session KPIs (completion, share, authentication) used by content and distribution leadership for program performance and platform health."
  source: "`vibe_media_broadcasting_v1`.`audience`.`viewership_record`"
  dimensions:
    - name: "broadcast_month"
      expr: DATE_TRUNC('MONTH', broadcast_date)
      comment: "Month of broadcast for trended viewing analysis"
    - name: "platform_type"
      expr: platform_type
      comment: "Platform type (linear/OTT) for cross-platform viewing comparison"
    - name: "delivery_type"
      expr: delivery_type
      comment: "Delivery type (live/VOD/timeshift) for consumption-mode analysis"
    - name: "daypart"
      expr: daypart
      comment: "Daypart for time-of-day viewing patterns"
    - name: "viewing_status"
      expr: viewing_status
      comment: "Viewing status of the session for completeness filtering"
  measures:
    - name: "Avg Completion Rate"
      expr: AVG(CAST(completion_rate AS DOUBLE))
      comment: "Average content completion rate, a core content-quality and recommendation KPI"
    - name: "Avg Audience Share"
      expr: AVG(CAST(audience_share AS DOUBLE))
      comment: "Average audience share, indicating competitive viewing strength"
    - name: "Avg Nielsen Program Rating"
      expr: AVG(CAST(nielsen_program_rating AS DOUBLE))
      comment: "Average Nielsen program rating tied to viewing sessions for monetization"
    - name: "Distinct Households Reached"
      expr: COUNT(DISTINCT household_id)
      comment: "Distinct households viewing, the household-reach base for ratings projections"
    - name: "Authenticated Viewing Rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_authenticated = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of authenticated sessions, a TV-Everywhere/login-wall adoption KPI"
    - name: "Viewing Sessions"
      expr: COUNT(1)
      comment: "Total viewing sessions, the consumption-volume baseline"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`audience_dsp_usage_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Digital music streaming (DSP) usage and royalty KPIs (Spotify/Apple/YouTube Music) used by music-licensing and finance leadership for catalog monetization."
  source: "`vibe_media_broadcasting_v1`.`audience`.`dsp_usage_report`"
  dimensions:
    - name: "report_month"
      expr: DATE_TRUNC('MONTH', report_period_start)
      comment: "Month of the DSP usage report for revenue trending"
    - name: "dsp_name"
      expr: dsp_name
      comment: "DSP/streaming service for platform-level revenue comparison"
    - name: "territory_code"
      expr: territory_code
      comment: "Territory for geographic royalty analysis"
    - name: "stream_type"
      expr: stream_type
      comment: "Stream type (interactive/non-interactive) for rights-classification analysis"
    - name: "subscription_tier"
      expr: subscription_tier
      comment: "Listener subscription tier driving per-stream rate differences"
  measures:
    - name: "Total Stream Count"
      expr: SUM(CAST(stream_count AS DOUBLE))
      comment: "Total streams reported, the volume base for catalog performance"
    - name: "Total Revenue Amount"
      expr: SUM(CAST(revenue_amount AS DOUBLE))
      comment: "Total streaming revenue, the core music-catalog monetization KPI"
    - name: "Total Revenue Share Amount"
      expr: SUM(CAST(revenue_share_amount AS DOUBLE))
      comment: "Total revenue share payable, used in royalty distribution and settlement"
    - name: "Avg Per Stream Rate"
      expr: AVG(CAST(per_stream_rate AS DOUBLE))
      comment: "Average per-stream payout rate, an effective-rate benchmark across DSPs"
    - name: "Total Unique Listeners"
      expr: SUM(CAST(unique_listeners AS DOUBLE))
      comment: "Total unique listeners, an audience-size indicator for catalog reach"
    - name: "Total Skip Count"
      expr: SUM(CAST(skip_count AS DOUBLE))
      comment: "Total skips, an engagement-quality indicator informing playlist strategy"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`audience_talent_demographic_appeal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Talent demographic-appeal (Q-Score style) KPIs used by casting, programming, and marketing leadership for talent-investment decisions."
  source: "`vibe_media_broadcasting_v1`.`audience`.`talent_demographic_appeal`"
  dimensions:
    - name: "measurement_month"
      expr: DATE_TRUNC('MONTH', measurement_date)
      comment: "Month of the appeal measurement for trend analysis"
    - name: "measurement_vendor"
      expr: measurement_vendor
      comment: "Measurement vendor for source-comparison of appeal scores"
    - name: "trend_direction"
      expr: trend_direction
      comment: "Trend direction of appeal for momentum-based casting decisions"
    - name: "casting_recommendation_flag"
      expr: casting_recommendation_flag
      comment: "Whether the talent is recommended for casting, a direct decision flag"
  measures:
    - name: "Avg Q Score"
      expr: AVG(CAST(q_score AS DOUBLE))
      comment: "Average Q-Score, the standard talent-likeability KPI driving casting and endorsement value"
    - name: "Avg Appeal Index"
      expr: AVG(CAST(appeal_index AS DOUBLE))
      comment: "Average demographic appeal index informing targeted programming"
    - name: "Avg Awareness Percentage"
      expr: AVG(CAST(awareness_percentage AS DOUBLE))
      comment: "Average audience awareness percentage, a talent-recognition KPI"
    - name: "Avg Favorability Rating"
      expr: AVG(CAST(favorability_rating AS DOUBLE))
      comment: "Average favorability rating, a brand-safety and marketing-fit indicator"
    - name: "Casting Recommended Rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN casting_recommendation_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of measurements yielding a casting recommendation — a talent-pipeline conversion KPI"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`audience_demographic_segment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Demographic-segment portfolio KPIs used by ad-sales and research to assess targetable-segment economics and reach potential."
  source: "`vibe_media_broadcasting_v1`.`audience`.`demographic_segment`"
  dimensions:
    - name: "segment_type"
      expr: segment_type
      comment: "Segment type for portfolio classification"
    - name: "segment_status"
      expr: segment_status
      comment: "Segment lifecycle status for active-segment filtering"
    - name: "is_key_demo"
      expr: is_key_demo
      comment: "Whether the segment is a key advertiser demo, prioritizing sales focus"
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the segment for market-level analysis"
  measures:
    - name: "Avg CPM Index"
      expr: AVG(CAST(cpm_index AS DOUBLE))
      comment: "Average CPM index, indicating relative monetization value of segments"
    - name: "Avg Reach Potential Pct"
      expr: AVG(CAST(reach_potential_pct AS DOUBLE))
      comment: "Average reach-potential percentage, sizing addressable opportunity per segment"
    - name: "Total Universe Estimate"
      expr: SUM(CAST(universe_estimate AS DOUBLE))
      comment: "Total universe estimate across segments, the addressable-population base"
    - name: "Key Demo Segment Rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_key_demo = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of segments classified as key demos — a portfolio-focus KPI for sales prioritization"
    - name: "Distinct Segments"
      expr: COUNT(DISTINCT demographic_segment_id)
      comment: "Distinct demographic segments maintained, a portfolio-coverage baseline"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`audience_panel`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Measurement-panel quality KPIs (cooperation, sampling error, accreditation) used by research leadership to govern measurement reliability and currency status."
  source: "`vibe_media_broadcasting_v1`.`audience`.`panel`"
  dimensions:
    - name: "panel_type"
      expr: panel_type
      comment: "Type of panel for methodology-level quality comparison"
    - name: "panel_status"
      expr: panel_status
      comment: "Panel lifecycle status for active-panel filtering"
    - name: "mrc_accreditation_status"
      expr: mrc_accreditation_status
      comment: "MRC accreditation status, a credibility gate for currency use"
    - name: "measurement_currency_flag"
      expr: measurement_currency_flag
      comment: "Whether the panel is a measurement currency, a high-stakes governance flag"
  measures:
    - name: "Avg Cooperation Rate"
      expr: AVG(CAST(cooperation_rate AS DOUBLE))
      comment: "Average panel cooperation rate, a leading indicator of data reliability"
    - name: "Avg Sampling Error Pct"
      expr: AVG(CAST(sampling_error_pct AS DOUBLE))
      comment: "Average sampling error percentage, a precision KPI for measurement confidence"
    - name: "Avg Weighting Factor"
      expr: AVG(CAST(weighting_factor AS DOUBLE))
      comment: "Average weighting factor applied, indicating panel-balance adjustments"
    - name: "Total Universe Estimate"
      expr: SUM(CAST(universe_estimate AS DOUBLE))
      comment: "Total universe represented across panels, the population-projection base"
    - name: "Currency Panel Rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN measurement_currency_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of panels serving as measurement currency — a governance-criticality KPI"
$$;