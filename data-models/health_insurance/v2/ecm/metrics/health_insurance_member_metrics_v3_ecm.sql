-- Metric views for domain: member | Business: Health_Insurance | Version: 3 | Generated on: 2026-07-10 20:19:29

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`member_address`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Address business metrics"
  source: "`vibe_health_insurance_v1`.`member`.`address`"
  dimensions:
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
    - name: "Postal Code"
      expr: postal_code
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

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`member_assignment_rule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Assignment Rule business metrics"
  source: "`vibe_health_insurance_v1`.`member`.`assignment_rule`"
  dimensions:
    - name: "Effective From"
      expr: effective_from
    - name: "Effective Until"
      expr: effective_until
    - name: "Rule Action"
      expr: rule_action
    - name: "Rule Category"
      expr: rule_category
    - name: "Rule Criteria"
      expr: rule_criteria
    - name: "Rule Description"
      expr: rule_description
    - name: "Rule Expression"
      expr: rule_expression
    - name: "Rule Immutable Date"
      expr: rule_immutable_date
    - name: "Rule Immutable Reason"
      expr: rule_immutable_reason
    - name: "Rule Is Custom"
      expr: rule_is_custom
    - name: "Rule Is Default"
      expr: rule_is_default
    - name: "Rule Is Immutable"
      expr: rule_is_immutable
    - name: "Rule Is System"
      expr: rule_is_system
    - name: "Rule Lifecycle Status"
      expr: rule_lifecycle_status
    - name: "Rule Logic"
      expr: rule_logic
    - name: "Rule Name"
      expr: rule_name
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Assignment Rule"
      expr: COUNT(DISTINCT assignment_rule_id)
    - name: "Total Updated By"
      expr: SUM(updated_by)
    - name: "Average Updated By"
      expr: AVG(updated_by)
    - name: "Total Created By"
      expr: SUM(created_by)
    - name: "Average Created By"
      expr: AVG(created_by)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`member_authorization_document`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Authorization Document business metrics"
  source: "`vibe_health_insurance_v1`.`member`.`authorization_document`"
  dimensions:
    - name: "Authorization Number"
      expr: authorization_number
    - name: "Authorization Type"
      expr: authorization_type
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Member Address"
      expr: member_address
    - name: "Member Dob"
      expr: member_dob
    - name: "Member Email"
      expr: member_email
    - name: "Member Gender"
      expr: member_gender
    - name: "Member Name"
      expr: member_name
    - name: "Member Phone"
      expr: member_phone
    - name: "Member Ssn"
      expr: member_ssn
    - name: "Authorization Document Status"
      expr: authorization_document_status
    - name: "Effective Date Month"
      expr: DATE_TRUNC('MONTH', effective_date)
    - name: "Expiration Date Month"
      expr: DATE_TRUNC('MONTH', expiration_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Authorization Document"
      expr: COUNT(DISTINCT authorization_document_id)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`member_authorized_representative`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Authorized Representative business metrics"
  source: "`vibe_health_insurance_v1`.`member`.`authorized_representative`"
  dimensions:
    - name: "Audit Reason"
      expr: audit_reason
    - name: "Authorization End Date"
      expr: authorization_end_date
    - name: "Authorization Scope"
      expr: authorization_scope
    - name: "Authorization Start Date"
      expr: authorization_start_date
    - name: "Authorization Status"
      expr: authorization_status
    - name: "Bar Number"
      expr: bar_number
    - name: "Contact Address Line1"
      expr: contact_address_line1
    - name: "Contact City"
      expr: contact_city
    - name: "Contact Country Code"
      expr: contact_country_code
    - name: "Contact Email"
      expr: contact_email
    - name: "Contact Phone"
      expr: contact_phone
    - name: "Contact Postal Code"
      expr: contact_postal_code
    - name: "Contact State Code"
      expr: contact_state_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Document Reference"
      expr: document_reference
    - name: "Effective Timestamp"
      expr: effective_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Authorized Representative"
      expr: COUNT(DISTINCT authorized_representative_id)
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
    - name: "Other Carrier Group Number"
      expr: other_carrier_group_number
    - name: "Other Carrier Member Number"
      expr: other_carrier_member_number
    - name: "Other Carrier Name"
      expr: other_carrier_name
    - name: "Other Carrier Relationship Type"
      expr: other_carrier_relationship_type
    - name: "Policy Type"
      expr: policy_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Cob Record"
      expr: COUNT(DISTINCT cob_record_id)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`member_cobra_continuant`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cobra Continuant business metrics"
  source: "`vibe_health_insurance_v1`.`member`.`cobra_continuant`"
  dimensions:
    - name: "Cobra Eligibility Indicator"
      expr: cobra_eligibility_indicator
    - name: "Cobra Eligibility Reason"
      expr: cobra_eligibility_reason
    - name: "Cobra Notice Sent Date"
      expr: cobra_notice_sent_date
    - name: "Cobra Notice Type"
      expr: cobra_notice_type
    - name: "Coverage End Date"
      expr: coverage_end_date
    - name: "Coverage Start Date"
      expr: coverage_start_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Election Date"
      expr: election_date
    - name: "Election Deadline"
      expr: election_deadline
    - name: "Exhaustion Date"
      expr: exhaustion_date
    - name: "Is Exhausted"
      expr: is_exhausted
    - name: "Max Coverage End Date"
      expr: max_coverage_end_date
    - name: "Max Coverage Months"
      expr: max_coverage_months
    - name: "Member Relationship"
      expr: member_relationship
    - name: "Notes"
      expr: notes
    - name: "Payment Frequency"
      expr: payment_frequency
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Cobra Continuant"
      expr: COUNT(DISTINCT cobra_continuant_id)
    - name: "Total Premium Amount"
      expr: SUM(premium_amount)
    - name: "Average Premium Amount"
      expr: AVG(premium_amount)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`member_consent`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Consent business metrics"
  source: "`vibe_health_insurance_v1`.`member`.`consent`"
  dimensions:
    - name: "Authorized Recipient"
      expr: authorized_recipient
    - name: "Collection Method"
      expr: collection_method
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Consent Date"
      expr: consent_date
    - name: "Disclosure Scope"
      expr: disclosure_scope
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Is 42cfr Part2 Applicable"
      expr: is_42cfr_part2_applicable
    - name: "Is Electronic Signature"
      expr: is_electronic_signature
    - name: "Is Minimum Necessary"
      expr: is_minimum_necessary
    - name: "Language"
      expr: language
    - name: "Notes"
      expr: notes
    - name: "Revocation Date"
      expr: revocation_date
    - name: "Signature Timestamp"
      expr: signature_timestamp
    - name: "State Of Residence"
      expr: state_of_residence
    - name: "Consent Status"
      expr: consent_status
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Consent"
      expr: COUNT(DISTINCT consent_id)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`member_dependent`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dependent business metrics"
  source: "`vibe_health_insurance_v1`.`member`.`dependent`"
  dimensions:
    - name: "Address Line1"
      expr: address_line1
    - name: "Address Line2"
      expr: address_line2
    - name: "Age Out Eligibility Flag"
      expr: age_out_eligibility_flag
    - name: "Chip Eligibility Flag"
      expr: chip_eligibility_flag
    - name: "City"
      expr: city
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
    - name: "Email Address"
      expr: email_address
    - name: "First Name"
      expr: first_name
    - name: "Gender"
      expr: gender
    - name: "Is Primary Contact"
      expr: is_primary_contact
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Dependent"
      expr: COUNT(DISTINCT dependent_id)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`member_disenrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Disenrollment business metrics"
  source: "`vibe_health_insurance_v1`.`member`.`disenrollment`"
  dimensions:
    - name: "Appeal Rights Notified"
      expr: appeal_rights_notified
    - name: "Cobro Eligibility"
      expr: cobro_eligibility
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Effective Timestamp"
      expr: effective_timestamp
    - name: "Eligibility Loss Indicator"
      expr: eligibility_loss_indicator
    - name: "Notice Sent Date"
      expr: notice_sent_date
    - name: "Number"
      expr: number
    - name: "Processed By"
      expr: processed_by
    - name: "Processed Timestamp"
      expr: processed_timestamp
    - name: "Reason Code"
      expr: reason_code
    - name: "Reason Description"
      expr: reason_description
    - name: "Request Date"
      expr: request_date
    - name: "Source"
      expr: source
    - name: "Disenrollment Status"
      expr: disenrollment_status
    - name: "Termination Type"
      expr: termination_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Disenrollment"
      expr: COUNT(DISTINCT disenrollment_id)
    - name: "Total Refund Adjustment Amount"
      expr: SUM(refund_adjustment_amount)
    - name: "Average Refund Adjustment Amount"
      expr: AVG(refund_adjustment_amount)
    - name: "Total Refund Gross Amount"
      expr: SUM(refund_gross_amount)
    - name: "Average Refund Gross Amount"
      expr: AVG(refund_gross_amount)
    - name: "Total Refund Net Amount"
      expr: SUM(refund_net_amount)
    - name: "Average Refund Net Amount"
      expr: AVG(refund_net_amount)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`member_household`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Household business metrics"
  source: "`vibe_health_insurance_v1`.`member`.`household`"
  dimensions:
    - name: "Aca Subsidy Eligible"
      expr: aca_subsidy_eligible
    - name: "City"
      expr: city
    - name: "Cobra Coverage Flag"
      expr: cobra_coverage_flag
    - name: "Country"
      expr: country
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Creation Method"
      expr: creation_method
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Email Address"
      expr: email_address
    - name: "Enrollment Status"
      expr: enrollment_status
    - name: "Fpl Year"
      expr: fpl_year
    - name: "Income Source"
      expr: income_source
    - name: "Income Verification Flag"
      expr: income_verification_flag
    - name: "Is Hispanic"
      expr: is_hispanic
    - name: "Is Multi Plan"
      expr: is_multi_plan
    - name: "Is Veteran"
      expr: is_veteran
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Household"
      expr: COUNT(DISTINCT household_id)
    - name: "Total Fpl Percentage"
      expr: SUM(fpl_percentage)
    - name: "Average Fpl Percentage"
      expr: AVG(fpl_percentage)
    - name: "Total Risk Score"
      expr: SUM(risk_score)
    - name: "Average Risk Score"
      expr: AVG(risk_score)
    - name: "Total Subsidy Amount"
      expr: SUM(subsidy_amount)
    - name: "Average Subsidy Amount"
      expr: AVG(subsidy_amount)
    - name: "Total Tax Credit Amount"
      expr: SUM(tax_credit_amount)
    - name: "Average Tax Credit Amount"
      expr: AVG(tax_credit_amount)
    - name: "Total Total Income"
      expr: SUM(total_income)
    - name: "Average Total Income"
      expr: AVG(total_income)
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
    - name: "Group Number"
      expr: group_number
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

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`member_lob_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lob Assignment business metrics"
  source: "`vibe_health_insurance_v1`.`member`.`lob_assignment`"
  dimensions:
    - name: "Care Management Eligibility Flag"
      expr: care_management_eligibility_flag
    - name: "Chronic Condition Flag"
      expr: chronic_condition_flag
    - name: "Cms Contract Number"
      expr: cms_contract_number
    - name: "Cms Region"
      expr: cms_region
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Dual Eligible Flag"
      expr: dual_eligible_flag
    - name: "Effective Date"
      expr: effective_date
    - name: "Hcc Risk Score Tier"
      expr: hcc_risk_score_tier
    - name: "Lob Code"
      expr: lob_code
    - name: "Lob Description"
      expr: lob_description
    - name: "Plan Benefit Package Code"
      expr: plan_benefit_package_code
    - name: "Rising Risk Indicator"
      expr: rising_risk_indicator
    - name: "Risk Tier"
      expr: risk_tier
    - name: "Sdoh Risk Flag"
      expr: sdoh_risk_flag
    - name: "Segmentation Model Version"
      expr: segmentation_model_version
    - name: "Segmentation Source"
      expr: segmentation_source
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Lob Assignment"
      expr: COUNT(DISTINCT lob_assignment_id)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`member_member_communication`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Member Communication business metrics"
  source: "`vibe_health_insurance_v1`.`member`.`member_communication`"
  dimensions:
    - name: "Acknowledgment Status"
      expr: acknowledgment_status
    - name: "Body"
      expr: body
    - name: "Card Format"
      expr: card_format
    - name: "Card Status"
      expr: card_status
    - name: "Card Type"
      expr: card_type
    - name: "Channel"
      expr: channel
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Customer Service Phone"
      expr: customer_service_phone
    - name: "Delivery Confirmation"
      expr: delivery_confirmation
    - name: "Delivery Timestamp"
      expr: delivery_timestamp
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Group Number"
      expr: group_number
    - name: "Language Code"
      expr: language_code
    - name: "Member Communication Status"
      expr: member_communication_status
    - name: "Member Id Displayed"
      expr: member_id_displayed
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Member Communication"
      expr: COUNT(DISTINCT member_communication_id)
    - name: "Total Copay Amount"
      expr: SUM(copay_amount)
    - name: "Average Copay Amount"
      expr: AVG(copay_amount)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`member_member_contact`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Member Contact business metrics"
  source: "`vibe_health_insurance_v1`.`member`.`member_contact`"
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
    - name: "Contact Name"
      expr: contact_name
    - name: "Contact Type"
      expr: contact_type
    - name: "Country Code"
      expr: country_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Member Contact"
      expr: COUNT(DISTINCT member_contact_id)
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

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`member_member_eligibility_span`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Member Eligibility Span business metrics"
  source: "`vibe_health_insurance_v1`.`member`.`member_eligibility_span`"
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
    - name: "Distinct Member Eligibility Span"
      expr: COUNT(DISTINCT member_eligibility_span_id)
    - name: "Total Premium Amount"
      expr: SUM(premium_amount)
    - name: "Average Premium Amount"
      expr: AVG(premium_amount)
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
    - name: "Number"
      expr: number
    - name: "Reason"
      expr: reason
    - name: "Member Enrollment Status"
      expr: member_enrollment_status
    - name: "Member Enrollment Type"
      expr: member_enrollment_type
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

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`member_member_grievance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Member Grievance business metrics"
  source: "`vibe_health_insurance_v1`.`member`.`member_grievance`"
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
    - name: "Distinct Member Grievance"
      expr: COUNT(DISTINCT member_grievance_id)
    - name: "Total Disputed Amount"
      expr: SUM(disputed_amount)
    - name: "Average Disputed Amount"
      expr: AVG(disputed_amount)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`member_member_lifecycle_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Member Lifecycle Event business metrics"
  source: "`vibe_health_insurance_v1`.`member`.`member_lifecycle_event`"
  dimensions:
    - name: "Appeal Rights Notification Flag"
      expr: appeal_rights_notification_flag
    - name: "Chip Aging Out Flag"
      expr: chip_aging_out_flag
    - name: "Cms Reporting Indicator"
      expr: cms_reporting_indicator
    - name: "Cobra Qualifying Event Flag"
      expr: cobra_qualifying_event_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Disability Determination Flag"
      expr: disability_determination_flag
    - name: "Disenrollment Reason Code"
      expr: disenrollment_reason_code
    - name: "Disenrollment Request Date"
      expr: disenrollment_request_date
    - name: "Disenrollment Source"
      expr: disenrollment_source
    - name: "Documentation Received Flag"
      expr: documentation_received_flag
    - name: "Effective Date"
      expr: effective_date
    - name: "Event Description"
      expr: event_description
    - name: "Event Reason Code"
      expr: event_reason_code
    - name: "Event Timestamp"
      expr: event_timestamp
    - name: "Event Type Code"
      expr: event_type_code
    - name: "Incarceration Release Flag"
      expr: incarceration_release_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Member Lifecycle Event"
      expr: COUNT(DISTINCT member_lifecycle_event_id)
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
    - name: "Network Tier"
      expr: network_tier
    - name: "Notes"
      expr: notes
    - name: "Panel Status"
      expr: panel_status
    - name: "Pcp Specialty Code"
      expr: pcp_specialty_code
    - name: "Termination Date"
      expr: termination_date
    - name: "Updated Timestamp"
      expr: updated_timestamp
    - name: "Change Timestamp Month"
      expr: DATE_TRUNC('MONTH', change_timestamp)
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
    - name: "Premium Currency"
      expr: premium_currency
    - name: "Premium Frequency"
      expr: premium_frequency
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
    - name: "Total Premium Amount"
      expr: SUM(premium_amount)
    - name: "Average Premium Amount"
      expr: AVG(premium_amount)
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

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`member_segment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Segment business metrics"
  source: "`vibe_health_insurance_v1`.`member`.`segment`"
  dimensions:
    - name: "Audit Reason"
      expr: audit_reason
    - name: "Segment Category"
      expr: segment_category
    - name: "Chronic Condition Code"
      expr: chronic_condition_code
    - name: "Chronic Condition Flag"
      expr: chronic_condition_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Segment Description"
      expr: segment_description
    - name: "Dual Eligible"
      expr: dual_eligible
    - name: "Effective Date"
      expr: effective_date
    - name: "End Date"
      expr: end_date
    - name: "Hcc Risk Score Tier"
      expr: hcc_risk_score_tier
    - name: "Is Current"
      expr: is_current
    - name: "Segment Name"
      expr: segment_name
    - name: "Notes"
      expr: notes
    - name: "Risk Tier"
      expr: risk_tier
    - name: "Segmentation Model Version"
      expr: segmentation_model_version
    - name: "Segmentation Source"
      expr: segmentation_source
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Segment"
      expr: COUNT(DISTINCT segment_id)
    - name: "Total Sdoh Risk Score"
      expr: SUM(sdoh_risk_score)
    - name: "Average Sdoh Risk Score"
      expr: AVG(sdoh_risk_score)
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