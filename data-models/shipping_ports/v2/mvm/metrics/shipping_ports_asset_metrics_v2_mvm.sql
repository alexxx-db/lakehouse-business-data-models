-- Metric views for domain: asset | Business: Shipping_Ports | Version: 2 | Generated on: 2026-07-13 10:21:34

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`asset_port_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core asset performance and financial metrics for port infrastructure and equipment, tracking utilization, reliability, and asset value."
  source: "`vibe_shipping_ports_v1`.`asset`.`port_asset`"
  dimensions:
    - name: "asset_category"
      expr: asset_category
      comment: "Type of port asset (e.g., crane, tug, terminal equipment)"
    - name: "asset_status"
      expr: asset_status
      comment: "Current operational status of the asset"
    - name: "criticality_rating"
      expr: criticality_rating
      comment: "Business criticality classification of the asset"
    - name: "maintenance_strategy"
      expr: maintenance_strategy
      comment: "Maintenance approach applied to the asset"
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Accounting depreciation method used"
    - name: "capex_classification"
      expr: capex_classification
      comment: "Capital expenditure classification"
    - name: "commissioning_year"
      expr: YEAR(commissioning_date)
      comment: "Year the asset was commissioned"
    - name: "environmental_compliance_flag"
      expr: environmental_compliance_flag
      comment: "Whether asset meets environmental compliance standards"
  measures:
    - name: "total_asset_count"
      expr: COUNT(1)
      comment: "Total number of port assets"
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total capital invested in acquiring assets"
    - name: "total_current_book_value"
      expr: SUM(CAST(current_book_value AS DOUBLE))
      comment: "Total current book value of all assets"
    - name: "total_residual_value"
      expr: SUM(CAST(residual_value AS DOUBLE))
      comment: "Total estimated residual value of assets at end of useful life"
    - name: "avg_asset_age_years"
      expr: AVG(DATEDIFF(CURRENT_DATE(), commissioning_date) / 365.25)
      comment: "Average age of assets in years since commissioning"
    - name: "total_operating_hours"
      expr: SUM(CAST(operating_hours AS DOUBLE))
      comment: "Total operating hours across all assets"
    - name: "avg_operating_hours_per_asset"
      expr: AVG(CAST(operating_hours AS DOUBLE))
      comment: "Average operating hours per asset"
    - name: "avg_mtbf_hours"
      expr: AVG(CAST(mean_time_between_failures AS DOUBLE))
      comment: "Average mean time between failures across assets, indicating reliability"
    - name: "avg_mttr_hours"
      expr: AVG(CAST(mean_time_to_repair AS DOUBLE))
      comment: "Average mean time to repair across assets, indicating maintainability"
    - name: "asset_availability_pct"
      expr: ROUND(100.0 * AVG(CAST(mean_time_between_failures AS DOUBLE) / NULLIF(CAST(mean_time_between_failures AS DOUBLE) + CAST(mean_time_to_repair AS DOUBLE), 0)), 2)
      comment: "Average asset availability percentage based on MTBF and MTTR"
    - name: "depreciation_rate_pct"
      expr: ROUND(100.0 * AVG((CAST(acquisition_cost AS DOUBLE) - CAST(current_book_value AS DOUBLE)) / NULLIF(CAST(acquisition_cost AS DOUBLE), 0)), 2)
      comment: "Average depreciation rate as percentage of original acquisition cost"
    - name: "total_swl_capacity_tonnes"
      expr: SUM(CAST(swl_rating AS DOUBLE))
      comment: "Total safe working load capacity across all assets in tonnes"
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`asset_work_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Work order execution and maintenance cost metrics, tracking efficiency, timeliness, and resource utilization in asset maintenance operations."
  source: "`vibe_shipping_ports_v1`.`asset`.`work_order`"
  dimensions:
    - name: "work_order_type"
      expr: work_order_type
      comment: "Type of maintenance work order (preventive, corrective, emergency)"
    - name: "work_order_status"
      expr: work_order_status
      comment: "Current status of the work order"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority classification of the work order"
    - name: "failure_code"
      expr: failure_code
      comment: "Code identifying the type of failure addressed"
    - name: "root_cause_code"
      expr: root_cause_code
      comment: "Root cause classification for the maintenance need"
    - name: "parts_availability_status"
      expr: parts_availability_status
      comment: "Status of spare parts availability for the work order"
    - name: "equipment_shutdown_required_flag"
      expr: equipment_shutdown_required_flag
      comment: "Whether equipment shutdown was required for maintenance"
    - name: "safety_permit_required_flag"
      expr: safety_permit_required_flag
      comment: "Whether safety permit was required for the work"
    - name: "warranty_claim_flag"
      expr: warranty_claim_flag
      comment: "Whether work order is eligible for warranty claim"
    - name: "completion_month"
      expr: DATE_TRUNC('MONTH', completion_datetime)
      comment: "Month when work order was completed"
  measures:
    - name: "total_work_orders"
      expr: COUNT(1)
      comment: "Total number of work orders"
    - name: "total_work_order_cost"
      expr: SUM(CAST(total_work_order_cost AS DOUBLE))
      comment: "Total cost of all work orders including labor, materials, and contractor costs"
    - name: "total_actual_labour_hours"
      expr: SUM(CAST(actual_labour_hours AS DOUBLE))
      comment: "Total actual labor hours spent on work orders"
    - name: "total_estimated_labour_hours"
      expr: SUM(CAST(estimated_labour_hours AS DOUBLE))
      comment: "Total estimated labor hours for work orders"
    - name: "total_actual_material_cost"
      expr: SUM(CAST(actual_material_cost AS DOUBLE))
      comment: "Total actual material costs incurred"
    - name: "total_actual_contractor_cost"
      expr: SUM(CAST(actual_contractor_cost AS DOUBLE))
      comment: "Total actual contractor costs incurred"
    - name: "total_downtime_hours"
      expr: SUM(CAST(downtime_hours AS DOUBLE))
      comment: "Total equipment downtime hours due to maintenance"
    - name: "avg_downtime_per_work_order"
      expr: AVG(CAST(downtime_hours AS DOUBLE))
      comment: "Average downtime hours per work order"
    - name: "avg_work_order_cost"
      expr: AVG(CAST(total_work_order_cost AS DOUBLE))
      comment: "Average cost per work order"
    - name: "labour_variance_hours"
      expr: SUM(CAST(actual_labour_hours AS DOUBLE) - CAST(estimated_labour_hours AS DOUBLE))
      comment: "Total variance between actual and estimated labor hours"
    - name: "cost_variance_total"
      expr: SUM(CAST(total_work_order_cost AS DOUBLE) - (CAST(estimated_material_cost AS DOUBLE) + CAST(estimated_contractor_cost AS DOUBLE) + CAST(estimated_labour_hours AS DOUBLE)))
      comment: "Total cost variance between actual and estimated costs"
    - name: "schedule_adherence_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN actual_end_datetime <= planned_end_datetime THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of work orders completed on or before planned end date"
    - name: "warranty_claim_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN warranty_claim_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of work orders eligible for warranty claims"
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`asset_failure_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Asset failure and incident metrics tracking failure patterns, severity, recurrence, and operational impact to drive reliability improvements."
  source: "`vibe_shipping_ports_v1`.`asset`.`failure_report`"
  dimensions:
    - name: "failure_severity"
      expr: failure_severity
      comment: "Severity classification of the failure"
    - name: "failure_mode"
      expr: failure_mode
      comment: "Mode or mechanism of failure"
    - name: "failure_class"
      expr: failure_class
      comment: "Classification category of the failure"
    - name: "root_cause"
      expr: root_cause
      comment: "Identified root cause of the failure"
    - name: "affected_system"
      expr: affected_system
      comment: "System affected by the failure"
    - name: "affected_component"
      expr: affected_component
      comment: "Component affected by the failure"
    - name: "priority"
      expr: priority
      comment: "Priority level assigned to the failure"
    - name: "report_status"
      expr: report_status
      comment: "Current status of the failure report"
    - name: "failure_recurrence_flag"
      expr: failure_recurrence_flag
      comment: "Whether this is a recurring failure"
    - name: "safety_incident_flag"
      expr: safety_incident_flag
      comment: "Whether failure resulted in a safety incident"
    - name: "environmental_impact_flag"
      expr: environmental_impact_flag
      comment: "Whether failure had environmental impact"
    - name: "swl_exceeded_flag"
      expr: swl_exceeded_flag
      comment: "Whether safe working load was exceeded at time of failure"
    - name: "warranty_claim_eligible_flag"
      expr: warranty_claim_eligible_flag
      comment: "Whether failure is eligible for warranty claim"
    - name: "failure_month"
      expr: DATE_TRUNC('MONTH', failure_datetime)
      comment: "Month when failure occurred"
  measures:
    - name: "total_failures"
      expr: COUNT(1)
      comment: "Total number of asset failures reported"
    - name: "total_downtime_hours"
      expr: SUM(CAST(downtime_hours AS DOUBLE))
      comment: "Total downtime hours caused by failures"
    - name: "avg_downtime_per_failure"
      expr: AVG(CAST(downtime_hours AS DOUBLE))
      comment: "Average downtime hours per failure event"
    - name: "total_estimated_repair_cost"
      expr: SUM(CAST(estimated_repair_cost AS DOUBLE))
      comment: "Total estimated cost to repair all failures"
    - name: "avg_repair_cost_per_failure"
      expr: AVG(CAST(estimated_repair_cost AS DOUBLE))
      comment: "Average estimated repair cost per failure"
    - name: "avg_cycles_at_failure"
      expr: AVG(CAST(cycles_at_failure AS DOUBLE))
      comment: "Average number of operating cycles at time of failure"
    - name: "avg_operating_hours_at_failure"
      expr: AVG(CAST(operating_hours_at_failure AS DOUBLE))
      comment: "Average operating hours accumulated at time of failure"
    - name: "failure_recurrence_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN failure_recurrence_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of failures that are recurring issues"
    - name: "safety_incident_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN safety_incident_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of failures resulting in safety incidents"
    - name: "environmental_impact_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN environmental_impact_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of failures with environmental impact"
    - name: "swl_violation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN swl_exceeded_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of failures where safe working load was exceeded"
    - name: "warranty_eligible_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN warranty_claim_eligible_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of failures eligible for warranty claims"
    - name: "avg_load_at_failure_tonnes"
      expr: AVG(CAST(load_at_failure_tonnes AS DOUBLE))
      comment: "Average load in tonnes at time of failure"
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`asset_inspection_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Asset inspection compliance and quality metrics tracking inspection outcomes, defect rates, and regulatory compliance status."
  source: "`vibe_shipping_ports_v1`.`asset`.`inspection_record`"
  dimensions:
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection performed"
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current status of the inspection"
    - name: "inspection_outcome"
      expr: inspection_outcome
      comment: "Outcome result of the inspection"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status determined by inspection"
    - name: "inspector_authority"
      expr: inspector_authority
      comment: "Authority or organization conducting the inspection"
    - name: "defect_severity_highest"
      expr: defect_severity_highest
      comment: "Highest severity level of defects found"
    - name: "load_test_performed"
      expr: load_test_performed
      comment: "Whether load testing was performed during inspection"
    - name: "inspection_scope"
      expr: inspection_scope
      comment: "Scope of the inspection"
    - name: "inspection_month"
      expr: DATE_TRUNC('MONTH', inspection_date)
      comment: "Month when inspection was performed"
    - name: "inspection_year"
      expr: YEAR(inspection_date)
      comment: "Year when inspection was performed"
  measures:
    - name: "total_inspections"
      expr: COUNT(1)
      comment: "Total number of inspections performed"
    - name: "total_inspection_cost"
      expr: SUM(CAST(inspection_cost AS DOUBLE))
      comment: "Total cost of all inspections"
    - name: "avg_inspection_cost"
      expr: AVG(CAST(inspection_cost AS DOUBLE))
      comment: "Average cost per inspection"
    - name: "total_defects_identified"
      expr: SUM(CAST(defects_identified_count AS DOUBLE))
      comment: "Total number of defects identified across all inspections"
    - name: "avg_defects_per_inspection"
      expr: AVG(CAST(defects_identified_count AS DOUBLE))
      comment: "Average number of defects found per inspection"
    - name: "compliance_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_status = 'Compliant' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections resulting in compliant status"
    - name: "critical_defect_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN defect_severity_highest = 'Critical' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections finding critical defects"
    - name: "corrective_action_required_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN corrective_actions_required IS NOT NULL AND corrective_actions_required != '' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections requiring corrective actions"
    - name: "load_test_coverage_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN load_test_performed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections that included load testing"
    - name: "avg_load_test_weight_tonnes"
      expr: AVG(CAST(load_test_weight AS DOUBLE))
      comment: "Average load test weight in tonnes when load testing is performed"
    - name: "avg_swl_rating_verified_tonnes"
      expr: AVG(CAST(swl_rating_verified AS DOUBLE))
      comment: "Average safe working load rating verified during inspections"
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`asset_spare_part`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Spare parts inventory and supply chain metrics tracking stock levels, turnover, criticality, and inventory value for maintenance operations."
  source: "`vibe_shipping_ports_v1`.`asset`.`spare_part`"
  dimensions:
    - name: "part_category"
      expr: part_category
      comment: "Category classification of the spare part"
    - name: "abc_classification"
      expr: abc_classification
      comment: "ABC inventory classification based on value and usage"
    - name: "criticality_classification"
      expr: criticality_classification
      comment: "Criticality level of the spare part to operations"
    - name: "spare_part_status"
      expr: spare_part_status
      comment: "Current status of the spare part"
    - name: "obsolescence_status"
      expr: obsolescence_status
      comment: "Obsolescence status of the part"
    - name: "hazardous_material_flag"
      expr: hazardous_material_flag
      comment: "Whether part is classified as hazardous material"
    - name: "imdg_class"
      expr: imdg_class
      comment: "IMDG dangerous goods classification if applicable"
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the spare part"
  measures:
    - name: "total_spare_parts"
      expr: COUNT(1)
      comment: "Total number of unique spare part SKUs"
    - name: "total_inventory_value"
      expr: SUM(CAST(total_stock_value AS DOUBLE))
      comment: "Total value of spare parts inventory on hand"
    - name: "total_quantity_on_hand"
      expr: SUM(CAST(quantity_on_hand AS DOUBLE))
      comment: "Total quantity of spare parts in stock"
    - name: "total_quantity_on_order"
      expr: SUM(CAST(quantity_on_order AS DOUBLE))
      comment: "Total quantity of spare parts on order"
    - name: "total_quantity_reserved"
      expr: SUM(CAST(quantity_reserved AS DOUBLE))
      comment: "Total quantity of spare parts reserved for work orders"
    - name: "total_annual_usage_quantity"
      expr: SUM(CAST(annual_usage_quantity AS DOUBLE))
      comment: "Total annual usage quantity across all spare parts"
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost per spare part"
    - name: "inventory_turnover_ratio"
      expr: ROUND(SUM(CAST(annual_usage_quantity AS DOUBLE)) / NULLIF(SUM(CAST(quantity_on_hand AS DOUBLE)), 0), 2)
      comment: "Inventory turnover ratio indicating how many times inventory is used per year"
    - name: "stockout_risk_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN CAST(quantity_on_hand AS DOUBLE) < CAST(minimum_stock_level AS DOUBLE) THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of parts below minimum stock level indicating stockout risk"
    - name: "excess_inventory_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN CAST(quantity_on_hand AS DOUBLE) > 2 * CAST(reorder_point AS DOUBLE) THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of parts with inventory exceeding twice the reorder point"
    - name: "critical_parts_count"
      expr: COUNT(CASE WHEN criticality_classification = 'Critical' THEN 1 END)
      comment: "Number of spare parts classified as critical"
    - name: "hazardous_parts_count"
      expr: COUNT(CASE WHEN hazardous_material_flag = TRUE THEN 1 END)
      comment: "Number of spare parts classified as hazardous materials"
    - name: "obsolete_parts_count"
      expr: COUNT(CASE WHEN obsolescence_status = 'Obsolete' THEN 1 END)
      comment: "Number of spare parts marked as obsolete"
    - name: "avg_lead_time_days"
      expr: AVG(CAST(lead_time_days AS DOUBLE))
      comment: "Average lead time in days to procure spare parts"
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`asset_maintenance_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Preventive maintenance planning and execution metrics tracking plan adherence, resource requirements, and maintenance effectiveness."
  source: "`vibe_shipping_ports_v1`.`asset`.`maintenance_plan`"
  dimensions:
    - name: "plan_type"
      expr: plan_type
      comment: "Type of maintenance plan (preventive, predictive, condition-based)"
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the maintenance plan"
    - name: "priority"
      expr: priority
      comment: "Priority level of the maintenance plan"
    - name: "maintenance_frequency_unit"
      expr: maintenance_frequency_unit
      comment: "Unit of measurement for maintenance frequency (days, hours, cycles)"
    - name: "regulatory_requirement"
      expr: regulatory_requirement
      comment: "Regulatory requirement driving the maintenance plan"
    - name: "compliance_certificate_required"
      expr: compliance_certificate_required
      comment: "Whether compliance certification is required"
    - name: "auto_generate_work_order"
      expr: auto_generate_work_order
      comment: "Whether work orders are auto-generated from this plan"
    - name: "responsible_department"
      expr: responsible_department
      comment: "Department responsible for executing the plan"
    - name: "seasonal_adjustment"
      expr: seasonal_adjustment
      comment: "Seasonal adjustment applied to the maintenance schedule"
  measures:
    - name: "total_maintenance_plans"
      expr: COUNT(1)
      comment: "Total number of maintenance plans"
    - name: "active_plans_count"
      expr: COUNT(CASE WHEN plan_status = 'Active' THEN 1 END)
      comment: "Number of currently active maintenance plans"
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated cost of all maintenance plans"
    - name: "avg_estimated_cost_per_plan"
      expr: AVG(CAST(estimated_cost AS DOUBLE))
      comment: "Average estimated cost per maintenance plan"
    - name: "total_estimated_downtime_hours"
      expr: SUM(CAST(estimated_downtime_hours AS DOUBLE))
      comment: "Total estimated downtime hours for all planned maintenance"
    - name: "avg_estimated_downtime_per_plan"
      expr: AVG(CAST(estimated_downtime_hours AS DOUBLE))
      comment: "Average estimated downtime hours per maintenance plan"
    - name: "total_estimated_labour_hours"
      expr: SUM(CAST(estimated_labor_hours AS DOUBLE))
      comment: "Total estimated labor hours for all maintenance plans"
    - name: "avg_estimated_labour_per_plan"
      expr: AVG(CAST(estimated_labor_hours AS DOUBLE))
      comment: "Average estimated labor hours per maintenance plan"
    - name: "plan_adherence_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN last_completed_date IS NOT NULL AND last_completed_date <= next_due_date THEN 1 END) / NULLIF(COUNT(CASE WHEN last_completed_date IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of maintenance plans completed on or before due date"
    - name: "overdue_plans_count"
      expr: COUNT(CASE WHEN next_due_date < CURRENT_DATE() AND plan_status = 'Active' THEN 1 END)
      comment: "Number of active maintenance plans currently overdue"
    - name: "regulatory_compliance_plans_count"
      expr: COUNT(CASE WHEN regulatory_requirement IS NOT NULL AND regulatory_requirement != '' THEN 1 END)
      comment: "Number of maintenance plans driven by regulatory requirements"
    - name: "certification_required_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_certificate_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of maintenance plans requiring compliance certification"
$$;