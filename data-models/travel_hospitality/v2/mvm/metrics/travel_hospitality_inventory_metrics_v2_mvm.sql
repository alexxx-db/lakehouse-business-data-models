-- Metric views for domain: inventory | Business: Travel_Hospitality | Version: 2 | Generated on: 2026-07-10 22:17:24

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`inventory_allotment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Governs allotment performance, commission economics, and release-risk KPIs across channels, room types, and corporate accounts. Enables revenue managers to evaluate allotment utilisation, commission exposure, and auto-release readiness."
  source: "`vibe_travel_hospitality_v1`.`inventory`.`allotment`"
  dimensions:
    - name: "allotment_status"
      expr: allotment_status
      comment: "Current lifecycle status of the allotment (e.g. Active, Suspended, Expired) — primary filter for operational dashboards."
    - name: "allotment_type"
      expr: allotment_type
      comment: "Classification of the allotment (e.g. Corporate, Wholesale, Tour Operator) used to segment performance by contract type."
    - name: "channel_id"
      expr: channel_id
      comment: "Distribution channel through which the allotment is sold; used to compare channel-level utilisation and commission rates."
    - name: "property_id"
      expr: property_id
      comment: "Property to which the allotment belongs; enables property-level benchmarking."
    - name: "room_type_id"
      expr: room_type_id
      comment: "Room type covered by the allotment; supports room-type yield analysis."
    - name: "corporate_account_id"
      expr: corporate_account_id
      comment: "Corporate account holding the allotment; used for account-level performance reviews."
    - name: "start_date"
      expr: start_date
      comment: "Allotment validity start date; used for time-series trending of allotment openings."
    - name: "end_date"
      expr: end_date
      comment: "Allotment validity end date; used to identify near-expiry allotments requiring action."
    - name: "freesale_enabled"
      expr: freesale_enabled
      comment: "Indicates whether the allotment operates in freesale mode, bypassing availability checks."
    - name: "auto_release_enabled"
      expr: auto_release_enabled
      comment: "Indicates whether unsold rooms are automatically released back to general inventory."
    - name: "lra_enabled"
      expr: lra_enabled
      comment: "Indicates whether Last Room Availability is enabled for this allotment."
  measures:
    - name: "total_allotments"
      expr: COUNT(1)
      comment: "Total number of allotment contracts; baseline volume metric for allotment portfolio sizing."
    - name: "active_allotments"
      expr: COUNT(CASE WHEN allotment_status = 'Active' THEN 1 END)
      comment: "Count of currently active allotments; tracks live inventory commitments requiring monitoring."
    - name: "avg_commission_rate_percent"
      expr: AVG(CAST(commission_rate_percent AS DOUBLE))
      comment: "Average commission rate across allotments; directly impacts net revenue yield and informs renegotiation decisions."
    - name: "max_commission_rate_percent"
      expr: MAX(CAST(commission_rate_percent AS DOUBLE))
      comment: "Highest commission rate in the allotment portfolio; flags outlier contracts with excessive commission exposure."
    - name: "avg_performance_threshold_percent"
      expr: AVG(CAST(performance_threshold_percent AS DOUBLE))
      comment: "Average contracted performance threshold; measures how demanding allotment contracts are relative to pickup obligations."
    - name: "allotments_with_auto_release"
      expr: COUNT(CASE WHEN auto_release_enabled = TRUE THEN 1 END)
      comment: "Number of allotments with auto-release enabled; higher counts reduce stranded inventory risk."
    - name: "allotments_with_lra"
      expr: COUNT(CASE WHEN lra_enabled = TRUE THEN 1 END)
      comment: "Number of allotments with Last Room Availability enabled; indicates premium commitment level to partners."
    - name: "freesale_allotment_count"
      expr: COUNT(CASE WHEN freesale_enabled = TRUE THEN 1 END)
      comment: "Count of freesale allotments; freesale mode bypasses availability controls and carries higher overbooking risk."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`inventory_availability_snapshot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks daily room availability health, occupancy rates, and inventory restriction flags at the property and room-type level. Core operational KPI layer for revenue management and front-office decision-making."
  source: "`vibe_travel_hospitality_v1`.`inventory`.`availability_snapshot`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property identifier; primary grouping dimension for multi-property portfolio analysis."
    - name: "room_type_id"
      expr: room_type_id
      comment: "Room type identifier; enables room-type-level availability and occupancy analysis."
    - name: "snapshot_date"
      expr: snapshot_date
      comment: "Date of the availability snapshot; primary time dimension for daily trending."
    - name: "snapshot_month"
      expr: DATE_TRUNC('MONTH', snapshot_date)
      comment: "Month-level bucketing of snapshot date for monthly occupancy trend reporting."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Status of the inventory reconciliation process; flags snapshots with unresolved discrepancies."
    - name: "stop_sell_flag"
      expr: stop_sell_flag
      comment: "Indicates whether stop-sell is active; critical operational flag for revenue managers."
    - name: "closed_to_arrival_flag"
      expr: closed_to_arrival_flag
      comment: "Indicates whether the property/room type is closed to new arrivals on this date."
    - name: "closed_to_departure_flag"
      expr: closed_to_departure_flag
      comment: "Indicates whether the property/room type is closed to departures on this date."
    - name: "lra_flag"
      expr: lra_flag
      comment: "Last Room Availability flag; indicates whether LRA obligations are active for this snapshot."
  measures:
    - name: "avg_occupancy_rate"
      expr: AVG(CAST(occ_rate AS DOUBLE))
      comment: "Average occupancy rate across snapshots; the primary KPI for measuring how effectively room inventory is being sold."
    - name: "max_occupancy_rate"
      expr: MAX(CAST(occ_rate AS DOUBLE))
      comment: "Peak occupancy rate observed; identifies high-demand periods requiring yield management intervention."
    - name: "stop_sell_days"
      expr: COUNT(CASE WHEN stop_sell_flag = TRUE THEN 1 END)
      comment: "Number of snapshot days with stop-sell active; high counts indicate aggressive yield management or chronic oversell risk."
    - name: "closed_to_arrival_days"
      expr: COUNT(CASE WHEN closed_to_arrival_flag = TRUE THEN 1 END)
      comment: "Number of days closed to arrival; measures restriction intensity and potential revenue displacement."
    - name: "snapshots_with_discrepancy"
      expr: COUNT(CASE WHEN reconciliation_status NOT IN ('Reconciled', 'Clean') THEN 1 END)
      comment: "Count of snapshots with unresolved reconciliation issues; data quality KPI that directly impacts revenue accuracy."
    - name: "total_snapshots"
      expr: COUNT(1)
      comment: "Total availability snapshot records; baseline volume metric for coverage and completeness monitoring."
    - name: "lra_active_days"
      expr: COUNT(CASE WHEN lra_flag = TRUE THEN 1 END)
      comment: "Number of snapshot days with LRA obligations active; informs partner commitment exposure."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`inventory_los_restriction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Measures the breadth, intensity, and revenue thresholds of length-of-stay restrictions across properties, channels, and room types. Enables revenue managers to evaluate restriction strategy effectiveness and compliance."
  source: "`vibe_travel_hospitality_v1`.`inventory`.`los_restriction`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property to which the LOS restriction applies; primary grouping for property-level restriction analysis."
    - name: "room_type_id"
      expr: room_type_id
      comment: "Room type subject to the restriction; enables room-type-level restriction intensity analysis."
    - name: "channel_id"
      expr: channel_id
      comment: "Distribution channel to which the restriction applies; used to compare restriction strategies by channel."
    - name: "restriction_type"
      expr: restriction_type
      comment: "Type of LOS restriction (e.g. MinLOS, MaxLOS, FullPattern); classifies restriction strategy."
    - name: "restriction_status"
      expr: restriction_status
      comment: "Current status of the restriction (e.g. Active, Inactive, Pending); filters operational vs. historical restrictions."
    - name: "stay_date"
      expr: stay_date
      comment: "Stay date to which the restriction applies; primary time dimension for restriction calendar analysis."
    - name: "stay_month"
      expr: DATE_TRUNC('MONTH', stay_date)
      comment: "Month-level bucketing of stay date for monthly restriction trend reporting."
    - name: "forecast_demand_level"
      expr: forecast_demand_level
      comment: "Demand level that triggered the restriction (e.g. High, Peak, Shoulder); links restrictions to demand strategy."
    - name: "revenue_strategy_code"
      expr: revenue_strategy_code
      comment: "Revenue strategy code associated with the restriction; enables strategy-level performance attribution."
    - name: "lra_flag"
      expr: lra_flag
      comment: "Indicates whether the restriction is LRA-exempt; critical for partner contract compliance."
    - name: "override_reason_required_flag"
      expr: override_reason_required_flag
      comment: "Indicates whether an override reason is mandatory; measures governance strictness of restriction policy."
  measures:
    - name: "total_restrictions"
      expr: COUNT(1)
      comment: "Total LOS restrictions in effect; baseline volume metric for restriction portfolio management."
    - name: "active_restrictions"
      expr: COUNT(CASE WHEN restriction_status = 'Active' THEN 1 END)
      comment: "Count of currently active LOS restrictions; measures live restriction intensity across the portfolio."
    - name: "avg_adr_threshold"
      expr: AVG(CAST(adr_threshold_amount AS DOUBLE))
      comment: "Average ADR threshold triggering LOS restrictions; indicates the rate floor at which restrictions are applied."
    - name: "avg_occ_threshold_percent"
      expr: AVG(CAST(occ_threshold_percent AS DOUBLE))
      comment: "Average occupancy threshold that triggers LOS restrictions; measures how aggressively restrictions are deployed relative to demand."
    - name: "avg_revpar_threshold"
      expr: AVG(CAST(revpar_threshold_amount AS DOUBLE))
      comment: "Average RevPAR threshold for restriction activation; directly links restriction strategy to RevPAR performance targets."
    - name: "lra_exempt_restrictions"
      expr: COUNT(CASE WHEN lra_flag = TRUE THEN 1 END)
      comment: "Count of restrictions with LRA exemption; measures the scope of partner commitments that override standard restrictions."
    - name: "group_block_exempt_restrictions"
      expr: COUNT(CASE WHEN group_block_exempt_flag = TRUE THEN 1 END)
      comment: "Count of restrictions exempt for group blocks; quantifies group business protection within the restriction strategy."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`inventory_out_of_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks financial impact, duration, and operational risk of out-of-order room events. Enables asset management and operations teams to quantify lost revenue, maintenance cost efficiency, and guest impact exposure."
  source: "`vibe_travel_hospitality_v1`.`inventory`.`out_of_order`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property where the OOO event occurred; primary grouping for property-level maintenance performance."
    - name: "ooo_status"
      expr: ooo_status
      comment: "Current status of the OOO event (e.g. Open, Closed, In Progress); filters active vs. resolved incidents."
    - name: "ooo_reason"
      expr: ooo_reason
      comment: "Reason for the room being out of order; enables root-cause analysis of maintenance patterns."
    - name: "responsible_department"
      expr: responsible_department
      comment: "Department responsible for resolving the OOO event; used for departmental accountability reporting."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority assigned to the OOO event; used to assess urgency and resource allocation."
    - name: "safety_concern_flag"
      expr: safety_concern_flag
      comment: "Indicates whether the OOO event involves a safety concern; critical risk flag for compliance and liability management."
    - name: "guest_impacted_flag"
      expr: guest_impacted_flag
      comment: "Indicates whether a guest was impacted by the OOO event; links maintenance failures to guest satisfaction risk."
    - name: "ada_compliance_flag"
      expr: ada_compliance_flag
      comment: "Indicates whether the OOO event affects ADA-compliant rooms; flags regulatory compliance exposure."
    - name: "start_date"
      expr: start_date
      comment: "Date the OOO event began; primary time dimension for maintenance trend analysis."
    - name: "start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month-level bucketing of OOO start date for monthly maintenance volume trending."
  measures:
    - name: "total_ooo_events"
      expr: COUNT(1)
      comment: "Total out-of-order events; baseline volume metric for maintenance incident management."
    - name: "total_lost_revenue_estimate"
      expr: SUM(CAST(lost_revenue_estimate AS DOUBLE))
      comment: "Total estimated revenue lost due to OOO events; the primary financial KPI for quantifying maintenance impact on top-line performance."
    - name: "avg_lost_revenue_per_event"
      expr: AVG(CAST(lost_revenue_estimate AS DOUBLE))
      comment: "Average lost revenue per OOO event; benchmarks the financial severity of individual maintenance incidents."
    - name: "total_actual_maintenance_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred for OOO resolutions; measures maintenance spend and informs capex planning."
    - name: "avg_actual_maintenance_cost"
      expr: AVG(CAST(actual_cost AS DOUBLE))
      comment: "Average actual maintenance cost per OOO event; used to benchmark cost efficiency across departments and properties."
    - name: "total_estimated_maintenance_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated maintenance cost at time of OOO creation; compared against actual cost to measure estimation accuracy."
    - name: "avg_occ_impact"
      expr: AVG(CAST(impact_on_occ AS DOUBLE))
      comment: "Average occupancy impact per OOO event; quantifies how maintenance incidents depress sellable inventory."
    - name: "avg_revpar_impact"
      expr: AVG(CAST(impact_on_revpar AS DOUBLE))
      comment: "Average RevPAR impact per OOO event; directly links maintenance failures to the hotel's primary revenue efficiency KPI."
    - name: "safety_concern_events"
      expr: COUNT(CASE WHEN safety_concern_flag = TRUE THEN 1 END)
      comment: "Count of OOO events flagged as safety concerns; critical risk metric for liability management and regulatory compliance."
    - name: "guest_impacted_events"
      expr: COUNT(CASE WHEN guest_impacted_flag = TRUE THEN 1 END)
      comment: "Count of OOO events that impacted guests; measures service failure exposure and guest satisfaction risk."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`inventory_room`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provides a strategic view of the physical room asset portfolio — condition scores, ADA compliance, feature mix, and operational status. Supports asset management, renovation planning, and sellable inventory optimisation."
  source: "`vibe_travel_hospitality_v1`.`inventory`.`room`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property to which the room belongs; primary grouping for property-level asset analysis."
    - name: "room_type_id"
      expr: room_type_id
      comment: "Room type classification; enables room-type-level asset condition and feature analysis."
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the room (e.g. Active, OOO, OOS); primary filter for sellable inventory counts."
    - name: "housekeeping_status"
      expr: housekeeping_status
      comment: "Current housekeeping status; used for operational readiness and turnaround efficiency analysis."
    - name: "front_office_status"
      expr: front_office_status
      comment: "Front office status of the room; used for real-time inventory availability management."
    - name: "bed_type"
      expr: bed_type
      comment: "Bed configuration of the room; used to analyse inventory mix and match demand preferences."
    - name: "view_type"
      expr: view_type
      comment: "View category of the room (e.g. Ocean, Garden, City); used for premium inventory segmentation."
    - name: "ada_accessible"
      expr: ada_accessible
      comment: "Indicates ADA accessibility; used for compliance reporting and accessible inventory management."
    - name: "smoking_allowed"
      expr: smoking_allowed
      comment: "Indicates whether smoking is permitted; used for inventory segmentation by guest preference."
    - name: "floor_number"
      expr: floor_number
      comment: "Floor on which the room is located; used for floor-level demand and pricing analysis."
    - name: "last_renovation_date"
      expr: last_renovation_date
      comment: "Date of last room renovation; used to identify rooms due for refurbishment."
  measures:
    - name: "total_rooms"
      expr: COUNT(1)
      comment: "Total physical room count in the portfolio; baseline asset inventory metric for capacity planning."
    - name: "sellable_rooms"
      expr: COUNT(CASE WHEN operational_status = 'Active' THEN 1 END)
      comment: "Count of rooms in active/sellable operational status; the denominator for occupancy and RevPAR calculations."
    - name: "ada_accessible_rooms"
      expr: COUNT(CASE WHEN ada_accessible = TRUE THEN 1 END)
      comment: "Count of ADA-accessible rooms; measures compliance with accessibility regulations and demand for accessible inventory."
    - name: "avg_ffe_condition_score"
      expr: AVG(CAST(ffe_condition_score AS DOUBLE))
      comment: "Average FF&E (Furniture, Fixtures & Equipment) condition score across rooms; primary asset health KPI for renovation prioritisation."
    - name: "min_ffe_condition_score"
      expr: MIN(CAST(ffe_condition_score AS DOUBLE))
      comment: "Lowest FF&E condition score in the portfolio; identifies the most deteriorated rooms requiring urgent capital investment."
    - name: "avg_square_footage"
      expr: AVG(CAST(square_footage AS DOUBLE))
      comment: "Average room size in square footage; used for product positioning and rate benchmarking against competitive set."
    - name: "overbooking_eligible_rooms"
      expr: COUNT(CASE WHEN overbooking_eligible = TRUE THEN 1 END)
      comment: "Count of rooms eligible for overbooking; informs overbooking limit-setting and walk risk management."
    - name: "lra_eligible_rooms"
      expr: COUNT(CASE WHEN lra_eligible = TRUE THEN 1 END)
      comment: "Count of rooms eligible for Last Room Availability; quantifies the scope of LRA partner commitments."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`inventory_room_block`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Measures group block performance including pickup rates, attrition risk, commission exposure, and deposit compliance. Core KPI layer for group sales, revenue management, and event contracting teams."
  source: "`vibe_travel_hospitality_v1`.`inventory`.`room_block`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property hosting the room block; primary grouping for property-level group business analysis."
    - name: "room_type_id"
      expr: room_type_id
      comment: "Room type allocated to the block; used to analyse group demand by room category."
    - name: "block_status"
      expr: block_status
      comment: "Current status of the room block (e.g. Tentative, Definite, Cancelled); primary filter for active vs. historical blocks."
    - name: "block_type"
      expr: block_type
      comment: "Type of room block (e.g. Group, Corporate, Tour); used to segment group business by category."
    - name: "channel_id"
      expr: channel_id
      comment: "Distribution channel through which the block was booked; used for channel-level group business analysis."
    - name: "corporate_account_id"
      expr: corporate_account_id
      comment: "Corporate account associated with the block; used for account-level group business performance reviews."
    - name: "start_date"
      expr: start_date
      comment: "Block arrival date; primary time dimension for group business calendar analysis."
    - name: "start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month-level bucketing of block start date for monthly group business trending."
    - name: "cutoff_date"
      expr: cutoff_date
      comment: "Cutoff date for the block; used to identify blocks approaching release deadlines."
    - name: "lra_flag"
      expr: lra_flag
      comment: "Indicates whether LRA applies to this block; flags premium commitment level."
    - name: "deposit_required_flag"
      expr: deposit_required_flag
      comment: "Indicates whether a deposit is required; used for financial risk and cash flow management."
  measures:
    - name: "total_room_blocks"
      expr: COUNT(1)
      comment: "Total room block contracts; baseline volume metric for group business portfolio management."
    - name: "definite_room_blocks"
      expr: COUNT(CASE WHEN block_status = 'Definite' THEN 1 END)
      comment: "Count of confirmed/definite room blocks; measures committed group business on the books."
    - name: "avg_pickup_percentage"
      expr: AVG(CAST(pickup_percentage AS DOUBLE))
      comment: "Average room block pickup rate; the primary KPI for group business performance — low pickup signals attrition risk."
    - name: "avg_attrition_percentage"
      expr: AVG(CAST(attrition_percentage AS DOUBLE))
      comment: "Average attrition percentage across blocks; measures the gap between contracted and picked-up room nights."
    - name: "total_attrition_penalty_amount"
      expr: SUM(CAST(attrition_penalty_amount AS DOUBLE))
      comment: "Total attrition penalty revenue; quantifies financial recovery from underperforming group blocks."
    - name: "avg_negotiated_rate"
      expr: AVG(CAST(negotiated_rate_amount AS DOUBLE))
      comment: "Average negotiated room rate for group blocks; benchmarks group pricing against rack and BAR rates."
    - name: "total_deposit_amount"
      expr: SUM(CAST(deposit_amount AS DOUBLE))
      comment: "Total deposit amounts held for room blocks; measures cash flow security from group business commitments."
    - name: "avg_commission_percentage"
      expr: AVG(CAST(commission_percentage AS DOUBLE))
      comment: "Average commission rate on group blocks; measures intermediary cost of group business acquisition."
    - name: "cancelled_blocks"
      expr: COUNT(CASE WHEN block_status = 'Cancelled' THEN 1 END)
      comment: "Count of cancelled room blocks; tracks group business attrition and displacement cost exposure."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`inventory_room_type`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provides a strategic view of the room type product portfolio — sellability, ADA compliance, suite mix, and physical characteristics. Supports product strategy, distribution configuration, and inventory optimisation decisions."
  source: "`vibe_travel_hospitality_v1`.`inventory`.`room_type`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property to which the room type belongs; primary grouping for property-level product mix analysis."
    - name: "active_status"
      expr: active_status
      comment: "Active/inactive status of the room type; filters sellable product from retired inventory."
    - name: "room_class"
      expr: room_class
      comment: "Room class (e.g. Standard, Deluxe, Premium); used for product tier analysis and pricing strategy."
    - name: "rate_category"
      expr: rate_category
      comment: "Rate category associated with the room type; links product to pricing strategy."
    - name: "bed_type"
      expr: bed_type
      comment: "Bed configuration of the room type; used to analyse product mix against demand patterns."
    - name: "view_category"
      expr: view_category
      comment: "View category (e.g. Ocean, City, Garden); used for premium product segmentation."
    - name: "is_suite"
      expr: is_suite
      comment: "Indicates whether the room type is a suite; used for luxury inventory analysis and upsell strategy."
    - name: "is_ada_compliant"
      expr: is_ada_compliant
      comment: "Indicates ADA compliance of the room type; used for regulatory compliance and accessible inventory management."
    - name: "sellable_flag"
      expr: sellable_flag
      comment: "Indicates whether the room type is currently sellable; primary filter for active distribution inventory."
    - name: "lra_eligible"
      expr: lra_eligible
      comment: "Indicates LRA eligibility; used to quantify partner commitment scope at the room-type level."
    - name: "overbooking_allowed"
      expr: overbooking_allowed
      comment: "Indicates whether overbooking is permitted for this room type; informs overbooking strategy configuration."
  measures:
    - name: "total_room_types"
      expr: COUNT(1)
      comment: "Total room type configurations in the portfolio; baseline product inventory metric."
    - name: "sellable_room_types"
      expr: COUNT(CASE WHEN sellable_flag = TRUE THEN 1 END)
      comment: "Count of sellable room types; measures the breadth of the active product offering available for distribution."
    - name: "suite_room_types"
      expr: COUNT(CASE WHEN is_suite = TRUE THEN 1 END)
      comment: "Count of suite room types; measures luxury inventory depth and upsell opportunity scope."
    - name: "ada_compliant_room_types"
      expr: COUNT(CASE WHEN is_ada_compliant = TRUE THEN 1 END)
      comment: "Count of ADA-compliant room types; measures regulatory compliance coverage across the product portfolio."
    - name: "avg_square_footage"
      expr: AVG(CAST(square_footage AS DOUBLE))
      comment: "Average square footage across room types; used for product positioning and competitive benchmarking."
    - name: "lra_eligible_room_types"
      expr: COUNT(CASE WHEN lra_eligible = TRUE THEN 1 END)
      comment: "Count of room types eligible for Last Room Availability; quantifies the scope of LRA partner commitments at the product level."
    - name: "overbooking_allowed_room_types"
      expr: COUNT(CASE WHEN overbooking_allowed = TRUE THEN 1 END)
      comment: "Count of room types where overbooking is permitted; informs overbooking strategy and walk risk management."
$$;