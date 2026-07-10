-- Metric views for domain: asset | Business: Manufacturing | Version: 2 | Generated on: 2026-07-10 14:39:56

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`asset_work_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Work order execution and cost performance metrics for maintenance and repair operations"
  source: "`vibe_manufacturing_v1`.`asset`.`asset_work_order`"
  dimensions:
    - name: "work_order_status"
      expr: work_order_status
      comment: "Current status of the work order (e.g., open, in progress, completed, cancelled)"
    - name: "work_order_source"
      expr: work_order_source
      comment: "Origin of the work order (e.g., preventive maintenance, breakdown, inspection)"
    - name: "priority"
      expr: priority
      comment: "Work order priority level indicating urgency"
    - name: "asset_criticality"
      expr: asset_criticality
      comment: "Criticality classification of the asset being maintained"
    - name: "capex_opex_classification"
      expr: capex_opex_classification
      comment: "Financial classification as capital or operational expenditure"
    - name: "is_production_impacting"
      expr: is_production_impacting
      comment: "Flag indicating whether work order impacts production operations"
    - name: "craft_type"
      expr: craft_type
      comment: "Type of craft or trade required for the work"
    - name: "tpm_pillar"
      expr: tpm_pillar
      comment: "Total Productive Maintenance pillar classification"
    - name: "completion_year"
      expr: YEAR(actual_finish_date)
      comment: "Year when work order was completed"
    - name: "completion_month"
      expr: DATE_TRUNC('MONTH', actual_finish_date)
      comment: "Month when work order was completed"
    - name: "planned_start_year"
      expr: YEAR(planned_start_date)
      comment: "Year when work order was planned to start"
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
    - name: "total_actual_labor_hours"
      expr: SUM(CAST(actual_labor_hours AS DOUBLE))
      comment: "Total actual labor hours consumed across all work orders"
    - name: "total_planned_labor_hours"
      expr: SUM(CAST(planned_labor_hours AS DOUBLE))
      comment: "Total planned labor hours across all work orders"
    - name: "total_downtime_hours"
      expr: SUM(CAST(downtime_duration_hours AS DOUBLE))
      comment: "Total equipment downtime hours caused by work orders"
    - name: "avg_actual_labor_cost"
      expr: AVG(CAST(actual_labor_cost AS DOUBLE))
      comment: "Average actual labor cost per work order"
    - name: "avg_downtime_hours"
      expr: AVG(CAST(downtime_duration_hours AS DOUBLE))
      comment: "Average downtime hours per work order"
    - name: "labor_cost_variance_pct"
      expr: ROUND(100.0 * (SUM(CAST(actual_labor_cost AS DOUBLE)) - SUM(CAST(total_estimated_cost AS DOUBLE))) / NULLIF(SUM(CAST(total_estimated_cost AS DOUBLE)), 0), 2)
      comment: "Percentage variance between actual labor cost and estimated total cost"
    - name: "production_impacting_work_orders"
      expr: SUM(CASE WHEN is_production_impacting = TRUE THEN 1 ELSE 0 END)
      comment: "Count of work orders that impacted production operations"
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`asset_equipment_register`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Equipment asset performance and reliability metrics for maintenance strategy optimization"
  source: "`vibe_manufacturing_v1`.`asset`.`equipment_register`"
  dimensions:
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the equipment"
    - name: "asset_category"
      expr: asset_category
      comment: "Category classification of the asset"
    - name: "equipment_class"
      expr: equipment_class
      comment: "Equipment class grouping"
    - name: "criticality_ranking"
      expr: criticality_ranking
      comment: "Criticality ranking for maintenance prioritization"
    - name: "maintenance_strategy"
      expr: maintenance_strategy
      comment: "Assigned maintenance strategy (e.g., preventive, predictive, run-to-failure)"
    - name: "safety_classification"
      expr: safety_classification
      comment: "Safety classification level of the equipment"
    - name: "condition_grade"
      expr: condition_grade
      comment: "Current condition grade assessment"
    - name: "manufacturer_name"
      expr: manufacturer_name
      comment: "Equipment manufacturer name"
    - name: "commissioning_year"
      expr: YEAR(commissioning_date)
      comment: "Year when equipment was commissioned"
  measures:
    - name: "total_equipment_count"
      expr: COUNT(1)
      comment: "Total number of equipment assets in the register"
    - name: "total_replacement_value"
      expr: SUM(CAST(replacement_value AS DOUBLE))
      comment: "Total replacement value of all equipment assets"
    - name: "avg_replacement_value"
      expr: AVG(CAST(replacement_value AS DOUBLE))
      comment: "Average replacement value per equipment asset"
    - name: "total_rated_capacity"
      expr: SUM(CAST(rated_capacity AS DOUBLE))
      comment: "Total rated capacity across all equipment"
    - name: "avg_mean_time_between_failures"
      expr: AVG(CAST(mean_time_between_failures AS DOUBLE))
      comment: "Average mean time between failures across equipment fleet"
    - name: "avg_mean_time_to_repair"
      expr: AVG(CAST(mean_time_to_repair AS DOUBLE))
      comment: "Average mean time to repair across equipment fleet"
    - name: "equipment_availability_ratio"
      expr: ROUND(AVG(CAST(mean_time_between_failures AS DOUBLE)) / NULLIF(AVG(CAST(mean_time_between_failures AS DOUBLE)) + AVG(CAST(mean_time_to_repair AS DOUBLE)), 0), 4)
      comment: "Equipment availability ratio calculated from MTBF and MTTR averages"
    - name: "total_power_rating_kw"
      expr: SUM(CAST(power_rating_kw AS DOUBLE))
      comment: "Total power rating in kilowatts across all equipment"
    - name: "avg_power_rating_kw"
      expr: AVG(CAST(power_rating_kw AS DOUBLE))
      comment: "Average power rating per equipment asset"
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`asset_failure_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Equipment failure analysis and risk metrics for reliability improvement and FMEA"
  source: "`vibe_manufacturing_v1`.`asset`.`failure_record`"
  dimensions:
    - name: "failure_class_code"
      expr: failure_class_code
      comment: "Failure class code for categorization"
    - name: "failure_mode_code"
      expr: failure_mode_code
      comment: "Failure mode code identifying the type of failure"
    - name: "failure_cause_code"
      expr: failure_cause_code
      comment: "Root cause code of the failure"
    - name: "failure_impact_type"
      expr: failure_impact_type
      comment: "Type of impact caused by the failure (e.g., safety, production, quality)"
    - name: "severity_rating"
      expr: severity_rating
      comment: "Severity rating from FMEA analysis"
    - name: "occurrence_rating"
      expr: occurrence_rating
      comment: "Occurrence rating from FMEA analysis"
    - name: "detection_rating"
      expr: detection_rating
      comment: "Detection rating from FMEA analysis"
    - name: "detection_method_code"
      expr: detection_method_code
      comment: "Method by which the failure was detected"
    - name: "maintenance_type"
      expr: maintenance_type
      comment: "Type of maintenance performed to remedy the failure"
    - name: "safety_incident_flag"
      expr: safety_incident_flag
      comment: "Flag indicating whether failure resulted in a safety incident"
    - name: "environmental_incident_flag"
      expr: environmental_incident_flag
      comment: "Flag indicating whether failure resulted in an environmental incident"
    - name: "capa_required_flag"
      expr: capa_required_flag
      comment: "Flag indicating whether corrective and preventive action is required"
    - name: "failure_year"
      expr: YEAR(failure_datetime)
      comment: "Year when failure occurred"
    - name: "failure_month"
      expr: DATE_TRUNC('MONTH', failure_datetime)
      comment: "Month when failure occurred"
  measures:
    - name: "total_failures"
      expr: COUNT(1)
      comment: "Total number of equipment failures recorded"
    - name: "total_downtime_minutes"
      expr: SUM(CAST(downtime_duration_minutes AS DOUBLE))
      comment: "Total downtime in minutes caused by failures"
    - name: "avg_downtime_minutes"
      expr: AVG(CAST(downtime_duration_minutes AS DOUBLE))
      comment: "Average downtime per failure event in minutes"
    - name: "total_repair_cost"
      expr: SUM(CAST(repair_cost AS DOUBLE))
      comment: "Total cost of repairs across all failures"
    - name: "avg_repair_cost"
      expr: AVG(CAST(repair_cost AS DOUBLE))
      comment: "Average repair cost per failure event"
    - name: "total_production_units_lost"
      expr: SUM(CAST(production_units_lost AS DOUBLE))
      comment: "Total production units lost due to failures"
    - name: "avg_production_units_lost"
      expr: AVG(CAST(production_units_lost AS DOUBLE))
      comment: "Average production units lost per failure event"
    - name: "total_mtbf_contribution_hours"
      expr: SUM(CAST(mtbf_contribution_hours AS DOUBLE))
      comment: "Total hours contributing to mean time between failures calculation"
    - name: "safety_incident_count"
      expr: SUM(CASE WHEN safety_incident_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of failures that resulted in safety incidents"
    - name: "environmental_incident_count"
      expr: SUM(CASE WHEN environmental_incident_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of failures that resulted in environmental incidents"
    - name: "capa_required_count"
      expr: SUM(CASE WHEN capa_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of failures requiring corrective and preventive action"
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`asset_pm_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Preventive maintenance schedule compliance and effectiveness metrics for maintenance planning optimization"
  source: "`vibe_manufacturing_v1`.`asset`.`pm_schedule`"
  dimensions:
    - name: "schedule_status"
      expr: schedule_status
      comment: "Current status of the PM schedule"
    - name: "maintenance_type"
      expr: maintenance_type
      comment: "Type of preventive maintenance (e.g., time-based, condition-based, predictive)"
    - name: "trigger_type"
      expr: trigger_type
      comment: "Trigger mechanism for the PM schedule (e.g., calendar, meter, condition)"
    - name: "frequency_unit"
      expr: frequency_unit
      comment: "Unit of frequency for PM schedule (e.g., days, weeks, months, cycles)"
    - name: "priority"
      expr: priority
      comment: "Priority level of the PM schedule"
    - name: "tpm_pillar"
      expr: tpm_pillar
      comment: "Total Productive Maintenance pillar classification"
    - name: "is_regulatory_required"
      expr: is_regulatory_required
      comment: "Flag indicating whether PM is required by regulation"
    - name: "is_safety_critical"
      expr: is_safety_critical
      comment: "Flag indicating whether PM is safety-critical"
    - name: "shutdown_required"
      expr: shutdown_required
      comment: "Flag indicating whether equipment shutdown is required for PM"
    - name: "spare_parts_required"
      expr: spare_parts_required
      comment: "Flag indicating whether spare parts are required for PM"
    - name: "effective_start_year"
      expr: YEAR(effective_start_date)
      comment: "Year when PM schedule became effective"
  measures:
    - name: "total_pm_schedules"
      expr: COUNT(1)
      comment: "Total number of preventive maintenance schedules"
    - name: "total_estimated_duration_hours"
      expr: SUM(CAST(estimated_duration_hours AS DOUBLE))
      comment: "Total estimated duration hours across all PM schedules"
    - name: "avg_estimated_duration_hours"
      expr: AVG(CAST(estimated_duration_hours AS DOUBLE))
      comment: "Average estimated duration per PM schedule"
    - name: "total_estimated_downtime_hours"
      expr: SUM(CAST(estimated_downtime_hours AS DOUBLE))
      comment: "Total estimated downtime hours across all PM schedules"
    - name: "avg_estimated_downtime_hours"
      expr: AVG(CAST(estimated_downtime_hours AS DOUBLE))
      comment: "Average estimated downtime per PM schedule"
    - name: "total_estimated_material_cost"
      expr: SUM(CAST(estimated_material_cost AS DOUBLE))
      comment: "Total estimated material cost across all PM schedules"
    - name: "avg_estimated_material_cost"
      expr: AVG(CAST(estimated_material_cost AS DOUBLE))
      comment: "Average estimated material cost per PM schedule"
    - name: "regulatory_required_count"
      expr: SUM(CASE WHEN is_regulatory_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of PM schedules required by regulation"
    - name: "safety_critical_count"
      expr: SUM(CASE WHEN is_safety_critical = TRUE THEN 1 ELSE 0 END)
      comment: "Count of safety-critical PM schedules"
    - name: "shutdown_required_count"
      expr: SUM(CASE WHEN shutdown_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of PM schedules requiring equipment shutdown"
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`asset_spare_part`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Spare parts inventory optimization and criticality metrics for MRO supply chain management"
  source: "`vibe_manufacturing_v1`.`asset`.`spare_part`"
  dimensions:
    - name: "part_status"
      expr: part_status
      comment: "Current status of the spare part (e.g., active, obsolete, superseded)"
    - name: "part_type"
      expr: part_type
      comment: "Type classification of the spare part"
    - name: "abc_class"
      expr: abc_class
      comment: "ABC classification for inventory prioritization"
    - name: "criticality_class"
      expr: criticality_class
      comment: "Criticality classification for maintenance operations"
    - name: "mro_category"
      expr: mro_category
      comment: "Maintenance, repair, and operations category"
    - name: "procurement_type"
      expr: procurement_type
      comment: "Procurement type (e.g., stock, non-stock, consignment)"
    - name: "equipment_class_code"
      expr: equipment_class_code
      comment: "Equipment class code for which the part is used"
    - name: "maintenance_strategy"
      expr: maintenance_strategy
      comment: "Maintenance strategy associated with the spare part"
    - name: "hazardous_material_flag"
      expr: hazardous_material_flag
      comment: "Flag indicating whether the part is hazardous material"
    - name: "quality_inspection_required"
      expr: quality_inspection_required
      comment: "Flag indicating whether quality inspection is required upon receipt"
    - name: "capex_asset_flag"
      expr: capex_asset_flag
      comment: "Flag indicating whether the part is capitalized as an asset"
  measures:
    - name: "total_spare_parts"
      expr: COUNT(1)
      comment: "Total number of unique spare parts in the catalog"
    - name: "total_standard_cost"
      expr: SUM(CAST(standard_cost AS DOUBLE))
      comment: "Total standard cost value across all spare parts"
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
    - name: "total_reorder_point"
      expr: SUM(CAST(reorder_point AS DOUBLE))
      comment: "Total reorder point quantity across all spare parts"
    - name: "total_max_stock_qty"
      expr: SUM(CAST(max_stock_qty AS DOUBLE))
      comment: "Total maximum stock quantity across all spare parts"
    - name: "avg_annual_consumption"
      expr: AVG(CAST(average_annual_consumption AS DOUBLE))
      comment: "Average annual consumption per spare part"
    - name: "total_annual_consumption"
      expr: SUM(CAST(average_annual_consumption AS DOUBLE))
      comment: "Total annual consumption across all spare parts"
    - name: "hazardous_parts_count"
      expr: SUM(CASE WHEN hazardous_material_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of spare parts classified as hazardous materials"
    - name: "inspection_required_count"
      expr: SUM(CASE WHEN quality_inspection_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of spare parts requiring quality inspection"
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`asset_calibration_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Instrument calibration compliance and quality metrics for regulatory adherence and measurement system analysis"
  source: "`vibe_manufacturing_v1`.`asset`.`calibration_record`"
  dimensions:
    - name: "calibration_status"
      expr: calibration_status
      comment: "Current status of the calibration record (e.g., pass, fail, conditional)"
    - name: "calibration_type"
      expr: calibration_type
      comment: "Type of calibration performed (e.g., initial, periodic, post-repair)"
    - name: "calibration_method"
      expr: calibration_method
      comment: "Method or procedure used for calibration"
    - name: "instrument_type"
      expr: instrument_type
      comment: "Type of instrument being calibrated"
    - name: "measurement_parameter"
      expr: measurement_parameter
      comment: "Parameter being measured (e.g., temperature, pressure, flow)"
    - name: "measurement_unit"
      expr: measurement_unit
      comment: "Unit of measurement for the calibration"
    - name: "calibration_lab"
      expr: calibration_lab
      comment: "Laboratory or facility where calibration was performed"
    - name: "adjustment_made"
      expr: adjustment_made
      comment: "Flag indicating whether adjustment was made during calibration"
    - name: "out_of_service"
      expr: out_of_service
      comment: "Flag indicating whether instrument was taken out of service"
    - name: "calibration_year"
      expr: YEAR(calibration_date)
      comment: "Year when calibration was performed"
    - name: "calibration_month"
      expr: DATE_TRUNC('MONTH', calibration_date)
      comment: "Month when calibration was performed"
  measures:
    - name: "total_calibrations"
      expr: COUNT(1)
      comment: "Total number of calibration records"
    - name: "avg_as_found_error"
      expr: AVG(CAST(as_found_error AS DOUBLE))
      comment: "Average as-found error across all calibrations"
    - name: "avg_as_left_error"
      expr: AVG(CAST(as_left_error AS DOUBLE))
      comment: "Average as-left error after calibration"
    - name: "avg_measurement_uncertainty"
      expr: AVG(CAST(measurement_uncertainty AS DOUBLE))
      comment: "Average measurement uncertainty across calibrations"
    - name: "calibrations_with_adjustment"
      expr: SUM(CASE WHEN adjustment_made = TRUE THEN 1 ELSE 0 END)
      comment: "Count of calibrations where adjustment was required"
    - name: "instruments_out_of_service"
      expr: SUM(CASE WHEN out_of_service = TRUE THEN 1 ELSE 0 END)
      comment: "Count of instruments taken out of service due to calibration failure"
    - name: "adjustment_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN adjustment_made = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of calibrations requiring adjustment"
    - name: "out_of_service_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN out_of_service = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of calibrations resulting in out-of-service status"
    - name: "avg_environmental_temperature_c"
      expr: AVG(CAST(environmental_temperature_c AS DOUBLE))
      comment: "Average environmental temperature during calibration"
    - name: "avg_environmental_humidity_pct"
      expr: AVG(CAST(environmental_humidity_pct AS DOUBLE))
      comment: "Average environmental humidity during calibration"
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`asset_plant`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Plant-level operational efficiency and sustainability metrics for facility management and ESG reporting"
  source: "`vibe_manufacturing_v1`.`asset`.`asset_plant`"
  dimensions:
    - name: "plant_type"
      expr: plant_type
      comment: "Type classification of the plant facility"
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle status of the plant (e.g., operational, under construction, decommissioned)"
    - name: "maintenance_strategy"
      expr: maintenance_strategy
      comment: "Maintenance strategy employed at the plant"
    - name: "maintenance_contract_status"
      expr: maintenance_contract_status
      comment: "Status of maintenance contracts for the plant"
    - name: "country_code"
      expr: country_code
      comment: "Country code where the plant is located"
    - name: "state_province"
      expr: state_province
      comment: "State or province where the plant is located"
    - name: "city"
      expr: city
      comment: "City where the plant is located"
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost center code for financial tracking"
    - name: "operational_start_year"
      expr: YEAR(operational_start_date)
      comment: "Year when plant became operational"
  measures:
    - name: "total_plants"
      expr: COUNT(1)
      comment: "Total number of plant facilities"
    - name: "total_area_sq_m"
      expr: SUM(CAST(area_sq_m AS DOUBLE))
      comment: "Total plant area in square meters"
    - name: "avg_area_sq_m"
      expr: AVG(CAST(area_sq_m AS DOUBLE))
      comment: "Average plant area in square meters"
    - name: "total_capacity_units_per_year"
      expr: SUM(CAST(capacity_units_per_year AS DOUBLE))
      comment: "Total production capacity across all plants in units per year"
    - name: "avg_capacity_units_per_year"
      expr: AVG(CAST(capacity_units_per_year AS DOUBLE))
      comment: "Average production capacity per plant in units per year"
    - name: "total_emissions_co2_tons"
      expr: SUM(CAST(emissions_co2_tons AS DOUBLE))
      comment: "Total CO2 emissions in tons across all plants for ESG reporting"
    - name: "avg_emissions_co2_tons"
      expr: AVG(CAST(emissions_co2_tons AS DOUBLE))
      comment: "Average CO2 emissions per plant in tons"
    - name: "total_energy_consumption_mwh"
      expr: SUM(CAST(energy_consumption_mwh AS DOUBLE))
      comment: "Total energy consumption in megawatt-hours across all plants"
    - name: "avg_energy_consumption_mwh"
      expr: AVG(CAST(energy_consumption_mwh AS DOUBLE))
      comment: "Average energy consumption per plant in megawatt-hours"
    - name: "energy_intensity_mwh_per_sqm"
      expr: ROUND(SUM(CAST(energy_consumption_mwh AS DOUBLE)) / NULLIF(SUM(CAST(area_sq_m AS DOUBLE)), 0), 4)
      comment: "Energy intensity ratio of total energy consumption to total plant area"
    - name: "carbon_intensity_tons_per_unit"
      expr: ROUND(SUM(CAST(emissions_co2_tons AS DOUBLE)) / NULLIF(SUM(CAST(capacity_units_per_year AS DOUBLE)), 0), 6)
      comment: "Carbon intensity ratio of CO2 emissions to production capacity"
$$;