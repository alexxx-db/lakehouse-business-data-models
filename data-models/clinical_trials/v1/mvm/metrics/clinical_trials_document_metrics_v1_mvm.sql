-- Metric views for domain: document | Business: Clinical Trials | Version: 1 | Generated on: 2026-05-07 02:29:00

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`document_tmf_completeness`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Trial Master File completeness KPIs tracking overall and zone-level completeness percentages, inspection readiness posture, and remediation burden across studies and sites. Used by TMF leads, QA directors, and study managers to steer document completeness programs and prepare for regulatory inspections."
  source: "`clinical_trials_ecm`.`document`.`tmf_completeness`"
  dimensions:
    - name: "study_id"
      expr: study_id
      comment: "Foreign key to the study — enables slicing completeness KPIs by individual clinical study."
    - name: "study_site_id"
      expr: study_site_id
      comment: "Foreign key to the study site — enables site-level completeness analysis."
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of completeness assessment (e.g., Periodic, Pre-Inspection, Closeout) — segments KPIs by assessment cadence."
    - name: "assessment_status"
      expr: assessment_status
      comment: "Current status of the completeness assessment (e.g., Open, Closed, In Review) — filters active vs. completed assessments."
    - name: "study_phase"
      expr: study_phase
      comment: "Phase of the clinical study at time of assessment — enables phase-level benchmarking of completeness."
    - name: "study_status_at_assessment"
      expr: study_status_at_assessment
      comment: "Study lifecycle status at the time of assessment (e.g., Active, Closed) — contextualises completeness expectations."
    - name: "tmf_scope"
      expr: tmf_scope
      comment: "Scope of the TMF assessed (e.g., Sponsor, Site, Country) — segments completeness by TMF ownership layer."
    - name: "inspection_readiness_risk"
      expr: inspection_readiness_risk
      comment: "Risk rating for inspection readiness (e.g., High, Medium, Low) — critical dimension for prioritising remediation."
    - name: "is_inspection_ready"
      expr: is_inspection_ready
      comment: "Boolean flag indicating whether the TMF was deemed inspection-ready at assessment — key binary KPI dimension."
    - name: "remediation_action_required"
      expr: remediation_action_required
      comment: "Boolean flag indicating whether a remediation action was required — segments assessments needing active intervention."
    - name: "completeness_trend"
      expr: completeness_trend
      comment: "Directional trend of completeness over time (e.g., Improving, Declining, Stable) — supports trend-based steering."
    - name: "assessment_period_start_date"
      expr: DATE_TRUNC('month', assessment_period_start_date)
      comment: "Month bucket of the assessment period start — enables monthly trending of completeness KPIs."
    - name: "assessment_date"
      expr: DATE_TRUNC('month', assessment_date)
      comment: "Month bucket of the actual assessment date — supports time-series analysis of completeness scores."
  measures:
    - name: "total_assessments"
      expr: COUNT(1)
      comment: "Total number of TMF completeness assessments conducted — baseline volume metric for assessment program throughput."
    - name: "avg_overall_completeness_pct"
      expr: AVG(CAST(overall_completeness_pct AS DOUBLE))
      comment: "Average overall TMF completeness percentage across all assessments — primary KPI for TMF health; executives use this to gauge regulatory readiness."
    - name: "min_overall_completeness_pct"
      expr: MIN(overall_completeness_pct)
      comment: "Minimum overall completeness percentage observed — identifies the worst-performing study or site requiring urgent intervention."
    - name: "avg_completeness_target_pct"
      expr: AVG(CAST(completeness_target_pct AS DOUBLE))
      comment: "Average completeness target percentage set across assessments — provides the benchmark against which actual completeness is measured."
    - name: "inspection_ready_assessment_count"
      expr: COUNT(CASE WHEN is_inspection_ready = TRUE THEN 1 END)
      comment: "Number of assessments where the TMF was deemed inspection-ready — directly measures regulatory preparedness."
    - name: "remediation_required_count"
      expr: COUNT(CASE WHEN remediation_action_required = TRUE THEN 1 END)
      comment: "Number of assessments requiring remediation action — quantifies the active remediation burden on the TMF team."
    - name: "high_risk_inspection_count"
      expr: COUNT(CASE WHEN inspection_readiness_risk = 'High' THEN 1 END)
      comment: "Number of assessments rated High inspection readiness risk — critical leading indicator for regulatory exposure."
    - name: "avg_zone_1_completeness_pct"
      expr: AVG(CAST(zone_1_completeness_pct AS DOUBLE))
      comment: "Average completeness percentage for TMF Zone 1 (Trial Management) — zone-level KPI for targeted gap remediation."
    - name: "avg_zone_2_completeness_pct"
      expr: AVG(CAST(zone_2_completeness_pct AS DOUBLE))
      comment: "Average completeness percentage for TMF Zone 2 (Central Trial Documents) — zone-level KPI for targeted gap remediation."
    - name: "avg_zone_3_completeness_pct"
      expr: AVG(CAST(zone_3_completeness_pct AS DOUBLE))
      comment: "Average completeness percentage for TMF Zone 3 (Regulatory) — zone-level KPI for targeted gap remediation."
    - name: "avg_zone_4_completeness_pct"
      expr: AVG(CAST(zone_4_completeness_pct AS DOUBLE))
      comment: "Average completeness percentage for TMF Zone 4 (IRB/IEC) — zone-level KPI for targeted gap remediation."
    - name: "avg_zone_5_completeness_pct"
      expr: AVG(CAST(zone_5_completeness_pct AS DOUBLE))
      comment: "Average completeness percentage for TMF Zone 5 (Site Management) — zone-level KPI for targeted gap remediation."
    - name: "completeness_gap_pct"
      expr: AVG(completeness_target_pct - overall_completeness_pct)
      comment: "Average gap between target and actual completeness percentage — measures how far the TMF program is from its goals; drives resource allocation decisions."
    - name: "distinct_studies_assessed"
      expr: COUNT(DISTINCT study_id)
      comment: "Number of distinct studies with at least one completeness assessment — measures breadth of TMF oversight program coverage."
    - name: "distinct_sites_assessed"
      expr: COUNT(DISTINCT study_site_id)
      comment: "Number of distinct study sites assessed — measures site-level TMF oversight coverage."
