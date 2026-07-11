-- Metric views for domain: audience | Business: Media_Broadcasting | Version: 3 | Generated on: 2026-07-10 19:06:42

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`audience_nielsen_rating`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core Nielsen audience measurement KPIs tracking household ratings, GRP delivery, reach, and demographic performance across channels, dayparts, and sweeps periods. Used by programming, sales, and research teams to evaluate content performance and validate audience guarantees."
  source: "`vibe_media_broadcasting_v1`.`audience`.`nielsen_rating`"
  dimensions:
    - name: "air_date"
      expr: air_date
      comment: "Date the program aired, used for trend analysis and sweeps period comparisons."
    - name: "sweeps_period_flag"
      expr: sweeps_period_flag
      comment: "Indicates whether the rating was recorded during a Nielsen sweeps period, enabling sweeps vs. non-sweeps performance segmentation."
    - name: "rating_status"
      expr: rating_status
      comment: "Current status of the Nielsen rating record (e.g., preliminary, final, revised), used to filter for confirmed data."
    - name: "nielsen_report_week"
      expr: nielsen_report_week
      comment: "Nielsen report week label for weekly audience trend analysis."
    - name: "nielsen_program_code"
      expr: nielsen_program_code
      comment: "Nielsen program identifier for program-level audience performance analysis."
  measures:
    - name: "avg_household_rating"
      expr: AVG(CAST(household_rating AS DOUBLE))
      comment: "Average household rating across all measured programs. Core KPI for evaluating content reach relative to total TV households. Drives programming and scheduling decisions."
    - name: "avg_household_share"
      expr: AVG(CAST(household_share AS DOUBLE))
      comment: "Average household share (percentage of HUTs tuned to the program). Indicates competitive performance within the available viewing audience."
    - name: "total_impressions"
      expr: SUM(CAST(impressions AS DOUBLE))
      comment: "Total audience impressions delivered. Primary currency for advertising sales and audience guarantee reconciliation."
    - name: "avg_grp"
      expr: AVG(CAST(grp AS DOUBLE))
      comment: "Average Gross Rating Points delivered per program. Core advertising effectiveness metric used in upfront and scatter market negotiations."
    - name: "total_grp"
      expr: SUM(CAST(grp AS DOUBLE))
      comment: "Total GRP delivered across all measured programs. Used to assess cumulative audience weight for campaign delivery validation."
    - name: "avg_trp"
      expr: AVG(CAST(trp AS DOUBLE))
      comment: "Average Target Rating Points for the primary demographic. Drives demographic-specific advertising pricing and guarantee fulfillment."
    - name: "avg_demo_a18_49_rating"
      expr: AVG(CAST(demo_a18_49_rating AS DOUBLE))
      comment: "Average Adults 18-49 rating, the most commercially valuable demographic in broadcast television. Directly influences ad rates and upfront deal pricing."
    - name: "avg_demo_a25_54_rating"
      expr: AVG(CAST(demo_a25_54_rating AS DOUBLE))
      comment: "Average Adults 25-54 rating, key demographic for news and late-night programming. Used in targeted advertising and content strategy decisions."
    - name: "avg_demo_w18_49_rating"
      expr: AVG(CAST(demo_w18_49_rating AS DOUBLE))
      comment: "Average Women 18-49 rating. Critical for lifestyle, daytime, and primetime programming performance evaluation."
    - name: "avg_hut_level"
      expr: AVG(CAST(hut_level AS DOUBLE))
      comment: "Average Households Using Television level. Baseline audience availability metric used to contextualize share and rating performance."
    - name: "avg_put_level"
      expr: AVG(CAST(put_level AS DOUBLE))
      comment: "Average Persons Using Television level. Used for persons-based audience measurement and demographic targeting analysis."
    - name: "avg_cume_audience"
      expr: AVG(CAST(cume_audience AS DOUBLE))
      comment: "Average cumulative unduplicated audience across a time period. Measures total reach for programming and advertising effectiveness."
    - name: "avg_time_spent_viewing_min"
      expr: AVG(CAST(time_spent_viewing_min AS DOUBLE))
      comment: "Average time spent viewing in minutes. Engagement depth metric used to evaluate content stickiness and ad exposure duration."
    - name: "avg_frequency"
      expr: AVG(CAST(frequency AS DOUBLE))
      comment: "Average number of times the average viewer was exposed to the program. Used in reach/frequency optimization for advertising campaigns."
    - name: "avg_reach"
      expr: AVG(CAST(reach AS DOUBLE))
      comment: "Average unduplicated reach of the program. Measures breadth of audience exposure, critical for brand awareness campaign evaluation."
    - name: "total_programs_rated"
      expr: COUNT(1)
      comment: "Total number of program rating records. Used as a baseline volume metric for coverage and data completeness monitoring."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`audience_guarantee`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Audience guarantee performance KPIs tracking GRP/TRP delivery, makegood obligations, and guarantee fulfillment rates. Used by sales, research, and finance teams to manage advertiser commitments and identify delivery shortfalls requiring makegoods."
  source: "`vibe_media_broadcasting_v1`.`audience`.`guarantee`"
  dimensions:
    - name: "guarantee_status"
      expr: guarantee_status
      comment: "Current status of the audience guarantee (e.g., active, fulfilled, makegood_required). Primary filter for operational guarantee management."
    - name: "deal_type"
      expr: deal_type
      comment: "Type of advertising deal (e.g., upfront, scatter, direct). Enables performance comparison across deal structures."
    - name: "platform_type"
      expr: platform_type
      comment: "Platform on which the guarantee applies (e.g., linear, OTT, digital). Used for cross-platform guarantee analysis."
    - name: "rating_metric_type"
      expr: rating_metric_type
      comment: "Type of rating metric used for the guarantee (e.g., GRP, TRP, impressions). Enables metric-type segmentation of delivery performance."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation state of the guarantee (e.g., pending, reconciled, disputed). Used to track post-campaign settlement workflows."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the guarantee value is denominated. Required for multi-currency financial reporting."
    - name: "is_sweeps_period"
      expr: is_sweeps_period
      comment: "Indicates whether the guarantee covers a sweeps period. Sweeps guarantees carry higher commercial value and stricter delivery requirements."
    - name: "effective_start_date"
      expr: effective_start_date
      comment: "Start date of the guarantee period. Used for time-series analysis of guarantee portfolios."
  measures:
    - name: "total_guarantee_value"
      expr: SUM(CAST(total_guarantee_value AS DOUBLE))
      comment: "Total committed guarantee value in contract currency. Primary financial KPI for the audience guarantee portfolio, used in revenue forecasting and sales performance reporting."
    - name: "total_guaranteed_grp"
      expr: SUM(CAST(guaranteed_grp AS DOUBLE))
      comment: "Total GRP committed across all active guarantees. Measures the aggregate audience delivery obligation for the sales portfolio."
    - name: "total_actual_grp_delivered"
      expr: SUM(CAST(actual_grp_delivered AS DOUBLE))
      comment: "Total GRP actually delivered against guarantees. Compared against guaranteed GRP to assess delivery performance and makegood exposure."
    - name: "total_delivery_shortfall_grp"
      expr: SUM(CAST(delivery_shortfall_grp AS DOUBLE))
      comment: "Total GRP shortfall across all guarantees. Directly quantifies makegood liability and is a critical risk metric for the sales and finance teams."
    - name: "total_makegood_grp_issued"
      expr: SUM(CAST(makegood_grp_issued AS DOUBLE))
      comment: "Total makegood GRP issued to compensate for delivery shortfalls. Tracks the cost of under-delivery remediation and its impact on inventory."
    - name: "avg_grp_delivery_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_grp_delivered AS DOUBLE)) / NULLIF(SUM(CAST(guaranteed_grp AS DOUBLE)), 0), 2)
      comment: "Percentage of guaranteed GRP actually delivered. Core fulfillment KPI — values below 100% trigger makegood obligations and affect advertiser satisfaction."
    - name: "avg_cprp"
      expr: AVG(CAST(cprp AS DOUBLE))
      comment: "Average Cost Per Rating Point across guarantees. Pricing efficiency metric used in upfront negotiations and competitive benchmarking."
    - name: "total_guaranteed_trp"
      expr: SUM(CAST(guaranteed_trp AS DOUBLE))
      comment: "Total Target Rating Points committed across guarantees. Measures demographic-specific audience delivery obligations."
    - name: "total_actual_trp_delivered"
      expr: SUM(CAST(actual_trp_delivered AS DOUBLE))
      comment: "Total TRP actually delivered. Used alongside guaranteed TRP to calculate demographic delivery performance for targeted campaigns."
    - name: "avg_tolerance_threshold_pct"
      expr: AVG(CAST(tolerance_threshold_pct AS DOUBLE))
      comment: "Average delivery tolerance threshold percentage across guarantees. Defines the acceptable under-delivery band before makegood obligations are triggered."
    - name: "total_active_guarantees"
      expr: COUNT(1)
      comment: "Total number of audience guarantee records. Used as a portfolio size baseline for per-guarantee performance normalization."
    - name: "avg_guaranteed_reach"
      expr: AVG(CAST(guaranteed_reach AS DOUBLE))
      comment: "Average guaranteed reach percentage across commitments. Measures the breadth of audience exposure promised to advertisers."
    - name: "avg_guaranteed_frequency"
      expr: AVG(CAST(guaranteed_frequency AS DOUBLE))
      comment: "Average guaranteed frequency of exposure across commitments. Used to evaluate the depth of audience engagement promised in deals."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`audience_reach_frequency_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reach and frequency performance KPIs for advertising campaigns, tracking audience delivery efficiency, CPM, CPRP, and makegood requirements. Used by research, sales, and media planning teams to evaluate campaign effectiveness and optimize future buys."
  source: "`vibe_media_broadcasting_v1`.`audience`.`reach_frequency_report`"
  dimensions:
    - name: "report_status"
      expr: report_status
      comment: "Status of the reach/frequency report (e.g., draft, final, revised). Used to filter for confirmed measurement data."
    - name: "platform_type"
      expr: platform_type
      comment: "Platform type covered by the report (e.g., linear, OTT, digital). Enables cross-platform reach and frequency comparison."
    - name: "measurement_type"
      expr: measurement_type
      comment: "Type of measurement methodology applied (e.g., panel, census, hybrid). Used to segment reports by data quality and methodology."
    - name: "is_sweeps_period"
      expr: is_sweeps_period
      comment: "Indicates whether the report covers a sweeps measurement period. Sweeps data carries higher commercial weight."
    - name: "is_makegood_required"
      expr: is_makegood_required
      comment: "Flag indicating whether a makegood is required due to delivery shortfall. Critical operational filter for post-campaign reconciliation."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for financial metrics in the report. Required for multi-currency campaign analysis."
    - name: "measurement_period_start_date"
      expr: measurement_period_start_date
      comment: "Start date of the measurement period. Used for time-series campaign performance trending."
    - name: "report_version"
      expr: report_version
      comment: "Version of the report, distinguishing preliminary from final data. Used to ensure analysis uses the most current measurement."
  measures:
    - name: "total_impressions"
      expr: SUM(CAST(total_impressions AS DOUBLE))
      comment: "Total audience impressions delivered across all campaigns in scope. Primary volume metric for advertising delivery and billing reconciliation."
    - name: "avg_reach_pct"
      expr: AVG(CAST(reach_pct AS DOUBLE))
      comment: "Average unduplicated reach percentage of the target audience. Measures campaign breadth — a core KPI for brand awareness objectives."
    - name: "total_reach_persons"
      expr: SUM(CAST(reach_persons AS DOUBLE))
      comment: "Total unduplicated persons reached across campaigns. Absolute reach volume metric used in audience delivery reporting."
    - name: "avg_frequency"
      expr: AVG(CAST(average_frequency AS DOUBLE))
      comment: "Average number of times the target audience was exposed to the campaign. Frequency optimization is critical for message recall and ad effectiveness."
    - name: "avg_grp"
      expr: AVG(CAST(grp AS DOUBLE))
      comment: "Average Gross Rating Points delivered per report. Core advertising currency metric used to evaluate campaign weight and compare against guarantees."
    - name: "total_grp"
      expr: SUM(CAST(grp AS DOUBLE))
      comment: "Total GRP delivered across all campaigns in scope. Used for aggregate delivery performance assessment against upfront commitments."
    - name: "avg_trp"
      expr: AVG(CAST(trp AS DOUBLE))
      comment: "Average Target Rating Points delivered. Demographic-specific delivery metric used to validate targeted campaign performance."
    - name: "avg_cpm"
      expr: AVG(CAST(cpm AS DOUBLE))
      comment: "Average Cost Per Thousand impressions. Pricing efficiency metric used to benchmark campaign value and negotiate future buys."
    - name: "avg_cprp"
      expr: AVG(CAST(cprp AS DOUBLE))
      comment: "Average Cost Per Rating Point. Key pricing metric for GRP-based advertising deals, used in upfront and scatter market negotiations."
    - name: "avg_delivery_variance_pct"
      expr: AVG(CAST(delivery_variance_pct AS DOUBLE))
      comment: "Average delivery variance percentage against guaranteed levels. Measures systematic over- or under-delivery patterns to inform future guarantee calibration."
    - name: "total_effective_reach_1plus"
      expr: SUM(CAST(effective_reach_1plus AS DOUBLE))
      comment: "Total persons reached at least once (1+ frequency). Baseline effective reach metric for campaign coverage assessment."
    - name: "total_effective_reach_3plus"
      expr: SUM(CAST(effective_reach_3plus AS DOUBLE))
      comment: "Total persons reached at least three times (3+ frequency). Threshold reach metric associated with message recall and purchase intent lift."
    - name: "avg_hut_rating"
      expr: AVG(CAST(hut_rating AS DOUBLE))
      comment: "Average Households Using Television rating during the campaign period. Contextualizes campaign performance against total available viewing audience."
    - name: "avg_audience_share_pct"
      expr: AVG(CAST(audience_share_pct AS DOUBLE))
      comment: "Average audience share percentage. Measures competitive performance of the programming carrying the campaign."
    - name: "makegood_required_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_makegood_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of campaigns requiring a makegood due to delivery shortfall. Operational quality KPI — high rates signal systemic inventory or measurement issues."
    - name: "total_reports"
      expr: COUNT(1)
      comment: "Total number of reach/frequency reports. Used as a baseline volume metric for coverage and reporting completeness monitoring."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`audience_viewership_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Individual viewership event KPIs tracking audience engagement, completion rates, and platform distribution. Used by programming, digital, and advertising teams to understand viewing behavior, content performance, and subscriber engagement patterns."
  source: "`vibe_media_broadcasting_v1`.`audience`.`viewership_record`"
  dimensions:
    - name: "broadcast_date"
      expr: broadcast_date
      comment: "Date of the broadcast or streaming event. Primary time dimension for daily viewership trend analysis."
    - name: "platform_type"
      expr: platform_type
      comment: "Platform type (e.g., linear, OTT, MVPD). Enables cross-platform audience distribution analysis."
    - name: "delivery_type"
      expr: delivery_type
      comment: "Content delivery method (e.g., live, VOD, DVR). Used to segment viewership by consumption pattern."
    - name: "device_type"
      expr: device_type
      comment: "Device category used for viewing (e.g., TV, mobile, tablet). Informs device strategy and platform investment decisions."
    - name: "daypart"
      expr: daypart
      comment: "Daypart during which viewing occurred (e.g., primetime, daytime, late night). Core scheduling and advertising planning dimension."
    - name: "is_sweeps_period"
      expr: is_sweeps_period
      comment: "Indicates whether the viewing event occurred during a sweeps period. Used to compare sweeps vs. non-sweeps audience behavior."
    - name: "viewing_status"
      expr: viewing_status
      comment: "Status of the viewing record (e.g., complete, partial, abandoned). Used to segment engaged vs. disengaged viewers."
    - name: "country_code"
      expr: country_code
      comment: "Country of the viewing event. Enables geographic audience distribution analysis for rights and regulatory compliance."
    - name: "is_authenticated"
      expr: is_authenticated
      comment: "Indicates whether the viewer was authenticated (logged in). Distinguishes authenticated from anonymous viewership for subscriber analysis."
  measures:
    - name: "total_viewing_events"
      expr: COUNT(1)
      comment: "Total number of viewership records. Primary volume metric for audience scale and content consumption monitoring."
    - name: "total_unique_subscribers"
      expr: COUNT(DISTINCT subscriber_id)
      comment: "Total unique subscribers with viewership records. Measures active subscriber engagement — critical for churn prediction and content investment decisions."
    - name: "total_unique_households"
      expr: COUNT(DISTINCT household_id)
      comment: "Total unique households with viewership. Household-level reach metric used for Nielsen-comparable audience sizing."
    - name: "avg_completion_rate"
      expr: AVG(CAST(completion_rate AS DOUBLE))
      comment: "Average content completion rate across all viewing events. Measures content engagement depth — low completion rates signal content quality or UX issues."
    - name: "avg_nielsen_program_rating"
      expr: AVG(CAST(nielsen_program_rating AS DOUBLE))
      comment: "Average Nielsen program rating across viewership records. Bridges individual viewing data with panel-based ratings for cross-validation."
    - name: "avg_audience_share"
      expr: AVG(CAST(audience_share AS DOUBLE))
      comment: "Average audience share across viewership records. Competitive performance metric measuring the program's share of total available viewers."
    - name: "blackout_applied_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN blackout_applied = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of viewing events where a blackout was applied. Monitors rights enforcement compliance and potential viewer experience impact."
    - name: "drm_protected_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN drm_protected = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of viewing events with DRM protection active. Content security compliance metric used by rights and technology teams."
    - name: "authenticated_viewer_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_authenticated = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of viewing events from authenticated subscribers. Measures subscriber engagement vs. anonymous viewing — informs authentication strategy."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`audience_cross_platform_measurement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cross-platform audience measurement KPIs aggregating linear, OTT, MVPD, and social video impressions with GRP/TRP delivery. Used by research, sales, and programming leadership to evaluate total audience reach across all distribution platforms and validate cross-platform advertising commitments."
  source: "`vibe_media_broadcasting_v1`.`audience`.`cross_platform_measurement`"
  dimensions:
    - name: "measurement_period_start"
      expr: measurement_period_start
      comment: "Start date of the cross-platform measurement period. Primary time dimension for trend analysis."
    - name: "measurement_status"
      expr: measurement_status
      comment: "Status of the measurement record (e.g., preliminary, final). Used to filter for confirmed cross-platform data."
    - name: "distribution_type"
      expr: distribution_type
      comment: "Distribution type covered (e.g., linear, streaming, hybrid). Enables platform mix analysis."
    - name: "content_genre"
      expr: content_genre
      comment: "Genre of the content measured. Used to analyze audience performance by content category."
    - name: "daypart_code"
      expr: daypart_code
      comment: "Daypart code for the measurement period. Enables daypart-level cross-platform audience analysis."
    - name: "is_sweeps_period"
      expr: is_sweeps_period
      comment: "Indicates whether the measurement covers a sweeps period. Sweeps cross-platform data is used for annual rate card negotiations."
    - name: "is_mrc_accredited"
      expr: is_mrc_accredited
      comment: "Indicates whether the measurement is MRC-accredited. Accredited data is required for advertising currency and guarantee validation."
    - name: "currency_version"
      expr: currency_version
      comment: "Measurement currency version (e.g., Nielsen, Comscore). Used to segment analysis by measurement vendor and currency standard."
  measures:
    - name: "total_impressions"
      expr: SUM(CAST(total_impressions AS DOUBLE))
      comment: "Total cross-platform impressions delivered. Primary advertising currency metric for cross-platform deal valuation and delivery reporting."
    - name: "total_linear_impressions"
      expr: SUM(CAST(linear_impressions AS DOUBLE))
      comment: "Total linear TV impressions. Used to assess the contribution of traditional broadcast to total cross-platform reach."
    - name: "total_ott_streaming_impressions"
      expr: SUM(CAST(ott_streaming_impressions AS DOUBLE))
      comment: "Total OTT/streaming impressions. Measures digital audience scale and tracks the shift from linear to streaming consumption."
    - name: "total_mvpd_impressions"
      expr: SUM(CAST(mvpd_impressions AS DOUBLE))
      comment: "Total MVPD (cable/satellite) impressions. Used to evaluate pay-TV audience contribution to total cross-platform delivery."
    - name: "total_fast_channel_impressions"
      expr: SUM(CAST(fast_channel_impressions AS DOUBLE))
      comment: "Total FAST (Free Ad-Supported Streaming TV) channel impressions. Tracks the growing FAST audience segment for ad inventory planning."
    - name: "total_social_video_impressions"
      expr: SUM(CAST(social_video_impressions AS DOUBLE))
      comment: "Total social video impressions. Measures social platform audience contribution to total cross-platform campaign delivery."
    - name: "total_deduplicated_reach"
      expr: SUM(CAST(deduplicated_reach AS DOUBLE))
      comment: "Total deduplicated cross-platform reach (unique persons). The gold-standard reach metric for cross-platform advertising — eliminates double-counting across platforms."
    - name: "avg_cross_platform_grp"
      expr: AVG(CAST(cross_platform_grp AS DOUBLE))
      comment: "Average cross-platform GRP. Unified advertising currency metric enabling apples-to-apples comparison of cross-platform vs. linear-only campaign performance."
    - name: "total_cross_platform_grp"
      expr: SUM(CAST(cross_platform_grp AS DOUBLE))
      comment: "Total cross-platform GRP delivered. Used to validate cross-platform advertising guarantees and inform upfront pricing."
    - name: "avg_cross_platform_trp"
      expr: AVG(CAST(cross_platform_trp AS DOUBLE))
      comment: "Average cross-platform Target Rating Points. Demographic-specific cross-platform delivery metric for targeted advertising validation."
    - name: "avg_average_frequency"
      expr: AVG(CAST(average_frequency AS DOUBLE))
      comment: "Average cross-platform exposure frequency. Used to optimize reach/frequency balance in cross-platform media plans."
    - name: "avg_audience_share"
      expr: AVG(CAST(audience_share AS DOUBLE))
      comment: "Average cross-platform audience share. Competitive positioning metric measuring total platform share of available viewing audience."
    - name: "avg_hut_rating"
      expr: AVG(CAST(hut_rating AS DOUBLE))
      comment: "Average HUT rating in cross-platform measurement. Contextualizes cross-platform performance against total household viewing availability."
    - name: "ott_impression_share"
      expr: ROUND(100.0 * SUM(CAST(ott_streaming_impressions AS DOUBLE)) / NULLIF(SUM(CAST(total_impressions AS DOUBLE)), 0), 2)
      comment: "OTT impressions as a percentage of total cross-platform impressions. Strategic KPI tracking the digital transformation of audience consumption — rising share signals accelerating cord-cutting."
    - name: "total_target_universe_size"
      expr: SUM(CAST(target_universe_size AS DOUBLE))
      comment: "Total target demographic universe size across measurement records. Used to normalize GRP and TRP calculations and assess market penetration."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`audience_engagement_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Digital audience engagement event KPIs tracking viewer interaction depth, ad engagement, and streaming quality. Used by digital product, advertising, and audience development teams to optimize content experiences and measure advertising effectiveness in streaming environments."
  source: "`vibe_media_broadcasting_v1`.`audience`.`engagement_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of engagement event (e.g., play, pause, seek, ad_view, ad_skip). Primary dimension for engagement funnel analysis."
    - name: "event_status"
      expr: event_status
      comment: "Status of the engagement event (e.g., completed, error, abandoned). Used to filter for valid engagement data."
    - name: "platform_type_dimension"
      expr: device_type
      comment: "Device type used for the engagement event (e.g., CTV, mobile, desktop). Enables device-level engagement analysis for product optimization."
    - name: "daypart"
      expr: daypart
      comment: "Daypart during which the engagement event occurred. Used to identify peak engagement windows for content scheduling and ad placement."
    - name: "content_genre"
      expr: content_genre
      comment: "Genre of the content associated with the engagement event. Used to identify high-engagement content categories for programming investment."
    - name: "is_ad_event"
      expr: is_ad_event
      comment: "Indicates whether the event is an advertising engagement event. Used to separate content engagement from ad engagement metrics."
    - name: "is_sweeps_period"
      expr: is_sweeps_period
      comment: "Indicates whether the event occurred during a sweeps period. Used to compare engagement patterns during high-value measurement windows."
    - name: "subscription_tier"
      expr: subscription_tier
      comment: "Subscriber tier associated with the engagement event. Enables engagement analysis by subscription level for product and pricing decisions."
    - name: "stream_quality"
      expr: stream_quality
      comment: "Streaming quality level during the event. Used to correlate technical quality with engagement depth and completion rates."
    - name: "geo_country_code"
      expr: geo_country_code
      comment: "Country of the engagement event. Enables geographic audience engagement analysis for rights and content strategy."
  measures:
    - name: "total_engagement_events"
      expr: COUNT(1)
      comment: "Total number of engagement events. Primary volume metric for audience activity and platform usage monitoring."
    - name: "total_unique_viewers"
      expr: COUNT(DISTINCT viewer_profile_id)
      comment: "Total unique viewer profiles generating engagement events. Measures active audience size — critical for content reach and subscriber engagement reporting."
    - name: "avg_engagement_depth_score"
      expr: AVG(CAST(engagement_depth_score AS DOUBLE))
      comment: "Average engagement depth score across all events. Composite engagement quality metric — higher scores indicate deeper content interaction and stronger audience connection."
    - name: "avg_content_duration_ms"
      expr: AVG(CAST(content_duration_ms AS DOUBLE))
      comment: "Average content duration in milliseconds. Used to understand the typical content length driving engagement events."
    - name: "avg_content_position_ms"
      expr: AVG(CAST(content_position_ms AS DOUBLE))
      comment: "Average content position at time of event in milliseconds. Measures how far into content viewers engage — used to identify drop-off points and optimize content structure."
    - name: "ad_event_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_ad_event = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of engagement events that are advertising events. Measures ad load relative to content engagement — used to optimize ad density without degrading viewer experience."
    - name: "concurrent_stream_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_concurrent_stream = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of engagement events occurring in concurrent streaming sessions. Monitors multi-stream usage patterns for capacity planning and subscription tier enforcement."
    - name: "blackout_applied_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN blackout_applied = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of engagement events where content blackout was applied. Rights compliance metric — high rates in specific markets may indicate rights gaps or geo-targeting issues."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`audience_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Audience profile composition and identity KPIs used by data science, advertising, and audience development teams to understand the addressable audience, identity resolution quality, and demographic composition for targeting and measurement."
  source: "`vibe_media_broadcasting_v1`.`audience`.`audience_profile`"
  dimensions:
    - name: "profile_status"
      expr: profile_status
      comment: "Current status of the audience profile (e.g., active, inactive, suppressed). Used to filter for actionable audience segments."
    - name: "profile_type"
      expr: profile_type
      comment: "Type of audience profile (e.g., panel, census, modeled). Enables analysis by data quality and methodology tier."
    - name: "platform_preference"
      expr: platform_preference
      comment: "Preferred viewing platform of the audience profile. Used for platform-specific audience sizing and targeting strategy."
    - name: "primary_device_type"
      expr: primary_device_type
      comment: "Primary device type used by the audience profile. Informs device-level audience composition for ad targeting and product development."
    - name: "inferred_age_band"
      expr: inferred_age_band
      comment: "Inferred age band of the audience profile. Core demographic dimension for audience composition analysis and targeting."
    - name: "inferred_gender"
      expr: inferred_gender
      comment: "Inferred gender of the audience profile. Used for gender-based demographic targeting and audience composition reporting."
    - name: "income_band"
      expr: income_band
      comment: "Income band of the audience profile. Used for premium audience segmentation and advertiser targeting qualification."
    - name: "content_affinity_genre"
      expr: content_affinity_genre
      comment: "Primary content genre affinity of the audience profile. Used for content recommendation, programming strategy, and genre-based ad targeting."
    - name: "gdpr_consent_status"
      expr: gdpr_consent_status
      comment: "GDPR consent status of the audience profile. Required for privacy-compliant audience activation and data usage governance."
    - name: "hut_eligible"
      expr: hut_eligible
      comment: "Indicates whether the profile is eligible for HUT measurement. Used to size the panel-eligible audience for ratings currency purposes."
  measures:
    - name: "total_audience_profiles"
      expr: COUNT(1)
      comment: "Total number of audience profiles. Measures the size of the addressable audience universe — foundational metric for audience monetization and targeting scale."
    - name: "avg_ad_receptivity_score"
      expr: AVG(CAST(ad_receptivity_score AS DOUBLE))
      comment: "Average advertising receptivity score across audience profiles. Measures audience openness to advertising — higher scores indicate more monetizable audience segments."
    - name: "avg_identity_confidence_score"
      expr: AVG(CAST(identity_confidence_score AS DOUBLE))
      comment: "Average identity resolution confidence score. Measures data quality of the audience graph — low scores indicate identity resolution gaps that reduce targeting precision."
    - name: "avg_nielsen_grp_index"
      expr: AVG(CAST(nielsen_grp_index AS DOUBLE))
      comment: "Average Nielsen GRP index across audience profiles. Measures the relative audience value index compared to the total population — used for premium audience identification."
    - name: "avg_trp_index"
      expr: AVG(CAST(trp_index AS DOUBLE))
      comment: "Average TRP index across audience profiles. Demographic targeting efficiency metric — profiles with high TRP index deliver more efficient demographic reach."
    - name: "avg_panel_weight_factor"
      expr: AVG(CAST(panel_weight_factor AS DOUBLE))
      comment: "Average panel weight factor across profiles. Used to assess the representativeness of the panel sample relative to the total population."
    - name: "ccpa_opt_out_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN ccpa_opt_out = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audience profiles with CCPA opt-out. Privacy compliance KPI — rising opt-out rates reduce addressable audience size and monetization potential."
    - name: "data_clean_room_eligible_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN data_clean_room_eligible = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audience profiles eligible for data clean room activation. Measures the scale of privacy-safe audience data available for advertiser partnerships."
    - name: "hut_eligible_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN hut_eligible = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audience profiles eligible for HUT measurement. Measures the panel-eligible audience fraction used for ratings currency calculations."
    - name: "avg_avg_session_duration_minutes"
      expr: AVG(CAST(avg_session_duration_minutes AS DOUBLE))
      comment: "Average session duration in minutes across audience profiles. Engagement depth metric — longer sessions indicate higher content affinity and ad exposure opportunity."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`audience_demographic_segment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Demographic segment portfolio KPIs used by research, sales, and audience strategy teams to evaluate the commercial value, reach potential, and regulatory status of audience segments used in advertising targeting and guarantee negotiations."
  source: "`vibe_media_broadcasting_v1`.`audience`.`demographic_segment`"
  dimensions:
    - name: "segment_type"
      expr: segment_type
      comment: "Type of demographic segment (e.g., age/gender cell, psychographic, behavioral). Used to categorize the segment portfolio by methodology."
    - name: "segment_status"
      expr: segment_status
      comment: "Current status of the segment (e.g., active, deprecated, pending). Used to filter for commercially active segments."
    - name: "gender_qualifier"
      expr: gender_qualifier
      comment: "Gender qualifier for the segment. Core demographic targeting dimension for advertising sales."
    - name: "is_key_demo"
      expr: is_key_demo
      comment: "Indicates whether this is a key commercial demographic (e.g., A18-49). Key demos command premium CPMs and are central to upfront negotiations."
    - name: "is_nielsen_standard_cell"
      expr: is_nielsen_standard_cell
      comment: "Indicates whether the segment maps to a Nielsen standard measurement cell. Standard cells are required for ratings currency and guarantee validation."
    - name: "platform_applicability"
      expr: platform_applicability
      comment: "Platforms to which the segment applies (e.g., linear, digital, cross-platform). Used to scope segment usage by distribution channel."
    - name: "is_children_segment"
      expr: is_children_segment
      comment: "Indicates whether the segment targets children. Triggers COPPA compliance requirements and restricts advertising categories."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the segment (e.g., national, DMA, local). Used to match segments to appropriate market-level advertising buys."
  measures:
    - name: "total_segments"
      expr: COUNT(1)
      comment: "Total number of demographic segments in the portfolio. Measures the breadth of targeting options available for advertising sales."
    - name: "avg_cpm_index"
      expr: AVG(CAST(cpm_index AS DOUBLE))
      comment: "Average CPM index across demographic segments. Measures the relative commercial value of segments — high-index segments command premium pricing."
    - name: "avg_grp_weight_factor"
      expr: AVG(CAST(grp_weight_factor AS DOUBLE))
      comment: "Average GRP weight factor across segments. Used in audience measurement weighting to ensure representative ratings calculations."
    - name: "avg_reach_potential_pct"
      expr: AVG(CAST(reach_potential_pct AS DOUBLE))
      comment: "Average reach potential percentage across segments. Measures the addressable fraction of the total population for each segment — informs targeting scale decisions."
    - name: "total_universe_estimate"
      expr: SUM(CAST(universe_estimate AS DOUBLE))
      comment: "Total universe estimate across all segments. Measures the aggregate addressable audience size available for advertising targeting."
    - name: "key_demo_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_key_demo = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of segments classified as key commercial demographics. Measures the concentration of high-value targeting options in the segment portfolio."
    - name: "children_segment_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_children_segment = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of segments targeting children. Compliance risk metric — high rates require COPPA governance and restrict advertising revenue opportunities."
    - name: "nielsen_standard_cell_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_nielsen_standard_cell = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of segments that are Nielsen standard measurement cells. Measures the proportion of the segment portfolio usable as advertising currency."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`audience_sweeps_period`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Nielsen sweeps period performance and compliance KPIs used by research, programming, and regulatory teams to monitor sweeps data quality, measurement coverage, and regulatory reporting obligations. Sweeps periods are the primary basis for local market rate cards."
  source: "`vibe_media_broadcasting_v1`.`audience`.`sweeps_period`"
  dimensions:
    - name: "period_status"
      expr: period_status
      comment: "Current status of the sweeps period (e.g., active, completed, preliminary). Used to filter for confirmed sweeps data."
    - name: "sweep_month"
      expr: sweep_month
      comment: "Month of the sweeps period (e.g., February, May, July, November). Used to compare performance across the four annual sweeps books."
    - name: "sweep_year"
      expr: sweep_year
      comment: "Year of the sweeps period. Used for year-over-year sweeps performance comparison."
    - name: "market_scope"
      expr: market_scope
      comment: "Geographic scope of the sweeps period (e.g., national, local DMA). Used to segment sweeps analysis by market level."
    - name: "data_release_status"
      expr: data_release_status
      comment: "Status of sweeps data release (e.g., preliminary, final). Used to ensure analysis uses confirmed ratings data."
    - name: "grp_guarantee_applicable"
      expr: grp_guarantee_applicable
      comment: "Indicates whether GRP guarantees apply during this sweeps period. Used to identify periods with active advertising delivery obligations."
    - name: "regulatory_reporting_required"
      expr: regulatory_reporting_required
      comment: "Indicates whether regulatory reporting is required for this sweeps period. Used to track compliance obligations."
  measures:
    - name: "total_sweeps_periods"
      expr: COUNT(1)
      comment: "Total number of sweeps periods. Used as a baseline for sweeps coverage and historical trend analysis."
    - name: "avg_diary_return_rate_pct"
      expr: AVG(CAST(diary_return_rate_pct AS DOUBLE))
      comment: "Average diary return rate percentage across sweeps periods. Data quality KPI — low return rates reduce sample size and ratings reliability, affecting rate card credibility."
    - name: "avg_ppm_compliance_rate_pct"
      expr: AVG(CAST(ppm_compliance_rate_pct AS DOUBLE))
      comment: "Average PPM (Portable People Meter) compliance rate percentage. Measurement quality KPI — compliance rates below threshold invalidate panel data and require remediation."
    - name: "grp_guarantee_applicable_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN grp_guarantee_applicable = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sweeps periods with active GRP guarantees. Measures the commercial exposure tied to sweeps measurement — high rates indicate significant revenue at risk from ratings performance."
    - name: "regulatory_reporting_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN regulatory_reporting_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sweeps periods requiring regulatory reporting. Compliance burden metric used by legal and regulatory affairs teams."
    - name: "hut_measurement_coverage_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN hut_measurement_included = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sweeps periods including HUT measurement. Measures the completeness of household-level audience measurement coverage."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`audience_market_coverage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Market coverage portfolio KPIs used by distribution, sales, and regulatory teams to evaluate the geographic footprint, audience universe size, and platform penetration across DMA markets. Drives local advertising pricing and distribution strategy."
  source: "`vibe_media_broadcasting_v1`.`audience`.`market_coverage`"
  dimensions:
    - name: "market_status"
      expr: market_status
      comment: "Current status of the market coverage record (e.g., active, inactive). Used to filter for commercially active markets."
    - name: "market_type"
      expr: market_type
      comment: "Type of market (e.g., DMA, cable zone, OTT market). Used to segment coverage analysis by market structure."
    - name: "country_code"
      expr: country_code
      comment: "Country of the market. Used for international market portfolio analysis."
    - name: "primary_language"
      expr: primary_language
      comment: "Primary language of the market. Used for language-based audience segmentation and content localization decisions."
    - name: "sweeps_participation"
      expr: sweeps_participation
      comment: "Indicates whether the market participates in Nielsen sweeps. Sweeps markets have higher commercial value due to ratings-based rate cards."
    - name: "must_carry_applicable"
      expr: must_carry_applicable
      comment: "Indicates whether must-carry rules apply in this market. Regulatory dimension affecting distribution agreements and carriage negotiations."
    - name: "measurement_frequency"
      expr: measurement_frequency
      comment: "Frequency of audience measurement in the market (e.g., continuous, sweeps-only). Used to assess data availability for sales and programming decisions."
  measures:
    - name: "total_markets"
      expr: COUNT(1)
      comment: "Total number of market coverage records. Measures the geographic footprint of the broadcast network."
    - name: "total_tv_household_universe"
      expr: SUM(CAST(tv_household_universe AS DOUBLE))
      comment: "Total TV household universe across all markets. Primary audience scale metric — the denominator for national ratings calculations and total addressable market sizing."
    - name: "total_population_universe"
      expr: SUM(CAST(population_universe AS DOUBLE))
      comment: "Total population universe across all markets. Used for persons-based audience measurement and demographic targeting scale assessment."
    - name: "avg_cable_penetration_rate"
      expr: AVG(CAST(cable_penetration_rate AS DOUBLE))
      comment: "Average cable penetration rate across markets. Distribution reach metric used to assess pay-TV audience availability for cable network advertising."
    - name: "avg_ott_penetration_rate"
      expr: AVG(CAST(ott_penetration_rate AS DOUBLE))
      comment: "Average OTT penetration rate across markets. Digital transformation metric — rising OTT penetration signals audience migration from linear TV and informs streaming investment strategy."
    - name: "avg_hut_base_estimate"
      expr: AVG(CAST(hut_base_estimate AS DOUBLE))
      comment: "Average HUT base estimate across markets. Baseline audience availability metric used to normalize ratings and share calculations."
    - name: "avg_hispanic_tv_household_pct"
      expr: AVG(CAST(hispanic_tv_household_pct AS DOUBLE))
      comment: "Average Hispanic TV household percentage across markets. Demographic composition metric used for Spanish-language programming strategy and targeted advertising."
    - name: "avg_median_household_income"
      expr: AVG(CAST(median_household_income AS DOUBLE))
      comment: "Average median household income across markets. Market quality metric used to identify premium advertising markets and inform CPM pricing strategy."
    - name: "sweeps_market_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN sweeps_participation = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of markets participating in Nielsen sweeps. Measures the proportion of the market portfolio with ratings-based rate cards."
$$;