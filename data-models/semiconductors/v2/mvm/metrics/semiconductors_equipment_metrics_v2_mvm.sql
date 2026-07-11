-- Metric views for domain: equipment | Business: Semiconductors | Version: 2 | Generated on: 2026-07-10 14:15:10

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`equipment_fab_tool`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic fab tool performance and utilization metrics for capital asset management and operational efficiency"
  source: "`vibe_semiconductors_v1`.`equipment`.`fab_tool`"
  dimensions:
    - name: "tool_type"
      expr: tool_type
      comment: "Type of fabrication tool (e.g., lithography, etch, deposition)"
    - name: "tool_subtype"
      expr: tool_subtype
      comment: "Subtype classification of the tool"
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle stage of the tool (e.g., active, deprecated, end-of-life)"
    - name: "asset_status"
      expr: asset_status
      comment: "Current operational status of the asset"
    - name: "process_node_compatibility"
      expr: process_node_compatibility
      comment: "Process node technology the tool supports (e.g., 7nm, 5nm, 3nm)"
    - name: "cleanroom_class"
      expr: cleanroom_class
      comment: "ISO cleanroom classification for the tool environment"
    - name: "fab_site_code"
      expr: fab_site_code
      comment: "Fabrication site identifier where the tool is located"
    - name: "installation_year"
      expr: YEAR(installation_date)
      comment: "Year the tool was installed"
    - name: "calibration_status"
      expr: CASE WHEN calibration_due_date < CURRENT_DATE() THEN 'Overdue' WHEN calibration_due_date <= DATE_ADD(CURRENT_DATE(), 30) THEN 'Due Soon' ELSE 'Current' END
      comment: "Calibration compliance status based on due date"
  measures:
    - name: "total_fab_tools"
      expr: COUNT(DISTINCT fab_tool_id)
      comment: "Total count of unique fabrication tools"
    - name: "avg_oee_percent"
      expr: AVG(CAST(oee_percent AS DOUBLE))
      comment: "Average Overall Equipment Effectiveness percentage across tools - key operational efficiency KPI"
    - name: "total_capacity_wafer_per_hour"
      expr: SUM(CAST(capacity_wafer_per_hour AS DOUBLE))
      comment: "Total wafer processing capacity per hour across all tools - critical throughput metric"
    - name: "avg_capacity_wafer_per_hour"
      expr: AVG(CAST(capacity_wafer_per_hour AS DOUBLE))
      comment: "Average wafer processing capacity per hour per tool"
    - name: "total_capex_amount"
      expr: SUM(CAST(capital_expenditure_amount AS DOUBLE))
      comment: "Total capital expenditure invested in fabrication tools - strategic investment metric"
    - name: "avg_mtbf_hours"
      expr: AVG(CAST(mtbf_hours AS DOUBLE))
      comment: "Average Mean Time Between Failures in hours - reliability KPI"
    - name: "avg_mttr_hours"
      expr: AVG(CAST(mttr_hours AS DOUBLE))
      comment: "Average Mean Time To Repair in hours - maintenance efficiency KPI"
    - name: "tool_availability_ratio"
      expr: ROUND(100.0 * AVG(CAST(mtbf_hours AS DOUBLE)) / NULLIF(AVG(CAST(mtbf_hours AS DOUBLE)) + AVG(CAST(mttr_hours AS DOUBLE)), 0), 2)
      comment: "Tool availability percentage calculated from MTBF and MTTR - operational uptime KPI"
    - name: "total_energy_consumption_kwh_per_year"
      expr: SUM(CAST(energy_consumption_kwh_per_year AS DOUBLE))
      comment: "Total annual energy consumption across all tools - sustainability and cost metric"
    - name: "avg_power_rating_kw"
      expr: AVG(CAST(power_rating_kw AS DOUBLE))
      comment: "Average power rating in kilowatts per tool"
    - name: "tools_overdue_calibration"
      expr: COUNT(DISTINCT CASE WHEN calibration_due_date < CURRENT_DATE() THEN fab_tool_id END)
      comment: "Count of tools with overdue calibration - compliance risk metric"
    - name: "tools_warranty_expired"
      expr: COUNT(DISTINCT CASE WHEN warranty_expiration_date < CURRENT_DATE() THEN fab_tool_id END)
      comment: "Count of tools with expired warranty - financial risk and maintenance cost exposure"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`equipment_tool_downtime`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tool downtime and availability metrics for operational efficiency and production impact analysis"
  source: "`vibe_semiconductors_v1`.`equipment`.`tool_downtime`"
  dimensions:
    - name: "downtime_type"
      expr: downtime_type
      comment: "Type of downtime event (e.g., planned, unplanned, emergency)"
    - name: "downtime_reason_code"
      expr: downtime_reason_code
      comment: "Standardized code for downtime reason"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "High-level category of root cause for downtime"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the downtime event"
    - name: "scheduled_flag"
      expr: scheduled_flag
      comment: "Boolean indicating if downtime was scheduled (True) or unscheduled (False)"
    - name: "shift"
      expr: shift
      comment: "Production shift during which downtime occurred"
    - name: "responsible_party"
      expr: responsible_party
      comment: "Party responsible for the downtime event"
    - name: "downtime_month"
      expr: DATE_TRUNC('MONTH', downtime_start_timestamp)
      comment: "Month when downtime started"
    - name: "downtime_week"
      expr: DATE_TRUNC('WEEK', downtime_start_timestamp)
      comment: "Week when downtime started"
  measures:
    - name: "total_downtime_events"
      expr: COUNT(DISTINCT tool_downtime_id)
      comment: "Total count of downtime events"
    - name: "total_downtime_minutes"
      expr: SUM(CAST(downtime_duration_minutes AS DOUBLE))
      comment: "Total downtime duration in minutes - critical production loss metric"
    - name: "avg_downtime_minutes_per_event"
      expr: AVG(CAST(downtime_duration_minutes AS DOUBLE))
      comment: "Average downtime duration per event in minutes"
    - name: "unscheduled_downtime_events"
      expr: COUNT(DISTINCT CASE WHEN scheduled_flag = FALSE THEN tool_downtime_id END)
      comment: "Count of unscheduled downtime events - operational disruption indicator"
    - name: "unscheduled_downtime_minutes"
      expr: SUM(CASE WHEN scheduled_flag = FALSE THEN CAST(downtime_duration_minutes AS DOUBLE) ELSE 0 END)
      comment: "Total unscheduled downtime in minutes - key reliability metric"
    - name: "avg_oee_impact_percentage"
      expr: AVG(CAST(oee_impact_percentage AS DOUBLE))
      comment: "Average OEE impact percentage per downtime event - productivity loss metric"
    - name: "total_wip_lot_impact"
      expr: SUM(CAST(impact_wip_lot_count AS DOUBLE))
      comment: "Total work-in-progress lots impacted by downtime - production disruption metric"
    - name: "high_severity_events"
      expr: COUNT(DISTINCT CASE WHEN severity_level IN ('High', 'Critical') THEN tool_downtime_id END)
      comment: "Count of high and critical severity downtime events - risk and escalation metric"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`equipment_maintenance_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Maintenance cost, efficiency, and quality metrics for asset management and operational excellence"
  source: "`vibe_semiconductors_v1`.`equipment`.`maintenance_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of maintenance event (e.g., preventive, corrective, upgrade)"
    - name: "maintenance_category"
      expr: maintenance_category
      comment: "Category classification of maintenance work"
    - name: "maintenance_event_status"
      expr: maintenance_event_status
      comment: "Current status of the maintenance event"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category for corrective maintenance"
    - name: "trigger_source"
      expr: trigger_source
      comment: "Source that triggered the maintenance event"
    - name: "upgrade_type"
      expr: upgrade_type
      comment: "Type of upgrade performed during maintenance"
    - name: "requalification_required"
      expr: requalification_required
      comment: "Boolean indicating if tool requalification is required post-maintenance"
    - name: "requalification_status"
      expr: requalification_status
      comment: "Status of requalification process"
    - name: "safety_incident_flag"
      expr: safety_incident_flag
      comment: "Boolean indicating if a safety incident occurred during maintenance"
    - name: "baseline_change_flag"
      expr: baseline_change_flag
      comment: "Boolean indicating if maintenance changed tool baseline configuration"
    - name: "maintenance_month"
      expr: DATE_TRUNC('MONTH', start_timestamp)
      comment: "Month when maintenance started"
  measures:
    - name: "total_maintenance_events"
      expr: COUNT(DISTINCT maintenance_event_id)
      comment: "Total count of maintenance events"
    - name: "total_maintenance_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total maintenance cost across all events - key operational expense metric"
    - name: "avg_maintenance_cost_per_event"
      expr: AVG(CAST(total_cost AS DOUBLE))
      comment: "Average maintenance cost per event"
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost_total AS DOUBLE))
      comment: "Total labor cost for maintenance activities"
    - name: "total_parts_cost"
      expr: SUM(CAST(parts_cost_total AS DOUBLE))
      comment: "Total parts and materials cost for maintenance"
    - name: "labor_cost_ratio"
      expr: ROUND(100.0 * SUM(CAST(labor_cost_total AS DOUBLE)) / NULLIF(SUM(CAST(total_cost AS DOUBLE)), 0), 2)
      comment: "Labor cost as percentage of total maintenance cost - cost structure metric"
    - name: "parts_cost_ratio"
      expr: ROUND(100.0 * SUM(CAST(parts_cost_total AS DOUBLE)) / NULLIF(SUM(CAST(total_cost AS DOUBLE)), 0), 2)
      comment: "Parts cost as percentage of total maintenance cost - cost structure metric"
    - name: "total_labor_hours"
      expr: SUM(CAST(labor_hours AS DOUBLE))
      comment: "Total labor hours spent on maintenance - resource utilization metric"
    - name: "avg_labor_hours_per_event"
      expr: AVG(CAST(labor_hours AS DOUBLE))
      comment: "Average labor hours per maintenance event"
    - name: "total_downtime_minutes"
      expr: SUM(CAST(downtime_duration_minutes AS DOUBLE))
      comment: "Total downtime duration in minutes due to maintenance - production impact metric"
    - name: "avg_downtime_minutes_per_event"
      expr: AVG(CAST(downtime_duration_minutes AS DOUBLE))
      comment: "Average downtime per maintenance event in minutes"
    - name: "avg_oee_impact_percentage"
      expr: AVG(CAST(oee_impact_percentage AS DOUBLE))
      comment: "Average OEE impact percentage from maintenance - efficiency loss metric"
    - name: "events_with_safety_incidents"
      expr: COUNT(DISTINCT CASE WHEN safety_incident_flag = TRUE THEN maintenance_event_id END)
      comment: "Count of maintenance events with safety incidents - safety performance metric"
    - name: "events_requiring_requalification"
      expr: COUNT(DISTINCT CASE WHEN requalification_required = TRUE THEN maintenance_event_id END)
      comment: "Count of events requiring tool requalification - quality assurance metric"
    - name: "events_with_baseline_change"
      expr: COUNT(DISTINCT CASE WHEN baseline_change_flag = TRUE THEN maintenance_event_id END)
      comment: "Count of events that changed tool baseline - change management metric"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`equipment_tool_chamber`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tool chamber performance, utilization, and compliance metrics for process control and quality management"
  source: "`vibe_semiconductors_v1`.`equipment`.`tool_chamber`"
  dimensions:
    - name: "chamber_type"
      expr: chamber_type
      comment: "Type of tool chamber (e.g., process chamber, load lock)"
    - name: "tool_chamber_status"
      expr: tool_chamber_status
      comment: "Current operational status of the chamber"
    - name: "chamber_status_reason"
      expr: chamber_status_reason
      comment: "Reason for current chamber status"
    - name: "qualification_status"
      expr: qualification_status
      comment: "Qualification status of the chamber for production use"
    - name: "calibration_status"
      expr: calibration_status
      comment: "Current calibration status of the chamber"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Regulatory and process compliance status"
    - name: "safety_lock_status"
      expr: safety_lock_status
      comment: "Safety interlock status of the chamber"
    - name: "location"
      expr: location
      comment: "Physical location of the chamber"
    - name: "maintenance_due_status"
      expr: CASE WHEN next_maintenance_due < CURRENT_DATE() THEN 'Overdue' WHEN next_maintenance_due <= DATE_ADD(CURRENT_DATE(), 7) THEN 'Due This Week' ELSE 'Current' END
      comment: "Maintenance due status based on next scheduled date"
  measures:
    - name: "total_tool_chambers"
      expr: COUNT(DISTINCT tool_chamber_id)
      comment: "Total count of unique tool chambers"
    - name: "avg_oee_percentage"
      expr: AVG(CAST(oee_percentage AS DOUBLE))
      comment: "Average Overall Equipment Effectiveness percentage for chambers - operational efficiency KPI"
    - name: "avg_throughput_pph"
      expr: AVG(CAST(throughput_pph AS DOUBLE))
      comment: "Average throughput in parts per hour - productivity metric"
    - name: "total_throughput_capacity_pph"
      expr: SUM(CAST(throughput_pph AS DOUBLE))
      comment: "Total throughput capacity across all chambers in parts per hour"
    - name: "avg_mtbf_hours"
      expr: AVG(CAST(mtbf_hours AS DOUBLE))
      comment: "Average Mean Time Between Failures for chambers - reliability KPI"
    - name: "avg_mttr_hours"
      expr: AVG(CAST(mttr_hours AS DOUBLE))
      comment: "Average Mean Time To Repair for chambers - maintenance efficiency KPI"
    - name: "chamber_availability_ratio"
      expr: ROUND(100.0 * AVG(CAST(mtbf_hours AS DOUBLE)) / NULLIF(AVG(CAST(mtbf_hours AS DOUBLE)) + AVG(CAST(mttr_hours AS DOUBLE)), 0), 2)
      comment: "Chamber availability percentage from MTBF and MTTR - uptime KPI"
    - name: "avg_chamber_lifetime_hours"
      expr: AVG(CAST(chamber_lifetime_hours AS DOUBLE))
      comment: "Average cumulative operating hours per chamber - asset utilization metric"
    - name: "chambers_overdue_maintenance"
      expr: COUNT(DISTINCT CASE WHEN next_maintenance_due < CURRENT_DATE() THEN tool_chamber_id END)
      comment: "Count of chambers with overdue maintenance - compliance risk metric"
    - name: "chambers_not_qualified"
      expr: COUNT(DISTINCT CASE WHEN qualification_status NOT IN ('Qualified', 'Active') THEN tool_chamber_id END)
      comment: "Count of chambers not qualified for production - capacity constraint metric"
    - name: "chambers_calibration_overdue"
      expr: COUNT(DISTINCT CASE WHEN calibration_status IN ('Overdue', 'Expired') THEN tool_chamber_id END)
      comment: "Count of chambers with overdue calibration - quality risk metric"
    - name: "chambers_warranty_expired"
      expr: COUNT(DISTINCT CASE WHEN warranty_expiration_date < CURRENT_DATE() THEN tool_chamber_id END)
      comment: "Count of chambers with expired warranty - cost exposure metric"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`equipment_calibration_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Calibration compliance, quality, and measurement accuracy metrics for regulatory adherence and process control"
  source: "`vibe_semiconductors_v1`.`equipment`.`calibration_record`"
  dimensions:
    - name: "calibration_type"
      expr: calibration_type
      comment: "Type of calibration performed (e.g., full, partial, verification)"
    - name: "calibration_method"
      expr: calibration_method
      comment: "Method used for calibration"
    - name: "calibration_standard"
      expr: calibration_standard
      comment: "Calibration standard or reference used"
    - name: "calibration_record_status"
      expr: calibration_record_status
      comment: "Status of the calibration record"
    - name: "pass_fail_result"
      expr: pass_fail_result
      comment: "Pass or fail result of calibration"
    - name: "calibration_result_code"
      expr: calibration_result_code
      comment: "Detailed result code from calibration"
    - name: "measurement_unit"
      expr: measurement_unit
      comment: "Unit of measurement for calibration"
    - name: "location"
      expr: location
      comment: "Location where calibration was performed"
    - name: "technician_name"
      expr: technician_name
      comment: "Name of technician who performed calibration"
    - name: "calibration_month"
      expr: DATE_TRUNC('MONTH', calibration_timestamp)
      comment: "Month when calibration was performed"
    - name: "compliance_reference"
      expr: compliance_reference
      comment: "Regulatory compliance reference for calibration"
  measures:
    - name: "total_calibration_records"
      expr: COUNT(DISTINCT calibration_record_id)
      comment: "Total count of calibration records"
    - name: "calibration_pass_count"
      expr: COUNT(DISTINCT CASE WHEN pass_fail_result = 'Pass' THEN calibration_record_id END)
      comment: "Count of calibrations that passed"
    - name: "calibration_fail_count"
      expr: COUNT(DISTINCT CASE WHEN pass_fail_result = 'Fail' THEN calibration_record_id END)
      comment: "Count of calibrations that failed - quality risk indicator"
    - name: "calibration_pass_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN pass_fail_result = 'Pass' THEN calibration_record_id END) / NULLIF(COUNT(DISTINCT calibration_record_id), 0), 2)
      comment: "Calibration pass rate percentage - quality and compliance KPI"
    - name: "avg_measured_value"
      expr: AVG(CAST(measured_value AS DOUBLE))
      comment: "Average measured value across calibrations"
    - name: "avg_nominal_value"
      expr: AVG(CAST(nominal_value AS DOUBLE))
      comment: "Average nominal (target) value across calibrations"
    - name: "avg_measurement_uncertainty"
      expr: AVG(CAST(measurement_uncertainty AS DOUBLE))
      comment: "Average measurement uncertainty - precision metric"
    - name: "avg_measurement_deviation"
      expr: AVG(ABS(CAST(measured_value AS DOUBLE) - CAST(nominal_value AS DOUBLE)))
      comment: "Average absolute deviation between measured and nominal values - accuracy metric"
    - name: "calibrations_overdue"
      expr: COUNT(DISTINCT CASE WHEN next_due_date < CURRENT_DATE() THEN calibration_record_id END)
      comment: "Count of calibrations that are overdue - compliance risk metric"
    - name: "calibrations_due_soon"
      expr: COUNT(DISTINCT CASE WHEN next_due_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 30) THEN calibration_record_id END)
      comment: "Count of calibrations due within next 30 days - planning metric"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`equipment_spare_part`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Spare parts inventory, cost, and availability metrics for supply chain optimization and maintenance planning"
  source: "`vibe_semiconductors_v1`.`equipment`.`spare_part`"
  dimensions:
    - name: "part_type"
      expr: part_type
      comment: "Type classification of spare part"
    - name: "part_category"
      expr: part_category
      comment: "Category of spare part"
    - name: "spare_part_status"
      expr: spare_part_status
      comment: "Current status of the spare part"
    - name: "criticality_rating"
      expr: criticality_rating
      comment: "Criticality rating for production impact (e.g., critical, high, medium, low)"
    - name: "calibration_required_flag"
      expr: calibration_required_flag
      comment: "Boolean indicating if part requires calibration"
    - name: "hazardous_material_flag"
      expr: hazardous_material_flag
      comment: "Boolean indicating if part is hazardous material"
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current inspection status of the part"
    - name: "storage_condition"
      expr: storage_condition
      comment: "Required storage conditions for the part"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for part cost"
    - name: "stock_status"
      expr: CASE WHEN CAST(current_stock_qty AS DOUBLE) <= CAST(min_stock_level AS DOUBLE) THEN 'Below Minimum' WHEN CAST(current_stock_qty AS DOUBLE) <= CAST(reorder_point AS DOUBLE) THEN 'Reorder Needed' ELSE 'Adequate' END
      comment: "Stock level status relative to minimum and reorder thresholds"
  measures:
    - name: "total_spare_parts"
      expr: COUNT(DISTINCT spare_part_id)
      comment: "Total count of unique spare parts in inventory"
    - name: "total_inventory_value"
      expr: SUM(CAST(current_stock_qty AS DOUBLE) * CAST(unit_cost AS DOUBLE))
      comment: "Total inventory value of spare parts - working capital metric"
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost per spare part"
    - name: "total_current_stock_qty"
      expr: SUM(CAST(current_stock_qty AS DOUBLE))
      comment: "Total current stock quantity across all parts"
    - name: "parts_below_minimum"
      expr: COUNT(DISTINCT CASE WHEN CAST(current_stock_qty AS DOUBLE) < CAST(min_stock_level AS DOUBLE) THEN spare_part_id END)
      comment: "Count of parts below minimum stock level - stockout risk metric"
    - name: "parts_at_reorder_point"
      expr: COUNT(DISTINCT CASE WHEN CAST(current_stock_qty AS DOUBLE) <= CAST(reorder_point AS DOUBLE) THEN spare_part_id END)
      comment: "Count of parts at or below reorder point - procurement action metric"
    - name: "critical_parts_below_minimum"
      expr: COUNT(DISTINCT CASE WHEN criticality_rating = 'Critical' AND CAST(current_stock_qty AS DOUBLE) < CAST(min_stock_level AS DOUBLE) THEN spare_part_id END)
      comment: "Count of critical parts below minimum stock - high-risk shortage metric"
    - name: "avg_lead_time_days"
      expr: AVG(CAST(lead_time_days AS DOUBLE))
      comment: "Average lead time in days for spare parts procurement"
    - name: "parts_requiring_calibration"
      expr: COUNT(DISTINCT CASE WHEN calibration_required_flag = TRUE THEN spare_part_id END)
      comment: "Count of parts requiring calibration - quality control metric"
    - name: "hazardous_parts_count"
      expr: COUNT(DISTINCT CASE WHEN hazardous_material_flag = TRUE THEN spare_part_id END)
      comment: "Count of hazardous material parts - safety and compliance metric"
    - name: "parts_warranty_expired"
      expr: COUNT(DISTINCT CASE WHEN warranty_expiration_date < CURRENT_DATE() THEN spare_part_id END)
      comment: "Count of parts with expired warranty - cost exposure metric"
    - name: "avg_part_weight_kg"
      expr: AVG(CAST(part_weight_kg AS DOUBLE))
      comment: "Average part weight in kilograms - logistics planning metric"
$$;