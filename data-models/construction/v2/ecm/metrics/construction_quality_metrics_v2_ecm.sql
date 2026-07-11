-- Metric views for domain: quality | Business: Construction | Version: 2 | Generated on: 2026-07-10 12:14:04

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`quality_ncr`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Non-Conformance Report (NCR) metrics tracking quality failures, cost impacts, and resolution performance across construction projects. NCRs are the primary quality control instrument for identifying and closing non-conformances."
  source: "`vibe_construction_v1`.`quality`.`ncr`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project context for NCR — enables project-level quality benchmarking."
    - name: "ncr_status"
      expr: ncr_status
      comment: "Current lifecycle status of the NCR (Open, Closed, Under Review, etc.)."
    - name: "ncr_category"
      expr: ncr_category
      comment: "Category of non-conformance (e.g. Material, Workmanship, Design) for root-cause trending."
    - name: "severity"
      expr: severity
      comment: "Severity classification of the NCR — drives prioritisation and escalation decisions."
    - name: "discipline"
      expr: discipline
      comment: "Engineering or trade discipline associated with the NCR for discipline-level quality analysis."
    - name: "disposition"
      expr: disposition
      comment: "Final disposition of the NCR (Accept As Is, Rework, Reject) — key quality outcome indicator."
    - name: "identified_date"
      expr: identified_date
      comment: "Date the non-conformance was identified — used for trend analysis over time."
    - name: "wbs_element_id"
      expr: wbs_element_id
      comment: "WBS element where the NCR was raised — enables cost-area quality analysis."
  measures:
    - name: "total_ncr_count"
      expr: COUNT(1)
      comment: "Total number of NCRs raised. Baseline volume metric for quality performance dashboards."
    - name: "open_ncr_count"
      expr: COUNT(CASE WHEN ncr_status = 'Open' THEN 1 END)
      comment: "Number of currently open NCRs. High open counts signal unresolved quality risk on the project."
    - name: "closed_ncr_count"
      expr: COUNT(CASE WHEN ncr_status = 'Closed' THEN 1 END)
      comment: "Number of closed NCRs. Used to track resolution throughput and backlog clearance."
    - name: "ncr_closure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN ncr_status = 'Closed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of NCRs that have been closed. A key quality KPI — low closure rate indicates systemic resolution bottlenecks."
    - name: "total_estimated_cost_impact"
      expr: SUM(CAST(estimated_cost_impact AS DOUBLE))
      comment: "Total estimated financial cost of all non-conformances. Directly informs quality cost management and budget risk."
    - name: "avg_estimated_cost_impact"
      expr: AVG(CAST(estimated_cost_impact AS DOUBLE))
      comment: "Average cost impact per NCR. Benchmarks the financial severity of quality failures."
    - name: "hold_status_ncr_count"
      expr: COUNT(CASE WHEN hold_status = TRUE THEN 1 END)
      comment: "Number of NCRs currently on hold. Hold NCRs block construction progress and represent active schedule risk."
    - name: "ncr_with_client_notification_count"
      expr: COUNT(CASE WHEN client_notification_required = TRUE THEN 1 END)
      comment: "Number of NCRs requiring client notification. Tracks contractual notification obligations and client relationship risk."
    - name: "total_quantity_affected"
      expr: SUM(CAST(quantity_affected AS DOUBLE))
      comment: "Total quantity of materials or work affected by non-conformances. Indicates the physical scale of quality failures."
    - name: "avg_schedule_impact_days"
      expr: AVG(CAST(schedule_impact_days AS DOUBLE))
      comment: "Average schedule delay in days caused by NCRs. Links quality failures directly to programme performance."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`quality_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inspection performance metrics covering pass/fail rates, reinspection frequency, and inspection throughput. Inspections are the primary quality gate mechanism on construction projects."
  source: "`vibe_construction_v1`.`quality`.`inspection`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project context for the inspection — enables project-level inspection performance comparison."
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection (e.g. Pre-pour, Weld, Structural) — drives discipline-specific quality analysis."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current status of the inspection (Pending, Passed, Failed, Reinspection Required)."
    - name: "overall_outcome"
      expr: overall_outcome
      comment: "Final outcome of the inspection — the primary pass/fail quality signal."
    - name: "inspection_date"
      expr: inspection_date
      comment: "Date of inspection — used for trend analysis and inspection frequency reporting."
    - name: "wbs_element_id"
      expr: wbs_element_id
      comment: "WBS element inspected — enables cost-area quality performance analysis."
    - name: "location_type"
      expr: location_type
      comment: "Type of location inspected (e.g. Site, Workshop, Factory) — contextualises inspection scope."
  measures:
    - name: "total_inspections"
      expr: COUNT(1)
      comment: "Total number of inspections conducted. Baseline volume metric for inspection programme tracking."
    - name: "passed_inspections"
      expr: COUNT(CASE WHEN overall_outcome = 'Pass' THEN 1 END)
      comment: "Number of inspections with a passing outcome. Core quality throughput indicator."
    - name: "failed_inspections"
      expr: COUNT(CASE WHEN overall_outcome = 'Fail' THEN 1 END)
      comment: "Number of inspections that failed. Directly signals quality non-compliance requiring corrective action."
    - name: "inspection_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN overall_outcome = 'Pass' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections passed on first attempt. A primary quality KPI used in project performance reviews."
    - name: "reinspection_required_count"
      expr: COUNT(CASE WHEN reinspection_required = TRUE THEN 1 END)
      comment: "Number of inspections requiring reinspection. High reinspection rates indicate systemic quality issues."
    - name: "reinspection_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN reinspection_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections requiring reinspection. A key rework efficiency indicator — high rates increase cost and delay."
    - name: "ncr_raised_count"
      expr: COUNT(CASE WHEN ncr_raised = TRUE THEN 1 END)
      comment: "Number of inspections that triggered an NCR. Links inspection failures to formal non-conformance records."
    - name: "ncr_raise_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN ncr_raised = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections that resulted in an NCR being raised. Measures the severity conversion rate of inspection failures."
    - name: "avg_temperature_celsius"
      expr: AVG(CAST(temperature_celsius AS DOUBLE))
      comment: "Average ambient temperature during inspections. Environmental context for quality outcome analysis."
    - name: "avg_humidity_percent"
      expr: AVG(CAST(humidity_percent AS DOUBLE))
      comment: "Average humidity during inspections. Environmental factor affecting material and workmanship quality outcomes."
    - name: "corrective_action_required_count"
      expr: COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END)
      comment: "Number of inspections requiring corrective action. Tracks the volume of quality remediation work generated."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`quality_defect`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Defect management metrics tracking defect volumes, rectification costs, closure rates, and DLP exposure. Defects represent quality failures that must be resolved before handover or within the defects liability period."
  source: "`vibe_construction_v1`.`quality`.`defect`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project context for defect analysis — enables cross-project quality benchmarking."
    - name: "defect_status"
      expr: defect_status
      comment: "Current lifecycle status of the defect (Open, In Progress, Closed, Deferred)."
    - name: "defect_type"
      expr: defect_type
      comment: "Classification of defect type — drives root cause analysis and prevention strategies."
    - name: "severity"
      expr: severity
      comment: "Severity of the defect — determines prioritisation and escalation thresholds."
    - name: "trade_discipline"
      expr: trade_discipline
      comment: "Trade or discipline responsible for the defect — enables trade-level quality accountability."
    - name: "identified_phase"
      expr: identified_phase
      comment: "Construction phase when the defect was identified — earlier detection reduces rectification cost."
    - name: "identified_date"
      expr: identified_date
      comment: "Date defect was identified — used for trend analysis and ageing reports."
    - name: "wbs_element_id"
      expr: wbs_element_id
      comment: "WBS element where the defect was found — enables cost-area defect density analysis."
  measures:
    - name: "total_defects"
      expr: COUNT(1)
      comment: "Total number of defects recorded. Baseline quality volume metric for project performance dashboards."
    - name: "open_defects"
      expr: COUNT(CASE WHEN defect_status = 'Open' THEN 1 END)
      comment: "Number of currently open defects. Open defect backlog is a key handover readiness indicator."
    - name: "defect_closure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN defect_status = 'Closed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of defects closed. Low closure rate signals handover risk and contractor performance issues."
    - name: "total_rectification_cost"
      expr: SUM(CAST(rectification_cost AS DOUBLE))
      comment: "Total cost of defect rectification. Directly measures the financial impact of quality failures on project budget."
    - name: "avg_rectification_cost"
      expr: AVG(CAST(rectification_cost AS DOUBLE))
      comment: "Average rectification cost per defect. Benchmarks the cost efficiency of quality remediation."
    - name: "dlp_deferred_defects"
      expr: COUNT(CASE WHEN impact_on_handover = TRUE THEN 1 END)
      comment: "Number of defects impacting handover. Directly measures handover readiness risk."
    - name: "distinct_projects_with_defects"
      expr: COUNT(DISTINCT construction_project_id)
      comment: "Number of distinct projects with recorded defects. Portfolio-level quality exposure indicator."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`quality_corrective_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Corrective action effectiveness metrics tracking resolution rates, cost of quality, systemic issue identification, and timeliness of corrective actions. Corrective actions are the primary mechanism for closing NCRs and preventing recurrence."
  source: "`vibe_construction_v1`.`quality`.`corrective_action`"
  dimensions:
    - name: "action_status"
      expr: action_status
      comment: "Current status of the corrective action (Open, In Progress, Closed, Overdue)."
    - name: "action_type"
      expr: action_type
      comment: "Type of corrective action (Rework, Repair, Replace, Accept As Is) — informs quality strategy."
    - name: "priority"
      expr: priority
      comment: "Priority level of the corrective action — drives resource allocation decisions."
    - name: "effectiveness_review_outcome"
      expr: effectiveness_review_outcome
      comment: "Outcome of the effectiveness review — measures whether the corrective action actually resolved the root cause."
    - name: "is_systemic_issue"
      expr: is_systemic_issue
      comment: "Flag indicating whether the NCR represents a systemic quality issue requiring process change."
    - name: "assigned_date"
      expr: assigned_date
      comment: "Date the corrective action was assigned — used for ageing and SLA compliance analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of cost estimates — required for multi-currency project cost analysis."
  measures:
    - name: "total_corrective_actions"
      expr: COUNT(1)
      comment: "Total corrective actions raised. Baseline volume metric for quality management workload."
    - name: "open_corrective_actions"
      expr: COUNT(CASE WHEN action_status = 'Open' THEN 1 END)
      comment: "Number of open corrective actions. High open counts indicate unresolved quality risk."
    - name: "corrective_action_closure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN action_status = 'Closed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of corrective actions closed. Primary KPI for quality resolution effectiveness."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred for corrective actions. Measures the true cost of quality failures."
    - name: "total_estimated_cost"
      expr: SUM(CAST(cost_estimate AS DOUBLE))
      comment: "Total estimated cost of corrective actions. Used for budget forecasting of quality remediation."
    - name: "cost_overrun_amount"
      expr: SUM(CAST(actual_cost AS DOUBLE) - CAST(cost_estimate AS DOUBLE))
      comment: "Total cost overrun on corrective actions (actual minus estimate). Measures estimating accuracy for quality remediation."
    - name: "systemic_issue_count"
      expr: COUNT(CASE WHEN is_systemic_issue = TRUE THEN 1 END)
      comment: "Number of corrective actions flagged as systemic issues. Systemic issues require process-level intervention and are a leading indicator of quality programme maturity."
    - name: "systemic_issue_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_systemic_issue = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of corrective actions that are systemic. High rates indicate fundamental quality management process failures."
    - name: "requires_design_change_count"
      expr: COUNT(CASE WHEN requires_design_change = TRUE THEN 1 END)
      comment: "Number of corrective actions requiring a design change. Measures the design quality impact on construction quality."
    - name: "effective_corrective_actions"
      expr: COUNT(CASE WHEN effectiveness_review_outcome = 'Effective' THEN 1 END)
      comment: "Number of corrective actions confirmed as effective after review. Measures the true resolution quality of the quality management system."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`quality_punch_list`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Punch list completion metrics tracking handover readiness, open item backlog, and closeout performance. Punch lists are the final quality gate before project handover and DLP commencement."
  source: "`vibe_construction_v1`.`quality`.`punch_list`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project context — enables cross-project handover readiness comparison."
    - name: "punch_list_status"
      expr: punch_list_status
      comment: "Current status of the punch list (Open, In Progress, Closed) — primary handover readiness indicator."
    - name: "discipline"
      expr: discipline
      comment: "Engineering discipline for the punch list — enables discipline-level closeout tracking."
    - name: "milestone_type"
      expr: milestone_type
      comment: "Milestone type associated with the punch list (e.g. Mechanical Completion, Handover) — links quality to project milestones."
    - name: "priority"
      expr: priority
      comment: "Priority of the punch list — drives resource allocation for closeout activities."
    - name: "handover_gate"
      expr: handover_gate
      comment: "Flag indicating whether this punch list is a handover gate — critical for project completion tracking."
    - name: "dlp_commencement_gate"
      expr: dlp_commencement_gate
      comment: "Flag indicating whether this punch list gates DLP commencement — directly impacts contractual liability periods."
    - name: "creation_date"
      expr: creation_date
      comment: "Date the punch list was created — used for ageing and closeout velocity analysis."
  measures:
    - name: "total_punch_lists"
      expr: COUNT(1)
      comment: "Total number of punch lists. Baseline volume metric for handover management."
    - name: "avg_completion_percentage"
      expr: AVG(CAST(completion_percentage AS DOUBLE))
      comment: "Average completion percentage across all punch lists. Primary handover readiness KPI used in project steering meetings."
    - name: "handover_gate_punch_lists"
      expr: COUNT(CASE WHEN handover_gate = TRUE THEN 1 END)
      comment: "Number of punch lists that are handover gates. Tracks the critical path to project completion."
    - name: "closed_punch_lists"
      expr: COUNT(CASE WHEN punch_list_status = 'Closed' THEN 1 END)
      comment: "Number of fully closed punch lists. Measures handover completion throughput."
    - name: "punch_list_closure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN punch_list_status = 'Closed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of punch lists closed. Key handover readiness KPI reported at project steering level."
    - name: "distinct_projects_with_open_punch_lists"
      expr: COUNT(DISTINCT CASE WHEN punch_list_status != 'Closed' THEN construction_project_id END)
      comment: "Number of projects with open punch lists. Portfolio-level handover risk indicator for programme directors."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`quality_punch_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Punch item granular metrics tracking individual item resolution, cost impact, and DLP deferral rates. Punch items are the line-level quality deficiencies that must be resolved for handover."
  source: "`vibe_construction_v1`.`quality`.`punch_item`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project context for punch item analysis."
    - name: "punch_item_status"
      expr: punch_item_status
      comment: "Current status of the punch item (Open, In Progress, Closed, Deferred)."
    - name: "punch_item_category"
      expr: punch_item_category
      comment: "Category of the punch item — enables category-level quality analysis and trend identification."
    - name: "priority"
      expr: priority
      comment: "Priority of the punch item — drives closeout sequencing decisions."
    - name: "closure_status"
      expr: closure_status
      comment: "Closure status of the punch item — tracks formal sign-off on resolution."
    - name: "deferred_to_dlp"
      expr: deferred_to_dlp
      comment: "Flag indicating whether the item was deferred to the DLP — deferred items represent contractual liability exposure."
    - name: "identified_date"
      expr: identified_date
      comment: "Date the punch item was identified — used for ageing analysis."
    - name: "wbs_element_id"
      expr: wbs_element_id
      comment: "WBS element for the punch item — enables cost-area closeout analysis."
  measures:
    - name: "total_punch_items"
      expr: COUNT(1)
      comment: "Total number of punch items. Baseline volume metric for handover quality management."
    - name: "open_punch_items"
      expr: COUNT(CASE WHEN punch_item_status = 'Open' THEN 1 END)
      comment: "Number of open punch items. Open item backlog is the primary handover readiness risk indicator."
    - name: "punch_item_closure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN punch_item_status = 'Closed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of punch items closed. Key handover completion KPI for project managers and clients."
    - name: "dlp_deferred_items"
      expr: COUNT(CASE WHEN deferred_to_dlp = TRUE THEN 1 END)
      comment: "Number of punch items deferred to the DLP. Deferred items represent post-handover liability and contractor obligation."
    - name: "dlp_deferral_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN deferred_to_dlp = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of punch items deferred to DLP. High deferral rates indicate handover quality risk and potential client disputes."
    - name: "total_cost_impact"
      expr: SUM(CAST(cost_impact AS DOUBLE))
      comment: "Total financial cost impact of punch items. Measures the budget exposure from outstanding quality deficiencies."
    - name: "avg_cost_impact"
      expr: AVG(CAST(cost_impact AS DOUBLE))
      comment: "Average cost impact per punch item. Benchmarks the financial severity of individual quality deficiencies."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`quality_checklist_execution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Checklist execution performance metrics tracking compliance rates, critical failures, and NCR generation from quality inspections. Checklist executions are the operational record of quality control activities on site."
  source: "`vibe_construction_v1`.`quality`.`checklist_execution`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project context for checklist execution — enables project-level quality compliance analysis."
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection the checklist supports — enables inspection-type quality benchmarking."
    - name: "inspection_stage"
      expr: inspection_stage
      comment: "Stage of construction at which the checklist was executed — links quality to construction progress."
    - name: "overall_result"
      expr: overall_result
      comment: "Overall pass/fail result of the checklist execution — primary quality outcome indicator."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the checklist execution — tracks formal sign-off on quality activities."
    - name: "critical_failure_flag"
      expr: critical_failure_flag
      comment: "Flag indicating a critical failure was identified — critical failures require immediate escalation."
    - name: "execution_date"
      expr: execution_date
      comment: "Date of checklist execution — used for trend analysis and inspection frequency reporting."
    - name: "wbs_element_id"
      expr: wbs_element_id
      comment: "WBS element for the checklist execution — enables cost-area quality compliance analysis."
  measures:
    - name: "total_executions"
      expr: COUNT(1)
      comment: "Total number of checklist executions. Baseline quality activity volume metric."
    - name: "avg_compliance_percentage"
      expr: AVG(CAST(compliance_percentage AS DOUBLE))
      comment: "Average compliance percentage across all checklist executions. Primary quality compliance KPI for project steering."
    - name: "critical_failure_count"
      expr: COUNT(CASE WHEN critical_failure_flag = TRUE THEN 1 END)
      comment: "Number of checklist executions with critical failures. Critical failures represent immediate safety and quality risk."
    - name: "critical_failure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN critical_failure_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of checklist executions with critical failures. A leading quality risk indicator for project directors."
    - name: "ncr_generated_count"
      expr: COUNT(CASE WHEN ncr_generated_flag = TRUE THEN 1 END)
      comment: "Number of checklist executions that generated an NCR. Measures the conversion rate from quality checks to formal non-conformances."
    - name: "ncr_generation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN ncr_generated_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of checklist executions resulting in an NCR. High rates indicate systemic quality issues in specific work areas."
    - name: "witness_required_not_captured_count"
      expr: COUNT(CASE WHEN witness_required_flag = TRUE AND witness_signature_captured = FALSE THEN 1 END)
      comment: "Number of executions where a witness was required but signature was not captured. Measures contractual compliance with witness point obligations."
    - name: "avg_temperature_celsius"
      expr: AVG(CAST(temperature_celsius AS DOUBLE))
      comment: "Average ambient temperature during checklist executions. Environmental context for quality outcome analysis."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`quality_lab_test`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Laboratory test result metrics tracking material compliance rates, test pass/fail performance, and specification conformance. Lab tests provide objective evidence of material quality for construction projects."
  source: "`vibe_construction_v1`.`quality`.`lab_test`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project context for lab tests — enables project-level material quality analysis."
    - name: "test_result_status"
      expr: test_result_status
      comment: "Pass/fail status of the lab test — primary material quality outcome indicator."
    - name: "material_type"
      expr: material_type
      comment: "Type of material tested — enables material-category quality benchmarking."
    - name: "test_method"
      expr: test_method
      comment: "Test method used — ensures comparability of results across test types."
    - name: "test_standard"
      expr: test_standard
      comment: "Standard against which the test was conducted — links results to regulatory and specification requirements."
    - name: "retest_flag"
      expr: retest_flag
      comment: "Flag indicating this is a retest — retest rates measure first-pass material quality."
    - name: "test_date"
      expr: test_date
      comment: "Date of the lab test — used for trend analysis and material quality monitoring over time."
    - name: "wbs_element_id"
      expr: wbs_element_id
      comment: "WBS element for the lab test — enables cost-area material quality analysis."
  measures:
    - name: "total_lab_tests"
      expr: COUNT(1)
      comment: "Total number of lab tests conducted. Baseline material testing volume metric."
    - name: "passed_tests"
      expr: COUNT(CASE WHEN test_result_status = 'Pass' THEN 1 END)
      comment: "Number of lab tests that passed. Core material quality compliance indicator."
    - name: "failed_tests"
      expr: COUNT(CASE WHEN test_result_status = 'Fail' THEN 1 END)
      comment: "Number of lab tests that failed. Failed tests trigger NCRs and material rejection decisions."
    - name: "test_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN test_result_status = 'Pass' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of lab tests passing. Primary material quality KPI for procurement and quality management."
    - name: "retest_count"
      expr: COUNT(CASE WHEN retest_flag = TRUE THEN 1 END)
      comment: "Number of retests conducted. High retest volumes indicate material quality issues and increase testing costs."
    - name: "retest_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN retest_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of tests that are retests. Measures first-pass material quality and testing efficiency."
    - name: "avg_measured_result"
      expr: AVG(CAST(measured_result AS DOUBLE))
      comment: "Average measured test result value. Used for statistical process control and specification compliance trending."
    - name: "avg_specification_requirement"
      expr: AVG(CAST(specification_requirement AS DOUBLE))
      comment: "Average specification requirement value. Provides the benchmark for measured result comparison."
    - name: "distinct_materials_tested"
      expr: COUNT(DISTINCT material_type)
      comment: "Number of distinct material types tested. Measures the breadth of material quality assurance coverage."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`quality_weld_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Weld quality metrics tracking acceptance rates, NDT results, rework rates, and PWHT compliance. Weld quality is a critical safety and structural integrity indicator in construction and industrial projects."
  source: "`vibe_construction_v1`.`quality`.`weld_record`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project context for weld quality analysis — enables project-level weld performance benchmarking."
    - name: "acceptance_status"
      expr: acceptance_status
      comment: "Acceptance status of the weld (Accepted, Rejected, Pending) — primary weld quality outcome indicator."
    - name: "ndt_method"
      expr: ndt_method
      comment: "NDT method used to inspect the weld (RT, UT, MT, PT) — enables method-specific quality analysis."
    - name: "ndt_result"
      expr: ndt_result
      comment: "Result of the NDT inspection — links weld quality to non-destructive testing outcomes."
    - name: "weld_type"
      expr: weld_type
      comment: "Type of weld (Butt, Fillet, etc.) — enables weld-type quality benchmarking."
    - name: "joint_type"
      expr: joint_type
      comment: "Joint type for the weld — provides structural context for quality analysis."
    - name: "rework_required_flag"
      expr: rework_required_flag
      comment: "Flag indicating weld rework was required — rework rates are a key welder performance indicator."
    - name: "weld_date"
      expr: weld_date
      comment: "Date of welding — used for trend analysis and welder performance monitoring."
    - name: "wbs_element_id"
      expr: wbs_element_id
      comment: "WBS element for the weld — enables cost-area weld quality analysis."
  measures:
    - name: "total_welds"
      expr: COUNT(1)
      comment: "Total number of weld records. Baseline weld production volume metric."
    - name: "accepted_welds"
      expr: COUNT(CASE WHEN acceptance_status = 'Accepted' THEN 1 END)
      comment: "Number of welds accepted. Core weld quality throughput indicator."
    - name: "rejected_welds"
      expr: COUNT(CASE WHEN acceptance_status = 'Rejected' THEN 1 END)
      comment: "Number of welds rejected. Rejected welds require rework and directly impact schedule and cost."
    - name: "weld_acceptance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN acceptance_status = 'Accepted' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of welds accepted on first inspection. Primary weld quality KPI — industry benchmark is typically >97%."
    - name: "rework_required_count"
      expr: COUNT(CASE WHEN rework_required_flag = TRUE THEN 1 END)
      comment: "Number of welds requiring rework. Rework is a direct cost and schedule impact indicator."
    - name: "rework_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN rework_required_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of welds requiring rework. High rework rates indicate welder qualification or procedure compliance issues."
    - name: "pwht_required_count"
      expr: COUNT(CASE WHEN pwht_required_flag = TRUE THEN 1 END)
      comment: "Number of welds requiring post-weld heat treatment. PWHT compliance is a critical structural integrity requirement."
    - name: "total_weld_length_mm"
      expr: SUM(CAST(weld_length_mm AS DOUBLE))
      comment: "Total weld length in millimetres. Production volume metric for weld programme progress tracking."
    - name: "avg_weld_length_mm"
      expr: AVG(CAST(weld_length_mm AS DOUBLE))
      comment: "Average weld length per record. Used for productivity benchmarking and resource planning."
    - name: "avg_preheat_temperature_c"
      expr: AVG(CAST(preheat_temperature_c AS DOUBLE))
      comment: "Average preheat temperature applied. Preheat compliance is a critical weld procedure parameter affecting structural integrity."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`quality_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality audit performance metrics tracking audit findings, corrective action rates, and audit programme effectiveness. Quality audits provide independent assurance of the quality management system."
  source: "`vibe_construction_v1`.`quality`.`quality_audit`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project context for quality audits — enables project-level audit performance analysis."
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit (Internal, External, Certification, Surveillance) — determines audit scope and authority."
    - name: "audit_status"
      expr: audit_status
      comment: "Current status of the audit (Planned, In Progress, Closed) — tracks audit programme execution."
    - name: "certification_standard"
      expr: certification_standard
      comment: "Certification standard audited against (ISO 9001, etc.) — links audits to regulatory and contractual requirements."
    - name: "auditee_department"
      expr: auditee_department
      comment: "Department being audited — enables department-level quality performance analysis."
    - name: "audit_date"
      expr: audit_date
      comment: "Date of the audit — used for audit programme frequency and trend analysis."
    - name: "follow_up_audit_required"
      expr: follow_up_audit_required
      comment: "Flag indicating a follow-up audit is required — indicates unresolved findings requiring re-verification."
  measures:
    - name: "total_audits"
      expr: COUNT(1)
      comment: "Total number of quality audits conducted. Baseline audit programme volume metric."
    - name: "closed_audits"
      expr: COUNT(CASE WHEN audit_status = 'Closed' THEN 1 END)
      comment: "Number of closed audits. Measures audit programme completion and finding resolution."
    - name: "audit_closure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN audit_status = 'Closed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits closed. Low closure rates indicate unresolved quality system findings."
    - name: "total_car_raised"
      expr: SUM(CAST(car_raised_count AS DOUBLE))
      comment: "Total corrective action requests raised across all audits. Measures the volume of quality system deficiencies identified."
    - name: "total_major_nc"
      expr: SUM(CAST(major_nc_count AS DOUBLE))
      comment: "Total major non-conformances identified in audits. Major NCs represent significant quality system failures requiring urgent corrective action."
    - name: "total_minor_nc"
      expr: SUM(CAST(minor_nc_count AS DOUBLE))
      comment: "Total minor non-conformances identified in audits. Tracks the volume of lower-severity quality system gaps."
    - name: "follow_up_required_count"
      expr: COUNT(CASE WHEN follow_up_audit_required = TRUE THEN 1 END)
      comment: "Number of audits requiring follow-up. High follow-up rates indicate persistent quality system non-compliance."
    - name: "avg_audit_duration_hours"
      expr: AVG(CAST(duration_hours AS DOUBLE))
      comment: "Average audit duration in hours. Used for audit resource planning and programme scheduling."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`quality_concrete_pour_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Concrete pour quality metrics tracking pour volumes, slump test compliance, NCR rates, and curing performance. Concrete quality is a critical structural integrity indicator with direct safety and regulatory implications."
  source: "`vibe_construction_v1`.`quality`.`concrete_pour_record`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project context for concrete pour quality analysis."
    - name: "pour_status"
      expr: pour_status
      comment: "Status of the concrete pour (Completed, In Progress, On Hold) — tracks pour programme execution."
    - name: "acceptance_status"
      expr: acceptance_status
      comment: "Acceptance status of the pour — primary concrete quality outcome indicator."
    - name: "concrete_grade"
      expr: concrete_grade
      comment: "Concrete grade/mix design — enables grade-level quality performance analysis."
    - name: "element_type"
      expr: element_type
      comment: "Structural element type being poured (Column, Slab, Beam) — enables element-type quality benchmarking."
    - name: "slump_test_passed"
      expr: slump_test_passed
      comment: "Flag indicating slump test passed — slump compliance is a critical fresh concrete quality indicator."
    - name: "ncr_raised"
      expr: ncr_raised
      comment: "Flag indicating an NCR was raised for this pour — links concrete quality to formal non-conformance management."
    - name: "pour_date"
      expr: pour_date
      comment: "Date of the concrete pour — used for trend analysis and seasonal quality monitoring."
    - name: "wbs_element_id"
      expr: wbs_element_id
      comment: "WBS element for the pour — enables cost-area concrete quality analysis."
  measures:
    - name: "total_pours"
      expr: COUNT(1)
      comment: "Total number of concrete pours. Baseline concrete production volume metric."
    - name: "total_pour_volume_m3"
      expr: SUM(CAST(total_pour_volume_m3 AS DOUBLE))
      comment: "Total concrete volume poured in cubic metres. Primary concrete production progress metric for project tracking."
    - name: "avg_pour_volume_m3"
      expr: AVG(CAST(total_pour_volume_m3 AS DOUBLE))
      comment: "Average pour volume per pour event. Used for pour planning and resource scheduling."
    - name: "slump_test_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN slump_test_passed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of pours passing slump test. Critical fresh concrete quality KPI — failures indicate mix design or delivery issues."
    - name: "ncr_raised_count"
      expr: COUNT(CASE WHEN ncr_raised = TRUE THEN 1 END)
      comment: "Number of pours that raised an NCR. Measures the rate of concrete quality non-conformances."
    - name: "ncr_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN ncr_raised = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of pours resulting in an NCR. High NCR rates indicate systemic concrete quality issues."
    - name: "avg_concrete_temperature_c"
      expr: AVG(CAST(concrete_temperature_c AS DOUBLE))
      comment: "Average concrete temperature at time of pour. Temperature compliance is a critical quality parameter for concrete strength development."
    - name: "avg_ambient_temperature_c"
      expr: AVG(CAST(ambient_temperature_c AS DOUBLE))
      comment: "Average ambient temperature during pours. Extreme temperatures affect concrete curing and require special measures."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`quality_ndt_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Non-Destructive Testing (NDT) metrics tracking test acceptance rates, repair requirements, and technician certification compliance. NDT is a critical quality assurance activity for structural and pressure-containing components."
  source: "`vibe_construction_v1`.`quality`.`ndt_record`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project context for NDT analysis — enables project-level NDT performance benchmarking."
    - name: "ndt_method"
      expr: ndt_method
      comment: "NDT method used (RT, UT, MT, PT, VT) — enables method-specific quality analysis."
    - name: "acceptance_status"
      expr: acceptance_status
      comment: "Acceptance status of the NDT result — primary NDT quality outcome indicator."
    - name: "test_status"
      expr: test_status
      comment: "Current status of the NDT test (Pending, Complete, Rejected)."
    - name: "repair_required"
      expr: repair_required
      comment: "Flag indicating repair is required based on NDT findings — directly impacts schedule and cost."
    - name: "ncr_raised"
      expr: ncr_raised
      comment: "Flag indicating an NCR was raised from this NDT result — links NDT failures to formal quality management."
    - name: "test_date"
      expr: test_date
      comment: "Date of NDT test — used for trend analysis and testing programme tracking."
    - name: "wbs_element_id"
      expr: wbs_element_id
      comment: "WBS element for the NDT test — enables cost-area NDT quality analysis."
  measures:
    - name: "total_ndt_tests"
      expr: COUNT(1)
      comment: "Total number of NDT tests conducted. Baseline NDT programme volume metric."
    - name: "accepted_ndt_tests"
      expr: COUNT(CASE WHEN acceptance_status = 'Accepted' THEN 1 END)
      comment: "Number of NDT tests with accepted results. Core NDT quality throughput indicator."
    - name: "ndt_acceptance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN acceptance_status = 'Accepted' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of NDT tests accepted. Primary NDT quality KPI — low acceptance rates indicate structural quality issues."
    - name: "repair_required_count"
      expr: COUNT(CASE WHEN repair_required = TRUE THEN 1 END)
      comment: "Number of NDT tests requiring repair. Repair requirements directly impact schedule and cost."
    - name: "repair_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN repair_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of NDT tests requiring repair. High repair rates indicate systemic workmanship quality issues."
    - name: "ncr_raised_count"
      expr: COUNT(CASE WHEN ncr_raised = TRUE THEN 1 END)
      comment: "Number of NDT tests that raised an NCR. Measures the formal non-conformance rate from NDT activities."
    - name: "retest_required_count"
      expr: COUNT(CASE WHEN retest_required = TRUE THEN 1 END)
      comment: "Number of NDT tests requiring retest. Retest requirements increase testing cost and programme duration."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`quality_acceptance_test`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Acceptance test metrics tracking equipment and system commissioning quality, test pass rates, and retest requirements. Acceptance tests are the final quality gate before equipment and systems are handed over to the client."
  source: "`vibe_construction_v1`.`quality`.`acceptance_test`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project context for acceptance testing — enables project-level commissioning quality analysis."
    - name: "test_status"
      expr: test_status
      comment: "Current status of the acceptance test (Pending, In Progress, Passed, Failed)."
    - name: "acceptance_status"
      expr: acceptance_status
      comment: "Final acceptance status — primary commissioning quality outcome indicator."
    - name: "test_type"
      expr: test_type
      comment: "Type of acceptance test (FAT, SAT, Commissioning, Performance) — enables test-type quality benchmarking."
    - name: "test_result"
      expr: test_result
      comment: "Result of the acceptance test — links test execution to quality outcomes."
    - name: "retest_required"
      expr: retest_required
      comment: "Flag indicating retest is required — retest rates measure first-pass commissioning quality."
    - name: "test_date"
      expr: test_date
      comment: "Date of the acceptance test — used for commissioning programme trend analysis."
    - name: "wbs_element_id"
      expr: wbs_element_id
      comment: "WBS element for the acceptance test — enables cost-area commissioning quality analysis."
  measures:
    - name: "total_acceptance_tests"
      expr: COUNT(1)
      comment: "Total number of acceptance tests conducted. Baseline commissioning programme volume metric."
    - name: "passed_acceptance_tests"
      expr: COUNT(CASE WHEN acceptance_status = 'Accepted' THEN 1 END)
      comment: "Number of acceptance tests passed. Core commissioning quality throughput indicator."
    - name: "acceptance_test_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN acceptance_status = 'Accepted' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of acceptance tests passed. Primary commissioning quality KPI for project handover readiness."
    - name: "retest_required_count"
      expr: COUNT(CASE WHEN retest_required = TRUE THEN 1 END)
      comment: "Number of acceptance tests requiring retest. High retest rates indicate commissioning quality issues and schedule risk."
    - name: "retest_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN retest_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of acceptance tests requiring retest. Measures first-pass commissioning quality — high rates delay handover."
    - name: "avg_test_duration_hours"
      expr: AVG(CAST(test_duration_hours AS DOUBLE))
      comment: "Average acceptance test duration in hours. Used for commissioning programme scheduling and resource planning."
    - name: "corrective_action_required_count"
      expr: COUNT(CASE WHEN corrective_action_required IS NOT NULL AND corrective_action_required != '' THEN 1 END)
      comment: "Number of acceptance tests requiring corrective action. Measures the volume of commissioning deficiencies requiring resolution."
$$;