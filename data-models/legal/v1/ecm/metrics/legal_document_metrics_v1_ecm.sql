-- Metric views for domain: document | Business: Legal | Version: 1 | Generated on: 2026-05-07 11:56:28

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`document_custodian_hold`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Custodian Hold business metrics"
  source: "`legal_ecm`.`document`.`custodian_hold`"
  dimensions:
    - name: "Acknowledgement Date"
      expr: acknowledgement_date
    - name: "Acknowledgement Status"
      expr: acknowledgement_status
    - name: "Collection Completion Date"
      expr: collection_completion_date
    - name: "Collection Custodian Notes"
      expr: collection_custodian_notes
    - name: "Collection Method"
      expr: collection_method
    - name: "Collection Notes"
      expr: collection_notes
    - name: "Collection Start Date"
      expr: collection_start_date
    - name: "Collection Status"
      expr: collection_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Custodian Interview Date"
      expr: custodian_interview_date
    - name: "Custodian Interview Notes"
      expr: custodian_interview_notes
    - name: "Custodian Status"
      expr: custodian_status
    - name: "Escalation Count"
      expr: escalation_count
    - name: "Exemption Reason"
      expr: exemption_reason
    - name: "Interview Date"
      expr: interview_date
    - name: "Interview Notes"
      expr: interview_notes
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Custodian Hold"
      expr: COUNT(DISTINCT custodian_hold_id)
    - name: "Total Collection File Count"
      expr: SUM(collection_file_count)
    - name: "Average Collection File Count"
      expr: AVG(collection_file_count)
    - name: "Total Collection Volume Gb"
      expr: SUM(collection_volume_gb)
    - name: "Average Collection Volume Gb"
      expr: AVG(collection_volume_gb)
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`document_doc_access_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Doc Access Event business metrics"
  source: "`legal_ecm`.`document`.`doc_access_event`"
  dimensions:
    - name: "Access Authorized Flag"
      expr: access_authorized_flag
    - name: "Access Duration Seconds"
      expr: access_duration_seconds
    - name: "Access Method"
      expr: access_method
    - name: "Access Reason"
      expr: access_reason
    - name: "Access Source System"
      expr: access_source_system
    - name: "Access Timestamp"
      expr: access_timestamp
    - name: "Access Type"
      expr: access_type
    - name: "Compliance Review Notes"
      expr: compliance_review_notes
    - name: "Compliance Review Required Flag"
      expr: compliance_review_required_flag
    - name: "Compliance Review Status"
      expr: compliance_review_status
    - name: "Compliance Review Timestamp"
      expr: compliance_review_timestamp
    - name: "Document Classification"
      expr: document_classification
    - name: "Document Title"
      expr: document_title
    - name: "Document Type"
      expr: document_type
    - name: "Ethical Wall Status"
      expr: ethical_wall_status
    - name: "Lpp Breach Flag"
      expr: lpp_breach_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Doc Access Event"
      expr: COUNT(DISTINCT doc_access_event_id)
    - name: "Total Access Anomaly Score"
      expr: SUM(access_anomaly_score)
    - name: "Average Access Anomaly Score"
      expr: AVG(access_anomaly_score)
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`document_doc_annotation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Doc Annotation business metrics"
  source: "`legal_ecm`.`document`.`doc_annotation`"
  dimensions:
    - name: "Annotation Category"
      expr: annotation_category
    - name: "Annotation Length"
      expr: annotation_length
    - name: "Annotation Notes"
      expr: annotation_notes
    - name: "Annotation Status"
      expr: annotation_status
    - name: "Annotation Text"
      expr: annotation_text
    - name: "Annotation Timestamp"
      expr: annotation_timestamp
    - name: "Annotation Type"
      expr: annotation_type
    - name: "Approval Timestamp"
      expr: approval_timestamp
    - name: "Cal Training Set Flag"
      expr: cal_training_set_flag
    - name: "Chain Of Custody Flag"
      expr: chain_of_custody_flag
    - name: "Coding Decision"
      expr: coding_decision
    - name: "Highlight Color"
      expr: highlight_color
    - name: "Is Active"
      expr: is_active
    - name: "Issue Tag"
      expr: issue_tag
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Nlp Extracted Flag"
      expr: nlp_extracted_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Doc Annotation"
      expr: COUNT(DISTINCT doc_annotation_id)
    - name: "Total Confidence Score"
      expr: SUM(confidence_score)
    - name: "Average Confidence Score"
      expr: AVG(confidence_score)
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`document_doc_execution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Doc Execution business metrics"
  source: "`legal_ecm`.`document`.`doc_execution`"
  dimensions:
    - name: "Audit Trail Reference"
      expr: audit_trail_reference
    - name: "Board Resolution Reference"
      expr: board_resolution_reference
    - name: "Board Resolution Required Flag"
      expr: board_resolution_required_flag
    - name: "Compliance Review Completed Flag"
      expr: compliance_review_completed_flag
    - name: "Counterpart Count"
      expr: counterpart_count
    - name: "Counterpart Indicator"
      expr: counterpart_indicator
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective Date"
      expr: effective_date
    - name: "Executed Document Reference"
      expr: executed_document_reference
    - name: "Execution Date"
      expr: execution_date
    - name: "Execution Language"
      expr: execution_language
    - name: "Execution Location"
      expr: execution_location
    - name: "Execution Method"
      expr: execution_method
    - name: "Execution Notes"
      expr: execution_notes
    - name: "Execution Reference Number"
      expr: execution_reference_number
    - name: "Execution Status"
      expr: execution_status
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Doc Execution"
      expr: COUNT(DISTINCT doc_execution_id)
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`document_doc_folder`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Doc Folder business metrics"
  source: "`legal_ecm`.`document`.`doc_folder`"
  dimensions:
    - name: "Access Control Group"
      expr: access_control_group
    - name: "Archived Date"
      expr: archived_date
    - name: "Audit Log Enabled"
      expr: audit_log_enabled
    - name: "Closed Date"
      expr: closed_date
    - name: "Collaboration Enabled"
      expr: collaboration_enabled
    - name: "Confidentiality Agreement Required"
      expr: confidentiality_agreement_required
    - name: "Created By User Code"
      expr: created_by_user_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Dms Source System"
      expr: dms_source_system
    - name: "Doc Folder Description"
      expr: doc_folder_description
    - name: "Document Count"
      expr: document_count
    - name: "Encryption Enabled"
      expr: encryption_enabled
    - name: "Ethical Wall Flag"
      expr: ethical_wall_flag
    - name: "External Reference Number"
      expr: external_reference_number
    - name: "External Sharing Allowed"
      expr: external_sharing_allowed
    - name: "Folder Name"
      expr: folder_name
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Doc Folder"
      expr: COUNT(DISTINCT doc_folder_id)
    - name: "Total Parent Hierarchy"
      expr: SUM(parent_hierarchy)
    - name: "Average Parent Hierarchy"
      expr: AVG(parent_hierarchy)
    - name: "Total Total Storage Bytes"
      expr: SUM(total_storage_bytes)
    - name: "Average Total Storage Bytes"
      expr: AVG(total_storage_bytes)
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`document_doc_production`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Doc Production business metrics"
  source: "`legal_ecm`.`document`.`doc_production`"
  dimensions:
    - name: "Acknowledgment Date"
      expr: acknowledgment_date
    - name: "Acknowledgment Received"
      expr: acknowledgment_received
    - name: "Bates End Number"
      expr: bates_end_number
    - name: "Bates Prefix"
      expr: bates_prefix
    - name: "Bates Start Number"
      expr: bates_start_number
    - name: "Clawback Date"
      expr: clawback_date
    - name: "Clawback Invoked"
      expr: clawback_invoked
    - name: "Confidentiality Designation"
      expr: confidentiality_designation
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Delivery Location"
      expr: delivery_location
    - name: "Delivery Method"
      expr: delivery_method
    - name: "Dispute Description"
      expr: dispute_description
    - name: "Dispute Raised"
      expr: dispute_raised
    - name: "Document Count"
      expr: document_count
    - name: "Hash Verification Method"
      expr: hash_verification_method
    - name: "Load File Format"
      expr: load_file_format
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Doc Production"
      expr: COUNT(DISTINCT doc_production_id)
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`document_doc_relationship`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Doc Relationship business metrics"
  source: "`legal_ecm`.`document`.`doc_relationship`"
  dimensions:
    - name: "Attachment Type"
      expr: attachment_type
    - name: "Bates Range End"
      expr: bates_range_end
    - name: "Bates Range Start"
      expr: bates_range_start
    - name: "Chain Of Custody Verified"
      expr: chain_of_custody_verified
    - name: "Confidentiality Level"
      expr: confidentiality_level
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective Date"
      expr: effective_date
    - name: "End Date"
      expr: end_date
    - name: "Exhibit Number"
      expr: exhibit_number
    - name: "Is Active"
      expr: is_active
    - name: "Modified By User Code"
      expr: modified_by_user_code
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Notes"
      expr: notes
    - name: "Privilege Designation"
      expr: privilege_designation
    - name: "Production Flag"
      expr: production_flag
    - name: "Relationship Basis"
      expr: relationship_basis
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Doc Relationship"
      expr: COUNT(DISTINCT doc_relationship_id)
    - name: "Total Target Legal Document"
      expr: SUM(target_legal_document)
    - name: "Average Target Legal Document"
      expr: AVG(target_legal_document)
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`document_doc_review_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Doc Review Assignment business metrics"
  source: "`legal_ecm`.`document`.`doc_review_assignment`"
  dimensions:
    - name: "Annotation Count"
      expr: annotation_count
    - name: "Assignment Date"
      expr: assignment_date
    - name: "Assignment Method"
      expr: assignment_method
    - name: "Assignment Timestamp"
      expr: assignment_timestamp
    - name: "Bates Number"
      expr: bates_number
    - name: "Cal Feedback Flag"
      expr: cal_feedback_flag
    - name: "Confidentiality Designation"
      expr: confidentiality_designation
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Custodian Name"
      expr: custodian_name
    - name: "Issue Tags"
      expr: issue_tags
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Privilege Type"
      expr: privilege_type
    - name: "Production Flag"
      expr: production_flag
    - name: "Redaction Count"
      expr: redaction_count
    - name: "Redaction Required Flag"
      expr: redaction_required_flag
    - name: "Review Completion Timestamp"
      expr: review_completion_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Doc Review Assignment"
      expr: COUNT(DISTINCT doc_review_assignment_id)
    - name: "Total Modified By User Code"
      expr: SUM(modified_by_user_code)
    - name: "Average Modified By User Code"
      expr: AVG(modified_by_user_code)
    - name: "Total Relevance Score"
      expr: SUM(relevance_score)
    - name: "Average Relevance Score"
      expr: AVG(relevance_score)
    - name: "Total Review Duration Minutes"
      expr: SUM(review_duration_minutes)
    - name: "Average Review Duration Minutes"
      expr: AVG(review_duration_minutes)
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`document_doc_template`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Doc Template business metrics"
  source: "`legal_ecm`.`document`.`doc_template`"
  dimensions:
    - name: "Access Level"
      expr: access_level
    - name: "Approval Date"
      expr: approval_date
    - name: "Approval Status"
      expr: approval_status
    - name: "Automation Platform"
      expr: automation_platform
    - name: "Contains Automation"
      expr: contains_automation
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Document Type"
      expr: document_type
    - name: "File Format"
      expr: file_format
    - name: "Governing Law"
      expr: governing_law
    - name: "Is Active"
      expr: is_active
    - name: "Is Client Facing"
      expr: is_client_facing
    - name: "Jurisdiction"
      expr: jurisdiction
    - name: "Language"
      expr: language
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Last Review Date"
      expr: last_review_date
    - name: "Last Used Date"
      expr: last_used_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Doc Template"
      expr: COUNT(DISTINCT doc_template_id)
    - name: "Total Modified By User Code"
      expr: SUM(modified_by_user_code)
    - name: "Average Modified By User Code"
      expr: AVG(modified_by_user_code)
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`document_doc_type`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Doc Type business metrics"
  source: "`legal_ecm`.`document`.`doc_type`"
  dimensions:
    - name: "Approval Workflow Required"
      expr: approval_workflow_required
    - name: "Billable Activity"
      expr: billable_activity
    - name: "Chain Of Custody Tracking"
      expr: chain_of_custody_tracking
    - name: "Court Filing Eligible"
      expr: court_filing_eligible
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Default Privilege Classification"
      expr: default_privilege_classification
    - name: "Dms Folder Path Template"
      expr: dms_folder_path_template
    - name: "Doc Type Category"
      expr: doc_type_category
    - name: "Doc Type Code"
      expr: doc_type_code
    - name: "Doc Type Description"
      expr: doc_type_description
    - name: "Doc Type Name"
      expr: doc_type_name
    - name: "Doc Type Status"
      expr: doc_type_status
    - name: "Ediscovery Reviewable"
      expr: ediscovery_reviewable
    - name: "Effective Date"
      expr: effective_date
    - name: "Encryption Required"
      expr: encryption_required
    - name: "End Date"
      expr: end_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Doc Type"
      expr: COUNT(DISTINCT doc_type_id)
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`document_doc_version`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Doc Version business metrics"
  source: "`legal_ecm`.`document`.`doc_version`"
  dimensions:
    - name: "Bates Number"
      expr: bates_number
    - name: "Change Summary"
      expr: change_summary
    - name: "Checked In Timestamp"
      expr: checked_in_timestamp
    - name: "Checked Out Timestamp"
      expr: checked_out_timestamp
    - name: "Confidentiality Level"
      expr: confidentiality_level
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Extracted Text"
      expr: extracted_text
    - name: "File Format"
      expr: file_format
    - name: "File Hash"
      expr: file_hash
    - name: "File Name"
      expr: file_name
    - name: "Is Current Version"
      expr: is_current_version
    - name: "Language Code"
      expr: language_code
    - name: "Legal Hold Flag"
      expr: legal_hold_flag
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Nlp Entities Extracted"
      expr: nlp_entities_extracted
    - name: "Ocr Engine"
      expr: ocr_engine
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Doc Version"
      expr: COUNT(DISTINCT doc_version_id)
    - name: "Total File Size Bytes"
      expr: SUM(file_size_bytes)
    - name: "Average File Size Bytes"
      expr: AVG(file_size_bytes)
    - name: "Total Ocr Confidence Score"
      expr: SUM(ocr_confidence_score)
    - name: "Average Ocr Confidence Score"
      expr: AVG(ocr_confidence_score)
    - name: "Total Tar Relevance Score"
      expr: SUM(tar_relevance_score)
    - name: "Average Tar Relevance Score"
      expr: AVG(tar_relevance_score)
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`document_esi_collection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Esi Collection business metrics"
  source: "`legal_ecm`.`document`.`esi_collection`"
  dimensions:
    - name: "Chain Of Custody Hash"
      expr: chain_of_custody_hash
    - name: "Collection Cost Currency"
      expr: collection_cost_currency
    - name: "Collection End Date"
      expr: collection_end_date
    - name: "Collection Method"
      expr: collection_method
    - name: "Collection Name"
      expr: collection_name
    - name: "Collection Notes"
      expr: collection_notes
    - name: "Collection Number"
      expr: collection_number
    - name: "Collection Scope Description"
      expr: collection_scope_description
    - name: "Collection Start Date"
      expr: collection_start_date
    - name: "Collection Status"
      expr: collection_status
    - name: "Collection Timestamp"
      expr: collection_timestamp
    - name: "Collection Tool Name"
      expr: collection_tool_name
    - name: "Collection Tool Version"
      expr: collection_tool_version
    - name: "Collection Type"
      expr: collection_type
    - name: "Collector Name"
      expr: collector_name
    - name: "Collector Organization"
      expr: collector_organization
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Esi Collection"
      expr: COUNT(DISTINCT esi_collection_id)
    - name: "Total Collection Cost Amount"
      expr: SUM(collection_cost_amount)
    - name: "Average Collection Cost Amount"
      expr: AVG(collection_cost_amount)
    - name: "Total Password Protected Items Count"
      expr: SUM(password_protected_items_count)
    - name: "Average Password Protected Items Count"
      expr: AVG(password_protected_items_count)
    - name: "Total Total Items Collected"
      expr: SUM(total_items_collected)
    - name: "Average Total Items Collected"
      expr: AVG(total_items_collected)
    - name: "Total Total Size Bytes"
      expr: SUM(total_size_bytes)
    - name: "Average Total Size Bytes"
      expr: AVG(total_size_bytes)
    - name: "Total Total Size Gb"
      expr: SUM(total_size_gb)
    - name: "Average Total Size Gb"
      expr: AVG(total_size_gb)
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`document_esi_custodian`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Esi Custodian business metrics"
  source: "`legal_ecm`.`document`.`esi_custodian`"
  dimensions:
    - name: "Chain Of Custody Verified"
      expr: chain_of_custody_verified
    - name: "Collection Completion Date"
      expr: collection_completion_date
    - name: "Collection Method"
      expr: collection_method
    - name: "Collection Start Date"
      expr: collection_start_date
    - name: "Collection Status"
      expr: collection_status
    - name: "Created By User"
      expr: created_by_user
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Custodian Active Flag"
      expr: custodian_active_flag
    - name: "Custodian Department"
      expr: custodian_department
    - name: "Custodian Departure Date"
      expr: custodian_departure_date
    - name: "Custodian Email"
      expr: custodian_email
    - name: "Custodian Full Name"
      expr: custodian_full_name
    - name: "Custodian Organization"
      expr: custodian_organization
    - name: "Custodian Role"
      expr: custodian_role
    - name: "Custodian Status"
      expr: custodian_status
    - name: "Custodian Type"
      expr: custodian_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Esi Custodian"
      expr: COUNT(DISTINCT esi_custodian_id)
    - name: "Total Collection File Count"
      expr: SUM(collection_file_count)
    - name: "Average Collection File Count"
      expr: AVG(collection_file_count)
    - name: "Total Collection Volume Gb"
      expr: SUM(collection_volume_gb)
    - name: "Average Collection Volume Gb"
      expr: AVG(collection_volume_gb)
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`document_execution_workflow`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Execution Workflow business metrics"
  source: "`legal_ecm`.`document`.`execution_workflow`"
  dimensions:
    - name: "Approval Authority Level"
      expr: approval_authority_level
    - name: "Approval Required"
      expr: approval_required
    - name: "Audit Trail Required"
      expr: audit_trail_required
    - name: "Business Unit"
      expr: business_unit
    - name: "Chain Of Custody Required"
      expr: chain_of_custody_required
    - name: "Compliance Framework"
      expr: compliance_framework
    - name: "Confidentiality Level"
      expr: confidentiality_level
    - name: "Cost Center"
      expr: cost_center
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective From Date"
      expr: effective_from_date
    - name: "Effective Until Date"
      expr: effective_until_date
    - name: "Escalation Threshold Days"
      expr: escalation_threshold_days
    - name: "Execution Method"
      expr: execution_method
    - name: "Is Default Workflow"
      expr: is_default_workflow
    - name: "Jurisdiction Code"
      expr: jurisdiction_code
    - name: "Last Used Timestamp"
      expr: last_used_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Execution Workflow"
      expr: COUNT(DISTINCT execution_workflow_id)
    - name: "Total Usage Count"
      expr: SUM(usage_count)
    - name: "Average Usage Count"
      expr: AVG(usage_count)
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`document_family_group`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Family Group business metrics"
  source: "`legal_ecm`.`document`.`family_group`"
  dimensions:
    - name: "Attachment Count"
      expr: attachment_count
    - name: "Chain Of Custody Verified"
      expr: chain_of_custody_verified
    - name: "Confidentiality Level"
      expr: confidentiality_level
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Deduplication Status"
      expr: deduplication_status
    - name: "Discovery Status"
      expr: discovery_status
    - name: "Disposition Eligible Date"
      expr: disposition_eligible_date
    - name: "Earliest Document Date"
      expr: earliest_document_date
    - name: "Family Group Code"
      expr: family_group_code
    - name: "Family Group Name"
      expr: family_group_name
    - name: "Family Group Type"
      expr: family_group_type
    - name: "Family Relationship Basis"
      expr: family_relationship_basis
    - name: "Hash Algorithm"
      expr: hash_algorithm
    - name: "Hash Value"
      expr: hash_value
    - name: "Latest Document Date"
      expr: latest_document_date
    - name: "Legal Hold Status"
      expr: legal_hold_status
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Family Group"
      expr: COUNT(DISTINCT family_group_id)
    - name: "Total Technology Assisted Review Score"
      expr: SUM(technology_assisted_review_score)
    - name: "Average Technology Assisted Review Score"
      expr: AVG(technology_assisted_review_score)
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`document_legal_document`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Legal Document business metrics"
  source: "`legal_ecm`.`document`.`legal_document`"
  dimensions:
    - name: "Confidentiality Level"
      expr: confidentiality_level
    - name: "Contains Pii"
      expr: contains_pii
    - name: "Created Date"
      expr: created_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Dms Document Reference"
      expr: dms_document_reference
    - name: "Dms System"
      expr: dms_system
    - name: "Document Category"
      expr: document_category
    - name: "Document Number"
      expr: document_number
    - name: "Document Status"
      expr: document_status
    - name: "Executed Date"
      expr: executed_date
    - name: "Expiration Date"
      expr: expiration_date
    - name: "File Extension"
      expr: file_extension
    - name: "File Name"
      expr: file_name
    - name: "Is Current Version"
      expr: is_current_version
    - name: "Keywords"
      expr: keywords
    - name: "Language Code"
      expr: language_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Legal Document"
      expr: COUNT(DISTINCT legal_document_id)
    - name: "Total File Size Bytes"
      expr: SUM(file_size_bytes)
    - name: "Average File Size Bytes"
      expr: AVG(file_size_bytes)
    - name: "Total Hash Value"
      expr: SUM(hash_value)
    - name: "Average Hash Value"
      expr: AVG(hash_value)
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`document_legal_hold`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Legal Hold business metrics"
  source: "`legal_ecm`.`document`.`legal_hold`"
  dimensions:
    - name: "Acknowledged Count"
      expr: acknowledged_count
    - name: "Compliance Monitoring Flag"
      expr: compliance_monitoring_flag
    - name: "Confidentiality Level"
      expr: confidentiality_level
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Custodian Count"
      expr: custodian_count
    - name: "Data Sources In Scope"
      expr: data_sources_in_scope
    - name: "Document Types In Scope"
      expr: document_types_in_scope
    - name: "Ediscovery Collection Initiated Flag"
      expr: ediscovery_collection_initiated_flag
    - name: "Escalation Count"
      expr: escalation_count
    - name: "Hold Name"
      expr: hold_name
    - name: "Hold Number"
      expr: hold_number
    - name: "Hold Status"
      expr: hold_status
    - name: "Issued Date"
      expr: issued_date
    - name: "Jurisdiction"
      expr: jurisdiction
    - name: "Last Reminder Sent Date"
      expr: last_reminder_sent_date
    - name: "Modified Timestamp"
      expr: modified_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Legal Hold"
      expr: COUNT(DISTINCT legal_hold_id)
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`document_privilege_log`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Privilege Log business metrics"
  source: "`legal_ecm`.`document`.`privilege_log`"
  dimensions:
    - name: "Author Name"
      expr: author_name
    - name: "Bates Number"
      expr: bates_number
    - name: "Challenge Date"
      expr: challenge_date
    - name: "Challenge Notes"
      expr: challenge_notes
    - name: "Challenge Resolution Date"
      expr: challenge_resolution_date
    - name: "Challenge Status"
      expr: challenge_status
    - name: "Clawback Date"
      expr: clawback_date
    - name: "Clawback Requested"
      expr: clawback_requested
    - name: "Clawback Status"
      expr: clawback_status
    - name: "Confidentiality Level"
      expr: confidentiality_level
    - name: "Court Case Number"
      expr: court_case_number
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Custodian Name"
      expr: custodian_name
    - name: "Designation Date"
      expr: designation_date
    - name: "Designation Timestamp"
      expr: designation_timestamp
    - name: "Document Date"
      expr: document_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Privilege Log"
      expr: COUNT(DISTINCT privilege_log_id)
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`document_processing_batch`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Processing Batch business metrics"
  source: "`legal_ecm`.`document`.`processing_batch`"
  dimensions:
    - name: "Actual Start Timestamp"
      expr: actual_start_timestamp
    - name: "Batch Name"
      expr: batch_name
    - name: "Batch Number"
      expr: batch_number
    - name: "Batch Status"
      expr: batch_status
    - name: "Batch Type"
      expr: batch_type
    - name: "Chain Of Custody Verified"
      expr: chain_of_custody_verified
    - name: "Completion Timestamp"
      expr: completion_timestamp
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Deduplication Enabled"
      expr: deduplication_enabled
    - name: "Document Count"
      expr: document_count
    - name: "Error Message"
      expr: error_message
    - name: "Extraction Method"
      expr: extraction_method
    - name: "Failed Document Count"
      expr: failed_document_count
    - name: "Hash Algorithm"
      expr: hash_algorithm
    - name: "Language Detection Enabled"
      expr: language_detection_enabled
    - name: "Modified Timestamp"
      expr: modified_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Processing Batch"
      expr: COUNT(DISTINCT processing_batch_id)
    - name: "Total Total File Size Bytes"
      expr: SUM(total_file_size_bytes)
    - name: "Average Total File Size Bytes"
      expr: AVG(total_file_size_bytes)
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`document_production_batch`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Production Batch business metrics"
  source: "`legal_ecm`.`document`.`production_batch`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Approval Required"
      expr: approval_required
    - name: "Approved By"
      expr: approved_by
    - name: "Batch Number"
      expr: batch_number
    - name: "Bates Prefix"
      expr: bates_prefix
    - name: "Bates Range End"
      expr: bates_range_end
    - name: "Bates Range Start"
      expr: bates_range_start
    - name: "Confidentiality Designation"
      expr: confidentiality_designation
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Custodian Count"
      expr: custodian_count
    - name: "Date Range End"
      expr: date_range_end
    - name: "Date Range Start"
      expr: date_range_start
    - name: "Delivery Date"
      expr: delivery_date
    - name: "Delivery Method"
      expr: delivery_method
    - name: "Document Count"
      expr: document_count
    - name: "Encryption Applied"
      expr: encryption_applied
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Production Batch"
      expr: COUNT(DISTINCT production_batch_id)
    - name: "Total Total Size Bytes"
      expr: SUM(total_size_bytes)
    - name: "Average Total Size Bytes"
      expr: AVG(total_size_bytes)
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`document_production_set`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Production Set business metrics"
  source: "`legal_ecm`.`document`.`production_set`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Approving Attorney Name"
      expr: approving_attorney_name
    - name: "Bates Range End"
      expr: bates_range_end
    - name: "Bates Range Start"
      expr: bates_range_start
    - name: "Confidentiality Designation"
      expr: confidentiality_designation
    - name: "Created By User"
      expr: created_by_user
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Custodian Count"
      expr: custodian_count
    - name: "Data Source Count"
      expr: data_source_count
    - name: "Delivery Location"
      expr: delivery_location
    - name: "Delivery Method"
      expr: delivery_method
    - name: "Document Count"
      expr: document_count
    - name: "Hash Algorithm"
      expr: hash_algorithm
    - name: "Load File Format"
      expr: load_file_format
    - name: "Metadata Fields Produced"
      expr: metadata_fields_produced
    - name: "Modified By User"
      expr: modified_by_user
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Production Set"
      expr: COUNT(DISTINCT production_set_id)
    - name: "Total Total File Size Gb"
      expr: SUM(total_file_size_gb)
    - name: "Average Total File Size Gb"
      expr: AVG(total_file_size_gb)
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`document_production_source`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Production Source business metrics"
  source: "`legal_ecm`.`document`.`production_source`"
  dimensions:
    - name: "Bates Range End"
      expr: bates_range_end
    - name: "Bates Range Start"
      expr: bates_range_start
    - name: "Collection Subset Filter"
      expr: collection_subset_filter
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Document Count From Collection"
      expr: document_count_from_collection
    - name: "Inclusion Reason"
      expr: inclusion_reason
    - name: "Production Date"
      expr: production_date
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
    - name: "Production Date Month"
      expr: DATE_TRUNC('MONTH', production_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Production Source"
      expr: COUNT(DISTINCT production_source_id)
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`document_production_specification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Production Specification business metrics"
  source: "`legal_ecm`.`document`.`production_specification`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Approved By"
      expr: approved_by
    - name: "Bates Numbering Required"
      expr: bates_numbering_required
    - name: "Bates Prefix"
      expr: bates_prefix
    - name: "Clawback Provision Applies"
      expr: clawback_provision_applies
    - name: "Confidentiality Designation"
      expr: confidentiality_designation
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Custodian Scope"
      expr: custodian_scope
    - name: "Date Range End"
      expr: date_range_end
    - name: "Date Range Start"
      expr: date_range_start
    - name: "Deduplication Scope"
      expr: deduplication_scope
    - name: "Delivery Method"
      expr: delivery_method
    - name: "Encryption Required"
      expr: encryption_required
    - name: "Family Relationship Preserved"
      expr: family_relationship_preserved
    - name: "Hash Validation Required"
      expr: hash_validation_required
    - name: "Load File Format"
      expr: load_file_format
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Production Specification"
      expr: COUNT(DISTINCT production_specification_id)
    - name: "Total Bates Starting Number"
      expr: SUM(bates_starting_number)
    - name: "Average Bates Starting Number"
      expr: AVG(bates_starting_number)
    - name: "Total Production Cost Estimate"
      expr: SUM(production_cost_estimate)
    - name: "Average Production Cost Estimate"
      expr: AVG(production_cost_estimate)
    - name: "Total Production Volume Estimate"
      expr: SUM(production_volume_estimate)
    - name: "Average Production Volume Estimate"
      expr: AVG(production_volume_estimate)
    - name: "Total Quality Control Sampling Rate"
      expr: SUM(quality_control_sampling_rate)
    - name: "Average Quality Control Sampling Rate"
      expr: AVG(quality_control_sampling_rate)
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`document_retention_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Retention Schedule business metrics"
  source: "`legal_ecm`.`document`.`retention_schedule`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Approved By"
      expr: approved_by
    - name: "Certificate Of Destruction Required"
      expr: certificate_of_destruction_required
    - name: "Client Specific Override"
      expr: client_specific_override
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Cross Border Transfer Restriction"
      expr: cross_border_transfer_restriction
    - name: "Destruction Authorization Required"
      expr: destruction_authorization_required
    - name: "Destruction Method"
      expr: destruction_method
    - name: "Dms System Enforcement"
      expr: dms_system_enforcement
    - name: "Ediscovery Relevance Flag"
      expr: ediscovery_relevance_flag
    - name: "Effective From Date"
      expr: effective_from_date
    - name: "Effective Until Date"
      expr: effective_until_date
    - name: "Jurisdiction Code"
      expr: jurisdiction_code
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Last Review Date"
      expr: last_review_date
    - name: "Legal Hold Exemption"
      expr: legal_hold_exemption
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Retention Schedule"
      expr: COUNT(DISTINCT retention_schedule_id)
    - name: "Total Audit Trail Retention Years"
      expr: SUM(audit_trail_retention_years)
    - name: "Average Audit Trail Retention Years"
      expr: AVG(audit_trail_retention_years)
    - name: "Total Maximum Retention Period Years"
      expr: SUM(maximum_retention_period_years)
    - name: "Average Maximum Retention Period Years"
      expr: AVG(maximum_retention_period_years)
    - name: "Total Minimum Retention Period Years"
      expr: SUM(minimum_retention_period_years)
    - name: "Average Minimum Retention Period Years"
      expr: AVG(minimum_retention_period_years)
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`document_review_batch`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Review Batch business metrics"
  source: "`legal_ecm`.`document`.`review_batch`"
  dimensions:
    - name: "Actual Completion Date"
      expr: actual_completion_date
    - name: "Assigned Date"
      expr: assigned_date
    - name: "Batch Name"
      expr: batch_name
    - name: "Batch Number"
      expr: batch_number
    - name: "Batch Type"
      expr: batch_type
    - name: "Cal Round Number"
      expr: cal_round_number
    - name: "Completion Timestamp"
      expr: completion_timestamp
    - name: "Confidentiality Level"
      expr: confidentiality_level
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Custodian List"
      expr: custodian_list
    - name: "Date Range End"
      expr: date_range_end
    - name: "Date Range Start"
      expr: date_range_start
    - name: "Document Count"
      expr: document_count
    - name: "Hot Document Count"
      expr: hot_document_count
    - name: "Is Billable"
      expr: is_billable
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Review Batch"
      expr: COUNT(DISTINCT review_batch_id)
    - name: "Total Actual Hours"
      expr: SUM(actual_hours)
    - name: "Average Actual Hours"
      expr: AVG(actual_hours)
    - name: "Total Estimated Hours"
      expr: SUM(estimated_hours)
    - name: "Average Estimated Hours"
      expr: AVG(estimated_hours)
    - name: "Total Review Rate Documents Per Hour"
      expr: SUM(review_rate_documents_per_hour)
    - name: "Average Review Rate Documents Per Hour"
      expr: AVG(review_rate_documents_per_hour)
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`document_review_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Review Project business metrics"
  source: "`legal_ecm`.`document`.`review_project`"
  dimensions:
    - name: "Chain Of Custody Maintained"
      expr: chain_of_custody_maintained
    - name: "Confidentiality Level"
      expr: confidentiality_level
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Custodian Count"
      expr: custodian_count
    - name: "Data Source Count"
      expr: data_source_count
    - name: "Deduplication Applied"
      expr: deduplication_applied
    - name: "Email Threading Applied"
      expr: email_threading_applied
    - name: "Jurisdiction"
      expr: jurisdiction
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Nlp Processing Applied"
      expr: nlp_processing_applied
    - name: "Ocr Processing Applied"
      expr: ocr_processing_applied
    - name: "Privilege Protocol Applied"
      expr: privilege_protocol_applied
    - name: "Production Deadline Date"
      expr: production_deadline_date
    - name: "Production Format"
      expr: production_format
    - name: "Project Description"
      expr: project_description
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Review Project"
      expr: COUNT(DISTINCT review_project_id)
    - name: "Total Actual Cost Amount"
      expr: SUM(actual_cost_amount)
    - name: "Average Actual Cost Amount"
      expr: AVG(actual_cost_amount)
    - name: "Total Estimated Budget Amount"
      expr: SUM(estimated_budget_amount)
    - name: "Average Estimated Budget Amount"
      expr: AVG(estimated_budget_amount)
    - name: "Total Privileged Document Count"
      expr: SUM(privileged_document_count)
    - name: "Average Privileged Document Count"
      expr: AVG(privileged_document_count)
    - name: "Total Quality Control Percentage"
      expr: SUM(quality_control_percentage)
    - name: "Average Quality Control Percentage"
      expr: AVG(quality_control_percentage)
    - name: "Total Responsive Document Count"
      expr: SUM(responsive_document_count)
    - name: "Average Responsive Document Count"
      expr: AVG(responsive_document_count)
    - name: "Total Reviewed Document Count"
      expr: SUM(reviewed_document_count)
    - name: "Average Reviewed Document Count"
      expr: AVG(reviewed_document_count)
    - name: "Total Total Data Volume Gb"
      expr: SUM(total_data_volume_gb)
    - name: "Average Total Data Volume Gb"
      expr: AVG(total_data_volume_gb)
    - name: "Total Total Document Count"
      expr: SUM(total_document_count)
    - name: "Average Total Document Count"
      expr: AVG(total_document_count)
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`document_review_protocol`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Review Protocol business metrics"
  source: "`legal_ecm`.`document`.`review_protocol`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved By"
      expr: approved_by
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Custodian Scope"
      expr: custodian_scope
    - name: "Date Range End"
      expr: date_range_end
    - name: "Date Range Start"
      expr: date_range_start
    - name: "Deduplication Method"
      expr: deduplication_method
    - name: "Description"
      expr: review_protocol_description
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Modified By"
      expr: modified_by
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Nlp Processing Required"
      expr: nlp_processing_required
    - name: "Notes"
      expr: notes
    - name: "Ocr Processing Required"
      expr: ocr_processing_required
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Review Protocol"
      expr: COUNT(DISTINCT review_protocol_id)
    - name: "Total Confidence Level Percent"
      expr: SUM(confidence_level_percent)
    - name: "Average Confidence Level Percent"
      expr: AVG(confidence_level_percent)
    - name: "Total Escalation Threshold Percent"
      expr: SUM(escalation_threshold_percent)
    - name: "Average Escalation Threshold Percent"
      expr: AVG(escalation_threshold_percent)
    - name: "Total Margin Of Error Percent"
      expr: SUM(margin_of_error_percent)
    - name: "Average Margin Of Error Percent"
      expr: AVG(margin_of_error_percent)
    - name: "Total Quality Control Rate Percent"
      expr: SUM(quality_control_rate_percent)
    - name: "Average Quality Control Rate Percent"
      expr: AVG(quality_control_rate_percent)
    - name: "Total Richness Assumption Percent"
      expr: SUM(richness_assumption_percent)
    - name: "Average Richness Assumption Percent"
      expr: AVG(richness_assumption_percent)
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`document_review_session`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Review Session business metrics"
  source: "`legal_ecm`.`document`.`review_session`"
  dimensions:
    - name: "Actual End Timestamp"
      expr: actual_end_timestamp
    - name: "Actual Start Timestamp"
      expr: actual_start_timestamp
    - name: "Coding Layout Name"
      expr: coding_layout_name
    - name: "Confidentiality Level"
      expr: confidentiality_level
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Custodian Filter"
      expr: custodian_filter
    - name: "Date Range Filter End"
      expr: date_range_filter_end
    - name: "Date Range Filter Start"
      expr: date_range_filter_start
    - name: "Documents Pending"
      expr: documents_pending
    - name: "Documents Reviewed"
      expr: documents_reviewed
    - name: "Hot Document Count"
      expr: hot_document_count
    - name: "Is Billable"
      expr: is_billable
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Non Responsive Document Count"
      expr: non_responsive_document_count
    - name: "Privilege Designation Count"
      expr: privilege_designation_count
    - name: "Quality Control Sample Size"
      expr: quality_control_sample_size
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Review Session"
      expr: COUNT(DISTINCT review_session_id)
    - name: "Total Actual Cost"
      expr: SUM(actual_cost)
    - name: "Average Actual Cost"
      expr: AVG(actual_cost)
    - name: "Total Average Review Time Seconds"
      expr: SUM(average_review_time_seconds)
    - name: "Average Average Review Time Seconds"
      expr: AVG(average_review_time_seconds)
    - name: "Total Estimated Cost"
      expr: SUM(estimated_cost)
    - name: "Average Estimated Cost"
      expr: AVG(estimated_cost)
    - name: "Total Quality Control Error Rate"
      expr: SUM(quality_control_error_rate)
    - name: "Average Quality Control Error Rate"
      expr: AVG(quality_control_error_rate)
    - name: "Total Review Completion Percentage"
      expr: SUM(review_completion_percentage)
    - name: "Average Review Completion Percentage"
      expr: AVG(review_completion_percentage)
    - name: "Total Total Review Hours"
      expr: SUM(total_review_hours)
    - name: "Average Total Review Hours"
      expr: AVG(total_review_hours)
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`document_review_set`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Review Set business metrics"
  source: "`legal_ecm`.`document`.`review_set`"
  dimensions:
    - name: "Assigned Reviewer Count"
      expr: assigned_reviewer_count
    - name: "Chain Of Custody Verified"
      expr: chain_of_custody_verified
    - name: "Completed Timestamp"
      expr: completed_timestamp
    - name: "Confidentiality Designation"
      expr: confidentiality_designation
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Custodian Count"
      expr: custodian_count
    - name: "Date Range End"
      expr: date_range_end
    - name: "Date Range Start"
      expr: date_range_start
    - name: "Deduplication Applied"
      expr: deduplication_applied
    - name: "Description"
      expr: review_set_description
    - name: "Email Threading Applied"
      expr: email_threading_applied
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Near Duplicate Identification Applied"
      expr: near_duplicate_identification_applied
    - name: "Nlp Processing Applied"
      expr: nlp_processing_applied
    - name: "Ocr Applied"
      expr: ocr_applied
    - name: "Quality Control Sample Size"
      expr: quality_control_sample_size
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Review Set"
      expr: COUNT(DISTINCT review_set_id)
    - name: "Total Document Count"
      expr: SUM(document_count)
    - name: "Average Document Count"
      expr: AVG(document_count)
    - name: "Total Privileged Document Count"
      expr: SUM(privileged_document_count)
    - name: "Average Privileged Document Count"
      expr: AVG(privileged_document_count)
    - name: "Total Quality Control Accuracy Rate"
      expr: SUM(quality_control_accuracy_rate)
    - name: "Average Quality Control Accuracy Rate"
      expr: AVG(quality_control_accuracy_rate)
    - name: "Total Responsive Document Count"
      expr: SUM(responsive_document_count)
    - name: "Average Responsive Document Count"
      expr: AVG(responsive_document_count)
    - name: "Total Reviewed Document Count"
      expr: SUM(reviewed_document_count)
    - name: "Average Reviewed Document Count"
      expr: AVG(reviewed_document_count)
    - name: "Total Tar Precision Score"
      expr: SUM(tar_precision_score)
    - name: "Average Tar Precision Score"
      expr: AVG(tar_precision_score)
    - name: "Total Tar Recall Score"
      expr: SUM(tar_recall_score)
    - name: "Average Tar Recall Score"
      expr: AVG(tar_recall_score)
    - name: "Total Total Page Count"
      expr: SUM(total_page_count)
    - name: "Average Total Page Count"
      expr: AVG(total_page_count)
    - name: "Total Total Size Gb"
      expr: SUM(total_size_gb)
    - name: "Average Total Size Gb"
      expr: AVG(total_size_gb)
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`document_tar_model`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tar Model business metrics"
  source: "`legal_ecm`.`document`.`tar_model`"
  dimensions:
    - name: "Algorithm Type"
      expr: algorithm_type
    - name: "Control Set Size"
      expr: control_set_size
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Defensibility Documentation Url"
      expr: defensibility_documentation_url
    - name: "Deployment Timestamp"
      expr: deployment_timestamp
    - name: "Deprecation Timestamp"
      expr: deprecation_timestamp
    - name: "Feature Engineering Approach"
      expr: feature_engineering_approach
    - name: "Language Support"
      expr: language_support
    - name: "Last Modified By"
      expr: last_modified_by
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Last Training Timestamp"
      expr: last_training_timestamp
    - name: "Model Code"
      expr: model_code
    - name: "Model Name"
      expr: model_name
    - name: "Model Type"
      expr: model_type
    - name: "Model Version"
      expr: model_version
    - name: "Notes"
      expr: notes
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Tar Model"
      expr: COUNT(DISTINCT tar_model_id)
    - name: "Total Accuracy Score"
      expr: SUM(accuracy_score)
    - name: "Average Accuracy Score"
      expr: AVG(accuracy_score)
    - name: "Total Confidence Interval"
      expr: SUM(confidence_interval)
    - name: "Average Confidence Interval"
      expr: AVG(confidence_interval)
    - name: "Total Cutoff Threshold"
      expr: SUM(cutoff_threshold)
    - name: "Average Cutoff Threshold"
      expr: AVG(cutoff_threshold)
    - name: "Total Documents Classified"
      expr: SUM(documents_classified)
    - name: "Average Documents Classified"
      expr: AVG(documents_classified)
    - name: "Total Documents Reviewed"
      expr: SUM(documents_reviewed)
    - name: "Average Documents Reviewed"
      expr: AVG(documents_reviewed)
    - name: "Total F1 Score"
      expr: SUM(f1_score)
    - name: "Average F1 Score"
      expr: AVG(f1_score)
    - name: "Total Precision Score"
      expr: SUM(precision_score)
    - name: "Average Precision Score"
      expr: AVG(precision_score)
    - name: "Total Recall Score"
      expr: SUM(recall_score)
    - name: "Average Recall Score"
      expr: AVG(recall_score)
    - name: "Total Richness Estimate"
      expr: SUM(richness_estimate)
    - name: "Average Richness Estimate"
      expr: AVG(richness_estimate)
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`document_template_clause_usage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Template Clause Usage business metrics"
  source: "`legal_ecm`.`document`.`template_clause_usage`"
  dimensions:
    - name: "Added Date"
      expr: added_date
    - name: "Clause Library References"
      expr: clause_library_references
    - name: "Clause Position In Template"
      expr: clause_position_in_template
    - name: "Clause Variant Selected"
      expr: clause_variant_selected
    - name: "Customization Notes"
      expr: customization_notes
    - name: "Last Updated Date"
      expr: last_updated_date
    - name: "Mandatory Flag"
      expr: mandatory_flag
    - name: "Section Heading"
      expr: section_heading
    - name: "Added Date Month"
      expr: DATE_TRUNC('MONTH', added_date)
    - name: "Last Updated Date Month"
      expr: DATE_TRUNC('MONTH', last_updated_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Template Clause Usage"
      expr: COUNT(DISTINCT template_clause_usage_id)
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`document_workspace`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workspace business metrics"
  source: "`legal_ecm`.`document`.`workspace`"
  dimensions:
    - name: "Access Control Model"
      expr: access_control_model
    - name: "Archived Date"
      expr: archived_date
    - name: "Billing Code"
      expr: billing_code
    - name: "Closed Date"
      expr: closed_date
    - name: "Conflict Check Date"
      expr: conflict_check_date
    - name: "Conflict Check Status"
      expr: conflict_check_status
    - name: "Cost Center"
      expr: cost_center
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Description"
      expr: workspace_description
    - name: "Destruction Eligible Date"
      expr: destruction_eligible_date
    - name: "Document Management System"
      expr: document_management_system
    - name: "Encryption Enabled"
      expr: encryption_enabled
    - name: "External Collaboration Enabled"
      expr: external_collaboration_enabled
    - name: "External System Code"
      expr: external_system_code
    - name: "Jurisdiction"
      expr: jurisdiction
    - name: "Language Code"
      expr: language_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Workspace"
      expr: COUNT(DISTINCT workspace_id)
    - name: "Total Total Document Count"
      expr: SUM(total_document_count)
    - name: "Average Total Document Count"
      expr: AVG(total_document_count)
    - name: "Total Total Storage Size Mb"
      expr: SUM(total_storage_size_mb)
    - name: "Average Total Storage Size Mb"
      expr: AVG(total_storage_size_mb)
$$;
