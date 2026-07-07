-- Metric views for domain: scheduling | Business: Media_Broadcasting | Version: 2 | Generated on: 2026-06-30 06:47:57

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`scheduling_program_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic scheduling KPIs: broadcast compliance, schedule efficiency, and operational readiness metrics that drive programming decisions and regulatory adherence."
  source: "`vibe_media_broadcasting_v1`.`scheduling`.`program_schedule`"
  dimensions:
    - name: "broadcast_date"
      expr: broadcast_date
      comment: "Date of broadcast transmission for daily performance tracking"
    - name: "broadcast_month"
      expr: DATE_TRUNC('MONTH', broadcast_date)
      comment: "Month of broadcast for monthly trend analysis"
    - name: "schedule_status"
      expr: schedule_status
      comment: "Current status of the program schedule (draft, approved, transmitted, etc.)"
    - name: "schedule_type"
      expr: schedule_type
      comment: "Type of schedule (regular, special event, emergency, etc.)"
    - name: "rights_clearance_status"
      expr: rights_clearance_status
      comment: "Rights clearance status indicating legal broadcast readiness"
    - name: "broadcast_standard"
      expr: broadcast_standard
      comment: "Technical broadcast standard (NTSC, PAL, ATSC, DVB, etc.)"
    - name: "transmission_type"
      expr: transmission_type
      comment: "Transmission delivery method (terrestrial, cable, satellite, OTT)"
    - name: "simulcast_flag"
      expr: simulcast_flag
      comment: "Whether schedule is simulcast across multiple platforms"
    - name: "blackout_flag"
      expr: blackout_flag
      comment: "Whether schedule includes blackout restrictions"
    - name: "fcc_children_programming_compliant"
      expr: fcc_children_programming_compliant
      comment: "FCC children's programming compliance flag for regulatory reporting"
    - name: "must_carry_compliant"
      expr: must_carry_compliant
      comment: "Must-carry regulation compliance flag"
    - name: "emergency_alert_ready"
      expr: emergency_alert_ready
      comment: "Emergency alert system readiness flag"
  measures:
    - name: "total_schedules"
      expr: COUNT(1)
      comment: "Total number of program schedules created"
    - name: "total_program_hours"
      expr: SUM(CAST(total_program_time_seconds AS DOUBLE)) / 3600.0
      comment: "Total hours of program content scheduled, key capacity utilization metric"
    - name: "total_ad_hours"
      expr: SUM(CAST(total_ad_time_seconds AS DOUBLE)) / 3600.0
      comment: "Total hours of advertising inventory scheduled, drives revenue capacity"
    - name: "total_runtime_hours"
      expr: SUM(CAST(total_runtime_seconds AS DOUBLE)) / 3600.0
      comment: "Total broadcast runtime hours including all content and ads"
    - name: "avg_ad_load_pct"
      expr: ROUND(100.0 * AVG(CAST(total_ad_time_seconds AS DOUBLE) / NULLIF(CAST(total_runtime_seconds AS DOUBLE), 0)), 2)
      comment: "Average advertising load percentage, critical for balancing revenue vs viewer experience"
    - name: "rights_cleared_schedule_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN rights_clearance_status = 'cleared' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of schedules with cleared broadcast rights, measures legal risk exposure"
    - name: "fcc_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN fcc_children_programming_compliant = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "FCC children's programming compliance rate, critical for regulatory adherence and license renewal"
    - name: "must_carry_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN must_carry_compliant = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Must-carry compliance rate, essential for cable/satellite carriage agreements"
    - name: "emergency_alert_readiness_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN emergency_alert_ready = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of schedules ready for emergency alerts, critical for public safety compliance"
    - name: "simulcast_penetration_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN simulcast_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of schedules simulcast across platforms, measures multi-platform reach strategy"
    - name: "avg_simulcast_platforms"
      expr: AVG(CAST(simulcast_platform_count AS DOUBLE))
      comment: "Average number of platforms per simulcast schedule, indicates distribution breadth"
    - name: "total_scte35_cues"
      expr: SUM(CAST(scte35_cue_count AS DOUBLE))
      comment: "Total SCTE-35 cue points for dynamic ad insertion, measures DAI readiness"
    - name: "avg_ad_pods_per_schedule"
      expr: AVG(CAST(ad_pod_count AS DOUBLE))
      comment: "Average number of ad pods per schedule, indicates ad break frequency strategy"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`scheduling_playout_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational playout execution KPIs: on-time performance, failover incidents, rights compliance, and transmission quality metrics that drive broadcast reliability and legal adherence."
  source: "`vibe_media_broadcasting_v1`.`scheduling`.`playout_event`"
  dimensions:
    - name: "broadcast_date"
      expr: broadcast_date
      comment: "Date of playout event for daily operational tracking"
    - name: "broadcast_month"
      expr: DATE_TRUNC('MONTH', broadcast_date)
      comment: "Month of playout for monthly performance trends"
    - name: "playout_status"
      expr: playout_status
      comment: "Execution status of playout event (completed, failed, aborted, etc.)"
    - name: "event_type"
      expr: event_type
      comment: "Type of playout event (program, commercial, promo, filler, etc.)"
    - name: "rights_clearance_status"
      expr: rights_clearance_status
      comment: "Rights clearance status at playout time, critical for legal compliance"
    - name: "automation_mode"
      expr: automation_mode
      comment: "Automation mode (fully automated, manual override, hybrid)"
    - name: "transmission_type"
      expr: transmission_type
      comment: "Transmission delivery method"
    - name: "broadcast_standard"
      expr: broadcast_standard
      comment: "Technical broadcast standard used"
    - name: "failover_activated"
      expr: failover_activated
      comment: "Whether failover was triggered during playout"
    - name: "blackout_flag"
      expr: blackout_flag
      comment: "Whether event was subject to blackout restrictions"
    - name: "simulcast_flag"
      expr: simulcast_flag
      comment: "Whether event was simulcast"
    - name: "dai_eligible"
      expr: dai_eligible
      comment: "Dynamic ad insertion eligibility flag"
    - name: "must_carry_flag"
      expr: must_carry_flag
      comment: "Must-carry regulation flag"
    - name: "affidavit_generated"
      expr: affidavit_generated
      comment: "Whether proof-of-performance affidavit was generated"
  measures:
    - name: "total_playout_events"
      expr: COUNT(1)
      comment: "Total number of playout events executed"
    - name: "total_playout_hours"
      expr: SUM(CAST(actual_duration_seconds AS DOUBLE)) / 3600.0
      comment: "Total hours of content actually played out"
    - name: "on_time_playout_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN ABS(CAST(start_deviation_seconds AS DOUBLE)) <= 2 THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of playout events starting within 2 seconds of schedule, critical operational KPI for broadcast quality"
    - name: "avg_start_deviation_seconds"
      expr: AVG(ABS(CAST(start_deviation_seconds AS DOUBLE)))
      comment: "Average absolute start time deviation in seconds, measures scheduling precision"
    - name: "failover_incident_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN failover_activated = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of playout events requiring failover, measures system reliability and risk"
    - name: "rights_cleared_playout_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN rights_clearance_status = 'cleared' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of playout events with cleared rights, critical for legal compliance and liability avoidance"
    - name: "affidavit_generation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN affidavit_generated = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of events with proof-of-performance affidavits, required for advertiser billing and compliance"
    - name: "dai_eligible_event_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN dai_eligible = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of events eligible for dynamic ad insertion, measures addressable advertising capacity"
    - name: "simulcast_event_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN simulcast_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of events simulcast, measures multi-platform distribution effectiveness"
    - name: "blackout_event_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN blackout_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of events subject to blackout, measures geographic rights restrictions impact"
    - name: "avg_actual_duration_minutes"
      expr: AVG(CAST(actual_duration_seconds AS DOUBLE)) / 60.0
      comment: "Average actual playout duration in minutes"
    - name: "duration_variance_pct"
      expr: ROUND(100.0 * AVG((CAST(actual_duration_seconds AS DOUBLE) - CAST(scheduled_duration_seconds AS DOUBLE)) / NULLIF(CAST(scheduled_duration_seconds AS DOUBLE), 0)), 2)
      comment: "Average percentage variance between actual and scheduled duration, measures content timing accuracy"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`scheduling_ad_break`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Advertising inventory and revenue KPIs: avail utilization, sell-through rates, CPM performance, and makegood requirements that drive advertising revenue optimization."
  source: "`vibe_media_broadcasting_v1`.`scheduling`.`ad_break`"
  dimensions:
    - name: "broadcast_date"
      expr: broadcast_date
      comment: "Date of ad break for daily revenue tracking"
    - name: "broadcast_month"
      expr: DATE_TRUNC('MONTH', broadcast_date)
      comment: "Month of ad break for monthly revenue trends"
    - name: "break_status"
      expr: break_status
      comment: "Status of ad break (scheduled, aired, preempted, etc.)"
    - name: "break_type"
      expr: break_type
      comment: "Type of ad break (local, network, promotional, etc.)"
    - name: "break_position"
      expr: break_position
      comment: "Position of break within program (opening, mid-roll, closing)"
    - name: "dai_eligible"
      expr: dai_eligible
      comment: "Dynamic ad insertion eligibility"
    - name: "simulcast_eligible"
      expr: simulcast_eligible
      comment: "Simulcast eligibility flag"
    - name: "blackout_restricted"
      expr: blackout_restricted
      comment: "Whether break is subject to blackout restrictions"
    - name: "makegood_required"
      expr: makegood_required
      comment: "Whether makegood is required due to delivery failure"
    - name: "affidavit_generated"
      expr: affidavit_generated
      comment: "Whether proof-of-performance affidavit was generated"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for financial metrics"
  measures:
    - name: "total_ad_breaks"
      expr: COUNT(1)
      comment: "Total number of ad breaks scheduled"
    - name: "total_avails"
      expr: SUM(CAST(avail_count AS DOUBLE))
      comment: "Total advertising avails (spots) available for sale"
    - name: "total_sold_avails"
      expr: SUM(CAST(sold_avail_count AS DOUBLE))
      comment: "Total avails sold to advertisers"
    - name: "avail_sell_through_rate"
      expr: ROUND(100.0 * SUM(CAST(sold_avail_count AS DOUBLE)) / NULLIF(SUM(CAST(avail_count AS DOUBLE)), 0), 2)
      comment: "Percentage of available ad inventory sold, critical revenue optimization KPI"
    - name: "total_planned_ad_hours"
      expr: SUM(CAST(planned_duration_seconds AS DOUBLE)) / 3600.0
      comment: "Total planned advertising hours"
    - name: "total_actual_ad_hours"
      expr: SUM(CAST(actual_duration_seconds AS DOUBLE)) / 3600.0
      comment: "Total actual advertising hours delivered"
    - name: "total_sold_ad_hours"
      expr: SUM(CAST(sold_duration_seconds AS DOUBLE)) / 3600.0
      comment: "Total sold advertising hours, drives revenue recognition"
    - name: "duration_sell_through_rate"
      expr: ROUND(100.0 * SUM(CAST(sold_duration_seconds AS DOUBLE)) / NULLIF(SUM(CAST(planned_duration_seconds AS DOUBLE)), 0), 2)
      comment: "Percentage of planned ad duration sold, measures inventory monetization efficiency"
    - name: "avg_rate_card_cpm"
      expr: AVG(CAST(rate_card_cpm AS DOUBLE))
      comment: "Average rate card CPM (cost per thousand impressions), key pricing benchmark"
    - name: "total_grp_target"
      expr: SUM(CAST(grp_target AS DOUBLE))
      comment: "Total gross rating points targeted across all breaks"
    - name: "avg_nielsen_program_rating"
      expr: AVG(CAST(nielsen_program_rating AS DOUBLE))
      comment: "Average Nielsen program rating, drives advertising pricing power"
    - name: "makegood_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN makegood_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of breaks requiring makegoods, measures delivery quality and advertiser satisfaction risk"
    - name: "affidavit_generation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN affidavit_generated = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of breaks with affidavits, required for billing and compliance"
    - name: "dai_eligible_break_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN dai_eligible = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of breaks eligible for dynamic ad insertion, measures addressable ad capacity"
    - name: "blackout_restricted_break_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN blackout_restricted = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of breaks subject to blackout, measures geographic revenue restrictions"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`scheduling_channel`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Channel performance and capability KPIs: carriage economics, technical capabilities, and regulatory compliance metrics that drive distribution strategy and platform investment decisions."
  source: "`vibe_media_broadcasting_v1`.`scheduling`.`channel`"
  dimensions:
    - name: "channel_status"
      expr: channel_status
      comment: "Current operational status of channel"
    - name: "channel_type"
      expr: channel_type
      comment: "Type of channel (linear, OTT, hybrid, etc.)"
    - name: "network_name"
      expr: network_name
      comment: "Network affiliation or brand name"
    - name: "genre"
      expr: genre
      comment: "Primary content genre of channel"
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country where channel originates"
    - name: "primary_language"
      expr: primary_language
      comment: "Primary broadcast language"
    - name: "transmission_standard"
      expr: transmission_standard
      comment: "Technical transmission standard"
    - name: "resolution_profile"
      expr: resolution_profile
      comment: "Video resolution profile (SD, HD, 4K, etc.)"
    - name: "broadcast_timezone"
      expr: broadcast_timezone
      comment: "Timezone for broadcast scheduling"
    - name: "dai_enabled"
      expr: dai_enabled
      comment: "Dynamic ad insertion capability enabled"
    - name: "drm_enabled"
      expr: drm_enabled
      comment: "Digital rights management enabled"
    - name: "scte35_enabled"
      expr: scte35_enabled
      comment: "SCTE-35 signaling enabled for ad insertion"
    - name: "epg_enabled"
      expr: epg_enabled
      comment: "Electronic program guide enabled"
    - name: "playout_automation_enabled"
      expr: playout_automation_enabled
      comment: "Playout automation capability enabled"
    - name: "must_carry_status"
      expr: must_carry_status
      comment: "Must-carry regulatory status"
    - name: "retransmission_consent_required"
      expr: retransmission_consent_required
      comment: "Whether retransmission consent is required"
    - name: "blackout_enabled"
      expr: blackout_enabled
      comment: "Blackout capability enabled"
  measures:
    - name: "total_channels"
      expr: COUNT(1)
      comment: "Total number of channels in portfolio"
    - name: "active_channels"
      expr: COUNT(CASE WHEN channel_status = 'active' THEN 1 END)
      comment: "Number of active operational channels"
    - name: "total_carriage_fee_revenue"
      expr: SUM(CAST(carriage_fee_usd AS DOUBLE))
      comment: "Total carriage fee revenue from distributors, key distribution revenue stream"
    - name: "avg_carriage_fee_per_channel"
      expr: AVG(CAST(carriage_fee_usd AS DOUBLE))
      comment: "Average carriage fee per channel, measures distribution pricing power"
    - name: "avg_max_ad_load_pct"
      expr: AVG(CAST(max_ad_load_pct AS DOUBLE))
      comment: "Average maximum advertising load percentage across channels, balances revenue vs viewer experience"
    - name: "dai_enabled_channel_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN dai_enabled = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of channels with dynamic ad insertion capability, measures addressable advertising readiness"
    - name: "drm_enabled_channel_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN drm_enabled = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of channels with DRM enabled, measures content protection capability"
    - name: "scte35_enabled_channel_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN scte35_enabled = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of channels with SCTE-35 signaling, critical for programmatic ad insertion"
    - name: "playout_automation_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN playout_automation_enabled = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of channels with playout automation, measures operational efficiency and cost reduction"
    - name: "epg_enabled_channel_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN epg_enabled = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of channels with EPG capability, measures viewer discovery and engagement enablement"
    - name: "must_carry_channel_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN must_carry_status = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of channels with must-carry status, measures regulatory distribution protection"
    - name: "retransmission_consent_channel_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN retransmission_consent_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of channels requiring retransmission consent, impacts distribution negotiation leverage"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`scheduling_channel_license`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Content licensing economics KPIs: license utilization, fee efficiency, and rights consumption metrics that drive content acquisition ROI and programming strategy."
  source: "`vibe_media_broadcasting_v1`.`scheduling`.`channel_license`"
  dimensions:
    - name: "license_status"
      expr: license_status
      comment: "Current status of content license"
    - name: "territory_code"
      expr: territory_code
      comment: "Geographic territory covered by license"
    - name: "exclusivity_flag"
      expr: exclusivity_flag
      comment: "Whether license grants exclusive rights"
    - name: "license_start_month"
      expr: DATE_TRUNC('MONTH', license_start_date)
      comment: "Month when license becomes active"
    - name: "license_end_month"
      expr: DATE_TRUNC('MONTH', license_end_date)
      comment: "Month when license expires"
  measures:
    - name: "total_licenses"
      expr: COUNT(1)
      comment: "Total number of content licenses"
    - name: "active_licenses"
      expr: COUNT(CASE WHEN license_status = 'active' THEN 1 END)
      comment: "Number of currently active licenses"
    - name: "total_license_fees"
      expr: SUM(CAST(license_fee_usd AS DOUBLE))
      comment: "Total content licensing fees paid, major content acquisition cost driver"
    - name: "avg_license_fee"
      expr: AVG(CAST(license_fee_usd AS DOUBLE))
      comment: "Average license fee per agreement, measures content acquisition pricing"
    - name: "total_runs_allowed"
      expr: SUM(CAST(runs_allowed AS DOUBLE))
      comment: "Total broadcast runs allowed across all licenses"
    - name: "total_runs_consumed"
      expr: SUM(CAST(runs_consumed AS DOUBLE))
      comment: "Total broadcast runs consumed"
    - name: "runs_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(runs_consumed AS DOUBLE)) / NULLIF(SUM(CAST(runs_allowed AS DOUBLE)), 0), 2)
      comment: "Percentage of allowed runs consumed, measures content licensing ROI and programming efficiency"
    - name: "cost_per_run"
      expr: SUM(CAST(license_fee_usd AS DOUBLE)) / NULLIF(SUM(CAST(runs_consumed AS DOUBLE)), 0)
      comment: "Average cost per broadcast run, key content acquisition efficiency metric"
    - name: "exclusive_license_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN exclusivity_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of licenses with exclusive rights, measures competitive content advantage"
    - name: "avg_license_duration_days"
      expr: AVG(DATEDIFF(license_end_date, license_start_date))
      comment: "Average license duration in days, measures content rights window length"
$$;