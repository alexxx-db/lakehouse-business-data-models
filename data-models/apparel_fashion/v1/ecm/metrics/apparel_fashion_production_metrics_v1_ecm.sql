-- Metric views for domain: production | Business: Apparel Fashion | Version: 1 | Generated on: 2026-05-05 15:42:09

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`production_work_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core production work order KPIs tracking order fulfillment, cost efficiency, quality performance, and on-time delivery across factories and styles"
  source: "`apparel_fashion_ecm`.`production`.`work_order`"
  dimensions:
    - name: "work_order_status"
      expr: work_order_status
      comment: "Current status of the work order (e.g., planned, in-progress, completed, cancelled)"
    - name: "priority"
      expr: priority
      comment: "Priority level of the work order for production scheduling"
    - name: "production_start_month"
      expr: DATE_TRUNC('MONTH', production_start_date)
      comment: "Month when production started, for time-series analysis"
    - name: "production_end_month"
      expr: DATE_TRUNC('MONTH', production_end_date)
      comment: "Month when production ended, for time-series analysis"
    - name: "destination_country_code"
      expr: destination_country_code
      comment: "Destination country for the work order shipment"
    - name: "shipping_mode"
      expr: shipping_mode
      comment: "Shipping method (e.g., air, sea, ground)"
    - name: "quality_inspection_status"
      expr: quality_inspection_status
      comment: "Quality inspection outcome status"
    - name: "cmt_type"
      expr: cmt_type
      comment: "Cut-Make-Trim type classification"
    - name: "aql_level"
      expr: aql_level
      comment: "Acceptable Quality Limit level for inspection"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for cost and pricing"
  measures:
    - name: "total_work_orders"
      expr: COUNT(1)
      comment: "Total number of work orders"
    - name: "total_ordered_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total quantity ordered across all work orders"
    - name: "total_produced_quantity"
      expr: SUM(CAST(produced_quantity AS DOUBLE))
      comment: "Total quantity produced across all work orders"
    - name: "total_confirmed_quantity"
      expr: SUM(CAST(confirmed_quantity AS DOUBLE))
      comment: "Total quantity confirmed for production"
    - name: "total_rejected_quantity"
      expr: SUM(CAST(rejected_quantity AS DOUBLE))
      comment: "Total quantity rejected due to quality issues"
    - name: "total_production_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total production cost across all work orders"
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost per work order"
    - name: "order_fulfillment_rate"
      expr: ROUND(100.0 * SUM(CAST(produced_quantity AS DOUBLE)) / NULLIF(SUM(CAST(ordered_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of ordered quantity that was produced (production yield rate)"
    - name: "quality_rejection_rate"
      expr: ROUND(100.0 * SUM(CAST(rejected_quantity AS DOUBLE)) / NULLIF(SUM(CAST(produced_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of produced quantity that was rejected (quality defect rate)"
    - name: "distinct_factories"
      expr: COUNT(DISTINCT production_factory_id)
      comment: "Number of distinct factories producing work orders"
    - name: "distinct_styles"
      expr: COUNT(DISTINCT style_id)
      comment: "Number of distinct styles in production"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`production_factory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Factory performance KPIs tracking capacity utilization, quality ratings, sustainability scores, and operational efficiency across production facilities"
  source: "`apparel_fashion_ecm`.`production`.`production_factory`"
  dimensions:
    - name: "factory_type"
      expr: factory_type
      comment: "Type of production facility (e.g., owned, contracted, partner)"
    - name: "country_code"
      expr: country_code
      comment: "Country where the factory is located"
    - name: "active_flag"
      expr: active_flag
      comment: "Whether the factory is currently active"
    - name: "preferred_vendor_flag"
      expr: preferred_vendor_flag
      comment: "Whether the factory is a preferred vendor"
    - name: "quality_rating"
      expr: quality_rating
      comment: "Quality rating classification of the factory"
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating classification of the factory"
    - name: "onboarding_year"
      expr: YEAR(onboarding_date)
      comment: "Year when the factory was onboarded"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for factory transactions"
  measures:
    - name: "total_factories"
      expr: COUNT(1)
      comment: "Total number of production factories"
    - name: "active_factories"
      expr: SUM(CASE WHEN active_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of currently active factories"
    - name: "preferred_factories"
      expr: SUM(CASE WHEN preferred_vendor_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of preferred vendor factories"
    - name: "avg_audit_score"
      expr: AVG(CAST(audit_score AS DOUBLE))
      comment: "Average audit score across all factories"
    - name: "avg_sustainability_score"
      expr: AVG(CAST(sustainability_score AS DOUBLE))
      comment: "Average sustainability score across all factories"
    - name: "avg_otif_performance"
      expr: AVG(CAST(otif_performance_pct AS DOUBLE))
      comment: "Average on-time-in-full delivery performance percentage"
    - name: "total_employee_count"
      expr: SUM(CAST(employee_count AS DOUBLE))
      comment: "Total employee headcount across all factories"
    - name: "total_facility_size_sqm"
      expr: SUM(CAST(facility_size_sqm AS DOUBLE))
      comment: "Total facility size in square meters across all factories"
    - name: "avg_lead_time_days"
      expr: AVG(CAST(lead_time_days AS DOUBLE))
      comment: "Average lead time in days across factories"
    - name: "distinct_countries"
      expr: COUNT(DISTINCT country_code)
      comment: "Number of distinct countries with production facilities"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`production_lot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Production lot quality and yield KPIs tracking defect rates, acceptance rates, rework efficiency, and production throughput by lot"
  source: "`apparel_fashion_ecm`.`production`.`lot`"
  dimensions:
    - name: "lot_status"
      expr: lot_status
      comment: "Current status of the production lot"
    - name: "lot_type"
      expr: lot_type
      comment: "Type of production lot (e.g., regular, sample, rework)"
    - name: "quality_inspection_status"
      expr: quality_inspection_status
      comment: "Quality inspection outcome status"
    - name: "aql_level"
      expr: aql_level
      comment: "Acceptable Quality Limit level for inspection"
    - name: "season_code"
      expr: season_code
      comment: "Season code for the production lot"
    - name: "production_start_month"
      expr: DATE_TRUNC('MONTH', production_start_date)
      comment: "Month when lot production started"
    - name: "production_end_month"
      expr: DATE_TRUNC('MONTH', production_end_date)
      comment: "Month when lot production ended"
    - name: "cmt_type"
      expr: cmt_type
      comment: "Cut-Make-Trim type classification"
    - name: "shift_code"
      expr: shift_code
      comment: "Production shift code"
  measures:
    - name: "total_lots"
      expr: COUNT(1)
      comment: "Total number of production lots"
    - name: "total_planned_quantity"
      expr: SUM(CAST(planned_quantity AS DOUBLE))
      comment: "Total planned quantity across all lots"
    - name: "total_produced_quantity"
      expr: SUM(CAST(produced_quantity AS DOUBLE))
      comment: "Total produced quantity across all lots"
    - name: "total_accepted_quantity"
      expr: SUM(CAST(accepted_quantity AS DOUBLE))
      comment: "Total accepted quantity after quality inspection"
    - name: "total_rejected_quantity"
      expr: SUM(CAST(rejected_quantity AS DOUBLE))
      comment: "Total rejected quantity due to quality defects"
    - name: "total_rework_quantity"
      expr: SUM(CAST(rework_quantity AS DOUBLE))
      comment: "Total quantity sent for rework"
    - name: "total_scrap_quantity"
      expr: SUM(CAST(scrap_quantity AS DOUBLE))
      comment: "Total quantity scrapped as unrecoverable"
    - name: "total_critical_defects"
      expr: SUM(CAST(critical_defect_count AS DOUBLE))
      comment: "Total critical defects found across all lots"
    - name: "total_major_defects"
      expr: SUM(CAST(major_defect_count AS DOUBLE))
      comment: "Total major defects found across all lots"
    - name: "total_minor_defects"
      expr: SUM(CAST(minor_defect_count AS DOUBLE))
      comment: "Total minor defects found across all lots"
    - name: "lot_yield_rate"
      expr: ROUND(100.0 * SUM(CAST(produced_quantity AS DOUBLE)) / NULLIF(SUM(CAST(planned_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of planned quantity that was produced (lot yield efficiency)"
    - name: "quality_acceptance_rate"
      expr: ROUND(100.0 * SUM(CAST(accepted_quantity AS DOUBLE)) / NULLIF(SUM(CAST(produced_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of produced quantity that passed quality inspection (first-pass yield)"
    - name: "rework_rate"
      expr: ROUND(100.0 * SUM(CAST(rework_quantity AS DOUBLE)) / NULLIF(SUM(CAST(produced_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of produced quantity requiring rework"
    - name: "scrap_rate"
      expr: ROUND(100.0 * SUM(CAST(scrap_quantity AS DOUBLE)) / NULLIF(SUM(CAST(produced_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of produced quantity scrapped as waste"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`production_cut_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cutting operation efficiency KPIs tracking fabric utilization, marker efficiency, cutting accuracy, and waste reduction performance"
  source: "`apparel_fashion_ecm`.`production`.`cut_order`"
  dimensions:
    - name: "cut_status"
      expr: cut_status
      comment: "Current status of the cut order"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the cut order"
    - name: "quality_inspection_status"
      expr: quality_inspection_status
      comment: "Quality inspection outcome status for cut pieces"
    - name: "cut_month"
      expr: DATE_TRUNC('MONTH', cut_date)
      comment: "Month when cutting was performed"
    - name: "scheduled_cut_month"
      expr: DATE_TRUNC('MONTH', scheduled_cut_date)
      comment: "Month when cutting was scheduled"
    - name: "bundle_ticket_generated"
      expr: bundle_ticket_generated
      comment: "Whether bundle tickets were generated for the cut order"
  measures:
    - name: "total_cut_orders"
      expr: COUNT(1)
      comment: "Total number of cut orders"
    - name: "total_units_planned"
      expr: SUM(CAST(total_units_planned AS DOUBLE))
      comment: "Total units planned for cutting"
    - name: "total_units_cut"
      expr: SUM(CAST(total_units_cut AS DOUBLE))
      comment: "Total units actually cut"
    - name: "total_fabric_allocated"
      expr: SUM(CAST(total_fabric_allocated AS DOUBLE))
      comment: "Total fabric allocated for cutting operations"
    - name: "total_fabric_consumed"
      expr: SUM(CAST(total_fabric_consumed AS DOUBLE))
      comment: "Total fabric consumed during cutting operations"
    - name: "avg_cut_efficiency"
      expr: AVG(CAST(cut_efficiency_percentage AS DOUBLE))
      comment: "Average cutting efficiency percentage across all cut orders"
    - name: "avg_marker_efficiency"
      expr: AVG(CAST(marker_efficiency_percentage AS DOUBLE))
      comment: "Average marker efficiency percentage (fabric utilization in marker layout)"
    - name: "avg_fabric_consumption_per_unit"
      expr: AVG(CAST(fabric_consumption_per_unit AS DOUBLE))
      comment: "Average fabric consumption per unit cut"
    - name: "cutting_yield_rate"
      expr: ROUND(100.0 * SUM(CAST(total_units_cut AS DOUBLE)) / NULLIF(SUM(CAST(total_units_planned AS DOUBLE)), 0), 2)
      comment: "Percentage of planned units that were successfully cut (cutting yield)"
    - name: "fabric_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(total_fabric_consumed AS DOUBLE)) / NULLIF(SUM(CAST(total_fabric_allocated AS DOUBLE)), 0), 2)
      comment: "Percentage of allocated fabric that was consumed (fabric utilization efficiency)"
    - name: "total_defect_count"
      expr: SUM(CAST(defect_count AS DOUBLE))
      comment: "Total defects found during cutting operations"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`production_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Production scheduling and on-time delivery KPIs tracking schedule adherence, lead time accuracy, and capacity utilization across production lines"
  source: "`apparel_fashion_ecm`.`production`.`schedule`"
  dimensions:
    - name: "schedule_status"
      expr: schedule_status
      comment: "Current status of the production schedule"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the scheduled production"
    - name: "production_type"
      expr: production_type
      comment: "Type of production (e.g., regular, rush, sample)"
    - name: "production_method"
      expr: production_method
      comment: "Production method used"
    - name: "critical_path_flag"
      expr: critical_path_flag
      comment: "Whether this schedule is on the critical path"
    - name: "otif_target_flag"
      expr: otif_target_flag
      comment: "Whether this schedule has an on-time-in-full target"
    - name: "planned_ex_factory_month"
      expr: DATE_TRUNC('MONTH', planned_ex_factory_date)
      comment: "Month when ex-factory shipment is planned"
    - name: "actual_ex_factory_month"
      expr: DATE_TRUNC('MONTH', actual_ex_factory_date)
      comment: "Month when ex-factory shipment actually occurred"
  measures:
    - name: "total_schedules"
      expr: COUNT(1)
      comment: "Total number of production schedules"
    - name: "total_scheduled_quantity"
      expr: SUM(CAST(scheduled_quantity AS DOUBLE))
      comment: "Total quantity scheduled for production"
    - name: "avg_factory_capacity_utilization"
      expr: AVG(CAST(factory_capacity_utilization_pct AS DOUBLE))
      comment: "Average factory capacity utilization percentage across schedules"
    - name: "avg_lead_time_days"
      expr: AVG(CAST(lead_time_days AS DOUBLE))
      comment: "Average lead time in days across schedules"
    - name: "critical_path_schedules"
      expr: SUM(CASE WHEN critical_path_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of schedules on the critical path"
    - name: "otif_target_schedules"
      expr: SUM(CASE WHEN otif_target_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of schedules with on-time-in-full targets"
    - name: "on_time_ex_factory_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN actual_ex_factory_date <= planned_ex_factory_date THEN 1 ELSE 0 END) / NULLIF(COUNT(CASE WHEN actual_ex_factory_date IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of schedules that shipped on or before planned ex-factory date (OTIF rate)"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`production_order_confirmation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Production order confirmation and yield KPIs tracking actual vs planned output, labor efficiency, scrap rates, and goods movement accuracy"
  source: "`apparel_fashion_ecm`.`production`.`order_confirmation`"
  dimensions:
    - name: "confirmation_status"
      expr: confirmation_status
      comment: "Status of the order confirmation"
    - name: "confirmation_type"
      expr: confirmation_type
      comment: "Type of confirmation (e.g., final, partial, reversal)"
    - name: "activity_type_code"
      expr: activity_type_code
      comment: "Activity type code for the confirmed operation"
    - name: "quality_inspection_status"
      expr: quality_inspection_status
      comment: "Quality inspection outcome status"
    - name: "quality_inspection_required"
      expr: quality_inspection_required
      comment: "Whether quality inspection is required"
    - name: "final_confirmation_indicator"
      expr: final_confirmation_indicator
      comment: "Whether this is the final confirmation for the operation"
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Whether this confirmation is a reversal"
    - name: "backflush_indicator"
      expr: backflush_indicator
      comment: "Whether backflushing was used for material consumption"
    - name: "goods_movement_posted"
      expr: goods_movement_posted
      comment: "Whether goods movement was posted to inventory"
    - name: "confirmation_month"
      expr: DATE_TRUNC('MONTH', confirmation_date)
      comment: "Month when the confirmation was recorded"
    - name: "shift_code"
      expr: shift_code
      comment: "Production shift code"
  measures:
    - name: "total_confirmations"
      expr: COUNT(1)
      comment: "Total number of order confirmations"
    - name: "total_yield_quantity"
      expr: SUM(CAST(yield_quantity AS DOUBLE))
      comment: "Total yield quantity confirmed across all operations"
    - name: "total_scrap_quantity"
      expr: SUM(CAST(scrap_quantity AS DOUBLE))
      comment: "Total scrap quantity reported across all operations"
    - name: "total_rework_quantity"
      expr: SUM(CAST(rework_quantity AS DOUBLE))
      comment: "Total rework quantity reported across all operations"
    - name: "total_actual_labor_hours"
      expr: SUM(CAST(actual_labor_hours AS DOUBLE))
      comment: "Total actual labor hours consumed"
    - name: "total_actual_machine_hours"
      expr: SUM(CAST(actual_machine_hours AS DOUBLE))
      comment: "Total actual machine hours consumed"
    - name: "total_setup_time_hours"
      expr: SUM(CAST(setup_time_hours AS DOUBLE))
      comment: "Total setup time in hours"
    - name: "total_teardown_time_hours"
      expr: SUM(CAST(teardown_time_hours AS DOUBLE))
      comment: "Total teardown time in hours"
    - name: "scrap_rate"
      expr: ROUND(100.0 * SUM(CAST(scrap_quantity AS DOUBLE)) / NULLIF(SUM(CAST(yield_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of yield quantity that was scrapped (scrap rate)"
    - name: "rework_rate"
      expr: ROUND(100.0 * SUM(CAST(rework_quantity AS DOUBLE)) / NULLIF(SUM(CAST(yield_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of yield quantity that required rework"
    - name: "avg_labor_hours_per_confirmation"
      expr: AVG(CAST(actual_labor_hours AS DOUBLE))
      comment: "Average labor hours per confirmation"
    - name: "avg_machine_hours_per_confirmation"
      expr: AVG(CAST(actual_machine_hours AS DOUBLE))
      comment: "Average machine hours per confirmation"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`production_factory_capacity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Factory capacity planning and utilization KPIs tracking available capacity, allocation efficiency, labor and machine hour utilization, and booking performance"
  source: "`apparel_fashion_ecm`.`production`.`factory_capacity`"
  dimensions:
    - name: "capacity_status"
      expr: capacity_status
      comment: "Current status of factory capacity"
    - name: "booking_status"
      expr: booking_status
      comment: "Booking status of the capacity"
    - name: "planning_period_type"
      expr: planning_period_type
      comment: "Type of planning period (e.g., weekly, monthly, quarterly)"
    - name: "department_code"
      expr: department_code
      comment: "Department code for capacity allocation"
    - name: "capacity_allocation_priority"
      expr: capacity_allocation_priority
      comment: "Priority level for capacity allocation"
    - name: "is_active"
      expr: is_active
      comment: "Whether the capacity record is currently active"
    - name: "planning_period_start_month"
      expr: DATE_TRUNC('MONTH', planning_period_start_date)
      comment: "Month when the planning period starts"
  measures:
    - name: "total_capacity_records"
      expr: COUNT(1)
      comment: "Total number of factory capacity records"
    - name: "total_capacity_units"
      expr: SUM(CAST(total_capacity_units AS DOUBLE))
      comment: "Total capacity units available across all factories"
    - name: "total_allocated_capacity"
      expr: SUM(CAST(allocated_capacity_units AS DOUBLE))
      comment: "Total capacity units allocated to production"
    - name: "total_available_capacity"
      expr: SUM(CAST(available_capacity_units AS DOUBLE))
      comment: "Total capacity units still available for booking"
    - name: "total_reserved_capacity"
      expr: SUM(CAST(reserved_capacity_units AS DOUBLE))
      comment: "Total capacity units reserved for future orders"
    - name: "total_available_labor_hours"
      expr: SUM(CAST(available_labor_hours AS DOUBLE))
      comment: "Total labor hours available across all factories"
    - name: "total_available_machine_hours"
      expr: SUM(CAST(available_machine_hours AS DOUBLE))
      comment: "Total machine hours available across all factories"
    - name: "total_overtime_hours_available"
      expr: SUM(CAST(overtime_hours_available AS DOUBLE))
      comment: "Total overtime hours available for production"
    - name: "total_planned_downtime_hours"
      expr: SUM(CAST(planned_downtime_hours AS DOUBLE))
      comment: "Total planned downtime hours for maintenance"
    - name: "avg_utilization_rate"
      expr: AVG(CAST(utilization_rate_percent AS DOUBLE))
      comment: "Average capacity utilization rate percentage"
    - name: "avg_efficiency_rate"
      expr: AVG(CAST(efficiency_rate_percent AS DOUBLE))
      comment: "Average efficiency rate percentage"
    - name: "capacity_allocation_rate"
      expr: ROUND(100.0 * SUM(CAST(allocated_capacity_units AS DOUBLE)) / NULLIF(SUM(CAST(total_capacity_units AS DOUBLE)), 0), 2)
      comment: "Percentage of total capacity that has been allocated (capacity booking rate)"
    - name: "capacity_availability_rate"
      expr: ROUND(100.0 * SUM(CAST(available_capacity_units AS DOUBLE)) / NULLIF(SUM(CAST(total_capacity_units AS DOUBLE)), 0), 2)
      comment: "Percentage of total capacity that remains available for booking"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`production_fabric_roll`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fabric inventory and quality KPIs tracking fabric utilization, defect rates, sustainability metrics, and cost efficiency across fabric rolls"
  source: "`apparel_fashion_ecm`.`production`.`fabric_roll`"
  dimensions:
    - name: "status"
      expr: fabric_roll_status
      comment: "Current status of the fabric roll"
    - name: "grade"
      expr: grade
      comment: "Quality grade of the fabric roll"
    - name: "color_name"
      expr: color_name
      comment: "Color name of the fabric"
    - name: "finish_type"
      expr: finish_type
      comment: "Finish type applied to the fabric"
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country where the fabric was manufactured"
    - name: "is_organic"
      expr: is_organic
      comment: "Whether the fabric is organic certified"
    - name: "is_recycled"
      expr: is_recycled
      comment: "Whether the fabric is made from recycled materials"
    - name: "certification"
      expr: certification
      comment: "Sustainability or quality certification of the fabric"
    - name: "received_month"
      expr: DATE_TRUNC('MONTH', received_date)
      comment: "Month when the fabric roll was received"
    - name: "inspection_month"
      expr: DATE_TRUNC('MONTH', inspection_date)
      comment: "Month when the fabric roll was inspected"
  measures:
    - name: "total_fabric_rolls"
      expr: COUNT(1)
      comment: "Total number of fabric rolls in inventory"
    - name: "total_fabric_length_meters"
      expr: SUM(CAST(length_meters AS DOUBLE))
      comment: "Total fabric length in meters across all rolls"
    - name: "total_fabric_weight_kg"
      expr: SUM(CAST(weight_kg AS DOUBLE))
      comment: "Total fabric weight in kilograms across all rolls"
    - name: "total_fabric_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total cost of all fabric rolls"
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost per fabric roll"
    - name: "avg_gsm"
      expr: AVG(CAST(gsm AS DOUBLE))
      comment: "Average grams per square meter (fabric weight)"
    - name: "avg_width_cm"
      expr: AVG(CAST(width_cm AS DOUBLE))
      comment: "Average fabric width in centimeters"
    - name: "avg_shrinkage_percentage"
      expr: AVG(CAST(shrinkage_percentage AS DOUBLE))
      comment: "Average shrinkage percentage across fabric rolls"
    - name: "avg_stretch_percentage"
      expr: AVG(CAST(stretch_percentage AS DOUBLE))
      comment: "Average stretch percentage across fabric rolls"
    - name: "avg_sustainability_score"
      expr: AVG(CAST(sustainability_score AS DOUBLE))
      comment: "Average sustainability score across fabric rolls"
    - name: "total_defect_points"
      expr: SUM(CAST(defect_points AS DOUBLE))
      comment: "Total defect points found across all fabric rolls"
    - name: "avg_defect_points_per_roll"
      expr: AVG(CAST(defect_points AS DOUBLE))
      comment: "Average defect points per fabric roll"
    - name: "organic_fabric_rolls"
      expr: SUM(CASE WHEN is_organic = TRUE THEN 1 ELSE 0 END)
      comment: "Number of organic certified fabric rolls"
    - name: "recycled_fabric_rolls"
      expr: SUM(CASE WHEN is_recycled = TRUE THEN 1 ELSE 0 END)
      comment: "Number of recycled fabric rolls"
$$;
