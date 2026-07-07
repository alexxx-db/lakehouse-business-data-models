-- Metric views for domain: asset | Business: Manufacturing | Version: 2 | Generated on: 2026-07-03 07:46:30

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`asset_downtime_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Asset downtime event metrics tracking equipment availability, downtime costs, and operational efficiency impacts"
  source: "`vibe_manufacturing_v1`.`asset`.`asset_downtime_event`"
  dimensions:
    - name: "downtime_category"
      expr: downtime_category
      comment: "Category of downtime event (planned, unplanned, etc.)"
    - name: "downtime_type"
      expr: downtime_type
      comment: "Specific type of downtime event"
    - name: "failure_class"
      expr: failure_class
      comment: "Classification of failure that caused downtime"
    - name: "failure_code"
      expr: failure_code
      comment: "Specific failure code"
    - name: "detection_method"
      expr: detection_method
      comment: "Method by which downtime was detected"
    - name: "maintenance_type"
      expr: maintenance_type
      comment: "Type of maintenance performed"
    - name: "event_status"
      expr: event_status
      comment: "Current status of downtime event"
    - name: "plant_code"
      expr: plant_code
      comment: "Plant where downtime occurred"
    - name: "is_repeat_failure"
      expr: is_repeat_failure
      comment: "Flag indicating if this is a repeat failure"
    - name: "is_safety_incident"
      expr: is_safety_incident
      comment: "Flag indicating if downtime involved a safety incident"
    - name: "environmental_impact_flag"
      expr: environmental_impact_flag
      comment: "Flag indicating environmental impact"
    - name: "downtime_year"
      expr: YEAR(start_timestamp)
      comment: "Year of downtime event start"
    - name: "downtime_month"
      expr: DATE_TRUNC('MONTH', start_timestamp)
      comment: "Month of downtime event start"
    - name: "downtime_week"
      expr: DATE_TRUNC('WEEK', start_timestamp)
      comment: "Week of downtime event start"
  measures:
    - name: "total_downtime_events"
      expr: COUNT(1)
      comment: "Total number of downtime events"
    - name: "total_downtime_minutes"
      expr: SUM(CAST(duration_minutes AS DOUBLE))
      comment: "Total downtime duration in minutes across all events"
    - name: "avg_downtime_minutes"
      expr: AVG(CAST(duration_minutes AS DOUBLE))
      comment: "Average downtime duration per event in minutes"
    - name: "total_estimated_loss_cost"
      expr: SUM(CAST(estimated_loss_cost AS DOUBLE))
      comment: "Total estimated financial loss from downtime events"
    - name: "avg_estimated_loss_cost"
      expr: AVG(CAST(estimated_loss_cost AS DOUBLE))
      comment: "Average estimated financial loss per downtime event"
    - name: "total_production_loss_units"
      expr: SUM(CAST(estimated_production_loss_units AS DOUBLE))
      comment: "Total production units lost due to downtime"
    - name: "avg_response_time_minutes"
      expr: AVG(CAST(response_time_minutes AS DOUBLE))
      comment: "Average time to respond to downtime events in minutes"
    - name: "avg_repair_time_minutes"
      expr: AVG(CAST(repair_time_minutes AS DOUBLE))
      comment: "Average time to repair and restore equipment in minutes"
    - name: "total_oee_availability_impact"
      expr: SUM(CAST(oee_availability_impact_pct AS DOUBLE))
      comment: "Total OEE availability impact percentage points across all events"
    - name: "avg_oee_availability_impact"
      expr: AVG(CAST(oee_availability_impact_pct AS DOUBLE))
      comment: "Average OEE availability impact percentage per event"
    - name: "repeat_failure_count"
      expr: SUM(CASE WHEN is_repeat_failure = TRUE THEN 1 ELSE 0 END)
      comment: "Count of downtime events that are repeat failures"
    - name: "safety_incident_count"
      expr: SUM(CASE WHEN is_safety_incident = TRUE THEN 1 ELSE 0 END)
      comment: "Count of downtime events involving safety incidents"
    - name: "environmental_impact_count"
      expr: SUM(CASE WHEN environmental_impact_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of downtime events with environmental impact"
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`asset_work_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Asset work order metrics tracking maintenance execution, cost performance, and schedule adherence"
  source: "`vibe_manufacturing_v1`.`asset`.`asset_work_order`"
  dimensions:
    - name: "work_order_status"
      expr: work_order_status
      comment: "Current status of work order"
    - name: "work_order_source"
      expr: work_order_source
      comment: "Source system or trigger for work order"
    - name: "priority"
      expr: priority
      comment: "Work order priority level"
    - name: "craft_type"
      expr: craft_type
      comment: "Type of craft/skill required"
    - name: "asset_criticality"
      expr: asset_criticality
      comment: "Criticality classification of affected asset"
    - name: "capex_opex_classification"
      expr: capex_opex_classification
      comment: "Capital vs operational expenditure classification"
    - name: "is_production_impacting"
      expr: is_production_impacting
      comment: "Flag indicating if work order impacts production"
    - name: "safety_permit_required"
      expr: safety_permit_required
      comment: "Flag indicating if safety permit is required"
    - name: "tpm_pillar"
      expr: tpm_pillar
      comment: "Total Productive Maintenance pillar classification"
    - name: "failure_code"
      expr: failure_code
      comment: "Failure code associated with work order"
    - name: "completion_code"
      expr: completion_code
      comment: "Code indicating completion status or outcome"
    - name: "planned_start_year"
      expr: YEAR(planned_start_date)
      comment: "Year of planned work order start"
    - name: "planned_start_month"
      expr: DATE_TRUNC('MONTH', planned_start_date)
      comment: "Month of planned work order start"
    - name: "actual_start_month"
      expr: DATE_TRUNC('MONTH', actual_start_date)
      comment: "Month of actual work order start"
  measures:
    - name: "total_work_orders"
      expr: COUNT(1)
      comment: "Total number of work orders"
    - name: "total_actual_labor_cost"
      expr: SUM(CAST(actual_labor_cost AS DOUBLE))
      comment: "Total actual labor cost across all work orders"
    - name: "total_actual_material_cost"
      expr: SUM(CAST(actual_material_cost AS DOUBLE))
      comment: "Total actual material cost across all work orders"
    - name: "total_planned_material_cost"
      expr: SUM(CAST(planned_material_cost AS DOUBLE))
      comment: "Total planned material cost across all work orders"
    - name: "total_estimated_cost"
      expr: SUM(CAST(total_estimated_cost AS DOUBLE))
      comment: "Total estimated cost for all work orders"
    - name: "avg_actual_labor_cost"
      expr: AVG(CAST(actual_labor_cost AS DOUBLE))
      comment: "Average actual labor cost per work order"
    - name: "avg_actual_material_cost"
      expr: AVG(CAST(actual_material_cost AS DOUBLE))
      comment: "Average actual material cost per work order"
    - name: "total_actual_labor_hours"
      expr: SUM(CAST(actual_labor_hours AS DOUBLE))
      comment: "Total actual labor hours across all work orders"
    - name: "total_planned_labor_hours"
      expr: SUM(CAST(planned_labor_hours AS DOUBLE))
      comment: "Total planned labor hours across all work orders"
    - name: "avg_actual_labor_hours"
      expr: AVG(CAST(actual_labor_hours AS DOUBLE))
      comment: "Average actual labor hours per work order"
    - name: "avg_planned_labor_hours"
      expr: AVG(CAST(planned_labor_hours AS DOUBLE))
      comment: "Average planned labor hours per work order"
    - name: "total_downtime_hours"
      expr: SUM(CAST(downtime_duration_hours AS DOUBLE))
      comment: "Total downtime hours caused by work orders"
    - name: "avg_downtime_hours"
      expr: AVG(CAST(downtime_duration_hours AS DOUBLE))
      comment: "Average downtime hours per work order"
    - name: "production_impacting_count"
      expr: SUM(CASE WHEN is_production_impacting = TRUE THEN 1 ELSE 0 END)
      comment: "Count of work orders that impact production"
    - name: "safety_permit_required_count"
      expr: SUM(CASE WHEN safety_permit_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of work orders requiring safety permits"
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`asset_equipment_register`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Equipment register metrics tracking asset reliability, maintenance performance, and asset value"
  source: "`vibe_manufacturing_v1`.`asset`.`equipment_register`"
  dimensions:
    - name: "asset_category"
      expr: asset_category
      comment: "Category classification of asset"
    - name: "equipment_class"
      expr: equipment_class
      comment: "Equipment class designation"
    - name: "criticality_ranking"
      expr: criticality_ranking
      comment: "Criticality ranking of equipment"
    - name: "condition_grade"
      expr: condition_grade
      comment: "Current condition grade of equipment"
    - name: "manufacturer_name"
      expr: manufacturer_name
      comment: "Equipment manufacturer name"
    - name: "safety_classification"
      expr: safety_classification
      comment: "Safety classification of equipment"
    - name: "work_center_code"
      expr: work_center_code
      comment: "Work center where equipment is assigned"
    - name: "regulatory_certification"
      expr: regulatory_certification
      comment: "Regulatory certification status"
    - name: "commissioning_year"
      expr: YEAR(commissioning_date)
      comment: "Year equipment was commissioned"
    - name: "installation_year"
      expr: YEAR(installation_date)
      comment: "Year equipment was installed"
  measures:
    - name: "total_equipment_count"
      expr: COUNT(1)
      comment: "Total number of equipment assets in register"
    - name: "total_replacement_value"
      expr: SUM(CAST(replacement_value AS DOUBLE))
      comment: "Total replacement value of all equipment"
    - name: "avg_replacement_value"
      expr: AVG(CAST(replacement_value AS DOUBLE))
      comment: "Average replacement value per equipment asset"
    - name: "avg_mean_time_between_failures"
      expr: AVG(CAST(mean_time_between_failures AS DOUBLE))
      comment: "Average MTBF across all equipment"
    - name: "avg_mean_time_to_repair"
      expr: AVG(CAST(mean_time_to_repair AS DOUBLE))
      comment: "Average MTTR across all equipment"
    - name: "total_rated_capacity"
      expr: SUM(CAST(rated_capacity AS DOUBLE))
      comment: "Total rated capacity across all equipment"
    - name: "avg_rated_capacity"
      expr: AVG(CAST(rated_capacity AS DOUBLE))
      comment: "Average rated capacity per equipment asset"
    - name: "total_power_rating_kw"
      expr: SUM(CAST(power_rating_kw AS DOUBLE))
      comment: "Total power rating in kilowatts across all equipment"
    - name: "avg_power_rating_kw"
      expr: AVG(CAST(power_rating_kw AS DOUBLE))
      comment: "Average power rating per equipment asset in kilowatts"
    - name: "total_weight_kg"
      expr: SUM(CAST(weight_kg AS DOUBLE))
      comment: "Total weight of all equipment in kilograms"
    - name: "avg_weight_kg"
      expr: AVG(CAST(weight_kg AS DOUBLE))
      comment: "Average weight per equipment asset in kilograms"
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`asset_failure_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Failure record metrics tracking equipment failure patterns, FMEA risk, and failure costs"
  source: "`vibe_manufacturing_v1`.`asset`.`failure_record`"
  dimensions:
    - name: "failure_class_code"
      expr: failure_class_code
      comment: "Failure class code"
    - name: "failure_mode_code"
      expr: failure_mode_code
      comment: "Failure mode code"
    - name: "failure_cause_code"
      expr: failure_cause_code
      comment: "Root cause code for failure"
    - name: "failure_impact_type"
      expr: failure_impact_type
      comment: "Type of impact from failure"
    - name: "detection_method_code"
      expr: detection_method_code
      comment: "Method by which failure was detected"
    - name: "maintenance_type"
      expr: maintenance_type
      comment: "Type of maintenance performed"
    - name: "severity_rating"
      expr: severity_rating
      comment: "FMEA severity rating"
    - name: "occurrence_rating"
      expr: occurrence_rating
      comment: "FMEA occurrence rating"
    - name: "detection_rating"
      expr: detection_rating
      comment: "FMEA detection rating"
    - name: "risk_priority_number"
      expr: risk_priority_number
      comment: "FMEA risk priority number (RPN)"
    - name: "plant_code"
      expr: plant_code
      comment: "Plant where failure occurred"
    - name: "capa_required_flag"
      expr: capa_required_flag
      comment: "Flag indicating if corrective action is required"
    - name: "safety_incident_flag"
      expr: safety_incident_flag
      comment: "Flag indicating if failure involved safety incident"
    - name: "environmental_incident_flag"
      expr: environmental_incident_flag
      comment: "Flag indicating environmental incident"
    - name: "spare_part_consumed_flag"
      expr: spare_part_consumed_flag
      comment: "Flag indicating if spare parts were consumed"
    - name: "record_status"
      expr: record_status
      comment: "Status of failure record"
    - name: "failure_year"
      expr: YEAR(failure_datetime)
      comment: "Year of failure occurrence"
    - name: "failure_month"
      expr: DATE_TRUNC('MONTH', failure_datetime)
      comment: "Month of failure occurrence"
  measures:
    - name: "total_failures"
      expr: COUNT(1)
      comment: "Total number of failure records"
    - name: "total_repair_cost"
      expr: SUM(CAST(repair_cost AS DOUBLE))
      comment: "Total repair cost across all failures"
    - name: "avg_repair_cost"
      expr: AVG(CAST(repair_cost AS DOUBLE))
      comment: "Average repair cost per failure"
    - name: "total_downtime_minutes"
      expr: SUM(CAST(downtime_duration_minutes AS DOUBLE))
      comment: "Total downtime in minutes caused by failures"
    - name: "avg_downtime_minutes"
      expr: AVG(CAST(downtime_duration_minutes AS DOUBLE))
      comment: "Average downtime per failure in minutes"
    - name: "total_production_units_lost"
      expr: SUM(CAST(production_units_lost AS DOUBLE))
      comment: "Total production units lost due to failures"
    - name: "avg_production_units_lost"
      expr: AVG(CAST(production_units_lost AS DOUBLE))
      comment: "Average production units lost per failure"
    - name: "total_mtbf_contribution_hours"
      expr: SUM(CAST(mtbf_contribution_hours AS DOUBLE))
      comment: "Total MTBF contribution hours across all failures"
    - name: "avg_mtbf_contribution_hours"
      expr: AVG(CAST(mtbf_contribution_hours AS DOUBLE))
      comment: "Average MTBF contribution hours per failure"
    - name: "capa_required_count"
      expr: SUM(CASE WHEN capa_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of failures requiring corrective action"
    - name: "safety_incident_count"
      expr: SUM(CASE WHEN safety_incident_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of failures involving safety incidents"
    - name: "environmental_incident_count"
      expr: SUM(CASE WHEN environmental_incident_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of failures involving environmental incidents"
    - name: "spare_part_consumed_count"
      expr: SUM(CASE WHEN spare_part_consumed_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of failures requiring spare part consumption"
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`asset_pm_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Preventive maintenance schedule metrics tracking PM compliance, planning accuracy, and maintenance efficiency"
  source: "`vibe_manufacturing_v1`.`asset`.`pm_schedule`"
  dimensions:
    - name: "schedule_status"
      expr: schedule_status
      comment: "Current status of PM schedule"
    - name: "maintenance_type"
      expr: maintenance_type
      comment: "Type of preventive maintenance"
    - name: "trigger_type"
      expr: trigger_type
      comment: "Trigger type for PM schedule (time-based, meter-based, etc.)"
    - name: "frequency_unit"
      expr: frequency_unit
      comment: "Unit of frequency (days, weeks, months, etc.)"
    - name: "priority"
      expr: priority
      comment: "Priority level of PM schedule"
    - name: "tpm_pillar"
      expr: tpm_pillar
      comment: "Total Productive Maintenance pillar"
    - name: "is_regulatory_required"
      expr: is_regulatory_required
      comment: "Flag indicating if PM is regulatory required"
    - name: "is_safety_critical"
      expr: is_safety_critical
      comment: "Flag indicating if PM is safety critical"
    - name: "shutdown_required"
      expr: shutdown_required
      comment: "Flag indicating if shutdown is required for PM"
    - name: "spare_parts_required"
      expr: spare_parts_required
      comment: "Flag indicating if spare parts are required"
    - name: "work_center_code"
      expr: work_center_code
      comment: "Work center responsible for PM"
    - name: "effective_start_year"
      expr: YEAR(effective_start_date)
      comment: "Year PM schedule became effective"
    - name: "next_due_month"
      expr: DATE_TRUNC('MONTH', next_due_date)
      comment: "Month when next PM is due"
  measures:
    - name: "total_pm_schedules"
      expr: COUNT(1)
      comment: "Total number of PM schedules"
    - name: "total_estimated_material_cost"
      expr: SUM(CAST(estimated_material_cost AS DOUBLE))
      comment: "Total estimated material cost for all PM schedules"
    - name: "avg_estimated_material_cost"
      expr: AVG(CAST(estimated_material_cost AS DOUBLE))
      comment: "Average estimated material cost per PM schedule"
    - name: "total_estimated_duration_hours"
      expr: SUM(CAST(estimated_duration_hours AS DOUBLE))
      comment: "Total estimated duration in hours for all PM schedules"
    - name: "avg_estimated_duration_hours"
      expr: AVG(CAST(estimated_duration_hours AS DOUBLE))
      comment: "Average estimated duration per PM schedule in hours"
    - name: "total_estimated_downtime_hours"
      expr: SUM(CAST(estimated_downtime_hours AS DOUBLE))
      comment: "Total estimated downtime in hours for all PM schedules"
    - name: "avg_estimated_downtime_hours"
      expr: AVG(CAST(estimated_downtime_hours AS DOUBLE))
      comment: "Average estimated downtime per PM schedule in hours"
    - name: "avg_frequency_value"
      expr: AVG(CAST(frequency_value AS DOUBLE))
      comment: "Average frequency value across PM schedules"
    - name: "avg_next_due_meter_reading"
      expr: AVG(CAST(next_due_meter_reading AS DOUBLE))
      comment: "Average next due meter reading for meter-based PM"
    - name: "avg_condition_threshold_value"
      expr: AVG(CAST(condition_threshold_value AS DOUBLE))
      comment: "Average condition threshold value for condition-based PM"
    - name: "regulatory_required_count"
      expr: SUM(CASE WHEN is_regulatory_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of PM schedules that are regulatory required"
    - name: "safety_critical_count"
      expr: SUM(CASE WHEN is_safety_critical = TRUE THEN 1 ELSE 0 END)
      comment: "Count of PM schedules that are safety critical"
    - name: "shutdown_required_count"
      expr: SUM(CASE WHEN shutdown_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of PM schedules requiring shutdown"
    - name: "spare_parts_required_count"
      expr: SUM(CASE WHEN spare_parts_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of PM schedules requiring spare parts"
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`asset_spare_part`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Spare part inventory metrics tracking stock levels, consumption patterns, and inventory value"
  source: "`vibe_manufacturing_v1`.`asset`.`spare_part`"
  dimensions:
    - name: "part_status"
      expr: part_status
      comment: "Current status of spare part"
    - name: "part_type"
      expr: part_type
      comment: "Type classification of spare part"
    - name: "abc_class"
      expr: abc_class
      comment: "ABC classification for inventory management"
    - name: "criticality_class"
      expr: criticality_class
      comment: "Criticality classification of spare part"
    - name: "equipment_category"
      expr: equipment_category
      comment: "Equipment category the part belongs to"
    - name: "equipment_class_code"
      expr: equipment_class_code
      comment: "Equipment class code"
    - name: "mro_category"
      expr: mro_category
      comment: "Maintenance, repair, and operations category"
    - name: "procurement_type"
      expr: procurement_type
      comment: "Procurement type for spare part"
    - name: "manufacturer_name"
      expr: manufacturer_name
      comment: "Manufacturer of spare part"
    - name: "material_group_code"
      expr: material_group_code
      comment: "Material group code"
    - name: "valuation_class"
      expr: valuation_class
      comment: "Valuation class for accounting"
    - name: "hazardous_material_flag"
      expr: hazardous_material_flag
      comment: "Flag indicating if part is hazardous material"
    - name: "capex_asset_flag"
      expr: capex_asset_flag
      comment: "Flag indicating if part is capitalized asset"
    - name: "quality_inspection_required"
      expr: quality_inspection_required
      comment: "Flag indicating if quality inspection is required"
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for spare part"
  measures:
    - name: "total_spare_parts"
      expr: COUNT(1)
      comment: "Total number of unique spare parts in catalog"
    - name: "total_standard_cost"
      expr: SUM(CAST(standard_cost AS DOUBLE))
      comment: "Total standard cost value of all spare parts"
    - name: "avg_standard_cost"
      expr: AVG(CAST(standard_cost AS DOUBLE))
      comment: "Average standard cost per spare part"
    - name: "total_last_purchase_price"
      expr: SUM(CAST(last_purchase_price AS DOUBLE))
      comment: "Total last purchase price across all spare parts"
    - name: "avg_last_purchase_price"
      expr: AVG(CAST(last_purchase_price AS DOUBLE))
      comment: "Average last purchase price per spare part"
    - name: "total_safety_stock_qty"
      expr: SUM(CAST(safety_stock_qty AS DOUBLE))
      comment: "Total safety stock quantity across all spare parts"
    - name: "avg_safety_stock_qty"
      expr: AVG(CAST(safety_stock_qty AS DOUBLE))
      comment: "Average safety stock quantity per spare part"
    - name: "total_reorder_point"
      expr: SUM(CAST(reorder_point AS DOUBLE))
      comment: "Total reorder point quantity across all spare parts"
    - name: "avg_reorder_point"
      expr: AVG(CAST(reorder_point AS DOUBLE))
      comment: "Average reorder point per spare part"
    - name: "total_max_stock_qty"
      expr: SUM(CAST(max_stock_qty AS DOUBLE))
      comment: "Total maximum stock quantity across all spare parts"
    - name: "avg_max_stock_qty"
      expr: AVG(CAST(max_stock_qty AS DOUBLE))
      comment: "Average maximum stock quantity per spare part"
    - name: "total_minimum_order_qty"
      expr: SUM(CAST(minimum_order_qty AS DOUBLE))
      comment: "Total minimum order quantity across all spare parts"
    - name: "avg_minimum_order_qty"
      expr: AVG(CAST(minimum_order_qty AS DOUBLE))
      comment: "Average minimum order quantity per spare part"
    - name: "total_average_annual_consumption"
      expr: SUM(CAST(average_annual_consumption AS DOUBLE))
      comment: "Total average annual consumption across all spare parts"
    - name: "avg_average_annual_consumption"
      expr: AVG(CAST(average_annual_consumption AS DOUBLE))
      comment: "Average annual consumption per spare part"
    - name: "avg_weight_kg"
      expr: AVG(CAST(weight_kg AS DOUBLE))
      comment: "Average weight per spare part in kilograms"
    - name: "hazardous_material_count"
      expr: SUM(CASE WHEN hazardous_material_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of spare parts classified as hazardous material"
    - name: "capex_asset_count"
      expr: SUM(CASE WHEN capex_asset_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of spare parts classified as capital assets"
    - name: "quality_inspection_required_count"
      expr: SUM(CASE WHEN quality_inspection_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of spare parts requiring quality inspection"
$$;