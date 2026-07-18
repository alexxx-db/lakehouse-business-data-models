-- Metric views for domain: customer | Business: Shipping_Ports | Version: 2 | Generated on: 2026-07-13 10:23:34

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`customer_contact_person`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contact Person business metrics"
  source: "`vibe_shipping_ports_v1`.`customer`.`contact_person`"
  dimensions:
    - name: "Accreditation Expiry Date"
      expr: accreditation_expiry_date
    - name: "Accreditation Status"
      expr: accreditation_status
    - name: "Contact Person Status"
      expr: contact_person_status
    - name: "Contact Role Type"
      expr: contact_role_type
    - name: "Contact Type"
      expr: contact_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Crm Contact Reference"
      expr: crm_contact_reference
    - name: "Customs Broker Licence Number"
      expr: customs_broker_licence_number
    - name: "Department"
      expr: department
    - name: "Do Not Contact"
      expr: do_not_contact
    - name: "Do Not Email"
      expr: do_not_email
    - name: "Do Not Sms"
      expr: do_not_sms
    - name: "Effective From Date"
      expr: effective_from_date
    - name: "Effective To Date"
      expr: effective_to_date
    - name: "Email"
      expr: email
    - name: "Email Secondary"
      expr: email_secondary
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Contact Person"
      expr: COUNT(DISTINCT contact_person_id)
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`customer_credit_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Credit Assessment business metrics"
  source: "`vibe_shipping_ports_v1`.`customer`.`credit_assessment`"
  dimensions:
    - name: "Application Date"
      expr: application_date
    - name: "Approval Date"
      expr: approval_date
    - name: "Approval Level"
      expr: approval_level
    - name: "Approver Name"
      expr: approver_name
    - name: "Assessment Date"
      expr: assessment_date
    - name: "Assessment Methodology"
      expr: assessment_methodology
    - name: "Assessment Notes"
      expr: assessment_notes
    - name: "Assessment Reference Number"
      expr: assessment_reference_number
    - name: "Assessment Status"
      expr: assessment_status
    - name: "Assessment Type"
      expr: assessment_type
    - name: "Assessor Name"
      expr: assessor_name
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Credit Bureau Reference"
      expr: credit_bureau_reference
    - name: "Credit Insurance Policy Number"
      expr: credit_insurance_policy_number
    - name: "Credit Rating"
      expr: credit_rating
    - name: "Crm Opportunity Reference"
      expr: crm_opportunity_reference
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Credit Assessment"
      expr: COUNT(DISTINCT credit_assessment_id)
    - name: "Total Annual Revenue"
      expr: SUM(annual_revenue)
    - name: "Average Annual Revenue"
      expr: AVG(annual_revenue)
    - name: "Total Approved Credit Limit"
      expr: SUM(approved_credit_limit)
    - name: "Average Approved Credit Limit"
      expr: AVG(approved_credit_limit)
    - name: "Total Assessed Credit Limit"
      expr: SUM(assessed_credit_limit)
    - name: "Average Assessed Credit Limit"
      expr: AVG(assessed_credit_limit)
    - name: "Total Credit Score"
      expr: SUM(credit_score)
    - name: "Average Credit Score"
      expr: AVG(credit_score)
    - name: "Total Outstanding Balance"
      expr: SUM(outstanding_balance)
    - name: "Average Outstanding Balance"
      expr: AVG(outstanding_balance)
    - name: "Total Previous Credit Limit"
      expr: SUM(previous_credit_limit)
    - name: "Average Previous Credit Limit"
      expr: AVG(previous_credit_limit)
    - name: "Total Requested Credit Limit"
      expr: SUM(requested_credit_limit)
    - name: "Average Requested Credit Limit"
      expr: AVG(requested_credit_limit)
    - name: "Total Security Deposit Amount"
      expr: SUM(security_deposit_amount)
    - name: "Average Security Deposit Amount"
      expr: AVG(security_deposit_amount)
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`customer_participant_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Participant Account business metrics"
  source: "`vibe_shipping_ports_v1`.`customer`.`participant_account`"
  dimensions:
    - name: "Account Close Date"
      expr: account_close_date
    - name: "Account Name"
      expr: account_name
    - name: "Account Number"
      expr: account_number
    - name: "Account Open Date"
      expr: account_open_date
    - name: "Account Status"
      expr: account_status
    - name: "Account Tier"
      expr: account_tier
    - name: "Account Type"
      expr: account_type
    - name: "Annual Teu Volume Commitment"
      expr: annual_teu_volume_commitment
    - name: "Auto Suspension Enabled"
      expr: auto_suspension_enabled
    - name: "Billing Address"
      expr: billing_address
    - name: "Billing Contact Name"
      expr: billing_contact_name
    - name: "Billing Cycle"
      expr: billing_cycle
    - name: "Billing Email"
      expr: billing_email
    - name: "Contract End Date"
      expr: contract_end_date
    - name: "Contract Reference"
      expr: contract_reference
    - name: "Contract Start Date"
      expr: contract_start_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Participant Account"
      expr: COUNT(DISTINCT participant_account_id)
    - name: "Total Credit Limit"
      expr: SUM(credit_limit)
    - name: "Average Credit Limit"
      expr: AVG(credit_limit)
    - name: "Total Credit Utilisation Pct"
      expr: SUM(credit_utilisation_pct)
    - name: "Average Credit Utilisation Pct"
      expr: AVG(credit_utilisation_pct)
    - name: "Total Deposit Amount"
      expr: SUM(deposit_amount)
    - name: "Average Deposit Amount"
      expr: AVG(deposit_amount)
    - name: "Total Discount Rate Pct"
      expr: SUM(discount_rate_pct)
    - name: "Average Discount Rate Pct"
      expr: AVG(discount_rate_pct)
    - name: "Total Last Payment Amount"
      expr: SUM(last_payment_amount)
    - name: "Average Last Payment Amount"
      expr: AVG(last_payment_amount)
    - name: "Total Outstanding Balance"
      expr: SUM(outstanding_balance)
    - name: "Average Outstanding Balance"
      expr: AVG(outstanding_balance)
    - name: "Total Overdue Amount"
      expr: SUM(overdue_amount)
    - name: "Average Overdue Amount"
      expr: AVG(overdue_amount)
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`customer_participant_address`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Participant Address business metrics"
  source: "`vibe_shipping_ports_v1`.`customer`.`participant_address`"
  dimensions:
    - name: "Address Format Type"
      expr: address_format_type
    - name: "Address Line 1"
      expr: address_line_1
    - name: "Address Line 2"
      expr: address_line_2
    - name: "Address Line 3"
      expr: address_line_3
    - name: "Address Status"
      expr: address_status
    - name: "Address Type"
      expr: address_type
    - name: "Attention To"
      expr: attention_to
    - name: "City"
      expr: city
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Customs Registered Address Flag"
      expr: customs_registered_address_flag
    - name: "Customs Registration Number"
      expr: customs_registration_number
    - name: "Department"
      expr: department
    - name: "Effective From Date"
      expr: effective_from_date
    - name: "Effective To Date"
      expr: effective_to_date
    - name: "Email Address"
      expr: email_address
    - name: "Fax Number"
      expr: fax_number
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Participant Address"
      expr: COUNT(DISTINCT participant_address_id)
    - name: "Total Latitude"
      expr: SUM(latitude)
    - name: "Average Latitude"
      expr: AVG(latitude)
    - name: "Total Longitude"
      expr: SUM(longitude)
    - name: "Average Longitude"
      expr: AVG(longitude)
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`customer_participant_service_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Participant Service Agreement business metrics"
  source: "`vibe_shipping_ports_v1`.`customer`.`participant_service_agreement`"
  dimensions:
    - name: "Agreement Reference Number"
      expr: agreement_reference_number
    - name: "Agreement Status"
      expr: agreement_status
    - name: "Billing Frequency Override"
      expr: billing_frequency_override
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Effective From Date"
      expr: effective_from_date
    - name: "Effective To Date"
      expr: effective_to_date
    - name: "Last Modified By"
      expr: last_modified_by
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Notes"
      expr: notes
    - name: "Payment Terms Override"
      expr: payment_terms_override
    - name: "Volume Tier"
      expr: volume_tier
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
    - name: "Effective From Date Month"
      expr: DATE_TRUNC('MONTH', effective_from_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Participant Service Agreement"
      expr: COUNT(DISTINCT participant_service_agreement_id)
    - name: "Total Discount Percentage"
      expr: SUM(discount_percentage)
    - name: "Average Discount Percentage"
      expr: AVG(discount_percentage)
    - name: "Total Minimum Charge"
      expr: SUM(minimum_charge)
    - name: "Average Minimum Charge"
      expr: AVG(minimum_charge)
    - name: "Total Negotiated Rate"
      expr: SUM(negotiated_rate)
    - name: "Average Negotiated Rate"
      expr: AVG(negotiated_rate)
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`customer_port_access_permit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Port Access Permit business metrics"
  source: "`vibe_shipping_ports_v1`.`customer`.`port_access_permit`"
  dimensions:
    - name: "Access Time Restriction"
      expr: access_time_restriction
    - name: "Application Reference"
      expr: application_reference
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Background Check Date"
      expr: background_check_date
    - name: "Background Check Status"
      expr: background_check_status
    - name: "Badge Number"
      expr: badge_number
    - name: "Biometric Reference Code"
      expr: biometric_reference_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Crm Contact Reference"
      expr: crm_contact_reference
    - name: "Escort Required"
      expr: escort_required
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Holder Date Of Birth"
      expr: holder_date_of_birth
    - name: "Holder Employer Name"
      expr: holder_employer_name
    - name: "Holder Full Name"
      expr: holder_full_name
    - name: "Holder Id Document Number"
      expr: holder_id_document_number
    - name: "Holder Id Document Type"
      expr: holder_id_document_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Port Access Permit"
      expr: COUNT(DISTINCT port_access_permit_id)
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`customer_port_community_participant`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Port Community Participant business metrics"
  source: "`vibe_shipping_ports_v1`.`customer`.`port_community_participant`"
  dimensions:
    - name: "Aeo Certification Expiry Date"
      expr: aeo_certification_expiry_date
    - name: "Aeo Certification Number"
      expr: aeo_certification_number
    - name: "Annual Teu Volume Estimate"
      expr: annual_teu_volume_estimate
    - name: "Billing Contact Email"
      expr: billing_contact_email
    - name: "Carrier Code"
      expr: carrier_code
    - name: "Credit Currency Code"
      expr: credit_currency_code
    - name: "Crm Account Reference"
      expr: crm_account_reference
    - name: "Customer Tier"
      expr: customer_tier
    - name: "Customs Registration Number"
      expr: customs_registration_number
    - name: "Dangerous Goods Approved"
      expr: dangerous_goods_approved
    - name: "Deactivation Date"
      expr: deactivation_date
    - name: "Freight Forwarder Licence Number"
      expr: freight_forwarder_licence_number
    - name: "Imo Company Number"
      expr: imo_company_number
    - name: "Isps Accreditation Expiry Date"
      expr: isps_accreditation_expiry_date
    - name: "Isps Accreditation Status"
      expr: isps_accreditation_status
    - name: "Last Activity Date"
      expr: last_activity_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Port Community Participant"
      expr: COUNT(DISTINCT port_community_participant_id)
    - name: "Total Credit Limit"
      expr: SUM(credit_limit)
    - name: "Average Credit Limit"
      expr: AVG(credit_limit)
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`customer_service_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service Request business metrics"
  source: "`vibe_shipping_ports_v1`.`customer`.`service_request`"
  dimensions:
    - name: "Acknowledged Timestamp"
      expr: acknowledged_timestamp
    - name: "Category"
      expr: service_request_category
    - name: "Channel"
      expr: channel
    - name: "Closed Timestamp"
      expr: closed_timestamp
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Crm Case Reference"
      expr: crm_case_reference
    - name: "Currency Code"
      expr: currency_code
    - name: "Customer Satisfaction Score"
      expr: customer_satisfaction_score
    - name: "Description"
      expr: service_request_description
    - name: "Escalation Flag"
      expr: escalation_flag
    - name: "Escalation Reason"
      expr: escalation_reason
    - name: "Escalation Timestamp"
      expr: escalation_timestamp
    - name: "Imdg Related"
      expr: imdg_related
    - name: "Isps Related"
      expr: isps_related
    - name: "Lodgement Timestamp"
      expr: lodgement_timestamp
    - name: "Pcs Message Reference"
      expr: pcs_message_reference
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Service Request"
      expr: COUNT(DISTINCT service_request_id)
    - name: "Total Dispute Amount"
      expr: SUM(dispute_amount)
    - name: "Average Dispute Amount"
      expr: AVG(dispute_amount)
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`customer_sla_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sla Profile business metrics"
  source: "`vibe_shipping_ports_v1`.`customer`.`sla_profile`"
  dimensions:
    - name: "Bol Reference"
      expr: bol_reference
    - name: "Breach Count"
      expr: breach_count
    - name: "Breach Flag"
      expr: breach_flag
    - name: "Breach Severity"
      expr: breach_severity
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Escalation Contact"
      expr: escalation_contact
    - name: "Force Majeure Applicable"
      expr: force_majeure_applicable
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "Measurement Period End"
      expr: measurement_period_end
    - name: "Measurement Period Start"
      expr: measurement_period_start
    - name: "Measurement Source System"
      expr: measurement_source_system
    - name: "Measurement Timestamp"
      expr: measurement_timestamp
    - name: "Measurement Window"
      expr: measurement_window
    - name: "Metric Type"
      expr: metric_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Sla Profile"
      expr: COUNT(DISTINCT sla_profile_id)
    - name: "Total Actual Value"
      expr: SUM(actual_value)
    - name: "Average Actual Value"
      expr: AVG(actual_value)
    - name: "Total Breach Threshold"
      expr: SUM(breach_threshold)
    - name: "Average Breach Threshold"
      expr: AVG(breach_threshold)
    - name: "Total Credit Cap Value"
      expr: SUM(credit_cap_value)
    - name: "Average Credit Cap Value"
      expr: AVG(credit_cap_value)
    - name: "Total Penalty Amount Applied"
      expr: SUM(penalty_amount_applied)
    - name: "Average Penalty Amount Applied"
      expr: AVG(penalty_amount_applied)
    - name: "Total Penalty Value"
      expr: SUM(penalty_value)
    - name: "Average Penalty Value"
      expr: AVG(penalty_value)
    - name: "Total Target Value"
      expr: SUM(target_value)
    - name: "Average Target Value"
      expr: AVG(target_value)
    - name: "Total Teu Volume"
      expr: SUM(teu_volume)
    - name: "Average Teu Volume"
      expr: AVG(teu_volume)
    - name: "Total Variance From Target"
      expr: SUM(variance_from_target)
    - name: "Average Variance From Target"
      expr: AVG(variance_from_target)
$$;
