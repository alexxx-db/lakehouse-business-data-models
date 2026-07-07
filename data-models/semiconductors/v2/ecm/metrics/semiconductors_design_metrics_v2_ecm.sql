-- Metric views for domain: design | Business: Semiconductors | Version: 2 | Generated on: 2026-06-28 00:14:33

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`design_change_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Design change management metrics tracking change volume, approval cycle time, cost impact, and risk assessment"
  source: "`vibe_semiconductors_v1`.`design`.`change_request`"
  dimensions:
    - name: "change_request_status"
      expr: change_request_status
      comment: "Current status of the change request (submitted, under-review, approved, rejected, implemented, closed)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status (pending, approved, rejected, conditional)"
    - name: "change_category"
      expr: change_category
      comment: "Category of change (functional, timing, power, area, testability)"
    - name: "change_type"
      expr: change_type
      comment: "Type of change (enhancement, defect-fix, optimization, compliance)"
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level of the change (low, medium, high, critical)"
    - name: "priority"
      expr: priority
      comment: "Priority of the change request (low, medium, high, urgent)"
    - name: "severity"
      expr: severity
      comment: "Severity of the issue being addressed"
    - name: "is_compliance_related"
      expr: compliance_flag
      comment: "Whether change is driven by compliance requirements"
    - name: "request_year"
      expr: YEAR(requested_date)
      comment: "Year the change request was submitted"
    - name: "request_quarter"
      expr: CONCAT('Q', QUARTER(requested_date), '-', YEAR(requested_date))
      comment: "Quarter the change request was submitted"
  measures:
    - name: "total_change_requests"
      expr: COUNT(DISTINCT change_request_id)
      comment: "Total number of design change requests"
    - name: "total_cost_estimate"
      expr: SUM(CAST(cost_estimate AS DOUBLE))
      comment: "Total estimated cost impact of all change requests"
    - name: "total_cost_actual"
      expr: SUM(CAST(cost_actual AS DOUBLE))
      comment: "Total actual cost of implemented change requests"
    - name: "avg_cost_estimate_per_change"
      expr: AVG(CAST(cost_estimate AS DOUBLE))
      comment: "Average estimated cost per change request"
    - name: "avg_cost_actual_per_change"
      expr: AVG(CAST(cost_actual AS DOUBLE))
      comment: "Average actual cost per implemented change request"
    - name: "changes_approved"
      expr: COUNT(DISTINCT CASE WHEN approval_status = 'approved' THEN change_request_id END)
      comment: "Number of change requests approved"
    - name: "changes_rejected"
      expr: COUNT(DISTINCT CASE WHEN approval_status = 'rejected' THEN change_request_id END)
      comment: "Number of change requests rejected"
    - name: "changes_high_risk"
      expr: COUNT(DISTINCT CASE WHEN risk_level = 'high' THEN change_request_id END)
      comment: "Number of high-risk change requests"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`design_ip_core`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "IP core portfolio KPIs tracking licensing economics, silicon validation status, and reuse readiness. Used by IP Strategy, Engineering, and Finance to manage IP investments and royalty revenue."
  source: "`vibe_semiconductors_v1`.`design`.`design_ip_core`"
  dimensions:
    - name: "ip_type"
      expr: ip_type
      comment: "Type of IP core (e.g. Hard IP, Soft IP, Firm IP) for portfolio segmentation."
    - name: "function_category"
      expr: function_category
      comment: "Functional category of the IP (e.g. Memory, Interface, Processor, Analog) for technology portfolio analysis."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Lifecycle status of the IP core (e.g. Active, Deprecated, Under Development) for portfolio health tracking."
    - name: "license_type"
      expr: license_type
      comment: "Licensing model (e.g. Perpetual, Subscription, Royalty-Based) for revenue model analysis."
    - name: "qualification_status"
      expr: qualification_status
      comment: "Qualification status of the IP core (e.g. Qualified, In Qualification, Not Qualified) for reuse readiness."
    - name: "silicon_proven"
      expr: silicon_proven
      comment: "Flag indicating whether the IP has been validated in silicon. Silicon-proven IP commands higher reuse confidence and licensing value."
    - name: "source_type"
      expr: source_type
      comment: "Source of the IP (e.g. Internal, Licensed, Open Source) for make-vs-buy analysis."
    - name: "release_year_month"
      expr: DATE_TRUNC('month', release_date)
      comment: "Month the IP core was released for portfolio vintage analysis."
  measures:
    - name: "total_ip_core_count"
      expr: COUNT(DISTINCT design_ip_core_id)
      comment: "Total number of IP cores in the portfolio. Tracks IP library breadth and reuse asset base."
    - name: "silicon_proven_count"
      expr: COUNT(DISTINCT CASE WHEN silicon_proven = TRUE THEN design_ip_core_id END)
      comment: "Number of silicon-proven IP cores. Silicon-proven IP reduces integration risk and accelerates design schedules."
    - name: "silicon_proven_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN silicon_proven = TRUE THEN design_ip_core_id END) / NULLIF(COUNT(DISTINCT design_ip_core_id), 0), 2)
      comment: "Percentage of IP cores that are silicon-proven. A key IP quality metric for reuse confidence and customer trust."
    - name: "total_license_fee_usd"
      expr: SUM(CAST(license_fee_usd AS DOUBLE))
      comment: "Total license fee value across all IP cores. Represents the IP portfolio's licensing revenue potential."
    - name: "avg_license_fee_usd"
      expr: AVG(CAST(license_fee_usd AS DOUBLE))
      comment: "Average license fee per IP core. Benchmarks IP pricing strategy and informs negotiation positions."
    - name: "avg_royalty_rate_pct"
      expr: AVG(CAST(royalty_rate_pct AS DOUBLE))
      comment: "Average royalty rate percentage across IP cores. Drives long-term IP revenue forecasting."
    - name: "avg_area_um2"
      expr: AVG(CAST(area_um2 AS DOUBLE))
      comment: "Average IP core area in square micrometers. Area drives die cost contribution when IP is integrated."
    - name: "avg_max_frequency_mhz"
      expr: AVG(CAST(max_frequency_mhz AS DOUBLE))
      comment: "Average maximum operating frequency in MHz. Tracks IP performance capability across the portfolio."
    - name: "avg_scan_coverage_pct"
      expr: AVG(CAST(scan_coverage_pct AS DOUBLE))
      comment: "Average scan coverage percentage across IP cores. Ensures testability standards are met for integration."
    - name: "mpw_eligible_count"
      expr: COUNT(DISTINCT CASE WHEN mpw_eligible = TRUE THEN design_ip_core_id END)
      comment: "Number of IP cores eligible for MPW shuttle inclusion. Tracks IP available for cost-shared prototyping."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`design_milestone`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Design program milestone KPIs tracking schedule adherence, gate review outcomes, and sign-off quality. Used by Program Management and VP Engineering to manage design execution against plan."
  source: "`vibe_semiconductors_v1`.`design`.`design_milestone`"
  dimensions:
    - name: "milestone_status"
      expr: milestone_status
      comment: "Current status of the milestone (e.g. Planned, In Progress, Completed, Delayed)."
    - name: "milestone_type"
      expr: milestone_type
      comment: "Type of milestone (e.g. RTL Freeze, Netlist Freeze, Tapeout, Silicon Return) for phase-level tracking."
    - name: "approval_disposition"
      expr: approval_disposition
      comment: "Gate review approval outcome (e.g. Approved, Approved with Conditions, Rejected) for quality gate analysis."
    - name: "nre_phase"
      expr: nre_phase
      comment: "NRE billing phase associated with the milestone for financial milestone tracking."
    - name: "process_node"
      expr: process_node
      comment: "Process node associated with the milestone for technology-tier analysis."
    - name: "planned_year_month"
      expr: DATE_TRUNC('month', planned_date)
      comment: "Planned completion month for milestone pipeline and schedule visibility."
    - name: "actual_year_month"
      expr: DATE_TRUNC('month', actual_date)
      comment: "Actual completion month for schedule adherence trend analysis."
  measures:
    - name: "total_milestone_count"
      expr: COUNT(DISTINCT design_milestone_id)
      comment: "Total number of design milestones. Tracks program execution breadth and gate review volume."
    - name: "milestone_schedule_slip_days"
      expr: AVG(DATEDIFF(actual_date, planned_date))
      comment: "Average days between planned and actual milestone completion. Positive values indicate schedule slippage; a primary program health KPI."
    - name: "on_time_milestone_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN actual_date <= planned_date THEN design_milestone_id END) / NULLIF(COUNT(DISTINCT CASE WHEN actual_date IS NOT NULL THEN design_milestone_id END), 0), 2)
      comment: "Percentage of milestones completed on or before planned date. A key program execution health metric for executive dashboards."
    - name: "tapeout_authorized_count"
      expr: COUNT(DISTINCT CASE WHEN tapeout_authorized = TRUE THEN design_milestone_id END)
      comment: "Number of milestones where tapeout was authorized. Tracks tapeout pipeline progression."
    - name: "gate_criteria_met_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN gate_criteria_met = TRUE THEN design_milestone_id END) / NULLIF(COUNT(DISTINCT design_milestone_id), 0), 2)
      comment: "Percentage of milestones where all gate criteria were met. Low rates indicate systemic design quality issues."
    - name: "avg_die_area_mm2"
      expr: AVG(CAST(die_area_mm2 AS DOUBLE))
      comment: "Average die area recorded at milestone. Tracks die size evolution through design phases."
    - name: "avg_power_budget_mw"
      expr: AVG(CAST(power_budget_mw AS DOUBLE))
      comment: "Average power budget at milestone. Tracks power compliance through design phases."
    - name: "avg_timing_slack_worst_ps"
      expr: AVG(CAST(timing_slack_worst_ps AS DOUBLE))
      comment: "Average worst timing slack in picoseconds at milestone. Negative values at late milestones indicate tapeout risk."
    - name: "dfm_sign_off_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN dfm_sign_off = TRUE THEN design_milestone_id END) / NULLIF(COUNT(DISTINCT design_milestone_id), 0), 2)
      comment: "Percentage of milestones with DFM sign-off completed. DFM sign-off is required for yield-optimized tapeout."
    - name: "dft_sign_off_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN dft_sign_off = TRUE THEN design_milestone_id END) / NULLIF(COUNT(DISTINCT design_milestone_id), 0), 2)
      comment: "Percentage of milestones with DFT sign-off completed. DFT sign-off ensures test coverage requirements are met."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`design_revision`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality and resource metrics for design revisions"
  source: "`vibe_semiconductors_v1`.`design`.`design_revision`"
  dimensions:
    - name: "design_stage"
      expr: design_stage
      comment: "Stage of the design (e.g., concept, detailed)"
    - name: "design_type"
      expr: design_type
      comment: "Type of design (e.g., ASIC, FPGA)"
    - name: "revision_type"
      expr: revision_type
      comment: "Classification of the revision (e.g., incremental, major)"
    - name: "created_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month the revision record was created"
  measures:
    - name: "total_power_mw"
      expr: SUM(CAST(power_mw AS DOUBLE))
      comment: "Total power (mW) across design revisions"
    - name: "average_gate_count"
      expr: AVG(CAST(gate_count AS DOUBLE))
      comment: "Average gate count per revision"
    - name: "total_area_um2"
      expr: SUM(CAST(area_um2 AS DOUBLE))
      comment: "Total silicon area (µm²) across revisions"
    - name: "critical_revision_count"
      expr: SUM(CASE WHEN is_critical THEN 1 ELSE 0 END)
      comment: "Number of revisions flagged as critical"
    - name: "count_revisions"
      expr: COUNT(1)
      comment: "Total number of design revisions"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`design_eda_tool`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "EDA tool licensing and utilization metrics tracking license costs, usage efficiency, and tool qualification status"
  source: "`vibe_semiconductors_v1`.`design`.`eda_tool`"
  dimensions:
    - name: "tool_status"
      expr: tool_status
      comment: "Current status of the EDA tool (active, deprecated, retired)"
    - name: "tool_category"
      expr: tool_category
      comment: "Category of EDA tool (synthesis, P&R, verification, simulation, signoff)"
    - name: "license_type"
      expr: license_type
      comment: "Type of license (floating, node-locked, subscription, perpetual)"
    - name: "qualification_status"
      expr: qualification_status
      comment: "Qualification status for production use (qualified, in-qualification, not-qualified)"
    - name: "vendor_name"
      expr: vendor_name
      comment: "Name of the EDA tool vendor"
    - name: "design_flow_stage"
      expr: design_flow_stage
      comment: "Design flow stage where tool is used"
    - name: "is_dft_supported"
      expr: dft_support_flag
      comment: "Whether tool supports design-for-test features"
    - name: "is_euv_supported"
      expr: euv_process_support_flag
      comment: "Whether tool supports EUV process flows"
    - name: "is_formal_verification"
      expr: formal_verification_flag
      comment: "Whether tool supports formal verification"
    - name: "license_year"
      expr: YEAR(license_start_date)
      comment: "Year the license became active"
  measures:
    - name: "total_eda_tools"
      expr: COUNT(DISTINCT eda_tool_id)
      comment: "Total number of EDA tool licenses"
    - name: "total_annual_license_cost_usd"
      expr: SUM(CAST(annual_license_cost_usd AS DOUBLE))
      comment: "Total annual licensing cost across all EDA tools"
    - name: "avg_annual_license_cost_usd"
      expr: AVG(CAST(annual_license_cost_usd AS DOUBLE))
      comment: "Average annual license cost per EDA tool"
    - name: "avg_license_utilization_pct"
      expr: AVG(CAST(license_utilization_pct AS DOUBLE))
      comment: "Average license utilization percentage across all tools"
    - name: "tools_qualified"
      expr: COUNT(DISTINCT CASE WHEN qualification_status = 'qualified' THEN eda_tool_id END)
      comment: "Number of EDA tools qualified for production use"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`design_ic_design_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core design project performance metrics tracking NRE spend, schedule adherence, and project health across IC design initiatives"
  source: "`vibe_semiconductors_v1`.`design`.`ic_design_project`"
  dimensions:
    - name: "project_status"
      expr: project_status
      comment: "Current lifecycle status of the IC design project (active, on-hold, completed, cancelled)"
    - name: "design_phase"
      expr: design_phase
      comment: "Current design phase (concept, architecture, RTL, verification, physical design, tapeout)"
    - name: "design_type"
      expr: design_type
      comment: "Type of design (ASIC, ASSP, custom, IP block)"
    - name: "process_node_nm"
      expr: process_node_nm
      comment: "Target process technology node in nanometers"
    - name: "packaging_type"
      expr: packaging_type
      comment: "Target package type for the design"
    - name: "lithography_type"
      expr: lithography_type
      comment: "Lithography technology (DUV, EUV)"
    - name: "project_start_year"
      expr: YEAR(project_start_date)
      comment: "Year the design project was initiated"
    - name: "project_start_quarter"
      expr: CONCAT('Q', QUARTER(project_start_date), '-', YEAR(project_start_date))
      comment: "Quarter and year the design project was initiated"
    - name: "tapeout_year"
      expr: YEAR(tapeout_target_date)
      comment: "Target tapeout year"
    - name: "is_dft_enabled"
      expr: dft_enabled
      comment: "Whether design-for-test features are enabled"
    - name: "is_automotive_grade"
      expr: iatf_automotive_grade
      comment: "Whether design targets automotive qualification (IATF)"
    - name: "is_rohs_compliant"
      expr: rohs_compliant
      comment: "Whether design is RoHS compliant"
  measures:
    - name: "total_design_projects"
      expr: COUNT(DISTINCT ic_design_project_id)
      comment: "Total number of unique IC design projects"
    - name: "total_nre_budget_usd"
      expr: SUM(CAST(nre_budget_usd AS DOUBLE))
      comment: "Total non-recurring engineering budget allocated across all design projects"
    - name: "total_nre_actual_spend_usd"
      expr: SUM(CAST(nre_actual_spend_usd AS DOUBLE))
      comment: "Total actual NRE spend across all design projects"
    - name: "avg_nre_budget_per_project_usd"
      expr: AVG(CAST(nre_budget_usd AS DOUBLE))
      comment: "Average NRE budget per design project"
    - name: "avg_nre_actual_spend_per_project_usd"
      expr: AVG(CAST(nre_actual_spend_usd AS DOUBLE))
      comment: "Average actual NRE spend per design project"
    - name: "avg_target_die_area_mm2"
      expr: AVG(CAST(target_die_area_mm2 AS DOUBLE))
      comment: "Average target die area across design projects"
    - name: "avg_target_power_budget_mw"
      expr: AVG(CAST(target_power_budget_mw AS DOUBLE))
      comment: "Average target power budget across design projects"
    - name: "avg_target_clock_freq_mhz"
      expr: AVG(CAST(target_clock_freq_mhz AS DOUBLE))
      comment: "Average target clock frequency across design projects"
    - name: "avg_gate_count_target_k"
      expr: AVG(CAST(gate_count_target_k AS DOUBLE))
      comment: "Average target gate count (in thousands) across design projects"
    - name: "projects_with_tapeout_actual"
      expr: COUNT(DISTINCT CASE WHEN tapeout_actual_date IS NOT NULL THEN ic_design_project_id END)
      comment: "Number of projects that have completed tapeout"
    - name: "projects_with_rtl_freeze"
      expr: COUNT(DISTINCT CASE WHEN rtl_freeze_date IS NOT NULL THEN ic_design_project_id END)
      comment: "Number of projects that have reached RTL freeze milestone"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`design_ip_core_usage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "IP core reuse and licensing metrics tracking integration costs, royalty exposure, and design reuse efficiency"
  source: "`vibe_semiconductors_v1`.`design`.`ip_core_usage`"
  dimensions:
    - name: "integration_status"
      expr: integration_status
      comment: "Status of IP core integration (planned, in-progress, integrated, verified, signed-off)"
    - name: "sign_off_status"
      expr: sign_off_status
      comment: "Sign-off status of the IP core integration"
    - name: "license_type"
      expr: license_type
      comment: "Type of IP license (perpetual, subscription, royalty-bearing)"
    - name: "verification_methodology"
      expr: verification_methodology
      comment: "Verification methodology used for IP integration"
    - name: "is_ip_reuse"
      expr: ip_reuse_flag
      comment: "Whether this is a reused IP core from prior project"
    - name: "is_dfm_compliant"
      expr: is_dfm_compliant
      comment: "Whether IP core is DFM compliant"
    - name: "is_dft_enabled"
      expr: is_dft_enabled
      comment: "Whether IP core has DFT features enabled"
    - name: "is_silicon_proven"
      expr: is_silicon_proven
      comment: "Whether IP core has been proven in silicon"
    - name: "integration_year"
      expr: YEAR(integration_start_date)
      comment: "Year IP core integration was started"
  measures:
    - name: "total_ip_core_usages"
      expr: COUNT(DISTINCT ip_core_usage_id)
      comment: "Total number of IP core integration instances"
    - name: "total_nre_cost_usd"
      expr: SUM(CAST(nre_cost_usd AS DOUBLE))
      comment: "Total non-recurring engineering cost for IP integration"
    - name: "avg_nre_cost_per_usage_usd"
      expr: AVG(CAST(nre_cost_usd AS DOUBLE))
      comment: "Average NRE cost per IP core integration"
    - name: "avg_area_consumed_um2"
      expr: AVG(CAST(area_consumed_um2 AS DOUBLE))
      comment: "Average silicon area consumed by IP cores"
    - name: "avg_power_contribution_mw"
      expr: AVG(CAST(power_contribution_mw AS DOUBLE))
      comment: "Average power contribution of IP cores"
    - name: "avg_clock_frequency_mhz"
      expr: AVG(CAST(clock_frequency_mhz AS DOUBLE))
      comment: "Average operating clock frequency of IP cores"
    - name: "avg_functional_coverage_pct"
      expr: AVG(CAST(functional_coverage_pct AS DOUBLE))
      comment: "Average functional coverage achieved for IP verification"
    - name: "avg_royalty_rate_per_unit"
      expr: AVG(CAST(royalty_rate_per_unit AS DOUBLE))
      comment: "Average royalty rate per unit for royalty-bearing IP"
    - name: "ip_cores_reused"
      expr: COUNT(DISTINCT CASE WHEN ip_reuse_flag = TRUE THEN ip_core_usage_id END)
      comment: "Number of IP core instances that are reused from prior projects"
    - name: "ip_cores_silicon_proven"
      expr: COUNT(DISTINCT CASE WHEN is_silicon_proven = TRUE THEN ip_core_usage_id END)
      comment: "Number of IP core instances that are silicon-proven"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`design_mpw_shuttle`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Multi-project wafer shuttle cost and schedule metrics tracking shared mask costs, project allocation, and foundry execution"
  source: "`vibe_semiconductors_v1`.`design`.`mpw_shuttle`"
  dimensions:
    - name: "shuttle_status"
      expr: shuttle_status
      comment: "Current status of the MPW shuttle (planning, open, closed, submitted, in-fab, completed)"
    - name: "shuttle_type"
      expr: shuttle_type
      comment: "Type of shuttle (commercial, research, university, internal)"
    - name: "process_node"
      expr: process_node
      comment: "Process technology node for the shuttle"
    - name: "lithography_technology"
      expr: lithography_technology
      comment: "Lithography technology (DUV, EUV)"
    - name: "cost_sharing_model"
      expr: cost_sharing_model
      comment: "Cost sharing model (equal split, area-based, custom)"
    - name: "is_chips_act_eligible"
      expr: chips_act_eligible
      comment: "Whether shuttle is eligible for CHIPS Act funding"
    - name: "is_rohs_compliant"
      expr: rohs_compliant
      comment: "Whether shuttle is RoHS compliant"
    - name: "tapeout_year"
      expr: YEAR(scheduled_tapeout_date)
      comment: "Scheduled tapeout year"
    - name: "tapeout_quarter"
      expr: CONCAT('Q', QUARTER(scheduled_tapeout_date), '-', YEAR(scheduled_tapeout_date))
      comment: "Scheduled tapeout quarter"
  measures:
    - name: "total_mpw_shuttles"
      expr: COUNT(DISTINCT mpw_shuttle_id)
      comment: "Total number of MPW shuttle runs"
    - name: "total_shuttle_cost_usd"
      expr: SUM(CAST(total_shuttle_cost_usd AS DOUBLE))
      comment: "Total cost across all MPW shuttles"
    - name: "total_mask_set_cost_usd"
      expr: SUM(CAST(mask_set_cost_usd AS DOUBLE))
      comment: "Total mask set costs across all shuttles"
    - name: "avg_shuttle_cost_usd"
      expr: AVG(CAST(total_shuttle_cost_usd AS DOUBLE))
      comment: "Average total cost per MPW shuttle"
    - name: "avg_mask_set_cost_usd"
      expr: AVG(CAST(mask_set_cost_usd AS DOUBLE))
      comment: "Average mask set cost per shuttle"
    - name: "avg_cost_per_mm2_usd"
      expr: AVG(CAST(cost_per_mm2_usd AS DOUBLE))
      comment: "Average cost per square millimeter of reticle area"
    - name: "avg_total_reticle_area_mm2"
      expr: AVG(CAST(total_reticle_area_mm2 AS DOUBLE))
      comment: "Average total reticle area per shuttle"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`design_netlist`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Netlist quality and synthesis KPIs tracking gate count, timing, power, and DFT coverage. Used by Design Engineering to assess synthesis quality and readiness for physical implementation."
  source: "`vibe_semiconductors_v1`.`design`.`netlist`"
  dimensions:
    - name: "netlist_type"
      expr: netlist_type
      comment: "Type of netlist (e.g. RTL, Gate-Level, Post-Layout) for stage-specific quality analysis."
    - name: "synthesis_status"
      expr: synthesis_status
      comment: "Status of the synthesis run that produced this netlist (e.g. Completed, Failed, In Progress)."
    - name: "timing_closure_achieved"
      expr: timing_closure_achieved
      comment: "Flag indicating whether timing closure was achieved for this netlist. A critical gate for physical implementation."
    - name: "dfm_rule_check_status"
      expr: dfm_rule_check_status
      comment: "DFM rule check status for the netlist (e.g. Clean, Violations, Waived)."
    - name: "process_node_nm"
      expr: process_node_nm
      comment: "Process node in nanometers for technology-tier analysis of synthesis quality."
    - name: "synthesis_year_month"
      expr: DATE_TRUNC('month', synthesis_run_timestamp)
      comment: "Month the synthesis run was executed for trend analysis."
  measures:
    - name: "total_netlist_count"
      expr: COUNT(DISTINCT netlist_id)
      comment: "Total number of netlists generated. Tracks synthesis activity volume and design iteration cadence."
    - name: "avg_gate_count"
      expr: AVG(CAST(gate_count AS DOUBLE))
      comment: "Average gate count across netlists. Gate count is a primary design complexity metric driving area and power estimates."
    - name: "avg_cell_instance_count"
      expr: AVG(CAST(cell_instance_count AS DOUBLE))
      comment: "Average cell instance count. Tracks design complexity and synthesis quality across iterations."
    - name: "avg_total_power_estimate_mw"
      expr: AVG(CAST(total_power_estimate_mw AS DOUBLE))
      comment: "Average total power estimate in milliwatts. Power estimates at netlist stage inform packaging and thermal decisions."
    - name: "avg_dynamic_power_mw"
      expr: AVG(CAST(dynamic_power_mw AS DOUBLE))
      comment: "Average dynamic power in milliwatts. Dynamic power drives thermal design and battery life for mobile products."
    - name: "avg_leakage_power_uw"
      expr: AVG(CAST(leakage_power_uw AS DOUBLE))
      comment: "Average leakage power in microwatts. Critical for low-power and IoT designs."
    - name: "avg_critical_path_delay_ps"
      expr: AVG(CAST(critical_path_delay_ps AS DOUBLE))
      comment: "Average critical path delay in picoseconds. Determines maximum achievable clock frequency and timing closure difficulty."
    - name: "avg_timing_slack_setup_ps"
      expr: AVG(CAST(timing_slack_setup_ps AS DOUBLE))
      comment: "Average setup timing slack in picoseconds. Negative values indicate timing violations requiring design changes."
    - name: "avg_dft_scan_coverage_pct"
      expr: AVG(CAST(dft_scan_coverage_pct AS DOUBLE))
      comment: "Average DFT scan coverage percentage at netlist level. Insufficient coverage at this stage is costly to fix in physical implementation."
    - name: "avg_synthesis_runtime_minutes"
      expr: AVG(CAST(synthesis_runtime_minutes AS DOUBLE))
      comment: "Average synthesis runtime in minutes. Long runtimes reduce design iteration velocity and delay tapeout schedules."
    - name: "timing_closure_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN timing_closure_achieved = TRUE THEN netlist_id END) / NULLIF(COUNT(DISTINCT netlist_id), 0), 2)
      comment: "Percentage of netlists achieving timing closure. A low rate signals systemic timing challenges requiring architectural changes."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`design_physical_layout`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Physical design quality and efficiency metrics tracking area utilization, power consumption, timing closure, and DRC/LVS cleanliness"
  source: "`vibe_semiconductors_v1`.`design`.`physical_layout`"
  dimensions:
    - name: "layout_status"
      expr: layout_status
      comment: "Current status of the physical layout (in-progress, timing-closure, signoff, released)"
    - name: "implementation_stage"
      expr: implementation_stage
      comment: "Stage of physical implementation (floorplan, placement, CTS, routing, signoff)"
    - name: "eda_tool"
      expr: eda_tool
      comment: "EDA tool used for physical design"
    - name: "is_lvs_clean"
      expr: lvs_clean
      comment: "Whether layout versus schematic check is clean"
    - name: "is_em_compliant"
      expr: em_compliant
      comment: "Whether electromigration rules are satisfied"
    - name: "layout_year"
      expr: YEAR(tapeout_date)
      comment: "Year of layout completion/tapeout"
  measures:
    - name: "total_layouts"
      expr: COUNT(DISTINCT physical_layout_id)
      comment: "Total number of physical layout versions"
    - name: "avg_die_area_mm2"
      expr: AVG(CAST(die_area_mm2 AS DOUBLE))
      comment: "Average die area across layouts"
    - name: "avg_core_area_mm2"
      expr: AVG(CAST(core_area_mm2 AS DOUBLE))
      comment: "Average core area across layouts"
    - name: "avg_cell_utilization_pct"
      expr: AVG(CAST(cell_utilization_pct AS DOUBLE))
      comment: "Average cell utilization percentage (core area efficiency)"
    - name: "avg_power_consumption_mw"
      expr: AVG(CAST(power_consumption_mw AS DOUBLE))
      comment: "Average power consumption across layouts"
    - name: "avg_leakage_power_uw"
      expr: AVG(CAST(leakage_power_uw AS DOUBLE))
      comment: "Average leakage power across layouts"
    - name: "avg_wns_ps"
      expr: AVG(CAST(wns_ps AS DOUBLE))
      comment: "Average worst negative slack in picoseconds (timing margin)"
    - name: "avg_tns_ps"
      expr: AVG(CAST(tns_ps AS DOUBLE))
      comment: "Average total negative slack in picoseconds"
    - name: "avg_ir_drop_max_mv"
      expr: AVG(CAST(ir_drop_max_mv AS DOUBLE))
      comment: "Average maximum IR drop in millivolts"
    - name: "avg_routing_congestion_max_pct"
      expr: AVG(CAST(routing_congestion_max_pct AS DOUBLE))
      comment: "Average maximum routing congestion percentage"
    - name: "avg_metal_fill_density_pct"
      expr: AVG(CAST(metal_fill_density_pct AS DOUBLE))
      comment: "Average metal fill density percentage"
    - name: "avg_dfm_score"
      expr: AVG(CAST(dfm_score AS DOUBLE))
      comment: "Average design-for-manufacturing score"
    - name: "avg_dft_coverage_pct"
      expr: AVG(CAST(dft_coverage_pct AS DOUBLE))
      comment: "Average design-for-test coverage percentage"
    - name: "layouts_lvs_clean"
      expr: COUNT(DISTINCT CASE WHEN lvs_clean = TRUE THEN physical_layout_id END)
      comment: "Number of layouts with clean LVS"
    - name: "layouts_em_compliant"
      expr: COUNT(DISTINCT CASE WHEN em_compliant = TRUE THEN physical_layout_id END)
      comment: "Number of layouts compliant with electromigration rules"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`design_simulation_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Simulation execution and coverage metrics tracking verification progress, resource consumption, and defect detection"
  source: "`vibe_semiconductors_v1`.`design`.`simulation_run`"
  dimensions:
    - name: "run_status"
      expr: run_status
      comment: "Status of the simulation run (queued, running, passed, failed, aborted)"
    - name: "run_type"
      expr: run_type
      comment: "Type of simulation (functional, timing, power, formal)"
    - name: "design_stage"
      expr: design_stage
      comment: "Design stage when simulation was run (RTL, gate-level, post-layout)"
    - name: "pass_fail_status"
      expr: pass_fail_status
      comment: "Pass/fail outcome of the simulation"
    - name: "process_corner"
      expr: process_corner
      comment: "Process corner for the simulation (TT, SS, FF, SF, FS)"
    - name: "regression_suite_name"
      expr: regression_suite_name
      comment: "Name of the regression test suite"
    - name: "is_signoff_approved"
      expr: signoff_approved
      comment: "Whether simulation results are approved for signoff"
    - name: "run_year"
      expr: YEAR(start_timestamp)
      comment: "Year the simulation run was started"
    - name: "run_month"
      expr: DATE_TRUNC('MONTH', start_timestamp)
      comment: "Month the simulation run was started"
  measures:
    - name: "total_simulation_runs"
      expr: COUNT(DISTINCT simulation_run_id)
      comment: "Total number of simulation runs executed"
    - name: "total_cpu_hours_consumed"
      expr: SUM(CAST(cpu_hours_consumed AS DOUBLE))
      comment: "Total CPU hours consumed across all simulation runs"
    - name: "avg_cpu_hours_per_run"
      expr: AVG(CAST(cpu_hours_consumed AS DOUBLE))
      comment: "Average CPU hours per simulation run"
    - name: "avg_run_duration_minutes"
      expr: AVG(CAST(run_duration_minutes AS DOUBLE))
      comment: "Average runtime duration in minutes per simulation"
    - name: "avg_peak_memory_gb"
      expr: AVG(CAST(peak_memory_gb AS DOUBLE))
      comment: "Average peak memory consumption in gigabytes per simulation"
    - name: "avg_functional_coverage_pct"
      expr: AVG(CAST(functional_coverage_pct AS DOUBLE))
      comment: "Average functional coverage percentage achieved"
    - name: "avg_code_coverage_pct"
      expr: AVG(CAST(code_coverage_pct AS DOUBLE))
      comment: "Average code coverage percentage achieved"
    - name: "avg_assertion_coverage_pct"
      expr: AVG(CAST(assertion_coverage_pct AS DOUBLE))
      comment: "Average assertion coverage percentage achieved"
    - name: "avg_toggle_coverage_pct"
      expr: AVG(CAST(toggle_coverage_pct AS DOUBLE))
      comment: "Average toggle coverage percentage achieved"
    - name: "runs_passed"
      expr: COUNT(DISTINCT CASE WHEN pass_fail_status = 'passed' THEN simulation_run_id END)
      comment: "Number of simulation runs that passed"
    - name: "runs_failed"
      expr: COUNT(DISTINCT CASE WHEN pass_fail_status = 'failed' THEN simulation_run_id END)
      comment: "Number of simulation runs that failed"
    - name: "runs_signoff_approved"
      expr: COUNT(DISTINCT CASE WHEN signoff_approved = TRUE THEN simulation_run_id END)
      comment: "Number of simulation runs approved for signoff"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`design_tapeout`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tapeout execution metrics tracking design quality, schedule performance, and mask costs for silicon fabrication readiness"
  source: "`vibe_semiconductors_v1`.`design`.`tapeout`"
  dimensions:
    - name: "tapeout_status"
      expr: tapeout_status
      comment: "Current status of the tapeout (planned, submitted, accepted, in-fab, completed)"
    - name: "tapeout_type"
      expr: tapeout_type
      comment: "Type of tapeout (production, prototype, MPW, shuttle)"
    - name: "design_type"
      expr: design_type
      comment: "Type of design being taped out"
    - name: "process_node"
      expr: process_node
      comment: "Process technology node for the tapeout"
    - name: "lithography_type"
      expr: lithography_type
      comment: "Lithography technology used (DUV, EUV)"
    - name: "packaging_type"
      expr: packaging_type
      comment: "Target package type"
    - name: "foundry_name"
      expr: foundry_name
      comment: "Name of the foundry partner"
    - name: "tapeout_year"
      expr: YEAR(tapeout_date)
      comment: "Year of tapeout submission"
    - name: "tapeout_quarter"
      expr: CONCAT('Q', QUARTER(tapeout_date), '-', YEAR(tapeout_date))
      comment: "Quarter and year of tapeout submission"
    - name: "is_drc_clean"
      expr: drc_clean
      comment: "Whether design rule check passed without violations"
    - name: "is_lvs_clean"
      expr: lvs_clean
      comment: "Whether layout versus schematic check passed"
    - name: "is_erc_clean"
      expr: erc_clean
      comment: "Whether electrical rule check passed"
    - name: "is_signoff_complete"
      expr: signoff_checklist_complete
      comment: "Whether all signoff criteria have been met"
    - name: "is_ip_signoff_complete"
      expr: ip_sign_off_complete
      comment: "Whether all IP blocks have been signed off"
  measures:
    - name: "total_tapeouts"
      expr: COUNT(DISTINCT tapeout_id)
      comment: "Total number of tapeout events"
    - name: "total_mask_cost_usd"
      expr: SUM(CAST(mask_cost_usd AS DOUBLE))
      comment: "Total mask set costs across all tapeouts"
    - name: "total_nre_cost_usd"
      expr: SUM(CAST(nre_cost_usd AS DOUBLE))
      comment: "Total non-recurring engineering costs for tapeouts"
    - name: "avg_mask_cost_per_tapeout_usd"
      expr: AVG(CAST(mask_cost_usd AS DOUBLE))
      comment: "Average mask set cost per tapeout"
    - name: "avg_nre_cost_per_tapeout_usd"
      expr: AVG(CAST(nre_cost_usd AS DOUBLE))
      comment: "Average NRE cost per tapeout"
    - name: "avg_die_size_mm2"
      expr: AVG(CAST(die_size_mm2 AS DOUBLE))
      comment: "Average die size across tapeouts"
    - name: "avg_expected_yield_pct"
      expr: AVG(CAST(expected_yield_pct AS DOUBLE))
      comment: "Average expected yield percentage across tapeouts"
    - name: "avg_dfm_score"
      expr: AVG(CAST(dfm_score AS DOUBLE))
      comment: "Average design-for-manufacturing score across tapeouts"
    - name: "avg_dft_coverage_pct"
      expr: AVG(CAST(dft_coverage_pct AS DOUBLE))
      comment: "Average design-for-test coverage percentage across tapeouts"
    - name: "tapeouts_drc_clean"
      expr: COUNT(DISTINCT CASE WHEN drc_clean = TRUE THEN tapeout_id END)
      comment: "Number of tapeouts with clean DRC"
    - name: "tapeouts_lvs_clean"
      expr: COUNT(DISTINCT CASE WHEN lvs_clean = TRUE THEN tapeout_id END)
      comment: "Number of tapeouts with clean LVS"
    - name: "tapeouts_signoff_complete"
      expr: COUNT(DISTINCT CASE WHEN signoff_checklist_complete = TRUE THEN tapeout_id END)
      comment: "Number of tapeouts with complete signoff checklist"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`design_timing_analysis_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Static timing analysis metrics tracking timing closure, slack distribution, and signoff readiness for design performance validation"
  source: "`vibe_semiconductors_v1`.`design`.`timing_analysis_run`"
  dimensions:
    - name: "run_status"
      expr: run_status
      comment: "Status of the timing analysis run (queued, running, completed, failed)"
    - name: "timing_closure_status"
      expr: timing_closure_status
      comment: "Timing closure status (met, violated, marginal)"
    - name: "analysis_mode"
      expr: analysis_mode
      comment: "Analysis mode (setup, hold, recovery, removal, multi-mode)"
    - name: "design_stage"
      expr: design_stage
      comment: "Design stage when timing analysis was run (synthesis, placement, routing, signoff)"
    - name: "pvt_corner"
      expr: pvt_corner
      comment: "Process-voltage-temperature corner (TT, SS, FF, etc.)"
    - name: "is_signoff_run"
      expr: is_signoff_run
      comment: "Whether this is a signoff-quality timing run"
    - name: "is_multi_corner_run"
      expr: is_multi_corner_run
      comment: "Whether this run covers multiple PVT corners"
    - name: "run_year"
      expr: YEAR(run_timestamp)
      comment: "Year the timing analysis run was executed"
    - name: "run_month"
      expr: DATE_TRUNC('MONTH', run_timestamp)
      comment: "Month the timing analysis run was executed"
  measures:
    - name: "total_timing_runs"
      expr: COUNT(DISTINCT timing_analysis_run_id)
      comment: "Total number of timing analysis runs executed"
    - name: "avg_worst_negative_slack_ps"
      expr: AVG(CAST(worst_negative_slack_ps AS DOUBLE))
      comment: "Average worst negative slack in picoseconds (primary timing metric)"
    - name: "avg_total_negative_slack_ps"
      expr: AVG(CAST(total_negative_slack_ps AS DOUBLE))
      comment: "Average total negative slack in picoseconds"
    - name: "avg_worst_hold_slack_ps"
      expr: AVG(CAST(worst_hold_slack_ps AS DOUBLE))
      comment: "Average worst hold slack in picoseconds"
    - name: "avg_total_hold_negative_slack_ps"
      expr: AVG(CAST(total_hold_negative_slack_ps AS DOUBLE))
      comment: "Average total hold negative slack in picoseconds"
    - name: "avg_clock_frequency_target_mhz"
      expr: AVG(CAST(clock_frequency_target_mhz AS DOUBLE))
      comment: "Average target clock frequency in MHz"
    - name: "runs_timing_closure_met"
      expr: COUNT(DISTINCT CASE WHEN timing_closure_status = 'met' THEN timing_analysis_run_id END)
      comment: "Number of timing runs that achieved timing closure"
    - name: "runs_signoff_quality"
      expr: COUNT(DISTINCT CASE WHEN is_signoff_run = TRUE THEN timing_analysis_run_id END)
      comment: "Number of signoff-quality timing runs"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`design_verification_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Verification planning and coverage metrics tracking functional, code, and fault coverage targets for design validation"
  source: "`vibe_semiconductors_v1`.`design`.`verification_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the verification plan (draft, active, completed, archived)"
    - name: "design_type"
      expr: design_type
      comment: "Type of design being verified"
    - name: "verification_methodology"
      expr: verification_methodology
      comment: "Verification methodology (UVM, OVM, VMM, custom)"
    - name: "safety_criticality_level"
      expr: safety_criticality_level
      comment: "Safety criticality level (ISO 26262 ASIL, IEC 61508 SIL)"
    - name: "target_process_node"
      expr: target_process_node
      comment: "Target process technology node"
    - name: "is_signoff_approved"
      expr: signoff_approved
      comment: "Whether verification plan has been approved for signoff"
    - name: "plan_year"
      expr: YEAR(plan_start_date)
      comment: "Year the verification plan was initiated"
  measures:
    - name: "total_verification_plans"
      expr: COUNT(DISTINCT verification_plan_id)
      comment: "Total number of verification plans"
    - name: "avg_functional_coverage_target_pct"
      expr: AVG(CAST(functional_coverage_target_pct AS DOUBLE))
      comment: "Average functional coverage target percentage"
    - name: "avg_code_coverage_target_pct"
      expr: AVG(CAST(code_coverage_target_pct AS DOUBLE))
      comment: "Average code coverage target percentage"
    - name: "avg_assertion_coverage_target_pct"
      expr: AVG(CAST(assertion_coverage_target_pct AS DOUBLE))
      comment: "Average assertion coverage target percentage"
    - name: "avg_toggle_coverage_target_pct"
      expr: AVG(CAST(toggle_coverage_target_pct AS DOUBLE))
      comment: "Average toggle coverage target percentage"
    - name: "avg_fault_coverage_target_pct"
      expr: AVG(CAST(fault_coverage_target_pct AS DOUBLE))
      comment: "Average fault coverage target percentage"
    - name: "avg_safety_mechanism_coverage_target_pct"
      expr: AVG(CAST(safety_mechanism_coverage_target_pct AS DOUBLE))
      comment: "Average safety mechanism coverage target for functional safety designs"
    - name: "plans_signoff_approved"
      expr: COUNT(DISTINCT CASE WHEN signoff_approved = TRUE THEN verification_plan_id END)
      comment: "Number of verification plans approved for signoff"
$$;
