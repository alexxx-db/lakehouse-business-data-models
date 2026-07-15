-- Metric views for domain: inventory | Business: Airlines | Version: 1 | Generated on: 2026-05-07 12:47:29

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`inventory_flight_inventory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core flight inventory performance metrics tracking capacity utilization, load factors, overbooking efficiency, and revenue management effectiveness across the network"
  source: "`airlines_ecm`.`inventory`.`flight_inventory`"
  dimensions:
    - name: "departure_date"
      expr: departure_date
      comment: "Scheduled departure date of the flight"
    - name: "departure_month"
      expr: DATE_TRUNC('MONTH', departure_date)
      comment: "Month of departure for seasonal analysis"
    - name: "origin_airport"
      expr: origin_airport_code
      comment: "Origin airport IATA code"
    - name: "destination_airport"
      expr: destination_airport_code
      comment: "Destination airport IATA code"
    - name: "flight_number"
      expr: flight_number
      comment: "Flight number identifier"
    - name: "inventory_status"
      expr: inventory_status
      comment: "Current status of inventory (open, closed, etc.)"
    - name: "inventory_control_mode"
      expr: inventory_control_mode
      comment: "Revenue management control mode applied"
    - name: "is_codeshare"
      expr: codeshare_indicator
      comment: "Whether flight has codeshare arrangements"
    - name: "revenue_management_class"
      expr: revenue_management_class
      comment: "RM classification for yield optimization"
  measures:
    - name: "total_flights"
      expr: COUNT(1)
      comment: "Total number of flight inventory records"
    - name: "total_capacity"
      expr: SUM(CAST(total_capacity AS DOUBLE))
      comment: "Total seat capacity across all flights"
    - name: "total_seats_sold"
      expr: SUM(CAST(seats_sold AS DOUBLE))
      comment: "Total seats sold across all flights"
    - name: "total_seats_available"
      expr: SUM(CAST(seats_available AS DOUBLE))
      comment: "Total seats currently available for sale"
    - name: "avg_load_factor"
      expr: AVG(CAST(load_factor_pct AS DOUBLE))
      comment: "Average load factor percentage across flights - key capacity utilization metric"
    - name: "avg_overbooking_factor"
      expr: AVG(CAST(overbooking_factor AS DOUBLE))
      comment: "Average overbooking factor applied - measures revenue management aggressiveness"
    - name: "total_waitlist_passengers"
      expr: SUM(CAST(waitlist_count AS DOUBLE))
      comment: "Total passengers on waitlist - indicates demand spillage"
    - name: "total_group_seats_held"
      expr: SUM(CAST(group_seats_held AS DOUBLE))
      comment: "Total seats held for group bookings"
    - name: "total_codeshare_seats"
      expr: SUM(CAST(codeshare_seats_allocated AS DOUBLE))
      comment: "Total seats allocated to codeshare partners"
    - name: "total_first_class_capacity"
      expr: SUM(CAST(first_class_capacity AS DOUBLE))
      comment: "Total first class seat capacity"
    - name: "total_business_class_capacity"
      expr: SUM(CAST(business_class_capacity AS DOUBLE))
      comment: "Total business class seat capacity"
    - name: "total_premium_economy_capacity"
      expr: SUM(CAST(premium_economy_capacity AS DOUBLE))
      comment: "Total premium economy seat capacity"
    - name: "total_economy_capacity"
      expr: SUM(CAST(economy_capacity AS DOUBLE))
      comment: "Total economy class seat capacity"
$$;


CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`inventory_availability_snapshot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Real-time inventory availability metrics tracking seat availability dynamics, revenue management bid prices, demand forecasting accuracy, and booking curve performance"
  source: "`airlines_ecm`.`inventory`.`availability_snapshot`"
  dimensions:
    - name: "snapshot_date"
      expr: DATE_TRUNC('DAY', snapshot_timestamp)
      comment: "Date of the availability snapshot"
    - name: "departure_date"
      expr: departure_date
      comment: "Flight departure date"
    - name: "days_before_departure"
      expr: days_before_departure
      comment: "Number of days before departure when snapshot was taken"
    - name: "origin_airport"
      expr: origin_airport_code
      comment: "Origin airport IATA code"
    - name: "destination_airport"
      expr: destination_airport_code
      comment: "Destination airport IATA code"
    - name: "flight_number"
      expr: flight_number
      comment: "Flight number"
    - name: "availability_code"
      expr: availability_code
      comment: "GDS availability code (e.g., 0-9, L)"
    - name: "bucket_status"
      expr: bucket_status
      comment: "Status of the fare bucket (open, closed, etc.)"
    - name: "is_active_snapshot"
      expr: is_active_snapshot
      comment: "Whether this is the current active snapshot"
    - name: "trigger_reason"
      expr: trigger_reason
      comment: "Reason that triggered the snapshot (booking, time-based, manual)"
    - name: "has_channel_restriction"
      expr: channel_restriction_flag
      comment: "Whether channel restrictions apply"
  measures:
    - name: "total_snapshots"
      expr: COUNT(1)
      comment: "Total number of availability snapshots"
    - name: "total_seats_available"
      expr: SUM(CAST(seats_available AS DOUBLE))
      comment: "Total seats available across all snapshots"
    - name: "total_seats_sold"
      expr: SUM(CAST(seats_sold AS DOUBLE))
      comment: "Total seats sold at snapshot time"
    - name: "total_seats_held"
      expr: SUM(CAST(seats_held AS DOUBLE))
      comment: "Total seats held (not yet ticketed)"
    - name: "total_seats_authorized"
      expr: SUM(CAST(seats_authorized AS DOUBLE))
      comment: "Total seats authorized for sale by revenue management"
    - name: "avg_load_factor"
      expr: AVG(CAST(load_factor AS DOUBLE))
      comment: "Average load factor at snapshot time - tracks booking curve progression"
    - name: "avg_overbooking_factor"
      expr: AVG(CAST(overbooking_factor AS DOUBLE))
      comment: "Average overbooking factor applied"
    - name: "avg_rm_bid_price"
      expr: AVG(CAST(rm_bid_price AS DOUBLE))
      comment: "Average revenue management bid price - key pricing signal for inventory optimization"
    - name: "total_forecast_demand"
      expr: SUM(CAST(rm_forecast_demand AS DOUBLE))
      comment: "Total forecasted demand from revenue management system"
    - name: "total_waitlist_count"
      expr: SUM(CAST(waitlist_count AS DOUBLE))
      comment: "Total passengers on waitlist - indicates unmet demand"
    - name: "total_group_seats_blocked"
      expr: SUM(CAST(group_seats_blocked AS DOUBLE))
      comment: "Total seats blocked for group bookings"
    - name: "total_codeshare_seats"
      expr: SUM(CAST(codeshare_seats_allocated AS DOUBLE))
      comment: "Total seats allocated to codeshare partners"
    - name: "total_upgrade_seats_used"
      expr: SUM(CAST(upgrade_seats_used AS DOUBLE))
      comment: "Total seats consumed by upgrades"
