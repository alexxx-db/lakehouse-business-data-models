-- Metric views for domain: scheduling | Business: Media_Broadcasting | Version: 3 | Generated on: 2026-07-10 19:06:42

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`scheduling_channel`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for broadcast channel portfolio management — carriage economics, ad load capacity, and digital readiness. Used by channel operations VPs and revenue leadership to evaluate channel health and monetization potential."
  source: "`vibe_media_broadcasting_v1`.`scheduling`.`channel`"
  dimensions:
    - name: "channel_type"
      expr: channel_type
      comment: "Type of channel (linear, OTT, simulcast, etc.) for portfolio segmentation."
    - name: "channel_status"
      expr: channel_status
      comment: "Operational status of the channel (active, decommissioned, pending) for filtering live inventory."
    - name: "genre"
      expr: genre
      comment: "Primary content genre of the channel for audience and advertiser targeting analysis."
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country where the channel originates, used for rights and regulatory segmentation."
    - name: "primary_language"
      expr: primary_language
      comment: "Primary broadcast language for demographic and market segmentation."
    - name: "dai_enabled"
      expr: dai_enabled
      comment: "Whether dynamic ad insertion is enabled on the channel — key for digital revenue capability analysis."
    - name: "drm_enabled"
      expr: drm_enabled
      comment: "Whether DRM protection is active, relevant for premium content distribution strategy."
    - name: "must_carry_status"
      expr: must_carry_status
      comment: "Regulatory must-carry designation affecting carriage negotiation leverage."
    - name: "launch_date"
      expr: DATE_TRUNC('year', launch_date)
      comment: "Year the channel launched, used for cohort analysis of channel maturity vs. revenue performance."
  measures:
    - name: "total_channels"
      expr: COUNT(1)
      comment: "Total number of channels in the portfolio. Baseline KPI for portfolio scale tracking."
    - name: "total_carriage_fee_usd"
      expr: SUM(CAST(carriage_fee_usd AS DOUBLE))
      comment: "Total carriage fees across all channels. Directly informs distribution cost management and negotiation strategy."
    - name: "avg_carriage_fee_usd"
      expr: AVG(CAST(carriage_fee_usd AS DOUBLE))
      comment: "Average carriage fee per channel. Benchmarks individual channel cost against portfolio average for renegotiation decisions."
    - name: "avg_max_ad_load_pct"
      expr: AVG(CAST(max_ad_load_pct AS DOUBLE))
      comment: "Average maximum ad load percentage across channels. Indicates monetization ceiling and informs yield optimization strategy."
    - name: "total_max_ad_load_pct"
      expr: SUM(CAST(max_ad_load_pct AS DOUBLE))
      comment: "Sum of max ad load percentages across channels — used to compute weighted ad inventory capacity across the portfolio."
    - name: "dai_enabled_channel_count"
      expr: COUNT(CASE WHEN dai_enabled = TRUE THEN 1 END)
      comment: "Number of channels with DAI enabled. Tracks digital monetization readiness across the portfolio."
    - name: "drm_enabled_channel_count"
      expr: COUNT(CASE WHEN drm_enabled = TRUE THEN 1 END)
      comment: "Number of channels with DRM active. Measures premium content protection coverage."
    - name: "must_carry_channel_count"
      expr: COUNT(CASE WHEN must_carry_status = TRUE THEN 1 END)
      comment: "Number of must-carry channels. Regulatory exposure metric used in distribution contract negotiations."
    - name: "active_channel_count"
      expr: COUNT(CASE WHEN channel_status = 'active' THEN 1 END)
      comment: "Count of currently active channels. Operational baseline for scheduling and traffic capacity planning."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`scheduling_ad_break`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ad break inventory and monetization KPIs for revenue operations and traffic management. Tracks avail fill rates, GRP delivery, CPM economics, and makegood exposure across scheduled ad breaks."
  source: "`vibe_media_broadcasting_v1`.`scheduling`.`ad_break`"
  dimensions:
    - name: "break_type"
      expr: break_type
      comment: "Type of ad break (commercial, promo, PSA) for inventory classification and revenue attribution."
    - name: "break_status"
      expr: break_status
      comment: "Current status of the ad break (sold, unsold, makegood, preempted) for fill rate analysis."
    - name: "break_position"
      expr: break_position
      comment: "Position of the break within the program (pre-roll, mid-roll, post-roll) for CPM premium analysis."
    - name: "dai_eligible"
      expr: dai_eligible
      comment: "Whether the break is eligible for dynamic ad insertion — key for digital vs. linear revenue segmentation."
    - name: "blackout_restricted"
      expr: blackout_restricted
      comment: "Whether the break is subject to blackout restrictions, affecting available inventory."
    - name: "makegood_required"
      expr: makegood_required
      comment: "Whether a makegood is required for this break — tracks underdelivery liability exposure."
    - name: "affidavit_generated"
      expr: affidavit_generated
      comment: "Whether proof-of-performance affidavit has been generated — compliance and billing readiness indicator."
    - name: "broadcast_date"
      expr: DATE_TRUNC('month', broadcast_date)
      comment: "Month of broadcast date for trend analysis of ad break performance over time."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the ad break transaction for multi-currency revenue reporting."
  measures:
    - name: "total_ad_breaks"
      expr: COUNT(1)
      comment: "Total number of ad breaks scheduled. Baseline inventory volume metric for traffic operations."
    - name: "total_grp_target"
      expr: SUM(CAST(grp_target AS DOUBLE))
      comment: "Total GRP target committed across all ad breaks. Measures audience delivery obligation for upfront and scatter commitments."
    - name: "avg_grp_target"
      expr: AVG(CAST(grp_target AS DOUBLE))
      comment: "Average GRP target per ad break. Benchmarks audience delivery expectations per break for pricing and planning."
    - name: "total_nielsen_program_rating"
      expr: SUM(CAST(nielsen_program_rating AS DOUBLE))
      comment: "Sum of Nielsen program ratings across breaks — proxy for total audience exposure delivered."
    - name: "avg_nielsen_program_rating"
      expr: AVG(CAST(nielsen_program_rating AS DOUBLE))
      comment: "Average Nielsen program rating per ad break. Key pricing input — higher-rated breaks command premium CPMs."
    - name: "total_rate_card_cpm"
      expr: SUM(CAST(rate_card_cpm AS DOUBLE))
      comment: "Sum of rate card CPMs across breaks — used to compute total rate card revenue potential of the inventory."
    - name: "avg_rate_card_cpm"
      expr: AVG(CAST(rate_card_cpm AS DOUBLE))
      comment: "Average rate card CPM across ad breaks. Tracks pricing level trends and informs yield management decisions."
    - name: "makegood_required_count"
      expr: COUNT(CASE WHEN makegood_required = TRUE THEN 1 END)
      comment: "Number of breaks requiring makegoods. Quantifies underdelivery liability and operational remediation workload."
    - name: "dai_eligible_break_count"
      expr: COUNT(CASE WHEN dai_eligible = TRUE THEN 1 END)
      comment: "Number of DAI-eligible ad breaks. Measures addressable advertising inventory available for programmatic monetization."
    - name: "affidavit_generated_count"
      expr: COUNT(CASE WHEN affidavit_generated = TRUE THEN 1 END)
      comment: "Number of breaks with affidavits generated. Tracks proof-of-performance compliance rate for billing and advertiser reporting."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`scheduling_schedule_slot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Program schedule slot utilization and content delivery KPIs. Used by scheduling directors and operations teams to track slot fill, simulcast coverage, blackout exposure, and rights clearance status across the broadcast grid."
  source: "`vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot`"
  dimensions:
    - name: "slot_type"
      expr: slot_type
      comment: "Type of schedule slot (program, ad, promo, filler) for inventory classification."
    - name: "slot_status"
      expr: slot_status
      comment: "Current status of the slot (scheduled, aired, preempted, cancelled) for delivery tracking."
    - name: "is_live"
      expr: is_live
      comment: "Whether the slot carries live content — live slots have different rights, ad, and operational profiles."
    - name: "is_simulcast"
      expr: is_simulcast
      comment: "Whether the slot is simulcast across platforms — key for multi-platform reach and rights compliance."
    - name: "is_blackout"
      expr: is_blackout
      comment: "Whether the slot is subject to a blackout restriction — affects available audience and advertiser delivery."
    - name: "is_repeat"
      expr: is_repeat
      comment: "Whether the slot is a repeat airing — informs content freshness and audience tune-in expectations."
    - name: "closed_caption_flag"
      expr: closed_caption_flag
      comment: "Whether closed captioning is active — regulatory compliance indicator for FCC requirements."
    - name: "must_carry_flag"
      expr: must_carry_flag
      comment: "Whether the slot is subject to must-carry rules — regulatory exposure metric."
    - name: "broadcast_date"
      expr: DATE_TRUNC('month', broadcast_date)
      comment: "Month of broadcast for trend analysis of schedule utilization over time."
    - name: "aspect_ratio"
      expr: aspect_ratio
      comment: "Video aspect ratio of the slot — used for technical quality and format compliance reporting."
  measures:
    - name: "total_schedule_slots"
      expr: COUNT(1)
      comment: "Total number of schedule slots. Baseline measure of broadcast grid capacity utilization."
    - name: "live_slot_count"
      expr: COUNT(CASE WHEN is_live = TRUE THEN 1 END)
      comment: "Number of live content slots. Live programming drives premium ad rates and audience engagement."
    - name: "simulcast_slot_count"
      expr: COUNT(CASE WHEN is_simulcast = TRUE THEN 1 END)
      comment: "Number of simulcast slots. Measures multi-platform distribution reach and associated rights obligations."
    - name: "blackout_slot_count"
      expr: COUNT(CASE WHEN is_blackout = TRUE THEN 1 END)
      comment: "Number of blacked-out slots. Quantifies audience delivery loss due to rights restrictions."
    - name: "closed_caption_compliance_count"
      expr: COUNT(CASE WHEN closed_caption_flag = TRUE THEN 1 END)
      comment: "Number of slots with closed captioning active. FCC compliance coverage metric."
    - name: "must_carry_slot_count"
      expr: COUNT(CASE WHEN must_carry_flag = TRUE THEN 1 END)
      comment: "Number of must-carry slots. Regulatory obligation exposure for distribution compliance reporting."
    - name: "repeat_slot_count"
      expr: COUNT(CASE WHEN is_repeat = TRUE THEN 1 END)
      comment: "Number of repeat airings. High repeat rates signal content library depth vs. original programming investment gaps."
    - name: "distinct_titles_scheduled"
      expr: COUNT(DISTINCT title_id)
      comment: "Number of distinct content titles scheduled. Measures content diversity and library utilization breadth."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`scheduling_program_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Program schedule operational KPIs for broadcast operations and compliance leadership. Tracks schedule approval rates, rights clearance status, simulcast coverage, FCC compliance, and ad time allocation across broadcast dates."
  source: "`vibe_media_broadcasting_v1`.`scheduling`.`program_schedule`"
  dimensions:
    - name: "schedule_status"
      expr: schedule_status
      comment: "Current status of the program schedule (draft, approved, transmitted, archived) for workflow tracking."
    - name: "schedule_type"
      expr: schedule_type
      comment: "Type of schedule (live, pre-recorded, simulcast, emergency) for operational classification."
    - name: "rights_clearance_status"
      expr: rights_clearance_status
      comment: "Rights clearance status of the schedule — uncleared schedules represent legal and broadcast risk."
    - name: "simulcast_flag"
      expr: simulcast_flag
      comment: "Whether the schedule includes simulcast content — drives multi-platform distribution planning."
    - name: "blackout_flag"
      expr: blackout_flag
      comment: "Whether any blackout restrictions apply to this schedule — affects audience delivery and advertiser commitments."
    - name: "fcc_children_programming_compliant"
      expr: fcc_children_programming_compliant
      comment: "FCC children's programming compliance flag — regulatory reporting requirement for broadcast licensees."
    - name: "must_carry_compliant"
      expr: must_carry_compliant
      comment: "Must-carry compliance status — regulatory obligation for cable and satellite distribution."
    - name: "broadcast_date"
      expr: DATE_TRUNC('month', broadcast_date)
      comment: "Month of broadcast for trend analysis of schedule performance and compliance over time."
    - name: "transmission_type"
      expr: transmission_type
      comment: "Transmission type (terrestrial, satellite, IP) for infrastructure cost and capacity analysis."
  measures:
    - name: "total_schedules"
      expr: COUNT(1)
      comment: "Total number of program schedules. Baseline operational volume metric for scheduling throughput."
    - name: "approved_schedule_count"
      expr: COUNT(CASE WHEN schedule_status = 'approved' THEN 1 END)
      comment: "Number of approved schedules. Tracks scheduling workflow efficiency and readiness for transmission."
    - name: "rights_cleared_schedule_count"
      expr: COUNT(CASE WHEN rights_clearance_status = 'cleared' THEN 1 END)
      comment: "Number of schedules with full rights clearance. Uncleared schedules represent legal broadcast risk."
    - name: "fcc_compliant_schedule_count"
      expr: COUNT(CASE WHEN fcc_children_programming_compliant = TRUE THEN 1 END)
      comment: "Number of FCC children's programming compliant schedules. Regulatory compliance KPI for broadcast license maintenance."
    - name: "simulcast_schedule_count"
      expr: COUNT(CASE WHEN simulcast_flag = TRUE THEN 1 END)
      comment: "Number of simulcast schedules. Measures multi-platform distribution reach and associated rights obligations."
    - name: "blackout_affected_schedule_count"
      expr: COUNT(CASE WHEN blackout_flag = TRUE THEN 1 END)
      comment: "Number of schedules affected by blackout restrictions. Quantifies audience delivery risk from rights constraints."
    - name: "total_ad_time_seconds"
      expr: SUM(CAST(total_ad_time_seconds AS DOUBLE))
      comment: "Total ad time in seconds across all schedules. Measures monetizable inventory volume for revenue planning."
    - name: "avg_ad_time_seconds"
      expr: AVG(CAST(total_ad_time_seconds AS DOUBLE))
      comment: "Average ad time per schedule in seconds. Benchmarks ad load against regulatory limits and industry norms."
    - name: "total_program_time_seconds"
      expr: SUM(CAST(total_program_time_seconds AS DOUBLE))
      comment: "Total program content time in seconds. Measures content delivery volume for rights utilization reporting."
    - name: "total_runtime_seconds"
      expr: SUM(CAST(total_runtime_seconds AS DOUBLE))
      comment: "Total runtime in seconds across all schedules. Used to compute ad-to-content ratio for yield analysis."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`scheduling_playout_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Playout execution KPIs for broadcast operations and engineering leadership. Tracks on-air delivery accuracy, failover incidents, DAI eligibility, rights clearance, and simulcast performance across all playout events."
  source: "`vibe_media_broadcasting_v1`.`scheduling`.`playout_event`"
  dimensions:
    - name: "playout_status"
      expr: playout_status
      comment: "Execution status of the playout event (aired, failed, preempted, substituted) for delivery quality tracking."
    - name: "event_type"
      expr: event_type
      comment: "Type of playout event (program, commercial, promo, filler) for content mix analysis."
    - name: "rights_clearance_status"
      expr: rights_clearance_status
      comment: "Rights clearance status at time of playout — uncleared events represent compliance risk."
    - name: "dai_eligible"
      expr: dai_eligible
      comment: "Whether the event was eligible for dynamic ad insertion — digital monetization coverage metric."
    - name: "failover_activated"
      expr: failover_activated
      comment: "Whether failover was activated during this event — key reliability and engineering SLA metric."
    - name: "simulcast_flag"
      expr: simulcast_flag
      comment: "Whether the event was simulcast across platforms — multi-platform reach indicator."
    - name: "blackout_flag"
      expr: blackout_flag
      comment: "Whether a blackout was enforced during this event — audience delivery impact indicator."
    - name: "affidavit_generated"
      expr: affidavit_generated
      comment: "Whether proof-of-performance affidavit was generated — billing and advertiser compliance readiness."
    - name: "broadcast_date"
      expr: DATE_TRUNC('month', broadcast_date)
      comment: "Month of broadcast for trend analysis of playout performance and reliability over time."
    - name: "automation_mode"
      expr: automation_mode
      comment: "Automation mode used during playout (fully automated, assisted, manual) for operational efficiency analysis."
  measures:
    - name: "total_playout_events"
      expr: COUNT(1)
      comment: "Total number of playout events. Baseline operational throughput metric for broadcast operations."
    - name: "failover_event_count"
      expr: COUNT(CASE WHEN failover_activated = TRUE THEN 1 END)
      comment: "Number of events where failover was activated. Critical reliability KPI — high failover rates indicate infrastructure or content delivery issues."
    - name: "blackout_event_count"
      expr: COUNT(CASE WHEN blackout_flag = TRUE THEN 1 END)
      comment: "Number of blacked-out playout events. Quantifies audience delivery loss from rights restrictions."
    - name: "dai_eligible_event_count"
      expr: COUNT(CASE WHEN dai_eligible = TRUE THEN 1 END)
      comment: "Number of DAI-eligible playout events. Measures addressable advertising opportunity volume."
    - name: "affidavit_generated_count"
      expr: COUNT(CASE WHEN affidavit_generated = TRUE THEN 1 END)
      comment: "Number of events with affidavits generated. Proof-of-performance compliance rate for advertiser billing."
    - name: "simulcast_event_count"
      expr: COUNT(CASE WHEN simulcast_flag = TRUE THEN 1 END)
      comment: "Number of simulcast playout events. Tracks multi-platform distribution execution volume."
    - name: "rights_cleared_event_count"
      expr: COUNT(CASE WHEN rights_clearance_status = 'cleared' THEN 1 END)
      comment: "Number of playout events with confirmed rights clearance. Compliance coverage metric for broadcast licensing."
    - name: "total_scheduled_duration_seconds"
      expr: SUM(CAST(scheduled_duration_seconds AS DOUBLE))
      comment: "Total scheduled duration in seconds across all playout events. Measures planned broadcast output volume."
    - name: "avg_start_deviation_seconds"
      expr: AVG(CAST(start_deviation_seconds AS DOUBLE))
      comment: "Average deviation between scheduled and actual start time in seconds. Key on-air accuracy KPI — large deviations indicate scheduling or automation issues."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`scheduling_daypart`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Daypart inventory economics and audience KPIs for sales planning and yield management. Tracks CPM pricing, GRP indices, audience levels, and ad pod capacity across daypart segments to inform upfront and scatter sales strategy."
  source: "`vibe_media_broadcasting_v1`.`scheduling`.`daypart`"
  dimensions:
    - name: "daypart_type"
      expr: daypart_type
      comment: "Type of daypart (primetime, daytime, late night, news, sports) for audience and pricing segmentation."
    - name: "daypart_status"
      expr: daypart_status
      comment: "Operational status of the daypart (active, inactive, seasonal) for inventory availability filtering."
    - name: "day_category"
      expr: day_category
      comment: "Day category (weekday, weekend, holiday) for audience pattern and pricing analysis."
    - name: "upfront_eligible"
      expr: upfront_eligible
      comment: "Whether the daypart is eligible for upfront sales — key for annual revenue planning segmentation."
    - name: "scatter_eligible"
      expr: scatter_eligible
      comment: "Whether the daypart is eligible for scatter market sales — short-term revenue opportunity indicator."
    - name: "makegood_eligible"
      expr: makegood_eligible
      comment: "Whether makegoods can be placed in this daypart — affects underdelivery remediation options."
    - name: "dai_eligible"
      expr: dai_eligible
      comment: "Whether the daypart supports dynamic ad insertion — digital monetization capability indicator."
    - name: "coppa_restricted"
      expr: coppa_restricted
      comment: "Whether the daypart is COPPA-restricted (children's programming) — limits advertiser categories and targeting."
    - name: "sweeps_period_flag"
      expr: sweeps_period_flag
      comment: "Whether the daypart falls within a Nielsen sweeps period — premium pricing and programming strategy indicator."
    - name: "target_demographic"
      expr: target_demographic
      comment: "Primary target demographic for the daypart — used for advertiser matching and CPM premium analysis."
  measures:
    - name: "total_dayparts"
      expr: COUNT(1)
      comment: "Total number of daypart definitions. Baseline inventory segmentation metric."
    - name: "total_avg_audience_000"
      expr: SUM(CAST(avg_audience_000 AS DOUBLE))
      comment: "Sum of average audience (in thousands) across dayparts. Aggregate audience delivery capacity for portfolio-level planning."
    - name: "avg_audience_000_per_daypart"
      expr: AVG(CAST(avg_audience_000 AS DOUBLE))
      comment: "Average audience (in thousands) per daypart. Benchmarks audience delivery by daypart type for pricing and sales planning."
    - name: "total_base_cpm_usd"
      expr: SUM(CAST(base_cpm_usd AS DOUBLE))
      comment: "Sum of base CPM rates across dayparts. Measures total rate card value of the daypart inventory portfolio."
    - name: "avg_base_cpm_usd"
      expr: AVG(CAST(base_cpm_usd AS DOUBLE))
      comment: "Average base CPM across dayparts. Key pricing benchmark for yield management and competitive rate analysis."
    - name: "avg_grp_index"
      expr: AVG(CAST(grp_index AS DOUBLE))
      comment: "Average GRP index across dayparts. Measures relative audience delivery strength — above 100 indicates above-average delivery."
    - name: "avg_hut_level"
      expr: AVG(CAST(hut_level AS DOUBLE))
      comment: "Average Households Using Television (HUT) level across dayparts. Measures total TV viewing universe available for audience delivery."
    - name: "avg_rate_multiplier"
      expr: AVG(CAST(rate_multiplier AS DOUBLE))
      comment: "Average rate multiplier across dayparts. Tracks premium pricing factors applied above base CPM for high-demand dayparts."
    - name: "upfront_eligible_daypart_count"
      expr: COUNT(CASE WHEN upfront_eligible = TRUE THEN 1 END)
      comment: "Number of upfront-eligible dayparts. Defines the scope of annual upfront sales inventory available to advertisers."
    - name: "scatter_eligible_daypart_count"
      expr: COUNT(CASE WHEN scatter_eligible = TRUE THEN 1 END)
      comment: "Number of scatter-eligible dayparts. Measures short-term market inventory capacity for opportunistic revenue."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`scheduling_channel_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Campaign channel allocation performance KPIs for sales and traffic operations. Tracks budget utilization, GRP delivery vs. target, and spot execution across channel-campaign allocations to identify underdelivery and reallocation opportunities."
  source: "`vibe_media_broadcasting_v1`.`scheduling`.`channel_allocation`"
  dimensions:
    - name: "delivery_status"
      expr: delivery_status
      comment: "Delivery status of the channel allocation (on-track, underdelivering, overdelivering, completed) for campaign health monitoring."
    - name: "flight_start_date"
      expr: DATE_TRUNC('month', flight_start_date)
      comment: "Month the campaign flight started — used for cohort analysis of allocation performance by flight period."
    - name: "flight_end_date"
      expr: DATE_TRUNC('month', flight_end_date)
      comment: "Month the campaign flight ends — used for forward-looking delivery risk analysis."
  measures:
    - name: "total_allocations"
      expr: COUNT(1)
      comment: "Total number of channel-campaign allocations. Baseline measure of campaign distribution breadth."
    - name: "total_allocated_budget_amount"
      expr: SUM(CAST(allocated_budget_amount AS DOUBLE))
      comment: "Total budget allocated across all channel-campaign combinations. Core revenue commitment metric for sales operations."
    - name: "avg_allocated_budget_amount"
      expr: AVG(CAST(allocated_budget_amount AS DOUBLE))
      comment: "Average budget per channel allocation. Benchmarks investment concentration across channels."
    - name: "total_target_grp"
      expr: SUM(CAST(target_grp AS DOUBLE))
      comment: "Total GRP target committed across all allocations. Measures total audience delivery obligation."
    - name: "total_actual_grp_delivered"
      expr: SUM(CAST(actual_grp_delivered AS DOUBLE))
      comment: "Total GRP actually delivered across all allocations. Measures actual audience delivery performance against commitments."
    - name: "avg_target_grp"
      expr: AVG(CAST(target_grp AS DOUBLE))
      comment: "Average GRP target per allocation. Used to benchmark individual allocation ambition against portfolio norms."
    - name: "avg_actual_grp_delivered"
      expr: AVG(CAST(actual_grp_delivered AS DOUBLE))
      comment: "Average GRP delivered per allocation. Tracks execution quality against audience delivery commitments."
    - name: "distinct_campaigns_allocated"
      expr: COUNT(DISTINCT campaign_id)
      comment: "Number of distinct campaigns with channel allocations. Measures active campaign portfolio breadth across channels."
    - name: "distinct_channels_utilized"
      expr: COUNT(DISTINCT channel_id)
      comment: "Number of distinct channels receiving campaign allocations. Measures channel inventory utilization breadth."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`scheduling_blackout_rule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Blackout rule compliance and rights enforcement KPIs for rights management and legal teams. Tracks blackout rule coverage, enforcement scope, simulcast restrictions, and must-carry exemptions to manage rights compliance risk."
  source: "`vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule`"
  dimensions:
    - name: "rule_type"
      expr: rule_type
      comment: "Type of blackout rule (sports, syndication, retransmission, regulatory) for rights category analysis."
    - name: "rule_status"
      expr: rule_status
      comment: "Current status of the blackout rule (active, expired, pending) for enforcement coverage tracking."
    - name: "enforcement_scope"
      expr: enforcement_scope
      comment: "Geographic or platform scope of enforcement — national, regional, or platform-specific blackout coverage."
    - name: "holdback_type"
      expr: holdback_type
      comment: "Type of content holdback (exclusive window, territorial, platform) for rights strategy analysis."
    - name: "simulcast_blackout_flag"
      expr: simulcast_blackout_flag
      comment: "Whether the blackout applies to simulcast streams — affects multi-platform distribution compliance."
    - name: "must_carry_exempt_flag"
      expr: must_carry_exempt_flag
      comment: "Whether the rule includes a must-carry exemption — regulatory compliance indicator."
    - name: "retransmission_consent_flag"
      expr: retransmission_consent_flag
      comment: "Whether retransmission consent is required — key distribution negotiation and compliance metric."
    - name: "restricted_territory_type"
      expr: restricted_territory_type
      comment: "Type of restricted territory (DMA, national, international) for geographic rights enforcement analysis."
  measures:
    - name: "total_blackout_rules"
      expr: COUNT(1)
      comment: "Total number of blackout rules in force. Baseline measure of rights restriction complexity and compliance workload."
    - name: "active_blackout_rule_count"
      expr: COUNT(CASE WHEN rule_status = 'active' THEN 1 END)
      comment: "Number of currently active blackout rules. Measures live rights enforcement obligations affecting broadcast operations."
    - name: "simulcast_blackout_rule_count"
      expr: COUNT(CASE WHEN simulcast_blackout_flag = TRUE THEN 1 END)
      comment: "Number of rules with simulcast blackout restrictions. Quantifies multi-platform distribution constraints from rights agreements."
    - name: "retransmission_consent_rule_count"
      expr: COUNT(CASE WHEN retransmission_consent_flag = TRUE THEN 1 END)
      comment: "Number of rules requiring retransmission consent. Tracks regulatory compliance obligations in distribution agreements."
    - name: "must_carry_exempt_rule_count"
      expr: COUNT(CASE WHEN must_carry_exempt_flag = TRUE THEN 1 END)
      comment: "Number of rules with must-carry exemptions. Measures regulatory carve-outs that affect distribution obligations."
    - name: "distinct_titles_under_blackout"
      expr: COUNT(DISTINCT primary_scheduling_title_id)
      comment: "Number of distinct content titles subject to blackout rules. Measures breadth of rights-restricted content in the schedule."
    - name: "distinct_channels_with_blackout"
      expr: COUNT(DISTINCT channel_id)
      comment: "Number of distinct channels with active blackout rules. Identifies channels with highest rights compliance complexity."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`scheduling_simulcast_config`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Simulcast configuration KPIs for distribution engineering and operations leadership. Tracks simulcast deployment coverage, DAI enablement, DRM protection, failover readiness, and must-carry compliance across simulcast configurations."
  source: "`vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config`"
  dimensions:
    - name: "simulcast_config_status"
      expr: simulcast_config_status
      comment: "Operational status of the simulcast configuration (active, inactive, testing) for deployment coverage analysis."
    - name: "simulcast_type"
      expr: simulcast_type
      comment: "Type of simulcast (live, time-shifted, catch-up) for distribution strategy segmentation."
    - name: "distribution_platform"
      expr: distribution_platform
      comment: "Target distribution platform (cable, satellite, OTT, IPTV) for platform-specific performance analysis."
    - name: "dai_enabled"
      expr: dai_enabled
      comment: "Whether DAI is enabled on this simulcast config — digital monetization readiness indicator."
    - name: "drm_scheme"
      expr: drm_scheme
      comment: "DRM scheme applied (Widevine, PlayReady, FairPlay) for content protection coverage analysis."
    - name: "failover_mode"
      expr: failover_mode
      comment: "Failover mode configured (automatic, manual, none) — engineering resilience and SLA compliance indicator."
    - name: "must_carry_compliant"
      expr: must_carry_compliant
      comment: "Whether the simulcast config meets must-carry regulatory requirements."
    - name: "blackout_enforced"
      expr: blackout_enforced
      comment: "Whether blackout enforcement is active on this config — rights compliance coverage indicator."
    - name: "effective_from"
      expr: DATE_TRUNC('year', effective_from)
      comment: "Year the simulcast configuration became effective — used for deployment vintage analysis."
  measures:
    - name: "total_simulcast_configs"
      expr: COUNT(1)
      comment: "Total number of simulcast configurations. Baseline measure of multi-platform distribution deployment scale."
    - name: "active_simulcast_config_count"
      expr: COUNT(CASE WHEN simulcast_config_status = 'active' THEN 1 END)
      comment: "Number of active simulcast configurations. Measures live multi-platform distribution footprint."
    - name: "dai_enabled_config_count"
      expr: COUNT(CASE WHEN dai_enabled = TRUE THEN 1 END)
      comment: "Number of simulcast configs with DAI enabled. Measures addressable advertising reach across simulcast streams."
    - name: "blackout_enforced_config_count"
      expr: COUNT(CASE WHEN blackout_enforced = TRUE THEN 1 END)
      comment: "Number of configs with blackout enforcement active. Measures rights compliance coverage across simulcast deployments."
    - name: "must_carry_compliant_config_count"
      expr: COUNT(CASE WHEN must_carry_compliant = TRUE THEN 1 END)
      comment: "Number of must-carry compliant simulcast configs. Regulatory compliance coverage metric for distribution licensing."
    - name: "failover_configured_count"
      expr: COUNT(CASE WHEN failover_mode IS NOT NULL AND failover_mode != 'none' THEN 1 END)
      comment: "Number of simulcast configs with failover configured. Engineering resilience metric — configs without failover represent single points of failure."
    - name: "distinct_source_channels"
      expr: COUNT(DISTINCT source_channel_id)
      comment: "Number of distinct source channels with simulcast configurations. Measures simulcast origination breadth across the channel portfolio."
    - name: "distinct_target_channels"
      expr: COUNT(DISTINCT target_channel_id)
      comment: "Number of distinct target channels receiving simulcast feeds. Measures simulcast distribution reach."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`scheduling_channel_carriage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Channel carriage economics and platform distribution KPIs for distribution strategy and finance leadership. Tracks carriage fees, platform coverage, simulcast enablement, and DAI deployment across OTT platform carriage agreements."
  source: "`vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage`"
  dimensions:
    - name: "carriage_status"
      expr: carriage_status
      comment: "Current status of the carriage agreement (active, expired, negotiating, terminated) for distribution coverage analysis."
    - name: "simulcast_enabled"
      expr: simulcast_enabled
      comment: "Whether simulcast is enabled under this carriage agreement — multi-platform reach indicator."
    - name: "dai_enabled_flag"
      expr: dai_enabled_flag
      comment: "Whether DAI is enabled under this carriage agreement — digital monetization capability per platform."
    - name: "epg_sync_enabled"
      expr: epg_sync_enabled
      comment: "Whether EPG synchronization is enabled — affects viewer discovery and ad scheduling accuracy on the platform."
    - name: "contract_start_date"
      expr: DATE_TRUNC('year', contract_start_date)
      comment: "Year the carriage contract started — used for contract vintage and renewal cycle analysis."
    - name: "contract_end_date"
      expr: DATE_TRUNC('year', contract_end_date)
      comment: "Year the carriage contract expires — used for renewal pipeline and revenue continuity planning."
  measures:
    - name: "total_carriage_agreements"
      expr: COUNT(1)
      comment: "Total number of channel carriage agreements. Baseline measure of distribution platform footprint."
    - name: "total_carriage_fee_usd"
      expr: SUM(CAST(carriage_fee_usd AS DOUBLE))
      comment: "Total carriage fees across all platform agreements. Core distribution cost metric for finance and strategy leadership."
    - name: "avg_carriage_fee_usd"
      expr: AVG(CAST(carriage_fee_usd AS DOUBLE))
      comment: "Average carriage fee per platform agreement. Benchmarks individual platform cost for renegotiation strategy."
    - name: "active_carriage_count"
      expr: COUNT(CASE WHEN carriage_status = 'active' THEN 1 END)
      comment: "Number of active carriage agreements. Measures live distribution platform coverage."
    - name: "simulcast_enabled_count"
      expr: COUNT(CASE WHEN simulcast_enabled = TRUE THEN 1 END)
      comment: "Number of carriage agreements with simulcast enabled. Measures multi-platform simulcast distribution reach."
    - name: "dai_enabled_carriage_count"
      expr: COUNT(CASE WHEN dai_enabled_flag = TRUE THEN 1 END)
      comment: "Number of carriage agreements with DAI enabled. Measures addressable advertising monetization coverage across platforms."
    - name: "distinct_platforms_carried"
      expr: COUNT(DISTINCT ott_platform_id)
      comment: "Number of distinct OTT platforms carrying the channel. Measures distribution reach breadth for audience and revenue strategy."
    - name: "distinct_channels_carried"
      expr: COUNT(DISTINCT channel_id)
      comment: "Number of distinct channels with carriage agreements. Measures portfolio distribution coverage."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`scheduling_epg_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Electronic Program Guide (EPG) content coverage and quality KPIs for programming and distribution operations. Tracks live content volume, simulcast coverage, closed captioning compliance, HDR availability, and blackout exposure across EPG entries."
  source: "`vibe_media_broadcasting_v1`.`scheduling`.`epg_entry`"
  dimensions:
    - name: "entry_status"
      expr: entry_status
      comment: "Status of the EPG entry (published, draft, expired, cancelled) for guide completeness analysis."
    - name: "is_live"
      expr: is_live
      comment: "Whether the EPG entry is for live content — live programming drives premium audience and advertiser interest."
    - name: "is_new_episode"
      expr: is_new_episode
      comment: "Whether the entry is a new episode — new content drives higher tune-in and ad premium."
    - name: "is_simulcast"
      expr: is_simulcast
      comment: "Whether the entry is simulcast across platforms — multi-platform reach indicator."
    - name: "is_blackout"
      expr: is_blackout
      comment: "Whether the entry is subject to blackout — affects audience delivery and advertiser commitments."
    - name: "is_hdr"
      expr: is_hdr
      comment: "Whether the content is available in HDR — premium technical quality indicator for subscriber value."
    - name: "is_closed_caption"
      expr: is_closed_caption
      comment: "Whether closed captioning is available — FCC compliance and accessibility metric."
    - name: "genre_primary"
      expr: genre_primary
      comment: "Primary content genre for audience segmentation and programming strategy analysis."
    - name: "broadcast_date"
      expr: DATE_TRUNC('month', broadcast_date)
      comment: "Month of broadcast for trend analysis of EPG content mix and quality over time."
    - name: "language_code"
      expr: language_code
      comment: "Language of the content for multilingual programming coverage analysis."
  measures:
    - name: "total_epg_entries"
      expr: COUNT(1)
      comment: "Total number of EPG entries. Baseline measure of program guide completeness and content volume."
    - name: "live_entry_count"
      expr: COUNT(CASE WHEN is_live = TRUE THEN 1 END)
      comment: "Number of live content EPG entries. Live programming is a key driver of audience ratings and ad premium."
    - name: "new_episode_count"
      expr: COUNT(CASE WHEN is_new_episode = TRUE THEN 1 END)
      comment: "Number of new episode entries. Measures original content freshness — a key subscriber retention and tune-in driver."
    - name: "simulcast_entry_count"
      expr: COUNT(CASE WHEN is_simulcast = TRUE THEN 1 END)
      comment: "Number of simulcast EPG entries. Measures multi-platform content distribution reach."
    - name: "blackout_entry_count"
      expr: COUNT(CASE WHEN is_blackout = TRUE THEN 1 END)
      comment: "Number of blacked-out EPG entries. Quantifies audience delivery loss from rights restrictions."
    - name: "hdr_entry_count"
      expr: COUNT(CASE WHEN is_hdr = TRUE THEN 1 END)
      comment: "Number of HDR content entries. Measures premium technical quality coverage for subscriber value proposition."
    - name: "closed_caption_entry_count"
      expr: COUNT(CASE WHEN is_closed_caption = TRUE THEN 1 END)
      comment: "Number of entries with closed captioning. FCC accessibility compliance coverage metric."
    - name: "distinct_series_in_epg"
      expr: COUNT(DISTINCT series_name)
      comment: "Number of distinct series represented in the EPG. Measures content library breadth and programming diversity."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`scheduling_channel_targeting`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Channel audience targeting effectiveness KPIs for sales planning and audience strategy. Tracks GRP guarantees, rate multipliers, and targeting coverage across demographic segments to optimize channel-advertiser matching and pricing."
  source: "`vibe_media_broadcasting_v1`.`scheduling`.`channel_targeting`"
  dimensions:
    - name: "targeting_status"
      expr: targeting_status
      comment: "Status of the targeting configuration (active, expired, pending) for current targeting coverage analysis."
    - name: "is_primary_target"
      expr: is_primary_target
      comment: "Whether this is the primary target demographic for the channel — primary targets command highest CPM premiums."
    - name: "daypart_strategy"
      expr: daypart_strategy
      comment: "Daypart strategy applied for this targeting configuration — used to analyze targeting approach by time period."
    - name: "effective_from"
      expr: DATE_TRUNC('year', effective_from)
      comment: "Year the targeting configuration became effective — used for strategy evolution analysis."
  measures:
    - name: "total_targeting_configs"
      expr: COUNT(1)
      comment: "Total number of channel targeting configurations. Baseline measure of audience targeting strategy breadth."
    - name: "total_guaranteed_grp"
      expr: SUM(CAST(guaranteed_grp AS DOUBLE))
      comment: "Total GRP guaranteed across all channel targeting configurations. Measures total audience delivery commitment to advertisers."
    - name: "avg_guaranteed_grp"
      expr: AVG(CAST(guaranteed_grp AS DOUBLE))
      comment: "Average GRP guarantee per targeting configuration. Benchmarks audience delivery commitments by demographic and channel."
    - name: "avg_target_rating"
      expr: AVG(CAST(target_rating AS DOUBLE))
      comment: "Average target rating across configurations. Measures expected audience delivery level for pricing and planning."
    - name: "avg_rate_multiplier"
      expr: AVG(CAST(rate_multiplier AS DOUBLE))
      comment: "Average rate multiplier applied for targeted demographics. Measures pricing premium achieved through audience targeting."
    - name: "primary_target_count"
      expr: COUNT(CASE WHEN is_primary_target = TRUE THEN 1 END)
      comment: "Number of primary targeting configurations. Identifies channels with clearly defined core audience strategies."
    - name: "distinct_channels_targeted"
      expr: COUNT(DISTINCT channel_id)
      comment: "Number of distinct channels with audience targeting configurations. Measures targeting strategy deployment breadth."
    - name: "distinct_demographic_segments"
      expr: COUNT(DISTINCT demographic_segment_id)
      comment: "Number of distinct demographic segments targeted across channels. Measures audience strategy diversity and advertiser appeal breadth."
$$;