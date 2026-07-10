-- Metric views for domain: site | Business: Construction | Version: 2 | Generated on: 2026-07-10 14:32:32

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`site_concrete_pour`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Concrete pour execution metrics tracking volume, quality compliance, and temperature control for structural concrete placement activities."
  source: "`vibe_construction_v1`.`site`.`concrete_pour`"
  dimensions:
    - name: "pour_date"
      expr: pour_date
      comment: "Date when concrete pour was executed"
    - name: "pour_month"
      expr: DATE_TRUNC('MONTH', pour_date)
      comment: "Month of concrete pour for trend analysis"
    - name: "pour_status"
      expr: pour_status
      comment: "Current status of the concrete pour (e.g., planned, in-progress, completed, cured)"
    - name: "pour_type"
      expr: pour_type
      comment: "Type of concrete pour (e.g., foundation, slab, column, beam)"
    - name: "structure_element"
      expr: structure_element
      comment: "Structural element being poured (e.g., footing, wall, deck)"
    - name: "placement_method"
      expr: placement_method
      comment: "Method used for concrete placement (e.g., pump, bucket, chute)"
    - name: "curing_method"
      expr: curing_method
      comment: "Curing method applied (e.g., wet curing, membrane, steam)"
    - name: "qc_hold_status"
      expr: qc_hold_status
      comment: "Quality control hold status indicating if pour is on hold for inspection"
    - name: "slump_compliant"
      expr: slump_compliant
      comment: "Boolean flag indicating whether slump test met specification"
    - name: "weather_condition"
      expr: weather_condition
      comment: "Weather conditions during pour affecting quality and curing"
  measures:
    - name: "total_concrete_volume_m3"
      expr: SUM(CAST(volume_poured_m3 AS DOUBLE))
      comment: "Total volume of concrete poured in cubic meters - primary production metric for concrete operations"
    - name: "avg_concrete_volume_per_pour_m3"
      expr: AVG(CAST(volume_poured_m3 AS DOUBLE))
      comment: "Average concrete volume per pour event - indicates typical pour size and efficiency"
    - name: "total_pour_count"
      expr: COUNT(1)
      comment: "Total number of concrete pour events - activity volume metric"
    - name: "slump_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN slump_compliant = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of pours meeting slump specification - critical quality control KPI"
    - name: "avg_ambient_temperature_c"
      expr: AVG(CAST(ambient_temperature_c AS DOUBLE))
      comment: "Average ambient temperature during pours - affects curing and quality planning"
    - name: "avg_concrete_temperature_c"
      expr: AVG(CAST(concrete_temperature_c AS DOUBLE))
      comment: "Average concrete temperature at placement - critical for hydration control"
    - name: "qc_hold_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN qc_hold_status IS NOT NULL AND qc_hold_status != '' THEN concrete_pour_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of pours placed on QC hold - quality risk indicator"
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`site_crew_deployment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce deployment and productivity metrics tracking crew utilization, production rates, and labor efficiency across site activities."
  source: "`vibe_construction_v1`.`site`.`crew_deployment`"
  dimensions:
    - name: "deployment_date"
      expr: deployment_date
      comment: "Date of crew deployment"
    - name: "deployment_month"
      expr: DATE_TRUNC('MONTH', deployment_date)
      comment: "Month of deployment for trend analysis"
    - name: "deployment_status"
      expr: deployment_status
      comment: "Status of crew deployment (e.g., planned, active, completed, cancelled)"
    - name: "shift_type"
      expr: shift_type
      comment: "Type of shift (e.g., day, night, weekend)"
    - name: "is_overtime"
      expr: is_overtime
      comment: "Flag indicating whether deployment involved overtime hours"
    - name: "is_subcontractor_crew"
      expr: is_subcontractor_crew
      comment: "Flag indicating whether crew is subcontracted vs direct labor"
    - name: "is_weather_impacted"
      expr: is_weather_impacted
      comment: "Flag indicating whether deployment was impacted by weather"
    - name: "weather_condition"
      expr: weather_condition
      comment: "Weather conditions during deployment"
    - name: "ppe_compliance"
      expr: ppe_compliance
      comment: "Flag indicating PPE compliance status"
    - name: "hse_toolbox_meeting_held"
      expr: hse_toolbox_meeting_held
      comment: "Flag indicating whether HSE toolbox meeting was conducted"
  measures:
    - name: "total_actual_hours"
      expr: SUM(CAST(actual_hours AS DOUBLE))
      comment: "Total actual labor hours worked - primary labor input metric"
    - name: "total_planned_hours"
      expr: SUM(CAST(planned_hours AS DOUBLE))
      comment: "Total planned labor hours - baseline for schedule adherence"
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours worked - cost and fatigue risk indicator"
    - name: "total_actual_production_qty"
      expr: SUM(CAST(actual_production_qty AS DOUBLE))
      comment: "Total actual production quantity achieved by crews - output metric"
    - name: "total_planned_production_qty"
      expr: SUM(CAST(planned_production_qty AS DOUBLE))
      comment: "Total planned production quantity - baseline for productivity analysis"
    - name: "avg_productivity_rate"
      expr: AVG(CAST(productivity_rate AS DOUBLE))
      comment: "Average productivity rate (units per hour) - efficiency benchmark"
    - name: "schedule_adherence_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_hours AS DOUBLE)) / NULLIF(SUM(CAST(planned_hours AS DOUBLE)), 0), 2)
      comment: "Percentage of planned hours actually worked - schedule execution KPI"
    - name: "production_achievement_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_production_qty AS DOUBLE)) / NULLIF(SUM(CAST(planned_production_qty AS DOUBLE)), 0), 2)
      comment: "Percentage of planned production achieved - productivity performance KPI"
    - name: "overtime_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(overtime_hours AS DOUBLE)) / NULLIF(SUM(CAST(actual_hours AS DOUBLE)), 0), 2)
      comment: "Overtime hours as percentage of total hours - cost control and fatigue risk metric"
    - name: "weather_impact_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_weather_impacted = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deployments impacted by weather - schedule risk indicator"
    - name: "ppe_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN ppe_compliance = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deployments with PPE compliance - safety performance KPI"
    - name: "toolbox_meeting_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN hse_toolbox_meeting_held = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deployments with toolbox meetings held - safety culture indicator"
    - name: "total_deployment_count"
      expr: COUNT(1)
      comment: "Total number of crew deployment events - activity volume metric"
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`site_equipment_deployment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Equipment utilization and performance metrics tracking operating hours, fuel consumption, breakdown rates, and equipment productivity."
  source: "`vibe_construction_v1`.`site`.`equipment_deployment`"
  dimensions:
    - name: "deployment_date"
      expr: deployment_date
      comment: "Date of equipment deployment"
    - name: "deployment_month"
      expr: DATE_TRUNC('MONTH', deployment_date)
      comment: "Month of deployment for trend analysis"
    - name: "deployment_status"
      expr: deployment_status
      comment: "Status of equipment deployment (e.g., active, completed, standby)"
    - name: "equipment_type"
      expr: equipment_type
      comment: "Type of equipment deployed (e.g., excavator, crane, loader)"
    - name: "ownership_type"
      expr: ownership_type
      comment: "Equipment ownership type (e.g., owned, rented, leased)"
    - name: "shift_type"
      expr: shift_type
      comment: "Shift during which equipment was deployed"
    - name: "breakdown_flag"
      expr: breakdown_flag
      comment: "Flag indicating whether equipment experienced breakdown"
    - name: "pre_start_check_flag"
      expr: pre_start_check_flag
      comment: "Flag indicating whether pre-start inspection was completed"
    - name: "fuel_type"
      expr: fuel_type
      comment: "Type of fuel used by equipment"
    - name: "weather_condition"
      expr: weather_condition
      comment: "Weather conditions during deployment"
  measures:
    - name: "total_operating_hours"
      expr: SUM(CAST(operating_hours AS DOUBLE))
      comment: "Total equipment operating hours - primary utilization metric"
    - name: "total_idle_hours"
      expr: SUM(CAST(idle_hours AS DOUBLE))
      comment: "Total equipment idle hours - inefficiency indicator"
    - name: "total_standby_hours"
      expr: SUM(CAST(standby_hours AS DOUBLE))
      comment: "Total equipment standby hours - availability metric"
    - name: "total_breakdown_hours"
      expr: SUM(CAST(breakdown_hours AS DOUBLE))
      comment: "Total equipment breakdown hours - reliability risk metric"
    - name: "total_fuel_consumption_liters"
      expr: SUM(CAST(fuel_consumption_liters AS DOUBLE))
      comment: "Total fuel consumed in liters - operating cost driver"
    - name: "total_production_quantity"
      expr: SUM(CAST(production_quantity AS DOUBLE))
      comment: "Total production quantity achieved by equipment - output metric"
    - name: "avg_fuel_consumption_per_hour"
      expr: AVG(CAST(fuel_consumption_liters AS DOUBLE) / NULLIF(CAST(operating_hours AS DOUBLE), 0))
      comment: "Average fuel consumption per operating hour - efficiency benchmark"
    - name: "equipment_utilization_pct"
      expr: ROUND(100.0 * SUM(CAST(operating_hours AS DOUBLE)) / NULLIF(SUM(CAST(operating_hours AS DOUBLE)) + SUM(CAST(idle_hours AS DOUBLE)) + SUM(CAST(standby_hours AS DOUBLE)), 0), 2)
      comment: "Percentage of available time spent operating - utilization efficiency KPI"
    - name: "breakdown_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN breakdown_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deployments with breakdowns - reliability KPI"
    - name: "pre_start_check_compliance_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN pre_start_check_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deployments with completed pre-start checks - safety compliance metric"
    - name: "idle_time_pct"
      expr: ROUND(100.0 * SUM(CAST(idle_hours AS DOUBLE)) / NULLIF(SUM(CAST(operating_hours AS DOUBLE)) + SUM(CAST(idle_hours AS DOUBLE)) + SUM(CAST(standby_hours AS DOUBLE)), 0), 2)
      comment: "Percentage of available time spent idle - waste indicator"
    - name: "total_deployment_count"
      expr: COUNT(1)
      comment: "Total number of equipment deployment events - activity volume metric"
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`site_field_progress`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Field progress measurement metrics tracking installed quantities, percent complete, earned value, and schedule performance for construction activities."
  source: "`vibe_construction_v1`.`site`.`field_progress`"
  dimensions:
    - name: "measurement_date"
      expr: measurement_date
      comment: "Date when progress measurement was taken"
    - name: "measurement_month"
      expr: DATE_TRUNC('MONTH', measurement_date)
      comment: "Month of measurement for trend analysis"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of progress measurement (e.g., draft, submitted, approved, rejected)"
    - name: "activity_type"
      expr: activity_type
      comment: "Type of construction activity being measured"
    - name: "measurement_method"
      expr: measurement_method
      comment: "Method used for progress measurement (e.g., physical count, survey, BIM)"
    - name: "is_critical_path"
      expr: is_critical_path
      comment: "Flag indicating whether activity is on critical path"
    - name: "is_milestone"
      expr: is_milestone
      comment: "Flag indicating whether activity is a milestone"
    - name: "quantity_unit_of_measure"
      expr: quantity_unit_of_measure
      comment: "Unit of measure for quantities (e.g., m3, m2, EA, LM)"
  measures:
    - name: "total_installed_quantity"
      expr: SUM(CAST(installed_quantity AS DOUBLE))
      comment: "Total installed quantity to date - cumulative progress metric"
    - name: "total_planned_quantity"
      expr: SUM(CAST(planned_quantity AS DOUBLE))
      comment: "Total planned quantity - baseline for progress analysis"
    - name: "total_period_installed_quantity"
      expr: SUM(CAST(period_installed_quantity AS DOUBLE))
      comment: "Total quantity installed in current period - production rate metric"
    - name: "total_bcwp"
      expr: SUM(CAST(bcwp AS DOUBLE))
      comment: "Total Budgeted Cost of Work Performed (Earned Value) - EVM performance metric"
    - name: "total_budget_at_completion"
      expr: SUM(CAST(budget_at_completion AS DOUBLE))
      comment: "Total Budget at Completion - baseline cost metric"
    - name: "avg_reported_percent_complete"
      expr: AVG(CAST(reported_percent_complete AS DOUBLE))
      comment: "Average percent complete across activities - overall progress indicator"
    - name: "avg_progress_delta"
      expr: AVG(CAST(progress_delta AS DOUBLE))
      comment: "Average progress change from previous period - velocity metric"
    - name: "quantity_achievement_pct"
      expr: ROUND(100.0 * SUM(CAST(installed_quantity AS DOUBLE)) / NULLIF(SUM(CAST(planned_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of planned quantity installed - schedule performance index"
    - name: "cost_performance_index"
      expr: ROUND(SUM(CAST(bcwp AS DOUBLE)) / NULLIF(SUM(CAST(budget_at_completion AS DOUBLE)), 0), 4)
      comment: "Earned Value divided by Budget at Completion - cost efficiency KPI"
    - name: "critical_path_activity_count"
      expr: COUNT(DISTINCT CASE WHEN is_critical_path = TRUE THEN field_progress_id END)
      comment: "Number of critical path activities measured - schedule risk indicator"
    - name: "milestone_count"
      expr: COUNT(DISTINCT CASE WHEN is_milestone = TRUE THEN field_progress_id END)
      comment: "Number of milestone activities measured - key deliverable tracking"
    - name: "total_measurement_count"
      expr: COUNT(1)
      comment: "Total number of progress measurements - activity volume metric"
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`site_material_delivery`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Material delivery and receipt metrics tracking delivery performance, quality acceptance, discrepancies, and material flow to site."
  source: "`vibe_construction_v1`.`site`.`material_delivery`"
  dimensions:
    - name: "delivery_date"
      expr: delivery_date
      comment: "Date of material delivery"
    - name: "delivery_month"
      expr: DATE_TRUNC('MONTH', delivery_date)
      comment: "Month of delivery for trend analysis"
    - name: "delivery_status"
      expr: delivery_status
      comment: "Status of delivery (e.g., scheduled, in-transit, received, rejected)"
    - name: "material_category"
      expr: material_category
      comment: "Category of material delivered (e.g., concrete, steel, electrical, piping)"
    - name: "receipt_condition"
      expr: receipt_condition
      comment: "Condition of material upon receipt (e.g., good, damaged, incomplete)"
    - name: "hazardous_material"
      expr: hazardous_material
      comment: "Flag indicating whether material is hazardous"
    - name: "temperature_sensitive"
      expr: temperature_sensitive
      comment: "Flag indicating whether material requires temperature control"
    - name: "msds_verified"
      expr: msds_verified
      comment: "Flag indicating whether Material Safety Data Sheet was verified"
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for delivered material"
  measures:
    - name: "total_quantity_delivered"
      expr: SUM(CAST(quantity_delivered AS DOUBLE))
      comment: "Total quantity of material delivered - supply volume metric"
    - name: "total_quantity_ordered"
      expr: SUM(CAST(quantity_ordered AS DOUBLE))
      comment: "Total quantity ordered - baseline for delivery performance"
    - name: "total_quantity_accepted"
      expr: SUM(CAST(quantity_accepted AS DOUBLE))
      comment: "Total quantity accepted after inspection - quality metric"
    - name: "total_quantity_rejected"
      expr: SUM(CAST(quantity_rejected AS DOUBLE))
      comment: "Total quantity rejected due to quality issues - defect metric"
    - name: "total_delivery_value"
      expr: SUM(CAST(delivery_value AS DOUBLE))
      comment: "Total value of materials delivered - procurement spend metric"
    - name: "delivery_fulfillment_pct"
      expr: ROUND(100.0 * SUM(CAST(quantity_delivered AS DOUBLE)) / NULLIF(SUM(CAST(quantity_ordered AS DOUBLE)), 0), 2)
      comment: "Percentage of ordered quantity delivered - supplier performance KPI"
    - name: "acceptance_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(quantity_accepted AS DOUBLE)) / NULLIF(SUM(CAST(quantity_delivered AS DOUBLE)), 0), 2)
      comment: "Percentage of delivered quantity accepted - quality performance KPI"
    - name: "rejection_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(quantity_rejected AS DOUBLE)) / NULLIF(SUM(CAST(quantity_delivered AS DOUBLE)), 0), 2)
      comment: "Percentage of delivered quantity rejected - quality risk indicator"
    - name: "avg_unit_rate"
      expr: AVG(CAST(unit_rate AS DOUBLE))
      comment: "Average unit rate for delivered materials - cost benchmark"
    - name: "msds_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN msds_verified = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deliveries with verified MSDS - safety compliance metric"
    - name: "total_delivery_count"
      expr: COUNT(1)
      comment: "Total number of material deliveries - logistics activity volume"
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`site_production_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Daily production entry metrics tracking installed quantities, production rates, labor and equipment hours, and work item progress."
  source: "`vibe_construction_v1`.`site`.`production_entry`"
  dimensions:
    - name: "entry_date"
      expr: entry_date
      comment: "Date of production entry"
    - name: "entry_month"
      expr: DATE_TRUNC('MONTH', entry_date)
      comment: "Month of production entry for trend analysis"
    - name: "entry_status"
      expr: entry_status
      comment: "Status of production entry (e.g., draft, submitted, approved)"
    - name: "production_type"
      expr: production_type
      comment: "Type of production activity (e.g., installation, fabrication, assembly)"
    - name: "shift_type"
      expr: shift_type
      comment: "Shift during which production occurred"
    - name: "is_rework"
      expr: is_rework
      comment: "Flag indicating whether production is rework"
    - name: "weather_condition"
      expr: weather_condition
      comment: "Weather conditions during production"
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for production quantity"
  measures:
    - name: "total_installed_quantity"
      expr: SUM(CAST(installed_quantity AS DOUBLE))
      comment: "Total quantity installed - primary production output metric"
    - name: "total_budgeted_quantity"
      expr: SUM(CAST(budgeted_quantity AS DOUBLE))
      comment: "Total budgeted quantity - baseline for productivity analysis"
    - name: "total_cumulative_quantity"
      expr: SUM(CAST(cumulative_quantity AS DOUBLE))
      comment: "Total cumulative quantity to date - progress tracking metric"
    - name: "total_labor_hours"
      expr: SUM(CAST(labor_hours AS DOUBLE))
      comment: "Total labor hours consumed - labor input metric"
    - name: "total_equipment_hours"
      expr: SUM(CAST(equipment_hours AS DOUBLE))
      comment: "Total equipment hours consumed - equipment input metric"
    - name: "avg_production_rate"
      expr: AVG(CAST(production_rate AS DOUBLE))
      comment: "Average production rate (units per hour) - productivity benchmark"
    - name: "avg_budgeted_production_rate"
      expr: AVG(CAST(budgeted_production_rate AS DOUBLE))
      comment: "Average budgeted production rate - baseline productivity standard"
    - name: "avg_percent_complete"
      expr: AVG(CAST(percent_complete AS DOUBLE))
      comment: "Average percent complete across work items - progress indicator"
    - name: "production_efficiency_pct"
      expr: ROUND(100.0 * SUM(CAST(installed_quantity AS DOUBLE)) / NULLIF(SUM(CAST(budgeted_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of budgeted quantity achieved - productivity performance KPI"
    - name: "rework_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_rework = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of production entries that are rework - quality cost indicator"
    - name: "total_production_entry_count"
      expr: COUNT(1)
      comment: "Total number of production entries - activity volume metric"
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`site_shift_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shift-level operational metrics tracking headcount, labor hours, production, equipment utilization, safety events, and shift performance."
  source: "`vibe_construction_v1`.`site`.`shift_report`"
  dimensions:
    - name: "shift_date"
      expr: shift_date
      comment: "Date of shift"
    - name: "shift_month"
      expr: DATE_TRUNC('MONTH', shift_date)
      comment: "Month of shift for trend analysis"
    - name: "shift_type"
      expr: shift_type
      comment: "Type of shift (e.g., day, night, weekend)"
    - name: "report_status"
      expr: report_status
      comment: "Status of shift report (e.g., draft, submitted, approved)"
    - name: "weather_condition"
      expr: weather_condition
      comment: "Weather conditions during shift"
    - name: "lti_flag"
      expr: lti_flag
      comment: "Flag indicating whether Lost Time Injury occurred during shift"
    - name: "ncr_raised_flag"
      expr: ncr_raised_flag
      comment: "Flag indicating whether Non-Conformance Report was raised during shift"
    - name: "tbm_conducted_flag"
      expr: tbm_conducted_flag
      comment: "Flag indicating whether Toolbox Meeting was conducted"
  measures:
    - name: "total_labour_hours"
      expr: SUM(CAST(total_labour_hours AS DOUBLE))
      comment: "Total labor hours worked across all shifts - primary labor input metric"
    - name: "total_production_quantity"
      expr: SUM(CAST(production_quantity AS DOUBLE))
      comment: "Total production quantity achieved - shift output metric"
    - name: "total_planned_production_quantity"
      expr: SUM(CAST(planned_production_quantity AS DOUBLE))
      comment: "Total planned production quantity - baseline for shift performance"
    - name: "total_concrete_volume_m3"
      expr: SUM(CAST(concrete_volume_m3 AS DOUBLE))
      comment: "Total concrete volume poured during shifts - concrete production metric"
    - name: "total_earthworks_volume_m3"
      expr: SUM(CAST(earthworks_volume_m3 AS DOUBLE))
      comment: "Total earthworks volume moved during shifts - earthworks production metric"
    - name: "total_delay_duration_hrs"
      expr: SUM(CAST(delay_duration_hrs AS DOUBLE))
      comment: "Total delay hours across shifts - schedule impact metric"
    - name: "avg_equipment_utilisation_pct"
      expr: AVG(CAST(equipment_utilisation_pct AS DOUBLE))
      comment: "Average equipment utilization percentage - equipment efficiency metric"
    - name: "shift_production_achievement_pct"
      expr: ROUND(100.0 * SUM(CAST(production_quantity AS DOUBLE)) / NULLIF(SUM(CAST(planned_production_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of planned production achieved - shift performance KPI"
    - name: "lti_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN lti_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of shifts with Lost Time Injuries - critical safety KPI"
    - name: "ncr_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN ncr_raised_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of shifts with Non-Conformance Reports raised - quality issue rate"
    - name: "toolbox_meeting_compliance_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN tbm_conducted_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of shifts with toolbox meetings conducted - safety culture metric"
    - name: "total_shift_count"
      expr: COUNT(1)
      comment: "Total number of shifts reported - activity volume metric"
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`site_work_front`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Work front performance metrics tracking progress, production achievement, schedule variance, and resource deployment across site work zones."
  source: "`vibe_construction_v1`.`site`.`work_front`"
  dimensions:
    - name: "front_status"
      expr: front_status
      comment: "Current status of work front (e.g., planned, active, completed, on-hold)"
    - name: "front_type"
      expr: front_type
      comment: "Type of work front (e.g., excavation, structural, MEP, finishing)"
    - name: "is_critical_path"
      expr: is_critical_path
      comment: "Flag indicating whether work front is on critical path"
    - name: "is_subcontracted"
      expr: is_subcontracted
      comment: "Flag indicating whether work front is subcontracted"
    - name: "hse_risk_level"
      expr: hse_risk_level
      comment: "HSE risk level classification (e.g., low, medium, high, critical)"
    - name: "weather_sensitivity"
      expr: weather_sensitivity
      comment: "Weather sensitivity classification of work front"
    - name: "zone_classification"
      expr: zone_classification
      comment: "Zone classification for site organization"
    - name: "shift_pattern"
      expr: shift_pattern
      comment: "Shift pattern for work front (e.g., single, double, 24/7)"
  measures:
    - name: "total_actual_production_qty"
      expr: SUM(CAST(actual_production_qty AS DOUBLE))
      comment: "Total actual production quantity across work fronts - output metric"
    - name: "total_planned_production_qty"
      expr: SUM(CAST(planned_production_qty AS DOUBLE))
      comment: "Total planned production quantity - baseline for performance analysis"
    - name: "avg_percent_complete"
      expr: AVG(CAST(percent_complete AS DOUBLE))
      comment: "Average percent complete across work fronts - overall progress indicator"
    - name: "total_area_sqm"
      expr: SUM(CAST(area_sqm AS DOUBLE))
      comment: "Total area of work fronts in square meters - scope metric"
    - name: "production_achievement_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_production_qty AS DOUBLE)) / NULLIF(SUM(CAST(planned_production_qty AS DOUBLE)), 0), 2)
      comment: "Percentage of planned production achieved - work front performance KPI"
    - name: "critical_path_work_front_count"
      expr: COUNT(DISTINCT CASE WHEN is_critical_path = TRUE THEN work_front_id END)
      comment: "Number of work fronts on critical path - schedule risk indicator"
    - name: "subcontracted_work_front_count"
      expr: COUNT(DISTINCT CASE WHEN is_subcontracted = TRUE THEN work_front_id END)
      comment: "Number of subcontracted work fronts - subcontractor management metric"
    - name: "high_risk_work_front_count"
      expr: COUNT(DISTINCT CASE WHEN hse_risk_level IN ('high', 'critical') THEN work_front_id END)
      comment: "Number of high-risk work fronts - safety focus indicator"
    - name: "total_work_front_count"
      expr: COUNT(1)
      comment: "Total number of work fronts - site complexity metric"
$$;