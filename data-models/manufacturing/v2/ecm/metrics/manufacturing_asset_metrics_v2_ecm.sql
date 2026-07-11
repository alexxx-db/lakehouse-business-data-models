-- Metric views for domain: asset | Business: Manufacturing | Version: 2 | Generated on: 2026-07-10 11:52:40

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`asset_equipment_register`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core equipment asset KPIs tracking fleet health, replacement value, maintenance readiness, and operational status distribution across the equipment register."
  source: "`vibe_manufacturing_v1`.`asset`.`equipment_register`"
  dimensions:
    - name: "asset_category"
      expr: asset_category
      comment: "Equipment asset category for fleet segmentation (e.g. rotating, static, electrical)."
    - name: "equipment_class"
      expr: equipment_class
      comment: "Equipment class for grouping similar asset types in performance analysis."
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the equipment (active, decommissioned, standby) for availability reporting."
    - name: "maintenance_strategy"
      expr: maintenance_strategy
      comment: "Maintenance strategy applied to the asset (preventive, predictive, corrective) for strategy effectiveness analysis."
    - name: "safety_classification"
      expr: safety_classification
      comment: "Safety classification of the equipment for risk-based prioritization."
    - name: "criticality_ranking"
      expr: criticality_ranking
      comment: "Asset criticality ranking for prioritizing maintenance investment and risk management."
    - name: "work_center_code"
      expr: work_center_code
      comment: "Work center where the equipment is assigned for operational planning."
  measures:
    - name: "total_equipment_count"
      expr: COUNT(1)
      comment: "Total number of registered equipment assets. Baseline fleet size KPI used for capacity and investment planning."
    - name: "total_replacement_value"
      expr: SUM(CAST(replacement_value AS DOUBLE))
      comment: "Total replacement value of all registered equipment assets. Critical for insurance, capital budgeting, and asset lifecycle investment decisions."
    - name: "avg_replacement_value"
      expr: AVG(CAST(replacement_value AS DOUBLE))
      comment: "Average replacement value per equipment asset. Used to benchmark asset investment levels and prioritize high-value asset maintenance."
    - name: "avg_mean_time_between_failures_hours"
      expr: AVG(CAST(mean_time_between_failures AS DOUBLE))
      comment: "Average MTBF across the equipment fleet. A key reliability KPI — declining MTBF signals deteriorating fleet health requiring maintenance strategy review."
    - name: "avg_mean_time_to_repair_hours"
      expr: AVG(CAST(mean_time_to_repair AS DOUBLE))
      comment: "Average MTTR across the equipment fleet. Measures maintenance responsiveness — high MTTR indicates resource or spare parts constraints impacting production availability."
    - name: "total_rated_capacity"
      expr: SUM(CAST(rated_capacity AS DOUBLE))
      comment: "Total rated capacity across all equipment assets. Used for production capacity planning and utilization benchmarking."
    - name: "total_power_rating_kw"
      expr: SUM(CAST(power_rating_kw AS DOUBLE))
      comment: "Total installed power rating in kilowatts across the fleet. Supports energy management and sustainability reporting."
    - name: "equipment_with_overdue_maintenance_count"
      expr: COUNT(CASE WHEN next_maintenance_due_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of equipment assets with overdue maintenance. A critical operational risk KPI — high counts indicate maintenance backlog threatening reliability and compliance."
    - name: "equipment_with_expired_warranty_count"
      expr: COUNT(CASE WHEN warranty_expiry_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of equipment assets with expired warranties. Drives warranty renewal and risk exposure decisions for asset protection."
    - name: "distinct_plant_count"
      expr: COUNT(DISTINCT plant_id)
      comment: "Number of distinct plants with registered equipment. Used for geographic asset distribution analysis and plant-level investment planning."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`asset_work_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Work order execution KPIs measuring maintenance cost, labor efficiency, schedule adherence, and backlog across all asset work orders."
  source: "`vibe_manufacturing_v1`.`asset`.`asset_work_order`"
  dimensions:
    - name: "work_order_status"
      expr: work_order_status
      comment: "Current status of the work order (open, in-progress, completed, cancelled) for backlog and throughput analysis."
    - name: "work_order_source"
      expr: work_order_source
      comment: "Origin of the work order (preventive, corrective, inspection, breakdown) for maintenance strategy effectiveness analysis."
    - name: "priority"
      expr: priority
      comment: "Work order priority level for resource allocation and SLA compliance monitoring."
    - name: "tpm_pillar"
      expr: tpm_pillar
      comment: "Total Productive Maintenance pillar associated with the work order for TPM program performance tracking."
    - name: "capex_opex_classification"
      expr: capex_opex_classification
      comment: "CapEx vs OpEx classification for financial reporting and budget management."
    - name: "craft_type"
      expr: craft_type
      comment: "Craft or trade type required for the work order for workforce planning and skills gap analysis."
    - name: "is_production_impacting"
      expr: is_production_impacting
      comment: "Flag indicating whether the work order impacts production. Used to prioritize critical maintenance and quantify production risk."
  measures:
    - name: "total_work_orders"
      expr: COUNT(1)
      comment: "Total number of work orders. Baseline maintenance activity volume KPI for workload and capacity planning."
    - name: "total_actual_labor_cost"
      expr: SUM(CAST(actual_labor_cost AS DOUBLE))
      comment: "Total actual labor cost across all work orders. Core maintenance cost KPI for budget management and cost control."
    - name: "total_actual_material_cost"
      expr: SUM(CAST(actual_material_cost AS DOUBLE))
      comment: "Total actual material cost across all work orders. Drives spare parts inventory investment and procurement decisions."
    - name: "total_maintenance_cost"
      expr: SUM(CAST(actual_labor_cost AS DOUBLE) + CAST(actual_material_cost AS DOUBLE))
      comment: "Total combined maintenance cost (labor + materials). Primary maintenance spend KPI for executive cost management and budget variance analysis."
    - name: "total_planned_labor_hours"
      expr: SUM(CAST(planned_labor_hours AS DOUBLE))
      comment: "Total planned labor hours across all work orders. Used for workforce capacity planning and scheduling."
    - name: "total_actual_labor_hours"
      expr: SUM(CAST(actual_labor_hours AS DOUBLE))
      comment: "Total actual labor hours consumed. Compared against planned hours to measure maintenance execution efficiency."
    - name: "total_downtime_duration_hours"
      expr: SUM(CAST(downtime_duration_hours AS DOUBLE))
      comment: "Total asset downtime hours caused by work orders. Directly linked to production loss — a key OEE and availability KPI."
    - name: "avg_downtime_duration_hours"
      expr: AVG(CAST(downtime_duration_hours AS DOUBLE))
      comment: "Average downtime duration per work order. Measures maintenance responsiveness and impact on production availability."
    - name: "total_estimated_cost"
      expr: SUM(CAST(total_estimated_cost AS DOUBLE))
      comment: "Total estimated cost across all work orders. Used for budget forecasting and cost variance analysis against actuals."
    - name: "production_impacting_work_order_count"
      expr: COUNT(CASE WHEN is_production_impacting = TRUE THEN 1 END)
      comment: "Number of work orders that impact production. Quantifies production risk exposure from maintenance activities."
    - name: "safety_permit_required_count"
      expr: COUNT(CASE WHEN safety_permit_required = TRUE THEN 1 END)
      comment: "Number of work orders requiring safety permits. Tracks safety compliance workload and regulatory adherence."
    - name: "overdue_work_order_count"
      expr: COUNT(CASE WHEN planned_finish_date < CURRENT_TIMESTAMP() AND work_order_status NOT IN ('Completed', 'Closed', 'Cancelled') THEN 1 END)
      comment: "Number of work orders past their planned finish date and not yet closed. Measures maintenance backlog and schedule adherence — a critical operational risk indicator."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`asset_downtime_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Asset downtime KPIs measuring production loss, downtime duration, failure patterns, and OEE availability impact to drive reliability improvement decisions."
  source: "`vibe_manufacturing_v1`.`asset`.`asset_downtime_event`"
  dimensions:
    - name: "downtime_category"
      expr: downtime_category
      comment: "Category of downtime event (planned, unplanned, breakdown) for root cause and trend analysis."
    - name: "downtime_type"
      expr: downtime_type
      comment: "Type of downtime for granular failure classification and maintenance strategy alignment."
    - name: "failure_class"
      expr: failure_class
      comment: "Failure class code for FMEA-aligned root cause analysis and reliability improvement prioritization."
    - name: "failure_code"
      expr: failure_code
      comment: "Specific failure code for detailed failure mode tracking and spare parts demand forecasting."
    - name: "root_cause_code"
      expr: root_cause_code
      comment: "Root cause code for systemic failure analysis and corrective action targeting."
    - name: "maintenance_type"
      expr: maintenance_type
      comment: "Type of maintenance response (corrective, emergency, preventive) for maintenance mix analysis."
    - name: "is_safety_incident"
      expr: is_safety_incident
      comment: "Flag indicating whether the downtime event involved a safety incident for EHS compliance reporting."
    - name: "is_repeat_failure"
      expr: is_repeat_failure
      comment: "Flag indicating repeat failures on the same asset for chronic failure identification and CAPA prioritization."
    - name: "plant_code"
      expr: plant_code
      comment: "Plant where the downtime event occurred for site-level availability benchmarking."
  measures:
    - name: "total_downtime_events"
      expr: COUNT(1)
      comment: "Total number of downtime events. Baseline reliability KPI for trend analysis and maintenance program effectiveness."
    - name: "total_downtime_duration_minutes"
      expr: SUM(CAST(duration_minutes AS DOUBLE))
      comment: "Total downtime duration in minutes. Primary availability KPI — directly drives OEE availability component and production loss calculations."
    - name: "avg_downtime_duration_minutes"
      expr: AVG(CAST(duration_minutes AS DOUBLE))
      comment: "Average downtime duration per event. Measures severity of individual failures and maintenance response effectiveness."
    - name: "total_estimated_production_loss_units"
      expr: SUM(CAST(estimated_production_loss_units AS DOUBLE))
      comment: "Total estimated production units lost due to downtime. Directly quantifies the business impact of asset failures on throughput."
    - name: "total_estimated_loss_cost"
      expr: SUM(CAST(estimated_loss_cost AS DOUBLE))
      comment: "Total estimated financial loss from downtime events. Executive-level KPI linking asset reliability to revenue impact."
    - name: "avg_oee_availability_impact_pct"
      expr: AVG(CAST(oee_availability_impact_pct AS DOUBLE))
      comment: "Average OEE availability impact percentage per downtime event. Core OEE component KPI for manufacturing performance management."
    - name: "total_repair_time_minutes"
      expr: SUM(CAST(repair_time_minutes AS DOUBLE))
      comment: "Total repair time in minutes across all downtime events. Measures maintenance resource consumption and MTTR contribution."
    - name: "avg_response_time_minutes"
      expr: AVG(CAST(response_time_minutes AS DOUBLE))
      comment: "Average maintenance response time in minutes. Measures maintenance team responsiveness — high response times amplify production loss."
    - name: "repeat_failure_count"
      expr: COUNT(CASE WHEN is_repeat_failure = TRUE THEN 1 END)
      comment: "Number of repeat failure events. Identifies chronic failure patterns requiring root cause elimination and CAPA investment."
    - name: "safety_incident_downtime_count"
      expr: COUNT(CASE WHEN is_safety_incident = TRUE THEN 1 END)
      comment: "Number of downtime events involving safety incidents. Critical EHS KPI for regulatory compliance and safety culture assessment."
    - name: "distinct_failed_equipment_count"
      expr: COUNT(DISTINCT equipment_register_id)
      comment: "Number of distinct equipment assets that experienced downtime. Measures fleet-wide failure breadth for maintenance prioritization."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`asset_pm_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Preventive maintenance schedule KPIs measuring PM program coverage, compliance, cost estimation, and schedule health across the asset fleet."
  source: "`vibe_manufacturing_v1`.`asset`.`asset_pm_schedule`"
  dimensions:
    - name: "schedule_status"
      expr: schedule_status
      comment: "Current status of the PM schedule (active, inactive, suspended) for program coverage analysis."
    - name: "maintenance_type"
      expr: maintenance_type
      comment: "Type of preventive maintenance (time-based, condition-based, meter-based) for strategy mix analysis."
    - name: "trigger_type"
      expr: trigger_type
      comment: "PM trigger type (calendar, meter, condition) for maintenance strategy effectiveness evaluation."
    - name: "tpm_pillar"
      expr: tpm_pillar
      comment: "TPM pillar associated with the PM schedule for Total Productive Maintenance program tracking."
    - name: "priority"
      expr: priority
      comment: "PM schedule priority for resource allocation and scheduling optimization."
    - name: "is_safety_critical"
      expr: is_safety_critical
      comment: "Flag indicating safety-critical PM tasks for compliance and risk management prioritization."
    - name: "is_regulatory_required"
      expr: is_regulatory_required
      comment: "Flag indicating regulatory-mandated PM tasks for compliance reporting and audit readiness."
    - name: "frequency_unit"
      expr: frequency_unit
      comment: "Frequency unit of the PM schedule (daily, weekly, monthly, annually) for workload distribution analysis."
  measures:
    - name: "total_pm_schedules"
      expr: COUNT(1)
      comment: "Total number of active PM schedules. Baseline PM program coverage KPI for maintenance planning."
    - name: "total_estimated_material_cost"
      expr: SUM(CAST(estimated_material_cost AS DOUBLE))
      comment: "Total estimated material cost across all PM schedules. Drives annual maintenance budget planning and spare parts procurement."
    - name: "avg_estimated_duration_hours"
      expr: AVG(CAST(estimated_duration_hours AS DOUBLE))
      comment: "Average estimated duration per PM task. Used for workforce capacity planning and maintenance window scheduling."
    - name: "total_estimated_downtime_hours"
      expr: SUM(CAST(estimated_downtime_hours AS DOUBLE))
      comment: "Total estimated downtime hours from planned PM activities. Critical for production scheduling and OEE planned downtime forecasting."
    - name: "safety_critical_pm_count"
      expr: COUNT(CASE WHEN is_safety_critical = TRUE THEN 1 END)
      comment: "Number of safety-critical PM schedules. Ensures safety-critical maintenance tasks are tracked and never deferred."
    - name: "regulatory_required_pm_count"
      expr: COUNT(CASE WHEN is_regulatory_required = TRUE THEN 1 END)
      comment: "Number of regulatory-mandated PM schedules. Tracks compliance obligations and audit exposure."
    - name: "overdue_pm_schedule_count"
      expr: COUNT(CASE WHEN next_due_date < CURRENT_DATE() AND schedule_status = 'Active' THEN 1 END)
      comment: "Number of PM schedules past their next due date. Measures PM compliance backlog — a leading indicator of equipment reliability risk."
    - name: "shutdown_required_pm_count"
      expr: COUNT(CASE WHEN shutdown_required = TRUE THEN 1 END)
      comment: "Number of PM tasks requiring equipment shutdown. Used for production shutdown planning and minimizing unplanned outages."
    - name: "distinct_equipment_on_pm_count"
      expr: COUNT(DISTINCT equipment_register_id)
      comment: "Number of distinct equipment assets covered by PM schedules. Measures PM program coverage breadth across the fleet."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`asset_reliability_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Asset reliability KPIs measuring MTBF, MTTR, availability, failure rates, and downtime costs to drive reliability-centered maintenance investment decisions."
  source: "`vibe_manufacturing_v1`.`asset`.`reliability_record`"
  dimensions:
    - name: "asset_class"
      expr: asset_class
      comment: "Asset class for fleet-level reliability benchmarking and investment prioritization."
    - name: "maintenance_strategy"
      expr: maintenance_strategy
      comment: "Maintenance strategy applied to the asset for strategy effectiveness evaluation."
    - name: "reliability_tier"
      expr: reliability_tier
      comment: "Reliability tier classification for risk-based maintenance prioritization."
    - name: "trend_direction"
      expr: trend_direction
      comment: "Reliability trend direction (improving, stable, declining) for proactive intervention targeting."
    - name: "plant_code"
      expr: plant_code
      comment: "Plant code for site-level reliability benchmarking and resource allocation."
    - name: "replacement_recommended"
      expr: replacement_recommended
      comment: "Flag indicating assets recommended for replacement for capital planning and lifecycle management."
    - name: "condition_monitoring_enabled"
      expr: condition_monitoring_enabled
      comment: "Flag indicating whether condition monitoring is active for predictive maintenance program coverage analysis."
  measures:
    - name: "avg_mean_time_between_failures_hours"
      expr: AVG(CAST(mean_time_between_failures AS DOUBLE))
      comment: "Average MTBF in hours across reliability records. Primary fleet reliability KPI — declining MTBF triggers maintenance strategy review and capital investment decisions."
    - name: "avg_mean_time_to_repair_hours"
      expr: AVG(CAST(mean_time_to_repair AS DOUBLE))
      comment: "Average MTTR in hours. Measures maintenance responsiveness — high MTTR drives workforce and spare parts investment decisions."
    - name: "avg_availability_pct"
      expr: AVG(CAST(availability_pct AS DOUBLE))
      comment: "Average asset availability percentage. Core OEE availability component — directly linked to production throughput and revenue."
    - name: "avg_oee_availability_component"
      expr: AVG(CAST(oee_availability_component AS DOUBLE))
      comment: "Average OEE availability component across assets. Executive-level manufacturing performance KPI for operational excellence programs."
    - name: "total_downtime_cost_usd"
      expr: SUM(CAST(downtime_cost_usd AS DOUBLE))
      comment: "Total downtime cost in USD across all reliability records. Quantifies the financial impact of asset unreliability for executive investment justification."
    - name: "avg_failure_rate"
      expr: AVG(CAST(failure_rate AS DOUBLE))
      comment: "Average failure rate across assets. Measures fleet-wide reliability health — rising failure rates signal deteriorating asset condition."
    - name: "total_downtime_hours"
      expr: SUM(CAST(total_downtime_hours AS DOUBLE))
      comment: "Total downtime hours across all reliability records. Aggregated availability loss KPI for production planning and maintenance investment justification."
    - name: "total_uptime_hours"
      expr: SUM(CAST(total_uptime_hours AS DOUBLE))
      comment: "Total uptime hours across all reliability records. Measures productive asset utilization for capacity and throughput analysis."
    - name: "assets_below_availability_target_count"
      expr: COUNT(CASE WHEN availability_pct < availability_target_pct THEN 1 END)
      comment: "Number of assets performing below their availability target. Identifies underperforming assets requiring immediate maintenance intervention."
    - name: "replacement_recommended_count"
      expr: COUNT(CASE WHEN replacement_recommended = TRUE THEN 1 END)
      comment: "Number of assets recommended for replacement. Drives capital expenditure planning and asset lifecycle management decisions."
    - name: "avg_mtbf_variance_pct"
      expr: AVG(CAST(mtbf_variance_pct AS DOUBLE))
      comment: "Average MTBF variance percentage against target. Measures reliability program effectiveness — high variance indicates maintenance strategy misalignment."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`asset_capex_asset_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capital asset financial KPIs measuring acquisition cost, depreciation, net book value, and asset lifecycle financial health for capital planning and financial reporting."
  source: "`vibe_manufacturing_v1`.`asset`.`capex_asset_record`"
  dimensions:
    - name: "asset_category"
      expr: asset_category
      comment: "Asset category for capital portfolio segmentation and investment analysis."
    - name: "asset_class_code"
      expr: asset_class_code
      comment: "Asset class code for depreciation policy grouping and financial reporting."
    - name: "asset_status"
      expr: asset_status
      comment: "Current asset status (active, disposed, impaired) for portfolio health monitoring."
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Depreciation method applied (straight-line, declining balance) for financial reporting consistency analysis."
    - name: "plant_code"
      expr: plant_code
      comment: "Plant code for site-level capital asset distribution and investment analysis."
    - name: "impairment_indicator"
      expr: impairment_indicator
      comment: "Flag indicating impaired assets for financial risk and write-down exposure reporting."
    - name: "capitalization_threshold_met"
      expr: capitalization_threshold_met
      comment: "Flag indicating whether the asset met the capitalization threshold for CapEx vs OpEx classification."
  measures:
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total acquisition cost of all capital assets. Primary CapEx portfolio value KPI for balance sheet and investment planning."
    - name: "total_net_book_value"
      expr: SUM(CAST(net_book_value AS DOUBLE))
      comment: "Total net book value of all capital assets. Core financial reporting KPI for balance sheet asset valuation."
    - name: "total_accumulated_depreciation"
      expr: SUM(CAST(accumulated_depreciation AS DOUBLE))
      comment: "Total accumulated depreciation across all capital assets. Measures asset aging and replacement investment timing."
    - name: "total_salvage_value"
      expr: SUM(CAST(salvage_value AS DOUBLE))
      comment: "Total salvage value of all capital assets. Used for disposal planning and residual value management."
    - name: "total_impairment_loss_amount"
      expr: SUM(CAST(impairment_loss_amount AS DOUBLE))
      comment: "Total impairment loss recognized across the capital asset portfolio. Financial risk KPI for executive reporting and audit compliance."
    - name: "avg_useful_life_years"
      expr: AVG(CAST(useful_life_years AS DOUBLE))
      comment: "Average useful life in years across capital assets. Used for depreciation planning and asset replacement cycle forecasting."
    - name: "impaired_asset_count"
      expr: COUNT(CASE WHEN impairment_indicator = TRUE THEN 1 END)
      comment: "Number of impaired capital assets. Tracks financial write-down exposure and asset portfolio quality."
    - name: "disposed_asset_count"
      expr: COUNT(CASE WHEN disposal_date IS NOT NULL THEN 1 END)
      comment: "Number of disposed capital assets. Measures asset lifecycle turnover and replacement investment activity."
    - name: "total_disposal_proceeds"
      expr: SUM(CAST(disposal_proceeds AS DOUBLE))
      comment: "Total proceeds from asset disposals. Used for gain/loss on disposal analysis and capital recycling decisions."
    - name: "avg_net_book_value"
      expr: AVG(CAST(net_book_value AS DOUBLE))
      comment: "Average net book value per capital asset. Benchmarks asset depreciation health and replacement timing across the portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`asset_calibration_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Instrument calibration KPIs measuring calibration compliance, measurement accuracy, out-of-tolerance rates, and calibration program health for quality and regulatory assurance."
  source: "`vibe_manufacturing_v1`.`asset`.`calibration_record`"
  dimensions:
    - name: "calibration_status"
      expr: calibration_status
      comment: "Current calibration status (pass, fail, overdue) for compliance monitoring."
    - name: "calibration_type"
      expr: calibration_type
      comment: "Type of calibration (internal, external, on-site) for resource and cost planning."
    - name: "calibration_method"
      expr: calibration_method
      comment: "Calibration method applied for measurement system analysis and standardization."
    - name: "instrument_type"
      expr: instrument_type
      comment: "Type of instrument being calibrated for fleet-level calibration program management."
    - name: "measurement_parameter"
      expr: measurement_parameter
      comment: "Physical parameter being measured (temperature, pressure, flow) for calibration scope analysis."
    - name: "out_of_service"
      expr: out_of_service
      comment: "Flag indicating instruments taken out of service due to calibration failure for availability impact tracking."
    - name: "adjustment_made"
      expr: adjustment_made
      comment: "Flag indicating whether a calibration adjustment was required for measurement system drift analysis."
  measures:
    - name: "total_calibration_records"
      expr: COUNT(1)
      comment: "Total number of calibration records. Baseline calibration program activity KPI."
    - name: "out_of_tolerance_count"
      expr: COUNT(CASE WHEN calibration_status = 'Fail' OR adjustment_made = TRUE THEN 1 END)
      comment: "Number of calibrations where instruments were out of tolerance. Quality risk KPI — high counts indicate measurement system unreliability affecting product quality."
    - name: "out_of_service_instrument_count"
      expr: COUNT(CASE WHEN out_of_service = TRUE THEN 1 END)
      comment: "Number of instruments currently out of service due to calibration issues. Operational risk KPI for production and quality control availability."
    - name: "avg_as_found_error"
      expr: AVG(CAST(as_found_error AS DOUBLE))
      comment: "Average as-found measurement error across calibrations. Measures instrument drift and measurement system stability over time."
    - name: "avg_as_left_error"
      expr: AVG(CAST(as_left_error AS DOUBLE))
      comment: "Average as-left measurement error after calibration adjustment. Measures calibration effectiveness and residual measurement uncertainty."
    - name: "avg_measurement_uncertainty"
      expr: AVG(CAST(measurement_uncertainty AS DOUBLE))
      comment: "Average measurement uncertainty across calibrated instruments. Quantifies measurement system quality for product conformance decisions."
    - name: "overdue_calibration_count"
      expr: COUNT(CASE WHEN calibration_due_date < CURRENT_DATE() AND out_of_service = FALSE THEN 1 END)
      comment: "Number of instruments with overdue calibrations still in service. Critical compliance risk KPI — overdue calibrations invalidate measurement data and create regulatory exposure."
    - name: "distinct_calibrated_equipment_count"
      expr: COUNT(DISTINCT equipment_register_id)
      comment: "Number of distinct equipment assets with calibration records. Measures calibration program coverage across the instrumented asset fleet."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`asset_inspection_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Asset inspection KPIs measuring inspection outcomes, findings rates, compliance status, and corrective action requirements to drive asset integrity and regulatory compliance."
  source: "`vibe_manufacturing_v1`.`asset`.`inspection_event`"
  dimensions:
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection (statutory, preventive, condition-based) for compliance and program analysis."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current inspection status (scheduled, in-progress, completed, overdue) for program execution tracking."
    - name: "inspection_outcome"
      expr: inspection_outcome
      comment: "Outcome of the inspection (pass, fail, conditional pass) for asset integrity assessment."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned to the inspection for prioritization and resource allocation."
    - name: "plant_code"
      expr: plant_code
      comment: "Plant where the inspection was conducted for site-level compliance benchmarking."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Flag indicating whether corrective action is required following the inspection."
    - name: "certificate_issued"
      expr: certificate_issued
      comment: "Flag indicating whether a compliance certificate was issued following the inspection."
  measures:
    - name: "total_inspection_events"
      expr: COUNT(1)
      comment: "Total number of inspection events. Baseline inspection program activity KPI."
    - name: "inspections_requiring_corrective_action_count"
      expr: COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END)
      comment: "Number of inspections requiring corrective action. Measures asset integrity risk exposure and maintenance backlog from inspection findings."
    - name: "certificates_issued_count"
      expr: COUNT(CASE WHEN certificate_issued = TRUE THEN 1 END)
      comment: "Number of inspections resulting in certificate issuance. Tracks regulatory compliance achievement and certification program throughput."
    - name: "downtime_caused_count"
      expr: COUNT(CASE WHEN downtime_caused = TRUE THEN 1 END)
      comment: "Number of inspections that caused equipment downtime. Quantifies production impact of inspection activities for scheduling optimization."
    - name: "distinct_inspected_equipment_count"
      expr: COUNT(DISTINCT equipment_register_id)
      comment: "Number of distinct equipment assets inspected. Measures inspection program coverage across the asset fleet."
    - name: "overdue_inspection_count"
      expr: COUNT(CASE WHEN next_inspection_due_date < CURRENT_DATE() AND inspection_status NOT IN ('Completed', 'Closed') THEN 1 END)
      comment: "Number of inspections past their due date. Critical compliance risk KPI — overdue inspections create regulatory and safety exposure."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`asset_failure_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Asset failure analysis KPIs measuring failure frequency, repair costs, downtime impact, and safety incidents to drive FMEA-based reliability improvement and maintenance investment."
  source: "`vibe_manufacturing_v1`.`asset`.`failure_record`"
  dimensions:
    - name: "failure_class_code"
      expr: failure_class_code
      comment: "Failure class code for FMEA-aligned failure categorization and reliability analysis."
    - name: "failure_mode_code"
      expr: failure_mode_code
      comment: "Failure mode code for root cause analysis and predictive maintenance model development."
    - name: "failure_cause_code"
      expr: failure_cause_code
      comment: "Root cause code for systemic failure elimination and corrective action targeting."
    - name: "maintenance_type"
      expr: maintenance_type
      comment: "Maintenance response type for analyzing corrective vs preventive maintenance balance."
    - name: "failure_impact_type"
      expr: failure_impact_type
      comment: "Type of business impact from the failure (production, safety, quality, cost) for prioritization."
    - name: "safety_incident_flag"
      expr: safety_incident_flag
      comment: "Flag indicating failures involving safety incidents for EHS compliance and risk management."
    - name: "plant_code"
      expr: plant_code
      comment: "Plant where the failure occurred for site-level reliability benchmarking."
    - name: "capa_required_flag"
      expr: capa_required_flag
      comment: "Flag indicating whether a CAPA is required for the failure for quality system compliance tracking."
  measures:
    - name: "total_failure_records"
      expr: COUNT(1)
      comment: "Total number of failure records. Baseline failure frequency KPI for reliability trend analysis."
    - name: "total_repair_cost"
      expr: SUM(CAST(repair_cost AS DOUBLE))
      comment: "Total repair cost across all failure records. Primary maintenance cost KPI for budget management and reliability investment justification."
    - name: "avg_repair_cost"
      expr: AVG(CAST(repair_cost AS DOUBLE))
      comment: "Average repair cost per failure. Benchmarks failure severity and guides make-vs-replace decisions for aging assets."
    - name: "total_downtime_duration_minutes"
      expr: SUM(CAST(downtime_duration_minutes AS DOUBLE))
      comment: "Total downtime duration from failures in minutes. Quantifies production availability loss from asset failures."
    - name: "total_production_units_lost"
      expr: SUM(CAST(production_units_lost AS DOUBLE))
      comment: "Total production units lost due to asset failures. Directly links asset reliability to production throughput and revenue impact."
    - name: "total_mtbf_contribution_hours"
      expr: SUM(CAST(mtbf_contribution_hours AS DOUBLE))
      comment: "Total MTBF contribution hours across failure records. Used for fleet-level MTBF calculation and reliability benchmarking."
    - name: "safety_incident_failure_count"
      expr: COUNT(CASE WHEN safety_incident_flag = TRUE THEN 1 END)
      comment: "Number of failures involving safety incidents. Critical EHS KPI for regulatory compliance and safety culture assessment."
    - name: "capa_required_failure_count"
      expr: COUNT(CASE WHEN capa_required_flag = TRUE THEN 1 END)
      comment: "Number of failures requiring corrective and preventive action. Measures quality system workload and systemic failure exposure."
    - name: "distinct_failed_equipment_count"
      expr: COUNT(DISTINCT equipment_register_id)
      comment: "Number of distinct equipment assets with failure records. Measures failure breadth across the fleet for maintenance prioritization."
    - name: "spare_part_consumed_failure_count"
      expr: COUNT(CASE WHEN spare_part_consumed_flag = TRUE THEN 1 END)
      comment: "Number of failures requiring spare part consumption. Drives spare parts inventory planning and stocking strategy decisions."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`asset_warranty`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Asset warranty KPIs measuring warranty coverage, claim activity, financial exposure, and expiry risk to optimize warranty recovery and supplier accountability."
  source: "`vibe_manufacturing_v1`.`asset`.`asset_warranty`"
  dimensions:
    - name: "warranty_status"
      expr: warranty_status
      comment: "Current warranty status (active, expired, claimed) for coverage portfolio management."
    - name: "warranty_type"
      expr: warranty_type
      comment: "Type of warranty (OEM, extended, service) for warranty program analysis."
    - name: "labor_coverage_flag"
      expr: labor_coverage_flag
      comment: "Flag indicating labor coverage inclusion for warranty value assessment."
    - name: "parts_coverage_flag"
      expr: parts_coverage_flag
      comment: "Flag indicating parts coverage inclusion for warranty scope analysis."
    - name: "usage_based_flag"
      expr: usage_based_flag
      comment: "Flag indicating usage-based warranty terms for condition monitoring alignment."
    - name: "rma_eligible_flag"
      expr: rma_eligible_flag
      comment: "Flag indicating RMA eligibility under warranty for returns management planning."
  measures:
    - name: "total_active_warranties"
      expr: COUNT(CASE WHEN warranty_status = 'Active' THEN 1 END)
      comment: "Total number of active warranties. Measures warranty coverage portfolio size for risk management."
    - name: "total_claimed_amount"
      expr: SUM(CAST(total_claimed_amount AS DOUBLE))
      comment: "Total amount claimed under warranties. Measures warranty recovery value and supplier accountability performance."
    - name: "total_remaining_warranty_value"
      expr: SUM(CAST(remaining_warranty_value AS DOUBLE))
      comment: "Total remaining warranty value across active warranties. Quantifies unclaimed warranty protection for financial risk management."
    - name: "total_max_claim_value"
      expr: SUM(CAST(max_claim_value AS DOUBLE))
      comment: "Total maximum claimable value across all warranties. Measures total warranty protection ceiling for asset risk coverage analysis."
    - name: "warranties_expiring_within_90_days_count"
      expr: COUNT(CASE WHEN expiration_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 90) AND warranty_status = 'Active' THEN 1 END)
      comment: "Number of warranties expiring within 90 days. Drives proactive warranty renewal and claim submission before expiry."
    - name: "avg_usage_limit_value"
      expr: AVG(CAST(usage_limit_value AS DOUBLE))
      comment: "Average usage limit value for usage-based warranties. Used for condition monitoring alignment and warranty compliance tracking."
    - name: "distinct_equipment_under_warranty_count"
      expr: COUNT(DISTINCT equipment_register_id)
      comment: "Number of distinct equipment assets under warranty coverage. Measures warranty program coverage breadth for risk management."
$$;