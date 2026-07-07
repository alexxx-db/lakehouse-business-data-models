-- Metric views for domain: design | Business: Semiconductors | Version: 2 | Generated on: 2026-06-27 11:25:39

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`design_ic_design_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core IC design project performance metrics tracking budget adherence, schedule performance, and design complexity targets across semiconductor design initiatives."
  source: "`vibe_semiconductors_v1`.`design`.`ic_design_project`"
  dimensions:
    - name: "design_phase"
      expr: design_phase
      comment: "Current phase of the IC design project lifecycle (e.g., RTL, synthesis, place-and-route, verification, tapeout)."
    - name: "project_status"
      expr: project_status
      comment: "Overall status of the design project (e.g., active, on-hold, completed, cancelled)."
    - name: "process_node_nm"
      expr: process_node_nm
      comment: "Target semiconductor process node in nanometers (e.g., 7nm, 5nm, 3nm) indicating manufacturing technology generation."
    - name: "design_type"
      expr: design_type
      comment: "Classification of design type (e.g., ASIC, SoC, analog, mixed-signal, digital)."
    - name: "eda_tool_suite"
      expr: eda_tool_suite
      comment: "Primary EDA tool suite used for design (e.g., Cadence, Synopsys, Mentor Graphics)."
    - name: "lithography_type"
      expr: lithography_type
      comment: "Lithography technology used (e.g., DUV, EUV) impacting manufacturing cost and capability."
    - name: "packaging_type"
      expr: packaging_type
      comment: "Target packaging technology (e.g., flip-chip, wire-bond, 2.5D, 3D) affecting cost and performance."
    - name: "project_start_year"
      expr: YEAR(project_start_date)
      comment: "Year the design project was initiated for cohort analysis."
    - name: "project_start_quarter"
      expr: CONCAT('Q', QUARTER(project_start_date), '-', YEAR(project_start_date))
      comment: "Quarter and year of project start for time-series analysis."
    - name: "tapeout_target_year"
      expr: YEAR(tapeout_target_date)
      comment: "Target year for tapeout milestone."
    - name: "dft_enabled_flag"
      expr: CASE WHEN dft_enabled = TRUE THEN 'DFT Enabled' ELSE 'DFT Not Enabled' END
      comment: "Whether design-for-test features are enabled, critical for manufacturing yield."
    - name: "rohs_compliant_flag"
      expr: CASE WHEN rohs_compliant = TRUE THEN 'RoHS Compliant' ELSE 'Not RoHS Compliant' END
      comment: "RoHS compliance status for regulatory and market access requirements."
  measures:
    - name: "total_projects"
      expr: COUNT(1)
      comment: "Total number of IC design projects, baseline metric for portfolio size."
    - name: "total_nre_budget_usd"
      expr: SUM(CAST(nre_budget_usd AS DOUBLE))
      comment: "Total non-recurring engineering budget allocated across all design projects in USD."
    - name: "total_nre_actual_spend_usd"
      expr: SUM(CAST(nre_actual_spend_usd AS DOUBLE))
      comment: "Total actual NRE spend across all design projects in USD, tracking cost execution."
    - name: "nre_budget_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(nre_actual_spend_usd AS DOUBLE)) / NULLIF(SUM(CAST(nre_budget_usd AS DOUBLE)), 0), 2)
      comment: "Percentage of NRE budget consumed, key metric for financial discipline and project cost control."
    - name: "avg_nre_budget_per_project_usd"
      expr: AVG(CAST(nre_budget_usd AS DOUBLE))
      comment: "Average NRE budget per project, indicating typical project investment size."
    - name: "avg_target_die_area_mm2"
      expr: AVG(CAST(target_die_area_mm2 AS DOUBLE))
      comment: "Average target die area in square millimeters, proxy for design complexity and manufacturing cost."
    - name: "avg_target_power_budget_mw"
      expr: AVG(CAST(target_power_budget_mw AS DOUBLE))
      comment: "Average target power budget in milliwatts, critical for mobile and power-sensitive applications."
    - name: "avg_gate_count_target_k"
      expr: AVG(CAST(gate_count_target_k AS DOUBLE))
      comment: "Average target gate count in thousands, indicating design complexity and logic density."
    - name: "avg_target_clock_freq_mhz"
      expr: AVG(CAST(target_clock_freq_mhz AS DOUBLE))
      comment: "Average target clock frequency in MHz, key performance specification for digital designs."
    - name: "schedule_adherence_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN tapeout_actual_date <= tapeout_target_date THEN 1 END) / NULLIF(COUNT(CASE WHEN tapeout_actual_date IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of projects that met or beat tapeout target date, critical KPI for execution excellence and time-to-market."
    - name: "projects_with_tapeout"
      expr: COUNT(CASE WHEN tapeout_actual_date IS NOT NULL THEN 1 END)
      comment: "Number of projects that have completed tapeout, indicating portfolio maturity."
    - name: "dft_adoption_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN dft_enabled = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of projects with DFT enabled, indicating testability and yield optimization focus."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`design_tapeout`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tapeout execution metrics tracking design quality, manufacturing readiness, and mask cost efficiency for semiconductor production handoff."
  source: "`vibe_semiconductors_v1`.`design`.`tapeout`"
  dimensions:
    - name: "tapeout_status"
      expr: tapeout_status
      comment: "Status of the tapeout event (e.g., submitted, accepted, in-production, cancelled)."
    - name: "tapeout_type"
      expr: tapeout_type
      comment: "Type of tapeout (e.g., full production, MPW shuttle, prototype, engineering sample)."
    - name: "foundry_name"
      expr: foundry_name
      comment: "Semiconductor foundry partner (e.g., TSMC, Samsung, GlobalFoundries) for manufacturing."
    - name: "lithography_type"
      expr: lithography_type
      comment: "Lithography technology used (e.g., DUV, EUV) impacting cost and yield."
    - name: "design_type"
      expr: design_type
      comment: "Type of design being taped out (e.g., ASIC, SoC, analog, mixed-signal)."
    - name: "packaging_type"
      expr: packaging_type
      comment: "Packaging technology for the taped-out design."
    - name: "target_market_segment"
      expr: target_market_segment
      comment: "Target market segment (e.g., automotive, mobile, IoT, data-center) for strategic portfolio analysis."
    - name: "tapeout_year"
      expr: YEAR(tapeout_date)
      comment: "Year of tapeout for time-series trend analysis."
    - name: "tapeout_quarter"
      expr: CONCAT('Q', QUARTER(tapeout_date), '-', YEAR(tapeout_date))
      comment: "Quarter and year of tapeout for quarterly performance tracking."
    - name: "drc_clean_flag"
      expr: CASE WHEN drc_clean = TRUE THEN 'DRC Clean' ELSE 'DRC Violations' END
      comment: "Design rule check status, critical quality gate for manufacturing success."
    - name: "lvs_clean_flag"
      expr: CASE WHEN lvs_clean = TRUE THEN 'LVS Clean' ELSE 'LVS Violations' END
      comment: "Layout versus schematic check status, ensuring design integrity."
    - name: "timing_closure_status"
      expr: timing_closure_status
      comment: "Timing closure status at tapeout, indicating design performance readiness."
    - name: "signoff_checklist_complete_flag"
      expr: CASE WHEN signoff_checklist_complete = TRUE THEN 'Signoff Complete' ELSE 'Signoff Incomplete' END
      comment: "Whether all signoff criteria were met before tapeout submission."
  measures:
    - name: "total_tapeouts"
      expr: COUNT(1)
      comment: "Total number of tapeout events, baseline metric for design execution throughput."
    - name: "total_mask_cost_usd"
      expr: SUM(CAST(mask_cost_usd AS DOUBLE))
      comment: "Total mask set cost in USD, major NRE component for advanced nodes."
    - name: "total_nre_cost_usd"
      expr: SUM(CAST(nre_cost_usd AS DOUBLE))
      comment: "Total non-recurring engineering cost for tapeouts in USD, tracking total investment."
    - name: "avg_mask_cost_usd"
      expr: AVG(CAST(mask_cost_usd AS DOUBLE))
      comment: "Average mask cost per tapeout in USD, indicating typical mask investment."
    - name: "avg_nre_cost_usd"
      expr: AVG(CAST(nre_cost_usd AS DOUBLE))
      comment: "Average NRE cost per tapeout in USD, benchmark for project economics."
    - name: "avg_die_size_mm2"
      expr: AVG(CAST(die_size_mm2 AS DOUBLE))
      comment: "Average die size in square millimeters, key driver of manufacturing cost and yield."
    - name: "avg_expected_yield_pct"
      expr: AVG(CAST(expected_yield_pct AS DOUBLE))
      comment: "Average expected manufacturing yield percentage, critical for unit economics and profitability."
    - name: "avg_dfm_score"
      expr: AVG(CAST(dfm_score AS DOUBLE))
      comment: "Average design-for-manufacturing score, indicating manufacturability and yield optimization."
    - name: "avg_dft_coverage_pct"
      expr: AVG(CAST(dft_coverage_pct AS DOUBLE))
      comment: "Average design-for-test coverage percentage, critical for production test efficiency and quality."
    - name: "first_pass_success_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN drc_clean = TRUE AND lvs_clean = TRUE AND erc_clean = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of tapeouts passing all design checks (DRC, LVS, ERC) on first submission, key quality and efficiency metric."
    - name: "signoff_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN signoff_checklist_complete = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of tapeouts with complete signoff checklist, indicating process discipline and readiness."
    - name: "timing_closure_achievement_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN timing_closure_status = 'Closed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of tapeouts achieving timing closure, critical for meeting performance specifications."
    - name: "mask_cost_per_mm2"
      expr: ROUND(SUM(CAST(mask_cost_usd AS DOUBLE)) / NULLIF(SUM(CAST(die_size_mm2 AS DOUBLE)), 0), 2)
      comment: "Mask cost per square millimeter of die area, efficiency metric for mask investment relative to silicon area."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`design_ip_core`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "IP core portfolio metrics tracking reusability, licensing economics, and design quality for semiconductor intellectual property assets."
  source: "`vibe_semiconductors_v1`.`design`.`ip_core`"
  dimensions:
    - name: "ip_type"
      expr: ip_type
      comment: "Type of IP core (e.g., processor, memory controller, interface, analog, mixed-signal)."
    - name: "function_category"
      expr: function_category
      comment: "Functional category of the IP core (e.g., connectivity, compute, storage, power management)."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Lifecycle status of the IP (e.g., active, deprecated, under-development, end-of-life)."
    - name: "source_type"
      expr: source_type
      comment: "Source of the IP core (e.g., in-house, third-party, open-source, acquired)."
    - name: "license_type"
      expr: license_type
      comment: "Licensing model (e.g., perpetual, subscription, royalty-bearing, royalty-free)."
    - name: "vendor_name"
      expr: vendor_name
      comment: "Vendor or provider of the IP core for third-party IP tracking."
    - name: "qualification_status"
      expr: qualification_status
      comment: "Qualification status (e.g., qualified, in-qualification, not-qualified) for production readiness."
    - name: "silicon_proven_flag"
      expr: CASE WHEN silicon_proven = TRUE THEN 'Silicon Proven' ELSE 'Not Silicon Proven' END
      comment: "Whether the IP has been proven in silicon, reducing integration risk."
    - name: "gds_available_flag"
      expr: CASE WHEN gds_available = TRUE THEN 'GDS Available' ELSE 'GDS Not Available' END
      comment: "Whether hard IP GDS layout is available for direct integration."
    - name: "mpw_eligible_flag"
      expr: CASE WHEN mpw_eligible = TRUE THEN 'MPW Eligible' ELSE 'Not MPW Eligible' END
      comment: "Whether IP is eligible for multi-project wafer shuttle runs."
    - name: "rohs_compliant_flag"
      expr: CASE WHEN rohs_compliant = TRUE THEN 'RoHS Compliant' ELSE 'Not RoHS Compliant' END
      comment: "RoHS compliance status for regulatory requirements."
    - name: "release_year"
      expr: YEAR(release_date)
      comment: "Year the IP core was released for portfolio age analysis."
  measures:
    - name: "total_ip_cores"
      expr: COUNT(1)
      comment: "Total number of IP cores in the portfolio, baseline metric for IP asset inventory."
    - name: "total_license_fee_usd"
      expr: SUM(CAST(license_fee_usd AS DOUBLE))
      comment: "Total upfront license fees across all IP cores in USD, tracking IP acquisition investment."
    - name: "avg_license_fee_usd"
      expr: AVG(CAST(license_fee_usd AS DOUBLE))
      comment: "Average license fee per IP core in USD, indicating typical IP investment."
    - name: "avg_royalty_rate_pct"
      expr: AVG(CAST(royalty_rate_pct AS DOUBLE))
      comment: "Average royalty rate percentage for royalty-bearing IP, impacting unit economics."
    - name: "avg_gate_count"
      expr: AVG(CAST(gate_count AS DOUBLE))
      comment: "Average gate count across IP cores, indicating typical IP complexity."
    - name: "avg_area_um2"
      expr: AVG(CAST(area_um2 AS DOUBLE))
      comment: "Average area in square micrometers, key metric for silicon footprint and integration cost."
    - name: "avg_power_uw"
      expr: AVG(CAST(power_uw AS DOUBLE))
      comment: "Average power consumption in microwatts, critical for power-constrained designs."
    - name: "avg_max_frequency_mhz"
      expr: AVG(CAST(max_frequency_mhz AS DOUBLE))
      comment: "Average maximum operating frequency in MHz, indicating performance capability."
    - name: "avg_scan_coverage_pct"
      expr: AVG(CAST(scan_coverage_pct AS DOUBLE))
      comment: "Average scan test coverage percentage, indicating testability and quality."
    - name: "silicon_proven_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN silicon_proven = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of IP cores that are silicon proven, reducing integration risk and time-to-market."
    - name: "gds_availability_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN gds_available = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of IP cores with GDS available, enabling hard IP integration strategies."
    - name: "qualification_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN qualification_status = 'Qualified' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of IP cores fully qualified for production use, indicating portfolio readiness."
    - name: "power_efficiency_uw_per_mhz"
      expr: ROUND(AVG(CAST(power_uw AS DOUBLE) / NULLIF(CAST(max_frequency_mhz AS DOUBLE), 0)), 2)
      comment: "Average power consumption per MHz of operating frequency, key efficiency metric for performance-per-watt optimization."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`design_physical_layout`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Physical layout quality and efficiency metrics tracking design rule compliance, area utilization, and timing closure for place-and-route execution."
  source: "`vibe_semiconductors_v1`.`design`.`physical_layout`"
  dimensions:
    - name: "layout_status"
      expr: layout_status
      comment: "Status of the physical layout (e.g., in-progress, complete, signed-off, failed)."
    - name: "implementation_stage"
      expr: implementation_stage
      comment: "Stage of physical implementation (e.g., floorplan, placement, CTS, routing, finishing)."
    - name: "eda_tool"
      expr: eda_tool
      comment: "EDA tool used for physical design (e.g., Cadence Innovus, Synopsys ICC2)."
    - name: "gds_file_format"
      expr: gds_file_format
      comment: "GDS file format version (e.g., GDSII, OASIS) for layout data exchange."
    - name: "lvs_clean_flag"
      expr: CASE WHEN lvs_clean = TRUE THEN 'LVS Clean' ELSE 'LVS Violations' END
      comment: "Layout versus schematic verification status, critical quality gate."
    - name: "em_compliant_flag"
      expr: CASE WHEN em_compliant = TRUE THEN 'EM Compliant' ELSE 'EM Violations' END
      comment: "Electromigration compliance status, ensuring reliability."
    - name: "tapeout_year"
      expr: YEAR(tapeout_date)
      comment: "Year of tapeout for time-series analysis."
  measures:
    - name: "total_layouts"
      expr: COUNT(1)
      comment: "Total number of physical layouts, baseline metric for design execution volume."
    - name: "avg_die_area_mm2"
      expr: AVG(CAST(die_area_mm2 AS DOUBLE))
      comment: "Average die area in square millimeters, key driver of manufacturing cost."
    - name: "avg_core_area_mm2"
      expr: AVG(CAST(core_area_mm2 AS DOUBLE))
      comment: "Average core area in square millimeters, indicating active logic area."
    - name: "avg_cell_utilization_pct"
      expr: AVG(CAST(cell_utilization_pct AS DOUBLE))
      comment: "Average cell utilization percentage, indicating how efficiently die area is used for logic."
    - name: "avg_power_consumption_mw"
      expr: AVG(CAST(power_consumption_mw AS DOUBLE))
      comment: "Average power consumption in milliwatts, critical for thermal and battery life considerations."
    - name: "avg_leakage_power_uw"
      expr: AVG(CAST(leakage_power_uw AS DOUBLE))
      comment: "Average leakage power in microwatts, important for standby power and battery-operated devices."
    - name: "avg_wns_ps"
      expr: AVG(CAST(wns_ps AS DOUBLE))
      comment: "Average worst negative slack in picoseconds, key timing metric (negative values indicate timing violations)."
    - name: "avg_tns_ps"
      expr: AVG(CAST(tns_ps AS DOUBLE))
      comment: "Average total negative slack in picoseconds, aggregate timing health metric."
    - name: "avg_cts_skew_ps"
      expr: AVG(CAST(cts_skew_ps AS DOUBLE))
      comment: "Average clock tree synthesis skew in picoseconds, impacting timing margin and performance."
    - name: "avg_ir_drop_max_mv"
      expr: AVG(CAST(ir_drop_max_mv AS DOUBLE))
      comment: "Average maximum IR drop in millivolts, indicating power delivery network quality."
    - name: "avg_routing_congestion_max_pct"
      expr: AVG(CAST(routing_congestion_max_pct AS DOUBLE))
      comment: "Average maximum routing congestion percentage, indicating routability challenges."
    - name: "avg_metal_fill_density_pct"
      expr: AVG(CAST(metal_fill_density_pct AS DOUBLE))
      comment: "Average metal fill density percentage, required for CMP uniformity in manufacturing."
    - name: "avg_dfm_score"
      expr: AVG(CAST(dfm_score AS DOUBLE))
      comment: "Average design-for-manufacturing score, indicating manufacturability and yield potential."
    - name: "avg_dft_coverage_pct"
      expr: AVG(CAST(dft_coverage_pct AS DOUBLE))
      comment: "Average design-for-test coverage percentage, critical for production test efficiency."
    - name: "lvs_clean_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN lvs_clean = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of layouts passing LVS verification, critical quality gate for design correctness."
    - name: "em_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN em_compliant = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of layouts meeting electromigration rules, ensuring long-term reliability."
    - name: "area_efficiency_ratio"
      expr: ROUND(AVG(CAST(core_area_mm2 AS DOUBLE) / NULLIF(CAST(die_area_mm2 AS DOUBLE), 0)), 4)
      comment: "Ratio of core area to total die area, indicating how much of the die is used for active logic versus IO and periphery."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`design_verification_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Verification planning and coverage metrics tracking test completeness, quality targets, and functional safety compliance for design validation."
  source: "`vibe_semiconductors_v1`.`design`.`verification_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Status of the verification plan (e.g., draft, active, complete, approved)."
    - name: "verification_methodology"
      expr: verification_methodology
      comment: "Verification methodology used (e.g., UVM, OVM, VMM, traditional testbench)."
    - name: "design_type"
      expr: design_type
      comment: "Type of design being verified (e.g., ASIC, SoC, IP block)."
    - name: "safety_criticality_level"
      expr: safety_criticality_level
      comment: "Safety criticality level (e.g., ASIL-A through ASIL-D for automotive, SIL for industrial) for functional safety requirements."
    - name: "simulation_tool"
      expr: simulation_tool
      comment: "Primary simulation tool used for verification (e.g., VCS, ModelSim, Xcelium)."
    - name: "formal_verification_tool"
      expr: formal_verification_tool
      comment: "Formal verification tool used (e.g., JasperGold, VC Formal) for exhaustive property checking."
    - name: "emulation_platform"
      expr: emulation_platform
      comment: "Hardware emulation platform used (e.g., Palladium, Veloce, Zebu) for accelerated verification."
    - name: "signoff_approved_flag"
      expr: CASE WHEN signoff_approved = TRUE THEN 'Signoff Approved' ELSE 'Not Approved' END
      comment: "Whether the verification plan has been approved for signoff."
    - name: "plan_start_year"
      expr: YEAR(plan_start_date)
      comment: "Year the verification plan started for time-series analysis."
  measures:
    - name: "total_verification_plans"
      expr: COUNT(1)
      comment: "Total number of verification plans, baseline metric for verification portfolio size."
    - name: "avg_functional_coverage_target_pct"
      expr: AVG(CAST(functional_coverage_target_pct AS DOUBLE))
      comment: "Average functional coverage target percentage, indicating verification completeness goals."
    - name: "avg_code_coverage_target_pct"
      expr: AVG(CAST(code_coverage_target_pct AS DOUBLE))
      comment: "Average code coverage target percentage, measuring structural verification completeness."
    - name: "avg_assertion_coverage_target_pct"
      expr: AVG(CAST(assertion_coverage_target_pct AS DOUBLE))
      comment: "Average assertion coverage target percentage, indicating property-based verification depth."
    - name: "avg_toggle_coverage_target_pct"
      expr: AVG(CAST(toggle_coverage_target_pct AS DOUBLE))
      comment: "Average toggle coverage target percentage, measuring signal activity coverage."
    - name: "avg_fault_coverage_target_pct"
      expr: AVG(CAST(fault_coverage_target_pct AS DOUBLE))
      comment: "Average fault coverage target percentage for DFT, critical for manufacturing test quality."
    - name: "avg_safety_mechanism_coverage_target_pct"
      expr: AVG(CAST(safety_mechanism_coverage_target_pct AS DOUBLE))
      comment: "Average safety mechanism coverage target percentage for functional safety compliance (e.g., ISO 26262)."
    - name: "signoff_approval_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN signoff_approved = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of verification plans that have received signoff approval, indicating verification readiness and quality gate passage."
    - name: "avg_coverage_target_composite"
      expr: ROUND((AVG(CAST(functional_coverage_target_pct AS DOUBLE)) + AVG(CAST(code_coverage_target_pct AS DOUBLE)) + AVG(CAST(assertion_coverage_target_pct AS DOUBLE))) / 3.0, 2)
      comment: "Composite average of functional, code, and assertion coverage targets, overall verification rigor indicator."
    - name: "safety_critical_plan_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN safety_criticality_level IS NOT NULL AND safety_criticality_level != '' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of verification plans with defined safety criticality levels, indicating functional safety focus in portfolio."
$$;