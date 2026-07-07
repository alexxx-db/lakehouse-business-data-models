-- Metric views for domain: packaging | Business: Semiconductors | Version: 2 | Generated on: 2026-06-28 00:14:33

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`packaging_assembly_change_notice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Assembly change notice (ACN) KPIs — tracks change volume, compliance review status, customer approval rates, and yield/DPPM impact. Drives change management governance and customer notification compliance."
  source: "`vibe_semiconductors_v1`.`packaging`.`assembly_change_notice`"
  dimensions:
    - name: "assembly_change_notice_status"
      expr: assembly_change_notice_status
      comment: "Current status of the ACN (e.g. Draft, Under Review, Approved, Effective) — primary governance filter."
    - name: "change_type"
      expr: change_type
      comment: "Type of change (e.g. process, material, equipment) — used to categorize change risk and impact."
    - name: "change_category"
      expr: change_category
      comment: "Category of the change — enables Pareto analysis of change drivers."
    - name: "change_status"
      expr: change_status
      comment: "Workflow status of the change — used to track change pipeline and approval bottlenecks."
    - name: "compliance_review_status"
      expr: compliance_review_status
      comment: "Status of compliance review — used to identify ACNs with pending regulatory obligations."
    - name: "customer_approval_required"
      expr: customer_approval_required
      comment: "Boolean indicating customer approval is required — used to prioritize customer-facing change notifications."
    - name: "customer_approval_status"
      expr: customer_approval_status
      comment: "Status of customer approval — tracks customer notification compliance and approval cycle time."
    - name: "regulatory_impact_flag"
      expr: regulatory_impact_flag
      comment: "Boolean indicating regulatory impact — used to escalate changes requiring regulatory filing."
    - name: "change_submission_month"
      expr: DATE_TRUNC('MONTH', change_submission_date)
      comment: "Month bucket of change submission — supports monthly change volume trending."
  measures:
    - name: "total_change_notices"
      expr: COUNT(1)
      comment: "Total number of assembly change notices — baseline metric for change management workload."
    - name: "avg_impact_on_yield_percent"
      expr: AVG(CAST(impact_on_yield_percent AS DOUBLE))
      comment: "Average yield impact of changes — used to assess risk of pending changes on production quality."
    - name: "avg_impact_on_dppm"
      expr: AVG(CAST(impact_on_dppm AS DOUBLE))
      comment: "Average DPPM impact of changes — used to assess customer quality risk from packaging changes."
    - name: "customer_approval_pending_count"
      expr: COUNT(CASE WHEN customer_approval_required = TRUE AND customer_approval_status != 'Approved' THEN 1 END)
      comment: "Number of ACNs awaiting customer approval — measures customer notification compliance backlog."
    - name: "regulatory_impact_count"
      expr: COUNT(CASE WHEN regulatory_impact_flag = TRUE THEN 1 END)
      comment: "Number of ACNs with regulatory impact — used to prioritize compliance review resources."
    - name: "qualification_required_count"
      expr: COUNT(CASE WHEN qualification_required = TRUE THEN 1 END)
      comment: "Number of ACNs requiring re-qualification — measures NPI and re-qualification workload driven by changes."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`packaging_assembly_defect`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Defect tracking and quality KPIs for assembly operations — used by quality engineering and manufacturing teams to drive defect reduction, root cause analysis, and corrective action prioritization."
  source: "`vibe_semiconductors_v1`.`packaging`.`assembly_defect`"
  dimensions:
    - name: "defect_category"
      expr: defect_category
      comment: "High-level category of the defect (e.g., mechanical, electrical, cosmetic) — used for Pareto analysis and defect classification."
    - name: "defect_type"
      expr: defect_type
      comment: "Specific type of defect (e.g., wire-sweep, void, delamination) — enables detailed root cause analysis and corrective action targeting."
    - name: "defect_code"
      expr: defect_code
      comment: "Standardized defect code — used for defect tracking, trending, and benchmarking across sites and products."
    - name: "severity"
      expr: severity
      comment: "Severity level of the defect (e.g., critical, major, minor) — used to prioritize corrective actions and assess quality risk."
    - name: "severity_level"
      expr: severity_level
      comment: "Numeric or categorical severity level — enables severity-weighted defect analysis and risk scoring."
    - name: "disposition"
      expr: disposition
      comment: "Disposition decision for the defect (e.g., scrap, rework, use-as-is, RMA) — tracks defect resolution and cost impact."
    - name: "is_critical"
      expr: is_critical
      comment: "Flag indicating whether the defect is critical (customer-impacting or safety-related) — used to filter high-priority defects."
    - name: "hold_flag"
      expr: hold_flag
      comment: "Indicates whether the defect triggered a lot hold — measures defect impact on production flow and cycle time."
    - name: "root_cause"
      expr: root_cause
      comment: "Identified root cause of the defect — used for root cause Pareto analysis and corrective action effectiveness tracking."
    - name: "detection_month"
      expr: DATE_TRUNC('MONTH', detected_date)
      comment: "Month the defect was detected — supports monthly defect trend analysis and quality performance tracking."
  measures:
    - name: "total_defects"
      expr: COUNT(DISTINCT assembly_defect_id)
      comment: "Total number of distinct defects recorded — baseline metric for defect volume and quality performance."
    - name: "total_defect_count"
      expr: SUM(CAST(defect_count AS DOUBLE))
      comment: "Total count of defect occurrences (may be multiple per record) — measures defect frequency and quality impact."
    - name: "avg_dppm"
      expr: AVG(CAST(dppm AS DOUBLE))
      comment: "Average defects per million units — industry-standard quality metric for defect rate benchmarking and Six Sigma tracking."
    - name: "critical_defects_count"
      expr: SUM(CASE WHEN is_critical = TRUE THEN 1 ELSE 0 END)
      comment: "Count of critical defects — high-priority quality metric for customer impact and risk assessment."
    - name: "defects_causing_hold_count"
      expr: SUM(CASE WHEN hold_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of defects that triggered a lot hold — measures defect impact on production throughput and cycle time."
    - name: "avg_measurement_value"
      expr: AVG(CAST(measurement_value AS DOUBLE))
      comment: "Average measurement value associated with defects (e.g., dimension, resistance) — used for parametric defect analysis."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`packaging_assembly_lot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational KPIs for assembly lot execution, yield performance, quality metrics, and WIP status — used by manufacturing operations to monitor real-time production health, identify yield excursions, and manage lot flow."
  source: "`vibe_semiconductors_v1`.`packaging`.`assembly_lot`"
  dimensions:
    - name: "assembly_lot_status"
      expr: assembly_lot_status
      comment: "Current status of the assembly lot (e.g., in-process, completed, scrapped, on-hold) — used to segment performance by lot lifecycle stage."
    - name: "wip_status"
      expr: wip_status
      comment: "Work-in-progress status of the lot — tracks lot position in the manufacturing flow for cycle time and bottleneck analysis."
    - name: "quality_status"
      expr: quality_status
      comment: "Quality disposition of the lot (e.g., pass, fail, conditional-release) — critical for quality gate tracking and hold management."
    - name: "hold_flag"
      expr: hold_flag
      comment: "Indicates whether the lot is currently on hold — used to calculate hold rate and identify quality or process issues."
    - name: "hold_reason"
      expr: hold_reason
      comment: "Reason code for lot hold — enables root cause analysis of holds and prioritization of corrective actions."
    - name: "assembly_site"
      expr: assembly_site
      comment: "Physical site or OSAT facility where the lot is being assembled — used for multi-site performance benchmarking."
    - name: "lot_start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the lot started processing — supports monthly throughput and cycle time trend analysis."
    - name: "lot_completion_month"
      expr: DATE_TRUNC('MONTH', completion_date)
      comment: "Month the lot completed processing — used for output volume and yield trend analysis by completion period."
  measures:
    - name: "total_assembly_lots"
      expr: COUNT(DISTINCT assembly_lot_id)
      comment: "Total number of distinct assembly lots — baseline volume metric for throughput and capacity utilization analysis."
    - name: "total_unit_count_in"
      expr: SUM(CAST(unit_count_in AS DOUBLE))
      comment: "Total units input into assembly lots — measures input volume and material consumption."
    - name: "total_unit_count_out"
      expr: SUM(CAST(unit_count_out AS DOUBLE))
      comment: "Total units output from assembly lots — measures actual production output and fulfillment capacity."
    - name: "total_good_unit_count"
      expr: SUM(CAST(good_unit_count AS DOUBLE))
      comment: "Total good units produced (passed quality inspection) — key quality and yield metric for manufacturing performance."
    - name: "total_scrap_unit_count"
      expr: SUM(CAST(scrap_unit_count AS DOUBLE))
      comment: "Total units scrapped due to defects or process failures — measures yield loss and cost of poor quality."
    - name: "total_reject_count"
      expr: SUM(CAST(reject_count AS DOUBLE))
      comment: "Total units rejected at inspection — quality metric for defect rate and inspection effectiveness."
    - name: "avg_cumulative_yield_percent"
      expr: AVG(CAST(cumulative_yield_percent AS DOUBLE))
      comment: "Average cumulative yield percentage across all lots — critical manufacturing efficiency KPI for process capability."
    - name: "avg_defect_density"
      expr: AVG(CAST(defect_density AS DOUBLE))
      comment: "Average defect density (defects per unit area or per unit) — quality metric for process control and Six Sigma analysis."
    - name: "total_inspection_pass_count"
      expr: SUM(CAST(inspection_pass_count AS DOUBLE))
      comment: "Total units that passed inspection — measures quality gate effectiveness and first-pass yield."
    - name: "total_inspection_fail_count"
      expr: SUM(CAST(inspection_fail_count AS DOUBLE))
      comment: "Total units that failed inspection — tracks quality escapes and inspection sensitivity."
    - name: "total_cost_estimate_usd"
      expr: SUM(CAST(cost_estimate_usd AS DOUBLE))
      comment: "Total estimated cost of assembly lots in USD — used for cost tracking, variance analysis, and margin calculation."
    - name: "lots_on_hold_count"
      expr: SUM(CASE WHEN hold_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of lots currently on hold — operational metric for hold rate and bottleneck identification."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`packaging_assembly_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for assembly order execution, yield performance, cost efficiency, and throughput — used by operations leadership to steer capacity planning, supplier performance, and manufacturing efficiency."
  source: "`vibe_semiconductors_v1`.`packaging`.`assembly_order`"
  dimensions:
    - name: "assembly_order_status"
      expr: assembly_order_status
      comment: "Current status of the assembly order (e.g., planned, in-progress, completed, on-hold) — used to segment performance by order lifecycle stage."
    - name: "assembly_site"
      expr: assembly_site
      comment: "Physical site or OSAT facility where assembly is performed — critical for multi-site capacity and yield benchmarking."
    - name: "priority_class"
      expr: priority_class
      comment: "Priority classification of the order (e.g., expedite, standard, low) — used to analyze on-time delivery and resource allocation by priority tier."
    - name: "order_year"
      expr: YEAR(order_placed_timestamp)
      comment: "Year the order was placed — enables year-over-year trend analysis of order volume and yield."
    - name: "order_quarter"
      expr: CONCAT('Q', QUARTER(order_placed_timestamp), '-', YEAR(order_placed_timestamp))
      comment: "Quarter and year the order was placed — used for quarterly business reviews and capacity planning cycles."
    - name: "order_month"
      expr: DATE_TRUNC('MONTH', order_placed_timestamp)
      comment: "Month the order was placed — supports monthly operational dashboards and trend analysis."
    - name: "hold_flag"
      expr: hold_flag
      comment: "Indicates whether the order is currently on hold — used to track hold rate and identify bottlenecks."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Quality inspection status of the order — used to monitor quality gate pass rates and inspection cycle time."
  measures:
    - name: "total_assembly_orders"
      expr: COUNT(DISTINCT assembly_order_id)
      comment: "Total number of distinct assembly orders — baseline volume metric for capacity planning and throughput analysis."
    - name: "total_ordered_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total quantity of units ordered across all assembly orders — measures demand volume and capacity requirements."
    - name: "total_completed_quantity"
      expr: SUM(CAST(completed_quantity AS DOUBLE))
      comment: "Total quantity of units completed — measures actual output and fulfillment performance."
    - name: "avg_actual_yield_percent"
      expr: AVG(CAST(actual_yield_percent AS DOUBLE))
      comment: "Average actual yield percentage across assembly orders — critical quality and efficiency KPI for manufacturing performance."
    - name: "avg_expected_yield_percent"
      expr: AVG(CAST(expected_yield_percent AS DOUBLE))
      comment: "Average expected yield percentage — baseline for yield variance analysis and process capability assessment."
    - name: "total_gross_cost"
      expr: SUM(CAST(cost_gross_amount AS DOUBLE))
      comment: "Total gross cost of assembly orders before adjustments — measures total manufacturing spend and cost baseline."
    - name: "total_net_cost"
      expr: SUM(CAST(cost_net_amount AS DOUBLE))
      comment: "Total net cost of assembly orders after adjustments — actual cost incurred, used for margin analysis and cost control."
    - name: "total_cost_adjustments"
      expr: SUM(CAST(cost_adjustment_amount AS DOUBLE))
      comment: "Total cost adjustments (credits, penalties, rework) — tracks cost variance and financial impact of quality issues."
    - name: "total_defect_count"
      expr: SUM(CAST(defect_count AS DOUBLE))
      comment: "Total defects detected across all assembly orders — quality metric for defect rate and process control."
    - name: "orders_on_hold_count"
      expr: SUM(CASE WHEN hold_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of orders currently on hold — operational metric for bottleneck identification and hold rate tracking."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`packaging_assembly_process_flow`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Process flow governance KPIs — tracks qualification status, cycle time targets, and yield targets across assembly process flows. Supports NPI and process change management."
  source: "`vibe_semiconductors_v1`.`packaging`.`assembly_process_flow`"
  dimensions:
    - name: "assembly_process_flow_status"
      expr: assembly_process_flow_status
      comment: "Lifecycle status of the process flow (e.g. Active, Obsolete, Under Review) — primary governance filter."
    - name: "flow_status"
      expr: flow_status
      comment: "Operational status of the flow — used to identify flows ready for production vs. in qualification."
    - name: "qualification_status"
      expr: qualification_status
      comment: "Qualification status of the process flow — critical gate for new product introduction decisions."
    - name: "bond_type"
      expr: bond_type
      comment: "Bonding technology used in the flow (e.g. wire bond, flip chip) — enables technology-level benchmarking."
    - name: "die_attach_method"
      expr: die_attach_method
      comment: "Die attach method — used to segment process flows by technology for yield and cost comparison."
    - name: "singulation_method"
      expr: singulation_method
      comment: "Singulation method (e.g. saw, laser) — impacts yield and cost; used for process selection decisions."
    - name: "is_default_flow"
      expr: is_default_flow
      comment: "Boolean indicating this is the default flow for a package type — used to identify standard vs. custom flows."
    - name: "effective_from_month"
      expr: DATE_TRUNC('MONTH', effective_from)
      comment: "Month the flow became effective — supports process change timeline analysis."
  measures:
    - name: "total_process_flows"
      expr: COUNT(1)
      comment: "Total number of assembly process flows — baseline count for process portfolio management."
    - name: "avg_estimated_cycle_time_days"
      expr: AVG(CAST(estimated_cycle_time_days AS DOUBLE))
      comment: "Average estimated cycle time in days — key input for delivery lead time commitments."
    - name: "avg_estimated_cycle_time_hours"
      expr: AVG(CAST(estimated_cycle_time_hours AS DOUBLE))
      comment: "Average estimated cycle time in hours — used for detailed capacity planning and scheduling."
    - name: "avg_target_yield_percent"
      expr: AVG(CAST(target_yield_percent AS DOUBLE))
      comment: "Average target yield across process flows — baseline for yield performance gap analysis."
    - name: "avg_process_yield_target"
      expr: AVG(CAST(process_yield_target AS DOUBLE))
      comment: "Average process yield target — used to set OSAT performance expectations and SLA thresholds."
    - name: "qualified_flow_count"
      expr: COUNT(CASE WHEN qualification_status = 'Qualified' THEN 1 END)
      comment: "Number of fully qualified process flows — measures readiness of packaging process portfolio for production."
    - name: "default_flow_count"
      expr: COUNT(CASE WHEN is_default_flow = TRUE THEN 1 END)
      comment: "Number of default process flows — used to assess standardization level across package types."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`packaging_assembly_step_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Process step execution KPIs — tracks yield, throughput, and process parameter compliance at the individual assembly step level. Drives step-level process optimization."
  source: "`vibe_semiconductors_v1`.`packaging`.`assembly_step_record`"
  dimensions:
    - name: "assembly_step_record_status"
      expr: assembly_step_record_status
      comment: "Status of the step execution record — used to filter completed vs. in-progress steps."
    - name: "step_name"
      expr: step_name
      comment: "Name of the assembly process step — primary grouping dimension for step-level analysis."
    - name: "step_type"
      expr: step_type
      comment: "Type of assembly step (e.g. die attach, wire bond, mold) — enables process category benchmarking."
    - name: "step_status"
      expr: step_status
      comment: "Execution status of the step — used to identify bottlenecks and blocked steps."
    - name: "is_pass"
      expr: is_pass
      comment: "Boolean pass/fail result of the step — primary quality gate indicator."
    - name: "inspection_result"
      expr: inspection_result
      comment: "Inspection outcome at this step — used to track in-process quality gates."
    - name: "defect_type"
      expr: defect_type
      comment: "Type of defect detected at this step — enables step-level defect attribution."
    - name: "compliance_standard"
      expr: compliance_standard
      comment: "Compliance standard applied at this step — used for regulatory and customer audit reporting."
    - name: "start_month"
      expr: DATE_TRUNC('MONTH', start_timestamp)
      comment: "Month bucket of step start timestamp — supports monthly process performance trending."
  measures:
    - name: "total_step_executions"
      expr: COUNT(1)
      comment: "Total number of step execution records — baseline throughput metric for process capacity analysis."
    - name: "avg_process_yield_percent"
      expr: AVG(CAST(process_yield_percent AS DOUBLE))
      comment: "Average yield at each process step — identifies yield loss hot spots in the assembly flow."
    - name: "avg_temperature_c"
      expr: AVG(CAST(temperature_c AS DOUBLE))
      comment: "Average process temperature — monitors thermal process compliance and drift."
    - name: "avg_pressure_pa"
      expr: AVG(CAST(pressure_pa AS DOUBLE))
      comment: "Average process pressure — monitors mechanical process compliance and equipment calibration."
    - name: "avg_force_n"
      expr: AVG(CAST(force_n AS DOUBLE))
      comment: "Average bonding or placement force — critical parameter for wire bond and die attach quality."
    - name: "avg_material_quantity"
      expr: AVG(CAST(material_quantity AS DOUBLE))
      comment: "Average material consumed per step execution — used for material cost and waste analysis."
    - name: "pass_rate"
      expr: COUNT(CASE WHEN is_pass = TRUE THEN 1 END)
      comment: "Count of passing step executions — numerator for first-pass yield rate calculation."
    - name: "fail_count"
      expr: COUNT(CASE WHEN is_pass = FALSE THEN 1 END)
      comment: "Count of failing step executions — drives step-level corrective action prioritization."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`packaging_assembly_yield`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Detailed yield performance KPIs by process step and assembly lot — used by process engineering and quality teams to identify yield detractors, optimize process steps, and drive continuous improvement initiatives."
  source: "`vibe_semiconductors_v1`.`packaging`.`assembly_yield`"
  dimensions:
    - name: "assembly_yield_status"
      expr: assembly_yield_status
      comment: "Status of the yield record (e.g., active, archived, under-review) — used to filter current vs. historical yield data."
    - name: "process_step"
      expr: process_step
      comment: "Specific process step where yield was measured (e.g., die-attach, wire-bond, molding) — critical dimension for step-level yield analysis."
    - name: "yield_category"
      expr: yield_category
      comment: "Category of yield measurement (e.g., first-pass, cumulative, rework) — used to segment yield performance by type."
    - name: "yield_type"
      expr: yield_type
      comment: "Type of yield metric (e.g., parametric, functional, visual) — enables analysis by yield measurement method."
    - name: "yield_loss_category"
      expr: yield_loss_category
      comment: "Category of yield loss (e.g., equipment, material, process, handling) — used for Pareto analysis of yield detractors."
    - name: "top_defect_category"
      expr: top_defect_category
      comment: "Top defect category contributing to yield loss — enables focused corrective action on highest-impact defects."
    - name: "scrap_reason_code"
      expr: scrap_reason_code
      comment: "Reason code for scrapped units — used for root cause analysis and scrap reduction initiatives."
    - name: "measurement_month"
      expr: DATE_TRUNC('MONTH', measurement_date)
      comment: "Month the yield was measured — supports monthly yield trend analysis and process control charting."
  measures:
    - name: "total_yield_records"
      expr: COUNT(DISTINCT assembly_yield_id)
      comment: "Total number of distinct yield measurement records — baseline metric for yield data coverage and sampling frequency."
    - name: "total_units_in"
      expr: SUM(CAST(units_in AS DOUBLE))
      comment: "Total units input into the process step — measures input volume for yield calculation denominator."
    - name: "total_units_out"
      expr: SUM(CAST(units_out AS DOUBLE))
      comment: "Total units output from the process step — measures output volume for yield calculation numerator."
    - name: "total_units_scrapped"
      expr: SUM(CAST(units_scrapped AS DOUBLE))
      comment: "Total units scrapped at the process step — measures yield loss and cost of poor quality."
    - name: "avg_yield_percent"
      expr: AVG(CAST(yield_percent AS DOUBLE))
      comment: "Average yield percentage across all measurements — primary KPI for process capability and manufacturing efficiency."
    - name: "avg_first_pass_yield_percent"
      expr: AVG(CAST(first_pass_yield_percent AS DOUBLE))
      comment: "Average first-pass yield percentage (no rework) — critical quality metric for process robustness and cost efficiency."
    - name: "avg_cumulative_yield_percent"
      expr: AVG(CAST(cumulative_yield_percent AS DOUBLE))
      comment: "Average cumulative yield percentage across all process steps — measures overall manufacturing efficiency from start to finish."
    - name: "avg_rework_yield_percent"
      expr: AVG(CAST(rework_yield_percent AS DOUBLE))
      comment: "Average yield percentage after rework — measures effectiveness of rework operations and recovery rate."
    - name: "avg_dppm"
      expr: AVG(CAST(dppm AS DOUBLE))
      comment: "Average defects per million units — industry-standard quality metric for defect rate benchmarking and Six Sigma analysis."
    - name: "total_reject_count"
      expr: SUM(CAST(reject_count AS DOUBLE))
      comment: "Total units rejected at the process step — measures quality gate effectiveness and defect detection rate."
    - name: "total_loss_quantity"
      expr: SUM(CAST(loss_quantity AS DOUBLE))
      comment: "Total quantity lost due to yield loss — measures material waste and financial impact of poor yield."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`packaging_customer_requirement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer packaging requirement KPIs — tracks compliance status, yield targets, cost, and dimensional requirements. Drives customer satisfaction and packaging design decisions."
  source: "`vibe_semiconductors_v1`.`packaging`.`customer_requirement`"
  dimensions:
    - name: "customer_requirement_status"
      expr: customer_requirement_status
      comment: "Current status of the customer requirement — primary filter for active vs. expired requirements."
    - name: "requirement_type"
      expr: requirement_type
      comment: "Type of customer requirement (e.g. dimensional, electrical, reliability) — primary dimension for requirement analysis."
    - name: "requirement_status"
      expr: requirement_status
      comment: "Fulfillment status of the requirement — used to identify gaps between customer needs and current capability."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status against the requirement — used for customer audit and SLA reporting."
    - name: "moisture_sensitivity_level"
      expr: moisture_sensitivity_level
      comment: "MSL classification required by customer — used for packaging and storage compliance."
    - name: "dry_pack_required"
      expr: dry_pack_required
      comment: "Boolean indicating dry pack requirement — used for packaging material and logistics planning."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for cost fields — required for multi-currency financial analysis."
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the requirement became effective — supports requirement timeline analysis."
  measures:
    - name: "total_customer_requirements"
      expr: COUNT(1)
      comment: "Total number of customer packaging requirements — baseline metric for customer requirement portfolio."
    - name: "avg_required_yield_percent"
      expr: AVG(CAST(required_yield_percent AS DOUBLE))
      comment: "Average yield percentage required by customers — used to set internal yield targets and OSAT SLAs."
    - name: "avg_packaging_cost_usd"
      expr: AVG(CAST(packaging_cost_usd AS DOUBLE))
      comment: "Average packaging cost per customer requirement — used for pricing and margin analysis."
    - name: "avg_required_mtbf_hours"
      expr: AVG(CAST(required_mtbf_hours AS DOUBLE))
      comment: "Average MTBF requirement from customers — used to set reliability test targets and qualification criteria."
    - name: "avg_thermal_budget_c"
      expr: AVG(CAST(thermal_budget_c AS DOUBLE))
      comment: "Average thermal budget required — used for package thermal design compliance."
    - name: "avg_package_height_mm"
      expr: AVG(CAST(package_height_mm AS DOUBLE))
      comment: "Average required package height — used for dimensional compliance and package selection."
    - name: "dry_pack_required_count"
      expr: COUNT(CASE WHEN dry_pack_required = TRUE THEN 1 END)
      comment: "Number of requirements mandating dry pack — used for packaging logistics and cost planning."
    - name: "distinct_customers"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of distinct customers with packaging requirements — measures customer requirement portfolio breadth."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`packaging_inspection_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inspection result KPIs for assembly quality control — used by quality and manufacturing teams to monitor inspection effectiveness, defect detection rates, and quality gate performance."
  source: "`vibe_semiconductors_v1`.`packaging`.`inspection_result`"
  dimensions:
    - name: "inspection_result_status"
      expr: inspection_result_status
      comment: "Status of the inspection result (e.g., pass, fail, conditional, pending) — used to segment inspection outcomes and calculate pass rate."
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection performed (e.g., visual, X-ray, electrical, dimensional) — enables analysis by inspection method and coverage."
    - name: "inspection_method"
      expr: inspection_method
      comment: "Specific inspection method or technique used — used for inspection capability analysis and method effectiveness comparison."
    - name: "disposition"
      expr: disposition
      comment: "Disposition decision based on inspection result (e.g., accept, reject, rework, MRB) — tracks inspection outcome and material flow."
    - name: "defect_category"
      expr: defect_category
      comment: "Category of defects found during inspection — used for defect Pareto analysis and corrective action prioritization."
    - name: "defect_severity"
      expr: defect_severity
      comment: "Severity level of defects found — enables severity-weighted defect analysis and risk assessment."
    - name: "is_spc_control"
      expr: is_spc_control
      comment: "Flag indicating whether the inspection is under statistical process control — tracks process stability and control plan compliance."
    - name: "inspection_month"
      expr: DATE_TRUNC('MONTH', inspection_date)
      comment: "Month the inspection was performed — supports monthly quality trend analysis and inspection volume tracking."
  measures:
    - name: "total_inspections"
      expr: COUNT(DISTINCT inspection_result_id)
      comment: "Total number of distinct inspection results — baseline metric for inspection coverage and workload."
    - name: "total_units_inspected"
      expr: SUM(CAST(units_inspected AS DOUBLE))
      comment: "Total units inspected across all inspection results — measures inspection sample size and coverage."
    - name: "total_pass_count"
      expr: SUM(CAST(pass_count AS DOUBLE))
      comment: "Total units that passed inspection — measures quality gate effectiveness and first-pass yield."
    - name: "total_fail_count"
      expr: SUM(CAST(fail_count AS DOUBLE))
      comment: "Total units that failed inspection — measures defect detection rate and quality risk."
    - name: "total_defect_count"
      expr: SUM(CAST(defect_count_total AS DOUBLE))
      comment: "Total defects detected across all inspections — measures defect volume and quality performance."
    - name: "avg_defect_density"
      expr: AVG(CAST(defect_density AS DOUBLE))
      comment: "Average defect density (defects per unit area or per unit) — quality metric for process control and benchmarking."
    - name: "avg_measured_value"
      expr: AVG(CAST(measured_value AS DOUBLE))
      comment: "Average measured value from inspections (e.g., dimension, resistance) — used for parametric quality analysis and SPC charting."
    - name: "inspections_under_spc_count"
      expr: SUM(CASE WHEN is_spc_control = TRUE THEN 1 ELSE 0 END)
      comment: "Count of inspections under statistical process control — measures process stability and control plan maturity."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`packaging_material_lot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Packaging material lot KPIs — tracks material quality, compliance status, cost, and shelf life. Drives incoming material qualification and supply chain quality decisions."
  source: "`vibe_semiconductors_v1`.`packaging`.`material_lot`"
  dimensions:
    - name: "material_lot_status"
      expr: material_lot_status
      comment: "Current status of the material lot (e.g. Released, Quarantined, Expired) — primary operational filter."
    - name: "material_type"
      expr: material_type
      comment: "Type of packaging material (e.g. substrate, leadframe, mold compound) — primary dimension for material analysis."
    - name: "material_grade"
      expr: material_grade
      comment: "Grade classification of the material — used for quality tier analysis and supplier benchmarking."
    - name: "compliance_rohs_status"
      expr: compliance_rohs_status
      comment: "RoHS compliance status — required for customer compliance reporting and product certification."
    - name: "compliance_reach_status"
      expr: compliance_reach_status
      comment: "REACH compliance status — required for EU regulatory compliance and customer declarations."
    - name: "incoming_inspection_status"
      expr: incoming_inspection_status
      comment: "Result of incoming inspection — used to track material acceptance rates by supplier."
    - name: "quarantine_flag"
      expr: quarantine_flag
      comment: "Boolean indicating lot is quarantined — used to identify blocked material inventory."
    - name: "rohs_compliant"
      expr: rohs_compliant
      comment: "Boolean RoHS compliance flag — used for compliance screening and customer reporting."
    - name: "receipt_month"
      expr: DATE_TRUNC('MONTH', receipt_date)
      comment: "Month bucket of material receipt date — supports monthly incoming material volume trending."
  measures:
    - name: "total_material_lots"
      expr: COUNT(1)
      comment: "Total number of material lots received — baseline metric for incoming material volume."
    - name: "total_quantity_received"
      expr: SUM(CAST(quantity_received AS DOUBLE))
      comment: "Total quantity of material received — used for inventory planning and supplier delivery performance."
    - name: "avg_cost_per_unit"
      expr: AVG(CAST(cost_per_unit AS DOUBLE))
      comment: "Average material cost per unit — used for packaging cost modeling and supplier price benchmarking."
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average quality score of incoming material lots — measures supplier material quality consistency."
    - name: "quarantined_lot_count"
      expr: COUNT(CASE WHEN quarantine_flag = TRUE THEN 1 END)
      comment: "Number of quarantined material lots — measures incoming quality failure rate and supply risk."
    - name: "passed_inspection_count"
      expr: COUNT(CASE WHEN inspection_passed = TRUE THEN 1 END)
      comment: "Number of lots passing incoming inspection — used to calculate supplier acceptance rate."
    - name: "rohs_compliant_lot_count"
      expr: COUNT(CASE WHEN rohs_compliant = TRUE THEN 1 END)
      comment: "Number of RoHS-compliant material lots — used for compliance portfolio reporting."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`packaging_osat_vendor`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "OSAT vendor performance and capability KPIs — used by supply chain and operations leadership to evaluate vendor performance, manage capacity allocation, and drive supplier quality improvement."
  source: "`vibe_semiconductors_v1`.`packaging`.`osat_vendor`"
  dimensions:
    - name: "vendor_name"
      expr: vendor_name
      comment: "Name of the OSAT vendor — primary dimension for vendor-level performance analysis and benchmarking."
    - name: "vendor_code"
      expr: vendor_code
      comment: "Standardized vendor code — used for vendor identification and cross-system integration."
    - name: "vendor_country"
      expr: vendor_country
      comment: "Country where the vendor is located — enables geographic analysis of vendor base and supply chain risk."
    - name: "qualification_status"
      expr: qualification_status
      comment: "Qualification status of the vendor (e.g., qualified, conditional, under-review, disqualified) — tracks vendor readiness and compliance."
    - name: "partnership_status"
      expr: partnership_status
      comment: "Partnership tier or status (e.g., strategic, preferred, approved, probation) — used for vendor segmentation and relationship management."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Lifecycle status of the vendor relationship (e.g., active, inactive, phase-out) — tracks vendor portfolio health."
    - name: "is_active"
      expr: is_active
      comment: "Flag indicating whether the vendor is currently active — used to filter active vendor base for performance reporting."
    - name: "capacity_tier"
      expr: capacity_tier
      comment: "Capacity tier of the vendor (e.g., high-volume, mid-volume, low-volume) — used for capacity planning and allocation decisions."
    - name: "iso_9001_certified"
      expr: iso_9001_certified
      comment: "Flag indicating ISO 9001 certification — tracks quality management system compliance."
    - name: "iatf_16949_certified"
      expr: iatf_16949_certified
      comment: "Flag indicating IATF 16949 certification (automotive quality) — tracks automotive-grade vendor capability."
    - name: "aec_q100_certified"
      expr: aec_q100_certified
      comment: "Flag indicating AEC-Q100 certification (automotive IC qualification) — tracks automotive qualification capability."
  measures:
    - name: "total_osat_vendors"
      expr: COUNT(DISTINCT osat_vendor_id)
      comment: "Total number of distinct OSAT vendors — baseline metric for vendor base size and supply chain diversification."
    - name: "active_vendors_count"
      expr: SUM(CASE WHEN is_active = TRUE THEN 1 ELSE 0 END)
      comment: "Count of active OSAT vendors — measures current vendor base and supply chain capacity."
    - name: "avg_quality_rating"
      expr: AVG(CAST(quality_rating AS DOUBLE))
      comment: "Average quality rating across all vendors — composite quality metric for vendor performance benchmarking."
    - name: "avg_scorecard_rating"
      expr: AVG(CAST(scorecard_rating AS DOUBLE))
      comment: "Average scorecard rating across all vendors — overall vendor performance metric for strategic sourcing decisions."
    - name: "avg_dppm_rate"
      expr: AVG(CAST(dppm_rate AS DOUBLE))
      comment: "Average defects per million units across all vendors — industry-standard quality metric for vendor quality comparison."
    - name: "avg_audit_score"
      expr: AVG(CAST(audit_score AS DOUBLE))
      comment: "Average audit score across all vendors — measures vendor compliance and quality system maturity."
    - name: "iso_certified_vendors_count"
      expr: SUM(CASE WHEN iso_9001_certified = TRUE THEN 1 ELSE 0 END)
      comment: "Count of ISO 9001 certified vendors — tracks quality management system compliance across vendor base."
    - name: "automotive_certified_vendors_count"
      expr: SUM(CASE WHEN iatf_16949_certified = TRUE OR aec_q100_certified = TRUE THEN 1 ELSE 0 END)
      comment: "Count of vendors with automotive quality certifications — measures automotive-grade supply chain capability."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`packaging_package_qualification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Package qualification program KPIs — used by product engineering and quality teams to track qualification progress, cost, cycle time, and compliance for new package introductions and technology transfers."
  source: "`vibe_semiconductors_v1`.`packaging`.`package_qualification`"
  dimensions:
    - name: "package_qualification_status"
      expr: package_qualification_status
      comment: "Current status of the qualification program (e.g., in-progress, completed, on-hold, failed) — used to segment qualification performance by lifecycle stage."
    - name: "qualification_type"
      expr: qualification_type
      comment: "Type of qualification (e.g., new-product, process-change, supplier-transfer) — enables analysis by qualification scope and complexity."
    - name: "qualification_standard"
      expr: qualification_standard
      comment: "Industry standard or customer specification used for qualification (e.g., JEDEC, AEC-Q100, customer-specific) — tracks compliance requirements."
    - name: "qualification_result"
      expr: qualification_result
      comment: "Final result of the qualification (e.g., pass, fail, conditional-pass) — measures qualification success rate and quality gate effectiveness."
    - name: "pass_fail_result"
      expr: pass_fail_result
      comment: "Binary pass/fail outcome — used for qualification success rate calculation and trend analysis."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level of the qualification (e.g., high, medium, low) — used to prioritize resources and management attention."
    - name: "external_audit_required"
      expr: external_audit_required
      comment: "Flag indicating whether external audit is required — tracks regulatory and customer compliance requirements."
    - name: "qualification_year"
      expr: YEAR(planned_start_date)
      comment: "Year the qualification was planned to start — enables year-over-year trend analysis of qualification volume and cycle time."
    - name: "approval_month"
      expr: DATE_TRUNC('MONTH', approval_date)
      comment: "Month the qualification was approved — supports monthly qualification completion tracking and cycle time analysis."
  measures:
    - name: "total_qualifications"
      expr: COUNT(DISTINCT package_qualification_id)
      comment: "Total number of distinct package qualification programs — baseline metric for qualification workload and resource planning."
    - name: "total_qualification_cost_usd"
      expr: SUM(CAST(qualification_cost_usd AS DOUBLE))
      comment: "Total cost of qualification programs in USD — measures investment in new product introduction and quality assurance."
    - name: "avg_qualification_cost_usd"
      expr: AVG(CAST(qualification_cost_usd AS DOUBLE))
      comment: "Average cost per qualification program — used for cost benchmarking and budgeting for future qualifications."
    - name: "avg_test_duration_hours"
      expr: AVG(CAST(test_duration_hours AS DOUBLE))
      comment: "Average test duration in hours — measures qualification cycle time and resource utilization."
    - name: "avg_yield_percentage"
      expr: AVG(CAST(yield_percentage AS DOUBLE))
      comment: "Average yield percentage during qualification — quality metric for process capability and readiness for production ramp."
    - name: "qualifications_passed_count"
      expr: SUM(CASE WHEN pass_fail_result = 'pass' THEN 1 ELSE 0 END)
      comment: "Count of qualifications that passed — measures qualification success rate and process maturity."
    - name: "qualifications_requiring_external_audit_count"
      expr: SUM(CASE WHEN external_audit_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of qualifications requiring external audit — tracks regulatory and customer compliance workload."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`packaging_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Packaging line capacity and performance KPIs — tracks throughput, yield, defect rate, and maintenance metrics. Drives capital investment and capacity planning decisions."
  source: "`vibe_semiconductors_v1`.`packaging`.`packaging_line`"
  dimensions:
    - name: "packaging_line_status"
      expr: packaging_line_status
      comment: "Current operational status of the packaging line — primary filter for active capacity analysis."
    - name: "line_type"
      expr: line_type
      comment: "Type of packaging line (e.g. wire bond, flip chip, SiP) — enables technology-level capacity benchmarking."
    - name: "qualification_status"
      expr: qualification_status
      comment: "Qualification status of the line — used to identify lines ready for production vs. in qualification."
    - name: "is_active"
      expr: is_active
      comment: "Boolean indicating line is currently active — used to filter active vs. idle capacity."
    - name: "location"
      expr: location
      comment: "Physical location of the packaging line — enables site-level capacity analysis."
    - name: "safety_classification"
      expr: safety_classification
      comment: "Safety classification of the line — used for regulatory compliance and risk management."
    - name: "commissioning_month"
      expr: DATE_TRUNC('MONTH', commissioning_date)
      comment: "Month the line was commissioned — used for asset age and depreciation analysis."
  measures:
    - name: "total_packaging_lines"
      expr: COUNT(1)
      comment: "Total number of packaging lines — baseline metric for capacity portfolio management."
    - name: "avg_capacity_per_hour"
      expr: AVG(CAST(capacity_per_hour AS DOUBLE))
      comment: "Average throughput capacity per hour — primary capacity planning metric for production scheduling."
    - name: "avg_current_yield_percent"
      expr: AVG(CAST(current_yield_percent AS DOUBLE))
      comment: "Average current yield across packaging lines — measures line-level quality performance."
    - name: "avg_defect_rate_ppm"
      expr: AVG(CAST(defect_rate_ppm AS DOUBLE))
      comment: "Average defect rate in PPM across lines — used for line-level quality benchmarking and SLA compliance."
    - name: "avg_mtbf_hours"
      expr: AVG(CAST(mtbf_hours AS DOUBLE))
      comment: "Average mean time between failures — measures equipment reliability and maintenance effectiveness."
    - name: "avg_mttr_hours"
      expr: AVG(CAST(mttr_hours AS DOUBLE))
      comment: "Average mean time to repair — measures maintenance responsiveness and downtime impact."
    - name: "avg_energy_consumption_kwh"
      expr: AVG(CAST(energy_consumption_kwh AS DOUBLE))
      comment: "Average energy consumption per line — used for sustainability reporting and cost optimization."
    - name: "active_line_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Number of currently active packaging lines — measures available production capacity."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`packaging_qualification_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Qualification plan governance KPIs — tracks plan status, yield targets, and timeline adherence for packaging qualification programs. Drives NPI readiness and OSAT qualification governance."
  source: "`vibe_semiconductors_v1`.`packaging`.`qualification_plan`"
  dimensions:
    - name: "qualification_plan_status"
      expr: qualification_plan_status
      comment: "Current status of the qualification plan — primary filter for active vs. completed plans."
    - name: "plan_type"
      expr: plan_type
      comment: "Type of qualification plan (e.g. initial, transfer, re-qualification) — used to segment qualification workload."
    - name: "plan_status"
      expr: plan_status
      comment: "Workflow status of the plan — used to track approval pipeline and bottlenecks."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the plan — used to identify plans pending sign-off."
    - name: "qualification_standard"
      expr: qualification_standard
      comment: "Industry standard applied — used for compliance and customer audit reporting."
    - name: "is_mandatory"
      expr: is_mandatory
      comment: "Boolean indicating mandatory qualification — used to prioritize critical qualification activities."
    - name: "product_family"
      expr: product_family
      comment: "Product family covered by the plan — enables family-level qualification portfolio analysis."
    - name: "planned_start_month"
      expr: DATE_TRUNC('MONTH', planned_start_date)
      comment: "Month bucket of planned start — supports qualification pipeline planning."
  measures:
    - name: "total_qualification_plans"
      expr: COUNT(1)
      comment: "Total number of qualification plans — baseline metric for qualification program portfolio size."
    - name: "avg_target_yield_percent"
      expr: AVG(CAST(target_yield_percent AS DOUBLE))
      comment: "Average target yield across qualification plans — used to set OSAT performance expectations."
    - name: "mandatory_plan_count"
      expr: COUNT(CASE WHEN is_mandatory = TRUE THEN 1 END)
      comment: "Number of mandatory qualification plans — measures compliance-driven qualification workload."
    - name: "approved_plan_count"
      expr: COUNT(CASE WHEN approval_status = 'Approved' THEN 1 END)
      comment: "Number of approved qualification plans — measures qualification readiness for production release."
    - name: "distinct_osat_vendors_in_plans"
      expr: COUNT(DISTINCT osat_vendor_id)
      comment: "Number of distinct OSAT vendors covered by qualification plans — measures qualification breadth across supply base."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`packaging_reliability_stress_test`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reliability stress test KPIs for package qualification and product reliability assurance — used by reliability engineering and quality teams to assess product robustness, predict field failure rates, and ensure customer reliability requirements are met."
  source: "`vibe_semiconductors_v1`.`packaging`.`reliability_stress_test`"
  dimensions:
    - name: "test_type"
      expr: test_type
      comment: "Type of reliability stress test (e.g., HTOL, HAST, TC, TMCL, MSL) — used to segment reliability performance by test method."
    - name: "test_standard"
      expr: test_standard
      comment: "Industry standard or specification used for the test (e.g., JEDEC, AEC-Q100, MIL-STD) — tracks compliance and test rigor."
    - name: "result_status"
      expr: result_status
      comment: "Status of the test result (e.g., pass, fail, in-progress, aborted) — used to filter completed tests and calculate pass rate."
    - name: "disposition"
      expr: disposition
      comment: "Disposition decision based on test result (e.g., release, hold, investigate, re-test) — tracks test outcome and corrective action."
    - name: "failure_mode"
      expr: failure_mode
      comment: "Failure mode observed during the test (e.g., open, short, parametric-drift, delamination) — enables failure mode Pareto analysis."
    - name: "test_location"
      expr: test_location
      comment: "Physical location where the test was conducted — used for multi-site test capability and cost analysis."
    - name: "test_start_year"
      expr: YEAR(test_start_date)
      comment: "Year the test started — enables year-over-year trend analysis of reliability test volume and results."
    - name: "test_start_month"
      expr: DATE_TRUNC('MONTH', test_start_date)
      comment: "Month the test started — supports monthly reliability test tracking and cycle time analysis."
  measures:
    - name: "total_stress_tests"
      expr: COUNT(DISTINCT reliability_stress_test_id)
      comment: "Total number of distinct reliability stress tests — baseline metric for reliability test workload and coverage."
    - name: "total_sample_size"
      expr: SUM(CAST(sample_size AS DOUBLE))
      comment: "Total sample size across all stress tests — measures test coverage and statistical confidence."
    - name: "total_failure_count"
      expr: SUM(CAST(failure_count AS DOUBLE))
      comment: "Total failures observed across all stress tests — measures reliability risk and failure rate."
    - name: "avg_mttf_hours"
      expr: AVG(CAST(mttf_hours AS DOUBLE))
      comment: "Average mean time to failure in hours — critical reliability metric for product lifetime prediction and warranty cost estimation."
    - name: "avg_duration_hours"
      expr: AVG(CAST(duration_hours AS DOUBLE))
      comment: "Average test duration in hours — measures test cycle time and resource utilization."
    - name: "avg_temperature_c"
      expr: AVG(CAST(temperature_c AS DOUBLE))
      comment: "Average test temperature in Celsius — used for stress condition analysis and acceleration factor calculation."
    - name: "avg_humidity_percent"
      expr: AVG(CAST(humidity_percent AS DOUBLE))
      comment: "Average test humidity percentage — used for environmental stress analysis and moisture sensitivity assessment."
    - name: "avg_voltage_v"
      expr: AVG(CAST(voltage_v AS DOUBLE))
      comment: "Average test voltage in volts — used for electrical stress analysis and overvoltage reliability assessment."
    - name: "tests_passed_count"
      expr: SUM(CASE WHEN result_status = 'pass' THEN 1 ELSE 0 END)
      comment: "Count of stress tests that passed — measures reliability qualification success rate and product robustness."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`packaging_substrate_bom`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Substrate BOM KPIs — tracks material cost, compliance status, and design parameters across substrate configurations. Drives substrate sourcing, cost optimization, and compliance management."
  source: "`vibe_semiconductors_v1`.`packaging`.`substrate_bom`"
  dimensions:
    - name: "substrate_bom_status"
      expr: substrate_bom_status
      comment: "Current status of the substrate BOM (e.g. Active, Obsolete, Under Review) — primary governance filter."
    - name: "substrate_type"
      expr: substrate_type
      comment: "Type of substrate (e.g. organic, ceramic, leadframe) — primary dimension for substrate technology analysis."
    - name: "substrate_material"
      expr: substrate_material
      comment: "Substrate material specification — used for material cost and compliance benchmarking."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Lifecycle status of the substrate BOM — used to identify obsolete designs requiring redesign."
    - name: "reach_compliant"
      expr: reach_compliant
      comment: "Boolean REACH compliance flag — required for EU regulatory compliance reporting."
    - name: "rohs_compliant"
      expr: rohs_compliant
      comment: "Boolean RoHS compliance flag — required for customer compliance declarations."
    - name: "is_obsolete"
      expr: is_obsolete
      comment: "Boolean indicating BOM is obsolete — used to identify designs requiring refresh."
    - name: "effective_from_month"
      expr: DATE_TRUNC('MONTH', effective_from)
      comment: "Month the BOM became effective — supports design change timeline analysis."
  measures:
    - name: "total_substrate_boms"
      expr: COUNT(1)
      comment: "Total number of substrate BOM records — baseline metric for substrate design portfolio size."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average substrate unit cost — primary cost metric for packaging BOM cost optimization."
    - name: "total_unit_cost"
      expr: SUM(CAST(unit_cost AS DOUBLE))
      comment: "Total substrate cost across all BOM records — used for portfolio-level cost exposure analysis."
    - name: "avg_quantity_per_unit"
      expr: AVG(CAST(quantity_per_unit AS DOUBLE))
      comment: "Average quantity of substrate per assembled unit — used for material consumption planning."
    - name: "avg_thermal_conductivity"
      expr: AVG(CAST(thermal_conductivity_w_per_mk AS DOUBLE))
      comment: "Average thermal conductivity of substrates — used for thermal design compliance and package selection."
    - name: "avg_thickness_um"
      expr: AVG(CAST(thickness_um AS DOUBLE))
      comment: "Average substrate thickness — used for package height compliance and design rule checking."
    - name: "rohs_compliant_bom_count"
      expr: COUNT(CASE WHEN rohs_compliant = TRUE THEN 1 END)
      comment: "Number of RoHS-compliant substrate BOMs — measures compliance coverage of the substrate portfolio."
    - name: "obsolete_bom_count"
      expr: COUNT(CASE WHEN is_obsolete = TRUE THEN 1 END)
      comment: "Number of obsolete substrate BOMs — measures technical debt in the substrate design portfolio."
$$;
