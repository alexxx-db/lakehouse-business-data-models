-- Metric views for domain: manufacturing | Business: Automotive | Version: 2 | Generated on: 2026-07-14 01:46:32

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`manufacturing_production_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core production order KPIs tracking manufacturing execution, cost variance, and schedule adherence for vehicle production orders"
  source: "`vibe_automotive_v1`.`manufacturing`.`production_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the production order (released, in-progress, completed, technical completion)"
    - name: "order_type"
      expr: order_type
      comment: "Type of production order (standard, rework, prototype, pilot)"
    - name: "model_year"
      expr: model_year
      comment: "Model year of the vehicle being produced"
    - name: "production_stage"
      expr: production_stage
      comment: "Current production stage (body shop, paint, assembly, final inspection)"
    - name: "order_month"
      expr: DATE_TRUNC('MONTH', order_date)
      comment: "Month when the production order was created"
    - name: "planned_finish_month"
      expr: DATE_TRUNC('MONTH', planned_finish_date)
      comment: "Month when the production order is planned to finish"
    - name: "is_sop_order"
      expr: sop_indicator
      comment: "Flag indicating if this is a start-of-production order"
    - name: "is_ppap_required"
      expr: ppap_required
      comment: "Flag indicating if PPAP (Production Part Approval Process) is required"
  measures:
    - name: "total_production_orders"
      expr: COUNT(DISTINCT production_order_id)
      comment: "Total number of unique production orders"
    - name: "total_target_quantity"
      expr: SUM(CAST(target_quantity AS DOUBLE))
      comment: "Total planned production quantity across all orders"
    - name: "total_confirmed_quantity"
      expr: SUM(CAST(confirmed_quantity AS DOUBLE))
      comment: "Total confirmed production quantity across all orders"
    - name: "total_scrap_quantity"
      expr: SUM(CAST(scrap_quantity AS DOUBLE))
      comment: "Total scrap quantity across all production orders"
    - name: "total_rework_quantity"
      expr: SUM(CAST(rework_quantity AS DOUBLE))
      comment: "Total rework quantity across all production orders"
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual manufacturing cost incurred across all production orders"
    - name: "total_standard_cost"
      expr: SUM(CAST(standard_cost AS DOUBLE))
      comment: "Total standard (planned) manufacturing cost across all production orders"
    - name: "avg_actual_labor_hours"
      expr: AVG(CAST(actual_labor_hours AS DOUBLE))
      comment: "Average actual labor hours per production order"
    - name: "avg_planned_labor_hours"
      expr: AVG(CAST(planned_labor_hours AS DOUBLE))
      comment: "Average planned labor hours per production order"
    - name: "first_pass_yield_pct"
      expr: ROUND(100.0 * SUM(CAST(confirmed_quantity AS DOUBLE) - CAST(rework_quantity AS DOUBLE)) / NULLIF(SUM(CAST(confirmed_quantity AS DOUBLE)), 0), 2)
      comment: "First pass yield percentage - ratio of good units to total confirmed units"
    - name: "scrap_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(scrap_quantity AS DOUBLE)) / NULLIF(SUM(CAST(target_quantity AS DOUBLE)), 0), 2)
      comment: "Scrap rate as percentage of target quantity"
    - name: "order_fulfillment_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(confirmed_quantity AS DOUBLE)) / NULLIF(SUM(CAST(target_quantity AS DOUBLE)), 0), 2)
      comment: "Order fulfillment rate - ratio of confirmed to target quantity"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`manufacturing_downtime_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Manufacturing downtime and availability KPIs tracking equipment failures, production losses, and OEE availability impact"
  source: "`vibe_automotive_v1`.`manufacturing`.`downtime_event`"
  dimensions:
    - name: "downtime_category"
      expr: downtime_category
      comment: "Category of downtime (planned, unplanned, changeover, quality hold)"
    - name: "downtime_type"
      expr: downtime_type
      comment: "Specific type of downtime event"
    - name: "event_status"
      expr: event_status
      comment: "Current status of the downtime event (open, in-progress, resolved, closed)"
    - name: "root_cause_code"
      expr: root_cause_code
      comment: "Root cause classification code for the downtime"
    - name: "is_safety_related"
      expr: is_safety_related
      comment: "Flag indicating if downtime was safety-related"
    - name: "is_repeat_failure"
      expr: is_repeat_failure
      comment: "Flag indicating if this is a repeat failure of the same equipment"
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', event_date)
      comment: "Month when the downtime event occurred"
    - name: "escalation_level"
      expr: escalation_level
      comment: "Escalation level of the downtime event"
  measures:
    - name: "total_downtime_events"
      expr: COUNT(DISTINCT downtime_event_id)
      comment: "Total number of unique downtime events"
    - name: "total_downtime_minutes"
      expr: SUM(CAST(duration_minutes AS DOUBLE))
      comment: "Total downtime duration in minutes across all events"
    - name: "total_production_loss_units"
      expr: SUM(CAST(production_loss_units AS DOUBLE))
      comment: "Total production units lost due to downtime"
    - name: "total_maintenance_cost"
      expr: SUM(CAST(maintenance_cost_local AS DOUBLE))
      comment: "Total maintenance cost incurred for downtime resolution"
    - name: "avg_time_to_repair_minutes"
      expr: AVG(CAST(time_to_repair_minutes AS DOUBLE))
      comment: "Average time to repair equipment and restore production"
    - name: "avg_time_to_respond_minutes"
      expr: AVG(CAST(time_to_respond_minutes AS DOUBLE))
      comment: "Average time to respond to downtime event notification"
    - name: "avg_oee_availability_loss_pct"
      expr: AVG(CAST(oee_availability_loss_pct AS DOUBLE))
      comment: "Average OEE availability loss percentage per downtime event"
    - name: "mttr_hours"
      expr: ROUND(AVG(CAST(time_to_repair_minutes AS DOUBLE)) / 60.0, 2)
      comment: "Mean Time To Repair in hours - key reliability metric"
    - name: "downtime_cost_per_minute"
      expr: ROUND(SUM(CAST(maintenance_cost_local AS DOUBLE)) / NULLIF(SUM(CAST(duration_minutes AS DOUBLE)), 0), 2)
      comment: "Average maintenance cost per minute of downtime"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`manufacturing_oee_daily_snapshot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Overall Equipment Effectiveness (OEE) daily KPIs tracking availability, performance, quality, and composite OEE for manufacturing lines"
  source: "`vibe_automotive_v1`.`manufacturing`.`oee_daily_snapshot`"
  dimensions:
    - name: "snapshot_date"
      expr: snapshot_date
      comment: "Date of the OEE snapshot"
    - name: "snapshot_month"
      expr: DATE_TRUNC('MONTH', snapshot_date)
      comment: "Month of the OEE snapshot"
    - name: "snapshot_year"
      expr: YEAR(snapshot_date)
      comment: "Year of the OEE snapshot"
  measures:
    - name: "total_snapshots"
      expr: COUNT(DISTINCT oee_daily_snapshot_id)
      comment: "Total number of daily OEE snapshots"
    - name: "avg_oee_pct"
      expr: AVG(CAST(oee_pct AS DOUBLE))
      comment: "Average Overall Equipment Effectiveness percentage - composite metric of availability x performance x quality"
    - name: "avg_availability_pct"
      expr: AVG(CAST(availability_pct AS DOUBLE))
      comment: "Average availability percentage - ratio of operating time to planned production time"
    - name: "avg_performance_pct"
      expr: AVG(CAST(performance_pct AS DOUBLE))
      comment: "Average performance percentage - ratio of actual to ideal cycle time"
    - name: "avg_quality_pct"
      expr: AVG(CAST(quality_pct AS DOUBLE))
      comment: "Average quality percentage - ratio of good units to total units produced"
    - name: "total_good_units_produced"
      expr: SUM(CAST(good_units_produced AS DOUBLE))
      comment: "Total good units produced across all snapshots"
    - name: "total_units_produced"
      expr: SUM(CAST(total_units_produced AS DOUBLE))
      comment: "Total units produced (good + scrap) across all snapshots"
    - name: "total_scrap_units"
      expr: SUM(CAST(scrap_units AS DOUBLE))
      comment: "Total scrap units across all snapshots"
    - name: "total_downtime_minutes"
      expr: SUM(CAST(downtime_minutes AS DOUBLE))
      comment: "Total downtime minutes across all snapshots"
    - name: "total_planned_production_time_minutes"
      expr: SUM(CAST(planned_production_time_minutes AS DOUBLE))
      comment: "Total planned production time in minutes"
    - name: "world_class_oee_achievement_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN CAST(oee_pct AS DOUBLE) >= 85.0 THEN 1 END) / NULLIF(COUNT(DISTINCT oee_daily_snapshot_id), 0), 2)
      comment: "Percentage of days achieving world-class OEE (85%+) - strategic performance indicator"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`manufacturing_vehicle_build`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vehicle build execution KPIs tracking build status, cycle times, quality gates, and rework for individual vehicle production"
  source: "`vibe_automotive_v1`.`manufacturing`.`vehicle_build`"
  dimensions:
    - name: "build_status"
      expr: build_status
      comment: "Current status of the vehicle build (in-progress, completed, on-hold, scrapped)"
    - name: "build_type"
      expr: build_type
      comment: "Type of build (production, pilot, prototype, rework)"
    - name: "model_year"
      expr: model_year
      comment: "Model year of the vehicle being built"
    - name: "powertrain_type"
      expr: powertrain_type
      comment: "Powertrain type (ICE, HEV, PHEV, BEV, FCEV)"
    - name: "body_style"
      expr: body_style
      comment: "Body style of the vehicle (sedan, SUV, truck, coupe)"
    - name: "quality_gate_status"
      expr: quality_gate_status
      comment: "Status of quality gate checks (passed, failed, pending)"
    - name: "is_on_hold"
      expr: hold_flag
      comment: "Flag indicating if the vehicle build is on quality or process hold"
    - name: "is_rework"
      expr: rework_flag
      comment: "Flag indicating if the vehicle required rework"
    - name: "is_sop_build"
      expr: sop_flag
      comment: "Flag indicating if this is a start-of-production build"
    - name: "scheduled_build_month"
      expr: DATE_TRUNC('MONTH', scheduled_build_date)
      comment: "Month when the vehicle was scheduled to be built"
    - name: "end_of_line_test_result"
      expr: end_of_line_test_result
      comment: "Result of end-of-line testing (pass, fail, conditional pass)"
  measures:
    - name: "total_vehicles_built"
      expr: COUNT(DISTINCT vehicle_build_id)
      comment: "Total number of unique vehicle builds"
    - name: "total_rework_count"
      expr: SUM(CAST(rework_count AS DOUBLE))
      comment: "Total number of rework instances across all vehicle builds"
    - name: "rework_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN rework_flag = TRUE THEN 1 END) / NULLIF(COUNT(DISTINCT vehicle_build_id), 0), 2)
      comment: "Percentage of vehicles requiring rework - key quality indicator"
    - name: "quality_hold_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN hold_flag = TRUE THEN 1 END) / NULLIF(COUNT(DISTINCT vehicle_build_id), 0), 2)
      comment: "Percentage of vehicles placed on quality hold"
    - name: "eol_first_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN end_of_line_test_result = 'pass' AND rework_flag = FALSE THEN 1 END) / NULLIF(COUNT(DISTINCT vehicle_build_id), 0), 2)
      comment: "End-of-line first pass rate - vehicles passing EOL test without rework"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`manufacturing_material_consumption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Material consumption and variance KPIs tracking actual vs planned material usage, scrap, and cost variance for production"
  source: "`vibe_automotive_v1`.`manufacturing`.`material_consumption`"
  dimensions:
    - name: "consumption_status"
      expr: consumption_status
      comment: "Status of the material consumption transaction (posted, reversed, pending)"
    - name: "goods_movement_type"
      expr: goods_movement_type
      comment: "SAP goods movement type code"
    - name: "is_scrap"
      expr: scrap_indicator
      comment: "Flag indicating if this consumption was scrapped material"
    - name: "is_reversal"
      expr: reversal_indicator
      comment: "Flag indicating if this is a reversal transaction"
    - name: "model_year"
      expr: model_year
      comment: "Model year of the vehicle for which material was consumed"
    - name: "powertrain_type"
      expr: powertrain_type
      comment: "Powertrain type of the vehicle"
    - name: "consumption_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month when the material consumption was posted"
    - name: "scrap_reason_code"
      expr: scrap_reason_code
      comment: "Reason code for scrapped material"
  measures:
    - name: "total_consumption_transactions"
      expr: COUNT(DISTINCT material_consumption_id)
      comment: "Total number of material consumption transactions"
    - name: "total_quantity_consumed"
      expr: SUM(CAST(quantity_consumed AS DOUBLE))
      comment: "Total quantity of material consumed"
    - name: "total_planned_quantity"
      expr: SUM(CAST(planned_quantity AS DOUBLE))
      comment: "Total planned quantity of material"
    - name: "total_quantity_variance"
      expr: SUM(CAST(quantity_variance AS DOUBLE))
      comment: "Total quantity variance (actual - planned)"
    - name: "total_material_cost"
      expr: SUM(CAST(material_cost_amount AS DOUBLE))
      comment: "Total material cost for consumed materials"
    - name: "total_cost_variance"
      expr: SUM(CAST(cost_variance_amount AS DOUBLE))
      comment: "Total cost variance (actual - standard cost)"
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average variance percentage across all consumption transactions"
    - name: "material_yield_pct"
      expr: ROUND(100.0 * SUM(CAST(quantity_consumed AS DOUBLE)) / NULLIF(SUM(CAST(planned_quantity AS DOUBLE)), 0), 2)
      comment: "Material yield percentage - ratio of actual to planned consumption"
    - name: "scrap_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN scrap_indicator = TRUE THEN 1 END) / NULLIF(COUNT(DISTINCT material_consumption_id), 0), 2)
      comment: "Scrap rate as percentage of total consumption transactions"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`manufacturing_production_confirmation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Production confirmation KPIs tracking labor efficiency, machine utilization, and actual vs planned time for manufacturing operations"
  source: "`vibe_automotive_v1`.`manufacturing`.`production_confirmation`"
  dimensions:
    - name: "confirmation_status"
      expr: confirmation_status
      comment: "Status of the production confirmation (confirmed, reversed, pending)"
    - name: "confirmation_type"
      expr: confirmation_type
      comment: "Type of confirmation (time ticket, milestone, final confirmation)"
    - name: "is_final_confirmation"
      expr: final_confirmation_flag
      comment: "Flag indicating if this is the final confirmation for the operation"
    - name: "is_reversal"
      expr: reversal_indicator
      comment: "Flag indicating if this is a reversal of a previous confirmation"
    - name: "assembly_stage"
      expr: assembly_stage
      comment: "Assembly stage where the work was performed"
    - name: "model_year"
      expr: model_year
      comment: "Model year of the vehicle being produced"
    - name: "powertrain_type"
      expr: powertrain_type
      comment: "Powertrain type of the vehicle"
    - name: "confirmation_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month when the production confirmation was posted"
    - name: "downtime_reason_code"
      expr: downtime_reason_code
      comment: "Reason code for any downtime during the operation"
    - name: "scrap_reason_code"
      expr: scrap_reason_code
      comment: "Reason code for any scrap generated"
  measures:
    - name: "total_confirmations"
      expr: COUNT(DISTINCT production_confirmation_id)
      comment: "Total number of production confirmations"
    - name: "total_yield_quantity"
      expr: SUM(CAST(yield_quantity AS DOUBLE))
      comment: "Total yield quantity confirmed across all operations"
    - name: "total_scrap_quantity"
      expr: SUM(CAST(scrap_quantity AS DOUBLE))
      comment: "Total scrap quantity confirmed"
    - name: "total_rework_quantity"
      expr: SUM(CAST(rework_quantity AS DOUBLE))
      comment: "Total rework quantity confirmed"
    - name: "total_actual_labor_time_minutes"
      expr: SUM(CAST(labor_time_actual_min AS DOUBLE))
      comment: "Total actual labor time in minutes"
    - name: "total_planned_labor_time_minutes"
      expr: SUM(CAST(labor_time_planned_min AS DOUBLE))
      comment: "Total planned labor time in minutes"
    - name: "total_actual_machine_time_minutes"
      expr: SUM(CAST(machine_time_actual_min AS DOUBLE))
      comment: "Total actual machine time in minutes"
    - name: "total_planned_machine_time_minutes"
      expr: SUM(CAST(machine_time_planned_min AS DOUBLE))
      comment: "Total planned machine time in minutes"
    - name: "total_downtime_duration_minutes"
      expr: SUM(CAST(downtime_duration_min AS DOUBLE))
      comment: "Total downtime duration in minutes"
    - name: "labor_efficiency_pct"
      expr: ROUND(100.0 * SUM(CAST(labor_time_planned_min AS DOUBLE)) / NULLIF(SUM(CAST(labor_time_actual_min AS DOUBLE)), 0), 2)
      comment: "Labor efficiency percentage - ratio of planned to actual labor time"
    - name: "machine_utilization_pct"
      expr: ROUND(100.0 * SUM(CAST(machine_time_actual_min AS DOUBLE)) / NULLIF(SUM(CAST(machine_time_planned_min AS DOUBLE)), 0), 2)
      comment: "Machine utilization percentage - ratio of actual to planned machine time"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`manufacturing_scrap_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Manufacturing scrap KPIs tracking scrap quantity, value, root causes, and environmental impact for quality and cost management"
  source: "`vibe_automotive_v1`.`manufacturing`.`scrap_record`"
  dimensions:
    - name: "scrap_status"
      expr: scrap_status
      comment: "Status of the scrap record (recorded, disposed, salvaged)"
    - name: "scrap_category"
      expr: scrap_category
      comment: "Category of scrap (material, component, assembly, vehicle)"
    - name: "scrap_reason_code"
      expr: scrap_reason_code
      comment: "Reason code for the scrap"
    - name: "root_cause_code"
      expr: root_cause_code
      comment: "Root cause classification for the scrap"
    - name: "is_hazardous"
      expr: is_hazardous_material
      comment: "Flag indicating if the scrapped material is hazardous"
    - name: "is_safety_related"
      expr: is_safety_related
      comment: "Flag indicating if the scrap was due to safety concerns"
    - name: "is_warranty_relevant"
      expr: is_warranty_relevant
      comment: "Flag indicating if the scrap is relevant to warranty claims"
    - name: "disposal_method_code"
      expr: disposal_method_code
      comment: "Method used for disposal of scrapped material"
    - name: "model_year"
      expr: model_year
      comment: "Model year of the vehicle for which material was scrapped"
    - name: "scrap_month"
      expr: DATE_TRUNC('MONTH', scrap_timestamp)
      comment: "Month when the scrap was recorded"
  measures:
    - name: "total_scrap_records"
      expr: COUNT(DISTINCT scrap_record_id)
      comment: "Total number of scrap records"
    - name: "total_scrap_quantity"
      expr: SUM(CAST(scrap_quantity AS DOUBLE))
      comment: "Total quantity of scrapped material"
    - name: "total_scrap_value"
      expr: SUM(CAST(scrap_value AS DOUBLE))
      comment: "Total value of scrapped material at standard cost"
    - name: "total_salvage_value"
      expr: SUM(CAST(salvage_value AS DOUBLE))
      comment: "Total salvage value recovered from scrapped material"
    - name: "total_scrap_weight_kg"
      expr: SUM(CAST(weight_kg AS DOUBLE))
      comment: "Total weight of scrapped material in kilograms"
    - name: "total_co2_impact_kg"
      expr: SUM(CAST(co2_impact_kg AS DOUBLE))
      comment: "Total CO2 impact of scrapped material in kilograms"
    - name: "avg_ppm_contribution"
      expr: AVG(CAST(ppm_contribution AS DOUBLE))
      comment: "Average parts-per-million contribution to defect rate"
    - name: "net_scrap_cost"
      expr: SUM(CAST(scrap_value AS DOUBLE) - CAST(salvage_value AS DOUBLE))
      comment: "Net scrap cost after salvage value recovery - key cost management metric"
    - name: "salvage_recovery_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(salvage_value AS DOUBLE)) / NULLIF(SUM(CAST(scrap_value AS DOUBLE)), 0), 2)
      comment: "Salvage recovery rate as percentage of scrap value"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`manufacturing_capacity_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Manufacturing capacity planning KPIs tracking capacity utilization, gaps, bottlenecks, and investment requirements for production planning"
  source: "`vibe_automotive_v1`.`manufacturing`.`capacity_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Status of the capacity plan (draft, approved, active, archived)"
    - name: "capacity_plan_type"
      expr: capacity_plan_type
      comment: "Type of capacity plan (annual, quarterly, scenario, contingency)"
    - name: "planning_scenario"
      expr: planning_scenario
      comment: "Planning scenario (base case, optimistic, pessimistic, stress test)"
    - name: "planning_period_type"
      expr: planning_period_type
      comment: "Period type for the plan (daily, weekly, monthly, annual)"
    - name: "is_bottleneck_constrained"
      expr: is_bottleneck_constrained
      comment: "Flag indicating if the plan is constrained by bottleneck capacity"
    - name: "is_capex_required"
      expr: capex_required
      comment: "Flag indicating if capital expenditure is required to meet capacity"
    - name: "model_year"
      expr: model_year
      comment: "Model year for which capacity is planned"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the capacity plan"
    - name: "powertrain_type"
      expr: powertrain_type
      comment: "Powertrain type for which capacity is planned"
    - name: "plan_start_month"
      expr: DATE_TRUNC('MONTH', plan_start_date)
      comment: "Month when the capacity plan starts"
  measures:
    - name: "total_capacity_plans"
      expr: COUNT(DISTINCT capacity_plan_id)
      comment: "Total number of capacity plans"
    - name: "total_planned_production_units"
      expr: SUM(CAST(planned_production_units AS DOUBLE))
      comment: "Total planned production units across all capacity plans"
    - name: "total_rated_capacity_units"
      expr: SUM(CAST(rated_capacity_units AS DOUBLE))
      comment: "Total rated capacity units available"
    - name: "total_demonstrated_capacity_units"
      expr: SUM(CAST(demonstrated_capacity_units AS DOUBLE))
      comment: "Total demonstrated capacity units (proven capability)"
    - name: "total_capacity_gap_units"
      expr: SUM(CAST(capacity_gap_units AS DOUBLE))
      comment: "Total capacity gap (demand minus available capacity)"
    - name: "total_available_hours"
      expr: SUM(CAST(available_hours AS DOUBLE))
      comment: "Total available production hours"
    - name: "total_planned_downtime_hours"
      expr: SUM(CAST(planned_downtime_hours AS DOUBLE))
      comment: "Total planned downtime hours"
    - name: "total_planned_overtime_hours"
      expr: SUM(CAST(planned_overtime_hours AS DOUBLE))
      comment: "Total planned overtime hours"
    - name: "total_capex_required"
      expr: SUM(CAST(capex_amount AS DOUBLE))
      comment: "Total capital expenditure required to meet capacity targets"
    - name: "avg_capacity_utilization_pct"
      expr: AVG(CAST(capacity_utilization_percent AS DOUBLE))
      comment: "Average capacity utilization percentage across all plans"
    - name: "capacity_fulfillment_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(rated_capacity_units AS DOUBLE)) / NULLIF(SUM(CAST(planned_production_units AS DOUBLE)), 0), 2)
      comment: "Capacity fulfillment rate - ratio of rated capacity to planned demand"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`manufacturing_changeover`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Manufacturing changeover KPIs tracking changeover duration, efficiency, and production losses for SMED (Single-Minute Exchange of Die) optimization"
  source: "`vibe_automotive_v1`.`manufacturing`.`changeover`"
  dimensions:
    - name: "changeover_status"
      expr: changeover_status
      comment: "Status of the changeover (planned, in-progress, completed, aborted)"
    - name: "changeover_type"
      expr: changeover_type
      comment: "Type of changeover (model, color, powertrain, tooling)"
    - name: "is_planned"
      expr: is_planned
      comment: "Flag indicating if the changeover was planned"
    - name: "is_smed_target"
      expr: is_smed_target
      comment: "Flag indicating if this changeover is a SMED (Single-Minute Exchange of Die) target"
    - name: "is_tooling_change_required"
      expr: tooling_change_required
      comment: "Flag indicating if tooling change was required"
    - name: "is_agv_intervention_required"
      expr: agv_intervention_required
      comment: "Flag indicating if AGV intervention was required"
    - name: "quality_gate_passed"
      expr: quality_gate_passed
      comment: "Flag indicating if quality gate was passed after changeover"
    - name: "from_vehicle_model"
      expr: from_vehicle_model_code
      comment: "Vehicle model code before changeover"
    - name: "to_vehicle_model"
      expr: to_vehicle_model_code
      comment: "Vehicle model code after changeover"
    - name: "model_year"
      expr: model_year
      comment: "Model year during changeover"
    - name: "changeover_month"
      expr: DATE_TRUNC('MONTH', actual_start_timestamp)
      comment: "Month when the changeover occurred"
  measures:
    - name: "total_changeovers"
      expr: COUNT(DISTINCT changeover_id)
      comment: "Total number of changeover events"
    - name: "total_actual_duration_minutes"
      expr: SUM(CAST(actual_duration_minutes AS DOUBLE))
      comment: "Total actual changeover duration in minutes"
    - name: "total_planned_duration_minutes"
      expr: SUM(CAST(planned_duration_minutes AS DOUBLE))
      comment: "Total planned changeover duration in minutes"
    - name: "total_variance_minutes"
      expr: SUM(CAST(variance_minutes AS DOUBLE))
      comment: "Total variance between actual and planned duration"
    - name: "total_production_loss_units"
      expr: SUM(CAST(production_loss_units AS DOUBLE))
      comment: "Total production units lost during changeovers"
    - name: "total_scrap_units_during_changeover"
      expr: SUM(CAST(scrap_units_during_changeover AS DOUBLE))
      comment: "Total scrap units generated during changeovers"
    - name: "avg_actual_duration_minutes"
      expr: AVG(CAST(actual_duration_minutes AS DOUBLE))
      comment: "Average actual changeover duration in minutes"
    - name: "avg_planned_duration_minutes"
      expr: AVG(CAST(planned_duration_minutes AS DOUBLE))
      comment: "Average planned changeover duration in minutes"
    - name: "changeover_efficiency_pct"
      expr: ROUND(100.0 * SUM(CAST(planned_duration_minutes AS DOUBLE)) / NULLIF(SUM(CAST(actual_duration_minutes AS DOUBLE)), 0), 2)
      comment: "Changeover efficiency percentage - ratio of planned to actual duration"
    - name: "smed_achievement_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_smed_target = TRUE AND CAST(actual_duration_minutes AS DOUBLE) < 10.0 THEN 1 END) / NULLIF(COUNT(CASE WHEN is_smed_target = TRUE THEN 1 END), 0), 2)
      comment: "SMED achievement rate - percentage of SMED-target changeovers completed under 10 minutes"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`manufacturing_plant`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Manufacturing plant master data and capability KPIs tracking plant capacity, certifications, and operational characteristics"
  source: "`vibe_automotive_v1`.`manufacturing`.`plant`"
  dimensions:
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the plant (active, ramping, idle, decommissioned)"
    - name: "plant_type"
      expr: plant_type
      comment: "Type of manufacturing plant (assembly, stamping, powertrain, body shop)"
    - name: "is_iatf_certified"
      expr: iatf_16949_certified
      comment: "Flag indicating if plant is IATF 16949 certified"
    - name: "is_iso_9001_certified"
      expr: iso_9001_certified
      comment: "Flag indicating if plant is ISO 9001 certified"
    - name: "is_iso_14001_certified"
      expr: iso_14001_certified
      comment: "Flag indicating if plant is ISO 14001 (environmental) certified"
    - name: "is_agv_enabled"
      expr: agv_enabled
      comment: "Flag indicating if plant uses automated guided vehicles"
    - name: "is_ota_capable"
      expr: ota_capable
      comment: "Flag indicating if plant can produce OTA-capable vehicles"
    - name: "is_union_represented"
      expr: union_represented
      comment: "Flag indicating if plant workforce is union-represented"
    - name: "region"
      expr: region
      comment: "Geographic region of the plant"
    - name: "country_code"
      expr: country_code
      comment: "Country code where the plant is located"
    - name: "primary_vehicle_segment"
      expr: primary_vehicle_segment
      comment: "Primary vehicle segment produced at the plant"
    - name: "model_year_current"
      expr: model_year_current
      comment: "Current model year in production"
  measures:
    - name: "total_plants"
      expr: COUNT(DISTINCT plant_id)
      comment: "Total number of manufacturing plants"
    - name: "total_annual_capacity_units"
      expr: SUM(CAST(annual_capacity_units AS DOUBLE))
      comment: "Total annual production capacity across all plants"
    - name: "total_daily_capacity_units"
      expr: SUM(CAST(daily_capacity_units AS DOUBLE))
      comment: "Total daily production capacity across all plants"
    - name: "total_floor_area_sqm"
      expr: SUM(CAST(floor_area_sqm AS DOUBLE))
      comment: "Total manufacturing floor area in square meters"
    - name: "total_workforce_headcount"
      expr: SUM(CAST(workforce_headcount AS DOUBLE))
      comment: "Total workforce headcount across all plants"
    - name: "avg_takt_time_seconds"
      expr: AVG(CAST(takt_time_seconds AS DOUBLE))
      comment: "Average takt time in seconds across all plants"
    - name: "iatf_certification_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN iatf_16949_certified = TRUE THEN 1 END) / NULLIF(COUNT(DISTINCT plant_id), 0), 2)
      comment: "Percentage of plants with IATF 16949 certification - quality system maturity indicator"
    - name: "agv_adoption_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN agv_enabled = TRUE THEN 1 END) / NULLIF(COUNT(DISTINCT plant_id), 0), 2)
      comment: "Percentage of plants with AGV automation - Industry 4.0 adoption indicator"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`manufacturing_energy_consumption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Manufacturing energy consumption KPIs tracking energy usage, costs, and renewable energy adoption for ESG and sustainability reporting"
  source: "`vibe_automotive_v1`.`manufacturing`.`energy_consumption_record`"
  dimensions:
    - name: "energy_source"
      expr: energy_source
      comment: "Source of energy (grid, solar, wind, natural gas, diesel)"
    - name: "is_renewable"
      expr: renewable_flag
      comment: "Flag indicating if the energy source is renewable"
    - name: "reading_month"
      expr: DATE_TRUNC('MONTH', reading_date)
      comment: "Month of the energy consumption reading"
    - name: "reading_year"
      expr: YEAR(reading_date)
      comment: "Year of the energy consumption reading"
  measures:
    - name: "total_energy_records"
      expr: COUNT(DISTINCT energy_consumption_record_id)
      comment: "Total number of energy consumption records"
    - name: "total_energy_kwh"
      expr: SUM(CAST(energy_kwh AS DOUBLE))
      comment: "Total energy consumed in kilowatt-hours"
    - name: "total_energy_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost of energy consumed"
    - name: "avg_energy_cost_per_kwh"
      expr: ROUND(SUM(CAST(cost_amount AS DOUBLE)) / NULLIF(SUM(CAST(energy_kwh AS DOUBLE)), 0), 4)
      comment: "Average energy cost per kilowatt-hour"
    - name: "renewable_energy_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN renewable_flag = TRUE THEN CAST(energy_kwh AS DOUBLE) ELSE 0 END) / NULLIF(SUM(CAST(energy_kwh AS DOUBLE)), 0), 2)
      comment: "Percentage of energy from renewable sources - key ESG sustainability metric"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`manufacturing_co2_emissions`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Manufacturing CO2 emissions KPIs tracking carbon footprint by scope and source for ESG reporting and carbon reduction initiatives"
  source: "`vibe_automotive_v1`.`manufacturing`.`co2_emission_record`"
  dimensions:
    - name: "emission_scope"
      expr: emission_scope
      comment: "GHG Protocol emission scope (Scope 1, Scope 2, Scope 3)"
    - name: "emission_source"
      expr: emission_source
      comment: "Source of CO2 emissions (electricity, natural gas, diesel, process emissions)"
    - name: "calculation_method"
      expr: calculation_method
      comment: "Method used to calculate emissions (direct measurement, emission factor, estimation)"
    - name: "reading_month"
      expr: DATE_TRUNC('MONTH', reading_date)
      comment: "Month of the emission reading"
    - name: "reading_year"
      expr: YEAR(reading_date)
      comment: "Year of the emission reading"
  measures:
    - name: "total_emission_records"
      expr: COUNT(DISTINCT co2_emission_record_id)
      comment: "Total number of CO2 emission records"
    - name: "total_co2_kg"
      expr: SUM(CAST(co2_kg AS DOUBLE))
      comment: "Total CO2 emissions in kilograms - primary carbon footprint metric for ESG reporting"
    - name: "total_co2_metric_tons"
      expr: ROUND(SUM(CAST(co2_kg AS DOUBLE)) / 1000.0, 2)
      comment: "Total CO2 emissions in metric tons - standard ESG reporting unit"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`manufacturing_water_usage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Manufacturing water usage KPIs tracking water consumption and recycling for ESG environmental sustainability reporting"
  source: "`vibe_automotive_v1`.`manufacturing`.`water_usage_record`"
  dimensions:
    - name: "water_source"
      expr: water_source
      comment: "Source of water (municipal, well, surface water, recycled)"
    - name: "is_recycled"
      expr: recycled_flag
      comment: "Flag indicating if the water is recycled/reclaimed"
    - name: "reading_month"
      expr: DATE_TRUNC('MONTH', reading_date)
      comment: "Month of the water usage reading"
    - name: "reading_year"
      expr: YEAR(reading_date)
      comment: "Year of the water usage reading"
  measures:
    - name: "total_water_records"
      expr: COUNT(DISTINCT water_usage_record_id)
      comment: "Total number of water usage records"
    - name: "total_water_liters"
      expr: SUM(CAST(water_liters AS DOUBLE))
      comment: "Total water consumed in liters"
    - name: "total_water_cubic_meters"
      expr: ROUND(SUM(CAST(water_liters AS DOUBLE)) / 1000.0, 2)
      comment: "Total water consumed in cubic meters - standard ESG reporting unit"
    - name: "recycled_water_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN recycled_flag = TRUE THEN CAST(water_liters AS DOUBLE) ELSE 0 END) / NULLIF(SUM(CAST(water_liters AS DOUBLE)), 0), 2)
      comment: "Percentage of water that is recycled - key ESG water stewardship metric"
$$;