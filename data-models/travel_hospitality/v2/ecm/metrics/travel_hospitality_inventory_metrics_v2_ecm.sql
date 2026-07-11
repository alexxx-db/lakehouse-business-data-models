-- Metric views for domain: inventory | Business: Travel_Hospitality | Version: 2 | Generated on: 2026-07-10 20:26:08

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`inventory_allotment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Allotment business metrics"
  source: "`vibe_travel_hospitality_v1`.`inventory`.`allotment`"
  dimensions:
    - name: "Activated Timestamp"
      expr: activated_timestamp
    - name: "Adjustment Trigger Enabled"
      expr: adjustment_trigger_enabled
    - name: "Allocated Quantity"
      expr: allocated_quantity
    - name: "Allotment Status"
      expr: allotment_status
    - name: "Allotment Type"
      expr: allotment_type
    - name: "Auto Release Enabled"
      expr: auto_release_enabled
    - name: "Available Quantity"
      expr: available_quantity
    - name: "Booking Window End Days"
      expr: booking_window_end_days
    - name: "Booking Window Start Days"
      expr: booking_window_start_days
    - name: "Allotment Code"
      expr: allotment_code
    - name: "Contract Reference"
      expr: contract_reference
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "End Date"
      expr: end_date
    - name: "Expired Timestamp"
      expr: expired_timestamp
    - name: "Freesale Enabled"
      expr: freesale_enabled
    - name: "Freesale Threshold Quantity"
      expr: freesale_threshold_quantity
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Allotment"
      expr: COUNT(DISTINCT allotment_id)
    - name: "Total Commission Rate Percent"
      expr: SUM(commission_rate_percent)
    - name: "Average Commission Rate Percent"
      expr: AVG(commission_rate_percent)
    - name: "Total Performance Threshold Percent"
      expr: SUM(performance_threshold_percent)
    - name: "Average Performance Threshold Percent"
      expr: AVG(performance_threshold_percent)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`inventory_availability_snapshot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Availability Snapshot business metrics"
  source: "`vibe_travel_hospitality_v1`.`inventory`.`availability_snapshot`"
  dimensions:
    - name: "Closed To Arrival Flag"
      expr: closed_to_arrival_flag
    - name: "Closed To Departure Flag"
      expr: closed_to_departure_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Discrepancy Notes"
      expr: discrepancy_notes
    - name: "Lra Flag"
      expr: lra_flag
    - name: "Max Los Restriction"
      expr: max_los_restriction
    - name: "Min Los Restriction"
      expr: min_los_restriction
    - name: "Net Available Rooms"
      expr: net_available_rooms
    - name: "Overbooking Limit"
      expr: overbooking_limit
    - name: "Reconciliation Status"
      expr: reconciliation_status
    - name: "Rooms Blocked Allotment"
      expr: rooms_blocked_allotment
    - name: "Rooms Blocked Group"
      expr: rooms_blocked_group
    - name: "Rooms Complimentary"
      expr: rooms_complimentary
    - name: "Rooms Day Use"
      expr: rooms_day_use
    - name: "Rooms House Use"
      expr: rooms_house_use
    - name: "Rooms Out Of Order"
      expr: rooms_out_of_order
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Availability Snapshot"
      expr: COUNT(DISTINCT availability_snapshot_id)
    - name: "Total Occ Rate"
      expr: SUM(occ_rate)
    - name: "Average Occ Rate"
      expr: AVG(occ_rate)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`inventory_block_pickup`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Block Pickup business metrics"
  source: "`vibe_travel_hospitality_v1`.`inventory`.`block_pickup`"
  dimensions:
    - name: "Block Status"
      expr: block_status
    - name: "Booking Channel Code"
      expr: booking_channel_code
    - name: "Contracted Rooms"
      expr: contracted_rooms
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Cumulative Pickup"
      expr: cumulative_pickup
    - name: "Cutoff Date"
      expr: cutoff_date
    - name: "Days To Arrival"
      expr: days_to_arrival
    - name: "Forecasted Pickup"
      expr: forecasted_pickup
    - name: "Group Code"
      expr: group_code
    - name: "Is Lra Eligible"
      expr: is_lra_eligible
    - name: "Market Segment Code"
      expr: market_segment_code
    - name: "Net Pickup"
      expr: net_pickup
    - name: "Pickup Date"
      expr: pickup_date
    - name: "Pickup Notes"
      expr: pickup_notes
    - name: "Pickup Pace Variance"
      expr: pickup_pace_variance
    - name: "Pickup Variance"
      expr: pickup_variance
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Block Pickup"
      expr: COUNT(DISTINCT block_pickup_id)
    - name: "Total Displacement Cost"
      expr: SUM(displacement_cost)
    - name: "Average Displacement Cost"
      expr: AVG(displacement_cost)
    - name: "Total Pickup Percentage"
      expr: SUM(pickup_percentage)
    - name: "Average Pickup Percentage"
      expr: AVG(pickup_percentage)
    - name: "Total Pickup Rate"
      expr: SUM(pickup_rate)
    - name: "Average Pickup Rate"
      expr: AVG(pickup_rate)
    - name: "Total Pickup Revenue"
      expr: SUM(pickup_revenue)
    - name: "Average Pickup Revenue"
      expr: AVG(pickup_revenue)
    - name: "Total Wash Factor"
      expr: SUM(wash_factor)
    - name: "Average Wash Factor"
      expr: AVG(wash_factor)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`inventory_block_wash_factor_application`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Block Wash Factor Application business metrics"
  source: "`vibe_travel_hospitality_v1`.`inventory`.`block_wash_factor_application`"
  dimensions:
    - name: "Application Reason"
      expr: application_reason
    - name: "Application Status"
      expr: application_status
    - name: "Applied By"
      expr: applied_by
    - name: "Block Size Tier Match"
      expr: block_size_tier_match
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective Date"
      expr: effective_date
    - name: "Forecast Run Code"
      expr: forecast_run_code
    - name: "Lead Time Bucket Match"
      expr: lead_time_bucket_match
    - name: "Updated Timestamp"
      expr: updated_timestamp
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
    - name: "Effective Date Month"
      expr: DATE_TRUNC('MONTH', effective_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Block Wash Factor Application"
      expr: COUNT(DISTINCT block_wash_factor_application_id)
    - name: "Total Actual Wash Pct"
      expr: SUM(actual_wash_pct)
    - name: "Average Actual Wash Pct"
      expr: AVG(actual_wash_pct)
    - name: "Total Applied Wash Pct"
      expr: SUM(applied_wash_pct)
    - name: "Average Applied Wash Pct"
      expr: AVG(applied_wash_pct)
    - name: "Total Variance Pct"
      expr: SUM(variance_pct)
    - name: "Average Variance Pct"
      expr: AVG(variance_pct)
    - name: "Total Wash Factor Percentage"
      expr: SUM(wash_factor_percentage)
    - name: "Average Wash Factor Percentage"
      expr: AVG(wash_factor_percentage)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`inventory_change_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Change Audit business metrics"
  source: "`vibe_travel_hospitality_v1`.`inventory`.`change_audit`"
  dimensions:
    - name: "Approval Authority Level"
      expr: approval_authority_level
    - name: "Approval Required Flag"
      expr: approval_required_flag
    - name: "Approval Timestamp"
      expr: approval_timestamp
    - name: "Authorizing User Name"
      expr: authorizing_user_name
    - name: "Business Date"
      expr: business_date
    - name: "Change Impact Type"
      expr: change_impact_type
    - name: "Change Reason Code"
      expr: change_reason_code
    - name: "Change Reason Description"
      expr: change_reason_description
    - name: "Change Timestamp"
      expr: change_timestamp
    - name: "Changed Entity Reference"
      expr: changed_entity_reference
    - name: "Changed Entity Type"
      expr: changed_entity_type
    - name: "Channel Code"
      expr: channel_code
    - name: "Compliance Flag"
      expr: compliance_flag
    - name: "Cta Ctd Change Flag"
      expr: cta_ctd_change_flag
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Change Audit"
      expr: COUNT(DISTINCT change_audit_id)
    - name: "Total New Value"
      expr: SUM(new_value)
    - name: "Average New Value"
      expr: AVG(new_value)
    - name: "Total Previous Value"
      expr: SUM(previous_value)
    - name: "Average Previous Value"
      expr: AVG(previous_value)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`inventory_channel_inventory_map`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Channel Inventory Map business metrics"
  source: "`vibe_travel_hospitality_v1`.`inventory`.`channel_inventory_map`"
  dimensions:
    - name: "Advance Booking Days Max"
      expr: advance_booking_days_max
    - name: "Advance Booking Days Min"
      expr: advance_booking_days_min
    - name: "Allocation Type"
      expr: allocation_type
    - name: "Booking Source Code"
      expr: booking_source_code
    - name: "Channel Code"
      expr: channel_code
    - name: "Channel Priority Rank"
      expr: channel_priority_rank
    - name: "Channel Sell Limit"
      expr: channel_sell_limit
    - name: "Channel Visibility Flag"
      expr: channel_visibility_flag
    - name: "Commission Eligible Flag"
      expr: commission_eligible_flag
    - name: "Connectivity Method"
      expr: connectivity_method
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Last Sync Timestamp"
      expr: last_sync_timestamp
    - name: "Lra Enabled Flag"
      expr: lra_enabled_flag
    - name: "Mapping Status"
      expr: mapping_status
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Channel Inventory Map"
      expr: COUNT(DISTINCT channel_inventory_map_id)
    - name: "Total Overbooking Limit Pct"
      expr: SUM(overbooking_limit_pct)
    - name: "Average Overbooking Limit Pct"
      expr: AVG(overbooking_limit_pct)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`inventory_inventory_overbooking_policy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory Overbooking Policy business metrics"
  source: "`vibe_travel_hospitality_v1`.`inventory`.`inventory_overbooking_policy`"
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

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`inventory_los_restriction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Los Restriction business metrics"
  source: "`vibe_travel_hospitality_v1`.`inventory`.`los_restriction`"
  dimensions:
    - name: "Channel Code"
      expr: channel_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Day Of Week Pattern"
      expr: day_of_week_pattern
    - name: "Distribution Timestamp"
      expr: distribution_timestamp
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Forecast Demand Level"
      expr: forecast_demand_level
    - name: "Full Pattern Los"
      expr: full_pattern_los
    - name: "Group Block Exempt Flag"
      expr: group_block_exempt_flag
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Loyalty Tier Exempt List"
      expr: loyalty_tier_exempt_list
    - name: "Lra Flag"
      expr: lra_flag
    - name: "Market Segment Code"
      expr: market_segment_code
    - name: "Max Los"
      expr: max_los
    - name: "Min Los"
      expr: min_los
    - name: "Override Authority Level"
      expr: override_authority_level
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Los Restriction"
      expr: COUNT(DISTINCT los_restriction_id)
    - name: "Total Adr Threshold Amount"
      expr: SUM(adr_threshold_amount)
    - name: "Average Adr Threshold Amount"
      expr: AVG(adr_threshold_amount)
    - name: "Total Occ Threshold Percent"
      expr: SUM(occ_threshold_percent)
    - name: "Average Occ Threshold Percent"
      expr: AVG(occ_threshold_percent)
    - name: "Total Revpar Threshold Amount"
      expr: SUM(revpar_threshold_amount)
    - name: "Average Revpar Threshold Amount"
      expr: AVG(revpar_threshold_amount)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`inventory_out_of_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Out Of Order business metrics"
  source: "`vibe_travel_hospitality_v1`.`inventory`.`out_of_order`"
  dimensions:
    - name: "Actual Return Date"
      expr: actual_return_date
    - name: "Actual Return Timestamp"
      expr: actual_return_timestamp
    - name: "Ada Compliance Flag"
      expr: ada_compliance_flag
    - name: "Approved By Name"
      expr: approved_by_name
    - name: "Closed By Name"
      expr: closed_by_name
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Duration Days"
      expr: duration_days
    - name: "Expected Return Date"
      expr: expected_return_date
    - name: "Guest Impacted Flag"
      expr: guest_impacted_flag
    - name: "Notes"
      expr: notes
    - name: "Ooo Code"
      expr: ooo_code
    - name: "Ooo Reason"
      expr: ooo_reason
    - name: "Ooo Status"
      expr: ooo_status
    - name: "Priority Level"
      expr: priority_level
    - name: "Record Status"
      expr: record_status
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Out Of Order"
      expr: COUNT(DISTINCT out_of_order_id)
    - name: "Total Actual Cost"
      expr: SUM(actual_cost)
    - name: "Average Actual Cost"
      expr: AVG(actual_cost)
    - name: "Total Estimated Cost"
      expr: SUM(estimated_cost)
    - name: "Average Estimated Cost"
      expr: AVG(estimated_cost)
    - name: "Total Impact On Occ"
      expr: SUM(impact_on_occ)
    - name: "Average Impact On Occ"
      expr: AVG(impact_on_occ)
    - name: "Total Impact On Revpar"
      expr: SUM(impact_on_revpar)
    - name: "Average Impact On Revpar"
      expr: AVG(impact_on_revpar)
    - name: "Total Lost Revenue Estimate"
      expr: SUM(lost_revenue_estimate)
    - name: "Average Lost Revenue Estimate"
      expr: AVG(lost_revenue_estimate)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`inventory_rate_plan_room_type_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rate Plan Room Type Assignment business metrics"
  source: "`vibe_travel_hospitality_v1`.`inventory`.`rate_plan_room_type_assignment`"
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
  comment: "Room business metrics"
  source: "`vibe_travel_hospitality_v1`.`inventory`.`room`"
  dimensions:
    - name: "Ada Accessible"
      expr: ada_accessible
    - name: "Balcony Available"
      expr: balcony_available
    - name: "Bed Count"
      expr: bed_count
    - name: "Bed Type"
      expr: bed_type
    - name: "Building Code"
      expr: building_code
    - name: "Connecting Room Available"
      expr: connecting_room_available
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Features"
      expr: features
    - name: "Floor Number"
      expr: floor_number
    - name: "Front Office Status"
      expr: front_office_status
    - name: "Housekeeping Status"
      expr: housekeeping_status
    - name: "Kitchenette Available"
      expr: kitchenette_available
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Last Renovation Date"
      expr: last_renovation_date
    - name: "Lra Eligible"
      expr: lra_eligible
    - name: "Max Occupancy"
      expr: max_occupancy
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Room"
      expr: COUNT(DISTINCT room_id)
    - name: "Total Ffe Condition Score"
      expr: SUM(ffe_condition_score)
    - name: "Average Ffe Condition Score"
      expr: AVG(ffe_condition_score)
    - name: "Total Square Footage"
      expr: SUM(square_footage)
    - name: "Average Square Footage"
      expr: AVG(square_footage)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`inventory_room_amenity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Room Amenity business metrics"
  source: "`vibe_travel_hospitality_v1`.`inventory`.`room_amenity`"
  dimensions:
    - name: "Amenity Category"
      expr: amenity_category
    - name: "Amenity Code"
      expr: amenity_code
    - name: "Amenity Description"
      expr: amenity_description
    - name: "Amenity Name"
      expr: amenity_name
    - name: "Brand Name"
      expr: brand_name
    - name: "Condition Status"
      expr: condition_status
    - name: "Cost Currency Code"
      expr: cost_currency_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Display Sequence"
      expr: display_sequence
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Guest Visible Flag"
      expr: guest_visible_flag
    - name: "Installation Date"
      expr: installation_date
    - name: "Is Ada Compliant"
      expr: is_ada_compliant
    - name: "Is Complimentary"
      expr: is_complimentary
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Room Amenity"
      expr: COUNT(DISTINCT room_amenity_id)
    - name: "Total Charge Amount"
      expr: SUM(charge_amount)
    - name: "Average Charge Amount"
      expr: AVG(charge_amount)
    - name: "Total Unit Cost"
      expr: SUM(unit_cost)
    - name: "Average Unit Cost"
      expr: AVG(unit_cost)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`inventory_room_block`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Room Block business metrics"
  source: "`vibe_travel_hospitality_v1`.`inventory`.`room_block`"
  dimensions:
    - name: "Available Room Nights"
      expr: available_room_nights
    - name: "Block Code"
      expr: block_code
    - name: "Block Name"
      expr: block_name
    - name: "Block Status"
      expr: block_status
    - name: "Block Type"
      expr: block_type
    - name: "Booking Source"
      expr: booking_source
    - name: "Cancellation Policy"
      expr: cancellation_policy
    - name: "Cancellation Reason"
      expr: cancellation_reason
    - name: "Cancelled Timestamp"
      expr: cancelled_timestamp
    - name: "Confirmed Timestamp"
      expr: confirmed_timestamp
    - name: "Contracted Room Nights"
      expr: contracted_room_nights
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Cutoff Date"
      expr: cutoff_date
    - name: "Deposit Due Date"
      expr: deposit_due_date
    - name: "Deposit Required Flag"
      expr: deposit_required_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Room Block"
      expr: COUNT(DISTINCT room_block_id)
    - name: "Total Attrition Penalty Amount"
      expr: SUM(attrition_penalty_amount)
    - name: "Average Attrition Penalty Amount"
      expr: AVG(attrition_penalty_amount)
    - name: "Total Attrition Percentage"
      expr: SUM(attrition_percentage)
    - name: "Average Attrition Percentage"
      expr: AVG(attrition_percentage)
    - name: "Total Commission Percentage"
      expr: SUM(commission_percentage)
    - name: "Average Commission Percentage"
      expr: AVG(commission_percentage)
    - name: "Total Deposit Amount"
      expr: SUM(deposit_amount)
    - name: "Average Deposit Amount"
      expr: AVG(deposit_amount)
    - name: "Total Negotiated Rate Amount"
      expr: SUM(negotiated_rate_amount)
    - name: "Average Negotiated Rate Amount"
      expr: AVG(negotiated_rate_amount)
    - name: "Total Pickup Percentage"
      expr: SUM(pickup_percentage)
    - name: "Average Pickup Percentage"
      expr: AVG(pickup_percentage)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`inventory_room_material_installation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Room Material Installation business metrics"
  source: "`vibe_travel_hospitality_v1`.`inventory`.`room_material_installation`"
  dimensions:
    - name: "Condition Status"
      expr: condition_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Installation Date"
      expr: installation_date
    - name: "Installation Notes"
      expr: installation_notes
    - name: "Last Maintenance Date"
      expr: last_maintenance_date
    - name: "Last Replacement Date"
      expr: last_replacement_date
    - name: "Maintenance Frequency Days"
      expr: maintenance_frequency_days
    - name: "Next Scheduled Replacement Date"
      expr: next_scheduled_replacement_date
    - name: "Updated Timestamp"
      expr: updated_timestamp
    - name: "Warranty Expiry Date"
      expr: warranty_expiry_date
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
    - name: "Installation Date Month"
      expr: DATE_TRUNC('MONTH', installation_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Room Material Installation"
      expr: COUNT(DISTINCT room_material_installation_id)
    - name: "Total Quantity Installed"
      expr: SUM(quantity_installed)
    - name: "Average Quantity Installed"
      expr: AVG(quantity_installed)
    - name: "Total Unit Cost At Installation"
      expr: SUM(unit_cost_at_installation)
    - name: "Average Unit Cost At Installation"
      expr: AVG(unit_cost_at_installation)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`inventory_room_status`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Room Status business metrics"
  source: "`vibe_travel_hospitality_v1`.`inventory`.`room_status`"
  dimensions:
    - name: "Blocked Reason"
      expr: blocked_reason
    - name: "Cleaning Type"
      expr: cleaning_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Discrepancy Flag"
      expr: discrepancy_flag
    - name: "Discrepancy Notes"
      expr: discrepancy_notes
    - name: "Do Not Disturb Flag"
      expr: do_not_disturb_flag
    - name: "Expected Checkin Date"
      expr: expected_checkin_date
    - name: "Expected Checkout Date"
      expr: expected_checkout_date
    - name: "Front Desk Status"
      expr: front_desk_status
    - name: "Housekeeping Status"
      expr: housekeeping_status
    - name: "Is Blocked"
      expr: is_blocked
    - name: "Is Clean"
      expr: is_clean
    - name: "Is Inspected"
      expr: is_inspected
    - name: "Is Out Of Order"
      expr: is_out_of_order
    - name: "Last Cleaned Timestamp"
      expr: last_cleaned_timestamp
    - name: "Last Inspected Timestamp"
      expr: last_inspected_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Room Status"
      expr: COUNT(DISTINCT room_status_id)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`inventory_room_type`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Room Type business metrics"
  source: "`vibe_travel_hospitality_v1`.`inventory`.`room_type`"
  dimensions:
    - name: "Accessibility Features"
      expr: accessibility_features
    - name: "Active Status"
      expr: active_status
    - name: "Bathroom Configuration"
      expr: bathroom_configuration
    - name: "Bed Count"
      expr: bed_count
    - name: "Bed Type"
      expr: bed_type
    - name: "Room Type Code"
      expr: room_type_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Room Type Description"
      expr: room_type_description
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Floor Level Range"
      expr: floor_level_range
    - name: "Is Ada Compliant"
      expr: is_ada_compliant
    - name: "Is Connecting Eligible"
      expr: is_connecting_eligible
    - name: "Is Suite"
      expr: is_suite
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Lra Eligible"
      expr: lra_eligible
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Room Type"
      expr: COUNT(DISTINCT room_type_id)
    - name: "Total Square Footage"
      expr: SUM(square_footage)
    - name: "Average Square Footage"
      expr: AVG(square_footage)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`inventory_room_type_competitive_benchmark`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Room Type Competitive Benchmark business metrics"
  source: "`vibe_travel_hospitality_v1`.`inventory`.`room_type_competitive_benchmark`"
  dimensions:
    - name: "Advance Purchase Window Days"
      expr: advance_purchase_window_days
    - name: "Benchmark Room Type Category"
      expr: benchmark_room_type_category
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Is Primary Comp Category"
      expr: is_primary_comp_category
    - name: "Last Modified By"
      expr: last_modified_by
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Los Benchmark Nights"
      expr: los_benchmark_nights
    - name: "Rate Shop Frequency"
      expr: rate_shop_frequency
    - name: "Room Type Competitive Benchmark Status"
      expr: room_type_competitive_benchmark_status
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
    - name: "Effective Date Month"
      expr: DATE_TRUNC('MONTH', effective_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Room Type Competitive Benchmark"
      expr: COUNT(DISTINCT room_type_competitive_benchmark_id)
    - name: "Total Benchmark Weight"
      expr: SUM(benchmark_weight)
    - name: "Average Benchmark Weight"
      expr: AVG(benchmark_weight)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`inventory_room_type_promotion`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Room Type Promotion business metrics"
  source: "`vibe_travel_hospitality_v1`.`inventory`.`room_type_promotion`"
  dimensions:
    - name: "Active Status"
      expr: active_status
    - name: "Blackout Dates"
      expr: blackout_dates
    - name: "Booking Window End Date"
      expr: booking_window_end_date
    - name: "Booking Window Start Date"
      expr: booking_window_start_date
    - name: "Created Date"
      expr: created_date
    - name: "Inventory Allocation Cap"
      expr: inventory_allocation_cap
    - name: "Minimum Los Override"
      expr: minimum_los_override
    - name: "Rooms Booked Count"
      expr: rooms_booked_count
    - name: "Booking Window End Date Month"
      expr: DATE_TRUNC('MONTH', booking_window_end_date)
    - name: "Booking Window Start Date Month"
      expr: DATE_TRUNC('MONTH', booking_window_start_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Room Type Promotion"
      expr: COUNT(DISTINCT room_type_promotion_id)
    - name: "Total Bonus Points Multiplier"
      expr: SUM(bonus_points_multiplier)
    - name: "Average Bonus Points Multiplier"
      expr: AVG(bonus_points_multiplier)
    - name: "Total Promotional Rate Amount"
      expr: SUM(promotional_rate_amount)
    - name: "Average Promotional Rate Amount"
      expr: AVG(promotional_rate_amount)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`inventory_room_type_vendor_supply`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Room Type Vendor Supply business metrics"
  source: "`vibe_travel_hospitality_v1`.`inventory`.`room_type_vendor_supply`"
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