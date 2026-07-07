-- Metric views for domain: production | Business: Manufacturing | Version: 2 | Generated on: 2026-07-03 07:46:30

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`production_work_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core production work order KPIs tracking manufacturing efficiency, quality, cost, and throughput performance"
  source: "`vibe_manufacturing_v1`.`production`.`production_work_order`"
  dimensions:
    - name: "work_order_status"
      expr: work_order_status
      comment: "Current status of the production work order (e.g., Released, In Progress, Completed, Closed)"
    - name: "work_order_type"
      expr: work_order_type
      comment: "Type classification of work order (e.g., Standard, Rework, Prototype)"
    - name: "priority_code"
      expr: priority_code
      comment: "Priority level assigned to the work order"
    - name: "planned_start_month"
      expr: DATE_TRUNC('MONTH', planned_start_date)
      comment: "Month when production was planned to start"
    - name: "planned_finish_month"
      expr: DATE_TRUNC('MONTH', planned_finish_date)
      comment: "Month when production was planned to finish"
    - name: "actual_start_month"
      expr: DATE_TRUNC('MONTH', actual_start_timestamp)
      comment: "Month when production actually started"
    - name: "actual_finish_month"
      expr: DATE_TRUNC('MONTH', actual_finish_timestamp)
      comment: "Month when production actually finished"
    - name: "release_month"
      expr: DATE_TRUNC('MONTH', release_date)
      comment: "Month when work order was released to production floor"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency used for cost tracking"
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for quantities produced"
  measures:
    - name: "total_work_orders"
      expr: COUNT(1)
      comment: "Total number of production work orders"
    - name: "total_planned_quantity"
      expr: SUM(CAST(planned_quantity AS DOUBLE))
      comment: "Total planned production quantity across all work orders"
    - name: "total_actual_quantity"
      expr: SUM(CAST(actual_quantity AS DOUBLE))
      comment: "Total actual production quantity delivered"
    - name: "total_scrap_quantity"
      expr: SUM(CAST(scrap_quantity AS DOUBLE))
      comment: "Total quantity scrapped during production"
    - name: "avg_yield_rate_pct"
      expr: AVG(CAST(yield_rate_percentage AS DOUBLE))
      comment: "Average yield rate percentage across work orders (good units / total units started)"
    - name: "avg_scrap_rate_pct"
      expr: AVG(CAST(scrap_rate_percentage AS DOUBLE))
      comment: "Average scrap rate percentage (scrapped units / total units)"
    - name: "avg_oee_pct"
      expr: AVG(CAST(oee_percentage AS DOUBLE))
      comment: "Average Overall Equipment Effectiveness percentage (availability × performance × quality)"
    - name: "avg_completion_pct"
      expr: AVG(CAST(completion_percentage AS DOUBLE))
      comment: "Average completion percentage of work orders"
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual production cost incurred"
    - name: "total_standard_cost"
      expr: SUM(CAST(standard_cost AS DOUBLE))
      comment: "Total standard (budgeted) production cost"
    - name: "total_wip_value"
      expr: SUM(CAST(wip_value AS DOUBLE))
      comment: "Total work-in-progress inventory value"
    - name: "avg_cycle_time_minutes"
      expr: AVG(CAST(cycle_time_minutes AS DOUBLE))
      comment: "Average cycle time per work order in minutes (actual production time)"
    - name: "avg_setup_time_minutes"
      expr: AVG(CAST(setup_time_minutes AS DOUBLE))
      comment: "Average setup time per work order in minutes"
    - name: "avg_downtime_minutes"
      expr: AVG(CAST(downtime_minutes AS DOUBLE))
      comment: "Average downtime per work order in minutes"
    - name: "avg_takt_time_minutes"
      expr: AVG(CAST(takt_time_minutes AS DOUBLE))
      comment: "Average takt time (available production time / customer demand) in minutes"
    - name: "total_cycle_time_minutes"
      expr: SUM(CAST(cycle_time_minutes AS DOUBLE))
      comment: "Total cycle time across all work orders in minutes"
    - name: "total_downtime_minutes"
      expr: SUM(CAST(downtime_minutes AS DOUBLE))
      comment: "Total downtime across all work orders in minutes"
    - name: "distinct_plants"
      expr: COUNT(DISTINCT plant_id)
      comment: "Number of distinct plants executing work orders"
    - name: "distinct_production_lines"
      expr: COUNT(DISTINCT production_line_id)
      comment: "Number of distinct production lines used"
    - name: "distinct_materials"
      expr: COUNT(DISTINCT material_master_id)
      comment: "Number of distinct materials being produced"
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`production_downtime_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Production downtime and equipment reliability KPIs for root cause analysis and MTTR tracking"
  source: "`vibe_manufacturing_v1`.`production`.`production_downtime_event`"
  dimensions:
    - name: "downtime_category"
      expr: downtime_category
      comment: "High-level category of downtime (e.g., Planned, Unplanned, Breakdown)"
    - name: "downtime_type"
      expr: downtime_type
      comment: "Specific type of downtime event"
    - name: "downtime_reason"
      expr: downtime_reason
      comment: "Reason code or description for the downtime"
    - name: "root_cause_code"
      expr: root_cause_code
      comment: "Root cause classification code"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of the downtime event (e.g., Critical, High, Medium, Low)"
    - name: "responsible_department"
      expr: responsible_department
      comment: "Department responsible for resolving the downtime"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the downtime event record"
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', start_timestamp)
      comment: "Month when downtime event started"
    - name: "shift_date"
      expr: shift_date
      comment: "Date of the shift when downtime occurred"
    - name: "is_recurring"
      expr: is_recurring
      comment: "Flag indicating if this is a recurring downtime issue"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for production loss valuation"
  measures:
    - name: "total_downtime_events"
      expr: COUNT(1)
      comment: "Total number of downtime events recorded"
    - name: "total_downtime_minutes"
      expr: SUM(CAST(duration_minutes AS DOUBLE))
      comment: "Total downtime duration in minutes"
    - name: "avg_downtime_minutes"
      expr: AVG(CAST(duration_minutes AS DOUBLE))
      comment: "Average downtime duration per event in minutes"
    - name: "avg_mttr_minutes"
      expr: AVG(CAST(mttr_minutes AS DOUBLE))
      comment: "Average Mean Time To Repair in minutes (key reliability metric)"
    - name: "total_production_loss_units"
      expr: SUM(CAST(production_loss_units AS DOUBLE))
      comment: "Total production units lost due to downtime"
    - name: "total_production_loss_value"
      expr: SUM(CAST(production_loss_value AS DOUBLE))
      comment: "Total financial value of production lost due to downtime"
    - name: "avg_production_loss_value"
      expr: AVG(CAST(production_loss_value AS DOUBLE))
      comment: "Average financial loss per downtime event"
    - name: "avg_impact_on_oee"
      expr: AVG(CAST(impact_on_oee AS DOUBLE))
      comment: "Average impact on Overall Equipment Effectiveness percentage"
    - name: "distinct_work_centers"
      expr: COUNT(DISTINCT work_center_id)
      comment: "Number of distinct work centers experiencing downtime"
    - name: "distinct_equipment"
      expr: COUNT(DISTINCT equipment_register_id)
      comment: "Number of distinct equipment units experiencing downtime"
    - name: "recurring_events"
      expr: COUNT(CASE WHEN is_recurring = TRUE THEN 1 END)
      comment: "Count of recurring downtime events requiring systematic resolution"
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`production_bom_consumption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bill of Materials consumption and material usage variance KPIs for production cost control"
  source: "`vibe_manufacturing_v1`.`production`.`bom_consumption`"
  dimensions:
    - name: "consumption_status"
      expr: consumption_status
      comment: "Status of the consumption transaction (e.g., Posted, Reversed, Pending)"
    - name: "consumption_type"
      expr: consumption_type
      comment: "Type of consumption (e.g., Planned, Backflush, Manual)"
    - name: "movement_type"
      expr: movement_type
      comment: "Material movement type code"
    - name: "backflush_indicator"
      expr: backflush_indicator
      comment: "Flag indicating if consumption was backflushed automatically"
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Flag indicating if this is a reversal transaction"
    - name: "quality_inspection_required"
      expr: quality_inspection_required
      comment: "Flag indicating if quality inspection was required for consumed material"
    - name: "posting_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month when consumption was posted to inventory"
    - name: "goods_issue_month"
      expr: DATE_TRUNC('MONTH', goods_issue_timestamp)
      comment: "Month when goods were issued from inventory"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for cost tracking"
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for consumed quantities"
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for the consumption transaction"
    - name: "variance_reason_code"
      expr: variance_reason_code
      comment: "Reason code explaining quantity variance from plan"
  measures:
    - name: "total_consumption_transactions"
      expr: COUNT(1)
      comment: "Total number of BOM consumption transactions"
    - name: "total_planned_quantity"
      expr: SUM(CAST(planned_quantity AS DOUBLE))
      comment: "Total planned material consumption quantity"
    - name: "total_actual_quantity"
      expr: SUM(CAST(actual_quantity AS DOUBLE))
      comment: "Total actual material consumption quantity"
    - name: "total_variance_quantity"
      expr: SUM(CAST(variance_quantity AS DOUBLE))
      comment: "Total quantity variance (actual minus planned)"
    - name: "total_scrap_quantity"
      expr: SUM(CAST(scrap_quantity AS DOUBLE))
      comment: "Total quantity scrapped during consumption"
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost of materials consumed"
    - name: "total_standard_cost"
      expr: SUM(CAST(standard_cost AS DOUBLE))
      comment: "Total standard (budgeted) cost of materials consumed"
    - name: "total_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total cost including all adjustments"
    - name: "avg_actual_cost"
      expr: AVG(CAST(actual_cost AS DOUBLE))
      comment: "Average actual cost per consumption transaction"
    - name: "distinct_materials"
      expr: COUNT(DISTINCT material_master_id)
      comment: "Number of distinct materials consumed"
    - name: "distinct_work_orders"
      expr: COUNT(DISTINCT production_work_order_id)
      comment: "Number of distinct work orders consuming materials"
    - name: "distinct_work_centers"
      expr: COUNT(DISTINCT work_center_id)
      comment: "Number of distinct work centers consuming materials"
    - name: "backflush_transactions"
      expr: COUNT(CASE WHEN backflush_indicator = TRUE THEN 1 END)
      comment: "Count of backflushed consumption transactions"
    - name: "reversal_transactions"
      expr: COUNT(CASE WHEN reversal_indicator = TRUE THEN 1 END)
      comment: "Count of reversed consumption transactions"
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`production_goods_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Production output and goods receipt KPIs tracking yield, quality inspection, and finished goods flow"
  source: "`vibe_manufacturing_v1`.`production`.`production_goods_receipt`"
  dimensions:
    - name: "gr_status"
      expr: gr_status
      comment: "Status of the goods receipt (e.g., Posted, Reversed, Pending)"
    - name: "movement_type"
      expr: movement_type
      comment: "Material movement type code for the receipt"
    - name: "stock_type"
      expr: stock_type
      comment: "Type of stock received (e.g., Unrestricted, Quality Inspection, Blocked)"
    - name: "quality_inspection_required"
      expr: quality_inspection_required
      comment: "Flag indicating if quality inspection is required for received goods"
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Flag indicating if this is a reversal transaction"
    - name: "posting_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month when goods receipt was posted"
    - name: "document_month"
      expr: DATE_TRUNC('MONTH', document_date)
      comment: "Month of the goods receipt document"
    - name: "receipt_month"
      expr: DATE_TRUNC('MONTH', receipt_timestamp)
      comment: "Month when goods were physically received"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the goods receipt"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the goods receipt"
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for received quantities"
    - name: "valuation_type"
      expr: valuation_type
      comment: "Valuation type for inventory accounting"
  measures:
    - name: "total_goods_receipts"
      expr: COUNT(1)
      comment: "Total number of production goods receipt transactions"
    - name: "total_order_quantity"
      expr: SUM(CAST(order_quantity AS DOUBLE))
      comment: "Total ordered quantity for production"
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total quantity received into inventory from production"
    - name: "total_scrap_quantity"
      expr: SUM(CAST(scrap_quantity AS DOUBLE))
      comment: "Total quantity scrapped during production"
    - name: "avg_yield_pct"
      expr: AVG(CAST(yield_percentage AS DOUBLE))
      comment: "Average production yield percentage (received / ordered)"
    - name: "avg_received_quantity"
      expr: AVG(CAST(received_quantity AS DOUBLE))
      comment: "Average quantity received per goods receipt transaction"
    - name: "distinct_work_orders"
      expr: COUNT(DISTINCT production_work_order_id)
      comment: "Number of distinct work orders with goods receipts"
    - name: "distinct_materials"
      expr: COUNT(DISTINCT material_master_id)
      comment: "Number of distinct materials received"
    - name: "distinct_production_lines"
      expr: COUNT(DISTINCT production_line_id)
      comment: "Number of distinct production lines producing output"
    - name: "distinct_warehouses"
      expr: COUNT(DISTINCT warehouse_id)
      comment: "Number of distinct warehouses receiving production output"
    - name: "quality_inspection_receipts"
      expr: COUNT(CASE WHEN quality_inspection_required = TRUE THEN 1 END)
      comment: "Count of goods receipts requiring quality inspection"
    - name: "reversal_receipts"
      expr: COUNT(CASE WHEN reversal_indicator = TRUE THEN 1 END)
      comment: "Count of reversed goods receipt transactions"
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`production_plant`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Manufacturing plant performance, sustainability, and safety KPIs for facility management"
  source: "`vibe_manufacturing_v1`.`production`.`plant`"
  dimensions:
    - name: "plant_type"
      expr: plant_type
      comment: "Type classification of the plant (e.g., Assembly, Fabrication, Packaging)"
    - name: "production_plant_status"
      expr: production_plant_status
      comment: "Current operational status of the plant"
    - name: "is_active"
      expr: is_active
      comment: "Flag indicating if plant is currently active"
    - name: "region"
      expr: region
      comment: "Geographic region of the plant"
    - name: "country_code"
      expr: country_code
      comment: "Country code where plant is located"
    - name: "state_province"
      expr: state_province
      comment: "State or province of the plant"
    - name: "city"
      expr: city
      comment: "City where plant is located"
    - name: "timezone"
      expr: timezone
      comment: "Timezone of the plant location"
  measures:
    - name: "total_plants"
      expr: COUNT(1)
      comment: "Total number of manufacturing plants"
    - name: "active_plants"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Number of active plants currently in operation"
    - name: "total_capacity_mw"
      expr: SUM(CAST(capacity_mw AS DOUBLE))
      comment: "Total production capacity in megawatts across all plants"
    - name: "avg_oee_actual"
      expr: AVG(CAST(oee_actual AS DOUBLE))
      comment: "Average actual Overall Equipment Effectiveness across plants"
    - name: "avg_oee_target"
      expr: AVG(CAST(oee_target AS DOUBLE))
      comment: "Average target Overall Equipment Effectiveness across plants"
    - name: "total_energy_consumption_mwh"
      expr: SUM(CAST(energy_consumption_mwh AS DOUBLE))
      comment: "Total energy consumption in megawatt-hours (sustainability metric)"
    - name: "total_carbon_emission_kg"
      expr: SUM(CAST(carbon_emission_kg AS DOUBLE))
      comment: "Total carbon emissions in kilograms (environmental impact metric)"
    - name: "total_water_consumption_m3"
      expr: SUM(CAST(water_consumption_m3 AS DOUBLE))
      comment: "Total water consumption in cubic meters (sustainability metric)"
    - name: "total_waste_generated_tons"
      expr: SUM(CAST(waste_generated_tons AS DOUBLE))
      comment: "Total waste generated in tons (environmental metric)"
    - name: "avg_energy_consumption_mwh"
      expr: AVG(CAST(energy_consumption_mwh AS DOUBLE))
      comment: "Average energy consumption per plant in megawatt-hours"
    - name: "avg_carbon_emission_kg"
      expr: AVG(CAST(carbon_emission_kg AS DOUBLE))
      comment: "Average carbon emissions per plant in kilograms"
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`production_work_center`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Work center capacity, utilization, and efficiency KPIs for production planning and scheduling"
  source: "`vibe_manufacturing_v1`.`production`.`work_center`"
  dimensions:
    - name: "work_center_status"
      expr: work_center_status
      comment: "Current operational status of the work center"
    - name: "category"
      expr: category
      comment: "Category classification of the work center"
    - name: "capacity_category"
      expr: capacity_category
      comment: "Capacity category for planning purposes"
    - name: "scheduling_type"
      expr: scheduling_type
      comment: "Type of scheduling logic applied to the work center"
    - name: "quality_inspection_required"
      expr: quality_inspection_required
      comment: "Flag indicating if quality inspection is required at this work center"
    - name: "capacity_planning_group"
      expr: capacity_planning_group
      comment: "Planning group for capacity management"
    - name: "control_key"
      expr: control_key
      comment: "Control key defining work center behavior"
  measures:
    - name: "total_work_centers"
      expr: COUNT(1)
      comment: "Total number of work centers"
    - name: "total_available_capacity_per_shift"
      expr: SUM(CAST(available_capacity_per_shift AS DOUBLE))
      comment: "Total available production capacity per shift across all work centers"
    - name: "avg_available_capacity_per_shift"
      expr: AVG(CAST(available_capacity_per_shift AS DOUBLE))
      comment: "Average available capacity per shift per work center"
    - name: "avg_efficiency_rate_pct"
      expr: AVG(CAST(efficiency_rate_percent AS DOUBLE))
      comment: "Average efficiency rate percentage across work centers"
    - name: "avg_utilization_rate_pct"
      expr: AVG(CAST(utilization_rate_percent AS DOUBLE))
      comment: "Average utilization rate percentage (actual usage / available capacity)"
    - name: "avg_oee_baseline_target_pct"
      expr: AVG(CAST(oee_baseline_target_percent AS DOUBLE))
      comment: "Average OEE baseline target percentage for work centers"
    - name: "avg_standard_setup_time_minutes"
      expr: AVG(CAST(standard_setup_time_minutes AS DOUBLE))
      comment: "Average standard setup time per work center in minutes"
    - name: "avg_standard_processing_time_minutes"
      expr: AVG(CAST(standard_processing_time_minutes AS DOUBLE))
      comment: "Average standard processing time per work center in minutes"
    - name: "avg_standard_teardown_time_minutes"
      expr: AVG(CAST(standard_teardown_time_minutes AS DOUBLE))
      comment: "Average standard teardown time per work center in minutes"
    - name: "avg_standard_queue_time_hours"
      expr: AVG(CAST(standard_queue_time_hours AS DOUBLE))
      comment: "Average standard queue time per work center in hours"
    - name: "distinct_plants"
      expr: COUNT(DISTINCT plant_id)
      comment: "Number of distinct plants containing work centers"
    - name: "distinct_production_lines"
      expr: COUNT(DISTINCT production_line_id)
      comment: "Number of distinct production lines associated with work centers"
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`production_wip_lot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Work-in-progress lot tracking KPIs for production flow, quality holds, and lot traceability"
  source: "`vibe_manufacturing_v1`.`production`.`wip_lot`"
  dimensions:
    - name: "lot_status"
      expr: lot_status
      comment: "Current status of the WIP lot (e.g., In Process, On Hold, Completed, Scrapped)"
    - name: "priority_code"
      expr: priority_code
      comment: "Priority level assigned to the lot"
    - name: "rework_flag"
      expr: rework_flag
      comment: "Flag indicating if this lot is undergoing rework"
    - name: "quality_inspection_required_flag"
      expr: quality_inspection_required_flag
      comment: "Flag indicating if quality inspection is required for this lot"
    - name: "hold_reason_code"
      expr: hold_reason_code
      comment: "Reason code if lot is on hold"
    - name: "scrap_reason_code"
      expr: scrap_reason_code
      comment: "Reason code if lot was scrapped"
    - name: "special_stock_indicator"
      expr: special_stock_indicator
      comment: "Indicator for special stock handling requirements"
    - name: "production_start_month"
      expr: DATE_TRUNC('MONTH', production_start_timestamp)
      comment: "Month when lot production started"
    - name: "scheduled_completion_month"
      expr: DATE_TRUNC('MONTH', scheduled_completion_date)
      comment: "Month when lot is scheduled to complete"
    - name: "actual_completion_month"
      expr: DATE_TRUNC('MONTH', actual_completion_timestamp)
      comment: "Month when lot actually completed"
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for lot quantities"
  measures:
    - name: "total_wip_lots"
      expr: COUNT(1)
      comment: "Total number of work-in-progress lots"
    - name: "total_quantity_ordered"
      expr: SUM(CAST(quantity_ordered AS DOUBLE))
      comment: "Total quantity ordered across all WIP lots"
    - name: "total_quantity_in_process"
      expr: SUM(CAST(quantity_in_process AS DOUBLE))
      comment: "Total quantity currently in process"
    - name: "total_quantity_completed"
      expr: SUM(CAST(quantity_completed AS DOUBLE))
      comment: "Total quantity completed from WIP lots"
    - name: "total_quantity_on_hold"
      expr: SUM(CAST(quantity_on_hold AS DOUBLE))
      comment: "Total quantity on hold (quality or other issues)"
    - name: "total_quantity_scrapped"
      expr: SUM(CAST(quantity_scrapped AS DOUBLE))
      comment: "Total quantity scrapped from WIP lots"
    - name: "avg_quantity_ordered"
      expr: AVG(CAST(quantity_ordered AS DOUBLE))
      comment: "Average lot size ordered"
    - name: "distinct_work_orders"
      expr: COUNT(DISTINCT production_work_order_id)
      comment: "Number of distinct work orders with WIP lots"
    - name: "distinct_materials"
      expr: COUNT(DISTINCT material_master_id)
      comment: "Number of distinct materials in WIP"
    - name: "distinct_work_centers"
      expr: COUNT(DISTINCT current_work_center_id)
      comment: "Number of distinct work centers processing WIP lots"
    - name: "rework_lots"
      expr: COUNT(CASE WHEN rework_flag = TRUE THEN 1 END)
      comment: "Count of lots undergoing rework"
    - name: "lots_on_hold"
      expr: COUNT(CASE WHEN quantity_on_hold > 0 THEN 1 END)
      comment: "Count of lots with quantity on hold"
$$;