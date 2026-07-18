-- Metric views for domain: reservation | Business: Airlines | Version: 1 | Generated on: 2026-05-07 12:47:29

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`reservation_pnr`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core booking and reservation performance metrics tracking booking volume, revenue, conversion, and channel effectiveness"
  source: "`airlines_ecm`.`reservation`.`pnr`"
  dimensions:
    - name: "booking_date"
      expr: DATE_TRUNC('day', creation_timestamp)
      comment: "Date the PNR was created"
    - name: "booking_month"
      expr: DATE_TRUNC('month', creation_timestamp)
      comment: "Month the PNR was created"
    - name: "departure_date"
      expr: departure_date
      comment: "Scheduled departure date for the journey"
    - name: "booking_status"
      expr: booking_status
      comment: "Current status of the booking (confirmed, cancelled, etc.)"
    - name: "booking_type"
      expr: booking_type
      comment: "Type of booking (individual, group, corporate, etc.)"
    - name: "distribution_channel"
      expr: distribution_channel
      comment: "Channel through which booking was made (web, mobile, GDS, call center, etc.)"
    - name: "booking_source"
      expr: booking_source
      comment: "Source system or platform of the booking"
    - name: "trip_type"
      expr: trip_type
      comment: "Type of trip (one-way, round-trip, multi-city)"
    - name: "origin_city"
      expr: origin_city_code
      comment: "Origin city code for the journey"
    - name: "destination_city"
      expr: destination_city_code
      comment: "Destination city code for the journey"
    - name: "point_of_sale_country"
      expr: point_of_sale_country
      comment: "Country where the booking was made"
    - name: "point_of_sale_city"
      expr: point_of_sale_city
      comment: "City where the booking was made"
    - name: "has_corporate_account"
      expr: CASE WHEN corporate_account_number IS NOT NULL THEN 'Yes' ELSE 'No' END
      comment: "Whether booking is associated with a corporate account"
    - name: "is_interline"
      expr: CASE WHEN interline_indicator = TRUE THEN 'Yes' ELSE 'No' END
      comment: "Whether booking involves interline segments"
    - name: "is_codeshare"
      expr: CASE WHEN codeshare_indicator = TRUE THEN 'Yes' ELSE 'No' END
      comment: "Whether booking involves codeshare segments"
    - name: "booking_lead_time_bucket"
      expr: CASE WHEN DATEDIFF(departure_date, DATE(creation_timestamp)) <= 7 THEN '0-7 days' WHEN DATEDIFF(departure_date, DATE(creation_timestamp)) <= 14 THEN '8-14 days' WHEN DATEDIFF(departure_date, DATE(creation_timestamp)) <= 30 THEN '15-30 days' WHEN DATEDIFF(departure_date, DATE(creation_timestamp)) <= 60 THEN '31-60 days' WHEN DATEDIFF(departure_date, DATE(creation_timestamp)) <= 90 THEN '61-90 days' ELSE '90+ days' END
      comment: "Bucketed lead time between booking and departure"
  measures:
    - name: "total_bookings"
      expr: COUNT(DISTINCT pnr_id)
      comment: "Total number of unique bookings (PNRs)"
    - name: "total_passengers"
      expr: SUM(CAST(passenger_count AS BIGINT))
      comment: "Total number of passengers across all bookings"
    - name: "total_segments"
      expr: SUM(CAST(segment_count AS BIGINT))
      comment: "Total number of flight segments booked"
    - name: "total_base_fare_revenue"
      expr: SUM(CAST(base_fare_amount AS DOUBLE))
      comment: "Total base fare revenue across all bookings"
    - name: "total_tax_revenue"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount collected across all bookings"
    - name: "total_fare_revenue"
      expr: SUM(CAST(total_fare_amount AS DOUBLE))
      comment: "Total fare revenue including base fare and taxes"
    - name: "avg_base_fare_per_booking"
      expr: AVG(CAST(base_fare_amount AS DOUBLE))
      comment: "Average base fare amount per booking"
    - name: "avg_total_fare_per_booking"
      expr: AVG(CAST(total_fare_amount AS DOUBLE))
      comment: "Average total fare amount per booking"
    - name: "avg_passengers_per_booking"
      expr: AVG(CAST(passenger_count AS DOUBLE))
      comment: "Average number of passengers per booking"
    - name: "avg_segments_per_booking"
      expr: AVG(CAST(segment_count AS DOUBLE))
      comment: "Average number of segments per booking"
    - name: "ticketed_bookings"
      expr: COUNT(DISTINCT CASE WHEN ticketed_timestamp IS NOT NULL THEN pnr_id END)
      comment: "Number of bookings that have been ticketed"
