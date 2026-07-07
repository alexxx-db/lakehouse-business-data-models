-- Metric views for domain: distribution | Business: Media_Broadcasting | Version: 2 | Generated on: 2026-06-30 06:47:57

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`distribution_carriage_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic carriage agreement economics and renewal risk metrics for distribution partnerships"
  source: "`vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the carriage agreement (active, expired, pending renewal)"
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of carriage agreement (retransmission consent, must-carry, negotiated)"
    - name: "channel_positioning_tier"
      expr: channel_positioning_tier
      comment: "Tier placement of channel in partner lineup (basic, premium, sports)"
    - name: "carriage_fee_structure"
      expr: carriage_fee_structure
      comment: "Fee structure model (per-subscriber, flat-fee, tiered)"
    - name: "geographic_coverage"
      expr: geographic_coverage
      comment: "Geographic territory covered by the agreement"
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Whether agreement automatically renews"
    - name: "must_carry_election"
      expr: must_carry_election
      comment: "Whether broadcaster elected must-carry status"
    - name: "retransmission_consent_granted"
      expr: retransmission_consent_granted
      comment: "Whether retransmission consent was granted"
    - name: "agreement_year"
      expr: YEAR(effective_date)
      comment: "Year the agreement became effective"
    - name: "expiration_year"
      expr: YEAR(expiration_date)
      comment: "Year the agreement expires"
    - name: "agreement_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the agreement became effective"
  measures:
    - name: "total_carriage_agreements"
      expr: COUNT(1)
      comment: "Total number of carriage agreements"
    - name: "total_carriage_fee_revenue"
      expr: SUM(CAST(carriage_fee_amount AS DOUBLE))
      comment: "Total carriage fee revenue across all agreements"
    - name: "avg_carriage_fee_per_agreement"
      expr: AVG(CAST(carriage_fee_amount AS DOUBLE))
      comment: "Average carriage fee amount per agreement"
    - name: "distinct_partners"
      expr: COUNT(DISTINCT partner_id)
      comment: "Number of unique distribution partners with carriage agreements"
    - name: "distinct_channels"
      expr: COUNT(DISTINCT channel_id)
      comment: "Number of unique channels covered by carriage agreements"
    - name: "auto_renewal_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN auto_renewal_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of agreements with auto-renewal provisions (renewal risk indicator)"
    - name: "retransmission_consent_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN retransmission_consent_granted = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of agreements with retransmission consent granted (negotiation leverage indicator)"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`distribution_deal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Distribution deal economics, revenue models, and partnership performance metrics"
  source: "`vibe_media_broadcasting_v1`.`distribution`.`deal`"
  dimensions:
    - name: "deal_status"
      expr: deal_status
      comment: "Current status of the distribution deal"
    - name: "deal_type"
      expr: deal_type
      comment: "Type of distribution deal (licensing, syndication, programmatic)"
    - name: "revenue_model"
      expr: revenue_model
      comment: "Revenue model for the deal (revenue share, flat fee, CPM, hybrid)"
    - name: "territory"
      expr: territory
      comment: "Geographic territory covered by the deal"
    - name: "exclusivity_flag"
      expr: exclusivity_flag
      comment: "Whether deal grants exclusive distribution rights"
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Whether deal automatically renews"
    - name: "programmatic_deal_type"
      expr: programmatic_deal_type
      comment: "Type of programmatic deal (PMP, PG, open auction)"
    - name: "sla_tier"
      expr: sla_tier
      comment: "Service level agreement tier"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the deal became effective"
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the deal became effective"
    - name: "signed_year"
      expr: YEAR(signed_date)
      comment: "Year the deal was signed"
  measures:
    - name: "total_deals"
      expr: COUNT(1)
      comment: "Total number of distribution deals"
    - name: "total_flat_fee_value"
      expr: SUM(CAST(flat_fee_amount AS DOUBLE))
      comment: "Total flat fee revenue committed across all deals"
    - name: "total_minimum_guarantee"
      expr: SUM(CAST(minimum_guarantee_amount AS DOUBLE))
      comment: "Total minimum guarantee revenue across all deals"
    - name: "avg_revenue_share_pct"
      expr: AVG(CAST(revenue_share_percentage AS DOUBLE))
      comment: "Average revenue share percentage across deals"
    - name: "avg_floor_price_cpm"
      expr: AVG(CAST(floor_price_cpm AS DOUBLE))
      comment: "Average programmatic floor price CPM across deals"
    - name: "total_subscriber_guarantees"
      expr: SUM(CAST(minimum_subscriber_guarantee AS DOUBLE))
      comment: "Total minimum subscriber guarantees committed across deals"
    - name: "distinct_partners"
      expr: COUNT(DISTINCT partner_id)
      comment: "Number of unique distribution partners with active deals"
    - name: "distinct_platforms"
      expr: COUNT(DISTINCT ott_platform_id)
      comment: "Number of unique OTT platforms with active deals"
    - name: "exclusivity_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN exclusivity_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deals with exclusivity provisions (market concentration indicator)"
    - name: "auto_renewal_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN auto_renewal_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deals with auto-renewal (revenue stability indicator)"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`distribution_content_delivery_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Content delivery fulfillment efficiency, SLA compliance, and operational quality metrics"
  source: "`vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the delivery order (pending, in-progress, completed, failed)"
    - name: "order_type"
      expr: order_type
      comment: "Type of delivery order (VOD, live, linear, archive)"
    - name: "delivery_method"
      expr: delivery_method
      comment: "Method used for content delivery (push, pull, streaming)"
    - name: "delivery_format"
      expr: delivery_format
      comment: "Format of delivered content (HLS, DASH, MP4, ProRes)"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the delivery order (urgent, high, normal, low)"
    - name: "sla_tier"
      expr: sla_tier
      comment: "Service level agreement tier for delivery"
    - name: "video_resolution"
      expr: video_resolution
      comment: "Video resolution of delivered content (4K, 1080p, 720p)"
    - name: "hdr_format"
      expr: hdr_format
      comment: "HDR format of delivered content (HDR10, Dolby Vision, HLG)"
    - name: "closed_captions_included"
      expr: closed_captions_included
      comment: "Whether closed captions were included in delivery"
    - name: "order_date_month"
      expr: DATE_TRUNC('MONTH', order_date)
      comment: "Month the order was placed"
    - name: "requested_delivery_month"
      expr: DATE_TRUNC('MONTH', requested_delivery_date)
      comment: "Month delivery was requested"
  measures:
    - name: "total_delivery_orders"
      expr: COUNT(1)
      comment: "Total number of content delivery orders"
    - name: "total_content_volume_gb"
      expr: SUM(CAST(file_size_gb AS DOUBLE))
      comment: "Total volume of content delivered in gigabytes"
    - name: "avg_file_size_gb"
      expr: AVG(CAST(file_size_gb AS DOUBLE))
      comment: "Average file size per delivery order in gigabytes"
    - name: "distinct_media_assets"
      expr: COUNT(DISTINCT media_asset_id)
      comment: "Number of unique media assets delivered"
    - name: "distinct_partners"
      expr: COUNT(DISTINCT partner_id)
      comment: "Number of unique partners receiving deliveries"
    - name: "distinct_platforms"
      expr: COUNT(DISTINCT ott_platform_id)
      comment: "Number of unique OTT platforms receiving deliveries"
    - name: "on_time_delivery_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN actual_delivery_timestamp <= delivery_deadline_timestamp THEN 1 ELSE 0 END) / NULLIF(COUNT(CASE WHEN actual_delivery_timestamp IS NOT NULL AND delivery_deadline_timestamp IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of orders delivered on or before deadline (SLA compliance indicator)"
    - name: "delivery_success_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN order_status = 'completed' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of delivery orders successfully completed (operational quality indicator)"
    - name: "closed_caption_inclusion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN closed_captions_included = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deliveries including closed captions (accessibility compliance indicator)"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`distribution_delivery_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Real-time content delivery performance, CDN efficiency, and streaming quality metrics"
  source: "`vibe_media_broadcasting_v1`.`distribution`.`delivery_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of delivery event (start, stop, error, buffer, quality-change)"
    - name: "delivery_status"
      expr: delivery_status
      comment: "Status of the delivery (success, failure, timeout)"
    - name: "delivery_technology"
      expr: delivery_technology
      comment: "Technology used for delivery (CDN, P2P, direct)"
    - name: "streaming_protocol"
      expr: streaming_protocol
      comment: "Streaming protocol used (HLS, DASH, RTMP, WebRTC)"
    - name: "cdn_cache_status"
      expr: cdn_cache_status
      comment: "CDN cache hit/miss status"
    - name: "cdn_pop_location"
      expr: cdn_pop_location
      comment: "CDN point-of-presence location"
    - name: "resolution"
      expr: resolution
      comment: "Video resolution delivered (4K, 1080p, 720p, 480p)"
    - name: "video_codec"
      expr: video_codec
      comment: "Video codec used (H.264, H.265, VP9, AV1)"
    - name: "audio_codec"
      expr: audio_codec
      comment: "Audio codec used (AAC, AC3, Opus)"
    - name: "drm_system"
      expr: drm_system
      comment: "DRM system used (Widevine, FairPlay, PlayReady)"
    - name: "dai_enabled"
      expr: dai_enabled
      comment: "Whether dynamic ad insertion was enabled"
    - name: "geographic_country_code"
      expr: geographic_country_code
      comment: "Country code of viewer location"
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region of viewer"
    - name: "sla_tier"
      expr: sla_tier
      comment: "Service level agreement tier"
    - name: "event_date"
      expr: DATE_TRUNC('DAY', event_timestamp)
      comment: "Date of the delivery event"
    - name: "event_hour"
      expr: DATE_TRUNC('HOUR', event_timestamp)
      comment: "Hour of the delivery event"
  measures:
    - name: "total_delivery_events"
      expr: COUNT(1)
      comment: "Total number of delivery events"
    - name: "total_bytes_delivered"
      expr: SUM(CAST(bytes_delivered AS DOUBLE))
      comment: "Total bytes delivered across all events"
    - name: "avg_bytes_per_event"
      expr: AVG(CAST(bytes_delivered AS DOUBLE))
      comment: "Average bytes delivered per event"
    - name: "avg_ad_fill_rate_pct"
      expr: AVG(CAST(ad_fill_rate_percent AS DOUBLE))
      comment: "Average ad fill rate percentage (monetization efficiency indicator)"
    - name: "distinct_media_assets"
      expr: COUNT(DISTINCT media_asset_id)
      comment: "Number of unique media assets delivered"
    - name: "distinct_channels"
      expr: COUNT(DISTINCT channel_id)
      comment: "Number of unique channels with delivery events"
    - name: "distinct_partners"
      expr: COUNT(DISTINCT partner_id)
      comment: "Number of unique partners with delivery events"
    - name: "distinct_streaming_endpoints"
      expr: COUNT(DISTINCT streaming_endpoint_id)
      comment: "Number of unique streaming endpoints used"
    - name: "cdn_cache_hit_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN cdn_cache_status = 'hit' THEN 1 ELSE 0 END) / NULLIF(COUNT(CASE WHEN cdn_cache_status IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of CDN cache hits (CDN efficiency and cost indicator)"
    - name: "delivery_success_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN delivery_status = 'success' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of successful delivery events (streaming quality indicator)"
    - name: "dai_adoption_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN dai_enabled = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of events with dynamic ad insertion enabled (monetization capability indicator)"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`distribution_playback_session`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Viewer engagement, streaming quality of experience, and content consumption metrics"
  source: "`vibe_media_broadcasting_v1`.`distribution`.`playback_session`"
  dimensions:
    - name: "playback_mode"
      expr: playback_mode
      comment: "Mode of playback (live, VOD, DVR, time-shift)"
    - name: "exit_reason"
      expr: exit_reason
      comment: "Reason viewer exited session (completed, user-stop, error, timeout)"
    - name: "streaming_protocol"
      expr: streaming_protocol
      comment: "Streaming protocol used (HLS, DASH, RTMP)"
    - name: "video_resolution"
      expr: video_resolution
      comment: "Video resolution of playback (4K, 1080p, 720p, 480p)"
    - name: "audio_language"
      expr: audio_language
      comment: "Audio language selected by viewer"
    - name: "subtitle_language"
      expr: subtitle_language
      comment: "Subtitle language selected by viewer"
    - name: "closed_captions_enabled"
      expr: closed_captions_enabled
      comment: "Whether closed captions were enabled"
    - name: "dai_enabled"
      expr: dai_enabled
      comment: "Whether dynamic ad insertion was enabled"
    - name: "cdn_pop_location"
      expr: cdn_pop_location
      comment: "CDN point-of-presence location serving the session"
    - name: "geographic_city"
      expr: geographic_city
      comment: "City of viewer location"
    - name: "session_date"
      expr: DATE_TRUNC('DAY', session_start_timestamp)
      comment: "Date the playback session started"
    - name: "session_hour"
      expr: DATE_TRUNC('HOUR', session_start_timestamp)
      comment: "Hour the playback session started"
  measures:
    - name: "total_playback_sessions"
      expr: COUNT(1)
      comment: "Total number of playback sessions"
    - name: "avg_completion_pct"
      expr: AVG(CAST(completion_percentage AS DOUBLE))
      comment: "Average content completion percentage (engagement indicator)"
    - name: "avg_watch_duration_seconds"
      expr: AVG(CAST(total_watch_duration_seconds AS DOUBLE))
      comment: "Average watch duration per session in seconds"
    - name: "total_watch_hours"
      expr: SUM(CAST(total_watch_duration_seconds AS DOUBLE)) / 3600.0
      comment: "Total watch time across all sessions in hours (key engagement metric)"
    - name: "avg_bitrate_kbps"
      expr: AVG(CAST(average_bitrate_kbps AS DOUBLE))
      comment: "Average streaming bitrate in kbps (quality indicator)"
    - name: "avg_rebuffering_events"
      expr: AVG(CAST(rebuffering_events_count AS DOUBLE))
      comment: "Average number of rebuffering events per session (quality of experience indicator)"
    - name: "avg_initial_buffering_ms"
      expr: AVG(CAST(initial_buffering_duration_ms AS DOUBLE))
      comment: "Average initial buffering time in milliseconds (startup quality indicator)"
    - name: "avg_ad_duration_seconds"
      expr: AVG(CAST(total_ad_duration_seconds AS DOUBLE))
      comment: "Average ad duration per session in seconds"
    - name: "total_ad_hours_delivered"
      expr: SUM(CAST(total_ad_duration_seconds AS DOUBLE)) / 3600.0
      comment: "Total ad time delivered across all sessions in hours (monetization volume)"
    - name: "distinct_subscribers"
      expr: COUNT(DISTINCT subscriber_id)
      comment: "Number of unique subscribers with playback sessions"
    - name: "distinct_media_assets"
      expr: COUNT(DISTINCT media_asset_id)
      comment: "Number of unique media assets played"
    - name: "distinct_platforms"
      expr: COUNT(DISTINCT ott_platform_id)
      comment: "Number of unique OTT platforms with playback sessions"
    - name: "completion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN CAST(completion_percentage AS DOUBLE) >= 90.0 THEN 1 ELSE 0 END) / NULLIF(COUNT(CASE WHEN completion_percentage IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of sessions with 90%+ completion (content engagement quality indicator)"
    - name: "error_free_session_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN error_code IS NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sessions without errors (streaming reliability indicator)"
    - name: "closed_caption_usage_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN closed_captions_enabled = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sessions with closed captions enabled (accessibility adoption indicator)"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`distribution_ott_platform`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "OTT platform subscriber economics, technical capability, and service quality metrics"
  source: "`vibe_media_broadcasting_v1`.`distribution`.`ott_platform`"
  dimensions:
    - name: "platform_name"
      expr: platform_name
      comment: "Name of the OTT platform"
    - name: "platform_status"
      expr: platform_status
      comment: "Current operational status of the platform"
    - name: "service_tier"
      expr: service_tier
      comment: "Service tier of the platform (free, basic, premium, enterprise)"
    - name: "parent_brand"
      expr: parent_brand
      comment: "Parent brand or company owning the platform"
    - name: "drm_system"
      expr: drm_system
      comment: "DRM system used by the platform"
    - name: "cdn_provider"
      expr: cdn_provider
      comment: "CDN provider used by the platform"
    - name: "dai_provider"
      expr: dai_provider
      comment: "Dynamic ad insertion provider"
    - name: "primary_streaming_protocol"
      expr: primary_streaming_protocol
      comment: "Primary streaming protocol used (HLS, DASH)"
    - name: "max_video_resolution"
      expr: max_video_resolution
      comment: "Maximum video resolution supported"
    - name: "fast_channel_enabled"
      expr: fast_channel_enabled
      comment: "Whether FAST (Free Ad-Supported TV) channels are enabled"
    - name: "dai_enabled"
      expr: dai_enabled
      comment: "Whether dynamic ad insertion is enabled"
    - name: "programmatic_enabled"
      expr: programmatic_enabled
      comment: "Whether programmatic advertising is enabled"
    - name: "hdr_supported"
      expr: hdr_supported
      comment: "Whether HDR video is supported"
    - name: "gdpr_applicable"
      expr: gdpr_applicable
      comment: "Whether GDPR regulations apply"
    - name: "coppa_compliant"
      expr: coppa_compliant
      comment: "Whether platform is COPPA compliant"
    - name: "launch_year"
      expr: YEAR(launch_date)
      comment: "Year the platform launched"
  measures:
    - name: "total_ott_platforms"
      expr: COUNT(1)
      comment: "Total number of OTT platforms"
    - name: "total_subscribers"
      expr: SUM(CAST(subscriber_count AS DOUBLE))
      comment: "Total subscriber count across all platforms"
    - name: "avg_subscribers_per_platform"
      expr: AVG(CAST(subscriber_count AS DOUBLE))
      comment: "Average subscriber count per platform"
    - name: "total_subscription_revenue"
      expr: SUM(CAST(base_subscription_price AS DOUBLE) * CAST(subscriber_count AS DOUBLE))
      comment: "Total monthly subscription revenue across all platforms (key revenue metric)"
    - name: "avg_subscription_price"
      expr: AVG(CAST(base_subscription_price AS DOUBLE))
      comment: "Average base subscription price across platforms"
    - name: "avg_arpu"
      expr: AVG(CAST(arpu AS DOUBLE))
      comment: "Average revenue per user across platforms (monetization efficiency indicator)"
    - name: "avg_sla_uptime_target"
      expr: AVG(CAST(sla_uptime_target_pct AS DOUBLE))
      comment: "Average SLA uptime target percentage"
    - name: "fast_channel_adoption_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN fast_channel_enabled = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of platforms with FAST channels enabled (FAST strategy indicator)"
    - name: "dai_adoption_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN dai_enabled = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of platforms with dynamic ad insertion enabled (monetization capability)"
    - name: "programmatic_adoption_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN programmatic_enabled = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of platforms with programmatic advertising enabled (ad tech maturity indicator)"
    - name: "hdr_support_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN hdr_supported = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of platforms supporting HDR (premium quality capability indicator)"
    - name: "gdpr_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN gdpr_applicable = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of platforms subject to GDPR (regulatory scope indicator)"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`distribution_partner`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Distribution partner relationship quality, technical capability, and reach metrics"
  source: "`vibe_media_broadcasting_v1`.`distribution`.`partner`"
  dimensions:
    - name: "partner_type"
      expr: partner_type
      comment: "Type of distribution partner (MVPD, vMVPD, OTT, syndication, affiliate)"
    - name: "relationship_status"
      expr: relationship_status
      comment: "Current status of partner relationship (active, inactive, pending, terminated)"
    - name: "tier"
      expr: tier
      comment: "Partner tier classification (platinum, gold, silver, bronze)"
    - name: "geographic_footprint"
      expr: geographic_footprint
      comment: "Geographic coverage of partner (national, regional, local, international)"
    - name: "headquarters_country_code"
      expr: headquarters_country_code
      comment: "Country code of partner headquarters"
    - name: "cdn_provider"
      expr: cdn_provider
      comment: "CDN provider used by partner"
    - name: "drm_capability"
      expr: drm_capability
      comment: "DRM systems supported by partner"
    - name: "carriage_fee_model"
      expr: carriage_fee_model
      comment: "Fee model used for carriage (per-subscriber, flat-fee, tiered)"
    - name: "dai_support_flag"
      expr: dai_support_flag
      comment: "Whether partner supports dynamic ad insertion"
    - name: "blackout_capability_flag"
      expr: blackout_capability_flag
      comment: "Whether partner supports content blackout enforcement"
    - name: "must_carry_obligation_flag"
      expr: must_carry_obligation_flag
      comment: "Whether partner has must-carry obligations"
    - name: "qos_monitoring_enabled_flag"
      expr: qos_monitoring_enabled_flag
      comment: "Whether quality-of-service monitoring is enabled"
    - name: "contract_start_year"
      expr: YEAR(contract_start_date)
      comment: "Year the partner contract started"
  measures:
    - name: "total_partners"
      expr: COUNT(1)
      comment: "Total number of distribution partners"
    - name: "total_subscriber_reach"
      expr: SUM(CAST(subscriber_reach_estimate AS DOUBLE))
      comment: "Total estimated subscriber reach across all partners (market reach indicator)"
    - name: "avg_subscriber_reach"
      expr: AVG(CAST(subscriber_reach_estimate AS DOUBLE))
      comment: "Average subscriber reach per partner"
    - name: "avg_sla_uptime_target"
      expr: AVG(CAST(sla_uptime_target_percent AS DOUBLE))
      comment: "Average SLA uptime target percentage across partners"
    - name: "distinct_accounts"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique accounts associated with partners"
    - name: "dai_support_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN dai_support_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of partners supporting dynamic ad insertion (monetization capability indicator)"
    - name: "blackout_capability_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN blackout_capability_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of partners with blackout enforcement capability (rights management indicator)"
    - name: "qos_monitoring_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN qos_monitoring_enabled_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of partners with QoS monitoring enabled (service quality visibility indicator)"
    - name: "must_carry_obligation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN must_carry_obligation_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of partners with must-carry obligations (regulatory compliance indicator)"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`distribution_streaming_endpoint`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Streaming infrastructure capacity, cost efficiency, and operational health metrics"
  source: "`vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint`"
  dimensions:
    - name: "endpoint_type"
      expr: endpoint_type
      comment: "Type of streaming endpoint (origin, edge, CDN, P2P)"
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status (active, inactive, maintenance, degraded)"
    - name: "streaming_protocol"
      expr: streaming_protocol
      comment: "Streaming protocol supported (HLS, DASH, RTMP, WebRTC)"
    - name: "manifest_format"
      expr: manifest_format
      comment: "Manifest format used (M3U8, MPD, SMIL)"
    - name: "geo_restriction_mode"
      expr: geo_restriction_mode
      comment: "Geographic restriction mode (whitelist, blacklist, none)"
    - name: "dai_enabled"
      expr: dai_enabled
      comment: "Whether dynamic ad insertion is enabled"
    - name: "ipv6_enabled"
      expr: ipv6_enabled
      comment: "Whether IPv6 is enabled"
    - name: "token_authentication_scheme"
      expr: token_authentication_scheme
      comment: "Token authentication scheme used (JWT, HMAC, none)"
    - name: "provisioned_year"
      expr: YEAR(provisioned_date)
      comment: "Year the endpoint was provisioned"
    - name: "ssl_expiry_year"
      expr: YEAR(ssl_certificate_expiry_date)
      comment: "Year the SSL certificate expires"
  measures:
    - name: "total_streaming_endpoints"
      expr: COUNT(1)
      comment: "Total number of streaming endpoints"
    - name: "total_bandwidth_capacity_gbps"
      expr: SUM(CAST(bandwidth_limit_gbps AS DOUBLE))
      comment: "Total bandwidth capacity across all endpoints in Gbps (infrastructure capacity indicator)"
    - name: "avg_bandwidth_capacity_gbps"
      expr: AVG(CAST(bandwidth_limit_gbps AS DOUBLE))
      comment: "Average bandwidth capacity per endpoint in Gbps"
    - name: "avg_cost_per_gb"
      expr: AVG(CAST(cost_per_gb AS DOUBLE))
      comment: "Average cost per gigabyte delivered (cost efficiency indicator)"
    - name: "total_delivery_cost"
      expr: SUM(CAST(cost_per_gb AS DOUBLE) * CAST(bandwidth_limit_gbps AS DOUBLE))
      comment: "Total estimated delivery cost based on capacity and per-GB cost (infrastructure cost metric)"
    - name: "avg_max_bitrate_mbps"
      expr: AVG(CAST(max_bitrate_mbps AS DOUBLE))
      comment: "Average maximum bitrate supported in Mbps"
    - name: "avg_sla_uptime_target"
      expr: AVG(CAST(sla_uptime_target_percent AS DOUBLE))
      comment: "Average SLA uptime target percentage"
    - name: "distinct_platforms"
      expr: COUNT(DISTINCT ott_platform_id)
      comment: "Number of unique OTT platforms using these endpoints"
    - name: "distinct_channels"
      expr: COUNT(DISTINCT channel_id)
      comment: "Number of unique channels served by these endpoints"
    - name: "dai_adoption_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN dai_enabled = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of endpoints with dynamic ad insertion enabled (monetization infrastructure indicator)"
    - name: "ipv6_adoption_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN ipv6_enabled = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of endpoints with IPv6 enabled (modern infrastructure indicator)"
    - name: "geo_restricted_endpoint_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN geo_restriction_mode IN ('whitelist', 'blacklist') THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of endpoints with geographic restrictions (rights enforcement indicator)"
$$;