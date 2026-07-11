-- Metric views for domain: distribution | Business: Media_Broadcasting | Version: 3 | Generated on: 2026-07-10 21:10:12

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
      comment: "Type of carriage agreement (must-carry, retransmission consent, negotiated)"
    - name: "carriage_fee_structure"
      expr: carriage_fee_structure
      comment: "Fee structure model (flat, per-subscriber, tiered)"
    - name: "channel_positioning_tier"
      expr: channel_positioning_tier
      comment: "Channel tier placement (basic, premium, sports, etc.)"
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Whether agreement auto-renews at expiration"
    - name: "must_carry_election"
      expr: must_carry_election
      comment: "Whether broadcaster elected must-carry status"
    - name: "retransmission_consent_granted"
      expr: retransmission_consent_granted
      comment: "Whether retransmission consent was granted"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the agreement became effective"
    - name: "expiration_year"
      expr: YEAR(expiration_date)
      comment: "Year the agreement expires"
    - name: "geographic_coverage"
      expr: geographic_coverage
      comment: "Geographic scope of the carriage agreement"
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
    - name: "distinct_distribution_partners"
      expr: COUNT(DISTINCT distribution_partner_id)
      comment: "Number of unique distribution partners with carriage agreements"
    - name: "distinct_channels_carried"
      expr: COUNT(DISTINCT channel_id)
      comment: "Number of unique channels covered by carriage agreements"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`distribution_channel_lineup`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Channel lineup economics and subscriber reach metrics for distribution optimization"
  source: "`vibe_media_broadcasting_v1`.`distribution`.`channel_lineup`"
  dimensions:
    - name: "lineup_status"
      expr: lineup_status
      comment: "Current status of the channel lineup (active, pending, retired)"
    - name: "service_tier"
      expr: service_tier
      comment: "Service tier classification (basic, standard, premium)"
    - name: "tier_type"
      expr: tier_type
      comment: "Type of tier offering"
    - name: "carriage_type"
      expr: carriage_type
      comment: "Type of carriage arrangement"
    - name: "hd_available"
      expr: hd_available
      comment: "Whether HD feed is available in this lineup"
    - name: "uhd_4k_available"
      expr: uhd_4k_available
      comment: "Whether UHD/4K feed is available in this lineup"
    - name: "dvr_enabled"
      expr: dvr_enabled
      comment: "Whether DVR functionality is enabled"
    - name: "vod_enabled"
      expr: vod_enabled
      comment: "Whether video-on-demand is enabled"
    - name: "closed_caption_required"
      expr: closed_caption_required
      comment: "Whether closed captioning is required for this lineup"
    - name: "promotional_flag"
      expr: promotional_flag
      comment: "Whether lineup is part of a promotional offer"
    - name: "effective_year"
      expr: YEAR(effective_start_date)
      comment: "Year the lineup became effective"
  measures:
    - name: "total_channel_lineup_entries"
      expr: COUNT(1)
      comment: "Total number of channel lineup entries"
    - name: "total_carriage_fee_revenue"
      expr: SUM(CAST(carriage_fee_per_subscriber AS DOUBLE))
      comment: "Total carriage fee revenue per subscriber across all lineups"
    - name: "avg_carriage_fee_per_subscriber"
      expr: AVG(CAST(carriage_fee_per_subscriber AS DOUBLE))
      comment: "Average carriage fee per subscriber across lineups"
    - name: "distinct_channels_in_lineups"
      expr: COUNT(DISTINCT channel_id)
      comment: "Number of unique channels across all lineups"
    - name: "distinct_distribution_partners"
      expr: COUNT(DISTINCT distribution_partner_id)
      comment: "Number of unique distribution partners offering lineups"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`distribution_deal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Distribution deal economics and revenue model performance metrics for partnership strategy"
  source: "`vibe_media_broadcasting_v1`.`distribution`.`deal`"
  dimensions:
    - name: "deal_status"
      expr: deal_status
      comment: "Current status of the distribution deal (active, pending, expired, terminated)"
    - name: "deal_type"
      expr: deal_type
      comment: "Type of distribution deal (licensing, syndication, carriage)"
    - name: "revenue_model"
      expr: revenue_model
      comment: "Revenue model for the deal (flat fee, revenue share, hybrid)"
    - name: "platform_type"
      expr: platform_type
      comment: "Platform type for distribution (linear, OTT, FAST, MVPD)"
    - name: "exclusivity_flag"
      expr: exclusivity_flag
      comment: "Whether the deal grants exclusive distribution rights"
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Whether the deal auto-renews at expiration"
    - name: "territory"
      expr: territory
      comment: "Geographic territory covered by the deal"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for deal financial terms"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the deal became effective"
    - name: "expiration_year"
      expr: YEAR(expiration_date)
      comment: "Year the deal expires"
  measures:
    - name: "total_distribution_deals"
      expr: COUNT(1)
      comment: "Total number of distribution deals"
    - name: "total_flat_fee_revenue"
      expr: SUM(CAST(flat_fee_amount AS DOUBLE))
      comment: "Total flat fee revenue across all deals"
    - name: "total_minimum_guarantee_value"
      expr: SUM(CAST(minimum_guarantee_amount AS DOUBLE))
      comment: "Total minimum guarantee commitments across all deals"
    - name: "avg_revenue_share_percentage"
      expr: AVG(CAST(revenue_share_percentage AS DOUBLE))
      comment: "Average revenue share percentage across deals"
    - name: "avg_flat_fee_per_deal"
      expr: AVG(CAST(flat_fee_amount AS DOUBLE))
      comment: "Average flat fee amount per deal"
    - name: "total_minimum_subscriber_guarantees"
      expr: SUM(CAST(minimum_subscriber_guarantee AS DOUBLE))
      comment: "Total minimum subscriber guarantees across all deals"
    - name: "distinct_distribution_partners"
      expr: COUNT(DISTINCT distribution_partner_id)
      comment: "Number of unique distribution partners with active deals"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`distribution_delivery_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Content delivery performance and quality metrics for operational monitoring and SLA compliance"
  source: "`vibe_media_broadcasting_v1`.`distribution`.`delivery_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of delivery event (start, stop, error, buffer, quality change)"
    - name: "delivery_status"
      expr: delivery_status
      comment: "Status of the content delivery (success, failed, in-progress)"
    - name: "delivery_technology"
      expr: delivery_technology
      comment: "Technology used for content delivery (CDN, origin, edge)"
    - name: "streaming_protocol"
      expr: streaming_protocol
      comment: "Streaming protocol used (HLS, DASH, RTMP, etc.)"
    - name: "cdn_cache_status"
      expr: cdn_cache_status
      comment: "CDN cache hit/miss status"
    - name: "cdn_pop_location"
      expr: cdn_pop_location
      comment: "CDN point-of-presence location serving the content"
    - name: "resolution"
      expr: resolution
      comment: "Video resolution delivered (480p, 720p, 1080p, 4K)"
    - name: "video_codec"
      expr: video_codec
      comment: "Video codec used for delivery"
    - name: "audio_codec"
      expr: audio_codec
      comment: "Audio codec used for delivery"
    - name: "drm_system"
      expr: drm_system
      comment: "DRM system applied (Widevine, FairPlay, PlayReady)"
    - name: "dai_enabled"
      expr: dai_enabled
      comment: "Whether dynamic ad insertion was enabled"
    - name: "geographic_country_code"
      expr: geographic_country_code
      comment: "Country code of the viewer"
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region of the viewer"
    - name: "event_date"
      expr: DATE(event_timestamp)
      comment: "Date of the delivery event"
    - name: "event_hour"
      expr: HOUR(event_timestamp)
      comment: "Hour of the delivery event"
  measures:
    - name: "total_delivery_events"
      expr: COUNT(1)
      comment: "Total number of content delivery events"
    - name: "total_bytes_delivered"
      expr: SUM(CAST(bytes_delivered AS DOUBLE))
      comment: "Total bytes delivered across all events"
    - name: "avg_bytes_per_delivery"
      expr: AVG(CAST(bytes_delivered AS DOUBLE))
      comment: "Average bytes delivered per event"
    - name: "avg_ad_fill_rate"
      expr: AVG(CAST(ad_fill_rate_percent AS DOUBLE))
      comment: "Average ad fill rate percentage across delivery events"
    - name: "distinct_delivery_channels"
      expr: COUNT(DISTINCT delivery_channel_id)
      comment: "Number of unique delivery channels used"
    - name: "distinct_streaming_endpoints"
      expr: COUNT(DISTINCT streaming_endpoint_id)
      comment: "Number of unique streaming endpoints serving content"
    - name: "distinct_cdn_nodes"
      expr: COUNT(DISTINCT cdn_node_code)
      comment: "Number of unique CDN nodes serving content"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`distribution_partner`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Distribution partner relationship and capacity metrics for partnership management and strategic planning"
  source: "`vibe_media_broadcasting_v1`.`distribution`.`distribution_partner`"
  dimensions:
    - name: "partner_type"
      expr: partner_type
      comment: "Type of distribution partner (MVPD, OTT, FAST, cable, satellite, telco)"
    - name: "partner_tier"
      expr: partner_tier
      comment: "Strategic tier classification of the partner (tier 1, tier 2, tier 3)"
    - name: "relationship_status"
      expr: relationship_status
      comment: "Current status of the partnership relationship (active, inactive, pending, terminated)"
    - name: "carriage_fee_model"
      expr: carriage_fee_model
      comment: "Fee model used for carriage (flat, per-subscriber, tiered)"
    - name: "must_carry_obligation_flag"
      expr: must_carry_obligation_flag
      comment: "Whether partner has must-carry obligations"
    - name: "retransmission_consent_status"
      expr: retransmission_consent_status
      comment: "Status of retransmission consent with partner"
    - name: "dai_support_flag"
      expr: dai_support_flag
      comment: "Whether partner supports dynamic ad insertion"
    - name: "blackout_capability_flag"
      expr: blackout_capability_flag
      comment: "Whether partner can enforce blackout rules"
    - name: "qos_monitoring_enabled_flag"
      expr: qos_monitoring_enabled_flag
      comment: "Whether quality-of-service monitoring is enabled"
    - name: "headquarters_country_code"
      expr: headquarters_country_code
      comment: "Country code of partner headquarters"
    - name: "geographic_footprint"
      expr: geographic_footprint
      comment: "Geographic coverage area of the partner"
    - name: "cdn_provider"
      expr: cdn_provider
      comment: "CDN provider used by the partner"
  measures:
    - name: "total_distribution_partners"
      expr: COUNT(1)
      comment: "Total number of distribution partners"
    - name: "total_subscriber_reach"
      expr: SUM(CAST(subscriber_reach_estimate AS DOUBLE))
      comment: "Total estimated subscriber reach across all partners"
    - name: "avg_subscriber_reach_per_partner"
      expr: AVG(CAST(subscriber_reach_estimate AS DOUBLE))
      comment: "Average subscriber reach per distribution partner"
    - name: "avg_sla_uptime_target"
      expr: AVG(CAST(sla_uptime_target_percent AS DOUBLE))
      comment: "Average SLA uptime target percentage across partners"
    - name: "distinct_territories_covered"
      expr: COUNT(DISTINCT territory_id)
      comment: "Number of unique territories covered by distribution partners"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`distribution_ott_platform`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "OTT platform subscriber economics and ARPU metrics for direct-to-consumer strategy"
  source: "`vibe_media_broadcasting_v1`.`distribution`.`ott_platform`"
  dimensions:
    - name: "platform_status"
      expr: platform_status
      comment: "Current operational status of the OTT platform (active, beta, sunset, retired)"
    - name: "service_tier"
      expr: service_tier
      comment: "Service tier offering (free, basic, premium, enterprise)"
    - name: "dai_enabled"
      expr: dai_enabled
      comment: "Whether dynamic ad insertion is enabled"
    - name: "fast_channel_enabled"
      expr: fast_channel_enabled
      comment: "Whether FAST (Free Ad-Supported TV) channels are enabled"
    - name: "hdr_supported"
      expr: hdr_supported
      comment: "Whether HDR video is supported"
    - name: "mvpd_carriage_eligible"
      expr: mvpd_carriage_eligible
      comment: "Whether platform is eligible for MVPD carriage"
    - name: "gdpr_applicable"
      expr: gdpr_applicable
      comment: "Whether GDPR regulations apply to this platform"
    - name: "coppa_compliant"
      expr: coppa_compliant
      comment: "Whether platform is COPPA compliant for children's content"
    - name: "drm_system"
      expr: drm_system
      comment: "DRM system used by the platform"
    - name: "cdn_provider"
      expr: cdn_provider
      comment: "CDN provider for content delivery"
    - name: "launch_year"
      expr: YEAR(launch_date)
      comment: "Year the platform launched"
  measures:
    - name: "total_ott_platforms"
      expr: COUNT(1)
      comment: "Total number of OTT platforms"
    - name: "total_subscribers"
      expr: SUM(CAST(subscriber_count AS DOUBLE))
      comment: "Total subscriber count across all OTT platforms"
    - name: "avg_subscribers_per_platform"
      expr: AVG(CAST(subscriber_count AS DOUBLE))
      comment: "Average subscriber count per OTT platform"
    - name: "total_subscription_revenue_potential"
      expr: SUM(CAST(base_subscription_price AS DOUBLE))
      comment: "Total subscription price across all platforms (revenue potential indicator)"
    - name: "avg_subscription_price"
      expr: AVG(CAST(base_subscription_price AS DOUBLE))
      comment: "Average base subscription price across platforms"
    - name: "avg_arpu"
      expr: AVG(CAST(arpu AS DOUBLE))
      comment: "Average revenue per user across OTT platforms"
    - name: "avg_sla_uptime_target"
      expr: AVG(CAST(sla_uptime_target_pct AS DOUBLE))
      comment: "Average SLA uptime target percentage across platforms"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`distribution_playback_session`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Viewer engagement and streaming quality metrics for content performance and QoE optimization"
  source: "`vibe_media_broadcasting_v1`.`distribution`.`playback_session`"
  dimensions:
    - name: "platform_type"
      expr: platform_type
      comment: "Platform type for playback (web, mobile, smart TV, set-top box)"
    - name: "playback_mode"
      expr: playback_mode
      comment: "Playback mode (live, VOD, DVR, time-shifted)"
    - name: "exit_reason"
      expr: exit_reason
      comment: "Reason for session exit (completed, user stopped, error, timeout)"
    - name: "streaming_protocol"
      expr: streaming_protocol
      comment: "Streaming protocol used (HLS, DASH, RTMP)"
    - name: "video_resolution"
      expr: video_resolution
      comment: "Video resolution during playback (480p, 720p, 1080p, 4K)"
    - name: "audio_language"
      expr: audio_language
      comment: "Audio language selected by viewer"
    - name: "closed_captions_enabled"
      expr: closed_captions_enabled
      comment: "Whether closed captions were enabled during playback"
    - name: "dai_enabled"
      expr: dai_enabled
      comment: "Whether dynamic ad insertion was enabled"
    - name: "cdn_pop_location"
      expr: cdn_pop_location
      comment: "CDN point-of-presence serving the session"
    - name: "geographic_city"
      expr: geographic_city
      comment: "City of the viewer"
    - name: "session_date"
      expr: DATE(session_start_timestamp)
      comment: "Date the playback session started"
    - name: "session_hour"
      expr: HOUR(session_start_timestamp)
      comment: "Hour the playback session started"
  measures:
    - name: "total_playback_sessions"
      expr: COUNT(1)
      comment: "Total number of playback sessions"
    - name: "total_watch_duration_hours"
      expr: SUM(CAST(total_watch_duration_seconds AS DOUBLE)) / 3600.0
      comment: "Total watch duration in hours across all sessions"
    - name: "avg_watch_duration_minutes"
      expr: AVG(CAST(total_watch_duration_seconds AS DOUBLE)) / 60.0
      comment: "Average watch duration per session in minutes"
    - name: "avg_completion_percentage"
      expr: AVG(CAST(completion_percentage AS DOUBLE))
      comment: "Average content completion percentage across sessions"
    - name: "avg_bitrate_kbps"
      expr: AVG(CAST(average_bitrate_kbps AS DOUBLE))
      comment: "Average streaming bitrate in kbps across sessions"
    - name: "total_ad_duration_hours"
      expr: SUM(CAST(total_ad_duration_seconds AS DOUBLE)) / 3600.0
      comment: "Total ad duration delivered in hours"
    - name: "avg_ad_duration_per_session_seconds"
      expr: AVG(CAST(total_ad_duration_seconds AS DOUBLE))
      comment: "Average ad duration per session in seconds"
    - name: "distinct_subscribers"
      expr: COUNT(DISTINCT subscriber_id)
      comment: "Number of unique subscribers with playback sessions"
    - name: "distinct_streaming_endpoints"
      expr: COUNT(DISTINCT streaming_endpoint_id)
      comment: "Number of unique streaming endpoints used"
    - name: "distinct_territories"
      expr: COUNT(DISTINCT territory_id)
      comment: "Number of unique territories with playback activity"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`distribution_release_window`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Release window economics and windowing strategy metrics for content monetization optimization"
  source: "`vibe_media_broadcasting_v1`.`distribution`.`release_window`"
  dimensions:
    - name: "window_type"
      expr: window_type
      comment: "Type of release window (theatrical, PVOD, TVOD, SVOD, AVOD, FAST, linear)"
    - name: "window_status"
      expr: window_status
      comment: "Current status of the release window (active, scheduled, expired, cancelled)"
    - name: "platform_type"
      expr: platform_type
      comment: "Platform type for the release window (theatrical, OTT, linear, FAST)"
    - name: "pricing_model"
      expr: pricing_model
      comment: "Pricing model for the window (rental, purchase, subscription, ad-supported, free)"
    - name: "exclusivity_flag"
      expr: exclusivity_flag
      comment: "Whether the window grants exclusive distribution rights"
    - name: "ad_insertion_enabled"
      expr: ad_insertion_enabled
      comment: "Whether ad insertion is enabled for this window"
    - name: "hdr_enabled"
      expr: hdr_enabled
      comment: "Whether HDR is enabled for this window"
    - name: "closed_caption_required"
      expr: closed_caption_required
      comment: "Whether closed captioning is required"
    - name: "audio_description_required"
      expr: audio_description_required
      comment: "Whether audio description is required for accessibility"
    - name: "territory_scope"
      expr: territory_scope
      comment: "Geographic scope of the release window"
    - name: "max_resolution"
      expr: max_resolution
      comment: "Maximum video resolution allowed in this window"
    - name: "streaming_protocol"
      expr: streaming_protocol
      comment: "Streaming protocol for delivery"
    - name: "window_open_year"
      expr: YEAR(window_open_date)
      comment: "Year the release window opens"
  measures:
    - name: "total_release_windows"
      expr: COUNT(1)
      comment: "Total number of release windows"
    - name: "total_carriage_fee_revenue"
      expr: SUM(CAST(carriage_fee_amount AS DOUBLE))
      comment: "Total carriage fee revenue across all release windows"
    - name: "total_minimum_guarantee_value"
      expr: SUM(CAST(minimum_guarantee_amount AS DOUBLE))
      comment: "Total minimum guarantee commitments across windows"
    - name: "total_purchase_price_revenue"
      expr: SUM(CAST(purchase_price AS DOUBLE))
      comment: "Total purchase price revenue potential across windows"
    - name: "total_rental_price_revenue"
      expr: SUM(CAST(rental_price AS DOUBLE))
      comment: "Total rental price revenue potential across windows"
    - name: "avg_revenue_share_percentage"
      expr: AVG(CAST(revenue_share_percent AS DOUBLE))
      comment: "Average revenue share percentage across windows"
    - name: "avg_ad_load_minutes"
      expr: AVG(CAST(ad_load_minutes AS DOUBLE))
      comment: "Average ad load in minutes per window"
    - name: "distinct_territories"
      expr: COUNT(DISTINCT territory_id)
      comment: "Number of unique territories with release windows"
    - name: "distinct_ott_platforms"
      expr: COUNT(DISTINCT ott_platform_id)
      comment: "Number of unique OTT platforms with release windows"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`distribution_streaming_endpoint`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Streaming endpoint capacity and cost efficiency metrics for infrastructure optimization"
  source: "`vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint`"
  dimensions:
    - name: "endpoint_type"
      expr: endpoint_type
      comment: "Type of streaming endpoint (origin, edge, CDN, live, VOD)"
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status (active, standby, maintenance, decommissioned)"
    - name: "streaming_protocol"
      expr: streaming_protocol
      comment: "Streaming protocol supported (HLS, DASH, RTMP, WebRTC)"
    - name: "manifest_format"
      expr: manifest_format
      comment: "Manifest format used (M3U8, MPD, F4M)"
    - name: "dai_enabled"
      expr: dai_enabled
      comment: "Whether dynamic ad insertion is enabled"
    - name: "ipv6_enabled"
      expr: ipv6_enabled
      comment: "Whether IPv6 is enabled for the endpoint"
    - name: "geo_restriction_mode"
      expr: geo_restriction_mode
      comment: "Geographic restriction mode (whitelist, blacklist, none)"
    - name: "token_authentication_scheme"
      expr: token_authentication_scheme
      comment: "Token authentication scheme used for security"
    - name: "provisioned_year"
      expr: YEAR(provisioned_date)
      comment: "Year the endpoint was provisioned"
  measures:
    - name: "total_streaming_endpoints"
      expr: COUNT(1)
      comment: "Total number of streaming endpoints"
    - name: "total_bandwidth_capacity_gbps"
      expr: SUM(CAST(bandwidth_limit_gbps AS DOUBLE))
      comment: "Total bandwidth capacity in Gbps across all endpoints"
    - name: "avg_bandwidth_per_endpoint_gbps"
      expr: AVG(CAST(bandwidth_limit_gbps AS DOUBLE))
      comment: "Average bandwidth capacity per endpoint in Gbps"
    - name: "avg_cost_per_gb"
      expr: AVG(CAST(cost_per_gb AS DOUBLE))
      comment: "Average cost per GB across streaming endpoints"
    - name: "avg_max_bitrate_mbps"
      expr: AVG(CAST(max_bitrate_mbps AS DOUBLE))
      comment: "Average maximum bitrate in Mbps across endpoints"
    - name: "avg_sla_uptime_target"
      expr: AVG(CAST(sla_uptime_target_percent AS DOUBLE))
      comment: "Average SLA uptime target percentage across endpoints"
    - name: "distinct_channels_served"
      expr: COUNT(DISTINCT channel_id)
      comment: "Number of unique channels served by streaming endpoints"
    - name: "distinct_ott_platforms_served"
      expr: COUNT(DISTINCT ott_platform_id)
      comment: "Number of unique OTT platforms served by endpoints"
    - name: "distinct_territories_served"
      expr: COUNT(DISTINCT territory_id)
      comment: "Number of unique territories served by endpoints"
$$;