$$;


CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`document_inspection_readiness`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory inspection readiness KPIs tracking readiness scores, gap counts, inspection outcomes, and CAPA burden across studies and sites. Used by QA directors, regulatory affairs leads, and executive sponsors to manage inspection risk and demonstrate GCP compliance."
  source: "`clinical_trials_ecm`.`document`.`inspection_readiness`"
  dimensions:
    - name: "study_site_id"
      expr: study_site_id
      comment: "Foreign key to the study site — enables site-level inspection readiness analysis."
    - name: "inspecting_authority"
      expr: inspecting_authority
      comment: "Regulatory authority conducting the inspection (e.g., FDA, EMA, MHRA) — critical dimension for authority-specific readiness benchmarking."
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection (e.g., Routine, For-Cause, Pre-Approval) — segments readiness KPIs by inspection risk category."
    - name: "inspection_outcome"
      expr: inspection_outcome
      comment: "Outcome of the inspection (e.g., No Action Indicated, Voluntary Action Indicated, Warning Letter) — key result dimension for outcome analysis."
    - name: "readiness_status"
      expr: readiness_status
      comment: "Current readiness status (e.g., Ready, At Risk, Not Ready) — primary operational status dimension."
    - name: "inspection_readiness_tier"
      expr: inspection_readiness_tier
      comment: "Tiered readiness classification (e.g., Tier 1, Tier 2, Tier 3) — enables prioritisation of inspection preparation resources."
    - name: "capa_required"
      expr: capa_required
      comment: "Boolean flag indicating whether a CAPA was required following the inspection — segments inspections by remediation obligation."
    - name: "sponsor_notified"
      expr: sponsor_notified
      comment: "Boolean flag indicating whether the sponsor was notified of the inspection — tracks notification compliance."
    - name: "tmf_scope"
      expr: tmf_scope
      comment: "Scope of the TMF under inspection review — segments readiness KPIs by TMF ownership layer."
    - name: "target_inspection_date"
      expr: DATE_TRUNC('month', target_inspection_date)
      comment: "Month bucket of the target inspection date — enables forward-looking readiness pipeline analysis."
    - name: "actual_inspection_start_date"
      expr: DATE_TRUNC('month', actual_inspection_start_date)
      comment: "Month bucket of the actual inspection start — supports historical inspection volume trending."
  measures:
    - name: "total_inspection_readiness_records"
      expr: COUNT(1)
      comment: "Total number of inspection readiness records — baseline volume metric for inspection program activity."
    - name: "avg_readiness_score"
      expr: AVG(CAST(readiness_score AS DOUBLE))
      comment: "Average inspection readiness score across all records — primary executive KPI for overall regulatory preparedness posture."
    - name: "min_readiness_score"
      expr: MIN(readiness_score)
      comment: "Minimum readiness score observed — identifies the most at-risk study or site requiring immediate intervention."
    - name: "ready_count"
      expr: COUNT(CASE WHEN readiness_status = 'Ready' THEN 1 END)
      comment: "Number of inspection readiness records with Ready status — measures the volume of studies/sites fully prepared for inspection."
    - name: "at_risk_count"
      expr: COUNT(CASE WHEN readiness_status = 'At Risk' THEN 1 END)
      comment: "Number of inspection readiness records with At Risk status — leading indicator of potential inspection failures requiring escalation."
    - name: "capa_required_count"
      expr: COUNT(CASE WHEN capa_required = TRUE THEN 1 END)
      comment: "Number of inspections requiring a CAPA — quantifies post-inspection remediation burden and compliance debt."
    - name: "favorable_outcome_count"
      expr: COUNT(CASE WHEN inspection_outcome = 'No Action Indicated' THEN 1 END)
      comment: "Number of inspections with No Action Indicated outcome — measures the rate of clean inspection results, a key quality KPI."
    - name: "warning_letter_count"
      expr: COUNT(CASE WHEN inspection_outcome = 'Warning Letter' THEN 1 END)
      comment: "Number of inspections resulting in a Warning Letter — critical risk metric; any non-zero value triggers executive escalation."
    - name: "distinct_studies_inspected"
      expr: COUNT(DISTINCT study_id)
      comment: "Number of distinct studies with inspection readiness records — measures breadth of inspection oversight program."
    - name: "distinct_sites_inspected"
      expr: COUNT(DISTINCT study_site_id)
      comment: "Number of distinct sites with inspection readiness records — measures site-level inspection coverage."