$$;


CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`reservation_itinerary_segment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Flight segment-level metrics tracking segment volume, revenue, load factors, and operational performance"
  source: "`airlines_ecm`.`reservation`.`itinerary_segment`"
  dimensions:
    - name: "departure_date"
      expr: DATE_TRUNC('day', scheduled_departure_datetime)
      comment: "Date of scheduled departure"
    - name: "departure_month"
      expr: DATE_TRUNC('month', scheduled_departure_datetime)
      comment: "Month of scheduled departure"
    - name: "booking_date"
      expr: DATE_TRUNC('day', segment_created_timestamp)
      comment: "Date the segment was booked"
    - name: "segment_status"
      expr: segment_status_code
      comment: "Current status of the segment (confirmed, waitlisted, cancelled, etc.)"
    - name: "booking_class"
      expr: booking_class_code
      comment: "Booking class code for the segment"
    - name: "fare_basis"
      expr: fare_basis_code
      comment: "Fare basis code for pricing and rules"
    - name: "origin_airport"
      expr: SUBSTRING(marketing_flight_number, 1, 3)
      comment: "Origin airport code (derived from context)"
    - name: "destination_airport"
      expr: arrival_airport_code
      comment: "Destination airport code"
    - name: "marketing_carrier"
      expr: marketing_carrier_code
      comment: "Marketing carrier code"
    - name: "operating_carrier"
      expr: operating_carrier_code
      comment: "Operating carrier code"
    - name: "marketing_flight_number"
      expr: marketing_flight_number
      comment: "Marketing flight number"
    - name: "operating_flight_number"
      expr: operating_flight_number
      comment: "Operating flight number"
    - name: "is_codeshare"
      expr: CASE WHEN codeshare_indicator = TRUE THEN 'Yes' ELSE 'No' END
      comment: "Whether segment is a codeshare flight"
    - name: "is_interline"
      expr: CASE WHEN interline_indicator = TRUE THEN 'Yes' ELSE 'No' END
      comment: "Whether segment is an interline connection"
    - name: "is_flown"
      expr: CASE WHEN flown_indicator = TRUE THEN 'Yes' ELSE 'No' END
      comment: "Whether segment has been flown"
    - name: "has_schedule_change"
      expr: CASE WHEN schedule_change_indicator = TRUE THEN 'Yes' ELSE 'No' END
      comment: "Whether segment has experienced a schedule change"
    - name: "booking_channel"
      expr: booking_channel_code
      comment: "Channel through which segment was booked"
    - name: "booking_lead_time_bucket"
      expr: CASE WHEN DATEDIFF(DATE(scheduled_departure_datetime), DATE(segment_created_timestamp)) <= 7 THEN '0-7 days' WHEN DATEDIFF(DATE(scheduled_departure_datetime), DATE(segment_created_timestamp)) <= 14 THEN '8-14 days' WHEN DATEDIFF(DATE(scheduled_departure_datetime), DATE(segment_created_timestamp)) <= 30 THEN '15-30 days' WHEN DATEDIFF(DATE(scheduled_departure_datetime), DATE(segment_created_timestamp)) <= 60 THEN '31-60 days' WHEN DATEDIFF(DATE(scheduled_departure_datetime), DATE(segment_created_timestamp)) <= 90 THEN '61-90 days' ELSE '90+ days' END
      comment: "Bucketed lead time between booking and departure"
  measures:
    - name: "total_segments_booked"
      expr: COUNT(DISTINCT itinerary_segment_id)
      comment: "Total number of unique segments booked"
    - name: "total_seats_booked"
      expr: SUM(CAST(number_of_seats AS BIGINT))
      comment: "Total number of seats booked across all segments"
    - name: "total_segment_fare_revenue"
      expr: SUM(CAST(fare_amount AS DOUBLE))
      comment: "Total fare revenue at segment level"
    - name: "avg_fare_per_segment"
      expr: AVG(CAST(fare_amount AS DOUBLE))
      comment: "Average fare amount per segment"
    - name: "flown_segments"
      expr: COUNT(DISTINCT CASE WHEN flown_indicator = TRUE THEN itinerary_segment_id END)
      comment: "Number of segments that have been flown"
    - name: "codeshare_segments"
      expr: COUNT(DISTINCT CASE WHEN codeshare_indicator = TRUE THEN itinerary_segment_id END)
      comment: "Number of codeshare segments"
    - name: "interline_segments"
      expr: COUNT(DISTINCT CASE WHEN interline_indicator = TRUE THEN itinerary_segment_id END)
      comment: "Number of interline segments"
    - name: "schedule_changed_segments"
      expr: COUNT(DISTINCT CASE WHEN schedule_change_indicator = TRUE THEN itinerary_segment_id END)
      comment: "Number of segments with schedule changes"
    - name: "unique_pnrs"
      expr: COUNT(DISTINCT pnr_id)
      comment: "Number of unique PNRs associated with segments"
    - name: "unique_routes"
      expr: COUNT(DISTINCT route_id)
      comment: "Number of unique routes flown"
$$;


CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`reservation_booking_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment transaction metrics tracking payment volume, success rates, fraud, refunds, and payment method performance"
  source: "`airlines_ecm`.`reservation`.`booking_payment`"
  dimensions:
    - name: "payment_date"
      expr: DATE_TRUNC('day', payment_timestamp)
      comment: "Date the payment was processed"
    - name: "payment_month"
      expr: DATE_TRUNC('month', payment_timestamp)
      comment: "Month the payment was processed"
    - name: "payment_status"
      expr: payment_status
      comment: "Status of the payment (authorized, captured, declined, refunded, etc.)"
    - name: "payment_method_type"
      expr: payment_method_type
      comment: "Type of payment method (credit card, debit card, miles, voucher, etc.)"
    - name: "card_type"
      expr: card_type
      comment: "Type of card used (Visa, Mastercard, Amex, etc.)"
    - name: "payment_currency"
      expr: payment_currency_code
      comment: "Currency in which payment was made"
    - name: "has_instalment_plan"
      expr: CASE WHEN instalment_plan_flag = TRUE THEN 'Yes' ELSE 'No' END
      comment: "Whether payment is part of an instalment plan"
    - name: "three_ds_status"
      expr: three_ds_authentication_status
      comment: "3D Secure authentication status"
    - name: "fraud_risk_bucket"
      expr: CASE WHEN fraud_score < 10 THEN 'Low Risk' WHEN fraud_score < 30 THEN 'Medium Risk' WHEN fraud_score < 60 THEN 'High Risk' ELSE 'Very High Risk' END
      comment: "Fraud risk categorization based on fraud score"
    - name: "has_refund"
      expr: CASE WHEN refund_amount > 0 THEN 'Yes' ELSE 'No' END
      comment: "Whether payment has been refunded"
    - name: "processor_response"
      expr: processor_response_code
      comment: "Payment processor response code"
  measures:
    - name: "total_payments"
      expr: COUNT(DISTINCT booking_payment_id)
      comment: "Total number of payment transactions"
    - name: "total_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total payment amount processed"
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total amount refunded to customers"
    - name: "net_payment_amount"
      expr: SUM((CAST(payment_amount AS DOUBLE)) - (CAST(refund_amount AS DOUBLE)))
      comment: "Net payment amount after refunds"
    - name: "avg_payment_amount"
      expr: AVG(CAST(payment_amount AS DOUBLE))
      comment: "Average payment amount per transaction"
    - name: "avg_fraud_score"
      expr: AVG(CAST(fraud_score AS DOUBLE))
      comment: "Average fraud score across all payments"
    - name: "successful_payments"
      expr: COUNT(DISTINCT CASE WHEN payment_status IN ('authorized', 'captured', 'settled') THEN booking_payment_id END)
      comment: "Number of successful payment transactions"
    - name: "declined_payments"
      expr: COUNT(DISTINCT CASE WHEN payment_status = 'declined' THEN booking_payment_id END)
      comment: "Number of declined payment transactions"
    - name: "refunded_payments"
      expr: COUNT(DISTINCT CASE WHEN refund_amount > 0 THEN booking_payment_id END)
      comment: "Number of payments that have been refunded"
    - name: "high_fraud_risk_payments"
      expr: COUNT(DISTINCT CASE WHEN fraud_score >= 60 THEN booking_payment_id END)
      comment: "Number of payments with high fraud risk (score >= 60)"
    - name: "total_miles_redeemed"
      expr: SUM(CAST(miles_redeemed_quantity AS DOUBLE))
      comment: "Total loyalty miles redeemed for payments"
    - name: "unique_pnrs_paid"
      expr: COUNT(DISTINCT pnr_id)
      comment: "Number of unique PNRs with payment transactions"
