-- Metric views for domain: revenue | Business: Travel Hospitality | Version: 2 | Generated on: 2026-06-28 00:14:33

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`revenue_channel_contribution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Channel-level revenue contribution and distribution cost analysis. Enables channel mix optimization, OTA vs direct cost comparison, and net revenue management decisions."
  source: "`vibe_travel_hospitality_v1`.`revenue`.`channel_contribution`"
  dimensions:
    - name: "business_date"
      expr: business_date
      comment: "Business date for time-series channel contribution analysis."
    - name: "channel_id"
      expr: channel_id
      comment: "Distribution channel identifier for channel-level performance segmentation."
    - name: "channel_type"
      expr: channel_type
      comment: "Channel type (e.g., OTA, direct, GDS) for channel category analysis."
    - name: "is_direct_channel"
      expr: is_direct_channel
      comment: "Flag indicating direct booking channel; used for direct vs indirect revenue split."
    - name: "is_ota_channel"
      expr: is_ota_channel
      comment: "Flag indicating OTA channel; used for OTA cost and revenue analysis."
    - name: "property_id"
      expr: property_id
      comment: "Property identifier for property-level channel mix analysis."
    - name: "market_segment_id"
      expr: market_segment_id
      comment: "Market segment for segment-channel revenue attribution."
    - name: "currency_code"
      expr: currency_code
      comment: "Reporting currency for monetary measures."
    - name: "contribution_status"
      expr: contribution_status
      comment: "Status of the contribution record for data quality filtering."
    - name: "reporting_period_start_date"
      expr: reporting_period_start_date
      comment: "Start date of the reporting period for period-level aggregation."
    - name: "reporting_period_end_date"
      expr: reporting_period_end_date
      comment: "End date of the reporting period."
  measures:
    - name: "total_gross_revenue"
      expr: SUM(CAST(gross_revenue AS DOUBLE))
      comment: "Total gross revenue by channel. Baseline for channel contribution analysis."
    - name: "total_net_revenue"
      expr: SUM(CAST(net_revenue AS DOUBLE))
      comment: "Total net revenue after distribution costs. True channel profitability measure."
    - name: "total_revenue_net_of_distribution"
      expr: SUM(CAST(revenue_net_of_distribution AS DOUBLE))
      comment: "Revenue net of all distribution costs. Used to compare true channel yield."
    - name: "total_commission_amount"
      expr: SUM(CAST(commission_amount AS DOUBLE))
      comment: "Total commission paid to distribution channels. Key cost driver for channel strategy."
    - name: "total_distribution_cost"
      expr: SUM(CAST(total_distribution_cost AS DOUBLE))
      comment: "Total distribution cost including commissions and GDS fees. Drives channel cost optimization."
    - name: "total_gds_transaction_fees"
      expr: SUM(CAST(gds_transaction_fees AS DOUBLE))
      comment: "Total GDS transaction fees. Specific cost component for GDS channel management."
    - name: "avg_adr"
      expr: AVG(CAST(adr AS DOUBLE))
      comment: "Average Daily Rate by channel. Reveals pricing effectiveness per distribution channel."
    - name: "avg_revpar"
      expr: AVG(CAST(revpar AS DOUBLE))
      comment: "Average RevPAR by channel. Channel-level revenue productivity."
    - name: "avg_commission_rate_pct"
      expr: AVG(CAST(commission_rate_pct AS DOUBLE))
      comment: "Average commission rate percentage. Benchmarks channel cost efficiency."
    - name: "avg_channel_mix_pct"
      expr: AVG(CAST(channel_mix_pct AS DOUBLE))
      comment: "Average channel mix percentage. Tracks channel share of total bookings."
    - name: "avg_cancellation_rate_pct"
      expr: AVG(CAST(cancellation_rate_pct AS DOUBLE))
      comment: "Average cancellation rate by channel. High cancellation rates erode net revenue."
    - name: "avg_cost_per_booking"
      expr: AVG(CAST(cost_per_booking AS DOUBLE))
      comment: "Average cost per booking by channel. Direct efficiency KPI for channel cost management."
    - name: "avg_alos"
      expr: AVG(CAST(alos AS DOUBLE))
      comment: "Average Length of Stay by channel. Longer stays typically indicate higher-value bookings."
    - name: "avg_advance_booking_days"
      expr: AVG(CAST(advance_booking_days AS DOUBLE))
      comment: "Average advance booking window by channel. Informs channel-specific pricing and inventory strategy."
    - name: "avg_rgi"
      expr: AVG(CAST(rgi AS DOUBLE))
      comment: "Average Revenue Generation Index by channel. Competitive revenue share by distribution channel."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`revenue_competitor_rate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Competitor rate shopping intelligence metrics. Tracks rate gaps, parity, and competitive positioning to inform dynamic pricing and rate strategy decisions."
  source: "`vibe_travel_hospitality_v1`.`revenue`.`competitor_rate`"
  dimensions:
    - name: "shop_date"
      expr: shop_date
      comment: "Date the competitor rate was shopped; primary time dimension for rate intelligence trending."
    - name: "stay_date"
      expr: stay_date
      comment: "Stay date for the shopped rate; enables lead-time rate analysis."
    - name: "competitive_set_id"
      expr: competitive_set_id
      comment: "Competitive set identifier for comp set-level rate analysis."
    - name: "channel_shopped"
      expr: channel_shopped
      comment: "Channel where the rate was shopped (e.g., OTA, direct) for channel parity analysis."
    - name: "rate_plan_type"
      expr: rate_plan_type
      comment: "Rate plan type for rate category comparison."
    - name: "room_type_category"
      expr: room_type_category
      comment: "Room type category for room-level competitive rate analysis."
    - name: "meal_plan_code"
      expr: meal_plan_code
      comment: "Meal plan code for rate inclusion comparison."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for rate monetary measures."
    - name: "is_weekend"
      expr: is_weekend
      comment: "Weekend flag for weekday vs weekend rate gap analysis."
    - name: "special_event_flag"
      expr: special_event_flag
      comment: "Special event flag for event-period rate intelligence."
    - name: "day_of_week"
      expr: day_of_week
      comment: "Day of week for day-of-week rate pattern analysis."
  measures:
    - name: "avg_shopped_rate"
      expr: AVG(CAST(shopped_rate AS DOUBLE))
      comment: "Average competitor shopped rate. Baseline for competitive rate positioning."
    - name: "avg_our_rate"
      expr: AVG(CAST(our_rate AS DOUBLE))
      comment: "Average own property rate at time of shop. Enables direct rate comparison."
    - name: "avg_rate_gap"
      expr: AVG(CAST(rate_gap AS DOUBLE))
      comment: "Average rate gap (own rate minus competitor rate). Positive gap means priced above competition."
    - name: "avg_rate_delta"
      expr: AVG(CAST(rate_delta AS DOUBLE))
      comment: "Average rate delta (change from previous shop). Tracks competitor rate movement velocity."
    - name: "avg_rate_in_usd"
      expr: AVG(CAST(rate_in_usd AS DOUBLE))
      comment: "Average competitor rate in USD. Enables cross-currency competitive comparison."
    - name: "avg_ari"
      expr: AVG(CAST(ari AS DOUBLE))
      comment: "Average ARI from competitor rate data. Competitive revenue index from rate shopping."
    - name: "avg_star_rating"
      expr: AVG(CAST(star_rating AS DOUBLE))
      comment: "Average star rating of shopped competitors. Ensures like-for-like competitive comparison."
    - name: "rate_shop_record_count"
      expr: COUNT(1)
      comment: "Count of rate shop records. Tracks rate shopping coverage and frequency."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`revenue_demand_forecast`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Demand forecast accuracy and projected KPI metrics. Enables revenue managers to evaluate forecast quality, adjust strategies, and monitor projected occupancy and rate performance."
  source: "`vibe_travel_hospitality_v1`.`revenue`.`demand_forecast`"
  dimensions:
    - name: "forecast_date"
      expr: forecast_date
      comment: "Date the forecast was generated; used for forecast vintage analysis."
    - name: "property_id"
      expr: property_id
      comment: "Property identifier for property-level forecast analysis."
    - name: "room_type_id"
      expr: room_type_id
      comment: "Room type for granular demand forecast analysis."
    - name: "market_segment_id"
      expr: market_segment_id
      comment: "Market segment for segment-level demand forecasting."
    - name: "forecast_type"
      expr: forecast_type
      comment: "Type of forecast (e.g., unconstrained, constrained) for forecast methodology comparison."
    - name: "forecast_model_type"
      expr: forecast_model_type
      comment: "Forecasting model type for model performance benchmarking."
    - name: "forecast_status"
      expr: forecast_status
      comment: "Status of the forecast record for filtering active vs archived forecasts."
    - name: "is_override"
      expr: is_override
      comment: "Flag indicating manual override of system forecast; tracks human intervention frequency."
    - name: "is_special_event"
      expr: is_special_event
      comment: "Special event flag for event-driven demand analysis."
    - name: "is_holiday"
      expr: is_holiday
      comment: "Holiday flag for holiday demand pattern analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Reporting currency for monetary forecast measures."
    - name: "day_of_week"
      expr: day_of_week
      comment: "Day of week for weekday vs weekend demand pattern analysis."
  measures:
    - name: "avg_projected_occupancy_pct"
      expr: AVG(CAST(projected_occupancy_pct AS DOUBLE))
      comment: "Average projected occupancy percentage. Primary demand forecast output for inventory and pricing decisions."
    - name: "avg_projected_adr"
      expr: AVG(CAST(projected_adr AS DOUBLE))
      comment: "Average projected ADR. Forecast pricing KPI for rate strategy validation."
    - name: "avg_projected_revpar"
      expr: AVG(CAST(projected_revpar AS DOUBLE))
      comment: "Average projected RevPAR. Composite forecast KPI combining occupancy and rate projections."
    - name: "total_projected_room_revenue"
      expr: SUM(CAST(projected_room_revenue AS DOUBLE))
      comment: "Total projected room revenue. Aggregate forecast for budget and strategy alignment."
    - name: "avg_unconstrained_demand"
      expr: AVG(CAST(unconstrained_demand AS DOUBLE))
      comment: "Average unconstrained demand. Reveals true market demand before inventory constraints."
    - name: "avg_constrained_demand"
      expr: AVG(CAST(constrained_demand AS DOUBLE))
      comment: "Average constrained demand. Actual sellable demand after inventory limits."
    - name: "avg_forecast_accuracy_mape"
      expr: AVG(CAST(forecast_accuracy_mape AS DOUBLE))
      comment: "Average Mean Absolute Percentage Error of forecast. Model accuracy KPI; lower is better."
    - name: "avg_booking_pace_index"
      expr: AVG(CAST(booking_pace_index AS DOUBLE))
      comment: "Average booking pace index. Tracks how quickly bookings are accumulating vs historical pace."
    - name: "avg_ari_forecast"
      expr: AVG(CAST(ari_forecast AS DOUBLE))
      comment: "Average forecasted ARI. Projected competitive revenue index for strategy planning."
    - name: "avg_mpi_forecast"
      expr: AVG(CAST(mpi_forecast AS DOUBLE))
      comment: "Average forecasted MPI. Projected market penetration index."
    - name: "avg_rgi_forecast"
      expr: AVG(CAST(rgi_forecast AS DOUBLE))
      comment: "Average forecasted RGI. Projected revenue generation index vs competitive set."
    - name: "avg_projected_cancellations"
      expr: AVG(CAST(projected_cancellations AS DOUBLE))
      comment: "Average projected cancellations. Informs overbooking policy and net demand planning."
    - name: "avg_projected_no_shows"
      expr: AVG(CAST(projected_no_shows AS DOUBLE))
      comment: "Average projected no-shows. Informs walk policy and overbooking strategy."
    - name: "avg_projected_pickup"
      expr: AVG(CAST(projected_pickup AS DOUBLE))
      comment: "Average projected pickup (incremental bookings). Tracks booking velocity forecast."
    - name: "avg_confidence_level_pct"
      expr: AVG(CAST(confidence_level_pct AS DOUBLE))
      comment: "Average forecast confidence level. Indicates reliability of forecast for decision-making."
    - name: "forecast_record_count"
      expr: COUNT(1)
      comment: "Count of forecast records. Baseline for forecast coverage and completeness analysis."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`revenue_displacement_analysis`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Group displacement analysis metrics. Quantifies the revenue trade-off between accepting group business and displacing transient demand. Critical for group pricing and acceptance decisions."
  source: "`vibe_travel_hospitality_v1`.`revenue`.`displacement_analysis`"
  dimensions:
    - name: "analysis_date"
      expr: analysis_date
      comment: "Date of the displacement analysis; primary time dimension."
    - name: "property_id"
      expr: property_id
      comment: "Property identifier for property-level displacement analysis."
    - name: "market_segment_id"
      expr: market_segment_id
      comment: "Market segment for segment-level displacement impact analysis."
    - name: "analysis_type"
      expr: analysis_type
      comment: "Type of displacement analysis for methodology classification."
    - name: "analysis_status"
      expr: analysis_status
      comment: "Status of the analysis for filtering completed vs pending evaluations."
    - name: "recommendation_outcome"
      expr: recommendation_outcome
      comment: "Outcome of the displacement recommendation (accept/decline) for decision tracking."
    - name: "displacement_risk_level"
      expr: displacement_risk_level
      comment: "Risk level of displacement for prioritizing revenue management attention."
    - name: "is_peak_period"
      expr: is_peak_period
      comment: "Peak period flag for high-demand displacement analysis."
    - name: "is_special_event"
      expr: is_special_event
      comment: "Special event flag for event-period displacement analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Reporting currency for displacement monetary measures."
    - name: "stay_date_from"
      expr: stay_date_from
      comment: "Start of the group stay period for displacement analysis."
    - name: "stay_date_to"
      expr: stay_date_to
      comment: "End of the group stay period for displacement analysis."
  measures:
    - name: "total_net_revenue_impact"
      expr: SUM(CAST(net_revenue_impact AS DOUBLE))
      comment: "Total net revenue impact of displacement decisions. Primary KPI for group acceptance strategy."
    - name: "total_group_room_revenue"
      expr: SUM(CAST(group_room_revenue AS DOUBLE))
      comment: "Total group room revenue from accepted group business."
    - name: "total_transient_revenue_displaced"
      expr: SUM(CAST(transient_room_revenue_displaced AS DOUBLE))
      comment: "Total transient room revenue displaced by group business. Opportunity cost measure."
    - name: "total_fb_revenue_contribution"
      expr: SUM(CAST(fb_revenue_contribution AS DOUBLE))
      comment: "Total F&B revenue contribution from group business. Ancillary revenue from group acceptance."
    - name: "total_ancillary_revenue_contribution"
      expr: SUM(CAST(ancillary_revenue_contribution AS DOUBLE))
      comment: "Total ancillary revenue contribution from group business."
    - name: "total_group_spend"
      expr: SUM(CAST(total_group_spend AS DOUBLE))
      comment: "Total group spend including all revenue streams. Full value of group business."
    - name: "avg_proposed_group_rate"
      expr: AVG(CAST(proposed_group_rate AS DOUBLE))
      comment: "Average proposed group rate. Pricing benchmark for group negotiations."
    - name: "avg_min_acceptable_rate"
      expr: AVG(CAST(min_acceptable_rate AS DOUBLE))
      comment: "Average minimum acceptable rate for group business. Floor pricing KPI."
    - name: "avg_estimated_transient_adr_displaced"
      expr: AVG(CAST(estimated_transient_adr_displaced AS DOUBLE))
      comment: "Average estimated transient ADR displaced. Opportunity cost per room for group decisions."
    - name: "avg_revpar_impact"
      expr: AVG(CAST(revpar_impact AS DOUBLE))
      comment: "Average RevPAR impact of displacement decisions. Net effect on property revenue productivity."
    - name: "avg_forecast_occupancy_pct"
      expr: AVG(CAST(forecast_occupancy_pct AS DOUBLE))
      comment: "Average forecast occupancy at time of analysis. Context for displacement risk assessment."
    - name: "displacement_analysis_count"
      expr: COUNT(1)
      comment: "Count of displacement analyses. Tracks group evaluation volume."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`revenue_dynamic_rate_rule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dynamic rate rule configuration and trigger metrics. Tracks rule activity, adjustment levels, and trigger frequency to optimize automated pricing rule performance."
  source: "`vibe_travel_hospitality_v1`.`revenue`.`dynamic_rate_rule`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property identifier for property-level dynamic rate rule analysis."
    - name: "room_type_id"
      expr: room_type_id
      comment: "Room type for room-level rate rule analysis."
    - name: "market_segment_id"
      expr: market_segment_id
      comment: "Market segment for segment-level rate rule analysis."
    - name: "rule_type"
      expr: rule_type
      comment: "Type of dynamic rate rule for rule category analysis."
    - name: "rule_status"
      expr: rule_status
      comment: "Status of the rate rule (active, inactive) for filtering live rules."
    - name: "adjustment_type"
      expr: adjustment_type
      comment: "Adjustment type (percentage, absolute) for rule methodology analysis."
    - name: "adjustment_direction"
      expr: adjustment_direction
      comment: "Adjustment direction (up, down) for pricing direction analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the rate rule for governance tracking."
    - name: "is_stackable"
      expr: is_stackable
      comment: "Stackable flag; stackable rules can compound with other rules."
    - name: "currency_code"
      expr: currency_code
      comment: "Reporting currency for rate rule monetary measures."
    - name: "effective_from"
      expr: effective_from
      comment: "Effective start date of the rate rule."
    - name: "effective_until"
      expr: effective_until
      comment: "Effective end date of the rate rule."
  measures:
    - name: "avg_adjustment_value"
      expr: AVG(CAST(adjustment_value AS DOUBLE))
      comment: "Average adjustment value applied by dynamic rate rules. Tracks pricing adjustment magnitude."
    - name: "avg_max_rate_ceiling"
      expr: AVG(CAST(max_rate_ceiling AS DOUBLE))
      comment: "Average maximum rate ceiling across rules. Tracks upper pricing boundary deployment."
    - name: "avg_min_rate_floor"
      expr: AVG(CAST(min_rate_floor AS DOUBLE))
      comment: "Average minimum rate floor across rules. Tracks lower pricing boundary deployment."
    - name: "avg_trigger_threshold_value"
      expr: AVG(CAST(trigger_threshold_value AS DOUBLE))
      comment: "Average trigger threshold value. Tracks sensitivity calibration of dynamic pricing rules."
    - name: "active_rule_count"
      expr: COUNT(CASE WHEN rule_status = 'ACTIVE' THEN 1 END)
      comment: "Count of active dynamic rate rules. Tracks live automated pricing rule portfolio."
    - name: "stackable_rule_count"
      expr: COUNT(CASE WHEN is_stackable = TRUE THEN 1 END)
      comment: "Count of stackable rules. Tracks compounding pricing rule exposure."
    - name: "dynamic_rate_rule_count"
      expr: COUNT(1)
      comment: "Total count of dynamic rate rules. Tracks rule library size."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`revenue_group_evaluation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Group business evaluation and decision metrics. Tracks group inquiry outcomes, revenue impact, wash factors, and displacement costs to optimize group acceptance strategy."
  source: "`vibe_travel_hospitality_v1`.`revenue`.`group_evaluation`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property identifier for property-level group evaluation analysis."
    - name: "evaluation_status"
      expr: evaluation_status
      comment: "Status of the group evaluation (pending, accepted, declined) for pipeline tracking."
    - name: "group_type"
      expr: group_type
      comment: "Group type (corporate, leisure, SMERF) for segment-level group analysis."
    - name: "revenue_manager_decision"
      expr: revenue_manager_decision
      comment: "Revenue manager decision outcome for decision quality analysis."
    - name: "is_definite_booking"
      expr: is_definite_booking
      comment: "Flag indicating definite booking status for pipeline conversion tracking."
    - name: "lead_time_bucket"
      expr: lead_time_bucket
      comment: "Lead time bucket for booking window analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Reporting currency for group evaluation monetary measures."
    - name: "arrival_date"
      expr: arrival_date
      comment: "Group arrival date for stay period analysis."
    - name: "departure_date"
      expr: departure_date
      comment: "Group departure date for stay period analysis."
  measures:
    - name: "total_group_room_revenue"
      expr: SUM(CAST(group_room_revenue AS DOUBLE))
      comment: "Total group room revenue from evaluated groups. Revenue pipeline measure."
    - name: "total_net_revenue_impact"
      expr: SUM(CAST(net_revenue_impact AS DOUBLE))
      comment: "Total net revenue impact of group decisions. Measures value of group business after displacement."
    - name: "total_fb_revenue_estimate"
      expr: SUM(CAST(fb_revenue_estimate AS DOUBLE))
      comment: "Total estimated F&B revenue from group business. Ancillary revenue pipeline."
    - name: "total_ancillary_revenue_estimate"
      expr: SUM(CAST(ancillary_revenue_estimate AS DOUBLE))
      comment: "Total estimated ancillary revenue from group business."
    - name: "total_displacement_cost"
      expr: SUM(CAST(displacement_cost AS DOUBLE))
      comment: "Total displacement cost of accepting group business. Opportunity cost measure."
    - name: "avg_proposed_group_rate"
      expr: AVG(CAST(proposed_group_rate AS DOUBLE))
      comment: "Average proposed group rate. Pricing benchmark for group negotiations."
    - name: "avg_minimum_acceptable_rate"
      expr: AVG(CAST(minimum_acceptable_rate AS DOUBLE))
      comment: "Average minimum acceptable rate. Floor pricing for group acceptance decisions."
    - name: "avg_counter_offer_rate"
      expr: AVG(CAST(counter_offer_rate AS DOUBLE))
      comment: "Average counter offer rate. Tracks negotiation outcomes and pricing flexibility."
    - name: "avg_wash_factor_pct"
      expr: AVG(CAST(wash_factor_pct AS DOUBLE))
      comment: "Average wash factor percentage. Measures expected attrition from group blocks."
    - name: "avg_historical_wash_pct"
      expr: AVG(CAST(historical_wash_pct AS DOUBLE))
      comment: "Average historical wash percentage. Baseline for wash factor calibration."
    - name: "avg_revpar_impact"
      expr: AVG(CAST(revpar_impact AS DOUBLE))
      comment: "Average RevPAR impact of group decisions. Net effect on property revenue productivity."
    - name: "avg_attrition_pct"
      expr: AVG(CAST(attrition_pct AS DOUBLE))
      comment: "Average attrition percentage. Tracks group block pickup vs contracted rooms."
    - name: "avg_demand_forecast_occupancy_pct"
      expr: AVG(CAST(demand_forecast_occupancy_pct AS DOUBLE))
      comment: "Average forecasted occupancy at time of group evaluation. Context for displacement risk."
    - name: "definite_booking_count"
      expr: COUNT(CASE WHEN is_definite_booking = TRUE THEN 1 END)
      comment: "Count of definite group bookings. Tracks group pipeline conversion."
    - name: "group_evaluation_count"
      expr: COUNT(1)
      comment: "Total count of group evaluations. Tracks group inquiry volume."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`revenue_inventory_control`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory control and yield management metrics. Tracks hurdle rates, overbooking levels, availability controls, and BAR rates to optimize room inventory deployment."
  source: "`vibe_travel_hospitality_v1`.`revenue`.`inventory_control`"
  dimensions:
    - name: "stay_date"
      expr: stay_date
      comment: "Stay date for inventory control record; primary time dimension."
    - name: "primary_inventory_property_id"
      expr: primary_inventory_property_id
      comment: "Property identifier for property-level inventory control analysis."
    - name: "room_type_id"
      expr: room_type_id
      comment: "Room type for room-level inventory control analysis."
    - name: "control_type"
      expr: control_type
      comment: "Type of inventory control (e.g., stop sell, CTA, CTD) for control category analysis."
    - name: "control_status"
      expr: control_status
      comment: "Status of the inventory control record."
    - name: "is_closed_to_arrival"
      expr: is_closed_to_arrival
      comment: "CTA flag; tracks arrival restriction patterns."
    - name: "is_closed_to_departure"
      expr: is_closed_to_departure
      comment: "CTD flag; tracks departure restriction patterns."
    - name: "is_override"
      expr: is_override
      comment: "Override flag; tracks manual intervention frequency in inventory controls."
    - name: "currency_code"
      expr: currency_code
      comment: "Reporting currency for monetary inventory control measures."
  measures:
    - name: "avg_hurdle_rate"
      expr: AVG(CAST(hurdle_rate AS DOUBLE))
      comment: "Average hurdle rate. Minimum acceptable rate for inventory acceptance; core yield management KPI."
    - name: "avg_current_bar"
      expr: AVG(CAST(current_bar AS DOUBLE))
      comment: "Average current Best Available Rate. Tracks live pricing level for inventory control."
    - name: "avg_overbooking_pct"
      expr: AVG(CAST(overbooking_pct AS DOUBLE))
      comment: "Average overbooking percentage. Tracks inventory risk exposure."
    - name: "avg_occupancy_on_books"
      expr: AVG(CAST(occupancy_on_books AS DOUBLE))
      comment: "Average occupancy on books at control record time. Current demand absorption level."
    - name: "avg_demand_forecast_rooms"
      expr: AVG(CAST(demand_forecast_rooms AS DOUBLE))
      comment: "Average demand forecast rooms. Projected demand for inventory control calibration."
    - name: "avg_control_value"
      expr: AVG(CAST(control_value AS DOUBLE))
      comment: "Average control value (e.g., sell limit, min rate). Tracks inventory control parameter levels."
    - name: "avg_system_recommended_value"
      expr: AVG(CAST(system_recommended_value AS DOUBLE))
      comment: "Average system-recommended control value. Benchmarks RMS recommendations vs applied controls."
    - name: "avg_max_rate"
      expr: AVG(CAST(max_rate AS DOUBLE))
      comment: "Average maximum rate ceiling. Tracks rate ceiling deployment."
    - name: "avg_min_rate"
      expr: AVG(CAST(min_rate AS DOUBLE))
      comment: "Average minimum rate floor. Tracks rate floor deployment."
    - name: "override_count"
      expr: COUNT(CASE WHEN is_override = TRUE THEN 1 END)
      comment: "Count of manual override inventory controls. High override rates indicate RMS calibration issues."
    - name: "cta_count"
      expr: COUNT(CASE WHEN is_closed_to_arrival = TRUE THEN 1 END)
      comment: "Count of closed-to-arrival controls. Tracks arrival restriction frequency."
    - name: "inventory_control_count"
      expr: COUNT(1)
      comment: "Total count of inventory control records. Tracks control activity volume."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`revenue_market_segment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Market segment configuration and revenue strategy metrics. Tracks segment characteristics, commission eligibility, loyalty participation, and pricing parameters for segment-level revenue strategy."
  source: "`vibe_travel_hospitality_v1`.`revenue`.`market_segment`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property identifier for property-level segment analysis."
    - name: "segment_type"
      expr: segment_type
      comment: "Segment type (transient, group, contract) for segment category analysis."
    - name: "segment_category"
      expr: segment_category
      comment: "Segment category for hierarchical segment analysis."
    - name: "market_segment_status"
      expr: market_segment_status
      comment: "Status of the market segment for filtering active vs inactive segments."
    - name: "commission_eligible"
      expr: commission_eligible
      comment: "Commission eligibility flag for commission cost analysis."
    - name: "loyalty_eligible"
      expr: loyalty_eligible
      comment: "Loyalty eligibility flag for loyalty program participation analysis."
    - name: "gds_eligible"
      expr: gds_eligible
      comment: "GDS eligibility flag for distribution channel analysis."
    - name: "ota_eligible"
      expr: ota_eligible
      comment: "OTA eligibility flag for OTA distribution analysis."
    - name: "group_block_eligible"
      expr: group_block_eligible
      comment: "Group block eligibility flag for group business analysis."
    - name: "price_sensitivity"
      expr: price_sensitivity
      comment: "Price sensitivity classification for pricing strategy segmentation."
    - name: "contribution_margin_tier"
      expr: contribution_margin_tier
      comment: "Contribution margin tier for profitability-based segment analysis."
    - name: "effective_from"
      expr: effective_from
      comment: "Effective start date of the market segment definition."
  measures:
    - name: "avg_commission_rate_pct"
      expr: AVG(CAST(commission_rate_pct AS DOUBLE))
      comment: "Average commission rate percentage by segment. Tracks distribution cost by market segment."
    - name: "avg_avg_length_of_stay_nights"
      expr: AVG(CAST(avg_length_of_stay_nights AS DOUBLE))
      comment: "Average length of stay by market segment. Informs minimum stay strategy and inventory optimization."
    - name: "active_segment_count"
      expr: COUNT(CASE WHEN market_segment_status = 'ACTIVE' THEN 1 END)
      comment: "Count of active market segments. Tracks segment portfolio coverage."
    - name: "commission_eligible_segment_count"
      expr: COUNT(CASE WHEN commission_eligible = TRUE THEN 1 END)
      comment: "Count of commission-eligible segments. Tracks commission cost exposure."
    - name: "loyalty_eligible_segment_count"
      expr: COUNT(CASE WHEN loyalty_eligible = TRUE THEN 1 END)
      comment: "Count of loyalty-eligible segments. Tracks loyalty program reach."
    - name: "market_segment_count"
      expr: COUNT(1)
      comment: "Total count of market segment records. Tracks segment library size."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`revenue_performance_actuals`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core hospitality KPI dashboard covering ADR, RevPAR, occupancy, GOP, TRevPAR, and ancillary revenue actuals. Primary steering metric for revenue managers and C-suite."
  source: "`vibe_travel_hospitality_v1`.`revenue`.`performance_actuals`"
  dimensions:
    - name: "performance_date"
      expr: performance_date
      comment: "Business date of the performance record; used for daily, weekly, monthly trending."
    - name: "property_id"
      expr: property_id
      comment: "Property identifier; enables property-level performance comparison."
    - name: "currency_code"
      expr: currency_code
      comment: "Reporting currency for all monetary measures."
    - name: "record_status"
      expr: record_status
      comment: "Status of the performance record (e.g., final, preliminary) for data quality filtering."
    - name: "loyalty_tier_id"
      expr: loyalty_tier_id
      comment: "Loyalty tier associated with the performance record for tier-level revenue analysis."
    - name: "cost_center_id"
      expr: cost_center_id
      comment: "Cost center for departmental revenue attribution."
    - name: "profit_center_id"
      expr: profit_center_id
      comment: "Profit center for P&L segmentation."
  measures:
    - name: "total_room_revenue"
      expr: SUM(CAST(total_room_revenue AS DOUBLE))
      comment: "Total rooms revenue across all selected records. Core top-line KPI for hotel operations."
    - name: "total_property_revenue"
      expr: SUM(CAST(total_property_revenue AS DOUBLE))
      comment: "Total property revenue including rooms, F&B, spa, and ancillary. Drives TRevPAR and overall P&L."
    - name: "avg_adr"
      expr: AVG(CAST(adr AS DOUBLE))
      comment: "Average Daily Rate across selected records. Primary pricing effectiveness KPI for revenue management."
    - name: "avg_revpar"
      expr: AVG(CAST(revpar AS DOUBLE))
      comment: "Average Revenue Per Available Room. The single most-watched KPI in hotel revenue management."
    - name: "avg_occupancy_rate"
      expr: AVG(CAST(occupancy_rate AS DOUBLE))
      comment: "Average occupancy rate (%). Indicates demand absorption and inventory utilization."
    - name: "avg_trevpar"
      expr: AVG(CAST(trevpar AS DOUBLE))
      comment: "Average Total Revenue Per Available Room. Captures full property revenue productivity beyond rooms."
    - name: "avg_goppar"
      expr: AVG(CAST(goppar AS DOUBLE))
      comment: "Average Gross Operating Profit Per Available Room. Profitability efficiency KPI used in owner/investor reporting."
    - name: "total_gop"
      expr: SUM(CAST(gop AS DOUBLE))
      comment: "Total Gross Operating Profit. Core profitability measure for operational steering and budget variance."
    - name: "total_fb_revenue"
      expr: SUM(CAST(fb_revenue AS DOUBLE))
      comment: "Total Food & Beverage revenue. Tracks ancillary revenue stream performance."
    - name: "total_spa_revenue"
      expr: SUM(CAST(spa_revenue AS DOUBLE))
      comment: "Total spa revenue. Tracks wellness ancillary revenue stream."
    - name: "total_ancillary_revenue"
      expr: SUM(CAST(ancillary_revenue AS DOUBLE))
      comment: "Total ancillary revenue (non-rooms). Measures diversification of revenue beyond core rooms."
    - name: "avg_cpor"
      expr: AVG(CAST(cpor AS DOUBLE))
      comment: "Average Cost Per Occupied Room. Operational efficiency KPI; rising CPOR erodes GOP margin."
    - name: "avg_ari"
      expr: AVG(CAST(ari AS DOUBLE))
      comment: "Average Accommodation Revenue Index. Competitive benchmarking KPI vs comp set."
    - name: "avg_mpi"
      expr: AVG(CAST(mpi AS DOUBLE))
      comment: "Average Market Penetration Index. Measures occupancy share vs competitive set."
    - name: "avg_rgi"
      expr: AVG(CAST(rgi AS DOUBLE))
      comment: "Average Revenue Generation Index. Overall revenue share vs competitive set; STR benchmark KPI."
    - name: "budget_variance_room_revenue"
      expr: SUM(CAST(total_room_revenue AS DOUBLE) - CAST(budget_room_revenue AS DOUBLE))
      comment: "Actual vs budget variance for room revenue. Drives budget review conversations and reforecast decisions."
    - name: "budget_variance_total_revenue"
      expr: SUM(CAST(total_property_revenue AS DOUBLE) - CAST(budget_total_revenue AS DOUBLE))
      comment: "Actual vs budget variance for total property revenue. Key metric for owner reporting and strategic review."
    - name: "avg_ebitda_contribution"
      expr: AVG(CAST(ebitda_contribution AS DOUBLE))
      comment: "Average EBITDA contribution per record. Investor-facing profitability KPI."
    - name: "prior_year_revpar_avg"
      expr: AVG(CAST(prior_year_revpar AS DOUBLE))
      comment: "Average prior-year RevPAR for year-over-year comparison. Essential for growth narrative in board decks."
    - name: "record_count"
      expr: COUNT(1)
      comment: "Count of performance actual records. Used as denominator baseline for average calculations."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`revenue_pickup_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Booking pickup velocity and pace metrics. Tracks rooms on books, pickup velocity, and forecast variance to enable proactive revenue management interventions."
  source: "`vibe_travel_hospitality_v1`.`revenue`.`pickup_report`"
  dimensions:
    - name: "report_date"
      expr: report_date
      comment: "Date the pickup report was generated; primary time dimension for pace analysis."
    - name: "stay_date"
      expr: stay_date
      comment: "Stay date being tracked; enables lead-time pickup analysis."
    - name: "property_id"
      expr: property_id
      comment: "Property identifier for property-level pickup analysis."
    - name: "market_segment_id"
      expr: market_segment_id
      comment: "Market segment for segment-level pickup tracking."
    - name: "channel_code"
      expr: channel_code
      comment: "Channel code for channel-level pickup analysis."
    - name: "demand_level"
      expr: demand_level
      comment: "Demand level classification for demand-tier pickup analysis."
    - name: "is_special_event"
      expr: is_special_event
      comment: "Special event flag for event-period pickup analysis."
    - name: "is_weekend"
      expr: is_weekend
      comment: "Weekend flag for weekday vs weekend pickup pattern analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Reporting currency for monetary pickup measures."
    - name: "report_type"
      expr: report_type
      comment: "Report type for filtering specific pickup report categories."
    - name: "report_status"
      expr: report_status
      comment: "Report status for filtering finalized vs draft pickup reports."
  measures:
    - name: "avg_adr_on_books"
      expr: AVG(CAST(adr_on_books AS DOUBLE))
      comment: "Average ADR on books at report date. Current pricing performance indicator."
    - name: "avg_forecasted_adr"
      expr: AVG(CAST(forecasted_adr AS DOUBLE))
      comment: "Average forecasted ADR. Pricing target for the stay date."
    - name: "avg_adr_variance_to_forecast"
      expr: AVG(CAST(adr_variance_to_forecast AS DOUBLE))
      comment: "Average ADR variance vs forecast. Tracks pricing execution vs plan."
    - name: "avg_revpar_on_books"
      expr: AVG(CAST(revpar_on_books AS DOUBLE))
      comment: "Average RevPAR on books. Current revenue productivity at report date."
    - name: "avg_forecasted_revpar"
      expr: AVG(CAST(forecasted_revpar AS DOUBLE))
      comment: "Average forecasted RevPAR. Revenue productivity target for the stay date."
    - name: "avg_pickup_velocity"
      expr: AVG(CAST(pickup_velocity AS DOUBLE))
      comment: "Average pickup velocity (bookings per day). Tracks booking pace for proactive inventory management."
    - name: "avg_prior_year_adr"
      expr: AVG(CAST(prior_year_adr AS DOUBLE))
      comment: "Average prior year ADR. Year-over-year pricing comparison."
    - name: "pickup_report_count"
      expr: COUNT(1)
      comment: "Count of pickup report records. Tracks reporting coverage."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`revenue_pricing_override`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pricing override activity and impact metrics. Tracks manual rate overrides, approval patterns, and rate variance to monitor pricing discipline and revenue management governance."
  source: "`vibe_travel_hospitality_v1`.`revenue`.`pricing_override`"
  dimensions:
    - name: "effective_date"
      expr: effective_date
      comment: "Effective date of the pricing override; primary time dimension."
    - name: "property_id"
      expr: property_id
      comment: "Property identifier for property-level override analysis."
    - name: "room_type_id"
      expr: room_type_id
      comment: "Room type for room-level override analysis."
    - name: "override_reason_code"
      expr: override_reason_code
      comment: "Override reason code for root cause analysis of pricing exceptions."
    - name: "override_status"
      expr: override_status
      comment: "Status of the override (pending, approved, reversed) for governance tracking."
    - name: "override_scope"
      expr: override_scope
      comment: "Scope of the override for impact assessment."
    - name: "approval_required"
      expr: approval_required
      comment: "Flag indicating whether approval was required for the override."
    - name: "is_bar_override"
      expr: is_bar_override
      comment: "Flag indicating BAR override; tracks deviations from Best Available Rate."
    - name: "currency_code"
      expr: currency_code
      comment: "Reporting currency for override monetary measures."
    - name: "distribution_channel_id"
      expr: distribution_channel_id
      comment: "Distribution channel for channel-level override analysis."
  measures:
    - name: "avg_override_rate"
      expr: AVG(CAST(override_rate AS DOUBLE))
      comment: "Average override rate applied. Tracks pricing exception levels."
    - name: "avg_rms_recommended_rate"
      expr: AVG(CAST(rms_recommended_rate AS DOUBLE))
      comment: "Average RMS-recommended rate at time of override. Benchmarks human vs system pricing."
    - name: "avg_rate_variance_amount"
      expr: AVG(CAST(rate_variance_amount AS DOUBLE))
      comment: "Average rate variance amount (override vs recommended). Measures pricing deviation magnitude."
    - name: "avg_rate_variance_pct"
      expr: AVG(CAST(rate_variance_pct AS DOUBLE))
      comment: "Average rate variance percentage. Tracks relative pricing deviation from RMS recommendation."
    - name: "avg_competitive_rate_reference"
      expr: AVG(CAST(competitive_rate_reference AS DOUBLE))
      comment: "Average competitive rate reference at override time. Context for override justification analysis."
    - name: "avg_approval_threshold_pct"
      expr: AVG(CAST(approval_threshold_pct AS DOUBLE))
      comment: "Average approval threshold percentage. Tracks governance threshold calibration."
    - name: "bar_override_count"
      expr: COUNT(CASE WHEN is_bar_override = TRUE THEN 1 END)
      comment: "Count of BAR overrides. High BAR override frequency indicates pricing discipline issues."
    - name: "approval_required_count"
      expr: COUNT(CASE WHEN approval_required = TRUE THEN 1 END)
      comment: "Count of overrides requiring approval. Tracks governance process utilization."
    - name: "pricing_override_count"
      expr: COUNT(1)
      comment: "Total count of pricing overrides. Tracks override volume for governance reporting."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`revenue_rate_availability`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rate availability and distribution metrics. Tracks rate plan availability, stop-sell conditions, parity compliance, and pricing override activity across channels and room types."
  source: "`vibe_travel_hospitality_v1`.`revenue`.`rate_availability`"
  dimensions:
    - name: "snapshot_date"
      expr: snapshot_date
      comment: "Snapshot date for rate availability record; primary time dimension."
    - name: "property_id"
      expr: property_id
      comment: "Property identifier for property-level rate availability analysis."
    - name: "room_type_id"
      expr: room_type_id
      comment: "Room type for room-level rate availability analysis."
    - name: "distribution_channel_id"
      expr: distribution_channel_id
      comment: "Distribution channel for channel-level rate availability analysis."
    - name: "revenue_rate_plan_id"
      expr: revenue_rate_plan_id
      comment: "Rate plan identifier for rate plan-level availability analysis."
    - name: "availability_status"
      expr: availability_status
      comment: "Availability status (open, closed, stop-sell) for availability pattern analysis."
    - name: "stop_sell"
      expr: stop_sell
      comment: "Stop-sell flag; tracks inventory closure frequency."
    - name: "closed_to_arrival"
      expr: closed_to_arrival
      comment: "CTA flag for arrival restriction analysis."
    - name: "closed_to_departure"
      expr: closed_to_departure
      comment: "CTD flag for departure restriction analysis."
    - name: "rate_parity_flag"
      expr: rate_parity_flag
      comment: "Rate parity flag for parity compliance monitoring."
    - name: "is_package_rate"
      expr: is_package_rate
      comment: "Package rate flag for package vs standalone rate analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Reporting currency for rate monetary measures."
    - name: "meal_plan_code"
      expr: meal_plan_code
      comment: "Meal plan code for rate inclusion analysis."
  measures:
    - name: "avg_bar_rate"
      expr: AVG(CAST(bar_rate AS DOUBLE))
      comment: "Average Best Available Rate. Primary pricing KPI for rate availability analysis."
    - name: "avg_rack_rate"
      expr: AVG(CAST(rack_rate AS DOUBLE))
      comment: "Average rack rate. Baseline rate for discount and yield analysis."
    - name: "avg_min_rate"
      expr: AVG(CAST(min_rate AS DOUBLE))
      comment: "Average minimum rate floor. Tracks rate floor deployment across channels."
    - name: "avg_max_rate"
      expr: AVG(CAST(max_rate AS DOUBLE))
      comment: "Average maximum rate ceiling. Tracks rate ceiling deployment."
    - name: "avg_occupancy_forecast_pct"
      expr: AVG(CAST(occupancy_forecast_pct AS DOUBLE))
      comment: "Average occupancy forecast at rate availability snapshot. Context for rate decision analysis."
    - name: "stop_sell_count"
      expr: COUNT(CASE WHEN stop_sell = TRUE THEN 1 END)
      comment: "Count of stop-sell records. Tracks inventory closure frequency and patterns."
    - name: "rate_parity_violation_count"
      expr: COUNT(CASE WHEN rate_parity_flag = FALSE THEN 1 END)
      comment: "Count of rate parity violations. Tracks distribution compliance issues."
    - name: "rate_availability_record_count"
      expr: COUNT(1)
      comment: "Total count of rate availability records. Tracks distribution coverage."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`revenue_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue budget planning and target KPI tracking. Enables budget vs actual comparison, strategic target monitoring, and planning cycle management for revenue and finance leadership."
  source: "`vibe_travel_hospitality_v1`.`revenue`.`revenue_budget`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property identifier for property-level budget analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for period-level budget tracking."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual budget planning and review."
    - name: "planning_horizon_type"
      expr: planning_horizon_type
      comment: "Planning horizon type (e.g., annual, quarterly) for budget cycle classification."
    - name: "strategy_type"
      expr: strategy_type
      comment: "Strategy type associated with the budget for strategic initiative tracking."
    - name: "strategy_status"
      expr: strategy_status
      comment: "Status of the budget strategy for filtering active vs archived plans."
    - name: "market_segment_id"
      expr: market_segment_id
      comment: "Market segment for segment-level budget allocation analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Reporting currency for budget monetary measures."
    - name: "is_owner_approved"
      expr: is_owner_approved
      comment: "Owner approval flag for tracking budget approval status."
    - name: "planning_period_start_date"
      expr: planning_period_start_date
      comment: "Start date of the planning period."
    - name: "planning_period_end_date"
      expr: planning_period_end_date
      comment: "End date of the planning period."
  measures:
    - name: "total_budgeted_room_revenue"
      expr: SUM(CAST(budgeted_room_revenue AS DOUBLE))
      comment: "Total budgeted room revenue. Primary revenue planning target for rooms department."
    - name: "total_budgeted_total_revenue"
      expr: SUM(CAST(budgeted_total_revenue AS DOUBLE))
      comment: "Total budgeted property revenue. Overall revenue planning target for owner and executive reporting."
    - name: "total_budgeted_fb_revenue"
      expr: SUM(CAST(budgeted_fb_revenue AS DOUBLE))
      comment: "Total budgeted F&B revenue. F&B department planning target."
    - name: "total_budgeted_events_revenue"
      expr: SUM(CAST(budgeted_events_revenue AS DOUBLE))
      comment: "Total budgeted events revenue. Events department planning target."
    - name: "total_budgeted_gop"
      expr: SUM(CAST(budgeted_gop AS DOUBLE))
      comment: "Total budgeted Gross Operating Profit. Profitability planning target for owner reporting."
    - name: "avg_target_adr"
      expr: AVG(CAST(target_adr AS DOUBLE))
      comment: "Average target ADR. Pricing target for revenue management strategy execution."
    - name: "avg_target_revpar"
      expr: AVG(CAST(target_revpar AS DOUBLE))
      comment: "Average target RevPAR. Primary revenue productivity target for hotel operations."
    - name: "avg_target_occupancy_rate"
      expr: AVG(CAST(target_occupancy_rate AS DOUBLE))
      comment: "Average target occupancy rate. Demand absorption target for inventory management."
    - name: "avg_target_trevpar"
      expr: AVG(CAST(target_trevpar AS DOUBLE))
      comment: "Average target TRevPAR. Total revenue productivity target."
    - name: "avg_target_goppar"
      expr: AVG(CAST(target_goppar AS DOUBLE))
      comment: "Average target GOPPAR. Profitability per available room target for investor reporting."
    - name: "avg_target_alos"
      expr: AVG(CAST(target_alos AS DOUBLE))
      comment: "Average target length of stay. Informs minimum stay restrictions and group strategy."
    - name: "avg_target_ari"
      expr: AVG(CAST(target_ari AS DOUBLE))
      comment: "Average target ARI. Competitive revenue index target for benchmarking strategy."
    - name: "avg_target_mpi"
      expr: AVG(CAST(target_mpi AS DOUBLE))
      comment: "Average target MPI. Market penetration index target."
    - name: "avg_target_rgi"
      expr: AVG(CAST(target_rgi AS DOUBLE))
      comment: "Average target RGI. Revenue generation index target vs competitive set."
    - name: "avg_budgeted_cpor"
      expr: AVG(CAST(budgeted_cpor AS DOUBLE))
      comment: "Average budgeted cost per occupied room. Cost efficiency planning target."
    - name: "budget_record_count"
      expr: COUNT(1)
      comment: "Count of budget records. Tracks budget planning coverage across properties and periods."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`revenue_negotiated_rate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Negotiated rate contract metrics. Tracks negotiated rate levels, commitment performance, and contract status for corporate account and consortia rate management."
  source: "`vibe_travel_hospitality_v1`.`revenue`.`revenue_negotiated_rate`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property identifier for property-level negotiated rate analysis."
    - name: "market_segment_id"
      expr: market_segment_id
      comment: "Market segment for segment-level negotiated rate analysis."
    - name: "room_type_id"
      expr: room_type_id
      comment: "Room type for room-level negotiated rate analysis."
    - name: "rate_type"
      expr: rate_type
      comment: "Rate type (LRA, non-LRA, consortia) for rate category analysis."
    - name: "rate_status"
      expr: rate_status
      comment: "Status of the negotiated rate for filtering active vs expired contracts."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the negotiated rate for governance tracking."
    - name: "is_lra"
      expr: is_lra
      comment: "Last Room Availability flag; LRA rates have higher commitment obligations."
    - name: "is_non_refundable"
      expr: is_non_refundable
      comment: "Non-refundable flag for rate condition analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Reporting currency for negotiated rate monetary measures."
    - name: "contract_start_date"
      expr: contract_start_date
      comment: "Contract start date for contract period analysis."
    - name: "contract_end_date"
      expr: contract_end_date
      comment: "Contract end date for contract expiry tracking."
  measures:
    - name: "avg_negotiated_rate_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average negotiated rate amount. Baseline pricing KPI for corporate rate management."
    - name: "avg_commission_pct"
      expr: AVG(CAST(commission_pct AS DOUBLE))
      comment: "Average commission percentage on negotiated rates. Tracks distribution cost for corporate accounts."
    - name: "avg_rate_bar_variance_pct"
      expr: AVG(CAST(rate_bar_variance_pct AS DOUBLE))
      comment: "Average variance between negotiated rate and BAR. Measures discount depth for corporate accounts."
    - name: "lra_rate_count"
      expr: COUNT(CASE WHEN is_lra = TRUE THEN 1 END)
      comment: "Count of LRA negotiated rates. Tracks high-commitment rate exposure."
    - name: "active_rate_count"
      expr: COUNT(CASE WHEN rate_status = 'ACTIVE' THEN 1 END)
      comment: "Count of active negotiated rates. Tracks live contract portfolio size."
    - name: "negotiated_rate_count"
      expr: COUNT(1)
      comment: "Total count of negotiated rate records. Tracks corporate rate portfolio coverage."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`revenue_rate_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rate plan configuration and pricing metrics. Used by revenue managers and distribution teams to monitor rate plan portfolio, pricing levels, and eligibility rules."
  source: "`vibe_travel_hospitality_v1`.`revenue`.`revenue_rate_plan`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property identifier for property-level rate plan analysis."
    - name: "rate_plan_type"
      expr: rate_plan_type
      comment: "Rate plan type (BAR, negotiated, package, promotional) for rate category analysis."
    - name: "rate_status"
      expr: rate_status
      comment: "Rate plan status (active, inactive, pending) for active rate plan monitoring."
    - name: "rate_category"
      expr: rate_category
      comment: "Rate category for rate portfolio segmentation."
    - name: "rate_level"
      expr: rate_level
      comment: "Rate level for pricing tier analysis."
    - name: "room_type_id"
      expr: room_type_id
      comment: "Room type for product-level rate plan analysis."
    - name: "loyalty_tier_id"
      expr: loyalty_tier_id
      comment: "Loyalty tier for loyalty-linked rate plan analysis."
    - name: "is_commissionable"
      expr: is_commissionable
      comment: "Commissionable flag for distribution cost analysis."
    - name: "gds_eligible"
      expr: gds_eligible
      comment: "GDS eligibility flag for GDS distribution coverage analysis."
    - name: "ota_eligible"
      expr: ota_eligible
      comment: "OTA eligibility flag for OTA distribution coverage analysis."
    - name: "loyalty_points_eligible"
      expr: loyalty_points_eligible
      comment: "Loyalty points eligibility flag for loyalty program rate analysis."
    - name: "is_refundable"
      expr: is_refundable
      comment: "Refundable flag for cancellation policy and revenue risk analysis."
    - name: "tax_inclusive"
      expr: tax_inclusive
      comment: "Tax inclusive flag for rate comparison normalization."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for rate normalization."
  measures:
    - name: "avg_base_rate_amount"
      expr: AVG(CAST(base_rate_amount AS DOUBLE))
      comment: "Average base rate amount across rate plans. Pricing level benchmark for rate portfolio analysis."
    - name: "avg_rate_floor_amount"
      expr: AVG(CAST(rate_floor_amount AS DOUBLE))
      comment: "Average rate floor amount. Minimum pricing protection across rate plans."
    - name: "avg_rate_ceiling_amount"
      expr: AVG(CAST(rate_ceiling_amount AS DOUBLE))
      comment: "Average rate ceiling amount. Maximum pricing cap across rate plans."
    - name: "avg_discount_pct"
      expr: AVG(CAST(discount_pct AS DOUBLE))
      comment: "Average discount percentage across rate plans. Measures rate plan discount depth for revenue optimization."
    - name: "avg_commission_pct"
      expr: AVG(CAST(commission_pct AS DOUBLE))
      comment: "Average commission percentage across rate plans. Distribution cost metric for channel profitability."
    - name: "active_rate_plan_count"
      expr: COUNT(CASE WHEN rate_status = 'active' THEN 1 END)
      comment: "Number of active rate plans. Monitors rate plan portfolio size and complexity."
    - name: "total_rate_plan_count"
      expr: COUNT(1)
      comment: "Total number of rate plans. Rate portfolio coverage metric."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`revenue_str_benchmark`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "STR (Smith Travel Research) competitive benchmarking metrics. Tracks property performance vs competitive set across ADR, occupancy, RevPAR, ARI, MPI, and RGI. Essential for competitive positioning decisions."
  source: "`vibe_travel_hospitality_v1`.`revenue`.`str_benchmark`"
  dimensions:
    - name: "stay_date"
      expr: stay_date
      comment: "Stay date for the benchmark record; primary time dimension for competitive trend analysis."
    - name: "property_id"
      expr: property_id
      comment: "Property identifier for property-level competitive benchmarking."
    - name: "competitive_set_id"
      expr: competitive_set_id
      comment: "Competitive set identifier for comp set-level analysis."
    - name: "market_segment_id"
      expr: market_segment_id
      comment: "Market segment for segment-level competitive benchmarking."
    - name: "report_period_type"
      expr: report_period_type
      comment: "Report period type (daily, weekly, monthly) for period-level benchmarking."
    - name: "benchmark_currency_code"
      expr: benchmark_currency_code
      comment: "Currency for benchmark monetary measures."
    - name: "benchmark_status"
      expr: benchmark_status
      comment: "Status of the benchmark record for data quality filtering."
    - name: "is_rate_parity_compliant"
      expr: is_rate_parity_compliant
      comment: "Rate parity compliance flag; non-compliant records indicate distribution strategy issues."
    - name: "report_period_start_date"
      expr: report_period_start_date
      comment: "Start date of the STR report period."
    - name: "report_period_end_date"
      expr: report_period_end_date
      comment: "End date of the STR report period."
  measures:
    - name: "avg_property_adr"
      expr: AVG(CAST(property_adr AS DOUBLE))
      comment: "Average property ADR from STR data. Own-property pricing performance."
    - name: "avg_comp_set_adr"
      expr: AVG(CAST(comp_set_adr AS DOUBLE))
      comment: "Average competitive set ADR. Benchmark for pricing strategy calibration."
    - name: "avg_property_occupancy_rate"
      expr: AVG(CAST(property_occupancy_rate AS DOUBLE))
      comment: "Average property occupancy rate from STR. Own-property demand performance."
    - name: "avg_comp_set_occupancy_rate"
      expr: AVG(CAST(comp_set_occupancy_rate AS DOUBLE))
      comment: "Average competitive set occupancy rate. Benchmark for demand performance."
    - name: "avg_property_revpar"
      expr: AVG(CAST(property_revpar AS DOUBLE))
      comment: "Average property RevPAR from STR. Own-property revenue productivity."
    - name: "avg_comp_set_revpar"
      expr: AVG(CAST(comp_set_revpar AS DOUBLE))
      comment: "Average competitive set RevPAR. Benchmark for revenue productivity comparison."
    - name: "avg_ari"
      expr: AVG(CAST(ari AS DOUBLE))
      comment: "Average Accommodation Revenue Index. Measures revenue share vs competitive set; >100 means outperforming."
    - name: "avg_mpi"
      expr: AVG(CAST(mpi AS DOUBLE))
      comment: "Average Market Penetration Index. Measures occupancy share vs competitive set."
    - name: "avg_rgi"
      expr: AVG(CAST(rgi AS DOUBLE))
      comment: "Average Revenue Generation Index. Overall competitive revenue performance index."
    - name: "avg_shopped_rate_amount"
      expr: AVG(CAST(shopped_rate_amount AS DOUBLE))
      comment: "Average shopped rate from STR. Competitive rate intelligence for pricing decisions."
    - name: "rate_parity_compliant_count"
      expr: COUNT(CASE WHEN is_rate_parity_compliant = TRUE THEN 1 END)
      comment: "Count of rate parity compliant records. Tracks distribution compliance."
    - name: "benchmark_record_count"
      expr: COUNT(1)
      comment: "Count of STR benchmark records. Tracks data coverage for competitive analysis."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`revenue_strategy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue strategy planning and target metrics. Tracks strategic KPI targets, strategy status, and planning horizon coverage for executive and revenue management steering."
  source: "`vibe_travel_hospitality_v1`.`revenue`.`strategy`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property identifier for property-level strategy analysis."
    - name: "strategy_type"
      expr: strategy_type
      comment: "Strategy type for strategy category analysis."
    - name: "strategy_status"
      expr: strategy_status
      comment: "Status of the strategy (active, superseded, draft) for pipeline tracking."
    - name: "horizon_type"
      expr: horizon_type
      comment: "Planning horizon type (short, medium, long-term) for strategy horizon analysis."
    - name: "pricing_approach"
      expr: pricing_approach
      comment: "Pricing approach for strategy methodology analysis."
    - name: "primary_market_segment_focus"
      expr: primary_market_segment_focus
      comment: "Primary market segment focus for strategy segmentation analysis."
    - name: "special_event_flag"
      expr: special_event_flag
      comment: "Special event flag for event-driven strategy analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Reporting currency for strategy monetary targets."
    - name: "planning_horizon_start_date"
      expr: planning_horizon_start_date
      comment: "Start date of the strategy planning horizon."
    - name: "planning_horizon_end_date"
      expr: planning_horizon_end_date
      comment: "End date of the strategy planning horizon."
  measures:
    - name: "avg_target_revpar"
      expr: AVG(CAST(target_revpar AS DOUBLE))
      comment: "Average target RevPAR across strategies. Primary revenue productivity target for strategy evaluation."
    - name: "avg_target_adr"
      expr: AVG(CAST(target_adr AS DOUBLE))
      comment: "Average target ADR. Pricing target for strategy execution."
    - name: "avg_target_occupancy_pct"
      expr: AVG(CAST(target_occupancy_pct AS DOUBLE))
      comment: "Average target occupancy percentage. Demand target for strategy planning."
    - name: "avg_target_trevpar"
      expr: AVG(CAST(target_trevpar AS DOUBLE))
      comment: "Average target TRevPAR. Total revenue productivity target."
    - name: "avg_target_goppar"
      expr: AVG(CAST(target_goppar AS DOUBLE))
      comment: "Average target GOPPAR. Profitability target for owner and investor reporting."
    - name: "avg_target_ari"
      expr: AVG(CAST(target_ari AS DOUBLE))
      comment: "Average target ARI. Competitive revenue index target."
    - name: "avg_target_mpi"
      expr: AVG(CAST(target_mpi AS DOUBLE))
      comment: "Average target MPI. Market penetration index target."
    - name: "avg_target_rgi"
      expr: AVG(CAST(target_rgi AS DOUBLE))
      comment: "Average target RGI. Revenue generation index target."
    - name: "active_strategy_count"
      expr: COUNT(CASE WHEN strategy_status = 'ACTIVE' THEN 1 END)
      comment: "Count of active strategies. Tracks live strategy portfolio."
    - name: "strategy_count"
      expr: COUNT(1)
      comment: "Total count of strategy records. Tracks strategy planning activity."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`revenue_total_revenue_actuals`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Consolidated total revenue actuals view for property-level P&L reporting, covering all revenue streams, profitability indices, and budget variance. Used in owner reports and executive dashboards."
  source: "`vibe_travel_hospitality_v1`.`revenue`.`total_revenue_actuals`"
  dimensions:
    - name: "stay_date"
      expr: stay_date
      comment: "Stay date for the revenue record; primary time dimension for daily revenue trending."
    - name: "property_id"
      expr: property_id
      comment: "Property identifier for property-level revenue aggregation."
    - name: "currency_code"
      expr: currency_code
      comment: "Reporting currency for monetary measures."
    - name: "day_of_week"
      expr: day_of_week
      comment: "Day of week for weekday vs weekend revenue pattern analysis."
    - name: "is_weekend"
      expr: is_weekend
      comment: "Weekend flag for segmenting leisure vs business demand patterns."
    - name: "is_holiday"
      expr: is_holiday
      comment: "Holiday flag for special event revenue analysis."
    - name: "is_special_event"
      expr: is_special_event
      comment: "Special event flag for event-driven demand and pricing analysis."
    - name: "record_status"
      expr: record_status
      comment: "Record status for filtering finalized vs preliminary data."
    - name: "reporting_segment"
      expr: reporting_segment
      comment: "Reporting segment for segment-level revenue attribution."
    - name: "cost_center_id"
      expr: cost_center_id
      comment: "Cost center for departmental revenue reporting."
    - name: "profit_center_id"
      expr: profit_center_id
      comment: "Profit center for P&L segmentation."
    - name: "fiscal_period_id"
      expr: fiscal_period_id
      comment: "Fiscal period for period-over-period financial reporting."
  measures:
    - name: "total_revenue"
      expr: SUM(CAST(total_revenue AS DOUBLE))
      comment: "Total property revenue across all streams. Primary top-line KPI for owner and investor reporting."
    - name: "total_rooms_revenue"
      expr: SUM(CAST(rooms_revenue AS DOUBLE))
      comment: "Total rooms revenue. Core revenue stream for hotel operations."
    - name: "total_fb_revenue"
      expr: SUM(CAST(fb_revenue AS DOUBLE))
      comment: "Total F&B revenue. Tracks food and beverage contribution to total revenue."
    - name: "total_spa_revenue"
      expr: SUM(CAST(spa_revenue AS DOUBLE))
      comment: "Total spa revenue. Wellness revenue stream performance."
    - name: "total_parking_revenue"
      expr: SUM(CAST(parking_revenue AS DOUBLE))
      comment: "Total parking revenue. Ancillary revenue stream."
    - name: "total_other_operated_dept_revenue"
      expr: SUM(CAST(other_operated_dept_revenue AS DOUBLE))
      comment: "Total other operated department revenue. Captures miscellaneous revenue streams."
    - name: "total_miscellaneous_income"
      expr: SUM(CAST(miscellaneous_income AS DOUBLE))
      comment: "Total miscellaneous income. Tracks non-standard revenue items."
    - name: "total_operating_expenses"
      expr: SUM(CAST(total_operating_expenses AS DOUBLE))
      comment: "Total operating expenses. Key cost driver for GOP and EBITDA calculation."
    - name: "total_gop"
      expr: SUM(CAST(gop_amount AS DOUBLE))
      comment: "Total Gross Operating Profit. Core profitability measure for operational and owner reporting."
    - name: "total_ebitda_contribution"
      expr: SUM(CAST(ebitda_contribution AS DOUBLE))
      comment: "Total EBITDA contribution. Investor-facing profitability KPI."
    - name: "avg_adr"
      expr: AVG(CAST(adr AS DOUBLE))
      comment: "Average Daily Rate. Primary pricing KPI for revenue management."
    - name: "avg_revpar"
      expr: AVG(CAST(revpar AS DOUBLE))
      comment: "Average RevPAR. Most-watched revenue productivity KPI in hospitality."
    - name: "avg_occupancy_pct"
      expr: AVG(CAST(occupancy_pct AS DOUBLE))
      comment: "Average occupancy percentage. Demand absorption and inventory utilization indicator."
    - name: "avg_trevpar"
      expr: AVG(CAST(trevpar AS DOUBLE))
      comment: "Average TRevPAR. Total revenue productivity per available room."
    - name: "avg_goppar"
      expr: AVG(CAST(goppar AS DOUBLE))
      comment: "Average GOPPAR. Profitability per available room; used in owner/investor benchmarking."
    - name: "avg_cpor"
      expr: AVG(CAST(cpor AS DOUBLE))
      comment: "Average Cost Per Occupied Room. Operational efficiency KPI."
    - name: "avg_ari"
      expr: AVG(CAST(ari AS DOUBLE))
      comment: "Average ARI. Competitive revenue index vs comp set."
    - name: "avg_mpi"
      expr: AVG(CAST(mpi AS DOUBLE))
      comment: "Average MPI. Market penetration index vs competitive set."
    - name: "avg_rgi"
      expr: AVG(CAST(rgi AS DOUBLE))
      comment: "Average RGI. Revenue generation index; overall competitive revenue share."
    - name: "budget_variance_total_revenue"
      expr: SUM(CAST(total_revenue AS DOUBLE) - CAST(total_revenue_budget AS DOUBLE))
      comment: "Total revenue vs budget variance. Drives reforecast and strategic intervention decisions."
    - name: "budget_variance_rooms_revenue"
      expr: SUM(CAST(rooms_revenue AS DOUBLE) - CAST(rooms_revenue_budget AS DOUBLE))
      comment: "Rooms revenue vs budget variance. Tracks pricing and occupancy execution vs plan."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`revenue_wash_factor`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Group block wash factor analysis. Tracks historical and adjusted wash percentages by market segment, room type, and lead time to improve group revenue forecasting accuracy."
  source: "`vibe_travel_hospitality_v1`.`revenue`.`wash_factor`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property identifier for property-level wash factor analysis."
    - name: "market_segment_id"
      expr: market_segment_id
      comment: "Market segment for segment-level wash factor benchmarking."
    - name: "room_type_id"
      expr: room_type_id
      comment: "Room type for room-category wash factor analysis."
    - name: "group_type"
      expr: group_type
      comment: "Group type for group-category wash factor analysis."
    - name: "block_size_tier"
      expr: block_size_tier
      comment: "Block size tier for size-based wash factor segmentation."
    - name: "booking_lead_time_bucket"
      expr: booking_lead_time_bucket
      comment: "Lead time bucket for lead-time-based wash factor analysis."
    - name: "season_type"
      expr: season_type
      comment: "Season type for seasonal wash factor patterns."
    - name: "factor_status"
      expr: factor_status
      comment: "Status of the wash factor record for filtering active vs archived factors."
    - name: "is_default_factor"
      expr: is_default_factor
      comment: "Flag indicating default wash factor for baseline analysis."
    - name: "is_rms_active"
      expr: is_rms_active
      comment: "Flag indicating whether the wash factor is active in the RMS."
    - name: "effective_date"
      expr: effective_date
      comment: "Effective date of the wash factor for temporal analysis."
  measures:
    - name: "avg_historical_wash_pct"
      expr: AVG(CAST(historical_wash_pct AS DOUBLE))
      comment: "Average historical wash percentage. Baseline measure for group attrition forecasting."
    - name: "avg_adjusted_wash_pct"
      expr: AVG(CAST(adjusted_wash_pct AS DOUBLE))
      comment: "Average adjusted wash percentage. Current calibrated wash factor used in group evaluations."
    - name: "avg_wash_pct_variance"
      expr: AVG(CAST(wash_pct_variance AS DOUBLE))
      comment: "Average variance between historical and adjusted wash. Tracks calibration adjustments."
    - name: "avg_displacement_impact_pct"
      expr: AVG(CAST(displacement_impact_pct AS DOUBLE))
      comment: "Average displacement impact percentage. Measures how wash affects transient displacement calculations."
    - name: "avg_confidence_level_pct"
      expr: AVG(CAST(confidence_level_pct AS DOUBLE))
      comment: "Average confidence level of the wash factor. Indicates statistical reliability for decision-making."
    - name: "wash_factor_count"
      expr: COUNT(1)
      comment: "Count of wash factor records. Tracks wash factor library coverage."
$$;
