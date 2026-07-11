-- Metric views for domain: design | Business: Construction | Version: 2 | Generated on: 2026-07-10 12:14:04

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`design_change_notice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks design change notices across projects — volume, cost impact, and schedule impact to support change control governance and project cost management decisions."
  source: "`vibe_construction_v1`.`design`.`change_notice`"
  dimensions:
    - name: "project_id"
      expr: construction_project_id
      comment: "Construction project the change notice belongs to, enabling per-project change analysis."
    - name: "change_notice_status"
      expr: change_notice_status
      comment: "Current workflow status of the change notice (e.g. Draft, Approved, Rejected) for pipeline analysis."
    - name: "change_notice_type"
      expr: change_notice_type
      comment: "Category of change (e.g. Design, Scope, Regulatory) to identify root causes of change."
    - name: "discipline"
      expr: discipline
      comment: "Engineering discipline originating the change notice (e.g. Civil, Structural, MEP)."
    - name: "priority"
      expr: priority
      comment: "Priority level of the change notice to focus management attention on critical changes."
    - name: "cost_impact_flag"
      expr: cost_impact_flag
      comment: "Boolean flag indicating whether the change notice carries a cost impact."
    - name: "schedule_impact_flag"
      expr: schedule_impact_flag
      comment: "Boolean flag indicating whether the change notice carries a schedule impact."
    - name: "date_raised_month"
      expr: DATE_TRUNC('MONTH', date_raised)
      comment: "Month the change notice was raised, for trend analysis over time."
    - name: "originating_cause"
      expr: originating_cause
      comment: "Root cause category of the change (e.g. Client Request, Design Error, Regulatory) for Pareto analysis."
  measures:
    - name: "total_change_notices"
      expr: COUNT(1)
      comment: "Total number of change notices raised. Baseline volume KPI for change control governance."
    - name: "total_estimated_cost_impact"
      expr: SUM(CAST(estimated_cost_impact_amount AS DOUBLE))
      comment: "Sum of estimated cost impacts across all change notices. Directly informs project budget exposure and contingency management."
    - name: "total_actual_cost_impact"
      expr: SUM(CAST(actual_cost_impact_amount AS DOUBLE))
      comment: "Sum of realized cost impacts from approved change notices. Measures actual budget deviation driven by design changes."
    - name: "avg_estimated_cost_impact"
      expr: AVG(CAST(estimated_cost_impact_amount AS DOUBLE))
      comment: "Average estimated cost impact per change notice. Helps benchmark change complexity and cost exposure per event."
    - name: "cost_impact_change_notices"
      expr: COUNT(CASE WHEN cost_impact_flag = TRUE THEN 1 END)
      comment: "Number of change notices with a cost impact. Drives prioritization of change review resources."
    - name: "schedule_impact_change_notices"
      expr: COUNT(CASE WHEN schedule_impact_flag = TRUE THEN 1 END)
      comment: "Number of change notices with a schedule impact. Informs programme risk management and delay mitigation."
    - name: "approved_change_notices"
      expr: COUNT(CASE WHEN change_notice_status = 'Approved' THEN 1 END)
      comment: "Count of approved change notices. Measures the volume of sanctioned scope changes affecting contract and budget."
    - name: "rejected_change_notices"
      expr: COUNT(CASE WHEN change_notice_status = 'Rejected' THEN 1 END)
      comment: "Count of rejected change notices. High rejection rates may signal poor change quality or scope creep attempts."
    - name: "cost_variance_vs_estimate"
      expr: SUM(CAST(actual_cost_impact_amount AS DOUBLE) - CAST(estimated_cost_impact_amount AS DOUBLE))
      comment: "Aggregate variance between actual and estimated cost impacts. Negative values indicate cost overruns vs. estimates, a key project controls KPI."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`design_rfi`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Measures RFI (Request for Information) performance — volume, cost impact, and closure efficiency — to manage design information flow and contractual risk."
  source: "`vibe_construction_v1`.`design`.`rfi`"
  dimensions:
    - name: "project_id"
      expr: construction_project_id
      comment: "Construction project the RFI belongs to, enabling per-project RFI performance benchmarking."
    - name: "rfi_status"
      expr: rfi_status
      comment: "Current status of the RFI (e.g. Open, Closed, Pending) for pipeline and backlog analysis."
    - name: "discipline"
      expr: discipline
      comment: "Engineering discipline that raised the RFI, identifying which disciplines generate the most information gaps."
    - name: "priority"
      expr: priority
      comment: "Priority level of the RFI to focus resolution effort on critical information needs."
    - name: "cost_impact_flag"
      expr: cost_impact_flag
      comment: "Boolean flag indicating whether the RFI has a cost impact, for financial risk triage."
    - name: "schedule_impact_flag"
      expr: schedule_impact_flag
      comment: "Boolean flag indicating whether the RFI has a schedule impact, for programme risk triage."
    - name: "date_raised_month"
      expr: DATE_TRUNC('MONTH', date_raised)
      comment: "Month the RFI was raised, for trend and velocity analysis."
  measures:
    - name: "total_rfis"
      expr: COUNT(1)
      comment: "Total number of RFIs raised. Baseline volume KPI for design information management."
    - name: "open_rfis"
      expr: COUNT(CASE WHEN rfi_status = 'Open' THEN 1 END)
      comment: "Number of currently open RFIs. High open counts signal design information bottlenecks that can delay construction."
    - name: "closed_rfis"
      expr: COUNT(CASE WHEN rfi_status = 'Closed' THEN 1 END)
      comment: "Number of closed RFIs. Measures throughput of the RFI resolution process."
    - name: "rfi_closure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN rfi_status = 'Closed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of RFIs that have been closed. A key design management KPI — low closure rates indicate unresolved design queries blocking construction."
    - name: "total_cost_impact"
      expr: SUM(CAST(cost_impact_amount AS DOUBLE))
      comment: "Total cost impact value across all RFIs. Quantifies the financial exposure from unresolved or resolved design queries."
    - name: "avg_cost_impact_per_rfi"
      expr: AVG(CAST(cost_impact_amount AS DOUBLE))
      comment: "Average cost impact per RFI. Benchmarks the financial weight of individual design information gaps."
    - name: "cost_impacting_rfis"
      expr: COUNT(CASE WHEN cost_impact_flag = TRUE THEN 1 END)
      comment: "Number of RFIs with a cost impact. Drives prioritization of RFI resolution to protect project budget."
    - name: "schedule_impacting_rfis"
      expr: COUNT(CASE WHEN schedule_impact_flag = TRUE THEN 1 END)
      comment: "Number of RFIs with a schedule impact. Informs programme risk management and critical path protection."
    - name: "distinct_projects_with_rfis"
      expr: COUNT(DISTINCT construction_project_id)
      comment: "Number of distinct projects with active RFIs. Measures breadth of design information risk across the portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`design_submittal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks design submittal performance — approval rates, cost and schedule impacts, and review cycle efficiency — to manage contractor deliverable compliance."
  source: "`vibe_construction_v1`.`design`.`design_submittal`"
  dimensions:
    - name: "project_id"
      expr: construction_project_id
      comment: "Construction project the submittal belongs to, for per-project submittal compliance tracking."
    - name: "submittal_status"
      expr: submittal_status
      comment: "Current status of the submittal (e.g. Approved, Rejected, Under Review) for pipeline analysis."
    - name: "submittal_type"
      expr: submittal_type
      comment: "Type of submittal (e.g. Shop Drawing, Material Sample, Method Statement) for category-level performance analysis."
    - name: "discipline"
      expr: discipline
      comment: "Engineering discipline of the submittal, identifying which disciplines have the most review bottlenecks."
    - name: "approval_disposition"
      expr: approval_disposition
      comment: "Reviewer disposition (e.g. Approved, Approved with Comments, Rejected) for quality analysis of first-pass approval rates."
    - name: "cost_impact_flag"
      expr: cost_impact_flag
      comment: "Boolean flag indicating whether the submittal has a cost impact."
    - name: "schedule_impact_flag"
      expr: schedule_impact_flag
      comment: "Boolean flag indicating whether the submittal has a schedule impact."
    - name: "required_submission_month"
      expr: DATE_TRUNC('MONTH', required_submission_date)
      comment: "Month the submittal was contractually required, for on-time delivery trend analysis."
  measures:
    - name: "total_submittals"
      expr: COUNT(1)
      comment: "Total number of design submittals. Baseline volume KPI for submittal register management."
    - name: "approved_submittals"
      expr: COUNT(CASE WHEN submittal_status = 'Approved' THEN 1 END)
      comment: "Number of approved submittals. Measures throughput of the design approval process."
    - name: "rejected_submittals"
      expr: COUNT(CASE WHEN submittal_status = 'Rejected' THEN 1 END)
      comment: "Number of rejected submittals. High rejection rates indicate quality issues in contractor design deliverables."
    - name: "first_pass_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN approval_disposition = 'Approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of submittals approved on first submission without comments or rejection. A key quality KPI — low rates drive rework cost and schedule delay."
    - name: "total_estimated_cost_impact"
      expr: SUM(CAST(estimated_cost_impact_amount AS DOUBLE))
      comment: "Total estimated cost impact across submittals with cost implications. Quantifies financial exposure from submittal-driven changes."
    - name: "cost_impacting_submittals"
      expr: COUNT(CASE WHEN cost_impact_flag = TRUE THEN 1 END)
      comment: "Number of submittals with a cost impact. Drives prioritization of review resources to protect project budget."
    - name: "schedule_impacting_submittals"
      expr: COUNT(CASE WHEN schedule_impact_flag = TRUE THEN 1 END)
      comment: "Number of submittals with a schedule impact. Informs programme risk management."
    - name: "on_time_submission_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN actual_submission_date <= required_submission_date THEN 1 END) / NULLIF(COUNT(CASE WHEN actual_submission_date IS NOT NULL AND required_submission_date IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of submittals delivered on or before the contractually required date. Measures contractor schedule compliance for design deliverables."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`design_clash_detection_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Monitors BIM clash detection performance — clash severity, resolution progress, and coordination quality — to manage design coordination risk and reduce rework."
  source: "`vibe_construction_v1`.`design`.`clash_detection_run`"
  dimensions:
    - name: "project_id"
      expr: construction_project_id
      comment: "Construction project the clash detection run belongs to, for per-project BIM coordination performance."
    - name: "run_status"
      expr: run_status
      comment: "Status of the clash detection run (e.g. Complete, In Progress) for pipeline monitoring."
    - name: "discipline_pair"
      expr: discipline_pair
      comment: "Pair of disciplines compared in the clash run (e.g. Structural vs MEP) to identify highest-risk coordination interfaces."
    - name: "primary_discipline"
      expr: primary_discipline
      comment: "Primary discipline in the clash detection run for discipline-level coordination analysis."
    - name: "building_zone"
      expr: building_zone
      comment: "Building zone where clashes were detected, for spatial hotspot analysis."
    - name: "baseline_run_flag"
      expr: baseline_run_flag
      comment: "Indicates whether this is a baseline clash detection run, for trend comparison against baseline."
    - name: "run_date_month"
      expr: DATE_TRUNC('MONTH', run_date)
      comment: "Month of the clash detection run, for trend analysis of coordination progress over time."
    - name: "clash_free_certification_flag"
      expr: clash_free_certification_flag
      comment: "Indicates whether the run achieved clash-free certification, a key BIM coordination milestone."
  measures:
    - name: "total_clash_runs"
      expr: COUNT(1)
      comment: "Total number of clash detection runs executed. Baseline volume KPI for BIM coordination activity."
    - name: "clash_free_certified_runs"
      expr: COUNT(CASE WHEN clash_free_certification_flag = TRUE THEN 1 END)
      comment: "Number of runs achieving clash-free certification. Measures BIM coordination maturity and readiness for construction."
    - name: "clash_free_certification_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN clash_free_certification_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of clash detection runs achieving clash-free certification. A strategic BIM KPI — low rates indicate unresolved coordination issues that will drive field rework."
    - name: "avg_clash_tolerance_mm"
      expr: AVG(CAST(clash_tolerance_mm AS DOUBLE))
      comment: "Average clash tolerance threshold used across runs. Tighter tolerances indicate higher coordination quality standards being enforced."
    - name: "total_clash_runs_with_certification"
      expr: COUNT(CASE WHEN certification_date IS NOT NULL THEN 1 END)
      comment: "Number of clash runs that have a formal certification date, indicating completed coordination sign-off."
    - name: "distinct_projects_coordinated"
      expr: COUNT(DISTINCT construction_project_id)
      comment: "Number of distinct projects with active clash detection runs. Measures breadth of BIM coordination programme."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`design_drawing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks drawing register health — volume, revision activity, and deliverable status — to manage design documentation compliance and information release."
  source: "`vibe_construction_v1`.`design`.`drawing`"
  dimensions:
    - name: "project_id"
      expr: construction_project_id
      comment: "Construction project the drawing belongs to, for per-project drawing register analysis."
    - name: "drawing_status"
      expr: drawing_status
      comment: "Current status of the drawing (e.g. Issued for Construction, Under Review, Superseded) for register health monitoring."
    - name: "drawing_type"
      expr: drawing_type
      comment: "Type of drawing (e.g. General Arrangement, Detail, Schematic) for category-level analysis."
    - name: "discipline"
      expr: discipline
      comment: "Engineering discipline of the drawing, for discipline-level deliverable tracking."
    - name: "is_client_deliverable"
      expr: is_client_deliverable
      comment: "Indicates whether the drawing is a contractual client deliverable, for compliance tracking."
    - name: "is_controlled_document"
      expr: is_controlled_document
      comment: "Indicates whether the drawing is under document control, for governance monitoring."
    - name: "issue_purpose"
      expr: issue_purpose
      comment: "Purpose of issue (e.g. For Construction, For Review, For Approval) to track design maturity."
    - name: "revision_date_month"
      expr: DATE_TRUNC('MONTH', revision_date)
      comment: "Month of the latest drawing revision, for design change velocity analysis."
  measures:
    - name: "total_drawings"
      expr: COUNT(1)
      comment: "Total number of drawings in the register. Baseline volume KPI for design documentation scope."
    - name: "issued_for_construction_drawings"
      expr: COUNT(CASE WHEN drawing_status = 'Issued for Construction' THEN 1 END)
      comment: "Number of drawings issued for construction. Measures design completion progress and construction readiness."
    - name: "client_deliverable_drawings"
      expr: COUNT(CASE WHEN is_client_deliverable = TRUE THEN 1 END)
      comment: "Number of drawings that are contractual client deliverables. Tracks compliance with contractual documentation obligations."
    - name: "controlled_document_drawings"
      expr: COUNT(CASE WHEN is_controlled_document = TRUE THEN 1 END)
      comment: "Number of drawings under formal document control. Measures governance compliance of the drawing register."
    - name: "avg_file_size_mb"
      expr: AVG(CAST(file_size_mb AS DOUBLE))
      comment: "Average drawing file size in MB. Informs storage infrastructure planning and BIM model management."
    - name: "total_file_size_mb"
      expr: SUM(CAST(file_size_mb AS DOUBLE))
      comment: "Total storage consumed by drawings in MB. Drives infrastructure capacity planning for document management systems."
    - name: "distinct_disciplines"
      expr: COUNT(DISTINCT discipline)
      comment: "Number of distinct engineering disciplines represented in the drawing register. Measures design scope breadth."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`design_value_engineering_proposal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Measures value engineering performance — savings identified, approved, and realized — to quantify the financial return on design optimization efforts."
  source: "`vibe_construction_v1`.`design`.`value_engineering_proposal`"
  dimensions:
    - name: "project_id"
      expr: construction_project_id
      comment: "Construction project the VE proposal belongs to, for per-project value engineering performance."
    - name: "proposal_status"
      expr: proposal_status
      comment: "Current status of the VE proposal (e.g. Submitted, Approved, Rejected, Implemented) for pipeline analysis."
    - name: "originator_discipline"
      expr: originator_discipline
      comment: "Engineering discipline that originated the VE proposal, identifying which disciplines generate the most value."
    - name: "client_decision"
      expr: client_decision
      comment: "Client decision on the VE proposal (e.g. Accepted, Rejected, Deferred) for client engagement analysis."
    - name: "implementation_status"
      expr: implementation_status
      comment: "Implementation status of approved VE proposals, tracking conversion from approval to realized savings."
    - name: "environmental_impact_flag"
      expr: environmental_impact_flag
      comment: "Indicates whether the VE proposal has an environmental impact, for sustainability-linked value analysis."
    - name: "safety_impact_flag"
      expr: safety_impact_flag
      comment: "Indicates whether the VE proposal has a safety impact, for risk-adjusted value assessment."
    - name: "proposal_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month the VE proposal was created, for trend analysis of value engineering activity."
  measures:
    - name: "total_ve_proposals"
      expr: COUNT(1)
      comment: "Total number of value engineering proposals submitted. Baseline volume KPI for VE programme activity."
    - name: "total_estimated_savings"
      expr: SUM(CAST(estimated_cost_saving AS DOUBLE))
      comment: "Total estimated cost savings across all VE proposals. Quantifies the potential financial value of the VE programme pipeline."
    - name: "total_implemented_savings"
      expr: SUM(CAST(implemented_saving_value AS DOUBLE))
      comment: "Total realized cost savings from implemented VE proposals. Measures the actual financial return delivered by the VE programme — a direct P&L impact KPI."
    - name: "avg_estimated_saving_per_proposal"
      expr: AVG(CAST(estimated_cost_saving AS DOUBLE))
      comment: "Average estimated saving per VE proposal. Benchmarks the quality and ambition of individual VE ideas."
    - name: "savings_realization_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(implemented_saving_value AS DOUBLE)) / NULLIF(SUM(CAST(estimated_cost_saving AS DOUBLE)), 0), 2)
      comment: "Percentage of estimated savings that have been realized through implementation. Measures VE programme execution effectiveness — low rates indicate approval-to-implementation conversion failures."
    - name: "client_accepted_proposals"
      expr: COUNT(CASE WHEN client_decision = 'Accepted' THEN 1 END)
      comment: "Number of VE proposals accepted by the client. Measures client engagement and receptiveness to design optimization."
    - name: "client_acceptance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN client_decision = 'Accepted' THEN 1 END) / NULLIF(COUNT(CASE WHEN client_decision IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of decided VE proposals accepted by the client. A strategic KPI for client relationship and design quality management."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`design_handover_package`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks project handover package completeness and timeliness — critical for contractual close-out, DLP commencement, and client acceptance milestones."
  source: "`vibe_construction_v1`.`design`.`handover_package`"
  dimensions:
    - name: "project_id"
      expr: construction_project_id
      comment: "Construction project the handover package belongs to, for per-project close-out performance."
    - name: "package_status"
      expr: package_status
      comment: "Current status of the handover package (e.g. In Preparation, Submitted, Accepted) for close-out pipeline monitoring."
    - name: "package_type"
      expr: package_type
      comment: "Type of handover package (e.g. As-Built, O&M, Commissioning) for category-level completeness analysis."
    - name: "client_acceptance_status"
      expr: client_acceptance_status
      comment: "Client acceptance status of the handover package, measuring contractual close-out progress."
    - name: "iso_19650_compliance_flag"
      expr: iso_19650_compliance_flag
      comment: "Indicates whether the package meets ISO 19650 information management standards."
    - name: "legal_hold_flag"
      expr: legal_hold_flag
      comment: "Indicates whether the package is under legal hold, flagging packages with legal risk."
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_date)
      comment: "Month the handover package was submitted, for close-out velocity trend analysis."
  measures:
    - name: "total_handover_packages"
      expr: COUNT(1)
      comment: "Total number of handover packages. Baseline volume KPI for project close-out scope."
    - name: "client_accepted_packages"
      expr: COUNT(CASE WHEN client_acceptance_status = 'Accepted' THEN 1 END)
      comment: "Number of handover packages formally accepted by the client. Measures contractual close-out progress and DLP commencement readiness."
    - name: "client_acceptance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN client_acceptance_status = 'Accepted' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of handover packages accepted by the client. A key project close-out KPI — low rates delay final payment and DLP start."
    - name: "avg_completeness_pct"
      expr: AVG(CAST(completeness_percentage AS DOUBLE))
      comment: "Average completeness percentage across handover packages. Measures overall readiness of the handover programme for client submission."
    - name: "iso_compliant_packages"
      expr: COUNT(CASE WHEN iso_19650_compliance_flag = TRUE THEN 1 END)
      comment: "Number of handover packages meeting ISO 19650 information management standards. Measures BIM/information governance compliance."
    - name: "on_time_submission_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN submission_date <= planned_submission_date THEN 1 END) / NULLIF(COUNT(CASE WHEN submission_date IS NOT NULL AND planned_submission_date IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of handover packages submitted on or before the planned date. Measures close-out schedule compliance."
    - name: "packages_on_legal_hold"
      expr: COUNT(CASE WHEN legal_hold_flag = TRUE THEN 1 END)
      comment: "Number of handover packages under legal hold. Flags legal risk exposure in the close-out programme."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`design_workflow_approval`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Measures design workflow approval performance — SLA compliance, escalation rates, and cycle time — to manage design governance efficiency and bottleneck identification."
  source: "`vibe_construction_v1`.`design`.`workflow_approval`"
  dimensions:
    - name: "project_id"
      expr: construction_project_id
      comment: "Construction project the workflow approval belongs to, for per-project governance performance."
    - name: "workflow_status"
      expr: workflow_status
      comment: "Current status of the workflow approval (e.g. Pending, Approved, Rejected, Escalated) for pipeline analysis."
    - name: "workflow_type"
      expr: workflow_type
      comment: "Type of approval workflow (e.g. Drawing Review, Submittal Approval, Change Notice) for category-level SLA analysis."
    - name: "overall_outcome"
      expr: overall_outcome
      comment: "Final outcome of the workflow (e.g. Approved, Rejected, Withdrawn) for quality analysis."
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Indicates whether the workflow was escalated, for bottleneck and governance risk analysis."
    - name: "sla_compliance_flag"
      expr: sla_compliance_flag
      comment: "Indicates whether the workflow was completed within SLA, for service level performance tracking."
    - name: "approval_authority_level"
      expr: approval_authority_level
      comment: "Authority level required for approval, for delegation of authority compliance analysis."
    - name: "initiated_month"
      expr: DATE_TRUNC('MONTH', initiated_date)
      comment: "Month the workflow was initiated, for approval cycle trend analysis."
  measures:
    - name: "total_workflow_approvals"
      expr: COUNT(1)
      comment: "Total number of design workflow approvals. Baseline volume KPI for design governance activity."
    - name: "sla_compliant_approvals"
      expr: COUNT(CASE WHEN sla_compliance_flag = TRUE THEN 1 END)
      comment: "Number of workflow approvals completed within SLA. Measures design governance efficiency."
    - name: "sla_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sla_compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of workflow approvals completed within SLA. A key design management KPI — low SLA compliance delays design release and construction start."
    - name: "escalated_approvals"
      expr: COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END)
      comment: "Number of workflow approvals that required escalation. High escalation rates indicate approval bottlenecks or authority delegation gaps."
    - name: "escalation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of workflow approvals that were escalated. Measures governance friction and management overhead in the design approval process."
    - name: "avg_sla_actual_hours"
      expr: AVG(CAST(sla_actual_hours AS DOUBLE))
      comment: "Average actual hours taken to complete workflow approvals. Benchmarks approval cycle time against SLA targets."
    - name: "approved_workflows"
      expr: COUNT(CASE WHEN overall_outcome = 'Approved' THEN 1 END)
      comment: "Number of workflows with an approved outcome. Measures design approval throughput."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`design_change_impact`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quantifies the financial impact of design changes at the asset and project level — enabling cost exposure analysis and change control prioritization."
  source: "`vibe_construction_v1`.`design`.`change_impact`"
  dimensions:
    - name: "project_id"
      expr: construction_project_id
      comment: "Construction project the change impact belongs to, for per-project cost exposure analysis."
    - name: "change_notice_id"
      expr: change_notice_id
      comment: "Change notice driving the impact, for traceability from cost impact back to the originating design change."
    - name: "asset_id"
      expr: asset_id
      comment: "Asset affected by the design change, for asset-level cost impact analysis."
  measures:
    - name: "total_change_impacts"
      expr: COUNT(1)
      comment: "Total number of change impact records. Measures the breadth of design change consequences across assets and projects."
    - name: "total_cost_impact"
      expr: SUM(CAST(cost_impact_amount AS DOUBLE))
      comment: "Total financial cost impact from design changes. A direct project cost control KPI — drives contingency management and change order valuation."
    - name: "avg_cost_impact_per_change"
      expr: AVG(CAST(cost_impact_amount AS DOUBLE))
      comment: "Average cost impact per change impact record. Benchmarks the financial weight of individual design change consequences."
    - name: "distinct_projects_impacted"
      expr: COUNT(DISTINCT construction_project_id)
      comment: "Number of distinct projects with recorded change impacts. Measures portfolio-wide exposure to design change costs."
    - name: "distinct_change_notices_with_impact"
      expr: COUNT(DISTINCT change_notice_id)
      comment: "Number of distinct change notices that have generated cost impacts. Measures the proportion of changes with financial consequences."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`design_document_register`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks document register health — controlled document compliance, client deliverable status, and review cycle performance — for ISO 19650 and contractual documentation governance."
  source: "`vibe_construction_v1`.`design`.`document_register`"
  dimensions:
    - name: "project_id"
      expr: construction_project_id
      comment: "Construction project the document belongs to, for per-project document register analysis."
    - name: "document_register_status"
      expr: document_register_status
      comment: "Current status of the document (e.g. Issued, Under Review, Superseded) for register health monitoring."
    - name: "document_type"
      expr: document_type
      comment: "Type of document (e.g. Drawing, Specification, Report) for category-level register analysis."
    - name: "discipline"
      expr: discipline
      comment: "Engineering discipline of the document, for discipline-level documentation compliance tracking."
    - name: "is_client_deliverable"
      expr: is_client_deliverable
      comment: "Indicates whether the document is a contractual client deliverable, for compliance tracking."
    - name: "is_controlled_document"
      expr: is_controlled_document
      comment: "Indicates whether the document is under formal document control, for governance monitoring."
    - name: "issue_date_month"
      expr: DATE_TRUNC('MONTH', issue_date)
      comment: "Month the document was issued, for documentation release velocity trend analysis."
  measures:
    - name: "total_documents"
      expr: COUNT(1)
      comment: "Total number of documents in the register. Baseline volume KPI for design documentation scope."
    - name: "controlled_documents"
      expr: COUNT(CASE WHEN is_controlled_document = TRUE THEN 1 END)
      comment: "Number of documents under formal document control. Measures governance compliance of the document register."
    - name: "controlled_document_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_controlled_document = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of documents under formal document control. A governance KPI — low rates indicate document management compliance risk."
    - name: "client_deliverable_documents"
      expr: COUNT(CASE WHEN is_client_deliverable = TRUE THEN 1 END)
      comment: "Number of documents that are contractual client deliverables. Tracks compliance with contractual documentation obligations."
    - name: "total_file_size_mb"
      expr: SUM(CAST(file_size_mb AS DOUBLE))
      comment: "Total storage consumed by registered documents in MB. Drives infrastructure capacity planning for document management systems."
    - name: "avg_file_size_mb"
      expr: AVG(CAST(file_size_mb AS DOUBLE))
      comment: "Average document file size in MB. Informs storage and BIM infrastructure planning."
    - name: "distinct_disciplines"
      expr: COUNT(DISTINCT discipline)
      comment: "Number of distinct engineering disciplines represented in the document register. Measures design scope breadth."
$$;