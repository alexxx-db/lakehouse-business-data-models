-- Metric views for domain: engineering | Business: Manufacturing | Version: 2 | Generated on: 2026-07-10 14:39:56

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`engineering_eco`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Engineering Change Order (ECO) metrics tracking change volume, cost impact, cycle time, and approval efficiency — critical for product lifecycle management and change control governance."
  source: "`vibe_manufacturing_v1`.`engineering`.`eco`"
  dimensions:
    - name: "change_type"
      expr: change_type
      comment: "Type of engineering change (e.g., design, process, material) — primary segmentation for change analysis."
    - name: "change_priority"
      expr: change_priority
      comment: "Priority level of the change order — used to segment urgent vs. routine changes."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle state of the ECO (e.g., draft, submitted, approved, closed) — tracks change progression."
    - name: "reason_code"
      expr: reason_code
      comment: "Standardized reason code for the change — enables root cause and trend analysis."
    - name: "effectivity_type"
      expr: effectivity_type
      comment: "How the change takes effect (e.g., date-based, serial-based) — impacts implementation planning."
    - name: "customer_approval_received"
      expr: customer_approval_received
      comment: "Whether customer approval was received — critical for customer-facing changes."
    - name: "initiated_year"
      expr: YEAR(initiated_date)
      comment: "Year the ECO was initiated — enables year-over-year trend analysis."
    - name: "initiated_quarter"
      expr: CONCAT('Q', QUARTER(initiated_date), '-', YEAR(initiated_date))
      comment: "Quarter the ECO was initiated — enables quarterly trend analysis."
    - name: "initiated_month"
      expr: DATE_TRUNC('MONTH', initiated_date)
      comment: "Month the ECO was initiated — enables monthly trend analysis."
  measures:
    - name: "total_eco_count"
      expr: COUNT(1)
      comment: "Total number of engineering change orders — baseline volume metric for change activity."
    - name: "total_estimated_cost_impact"
      expr: SUM(CAST(estimated_cost_impact AS DOUBLE))
      comment: "Sum of estimated cost impacts across all ECOs — forecasts financial exposure from changes."
    - name: "total_actual_cost_impact"
      expr: SUM(CAST(actual_cost_impact AS DOUBLE))
      comment: "Sum of actual cost impacts across all ECOs — measures realized financial impact of changes."
    - name: "avg_estimated_cost_impact"
      expr: AVG(CAST(estimated_cost_impact AS DOUBLE))
      comment: "Average estimated cost impact per ECO — indicates typical change cost magnitude."
    - name: "avg_actual_cost_impact"
      expr: AVG(CAST(actual_cost_impact AS DOUBLE))
      comment: "Average actual cost impact per ECO — measures typical realized change cost."
    - name: "total_affected_items"
      expr: SUM(CAST(affected_items_count AS BIGINT))
      comment: "Total number of items affected across all ECOs — measures change scope and complexity."
    - name: "avg_affected_items_per_eco"
      expr: AVG(CAST(affected_items_count AS DOUBLE))
      comment: "Average number of items affected per ECO — indicates typical change breadth."
    - name: "eco_requiring_customer_approval_count"
      expr: COUNT(CASE WHEN requires_customer_approval = TRUE THEN 1 END)
      comment: "Count of ECOs requiring customer approval — measures customer-facing change volume."
    - name: "eco_with_customer_approval_received_count"
      expr: COUNT(CASE WHEN customer_approval_received = TRUE THEN 1 END)
      comment: "Count of ECOs where customer approval was received — tracks customer approval completion."
    - name: "eco_requiring_supplier_notification_count"
      expr: COUNT(CASE WHEN requires_supplier_notification = TRUE THEN 1 END)
      comment: "Count of ECOs requiring supplier notification — measures supply chain coordination needs."
    - name: "closed_eco_count"
      expr: COUNT(CASE WHEN closure_date IS NOT NULL THEN 1 END)
      comment: "Count of ECOs that have been closed — measures change completion rate."
    - name: "approved_eco_count"
      expr: COUNT(CASE WHEN approval_date IS NOT NULL THEN 1 END)
      comment: "Count of ECOs that have been approved — tracks approval throughput."
    - name: "implemented_eco_count"
      expr: COUNT(CASE WHEN implementation_date IS NOT NULL THEN 1 END)
      comment: "Count of ECOs that have been implemented — measures change execution completion."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`engineering_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Engineering project portfolio metrics tracking budget performance, timeline adherence, complexity, and design quality — essential for R&D and product development governance."
  source: "`vibe_manufacturing_v1`.`engineering`.`project`"
  dimensions:
    - name: "project_status"
      expr: project_status
      comment: "Current status of the project (e.g., active, on-hold, completed) — primary segmentation for portfolio health."
    - name: "project_type"
      expr: project_type
      comment: "Type of engineering project (e.g., new product, redesign, cost reduction) — enables strategic portfolio mix analysis."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the project — used to segment strategic vs. tactical initiatives."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level of the project — critical for portfolio risk management."
    - name: "program_phase"
      expr: program_phase
      comment: "Current phase of the project (e.g., concept, design, validation, launch) — tracks project lifecycle progression."
    - name: "design_methodology"
      expr: design_methodology
      comment: "Design methodology used (e.g., agile, waterfall, lean) — enables methodology effectiveness analysis."
    - name: "ppap_required"
      expr: ppap_required
      comment: "Whether Production Part Approval Process is required — segments automotive/regulated projects."
    - name: "dfmea_completed"
      expr: dfmea_completed
      comment: "Whether Design Failure Mode Effects Analysis is completed — tracks design quality gate completion."
    - name: "pfmea_completed"
      expr: pfmea_completed
      comment: "Whether Process Failure Mode Effects Analysis is completed — tracks process quality gate completion."
    - name: "start_year"
      expr: YEAR(start_date)
      comment: "Year the project started — enables cohort analysis by project vintage."
    - name: "target_launch_quarter"
      expr: CONCAT('Q', QUARTER(target_launch_date), '-', YEAR(target_launch_date))
      comment: "Target launch quarter — enables pipeline and capacity planning."
  measures:
    - name: "total_project_count"
      expr: COUNT(1)
      comment: "Total number of engineering projects — baseline portfolio size metric."
    - name: "total_budget_allocated"
      expr: SUM(CAST(budget_allocated_amount AS DOUBLE))
      comment: "Total budget allocated across all projects — measures total R&D investment."
    - name: "total_budget_spent"
      expr: SUM(CAST(budget_spent_amount AS DOUBLE))
      comment: "Total budget spent across all projects — measures actual R&D expenditure."
    - name: "avg_budget_allocated_per_project"
      expr: AVG(CAST(budget_allocated_amount AS DOUBLE))
      comment: "Average budget allocated per project — indicates typical project investment size."
    - name: "avg_budget_spent_per_project"
      expr: AVG(CAST(budget_spent_amount AS DOUBLE))
      comment: "Average budget spent per project — measures typical project cost."
    - name: "total_eco_count_across_projects"
      expr: SUM(CAST(eco_count AS BIGINT))
      comment: "Total number of ECOs across all projects — measures change activity and design stability."
    - name: "avg_eco_count_per_project"
      expr: AVG(CAST(eco_count AS DOUBLE))
      comment: "Average number of ECOs per project — indicates typical design churn."
    - name: "total_design_review_count"
      expr: SUM(CAST(design_review_count AS BIGINT))
      comment: "Total number of design reviews across all projects — measures design governance rigor."
    - name: "avg_design_review_count_per_project"
      expr: AVG(CAST(design_review_count AS DOUBLE))
      comment: "Average number of design reviews per project — indicates typical review intensity."
    - name: "total_prototype_count"
      expr: SUM(CAST(prototype_count AS BIGINT))
      comment: "Total number of prototypes across all projects — measures development iteration volume."
    - name: "avg_prototype_count_per_project"
      expr: AVG(CAST(prototype_count AS DOUBLE))
      comment: "Average number of prototypes per project — indicates typical iteration cycles."
    - name: "projects_with_dfmea_completed_count"
      expr: COUNT(CASE WHEN dfmea_completed = TRUE THEN 1 END)
      comment: "Count of projects with DFMEA completed — tracks design quality gate compliance."
    - name: "projects_with_pfmea_completed_count"
      expr: COUNT(CASE WHEN pfmea_completed = TRUE THEN 1 END)
      comment: "Count of projects with PFMEA completed — tracks process quality gate compliance."
    - name: "projects_with_dfm_analysis_completed_count"
      expr: COUNT(CASE WHEN dfm_analysis_completed = TRUE THEN 1 END)
      comment: "Count of projects with Design for Manufacturability analysis completed — tracks manufacturing readiness."
    - name: "projects_requiring_ppap_count"
      expr: COUNT(CASE WHEN ppap_required = TRUE THEN 1 END)
      comment: "Count of projects requiring PPAP — measures automotive/regulated project volume."
    - name: "projects_approved_count"
      expr: COUNT(CASE WHEN approved_timestamp IS NOT NULL THEN 1 END)
      comment: "Count of projects that have been approved — tracks project approval throughput."
    - name: "projects_launched_count"
      expr: COUNT(CASE WHEN actual_launch_date IS NOT NULL THEN 1 END)
      comment: "Count of projects that have launched — measures project completion and delivery."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`engineering_component`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Component master metrics tracking inventory value, lifecycle health, compliance status, and sourcing strategy — critical for product cost management and supply chain planning."
  source: "`vibe_manufacturing_v1`.`engineering`.`component`"
  dimensions:
    - name: "component_type"
      expr: component_type
      comment: "Type of component (e.g., mechanical, electrical, software) — primary segmentation for component portfolio."
    - name: "lifecycle_phase"
      expr: lifecycle_phase
      comment: "Current lifecycle phase (e.g., active, phase-out, obsolete) — critical for lifecycle management."
    - name: "release_status"
      expr: release_status
      comment: "Release status of the component (e.g., draft, released, frozen) — tracks design maturity."
    - name: "make_or_buy"
      expr: make_or_buy
      comment: "Whether component is made in-house or purchased — key sourcing strategy dimension."
    - name: "abc_classification"
      expr: abc_classification
      comment: "ABC classification for inventory management — segments components by value/criticality."
    - name: "technology_family"
      expr: technology_family
      comment: "Technology family of the component — enables technology portfolio analysis."
    - name: "functional_group"
      expr: functional_group
      comment: "Functional group or subsystem — enables functional cost and complexity analysis."
    - name: "rohs_compliant_flag"
      expr: rohs_compliant_flag
      comment: "Whether component is RoHS compliant — critical for environmental compliance tracking."
    - name: "reach_compliant_flag"
      expr: reach_compliant_flag
      comment: "Whether component is REACH compliant — critical for chemical substance compliance."
    - name: "ce_marking_flag"
      expr: ce_marking_flag
      comment: "Whether component requires CE marking — tracks EU regulatory compliance."
    - name: "hazardous_material_flag"
      expr: hazardous_material_flag
      comment: "Whether component contains hazardous materials — critical for safety and disposal planning."
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the component became effective — enables vintage analysis."
  measures:
    - name: "total_component_count"
      expr: COUNT(1)
      comment: "Total number of components — baseline portfolio size metric."
    - name: "active_component_count"
      expr: COUNT(CASE WHEN lifecycle_phase = 'Active' THEN 1 END)
      comment: "Count of active components — measures current usable component base."
    - name: "total_standard_cost"
      expr: SUM(CAST(standard_cost AS DOUBLE))
      comment: "Sum of standard costs across all components — measures total component inventory value at standard cost."
    - name: "avg_standard_cost_per_component"
      expr: AVG(CAST(standard_cost AS DOUBLE))
      comment: "Average standard cost per component — indicates typical component cost."
    - name: "total_weight_kg"
      expr: SUM(CAST(weight_kg AS DOUBLE))
      comment: "Total weight of all components in kilograms — measures total material mass for logistics and sustainability."
    - name: "avg_weight_kg_per_component"
      expr: AVG(CAST(weight_kg AS DOUBLE))
      comment: "Average weight per component in kilograms — indicates typical component mass."
    - name: "total_dfm_score"
      expr: SUM(CAST(dfm_score AS DOUBLE))
      comment: "Sum of Design for Manufacturability scores — aggregate manufacturability assessment."
    - name: "avg_dfm_score_per_component"
      expr: AVG(CAST(dfm_score AS DOUBLE))
      comment: "Average DFM score per component — measures typical manufacturability quality."
    - name: "total_safety_stock_quantity"
      expr: SUM(CAST(safety_stock_quantity AS DOUBLE))
      comment: "Total safety stock quantity across all components — measures inventory buffer requirements."
    - name: "total_reorder_point"
      expr: SUM(CAST(reorder_point AS DOUBLE))
      comment: "Total reorder point across all components — measures aggregate replenishment trigger level."
    - name: "total_minimum_order_quantity"
      expr: SUM(CAST(minimum_order_quantity AS DOUBLE))
      comment: "Total minimum order quantity across all components — measures procurement constraint impact."
    - name: "rohs_compliant_component_count"
      expr: COUNT(CASE WHEN rohs_compliant_flag = TRUE THEN 1 END)
      comment: "Count of RoHS compliant components — tracks environmental compliance coverage."
    - name: "reach_compliant_component_count"
      expr: COUNT(CASE WHEN reach_compliant_flag = TRUE THEN 1 END)
      comment: "Count of REACH compliant components — tracks chemical compliance coverage."
    - name: "ce_marking_required_component_count"
      expr: COUNT(CASE WHEN ce_marking_flag = TRUE THEN 1 END)
      comment: "Count of components requiring CE marking — measures EU regulatory scope."
    - name: "hazardous_material_component_count"
      expr: COUNT(CASE WHEN hazardous_material_flag = TRUE THEN 1 END)
      comment: "Count of components with hazardous materials — tracks safety and disposal risk."
    - name: "make_component_count"
      expr: COUNT(CASE WHEN make_or_buy = 'Make' THEN 1 END)
      comment: "Count of make components — measures in-house manufacturing scope."
    - name: "buy_component_count"
      expr: COUNT(CASE WHEN make_or_buy = 'Buy' THEN 1 END)
      comment: "Count of buy components — measures procurement scope."
    - name: "obsolete_component_count"
      expr: COUNT(CASE WHEN obsolescence_date IS NOT NULL THEN 1 END)
      comment: "Count of components with obsolescence date set — measures lifecycle risk exposure."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`engineering_test_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Engineering test result metrics tracking test pass rates, failure modes, retest frequency, and regulatory compliance — essential for product quality assurance and validation governance."
  source: "`vibe_manufacturing_v1`.`engineering`.`test_result`"
  dimensions:
    - name: "test_outcome"
      expr: test_outcome
      comment: "Outcome of the test (e.g., pass, fail, conditional) — primary segmentation for quality analysis."
    - name: "test_type"
      expr: test_type
      comment: "Type of test performed (e.g., functional, environmental, safety) — enables test portfolio analysis."
    - name: "test_status"
      expr: test_status
      comment: "Current status of the test (e.g., planned, in-progress, completed) — tracks test execution progress."
    - name: "test_purpose"
      expr: test_purpose
      comment: "Purpose of the test (e.g., design validation, production qualification) — segments tests by objective."
    - name: "prototype_phase"
      expr: prototype_phase
      comment: "Prototype phase during which test was conducted — enables phase-based quality trend analysis."
    - name: "failure_mode_code"
      expr: failure_mode_code
      comment: "Standardized failure mode code — critical for failure analysis and FMEA linkage."
    - name: "retest_flag"
      expr: retest_flag
      comment: "Whether this is a retest — measures test efficiency and first-pass yield."
    - name: "root_cause_analysis_required"
      expr: root_cause_analysis_required
      comment: "Whether root cause analysis is required — segments critical failures requiring investigation."
    - name: "regulatory_submission_flag"
      expr: regulatory_submission_flag
      comment: "Whether test results are for regulatory submission — tracks compliance testing volume."
    - name: "test_facility"
      expr: test_facility
      comment: "Facility where test was conducted — enables facility performance comparison."
    - name: "test_year"
      expr: YEAR(test_date)
      comment: "Year the test was conducted — enables year-over-year quality trend analysis."
    - name: "test_quarter"
      expr: CONCAT('Q', QUARTER(test_date), '-', YEAR(test_date))
      comment: "Quarter the test was conducted — enables quarterly quality trend analysis."
    - name: "test_month"
      expr: DATE_TRUNC('MONTH', test_date)
      comment: "Month the test was conducted — enables monthly quality trend analysis."
  measures:
    - name: "total_test_count"
      expr: COUNT(1)
      comment: "Total number of test results — baseline test volume metric."
    - name: "passed_test_count"
      expr: COUNT(CASE WHEN test_outcome = 'Pass' THEN 1 END)
      comment: "Count of tests that passed — measures test success volume."
    - name: "failed_test_count"
      expr: COUNT(CASE WHEN test_outcome = 'Fail' THEN 1 END)
      comment: "Count of tests that failed — measures test failure volume and quality risk."
    - name: "retest_count"
      expr: COUNT(CASE WHEN retest_flag = TRUE THEN 1 END)
      comment: "Count of retests — measures test inefficiency and rework."
    - name: "tests_requiring_rca_count"
      expr: COUNT(CASE WHEN root_cause_analysis_required = TRUE THEN 1 END)
      comment: "Count of tests requiring root cause analysis — measures critical failure volume."
    - name: "regulatory_submission_test_count"
      expr: COUNT(CASE WHEN regulatory_submission_flag = TRUE THEN 1 END)
      comment: "Count of tests for regulatory submission — measures compliance testing activity."
    - name: "total_test_duration_hours"
      expr: SUM(CAST(test_duration_hours AS DOUBLE))
      comment: "Total test duration in hours across all tests — measures total test resource consumption."
    - name: "avg_test_duration_hours"
      expr: AVG(CAST(test_duration_hours AS DOUBLE))
      comment: "Average test duration in hours — indicates typical test cycle time."
    - name: "avg_measured_value"
      expr: AVG(CAST(measured_value AS DOUBLE))
      comment: "Average measured value across all tests — provides central tendency of test measurements."
    - name: "avg_measurement_uncertainty"
      expr: AVG(CAST(measurement_uncertainty AS DOUBLE))
      comment: "Average measurement uncertainty — indicates typical test precision."
    - name: "tests_within_upper_limit_count"
      expr: COUNT(CASE WHEN measured_value <= acceptance_criteria_upper_limit THEN 1 END)
      comment: "Count of tests where measured value is within upper acceptance limit — tracks upper spec compliance."
    - name: "tests_within_lower_limit_count"
      expr: COUNT(CASE WHEN measured_value >= acceptance_criteria_lower_limit THEN 1 END)
      comment: "Count of tests where measured value is within lower acceptance limit — tracks lower spec compliance."
    - name: "tests_within_both_limits_count"
      expr: COUNT(CASE WHEN measured_value >= acceptance_criteria_lower_limit AND measured_value <= acceptance_criteria_upper_limit THEN 1 END)
      comment: "Count of tests where measured value is within both acceptance limits — measures full spec compliance."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`engineering_bom`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bill of Materials (BOM) metrics tracking BOM complexity, cost estimates, approval status, and configuration management — critical for product cost control and manufacturing planning."
  source: "`vibe_manufacturing_v1`.`engineering`.`bom`"
  dimensions:
    - name: "bom_type"
      expr: bom_type
      comment: "Type of BOM (e.g., engineering, manufacturing, service) — primary segmentation for BOM analysis."
    - name: "bom_status"
      expr: bom_status
      comment: "Current status of the BOM (e.g., draft, released, frozen) — tracks BOM maturity."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the BOM — tracks approval workflow progress."
    - name: "category"
      expr: category
      comment: "BOM category — enables categorical segmentation for analysis."
    - name: "explosion_type"
      expr: explosion_type
      comment: "Explosion type (e.g., single-level, multi-level) — indicates BOM structure complexity."
    - name: "is_configurable"
      expr: is_configurable
      comment: "Whether BOM is configurable — segments standard vs. configurable products."
    - name: "is_phantom_bom"
      expr: is_phantom_bom
      comment: "Whether BOM is a phantom BOM — identifies transient assemblies."
    - name: "is_critical_bom"
      expr: is_critical_bom
      comment: "Whether BOM is critical — segments high-priority BOMs."
    - name: "usage"
      expr: usage
      comment: "Usage context of the BOM — enables usage-based segmentation."
    - name: "approved_year"
      expr: YEAR(approved_date)
      comment: "Year the BOM was approved — enables approval trend analysis."
    - name: "effective_from_year"
      expr: YEAR(effective_from_date)
      comment: "Year the BOM became effective — enables effectivity trend analysis."
  measures:
    - name: "total_bom_count"
      expr: COUNT(1)
      comment: "Total number of BOMs — baseline BOM portfolio size metric."
    - name: "approved_bom_count"
      expr: COUNT(CASE WHEN approved_date IS NOT NULL THEN 1 END)
      comment: "Count of approved BOMs — measures BOM approval throughput."
    - name: "configurable_bom_count"
      expr: COUNT(CASE WHEN is_configurable = TRUE THEN 1 END)
      comment: "Count of configurable BOMs — measures product configuration complexity."
    - name: "phantom_bom_count"
      expr: COUNT(CASE WHEN is_phantom_bom = TRUE THEN 1 END)
      comment: "Count of phantom BOMs — tracks transient assembly usage."
    - name: "critical_bom_count"
      expr: COUNT(CASE WHEN is_critical_bom = TRUE THEN 1 END)
      comment: "Count of critical BOMs — measures high-priority BOM volume."
    - name: "total_cost_estimate"
      expr: SUM(CAST(cost_estimate_total AS DOUBLE))
      comment: "Sum of total cost estimates across all BOMs — measures aggregate product cost at BOM level."
    - name: "avg_cost_estimate_per_bom"
      expr: AVG(CAST(cost_estimate_total AS DOUBLE))
      comment: "Average cost estimate per BOM — indicates typical product cost."
    - name: "total_weight"
      expr: SUM(CAST(weight_total AS DOUBLE))
      comment: "Sum of total weights across all BOMs — measures aggregate product mass for logistics and sustainability."
    - name: "avg_weight_per_bom"
      expr: AVG(CAST(weight_total AS DOUBLE))
      comment: "Average weight per BOM — indicates typical product mass."
    - name: "total_lot_size"
      expr: SUM(CAST(lot_size AS DOUBLE))
      comment: "Sum of lot sizes across all BOMs — measures aggregate production batch sizing."
    - name: "avg_lot_size_per_bom"
      expr: AVG(CAST(lot_size AS DOUBLE))
      comment: "Average lot size per BOM — indicates typical production batch size."
    - name: "total_quantity_basis"
      expr: SUM(CAST(quantity_basis AS DOUBLE))
      comment: "Sum of quantity basis across all BOMs — measures aggregate BOM quantity foundation."
    - name: "avg_scrap_percentage"
      expr: AVG(CAST(scrap_percentage AS DOUBLE))
      comment: "Average scrap percentage across all BOMs — indicates typical material waste rate."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`engineering_revision`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Engineering revision metrics tracking revision volume, change impact, compliance gate completion, and lifecycle state — essential for design change control and product maturity governance."
  source: "`vibe_manufacturing_v1`.`engineering`.`revision`"
  dimensions:
    - name: "lifecycle_state"
      expr: lifecycle_state
      comment: "Current lifecycle state of the revision (e.g., draft, released, obsolete) — primary segmentation for revision maturity."
    - name: "revision_type"
      expr: revision_type
      comment: "Type of revision (e.g., major, minor, ECO-driven) — segments revisions by change magnitude."
    - name: "change_category"
      expr: change_category
      comment: "Category of change (e.g., design, process, documentation) — enables change type analysis."
    - name: "change_impact_level"
      expr: change_impact_level
      comment: "Impact level of the change (e.g., low, medium, high) — critical for risk assessment."
    - name: "interchangeability_code"
      expr: interchangeability_code
      comment: "Interchangeability code — indicates whether revision is backward/forward compatible."
    - name: "mass_production_approved"
      expr: mass_production_approved
      comment: "Whether revision is approved for mass production — tracks production readiness."
    - name: "dfmea_completed"
      expr: dfmea_completed
      comment: "Whether Design FMEA is completed — tracks design quality gate compliance."
    - name: "pfmea_completed"
      expr: pfmea_completed
      comment: "Whether Process FMEA is completed — tracks process quality gate compliance."
    - name: "dfm_analysis_completed"
      expr: dfm_analysis_completed
      comment: "Whether Design for Manufacturability analysis is completed — tracks manufacturing readiness."
    - name: "ppap_required"
      expr: ppap_required
      comment: "Whether PPAP is required — segments automotive/regulated revisions."
    - name: "rohs_compliant"
      expr: rohs_compliant
      comment: "Whether revision is RoHS compliant — tracks environmental compliance."
    - name: "reach_compliant"
      expr: reach_compliant
      comment: "Whether revision is REACH compliant — tracks chemical compliance."
    - name: "ce_marking_required"
      expr: ce_marking_required
      comment: "Whether CE marking is required — tracks EU regulatory compliance."
    - name: "release_year"
      expr: YEAR(release_date)
      comment: "Year the revision was released — enables release trend analysis."
    - name: "approval_year"
      expr: YEAR(approval_date)
      comment: "Year the revision was approved — enables approval trend analysis."
  measures:
    - name: "total_revision_count"
      expr: COUNT(1)
      comment: "Total number of revisions — baseline revision volume metric."
    - name: "released_revision_count"
      expr: COUNT(CASE WHEN release_date IS NOT NULL THEN 1 END)
      comment: "Count of released revisions — measures revision release throughput."
    - name: "approved_revision_count"
      expr: COUNT(CASE WHEN approval_date IS NOT NULL THEN 1 END)
      comment: "Count of approved revisions — tracks approval completion."
    - name: "mass_production_approved_revision_count"
      expr: COUNT(CASE WHEN mass_production_approved = TRUE THEN 1 END)
      comment: "Count of revisions approved for mass production — measures production-ready design volume."
    - name: "revisions_with_dfmea_completed_count"
      expr: COUNT(CASE WHEN dfmea_completed = TRUE THEN 1 END)
      comment: "Count of revisions with DFMEA completed — tracks design quality gate compliance."
    - name: "revisions_with_pfmea_completed_count"
      expr: COUNT(CASE WHEN pfmea_completed = TRUE THEN 1 END)
      comment: "Count of revisions with PFMEA completed — tracks process quality gate compliance."
    - name: "revisions_with_dfm_analysis_completed_count"
      expr: COUNT(CASE WHEN dfm_analysis_completed = TRUE THEN 1 END)
      comment: "Count of revisions with DFM analysis completed — tracks manufacturing readiness."
    - name: "revisions_requiring_ppap_count"
      expr: COUNT(CASE WHEN ppap_required = TRUE THEN 1 END)
      comment: "Count of revisions requiring PPAP — measures automotive/regulated revision volume."
    - name: "prototype_tested_revision_count"
      expr: COUNT(CASE WHEN prototype_tested = TRUE THEN 1 END)
      comment: "Count of revisions where prototype was tested — tracks validation completion."
    - name: "rohs_compliant_revision_count"
      expr: COUNT(CASE WHEN rohs_compliant = TRUE THEN 1 END)
      comment: "Count of RoHS compliant revisions — tracks environmental compliance coverage."
    - name: "reach_compliant_revision_count"
      expr: COUNT(CASE WHEN reach_compliant = TRUE THEN 1 END)
      comment: "Count of REACH compliant revisions — tracks chemical compliance coverage."
    - name: "ce_marking_required_revision_count"
      expr: COUNT(CASE WHEN ce_marking_required = TRUE THEN 1 END)
      comment: "Count of revisions requiring CE marking — measures EU regulatory scope."
    - name: "ul_certification_required_revision_count"
      expr: COUNT(CASE WHEN ul_certification_required = TRUE THEN 1 END)
      comment: "Count of revisions requiring UL certification — measures safety certification scope."
$$;