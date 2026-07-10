-- Metric views for domain: distribution | Business: Media_Broadcasting | Version: 3 | Generated on: 2026-07-10 19:06:42

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`distribution_playback_session`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Streaming playback quality and engagement KPIs. Tracks viewer experience, completion rates, rebuffering, and ad delivery performance across sessions — core metrics for OTT platform health and subscriber satisfaction."
  source: "`vibe_media_broadcasting_v1`.`distribution`.`playback_session`"
  dimensions:
    - name: "platform_type"
      expr: platform_type
      comment: "Streaming platform type (e.g., iOS, Android, CTV, Web) for cross-platform performance segmentation."
    - name: "playback_mode"
      expr: playback_mode
      comment: "Playback mode (live, VOD, DVR) to segment engagement patterns by content delivery type."
    - name: "streaming_protocol"
      expr: streaming_protocol
      comment: "Streaming protocol (HLS, DASH, etc.) used during the session for technical quality analysis."
    - name: "video_resolution"
      expr: video_resolution
      comment: "Video resolution delivered (e.g., 1080p, 4K) to assess quality tier distribution."
    - name: "exit_reason"
      expr: exit_reason
      comment: "Reason the playback session ended (e.g., user exit, error, completion) for churn and error analysis."
    - name: "dai_enabled"
      expr: dai_enabled
      comment: "Whether dynamic ad insertion was active during the session, for ad monetization segmentation."
    - name: "session_date"
      expr: DATE_TRUNC('day', session_start_timestamp)
      comment: "Date the playback session started, for daily trend analysis."
    - name: "session_month"
      expr: DATE_TRUNC('month', session_start_timestamp)
      comment: "Month the playback session started, for monthly trend and capacity planning."
    - name: "geographic_city"
      expr: geographic_city
      comment: "City of the viewer for geographic audience distribution analysis."
    - name: "audio_language"
      expr: audio_language
      comment: "Audio language selected during playback for localization and content strategy decisions."
  measures:
    - name: "total_sessions"
      expr: COUNT(1)
      comment: "Total number of playback sessions initiated. Baseline volume metric for platform usage and capacity planning."
    - name: "total_watch_duration_seconds"
      expr: SUM(CAST(total_watch_duration_seconds AS DOUBLE))
      comment: "Total watch time in seconds across all sessions. Core engagement metric tied directly to subscriber value and content licensing ROI."
    - name: "avg_watch_duration_seconds"
      expr: AVG(CAST(total_watch_duration_seconds AS DOUBLE))
      comment: "Average watch duration per session in seconds. Indicates content stickiness and viewer engagement depth."
    - name: "avg_completion_percentage"
      expr: AVG(CAST(completion_percentage AS DOUBLE))
      comment: "Average content completion rate across sessions. Key indicator of content quality and viewer satisfaction — low completion signals content or technical issues."
    - name: "avg_initial_buffering_duration_ms"
      expr: AVG(CAST(initial_buffering_duration_ms AS DOUBLE))
      comment: "Average time-to-first-frame in milliseconds. Critical QoE metric — high buffering directly causes viewer abandonment and subscriber churn."
    - name: "avg_total_rebuffering_duration_ms"
      expr: AVG(CAST(total_rebuffering_duration_ms AS DOUBLE))
      comment: "Average total rebuffering time per session in milliseconds. Directly correlates with viewer satisfaction scores and churn probability."
    - name: "avg_rebuffering_events_count"
      expr: AVG(CAST(rebuffering_events_count AS DOUBLE))
      comment: "Average number of rebuffering interruptions per session. Operational quality metric used to trigger CDN or encoder investigations."
    - name: "total_ad_duration_seconds"
      expr: SUM(CAST(total_ad_duration_seconds AS DOUBLE))
      comment: "Total ad time delivered across all sessions in seconds. Directly tied to ad revenue realization and inventory fill performance."
    - name: "avg_ad_breaks_served_count"
      expr: AVG(CAST(ad_breaks_served_count AS DOUBLE))
      comment: "Average number of ad breaks served per session. Informs ad load optimization to balance revenue and viewer experience."
    - name: "distinct_subscribers"
      expr: COUNT(DISTINCT subscriber_id)
      comment: "Count of unique subscribers with active playback sessions. Measures active user base size for subscriber engagement reporting."
    - name: "sessions_with_errors"
      expr: COUNT(CASE WHEN error_code IS NOT NULL AND error_code <> '' THEN 1 END)
      comment: "Number of sessions that encountered a playback error. Operational quality metric — high error counts trigger engineering escalation."
    - name: "closed_captions_enabled_sessions"
      expr: COUNT(CASE WHEN closed_captions_enabled = TRUE THEN 1 END)
      comment: "Number of sessions with closed captions enabled. Accessibility compliance metric and indicator of accessibility feature adoption."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`distribution_dai_session`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dynamic Ad Insertion (DAI) performance and monetization KPIs. Tracks ad fill rates, impression delivery, pod performance, and targeting effectiveness — essential for ad revenue optimization and advertiser commitment fulfillment."
  source: "`vibe_media_broadcasting_v1`.`distribution`.`dai_session`"
  dimensions:
    - name: "platform_type"
      expr: platform_type
      comment: "Platform type (CTV, mobile, web) for cross-platform ad performance segmentation."
    - name: "device_type"
      expr: device_type
      comment: "Device category for ad delivery performance analysis by device class."
    - name: "stitching_mode"
      expr: stitching_mode
      comment: "Ad stitching mode (server-side, client-side) to evaluate technical delivery approach effectiveness."
    - name: "scte35_cue_type"
      expr: scte35_cue_type
      comment: "SCTE-35 cue type triggering the ad insertion opportunity, for signal quality and inventory analysis."
    - name: "session_status"
      expr: session_status
      comment: "DAI session status (active, completed, error) for operational health monitoring."
    - name: "geographic_dma_code"
      expr: geographic_dma_code
      comment: "DMA code of the viewer for geographic ad targeting performance analysis."
    - name: "geographic_country_code"
      expr: geographic_country_code
      comment: "Country code for international ad delivery and compliance segmentation."
    - name: "session_date"
      expr: DATE_TRUNC('day', session_start_timestamp)
      comment: "Date of the DAI session for daily ad revenue and fill rate trending."
    - name: "session_month"
      expr: DATE_TRUNC('month', session_start_timestamp)
      comment: "Month of the DAI session for monthly ad revenue reporting and forecasting."
    - name: "blackout_override_flag"
      expr: blackout_override_flag
      comment: "Whether a blackout override was applied, for compliance and rights enforcement monitoring."
  measures:
    - name: "total_dai_sessions"
      expr: COUNT(1)
      comment: "Total DAI sessions processed. Baseline volume metric for ad inventory utilization and platform scale."
    - name: "total_ads_inserted"
      expr: SUM(CAST(ads_inserted_count AS DOUBLE))
      comment: "Total number of ads successfully inserted across all sessions. Core ad delivery volume metric tied directly to revenue realization."
    - name: "total_ads_requested"
      expr: SUM(CAST(ads_requested_count AS DOUBLE))
      comment: "Total ad requests made to the ad decision server. Denominator for fill rate calculation and inventory demand measurement."
    - name: "total_ads_fallback"
      expr: SUM(CAST(ads_fallback_count AS DOUBLE))
      comment: "Total fallback ads served when primary ad decisioning failed. High fallback counts indicate ad server issues or targeting gaps."
    - name: "avg_fill_rate_percentage"
      expr: AVG(CAST(fill_rate_percentage AS DOUBLE))
      comment: "Average ad fill rate across DAI sessions. Critical revenue metric — fill rate directly determines monetization efficiency of ad inventory."
    - name: "total_ad_pod_duration_seconds"
      expr: SUM(CAST(ad_pod_duration_seconds AS DOUBLE))
      comment: "Total ad pod duration delivered in seconds. Measures total ad time monetized, directly tied to CPM-based revenue."
    - name: "avg_ad_pod_duration_seconds"
      expr: AVG(CAST(ad_pod_duration_seconds AS DOUBLE))
      comment: "Average ad pod duration per session. Informs ad load strategy and viewer experience trade-off decisions."
    - name: "total_ad_duration_seconds"
      expr: SUM(CAST(total_ad_duration_seconds AS DOUBLE))
      comment: "Total ad duration delivered across all sessions in seconds. Aggregate monetized ad time for revenue attribution."
    - name: "avg_ad_server_response_time_ms"
      expr: AVG(CAST(ad_decision_server_response_time_ms AS DOUBLE))
      comment: "Average ad decision server response time in milliseconds. Technical performance metric — high latency causes ad timeouts and lost revenue."
    - name: "sessions_with_frequency_cap"
      expr: COUNT(CASE WHEN frequency_cap_applied_flag = TRUE THEN 1 END)
      comment: "Sessions where frequency capping was applied. Indicates ad fatigue management effectiveness and campaign pacing health."
    - name: "distinct_subscribers_reached"
      expr: COUNT(DISTINCT subscriber_id)
      comment: "Unique subscribers reached via DAI. Measures unduplicated audience for advertiser reach reporting and guarantee fulfillment."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`distribution_sla_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Distribution SLA compliance and breach KPIs. Tracks actual vs. target performance, penalty exposure, and breach frequency — essential for partner contract management, operational accountability, and financial risk control."
  source: "`vibe_media_broadcasting_v1`.`distribution`.`sla_performance`"
  dimensions:
    - name: "affected_platform"
      expr: affected_platform
      comment: "Platform affected by the SLA measurement for platform-level performance segmentation."
    - name: "affected_region"
      expr: affected_region
      comment: "Geographic region of the SLA measurement for regional performance accountability."
    - name: "breach_flag"
      expr: breach_flag
      comment: "Whether the measurement period resulted in an SLA breach, for breach vs. compliance segmentation."
    - name: "breach_severity"
      expr: breach_severity
      comment: "Severity classification of the SLA breach for prioritized remediation and escalation."
    - name: "measurement_status"
      expr: measurement_status
      comment: "Status of the SLA measurement record (validated, pending, disputed) for data quality filtering."
    - name: "streaming_protocol"
      expr: streaming_protocol
      comment: "Streaming protocol associated with the SLA measurement for protocol-level performance analysis."
    - name: "cdn_provider"
      expr: cdn_provider
      comment: "CDN provider associated with the measurement for vendor performance benchmarking."
    - name: "measurement_period_month"
      expr: DATE_TRUNC('month', measurement_period_start)
      comment: "Month of the SLA measurement period for monthly compliance trend reporting."
    - name: "device_category"
      expr: device_category
      comment: "Device category for device-level SLA performance segmentation."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Whether the SLA measurement is under dispute, for financial risk and partner relationship management."
  measures:
    - name: "total_measurements"
      expr: COUNT(1)
      comment: "Total SLA measurement records. Baseline volume for compliance coverage assessment."
    - name: "total_breach_count"
      expr: COUNT(CASE WHEN breach_flag = TRUE THEN 1 END)
      comment: "Total number of SLA breaches. Core operational risk metric — high breach counts trigger contract penalties and partner escalations."
    - name: "breach_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN breach_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of measurement periods resulting in an SLA breach. Executive KPI for distribution reliability and partner contract health."
    - name: "avg_actual_value"
      expr: AVG(CAST(actual_value AS DOUBLE))
      comment: "Average actual SLA metric value across measurement periods. Compared against target to assess performance trajectory."
    - name: "avg_target_value"
      expr: AVG(CAST(target_value AS DOUBLE))
      comment: "Average SLA target value across measurement periods. Baseline for performance gap analysis."
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average percentage variance between actual and target SLA values. Indicates systematic over- or under-performance against contractual commitments."
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total financial penalties incurred from SLA breaches. Direct P&L impact metric for distribution operations cost management."
    - name: "avg_breach_duration_minutes"
      expr: AVG(CAST(breach_duration_minutes AS DOUBLE))
      comment: "Average duration of SLA breaches in minutes. Operational severity metric — longer breaches indicate systemic infrastructure issues."
    - name: "total_sample_size"
      expr: SUM(CAST(sample_size AS DOUBLE))
      comment: "Total measurement sample size across all SLA records. Validates statistical significance of performance measurements."
    - name: "disputed_measurements"
      expr: COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END)
      comment: "Number of SLA measurements under dispute. Indicates partner relationship friction and potential revenue-at-risk from contested penalties."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`distribution_delivery_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Content delivery performance and quality KPIs at the event level. Tracks bytes delivered, error rates, ad fill, and delivery technology effectiveness — operational metrics for CDN optimization and delivery infrastructure decisions."
  source: "`vibe_media_broadcasting_v1`.`distribution`.`delivery_event`"
  dimensions:
    - name: "delivery_status"
      expr: delivery_status
      comment: "Delivery outcome status (success, error, partial) for quality and reliability segmentation."
    - name: "delivery_technology"
      expr: delivery_technology
      comment: "Technology used for delivery (OTT, MVPD, satellite) for infrastructure performance comparison."
    - name: "delivery_channel_type"
      expr: delivery_channel_type
      comment: "Type of delivery channel for channel-level performance analysis."
    - name: "streaming_protocol"
      expr: streaming_protocol
      comment: "Streaming protocol used for the delivery event for protocol efficiency benchmarking."
    - name: "cdn_cache_status"
      expr: cdn_cache_status
      comment: "CDN cache hit/miss status for cache efficiency and origin offload analysis."
    - name: "cdn_pop_location"
      expr: cdn_pop_location
      comment: "CDN point-of-presence location for geographic delivery performance analysis."
    - name: "event_type"
      expr: event_type
      comment: "Type of delivery event (start, bitrate change, error, end) for event-level operational analysis."
    - name: "geographic_country_code"
      expr: geographic_country_code
      comment: "Country of the delivery event for international distribution performance reporting."
    - name: "event_date"
      expr: DATE_TRUNC('day', event_timestamp)
      comment: "Date of the delivery event for daily throughput and quality trending."
    - name: "dai_enabled"
      expr: dai_enabled
      comment: "Whether DAI was active during the delivery event for ad-enabled vs. non-ad delivery comparison."
    - name: "drm_system"
      expr: drm_system
      comment: "DRM system used during delivery for rights enforcement and compatibility analysis."
  measures:
    - name: "total_delivery_events"
      expr: COUNT(1)
      comment: "Total delivery events recorded. Baseline volume metric for delivery infrastructure scale and throughput."
    - name: "total_bytes_delivered"
      expr: SUM(CAST(bytes_delivered AS DOUBLE))
      comment: "Total bytes delivered across all events. Core infrastructure capacity metric tied to CDN cost and bandwidth planning."
    - name: "avg_bytes_delivered"
      expr: AVG(CAST(bytes_delivered AS DOUBLE))
      comment: "Average bytes delivered per event. Indicates typical payload size for capacity and cost modeling."
    - name: "avg_ad_fill_rate_percent"
      expr: AVG(CAST(ad_fill_rate_percent AS DOUBLE))
      comment: "Average ad fill rate across delivery events. Revenue efficiency metric — low fill rates indicate lost ad monetization opportunities."
    - name: "error_event_count"
      expr: COUNT(CASE WHEN error_code IS NOT NULL AND error_code <> '' THEN 1 END)
      comment: "Number of delivery events with errors. Operational quality metric — high error counts trigger CDN and infrastructure investigations."
    - name: "error_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN error_code IS NOT NULL AND error_code <> '' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of delivery events resulting in an error. Key reliability KPI for SLA compliance and infrastructure health dashboards."
    - name: "avg_network_latency_ms"
      expr: AVG(CAST(network_latency_ms AS DOUBLE))
      comment: "Average network latency in milliseconds across delivery events. Technical performance metric directly impacting viewer QoE and SLA compliance."
    - name: "avg_origin_response_time_ms"
      expr: AVG(CAST(origin_server_response_time_ms AS DOUBLE))
      comment: "Average origin server response time in milliseconds. Identifies origin infrastructure bottlenecks affecting delivery quality."
    - name: "distinct_sessions_delivered"
      expr: COUNT(DISTINCT playback_session_id)
      comment: "Unique playback sessions with delivery events. Measures active delivery footprint for capacity and subscriber reach reporting."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`distribution_carriage_fee_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Carriage fee billing and revenue collection KPIs. Tracks invoice amounts, payment status, dispute rates, and reconciliation health — essential for distribution revenue management and partner financial accountability."
  source: "`vibe_media_broadcasting_v1`.`distribution`.`distribution_carriage_fee_invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the carriage fee invoice (draft, sent, paid, disputed) for AR pipeline management."
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of the invoice for cash collection and aging analysis."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Whether the invoice is under dispute, for financial risk and partner relationship management."
    - name: "fee_basis"
      expr: fee_basis
      comment: "Basis for the carriage fee calculation (per-subscriber, flat fee, etc.) for revenue model analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the invoice for multi-currency revenue reporting and FX exposure analysis."
    - name: "billing_period_month"
      expr: DATE_TRUNC('month', billing_period_start_date)
      comment: "Billing period month for monthly carriage revenue trending and forecasting."
    - name: "invoice_date_month"
      expr: DATE_TRUNC('month', invoice_date)
      comment: "Month the invoice was issued for billing cycle and revenue recognition timing analysis."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status of the invoice for financial close and audit readiness monitoring."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used for settlement for treasury and cash management analysis."
  measures:
    - name: "total_invoices"
      expr: COUNT(1)
      comment: "Total carriage fee invoices issued. Baseline volume for billing operations and partner activity monitoring."
    - name: "total_invoice_amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total carriage fee revenue billed. Core distribution revenue metric for P&L reporting and partner contract value tracking."
    - name: "total_base_fee_amount"
      expr: SUM(CAST(base_fee_amount AS DOUBLE))
      comment: "Total base carriage fees before adjustments. Measures contracted revenue before disputes and adjustments."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total fee adjustments applied across invoices. Tracks revenue leakage from credits, disputes, and corrections."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected on carriage fee invoices. Required for tax compliance reporting and remittance."
    - name: "disputed_invoice_count"
      expr: COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END)
      comment: "Number of invoices under dispute. Indicates partner relationship friction and revenue-at-risk from contested charges."
    - name: "dispute_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of invoices under dispute. Executive KPI for distribution partner relationship health and billing quality."
    - name: "avg_invoice_amount"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average carriage fee invoice value. Benchmarks partner contract size and informs pricing strategy."
    - name: "distinct_partners_billed"
      expr: COUNT(DISTINCT distribution_partner_id)
      comment: "Number of unique distribution partners billed. Measures active billing relationship footprint."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`distribution_sla_breach`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SLA breach incident KPIs for distribution operations. Tracks breach severity, penalty exposure, resolution time, and root cause patterns — critical for operational risk management and partner contract governance."
  source: "`vibe_media_broadcasting_v1`.`distribution`.`sla_breach`"
  dimensions:
    - name: "breach_severity"
      expr: breach_severity
      comment: "Severity level of the SLA breach (critical, major, minor) for prioritized remediation and escalation."
    - name: "breach_status"
      expr: breach_status
      comment: "Current status of the breach (open, resolved, disputed) for operational tracking."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category of the breach for systemic issue identification and prevention."
    - name: "affected_platform"
      expr: affected_platform
      comment: "Platform affected by the breach for platform-level reliability analysis."
    - name: "affected_region"
      expr: affected_region
      comment: "Geographic region of the breach for regional infrastructure accountability."
    - name: "cdn_provider"
      expr: cdn_provider
      comment: "CDN provider associated with the breach for vendor performance and accountability analysis."
    - name: "metric_type"
      expr: metric_type
      comment: "Type of SLA metric breached (uptime, latency, error rate) for metric-level performance analysis."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Whether the breach is under dispute for financial risk and partner negotiation tracking."
    - name: "breach_month"
      expr: DATE_TRUNC('month', breach_timestamp)
      comment: "Month of the breach for monthly reliability trend reporting and capacity planning."
    - name: "penalty_applicable_flag"
      expr: penalty_applicable_flag
      comment: "Whether a financial penalty applies to the breach for revenue impact segmentation."
  measures:
    - name: "total_breaches"
      expr: COUNT(1)
      comment: "Total SLA breach incidents. Baseline reliability metric for distribution operations health."
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total financial penalties from SLA breaches. Direct P&L impact metric for distribution cost management and contract risk reporting."
    - name: "avg_penalty_amount"
      expr: AVG(CAST(penalty_amount AS DOUBLE))
      comment: "Average penalty per SLA breach. Benchmarks breach cost severity for contract renegotiation and risk modeling."
    - name: "avg_breach_duration_minutes"
      expr: AVG(CAST(breach_duration_minutes AS DOUBLE))
      comment: "Average breach duration in minutes. Operational severity metric — longer breaches indicate systemic infrastructure failures."
    - name: "avg_measured_value"
      expr: AVG(CAST(measured_value AS DOUBLE))
      comment: "Average measured metric value at time of breach. Quantifies how far performance fell below SLA thresholds."
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average percentage variance from SLA threshold at breach. Indicates severity of performance degradation relative to contractual commitments."
    - name: "makegood_triggered_count"
      expr: COUNT(CASE WHEN makegood_triggered_flag = TRUE THEN 1 END)
      comment: "Number of breaches that triggered a makegood. Measures remediation activity and advertiser/partner compensation obligations."
    - name: "penalty_applicable_breach_count"
      expr: COUNT(CASE WHEN penalty_applicable_flag = TRUE THEN 1 END)
      comment: "Number of breaches with applicable financial penalties. Measures financial exposure from distribution reliability failures."
    - name: "distinct_endpoints_breached"
      expr: COUNT(DISTINCT streaming_endpoint_id)
      comment: "Number of unique streaming endpoints that experienced SLA breaches. Identifies infrastructure hotspots requiring investment."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`distribution_subscriber_count_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Distribution subscriber count reporting KPIs. Tracks reported vs. verified subscriber counts, variance rates, and audit compliance — essential for carriage fee calculation accuracy and partner contract enforcement."
  source: "`vibe_media_broadcasting_v1`.`distribution`.`subscriber_count_report`"
  dimensions:
    - name: "report_status"
      expr: report_status
      comment: "Status of the subscriber count report (submitted, approved, disputed) for reporting pipeline management."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the report for governance and audit readiness tracking."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Whether the subscriber count is under dispute, for financial risk and partner relationship management."
    - name: "variance_flag"
      expr: variance_flag
      comment: "Whether a material variance exists between reported and verified counts, for audit and billing accuracy monitoring."
    - name: "reporting_period_type"
      expr: reporting_period_type
      comment: "Frequency of the reporting period (monthly, quarterly) for temporal analysis."
    - name: "reporting_period_month"
      expr: DATE_TRUNC('month', reporting_period_start_date)
      comment: "Month of the reporting period for subscriber count trend analysis."
    - name: "audit_rights_exercised"
      expr: audit_rights_exercised
      comment: "Whether audit rights were exercised for this report, for compliance and governance monitoring."
    - name: "invoice_generated_flag"
      expr: invoice_generated_flag
      comment: "Whether an invoice was generated from this report, for billing cycle completeness tracking."
  measures:
    - name: "total_reports"
      expr: COUNT(1)
      comment: "Total subscriber count reports submitted. Baseline volume for reporting compliance monitoring."
    - name: "total_reported_subscribers"
      expr: SUM(CAST(reported_subscriber_count AS DOUBLE))
      comment: "Total reported subscriber count across all reports. Core metric for carriage fee calculation and distribution reach measurement."
    - name: "total_verified_subscribers"
      expr: SUM(CAST(verified_subscriber_count AS DOUBLE))
      comment: "Total verified subscriber count after audit. Compared against reported count to identify under-reporting and revenue leakage."
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average percentage variance between reported and verified subscriber counts. Measures billing accuracy and partner reporting integrity."
    - name: "total_variance_count"
      expr: SUM(CAST(variance_count AS DOUBLE))
      comment: "Total subscriber count variance across all reports. Quantifies absolute billing discrepancy for revenue recovery analysis."
    - name: "avg_carriage_fee_per_subscriber"
      expr: AVG(CAST(carriage_fee_per_subscriber AS DOUBLE))
      comment: "Average carriage fee per subscriber across reports. Benchmarks per-subscriber economics for contract pricing and negotiation."
    - name: "disputed_report_count"
      expr: COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END)
      comment: "Number of reports under dispute. Indicates partner reporting friction and potential revenue-at-risk."
    - name: "variance_report_count"
      expr: COUNT(CASE WHEN variance_flag = TRUE THEN 1 END)
      comment: "Number of reports with material subscriber count variances. Triggers audit and billing correction workflows."
    - name: "distinct_partners_reporting"
      expr: COUNT(DISTINCT distribution_partner_id)
      comment: "Number of unique distribution partners submitting subscriber count reports. Measures reporting compliance coverage."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`distribution_qos_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality of Service (QoS) event KPIs for streaming delivery. Tracks buffering, bitrate performance, error rates, and playback quality — operational metrics for engineering teams to maintain viewer experience standards."
  source: "`vibe_media_broadcasting_v1`.`distribution`.`qos_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of QoS event (buffering, bitrate change, error, stall) for event-level quality analysis."
    - name: "event_severity"
      expr: event_severity
      comment: "Severity of the QoS event for prioritized engineering response and SLA impact assessment."
    - name: "player_state"
      expr: player_state
      comment: "Player state at time of event (playing, buffering, paused, error) for playback health analysis."
    - name: "cdn_cache_status"
      expr: cdn_cache_status
      comment: "CDN cache status at time of event for cache efficiency and origin load analysis."
    - name: "streaming_protocol"
      expr: streaming_protocol
      comment: "Streaming protocol in use during the QoS event for protocol-level quality benchmarking."
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region of the QoS event for regional infrastructure performance analysis."
    - name: "isp_name"
      expr: isp_name
      comment: "Internet service provider of the viewer for ISP-level quality analysis and peering decisions."
    - name: "drm_system"
      expr: drm_system
      comment: "DRM system active during the event for DRM-related performance issue identification."
    - name: "event_date"
      expr: DATE_TRUNC('day', event_timestamp)
      comment: "Date of the QoS event for daily quality trend monitoring."
    - name: "device_type"
      expr: device_type
      comment: "Device type experiencing the QoS event for device-level quality analysis."
  measures:
    - name: "total_qos_events"
      expr: COUNT(1)
      comment: "Total QoS events recorded. Baseline volume for streaming quality monitoring and infrastructure health assessment."
    - name: "avg_buffer_level_seconds"
      expr: AVG(CAST(buffer_level_seconds AS DOUBLE))
      comment: "Average buffer level in seconds at time of QoS event. Low buffer levels predict imminent rebuffering and viewer abandonment."
    - name: "avg_playback_position_seconds"
      expr: AVG(CAST(playback_position_seconds AS DOUBLE))
      comment: "Average playback position at time of QoS event. Identifies content segments with recurring quality issues."
    - name: "avg_seek_position_seconds"
      expr: AVG(CAST(seek_position_seconds AS DOUBLE))
      comment: "Average seek position during QoS events. Identifies seek-related performance patterns for player optimization."
    - name: "avg_stall_duration_ms"
      expr: AVG(CAST(stall_duration_ms AS DOUBLE))
      comment: "Average stall duration in milliseconds. Critical viewer experience metric — stalls above threshold thresholds directly cause viewer abandonment."
    - name: "avg_network_latency_ms"
      expr: AVG(CAST(network_latency_ms AS DOUBLE))
      comment: "Average network latency at time of QoS event. Identifies network-layer issues contributing to quality degradation."
    - name: "avg_origin_response_time_ms"
      expr: AVG(CAST(origin_server_response_time_ms AS DOUBLE))
      comment: "Average origin server response time during QoS events. Identifies origin infrastructure bottlenecks."
    - name: "error_event_count"
      expr: COUNT(CASE WHEN error_code IS NOT NULL AND error_code <> '' THEN 1 END)
      comment: "Number of QoS events classified as errors. Operational quality metric for engineering escalation and SLA compliance."
    - name: "distinct_sessions_affected"
      expr: COUNT(DISTINCT playback_session_id)
      comment: "Number of unique playback sessions with QoS events. Measures breadth of quality issues across the viewer base."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`distribution_carriage_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Carriage agreement portfolio KPIs. Tracks agreement status, financial terms, renewal pipeline, and retransmission consent — strategic metrics for distribution deal management and revenue planning."
  source: "`vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the carriage agreement (active, expired, negotiating) for portfolio health monitoring."
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of carriage agreement (retransmission consent, must-carry, etc.) for deal type analysis."
    - name: "carriage_fee_currency"
      expr: carriage_fee_currency
      comment: "Currency of the carriage fee for multi-currency revenue analysis."
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Whether the agreement auto-renews, for renewal pipeline and revenue continuity planning."
    - name: "must_carry_election"
      expr: must_carry_election
      comment: "Whether must-carry election applies, for regulatory compliance and carriage strategy analysis."
    - name: "retransmission_consent_granted"
      expr: retransmission_consent_granted
      comment: "Whether retransmission consent has been granted, for rights and distribution compliance monitoring."
    - name: "effective_year"
      expr: DATE_TRUNC('year', effective_date)
      comment: "Year the agreement became effective for cohort and vintage analysis of the agreement portfolio."
    - name: "expiration_month"
      expr: DATE_TRUNC('month', expiration_date)
      comment: "Month the agreement expires for renewal pipeline management and revenue continuity planning."
  measures:
    - name: "total_agreements"
      expr: COUNT(1)
      comment: "Total carriage agreements in the portfolio. Baseline metric for distribution footprint and partner relationship scale."
    - name: "total_carriage_fee_amount"
      expr: SUM(CAST(carriage_fee_amount AS DOUBLE))
      comment: "Total contracted carriage fee value across all agreements. Core distribution revenue metric for financial planning and forecasting."
    - name: "avg_carriage_fee_amount"
      expr: AVG(CAST(carriage_fee_amount AS DOUBLE))
      comment: "Average carriage fee per agreement. Benchmarks deal economics for pricing strategy and negotiation."
    - name: "active_agreement_count"
      expr: COUNT(CASE WHEN agreement_status = 'active' THEN 1 END)
      comment: "Number of currently active carriage agreements. Measures live distribution footprint for revenue and reach reporting."
    - name: "expiring_agreement_count"
      expr: COUNT(CASE WHEN expiration_date <= DATE_ADD(CURRENT_DATE(), 90) AND agreement_status = 'active' THEN 1 END)
      comment: "Number of active agreements expiring within 90 days. Critical renewal pipeline metric for revenue continuity and negotiation prioritization."
    - name: "retransmission_consent_granted_count"
      expr: COUNT(CASE WHEN retransmission_consent_granted = TRUE THEN 1 END)
      comment: "Number of agreements with retransmission consent granted. Measures rights-cleared distribution coverage."
    - name: "distinct_partners"
      expr: COUNT(DISTINCT distribution_partner_id)
      comment: "Number of unique distribution partners under carriage agreements. Measures distribution partner ecosystem breadth."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`distribution_release_window`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Content release window and windowing strategy KPIs. Tracks window status, pricing, revenue share, and exclusivity — strategic metrics for content monetization and rights window optimization."
  source: "`vibe_media_broadcasting_v1`.`distribution`.`release_window`"
  dimensions:
    - name: "window_status"
      expr: window_status
      comment: "Current status of the release window (active, expired, pending) for windowing portfolio management."
    - name: "window_type"
      expr: window_type
      comment: "Type of release window (theatrical, SVOD, AVOD, TVOD, linear) for windowing strategy analysis."
    - name: "platform_type"
      expr: platform_type
      comment: "Platform type for the release window for platform-level monetization analysis."
    - name: "exclusivity_flag"
      expr: exclusivity_flag
      comment: "Whether the window is exclusive, for exclusivity premium and competitive positioning analysis."
    - name: "pricing_model"
      expr: pricing_model
      comment: "Pricing model for the window (subscription, transactional, ad-supported) for revenue model mix analysis."
    - name: "hdr_enabled"
      expr: hdr_enabled
      comment: "Whether HDR is enabled for the window, for premium format availability and upsell analysis."
    - name: "window_open_month"
      expr: DATE_TRUNC('month', window_open_date)
      comment: "Month the release window opens for content release calendar and revenue timing analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the window pricing for multi-currency revenue analysis."
  measures:
    - name: "total_release_windows"
      expr: COUNT(1)
      comment: "Total release windows defined. Baseline metric for content windowing portfolio scale."
    - name: "total_purchase_price_revenue"
      expr: SUM(CAST(purchase_price AS DOUBLE))
      comment: "Total purchase price across transactional windows. Measures TVOD revenue potential from the windowing portfolio."
    - name: "avg_purchase_price"
      expr: AVG(CAST(purchase_price AS DOUBLE))
      comment: "Average purchase price per transactional window. Benchmarks TVOD pricing strategy and informs price optimization."
    - name: "avg_rental_price"
      expr: AVG(CAST(rental_price AS DOUBLE))
      comment: "Average rental price per window. Benchmarks rental pricing strategy for transactional revenue optimization."
    - name: "avg_revenue_share_percent"
      expr: AVG(CAST(revenue_share_percent AS DOUBLE))
      comment: "Average revenue share percentage across windows. Measures partner economics and informs deal structure negotiations."
    - name: "total_minimum_guarantee_amount"
      expr: SUM(CAST(minimum_guarantee_amount AS DOUBLE))
      comment: "Total minimum guarantee commitments across release windows. Measures contracted revenue floor for financial planning."
    - name: "avg_ad_load_minutes"
      expr: AVG(CAST(ad_load_minutes AS DOUBLE))
      comment: "Average ad load per window in minutes. Informs ad inventory planning and viewer experience trade-off decisions."
    - name: "exclusive_window_count"
      expr: COUNT(CASE WHEN exclusivity_flag = TRUE THEN 1 END)
      comment: "Number of exclusive release windows. Measures exclusivity portfolio for competitive differentiation and premium pricing justification."
    - name: "active_window_count"
      expr: COUNT(CASE WHEN window_status = 'active' THEN 1 END)
      comment: "Number of currently active release windows. Measures live content monetization footprint."
    - name: "distinct_titles_windowed"
      expr: COUNT(DISTINCT title_id)
      comment: "Number of unique titles with release windows. Measures content portfolio coverage in the windowing strategy."
$$;