$$;


CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`reservation_check_in_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Check-in performance metrics tracking check-in volume, channel effectiveness, baggage, upgrades, and operational efficiency"
  source: "`airlines_ecm`.`reservation`.`check_in_event`"
  dimensions:
    - name: "check_in_date"
      expr: DATE_TRUNC('day', check_in_timestamp)
      comment: "Date of check-in event"
    - name: "check_in_month"
      expr: DATE_TRUNC('month', check_in_timestamp)
      comment: "Month of check-in event"
    - name: "check_in_status"
      expr: check_in_status
      comment: "Status of check-in (completed, pending, failed, etc.)"
    - name: "check_in_channel"
      expr: check_in_channel
      comment: "Channel used for check-in (mobile, web, kiosk, counter, etc.)"
    - name: "check_in_station"
      expr: check_in_station_code
      comment: "Airport station code where check-in occurred"
    - name: "boarding_group"
      expr: boarding_group
      comment: "Assigned boarding group"
    - name: "has_checked_baggage"
      expr: CASE WHEN CAST(checked_bags_count AS INT) > 0 THEN 'Yes' ELSE 'No' END
      comment: "Whether passenger checked baggage"
    - name: "has_excess_baggage_fee"
      expr: CASE WHEN excess_baggage_fee_amount > 0 THEN 'Yes' ELSE 'No' END
      comment: "Whether excess baggage fee was charged"
    - name: "has_priority_boarding"
      expr: CASE WHEN priority_boarding_flag = TRUE THEN 'Yes' ELSE 'No' END
      comment: "Whether passenger has priority boarding"
    - name: "upgraded_at_check_in"
      expr: CASE WHEN upgrade_at_check_in_flag = TRUE THEN 'Yes' ELSE 'No' END
      comment: "Whether passenger was upgraded at check-in"
    - name: "upgraded_cabin"
      expr: upgraded_cabin_class
      comment: "Cabin class upgraded to at check-in"
    - name: "mobile_boarding_pass_issued"
      expr: CASE WHEN mobile_boarding_pass_issued_flag = TRUE THEN 'Yes' ELSE 'No' END
      comment: "Whether mobile boarding pass was issued"
    - name: "document_verification_status"
      expr: document_verification_status
      comment: "Status of document verification"
    - name: "apis_submission_status"
      expr: apis_submission_status
      comment: "Status of APIS (Advance Passenger Information System) submission"
    - name: "check_in_timing_bucket"
      expr: CASE WHEN CAST(minutes_before_departure AS INT) <= 60 THEN '0-60 min' WHEN CAST(minutes_before_departure AS INT) <= 120 THEN '61-120 min' WHEN CAST(minutes_before_departure AS INT) <= 240 THEN '121-240 min' WHEN CAST(minutes_before_departure AS INT) <= 1440 THEN '4-24 hours' ELSE '24+ hours' END
      comment: "Bucketed time before departure when check-in occurred"
  measures:
    - name: "total_check_ins"
      expr: COUNT(DISTINCT check_in_event_id)
      comment: "Total number of check-in events"
    - name: "successful_check_ins"
      expr: COUNT(DISTINCT CASE WHEN check_in_status = 'completed' THEN check_in_event_id END)
      comment: "Number of successfully completed check-ins"
    - name: "total_checked_bags"
      expr: SUM(CAST(checked_bags_count AS BIGINT))
      comment: "Total number of bags checked"
    - name: "total_baggage_weight_kg"
      expr: SUM(CAST(checked_baggage_weight_kg AS DOUBLE))
      comment: "Total weight of checked baggage in kilograms"
    - name: "total_excess_baggage_fees"
      expr: SUM(CAST(excess_baggage_fee_amount AS DOUBLE))
      comment: "Total excess baggage fees collected"
    - name: "avg_baggage_weight_per_passenger"
      expr: AVG(CAST(checked_baggage_weight_kg AS DOUBLE))
      comment: "Average checked baggage weight per passenger"
    - name: "passengers_with_checked_bags"
      expr: COUNT(DISTINCT CASE WHEN CAST(checked_bags_count AS INT) > 0 THEN check_in_event_id END)
      comment: "Number of passengers who checked baggage"
    - name: "passengers_with_excess_baggage"
      expr: COUNT(DISTINCT CASE WHEN excess_baggage_fee_amount > 0 THEN check_in_event_id END)
      comment: "Number of passengers charged excess baggage fees"
    - name: "priority_boarding_passengers"
      expr: COUNT(DISTINCT CASE WHEN priority_boarding_flag = TRUE THEN check_in_event_id END)
      comment: "Number of passengers with priority boarding"
    - name: "upgraded_at_check_in_count"
      expr: COUNT(DISTINCT CASE WHEN upgrade_at_check_in_flag = TRUE THEN check_in_event_id END)
      comment: "Number of passengers upgraded at check-in"
    - name: "mobile_boarding_passes_issued"
      expr: COUNT(DISTINCT CASE WHEN mobile_boarding_pass_issued_flag = TRUE THEN check_in_event_id END)
      comment: "Number of mobile boarding passes issued"
    - name: "unique_passengers"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique passengers who checked in"
    - name: "unique_pnrs"
      expr: COUNT(DISTINCT pnr_id)
      comment: "Number of unique PNRs with check-in events"
$$;


CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`reservation_refund_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Refund performance metrics tracking refund volume, processing efficiency, reason analysis, and financial impact"
  source: "`airlines_ecm`.`reservation`.`refund_transaction`"
  dimensions:
    - name: "refund_request_date"
      expr: refund_request_date
      comment: "Date refund was requested"
    - name: "refund_processing_date"
      expr: refund_processing_date
      comment: "Date refund was processed"
    - name: "refund_request_month"
      expr: DATE_TRUNC('month', CAST(refund_request_date AS TIMESTAMP))
      comment: "Month refund was requested"
    - name: "refund_status"
      expr: refund_status
      comment: "Current status of refund (pending, approved, processed, rejected, etc.)"
    - name: "refund_type"
      expr: refund_type
      comment: "Type of refund (voluntary, involuntary, partial, full, etc.)"
    - name: "refund_reason_code"
      expr: refund_reason_code
      comment: "Code indicating reason for refund"
    - name: "refund_reason_description"
      expr: refund_reason_description
      comment: "Description of refund reason"
    - name: "refund_method"
      expr: refund_method
      comment: "Method of refund (original payment method, voucher, miles, etc.)"
    - name: "processing_channel"
      expr: processing_channel
      comment: "Channel through which refund was processed"
    - name: "currency"
      expr: currency_code
      comment: "Currency of refund"
    - name: "has_waiver"
      expr: CASE WHEN waiver_flag = TRUE THEN 'Yes' ELSE 'No' END
      comment: "Whether refund penalty was waived"
    - name: "has_penalty"
      expr: CASE WHEN penalty_amount > 0 THEN 'Yes' ELSE 'No' END
      comment: "Whether penalty was applied to refund"
    - name: "refund_processing_time_bucket"
      expr: CASE WHEN DATEDIFF(refund_processing_date, refund_request_date) <= 1 THEN '0-1 day' WHEN DATEDIFF(refund_processing_date, refund_request_date) <= 3 THEN '2-3 days' WHEN DATEDIFF(refund_processing_date, refund_request_date) <= 7 THEN '4-7 days' WHEN DATEDIFF(refund_processing_date, refund_request_date) <= 14 THEN '8-14 days' ELSE '15+ days' END
      comment: "Bucketed time to process refund from request"
  measures:
    - name: "total_refund_transactions"
      expr: COUNT(DISTINCT refund_transaction_id)
      comment: "Total number of refund transactions"
    - name: "total_refund_amount"
      expr: SUM(CAST(total_refund_amount AS DOUBLE))
      comment: "Total amount refunded to customers"
    - name: "total_base_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total base fare refund amount"
    - name: "total_tax_refund_amount"
      expr: SUM(CAST(tax_refund_amount AS DOUBLE))
      comment: "Total tax refund amount"
    - name: "total_fee_refund_amount"
      expr: SUM(CAST(fee_refund_amount AS DOUBLE))
      comment: "Total fee refund amount"
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total penalty amount deducted from refunds"
    - name: "net_refund_after_penalties"
      expr: SUM((CAST(total_refund_amount AS DOUBLE)) - (CAST(penalty_amount AS DOUBLE)))
      comment: "Net refund amount after deducting penalties"
    - name: "avg_refund_amount"
      expr: AVG(CAST(total_refund_amount AS DOUBLE))
      comment: "Average refund amount per transaction"
    - name: "avg_penalty_amount"
      expr: AVG(CAST(penalty_amount AS DOUBLE))
      comment: "Average penalty amount per refund"
    - name: "approved_refunds"
      expr: COUNT(DISTINCT CASE WHEN refund_status = 'approved' THEN refund_transaction_id END)
      comment: "Number of approved refund requests"
    - name: "processed_refunds"
      expr: COUNT(DISTINCT CASE WHEN refund_status = 'processed' THEN refund_transaction_id END)
      comment: "Number of processed refunds"
    - name: "rejected_refunds"
      expr: COUNT(DISTINCT CASE WHEN refund_status = 'rejected' THEN refund_transaction_id END)
      comment: "Number of rejected refund requests"
    - name: "waived_penalty_refunds"
      expr: COUNT(DISTINCT CASE WHEN waiver_flag = TRUE THEN refund_transaction_id END)
      comment: "Number of refunds with waived penalties"
    - name: "unique_pnrs_refunded"
      expr: COUNT(DISTINCT pnr_id)
      comment: "Number of unique PNRs with refund transactions"
