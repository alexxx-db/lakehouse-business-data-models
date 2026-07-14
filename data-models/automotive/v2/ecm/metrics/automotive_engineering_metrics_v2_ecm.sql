-- Metric views for domain: engineering | Business: Automotive | Version: 2 | Generated on: 2026-07-14 01:46:32

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`engineering_vehicle_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic vehicle program performance metrics tracking budget, cost targets, emissions, and program health for executive steering and portfolio management decisions."
  source: "`vibe_automotive_v1`.`engineering`.`vehicle_program`"
  dimensions:
    - name: "program_code"
      expr: program_code
      comment: "Unique vehicle program identifier for portfolio segmentation"
    - name: "program_name"
      expr: program_name
      comment: "Vehicle program name for business reporting"
    - name: "program_type"
      expr: program_type
      comment: "Program classification (new platform, facelift, derivative) for strategic analysis"
    - name: "vehicle_program_status"
      expr: vehicle_program_status
      comment: "Current program lifecycle status for portfolio health monitoring"
    - name: "segment"
      expr: segment
      comment: "Market segment (sedan, SUV, truck) for competitive positioning analysis"
    - name: "powertrain_type"
      expr: powertrain_type
      comment: "Powertrain architecture (ICE, BEV, PHEV, HEV) for electrification strategy tracking"
    - name: "target_market"
      expr: target_market
      comment: "Geographic market target for regional portfolio planning"
    - name: "platform_architecture"
      expr: platform_architecture
      comment: "Underlying platform for platform sharing and economies of scale analysis"
    - name: "regulatory_approval_status"
      expr: regulatory_approval_status
      comment: "Homologation and compliance status for launch readiness assessment"
    - name: "model_year_start"
      expr: model_year_start
      comment: "First model year for program lifecycle tracking"
    - name: "launch_year"
      expr: YEAR(launch_date)
      comment: "Launch year for time-series portfolio analysis"
    - name: "launch_quarter"
      expr: CONCAT('Q', QUARTER(launch_date), '-', YEAR(launch_date))
      comment: "Launch quarter for quarterly portfolio planning"
  measures:
    - name: "program_count"
      expr: COUNT(DISTINCT vehicle_program_id)
      comment: "Number of active vehicle programs in portfolio for capacity planning"
    - name: "total_budget_allocation"
      expr: SUM(CAST(budget_allocation AS DOUBLE))
      comment: "Total allocated budget across programs for investment portfolio management"
    - name: "avg_budget_per_program"
      expr: AVG(CAST(budget_allocation AS DOUBLE))
      comment: "Average program budget for benchmarking and resource allocation decisions"
    - name: "total_target_cost_per_vehicle"
      expr: SUM(CAST(target_cost_per_vehicle AS DOUBLE))
      comment: "Aggregate target vehicle cost for margin planning"
    - name: "avg_target_cost_per_vehicle"
      expr: AVG(CAST(target_cost_per_vehicle AS DOUBLE))
      comment: "Average target vehicle cost for competitive cost positioning"
    - name: "avg_target_emissions_g_per_km"
      expr: AVG(CAST(target_emissions_g_per_km AS DOUBLE))
      comment: "Average CO2 emissions target for fleet compliance and regulatory strategy"
    - name: "avg_target_fuel_efficiency_mpg"
      expr: AVG(CAST(target_fuel_efficiency_mpg AS DOUBLE))
      comment: "Average fuel efficiency target for CAFE/emissions compliance planning"
    - name: "avg_target_range_km"
      expr: AVG(CAST(target_range_km AS DOUBLE))
      comment: "Average electric range target for BEV competitiveness assessment"
    - name: "avg_target_weight_kg"
      expr: AVG(CAST(target_weight_kg AS DOUBLE))
      comment: "Average target vehicle weight for lightweighting strategy tracking"
    - name: "total_target_production_volume"
      expr: SUM(CAST(target_production_volume AS DOUBLE))
      comment: "Total planned production volume for capacity planning and supplier negotiations"
    - name: "avg_eco_count_per_program"
      expr: AVG(CAST(engineering_change_order_count AS DOUBLE))
      comment: "Average ECO count per program for design maturity and change management assessment"
    - name: "ota_capable_program_count"
      expr: SUM(CAST(CASE WHEN ota_update_capability = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Count of OTA-capable programs for connected vehicle strategy tracking"
    - name: "digital_twin_enabled_program_count"
      expr: SUM(CAST(CASE WHEN digital_twin_enabled = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Count of digital-twin-enabled programs for Industry 4.0 transformation tracking"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`engineering_change`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Engineering change order (ECO/ECN) performance metrics for change velocity, cost impact, and risk management to support agile product development and cost control."
  source: "`vibe_automotive_v1`.`engineering`.`change`"
  dimensions:
    - name: "change_number"
      expr: change_number
      comment: "Unique change order identifier for traceability"
    - name: "change_type"
      expr: change_type
      comment: "Change classification (ECO, ECN, deviation) for process governance"
    - name: "change_status"
      expr: change_status
      comment: "Current change status for workflow monitoring"
    - name: "priority"
      expr: priority
      comment: "Change priority level for resource allocation and expediting decisions"
    - name: "risk_level"
      expr: risk_level
      comment: "Risk assessment level for quality and safety governance"
    - name: "reason_category"
      expr: reason_category
      comment: "Root cause category for change pattern analysis and prevention"
    - name: "origin"
      expr: origin
      comment: "Change origin (design, manufacturing, supplier, field) for source analysis"
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Regulatory compliance indicator for homologation impact tracking"
    - name: "request_month"
      expr: DATE_TRUNC('MONTH', request_timestamp)
      comment: "Change request month for time-series velocity analysis"
    - name: "approval_month"
      expr: DATE_TRUNC('MONTH', approval_timestamp)
      comment: "Change approval month for cycle time tracking"
    - name: "implementation_month"
      expr: DATE_TRUNC('MONTH', implementation_date)
      comment: "Change implementation month for deployment tracking"
  measures:
    - name: "change_count"
      expr: COUNT(DISTINCT change_id)
      comment: "Total number of engineering changes for change velocity and maturity assessment"
    - name: "total_cost_estimate_gross"
      expr: SUM(CAST(cost_estimate_gross AS DOUBLE))
      comment: "Total gross cost impact of changes for budget variance analysis"
    - name: "total_cost_net"
      expr: SUM(CAST(cost_net AS DOUBLE))
      comment: "Total net cost impact after adjustments for financial impact tracking"
    - name: "avg_cost_per_change"
      expr: AVG(CAST(cost_net AS DOUBLE))
      comment: "Average cost per change for cost control benchmarking"
    - name: "high_risk_change_count"
      expr: SUM(CAST(CASE WHEN risk_level = 'High' THEN 1 ELSE 0 END AS INT))
      comment: "Count of high-risk changes for quality and safety governance"
    - name: "compliance_change_count"
      expr: SUM(CAST(CASE WHEN compliance_flag = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Count of compliance-driven changes for regulatory impact assessment"
    - name: "approved_change_count"
      expr: SUM(CAST(CASE WHEN change_status = 'Approved' THEN 1 ELSE 0 END AS INT))
      comment: "Count of approved changes for approval rate tracking"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`engineering_part_master`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Part master data quality and lifecycle metrics for engineering BOM governance, obsolescence management, and supplier quality tracking."
  source: "`vibe_automotive_v1`.`engineering`.`part_master`"
  dimensions:
    - name: "part_number"
      expr: part_number
      comment: "Unique part identifier for traceability"
    - name: "part_type"
      expr: part_type
      comment: "Part classification (raw material, component, assembly) for BOM structure analysis"
    - name: "part_family"
      expr: part_family
      comment: "Part family grouping for commonality and platform sharing analysis"
    - name: "part_classification"
      expr: part_classification
      comment: "ABC/XYZ classification for inventory and sourcing strategy"
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Part lifecycle stage (active, phase-out, obsolete) for obsolescence management"
    - name: "criticality"
      expr: criticality
      comment: "Part criticality level for risk management and dual-sourcing decisions"
    - name: "quality_rating"
      expr: quality_rating
      comment: "Supplier quality rating for sourcing decisions"
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current inspection status for quality gate tracking"
    - name: "material"
      expr: material
      comment: "Material type for sustainability and cost analysis"
    - name: "reach_compliance"
      expr: reach_compliance
      comment: "REACH compliance flag for regulatory risk management"
    - name: "rohs_compliance"
      expr: rohs_compliance
      comment: "RoHS compliance flag for electronics regulatory compliance"
    - name: "obsolescence_notice"
      expr: obsolescence_notice
      comment: "Obsolescence notice flag for proactive last-time-buy planning"
    - name: "is_active"
      expr: is_active
      comment: "Active status for current BOM coverage analysis"
  measures:
    - name: "part_count"
      expr: COUNT(DISTINCT part_master_id)
      comment: "Total number of parts in master data for complexity and commonality tracking"
    - name: "active_part_count"
      expr: SUM(CAST(CASE WHEN is_active = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Count of active parts for current BOM coverage"
    - name: "obsolete_part_count"
      expr: SUM(CAST(CASE WHEN lifecycle_status = 'Obsolete' THEN 1 ELSE 0 END AS INT))
      comment: "Count of obsolete parts for data cleanup and archival planning"
    - name: "obsolescence_notice_count"
      expr: SUM(CAST(CASE WHEN obsolescence_notice = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Count of parts with obsolescence notices for proactive last-time-buy actions"
    - name: "critical_part_count"
      expr: SUM(CAST(CASE WHEN criticality = 'Critical' THEN 1 ELSE 0 END AS INT))
      comment: "Count of critical parts for risk management and dual-sourcing strategy"
    - name: "total_part_cost_usd"
      expr: SUM(CAST(cost_usd AS DOUBLE))
      comment: "Total part cost for BOM cost rollup and target costing"
    - name: "avg_part_cost_usd"
      expr: AVG(CAST(cost_usd AS DOUBLE))
      comment: "Average part cost for cost benchmarking"
    - name: "avg_lead_time_days"
      expr: AVG(CAST(lead_time_days AS DOUBLE))
      comment: "Average part lead time for supply chain planning and buffer stock decisions"
    - name: "avg_weight_kg"
      expr: AVG(CAST(weight_kg AS DOUBLE))
      comment: "Average part weight for vehicle weight rollup and lightweighting strategy"
    - name: "reach_compliant_part_count"
      expr: SUM(CAST(CASE WHEN reach_compliance = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Count of REACH-compliant parts for regulatory compliance tracking"
    - name: "rohs_compliant_part_count"
      expr: SUM(CAST(CASE WHEN rohs_compliance = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Count of RoHS-compliant parts for electronics regulatory compliance"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`engineering_validation_test`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Design validation and verification (DVP&R) test performance metrics for quality gate tracking, compliance verification, and test efficiency optimization."
  source: "`vibe_automotive_v1`.`engineering`.`validation_test`"
  dimensions:
    - name: "test_name"
      expr: test_name
      comment: "Test name for test catalog and traceability"
    - name: "test_type"
      expr: test_type
      comment: "Test type (durability, performance, safety, emissions) for test portfolio analysis"
    - name: "test_category"
      expr: test_category
      comment: "Test category for test planning and resource allocation"
    - name: "test_phase"
      expr: test_phase
      comment: "Development phase (prototype, pre-production, production) for gate tracking"
    - name: "test_status"
      expr: test_status
      comment: "Current test status for test execution monitoring"
    - name: "test_result"
      expr: test_result
      comment: "Test outcome (pass, fail, conditional) for quality gate decisions"
    - name: "disposition"
      expr: disposition
      comment: "Final disposition for defect tracking and corrective action"
    - name: "test_approval_status"
      expr: test_approval_status
      comment: "Approval status for release readiness tracking"
    - name: "compliance_standard"
      expr: compliance_standard
      comment: "Regulatory standard (FMVSS, ECE, NCAP) for homologation tracking"
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Regulatory compliance indicator for certification readiness"
    - name: "is_critical"
      expr: is_critical
      comment: "Critical test flag for priority tracking and resource allocation"
    - name: "test_facility"
      expr: test_facility
      comment: "Test facility location for capacity planning and cost allocation"
    - name: "test_month"
      expr: DATE_TRUNC('MONTH', test_timestamp)
      comment: "Test execution month for time-series test velocity tracking"
  measures:
    - name: "test_count"
      expr: COUNT(DISTINCT validation_test_id)
      comment: "Total number of validation tests for test coverage and workload tracking"
    - name: "passed_test_count"
      expr: SUM(CAST(CASE WHEN test_result = 'Pass' THEN 1 ELSE 0 END AS INT))
      comment: "Count of passed tests for quality gate pass rate calculation"
    - name: "failed_test_count"
      expr: SUM(CAST(CASE WHEN test_result = 'Fail' THEN 1 ELSE 0 END AS INT))
      comment: "Count of failed tests for quality issue identification and corrective action"
    - name: "critical_test_count"
      expr: SUM(CAST(CASE WHEN is_critical = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Count of critical tests for priority tracking and gate readiness"
    - name: "regulatory_test_count"
      expr: SUM(CAST(CASE WHEN regulatory_compliance_flag = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Count of regulatory tests for homologation readiness tracking"
    - name: "avg_test_duration_minutes"
      expr: AVG(CAST(test_duration_minutes AS DOUBLE))
      comment: "Average test duration for test efficiency and capacity planning"
    - name: "avg_emission_co2_g_per_km"
      expr: AVG(CAST(emission_co2_g_per_km AS DOUBLE))
      comment: "Average measured CO2 emissions for fleet compliance tracking"
    - name: "avg_noise_db"
      expr: AVG(CAST(noise_db AS DOUBLE))
      comment: "Average measured noise level for NVH compliance verification"
    - name: "avg_torque_nm"
      expr: AVG(CAST(torque_nm AS DOUBLE))
      comment: "Average measured torque for powertrain performance validation"
    - name: "avg_variance_percent"
      expr: AVG(CAST(variance_percent AS DOUBLE))
      comment: "Average test variance from target for design margin assessment"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`engineering_milestone`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vehicle program milestone and gate performance metrics for program health monitoring, schedule adherence, and launch readiness assessment."
  source: "`vibe_automotive_v1`.`engineering`.`milestone`"
  dimensions:
    - name: "milestone_code"
      expr: milestone_code
      comment: "Milestone identifier (P0, P1, P2, SOP) for program phase tracking"
    - name: "milestone_name"
      expr: milestone_name
      comment: "Milestone name for business reporting"
    - name: "milestone_type"
      expr: milestone_type
      comment: "Milestone classification (gate, deliverable, decision point) for governance"
    - name: "milestone_status"
      expr: milestone_status
      comment: "Current milestone status for program health monitoring"
    - name: "is_critical"
      expr: is_critical
      comment: "Critical path flag for schedule risk management"
    - name: "risk_level"
      expr: risk_level
      comment: "Risk assessment level for escalation and mitigation planning"
    - name: "gate_review_outcome"
      expr: gate_review_outcome
      comment: "Gate review decision (pass, conditional, fail) for quality gate tracking"
    - name: "compliance_standard"
      expr: compliance_standard
      comment: "Applicable compliance standard for regulatory gate tracking"
    - name: "plant_location"
      expr: plant_location
      comment: "Manufacturing plant for multi-site program coordination"
    - name: "planned_month"
      expr: DATE_TRUNC('MONTH', planned_date)
      comment: "Planned milestone month for baseline schedule tracking"
    - name: "actual_month"
      expr: DATE_TRUNC('MONTH', actual_date)
      comment: "Actual milestone month for schedule variance analysis"
  measures:
    - name: "milestone_count"
      expr: COUNT(DISTINCT milestone_id)
      comment: "Total number of milestones for program complexity and governance tracking"
    - name: "critical_milestone_count"
      expr: SUM(CAST(CASE WHEN is_critical = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Count of critical path milestones for schedule risk assessment"
    - name: "completed_milestone_count"
      expr: SUM(CAST(CASE WHEN milestone_status = 'Completed' THEN 1 ELSE 0 END AS INT))
      comment: "Count of completed milestones for program progress tracking"
    - name: "delayed_milestone_count"
      expr: SUM(CAST(CASE WHEN milestone_status = 'Delayed' THEN 1 ELSE 0 END AS INT))
      comment: "Count of delayed milestones for schedule risk and escalation"
    - name: "high_risk_milestone_count"
      expr: SUM(CAST(CASE WHEN risk_level = 'High' THEN 1 ELSE 0 END AS INT))
      comment: "Count of high-risk milestones for mitigation planning"
    - name: "avg_open_action_items"
      expr: AVG(CAST(open_action_items_count AS DOUBLE))
      comment: "Average open action items per milestone for gate readiness assessment"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`engineering_fmea_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Failure Mode and Effects Analysis (FMEA) risk metrics for design and process quality, risk prioritization, and corrective action tracking per IATF 16949."
  source: "`vibe_automotive_v1`.`engineering`.`fmea_record`"
  dimensions:
    - name: "fmea_number"
      expr: fmea_number
      comment: "Unique FMEA identifier for traceability"
    - name: "fmea_type"
      expr: fmea_type
      comment: "FMEA type (DFMEA, PFMEA) for quality process governance"
    - name: "fmea_record_status"
      expr: fmea_record_status
      comment: "Current FMEA status for completion tracking"
    - name: "risk_category"
      expr: risk_category
      comment: "Risk category for risk portfolio analysis"
    - name: "severity_rating"
      expr: severity_rating
      comment: "Severity rating (1-10) for impact assessment"
    - name: "occurrence_rating"
      expr: occurrence_rating
      comment: "Occurrence rating (1-10) for frequency assessment"
    - name: "detection_rating"
      expr: detection_rating
      comment: "Detection rating (1-10) for control effectiveness assessment"
    - name: "rpn"
      expr: rpn
      comment: "Risk Priority Number (RPN = S × O × D) for risk prioritization"
    - name: "failure_mode"
      expr: failure_mode
      comment: "Failure mode description for pattern analysis"
    - name: "failure_effect"
      expr: failure_effect
      comment: "Failure effect description for impact analysis"
  measures:
    - name: "fmea_count"
      expr: COUNT(DISTINCT fmea_record_id)
      comment: "Total number of FMEA records for quality process coverage tracking"
    - name: "avg_rpn"
      expr: AVG(CAST(rpn AS DOUBLE))
      comment: "Average Risk Priority Number for overall risk level assessment"
    - name: "high_rpn_count"
      expr: SUM(CASE WHEN CAST(rpn AS DOUBLE) >= 100 THEN 1 ELSE 0 END)
      comment: "Count of high-RPN failure modes (RPN >= 100) for priority corrective action"
    - name: "avg_severity_rating"
      expr: AVG(CAST(severity_rating AS DOUBLE))
      comment: "Average severity rating for impact assessment"
    - name: "avg_occurrence_rating"
      expr: AVG(CAST(occurrence_rating AS DOUBLE))
      comment: "Average occurrence rating for frequency assessment"
    - name: "avg_detection_rating"
      expr: AVG(CAST(detection_rating AS DOUBLE))
      comment: "Average detection rating for control effectiveness assessment"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`engineering_prototype_build`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Prototype build performance metrics for development velocity, build quality, and test readiness tracking across vehicle program phases."
  source: "`vibe_automotive_v1`.`engineering`.`prototype_build`"
  dimensions:
    - name: "prototype_number"
      expr: prototype_number
      comment: "Unique prototype identifier for traceability"
    - name: "build_number"
      expr: build_number
      comment: "Build sequence number for iteration tracking"
    - name: "build_phase"
      expr: build_phase
      comment: "Development phase (concept, alpha, beta, pre-production) for gate tracking"
    - name: "build_purpose"
      expr: build_purpose
      comment: "Build purpose (design validation, crash test, durability) for resource allocation"
    - name: "prototype_build_status"
      expr: prototype_build_status
      comment: "Current build status for build pipeline monitoring"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status for regulatory readiness tracking"
    - name: "safety_rating"
      expr: safety_rating
      comment: "Safety rating for crash test and safety validation"
    - name: "emission_rating"
      expr: emission_rating
      comment: "Emissions rating for regulatory compliance validation"
    - name: "build_location"
      expr: build_location
      comment: "Build facility for capacity planning and cost allocation"
    - name: "build_month"
      expr: DATE_TRUNC('MONTH', build_date)
      comment: "Build month for time-series velocity tracking"
  measures:
    - name: "prototype_count"
      expr: COUNT(DISTINCT prototype_build_id)
      comment: "Total number of prototype builds for development velocity and investment tracking"
    - name: "total_build_cost"
      expr: SUM(CAST(build_cost AS DOUBLE))
      comment: "Total prototype build cost for budget tracking and cost control"
    - name: "avg_build_cost"
      expr: AVG(CAST(build_cost AS DOUBLE))
      comment: "Average build cost per prototype for cost benchmarking"
    - name: "avg_build_duration_hours"
      expr: AVG(CAST(build_duration_hours AS DOUBLE))
      comment: "Average build duration for build efficiency and capacity planning"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`engineering_cost_target`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost target and cost gap metrics for target costing, value engineering, and margin management to support profitability and competitive pricing decisions."
  source: "`vibe_automotive_v1`.`engineering`.`cost_target`"
  dimensions:
    - name: "target_code"
      expr: target_code
      comment: "Cost target identifier for traceability"
    - name: "target_name"
      expr: target_name
      comment: "Cost target name for business reporting"
    - name: "target_type"
      expr: target_type
      comment: "Target type (material, manufacturing, total) for cost breakdown analysis"
    - name: "system_or_component"
      expr: system_or_component
      comment: "System or component scope for cost allocation and value engineering"
    - name: "cost_target_status"
      expr: cost_target_status
      comment: "Current target status for target management tracking"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status for governance and release control"
    - name: "is_locked"
      expr: is_locked
      comment: "Lock status for baseline freeze tracking"
    - name: "cost_basis"
      expr: cost_basis
      comment: "Cost basis (should-cost, market benchmark, historical) for target setting methodology"
    - name: "cost_methodology"
      expr: cost_methodology
      comment: "Costing methodology for transparency and audit"
    - name: "target_currency"
      expr: target_currency
      comment: "Currency for multi-currency cost management"
  measures:
    - name: "cost_target_count"
      expr: COUNT(DISTINCT cost_target_id)
      comment: "Total number of cost targets for target costing coverage tracking"
    - name: "total_target_cost_material"
      expr: SUM(CAST(target_cost_material AS DOUBLE))
      comment: "Total material cost target for material cost management"
    - name: "total_target_cost_manufacturing"
      expr: SUM(CAST(target_cost_manufacturing AS DOUBLE))
      comment: "Total manufacturing cost target for manufacturing cost management"
    - name: "total_target_cost_total"
      expr: SUM(CAST(target_cost_total AS DOUBLE))
      comment: "Total cost target for vehicle cost rollup and margin planning"
    - name: "total_current_estimated_cost_material"
      expr: SUM(CAST(current_estimated_cost_material AS DOUBLE))
      comment: "Total current estimated material cost for cost gap analysis"
    - name: "total_current_estimated_cost_manufacturing"
      expr: SUM(CAST(current_estimated_cost_manufacturing AS DOUBLE))
      comment: "Total current estimated manufacturing cost for cost gap analysis"
    - name: "total_current_estimated_cost_total"
      expr: SUM(CAST(current_estimated_cost_total AS DOUBLE))
      comment: "Total current estimated cost for cost gap analysis"
    - name: "total_cost_gap_total"
      expr: SUM(CAST(cost_gap_total AS DOUBLE))
      comment: "Total cost gap (current - target) for value engineering prioritization"
    - name: "avg_cost_gap_percentage"
      expr: AVG(CAST(cost_gap_percentage AS DOUBLE))
      comment: "Average cost gap percentage for cost performance assessment"
    - name: "avg_cost_reduction_ideas_count"
      expr: AVG(CAST(cost_reduction_ideas_count AS DOUBLE))
      comment: "Average cost reduction ideas per target for value engineering activity tracking"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`engineering_cae_simulation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Computer-Aided Engineering (CAE) simulation performance metrics for virtual validation efficiency, simulation quality, and computational resource optimization."
  source: "`vibe_automotive_v1`.`engineering`.`cae_simulation`"
  dimensions:
    - name: "simulation_number"
      expr: simulation_number
      comment: "Unique simulation identifier for traceability"
    - name: "simulation_type"
      expr: simulation_type
      comment: "Simulation type (CFD, FEA, NVH, crash) for simulation portfolio analysis"
    - name: "simulation_status"
      expr: simulation_status
      comment: "Current simulation status for workload monitoring"
    - name: "result_outcome"
      expr: result_outcome
      comment: "Simulation outcome (pass, fail, inconclusive) for virtual validation tracking"
    - name: "solver_name"
      expr: solver_name
      comment: "Solver software for tool utilization and license management"
    - name: "load_case"
      expr: load_case
      comment: "Load case scenario for test coverage analysis"
    - name: "analyst_name"
      expr: analyst_name
      comment: "Analyst name for workload allocation and skill tracking"
    - name: "part_number"
      expr: part_number
      comment: "Part number for part-level simulation coverage"
  measures:
    - name: "simulation_count"
      expr: COUNT(DISTINCT cae_simulation_id)
      comment: "Total number of simulations for virtual validation workload tracking"
    - name: "passed_simulation_count"
      expr: SUM(CAST(CASE WHEN result_outcome = 'Pass' THEN 1 ELSE 0 END AS INT))
      comment: "Count of passed simulations for virtual validation success rate"
    - name: "failed_simulation_count"
      expr: SUM(CAST(CASE WHEN result_outcome = 'Fail' THEN 1 ELSE 0 END AS INT))
      comment: "Count of failed simulations for design issue identification"
    - name: "total_cpu_time_seconds"
      expr: SUM(CAST(cpu_time_seconds AS DOUBLE))
      comment: "Total CPU time for computational resource utilization and cost allocation"
    - name: "avg_cpu_time_seconds"
      expr: AVG(CAST(cpu_time_seconds AS DOUBLE))
      comment: "Average CPU time per simulation for efficiency benchmarking"
    - name: "avg_run_duration_seconds"
      expr: AVG(CAST(run_duration_seconds AS DOUBLE))
      comment: "Average run duration for turnaround time and capacity planning"
    - name: "avg_memory_usage_mb"
      expr: AVG(CAST(memory_usage_mb AS DOUBLE))
      comment: "Average memory usage for infrastructure sizing and cost optimization"
    - name: "avg_mesh_element_count"
      expr: AVG(CAST(mesh_element_count AS DOUBLE))
      comment: "Average mesh element count for simulation fidelity and quality assessment"
    - name: "avg_mesh_quality_score"
      expr: AVG(CAST(mesh_quality_score AS DOUBLE))
      comment: "Average mesh quality score for simulation accuracy and convergence tracking"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`engineering_dvp_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Design Verification Plan (DVP) execution metrics for test planning, completion tracking, and quality gate readiness assessment."
  source: "`vibe_automotive_v1`.`engineering`.`dvp_plan`"
  dimensions:
    - name: "plan_code"
      expr: plan_code
      comment: "DVP plan identifier for traceability"
    - name: "plan_title"
      expr: plan_title
      comment: "DVP plan title for business reporting"
    - name: "plan_type"
      expr: plan_type
      comment: "Plan type (component, system, vehicle) for test scope analysis"
    - name: "dvp_plan_status"
      expr: dvp_plan_status
      comment: "Current plan status for execution monitoring"
    - name: "test_phase"
      expr: test_phase
      comment: "Development phase for gate tracking"
    - name: "test_type"
      expr: test_type
      comment: "Test type for test portfolio analysis"
    - name: "test_environment"
      expr: test_environment
      comment: "Test environment (lab, proving ground, field) for resource allocation"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status for governance tracking"
    - name: "regulatory_approval_required"
      expr: regulatory_approval_required
      comment: "Regulatory approval flag for homologation tracking"
    - name: "regulatory_approval_status"
      expr: regulatory_approval_status
      comment: "Regulatory approval status for certification readiness"
    - name: "is_automated"
      expr: is_automated
      comment: "Automation flag for test automation strategy tracking"
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level for priority and resource allocation"
    - name: "priority"
      expr: priority
      comment: "Priority level for test sequencing and resource allocation"
  measures:
    - name: "dvp_plan_count"
      expr: COUNT(DISTINCT dvp_plan_id)
      comment: "Total number of DVP plans for test planning coverage tracking"
    - name: "avg_completion_percentage"
      expr: AVG(CAST(completion_percentage AS DOUBLE))
      comment: "Average plan completion percentage for overall test progress tracking"
    - name: "avg_completed_test_count"
      expr: AVG(CAST(completed_test_count AS DOUBLE))
      comment: "Average completed tests per plan for execution velocity"
    - name: "avg_total_test_count"
      expr: AVG(CAST(total_test_count AS DOUBLE))
      comment: "Average total tests per plan for test scope sizing"
    - name: "total_cost_estimate_usd"
      expr: SUM(CAST(cost_estimate_usd AS DOUBLE))
      comment: "Total DVP cost estimate for test budget planning"
    - name: "avg_cost_estimate_usd"
      expr: AVG(CAST(cost_estimate_usd AS DOUBLE))
      comment: "Average cost per DVP plan for cost benchmarking"
    - name: "automated_plan_count"
      expr: SUM(CAST(CASE WHEN is_automated = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Count of automated test plans for test automation strategy tracking"
    - name: "regulatory_plan_count"
      expr: SUM(CAST(CASE WHEN regulatory_approval_required = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Count of regulatory test plans for homologation workload tracking"
$$;