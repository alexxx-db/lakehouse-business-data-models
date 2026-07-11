-- Metric views for domain: revenue | Business: Travel_Hospitality | Version: 2 | Generated on: 2026-07-10 20:25:58

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`revenue_channel_contribution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Channel Contribution business metrics"
  source: "`vibe_travel_hospitality_v1`.`revenue`.`channel_contribution`"
  dimensions:
    - name: "Booking Volume"
      expr: booking_volume
    - name: "Business Date"
      expr: business_date
    - name: "Cancellation Count"
      expr: cancellation_count
    - name: "Channel Type"
      expr: channel_type
    - name: "Contribution Status"
      expr: contribution_status
    - name: "Currency Code"
      expr: currency_code
    - name: "Data Extract Timestamp"
      expr: data_extract_timestamp
    - name: "Is Direct Channel"
      expr: is_direct_channel
    - name: "Is Ota Channel"
      expr: is_ota_channel
    - name: "Loyalty Bookings Count"
      expr: loyalty_bookings_count
    - name: "No Show Count"
      expr: no_show_count
    - name: "Nrr Bookings Count"
      expr: nrr_bookings_count
    - name: "Record Created Timestamp"
      expr: record_created_timestamp
    - name: "Record Updated Timestamp"
      expr: record_updated_timestamp
    - name: "Reporting Granularity"
      expr: reporting_granularity
    - name: "Reporting Period End Date"
      expr: reporting_period_end_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Channel Contribution"
      expr: COUNT(DISTINCT channel_contribution_id)
    - name: "Total Adr"
      expr: SUM(adr)
    - name: "Average Adr"
      expr: AVG(adr)
    - name: "Total Advance Booking Days"
      expr: SUM(advance_booking_days)
    - name: "Average Advance Booking Days"
      expr: AVG(advance_booking_days)
    - name: "Total Alos"
      expr: SUM(alos)
    - name: "Average Alos"
      expr: AVG(alos)
    - name: "Total Cancellation Rate Pct"
      expr: SUM(cancellation_rate_pct)
    - name: "Average Cancellation Rate Pct"
      expr: AVG(cancellation_rate_pct)
    - name: "Total Channel Mix Pct"
      expr: SUM(channel_mix_pct)
    - name: "Average Channel Mix Pct"
      expr: AVG(channel_mix_pct)
    - name: "Total Commission Amount"
      expr: SUM(commission_amount)
    - name: "Average Commission Amount"
      expr: AVG(commission_amount)
    - name: "Total Commission Rate Pct"
      expr: SUM(commission_rate_pct)
    - name: "Average Commission Rate Pct"
      expr: AVG(commission_rate_pct)
    - name: "Total Cost Per Booking"
      expr: SUM(cost_per_booking)
    - name: "Average Cost Per Booking"
      expr: AVG(cost_per_booking)
    - name: "Total Gds Transaction Fees"
      expr: SUM(gds_transaction_fees)
    - name: "Average Gds Transaction Fees"
      expr: AVG(gds_transaction_fees)
    - name: "Total Gross Revenue"
      expr: SUM(gross_revenue)
    - name: "Average Gross Revenue"
      expr: AVG(gross_revenue)
    - name: "Total Net Revenue"
      expr: SUM(net_revenue)
    - name: "Average Net Revenue"
      expr: AVG(net_revenue)
    - name: "Total Occupancy Pct"
      expr: SUM(occupancy_pct)
    - name: "Average Occupancy Pct"
      expr: AVG(occupancy_pct)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`revenue_competitive_set`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Competitive Set business metrics"
  source: "`vibe_travel_hospitality_v1`.`revenue`.`competitive_set`"
  dimensions:
    - name: "Advance Purchase Window Days"
      expr: advance_purchase_window_days
    - name: "Approval Date"
      expr: approval_date
    - name: "Approved By"
      expr: approved_by
    - name: "Benchmarking Currency Code"
      expr: benchmarking_currency_code
    - name: "Competitive Set Status"
      expr: competitive_set_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Demand Segment Focus"
      expr: demand_segment_focus
    - name: "Effective From"
      expr: effective_from
    - name: "Effective Until"
      expr: effective_until
    - name: "Geographic Market"
      expr: geographic_market
    - name: "Ideass Comp Set Code"
      expr: ideass_comp_set_code
    - name: "Is Str Submitted"
      expr: is_str_submitted
    - name: "Last Reviewed Date"
      expr: last_reviewed_date
    - name: "Los Benchmark Nights"
      expr: los_benchmark_nights
    - name: "Market Country Code"
      expr: market_country_code
    - name: "Market Segment"
      expr: market_segment
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Competitive Set"
      expr: COUNT(DISTINCT competitive_set_id)
    - name: "Total Ari Target"
      expr: SUM(ari_target)
    - name: "Average Ari Target"
      expr: AVG(ari_target)
    - name: "Total Mpi Target"
      expr: SUM(mpi_target)
    - name: "Average Mpi Target"
      expr: AVG(mpi_target)
    - name: "Total Rgi Target"
      expr: SUM(rgi_target)
    - name: "Average Rgi Target"
      expr: AVG(rgi_target)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`revenue_competitor_rate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Competitor Rate business metrics"
  source: "`vibe_travel_hospitality_v1`.`revenue`.`competitor_rate`"
  dimensions:
    - name: "Availability Status"
      expr: availability_status
    - name: "Cancellation Policy"
      expr: cancellation_policy
    - name: "Channel Name"
      expr: channel_name
    - name: "Channel Shopped"
      expr: channel_shopped
    - name: "Competitor Property Name"
      expr: competitor_property_name
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Data Source"
      expr: data_source
    - name: "Data Source Reference"
      expr: data_source_reference
    - name: "Day Of Week"
      expr: day_of_week
    - name: "Fees Included"
      expr: fees_included
    - name: "Is Weekend"
      expr: is_weekend
    - name: "Lead Time Days"
      expr: lead_time_days
    - name: "Los Nights"
      expr: los_nights
    - name: "Market Code"
      expr: market_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Competitor Rate"
      expr: COUNT(DISTINCT competitor_rate_id)
    - name: "Total Ari"
      expr: SUM(ari)
    - name: "Average Ari"
      expr: AVG(ari)
    - name: "Total Our Rate"
      expr: SUM(our_rate)
    - name: "Average Our Rate"
      expr: AVG(our_rate)
    - name: "Total Previous Shopped Rate"
      expr: SUM(previous_shopped_rate)
    - name: "Average Previous Shopped Rate"
      expr: AVG(previous_shopped_rate)
    - name: "Total Rate Delta"
      expr: SUM(rate_delta)
    - name: "Average Rate Delta"
      expr: AVG(rate_delta)
    - name: "Total Rate Gap"
      expr: SUM(rate_gap)
    - name: "Average Rate Gap"
      expr: AVG(rate_gap)
    - name: "Total Rate In Usd"
      expr: SUM(rate_in_usd)
    - name: "Average Rate In Usd"
      expr: AVG(rate_in_usd)
    - name: "Total Shop Run Reference"
      expr: SUM(shop_run_reference)
    - name: "Average Shop Run Reference"
      expr: AVG(shop_run_reference)
    - name: "Total Shopped Rate"
      expr: SUM(shopped_rate)
    - name: "Average Shopped Rate"
      expr: AVG(shopped_rate)
    - name: "Total Star Rating"
      expr: SUM(star_rating)
    - name: "Average Star Rating"
      expr: AVG(star_rating)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`revenue_demand_forecast`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Demand Forecast business metrics"
  source: "`vibe_travel_hospitality_v1`.`revenue`.`demand_forecast`"
  dimensions:
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Day Of Week"
      expr: day_of_week
    - name: "Forecast Date"
      expr: forecast_date
    - name: "Forecast Granularity"
      expr: forecast_granularity
    - name: "Forecast Horizon Days"
      expr: forecast_horizon_days
    - name: "Forecast Model Type"
      expr: forecast_model_type
    - name: "Forecast Model Version"
      expr: forecast_model_version
    - name: "Forecast Run Reference"
      expr: forecast_run_reference
    - name: "Forecast Run Timestamp"
      expr: forecast_run_timestamp
    - name: "Forecast Status"
      expr: forecast_status
    - name: "Forecast Type"
      expr: forecast_type
    - name: "Is Holiday"
      expr: is_holiday
    - name: "Is Override"
      expr: is_override
    - name: "Is Special Event"
      expr: is_special_event
    - name: "Projected Rooms Available"
      expr: projected_rooms_available
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Demand Forecast"
      expr: COUNT(DISTINCT demand_forecast_id)
    - name: "Total Ari Forecast"
      expr: SUM(ari_forecast)
    - name: "Average Ari Forecast"
      expr: AVG(ari_forecast)
    - name: "Total Booking Pace Index"
      expr: SUM(booking_pace_index)
    - name: "Average Booking Pace Index"
      expr: AVG(booking_pace_index)
    - name: "Total Confidence Interval Lower"
      expr: SUM(confidence_interval_lower)
    - name: "Average Confidence Interval Lower"
      expr: AVG(confidence_interval_lower)
    - name: "Total Confidence Interval Upper"
      expr: SUM(confidence_interval_upper)
    - name: "Average Confidence Interval Upper"
      expr: AVG(confidence_interval_upper)
    - name: "Total Confidence Level Pct"
      expr: SUM(confidence_level_pct)
    - name: "Average Confidence Level Pct"
      expr: AVG(confidence_level_pct)
    - name: "Total Constrained Demand"
      expr: SUM(constrained_demand)
    - name: "Average Constrained Demand"
      expr: AVG(constrained_demand)
    - name: "Total Demand Segment Mix Pct"
      expr: SUM(demand_segment_mix_pct)
    - name: "Average Demand Segment Mix Pct"
      expr: AVG(demand_segment_mix_pct)
    - name: "Total Forecast Accuracy Mape"
      expr: SUM(forecast_accuracy_mape)
    - name: "Average Forecast Accuracy Mape"
      expr: AVG(forecast_accuracy_mape)
    - name: "Total Mpi Forecast"
      expr: SUM(mpi_forecast)
    - name: "Average Mpi Forecast"
      expr: AVG(mpi_forecast)
    - name: "Total Projected Adr"
      expr: SUM(projected_adr)
    - name: "Average Projected Adr"
      expr: AVG(projected_adr)
    - name: "Total Projected Cancellations"
      expr: SUM(projected_cancellations)
    - name: "Average Projected Cancellations"
      expr: AVG(projected_cancellations)
    - name: "Total Projected No Shows"
      expr: SUM(projected_no_shows)
    - name: "Average Projected No Shows"
      expr: AVG(projected_no_shows)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`revenue_displacement_analysis`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Displacement Analysis business metrics"
  source: "`vibe_travel_hospitality_v1`.`revenue`.`displacement_analysis`"
  dimensions:
    - name: "Analysis Date"
      expr: analysis_date
    - name: "Analysis Reference Number"
      expr: analysis_reference_number
    - name: "Analysis Status"
      expr: analysis_status
    - name: "Analysis Type"
      expr: analysis_type
    - name: "Channel Source"
      expr: channel_source
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Decision Rationale"
      expr: decision_rationale
    - name: "Displacement Risk Level"
      expr: displacement_risk_level
    - name: "Estimated Transient Rooms Displaced"
      expr: estimated_transient_rooms_displaced
    - name: "Is Peak Period"
      expr: is_peak_period
    - name: "Is Special Event"
      expr: is_special_event
    - name: "Los Nights"
      expr: los_nights
    - name: "Notes"
      expr: notes
    - name: "Recommendation Outcome"
      expr: recommendation_outcome
    - name: "Reviewed By"
      expr: reviewed_by
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Displacement Analysis"
      expr: COUNT(DISTINCT displacement_analysis_id)
    - name: "Total Ancillary Revenue Contribution"
      expr: SUM(ancillary_revenue_contribution)
    - name: "Average Ancillary Revenue Contribution"
      expr: AVG(ancillary_revenue_contribution)
    - name: "Total Estimated Transient Adr Displaced"
      expr: SUM(estimated_transient_adr_displaced)
    - name: "Average Estimated Transient Adr Displaced"
      expr: AVG(estimated_transient_adr_displaced)
    - name: "Total Fb Revenue Contribution"
      expr: SUM(fb_revenue_contribution)
    - name: "Average Fb Revenue Contribution"
      expr: AVG(fb_revenue_contribution)
    - name: "Total Forecast Occupancy Pct"
      expr: SUM(forecast_occupancy_pct)
    - name: "Average Forecast Occupancy Pct"
      expr: AVG(forecast_occupancy_pct)
    - name: "Total Group Room Revenue"
      expr: SUM(group_room_revenue)
    - name: "Average Group Room Revenue"
      expr: AVG(group_room_revenue)
    - name: "Total Min Acceptable Rate"
      expr: SUM(min_acceptable_rate)
    - name: "Average Min Acceptable Rate"
      expr: AVG(min_acceptable_rate)
    - name: "Total Net Revenue Impact"
      expr: SUM(net_revenue_impact)
    - name: "Average Net Revenue Impact"
      expr: AVG(net_revenue_impact)
    - name: "Total Proposed Group Rate"
      expr: SUM(proposed_group_rate)
    - name: "Average Proposed Group Rate"
      expr: AVG(proposed_group_rate)
    - name: "Total Revpar Impact"
      expr: SUM(revpar_impact)
    - name: "Average Revpar Impact"
      expr: AVG(revpar_impact)
    - name: "Total Total Group Spend"
      expr: SUM(total_group_spend)
    - name: "Average Total Group Spend"
      expr: AVG(total_group_spend)
    - name: "Total Transient Room Revenue Displaced"
      expr: SUM(transient_room_revenue_displaced)
    - name: "Average Transient Room Revenue Displaced"
      expr: AVG(transient_room_revenue_displaced)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`revenue_dynamic_rate_rule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dynamic Rate Rule business metrics"
  source: "`vibe_travel_hospitality_v1`.`revenue`.`dynamic_rate_rule`"
  dimensions:
    - name: "Adjustment Direction"
      expr: adjustment_direction
    - name: "Adjustment Type"
      expr: adjustment_type
    - name: "Advance Booking Max Days"
      expr: advance_booking_max_days
    - name: "Advance Booking Min Days"
      expr: advance_booking_min_days
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved By"
      expr: approved_by
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Days Of Week Mask"
      expr: days_of_week_mask
    - name: "Effective From"
      expr: effective_from
    - name: "Effective Until"
      expr: effective_until
    - name: "Is Stackable"
      expr: is_stackable
    - name: "Last Triggered Timestamp"
      expr: last_triggered_timestamp
    - name: "Los Max Nights"
      expr: los_max_nights
    - name: "Los Min Nights"
      expr: los_min_nights
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Dynamic Rate Rule"
      expr: COUNT(DISTINCT dynamic_rate_rule_id)
    - name: "Total Adjustment Value"
      expr: SUM(adjustment_value)
    - name: "Average Adjustment Value"
      expr: AVG(adjustment_value)
    - name: "Total Max Rate Ceiling"
      expr: SUM(max_rate_ceiling)
    - name: "Average Max Rate Ceiling"
      expr: AVG(max_rate_ceiling)
    - name: "Total Min Rate Floor"
      expr: SUM(min_rate_floor)
    - name: "Average Min Rate Floor"
      expr: AVG(min_rate_floor)
    - name: "Total Trigger Threshold Value"
      expr: SUM(trigger_threshold_value)
    - name: "Average Trigger Threshold Value"
      expr: AVG(trigger_threshold_value)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`revenue_group_evaluation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Group Evaluation business metrics"
  source: "`vibe_travel_hospitality_v1`.`revenue`.`group_evaluation`"
  dimensions:
    - name: "Arrival Date"
      expr: arrival_date
    - name: "Channel Code"
      expr: channel_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Cutoff Date"
      expr: cutoff_date
    - name: "Decision Override Reason"
      expr: decision_override_reason
    - name: "Decision Timestamp"
      expr: decision_timestamp
    - name: "Departure Date"
      expr: departure_date
    - name: "Evaluation Status"
      expr: evaluation_status
    - name: "Evaluation Timestamp"
      expr: evaluation_timestamp
    - name: "Group Name"
      expr: group_name
    - name: "Group Type"
      expr: group_type
    - name: "Inquiry Reference Number"
      expr: inquiry_reference_number
    - name: "Is Definite Booking"
      expr: is_definite_booking
    - name: "Lead Time Bucket"
      expr: lead_time_bucket
    - name: "Los Nights"
      expr: los_nights
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Group Evaluation"
      expr: COUNT(DISTINCT group_evaluation_id)
    - name: "Total Ancillary Revenue Estimate"
      expr: SUM(ancillary_revenue_estimate)
    - name: "Average Ancillary Revenue Estimate"
      expr: AVG(ancillary_revenue_estimate)
    - name: "Total Attrition Pct"
      expr: SUM(attrition_pct)
    - name: "Average Attrition Pct"
      expr: AVG(attrition_pct)
    - name: "Total Counter Offer Rate"
      expr: SUM(counter_offer_rate)
    - name: "Average Counter Offer Rate"
      expr: AVG(counter_offer_rate)
    - name: "Total Demand Forecast Occupancy Pct"
      expr: SUM(demand_forecast_occupancy_pct)
    - name: "Average Demand Forecast Occupancy Pct"
      expr: AVG(demand_forecast_occupancy_pct)
    - name: "Total Displacement Cost"
      expr: SUM(displacement_cost)
    - name: "Average Displacement Cost"
      expr: AVG(displacement_cost)
    - name: "Total Fb Revenue Estimate"
      expr: SUM(fb_revenue_estimate)
    - name: "Average Fb Revenue Estimate"
      expr: AVG(fb_revenue_estimate)
    - name: "Total Group Room Revenue"
      expr: SUM(group_room_revenue)
    - name: "Average Group Room Revenue"
      expr: AVG(group_room_revenue)
    - name: "Total Historical Wash Pct"
      expr: SUM(historical_wash_pct)
    - name: "Average Historical Wash Pct"
      expr: AVG(historical_wash_pct)
    - name: "Total Minimum Acceptable Rate"
      expr: SUM(minimum_acceptable_rate)
    - name: "Average Minimum Acceptable Rate"
      expr: AVG(minimum_acceptable_rate)
    - name: "Total Net Revenue Impact"
      expr: SUM(net_revenue_impact)
    - name: "Average Net Revenue Impact"
      expr: AVG(net_revenue_impact)
    - name: "Total Proposed Group Rate"
      expr: SUM(proposed_group_rate)
    - name: "Average Proposed Group Rate"
      expr: AVG(proposed_group_rate)
    - name: "Total Revpar Impact"
      expr: SUM(revpar_impact)
    - name: "Average Revpar Impact"
      expr: AVG(revpar_impact)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`revenue_inventory_control`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory Control business metrics"
  source: "`vibe_travel_hospitality_v1`.`revenue`.`inventory_control`"
  dimensions:
    - name: "Allotment Rooms"
      expr: allotment_rooms
    - name: "Approval Authority"
      expr: approval_authority
    - name: "Available Room Count"
      expr: available_room_count
    - name: "Control Record Code"
      expr: control_record_code
    - name: "Control Status"
      expr: control_status
    - name: "Control Type"
      expr: control_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Effective From Timestamp"
      expr: effective_from_timestamp
    - name: "Effective Until Timestamp"
      expr: effective_until_timestamp
    - name: "Group Block Rooms"
      expr: group_block_rooms
    - name: "Is Closed To Arrival"
      expr: is_closed_to_arrival
    - name: "Is Closed To Departure"
      expr: is_closed_to_departure
    - name: "Is Override"
      expr: is_override
    - name: "Last Distributed Timestamp"
      expr: last_distributed_timestamp
    - name: "Max Los"
      expr: max_los
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Inventory Control"
      expr: COUNT(DISTINCT inventory_control_id)
    - name: "Total Control Value"
      expr: SUM(control_value)
    - name: "Average Control Value"
      expr: AVG(control_value)
    - name: "Total Current Bar"
      expr: SUM(current_bar)
    - name: "Average Current Bar"
      expr: AVG(current_bar)
    - name: "Total Demand Forecast Rooms"
      expr: SUM(demand_forecast_rooms)
    - name: "Average Demand Forecast Rooms"
      expr: AVG(demand_forecast_rooms)
    - name: "Total Hurdle Rate"
      expr: SUM(hurdle_rate)
    - name: "Average Hurdle Rate"
      expr: AVG(hurdle_rate)
    - name: "Total Max Rate"
      expr: SUM(max_rate)
    - name: "Average Max Rate"
      expr: AVG(max_rate)
    - name: "Total Min Rate"
      expr: SUM(min_rate)
    - name: "Average Min Rate"
      expr: AVG(min_rate)
    - name: "Total Occupancy On Books"
      expr: SUM(occupancy_on_books)
    - name: "Average Occupancy On Books"
      expr: AVG(occupancy_on_books)
    - name: "Total Overbooking Pct"
      expr: SUM(overbooking_pct)
    - name: "Average Overbooking Pct"
      expr: AVG(overbooking_pct)
    - name: "Total System Recommended Value"
      expr: SUM(system_recommended_value)
    - name: "Average System Recommended Value"
      expr: AVG(system_recommended_value)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`revenue_market_segment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Market Segment business metrics"
  source: "`vibe_travel_hospitality_v1`.`revenue`.`market_segment`"
  dimensions:
    - name: "Ada Accommodation Typical"
      expr: ada_accommodation_typical
    - name: "Avg Lead Time Days"
      expr: avg_lead_time_days
    - name: "Cancellation Propensity"
      expr: cancellation_propensity
    - name: "Channel Affinity"
      expr: channel_affinity
    - name: "Commission Eligible"
      expr: commission_eligible
    - name: "Contribution Margin Tier"
      expr: contribution_margin_tier
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Crs Segment Code"
      expr: crs_segment_code
    - name: "Demand Pattern"
      expr: demand_pattern
    - name: "Market Segment Description"
      expr: market_segment_description
    - name: "Effective From"
      expr: effective_from
    - name: "Effective Until"
      expr: effective_until
    - name: "Gdpr Data Subject Applicable"
      expr: gdpr_data_subject_applicable
    - name: "Gds Eligible"
      expr: gds_eligible
    - name: "Group Block Eligible"
      expr: group_block_eligible
    - name: "Hierarchy Level"
      expr: hierarchy_level
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Market Segment"
      expr: COUNT(DISTINCT market_segment_id)
    - name: "Total Avg Length Of Stay Nights"
      expr: SUM(avg_length_of_stay_nights)
    - name: "Average Avg Length Of Stay Nights"
      expr: AVG(avg_length_of_stay_nights)
    - name: "Total Commission Rate Pct"
      expr: SUM(commission_rate_pct)
    - name: "Average Commission Rate Pct"
      expr: AVG(commission_rate_pct)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`revenue_performance_actuals`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Performance Actuals business metrics"
  source: "`vibe_travel_hospitality_v1`.`revenue`.`performance_actuals`"
  dimensions:
    - name: "Channel Direct Rooms"
      expr: channel_direct_rooms
    - name: "Channel Ota Rooms"
      expr: channel_ota_rooms
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Demand Forecast Rooms"
      expr: demand_forecast_rooms
    - name: "Is Reconciled"
      expr: is_reconciled
    - name: "Performance Date"
      expr: performance_date
    - name: "Record Status"
      expr: record_status
    - name: "Rooms Available"
      expr: rooms_available
    - name: "Rooms Complimentary"
      expr: rooms_complimentary
    - name: "Rooms Out Of Order"
      expr: rooms_out_of_order
    - name: "Rooms Sold"
      expr: rooms_sold
    - name: "Segment Contract Rooms"
      expr: segment_contract_rooms
    - name: "Segment Group Rooms"
      expr: segment_group_rooms
    - name: "Segment Transient Rooms"
      expr: segment_transient_rooms
    - name: "Source System Code"
      expr: source_system_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Performance Actuals"
      expr: COUNT(DISTINCT performance_actuals_id)
    - name: "Total Adr"
      expr: SUM(adr)
    - name: "Average Adr"
      expr: AVG(adr)
    - name: "Total Ancillary Revenue"
      expr: SUM(ancillary_revenue)
    - name: "Average Ancillary Revenue"
      expr: AVG(ancillary_revenue)
    - name: "Total Ari"
      expr: SUM(ari)
    - name: "Average Ari"
      expr: AVG(ari)
    - name: "Total Budget Adr"
      expr: SUM(budget_adr)
    - name: "Average Budget Adr"
      expr: AVG(budget_adr)
    - name: "Total Budget Occupancy Rate"
      expr: SUM(budget_occupancy_rate)
    - name: "Average Budget Occupancy Rate"
      expr: AVG(budget_occupancy_rate)
    - name: "Total Budget Room Revenue"
      expr: SUM(budget_room_revenue)
    - name: "Average Budget Room Revenue"
      expr: AVG(budget_room_revenue)
    - name: "Total Budget Total Revenue"
      expr: SUM(budget_total_revenue)
    - name: "Average Budget Total Revenue"
      expr: AVG(budget_total_revenue)
    - name: "Total Cpor"
      expr: SUM(cpor)
    - name: "Average Cpor"
      expr: AVG(cpor)
    - name: "Total Ebitda Contribution"
      expr: SUM(ebitda_contribution)
    - name: "Average Ebitda Contribution"
      expr: AVG(ebitda_contribution)
    - name: "Total Fb Revenue"
      expr: SUM(fb_revenue)
    - name: "Average Fb Revenue"
      expr: AVG(fb_revenue)
    - name: "Total Gop"
      expr: SUM(gop)
    - name: "Average Gop"
      expr: AVG(gop)
    - name: "Total Goppar"
      expr: SUM(goppar)
    - name: "Average Goppar"
      expr: AVG(goppar)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`revenue_pickup_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pickup Report business metrics"
  source: "`vibe_travel_hospitality_v1`.`revenue`.`pickup_report`"
  dimensions:
    - name: "Channel Code"
      expr: channel_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Day Of Week"
      expr: day_of_week
    - name: "Demand Level"
      expr: demand_level
    - name: "Forecasted Rooms"
      expr: forecasted_rooms
    - name: "Is Special Event"
      expr: is_special_event
    - name: "Is Weekend"
      expr: is_weekend
    - name: "Lead Time Days"
      expr: lead_time_days
    - name: "Los Restriction Active"
      expr: los_restriction_active
    - name: "Min Los"
      expr: min_los
    - name: "Notes"
      expr: notes
    - name: "Prior Year Rooms On Books"
      expr: prior_year_rooms_on_books
    - name: "Rate Plan Code"
      expr: rate_plan_code
    - name: "Report Date"
      expr: report_date
    - name: "Report Number"
      expr: report_number
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Pickup Report"
      expr: COUNT(DISTINCT pickup_report_id)
    - name: "Total Adr On Books"
      expr: SUM(adr_on_books)
    - name: "Average Adr On Books"
      expr: AVG(adr_on_books)
    - name: "Total Adr Variance To Forecast"
      expr: SUM(adr_variance_to_forecast)
    - name: "Average Adr Variance To Forecast"
      expr: AVG(adr_variance_to_forecast)
    - name: "Total Forecasted Adr"
      expr: SUM(forecasted_adr)
    - name: "Average Forecasted Adr"
      expr: AVG(forecasted_adr)
    - name: "Total Forecasted Revpar"
      expr: SUM(forecasted_revpar)
    - name: "Average Forecasted Revpar"
      expr: AVG(forecasted_revpar)
    - name: "Total Pickup Velocity"
      expr: SUM(pickup_velocity)
    - name: "Average Pickup Velocity"
      expr: AVG(pickup_velocity)
    - name: "Total Prior Year Adr"
      expr: SUM(prior_year_adr)
    - name: "Average Prior Year Adr"
      expr: AVG(prior_year_adr)
    - name: "Total Revpar On Books"
      expr: SUM(revpar_on_books)
    - name: "Average Revpar On Books"
      expr: AVG(revpar_on_books)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`revenue_pricing_override`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pricing Override business metrics"
  source: "`vibe_travel_hospitality_v1`.`revenue`.`pricing_override`"
  dimensions:
    - name: "Approval Required"
      expr: approval_required
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Channel Restriction"
      expr: channel_restriction
    - name: "Closed To Arrival"
      expr: closed_to_arrival
    - name: "Closed To Departure"
      expr: closed_to_departure
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Day Of Week Mask"
      expr: day_of_week_mask
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Inventory Rooms Affected"
      expr: inventory_rooms_affected
    - name: "Is Bar Override"
      expr: is_bar_override
    - name: "Los Restriction Max"
      expr: los_restriction_max
    - name: "Los Restriction Min"
      expr: los_restriction_min
    - name: "Override Notes"
      expr: override_notes
    - name: "Override Reason Code"
      expr: override_reason_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Pricing Override"
      expr: COUNT(DISTINCT pricing_override_id)
    - name: "Total Approval Threshold Pct"
      expr: SUM(approval_threshold_pct)
    - name: "Average Approval Threshold Pct"
      expr: AVG(approval_threshold_pct)
    - name: "Total Competitive Rate Reference"
      expr: SUM(competitive_rate_reference)
    - name: "Average Competitive Rate Reference"
      expr: AVG(competitive_rate_reference)
    - name: "Total Override Rate"
      expr: SUM(override_rate)
    - name: "Average Override Rate"
      expr: AVG(override_rate)
    - name: "Total Rate Variance Amount"
      expr: SUM(rate_variance_amount)
    - name: "Average Rate Variance Amount"
      expr: AVG(rate_variance_amount)
    - name: "Total Rate Variance Pct"
      expr: SUM(rate_variance_pct)
    - name: "Average Rate Variance Pct"
      expr: AVG(rate_variance_pct)
    - name: "Total Rms Recommended Rate"
      expr: SUM(rms_recommended_rate)
    - name: "Average Rms Recommended Rate"
      expr: AVG(rms_recommended_rate)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`revenue_rate_availability`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rate Availability business metrics"
  source: "`vibe_travel_hospitality_v1`.`revenue`.`rate_availability`"
  dimensions:
    - name: "Advance Purchase Days"
      expr: advance_purchase_days
    - name: "Availability Status"
      expr: availability_status
    - name: "Available Rooms"
      expr: available_rooms
    - name: "Closed To Arrival"
      expr: closed_to_arrival
    - name: "Closed To Departure"
      expr: closed_to_departure
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Demand Forecast Level"
      expr: demand_forecast_level
    - name: "Effective From Timestamp"
      expr: effective_from_timestamp
    - name: "Effective Until Timestamp"
      expr: effective_until_timestamp
    - name: "Gds Rate Code"
      expr: gds_rate_code
    - name: "Group Block Rooms"
      expr: group_block_rooms
    - name: "Is Package Rate"
      expr: is_package_rate
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "Los Maximum"
      expr: los_maximum
    - name: "Los Minimum"
      expr: los_minimum
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Rate Availability"
      expr: COUNT(DISTINCT rate_availability_id)
    - name: "Total Bar Rate"
      expr: SUM(bar_rate)
    - name: "Average Bar Rate"
      expr: AVG(bar_rate)
    - name: "Total Max Rate"
      expr: SUM(max_rate)
    - name: "Average Max Rate"
      expr: AVG(max_rate)
    - name: "Total Min Rate"
      expr: SUM(min_rate)
    - name: "Average Min Rate"
      expr: AVG(min_rate)
    - name: "Total Occupancy Forecast Pct"
      expr: SUM(occupancy_forecast_pct)
    - name: "Average Occupancy Forecast Pct"
      expr: AVG(occupancy_forecast_pct)
    - name: "Total Rack Rate"
      expr: SUM(rack_rate)
    - name: "Average Rack Rate"
      expr: AVG(rack_rate)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`revenue_rate_restriction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rate Restriction business metrics"
  source: "`vibe_travel_hospitality_v1`.`revenue`.`rate_restriction`"
  dimensions:
    - name: "Advance Purchase Days"
      expr: advance_purchase_days
    - name: "Applied Timestamp"
      expr: applied_timestamp
    - name: "Created By User"
      expr: created_by_user
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Days Of Week Mask"
      expr: days_of_week_mask
    - name: "Demand Forecast Level"
      expr: demand_forecast_level
    - name: "Distribution Status"
      expr: distribution_status
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Is Blackout"
      expr: is_blackout
    - name: "Is Cta"
      expr: is_cta
    - name: "Is Ctd"
      expr: is_ctd
    - name: "Is Loyalty Exempt"
      expr: is_loyalty_exempt
    - name: "Last Distributed Timestamp"
      expr: last_distributed_timestamp
    - name: "Max Advance Purchase Days"
      expr: max_advance_purchase_days
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Rate Restriction"
      expr: COUNT(DISTINCT rate_restriction_id)
    - name: "Total Hurdle Rate Amount"
      expr: SUM(hurdle_rate_amount)
    - name: "Average Hurdle Rate Amount"
      expr: AVG(hurdle_rate_amount)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`revenue_revenue_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue Budget business metrics"
  source: "`vibe_travel_hospitality_v1`.`revenue`.`revenue_budget`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Budgeted Available Rooms"
      expr: budgeted_available_rooms
    - name: "Budgeted Occupied Rooms"
      expr: budgeted_occupied_rooms
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Demand Forecast Source"
      expr: demand_forecast_source
    - name: "Fiscal Period"
      expr: fiscal_period
    - name: "Fiscal Year"
      expr: fiscal_year
    - name: "Is Owner Approved"
      expr: is_owner_approved
    - name: "Key Tactical Actions"
      expr: key_tactical_actions
    - name: "Notes"
      expr: notes
    - name: "Planning Horizon Type"
      expr: planning_horizon_type
    - name: "Planning Period End Date"
      expr: planning_period_end_date
    - name: "Planning Period Start Date"
      expr: planning_period_start_date
    - name: "Property Segment"
      expr: property_segment
    - name: "Reference Number"
      expr: reference_number
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Revenue Budget"
      expr: COUNT(DISTINCT revenue_budget_id)
    - name: "Total Budgeted Cpor"
      expr: SUM(budgeted_cpor)
    - name: "Average Budgeted Cpor"
      expr: AVG(budgeted_cpor)
    - name: "Total Budgeted Events Revenue"
      expr: SUM(budgeted_events_revenue)
    - name: "Average Budgeted Events Revenue"
      expr: AVG(budgeted_events_revenue)
    - name: "Total Budgeted Fb Revenue"
      expr: SUM(budgeted_fb_revenue)
    - name: "Average Budgeted Fb Revenue"
      expr: AVG(budgeted_fb_revenue)
    - name: "Total Budgeted Gop"
      expr: SUM(budgeted_gop)
    - name: "Average Budgeted Gop"
      expr: AVG(budgeted_gop)
    - name: "Total Budgeted Other Revenue"
      expr: SUM(budgeted_other_revenue)
    - name: "Average Budgeted Other Revenue"
      expr: AVG(budgeted_other_revenue)
    - name: "Total Budgeted Room Revenue"
      expr: SUM(budgeted_room_revenue)
    - name: "Average Budgeted Room Revenue"
      expr: AVG(budgeted_room_revenue)
    - name: "Total Budgeted Total Revenue"
      expr: SUM(budgeted_total_revenue)
    - name: "Average Budgeted Total Revenue"
      expr: AVG(budgeted_total_revenue)
    - name: "Total Target Adr"
      expr: SUM(target_adr)
    - name: "Average Target Adr"
      expr: AVG(target_adr)
    - name: "Total Target Alos"
      expr: SUM(target_alos)
    - name: "Average Target Alos"
      expr: AVG(target_alos)
    - name: "Total Target Ari"
      expr: SUM(target_ari)
    - name: "Average Target Ari"
      expr: AVG(target_ari)
    - name: "Total Target Goppar"
      expr: SUM(target_goppar)
    - name: "Average Target Goppar"
      expr: AVG(target_goppar)
    - name: "Total Target Mpi"
      expr: SUM(target_mpi)
    - name: "Average Target Mpi"
      expr: AVG(target_mpi)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`revenue_revenue_negotiated_rate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue Negotiated Rate business metrics"
  source: "`vibe_travel_hospitality_v1`.`revenue`.`revenue_negotiated_rate`"
  dimensions:
    - name: "Advance Booking Days"
      expr: advance_booking_days
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved By"
      expr: approved_by
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Blackout Dates"
      expr: blackout_dates
    - name: "Breakfast Included"
      expr: breakfast_included
    - name: "Committed Room Nights"
      expr: committed_room_nights
    - name: "Consortia Code"
      expr: consortia_code
    - name: "Contract End Date"
      expr: contract_end_date
    - name: "Contract Reference Number"
      expr: contract_reference_number
    - name: "Contract Start Date"
      expr: contract_start_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Gds Chain Code"
      expr: gds_chain_code
    - name: "Iata Number"
      expr: iata_number
    - name: "Is Lra"
      expr: is_lra
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Revenue Negotiated Rate"
      expr: COUNT(DISTINCT revenue_negotiated_rate_id)
    - name: "Total Amount"
      expr: SUM(amount)
    - name: "Average Amount"
      expr: AVG(amount)
    - name: "Total Commission Pct"
      expr: SUM(commission_pct)
    - name: "Average Commission Pct"
      expr: AVG(commission_pct)
    - name: "Total Rate Bar Variance Pct"
      expr: SUM(rate_bar_variance_pct)
    - name: "Average Rate Bar Variance Pct"
      expr: AVG(rate_bar_variance_pct)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`revenue_revenue_overbooking_policy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue Overbooking Policy business metrics"
  source: "`vibe_travel_hospitality_v1`.`revenue`.`revenue_overbooking_policy`"
  dimensions:
    - name: "Ada Room Exempt"
      expr: ada_room_exempt
    - name: "Approval Authority Level"
      expr: approval_authority_level
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Auto Adjust Enabled"
      expr: auto_adjust_enabled
    - name: "Channel Scope"
      expr: channel_scope
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Day Of Week Mask"
      expr: day_of_week_mask
    - name: "Demand Tier"
      expr: demand_tier
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Last Reviewed Date"
      expr: last_reviewed_date
    - name: "Los Restriction Min"
      expr: los_restriction_min
    - name: "Loyalty Points Walk Bonus"
      expr: loyalty_points_walk_bonus
    - name: "Loyalty Tier Exempt"
      expr: loyalty_tier_exempt
    - name: "Next Review Date"
      expr: next_review_date
    - name: "Overbooking Cap"
      expr: overbooking_cap
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Revenue Overbooking Policy"
      expr: COUNT(DISTINCT revenue_overbooking_policy_id)
    - name: "Total Cancellation Rate Assumption Pct"
      expr: SUM(cancellation_rate_assumption_pct)
    - name: "Average Cancellation Rate Assumption Pct"
      expr: AVG(cancellation_rate_assumption_pct)
    - name: "Total Min Overbooking Pct"
      expr: SUM(min_overbooking_pct)
    - name: "Average Min Overbooking Pct"
      expr: AVG(min_overbooking_pct)
    - name: "Total No Show Rate Assumption Pct"
      expr: SUM(no_show_rate_assumption_pct)
    - name: "Average No Show Rate Assumption Pct"
      expr: AVG(no_show_rate_assumption_pct)
    - name: "Total Overbooking Pct"
      expr: SUM(overbooking_pct)
    - name: "Average Overbooking Pct"
      expr: AVG(overbooking_pct)
    - name: "Total Walk Compensation Amount"
      expr: SUM(walk_compensation_amount)
    - name: "Average Walk Compensation Amount"
      expr: AVG(walk_compensation_amount)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`revenue_revenue_rate_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue Rate Plan business metrics"
  source: "`vibe_travel_hospitality_v1`.`revenue`.`revenue_rate_plan`"
  dimensions:
    - name: "Advance Purchase Days"
      expr: advance_purchase_days
    - name: "Approved By"
      expr: approved_by
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Booking Window Close Date"
      expr: booking_window_close_date
    - name: "Booking Window Open Date"
      expr: booking_window_open_date
    - name: "Cancellation Policy Code"
      expr: cancellation_policy_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Drr Eligible"
      expr: drr_eligible
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Gds Eligible"
      expr: gds_eligible
    - name: "Is Commissionable"
      expr: is_commissionable
    - name: "Is Lra Eligible"
      expr: is_lra_eligible
    - name: "Is Refundable"
      expr: is_refundable
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Revenue Rate Plan"
      expr: COUNT(DISTINCT revenue_rate_plan_id)
    - name: "Total Base Rate Amount"
      expr: SUM(base_rate_amount)
    - name: "Average Base Rate Amount"
      expr: AVG(base_rate_amount)
    - name: "Total Commission Pct"
      expr: SUM(commission_pct)
    - name: "Average Commission Pct"
      expr: AVG(commission_pct)
    - name: "Total Discount Pct"
      expr: SUM(discount_pct)
    - name: "Average Discount Pct"
      expr: AVG(discount_pct)
    - name: "Total Rate Ceiling Amount"
      expr: SUM(rate_ceiling_amount)
    - name: "Average Rate Ceiling Amount"
      expr: AVG(rate_ceiling_amount)
    - name: "Total Rate Floor Amount"
      expr: SUM(rate_floor_amount)
    - name: "Average Rate Floor Amount"
      expr: AVG(rate_floor_amount)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`revenue_segment_program_eligibility`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Segment Program Eligibility business metrics"
  source: "`vibe_travel_hospitality_v1`.`revenue`.`segment_program_eligibility`"
  dimensions:
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Enrollment Eligibility Flag"
      expr: enrollment_eligibility_flag
    - name: "Priority Rank"
      expr: priority_rank
    - name: "Effective End Date Month"
      expr: DATE_TRUNC('MONTH', effective_end_date)
    - name: "Effective Start Date Month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Segment Program Eligibility"
      expr: COUNT(DISTINCT segment_program_eligibility_id)
    - name: "Total Program Discount Pct"
      expr: SUM(program_discount_pct)
    - name: "Average Program Discount Pct"
      expr: AVG(program_discount_pct)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`revenue_str_benchmark`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Str Benchmark business metrics"
  source: "`vibe_travel_hospitality_v1`.`revenue`.`str_benchmark`"
  dimensions:
    - name: "Benchmark Currency Code"
      expr: benchmark_currency_code
    - name: "Benchmark Status"
      expr: benchmark_status
    - name: "Comp Set Rooms Available"
      expr: comp_set_rooms_available
    - name: "Competitor Property Code"
      expr: competitor_property_code
    - name: "Competitor Property Name"
      expr: competitor_property_name
    - name: "Data Source"
      expr: data_source
    - name: "Distribution Channel"
      expr: distribution_channel
    - name: "Ingested Timestamp"
      expr: ingested_timestamp
    - name: "Is Rate Parity Compliant"
      expr: is_rate_parity_compliant
    - name: "Lead Time Days"
      expr: lead_time_days
    - name: "Los Nights"
      expr: los_nights
    - name: "Market Location Type"
      expr: market_location_type
    - name: "Ota Platform Name"
      expr: ota_platform_name
    - name: "Property Rooms Available"
      expr: property_rooms_available
    - name: "Rate Availability Status"
      expr: rate_availability_status
    - name: "Rate Plan Type"
      expr: rate_plan_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Str Benchmark"
      expr: COUNT(DISTINCT str_benchmark_id)
    - name: "Total Ari"
      expr: SUM(ari)
    - name: "Average Ari"
      expr: AVG(ari)
    - name: "Total Comp Set Adr"
      expr: SUM(comp_set_adr)
    - name: "Average Comp Set Adr"
      expr: AVG(comp_set_adr)
    - name: "Total Comp Set Occupancy Rate"
      expr: SUM(comp_set_occupancy_rate)
    - name: "Average Comp Set Occupancy Rate"
      expr: AVG(comp_set_occupancy_rate)
    - name: "Total Comp Set Revpar"
      expr: SUM(comp_set_revpar)
    - name: "Average Comp Set Revpar"
      expr: AVG(comp_set_revpar)
    - name: "Total Mpi"
      expr: SUM(mpi)
    - name: "Average Mpi"
      expr: AVG(mpi)
    - name: "Total Property Adr"
      expr: SUM(property_adr)
    - name: "Average Property Adr"
      expr: AVG(property_adr)
    - name: "Total Property Occupancy Rate"
      expr: SUM(property_occupancy_rate)
    - name: "Average Property Occupancy Rate"
      expr: AVG(property_occupancy_rate)
    - name: "Total Property Revpar"
      expr: SUM(property_revpar)
    - name: "Average Property Revpar"
      expr: AVG(property_revpar)
    - name: "Total Rgi"
      expr: SUM(rgi)
    - name: "Average Rgi"
      expr: AVG(rgi)
    - name: "Total Shopped Rate Amount"
      expr: SUM(shopped_rate_amount)
    - name: "Average Shopped Rate Amount"
      expr: AVG(shopped_rate_amount)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`revenue_strategy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategy business metrics"
  source: "`vibe_travel_hospitality_v1`.`revenue`.`strategy`"
  dimensions:
    - name: "Activated Timestamp"
      expr: activated_timestamp
    - name: "Approved By"
      expr: approved_by
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Channel Focus"
      expr: channel_focus
    - name: "Strategy Code"
      expr: strategy_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Horizon Type"
      expr: horizon_type
    - name: "Inventory Control Approach"
      expr: inventory_control_approach
    - name: "Key Tactical Actions"
      expr: key_tactical_actions
    - name: "Strategy Name"
      expr: strategy_name
    - name: "Next Review Date"
      expr: next_review_date
    - name: "Notes"
      expr: notes
    - name: "Planning Horizon End Date"
      expr: planning_horizon_end_date
    - name: "Planning Horizon Start Date"
      expr: planning_horizon_start_date
    - name: "Pricing Approach"
      expr: pricing_approach
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Strategy"
      expr: COUNT(DISTINCT strategy_id)
    - name: "Total Target Adr"
      expr: SUM(target_adr)
    - name: "Average Target Adr"
      expr: AVG(target_adr)
    - name: "Total Target Ari"
      expr: SUM(target_ari)
    - name: "Average Target Ari"
      expr: AVG(target_ari)
    - name: "Total Target Goppar"
      expr: SUM(target_goppar)
    - name: "Average Target Goppar"
      expr: AVG(target_goppar)
    - name: "Total Target Mpi"
      expr: SUM(target_mpi)
    - name: "Average Target Mpi"
      expr: AVG(target_mpi)
    - name: "Total Target Occupancy Pct"
      expr: SUM(target_occupancy_pct)
    - name: "Average Target Occupancy Pct"
      expr: AVG(target_occupancy_pct)
    - name: "Total Target Revpar"
      expr: SUM(target_revpar)
    - name: "Average Target Revpar"
      expr: AVG(target_revpar)
    - name: "Total Target Rgi"
      expr: SUM(target_rgi)
    - name: "Average Target Rgi"
      expr: AVG(target_rgi)
    - name: "Total Target Trevpar"
      expr: SUM(target_trevpar)
    - name: "Average Target Trevpar"
      expr: AVG(target_trevpar)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`revenue_total_revenue_actuals`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Total Revenue Actuals business metrics"
  source: "`vibe_travel_hospitality_v1`.`revenue`.`total_revenue_actuals`"
  dimensions:
    - name: "Adjustment Flag"
      expr: adjustment_flag
    - name: "Adjustment Reason"
      expr: adjustment_reason
    - name: "Complimentary Rooms"
      expr: complimentary_rooms
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Day Of Week"
      expr: day_of_week
    - name: "Gl Posting Date"
      expr: gl_posting_date
    - name: "House Use Rooms"
      expr: house_use_rooms
    - name: "Is Holiday"
      expr: is_holiday
    - name: "Is Special Event"
      expr: is_special_event
    - name: "Is Weekend"
      expr: is_weekend
    - name: "Out Of Order Rooms"
      expr: out_of_order_rooms
    - name: "Record Status"
      expr: record_status
    - name: "Reporting Segment"
      expr: reporting_segment
    - name: "Rooms Available"
      expr: rooms_available
    - name: "Rooms Sold"
      expr: rooms_sold
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Total Revenue Actuals"
      expr: COUNT(DISTINCT total_revenue_actuals_id)
    - name: "Total Adr"
      expr: SUM(adr)
    - name: "Average Adr"
      expr: AVG(adr)
    - name: "Total Ari"
      expr: SUM(ari)
    - name: "Average Ari"
      expr: AVG(ari)
    - name: "Total Cpor"
      expr: SUM(cpor)
    - name: "Average Cpor"
      expr: AVG(cpor)
    - name: "Total Ebitda Contribution"
      expr: SUM(ebitda_contribution)
    - name: "Average Ebitda Contribution"
      expr: AVG(ebitda_contribution)
    - name: "Total Fb Revenue"
      expr: SUM(fb_revenue)
    - name: "Average Fb Revenue"
      expr: AVG(fb_revenue)
    - name: "Total Gop Amount"
      expr: SUM(gop_amount)
    - name: "Average Gop Amount"
      expr: AVG(gop_amount)
    - name: "Total Goppar"
      expr: SUM(goppar)
    - name: "Average Goppar"
      expr: AVG(goppar)
    - name: "Total Miscellaneous Income"
      expr: SUM(miscellaneous_income)
    - name: "Average Miscellaneous Income"
      expr: AVG(miscellaneous_income)
    - name: "Total Mpi"
      expr: SUM(mpi)
    - name: "Average Mpi"
      expr: AVG(mpi)
    - name: "Total Occupancy Pct"
      expr: SUM(occupancy_pct)
    - name: "Average Occupancy Pct"
      expr: AVG(occupancy_pct)
    - name: "Total Other Operated Dept Revenue"
      expr: SUM(other_operated_dept_revenue)
    - name: "Average Other Operated Dept Revenue"
      expr: AVG(other_operated_dept_revenue)
    - name: "Total Parking Revenue"
      expr: SUM(parking_revenue)
    - name: "Average Parking Revenue"
      expr: AVG(parking_revenue)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`revenue_wash_factor`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Wash Factor business metrics"
  source: "`vibe_travel_hospitality_v1`.`revenue`.`wash_factor`"
  dimensions:
    - name: "Adjustment Reason"
      expr: adjustment_reason
    - name: "Approved By"
      expr: approved_by
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Block Size Max Rooms"
      expr: block_size_max_rooms
    - name: "Block Size Min Rooms"
      expr: block_size_min_rooms
    - name: "Block Size Tier"
      expr: block_size_tier
    - name: "Booking Lead Time Bucket"
      expr: booking_lead_time_bucket
    - name: "Channel Code"
      expr: channel_code
    - name: "Wash Factor Code"
      expr: wash_factor_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Day Of Week Pattern"
      expr: day_of_week_pattern
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Factor Status"
      expr: factor_status
    - name: "Group Type"
      expr: group_type
    - name: "Historical Observation End Date"
      expr: historical_observation_end_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Wash Factor"
      expr: COUNT(DISTINCT wash_factor_id)
    - name: "Total Adjusted Wash Pct"
      expr: SUM(adjusted_wash_pct)
    - name: "Average Adjusted Wash Pct"
      expr: AVG(adjusted_wash_pct)
    - name: "Total Confidence Level Pct"
      expr: SUM(confidence_level_pct)
    - name: "Average Confidence Level Pct"
      expr: AVG(confidence_level_pct)
    - name: "Total Displacement Impact Pct"
      expr: SUM(displacement_impact_pct)
    - name: "Average Displacement Impact Pct"
      expr: AVG(displacement_impact_pct)
    - name: "Total Historical Wash Pct"
      expr: SUM(historical_wash_pct)
    - name: "Average Historical Wash Pct"
      expr: AVG(historical_wash_pct)
    - name: "Total Wash Pct Variance"
      expr: SUM(wash_pct_variance)
    - name: "Average Wash Pct Variance"
      expr: AVG(wash_pct_variance)
$$;