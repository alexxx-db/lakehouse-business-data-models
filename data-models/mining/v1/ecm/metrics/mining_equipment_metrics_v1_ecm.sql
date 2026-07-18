-- Metric views for domain: equipment | Business: Mining | Version: 1 | Generated on: 2026-05-05 10:43:42

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`equipment_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core asset inventory and capital metrics for mobile and fixed equipment across mining operations"
  source: "`mining_ecm`.`equipment`.`asset`"
  dimensions:
    - name: "asset_name"
      expr: asset_name
      comment: "Unique name identifier for the asset"
    - name: "asset_class_id"
      expr: asset_class_id
      comment: "Foreign key to asset class for equipment categorization"
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the asset (e.g., Active, Standby, Decommissioned)"
    - name: "criticality_rating"
      expr: criticality_rating
      comment: "Business criticality rating for prioritization and risk management"
    - name: "site_code"
      expr: site_code
      comment: "Mine site where the asset is deployed"
    - name: "is_mobile"
      expr: is_mobile
      comment: "Flag indicating whether the asset is mobile equipment (True) or fixed plant (False)"
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership model (e.g., Owned, Leased, Contractor-supplied)"
    - name: "fuel_type"
      expr: fuel_type
      comment: "Primary fuel type for mobile equipment (Diesel, Electric, Hybrid)"
    - name: "fleet_number"
      expr: fleet_number
      comment: "Fleet identification number for operational tracking"
    - name: "model"
      expr: model
      comment: "Equipment model designation from OEM"
    - name: "manufacture_year"
      expr: manufacture_year
      comment: "Year of manufacture for age analysis"
    - name: "commissioning_year"
      expr: YEAR(commissioning_date)
      comment: "Year the asset was commissioned into service"
    - name: "commissioning_month"
      expr: DATE_TRUNC('MONTH', commissioning_date)
      comment: "Month the asset was commissioned for cohort analysis"
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost center for financial allocation and reporting"
  measures:
    - name: "total_asset_count"
      expr: COUNT(1)
      comment: "Total number of assets in the register"
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total capital invested in asset acquisition"
    - name: "avg_acquisition_cost"
      expr: AVG(CAST(acquisition_cost AS DOUBLE))
      comment: "Average acquisition cost per asset for benchmarking"
    - name: "total_payload_capacity_tonnes"
      expr: SUM(CAST(payload_capacity_tonnes AS DOUBLE))
      comment: "Total payload capacity across fleet for production planning"
    - name: "avg_payload_capacity_tonnes"
      expr: AVG(CAST(payload_capacity_tonnes AS DOUBLE))
      comment: "Average payload capacity per asset"
    - name: "total_engine_power_kw"
      expr: SUM(CAST(engine_power_kw AS DOUBLE))
      comment: "Total installed engine power across fleet"
    - name: "avg_operating_weight_tonnes"
      expr: AVG(CAST(operating_weight_tonnes AS DOUBLE))
      comment: "Average operating weight for fleet composition analysis"
    - name: "total_fuel_tank_capacity_litres"
      expr: SUM(CAST(fuel_tank_capacity_litres AS DOUBLE))
      comment: "Total fuel storage capacity across mobile fleet"
    - name: "avg_smr_hours"
      expr: AVG(CAST(smr_hours AS DOUBLE))
      comment: "Average service meter reading hours for fleet age assessment"
    - name: "avg_odometer_km"
      expr: AVG(CAST(odometer_km AS DOUBLE))
      comment: "Average odometer reading for mobile equipment utilization"
$$;


CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`equipment_downtime_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Equipment downtime and availability metrics for maintenance optimization and production planning"
  source: "`mining_ecm`.`equipment`.`downtime_event`"
  dimensions:
    - name: "asset_id"
      expr: asset_id
      comment: "Asset experiencing downtime"
    - name: "downtime_category"
      expr: downtime_category
      comment: "High-level downtime classification (Mechanical, Electrical, Operational, etc.)"
    - name: "downtime_reason_code"
      expr: downtime_reason_code
      comment: "Detailed reason code for root cause analysis"
    - name: "downtime_status"
      expr: downtime_status
      comment: "Current status of the downtime event (Open, In Progress, Resolved)"
    - name: "maintenance_type"
      expr: maintenance_type
      comment: "Type of maintenance performed (Corrective, Preventive, Predictive)"
    - name: "failure_mode"
      expr: failure_mode
      comment: "Failure mode for reliability engineering analysis"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority assigned to the downtime event"
    - name: "oee_impact_category"
      expr: oee_impact_category
      comment: "OEE impact classification (Availability, Performance, Quality)"
    - name: "is_safety_related"
      expr: is_safety_related
      comment: "Flag indicating safety-related downtime requiring investigation"
    - name: "environmental_impact_flag"
      expr: environmental_impact_flag
      comment: "Flag indicating environmental impact from the downtime event"
    - name: "detection_method"
      expr: detection_method
      comment: "How the downtime was detected (Operator, Sensor, Inspection)"
    - name: "site_id"
      expr: site_id
      comment: "Mine site where downtime occurred"
    - name: "shift_type"
      expr: shift_type
      comment: "Shift during which downtime occurred"
    - name: "downtime_year"
      expr: YEAR(start_timestamp)
      comment: "Year of downtime event for trend analysis"
    - name: "downtime_month"
      expr: DATE_TRUNC('MONTH', start_timestamp)
      comment: "Month of downtime event for seasonality analysis"
  measures:
    - name: "total_downtime_events"
      expr: COUNT(1)
      comment: "Total number of downtime events for frequency analysis"
    - name: "total_downtime_hours"
      expr: SUM(CAST(duration_minutes AS DOUBLE)) / 60.0
      comment: "Total downtime hours impacting production availability"
    - name: "avg_downtime_hours"
      expr: AVG(CAST(duration_minutes AS DOUBLE)) / 60.0
      comment: "Average downtime duration per event for MTTR benchmarking"
    - name: "total_production_tonnes_lost"
      expr: SUM(CAST(production_tonnes_lost AS DOUBLE))
      comment: "Total production lost due to downtime in tonnes"
    - name: "total_production_impact_hours"
      expr: SUM(CAST(production_impact_hours AS DOUBLE))
      comment: "Total production hours lost across all downtime events"
    - name: "total_maintenance_cost"
      expr: SUM(CAST(maintenance_cost AS DOUBLE))
      comment: "Total maintenance cost incurred for downtime resolution"
    - name: "avg_maintenance_cost"
      expr: AVG(CAST(maintenance_cost AS DOUBLE))
      comment: "Average maintenance cost per downtime event"
    - name: "total_actual_repair_hours"
      expr: SUM(CAST(actual_repair_hours AS DOUBLE))
      comment: "Total labor hours spent on repairs"
    - name: "avg_actual_repair_hours"
      expr: AVG(CAST(actual_repair_hours AS DOUBLE))
      comment: "Average repair hours per event for labor planning"
    - name: "total_estimated_repair_hours"
      expr: SUM(CAST(estimated_repair_hours AS DOUBLE))
      comment: "Total estimated repair hours for planning accuracy assessment"
    - name: "distinct_assets_with_downtime"
      expr: COUNT(DISTINCT asset_id)
      comment: "Number of unique assets experiencing downtime for fleet health assessment"
