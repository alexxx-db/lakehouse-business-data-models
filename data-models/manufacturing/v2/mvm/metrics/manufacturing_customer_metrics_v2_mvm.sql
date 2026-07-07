-- Metric views for domain: customer | Business: Manufacturing | Version: 2 | Generated on: 2026-07-03 07:49:42

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`customer_account_site`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Account Site business metrics"
  source: "`vibe_manufacturing_v1`.`customer`.`account_site`"
  dimensions:
    - name: "Access Restriction Notes"
      expr: access_restriction_notes
    - name: "Commissioning Date"
      expr: commissioning_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Crm Site Code"
      expr: crm_site_code
    - name: "Decommission Date"
      expr: decommission_date
    - name: "Environmental Classification"
      expr: environmental_classification
    - name: "Erp Plant Code"
      expr: erp_plant_code
    - name: "Industry Segment"
      expr: industry_segment
    - name: "Installed Product Count"
      expr: installed_product_count
    - name: "Is Headquarters"
      expr: is_headquarters
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Last Site Visit Date"
      expr: last_site_visit_date
    - name: "Maximo Location Code"
      expr: maximo_location_code
    - name: "Mes System Present"
      expr: mes_system_present
    - name: "Network Connectivity Type"
      expr: network_connectivity_type
    - name: "Next Scheduled Maintenance Date"
      expr: next_scheduled_maintenance_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Account Site"
      expr: COUNT(DISTINCT account_site_id)
    - name: "Total Operates 24x7"
      expr: SUM(operates_24x7)
    - name: "Average Operates 24x7"
      expr: AVG(operates_24x7)
    - name: "Total Operational Hours End"
      expr: SUM(operational_hours_end)
    - name: "Average Operational Hours End"
      expr: AVG(operational_hours_end)
    - name: "Total Operational Hours Start"
      expr: SUM(operational_hours_start)
    - name: "Average Operational Hours Start"
      expr: AVG(operational_hours_start)
    - name: "Total Plant Floor Area Sqm"
      expr: SUM(plant_floor_area_sqm)
    - name: "Average Plant Floor Area Sqm"
      expr: AVG(plant_floor_area_sqm)
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`customer_address`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Address business metrics"
  source: "`vibe_manufacturing_v1`.`customer`.`address`"
  dimensions:
    - name: "Address Status"
      expr: address_status
    - name: "Address Type"
      expr: address_type
    - name: "Attention Line"
      expr: attention_line
    - name: "Building Name"
      expr: building_name
    - name: "City"
      expr: city
    - name: "Country Code"
      expr: country_code
    - name: "County District"
      expr: county_district
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Delivery Instructions"
      expr: delivery_instructions
    - name: "Effective From"
      expr: effective_from
    - name: "Effective Until"
      expr: effective_until
    - name: "Floor Number"
      expr: floor_number
    - name: "Geocoding Accuracy"
      expr: geocoding_accuracy
    - name: "Hazmat Certified"
      expr: hazmat_certified
    - name: "Is Primary"
      expr: is_primary
    - name: "Is Validated"
      expr: is_validated
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Address"
      expr: COUNT(DISTINCT address_id)
    - name: "Total Latitude"
      expr: SUM(latitude)
    - name: "Average Latitude"
      expr: AVG(latitude)
    - name: "Total Longitude"
      expr: SUM(longitude)
    - name: "Average Longitude"
      expr: AVG(longitude)
    - name: "Total Vat Registration Number"
      expr: SUM(vat_registration_number)
    - name: "Average Vat Registration Number"
      expr: AVG(vat_registration_number)
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`customer_contact`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contact business metrics"
  source: "`vibe_manufacturing_v1`.`customer`.`contact`"
  dimensions:
    - name: "Account Site"
      expr: account_site
    - name: "Assistant Name"
      expr: assistant_name
    - name: "Assistant Phone"
      expr: assistant_phone
    - name: "Birthdate"
      expr: birthdate
    - name: "Consent Record Code"
      expr: consent_record_code
    - name: "Contact Type"
      expr: contact_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Crm Contact Code"
      expr: crm_contact_code
    - name: "Customer Contact Status"
      expr: customer_contact_status
    - name: "Department"
      expr: department
    - name: "Do Not Call"
      expr: do_not_call
    - name: "Email"
      expr: email
    - name: "Email Opt Out"
      expr: email_opt_out
    - name: "Fax"
      expr: fax
    - name: "First Name"
      expr: first_name
    - name: "Gdpr Data Subject Code"
      expr: gdpr_data_subject_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Contact"
      expr: COUNT(DISTINCT contact_id)
    - name: "Total Data Quality Score"
      expr: SUM(data_quality_score)
    - name: "Average Data Quality Score"
      expr: AVG(data_quality_score)
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`customer_credit_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Credit Profile business metrics"
  source: "`vibe_manufacturing_v1`.`customer`.`credit_profile`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Approved By"
      expr: approved_by
    - name: "Bank Account Verified Flag"
      expr: bank_account_verified_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Credit Hold Date"
      expr: credit_hold_date
    - name: "Credit Hold Flag"
      expr: credit_hold_flag
    - name: "Credit Hold Released Date"
      expr: credit_hold_released_date
    - name: "Credit Insurance Expiry Date"
      expr: credit_insurance_expiry_date
    - name: "Currency Code"
      expr: currency_code
    - name: "Dunning Level"
      expr: dunning_level
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Last Credit Review Date"
      expr: last_credit_review_date
    - name: "Last Dunning Date"
      expr: last_dunning_date
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "Next Credit Review Date"
      expr: next_credit_review_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Credit Profile"
      expr: COUNT(DISTINCT credit_profile_id)
    - name: "Total Bad Debt Provision Amount"
      expr: SUM(bad_debt_provision_amount)
    - name: "Average Bad Debt Provision Amount"
      expr: AVG(bad_debt_provision_amount)
    - name: "Total Collection Strategy Code"
      expr: SUM(collection_strategy_code)
    - name: "Average Collection Strategy Code"
      expr: AVG(collection_strategy_code)
    - name: "Total Credit Account Type"
      expr: SUM(credit_account_type)
    - name: "Average Credit Account Type"
      expr: AVG(credit_account_type)
    - name: "Total Credit Control Area"
      expr: SUM(credit_control_area)
    - name: "Average Credit Control Area"
      expr: AVG(credit_control_area)
    - name: "Total Credit Hold Reason"
      expr: SUM(credit_hold_reason)
    - name: "Average Credit Hold Reason"
      expr: AVG(credit_hold_reason)
    - name: "Total Credit Insurance Coverage Limit"
      expr: SUM(credit_insurance_coverage_limit)
    - name: "Average Credit Insurance Coverage Limit"
      expr: AVG(credit_insurance_coverage_limit)
    - name: "Total Credit Insurance Policy Number"
      expr: SUM(credit_insurance_policy_number)
    - name: "Average Credit Insurance Policy Number"
      expr: AVG(credit_insurance_policy_number)
    - name: "Total Credit Insurance Provider"
      expr: SUM(credit_insurance_provider)
    - name: "Average Credit Insurance Provider"
      expr: AVG(credit_insurance_provider)
    - name: "Total Credit Limit"
      expr: SUM(credit_limit)
    - name: "Average Credit Limit"
      expr: AVG(credit_limit)
    - name: "Total Credit Notes"
      expr: SUM(credit_notes)
    - name: "Average Credit Notes"
      expr: AVG(credit_notes)
    - name: "Total Credit Rating"
      expr: SUM(credit_rating)
    - name: "Average Credit Rating"
      expr: AVG(credit_rating)
    - name: "Total Credit Rating Agency"
      expr: SUM(credit_rating_agency)
    - name: "Average Credit Rating Agency"
      expr: AVG(credit_rating_agency)
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`customer_customer_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer Account business metrics"
  source: "`vibe_manufacturing_v1`.`customer`.`customer_account`"
  dimensions:
    - name: "Account Name"
      expr: account_name
    - name: "Account Source"
      expr: account_source
    - name: "Account Status"
      expr: account_status
    - name: "Account Type"
      expr: account_type
    - name: "Billing City"
      expr: billing_city
    - name: "Billing Country Code"
      expr: billing_country_code
    - name: "Billing Postal Code"
      expr: billing_postal_code
    - name: "Billing State Province"
      expr: billing_state_province
    - name: "Close Date"
      expr: close_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Crm Account Code"
      expr: crm_account_code
    - name: "Distribution Channel Code"
      expr: distribution_channel_code
    - name: "Duns Number"
      expr: duns_number
    - name: "Employee Count"
      expr: employee_count
    - name: "Incoterms Code"
      expr: incoterms_code
    - name: "Industry Naics Code"
      expr: industry_naics_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Customer Account"
      expr: COUNT(DISTINCT customer_account_id)
    - name: "Total Annual Revenue"
      expr: SUM(annual_revenue)
    - name: "Average Annual Revenue"
      expr: AVG(annual_revenue)
    - name: "Total Credit Limit"
      expr: SUM(credit_limit)
    - name: "Average Credit Limit"
      expr: AVG(credit_limit)
    - name: "Total Credit Limit Currency Code"
      expr: SUM(credit_limit_currency_code)
    - name: "Average Credit Limit Currency Code"
      expr: AVG(credit_limit_currency_code)
    - name: "Total Credit Rating"
      expr: SUM(credit_rating)
    - name: "Average Credit Rating"
      expr: AVG(credit_rating)
    - name: "Total Data Quality Score"
      expr: SUM(data_quality_score)
    - name: "Average Data Quality Score"
      expr: AVG(data_quality_score)
    - name: "Total Revenue Currency Code"
      expr: SUM(revenue_currency_code)
    - name: "Average Revenue Currency Code"
      expr: AVG(revenue_currency_code)
    - name: "Total Vat Registration Number"
      expr: SUM(vat_registration_number)
    - name: "Average Vat Registration Number"
      expr: AVG(vat_registration_number)
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`customer_interaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Interaction business metrics"
  source: "`vibe_manufacturing_v1`.`customer`.`interaction`"
  dimensions:
    - name: "Capa Reference"
      expr: capa_reference
    - name: "Channel"
      expr: channel
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Crm Activity Code"
      expr: crm_activity_code
    - name: "Description"
      expr: description
    - name: "End Timestamp"
      expr: end_timestamp
    - name: "External Participants"
      expr: external_participants
    - name: "Follow Up Action"
      expr: follow_up_action
    - name: "Follow Up Due Date"
      expr: follow_up_due_date
    - name: "Follow Up Required"
      expr: follow_up_required
    - name: "Interaction Date"
      expr: interaction_date
    - name: "Interaction Status"
      expr: interaction_status
    - name: "Interaction Type"
      expr: interaction_type
    - name: "Internal Participants"
      expr: internal_participants
    - name: "Is Customer Complaint"
      expr: is_customer_complaint
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Interaction"
      expr: COUNT(DISTINCT interaction_id)
    - name: "Total Campaign Code"
      expr: SUM(campaign_code)
    - name: "Average Campaign Code"
      expr: AVG(campaign_code)
    - name: "Total Duration Minutes"
      expr: SUM(duration_minutes)
    - name: "Average Duration Minutes"
      expr: AVG(duration_minutes)
    - name: "Total Verbatim Feedback"
      expr: SUM(verbatim_feedback)
    - name: "Average Verbatim Feedback"
      expr: AVG(verbatim_feedback)
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`customer_lead`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lead business metrics"
  source: "`vibe_manufacturing_v1`.`customer`.`lead`"
  dimensions:
    - name: "Buying Stage"
      expr: buying_stage
    - name: "Campaign Code"
      expr: campaign_code
    - name: "City"
      expr: city
    - name: "Company Industry"
      expr: company_industry
    - name: "Company Name"
      expr: company_name
    - name: "Company Size"
      expr: company_size
    - name: "Conversion Date"
      expr: conversion_date
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Source"
      expr: data_source
    - name: "Disqualification Reason"
      expr: disqualification_reason
    - name: "Do Not Contact"
      expr: do_not_contact
    - name: "Email"
      expr: email
    - name: "Email Opt Out"
      expr: email_opt_out
    - name: "Estimated Close Date"
      expr: estimated_close_date
    - name: "Existing Automation Vendor"
      expr: existing_automation_vendor
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Lead"
      expr: COUNT(DISTINCT lead_id)
    - name: "Total Annual Energy Consumption Mwh"
      expr: SUM(annual_energy_consumption_mwh)
    - name: "Average Annual Energy Consumption Mwh"
      expr: AVG(annual_energy_consumption_mwh)
    - name: "Total Estimated Annual Revenue"
      expr: SUM(estimated_annual_revenue)
    - name: "Average Estimated Annual Revenue"
      expr: AVG(estimated_annual_revenue)
    - name: "Total Estimated Deal Value"
      expr: SUM(estimated_deal_value)
    - name: "Average Estimated Deal Value"
      expr: AVG(estimated_deal_value)
    - name: "Total Revenue Currency"
      expr: SUM(revenue_currency)
    - name: "Average Revenue Currency"
      expr: AVG(revenue_currency)
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`customer_segment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Segment business metrics"
  source: "`vibe_manufacturing_v1`.`customer`.`segment`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Approved By"
      expr: approved_by
    - name: "Assigned Segment Manager"
      expr: assigned_segment_manager
    - name: "Channel Type"
      expr: channel_type
    - name: "Code"
      expr: code
    - name: "Contract Required"
      expr: contract_required
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Criteria"
      expr: criteria
    - name: "Crm Segment Record Code"
      expr: crm_segment_record_code
    - name: "Customer Account Type"
      expr: customer_account_type
    - name: "Dedicated Account Manager Required"
      expr: dedicated_account_manager_required
    - name: "Description"
      expr: description
    - name: "Effective From Date"
      expr: effective_from_date
    - name: "Effective Until Date"
      expr: effective_until_date
    - name: "Erp Customer Group Code"
      expr: erp_customer_group_code
    - name: "Geographic Region"
      expr: geographic_region
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Segment"
      expr: COUNT(DISTINCT segment_id)
    - name: "Total Credit Limit Usd"
      expr: SUM(credit_limit_usd)
    - name: "Average Credit Limit Usd"
      expr: AVG(credit_limit_usd)
    - name: "Total Discount Rate Pct"
      expr: SUM(discount_rate_pct)
    - name: "Average Discount Rate Pct"
      expr: AVG(discount_rate_pct)
    - name: "Total Payment Terms Code"
      expr: SUM(payment_terms_code)
    - name: "Average Payment Terms Code"
      expr: AVG(payment_terms_code)
    - name: "Total Revenue Band Currency"
      expr: SUM(revenue_band_currency)
    - name: "Average Revenue Band Currency"
      expr: AVG(revenue_band_currency)
    - name: "Total Revenue Band Max"
      expr: SUM(revenue_band_max)
    - name: "Average Revenue Band Max"
      expr: AVG(revenue_band_max)
    - name: "Total Revenue Band Min"
      expr: SUM(revenue_band_min)
    - name: "Average Revenue Band Min"
      expr: AVG(revenue_band_min)
    - name: "Total Target Gross Margin Pct"
      expr: SUM(target_gross_margin_pct)
    - name: "Average Target Gross Margin Pct"
      expr: AVG(target_gross_margin_pct)
    - name: "Total Target Revenue Usd"
      expr: SUM(target_revenue_usd)
    - name: "Average Target Revenue Usd"
      expr: AVG(target_revenue_usd)
$$;