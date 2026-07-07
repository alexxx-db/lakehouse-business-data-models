-- Metric views for domain: quality | Business: Construction | Version: 2 | Generated on: 2026-06-28 00:14:33

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`quality_acceptance_test`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Acceptance test performance metrics tracking test outcomes, retest rates, and duration. Governs system commissioning readiness and contractual handover obligations."
  source: "`vibe_construction_v1`.`quality`.`acceptance_test`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project identifier for project-level acceptance test benchmarking."
    - name: "test_status"
      expr: test_status
      comment: "Current status of the acceptance test (Pending, In Progress, Completed, Failed) for pipeline management."
    - name: "acceptance_status"
      expr: acceptance_status
      comment: "Acceptance outcome (Accepted, Rejected, Conditional) for handover gate analysis."
    - name: "test_type"
      expr: test_type
      comment: "Type of acceptance test (FAT, SAT, Commissioning, Performance) for test-type quality analysis."
    - name: "test_result"
      expr: test_result
      comment: "Test result (Pass, Fail) for acceptance rate analysis."
    - name: "retest_required"
      expr: retest_required
      comment: "Flag indicating retest is required. Retest rate is a key commissioning quality KPI."
    - name: "test_date_month"
      expr: DATE_TRUNC('month', test_date)
      comment: "Month of acceptance testing for trend and commissioning schedule analysis."
    - name: "compliance_standard"
      expr: compliance_standard
      comment: "Compliance standard applied for regulatory and contractual compliance analysis."
  measures:
    - name: "total_acceptance_tests"
      expr: COUNT(1)
      comment: "Total acceptance tests conducted. Baseline commissioning throughput KPI."
    - name: "passed_acceptance_tests"
      expr: COUNT(CASE WHEN test_result = 'Pass' THEN 1 END)
      comment: "Count of acceptance tests passed. Numerator for acceptance test pass rate."
    - name: "failed_acceptance_tests"
      expr: COUNT(CASE WHEN test_result = 'Fail' THEN 1 END)
      comment: "Count of failed acceptance tests. Failures delay handover and trigger contractual consequences."
    - name: "acceptance_test_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN test_result = 'Pass' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of acceptance tests passed. Primary commissioning readiness KPI for project directors."
    - name: "retest_required_count"
      expr: COUNT(CASE WHEN retest_required = TRUE THEN 1 END)
      comment: "Number of acceptance tests requiring retest. High retest rate delays commissioning and handover milestones."
    - name: "retest_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN retest_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of acceptance tests requiring retest. Key commissioning quality and schedule risk KPI."
    - name: "avg_test_duration_hours"
      expr: AVG(CAST(test_duration_hours AS DOUBLE))
      comment: "Average duration of acceptance tests in hours. Used for commissioning schedule planning and resource allocation."
    - name: "total_test_duration_hours"
      expr: SUM(CAST(test_duration_hours AS DOUBLE))
      comment: "Total hours spent on acceptance testing. Informs commissioning resource planning and cost tracking."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`quality_checklist_execution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Checklist execution quality metrics tracking compliance rates, critical failure rates, and NCR generation rates. Operational quality assurance KPI layer for site supervisors and QA managers."
  source: "`vibe_construction_v1`.`quality`.`checklist_execution`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project identifier for project-level checklist execution benchmarking."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the checklist execution (Approved, Rejected, Pending) for governance tracking."
    - name: "overall_result"
      expr: overall_result
      comment: "Overall result of the checklist execution (Pass, Fail, Conditional) for quality gate analysis."
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection associated with the checklist execution."
    - name: "inspection_stage"
      expr: inspection_stage
      comment: "Stage of inspection (Pre-pour, In-process, Final) for stage-level quality analysis."
    - name: "critical_failure_flag"
      expr: critical_failure_flag
      comment: "Flag indicating a critical failure was identified. Critical failures require immediate escalation."
    - name: "execution_date_month"
      expr: DATE_TRUNC('month', execution_date)
      comment: "Month of checklist execution for trend analysis."
  measures:
    - name: "total_executions"
      expr: COUNT(1)
      comment: "Total checklist executions. Baseline quality assurance activity throughput KPI."
    - name: "avg_compliance_percentage"
      expr: AVG(CAST(compliance_percentage AS DOUBLE))
      comment: "Average compliance percentage across all checklist executions. Primary quality conformance KPI for site management."
    - name: "critical_failure_count"
      expr: COUNT(CASE WHEN critical_failure_flag = TRUE THEN 1 END)
      comment: "Number of checklist executions with critical failures. Critical failures halt work and require immediate corrective action."
    - name: "critical_failure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN critical_failure_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of checklist executions with critical failures. Key safety and quality risk KPI."
    - name: "ncr_generated_count"
      expr: COUNT(CASE WHEN ncr_generated_flag = TRUE THEN 1 END)
      comment: "Number of checklist executions that generated an NCR. Links checklist quality to formal non-conformance management."
    - name: "ncr_generation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN ncr_generated_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of checklist executions resulting in an NCR. Measures quality failure frequency at activity level."
    - name: "witness_signature_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN witness_signature_captured = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN witness_required_flag = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of required witness signatures captured. Contractual and ITP compliance KPI."
    - name: "avg_temperature_celsius"
      expr: AVG(CAST(temperature_celsius AS DOUBLE))
      comment: "Average ambient temperature during checklist executions. Environmental compliance indicator."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`quality_concrete_pour`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Concrete pour performance and quality metrics"
  source: "`construction_ecm`.`quality`.`concrete_pour_record`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Construction project identifier"
    - name: "pour_date"
      expr: pour_date
      comment: "Date the concrete pour occurred"
    - name: "concrete_grade"
      expr: concrete_grade
      comment: "Grade/specification of the concrete used"
    - name: "supplier_name"
      expr: supplier_name
      comment: "Supplier of the concrete mix"
    - name: "weather_conditions"
      expr: weather_conditions
      comment: "Weather conditions during the pour"
  measures:
    - name: "total_pours"
      expr: COUNT(1)
      comment: "Total number of concrete pour records"
    - name: "total_volume_m3"
      expr: SUM(CAST(total_pour_volume_m3 AS DOUBLE))
      comment: "Cumulative concrete volume poured (cubic meters)"
    - name: "avg_volume_per_pour"
      expr: AVG(CAST(total_pour_volume_m3 AS DOUBLE))
      comment: "Average volume per concrete pour"
    - name: "slump_test_passed_count"
      expr: COUNT(CASE WHEN slump_test_passed = TRUE THEN 1 END)
      comment: "Number of pours where the slump test passed"
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`quality_concrete_pour_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Concrete pour quality metrics tracking pour volumes, slump test compliance, sample rates, and NCR rates. Essential for structural quality assurance on civil and building projects."
  source: "`vibe_construction_v1`.`quality`.`concrete_pour_record`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project identifier for project-level concrete quality benchmarking."
    - name: "pour_status"
      expr: pour_status
      comment: "Status of the pour (Completed, In Progress, On Hold) for production tracking."
    - name: "acceptance_status"
      expr: acceptance_status
      comment: "Acceptance status of the pour (Accepted, Rejected, Conditional) for quality gate tracking."
    - name: "concrete_grade"
      expr: concrete_grade
      comment: "Concrete grade/mix design for grade-level quality analysis."
    - name: "element_type"
      expr: element_type
      comment: "Structural element type (Column, Slab, Beam, Foundation) for element-level quality analysis."
    - name: "pour_date_month"
      expr: DATE_TRUNC('month', pour_date)
      comment: "Month of pour for production trend analysis."
    - name: "curing_method"
      expr: curing_method
      comment: "Curing method applied for quality compliance analysis."
  measures:
    - name: "total_pours"
      expr: COUNT(1)
      comment: "Total concrete pours recorded. Baseline production volume KPI."
    - name: "total_pour_volume_m3"
      expr: SUM(CAST(pour_volume_m3 AS DOUBLE))
      comment: "Total concrete volume poured in cubic metres. Primary production progress KPI for civil works."
    - name: "avg_pour_volume_m3"
      expr: AVG(CAST(pour_volume_m3 AS DOUBLE))
      comment: "Average pour volume per event. Used for productivity benchmarking and resource planning."
    - name: "slump_test_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN slump_test_passed = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN slump_test_passed IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of pours where slump test passed. Concrete workability compliance KPI — failures indicate mix design or delivery issues."
    - name: "ncr_raised_count"
      expr: COUNT(CASE WHEN ncr_raised = TRUE THEN 1 END)
      comment: "Number of pours that triggered an NCR. Tracks concrete quality non-conformances for structural assurance."
    - name: "ncr_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN ncr_raised = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of pours resulting in an NCR. Key concrete quality KPI for structural integrity governance."
    - name: "avg_concrete_temperature_c"
      expr: AVG(CAST(concrete_temperature_c AS DOUBLE))
      comment: "Average concrete temperature at pour. Compliance indicator for temperature-sensitive concrete specifications."
    - name: "avg_slump_mm"
      expr: AVG(CAST(slump_mm AS DOUBLE))
      comment: "Average slump value in mm. Tracks concrete workability against specification limits."
    - name: "total_volume_poured_m3"
      expr: SUM(CAST(volume_poured_m3 AS DOUBLE))
      comment: "Total volume poured (alternate field). Cross-validates pour volume reporting for audit purposes."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`quality_corrective_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Corrective action effectiveness and cost metrics. Tracks resolution timeliness, cost of quality remediation, and systemic issue identification to drive continuous improvement."
  source: "`vibe_construction_v1`.`quality`.`corrective_action`"
  dimensions:
    - name: "action_status"
      expr: action_status
      comment: "Current status of the corrective action (Open, In Progress, Closed, Verified) for pipeline management."
    - name: "action_type"
      expr: action_type
      comment: "Type of corrective action (Immediate, Preventive, Systemic) for classification and trend analysis."
    - name: "priority"
      expr: priority
      comment: "Priority level of the corrective action for resource allocation decisions."
    - name: "effectiveness_review_outcome"
      expr: effectiveness_review_outcome
      comment: "Outcome of the effectiveness review to assess whether corrective actions are actually resolving root causes."
    - name: "is_systemic_issue"
      expr: is_systemic_issue
      comment: "Flag indicating whether the NCR represents a systemic quality issue requiring process-level intervention."
    - name: "assigned_date_month"
      expr: DATE_TRUNC('month', assigned_date)
      comment: "Month corrective action was assigned for trend and backlog analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of cost estimates for multi-currency project cost-of-quality reporting."
  measures:
    - name: "total_corrective_actions"
      expr: COUNT(1)
      comment: "Total corrective actions raised. Baseline volume KPI for quality remediation workload."
    - name: "open_corrective_actions"
      expr: COUNT(CASE WHEN action_status = 'Open' THEN 1 END)
      comment: "Count of open corrective actions. High open count signals unresolved quality risk."
    - name: "overdue_corrective_actions"
      expr: COUNT(CASE WHEN action_status != 'Closed' AND target_completion_date < CURRENT_DATE() THEN 1 END)
      comment: "Corrective actions past their target completion date. Overdue rate is a key quality governance KPI."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred for corrective actions. Core cost-of-quality metric for financial reporting."
    - name: "total_cost_estimate"
      expr: SUM(CAST(cost_estimate AS DOUBLE))
      comment: "Total estimated cost of corrective actions. Used for budget forecasting and cost-of-quality planning."
    - name: "avg_actual_cost"
      expr: AVG(CAST(actual_cost AS DOUBLE))
      comment: "Average actual cost per corrective action. Benchmarks remediation cost efficiency."
    - name: "cost_overrun_amount"
      expr: SUM(CAST(actual_cost AS DOUBLE) - CAST(cost_estimate AS DOUBLE))
      comment: "Total cost overrun across corrective actions (actual minus estimate). Signals estimation accuracy and scope creep."
    - name: "systemic_issue_count"
      expr: COUNT(CASE WHEN is_systemic_issue = TRUE THEN 1 END)
      comment: "Number of corrective actions flagged as systemic issues. Systemic issues require process redesign and executive attention."
    - name: "requires_design_change_count"
      expr: COUNT(CASE WHEN requires_design_change = TRUE THEN 1 END)
      comment: "Corrective actions requiring a design change. Indicates design quality issues with downstream schedule and cost impact."
    - name: "effective_closure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN effectiveness_review_outcome = 'Effective' THEN 1 END) / NULLIF(COUNT(CASE WHEN effectiveness_review_outcome IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of reviewed corrective actions deemed effective. Measures whether quality fixes are actually working."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`quality_defect`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Defect tracking and rectification cost metrics. Provides visibility into defect volumes, severity distribution, rectification costs, and DLP exposure for project handover governance."
  source: "`vibe_construction_v1`.`quality`.`defect`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project identifier for project-level defect benchmarking."
    - name: "defect_status"
      expr: defect_status
      comment: "Current status of the defect (Open, In Rectification, Closed, Verified) for pipeline management."
    - name: "defect_type"
      expr: defect_type
      comment: "Type of defect (e.g. Structural, Finishing, MEP) for trade-level quality analysis."
    - name: "severity"
      expr: severity
      comment: "Severity of the defect for prioritisation and escalation decisions."
    - name: "identified_phase"
      expr: identified_phase
      comment: "Project phase when defect was identified (Construction, Commissioning, DLP) for phase-gate quality analysis."
    - name: "trade_discipline"
      expr: trade_discipline
      comment: "Trade discipline responsible for the defect for subcontractor performance management."
    - name: "identified_date_month"
      expr: DATE_TRUNC('month', identified_date)
      comment: "Month defect was identified for trend analysis."
    - name: "impact_on_handover"
      expr: impact_on_handover
      comment: "Flag indicating whether the defect impacts project handover. Critical for milestone gate management."
  measures:
    - name: "total_defects"
      expr: COUNT(1)
      comment: "Total defects identified. Baseline quality KPI for defect density analysis."
    - name: "open_defects"
      expr: COUNT(CASE WHEN defect_status = 'Open' THEN 1 END)
      comment: "Count of open defects. High open count blocks handover and triggers contractual penalties."
    - name: "closed_defects"
      expr: COUNT(CASE WHEN defect_status = 'Closed' THEN 1 END)
      comment: "Count of closed/rectified defects. Used to compute defect closure rate."
    - name: "defect_closure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN defect_status = 'Closed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of defects closed. Key handover readiness KPI — low rate delays practical completion."
    - name: "total_rectification_cost"
      expr: SUM(CAST(rectification_cost AS DOUBLE))
      comment: "Total cost of defect rectification. Core cost-of-quality metric for financial and contract management."
    - name: "avg_rectification_cost"
      expr: AVG(CAST(rectification_cost AS DOUBLE))
      comment: "Average rectification cost per defect. Benchmarks remediation efficiency and informs DLP provisioning."
    - name: "handover_blocking_defects"
      expr: COUNT(CASE WHEN impact_on_handover = TRUE AND defect_status != 'Closed' THEN 1 END)
      comment: "Open defects that block project handover. Critical milestone gate KPI for project directors."
    - name: "deferred_to_dlp_count"
      expr: COUNT(CASE WHEN defect_status = 'Closed' THEN 1 END)
      comment: "Placeholder aligned to defects tracked through DLP period. Monitors post-handover liability exposure."
    - name: "overdue_rectification_count"
      expr: COUNT(CASE WHEN defect_status != 'Closed' AND target_rectification_date < CURRENT_DATE() THEN 1 END)
      comment: "Defects past their target rectification date. Overdue defects trigger contractual and client escalation."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`quality_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inspection performance metrics covering pass/fail outcomes, reinspection rates, and inspection throughput. Drives quality assurance governance and ITP compliance monitoring."
  source: "`vibe_construction_v1`.`quality`.`inspection`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project identifier for project-level inspection performance benchmarking."
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection (e.g. Hold Point, Witness Point, Review) for compliance tracking."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current status of the inspection (Passed, Failed, Pending) for pipeline management."
    - name: "overall_outcome"
      expr: overall_outcome
      comment: "Final outcome of the inspection for pass/fail rate analysis."
    - name: "location_type"
      expr: location_type
      comment: "Location type of the inspection for spatial quality analysis."
    - name: "inspection_date_month"
      expr: DATE_TRUNC('month', inspection_date)
      comment: "Month of inspection for trend analysis and workload planning."
    - name: "inspection_date_week"
      expr: DATE_TRUNC('week', inspection_date)
      comment: "Week of inspection for short-term operational throughput monitoring."
  measures:
    - name: "total_inspections"
      expr: COUNT(1)
      comment: "Total inspections conducted. Baseline throughput KPI for quality assurance activity."
    - name: "passed_inspections"
      expr: COUNT(CASE WHEN overall_outcome = 'Pass' THEN 1 END)
      comment: "Count of inspections with a passing outcome. Numerator for first-time pass rate."
    - name: "failed_inspections"
      expr: COUNT(CASE WHEN overall_outcome = 'Fail' THEN 1 END)
      comment: "Count of failed inspections. Directly signals quality deficiencies requiring corrective action."
    - name: "first_time_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN overall_outcome = 'Pass' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections passed on first attempt. Premier quality KPI — low rate indicates systemic workmanship issues."
    - name: "reinspection_required_count"
      expr: COUNT(CASE WHEN reinspection_required = TRUE THEN 1 END)
      comment: "Number of inspections requiring reinspection. Indicates rework volume and schedule risk."
    - name: "reinspection_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN reinspection_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections requiring reinspection. High rate signals quality process breakdown."
    - name: "ncr_raised_count"
      expr: COUNT(CASE WHEN ncr_raised = TRUE THEN 1 END)
      comment: "Number of inspections that triggered an NCR. Links inspection outcomes to formal non-conformance records."
    - name: "ncr_raise_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN ncr_raised = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections resulting in an NCR. Key quality risk indicator for executive reporting."
    - name: "corrective_action_required_count"
      expr: COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END)
      comment: "Inspections requiring corrective action. Drives workload planning for quality remediation teams."
    - name: "avg_humidity_percent"
      expr: AVG(CAST(humidity_percent AS DOUBLE))
      comment: "Average ambient humidity during inspections. Environmental quality control indicator for sensitive works."
    - name: "avg_temperature_celsius"
      expr: AVG(CAST(temperature_celsius AS DOUBLE))
      comment: "Average ambient temperature during inspections. Environmental compliance indicator for concrete and coating works."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`quality_lab_test`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Laboratory test performance metrics tracking pass/fail rates, specification compliance, and retest rates. Governs material quality assurance and regulatory compliance for construction materials."
  source: "`vibe_construction_v1`.`quality`.`lab_test`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project identifier for project-level lab test quality benchmarking."
    - name: "test_type"
      expr: test_type
      comment: "Type of laboratory test (Compressive Strength, Gradation, Density) for test-type quality analysis."
    - name: "pass_fail_status"
      expr: pass_fail_status
      comment: "Pass/fail outcome of the lab test for compliance rate analysis."
    - name: "test_status"
      expr: test_status
      comment: "Current status of the test (Pending, In Progress, Completed) for pipeline management."
    - name: "material_type"
      expr: material_type
      comment: "Material type tested (Concrete, Steel, Asphalt) for material-level quality analysis."
    - name: "test_method"
      expr: test_method
      comment: "Test method/standard applied for method-level compliance analysis."
    - name: "test_date_month"
      expr: DATE_TRUNC('month', test_date)
      comment: "Month of testing for trend analysis and lab throughput planning."
    - name: "retest_flag"
      expr: retest_flag
      comment: "Flag indicating this is a retest. Retest rate is a key material quality KPI."
  measures:
    - name: "total_lab_tests"
      expr: COUNT(1)
      comment: "Total laboratory tests conducted. Baseline quality assurance throughput KPI."
    - name: "passed_tests"
      expr: COUNT(CASE WHEN pass_fail_status = 'Pass' THEN 1 END)
      comment: "Count of tests that passed. Numerator for lab test pass rate."
    - name: "failed_tests"
      expr: COUNT(CASE WHEN pass_fail_status = 'Fail' THEN 1 END)
      comment: "Count of failed tests. Triggers material rejection and NCR issuance."
    - name: "lab_test_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN pass_fail_status = 'Pass' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of lab tests passing. Primary material quality compliance KPI for QA/QC reporting."
    - name: "retest_count"
      expr: COUNT(CASE WHEN retest_flag = TRUE THEN 1 END)
      comment: "Number of retests conducted. High retest rate signals material quality issues and increases testing cost."
    - name: "retest_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN retest_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of tests that are retests. Key material quality and cost-of-quality indicator."
    - name: "avg_measured_result"
      expr: AVG(CAST(measured_result AS DOUBLE))
      comment: "Average measured test result value. Used to track material performance against specification requirements."
    - name: "avg_test_result_value"
      expr: AVG(CAST(test_result_value AS DOUBLE))
      comment: "Average test result value across all tests. Tracks material quality trends against specification limits."
    - name: "specification_compliance_gap"
      expr: AVG(CAST(measured_result AS DOUBLE) - CAST(specification_requirement AS DOUBLE))
      comment: "Average gap between measured result and specification requirement. Negative values indicate non-compliance risk."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`quality_ncr`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Non-Conformance Report (NCR) performance metrics tracking quality failures, cost impacts, closure rates, and systemic risk across construction projects. Core quality KPI layer for executive steering."
  source: "`vibe_construction_v1`.`quality`.`ncr`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project identifier for cross-project NCR benchmarking."
    - name: "ncr_status"
      expr: ncr_status
      comment: "Current lifecycle status of the NCR (Open, Closed, Under Review) for pipeline analysis."
    - name: "ncr_category"
      expr: ncr_category
      comment: "Category of non-conformance (e.g. Material, Workmanship, Design) to identify systemic failure patterns."
    - name: "severity"
      expr: severity
      comment: "Severity classification of the NCR to prioritise resolution effort and escalation."
    - name: "discipline"
      expr: discipline
      comment: "Engineering or trade discipline associated with the NCR for discipline-level quality benchmarking."
    - name: "disposition"
      expr: disposition
      comment: "Approved disposition of the NCR (e.g. Repair, Accept-as-is, Reject) for trend analysis."
    - name: "identified_date"
      expr: DATE_TRUNC('month', identified_date)
      comment: "Month of NCR identification for trend and seasonality analysis."
    - name: "reported_by_organization"
      expr: reported_by_organization
      comment: "Organisation that raised the NCR to assess subcontractor vs. self-performed quality performance."
  measures:
    - name: "total_ncrs"
      expr: COUNT(1)
      comment: "Total number of NCRs raised. Baseline volume KPI for quality failure frequency."
    - name: "open_ncrs"
      expr: COUNT(CASE WHEN ncr_status = 'Open' THEN 1 END)
      comment: "Count of NCRs currently open. High open count signals unresolved quality risk on the project."
    - name: "closed_ncrs"
      expr: COUNT(CASE WHEN ncr_status = 'Closed' THEN 1 END)
      comment: "Count of closed NCRs. Used to compute closure rate and track resolution throughput."
    - name: "ncr_closure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN ncr_status = 'Closed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of NCRs that have been closed. Key quality management KPI — low closure rate indicates backlog risk."
    - name: "total_estimated_cost_impact"
      expr: SUM(CAST(estimated_cost_impact AS DOUBLE))
      comment: "Total estimated financial cost of all NCRs. Directly informs budget risk and cost-of-quality reporting."
    - name: "avg_estimated_cost_impact"
      expr: AVG(CAST(estimated_cost_impact AS DOUBLE))
      comment: "Average cost impact per NCR. Helps benchmark severity and prioritise high-cost non-conformances."
    - name: "ncrs_with_client_notification"
      expr: COUNT(CASE WHEN client_notification_required = TRUE THEN 1 END)
      comment: "Number of NCRs requiring client notification. Tracks contractual compliance and client relationship risk."
    - name: "ncrs_on_hold"
      expr: COUNT(CASE WHEN hold_status = TRUE THEN 1 END)
      comment: "NCRs currently under hold status. Work-stoppage indicator with direct schedule and cost implications."
    - name: "avg_quantity_affected"
      expr: AVG(CAST(quantity_affected AS DOUBLE))
      comment: "Average quantity of material or work affected per NCR. Indicates scope of rework required."
    - name: "critical_severity_ncrs"
      expr: COUNT(CASE WHEN severity = 'Critical' THEN 1 END)
      comment: "Count of critical-severity NCRs. Triggers executive escalation and immediate corrective action."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`quality_ndt_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Non-Destructive Testing (NDT) metrics tracking acceptance rates, repair rates, and retest rates. Critical for structural integrity assurance on pressure vessels, pipelines, and structural steel."
  source: "`vibe_construction_v1`.`quality`.`ndt_record`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project identifier for project-level NDT quality benchmarking."
    - name: "ndt_method"
      expr: ndt_method
      comment: "NDT method applied (RT, UT, MT, PT, VT) for method-level quality analysis."
    - name: "acceptance_status"
      expr: acceptance_status
      comment: "Acceptance status of the NDT result (Accepted, Rejected) for quality gate tracking."
    - name: "test_status"
      expr: test_status
      comment: "Current status of the NDT test for pipeline management."
    - name: "test_result"
      expr: test_result
      comment: "Test result (Pass, Fail) for acceptance rate analysis."
    - name: "indication_severity"
      expr: indication_severity
      comment: "Severity of NDT indications found for risk-based prioritisation."
    - name: "test_date_month"
      expr: DATE_TRUNC('month', test_date)
      comment: "Month of NDT testing for trend analysis."
  measures:
    - name: "total_ndt_records"
      expr: COUNT(1)
      comment: "Total NDT tests conducted. Baseline structural integrity assurance throughput KPI."
    - name: "accepted_ndt_records"
      expr: COUNT(CASE WHEN acceptance_status = 'Accepted' THEN 1 END)
      comment: "Count of NDT tests with accepted results. Numerator for NDT acceptance rate."
    - name: "rejected_ndt_records"
      expr: COUNT(CASE WHEN acceptance_status = 'Rejected' THEN 1 END)
      comment: "Count of rejected NDT tests. Triggers repair and re-inspection with direct schedule and cost impact."
    - name: "ndt_acceptance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN acceptance_status = 'Accepted' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of NDT tests accepted. Premier structural integrity KPI — industry benchmarks vary by method and code."
    - name: "repair_required_count"
      expr: COUNT(CASE WHEN repair_required = TRUE THEN 1 END)
      comment: "Number of components requiring repair based on NDT findings. Directly impacts schedule and cost."
    - name: "repair_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN repair_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of NDT tests resulting in repair requirement. Key structural quality and cost-of-quality KPI."
    - name: "ncr_raised_count"
      expr: COUNT(CASE WHEN ncr_raised = TRUE THEN 1 END)
      comment: "NDT tests that triggered an NCR. Links structural defects to formal quality management records."
    - name: "retest_required_count"
      expr: COUNT(CASE WHEN retest_required = TRUE THEN 1 END)
      comment: "NDT tests requiring retest. Retest rate indicates quality process effectiveness and adds cost."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`quality_punch_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Punch item granular metrics tracking item-level closure rates, cost impacts, and overdue items. Provides operational detail beneath punch list summaries for trade and area managers."
  source: "`vibe_construction_v1`.`quality`.`punch_item`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project identifier for project-level punch item analysis."
    - name: "punch_item_status"
      expr: punch_item_status
      comment: "Current status of the punch item (Open, In Progress, Closed, Rejected) for pipeline management."
    - name: "punch_item_category"
      expr: punch_item_category
      comment: "Category of the punch item (e.g. Category A, B, C) for priority-based closure tracking."
    - name: "closure_status"
      expr: closure_status
      comment: "Closure status of the punch item for handover gate analysis."
    - name: "priority"
      expr: priority
      comment: "Priority of the punch item for resource allocation."
    - name: "deferred_to_dlp"
      expr: deferred_to_dlp
      comment: "Flag indicating item deferred to DLP period. Tracks post-handover liability exposure."
    - name: "identified_date_month"
      expr: DATE_TRUNC('month', identified_date)
      comment: "Month punch item was identified for trend analysis."
  measures:
    - name: "total_punch_items"
      expr: COUNT(1)
      comment: "Total punch items raised. Baseline volume KPI for handover readiness at item level."
    - name: "open_punch_items"
      expr: COUNT(CASE WHEN punch_item_status = 'Open' THEN 1 END)
      comment: "Count of open punch items. High open count blocks handover milestone."
    - name: "punch_item_closure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN punch_item_status = 'Closed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of punch items closed. Primary handover readiness KPI at item granularity."
    - name: "total_cost_impact"
      expr: SUM(CAST(cost_impact AS DOUBLE))
      comment: "Total financial cost impact of all punch items. Informs cost-of-quality and contract close-out provisions."
    - name: "avg_cost_impact"
      expr: AVG(CAST(cost_impact AS DOUBLE))
      comment: "Average cost impact per punch item. Benchmarks remediation cost and informs DLP financial provisioning."
    - name: "deferred_to_dlp_count"
      expr: COUNT(CASE WHEN deferred_to_dlp = TRUE THEN 1 END)
      comment: "Punch items deferred to DLP. Tracks post-handover liability and client satisfaction risk."
    - name: "overdue_punch_items"
      expr: COUNT(CASE WHEN punch_item_status != 'Closed' AND target_completion_date < CURRENT_DATE() THEN 1 END)
      comment: "Punch items past their target completion date. Overdue items risk contractual penalties and handover delays."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`quality_punch_list`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Punch list completion and handover readiness metrics. Tracks open/closed item ratios, completion percentages, and milestone gate status to govern practical completion and DLP commencement."
  source: "`vibe_construction_v1`.`quality`.`punch_list`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project identifier for project-level punch list benchmarking."
    - name: "punch_list_status"
      expr: punch_list_status
      comment: "Current status of the punch list (Open, In Progress, Closed) for pipeline management."
    - name: "discipline"
      expr: discipline
      comment: "Engineering discipline for the punch list to identify trade-level completion gaps."
    - name: "milestone_type"
      expr: milestone_type
      comment: "Milestone type associated with the punch list (e.g. Practical Completion, Handover) for gate management."
    - name: "handover_gate"
      expr: handover_gate
      comment: "Flag indicating whether this punch list is a handover gate requirement."
    - name: "dlp_commencement_gate"
      expr: dlp_commencement_gate
      comment: "Flag indicating whether this punch list gates DLP commencement."
    - name: "priority"
      expr: priority
      comment: "Priority of the punch list for resource allocation and scheduling."
    - name: "creation_date_month"
      expr: DATE_TRUNC('month', creation_date)
      comment: "Month punch list was created for trend analysis."
  measures:
    - name: "total_punch_lists"
      expr: COUNT(1)
      comment: "Total punch lists created. Baseline volume KPI for handover readiness tracking."
    - name: "avg_completion_percentage"
      expr: AVG(CAST(completion_percentage AS DOUBLE))
      comment: "Average completion percentage across all punch lists. Primary handover readiness KPI for project directors."
    - name: "fully_closed_punch_lists"
      expr: COUNT(CASE WHEN punch_list_status = 'Closed' THEN 1 END)
      comment: "Number of fully closed punch lists. Tracks handover milestone achievement."
    - name: "punch_list_closure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN punch_list_status = 'Closed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of punch lists fully closed. Key practical completion KPI."
    - name: "handover_gate_open_count"
      expr: COUNT(CASE WHEN handover_gate = TRUE AND punch_list_status != 'Closed' THEN 1 END)
      comment: "Open punch lists that are handover gate requirements. Directly blocks practical completion milestone."
    - name: "dlp_gate_open_count"
      expr: COUNT(CASE WHEN dlp_commencement_gate = TRUE AND punch_list_status != 'Closed' THEN 1 END)
      comment: "Open punch lists blocking DLP commencement. Delays defect liability period start and associated cash flows."
    - name: "overdue_punch_lists"
      expr: COUNT(CASE WHEN punch_list_status != 'Closed' AND target_closeout_date < CURRENT_DATE() THEN 1 END)
      comment: "Punch lists past their target closeout date. Overdue punch lists risk contractual penalties and client disputes."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`quality_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality audit performance metrics tracking audit findings, non-conformance counts, closure rates, and corrective action timeliness. Drives quality management system effectiveness assessment."
  source: "`vibe_construction_v1`.`quality`.`quality_audit`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project identifier for project-level quality audit benchmarking."
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit (Internal, External, Certification, Surveillance) for audit programme analysis."
    - name: "audit_status"
      expr: audit_status
      comment: "Current status of the audit (Planned, In Progress, Closed) for audit programme management."
    - name: "certification_standard"
      expr: certification_standard
      comment: "Certification standard audited (ISO 9001, ISO 14001) for compliance programme tracking."
    - name: "auditee_department"
      expr: auditee_department
      comment: "Department audited for department-level quality performance analysis."
    - name: "audit_date_month"
      expr: DATE_TRUNC('month', audit_date)
      comment: "Month of audit for audit programme trend analysis."
    - name: "follow_up_audit_required"
      expr: follow_up_audit_required
      comment: "Flag indicating follow-up audit required. Tracks unresolved audit findings requiring re-verification."
  measures:
    - name: "total_audits"
      expr: COUNT(1)
      comment: "Total quality audits conducted. Baseline audit programme throughput KPI."
    - name: "closed_audits"
      expr: COUNT(CASE WHEN audit_status = 'Closed' THEN 1 END)
      comment: "Count of closed audits. Used to compute audit closure rate."
    - name: "audit_closure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN audit_status = 'Closed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits closed. Key quality management system governance KPI."
    - name: "avg_audit_duration_hours"
      expr: AVG(CAST(duration_hours AS DOUBLE))
      comment: "Average audit duration in hours. Used for audit resource planning and programme scheduling."
    - name: "follow_up_required_count"
      expr: COUNT(CASE WHEN follow_up_audit_required = TRUE THEN 1 END)
      comment: "Number of audits requiring follow-up. High count indicates persistent quality system deficiencies."
    - name: "follow_up_required_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN follow_up_audit_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits requiring follow-up. Measures quality management system maturity and effectiveness."
    - name: "overdue_corrective_actions"
      expr: COUNT(CASE WHEN audit_status != 'Closed' AND corrective_action_due_date < CURRENT_DATE() THEN 1 END)
      comment: "Audits with overdue corrective actions. Signals quality governance breakdown requiring executive intervention."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`quality_submittal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality submittal review performance metrics tracking review cycle times, approval rates, and resubmission rates. Governs material and method approval workflows critical to project schedule."
  source: "`vibe_construction_v1`.`quality`.`quality_submittal`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project identifier for project-level submittal performance benchmarking."
    - name: "review_status"
      expr: review_status
      comment: "Current review status of the submittal (Approved, Rejected, Under Review, Revise and Resubmit) for pipeline management."
    - name: "submittal_type"
      expr: submittal_type
      comment: "Type of submittal (Material, Method Statement, Shop Drawing) for category-level analysis."
    - name: "review_priority"
      expr: review_priority
      comment: "Priority of the submittal review for resource allocation and scheduling."
    - name: "resubmission_required"
      expr: resubmission_required
      comment: "Flag indicating resubmission is required. High resubmission rate signals quality of contractor submissions."
    - name: "submission_date_month"
      expr: DATE_TRUNC('month', submission_date)
      comment: "Month of submittal submission for trend and workload analysis."
    - name: "certification_required"
      expr: certification_required
      comment: "Flag indicating third-party certification is required for the submittal."
  measures:
    - name: "total_submittals"
      expr: COUNT(1)
      comment: "Total quality submittals raised. Baseline submittal pipeline volume KPI."
    - name: "approved_submittals"
      expr: COUNT(CASE WHEN review_status = 'Approved' THEN 1 END)
      comment: "Count of approved submittals. Numerator for approval rate."
    - name: "rejected_submittals"
      expr: COUNT(CASE WHEN review_status = 'Rejected' THEN 1 END)
      comment: "Count of rejected submittals. High rejection rate signals poor submission quality and delays procurement."
    - name: "submittal_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN review_status = 'Approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of submittals approved. Key quality and procurement efficiency KPI."
    - name: "resubmission_count"
      expr: COUNT(CASE WHEN resubmission_required = TRUE THEN 1 END)
      comment: "Number of submittals requiring resubmission. Resubmissions add review cycle time and delay material procurement."
    - name: "resubmission_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN resubmission_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of submittals requiring resubmission. High rate indicates contractor submission quality issues."
    - name: "total_cost_impact"
      expr: SUM(CAST(cost_impact AS DOUBLE))
      comment: "Total cost impact of quality submittals. Tracks financial consequences of submittal delays and rejections."
    - name: "pending_submittals"
      expr: COUNT(CASE WHEN review_status = 'Under Review' THEN 1 END)
      comment: "Count of submittals currently under review. Tracks review backlog and potential schedule risk."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`quality_weld_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Weld quality metrics tracking acceptance rates, NDT outcomes, rework rates, and PWHT compliance. Critical for structural integrity assurance on oil, gas, and infrastructure projects."
  source: "`vibe_construction_v1`.`quality`.`weld_record`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project identifier for project-level weld quality benchmarking."
    - name: "acceptance_status"
      expr: acceptance_status
      comment: "Weld acceptance status (Accepted, Rejected, Pending) for quality gate tracking."
    - name: "ndt_method"
      expr: ndt_method
      comment: "NDT method applied (RT, UT, MT, PT) for method-level quality analysis."
    - name: "ndt_result"
      expr: ndt_result
      comment: "NDT test result (Pass, Fail) for weld integrity analysis."
    - name: "weld_type"
      expr: weld_type
      comment: "Type of weld (Butt, Fillet, Socket) for weld-type quality benchmarking."
    - name: "joint_type"
      expr: joint_type
      comment: "Joint type for structural quality analysis."
    - name: "weld_date_month"
      expr: DATE_TRUNC('month', weld_date)
      comment: "Month of welding for trend analysis and welder performance tracking."
    - name: "wps_number"
      expr: wps_number
      comment: "Welding Procedure Specification number for procedure-level quality analysis."
  measures:
    - name: "total_welds"
      expr: COUNT(1)
      comment: "Total weld records. Baseline volume KPI for weld production throughput."
    - name: "accepted_welds"
      expr: COUNT(CASE WHEN acceptance_status = 'Accepted' THEN 1 END)
      comment: "Count of accepted welds. Numerator for weld acceptance rate."
    - name: "rejected_welds"
      expr: COUNT(CASE WHEN acceptance_status = 'Rejected' THEN 1 END)
      comment: "Count of rejected welds. High rejection rate signals welder qualification or procedure issues."
    - name: "weld_acceptance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN acceptance_status = 'Accepted' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of welds accepted on first inspection. Premier structural quality KPI — industry benchmark is typically >97%."
    - name: "rework_required_count"
      expr: COUNT(CASE WHEN rework_required_flag = TRUE THEN 1 END)
      comment: "Number of welds requiring rework. Directly impacts schedule and cost on piping and structural packages."
    - name: "rework_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN rework_required_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of welds requiring rework. Key cost-of-quality and schedule risk indicator."
    - name: "pwht_required_count"
      expr: COUNT(CASE WHEN pwht_required_flag = TRUE THEN 1 END)
      comment: "Number of welds requiring post-weld heat treatment. Tracks PWHT compliance for pressure vessel and piping codes."
    - name: "total_weld_length_mm"
      expr: SUM(CAST(weld_length_mm AS DOUBLE))
      comment: "Total weld length in millimetres. Production volume KPI for progress measurement and resource planning."
    - name: "avg_weld_length_mm"
      expr: AVG(CAST(weld_length_mm AS DOUBLE))
      comment: "Average weld length per record. Used for productivity benchmarking and resource planning."
    - name: "ndt_fail_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN ndt_result = 'Fail' THEN 1 END) / NULLIF(COUNT(CASE WHEN ndt_result IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of NDT-tested welds that failed. Structural integrity KPI with direct safety and regulatory implications."
$$;