$$;


CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`inventory_overbooking_control`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Overbooking strategy effectiveness metrics tracking denied boarding risk, spoilage risk, compensation exposure, and no-show prediction accuracy to optimize revenue while minimizing customer disruption"
  source: "`airlines_ecm`.`inventory`.`overbooking_control`"
  dimensions:
    - name: "departure_date"
      expr: departure_date
      comment: "Flight departure date"
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_from)
      comment: "Month when overbooking control became effective"
    - name: "control_status"
      expr: control_status
      comment: "Status of overbooking control (active, suspended, etc.)"
    - name: "day_of_week_pattern"
      expr: day_of_week_pattern
      comment: "Day of week pattern for overbooking strategy"
    - name: "season_code"
      expr: season_code
      comment: "Seasonal code for demand patterns"
    - name: "regulatory_market"
      expr: regulatory_market_code
      comment: "Regulatory market code (affects compensation rules)"
    - name: "has_rm_override"
      expr: rm_system_override_flag
      comment: "Whether revenue management system override is active"
    - name: "is_codeshare"
      expr: codeshare_inventory_flag
      comment: "Whether this is codeshare inventory"
  measures:
    - name: "total_overbooking_controls"
      expr: COUNT(1)
      comment: "Total number of overbooking control records"
    - name: "avg_authorized_overbooking_pct"
      expr: AVG(CAST(authorized_overbooking_pct AS DOUBLE))
      comment: "Average authorized overbooking percentage - key risk tolerance metric"
    - name: "avg_historical_no_show_rate"
      expr: AVG(CAST(historical_no_show_rate AS DOUBLE))
      comment: "Average historical no-show rate used for overbooking calculations"
    - name: "avg_cancellation_rate"
      expr: AVG(CAST(cancellation_rate_input AS DOUBLE))
      comment: "Average cancellation rate input to overbooking model"
    - name: "avg_go_show_rate"
      expr: AVG(CAST(go_show_rate_input AS DOUBLE))
      comment: "Average go-show rate (passengers without reservations)"
    - name: "avg_load_factor_forecast"
      expr: AVG(CAST(load_factor_forecast AS DOUBLE))
      comment: "Average forecasted load factor"
    - name: "avg_denied_boarding_risk"
      expr: AVG(CAST(denied_boarding_risk_threshold AS DOUBLE))
      comment: "Average denied boarding risk threshold - measures acceptable IDB probability"
    - name: "avg_spoilage_risk"
      expr: AVG(CAST(spoilage_risk_threshold AS DOUBLE))
      comment: "Average spoilage risk threshold - measures acceptable empty seat probability"
    - name: "total_idb_compensation_exposure"
      expr: SUM(CAST(idb_compensation_exposure_usd AS DOUBLE))
      comment: "Total involuntary denied boarding compensation exposure in USD - key financial risk metric"
    - name: "avg_fare_value"
      expr: AVG(CAST(avg_fare_value_usd AS DOUBLE))
      comment: "Average fare value in USD used for overbooking optimization"
    - name: "total_max_oversale_seats"
      expr: SUM(CAST(max_oversale_seats AS DOUBLE))
      comment: "Total maximum oversale seats authorized"
    - name: "total_upgrade_buffer_seats"
      expr: SUM(CAST(upgrade_buffer_seats AS DOUBLE))
      comment: "Total seats reserved as upgrade buffer"
    - name: "total_group_reserved_seats"
      expr: SUM(CAST(group_booking_seats_reserved AS DOUBLE))
      comment: "Total seats reserved for group bookings"
    - name: "total_physical_capacity"
      expr: SUM(CAST(physical_seat_capacity AS DOUBLE))
      comment: "Total physical seat capacity"
    - name: "total_booking_limit"
      expr: SUM(CAST(booking_limit AS DOUBLE))
      comment: "Total booking limit (capacity + overbooking)"
