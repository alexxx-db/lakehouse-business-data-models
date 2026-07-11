-- Metric views for domain: design | Business: Semiconductors | Version: 2 | Generated on: 2026-07-10 14:15:10

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`design_ic_design_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic IC design project performance metrics tracking NRE spend efficiency, schedule adherence, and design complexity for semiconductor product development portfolio management."
  source: "`vibe_semiconductors_v1`.`design`.`ic_design_project`"
  dimensions:
    - name: "project_status"
      expr: project_status
      comment: "Current lifecycle status of the IC design project (e.g., Active, On Hold, Completed, Cancelled) for portfolio health tracking."
    - name: "design_phase"
      expr: design_phase
      comment: "Current design phase (e.g., RTL, Synthesis, Place & Route, Verification) for pipeline stage analysis."
    - name: "process_node_nm"
      expr: process_node_nm
      comment: "Target process node in nanometers (e.g., 7nm, 5nm, 3nm) for technology generation segmentation."
    - name: "lithography_type"
      expr: lithography_type
      comment: "Lithography technology type (e.g., DUV, EUV) for advanced node capability tracking."
    - name: "design_type"
      expr: design_type
      comment: "Type of IC design (e.g., ASIC, SoC, FPGA) for product category analysis."
    - name: "project_start_year"
      expr: YEAR(project_start_date)
      comment: "Year the project was initiated for cohort and vintage analysis."
    - name: "tapeout_target_quarter"
      expr: CONCAT(CAST(YEAR(tapeout_target_date) AS STRING), '-Q', CAST(QUARTER(tapeout_target_date) AS STRING))
      comment: "Target tapeout quarter for pipeline planning and capacity forecasting."
    - name: "dft_enabled_flag"
      expr: CASE WHEN dft_enabled THEN 'DFT Enabled' ELSE 'DFT Not Enabled' END
      comment: "Design-for-test enablement status for testability and quality segmentation."
    - name: "iatf_automotive_grade_flag"
      expr: CASE WHEN iatf_automotive_grade THEN 'Automotive Grade' ELSE 'Non-Automotive' END
      comment: "IATF automotive qualification status for market segment analysis."
  measures:
    - name: "total_projects"
      expr: COUNT(1)
      comment: "Total number of IC design projects for portfolio size tracking."
    - name: "total_nre_budget_usd"
      expr: SUM(CAST(nre_budget_usd AS DOUBLE))
      comment: "Total non-recurring engineering budget allocated across projects for investment planning."
    - name: "total_nre_actual_spend_usd"
      expr: SUM(CAST(nre_actual_spend_usd AS DOUBLE))
      comment: "Total actual NRE spend across projects for cost tracking and variance analysis."
    - name: "avg_nre_budget_per_project_usd"
      expr: AVG(CAST(nre_budget_usd AS DOUBLE))
      comment: "Average NRE budget per project for benchmarking and resource allocation planning."
    - name: "nre_budget_utilization_pct"
      expr: ROUND(100.0 * SUM(CAST(nre_actual_spend_usd AS DOUBLE)) / NULLIF(SUM(CAST(nre_budget_usd AS DOUBLE)), 0), 2)
      comment: "Percentage of NRE budget consumed (actual vs. budget) for financial efficiency tracking and overrun detection."
    - name: "projects_with_tapeout_delay"
      expr: COUNT(CASE WHEN tapeout_actual_date > tapeout_target_date THEN 1 END)
      comment: "Count of projects that missed their tapeout target date for schedule adherence monitoring."
    - name: "on_time_tapeout_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN tapeout_actual_date <= tapeout_target_date THEN 1 END) / NULLIF(COUNT(CASE WHEN tapeout_actual_date IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of completed projects that met or beat tapeout target date for execution quality assessment."
    - name: "avg_target_die_area_mm2"
      expr: AVG(CAST(target_die_area_mm2 AS DOUBLE))
      comment: "Average target die area in square millimeters for silicon cost and complexity benchmarking."
    - name: "avg_gate_count_target_k"
      expr: AVG(CAST(gate_count_target_k AS DOUBLE))
      comment: "Average target gate count in thousands for design complexity and resource estimation."
    - name: "distinct_process_nodes"
      expr: COUNT(DISTINCT process_node_nm)
      comment: "Number of distinct process nodes in the portfolio for technology diversification tracking."
    - name: "distinct_customers"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of distinct customer accounts with active design projects for customer concentration analysis."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`design_tapeout`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Critical tapeout execution metrics tracking mask costs, design quality sign-off, and foundry submission success for semiconductor manufacturing readiness."
  source: "`vibe_semiconductors_v1`.`design`.`tapeout`"
  dimensions:
    - name: "tapeout_status"
      expr: tapeout_status
      comment: "Current status of the tapeout (e.g., Submitted, In Progress, Completed, Failed) for execution tracking."
    - name: "tapeout_type"
      expr: tapeout_type
      comment: "Type of tapeout (e.g., Full Production, MPW, Shuttle, Engineering) for cost and risk segmentation."
    - name: "design_type"
      expr: design_type
      comment: "Type of IC design being taped out for product category analysis."
    - name: "lithography_type"
      expr: lithography_type
      comment: "Lithography technology used (e.g., DUV, EUV) for advanced manufacturing capability tracking."
    - name: "foundry_name"
      expr: foundry_name
      comment: "Name of the foundry partner for supplier performance and capacity analysis."
    - name: "tapeout_year"
      expr: YEAR(tapeout_date)
      comment: "Year of tapeout for trend analysis and capacity planning."
    - name: "tapeout_quarter"
      expr: CONCAT(CAST(YEAR(tapeout_date) AS STRING), '-Q', CAST(QUARTER(tapeout_date) AS STRING))
      comment: "Quarter of tapeout for quarterly performance tracking and forecasting."
    - name: "metal_layer_count"
      expr: metal_layer_count
      comment: "Number of metal layers in the design for complexity and cost correlation."
    - name: "packaging_type"
      expr: packaging_type
      comment: "Type of packaging technology for assembly cost and capability planning."
    - name: "drc_clean_flag"
      expr: CASE WHEN drc_clean THEN 'DRC Clean' ELSE 'DRC Issues' END
      comment: "Design rule check cleanliness status for quality gate tracking."
    - name: "lvs_clean_flag"
      expr: CASE WHEN lvs_clean THEN 'LVS Clean' ELSE 'LVS Issues' END
      comment: "Layout versus schematic cleanliness status for design integrity verification."
    - name: "signoff_complete_flag"
      expr: CASE WHEN signoff_checklist_complete THEN 'Signoff Complete' ELSE 'Signoff Pending' END
      comment: "Design sign-off checklist completion status for readiness assessment."
  measures:
    - name: "total_tapeouts"
      expr: COUNT(1)
      comment: "Total number of tapeouts for volume and throughput tracking."
    - name: "total_mask_cost_usd"
      expr: SUM(CAST(mask_cost_usd AS DOUBLE))
      comment: "Total mask set costs across all tapeouts for capital expenditure tracking and foundry cost analysis."
    - name: "total_nre_cost_usd"
      expr: SUM(CAST(nre_cost_usd AS DOUBLE))
      comment: "Total non-recurring engineering costs for tapeout execution for financial planning."
    - name: "avg_mask_cost_per_tapeout_usd"
      expr: AVG(CAST(mask_cost_usd AS DOUBLE))
      comment: "Average mask cost per tapeout for cost benchmarking and budgeting."
    - name: "avg_die_size_mm2"
      expr: AVG(CAST(die_size_mm2 AS DOUBLE))
      comment: "Average die size in square millimeters for silicon cost estimation and yield modeling."
    - name: "avg_expected_yield_pct"
      expr: AVG(CAST(expected_yield_pct AS DOUBLE))
      comment: "Average expected manufacturing yield percentage for production cost and capacity planning."
    - name: "avg_dfm_score"
      expr: AVG(CAST(dfm_score AS DOUBLE))
      comment: "Average design-for-manufacturability score for process maturity and yield risk assessment."
    - name: "avg_dft_coverage_pct"
      expr: AVG(CAST(dft_coverage_pct AS DOUBLE))
      comment: "Average design-for-test coverage percentage for test cost and quality prediction."
    - name: "tapeouts_drc_clean"
      expr: COUNT(CASE WHEN drc_clean THEN 1 END)
      comment: "Count of tapeouts with clean DRC status for quality gate pass rate tracking."
    - name: "tapeouts_lvs_clean"
      expr: COUNT(CASE WHEN lvs_clean THEN 1 END)
      comment: "Count of tapeouts with clean LVS status for design integrity verification rate."
    - name: "tapeouts_signoff_complete"
      expr: COUNT(CASE WHEN signoff_checklist_complete THEN 1 END)
      comment: "Count of tapeouts with complete sign-off checklist for readiness and risk assessment."
    - name: "first_pass_quality_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN drc_clean AND lvs_clean AND erc_clean THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of tapeouts passing all design checks (DRC, LVS, ERC) on first submission for execution quality measurement."
    - name: "distinct_customers"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of distinct customers with tapeouts for revenue diversification analysis."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`design_ip_core`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "IP core portfolio and licensing metrics tracking reuse economics, qualification status, and technology readiness for design productivity and cost reduction."
  source: "`vibe_semiconductors_v1`.`design`.`design_ip_core`"
  dimensions:
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle status of the IP core (e.g., Active, Deprecated, Under Development) for portfolio health."
    - name: "qualification_status"
      expr: qualification_status
      comment: "Qualification and validation status for production readiness assessment."
    - name: "ip_type"
      expr: ip_type
      comment: "Type of IP core (e.g., Hard IP, Soft IP, Firm IP) for technology and reuse strategy segmentation."
    - name: "function_category"
      expr: function_category
      comment: "Functional category of the IP core (e.g., Processor, Memory Controller, Interface) for capability mapping."
    - name: "source_type"
      expr: source_type
      comment: "Source of the IP core (e.g., Internal, Third-Party, Open Source) for make-vs-buy analysis."
    - name: "license_type"
      expr: license_type
      comment: "Type of licensing model (e.g., Perpetual, Subscription, Royalty-Bearing) for cost structure analysis."
    - name: "vendor_name"
      expr: vendor_name
      comment: "Name of the IP vendor or supplier for supplier performance and concentration tracking."
    - name: "silicon_proven_flag"
      expr: CASE WHEN silicon_proven THEN 'Silicon Proven' ELSE 'Not Silicon Proven' END
      comment: "Silicon validation status for risk assessment and qualification tracking."
    - name: "dft_compliant_flag"
      expr: CASE WHEN dft_compliant THEN 'DFT Compliant' ELSE 'DFT Non-Compliant' END
      comment: "Design-for-test compliance status for testability and quality requirements."
    - name: "dfm_compliant_flag"
      expr: CASE WHEN dfm_compliant THEN 'DFM Compliant' ELSE 'DFM Non-Compliant' END
      comment: "Design-for-manufacturability compliance status for yield and manufacturing readiness."
    - name: "gds_available_flag"
      expr: CASE WHEN gds_available THEN 'GDS Available' ELSE 'GDS Not Available' END
      comment: "GDS layout availability for hard IP integration readiness."
  measures:
    - name: "total_ip_cores"
      expr: COUNT(1)
      comment: "Total number of IP cores in the portfolio for asset inventory and reuse potential tracking."
    - name: "total_license_fee_usd"
      expr: SUM(CAST(license_fee_usd AS DOUBLE))
      comment: "Total upfront license fees across all IP cores for capital expenditure and IP investment tracking."
    - name: "avg_license_fee_usd"
      expr: AVG(CAST(license_fee_usd AS DOUBLE))
      comment: "Average license fee per IP core for cost benchmarking and budgeting."
    - name: "avg_royalty_rate_pct"
      expr: AVG(CAST(royalty_rate_pct AS DOUBLE))
      comment: "Average royalty rate percentage for ongoing cost-of-goods-sold modeling and pricing strategy."
    - name: "avg_gate_count"
      expr: AVG(CAST(gate_count AS DOUBLE))
      comment: "Average gate count per IP core for complexity and area estimation."
    - name: "avg_area_um2"
      expr: AVG(CAST(area_um2 AS DOUBLE))
      comment: "Average silicon area in square micrometers for die cost and floorplanning analysis."
    - name: "avg_max_frequency_mhz"
      expr: AVG(CAST(max_frequency_mhz AS DOUBLE))
      comment: "Average maximum operating frequency in MHz for performance capability benchmarking."
    - name: "avg_power_uw"
      expr: AVG(CAST(power_uw AS DOUBLE))
      comment: "Average power consumption in microwatts for power budget planning and efficiency analysis."
    - name: "silicon_proven_ip_count"
      expr: COUNT(CASE WHEN silicon_proven THEN 1 END)
      comment: "Count of silicon-proven IP cores for risk mitigation and qualification tracking."
    - name: "silicon_proven_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN silicon_proven THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of IP cores that are silicon-proven for portfolio maturity and risk assessment."
    - name: "dft_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN dft_compliant THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of IP cores that are DFT-compliant for testability and quality readiness."
    - name: "dfm_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN dfm_compliant THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of IP cores that are DFM-compliant for manufacturability and yield optimization."
    - name: "distinct_vendors"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of distinct IP vendors for supply chain diversification and concentration risk tracking."
    - name: "distinct_function_categories"
      expr: COUNT(DISTINCT function_category)
      comment: "Number of distinct functional categories for portfolio breadth and capability coverage assessment."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`design_verification_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Verification execution and quality metrics tracking coverage targets, sign-off status, and functional safety compliance for design quality assurance and risk mitigation."
  source: "`vibe_semiconductors_v1`.`design`.`verification_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the verification plan (e.g., Active, Completed, On Hold) for execution tracking."
    - name: "verification_methodology"
      expr: verification_methodology
      comment: "Verification methodology used (e.g., UVM, OVM, SystemVerilog) for process standardization tracking."
    - name: "design_type"
      expr: design_type
      comment: "Type of design being verified for complexity and resource allocation analysis."
    - name: "safety_criticality_level"
      expr: safety_criticality_level
      comment: "Safety criticality level (e.g., ASIL-A, ASIL-B, ASIL-D) for automotive and functional safety segmentation."
    - name: "dft_strategy"
      expr: dft_strategy
      comment: "Design-for-test strategy employed for testability and quality planning."
    - name: "signoff_approved_flag"
      expr: CASE WHEN signoff_approved THEN 'Signoff Approved' ELSE 'Signoff Pending' END
      comment: "Verification sign-off approval status for quality gate and readiness tracking."
    - name: "plan_year"
      expr: YEAR(plan_start_date)
      comment: "Year the verification plan was initiated for trend and capacity analysis."
  measures:
    - name: "total_verification_plans"
      expr: COUNT(1)
      comment: "Total number of verification plans for workload and resource capacity tracking."
    - name: "avg_functional_coverage_target_pct"
      expr: AVG(CAST(functional_coverage_target_pct AS DOUBLE))
      comment: "Average functional coverage target percentage for quality standard benchmarking."
    - name: "avg_code_coverage_target_pct"
      expr: AVG(CAST(code_coverage_target_pct AS DOUBLE))
      comment: "Average code coverage target percentage for verification thoroughness assessment."
    - name: "avg_assertion_coverage_target_pct"
      expr: AVG(CAST(assertion_coverage_target_pct AS DOUBLE))
      comment: "Average assertion coverage target percentage for formal verification rigor tracking."
    - name: "avg_fault_coverage_target_pct"
      expr: AVG(CAST(fault_coverage_target_pct AS DOUBLE))
      comment: "Average fault coverage target percentage for DFT and test quality planning."
    - name: "avg_toggle_coverage_target_pct"
      expr: AVG(CAST(toggle_coverage_target_pct AS DOUBLE))
      comment: "Average toggle coverage target percentage for activity and switching verification."
    - name: "plans_signoff_approved"
      expr: COUNT(CASE WHEN signoff_approved THEN 1 END)
      comment: "Count of verification plans with approved sign-off for quality gate pass rate tracking."
    - name: "signoff_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN signoff_approved THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of verification plans that achieved sign-off approval for execution quality measurement."
    - name: "distinct_methodologies"
      expr: COUNT(DISTINCT verification_methodology)
      comment: "Number of distinct verification methodologies in use for process standardization assessment."
    - name: "distinct_safety_levels"
      expr: COUNT(DISTINCT safety_criticality_level)
      comment: "Number of distinct safety criticality levels for functional safety portfolio segmentation."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`design_physical_layout`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Physical design implementation metrics tracking timing closure, power efficiency, and design rule compliance for silicon quality and manufacturability."
  source: "`vibe_semiconductors_v1`.`design`.`physical_layout`"
  dimensions:
    - name: "layout_status"
      expr: layout_status
      comment: "Current status of the physical layout (e.g., In Progress, Completed, Failed) for execution tracking."
    - name: "implementation_stage"
      expr: implementation_stage
      comment: "Current implementation stage (e.g., Floorplan, Placement, Routing, Signoff) for pipeline analysis."
    - name: "metal_layer_count"
      expr: metal_layer_count
      comment: "Number of metal layers in the layout for complexity and cost correlation."
    - name: "lvs_clean_flag"
      expr: CASE WHEN lvs_clean THEN 'LVS Clean' ELSE 'LVS Issues' END
      comment: "Layout versus schematic cleanliness status for design integrity verification."
    - name: "em_compliant_flag"
      expr: CASE WHEN em_compliant THEN 'EM Compliant' ELSE 'EM Non-Compliant' END
      comment: "Electromigration compliance status for reliability and quality assessment."
    - name: "timing_closure_flag"
      expr: CASE WHEN wns_ps >= 0 THEN 'Timing Closed' ELSE 'Timing Open' END
      comment: "Timing closure status based on worst negative slack for schedule and quality risk."
    - name: "tapeout_year"
      expr: YEAR(tapeout_date)
      comment: "Year of tapeout for trend and capacity analysis."
  measures:
    - name: "total_layouts"
      expr: COUNT(1)
      comment: "Total number of physical layouts for workload and throughput tracking."
    - name: "avg_die_area_mm2"
      expr: AVG(CAST(die_area_mm2 AS DOUBLE))
      comment: "Average die area in square millimeters for silicon cost estimation and yield modeling."
    - name: "avg_core_area_mm2"
      expr: AVG(CAST(core_area_mm2 AS DOUBLE))
      comment: "Average core area in square millimeters for logic density and utilization analysis."
    - name: "avg_cell_utilization_pct"
      expr: AVG(CAST(cell_utilization_pct AS DOUBLE))
      comment: "Average cell utilization percentage for area efficiency and routing congestion assessment."
    - name: "avg_power_consumption_mw"
      expr: AVG(CAST(power_consumption_mw AS DOUBLE))
      comment: "Average power consumption in milliwatts for power budget compliance and thermal management."
    - name: "avg_leakage_power_uw"
      expr: AVG(CAST(leakage_power_uw AS DOUBLE))
      comment: "Average leakage power in microwatts for low-power design effectiveness and battery life impact."
    - name: "avg_wns_ps"
      expr: AVG(CAST(wns_ps AS DOUBLE))
      comment: "Average worst negative slack in picoseconds for timing closure health and performance risk."
    - name: "avg_tns_ps"
      expr: AVG(CAST(tns_ps AS DOUBLE))
      comment: "Average total negative slack in picoseconds for overall timing quality assessment."
    - name: "avg_ir_drop_max_mv"
      expr: AVG(CAST(ir_drop_max_mv AS DOUBLE))
      comment: "Average maximum IR drop in millivolts for power grid integrity and reliability assessment."
    - name: "avg_dfm_score"
      expr: AVG(CAST(dfm_score AS DOUBLE))
      comment: "Average design-for-manufacturability score for yield prediction and process maturity."
    - name: "avg_dft_coverage_pct"
      expr: AVG(CAST(dft_coverage_pct AS DOUBLE))
      comment: "Average design-for-test coverage percentage for test cost and quality prediction."
    - name: "avg_routing_congestion_max_pct"
      expr: AVG(CAST(routing_congestion_max_pct AS DOUBLE))
      comment: "Average maximum routing congestion percentage for routability and timing risk assessment."
    - name: "layouts_lvs_clean"
      expr: COUNT(CASE WHEN lvs_clean THEN 1 END)
      comment: "Count of layouts with clean LVS status for design integrity verification rate."
    - name: "layouts_em_compliant"
      expr: COUNT(CASE WHEN em_compliant THEN 1 END)
      comment: "Count of layouts that are electromigration compliant for reliability quality tracking."
    - name: "timing_closure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN wns_ps >= 0 THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of layouts achieving timing closure (WNS >= 0) for execution quality and schedule risk."
$$;