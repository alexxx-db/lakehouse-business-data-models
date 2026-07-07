-- Metric views for domain: design | Business: Construction | Version: 2 | Generated on: 2026-06-27 01:50:09

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`design_bim_model`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "BIM model quality, compliance, and size metrics for design governance. Tracks ISO 19650 compliance, clash detection health, and model file footprint across disciplines and lifecycle stages."
  source: "`vibe_construction_v1`.`design`.`bim_model`"
  dimensions:
    - name: "discipline"
      expr: discipline
      comment: "Engineering discipline (e.g. Structural, MEP, Civil) for cross-discipline BIM performance analysis."
    - name: "model_status"
      expr: model_status
      comment: "Current status of the BIM model (e.g. In Progress, Approved, Superseded) for lifecycle tracking."
    - name: "model_type"
      expr: model_type
      comment: "Type of BIM model (e.g. Architectural, Structural, Federated) for categorised reporting."
    - name: "lod_classification"
      expr: lod_classification
      comment: "Level of Development classification indicating model maturity and detail level."
    - name: "lifecycle_stage"
      expr: lifecycle_stage
      comment: "Project lifecycle stage (e.g. Design, Construction, Handover) the model belongs to."
    - name: "authoring_software"
      expr: authoring_software
      comment: "Software used to author the BIM model (e.g. Revit, ArchiCAD) for tooling governance."
    - name: "clash_detection_status"
      expr: clash_detection_status
      comment: "Status of clash detection runs (e.g. Passed, Failed, Pending) for quality gate monitoring."
    - name: "iso_19650_compliance_flag"
      expr: iso_19650_compliance_flag
      comment: "Boolean flag indicating whether the model meets ISO 19650 information management standards."
    - name: "federation_role"
      expr: federation_role
      comment: "Role of the model within a federated BIM environment (e.g. Host, Reference, Linked)."
    - name: "issue_date"
      expr: DATE_TRUNC('month', issue_date)
      comment: "Month of model issue date for trend analysis of BIM deliverable cadence."
  measures:
    - name: "total_bim_models"
      expr: COUNT(1)
      comment: "Total number of BIM models. Baseline volume metric for design output tracking."
    - name: "iso_19650_compliant_models"
      expr: COUNT(CASE WHEN iso_19650_compliance_flag = TRUE THEN 1 END)
      comment: "Count of BIM models that are ISO 19650 compliant. Drives regulatory and contractual compliance reporting."
    - name: "iso_19650_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN iso_19650_compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of BIM models meeting ISO 19650 compliance. Key governance KPI for design quality assurance."
    - name: "models_with_active_clashes"
      expr: COUNT(CASE WHEN clash_detection_status = 'Failed' THEN 1 END)
      comment: "Number of BIM models with unresolved clash detection failures. Directly impacts construction rework risk and cost."
    - name: "clash_free_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN clash_detection_status = 'Passed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of BIM models that have passed clash detection. Measures design coordination quality and readiness for construction."
    - name: "total_file_size_mb"
      expr: SUM(CAST(file_size_mb AS DOUBLE))
      comment: "Total storage footprint of all BIM models in megabytes. Informs infrastructure and data management investment decisions."
    - name: "avg_file_size_mb"
      expr: AVG(CAST(file_size_mb AS DOUBLE))
      comment: "Average BIM model file size in megabytes. Benchmarks model complexity and authoring discipline standards."
    - name: "superseded_model_count"
      expr: COUNT(CASE WHEN superseded_by_model_bim_model_id IS NOT NULL THEN 1 END)
      comment: "Number of BIM models that have been superseded. Indicates design churn and revision frequency impacting project schedule."
    - name: "active_model_count"
      expr: COUNT(CASE WHEN model_status = 'Approved' THEN 1 END)
      comment: "Count of BIM models in Approved status. Measures the volume of design deliverables ready for construction use."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`design_drawing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Drawing production, approval, and quality metrics for design deliverable management. Tracks drawing status, client deliverable readiness, and revision activity across disciplines."
  source: "`vibe_construction_v1`.`design`.`drawing`"
  dimensions:
    - name: "discipline"
      expr: discipline
      comment: "Engineering discipline the drawing belongs to (e.g. Civil, Structural, Electrical)."
    - name: "drawing_status"
      expr: drawing_status
      comment: "Current status of the drawing (e.g. Issued for Construction, Under Review, Superseded)."
    - name: "drawing_type"
      expr: drawing_type
      comment: "Type of drawing (e.g. General Arrangement, Detail, Schematic) for deliverable categorisation."
    - name: "is_client_deliverable"
      expr: is_client_deliverable
      comment: "Boolean flag indicating whether the drawing is a contractual client deliverable."
    - name: "is_controlled_document"
      expr: is_controlled_document
      comment: "Boolean flag indicating whether the drawing is under document control procedures."
    - name: "clash_detection_status"
      expr: clash_detection_status
      comment: "Clash detection status for the drawing, indicating coordination quality."
    - name: "issue_purpose"
      expr: issue_purpose
      comment: "Purpose for which the drawing was issued (e.g. For Construction, For Review, For Approval)."
    - name: "originator"
      expr: originator
      comment: "Organisation or individual who originated the drawing for accountability tracking."
    - name: "approval_date_month"
      expr: DATE_TRUNC('month', approval_date)
      comment: "Month of drawing approval for trend analysis of design approval throughput."
    - name: "created_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month the drawing record was created for production volume trending."
  measures:
    - name: "total_drawings"
      expr: COUNT(1)
      comment: "Total number of drawings in the register. Baseline design output volume metric."
    - name: "client_deliverable_drawings"
      expr: COUNT(CASE WHEN is_client_deliverable = TRUE THEN 1 END)
      comment: "Count of drawings that are contractual client deliverables. Tracks delivery obligation fulfilment."
    - name: "approved_drawings"
      expr: COUNT(CASE WHEN drawing_status = 'Approved' THEN 1 END)
      comment: "Number of drawings in Approved status. Measures design completion and readiness for construction."
    - name: "drawing_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN drawing_status = 'Approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of drawings that have been approved. Key design progress KPI for project steering."
    - name: "superseded_drawings"
      expr: COUNT(CASE WHEN superseded_by_drawing_number IS NOT NULL THEN 1 END)
      comment: "Number of drawings that have been superseded by a newer revision. Indicates design instability and rework risk."
    - name: "total_drawing_file_size_mb"
      expr: SUM(CAST(file_size_mb AS DOUBLE))
      comment: "Total file storage consumed by drawings in megabytes. Informs document management infrastructure planning."
    - name: "avg_drawing_file_size_mb"
      expr: AVG(CAST(file_size_mb AS DOUBLE))
      comment: "Average drawing file size in megabytes. Benchmarks drawing complexity across disciplines."
    - name: "controlled_document_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_controlled_document = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of drawings under formal document control. Measures governance compliance of the drawing register."
    - name: "drawings_with_clash_failures"
      expr: COUNT(CASE WHEN clash_detection_status = 'Failed' THEN 1 END)
      comment: "Number of drawings with unresolved clash detection failures. Directly linked to construction coordination risk."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`design_drawing_revision`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Drawing revision velocity, approval cycle, and distribution metrics. Tracks revision frequency, schedule/cost impact flags, and distribution effectiveness to support design change management decisions."
  source: "`vibe_construction_v1`.`design`.`revision`"
  dimensions:
    - name: "revision_status"
      expr: revision_status
      comment: "Current status of the revision (e.g. Issued, Under Review, Superseded)."
    - name: "revision_type"
      expr: revision_type
      comment: "Type of revision (e.g. Minor, Major, As-Built) for change impact classification."
    - name: "revision_date_month"
      expr: DATE_TRUNC('month', revision_date)
      comment: "Month of revision date for trend analysis of design change velocity."
    - name: "approval_date_month"
      expr: DATE_TRUNC('month', approval_date)
      comment: "Month of revision approval for approval throughput trending."
  measures:
    - name: "total_drawing_revisions"
      expr: COUNT(1)
      comment: "Total number of drawing revisions. Baseline metric for design change volume and velocity."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`design_engineering_submittal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Engineering submittal review cycle, compliance, and cost/schedule impact metrics. Tracks submittal approval rates, review timeliness, regulatory compliance, and financial exposure from submittals."
  source: "`vibe_construction_v1`.`design`.`engineering_submittal`"
  dimensions:
    - name: "discipline"
      expr: discipline
      comment: "Engineering discipline of the submittal (e.g. Structural, MEP, Civil)."
    - name: "submittal_status"
      expr: submittal_status
      comment: "Current status of the submittal (e.g. Approved, Rejected, Under Review, Pending)."
    - name: "submittal_type"
      expr: submittal_type
      comment: "Type of submittal (e.g. Shop Drawing, Material Sample, Method Statement) for categorised tracking."
    - name: "approval_disposition"
      expr: approval_disposition
      comment: "Reviewer disposition on the submittal (e.g. Approved, Approved with Comments, Rejected)."
    - name: "approval_authority_level"
      expr: approval_authority_level
      comment: "Authority level required to approve the submittal (e.g. Engineer, Client, Regulatory Body)."
    - name: "priority"
      expr: priority
      comment: "Priority level of the submittal (e.g. High, Medium, Low) for workload triage."
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Boolean flag indicating whether the submittal has a regulatory compliance requirement."
    - name: "cost_impact_flag"
      expr: cost_impact_flag
      comment: "Boolean flag indicating whether the submittal carries a cost impact."
    - name: "schedule_impact_flag"
      expr: schedule_impact_flag
      comment: "Boolean flag indicating whether the submittal carries a schedule impact."
    - name: "submitting_organization"
      expr: submitting_organization
      comment: "Organisation submitting the engineering submittal for vendor/subcontractor performance tracking."
    - name: "actual_submission_month"
      expr: DATE_TRUNC('month', actual_submission_date)
      comment: "Month of actual submission for submittal volume trending."
    - name: "actual_review_month"
      expr: DATE_TRUNC('month', actual_review_date)
      comment: "Month of actual review completion for review throughput trending."
  measures:
    - name: "total_submittals"
      expr: COUNT(1)
      comment: "Total number of engineering submittals. Baseline volume metric for design review workload."
    - name: "approved_submittals"
      expr: COUNT(CASE WHEN submittal_status = 'Approved' THEN 1 END)
      comment: "Number of submittals that have been approved. Measures design review throughput and procurement readiness."
    - name: "submittal_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN submittal_status = 'Approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of submittals approved. Key KPI for design review efficiency and vendor quality performance."
    - name: "rejected_submittals"
      expr: COUNT(CASE WHEN submittal_status = 'Rejected' THEN 1 END)
      comment: "Number of rejected submittals. High rejection rates signal vendor quality issues or unclear specifications."
    - name: "submittal_rejection_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN submittal_status = 'Rejected' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of submittals rejected. Directly linked to rework cost and schedule delay risk."
    - name: "submittals_with_cost_impact"
      expr: COUNT(CASE WHEN cost_impact_flag = TRUE THEN 1 END)
      comment: "Number of submittals flagged as having a cost impact. Informs change order and budget exposure tracking."
    - name: "total_estimated_cost_impact"
      expr: SUM(CAST(estimated_cost_impact_amount AS DOUBLE))
      comment: "Total estimated cost impact across all submittals in currency units. Critical financial exposure metric for project controls."
    - name: "avg_estimated_cost_impact"
      expr: AVG(CAST(estimated_cost_impact_amount AS DOUBLE))
      comment: "Average estimated cost impact per submittal. Benchmarks the financial weight of design changes per submittal event."
    - name: "submittals_with_schedule_impact"
      expr: COUNT(CASE WHEN schedule_impact_flag = TRUE THEN 1 END)
      comment: "Number of submittals flagged as having a schedule impact. Directly informs critical path and delay risk management."
    - name: "overdue_submittals"
      expr: COUNT(CASE WHEN review_due_date < CURRENT_DATE AND submittal_status NOT IN ('Approved', 'Closed') THEN 1 END)
      comment: "Number of submittals past their review due date and not yet closed. Measures review process bottlenecks and schedule risk."
    - name: "regulatory_compliant_submittals"
      expr: COUNT(CASE WHEN regulatory_compliance_flag = TRUE THEN 1 END)
      comment: "Number of submittals with regulatory compliance requirements. Tracks regulatory obligation fulfilment in the design phase."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`design_rfi`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Request for Information (RFI) volume, response performance, and cost/schedule impact metrics. Tracks RFI cycle times, financial exposure, and resolution rates to manage design ambiguity and its downstream project impact."
  source: "`vibe_construction_v1`.`design`.`rfi`"
  dimensions:
    - name: "discipline"
      expr: discipline
      comment: "Engineering discipline the RFI relates to for cross-discipline design gap analysis."
    - name: "rfi_status"
      expr: rfi_status
      comment: "Current status of the RFI (e.g. Open, Closed, Under Review, Overdue)."
    - name: "priority"
      expr: priority
      comment: "Priority level of the RFI (e.g. Critical, High, Medium, Low) for triage and escalation management."
    - name: "cost_impact_flag"
      expr: cost_impact_flag
      comment: "Boolean flag indicating whether the RFI carries a cost impact."
    - name: "schedule_impact_flag"
      expr: schedule_impact_flag
      comment: "Boolean flag indicating whether the RFI carries a schedule impact."
    - name: "date_raised_month"
      expr: DATE_TRUNC('month', date_raised)
      comment: "Month the RFI was raised for trend analysis of design query volume over time."
    - name: "closure_month"
      expr: DATE_TRUNC('month', closure_date)
      comment: "Month the RFI was closed for resolution throughput trending."
  measures:
    - name: "total_rfis"
      expr: COUNT(1)
      comment: "Total number of RFIs raised. Baseline metric for design ambiguity volume and information management workload."
    - name: "open_rfis"
      expr: COUNT(CASE WHEN rfi_status = 'Open' THEN 1 END)
      comment: "Number of currently open RFIs. Measures outstanding design information gaps that may block construction progress."
    - name: "closed_rfis"
      expr: COUNT(CASE WHEN rfi_status = 'Closed' THEN 1 END)
      comment: "Number of closed RFIs. Measures resolution throughput and design team responsiveness."
    - name: "rfi_closure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN rfi_status = 'Closed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of RFIs that have been closed. Key KPI for design information management effectiveness."
    - name: "overdue_rfis"
      expr: COUNT(CASE WHEN response_due_date < CURRENT_DATE AND rfi_status != 'Closed' THEN 1 END)
      comment: "Number of RFIs past their response due date and still open. Directly flags design team SLA breaches and construction delay risk."
    - name: "rfis_with_cost_impact"
      expr: COUNT(CASE WHEN cost_impact_flag = TRUE THEN 1 END)
      comment: "Number of RFIs flagged as having a cost impact. Informs change order exposure and budget risk."
    - name: "total_rfi_cost_impact"
      expr: SUM(CAST(cost_impact_amount AS DOUBLE))
      comment: "Total financial exposure from RFIs with cost impacts in currency units. Critical metric for project budget risk management."
    - name: "avg_rfi_cost_impact"
      expr: AVG(CAST(cost_impact_amount AS DOUBLE))
      comment: "Average cost impact per RFI. Benchmarks the financial weight of design information gaps."
    - name: "rfis_with_schedule_impact"
      expr: COUNT(CASE WHEN schedule_impact_flag = TRUE THEN 1 END)
      comment: "Number of RFIs flagged as having a schedule impact. Directly informs critical path risk and delay management."
    - name: "high_priority_open_rfis"
      expr: COUNT(CASE WHEN priority = 'High' AND rfi_status = 'Open' THEN 1 END)
      comment: "Number of high-priority RFIs that remain open. Escalation metric for executive attention on critical design blockers."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`design_package`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Design package delivery, completeness, and approval metrics. Tracks package submission performance against contractual due dates, completeness levels, and client acceptance rates for design deliverable governance."
  source: "`vibe_construction_v1`.`design`.`package`"
  dimensions:
    - name: "discipline"
      expr: discipline
      comment: "Engineering discipline of the design package for cross-discipline delivery performance analysis."
    - name: "package_status"
      expr: package_status
      comment: "Current status of the package (e.g. Issued, Under Review, Approved, Rejected)."
    - name: "package_type"
      expr: package_type
      comment: "Type of design package (e.g. IFC, IFR, IFA) for deliverable category analysis."
    - name: "milestone_stage"
      expr: milestone_stage
      comment: "Project milestone stage the package is associated with (e.g. FEED, Detailed Design, As-Built)."
    - name: "approval_workflow_state"
      expr: approval_workflow_state
      comment: "Current state in the approval workflow for bottleneck identification."
    - name: "client_acceptance_status"
      expr: client_acceptance_status
      comment: "Client acceptance status of the package (e.g. Accepted, Rejected, Pending) for contractual obligation tracking."
    - name: "submission_status"
      expr: submission_status
      comment: "Submission status of the package (e.g. Submitted, Not Submitted, Late) for schedule compliance monitoring."
    - name: "iso_19650_compliance_flag"
      expr: iso_19650_compliance_flag
      comment: "Boolean flag indicating whether the package meets ISO 19650 information management standards."
    - name: "responsible_organization"
      expr: responsible_organization
      comment: "Organisation responsible for delivering the package for accountability and performance tracking."
    - name: "planned_issue_month"
      expr: DATE_TRUNC('month', planned_issue_date)
      comment: "Month of planned issue date for schedule adherence trending."
    - name: "actual_submission_month"
      expr: DATE_TRUNC('month', actual_submission_date)
      comment: "Month of actual submission for delivery volume trending."
  measures:
    - name: "total_packages"
      expr: COUNT(1)
      comment: "Total number of design packages. Baseline metric for design deliverable volume."
    - name: "approved_packages"
      expr: COUNT(CASE WHEN package_status = 'Approved' THEN 1 END)
      comment: "Number of packages that have been approved. Measures design completion and readiness for construction."
    - name: "package_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN package_status = 'Approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of design packages approved. Key design delivery KPI for project steering and client reporting."
    - name: "client_accepted_packages"
      expr: COUNT(CASE WHEN client_acceptance_status = 'Accepted' THEN 1 END)
      comment: "Number of packages formally accepted by the client. Measures contractual delivery fulfilment."
    - name: "client_acceptance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN client_acceptance_status = 'Accepted' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of packages accepted by the client. Critical KPI for contract performance and revenue recognition milestones."
    - name: "late_submissions"
      expr: COUNT(CASE WHEN actual_submission_date > contractual_due_date AND actual_submission_date IS NOT NULL THEN 1 END)
      comment: "Number of packages submitted after their contractual due date. Directly measures design schedule compliance and delay risk."
    - name: "on_time_submission_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN actual_submission_date <= contractual_due_date AND actual_submission_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(CASE WHEN actual_submission_date IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of packages submitted on or before the contractual due date. Key schedule performance indicator for design delivery."
    - name: "avg_package_completeness_pct"
      expr: AVG(CAST(completeness_percentage AS DOUBLE))
      comment: "Average completeness percentage across all design packages. Measures overall design maturity and readiness for construction."
    - name: "iso_19650_compliant_packages"
      expr: COUNT(CASE WHEN iso_19650_compliance_flag = TRUE THEN 1 END)
      comment: "Number of packages meeting ISO 19650 compliance. Tracks information management governance across design deliverables."
    - name: "superseded_packages"
      expr: COUNT(CASE WHEN supersedes_package_number IS NOT NULL THEN 1 END)
      comment: "Number of packages that supersede a prior package. Indicates design revision frequency and associated rework cost."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`design_workflow_approval`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Design workflow approval cycle time, SLA compliance, and escalation metrics. Tracks approval throughput, SLA adherence, and escalation rates to optimise the design review and approval process."
  source: "`vibe_construction_v1`.`design`.`workflow_approval`"
  dimensions:
    - name: "workflow_type"
      expr: workflow_type
      comment: "Type of approval workflow (e.g. Drawing Review, Submittal Approval, Document Release) for process-level analysis."
    - name: "workflow_status"
      expr: workflow_status
      comment: "Current status of the workflow (e.g. In Progress, Completed, Escalated, Overdue)."
    - name: "overall_outcome"
      expr: overall_outcome
      comment: "Final outcome of the workflow (e.g. Approved, Rejected, Withdrawn) for approval decision analysis."
    - name: "approval_authority_level"
      expr: approval_authority_level
      comment: "Authority level required for the approval (e.g. Engineer, Manager, Director) for governance tier analysis."
    - name: "assigned_reviewer_role"
      expr: assigned_reviewer_role
      comment: "Role assigned to review the workflow step for workload and capacity analysis."
    - name: "priority"
      expr: priority
      comment: "Priority level of the workflow (e.g. High, Medium, Low) for triage and escalation management."
    - name: "sla_compliance_flag"
      expr: sla_compliance_flag
      comment: "Boolean flag indicating whether the workflow was completed within the SLA target hours."
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Boolean flag indicating whether the workflow was escalated due to non-response or delay."
    - name: "regulatory_requirement_flag"
      expr: regulatory_requirement_flag
      comment: "Boolean flag indicating whether the workflow has a regulatory compliance requirement."
    - name: "initiated_month"
      expr: DATE_TRUNC('month', initiated_date)
      comment: "Month the workflow was initiated for approval volume trending."
    - name: "outcome_month"
      expr: DATE_TRUNC('month', outcome_date)
      comment: "Month the workflow outcome was recorded for approval throughput trending."
  measures:
    - name: "total_approval_workflows"
      expr: COUNT(1)
      comment: "Total number of approval workflows initiated. Baseline metric for design review workload volume."
    - name: "completed_workflows"
      expr: COUNT(CASE WHEN workflow_status = 'Completed' THEN 1 END)
      comment: "Number of approval workflows that have been completed. Measures design review throughput."
    - name: "workflow_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN workflow_status = 'Completed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of approval workflows completed. Key process efficiency KPI for design governance."
    - name: "sla_compliant_workflows"
      expr: COUNT(CASE WHEN sla_compliance_flag = TRUE THEN 1 END)
      comment: "Number of workflows completed within SLA target hours. Measures design review process adherence to service commitments."
    - name: "sla_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sla_compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of approval workflows meeting SLA targets. Critical KPI for design review process performance and contractual compliance."
    - name: "escalated_workflows"
      expr: COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END)
      comment: "Number of workflows that were escalated. High escalation rates indicate approval bottlenecks and resource constraints."
    - name: "escalation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of workflows that required escalation. Measures approval process health and reviewer responsiveness."
    - name: "total_sla_actual_hours"
      expr: SUM(CAST(sla_actual_hours AS DOUBLE))
      comment: "Total actual hours consumed across all approval workflows. Informs resource capacity planning for design review teams."
    - name: "avg_sla_actual_hours"
      expr: AVG(CAST(sla_actual_hours AS DOUBLE))
      comment: "Average actual hours per approval workflow. Benchmarks review cycle time and identifies process improvement opportunities."
    - name: "overdue_workflows"
      expr: COUNT(CASE WHEN due_date < CURRENT_DATE AND workflow_status NOT IN ('Completed', 'Withdrawn') THEN 1 END)
      comment: "Number of approval workflows past their due date and not yet completed. Flags approval bottlenecks that risk design schedule delays."
    - name: "regulatory_workflows"
      expr: COUNT(CASE WHEN regulatory_requirement_flag = TRUE THEN 1 END)
      comment: "Number of workflows with regulatory compliance requirements. Tracks regulatory obligation fulfilment in the design approval process."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`design_technical_specification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Technical specification approval status, compliance, and lifecycle metrics. Tracks specification approval rates, HSE and client deliverable coverage, and supersession activity to govern design specification quality."
  source: "`vibe_construction_v1`.`design`.`technical_specification`"
  dimensions:
    - name: "discipline"
      expr: discipline
      comment: "Engineering discipline of the technical specification for cross-discipline coverage analysis."
    - name: "technical_specification_status"
      expr: technical_specification_status
      comment: "Current status of the specification (e.g. Approved, Under Review, Superseded, Draft)."
    - name: "specification_type"
      expr: specification_type
      comment: "Type of specification (e.g. Material, Workmanship, Performance) for categorised governance."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the specification (e.g. Approved, Pending, Rejected) for review pipeline tracking."
    - name: "is_client_deliverable"
      expr: is_client_deliverable
      comment: "Boolean flag indicating whether the specification is a contractual client deliverable."
    - name: "csi_division"
      expr: csi_division
      comment: "CSI MasterFormat division for industry-standard specification categorisation."
    - name: "author_organization"
      expr: author_organization
      comment: "Organisation that authored the specification for accountability and quality tracking."
    - name: "issue_date_month"
      expr: DATE_TRUNC('month', issue_date)
      comment: "Month of specification issue for deliverable cadence trending."
    - name: "effective_date_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the specification became effective for lifecycle analysis."
  measures:
    - name: "total_specifications"
      expr: COUNT(1)
      comment: "Total number of technical specifications. Baseline metric for design specification library volume."
    - name: "approved_specifications"
      expr: COUNT(CASE WHEN approval_status = 'Approved' THEN 1 END)
      comment: "Number of specifications that have been formally approved. Measures design specification readiness for construction."
    - name: "specification_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN approval_status = 'Approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of technical specifications approved. Key design quality KPI for project readiness assessment."
    - name: "client_deliverable_specifications"
      expr: COUNT(CASE WHEN is_client_deliverable = TRUE THEN 1 END)
      comment: "Number of specifications that are contractual client deliverables. Tracks delivery obligation fulfilment."
    - name: "superseded_specifications"
      expr: COUNT(CASE WHEN supersedes_specification_number IS NOT NULL THEN 1 END)
      comment: "Number of specifications that supersede a prior version. Indicates specification churn and design change frequency."
    - name: "specifications_with_hse_requirements"
      expr: COUNT(CASE WHEN hse_requirements IS NOT NULL AND hse_requirements != '' THEN 1 END)
      comment: "Number of specifications containing HSE requirements. Measures HSE integration into design specifications for safety governance."
    - name: "distinct_csi_divisions_covered"
      expr: COUNT(DISTINCT csi_division)
      comment: "Number of distinct CSI MasterFormat divisions covered by specifications. Measures breadth of design specification coverage."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`design_transmittal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Design transmittal volume, acknowledgment compliance, and distribution performance metrics. Tracks transmittal issuance rates, acknowledgment SLA adherence, and overdue transmittals to govern design information exchange."
  source: "`vibe_construction_v1`.`design`.`transmittal`"
  dimensions:
    - name: "discipline"
      expr: discipline
      comment: "Engineering discipline associated with the transmittal for cross-discipline distribution analysis."
    - name: "transmittal_status"
      expr: transmittal_status
      comment: "Current status of the transmittal (e.g. Issued, Acknowledged, Overdue, Cancelled)."
    - name: "purpose_of_issue"
      expr: purpose_of_issue
      comment: "Purpose for which the transmittal was issued (e.g. For Approval, For Information, For Construction)."
    - name: "delivery_method"
      expr: delivery_method
      comment: "Method used to deliver the transmittal (e.g. Email, Portal, Courier) for distribution channel analysis."
    - name: "priority"
      expr: priority
      comment: "Priority level of the transmittal (e.g. Urgent, High, Normal) for workload triage."
    - name: "acknowledgement_required_flag"
      expr: acknowledgement_required_flag
      comment: "Boolean flag indicating whether formal acknowledgment is required from the recipient."
    - name: "acknowledgement_status"
      expr: acknowledgement_status
      comment: "Current acknowledgment status (e.g. Acknowledged, Pending, Overdue) for compliance tracking."
    - name: "confidentiality_level"
      expr: confidentiality_level
      comment: "Confidentiality classification of the transmittal for information security governance."
    - name: "recipient_organization"
      expr: recipient_organization
      comment: "Organisation receiving the transmittal for stakeholder distribution analysis."
    - name: "issue_date_month"
      expr: DATE_TRUNC('month', issue_date)
      comment: "Month of transmittal issue for distribution volume trending."
  measures:
    - name: "total_transmittals"
      expr: COUNT(1)
      comment: "Total number of transmittals issued. Baseline metric for design information exchange volume."
    - name: "acknowledged_transmittals"
      expr: COUNT(CASE WHEN acknowledgement_status = 'Acknowledged' THEN 1 END)
      comment: "Number of transmittals that have been formally acknowledged by recipients. Measures information receipt confirmation compliance."
    - name: "acknowledgment_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN acknowledgement_required_flag = TRUE AND acknowledgement_status = 'Acknowledged' THEN 1 END) / NULLIF(COUNT(CASE WHEN acknowledgement_required_flag = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of transmittals requiring acknowledgment that have been acknowledged. Key contractual compliance KPI for design information management."
    - name: "overdue_transmittals"
      expr: COUNT(CASE WHEN due_date < CURRENT_DATE AND transmittal_status NOT IN ('Acknowledged', 'Closed') THEN 1 END)
      comment: "Number of transmittals past their due date without acknowledgment or closure. Flags information exchange SLA breaches and contractual risk."
    - name: "pending_acknowledgment_transmittals"
      expr: COUNT(CASE WHEN acknowledgement_required_flag = TRUE AND acknowledgement_status != 'Acknowledged' THEN 1 END)
      comment: "Number of transmittals requiring acknowledgment that are still pending. Measures outstanding information receipt obligations."
    - name: "distinct_recipient_organizations"
      expr: COUNT(DISTINCT recipient_organization)
      comment: "Number of distinct organisations receiving transmittals. Measures breadth of design information distribution network."
$$;