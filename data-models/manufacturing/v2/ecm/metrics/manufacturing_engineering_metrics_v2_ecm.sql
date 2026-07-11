-- Metric views for domain: engineering | Business: Manufacturing | Version: 2 | Generated on: 2026-07-10 11:52:40

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`engineering_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for engineering project portfolio management — tracks budget performance, schedule adherence, and project health across the engineering program."
  source: "`vibe_manufacturing_v1`.`engineering`.`engineering_project`"
  dimensions:
    - name: "project_status"
      expr: project_status
      comment: "Current lifecycle status of the engineering project (e.g. Active, On Hold, Completed) for portfolio segmentation."
    - name: "project_type"
      expr: project_type
      comment: "Classification of the engineering project type (e.g. New Product Development, Cost Reduction, Platform) for strategic grouping."
    - name: "priority_level"
      expr: priority_level
      comment: "Business priority tier assigned to the project for resource allocation analysis."
    - name: "program_phase"
      expr: program_phase
      comment: "Current APQP/development phase of the project (e.g. Concept, Design, Validation, Launch)."
    - name: "capex_opex_classification"
      expr: capex_opex_classification
      comment: "Financial classification of the project spend as CapEx or OpEx for financial reporting."
    - name: "risk_level"
      expr: risk_level
      comment: "Assessed risk level of the project for executive risk management dashboards."
    - name: "target_market_segment"
      expr: target_market_segment
      comment: "Market segment the project is targeting, enabling revenue-linked portfolio analysis."
    - name: "technology_platform"
      expr: technology_platform
      comment: "Technology platform underpinning the project for platform investment analysis."
    - name: "start_date_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the project started, for cohort and trend analysis."
    - name: "target_launch_date_month"
      expr: DATE_TRUNC('MONTH', target_launch_date)
      comment: "Planned launch month for schedule pipeline analysis."
  measures:
    - name: "total_projects"
      expr: COUNT(1)
      comment: "Total number of engineering projects in the portfolio. Baseline KPI for portfolio size and capacity planning."
    - name: "total_budget_allocated"
      expr: SUM(CAST(budget_allocated_amount AS DOUBLE))
      comment: "Total capital committed across all engineering projects. Drives investment portfolio decisions and budget governance."
    - name: "total_budget_spent"
      expr: SUM(CAST(budget_spent_amount AS DOUBLE))
      comment: "Total actual spend across all engineering projects. Compared against allocated budget to assess burn rate."
    - name: "avg_budget_allocated_per_project"
      expr: AVG(CAST(budget_allocated_amount AS DOUBLE))
      comment: "Average budget allocated per engineering project. Benchmarks investment intensity per initiative."
    - name: "avg_budget_spent_per_project"
      expr: AVG(CAST(budget_spent_amount AS DOUBLE))
      comment: "Average actual spend per engineering project. Identifies over- or under-spending patterns across the portfolio."
    - name: "projects_with_dfmea_completed"
      expr: COUNT(CASE WHEN dfmea_completed = TRUE THEN 1 END)
      comment: "Number of projects where DFMEA has been completed. Measures design quality process compliance — a leading indicator of product reliability."
    - name: "projects_with_pfmea_completed"
      expr: COUNT(CASE WHEN pfmea_completed = TRUE THEN 1 END)
      comment: "Number of projects where PFMEA has been completed. Measures manufacturing process risk analysis compliance."
    - name: "projects_requiring_ppap"
      expr: COUNT(CASE WHEN ppap_required = TRUE THEN 1 END)
      comment: "Number of projects requiring PPAP submission. Indicates customer-facing quality gate workload for launch readiness planning."
    - name: "projects_with_dfm_completed"
      expr: COUNT(CASE WHEN dfm_analysis_completed = TRUE THEN 1 END)
      comment: "Number of projects where Design for Manufacturability analysis is complete. Tracks manufacturing readiness across the portfolio."
    - name: "avg_team_size"
      expr: AVG(CAST(team_size_count AS DOUBLE))
      comment: "Average team size across engineering projects. Informs resource capacity planning and project staffing benchmarks."
    - name: "avg_eco_count_per_project"
      expr: AVG(CAST(eco_count AS DOUBLE))
      comment: "Average number of Engineering Change Orders per project. High ECO counts signal design instability and rework cost risk."
    - name: "avg_design_review_count"
      expr: AVG(CAST(design_review_count AS DOUBLE))
      comment: "Average number of design reviews conducted per project. Measures design governance rigor."
    - name: "avg_prototype_count"
      expr: AVG(CAST(prototype_count AS DOUBLE))
      comment: "Average number of prototypes built per project. Higher counts may indicate design iteration challenges or complexity."
    - name: "avg_patent_applications"
      expr: AVG(CAST(patent_application_count AS DOUBLE))
      comment: "Average patent applications per project. Measures innovation output and IP generation rate across the engineering portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`engineering_eco`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Engineering Change Order (ECO) metrics tracking change volume, cost impact, and cycle time — critical for managing design stability and change governance."
  source: "`vibe_manufacturing_v1`.`engineering`.`eco`"
  dimensions:
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current workflow status of the ECO (e.g. Draft, Submitted, Approved, Implemented, Closed) for pipeline visibility."
    - name: "change_type"
      expr: change_type
      comment: "Category of engineering change (e.g. Design, Process, Material, Regulatory) for root cause analysis."
    - name: "change_priority"
      expr: change_priority
      comment: "Business priority of the change order for triage and resource allocation."
    - name: "reason_code"
      expr: reason_code
      comment: "Coded reason driving the engineering change. Identifies systemic design or process issues."
    - name: "effectivity_type"
      expr: effectivity_type
      comment: "How the change takes effect (e.g. Date-based, Serial-number-based) for production planning impact."
    - name: "requires_customer_approval"
      expr: requires_customer_approval
      comment: "Flag indicating whether the change requires customer sign-off — affects lead time and customer relationship management."
    - name: "initiated_date_month"
      expr: DATE_TRUNC('MONTH', initiated_date)
      comment: "Month the ECO was initiated, for trend analysis of change volume over time."
    - name: "effectivity_date_month"
      expr: DATE_TRUNC('MONTH', effectivity_date)
      comment: "Month the change becomes effective, for production planning and supply chain impact scheduling."
  measures:
    - name: "total_ecos"
      expr: COUNT(1)
      comment: "Total number of Engineering Change Orders. Baseline measure of design change activity volume."
    - name: "total_estimated_cost_impact"
      expr: SUM(CAST(estimated_cost_impact AS DOUBLE))
      comment: "Total estimated financial impact of all ECOs. Quantifies the cost burden of engineering changes on the business."
    - name: "total_actual_cost_impact"
      expr: SUM(CAST(actual_cost_impact AS DOUBLE))
      comment: "Total actual financial impact of implemented ECOs. Compared against estimates to assess change cost accuracy."
    - name: "avg_estimated_cost_impact"
      expr: AVG(CAST(estimated_cost_impact AS DOUBLE))
      comment: "Average estimated cost per ECO. Benchmarks the typical financial weight of a change order."
    - name: "avg_actual_cost_impact"
      expr: AVG(CAST(actual_cost_impact AS DOUBLE))
      comment: "Average actual cost per ECO. Identifies whether change costs are systematically under- or over-estimated."
    - name: "ecos_requiring_customer_approval"
      expr: COUNT(CASE WHEN requires_customer_approval = TRUE THEN 1 END)
      comment: "Number of ECOs requiring customer approval. High counts signal customer relationship and schedule risk."
    - name: "ecos_with_customer_approval_received"
      expr: COUNT(CASE WHEN customer_approval_received = TRUE THEN 1 END)
      comment: "Number of ECOs where customer approval has been obtained. Measures approval pipeline throughput."
    - name: "ecos_requiring_supplier_notification"
      expr: COUNT(CASE WHEN requires_supplier_notification = TRUE THEN 1 END)
      comment: "Number of ECOs requiring supplier notification. Quantifies supply chain disruption risk from engineering changes."
    - name: "avg_affected_items_count"
      expr: AVG(CAST(affected_items_count AS DOUBLE))
      comment: "Average number of BOM items affected per ECO. Higher values indicate broader change scope and greater implementation complexity."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`engineering_ecn`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Engineering Change Notice (ECN) metrics tracking notification effectiveness, BOM/routing impact, and ERP/MES synchronization status — measures change communication governance."
  source: "`vibe_manufacturing_v1`.`engineering`.`ecn`"
  dimensions:
    - name: "ecn_status"
      expr: ecn_status
      comment: "Current status of the ECN (e.g. Draft, Released, Acknowledged, Closed) for pipeline management."
    - name: "ecn_type"
      expr: ecn_type
      comment: "Type of engineering change notice for categorization and routing analysis."
    - name: "change_category"
      expr: change_category
      comment: "Business category of the change (e.g. Safety, Cost, Quality, Regulatory) for impact classification."
    - name: "priority"
      expr: priority
      comment: "Priority level of the ECN for triage and escalation management."
    - name: "erp_sync_status"
      expr: erp_sync_status
      comment: "ERP system synchronization status — unsynced ECNs represent data integrity risk in production."
    - name: "mes_sync_status"
      expr: mes_sync_status
      comment: "MES system synchronization status — unsynced ECNs risk production executing against obsolete designs."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the ECN becomes effective, for production planning and supply chain scheduling."
    - name: "release_date_month"
      expr: DATE_TRUNC('MONTH', release_date)
      comment: "Month the ECN was released, for change velocity trend analysis."
  measures:
    - name: "total_ecns"
      expr: COUNT(1)
      comment: "Total number of Engineering Change Notices issued. Baseline measure of change communication volume."
    - name: "total_estimated_cost_impact"
      expr: SUM(CAST(cost_impact_estimate AS DOUBLE))
      comment: "Total estimated cost impact across all ECNs. Quantifies the financial exposure from pending engineering changes."
    - name: "avg_cost_impact_per_ecn"
      expr: AVG(CAST(cost_impact_estimate AS DOUBLE))
      comment: "Average estimated cost impact per ECN. Benchmarks the typical financial weight of a change notice."
    - name: "ecns_with_bom_impact"
      expr: COUNT(CASE WHEN bom_impact_flag = TRUE THEN 1 END)
      comment: "Number of ECNs with BOM impact. High counts signal significant supply chain and procurement disruption risk."
    - name: "ecns_with_routing_impact"
      expr: COUNT(CASE WHEN routing_impact_flag = TRUE THEN 1 END)
      comment: "Number of ECNs affecting production routing. Indicates manufacturing process change workload."
    - name: "ecns_with_inventory_impact"
      expr: COUNT(CASE WHEN inventory_impact_flag = TRUE THEN 1 END)
      comment: "Number of ECNs with inventory impact. Drives obsolescence write-off risk assessment."
    - name: "ecns_with_regulatory_impact"
      expr: COUNT(CASE WHEN regulatory_impact_flag = TRUE THEN 1 END)
      comment: "Number of ECNs with regulatory compliance impact. Critical for compliance risk management and regulatory filing planning."
    - name: "ecns_requiring_customer_notification"
      expr: COUNT(CASE WHEN customer_notification_required = TRUE THEN 1 END)
      comment: "Number of ECNs requiring customer notification. Measures customer communication workload and relationship risk."
    - name: "ecns_not_synced_to_erp"
      expr: COUNT(CASE WHEN erp_sync_status <> 'SYNCED' THEN 1 END)
      comment: "Number of ECNs not yet synchronized to ERP. Represents data integrity risk — production may execute against outdated BOMs."
    - name: "avg_affected_part_count"
      expr: AVG(CAST(affected_part_count AS DOUBLE))
      comment: "Average number of parts affected per ECN. Higher values indicate broader change scope and greater supply chain disruption."
    - name: "avg_affected_drawing_count"
      expr: AVG(CAST(affected_drawing_count AS DOUBLE))
      comment: "Average number of drawings affected per ECN. Measures documentation update workload per change."
    - name: "acknowledgement_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN CAST(acknowledgement_count AS DOUBLE) >= CAST(acknowledgement_target_count AS DOUBLE) AND acknowledgement_target_count <> '0' THEN 1 END) / NULLIF(COUNT(CASE WHEN acknowledgement_required = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of ECNs requiring acknowledgement where target acknowledgement count has been met. Measures change communication effectiveness."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`engineering_component`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Component master data quality and portfolio metrics — tracks component lifecycle, compliance status, cost, and make/buy strategy for engineering and procurement decisions."
  source: "`vibe_manufacturing_v1`.`engineering`.`component`"
  dimensions:
    - name: "component_type"
      expr: component_type
      comment: "Classification of the component type (e.g. Mechanical, Electrical, Software) for portfolio analysis."
    - name: "lifecycle_phase"
      expr: lifecycle_phase
      comment: "Current lifecycle phase of the component (e.g. Active, Obsolete, Phase-Out) for obsolescence management."
    - name: "make_or_buy"
      expr: make_or_buy
      comment: "Make vs. Buy designation for strategic sourcing and manufacturing capacity analysis."
    - name: "release_status"
      expr: release_status
      comment: "Engineering release status of the component for design governance tracking."
    - name: "abc_classification"
      expr: abc_classification
      comment: "ABC inventory classification of the component for prioritized management focus."
    - name: "technology_family"
      expr: technology_family
      comment: "Technology family grouping for platform and technology investment analysis."
    - name: "hazardous_material_flag"
      expr: hazardous_material_flag
      comment: "Indicates whether the component contains hazardous materials — critical for regulatory compliance and EHS reporting."
    - name: "rohs_compliant_flag"
      expr: rohs_compliant_flag
      comment: "RoHS compliance status — mandatory for EU market access and regulatory reporting."
    - name: "reach_compliant_flag"
      expr: reach_compliant_flag
      comment: "REACH compliance status — mandatory for EU chemical regulation compliance."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the component became effective, for new component introduction trend analysis."
  measures:
    - name: "total_components"
      expr: COUNT(1)
      comment: "Total number of components in the engineering master. Baseline for portfolio size and complexity management."
    - name: "total_standard_cost"
      expr: SUM(CAST(standard_cost AS DOUBLE))
      comment: "Total standard cost across all components. Drives product cost rollup and margin analysis."
    - name: "avg_standard_cost"
      expr: AVG(CAST(standard_cost AS DOUBLE))
      comment: "Average standard cost per component. Benchmarks component cost levels for cost reduction targeting."
    - name: "avg_dfm_score"
      expr: AVG(CAST(dfm_score AS DOUBLE))
      comment: "Average Design for Manufacturability score across components. Low scores indicate manufacturing complexity risk and cost drivers."
    - name: "avg_lead_time_days"
      expr: AVG(CAST(lead_time_days AS DOUBLE))
      comment: "Average procurement lead time across components. Critical for supply chain planning and new product launch scheduling."
    - name: "avg_weight_kg"
      expr: AVG(CAST(weight_kg AS DOUBLE))
      comment: "Average component weight in kilograms. Supports product weight targets and logistics cost analysis."
    - name: "components_rohs_compliant"
      expr: COUNT(CASE WHEN rohs_compliant_flag = TRUE THEN 1 END)
      comment: "Number of RoHS-compliant components. Measures regulatory compliance coverage for EU market access."
    - name: "components_reach_compliant"
      expr: COUNT(CASE WHEN reach_compliant_flag = TRUE THEN 1 END)
      comment: "Number of REACH-compliant components. Measures chemical regulation compliance coverage."
    - name: "components_hazardous"
      expr: COUNT(CASE WHEN hazardous_material_flag = TRUE THEN 1 END)
      comment: "Number of components containing hazardous materials. Drives EHS risk management and regulatory reporting workload."
    - name: "components_obsolete"
      expr: COUNT(CASE WHEN lifecycle_phase = 'Obsolete' THEN 1 END)
      comment: "Number of obsolete components. High counts indicate BOM hygiene risk and potential production disruption."
    - name: "avg_safety_stock_quantity"
      expr: AVG(CAST(safety_stock_quantity AS DOUBLE))
      comment: "Average safety stock quantity across components. Informs inventory investment and supply risk mitigation strategy."
    - name: "avg_minimum_order_quantity"
      expr: AVG(CAST(minimum_order_quantity AS DOUBLE))
      comment: "Average minimum order quantity across components. Impacts procurement cost and inventory carrying cost planning."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`engineering_test_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Engineering test result metrics tracking test pass rates, measurement accuracy, and validation coverage — key quality gate KPIs for product development and regulatory submission."
  source: "`vibe_manufacturing_v1`.`engineering`.`test_result`"
  dimensions:
    - name: "test_type"
      expr: test_type
      comment: "Type of engineering test (e.g. DVP&R, Environmental, Functional, Regulatory) for test program analysis."
    - name: "test_outcome"
      expr: test_outcome
      comment: "Result of the test (e.g. Pass, Fail, Inconclusive) for quality gate performance tracking."
    - name: "test_status"
      expr: test_status
      comment: "Current status of the test record (e.g. Planned, In Progress, Complete) for test pipeline management."
    - name: "prototype_phase"
      expr: prototype_phase
      comment: "Development phase during which the test was conducted (e.g. Alpha, Beta, Pre-Production) for phase-gate analysis."
    - name: "regulatory_submission_flag"
      expr: regulatory_submission_flag
      comment: "Indicates whether the test result is required for regulatory submission — critical for compliance milestone tracking."
    - name: "retest_flag"
      expr: retest_flag
      comment: "Indicates whether this is a retest. High retest rates signal design or process quality issues."
    - name: "test_date_month"
      expr: DATE_TRUNC('MONTH', test_date)
      comment: "Month the test was conducted, for test velocity and quality trend analysis."
    - name: "test_facility"
      expr: test_facility
      comment: "Facility where the test was conducted, for test capacity and geographic analysis."
  measures:
    - name: "total_tests"
      expr: COUNT(1)
      comment: "Total number of engineering test records. Baseline measure of test program activity and validation coverage."
    - name: "tests_passed"
      expr: COUNT(CASE WHEN test_outcome = 'Pass' THEN 1 END)
      comment: "Number of tests with a passing outcome. Measures product validation success rate."
    - name: "tests_failed"
      expr: COUNT(CASE WHEN test_outcome = 'Fail' THEN 1 END)
      comment: "Number of failed tests. Drives root cause analysis prioritization and design rework decisions."
    - name: "first_pass_yield_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN test_outcome = 'Pass' AND retest_flag = FALSE THEN 1 END) / NULLIF(COUNT(CASE WHEN retest_flag = FALSE THEN 1 END), 0), 2)
      comment: "Percentage of first-attempt tests that pass. Core quality KPI — low first-pass yield signals design or process deficiencies requiring executive intervention."
    - name: "retest_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN retest_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of tests that are retests. High retest rates indicate design instability and inflate validation cost and schedule."
    - name: "regulatory_submission_tests"
      expr: COUNT(CASE WHEN regulatory_submission_flag = TRUE THEN 1 END)
      comment: "Number of tests required for regulatory submission. Tracks compliance validation coverage for market authorization."
    - name: "avg_measured_value"
      expr: AVG(CAST(measured_value AS DOUBLE))
      comment: "Average measured test value across all test records. Provides baseline for process capability and specification conformance analysis."
    - name: "avg_measurement_uncertainty"
      expr: AVG(CAST(measurement_uncertainty AS DOUBLE))
      comment: "Average measurement uncertainty across tests. High uncertainty values indicate test equipment calibration or methodology issues."
    - name: "avg_test_duration_hours"
      expr: AVG(CAST(test_duration_hours AS DOUBLE))
      comment: "Average test duration in hours. Drives test lab capacity planning and critical path schedule analysis."
    - name: "total_test_duration_hours"
      expr: SUM(CAST(test_duration_hours AS DOUBLE))
      comment: "Total test hours consumed. Quantifies test lab resource utilization and validation program cost."
    - name: "tests_requiring_rca"
      expr: COUNT(CASE WHEN root_cause_analysis_required = TRUE THEN 1 END)
      comment: "Number of tests requiring root cause analysis. Measures the volume of quality investigations triggered by test failures."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`engineering_dfmea`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Design Failure Mode and Effects Analysis (DFMEA) metrics tracking risk priority, action completion, and safety-critical failure modes — core product reliability and safety governance KPIs."
  source: "`vibe_manufacturing_v1`.`engineering`.`dfmea`"
  dimensions:
    - name: "dfmea_status"
      expr: dfmea_status
      comment: "Current status of the DFMEA record (e.g. In Progress, Approved, Closed) for governance tracking."
    - name: "action_status"
      expr: action_status
      comment: "Status of corrective actions defined in the DFMEA for action closure rate analysis."
    - name: "design_phase"
      expr: design_phase
      comment: "Design phase during which the DFMEA was conducted for phase-gate quality analysis."
    - name: "safety_related_flag"
      expr: safety_related_flag
      comment: "Indicates safety-critical failure modes — mandatory for product liability and regulatory compliance reporting."
    - name: "regulatory_impact_flag"
      expr: regulatory_impact_flag
      comment: "Indicates whether the failure mode has regulatory compliance implications."
    - name: "special_characteristics_flag"
      expr: special_characteristics_flag
      comment: "Indicates special product characteristics requiring enhanced control — critical for IATF/APQP compliance."
    - name: "analysis_date_month"
      expr: DATE_TRUNC('MONTH', analysis_date)
      comment: "Month the DFMEA analysis was conducted, for quality program trend analysis."
  measures:
    - name: "total_dfmea_records"
      expr: COUNT(1)
      comment: "Total number of DFMEA records. Baseline measure of design risk analysis coverage."
    - name: "safety_related_failure_modes"
      expr: COUNT(CASE WHEN safety_related_flag = TRUE THEN 1 END)
      comment: "Number of safety-critical failure modes identified. Drives product liability risk management and regulatory compliance decisions."
    - name: "open_action_items"
      expr: COUNT(CASE WHEN action_status NOT IN ('Closed', 'Complete', 'Completed') THEN 1 END)
      comment: "Number of DFMEA records with open corrective actions. Measures design risk mitigation backlog requiring management attention."
    - name: "action_closure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN action_status IN ('Closed', 'Complete', 'Completed') THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of DFMEA action items that have been closed. Measures design risk mitigation effectiveness — a key APQP gate metric."
    - name: "dfmeas_with_regulatory_impact"
      expr: COUNT(CASE WHEN regulatory_impact_flag = TRUE THEN 1 END)
      comment: "Number of DFMEAs with regulatory compliance impact. Quantifies regulatory risk exposure in the product design portfolio."
    - name: "dfmeas_with_special_characteristics"
      expr: COUNT(CASE WHEN special_characteristics_flag = TRUE THEN 1 END)
      comment: "Number of DFMEAs identifying special product characteristics. Drives enhanced control plan requirements and manufacturing process design."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`engineering_certification_requirement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product and component certification requirement metrics tracking compliance status, cost, and schedule adherence — critical for market access and regulatory approval governance."
  source: "`vibe_manufacturing_v1`.`engineering`.`certification_requirement`"
  dimensions:
    - name: "certification_type"
      expr: certification_type
      comment: "Type of certification required (e.g. CE, UL, FCC, ISO) for regulatory portfolio analysis."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status of the certification requirement for regulatory risk tracking."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level associated with non-compliance for executive risk management prioritization."
    - name: "certification_priority"
      expr: certification_priority
      comment: "Business priority of the certification for resource allocation and schedule management."
    - name: "mandatory_flag"
      expr: mandatory_flag
      comment: "Indicates whether the certification is mandatory for market access — non-compliant mandatory certs block product launch."
    - name: "target_market"
      expr: target_market
      comment: "Target market for the certification (e.g. EU, US, Japan) for geographic compliance portfolio analysis."
    - name: "target_country_code"
      expr: target_country_code
      comment: "Target country code for country-level regulatory compliance tracking."
    - name: "renewal_required_flag"
      expr: renewal_required_flag
      comment: "Indicates whether the certification requires periodic renewal — drives compliance maintenance planning."
    - name: "planned_completion_date_month"
      expr: DATE_TRUNC('MONTH', planned_completion_date)
      comment: "Planned completion month for certification milestone pipeline analysis."
  measures:
    - name: "total_certification_requirements"
      expr: COUNT(1)
      comment: "Total number of certification requirements across the product portfolio. Baseline for compliance program scope."
    - name: "mandatory_certifications"
      expr: COUNT(CASE WHEN mandatory_flag = TRUE THEN 1 END)
      comment: "Number of mandatory certification requirements. Non-compliance with mandatory certs blocks market access — critical executive KPI."
    - name: "certifications_compliant"
      expr: COUNT(CASE WHEN compliance_status = 'Compliant' THEN 1 END)
      comment: "Number of certification requirements in compliant status. Measures regulatory compliance achievement rate."
    - name: "certifications_non_compliant"
      expr: COUNT(CASE WHEN compliance_status = 'Non-Compliant' THEN 1 END)
      comment: "Number of non-compliant certification requirements. Directly represents market access risk and potential regulatory penalty exposure."
    - name: "compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_status = 'Compliant' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of certification requirements in compliant status. Top-level regulatory health KPI for executive and board reporting."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost_amount AS DOUBLE))
      comment: "Total actual cost incurred for certification activities. Tracks regulatory compliance spend against budget."
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost_amount AS DOUBLE))
      comment: "Total estimated cost for all certification requirements. Drives compliance budget planning."
    - name: "avg_actual_cost_per_certification"
      expr: AVG(CAST(actual_cost_amount AS DOUBLE))
      comment: "Average actual cost per certification requirement. Benchmarks certification investment and identifies cost outliers."
    - name: "certifications_requiring_renewal"
      expr: COUNT(CASE WHEN renewal_required_flag = TRUE THEN 1 END)
      comment: "Number of certifications requiring periodic renewal. Drives compliance maintenance workload and budget planning."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`engineering_revision`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Engineering revision metrics tracking design change velocity, compliance readiness, and lifecycle state — measures design maturity and change management effectiveness."
  source: "`vibe_manufacturing_v1`.`engineering`.`engineering_revision`"
  dimensions:
    - name: "lifecycle_state"
      expr: lifecycle_state
      comment: "Current lifecycle state of the revision (e.g. In Development, Released, Obsolete) for design maturity analysis."
    - name: "revision_type"
      expr: revision_type
      comment: "Type of revision (e.g. Major, Minor, Administrative) for change impact classification."
    - name: "change_impact_level"
      expr: change_impact_level
      comment: "Assessed impact level of the revision for change governance and resource prioritization."
    - name: "change_category"
      expr: change_category
      comment: "Business category of the change driving the revision for root cause analysis."
    - name: "ppap_required"
      expr: ppap_required
      comment: "Indicates whether PPAP is required for this revision — affects customer approval and launch schedule."
    - name: "mass_production_approved"
      expr: mass_production_approved
      comment: "Indicates whether the revision is approved for mass production — key launch readiness gate."
    - name: "rohs_compliant"
      expr: rohs_compliant
      comment: "RoHS compliance status of the revision for regulatory market access tracking."
    - name: "reach_compliant"
      expr: reach_compliant
      comment: "REACH compliance status of the revision for EU chemical regulation compliance."
    - name: "release_date_month"
      expr: DATE_TRUNC('MONTH', release_date)
      comment: "Month the revision was released, for design change velocity trend analysis."
  measures:
    - name: "total_revisions"
      expr: COUNT(1)
      comment: "Total number of engineering revisions. Baseline measure of design change activity and product complexity."
    - name: "revisions_mass_production_approved"
      expr: COUNT(CASE WHEN mass_production_approved = TRUE THEN 1 END)
      comment: "Number of revisions approved for mass production. Measures design release throughput and launch readiness."
    - name: "revisions_requiring_ppap"
      expr: COUNT(CASE WHEN ppap_required = TRUE THEN 1 END)
      comment: "Number of revisions requiring PPAP submission. Quantifies customer approval workload and schedule risk."
    - name: "revisions_with_dfmea_completed"
      expr: COUNT(CASE WHEN dfmea_completed = TRUE THEN 1 END)
      comment: "Number of revisions with completed DFMEA. Measures design quality process compliance rate."
    - name: "revisions_with_pfmea_completed"
      expr: COUNT(CASE WHEN pfmea_completed = TRUE THEN 1 END)
      comment: "Number of revisions with completed PFMEA. Measures manufacturing process risk analysis compliance."
    - name: "revisions_rohs_compliant"
      expr: COUNT(CASE WHEN rohs_compliant = TRUE THEN 1 END)
      comment: "Number of revisions with RoHS compliance confirmed. Tracks regulatory compliance coverage for EU market access."
    - name: "ppap_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN ppap_required = FALSE OR ppap_required IS NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of revisions where PPAP is not required or has been waived. Complements the PPAP-required count for launch readiness assessment."
    - name: "prototype_tested_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN prototype_tested = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of revisions where prototype testing has been completed. Measures validation coverage across the revision portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`engineering_bom`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Engineering BOM metrics tracking BOM portfolio health, cost estimates, and configuration complexity — drives product cost management and BOM governance decisions."
  source: "`vibe_manufacturing_v1`.`engineering`.`bom`"
  dimensions:
    - name: "bom_status"
      expr: bom_status
      comment: "Current status of the BOM (e.g. Draft, Released, Obsolete) for BOM governance tracking."
    - name: "bom_type"
      expr: bom_type
      comment: "Type of BOM (e.g. Engineering, Manufacturing, Sales) for BOM portfolio segmentation."
    - name: "bom_category"
      expr: bom_category
      comment: "Business category of the BOM for product line and platform analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the BOM for release governance tracking."
    - name: "is_configurable"
      expr: is_configurable
      comment: "Indicates whether the BOM supports product configuration — drives variant management complexity analysis."
    - name: "is_critical_bom"
      expr: is_critical_bom
      comment: "Indicates whether the BOM is designated as critical — drives prioritized governance and change control."
    - name: "explosion_type"
      expr: explosion_type
      comment: "BOM explosion type (e.g. Single-level, Multi-level) for BOM complexity analysis."
    - name: "approved_date_month"
      expr: DATE_TRUNC('MONTH', approved_date)
      comment: "Month the BOM was approved, for BOM release velocity trend analysis."
  measures:
    - name: "total_boms"
      expr: COUNT(1)
      comment: "Total number of engineering BOMs. Baseline measure of product portfolio complexity."
    - name: "total_cost_estimate"
      expr: SUM(CAST(cost_estimate_total AS DOUBLE))
      comment: "Total estimated cost across all BOMs. Drives product cost portfolio analysis and margin planning."
    - name: "avg_cost_estimate_per_bom"
      expr: AVG(CAST(cost_estimate_total AS DOUBLE))
      comment: "Average estimated cost per BOM. Benchmarks product cost levels for cost reduction targeting."
    - name: "avg_scrap_percentage"
      expr: AVG(CAST(scrap_percentage AS DOUBLE))
      comment: "Average scrap percentage across BOMs. High scrap rates drive material cost and yield improvement initiatives."
    - name: "avg_weight_total"
      expr: AVG(CAST(weight_total AS DOUBLE))
      comment: "Average total BOM weight. Supports product weight targets, logistics cost analysis, and sustainability reporting."
    - name: "configurable_boms"
      expr: COUNT(CASE WHEN is_configurable = TRUE THEN 1 END)
      comment: "Number of configurable BOMs. Measures product variant complexity and configure-to-order capability."
    - name: "critical_boms"
      expr: COUNT(CASE WHEN is_critical_bom = TRUE THEN 1 END)
      comment: "Number of critical BOMs requiring enhanced governance. Drives prioritized change control and supply chain risk management."
    - name: "avg_lot_size"
      expr: AVG(CAST(lot_size AS DOUBLE))
      comment: "Average lot size across BOMs. Informs production planning and procurement batch sizing decisions."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`engineering_design_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Design review gate metrics tracking review outcomes, action item closure, and compliance status — measures design governance effectiveness and product development quality."
  source: "`vibe_manufacturing_v1`.`engineering`.`design_review`"
  dimensions:
    - name: "review_type"
      expr: review_type
      comment: "Type of design review (e.g. PDR, CDR, PRR, Gate Review) for phase-gate analysis."
    - name: "review_status"
      expr: review_status
      comment: "Current status of the design review (e.g. Scheduled, Completed, Deferred) for pipeline management."
    - name: "gate_decision"
      expr: gate_decision
      comment: "Gate decision outcome (e.g. Pass, Conditional Pass, Fail) — the primary quality gate KPI for design governance."
    - name: "apqp_phase"
      expr: apqp_phase
      comment: "APQP phase associated with the design review for product development lifecycle analysis."
    - name: "design_maturity_level"
      expr: design_maturity_level
      comment: "Assessed design maturity level at time of review for readiness tracking."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status assessed during the design review for regulatory risk tracking."
    - name: "review_date_month"
      expr: DATE_TRUNC('MONTH', review_date)
      comment: "Month the design review was conducted, for review cadence and quality trend analysis."
  measures:
    - name: "total_design_reviews"
      expr: COUNT(1)
      comment: "Total number of design reviews conducted. Baseline measure of design governance activity."
    - name: "gate_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN gate_decision = 'Pass' THEN 1 END) / NULLIF(COUNT(CASE WHEN gate_decision IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of design reviews with a passing gate decision. Core design quality KPI — low pass rates signal systemic design readiness issues."
    - name: "avg_open_action_items"
      expr: AVG(CAST(open_action_item_count AS DOUBLE))
      comment: "Average number of open action items per design review. High values indicate design maturity gaps requiring management intervention."
    - name: "total_action_items"
      expr: SUM(CAST(action_item_count AS DOUBLE))
      comment: "Total action items generated across all design reviews. Measures design review rigor and issue identification effectiveness."
    - name: "avg_criteria_pass_count"
      expr: AVG(CAST(criteria_pass_count AS DOUBLE))
      comment: "Average number of gate criteria passed per review. Measures design completeness at each review stage."
    - name: "avg_criteria_fail_count"
      expr: AVG(CAST(criteria_fail_count AS DOUBLE))
      comment: "Average number of gate criteria failed per review. Identifies systemic design gaps requiring targeted improvement."
    - name: "avg_meeting_duration_minutes"
      expr: AVG(CAST(meeting_duration_minutes AS DOUBLE))
      comment: "Average design review meeting duration in minutes. Informs review process efficiency and scheduling optimization."
    - name: "reviews_requiring_approval"
      expr: COUNT(CASE WHEN approval_required_flag = TRUE THEN 1 END)
      comment: "Number of design reviews requiring formal approval. Measures governance workload and approval pipeline."
$$;