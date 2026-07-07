-- Metric views for domain: production | Business: Manufacturing | Version: 2 | Generated on: 2026-07-03 05:35:52

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`production_work_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core KPIs for production work orders covering throughput, cost variance, quality, and schedule adherence — the primary steering dashboard for production operations."
  source: "`vibe_manufacturing_v1`.`production`.`production_work_order`"
  dimensions:
    - name: "work_order_status"
      expr: work_order_status
      comment: "Current status of the work order (e.g. Released, Confirmed, Closed) for pipeline analysis."
    - name: "work_order_type"
      expr: work_order_type
      comment: "Type of work order (e.g. Standard, Rework, Repair) for segmenting production activity."
    - name: "priority_code"
      expr: priority_code
      comment: "Priority classification of the work order for capacity and scheduling decisions."
    - name: "planned_start_date"
      expr: DATE_TRUNC('month', planned_start_date)
      comment: "Month bucket of planned start date for trend analysis."
    - name: "planned_finish_date"
      expr: DATE_TRUNC('month', planned_finish_date)
      comment: "Month bucket of planned finish date for schedule adherence tracking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which cost figures are denominated."
  measures:
    - name: "total_work_orders"
      expr: COUNT(1)
      comment: "Total number of work orders — baseline volume metric for production load assessment."
    - name: "total_planned_quantity"
      expr: SUM(CAST(planned_quantity AS DOUBLE))
      comment: "Sum of all planned production quantities across work orders — used to assess scheduled output volume."
    - name: "total_actual_quantity"
      expr: SUM(CAST(actual_quantity AS DOUBLE))
      comment: "Sum of all actual produced quantities — measures realized production output."
    - name: "total_scrap_quantity"
      expr: SUM(CAST(scrap_quantity AS DOUBLE))
      comment: "Total scrapped quantity across work orders — key quality and waste indicator."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual production cost incurred — used for cost control and variance analysis."
    - name: "total_standard_cost"
      expr: SUM(CAST(standard_cost AS DOUBLE))
      comment: "Total standard (expected) production cost — baseline for cost variance calculation."
    - name: "total_wip_value"
      expr: SUM(CAST(wip_value AS DOUBLE))
      comment: "Total value of work-in-progress inventory tied to open work orders — critical for balance sheet and cash flow."
    - name: "avg_oee_percentage"
      expr: AVG(CAST(oee_percentage AS DOUBLE))
      comment: "Average Overall Equipment Effectiveness across work orders — primary manufacturing efficiency KPI."
    - name: "avg_yield_rate_percentage"
      expr: AVG(CAST(yield_rate_percentage AS DOUBLE))
      comment: "Average yield rate across work orders — measures proportion of good output vs. total started."
    - name: "avg_scrap_rate_percentage"
      expr: AVG(CAST(scrap_rate_percentage AS DOUBLE))
      comment: "Average scrap rate across work orders — quality loss indicator driving rework and material cost."
    - name: "avg_cycle_time_minutes"
      expr: AVG(CAST(cycle_time_minutes AS DOUBLE))
      comment: "Average cycle time per work order in minutes — used to benchmark against takt time and identify bottlenecks."
    - name: "avg_setup_time_minutes"
      expr: AVG(CAST(setup_time_minutes AS DOUBLE))
      comment: "Average setup time per work order — changeover efficiency indicator for lean manufacturing."
    - name: "total_downtime_minutes"
      expr: SUM(CAST(downtime_minutes AS DOUBLE))
      comment: "Total downtime minutes recorded against work orders — direct input to OEE availability calculation."
    - name: "avg_completion_percentage"
      expr: AVG(CAST(completion_percentage AS DOUBLE))
      comment: "Average completion percentage across open work orders — schedule progress indicator."
    - name: "avg_takt_time_minutes"
      expr: AVG(CAST(takt_time_minutes AS DOUBLE))
      comment: "Average takt time per work order — measures pace of production relative to customer demand rate."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`production_order_confirmation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs derived from production order confirmations — captures actual labor, machine hours, costs, and quality outcomes at the operation level."
  source: "`vibe_manufacturing_v1`.`production`.`order_confirmation`"
  dimensions:
    - name: "confirmation_status"
      expr: confirmation_status
      comment: "Status of the confirmation (e.g. Posted, Reversed) for filtering valid vs. cancelled confirmations."
    - name: "confirmation_type"
      expr: confirmation_type
      comment: "Type of confirmation (e.g. Partial, Final) for distinguishing milestone completions."
    - name: "posting_date_month"
      expr: DATE_TRUNC('month', posting_date)
      comment: "Month of posting date for time-series trend analysis of production activity."
    - name: "activity_type"
      expr: activity_type
      comment: "Activity type (e.g. Labor, Machine) for cost allocation and capacity analysis."
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Flag indicating whether the confirmation was reversed — used to filter out cancelled transactions."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of cost figures for multi-currency reporting."
  measures:
    - name: "total_confirmations"
      expr: COUNT(1)
      comment: "Total number of order confirmations — baseline volume for production activity tracking."
    - name: "total_actual_labor_hours"
      expr: SUM(CAST(actual_labor_hours AS DOUBLE))
      comment: "Total actual labor hours consumed across all confirmations — workforce utilization and cost driver."
    - name: "total_actual_machine_hours"
      expr: SUM(CAST(actual_machine_hours AS DOUBLE))
      comment: "Total actual machine hours consumed — equipment utilization and capacity consumption metric."
    - name: "total_actual_cost_amount"
      expr: SUM(CAST(actual_cost_amount AS DOUBLE))
      comment: "Total actual cost confirmed at operation level — used for work order cost roll-up and variance analysis."
    - name: "total_standard_cost_amount"
      expr: SUM(CAST(standard_cost_amount AS DOUBLE))
      comment: "Total standard cost for confirmed operations — baseline for cost variance calculation."
    - name: "total_yield_quantity"
      expr: SUM(CAST(yield_quantity AS DOUBLE))
      comment: "Total good yield quantity confirmed — primary output volume measure."
    - name: "total_scrap_quantity"
      expr: SUM(CAST(scrap_quantity AS DOUBLE))
      comment: "Total scrap quantity from confirmations — quality loss and material waste indicator."
    - name: "total_rework_quantity"
      expr: SUM(CAST(rework_quantity AS DOUBLE))
      comment: "Total rework quantity — hidden factory cost indicator and quality process signal."
    - name: "total_setup_time_hours"
      expr: SUM(CAST(setup_time_hours AS DOUBLE))
      comment: "Total setup time hours across confirmations — changeover efficiency and OEE availability input."
    - name: "avg_actual_labor_hours"
      expr: AVG(CAST(actual_labor_hours AS DOUBLE))
      comment: "Average actual labor hours per confirmation — benchmarks against standard to identify inefficiencies."
    - name: "avg_actual_machine_hours"
      expr: AVG(CAST(actual_machine_hours AS DOUBLE))
      comment: "Average actual machine hours per confirmation — machine utilization efficiency indicator."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`production_downtime_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Downtime analytics for production — tracks duration, frequency, OEE impact, and production loss to drive reliability and maintenance investment decisions."
  source: "`vibe_manufacturing_v1`.`production`.`production_downtime_event`"
  dimensions:
    - name: "downtime_category"
      expr: downtime_category
      comment: "Category of downtime (e.g. Planned, Unplanned, Quality) for root-cause segmentation."
    - name: "downtime_type"
      expr: downtime_type
      comment: "Type of downtime event for detailed classification and Pareto analysis."
    - name: "root_cause_code"
      expr: root_cause_code
      comment: "Root cause code for the downtime event — drives corrective action prioritization."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity of the downtime event for risk-based prioritization."
    - name: "shift_date_month"
      expr: DATE_TRUNC('month', shift_date)
      comment: "Month of the shift date for trend analysis of downtime frequency and duration."
    - name: "responsible_department"
      expr: responsible_department
      comment: "Department responsible for the downtime — accountability and resource allocation dimension."
    - name: "downtime_reason"
      expr: downtime_reason
      comment: "Specific reason for downtime — used in Pareto analysis to identify top loss contributors."
  measures:
    - name: "total_downtime_events"
      expr: COUNT(1)
      comment: "Total number of downtime events — frequency metric for reliability trending."
    - name: "total_downtime_duration_minutes"
      expr: SUM(CAST(duration_minutes AS DOUBLE))
      comment: "Total downtime duration in minutes — primary availability loss metric for OEE calculation."
    - name: "avg_downtime_duration_minutes"
      expr: AVG(CAST(duration_minutes AS DOUBLE))
      comment: "Average downtime duration per event — used to benchmark MTTR and identify chronic vs. acute failures."
    - name: "total_production_loss_units"
      expr: SUM(CAST(production_loss_units AS DOUBLE))
      comment: "Total production units lost due to downtime — direct throughput impact measure."
    - name: "total_production_loss_value"
      expr: SUM(CAST(production_loss_value AS DOUBLE))
      comment: "Total financial value of production lost due to downtime — business impact in monetary terms."
    - name: "avg_oee_impact"
      expr: AVG(CAST(impact_on_oee AS DOUBLE))
      comment: "Average OEE impact per downtime event — quantifies how each event degrades overall equipment effectiveness."
    - name: "avg_mttr_minutes"
      expr: AVG(CAST(mttr_minutes AS DOUBLE))
      comment: "Average Mean Time To Repair in minutes — maintenance responsiveness and repair efficiency KPI."
    - name: "total_recurring_events"
      expr: COUNT(CASE WHEN is_recurring = TRUE THEN 1 END)
      comment: "Count of recurring downtime events — identifies systemic failures requiring root-cause elimination."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`production_goods_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for production goods receipts — measures output volume, yield, scrap, and receipt quality to evaluate production-to-stock performance."
  source: "`vibe_manufacturing_v1`.`production`.`production_goods_receipt`"
  dimensions:
    - name: "gr_status"
      expr: gr_status
      comment: "Status of the goods receipt (e.g. Posted, Reversed) for filtering valid receipts."
    - name: "movement_type"
      expr: movement_type
      comment: "Inventory movement type for the goods receipt — distinguishes standard receipt from reversal or special stock."
    - name: "posting_date_month"
      expr: DATE_TRUNC('month', posting_date)
      comment: "Month of posting date for time-series output volume analysis."
    - name: "stock_type"
      expr: stock_type
      comment: "Type of stock received (e.g. Unrestricted, Quality Inspection) for inventory quality segmentation."
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Flag for reversed receipts — used to exclude cancellations from net output calculations."
    - name: "quality_inspection_required"
      expr: quality_inspection_required
      comment: "Whether quality inspection was required — links production output to quality gate compliance."
  measures:
    - name: "total_goods_receipts"
      expr: COUNT(1)
      comment: "Total number of production goods receipts — baseline output transaction volume."
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total quantity received into stock from production — primary finished goods output measure."
    - name: "total_order_quantity"
      expr: SUM(CAST(order_quantity AS DOUBLE))
      comment: "Total ordered quantity for receipts — used to calculate receipt completeness rate."
    - name: "total_scrap_quantity"
      expr: SUM(CAST(scrap_quantity AS DOUBLE))
      comment: "Total scrap quantity at goods receipt — final quality loss measure before stock entry."
    - name: "avg_yield_percentage"
      expr: AVG(CAST(yield_percentage AS DOUBLE))
      comment: "Average yield percentage at goods receipt — measures proportion of good output vs. ordered quantity."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`production_bom_consumption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Material consumption analytics — tracks actual vs. planned component usage, scrap, and cost variance to drive material efficiency and cost control decisions."
  source: "`vibe_manufacturing_v1`.`production`.`bom_consumption`"
  dimensions:
    - name: "consumption_status"
      expr: consumption_status
      comment: "Status of the consumption record (e.g. Posted, Reversed) for filtering valid transactions."
    - name: "consumption_type"
      expr: consumption_type
      comment: "Type of consumption (e.g. Backflush, Manual) for process compliance analysis."
    - name: "movement_type"
      expr: movement_type
      comment: "Inventory movement type for the consumption — distinguishes issue types."
    - name: "posting_date_month"
      expr: DATE_TRUNC('month', posting_date)
      comment: "Month of posting date for time-series material consumption trending."
    - name: "backflush_indicator"
      expr: backflush_indicator
      comment: "Whether consumption was backflushed — process compliance and accuracy indicator."
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Flag for reversed consumption records — used to compute net consumption."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of cost figures for multi-currency material cost reporting."
  measures:
    - name: "total_consumption_records"
      expr: COUNT(1)
      comment: "Total number of BOM consumption records — baseline transaction volume for material tracking."
    - name: "total_actual_quantity"
      expr: SUM(CAST(actual_quantity AS DOUBLE))
      comment: "Total actual material quantity consumed — primary material usage measure."
    - name: "total_planned_quantity"
      expr: SUM(CAST(planned_quantity AS DOUBLE))
      comment: "Total planned material quantity — baseline for consumption variance analysis."
    - name: "total_scrap_quantity"
      expr: SUM(CAST(scrap_quantity AS DOUBLE))
      comment: "Total scrap quantity from material consumption — material waste and quality loss indicator."
    - name: "total_variance_quantity"
      expr: SUM(CAST(variance_quantity AS DOUBLE))
      comment: "Total quantity variance (actual minus planned) — key material efficiency KPI."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual material cost consumed — direct input to production cost of goods manufactured."
    - name: "total_standard_cost"
      expr: SUM(CAST(standard_cost AS DOUBLE))
      comment: "Total standard material cost — baseline for material cost variance calculation."
    - name: "total_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total combined material cost including all cost components — comprehensive material spend measure."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`production_shift_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shift-level production performance KPIs — the primary operational dashboard for shift supervisors and plant managers covering OEE, throughput, quality, and safety."
  source: "`vibe_manufacturing_v1`.`production`.`shift_report`"
  dimensions:
    - name: "shift_date_month"
      expr: DATE_TRUNC('month', shift_date)
      comment: "Month of shift date for trend analysis of shift performance over time."
    - name: "shift_date"
      expr: shift_date
      comment: "Exact shift date for daily operational reporting."
    - name: "quality_hold_flag"
      expr: quality_hold_flag
      comment: "Whether a quality hold was raised during the shift — quality risk indicator."
    - name: "safety_incident_flag"
      expr: safety_incident_flag
      comment: "Whether a safety incident occurred during the shift — safety performance indicator."
    - name: "escalation_required_flag"
      expr: escalation_required_flag
      comment: "Whether escalation was required — operational risk and management attention indicator."
    - name: "data_source_system"
      expr: data_source_system
      comment: "Source system for the shift report — data lineage and integration quality dimension."
  measures:
    - name: "total_shift_reports"
      expr: COUNT(1)
      comment: "Total number of shift reports — baseline for shift coverage and reporting completeness."
    - name: "total_planned_quantity"
      expr: SUM(CAST(planned_quantity AS DOUBLE))
      comment: "Total planned production quantity across shifts — scheduled output volume."
    - name: "total_actual_good_quantity"
      expr: SUM(CAST(actual_good_quantity AS DOUBLE))
      comment: "Total good quantity produced across shifts — net quality output measure."
    - name: "total_scrap_quantity"
      expr: SUM(CAST(scrap_quantity AS DOUBLE))
      comment: "Total scrap quantity across shifts — quality loss and waste indicator."
    - name: "total_rework_quantity"
      expr: SUM(CAST(rework_quantity AS DOUBLE))
      comment: "Total rework quantity across shifts — hidden factory cost and quality process signal."
    - name: "total_downtime_minutes"
      expr: SUM(CAST(downtime_minutes AS DOUBLE))
      comment: "Total downtime minutes across shifts — availability loss for OEE calculation."
    - name: "total_planned_production_time_minutes"
      expr: SUM(CAST(planned_production_time_minutes AS DOUBLE))
      comment: "Total planned production time in minutes — denominator for availability and utilization rates."
    - name: "total_actual_production_time_minutes"
      expr: SUM(CAST(actual_production_time_minutes AS DOUBLE))
      comment: "Total actual production time in minutes — measures realized productive time."
    - name: "avg_oee_percentage"
      expr: AVG(CAST(oee_percentage AS DOUBLE))
      comment: "Average OEE percentage across shifts — primary manufacturing efficiency KPI for executive dashboards."
    - name: "avg_availability_percentage"
      expr: AVG(CAST(availability_percentage AS DOUBLE))
      comment: "Average availability percentage — OEE availability component, measures uptime vs. planned time."
    - name: "avg_performance_percentage"
      expr: AVG(CAST(performance_percentage AS DOUBLE))
      comment: "Average performance percentage — OEE performance component, measures speed vs. ideal cycle time."
    - name: "avg_quality_percentage"
      expr: AVG(CAST(quality_percentage AS DOUBLE))
      comment: "Average quality percentage — OEE quality component, measures good parts vs. total produced."
    - name: "avg_yield_rate_percentage"
      expr: AVG(CAST(yield_rate_percentage AS DOUBLE))
      comment: "Average yield rate across shifts — proportion of good output vs. total started."
    - name: "avg_scrap_rate_percentage"
      expr: AVG(CAST(scrap_rate_percentage AS DOUBLE))
      comment: "Average scrap rate across shifts — quality loss rate for trend monitoring."
    - name: "total_energy_consumption_kwh"
      expr: SUM(CAST(energy_consumption_kwh AS DOUBLE))
      comment: "Total energy consumed across shifts in kWh — sustainability and operational cost KPI."
    - name: "total_material_waste_quantity"
      expr: SUM(CAST(material_waste_quantity AS DOUBLE))
      comment: "Total material waste quantity across shifts — sustainability and lean manufacturing indicator."
    - name: "total_safety_incidents"
      expr: COUNT(CASE WHEN safety_incident_flag = TRUE THEN 1 END)
      comment: "Count of shifts with safety incidents — safety performance KPI for regulatory and ESG reporting."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`production_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Production run performance KPIs — measures throughput, OEE components, cost, and quality at the run level for campaign and batch analysis."
  source: "`vibe_manufacturing_v1`.`production`.`run`"
  dimensions:
    - name: "run_status"
      expr: run_status
      comment: "Current status of the production run (e.g. In Progress, Completed, Cancelled)."
    - name: "run_type"
      expr: run_type
      comment: "Type of production run (e.g. Standard, Campaign, Trial) for segmentation."
    - name: "priority_code"
      expr: priority_code
      comment: "Priority of the run for scheduling and resource allocation analysis."
    - name: "actual_start_month"
      expr: DATE_TRUNC('month', actual_start_timestamp)
      comment: "Month of actual run start for time-series performance trending."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of cost figures for multi-currency reporting."
  measures:
    - name: "total_runs"
      expr: COUNT(1)
      comment: "Total number of production runs — baseline volume for production activity."
    - name: "total_planned_quantity"
      expr: SUM(CAST(planned_quantity AS DOUBLE))
      comment: "Total planned quantity across runs — scheduled production volume."
    - name: "total_actual_quantity"
      expr: SUM(CAST(actual_quantity AS DOUBLE))
      comment: "Total actual quantity produced across runs — realized output volume."
    - name: "total_scrap_quantity"
      expr: SUM(CAST(scrap_quantity AS DOUBLE))
      comment: "Total scrap quantity across runs — quality loss and material waste measure."
    - name: "total_rework_quantity"
      expr: SUM(CAST(rework_quantity AS DOUBLE))
      comment: "Total rework quantity across runs — hidden factory cost indicator."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred across runs — production cost of goods manufactured."
    - name: "total_standard_cost"
      expr: SUM(CAST(standard_cost AS DOUBLE))
      comment: "Total standard cost across runs — baseline for cost variance analysis."
    - name: "total_downtime_minutes"
      expr: SUM(CAST(total_downtime_minutes AS DOUBLE))
      comment: "Total downtime minutes across runs — availability loss for OEE and reliability analysis."
    - name: "total_setup_time_minutes"
      expr: SUM(CAST(total_setup_time_minutes AS DOUBLE))
      comment: "Total setup time minutes across runs — changeover efficiency and lean improvement indicator."
    - name: "avg_oee_percentage"
      expr: AVG(CAST(oee_percentage AS DOUBLE))
      comment: "Average OEE percentage across runs — primary manufacturing efficiency KPI."
    - name: "avg_availability_percentage"
      expr: AVG(CAST(availability_percentage AS DOUBLE))
      comment: "Average availability percentage across runs — OEE availability component."
    - name: "avg_performance_percentage"
      expr: AVG(CAST(performance_percentage AS DOUBLE))
      comment: "Average performance percentage across runs — OEE performance component."
    - name: "avg_quality_percentage"
      expr: AVG(CAST(quality_percentage AS DOUBLE))
      comment: "Average quality percentage across runs — OEE quality component."
    - name: "avg_yield_rate_percentage"
      expr: AVG(CAST(yield_rate_percentage AS DOUBLE))
      comment: "Average yield rate across runs — proportion of good output vs. total started."
    - name: "avg_scrap_rate_percentage"
      expr: AVG(CAST(scrap_rate_percentage AS DOUBLE))
      comment: "Average scrap rate across runs — quality loss rate for trend monitoring."
    - name: "avg_throughput_rate"
      expr: AVG(CAST(throughput_rate AS DOUBLE))
      comment: "Average throughput rate across runs — production speed vs. design capacity indicator."
    - name: "avg_takt_time_minutes"
      expr: AVG(CAST(takt_time_minutes AS DOUBLE))
      comment: "Average takt time across runs — pace of production relative to customer demand rate."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`production_wip_lot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "WIP lot tracking KPIs — monitors in-process inventory quantities, hold status, and quality flags to manage production flow and minimize WIP aging."
  source: "`vibe_manufacturing_v1`.`production`.`wip_lot`"
  dimensions:
    - name: "lot_status"
      expr: lot_status
      comment: "Current status of the WIP lot (e.g. In Process, On Hold, Completed) for pipeline visibility."
    - name: "priority_code"
      expr: priority_code
      comment: "Priority of the WIP lot for scheduling and expediting decisions."
    - name: "rework_flag"
      expr: rework_flag
      comment: "Whether the lot is flagged for rework — quality and hidden factory cost indicator."
    - name: "quality_inspection_required_flag"
      expr: quality_inspection_required_flag
      comment: "Whether quality inspection is required for the lot — quality gate compliance indicator."
    - name: "lot_creation_month"
      expr: DATE_TRUNC('month', lot_creation_timestamp)
      comment: "Month of lot creation for WIP aging and flow analysis."
    - name: "scheduled_completion_date_month"
      expr: DATE_TRUNC('month', scheduled_completion_date)
      comment: "Month of scheduled completion for on-time delivery analysis."
  measures:
    - name: "total_wip_lots"
      expr: COUNT(1)
      comment: "Total number of WIP lots — baseline for in-process inventory volume."
    - name: "total_quantity_ordered"
      expr: SUM(CAST(quantity_ordered AS DOUBLE))
      comment: "Total quantity ordered across WIP lots — planned production volume in process."
    - name: "total_quantity_in_process"
      expr: SUM(CAST(quantity_in_process AS DOUBLE))
      comment: "Total quantity currently in process — active WIP volume for capacity and flow management."
    - name: "total_quantity_completed"
      expr: SUM(CAST(quantity_completed AS DOUBLE))
      comment: "Total quantity completed from WIP lots — realized output from in-process inventory."
    - name: "total_quantity_on_hold"
      expr: SUM(CAST(quantity_on_hold AS DOUBLE))
      comment: "Total quantity on hold across WIP lots — quality risk and production flow blockage indicator."
    - name: "total_quantity_scrapped"
      expr: SUM(CAST(quantity_scrapped AS DOUBLE))
      comment: "Total scrapped quantity from WIP lots — quality loss and material waste measure."
    - name: "total_lots_on_hold"
      expr: COUNT(CASE WHEN lot_status = 'On Hold' THEN 1 END)
      comment: "Count of WIP lots currently on hold — production flow blockage and quality risk indicator."
    - name: "total_rework_lots"
      expr: COUNT(CASE WHEN rework_flag = TRUE THEN 1 END)
      comment: "Count of WIP lots flagged for rework — hidden factory cost and quality process signal."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`production_work_center`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Work center capacity and efficiency KPIs — measures utilization, OEE baseline, and capacity availability to drive resource allocation and bottleneck identification."
  source: "`vibe_manufacturing_v1`.`production`.`work_center`"
  dimensions:
    - name: "work_center_status"
      expr: work_center_status
      comment: "Operational status of the work center (e.g. Active, Inactive, Under Maintenance)."
    - name: "work_center_category"
      expr: work_center_category
      comment: "Category of the work center (e.g. Machine, Labor, Process) for capacity planning segmentation."
    - name: "capacity_category"
      expr: capacity_category
      comment: "Capacity category for the work center — used in capacity requirements planning."
    - name: "scheduling_type"
      expr: scheduling_type
      comment: "Scheduling type for the work center — determines how capacity is planned and allocated."
    - name: "quality_inspection_required"
      expr: quality_inspection_required
      comment: "Whether quality inspection is required at this work center — quality gate compliance indicator."
  measures:
    - name: "total_work_centers"
      expr: COUNT(1)
      comment: "Total number of work centers — baseline for capacity network sizing."
    - name: "total_available_capacity_per_shift"
      expr: SUM(CAST(available_capacity_per_shift AS DOUBLE))
      comment: "Total available capacity per shift across all work centers — aggregate capacity supply measure."
    - name: "avg_available_capacity_per_shift"
      expr: AVG(CAST(available_capacity_per_shift AS DOUBLE))
      comment: "Average available capacity per shift per work center — capacity planning baseline."
    - name: "avg_efficiency_rate_percent"
      expr: AVG(CAST(efficiency_rate_percent AS DOUBLE))
      comment: "Average efficiency rate across work centers — measures actual vs. standard output rate."
    - name: "avg_utilization_rate_percent"
      expr: AVG(CAST(utilization_rate_percent AS DOUBLE))
      comment: "Average utilization rate across work centers — capacity consumption vs. available capacity."
    - name: "avg_oee_baseline_target_percent"
      expr: AVG(CAST(oee_baseline_target_percent AS DOUBLE))
      comment: "Average OEE baseline target across work centers — strategic performance target for capacity planning."
    - name: "avg_standard_setup_time_minutes"
      expr: AVG(CAST(standard_setup_time_minutes AS DOUBLE))
      comment: "Average standard setup time across work centers — changeover efficiency benchmark."
    - name: "avg_standard_processing_time_minutes"
      expr: AVG(CAST(standard_processing_time_minutes AS DOUBLE))
      comment: "Average standard processing time across work centers — cycle time benchmark for scheduling."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`production_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Production schedule adherence and planning KPIs — measures schedule attainment, capacity requirements, and planning horizon to drive S&OP and production planning decisions."
  source: "`vibe_manufacturing_v1`.`production`.`production_schedule`"
  dimensions:
    - name: "schedule_status"
      expr: schedule_status
      comment: "Status of the production schedule (e.g. Planned, Released, Completed, Cancelled)."
    - name: "schedule_type"
      expr: schedule_type
      comment: "Type of schedule (e.g. MRP, Manual, APS) for planning source analysis."
    - name: "schedule_source"
      expr: schedule_source
      comment: "Source system or process that generated the schedule — data lineage and planning process indicator."
    - name: "scheduled_start_date_month"
      expr: DATE_TRUNC('month', scheduled_start_date)
      comment: "Month of scheduled start date for time-series schedule volume analysis."
    - name: "firmed_flag"
      expr: firmed_flag
      comment: "Whether the schedule is firmed — distinguishes committed from tentative production plans."
    - name: "approval_required_flag"
      expr: approval_required_flag
      comment: "Whether approval is required — governance and change management indicator."
  measures:
    - name: "total_schedule_records"
      expr: COUNT(1)
      comment: "Total number of production schedule records — baseline for planning volume."
    - name: "total_planned_quantity"
      expr: SUM(CAST(planned_quantity AS DOUBLE))
      comment: "Total planned production quantity across schedules — aggregate scheduled output volume."
    - name: "total_capacity_requirement_hours"
      expr: SUM(CAST(capacity_requirement_hours AS DOUBLE))
      comment: "Total capacity hours required by the schedule — input to capacity requirements planning."
    - name: "total_lot_size_quantity"
      expr: SUM(CAST(lot_size_quantity AS DOUBLE))
      comment: "Total lot size quantity across schedules — measures batch sizing decisions and their aggregate impact."
    - name: "total_safety_stock_quantity"
      expr: SUM(CAST(safety_stock_quantity AS DOUBLE))
      comment: "Total safety stock quantity planned — inventory buffer investment measure."
    - name: "avg_run_time_hours"
      expr: AVG(CAST(run_time_hours AS DOUBLE))
      comment: "Average run time hours per schedule record — production time planning benchmark."
    - name: "avg_setup_time_hours"
      expr: AVG(CAST(setup_time_hours AS DOUBLE))
      comment: "Average setup time hours per schedule record — changeover planning efficiency indicator."
    - name: "total_firmed_schedules"
      expr: COUNT(CASE WHEN firmed_flag = TRUE THEN 1 END)
      comment: "Count of firmed production schedules — measures planning stability and commitment horizon."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`production_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Production line capacity and efficiency KPIs — measures OEE, throughput, cycle time, and energy consumption to drive capital investment and operational improvement decisions."
  source: "`vibe_manufacturing_v1`.`production`.`production_line`"
  dimensions:
    - name: "line_type"
      expr: line_type
      comment: "Type of production line (e.g. Assembly, Machining, Packaging) for capacity segmentation."
    - name: "automation_level"
      expr: automation_level
      comment: "Level of automation on the line — used to segment OEE and throughput by automation investment."
    - name: "capacity_constraint_flag"
      expr: capacity_constraint_flag
      comment: "Whether the line is a capacity constraint — identifies bottleneck lines for investment prioritization."
    - name: "environmental_compliance_flag"
      expr: environmental_compliance_flag
      comment: "Whether the line meets environmental compliance requirements — ESG and regulatory risk indicator."
    - name: "quality_inspection_required_flag"
      expr: quality_inspection_required_flag
      comment: "Whether quality inspection is required on this line — quality gate compliance indicator."
  measures:
    - name: "total_production_lines"
      expr: COUNT(1)
      comment: "Total number of production lines — baseline for capacity network sizing."
    - name: "avg_actual_oee_percentage"
      expr: AVG(CAST(actual_oee_percentage AS DOUBLE))
      comment: "Average actual OEE percentage across production lines — primary line efficiency KPI for executive dashboards."
    - name: "avg_target_oee_percentage"
      expr: AVG(CAST(target_oee_percentage AS DOUBLE))
      comment: "Average target OEE percentage across lines — strategic performance target for gap analysis."
    - name: "avg_design_throughput_rate"
      expr: AVG(CAST(design_throughput_rate AS DOUBLE))
      comment: "Average design throughput rate across lines — nameplate capacity benchmark."
    - name: "avg_cycle_time_seconds"
      expr: AVG(CAST(cycle_time_seconds AS DOUBLE))
      comment: "Average cycle time in seconds across lines — production speed benchmark."
    - name: "avg_takt_time_seconds"
      expr: AVG(CAST(takt_time_seconds AS DOUBLE))
      comment: "Average takt time in seconds across lines — customer demand rate benchmark for line balancing."
    - name: "avg_changeover_time_minutes"
      expr: AVG(CAST(changeover_time_minutes AS DOUBLE))
      comment: "Average changeover time in minutes across lines — SMED and lean improvement indicator."
    - name: "avg_planned_availability_hours_per_day"
      expr: AVG(CAST(planned_availability_hours_per_day AS DOUBLE))
      comment: "Average planned availability hours per day across lines — capacity supply baseline."
    - name: "avg_energy_consumption_kwh_per_unit"
      expr: AVG(CAST(energy_consumption_kwh_per_unit AS DOUBLE))
      comment: "Average energy consumption per unit produced — sustainability and operational cost KPI."
    - name: "avg_mtbf_hours"
      expr: AVG(CAST(mtbf_hours AS DOUBLE))
      comment: "Average Mean Time Between Failures across lines — reliability and maintenance investment indicator."
    - name: "avg_mttr_hours"
      expr: AVG(CAST(mttr_hours AS DOUBLE))
      comment: "Average Mean Time To Repair across lines — maintenance responsiveness KPI."
    - name: "total_constrained_lines"
      expr: COUNT(CASE WHEN capacity_constraint_flag = TRUE THEN 1 END)
      comment: "Count of lines flagged as capacity constraints — bottleneck identification for investment decisions."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`production_plant`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Plant-level strategic KPIs — measures OEE, energy, carbon, waste, and safety performance across the manufacturing network for executive and ESG reporting."
  source: "`vibe_manufacturing_v1`.`production`.`production_plant`"
  dimensions:
    - name: "plant_type"
      expr: plant_type
      comment: "Type of plant (e.g. Assembly, Fabrication, Distribution) for network segmentation."
    - name: "production_plant_status"
      expr: production_plant_status
      comment: "Operational status of the plant (e.g. Active, Closed, Under Construction)."
    - name: "region"
      expr: region
      comment: "Geographic region of the plant for regional performance benchmarking."
    - name: "country_code"
      expr: country_code
      comment: "Country of the plant for regulatory and ESG reporting segmentation."
    - name: "is_active"
      expr: is_active
      comment: "Whether the plant is currently active — filters operational vs. closed plants."
  measures:
    - name: "total_plants"
      expr: COUNT(1)
      comment: "Total number of plants in the manufacturing network — baseline for network capacity assessment."
    - name: "avg_oee_actual"
      expr: AVG(CAST(oee_actual AS DOUBLE))
      comment: "Average actual OEE across plants — primary plant efficiency KPI for executive benchmarking."
    - name: "avg_oee_target"
      expr: AVG(CAST(oee_target AS DOUBLE))
      comment: "Average OEE target across plants — strategic performance target for gap analysis."
    - name: "total_capacity_mw"
      expr: SUM(CAST(capacity_mw AS DOUBLE))
      comment: "Total installed capacity in MW across the plant network — capital asset utilization measure."
    - name: "total_energy_consumption_mwh"
      expr: SUM(CAST(energy_consumption_mwh AS DOUBLE))
      comment: "Total energy consumption in MWh across plants — sustainability and operational cost KPI."
    - name: "total_carbon_emission_kg"
      expr: SUM(CAST(carbon_emission_kg AS DOUBLE))
      comment: "Total carbon emissions in kg across plants — ESG and regulatory compliance KPI."
    - name: "total_waste_generated_tons"
      expr: SUM(CAST(waste_generated_tons AS DOUBLE))
      comment: "Total waste generated in tons across plants — sustainability and environmental compliance KPI."
    - name: "total_water_consumption_m3"
      expr: SUM(CAST(water_consumption_m3 AS DOUBLE))
      comment: "Total water consumption in cubic meters across plants — environmental stewardship KPI."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`production_routing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Routing efficiency KPIs — measures standard times, operation counts, and cost to evaluate process design quality and identify routing optimization opportunities."
  source: "`vibe_manufacturing_v1`.`production`.`routing`"
  dimensions:
    - name: "routing_status"
      expr: routing_status
      comment: "Status of the routing (e.g. Active, Obsolete, In Review) for filtering valid routings."
    - name: "routing_type"
      expr: routing_type
      comment: "Type of routing (e.g. Standard, Reference, Rate) for process design segmentation."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the routing — governance and change control indicator."
    - name: "is_default_routing"
      expr: is_default_routing
      comment: "Whether this is the default routing for the material — used to filter primary process paths."
    - name: "scheduling_type"
      expr: scheduling_type
      comment: "Scheduling type for the routing — determines capacity planning approach."
  measures:
    - name: "total_routings"
      expr: COUNT(1)
      comment: "Total number of routings — baseline for process design coverage."
    - name: "avg_total_labor_time_minutes"
      expr: AVG(CAST(total_labor_time_minutes AS DOUBLE))
      comment: "Average total labor time per routing — labor content benchmark for cost estimation."
    - name: "avg_total_machine_time_minutes"
      expr: AVG(CAST(total_machine_time_minutes AS DOUBLE))
      comment: "Average total machine time per routing — machine capacity requirement benchmark."
    - name: "avg_total_setup_time_minutes"
      expr: AVG(CAST(total_setup_time_minutes AS DOUBLE))
      comment: "Average total setup time per routing — changeover efficiency benchmark across process designs."
    - name: "avg_total_lead_time_hours"
      expr: AVG(CAST(total_lead_time_hours AS DOUBLE))
      comment: "Average total lead time per routing — manufacturing lead time benchmark for delivery promise."
    - name: "avg_total_operation_count"
      expr: AVG(CAST(total_operation_count AS DOUBLE))
      comment: "Average number of operations per routing — process complexity indicator for lean analysis."
    - name: "avg_standard_cost_amount"
      expr: AVG(CAST(standard_cost_amount AS DOUBLE))
      comment: "Average standard cost per routing — process cost benchmark for product costing."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`production_work_order_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Work order allocation KPIs — measures allocation volumes, fulfillment rates, and consumption against plan to drive production scheduling and order fulfillment decisions."
  source: "`vibe_manufacturing_v1`.`production`.`work_order_allocation`"
  dimensions:
    - name: "allocation_status"
      expr: allocation_status
      comment: "Status of the allocation (e.g. Allocated, Partially Consumed, Closed) for pipeline visibility."
    - name: "allocation_type"
      expr: allocation_type
      comment: "Type of allocation (e.g. Make-to-Order, Make-to-Stock) for demand fulfillment segmentation."
    - name: "allocation_priority"
      expr: allocation_priority
      comment: "Priority of the allocation — used for scheduling and expediting decisions."
    - name: "allocation_date_month"
      expr: DATE_TRUNC('month', allocation_date)
      comment: "Month of allocation date for time-series allocation volume trending."
  measures:
    - name: "total_allocations"
      expr: COUNT(1)
      comment: "Total number of work order allocations — baseline for allocation activity volume."
    - name: "total_allocated_quantity"
      expr: SUM(CAST(allocated_quantity AS DOUBLE))
      comment: "Total quantity allocated to work orders — measures production commitment against demand."
    - name: "total_remaining_quantity"
      expr: SUM(CAST(remaining_quantity AS DOUBLE))
      comment: "Total remaining quantity not yet consumed — open allocation backlog measure."
$$;