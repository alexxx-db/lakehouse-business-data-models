-- Metric views for domain: loyalty | Business: Airlines | Version: 1 | Generated on: 2026-05-07 12:57:28

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`loyalty_award_booking`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Award Booking business metrics"
  source: "`airlines_ecm`.`loyalty`.`award_booking`"
  dimensions:
    - name: "Award Pnr"
      expr: award_pnr
    - name: "Award Type"
      expr: award_type
    - name: "Booking Channel"
      expr: booking_channel
    - name: "Booking Status"
      expr: booking_status
    - name: "Booking Timestamp"
      expr: booking_timestamp
    - name: "Cancellation Reason"
      expr: cancellation_reason
    - name: "Cancellation Timestamp"
      expr: cancellation_timestamp
    - name: "Copay Currency Code"
      expr: copay_currency_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Departure Date"
      expr: departure_date
    - name: "Destination Airport Code"
      expr: destination_airport_code
    - name: "Is Partner Award"
      expr: is_partner_award
    - name: "Is Round Trip"
      expr: is_round_trip
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Marketing Carrier Code"
      expr: marketing_carrier_code
    - name: "Number Of Passengers"
      expr: number_of_passengers
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Award Booking"
      expr: COUNT(DISTINCT award_booking_id)
    - name: "Total Copay Amount"
      expr: SUM(copay_amount)
    - name: "Average Copay Amount"
      expr: AVG(copay_amount)
    - name: "Total Refund Fee Miles"
      expr: SUM(refund_fee_miles)
    - name: "Average Refund Fee Miles"
      expr: AVG(refund_fee_miles)
    - name: "Total Refund Miles Amount"
      expr: SUM(refund_miles_amount)
    - name: "Average Refund Miles Amount"
      expr: AVG(refund_miles_amount)
    - name: "Total Total Miles Redeemed"
      expr: SUM(total_miles_redeemed)
    - name: "Average Total Miles Redeemed"
      expr: AVG(total_miles_redeemed)
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`loyalty_award_inventory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Award Inventory business metrics"
  source: "`airlines_ecm`.`loyalty`.`award_inventory`"
  dimensions:
    - name: "Allocation Effective Date"
      expr: allocation_effective_date
    - name: "Allocation Expiry Date"
      expr: allocation_expiry_date
    - name: "Allocation Notes"
      expr: allocation_notes
    - name: "Allocation Source"
      expr: allocation_source
    - name: "Award Bucket Code"
      expr: award_bucket_code
    - name: "Award Bucket Type"
      expr: award_bucket_type
    - name: "Blackout Date Flag"
      expr: blackout_date_flag
    - name: "Booking Window Close Days"
      expr: booking_window_close_days
    - name: "Booking Window Open Days"
      expr: booking_window_open_days
    - name: "Cancellation Fee Waived Flag"
      expr: cancellation_fee_waived_flag
    - name: "Change Fee Waived Flag"
      expr: change_fee_waived_flag
    - name: "Co Pay Currency Code"
      expr: co_pay_currency_code
    - name: "Dynamic Pricing Enabled Flag"
      expr: dynamic_pricing_enabled_flag
    - name: "Elite Only Flag"
      expr: elite_only_flag
    - name: "Flight Number"
      expr: flight_number
    - name: "Inventory Status"
      expr: inventory_status
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Award Inventory"
      expr: COUNT(DISTINCT award_inventory_id)
    - name: "Total Co Pay Amount"
      expr: SUM(co_pay_amount)
    - name: "Average Co Pay Amount"
      expr: AVG(co_pay_amount)
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`loyalty_coalition_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Coalition Program business metrics"
  source: "`airlines_ecm`.`loyalty`.`coalition_program`"
  dimensions:
    - name: "Api Authentication Method"
      expr: api_authentication_method
    - name: "Api Endpoint Url"
      expr: api_endpoint_url
    - name: "Auto Renewal Flag"
      expr: auto_renewal_flag
    - name: "Burn Rules Summary"
      expr: burn_rules_summary
    - name: "Coalition Operator Country Code"
      expr: coalition_operator_country_code
    - name: "Coalition Operator Name"
      expr: coalition_operator_name
    - name: "Contact Email"
      expr: contact_email
    - name: "Contact Person Name"
      expr: contact_person_name
    - name: "Contact Phone"
      expr: contact_phone
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Sharing Agreement Reference"
      expr: data_sharing_agreement_reference
    - name: "Earn Rules Summary"
      expr: earn_rules_summary
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Gdpr Compliant Flag"
      expr: gdpr_compliant_flag
    - name: "Governance Model"
      expr: governance_model
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Coalition Program"
      expr: COUNT(DISTINCT coalition_program_id)
    - name: "Total Burn Settlement Rate"
      expr: SUM(burn_settlement_rate)
    - name: "Average Burn Settlement Rate"
      expr: AVG(burn_settlement_rate)
    - name: "Total Conversion Rate To Airline Miles"
      expr: SUM(conversion_rate_to_airline_miles)
    - name: "Average Conversion Rate To Airline Miles"
      expr: AVG(conversion_rate_to_airline_miles)
    - name: "Total Earn Settlement Rate"
      expr: SUM(earn_settlement_rate)
    - name: "Average Earn Settlement Rate"
      expr: AVG(earn_settlement_rate)
    - name: "Total Minimum Commitment Amount"
      expr: SUM(minimum_commitment_amount)
    - name: "Average Minimum Commitment Amount"
      expr: AVG(minimum_commitment_amount)
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`loyalty_ffp_member`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ffp Member business metrics"
  source: "`airlines_ecm`.`loyalty`.`ffp_member`"
  dimensions:
    - name: "Address Line 1"
      expr: address_line_1
    - name: "Address Line 2"
      expr: address_line_2
    - name: "City"
      expr: city
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Date Of Birth"
      expr: date_of_birth
    - name: "Email Address"
      expr: email_address
    - name: "Email Consent Flag"
      expr: email_consent_flag
    - name: "Enrollment Channel"
      expr: enrollment_channel
    - name: "Enrollment Date"
      expr: enrollment_date
    - name: "Ffp Number"
      expr: ffp_number
    - name: "Gender"
      expr: gender
    - name: "Home Airport Code"
      expr: home_airport_code
    - name: "Last Activity Date"
      expr: last_activity_date
    - name: "Lifetime Status Flag"
      expr: lifetime_status_flag
    - name: "Marketing Consent Flag"
      expr: marketing_consent_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Ffp Member"
      expr: COUNT(DISTINCT ffp_member_id)
    - name: "Total Current Miles Balance"
      expr: SUM(current_miles_balance)
    - name: "Average Current Miles Balance"
      expr: AVG(current_miles_balance)
    - name: "Total Lifetime Miles Balance"
      expr: SUM(lifetime_miles_balance)
    - name: "Average Lifetime Miles Balance"
      expr: AVG(lifetime_miles_balance)
    - name: "Total Tier Qualifying Miles"
      expr: SUM(tier_qualifying_miles)
    - name: "Average Tier Qualifying Miles"
      expr: AVG(tier_qualifying_miles)
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`loyalty_lifetime_status`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lifetime Status business metrics"
  source: "`airlines_ecm`.`loyalty`.`lifetime_status`"
  dimensions:
    - name: "Approval Timestamp"
      expr: approval_timestamp
    - name: "Benefits Override Flag"
      expr: benefits_override_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "External Reference Code"
      expr: external_reference_code
    - name: "Extra Baggage Allowance Kg"
      expr: extra_baggage_allowance_kg
    - name: "Grant Date"
      expr: grant_date
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Lifetime Segments Flown"
      expr: lifetime_segments_flown
    - name: "Lifetime Spend Currency"
      expr: lifetime_spend_currency
    - name: "Lifetime Status Code"
      expr: lifetime_status_code
    - name: "Lifetime Status Level"
      expr: lifetime_status_level
    - name: "Lifetime Status Status"
      expr: lifetime_status_status
    - name: "Lounge Access Lifetime Flag"
      expr: lounge_access_lifetime_flag
    - name: "Notes"
      expr: notes
    - name: "Partner Tier Equivalent Code"
      expr: partner_tier_equivalent_code
    - name: "Priority Boarding Lifetime Flag"
      expr: priority_boarding_lifetime_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Lifetime Status"
      expr: COUNT(DISTINCT lifetime_status_id)
    - name: "Total Bonus Mile Multiplier Lifetime"
      expr: SUM(bonus_mile_multiplier_lifetime)
    - name: "Average Bonus Mile Multiplier Lifetime"
      expr: AVG(bonus_mile_multiplier_lifetime)
    - name: "Total Lifetime Miles Earned"
      expr: SUM(lifetime_miles_earned)
    - name: "Average Lifetime Miles Earned"
      expr: AVG(lifetime_miles_earned)
    - name: "Total Lifetime Spend Amount"
      expr: SUM(lifetime_spend_amount)
    - name: "Average Lifetime Spend Amount"
      expr: AVG(lifetime_spend_amount)
    - name: "Total Threshold Miles Required"
      expr: SUM(threshold_miles_required)
    - name: "Average Threshold Miles Required"
      expr: AVG(threshold_miles_required)
    - name: "Total Threshold Spend Required"
      expr: SUM(threshold_spend_required)
    - name: "Average Threshold Spend Required"
      expr: AVG(threshold_spend_required)
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`loyalty_loyalty_promotion`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Loyalty Promotion business metrics"
  source: "`airlines_ecm`.`loyalty`.`loyalty_promotion`"
  dimensions:
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved By"
      expr: approved_by
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Bonus Miles Formula"
      expr: bonus_miles_formula
    - name: "Communication Channel"
      expr: communication_channel
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Eligible Member Tiers"
      expr: eligible_member_tiers
    - name: "Eligible Partners"
      expr: eligible_partners
    - name: "End Date"
      expr: end_date
    - name: "External Promotion Code"
      expr: external_promotion_code
    - name: "Last Modified By"
      expr: last_modified_by
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Maximum Bonus Cap"
      expr: maximum_bonus_cap
    - name: "Opt In Count"
      expr: opt_in_count
    - name: "Opt In Required Flag"
      expr: opt_in_required_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Loyalty Promotion"
      expr: COUNT(DISTINCT loyalty_promotion_id)
    - name: "Total Actual Cost"
      expr: SUM(actual_cost)
    - name: "Average Actual Cost"
      expr: AVG(actual_cost)
    - name: "Total Estimated Cost"
      expr: SUM(estimated_cost)
    - name: "Average Estimated Cost"
      expr: AVG(estimated_cost)
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`loyalty_loyalty_promotion_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Loyalty Promotion Enrollment business metrics"
  source: "`airlines_ecm`.`loyalty`.`loyalty_promotion_enrollment`"
  dimensions:
    - name: "Auto Enrolled Flag"
      expr: auto_enrolled_flag
    - name: "Bonus Posting Date"
      expr: bonus_posting_date
    - name: "Bonus Posting Status"
      expr: bonus_posting_status
    - name: "Cancellation Date"
      expr: cancellation_date
    - name: "Cancellation Reason"
      expr: cancellation_reason
    - name: "Completion Date"
      expr: completion_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Enrollment Channel"
      expr: enrollment_channel
    - name: "Enrollment Date"
      expr: enrollment_date
    - name: "Enrollment Number"
      expr: enrollment_number
    - name: "Enrollment Source Campaign"
      expr: enrollment_source_campaign
    - name: "Enrollment Status"
      expr: enrollment_status
    - name: "Enrollment Timestamp"
      expr: enrollment_timestamp
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Notification Sent Flag"
      expr: notification_sent_flag
    - name: "Notification Sent Timestamp"
      expr: notification_sent_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Loyalty Promotion Enrollment"
      expr: COUNT(DISTINCT loyalty_promotion_enrollment_id)
    - name: "Total Bonus Miles Earned"
      expr: SUM(bonus_miles_earned)
    - name: "Average Bonus Miles Earned"
      expr: AVG(bonus_miles_earned)
    - name: "Total Qualification Current Value"
      expr: SUM(qualification_current_value)
    - name: "Average Qualification Current Value"
      expr: AVG(qualification_current_value)
    - name: "Total Qualification Percentage"
      expr: SUM(qualification_percentage)
    - name: "Average Qualification Percentage"
      expr: AVG(qualification_percentage)
    - name: "Total Qualification Target Value"
      expr: SUM(qualification_target_value)
    - name: "Average Qualification Target Value"
      expr: AVG(qualification_target_value)
    - name: "Total Tier Bonus Multiplier"
      expr: SUM(tier_bonus_multiplier)
    - name: "Average Tier Bonus Multiplier"
      expr: AVG(tier_bonus_multiplier)
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`loyalty_member_audit_sample`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Member Audit Sample business metrics"
  source: "`airlines_ecm`.`loyalty`.`member_audit_sample`"
  dimensions:
    - name: "Documentation Provided"
      expr: documentation_provided
    - name: "Examination Status"
      expr: examination_status
    - name: "Finding Count"
      expr: finding_count
    - name: "Interview Date"
      expr: interview_date
    - name: "Interview Notes"
      expr: interview_notes
    - name: "Risk Category"
      expr: risk_category
    - name: "Sample Selection Date"
      expr: sample_selection_date
    - name: "Sample Selection Flag"
      expr: sample_selection_flag
    - name: "Interview Date Month"
      expr: DATE_TRUNC('MONTH', interview_date)
    - name: "Sample Selection Date Month"
      expr: DATE_TRUNC('MONTH', sample_selection_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Member Audit Sample"
      expr: COUNT(DISTINCT member_audit_sample_id)
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`loyalty_member_benefit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Member Benefit business metrics"
  source: "`airlines_ecm`.`loyalty`.`member_benefit`"
  dimensions:
    - name: "Activation Trigger"
      expr: activation_trigger
    - name: "Auto Renew Flag"
      expr: auto_renew_flag
    - name: "Benefit Code"
      expr: benefit_code
    - name: "Benefit Description"
      expr: benefit_description
    - name: "Benefit Name"
      expr: benefit_name
    - name: "Benefit Quantity"
      expr: benefit_quantity
    - name: "Benefit Status"
      expr: benefit_status
    - name: "Benefit Terms"
      expr: benefit_terms
    - name: "Benefit Type"
      expr: benefit_type
    - name: "Benefit Unit"
      expr: benefit_unit
    - name: "Benefit Validity End Date"
      expr: benefit_validity_end_date
    - name: "Benefit Validity Start Date"
      expr: benefit_validity_start_date
    - name: "Blackout Dates"
      expr: blackout_dates
    - name: "Cabin Class Restriction"
      expr: cabin_class_restriction
    - name: "Cost Currency"
      expr: cost_currency
    - name: "Created Timestamp"
      expr: created_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Member Benefit"
      expr: COUNT(DISTINCT member_benefit_id)
    - name: "Total Cost To Airline"
      expr: SUM(cost_to_airline)
    - name: "Average Cost To Airline"
      expr: AVG(cost_to_airline)
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`loyalty_mileage_accrual`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Mileage Accrual business metrics"
  source: "`airlines_ecm`.`loyalty`.`mileage_accrual`"
  dimensions:
    - name: "Accrual Date"
      expr: accrual_date
    - name: "Accrual Source Type"
      expr: accrual_source_type
    - name: "Accrual Status"
      expr: accrual_status
    - name: "Adjustment Notes"
      expr: adjustment_notes
    - name: "Adjustment Reason Code"
      expr: adjustment_reason_code
    - name: "Approval Reference"
      expr: approval_reference
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Fare Class"
      expr: fare_class
    - name: "Flight Date"
      expr: flight_date
    - name: "Flight Number"
      expr: flight_number
    - name: "Marketing Carrier Code"
      expr: marketing_carrier_code
    - name: "Miles Expiry Date"
      expr: miles_expiry_date
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Operating Carrier Code"
      expr: operating_carrier_code
    - name: "Partner Transaction Reference"
      expr: partner_transaction_reference
    - name: "Pnr"
      expr: pnr
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Mileage Accrual"
      expr: COUNT(DISTINCT mileage_accrual_id)
    - name: "Total Base Miles"
      expr: SUM(base_miles)
    - name: "Average Base Miles"
      expr: AVG(base_miles)
    - name: "Total Elite Bonus Miles"
      expr: SUM(elite_bonus_miles)
    - name: "Average Elite Bonus Miles"
      expr: AVG(elite_bonus_miles)
    - name: "Total Elite Bonus Multiplier"
      expr: SUM(elite_bonus_multiplier)
    - name: "Average Elite Bonus Multiplier"
      expr: AVG(elite_bonus_multiplier)
    - name: "Total Promotional Bonus Miles"
      expr: SUM(promotional_bonus_miles)
    - name: "Average Promotional Bonus Miles"
      expr: AVG(promotional_bonus_miles)
    - name: "Total Total Miles Credited"
      expr: SUM(total_miles_credited)
    - name: "Average Total Miles Credited"
      expr: AVG(total_miles_credited)
    - name: "Total Transaction Amount"
      expr: SUM(transaction_amount)
    - name: "Average Transaction Amount"
      expr: AVG(transaction_amount)
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`loyalty_mileage_redemption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Mileage Redemption business metrics"
  source: "`airlines_ecm`.`loyalty`.`mileage_redemption`"
  dimensions:
    - name: "Award Booking Reference"
      expr: award_booking_reference
    - name: "Cancellation Reason"
      expr: cancellation_reason
    - name: "Co Pay Currency Code"
      expr: co_pay_currency_code
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Partner Transaction Reference"
      expr: partner_transaction_reference
    - name: "Processing Fee Currency Code"
      expr: processing_fee_currency_code
    - name: "Promotion Code"
      expr: promotion_code
    - name: "Record Created Timestamp"
      expr: record_created_timestamp
    - name: "Record Updated Timestamp"
      expr: record_updated_timestamp
    - name: "Redemption Channel"
      expr: redemption_channel
    - name: "Redemption Notes"
      expr: redemption_notes
    - name: "Redemption Status"
      expr: redemption_status
    - name: "Redemption Timestamp"
      expr: redemption_timestamp
    - name: "Redemption Transaction Number"
      expr: redemption_transaction_number
    - name: "Redemption Type"
      expr: redemption_type
    - name: "Refund Timestamp"
      expr: refund_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Mileage Redemption"
      expr: COUNT(DISTINCT mileage_redemption_id)
    - name: "Total Co Pay Amount"
      expr: SUM(co_pay_amount)
    - name: "Average Co Pay Amount"
      expr: AVG(co_pay_amount)
    - name: "Total Miles Discount Applied"
      expr: SUM(miles_discount_applied)
    - name: "Average Miles Discount Applied"
      expr: AVG(miles_discount_applied)
    - name: "Total Miles Redeemed"
      expr: SUM(miles_redeemed)
    - name: "Average Miles Redeemed"
      expr: AVG(miles_redeemed)
    - name: "Total Processing Fee Amount"
      expr: SUM(processing_fee_amount)
    - name: "Average Processing Fee Amount"
      expr: AVG(processing_fee_amount)
    - name: "Total Refund Miles"
      expr: SUM(refund_miles)
    - name: "Average Refund Miles"
      expr: AVG(refund_miles)
    - name: "Total Transfer Fee Amount"
      expr: SUM(transfer_fee_amount)
    - name: "Average Transfer Fee Amount"
      expr: AVG(transfer_fee_amount)
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`loyalty_miles_adjustment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Miles Adjustment business metrics"
  source: "`airlines_ecm`.`loyalty`.`miles_adjustment`"
  dimensions:
    - name: "Adjustment Channel"
      expr: adjustment_channel
    - name: "Adjustment Reason Code"
      expr: adjustment_reason_code
    - name: "Adjustment Reason Description"
      expr: adjustment_reason_description
    - name: "Adjustment Status"
      expr: adjustment_status
    - name: "Adjustment Timestamp"
      expr: adjustment_timestamp
    - name: "Adjustment Transaction Number"
      expr: adjustment_transaction_number
    - name: "Adjustment Type"
      expr: adjustment_type
    - name: "Approval Level"
      expr: approval_level
    - name: "Approval Reference"
      expr: approval_reference
    - name: "Audit Notes"
      expr: audit_notes
    - name: "Compliance Flag"
      expr: compliance_flag
    - name: "Cost Centre Code"
      expr: cost_centre_code
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiration Date"
      expr: expiration_date
    - name: "External Reference Code"
      expr: external_reference_code
    - name: "Financial Impact Currency"
      expr: financial_impact_currency
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Miles Adjustment"
      expr: COUNT(DISTINCT miles_adjustment_id)
    - name: "Total Financial Impact Amount"
      expr: SUM(financial_impact_amount)
    - name: "Average Financial Impact Amount"
      expr: AVG(financial_impact_amount)
    - name: "Total Miles Amount"
      expr: SUM(miles_amount)
    - name: "Average Miles Amount"
      expr: AVG(miles_amount)
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`loyalty_miles_balance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Miles Balance business metrics"
  source: "`airlines_ecm`.`loyalty`.`miles_balance`"
  dimensions:
    - name: "Account Inception Date"
      expr: account_inception_date
    - name: "Balance As Of Timestamp"
      expr: balance_as_of_timestamp
    - name: "Balance Calculation Method"
      expr: balance_calculation_method
    - name: "Balance Last Updated Timestamp"
      expr: balance_last_updated_timestamp
    - name: "Balance Status"
      expr: balance_status
    - name: "Balance Version Number"
      expr: balance_version_number
    - name: "Is Lifetime Status Qualified"
      expr: is_lifetime_status_qualified
    - name: "Last Accrual Date"
      expr: last_accrual_date
    - name: "Last Redemption Date"
      expr: last_redemption_date
    - name: "Last Transaction Date"
      expr: last_transaction_date
    - name: "Member Number"
      expr: member_number
    - name: "Next Expiration Date"
      expr: next_expiration_date
    - name: "Qualification Year End Date"
      expr: qualification_year_end_date
    - name: "Qualification Year Start Date"
      expr: qualification_year_start_date
    - name: "Qualifying Segments Ytd"
      expr: qualifying_segments_ytd
    - name: "Qualifying Spend Currency"
      expr: qualifying_spend_currency
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Miles Balance"
      expr: COUNT(DISTINCT miles_balance_id)
    - name: "Total Bonus Miles Balance"
      expr: SUM(bonus_miles_balance)
    - name: "Average Bonus Miles Balance"
      expr: AVG(bonus_miles_balance)
    - name: "Total Elite Bonus Miles Ytd"
      expr: SUM(elite_bonus_miles_ytd)
    - name: "Average Elite Bonus Miles Ytd"
      expr: AVG(elite_bonus_miles_ytd)
    - name: "Total Lifetime Miles Earned"
      expr: SUM(lifetime_miles_earned)
    - name: "Average Lifetime Miles Earned"
      expr: AVG(lifetime_miles_earned)
    - name: "Total Lifetime Miles Redeemed"
      expr: SUM(lifetime_miles_redeemed)
    - name: "Average Lifetime Miles Redeemed"
      expr: AVG(lifetime_miles_redeemed)
    - name: "Total Miles Expiring 180 Days"
      expr: SUM(miles_expiring_180_days)
    - name: "Average Miles Expiring 180 Days"
      expr: AVG(miles_expiring_180_days)
    - name: "Total Miles Expiring 90 Days"
      expr: SUM(miles_expiring_90_days)
    - name: "Average Miles Expiring 90 Days"
      expr: AVG(miles_expiring_90_days)
    - name: "Total On Hold Miles"
      expr: SUM(on_hold_miles)
    - name: "Average On Hold Miles"
      expr: AVG(on_hold_miles)
    - name: "Total Partner Miles Balance"
      expr: SUM(partner_miles_balance)
    - name: "Average Partner Miles Balance"
      expr: AVG(partner_miles_balance)
    - name: "Total Pending Miles"
      expr: SUM(pending_miles)
    - name: "Average Pending Miles"
      expr: AVG(pending_miles)
    - name: "Total Qualifying Miles Ytd"
      expr: SUM(qualifying_miles_ytd)
    - name: "Average Qualifying Miles Ytd"
      expr: AVG(qualifying_miles_ytd)
    - name: "Total Qualifying Spend Ytd"
      expr: SUM(qualifying_spend_ytd)
    - name: "Average Qualifying Spend Ytd"
      expr: AVG(qualifying_spend_ytd)
    - name: "Total Redeemable Miles"
      expr: SUM(redeemable_miles)
    - name: "Average Redeemable Miles"
      expr: AVG(redeemable_miles)
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`loyalty_miles_purchase`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Miles Purchase business metrics"
  source: "`airlines_ecm`.`loyalty`.`miles_purchase`"
  dimensions:
    - name: "Bonus Miles Quantity"
      expr: bonus_miles_quantity
    - name: "Cancellation Reason"
      expr: cancellation_reason
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Device Type"
      expr: device_type
    - name: "External Transaction Code"
      expr: external_transaction_code
    - name: "Ffp Number"
      expr: ffp_number
    - name: "Fraud Check Status"
      expr: fraud_check_status
    - name: "Ip Address"
      expr: ip_address
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "Miles Expiration Date"
      expr: miles_expiration_date
    - name: "Miles Quantity"
      expr: miles_quantity
    - name: "Notes"
      expr: notes
    - name: "Payment Authorization Code"
      expr: payment_authorization_code
    - name: "Payment Method"
      expr: payment_method
    - name: "Payment Reference"
      expr: payment_reference
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Miles Purchase"
      expr: COUNT(DISTINCT miles_purchase_id)
    - name: "Total Base Amount"
      expr: SUM(base_amount)
    - name: "Average Base Amount"
      expr: AVG(base_amount)
    - name: "Total Discount Amount"
      expr: SUM(discount_amount)
    - name: "Average Discount Amount"
      expr: AVG(discount_amount)
    - name: "Total Fraud Score"
      expr: SUM(fraud_score)
    - name: "Average Fraud Score"
      expr: AVG(fraud_score)
    - name: "Total Price Per Mile"
      expr: SUM(price_per_mile)
    - name: "Average Price Per Mile"
      expr: AVG(price_per_mile)
    - name: "Total Processing Fee Amount"
      expr: SUM(processing_fee_amount)
    - name: "Average Processing Fee Amount"
      expr: AVG(processing_fee_amount)
    - name: "Total Refund Amount"
      expr: SUM(refund_amount)
    - name: "Average Refund Amount"
      expr: AVG(refund_amount)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
    - name: "Total Total Amount Charged"
      expr: SUM(total_amount_charged)
    - name: "Average Total Amount Charged"
      expr: AVG(total_amount_charged)
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`loyalty_miles_transfer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Miles Transfer business metrics"
  source: "`airlines_ecm`.`loyalty`.`miles_transfer`"
  dimensions:
    - name: "Approval Required Flag"
      expr: approval_required_flag
    - name: "Approval Timestamp"
      expr: approval_timestamp
    - name: "Cancellation Reason"
      expr: cancellation_reason
    - name: "Completion Timestamp"
      expr: completion_timestamp
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Fraud Review Flag"
      expr: fraud_review_flag
    - name: "Payment Method"
      expr: payment_method
    - name: "Payment Reference Number"
      expr: payment_reference_number
    - name: "Promotion Code"
      expr: promotion_code
    - name: "Record Created Timestamp"
      expr: record_created_timestamp
    - name: "Record Updated Timestamp"
      expr: record_updated_timestamp
    - name: "Rejection Reason"
      expr: rejection_reason
    - name: "Relationship Type"
      expr: relationship_type
    - name: "Relationship Verified Flag"
      expr: relationship_verified_flag
    - name: "Reversal Reason"
      expr: reversal_reason
    - name: "Reversal Timestamp"
      expr: reversal_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Miles Transfer"
      expr: COUNT(DISTINCT miles_transfer_id)
    - name: "Total Bonus Miles Awarded"
      expr: SUM(bonus_miles_awarded)
    - name: "Average Bonus Miles Awarded"
      expr: AVG(bonus_miles_awarded)
    - name: "Total Fee Discount Applied"
      expr: SUM(fee_discount_applied)
    - name: "Average Fee Discount Applied"
      expr: AVG(fee_discount_applied)
    - name: "Total Fraud Risk Score"
      expr: SUM(fraud_risk_score)
    - name: "Average Fraud Risk Score"
      expr: AVG(fraud_risk_score)
    - name: "Total Miles Transferred"
      expr: SUM(miles_transferred)
    - name: "Average Miles Transferred"
      expr: AVG(miles_transferred)
    - name: "Total Recipient Annual Receipt Consumed"
      expr: SUM(recipient_annual_receipt_consumed)
    - name: "Average Recipient Annual Receipt Consumed"
      expr: AVG(recipient_annual_receipt_consumed)
    - name: "Total Recipient Annual Receipt Limit"
      expr: SUM(recipient_annual_receipt_limit)
    - name: "Average Recipient Annual Receipt Limit"
      expr: AVG(recipient_annual_receipt_limit)
    - name: "Total Sender Annual Transfer Consumed"
      expr: SUM(sender_annual_transfer_consumed)
    - name: "Average Sender Annual Transfer Consumed"
      expr: AVG(sender_annual_transfer_consumed)
    - name: "Total Sender Annual Transfer Limit"
      expr: SUM(sender_annual_transfer_limit)
    - name: "Average Sender Annual Transfer Limit"
      expr: AVG(sender_annual_transfer_limit)
    - name: "Total Transfer Fee Amount"
      expr: SUM(transfer_fee_amount)
    - name: "Average Transfer Fee Amount"
      expr: AVG(transfer_fee_amount)
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`loyalty_partner_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Partner Program business metrics"
  source: "`airlines_ecm`.`loyalty`.`partner_program`"
  dimensions:
    - name: "Accrual Delay Days"
      expr: accrual_delay_days
    - name: "Agreement Effective Date"
      expr: agreement_effective_date
    - name: "Agreement Expiry Date"
      expr: agreement_expiry_date
    - name: "Agreement Status"
      expr: agreement_status
    - name: "Auto Enrollment Flag"
      expr: auto_enrollment_flag
    - name: "Bonus Mile Eligibility Flag"
      expr: bonus_mile_eligibility_flag
    - name: "Burn Unit"
      expr: burn_unit
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Earn Unit"
      expr: earn_unit
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Partner Contact Email"
      expr: partner_contact_email
    - name: "Partner Contact Name"
      expr: partner_contact_name
    - name: "Partner Contact Phone"
      expr: partner_contact_phone
    - name: "Partner Country Code"
      expr: partner_country_code
    - name: "Partner Iata Code"
      expr: partner_iata_code
    - name: "Partner Icao Code"
      expr: partner_icao_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Partner Program"
      expr: COUNT(DISTINCT partner_program_id)
    - name: "Total Burn Rate"
      expr: SUM(burn_rate)
    - name: "Average Burn Rate"
      expr: AVG(burn_rate)
    - name: "Total Earn Rate"
      expr: SUM(earn_rate)
    - name: "Average Earn Rate"
      expr: AVG(earn_rate)
    - name: "Total Maximum Earn Per Transaction"
      expr: SUM(maximum_earn_per_transaction)
    - name: "Average Maximum Earn Per Transaction"
      expr: AVG(maximum_earn_per_transaction)
    - name: "Total Minimum Transaction Amount"
      expr: SUM(minimum_transaction_amount)
    - name: "Average Minimum Transaction Amount"
      expr: AVG(minimum_transaction_amount)
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`loyalty_partner_settlement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Partner Settlement business metrics"
  source: "`airlines_ecm`.`loyalty`.`partner_settlement`"
  dimensions:
    - name: "Approval Required Flag"
      expr: approval_required_flag
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Invoice Reference Number"
      expr: invoice_reference_number
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Partner Statement Reference"
      expr: partner_statement_reference
    - name: "Payment Due Date"
      expr: payment_due_date
    - name: "Payment Received Date"
      expr: payment_received_date
    - name: "Payment Status"
      expr: payment_status
    - name: "Reconciliation Status"
      expr: reconciliation_status
    - name: "Settlement Currency Code"
      expr: settlement_currency_code
    - name: "Settlement Date"
      expr: settlement_date
    - name: "Settlement Frequency"
      expr: settlement_frequency
    - name: "Settlement Notes"
      expr: settlement_notes
    - name: "Settlement Period End Date"
      expr: settlement_period_end_date
    - name: "Settlement Period Start Date"
      expr: settlement_period_start_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Partner Settlement"
      expr: COUNT(DISTINCT partner_settlement_id)
    - name: "Total Adjustment Amount"
      expr: SUM(adjustment_amount)
    - name: "Average Adjustment Amount"
      expr: AVG(adjustment_amount)
    - name: "Total Exchange Rate"
      expr: SUM(exchange_rate)
    - name: "Average Exchange Rate"
      expr: AVG(exchange_rate)
    - name: "Total Miles Redeemed Amount"
      expr: SUM(miles_redeemed_amount)
    - name: "Average Miles Redeemed Amount"
      expr: AVG(miles_redeemed_amount)
    - name: "Total Miles Redeemed Via Partner"
      expr: SUM(miles_redeemed_via_partner)
    - name: "Average Miles Redeemed Via Partner"
      expr: AVG(miles_redeemed_via_partner)
    - name: "Total Miles Sold Amount"
      expr: SUM(miles_sold_amount)
    - name: "Average Miles Sold Amount"
      expr: AVG(miles_sold_amount)
    - name: "Total Miles Sold To Partner"
      expr: SUM(miles_sold_to_partner)
    - name: "Average Miles Sold To Partner"
      expr: AVG(miles_sold_to_partner)
    - name: "Total Net Miles Position"
      expr: SUM(net_miles_position)
    - name: "Average Net Miles Position"
      expr: AVG(net_miles_position)
    - name: "Total Settlement Amount"
      expr: SUM(settlement_amount)
    - name: "Average Settlement Amount"
      expr: AVG(settlement_amount)
    - name: "Total Variance Amount"
      expr: SUM(variance_amount)
    - name: "Average Variance Amount"
      expr: AVG(variance_amount)
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`loyalty_partner_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Partner Transaction business metrics"
  source: "`airlines_ecm`.`loyalty`.`partner_transaction`"
  dimensions:
    - name: "Base Miles Awarded"
      expr: base_miles_awarded
    - name: "Bonus Miles Awarded"
      expr: bonus_miles_awarded
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Dispute Flag"
      expr: dispute_flag
    - name: "Dispute Reason"
      expr: dispute_reason
    - name: "Dispute Resolution Date"
      expr: dispute_resolution_date
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "Member Tier At Transaction"
      expr: member_tier_at_transaction
    - name: "Notes"
      expr: notes
    - name: "Partner Category"
      expr: partner_category
    - name: "Partner Location City"
      expr: partner_location_city
    - name: "Partner Location Code"
      expr: partner_location_code
    - name: "Partner Location Country Code"
      expr: partner_location_country_code
    - name: "Partner Location Name"
      expr: partner_location_name
    - name: "Posting Date"
      expr: posting_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Partner Transaction"
      expr: COUNT(DISTINCT partner_transaction_id)
    - name: "Total Earn Rate Multiplier"
      expr: SUM(earn_rate_multiplier)
    - name: "Average Earn Rate Multiplier"
      expr: AVG(earn_rate_multiplier)
    - name: "Total Settlement Amount"
      expr: SUM(settlement_amount)
    - name: "Average Settlement Amount"
      expr: AVG(settlement_amount)
    - name: "Total Transaction Amount"
      expr: SUM(transaction_amount)
    - name: "Average Transaction Amount"
      expr: AVG(transaction_amount)
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`loyalty_qualification_cycle`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Qualification Cycle business metrics"
  source: "`airlines_ecm`.`loyalty`.`qualification_cycle`"
  dimensions:
    - name: "Benefit Effective Date"
      expr: benefit_effective_date
    - name: "Benefit Expiry Date"
      expr: benefit_expiry_date
    - name: "Communication Sent Date"
      expr: communication_sent_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Cycle Code"
      expr: cycle_code
    - name: "Cycle Name"
      expr: cycle_name
    - name: "Cycle Type"
      expr: cycle_type
    - name: "Description"
      expr: qualification_cycle_description
    - name: "End Date"
      expr: end_date
    - name: "Evaluation Date"
      expr: evaluation_date
    - name: "Grace Period Days"
      expr: grace_period_days
    - name: "Is Active"
      expr: is_active
    - name: "Is Lifetime Eligible"
      expr: is_lifetime_eligible
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Notes"
      expr: notes
    - name: "Partner Activity Eligible"
      expr: partner_activity_eligible
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Qualification Cycle"
      expr: COUNT(DISTINCT qualification_cycle_id)
    - name: "Total Promotion Multiplier"
      expr: SUM(promotion_multiplier)
    - name: "Average Promotion Multiplier"
      expr: AVG(promotion_multiplier)
    - name: "Total Rollover Percentage"
      expr: SUM(rollover_percentage)
    - name: "Average Rollover Percentage"
      expr: AVG(rollover_percentage)
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`loyalty_status_match`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Status Match business metrics"
  source: "`airlines_ecm`.`loyalty`.`status_match`"
  dimensions:
    - name: "Approval Notes"
      expr: approval_notes
    - name: "Challenge Duration Months"
      expr: challenge_duration_months
    - name: "Challenge End Date"
      expr: challenge_end_date
    - name: "Challenge Start Date"
      expr: challenge_start_date
    - name: "Competing Airline Code"
      expr: competing_airline_code
    - name: "Competing Airline Name"
      expr: competing_airline_name
    - name: "Competing Tier Held"
      expr: competing_tier_held
    - name: "Competing Tier Level"
      expr: competing_tier_level
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Denial Reason"
      expr: denial_reason
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Match Outcome"
      expr: match_outcome
    - name: "Matched Tier Code"
      expr: matched_tier_code
    - name: "Matched Tier Effective Date"
      expr: matched_tier_effective_date
    - name: "Matched Tier Expiry Date"
      expr: matched_tier_expiry_date
    - name: "Proof Of Status Document Type"
      expr: proof_of_status_document_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Status Match"
      expr: COUNT(DISTINCT status_match_id)
    - name: "Total Progress Percentage"
      expr: SUM(progress_percentage)
    - name: "Average Progress Percentage"
      expr: AVG(progress_percentage)
    - name: "Total Qualifying Spend Achieved"
      expr: SUM(qualifying_spend_achieved)
    - name: "Average Qualifying Spend Achieved"
      expr: AVG(qualifying_spend_achieved)
    - name: "Total Qualifying Spend Required"
      expr: SUM(qualifying_spend_required)
    - name: "Average Qualifying Spend Required"
      expr: AVG(qualifying_spend_required)
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`loyalty_tier_qualification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tier Qualification business metrics"
  source: "`airlines_ecm`.`loyalty`.`tier_qualification`"
  dimensions:
    - name: "Adjudication Notes"
      expr: adjudication_notes
    - name: "Challenge Activity Achieved"
      expr: challenge_activity_achieved
    - name: "Challenge Activity Required"
      expr: challenge_activity_required
    - name: "Challenge End Date"
      expr: challenge_end_date
    - name: "Challenge Start Date"
      expr: challenge_start_date
    - name: "Competing Airline Code"
      expr: competing_airline_code
    - name: "Competing Tier Held"
      expr: competing_tier_held
    - name: "Extension Expiry Date"
      expr: extension_expiry_date
    - name: "Extension Granted Flag"
      expr: extension_granted_flag
    - name: "Extension Reason"
      expr: extension_reason
    - name: "Match Approval Date"
      expr: match_approval_date
    - name: "Match Outcome"
      expr: match_outcome
    - name: "Processed Timestamp"
      expr: processed_timestamp
    - name: "Proof Of Status Reference"
      expr: proof_of_status_reference
    - name: "Qualification Source Breakdown"
      expr: qualification_source_breakdown
    - name: "Qualification Status"
      expr: qualification_status
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Tier Qualification"
      expr: COUNT(DISTINCT tier_qualification_id)
    - name: "Total Lifetime Miles Accumulated"
      expr: SUM(lifetime_miles_accumulated)
    - name: "Average Lifetime Miles Accumulated"
      expr: AVG(lifetime_miles_accumulated)
    - name: "Total Qualifying Miles Earned"
      expr: SUM(qualifying_miles_earned)
    - name: "Average Qualifying Miles Earned"
      expr: AVG(qualifying_miles_earned)
    - name: "Total Qualifying Spend Amount"
      expr: SUM(qualifying_spend_amount)
    - name: "Average Qualifying Spend Amount"
      expr: AVG(qualifying_spend_amount)
    - name: "Total Rollover Miles"
      expr: SUM(rollover_miles)
    - name: "Average Rollover Miles"
      expr: AVG(rollover_miles)
    - name: "Total Tier Threshold Miles"
      expr: SUM(tier_threshold_miles)
    - name: "Average Tier Threshold Miles"
      expr: AVG(tier_threshold_miles)
    - name: "Total Tier Threshold Spend"
      expr: SUM(tier_threshold_spend)
    - name: "Average Tier Threshold Spend"
      expr: AVG(tier_threshold_spend)
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`loyalty_tier_status`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tier Status business metrics"
  source: "`airlines_ecm`.`loyalty`.`tier_status`"
  dimensions:
    - name: "Benefits Summary"
      expr: benefits_summary
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Extra Baggage Allowance Kg"
      expr: extra_baggage_allowance_kg
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Lifetime Status Eligible Flag"
      expr: lifetime_status_eligible_flag
    - name: "Lounge Access Flag"
      expr: lounge_access_flag
    - name: "Partner Tier Equivalent Code"
      expr: partner_tier_equivalent_code
    - name: "Priority Baggage Flag"
      expr: priority_baggage_flag
    - name: "Priority Boarding Flag"
      expr: priority_boarding_flag
    - name: "Priority Checkin Flag"
      expr: priority_checkin_flag
    - name: "Qualification Period Months"
      expr: qualification_period_months
    - name: "Qualification Segments Threshold"
      expr: qualification_segments_threshold
    - name: "Tier Code"
      expr: tier_code
    - name: "Tier Level"
      expr: tier_level
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Tier Status"
      expr: COUNT(DISTINCT tier_status_id)
    - name: "Total Award Booking Discount Percent"
      expr: SUM(award_booking_discount_percent)
    - name: "Average Award Booking Discount Percent"
      expr: AVG(award_booking_discount_percent)
    - name: "Total Bonus Mile Multiplier"
      expr: SUM(bonus_mile_multiplier)
    - name: "Average Bonus Mile Multiplier"
      expr: AVG(bonus_mile_multiplier)
    - name: "Total Qualification Miles Threshold"
      expr: SUM(qualification_miles_threshold)
    - name: "Average Qualification Miles Threshold"
      expr: AVG(qualification_miles_threshold)
    - name: "Total Qualification Spend Threshold"
      expr: SUM(qualification_spend_threshold)
    - name: "Average Qualification Spend Threshold"
      expr: AVG(qualification_spend_threshold)
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`loyalty_upgrade_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Upgrade Request business metrics"
  source: "`airlines_ecm`.`loyalty`.`upgrade_request`"
  dimensions:
    - name: "Cancellation Reason"
      expr: cancellation_reason
    - name: "Cancellation Timestamp"
      expr: cancellation_timestamp
    - name: "Co Pay Currency Code"
      expr: co_pay_currency_code
    - name: "Companion Upgrade Flag"
      expr: companion_upgrade_flag
    - name: "Denial Reason Code"
      expr: denial_reason_code
    - name: "Destination Airport Code"
      expr: destination_airport_code
    - name: "Expiry Timestamp"
      expr: expiry_timestamp
    - name: "Fare Class Code"
      expr: fare_class_code
    - name: "Flight Number"
      expr: flight_number
    - name: "Notes"
      expr: notes
    - name: "Origin Airport Code"
      expr: origin_airport_code
    - name: "Pnr"
      expr: pnr
    - name: "Record Created Timestamp"
      expr: record_created_timestamp
    - name: "Record Updated Timestamp"
      expr: record_updated_timestamp
    - name: "Request Channel"
      expr: request_channel
    - name: "Request Timestamp"
      expr: request_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Upgrade Request"
      expr: COUNT(DISTINCT upgrade_request_id)
    - name: "Total Co Pay Amount"
      expr: SUM(co_pay_amount)
    - name: "Average Co Pay Amount"
      expr: AVG(co_pay_amount)
    - name: "Total Miles Deducted"
      expr: SUM(miles_deducted)
    - name: "Average Miles Deducted"
      expr: AVG(miles_deducted)
    - name: "Total Upgrade Priority Score"
      expr: SUM(upgrade_priority_score)
    - name: "Average Upgrade Priority Score"
      expr: AVG(upgrade_priority_score)
$$;