$$;


CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`reservation_voluntary_change`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Voluntary change transaction metrics tracking change volume, fees, fare differences, and change reason analysis"
  source: "`airlines_ecm`.`reservation`.`voluntary_change`"
  dimensions:
    - name: "change_request_date"
      expr: DATE_TRUNC('day', change_request_timestamp)
      comment: "Date change was requested"
    - name: "change_processed_date"
      expr: DATE_TRUNC('day', change_processed_timestamp)
      comment: "Date change was processed"
    - name: "change_request_month"
      expr: DATE_TRUNC('month', change_request_timestamp)
      comment: "Month change was requested"
    - name: "change_status"
      expr: change_status
      comment: "Status of change request (pending, approved, processed, rejected, etc.)"
    - name: "change_type"
      expr: change_type
      comment: "Type of change (date, route, cabin, passenger, etc.)"
    - name: "change_reason"
      expr: change_reason_code
      comment: "Reason code for voluntary change"
    - name: "change_channel"
      expr: change_channel
      comment: "Channel through which change was requested"
    - name: "currency"
      expr: currency_code
      comment: "Currency of change transaction"
    - name: "has_fee_waiver"
      expr: CASE WHEN change_fee_waiver_code IS NOT NULL THEN 'Yes' ELSE 'No' END
      comment: "Whether change fee was waived"
    - name: "has_fare_difference"
      expr: CASE WHEN fare_difference_amount != 0 THEN 'Yes' ELSE 'No' END
      comment: "Whether there was a fare difference"
    - name: "fare_difference_direction"
      expr: CASE WHEN fare_difference_amount > 0 THEN 'Fare Increase' WHEN fare_difference_amount < 0 THEN 'Fare Decrease' ELSE 'No Change' END
      comment: "Direction of fare difference (increase, decrease, no change)"
    - name: "original_cabin"
      expr: original_cabin_class
      comment: "Original cabin class before change"
    - name: "new_cabin"
      expr: new_cabin_class
      comment: "New cabin class after change"
    - name: "cabin_change_direction"
      expr: CASE WHEN original_cabin_class != new_cabin_class THEN 'Cabin Changed' ELSE 'Same Cabin' END
      comment: "Whether cabin class changed"
    - name: "has_interline_agreement"
      expr: CASE WHEN interline_agreement_flag = TRUE THEN 'Yes' ELSE 'No' END
      comment: "Whether change involves interline agreement"
  measures:
    - name: "total_change_transactions"
      expr: COUNT(DISTINCT voluntary_change_id)
      comment: "Total number of voluntary change transactions"
    - name: "total_change_fees"
      expr: SUM(CAST(change_fee_amount AS DOUBLE))
      comment: "Total change fees collected"
    - name: "total_fare_difference_collected"
      expr: SUM(CAST(CASE WHEN fare_difference_amount > 0 THEN fare_difference_amount ELSE 0 END AS DOUBLE))
      comment: "Total positive fare differences collected"
    - name: "total_fare_difference_refunded"
      expr: SUM(CAST(CASE WHEN fare_difference_amount < 0 THEN ABS(fare_difference_amount) ELSE 0 END AS DOUBLE))
      comment: "Total negative fare differences refunded"
    - name: "total_amount_collected"
      expr: SUM(CAST(total_amount_collected AS DOUBLE))
      comment: "Total amount collected from changes (fees + fare differences)"
    - name: "total_amount_refunded"
      expr: SUM(CAST(total_amount_refunded AS DOUBLE))
      comment: "Total amount refunded from changes"
    - name: "net_change_revenue"
      expr: SUM((CAST(total_amount_collected AS DOUBLE)) - (CAST(total_amount_refunded AS DOUBLE)))
      comment: "Net revenue from voluntary changes after refunds"
    - name: "avg_change_fee"
      expr: AVG(CAST(change_fee_amount AS DOUBLE))
      comment: "Average change fee per transaction"
    - name: "avg_fare_difference"
      expr: AVG(CAST(fare_difference_amount AS DOUBLE))
      comment: "Average fare difference per change"
    - name: "approved_changes"
      expr: COUNT(DISTINCT CASE WHEN change_status = 'approved' THEN voluntary_change_id END)
      comment: "Number of approved change requests"
    - name: "processed_changes"
      expr: COUNT(DISTINCT CASE WHEN change_status = 'processed' THEN voluntary_change_id END)
      comment: "Number of processed changes"
    - name: "rejected_changes"
      expr: COUNT(DISTINCT CASE WHEN change_status = 'rejected' THEN voluntary_change_id END)
      comment: "Number of rejected change requests"
    - name: "waived_fee_changes"
      expr: COUNT(DISTINCT CASE WHEN change_fee_waiver_code IS NOT NULL THEN voluntary_change_id END)
      comment: "Number of changes with waived fees"
    - name: "unique_pnrs_changed"
      expr: COUNT(DISTINCT pnr_id)
      comment: "Number of unique PNRs with voluntary changes"
