-- Metric views for domain: design | Business: Semiconductors | Version: 2 | Generated on: 2026-07-10 11:52:05

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`design_ic_design_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for IC design projects covering NRE budget performance, tapeout pipeline, and design portfolio health. Used by VP Engineering and CFO to steer R&D investment and track design-to-silicon conversion."
  source: "`vibe_semiconductors_v1`.`design`.`ic_design_project`"
  dimensions:
    - name: "project_status"
      expr: project_status
      comment: "Current lifecycle status of the IC design project (e.g. Active, On Hold, Completed, Cancelled) — primary filter for portfolio health dashboards."
    - name: "design_phase"
      expr: design_phase
      comment: "Current design phase (e.g. RTL, Synthesis, P&R, Signoff) — used to track pipeline stage distribution across the portfolio."
    - name: "design_type"
      expr: design_type
      comment: "Classification of the design (e.g. ASIC, SoC, IP, Custom) — enables portfolio segmentation by design category."
    - name: "lithography_type"
      expr: lithography_type
      comment: "Lithography technology used (e.g. EUV, DUV) — critical for cost and risk segmentation of the design portfolio."
    - name: "process_node_nm"
      expr: process_node_nm
      comment: "Process node in nanometers (e.g. 3nm, 5nm, 7nm) — key dimension for technology roadmap and cost analysis."
    - name: "project_start_date_month"
      expr: DATE_TRUNC('MONTH', project_start_date)
      comment: "Month of project start date — enables trend analysis of new project starts over time."
    - name: "tapeout_target_month"
      expr: DATE_TRUNC('MONTH', tapeout_target_date)
      comment: "Month of planned tapeout date — used to forecast tapeout pipeline and mask set demand."
    - name: "dft_enabled"
      expr: dft_enabled
      comment: "Whether Design-for-Test is enabled on the project — used to assess testability coverage across the portfolio."
    - name: "rohs_compliant"
      expr: rohs_compliant
      comment: "RoHS compliance flag — used for regulatory reporting and customer qualification tracking."
    - name: "iatf_automotive_grade"
      expr: iatf_automotive_grade
      comment: "Whether the project targets automotive-grade qualification (IATF 16949) — segments automotive vs. commercial design portfolio."
  measures:
    - name: "active_project_count"
      expr: COUNT(1)
      comment: "Total number of IC design projects in the selected filter context. Baseline portfolio size metric used in executive dashboards."
    - name: "total_nre_budget_usd"
      expr: SUM(CAST(nre_budget_usd AS DOUBLE))
      comment: "Total NRE (Non-Recurring Engineering) budget committed across all projects. Directly tracks R&D capital allocation and is a primary CFO steering metric."
    - name: "total_nre_actual_spend_usd"
      expr: SUM(CAST(nre_actual_spend_usd AS DOUBLE))
      comment: "Total actual NRE spend incurred across all projects. Compared against budget to identify overruns requiring executive intervention."
    - name: "avg_nre_budget_usd"
      expr: AVG(CAST(nre_budget_usd AS DOUBLE))
      comment: "Average NRE budget per IC design project. Benchmarks investment intensity per project and informs resource planning."
    - name: "nre_budget_utilization_pct"
      expr: ROUND(100.0 * SUM(CAST(nre_actual_spend_usd AS DOUBLE)) / NULLIF(SUM(CAST(nre_budget_usd AS DOUBLE)), 0), 2)
      comment: "Percentage of NRE budget consumed (actual / budget × 100). A key financial health indicator — values above 100% signal budget overrun requiring CFO action."
    - name: "total_gate_count_target_k"
      expr: SUM(CAST(gate_count_target_k AS DOUBLE))
      comment: "Sum of gate count targets (in thousands) across all projects. Proxy for design complexity and silicon area demand in the portfolio."
    - name: "avg_target_die_area_mm2"
      expr: AVG(CAST(target_die_area_mm2 AS DOUBLE))
      comment: "Average target die area in mm² across projects. Drives mask cost forecasting and wafer yield planning."
    - name: "avg_target_power_budget_mw"
      expr: AVG(CAST(target_power_budget_mw AS DOUBLE))
      comment: "Average target power budget in milliwatts. Tracks power envelope compliance across the design portfolio — critical for mobile and automotive segments."
    - name: "avg_target_clock_freq_mhz"
      expr: AVG(CAST(target_clock_freq_mhz AS DOUBLE))
      comment: "Average target clock frequency in MHz across projects. Indicates performance ambition of the design portfolio and process node adequacy."
    - name: "dft_enabled_project_count"
      expr: COUNT(CASE WHEN dft_enabled = TRUE THEN 1 END)
      comment: "Number of projects with DFT enabled. Tracks testability coverage — low values indicate test escape risk in manufacturing."
    - name: "rohs_compliant_project_count"
      expr: COUNT(CASE WHEN rohs_compliant = TRUE THEN 1 END)
      comment: "Number of RoHS-compliant projects. Required for regulatory reporting and customer qualification in EU markets."
    - name: "automotive_grade_project_count"
      expr: COUNT(CASE WHEN iatf_automotive_grade = TRUE THEN 1 END)
      comment: "Number of projects targeting automotive-grade qualification. Tracks automotive market penetration strategy execution."
    - name: "distinct_process_nodes_count"
      expr: COUNT(DISTINCT process_node_nm)
      comment: "Number of distinct process nodes in the active design portfolio. High values indicate technology diversification risk and PDK maintenance burden."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`design_tapeout`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tapeout execution KPIs tracking design-to-silicon conversion, mask cost, NRE spend, and signoff quality. Used by VP Engineering, CFO, and foundry program managers to manage tapeout pipeline and cost."
  source: "`vibe_semiconductors_v1`.`design`.`tapeout`"
  dimensions:
    - name: "tapeout_status"
      expr: tapeout_status
      comment: "Current status of the tapeout (e.g. In Progress, Submitted, Completed, Cancelled) — primary pipeline health dimension."
    - name: "tapeout_type"
      expr: tapeout_type
      comment: "Type of tapeout (e.g. Full, MPW, Prototype) — used to segment cost and cycle time by tapeout category."
    - name: "design_type"
      expr: design_type
      comment: "Design classification (e.g. ASIC, SoC, IP) — enables portfolio segmentation of tapeout activity."
    - name: "process_node"
      expr: process_node
      comment: "Process node for the tapeout (e.g. 5nm, 7nm) — key cost and yield driver for tapeout economics."
    - name: "lithography_type"
      expr: lithography_type
      comment: "Lithography technology (e.g. EUV, DUV) — drives mask cost and foundry capacity planning."
    - name: "foundry_name"
      expr: foundry_name
      comment: "Name of the foundry executing the tapeout — used for foundry performance benchmarking and spend concentration analysis."
    - name: "target_market_segment"
      expr: target_market_segment
      comment: "Target market segment (e.g. Automotive, Mobile, HPC, IoT) — enables revenue pipeline attribution by market."
    - name: "tapeout_date_month"
      expr: DATE_TRUNC('MONTH', tapeout_date)
      comment: "Month of actual tapeout date — used for tapeout cadence trend analysis and foundry capacity planning."
    - name: "target_tapeout_date_month"
      expr: DATE_TRUNC('MONTH', target_tapeout_date)
      comment: "Month of planned tapeout date — used to track schedule adherence and pipeline forecasting."
    - name: "drc_clean"
      expr: drc_clean
      comment: "Whether the design passed DRC (Design Rule Check) cleanly — quality gate indicator for tapeout readiness."
    - name: "lvs_clean"
      expr: lvs_clean
      comment: "Whether the design passed LVS (Layout vs. Schematic) cleanly — critical signoff quality indicator."
    - name: "signoff_checklist_complete"
      expr: signoff_checklist_complete
      comment: "Whether the full tapeout signoff checklist was completed — governance and quality gate compliance indicator."
  measures:
    - name: "tapeout_count"
      expr: COUNT(1)
      comment: "Total number of tapeouts in the selected context. Baseline throughput metric for the design-to-silicon pipeline."
    - name: "total_mask_cost_usd"
      expr: SUM(CAST(mask_cost_usd AS DOUBLE))
      comment: "Total mask set cost in USD across all tapeouts. One of the largest NRE cost components — directly steers foundry selection and MPW vs. full-mask decisions."
    - name: "avg_mask_cost_usd"
      expr: AVG(CAST(mask_cost_usd AS DOUBLE))
      comment: "Average mask cost per tapeout. Benchmarks cost efficiency and tracks impact of process node transitions on mask economics."
    - name: "total_nre_cost_usd"
      expr: SUM(CAST(nre_cost_usd AS DOUBLE))
      comment: "Total NRE cost incurred across all tapeouts. Key P&L input for design program profitability analysis."
    - name: "avg_nre_cost_usd"
      expr: AVG(CAST(nre_cost_usd AS DOUBLE))
      comment: "Average NRE cost per tapeout. Used to benchmark cost per design start and evaluate make-vs-buy decisions."
    - name: "avg_die_size_mm2"
      expr: AVG(CAST(die_size_mm2 AS DOUBLE))
      comment: "Average die size in mm² across tapeouts. Directly drives wafer cost and yield — a primary lever for cost reduction programs."
    - name: "avg_expected_yield_pct"
      expr: AVG(CAST(expected_yield_pct AS DOUBLE))
      comment: "Average expected die yield percentage. Critical for revenue forecasting and wafer start planning — low values trigger yield improvement programs."
    - name: "avg_dfm_score"
      expr: AVG(CAST(dfm_score AS DOUBLE))
      comment: "Average Design-for-Manufacturability score across tapeouts. Predicts yield risk — low scores indicate designs likely to underperform in production."
    - name: "avg_dft_coverage_pct"
      expr: AVG(CAST(dft_coverage_pct AS DOUBLE))
      comment: "Average DFT (Design-for-Test) coverage percentage. Tracks test escape risk across the tapeout portfolio — low values increase field failure costs."
    - name: "drc_clean_tapeout_count"
      expr: COUNT(CASE WHEN drc_clean = TRUE THEN 1 END)
      comment: "Number of tapeouts that achieved DRC-clean status. Measures design quality discipline — non-DRC-clean tapeouts risk foundry rejection."
    - name: "signoff_complete_tapeout_count"
      expr: COUNT(CASE WHEN signoff_checklist_complete = TRUE THEN 1 END)
      comment: "Number of tapeouts with completed signoff checklists. Governance compliance metric — incomplete signoffs are a leading indicator of post-silicon issues."
    - name: "signoff_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN signoff_checklist_complete = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of tapeouts with completed signoff checklists. Executive quality KPI — targets typically 100%; deviations require VP Engineering review."
    - name: "ip_signoff_complete_count"
      expr: COUNT(CASE WHEN ip_sign_off_complete = TRUE THEN 1 END)
      comment: "Number of tapeouts with IP sign-off completed. Tracks IP clearance compliance — incomplete IP sign-off creates legal and export control risk."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`design_milestone`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Design milestone execution KPIs tracking gate review outcomes, schedule adherence, and design quality at key checkpoints. Used by program managers and VP Engineering to manage design schedule risk."
  source: "`vibe_semiconductors_v1`.`design`.`design_milestone`"
  dimensions:
    - name: "milestone_type"
      expr: milestone_type
      comment: "Type of design milestone (e.g. PDK Freeze, RTL Freeze, Netlist Freeze, Tapeout) — used to analyze performance by gate type."
    - name: "milestone_status"
      expr: milestone_status
      comment: "Current status of the milestone (e.g. Planned, In Progress, Completed, Delayed) — primary schedule health indicator."
    - name: "approval_disposition"
      expr: approval_disposition
      comment: "Gate review approval outcome (e.g. Approved, Approved with Conditions, Rejected) — quality gate pass/fail tracking."
    - name: "nre_phase"
      expr: nre_phase
      comment: "NRE phase associated with the milestone — links milestone completion to NRE billing and revenue recognition triggers."
    - name: "planned_date_month"
      expr: DATE_TRUNC('MONTH', planned_date)
      comment: "Month of planned milestone date — used for schedule pipeline analysis and resource demand forecasting."
    - name: "actual_date_month"
      expr: DATE_TRUNC('MONTH', actual_date)
      comment: "Month of actual milestone completion — used to measure schedule adherence trends over time."
    - name: "gate_criteria_met"
      expr: gate_criteria_met
      comment: "Whether all gate criteria were met at the review — binary quality gate compliance indicator."
    - name: "dfm_sign_off"
      expr: dfm_sign_off
      comment: "Whether DFM sign-off was achieved at this milestone — tracks manufacturability readiness at each gate."
    - name: "dft_sign_off"
      expr: dft_sign_off
      comment: "Whether DFT sign-off was achieved at this milestone — tracks testability readiness at each gate."
    - name: "tapeout_authorized"
      expr: tapeout_authorized
      comment: "Whether tapeout was authorized at this milestone — the most critical gate decision in the design flow."
  measures:
    - name: "milestone_count"
      expr: COUNT(1)
      comment: "Total number of design milestones in the selected context. Baseline throughput metric for design program activity."
    - name: "gate_criteria_met_count"
      expr: COUNT(CASE WHEN gate_criteria_met = TRUE THEN 1 END)
      comment: "Number of milestones where all gate criteria were met. Measures design quality discipline at gate reviews."
    - name: "gate_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN gate_criteria_met = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of milestones passing all gate criteria on first review. A leading indicator of design quality — low rates predict schedule overruns and rework costs."
    - name: "tapeout_authorized_count"
      expr: COUNT(CASE WHEN tapeout_authorized = TRUE THEN 1 END)
      comment: "Number of milestones where tapeout was authorized. Tracks the most critical design-to-silicon conversion decision point."
    - name: "avg_die_area_mm2"
      expr: AVG(CAST(die_area_mm2 AS DOUBLE))
      comment: "Average die area in mm² at milestone checkpoints. Tracks die size evolution through the design flow — area growth signals scope creep."
    - name: "avg_power_budget_mw"
      expr: AVG(CAST(power_budget_mw AS DOUBLE))
      comment: "Average power budget in milliwatts at milestone checkpoints. Tracks power compliance through the design flow — budget overruns require architectural changes."
    - name: "avg_timing_slack_worst_ps"
      expr: AVG(CAST(timing_slack_worst_ps AS DOUBLE))
      comment: "Average worst-case timing slack in picoseconds at milestone reviews. Negative values indicate timing violations requiring design iteration — a key schedule risk indicator."
    - name: "dfm_signoff_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN dfm_sign_off = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of milestones achieving DFM sign-off. Tracks manufacturability readiness progression — low rates predict yield issues post-tapeout."
    - name: "dft_signoff_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN dft_sign_off = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of milestones achieving DFT sign-off. Tracks test coverage readiness — low rates increase manufacturing test escape risk."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`design_simulation_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Verification simulation KPIs tracking coverage achievement, compute resource consumption, and signoff quality. Used by design verification leads and VP Engineering to manage verification closure and compute costs."
  source: "`vibe_semiconductors_v1`.`design`.`simulation_run`"
  dimensions:
    - name: "run_type"
      expr: run_type
      comment: "Type of simulation run (e.g. Functional, Formal, Timing, Power) — primary dimension for verification activity analysis."
    - name: "run_status"
      expr: run_status
      comment: "Current status of the simulation run (e.g. Running, Passed, Failed, Aborted) — used to track verification pipeline health."
    - name: "pass_fail_status"
      expr: pass_fail_status
      comment: "Pass/fail outcome of the simulation run — primary quality indicator for verification closure tracking."
    - name: "design_stage"
      expr: design_stage
      comment: "Design stage at which the simulation was run (e.g. RTL, Gate-Level, Post-Layout) — used to analyze verification effort by stage."
    - name: "process_corner"
      expr: process_corner
      comment: "Process corner simulated (e.g. TT, SS, FF, SF, FS) — used to assess corner coverage completeness."
    - name: "run_subtype"
      expr: run_subtype
      comment: "Sub-classification of the simulation run — enables granular analysis within each run type."
    - name: "signoff_approved"
      expr: signoff_approved
      comment: "Whether the simulation run was approved for signoff — tracks verification closure gate compliance."
    - name: "start_timestamp_month"
      expr: DATE_TRUNC('MONTH', start_timestamp)
      comment: "Month the simulation run started — used for compute consumption trend analysis and capacity planning."
    - name: "compute_cluster"
      expr: compute_cluster
      comment: "Compute cluster used for the simulation — used for infrastructure cost attribution and capacity utilization analysis."
  measures:
    - name: "simulation_run_count"
      expr: COUNT(1)
      comment: "Total number of simulation runs. Baseline verification throughput metric — high counts with low pass rates indicate design instability."
    - name: "passed_run_count"
      expr: COUNT(CASE WHEN pass_fail_status = 'PASS' THEN 1 END)
      comment: "Number of simulation runs that passed. Tracks verification progress toward closure."
    - name: "simulation_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN pass_fail_status = 'PASS' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of simulation runs passing. Primary verification quality KPI — declining pass rates signal design regression requiring immediate engineering action."
    - name: "total_cpu_hours_consumed"
      expr: SUM(CAST(cpu_hours_consumed AS DOUBLE))
      comment: "Total CPU hours consumed by simulation runs. Direct compute cost driver — used by infrastructure teams to right-size EDA compute budgets."
    - name: "avg_cpu_hours_per_run"
      expr: AVG(CAST(cpu_hours_consumed AS DOUBLE))
      comment: "Average CPU hours per simulation run. Benchmarks simulation efficiency — high values indicate opportunities for run optimization or parallelization."
    - name: "avg_run_duration_minutes"
      expr: AVG(CAST(run_duration_minutes AS DOUBLE))
      comment: "Average simulation run duration in minutes. Tracks EDA tool performance and identifies bottleneck simulation types."
    - name: "avg_functional_coverage_pct"
      expr: AVG(CAST(functional_coverage_pct AS DOUBLE))
      comment: "Average functional coverage percentage achieved across simulation runs. Key verification closure metric — values below target trigger additional test development."
    - name: "avg_code_coverage_pct"
      expr: AVG(CAST(code_coverage_pct AS DOUBLE))
      comment: "Average code coverage percentage. Measures RTL exercise completeness — low values indicate untested logic paths that may harbor bugs."
    - name: "avg_assertion_coverage_pct"
      expr: AVG(CAST(assertion_coverage_pct AS DOUBLE))
      comment: "Average assertion coverage percentage. Tracks formal property verification completeness — critical for safety-critical automotive designs."
    - name: "avg_toggle_coverage_pct"
      expr: AVG(CAST(toggle_coverage_pct AS DOUBLE))
      comment: "Average toggle coverage percentage. Measures signal switching exercise — used as a proxy for DFT scan coverage adequacy."
    - name: "avg_peak_memory_gb"
      expr: AVG(CAST(peak_memory_gb AS DOUBLE))
      comment: "Average peak memory consumption in GB per simulation run. Infrastructure capacity planning metric — drives EDA server memory configuration decisions."
    - name: "signoff_approved_run_count"
      expr: COUNT(CASE WHEN signoff_approved = TRUE THEN 1 END)
      comment: "Number of simulation runs approved for signoff. Tracks verification closure progress — required count must reach 100% before tapeout authorization."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`design_timing_analysis_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Static timing analysis KPIs tracking timing closure status, slack margins, and violation trends. Used by design leads and VP Engineering to manage timing risk and tapeout readiness."
  source: "`vibe_semiconductors_v1`.`design`.`timing_analysis_run`"
  dimensions:
    - name: "run_status"
      expr: run_status
      comment: "Status of the timing analysis run (e.g. Completed, Failed, In Progress) — pipeline health indicator."
    - name: "timing_closure_status"
      expr: timing_closure_status
      comment: "Timing closure outcome (e.g. Clean, Violations, Waived) — primary quality gate indicator for tapeout readiness."
    - name: "design_stage"
      expr: design_stage
      comment: "Design stage of the timing run (e.g. Synthesis, P&R, Signoff) — tracks timing convergence progression through the design flow."
    - name: "pvt_corner"
      expr: pvt_corner
      comment: "Process-Voltage-Temperature corner analyzed — used to assess worst-case timing margin coverage."
    - name: "analysis_mode"
      expr: analysis_mode
      comment: "Timing analysis mode (e.g. Setup, Hold, Multi-Corner) — used to segment timing violation analysis by constraint type."
    - name: "is_signoff_run"
      expr: is_signoff_run
      comment: "Whether this is a formal signoff timing run — used to filter analysis to authoritative tapeout-qualifying runs."
    - name: "is_multi_corner_run"
      expr: is_multi_corner_run
      comment: "Whether the run covers multiple PVT corners — multi-corner runs provide more comprehensive timing coverage."
    - name: "run_timestamp_month"
      expr: DATE_TRUNC('MONTH', run_timestamp)
      comment: "Month of the timing analysis run — used for trend analysis of timing closure progress over the design schedule."
    - name: "process_node_nm"
      expr: process_node_nm
      comment: "Process node in nanometers — used to benchmark timing performance across technology nodes."
  measures:
    - name: "timing_run_count"
      expr: COUNT(1)
      comment: "Total number of timing analysis runs. Baseline activity metric — high iteration counts indicate timing convergence difficulty."
    - name: "avg_worst_negative_slack_ps"
      expr: AVG(CAST(worst_negative_slack_ps AS DOUBLE))
      comment: "Average worst negative slack (WNS) in picoseconds. The primary timing health KPI — negative values indicate setup violations requiring frequency reduction or design changes."
    - name: "avg_total_negative_slack_ps"
      expr: AVG(CAST(total_negative_slack_ps AS DOUBLE))
      comment: "Average total negative slack (TNS) in picoseconds. Measures the aggregate timing violation burden — large TNS values indicate systemic timing issues requiring architectural intervention."
    - name: "avg_worst_hold_slack_ps"
      expr: AVG(CAST(worst_hold_slack_ps AS DOUBLE))
      comment: "Average worst hold slack in picoseconds. Tracks hold timing margin — hold violations are particularly dangerous as they cannot be fixed by frequency reduction."
    - name: "avg_total_hold_negative_slack_ps"
      expr: AVG(CAST(total_hold_negative_slack_ps AS DOUBLE))
      comment: "Average total hold negative slack in picoseconds. Aggregate hold violation burden — used to prioritize hold fixing effort in the design flow."
    - name: "avg_clock_frequency_target_mhz"
      expr: AVG(CAST(clock_frequency_target_mhz AS DOUBLE))
      comment: "Average target clock frequency in MHz across timing runs. Tracks performance ambition vs. achievable frequency — gap analysis drives architecture decisions."
    - name: "avg_supply_voltage_v"
      expr: AVG(CAST(supply_voltage_v AS DOUBLE))
      comment: "Average supply voltage used in timing analysis. Tracks voltage-frequency operating point optimization across the design portfolio."
    - name: "signoff_run_count"
      expr: COUNT(CASE WHEN is_signoff_run = TRUE THEN 1 END)
      comment: "Number of formal signoff timing runs completed. Tracks tapeout readiness — all required signoff runs must complete before tapeout authorization."
    - name: "timing_clean_run_count"
      expr: COUNT(CASE WHEN timing_closure_status = 'Clean' THEN 1 END)
      comment: "Number of timing runs achieving clean closure (no violations). Measures timing convergence success rate — the ultimate goal of the timing closure process."
    - name: "timing_closure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN timing_closure_status = 'Clean' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of timing runs achieving clean closure. Executive timing health KPI — values below target trigger schedule risk escalation."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`design_netlist`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Netlist quality and complexity KPIs tracking synthesis outcomes, timing performance, and power estimates. Used by design leads to monitor synthesis convergence and identify designs at risk of missing tapeout targets."
  source: "`vibe_semiconductors_v1`.`design`.`netlist`"
  dimensions:
    - name: "synthesis_status"
      expr: synthesis_status
      comment: "Status of the synthesis run that produced the netlist (e.g. Completed, Failed, In Progress) — pipeline health indicator."
    - name: "netlist_type"
      expr: netlist_type
      comment: "Type of netlist (e.g. RTL, Gate-Level, Post-Layout) — used to segment quality metrics by design abstraction level."
    - name: "dfm_rule_check_status"
      expr: dfm_rule_check_status
      comment: "DFM rule check status for the netlist — tracks manufacturability compliance at the netlist stage."
    - name: "timing_closure_achieved"
      expr: timing_closure_achieved
      comment: "Whether timing closure was achieved for this netlist — primary quality gate for netlist promotion to layout."
    - name: "process_node_nm"
      expr: process_node_nm
      comment: "Process node in nanometers — used to benchmark netlist metrics across technology nodes."
    - name: "synthesis_run_timestamp_month"
      expr: DATE_TRUNC('MONTH', synthesis_run_timestamp)
      comment: "Month of synthesis run — used for trend analysis of synthesis throughput and quality over time."
  measures:
    - name: "netlist_count"
      expr: COUNT(1)
      comment: "Total number of netlists generated. Baseline synthesis throughput metric."
    - name: "avg_gate_count"
      expr: AVG(CAST(gate_count AS BIGINT))
      comment: "Average gate count across netlists. Tracks design complexity — gate count growth signals scope creep and drives area/power budget reviews."
    - name: "avg_area_estimate_um2"
      expr: AVG(CAST(area_estimate_um2 AS DOUBLE))
      comment: "Average estimated area in µm² across netlists. Tracks die area consumption — area overruns trigger cost and yield risk escalation."
    - name: "avg_total_power_estimate_mw"
      expr: AVG(CAST(total_power_estimate_mw AS DOUBLE))
      comment: "Average total power estimate in milliwatts. Tracks power budget compliance — overruns require architectural power reduction measures."
    - name: "avg_dynamic_power_mw"
      expr: AVG(CAST(dynamic_power_mw AS DOUBLE))
      comment: "Average dynamic power in milliwatts. Dynamic power is the dominant power component in high-performance designs — tracks switching activity optimization."
    - name: "avg_leakage_power_uw"
      expr: AVG(CAST(leakage_power_uw AS DOUBLE))
      comment: "Average leakage power in microwatts. Critical for low-power and IoT designs — high leakage indicates need for multi-Vt cell optimization."
    - name: "avg_critical_path_delay_ps"
      expr: AVG(CAST(critical_path_delay_ps AS DOUBLE))
      comment: "Average critical path delay in picoseconds. Directly determines maximum achievable clock frequency — the primary synthesis performance KPI."
    - name: "avg_timing_slack_setup_ps"
      expr: AVG(CAST(timing_slack_setup_ps AS DOUBLE))
      comment: "Average setup timing slack in picoseconds. Positive values indicate timing margin; negative values require design changes before tapeout."
    - name: "avg_dft_scan_coverage_pct"
      expr: AVG(CAST(dft_scan_coverage_pct AS DOUBLE))
      comment: "Average DFT scan coverage percentage at netlist stage. Tracks test insertion completeness — low values increase manufacturing test escape risk."
    - name: "timing_closure_achieved_count"
      expr: COUNT(CASE WHEN timing_closure_achieved = TRUE THEN 1 END)
      comment: "Number of netlists achieving timing closure. Tracks synthesis success rate — non-closure netlists cannot proceed to physical implementation."
    - name: "timing_closure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN timing_closure_achieved = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of netlists achieving timing closure. Key synthesis quality KPI — low rates indicate systematic timing convergence problems requiring tool or flow changes."
    - name: "avg_synthesis_runtime_minutes"
      expr: AVG(CAST(synthesis_runtime_minutes AS DOUBLE))
      comment: "Average synthesis runtime in minutes. EDA compute efficiency metric — long runtimes increase design iteration cycle time and delay tapeout."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`design_physical_layout`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Physical layout implementation KPIs tracking DRC/LVS quality, area utilization, power, and timing closure. Used by layout engineers and VP Engineering to manage physical implementation quality and tapeout readiness."
  source: "`vibe_semiconductors_v1`.`design`.`physical_layout`"
  dimensions:
    - name: "layout_status"
      expr: layout_status
      comment: "Current status of the physical layout (e.g. In Progress, DRC Clean, Tapeout Ready) — primary pipeline health dimension."
    - name: "implementation_stage"
      expr: implementation_stage
      comment: "Implementation stage (e.g. Floorplan, Placement, Routing, Signoff) — tracks layout progression through the physical design flow."
    - name: "lvs_clean"
      expr: lvs_clean
      comment: "Whether the layout passed LVS cleanly — critical signoff quality gate; non-LVS-clean layouts cannot be taped out."
    - name: "em_compliant"
      expr: em_compliant
      comment: "Whether the layout meets electromigration (EM) rules — reliability compliance indicator for long-term product reliability."
    - name: "gds_file_format"
      expr: gds_file_format
      comment: "GDS file format used (e.g. GDSII, OASIS) — used for foundry submission compatibility tracking."
    - name: "tapeout_date_month"
      expr: DATE_TRUNC('MONTH', tapeout_date)
      comment: "Month of layout tapeout date — used for tapeout pipeline trend analysis."
    - name: "metal_layer_count"
      expr: metal_layer_count
      comment: "Number of metal layers in the layout — proxy for routing complexity and mask cost."
  measures:
    - name: "layout_count"
      expr: COUNT(1)
      comment: "Total number of physical layouts. Baseline implementation throughput metric."
    - name: "avg_die_area_mm2"
      expr: AVG(CAST(die_area_mm2 AS DOUBLE))
      comment: "Average die area in mm² across layouts. Primary cost driver — larger die areas increase wafer cost and reduce yield."
    - name: "avg_core_area_mm2"
      expr: AVG(CAST(core_area_mm2 AS DOUBLE))
      comment: "Average core area in mm². Tracks logic density — ratio of core to die area indicates layout efficiency."
    - name: "avg_cell_utilization_pct"
      expr: AVG(CAST(cell_utilization_pct AS DOUBLE))
      comment: "Average cell utilization percentage. Measures layout density efficiency — very high utilization (>90%) increases routing congestion and DRC risk."
    - name: "avg_dfm_score"
      expr: AVG(CAST(dfm_score AS DOUBLE))
      comment: "Average DFM score across layouts. Predicts manufacturing yield — low scores are a leading indicator of yield loss requiring layout optimization."
    - name: "avg_dft_coverage_pct"
      expr: AVG(CAST(dft_coverage_pct AS DOUBLE))
      comment: "Average DFT coverage percentage at layout stage. Tracks test insertion completeness through physical implementation."
    - name: "avg_power_consumption_mw"
      expr: AVG(CAST(power_consumption_mw AS DOUBLE))
      comment: "Average power consumption in milliwatts at layout stage. Tracks power budget compliance through physical implementation."
    - name: "avg_ir_drop_max_mv"
      expr: AVG(CAST(ir_drop_max_mv AS DOUBLE))
      comment: "Average maximum IR drop in millivolts. High IR drop causes functional failures — values exceeding PDK limits require power grid redesign."
    - name: "avg_routing_congestion_max_pct"
      expr: AVG(CAST(routing_congestion_max_pct AS DOUBLE))
      comment: "Average maximum routing congestion percentage. High congestion causes DRC violations and increases routing iterations — a key layout risk indicator."
    - name: "avg_wns_ps"
      expr: AVG(CAST(wns_ps AS DOUBLE))
      comment: "Average worst negative slack (WNS) in picoseconds at layout stage. Negative values indicate timing violations requiring ECO (Engineering Change Order) fixes."
    - name: "lvs_clean_layout_count"
      expr: COUNT(CASE WHEN lvs_clean = TRUE THEN 1 END)
      comment: "Number of layouts achieving LVS-clean status. Tracks physical verification quality — non-LVS-clean layouts block tapeout."
    - name: "lvs_clean_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN lvs_clean = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of layouts achieving LVS-clean status. Executive physical quality KPI — values below 100% indicate active tapeout blockers."
    - name: "em_compliant_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN em_compliant = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of layouts meeting EM compliance rules. Reliability quality KPI — non-compliant layouts risk field failures and product recalls."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`design_mpw_shuttle`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Multi-Project Wafer (MPW) shuttle program KPIs tracking cost efficiency, schedule adherence, and capacity utilization. Used by foundry program managers and CFO to optimize MPW participation and NRE cost sharing."
  source: "`vibe_semiconductors_v1`.`design`.`mpw_shuttle`"
  dimensions:
    - name: "shuttle_status"
      expr: shuttle_status
      comment: "Current status of the MPW shuttle (e.g. Open, Closed, In Fab, Completed) — primary pipeline health dimension."
    - name: "shuttle_type"
      expr: shuttle_type
      comment: "Type of shuttle (e.g. MPW, Full Mask, Prototype) — used to segment cost and cycle time by shuttle category."
    - name: "process_node"
      expr: process_node
      comment: "Process node for the shuttle (e.g. 5nm, 7nm) — key cost driver and technology roadmap dimension."
    - name: "lithography_technology"
      expr: lithography_technology
      comment: "Lithography technology used (e.g. EUV, DUV) — drives mask cost and foundry capacity requirements."
    - name: "chips_act_eligible"
      expr: chips_act_eligible
      comment: "Whether the shuttle is eligible for CHIPS Act funding — used to track government subsidy capture opportunities."
    - name: "scheduled_tapeout_date_month"
      expr: DATE_TRUNC('MONTH', scheduled_tapeout_date)
      comment: "Month of scheduled tapeout — used for foundry capacity planning and shuttle pipeline forecasting."
    - name: "actual_tapeout_date_month"
      expr: DATE_TRUNC('MONTH', actual_tapeout_date)
      comment: "Month of actual tapeout — used to measure schedule adherence and foundry on-time delivery performance."
    - name: "rohs_compliant"
      expr: rohs_compliant
      comment: "RoHS compliance flag for the shuttle — regulatory compliance tracking for EU market access."
  measures:
    - name: "shuttle_count"
      expr: COUNT(1)
      comment: "Total number of MPW shuttles. Baseline activity metric for foundry program management."
    - name: "total_shuttle_cost_usd"
      expr: SUM(CAST(total_shuttle_cost_usd AS DOUBLE))
      comment: "Total cost of all MPW shuttles in USD. Primary foundry spend metric — directly informs NRE budget planning and foundry contract negotiations."
    - name: "avg_shuttle_cost_usd"
      expr: AVG(CAST(total_shuttle_cost_usd AS DOUBLE))
      comment: "Average cost per MPW shuttle. Benchmarks shuttle economics across process nodes and foundries — used to evaluate cost-sharing model effectiveness."
    - name: "total_mask_set_cost_usd"
      expr: SUM(CAST(mask_set_cost_usd AS DOUBLE))
      comment: "Total mask set cost across all shuttles. Mask costs are the largest NRE component — tracks mask investment and drives MPW vs. full-mask decisions."
    - name: "avg_cost_per_mm2_usd"
      expr: AVG(CAST(cost_per_mm2_usd AS DOUBLE))
      comment: "Average cost per mm² of reticle area. Key shuttle economics metric — used to compare foundry pricing and optimize die area allocation."
    - name: "avg_total_reticle_area_mm2"
      expr: AVG(CAST(total_reticle_area_mm2 AS DOUBLE))
      comment: "Average total reticle area in mm² per shuttle. Tracks reticle utilization efficiency — underutilized reticles represent wasted NRE spend."
    - name: "chips_act_eligible_shuttle_count"
      expr: COUNT(CASE WHEN chips_act_eligible = TRUE THEN 1 END)
      comment: "Number of shuttles eligible for CHIPS Act funding. Tracks government subsidy capture — directly reduces net NRE cost for eligible programs."
    - name: "chips_act_eligible_cost_usd"
      expr: SUM(CASE WHEN chips_act_eligible = TRUE THEN CAST(total_shuttle_cost_usd AS DOUBLE) ELSE 0 END)
      comment: "Total shuttle cost for CHIPS Act eligible programs. Quantifies the subsidy opportunity — used by government affairs and finance teams to maximize funding capture."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`design_ip_core`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "IP core portfolio KPIs tracking licensing economics, qualification status, and technology coverage. Used by IP strategy leads and CFO to manage IP portfolio value, licensing revenue, and make-vs-buy decisions."
  source: "`vibe_semiconductors_v1`.`design`.`design_ip_core`"
  dimensions:
    - name: "ip_type"
      expr: ip_type
      comment: "Type of IP core (e.g. Hard IP, Soft IP, Firm IP) — used to segment portfolio by IP delivery format and licensing model."
    - name: "function_category"
      expr: function_category
      comment: "Functional category of the IP (e.g. Memory, Interface, Processor, Analog) — used for portfolio coverage analysis."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Lifecycle status of the IP core (e.g. Active, Deprecated, Under Development) — used to track portfolio health and obsolescence risk."
    - name: "qualification_status"
      expr: qualification_status
      comment: "Qualification status of the IP core — tracks silicon-proven and qualified IP available for design reuse."
    - name: "license_type"
      expr: license_type
      comment: "Licensing model (e.g. Perpetual, Subscription, Royalty) — used to analyze licensing revenue model mix."
    - name: "source_type"
      expr: source_type
      comment: "Source of the IP (e.g. Internal, Licensed, Open Source) — used for make-vs-buy analysis and IP strategy decisions."
    - name: "silicon_proven"
      expr: silicon_proven
      comment: "Whether the IP has been silicon-proven — critical quality indicator; silicon-proven IP carries lower integration risk."
    - name: "release_date_year"
      expr: DATE_TRUNC('YEAR', release_date)
      comment: "Year of IP core release — used for portfolio vintage analysis and technology refresh planning."
    - name: "rohs_compliant"
      expr: rohs_compliant
      comment: "RoHS compliance flag — regulatory compliance tracking for EU market access."
  measures:
    - name: "ip_core_count"
      expr: COUNT(1)
      comment: "Total number of IP cores in the portfolio. Baseline portfolio size metric — tracks IP library breadth."
    - name: "silicon_proven_ip_count"
      expr: COUNT(CASE WHEN silicon_proven = TRUE THEN 1 END)
      comment: "Number of silicon-proven IP cores. Tracks portfolio maturity — silicon-proven IP reduces integration risk and accelerates design schedules."
    - name: "silicon_proven_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN silicon_proven = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of IP cores that are silicon-proven. Portfolio quality KPI — low rates indicate high integration risk in the IP library."
    - name: "total_license_fee_usd"
      expr: SUM(CAST(license_fee_usd AS DOUBLE))
      comment: "Total license fees across all IP cores. Tracks IP licensing cost exposure — used by procurement and IP strategy teams to manage IP spend."
    - name: "avg_license_fee_usd"
      expr: AVG(CAST(license_fee_usd AS DOUBLE))
      comment: "Average license fee per IP core. Benchmarks IP licensing economics — used in make-vs-buy analysis for IP sourcing decisions."
    - name: "avg_royalty_rate_pct"
      expr: AVG(CAST(royalty_rate_pct AS DOUBLE))
      comment: "Average royalty rate percentage across licensed IP cores. Tracks ongoing royalty cost burden — high rates on high-volume products significantly impact product margin."
    - name: "avg_gate_count"
      expr: AVG(CAST(gate_count AS BIGINT))
      comment: "Average gate count across IP cores. Proxy for IP complexity — used to estimate integration effort and area consumption in target designs."
    - name: "avg_max_frequency_mhz"
      expr: AVG(CAST(max_frequency_mhz AS DOUBLE))
      comment: "Average maximum operating frequency in MHz. Tracks IP performance capability — used to assess whether IP meets target design frequency requirements."
    - name: "avg_scan_coverage_pct"
      expr: AVG(CAST(scan_coverage_pct AS DOUBLE))
      comment: "Average scan coverage percentage across IP cores. Tracks DFT completeness of the IP library — low values increase manufacturing test escape risk."
    - name: "mpw_eligible_ip_count"
      expr: COUNT(CASE WHEN mpw_eligible = TRUE THEN 1 END)
      comment: "Number of IP cores eligible for MPW shuttle inclusion. Tracks IP available for cost-effective silicon validation via MPW programs."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`design_change_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Design change request KPIs tracking change volume, approval cycle time, cost impact, and risk distribution. Used by program managers and VP Engineering to manage design change governance and schedule risk."
  source: "`vibe_semiconductors_v1`.`design`.`change_request`"
  dimensions:
    - name: "change_request_status"
      expr: change_request_status
      comment: "Current status of the change request (e.g. Open, Approved, Rejected, Implemented) — primary pipeline health dimension."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval decision status — used to track change governance compliance and approval cycle efficiency."
    - name: "change_type"
      expr: change_type
      comment: "Type of design change (e.g. ECO, Waiver, Deviation) — used to segment change volume by change category."
    - name: "change_category"
      expr: change_category
      comment: "Business category of the change (e.g. Functional, Timing, DRC, Power) — used to identify systemic design issues driving change volume."
    - name: "priority"
      expr: priority
      comment: "Priority level of the change request (e.g. Critical, High, Medium, Low) — used to track high-priority change backlog."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level associated with the change (e.g. High, Medium, Low) — used to assess change-driven schedule and quality risk."
    - name: "severity"
      expr: severity
      comment: "Severity of the issue driving the change — used to prioritize change resolution and assess design stability."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Whether the change has compliance implications — used to track regulatory and export control change exposure."
    - name: "request_timestamp_month"
      expr: DATE_TRUNC('MONTH', request_timestamp)
      comment: "Month the change request was submitted — used for change volume trend analysis and design stability tracking."
    - name: "planned_implementation_date_month"
      expr: DATE_TRUNC('MONTH', planned_implementation_date)
      comment: "Month of planned implementation — used for change pipeline forecasting and schedule impact analysis."
  measures:
    - name: "change_request_count"
      expr: COUNT(1)
      comment: "Total number of design change requests. Baseline design stability metric — high volumes indicate design instability and schedule risk."
    - name: "approved_change_count"
      expr: COUNT(CASE WHEN approval_status = 'Approved' THEN 1 END)
      comment: "Number of approved change requests. Tracks change governance throughput — backlog of unapproved changes blocks implementation."
    - name: "change_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN approval_status = 'Approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of change requests approved. Governance efficiency KPI — low rates indicate approval bottlenecks delaying design progress."
    - name: "high_risk_change_count"
      expr: COUNT(CASE WHEN risk_level = 'High' THEN 1 END)
      comment: "Number of high-risk change requests. Executive risk indicator — high counts require VP Engineering review and schedule contingency planning."
    - name: "compliance_flagged_change_count"
      expr: COUNT(CASE WHEN compliance_flag = TRUE THEN 1 END)
      comment: "Number of change requests with compliance implications. Tracks regulatory and export control change exposure — requires legal and compliance review."
    - name: "total_cost_estimate_usd"
      expr: SUM(CAST(cost_estimate AS DOUBLE))
      comment: "Total estimated cost of all change requests. Quantifies the financial impact of design changes — used by CFO to assess NRE budget adequacy."
    - name: "total_cost_actual_usd"
      expr: SUM(CAST(cost_actual AS DOUBLE))
      comment: "Total actual cost incurred by change requests. Compared against estimates to identify cost overruns requiring budget reallocation."
    - name: "cost_overrun_usd"
      expr: SUM(CAST(cost_actual AS DOUBLE) - CAST(cost_estimate AS DOUBLE))
      comment: "Total cost overrun (actual minus estimate) across all change requests. Negative values indicate under-spend; positive values indicate budget overruns requiring CFO action."
    - name: "avg_cost_estimate_usd"
      expr: AVG(CAST(cost_estimate AS DOUBLE))
      comment: "Average estimated cost per change request. Benchmarks change cost intensity — used to calibrate change management process efficiency."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`design_verification_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Verification plan KPIs tracking coverage targets, signoff status, and safety compliance. Used by verification leads and VP Engineering to manage verification completeness and tapeout readiness."
  source: "`vibe_semiconductors_v1`.`design`.`verification_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the verification plan (e.g. Draft, Active, Signoff, Closed) — primary pipeline health dimension."
    - name: "design_type"
      expr: design_type
      comment: "Design type covered by the verification plan — used to segment verification effort by design category."
    - name: "verification_methodology"
      expr: verification_methodology
      comment: "Verification methodology used (e.g. UVM, OVM, Formal) — used to analyze methodology adoption and effectiveness."
    - name: "safety_criticality_level"
      expr: safety_criticality_level
      comment: "Safety criticality level (e.g. ASIL-D, ASIL-B, QM) — used to segment verification rigor requirements for automotive designs."
    - name: "signoff_approved"
      expr: signoff_approved
      comment: "Whether the verification plan has been approved for signoff — primary tapeout readiness gate indicator."
    - name: "fault_injection_campaign_planned"
      expr: fault_injection_campaign_planned
      comment: "Whether a fault injection campaign is planned — tracks safety verification completeness for ISO 26262 compliance."
    - name: "plan_start_date_month"
      expr: DATE_TRUNC('MONTH', plan_start_date)
      comment: "Month the verification plan started — used for verification activity trend analysis."
    - name: "tapeout_target_date_month"
      expr: DATE_TRUNC('MONTH', tapeout_target_date)
      comment: "Month of tapeout target date — used to assess verification schedule alignment with tapeout milestones."
  measures:
    - name: "verification_plan_count"
      expr: COUNT(1)
      comment: "Total number of verification plans. Baseline verification program activity metric."
    - name: "signoff_approved_plan_count"
      expr: COUNT(CASE WHEN signoff_approved = TRUE THEN 1 END)
      comment: "Number of verification plans with signoff approved. Tracks tapeout readiness — all plans must be signoff-approved before tapeout authorization."
    - name: "signoff_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN signoff_approved = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of verification plans achieving signoff approval. Executive verification quality KPI — values below 100% indicate active tapeout blockers."
    - name: "avg_functional_coverage_target_pct"
      expr: AVG(CAST(functional_coverage_target_pct AS DOUBLE))
      comment: "Average functional coverage target percentage across verification plans. Tracks verification ambition level — used to benchmark coverage standards across design teams."
    - name: "avg_code_coverage_target_pct"
      expr: AVG(CAST(code_coverage_target_pct AS DOUBLE))
      comment: "Average code coverage target percentage. Tracks RTL exercise completeness targets — used to ensure consistent verification standards."
    - name: "avg_assertion_coverage_target_pct"
      expr: AVG(CAST(assertion_coverage_target_pct AS DOUBLE))
      comment: "Average assertion coverage target percentage. Tracks formal verification completeness targets — critical for safety-critical automotive designs."
    - name: "avg_fault_coverage_target_pct"
      expr: AVG(CAST(fault_coverage_target_pct AS DOUBLE))
      comment: "Average fault coverage target percentage. Tracks DFT fault simulation completeness targets — directly impacts manufacturing test quality."
    - name: "avg_safety_mechanism_coverage_target_pct"
      expr: AVG(CAST(safety_mechanism_coverage_target_pct AS DOUBLE))
      comment: "Average safety mechanism coverage target percentage. ISO 26262 compliance metric — tracks safety verification completeness for automotive ASIL designs."
    - name: "fault_injection_planned_count"
      expr: COUNT(CASE WHEN fault_injection_campaign_planned = TRUE THEN 1 END)
      comment: "Number of verification plans with fault injection campaigns planned. Tracks safety verification rigor — required for ASIL-C/D automotive designs."
$$;