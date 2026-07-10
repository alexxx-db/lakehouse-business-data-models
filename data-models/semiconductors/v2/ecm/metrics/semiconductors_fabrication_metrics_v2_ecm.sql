-- Metric views for domain: fabrication | Business: Semiconductors | Version: 2 | Generated on: 2026-07-10 11:52:05

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`fabrication_wafer_lot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core wafer lot throughput and cycle-time KPIs. Drives WIP management, on-time delivery, and fab capacity decisions at the lot level."
  source: "`vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot`"
  dimensions:
    - name: "wip_status"
      expr: wip_status
      comment: "Current WIP status of the lot (e.g. IN_PROCESS, ON_HOLD, COMPLETE) — primary operational grouping for WIP dashboards."
    - name: "lot_type"
      expr: lot_type
      comment: "Lot classification (production, engineering, qualification, pilot) — used to separate production throughput from R&D activity."
    - name: "priority_class"
      expr: priority_class
      comment: "Lot priority tier (HOT, STANDARD, etc.) — enables hot-lot tracking and escalation analysis."
    - name: "lot_disposition"
      expr: lot_disposition
      comment: "Final or current disposition of the lot (PASS, SCRAP, REWORK, HOLD) — key quality and yield dimension."
    - name: "hold_flag"
      expr: hold_flag
      comment: "Boolean indicating whether the lot is currently on hold — used to filter or segment held vs. flowing WIP."
    - name: "is_hot_lot"
      expr: is_hot_lot
      comment: "Boolean flag for expedited hot lots — used to measure hot-lot ratio and cycle-time premium."
    - name: "process_node_nm"
      expr: process_node_nm
      comment: "Technology node in nanometers (e.g. 7nm, 5nm) — critical dimension for node-level yield and throughput analysis."
    - name: "wafer_size_mm"
      expr: wafer_size_mm
      comment: "Wafer diameter in mm (200mm, 300mm) — affects capacity planning and cost-per-wafer benchmarking."
    - name: "planned_completion_month"
      expr: DATE_TRUNC('MONTH', planned_completion_date)
      comment: "Month bucket of planned lot completion — used for delivery schedule and capacity loading analysis."
    - name: "wafer_start_month"
      expr: DATE_TRUNC('MONTH', wafer_start_timestamp)
      comment: "Month bucket of wafer start — used for wafer-start trend and fab loading analysis."
  measures:
    - name: "total_wafer_lots"
      expr: COUNT(1)
      comment: "Total number of wafer lots — baseline throughput measure for fab WIP and starts tracking."
    - name: "active_wip_lots"
      expr: COUNT(CASE WHEN wip_status NOT IN ('COMPLETE','SCRAPPED','CLOSED') THEN 1 END)
      comment: "Count of lots currently in active WIP — key fab loading and capacity utilization indicator."
    - name: "on_hold_lots"
      expr: COUNT(CASE WHEN hold_flag = TRUE THEN 1 END)
      comment: "Number of lots currently on hold — elevated hold counts signal quality excursions or supply issues requiring management action."
    - name: "hot_lot_count"
      expr: COUNT(CASE WHEN is_hot_lot = TRUE THEN 1 END)
      comment: "Count of hot (expedited) lots — high hot-lot ratios indicate scheduling pressure and can inflate cycle time for standard lots."
    - name: "avg_cycle_time_days"
      expr: AVG(CAST(cycle_time_days AS DOUBLE))
      comment: "Average lot cycle time in days — primary fab efficiency KPI; increases signal process bottlenecks or capacity constraints."
    - name: "max_cycle_time_days"
      expr: MAX(cycle_time_days)
      comment: "Maximum lot cycle time in days — identifies worst-case outliers that may indicate stuck lots or systemic delays."
    - name: "avg_queue_time_hours"
      expr: AVG(CAST(queue_time_hours AS DOUBLE))
      comment: "Average queue time in hours across lots — high queue time pinpoints bottleneck tools or process steps."
    - name: "avg_process_time_hours"
      expr: AVG(CAST(process_time_hours AS DOUBLE))
      comment: "Average active process time in hours — distinguishes true processing time from queue/wait time for cycle-time decomposition."
    - name: "distinct_products_in_wip"
      expr: COUNT(DISTINCT ic_catalog_id)
      comment: "Number of distinct IC products currently in WIP — measures product mix complexity and its impact on fab scheduling."
    - name: "distinct_technology_nodes"
      expr: COUNT(DISTINCT fabrication_technology_node_id)
      comment: "Number of distinct technology nodes running concurrently — high node diversity increases changeover complexity and scheduling overhead."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`fabrication_fab_yield_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Wafer-level yield analytics — the primary KPI surface for fab quality, process excursion detection, and continuous improvement programs."
  source: "`vibe_semiconductors_v1`.`fabrication`.`fab_yield_record`"
  dimensions:
    - name: "disposition_status"
      expr: disposition_status
      comment: "Disposition outcome of the yield record (PASS, FAIL, REWORK, SCRAP) — primary quality segmentation dimension."
    - name: "excursion_severity_level"
      expr: excursion_severity_level
      comment: "Severity classification of yield excursions (CRITICAL, MAJOR, MINOR) — used to prioritize corrective action."
    - name: "yield_excursion_flag"
      expr: yield_excursion_flag
      comment: "Boolean flag indicating a yield excursion event — used to segment normal vs. excursion records."
    - name: "rework_flag"
      expr: rework_flag
      comment: "Boolean indicating the wafer was reworked — rework rate is a key cost and quality metric."
    - name: "scrap_flag"
      expr: scrap_flag
      comment: "Boolean indicating the wafer was scrapped — scrap rate directly impacts fab cost and yield."
    - name: "checkpoint_code"
      expr: checkpoint_code
      comment: "Process checkpoint at which yield was measured — enables step-level yield analysis to isolate process losses."
    - name: "measurement_month"
      expr: DATE_TRUNC('MONTH', measurement_timestamp)
      comment: "Month of yield measurement — used for yield trend analysis over time."
    - name: "technology_node"
      expr: fabrication_technology_node_id
      comment: "Technology node FK — used to compare yield performance across nodes."
    - name: "fab_facility"
      expr: fab_facility_id
      comment: "Fab facility FK — enables facility-level yield benchmarking."
  measures:
    - name: "avg_yield_percent"
      expr: AVG(CAST(yield_percentage AS DOUBLE))
      comment: "Average wafer yield percentage — the single most important fab quality KPI; directly drives die cost and profitability."
    - name: "min_yield_percent"
      expr: MIN(yield_percentage)
      comment: "Minimum yield percentage observed — identifies worst-performing lots or process steps requiring immediate intervention."
    - name: "yield_excursion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN yield_excursion_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of yield records flagged as excursions — a rising excursion rate signals process instability requiring engineering escalation."
    - name: "scrap_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN scrap_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of wafers scrapped — directly impacts fab cost of goods and is a key manufacturing efficiency KPI."
    - name: "rework_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN rework_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of wafers requiring rework — rework consumes capacity and signals process control gaps."
    - name: "avg_control_limit_range"
      expr: AVG(CAST(control_limit_upper AS DOUBLE) - CAST(control_limit_lower AS DOUBLE))
      comment: "Average SPC control limit range — a widening range indicates degrading process control capability."
    - name: "total_yield_records"
      expr: COUNT(1)
      comment: "Total yield measurement records — baseline volume measure for yield data completeness and measurement frequency tracking."
    - name: "distinct_lots_measured"
      expr: COUNT(DISTINCT fabrication_wafer_lot_id)
      comment: "Number of distinct wafer lots with yield measurements — used to assess yield measurement coverage across WIP."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`fabrication_equipment_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Equipment run performance and utilization KPIs — drives tool efficiency, process recipe adherence, and maintenance scheduling decisions."
  source: "`vibe_semiconductors_v1`.`fabrication`.`equipment_run`"
  dimensions:
    - name: "run_status"
      expr: run_status
      comment: "Status of the equipment run (COMPLETE, ABORTED, IN_PROGRESS) — used to filter productive vs. failed runs."
    - name: "process_type"
      expr: process_type
      comment: "Type of process performed (ETCH, DEPOSITION, IMPLANT, LITHO, CMP) — enables process-type-level efficiency analysis."
    - name: "abort_reason"
      expr: abort_reason
      comment: "Reason for run abort — Pareto analysis of abort reasons drives preventive maintenance and recipe improvement."
    - name: "fab_tool"
      expr: fab_tool_id
      comment: "FK to the fab tool — enables tool-level utilization and performance benchmarking."
    - name: "tool_chamber"
      expr: tool_chamber_id
      comment: "FK to the tool chamber — chamber-level analysis identifies chamber-to-chamber variation."
    - name: "run_start_month"
      expr: DATE_TRUNC('MONTH', run_start_timestamp)
      comment: "Month of run start — used for monthly throughput and utilization trend analysis."
    - name: "deposition_film_material"
      expr: deposition_film_material
      comment: "Film material deposited — used to segment deposition runs by material type for process performance analysis."
    - name: "implant_species"
      expr: implant_species
      comment: "Ion species used in implant runs — enables species-level implant performance tracking."
  measures:
    - name: "total_equipment_runs"
      expr: COUNT(1)
      comment: "Total number of equipment runs — baseline throughput measure for tool utilization and scheduling."
    - name: "avg_run_duration_seconds"
      expr: AVG(CAST(run_duration_seconds AS DOUBLE))
      comment: "Average run duration in seconds — deviations from target indicate recipe drift or tool degradation."
    - name: "total_run_duration_seconds"
      expr: SUM(CAST(run_duration_seconds AS DOUBLE))
      comment: "Total productive run time in seconds — used to calculate tool utilization against available capacity."
    - name: "abort_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN run_status = 'ABORTED' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of runs that were aborted — high abort rates signal tool reliability issues or recipe problems requiring engineering action."
    - name: "avg_actual_temperature_celsius"
      expr: AVG(CAST(actual_temperature_celsius AS DOUBLE))
      comment: "Average actual process temperature — compared against target to assess thermal process control."
    - name: "avg_temperature_deviation_celsius"
      expr: AVG(ABS(actual_temperature_celsius - target_temperature_celsius))
      comment: "Average absolute deviation between actual and target temperature — a key process control KPI; large deviations correlate with yield loss."
    - name: "avg_pressure_deviation_torr"
      expr: AVG(ABS(actual_pressure_torr - target_pressure_torr))
      comment: "Average absolute deviation between actual and target chamber pressure — pressure excursions are a leading indicator of process failures."
    - name: "avg_deposition_uniformity_percent"
      expr: AVG(CAST(deposition_uniformity_percent AS DOUBLE))
      comment: "Average film deposition uniformity percentage — uniformity directly impacts die-level electrical performance and yield."
    - name: "avg_cmp_removal_rate"
      expr: AVG(CAST(cmp_removal_rate_angstrom_per_min AS DOUBLE))
      comment: "Average CMP removal rate in Angstroms per minute — removal rate stability is critical for planarization quality and yield."
    - name: "avg_lithography_overlay_x_nm"
      expr: AVG(CAST(lithography_overlay_x_nm AS DOUBLE))
      comment: "Average lithography overlay error in X direction (nm) — overlay is a primary lithography quality KPI; errors cause shorts/opens and yield loss."
    - name: "avg_lithography_overlay_y_nm"
      expr: AVG(CAST(lithography_overlay_y_nm AS DOUBLE))
      comment: "Average lithography overlay error in Y direction (nm) — Y-axis overlay performance tracked separately for scanner alignment diagnostics."
    - name: "avg_lithography_cd_nm"
      expr: AVG(CAST(lithography_cd_measurement_nm AS DOUBLE))
      comment: "Average critical dimension (CD) measurement in nm — CD control is the most critical lithography KPI for device performance."
    - name: "distinct_tools_utilized"
      expr: COUNT(DISTINCT fab_tool_id)
      comment: "Number of distinct fab tools used — measures tool fleet utilization breadth and identifies underutilized assets."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`fabrication_lot_hold`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lot hold management KPIs — tracks hold frequency, duration, and resolution to minimize WIP disruption and improve fab flow."
  source: "`vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_hold`"
  dimensions:
    - name: "hold_status"
      expr: hold_status
      comment: "Current status of the hold (OPEN, RELEASED, EXPIRED) — primary dimension for hold queue management."
    - name: "hold_type"
      expr: hold_type
      comment: "Classification of hold type (QUALITY, ENGINEERING, CUSTOMER, COMPLIANCE) — enables root-cause categorization of holds."
    - name: "hold_reason_code"
      expr: hold_reason_code
      comment: "Specific reason code for the hold — Pareto analysis drives targeted process improvement to reduce hold frequency."
    - name: "root_cause_code"
      expr: root_cause_code
      comment: "Root cause category of the hold — used to track corrective action effectiveness over time."
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Boolean indicating the hold was escalated — escalated holds require executive visibility and faster resolution."
    - name: "customer_notification_required"
      expr: customer_notification_required
      comment: "Boolean indicating customer must be notified — customer-impacting holds are highest priority for resolution."
    - name: "defect_density_threshold_exceeded"
      expr: defect_density_threshold_exceeded
      comment: "Boolean indicating defect density exceeded threshold — links holds to specific quality excursion triggers."
    - name: "hold_placement_month"
      expr: DATE_TRUNC('MONTH', hold_placement_timestamp)
      comment: "Month the hold was placed — used for hold frequency trend analysis."
    - name: "fab_facility"
      expr: fab_facility_id
      comment: "FK to fab facility — enables facility-level hold rate benchmarking."
  measures:
    - name: "total_lot_holds"
      expr: COUNT(1)
      comment: "Total number of lot hold events — baseline measure for hold frequency; rising counts signal process instability."
    - name: "open_holds"
      expr: COUNT(CASE WHEN hold_status = 'OPEN' THEN 1 END)
      comment: "Number of currently open holds — real-time WIP disruption indicator for fab operations management."
    - name: "escalated_holds"
      expr: COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END)
      comment: "Number of escalated holds — escalations represent highest-severity WIP disruptions requiring management intervention."
    - name: "customer_impacting_holds"
      expr: COUNT(CASE WHEN customer_notification_required = TRUE THEN 1 END)
      comment: "Number of holds requiring customer notification — directly impacts customer satisfaction and delivery commitments."
    - name: "avg_hold_cycle_time_hours"
      expr: AVG(CAST(hold_cycle_time_hours AS DOUBLE))
      comment: "Average hold duration in hours — long hold cycle times inflate lot cycle time and delay delivery; key fab responsiveness KPI."
    - name: "max_hold_cycle_time_hours"
      expr: MAX(hold_cycle_time_hours)
      comment: "Maximum hold duration in hours — identifies worst-case hold events that may indicate systemic resolution bottlenecks."
    - name: "hold_escalation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of holds that were escalated — a rising escalation rate signals deteriorating first-response resolution capability."
    - name: "distinct_lots_held"
      expr: COUNT(DISTINCT primary_fabrication_wafer_lot_id)
      comment: "Number of distinct wafer lots that experienced holds — measures breadth of WIP disruption across the lot population."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`fabrication_lot_disposition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lot disposition outcome KPIs — tracks financial impact, scrap rates, and disposition cycle times to drive quality cost reduction."
  source: "`vibe_semiconductors_v1`.`fabrication`.`lot_disposition`"
  dimensions:
    - name: "disposition_type"
      expr: disposition_type
      comment: "Type of disposition action (USE_AS_IS, REWORK, SCRAP, RETURN_TO_VENDOR) — primary dimension for disposition outcome analysis."
    - name: "disposition_status"
      expr: disposition_status
      comment: "Current status of the disposition (PENDING, APPROVED, EXECUTED) — used to track disposition backlog and cycle time."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category of the defect requiring disposition — Pareto analysis drives targeted process improvement investment."
    - name: "scrap_reason_code"
      expr: scrap_reason_code
      comment: "Specific reason code for scrapped lots — enables granular scrap cost attribution by failure mode."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Boolean indicating a corrective action was required — tracks quality system response rate to disposition events."
    - name: "customer_approval_received"
      expr: customer_approval_received
      comment: "Boolean indicating customer approved the disposition — customer-approved dispositions indicate material shipped under deviation."
    - name: "disposition_date_month"
      expr: DATE_TRUNC('MONTH', disposition_date)
      comment: "Month of disposition — used for monthly scrap cost and disposition volume trend analysis."
    - name: "work_center"
      expr: work_center_id
      comment: "FK to work center where disposition occurred — enables work-center-level quality cost attribution."
  measures:
    - name: "total_dispositions"
      expr: COUNT(1)
      comment: "Total number of lot disposition events — baseline measure for quality event volume."
    - name: "total_financial_impact"
      expr: SUM(CAST(financial_impact_amount AS DOUBLE))
      comment: "Total financial impact of all dispositions in USD — the primary cost-of-quality KPI for fab management; directly impacts gross margin."
    - name: "avg_financial_impact_per_disposition"
      expr: AVG(CAST(financial_impact_amount AS DOUBLE))
      comment: "Average financial impact per disposition event — used to benchmark severity of quality events and prioritize improvement programs."
    - name: "avg_lot_yield_at_disposition"
      expr: AVG(CAST(lot_yield_percent AS DOUBLE))
      comment: "Average lot yield percentage at time of disposition — low yield at disposition indicates late-stage quality failures with high sunk cost."
    - name: "scrap_disposition_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN disposition_type = 'SCRAP' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of dispositions resulting in scrap — directly measures material loss rate and is a key fab cost efficiency KPI."
    - name: "corrective_action_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of dispositions requiring corrective action — measures quality system responsiveness and systemic defect rate."
    - name: "distinct_lots_dispositioned"
      expr: COUNT(DISTINCT fabrication_wafer_lot_id)
      comment: "Number of distinct wafer lots requiring disposition — measures breadth of quality impact across the lot population."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`fabrication_process_step`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Process step configuration and quality KPIs — tracks critical step coverage, cycle time targets, and process control plan adherence."
  source: "`vibe_semiconductors_v1`.`fabrication`.`fabrication_process_step`"
  dimensions:
    - name: "step_status"
      expr: step_status
      comment: "Approval/lifecycle status of the process step (ACTIVE, OBSOLETE, UNDER_REVIEW) — used to track process documentation currency."
    - name: "operation_type"
      expr: operation_type
      comment: "Type of operation (ETCH, DEPOSITION, IMPLANT, LITHO, CMP, ANNEAL) — enables step-type-level performance analysis."
    - name: "process_category"
      expr: process_category
      comment: "High-level process category (FEOL, MOL, BEOL) — used to segment process steps by fab area for capacity and yield analysis."
    - name: "critical_step_flag"
      expr: critical_step_flag
      comment: "Boolean indicating a critical process step — critical steps require tighter monitoring and have higher yield impact."
    - name: "inspection_required_flag"
      expr: inspection_required_flag
      comment: "Boolean indicating inspection is required at this step — used to validate inspection coverage of critical steps."
    - name: "rework_loop_indicator"
      expr: rework_loop_indicator
      comment: "Boolean indicating this step is part of a rework loop — rework loop steps consume additional capacity and cost."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the step definition — unapproved steps in production indicate process control gaps."
    - name: "equipment_group"
      expr: equipment_group_id
      comment: "FK to equipment group — enables equipment-group-level step coverage and utilization analysis."
  measures:
    - name: "total_process_steps"
      expr: COUNT(1)
      comment: "Total number of defined process steps — baseline measure for process flow complexity."
    - name: "critical_step_count"
      expr: COUNT(CASE WHEN critical_step_flag = TRUE THEN 1 END)
      comment: "Number of critical process steps — used to assess process risk profile and ensure adequate monitoring coverage."
    - name: "critical_step_ratio"
      expr: ROUND(100.0 * COUNT(CASE WHEN critical_step_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of steps classified as critical — high ratios indicate complex, high-risk process flows requiring intensive SPC coverage."
    - name: "inspection_coverage_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN inspection_required_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN critical_step_flag = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of critical steps that require inspection — gaps in inspection coverage of critical steps are a quality risk indicator."
    - name: "avg_target_cycle_time_minutes"
      expr: AVG(CAST(target_cycle_time_minutes AS DOUBLE))
      comment: "Average target cycle time per step in minutes — used to build process flow cycle time models and identify bottleneck steps."
    - name: "avg_step_cost_per_wafer"
      expr: AVG(CAST(step_cost_per_wafer AS DOUBLE))
      comment: "Average cost per wafer per process step — used for process cost modeling and identifying high-cost steps for optimization."
    - name: "total_step_cost_per_wafer"
      expr: SUM(CAST(step_cost_per_wafer AS DOUBLE))
      comment: "Sum of per-step wafer costs across all steps — approximates total process flow cost per wafer for cost-of-goods analysis."
    - name: "avg_sampling_rate_percent"
      expr: AVG(CAST(sampling_rate_percent AS DOUBLE))
      comment: "Average sampling rate across process steps — low sampling rates on critical steps increase risk of undetected excursions."
    - name: "avg_max_queue_time_minutes"
      expr: AVG(CAST(max_queue_time_minutes AS DOUBLE))
      comment: "Average maximum allowed queue time per step — used to identify steps with tight queue time constraints that create scheduling pressure."
    - name: "unapproved_active_steps"
      expr: COUNT(CASE WHEN approval_status != 'APPROVED' AND step_status = 'ACTIVE' THEN 1 END)
      comment: "Number of active steps without approved status — unapproved active steps represent a process control compliance risk."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`fabrication_process_flow`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Process flow portfolio KPIs — tracks flow qualification status, cycle time targets, and yield goals to manage technology readiness."
  source: "`vibe_semiconductors_v1`.`fabrication`.`fabrication_process_flow`"
  dimensions:
    - name: "flow_status"
      expr: flow_status
      comment: "Lifecycle status of the process flow (ACTIVE, DEVELOPMENT, OBSOLETE) — used to track technology readiness and active production flows."
    - name: "flow_type"
      expr: flow_type
      comment: "Type of process flow (STANDARD, CUSTOM, QUALIFICATION, PILOT) — enables segmentation of production vs. development flows."
    - name: "qualification_status"
      expr: qualification_status
      comment: "Qualification status of the flow (QUALIFIED, IN_PROGRESS, NOT_STARTED) — unqualified flows in production are a quality risk."
    - name: "is_customer_specific"
      expr: is_customer_specific
      comment: "Boolean indicating a customer-specific process flow — customer flows require dedicated capacity and change control."
    - name: "requires_nre"
      expr: requires_nre
      comment: "Boolean indicating NRE charges apply — used to track NRE revenue opportunities associated with new process flows."
    - name: "technology_node"
      expr: technology_node
      comment: "Technology node string for the flow — used to group flows by node generation for capacity and yield analysis."
    - name: "lithography_technology"
      expr: lithography_technology
      comment: "Lithography technology used (DUV, EUV) — critical dimension for cost and capability benchmarking."
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the flow became effective — used to track new flow introduction rate."
  measures:
    - name: "total_process_flows"
      expr: COUNT(1)
      comment: "Total number of process flows — baseline measure for process portfolio breadth."
    - name: "qualified_flows"
      expr: COUNT(CASE WHEN qualification_status = 'QUALIFIED' THEN 1 END)
      comment: "Number of fully qualified process flows — qualification coverage is a technology readiness KPI for production ramp decisions."
    - name: "qualification_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN qualification_status = 'QUALIFIED' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of process flows that are fully qualified — low qualification rates indicate technology readiness risk for production commitments."
    - name: "avg_estimated_cycle_time_days"
      expr: AVG(CAST(estimated_cycle_time_days AS DOUBLE))
      comment: "Average estimated cycle time across process flows in days — used for delivery promise and capacity planning."
    - name: "avg_target_yield_percent"
      expr: AVG(CAST(target_yield_percent AS DOUBLE))
      comment: "Average target yield percentage across process flows — used to set yield improvement goals and assess process maturity."
    - name: "customer_specific_flow_count"
      expr: COUNT(CASE WHEN is_customer_specific = TRUE THEN 1 END)
      comment: "Number of customer-specific process flows — high counts indicate customization complexity and dedicated capacity requirements."
    - name: "distinct_technology_nodes"
      expr: COUNT(DISTINCT technology_node)
      comment: "Number of distinct technology nodes covered by process flows — measures technology portfolio breadth."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`fabrication_technology_node`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Technology node portfolio KPIs — tracks node readiness, compliance status, and cost parameters to support technology roadmap decisions."
  source: "`vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node`"
  dimensions:
    - name: "qualification_status"
      expr: qualification_status
      comment: "Qualification status of the technology node (QUALIFIED, IN_QUALIFICATION, DEVELOPMENT) — primary readiness dimension for production ramp decisions."
    - name: "active_flag"
      expr: active_flag
      comment: "Boolean indicating the node is currently active — used to filter active vs. legacy or development nodes."
    - name: "transistor_architecture"
      expr: transistor_architecture
      comment: "Transistor architecture (FinFET, GAA, Planar) — used to segment nodes by device architecture for capability analysis."
    - name: "lithography_technology"
      expr: lithography_technology
      comment: "Lithography technology (DUV, EUV) — critical dimension for node cost and capability benchmarking."
    - name: "itar_controlled_flag"
      expr: itar_controlled_flag
      comment: "Boolean indicating ITAR-controlled node — ITAR nodes require export license management and restrict customer eligibility."
    - name: "rohs_compliant_flag"
      expr: rohs_compliant_flag
      comment: "Boolean indicating RoHS compliance — required for consumer electronics customers and EU market access."
    - name: "reach_compliant_flag"
      expr: reach_compliant_flag
      comment: "Boolean indicating REACH compliance — required for EU chemical regulation compliance."
    - name: "node_generation"
      expr: node_generation
      comment: "Generation label of the node (N3, N5, N7, N28) — used for generational technology roadmap analysis."
    - name: "production_readiness_month"
      expr: DATE_TRUNC('MONTH', production_readiness_date)
      comment: "Month of production readiness — used to track technology ramp timeline against roadmap commitments."
  measures:
    - name: "total_technology_nodes"
      expr: COUNT(1)
      comment: "Total number of technology nodes in the portfolio — measures technology breadth and roadmap coverage."
    - name: "qualified_nodes"
      expr: COUNT(CASE WHEN qualification_status = 'QUALIFIED' THEN 1 END)
      comment: "Number of fully qualified technology nodes — qualified node count is a key technology readiness KPI for customer commitments."
    - name: "active_nodes"
      expr: COUNT(CASE WHEN active_flag = TRUE THEN 1 END)
      comment: "Number of currently active technology nodes — active node count drives capacity planning and engineering resource allocation."
    - name: "avg_minimum_feature_size_nm"
      expr: AVG(CAST(minimum_feature_size_nm AS DOUBLE))
      comment: "Average minimum feature size in nm across nodes — tracks technology leadership position relative to industry roadmap."
    - name: "avg_mask_set_cost_usd"
      expr: AVG(CAST(mask_set_cost_usd AS DOUBLE))
      comment: "Average mask set cost in USD — mask cost is a major NRE barrier; rising costs impact customer acquisition and design win economics."
    - name: "total_nre_cost_estimate_usd"
      expr: SUM(CAST(nre_cost_estimate_usd AS DOUBLE))
      comment: "Total NRE cost estimate across all nodes in USD — represents total technology investment required to maintain the node portfolio."
    - name: "avg_target_yield_percent"
      expr: AVG(CAST(target_yield_percent AS DOUBLE))
      comment: "Average target yield percentage across technology nodes — used to assess yield maturity expectations by node generation."
    - name: "itar_controlled_node_count"
      expr: COUNT(CASE WHEN itar_controlled_flag = TRUE THEN 1 END)
      comment: "Number of ITAR-controlled technology nodes — determines export compliance burden and customer eligibility constraints."
    - name: "avg_nre_cost_estimate_usd"
      expr: AVG(CAST(nre_cost_estimate_usd AS DOUBLE))
      comment: "Average NRE cost estimate per technology node — used to benchmark node development investment and set customer NRE pricing."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`fabrication_fab_run_card`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Run card compliance and cycle-time KPIs — tracks deviation rates, hold rates, and regulatory compliance across production lots."
  source: "`vibe_semiconductors_v1`.`fabrication`.`fab_run_card`"
  dimensions:
    - name: "run_card_status"
      expr: run_card_status
      comment: "Current status of the run card (OPEN, COMPLETE, CANCELLED, ON_HOLD) — primary operational dimension for run card management."
    - name: "run_card_type"
      expr: run_card_type
      comment: "Type of run card (PRODUCTION, ENGINEERING, QUALIFICATION) — used to separate production from development activity."
    - name: "deviation_flag"
      expr: deviation_flag
      comment: "Boolean indicating a process deviation was recorded — deviation rate is a key process control KPI."
    - name: "hold_flag"
      expr: hold_flag
      comment: "Boolean indicating the run card is on hold — hold rate impacts cycle time and delivery performance."
    - name: "itar_controlled"
      expr: itar_controlled
      comment: "Boolean indicating ITAR-controlled lot — ITAR lots require export license verification before processing."
    - name: "rohs_compliant"
      expr: rohs_compliant
      comment: "Boolean indicating RoHS compliance — required for EU market shipments."
    - name: "reach_compliant"
      expr: reach_compliant
      comment: "Boolean indicating REACH compliance — required for EU chemical regulation compliance."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the run card (HOT, HIGH, STANDARD) — used to analyze priority distribution and its impact on cycle time."
    - name: "quality_grade"
      expr: quality_grade
      comment: "Quality grade assigned to the lot (A, B, C) — used to track quality grade distribution and downgrade rates."
    - name: "start_month"
      expr: DATE_TRUNC('MONTH', start_timestamp)
      comment: "Month the run card was started — used for monthly production volume and deviation trend analysis."
    - name: "fab_facility"
      expr: fab_facility_id
      comment: "FK to fab facility — enables facility-level run card performance benchmarking."
  measures:
    - name: "total_run_cards"
      expr: COUNT(1)
      comment: "Total number of run cards — baseline production volume measure."
    - name: "deviation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN deviation_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of run cards with process deviations — a rising deviation rate signals process instability and increases quality risk."
    - name: "hold_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN hold_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of run cards currently on hold — high hold rates inflate cycle time and delay customer deliveries."
    - name: "avg_cycle_time_days"
      expr: AVG(CAST(cycle_time_days AS DOUBLE))
      comment: "Average run card cycle time in days — primary delivery performance KPI; deviations from target trigger capacity and scheduling reviews."
    - name: "itar_lot_count"
      expr: COUNT(CASE WHEN itar_controlled = TRUE THEN 1 END)
      comment: "Number of ITAR-controlled run cards — used to track export compliance burden and ensure license coverage."
    - name: "rohs_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN rohs_compliant = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of run cards that are RoHS compliant — non-compliant lots cannot ship to EU customers; compliance rate is a regulatory KPI."
    - name: "distinct_products_run"
      expr: COUNT(DISTINCT ic_catalog_id)
      comment: "Number of distinct IC products processed — measures product mix complexity and its scheduling impact."
    - name: "distinct_customers_served"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of distinct customer accounts with active run cards — measures customer concentration and fab utilization breadth."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`fabrication_spc_control_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SPC control plan coverage and specification KPIs — tracks process control plan currency, specification tightness, and coverage across technology nodes."
  source: "`vibe_semiconductors_v1`.`fabrication`.`spc_control_plan`"
  dimensions:
    - name: "spc_control_plan_status"
      expr: spc_control_plan_status
      comment: "Lifecycle status of the SPC control plan (ACTIVE, SUPERSEDED, DRAFT) — active plan count drives process control coverage assessment."
    - name: "plan_type"
      expr: plan_type
      comment: "Type of SPC control plan (PROCESS, EQUIPMENT, PRODUCT) — used to segment control coverage by monitoring category."
    - name: "is_critical"
      expr: is_critical
      comment: "Boolean indicating a critical control plan — critical plans require tighter monitoring frequency and faster response."
    - name: "target_metric"
      expr: target_metric
      comment: "The process metric being controlled (CD, OVERLAY, THICKNESS, etc.) — used to assess control plan coverage by metric type."
    - name: "measurement_unit"
      expr: measurement_unit
      comment: "Unit of measurement for the controlled metric — used for dimensional analysis and cross-plan comparability."
    - name: "technology_node"
      expr: fabrication_technology_node_id
      comment: "FK to technology node — enables node-level SPC coverage analysis."
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the control plan became effective — used to track control plan refresh rate."
  measures:
    - name: "total_control_plans"
      expr: COUNT(1)
      comment: "Total number of SPC control plans — baseline measure for process control coverage breadth."
    - name: "active_control_plans"
      expr: COUNT(CASE WHEN spc_control_plan_status = 'ACTIVE' THEN 1 END)
      comment: "Number of currently active SPC control plans — active plan count is the primary process control coverage KPI."
    - name: "critical_plan_count"
      expr: COUNT(CASE WHEN is_critical = TRUE THEN 1 END)
      comment: "Number of critical SPC control plans — critical plan coverage is a quality risk management KPI."
    - name: "avg_control_limit_range"
      expr: AVG(CAST(control_limit_upper AS DOUBLE) - CAST(control_limit_lower AS DOUBLE))
      comment: "Average SPC control limit range — narrower ranges indicate tighter process control; widening ranges signal process degradation."
    - name: "avg_spec_limit_range"
      expr: AVG(CAST(upper_spec_limit AS DOUBLE) - CAST(lower_spec_limit AS DOUBLE))
      comment: "Average specification limit range — used to assess process window width relative to customer requirements."
    - name: "avg_target_value"
      expr: AVG(CAST(target_value AS DOUBLE))
      comment: "Average target value across control plans — used for process centering analysis."
    - name: "distinct_nodes_covered"
      expr: COUNT(DISTINCT fabrication_technology_node_id)
      comment: "Number of distinct technology nodes with SPC control plans — gaps in node coverage represent uncontrolled process risk."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`fabrication_mask_set`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Mask set portfolio and cost KPIs — tracks mask inventory, cost, utilization, and quality to optimize photomask asset management."
  source: "`vibe_semiconductors_v1`.`fabrication`.`mask_set`"
  dimensions:
    - name: "mask_set_status"
      expr: mask_set_status
      comment: "Lifecycle status of the mask set (ACTIVE, RETIRED, IN_INSPECTION) — used to track active mask inventory."
    - name: "mask_type"
      expr: mask_type
      comment: "Type of mask (BINARY, ATTPSM, ALTPSM, EUV) — used to segment mask cost and performance by technology type."
    - name: "mask_set_category"
      expr: mask_set_category
      comment: "Category of the mask set (PRODUCTION, QUALIFICATION, DEVELOPMENT) — used to separate production assets from R&D."
    - name: "lithography_technology"
      expr: lithography_technology
      comment: "Lithography technology the mask set is designed for (DUV, EUV) — critical for cost benchmarking."
    - name: "quality_grade"
      expr: quality_grade
      comment: "Quality grade of the mask set — used to track mask quality distribution and retirement decisions."
    - name: "inspection_result"
      expr: inspection_result
      comment: "Result of the last mask inspection (PASS, FAIL, CONDITIONAL) — failed inspections require immediate retirement or repair."
    - name: "creation_month"
      expr: DATE_TRUNC('MONTH', creation_timestamp)
      comment: "Month the mask set was created — used for mask procurement trend analysis."
  measures:
    - name: "total_mask_sets"
      expr: COUNT(1)
      comment: "Total number of mask sets in the portfolio — baseline inventory measure."
    - name: "active_mask_sets"
      expr: COUNT(CASE WHEN mask_set_status = 'ACTIVE' THEN 1 END)
      comment: "Number of currently active mask sets — active mask inventory drives production capacity and NRE cost tracking."
    - name: "total_mask_cost_usd"
      expr: SUM(CAST(mask_cost_usd AS DOUBLE))
      comment: "Total mask set cost in USD — mask costs are a major NRE component; total portfolio cost informs capital allocation decisions."
    - name: "avg_mask_cost_usd"
      expr: AVG(CAST(mask_cost_usd AS DOUBLE))
      comment: "Average mask set cost in USD — used to benchmark mask cost by technology type and track cost trends."
    - name: "avg_usage_count"
      expr: AVG(CAST(usage_count AS DOUBLE))
      comment: "Average number of times mask sets have been used — low usage on expensive masks indicates underutilized NRE investment."
    - name: "avg_mask_thickness_nm"
      expr: AVG(CAST(mask_thickness_nm AS DOUBLE))
      comment: "Average mask thickness in nm — used for process compatibility validation and quality benchmarking."
    - name: "distinct_design_projects"
      expr: COUNT(DISTINCT ic_design_project_id)
      comment: "Number of distinct IC design projects with mask sets — measures design-to-mask conversion rate and NRE pipeline."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`fabrication_wafer_start`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Wafer start authorization KPIs — tracks production release volume, cycle time estimates, and compliance status to manage fab loading."
  source: "`vibe_semiconductors_v1`.`fabrication`.`wafer_start`"
  dimensions:
    - name: "wafer_start_status"
      expr: wafer_start_status
      comment: "Status of the wafer start authorization (AUTHORIZED, PENDING, CANCELLED, ON_HOLD) — primary dimension for start queue management."
    - name: "wafer_start_type"
      expr: wafer_start_type
      comment: "Type of wafer start (PRODUCTION, ENGINEERING, QUALIFICATION, MPW) — used to separate production from development starts."
    - name: "priority_class"
      expr: priority_class
      comment: "Priority class of the wafer start (HOT, HIGH, STANDARD) — used to analyze priority distribution and capacity loading."
    - name: "itar_controlled_flag"
      expr: itar_controlled_flag
      comment: "Boolean indicating ITAR-controlled wafer start — ITAR starts require export license verification before release."
    - name: "technology_node"
      expr: technology_node
      comment: "Technology node for the wafer start — used for node-level start volume and capacity analysis."
    - name: "substrate_type"
      expr: substrate_type
      comment: "Substrate type (BULK, SOI, SiGe) — used to segment starts by substrate for material planning."
    - name: "wafer_size_mm"
      expr: wafer_size_mm
      comment: "Wafer diameter in mm — used for capacity planning and cost-per-wafer analysis."
    - name: "wafer_start_month"
      expr: DATE_TRUNC('MONTH', wafer_start_date)
      comment: "Month of wafer start — primary time dimension for wafer start trend and fab loading analysis."
    - name: "planned_completion_month"
      expr: DATE_TRUNC('MONTH', planned_completion_date)
      comment: "Month of planned completion — used for delivery schedule and capacity loading analysis."
  measures:
    - name: "total_wafer_starts"
      expr: COUNT(1)
      comment: "Total number of wafer start authorizations — the primary fab loading KPI; directly drives revenue and capacity utilization."
    - name: "avg_estimated_cycle_time_days"
      expr: AVG(CAST(estimated_cycle_time_days AS DOUBLE))
      comment: "Average estimated cycle time for wafer starts in days — used for delivery promise and WIP planning."
    - name: "itar_start_count"
      expr: COUNT(CASE WHEN itar_controlled_flag = TRUE THEN 1 END)
      comment: "Number of ITAR-controlled wafer starts — used to track export compliance burden and ensure license coverage."
    - name: "itar_start_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN itar_controlled_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of wafer starts that are ITAR-controlled — high ITAR rates increase compliance overhead and restrict customer eligibility."
    - name: "distinct_products_started"
      expr: COUNT(DISTINCT ic_catalog_id)
      comment: "Number of distinct IC products started — measures product mix in the fab loading plan."
    - name: "distinct_customers_with_starts"
      expr: COUNT(DISTINCT sales_order_id)
      comment: "Number of distinct sales orders driving wafer starts — measures customer demand breadth and order-to-start conversion."
    - name: "avg_resistivity_ohm_cm"
      expr: AVG(CAST(resistivity_ohm_cm AS DOUBLE))
      comment: "Average substrate resistivity in ohm-cm — used to validate substrate specification compliance across starts."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`fabrication_fab_facility`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fab facility capacity, sustainability, and operational KPIs — drives capital investment, environmental compliance, and capacity planning decisions."
  source: "`vibe_semiconductors_v1`.`fabrication`.`fab_facility`"
  dimensions:
    - name: "operational_status"
      expr: operational_status
      comment: "Operational status of the facility (OPERATIONAL, RAMP, SHUTDOWN, MAINTENANCE) — primary dimension for capacity availability analysis."
    - name: "facility_type"
      expr: facility_type
      comment: "Type of facility (LOGIC, MEMORY, ANALOG, MIXED) — used to segment capacity by technology type."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Lifecycle stage of the facility (ACTIVE, EOL, PLANNED) — used for long-range capacity planning and investment decisions."
    - name: "cleanroom_class"
      expr: cleanroom_class
      comment: "ISO cleanroom classification — used to assess facility capability for advanced node production."
    - name: "lithography_type"
      expr: lithography_type
      comment: "Primary lithography technology at the facility (DUV, EUV) — determines technology node capability and capital investment profile."
    - name: "country_code"
      expr: country_code
      comment: "Country where the facility is located — used for geopolitical risk analysis and supply chain diversification planning."
    - name: "restricted_access"
      expr: restricted_access
      comment: "Boolean indicating restricted access facility — used for security and compliance reporting."
  measures:
    - name: "total_facilities"
      expr: COUNT(1)
      comment: "Total number of fab facilities — baseline measure for global manufacturing footprint."
    - name: "total_capacity_wafers_per_month"
      expr: SUM(CAST(capacity_wafer_per_month AS DOUBLE))
      comment: "Total installed wafer capacity per month across all facilities — primary capacity planning KPI for executive capacity reviews."
    - name: "avg_capacity_wafers_per_month"
      expr: AVG(CAST(capacity_wafer_per_month AS DOUBLE))
      comment: "Average wafer capacity per month per facility — used to benchmark facility scale and identify capacity expansion opportunities."
    - name: "total_energy_consumption_mwh"
      expr: SUM(CAST(energy_consumption_mwh AS DOUBLE))
      comment: "Total energy consumption in MWh across all facilities — key sustainability KPI for ESG reporting and carbon reduction programs."
    - name: "total_carbon_footprint_kgco2e"
      expr: SUM(CAST(carbon_footprint_kgco2e AS DOUBLE))
      comment: "Total carbon footprint in kg CO2 equivalent — primary ESG KPI; rising carbon footprint triggers sustainability investment decisions."
    - name: "total_water_usage_m3"
      expr: SUM(CAST(water_usage_m3 AS DOUBLE))
      comment: "Total water usage in cubic meters — water is a critical and scarce resource in semiconductor manufacturing; tracked for ESG and operational risk."
    - name: "total_waste_generated_tons"
      expr: SUM(CAST(waste_generated_tons AS DOUBLE))
      comment: "Total waste generated in tons — environmental compliance KPI; high waste generation triggers regulatory scrutiny and disposal costs."
    - name: "total_fab_area_sqft"
      expr: SUM(CAST(fab_area_sqft AS DOUBLE))
      comment: "Total fab floor area in square feet — used for capacity density analysis and facility expansion planning."
    - name: "avg_energy_per_sqft"
      expr: ROUND(SUM(CAST(energy_consumption_mwh AS DOUBLE)) / NULLIF(SUM(CAST(fab_area_sqft AS DOUBLE)), 0), 4)
      comment: "Average energy consumption per square foot of fab area — energy intensity KPI for sustainability benchmarking and efficiency improvement."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`fabrication_lot_move`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lot move throughput and process parameter KPIs — tracks WIP flow velocity, rework rates, and process parameter adherence at the move level."
  source: "`vibe_semiconductors_v1`.`fabrication`.`lot_move`"
  dimensions:
    - name: "move_status"
      expr: move_status
      comment: "Status of the lot move (COMPLETE, IN_PROGRESS, ABORTED) — used to filter productive vs. failed moves."
    - name: "process_layer"
      expr: process_layer
      comment: "Process layer being processed (FEOL, MOL, BEOL) — enables layer-level throughput and cycle time analysis."
    - name: "process_module"
      expr: process_module
      comment: "Process module (LITHO, ETCH, DEP, IMP, CMP) — used for module-level throughput and bottleneck analysis."
    - name: "rework_flag"
      expr: rework_flag
      comment: "Boolean indicating this move was a rework operation — rework moves consume capacity without advancing the lot."
    - name: "sampling_flag"
      expr: sampling_flag
      comment: "Boolean indicating this move included sampling — used to track sampling plan adherence."
    - name: "priority_code"
      expr: priority_code
      comment: "Priority code of the lot move — used to analyze priority distribution and its impact on queue times."
    - name: "technology_node"
      expr: technology_node
      comment: "Technology node of the lot being moved — used for node-level throughput analysis."
    - name: "move_in_month"
      expr: DATE_TRUNC('MONTH', move_in_timestamp)
      comment: "Month of move-in — primary time dimension for throughput trend analysis."
    - name: "fab_tool"
      expr: fab_tool_id
      comment: "FK to fab tool — enables tool-level throughput and utilization analysis."
  measures:
    - name: "total_lot_moves"
      expr: COUNT(1)
      comment: "Total number of lot moves — primary fab throughput KPI; move velocity directly measures WIP flow rate."
    - name: "rework_move_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN rework_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of lot moves that are rework operations — high rework rates consume capacity and signal process control failures."
    - name: "avg_actual_temperature_c"
      expr: AVG(CAST(actual_temperature_c AS DOUBLE))
      comment: "Average actual process temperature at move level — used for process parameter trending and excursion detection."
    - name: "avg_actual_pressure_torr"
      expr: AVG(CAST(actual_pressure_torr AS DOUBLE))
      comment: "Average actual chamber pressure at move level — pressure trending identifies tool drift before yield impact occurs."
    - name: "avg_actual_power_watts"
      expr: AVG(CAST(actual_power_watts AS DOUBLE))
      comment: "Average actual process power in watts — power parameter trending is a leading indicator of tool health."
    - name: "avg_measurement_value"
      expr: AVG(CAST(measurement_value AS DOUBLE))
      comment: "Average in-line measurement value at move — used for process centering and SPC trending analysis."
    - name: "distinct_lots_moved"
      expr: COUNT(DISTINCT primary_fabrication_wafer_lot_id)
      comment: "Number of distinct wafer lots that had moves — measures WIP breadth and lot flow coverage."
    - name: "distinct_tools_used"
      expr: COUNT(DISTINCT fab_tool_id)
      comment: "Number of distinct fab tools used for moves — measures tool fleet utilization breadth."
$$;