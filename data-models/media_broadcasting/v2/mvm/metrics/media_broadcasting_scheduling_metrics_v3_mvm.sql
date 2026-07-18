-- Metric views for domain: scheduling | Business: Media_Broadcasting | Version: 3 | Generated on: 2026-07-10 21:13:11

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`scheduling_ad_break`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ad Break business metrics"
  source: "`vibe_media_broadcasting_v1`.`scheduling`.`ad_break`"
  dimensions:
    - name: "Actual Duration Seconds"
      expr: actual_duration_seconds
    - name: "Actual Start Time"
      expr: actual_start_time
    - name: "Affidavit Generated"
      expr: affidavit_generated
    - name: "Automation Event Code"
      expr: automation_event_code
    - name: "Avail Count"
      expr: avail_count
    - name: "Blackout Restricted"
      expr: blackout_restricted
    - name: "Break Position"
      expr: break_position
    - name: "Break Status"
      expr: break_status
    - name: "Break Type"
      expr: break_type
    - name: "Broadcast Date"
      expr: broadcast_date
    - name: "Content Restriction Code"
      expr: content_restriction_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Dai Eligible"
      expr: dai_eligible
    - name: "Epg Break Label"
      expr: epg_break_label
    - name: "Makegood Required"
      expr: makegood_required
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Ad Break"
      expr: COUNT(DISTINCT ad_break_id)
    - name: "Total Grp Target"
      expr: SUM(grp_target)
    - name: "Average Grp Target"
      expr: AVG(grp_target)
    - name: "Total Nielsen Program Rating"
      expr: SUM(nielsen_program_rating)
    - name: "Average Nielsen Program Rating"
      expr: AVG(nielsen_program_rating)
    - name: "Total Rate Card Cpm"
      expr: SUM(rate_card_cpm)
    - name: "Average Rate Card Cpm"
      expr: AVG(rate_card_cpm)
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`scheduling_channel`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Channel business metrics"
  source: "`vibe_media_broadcasting_v1`.`scheduling`.`channel`"
  dimensions:
    - name: "Ad Break Duration Sec"
      expr: ad_break_duration_sec
    - name: "Affiliate Network Code"
      expr: affiliate_network_code
    - name: "Blackout Enabled"
      expr: blackout_enabled
    - name: "Broadcast Timezone"
      expr: broadcast_timezone
    - name: "Call Sign"
      expr: call_sign
    - name: "Cdn Origin Url"
      expr: cdn_origin_url
    - name: "Channel Status"
      expr: channel_status
    - name: "Channel Type"
      expr: channel_type
    - name: "Content Rating System"
      expr: content_rating_system
    - name: "Country Of Origin"
      expr: country_of_origin
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Dai Enabled"
      expr: dai_enabled
    - name: "Dalet Channel Code"
      expr: dalet_channel_code
    - name: "Decommission Date"
      expr: decommission_date
    - name: "Drm Enabled"
      expr: drm_enabled
    - name: "Epg Enabled"
      expr: epg_enabled
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Channel"
      expr: COUNT(DISTINCT channel_id)
    - name: "Total Carriage Fee Usd"
      expr: SUM(carriage_fee_usd)
    - name: "Average Carriage Fee Usd"
      expr: AVG(carriage_fee_usd)
    - name: "Total Max Ad Load Pct"
      expr: SUM(max_ad_load_pct)
    - name: "Average Max Ad Load Pct"
      expr: AVG(max_ad_load_pct)
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`scheduling_daypart`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Daypart business metrics"
  source: "`vibe_media_broadcasting_v1`.`scheduling`.`daypart`"
  dimensions:
    - name: "Ad Pod Max Count"
      expr: ad_pod_max_count
    - name: "Ad Pod Max Duration Seconds"
      expr: ad_pod_max_duration_seconds
    - name: "Applicable Days"
      expr: applicable_days
    - name: "Blackout Eligible"
      expr: blackout_eligible
    - name: "Code"
      expr: daypart_code
    - name: "Content Rating Restriction"
      expr: content_rating_restriction
    - name: "Coppa Restricted"
      expr: coppa_restricted
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Dai Eligible"
      expr: dai_eligible
    - name: "Day Category"
      expr: day_category
    - name: "Daypart Status"
      expr: daypart_status
    - name: "Daypart Type"
      expr: daypart_type
    - name: "Description"
      expr: daypart_description
    - name: "Duration Minutes"
      expr: duration_minutes
    - name: "Effective From"
      expr: effective_from
    - name: "Effective Until"
      expr: effective_until
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Daypart"
      expr: COUNT(DISTINCT daypart_id)
    - name: "Total Avg Audience 000"
      expr: SUM(avg_audience_000)
    - name: "Average Avg Audience 000"
      expr: AVG(avg_audience_000)
    - name: "Total Base Cpm Usd"
      expr: SUM(base_cpm_usd)
    - name: "Average Base Cpm Usd"
      expr: AVG(base_cpm_usd)
    - name: "Total Grp Index"
      expr: SUM(grp_index)
    - name: "Average Grp Index"
      expr: AVG(grp_index)
    - name: "Total Hut Level"
      expr: SUM(hut_level)
    - name: "Average Hut Level"
      expr: AVG(hut_level)
    - name: "Total Rate Multiplier"
      expr: SUM(rate_multiplier)
    - name: "Average Rate Multiplier"
      expr: AVG(rate_multiplier)
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`scheduling_epg_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Epg Entry business metrics"
  source: "`vibe_media_broadcasting_v1`.`scheduling`.`epg_entry`"
  dimensions:
    - name: "Ad Pod Count"
      expr: ad_pod_count
    - name: "Blackout Region Codes"
      expr: blackout_region_codes
    - name: "Broadcast Date"
      expr: broadcast_date
    - name: "Code"
      expr: epg_entry_code
    - name: "Distribution Window"
      expr: distribution_window
    - name: "Duration Seconds"
      expr: duration_seconds
    - name: "Eidr"
      expr: eidr
    - name: "Entry Status"
      expr: entry_status
    - name: "Epg Feed Version"
      expr: epg_feed_version
    - name: "Genre Primary"
      expr: genre_primary
    - name: "Genre Secondary"
      expr: genre_secondary
    - name: "Is Blackout"
      expr: is_blackout
    - name: "Is Closed Caption"
      expr: is_closed_caption
    - name: "Is Hdr"
      expr: is_hdr
    - name: "Is Live"
      expr: is_live
    - name: "Is New Episode"
      expr: is_new_episode
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Epg Entry"
      expr: COUNT(DISTINCT epg_entry_id)
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`scheduling_playout_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Playout Event business metrics"
  source: "`vibe_media_broadcasting_v1`.`scheduling`.`playout_event`"
  dimensions:
    - name: "Actual Duration Seconds"
      expr: actual_duration_seconds
    - name: "Actual End Time"
      expr: actual_end_time
    - name: "Actual Start Time"
      expr: actual_start_time
    - name: "Affidavit Generated"
      expr: affidavit_generated
    - name: "Automation Mode"
      expr: automation_mode
    - name: "Blackout Flag"
      expr: blackout_flag
    - name: "Broadcast Date"
      expr: broadcast_date
    - name: "Broadcast Standard"
      expr: broadcast_standard
    - name: "Content Rating"
      expr: content_rating
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Dai Eligible"
      expr: dai_eligible
    - name: "Dalet Asset Code"
      expr: dalet_asset_code
    - name: "Event Type"
      expr: event_type
    - name: "Failover Activated"
      expr: failover_activated
    - name: "Isan Code"
      expr: isan_code
    - name: "Isci Code"
      expr: isci_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Playout Event"
      expr: COUNT(DISTINCT playout_event_id)
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`scheduling_program_rundown`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Program Rundown business metrics"
  source: "`vibe_media_broadcasting_v1`.`scheduling`.`program_rundown`"
  dimensions:
    - name: "Ad Pod Count"
      expr: ad_pod_count
    - name: "Approved By"
      expr: approved_by
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Blackout Flag"
      expr: blackout_flag
    - name: "Broadcast Date"
      expr: broadcast_date
    - name: "Content Rating"
      expr: content_rating
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Dai Eligible"
      expr: dai_eligible
    - name: "Dalet Story Code"
      expr: dalet_story_code
    - name: "Emergency Alert Ready"
      expr: emergency_alert_ready
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Live Flag"
      expr: live_flag
    - name: "Mediafirst Rundown Code"
      expr: mediafirst_rundown_code
    - name: "Playout Failover Mode"
      expr: playout_failover_mode
    - name: "Production Format"
      expr: production_format
    - name: "Program Content Seconds"
      expr: program_content_seconds
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Program Rundown"
      expr: COUNT(DISTINCT program_rundown_id)
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`scheduling_program_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Program Schedule business metrics"
  source: "`vibe_media_broadcasting_v1`.`scheduling`.`program_schedule`"
  dimensions:
    - name: "Ad Pod Count"
      expr: ad_pod_count
    - name: "Approved By"
      expr: approved_by
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "As Run Confirmed Timestamp"
      expr: as_run_confirmed_timestamp
    - name: "Blackout Flag"
      expr: blackout_flag
    - name: "Broadcast Date"
      expr: broadcast_date
    - name: "Broadcast Standard"
      expr: broadcast_standard
    - name: "Content Rating Advisory"
      expr: content_rating_advisory
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Dalet Workflow Code"
      expr: dalet_workflow_code
    - name: "Daypart Code"
      expr: daypart_code
    - name: "Emergency Alert Ready"
      expr: emergency_alert_ready
    - name: "Epg Grid Code"
      expr: epg_grid_code
    - name: "Fcc Children Programming Compliant"
      expr: fcc_children_programming_compliant
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Mediafirst Rundown Code"
      expr: mediafirst_rundown_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Program Schedule"
      expr: COUNT(DISTINCT program_schedule_id)
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`scheduling_rundown_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rundown Item business metrics"
  source: "`vibe_media_broadcasting_v1`.`scheduling`.`rundown_item`"
  dimensions:
    - name: "Actual Duration Seconds"
      expr: actual_duration_seconds
    - name: "Actual End Time"
      expr: actual_end_time
    - name: "Actual Start Time"
      expr: actual_start_time
    - name: "Ad Pod Duration Seconds"
      expr: ad_pod_duration_seconds
    - name: "Ad Pod Flag"
      expr: ad_pod_flag
    - name: "Ad Pod Spot Count"
      expr: ad_pod_spot_count
    - name: "Backtime Flag"
      expr: backtime_flag
    - name: "Blackout Flag"
      expr: blackout_flag
    - name: "Content Rating"
      expr: content_rating
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Cue Text"
      expr: cue_text
    - name: "Dalet Asset Code"
      expr: dalet_asset_code
    - name: "Daypart Code"
      expr: daypart_code
    - name: "Duration Variance Seconds"
      expr: duration_variance_seconds
    - name: "Eom Timecode"
      expr: eom_timecode
    - name: "Epg Description"
      expr: epg_description
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Rundown Item"
      expr: COUNT(DISTINCT rundown_item_id)
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`scheduling_schedule_slot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Schedule Slot business metrics"
  source: "`vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot`"
  dimensions:
    - name: "Actual Duration Seconds"
      expr: actual_duration_seconds
    - name: "Actual Start Time"
      expr: actual_start_time
    - name: "Aspect Ratio"
      expr: aspect_ratio
    - name: "Audio Format"
      expr: audio_format
    - name: "Automation Event Code"
      expr: automation_event_code
    - name: "Broadcast Date"
      expr: broadcast_date
    - name: "Closed Caption Flag"
      expr: closed_caption_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Eas Alert Type"
      expr: eas_alert_type
    - name: "Is Blackout"
      expr: is_blackout
    - name: "Is Live"
      expr: is_live
    - name: "Is Repeat"
      expr: is_repeat
    - name: "Is Simulcast"
      expr: is_simulcast
    - name: "Isan Code"
      expr: isan_code
    - name: "Isci Code"
      expr: isci_code
    - name: "Must Carry Flag"
      expr: must_carry_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Schedule Slot"
      expr: COUNT(DISTINCT schedule_slot_id)
$$;
