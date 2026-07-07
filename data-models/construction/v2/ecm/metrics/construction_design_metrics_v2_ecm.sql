-- Metric views for domain: design | Business: Construction | Version: 2 | Generated on: 2026-06-28 00:14:33

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`design_bim_model`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks BIM model register health, ISO 19650 compliance, and model quality metrics. Enables BIM management to monitor model maturity, clash status, and information delivery performance."
  source: "`vibe_construction_v1`.`design`.`bim_model`"
  dimensions:
    - name: "model_status"
      expr: model_status
      comment: "Current status of the BIM model (in development, issued, superseded, archived)."
    - name: "model_type"
      expr: model_type
      comment: "Type of BIM model (architectural, structural, MEP, federated, etc.) for category analysis."
    - name: "discipline"
      expr: discipline
      comment: "Engineering discipline of the model for workload attribution."
    - name: "lod_classification"
      expr: lod_classification
      comment: "Level of Development (LOD) classification of the model, measuring information maturity."
    - name: "iso_19650_compliance_flag"
      expr: iso_19650_compliance_flag
      comment: "Whether the model complies with ISO 19650 BIM information management standards."
    - name: "clash_detection_status"
      expr: clash_detection_status
      comment: "Current clash detection status of the model for coordination quality monitoring."
    - name: "lifecycle_stage"
      expr: lifecycle_stage
      comment: "Project lifecycle stage of the model (design, construction, as-built, operations)."
    - name: "issue_date_month"
      expr: DATE_TRUNC('MONTH', issue_date)
      comment: "Month the model was issued for trend analysis of BIM delivery velocity."
  measures:
    - name: "total_bim_models"
      expr: COUNT(1)
      comment: "Total number of BIM models in the register. Baseline measure of BIM programme scope."
    - name: "iso_19650_compliant_models"
      expr: COUNT(CASE WHEN iso_19650_compliance_flag = TRUE THEN 1 END)
      comment: "Number of BIM models compliant with ISO 19650. Measures BIM information management governance."
    - name: "iso_19650_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN iso_19650_compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of BIM models meeting ISO 19650 compliance. A BIM governance KPI for asset information delivery."
    - name: "total_file_size_mb"
      expr: SUM(CAST(file_size_mb AS DOUBLE))
      comment: "Total file size of all BIM models in MB. Informs BIM infrastructure and storage planning."
    - name: "avg_file_size_mb"
      expr: AVG(CAST(file_size_mb AS DOUBLE))
      comment: "Average BIM model file size in MB. Benchmarks model complexity and performance requirements."
    - name: "avg_origin_elevation_m"
      expr: AVG(CAST(origin_elevation_m AS DOUBLE))
      comment: "Average model origin elevation in metres. Used for spatial coordination and model federation quality checks."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`design_change_impact`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Measures the financial and schedule impact of design changes, enabling leadership to quantify change exposure, prioritise mitigation actions, and manage contract variation risk."
  source: "`vibe_construction_v1`.`design`.`change_impact`"
  dimensions:
    - name: "change_impact_status"
      expr: change_impact_status
      comment: "Current status of the change impact assessment (open, mitigated, closed)."
    - name: "impact_category"
      expr: impact_category
      comment: "Category of impact (cost, schedule, scope, quality) for multi-dimensional change analysis."
    - name: "impact_severity"
      expr: impact_severity
      comment: "Severity of the impact (critical, major, minor) for prioritisation."
    - name: "impact_type"
      expr: impact_type
      comment: "Type of impact for root cause and trend analysis."
    - name: "affected_discipline"
      expr: affected_discipline
      comment: "Engineering discipline affected by the change, for workload and risk attribution."
    - name: "disposition"
      expr: disposition
      comment: "Disposition of the impact assessment (accepted, rejected, under review)."
    - name: "assessed_date_month"
      expr: DATE_TRUNC('MONTH', assessed_date)
      comment: "Month the impact was assessed for trend analysis of change exposure over time."
  measures:
    - name: "total_change_impacts"
      expr: COUNT(1)
      comment: "Total number of change impact assessments. Measures the volume of design change exposure."
    - name: "total_cost_impact"
      expr: SUM(CAST(cost_impact AS DOUBLE))
      comment: "Total cost impact across all change impact assessments. Key input for contract variation and contingency management."
    - name: "total_cost_impact_amount"
      expr: SUM(CAST(cost_impact_amount AS DOUBLE))
      comment: "Total cost impact amount from change assessments. Measures aggregate financial exposure from design changes."
    - name: "avg_cost_impact_amount"
      expr: AVG(CAST(cost_impact_amount AS DOUBLE))
      comment: "Average cost impact per change assessment. Benchmarks the financial weight of individual design changes."
    - name: "critical_severity_impacts"
      expr: COUNT(CASE WHEN impact_severity = 'Critical' THEN 1 END)
      comment: "Number of critical severity change impacts. A priority escalation metric for project leadership."
    - name: "open_change_impacts"
      expr: COUNT(CASE WHEN change_impact_status = 'Open' THEN 1 END)
      comment: "Number of unresolved change impacts. Open impacts represent unmitigated project risk."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`design_change_notice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Monitors design change notices for volume, cost and schedule impact, and approval cycle performance. Critical for change control governance and contract variation management."
  source: "`vibe_construction_v1`.`design`.`change_notice`"
  dimensions:
    - name: "change_notice_status"
      expr: change_notice_status
      comment: "Lifecycle status of the change notice (draft, issued, approved, rejected) for pipeline tracking."
    - name: "change_notice_type"
      expr: change_notice_type
      comment: "Category of change (design error, client request, regulatory, etc.) to identify root causes."
    - name: "discipline"
      expr: discipline
      comment: "Engineering discipline originating the change, for workload and impact attribution."
    - name: "cost_impact_flag"
      expr: cost_impact_flag
      comment: "Whether the change notice carries a cost impact, for financial exposure segmentation."
    - name: "schedule_impact_flag"
      expr: schedule_impact_flag
      comment: "Whether the change notice carries a schedule impact, for delay risk segmentation."
    - name: "client_approval_required_flag"
      expr: client_approval_required_flag
      comment: "Whether client approval is required, to track governance compliance."
    - name: "date_raised_month"
      expr: DATE_TRUNC('MONTH', date_raised)
      comment: "Month the change notice was raised, for trend and velocity analysis."
    - name: "originating_cause"
      expr: originating_cause
      comment: "Root cause category of the change, enabling systemic issue identification."
  measures:
    - name: "total_change_notices"
      expr: COUNT(1)
      comment: "Total number of design change notices. High volumes indicate design instability or scope creep."
    - name: "approved_change_notices"
      expr: COUNT(CASE WHEN change_notice_status = 'Approved' THEN 1 END)
      comment: "Number of approved change notices, representing confirmed design changes entering implementation."
    - name: "rejected_change_notices"
      expr: COUNT(CASE WHEN change_notice_status = 'Rejected' THEN 1 END)
      comment: "Number of rejected change notices. High rejection rates may indicate poor change quality or misaligned scope."
    - name: "approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN change_notice_status = 'Approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of change notices approved. Informs change control effectiveness and client alignment."
    - name: "total_estimated_cost_impact"
      expr: SUM(CAST(estimated_cost_impact_amount AS DOUBLE))
      comment: "Total estimated cost impact across all change notices. Key input for contract variation forecasting and contingency management."
    - name: "total_actual_cost_impact"
      expr: SUM(CAST(actual_cost_impact_amount AS DOUBLE))
      comment: "Total actual cost impact from implemented change notices. Compared against estimates to assess change cost accuracy."
    - name: "avg_estimated_cost_impact"
      expr: AVG(CAST(estimated_cost_impact_amount AS DOUBLE))
      comment: "Average estimated cost impact per change notice. Benchmarks the financial weight of design changes."
    - name: "cost_impacting_change_notices"
      expr: COUNT(CASE WHEN cost_impact_flag = TRUE THEN 1 END)
      comment: "Number of change notices with a cost impact. Drives contract change order pipeline sizing."
    - name: "schedule_impacting_change_notices"
      expr: COUNT(CASE WHEN schedule_impact_flag = TRUE THEN 1 END)
      comment: "Number of change notices with a schedule impact. Informs EOT claim exposure and programme risk."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`design_clash_detection_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks BIM clash detection performance across coordination runs, measuring clash volumes, resolution rates, and coordination quality. Critical for MEP and multi-discipline coordination governance."
  source: "`vibe_construction_v1`.`design`.`clash_detection_run`"
  dimensions:
    - name: "run_status"
      expr: run_status
      comment: "Status of the clash detection run (completed, in progress, failed) for pipeline monitoring."
    - name: "primary_discipline"
      expr: primary_discipline
      comment: "Primary discipline involved in the clash run for discipline-level coordination analysis."
    - name: "secondary_discipline"
      expr: secondary_discipline
      comment: "Secondary discipline involved, enabling discipline-pair clash hotspot identification."
    - name: "discipline_pair"
      expr: discipline_pair
      comment: "Combined discipline pair (e.g., structural-MEP) for coordination interface analysis."
    - name: "building_zone"
      expr: building_zone
      comment: "Building zone where clashes were detected, for spatial hotspot analysis."
    - name: "clash_free_certification_flag"
      expr: clash_free_certification_flag
      comment: "Whether the run achieved clash-free certification, a key milestone for construction readiness."
    - name: "run_date_month"
      expr: DATE_TRUNC('MONTH', run_date)
      comment: "Month of the clash detection run for trend analysis of coordination progress."
    - name: "software_platform"
      expr: software_platform
      comment: "BIM coordination software platform used, for tool performance benchmarking."
  measures:
    - name: "total_runs"
      expr: COUNT(1)
      comment: "Total number of clash detection runs. Measures BIM coordination activity intensity."
    - name: "clash_free_certified_runs"
      expr: COUNT(CASE WHEN clash_free_certification_flag = TRUE THEN 1 END)
      comment: "Number of runs achieving clash-free certification. A key construction readiness milestone."
    - name: "clash_free_certification_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN clash_free_certification_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of clash detection runs achieving clash-free certification. Measures BIM coordination maturity and construction readiness."
    - name: "total_clash_tolerance_mm_avg"
      expr: AVG(CAST(clash_tolerance_mm AS DOUBLE))
      comment: "Average clash tolerance threshold across runs. Tighter tolerances indicate higher coordination quality standards."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`design_correspondence`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks project correspondence volume, response performance, and closure rates. Unresolved correspondence creates contractual risk; this view enables management to monitor communication governance."
  source: "`vibe_construction_v1`.`design`.`correspondence`"
  dimensions:
    - name: "correspondence_status"
      expr: correspondence_status
      comment: "Current status of the correspondence (open, closed, pending response) for pipeline health."
    - name: "correspondence_type"
      expr: correspondence_type
      comment: "Type of correspondence (letter, email, notice, instruction) for category analysis."
    - name: "discipline"
      expr: discipline
      comment: "Engineering discipline associated with the correspondence."
    - name: "priority"
      expr: priority
      comment: "Priority level of the correspondence for escalation management."
    - name: "response_required_flag"
      expr: response_required_flag
      comment: "Whether a formal response is required, for contractual obligation tracking."
    - name: "confidential_flag"
      expr: confidential_flag
      comment: "Whether the correspondence is confidential, for access control monitoring."
    - name: "correspondence_date_month"
      expr: DATE_TRUNC('MONTH', correspondence_date)
      comment: "Month of correspondence for volume trend analysis."
  measures:
    - name: "total_correspondence"
      expr: COUNT(1)
      comment: "Total number of correspondence items. Baseline measure of project communication volume."
    - name: "open_correspondence"
      expr: COUNT(CASE WHEN correspondence_status = 'Open' THEN 1 END)
      comment: "Number of open correspondence items. Unresolved correspondence creates contractual and legal risk."
    - name: "closed_correspondence"
      expr: COUNT(CASE WHEN correspondence_status = 'Closed' THEN 1 END)
      comment: "Number of closed correspondence items. Measures communication resolution throughput."
    - name: "correspondence_closure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN correspondence_status = 'Closed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of correspondence items closed. A contractual governance KPI — low rates indicate unresolved obligations."
    - name: "response_required_items"
      expr: COUNT(CASE WHEN response_required_flag = TRUE THEN 1 END)
      comment: "Number of correspondence items requiring a formal response. Measures contractual response obligation volume."
    - name: "overdue_response_items"
      expr: COUNT(CASE WHEN response_required_flag = TRUE AND response_date IS NULL AND response_due_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of correspondence items where a response was required but not provided by the due date. A critical contractual risk KPI."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`design_document_register`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Measures document register health, controlled document compliance, and deliverable status. Supports document control governance and ISO 19650 information management compliance."
  source: "`vibe_construction_v1`.`design`.`document_register`"
  dimensions:
    - name: "document_register_status"
      expr: document_register_status
      comment: "Current status of the document (current, superseded, archived, under review) for register health."
    - name: "document_type"
      expr: document_type
      comment: "Type of document (drawing, specification, report, calculation, etc.) for category analysis."
    - name: "discipline"
      expr: discipline
      comment: "Engineering discipline of the document for workload attribution."
    - name: "is_client_deliverable"
      expr: is_client_deliverable
      comment: "Whether the document is a contractual client deliverable."
    - name: "is_controlled_document"
      expr: is_controlled_document
      comment: "Whether the document is under formal document control."
    - name: "confidentiality_classification"
      expr: confidentiality_classification
      comment: "Confidentiality classification of the document for access control governance."
    - name: "issue_date_month"
      expr: DATE_TRUNC('MONTH', issue_date)
      comment: "Month the document was issued for trend analysis of document delivery velocity."
  measures:
    - name: "total_documents"
      expr: COUNT(1)
      comment: "Total number of documents in the register. Baseline measure of project information scope."
    - name: "controlled_documents"
      expr: COUNT(CASE WHEN is_controlled_document = TRUE THEN 1 END)
      comment: "Number of documents under formal document control. Measures information management compliance."
    - name: "controlled_document_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_controlled_document = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of documents under formal document control. A document management governance KPI."
    - name: "client_deliverable_documents"
      expr: COUNT(CASE WHEN is_client_deliverable = TRUE THEN 1 END)
      comment: "Number of documents that are contractual client deliverables. Tracks delivery obligation scope."
    - name: "total_file_size_mb"
      expr: SUM(CAST(file_size_mb AS DOUBLE))
      comment: "Total file size of all registered documents in MB. Informs storage infrastructure planning."
    - name: "avg_file_size_mb"
      expr: AVG(CAST(file_size_mb AS DOUBLE))
      comment: "Average document file size in MB. Benchmarks document complexity and storage efficiency."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`design_drawing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Measures drawing register health, revision velocity, and deliverable status. Supports design delivery governance and document control performance management."
  source: "`vibe_construction_v1`.`design`.`drawing`"
  dimensions:
    - name: "drawing_status"
      expr: drawing_status
      comment: "Current status of the drawing (issued for construction, under review, superseded, etc.) for register health monitoring."
    - name: "drawing_type"
      expr: drawing_type
      comment: "Type of drawing (plan, elevation, section, detail, etc.) for category analysis."
    - name: "discipline"
      expr: discipline
      comment: "Engineering discipline of the drawing for workload and delivery attribution."
    - name: "is_client_deliverable"
      expr: is_client_deliverable
      comment: "Whether the drawing is a contractual client deliverable, for delivery obligation tracking."
    - name: "is_controlled_document"
      expr: is_controlled_document
      comment: "Whether the drawing is a controlled document under the document management system."
    - name: "clash_detection_status"
      expr: clash_detection_status
      comment: "BIM clash detection status for the drawing, linking design quality to coordination."
    - name: "issue_purpose"
      expr: issue_purpose
      comment: "Purpose of issue (for construction, for approval, for information, etc.) for delivery stage analysis."
    - name: "revision_date_month"
      expr: DATE_TRUNC('MONTH', revision_date)
      comment: "Month of the latest revision for drawing activity trend analysis."
  measures:
    - name: "total_drawings"
      expr: COUNT(1)
      comment: "Total number of drawings in the register. Baseline measure of design deliverable scope."
    - name: "client_deliverable_drawings"
      expr: COUNT(CASE WHEN is_client_deliverable = TRUE THEN 1 END)
      comment: "Number of drawings that are contractual client deliverables. Tracks delivery obligation fulfilment."
    - name: "controlled_drawings"
      expr: COUNT(CASE WHEN is_controlled_document = TRUE THEN 1 END)
      comment: "Number of drawings under formal document control. Measures document management compliance."
    - name: "controlled_document_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_controlled_document = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of drawings under formal document control. A document management governance KPI."
    - name: "total_file_size_mb"
      expr: SUM(CAST(file_size_mb AS DOUBLE))
      comment: "Total file size of all drawings in MB. Informs storage infrastructure planning."
    - name: "avg_file_size_mb"
      expr: AVG(CAST(file_size_mb AS DOUBLE))
      comment: "Average drawing file size in MB. Benchmarks drawing complexity and storage efficiency."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`design_handover_package`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Measures design handover package completeness, submission performance, and client acceptance rates. Directly informs project closeout readiness and contractual handover milestone achievement."
  source: "`vibe_construction_v1`.`design`.`handover_package`"
  dimensions:
    - name: "package_status"
      expr: package_status
      comment: "Current status of the handover package (draft, submitted, accepted, rejected) for closeout pipeline tracking."
    - name: "package_type"
      expr: package_type
      comment: "Type of handover package (as-built, O&M, commissioning, etc.) for category analysis."
    - name: "client_acceptance_status"
      expr: client_acceptance_status
      comment: "Client acceptance decision on the package, for contractual obligation fulfilment tracking."
    - name: "iso_19650_compliance_flag"
      expr: iso_19650_compliance_flag
      comment: "Whether the package complies with ISO 19650 BIM information management standards."
    - name: "legal_hold_flag"
      expr: legal_hold_flag
      comment: "Whether the package is under legal hold, for risk and compliance monitoring."
    - name: "planned_submission_month"
      expr: DATE_TRUNC('MONTH', planned_submission_date)
      comment: "Month the package was planned for submission, for schedule adherence analysis."
  measures:
    - name: "total_handover_packages"
      expr: COUNT(1)
      comment: "Total number of handover packages. Baseline measure of closeout deliverable scope."
    - name: "client_accepted_packages"
      expr: COUNT(CASE WHEN client_acceptance_status = 'Accepted' THEN 1 END)
      comment: "Number of packages accepted by the client. Measures contractual handover milestone achievement."
    - name: "client_acceptance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN client_acceptance_status = 'Accepted' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of handover packages accepted by the client. A critical project closeout KPI — low rates delay final payment and project completion."
    - name: "on_time_submission_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN submission_date <= planned_submission_date THEN 1 END) / NULLIF(COUNT(CASE WHEN submission_date IS NOT NULL AND planned_submission_date IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of handover packages submitted on or before the planned date. Measures closeout schedule adherence."
    - name: "avg_completeness_pct"
      expr: AVG(CAST(completeness_percentage AS DOUBLE))
      comment: "Average completeness percentage across all handover packages. Measures overall closeout readiness."
    - name: "iso_19650_compliant_packages"
      expr: COUNT(CASE WHEN iso_19650_compliance_flag = TRUE THEN 1 END)
      comment: "Number of packages compliant with ISO 19650 BIM standards. Measures information management governance."
    - name: "iso_19650_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN iso_19650_compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of handover packages meeting ISO 19650 compliance. A BIM governance KPI for asset information delivery."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`design_interface_point`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks design interface points between project scopes, measuring resolution rates, cost and schedule impacts, and coordination performance. Critical for multi-contractor project interface management."
  source: "`vibe_construction_v1`.`design`.`interface_point`"
  dimensions:
    - name: "interface_status"
      expr: interface_status
      comment: "Current status of the interface point (open, closed, in progress) for resolution pipeline tracking."
    - name: "interface_type"
      expr: interface_type
      comment: "Type of interface (physical, functional, contractual) for category analysis."
    - name: "interface_category"
      expr: interface_category
      comment: "Category of the interface for grouping and prioritisation."
    - name: "discipline"
      expr: discipline
      comment: "Engineering discipline responsible for the interface, for workload attribution."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level of the interface point (high, medium, low) for prioritisation."
    - name: "cost_impact_flag"
      expr: cost_impact_flag
      comment: "Whether the interface carries a cost impact, for financial exposure tracking."
    - name: "clash_detection_status"
      expr: clash_detection_status
      comment: "BIM clash detection status for the interface, linking coordination to physical resolution."
    - name: "planned_handover_month"
      expr: DATE_TRUNC('MONTH', planned_handover_date)
      comment: "Month the interface was planned for handover, for schedule adherence analysis."
  measures:
    - name: "total_interface_points"
      expr: COUNT(1)
      comment: "Total number of design interface points. High volumes on complex multi-contractor projects require dedicated management resources."
    - name: "open_interface_points"
      expr: COUNT(CASE WHEN interface_status = 'Open' THEN 1 END)
      comment: "Number of unresolved interface points. Open interfaces are a leading indicator of construction coordination risk."
    - name: "closed_interface_points"
      expr: COUNT(CASE WHEN interface_status = 'Closed' THEN 1 END)
      comment: "Number of resolved interface points. Measures interface management throughput."
    - name: "interface_closure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN interface_status = 'Closed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of interface points resolved. A critical multi-contractor coordination KPI — low rates indicate systemic interface management failures."
    - name: "high_risk_open_interfaces"
      expr: COUNT(CASE WHEN risk_level = 'High' AND interface_status = 'Open' THEN 1 END)
      comment: "Number of high-risk interface points still open. A priority escalation metric for project leadership."
    - name: "total_cost_impact_amount"
      expr: SUM(CAST(cost_impact_amount AS DOUBLE))
      comment: "Total financial exposure from cost-impacting interface points. Informs contract variation and contingency management."
    - name: "avg_cost_impact_amount"
      expr: AVG(CAST(cost_impact_amount AS DOUBLE))
      comment: "Average cost impact per interface point. Benchmarks the financial weight of interface management."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`design_mep_coordination_zone`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Measures MEP coordination zone progress, clash resolution status, and spatial coordination performance. Enables management to track BIM coordination completion and construction readiness by zone."
  source: "`vibe_construction_v1`.`design`.`mep_coordination_zone`"
  dimensions:
    - name: "coordination_status"
      expr: coordination_status
      comment: "Current coordination status of the MEP zone (not started, in progress, complete, signed off)."
    - name: "clash_detection_status"
      expr: clash_detection_status
      comment: "BIM clash detection status for the zone, measuring coordination quality."
    - name: "primary_discipline"
      expr: primary_discipline
      comment: "Primary MEP discipline responsible for the zone."
    - name: "building_reference"
      expr: building_reference
      comment: "Building reference for spatial analysis of coordination progress."
    - name: "level_reference"
      expr: level_reference
      comment: "Floor/level reference for spatial coordination analysis."
    - name: "zone_complexity_rating"
      expr: zone_complexity_rating
      comment: "Complexity rating of the zone, for resource allocation and risk prioritisation."
    - name: "planned_completion_month"
      expr: DATE_TRUNC('MONTH', planned_completion_date)
      comment: "Month the zone coordination was planned for completion, for schedule adherence analysis."
  measures:
    - name: "total_coordination_zones"
      expr: COUNT(1)
      comment: "Total number of MEP coordination zones. Baseline measure of BIM coordination scope."
    - name: "completed_zones"
      expr: COUNT(CASE WHEN coordination_status = 'Complete' THEN 1 END)
      comment: "Number of MEP coordination zones with completed coordination. Measures construction readiness progress."
    - name: "zone_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN coordination_status = 'Complete' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of MEP coordination zones completed. A key BIM coordination KPI for construction readiness."
    - name: "total_zone_area_sqm"
      expr: SUM(CAST(zone_area_sqm AS DOUBLE))
      comment: "Total floor area covered by MEP coordination zones in square metres. Measures coordination programme scope."
    - name: "avg_ceiling_height_m"
      expr: AVG(CAST(ceiling_height_m AS DOUBLE))
      comment: "Average ceiling height across coordination zones. Informs MEP routing and clearance planning."
    - name: "avg_available_clearance_m"
      expr: AVG(CAST(available_clearance_m AS DOUBLE))
      comment: "Average available clearance across MEP coordination zones. Low clearance values indicate high-risk coordination areas."
    - name: "total_soffit_height_m_avg"
      expr: AVG(CAST(soffit_height_m AS DOUBLE))
      comment: "Average soffit height across zones. Used to assess MEP installation feasibility and coordination constraints."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`design_package`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Overall package delivery health"
  source: "`construction_ecm`.`design`.`package`"
  dimensions:
    - name: "package_status"
      expr: package_status
      comment: "Current status of the package"
    - name: "discipline"
      expr: discipline
      comment: "Discipline associated with the package"
    - name: "package_type"
      expr: package_type
      comment: "Type of package (e.g., mechanical, electrical)"
    - name: "created_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Date the package record was created"
  measures:
    - name: "total_packages"
      expr: COUNT(1)
      comment: "Total number of design packages"
    - name: "average_completeness_pct"
      expr: AVG(CAST(completeness_percentage AS DOUBLE))
      comment: "Average completeness percentage across packages"
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`design_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Performance and quality metrics for design reviews"
  source: "`construction_ecm`.`design`.`review`"
  dimensions:
    - name: "review_status"
      expr: review_status
      comment: "Current status of the review"
    - name: "discipline"
      expr: discipline
      comment: "Discipline of the review"
    - name: "review_type"
      expr: review_type
      comment: "Type of review (e.g., internal, client)"
    - name: "review_date"
      expr: DATE_TRUNC('day', review_date)
      comment: "Date the review took place"
  measures:
    - name: "total_reviews"
      expr: COUNT(1)
      comment: "Total number of design reviews conducted"
    - name: "average_review_duration_hours"
      expr: AVG(CAST(duration_hours AS DOUBLE))
      comment: "Average duration of reviews in hours"
    - name: "clash_detection_count"
      expr: SUM(CASE WHEN clash_detection_performed THEN 1 ELSE 0 END)
      comment: "Number of reviews where clash detection was performed"
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`design_drawing_revision`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks drawing revision activity, review cycle performance, and distribution compliance. High revision rates signal design instability; this view enables management to identify problem areas and drive design freeze."
  source: "`vibe_construction_v1`.`design`.`revision`"
  dimensions:
    - name: "revision_status"
      expr: revision_status
      comment: "Current status of the drawing revision (issued, under review, superseded, etc.)."
    - name: "revision_type"
      expr: revision_type
      comment: "Type of revision (minor, major, regulatory, client-driven) for root cause analysis."
    - name: "revision_date_month"
      expr: DATE_TRUNC('MONTH', revision_date)
      comment: "Month of the revision for trend analysis of design change velocity."
  measures:
    - name: "total_revisions"
      expr: COUNT(1)
      comment: "Total number of drawing revisions. High volumes indicate design instability and rework costs."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`design_rfi`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks RFI (Request for Information) volume, response performance, and cost/schedule impact to support design coordination decisions and identify bottlenecks in the design clarification process."
  source: "`vibe_construction_v1`.`design`.`rfi`"
  dimensions:
    - name: "discipline"
      expr: discipline
      comment: "Engineering discipline (civil, structural, MEP, etc.) to identify which design areas generate the most RFIs."
    - name: "rfi_status"
      expr: rfi_status
      comment: "Current lifecycle status of the RFI (open, closed, pending, etc.) for pipeline health monitoring."
    - name: "priority"
      expr: priority
      comment: "RFI priority level to focus management attention on critical items."
    - name: "cost_impact_flag"
      expr: cost_impact_flag
      comment: "Indicates whether the RFI carries a cost impact, enabling financial exposure analysis."
    - name: "schedule_impact_flag"
      expr: schedule_impact_flag
      comment: "Indicates whether the RFI carries a schedule impact, enabling delay risk analysis."
    - name: "date_raised_month"
      expr: DATE_TRUNC('MONTH', date_raised)
      comment: "Month the RFI was raised, for trend analysis over time."
  measures:
    - name: "total_rfis"
      expr: COUNT(1)
      comment: "Total number of RFIs raised. Baseline volume metric for design coordination workload."
    - name: "open_rfis"
      expr: COUNT(CASE WHEN rfi_status = 'Open' THEN 1 END)
      comment: "Number of currently open RFIs. High open counts signal design coordination bottlenecks requiring management intervention."
    - name: "closed_rfis"
      expr: COUNT(CASE WHEN rfi_status = 'Closed' THEN 1 END)
      comment: "Number of closed RFIs, indicating resolution throughput."
    - name: "rfi_closure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN rfi_status = 'Closed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of RFIs that have been closed. A low closure rate signals unresolved design queries that may block construction progress."
    - name: "cost_impacting_rfis"
      expr: COUNT(CASE WHEN cost_impact_flag = TRUE THEN 1 END)
      comment: "Number of RFIs with a confirmed cost impact. Drives contract change order forecasting."
    - name: "schedule_impacting_rfis"
      expr: COUNT(CASE WHEN schedule_impact_flag = TRUE THEN 1 END)
      comment: "Number of RFIs with a confirmed schedule impact. Directly informs delay risk and EOT claim exposure."
    - name: "total_cost_impact_amount"
      expr: SUM(CAST(cost_impact_amount AS DOUBLE))
      comment: "Total financial exposure from RFIs with cost impacts. Used to size contingency and change order budgets."
    - name: "avg_cost_impact_per_rfi"
      expr: AVG(CAST(cost_impact_amount AS DOUBLE))
      comment: "Average cost impact per RFI. Helps benchmark the financial weight of design queries."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`design_value_engineering_proposal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks value engineering proposal pipeline, estimated and realised savings, and client decision rates. Directly informs cost optimisation strategy and design innovation performance."
  source: "`vibe_construction_v1`.`design`.`value_engineering_proposal`"
  dimensions:
    - name: "proposal_status"
      expr: proposal_status
      comment: "Current status of the VE proposal (submitted, under review, approved, rejected, implemented) for pipeline tracking."
    - name: "client_decision"
      expr: client_decision
      comment: "Client decision on the VE proposal (accepted, rejected, deferred) for decision analysis."
    - name: "originator_discipline"
      expr: originator_discipline
      comment: "Engineering discipline originating the proposal, for innovation attribution."
    - name: "implementation_status"
      expr: implementation_status
      comment: "Implementation status of approved proposals, for savings realisation tracking."
    - name: "environmental_impact_flag"
      expr: environmental_impact_flag
      comment: "Whether the proposal has an environmental impact, for sustainability alignment."
    - name: "safety_impact_flag"
      expr: safety_impact_flag
      comment: "Whether the proposal has a safety impact, for HSE risk screening."
    - name: "client_decision_month"
      expr: DATE_TRUNC('MONTH', client_decision_date)
      comment: "Month of client decision for trend analysis of VE pipeline throughput."
  measures:
    - name: "total_ve_proposals"
      expr: COUNT(1)
      comment: "Total number of value engineering proposals submitted. Measures design innovation activity."
    - name: "client_accepted_proposals"
      expr: COUNT(CASE WHEN client_decision = 'Accepted' THEN 1 END)
      comment: "Number of VE proposals accepted by the client. Measures VE programme effectiveness."
    - name: "client_acceptance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN client_decision = 'Accepted' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of VE proposals accepted by the client. A key design innovation KPI — high rates indicate strong client alignment and cost optimisation culture."
    - name: "total_estimated_cost_saving"
      expr: SUM(CAST(estimated_cost_saving AS DOUBLE))
      comment: "Total estimated cost savings from all VE proposals. Measures the potential financial value of the VE programme."
    - name: "total_implemented_saving_value"
      expr: SUM(CAST(implemented_saving_value AS DOUBLE))
      comment: "Total realised savings from implemented VE proposals. Measures actual financial benefit delivered to the project."
    - name: "avg_estimated_cost_saving"
      expr: AVG(CAST(estimated_cost_saving AS DOUBLE))
      comment: "Average estimated saving per VE proposal. Benchmarks the financial impact of individual proposals."
    - name: "saving_realisation_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(implemented_saving_value AS DOUBLE)) / NULLIF(SUM(CAST(estimated_cost_saving AS DOUBLE)), 0), 2)
      comment: "Percentage of estimated VE savings actually realised through implementation. Measures VE programme delivery effectiveness — a critical cost optimisation KPI."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`design_workflow_approval`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Measures design document approval workflow performance including SLA compliance, escalation rates, and cycle time efficiency. Enables management to identify approval bottlenecks and governance failures."
  source: "`vibe_construction_v1`.`design`.`workflow_approval`"
  dimensions:
    - name: "workflow_status"
      expr: workflow_status
      comment: "Current status of the approval workflow (pending, approved, rejected, escalated) for pipeline health."
    - name: "workflow_type"
      expr: workflow_type
      comment: "Type of approval workflow (drawing review, submittal approval, change notice, etc.) for category analysis."
    - name: "overall_outcome"
      expr: overall_outcome
      comment: "Final outcome of the workflow (approved, rejected, withdrawn) for decision quality analysis."
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether the workflow was escalated, for governance and bottleneck identification."
    - name: "sla_compliance_flag"
      expr: sla_compliance_flag
      comment: "Whether the workflow was completed within SLA targets. Key governance KPI."
    - name: "approval_authority_level"
      expr: approval_authority_level
      comment: "Level of approval authority required, for governance tier analysis."
    - name: "regulatory_requirement_flag"
      expr: regulatory_requirement_flag
      comment: "Whether the workflow is driven by a regulatory requirement, for compliance tracking."
    - name: "due_date_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month the workflow was due for completion, for SLA trend analysis."
  measures:
    - name: "total_workflows"
      expr: COUNT(1)
      comment: "Total number of approval workflows initiated. Baseline measure of design governance workload."
    - name: "sla_compliant_workflows"
      expr: COUNT(CASE WHEN sla_compliance_flag = TRUE THEN 1 END)
      comment: "Number of workflows completed within SLA. Measures approval process efficiency."
    - name: "sla_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sla_compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of approval workflows completed within SLA targets. A critical design governance KPI — low rates indicate approval bottlenecks that delay design delivery."
    - name: "escalated_workflows"
      expr: COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END)
      comment: "Number of workflows that required escalation. High escalation rates signal approval authority gaps or resource constraints."
    - name: "escalation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of workflows escalated. A governance health KPI — high rates indicate systemic approval process failures."
    - name: "avg_sla_actual_hours"
      expr: AVG(CAST(sla_actual_hours AS DOUBLE))
      comment: "Average actual hours taken to complete approval workflows. Benchmarks approval cycle time performance."
    - name: "total_sla_actual_hours"
      expr: SUM(CAST(sla_actual_hours AS DOUBLE))
      comment: "Total hours consumed by approval workflows. Informs resource capacity planning for design review teams."
$$;
