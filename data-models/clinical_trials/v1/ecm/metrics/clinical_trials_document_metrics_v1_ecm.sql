-- Metric views for domain: document | Business: Clinical Trials | Version: 1 | Generated on: 2026-05-06 23:23:25

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`document_tmf_completeness`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "TMF completeness assessment metrics tracking inspection readiness, document gaps, and overall filing compliance across studies and sites."
  source: "`clinical_trials_ecm`.`document`.`tmf_completeness`"
  dimensions:
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of TMF completeness assessment (e.g., routine, pre-inspection, closeout)"
    - name: "assessment_status"
      expr: assessment_status
      comment: "Current status of the completeness assessment"
    - name: "tmf_scope"
      expr: tmf_scope
      comment: "Scope of TMF being assessed (e.g., study-level, site-level, country-level)"
    - name: "study_phase"
      expr: study_phase
      comment: "Phase of the clinical study at time of assessment"
    - name: "inspection_readiness_risk"
      expr: inspection_readiness_risk
      comment: "Risk level for inspection readiness (e.g., high, medium, low)"
    - name: "is_inspection_ready"
      expr: is_inspection_ready
      comment: "Whether the TMF is deemed inspection-ready"
    - name: "completeness_trend"
      expr: completeness_trend
      comment: "Trend direction of completeness (improving, declining, stable)"
    - name: "assessment_year"
      expr: YEAR(assessment_date)
      comment: "Year of the completeness assessment"
    - name: "assessment_quarter"
      expr: DATE_TRUNC('quarter', assessment_date)
      comment: "Quarter of the completeness assessment"
  measures:
    - name: "total_assessments"
      expr: COUNT(1)
      comment: "Total number of TMF completeness assessments conducted"
    - name: "avg_overall_completeness_pct"
      expr: AVG(CAST(overall_completeness_pct AS DOUBLE))
      comment: "Average overall TMF completeness percentage across assessments — key indicator of filing discipline"
    - name: "avg_completeness_target_pct"
      expr: AVG(CAST(completeness_target_pct AS DOUBLE))
      comment: "Average target completeness percentage set for assessments"
    - name: "inspection_ready_count"
      expr: COUNT(CASE WHEN is_inspection_ready = true THEN 1 END)
      comment: "Number of assessments where TMF was deemed inspection-ready"
    - name: "remediation_required_count"
      expr: COUNT(CASE WHEN remediation_action_required = true THEN 1 END)
      comment: "Number of assessments requiring remediation actions — signals quality gaps"
    - name: "avg_zone_1_completeness"
      expr: AVG(CAST(zone_1_completeness_pct AS DOUBLE))
      comment: "Average completeness for TMF Zone 1 (Trial Management)"
    - name: "avg_zone_2_completeness"
      expr: AVG(CAST(zone_2_completeness_pct AS DOUBLE))
      comment: "Average completeness for TMF Zone 2 (Central Trial Documents)"
    - name: "avg_zone_3_completeness"
      expr: AVG(CAST(zone_3_completeness_pct AS DOUBLE))
      comment: "Average completeness for TMF Zone 3 (Regulatory)"
    - name: "avg_zone_4_completeness"
      expr: AVG(CAST(zone_4_completeness_pct AS DOUBLE))
      comment: "Average completeness for TMF Zone 4 (IRB/IEC)"
    - name: "avg_zone_5_completeness"
      expr: AVG(CAST(zone_5_completeness_pct AS DOUBLE))
      comment: "Average completeness for TMF Zone 5 (Site Management)"
    - name: "avg_zone_6_completeness"
      expr: AVG(CAST(zone_6_completeness_pct AS DOUBLE))
      comment: "Average completeness for TMF Zone 6 (IP and Trial Supplies)"
    - name: "avg_zone_7_completeness"
      expr: AVG(CAST(zone_7_completeness_pct AS DOUBLE))
      comment: "Average completeness for TMF Zone 7 (Safety Reporting)"
    - name: "avg_zone_8_completeness"
      expr: AVG(CAST(zone_8_completeness_pct AS DOUBLE))
      comment: "Average completeness for TMF Zone 8 (Central and Local Testing)"
    - name: "high_risk_assessment_count"
      expr: COUNT(CASE WHEN inspection_readiness_risk = 'high' THEN 1 END)
      comment: "Number of assessments flagged as high inspection readiness risk"
$$;


CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`document_inspection_readiness`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inspection readiness metrics tracking regulatory preparedness, document gaps, and inspection outcomes for clinical trial sites and studies."
  source: "`clinical_trials_ecm`.`document`.`inspection_readiness`"
  dimensions:
    - name: "readiness_status"
      expr: readiness_status
      comment: "Current inspection readiness status"
    - name: "inspection_readiness_tier"
      expr: inspection_readiness_tier
      comment: "Tier classification of inspection readiness (e.g., Tier 1 critical, Tier 2 major)"
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of regulatory inspection (e.g., routine, for-cause, pre-approval)"
    - name: "inspecting_authority"
      expr: inspecting_authority
      comment: "Regulatory authority conducting the inspection (e.g., FDA, EMA, MHRA)"
    - name: "inspection_outcome"
      expr: inspection_outcome
      comment: "Outcome of the inspection (e.g., no action indicated, voluntary action, official action)"
    - name: "capa_required"
      expr: capa_required
      comment: "Whether corrective and preventive action is required post-inspection"
    - name: "sponsor_notified"
      expr: sponsor_notified
      comment: "Whether the sponsor has been notified of inspection findings"
    - name: "study_protocol_number"
      expr: study_protocol_number
      comment: "Protocol number of the study under inspection"
    - name: "tmf_scope"
      expr: tmf_scope
      comment: "Scope of TMF under inspection review"
  measures:
    - name: "total_readiness_assessments"
      expr: COUNT(1)
      comment: "Total number of inspection readiness assessments"
    - name: "avg_readiness_score"
      expr: AVG(CAST(readiness_score AS DOUBLE))
      comment: "Average inspection readiness score — primary KPI for regulatory preparedness"
    - name: "capa_required_count"
      expr: COUNT(CASE WHEN capa_required = true THEN 1 END)
      comment: "Number of inspections requiring CAPA — indicates systemic quality issues"
    - name: "favorable_outcome_count"
      expr: COUNT(CASE WHEN inspection_outcome = 'no action indicated' THEN 1 END)
      comment: "Number of inspections with favorable (no action indicated) outcomes"
    - name: "total_missing_documents"
      expr: SUM(CAST(missing_documents_count AS DOUBLE))
      comment: "Total missing documents across all readiness assessments — critical gap indicator"
    - name: "total_overdue_documents"
      expr: SUM(CAST(overdue_documents_count AS DOUBLE))
      comment: "Total overdue documents across assessments — filing timeliness indicator"
    - name: "total_critical_gaps"
      expr: SUM(CAST(critical_gaps_count AS DOUBLE))
      comment: "Total critical document gaps — highest severity findings requiring immediate action"
    - name: "total_major_gaps"
      expr: SUM(CAST(major_gaps_count AS DOUBLE))
      comment: "Total major document gaps across assessments"
    - name: "total_minor_gaps"
      expr: SUM(CAST(minor_gaps_count AS DOUBLE))
      comment: "Total minor document gaps across assessments"
    - name: "total_open_findings"
      expr: SUM(CAST(open_findings_count AS DOUBLE))
      comment: "Total open inspection findings requiring resolution"
$$;


CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`document_workflow`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Document workflow metrics tracking review/approval cycle efficiency, SLA compliance, and bottlenecks in clinical document lifecycle management."
  source: "`clinical_trials_ecm`.`document`.`workflow`"
  dimensions:
    - name: "workflow_status"
      expr: workflow_status
      comment: "Current status of the workflow (e.g., in progress, completed, cancelled)"
    - name: "workflow_type"
      expr: workflow_type
      comment: "Type of document workflow (e.g., review, approval, distribution)"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the workflow (e.g., high, medium, low)"
    - name: "document_type"
      expr: document_type
      comment: "Type of document being processed through the workflow"
    - name: "current_step_name"
      expr: current_step_name
      comment: "Name of the current workflow step"
    - name: "step_assignee_role"
      expr: step_assignee_role
      comment: "Role of the person assigned to the current workflow step"
    - name: "sla_breach_indicator"
      expr: sla_breach_indicator
      comment: "Whether the workflow has breached its SLA deadline"
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether the workflow has been escalated"
    - name: "gcp_critical_document_flag"
      expr: gcp_critical_document_flag
      comment: "Whether the document is GCP-critical (essential for regulatory compliance)"
    - name: "inspection_readiness_flag"
      expr: inspection_readiness_flag
      comment: "Whether the workflow is flagged for inspection readiness"
    - name: "tmf_zone"
      expr: tmf_zone
      comment: "TMF reference model zone for the document"
    - name: "initiated_month"
      expr: DATE_TRUNC('month', initiated_timestamp)
      comment: "Month when the workflow was initiated"
  measures:
    - name: "total_workflows"
      expr: COUNT(1)
      comment: "Total number of document workflows initiated"
    - name: "sla_breached_count"
      expr: COUNT(CASE WHEN sla_breach_indicator = true THEN 1 END)
      comment: "Number of workflows that breached SLA — key operational efficiency indicator"
    - name: "escalated_workflow_count"
      expr: COUNT(CASE WHEN escalation_flag = true THEN 1 END)
      comment: "Number of workflows requiring escalation — signals process bottlenecks"
    - name: "completed_workflow_count"
      expr: COUNT(CASE WHEN workflow_status = 'completed' THEN 1 END)
      comment: "Number of workflows successfully completed"
    - name: "total_rejections"
      expr: SUM(CAST(rejection_count AS DOUBLE))
      comment: "Total rejection count across workflows — quality indicator for document submissions"
    - name: "gcp_critical_workflow_count"
      expr: COUNT(CASE WHEN gcp_critical_document_flag = true THEN 1 END)
      comment: "Number of workflows for GCP-critical documents — regulatory priority tracking"
    - name: "esignature_required_count"
      expr: COUNT(CASE WHEN electronic_signature_required = true THEN 1 END)
      comment: "Number of workflows requiring electronic signature — 21 CFR Part 11 compliance tracking"
