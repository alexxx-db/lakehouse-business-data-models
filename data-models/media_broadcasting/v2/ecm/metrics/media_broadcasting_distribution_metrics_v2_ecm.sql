-- Metric views for domain: distribution | Business: Media_Broadcasting | Version: 2 | Generated on: 2026-06-30 04:55:25

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`distribution_playback_session`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Streaming QoE and engagement KPIs derived from individual playback sessions — the core fact table for OTT viewing quality and consumption."
  source: "`vibe_media_broadcasting_v1`.`distribution`.`playback_session`"
  dimensions:
    - name: "platform_type"
      expr: platform_type
      comment: "Streaming platform type (e.g. iOS, Android, Web, CTV) for cross-platform QoE comparison."
    - name: "playback_mode"
      expr: playback_mode
      comment: "Playback mode (live, VOD, catch-up) to segment engagement and quality by consumption pattern."
    - name: "streaming_protocol"
      expr: streaming_protocol
      comment: "Delivery protocol (HLS/DASH) for protocol-level performance analysis."
    - name: "video_resolution"
      expr: video_resolution
      comment: "Delivered video resolution tier for quality-of-experience segmentation."
    - name: "geographic_city"
      expr: geographic_city
      comment: "Viewer city for geographic QoE and demand hotspots."
    - name: "session_start_month"
      expr: DATE_TRUNC('MONTH', session_start_timestamp)
      comment: "Month bucket of session start for trended engagement and QoE analysis."
  measures:
    - name: "Session Count"
      expr: COUNT(1)
      comment: "Total number of playback sessions — baseline streaming demand volume."
    - name: "Avg Completion Percentage"
      expr: AVG(CAST(completion_percentage AS DOUBLE))
      comment: "Average content completion rate — primary content engagement/quality signal that triggers programming and UX action."
    - name: "Unique Subscribers Streaming"
      expr: COUNT(DISTINCT subscriber_id)
      comment: "Distinct subscribers who streamed — active streaming reach used for engagement steering."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`distribution_qos_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality-of-Service event KPIs (rebuffering, latency, errors) used to steer streaming reliability and SLA investment."
  source: "`vibe_media_broadcasting_v1`.`distribution`.`qos_event`"
  dimensions:
    - name: "qos_event_type"
      expr: event_type
      comment: "QoS event type (stall, bitrate-switch, error) for reliability root-cause segmentation."
    - name: "event_severity"
      expr: event_severity
      comment: "Severity classification for prioritising remediation."
    - name: "geographic_region"
      expr: geographic_region
      comment: "Region experiencing the QoS event for geographic reliability triage."
    - name: "isp_name"
      expr: isp_name
      comment: "ISP delivering the stream for last-mile reliability analysis."
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', event_timestamp)
      comment: "Month bucket of QoS event for trended reliability KPIs."
  measures:
    - name: "QoS Event Count"
      expr: COUNT(1)
      comment: "Total QoS events — overall streaming reliability load indicator."
    - name: "Avg Buffer Level Seconds"
      expr: AVG(CAST(buffer_level_seconds AS DOUBLE))
      comment: "Average player buffer depth — proximate driver of stall risk and viewer abandonment."
    - name: "Sessions With QoS Events"
      expr: COUNT(DISTINCT playback_session_id)
      comment: "Distinct sessions impacted by QoS events — exposure scope for reliability remediation decisions."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`distribution_dai_session`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dynamic ad insertion delivery KPIs measuring ad fill, monetization yield and stitching performance for CTV/programmatic revenue."
  source: "`vibe_media_broadcasting_v1`.`distribution`.`dai_session`"
  dimensions:
    - name: "dai_session_status"
      expr: session_status
      comment: "DAI session outcome status for ad-delivery success analysis."
    - name: "platform_type"
      expr: platform_type
      comment: "Platform where ads were stitched for monetization comparison."
    - name: "ad_pod_position"
      expr: ad_pod_position
      comment: "Ad pod placement (pre/mid/post-roll) for yield-by-position analysis."
    - name: "geographic_dma_code"
      expr: geographic_dma_code
      comment: "DMA market code for addressable-ad and blackout monetization steering."
    - name: "session_start_month"
      expr: DATE_TRUNC('MONTH', session_start_timestamp)
      comment: "Month bucket of DAI session for trended ad-delivery KPIs."
  measures:
    - name: "DAI Session Count"
      expr: COUNT(1)
      comment: "Total DAI sessions — base for ad-supported streaming scale."
    - name: "Avg Fill Rate Percentage"
      expr: AVG(CAST(fill_rate_percentage AS DOUBLE))
      comment: "Average ad fill rate — primary monetization-efficiency KPI driving inventory and demand-partner decisions."
    - name: "Total Ad Duration Seconds"
      expr: SUM(CAST(total_ad_duration_seconds AS DOUBLE))
      comment: "Total stitched ad seconds delivered — ad-load volume tied directly to ad revenue."
    - name: "Avg Ad Pod Duration Seconds"
      expr: AVG(CAST(ad_pod_duration_seconds AS DOUBLE))
      comment: "Average ad pod duration — pacing/UX balance metric for ad-load optimisation."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`distribution_delivery_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Content delivery/CDN event KPIs measuring throughput, error rates and ad fill at the delivery edge."
  source: "`vibe_media_broadcasting_v1`.`distribution`.`delivery_event`"
  dimensions:
    - name: "delivery_status"
      expr: delivery_status
      comment: "Delivery outcome status for success-rate analysis."
    - name: "delivery_channel_type"
      expr: delivery_channel_type
      comment: "Delivery channel (OTT/linear/CDN) for channel-level performance steering."
    - name: "cdn_pop_location"
      expr: cdn_pop_location
      comment: "CDN point-of-presence for edge-performance and cost optimisation."
    - name: "geographic_country_code"
      expr: geographic_country_code
      comment: "Country of delivery for geographic reliability analysis."
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', event_timestamp)
      comment: "Month bucket of delivery event for trended delivery KPIs."
  measures:
    - name: "Delivery Event Count"
      expr: COUNT(1)
      comment: "Total delivery events — overall delivery volume baseline."
    - name: "Total Bytes Delivered"
      expr: SUM(CAST(bytes_delivered AS DOUBLE))
      comment: "Total bytes delivered — directly drives CDN egress cost and capacity decisions."
    - name: "Avg Ad Fill Rate Percent"
      expr: AVG(CAST(ad_fill_rate_percent AS DOUBLE))
      comment: "Average ad fill rate at delivery — monetization efficiency of inserted ads."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`distribution_sla_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SLA performance measurement KPIs tracking attainment, breach rate and penalty exposure across distribution partners and platforms."
  source: "`vibe_media_broadcasting_v1`.`distribution`.`sla_performance`"
  dimensions:
    - name: "affected_platform"
      expr: affected_platform
      comment: "Platform measured against SLA for partner-level performance review."
    - name: "affected_region"
      expr: affected_region
      comment: "Region measured for geographic SLA attainment."
    - name: "partner_name"
      expr: partner_name
      comment: "Distribution partner under SLA for accountability and renegotiation decisions."
    - name: "measurement_month"
      expr: DATE_TRUNC('MONTH', measurement_period_start)
      comment: "Month bucket of measurement window for trended SLA attainment."
  measures:
    - name: "SLA Measurement Count"
      expr: COUNT(1)
      comment: "Total SLA measurements — base population for breach-rate ratios."
    - name: "SLA Breach Count"
      expr: SUM(CASE WHEN breach_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of SLA breaches — operational reliability failures that trigger remediation and penalties."
    - name: "Total Penalty Amount"
      expr: SUM(CAST(penalty_amount AS DECIMAL(18,2)))
      comment: "Total SLA penalty exposure — direct financial impact steering vendor and infra investment."
    - name: "Avg Variance Percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average variance from target — early-warning signal on SLA drift."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`distribution_sla_breach`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SLA breach incident KPIs quantifying severity, duration and penalty/makegood exposure for reliability accountability."
  source: "`vibe_media_broadcasting_v1`.`distribution`.`sla_breach`"
  dimensions:
    - name: "breach_severity"
      expr: breach_severity
      comment: "Breach severity tier for prioritisation."
    - name: "breach_status"
      expr: breach_status
      comment: "Breach lifecycle status for open/resolved tracking."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root-cause classification for systemic remediation decisions."
    - name: "affected_platform"
      expr: affected_platform
      comment: "Platform affected by the breach for partner accountability."
    - name: "breach_month"
      expr: DATE_TRUNC('MONTH', breach_timestamp)
      comment: "Month bucket of breach for trended reliability KPIs."
  measures:
    - name: "Breach Count"
      expr: COUNT(1)
      comment: "Total SLA breach incidents — reliability failure volume."
    - name: "Total Breach Penalty Amount"
      expr: SUM(CAST(penalty_amount AS DECIMAL(18,2)))
      comment: "Total penalty cost from breaches — financial consequence steering infra spend."
    - name: "Avg Breach Duration Minutes"
      expr: AVG(CAST(breach_duration_minutes AS DOUBLE))
      comment: "Average breach duration — mean-time-to-recover proxy for ops improvement."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`distribution_carriage_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Carriage agreement portfolio KPIs measuring carriage-fee economics and renewal/retransmission posture across MVPD/distribution partners."
  source: "`vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Agreement lifecycle status for active-vs-expired portfolio view."
    - name: "agreement_type"
      expr: agreement_type
      comment: "Carriage agreement type for structure-level analysis."
    - name: "carriage_fee_structure"
      expr: carriage_fee_structure
      comment: "Fee structure (flat/per-sub) for monetization model comparison."
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Effective year for cohort/renewal trend analysis."
  measures:
    - name: "Agreement Count"
      expr: COUNT(1)
      comment: "Total carriage agreements — distribution footprint baseline."
    - name: "Total Carriage Fee Amount"
      expr: SUM(CAST(carriage_fee_amount AS DECIMAL(18,2)))
      comment: "Total contracted carriage fees — core distribution revenue driver."
    - name: "Auto-Renewal Agreement Count"
      expr: SUM(CASE WHEN auto_renewal_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Agreements set to auto-renew — revenue-continuity risk/retention indicator."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`distribution_carriage_fee_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Carriage-fee invoicing KPIs measuring billed amounts, dispute exposure and collection status for distribution revenue assurance."
  source: "`vibe_media_broadcasting_v1`.`distribution`.`distribution_carriage_fee_invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Invoice lifecycle status for AR aging analysis."
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status for collection-risk steering."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status for revenue-assurance tracking."
    - name: "invoice_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month bucket of invoice for trended billing KPIs."
  measures:
    - name: "Invoice Count"
      expr: COUNT(1)
      comment: "Total carriage fee invoices — billing volume baseline."
    - name: "Total Billed Amount"
      expr: SUM(CAST(total_amount AS DECIMAL(18,2)))
      comment: "Total invoiced carriage fees — distribution revenue recognised."
    - name: "Disputed Invoice Count"
      expr: SUM(CASE WHEN dispute_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Invoices in dispute — revenue-at-risk indicator triggering finance intervention."
    - name: "Total Tax Amount"
      expr: SUM(CAST(tax_amount AS DECIMAL(18,2)))
      comment: "Total tax billed — compliance and net-revenue reconciliation input."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`distribution_subscriber_count_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reported subscriber-count KPIs underpinning per-subscriber carriage fee billing and audit/variance assurance."
  source: "`vibe_media_broadcasting_v1`.`distribution`.`subscriber_count_report`"
  dimensions:
    - name: "report_status"
      expr: report_status
      comment: "Report lifecycle status for completeness tracking."
    - name: "reporting_period_type"
      expr: reporting_period_type
      comment: "Reporting cadence type for period normalisation."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval state for revenue-recognition gating."
    - name: "period_end_month"
      expr: DATE_TRUNC('MONTH', reporting_period_end_date)
      comment: "Month bucket of reporting period end for trended subscriber-base analysis."
  measures:
    - name: "Report Count"
      expr: COUNT(1)
      comment: "Total subscriber-count reports — reporting volume baseline."
    - name: "Total Reported Subscribers"
      expr: SUM(CAST(reported_subscriber_count AS DOUBLE))
      comment: "Total reported subscribers — basis for per-subscriber carriage fee revenue."
    - name: "Total Verified Subscribers"
      expr: SUM(CAST(verified_subscriber_count AS DOUBLE))
      comment: "Total audit-verified subscribers — revenue-assurance baseline against reported counts."
    - name: "Disputed Report Count"
      expr: SUM(CASE WHEN dispute_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Reports in dispute — billing-accuracy risk triggering audit action."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`distribution_recommendation_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Recommendation/personalisation KPIs measuring click-through, play conversion and engagement to steer recsys investment."
  source: "`vibe_media_broadcasting_v1`.`distribution`.`recommendation_event`"
  dimensions:
    - name: "recommendation_algorithm"
      expr: recommendation_algorithm
      comment: "Algorithm/model serving the recommendation for A/B and model comparison."
    - name: "slate_name"
      expr: slate_name
      comment: "Recommendation slate/rail name for surface-level performance analysis."
    - name: "platform"
      expr: platform
      comment: "Platform serving the recommendation for cross-platform recsys comparison."
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', event_timestamp)
      comment: "Month bucket of recommendation event for trended conversion KPIs."
  measures:
    - name: "Recommendation Event Count"
      expr: COUNT(1)
      comment: "Total recommendation events — recsys serving volume baseline."
    - name: "Click Count"
      expr: SUM(CASE WHEN click_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Recommendations clicked — numerator for click-through rate steering personalisation ROI."
    - name: "Play Count"
      expr: SUM(CASE WHEN play_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Recommendations that led to playback — conversion outcome of personalisation."
    - name: "Avg Recommendation Score"
      expr: AVG(CAST(recommendation_score AS DOUBLE))
      comment: "Average model confidence score — model-quality monitoring signal."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`distribution_clip_distribution_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Social/UGC clip distribution KPIs measuring reach, engagement and monetization across YouTube/TikTok/IG outlets."
  source: "`vibe_media_broadcasting_v1`.`distribution`.`clip_distribution_event`"
  dimensions:
    - name: "distribution_status"
      expr: distribution_status
      comment: "Clip distribution status (published/removed) for outlet health tracking."
    - name: "publish_month"
      expr: DATE_TRUNC('MONTH', publish_timestamp)
      comment: "Month bucket of clip publish for trended social performance."
  measures:
    - name: "Clip Event Count"
      expr: COUNT(1)
      comment: "Total clip distribution events — social publishing volume."
    - name: "Total View Count"
      expr: SUM(CAST(view_count AS DOUBLE))
      comment: "Total social views — reach KPI for social distribution strategy."
    - name: "Total Social Revenue"
      expr: SUM(CAST(revenue_amount AS DECIMAL(18,2)))
      comment: "Total monetization from social clips — incremental revenue channel steering."
    - name: "Total Share Count"
      expr: SUM(CAST(share_count AS DOUBLE))
      comment: "Total shares — virality/engagement signal informing content and outlet decisions."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`distribution_deal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Distribution/programmatic deal portfolio KPIs measuring guaranteed value, floor pricing and revenue-share economics."
  source: "`vibe_media_broadcasting_v1`.`distribution`.`deal`"
  dimensions:
    - name: "deal_status"
      expr: deal_status
      comment: "Deal lifecycle status for pipeline and active-revenue view."
    - name: "deal_type"
      expr: deal_type
      comment: "Deal type (PMP/direct/programmatic) for monetization-channel comparison."
    - name: "platform_type"
      expr: platform_type
      comment: "Platform/exchange context for programmatic-channel steering."
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Effective year for deal cohort/trend analysis."
  measures:
    - name: "Deal Count"
      expr: COUNT(1)
      comment: "Total distribution deals — monetization pipeline baseline."
    - name: "Total Minimum Guarantee"
      expr: SUM(CAST(minimum_guarantee_amount AS DECIMAL(18,2)))
      comment: "Total guaranteed deal value — committed revenue floor for forecasting."
    - name: "Avg Floor Price CPM"
      expr: AVG(CAST(floor_price_cpm AS DOUBLE))
      comment: "Average programmatic floor CPM — pricing-power KPI for yield management."
    - name: "Avg Revenue Share Percentage"
      expr: AVG(CAST(revenue_share_percentage AS DOUBLE))
      comment: "Average revenue-share rate — net-economics indicator for deal negotiation."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`distribution_local_avail_inventory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Local ad avail inventory KPIs measuring sell-through, rate realisation and impression supply for affiliate/station ad sales."
  source: "`vibe_media_broadcasting_v1`.`distribution`.`distribution_local_avail_inventory`"
  dimensions:
    - name: "avail_type"
      expr: avail_type
      comment: "Avail type for inventory-class analysis."
    - name: "avail_date_month"
      expr: DATE_TRUNC('MONTH', avail_date)
      comment: "Month bucket of avail date for trended sell-through."
  measures:
    - name: "Avail Count"
      expr: COUNT(1)
      comment: "Total local avails — inventory supply baseline."
    - name: "Sold Avail Count"
      expr: SUM(CASE WHEN sold_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Sold avails — numerator for sell-through rate steering ad-sales performance."
    - name: "Total Estimated Impressions"
      expr: SUM(CAST(estimated_impressions AS DOUBLE))
      comment: "Total estimated impressions — supply scale for ad-sales planning."
    - name: "Avg Sold Rate"
      expr: AVG(CAST(sold_rate AS DECIMAL(18,2)))
      comment: "Average realised sold rate — price realisation vs rate card for yield decisions."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`distribution_abr_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Technical characteristics of Adaptive Bitrate profiles"
  source: "`vibe_media_broadcasting_v1`.`distribution`.`abr_profile`"
  dimensions:
    - name: "streaming_protocol"
      expr: streaming_protocol
      comment: "Streaming protocol used by the profile"
    - name: "video_codec"
      expr: video_codec
      comment: "Video codec used in the profile"
    - name: "audio_codec"
      expr: audio_codec
      comment: "Audio codec used in the profile"
    - name: "hdr_format"
      expr: hdr_format
      comment: "HDR format supported by the profile"
    - name: "profile_status"
      expr: profile_status
      comment: "Operational status of the profile"
    - name: "created_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Date the profile was created"
  measures:
    - name: "count_profiles"
      expr: COUNT(1)
      comment: "Number of ABR profiles defined"
    - name: "avg_frame_rate"
      expr: AVG(CAST(frame_rate AS DOUBLE))
      comment: "Average frame rate across ABR profiles"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`distribution_cdn_configuration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost and capacity KPIs for CDN configurations"
  source: "`vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration`"
  dimensions:
    - name: "cdn_provider"
      expr: cdn_provider
      comment: "CDN service provider"
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the configuration"
    - name: "geo_blocking_enabled"
      expr: geo_blocking_enabled
      comment: "Whether geo‑blocking is enabled"
    - name: "created_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Date the CDN configuration was created"
  measures:
    - name: "count_configurations"
      expr: COUNT(1)
      comment: "Total CDN configurations"
    - name: "total_bandwidth_limit_gbps"
      expr: SUM(CAST(bandwidth_limit_gbps AS DOUBLE))
      comment: "Sum of bandwidth limits across configurations (Gbps)"
    - name: "avg_cost_per_gb"
      expr: AVG(CAST(cost_per_gb AS DOUBLE))
      comment: "Average cost per GB across CDN configurations"
    - name: "geo_blocking_enabled_count"
      expr: SUM(CASE WHEN geo_blocking_enabled THEN 1 ELSE 0 END)
      comment: "Number of configurations with geo‑blocking enabled"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`distribution_content_delivery_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core order volume and size KPIs for content delivery"
  source: "`vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order`"
  dimensions:
    - name: "order_date_day"
      expr: DATE_TRUNC('day', order_date)
      comment: "Order date (day bucket)"
    - name: "order_status"
      expr: order_status
      comment: "Current status of the order"
    - name: "delivery_method"
      expr: delivery_method
      comment: "Method used to deliver the content"
  measures:
    - name: "total_orders"
      expr: COUNT(1)
      comment: "Total number of content delivery orders"
    - name: "total_file_size_gb"
      expr: SUM(CAST(file_size_gb AS DOUBLE))
      comment: "Sum of file sizes for all orders (GB)"
    - name: "avg_file_size_gb"
      expr: AVG(CAST(file_size_gb AS DOUBLE))
      comment: "Average file size per order (GB)"
    - name: "avg_approval_lead_time_seconds"
      expr: AVG(unix_timestamp(approved_timestamp) - unix_timestamp(order_date))
      comment: "Average time from order creation to approval (seconds)"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`distribution_device_type`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capability and market reach metrics for device types"
  source: "`vibe_media_broadcasting_v1`.`distribution`.`device_type`"
  dimensions:
    - name: "device_category"
      expr: device_category
      comment: "Category of the device (e.g., TV, Mobile)"
    - name: "manufacturer"
      expr: manufacturer
      comment: "Device manufacturer"
    - name: "os_family"
      expr: os_family
      comment: "Operating system family"
    - name: "hdr_capable"
      expr: hdr_capable
      comment: "HDR capability flag"
    - name: "dai_supported"
      expr: dai_supported
      comment: "Dynamic ad insertion support flag"
    - name: "created_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Date the device type record was created"
  measures:
    - name: "count_devices"
      expr: COUNT(1)
      comment: "Total distinct device types recorded"
    - name: "avg_max_bitrate_mbps"
      expr: AVG(CAST(max_bitrate_mbps AS DOUBLE))
      comment: "Average maximum bitrate supported (Mbps)"
    - name: "avg_active_install_base"
      expr: AVG(CAST(active_install_base AS DOUBLE))
      comment: "Average active install base across device types"
    - name: "hdr_capable_count"
      expr: SUM(CASE WHEN hdr_capable THEN 1 ELSE 0 END)
      comment: "Number of device types that are HDR capable"
$$;