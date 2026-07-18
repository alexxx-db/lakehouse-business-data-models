-- Metric views for domain: process | Business: Semiconductors | Version: 2 | Generated on: 2026-07-10 11:52:05

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`process_capability`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Process capability KPIs tracking Cp/Cpk/Pp/Ppk indices across technology nodes, tools, and process steps. Core steering metrics for manufacturing quality and process control."
  source: "`vibe_semiconductors_v1`.`process`.`capability`"
  dimensions:
    - name: "technology_node"
      expr: fabrication_technology_node_id
      comment: "Technology node FK for grouping capability by node generation (e.g., 5nm, 7nm)."
    - name: "fab_tool"
      expr: fab_tool_id
      comment: "Fab tool FK for identifying which tool the capability measurement was taken on."
    - name: "process_step"
      expr: fabrication_process_step_id
      comment: "Fabrication process step FK for pinpointing which step is under capability analysis."
    - name: "capability_status"
      expr: capability_status
      comment: "Current status of the capability study (e.g., In Control, Out of Control, Under Review)."
    - name: "assessment_method"
      expr: assessment_method
      comment: "Method used for capability assessment (e.g., SPC, DOE, Gauge R&R)."
    - name: "control_chart_type"
      expr: control_chart_type
      comment: "Type of control chart used (e.g., Xbar-R, EWMA, CUSUM)."
    - name: "process_area"
      expr: process_area
      comment: "Fab process area (e.g., Litho, Etch, CMP, Implant) for area-level capability rollup."
    - name: "process_layer"
      expr: process_layer
      comment: "Specific process layer being measured for capability (e.g., Metal 1, Gate)."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Flag indicating whether a corrective action has been triggered by this capability result."
    - name: "evaluation_period_start"
      expr: DATE_TRUNC('month', evaluation_period_start_date)
      comment: "Month bucket of the capability evaluation period start for trend analysis."
    - name: "ic_catalog"
      expr: ic_catalog_id
      comment: "Product IC catalog FK for product-level capability segmentation."
  measures:
    - name: "avg_cpk_index"
      expr: AVG(CAST(cpk_index AS DOUBLE))
      comment: "Average Cpk index across all capability studies. Primary process capability KPI — values below 1.33 trigger engineering intervention."
    - name: "avg_cp_index"
      expr: AVG(CAST(cp_index AS DOUBLE))
      comment: "Average Cp index measuring process spread relative to specification width. Indicates potential capability independent of centering."
    - name: "avg_ppk_index"
      expr: AVG(CAST(ppk_index AS DOUBLE))
      comment: "Average Ppk index for overall process performance including long-term variation. Used for customer qualification reporting."
    - name: "avg_pp_index"
      expr: AVG(CAST(pp_index AS DOUBLE))
      comment: "Average Pp index for overall process spread performance. Compared against Cp to assess long-term vs short-term variation."
    - name: "min_cpk_index"
      expr: MIN(cpk_index)
      comment: "Minimum Cpk observed — identifies worst-performing process/tool combination requiring immediate attention."
    - name: "pct_studies_below_cpk_133"
      expr: ROUND(100.0 * SUM(CASE WHEN cpk_index < 1.33 THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of capability studies with Cpk below 1.33 (industry minimum for production). Drives process improvement prioritization."
    - name: "pct_corrective_action_required"
      expr: ROUND(100.0 * SUM(CASE WHEN corrective_action_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of capability studies requiring corrective action. Tracks process health and engineering workload."
    - name: "avg_standard_deviation"
      expr: AVG(CAST(standard_deviation AS DOUBLE))
      comment: "Average process standard deviation across capability studies. Monitors process variability trends over time."
    - name: "avg_mean_value"
      expr: AVG(CAST(mean_value AS DOUBLE))
      comment: "Average measured mean value across capability studies. Used to detect systematic process drift."
    - name: "capability_study_count"
      expr: COUNT(1)
      comment: "Total number of capability studies conducted. Baseline volume metric for capability program coverage."
$$;


CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`process_excursion`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Process excursion KPIs tracking out-of-control events, financial impact, yield loss, and resolution performance. Critical for fab operations steering and risk management."
  source: "`vibe_semiconductors_v1`.`process`.`excursion`"
  dimensions:
    - name: "technology_node"
      expr: fabrication_technology_node_id
      comment: "Technology node FK for excursion frequency analysis by node generation."
    - name: "fab_tool"
      expr: fab_tool_id
      comment: "Fab tool FK for identifying which tools are generating the most excursions."
    - name: "process_step"
      expr: fabrication_process_step_id
      comment: "Fabrication process step FK for pinpointing high-excursion process steps."
    - name: "excursion_type"
      expr: excursion_type
      comment: "Type of excursion (e.g., SPC violation, spec out, equipment alarm) for classification."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the excursion (e.g., Critical, Major, Minor) for prioritization."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category (e.g., Equipment, Process, Material, Human) for systemic improvement."
    - name: "investigation_status"
      expr: investigation_status
      comment: "Current investigation status (e.g., Open, In Progress, Closed) for workload management."
    - name: "yield_loss_mode"
      expr: yield_loss_mode
      comment: "Mode of yield loss associated with the excursion (e.g., Defect, Parametric, Electrical)."
    - name: "customer_notification_required"
      expr: customer_notification_required
      comment: "Flag indicating whether the excursion requires customer notification — drives compliance tracking."
    - name: "detection_month"
      expr: DATE_TRUNC('month', detection_timestamp)
      comment: "Month of excursion detection for trend analysis and rate tracking."
    - name: "ic_catalog"
      expr: ic_catalog_id
      comment: "Product IC catalog FK for product-level excursion impact analysis."
  measures:
    - name: "total_excursions"
      expr: COUNT(1)
      comment: "Total number of process excursions. Primary volume KPI for fab process health monitoring."
    - name: "total_estimated_financial_impact_usd"
      expr: SUM(CAST(estimated_financial_impact_usd AS DOUBLE))
      comment: "Total estimated financial impact of all excursions in USD. Directly informs cost-of-poor-quality reporting and investment in prevention."
    - name: "avg_estimated_financial_impact_usd"
      expr: AVG(CAST(estimated_financial_impact_usd AS DOUBLE))
      comment: "Average financial impact per excursion. Used to prioritize high-cost excursion types for root cause investment."
    - name: "avg_estimated_yield_impact_pct"
      expr: AVG(CAST(estimated_yield_impact_percent AS DOUBLE))
      comment: "Average yield impact percentage per excursion. Directly links process excursions to wafer yield loss."
    - name: "total_estimated_yield_impact_pct"
      expr: SUM(CAST(estimated_yield_impact_percent AS DOUBLE))
      comment: "Cumulative yield impact percentage across all excursions. Aggregated yield loss signal for fab operations review."
    - name: "avg_defect_density_per_cm2"
      expr: AVG(CAST(defect_density_per_cm2 AS DOUBLE))
      comment: "Average defect density per cm² associated with excursions. Key process quality indicator for lithography and etch steps."
    - name: "pct_requiring_customer_notification"
      expr: ROUND(100.0 * SUM(CASE WHEN customer_notification_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of excursions requiring customer notification. Tracks customer-impacting quality events for account management."
    - name: "pct_critical_severity"
      expr: ROUND(100.0 * SUM(CASE WHEN severity_level = 'Critical' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of excursions classified as Critical severity. Drives escalation and resource allocation decisions."
    - name: "avg_resolution_time_minutes"
      expr: AVG(CAST(UNIX_TIMESTAMP(disposition_timestamp) - UNIX_TIMESTAMP(detection_timestamp) AS DOUBLE) / 60.0)
      comment: "Average time from excursion detection to disposition in minutes. Measures fab responsiveness and OCAP effectiveness."
    - name: "open_excursion_count"
      expr: SUM(CASE WHEN investigation_status != 'Closed' THEN 1 ELSE 0 END)
      comment: "Count of excursions not yet closed. Tracks open risk exposure and engineering backlog."
$$;


CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`process_spc_measurement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Statistical Process Control measurement KPIs tracking out-of-control rates, sigma levels, and specification compliance. Core real-time process monitoring metrics for fab operations."
  source: "`vibe_semiconductors_v1`.`process`.`spc_measurement`"
  dimensions:
    - name: "technology_node"
      expr: fabrication_technology_node_id
      comment: "Technology node FK for SPC performance segmentation by node generation."
    - name: "fab_tool"
      expr: fab_tool_id
      comment: "Fab tool FK for tool-level SPC performance monitoring."
    - name: "process_step"
      expr: fabrication_process_step_id
      comment: "Fabrication process step FK for step-level SPC compliance tracking."
    - name: "parameter_name"
      expr: parameter_name
      comment: "Name of the SPC-monitored parameter (e.g., CD, thickness, overlay) for parameter-level analysis."
    - name: "measurement_type"
      expr: measurement_type
      comment: "Type of measurement (e.g., inline, offline, final) for measurement program coverage analysis."
    - name: "measurement_status"
      expr: measurement_status
      comment: "Status of the measurement record (e.g., Valid, Suspect, Rejected) for data quality filtering."
    - name: "out_of_control_flag"
      expr: out_of_control_flag
      comment: "Boolean flag indicating SPC rule violation — primary filter for excursion analysis."
    - name: "out_of_spec_flag"
      expr: out_of_spec_flag
      comment: "Boolean flag indicating measurement outside specification limits — drives lot disposition decisions."
    - name: "measurement_month"
      expr: DATE_TRUNC('month', measurement_timestamp)
      comment: "Month bucket of measurement for SPC trend analysis over time."
    - name: "ic_catalog"
      expr: ic_catalog_id
      comment: "Product IC catalog FK for product-level SPC compliance segmentation."
    - name: "wafer"
      expr: wafer_id
      comment: "Wafer FK for wafer-level SPC traceability."
  measures:
    - name: "total_measurements"
      expr: COUNT(1)
      comment: "Total SPC measurements taken. Baseline volume metric for SPC program coverage and sampling rate compliance."
    - name: "out_of_control_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN out_of_control_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of measurements triggering SPC rule violations. Primary process stability KPI — rising rate signals process drift."
    - name: "out_of_spec_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN out_of_spec_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of measurements outside specification limits. Directly correlates to yield loss and customer quality risk."
    - name: "avg_sigma_level"
      expr: AVG(CAST(sigma_level AS DOUBLE))
      comment: "Average sigma level across all SPC measurements. Tracks process quality level — target is 6-sigma for advanced nodes."
    - name: "min_sigma_level"
      expr: MIN(sigma_level)
      comment: "Minimum sigma level observed — identifies worst-performing parameter/tool combinations."
    - name: "avg_deviation_from_target"
      expr: AVG(CAST(deviation_from_target AS DOUBLE))
      comment: "Average deviation from target value across measurements. Detects systematic process bias requiring recipe adjustment."
    - name: "avg_measured_value"
      expr: AVG(CAST(measured_value AS DOUBLE))
      comment: "Average measured value across SPC measurements. Used to monitor process centering relative to target."
    - name: "distinct_parameters_monitored"
      expr: COUNT(DISTINCT parameter_code)
      comment: "Number of distinct parameters under SPC monitoring. Tracks SPC program breadth and coverage completeness."
    - name: "distinct_tools_monitored"
      expr: COUNT(DISTINCT fab_tool_id)
      comment: "Number of distinct fab tools with active SPC measurements. Measures SPC program coverage across the tool fleet."
$$;


CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`process_yield_loss_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Yield loss event KPIs tracking defect density, yield impact, financial cost, and resolution performance. Directly drives fab yield improvement programs and cost reduction initiatives."
  source: "`vibe_semiconductors_v1`.`process`.`yield_loss_event`"
  dimensions:
    - name: "technology_node"
      expr: fabrication_technology_node_id
      comment: "Technology node FK for yield loss analysis by node generation — critical for node ramp decisions."
    - name: "fab_tool"
      expr: fab_tool_id
      comment: "Fab tool FK for tool-level yield loss attribution."
    - name: "process_step"
      expr: fabrication_process_step_id
      comment: "Fabrication process step FK for step-level yield loss root cause analysis."
    - name: "defect_type"
      expr: defect_type
      comment: "Type of defect causing yield loss (e.g., particle, scratch, pattern) for defect reduction prioritization."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category (e.g., Equipment, Process, Material) for systemic yield improvement programs."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity of the yield loss event for prioritization and escalation decisions."
    - name: "yield_loss_mode"
      expr: yield_loss_mode
      comment: "Mode of yield loss (e.g., Defect, Parametric, Electrical) for yield loss decomposition analysis."
    - name: "resolution_status"
      expr: resolution_status
      comment: "Current resolution status (e.g., Open, Resolved, Closed) for open risk tracking."
    - name: "layer_name"
      expr: layer_name
      comment: "Process layer where yield loss occurred for layer-level yield analysis."
    - name: "event_month"
      expr: DATE_TRUNC('month', event_timestamp)
      comment: "Month of yield loss event for trend analysis and yield improvement tracking."
    - name: "lot_hold_applied"
      expr: lot_hold_applied
      comment: "Flag indicating whether a lot hold was applied — tracks containment action rate."
  measures:
    - name: "total_yield_loss_events"
      expr: COUNT(1)
      comment: "Total number of yield loss events. Primary volume KPI for fab yield health monitoring."
    - name: "avg_estimated_yield_impact_pct"
      expr: AVG(CAST(estimated_yield_impact_percent AS DOUBLE))
      comment: "Average estimated yield impact percentage per event. Core yield KPI for process improvement prioritization."
    - name: "total_estimated_yield_impact_pct"
      expr: SUM(CAST(estimated_yield_impact_percent AS DOUBLE))
      comment: "Cumulative estimated yield impact across all events. Aggregated yield loss signal for fab operations steering."
    - name: "avg_defect_density_per_cm2"
      expr: AVG(CAST(defect_density_per_cm2 AS DOUBLE))
      comment: "Average defect density per cm² across yield loss events. Key process quality indicator for defect reduction programs."
    - name: "avg_defect_size_nm"
      expr: AVG(CAST(defect_size_nm AS DOUBLE))
      comment: "Average defect size in nanometers. Tracks defect size trends relative to technology node design rules."
    - name: "avg_cpk_value"
      expr: AVG(CAST(cpk_value AS DOUBLE))
      comment: "Average Cpk at time of yield loss event. Correlates process capability to yield loss frequency."
    - name: "pct_with_lot_hold"
      expr: ROUND(100.0 * SUM(CASE WHEN lot_hold_applied = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of yield loss events that triggered a lot hold. Measures containment action rate and risk management effectiveness."
    - name: "open_event_count"
      expr: SUM(CASE WHEN resolution_status != 'Closed' THEN 1 ELSE 0 END)
      comment: "Count of unresolved yield loss events. Tracks open yield risk exposure and engineering backlog."
    - name: "distinct_affected_lots"
      expr: COUNT(DISTINCT fabrication_wafer_lot_id)
      comment: "Number of distinct wafer lots affected by yield loss events. Measures breadth of yield impact across production."
$$;


CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`process_lot_process_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lot process run KPIs tracking throughput, process performance, defect density, and cycle time. Core fab operations metrics for WIP management and process efficiency."
  source: "`vibe_semiconductors_v1`.`process`.`lot_process_run`"
  dimensions:
    - name: "fab_tool"
      expr: fab_tool_id
      comment: "Fab tool FK for tool utilization and throughput analysis."
    - name: "process_step"
      expr: process_step_id
      comment: "Process step FK for step-level throughput and quality analysis."
    - name: "fabrication_process_step"
      expr: fabrication_process_step_id
      comment: "Fabrication process step FK for fab-level process run analysis."
    - name: "lot_disposition"
      expr: lot_disposition
      comment: "Disposition of the lot after process run (e.g., Pass, Hold, Scrap) for yield and quality tracking."
    - name: "control_chart_violation_flag"
      expr: control_chart_violation_flag
      comment: "Flag indicating SPC control chart rule violation during this run — drives OCAP initiation."
    - name: "process_qualification_status"
      expr: process_qualification_status
      comment: "Qualification status of the process run (e.g., Qualified, Conditional, Unqualified)."
    - name: "run_month"
      expr: DATE_TRUNC('month', actual_start_timestamp)
      comment: "Month of process run start for throughput trend analysis."
    - name: "tool_chamber"
      expr: tool_chamber_id
      comment: "Tool chamber FK for chamber-level performance analysis within multi-chamber tools."
    - name: "cost_center"
      expr: cost_center_id
      comment: "Cost center FK for financial allocation of process run costs."
    - name: "sku"
      expr: sku_id
      comment: "SKU FK for product-level process run volume analysis."
  measures:
    - name: "total_process_runs"
      expr: COUNT(1)
      comment: "Total number of lot process runs. Primary throughput volume KPI for fab operations capacity planning."
    - name: "avg_defect_density_per_cm2"
      expr: AVG(CAST(defect_density_per_cm2 AS DOUBLE))
      comment: "Average defect density per cm² across process runs. Inline quality KPI for process health monitoring."
    - name: "avg_measurement_result_value"
      expr: AVG(CAST(measurement_result_value AS DOUBLE))
      comment: "Average inline measurement result value across process runs. Tracks process centering and parameter stability."
    - name: "avg_process_temperature_c"
      expr: AVG(CAST(process_temperature_c AS DOUBLE))
      comment: "Average process temperature in Celsius across runs. Monitors thermal process stability — deviations indicate equipment issues."
    - name: "avg_process_pressure_torr"
      expr: AVG(CAST(process_pressure_torr AS DOUBLE))
      comment: "Average process pressure in Torr across runs. Monitors chamber pressure stability for etch and deposition processes."
    - name: "avg_process_power_watts"
      expr: AVG(CAST(process_power_watts AS DOUBLE))
      comment: "Average RF/process power in Watts across runs. Tracks power delivery consistency for plasma processes."
    - name: "spc_violation_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN control_chart_violation_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of process runs triggering SPC control chart violations. Real-time process stability KPI for fab operations."
    - name: "scrap_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN lot_disposition = 'Scrap' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of process runs resulting in lot scrap. Direct cost-of-poor-quality metric for fab operations."
    - name: "hold_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN lot_disposition = 'Hold' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of process runs resulting in lot hold. Tracks WIP at risk and engineering review workload."
    - name: "distinct_lots_processed"
      expr: COUNT(DISTINCT fabrication_wafer_lot_id)
      comment: "Number of distinct wafer lots processed. Measures fab throughput breadth for capacity utilization analysis."
    - name: "distinct_tools_utilized"
      expr: COUNT(DISTINCT fab_tool_id)
      comment: "Number of distinct fab tools utilized. Tracks tool fleet utilization breadth for capacity planning."
$$;


CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`process_qualification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Process qualification KPIs tracking qualification success rates, cycle time, yield, and Cpk performance. Drives technology node ramp decisions and customer qualification approvals."
  source: "`vibe_semiconductors_v1`.`process`.`process_qualification`"
  dimensions:
    - name: "technology_node"
      expr: fabrication_technology_node_id
      comment: "Technology node FK for qualification performance by node generation."
    - name: "fab_tool"
      expr: fab_tool_id
      comment: "Fab tool FK for tool-level qualification tracking."
    - name: "qualification_status"
      expr: qualification_status
      comment: "Current qualification status (e.g., Passed, Failed, In Progress) for pipeline management."
    - name: "qualification_type"
      expr: qualification_type
      comment: "Type of qualification (e.g., New Process, Tool Qual, Customer Qual) for program categorization."
    - name: "customer_approval_status"
      expr: customer_approval_status
      comment: "Customer approval status for qualifications requiring external sign-off — tracks revenue-gating milestones."
    - name: "requires_customer_approval"
      expr: requires_customer_approval
      comment: "Flag indicating customer approval is required — segments customer-facing vs internal qualifications."
    - name: "ic_catalog"
      expr: ic_catalog_id
      comment: "Product IC catalog FK for product-level qualification tracking."
    - name: "start_month"
      expr: DATE_TRUNC('month', start_date)
      comment: "Month of qualification start for pipeline trend analysis."
    - name: "account"
      expr: account_id
      comment: "Customer account FK for customer-specific qualification tracking."
    - name: "research_program"
      expr: research_program_id
      comment: "Research program FK for R&D-driven qualification tracking."
  measures:
    - name: "total_qualifications"
      expr: COUNT(1)
      comment: "Total number of process qualifications. Baseline volume KPI for qualification program activity."
    - name: "qualification_pass_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN qualification_status = 'Passed' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of qualifications that passed. Primary qualification effectiveness KPI — drives node ramp confidence."
    - name: "customer_approval_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN customer_approval_status = 'Approved' THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN requires_customer_approval = TRUE THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of customer-required qualifications receiving customer approval. Revenue-gating KPI for design win conversion."
    - name: "avg_actual_yield_pct"
      expr: AVG(CAST(actual_yield_percent AS DOUBLE))
      comment: "Average actual yield achieved during qualification. Measures qualification yield performance vs target."
    - name: "avg_target_yield_pct"
      expr: AVG(CAST(target_yield_percent AS DOUBLE))
      comment: "Average target yield for qualifications. Baseline for yield gap analysis."
    - name: "avg_actual_cpk"
      expr: AVG(CAST(actual_cpk AS DOUBLE))
      comment: "Average actual Cpk achieved during qualification. Measures process capability at qualification completion."
    - name: "avg_target_cpk"
      expr: AVG(CAST(target_cpk AS DOUBLE))
      comment: "Average target Cpk for qualifications. Baseline for capability gap analysis."
    - name: "avg_cycle_time_days"
      expr: AVG(DATEDIFF(actual_completion_date, start_date))
      comment: "Average qualification cycle time in days. Tracks time-to-qualify for node ramp and customer commitment planning."
    - name: "in_progress_count"
      expr: SUM(CASE WHEN qualification_status = 'In Progress' THEN 1 ELSE 0 END)
      comment: "Count of qualifications currently in progress. Tracks active qualification pipeline for resource planning."
    - name: "distinct_customers_qualifying"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of distinct customer accounts with active qualifications. Measures customer qualification pipeline breadth."
$$;


CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`process_defect_inspection_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Defect inspection KPIs tracking defect density, excursion rates, and inspection coverage. Core inline quality metrics for fab process control and yield management."
  source: "`vibe_semiconductors_v1`.`process`.`defect_inspection_result`"
  dimensions:
    - name: "technology_node"
      expr: fabrication_technology_node_id
      comment: "Technology node FK for defect density analysis by node generation."
    - name: "fab_tool"
      expr: fab_tool_id
      comment: "Fab tool FK for tool-level defect inspection performance."
    - name: "process_step"
      expr: process_step_id
      comment: "Process step FK for step-level defect density tracking."
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection (e.g., Brightfield, Darkfield, SEM Review) for inspection method analysis."
    - name: "inspection_mode"
      expr: inspection_mode
      comment: "Inspection mode (e.g., Full Wafer, Die, Site) for coverage analysis."
    - name: "layer_name"
      expr: layer_name
      comment: "Process layer inspected for layer-level defect density analysis."
    - name: "disposition"
      expr: disposition
      comment: "Lot/wafer disposition after inspection (e.g., Pass, Hold, Scrap) for yield impact tracking."
    - name: "excursion_detected"
      expr: excursion_detected
      comment: "Flag indicating an excursion was detected during inspection — primary quality alert signal."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Status of the inspection record (e.g., Complete, Pending Review) for workflow management."
    - name: "inspection_month"
      expr: DATE_TRUNC('month', inspection_timestamp)
      comment: "Month of inspection for defect density trend analysis."
    - name: "ic_catalog"
      expr: ic_catalog_id
      comment: "Product IC catalog FK for product-level defect inspection analysis."
  measures:
    - name: "total_inspections"
      expr: COUNT(1)
      comment: "Total number of defect inspections performed. Baseline volume KPI for inspection program coverage."
    - name: "avg_defect_density_per_cm2"
      expr: AVG(CAST(defect_density_per_cm2 AS DOUBLE))
      comment: "Average defect density per cm². Primary inline quality KPI — directly correlates to die yield."
    - name: "excursion_detection_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN excursion_detected = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections detecting an excursion. Tracks process instability frequency for fab operations."
    - name: "avg_spc_upper_control_limit"
      expr: AVG(CAST(spc_control_limit_upper AS DOUBLE))
      comment: "Average SPC upper control limit across inspections. Monitors control limit tightening over time as process matures."
    - name: "avg_inspected_area_cm2"
      expr: AVG(CAST(inspected_area_cm2 AS DOUBLE))
      comment: "Average inspected area per wafer in cm². Tracks inspection coverage completeness."
    - name: "review_required_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN review_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections requiring SEM or manual review. Tracks engineering review workload and defect severity."
    - name: "distinct_wafer_lots_inspected"
      expr: COUNT(DISTINCT fabrication_wafer_lot_id)
      comment: "Number of distinct wafer lots inspected. Measures inspection program coverage across production WIP."
    - name: "nuisance_filter_applied_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN nuisance_filter_applied = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections with nuisance filter applied. Tracks inspection recipe maturity — high rates indicate well-tuned recipes."
$$;


CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`process_ocap_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Out-of-Control Action Plan (OCAP) KPIs tracking response time, resolution effectiveness, and escalation rates. Measures fab process control responsiveness and OCAP program maturity."
  source: "`vibe_semiconductors_v1`.`process`.`ocap_action`"
  dimensions:
    - name: "technology_node"
      expr: fabrication_technology_node_id
      comment: "Technology node FK for OCAP activity analysis by node generation."
    - name: "fab_tool"
      expr: fab_tool_id
      comment: "Fab tool FK for tool-level OCAP frequency and resolution analysis."
    - name: "process_step"
      expr: fabrication_process_step_id
      comment: "Fabrication process step FK for step-level OCAP analysis."
    - name: "action_type"
      expr: action_type
      comment: "Type of OCAP action taken (e.g., Recipe Adjust, Tool PM, Lot Hold) for action effectiveness analysis."
    - name: "action_status"
      expr: action_status
      comment: "Current status of the OCAP action (e.g., Open, In Progress, Closed) for workload management."
    - name: "root_cause_classification"
      expr: root_cause_classification
      comment: "Root cause classification (e.g., Equipment, Process, Material) for systemic improvement programs."
    - name: "excursion_severity"
      expr: excursion_severity
      comment: "Severity of the excursion triggering the OCAP for prioritization analysis."
    - name: "escalation_level"
      expr: escalation_level
      comment: "Escalation level reached (e.g., L1, L2, L3) for escalation frequency analysis."
    - name: "containment_action_flag"
      expr: containment_action_flag
      comment: "Flag indicating a containment action was taken — tracks immediate risk mitigation rate."
    - name: "action_month"
      expr: DATE_TRUNC('month', action_initiated_timestamp)
      comment: "Month of OCAP action initiation for trend analysis."
    - name: "ic_catalog"
      expr: ic_catalog_id
      comment: "Product IC catalog FK for product-level OCAP impact analysis."
  measures:
    - name: "total_ocap_actions"
      expr: COUNT(1)
      comment: "Total OCAP actions initiated. Primary volume KPI for process control activity and fab stability."
    - name: "avg_response_time_minutes"
      expr: AVG(CAST(response_time_minutes AS DOUBLE))
      comment: "Average OCAP response time in minutes from detection to action initiation. Measures fab responsiveness — target typically <30 min for critical excursions."
    - name: "avg_resolution_time_minutes"
      expr: AVG(CAST(resolution_time_minutes AS DOUBLE))
      comment: "Average OCAP resolution time in minutes. Tracks OCAP closure efficiency and engineering effectiveness."
    - name: "escalation_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN escalation_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of OCAP actions requiring escalation. High rates indicate systemic process issues beyond L1 resolution."
    - name: "containment_action_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN containment_action_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of OCAP actions with containment measures applied. Tracks proactive risk mitigation rate."
    - name: "customer_notification_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN customer_notification_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of OCAP actions requiring customer notification. Tracks customer-impacting excursion frequency."
    - name: "open_ocap_count"
      expr: SUM(CASE WHEN action_status != 'Closed' THEN 1 ELSE 0 END)
      comment: "Count of open OCAP actions. Tracks unresolved process control issues and engineering backlog."
    - name: "distinct_tools_with_ocap"
      expr: COUNT(DISTINCT fab_tool_id)
      comment: "Number of distinct fab tools with OCAP actions. Identifies tools with systemic process control issues."
$$;


CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`process_flow`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Process flow KPIs tracking qualification status, cycle time, yield targets, and process complexity. Drives technology node ramp decisions and process flow portfolio management."
  source: "`vibe_semiconductors_v1`.`process`.`process_flow`"
  dimensions:
    - name: "technology_node"
      expr: process_technology_node_id
      comment: "Process technology node FK for flow analysis by node generation."
    - name: "ic_catalog"
      expr: ic_catalog_id
      comment: "Product IC catalog FK for product-level process flow analysis."
    - name: "qualification_status"
      expr: qualification_status
      comment: "Qualification status of the process flow (e.g., Qualified, In Qualification, Deprecated)."
    - name: "flow_type"
      expr: flow_type
      comment: "Type of process flow (e.g., Baseline, Experimental, Customer-Specific) for portfolio segmentation."
    - name: "is_baseline_flow"
      expr: is_baseline_flow
      comment: "Flag indicating this is the baseline production flow — segments production vs experimental flows."
    - name: "supports_multi_patterning"
      expr: supports_multi_patterning
      comment: "Flag indicating multi-patterning support — relevant for advanced node (sub-7nm) flow analysis."
    - name: "cost_center"
      expr: cost_center_id
      comment: "Cost center FK for financial allocation of process flow development costs."
    - name: "effective_start_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month of process flow effective start for flow lifecycle trend analysis."
    - name: "owner_org_unit"
      expr: org_unit_id
      comment: "Owner org unit FK for organizational accountability of process flows."
  measures:
    - name: "total_process_flows"
      expr: COUNT(1)
      comment: "Total number of process flows in the portfolio. Baseline volume KPI for process flow library management."
    - name: "qualified_flow_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN qualification_status = 'Qualified' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of process flows with qualified status. Tracks production readiness of the process flow portfolio."
    - name: "avg_target_yield_pct"
      expr: AVG(CAST(target_yield_percent AS DOUBLE))
      comment: "Average target yield percentage across process flows. Tracks yield ambition level by node and flow type."
    - name: "avg_baseline_cpk"
      expr: AVG(CAST(baseline_cpk AS DOUBLE))
      comment: "Average baseline Cpk across process flows. Measures process capability baseline for the flow portfolio."
    - name: "avg_cycle_time_days"
      expr: AVG(CAST(cycle_time_days AS DOUBLE))
      comment: "Average process flow cycle time in days. Key operational efficiency KPI for fab throughput planning."
    - name: "multi_patterning_flow_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN supports_multi_patterning = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of process flows supporting multi-patterning. Tracks advanced node technology adoption in the flow portfolio."
    - name: "distinct_technology_nodes_covered"
      expr: COUNT(DISTINCT process_technology_node_id)
      comment: "Number of distinct technology nodes covered by process flows. Measures technology portfolio breadth."
    - name: "distinct_products_covered"
      expr: COUNT(DISTINCT ic_catalog_id)
      comment: "Number of distinct IC products with dedicated process flows. Measures process flow coverage of the product portfolio."
$$;


CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`process_doe_experiment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Design of Experiments (DOE) KPIs tracking experiment completion rates, yield improvement, and Cpk gains. Measures R&D and process engineering effectiveness in driving process improvements."
  source: "`vibe_semiconductors_v1`.`process`.`doe_experiment`"
  dimensions:
    - name: "technology_node"
      expr: fabrication_technology_node_id
      comment: "Technology node FK for DOE activity analysis by node generation."
    - name: "process_step"
      expr: process_step_id
      comment: "Process step FK for step-level DOE activity tracking."
    - name: "doe_type"
      expr: doe_type
      comment: "Type of DOE (e.g., Full Factorial, Fractional Factorial, RSM) for experimental design analysis."
    - name: "experiment_status"
      expr: experiment_status
      comment: "Current status of the DOE (e.g., Planned, In Progress, Complete, Cancelled) for pipeline management."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the DOE (e.g., Approved, Pending, Rejected) for governance tracking."
    - name: "ic_catalog"
      expr: ic_catalog_id
      comment: "Product IC catalog FK for product-level DOE activity analysis."
    - name: "planned_start_month"
      expr: DATE_TRUNC('month', planned_start_date)
      comment: "Month of planned DOE start for experiment pipeline planning."
    - name: "fabrication_process_step"
      expr: fabrication_process_step_id
      comment: "Fabrication process step FK for fab-level DOE targeting analysis."
  measures:
    - name: "total_doe_experiments"
      expr: COUNT(1)
      comment: "Total number of DOE experiments. Baseline volume KPI for process engineering R&D activity."
    - name: "completion_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN experiment_status = 'Complete' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of DOE experiments completed. Measures R&D execution effectiveness and experiment pipeline throughput."
    - name: "avg_yield_impact_pct"
      expr: AVG(CAST(yield_impact_percent AS DOUBLE))
      comment: "Average yield impact percentage from DOE experiments. Measures the yield improvement value delivered by process engineering."
    - name: "total_yield_impact_pct"
      expr: SUM(CAST(yield_impact_percent AS DOUBLE))
      comment: "Cumulative yield impact from all DOE experiments. Aggregated R&D yield improvement contribution."
    - name: "avg_cpk_improvement"
      expr: AVG(CAST(post_doe_cpk AS DOUBLE) - CAST(baseline_cpk AS DOUBLE))
      comment: "Average Cpk improvement (post-DOE minus baseline) from experiments. Measures process capability gains from R&D investment."
    - name: "avg_post_doe_cpk"
      expr: AVG(CAST(post_doe_cpk AS DOUBLE))
      comment: "Average post-DOE Cpk achieved. Tracks process capability outcomes from experimental programs."
    - name: "avg_baseline_cpk"
      expr: AVG(CAST(baseline_cpk AS DOUBLE))
      comment: "Average baseline Cpk before DOE. Baseline for measuring DOE-driven capability improvement."
    - name: "avg_cycle_time_days"
      expr: AVG(DATEDIFF(actual_completion_date, actual_start_date))
      comment: "Average DOE cycle time in days from start to completion. Tracks R&D experiment execution speed."
    - name: "cancelled_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN experiment_status = 'Cancelled' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of DOE experiments cancelled. High cancellation rates indicate resource constraints or poor experiment planning."
$$;


CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`process_spc_control_chart`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SPC control chart KPIs tracking process capability indices, control limit compliance, and chart coverage. Provides the process control infrastructure view for fab operations management."
  source: "`vibe_semiconductors_v1`.`process`.`spc_control_chart`"
  dimensions:
    - name: "technology_node"
      expr: fabrication_technology_node_id
      comment: "Technology node FK for SPC chart coverage analysis by node generation."
    - name: "fab_tool"
      expr: fab_tool_id
      comment: "Fab tool FK for tool-level SPC chart coverage and performance."
    - name: "process_step"
      expr: process_step_id
      comment: "Process step FK for step-level SPC chart analysis."
    - name: "chart_type"
      expr: chart_type
      comment: "Type of SPC control chart (e.g., Xbar-R, I-MR, EWMA, CUSUM) for chart methodology analysis."
    - name: "chart_status"
      expr: chart_status
      comment: "Current status of the control chart (e.g., Active, Retired, Under Review) for chart portfolio management."
    - name: "monitored_parameter_name"
      expr: monitored_parameter_name
      comment: "Name of the parameter monitored by this chart for parameter-level analysis."
    - name: "ic_catalog"
      expr: ic_catalog_id
      comment: "Product IC catalog FK for product-level SPC chart coverage."
    - name: "chart_activation_month"
      expr: DATE_TRUNC('month', chart_activation_date)
      comment: "Month of chart activation for SPC program growth trend analysis."
  measures:
    - name: "total_active_charts"
      expr: SUM(CASE WHEN chart_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Total number of active SPC control charts. Measures SPC program coverage breadth across the fab."
    - name: "avg_process_capability_cpk"
      expr: AVG(CAST(process_capability_index_cpk AS DOUBLE))
      comment: "Average Cpk across all SPC control charts. Portfolio-level process capability KPI for fab operations review."
    - name: "avg_process_capability_cp"
      expr: AVG(CAST(process_capability_index_cp AS DOUBLE))
      comment: "Average Cp across all SPC control charts. Measures process spread capability independent of centering."
    - name: "pct_charts_below_cpk_133"
      expr: ROUND(100.0 * SUM(CASE WHEN process_capability_index_cpk < 1.33 THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN chart_status = 'Active' THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of active charts with Cpk below 1.33. Identifies parameters requiring process improvement investment."
    - name: "avg_upper_control_limit"
      expr: AVG(CAST(upper_control_limit AS DOUBLE))
      comment: "Average UCL across control charts. Monitors control limit tightening as process matures."
    - name: "avg_lower_control_limit"
      expr: AVG(CAST(lower_control_limit AS DOUBLE))
      comment: "Average LCL across control charts. Paired with UCL to assess control band width trends."
    - name: "distinct_parameters_monitored"
      expr: COUNT(DISTINCT monitored_parameter_name)
      comment: "Number of distinct parameters under SPC monitoring. Tracks SPC program parameter coverage completeness."
    - name: "distinct_tools_with_charts"
      expr: COUNT(DISTINCT fab_tool_id)
      comment: "Number of distinct fab tools with active SPC charts. Measures SPC tool fleet coverage."
$$;


CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`process_change_notification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Process Change Notification (PCN) KPIs tracking change approval rates, customer impact, and implementation cycle time. Critical for customer communication compliance and change management governance."
  source: "`vibe_semiconductors_v1`.`process`.`change_notification`"
  dimensions:
    - name: "technology_node"
      expr: fabrication_technology_node_id
      comment: "Technology node FK for PCN activity analysis by node generation."
    - name: "change_type"
      expr: change_type
      comment: "Type of process change (e.g., Material, Equipment, Process Recipe) for change classification analysis."
    - name: "change_classification"
      expr: change_classification
      comment: "Classification of change impact (e.g., Major, Minor, Administrative) for customer notification scoping."
    - name: "change_status"
      expr: change_status
      comment: "Current status of the change notification (e.g., Draft, Approved, Implemented, Cancelled)."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the PCN (e.g., Approved, Pending, Rejected) for governance tracking."
    - name: "customer_notification_required"
      expr: customer_notification_required
      comment: "Flag indicating customer notification is required — segments customer-impacting changes."
    - name: "customer_approval_required"
      expr: customer_approval_required
      comment: "Flag indicating customer approval is required before implementation — tracks revenue-gating changes."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level of the change (e.g., High, Medium, Low) for change risk portfolio management."
    - name: "notification_month"
      expr: DATE_TRUNC('month', notification_date)
      comment: "Month of PCN notification for change activity trend analysis."
    - name: "ic_catalog"
      expr: ic_catalog_id
      comment: "Product IC catalog FK for product-level PCN impact analysis."
  measures:
    - name: "total_change_notifications"
      expr: COUNT(1)
      comment: "Total number of process change notifications. Baseline volume KPI for change management activity."
    - name: "approval_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN approval_status = 'Approved' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of PCNs approved. Measures change governance effectiveness and approval pipeline health."
    - name: "customer_notification_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN customer_notification_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of changes requiring customer notification. Tracks customer communication compliance burden."
    - name: "avg_yield_impact_pct"
      expr: AVG(CAST(yield_impact_percent AS DOUBLE))
      comment: "Average yield impact percentage of process changes. Measures the yield risk/benefit profile of the change portfolio."
    - name: "avg_cycle_time_impact_hours"
      expr: AVG(CAST(cycle_time_impact_hours AS DOUBLE))
      comment: "Average cycle time impact in hours from process changes. Tracks throughput implications of the change portfolio."
    - name: "avg_implementation_cycle_days"
      expr: AVG(DATEDIFF(actual_implementation_date, notification_date))
      comment: "Average days from PCN notification to actual implementation. Measures change execution speed and process agility."
    - name: "high_risk_change_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN risk_level = 'High' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of changes classified as high risk. Tracks risk exposure in the change portfolio for management review."
    - name: "open_change_count"
      expr: SUM(CASE WHEN change_status NOT IN ('Implemented', 'Cancelled') THEN 1 ELSE 0 END)
      comment: "Count of changes not yet implemented or cancelled. Tracks open change pipeline and implementation backlog."
$$;
