-- Metric views for domain: guest | Business: Travel_Hospitality | Version: 2 | Generated on: 2026-07-10 20:26:53

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`guest_communication_consent`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Communication Consent business metrics"
  source: "`vibe_travel_hospitality_v1`.`guest`.`communication_consent`"
  dimensions:
    - name: "Consent Audit Trail"
      expr: consent_audit_trail
    - name: "Consent Capture Url"
      expr: consent_capture_url
    - name: "Consent Expiry Date"
      expr: consent_expiry_date
    - name: "Consent Granted Date"
      expr: consent_granted_date
    - name: "Consent Granted Timestamp"
      expr: consent_granted_timestamp
    - name: "Consent Language Code"
      expr: consent_language_code
    - name: "Consent Method"
      expr: consent_method
    - name: "Consent Notes"
      expr: consent_notes
    - name: "Consent Purpose"
      expr: consent_purpose
    - name: "Consent Source"
      expr: consent_source
    - name: "Consent Status"
      expr: consent_status
    - name: "Consent Text Version"
      expr: consent_text_version
    - name: "Consent Type"
      expr: consent_type
    - name: "Consent Withdrawn Date"
      expr: consent_withdrawn_date
    - name: "Consent Withdrawn Timestamp"
      expr: consent_withdrawn_timestamp
    - name: "Created Timestamp"
      expr: created_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Communication Consent"
      expr: COUNT(DISTINCT communication_consent_id)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`guest_contact_info`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contact Info business metrics"
  source: "`vibe_travel_hospitality_v1`.`guest`.`contact_info`"
  dimensions:
    - name: "Address Line1"
      expr: address_line1
    - name: "Address Line2"
      expr: address_line2
    - name: "Address Type"
      expr: address_type
    - name: "Address Validated Date"
      expr: address_validated_date
    - name: "Address Validation Status"
      expr: address_validation_status
    - name: "Bounce Reason"
      expr: bounce_reason
    - name: "City"
      expr: city
    - name: "Contact Channel"
      expr: contact_channel
    - name: "Contact Status"
      expr: contact_status
    - name: "Contact Type"
      expr: contact_type
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Retention Expiry Date"
      expr: data_retention_expiry_date
    - name: "Do Not Contact"
      expr: do_not_contact
    - name: "Email Address"
      expr: email_address
    - name: "Email Type"
      expr: email_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Contact Info"
      expr: COUNT(DISTINCT contact_info_id)
    - name: "Total Latitude"
      expr: SUM(latitude)
    - name: "Average Latitude"
      expr: AVG(latitude)
    - name: "Total Longitude"
      expr: SUM(longitude)
    - name: "Average Longitude"
      expr: AVG(longitude)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`guest_corporate_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Corporate Account business metrics"
  source: "`vibe_travel_hospitality_v1`.`guest`.`corporate_account`"
  dimensions:
    - name: "Account Manager Email"
      expr: account_manager_email
    - name: "Account Manager Name"
      expr: account_manager_name
    - name: "Account Status"
      expr: account_status
    - name: "Account Type"
      expr: account_type
    - name: "Annual Room Night Target"
      expr: annual_room_night_target
    - name: "Billing Address City"
      expr: billing_address_city
    - name: "Billing Address Country Code"
      expr: billing_address_country_code
    - name: "Billing Address Line1"
      expr: billing_address_line1
    - name: "Billing Instruction"
      expr: billing_instruction
    - name: "Blackout Dates Policy"
      expr: blackout_dates_policy
    - name: "Company Name"
      expr: company_name
    - name: "Contract End Date"
      expr: contract_end_date
    - name: "Contract Start Date"
      expr: contract_start_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Credit Currency Code"
      expr: credit_currency_code
    - name: "Crm Account Reference"
      expr: crm_account_reference
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Corporate Account"
      expr: COUNT(DISTINCT corporate_account_id)
    - name: "Total Annual Revenue Target"
      expr: SUM(annual_revenue_target)
    - name: "Average Annual Revenue Target"
      expr: AVG(annual_revenue_target)
    - name: "Total Credit Limit"
      expr: SUM(credit_limit)
    - name: "Average Credit Limit"
      expr: AVG(credit_limit)
    - name: "Total Discount Percent"
      expr: SUM(discount_percent)
    - name: "Average Discount Percent"
      expr: AVG(discount_percent)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`guest_corporate_property_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Corporate Property Contract business metrics"
  source: "`vibe_travel_hospitality_v1`.`guest`.`corporate_property_contract`"
  dimensions:
    - name: "Annual Room Night Target"
      expr: annual_room_night_target
    - name: "Blackout Dates Policy"
      expr: blackout_dates_policy
    - name: "Contract End Date"
      expr: contract_end_date
    - name: "Contract Start Date"
      expr: contract_start_date
    - name: "Contract Status"
      expr: contract_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Direct Billing Enabled"
      expr: direct_billing_enabled
    - name: "Last Pickup Review Date"
      expr: last_pickup_review_date
    - name: "Los Minimum Nights"
      expr: los_minimum_nights
    - name: "Negotiated Rate Code"
      expr: negotiated_rate_code
    - name: "Payment Terms"
      expr: payment_terms
    - name: "Property Account Manager Email"
      expr: property_account_manager_email
    - name: "Property Account Manager Name"
      expr: property_account_manager_name
    - name: "Rate Program Type"
      expr: rate_program_type
    - name: "Updated Timestamp"
      expr: updated_timestamp
    - name: "Contract End Date Month"
      expr: DATE_TRUNC('MONTH', contract_end_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Corporate Property Contract"
      expr: COUNT(DISTINCT corporate_property_contract_id)
    - name: "Total Annual Revenue Target"
      expr: SUM(annual_revenue_target)
    - name: "Average Annual Revenue Target"
      expr: AVG(annual_revenue_target)
    - name: "Total Credit Limit"
      expr: SUM(credit_limit)
    - name: "Average Credit Limit"
      expr: AVG(credit_limit)
    - name: "Total Discount Percent"
      expr: SUM(discount_percent)
    - name: "Average Discount Percent"
      expr: AVG(discount_percent)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`guest_group_function_space_booking`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Group Function Space Booking business metrics"
  source: "`vibe_travel_hospitality_v1`.`guest`.`group_function_space_booking`"
  dimensions:
    - name: "Actual Attendance"
      expr: actual_attendance
    - name: "Av Requirements"
      expr: av_requirements
    - name: "Booking Date"
      expr: booking_date
    - name: "Booking Status"
      expr: booking_status
    - name: "Catering Minimum Met"
      expr: catering_minimum_met
    - name: "Currency Code"
      expr: currency_code
    - name: "Event End Datetime"
      expr: event_end_datetime
    - name: "Event Start Datetime"
      expr: event_start_datetime
    - name: "Guaranteed Attendance"
      expr: guaranteed_attendance
    - name: "Setup Type"
      expr: setup_type
    - name: "Special Setup Notes"
      expr: special_setup_notes
    - name: "Booking Date Month"
      expr: DATE_TRUNC('MONTH', booking_date)
    - name: "Event End Datetime Month"
      expr: DATE_TRUNC('MONTH', event_end_datetime)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Group Function Space Booking"
      expr: COUNT(DISTINCT group_function_space_booking_id)
    - name: "Total Rental Amount"
      expr: SUM(rental_amount)
    - name: "Average Rental Amount"
      expr: AVG(rental_amount)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`guest_guest_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Guest Enrollment business metrics"
  source: "`vibe_travel_hospitality_v1`.`guest`.`guest_enrollment`"
  dimensions:
    - name: "Award Date"
      expr: award_date
    - name: "Bonus Awarded Flag"
      expr: bonus_awarded_flag
    - name: "Channel"
      expr: channel
    - name: "Completion Date"
      expr: completion_date
    - name: "Guest Enrollment Date"
      expr: guest_enrollment_date
    - name: "Guest Enrollment Status"
      expr: guest_enrollment_status
    - name: "Opt Out Date"
      expr: opt_out_date
    - name: "Award Date Month"
      expr: DATE_TRUNC('MONTH', award_date)
    - name: "Completion Date Month"
      expr: DATE_TRUNC('MONTH', completion_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Guest Enrollment"
      expr: COUNT(DISTINCT guest_enrollment_id)
    - name: "Total Enrollment Reference"
      expr: SUM(enrollment_reference)
    - name: "Average Enrollment Reference"
      expr: AVG(enrollment_reference)
    - name: "Total Progress Value"
      expr: SUM(progress_value)
    - name: "Average Progress Value"
      expr: AVG(progress_value)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`guest_guest_group_block`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Guest Group Block business metrics"
  source: "`vibe_travel_hospitality_v1`.`guest`.`guest_group_block`"
  dimensions:
    - name: "Accessible Rooms Requested"
      expr: accessible_rooms_requested
    - name: "Arrival Date"
      expr: arrival_date
    - name: "Billing Master Folio Instructions"
      expr: billing_master_folio_instructions
    - name: "Block Status"
      expr: block_status
    - name: "Cancellation Date"
      expr: cancellation_date
    - name: "Cancellation Policy Code"
      expr: cancellation_policy_code
    - name: "Complimentary Rooms Contracted"
      expr: complimentary_rooms_contracted
    - name: "Contracted Date"
      expr: contracted_date
    - name: "Contracted Room Nights"
      expr: contracted_room_nights
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Cutoff Date"
      expr: cutoff_date
    - name: "Delphi Opportunity Reference"
      expr: delphi_opportunity_reference
    - name: "Departure Date"
      expr: departure_date
    - name: "Deposit Due Date"
      expr: deposit_due_date
    - name: "Group Code"
      expr: group_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Guest Group Block"
      expr: COUNT(DISTINCT guest_group_block_id)
    - name: "Total Attrition Pct"
      expr: SUM(attrition_pct)
    - name: "Average Attrition Pct"
      expr: AVG(attrition_pct)
    - name: "Total Contracted Rate Amount"
      expr: SUM(contracted_rate_amount)
    - name: "Average Contracted Rate Amount"
      expr: AVG(contracted_rate_amount)
    - name: "Total Deposit Received Amount"
      expr: SUM(deposit_received_amount)
    - name: "Average Deposit Received Amount"
      expr: AVG(deposit_received_amount)
    - name: "Total Deposit Required Amount"
      expr: SUM(deposit_required_amount)
    - name: "Average Deposit Required Amount"
      expr: AVG(deposit_required_amount)
    - name: "Total Wash Pct"
      expr: SUM(wash_pct)
    - name: "Average Wash Pct"
      expr: AVG(wash_pct)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`guest_household`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Household business metrics"
  source: "`vibe_travel_hospitality_v1`.`guest`.`household`"
  dimensions:
    - name: "Address Line 1"
      expr: address_line_1
    - name: "Address Line 2"
      expr: address_line_2
    - name: "Adult Count"
      expr: adult_count
    - name: "Child Count"
      expr: child_count
    - name: "City"
      expr: city
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Crm Account Code"
      expr: crm_account_code
    - name: "External Reference Code"
      expr: external_reference_code
    - name: "Household Status"
      expr: household_status
    - name: "Household Type"
      expr: household_type
    - name: "Last Stay Date"
      expr: last_stay_date
    - name: "Lifetime Nights"
      expr: lifetime_nights
    - name: "Loyalty Tier"
      expr: loyalty_tier
    - name: "Marketing Opt In"
      expr: marketing_opt_in
    - name: "Member Count"
      expr: member_count
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Household"
      expr: COUNT(DISTINCT household_id)
    - name: "Total Average Daily Rate"
      expr: SUM(average_daily_rate)
    - name: "Average Average Daily Rate"
      expr: AVG(average_daily_rate)
    - name: "Total Lifetime Revenue"
      expr: SUM(lifetime_revenue)
    - name: "Average Lifetime Revenue"
      expr: AVG(lifetime_revenue)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`guest_identity_document`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Identity Document business metrics"
  source: "`vibe_travel_hospitality_v1`.`guest`.`identity_document`"
  dimensions:
    - name: "Capture Channel"
      expr: capture_channel
    - name: "Capture Timestamp"
      expr: capture_timestamp
    - name: "Compliance Flag"
      expr: compliance_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Retention Category"
      expr: data_retention_category
    - name: "Date Of Birth"
      expr: date_of_birth
    - name: "Document Number"
      expr: document_number
    - name: "Document Scan Reference"
      expr: document_scan_reference
    - name: "Document Scan Timestamp"
      expr: document_scan_timestamp
    - name: "Document Type"
      expr: document_type
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Full Name On Document"
      expr: full_name_on_document
    - name: "Gdpr Consent Flag"
      expr: gdpr_consent_flag
    - name: "Gender"
      expr: gender
    - name: "Government Report Status"
      expr: government_report_status
    - name: "Government Report Timestamp"
      expr: government_report_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Identity Document"
      expr: COUNT(DISTINCT identity_document_id)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`guest_lifetime_value`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lifetime Value business metrics"
  source: "`vibe_travel_hospitality_v1`.`guest`.`lifetime_value`"
  dimensions:
    - name: "Calculation Date"
      expr: calculation_date
    - name: "Calculation Method"
      expr: calculation_method
    - name: "Churn Risk Flag"
      expr: churn_risk_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Days Since Last Stay"
      expr: days_since_last_stay
    - name: "First Stay Date"
      expr: first_stay_date
    - name: "Guest Tenure Days"
      expr: guest_tenure_days
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "Loyalty Member Number"
      expr: loyalty_member_number
    - name: "Loyalty Tier Code"
      expr: loyalty_tier_code
    - name: "Ltv Tier"
      expr: ltv_tier
    - name: "Market Segment Code"
      expr: market_segment_code
    - name: "Most Recent Stay Date"
      expr: most_recent_stay_date
    - name: "Preferred Brand Code"
      expr: preferred_brand_code
    - name: "Total Complaints"
      expr: total_complaints
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Lifetime Value"
      expr: COUNT(DISTINCT lifetime_value_id)
    - name: "Total Average Daily Rate"
      expr: SUM(average_daily_rate)
    - name: "Average Average Daily Rate"
      expr: AVG(average_daily_rate)
    - name: "Total Average Gss Score"
      expr: SUM(average_gss_score)
    - name: "Average Average Gss Score"
      expr: AVG(average_gss_score)
    - name: "Total Average Length Of Stay"
      expr: SUM(average_length_of_stay)
    - name: "Average Average Length Of Stay"
      expr: AVG(average_length_of_stay)
    - name: "Total Average Nps Score"
      expr: SUM(average_nps_score)
    - name: "Average Average Nps Score"
      expr: AVG(average_nps_score)
    - name: "Total Average Revenue Per Stay"
      expr: SUM(average_revenue_per_stay)
    - name: "Average Average Revenue Per Stay"
      expr: AVG(average_revenue_per_stay)
    - name: "Total Churn Risk Score"
      expr: SUM(churn_risk_score)
    - name: "Average Churn Risk Score"
      expr: AVG(churn_risk_score)
    - name: "Total Data Quality Score"
      expr: SUM(data_quality_score)
    - name: "Average Data Quality Score"
      expr: AVG(data_quality_score)
    - name: "Total Ltv Score"
      expr: SUM(ltv_score)
    - name: "Average Ltv Score"
      expr: AVG(ltv_score)
    - name: "Total Next Stay Propensity Score"
      expr: SUM(next_stay_propensity_score)
    - name: "Average Next Stay Propensity Score"
      expr: AVG(next_stay_propensity_score)
    - name: "Total Projected 12m Revenue"
      expr: SUM(projected_12m_revenue)
    - name: "Average Projected 12m Revenue"
      expr: AVG(projected_12m_revenue)
    - name: "Total Total Ancillary Revenue"
      expr: SUM(total_ancillary_revenue)
    - name: "Average Total Ancillary Revenue"
      expr: AVG(total_ancillary_revenue)
    - name: "Total Total Fb Revenue"
      expr: SUM(total_fb_revenue)
    - name: "Average Total Fb Revenue"
      expr: AVG(total_fb_revenue)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`guest_note`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Note business metrics"
  source: "`vibe_travel_hospitality_v1`.`guest`.`note`"
  dimensions:
    - name: "Action Date"
      expr: action_date
    - name: "Assigned Department"
      expr: assigned_department
    - name: "Authoring Department"
      expr: authoring_department
    - name: "Note Category"
      expr: note_category
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Retention Category"
      expr: data_retention_category
    - name: "Display On Checkin"
      expr: display_on_checkin
    - name: "Display On Checkout"
      expr: display_on_checkout
    - name: "Display On Reservation"
      expr: display_on_reservation
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Gdpr Consent Flag"
      expr: gdpr_consent_flag
    - name: "Guest Segment"
      expr: guest_segment
    - name: "Is Confidential"
      expr: is_confidential
    - name: "Is Vip Alert"
      expr: is_vip_alert
    - name: "Language Code"
      expr: language_code
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Note"
      expr: COUNT(DISTINCT note_id)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`guest_preference`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Preference business metrics"
  source: "`vibe_travel_hospitality_v1`.`guest`.`preference`"
  dimensions:
    - name: "Allergy Detail"
      expr: allergy_detail
    - name: "Amenity Preferences"
      expr: amenity_preferences
    - name: "Bed Type Preference"
      expr: bed_type_preference
    - name: "Preference Category"
      expr: preference_category
    - name: "Preference Code"
      expr: preference_code
    - name: "Communication Channel Preference"
      expr: communication_channel_preference
    - name: "Consent Date"
      expr: consent_date
    - name: "Consent Given"
      expr: consent_given
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Classification"
      expr: data_classification
    - name: "Dietary Restriction"
      expr: dietary_restriction
    - name: "Fulfillment Notes"
      expr: fulfillment_notes
    - name: "Fulfillment Status"
      expr: fulfillment_status
    - name: "Housekeeping Schedule Preference"
      expr: housekeeping_schedule_preference
    - name: "Is Ada Requirement"
      expr: is_ada_requirement
    - name: "Is Allergy"
      expr: is_allergy
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Preference"
      expr: COUNT(DISTINCT preference_id)
    - name: "Total Room Temperature Celsius"
      expr: SUM(room_temperature_celsius)
    - name: "Average Room Temperature Celsius"
      expr: AVG(room_temperature_celsius)
    - name: "Total Value"
      expr: SUM(value)
    - name: "Average Value"
      expr: AVG(value)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`guest_privacy_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Privacy Request business metrics"
  source: "`vibe_travel_hospitality_v1`.`guest`.`privacy_request`"
  dimensions:
    - name: "Assigned Handler Email"
      expr: assigned_handler_email
    - name: "Assigned Handler Name"
      expr: assigned_handler_name
    - name: "Completion Date"
      expr: completion_date
    - name: "Completion Timestamp"
      expr: completion_timestamp
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Crm Case Reference"
      expr: crm_case_reference
    - name: "Data Format"
      expr: data_format
    - name: "Data Scope"
      expr: data_scope
    - name: "Delivery Method"
      expr: delivery_method
    - name: "Extended Due Date"
      expr: extended_due_date
    - name: "Extension Granted Flag"
      expr: extension_granted_flag
    - name: "Extension Reason"
      expr: extension_reason
    - name: "Guest Comments"
      expr: guest_comments
    - name: "Guest Communication Sent Count"
      expr: guest_communication_sent_count
    - name: "Guest Country Code"
      expr: guest_country_code
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Privacy Request"
      expr: COUNT(DISTINCT privacy_request_id)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`guest_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Profile business metrics"
  source: "`vibe_travel_hospitality_v1`.`guest`.`profile`"
  dimensions:
    - name: "Accessibility Needs"
      expr: accessibility_needs
    - name: "Birth Date"
      expr: birth_date
    - name: "Company Name"
      expr: company_name
    - name: "Country Of Residence Code"
      expr: country_of_residence_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Creation Property Code"
      expr: creation_property_code
    - name: "Crm Contact Reference"
      expr: crm_contact_reference
    - name: "Data Privacy Consent Date"
      expr: data_privacy_consent_date
    - name: "Email"
      expr: email
    - name: "Email Opt In"
      expr: email_opt_in
    - name: "Family Name"
      expr: family_name
    - name: "Gdpr Erasure Requested"
      expr: gdpr_erasure_requested
    - name: "Gender"
      expr: gender
    - name: "Given Name"
      expr: given_name
    - name: "Guest Type"
      expr: guest_type
    - name: "Is Merge Survivor"
      expr: is_merge_survivor
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Profile"
      expr: COUNT(DISTINCT profile_id)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`guest_profile_merge_history`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Profile Merge History business metrics"
  source: "`vibe_travel_hospitality_v1`.`guest`.`profile_merge_history`"
  dimensions:
    - name: "Contact Info Migrated Count"
      expr: contact_info_migrated_count
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Retention Category"
      expr: data_retention_category
    - name: "Error Message"
      expr: error_message
    - name: "Gdpr Consent Retained"
      expr: gdpr_consent_retained
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Matching Criteria"
      expr: matching_criteria
    - name: "Merge Batch Code"
      expr: merge_batch_code
    - name: "Merge Comments"
      expr: merge_comments
    - name: "Merge Method"
      expr: merge_method
    - name: "Merge Reason"
      expr: merge_reason
    - name: "Merge Status"
      expr: merge_status
    - name: "Merge Timestamp"
      expr: merge_timestamp
    - name: "Notes Migrated Count"
      expr: notes_migrated_count
    - name: "Operator Department"
      expr: operator_department
    - name: "Operator Name"
      expr: operator_name
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Profile Merge History"
      expr: COUNT(DISTINCT profile_merge_history_id)
    - name: "Total Loyalty Points Transferred"
      expr: SUM(loyalty_points_transferred)
    - name: "Average Loyalty Points Transferred"
      expr: AVG(loyalty_points_transferred)
    - name: "Total Matching Confidence Score"
      expr: SUM(matching_confidence_score)
    - name: "Average Matching Confidence Score"
      expr: AVG(matching_confidence_score)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`guest_relationship`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Relationship business metrics"
  source: "`vibe_travel_hospitality_v1`.`guest`.`relationship`"
  dimensions:
    - name: "Billing Authority Flag"
      expr: billing_authority_flag
    - name: "Booking Authority Flag"
      expr: booking_authority_flag
    - name: "Consent Date"
      expr: consent_date
    - name: "Consent Flag"
      expr: consent_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Retention Expiry Date"
      expr: data_retention_expiry_date
    - name: "Direction"
      expr: direction
    - name: "Emergency Contact Flag"
      expr: emergency_contact_flag
    - name: "End Date"
      expr: end_date
    - name: "Gdpr Lawful Basis"
      expr: gdpr_lawful_basis
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Notes"
      expr: notes
    - name: "Primary Contact Flag"
      expr: primary_contact_flag
    - name: "Priority"
      expr: priority
    - name: "Relationship Status"
      expr: relationship_status
    - name: "Relationship Type"
      expr: relationship_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Relationship"
      expr: COUNT(DISTINCT relationship_id)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`guest_segment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Segment business metrics"
  source: "`vibe_travel_hospitality_v1`.`guest`.`segment`"
  dimensions:
    - name: "Advance Booking Window Days"
      expr: advance_booking_window_days
    - name: "Assignment Date"
      expr: assignment_date
    - name: "Assignment Effective Date"
      expr: assignment_effective_date
    - name: "Assignment Expiry Date"
      expr: assignment_expiry_date
    - name: "Assignment Method"
      expr: assignment_method
    - name: "Assignment Notes"
      expr: assignment_notes
    - name: "Assignment Reason Code"
      expr: assignment_reason_code
    - name: "Cancellation Policy Code"
      expr: cancellation_policy_code
    - name: "Segment Category"
      expr: segment_category
    - name: "Segment Code"
      expr: segment_code
    - name: "Commission Eligible"
      expr: commission_eligible
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Displacement Analysis Eligible"
      expr: displacement_analysis_eligible
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Hierarchy Level"
      expr: hierarchy_level
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Segment"
      expr: COUNT(DISTINCT segment_id)
    - name: "Total Adr Index Vs Property"
      expr: SUM(adr_index_vs_property)
    - name: "Average Adr Index Vs Property"
      expr: AVG(adr_index_vs_property)
    - name: "Total Ancillary Revenue Per Stay"
      expr: SUM(ancillary_revenue_per_stay)
    - name: "Average Ancillary Revenue Per Stay"
      expr: AVG(ancillary_revenue_per_stay)
    - name: "Total Assignment Confidence Score"
      expr: SUM(assignment_confidence_score)
    - name: "Average Assignment Confidence Score"
      expr: AVG(assignment_confidence_score)
    - name: "Total Average Los Days"
      expr: SUM(average_los_days)
    - name: "Average Average Los Days"
      expr: AVG(average_los_days)
    - name: "Total Commission Rate Pct"
      expr: SUM(commission_rate_pct)
    - name: "Average Commission Rate Pct"
      expr: AVG(commission_rate_pct)
    - name: "Total Fb Attachment Rate Pct"
      expr: SUM(fb_attachment_rate_pct)
    - name: "Average Fb Attachment Rate Pct"
      expr: AVG(fb_attachment_rate_pct)
    - name: "Total Loyalty Points Multiplier"
      expr: SUM(loyalty_points_multiplier)
    - name: "Average Loyalty Points Multiplier"
      expr: AVG(loyalty_points_multiplier)
    - name: "Total Revpar Contribution Pct"
      expr: SUM(revpar_contribution_pct)
    - name: "Average Revpar Contribution Pct"
      expr: AVG(revpar_contribution_pct)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`guest_segment_membership`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Segment Membership business metrics"
  source: "`vibe_travel_hospitality_v1`.`guest`.`segment_membership`"
  dimensions:
    - name: "Assignment Date"
      expr: assignment_date
    - name: "Assignment Effective Date"
      expr: assignment_effective_date
    - name: "Assignment Expiry Date"
      expr: assignment_expiry_date
    - name: "Assignment Method"
      expr: assignment_method
    - name: "Assignment Reason Code"
      expr: assignment_reason_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Last Refresh Date"
      expr: last_refresh_date
    - name: "Membership Status"
      expr: membership_status
    - name: "Updated Timestamp"
      expr: updated_timestamp
    - name: "Assignment Date Month"
      expr: DATE_TRUNC('MONTH', assignment_date)
    - name: "Assignment Effective Date Month"
      expr: DATE_TRUNC('MONTH', assignment_effective_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Segment Membership"
      expr: COUNT(DISTINCT segment_membership_id)
    - name: "Total Assignment Confidence Score"
      expr: SUM(assignment_confidence_score)
    - name: "Average Assignment Confidence Score"
      expr: AVG(assignment_confidence_score)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`guest_stay_history`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Stay History business metrics"
  source: "`vibe_travel_hospitality_v1`.`guest`.`stay_history`"
  dimensions:
    - name: "Arrival Date"
      expr: arrival_date
    - name: "Booking Channel Code"
      expr: booking_channel_code
    - name: "Booking Date"
      expr: booking_date
    - name: "Checkin Timestamp"
      expr: checkin_timestamp
    - name: "Checkout Timestamp"
      expr: checkout_timestamp
    - name: "Complimentary Flag"
      expr: complimentary_flag
    - name: "Confirmation Number"
      expr: confirmation_number
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Departure Date"
      expr: departure_date
    - name: "Do Not Disturb Flag"
      expr: do_not_disturb_flag
    - name: "Guest Type"
      expr: guest_type
    - name: "Los Nights"
      expr: los_nights
    - name: "Loyalty Member Number"
      expr: loyalty_member_number
    - name: "Loyalty Points Earned"
      expr: loyalty_points_earned
    - name: "Loyalty Tier At Stay"
      expr: loyalty_tier_at_stay
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Stay History"
      expr: COUNT(DISTINCT stay_history_id)
    - name: "Total Adr"
      expr: SUM(adr)
    - name: "Average Adr"
      expr: AVG(adr)
    - name: "Total Ancillary Revenue"
      expr: SUM(ancillary_revenue)
    - name: "Average Ancillary Revenue"
      expr: AVG(ancillary_revenue)
    - name: "Total Fb Revenue"
      expr: SUM(fb_revenue)
    - name: "Average Fb Revenue"
      expr: AVG(fb_revenue)
    - name: "Total Gss Score"
      expr: SUM(gss_score)
    - name: "Average Gss Score"
      expr: AVG(gss_score)
    - name: "Total Room Revenue"
      expr: SUM(room_revenue)
    - name: "Average Room Revenue"
      expr: AVG(room_revenue)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
    - name: "Total Total Folio Amount"
      expr: SUM(total_folio_amount)
    - name: "Average Total Folio Amount"
      expr: AVG(total_folio_amount)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`guest_vip_designation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vip Designation business metrics"
  source: "`vibe_travel_hospitality_v1`.`guest`.`vip_designation`"
  dimensions:
    - name: "Airport Transfer Required"
      expr: airport_transfer_required
    - name: "Alias Name"
      expr: alias_name
    - name: "Amenity Tier Code"
      expr: amenity_tier_code
    - name: "Concurrent Designation Count"
      expr: concurrent_designation_count
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Designation Code"
      expr: designation_code
    - name: "Designation Notes"
      expr: designation_notes
    - name: "Designation Reason"
      expr: designation_reason
    - name: "Designation Scope"
      expr: designation_scope
    - name: "Designation Status"
      expr: designation_status
    - name: "Do Not Disturb"
      expr: do_not_disturb
    - name: "Effective From"
      expr: effective_from
    - name: "Effective Until"
      expr: effective_until
    - name: "Gm Greeting Required"
      expr: gm_greeting_required
    - name: "Incognito Checkin"
      expr: incognito_checkin
    - name: "Last Stay Date"
      expr: last_stay_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Vip Designation"
      expr: COUNT(DISTINCT vip_designation_id)
    - name: "Total Revenue Threshold Amount"
      expr: SUM(revenue_threshold_amount)
    - name: "Average Revenue Threshold Amount"
      expr: AVG(revenue_threshold_amount)
$$;