$$;


CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`inventory_bucket_adjustment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue management intervention metrics tracking manual and automated fare bucket adjustments, measuring RM responsiveness to market conditions, IROP events, and load factor dynamics"
  source: "`airlines_ecm`.`inventory`.`bucket_adjustment`"
  dimensions:
    - name: "adjustment_date"
      expr: DATE_TRUNC('DAY', effective_timestamp)
      comment: "Date when adjustment became effective"
    - name: "flight_date"
      expr: flight_date
      comment: "Date of the flight being adjusted"
    - name: "adjustment_type"
      expr: adjustment_type
      comment: "Type of adjustment (increase, decrease, open, close)"
    - name: "adjustment_status"
      expr: adjustment_status
      comment: "Status of the adjustment (pending, applied, reversed)"
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for the adjustment"
    - name: "is_automated"
      expr: is_automated
      comment: "Whether adjustment was automated or manual"
    - name: "is_codeshare_affected"
      expr: is_codeshare_affected
      comment: "Whether codeshare inventory was affected"
    - name: "origin_airport"
      expr: origin_airport_code
      comment: "Origin airport IATA code"
    - name: "destination_airport"
      expr: destination_airport_code
      comment: "Destination airport IATA code"
    - name: "initiating_system"
      expr: initiating_system
      comment: "System that initiated the adjustment"
    - name: "adjustment_scope"
      expr: adjustment_scope
      comment: "Scope of adjustment (single flight, route, network)"
  measures:
    - name: "total_adjustments"
      expr: COUNT(1)
      comment: "Total number of bucket adjustments - measures RM intervention frequency"
    - name: "total_seats_available_before"
      expr: SUM(CAST(seats_available_before AS DOUBLE))
      comment: "Total seats available before adjustments"
    - name: "total_seats_available_after"
      expr: SUM(CAST(seats_available_after AS DOUBLE))
      comment: "Total seats available after adjustments"
    - name: "avg_load_factor_at_adjustment"
      expr: AVG(CAST(load_factor_at_adjustment AS DOUBLE))
      comment: "Average load factor when adjustment was made - indicates booking curve position"
    - name: "avg_overbooking_factor_before"
      expr: AVG(CAST(overbooking_factor_before AS DOUBLE))
      comment: "Average overbooking factor before adjustment"
    - name: "avg_overbooking_factor_after"
      expr: AVG(CAST(overbooking_factor_after AS DOUBLE))
      comment: "Average overbooking factor after adjustment"
    - name: "distinct_flights_adjusted"
      expr: COUNT(DISTINCT scheduled_flight_id)
      comment: "Number of unique flights adjusted"
    - name: "distinct_employees_adjusting"
      expr: COUNT(DISTINCT employee_id)
      comment: "Number of unique employees making adjustments"
$$;


CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`inventory_irop_reprotection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Irregular operations recovery metrics tracking passenger reprotection effectiveness, inventory impact, compensation exposure, and operational recovery speed during disruptions"
  source: "`airlines_ecm`.`inventory`.`irop_reprotection`"
  dimensions:
    - name: "disrupted_flight_date"
      expr: disrupted_flight_date
      comment: "Date of the disrupted flight"
    - name: "recovery_flight_date"
      expr: recovery_flight_date
      comment: "Date of the recovery flight"
    - name: "reprotection_date"
      expr: DATE_TRUNC('DAY', reprotection_window_open_timestamp)
      comment: "Date when reprotection window opened"
    - name: "reprotection_status"
      expr: reprotection_status
      comment: "Status of reprotection (pending, confirmed, cancelled)"
    - name: "reprotection_type"
      expr: reprotection_type
      comment: "Type of reprotection (same carrier, interline, refund)"
    - name: "irop_cause_type"
      expr: irop_cause_type
      comment: "Root cause type of irregular operation"
    - name: "priority_class"
      expr: priority_class
      comment: "Passenger priority class for reprotection"
    - name: "origin_airport"
      expr: origin_airport_iata_code
      comment: "Origin airport IATA code"
    - name: "destination_airport"
      expr: destination_airport_iata_code
      comment: "Destination airport IATA code"
    - name: "is_interline"
      expr: interline_reprotection_indicator
      comment: "Whether reprotection involved interline carrier"
    - name: "is_codeshare"
      expr: codeshare_indicator
      comment: "Whether disrupted flight was codeshare"
    - name: "downgrade_compensation_applicable"
      expr: downgrade_compensation_applicable
      comment: "Whether downgrade compensation applies"
    - name: "overbooking_override_applied"
      expr: overbooking_override_applied
      comment: "Whether overbooking limits were overridden for recovery"
  measures:
    - name: "total_reprotection_events"
      expr: COUNT(1)
      comment: "Total number of IROP reprotection events - measures disruption frequency"
    - name: "total_pax_displaced"
      expr: SUM(CAST(pax_displaced_count AS DOUBLE))
      comment: "Total passengers displaced by irregular operations - key customer impact metric"
    - name: "total_pnrs_affected"
      expr: SUM(CAST(pnr_count AS DOUBLE))
      comment: "Total PNRs affected by irregular operations"
    - name: "total_seats_ring_fenced"
      expr: SUM(CAST(seats_ring_fenced AS DOUBLE))
      comment: "Total seats ring-fenced for reprotection - measures inventory protection"
    - name: "total_seats_utilized"
      expr: SUM(CAST(seats_utilized AS DOUBLE))
      comment: "Total reprotection seats actually utilized"
    - name: "total_seats_released"
      expr: SUM(CAST(seats_released AS DOUBLE))
      comment: "Total ring-fenced seats released back to inventory"
    - name: "distinct_disrupted_flights"
      expr: COUNT(DISTINCT scheduled_flight_id)
      comment: "Number of unique flights experiencing irregular operations"
    - name: "distinct_irop_events"
      expr: COUNT(DISTINCT flight_irop_event_id)
      comment: "Number of unique IROP events"