$$;


CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`reservation_fare_quote`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fare quoting and pricing metrics tracking quote volume, pricing accuracy, conversion, and fare family performance"
  source: "`airlines_ecm`.`reservation`.`fare_quote`"
  dimensions:
    - name: "pricing_date"
      expr: pricing_date
      comment: "Date the fare was priced"
    - name: "pricing_month"
      expr: DATE_TRUNC('month', CAST(pricing_date AS TIMESTAMP))
      comment: "Month the fare was priced"
    - name: "quote_status"
      expr: fare_quote_status
      comment: "Status of fare quote (active, expired, booked, cancelled, etc.)"
    - name: "fare_type"
      expr: fare_type
      comment: "Type of fare (published, private, negotiated, promotional, etc.)"
    - name: "passenger_type"
      expr: passenger_type_code
      comment: "Passenger type code (adult, child, infant, senior, etc.)"
    - name: "pricing_source"
      expr: pricing_source
      comment: "Source system or engine that generated the quote"
    - name: "gds"
      expr: gds_code
      comment: "GDS code if quote was generated through GDS"
    - name: "currency"
      expr: currency_code
      comment: "Currency of the fare quote"
    - name: "validating_carrier"
      expr: validating_carrier_code
      comment: "Validating carrier code"
    - name: "plating_carrier"
      expr: plating_carrier_code
      comment: "Plating carrier code"
    - name: "is_private_fare"
      expr: CASE WHEN private_fare_indicator = TRUE THEN 'Yes' ELSE 'No' END
      comment: "Whether quote is for a private fare"
    - name: "is_repricing"
      expr: CASE WHEN repricing_indicator = TRUE THEN 'Yes' ELSE 'No' END
      comment: "Whether quote is a repricing of an existing fare"
    - name: "has_promotional_code"
      expr: CASE WHEN promotional_code IS NOT NULL THEN 'Yes' ELSE 'No' END
      comment: "Whether promotional code was applied"
    - name: "has_corporate_account"
      expr: CASE WHEN corporate_account_code IS NOT NULL THEN 'Yes' ELSE 'No' END
      comment: "Whether corporate account discount was applied"
    - name: "has_tour_code"
      expr: CASE WHEN tour_code IS NOT NULL THEN 'Yes' ELSE 'No' END
      comment: "Whether tour code was applied"
  measures:
    - name: "total_fare_quotes"
      expr: COUNT(DISTINCT fare_quote_id)
      comment: "Total number of fare quotes generated"
    - name: "total_base_fare_quoted"
      expr: SUM(CAST(base_fare_amount AS DOUBLE))
      comment: "Total base fare amount quoted"
    - name: "total_tax_quoted"
      expr: SUM(CAST(total_tax_amount AS DOUBLE))
      comment: "Total tax amount quoted"
    - name: "total_surcharge_quoted"
      expr: SUM(CAST(total_surcharge_amount AS DOUBLE))
      comment: "Total surcharge amount quoted"
    - name: "total_fare_quoted"
      expr: SUM(CAST(total_fare_amount AS DOUBLE))
      comment: "Total fare amount quoted including all components"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount applied to quotes"
    - name: "total_commission_amount"
      expr: SUM(CAST(commission_amount AS DOUBLE))
      comment: "Total commission amount on quotes"
    - name: "avg_base_fare_per_quote"
      expr: AVG(CAST(base_fare_amount AS DOUBLE))
      comment: "Average base fare per quote"
    - name: "avg_total_fare_per_quote"
      expr: AVG(CAST(total_fare_amount AS DOUBLE))
      comment: "Average total fare per quote"
    - name: "avg_commission_rate"
      expr: AVG(CAST(commission_rate AS DOUBLE))
      comment: "Average commission rate across quotes"
    - name: "private_fare_quotes"
      expr: COUNT(DISTINCT CASE WHEN private_fare_indicator = TRUE THEN fare_quote_id END)
      comment: "Number of private fare quotes"
    - name: "promotional_quotes"
      expr: COUNT(DISTINCT CASE WHEN promotional_code IS NOT NULL THEN fare_quote_id END)
      comment: "Number of quotes with promotional codes"
    - name: "corporate_quotes"
      expr: COUNT(DISTINCT CASE WHEN corporate_account_code IS NOT NULL THEN fare_quote_id END)
      comment: "Number of quotes with corporate account discounts"
    - name: "unique_pnrs_quoted"
      expr: COUNT(DISTINCT pnr_id)
      comment: "Number of unique PNRs with fare quotes"
$$;