$$;


CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`document_workflow`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Document workflow KPIs tracking cycle times, SLA compliance, escalation rates, and completion throughput across document types and workflow categories. Used by document control managers, QA leads, and operations directors to optimise document review and approval processes."
  source: "`clinical_trials_ecm`.`document`.`workflow`"
  dimensions:
    - name: "workflow_type"
      expr: workflow_type
      comment: "Type of document workflow (e.g., Review, Approval, Distribution) — primary segmentation dimension for workflow performance analysis."
    - name: "workflow_status"
      expr: workflow_status
      comment: "Current status of the workflow (e.g., In Progress, Completed, Cancelled) — enables active vs. completed workflow analysis."
    - name: "document_type"
      expr: document_type
      comment: "Type of document being processed through the workflow — enables document-type-level performance benchmarking."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the workflow (e.g., Critical, High, Normal) — segments KPIs by urgency to identify priority-driven bottlenecks."
    - name: "current_step_name"
      expr: current_step_name
      comment: "Name of the current workflow step — identifies where workflows are stalling in the process."
    - name: "step_assignee_role"
      expr: step_assignee_role
      comment: "Role of the person assigned to the current step — enables workload and bottleneck analysis by role."
    - name: "sla_breach_indicator"
      expr: sla_breach_indicator
      comment: "Boolean flag indicating whether the workflow has breached its SLA — critical dimension for compliance and performance management."
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Boolean flag indicating whether the workflow has been escalated — segments escalated workflows for root cause analysis."
    - name: "gcp_critical_document_flag"
      expr: gcp_critical_document_flag
      comment: "Boolean flag indicating whether the document is GCP-critical — enables prioritised monitoring of regulatory-critical workflows."
    - name: "regulatory_submission_flag"
      expr: regulatory_submission_flag
      comment: "Boolean flag indicating whether the workflow is linked to a regulatory submission — segments submission-critical workflows."
    - name: "tmf_zone"
      expr: tmf_zone
      comment: "TMF zone associated with the workflow document — enables zone-level workflow performance analysis."
    - name: "initiated_month"
      expr: DATE_TRUNC('month', initiated_timestamp)
      comment: "Month bucket of workflow initiation — enables monthly trending of workflow volume and performance."
    - name: "target_completion_date"
      expr: DATE_TRUNC('month', target_completion_date)
      comment: "Month bucket of the target completion date — supports forward-looking workflow pipeline analysis."
  measures:
    - name: "total_workflows"
      expr: COUNT(1)
      comment: "Total number of document workflows initiated — baseline volume metric for document processing throughput."
    - name: "completed_workflow_count"
      expr: COUNT(CASE WHEN workflow_status = 'Completed' THEN 1 END)
      comment: "Number of workflows successfully completed — measures document processing throughput and team productivity."
    - name: "sla_breach_count"
      expr: COUNT(CASE WHEN sla_breach_indicator = TRUE THEN 1 END)
      comment: "Number of workflows that breached their SLA — critical operational KPI; high values indicate process bottlenecks or resource constraints."
    - name: "escalation_count"
      expr: COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END)
      comment: "Number of workflows that required escalation — measures exception volume and management overhead in the document process."
    - name: "gcp_critical_workflow_count"
      expr: COUNT(CASE WHEN gcp_critical_document_flag = TRUE THEN 1 END)
      comment: "Number of workflows involving GCP-critical documents — quantifies the volume of highest-priority regulatory document processing."
    - name: "regulatory_submission_workflow_count"
      expr: COUNT(CASE WHEN regulatory_submission_flag = TRUE THEN 1 END)
      comment: "Number of workflows linked to regulatory submissions — measures submission-critical document processing activity."
    - name: "electronic_signature_required_count"
      expr: COUNT(CASE WHEN electronic_signature_required = TRUE THEN 1 END)
      comment: "Number of workflows requiring electronic signature — measures e-signature adoption and compliance with 21 CFR Part 11 requirements."
    - name: "archival_required_count"
      expr: COUNT(CASE WHEN archival_required = TRUE THEN 1 END)
      comment: "Number of workflows requiring archival — quantifies the downstream archival workload generated by document workflows."
    - name: "distinct_studies_with_workflows"
      expr: COUNT(DISTINCT study_id)
      comment: "Number of distinct studies with active or completed workflows — measures breadth of document workflow program coverage."
    - name: "cycle_time_days"
      expr: AVG(DATEDIFF(actual_completion_date, DATE(initiated_timestamp)))
      comment: "Average workflow cycle time in days from initiation to completion — key efficiency KPI for document review and approval processes; drives SLA target-setting."
