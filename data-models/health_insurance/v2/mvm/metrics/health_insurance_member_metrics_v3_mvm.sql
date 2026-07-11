-- Metric views for domain: member | Business: Health_Insurance | Version: 3 | Generated on: 2026-07-10 22:45:16

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`member_address`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Address business metrics"
  source: "`vibe_health_insurance_v1`.`member`.`address`"
  dimensions:
    - name: "Address Type"
      expr: address_type
    - name: "Census Tract"
      expr: census_tract
    - name: "Change Reason"
      expr: change_reason
    - name: "City"
      expr: city
    - name: "Country Code"
      expr: country_code
    - name: "County Fips"
      expr: county_fips
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective Date"
      expr: effective_date
    - name: "External Code"
      expr: external_code
    - name: "Geocode Accuracy Meters"
      expr: geocode_accuracy_meters
    - name: "Is Primary"
      expr: is_primary
    - name: "Line1"
      expr: line1
    - name: "Line2"
      expr: line2
    - name: "Line3"
      expr: line3
    - name: "Line4"
      expr: line4
    - name: "Member Address Status"
      expr: member_address_status
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
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`member_cob_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cob Record business metrics"
  source: "`vibe_health_insurance_v1`.`member`.`cob_record`"
  dimensions:
    - name: "Birthday Rule Applicable"
      expr: birthday_rule_applicable
    - name: "Cob Order"
      expr: cob_order
    - name: "Cob Status"
      expr: cob_status
    - name: "Cob Verification Date"
      expr: cob_verification_date
    - name: "Coordination Of Benefits Rule"
      expr: coordination_of_benefits_rule
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective Date"
      expr: effective_date
    - name: "Is Msp Compliant"
      expr: is_msp_compliant
    - name: "Is Subrogation Flag"
      expr: is_subrogation_flag
    - name: "Notes"
      expr: notes
    - name: "Number"
      expr: number
    - name: "Policy Type"
      expr: policy_type
    - name: "Termination Date"
      expr: termination_date
    - name: "Updated Timestamp"
      expr: updated_timestamp
    - name: "Verification Method"
      expr: verification_method
    - name: "Cob Verification Date Month"
      expr: DATE_TRUNC('MONTH', cob_verification_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Cob Record"
      expr: COUNT(DISTINCT cob_record_id)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`member_contact`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contact business metrics"
  source: "`vibe_health_insurance_v1`.`member`.`contact`"
  dimensions:
    - name: "Address Cass Certified"
      expr: address_cass_certified
    - name: "Address Effective Date"
      expr: address_effective_date
    - name: "Address Geocode Accuracy"
      expr: address_geocode_accuracy
    - name: "Address Geocode Source"
      expr: address_geocode_source
    - name: "Address Line1"
      expr: address_line1
    - name: "Address Line2"
      expr: address_line2
    - name: "Address Priority Rank"
      expr: address_priority_rank
    - name: "Address Source System"
      expr: address_source_system
    - name: "Address Termination Date"
      expr: address_termination_date
    - name: "Address Type"
      expr: address_type
    - name: "Address Verification Status"
      expr: address_verification_status
    - name: "Census Tract"
      expr: census_tract
    - name: "City"
      expr: city
    - name: "Contact Type"
      expr: contact_type
    - name: "Country Code"
      expr: country_code
    - name: "County Fips"
      expr: county_fips
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Contact"
      expr: COUNT(DISTINCT contact_id)
    - name: "Total Id Value"
      expr: SUM(id_value)
    - name: "Average Id Value"
      expr: AVG(id_value)
    - name: "Total Latitude"
      expr: SUM(latitude)
    - name: "Average Latitude"
      expr: AVG(latitude)
    - name: "Total Longitude"
      expr: SUM(longitude)
    - name: "Average Longitude"
      expr: AVG(longitude)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`member_dependent`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dependent business metrics"
  source: "`vibe_health_insurance_v1`.`member`.`dependent`"
  dimensions:
    - name: "Age Out Eligibility Flag"
      expr: age_out_eligibility_flag
    - name: "Chip Eligibility Flag"
      expr: chip_eligibility_flag
    - name: "Country"
      expr: country
    - name: "Coverage End Date"
      expr: coverage_end_date
    - name: "Coverage Start Date"
      expr: coverage_start_date
    - name: "Coverage Status"
      expr: coverage_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Date Of Birth"
      expr: date_of_birth
    - name: "Disability Status"
      expr: disability_status
    - name: "First Name"
      expr: first_name
    - name: "Gender"
      expr: gender
    - name: "Is Primary Contact"
      expr: is_primary_contact
    - name: "Language Preference"
      expr: language_preference
    - name: "Last Name"
      expr: last_name
    - name: "Medicaid Eligibility Flag"
      expr: medicaid_eligibility_flag
    - name: "Middle Name"
      expr: middle_name
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Dependent"
      expr: COUNT(DISTINCT dependent_id)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`member_eligibility_span`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Eligibility Span business metrics"
  source: "`vibe_health_insurance_v1`.`member`.`eligibility_span`"
  dimensions:
    - name: "Cobro End Date"
      expr: cobro_end_date
    - name: "Cobro Start Date"
      expr: cobro_start_date
    - name: "Coverage Type"
      expr: coverage_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective Date"
      expr: effective_date
    - name: "Eligibility Source"
      expr: eligibility_source
    - name: "Eligibility Status"
      expr: eligibility_status
    - name: "Enrollment Type"
      expr: enrollment_type
    - name: "Gap In Coverage Flag"
      expr: gap_in_coverage_flag
    - name: "Is Primary Coverage"
      expr: is_primary_coverage
    - name: "Line Of Business"
      expr: line_of_business
    - name: "Premium Currency"
      expr: premium_currency
    - name: "Retroactive Eligibility Flag"
      expr: retroactive_eligibility_flag
    - name: "Subscriber Relationship Code"
      expr: subscriber_relationship_code
    - name: "Termination Date"
      expr: termination_date
    - name: "Termination Reason Code"
      expr: termination_reason_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Eligibility Span"
      expr: COUNT(DISTINCT eligibility_span_id)
    - name: "Total Premium Amount"
      expr: SUM(premium_amount)
    - name: "Average Premium Amount"
      expr: AVG(premium_amount)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`member_grievance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Grievance business metrics"
  source: "`vibe_health_insurance_v1`.`member`.`grievance`"
  dimensions:
    - name: "Cms Reportable Indicator"
      expr: cms_reportable_indicator
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Investigation End Timestamp"
      expr: investigation_end_timestamp
    - name: "Investigation Start Timestamp"
      expr: investigation_start_timestamp
    - name: "Issue Category Code"
      expr: issue_category_code
    - name: "Lob Code"
      expr: lob_code
    - name: "Member Grievance Status"
      expr: member_grievance_status
    - name: "Member Satisfaction Score"
      expr: member_satisfaction_score
    - name: "Number"
      expr: number
    - name: "Received Timestamp"
      expr: received_timestamp
    - name: "Regulatory Reporting Flag"
      expr: regulatory_reporting_flag
    - name: "Resolution Date"
      expr: resolution_date
    - name: "Resolution Description"
      expr: resolution_description
    - name: "Resolution Type Code"
      expr: resolution_type_code
    - name: "Source"
      expr: source
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Grievance"
      expr: COUNT(DISTINCT grievance_id)
    - name: "Total Disputed Amount"
      expr: SUM(disputed_amount)
    - name: "Average Disputed Amount"
      expr: AVG(disputed_amount)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`member_id_card`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Id Card business metrics"
  source: "`vibe_health_insurance_v1`.`member`.`id_card`"
  dimensions:
    - name: "Barcode"
      expr: barcode
    - name: "Card Format"
      expr: card_format
    - name: "Card Number"
      expr: card_number
    - name: "Card Type"
      expr: card_type
    - name: "Card Version"
      expr: card_version
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Customer Service Phone"
      expr: customer_service_phone
    - name: "Delivery Confirmation Date"
      expr: delivery_confirmation_date
    - name: "Delivery Method"
      expr: delivery_method
    - name: "Expiration Date"
      expr: expiration_date
    - name: "External System Code"
      expr: external_system_code
    - name: "Id Card Status"
      expr: id_card_status
    - name: "Is Primary"
      expr: is_primary
    - name: "Issue Date"
      expr: issue_date
    - name: "Language Preference"
      expr: language_preference
    - name: "Last Status Change Timestamp"
      expr: last_status_change_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Id Card"
      expr: COUNT(DISTINCT id_card_id)
    - name: "Total Copay Amount"
      expr: SUM(copay_amount)
    - name: "Average Copay Amount"
      expr: AVG(copay_amount)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`member_identity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Identity business metrics"
  source: "`vibe_health_insurance_v1`.`member`.`identity`"
  dimensions:
    - name: "Address Line1"
      expr: address_line1
    - name: "Address Line2"
      expr: address_line2
    - name: "Citizenship Status"
      expr: citizenship_status
    - name: "City"
      expr: city
    - name: "Country"
      expr: country
    - name: "Coverage End Date"
      expr: coverage_end_date
    - name: "Coverage Start Date"
      expr: coverage_start_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Date Of Birth"
      expr: date_of_birth
    - name: "Eligibility Status"
      expr: eligibility_status
    - name: "Email"
      expr: email
    - name: "Enrollment Effective Date"
      expr: enrollment_effective_date
    - name: "Ethnicity"
      expr: ethnicity
    - name: "External Subscriber Number"
      expr: external_subscriber_number
    - name: "First Name"
      expr: first_name
    - name: "Full Name"
      expr: full_name
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Identity"
      expr: COUNT(DISTINCT identity_id)
    - name: "Total Risk Score"
      expr: SUM(risk_score)
    - name: "Average Risk Score"
      expr: AVG(risk_score)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`member_member_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Member Enrollment business metrics"
  source: "`vibe_health_insurance_v1`.`member`.`member_enrollment`"
  dimensions:
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Member Enrollment Status"
      expr: member_enrollment_status
    - name: "Member Enrollment Type"
      expr: member_enrollment_type
    - name: "Number"
      expr: number
    - name: "Reason"
      expr: reason
    - name: "Effective End Date Month"
      expr: DATE_TRUNC('MONTH', effective_end_date)
    - name: "Effective Start Date Month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Member Enrollment"
      expr: COUNT(DISTINCT member_enrollment_id)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`member_pcp_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pcp Assignment business metrics"
  source: "`vibe_health_insurance_v1`.`member`.`pcp_assignment`"
  dimensions:
    - name: "Assignment Reason"
      expr: assignment_reason
    - name: "Assignment Status"
      expr: assignment_status
    - name: "Assignment Type"
      expr: assignment_type
    - name: "Change Reason"
      expr: change_reason
    - name: "Change Timestamp"
      expr: change_timestamp
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective Date"
      expr: effective_date
    - name: "Is Current"
      expr: is_current
    - name: "Is Primary"
      expr: is_primary
    - name: "Notes"
      expr: notes
    - name: "Panel Status"
      expr: panel_status
    - name: "Termination Date"
      expr: termination_date
    - name: "Updated Timestamp"
      expr: updated_timestamp
    - name: "Change Timestamp Month"
      expr: DATE_TRUNC('MONTH', change_timestamp)
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Pcp Assignment"
      expr: COUNT(DISTINCT pcp_assignment_id)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`member_policy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Policy business metrics"
  source: "`vibe_health_insurance_v1`.`member`.`policy`"
  dimensions:
    - name: "Coverage End Date"
      expr: coverage_end_date
    - name: "Coverage Limit Currency"
      expr: coverage_limit_currency
    - name: "Coverage Limit Type"
      expr: coverage_limit_type
    - name: "Coverage Start Date"
      expr: coverage_start_date
    - name: "Coverage Status"
      expr: coverage_status
    - name: "Coverage Type"
      expr: coverage_type
    - name: "Deductible Currency"
      expr: deductible_currency
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Number"
      expr: number
    - name: "Out Of Pocket Max Currency"
      expr: out_of_pocket_max_currency
    - name: "Policy Status"
      expr: policy_status
    - name: "Policy Type"
      expr: policy_type
    - name: "Renewal Currency"
      expr: renewal_currency
    - name: "Renewal Date"
      expr: renewal_date
    - name: "Renewal Deductible Currency"
      expr: renewal_deductible_currency
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Policy"
      expr: COUNT(DISTINCT policy_id)
    - name: "Total Coverage Limit Amount"
      expr: SUM(coverage_limit_amount)
    - name: "Average Coverage Limit Amount"
      expr: AVG(coverage_limit_amount)
    - name: "Total Deductible Amount"
      expr: SUM(deductible_amount)
    - name: "Average Deductible Amount"
      expr: AVG(deductible_amount)
    - name: "Total Out Of Pocket Max Amount"
      expr: SUM(out_of_pocket_max_amount)
    - name: "Average Out Of Pocket Max Amount"
      expr: AVG(out_of_pocket_max_amount)
    - name: "Total Renewal Amount"
      expr: SUM(renewal_amount)
    - name: "Average Renewal Amount"
      expr: AVG(renewal_amount)
    - name: "Total Renewal Deductible Amount"
      expr: SUM(renewal_deductible_amount)
    - name: "Average Renewal Deductible Amount"
      expr: AVG(renewal_deductible_amount)
    - name: "Total Renewal Out Of Pocket Max Amount"
      expr: SUM(renewal_out_of_pocket_max_amount)
    - name: "Average Renewal Out Of Pocket Max Amount"
      expr: AVG(renewal_out_of_pocket_max_amount)
    - name: "Total Renewal Premium Amount"
      expr: SUM(renewal_premium_amount)
    - name: "Average Renewal Premium Amount"
      expr: AVG(renewal_premium_amount)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`member_subscriber`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Subscriber business metrics"
  source: "`vibe_health_insurance_v1`.`member`.`subscriber`"
  dimensions:
    - name: "Chip Number"
      expr: chip_number
    - name: "Citizenship Status"
      expr: citizenship_status
    - name: "Cob Indicator"
      expr: cob_indicator
    - name: "Consent To Electronic Communication"
      expr: consent_to_electronic_communication
    - name: "Coverage Type"
      expr: coverage_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Date Of Birth"
      expr: date_of_birth
    - name: "Disability Status"
      expr: disability_status
    - name: "Effective Date"
      expr: effective_date
    - name: "Enrollment Source"
      expr: enrollment_source
    - name: "First Name"
      expr: first_name
    - name: "Gender"
      expr: gender
    - name: "Is Deceased"
      expr: is_deceased
    - name: "Language Preference"
      expr: language_preference
    - name: "Last Name"
      expr: last_name
    - name: "Line Of Business"
      expr: line_of_business
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Subscriber"
      expr: COUNT(DISTINCT subscriber_id)
    - name: "Total Annual Income"
      expr: SUM(annual_income)
    - name: "Average Annual Income"
      expr: AVG(annual_income)
    - name: "Total Hcc Score"
      expr: SUM(hcc_score)
    - name: "Average Hcc Score"
      expr: AVG(hcc_score)
    - name: "Total Risk Adjustment Factor"
      expr: SUM(risk_adjustment_factor)
    - name: "Average Risk Adjustment Factor"
      expr: AVG(risk_adjustment_factor)
$$;