$$;


CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`equipment_fuel_consumption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fuel consumption and emissions metrics for cost control and environmental reporting"
  source: "`mining_ecm`.`equipment`.`fuel_consumption`"
  dimensions:
    - name: "asset_id"
      expr: asset_id
      comment: "Asset consuming fuel"
    - name: "fuel_type"
      expr: fuel_type
      comment: "Type of fuel consumed (Diesel, Petrol, LNG)"
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of fuel transaction (Fill, Top-up, Bulk)"
    - name: "transaction_status"
      expr: transaction_status
      comment: "Status of the fuel transaction (Approved, Pending, Rejected)"
    - name: "dispensing_method"
      expr: dispensing_method
      comment: "Method of fuel dispensing (Bowser, Fixed Tank, Manual)"
    - name: "mine_site_code"
      expr: mine_site_code
      comment: "Mine site where fuel was dispensed"
    - name: "is_anomaly_flagged"
      expr: is_anomaly_flagged
      comment: "Flag indicating anomalous fuel consumption requiring investigation"
    - name: "anomaly_reason"
      expr: anomaly_reason
      comment: "Reason for flagged fuel consumption anomaly"
    - name: "cost_centre_id"
      expr: cost_centre_id
      comment: "Cost center charged for fuel consumption"
    - name: "transaction_year"
      expr: YEAR(transaction_timestamp)
      comment: "Year of fuel transaction for trend analysis"
    - name: "transaction_month"
      expr: DATE_TRUNC('MONTH', transaction_timestamp)
      comment: "Month of fuel transaction for budget tracking"
  measures:
    - name: "total_fuel_transactions"
      expr: COUNT(1)
      comment: "Total number of fuel transactions for activity monitoring"
    - name: "total_fuel_dispensed_litres"
      expr: SUM(CAST(quantity_dispensed_litres AS DOUBLE))
      comment: "Total fuel consumed across fleet in litres"
    - name: "avg_fuel_dispensed_litres"
      expr: AVG(CAST(quantity_dispensed_litres AS DOUBLE))
      comment: "Average fuel dispensed per transaction"
    - name: "total_fuel_cost"
      expr: SUM(CAST(total_fuel_cost AS DOUBLE))
      comment: "Total fuel expenditure for cost control"
    - name: "avg_fuel_cost_per_transaction"
      expr: AVG(CAST(total_fuel_cost AS DOUBLE))
      comment: "Average fuel cost per transaction"
    - name: "avg_unit_cost_per_litre"
      expr: AVG(CAST(unit_cost_per_litre AS DOUBLE))
      comment: "Average fuel price per litre for procurement benchmarking"
    - name: "total_co2e_emissions_kg"
      expr: SUM(CAST(co2e_emissions_kg AS DOUBLE))
      comment: "Total CO2 equivalent emissions for environmental reporting"
    - name: "avg_co2e_emissions_kg"
      expr: AVG(CAST(co2e_emissions_kg AS DOUBLE))
      comment: "Average CO2 emissions per transaction"
    - name: "avg_fuel_burn_rate_l_per_hr"
      expr: AVG(CAST(fuel_burn_rate_l_per_hr AS DOUBLE))
      comment: "Average fuel burn rate for efficiency benchmarking"
    - name: "distinct_assets_fueled"
      expr: COUNT(DISTINCT asset_id)
      comment: "Number of unique assets fueled for fleet coverage analysis"
$$;


CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`equipment_payload_cycle`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Haul truck payload and cycle time metrics for production optimization and fleet efficiency"
  source: "`mining_ecm`.`equipment`.`payload_cycle`"
  dimensions:
    - name: "asset_id"
      expr: asset_id
      comment: "Haul truck performing the payload cycle"
    - name: "cycle_status"
      expr: cycle_status
      comment: "Status of the payload cycle (Completed, In Progress, Aborted)"
    - name: "load_location_name"
      expr: load_location_name
      comment: "Loading location (pit, stockpile, ROM pad)"
    - name: "dump_location_name"
      expr: dump_location_name
      comment: "Dump location (crusher, waste dump, stockpile)"
    - name: "ore_grade_indicator"
      expr: ore_grade_indicator
      comment: "Ore grade classification for material tracking"
    - name: "overload_flag"
      expr: overload_flag
      comment: "Flag indicating payload exceeded safe capacity"
    - name: "payload_measurement_method"
      expr: payload_measurement_method
      comment: "Method used to measure payload (Onboard scale, Loader estimate, Weighbridge)"
    - name: "data_quality_flag"
      expr: data_quality_flag
      comment: "Data quality indicator for cycle record"
    - name: "shift_type"
      expr: shift_type
      comment: "Shift during which cycle occurred"
    - name: "operator_name"
      expr: operator_name
      comment: "Operator performing the haul cycle"
    - name: "production_date"
      expr: production_date
      comment: "Date of production for daily reporting"
    - name: "production_year"
      expr: YEAR(production_date)
      comment: "Year of production for annual analysis"
    - name: "production_month"
      expr: DATE_TRUNC('MONTH', production_date)
      comment: "Month of production for monthly reporting"
  measures:
    - name: "total_payload_cycles"
      expr: COUNT(1)
      comment: "Total number of payload cycles for productivity measurement"
    - name: "total_payload_tonnes"
      expr: SUM(CAST(payload_weight_tonnes AS DOUBLE))
      comment: "Total material hauled in tonnes for production reporting"
    - name: "avg_payload_tonnes"
      expr: AVG(CAST(payload_weight_tonnes AS DOUBLE))
      comment: "Average payload per cycle for truck utilization assessment"
    - name: "total_target_payload_tonnes"
      expr: SUM(CAST(target_payload_tonnes AS DOUBLE))
      comment: "Total target payload for performance comparison"
    - name: "avg_cycle_time_minutes"
      expr: AVG(CAST(cycle_time_minutes AS DOUBLE))
      comment: "Average cycle time for fleet efficiency benchmarking"
    - name: "avg_load_time_minutes"
      expr: AVG(CAST(load_time_minutes AS DOUBLE))
      comment: "Average loading time for loader productivity analysis"
    - name: "avg_haul_time_loaded_minutes"
      expr: AVG(CAST(haul_time_loaded_minutes AS DOUBLE))
      comment: "Average loaded haul time for route optimization"
    - name: "avg_dump_time_minutes"
      expr: AVG(CAST(dump_time_minutes AS DOUBLE))
      comment: "Average dump time for crusher/dump efficiency"
    - name: "avg_return_time_minutes"
      expr: AVG(CAST(return_time_minutes AS DOUBLE))
      comment: "Average empty return time for route planning"
    - name: "avg_queue_time_minutes"
      expr: AVG(CAST(queue_time_minutes AS DOUBLE))
      comment: "Average queue time for dispatch optimization"
    - name: "total_haul_distance_loaded_m"
      expr: SUM(CAST(haul_distance_loaded_m AS DOUBLE))
      comment: "Total loaded haul distance for road maintenance planning"
    - name: "avg_haul_distance_loaded_m"
      expr: AVG(CAST(haul_distance_loaded_m AS DOUBLE))
      comment: "Average loaded haul distance per cycle"
    - name: "total_fuel_consumed_litres"
      expr: SUM(CAST(fuel_consumed_litres AS DOUBLE))
      comment: "Total fuel consumed during payload cycles"
    - name: "avg_fuel_consumed_litres"
      expr: AVG(CAST(fuel_consumed_litres AS DOUBLE))
      comment: "Average fuel consumed per cycle for efficiency tracking"
    - name: "distinct_trucks"
      expr: COUNT(DISTINCT asset_id)
      comment: "Number of unique trucks performing cycles"
$$;


CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`equipment_utilisation_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Equipment utilisation and availability metrics for fleet performance management and capacity planning"
  source: "`mining_ecm`.`equipment`.`utilisation_record`"
  dimensions:
    - name: "asset_id"
      expr: asset_id
      comment: "Asset being measured for utilisation"
    - name: "record_status"
      expr: record_status
      comment: "Status of the utilisation record (Draft, Approved, Reconciled)"
    - name: "record_type"
      expr: record_type
      comment: "Type of utilisation record (Shift, Daily, Weekly)"
    - name: "shift_type"
      expr: shift_type
      comment: "Shift during which utilisation was recorded"
    - name: "operating_zone"
      expr: operating_zone
      comment: "Operating zone or area where asset was deployed"
    - name: "primary_delay_category"
      expr: primary_delay_category
      comment: "Primary delay category impacting utilisation"
    - name: "is_reconciled"
      expr: is_reconciled
      comment: "Flag indicating whether record has been reconciled with production data"
    - name: "data_source"
      expr: data_source
      comment: "Source system for utilisation data (FMS, Manual, Telematics)"
    - name: "site_id"
      expr: site_id
      comment: "Mine site where utilisation was recorded"
    - name: "record_year"
      expr: YEAR(record_date)
      comment: "Year of utilisation record for annual analysis"
    - name: "record_month"
      expr: DATE_TRUNC('MONTH', record_date)
      comment: "Month of utilisation record for monthly reporting"
  measures:
    - name: "total_utilisation_records"
      expr: COUNT(1)
      comment: "Total number of utilisation records for data completeness assessment"
    - name: "total_scheduled_hours"
      expr: SUM(CAST(scheduled_hours AS DOUBLE))
      comment: "Total scheduled operating hours for capacity planning"
    - name: "total_operating_hours"
      expr: SUM(CAST(operating_hours AS DOUBLE))
      comment: "Total actual operating hours for productivity measurement"
    - name: "total_downtime_hours"
      expr: SUM(CAST(downtime_hours AS DOUBLE))
      comment: "Total downtime hours impacting availability"
    - name: "total_idle_hours"
      expr: SUM(CAST(idle_hours AS DOUBLE))
      comment: "Total idle hours for dispatch optimization"
    - name: "total_standby_hours"
      expr: SUM(CAST(standby_hours AS DOUBLE))
      comment: "Total standby hours for fleet sizing analysis"
    - name: "total_delay_hours"
      expr: SUM(CAST(delay_hours AS DOUBLE))
      comment: "Total delay hours for operational improvement"
    - name: "avg_utilisation_pct"
      expr: AVG(CAST(utilisation_pct AS DOUBLE))
      comment: "Average utilisation percentage for fleet performance benchmarking"
    - name: "avg_physical_availability_pct"
      expr: AVG(CAST(physical_availability_pct AS DOUBLE))
      comment: "Average physical availability percentage for maintenance effectiveness"
    - name: "avg_use_of_availability_pct"
      expr: AVG(CAST(use_of_availability_pct AS DOUBLE))
      comment: "Average use of availability percentage for operational effectiveness"
    - name: "avg_oee_score"
      expr: AVG(CAST(oee_score AS DOUBLE))
      comment: "Average OEE score for overall equipment effectiveness"
    - name: "total_payload_tonnes"
      expr: SUM(CAST(payload_tonnes AS DOUBLE))
      comment: "Total payload moved during utilisation period"
    - name: "total_distance_travelled_km"
      expr: SUM(CAST(distance_travelled_km AS DOUBLE))
      comment: "Total distance travelled for road maintenance planning"
    - name: "total_fuel_consumed_litres"
      expr: SUM(CAST(fuel_consumed_litres AS DOUBLE))
      comment: "Total fuel consumed during utilisation period"
    - name: "avg_fuel_burn_rate_lph"
      expr: AVG(CAST(fuel_burn_rate_lph AS DOUBLE))
      comment: "Average fuel burn rate for efficiency benchmarking"
    - name: "total_engine_hours"
      expr: SUM(CAST(engine_hours AS DOUBLE))
      comment: "Total engine hours for maintenance scheduling"
    - name: "distinct_assets_utilised"
      expr: COUNT(DISTINCT asset_id)
      comment: "Number of unique assets with utilisation records"
