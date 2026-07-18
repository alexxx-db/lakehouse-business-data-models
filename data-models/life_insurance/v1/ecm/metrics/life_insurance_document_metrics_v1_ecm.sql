-- Metric views for domain: document | Business: Life Insurance | Version: 1 | Generated on: 2026-05-04 03:45:41

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`document_access_log`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Access Log business metrics"
  source: "`life_insurance_ecm`.`document`.`access_log`"
  dimensions:
    - name: "Access Authorized Flag"
      expr: access_authorized_flag
    - name: "Access Channel"
      expr: access_channel
    - name: "Access Denied Reason"
      expr: access_denied_reason
    - name: "Access Device Type"
      expr: access_device_type
    - name: "Access Duration Seconds"
      expr: access_duration_seconds
    - name: "Access Timestamp"
      expr: access_timestamp
    - name: "Access Type"
      expr: access_type
    - name: "Accessor Name"
      expr: accessor_name
    - name: "Accessor Role"
      expr: accessor_role
    - name: "Audit Trail Retention Years"
      expr: audit_trail_retention_years
    - name: "Business Justification Code"
      expr: business_justification_code
    - name: "Claim Number"
      expr: claim_number
    - name: "Consent Date"
      expr: consent_date
    - name: "Consent On File Flag"
      expr: consent_on_file_flag
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Access Log"
      expr: COUNT(DISTINCT access_log_id)
    - name: "Total Anomaly Score"
      expr: SUM(anomaly_score)
    - name: "Average Anomaly Score"
      expr: AVG(anomaly_score)
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`document_acord_form`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Acord Form business metrics"
  source: "`life_insurance_ecm`.`document`.`acord_form`"
  dimensions:
    - name: "Aml Kyc Required Flag"
      expr: aml_kyc_required_flag
    - name: "Applicable States"
      expr: applicable_states
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "E Delivery Eligible Flag"
      expr: e_delivery_eligible_flag
    - name: "Effective Date"
      expr: effective_date
    - name: "Electronic Signature Allowed Flag"
      expr: electronic_signature_allowed_flag
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Form Category"
      expr: form_category
    - name: "Form Description"
      expr: form_description
    - name: "Form Language"
      expr: form_language
    - name: "Form Name"
      expr: form_name
    - name: "Form Number"
      expr: form_number
    - name: "Form Purpose"
      expr: form_purpose
    - name: "Form Status"
      expr: form_status
    - name: "Form Template Url"
      expr: form_template_url
    - name: "Form Version"
      expr: form_version
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Acord Form"
      expr: COUNT(DISTINCT acord_form_id)
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`document_correspondence_link`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Correspondence Link business metrics"
  source: "`life_insurance_ecm`.`document`.`correspondence_link`"
  dimensions:
    - name: "Attachment Flag"
      expr: attachment_flag
    - name: "Audit Trail Reference"
      expr: audit_trail_reference
    - name: "Business Context"
      expr: business_context
    - name: "Confidentiality Level"
      expr: confidentiality_level
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Direction"
      expr: direction
    - name: "Legal Hold Flag"
      expr: legal_hold_flag
    - name: "Link Method"
      expr: link_method
    - name: "Link Status"
      expr: link_status
    - name: "Link Type"
      expr: link_type
    - name: "Linked By System"
      expr: linked_by_system
    - name: "Linked Date"
      expr: linked_date
    - name: "Linked Timestamp"
      expr: linked_timestamp
    - name: "Notes"
      expr: notes
    - name: "Primary Document Flag"
      expr: primary_document_flag
    - name: "Regulatory Reportable Flag"
      expr: regulatory_reportable_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Correspondence Link"
      expr: COUNT(DISTINCT correspondence_link_id)
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`document_delivery_consent`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Delivery Consent business metrics"
  source: "`life_insurance_ecm`.`document`.`delivery_consent`"
  dimensions:
    - name: "Alternate Email Address"
      expr: alternate_email_address
    - name: "Bounce Count"
      expr: bounce_count
    - name: "Consent Date"
      expr: consent_date
    - name: "Consent Device Type"
      expr: consent_device_type
    - name: "Consent Ip Address"
      expr: consent_ip_address
    - name: "Consent Language"
      expr: consent_language
    - name: "Consent Method"
      expr: consent_method
    - name: "Consent Scope"
      expr: consent_scope
    - name: "Consent Status"
      expr: consent_status
    - name: "Consent Timestamp"
      expr: consent_timestamp
    - name: "Consent User Agent"
      expr: consent_user_agent
    - name: "Consent Version"
      expr: consent_version
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Classification"
      expr: data_classification
    - name: "Effective Date"
      expr: effective_date
    - name: "Email Address"
      expr: email_address
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Delivery Consent"
      expr: COUNT(DISTINCT delivery_consent_id)
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`document_delivery_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Delivery Event business metrics"
  source: "`life_insurance_ecm`.`document`.`delivery_event`"
  dimensions:
    - name: "Audit Trail Reference"
      expr: audit_trail_reference
    - name: "Confirmation Receipt Timestamp"
      expr: confirmation_receipt_timestamp
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Delivery Batch Number"
      expr: delivery_batch_number
    - name: "Delivery Channel"
      expr: delivery_channel
    - name: "Delivery Method Preference"
      expr: delivery_method_preference
    - name: "Delivery Priority"
      expr: delivery_priority
    - name: "Delivery Status"
      expr: delivery_status
    - name: "Delivery Timestamp"
      expr: delivery_timestamp
    - name: "Document Type"
      expr: document_type
    - name: "Document Version"
      expr: document_version
    - name: "Encryption Flag"
      expr: encryption_flag
    - name: "Failure Code"
      expr: failure_code
    - name: "Failure Reason"
      expr: failure_reason
    - name: "Fallback To Paper Flag"
      expr: fallback_to_paper_flag
    - name: "Ip Address"
      expr: ip_address
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Delivery Event"
      expr: COUNT(DISTINCT delivery_event_id)
    - name: "Total Sla Target Hours"
      expr: SUM(sla_target_hours)
    - name: "Average Sla Target Hours"
      expr: AVG(sla_target_hours)
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`document_document`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Document business metrics"
  source: "`life_insurance_ecm`.`document`.`document`"
  dimensions:
    - name: "Archived Timestamp"
      expr: archived_timestamp
    - name: "Confidentiality Level"
      expr: confidentiality_level
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Destroyed Timestamp"
      expr: destroyed_timestamp
    - name: "Document Category"
      expr: document_category
    - name: "Document Description"
      expr: document_description
    - name: "Document Number"
      expr: document_number
    - name: "E Delivery Consent Flag"
      expr: e_delivery_consent_flag
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiration Date"
      expr: expiration_date
    - name: "File Format"
      expr: file_format
    - name: "Hash"
      expr: hash
    - name: "Indexed Timestamp"
      expr: indexed_timestamp
    - name: "Is Latest Version"
      expr: is_latest_version
    - name: "Jurisdiction Code"
      expr: jurisdiction_code
    - name: "Legal Hold Flag"
      expr: legal_hold_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Document"
      expr: COUNT(DISTINCT document_id)
    - name: "Total File Size Bytes"
      expr: SUM(file_size_bytes)
    - name: "Average File Size Bytes"
      expr: AVG(file_size_bytes)
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`document_document_type`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Document Type business metrics"
  source: "`life_insurance_ecm`.`document`.`document_type`"
  dimensions:
    - name: "Acord Form Number"
      expr: acord_form_number
    - name: "Approval Required Flag"
      expr: approval_required_flag
    - name: "Category"
      expr: document_type_category
    - name: "Code"
      expr: code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Customer Facing Flag"
      expr: customer_facing_flag
    - name: "Default Mime Type"
      expr: default_mime_type
    - name: "Description"
      expr: description
    - name: "Disclosure Type"
      expr: disclosure_type
    - name: "E Delivery Eligible Flag"
      expr: e_delivery_eligible_flag
    - name: "E Signature Allowed Flag"
      expr: e_signature_allowed_flag
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Imaging Required Flag"
      expr: imaging_required_flag
    - name: "Name"
      expr: name
    - name: "Nigo Tracking Enabled Flag"
      expr: nigo_tracking_enabled_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Document Type"
      expr: COUNT(DISTINCT document_type_id)
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`document_legal_hold`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Legal Hold business metrics"
  source: "`life_insurance_ecm`.`document`.`legal_hold`"
  dimensions:
    - name: "Acknowledgment Count"
      expr: acknowledgment_count
    - name: "Acknowledgment Required Flag"
      expr: acknowledgment_required_flag
    - name: "Affected Claim Count"
      expr: affected_claim_count
    - name: "Affected Document Count"
      expr: affected_document_count
    - name: "Affected Policy Count"
      expr: affected_policy_count
    - name: "Automated Purge Suspended Flag"
      expr: automated_purge_suspended_flag
    - name: "Chain Of Custody Log"
      expr: chain_of_custody_log
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Custodian Of Record"
      expr: custodian_of_record
    - name: "Date Range End"
      expr: date_range_end
    - name: "Date Range Start"
      expr: date_range_start
    - name: "Document Type Scope"
      expr: document_type_scope
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiration Date"
      expr: expiration_date
    - name: "External Counsel Firm"
      expr: external_counsel_firm
    - name: "Hold Number"
      expr: hold_number
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Legal Hold"
      expr: COUNT(DISTINCT legal_hold_id)
    - name: "Total Actual Cost"
      expr: SUM(actual_cost)
    - name: "Average Actual Cost"
      expr: AVG(actual_cost)
    - name: "Total Estimated Cost"
      expr: SUM(estimated_cost)
    - name: "Average Estimated Cost"
      expr: AVG(estimated_cost)
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`document_nigo_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Nigo Record business metrics"
  source: "`life_insurance_ecm`.`document`.`nigo_record`"
  dimensions:
    - name: "Aging Days"
      expr: aging_days
    - name: "Compliance Notes"
      expr: compliance_notes
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Deficiency Description"
      expr: deficiency_description
    - name: "Distribution Channel"
      expr: distribution_channel
    - name: "Due Date"
      expr: due_date
    - name: "Escalation Date"
      expr: escalation_date
    - name: "Escalation Flag"
      expr: escalation_flag
    - name: "Escalation Reason"
      expr: escalation_reason
    - name: "Estimated Delay Days"
      expr: estimated_delay_days
    - name: "Follow Up Count"
      expr: follow_up_count
    - name: "Identified Date"
      expr: identified_date
    - name: "Impact On Issue Date"
      expr: impact_on_issue_date
    - name: "Last Follow Up Date"
      expr: last_follow_up_date
    - name: "Last Modified By"
      expr: last_modified_by
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Nigo Record"
      expr: COUNT(DISTINCT nigo_record_id)
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`document_package`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Package business metrics"
  source: "`life_insurance_ecm`.`document`.`package`"
  dimensions:
    - name: "Assembly Date"
      expr: assembly_date
    - name: "Assigned Date"
      expr: assigned_date
    - name: "Completion Date"
      expr: completion_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Delivery Method"
      expr: delivery_method
    - name: "E Delivery Consent Date"
      expr: e_delivery_consent_date
    - name: "E Delivery Consent Flag"
      expr: e_delivery_consent_flag
    - name: "External Reference Number"
      expr: external_reference_number
    - name: "Imaging Batch Number"
      expr: imaging_batch_number
    - name: "Imaging Date"
      expr: imaging_date
    - name: "Nigo Date"
      expr: nigo_date
    - name: "Nigo Flag"
      expr: nigo_flag
    - name: "Nigo Reason"
      expr: nigo_reason
    - name: "Notes"
      expr: notes
    - name: "Optional Document Count"
      expr: optional_document_count
    - name: "Package Description"
      expr: package_description
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Package"
      expr: COUNT(DISTINCT package_id)
    - name: "Total Completeness Percentage"
      expr: SUM(completeness_percentage)
    - name: "Average Completeness Percentage"
      expr: AVG(completeness_percentage)
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`document_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Request business metrics"
  source: "`life_insurance_ecm`.`document`.`request`"
  dimensions:
    - name: "Acknowledgment Date"
      expr: acknowledgment_date
    - name: "Aging Days"
      expr: aging_days
    - name: "Business Transaction Type"
      expr: business_transaction_type
    - name: "Cancellation Date"
      expr: cancellation_date
    - name: "Cancellation Reason"
      expr: cancellation_reason
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Delivery Method"
      expr: delivery_method
    - name: "Due Date"
      expr: due_date
    - name: "External Reference Number"
      expr: external_reference_number
    - name: "Follow Up Count"
      expr: follow_up_count
    - name: "Follow Up Schedule"
      expr: follow_up_schedule
    - name: "Last Follow Up Date"
      expr: last_follow_up_date
    - name: "Next Follow Up Date"
      expr: next_follow_up_date
    - name: "Nigo Flag"
      expr: nigo_flag
    - name: "Notes"
      expr: notes
    - name: "Priority Level"
      expr: priority_level
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Request"
      expr: COUNT(DISTINCT request_id)
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`document_retention_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Retention Schedule business metrics"
  source: "`life_insurance_ecm`.`document`.`retention_schedule`"
  dimensions:
    - name: "Acord Form Indicator"
      expr: acord_form_indicator
    - name: "Approval Authority"
      expr: approval_authority
    - name: "Approval Date"
      expr: approval_date
    - name: "Audit Trail Required"
      expr: audit_trail_required
    - name: "Business Justification"
      expr: business_justification
    - name: "Destruction Authorization Required"
      expr: destruction_authorization_required
    - name: "Destruction Method"
      expr: destruction_method
    - name: "Document Type Code"
      expr: document_type_code
    - name: "E Delivery Eligible"
      expr: e_delivery_eligible
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Exception Process Available"
      expr: exception_process_available
    - name: "Jurisdiction Code"
      expr: jurisdiction_code
    - name: "Last Review Date"
      expr: last_review_date
    - name: "Legal Hold Override Allowed"
      expr: legal_hold_override_allowed
    - name: "Line Of Business"
      expr: line_of_business
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Retention Schedule"
      expr: COUNT(DISTINCT retention_schedule_id)
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`document_signature`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Signature business metrics"
  source: "`life_insurance_ecm`.`document`.`signature`"
  dimensions:
    - name: "Audit Trail Url"
      expr: audit_trail_url
    - name: "Authentication Method"
      expr: authentication_method
    - name: "Certificate Reference"
      expr: certificate_reference
    - name: "Consent Timestamp"
      expr: consent_timestamp
    - name: "Consent To Electronic Signature"
      expr: consent_to_electronic_signature
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Decline Reason"
      expr: decline_reason
    - name: "Device Type"
      expr: device_type
    - name: "Esignature Platform"
      expr: esignature_platform
    - name: "Expiration Timestamp"
      expr: expiration_timestamp
    - name: "Image Url"
      expr: image_url
    - name: "Ip Address"
      expr: ip_address
    - name: "Legal Validity Flag"
      expr: legal_validity_flag
    - name: "Notary Commission Number"
      expr: notary_commission_number
    - name: "Notary Expiration Date"
      expr: notary_expiration_date
    - name: "Notary State"
      expr: notary_state
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Signature"
      expr: COUNT(DISTINCT signature_id)
    - name: "Total Geolocation Latitude"
      expr: SUM(geolocation_latitude)
    - name: "Average Geolocation Latitude"
      expr: AVG(geolocation_latitude)
    - name: "Total Geolocation Longitude"
      expr: SUM(geolocation_longitude)
    - name: "Average Geolocation Longitude"
      expr: AVG(geolocation_longitude)
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`document_template`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Template business metrics"
  source: "`life_insurance_ecm`.`document`.`template`"
  dimensions:
    - name: "Acord Form Indicator"
      expr: acord_form_indicator
    - name: "Aml Kyc Required Flag"
      expr: aml_kyc_required_flag
    - name: "Applicable Jurisdictions"
      expr: applicable_jurisdictions
    - name: "Approval Authority"
      expr: approval_authority
    - name: "Approval Date"
      expr: approval_date
    - name: "Authoring System"
      expr: authoring_system
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Doi Approval Date"
      expr: doi_approval_date
    - name: "Doi Approval Number"
      expr: doi_approval_number
    - name: "Doi Approval Status"
      expr: doi_approval_status
    - name: "E Delivery Eligible Flag"
      expr: e_delivery_eligible_flag
    - name: "Effective Date"
      expr: effective_date
    - name: "Electronic Signature Allowed Flag"
      expr: electronic_signature_allowed_flag
    - name: "Expiration Date"
      expr: expiration_date
    - name: "File Path"
      expr: file_path
    - name: "Format"
      expr: format
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Template"
      expr: COUNT(DISTINCT template_id)
    - name: "Total Usage Count"
      expr: SUM(usage_count)
    - name: "Average Usage Count"
      expr: AVG(usage_count)
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`document_version`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Version business metrics"
  source: "`life_insurance_ecm`.`document`.`version`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Approver Name"
      expr: approver_name
    - name: "Author Name"
      expr: author_name
    - name: "Author Role"
      expr: author_role
    - name: "Change Reason"
      expr: change_reason
    - name: "Checksum Hash"
      expr: checksum_hash
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective Date"
      expr: effective_date
    - name: "Eligible For Purge Date"
      expr: eligible_for_purge_date
    - name: "Encryption Method"
      expr: encryption_method
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Extracted Text Available"
      expr: extracted_text_available
    - name: "File Format"
      expr: file_format
    - name: "Hash Algorithm"
      expr: hash_algorithm
    - name: "Is Digitally Signed"
      expr: is_digitally_signed
    - name: "Is Encrypted"
      expr: is_encrypted
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Version"
      expr: COUNT(DISTINCT version_id)
    - name: "Total File Size Bytes"
      expr: SUM(file_size_bytes)
    - name: "Average File Size Bytes"
      expr: AVG(file_size_bytes)
    - name: "Total Ocr Confidence Score"
      expr: SUM(ocr_confidence_score)
    - name: "Average Ocr Confidence Score"
      expr: AVG(ocr_confidence_score)
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`document_workflow`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workflow business metrics"
  source: "`life_insurance_ecm`.`document`.`workflow`"
  dimensions:
    - name: "Assigned Queue"
      expr: assigned_queue
    - name: "Completed Timestamp"
      expr: completed_timestamp
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Current Stage"
      expr: current_stage
    - name: "Entry Timestamp"
      expr: entry_timestamp
    - name: "Error Count"
      expr: error_count
    - name: "Escalation Level"
      expr: escalation_level
    - name: "Escalation Reason"
      expr: escalation_reason
    - name: "External Reference Number"
      expr: external_reference_number
    - name: "Imaging System Reference"
      expr: imaging_system_reference
    - name: "Initiated Timestamp"
      expr: initiated_timestamp
    - name: "Nigo Date"
      expr: nigo_date
    - name: "Nigo Flag"
      expr: nigo_flag
    - name: "Nigo Reason"
      expr: nigo_reason
    - name: "Notes"
      expr: notes
    - name: "Prior Stage"
      expr: prior_stage
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Workflow"
      expr: COUNT(DISTINCT workflow_id)
    - name: "Total Imaging Batch Number"
      expr: SUM(imaging_batch_number)
    - name: "Average Imaging Batch Number"
      expr: AVG(imaging_batch_number)
$$;
