-- Metric views for domain: customer | Business: Automotive | Version: 2 | Generated on: 2026-07-14 04:29:52

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`customer_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Case business metrics"
  source: "`vibe_automotive_v1`.`customer`.`case`"
  dimensions:
    - name: "Case Number"
      expr: case_number
    - name: "Case Status"
      expr: case_status
    - name: "Case Type"
      expr: case_type
    - name: "Category"
      expr: case_category
    - name: "Closed Timestamp"
      expr: closed_timestamp
    - name: "Customer Satisfaction Score"
      expr: customer_satisfaction_score
    - name: "Dealer Code"
      expr: dealer_code
    - name: "Description"
      expr: case_description
    - name: "Dynamics Case Reference"
      expr: dynamics_case_reference
    - name: "Escalation Level"
      expr: escalation_level
    - name: "Escalation Reason"
      expr: escalation_reason
    - name: "Opened Timestamp"
      expr: opened_timestamp
    - name: "Priority"
      expr: priority
    - name: "Record Audit Created"
      expr: record_audit_created
    - name: "Record Audit Updated"
      expr: record_audit_updated
    - name: "Resolution Code"
      expr: resolution_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Case"
      expr: COUNT(DISTINCT case_id)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`customer_connected_vehicle`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Connected Vehicle business metrics"
  source: "`vibe_automotive_v1`.`customer`.`connected_vehicle`"
  dimensions:
    - name: "Activation Status"
      expr: activation_status
    - name: "Activation Timestamp"
      expr: activation_timestamp
    - name: "Connectivity Tier"
      expr: connectivity_tier
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Plan"
      expr: data_plan
    - name: "Data Usage Last Reset"
      expr: data_usage_last_reset
    - name: "Deactivation Timestamp"
      expr: deactivation_timestamp
    - name: "Device Type"
      expr: device_type
    - name: "Diagnostic Status"
      expr: diagnostic_status
    - name: "Firmware Version"
      expr: firmware_version
    - name: "Geographic Region"
      expr: geographic_region
    - name: "Last Diagnostic Timestamp"
      expr: last_diagnostic_timestamp
    - name: "Last Error Code"
      expr: last_error_code
    - name: "Last Ota Update Timestamp"
      expr: last_ota_update_timestamp
    - name: "Last Tpms Update Timestamp"
      expr: last_tpms_update_timestamp
    - name: "Last V2x Update Timestamp"
      expr: last_v2x_update_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Connected Vehicle"
      expr: COUNT(DISTINCT connected_vehicle_id)
    - name: "Total Battery Health Percent"
      expr: SUM(battery_health_percent)
    - name: "Average Battery Health Percent"
      expr: AVG(battery_health_percent)
    - name: "Total Battery State Of Charge Percent"
      expr: SUM(battery_state_of_charge_percent)
    - name: "Average Battery State Of Charge Percent"
      expr: AVG(battery_state_of_charge_percent)
    - name: "Total Data Usage Gb"
      expr: SUM(data_usage_gb)
    - name: "Average Data Usage Gb"
      expr: AVG(data_usage_gb)
    - name: "Total Mileage Km"
      expr: SUM(mileage_km)
    - name: "Average Mileage Km"
      expr: AVG(mileage_km)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`customer_contact_point`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contact Point business metrics"
  source: "`vibe_automotive_v1`.`customer`.`contact_point`"
  dimensions:
    - name: "Address Line1"
      expr: address_line1
    - name: "Address Line2"
      expr: address_line2
    - name: "Channel"
      expr: channel
    - name: "City"
      expr: city
    - name: "Classification"
      expr: classification
    - name: "Communication Preference"
      expr: communication_preference
    - name: "Contact Point Status"
      expr: contact_point_status
    - name: "Contact Point Type"
      expr: contact_point_type
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective Date"
      expr: effective_date
    - name: "Email Address"
      expr: email_address
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Is Primary"
      expr: is_primary
    - name: "Is Verified"
      expr: is_verified
    - name: "Language Preference"
      expr: language_preference
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Contact Point"
      expr: COUNT(DISTINCT contact_point_id)
    - name: "Total Value"
      expr: SUM(value)
    - name: "Average Value"
      expr: AVG(value)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`customer_individual`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Individual business metrics"
  source: "`vibe_automotive_v1`.`customer`.`individual`"
  dimensions:
    - name: "Address Line1"
      expr: address_line1
    - name: "Address Line2"
      expr: address_line2
    - name: "Annual Income Band"
      expr: annual_income_band
    - name: "City"
      expr: city
    - name: "Consent Timestamp"
      expr: consent_timestamp
    - name: "Country Code"
      expr: country_code
    - name: "Country Of Residence"
      expr: country_of_residence
    - name: "Customer Type"
      expr: customer_type
    - name: "Date Of Birth"
      expr: date_of_birth
    - name: "Driver License Expiry"
      expr: driver_license_expiry
    - name: "Driver License Number"
      expr: driver_license_number
    - name: "Driver License State"
      expr: driver_license_state
    - name: "Education Level"
      expr: education_level
    - name: "Email Address"
      expr: email_address
    - name: "Employment Status"
      expr: employment_status
    - name: "First Name"
      expr: first_name
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Individual"
      expr: COUNT(DISTINCT individual_id)
    - name: "Total Cltv Estimate"
      expr: SUM(cltv_estimate)
    - name: "Average Cltv Estimate"
      expr: AVG(cltv_estimate)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`customer_loyalty_membership`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Loyalty Membership business metrics"
  source: "`vibe_automotive_v1`.`customer`.`loyalty_membership`"
  dimensions:
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Current Tier"
      expr: current_tier
    - name: "Enrollment Channel"
      expr: enrollment_channel
    - name: "Enrollment Date"
      expr: enrollment_date
    - name: "Is Primary Member"
      expr: is_primary_member
    - name: "Last Activity Timestamp"
      expr: last_activity_timestamp
    - name: "Last Redemption Timestamp"
      expr: last_redemption_timestamp
    - name: "Membership Expiry Date"
      expr: membership_expiry_date
    - name: "Membership Number"
      expr: membership_number
    - name: "Notes"
      expr: notes
    - name: "Points Expiry Date"
      expr: points_expiry_date
    - name: "Preferred Redemption Category"
      expr: preferred_redemption_category
    - name: "Program Status"
      expr: program_status
    - name: "Record Status"
      expr: record_status
    - name: "Redemption Eligibility Flag"
      expr: redemption_eligibility_flag
    - name: "Referral Code"
      expr: referral_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Loyalty Membership"
      expr: COUNT(DISTINCT loyalty_membership_id)
    - name: "Total Lifetime Points Earned"
      expr: SUM(lifetime_points_earned)
    - name: "Average Lifetime Points Earned"
      expr: AVG(lifetime_points_earned)
    - name: "Total Points Balance"
      expr: SUM(points_balance)
    - name: "Average Points Balance"
      expr: AVG(points_balance)
    - name: "Total Points Balance Last Year"
      expr: SUM(points_balance_last_year)
    - name: "Average Points Balance Last Year"
      expr: AVG(points_balance_last_year)
    - name: "Total Points Earned This Year"
      expr: SUM(points_earned_this_year)
    - name: "Average Points Earned This Year"
      expr: AVG(points_earned_this_year)
    - name: "Total Points Redeemed This Year"
      expr: SUM(points_redeemed_this_year)
    - name: "Average Points Redeemed This Year"
      expr: AVG(points_redeemed_this_year)
    - name: "Total Tier Points Required"
      expr: SUM(tier_points_required)
    - name: "Average Tier Points Required"
      expr: AVG(tier_points_required)
    - name: "Total Total Points Redeemed"
      expr: SUM(total_points_redeemed)
    - name: "Average Total Points Redeemed"
      expr: AVG(total_points_redeemed)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`customer_organization_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Organization Account business metrics"
  source: "`vibe_automotive_v1`.`customer`.`organization_account`"
  dimensions:
    - name: "Account Tier"
      expr: account_tier
    - name: "Accounts Payable Contact Email"
      expr: accounts_payable_contact_email
    - name: "Accounts Payable Contact Name"
      expr: accounts_payable_contact_name
    - name: "Accounts Payable Contact Phone"
      expr: accounts_payable_contact_phone
    - name: "Classification"
      expr: classification
    - name: "Contract Vehicle Type"
      expr: contract_vehicle_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Dba Name"
      expr: dba_name
    - name: "Duns Number"
      expr: duns_number
    - name: "Effective From"
      expr: effective_from
    - name: "Effective Until"
      expr: effective_until
    - name: "Fleet Size"
      expr: fleet_size
    - name: "Government Entity Type"
      expr: government_entity_type
    - name: "Industry Codes"
      expr: industry_codes
    - name: "Legal Entity Name"
      expr: legal_entity_name
    - name: "Naics Code"
      expr: naics_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Organization Account"
      expr: COUNT(DISTINCT organization_account_id)
    - name: "Total Annual Revenue"
      expr: SUM(annual_revenue)
    - name: "Average Annual Revenue"
      expr: AVG(annual_revenue)
    - name: "Total Credit Limit"
      expr: SUM(credit_limit)
    - name: "Average Credit Limit"
      expr: AVG(credit_limit)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`customer_party`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Party business metrics"
  source: "`vibe_automotive_v1`.`customer`.`party`"
  dimensions:
    - name: "Address Line1"
      expr: address_line1
    - name: "Address Line2"
      expr: address_line2
    - name: "Address Type"
      expr: address_type
    - name: "City"
      expr: city
    - name: "Communication Preference"
      expr: communication_preference
    - name: "Country Code"
      expr: country_code
    - name: "Credit Rating"
      expr: credit_rating
    - name: "Customer Segment"
      expr: customer_segment
    - name: "Data Residency Region"
      expr: data_residency_region
    - name: "Date Of Birth"
      expr: date_of_birth
    - name: "Email Address"
      expr: email_address
    - name: "External Reference Code"
      expr: external_reference_code
    - name: "Gdpr Consent Email"
      expr: gdpr_consent_email
    - name: "Gdpr Consent Sms"
      expr: gdpr_consent_sms
    - name: "Incorporation Date"
      expr: incorporation_date
    - name: "Industry Classification"
      expr: industry_classification
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Party"
      expr: COUNT(DISTINCT party_id)
    - name: "Total Customer Lifetime Value"
      expr: SUM(customer_lifetime_value)
    - name: "Average Customer Lifetime Value"
      expr: AVG(customer_lifetime_value)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`customer_predictive_maintenance_alert`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Predictive Maintenance Alert business metrics"
  source: "`vibe_automotive_v1`.`customer`.`predictive_maintenance_alert`"
  dimensions:
    - name: "Alert Category"
      expr: alert_category
    - name: "Alert Code"
      expr: alert_code
    - name: "Alert Status"
      expr: alert_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Failure Mode"
      expr: failure_mode
    - name: "Generation Timestamp"
      expr: generation_timestamp
    - name: "Predicted Failure End"
      expr: predicted_failure_end
    - name: "Predicted Failure Start"
      expr: predicted_failure_start
    - name: "Recommended Service Action"
      expr: recommended_service_action
    - name: "Resolution Timestamp"
      expr: resolution_timestamp
    - name: "Severity"
      expr: severity
    - name: "Updated Timestamp"
      expr: updated_timestamp
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
    - name: "Generation Timestamp Month"
      expr: DATE_TRUNC('MONTH', generation_timestamp)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Predictive Maintenance Alert"
      expr: COUNT(DISTINCT predictive_maintenance_alert_id)
    - name: "Total Confidence Percentage"
      expr: SUM(confidence_percentage)
    - name: "Average Confidence Percentage"
      expr: AVG(confidence_percentage)
    - name: "Total Mileage At Alert"
      expr: SUM(mileage_at_alert)
    - name: "Average Mileage At Alert"
      expr: AVG(mileage_at_alert)
    - name: "Total Temperature Celsius"
      expr: SUM(temperature_celsius)
    - name: "Average Temperature Celsius"
      expr: AVG(temperature_celsius)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`customer_preference`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Preference business metrics"
  source: "`vibe_automotive_v1`.`customer`.`preference`"
  dimensions:
    - name: "Category"
      expr: preference_category
    - name: "Channel"
      expr: channel
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Origin System"
      expr: data_origin_system
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Is Opt Out"
      expr: is_opt_out
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "Notes"
      expr: notes
    - name: "Preference Status"
      expr: preference_status
    - name: "Source"
      expr: source
    - name: "Value Data Type"
      expr: value_data_type
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
    - name: "Effective Date Month"
      expr: DATE_TRUNC('MONTH', effective_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Preference"
      expr: COUNT(DISTINCT preference_id)
    - name: "Total Confidence Score"
      expr: SUM(confidence_score)
    - name: "Average Confidence Score"
      expr: AVG(confidence_score)
    - name: "Total Value"
      expr: SUM(value)
    - name: "Average Value"
      expr: AVG(value)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`customer_vehicle_ownership`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vehicle Ownership business metrics"
  source: "`vibe_automotive_v1`.`customer`.`vehicle_ownership`"
  dimensions:
    - name: "Acquisition Channel"
      expr: acquisition_channel
    - name: "Acquisition Date"
      expr: acquisition_date
    - name: "Acquisition Dealer Code"
      expr: acquisition_dealer_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Disposition Date"
      expr: disposition_date
    - name: "Disposition Type"
      expr: disposition_type
    - name: "Insurance Carrier"
      expr: insurance_carrier
    - name: "Insurance Expiry"
      expr: insurance_expiry
    - name: "Insurance Policy Number"
      expr: insurance_policy_number
    - name: "Is Primary Vehicle"
      expr: is_primary_vehicle
    - name: "Lien Holder Name"
      expr: lien_holder_name
    - name: "Ownership Number"
      expr: ownership_number
    - name: "Ownership Type"
      expr: ownership_type
    - name: "Registration Country"
      expr: registration_country
    - name: "Registration Expiry"
      expr: registration_expiry
    - name: "Registration Number"
      expr: registration_number
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Vehicle Ownership"
      expr: COUNT(DISTINCT vehicle_ownership_id)
    - name: "Total Current Odometer"
      expr: SUM(current_odometer)
    - name: "Average Current Odometer"
      expr: AVG(current_odometer)
    - name: "Total Disposition Odometer"
      expr: SUM(disposition_odometer)
    - name: "Average Disposition Odometer"
      expr: AVG(disposition_odometer)
    - name: "Total Odometer At Acquisition"
      expr: SUM(odometer_at_acquisition)
    - name: "Average Odometer At Acquisition"
      expr: AVG(odometer_at_acquisition)
    - name: "Total Purchase Price"
      expr: SUM(purchase_price)
    - name: "Average Purchase Price"
      expr: AVG(purchase_price)
$$;
