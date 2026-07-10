-- Metric views for domain: patient | Business: Healthcare | Version: 2 | Generated on: 2026-07-10 16:21:28

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`patient_address`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Address business metrics"
  source: "`vibe_healthcare_v1`.`patient`.`address`"
  dimensions:
    - name: "Address Status"
      expr: address_status
    - name: "Address Type"
      expr: address_type
    - name: "Census Tract"
      expr: census_tract
    - name: "City"
      expr: city
    - name: "Country Code"
      expr: country_code
    - name: "County"
      expr: county
    - name: "County Fips Code"
      expr: county_fips_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "District"
      expr: district
    - name: "Do Not Contact Reason"
      expr: do_not_contact_reason
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Geocode Precision"
      expr: geocode_precision
    - name: "Health Service Area"
      expr: health_service_area
    - name: "Housing Type"
      expr: housing_type
    - name: "Is Confidential"
      expr: is_confidential
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Address"
      expr: COUNT(DISTINCT address_id)
    - name: "Total Area Deprivation Index"
      expr: SUM(area_deprivation_index)
    - name: "Average Area Deprivation Index"
      expr: AVG(area_deprivation_index)
    - name: "Total Latitude"
      expr: SUM(latitude)
    - name: "Average Latitude"
      expr: AVG(latitude)
    - name: "Total Longitude"
      expr: SUM(longitude)
    - name: "Average Longitude"
      expr: AVG(longitude)
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`patient_consent_reference`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Consent Reference business metrics"
  source: "`vibe_healthcare_v1`.`patient`.`consent_reference`"
  dimensions:
    - name: "Audit Trail Flag"
      expr: audit_trail_flag
    - name: "Consent Effective Date"
      expr: consent_effective_date
    - name: "Consent Expiration Date"
      expr: consent_expiration_date
    - name: "Consent Method"
      expr: consent_method
    - name: "Consent Obtained Date"
      expr: consent_obtained_date
    - name: "Consent Revocation Date"
      expr: consent_revocation_date
    - name: "Consent Scope"
      expr: consent_scope
    - name: "Consent Status"
      expr: consent_status
    - name: "Consent Type"
      expr: consent_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Document Reference Number"
      expr: document_reference_number
    - name: "Enterprise Mrn"
      expr: enterprise_mrn
    - name: "Guardian Name"
      expr: guardian_name
    - name: "Guardian Relationship"
      expr: guardian_relationship
    - name: "Hie Participation Flag"
      expr: hie_participation_flag
    - name: "Interpreter Used Flag"
      expr: interpreter_used_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Consent Reference"
      expr: COUNT(DISTINCT consent_reference_id)
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`patient_demographics`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Demographics business metrics"
  source: "`vibe_healthcare_v1`.`patient`.`demographics`"
  dimensions:
    - name: "Advance Directive On File"
      expr: advance_directive_on_file
    - name: "Birth Date"
      expr: birth_date
    - name: "Birth Time"
      expr: birth_time
    - name: "Census Tract"
      expr: census_tract
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Death Certificate Number"
      expr: death_certificate_number
    - name: "Death Date"
      expr: death_date
    - name: "Deceased Indicator"
      expr: deceased_indicator
    - name: "Email Address"
      expr: email_address
    - name: "Enterprise Mrn"
      expr: enterprise_mrn
    - name: "Ethnicity Code"
      expr: ethnicity_code
    - name: "Gender Identity"
      expr: gender_identity
    - name: "Home Address Line1"
      expr: home_address_line1
    - name: "Home Address Line2"
      expr: home_address_line2
    - name: "Home City"
      expr: home_city
    - name: "Home Country Code"
      expr: home_country_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Demographics"
      expr: COUNT(DISTINCT demographics_id)
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`patient_eligibility_check`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Eligibility Check business metrics"
  source: "`vibe_healthcare_v1`.`patient`.`eligibility_check`"
  dimensions:
    - name: "Clearinghouse Name"
      expr: clearinghouse_name
    - name: "Coordination Of Benefits Flag"
      expr: coordination_of_benefits_flag
    - name: "Coverage Type"
      expr: coverage_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Group Number"
      expr: group_number
    - name: "Is Override"
      expr: is_override
    - name: "Mrn"
      expr: mrn
    - name: "Network Status"
      expr: network_status
    - name: "Override Reason"
      expr: override_reason
    - name: "Prior Auth Number"
      expr: prior_auth_number
    - name: "Prior Auth Required"
      expr: prior_auth_required
    - name: "Referral Required"
      expr: referral_required
    - name: "Rejection Reason Code"
      expr: rejection_reason_code
    - name: "Rejection Reason Description"
      expr: rejection_reason_description
    - name: "Response Timestamp"
      expr: response_timestamp
    - name: "Service Date"
      expr: service_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Eligibility Check"
      expr: COUNT(DISTINCT eligibility_check_id)
    - name: "Total Coinsurance Percent"
      expr: SUM(coinsurance_percent)
    - name: "Average Coinsurance Percent"
      expr: AVG(coinsurance_percent)
    - name: "Total Copay Amount"
      expr: SUM(copay_amount)
    - name: "Average Copay Amount"
      expr: AVG(copay_amount)
    - name: "Total Family Deductible Amount"
      expr: SUM(family_deductible_amount)
    - name: "Average Family Deductible Amount"
      expr: AVG(family_deductible_amount)
    - name: "Total Individual Deductible Amount"
      expr: SUM(individual_deductible_amount)
    - name: "Average Individual Deductible Amount"
      expr: AVG(individual_deductible_amount)
    - name: "Total Individual Deductible Met Amount"
      expr: SUM(individual_deductible_met_amount)
    - name: "Average Individual Deductible Met Amount"
      expr: AVG(individual_deductible_met_amount)
    - name: "Total Individual Out Of Pocket Max"
      expr: SUM(individual_out_of_pocket_max)
    - name: "Average Individual Out Of Pocket Max"
      expr: AVG(individual_out_of_pocket_max)
    - name: "Total Individual Out Of Pocket Met"
      expr: SUM(individual_out_of_pocket_met)
    - name: "Average Individual Out Of Pocket Met"
      expr: AVG(individual_out_of_pocket_met)
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`patient_emergency_contact`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Emergency Contact business metrics"
  source: "`vibe_healthcare_v1`.`patient`.`emergency_contact`"
  dimensions:
    - name: "Address Line1"
      expr: address_line1
    - name: "Address Line2"
      expr: address_line2
    - name: "City"
      expr: city
    - name: "Consent Date"
      expr: consent_date
    - name: "Consent Obtained By"
      expr: consent_obtained_by
    - name: "Contact Status"
      expr: contact_status
    - name: "Contact Type"
      expr: contact_type
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Email Address"
      expr: email_address
    - name: "First Name"
      expr: first_name
    - name: "Healthcare Proxy Flag"
      expr: healthcare_proxy_flag
    - name: "Home Phone"
      expr: home_phone
    - name: "Interpreter Required"
      expr: interpreter_required
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Emergency Contact"
      expr: COUNT(DISTINCT emergency_contact_id)
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`patient_guarantor`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Guarantor business metrics"
  source: "`vibe_healthcare_v1`.`patient`.`guarantor`"
  dimensions:
    - name: "Account Number"
      expr: account_number
    - name: "Account Status"
      expr: account_status
    - name: "Address Line1"
      expr: address_line1
    - name: "Address Line2"
      expr: address_line2
    - name: "Bad Debt Flag"
      expr: bad_debt_flag
    - name: "Bankruptcy Flag"
      expr: bankruptcy_flag
    - name: "City"
      expr: city
    - name: "Collection Agency Flag"
      expr: collection_agency_flag
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Date Of Birth"
      expr: date_of_birth
    - name: "Deceased Flag"
      expr: deceased_flag
    - name: "Do Not Contact Flag"
      expr: do_not_contact_flag
    - name: "Email Address"
      expr: email_address
    - name: "Employer Name"
      expr: employer_name
    - name: "Employer Phone"
      expr: employer_phone
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Guarantor"
      expr: COUNT(DISTINCT guarantor_id)
    - name: "Total Account Balance"
      expr: SUM(account_balance)
    - name: "Average Account Balance"
      expr: AVG(account_balance)
    - name: "Total Annual Income"
      expr: SUM(annual_income)
    - name: "Average Annual Income"
      expr: AVG(annual_income)
    - name: "Total Federal Poverty Level Pct"
      expr: SUM(federal_poverty_level_pct)
    - name: "Average Federal Poverty Level Pct"
      expr: AVG(federal_poverty_level_pct)
    - name: "Total Last Payment Amount"
      expr: SUM(last_payment_amount)
    - name: "Average Last Payment Amount"
      expr: AVG(last_payment_amount)
    - name: "Total Payment Plan Amount"
      expr: SUM(payment_plan_amount)
    - name: "Average Payment Plan Amount"
      expr: AVG(payment_plan_amount)
    - name: "Total Responsibility Pct"
      expr: SUM(responsibility_pct)
    - name: "Average Responsibility Pct"
      expr: AVG(responsibility_pct)
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`patient_insurance_coverage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Insurance Coverage business metrics"
  source: "`vibe_healthcare_v1`.`patient`.`insurance_coverage`"
  dimensions:
    - name: "Benefit Year End"
      expr: benefit_year_end
    - name: "Benefit Year Start"
      expr: benefit_year_start
    - name: "Cob Priority"
      expr: cob_priority
    - name: "Coverage Status"
      expr: coverage_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective Date"
      expr: effective_date
    - name: "Eligibility Response Code"
      expr: eligibility_response_code
    - name: "Eligibility Transaction Number"
      expr: eligibility_transaction_number
    - name: "Eligibility Verification Method"
      expr: eligibility_verification_method
    - name: "Eligibility Verification Status"
      expr: eligibility_verification_status
    - name: "Eligibility Verified By"
      expr: eligibility_verified_by
    - name: "Eligibility Verified Timestamp"
      expr: eligibility_verified_timestamp
    - name: "Group Number"
      expr: group_number
    - name: "Insurance Card Back Url"
      expr: insurance_card_back_url
    - name: "Insurance Card Front Url"
      expr: insurance_card_front_url
    - name: "Medicaid State Code"
      expr: medicaid_state_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Insurance Coverage"
      expr: COUNT(DISTINCT insurance_coverage_id)
    - name: "Total Coinsurance Rate"
      expr: SUM(coinsurance_rate)
    - name: "Average Coinsurance Rate"
      expr: AVG(coinsurance_rate)
    - name: "Total Copay Amount"
      expr: SUM(copay_amount)
    - name: "Average Copay Amount"
      expr: AVG(copay_amount)
    - name: "Total Deductible Amount"
      expr: SUM(deductible_amount)
    - name: "Average Deductible Amount"
      expr: AVG(deductible_amount)
    - name: "Total Deductible Met Amount"
      expr: SUM(deductible_met_amount)
    - name: "Average Deductible Met Amount"
      expr: AVG(deductible_met_amount)
    - name: "Total Out Of Pocket Max"
      expr: SUM(out_of_pocket_max)
    - name: "Average Out Of Pocket Max"
      expr: AVG(out_of_pocket_max)
    - name: "Total Out Of Pocket Met Amount"
      expr: SUM(out_of_pocket_met_amount)
    - name: "Average Out Of Pocket Met Amount"
      expr: AVG(out_of_pocket_met_amount)
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`patient_mpi_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Mpi Record business metrics"
  source: "`vibe_healthcare_v1`.`patient`.`mpi_record`"
  dimensions:
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Date Of Birth"
      expr: date_of_birth
    - name: "Date Of Death"
      expr: date_of_death
    - name: "Deceased Flag"
      expr: deceased_flag
    - name: "Enterprise Patient Number"
      expr: enterprise_patient_number
    - name: "Ethnicity Code"
      expr: ethnicity_code
    - name: "First Registration Date"
      expr: first_registration_date
    - name: "Gender Identity"
      expr: gender_identity
    - name: "Hie Patient Number"
      expr: hie_patient_number
    - name: "Identity Confidence Tier"
      expr: identity_confidence_tier
    - name: "Identity Resolution Status"
      expr: identity_resolution_status
    - name: "Interpreter Required Flag"
      expr: interpreter_required_flag
    - name: "Is Duplicate Flag"
      expr: is_duplicate_flag
    - name: "Is Overlay Flag"
      expr: is_overlay_flag
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "Last Verified Date"
      expr: last_verified_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Mpi Record"
      expr: COUNT(DISTINCT mpi_record_id)
    - name: "Total Match Confidence Score"
      expr: SUM(match_confidence_score)
    - name: "Average Match Confidence Score"
      expr: AVG(match_confidence_score)
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`patient_patient_coverage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Patient Coverage business metrics"
  source: "`vibe_healthcare_v1`.`patient`.`patient_coverage`"
  dimensions:
    - name: "Cob Priority"
      expr: cob_priority
    - name: "Coverage Status"
      expr: coverage_status
    - name: "Coverage Tier"
      expr: coverage_tier
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Eligibility Last Verified Date"
      expr: eligibility_last_verified_date
    - name: "Eligibility Verification Status"
      expr: eligibility_verification_status
    - name: "Enrollment Effective Date"
      expr: enrollment_effective_date
    - name: "Enrollment Source"
      expr: enrollment_source
    - name: "Enrollment Termination Date"
      expr: enrollment_termination_date
    - name: "Group Number"
      expr: group_number
    - name: "Relationship To Subscriber"
      expr: relationship_to_subscriber
    - name: "Source System Code"
      expr: source_system_code
    - name: "Updated Timestamp"
      expr: updated_timestamp
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
    - name: "Eligibility Last Verified Date Month"
      expr: DATE_TRUNC('MONTH', eligibility_last_verified_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Patient Coverage"
      expr: COUNT(DISTINCT patient_coverage_id)
    - name: "Total Employer Contribution Amount"
      expr: SUM(employer_contribution_amount)
    - name: "Average Employer Contribution Amount"
      expr: AVG(employer_contribution_amount)
    - name: "Total Patient Responsibility Amount"
      expr: SUM(patient_responsibility_amount)
    - name: "Average Patient Responsibility Amount"
      expr: AVG(patient_responsibility_amount)
    - name: "Total Premium Amount"
      expr: SUM(premium_amount)
    - name: "Average Premium Amount"
      expr: AVG(premium_amount)
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`patient_pcp_attribution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pcp Attribution business metrics"
  source: "`vibe_healthcare_v1`.`patient`.`pcp_attribution`"
  dimensions:
    - name: "Aco Contract Number"
      expr: aco_contract_number
    - name: "Attributed Provider Npi"
      expr: attributed_provider_npi
    - name: "Attribution Method"
      expr: attribution_method
    - name: "Attribution Override Reason"
      expr: attribution_override_reason
    - name: "Attribution Rank"
      expr: attribution_rank
    - name: "Attribution Review Date"
      expr: attribution_review_date
    - name: "Attribution Segment"
      expr: attribution_segment
    - name: "Attribution Source"
      expr: attribution_source
    - name: "Attribution Status"
      expr: attribution_status
    - name: "Care Management Enrolled"
      expr: care_management_enrolled
    - name: "Consent On File"
      expr: consent_on_file
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Sharing Opt Out"
      expr: data_sharing_opt_out
    - name: "Disenrollment Reason"
      expr: disenrollment_reason
    - name: "Effective Date"
      expr: effective_date
    - name: "End Date"
      expr: end_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Pcp Attribution"
      expr: COUNT(DISTINCT pcp_attribution_id)
    - name: "Total Attribution Confidence Score"
      expr: SUM(attribution_confidence_score)
    - name: "Average Attribution Confidence Score"
      expr: AVG(attribution_confidence_score)
    - name: "Total Hcc Risk Score"
      expr: SUM(hcc_risk_score)
    - name: "Average Hcc Risk Score"
      expr: AVG(hcc_risk_score)
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`patient_portal_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Portal Account business metrics"
  source: "`vibe_healthcare_v1`.`patient`.`portal_account`"
  dimensions:
    - name: "Account Status"
      expr: account_status
    - name: "Account Type"
      expr: account_type
    - name: "Activation Date"
      expr: activation_date
    - name: "Activation Method"
      expr: activation_method
    - name: "App Link Date"
      expr: app_link_date
    - name: "Appointment Scheduling Enabled"
      expr: appointment_scheduling_enabled
    - name: "Created Date"
      expr: created_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Deactivation Date"
      expr: deactivation_date
    - name: "Digital Health App Linked"
      expr: digital_health_app_linked
    - name: "Identity Verification Method"
      expr: identity_verification_method
    - name: "Identity Verified Date"
      expr: identity_verified_date
    - name: "Identity Verified Flag"
      expr: identity_verified_flag
    - name: "Last Login Date"
      expr: last_login_date
    - name: "Last Login Timestamp"
      expr: last_login_timestamp
    - name: "Login Failure Count"
      expr: login_failure_count
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Portal Account"
      expr: COUNT(DISTINCT portal_account_id)
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`patient_registration_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Registration Event business metrics"
  source: "`vibe_healthcare_v1`.`patient`.`registration_event`"
  dimensions:
    - name: "Admission Type"
      expr: admission_type
    - name: "Admit Reason"
      expr: admit_reason
    - name: "Adt Message Type"
      expr: adt_message_type
    - name: "Advance Directive Flag"
      expr: advance_directive_flag
    - name: "Consent Obtained Flag"
      expr: consent_obtained_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Discharge Disposition"
      expr: discharge_disposition
    - name: "Duplicate Flag"
      expr: duplicate_flag
    - name: "Eligibility Verification Timestamp"
      expr: eligibility_verification_timestamp
    - name: "Eligibility Verified Flag"
      expr: eligibility_verified_flag
    - name: "Event Status"
      expr: event_status
    - name: "Event Timestamp"
      expr: event_timestamp
    - name: "Event Type"
      expr: event_type
    - name: "Financial Class"
      expr: financial_class
    - name: "Hipaa Notice Delivered Flag"
      expr: hipaa_notice_delivered_flag
    - name: "Identity Verification Method"
      expr: identity_verification_method
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Registration Event"
      expr: COUNT(DISTINCT registration_event_id)
    - name: "Total Completeness Score"
      expr: SUM(completeness_score)
    - name: "Average Completeness Score"
      expr: AVG(completeness_score)
    - name: "Total Expected Los Days"
      expr: SUM(expected_los_days)
    - name: "Average Expected Los Days"
      expr: AVG(expected_los_days)
    - name: "Total Mpi Match Score"
      expr: SUM(mpi_match_score)
    - name: "Average Mpi Match Score"
      expr: AVG(mpi_match_score)
$$;