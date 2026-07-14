-- Metric views for domain: customer | Business: Automotive | Version: 2 | Generated on: 2026-07-14 01:48:21

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
    - name: "Case Category"
      expr: case_category
    - name: "Closed Timestamp"
      expr: closed_timestamp
    - name: "Customer Satisfaction Score"
      expr: customer_satisfaction_score
    - name: "Dealer Code"
      expr: dealer_code
    - name: "Case Description"
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

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`customer_cltv_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cltv Record business metrics"
  source: "`vibe_automotive_v1`.`customer`.`cltv_record`"
  dimensions:
    - name: "Calculation Date"
      expr: calculation_date
    - name: "Calculation Status"
      expr: calculation_status
    - name: "Cltv Horizon Months"
      expr: cltv_horizon_months
    - name: "Model Version"
      expr: model_version
    - name: "Projected Vehicle Purchases"
      expr: projected_vehicle_purchases
    - name: "Record Created Timestamp"
      expr: record_created_timestamp
    - name: "Record Updated Timestamp"
      expr: record_updated_timestamp
    - name: "Segment At Calculation"
      expr: segment_at_calculation
    - name: "Calculation Date Month"
      expr: DATE_TRUNC('MONTH', calculation_date)
    - name: "Record Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', record_created_timestamp)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Cltv Record"
      expr: COUNT(DISTINCT cltv_record_id)
    - name: "Total Churn Probability"
      expr: SUM(churn_probability)
    - name: "Average Churn Probability"
      expr: AVG(churn_probability)
    - name: "Total Cltv Amount"
      expr: SUM(cltv_amount)
    - name: "Average Cltv Amount"
      expr: AVG(cltv_amount)
    - name: "Total Data Completeness Score"
      expr: SUM(data_completeness_score)
    - name: "Average Data Completeness Score"
      expr: AVG(data_completeness_score)
    - name: "Total Discount Rate"
      expr: SUM(discount_rate)
    - name: "Average Discount Rate"
      expr: AVG(discount_rate)
    - name: "Total Projected Accessories Revenue"
      expr: SUM(projected_accessories_revenue)
    - name: "Average Projected Accessories Revenue"
      expr: AVG(projected_accessories_revenue)
    - name: "Total Projected Connected Services Revenue"
      expr: SUM(projected_connected_services_revenue)
    - name: "Average Projected Connected Services Revenue"
      expr: AVG(projected_connected_services_revenue)
    - name: "Total Projected Finance Revenue"
      expr: SUM(projected_finance_revenue)
    - name: "Average Projected Finance Revenue"
      expr: AVG(projected_finance_revenue)
    - name: "Total Projected Parts Revenue"
      expr: SUM(projected_parts_revenue)
    - name: "Average Projected Parts Revenue"
      expr: AVG(projected_parts_revenue)
    - name: "Total Projected Service Revenue"
      expr: SUM(projected_service_revenue)
    - name: "Average Projected Service Revenue"
      expr: AVG(projected_service_revenue)
    - name: "Total Retention Probability"
      expr: SUM(retention_probability)
    - name: "Average Retention Probability"
      expr: AVG(retention_probability)
    - name: "Total Revenue To Date"
      expr: SUM(revenue_to_date)
    - name: "Average Revenue To Date"
      expr: AVG(revenue_to_date)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`customer_communication_subscription`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Communication Subscription business metrics"
  source: "`vibe_automotive_v1`.`customer`.`communication_subscription`"
  dimensions:
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Dealer Code"
      expr: dealer_code
    - name: "Delivery Channel"
      expr: delivery_channel
    - name: "External Subscription Code"
      expr: external_subscription_code
    - name: "Frequency"
      expr: frequency
    - name: "Is Test"
      expr: is_test
    - name: "Language"
      expr: language
    - name: "Last Sent Timestamp"
      expr: last_sent_timestamp
    - name: "Marketing Cloud Key"
      expr: marketing_cloud_key
    - name: "Next Scheduled Send"
      expr: next_scheduled_send
    - name: "Subscription Date"
      expr: subscription_date
    - name: "Subscription Status"
      expr: subscription_status
    - name: "Subscription Type"
      expr: subscription_type
    - name: "Unsubscribe Date"
      expr: unsubscribe_date
    - name: "Unsubscribe Reason"
      expr: unsubscribe_reason
    - name: "Updated Timestamp"
      expr: updated_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Communication Subscription"
      expr: COUNT(DISTINCT communication_subscription_id)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`customer_connected_service_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Connected Service Enrollment business metrics"
  source: "`vibe_automotive_v1`.`customer`.`connected_service_enrollment`"
  dimensions:
    - name: "Activation Date"
      expr: activation_date
    - name: "Auto Renew"
      expr: auto_renew
    - name: "Billing Cycle"
      expr: billing_cycle
    - name: "Connected App User Reference"
      expr: connected_app_user_reference
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Device Imei"
      expr: device_imei
    - name: "Enrollment Channel"
      expr: enrollment_channel
    - name: "Enrollment Date"
      expr: enrollment_date
    - name: "Enrollment Reference Code"
      expr: enrollment_reference_code
    - name: "Enrollment Status"
      expr: enrollment_status
    - name: "Last Ota Update Timestamp"
      expr: last_ota_update_timestamp
    - name: "Price Currency"
      expr: price_currency
    - name: "Service Plan Code"
      expr: service_plan_code
    - name: "Service Type"
      expr: service_type
    - name: "Sim Iccid"
      expr: sim_iccid
    - name: "Status Reason"
      expr: status_reason
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Connected Service Enrollment"
      expr: COUNT(DISTINCT connected_service_enrollment_id)
    - name: "Total Data Plan Gb"
      expr: SUM(data_plan_gb)
    - name: "Average Data Plan Gb"
      expr: AVG(data_plan_gb)
    - name: "Total Data Usage Gb"
      expr: SUM(data_usage_gb)
    - name: "Average Data Usage Gb"
      expr: AVG(data_usage_gb)
    - name: "Total Monthly Fee"
      expr: SUM(monthly_fee)
    - name: "Average Monthly Fee"
      expr: AVG(monthly_fee)
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

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`customer_customer_consent_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer Consent Record business metrics"
  source: "`vibe_automotive_v1`.`customer`.`customer_consent_record`"
  dimensions:
    - name: "Consent Channel"
      expr: consent_channel
    - name: "Consent Expiry Date"
      expr: consent_expiry_date
    - name: "Consent Granted Timestamp"
      expr: consent_granted_timestamp
    - name: "Consent Status"
      expr: consent_status
    - name: "Consent Type"
      expr: consent_type
    - name: "Consent Withdrawn Timestamp"
      expr: consent_withdrawn_timestamp
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Legal Basis"
      expr: legal_basis
    - name: "Opt In Flag"
      expr: opt_in_flag
    - name: "Purpose"
      expr: purpose
    - name: "Updated Timestamp"
      expr: updated_timestamp
    - name: "Consent Expiry Date Month"
      expr: DATE_TRUNC('MONTH', consent_expiry_date)
    - name: "Consent Granted Timestamp Month"
      expr: DATE_TRUNC('MONTH', consent_granted_timestamp)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Customer Consent Record"
      expr: COUNT(DISTINCT customer_consent_record_id)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`customer_customer_fleet_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer Fleet Account business metrics"
  source: "`vibe_automotive_v1`.`customer`.`customer_fleet_account`"
  dimensions:
    - name: "All Records"
      expr: "1"
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Customer Fleet Account"
      expr: COUNT(DISTINCT customer_fleet_account_id)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`customer_customer_fleet_vehicle_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer Fleet Vehicle Assignment business metrics"
  source: "`vibe_automotive_v1`.`customer`.`customer_fleet_vehicle_assignment`"
  dimensions:
    - name: "All Records"
      expr: "1"
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Customer Fleet Vehicle Assignment"
      expr: COUNT(DISTINCT customer_fleet_vehicle_assignment_id)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`customer_customer_segment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer Segment business metrics"
  source: "`vibe_automotive_v1`.`customer`.`customer_segment`"
  dimensions:
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Customer Segment Description"
      expr: customer_segment_description
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Geographic Scope"
      expr: geographic_scope
    - name: "Is Active"
      expr: is_active
    - name: "Last Review Date"
      expr: last_review_date
    - name: "Model Year End"
      expr: model_year_end
    - name: "Model Year Start"
      expr: model_year_start
    - name: "Owner"
      expr: owner
    - name: "Primary Vehicle Interest"
      expr: primary_vehicle_interest
    - name: "Priority"
      expr: priority
    - name: "Qualifying Criteria Summary"
      expr: qualifying_criteria_summary
    - name: "Revenue Potential Band"
      expr: revenue_potential_band
    - name: "Segment Category"
      expr: segment_category
    - name: "Segment Code"
      expr: segment_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Customer Segment"
      expr: COUNT(DISTINCT customer_segment_id)
    - name: "Total Confidence Score"
      expr: SUM(confidence_score)
    - name: "Average Confidence Score"
      expr: AVG(confidence_score)
    - name: "Total Estimated Segment Size"
      expr: SUM(estimated_segment_size)
    - name: "Average Estimated Segment Size"
      expr: AVG(estimated_segment_size)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`customer_customer_test_drive`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer Test Drive business metrics"
  source: "`vibe_automotive_v1`.`customer`.`customer_test_drive`"
  dimensions:
    - name: "All Records"
      expr: "1"
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Customer Test Drive"
      expr: COUNT(DISTINCT customer_test_drive_id)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`customer_dealer_customer_link`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dealer Customer Link business metrics"
  source: "`vibe_automotive_v1`.`customer`.`dealer_customer_link`"
  dimensions:
    - name: "Assignment Method"
      expr: assignment_method
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Dealer Code"
      expr: dealer_code
    - name: "Dealer Customer Link Status"
      expr: dealer_customer_link_status
    - name: "Is Primary"
      expr: is_primary
    - name: "Last Service Date"
      expr: last_service_date
    - name: "Notes"
      expr: notes
    - name: "Relationship End Date"
      expr: relationship_end_date
    - name: "Relationship Number"
      expr: relationship_number
    - name: "Relationship Start Date"
      expr: relationship_start_date
    - name: "Relationship Type"
      expr: relationship_type
    - name: "Salesforce Account Dealer Reference"
      expr: salesforce_account_dealer_reference
    - name: "Total Service Visits"
      expr: total_service_visits
    - name: "Updated Timestamp"
      expr: updated_timestamp
    - name: "Vin"
      expr: vin
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Dealer Customer Link"
      expr: COUNT(DISTINCT dealer_customer_link_id)
    - name: "Total Total Spend At Dealer"
      expr: SUM(total_spend_at_dealer)
    - name: "Average Total Spend At Dealer"
      expr: AVG(total_spend_at_dealer)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`customer_household`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Household business metrics"
  source: "`vibe_automotive_v1`.`customer`.`household`"
  dimensions:
    - name: "Address Line2"
      expr: address_line2
    - name: "Census Block"
      expr: census_block
    - name: "City"
      expr: city
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Estimated Income Band"
      expr: estimated_income_band
    - name: "Formation Date"
      expr: formation_date
    - name: "Household Status"
      expr: household_status
    - name: "Household Type"
      expr: household_type
    - name: "Last Contact Date"
      expr: last_contact_date
    - name: "Marketing Opt In"
      expr: marketing_opt_in
    - name: "Member Count"
      expr: member_count
    - name: "Household Name"
      expr: household_name
    - name: "Notes"
      expr: notes
    - name: "Nps Score"
      expr: nps_score
    - name: "Postal Code"
      expr: postal_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Household"
      expr: COUNT(DISTINCT household_id)
    - name: "Total Cltv"
      expr: SUM(cltv)
    - name: "Average Cltv"
      expr: AVG(cltv)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`customer_identity_resolution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Identity Resolution business metrics"
  source: "`vibe_automotive_v1`.`customer`.`identity_resolution`"
  dimensions:
    - name: "Match Method"
      expr: match_method
    - name: "Match Rule Set Version"
      expr: match_rule_set_version
    - name: "Matched Attributes"
      expr: matched_attributes
    - name: "Record Audit Created"
      expr: record_audit_created
    - name: "Record Audit Updated"
      expr: record_audit_updated
    - name: "Rejection Reason"
      expr: rejection_reason
    - name: "Resolution Action"
      expr: resolution_action
    - name: "Resolution Date"
      expr: resolution_date
    - name: "Resolved By"
      expr: resolved_by
    - name: "Review Status"
      expr: review_status
    - name: "Source System A"
      expr: source_system_a
    - name: "Source System B"
      expr: source_system_b
    - name: "Record Audit Created Month"
      expr: DATE_TRUNC('MONTH', record_audit_created)
    - name: "Record Audit Updated Month"
      expr: DATE_TRUNC('MONTH', record_audit_updated)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Identity Resolution"
      expr: COUNT(DISTINCT identity_resolution_id)
    - name: "Total Match Confidence Score"
      expr: SUM(match_confidence_score)
    - name: "Average Match Confidence Score"
      expr: AVG(match_confidence_score)
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

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`customer_journey_touchpoint`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Journey Touchpoint business metrics"
  source: "`vibe_automotive_v1`.`customer`.`journey_touchpoint`"
  dimensions:
    - name: "Channel"
      expr: channel
    - name: "Connected App Code"
      expr: connected_app_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Dealer Code"
      expr: dealer_code
    - name: "Device Type"
      expr: device_type
    - name: "Duration Seconds"
      expr: duration_seconds
    - name: "Event Source"
      expr: event_source
    - name: "Feedback Comments"
      expr: feedback_comments
    - name: "Feedback Score"
      expr: feedback_score
    - name: "Interaction Outcome"
      expr: interaction_outcome
    - name: "Ip Address"
      expr: ip_address
    - name: "Is Assisted"
      expr: is_assisted
    - name: "Location City"
      expr: location_city
    - name: "Location Country"
      expr: location_country
    - name: "Location State"
      expr: location_state
    - name: "Loyalty Points Redeemed"
      expr: loyalty_points_redeemed
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Journey Touchpoint"
      expr: COUNT(DISTINCT journey_touchpoint_id)
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

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`customer_loyalty_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Loyalty Program business metrics"
  source: "`vibe_automotive_v1`.`customer`.`loyalty_program`"
  dimensions:
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Loyalty Program Description"
      expr: loyalty_program_description
    - name: "Eligibility Criteria"
      expr: eligibility_criteria
    - name: "End Date"
      expr: end_date
    - name: "Enrollment End Date"
      expr: enrollment_end_date
    - name: "Enrollment Start Date"
      expr: enrollment_start_date
    - name: "Is Partner Program"
      expr: is_partner_program
    - name: "Last Review Date"
      expr: last_review_date
    - name: "Loyalty Program Status"
      expr: loyalty_program_status
    - name: "Loyalty Program Type"
      expr: loyalty_program_type
    - name: "Loyalty Program Name"
      expr: loyalty_program_name
    - name: "Notes"
      expr: notes
    - name: "Partner Redemption Options"
      expr: partner_redemption_options
    - name: "Points Earn Rate Currency"
      expr: points_earn_rate_currency
    - name: "Points Expiry Months"
      expr: points_expiry_months
    - name: "Points Redemption Currency"
      expr: points_redemption_currency
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Loyalty Program"
      expr: COUNT(DISTINCT loyalty_program_id)
    - name: "Total Earn Rate Points Per Dollar"
      expr: SUM(earn_rate_points_per_dollar)
    - name: "Average Earn Rate Points Per Dollar"
      expr: AVG(earn_rate_points_per_dollar)
    - name: "Total Min Redemption Points"
      expr: SUM(min_redemption_points)
    - name: "Average Min Redemption Points"
      expr: AVG(min_redemption_points)
    - name: "Total Redemption Rate Points Per Dollar"
      expr: SUM(redemption_rate_points_per_dollar)
    - name: "Average Redemption Rate Points Per Dollar"
      expr: AVG(redemption_rate_points_per_dollar)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`customer_loyalty_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Loyalty Transaction business metrics"
  source: "`vibe_automotive_v1`.`customer`.`loyalty_transaction`"
  dimensions:
    - name: "Approval Status"
      expr: approval_status
    - name: "Channel"
      expr: channel
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Dealer Code"
      expr: dealer_code
    - name: "Notes"
      expr: notes
    - name: "Points Amount"
      expr: points_amount
    - name: "Points Balance After"
      expr: points_balance_after
    - name: "Points Expiry Date"
      expr: points_expiry_date
    - name: "Reference Document Number"
      expr: reference_document_number
    - name: "Transaction Number"
      expr: transaction_number
    - name: "Transaction Status"
      expr: transaction_status
    - name: "Transaction Timestamp"
      expr: transaction_timestamp
    - name: "Transaction Type"
      expr: transaction_type
    - name: "Triggering Event Type"
      expr: triggering_event_type
    - name: "Updated Timestamp"
      expr: updated_timestamp
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Loyalty Transaction"
      expr: COUNT(DISTINCT loyalty_transaction_id)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`customer_nps_response`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Nps Response business metrics"
  source: "`vibe_automotive_v1`.`customer`.`nps_response`"
  dimensions:
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Dealer Code"
      expr: dealer_code
    - name: "Follow Up Required Flag"
      expr: follow_up_required_flag
    - name: "Follow Up Status"
      expr: follow_up_status
    - name: "Nps Response Status"
      expr: nps_response_status
    - name: "Nps Score"
      expr: nps_score
    - name: "Promoter Category"
      expr: promoter_category
    - name: "Response Date"
      expr: response_date
    - name: "Salesforce Survey Response Reference"
      expr: salesforce_survey_response_reference
    - name: "Survey Channel"
      expr: survey_channel
    - name: "Survey Date"
      expr: survey_date
    - name: "Survey Type"
      expr: survey_type
    - name: "Touchpoint"
      expr: touchpoint
    - name: "Updated Timestamp"
      expr: updated_timestamp
    - name: "Verbatim Comment"
      expr: verbatim_comment
    - name: "Vin"
      expr: vin
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Nps Response"
      expr: COUNT(DISTINCT nps_response_id)
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
    - name: "Address Line1"
      expr: address_line1
    - name: "Address Line2"
      expr: address_line2
    - name: "City"
      expr: city
    - name: "Classification"
      expr: classification
    - name: "Contract Vehicle Type"
      expr: contract_vehicle_type
    - name: "Country"
      expr: country
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

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`customer_party_relationship`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Party Relationship business metrics"
  source: "`vibe_automotive_v1`.`customer`.`party_relationship`"
  dimensions:
    - name: "Authorization Level"
      expr: authorization_level
    - name: "Compliance Status"
      expr: compliance_status
    - name: "Contract Reference"
      expr: contract_reference
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Party Relationship Description"
      expr: party_relationship_description
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Inverse Role"
      expr: inverse_role
    - name: "Is Legal Entity"
      expr: is_legal_entity
    - name: "Is Primary"
      expr: is_primary
    - name: "Jurisdiction"
      expr: jurisdiction
    - name: "Last Review Date"
      expr: last_review_date
    - name: "Party Relationship Status"
      expr: party_relationship_status
    - name: "Relationship Role"
      expr: relationship_role
    - name: "Relationship Strength"
      expr: relationship_strength
    - name: "Relationship Type"
      expr: relationship_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Party Relationship"
      expr: COUNT(DISTINCT party_relationship_id)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`customer_pdi_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pdi Record business metrics"
  source: "`vibe_automotive_v1`.`customer`.`pdi_record`"
  dimensions:
    - name: "Connected Services Activated"
      expr: connected_services_activated
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Customer Signature Date"
      expr: customer_signature_date
    - name: "Customer Walkthrough Completed"
      expr: customer_walkthrough_completed
    - name: "Dealer Code"
      expr: dealer_code
    - name: "Delivery Date"
      expr: delivery_date
    - name: "Floor Mat Count"
      expr: floor_mat_count
    - name: "Inspection Checklist Version"
      expr: inspection_checklist_version
    - name: "Inspection Items Json"
      expr: inspection_items_json
    - name: "Key Count"
      expr: key_count
    - name: "Notes"
      expr: notes
    - name: "Ota Baseline Version"
      expr: ota_baseline_version
    - name: "Overall Pass"
      expr: overall_pass
    - name: "Owner Manual Provided"
      expr: owner_manual_provided
    - name: "Pdi Date"
      expr: pdi_date
    - name: "Pdi Number"
      expr: pdi_number
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Pdi Record"
      expr: COUNT(DISTINCT pdi_record_id)
    - name: "Total Fuel Level Percent"
      expr: SUM(fuel_level_percent)
    - name: "Average Fuel Level Percent"
      expr: AVG(fuel_level_percent)
    - name: "Total Odometer Km"
      expr: SUM(odometer_km)
    - name: "Average Odometer Km"
      expr: AVG(odometer_km)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`customer_preference`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Preference business metrics"
  source: "`vibe_automotive_v1`.`customer`.`preference`"
  dimensions:
    - name: "Preference Category"
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

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`customer_privacy_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Privacy Request business metrics"
  source: "`vibe_automotive_v1`.`customer`.`privacy_request`"
  dimensions:
    - name: "Completion Date"
      expr: completion_date
    - name: "Data Domains Affected"
      expr: data_domains_affected
    - name: "Due Date"
      expr: due_date
    - name: "Fulfillment Notes"
      expr: fulfillment_notes
    - name: "Is High Risk"
      expr: is_high_risk
    - name: "Priority"
      expr: priority
    - name: "Record Audit Created"
      expr: record_audit_created
    - name: "Record Audit Updated"
      expr: record_audit_updated
    - name: "Regulatory Basis"
      expr: regulatory_basis
    - name: "Rejection Reason"
      expr: rejection_reason
    - name: "Request Number"
      expr: request_number
    - name: "Request Status"
      expr: request_status
    - name: "Request Type"
      expr: request_type
    - name: "Submission Channel"
      expr: submission_channel
    - name: "Submission Date"
      expr: submission_date
    - name: "Systems Notified"
      expr: systems_notified
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Privacy Request"
      expr: COUNT(DISTINCT privacy_request_id)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`customer_promotion`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Promotion business metrics"
  source: "`vibe_automotive_v1`.`customer`.`promotion`"
  dimensions:
    - name: "Applicable Geographies"
      expr: applicable_geographies
    - name: "Applicable Vehicle Models"
      expr: applicable_vehicle_models
    - name: "Channel"
      expr: channel
    - name: "Promotion Code"
      expr: promotion_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Customer Segment"
      expr: customer_segment
    - name: "Discount Type"
      expr: discount_type
    - name: "Eligibility Criteria"
      expr: eligibility_criteria
    - name: "End Date"
      expr: end_date
    - name: "Is Exclusive"
      expr: is_exclusive
    - name: "Loyalty Program Flag"
      expr: loyalty_program_flag
    - name: "Promotion Name"
      expr: promotion_name
    - name: "Priority"
      expr: priority
    - name: "Promotion Type"
      expr: promotion_type
    - name: "Promotional Message"
      expr: promotional_message
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Promotion"
      expr: COUNT(DISTINCT promotion_id)
    - name: "Total Budget Amount"
      expr: SUM(budget_amount)
    - name: "Average Budget Amount"
      expr: AVG(budget_amount)
    - name: "Total Cltv Impact Estimate"
      expr: SUM(cltv_impact_estimate)
    - name: "Average Cltv Impact Estimate"
      expr: AVG(cltv_impact_estimate)
    - name: "Total Discount Value"
      expr: SUM(discount_value)
    - name: "Average Discount Value"
      expr: AVG(discount_value)
    - name: "Total Max Discount Amount"
      expr: SUM(max_discount_amount)
    - name: "Average Max Discount Amount"
      expr: AVG(max_discount_amount)
    - name: "Total Min Purchase Amount"
      expr: SUM(min_purchase_amount)
    - name: "Average Min Purchase Amount"
      expr: AVG(min_purchase_amount)
    - name: "Total Nps Impact Estimate"
      expr: SUM(nps_impact_estimate)
    - name: "Average Nps Impact Estimate"
      expr: AVG(nps_impact_estimate)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`customer_segment_membership`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Segment Membership business metrics"
  source: "`vibe_automotive_v1`.`customer`.`segment_membership`"
  dimensions:
    - name: "Assigned By"
      expr: assigned_by
    - name: "Assignment Date"
      expr: assignment_date
    - name: "Assignment Method"
      expr: assignment_method
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Is Primary Segment"
      expr: is_primary_segment
    - name: "Model Version"
      expr: model_version
    - name: "Updated Timestamp"
      expr: updated_timestamp
    - name: "Assignment Date Month"
      expr: DATE_TRUNC('MONTH', assignment_date)
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Segment Membership"
      expr: COUNT(DISTINCT segment_membership_id)
    - name: "Total Confidence Score"
      expr: SUM(confidence_score)
    - name: "Average Confidence Score"
      expr: AVG(confidence_score)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`customer_survey`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Survey business metrics"
  source: "`vibe_automotive_v1`.`customer`.`survey`"
  dimensions:
    - name: "Survey Category"
      expr: survey_category
    - name: "Channel"
      expr: channel
    - name: "Confidentiality Level"
      expr: confidentiality_level
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Survey Description"
      expr: survey_description
    - name: "Effective From"
      expr: effective_from
    - name: "Effective Until"
      expr: effective_until
    - name: "Incentive Type"
      expr: incentive_type
    - name: "Is Anonymous"
      expr: is_anonymous
    - name: "Is Mandatory"
      expr: is_mandatory
    - name: "Language"
      expr: language
    - name: "Max Responses Allowed"
      expr: max_responses_allowed
    - name: "Survey Name"
      expr: survey_name
    - name: "Owner Contact Email"
      expr: owner_contact_email
    - name: "Owner Contact Phone"
      expr: owner_contact_phone
    - name: "Owner Department"
      expr: owner_department
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Survey"
      expr: COUNT(DISTINCT survey_id)
    - name: "Total Incentive Value"
      expr: SUM(incentive_value)
    - name: "Average Incentive Value"
      expr: AVG(incentive_value)
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