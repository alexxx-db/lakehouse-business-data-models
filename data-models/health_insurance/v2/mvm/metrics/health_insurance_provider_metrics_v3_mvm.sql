-- Metric views for domain: provider | Business: Health_Insurance | Version: 3 | Generated on: 2026-07-10 22:43:43

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`provider_affiliation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Affiliation business metrics"
  source: "`vibe_health_insurance_v1`.`provider`.`affiliation`"
  dimensions:
    - name: "Accepting New Patients Flag"
      expr: accepting_new_patients_flag
    - name: "Admitting Privileges Flag"
      expr: admitting_privileges_flag
    - name: "Affiliation Status"
      expr: affiliation_status
    - name: "Affiliation Type"
      expr: affiliation_type
    - name: "Billing Npi"
      expr: billing_npi
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Credentialing Verification Date"
      expr: credentialing_verification_date
    - name: "Department Name"
      expr: department_name
    - name: "Directory Display Flag"
      expr: directory_display_flag
    - name: "End Date"
      expr: end_date
    - name: "Last Updated By"
      expr: last_updated_by
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "Medical Staff Category"
      expr: medical_staff_category
    - name: "Network Participation Flag"
      expr: network_participation_flag
    - name: "Next Credentialing Due Date"
      expr: next_credentialing_due_date
    - name: "Notes"
      expr: notes
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Affiliation"
      expr: COUNT(DISTINCT affiliation_id)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`provider_directory_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Directory Entry business metrics"
  source: "`vibe_health_insurance_v1`.`provider`.`directory_entry`"
  dimensions:
    - name: "Accepting New Patients Flag"
      expr: accepting_new_patients_flag
    - name: "Accessibility Features"
      expr: accessibility_features
    - name: "Attestation Method"
      expr: attestation_method
    - name: "Attestation Status"
      expr: attestation_status
    - name: "Board Certifications"
      expr: board_certifications
    - name: "Directory Display Name"
      expr: directory_display_name
    - name: "Directory Publication Date"
      expr: directory_publication_date
    - name: "Gender"
      expr: gender
    - name: "Graduation Year"
      expr: graduation_year
    - name: "Hospital Affiliation"
      expr: hospital_affiliation
    - name: "Languages Spoken"
      expr: languages_spoken
    - name: "Last Verified Date"
      expr: last_verified_date
    - name: "Medical School"
      expr: medical_school
    - name: "Network Tier"
      expr: network_tier
    - name: "Next Verification Due Date"
      expr: next_verification_due_date
    - name: "Npi"
      expr: npi
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Directory Entry"
      expr: COUNT(DISTINCT directory_entry_id)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`provider_facility`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Facility business metrics"
  source: "`vibe_health_insurance_v1`.`provider`.`facility`"
  dimensions:
    - name: "Accepting New Patients Flag"
      expr: accepting_new_patients_flag
    - name: "Address Line 1"
      expr: address_line_1
    - name: "Address Line 2"
      expr: address_line_2
    - name: "Bed Count"
      expr: bed_count
    - name: "Ccn"
      expr: ccn
    - name: "City"
      expr: city
    - name: "Clia Number"
      expr: clia_number
    - name: "County Name"
      expr: county_name
    - name: "Credentialing Effective Date"
      expr: credentialing_effective_date
    - name: "Credentialing Expiration Date"
      expr: credentialing_expiration_date
    - name: "Credentialing Status"
      expr: credentialing_status
    - name: "Critical Access Hospital Flag"
      expr: critical_access_hospital_flag
    - name: "Effective Date"
      expr: effective_date
    - name: "Email Address"
      expr: email_address
    - name: "Emergency Services Flag"
      expr: emergency_services_flag
    - name: "Facility Type"
      expr: facility_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Facility"
      expr: COUNT(DISTINCT facility_id)
    - name: "Total Quality Rating"
      expr: SUM(quality_rating)
    - name: "Average Quality Rating"
      expr: AVG(quality_rating)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`provider_group_practice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Group Practice business metrics"
  source: "`vibe_health_insurance_v1`.`provider`.`group_practice`"
  dimensions:
    - name: "Accepting New Patients"
      expr: accepting_new_patients
    - name: "Accessibility Accommodations"
      expr: accessibility_accommodations
    - name: "Aco Name"
      expr: aco_name
    - name: "Aco Participant"
      expr: aco_participant
    - name: "Address Line 1"
      expr: address_line_1
    - name: "Address Line 2"
      expr: address_line_2
    - name: "City"
      expr: city
    - name: "Cms Certification Number"
      expr: cms_certification_number
    - name: "County"
      expr: county
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Credentialing Date"
      expr: credentialing_date
    - name: "Credentialing Status"
      expr: credentialing_status
    - name: "Data Source System"
      expr: data_source_system
    - name: "Doing Business As Name"
      expr: doing_business_as_name
    - name: "Effective Date"
      expr: effective_date
    - name: "Email Address"
      expr: email_address
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Group Practice"
      expr: COUNT(DISTINCT group_practice_id)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`provider_license`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "License business metrics"
  source: "`vibe_health_insurance_v1`.`provider`.`license`"
  dimensions:
    - name: "Attestation Date"
      expr: attestation_date
    - name: "Authorized Schedules"
      expr: authorized_schedules
    - name: "Compact Participation Flag"
      expr: compact_participation_flag
    - name: "Compact Privilege States"
      expr: compact_privilege_states
    - name: "Compact Type"
      expr: compact_type
    - name: "Continuing Education Required Flag"
      expr: continuing_education_required_flag
    - name: "Disciplinary Action Date"
      expr: disciplinary_action_date
    - name: "Disciplinary Action Details"
      expr: disciplinary_action_details
    - name: "Disciplinary Action Flag"
      expr: disciplinary_action_flag
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Issue Date"
      expr: issue_date
    - name: "Issuing Authority"
      expr: issuing_authority
    - name: "Issuing State"
      expr: issuing_state
    - name: "License Status"
      expr: license_status
    - name: "License Type"
      expr: license_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct License"
      expr: COUNT(DISTINCT license_id)
    - name: "Total Continuing Education Hours Required"
      expr: SUM(continuing_education_hours_required)
    - name: "Average Continuing Education Hours Required"
      expr: AVG(continuing_education_hours_required)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`provider_participation_status`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Participation Status business metrics"
  source: "`vibe_health_insurance_v1`.`provider`.`participation_status`"
  dimensions:
    - name: "Accepting New Patients Flag"
      expr: accepting_new_patients_flag
    - name: "Claims Adjudication Flag"
      expr: claims_adjudication_flag
    - name: "Code"
      expr: code
    - name: "Continuity Of Care End Date"
      expr: continuity_of_care_end_date
    - name: "Credentialing Approval Date"
      expr: credentialing_approval_date
    - name: "Credentialing Status"
      expr: credentialing_status
    - name: "Current Record Flag"
      expr: current_record_flag
    - name: "Directory Display Flag"
      expr: directory_display_flag
    - name: "Effective Date"
      expr: effective_date
    - name: "Lob Code"
      expr: lob_code
    - name: "Member Notification Date"
      expr: member_notification_date
    - name: "Member Notification Method"
      expr: member_notification_method
    - name: "Name"
      expr: name
    - name: "Network Tier Code"
      expr: network_tier_code
    - name: "Next Recredentialing Date"
      expr: next_recredentialing_date
    - name: "Panel Status"
      expr: panel_status
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Participation Status"
      expr: COUNT(DISTINCT participation_status_id)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`provider_practice_location`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Practice Location business metrics"
  source: "`vibe_health_insurance_v1`.`provider`.`practice_location`"
  dimensions:
    - name: "Accepting New Patients Flag"
      expr: accepting_new_patients_flag
    - name: "Ada Compliant Flag"
      expr: ada_compliant_flag
    - name: "Address Line 1"
      expr: address_line_1
    - name: "Address Line 2"
      expr: address_line_2
    - name: "City"
      expr: city
    - name: "County Name"
      expr: county_name
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Directory Display Flag"
      expr: directory_display_flag
    - name: "Effective Date"
      expr: effective_date
    - name: "Email Address"
      expr: email_address
    - name: "Fax Number"
      expr: fax_number
    - name: "Fips Code"
      expr: fips_code
    - name: "Languages Spoken"
      expr: languages_spoken
    - name: "Last Verified Date"
      expr: last_verified_date
    - name: "Location Name"
      expr: location_name
    - name: "Location Type"
      expr: location_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Practice Location"
      expr: COUNT(DISTINCT practice_location_id)
    - name: "Total Latitude"
      expr: SUM(latitude)
    - name: "Average Latitude"
      expr: AVG(latitude)
    - name: "Total Longitude"
      expr: SUM(longitude)
    - name: "Average Longitude"
      expr: AVG(longitude)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`provider_provider`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provider business metrics"
  source: "`vibe_health_insurance_v1`.`provider`.`provider`"
  dimensions:
    - name: "Address Line1"
      expr: address_line1
    - name: "Address Line2"
      expr: address_line2
    - name: "Board Certification Summary Status"
      expr: board_certification_summary_status
    - name: "Board Certifications"
      expr: board_certifications
    - name: "Category"
      expr: category
    - name: "City"
      expr: city
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Credentialing Status"
      expr: credentialing_status
    - name: "Cultural Competency Certifications"
      expr: cultural_competency_certifications
    - name: "Date Of Birth"
      expr: date_of_birth
    - name: "Dea Number"
      expr: dea_number
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Email Address"
      expr: email_address
    - name: "First Name"
      expr: first_name
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Provider"
      expr: COUNT(DISTINCT provider_id)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`provider_specialty`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Specialty business metrics"
  source: "`vibe_health_insurance_v1`.`provider`.`specialty`"
  dimensions:
    - name: "Accepting New Patients Flag"
      expr: accepting_new_patients_flag
    - name: "Board Certified Flag"
      expr: board_certified_flag
    - name: "Category"
      expr: category
    - name: "Certification Date"
      expr: certification_date
    - name: "Certification Expiration Date"
      expr: certification_expiration_date
    - name: "Certification Number"
      expr: certification_number
    - name: "Certifying Board Name"
      expr: certifying_board_name
    - name: "Code"
      expr: code
    - name: "Credentialing Effective Date"
      expr: credentialing_effective_date
    - name: "Credentialing End Date"
      expr: credentialing_end_date
    - name: "Credentialing Review Date"
      expr: credentialing_review_date
    - name: "Credentialing Status"
      expr: credentialing_status
    - name: "Current Record Flag"
      expr: current_record_flag
    - name: "End Date"
      expr: end_date
    - name: "Fellowship Completed Flag"
      expr: fellowship_completed_flag
    - name: "Fellowship Completion Date"
      expr: fellowship_completion_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Specialty"
      expr: COUNT(DISTINCT specialty_id)
$$;