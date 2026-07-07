-- Metric views for domain: site | Business: Construction | Version: 2 | Generated on: 2026-06-28 00:14:33

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`site_concrete_pour`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks concrete pour execution quality, volume throughput, and QC compliance across construction projects. Enables project engineers and QA managers to monitor pour performance, slump compliance, and structural delivery rates."
  source: "`vibe_construction_v1`.`site`.`concrete_pour`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Foreign key to the construction project — enables project-level pour analysis."
    - name: "pour_date"
      expr: pour_date
      comment: "Date the concrete pour was executed — supports time-series trending of pour activity."
    - name: "pour_type"
      expr: pour_type
      comment: "Classification of the pour (e.g. slab, column, footing) — drives structural element analysis."
    - name: "pour_status"
      expr: pour_status
      comment: "Current status of the pour record (e.g. completed, on-hold) — filters active vs. closed pours."
    - name: "structure_element"
      expr: structure_element
      comment: "Structural element being poured — enables element-level quality and volume tracking."
    - name: "mix_design_code"
      expr: mix_design_code
      comment: "Concrete mix design identifier — supports mix-level quality benchmarking."
    - name: "qc_hold_status"
      expr: qc_hold_status
      comment: "QC hold flag on the pour — identifies pours under quality investigation."
    - name: "curing_method"
      expr: curing_method
      comment: "Method used to cure the concrete — supports curing practice analysis."
    - name: "placement_method"
      expr: placement_method
      comment: "Method used to place concrete (e.g. pump, crane bucket) — supports method efficiency analysis."
    - name: "wbs_element_id"
      expr: wbs_element_id
      comment: "WBS element the pour is charged to — enables WBS-level volume and quality rollup."
  measures:
    - name: "total_volume_poured_m3"
      expr: SUM(CAST(volume_poured_m3 AS DOUBLE))
      comment: "Total cubic metres of concrete poured — primary throughput KPI for concrete works."
    - name: "avg_volume_per_pour_m3"
      expr: AVG(CAST(volume_poured_m3 AS DOUBLE))
      comment: "Average volume per pour event — indicates pour batch sizing and efficiency."
    - name: "total_pour_count"
      expr: COUNT(1)
      comment: "Total number of pour events — baseline activity volume metric."
    - name: "slump_compliant_pour_count"
      expr: COUNT(CASE WHEN slump_compliant = TRUE THEN 1 END)
      comment: "Number of pours where slump test result met specification — measures QC pass rate numerator."
    - name: "slump_non_compliant_pour_count"
      expr: COUNT(CASE WHEN slump_compliant = FALSE THEN 1 END)
      comment: "Number of pours failing slump specification — drives QC investigation and rework decisions."
    - name: "avg_slump_test_result_mm"
      expr: AVG(CAST(slump_test_result_mm AS DOUBLE))
      comment: "Average slump test result in millimetres — monitors concrete workability against specification."
    - name: "avg_specified_strength_mpa"
      expr: AVG(CAST(specified_strength_mpa AS DOUBLE))
      comment: "Average specified compressive strength across pours — supports mix design adequacy review."
    - name: "avg_concrete_temperature_c"
      expr: AVG(CAST(concrete_temperature_c AS DOUBLE))
      comment: "Average concrete temperature at placement — monitors thermal compliance for quality assurance."
    - name: "qc_hold_pour_count"
      expr: COUNT(CASE WHEN qc_hold_status IS NOT NULL AND qc_hold_status != 'NONE' THEN 1 END)
      comment: "Number of pours currently under a QC hold — flags quality risk requiring management intervention."
    - name: "avg_ambient_temperature_c"
      expr: AVG(CAST(ambient_temperature_c AS DOUBLE))
      comment: "Average ambient temperature during pours — supports weather-impact analysis on concrete quality."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`site_crew_deployment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Measures crew productivity, utilisation, and labour efficiency across work fronts and projects. Enables site managers and project controls teams to track planned vs. actual hours, overtime exposure, and production performance."
  source: "`vibe_construction_v1`.`site`.`crew_deployment`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Construction project the crew is deployed on — enables project-level labour analysis."
    - name: "deployment_date"
      expr: deployment_date
      comment: "Date of crew deployment — supports daily and weekly labour trend analysis."
    - name: "crew_type"
      expr: crew_type
      comment: "Type of crew (e.g. civil, structural, MEP) — enables trade-level productivity benchmarking."
    - name: "shift_type"
      expr: shift_type
      comment: "Shift classification (day/night/weekend) — supports shift-level efficiency comparison."
    - name: "deployment_status"
      expr: deployment_status
      comment: "Status of the deployment record — filters active, completed, or cancelled deployments."
    - name: "is_subcontractor_crew"
      expr: is_subcontractor_crew
      comment: "Indicates whether the crew is a subcontractor — enables direct vs. subcontract labour split analysis."
    - name: "is_overtime"
      expr: is_overtime
      comment: "Flags overtime deployments — supports overtime cost and scheduling risk monitoring."
    - name: "is_weather_impacted"
      expr: is_weather_impacted
      comment: "Flags deployments impacted by weather — quantifies weather-related productivity loss."
    - name: "work_front_id"
      expr: work_front_id
      comment: "Work front the crew is assigned to — enables front-level labour and production analysis."
    - name: "wbs_code"
      expr: wbs_code
      comment: "WBS code for the deployment — supports WBS-level labour cost and productivity rollup."
  measures:
    - name: "total_actual_hours"
      expr: SUM(CAST(actual_hours AS DOUBLE))
      comment: "Total actual labour hours deployed — primary labour consumption KPI."
    - name: "total_planned_hours"
      expr: SUM(CAST(planned_hours AS DOUBLE))
      comment: "Total planned labour hours — baseline for schedule adherence and resource planning."
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours incurred — drives cost overrun and fatigue risk decisions."
    - name: "total_actual_production_qty"
      expr: SUM(CAST(actual_production_qty AS DOUBLE))
      comment: "Total actual production quantity delivered by crews — measures output throughput."
    - name: "total_planned_production_qty"
      expr: SUM(CAST(planned_production_qty AS DOUBLE))
      comment: "Total planned production quantity — baseline for production performance assessment."
    - name: "avg_productivity_rate"
      expr: AVG(CAST(productivity_rate AS DOUBLE))
      comment: "Average crew productivity rate — key efficiency KPI for benchmarking and forecasting."
    - name: "total_deployment_count"
      expr: COUNT(1)
      comment: "Total number of crew deployment records — baseline activity volume metric."
    - name: "weather_impacted_deployment_count"
      expr: COUNT(CASE WHEN is_weather_impacted = TRUE THEN 1 END)
      comment: "Number of deployments impacted by weather — quantifies weather-driven productivity loss."
    - name: "overtime_deployment_count"
      expr: COUNT(CASE WHEN is_overtime = TRUE THEN 1 END)
      comment: "Number of overtime deployments — monitors overtime frequency for cost and fatigue risk management."
    - name: "subcontractor_deployment_count"
      expr: COUNT(CASE WHEN is_subcontractor_crew = TRUE THEN 1 END)
      comment: "Number of subcontractor crew deployments — supports subcontract labour monitoring and compliance."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`site_daily_log`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Aggregates daily site conditions, safety events, delays, and production volumes from site daily logs. Provides project managers and site superintendents with a consolidated view of daily site performance and risk indicators."
  source: "`vibe_construction_v1`.`site`.`daily_log`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Construction project the daily log belongs to — enables project-level daily performance analysis."
    - name: "log_date"
      expr: log_date
      comment: "Date of the daily log — primary time dimension for trend analysis."
    - name: "log_status"
      expr: log_status
      comment: "Approval status of the daily log — filters approved vs. pending records."
    - name: "shift_type"
      expr: shift_type
      comment: "Shift type recorded in the log — supports shift-level performance comparison."
    - name: "overall_site_status"
      expr: overall_site_status
      comment: "Overall site status for the day — high-level site health indicator."
    - name: "weather_condition"
      expr: weather_condition
      comment: "Weather condition recorded — supports weather-impact correlation analysis."
    - name: "has_delay_event"
      expr: has_delay_event
      comment: "Flags days with delay events — enables delay frequency and pattern analysis."
    - name: "lti_occurred_flag"
      expr: lti_occurred_flag
      comment: "Flags days with a Lost Time Injury — critical safety KPI dimension."
    - name: "ncr_raised_flag"
      expr: ncr_raised_flag
      comment: "Flags days where an NCR was raised — supports quality event frequency analysis."
    - name: "cost_impact_flag"
      expr: cost_impact_flag
      comment: "Flags days with a cost impact event — supports cost risk monitoring."
  measures:
    - name: "total_concrete_volume_m3"
      expr: SUM(CAST(concrete_volume_m3 AS DOUBLE))
      comment: "Total concrete volume poured as recorded in daily logs — tracks concrete production throughput."
    - name: "total_earthworks_volume_m3"
      expr: SUM(CAST(earthworks_volume_m3 AS DOUBLE))
      comment: "Total earthworks volume moved as recorded in daily logs — tracks earthworks production throughput."
    - name: "total_delay_duration_hrs"
      expr: SUM(CAST(total_delay_duration_hrs AS DOUBLE))
      comment: "Total delay hours recorded across all daily logs — primary schedule risk KPI."
    - name: "total_precipitation_mm"
      expr: SUM(CAST(precipitation_mm AS DOUBLE))
      comment: "Total precipitation recorded — supports weather-impact analysis on site productivity."
    - name: "avg_temperature_high_c"
      expr: AVG(CAST(temperature_high_c AS DOUBLE))
      comment: "Average daily high temperature — monitors extreme heat risk for workforce safety and productivity."
    - name: "lti_day_count"
      expr: COUNT(CASE WHEN lti_occurred_flag = TRUE THEN 1 END)
      comment: "Number of days with a Lost Time Injury — critical safety performance KPI."
    - name: "delay_day_count"
      expr: COUNT(CASE WHEN has_delay_event = TRUE THEN 1 END)
      comment: "Number of days with a recorded delay event — measures schedule disruption frequency."
    - name: "ncr_day_count"
      expr: COUNT(CASE WHEN ncr_raised_flag = TRUE THEN 1 END)
      comment: "Number of days with an NCR raised — measures quality event frequency."
    - name: "total_log_count"
      expr: COUNT(1)
      comment: "Total number of daily log records — baseline activity volume metric."
    - name: "cost_impact_day_count"
      expr: COUNT(CASE WHEN cost_impact_flag = TRUE THEN 1 END)
      comment: "Number of days with a cost impact event — supports cost risk trend monitoring."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`site_earthwork_volume`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks earthwork cut, fill, and net movement volumes against contracted quantities. Enables project engineers and quantity surveyors to monitor earthworks progress, compaction performance, and variation order exposure."
  source: "`vibe_construction_v1`.`site`.`earthwork_volume`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Construction project the earthwork volume belongs to — enables project-level earthworks analysis."
    - name: "measurement_date"
      expr: measurement_date
      comment: "Date the earthwork volume was measured — primary time dimension for progress trending."
    - name: "measurement_status"
      expr: measurement_status
      comment: "Approval status of the measurement — filters approved vs. pending volumes."
    - name: "material_classification"
      expr: material_classification
      comment: "Classification of earthwork material (e.g. rock, common fill) — supports material-type analysis."
    - name: "survey_method"
      expr: survey_method
      comment: "Survey method used (e.g. drone, total station) — supports measurement accuracy benchmarking."
    - name: "work_area_code"
      expr: work_area_code
      comment: "Work area identifier — enables zone-level earthworks progress tracking."
    - name: "is_variation_order"
      expr: is_variation_order
      comment: "Flags variation order earthworks — supports variation cost and scope analysis."
    - name: "wbs_element_id"
      expr: wbs_element_id
      comment: "WBS element the earthwork is charged to — enables WBS-level volume rollup."
  measures:
    - name: "total_cut_volume_m3"
      expr: SUM(CAST(cut_volume_m3 AS DOUBLE))
      comment: "Total cut volume in cubic metres — primary earthworks excavation KPI."
    - name: "total_fill_volume_m3"
      expr: SUM(CAST(fill_volume_m3 AS DOUBLE))
      comment: "Total fill volume in cubic metres — primary earthworks fill placement KPI."
    - name: "total_net_movement_m3"
      expr: SUM(CAST(net_movement_m3 AS DOUBLE))
      comment: "Total net earthwork movement (cut minus fill) — indicates mass balance and haul requirements."
    - name: "total_spoil_volume_m3"
      expr: SUM(CAST(spoil_volume_m3 AS DOUBLE))
      comment: "Total spoil volume requiring disposal — drives disposal cost and logistics planning."
    - name: "total_contracted_volume_m3"
      expr: SUM(CAST(contracted_volume_m3 AS DOUBLE))
      comment: "Total contracted earthwork volume — baseline for progress and variation analysis."
    - name: "total_cumulative_cut_volume_m3"
      expr: SUM(CAST(cumulative_cut_volume_m3 AS DOUBLE))
      comment: "Cumulative cut volume to date — tracks overall excavation progress against contract."
    - name: "total_cumulative_fill_volume_m3"
      expr: SUM(CAST(cumulative_fill_volume_m3 AS DOUBLE))
      comment: "Cumulative fill volume to date — tracks overall fill progress against contract."
    - name: "avg_compaction_factor"
      expr: AVG(CAST(compaction_factor AS DOUBLE))
      comment: "Average compaction factor across measurements — monitors fill quality and material behaviour."
    - name: "avg_swell_factor"
      expr: AVG(CAST(swell_factor AS DOUBLE))
      comment: "Average swell factor — supports bulk factor analysis for haul and disposal planning."
    - name: "variation_order_measurement_count"
      expr: COUNT(CASE WHEN is_variation_order = TRUE THEN 1 END)
      comment: "Number of earthwork measurements attributed to variation orders — quantifies scope change exposure."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`site_equipment_deployment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Measures equipment utilisation, productivity, fuel consumption, and breakdown frequency across construction sites. Enables plant managers and project controls to optimise fleet deployment and reduce idle and breakdown costs."
  source: "`vibe_construction_v1`.`site`.`equipment_deployment`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Construction project the equipment is deployed on — enables project-level fleet analysis."
    - name: "deployment_date"
      expr: deployment_date
      comment: "Date of equipment deployment — primary time dimension for utilisation trending."
    - name: "equipment_type"
      expr: equipment_type
      comment: "Type of equipment deployed — enables fleet category performance benchmarking."
    - name: "shift_type"
      expr: shift_type
      comment: "Shift type for the deployment — supports shift-level utilisation comparison."
    - name: "deployment_status"
      expr: deployment_status
      comment: "Status of the deployment record — filters active, completed, or cancelled deployments."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership type (owned/rented) — supports make-vs-buy and rental cost analysis."
    - name: "fuel_type"
      expr: fuel_type
      comment: "Fuel type used by the equipment — supports fuel cost and emissions analysis."
    - name: "breakdown_flag"
      expr: breakdown_flag
      comment: "Flags deployments with a breakdown event — enables breakdown frequency and impact analysis."
    - name: "work_front_id"
      expr: work_front_id
      comment: "Work front the equipment is assigned to — enables front-level fleet utilisation analysis."
  measures:
    - name: "total_operating_hours"
      expr: SUM(CAST(operating_hours AS DOUBLE))
      comment: "Total productive operating hours — primary equipment utilisation KPI."
    - name: "total_idle_hours"
      expr: SUM(CAST(idle_hours AS DOUBLE))
      comment: "Total idle hours — measures unproductive equipment time driving cost reduction decisions."
    - name: "total_standby_hours"
      expr: SUM(CAST(standby_hours AS DOUBLE))
      comment: "Total standby hours — quantifies equipment on-site but not operating, impacting rental cost."
    - name: "total_breakdown_hours"
      expr: SUM(CAST(breakdown_hours AS DOUBLE))
      comment: "Total hours lost to breakdowns — key reliability and maintenance effectiveness KPI."
    - name: "total_fuel_consumption_liters"
      expr: SUM(CAST(fuel_consumption_liters AS DOUBLE))
      comment: "Total fuel consumed in litres — drives fuel cost management and emissions reporting."
    - name: "total_production_quantity"
      expr: SUM(CAST(production_quantity AS DOUBLE))
      comment: "Total production quantity delivered by equipment — measures output throughput."
    - name: "avg_hourly_rate"
      expr: AVG(CAST(hourly_rate AS DOUBLE))
      comment: "Average hourly equipment rate — supports fleet cost benchmarking and rental negotiation."
    - name: "breakdown_event_count"
      expr: COUNT(CASE WHEN breakdown_flag = TRUE THEN 1 END)
      comment: "Number of deployment records with a breakdown — measures breakdown frequency for reliability analysis."
    - name: "total_deployment_count"
      expr: COUNT(1)
      comment: "Total number of equipment deployment records — baseline fleet activity volume metric."
    - name: "avg_fuel_consumption_per_deployment"
      expr: AVG(CAST(fuel_consumption_liters AS DOUBLE))
      comment: "Average fuel consumption per deployment record — supports fuel efficiency benchmarking by equipment type."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`site_field_progress`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks field-measured physical progress, earned value, and quantity installation rates across work activities. Enables project controls and earned value managers to assess schedule performance and forecast completion."
  source: "`vibe_construction_v1`.`site`.`field_progress`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Construction project the progress record belongs to — enables project-level progress analysis."
    - name: "measurement_date"
      expr: measurement_date
      comment: "Date the field progress was measured — primary time dimension for progress trending."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the progress record — filters approved vs. pending measurements."
    - name: "activity_type"
      expr: activity_type
      comment: "Type of activity being measured — enables activity category performance analysis."
    - name: "measurement_method"
      expr: measurement_method
      comment: "Method used to measure progress — supports measurement quality and consistency analysis."
    - name: "is_critical_path"
      expr: is_critical_path
      comment: "Flags critical path activities — enables focused monitoring of schedule-critical work."
    - name: "is_milestone"
      expr: is_milestone
      comment: "Flags milestone progress records — supports milestone achievement tracking."
    - name: "measurement_period_type"
      expr: measurement_period_type
      comment: "Period type (daily/weekly/monthly) — supports period-level progress aggregation."
    - name: "quantity_unit_of_measure"
      expr: quantity_unit_of_measure
      comment: "Unit of measure for installed quantities — ensures correct aggregation by trade/activity type."
    - name: "work_front"
      expr: work_front
      comment: "Work front identifier from the progress record — enables front-level progress analysis."
  measures:
    - name: "total_installed_quantity"
      expr: SUM(CAST(installed_quantity AS DOUBLE))
      comment: "Total quantity installed to date — primary physical progress KPI."
    - name: "total_period_installed_quantity"
      expr: SUM(CAST(period_installed_quantity AS DOUBLE))
      comment: "Total quantity installed in the reporting period — measures period production rate."
    - name: "total_planned_quantity"
      expr: SUM(CAST(planned_quantity AS DOUBLE))
      comment: "Total planned quantity — baseline for progress performance assessment."
    - name: "total_bcwp"
      expr: SUM(CAST(bcwp AS DOUBLE))
      comment: "Total Budgeted Cost of Work Performed (Earned Value) — core EVM KPI for project financial performance."
    - name: "total_budget_at_completion"
      expr: SUM(CAST(budget_at_completion AS DOUBLE))
      comment: "Total Budget at Completion — baseline for earned value and cost performance analysis."
    - name: "avg_reported_percent_complete"
      expr: AVG(CAST(reported_percent_complete AS DOUBLE))
      comment: "Average reported percent complete across activities — high-level progress health indicator."
    - name: "avg_progress_delta"
      expr: AVG(CAST(progress_delta AS DOUBLE))
      comment: "Average progress delta (period change in percent complete) — measures progress velocity."
    - name: "total_equipment_hours"
      expr: SUM(CAST(equipment_hours AS DOUBLE))
      comment: "Total equipment hours recorded in field progress — supports resource consumption analysis."
    - name: "critical_path_activity_count"
      expr: COUNT(CASE WHEN is_critical_path = TRUE THEN 1 END)
      comment: "Number of critical path progress records — enables focused critical path performance monitoring."
    - name: "total_progress_record_count"
      expr: COUNT(1)
      comment: "Total number of field progress records — baseline activity volume metric."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`site_lift_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Crane lift utilization and safety metrics."
  source: "`construction_ecm`.`site`.`lift_plan`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Construction project identifier."
    - name: "lift_date"
      expr: lift_date
      comment: "Date of the lift operation."
    - name: "crane_type"
      expr: crane_type
      comment: "Type/model of crane used."
    - name: "lift_type"
      expr: lift_type
      comment: "Classification of lift (e.g., heavy, routine)."
  measures:
    - name: "lift_count"
      expr: COUNT(1)
      comment: "Number of lift plan records (lifts executed)."
    - name: "total_load_weight_t"
      expr: SUM(CAST(load_weight_t AS DOUBLE))
      comment: "Total load weight lifted (tonnes)."
    - name: "avg_capacity_utilisation_pct"
      expr: AVG(CAST(capacity_utilisation_pct AS DOUBLE))
      comment: "Average crane capacity utilisation percentage."
    - name: "avg_load_weight_t"
      expr: AVG(CAST(load_weight_t AS DOUBLE))
      comment: "Average load weight per lift (tonnes)."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`site_material_delivery`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks material delivery performance, acceptance rates, and delivery value across construction sites. Enables procurement and site managers to monitor supplier delivery compliance, rejection rates, and material receipt efficiency."
  source: "`vibe_construction_v1`.`site`.`material_delivery`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Construction project the delivery belongs to — enables project-level delivery analysis."
    - name: "delivery_date"
      expr: delivery_date
      comment: "Date of material delivery — primary time dimension for delivery trending."
    - name: "delivery_status"
      expr: delivery_status
      comment: "Status of the delivery (accepted, rejected, partial) — filters delivery outcome analysis."
    - name: "material_category"
      expr: material_category
      comment: "Category of material delivered — enables category-level delivery performance analysis."
    - name: "receipt_condition"
      expr: receipt_condition
      comment: "Condition of materials on receipt — supports quality acceptance analysis."
    - name: "hazardous_material"
      expr: hazardous_material
      comment: "Flags hazardous material deliveries — supports HSE compliance monitoring."
    - name: "temperature_sensitive"
      expr: temperature_sensitive
      comment: "Flags temperature-sensitive material deliveries — supports cold chain compliance monitoring."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for delivered quantities — ensures correct aggregation by material type."
    - name: "wbs_code"
      expr: wbs_code
      comment: "WBS code for the delivery — supports WBS-level material receipt rollup."
  measures:
    - name: "total_quantity_delivered"
      expr: SUM(CAST(quantity_delivered AS DOUBLE))
      comment: "Total quantity of materials delivered — primary delivery throughput KPI."
    - name: "total_quantity_accepted"
      expr: SUM(CAST(quantity_accepted AS DOUBLE))
      comment: "Total quantity of materials accepted — measures effective material receipt."
    - name: "total_quantity_rejected"
      expr: SUM(CAST(quantity_rejected AS DOUBLE))
      comment: "Total quantity of materials rejected — key quality and supplier performance KPI."
    - name: "total_quantity_ordered"
      expr: SUM(CAST(quantity_ordered AS DOUBLE))
      comment: "Total quantity ordered — baseline for delivery fulfilment analysis."
    - name: "total_delivery_value"
      expr: SUM(CAST(delivery_value AS DOUBLE))
      comment: "Total value of materials delivered — primary financial throughput KPI for procurement."
    - name: "avg_unit_rate"
      expr: AVG(CAST(unit_rate AS DOUBLE))
      comment: "Average unit rate across deliveries — supports material cost benchmarking."
    - name: "hazardous_delivery_count"
      expr: COUNT(CASE WHEN hazardous_material = TRUE THEN 1 END)
      comment: "Number of hazardous material deliveries — supports HSE compliance and risk monitoring."
    - name: "total_delivery_count"
      expr: COUNT(1)
      comment: "Total number of material delivery records — baseline activity volume metric."
    - name: "rejected_delivery_count"
      expr: COUNT(CASE WHEN quantity_rejected > 0 THEN 1 END)
      comment: "Number of deliveries with any rejected quantity — measures supplier quality failure frequency."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`site_production_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Measures daily production output, labour and equipment resource consumption, and productivity rates at the work-front level. Enables site managers and project controls to track production efficiency and identify underperforming fronts."
  source: "`vibe_construction_v1`.`site`.`production_entry`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Construction project the production entry belongs to — enables project-level production analysis."
    - name: "entry_date"
      expr: entry_date
      comment: "Date of the production entry — primary time dimension for production trending."
    - name: "entry_status"
      expr: entry_status
      comment: "Approval status of the entry — filters approved vs. pending production records."
    - name: "production_type"
      expr: production_type
      comment: "Type of production activity — enables trade/activity category benchmarking."
    - name: "shift_type"
      expr: shift_type
      comment: "Shift type for the entry — supports shift-level production comparison."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for production quantities — ensures correct aggregation by activity type."
    - name: "is_rework"
      expr: is_rework
      comment: "Flags rework production entries — quantifies rework volume and cost impact."
    - name: "work_front_id"
      expr: work_front_id
      comment: "Work front the production is recorded against — enables front-level production analysis."
    - name: "wbs_code"
      expr: wbs_code
      comment: "WBS code for the production entry — supports WBS-level production rollup."
    - name: "weather_condition"
      expr: weather_condition
      comment: "Weather condition during production — supports weather-impact correlation analysis."
  measures:
    - name: "total_installed_quantity"
      expr: SUM(CAST(installed_quantity AS DOUBLE))
      comment: "Total quantity installed across production entries — primary production throughput KPI."
    - name: "total_budgeted_quantity"
      expr: SUM(CAST(budgeted_quantity AS DOUBLE))
      comment: "Total budgeted quantity — baseline for production performance and variance analysis."
    - name: "total_cumulative_quantity"
      expr: SUM(CAST(cumulative_quantity AS DOUBLE))
      comment: "Total cumulative quantity to date — tracks overall production progress."
    - name: "total_labor_hours"
      expr: SUM(CAST(labor_hours AS DOUBLE))
      comment: "Total labour hours consumed in production — primary labour resource consumption KPI."
    - name: "total_equipment_hours"
      expr: SUM(CAST(equipment_hours AS DOUBLE))
      comment: "Total equipment hours consumed in production — supports equipment resource consumption analysis."
    - name: "avg_production_rate"
      expr: AVG(CAST(production_rate AS DOUBLE))
      comment: "Average actual production rate — key efficiency KPI for benchmarking and forecasting."
    - name: "avg_budgeted_production_rate"
      expr: AVG(CAST(budgeted_production_rate AS DOUBLE))
      comment: "Average budgeted production rate — baseline for production rate variance analysis."
    - name: "avg_percent_complete"
      expr: AVG(CAST(percent_complete AS DOUBLE))
      comment: "Average percent complete across production entries — high-level progress health indicator."
    - name: "rework_entry_count"
      expr: COUNT(CASE WHEN is_rework = TRUE THEN 1 END)
      comment: "Number of rework production entries — measures rework frequency and quality performance."
    - name: "total_entry_count"
      expr: COUNT(1)
      comment: "Total number of production entries — baseline activity volume metric."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`site_shift_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Aggregates shift-level production output, labour hours, safety events, and delay durations. Enables site supervisors and project managers to monitor shift performance, safety compliance, and operational efficiency."
  source: "`vibe_construction_v1`.`site`.`shift_report`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Construction project the shift report belongs to — enables project-level shift analysis."
    - name: "shift_date"
      expr: shift_date
      comment: "Date of the shift — primary time dimension for shift performance trending."
    - name: "shift_type"
      expr: shift_type
      comment: "Shift classification (day/night/weekend) — supports shift-level performance comparison."
    - name: "report_status"
      expr: report_status
      comment: "Approval status of the shift report — filters approved vs. pending records."
    - name: "weather_condition"
      expr: weather_condition
      comment: "Weather condition during the shift — supports weather-impact correlation analysis."
    - name: "lti_flag"
      expr: lti_flag
      comment: "Flags shifts with a Lost Time Injury — critical safety KPI dimension."
    - name: "ncr_raised_flag"
      expr: ncr_raised_flag
      comment: "Flags shifts where an NCR was raised — supports quality event frequency analysis."
    - name: "tbm_conducted_flag"
      expr: tbm_conducted_flag
      comment: "Flags shifts where a toolbox meeting was conducted — monitors safety briefing compliance."
    - name: "work_front_id"
      expr: work_front_id
      comment: "Work front the shift report covers — enables front-level shift performance analysis."
    - name: "wbs_code"
      expr: wbs_code
      comment: "WBS code for the shift — supports WBS-level labour and production rollup."
  measures:
    - name: "total_labour_hours"
      expr: SUM(CAST(total_labour_hours AS DOUBLE))
      comment: "Total labour hours worked across shifts — primary labour consumption KPI."
    - name: "total_production_quantity"
      expr: SUM(CAST(production_quantity AS DOUBLE))
      comment: "Total production quantity delivered per shift — measures shift output throughput."
    - name: "total_planned_production_quantity"
      expr: SUM(CAST(planned_production_quantity AS DOUBLE))
      comment: "Total planned production quantity — baseline for shift production performance assessment."
    - name: "total_delay_duration_hrs"
      expr: SUM(CAST(delay_duration_hrs AS DOUBLE))
      comment: "Total delay hours recorded across shifts — primary schedule disruption KPI."
    - name: "total_concrete_volume_m3"
      expr: SUM(CAST(concrete_volume_m3 AS DOUBLE))
      comment: "Total concrete volume poured per shift — tracks concrete production throughput."
    - name: "total_earthworks_volume_m3"
      expr: SUM(CAST(earthworks_volume_m3 AS DOUBLE))
      comment: "Total earthworks volume moved per shift — tracks earthworks production throughput."
    - name: "avg_equipment_utilisation_pct"
      expr: AVG(CAST(equipment_utilisation_pct AS DOUBLE))
      comment: "Average equipment utilisation percentage per shift — measures fleet efficiency."
    - name: "lti_shift_count"
      expr: COUNT(CASE WHEN lti_flag = TRUE THEN 1 END)
      comment: "Number of shifts with a Lost Time Injury — critical safety performance KPI."
    - name: "tbm_compliance_count"
      expr: COUNT(CASE WHEN tbm_conducted_flag = TRUE THEN 1 END)
      comment: "Number of shifts where a toolbox meeting was conducted — measures safety briefing compliance."
    - name: "total_shift_count"
      expr: COUNT(1)
      comment: "Total number of shift reports — baseline activity volume metric."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`site_mobilization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks site mobilisation readiness, cost performance, and schedule adherence for construction project startups. Enables project directors and site managers to monitor mobilisation milestones, budget compliance, and permit readiness."
  source: "`vibe_construction_v1`.`site`.`site_mobilization`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Construction project the mobilisation belongs to — enables project-level mobilisation analysis."
    - name: "mobilization_status"
      expr: mobilization_status
      comment: "Current status of the mobilisation — filters active, completed, or planned mobilisations."
    - name: "mobilization_type"
      expr: mobilization_type
      comment: "Type of mobilisation (initial, remobilisation) — supports mobilisation category analysis."
    - name: "country_code"
      expr: country_code
      comment: "Country of the site — enables geographic mobilisation analysis."
    - name: "environmental_permit_obtained"
      expr: environmental_permit_obtained
      comment: "Flags whether the environmental permit has been obtained — monitors regulatory readiness."
    - name: "hse_plan_approved"
      expr: hse_plan_approved
      comment: "Flags whether the HSE plan has been approved — monitors safety readiness for mobilisation."
    - name: "access_road_established"
      expr: access_road_established
      comment: "Flags whether the access road is established — monitors site access readiness."
    - name: "site_office_established"
      expr: site_office_established
      comment: "Flags whether the site office is established — monitors site infrastructure readiness."
    - name: "planned_mobilization_date"
      expr: planned_mobilization_date
      comment: "Planned mobilisation date — supports schedule adherence analysis."
  measures:
    - name: "total_cost_actual"
      expr: SUM(CAST(cost_actual AS DOUBLE))
      comment: "Total actual mobilisation cost — primary cost performance KPI for site startups."
    - name: "total_cost_budget"
      expr: SUM(CAST(cost_budget AS DOUBLE))
      comment: "Total budgeted mobilisation cost — baseline for mobilisation cost variance analysis."
    - name: "total_site_area_sqm"
      expr: SUM(CAST(site_area_sqm AS DOUBLE))
      comment: "Total site area in square metres across mobilisations — supports site scale and resource planning."
    - name: "mobilization_count"
      expr: COUNT(1)
      comment: "Total number of site mobilisation records — baseline activity volume metric."
    - name: "environmental_permit_obtained_count"
      expr: COUNT(CASE WHEN environmental_permit_obtained = TRUE THEN 1 END)
      comment: "Number of mobilisations with environmental permit obtained — monitors regulatory compliance readiness."
    - name: "hse_plan_approved_count"
      expr: COUNT(CASE WHEN hse_plan_approved = TRUE THEN 1 END)
      comment: "Number of mobilisations with HSE plan approved — monitors safety readiness compliance rate."
    - name: "site_office_established_count"
      expr: COUNT(CASE WHEN site_office_established = TRUE THEN 1 END)
      comment: "Number of mobilisations with site office established — tracks infrastructure readiness milestone."
    - name: "avg_cost_budget"
      expr: AVG(CAST(cost_budget AS DOUBLE))
      comment: "Average budgeted mobilisation cost — supports mobilisation cost benchmarking across projects."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`site_permit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks site permit status, expiry risk, and fee exposure across construction projects. Enables compliance managers and project directors to monitor permit coverage, renewal risk, and regulatory compliance."
  source: "`vibe_construction_v1`.`site`.`site_permit`"
  dimensions:
    - name: "permit_type"
      expr: permit_type
      comment: "Type of site permit (building, environmental, access) — enables permit category analysis."
    - name: "permit_category"
      expr: permit_category
      comment: "Category of the permit — supports regulatory category compliance monitoring."
    - name: "site_permit_status"
      expr: site_permit_status
      comment: "Current status of the permit — filters active, expired, or pending permits."
    - name: "issuing_authority"
      expr: issuing_authority
      comment: "Authority that issued the permit — enables authority-level compliance analysis."
    - name: "is_environmental"
      expr: is_environmental
      comment: "Flags environmental permits — supports environmental compliance monitoring."
    - name: "is_safety_critical"
      expr: is_safety_critical
      comment: "Flags safety-critical permits — enables prioritised safety compliance monitoring."
    - name: "extension_requested"
      expr: extension_requested
      comment: "Flags permits with an extension request — monitors renewal pipeline."
    - name: "expiration_notice_sent"
      expr: expiration_notice_sent
      comment: "Flags permits where expiration notice has been sent — monitors renewal process compliance."
    - name: "expiry_date"
      expr: expiry_date
      comment: "Permit expiry date — supports expiry risk and renewal scheduling analysis."
  measures:
    - name: "total_fee_amount"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total permit fees paid or payable — primary financial exposure KPI for regulatory compliance."
    - name: "total_permit_count"
      expr: COUNT(1)
      comment: "Total number of site permits — baseline regulatory coverage metric."
    - name: "safety_critical_permit_count"
      expr: COUNT(CASE WHEN is_safety_critical = TRUE THEN 1 END)
      comment: "Number of safety-critical permits — enables prioritised safety compliance monitoring."
    - name: "environmental_permit_count"
      expr: COUNT(CASE WHEN is_environmental = TRUE THEN 1 END)
      comment: "Number of environmental permits — supports environmental compliance coverage analysis."
    - name: "extension_requested_count"
      expr: COUNT(CASE WHEN extension_requested = TRUE THEN 1 END)
      comment: "Number of permits with an extension request — monitors renewal pipeline volume."
    - name: "avg_fee_amount"
      expr: AVG(CAST(fee_amount AS DOUBLE))
      comment: "Average permit fee amount — supports permit cost benchmarking and budget planning."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`site_work_front`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks work front progress, production performance, and resource deployment status across construction sites. Enables project managers to monitor front-level schedule adherence, production efficiency, and critical path exposure."
  source: "`vibe_construction_v1`.`site`.`work_front`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Construction project the work front belongs to — enables project-level front analysis."
    - name: "front_type"
      expr: front_type
      comment: "Type of work front (e.g. civil, structural, MEP) — enables trade-level performance benchmarking."
    - name: "front_status"
      expr: front_status
      comment: "Current status of the work front — filters active, completed, or suspended fronts."
    - name: "current_phase"
      expr: current_phase
      comment: "Current construction phase of the front — supports phase-level progress analysis."
    - name: "is_critical_path"
      expr: is_critical_path
      comment: "Flags critical path work fronts — enables focused monitoring of schedule-critical fronts."
    - name: "is_subcontracted"
      expr: is_subcontracted
      comment: "Indicates whether the front is subcontracted — supports direct vs. subcontract performance comparison."
    - name: "hse_risk_level"
      expr: hse_risk_level
      comment: "HSE risk level of the work front — supports risk-based resource allocation decisions."
    - name: "zone_classification"
      expr: zone_classification
      comment: "Zone classification of the work front — enables zone-level analysis."
    - name: "site_id"
      expr: site_id
      comment: "Site the work front is located on — enables site-level front aggregation."
  measures:
    - name: "total_actual_production_qty"
      expr: SUM(CAST(actual_production_qty AS DOUBLE))
      comment: "Total actual production quantity across work fronts — primary output throughput KPI."
    - name: "total_planned_production_qty"
      expr: SUM(CAST(planned_production_qty AS DOUBLE))
      comment: "Total planned production quantity — baseline for production performance assessment."
    - name: "avg_percent_complete"
      expr: AVG(CAST(percent_complete AS DOUBLE))
      comment: "Average percent complete across work fronts — high-level progress health indicator."
    - name: "total_area_sqm"
      expr: SUM(CAST(area_sqm AS DOUBLE))
      comment: "Total area in square metres covered by work fronts — supports scope and resource density analysis."
    - name: "critical_path_front_count"
      expr: COUNT(CASE WHEN is_critical_path = TRUE THEN 1 END)
      comment: "Number of critical path work fronts — enables focused critical path performance monitoring."
    - name: "subcontracted_front_count"
      expr: COUNT(CASE WHEN is_subcontracted = TRUE THEN 1 END)
      comment: "Number of subcontracted work fronts — supports subcontract scope and performance monitoring."
    - name: "total_work_front_count"
      expr: COUNT(1)
      comment: "Total number of work fronts — baseline scope volume metric."
    - name: "avg_elevation_m"
      expr: AVG(CAST(elevation_m AS DOUBLE))
      comment: "Average elevation of work fronts — supports logistics and access planning for elevated works."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`site_work_front_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks craft worker assignments to work fronts, measuring allocation efficiency, actual vs. planned hours, and completion rates. Enables workforce planners and site managers to optimise labour allocation and identify under-resourced fronts."
  source: "`vibe_construction_v1`.`site`.`work_front_assignment`"
  dimensions:
    - name: "work_front_id"
      expr: work_front_id
      comment: "Work front the worker is assigned to — enables front-level assignment analysis."
    - name: "assignment_date"
      expr: assignment_date
      comment: "Date of the assignment — primary time dimension for assignment trending."
    - name: "assignment_status"
      expr: assignment_status
      comment: "Status of the assignment — filters active, completed, or cancelled assignments."
    - name: "role"
      expr: role
      comment: "Role of the assigned worker on the front — enables role-level resource analysis."
    - name: "shift"
      expr: shift
      comment: "Shift the worker is assigned to — supports shift-level allocation analysis."
    - name: "priority"
      expr: priority
      comment: "Priority of the assignment — supports prioritised resource allocation decisions."
    - name: "is_active"
      expr: is_active
      comment: "Flags currently active assignments — filters live workforce deployment."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for assigned quantities — ensures correct aggregation by work type."
  measures:
    - name: "total_actual_hours"
      expr: SUM(CAST(actual_hours AS DOUBLE))
      comment: "Total actual hours worked by assigned craft workers — primary labour consumption KPI."
    - name: "total_planned_hours"
      expr: SUM(CAST(planned_hours AS DOUBLE))
      comment: "Total planned hours for assignments — baseline for labour schedule adherence."
    - name: "total_allocated_hours"
      expr: SUM(CAST(allocated_hours AS DOUBLE))
      comment: "Total allocated hours across assignments — measures workforce capacity committed to fronts."
    - name: "total_assigned_quantity"
      expr: SUM(CAST(assigned_quantity AS DOUBLE))
      comment: "Total quantity assigned to craft workers — measures scope allocated to the workforce."
    - name: "avg_completion_pct"
      expr: AVG(CAST(completion_pct AS DOUBLE))
      comment: "Average completion percentage across assignments — measures workforce progress against assigned scope."
    - name: "avg_progress_percent"
      expr: AVG(CAST(progress_percent AS DOUBLE))
      comment: "Average progress percent reported by assigned workers — supports front-level progress monitoring."
    - name: "avg_allocation_percentage"
      expr: AVG(CAST(allocation_percentage AS DOUBLE))
      comment: "Average allocation percentage per assignment — identifies over- or under-allocated workers."
    - name: "active_assignment_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Number of currently active assignments — measures live workforce deployment size."
    - name: "total_assignment_count"
      expr: COUNT(1)
      comment: "Total number of work front assignments — baseline workforce deployment volume metric."
$$;
