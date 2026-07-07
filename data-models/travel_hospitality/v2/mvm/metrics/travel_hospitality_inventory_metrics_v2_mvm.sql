-- Metric views for domain: inventory | Business: Travel_Hospitality | Version: 2 | Generated on: 2026-06-27 02:47:23

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`inventory_availability_snapshot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Daily availability health metrics per property and room type. Tracks occupancy rate, stop-sell exposure, and overbooking risk to support revenue management decisions."
  source: "`vibe_travel_hospitality_v1`.`inventory`.`availability_snapshot`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property identifier — primary grouping dimension for all availability KPIs."
    - name: "room_type_id"
      expr: room_type_id
      comment: "Room type identifier — enables occupancy analysis by room category."
    - name: "snapshot_date"
      expr: snapshot_date
      comment: "Date of the availability snapshot — used for daily trend analysis."
    - name: "snapshot_month"
      expr: DATE_TRUNC('MONTH', snapshot_date)
      comment: "Month bucket of the snapshot date — supports monthly occupancy trend reporting."
    - name: "stop_sell_flag"
      expr: stop_sell_flag
      comment: "Indicates whether the room type is closed for new bookings — key revenue risk signal."
    - name: "closed_to_arrival_flag"
      expr: closed_to_arrival_flag
      comment: "Indicates whether arrivals are blocked for this room type on the snapshot date."
    - name: "closed_to_departure_flag"
      expr: closed_to_departure_flag
      comment: "Indicates whether departures are blocked for this room type on the snapshot date."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status of the snapshot record — used to filter or flag unreconciled data."
    - name: "lra_flag"
      expr: lra_flag
      comment: "Last Room Available flag — indicates whether the last available room is being sold."
  measures:
    - name: "avg_occupancy_rate"
      expr: AVG(CAST(occ_rate AS DOUBLE))
      comment: "Average occupancy rate across snapshots. Core KPI for revenue management — executives use this to assess demand fill and pricing strategy effectiveness."
    - name: "max_occupancy_rate"
      expr: MAX(CAST(occ_rate AS DOUBLE))
      comment: "Peak occupancy rate observed in the period. Identifies demand spikes that may require overbooking or rate adjustment decisions."
    - name: "min_occupancy_rate"
      expr: MIN(CAST(occ_rate AS DOUBLE))
      comment: "Lowest occupancy rate observed in the period. Identifies demand troughs that may trigger promotional or yield management interventions."
    - name: "stop_sell_snapshot_count"
      expr: COUNT(CASE WHEN stop_sell_flag = TRUE THEN 1 END)
      comment: "Number of snapshots where stop-sell was active. High counts signal aggressive inventory restriction that may be suppressing revenue."
    - name: "closed_to_arrival_snapshot_count"
      expr: COUNT(CASE WHEN closed_to_arrival_flag = TRUE THEN 1 END)
      comment: "Number of snapshots with closed-to-arrival restrictions. Tracks how often arrival restrictions are applied, impacting booking pace."
    - name: "lra_snapshot_count"
      expr: COUNT(CASE WHEN lra_flag = TRUE THEN 1 END)
      comment: "Number of snapshots where Last Room Available was active. Indicates near-sellout conditions requiring immediate revenue management attention."
    - name: "total_snapshots"
      expr: COUNT(1)
      comment: "Total number of availability snapshot records. Baseline denominator for rate calculations and data completeness checks."
    - name: "stop_sell_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN stop_sell_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of snapshots with stop-sell active. Executives use this to gauge how aggressively inventory is being restricted relative to total availability."
    - name: "lra_activation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN lra_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of snapshots where Last Room Available was triggered. High rates indicate sustained near-capacity conditions and potential revenue upside from dynamic pricing."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`inventory_control`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory control and yield management KPIs per property, room type, and channel. Tracks hurdle rates, overbooking limits, channel allocation, and competitive positioning to support revenue strategy decisions."
  source: "`vibe_travel_hospitality_v1`.`inventory`.`control`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property identifier — primary grouping dimension for control record analysis."
    - name: "room_type_id"
      expr: room_type_id
      comment: "Room type identifier — enables yield control analysis by room category."
    - name: "channel_id"
      expr: channel_id
      comment: "Distribution channel identifier — supports channel allocation and performance analysis."
    - name: "stay_date"
      expr: stay_date
      comment: "Stay date the control record applies to — used for forward-looking inventory control analysis."
    - name: "stay_month"
      expr: DATE_TRUNC('MONTH', stay_date)
      comment: "Month bucket of the stay date — supports monthly yield strategy review."
    - name: "control_status"
      expr: control_status
      comment: "Current status of the control record (e.g., active, expired) — used to filter actionable controls."
    - name: "stop_sell_flag"
      expr: stop_sell_flag
      comment: "Indicates whether stop-sell is active on this control record."
    - name: "cta_flag"
      expr: cta_flag
      comment: "Closed-to-arrival flag on the control record — restricts new arrivals for the stay date."
    - name: "ctd_flag"
      expr: ctd_flag
      comment: "Closed-to-departure flag on the control record — restricts departures for the stay date."
    - name: "lra_flag"
      expr: lra_flag
      comment: "Last Room Available flag on the control record — signals near-sellout inventory state."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which rate and revenue figures are denominated."
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for the control action — supports audit and strategy review."
  measures:
    - name: "avg_hurdle_rate"
      expr: AVG(CAST(hurdle_rate AS DOUBLE))
      comment: "Average hurdle rate across control records. The hurdle rate is the minimum acceptable ADR for accepting a booking — a core yield management lever executives monitor to protect revenue quality."
    - name: "avg_overbooking_limit_pct"
      expr: AVG(CAST(overbooking_limit_pct AS DOUBLE))
      comment: "Average overbooking limit percentage. Tracks how aggressively the property is overselling inventory — directly tied to walk risk and guest satisfaction outcomes."
    - name: "avg_channel_allocation_pct"
      expr: AVG(CAST(channel_allocation_pct AS DOUBLE))
      comment: "Average channel allocation percentage. Measures how inventory is distributed across channels — informs channel mix optimization and direct booking strategy."
    - name: "avg_competitive_set_adr"
      expr: AVG(CAST(competitive_set_adr AS DOUBLE))
      comment: "Average ADR of the competitive set as captured in control records. Used to benchmark the property's pricing position against the market."
    - name: "avg_rgi_target"
      expr: AVG(CAST(rgi_target AS DOUBLE))
      comment: "Average Revenue Generation Index target. Tracks the property's targeted market share of revenue — a strategic KPI for competitive positioning."
    - name: "stop_sell_control_count"
      expr: COUNT(CASE WHEN stop_sell_flag = TRUE THEN 1 END)
      comment: "Number of control records with stop-sell active. High counts indicate aggressive inventory restriction that may be suppressing revenue on high-demand dates."
    - name: "active_control_count"
      expr: COUNT(CASE WHEN control_status = 'ACTIVE' THEN 1 END)
      comment: "Number of currently active control records. Baseline measure for understanding the scope of active yield management interventions."
    - name: "total_control_records"
      expr: COUNT(1)
      comment: "Total number of inventory control records. Baseline denominator for rate and ratio calculations."
    - name: "hurdle_rate_vs_comp_set_gap"
      expr: AVG(CAST(hurdle_rate AS DOUBLE) - CAST(competitive_set_adr AS DOUBLE))
      comment: "Average gap between the property hurdle rate and competitive set ADR. Positive values indicate the property is pricing above the comp set floor; negative values signal potential revenue leakage or aggressive discounting."
    - name: "stop_sell_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN stop_sell_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of control records with stop-sell active. Executives use this to assess how broadly inventory restrictions are applied across the portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`inventory_los_restriction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Length-of-stay restriction KPIs per property, room type, channel, and market segment. Tracks restriction coverage, occupancy and ADR thresholds, and override patterns to support demand management decisions."
  source: "`vibe_travel_hospitality_v1`.`inventory`.`los_restriction`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property identifier — primary grouping dimension for LOS restriction analysis."
    - name: "room_type_id"
      expr: room_type_id
      comment: "Room type identifier — enables LOS restriction analysis by room category."
    - name: "channel_id"
      expr: channel_id
      comment: "Distribution channel identifier — supports channel-specific LOS restriction analysis."
    - name: "market_segment_id"
      expr: market_segment_id
      comment: "Market segment identifier — enables segment-level LOS restriction strategy review."
    - name: "stay_date"
      expr: stay_date
      comment: "Stay date the LOS restriction applies to — used for forward-looking restriction analysis."
    - name: "stay_month"
      expr: DATE_TRUNC('MONTH', stay_date)
      comment: "Month bucket of the stay date — supports monthly restriction trend reporting."
    - name: "restriction_type"
      expr: restriction_type
      comment: "Type of LOS restriction (e.g., MinLOS, MaxLOS, FullPattern) — key dimension for restriction strategy analysis."
    - name: "restriction_status"
      expr: restriction_status
      comment: "Current status of the restriction record — used to filter active vs. expired restrictions."
    - name: "lra_flag"
      expr: lra_flag
      comment: "Last Room Available flag on the restriction — indicates near-sellout conditions."
    - name: "group_block_exempt_flag"
      expr: group_block_exempt_flag
      comment: "Indicates whether group blocks are exempt from this LOS restriction."
    - name: "revenue_strategy_code"
      expr: revenue_strategy_code
      comment: "Revenue strategy code driving the restriction — links restrictions to strategic intent."
    - name: "day_of_week_pattern"
      expr: day_of_week_pattern
      comment: "Day-of-week pattern the restriction applies to — supports day-of-week demand analysis."
  measures:
    - name: "avg_occ_threshold_pct"
      expr: AVG(CAST(occ_threshold_percent AS DOUBLE))
      comment: "Average occupancy threshold that triggers LOS restrictions. Executives use this to understand how aggressively restrictions are set relative to demand levels."
    - name: "avg_adr_threshold_amount"
      expr: AVG(CAST(adr_threshold_amount AS DOUBLE))
      comment: "Average ADR threshold for LOS restriction activation. Tracks the minimum rate floor below which restrictions are applied to protect revenue quality."
    - name: "avg_revpar_threshold_amount"
      expr: AVG(CAST(revpar_threshold_amount AS DOUBLE))
      comment: "Average RevPAR threshold for LOS restriction activation. RevPAR is the primary hotel performance KPI — this threshold directly governs revenue protection strategy."
    - name: "total_active_restrictions"
      expr: COUNT(CASE WHEN restriction_status = 'ACTIVE' THEN 1 END)
      comment: "Total number of active LOS restrictions. High counts indicate broad demand management activity — a leading indicator of high-demand periods or revenue protection campaigns."
    - name: "total_restrictions"
      expr: COUNT(1)
      comment: "Total number of LOS restriction records. Baseline denominator for restriction rate calculations."
    - name: "override_required_restriction_count"
      expr: COUNT(CASE WHEN override_reason_required_flag = TRUE THEN 1 END)
      comment: "Number of restrictions requiring override justification. Tracks governance compliance — high counts indicate tightly controlled inventory requiring management approval to bypass."
    - name: "active_restriction_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN restriction_status = 'ACTIVE' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of LOS restrictions currently active. Executives use this to gauge the breadth of demand management interventions across the portfolio."
    - name: "lra_restriction_count"
      expr: COUNT(CASE WHEN lra_flag = TRUE THEN 1 END)
      comment: "Number of LOS restrictions with Last Room Available active. Indicates near-sellout conditions where LOS restrictions are being used to optimize the final inventory."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`inventory_room`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Physical room inventory KPIs per property and room type. Tracks room condition, ADA compliance, overbooking eligibility, and renovation age to support asset management and capital planning decisions."
  source: "`vibe_travel_hospitality_v1`.`inventory`.`room`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property identifier — primary grouping dimension for room inventory analysis."
    - name: "room_type_id"
      expr: room_type_id
      comment: "Room type identifier — enables room inventory analysis by category."
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the room (e.g., active, OOO, OOS) — key dimension for sellable inventory analysis."
    - name: "front_office_status"
      expr: front_office_status
      comment: "Front office status of the room — used for real-time inventory and check-in management."
    - name: "housekeeping_status"
      expr: housekeeping_status
      comment: "Housekeeping status of the room — used for operational readiness analysis."
    - name: "bed_type"
      expr: bed_type
      comment: "Bed configuration of the room — used for demand mix and inventory composition analysis."
    - name: "view_type"
      expr: view_type
      comment: "View type of the room (e.g., ocean, city, garden) — used for premium inventory segmentation."
    - name: "ada_accessible"
      expr: ada_accessible
      comment: "Indicates whether the room is ADA accessible — used for compliance and accessibility inventory reporting."
    - name: "overbooking_eligible"
      expr: overbooking_eligible
      comment: "Indicates whether the room is eligible for overbooking — used in yield management strategy."
    - name: "lra_eligible"
      expr: lra_eligible
      comment: "Indicates whether the room is eligible for Last Room Available selling — used in LRA strategy analysis."
    - name: "smoking_allowed"
      expr: smoking_allowed
      comment: "Indicates whether smoking is permitted in the room — used for inventory segmentation and policy compliance."
    - name: "floor_number"
      expr: floor_number
      comment: "Floor number of the room — used for location-based inventory analysis."
    - name: "building_code"
      expr: building_code
      comment: "Building code of the room — used for multi-building property inventory analysis."
  measures:
    - name: "total_rooms"
      expr: COUNT(1)
      comment: "Total number of physical rooms in inventory. Baseline denominator for all room-level rate and ratio calculations — fundamental to capacity planning."
    - name: "total_distinct_properties"
      expr: COUNT(DISTINCT property_id)
      comment: "Number of distinct properties represented in the room inventory. Used for portfolio-level capacity benchmarking."
    - name: "ada_accessible_room_count"
      expr: COUNT(CASE WHEN ada_accessible = TRUE THEN 1 END)
      comment: "Number of ADA-accessible rooms. Tracks compliance with accessibility requirements — a regulatory and brand standard KPI."
    - name: "ada_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN ada_accessible = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of rooms that are ADA accessible. Executives use this to assess portfolio-wide accessibility compliance and identify properties at regulatory risk."
    - name: "overbooking_eligible_room_count"
      expr: COUNT(CASE WHEN overbooking_eligible = TRUE THEN 1 END)
      comment: "Number of rooms eligible for overbooking. Defines the maximum overbooking capacity — a critical input to yield management strategy."
    - name: "overbooking_eligible_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN overbooking_eligible = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of rooms eligible for overbooking. Tracks the breadth of overbooking strategy across the portfolio."
    - name: "avg_ffe_condition_score"
      expr: AVG(CAST(ffe_condition_score AS DOUBLE))
      comment: "Average Furniture, Fixtures & Equipment condition score. A leading indicator of renovation need — low scores signal capital investment requirements that affect room quality and guest satisfaction."
    - name: "avg_square_footage"
      expr: AVG(CAST(square_footage AS DOUBLE))
      comment: "Average room square footage. Used for product positioning, rate benchmarking, and premium inventory identification."
    - name: "lra_eligible_room_count"
      expr: COUNT(CASE WHEN lra_eligible = TRUE THEN 1 END)
      comment: "Number of rooms eligible for Last Room Available selling. Defines the LRA inventory pool — a key input to rate strategy for high-demand periods."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`inventory_room_block`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Group and corporate room block KPIs per property, room type, and channel. Tracks pickup performance, attrition risk, commission exposure, and block utilization to support group sales and revenue management decisions."
  source: "`vibe_travel_hospitality_v1`.`inventory`.`room_block`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property identifier — primary grouping dimension for room block analysis."
    - name: "room_type_id"
      expr: room_type_id
      comment: "Room type identifier — enables block analysis by room category."
    - name: "channel_id"
      expr: channel_id
      comment: "Distribution channel identifier — supports channel-level block performance analysis."
    - name: "market_segment_id"
      expr: market_segment_id
      comment: "Market segment identifier — enables segment-level block strategy review."
    - name: "block_type"
      expr: block_type
      comment: "Type of room block (e.g., group, corporate, wholesale) — key dimension for block portfolio analysis."
    - name: "block_status"
      expr: block_status
      comment: "Current status of the block (e.g., tentative, definite, cancelled) — used to filter actionable blocks."
    - name: "start_date"
      expr: start_date
      comment: "Block start date — used for forward-looking group business analysis."
    - name: "start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month bucket of the block start date — supports monthly group pace reporting."
    - name: "cutoff_date"
      expr: cutoff_date
      comment: "Block cutoff date — used to identify blocks approaching release deadlines."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which block financial figures are denominated."
    - name: "overbooking_allowed_flag"
      expr: overbooking_allowed_flag
      comment: "Indicates whether overbooking is permitted on this block — used in yield management analysis."
    - name: "lra_flag"
      expr: lra_flag
      comment: "Last Room Available flag on the block — indicates near-sellout conditions."
    - name: "deposit_required_flag"
      expr: deposit_required_flag
      comment: "Indicates whether a deposit is required for this block — used for cash flow and risk management analysis."
  measures:
    - name: "avg_pickup_percentage"
      expr: AVG(CAST(pickup_percentage AS DOUBLE))
      comment: "Average block pickup percentage. The primary group block performance KPI — measures how much of the contracted block has been consumed. Low pickup signals attrition risk."
    - name: "avg_attrition_percentage"
      expr: AVG(CAST(attrition_percentage AS DOUBLE))
      comment: "Average attrition percentage across blocks. Tracks the contractual attrition threshold — blocks approaching this threshold trigger penalty clauses and revenue risk."
    - name: "total_attrition_penalty_amount"
      expr: SUM(CAST(attrition_penalty_amount AS DOUBLE))
      comment: "Total attrition penalty amounts across blocks. Directly quantifies the financial exposure from underperforming group blocks — a key revenue risk KPI."
    - name: "avg_negotiated_rate_amount"
      expr: AVG(CAST(negotiated_rate_amount AS DOUBLE))
      comment: "Average negotiated rate for room blocks. Used to benchmark group pricing against transient rates and assess revenue quality of the group segment."
    - name: "avg_commission_percentage"
      expr: AVG(CAST(commission_percentage AS DOUBLE))
      comment: "Average commission percentage on room blocks. Tracks distribution cost for group business — high commissions erode net revenue and inform channel strategy."
    - name: "total_deposit_amount"
      expr: SUM(CAST(deposit_amount AS DOUBLE))
      comment: "Total deposit amounts collected or due across blocks. Tracks cash flow from group business and financial commitment levels."
    - name: "total_blocks"
      expr: COUNT(1)
      comment: "Total number of room block records. Baseline measure for group business volume and pace analysis."
    - name: "definite_block_count"
      expr: COUNT(CASE WHEN block_status = 'DEFINITE' THEN 1 END)
      comment: "Number of definite (confirmed) room blocks. Tracks committed group business on the books — a key input to demand forecasting and inventory allocation."
    - name: "tentative_block_count"
      expr: COUNT(CASE WHEN block_status = 'TENTATIVE' THEN 1 END)
      comment: "Number of tentative room blocks. Tracks the group sales pipeline — conversion of tentative to definite is a key group sales performance metric."
    - name: "cancelled_block_count"
      expr: COUNT(CASE WHEN block_status = 'CANCELLED' THEN 1 END)
      comment: "Number of cancelled room blocks. Tracks group business attrition — high cancellation counts signal demand weakness or sales execution issues."
    - name: "block_conversion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN block_status = 'DEFINITE' THEN 1 END) / NULLIF(COUNT(CASE WHEN block_status IN ('DEFINITE', 'TENTATIVE') THEN 1 END), 0), 2)
      comment: "Percentage of definite blocks out of all definite and tentative blocks. Measures group sales conversion effectiveness — a key group sales team performance KPI."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`inventory_room_status`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Real-time room status KPIs per property and room. Tracks occupancy, housekeeping readiness, discrepancy rates, and maintenance status to support front office and operations management decisions."
  source: "`vibe_travel_hospitality_v1`.`inventory`.`room_status`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property identifier — primary grouping dimension for room status analysis."
    - name: "room_id"
      expr: room_id
      comment: "Room identifier — enables room-level status drill-down."
    - name: "occupancy_status"
      expr: occupancy_status
      comment: "Current occupancy status of the room (e.g., occupied, vacant) — core dimension for front office operations."
    - name: "housekeeping_status"
      expr: housekeeping_status
      comment: "Current housekeeping status (e.g., clean, dirty, inspected) — used for operational readiness analysis."
    - name: "front_desk_status"
      expr: front_desk_status
      comment: "Front desk view of room status — used for check-in and assignment operations."
    - name: "maintenance_status"
      expr: maintenance_status
      comment: "Current maintenance status of the room — used for asset management and OOO tracking."
    - name: "is_out_of_order"
      expr: is_out_of_order
      comment: "Indicates whether the room is currently out of order — key dimension for sellable inventory analysis."
    - name: "is_blocked"
      expr: is_blocked
      comment: "Indicates whether the room is currently blocked — used for inventory availability analysis."
    - name: "discrepancy_flag"
      expr: discrepancy_flag
      comment: "Indicates a discrepancy between front office and housekeeping status — a key operational quality signal."
    - name: "do_not_disturb_flag"
      expr: do_not_disturb_flag
      comment: "Indicates whether the room has a Do Not Disturb request active — used for housekeeping scheduling."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level for room status resolution — used for operational triage."
    - name: "expected_checkin_date"
      expr: expected_checkin_date
      comment: "Expected check-in date — used for arrival readiness analysis."
    - name: "expected_checkout_date"
      expr: expected_checkout_date
      comment: "Expected check-out date — used for departure and turnover planning."
  measures:
    - name: "total_room_status_records"
      expr: COUNT(1)
      comment: "Total number of room status records. Baseline measure for operational coverage and data completeness."
    - name: "occupied_room_count"
      expr: COUNT(CASE WHEN occupancy_status = 'OCCUPIED' THEN 1 END)
      comment: "Number of rooms currently occupied. Core operational KPI for front office — directly drives real-time occupancy reporting."
    - name: "out_of_order_room_count"
      expr: COUNT(CASE WHEN is_out_of_order = TRUE THEN 1 END)
      comment: "Number of rooms currently out of order. Tracks sellable inventory reduction — directly impacts occupancy capacity and revenue potential."
    - name: "blocked_room_count"
      expr: COUNT(CASE WHEN is_blocked = TRUE THEN 1 END)
      comment: "Number of rooms currently blocked. Tracks inventory held back from general sale — used for group and allotment management."
    - name: "clean_room_count"
      expr: COUNT(CASE WHEN is_clean = TRUE THEN 1 END)
      comment: "Number of rooms currently clean and ready. Tracks operational readiness — a key metric for front office assignment and guest check-in efficiency."
    - name: "inspected_room_count"
      expr: COUNT(CASE WHEN is_inspected = TRUE THEN 1 END)
      comment: "Number of rooms that have passed housekeeping inspection. Tracks quality assurance compliance — inspected rooms represent the highest-confidence sellable inventory."
    - name: "discrepancy_room_count"
      expr: COUNT(CASE WHEN discrepancy_flag = TRUE THEN 1 END)
      comment: "Number of rooms with a front office / housekeeping status discrepancy. Discrepancies cause check-in failures and guest complaints — a critical operational quality KPI."
    - name: "discrepancy_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN discrepancy_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of room status records with a discrepancy. Executives and operations managers use this to assess front office / housekeeping coordination quality — high rates signal systemic process failures."
    - name: "ooo_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_out_of_order = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of rooms currently out of order. Tracks the proportion of inventory unavailable for sale — a key asset management and revenue impact KPI."
    - name: "clean_readiness_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_clean = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN occupancy_status != 'OCCUPIED' THEN 1 END), 0), 2)
      comment: "Percentage of non-occupied rooms that are clean and ready. Measures housekeeping operational efficiency — low rates indicate readiness gaps that delay check-ins and reduce guest satisfaction."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`inventory_room_type`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Room type inventory composition and configuration KPIs per property. Tracks sellable inventory mix, ADA compliance, suite composition, and LRA eligibility to support product strategy and revenue management decisions."
  source: "`vibe_travel_hospitality_v1`.`inventory`.`room_type`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property identifier — primary grouping dimension for room type analysis."
    - name: "room_class"
      expr: room_class
      comment: "Room class (e.g., standard, deluxe, premium) — used for product tier analysis and rate strategy."
    - name: "rate_category"
      expr: rate_category
      comment: "Rate category of the room type — used for pricing tier and revenue mix analysis."
    - name: "bed_type"
      expr: bed_type
      comment: "Bed configuration of the room type — used for demand mix and inventory composition analysis."
    - name: "view_category"
      expr: view_category
      comment: "View category (e.g., ocean, city, garden) — used for premium inventory segmentation."
    - name: "active_status"
      expr: active_status
      comment: "Active status of the room type — used to filter sellable vs. inactive room types."
    - name: "sellable_flag"
      expr: sellable_flag
      comment: "Indicates whether the room type is currently sellable — key dimension for available inventory analysis."
    - name: "is_suite"
      expr: is_suite
      comment: "Indicates whether the room type is a suite — used for premium product mix analysis."
    - name: "is_ada_compliant"
      expr: is_ada_compliant
      comment: "Indicates whether the room type meets ADA compliance standards — used for accessibility inventory reporting."
    - name: "lra_eligible"
      expr: lra_eligible
      comment: "Indicates whether the room type is eligible for Last Room Available selling — used in LRA strategy analysis."
    - name: "overbooking_allowed"
      expr: overbooking_allowed
      comment: "Indicates whether overbooking is permitted for this room type — used in yield management strategy."
    - name: "pseudo_room_flag"
      expr: pseudo_room_flag
      comment: "Indicates whether this is a pseudo room type (virtual category) — used to exclude non-physical inventory from capacity calculations."
    - name: "segment_code"
      expr: segment_code
      comment: "Market segment code associated with the room type — used for segment-level inventory analysis."
  measures:
    - name: "total_room_types"
      expr: COUNT(1)
      comment: "Total number of room type records. Baseline measure for product portfolio breadth analysis."
    - name: "sellable_room_type_count"
      expr: COUNT(CASE WHEN sellable_flag = TRUE THEN 1 END)
      comment: "Number of sellable room types. Tracks the active product portfolio available for revenue generation — a key input to distribution and channel strategy."
    - name: "sellable_room_type_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sellable_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of room types that are sellable. Tracks the proportion of the product portfolio actively generating revenue — low rates indicate product rationalization opportunities."
    - name: "ada_compliant_room_type_count"
      expr: COUNT(CASE WHEN is_ada_compliant = TRUE THEN 1 END)
      comment: "Number of ADA-compliant room types. Tracks accessibility compliance at the product level — a regulatory and brand standard KPI."
    - name: "suite_room_type_count"
      expr: COUNT(CASE WHEN is_suite = TRUE THEN 1 END)
      comment: "Number of suite room types. Tracks premium product inventory — suites command higher ADR and are key to revenue mix optimization."
    - name: "suite_mix_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_suite = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN sellable_flag = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of sellable room types that are suites. Measures premium product depth — a key indicator of the property's ability to capture high-value demand."
    - name: "lra_eligible_room_type_count"
      expr: COUNT(CASE WHEN lra_eligible = TRUE THEN 1 END)
      comment: "Number of room types eligible for Last Room Available selling. Defines the LRA product pool — a key input to rate strategy for high-demand periods."
    - name: "avg_square_footage"
      expr: AVG(CAST(square_footage AS DOUBLE))
      comment: "Average square footage across room types. Used for product positioning, rate benchmarking, and premium inventory identification."
    - name: "overbooking_allowed_room_type_count"
      expr: COUNT(CASE WHEN overbooking_allowed = TRUE THEN 1 END)
      comment: "Number of room types where overbooking is permitted. Defines the overbooking-eligible product pool — a critical input to yield management capacity planning."
$$;