$$;


CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`equipment_oee_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Overall Equipment Effectiveness (OEE) metrics for world-class maintenance and production performance"
  source: "`mining_ecm`.`equipment`.`oee_record`"
  dimensions:
    - name: "asset_id"
      expr: asset_id
      comment: "Asset being measured for OEE"
    - name: "record_status"
      expr: record_status
      comment: "Status of the OEE record (Draft, Approved, Final)"
    - name: "is_reconciled"
      expr: is_reconciled
      comment: "Flag indicating whether OEE record has been reconciled"
    - name: "data_source"
      expr: data_source
      comment: "Source system for OEE data (SCADA, FMS, Manual)"
    - name: "site_id"
      expr: site_id
      comment: "Mine site where OEE was recorded"
    - name: "production_year"
      expr: YEAR(production_date)
      comment: "Year of OEE record for annual performance analysis"
    - name: "production_month"
      expr: DATE_TRUNC('MONTH', production_date)
      comment: "Month of OEE record for monthly performance tracking"
  measures:
    - name: "total_oee_records"
      expr: COUNT(1)
      comment: "Total number of OEE records for data completeness"
    - name: "avg_oee_rate"
      expr: AVG(CAST(oee_rate AS DOUBLE))
      comment: "Average OEE rate for world-class benchmarking (target 85%+)"
    - name: "avg_availability_rate"
      expr: AVG(CAST(availability_rate AS DOUBLE))
      comment: "Average availability component of OEE for maintenance effectiveness"
    - name: "avg_performance_rate"
      expr: AVG(CAST(performance_rate AS DOUBLE))
      comment: "Average performance component of OEE for speed loss analysis"
    - name: "avg_quality_rate"
      expr: AVG(CAST(quality_rate AS DOUBLE))
      comment: "Average quality component of OEE for defect reduction"
    - name: "total_planned_operating_time_hrs"
      expr: SUM(CAST(planned_operating_time_hrs AS DOUBLE))
      comment: "Total planned operating time for capacity planning"
    - name: "total_actual_operating_time_hrs"
      expr: SUM(CAST(actual_operating_time_hrs AS DOUBLE))
      comment: "Total actual operating time for productivity measurement"
    - name: "total_planned_downtime_hrs"
      expr: SUM(CAST(planned_downtime_hrs AS DOUBLE))
      comment: "Total planned downtime for maintenance scheduling"
    - name: "total_unplanned_downtime_hrs"
      expr: SUM(CAST(unplanned_downtime_hrs AS DOUBLE))
      comment: "Total unplanned downtime for reliability improvement"
    - name: "total_throughput_actual_t"
      expr: SUM(CAST(throughput_actual_t AS DOUBLE))
      comment: "Total actual throughput in tonnes for production reporting"
    - name: "total_throughput_target_t"
      expr: SUM(CAST(throughput_target_t AS DOUBLE))
      comment: "Total target throughput for performance comparison"
    - name: "total_units_produced"
      expr: SUM(CAST(total_units_produced AS BIGINT))
      comment: "Total units produced for volume tracking"
    - name: "total_reject_units"
      expr: SUM(CAST(reject_unit_count AS BIGINT))
      comment: "Total reject units for quality improvement"
    - name: "avg_fuel_efficiency_t_per_l"
      expr: AVG(CAST(fuel_efficiency_t_per_l AS DOUBLE))
      comment: "Average fuel efficiency in tonnes per litre for cost optimization"
    - name: "total_distance_travelled_km"
      expr: SUM(CAST(distance_travelled_km AS DOUBLE))
      comment: "Total distance travelled during OEE period"
    - name: "avg_payload_avg_t"
      expr: AVG(CAST(payload_avg_t AS DOUBLE))
      comment: "Average payload per cycle for truck utilization"
    - name: "distinct_assets_measured"
      expr: COUNT(DISTINCT asset_id)
      comment: "Number of unique assets with OEE records"
$$;


CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`equipment_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Equipment inspection and compliance metrics for safety, regulatory adherence, and defect management"
  source: "`mining_ecm`.`equipment`.`inspection`"
  dimensions:
    - name: "asset_id"
      expr: asset_id
      comment: "Asset being inspected"
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection (Pre-start, Statutory, Condition-based, Audit)"
    - name: "inspection_status"
      expr: inspection_status
      comment: "Status of the inspection (Scheduled, In Progress, Completed, Overdue)"
    - name: "overall_result"
      expr: overall_result
      comment: "Overall inspection result (Pass, Fail, Conditional Pass)"
    - name: "inspection_method"
      expr: inspection_method
      comment: "Method used for inspection (Visual, NDT, Functional Test)"
    - name: "equipment_grounded"
      expr: equipment_grounded
      comment: "Flag indicating whether equipment was grounded due to inspection findings"
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Flag indicating whether corrective action is required"
    - name: "inspector_role"
      expr: inspector_role
      comment: "Role of the inspector (Operator, Technician, Engineer, Third-party)"
    - name: "regulatory_standard"
      expr: regulatory_standard
      comment: "Regulatory standard governing the inspection"
    - name: "shift_type"
      expr: shift_type
      comment: "Shift during which inspection was performed"
    - name: "site_id"
      expr: site_id
      comment: "Mine site where inspection occurred"
    - name: "inspection_year"
      expr: YEAR(start_timestamp)
      comment: "Year of inspection for compliance reporting"
    - name: "inspection_month"
      expr: DATE_TRUNC('MONTH', start_timestamp)
      comment: "Month of inspection for trend analysis"
  measures:
    - name: "total_inspections"
      expr: COUNT(1)
      comment: "Total number of inspections for compliance tracking"
    - name: "total_defect_count_critical"
      expr: SUM(CAST(defect_count_critical AS BIGINT))
      comment: "Total critical defects requiring immediate action"
    - name: "total_defect_count_major"
      expr: SUM(CAST(defect_count_major AS BIGINT))
      comment: "Total major defects requiring planned action"
    - name: "total_defect_count_minor"
      expr: SUM(CAST(defect_count_minor AS BIGINT))
      comment: "Total minor defects for continuous improvement"
    - name: "avg_defect_count_critical"
      expr: AVG(CAST(defect_count_critical AS BIGINT))
      comment: "Average critical defects per inspection"
    - name: "total_checklist_items_completed"
      expr: SUM(CAST(checklist_items_completed AS BIGINT))
      comment: "Total checklist items completed for thoroughness assessment"
    - name: "total_checklist_items_total"
      expr: SUM(CAST(checklist_items_total AS BIGINT))
      comment: "Total checklist items for completion rate calculation"
    - name: "avg_equipment_hours_at_inspection"
      expr: AVG(CAST(equipment_hours_at_inspection AS DOUBLE))
      comment: "Average equipment hours at inspection for interval analysis"
    - name: "distinct_assets_inspected"
      expr: COUNT(DISTINCT asset_id)
      comment: "Number of unique assets inspected for coverage assessment"
    - name: "distinct_inspectors"
      expr: COUNT(DISTINCT inspector_employee_id)
      comment: "Number of unique inspectors for competency planning"