$$;


CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`document_site_file`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Site file completeness and inspection readiness KPIs tracking essential document presence, completeness percentages, and open action items across study sites. Used by site managers, clinical operations leads, and QA directors to ensure site-level regulatory compliance."
  source: "`clinical_trials_ecm`.`document`.`site_file`"
  dimensions:
    - name: "study_id"
      expr: study_id
      comment: "Foreign key to the study — enables study-level site file analysis."
    - name: "study_site_id"
      expr: study_site_id
      comment: "Foreign key to the study site — primary dimension for site-level file completeness analysis."
    - name: "file_status"
      expr: file_status
      comment: "Current status of the site file (e.g., Active, Closed, Archived) — segments KPIs by file lifecycle stage."
    - name: "file_type"
      expr: file_type
      comment: "Type of site file (e.g., Investigator Site File, Sponsor File) — enables file-type-level completeness benchmarking."
    - name: "completeness_status"
      expr: completeness_status
      comment: "Categorical completeness status (e.g., Complete, Incomplete, Critical Gap) — primary operational status for site file management."
    - name: "inspection_readiness_status"
      expr: inspection_readiness_status
      comment: "Inspection readiness status of the site file — critical dimension for regulatory preparedness monitoring."
    - name: "regulatory_authority"
      expr: regulatory_authority
      comment: "Regulatory authority with jurisdiction over the site — enables authority-specific compliance analysis."
    - name: "tmf_zone"
      expr: tmf_zone
      comment: "TMF zone associated with the site file — enables zone-level completeness analysis."
    - name: "icf_on_file"
      expr: icf_on_file
      comment: "Boolean flag indicating whether the Informed Consent Form is on file — critical GCP compliance indicator."
    - name: "irb_iec_approval_on_file"
      expr: irb_iec_approval_on_file
      comment: "Boolean flag indicating whether IRB/IEC approval is on file — essential regulatory document presence indicator."
    - name: "investigator_cv_on_file"
      expr: investigator_cv_on_file
      comment: "Boolean flag indicating whether the investigator CV is on file — GCP essential document compliance indicator."
    - name: "sponsor_review_completed"
      expr: sponsor_review_completed
      comment: "Boolean flag indicating whether the sponsor review of the site file has been completed — measures sponsor oversight compliance."
    - name: "last_review_date"
      expr: DATE_TRUNC('month', last_review_date)
      comment: "Month bucket of the last site file review date — enables review cadence analysis and identification of overdue reviews."
  measures:
    - name: "total_site_files"
      expr: COUNT(1)
      comment: "Total number of site files — baseline volume metric for site file portfolio size."
    - name: "avg_completeness_percentage"
      expr: AVG(CAST(completeness_percentage AS DOUBLE))
      comment: "Average site file completeness percentage — primary KPI for site-level document completeness; used by clinical operations to prioritise site support."
    - name: "min_completeness_percentage"
      expr: MIN(completeness_percentage)
      comment: "Minimum site file completeness percentage — identifies the most incomplete site file requiring urgent remediation."
    - name: "icf_on_file_count"
      expr: COUNT(CASE WHEN icf_on_file = TRUE THEN 1 END)
      comment: "Number of site files with the Informed Consent Form on file — measures ICF compliance across the site portfolio."
    - name: "irb_approval_on_file_count"
      expr: COUNT(CASE WHEN irb_iec_approval_on_file = TRUE THEN 1 END)
      comment: "Number of site files with IRB/IEC approval on file — measures ethics approval documentation compliance."
    - name: "investigator_cv_on_file_count"
      expr: COUNT(CASE WHEN investigator_cv_on_file = TRUE THEN 1 END)
      comment: "Number of site files with investigator CV on file — measures investigator qualification documentation compliance."
    - name: "sponsor_review_completed_count"
      expr: COUNT(CASE WHEN sponsor_review_completed = TRUE THEN 1 END)
      comment: "Number of site files where sponsor review has been completed — measures sponsor oversight program completion rate."
    - name: "distinct_studies_with_site_files"
      expr: COUNT(DISTINCT study_id)
      comment: "Number of distinct studies with site files — measures breadth of site file management program."
    - name: "distinct_sites_with_files"
      expr: COUNT(DISTINCT study_site_id)
      comment: "Number of distinct study sites with site files — measures site-level document management coverage."
$$;


CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`document_regulatory_binder`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory submission binder KPIs tracking completeness, submission timelines, eCTD compliance, and inspection readiness across regulatory submissions. Used by regulatory affairs directors, submission managers, and executives to manage submission quality and agency relationship timelines."
  source: "`clinical_trials_ecm`.`document`.`regulatory_binder`"
  dimensions:
    - name: "binder_type"
      expr: binder_type
      comment: "Type of regulatory binder (e.g., IND, NDA, BLA, CTA) — primary segmentation for submission portfolio analysis."
    - name: "binder_status"
      expr: binder_status
      comment: "Current status of the regulatory binder (e.g., Active, Submitted, Approved, Withdrawn) — lifecycle stage dimension."
    - name: "target_agency"
      expr: target_agency
      comment: "Target regulatory agency (e.g., FDA, EMA, PMDA) — enables agency-specific submission performance analysis."
    - name: "submission_category"
      expr: submission_category
      comment: "Category of the submission (e.g., Original, Amendment, Supplement) — segments binder KPIs by submission type."
    - name: "review_pathway"
      expr: review_pathway
      comment: "Regulatory review pathway (e.g., Standard, Priority, Breakthrough) — enables pathway-specific timeline benchmarking."
    - name: "therapeutic_area"
      expr: therapeutic_area
      comment: "Therapeutic area of the submission — enables portfolio analysis by disease area."
    - name: "is_ectd_format"
      expr: is_ectd_format
      comment: "Boolean flag indicating whether the binder is in eCTD format — measures eCTD adoption and compliance with modern submission standards."
    - name: "is_inspection_ready"
      expr: is_inspection_ready
      comment: "Boolean flag indicating whether the binder is inspection-ready — critical regulatory preparedness dimension."
    - name: "ctd_module"
      expr: ctd_module
      comment: "CTD module associated with the binder — enables module-level completeness and quality analysis."
    - name: "confidentiality_level"
      expr: confidentiality_level
      comment: "Confidentiality classification of the binder — supports access control and data governance reporting."
    - name: "submission_date"
      expr: DATE_TRUNC('month', submission_date)
      comment: "Month bucket of the submission date — enables monthly submission volume and timeline trending."
    - name: "planned_submission_date"
      expr: DATE_TRUNC('month', planned_submission_date)
      comment: "Month bucket of the planned submission date — supports submission pipeline and forecast analysis."
  measures:
    - name: "total_regulatory_binders"
      expr: COUNT(1)
      comment: "Total number of regulatory binders — baseline volume metric for submission portfolio size."
    - name: "avg_completeness_percentage"
      expr: AVG(CAST(completeness_percentage AS DOUBLE))
      comment: "Average binder completeness percentage — primary KPI for submission readiness; low values indicate risk of submission delays or agency queries."
    - name: "min_completeness_percentage"
      expr: MIN(completeness_percentage)
      comment: "Minimum binder completeness percentage — identifies the least complete submission requiring urgent attention."
    - name: "inspection_ready_binder_count"
      expr: COUNT(CASE WHEN is_inspection_ready = TRUE THEN 1 END)
      comment: "Number of regulatory binders deemed inspection-ready — measures the proportion of the submission portfolio prepared for regulatory scrutiny."
    - name: "ectd_format_binder_count"
      expr: COUNT(CASE WHEN is_ectd_format = TRUE THEN 1 END)
      comment: "Number of binders in eCTD format — measures eCTD compliance rate across the submission portfolio."
    - name: "withdrawn_binder_count"
      expr: COUNT(CASE WHEN binder_status = 'Withdrawn' THEN 1 END)
      comment: "Number of withdrawn regulatory binders — measures submission attrition rate; high values may indicate quality or strategic issues."
    - name: "approved_binder_count"
      expr: COUNT(CASE WHEN binder_status = 'Approved' THEN 1 END)
      comment: "Number of approved regulatory binders — measures submission success rate and regulatory approval throughput."
    - name: "distinct_agencies_submitted_to"
      expr: COUNT(DISTINCT target_agency)
      comment: "Number of distinct regulatory agencies with active binders — measures geographic and regulatory scope of the submission program."
    - name: "submission_timeline_variance_days"
      expr: AVG(DATEDIFF(submission_date, planned_submission_date))
      comment: "Average variance in days between planned and actual submission date — measures submission planning accuracy; positive values indicate delays that may impact approval timelines."
$$;


CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`document_distribution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Document distribution KPIs tracking acknowledgement compliance, distribution volumes, training completion, and overdue acknowledgements across document types and recipient organisations. Used by document control managers and compliance officers to ensure controlled document distribution obligations are met."
  source: "`clinical_trials_ecm`.`document`.`distribution`"
  dimensions:
    - name: "study_id"
      expr: study_id
      comment: "Foreign key to the study — enables study-level distribution compliance analysis."
    - name: "document_type"
      expr: document_type
      comment: "Type of document being distributed (e.g., Protocol, SOP, IB) — primary segmentation for distribution compliance analysis."
    - name: "distribution_status"
      expr: distribution_status
      comment: "Current status of the distribution (e.g., Sent, Acknowledged, Overdue) — operational status dimension for compliance monitoring."
    - name: "distribution_method"
      expr: distribution_method
      comment: "Method used for distribution (e.g., eTMF, Email, Paper) — enables channel-level distribution analysis."
    - name: "distribution_scope"
      expr: distribution_scope
      comment: "Scope of the distribution (e.g., Global, Country, Site) — segments distribution KPIs by reach."
    - name: "recipient_organization_type"
      expr: recipient_organization_type
      comment: "Type of recipient organisation (e.g., Site, CRO, Sponsor) — enables organisation-type-level compliance analysis."
    - name: "recipient_role"
      expr: recipient_role
      comment: "Role of the document recipient — enables role-level acknowledgement compliance analysis."
    - name: "acknowledgement_required"
      expr: acknowledgement_required
      comment: "Boolean flag indicating whether acknowledgement is required — segments distributions by compliance obligation."
    - name: "training_required"
      expr: training_required
      comment: "Boolean flag indicating whether training is required upon receipt — segments distributions with training obligations."
    - name: "tmf_zone"
      expr: tmf_zone
      comment: "TMF zone associated with the distributed document — enables zone-level distribution analysis."
    - name: "distribution_date"
      expr: DATE_TRUNC('month', distribution_date)
      comment: "Month bucket of the distribution date — enables monthly distribution volume and compliance trending."
  measures:
    - name: "total_distributions"
      expr: COUNT(1)
      comment: "Total number of document distributions — baseline volume metric for distribution program activity."
    - name: "acknowledgement_required_count"
      expr: COUNT(CASE WHEN acknowledgement_required = TRUE THEN 1 END)
      comment: "Number of distributions requiring acknowledgement — quantifies the total acknowledgement compliance obligation."
    - name: "acknowledged_count"
      expr: COUNT(CASE WHEN acknowledgement_required = TRUE AND distribution_status = 'Acknowledged' THEN 1 END)
      comment: "Number of distributions that have been acknowledged — measures acknowledgement compliance fulfilment."
    - name: "overdue_acknowledgement_count"
      expr: COUNT(CASE WHEN acknowledgement_required = TRUE AND distribution_status = 'Overdue' THEN 1 END)
      comment: "Number of distributions with overdue acknowledgements — critical compliance risk metric; drives escalation and follow-up actions."
    - name: "training_required_count"
      expr: COUNT(CASE WHEN training_required = TRUE THEN 1 END)
      comment: "Number of distributions requiring training completion — quantifies the training compliance obligation generated by document distributions."
    - name: "reminder_sent_count"
      expr: COUNT(CASE WHEN reminder_sent = TRUE THEN 1 END)
      comment: "Number of distributions where a reminder was sent — measures the volume of follow-up activity required to achieve acknowledgement compliance."
    - name: "distinct_studies_with_distributions"
      expr: COUNT(DISTINCT study_id)
      comment: "Number of distinct studies with document distributions — measures breadth of distribution program coverage."
    - name: "distinct_recipient_organisations"
      expr: COUNT(DISTINCT recipient_organization)
      comment: "Number of distinct recipient organisations — measures the reach and complexity of the document distribution network."
$$;


CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`document_signature`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Electronic and wet signature KPIs tracking signature completion rates, overdue signatures, void rates, and regulatory submission applicability across document types and signer roles. Used by document control managers, QA leads, and compliance officers to ensure 21 CFR Part 11 and ICH E6 signature compliance."
  source: "`clinical_trials_ecm`.`document`.`signature`"
  dimensions:
    - name: "study_id"
      expr: study_id
      comment: "Foreign key to the study — enables study-level signature compliance analysis."
    - name: "study_site_id"
      expr: study_site_id
      comment: "Foreign key to the study site — enables site-level signature compliance analysis."
    - name: "signature_type"
      expr: signature_type
      comment: "Type of signature (e.g., Approval, Authorship, Review) — primary segmentation for signature compliance analysis."
    - name: "signature_status"
      expr: signature_status
      comment: "Current status of the signature (e.g., Pending, Signed, Voided, Overdue) — operational status dimension for compliance monitoring."
    - name: "signature_method"
      expr: signature_method
      comment: "Method used for signing (e.g., Electronic, Wet Ink) — enables e-signature adoption analysis and 21 CFR Part 11 compliance tracking."
    - name: "signer_role"
      expr: signer_role
      comment: "Role of the signer (e.g., Principal Investigator, Sponsor Representative) — enables role-level signature compliance analysis."
    - name: "signer_organization"
      expr: signer_organization
      comment: "Organisation of the signer — enables organisation-level signature compliance analysis."
    - name: "is_regulatory_submission_applicable"
      expr: is_regulatory_submission_applicable
      comment: "Boolean flag indicating whether the signature is applicable to a regulatory submission — segments high-stakes signatures."
    - name: "inspection_readiness_flag"
      expr: inspection_readiness_flag
      comment: "Boolean flag indicating whether the signature is relevant to inspection readiness — segments inspection-critical signatures."
    - name: "tmf_zone"
      expr: tmf_zone
      comment: "TMF zone associated with the signed document — enables zone-level signature compliance analysis."
    - name: "signed_month"
      expr: DATE_TRUNC('month', signed_timestamp)
      comment: "Month bucket of the signature timestamp — enables monthly signature volume and compliance trending."
    - name: "due_date"
      expr: DATE_TRUNC('month', due_date)
      comment: "Month bucket of the signature due date — supports forward-looking signature pipeline and overdue analysis."
  measures:
    - name: "total_signature_requests"
      expr: COUNT(1)
      comment: "Total number of signature requests — baseline volume metric for signature program activity."
    - name: "signed_count"
      expr: COUNT(CASE WHEN signature_status = 'Signed' THEN 1 END)
      comment: "Number of completed signatures — measures signature fulfilment throughput and compliance rate."
    - name: "pending_signature_count"
      expr: COUNT(CASE WHEN signature_status = 'Pending' THEN 1 END)
      comment: "Number of signatures still pending — measures outstanding signature obligation and potential compliance risk."
    - name: "overdue_signature_count"
      expr: COUNT(CASE WHEN signature_status = 'Overdue' THEN 1 END)
      comment: "Number of overdue signatures — critical compliance risk metric; drives escalation to document owners and management."
    - name: "voided_signature_count"
      expr: COUNT(CASE WHEN signature_status = 'Voided' THEN 1 END)
      comment: "Number of voided signatures — measures signature quality issues and rework volume; high void rates indicate process problems."
    - name: "electronic_signature_count"
      expr: COUNT(CASE WHEN signature_method = 'Electronic' THEN 1 END)
      comment: "Number of electronic signatures — measures e-signature adoption rate and 21 CFR Part 11 compliance footprint."
    - name: "regulatory_submission_applicable_count"
      expr: COUNT(CASE WHEN is_regulatory_submission_applicable = TRUE THEN 1 END)
      comment: "Number of signatures applicable to regulatory submissions — quantifies the volume of highest-stakes signatures requiring strict compliance."
    - name: "inspection_ready_signature_count"
      expr: COUNT(CASE WHEN inspection_readiness_flag = TRUE THEN 1 END)
      comment: "Number of signatures flagged as inspection-ready — measures the completeness of inspection-critical signature documentation."
    - name: "distinct_studies_with_signatures"
      expr: COUNT(DISTINCT study_id)
      comment: "Number of distinct studies with signature activity — measures breadth of signature compliance program coverage."
$$;


CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`document_archival_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Document archival KPIs tracking archival completeness, retention compliance, litigation hold exposure, and destruction authorisation across studies and sites. Used by records management leads, legal counsel, and compliance officers to manage regulatory retention obligations and litigation risk."
  source: "`clinical_trials_ecm`.`document`.`archival_record`"
  dimensions:
    - name: "study_id"
      expr: study_id
      comment: "Foreign key to the study — enables study-level archival compliance analysis."
    - name: "study_site_id"
      expr: study_site_id
      comment: "Foreign key to the study site — enables site-level archival analysis."
    - name: "archival_status"
      expr: archival_status
      comment: "Current status of the archival record (e.g., Archived, Pending, Retrieved) — primary operational status dimension."
    - name: "archival_type"
      expr: archival_type
      comment: "Type of archival (e.g., Physical, Electronic, Hybrid) — enables archival method analysis."
    - name: "document_classification"
      expr: document_classification
      comment: "Classification of the archived document — enables classification-level retention and compliance analysis."
    - name: "regulatory_authority"
      expr: regulatory_authority
      comment: "Regulatory authority associated with the archived document — enables authority-specific retention compliance analysis."
    - name: "retention_basis"
      expr: retention_basis
      comment: "Legal or regulatory basis for the retention period — segments archival records by retention obligation type."
    - name: "inspection_readiness_flag"
      expr: inspection_readiness_flag
      comment: "Boolean flag indicating whether the archived document is inspection-ready — critical dimension for regulatory preparedness."
    - name: "litigation_hold_flag"
      expr: litigation_hold_flag
      comment: "Boolean flag indicating whether the document is under litigation hold — critical legal risk dimension."
    - name: "transfer_of_custody_flag"
      expr: transfer_of_custody_flag
      comment: "Boolean flag indicating whether custody has been transferred — tracks chain of custody compliance."
    - name: "country_code"
      expr: country_code
      comment: "Country code associated with the archival record — enables country-level retention compliance analysis."
    - name: "archival_date"
      expr: DATE_TRUNC('month', archival_date)
      comment: "Month bucket of the archival date — enables monthly archival volume trending."
    - name: "retention_expiry_date"
      expr: DATE_TRUNC('year', retention_expiry_date)
      comment: "Year bucket of the retention expiry date — supports retention expiry pipeline analysis and destruction scheduling."
  measures:
    - name: "total_archival_records"
      expr: COUNT(1)
      comment: "Total number of archival records — baseline volume metric for the archival portfolio."
    - name: "litigation_hold_count"
      expr: COUNT(CASE WHEN litigation_hold_flag = TRUE THEN 1 END)
      comment: "Number of documents under litigation hold — critical legal risk metric; any increase triggers legal review and resource allocation."
    - name: "inspection_ready_archival_count"
      expr: COUNT(CASE WHEN inspection_readiness_flag = TRUE THEN 1 END)
      comment: "Number of archived documents flagged as inspection-ready — measures the proportion of the archive prepared for regulatory inspection."
    - name: "custody_transferred_count"
      expr: COUNT(CASE WHEN transfer_of_custody_flag = TRUE THEN 1 END)
      comment: "Number of archival records with custody transferred — measures chain of custody compliance and transfer program completion."
    - name: "retrieved_record_count"
      expr: COUNT(CASE WHEN archival_status = 'Retrieved' THEN 1 END)
      comment: "Number of archived documents currently retrieved — measures active retrieval volume and archive access demand."
    - name: "pending_destruction_count"
      expr: COUNT(CASE WHEN destruction_date IS NOT NULL AND archival_status != 'Destroyed' THEN 1 END)
      comment: "Number of records with a destruction date set but not yet destroyed — measures pending destruction backlog and retention compliance risk."
    - name: "distinct_studies_archived"
      expr: COUNT(DISTINCT study_id)
      comment: "Number of distinct studies with archival records — measures breadth of archival program coverage."
    - name: "distinct_archive_facilities"
      expr: COUNT(DISTINCT archive_facility_name)
      comment: "Number of distinct archive facilities in use — measures archive infrastructure footprint and vendor management scope."
