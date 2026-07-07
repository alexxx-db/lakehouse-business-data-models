-- Metric views for domain: asset | Business: Manufacturing | Version: 2 | Generated on: 2026-07-03 05:35:52

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`asset_work_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational KPIs for asset maintenance work orders — tracks cost performance, labor efficiency, downtime impact, and schedule adherence to steer maintenance investment decisions."
  source: "`vibe_manufacturing_v1`.`asset`.`asset_work_order`"
  dimensions:
    - name: "work_order_status"
      expr: work_order_status
      comment: "Current status of the work order (e.g. Open, In Progress, Closed) for pipeline and backlog analysis."
    - name: "priority"
      expr: priority
      comment: "Work order priority level (e.g. Critical, High, Medium, Low) to assess urgency distribution."
    - name: "work_order_source"
      expr: work_order_source
      comment: "Origin of the work order (e.g. PM Schedule, Breakdown, Inspection) to understand reactive vs. proactive maintenance split."
    - name: "asset_criticality"
      expr: asset_criticality
      comment: "Criticality classification of the asset being maintained, enabling risk-weighted maintenance analysis."
    - name: "capex_opex_classification"
      expr: capex_opex_classification
      comment: "Whether the work order is classified as capital expenditure or operating expenditure for financial reporting."
    - name: "tpm_pillar"
      expr: tpm_pillar
      comment: "Total Productive Maintenance pillar (e.g. Autonomous, Planned, Quality) for TPM program tracking."
    - name: "craft_type"
      expr: craft_type
      comment: "Trade or craft type assigned to the work order (e.g. Electrical, Mechanical) for workforce planning."
    - name: "planned_start_month"
      expr: DATE_TRUNC('MONTH', planned_start_date)
      comment: "Month of planned start date for trend analysis of maintenance scheduling."
    - name: "actual_start_month"
      expr: DATE_TRUNC('MONTH', actual_start_date)
      comment: "Month of actual start date for comparing planned vs. actual maintenance execution trends."
    - name: "is_production_impacting"
      expr: is_production_impacting
      comment: "Flag indicating whether the work order caused production impact, for OEE and availability analysis."
  measures:
    - name: "total_work_orders"
      expr: COUNT(1)
      comment: "Total number of work orders — baseline volume metric for maintenance workload assessment."
    - name: "total_actual_labor_cost"
      expr: SUM(CAST(actual_labor_cost AS DOUBLE))
      comment: "Total actual labor cost across all work orders — key input to maintenance cost management and budget variance."
    - name: "total_actual_material_cost"
      expr: SUM(CAST(actual_material_cost AS DOUBLE))
      comment: "Total actual material cost across all work orders — tracks spare parts and consumables spend."
    - name: "total_maintenance_cost"
      expr: SUM(CAST(actual_labor_cost AS DOUBLE) + CAST(actual_material_cost AS DOUBLE))
      comment: "Combined labor and material cost per work order set — total maintenance spend for cost center reporting."
    - name: "avg_actual_labor_hours"
      expr: AVG(CAST(actual_labor_hours AS DOUBLE))
      comment: "Average actual labor hours per work order — measures workforce efficiency and job complexity."
    - name: "total_downtime_hours"
      expr: SUM(CAST(downtime_duration_hours AS DOUBLE))
      comment: "Total asset downtime hours caused by maintenance work orders — directly linked to production availability loss."
    - name: "avg_downtime_hours_per_wo"
      expr: AVG(CAST(downtime_duration_hours AS DOUBLE))
      comment: "Average downtime hours per work order — indicates typical disruption magnitude per maintenance event."
    - name: "labor_cost_variance"
      expr: SUM(CAST(actual_labor_cost AS DOUBLE) - CAST(planned_labor_hours AS DOUBLE))
      comment: "Aggregate variance between actual labor cost and planned labor hours (as cost proxy) — signals estimation accuracy and budget overruns."
    - name: "material_cost_variance"
      expr: SUM(CAST(actual_material_cost AS DOUBLE) - CAST(planned_material_cost AS DOUBLE))
      comment: "Aggregate variance between actual and planned material cost — identifies procurement and estimation gaps."
    - name: "total_estimated_cost_sum"
      expr: SUM(CAST(total_estimated_cost AS DOUBLE))
      comment: "Sum of total estimated costs across work orders — used for budget forecasting and approval thresholds."
    - name: "production_impacting_wo_count"
      expr: COUNT(CASE WHEN is_production_impacting = TRUE THEN 1 END)
      comment: "Count of work orders that caused production impact — key metric for OEE availability component and risk management."
    - name: "avg_planned_labor_hours"
      expr: AVG(CAST(planned_labor_hours AS DOUBLE))
      comment: "Average planned labor hours per work order — baseline for workforce capacity planning."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`asset_downtime_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Asset availability and downtime KPIs — tracks duration, frequency, cost impact, and root cause of downtime events to drive OEE improvement and reliability investment decisions."
  source: "`vibe_manufacturing_v1`.`asset`.`asset_downtime_event`"
  dimensions:
    - name: "downtime_category"
      expr: downtime_category
      comment: "High-level category of downtime (e.g. Mechanical, Electrical, Process) for Pareto analysis."
    - name: "downtime_type"
      expr: downtime_type
      comment: "Type of downtime (e.g. Planned, Unplanned, External) to distinguish controllable vs. uncontrollable losses."
    - name: "failure_class"
      expr: failure_class
      comment: "Failure classification code for root cause categorization and FMEA alignment."
    - name: "failure_code"
      expr: failure_code
      comment: "Specific failure code for granular root cause analysis and repeat failure tracking."
    - name: "root_cause_code"
      expr: root_cause_code
      comment: "Root cause code assigned to the downtime event — drives corrective action prioritization."
    - name: "maintenance_type"
      expr: maintenance_type
      comment: "Type of maintenance response (e.g. Corrective, Emergency, Preventive) triggered by the downtime event."
    - name: "event_status"
      expr: event_status
      comment: "Current status of the downtime event record (e.g. Open, Closed, Under Investigation)."
    - name: "is_safety_incident"
      expr: is_safety_incident
      comment: "Flag indicating whether the downtime event involved a safety incident — critical for EHS reporting."
    - name: "is_repeat_failure"
      expr: is_repeat_failure
      comment: "Flag indicating whether this is a repeat failure — key indicator of CAPA effectiveness."
    - name: "start_month"
      expr: DATE_TRUNC('MONTH', start_timestamp)
      comment: "Month of downtime event start for trend analysis of downtime frequency and duration over time."
    - name: "plant_code"
      expr: plant_code
      comment: "Plant where the downtime occurred — enables site-level benchmarking of availability performance."
  measures:
    - name: "total_downtime_events"
      expr: COUNT(1)
      comment: "Total number of downtime events — baseline frequency metric for reliability trending."
    - name: "total_downtime_minutes"
      expr: SUM(CAST(duration_minutes AS DOUBLE))
      comment: "Total downtime duration in minutes — primary availability loss metric for OEE calculation."
    - name: "avg_downtime_minutes"
      expr: AVG(CAST(duration_minutes AS DOUBLE))
      comment: "Average downtime duration per event — proxy for Mean Time To Repair (MTTR) at event level."
    - name: "total_repair_time_minutes"
      expr: SUM(CAST(repair_time_minutes AS DOUBLE))
      comment: "Total active repair time in minutes — distinguishes repair effort from total downtime including waiting."
    - name: "avg_response_time_minutes"
      expr: AVG(CAST(response_time_minutes AS DOUBLE))
      comment: "Average time from failure detection to maintenance response — measures maintenance responsiveness."
    - name: "total_estimated_production_loss"
      expr: SUM(CAST(estimated_production_loss_units AS DOUBLE))
      comment: "Total estimated production units lost due to downtime — quantifies throughput impact for operations leadership."
    - name: "total_estimated_loss_cost"
      expr: SUM(CAST(estimated_loss_cost AS DOUBLE))
      comment: "Total estimated financial cost of production losses from downtime — key input to maintenance ROI analysis."
    - name: "avg_oee_availability_impact_pct"
      expr: AVG(CAST(oee_availability_impact_pct AS DOUBLE))
      comment: "Average OEE availability impact percentage per downtime event — directly feeds OEE dashboard for executive review."
    - name: "repeat_failure_count"
      expr: COUNT(CASE WHEN is_repeat_failure = TRUE THEN 1 END)
      comment: "Count of repeat failure events — measures CAPA effectiveness and chronic failure elimination progress."
    - name: "safety_incident_downtime_count"
      expr: COUNT(CASE WHEN is_safety_incident = TRUE THEN 1 END)
      comment: "Count of downtime events involving safety incidents — critical EHS KPI for regulatory and board reporting."
    - name: "avg_repair_vs_response_ratio"
      expr: AVG(repair_time_minutes / NULLIF(response_time_minutes, 0))
      comment: "Ratio of repair time to response time per event — indicates whether delays are in response or actual repair, guiding resource allocation."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`asset_reliability_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Asset reliability and availability KPIs — tracks MTBF, MTTR, availability, failure rates, and health scores to guide asset lifecycle and maintenance strategy decisions."
  source: "`vibe_manufacturing_v1`.`asset`.`reliability_record`"
  dimensions:
    - name: "asset_class"
      expr: asset_class
      comment: "Asset class for benchmarking reliability performance across equipment categories."
    - name: "reliability_tier"
      expr: reliability_tier
      comment: "Reliability tier classification (e.g. Tier 1 Critical, Tier 2) for risk-stratified maintenance investment."
    - name: "plant_code"
      expr: plant_code
      comment: "Plant code for site-level reliability benchmarking and capital investment prioritization."
    - name: "record_status"
      expr: record_status
      comment: "Status of the reliability record (e.g. Active, Archived) to filter current vs. historical data."
    - name: "replacement_recommended"
      expr: replacement_recommended
      comment: "Flag indicating whether asset replacement is recommended — drives CapEx planning decisions."
    - name: "condition_monitoring_enabled"
      expr: condition_monitoring_enabled
      comment: "Whether condition monitoring is active on the asset — used to assess predictive maintenance coverage."
    - name: "measurement_period_start_month"
      expr: DATE_TRUNC('MONTH', CAST(measurement_period_start AS TIMESTAMP))
      comment: "Month of measurement period start for time-series reliability trending."
    - name: "trend_direction"
      expr: trend_direction
      comment: "Direction of reliability trend (e.g. Improving, Degrading, Stable) for proactive intervention triggers."
    - name: "failure_mode_dominant"
      expr: failure_mode_dominant
      comment: "Dominant failure mode for the asset — guides targeted maintenance strategy selection."
  measures:
    - name: "avg_mean_time_between_failures"
      expr: AVG(CAST(mean_time_between_failures AS DOUBLE))
      comment: "Average MTBF across assets — primary reliability KPI used in executive reliability dashboards and maintenance strategy reviews."
    - name: "avg_mean_time_to_repair"
      expr: AVG(CAST(mean_time_to_repair AS DOUBLE))
      comment: "Average MTTR across assets — measures maintenance efficiency and spare parts availability effectiveness."
    - name: "avg_availability_pct"
      expr: AVG(CAST(availability_pct AS DOUBLE))
      comment: "Average asset availability percentage — core OEE input and key metric for production capacity planning."
    - name: "avg_asset_health_score"
      expr: AVG(CAST(asset_health_score AS DOUBLE))
      comment: "Average asset health score across the fleet — executive-level indicator of overall asset condition and replacement risk."
    - name: "total_downtime_cost"
      expr: SUM(CAST(downtime_cost_usd AS DOUBLE))
      comment: "Total financial cost of downtime across all assets — key input to maintenance ROI and CapEx justification."
    - name: "total_failures"
      expr: SUM(CAST(total_failures AS DOUBLE))
      comment: "Total number of failures recorded across assets and periods — baseline for failure rate trending."
    - name: "avg_failure_rate"
      expr: AVG(CAST(failure_rate AS DOUBLE))
      comment: "Average failure rate per asset — used to identify chronic failure assets requiring reliability improvement programs."
    - name: "assets_below_availability_target"
      expr: COUNT(CASE WHEN availability_pct < availability_target_pct THEN 1 END)
      comment: "Count of assets failing to meet their availability target — drives prioritized maintenance intervention and investment decisions."
    - name: "avg_mtbf_variance_pct"
      expr: AVG(CAST(mtbf_variance_pct AS DOUBLE))
      comment: "Average variance between actual and target MTBF — measures reliability program effectiveness against engineering targets."
    - name: "replacement_recommended_count"
      expr: COUNT(CASE WHEN replacement_recommended = TRUE THEN 1 END)
      comment: "Count of assets recommended for replacement — directly informs CapEx budget planning and asset lifecycle decisions."
    - name: "total_planned_maintenance_hours"
      expr: SUM(CAST(planned_maintenance_hours AS DOUBLE))
      comment: "Total planned maintenance hours consumed — used for workforce capacity planning and maintenance budget tracking."
    - name: "avg_oee_availability_component"
      expr: AVG(CAST(oee_availability_component AS DOUBLE))
      comment: "Average OEE availability component across assets — feeds into plant-level OEE calculation for production leadership."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`asset_capex_asset_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capital asset financial KPIs — tracks acquisition cost, depreciation, net book value, and disposal performance to support CapEx planning, financial reporting, and asset lifecycle decisions."
  source: "`vibe_manufacturing_v1`.`asset`.`capex_asset_record`"
  dimensions:
    - name: "asset_category"
      expr: asset_category
      comment: "Asset category (e.g. Machinery, Buildings, IT Equipment) for portfolio-level CapEx analysis."
    - name: "asset_class_code"
      expr: asset_class_code
      comment: "Asset class code for financial reporting and depreciation policy grouping."
    - name: "asset_status"
      expr: asset_status
      comment: "Current lifecycle status of the asset (e.g. Active, Disposed, Under Construction) for portfolio health assessment."
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Depreciation method applied (e.g. Straight-Line, Declining Balance) for financial reporting consistency checks."
    - name: "plant_code"
      expr: plant_code
      comment: "Plant where the asset is located — enables site-level CapEx and asset value reporting."
    - name: "impairment_indicator"
      expr: impairment_indicator
      comment: "Flag indicating whether the asset has been assessed for impairment — critical for financial statement accuracy."
    - name: "capitalization_date_month"
      expr: DATE_TRUNC('MONTH', CAST(capitalization_date AS TIMESTAMP))
      comment: "Month of asset capitalization for CapEx spend timing analysis."
    - name: "disposal_method"
      expr: disposal_method
      comment: "Method of asset disposal (e.g. Sale, Scrap, Transfer) for disposal program performance tracking."
  measures:
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total acquisition cost of all capital assets — primary CapEx portfolio value metric for CFO and board reporting."
    - name: "total_net_book_value"
      expr: SUM(CAST(net_book_value AS DOUBLE))
      comment: "Total net book value of the asset portfolio — key balance sheet metric for financial reporting and asset management."
    - name: "total_accumulated_depreciation"
      expr: SUM(CAST(accumulated_depreciation AS DOUBLE))
      comment: "Total accumulated depreciation across all assets — measures asset aging and replacement fund requirements."
    - name: "avg_useful_life_years"
      expr: AVG(CAST(useful_life_years AS DOUBLE))
      comment: "Average useful life of assets — informs long-range CapEx replacement planning cycles."
    - name: "total_impairment_loss"
      expr: SUM(CAST(impairment_loss_amount AS DOUBLE))
      comment: "Total impairment losses recognized — critical financial risk metric for audit and investor reporting."
    - name: "total_disposal_proceeds"
      expr: SUM(CAST(disposal_proceeds AS DOUBLE))
      comment: "Total proceeds from asset disposals — measures asset monetization effectiveness and disposal program ROI."
    - name: "total_salvage_value"
      expr: SUM(CAST(salvage_value AS DOUBLE))
      comment: "Total estimated salvage value of the asset portfolio — input to depreciation calculations and end-of-life planning."
    - name: "avg_net_book_value"
      expr: AVG(CAST(net_book_value AS DOUBLE))
      comment: "Average net book value per asset — indicates average remaining value and fleet age profile."
    - name: "impaired_asset_count"
      expr: COUNT(CASE WHEN impairment_indicator = TRUE THEN 1 END)
      comment: "Count of assets with impairment indicators — flags financial risk concentration for audit and finance leadership."
    - name: "total_revaluation_amount"
      expr: SUM(CAST(revaluation_amount AS DOUBLE))
      comment: "Total revaluation adjustments applied to assets — tracks fair value adjustments for IFRS/GAAP compliance reporting."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`asset_pm_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Preventive maintenance schedule KPIs — tracks PM coverage, compliance, cost estimates, and schedule health to optimize maintenance planning and regulatory adherence."
  source: "`vibe_manufacturing_v1`.`asset`.`asset_pm_schedule`"
  dimensions:
    - name: "schedule_status"
      expr: schedule_status
      comment: "Current status of the PM schedule (e.g. Active, Suspended, Expired) for schedule portfolio health monitoring."
    - name: "maintenance_type"
      expr: maintenance_type
      comment: "Type of maintenance (e.g. Preventive, Predictive, Condition-Based) for strategy mix analysis."
    - name: "trigger_type"
      expr: trigger_type
      comment: "PM trigger type (e.g. Time-Based, Meter-Based, Condition-Based) for maintenance strategy optimization."
    - name: "tpm_pillar"
      expr: tpm_pillar
      comment: "TPM pillar alignment of the PM schedule for TPM program maturity assessment."
    - name: "is_regulatory_required"
      expr: is_regulatory_required
      comment: "Flag indicating whether the PM is mandated by regulation — critical for compliance risk management."
    - name: "is_safety_critical"
      expr: is_safety_critical
      comment: "Flag indicating safety-critical PM tasks — prioritization input for maintenance resource allocation."
    - name: "priority"
      expr: priority
      comment: "Priority level of the PM schedule for workload balancing and resource planning."
    - name: "frequency_unit"
      expr: frequency_unit
      comment: "Unit of PM frequency (e.g. Days, Hours, Cycles) for schedule density analysis."
    - name: "next_due_month"
      expr: DATE_TRUNC('MONTH', next_due_date)
      comment: "Month when PM is next due — enables forward-looking workload forecasting for maintenance planning."
  measures:
    - name: "total_pm_schedules"
      expr: COUNT(1)
      comment: "Total number of active PM schedules — baseline for PM program coverage assessment."
    - name: "total_estimated_material_cost"
      expr: SUM(CAST(estimated_material_cost AS DOUBLE))
      comment: "Total estimated material cost across all PM schedules — key input to maintenance budget planning."
    - name: "avg_estimated_duration_hours"
      expr: AVG(CAST(estimated_duration_hours AS DOUBLE))
      comment: "Average estimated duration per PM task — used for workforce capacity planning and schedule optimization."
    - name: "total_estimated_downtime_hours"
      expr: SUM(CAST(estimated_downtime_hours AS DOUBLE))
      comment: "Total estimated downtime hours from planned PM activities — input to production scheduling and OEE planning."
    - name: "regulatory_pm_count"
      expr: COUNT(CASE WHEN is_regulatory_required = TRUE THEN 1 END)
      comment: "Count of PM schedules mandated by regulation — measures regulatory compliance coverage and risk exposure."
    - name: "safety_critical_pm_count"
      expr: COUNT(CASE WHEN is_safety_critical = TRUE THEN 1 END)
      comment: "Count of safety-critical PM schedules — prioritization metric for EHS and maintenance leadership."
    - name: "avg_frequency_value"
      expr: AVG(CAST(frequency_value AS DOUBLE))
      comment: "Average PM frequency value — indicates maintenance intensity and schedule density across the asset fleet."
    - name: "avg_condition_threshold_value"
      expr: AVG(CAST(condition_threshold_value AS DOUBLE))
      comment: "Average condition threshold value for condition-based PM triggers — used to calibrate predictive maintenance sensitivity."
    - name: "shutdown_required_pm_count"
      expr: COUNT(CASE WHEN shutdown_required = TRUE THEN 1 END)
      comment: "Count of PM schedules requiring equipment shutdown — critical input to production downtime planning and outage scheduling."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`asset_calibration_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Instrument calibration quality KPIs — tracks calibration accuracy, out-of-tolerance rates, and compliance to ensure measurement system integrity for quality and regulatory purposes."
  source: "`vibe_manufacturing_v1`.`asset`.`calibration_record`"
  dimensions:
    - name: "instrument_type"
      expr: instrument_type
      comment: "Type of instrument being calibrated (e.g. Pressure Gauge, Thermocouple) for calibration program coverage analysis."
    - name: "measurement_parameter"
      expr: measurement_parameter
      comment: "Physical parameter being measured (e.g. Temperature, Pressure, Flow) for measurement system analysis."
    - name: "measurement_unit"
      expr: measurement_unit
      comment: "Unit of measurement for the calibrated instrument — ensures dimensional consistency in calibration reporting."
    - name: "adjustment_made"
      expr: adjustment_made
      comment: "Flag indicating whether an adjustment was made during calibration — key indicator of instrument drift and quality risk."
    - name: "out_of_service"
      expr: out_of_service
      comment: "Flag indicating whether the instrument was taken out of service — measures calibration failure impact on operations."
    - name: "calibration_date_month"
      expr: DATE_TRUNC('MONTH', calibration_date)
      comment: "Month of calibration for trend analysis of calibration activity volume and compliance."
    - name: "external_lab_name"
      expr: external_lab_name
      comment: "Name of external calibration laboratory — used for vendor performance and accreditation management."
  measures:
    - name: "total_calibrations"
      expr: COUNT(1)
      comment: "Total number of calibration records — baseline for calibration program activity and compliance coverage."
    - name: "avg_as_found_error"
      expr: AVG(CAST(as_found_error AS DOUBLE))
      comment: "Average as-found measurement error — indicates instrument drift magnitude and measurement system risk."
    - name: "avg_as_left_error"
      expr: AVG(CAST(as_left_error AS DOUBLE))
      comment: "Average as-left measurement error after calibration — measures calibration effectiveness and residual uncertainty."
    - name: "avg_measurement_uncertainty"
      expr: AVG(CAST(measurement_uncertainty AS DOUBLE))
      comment: "Average measurement uncertainty across calibrated instruments — key metric for measurement system analysis (MSA) and quality risk."
    - name: "out_of_service_count"
      expr: COUNT(CASE WHEN out_of_service = TRUE THEN 1 END)
      comment: "Count of instruments taken out of service due to calibration failure — measures quality risk from non-conforming measurement equipment."
    - name: "adjustment_required_count"
      expr: COUNT(CASE WHEN adjustment_made = TRUE THEN 1 END)
      comment: "Count of calibrations requiring adjustment — indicates instrument fleet drift rate and maintenance effectiveness."
    - name: "avg_calibration_interval_days"
      expr: AVG(CAST(calibration_interval_days AS DOUBLE))
      comment: "Average calibration interval in days — used to optimize calibration frequency and reduce compliance risk."
    - name: "avg_tolerance_range"
      expr: AVG(CAST(tolerance_upper_limit AS DOUBLE) - CAST(tolerance_lower_limit AS DOUBLE))
      comment: "Average tolerance band width across instruments — measures precision requirements and calibration stringency of the instrument fleet."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`asset_inspection_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Asset inspection performance KPIs — tracks inspection outcomes, findings, compliance rates, and corrective action triggers to manage regulatory compliance and asset safety."
  source: "`vibe_manufacturing_v1`.`asset`.`inspection_event`"
  dimensions:
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection (e.g. Statutory, Preventive, Condition) for compliance program coverage analysis."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current status of the inspection (e.g. Planned, In Progress, Completed, Overdue) for schedule adherence monitoring."
    - name: "inspection_outcome"
      expr: inspection_outcome
      comment: "Outcome of the inspection (e.g. Pass, Fail, Conditional Pass) — primary quality gate metric."
    - name: "inspection_method"
      expr: inspection_method
      comment: "Method used for inspection (e.g. Visual, NDT, Ultrasonic) for technique effectiveness analysis."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned to the inspection finding — drives prioritization of corrective actions."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Flag indicating whether corrective action is required — key compliance and safety risk indicator."
    - name: "plant_code"
      expr: plant_code
      comment: "Plant where the inspection was conducted — enables site-level compliance benchmarking."
    - name: "inspection_date_month"
      expr: DATE_TRUNC('MONTH', inspection_date)
      comment: "Month of inspection for trend analysis of inspection activity and compliance rates over time."
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory body requiring the inspection — used for jurisdiction-specific compliance reporting."
  measures:
    - name: "total_inspections"
      expr: COUNT(1)
      comment: "Total number of inspection events — baseline for compliance program activity and coverage."
    - name: "avg_inspection_duration_minutes"
      expr: AVG(CAST(inspection_duration_minutes AS DOUBLE))
      comment: "Average inspection duration — used for resource planning and identifying inspection complexity trends."
    - name: "total_downtime_from_inspections"
      expr: SUM(CAST(downtime_duration_minutes AS DOUBLE))
      comment: "Total downtime caused by inspection activities — quantifies production impact of compliance activities."
    - name: "avg_total_checklist_items"
      expr: AVG(CAST(total_checklist_items AS DOUBLE))
      comment: "Average number of checklist items per inspection — measures inspection thoroughness and scope."
    - name: "corrective_action_required_count"
      expr: COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END)
      comment: "Count of inspections requiring corrective action — key compliance risk metric for regulatory and safety leadership."
    - name: "certificate_issued_count"
      expr: COUNT(CASE WHEN certificate_issued = TRUE THEN 1 END)
      comment: "Count of inspections resulting in certificate issuance — measures regulatory certification throughput."
    - name: "downtime_caused_count"
      expr: COUNT(CASE WHEN downtime_caused = TRUE THEN 1 END)
      comment: "Count of inspections that caused asset downtime — measures production impact of compliance activities."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`asset_equipment_register`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Asset fleet composition and value KPIs — tracks fleet size, replacement value, condition distribution, and maintenance metrics to support asset lifecycle and investment decisions."
  source: "`vibe_manufacturing_v1`.`asset`.`equipment_register`"
  dimensions:
    - name: "asset_category"
      expr: asset_category
      comment: "Asset category for fleet composition and portfolio analysis."
    - name: "equipment_class"
      expr: equipment_class
      comment: "Equipment class for technical grouping and maintenance strategy assignment."
    - name: "condition_grade"
      expr: condition_grade
      comment: "Current condition grade of the equipment (e.g. A, B, C, D) — drives replacement prioritization and CapEx planning."
    - name: "criticality_ranking"
      expr: criticality_ranking
      comment: "Criticality ranking of the equipment — used for risk-based maintenance strategy selection."
    - name: "safety_classification"
      expr: safety_classification
      comment: "Safety classification of the equipment — required for EHS compliance and regulatory reporting."
    - name: "commissioning_month"
      expr: DATE_TRUNC('MONTH', commissioning_date)
      comment: "Month of equipment commissioning for fleet age profile analysis."
    - name: "manufacturer_name"
      expr: manufacturer_name
      comment: "Equipment manufacturer — used for vendor performance analysis and OEM contract management."
  measures:
    - name: "total_equipment_count"
      expr: COUNT(1)
      comment: "Total number of registered equipment assets — baseline fleet size metric for asset management reporting."
    - name: "total_replacement_value"
      expr: SUM(CAST(replacement_value AS DOUBLE))
      comment: "Total replacement value of the asset fleet — key metric for insurance, CapEx planning, and asset management strategy."
    - name: "avg_replacement_value"
      expr: AVG(CAST(replacement_value AS DOUBLE))
      comment: "Average replacement value per asset — used for fleet valuation benchmarking and insurance adequacy assessment."
    - name: "avg_mean_time_between_failures"
      expr: AVG(CAST(mean_time_between_failures AS DOUBLE))
      comment: "Average MTBF across the registered fleet — fleet-level reliability indicator for maintenance strategy review."
    - name: "avg_mean_time_to_repair"
      expr: AVG(CAST(mean_time_to_repair AS DOUBLE))
      comment: "Average MTTR across the registered fleet — measures overall maintenance responsiveness and spare parts effectiveness."
    - name: "total_power_rating_kw"
      expr: SUM(CAST(power_rating_kw AS DOUBLE))
      comment: "Total installed power rating in kW across the fleet — used for energy management and capacity planning."
    - name: "avg_rated_capacity"
      expr: AVG(CAST(rated_capacity AS DOUBLE))
      comment: "Average rated capacity across equipment — baseline for production capacity planning and utilization analysis."
    - name: "total_weight_kg"
      expr: SUM(CAST(weight_kg AS DOUBLE))
      comment: "Total weight of registered equipment — used for facility load planning and logistics/relocation planning."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`asset_warranty`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Asset warranty portfolio KPIs — tracks warranty coverage, claim activity, remaining value, and expiry risk to optimize warranty utilization and supplier accountability."
  source: "`vibe_manufacturing_v1`.`asset`.`asset_warranty`"
  dimensions:
    - name: "warranty_status"
      expr: warranty_status
      comment: "Current status of the warranty (e.g. Active, Expired, Claimed) for portfolio health monitoring."
    - name: "warranty_type"
      expr: warranty_type
      comment: "Type of warranty (e.g. OEM, Extended, Service) for coverage mix analysis."
    - name: "oem_vendor_name"
      expr: oem_vendor_name
      comment: "OEM vendor providing the warranty — used for vendor accountability and warranty claim performance tracking."
    - name: "labor_coverage_flag"
      expr: labor_coverage_flag
      comment: "Flag indicating whether labor costs are covered — used to assess warranty value and cost avoidance."
    - name: "parts_coverage_flag"
      expr: parts_coverage_flag
      comment: "Flag indicating whether parts are covered — key factor in warranty cost avoidance calculation."
    - name: "usage_based_flag"
      expr: usage_based_flag
      comment: "Flag indicating usage-based warranty terms — used to track consumption against warranty limits."
    - name: "activation_month"
      expr: DATE_TRUNC('MONTH', CAST(activation_date AS TIMESTAMP))
      comment: "Month of warranty activation for cohort analysis of warranty portfolio aging."
  measures:
    - name: "total_warranties"
      expr: COUNT(1)
      comment: "Total number of asset warranties — baseline for warranty portfolio coverage assessment."
    - name: "total_claimed_amount"
      expr: SUM(CAST(total_claimed_amount AS DOUBLE))
      comment: "Total amount claimed under warranties — measures warranty utilization and cost recovery from suppliers."
    - name: "total_remaining_warranty_value"
      expr: SUM(CAST(remaining_warranty_value AS DOUBLE))
      comment: "Total remaining warranty value across the portfolio — quantifies future cost protection and supplier liability."
    - name: "avg_duration_months"
      expr: AVG(CAST(duration_months AS DOUBLE))
      comment: "Average warranty duration in months — used for warranty coverage gap analysis and procurement negotiation."
    - name: "total_claims_count"
      expr: SUM(CAST(total_claims_count AS DOUBLE))
      comment: "Total number of warranty claims filed — measures warranty utilization rate and supplier quality performance."
    - name: "avg_max_claim_value"
      expr: AVG(CAST(max_claim_value AS DOUBLE))
      comment: "Average maximum claim value per warranty — used to assess warranty coverage adequacy against asset replacement costs."
    - name: "avg_usage_limit_value"
      expr: AVG(CAST(usage_limit_value AS DOUBLE))
      comment: "Average usage limit value for usage-based warranties — used to monitor consumption against warranty thresholds."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`asset_failure_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Asset failure analysis KPIs — tracks failure frequency, downtime impact, repair costs, and safety incidents to drive root cause elimination and reliability improvement programs."
  source: "`vibe_manufacturing_v1`.`asset`.`failure_record`"
  dimensions:
    - name: "failure_class_code"
      expr: failure_class_code
      comment: "Failure class code for Pareto analysis of failure categories driving the most downtime and cost."
    - name: "failure_mode_code"
      expr: failure_mode_code
      comment: "Specific failure mode code — used for FMEA alignment and targeted reliability improvement."
    - name: "failure_cause_code"
      expr: failure_cause_code
      comment: "Root cause code of the failure — drives corrective action prioritization and CAPA program management."
    - name: "maintenance_type"
      expr: maintenance_type
      comment: "Type of maintenance response triggered (e.g. Emergency, Corrective) — measures reactive maintenance burden."
    - name: "failure_impact_type"
      expr: failure_impact_type
      comment: "Type of impact caused by the failure (e.g. Production Loss, Safety, Quality) for risk classification."
    - name: "safety_incident_flag"
      expr: safety_incident_flag
      comment: "Flag indicating whether the failure caused a safety incident — critical EHS metric."
    - name: "capa_required_flag"
      expr: capa_required_flag
      comment: "Flag indicating whether CAPA is required — measures quality system response to failures."
    - name: "plant_code"
      expr: plant_code
      comment: "Plant where the failure occurred — enables site-level failure benchmarking."
    - name: "failure_datetime_month"
      expr: DATE_TRUNC('MONTH', failure_datetime)
      comment: "Month of failure occurrence for trend analysis of failure frequency over time."
  measures:
    - name: "total_failure_records"
      expr: COUNT(1)
      comment: "Total number of failure records — baseline failure frequency metric for reliability trending."
    - name: "total_downtime_minutes"
      expr: SUM(CAST(downtime_duration_minutes AS DOUBLE))
      comment: "Total downtime duration from failures in minutes — primary availability loss metric for OEE and production planning."
    - name: "avg_downtime_minutes"
      expr: AVG(CAST(downtime_duration_minutes AS DOUBLE))
      comment: "Average downtime per failure event — proxy for MTTR and maintenance response effectiveness."
    - name: "total_repair_cost"
      expr: SUM(CAST(repair_cost AS DOUBLE))
      comment: "Total repair cost across all failure records — key maintenance cost metric for budget management and ROI analysis."
    - name: "total_production_units_lost"
      expr: SUM(CAST(production_units_lost AS DOUBLE))
      comment: "Total production units lost due to failures — quantifies throughput impact for operations and finance leadership."
    - name: "total_mtbf_contribution_hours"
      expr: SUM(CAST(mtbf_contribution_hours AS DOUBLE))
      comment: "Total MTBF contribution hours across failure records — used to calculate fleet-level MTBF for reliability reporting."
    - name: "safety_incident_failure_count"
      expr: COUNT(CASE WHEN safety_incident_flag = TRUE THEN 1 END)
      comment: "Count of failures involving safety incidents — critical EHS KPI for regulatory reporting and board safety reviews."
    - name: "capa_required_count"
      expr: COUNT(CASE WHEN capa_required_flag = TRUE THEN 1 END)
      comment: "Count of failures requiring CAPA — measures quality system workload and chronic failure elimination progress."
    - name: "spare_part_consumed_count"
      expr: COUNT(CASE WHEN spare_part_consumed_flag = TRUE THEN 1 END)
      comment: "Count of failures consuming spare parts — used for spare parts demand forecasting and inventory optimization."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`asset_condition_reading`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Asset condition monitoring KPIs — tracks sensor readings, threshold breaches, and data quality to support predictive maintenance and condition-based maintenance programs."
  source: "`vibe_manufacturing_v1`.`asset`.`condition_reading`"
  dimensions:
    - name: "measurement_type"
      expr: measurement_type
      comment: "Type of measurement being monitored (e.g. Vibration, Temperature, Pressure) for condition monitoring coverage analysis."
    - name: "reading_type"
      expr: reading_type
      comment: "Type of reading (e.g. Continuous, Periodic, Manual) for data collection method analysis."
    - name: "reading_source"
      expr: reading_source
      comment: "Source of the reading (e.g. Sensor, Manual, SCADA) for data quality and coverage assessment."
    - name: "reading_status"
      expr: reading_status
      comment: "Status of the reading (e.g. Valid, Suspect, Rejected) for data quality filtering."
    - name: "threshold_breached"
      expr: threshold_breached
      comment: "Flag indicating whether the reading exceeded a threshold — primary trigger for predictive maintenance alerts."
    - name: "asset_operating_state"
      expr: asset_operating_state
      comment: "Operating state of the asset at time of reading (e.g. Running, Idle, Startup) for context-aware condition analysis."
    - name: "pm_trigger_flag"
      expr: pm_trigger_flag
      comment: "Flag indicating whether the reading triggered a PM work order — measures condition-based maintenance effectiveness."
    - name: "reading_month"
      expr: DATE_TRUNC('MONTH', reading_timestamp)
      comment: "Month of condition reading for trend analysis of asset health over time."
    - name: "equipment_class"
      expr: equipment_class
      comment: "Equipment class of the monitored asset — enables class-level condition benchmarking."
  measures:
    - name: "total_readings"
      expr: COUNT(1)
      comment: "Total number of condition readings — baseline for condition monitoring coverage and data collection activity."
    - name: "avg_reading_value"
      expr: AVG(CAST(reading_value AS DOUBLE))
      comment: "Average condition reading value — baseline for trend analysis and threshold calibration."
    - name: "avg_data_quality_score"
      expr: AVG(CAST(data_quality_score AS DOUBLE))
      comment: "Average data quality score across readings — measures sensor reliability and data integrity for predictive analytics."
    - name: "threshold_breach_count"
      expr: COUNT(CASE WHEN threshold_breached = TRUE THEN 1 END)
      comment: "Count of readings exceeding thresholds — primary alert volume metric for predictive maintenance program management."
    - name: "pm_trigger_count"
      expr: COUNT(CASE WHEN pm_trigger_flag = TRUE THEN 1 END)
      comment: "Count of readings that triggered PM work orders — measures condition-based maintenance activation rate."
    - name: "avg_load_percentage"
      expr: AVG(CAST(load_percentage AS DOUBLE))
      comment: "Average asset load percentage at time of reading — used for utilization analysis and capacity planning."
    - name: "avg_delta_value"
      expr: AVG(CAST(delta_value AS DOUBLE))
      comment: "Average change in reading value between measurements — measures rate of condition degradation for predictive maintenance models."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`asset_equipment_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Equipment utilization and allocation KPIs — tracks allocation rates, usage hours, and cost recovery to optimize asset deployment and identify underutilized equipment."
  source: "`vibe_manufacturing_v1`.`asset`.`location`"
  dimensions:
    - name: "All Records"
      expr: "1"
  measures:
    - name: "total_allocations"
      expr: COUNT(1)
      comment: "Total number of equipment allocations — baseline for deployment activity and asset sharing program assessment."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`asset_compliance_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Asset regulatory compliance KPIs — tracks assessment scores, compliance status, and corrective action requirements to manage regulatory risk and audit readiness."
  source: "`vibe_manufacturing_v1`.`asset`.`compliance_assessment`"
  dimensions:
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of compliance assessment (e.g. Regulatory, Internal, Third-Party) for compliance program coverage analysis."
    - name: "assessment_status"
      expr: assessment_status
      comment: "Current status of the assessment (e.g. Planned, In Progress, Completed) for compliance program pipeline monitoring."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Overall compliance status result (e.g. Compliant, Non-Compliant, Partially Compliant) — primary regulatory risk indicator."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level of the compliance finding — drives prioritization of remediation activities."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Flag indicating whether corrective action is required — key compliance risk metric for regulatory reporting."
    - name: "assessment_date_month"
      expr: DATE_TRUNC('MONTH', assessment_date)
      comment: "Month of assessment for trend analysis of compliance posture over time."
  measures:
    - name: "total_assessments"
      expr: COUNT(1)
      comment: "Total number of compliance assessments — baseline for regulatory compliance program activity."
    - name: "avg_compliance_score"
      expr: AVG(CAST(compliance_score AS DOUBLE))
      comment: "Average compliance score across assessments — executive-level indicator of overall regulatory compliance posture."
    - name: "avg_assessment_score"
      expr: AVG(CAST(assessment_score AS DOUBLE))
      comment: "Average assessment score — used for trend analysis of compliance performance improvement over time."
    - name: "non_compliant_count"
      expr: COUNT(CASE WHEN compliance_status = 'Non-Compliant' THEN 1 END)
      comment: "Count of non-compliant assessments — critical regulatory risk metric for board and executive reporting."
    - name: "corrective_action_required_count"
      expr: COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END)
      comment: "Count of assessments requiring corrective action — measures open regulatory risk exposure requiring remediation."
    - name: "remediation_required_count"
      expr: COUNT(CASE WHEN remediation_required_flag = TRUE THEN 1 END)
      comment: "Count of assessments with remediation required — tracks regulatory remediation backlog for compliance leadership."
$$;