$$;


CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`equipment_drill_activity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Drill rig performance and blast hole quality metrics for mining operations and cost per metre optimization"
  source: "`mining_ecm`.`equipment`.`drill_activity`"
  dimensions:
    - name: "asset_id"
      expr: asset_id
      comment: "Drill rig performing the activity"
    - name: "activity_type"
      expr: activity_type
      comment: "Type of drill activity (Production, Development, Exploration)"
    - name: "activity_status"
      expr: activity_status
      comment: "Status of the drill activity (Completed, In Progress, Aborted)"
    - name: "drill_method"
      expr: drill_method
      comment: "Drilling method used (Rotary, DTH, RC)"
    - name: "rock_type"
      expr: rock_type
      comment: "Rock type encountered for drillability analysis"
    - name: "bit_type"
      expr: bit_type
      comment: "Drill bit type used for consumable optimization"
    - name: "is_sample_collected"
      expr: is_sample_collected
      comment: "Flag indicating whether geological sample was collected"
    - name: "water_encountered"
      expr: water_encountered
      comment: "Flag indicating water encountered during drilling"
    - name: "pit_name"
      expr: pit_name
      comment: "Pit where drilling occurred"
    - name: "bench_level"
      expr: bench_level
      comment: "Bench level where drilling occurred"
    - name: "activity_year"
      expr: YEAR(activity_start_timestamp)
      comment: "Year of drill activity for annual analysis"
    - name: "activity_month"
      expr: DATE_TRUNC('MONTH', activity_start_timestamp)
      comment: "Month of drill activity for monthly reporting"
  measures:
    - name: "total_drill_activities"
      expr: COUNT(1)
      comment: "Total number of drill activities for productivity measurement"
    - name: "total_metres_drilled"
      expr: SUM(CAST(metres_drilled AS DOUBLE))
      comment: "Total metres drilled for production reporting"
    - name: "avg_metres_drilled"
      expr: AVG(CAST(metres_drilled AS DOUBLE))
      comment: "Average metres drilled per hole for performance benchmarking"
    - name: "total_actual_depth_m"
      expr: SUM(CAST(actual_depth_m AS DOUBLE))
      comment: "Total actual depth achieved"
    - name: "total_planned_depth_m"
      expr: SUM(CAST(planned_depth_m AS DOUBLE))
      comment: "Total planned depth for plan vs actual analysis"
    - name: "avg_penetration_rate_m_per_hr"
      expr: AVG(CAST(penetration_rate_m_per_hr AS DOUBLE))
      comment: "Average penetration rate for drill rig efficiency benchmarking"
    - name: "avg_hole_diameter_mm"
      expr: AVG(CAST(hole_diameter_mm AS DOUBLE))
      comment: "Average hole diameter for blast design validation"
    - name: "avg_deviation_from_plan_m"
      expr: AVG(CAST(deviation_from_plan_m AS DOUBLE))
      comment: "Average deviation from planned hole position for quality control"
    - name: "total_fuel_consumed_litres"
      expr: SUM(CAST(fuel_consumed_litres AS DOUBLE))
      comment: "Total fuel consumed during drilling for cost per metre calculation"
    - name: "avg_fuel_consumed_litres"
      expr: AVG(CAST(fuel_consumed_litres AS DOUBLE))
      comment: "Average fuel consumed per hole for efficiency tracking"
    - name: "avg_rock_hardness_index"
      expr: AVG(CAST(rock_hardness_index AS DOUBLE))
      comment: "Average rock hardness for drillability assessment"
    - name: "avg_air_pressure_kpa"
      expr: AVG(CAST(air_pressure_kpa AS DOUBLE))
      comment: "Average air pressure for drilling parameter optimization"
    - name: "avg_pulldown_force_kn"
      expr: AVG(CAST(pulldown_force_kn AS DOUBLE))
      comment: "Average pulldown force for bit life optimization"
    - name: "avg_rotary_speed_rpm"
      expr: AVG(CAST(rotary_speed_rpm AS DOUBLE))
      comment: "Average rotary speed for drilling parameter analysis"
    - name: "distinct_drill_rigs"
      expr: COUNT(DISTINCT asset_id)
      comment: "Number of unique drill rigs active"
$$;