$$;


CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`document_sop`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Standard Operating Procedure (SOP) lifecycle KPIs tracking SOP currency, inspection readiness, training obligations, and regulatory framework coverage. Used by QA directors, compliance managers, and training coordinators to maintain a current, compliant SOP library."
  source: "`clinical_trials_ecm`.`document`.`document_sop`"
  dimensions:
    - name: "sop_category"
      expr: sop_category
      comment: "Category of the SOP (e.g., Clinical Operations, Data Management, Pharmacovigilance) — primary segmentation for SOP portfolio analysis."
    - name: "sop_type"
      expr: sop_type
      comment: "Type of SOP (e.g., Standard, Guideline, Work Instruction) — enables document-type-level compliance analysis."
    - name: "sop_status"
      expr: sop_status
      comment: "Current lifecycle status of the SOP (e.g., Effective, Superseded, Retired, Draft) — primary operational status dimension."
    - name: "process_area"
      expr: process_area
      comment: "Business process area covered by the SOP — enables process-level SOP coverage analysis."
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework the SOP supports (e.g., ICH E6, 21 CFR Part 11, GDPR) — enables framework-level compliance coverage analysis."
    - name: "applicable_region"
      expr: applicable_region
      comment: "Geographic region where the SOP applies — enables regional SOP compliance analysis."
    - name: "gcp_applicable"
      expr: gcp_applicable
      comment: "Boolean flag indicating whether the SOP is GCP-applicable — segments GCP-critical SOPs for prioritised compliance monitoring."
    - name: "inspection_ready"
      expr: inspection_ready
      comment: "Boolean flag indicating whether the SOP is inspection-ready — critical dimension for regulatory preparedness."
    - name: "training_required"
      expr: training_required
      comment: "Boolean flag indicating whether training is required for this SOP — segments SOPs with training obligations."
    - name: "deviation_triggered"
      expr: deviation_triggered
      comment: "Boolean flag indicating whether a deviation was triggered against this SOP — identifies SOPs with compliance issues."
    - name: "effective_date"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month bucket of the SOP effective date — enables monthly SOP issuance volume trending."
    - name: "review_due_date"
      expr: DATE_TRUNC('month', review_due_date)
      comment: "Month bucket of the SOP review due date — supports review pipeline and overdue SOP identification."
  measures:
    - name: "total_sops"
      expr: COUNT(1)
      comment: "Total number of SOPs in the library — baseline volume metric for SOP portfolio size."
    - name: "effective_sop_count"
      expr: COUNT(CASE WHEN sop_status = 'Effective' THEN 1 END)
      comment: "Number of currently effective SOPs — measures the active, compliant SOP library size available to staff."
    - name: "inspection_ready_sop_count"
      expr: COUNT(CASE WHEN inspection_ready = TRUE THEN 1 END)
      comment: "Number of SOPs deemed inspection-ready — measures the proportion of the SOP library prepared for regulatory inspection."
    - name: "gcp_applicable_sop_count"
      expr: COUNT(CASE WHEN gcp_applicable = TRUE THEN 1 END)
      comment: "Number of GCP-applicable SOPs — quantifies the GCP compliance documentation footprint."
    - name: "training_required_sop_count"
      expr: COUNT(CASE WHEN training_required = TRUE THEN 1 END)
      comment: "Number of SOPs requiring staff training — quantifies the training compliance obligation generated by the SOP library."
    - name: "deviation_triggered_sop_count"
      expr: COUNT(CASE WHEN deviation_triggered = TRUE THEN 1 END)
      comment: "Number of SOPs against which a deviation has been triggered — measures SOP compliance failure rate; high values indicate process or training gaps."
    - name: "superseded_sop_count"
      expr: COUNT(CASE WHEN sop_status = 'Superseded' THEN 1 END)
      comment: "Number of superseded SOPs — measures SOP turnover rate and version management activity."
    - name: "distinct_process_areas_covered"
      expr: COUNT(DISTINCT process_area)
      comment: "Number of distinct process areas covered by SOPs — measures breadth of SOP library coverage across business processes."
    - name: "distinct_regulatory_frameworks_covered"
      expr: COUNT(DISTINCT regulatory_framework)
      comment: "Number of distinct regulatory frameworks covered by SOPs — measures regulatory compliance coverage breadth."
$$;
