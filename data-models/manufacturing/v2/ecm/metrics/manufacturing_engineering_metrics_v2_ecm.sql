-- Metric views for domain: engineering | Business: Manufacturing | Version: 2 | Generated on: 2026-07-03 05:35:52

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`engineering_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for engineering project portfolio management: budget utilization, schedule adherence, and project health indicators used by engineering leadership to steer R&D investment and resource allocation."
  source: "`vibe_manufacturing_v1`.`engineering`.`engineering_project`"
  dimensions:
    - name: "project_status"
      expr: project_status
      comment: "Current lifecycle status of the engineering project (e.g., Active, On Hold, Completed) for portfolio segmentation."
    - name: "project_type"
      expr: project_type
      comment: "Classification of the project (e.g., New Product Development, Cost Reduction, Platform) for investment mix analysis."
    - name: "priority_level"
      expr: priority_level
      comment: "Business priority assigned to the project (e.g., Critical, High, Medium) for resource prioritization."
    - name: "program_phase"
      expr: program_phase
      comment: "Current APQP/development phase (e.g., Concept, Design, Validation, Launch) for stage-gate tracking."
    - name: "capex_opex_classification"
      expr: capex_opex_classification
      comment: "Financial classification of the project spend (CapEx vs. OpEx) for finance reporting."
    - name: "risk_level"
      expr: risk_level
      comment: "Assessed risk level of the project for risk-weighted portfolio analysis."
    - name: "technology_platform"
      expr: technology_platform
      comment: "Technology platform or product family the project belongs to for platform investment tracking."
    - name: "target_market_segment"
      expr: target_market_segment
      comment: "Target market segment for the project output, enabling market-aligned investment analysis."
    - name: "start_date_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the project started, for cohort and trend analysis of project launches."
    - name: "target_launch_date_quarter"
      expr: DATE_TRUNC('QUARTER', target_launch_date)
      comment: "Quarter of the planned product launch, for pipeline and launch cadence planning."
  measures:
    - name: "active_project_count"
      expr: COUNT(1)
      comment: "Total number of engineering projects in the portfolio. Executives use this to assess R&D pipeline size and capacity loading."
    - name: "total_budget_allocated"
      expr: SUM(CAST(budget_allocated_amount AS DOUBLE))
      comment: "Total engineering budget committed across all projects. Drives investment governance and CapEx/OpEx planning decisions."
    - name: "total_budget_spent"
      expr: SUM(CAST(budget_spent_amount AS DOUBLE))
      comment: "Total engineering spend to date across all projects. Compared against allocated budget to identify over/under-runs."
    - name: "avg_budget_utilization_pct"
      expr: ROUND(100.0 * AVG(CAST(budget_spent_amount AS DOUBLE) / NULLIF(CAST(budget_allocated_amount AS DOUBLE), 0)), 2)
      comment: "Average budget utilization percentage per project. A key efficiency KPI — projects consistently above 100% signal cost overrun risk requiring executive intervention."
    - name: "avg_team_size"
      expr: AVG(CAST(team_size_count AS DOUBLE))
      comment: "Average engineering headcount per project. Used by workforce planning to assess resource intensity and staffing adequacy."
    - name: "ppap_required_project_count"
      expr: SUM(CASE WHEN ppap_required = TRUE THEN 1 ELSE 0 END)
      comment: "Number of projects requiring PPAP submission. Drives quality planning workload and supplier readiness scheduling."
    - name: "dfmea_completed_project_count"
      expr: SUM(CASE WHEN dfmea_completed = TRUE THEN 1 ELSE 0 END)
      comment: "Number of projects with DFMEA completed. A gate-readiness indicator — low completion rates signal design risk exposure."
    - name: "dfmea_completion_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN dfmea_completed = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of projects with DFMEA completed. Executives use this to assess design risk management maturity across the portfolio."
    - name: "avg_eco_count_per_project"
      expr: AVG(CAST(eco_count AS DOUBLE))
      comment: "Average number of Engineering Change Orders per project. High ECO counts indicate design instability and rework cost risk."
    - name: "avg_design_review_count"
      expr: AVG(CAST(design_review_count AS DOUBLE))
      comment: "Average number of design reviews conducted per project. Reflects design governance rigor and stage-gate discipline."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`engineering_eco`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Engineering Change Order (ECO) performance metrics tracking change velocity, cost impact, and approval cycle times. Used by engineering and operations leadership to manage design change risk and ERP/PLM synchronization."
  source: "`vibe_manufacturing_v1`.`engineering`.`eco`"
  dimensions:
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current status of the ECO (e.g., Draft, Submitted, Approved, Implemented, Closed) for pipeline visibility."
    - name: "change_type"
      expr: change_type
      comment: "Type of engineering change (e.g., Design, Process, Material, Documentation) for change category analysis."
    - name: "change_priority"
      expr: change_priority
      comment: "Priority of the change (e.g., Critical, High, Medium, Low) for urgency-based triage."
    - name: "reason_code"
      expr: reason_code
      comment: "Root cause category driving the change (e.g., Customer Request, Quality Issue, Cost Reduction) for Pareto analysis."
    - name: "effectivity_type"
      expr: effectivity_type
      comment: "How the change takes effect (e.g., Immediate, Serial Number, Date-based) for production planning impact."
    - name: "requires_customer_approval"
      expr: requires_customer_approval
      comment: "Flag indicating whether customer sign-off is required, for tracking approval bottlenecks."
    - name: "initiated_date_month"
      expr: DATE_TRUNC('MONTH', initiated_date)
      comment: "Month the ECO was initiated, for change volume trend analysis."
    - name: "effectivity_date_quarter"
      expr: DATE_TRUNC('QUARTER', effectivity_date)
      comment: "Quarter the change becomes effective, for production readiness planning."
  measures:
    - name: "total_eco_count"
      expr: COUNT(1)
      comment: "Total number of Engineering Change Orders. High volumes signal design instability or active product improvement programs."
    - name: "total_cost_impact"
      expr: SUM(CAST(actual_cost_impact AS DOUBLE))
      comment: "Total actual cost impact of all ECOs. A direct measure of engineering change cost burden on the business."
    - name: "total_estimated_cost_impact"
      expr: SUM(CAST(estimated_cost_impact AS DOUBLE))
      comment: "Total estimated cost impact at ECO initiation. Compared against actual to assess change cost estimation accuracy."
    - name: "avg_actual_cost_impact"
      expr: AVG(CAST(actual_cost_impact AS DOUBLE))
      comment: "Average cost impact per ECO. Executives use this to benchmark change cost and identify high-impact change categories."
    - name: "customer_approval_required_count"
      expr: SUM(CASE WHEN requires_customer_approval = TRUE THEN 1 ELSE 0 END)
      comment: "Number of ECOs requiring customer approval. High counts indicate customer-facing change risk and potential delivery delays."
    - name: "customer_approval_received_count"
      expr: SUM(CASE WHEN customer_approval_received = TRUE THEN 1 ELSE 0 END)
      comment: "Number of ECOs where customer approval has been received. Tracks approval pipeline clearance rate."
    - name: "customer_approval_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN customer_approval_received = TRUE THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN requires_customer_approval = TRUE THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of customer-approval-required ECOs that have received approval. Low rates signal customer relationship or change management issues."
    - name: "avg_schedule_impact_days"
      expr: AVG(CAST(actual_schedule_impact_days AS DOUBLE))
      comment: "Average schedule impact in days per ECO. Directly informs program managers of change-driven schedule risk."
    - name: "supplier_notification_required_count"
      expr: SUM(CASE WHEN requires_supplier_notification = TRUE THEN 1 ELSE 0 END)
      comment: "Number of ECOs requiring supplier notification. Drives supply chain change management workload and supplier readiness risk."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`engineering_ecn`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Engineering Change Notice (ECN) distribution and implementation metrics. Tracks change propagation across BOMs, drawings, and ERP/MES systems — critical for ensuring manufacturing executes to the latest engineering intent."
  source: "`vibe_manufacturing_v1`.`engineering`.`ecn`"
  dimensions:
    - name: "ecn_status"
      expr: ecn_status
      comment: "Current status of the ECN (e.g., Issued, Acknowledged, Implemented, Closed) for implementation pipeline tracking."
    - name: "ecn_type"
      expr: ecn_type
      comment: "Type of engineering change notice (e.g., Mandatory, Advisory, Informational) for prioritization."
    - name: "change_category"
      expr: change_category
      comment: "Category of the change (e.g., Safety, Quality, Cost, Performance) for impact classification."
    - name: "priority"
      expr: priority
      comment: "Implementation priority of the ECN for triage and scheduling."
    - name: "bom_impact_flag"
      expr: bom_impact_flag
      comment: "Whether the ECN impacts the Bill of Materials, for production planning risk assessment."
    - name: "regulatory_impact_flag"
      expr: regulatory_impact_flag
      comment: "Whether the ECN has regulatory compliance implications, for compliance risk tracking."
    - name: "erp_sync_status"
      expr: erp_sync_status
      comment: "ERP synchronization status of the ECN, for identifying changes not yet reflected in production systems."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the ECN becomes effective, for change implementation scheduling."
  measures:
    - name: "total_ecn_count"
      expr: COUNT(1)
      comment: "Total number of Engineering Change Notices issued. Tracks change communication volume and manufacturing update burden."
    - name: "total_cost_impact"
      expr: SUM(CAST(cost_impact_estimate AS DOUBLE))
      comment: "Total estimated cost impact across all ECNs. Quantifies the financial burden of engineering changes on manufacturing."
    - name: "avg_cost_impact_per_ecn"
      expr: AVG(CAST(cost_impact_estimate AS DOUBLE))
      comment: "Average cost impact per ECN. Benchmarks change cost intensity and identifies high-cost change categories."
    - name: "bom_impacting_ecn_count"
      expr: SUM(CASE WHEN bom_impact_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of ECNs that impact the BOM. BOM changes require production line updates and are the highest-risk change type."
    - name: "regulatory_impacting_ecn_count"
      expr: SUM(CASE WHEN regulatory_impact_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of ECNs with regulatory compliance impact. These require expedited implementation to avoid compliance exposure."
    - name: "acknowledgement_completion_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(acknowledgement_count AS DOUBLE)) / NULLIF(SUM(CAST(acknowledgement_target_count AS DOUBLE)), 0), 2)
      comment: "Percentage of required ECN acknowledgements received. Low rates indicate change communication gaps that risk manufacturing executing to obsolete designs."
    - name: "avg_affected_parts_per_ecn"
      expr: AVG(CAST(affected_part_count AS DOUBLE))
      comment: "Average number of parts affected per ECN. High values indicate broad-impact changes requiring extensive production updates."
    - name: "avg_affected_drawings_per_ecn"
      expr: AVG(CAST(affected_drawing_count AS DOUBLE))
      comment: "Average number of drawings affected per ECN. Drives documentation update workload estimation for engineering teams."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`engineering_dfmea`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Design Failure Mode and Effects Analysis (DFMEA) risk metrics. Tracks failure mode severity, RPN distribution, and action completion rates — essential for product safety governance and design risk reduction."
  source: "`vibe_manufacturing_v1`.`engineering`.`dfmea`"
  dimensions:
    - name: "dfmea_status"
      expr: dfmea_status
      comment: "Current status of the DFMEA record (e.g., In Progress, Approved, Closed) for governance tracking."
    - name: "design_phase"
      expr: design_phase
      comment: "Design phase when the DFMEA was conducted (e.g., Concept, Detailed Design, Validation) for phase-gate risk assessment."
    - name: "action_status"
      expr: action_status
      comment: "Status of corrective actions (e.g., Open, In Progress, Completed) for action closure tracking."
    - name: "scope_level"
      expr: scope_level
      comment: "Level of the DFMEA scope (e.g., System, Subsystem, Component) for risk hierarchy analysis."
    - name: "safety_related_flag"
      expr: safety_related_flag
      comment: "Whether the failure mode is safety-related, for prioritizing safety-critical risk reduction actions."
    - name: "regulatory_impact_flag"
      expr: regulatory_impact_flag
      comment: "Whether the failure mode has regulatory compliance implications, for compliance risk management."
    - name: "analysis_date_month"
      expr: DATE_TRUNC('MONTH', analysis_date)
      comment: "Month the DFMEA analysis was conducted, for risk assessment activity trending."
  measures:
    - name: "total_dfmea_records"
      expr: COUNT(1)
      comment: "Total number of DFMEA failure mode records. Tracks design risk analysis coverage across the product portfolio."
    - name: "safety_related_failure_mode_count"
      expr: SUM(CASE WHEN safety_related_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of safety-related failure modes identified. A critical product safety KPI — executives must ensure all safety FMs have completed corrective actions."
    - name: "open_action_count"
      expr: SUM(CASE WHEN action_status NOT IN ('Completed', 'Closed') THEN 1 ELSE 0 END)
      comment: "Number of DFMEA records with open corrective actions. Open actions represent unmitigated design risk — a key gate-readiness indicator."
    - name: "action_closure_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN action_status IN ('Completed', 'Closed') THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of DFMEA actions that have been closed. Low closure rates block design release and PPAP approval."
    - name: "avg_severity_rating"
      expr: AVG(CAST(severity_rating AS DOUBLE))
      comment: "Average severity rating across all failure modes. Tracks overall design risk severity profile — high averages require design architecture review."
    - name: "avg_occurrence_rating"
      expr: AVG(CAST(occurrence_rating AS DOUBLE))
      comment: "Average occurrence rating across all failure modes. Indicates how frequently failure modes are expected to occur without prevention controls."
    - name: "avg_detection_rating"
      expr: AVG(CAST(detection_rating AS DOUBLE))
      comment: "Average detection rating across all failure modes. High detection ratings mean failures are hard to catch — drives investment in detection controls."
    - name: "avg_revised_rpn"
      expr: AVG(CAST(revised_rpn AS DOUBLE))
      comment: "Average revised Risk Priority Number after corrective actions. Measures effectiveness of design risk reduction — declining RPN confirms action effectiveness."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`engineering_test_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Engineering test result performance metrics tracking pass rates, test coverage, and measurement quality. Used by engineering and quality leadership to assess design validation completeness and product readiness for launch."
  source: "`vibe_manufacturing_v1`.`engineering`.`test_result`"
  dimensions:
    - name: "test_outcome"
      expr: test_outcome
      comment: "Result of the test (e.g., Pass, Fail, Conditional Pass) for pass/fail rate analysis."
    - name: "test_type"
      expr: test_type
      comment: "Type of test conducted (e.g., Functional, Environmental, Durability, Safety) for test coverage analysis."
    - name: "test_status"
      expr: test_status
      comment: "Current status of the test record (e.g., Planned, In Progress, Complete) for test pipeline tracking."
    - name: "prototype_phase"
      expr: prototype_phase
      comment: "Development phase during which the test was conducted (e.g., Alpha, Beta, Pre-Production) for phase-gate readiness."
    - name: "regulatory_submission_flag"
      expr: regulatory_submission_flag
      comment: "Whether the test result is required for regulatory submission, for compliance readiness tracking."
    - name: "retest_flag"
      expr: retest_flag
      comment: "Whether this is a retest of a previously failed test, for first-pass yield analysis."
    - name: "test_date_month"
      expr: DATE_TRUNC('MONTH', test_date)
      comment: "Month the test was conducted, for test activity volume trending."
    - name: "test_facility"
      expr: test_facility
      comment: "Facility where the test was conducted, for test lab capacity and utilization analysis."
  measures:
    - name: "total_test_count"
      expr: COUNT(1)
      comment: "Total number of engineering tests conducted. Tracks design validation activity volume and test lab throughput."
    - name: "pass_count"
      expr: SUM(CASE WHEN test_outcome = 'Pass' THEN 1 ELSE 0 END)
      comment: "Number of tests that passed. Baseline for first-pass yield and design validation completeness."
    - name: "fail_count"
      expr: SUM(CASE WHEN test_outcome = 'Fail' THEN 1 ELSE 0 END)
      comment: "Number of tests that failed. High failure counts signal design issues requiring engineering intervention before launch."
    - name: "first_pass_yield_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN test_outcome = 'Pass' AND retest_flag = FALSE THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN retest_flag = FALSE THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of tests passed on the first attempt (excluding retests). A key design quality KPI — low FPY indicates design immaturity and drives rework cost."
    - name: "avg_test_duration_hours"
      expr: AVG(CAST(test_duration_hours AS DOUBLE))
      comment: "Average test duration in hours. Used for test lab capacity planning and identifying unusually long tests that may indicate test execution issues."
    - name: "total_test_duration_hours"
      expr: SUM(CAST(test_duration_hours AS DOUBLE))
      comment: "Total test lab hours consumed. Drives test facility capacity planning and cost allocation."
    - name: "regulatory_submission_test_count"
      expr: SUM(CASE WHEN regulatory_submission_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of tests required for regulatory submission. Tracks compliance test completion status — incomplete regulatory tests block product launch."
    - name: "avg_measured_value"
      expr: AVG(CAST(measured_value AS DOUBLE))
      comment: "Average measured test value across all test records. Used to assess whether test results are trending toward specification limits."
    - name: "avg_measurement_uncertainty"
      expr: AVG(CAST(measurement_uncertainty AS DOUBLE))
      comment: "Average measurement uncertainty across tests. High uncertainty values indicate measurement system adequacy issues that may invalidate test results."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`engineering_certification_requirement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product and component certification tracking metrics. Monitors certification completion rates, cost, and compliance status across target markets — critical for market access and regulatory compliance governance."
  source: "`vibe_manufacturing_v1`.`engineering`.`certification_requirement`"
  dimensions:
    - name: "certification_type"
      expr: certification_type
      comment: "Type of certification required (e.g., CE, UL, FCC, ISO) for certification portfolio analysis."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status (e.g., Compliant, Non-Compliant, In Progress, Waived) for market access risk tracking."
    - name: "certification_priority"
      expr: certification_priority
      comment: "Business priority of the certification requirement for resource allocation decisions."
    - name: "target_market"
      expr: target_market
      comment: "Target market or region for the certification (e.g., EU, North America, Asia-Pacific) for market entry planning."
    - name: "target_country_code"
      expr: target_country_code
      comment: "Specific country code for the certification requirement, for country-level compliance tracking."
    - name: "mandatory_flag"
      expr: mandatory_flag
      comment: "Whether the certification is mandatory for market access, for prioritizing critical compliance activities."
    - name: "renewal_required_flag"
      expr: renewal_required_flag
      comment: "Whether the certification requires periodic renewal, for proactive renewal planning."
    - name: "planned_completion_date_quarter"
      expr: DATE_TRUNC('QUARTER', planned_completion_date)
      comment: "Quarter the certification is planned to be completed, for launch readiness planning."
  measures:
    - name: "total_certification_requirements"
      expr: COUNT(1)
      comment: "Total number of certification requirements across the product portfolio. Tracks compliance workload and market access complexity."
    - name: "compliant_count"
      expr: SUM(CASE WHEN compliance_status = 'Compliant' THEN 1 ELSE 0 END)
      comment: "Number of certification requirements with compliant status. Baseline for market access readiness."
    - name: "non_compliant_count"
      expr: SUM(CASE WHEN compliance_status = 'Non-Compliant' THEN 1 ELSE 0 END)
      comment: "Number of non-compliant certification requirements. Non-compliance blocks market access and creates regulatory liability."
    - name: "compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN compliance_status = 'Compliant' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of certification requirements in compliant status. A key market access KPI — below-target rates signal product launch risk."
    - name: "mandatory_non_compliant_count"
      expr: SUM(CASE WHEN mandatory_flag = TRUE AND compliance_status = 'Non-Compliant' THEN 1 ELSE 0 END)
      comment: "Number of mandatory certifications that are non-compliant. These represent hard blockers to product launch and require immediate executive escalation."
    - name: "total_actual_certification_cost"
      expr: SUM(CAST(actual_cost_amount AS DOUBLE))
      comment: "Total actual cost incurred for certification activities. Tracks certification spend against budget for R&D cost management."
    - name: "total_estimated_certification_cost"
      expr: SUM(CAST(estimated_cost_amount AS DOUBLE))
      comment: "Total estimated certification cost. Used for launch budget planning and cost-to-market analysis."
    - name: "avg_actual_cost_per_certification"
      expr: AVG(CAST(actual_cost_amount AS DOUBLE))
      comment: "Average actual cost per certification requirement. Benchmarks certification cost efficiency across certification types and markets."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`engineering_bom`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bill of Materials governance metrics tracking BOM completeness, cost estimates, and approval status. Used by engineering and operations leadership to ensure manufacturing-ready BOMs and accurate product cost visibility."
  source: "`vibe_manufacturing_v1`.`engineering`.`bom`"
  dimensions:
    - name: "bom_status"
      expr: bom_status
      comment: "Current status of the BOM (e.g., Draft, Released, Obsolete) for BOM lifecycle governance."
    - name: "bom_type"
      expr: bom_type
      comment: "Type of BOM (e.g., Engineering, Manufacturing, Sales) for BOM category analysis."
    - name: "bom_category"
      expr: bom_category
      comment: "Business category of the BOM for portfolio segmentation."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the BOM (e.g., Pending, Approved, Rejected) for release governance tracking."
    - name: "is_configurable"
      expr: is_configurable
      comment: "Whether the BOM supports product configuration variants, for configure-to-order complexity analysis."
    - name: "is_critical_bom"
      expr: is_critical_bom
      comment: "Whether the BOM is flagged as critical (e.g., safety-critical product), for prioritized governance."
    - name: "effective_from_date_month"
      expr: DATE_TRUNC('MONTH', effective_from_date)
      comment: "Month the BOM becomes effective, for BOM release cadence analysis."
  measures:
    - name: "total_bom_count"
      expr: COUNT(1)
      comment: "Total number of BOMs in the engineering repository. Tracks BOM portfolio size and governance workload."
    - name: "approved_bom_count"
      expr: SUM(CASE WHEN approval_status = 'Approved' THEN 1 ELSE 0 END)
      comment: "Number of approved BOMs. Only approved BOMs can be used for production — low approval rates signal release bottlenecks."
    - name: "bom_approval_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN approval_status = 'Approved' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of BOMs that are approved. A release readiness KPI — below-target rates indicate engineering release process bottlenecks."
    - name: "total_cost_estimate"
      expr: SUM(CAST(cost_estimate_total AS DOUBLE))
      comment: "Total BOM cost estimate across all products. Drives product cost management and margin planning decisions."
    - name: "avg_cost_estimate_per_bom"
      expr: AVG(CAST(cost_estimate_total AS DOUBLE))
      comment: "Average BOM cost estimate. Benchmarks product cost complexity and identifies outliers requiring cost reduction focus."
    - name: "avg_scrap_percentage"
      expr: AVG(CAST(scrap_percentage AS DOUBLE))
      comment: "Average scrap percentage across all BOMs. High scrap rates inflate material costs — a key target for manufacturing efficiency improvement."
    - name: "critical_bom_count"
      expr: SUM(CASE WHEN is_critical_bom = TRUE THEN 1 ELSE 0 END)
      comment: "Number of critical BOMs requiring heightened governance. Executives use this to ensure critical product BOMs receive priority review and approval."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`engineering_revision`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Engineering revision lifecycle metrics tracking revision velocity, compliance readiness, and PPAP status. Used by engineering and quality leadership to manage design maturity and regulatory compliance across product revisions."
  source: "`vibe_manufacturing_v1`.`engineering`.`engineering_revision`"
  dimensions:
    - name: "lifecycle_state"
      expr: lifecycle_state
      comment: "Current lifecycle state of the revision (e.g., In Development, Released, Obsolete) for revision pipeline tracking."
    - name: "revision_type"
      expr: revision_type
      comment: "Type of revision (e.g., Major, Minor, Administrative) for change impact classification."
    - name: "change_impact_level"
      expr: change_impact_level
      comment: "Assessed impact level of the revision change for risk-based review prioritization."
    - name: "ppap_required"
      expr: ppap_required
      comment: "Whether PPAP is required for this revision, for quality planning workload assessment."
    - name: "mass_production_approved"
      expr: mass_production_approved
      comment: "Whether the revision is approved for mass production, for launch readiness tracking."
    - name: "reach_compliant"
      expr: reach_compliant
      comment: "REACH compliance status of the revision, for environmental regulatory compliance tracking."
    - name: "rohs_compliant"
      expr: rohs_compliant
      comment: "RoHS compliance status of the revision, for hazardous substance regulatory compliance tracking."
    - name: "release_date_month"
      expr: DATE_TRUNC('MONTH', release_date)
      comment: "Month the revision was released, for release cadence and engineering velocity analysis."
  measures:
    - name: "total_revision_count"
      expr: COUNT(1)
      comment: "Total number of engineering revisions. High revision counts may indicate design instability or active product improvement programs."
    - name: "mass_production_approved_count"
      expr: SUM(CASE WHEN mass_production_approved = TRUE THEN 1 ELSE 0 END)
      comment: "Number of revisions approved for mass production. Tracks design maturity and production readiness across the product portfolio."
    - name: "production_approval_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN mass_production_approved = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of revisions approved for mass production. A launch readiness KPI — low rates indicate design maturity gaps blocking production."
    - name: "ppap_required_count"
      expr: SUM(CASE WHEN ppap_required = TRUE THEN 1 ELSE 0 END)
      comment: "Number of revisions requiring PPAP. Drives quality planning resource allocation for supplier and process qualification."
    - name: "reach_compliant_count"
      expr: SUM(CASE WHEN reach_compliant = TRUE THEN 1 ELSE 0 END)
      comment: "Number of revisions with confirmed REACH compliance. Tracks environmental regulatory compliance coverage across the product portfolio."
    - name: "rohs_compliant_count"
      expr: SUM(CASE WHEN rohs_compliant = TRUE THEN 1 ELSE 0 END)
      comment: "Number of revisions with confirmed RoHS compliance. Tracks hazardous substance compliance — non-compliance blocks EU market access."
    - name: "environmental_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN reach_compliant = TRUE AND rohs_compliant = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of revisions compliant with both REACH and RoHS. A combined environmental compliance KPI for EU market access readiness."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`engineering_component`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Component portfolio health metrics tracking lifecycle status, compliance, cost, and make-or-buy distribution. Used by engineering and supply chain leadership to manage component risk, obsolescence, and sourcing strategy."
  source: "`vibe_manufacturing_v1`.`engineering`.`component`"
  dimensions:
    - name: "lifecycle_phase"
      expr: lifecycle_phase
      comment: "Current lifecycle phase of the component (e.g., Active, Mature, End-of-Life, Obsolete) for obsolescence risk management."
    - name: "make_or_buy"
      expr: make_or_buy
      comment: "Make-or-buy classification of the component for sourcing strategy analysis."
    - name: "component_type"
      expr: component_type
      comment: "Type of component (e.g., Mechanical, Electronic, Software, Raw Material) for portfolio composition analysis."
    - name: "release_status"
      expr: release_status
      comment: "Release status of the component (e.g., Prototype, Released, Obsolete) for design release governance."
    - name: "rohs_compliant_flag"
      expr: rohs_compliant_flag
      comment: "RoHS compliance status for environmental regulatory risk tracking."
    - name: "reach_compliant_flag"
      expr: reach_compliant_flag
      comment: "REACH compliance status for environmental regulatory risk tracking."
    - name: "hazardous_material_flag"
      expr: hazardous_material_flag
      comment: "Whether the component contains hazardous materials, for EHS risk management."
    - name: "abc_classification"
      expr: abc_classification
      comment: "ABC inventory classification of the component for inventory management prioritization."
    - name: "technology_family"
      expr: technology_family
      comment: "Technology family of the component for platform and technology roadmap analysis."
  measures:
    - name: "total_component_count"
      expr: COUNT(1)
      comment: "Total number of components in the engineering master data. Tracks portfolio size and complexity."
    - name: "active_component_count"
      expr: SUM(CASE WHEN lifecycle_phase = 'Active' THEN 1 ELSE 0 END)
      comment: "Number of active components. Baseline for portfolio health — declining active counts may indicate product line rationalization."
    - name: "obsolete_component_count"
      expr: SUM(CASE WHEN lifecycle_phase = 'Obsolete' THEN 1 ELSE 0 END)
      comment: "Number of obsolete components. High counts indicate BOM cleanup backlog and potential production risk from obsolete part usage."
    - name: "avg_standard_cost"
      expr: AVG(CAST(standard_cost AS DOUBLE))
      comment: "Average standard cost per component. Benchmarks component cost levels and identifies high-cost components for cost reduction focus."
    - name: "total_standard_cost"
      expr: SUM(CAST(standard_cost AS DOUBLE))
      comment: "Total standard cost across all components. Provides a portfolio-level view of component cost base for cost management."
    - name: "rohs_compliant_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN rohs_compliant_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of components that are RoHS compliant. Non-compliant components block EU market access — a critical regulatory KPI."
    - name: "avg_dfm_score"
      expr: AVG(CAST(dfm_score AS DOUBLE))
      comment: "Average Design for Manufacturability score across components. Low DFM scores predict high manufacturing cost and quality issues — drives design improvement priorities."
    - name: "avg_lead_time_days"
      expr: AVG(CAST(lead_time_days AS DOUBLE))
      comment: "Average component lead time in days. Long lead times create supply chain risk and constrain production scheduling flexibility."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`engineering_dfm_analysis`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Design for Manufacturability (DFM) analysis metrics tracking issue resolution rates, cost savings, and supplier feedback. Used by engineering and manufacturing leadership to reduce production cost and improve design-to-manufacture transition quality."
  source: "`vibe_manufacturing_v1`.`engineering`.`dfm_analysis`"
  dimensions:
    - name: "disposition_status"
      expr: disposition_status
      comment: "Current disposition of the DFM issue (e.g., Open, Accepted, Rejected, Resolved) for issue pipeline management."
    - name: "priority"
      expr: priority
      comment: "Priority of the DFM issue for triage and resource allocation."
    - name: "severity_classification"
      expr: severity_classification
      comment: "Severity of the DFM issue (e.g., Critical, Major, Minor) for impact-based prioritization."
    - name: "manufacturing_process_scope"
      expr: manufacturing_process_scope
      comment: "Manufacturing process affected by the DFM issue (e.g., Machining, Assembly, Welding) for process-level analysis."
    - name: "eco_initiated"
      expr: eco_initiated
      comment: "Whether an ECO was initiated to address the DFM issue, for change management tracking."
    - name: "review_date_month"
      expr: DATE_TRUNC('MONTH', review_date)
      comment: "Month the DFM analysis was reviewed, for analysis activity trending."
  measures:
    - name: "total_dfm_issues"
      expr: COUNT(1)
      comment: "Total number of DFM issues identified. Tracks design-to-manufacture gap analysis activity and issue volume."
    - name: "resolved_issue_count"
      expr: SUM(CASE WHEN disposition_status = 'Resolved' THEN 1 ELSE 0 END)
      comment: "Number of DFM issues resolved. Tracks design improvement progress and manufacturing readiness."
    - name: "issue_resolution_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN disposition_status = 'Resolved' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of DFM issues resolved. Low resolution rates indicate manufacturing readiness risk and potential production launch delays."
    - name: "total_estimated_cost_impact"
      expr: SUM(CAST(estimated_cost_impact AS DOUBLE))
      comment: "Total estimated cost impact of all DFM issues. Quantifies the manufacturing cost risk from unresolved design issues."
    - name: "total_estimated_cost_savings"
      expr: SUM(CAST(estimated_cost_savings AS DOUBLE))
      comment: "Total estimated cost savings from DFM improvements. Demonstrates the ROI of DFM analysis investment to engineering and finance leadership."
    - name: "avg_cost_savings_per_issue"
      expr: AVG(CAST(estimated_cost_savings AS DOUBLE))
      comment: "Average cost savings per DFM issue resolved. Benchmarks DFM program value and prioritizes high-savings improvement opportunities."
    - name: "eco_initiated_count"
      expr: SUM(CASE WHEN eco_initiated = TRUE THEN 1 ELSE 0 END)
      comment: "Number of DFM issues that triggered an Engineering Change Order. Tracks the downstream design change burden from DFM findings."
$$;