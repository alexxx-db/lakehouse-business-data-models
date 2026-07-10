-- Metric views for domain: provider | Business: Healthcare | Version: 2 | Generated on: 2026-07-10 16:21:12

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`provider_board_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Board Certification business metrics"
  source: "`vibe_healthcare_v1`.`provider`.`board_certification`"
  dimensions:
    - name: "Caqh Provider Number"
      expr: caqh_provider_number
    - name: "Certification Number"
      expr: certification_number
    - name: "Certification Status"
      expr: certification_status
    - name: "Certification Type"
      expr: certification_type
    - name: "Certifying Board Code"
      expr: certifying_board_code
    - name: "Certifying Board Name"
      expr: certifying_board_name
    - name: "Certifying Organization Type"
      expr: certifying_organization_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective Date"
      expr: effective_date
    - name: "Exam Attempt Number"
      expr: exam_attempt_number
    - name: "Exam Pass Date"
      expr: exam_pass_date
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Initial Certification Date"
      expr: initial_certification_date
    - name: "Is Active Privileges Required"
      expr: is_active_privileges_required
    - name: "Is Lifetime Certification"
      expr: is_lifetime_certification
    - name: "Is Primary Specialty"
      expr: is_primary_specialty
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Board Certification"
      expr: COUNT(DISTINCT board_certification_id)
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`provider_clinician`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Clinician business metrics"
  source: "`vibe_healthcare_v1`.`provider`.`clinician`"
  dimensions:
    - name: "Board Certification Expiration Date"
      expr: board_certification_expiration_date
    - name: "Board Certified"
      expr: board_certified
    - name: "Caqh Provider Number"
      expr: caqh_provider_number
    - name: "Clinician Type"
      expr: clinician_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Credentialing Expiration Date"
      expr: credentialing_expiration_date
    - name: "Credentialing Status"
      expr: credentialing_status
    - name: "Date Of Birth"
      expr: date_of_birth
    - name: "Dea Number"
      expr: dea_number
    - name: "Employment Status"
      expr: employment_status
    - name: "Employment Type"
      expr: employment_type
    - name: "Fellowship Completion Date"
      expr: fellowship_completion_date
    - name: "Fellowship Program Name"
      expr: fellowship_program_name
    - name: "First Name"
      expr: first_name
    - name: "Gender"
      expr: gender
    - name: "Hire Date"
      expr: hire_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Clinician"
      expr: COUNT(DISTINCT clinician_id)
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`provider_credentialing_application`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Credentialing Application business metrics"
  source: "`vibe_healthcare_v1`.`provider`.`credentialing_application`"
  dimensions:
    - name: "Application Number"
      expr: application_number
    - name: "Application Status"
      expr: application_status
    - name: "Application Type"
      expr: application_type
    - name: "Board Certification Status"
      expr: board_certification_status
    - name: "Caqh Provider Number"
      expr: caqh_provider_number
    - name: "Cme Compliance Status"
      expr: cme_compliance_status
    - name: "Committee Review Date"
      expr: committee_review_date
    - name: "Complete Date"
      expr: complete_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Dea Number"
      expr: dea_number
    - name: "Decision Date"
      expr: decision_date
    - name: "Decision Type"
      expr: decision_type
    - name: "Denial Reason"
      expr: denial_reason
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Malpractice Coverage Type"
      expr: malpractice_coverage_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Credentialing Application"
      expr: COUNT(DISTINCT credentialing_application_id)
    - name: "Total Malpractice Aggregate Limit"
      expr: SUM(malpractice_aggregate_limit)
    - name: "Average Malpractice Aggregate Limit"
      expr: AVG(malpractice_aggregate_limit)
    - name: "Total Malpractice Per Occurrence Limit"
      expr: SUM(malpractice_per_occurrence_limit)
    - name: "Average Malpractice Per Occurrence Limit"
      expr: AVG(malpractice_per_occurrence_limit)
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`provider_dea_registration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dea Registration business metrics"
  source: "`vibe_healthcare_v1`.`provider`.`dea_registration`"
  dimensions:
    - name: "Business Activity Type"
      expr: business_activity_type
    - name: "Days Until Expiration"
      expr: days_until_expiration
    - name: "Dea Number"
      expr: dea_number
    - name: "Expiration Alert Date"
      expr: expiration_alert_date
    - name: "Expiration Alert Sent"
      expr: expiration_alert_sent
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Fee Exempt"
      expr: fee_exempt
    - name: "Notes"
      expr: notes
    - name: "Npi Number"
      expr: npi_number
    - name: "Payment Date"
      expr: payment_date
    - name: "Pdmp Reporting Required"
      expr: pdmp_reporting_required
    - name: "Record Created Timestamp"
      expr: record_created_timestamp
    - name: "Record Updated Timestamp"
      expr: record_updated_timestamp
    - name: "Registered Address Line1"
      expr: registered_address_line1
    - name: "Registered Address Line2"
      expr: registered_address_line2
    - name: "Registered City"
      expr: registered_city
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Dea Registration"
      expr: COUNT(DISTINCT dea_registration_id)
    - name: "Total Fee Amount"
      expr: SUM(fee_amount)
    - name: "Average Fee Amount"
      expr: AVG(fee_amount)
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`provider_group`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Group business metrics"
  source: "`vibe_healthcare_v1`.`provider`.`group`"
  dimensions:
    - name: "Accepts New Patients"
      expr: accepts_new_patients
    - name: "Aco Participant"
      expr: aco_participant
    - name: "Admin Contact Email"
      expr: admin_contact_email
    - name: "Billing Entity Name"
      expr: billing_entity_name
    - name: "Billing Npi"
      expr: billing_npi
    - name: "Contract Effective Date"
      expr: contract_effective_date
    - name: "Contract Termination Date"
      expr: contract_termination_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Credentialing Expiration Date"
      expr: credentialing_expiration_date
    - name: "Credentialing Status"
      expr: credentialing_status
    - name: "Doing Business As Name"
      expr: doing_business_as_name
    - name: "Effective Date"
      expr: effective_date
    - name: "Fqhc Designation"
      expr: fqhc_designation
    - name: "Group Status"
      expr: group_status
    - name: "Group Type"
      expr: group_type
    - name: "Hl7 Fhir Organization Reference"
      expr: hl7_fhir_organization_reference
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Group"
      expr: COUNT(DISTINCT group_id)
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`provider_group_membership`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Group Membership business metrics"
  source: "`vibe_healthcare_v1`.`provider`.`group_membership`"
  dimensions:
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective Date"
      expr: effective_date
    - name: "Employment Type"
      expr: employment_type
    - name: "Is Primary Group"
      expr: is_primary_group
    - name: "Membership Role"
      expr: membership_role
    - name: "Membership Status"
      expr: membership_status
    - name: "Termination Date"
      expr: termination_date
    - name: "Updated Timestamp"
      expr: updated_timestamp
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
    - name: "Effective Date Month"
      expr: DATE_TRUNC('MONTH', effective_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Group Membership"
      expr: COUNT(DISTINCT group_membership_id)
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`provider_location`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Location business metrics"
  source: "`vibe_healthcare_v1`.`provider`.`location`"
  dimensions:
    - name: "Accepting New Patients Updated Date"
      expr: accepting_new_patients_updated_date
    - name: "Address Line1"
      expr: address_line1
    - name: "Address Line2"
      expr: address_line2
    - name: "After Hours Phone"
      expr: after_hours_phone
    - name: "Appointment Scheduling Url"
      expr: appointment_scheduling_url
    - name: "City"
      expr: city
    - name: "Cms Enrollment Number"
      expr: cms_enrollment_number
    - name: "Cms Place Of Service Code"
      expr: cms_place_of_service_code
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Credentialing Status"
      expr: credentialing_status
    - name: "Directory Last Verified Date"
      expr: directory_last_verified_date
    - name: "Effective Date"
      expr: effective_date
    - name: "Email"
      expr: email
    - name: "Fax"
      expr: fax
    - name: "Hours Of Operation"
      expr: hours_of_operation
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Location"
      expr: COUNT(DISTINCT location_id)
    - name: "Total Latitude"
      expr: SUM(latitude)
    - name: "Average Latitude"
      expr: AVG(latitude)
    - name: "Total Longitude"
      expr: SUM(longitude)
    - name: "Average Longitude"
      expr: AVG(longitude)
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`provider_org_provider`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Org Provider business metrics"
  source: "`vibe_healthcare_v1`.`provider`.`org_provider`"
  dimensions:
    - name: "Accreditation Body"
      expr: accreditation_body
    - name: "Accreditation Expiration Date"
      expr: accreditation_expiration_date
    - name: "Accreditation Status"
      expr: accreditation_status
    - name: "Address Line1"
      expr: address_line1
    - name: "Address Line2"
      expr: address_line2
    - name: "Bed Count"
      expr: bed_count
    - name: "City"
      expr: city
    - name: "Cms Certification Number"
      expr: cms_certification_number
    - name: "County"
      expr: county
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Credentialing Expiration Date"
      expr: credentialing_expiration_date
    - name: "Credentialing Status"
      expr: credentialing_status
    - name: "Critical Access Hospital Flag"
      expr: critical_access_hospital_flag
    - name: "Disproportionate Share Flag"
      expr: disproportionate_share_flag
    - name: "Doing Business As Name"
      expr: doing_business_as_name
    - name: "Effective Date"
      expr: effective_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Org Provider"
      expr: COUNT(DISTINCT org_provider_id)
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`provider_payer_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payer Enrollment business metrics"
  source: "`vibe_healthcare_v1`.`provider`.`payer_enrollment`"
  dimensions:
    - name: "Application Submitted Date"
      expr: application_submitted_date
    - name: "Approval Date"
      expr: approval_date
    - name: "Billing Npi"
      expr: billing_npi
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Credentialing Expiration Date"
      expr: credentialing_expiration_date
    - name: "Credentialing Status"
      expr: credentialing_status
    - name: "Credentialing Tier"
      expr: credentialing_tier
    - name: "Dea Number"
      expr: dea_number
    - name: "Edi Submitter Code"
      expr: edi_submitter_code
    - name: "Effective Date"
      expr: effective_date
    - name: "Eft Enrolled"
      expr: eft_enrolled
    - name: "Enrollment Number"
      expr: enrollment_number
    - name: "Enrollment Source"
      expr: enrollment_source
    - name: "Enrollment Status"
      expr: enrollment_status
    - name: "Enrollment Type"
      expr: enrollment_type
    - name: "Group Npi"
      expr: group_npi
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Payer Enrollment"
      expr: COUNT(DISTINCT payer_enrollment_id)
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`provider_privileging`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Privileging business metrics"
  source: "`vibe_healthcare_v1`.`provider`.`privileging`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Board Certification Required"
      expr: board_certification_required
    - name: "Completed Case Volume"
      expr: completed_case_volume
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Delineation Form Version"
      expr: delineation_form_version
    - name: "Effective Date"
      expr: effective_date
    - name: "Emtala Covered"
      expr: emtala_covered
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Fppe Completion Date"
      expr: fppe_completion_date
    - name: "Fppe Required"
      expr: fppe_required
    - name: "Is Provisional"
      expr: is_provisional
    - name: "Malpractice Verified"
      expr: malpractice_verified
    - name: "Npdb Report Date"
      expr: npdb_report_date
    - name: "Npdb Report Required"
      expr: npdb_report_required
    - name: "Oppe Last Review Date"
      expr: oppe_last_review_date
    - name: "Privilege Category"
      expr: privilege_category
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Privileging"
      expr: COUNT(DISTINCT privileging_id)
    - name: "Total Peer Review Score"
      expr: SUM(peer_review_score)
    - name: "Average Peer Review Score"
      expr: AVG(peer_review_score)
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`provider_specialty`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Specialty business metrics"
  source: "`vibe_healthcare_v1`.`provider`.`specialty`"
  dimensions:
    - name: "Abms Board Name"
      expr: abms_board_name
    - name: "Acgme Program Code"
      expr: acgme_program_code
    - name: "Board Certification Body"
      expr: board_certification_body
    - name: "Board Certification Required"
      expr: board_certification_required
    - name: "Category"
      expr: category
    - name: "Cms Enrollment Specialty Type"
      expr: cms_enrollment_specialty_type
    - name: "Cms Specialty Code"
      expr: cms_specialty_code
    - name: "Code"
      expr: code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Dea Registration Required"
      expr: dea_registration_required
    - name: "Description"
      expr: description
    - name: "Display Order"
      expr: display_order
    - name: "Effective Date"
      expr: effective_date
    - name: "End Date"
      expr: end_date
    - name: "Fhir Practitioner Role Code"
      expr: fhir_practitioner_role_code
    - name: "Hedis Measure Set"
      expr: hedis_measure_set
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Specialty"
      expr: COUNT(DISTINCT specialty_id)
    - name: "Total Rvu Work Component"
      expr: SUM(rvu_work_component)
    - name: "Average Rvu Work Component"
      expr: AVG(rvu_work_component)
$$;