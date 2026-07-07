-- Metric views for domain: scheduling | Business: Media_Broadcasting | Version: 2 | Generated on: 2026-06-30 04:55:25

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`scheduling_ad_break`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ad break inventory and monetization KPIs: sellout, fill, makegood exposure, and CPM/GRP yield to steer ad-revenue optimization."
  source: "`vibe_media_broadcasting_v1`.`scheduling`.`ad_break`"
  dimensions:
    - name: "broadcast_date"
      expr: broadcast_date
      comment: "Date the ad break aired; primary time axis for inventory analysis."
    - name: "break_type"
      expr: break_type
      comment: "Type of ad break (e.g. local, national, promo)."
    - name: "break_status"
      expr: break_status
      comment: "Lifecycle status of the ad break (planned, aired, preempted)."
    - name: "break_position"
      expr: break_position
      comment: "Position of the break within the program (pre/mid/post-roll)."
    - name: "dai_eligible"
      expr: dai_eligible
      comment: "Whether the break is eligible for dynamic ad insertion."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of monetary rate values."
  measures:
    - name: "Ad Break Count"
      expr: COUNT(1)
      comment: "Total number of ad breaks; baseline inventory volume."
    - name: "Avg Rate Card CPM"
      expr: AVG(CAST(rate_card_cpm AS DOUBLE))
      comment: "Average rate-card CPM across breaks; pricing benchmark for yield management."
    - name: "Avg GRP Target"
      expr: AVG(CAST(grp_target AS DOUBLE))
      comment: "Average gross rating point target per break; delivery planning KPI."
    - name: "Total GRP Target"
      expr: SUM(CAST(grp_target AS DOUBLE))
      comment: "Aggregate GRP target across breaks for campaign delivery tracking."
    - name: "Avg Nielsen Program Rating"
      expr: AVG(CAST(nielsen_program_rating AS DOUBLE))
      comment: "Average Nielsen program rating around breaks; audience-value indicator."
    - name: "Makegood Required Count"
      expr: SUM(CASE WHEN makegood_required = TRUE THEN 1 ELSE 0 END)
      comment: "Breaks flagged requiring makegoods; revenue-leakage and liability signal."
    - name: "DAI Eligible Count"
      expr: SUM(CASE WHEN dai_eligible = TRUE THEN 1 ELSE 0 END)
      comment: "Breaks eligible for dynamic ad insertion; addressable monetization opportunity."
    - name: "Affidavit Generated Count"
      expr: SUM(CASE WHEN affidavit_generated = TRUE THEN 1 ELSE 0 END)
      comment: "Breaks with affidavits generated; billing-readiness and reconciliation KPI."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`scheduling_channel_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Campaign-to-channel allocation delivery KPIs: GRP delivery vs target, budget allocation, and delivery status to steer media-plan pacing."
  source: "`vibe_media_broadcasting_v1`.`scheduling`.`channel_allocation`"
  dimensions:
    - name: "delivery_status"
      expr: delivery_status
      comment: "Delivery state of the allocation (on-pace, under, over)."
    - name: "daypart_mix"
      expr: daypart_mix
      comment: "Daypart mix descriptor for the allocation."
    - name: "flight_start_date"
      expr: flight_start_date
      comment: "Flight start date of the allocation."
    - name: "flight_end_date"
      expr: flight_end_date
      comment: "Flight end date of the allocation."
  measures:
    - name: "Allocation Count"
      expr: COUNT(1)
      comment: "Number of channel allocations; baseline plan volume."
    - name: "Total Allocated Budget"
      expr: SUM(CAST(allocated_budget_amount AS DOUBLE))
      comment: "Total budget allocated across channels; spend-management KPI."
    - name: "Total Target GRP"
      expr: SUM(CAST(target_grp AS DOUBLE))
      comment: "Aggregate target GRPs committed across allocations."
    - name: "Total Actual GRP Delivered"
      expr: SUM(CAST(actual_grp_delivered AS DOUBLE))
      comment: "Aggregate delivered GRPs; basis for delivery shortfall analysis."
    - name: "Avg Target GRP"
      expr: AVG(CAST(target_grp AS DOUBLE))
      comment: "Average target GRP per allocation."
    - name: "Avg Actual GRP Delivered"
      expr: AVG(CAST(actual_grp_delivered AS DOUBLE))
      comment: "Average delivered GRP per allocation."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`scheduling_channel_carriage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Channel carriage economics across OTT platforms: carriage-fee exposure and carriage status to steer distribution profitability."
  source: "`vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage`"
  dimensions:
    - name: "carriage_status"
      expr: carriage_status
      comment: "Status of the carriage relationship (active, pending, expired)."
    - name: "contract_start_date"
      expr: contract_start_date
      comment: "Carriage contract start date."
    - name: "contract_end_date"
      expr: contract_end_date
      comment: "Carriage contract end date."
    - name: "simulcast_enabled"
      expr: simulcast_enabled
      comment: "Whether simulcast is enabled on the carriage."
    - name: "dai_enabled_flag"
      expr: dai_enabled_flag
      comment: "Whether dynamic ad insertion is enabled on the carriage."
  measures:
    - name: "Carriage Count"
      expr: COUNT(1)
      comment: "Number of carriage agreements; distribution footprint KPI."
    - name: "Total Carriage Fee"
      expr: SUM(CAST(carriage_fee_usd AS DOUBLE))
      comment: "Aggregate carriage fees; distribution cost-management KPI."
    - name: "Avg Carriage Fee"
      expr: AVG(CAST(carriage_fee_usd AS DOUBLE))
      comment: "Average carriage fee per agreement; per-platform cost benchmark."
    - name: "Distinct Platforms Carried"
      expr: COUNT(DISTINCT ott_platform_id)
      comment: "Count of distinct OTT platforms carrying channels; reach indicator."
    - name: "DAI Enabled Carriage Count"
      expr: SUM(CASE WHEN dai_enabled_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Carriage agreements with DAI enabled; addressable monetization reach."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`scheduling_channel_license`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Channel content-license utilization and cost KPIs: license fees, run consumption, and exclusivity to steer programming acquisition value."
  source: "`vibe_media_broadcasting_v1`.`scheduling`.`channel_license`"
  dimensions:
    - name: "license_status"
      expr: license_status
      comment: "Status of the license (active, expired, pending)."
    - name: "territory_code"
      expr: territory_code
      comment: "Territory the license applies to."
    - name: "exclusivity_flag"
      expr: exclusivity_flag
      comment: "Whether the license is exclusive."
    - name: "license_start_date"
      expr: license_start_date
      comment: "License effective start date."
    - name: "license_end_date"
      expr: license_end_date
      comment: "License expiry date."
  measures:
    - name: "License Count"
      expr: COUNT(1)
      comment: "Number of channel licenses; programming-rights inventory."
    - name: "Total License Fee"
      expr: SUM(CAST(license_fee_usd AS DOUBLE))
      comment: "Aggregate content-license spend; acquisition cost KPI."
    - name: "Avg License Fee"
      expr: AVG(CAST(license_fee_usd AS DOUBLE))
      comment: "Average license fee per title; per-title acquisition benchmark."
    - name: "Exclusive License Count"
      expr: SUM(CASE WHEN exclusivity_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Exclusive licenses held; competitive-differentiation indicator."
    - name: "Distinct Licensed Titles"
      expr: COUNT(DISTINCT title_id)
      comment: "Distinct titles licensed; catalog breadth KPI."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`scheduling_channel_targeting`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Audience targeting and rate-premium KPIs by demographic segment to steer pricing and guarantee management."
  source: "`vibe_media_broadcasting_v1`.`scheduling`.`channel_targeting`"
  dimensions:
    - name: "targeting_status"
      expr: targeting_status
      comment: "Status of the targeting configuration."
    - name: "daypart_strategy"
      expr: daypart_strategy
      comment: "Daypart strategy used for targeting."
    - name: "is_primary_target"
      expr: is_primary_target
      comment: "Whether this is the primary target segment."
    - name: "effective_from"
      expr: effective_from
      comment: "Targeting effective start date."
  measures:
    - name: "Targeting Count"
      expr: COUNT(1)
      comment: "Number of targeting configurations; segmentation breadth."
    - name: "Total Guaranteed GRP"
      expr: SUM(CAST(guaranteed_grp AS DOUBLE))
      comment: "Aggregate guaranteed GRPs; delivery-liability KPI."
    - name: "Avg Target Rating"
      expr: AVG(CAST(target_rating AS DOUBLE))
      comment: "Average target rating; audience-quality benchmark."
    - name: "Avg Rate Multiplier"
      expr: AVG(CAST(rate_multiplier AS DOUBLE))
      comment: "Average rate multiplier applied for targeting; pricing-premium KPI."
    - name: "Distinct Target Segments"
      expr: COUNT(DISTINCT demographic_segment_id)
      comment: "Distinct demographic segments targeted; addressable-audience breadth."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`scheduling_daypart`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Daypart pricing and audience KPIs: CPM, audience size, HUT, and GRP index to steer inventory pricing and scheduling strategy."
  source: "`vibe_media_broadcasting_v1`.`scheduling`.`daypart`"
  dimensions:
    - name: "daypart_type"
      expr: daypart_type
      comment: "Type/classification of the daypart."
    - name: "day_category"
      expr: day_category
      comment: "Day category (weekday, weekend)."
    - name: "daypart_status"
      expr: daypart_status
      comment: "Status of the daypart definition."
    - name: "target_demographic"
      expr: target_demographic
      comment: "Primary target demographic of the daypart."
    - name: "upfront_eligible"
      expr: upfront_eligible
      comment: "Whether daypart inventory is upfront-eligible."
  measures:
    - name: "Daypart Count"
      expr: COUNT(1)
      comment: "Number of daypart definitions; scheduling grid breadth."
    - name: "Avg Base CPM"
      expr: AVG(CAST(base_cpm_usd AS DOUBLE))
      comment: "Average base CPM by daypart; pricing benchmark."
    - name: "Avg Audience (000s)"
      expr: AVG(CAST(avg_audience_000 AS DOUBLE))
      comment: "Average audience in thousands; audience-value KPI."
    - name: "Avg HUT Level"
      expr: AVG(CAST(hut_level AS DOUBLE))
      comment: "Average households-using-television level; demand-context indicator."
    - name: "Avg GRP Index"
      expr: AVG(CAST(grp_index AS DOUBLE))
      comment: "Average GRP index; relative-delivery efficiency metric."
    - name: "Avg Rate Multiplier"
      expr: AVG(CAST(rate_multiplier AS DOUBLE))
      comment: "Average rate multiplier by daypart; premium-pricing KPI."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`scheduling_playout_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Playout execution quality KPIs: on-air reliability, failovers, blackout enforcement, and rights-clearance to steer broadcast operations."
  source: "`vibe_media_broadcasting_v1`.`scheduling`.`playout_event`"
  dimensions:
    - name: "broadcast_date"
      expr: broadcast_date
      comment: "Date of the playout event; primary operations time axis."
    - name: "playout_status"
      expr: playout_status
      comment: "Outcome status of the playout (aired, failed, preempted)."
    - name: "event_type"
      expr: event_type
      comment: "Type of playout event."
    - name: "automation_mode"
      expr: automation_mode
      comment: "Automation mode (auto/manual) of the playout."
    - name: "rights_clearance_status"
      expr: rights_clearance_status
      comment: "Rights clearance status at airtime."
    - name: "transmission_type"
      expr: transmission_type
      comment: "Transmission type used for the event."
  measures:
    - name: "Playout Event Count"
      expr: COUNT(1)
      comment: "Total playout events; operational throughput baseline."
    - name: "Failover Activated Count"
      expr: SUM(CASE WHEN failover_activated = TRUE THEN 1 ELSE 0 END)
      comment: "Events where failover triggered; broadcast-resilience and reliability KPI."
    - name: "Blackout Event Count"
      expr: SUM(CASE WHEN blackout_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Events with blackout enforced; rights-compliance enforcement KPI."
    - name: "Affidavit Generated Count"
      expr: SUM(CASE WHEN affidavit_generated = TRUE THEN 1 ELSE 0 END)
      comment: "Events with affidavits generated; billing-readiness KPI."
    - name: "Must Carry Event Count"
      expr: SUM(CASE WHEN must_carry_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Must-carry events; regulatory carriage-obligation tracking."
    - name: "Distinct Channels Aired"
      expr: COUNT(DISTINCT channel_id)
      comment: "Distinct channels with playout activity; operational coverage."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`scheduling_program_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Program schedule composition and compliance KPIs: runtime/ad-time balance, simulcast reach, and FCC/must-carry compliance to steer grid health."
  source: "`vibe_media_broadcasting_v1`.`scheduling`.`program_schedule`"
  dimensions:
    - name: "broadcast_date"
      expr: broadcast_date
      comment: "Broadcast date of the schedule."
    - name: "schedule_status"
      expr: schedule_status
      comment: "Status of the schedule (draft, approved, as-run)."
    - name: "schedule_type"
      expr: schedule_type
      comment: "Type of schedule."
    - name: "daypart_code"
      expr: daypart_code
      comment: "Daypart code associated with the schedule."
    - name: "rights_clearance_status"
      expr: rights_clearance_status
      comment: "Rights clearance status of the schedule."
  measures:
    - name: "Schedule Count"
      expr: COUNT(1)
      comment: "Number of program schedules; grid-planning volume."
    - name: "FCC Children Compliant Count"
      expr: SUM(CASE WHEN fcc_children_programming_compliant = TRUE THEN 1 ELSE 0 END)
      comment: "Schedules compliant with FCC children's programming rules; regulatory KPI."
    - name: "Must Carry Compliant Count"
      expr: SUM(CASE WHEN must_carry_compliant = TRUE THEN 1 ELSE 0 END)
      comment: "Must-carry compliant schedules; carriage-obligation compliance KPI."
    - name: "Simulcast Schedule Count"
      expr: SUM(CASE WHEN simulcast_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Schedules with simulcast; multi-platform reach indicator."
    - name: "Blackout Schedule Count"
      expr: SUM(CASE WHEN blackout_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Schedules with blackout enforced; rights-restriction tracking."
    - name: "Distinct Channels Scheduled"
      expr: COUNT(DISTINCT channel_id)
      comment: "Distinct channels with schedules; planning coverage."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`scheduling_local_avail_inventory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Local avail inventory monetization KPIs: sellout, unit utilization, rate, and impressions to steer local-spot revenue at affiliate stations."
  source: "`vibe_media_broadcasting_v1`.`scheduling`.`scheduling_local_avail_inventory`"
  dimensions:
    - name: "avail_date"
      expr: avail_date
      comment: "Date of the local avail inventory."
    - name: "avail_type"
      expr: avail_type
      comment: "Type of avail (local, national, promo)."
    - name: "inventory_status"
      expr: inventory_status
      comment: "Status of the inventory (available, sold, expired)."
    - name: "rate_currency_code"
      expr: rate_currency_code
      comment: "Currency of the rate-card rate."
  measures:
    - name: "Avail Inventory Count"
      expr: COUNT(1)
      comment: "Number of local avail inventory records; inventory volume."
    - name: "Avg Sellout Percentage"
      expr: AVG(CAST(sellout_percentage AS DOUBLE))
      comment: "Average sellout percentage; local-inventory monetization efficiency KPI."
    - name: "Total Estimated Impressions"
      expr: SUM(CAST(estimated_impressions AS DOUBLE))
      comment: "Aggregate estimated impressions across avails; delivery-scale KPI."
    - name: "Avg Rate Card Rate"
      expr: AVG(CAST(rate_card_rate AS DOUBLE))
      comment: "Average rate-card rate per avail; pricing benchmark."
    - name: "Avg Estimated Rating"
      expr: AVG(CAST(estimated_rating AS DOUBLE))
      comment: "Average estimated rating; audience-value benchmark."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`scheduling_network_clearance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Network clearance KPIs for station groups: clearance rate, preemptions, delays, and makegood exposure to steer affiliate-network compliance."
  source: "`vibe_media_broadcasting_v1`.`scheduling`.`scheduling_network_clearance`"
  dimensions:
    - name: "clearance_status"
      expr: clearance_status
      comment: "Clearance outcome (cleared, preempted, delayed)."
    - name: "scheduled_air_date"
      expr: scheduled_air_date
      comment: "Scheduled air date of the cleared program."
    - name: "makegood_required_flag"
      expr: makegood_required_flag
      comment: "Whether a makegood was required due to non-clearance."
  measures:
    - name: "Clearance Count"
      expr: COUNT(1)
      comment: "Number of network clearance records; affiliate-program volume."
    - name: "Makegood Required Count"
      expr: SUM(CASE WHEN makegood_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Clearances requiring makegoods; revenue-liability and non-clearance signal."
    - name: "Network Notification Sent Count"
      expr: SUM(CASE WHEN network_notification_sent_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Clearances with network notification sent; process-compliance KPI."
    - name: "Distinct Affiliate Stations"
      expr: COUNT(DISTINCT affiliate_station_id)
      comment: "Distinct affiliate stations with clearance activity; network-coverage breadth."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`scheduling_scte_marker`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SCTE-35 ad-signaling quality KPIs: processing success, avail accuracy, and break durations to steer DAI signaling reliability."
  source: "`vibe_media_broadcasting_v1`.`scheduling`.`scte_marker`"
  dimensions:
    - name: "processing_status"
      expr: processing_status
      comment: "Processing status of the SCTE marker."
    - name: "splice_command_type"
      expr: splice_command_type
      comment: "Type of splice command in the marker."
    - name: "segmentation_type_label"
      expr: segmentation_type_label
      comment: "Segmentation type label of the marker."
    - name: "out_of_network"
      expr: out_of_network
      comment: "Whether the splice signals out-of-network (ad break)."
  measures:
    - name: "SCTE Marker Count"
      expr: COUNT(1)
      comment: "Total SCTE-35 markers; ad-signaling volume baseline."
    - name: "Out Of Network Marker Count"
      expr: SUM(CASE WHEN out_of_network = TRUE THEN 1 ELSE 0 END)
      comment: "Out-of-network markers signaling ad breaks; insertable-opportunity count."
    - name: "Encrypted Packet Count"
      expr: SUM(CASE WHEN encrypted_packet = TRUE THEN 1 ELSE 0 END)
      comment: "Encrypted SCTE packets; signaling-security indicator."
    - name: "Distinct Channels Signaled"
      expr: COUNT(DISTINCT channel_id)
      comment: "Distinct channels with SCTE markers; signaling coverage."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`scheduling_simulcast_config`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Simulcast configuration KPIs: active configs, DAI/blackout enforcement, and compliance to steer multi-platform distribution reliability."
  source: "`vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config`"
  dimensions:
    - name: "simulcast_config_status"
      expr: simulcast_config_status
      comment: "Status of the simulcast configuration."
    - name: "simulcast_type"
      expr: simulcast_type
      comment: "Type of simulcast."
    - name: "distribution_platform"
      expr: distribution_platform
      comment: "Target distribution platform."
    - name: "effective_from"
      expr: effective_from
      comment: "Configuration effective start date."
  measures:
    - name: "Simulcast Config Count"
      expr: COUNT(1)
      comment: "Number of simulcast configurations; distribution footprint."
    - name: "DAI Enabled Config Count"
      expr: SUM(CASE WHEN dai_enabled = TRUE THEN 1 ELSE 0 END)
      comment: "Configs with DAI enabled; addressable monetization reach."
    - name: "Blackout Enforced Count"
      expr: SUM(CASE WHEN blackout_enforced = TRUE THEN 1 ELSE 0 END)
      comment: "Configs enforcing blackout; rights-compliance enforcement KPI."
    - name: "Must Carry Compliant Count"
      expr: SUM(CASE WHEN must_carry_compliant = TRUE THEN 1 ELSE 0 END)
      comment: "Must-carry compliant configs; regulatory-compliance KPI."
    - name: "Distinct Target Channels"
      expr: COUNT(DISTINCT target_channel_id)
      comment: "Distinct target channels simulcast; distribution reach."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`scheduling_channel_abr_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "ABR encoding-profile assignment KPIs: active assignments, encoding-cost exposure, and QoS tiering to steer streaming-cost and quality trade-offs."
  source: "`vibe_media_broadcasting_v1`.`scheduling`.`channel_abr_assignment`"
  dimensions:
    - name: "assignment_status"
      expr: assignment_status
      comment: "Status of the ABR assignment."
    - name: "qos_tier"
      expr: qos_tier
      comment: "Quality-of-service tier of the assignment."
    - name: "device_class_override"
      expr: device_class_override
      comment: "Device-class override applied to the assignment."
    - name: "effective_start_date"
      expr: effective_start_date
      comment: "Assignment effective start date."
  measures:
    - name: "ABR Assignment Count"
      expr: COUNT(1)
      comment: "Number of ABR profile assignments; streaming-config volume."
    - name: "Total Encoding Cost Estimate"
      expr: SUM(CAST(encoding_cost_estimate_usd AS DOUBLE))
      comment: "Aggregate estimated encoding cost; streaming cost-management KPI."
    - name: "Avg Encoding Cost Estimate"
      expr: AVG(CAST(encoding_cost_estimate_usd AS DOUBLE))
      comment: "Average encoding cost per assignment; per-profile cost benchmark."
    - name: "Distinct Channels Assigned"
      expr: COUNT(DISTINCT channel_id)
      comment: "Distinct channels with ABR assignments; encoding coverage."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`scheduling_channel`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial and capacity metrics at the channel level"
  source: "`vibe_media_broadcasting_v1`.`scheduling`.`channel`"
  dimensions:
    - name: "network_name"
      expr: network_name
      comment: "Name of the broadcast network"
    - name: "channel_type"
      expr: channel_type
      comment: "Classification of the channel (e.g., linear, OTT)"
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country where the channel is licensed"
    - name: "broadcast_timezone"
      expr: broadcast_timezone
      comment: "Timezone used for the channel's schedule"
    - name: "dai_enabled"
      expr: dai_enabled
      comment: "Whether Dynamic Ad Insertion is enabled for the channel"
    - name: "scte35_enabled"
      expr: scte35_enabled
      comment: "Whether SCTE‑35 signaling is enabled"
  measures:
    - name: "total_carriage_fee_usd"
      expr: SUM(CAST(carriage_fee_usd AS DOUBLE))
      comment: "Total carriage fees collected for the channel"
    - name: "average_max_ad_load_pct"
      expr: AVG(CAST(max_ad_load_pct AS DOUBLE))
      comment: "Average maximum ad load percentage allowed on the channel"
    - name: "channel_count"
      expr: COUNT(1)
      comment: "Number of channel records"
$$;