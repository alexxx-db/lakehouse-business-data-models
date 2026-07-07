-- Metric views for domain: inventory | Business: Travel Hospitality | Version: 2 | Generated on: 2026-06-28 00:14:33

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`inventory_allotment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Allotment performance and economics KPIs. Tracks contracted inventory commitments, commission exposure, and release efficiency across channels and room types."
  source: "`vibe_travel_hospitality_v1`.`inventory`.`allotment`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property identifier; enables property-level allotment portfolio analysis."
    - name: "room_type_id"
      expr: room_type_id
      comment: "Room type identifier; enables room-type-level allotment utilization analysis."
    - name: "channel_id"
      expr: channel_id
      comment: "Distribution channel identifier; enables channel-level allotment performance comparison."
    - name: "allotment_status"
      expr: allotment_status
      comment: "Current status of the allotment (e.g., active, expired, suspended); used to filter live vs. historical allotments."
    - name: "allotment_type"
      expr: allotment_type
      comment: "Type of allotment (e.g., freesale, hard block, soft block); drives different yield management strategies."
    - name: "start_date"
      expr: start_date
      comment: "Allotment start date; used for time-series analysis of allotment portfolio."
    - name: "end_date"
      expr: end_date
      comment: "Allotment end date; used to identify expiring allotments requiring action."
    - name: "freesale_enabled"
      expr: freesale_enabled
      comment: "Indicates whether freesale is enabled for this allotment; differentiates hard-block from freesale inventory strategies."
    - name: "lra_enabled"
      expr: lra_enabled
      comment: "Indicates whether Last Room Availability is enabled; critical for premium channel and loyalty commitments."
    - name: "campaign_id"
      expr: campaign_id
      comment: "Associated marketing campaign; enables campaign-driven allotment performance analysis."
  measures:
    - name: "total_allotments"
      expr: COUNT(1)
      comment: "Total number of allotment records. Baseline measure for allotment portfolio size."
    - name: "avg_commission_rate_pct"
      expr: AVG(CAST(commission_rate_percent AS DOUBLE))
      comment: "Average commission rate across allotments. Directly impacts net revenue; executives use this to benchmark channel cost of distribution."
    - name: "total_commission_rate_exposure"
      expr: SUM(CAST(commission_rate_percent AS DOUBLE))
      comment: "Sum of commission rates across allotments. Proxy for total commission cost exposure in the allotment portfolio."
    - name: "avg_performance_threshold_pct"
      expr: AVG(CAST(performance_threshold_percent AS DOUBLE))
      comment: "Average performance threshold percentage set on allotments. Indicates how aggressively performance clauses are structured in allotment contracts."
    - name: "active_allotment_count"
      expr: SUM(CASE WHEN allotment_status = 'active' THEN 1 ELSE 0 END)
      comment: "Count of currently active allotments. Measures live inventory commitment exposure."
    - name: "freesale_allotment_count"
      expr: SUM(CASE WHEN freesale_enabled = TRUE THEN 1 ELSE 0 END)
      comment: "Count of allotments with freesale enabled. Tracks the proportion of inventory exposed to unrestricted channel selling."
    - name: "lra_allotment_count"
      expr: SUM(CASE WHEN lra_enabled = TRUE THEN 1 ELSE 0 END)
      comment: "Count of allotments with Last Room Availability enabled. Measures LRA commitment exposure, which constrains yield management flexibility."
    - name: "distinct_channels_with_allotments"
      expr: COUNT(DISTINCT channel_id)
      comment: "Number of distinct channels with active allotment agreements. Measures channel diversification of inventory distribution."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`inventory_availability_snapshot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Daily room availability and occupancy KPIs derived from availability snapshots. Drives revenue management decisions on sell limits, overbooking, and restriction strategies."
  source: "`vibe_travel_hospitality_v1`.`inventory`.`availability_snapshot`"
  dimensions:
    - name: "snapshot_date"
      expr: snapshot_date
      comment: "Business date of the availability snapshot; used to trend occupancy and availability over time."
    - name: "property_id"
      expr: property_id
      comment: "Property identifier; enables property-level occupancy and availability analysis."
    - name: "room_type_id"
      expr: room_type_id
      comment: "Room type identifier; enables room-type-level availability and overbooking analysis."
    - name: "stop_sell_flag"
      expr: stop_sell_flag
      comment: "Indicates whether the room type is closed to new bookings on this date; used to audit restriction decisions."
    - name: "closed_to_arrival_flag"
      expr: closed_to_arrival_flag
      comment: "Indicates CTA restriction is active; used to analyze restriction impact on pickup."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Status of inventory reconciliation for this snapshot; used to filter clean vs. discrepant records."
    - name: "snapshot_month"
      expr: DATE_TRUNC('MONTH', snapshot_date)
      comment: "Month bucket of the snapshot date; supports monthly trend analysis."
  measures:
    - name: "avg_occupancy_rate"
      expr: AVG(CAST(occ_rate AS DOUBLE))
      comment: "Average occupancy rate across snapshots. Core RevPAR driver; executives use this to assess demand fill and pricing power."
    - name: "snapshot_count"
      expr: COUNT(1)
      comment: "Total number of availability snapshots. Baseline volume measure for data completeness and coverage audits."
    - name: "stop_sell_days"
      expr: SUM(CASE WHEN stop_sell_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of snapshot records where stop-sell was active. Measures restriction intensity; high values signal demand saturation or conservative yield strategy."
    - name: "cta_days"
      expr: SUM(CASE WHEN closed_to_arrival_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of snapshot records with closed-to-arrival restriction active. Tracks how aggressively CTA is applied across the portfolio."
    - name: "ctd_days"
      expr: SUM(CASE WHEN closed_to_departure_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of snapshot records with closed-to-departure restriction active. Complements CTA analysis for full restriction picture."
    - name: "discrepancy_snapshot_count"
      expr: SUM(CASE WHEN discrepancy_notes IS NOT NULL AND discrepancy_notes <> '' THEN 1 ELSE 0 END)
      comment: "Count of snapshots with recorded discrepancy notes. Signals inventory reconciliation quality issues that can distort availability reporting."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`inventory_block_pickup`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Group block pickup performance KPIs. Tracks contracted vs. actual room pickup, wash risk, and displacement cost for group business — a critical revenue management decision surface."
  source: "`vibe_travel_hospitality_v1`.`inventory`.`block_pickup`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property identifier; enables property-level group block performance comparison."
    - name: "room_type_id"
      expr: room_type_id
      comment: "Room type identifier; enables room-type-level pickup analysis."
    - name: "block_status"
      expr: block_status
      comment: "Current status of the block (e.g., tentative, definite, cancelled); used to filter actionable vs. historical blocks."
    - name: "pickup_date"
      expr: pickup_date
      comment: "Date of pickup activity; used to trend pickup pace over time."
    - name: "stay_date"
      expr: stay_date
      comment: "Actual stay date for the block; used to align pickup analysis with revenue impact dates."
    - name: "cutoff_date"
      expr: cutoff_date
      comment: "Block cutoff date; used to identify blocks approaching or past cutoff requiring release decisions."
    - name: "is_lra_eligible"
      expr: is_lra_eligible
      comment: "Indicates LRA eligibility for this block; differentiates premium group commitments."
    - name: "market_segment_code"
      expr: market_segment_code
      comment: "Market segment of the group block; enables segment-level group performance analysis."
    - name: "room_block_id"
      expr: room_block_id
      comment: "Room block identifier; used to aggregate pickup metrics at the block level."
  measures:
    - name: "total_pickup_revenue"
      expr: SUM(CAST(pickup_revenue AS DOUBLE))
      comment: "Total revenue from rooms picked up against group blocks. Primary financial KPI for group business performance."
    - name: "avg_pickup_rate_pct"
      expr: AVG(CAST(pickup_rate AS DOUBLE))
      comment: "Average pickup rate across block records. Measures how efficiently contracted group rooms are being consumed."
    - name: "avg_pickup_percentage"
      expr: AVG(CAST(pickup_percentage AS DOUBLE))
      comment: "Average pickup percentage (rooms picked up vs. contracted). Core group block utilization KPI used in group evaluation and attrition risk assessment."
    - name: "total_displacement_cost"
      expr: SUM(CAST(displacement_cost AS DOUBLE))
      comment: "Total displacement cost across block pickup records. Measures the opportunity cost of holding group inventory vs. transient; critical for group pricing decisions."
    - name: "avg_wash_factor"
      expr: AVG(CAST(wash_factor AS DOUBLE))
      comment: "Average wash factor applied to blocks. Tracks how aggressively inventory is being released back; informs wash factor calibration."
    - name: "total_block_pickup_records"
      expr: COUNT(1)
      comment: "Total number of block pickup records. Baseline volume measure for group activity."
    - name: "distinct_active_blocks"
      expr: COUNT(DISTINCT room_block_id)
      comment: "Number of distinct room blocks with pickup activity. Measures breadth of active group business."
    - name: "avg_pickup_pace_variance"
      expr: AVG(CAST(pickup_pace_variance AS DOUBLE))
      comment: "Average pickup pace variance. Identifies blocks tracking ahead or behind expected pace, enabling proactive yield intervention."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`inventory_block_wash_factor_application`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Block wash factor application KPIs tracking forecast accuracy and wash calibration. Informs revenue management wash factor model performance and group block release strategy."
  source: "`vibe_travel_hospitality_v1`.`inventory`.`block_wash_factor_application`"
  dimensions:
    - name: "room_block_id"
      expr: room_block_id
      comment: "Room block identifier; enables block-level wash factor analysis."
    - name: "application_status"
      expr: application_status
      comment: "Status of the wash factor application (e.g., applied, pending, overridden); used to filter completed applications."
    - name: "application_reason"
      expr: application_reason
      comment: "Reason for the wash factor application; enables root-cause analysis of wash decisions."
    - name: "effective_date"
      expr: effective_date
      comment: "Date the wash factor was applied; used for time-series analysis of wash activity."
    - name: "block_size_tier_match"
      expr: block_size_tier_match
      comment: "Block size tier matched for wash factor selection; enables tier-level wash performance analysis."
    - name: "lead_time_bucket_match"
      expr: lead_time_bucket_match
      comment: "Lead time bucket matched for wash factor selection; enables lead-time-based wash accuracy analysis."
  measures:
    - name: "avg_applied_wash_pct"
      expr: AVG(CAST(applied_wash_pct AS DOUBLE))
      comment: "Average wash percentage applied to blocks. Measures how aggressively inventory is being released; informs wash factor model calibration."
    - name: "avg_actual_wash_pct"
      expr: AVG(CAST(actual_wash_pct AS DOUBLE))
      comment: "Average actual wash percentage observed. Compared against applied wash to measure forecast accuracy."
    - name: "avg_variance_pct"
      expr: AVG(CAST(variance_pct AS DOUBLE))
      comment: "Average variance between applied and actual wash percentage. Core model accuracy KPI; high variance signals wash factor model needs recalibration."
    - name: "avg_wash_factor_percentage"
      expr: AVG(CAST(wash_factor_percentage AS DOUBLE))
      comment: "Average wash factor percentage from the wash factor master. Benchmarks applied wash against the configured factor."
    - name: "total_applications"
      expr: COUNT(1)
      comment: "Total number of wash factor applications. Baseline measure for wash activity volume."
    - name: "overridden_application_count"
      expr: SUM(CASE WHEN application_status = 'overridden' THEN 1 ELSE 0 END)
      comment: "Count of wash factor applications that were manually overridden. Measures how often revenue managers override the model; high counts signal model distrust."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`inventory_change_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory change audit and governance metrics. Tracks the volume, type, and financial impact of inventory changes to support compliance, revenue management accountability, and audit trail integrity."
  source: "`vibe_travel_hospitality_v1`.`inventory`.`change_audit`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property identifier for property-level audit analysis."
    - name: "change_reason_code"
      expr: change_reason_code
      comment: "Reason code for the inventory change — used to categorize change drivers and identify patterns."
    - name: "change_impact_type"
      expr: change_impact_type
      comment: "Type of business impact from the change (e.g., Revenue, Compliance, Operational) — used for impact analysis."
    - name: "changed_entity_type"
      expr: changed_entity_type
      comment: "Type of entity that was changed (e.g., Rate, Restriction, Allotment) — used to categorize change activity."
    - name: "business_date"
      expr: business_date
      comment: "Business date of the change — used for trend analysis of change activity over time."
    - name: "stop_sell_change_flag"
      expr: stop_sell_change_flag
      comment: "Indicates whether the change involved a stop-sell modification — used to track restriction change frequency."
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Indicates whether this is a reversal of a prior change — used to track correction rates and data quality."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Compliance flag on the change — used to identify changes with regulatory or policy implications."
    - name: "approval_required_flag"
      expr: approval_required_flag
      comment: "Indicates whether the change required approval — used for governance and authorization tracking."
  measures:
    - name: "total_changes"
      expr: COUNT(1)
      comment: "Total inventory change audit records. Baseline governance metric — used to track change activity volume and identify periods of high change frequency."
    - name: "avg_value_change"
      expr: AVG(new_value - previous_value)
      comment: "Average magnitude of value change across audit records. Impact assessment metric — used to understand the typical scale of inventory adjustments."
    - name: "total_value_change"
      expr: SUM(new_value - previous_value)
      comment: "Total net value change across all audit records. Financial impact metric — used to quantify the cumulative effect of inventory adjustments on revenue potential."
    - name: "reversal_changes"
      expr: COUNT(CASE WHEN reversal_flag = TRUE THEN 1 END)
      comment: "Number of change reversals. Data quality and governance metric — high reversal rates indicate errors in inventory management processes requiring investigation."
    - name: "compliance_flagged_changes"
      expr: COUNT(CASE WHEN compliance_flag = TRUE THEN 1 END)
      comment: "Number of changes flagged for compliance review. Regulatory risk metric — compliance-flagged changes require audit trail preservation and may trigger regulatory reporting."
    - name: "stop_sell_changes"
      expr: COUNT(CASE WHEN stop_sell_change_flag = TRUE THEN 1 END)
      comment: "Number of changes involving stop-sell modifications. Revenue management activity metric — used to track restriction change frequency and assess strategy execution pace."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`inventory_channel_inventory_map`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Channel inventory mapping KPIs tracking distribution coverage, rate parity enforcement, and channel sell limits. Informs channel strategy and inventory distribution decisions."
  source: "`vibe_travel_hospitality_v1`.`inventory`.`channel_inventory_map`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property identifier; enables property-level channel distribution analysis."
    - name: "room_type_id"
      expr: room_type_id
      comment: "Room type identifier; enables room-type-level channel mapping analysis."
    - name: "mapping_status"
      expr: mapping_status
      comment: "Status of the channel inventory mapping (e.g., active, inactive); used to filter live mappings."
    - name: "allocation_type"
      expr: allocation_type
      comment: "Type of inventory allocation to the channel; differentiates hard block from freesale channel strategies."
    - name: "channel_visibility_flag"
      expr: channel_visibility_flag
      comment: "Indicates whether inventory is visible on this channel; used to measure distribution reach."
    - name: "rate_parity_enforcement_flag"
      expr: rate_parity_enforcement_flag
      comment: "Indicates rate parity enforcement is active; used to track parity compliance across channels."
    - name: "lra_enabled_flag"
      expr: lra_enabled_flag
      comment: "Indicates LRA is enabled for this channel mapping; used to track LRA commitment by channel."
    - name: "commission_eligible_flag"
      expr: commission_eligible_flag
      comment: "Indicates commission eligibility; used to analyze cost of distribution by channel."
  measures:
    - name: "total_channel_mappings"
      expr: COUNT(1)
      comment: "Total number of channel inventory mappings. Baseline measure for distribution network coverage."
    - name: "active_mapping_count"
      expr: SUM(CASE WHEN mapping_status = 'active' THEN 1 ELSE 0 END)
      comment: "Count of active channel inventory mappings. Measures live distribution network size."
    - name: "rate_parity_enforced_count"
      expr: SUM(CASE WHEN rate_parity_enforcement_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of mappings with rate parity enforcement active. Measures parity compliance coverage across the distribution network."
    - name: "avg_overbooking_limit_pct"
      expr: AVG(CAST(overbooking_limit_pct AS DOUBLE))
      comment: "Average overbooking limit percentage set at the channel-room-type level. Measures channel-level overbooking risk tolerance."
    - name: "lra_enabled_mapping_count"
      expr: SUM(CASE WHEN lra_enabled_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of channel mappings with LRA enabled. Measures LRA commitment exposure across the distribution network."
    - name: "distinct_channels_mapped"
      expr: COUNT(DISTINCT channel_contract_id)
      comment: "Number of distinct channel contracts with inventory mappings. Measures breadth of active distribution partnerships."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`inventory_control`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory control KPIs tracking yield management decisions, hurdle rates, forecast accuracy, and restriction activity. Core revenue management decision surface for daily inventory strategy."
  source: "`vibe_travel_hospitality_v1`.`inventory`.`control`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property identifier; enables property-level inventory control analysis."
    - name: "room_type_id"
      expr: room_type_id
      comment: "Room type identifier; enables room-type-level yield control analysis."
    - name: "stay_date"
      expr: stay_date
      comment: "Stay date for the control record; used to analyze inventory decisions by arrival date."
    - name: "control_status"
      expr: control_status
      comment: "Current status of the inventory control record; used to filter active vs. expired controls."
    - name: "stop_sell_flag"
      expr: stop_sell_flag
      comment: "Indicates stop-sell restriction is active; used to measure restriction intensity."
    - name: "cta_flag"
      expr: cta_flag
      comment: "Indicates closed-to-arrival restriction; used to analyze CTA usage patterns."
    - name: "ctd_flag"
      expr: ctd_flag
      comment: "Indicates closed-to-departure restriction; used to analyze CTD usage patterns."
    - name: "lra_flag"
      expr: lra_flag
      comment: "Indicates Last Room Availability is active; used to track LRA commitment exposure."
    - name: "channel_id"
      expr: channel_id
      comment: "Channel identifier; enables channel-level inventory control analysis."
    - name: "stay_month"
      expr: DATE_TRUNC('MONTH', stay_date)
      comment: "Month bucket of the stay date; supports monthly yield strategy analysis."
  measures:
    - name: "avg_hurdle_rate"
      expr: AVG(CAST(hurdle_rate AS DOUBLE))
      comment: "Average hurdle rate set across inventory controls. Measures the minimum acceptable rate threshold; directly drives revenue optimization decisions."
    - name: "avg_forecast_adr"
      expr: AVG(CAST(forecast_adr AS DOUBLE))
      comment: "Average forecasted ADR across control records. Tracks revenue management rate expectations vs. actuals."
    - name: "avg_forecast_occ_pct"
      expr: AVG(CAST(forecast_occ_pct AS DOUBLE))
      comment: "Average forecasted occupancy percentage. Core demand signal used in yield management decisions."
    - name: "avg_competitive_set_adr"
      expr: AVG(CAST(competitive_set_adr AS DOUBLE))
      comment: "Average competitive set ADR recorded in control records. Enables rate parity and competitive positioning analysis."
    - name: "avg_rgi_target"
      expr: AVG(CAST(rgi_target AS DOUBLE))
      comment: "Average Revenue Generation Index target. Measures ambition of revenue management strategy relative to competitive set."
    - name: "avg_channel_allocation_pct"
      expr: AVG(CAST(channel_allocation_pct AS DOUBLE))
      comment: "Average channel allocation percentage across controls. Tracks how inventory is distributed across channels."
    - name: "avg_overbooking_limit_pct"
      expr: AVG(CAST(overbooking_limit_pct AS DOUBLE))
      comment: "Average overbooking limit percentage set in control records. Measures portfolio-level overbooking risk tolerance."
    - name: "stop_sell_control_count"
      expr: SUM(CASE WHEN stop_sell_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of control records with stop-sell active. Measures restriction intensity across the inventory portfolio."
    - name: "total_control_records"
      expr: COUNT(1)
      comment: "Total number of inventory control records. Baseline measure for yield management activity volume."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`inventory_inventory_overbooking_policy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory Overbooking Policy business metrics"
  source: "`travel_hospitality_ecm`.`inventory`.`inventory_overbooking_policy`"
  dimensions:
    - name: "Approval Authority"
      expr: approval_authority
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Channel Applicability"
      expr: channel_applicability
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Los Restriction Max"
      expr: los_restriction_max
    - name: "Los Restriction Min"
      expr: los_restriction_min
    - name: "Lra Enabled"
      expr: lra_enabled
    - name: "Maximum Overbooking Rooms"
      expr: maximum_overbooking_rooms
    - name: "Notes"
      expr: notes
    - name: "Overbooking Limit Type"
      expr: overbooking_limit_type
    - name: "Physical Room Capacity"
      expr: physical_room_capacity
    - name: "Policy Code"
      expr: policy_code
    - name: "Policy Name"
      expr: policy_name
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Inventory Overbooking Policy"
      expr: COUNT(DISTINCT inventory_overbooking_policy_id)
    - name: "Total Cancellation Forecast Rate"
      expr: SUM(cancellation_forecast_rate)
    - name: "Average Cancellation Forecast Rate"
      expr: AVG(cancellation_forecast_rate)
    - name: "Total No Show Forecast Rate"
      expr: SUM(no_show_forecast_rate)
    - name: "Average No Show Forecast Rate"
      expr: AVG(no_show_forecast_rate)
    - name: "Total Overbooking Limit Value"
      expr: SUM(overbooking_limit_value)
    - name: "Average Overbooking Limit Value"
      expr: AVG(overbooking_limit_value)
    - name: "Total Walk Cost Estimate"
      expr: SUM(walk_cost_estimate)
    - name: "Average Walk Cost Estimate"
      expr: AVG(walk_cost_estimate)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`inventory_overbooking_policy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Overbooking policy KPIs tracking risk tolerance, walk cost exposure, and policy coverage across properties and room types. Informs revenue management risk strategy."
  source: "`vibe_travel_hospitality_v1`.`inventory`.`inventory_overbooking_policy`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property identifier; enables property-level overbooking policy comparison."
    - name: "room_type_id"
      expr: room_type_id
      comment: "Room type identifier; enables room-type-level overbooking risk analysis."
    - name: "policy_status"
      expr: policy_status
      comment: "Current status of the overbooking policy (e.g., active, inactive); used to filter live policies."
    - name: "overbooking_limit_type"
      expr: overbooking_limit_type
      comment: "Type of overbooking limit (e.g., absolute, percentage); differentiates policy structures."
    - name: "lra_enabled"
      expr: lra_enabled
      comment: "Indicates whether LRA is enabled under this policy; affects overbooking risk calculation."
    - name: "effective_start_date"
      expr: effective_start_date
      comment: "Policy effective start date; used for time-series analysis of policy changes."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the policy; used to understand policy hierarchy and override logic."
  measures:
    - name: "avg_overbooking_limit_value"
      expr: AVG(CAST(overbooking_limit_value AS DOUBLE))
      comment: "Average overbooking limit value across policies. Measures the average risk tolerance set across the portfolio; executives use this to benchmark against walk incident rates."
    - name: "avg_no_show_forecast_rate"
      expr: AVG(CAST(no_show_forecast_rate AS DOUBLE))
      comment: "Average no-show forecast rate used in overbooking policies. Tracks the demand signal driving overbooking decisions."
    - name: "avg_cancellation_forecast_rate"
      expr: AVG(CAST(cancellation_forecast_rate AS DOUBLE))
      comment: "Average cancellation forecast rate used in overbooking policies. Complements no-show rate in overbooking risk modeling."
    - name: "total_walk_cost_estimate"
      expr: SUM(CAST(walk_cost_estimate AS DOUBLE))
      comment: "Total estimated walk cost across overbooking policies. Quantifies the financial downside of overbooking strategy; used to calibrate risk tolerance."
    - name: "avg_walk_cost_estimate"
      expr: AVG(CAST(walk_cost_estimate AS DOUBLE))
      comment: "Average estimated walk cost per policy. Benchmarks walk cost exposure by property and room type."
    - name: "active_policy_count"
      expr: SUM(CASE WHEN policy_status = 'active' THEN 1 ELSE 0 END)
      comment: "Count of active overbooking policies. Measures policy coverage across the portfolio."
    - name: "total_policies"
      expr: COUNT(1)
      comment: "Total number of overbooking policy records. Baseline measure for policy portfolio size."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`inventory_los_restriction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Length-of-stay restriction KPIs tracking restriction coverage, ADR thresholds, and occupancy triggers. Informs revenue management LOS strategy and its impact on booking patterns."
  source: "`vibe_travel_hospitality_v1`.`inventory`.`los_restriction`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property identifier; enables property-level LOS restriction analysis."
    - name: "room_type_id"
      expr: room_type_id
      comment: "Room type identifier; enables room-type-level LOS restriction analysis."
    - name: "restriction_type"
      expr: restriction_type
      comment: "Type of LOS restriction (e.g., min stay, max stay, full pattern); differentiates restriction strategies."
    - name: "restriction_status"
      expr: restriction_status
      comment: "Current status of the restriction (e.g., active, expired); used to filter live restrictions."
    - name: "stay_date"
      expr: stay_date
      comment: "Stay date for the restriction; used to analyze restriction patterns by date."
    - name: "market_segment_code"
      expr: market_segment_code
      comment: "Market segment the restriction applies to; enables segment-level LOS strategy analysis."
    - name: "lra_flag"
      expr: lra_flag
      comment: "Indicates LRA exemption applies; differentiates LRA-exempt from standard restrictions."
    - name: "group_block_exempt_flag"
      expr: group_block_exempt_flag
      comment: "Indicates group blocks are exempt from this restriction; used to assess group vs. transient restriction impact."
  measures:
    - name: "avg_adr_threshold_amount"
      expr: AVG(CAST(adr_threshold_amount AS DOUBLE))
      comment: "Average ADR threshold set on LOS restrictions. Measures the rate floor used to trigger LOS controls; informs pricing strategy calibration."
    - name: "avg_occ_threshold_percent"
      expr: AVG(CAST(occ_threshold_percent AS DOUBLE))
      comment: "Average occupancy threshold percentage triggering LOS restrictions. Tracks demand levels at which LOS controls are activated."
    - name: "avg_revpar_threshold_amount"
      expr: AVG(CAST(revpar_threshold_amount AS DOUBLE))
      comment: "Average RevPAR threshold set on LOS restrictions. Measures the RevPAR floor used to trigger LOS controls."
    - name: "active_restriction_count"
      expr: SUM(CASE WHEN restriction_status = 'active' THEN 1 ELSE 0 END)
      comment: "Count of currently active LOS restrictions. Measures restriction intensity across the portfolio."
    - name: "total_los_restrictions"
      expr: COUNT(1)
      comment: "Total number of LOS restriction records. Baseline measure for restriction activity volume."
    - name: "distinct_properties_with_restrictions"
      expr: COUNT(DISTINCT property_id)
      comment: "Number of distinct properties with LOS restrictions active. Measures breadth of LOS strategy deployment."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`inventory_out_of_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Out-of-order room KPIs tracking financial impact, duration, and operational efficiency of room removals from sellable inventory. Directly informs CapEx prioritization and maintenance investment decisions."
  source: "`vibe_travel_hospitality_v1`.`inventory`.`out_of_order`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property identifier; enables property-level OOO impact comparison."
    - name: "ooo_status"
      expr: ooo_status
      comment: "Current status of the out-of-order record (e.g., open, closed); used to filter active vs. resolved OOO rooms."
    - name: "ooo_reason"
      expr: ooo_reason
      comment: "Reason for the out-of-order designation; enables root-cause analysis of inventory loss."
    - name: "responsible_department"
      expr: responsible_department
      comment: "Department responsible for the OOO room; enables departmental accountability analysis."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the OOO record; used to assess urgency of room restoration."
    - name: "safety_concern_flag"
      expr: safety_concern_flag
      comment: "Indicates whether the OOO is safety-related; used to prioritize compliance-driven restorations."
    - name: "guest_impacted_flag"
      expr: guest_impacted_flag
      comment: "Indicates whether guests were impacted by this OOO; used to assess service quality and walk risk."
    - name: "start_date"
      expr: start_date
      comment: "Start date of the OOO period; used for time-series analysis of inventory loss."
  measures:
    - name: "total_lost_revenue_estimate"
      expr: SUM(CAST(lost_revenue_estimate AS DOUBLE))
      comment: "Total estimated revenue lost due to out-of-order rooms. Primary financial KPI for OOO impact; drives CapEx and maintenance investment decisions."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred for out-of-order room repairs. Measures maintenance spend and informs ROI of preventive maintenance programs."
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated cost for OOO repairs. Used to compare budget vs. actual maintenance spend."
    - name: "avg_impact_on_occupancy"
      expr: AVG(CAST(impact_on_occ AS DOUBLE))
      comment: "Average occupancy impact per OOO record. Quantifies how OOO rooms drag down property-level occupancy performance."
    - name: "avg_impact_on_revpar"
      expr: AVG(CAST(impact_on_revpar AS DOUBLE))
      comment: "Average RevPAR impact per OOO record. Directly links room unavailability to revenue performance degradation."
    - name: "total_ooo_records"
      expr: COUNT(1)
      comment: "Total number of out-of-order records. Baseline measure for OOO frequency and operational quality."
    - name: "safety_related_ooo_count"
      expr: SUM(CASE WHEN safety_concern_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of OOO records flagged as safety concerns. Tracks compliance and safety risk exposure in the room inventory."
    - name: "guest_impacted_ooo_count"
      expr: SUM(CASE WHEN guest_impacted_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of OOO records where guests were impacted. Measures service quality risk from inventory unavailability."
    - name: "cost_variance"
      expr: SUM(CAST(actual_cost AS DOUBLE) - CAST(estimated_cost AS DOUBLE))
      comment: "Total variance between actual and estimated OOO repair costs. Measures accuracy of maintenance cost estimation and budget discipline."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`inventory_rate_plan_room_type_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rate Plan Room Type Assignment business metrics"
  source: "`travel_hospitality_ecm`.`inventory`.`rate_plan_room_type_assignment`"
  dimensions:
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Max Los"
      expr: max_los
    - name: "Min Los"
      expr: min_los
    - name: "Modified By User"
      expr: modified_by_user
    - name: "Priority Rank"
      expr: priority_rank
    - name: "Restriction Status"
      expr: restriction_status
    - name: "Sell Limit"
      expr: sell_limit
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
    - name: "Effective End Date Month"
      expr: DATE_TRUNC('MONTH', effective_end_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Rate Plan Room Type Assignment"
      expr: COUNT(DISTINCT rate_plan_room_type_assignment_id)
    - name: "Total Rate Adjustment Value"
      expr: SUM(rate_adjustment_value)
    - name: "Average Rate Adjustment Value"
      expr: AVG(rate_adjustment_value)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`inventory_room`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Physical room inventory KPIs tracking operational status, ADA coverage, and asset condition. Informs property operations, CapEx planning, and compliance reporting."
  source: "`vibe_travel_hospitality_v1`.`inventory`.`room`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property identifier; enables property-level physical room inventory analysis."
    - name: "room_type_id"
      expr: room_type_id
      comment: "Room type identifier; enables room-type-level physical inventory analysis."
    - name: "operational_status"
      expr: operational_status
      comment: "Operational status of the room (e.g., active, OOO, OOS); used to measure sellable vs. unavailable inventory."
    - name: "housekeeping_status"
      expr: housekeeping_status
      comment: "Housekeeping status of the room; used to analyze cleaning efficiency and room readiness."
    - name: "ada_accessible"
      expr: ada_accessible
      comment: "Indicates ADA accessibility; used to track accessible room coverage."
    - name: "smoking_allowed"
      expr: smoking_allowed
      comment: "Indicates smoking policy; used to analyze smoking vs. non-smoking inventory mix."
    - name: "lra_eligible"
      expr: lra_eligible
      comment: "Indicates LRA eligibility at the physical room level; used to track LRA commitment exposure."
    - name: "overbooking_eligible"
      expr: overbooking_eligible
      comment: "Indicates whether the room is eligible for overbooking; used to measure overbooking buffer capacity."
  measures:
    - name: "total_rooms"
      expr: COUNT(1)
      comment: "Total number of physical rooms. Baseline measure for property inventory capacity."
    - name: "ada_accessible_room_count"
      expr: SUM(CASE WHEN ada_accessible = TRUE THEN 1 ELSE 0 END)
      comment: "Count of ADA-accessible rooms. Tracks compliance with accessibility requirements; executives use this for regulatory reporting."
    - name: "avg_square_footage"
      expr: AVG(CAST(square_footage AS DOUBLE))
      comment: "Average square footage of physical rooms. Informs product positioning and renovation investment decisions."
    - name: "avg_ffe_condition_score"
      expr: AVG(CAST(ffe_condition_score AS DOUBLE))
      comment: "Average FF&E condition score across rooms. Measures asset quality; low scores trigger CapEx and renovation investment decisions."
    - name: "overbooking_eligible_room_count"
      expr: SUM(CASE WHEN overbooking_eligible = TRUE THEN 1 ELSE 0 END)
      comment: "Count of rooms eligible for overbooking. Measures the physical buffer available for overbooking strategy."
    - name: "lra_eligible_room_count"
      expr: SUM(CASE WHEN lra_eligible = TRUE THEN 1 ELSE 0 END)
      comment: "Count of LRA-eligible rooms. Measures the scope of LRA commitment at the physical room level."
    - name: "distinct_properties"
      expr: COUNT(DISTINCT property_id)
      comment: "Number of distinct properties in the room inventory. Measures portfolio coverage."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`inventory_room_amenity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Room amenity portfolio KPIs tracking asset value, condition, compliance, and cost. Informs CapEx planning, vendor management, and guest experience investment decisions."
  source: "`vibe_travel_hospitality_v1`.`inventory`.`room_amenity`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property identifier; enables property-level amenity portfolio analysis."
    - name: "room_type_id"
      expr: room_type_id
      comment: "Room type identifier; enables room-type-level amenity analysis."
    - name: "amenity_category"
      expr: amenity_category
      comment: "Category of the amenity (e.g., technology, furniture, bathroom); enables category-level investment analysis."
    - name: "condition_status"
      expr: condition_status
      comment: "Current condition of the amenity (e.g., good, fair, poor); used to prioritize replacement decisions."
    - name: "operational_status"
      expr: operational_status
      comment: "Operational status of the amenity; used to filter active vs. decommissioned assets."
    - name: "is_ada_compliant"
      expr: is_ada_compliant
      comment: "Indicates ADA compliance of the amenity; used for accessibility compliance reporting."
    - name: "is_complimentary"
      expr: is_complimentary
      comment: "Indicates whether the amenity is complimentary; used to analyze cost of complimentary amenity programs."
    - name: "is_premium_amenity"
      expr: is_premium_amenity
      comment: "Indicates premium amenity designation; used to analyze premium product mix and upsell potential."
    - name: "vendor_id"
      expr: vendor_id
      comment: "Vendor identifier; enables vendor-level amenity supply and cost analysis."
  measures:
    - name: "total_unit_cost"
      expr: SUM(CAST(unit_cost AS DOUBLE))
      comment: "Total unit cost of room amenities. Measures total amenity asset investment across the portfolio."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost of room amenities. Benchmarks amenity investment per unit for procurement and budgeting."
    - name: "total_charge_amount"
      expr: SUM(CAST(charge_amount AS DOUBLE))
      comment: "Total charge amount for paid amenities. Measures revenue generated from chargeable amenity services."
    - name: "total_amenity_records"
      expr: COUNT(1)
      comment: "Total number of room amenity records. Baseline measure for amenity portfolio size."
    - name: "premium_amenity_count"
      expr: SUM(CASE WHEN is_premium_amenity = TRUE THEN 1 ELSE 0 END)
      comment: "Count of premium amenity records. Measures premium product coverage across the room portfolio."
    - name: "ada_compliant_amenity_count"
      expr: SUM(CASE WHEN is_ada_compliant = TRUE THEN 1 ELSE 0 END)
      comment: "Count of ADA-compliant amenities. Tracks accessibility compliance in the amenity portfolio."
    - name: "distinct_vendors"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of distinct vendors supplying room amenities. Measures vendor diversification and concentration risk."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`inventory_room_block`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Group room block portfolio KPIs. Tracks contracted room nights, attrition risk, deposit compliance, and financial exposure across the group block portfolio."
  source: "`vibe_travel_hospitality_v1`.`inventory`.`room_block`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property identifier; enables property-level group block portfolio analysis."
    - name: "block_status"
      expr: block_status
      comment: "Current status of the room block (e.g., tentative, definite, cancelled); used to segment active vs. historical blocks."
    - name: "block_type"
      expr: block_type
      comment: "Type of room block (e.g., group, wholesale, crew); drives different yield and pricing strategies."
    - name: "start_date"
      expr: start_date
      comment: "Block start date; used for time-series analysis of group business on the books."
    - name: "cutoff_date"
      expr: cutoff_date
      comment: "Block cutoff date; used to identify blocks requiring release decisions."
    - name: "lra_flag"
      expr: lra_flag
      comment: "Indicates LRA commitment on this block; differentiates premium group contracts."
    - name: "overbooking_allowed_flag"
      expr: overbooking_allowed_flag
      comment: "Indicates whether overbooking is permitted on this block; used to assess walk risk."
    - name: "deposit_required_flag"
      expr: deposit_required_flag
      comment: "Indicates whether a deposit is required; used to track financial commitment compliance."
    - name: "booking_source"
      expr: booking_source
      comment: "Source of the group booking; enables channel-level group business analysis."
  measures:
    - name: "total_attrition_penalty_amount"
      expr: SUM(CAST(attrition_penalty_amount AS DOUBLE))
      comment: "Total attrition penalty exposure across room blocks. Measures financial risk from underperforming group contracts; drives proactive pickup management."
    - name: "avg_attrition_percentage"
      expr: AVG(CAST(attrition_percentage AS DOUBLE))
      comment: "Average attrition percentage across blocks. Indicates how much contracted inventory is at risk of not being picked up."
    - name: "total_deposit_amount"
      expr: SUM(CAST(deposit_amount AS DOUBLE))
      comment: "Total deposit amount collected or due across room blocks. Tracks financial commitment and cash flow from group business."
    - name: "avg_negotiated_rate_amount"
      expr: AVG(CAST(negotiated_rate_amount AS DOUBLE))
      comment: "Average negotiated rate across room blocks. Benchmarks group pricing against transient and market rates."
    - name: "avg_commission_percentage"
      expr: AVG(CAST(commission_percentage AS DOUBLE))
      comment: "Average commission percentage on room blocks. Measures cost of distribution for group business."
    - name: "total_room_blocks"
      expr: COUNT(1)
      comment: "Total number of room block records. Baseline measure for group business volume."
    - name: "definite_block_count"
      expr: SUM(CASE WHEN block_status = 'definite' THEN 1 ELSE 0 END)
      comment: "Count of definite (confirmed) room blocks. Measures committed group business on the books."
    - name: "tentative_block_count"
      expr: SUM(CASE WHEN block_status = 'tentative' THEN 1 ELSE 0 END)
      comment: "Count of tentative room blocks. Measures pipeline group business requiring conversion or release decisions."
    - name: "avg_pickup_percentage"
      expr: AVG(CAST(pickup_percentage AS DOUBLE))
      comment: "Average pickup percentage across room blocks. Core group utilization KPI; low values trigger attrition clause enforcement."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`inventory_room_material_installation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Room material installation and lifecycle metrics. Tracks installed materials, replacement schedules, and maintenance costs to support capital planning and PIP (Property Improvement Plan) execution."
  source: "`vibe_travel_hospitality_v1`.`inventory`.`room_material_installation`"
  dimensions:
    - name: "condition_status"
      expr: condition_status
      comment: "Current condition status of the installed material — used to prioritize replacement and maintenance decisions."
    - name: "installation_date"
      expr: installation_date
      comment: "Date of material installation — used for age analysis and replacement cycle planning."
    - name: "next_scheduled_replacement_date"
      expr: next_scheduled_replacement_date
      comment: "Next scheduled replacement date — used for capital expenditure planning and PIP scheduling."
  measures:
    - name: "total_installations"
      expr: COUNT(1)
      comment: "Total room material installation records. Baseline metric for installed asset inventory coverage."
    - name: "total_installation_cost"
      expr: SUM(CAST(unit_cost_at_installation AS DOUBLE))
      comment: "Total cost of all room material installations. Capital investment metric — used by asset managers and ownership to track total FF&E investment value."
    - name: "avg_unit_cost_at_installation"
      expr: AVG(CAST(unit_cost_at_installation AS DOUBLE))
      comment: "Average unit cost at time of installation. Benchmarking metric — used to compare material investment levels across properties and room types."
    - name: "total_quantity_installed"
      expr: SUM(CAST(quantity_installed AS DOUBLE))
      comment: "Total quantity of materials installed across rooms. Asset volume metric — used for inventory planning and bulk procurement decisions."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`inventory_room_status`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Real-time room status KPIs tracking occupancy, housekeeping efficiency, and discrepancy rates. Core operational dashboard for front office and housekeeping management."
  source: "`vibe_travel_hospitality_v1`.`inventory`.`room_status`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property identifier; enables property-level room status analysis."
    - name: "occupancy_status"
      expr: occupancy_status
      comment: "Occupancy status of the room (e.g., occupied, vacant, due-out); core front office operational dimension."
    - name: "housekeeping_status"
      expr: housekeeping_status
      comment: "Housekeeping status (e.g., clean, dirty, inspected); used to analyze room readiness and cleaning efficiency."
    - name: "front_desk_status"
      expr: front_desk_status
      comment: "Front desk status of the room; used to analyze front office operational efficiency."
    - name: "maintenance_status"
      expr: maintenance_status
      comment: "Maintenance status of the room; used to track rooms awaiting maintenance clearance."
    - name: "is_out_of_order"
      expr: is_out_of_order
      comment: "Indicates whether the room is out of order; used to measure unavailable inventory."
    - name: "discrepancy_flag"
      expr: discrepancy_flag
      comment: "Indicates a status discrepancy between housekeeping and front desk; used to measure reconciliation quality."
    - name: "expected_checkin_date"
      expr: expected_checkin_date
      comment: "Expected check-in date; used to analyze room readiness by arrival date."
  measures:
    - name: "total_room_status_records"
      expr: COUNT(1)
      comment: "Total number of room status records. Baseline measure for room status tracking volume."
    - name: "occupied_room_count"
      expr: SUM(CASE WHEN occupancy_status = 'occupied' THEN 1 ELSE 0 END)
      comment: "Count of rooms currently occupied. Core occupancy KPI for front office operations."
    - name: "clean_room_count"
      expr: SUM(CASE WHEN is_clean = TRUE THEN 1 ELSE 0 END)
      comment: "Count of rooms that are clean and ready. Measures housekeeping throughput and room readiness for check-in."
    - name: "inspected_room_count"
      expr: SUM(CASE WHEN is_inspected = TRUE THEN 1 ELSE 0 END)
      comment: "Count of rooms that have been inspected. Measures quality control coverage in housekeeping operations."
    - name: "out_of_order_room_count"
      expr: SUM(CASE WHEN is_out_of_order = TRUE THEN 1 ELSE 0 END)
      comment: "Count of rooms currently out of order. Measures unavailable inventory impacting sellable capacity."
    - name: "discrepancy_room_count"
      expr: SUM(CASE WHEN discrepancy_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of rooms with status discrepancies. Measures reconciliation quality between housekeeping and front desk; high counts signal operational process failures."
    - name: "blocked_room_count"
      expr: SUM(CASE WHEN is_blocked = TRUE THEN 1 ELSE 0 END)
      comment: "Count of rooms currently blocked. Measures inventory held back from general sale."
    - name: "do_not_disturb_room_count"
      expr: SUM(CASE WHEN do_not_disturb_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of rooms with DND flag active. Operational metric for housekeeping scheduling and guest service management."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`inventory_room_type`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Room type portfolio KPIs tracking sellable inventory composition, ADA compliance, and suite/premium mix. Informs product strategy and revenue mix optimization."
  source: "`vibe_travel_hospitality_v1`.`inventory`.`room_type`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property identifier; enables property-level room type portfolio analysis."
    - name: "room_class"
      expr: room_class
      comment: "Room class (e.g., standard, deluxe, suite); enables class-level revenue mix analysis."
    - name: "rate_category"
      expr: rate_category
      comment: "Rate category of the room type; enables rate-tier-level portfolio analysis."
    - name: "active_status"
      expr: active_status
      comment: "Active status of the room type; used to filter sellable vs. inactive room types."
    - name: "is_suite"
      expr: is_suite
      comment: "Indicates whether the room type is a suite; enables premium inventory mix analysis."
    - name: "is_ada_compliant"
      expr: is_ada_compliant
      comment: "Indicates ADA compliance; used to track accessible inventory coverage."
    - name: "sellable_flag"
      expr: sellable_flag
      comment: "Indicates whether the room type is currently sellable; used to measure active inventory."
    - name: "lra_eligible"
      expr: lra_eligible
      comment: "Indicates LRA eligibility; used to track LRA-committed inventory."
    - name: "view_category"
      expr: view_category
      comment: "View category (e.g., ocean view, city view); enables premium view inventory analysis."
  measures:
    - name: "total_room_types"
      expr: COUNT(1)
      comment: "Total number of room type records. Baseline measure for inventory product portfolio size."
    - name: "sellable_room_type_count"
      expr: SUM(CASE WHEN sellable_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of sellable room types. Measures active inventory product availability."
    - name: "suite_room_type_count"
      expr: SUM(CASE WHEN is_suite = TRUE THEN 1 ELSE 0 END)
      comment: "Count of suite room types. Measures premium inventory mix; suites drive disproportionate ADR and revenue."
    - name: "ada_compliant_room_type_count"
      expr: SUM(CASE WHEN is_ada_compliant = TRUE THEN 1 ELSE 0 END)
      comment: "Count of ADA-compliant room types. Tracks accessible inventory coverage for compliance and inclusivity reporting."
    - name: "avg_square_footage"
      expr: AVG(CAST(square_footage AS DOUBLE))
      comment: "Average square footage across room types. Informs product positioning and rate strategy by room size."
    - name: "lra_eligible_room_type_count"
      expr: SUM(CASE WHEN lra_eligible = TRUE THEN 1 ELSE 0 END)
      comment: "Count of LRA-eligible room types. Measures the scope of LRA commitment exposure in the inventory portfolio."
    - name: "distinct_properties_with_room_types"
      expr: COUNT(DISTINCT property_id)
      comment: "Number of distinct properties with room type records. Measures portfolio coverage."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`inventory_room_type_competitive_benchmark`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Room type competitive benchmarking KPIs tracking benchmark weight, rate shop frequency, and competitive set coverage. Informs revenue management competitive positioning strategy."
  source: "`vibe_travel_hospitality_v1`.`inventory`.`room_type_competitive_benchmark`"
  dimensions:
    - name: "inventory_room_type_id"
      expr: inventory_room_type_id
      comment: "Room type identifier; enables room-type-level competitive benchmark analysis."
    - name: "revenue_competitive_set_id"
      expr: revenue_competitive_set_id
      comment: "Competitive set identifier; enables competitive-set-level benchmark analysis."
    - name: "benchmark_room_type_category"
      expr: benchmark_room_type_category
      comment: "Category of the benchmark room type; enables category-level competitive positioning analysis."
    - name: "room_type_competitive_benchmark_status"
      expr: room_type_competitive_benchmark_status
      comment: "Status of the benchmark record; used to filter active vs. expired benchmarks."
    - name: "is_primary_comp_category"
      expr: is_primary_comp_category
      comment: "Indicates whether this is the primary competitive category; used to focus analysis on primary benchmarks."
    - name: "effective_date"
      expr: effective_date
      comment: "Effective date of the benchmark; used for time-series analysis of competitive positioning."
  measures:
    - name: "avg_benchmark_weight"
      expr: AVG(CAST(benchmark_weight AS DOUBLE))
      comment: "Average benchmark weight assigned to competitive room type categories. Measures how competitive set weighting is distributed; informs index calculation methodology."
    - name: "total_benchmark_records"
      expr: COUNT(1)
      comment: "Total number of competitive benchmark records. Baseline measure for competitive intelligence coverage."
    - name: "primary_comp_category_count"
      expr: SUM(CASE WHEN is_primary_comp_category = TRUE THEN 1 ELSE 0 END)
      comment: "Count of primary competitive category benchmarks. Measures the core competitive set used for rate indexing."
    - name: "distinct_competitive_sets"
      expr: COUNT(DISTINCT revenue_competitive_set_id)
      comment: "Number of distinct competitive sets with benchmark records. Measures breadth of competitive intelligence coverage."
    - name: "distinct_room_types_benchmarked"
      expr: COUNT(DISTINCT inventory_room_type_id)
      comment: "Number of distinct room types with competitive benchmarks. Measures depth of competitive rate shop coverage."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`inventory_room_type_promotion`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Room type promotion performance metrics. Tracks promotional rate activity, inventory allocation, and booking volumes to evaluate promotion effectiveness and loyalty program integration."
  source: "`vibe_travel_hospitality_v1`.`inventory`.`room_type_promotion`"
  dimensions:
    - name: "active_status"
      expr: active_status
      comment: "Current active status of the room type promotion — used to filter live vs. expired promotions."
    - name: "booking_window_start_date"
      expr: booking_window_start_date
      comment: "Start of the booking window for the promotion — used for promotional calendar analysis."
    - name: "booking_window_end_date"
      expr: booking_window_end_date
      comment: "End of the booking window for the promotion — used to identify expiring promotions."
  measures:
    - name: "total_promotions"
      expr: COUNT(1)
      comment: "Total room type promotion records. Baseline metric for promotional activity volume."
    - name: "avg_promotional_rate_amount"
      expr: AVG(CAST(promotional_rate_amount AS DOUBLE))
      comment: "Average promotional rate amount across room type promotions. Rate strategy metric — used to assess the depth of promotional discounting and its impact on ADR."
    - name: "avg_bonus_points_multiplier"
      expr: AVG(CAST(bonus_points_multiplier AS DOUBLE))
      comment: "Average bonus points multiplier for room type promotions. Loyalty program investment metric — used to evaluate the cost of loyalty-linked promotional incentives."
    - name: "active_promotions"
      expr: COUNT(CASE WHEN active_status = 'ACTIVE' THEN 1 END)
      comment: "Number of currently active room type promotions. Operational metric — used to track live promotional inventory and ensure promotions are properly managed."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`inventory_room_type_vendor_supply`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Room Type Vendor Supply business metrics"
  source: "`travel_hospitality_ecm`.`inventory`.`room_type_vendor_supply`"
  dimensions:
    - name: "Active Status"
      expr: active_status
    - name: "Contract Effective Date"
      expr: contract_effective_date
    - name: "Contract Expiry Date"
      expr: contract_expiry_date
    - name: "Created Date"
      expr: created_date
    - name: "Last Order Date"
      expr: last_order_date
    - name: "Last Updated Date"
      expr: last_updated_date
    - name: "Lead Time Days"
      expr: lead_time_days
    - name: "Minimum Order Quantity"
      expr: minimum_order_quantity
    - name: "Preferred Vendor Flag"
      expr: preferred_vendor_flag
    - name: "Supply Category"
      expr: supply_category
    - name: "Contract Effective Date Month"
      expr: DATE_TRUNC('MONTH', contract_effective_date)
    - name: "Contract Expiry Date Month"
      expr: DATE_TRUNC('MONTH', contract_expiry_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Room Type Vendor Supply"
      expr: COUNT(DISTINCT room_type_vendor_supply_id)
    - name: "Total Negotiated Discount Percent"
      expr: SUM(negotiated_discount_percent)
    - name: "Average Negotiated Discount Percent"
      expr: AVG(negotiated_discount_percent)
    - name: "Total Total Spend Amount"
      expr: SUM(total_spend_amount)
    - name: "Average Total Spend Amount"
      expr: AVG(total_spend_amount)
$$;
