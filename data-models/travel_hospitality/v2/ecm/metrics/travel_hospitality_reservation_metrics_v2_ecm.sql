-- Metric views for domain: reservation | Business: Travel_Hospitality | Version: 2 | Generated on: 2026-07-10 20:26:14

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`reservation_booking_package`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Booking Package business metrics"
  source: "`vibe_travel_hospitality_v1`.`reservation`.`booking_package`"
  dimensions:
    - name: "Cancellation Deadline"
      expr: cancellation_deadline
    - name: "Cancellation Reason"
      expr: cancellation_reason
    - name: "Cancelled Timestamp"
      expr: cancelled_timestamp
    - name: "Commission Eligible"
      expr: commission_eligible
    - name: "Component List"
      expr: component_list
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "End Date"
      expr: end_date
    - name: "Fulfillment Instructions"
      expr: fulfillment_instructions
    - name: "Is Inclusive"
      expr: is_inclusive
    - name: "Is Mandatory"
      expr: is_mandatory
    - name: "Is Refundable"
      expr: is_refundable
    - name: "Market Segment Code"
      expr: market_segment_code
    - name: "Modified By"
      expr: modified_by
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Notes"
      expr: notes
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Booking Package"
      expr: COUNT(DISTINCT booking_package_id)
    - name: "Total Fb Revenue Amount"
      expr: SUM(fb_revenue_amount)
    - name: "Average Fb Revenue Amount"
      expr: AVG(fb_revenue_amount)
    - name: "Total Other Revenue Amount"
      expr: SUM(other_revenue_amount)
    - name: "Average Other Revenue Amount"
      expr: AVG(other_revenue_amount)
    - name: "Total Package Cost Amount"
      expr: SUM(package_cost_amount)
    - name: "Average Package Cost Amount"
      expr: AVG(package_cost_amount)
    - name: "Total Package Rate Amount"
      expr: SUM(package_rate_amount)
    - name: "Average Package Rate Amount"
      expr: AVG(package_rate_amount)
    - name: "Total Rooms Revenue Amount"
      expr: SUM(rooms_revenue_amount)
    - name: "Average Rooms Revenue Amount"
      expr: AVG(rooms_revenue_amount)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`reservation_booking_status_history`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Booking Status History business metrics"
  source: "`vibe_travel_hospitality_v1`.`reservation`.`booking_status_history`"
  dimensions:
    - name: "Agent Name"
      expr: agent_name
    - name: "Booking Source Code"
      expr: booking_source_code
    - name: "Cancellation Reason Code"
      expr: cancellation_reason_code
    - name: "Channel Code"
      expr: channel_code
    - name: "Confirmation Number"
      expr: confirmation_number
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Dispute Flag"
      expr: dispute_flag
    - name: "Event Date"
      expr: event_date
    - name: "Event Timestamp"
      expr: event_timestamp
    - name: "Event Type"
      expr: event_type
    - name: "Guest Notification Sent Flag"
      expr: guest_notification_sent_flag
    - name: "Guest Notification Timestamp"
      expr: guest_notification_timestamp
    - name: "Ip Address"
      expr: ip_address
    - name: "Modification Field Name"
      expr: modification_field_name
    - name: "Modification Type"
      expr: modification_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Booking Status History"
      expr: COUNT(DISTINCT booking_status_history_id)
    - name: "Total New Value"
      expr: SUM(new_value)
    - name: "Average New Value"
      expr: AVG(new_value)
    - name: "Total Original Value"
      expr: SUM(original_value)
    - name: "Average Original Value"
      expr: AVG(original_value)
    - name: "Total Penalty Fee Amount"
      expr: SUM(penalty_fee_amount)
    - name: "Average Penalty Fee Amount"
      expr: AVG(penalty_fee_amount)
    - name: "Total Rate Difference Amount"
      expr: SUM(rate_difference_amount)
    - name: "Average Rate Difference Amount"
      expr: AVG(rate_difference_amount)
    - name: "Total Revenue Impact Amount"
      expr: SUM(revenue_impact_amount)
    - name: "Average Revenue Impact Amount"
      expr: AVG(revenue_impact_amount)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`reservation_cancellation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cancellation business metrics"
  source: "`vibe_travel_hospitality_v1`.`reservation`.`cancellation`"
  dimensions:
    - name: "Confirmation Number"
      expr: confirmation_number
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Dispute Date"
      expr: dispute_date
    - name: "Dispute Flag"
      expr: dispute_flag
    - name: "Dispute Resolution Status"
      expr: dispute_resolution_status
    - name: "Event Timestamp"
      expr: event_timestamp
    - name: "Event Type"
      expr: event_type
    - name: "Guarantee Charge Processed Flag"
      expr: guarantee_charge_processed_flag
    - name: "Guarantee Method"
      expr: guarantee_method
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Original Arrival Date"
      expr: original_arrival_date
    - name: "Original Departure Date"
      expr: original_departure_date
    - name: "Ota Chargeback Eligible Flag"
      expr: ota_chargeback_eligible_flag
    - name: "Penalty Applicable Flag"
      expr: penalty_applicable_flag
    - name: "Penalty Currency Code"
      expr: penalty_currency_code
    - name: "Posting Status"
      expr: posting_status
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Cancellation"
      expr: COUNT(DISTINCT cancellation_id)
    - name: "Total Ota Chargeback Amount"
      expr: SUM(ota_chargeback_amount)
    - name: "Average Ota Chargeback Amount"
      expr: AVG(ota_chargeback_amount)
    - name: "Total Penalty Amount"
      expr: SUM(penalty_amount)
    - name: "Average Penalty Amount"
      expr: AVG(penalty_amount)
    - name: "Total Refund Amount"
      expr: SUM(refund_amount)
    - name: "Average Refund Amount"
      expr: AVG(refund_amount)
    - name: "Total Revenue Lost Amount"
      expr: SUM(revenue_lost_amount)
    - name: "Average Revenue Lost Amount"
      expr: AVG(revenue_lost_amount)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`reservation_cancellation_policy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cancellation Policy business metrics"
  source: "`vibe_travel_hospitality_v1`.`reservation`.`cancellation_policy`"
  dimensions:
    - name: "Allows Modification"
      expr: allows_modification
    - name: "Applies To Corporate Bookings"
      expr: applies_to_corporate_bookings
    - name: "Applies To Group Bookings"
      expr: applies_to_group_bookings
    - name: "Channel Restrictions"
      expr: channel_restrictions
    - name: "Created By User"
      expr: created_by_user
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Deposit Due Days Before Arrival"
      expr: deposit_due_days_before_arrival
    - name: "Deposit Required"
      expr: deposit_required
    - name: "Display Order"
      expr: display_order
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Free Cancellation Window Days"
      expr: free_cancellation_window_days
    - name: "Free Cancellation Window Hours"
      expr: free_cancellation_window_hours
    - name: "Guarantee Required"
      expr: guarantee_required
    - name: "Guest Facing Summary"
      expr: guest_facing_summary
    - name: "Internal Notes"
      expr: internal_notes
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Cancellation Policy"
      expr: COUNT(DISTINCT cancellation_policy_id)
    - name: "Total Deposit Percentage"
      expr: SUM(deposit_percentage)
    - name: "Average Deposit Percentage"
      expr: AVG(deposit_percentage)
    - name: "Total Modification Fee"
      expr: SUM(modification_fee)
    - name: "Average Modification Fee"
      expr: AVG(modification_fee)
    - name: "Total No Show Penalty Amount"
      expr: SUM(no_show_penalty_amount)
    - name: "Average No Show Penalty Amount"
      expr: AVG(no_show_penalty_amount)
    - name: "Total No Show Penalty Percentage"
      expr: SUM(no_show_penalty_percentage)
    - name: "Average No Show Penalty Percentage"
      expr: AVG(no_show_penalty_percentage)
    - name: "Total Penalty Amount"
      expr: SUM(penalty_amount)
    - name: "Average Penalty Amount"
      expr: AVG(penalty_amount)
    - name: "Total Penalty Percentage"
      expr: SUM(penalty_percentage)
    - name: "Average Penalty Percentage"
      expr: AVG(penalty_percentage)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`reservation_deposit_ledger`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Deposit Ledger business metrics"
  source: "`vibe_travel_hospitality_v1`.`reservation`.`deposit_ledger`"
  dimensions:
    - name: "Applied To Folio Date"
      expr: applied_to_folio_date
    - name: "Booking Source"
      expr: booking_source
    - name: "Cancellation Policy Code"
      expr: cancellation_policy_code
    - name: "Card Last Four Digits"
      expr: card_last_four_digits
    - name: "Confirmation Number"
      expr: confirmation_number
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Deposit Due Date"
      expr: deposit_due_date
    - name: "Deposit Policy Code"
      expr: deposit_policy_code
    - name: "Deposit Status"
      expr: deposit_status
    - name: "Deposit Type"
      expr: deposit_type
    - name: "Folio Number"
      expr: folio_number
    - name: "Forfeiture Date"
      expr: forfeiture_date
    - name: "Forfeiture Reason"
      expr: forfeiture_reason
    - name: "Notes"
      expr: notes
    - name: "Payment Received Date"
      expr: payment_received_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Deposit Ledger"
      expr: COUNT(DISTINCT deposit_ledger_id)
    - name: "Total Deposit Amount"
      expr: SUM(deposit_amount)
    - name: "Average Deposit Amount"
      expr: AVG(deposit_amount)
    - name: "Total Forfeiture Amount"
      expr: SUM(forfeiture_amount)
    - name: "Average Forfeiture Amount"
      expr: AVG(forfeiture_amount)
    - name: "Total Refund Amount"
      expr: SUM(refund_amount)
    - name: "Average Refund Amount"
      expr: AVG(refund_amount)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`reservation_group_block_pickup`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Group Block Pickup business metrics"
  source: "`vibe_travel_hospitality_v1`.`reservation`.`group_block_pickup`"
  dimensions:
    - name: "Arrival Date"
      expr: arrival_date
    - name: "Booking Channel Code"
      expr: booking_channel_code
    - name: "Booking Source"
      expr: booking_source
    - name: "Cancellation Date"
      expr: cancellation_date
    - name: "Cancellation Reason Code"
      expr: cancellation_reason_code
    - name: "Company Name"
      expr: company_name
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Cutoff Date"
      expr: cutoff_date
    - name: "Departure Date"
      expr: departure_date
    - name: "Group Attendee Type"
      expr: group_attendee_type
    - name: "Guarantee Type"
      expr: guarantee_type
    - name: "Guest Email"
      expr: guest_email
    - name: "Guest Name"
      expr: guest_name
    - name: "Guest Phone"
      expr: guest_phone
    - name: "Loyalty Member Number"
      expr: loyalty_member_number
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Group Block Pickup"
      expr: COUNT(DISTINCT group_block_pickup_id)
    - name: "Total Block Utilization Percentage"
      expr: SUM(block_utilization_percentage)
    - name: "Average Block Utilization Percentage"
      expr: AVG(block_utilization_percentage)
    - name: "Total Rate Amount"
      expr: SUM(rate_amount)
    - name: "Average Rate Amount"
      expr: AVG(rate_amount)
    - name: "Total Total Room Revenue"
      expr: SUM(total_room_revenue)
    - name: "Average Total Room Revenue"
      expr: AVG(total_room_revenue)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`reservation_group_spa_package_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Group Spa Package Contract business metrics"
  source: "`vibe_travel_hospitality_v1`.`reservation`.`group_spa_package_contract`"
  dimensions:
    - name: "Advance Booking Deadline"
      expr: advance_booking_deadline
    - name: "Billing Arrangement"
      expr: billing_arrangement
    - name: "Contract Status"
      expr: contract_status
    - name: "Contracted Date"
      expr: contracted_date
    - name: "Contracted Package Count"
      expr: contracted_package_count
    - name: "Coordinator Contact"
      expr: coordinator_contact
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Customization Notes"
      expr: customization_notes
    - name: "Updated Timestamp"
      expr: updated_timestamp
    - name: "Advance Booking Deadline Month"
      expr: DATE_TRUNC('MONTH', advance_booking_deadline)
    - name: "Contracted Date Month"
      expr: DATE_TRUNC('MONTH', contracted_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Group Spa Package Contract"
      expr: COUNT(DISTINCT group_spa_package_contract_id)
    - name: "Total Group Discount Percentage"
      expr: SUM(group_discount_percentage)
    - name: "Average Group Discount Percentage"
      expr: AVG(group_discount_percentage)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`reservation_program_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Program Enrollment business metrics"
  source: "`vibe_travel_hospitality_v1`.`reservation`.`program_enrollment`"
  dimensions:
    - name: "Cancellation Date"
      expr: cancellation_date
    - name: "Cancellation Reason"
      expr: cancellation_reason
    - name: "Completion Status"
      expr: completion_status
    - name: "Confirmed Date"
      expr: confirmed_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Customization Notes"
      expr: customization_notes
    - name: "Dietary Preferences"
      expr: dietary_preferences
    - name: "Enrollment Date"
      expr: enrollment_date
    - name: "Medical Clearance Date"
      expr: medical_clearance_date
    - name: "Medical Clearance Status"
      expr: medical_clearance_status
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Program End Date"
      expr: program_end_date
    - name: "Program Start Date"
      expr: program_start_date
    - name: "Progress Notes"
      expr: progress_notes
    - name: "Satisfaction Score"
      expr: satisfaction_score
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Program Enrollment"
      expr: COUNT(DISTINCT program_enrollment_id)
    - name: "Total Enrollment Price"
      expr: SUM(enrollment_price)
    - name: "Average Enrollment Price"
      expr: AVG(enrollment_price)
    - name: "Total Refund Amount"
      expr: SUM(refund_amount)
    - name: "Average Refund Amount"
      expr: AVG(refund_amount)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`reservation_reservation_booking`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reservation Booking business metrics"
  source: "`vibe_travel_hospitality_v1`.`reservation`.`reservation_booking`"
  dimensions:
    - name: "Accessibility Required Flag"
      expr: accessibility_required_flag
    - name: "Arrival Date"
      expr: arrival_date
    - name: "Booking Date"
      expr: booking_date
    - name: "Booking Status"
      expr: booking_status
    - name: "Booking Timestamp"
      expr: booking_timestamp
    - name: "Cancellation Policy Code"
      expr: cancellation_policy_code
    - name: "Cancellation Timestamp"
      expr: cancellation_timestamp
    - name: "Confirmation Number"
      expr: confirmation_number
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Crs Confirmation Number"
      expr: crs_confirmation_number
    - name: "Currency Code"
      expr: currency_code
    - name: "Departure Date"
      expr: departure_date
    - name: "Early Checkin Requested Flag"
      expr: early_checkin_requested_flag
    - name: "Guarantee Method"
      expr: guarantee_method
    - name: "Late Checkout Requested Flag"
      expr: late_checkout_requested_flag
    - name: "Length Of Stay"
      expr: length_of_stay
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Reservation Booking"
      expr: COUNT(DISTINCT reservation_booking_id)
    - name: "Total Average Daily Rate"
      expr: SUM(average_daily_rate)
    - name: "Average Average Daily Rate"
      expr: AVG(average_daily_rate)
    - name: "Total Commission Amount"
      expr: SUM(commission_amount)
    - name: "Average Commission Amount"
      expr: AVG(commission_amount)
    - name: "Total Total Room Revenue"
      expr: SUM(total_room_revenue)
    - name: "Average Total Room Revenue"
      expr: AVG(total_room_revenue)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`reservation_reservation_group_block`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reservation Group Block business metrics"
  source: "`vibe_travel_hospitality_v1`.`reservation`.`reservation_group_block`"
  dimensions:
    - name: "Arrival Date"
      expr: arrival_date
    - name: "Attrition Clause Flag"
      expr: attrition_clause_flag
    - name: "Available Room Count"
      expr: available_room_count
    - name: "Billing Instruction"
      expr: billing_instruction
    - name: "Block Code"
      expr: block_code
    - name: "Block Name"
      expr: block_name
    - name: "Block Status"
      expr: block_status
    - name: "Block Type"
      expr: block_type
    - name: "Cancellation Policy"
      expr: cancellation_policy
    - name: "Cancellation Reason"
      expr: cancellation_reason
    - name: "Cancelled Timestamp"
      expr: cancelled_timestamp
    - name: "Contact Email"
      expr: contact_email
    - name: "Contact Name"
      expr: contact_name
    - name: "Contact Phone"
      expr: contact_phone
    - name: "Contract Signed Date"
      expr: contract_signed_date
    - name: "Contracted Room Count"
      expr: contracted_room_count
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Reservation Group Block"
      expr: COUNT(DISTINCT reservation_group_block_id)
    - name: "Total Attrition Threshold Percentage"
      expr: SUM(attrition_threshold_percentage)
    - name: "Average Attrition Threshold Percentage"
      expr: AVG(attrition_threshold_percentage)
    - name: "Total Commission Percentage"
      expr: SUM(commission_percentage)
    - name: "Average Commission Percentage"
      expr: AVG(commission_percentage)
    - name: "Total Deposit Amount"
      expr: SUM(deposit_amount)
    - name: "Average Deposit Amount"
      expr: AVG(deposit_amount)
    - name: "Total Group Rate Amount"
      expr: SUM(group_rate_amount)
    - name: "Average Group Rate Amount"
      expr: AVG(group_rate_amount)
    - name: "Total Revenue Forecast Amount"
      expr: SUM(revenue_forecast_amount)
    - name: "Average Revenue Forecast Amount"
      expr: AVG(revenue_forecast_amount)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`reservation_reservation_rate_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reservation Rate Plan business metrics"
  source: "`vibe_travel_hospitality_v1`.`reservation`.`reservation_rate_plan`"
  dimensions:
    - name: "Advance Purchase Days"
      expr: advance_purchase_days
    - name: "Booking Window End Days"
      expr: booking_window_end_days
    - name: "Booking Window Start Days"
      expr: booking_window_start_days
    - name: "Channel Corporate Flag"
      expr: channel_corporate_flag
    - name: "Channel Direct Flag"
      expr: channel_direct_flag
    - name: "Channel Gds Flag"
      expr: channel_gds_flag
    - name: "Channel Group Flag"
      expr: channel_group_flag
    - name: "Channel Ota Flag"
      expr: channel_ota_flag
    - name: "Commissionable Flag"
      expr: commissionable_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Display Sequence"
      expr: display_sequence
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Guarantee Method"
      expr: guarantee_method
    - name: "Guarantee Required Flag"
      expr: guarantee_required_flag
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Reservation Rate Plan"
      expr: COUNT(DISTINCT reservation_rate_plan_id)
    - name: "Total Commission Percentage"
      expr: SUM(commission_percentage)
    - name: "Average Commission Percentage"
      expr: AVG(commission_percentage)
    - name: "Total Loyalty Points Multiplier"
      expr: SUM(loyalty_points_multiplier)
    - name: "Average Loyalty Points Multiplier"
      expr: AVG(loyalty_points_multiplier)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`reservation_reservation_special_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reservation Special Request business metrics"
  source: "`vibe_travel_hospitality_v1`.`reservation`.`reservation_special_request`"
  dimensions:
    - name: "Acknowledged Timestamp"
      expr: acknowledged_timestamp
    - name: "Assigned Department"
      expr: assigned_department
    - name: "Charge Currency Code"
      expr: charge_currency_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Failure Category"
      expr: failure_category
    - name: "Failure Reason"
      expr: failure_reason
    - name: "Fulfillment Status"
      expr: fulfillment_status
    - name: "Fulfillment Timestamp"
      expr: fulfillment_timestamp
    - name: "Guest Feedback Text"
      expr: guest_feedback_text
    - name: "Guest Notified Flag"
      expr: guest_notified_flag
    - name: "Guest Satisfaction Rating"
      expr: guest_satisfaction_rating
    - name: "Impacts Loyalty Points"
      expr: impacts_loyalty_points
    - name: "Internal Notes"
      expr: internal_notes
    - name: "Is Pre Arrival"
      expr: is_pre_arrival
    - name: "Is Recurring"
      expr: is_recurring
    - name: "Is Vip Request"
      expr: is_vip_request
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Reservation Special Request"
      expr: COUNT(DISTINCT reservation_special_request_id)
    - name: "Total Actual Cost"
      expr: SUM(actual_cost)
    - name: "Average Actual Cost"
      expr: AVG(actual_cost)
    - name: "Total Charge Amount"
      expr: SUM(charge_amount)
    - name: "Average Charge Amount"
      expr: AVG(charge_amount)
    - name: "Total Estimated Cost"
      expr: SUM(estimated_cost)
    - name: "Average Estimated Cost"
      expr: AVG(estimated_cost)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`reservation_room_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Room Assignment business metrics"
  source: "`vibe_travel_hospitality_v1`.`reservation`.`room_assignment`"
  dimensions:
    - name: "Assignment Date"
      expr: assignment_date
    - name: "Assignment Method"
      expr: assignment_method
    - name: "Assignment Source System"
      expr: assignment_source_system
    - name: "Assignment Status"
      expr: assignment_status
    - name: "Assignment Timestamp"
      expr: assignment_timestamp
    - name: "Bed Configuration"
      expr: bed_configuration
    - name: "Building Code"
      expr: building_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Early Checkin Flag"
      expr: early_checkin_flag
    - name: "Floor Number"
      expr: floor_number
    - name: "Is Accessible Room"
      expr: is_accessible_room
    - name: "Is Connecting Room"
      expr: is_connecting_room
    - name: "Is Guest Requested"
      expr: is_guest_requested
    - name: "Is Upgrade"
      expr: is_upgrade
    - name: "Key Created Timestamp"
      expr: key_created_timestamp
    - name: "Key Type"
      expr: key_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Room Assignment"
      expr: COUNT(DISTINCT room_assignment_id)
    - name: "Total Guest Preference Match Score"
      expr: SUM(guest_preference_match_score)
    - name: "Average Guest Preference Match Score"
      expr: AVG(guest_preference_match_score)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`reservation_travel_agent`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Travel Agent business metrics"
  source: "`vibe_travel_hospitality_v1`.`reservation`.`travel_agent`"
  dimensions:
    - name: "Address Line1"
      expr: address_line1
    - name: "Address Line2"
      expr: address_line2
    - name: "Agency Name"
      expr: agency_name
    - name: "Agency Type"
      expr: agency_type
    - name: "Arc Number"
      expr: arc_number
    - name: "Booking Volume Tier"
      expr: booking_volume_tier
    - name: "City"
      expr: city
    - name: "Contact Email"
      expr: contact_email
    - name: "Contact Name"
      expr: contact_name
    - name: "Contact Phone"
      expr: contact_phone
    - name: "Contract End Date"
      expr: contract_end_date
    - name: "Contract Start Date"
      expr: contract_start_date
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Gds Identifier"
      expr: gds_identifier
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Travel Agent"
      expr: COUNT(DISTINCT travel_agent_id)
    - name: "Total Commission Rate"
      expr: SUM(commission_rate)
    - name: "Average Commission Rate"
      expr: AVG(commission_rate)
    - name: "Total Credit Limit"
      expr: SUM(credit_limit)
    - name: "Average Credit Limit"
      expr: AVG(credit_limit)
    - name: "Total Total Revenue Generated"
      expr: SUM(total_revenue_generated)
    - name: "Average Total Revenue Generated"
      expr: AVG(total_revenue_generated)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`reservation_waitlist`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Waitlist business metrics"
  source: "`vibe_travel_hospitality_v1`.`reservation`.`waitlist`"
  dimensions:
    - name: "Auto Convert Flag"
      expr: auto_convert_flag
    - name: "Cancellation Reason Code"
      expr: cancellation_reason_code
    - name: "Cancellation Timestamp"
      expr: cancellation_timestamp
    - name: "Channel Code"
      expr: channel_code
    - name: "Contact Email"
      expr: contact_email
    - name: "Contact Phone"
      expr: contact_phone
    - name: "Converted Timestamp"
      expr: converted_timestamp
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Expiration Date"
      expr: expiration_date
    - name: "External Reference Code"
      expr: external_reference_code
    - name: "Guarantee Type Code"
      expr: guarantee_type_code
    - name: "Guest Priority Tier"
      expr: guest_priority_tier
    - name: "Market Segment Code"
      expr: market_segment_code
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Notes"
      expr: notes
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Waitlist"
      expr: COUNT(DISTINCT waitlist_id)
    - name: "Total Quoted Rate Amount"
      expr: SUM(quoted_rate_amount)
    - name: "Average Quoted Rate Amount"
      expr: AVG(quoted_rate_amount)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`reservation_walk_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Walk Record business metrics"
  source: "`vibe_travel_hospitality_v1`.`reservation`.`walk_record`"
  dimensions:
    - name: "Brand Standard Compliance Flag"
      expr: brand_standard_compliance_flag
    - name: "Compensation Currency Code"
      expr: compensation_currency_code
    - name: "Compensation Type"
      expr: compensation_type
    - name: "Complaint Filed Flag"
      expr: complaint_filed_flag
    - name: "Complaint Resolution Status"
      expr: complaint_resolution_status
    - name: "Complimentary Nights Count"
      expr: complimentary_nights_count
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Guest Consent Obtained Flag"
      expr: guest_consent_obtained_flag
    - name: "Guest Consent Timestamp"
      expr: guest_consent_timestamp
    - name: "Guest Satisfaction Score"
      expr: guest_satisfaction_score
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Loyalty Points Awarded"
      expr: loyalty_points_awarded
    - name: "Notes"
      expr: notes
    - name: "Nps Score"
      expr: nps_score
    - name: "Original Arrival Date"
      expr: original_arrival_date
    - name: "Original Departure Date"
      expr: original_departure_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Walk Record"
      expr: COUNT(DISTINCT walk_record_id)
    - name: "Total Cash Compensation Amount"
      expr: SUM(cash_compensation_amount)
    - name: "Average Cash Compensation Amount"
      expr: AVG(cash_compensation_amount)
    - name: "Total Ota Penalty Amount"
      expr: SUM(ota_penalty_amount)
    - name: "Average Ota Penalty Amount"
      expr: AVG(ota_penalty_amount)
    - name: "Total Revenue Lost Amount"
      expr: SUM(revenue_lost_amount)
    - name: "Average Revenue Lost Amount"
      expr: AVG(revenue_lost_amount)
    - name: "Total Total Compensation Value Amount"
      expr: SUM(total_compensation_value_amount)
    - name: "Average Total Compensation Value Amount"
      expr: AVG(total_compensation_value_amount)
    - name: "Total Transportation Cost Amount"
      expr: SUM(transportation_cost_amount)
    - name: "Average Transportation Cost Amount"
      expr: AVG(transportation_cost_amount)
$$;