$$;


CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`document_access_log`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Document access audit metrics tracking access patterns, anomalous activity, and compliance with confidentiality controls for clinical trial documents."
  source: "`clinical_trials_ecm`.`document`.`access_log`"
  dimensions:
    - name: "access_action"
      expr: access_action
      comment: "Type of access action performed (e.g., view, download, print, edit)"
    - name: "access_result"
      expr: access_result
      comment: "Result of the access attempt (e.g., success, denied, error)"
    - name: "access_channel"
      expr: access_channel
      comment: "Channel through which document was accessed (e.g., web, API, mobile)"
    - name: "access_device_type"
      expr: access_device_type
      comment: "Device type used for access (e.g., desktop, tablet, mobile)"
    - name: "document_confidentiality_level"
      expr: document_confidentiality_level
      comment: "Confidentiality classification of the accessed document"
    - name: "document_type"
      expr: document_type
      comment: "Type of document accessed"
    - name: "user_role"
      expr: user_role
      comment: "Role of the user accessing the document"
    - name: "user_organization"
      expr: user_organization
      comment: "Organization of the user accessing the document"
    - name: "is_anomalous_access"
      expr: is_anomalous_access
      comment: "Whether the access was flagged as anomalous"
    - name: "inspection_context"
      expr: inspection_context
      comment: "Whether the access occurred in an inspection context"
    - name: "tmf_zone"
      expr: tmf_zone
      comment: "TMF zone of the accessed document"
    - name: "access_month"
      expr: DATE_TRUNC('month', access_timestamp)
      comment: "Month of the document access event"
  measures:
    - name: "total_access_events"
      expr: COUNT(1)
      comment: "Total document access events — baseline activity volume"
    - name: "anomalous_access_count"
      expr: COUNT(CASE WHEN is_anomalous_access = true THEN 1 END)
      comment: "Number of anomalous access events — security and compliance risk indicator"
    - name: "access_denied_count"
      expr: COUNT(CASE WHEN access_result = 'denied' THEN 1 END)
      comment: "Number of denied access attempts — potential unauthorized access indicator"
    - name: "download_count"
      expr: COUNT(CASE WHEN access_action = 'download' THEN 1 END)
      comment: "Number of document downloads — data exfiltration risk monitoring"
    - name: "distinct_users_accessing"
      expr: COUNT(DISTINCT employee_id)
      comment: "Distinct users accessing documents — access breadth indicator"
    - name: "distinct_documents_accessed"
      expr: COUNT(DISTINCT tmf_document_id)
      comment: "Distinct documents accessed — document utilization breadth"
    - name: "inspection_context_access_count"
      expr: COUNT(CASE WHEN inspection_context = true THEN 1 END)
      comment: "Number of accesses in inspection context — regulatory activity indicator"
    - name: "unjustified_access_count"
      expr: COUNT(CASE WHEN justification_required = true AND justification_provided = false THEN 1 END)
      comment: "Number of accesses where justification was required but not provided — compliance gap"
$$;


CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`document_signature`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Electronic signature metrics tracking signature completion rates, timeliness, and 21 CFR Part 11 compliance for clinical trial documents."
  source: "`clinical_trials_ecm`.`document`.`signature`"
  dimensions:
    - name: "signature_status"
      expr: signature_status
      comment: "Current status of the signature (e.g., pending, signed, voided, expired)"
    - name: "signature_type"
      expr: signature_type
      comment: "Type of signature (e.g., approval, acknowledgement, authorship)"
    - name: "signature_method"
      expr: signature_method
      comment: "Method of signature (e.g., electronic, wet ink, digital certificate)"
    - name: "meaning"
      expr: meaning
      comment: "Regulatory meaning of the signature (e.g., approval, review, responsibility)"
    - name: "signer_role"
      expr: signer_role
      comment: "Role of the signer in the clinical trial"
    - name: "signer_organization"
      expr: signer_organization
      comment: "Organization of the signer"
    - name: "tmf_zone"
      expr: tmf_zone
      comment: "TMF zone of the document requiring signature"
    - name: "inspection_readiness_flag"
      expr: inspection_readiness_flag
      comment: "Whether the signature is flagged for inspection readiness"
    - name: "is_regulatory_submission_applicable"
      expr: is_regulatory_submission_applicable
      comment: "Whether the signature applies to regulatory submission documents"
    - name: "signed_month"
      expr: DATE_TRUNC('month', signed_timestamp)
      comment: "Month when the signature was applied"
  measures:
    - name: "total_signature_requests"
      expr: COUNT(1)
      comment: "Total signature requests — volume of documents requiring formal sign-off"
    - name: "completed_signatures"
      expr: COUNT(CASE WHEN signature_status = 'signed' THEN 1 END)
      comment: "Number of signatures successfully completed"
    - name: "pending_signatures"
      expr: COUNT(CASE WHEN signature_status = 'pending' THEN 1 END)
      comment: "Number of signatures still pending — potential bottleneck indicator"
    - name: "voided_signatures"
      expr: COUNT(CASE WHEN signature_status = 'voided' THEN 1 END)
      comment: "Number of voided signatures — quality and compliance concern"
    - name: "overdue_signatures"
      expr: COUNT(CASE WHEN signature_status = 'pending' AND due_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of overdue pending signatures — critical compliance risk"
    - name: "distinct_signers"
      expr: COUNT(DISTINCT employee_id)
      comment: "Distinct individuals providing signatures"
    - name: "regulatory_submission_signatures"
      expr: COUNT(CASE WHEN is_regulatory_submission_applicable = true THEN 1 END)
      comment: "Signatures applicable to regulatory submissions — highest priority tracking"
$$;


CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`document_site_file`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Investigator Site File (ISF) metrics tracking completeness, inspection readiness, and essential document availability at clinical trial sites."
  source: "`clinical_trials_ecm`.`document`.`site_file`"
  dimensions:
    - name: "file_status"
      expr: file_status
      comment: "Current status of the site file (e.g., active, closed, archived)"
    - name: "file_type"
      expr: file_type
      comment: "Type of site file (e.g., ISF, pharmacy file, lab file)"
    - name: "completeness_status"
      expr: completeness_status
      comment: "Completeness status classification of the site file"
    - name: "inspection_readiness_status"
      expr: inspection_readiness_status
      comment: "Inspection readiness status of the site file"
    - name: "file_format"
      expr: file_format
      comment: "Format of the site file (e.g., electronic, paper, hybrid)"
    - name: "tmf_zone"
      expr: tmf_zone
      comment: "TMF reference model zone"
    - name: "regulatory_authority"
      expr: regulatory_authority
      comment: "Applicable regulatory authority for the site file"
    - name: "last_inspection_outcome"
      expr: last_inspection_outcome
      comment: "Outcome of the last inspection of this site file"
  measures:
    - name: "total_site_files"
      expr: COUNT(1)
      comment: "Total number of site files under management"
    - name: "avg_completeness_percentage"
      expr: AVG(CAST(completeness_percentage AS DOUBLE))
      comment: "Average site file completeness percentage — primary ISF health indicator"
    - name: "inspection_ready_count"
      expr: COUNT(CASE WHEN inspection_readiness_status = 'ready' THEN 1 END)
      comment: "Number of site files deemed inspection-ready"
    - name: "delegation_log_present_count"
      expr: COUNT(CASE WHEN delegation_log_on_file = true THEN 1 END)
      comment: "Number of site files with delegation log on file — GCP essential document"
    - name: "icf_on_file_count"
      expr: COUNT(CASE WHEN icf_on_file = true THEN 1 END)
      comment: "Number of site files with informed consent forms on file"
    - name: "irb_approval_on_file_count"
      expr: COUNT(CASE WHEN irb_iec_approval_on_file = true THEN 1 END)
      comment: "Number of site files with IRB/IEC approval documentation on file"
    - name: "sponsor_review_completed_count"
      expr: COUNT(CASE WHEN sponsor_review_completed = true THEN 1 END)
      comment: "Number of site files with completed sponsor review — oversight compliance"
    - name: "total_missing_documents"
      expr: SUM(CAST(missing_document_count AS DOUBLE))
      comment: "Total missing documents across all site files — gap remediation priority"
    - name: "total_open_action_items"
      expr: SUM(CAST(open_action_item_count AS DOUBLE))
      comment: "Total open action items across site files — operational workload indicator"
$$;


CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`document_sop`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Standard Operating Procedure (SOP) lifecycle metrics tracking currency, training requirements, and compliance status of clinical trial SOPs."
  source: "`clinical_trials_ecm`.`document`.`document_sop`"
  dimensions:
    - name: "sop_status"
      expr: sop_status
      comment: "Current lifecycle status of the SOP (e.g., effective, draft, retired, under review)"
    - name: "sop_category"
      expr: sop_category
      comment: "Category of the SOP (e.g., clinical operations, data management, safety)"
    - name: "sop_type"
      expr: sop_type
      comment: "Type of SOP document"
    - name: "process_area"
      expr: process_area
      comment: "Business process area the SOP governs"
    - name: "applicable_region"
      expr: applicable_region
      comment: "Geographic region where the SOP applies"
    - name: "training_required"
      expr: training_required
      comment: "Whether training is required for this SOP"
    - name: "inspection_ready"
      expr: inspection_ready
      comment: "Whether the SOP is inspection-ready"
    - name: "gcp_applicable"
      expr: gcp_applicable
      comment: "Whether the SOP is GCP-applicable"
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework the SOP supports (e.g., ICH-GCP, 21 CFR Part 11)"
  measures:
    - name: "total_sops"
      expr: COUNT(1)
      comment: "Total number of SOPs in the system"
    - name: "effective_sop_count"
      expr: COUNT(CASE WHEN sop_status = 'effective' THEN 1 END)
      comment: "Number of currently effective SOPs"
    - name: "overdue_review_count"
      expr: COUNT(CASE WHEN review_due_date < CURRENT_DATE() AND sop_status = 'effective' THEN 1 END)
      comment: "Number of effective SOPs past their review due date — compliance risk"
    - name: "training_required_count"
      expr: COUNT(CASE WHEN training_required = true THEN 1 END)
      comment: "Number of SOPs requiring training completion — workforce readiness indicator"
    - name: "gcp_applicable_count"
      expr: COUNT(CASE WHEN gcp_applicable = true THEN 1 END)
      comment: "Number of GCP-applicable SOPs — regulatory compliance scope"
    - name: "esignature_required_count"
      expr: COUNT(CASE WHEN electronic_signature_required = true THEN 1 END)
      comment: "Number of SOPs requiring electronic signature — Part 11 compliance scope"
    - name: "deviation_triggered_count"
      expr: COUNT(CASE WHEN deviation_triggered = true THEN 1 END)
      comment: "Number of SOPs that have triggered deviations — quality signal"
$$;


CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`document_etmf_exchange`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "eTMF document exchange metrics tracking transfer volumes, integrity verification, and exchange success rates between sponsors and CROs."
  source: "`clinical_trials_ecm`.`document`.`etmf_exchange`"
  dimensions:
    - name: "transfer_status"
      expr: transfer_status
      comment: "Status of the document transfer (e.g., completed, failed, pending)"
    - name: "exchange_direction"
      expr: exchange_direction
      comment: "Direction of the exchange (e.g., inbound, outbound)"
    - name: "exchange_type"
      expr: exchange_type
      comment: "Type of exchange (e.g., scheduled, ad-hoc, closeout)"
    - name: "transfer_method"
      expr: transfer_method
      comment: "Method used for transfer (e.g., vault-to-vault, SFTP, manual)"
    - name: "tmf_zone"
      expr: tmf_zone
      comment: "TMF zone of the exchanged documents"
    - name: "study_phase"
      expr: study_phase
      comment: "Study phase at time of exchange"
    - name: "regulatory_region"
      expr: regulatory_region
      comment: "Regulatory region applicable to the exchange"
    - name: "integrity_verified"
      expr: integrity_verified
      comment: "Whether document integrity was verified post-transfer"
    - name: "exchange_month"
      expr: DATE_TRUNC('month', exchange_date)
      comment: "Month of the document exchange"
  measures:
    - name: "total_exchanges"
      expr: COUNT(1)
      comment: "Total number of eTMF document exchanges"
    - name: "successful_exchange_count"
      expr: COUNT(CASE WHEN transfer_status = 'completed' THEN 1 END)
      comment: "Number of successfully completed exchanges"
    - name: "failed_exchange_count"
      expr: COUNT(CASE WHEN transfer_status = 'failed' THEN 1 END)
      comment: "Number of failed exchanges — data transfer reliability indicator"
    - name: "integrity_verified_count"
      expr: COUNT(CASE WHEN integrity_verified = true THEN 1 END)
      comment: "Number of exchanges with verified document integrity"
    - name: "total_package_size_mb"
      expr: SUM(CAST(package_size_mb AS DOUBLE))
      comment: "Total size of exchanged document packages in MB — data volume indicator"
    - name: "avg_package_size_mb"
      expr: AVG(CAST(package_size_mb AS DOUBLE))
      comment: "Average package size per exchange in MB"
    - name: "total_documents_exchanged"
      expr: SUM(CAST(document_count AS DOUBLE))
      comment: "Total documents exchanged across all transfers"
    - name: "rejected_exchange_count"
      expr: COUNT(CASE WHEN rejection_code IS NOT NULL THEN 1 END)
      comment: "Number of exchanges that were rejected — quality gate effectiveness"
$$;


CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`document_distribution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Document distribution metrics tracking delivery effectiveness, acknowledgement compliance, and training completion for distributed clinical documents."
  source: "`clinical_trials_ecm`.`document`.`distribution`"
  dimensions:
    - name: "distribution_status"
      expr: distribution_status
      comment: "Current status of the distribution (e.g., distributed, acknowledged, overdue)"
    - name: "distribution_method"
      expr: distribution_method
      comment: "Method of distribution (e.g., electronic, paper, hybrid)"
    - name: "distribution_scope"
      expr: distribution_scope
      comment: "Scope of distribution (e.g., global, regional, site-specific)"
    - name: "document_type"
      expr: document_type
      comment: "Type of document distributed"
    - name: "recipient_organization_type"
      expr: recipient_organization_type
      comment: "Type of recipient organization (e.g., site, sponsor, CRO, IRB)"
    - name: "recipient_role"
      expr: recipient_role
      comment: "Role of the document recipient"
    - name: "acknowledgement_required"
      expr: acknowledgement_required
      comment: "Whether acknowledgement is required from the recipient"
    - name: "training_required"
      expr: training_required
      comment: "Whether training is required upon receipt"
    - name: "tmf_zone"
      expr: tmf_zone
      comment: "TMF zone of the distributed document"
    - name: "distribution_month"
      expr: DATE_TRUNC('month', distribution_date)
      comment: "Month of document distribution"
  measures:
    - name: "total_distributions"
      expr: COUNT(1)
      comment: "Total number of document distributions"
    - name: "acknowledged_count"
      expr: COUNT(CASE WHEN acknowledgement_date IS NOT NULL THEN 1 END)
      comment: "Number of distributions that have been acknowledged by recipients"
    - name: "overdue_acknowledgement_count"
      expr: COUNT(CASE WHEN acknowledgement_required = true AND acknowledgement_date IS NULL AND acknowledgement_due_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of distributions with overdue acknowledgements — compliance gap indicator"
    - name: "training_completed_count"
      expr: COUNT(CASE WHEN training_completion_date IS NOT NULL THEN 1 END)
      comment: "Number of distributions where required training has been completed"
    - name: "training_pending_count"
      expr: COUNT(CASE WHEN training_required = true AND training_completion_date IS NULL THEN 1 END)
      comment: "Number of distributions with pending training — workforce readiness gap"
    - name: "reminder_sent_count"
      expr: COUNT(CASE WHEN reminder_sent = true THEN 1 END)
      comment: "Number of distributions where reminders were sent — follow-up effort indicator"
    - name: "avg_days_to_acknowledge"
      expr: AVG(CAST(days_to_acknowledge AS DOUBLE))
      comment: "Average days from distribution to acknowledgement — responsiveness metric"
$$;