$$;


CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`inventory_codeshare_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Codeshare partnership performance metrics tracking seat allocation utilization, revenue share effectiveness, and bilateral agreement compliance across marketing and operating carriers"
  source: "`airlines_ecm`.`inventory`.`codeshare_allocation`"
  dimensions:
    - name: "flight_date"
      expr: flight_date
      comment: "Date of the codeshare flight"
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_from)
      comment: "Month when allocation became effective"
    - name: "allocation_status"
      expr: allocation_status
      comment: "Status of the allocation (active, suspended, expired)"
    - name: "allocation_type"
      expr: allocation_type
      comment: "Type of allocation (free-sale, block-space, etc.)"
    - name: "origin_airport"
      expr: origin_iata_code
      comment: "Origin airport IATA code"
    - name: "destination_airport"
      expr: destination_iata_code
      comment: "Destination airport IATA code"
    - name: "marketing_carrier"
      expr: CAST(marketing_carrier_code AS STRING)
      comment: "Marketing carrier code"
    - name: "operating_flight_number"
      expr: operating_flight_number
      comment: "Operating carrier flight number"
    - name: "marketing_flight_number"
      expr: marketing_flight_number
      comment: "Marketing carrier flight number"
    - name: "is_interline"
      expr: interline_indicator
      comment: "Whether this is an interline arrangement"
    - name: "gds_available"
      expr: gds_availability_indicator
      comment: "Whether inventory is available in GDS"
  measures:
    - name: "total_codeshare_allocations"
      expr: COUNT(1)
      comment: "Total number of codeshare allocation records"
    - name: "total_authorized_seats"
      expr: SUM(CAST(authorized_seat_count AS DOUBLE))
      comment: "Total seats authorized for codeshare partners"
    - name: "total_seats_sold"
      expr: SUM(CAST(seats_sold AS DOUBLE))
      comment: "Total codeshare seats sold - measures partnership utilization"
    - name: "total_seats_available"
      expr: SUM(CAST(seats_available AS DOUBLE))
      comment: "Total codeshare seats currently available"
    - name: "avg_revenue_share_pct"
      expr: AVG(CAST(revenue_share_percentage AS DOUBLE))
      comment: "Average revenue share percentage - key partnership economics metric"
    - name: "avg_overbooking_factor"
      expr: AVG(CAST(overbooking_factor AS DOUBLE))
      comment: "Average overbooking factor applied to codeshare inventory"
    - name: "total_minimum_threshold_seats"
      expr: SUM(CAST(minimum_seat_threshold AS DOUBLE))
      comment: "Total minimum seat thresholds across allocations"
    - name: "total_maximum_threshold_seats"
      expr: SUM(CAST(maximum_seat_threshold AS DOUBLE))
      comment: "Total maximum seat thresholds across allocations"
    - name: "distinct_marketing_carriers"
      expr: COUNT(DISTINCT marketing_carrier_code)
      comment: "Number of unique marketing carrier partners"
    - name: "distinct_operating_carriers"
      expr: COUNT(DISTINCT carrier_id)
      comment: "Number of unique operating carriers"
    - name: "distinct_bilateral_agreements"
      expr: COUNT(DISTINCT bilateral_asa_id)
      comment: "Number of unique bilateral air service agreements"
$$;


CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`inventory_group_block`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Group booking inventory management metrics tracking block utilization, deposit collection, ticketing compliance, and revenue contribution from group travel segments"
  source: "`airlines_ecm`.`inventory`.`group_block`"
  dimensions:
    - name: "created_date"
      expr: DATE_TRUNC('DAY', created_timestamp)
      comment: "Date when group block was created"
    - name: "option_date"
      expr: option_date
      comment: "Date by which group must confirm or release"
    - name: "names_due_date"
      expr: names_due_date
      comment: "Date by which passenger names are due"
    - name: "final_payment_due_date"
      expr: final_payment_due_date
      comment: "Date by which final payment is due"
    - name: "ticketing_deadline"
      expr: ticketing_deadline
      comment: "Deadline for ticketing group passengers"
    - name: "block_status"
      expr: block_status
      comment: "Status of the group block (option, confirmed, cancelled)"
    - name: "group_type"
      expr: group_type
      comment: "Type of group (tour, corporate, sports, etc.)"
    - name: "sales_channel"
      expr: sales_channel
      comment: "Sales channel through which group was booked"
    - name: "deposit_paid"
      expr: deposit_paid
      comment: "Whether deposit has been paid"
    - name: "deposit_required"
      expr: deposit_required
      comment: "Whether deposit is required"
    - name: "is_codeshare"
      expr: codeshare_indicator
      comment: "Whether group is on codeshare flight"
    - name: "overbooking_eligible"
      expr: overbooking_eligible
      comment: "Whether group seats are eligible for overbooking"
  measures:
    - name: "total_group_blocks"
      expr: COUNT(1)
      comment: "Total number of group blocks"
    - name: "total_seats_requested"
      expr: SUM(CAST(seats_requested AS DOUBLE))
      comment: "Total seats requested by groups"
    - name: "total_seats_blocked"
      expr: SUM(CAST(seats_blocked AS DOUBLE))
      comment: "Total seats currently blocked for groups - measures inventory commitment"
    - name: "total_seats_confirmed"
      expr: SUM(CAST(seats_confirmed AS DOUBLE))
      comment: "Total seats confirmed by groups"
    - name: "total_seats_ticketed"
      expr: SUM(CAST(seats_ticketed AS DOUBLE))
      comment: "Total seats ticketed - measures revenue realization"
    - name: "total_seats_released"
      expr: SUM(CAST(seats_released AS DOUBLE))
      comment: "Total seats released back to inventory - measures group attrition"
    - name: "total_free_seats_allocated"
      expr: SUM(CAST(free_seats_allocated AS DOUBLE))
      comment: "Total complimentary seats allocated to groups"
    - name: "avg_free_seat_ratio"
      expr: AVG(CAST(free_seat_ratio AS DOUBLE))
      comment: "Average ratio of free seats to paid seats"
    - name: "total_deposit_amount"
      expr: SUM(CAST(deposit_amount AS DOUBLE))
      comment: "Total deposit amount collected - measures financial commitment"
    - name: "avg_group_fare_amount"
      expr: AVG(CAST(group_fare_amount AS DOUBLE))
      comment: "Average fare amount per group booking"
    - name: "total_minimum_group_size"
      expr: SUM(CAST(minimum_group_size AS DOUBLE))
      comment: "Total minimum group size requirements"
    - name: "distinct_campaigns"
      expr: COUNT(DISTINCT campaign_id)
      comment: "Number of unique marketing campaigns associated with groups"
    - name: "distinct_pnrs"
      expr: COUNT(DISTINCT pnr_id)
      comment: "Number of unique PNRs for group bookings"
$$;


CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`inventory_waitlist_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Waitlist management and clearance metrics tracking unmet demand, clearance rates, priority processing effectiveness, and revenue recovery from waitlisted passengers"
  source: "`airlines_ecm`.`inventory`.`waitlist_entry`"
  dimensions:
    - name: "created_date"
      expr: DATE_TRUNC('DAY', created_timestamp)
      comment: "Date when waitlist entry was created"
    - name: "flight_date"
      expr: flight_date
      comment: "Date of the waitlisted flight"
    - name: "clearance_date"
      expr: DATE_TRUNC('DAY', clearance_timestamp)
      comment: "Date when waitlist was cleared"
    - name: "waitlist_status"
      expr: waitlist_status
      comment: "Status of waitlist entry (active, cleared, expired, cancelled)"
    - name: "waitlist_reason"
      expr: waitlist_reason
      comment: "Reason for waitlisting (sold out, upgrade, etc.)"
    - name: "clearance_method"
      expr: clearance_method
      comment: "Method used to clear waitlist (auto, manual, upgrade)"
    - name: "origin_airport"
      expr: origin_airport_code
      comment: "Origin airport IATA code"
    - name: "destination_airport"
      expr: destination_airport_code
      comment: "Destination airport IATA code"
    - name: "flight_number"
      expr: flight_number
      comment: "Flight number"
    - name: "booking_class"
      expr: booking_class
      comment: "Booking class requested"
    - name: "cabin_code"
      expr: cabin_code
      comment: "Cabin class requested"
    - name: "ffp_tier"
      expr: ffp_tier
      comment: "Frequent flyer program tier of passenger"
    - name: "is_codeshare"
      expr: is_codeshare
      comment: "Whether waitlist is for codeshare flight"
    - name: "notification_sent"
      expr: notification_sent
      comment: "Whether clearance notification was sent"
    - name: "has_rm_override"
      expr: revenue_management_override
      comment: "Whether revenue management override was applied"
  measures:
    - name: "total_waitlist_entries"
      expr: COUNT(1)
      comment: "Total number of waitlist entries - measures unmet demand"
    - name: "total_seats_requested"
      expr: SUM(CAST(seat_count_requested AS DOUBLE))
      comment: "Total seats requested on waitlist"
    - name: "distinct_passengers"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique passengers on waitlist"
    - name: "distinct_pnrs"
      expr: COUNT(DISTINCT pnr_id)
      comment: "Number of unique PNRs with waitlisted passengers"
    - name: "distinct_flights"
      expr: COUNT(DISTINCT flight_inventory_id)
      comment: "Number of unique flights with waitlist demand"
    - name: "distinct_fare_classes"
      expr: COUNT(DISTINCT fare_class_id)
      comment: "Number of unique fare classes with waitlist demand"
$$;
