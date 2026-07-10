-- Metric views for domain: site | Business: Construction | Version: 2 | Generated on: 2026-07-10 12:14:04

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`site_concrete_pour`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks concrete pour execution quality, volume throughput, and QC compliance across project pours. Used by site engineers and project managers to monitor structural progress, slump test pass rates, and pour efficiency."
  source: "`vibe_construction_v1`.`site`.`concrete_pour`"
  dimensions:
    - name: "pour_date"
      expr: pour_date
      comment: "Date the concrete pour was executed — enables daily and weekly trend analysis."
    - name: "pour_status"
      expr: pour_status
      comment: "Current status of the pour (e.g. Completed, On Hold, Rejected) — used to filter active vs closed pours."
    - name: "pour_type"
      expr: pour_type
      comment: "Type of pour (e.g. Slab, Column, Beam) — enables structural element breakdown."
    - name: "structure_element"
      expr: structure_element
      comment: "Structural element being poured — supports element-level quality and volume reporting."
    - name: "mix_design_code"
      expr: mix_design_code
      comment: "Concrete mix design code — enables analysis of strength compliance by mix type."
    - name: "placement_method"
      expr: placement_method
      comment: "Method used to place concrete (e.g. Pump, Skip, Direct) — supports method efficiency analysis."
    - name: "curing_method"
      expr: curing_method
      comment: "Curing method applied — relevant to strength development and QC compliance."
    - name: "qc_hold_status"
      expr: qc_hold_status
      comment: "QC hold flag status — identifies pours under quality hold for management escalation."
    - name: "weather_condition"
      expr: weather_condition
      comment: "Weather condition at time of pour — used to correlate weather impact on slump and quality outcomes."
  measures:
    - name: "total_volume_poured_m3"
      expr: SUM(CAST(volume_poured_m3 AS DOUBLE))
      comment: "Total concrete volume poured in cubic metres. Core production throughput KPI for structural progress tracking."
    - name: "avg_volume_per_pour_m3"
      expr: AVG(CAST(volume_poured_m3 AS DOUBLE))
      comment: "Average concrete volume per pour event. Indicates pour batch sizing efficiency and planning accuracy."
    - name: "total_pour_count"
      expr: COUNT(1)
      comment: "Total number of concrete pour events. Baseline activity volume metric for scheduling and resource planning."
    - name: "slump_compliant_pour_count"
      expr: COUNT(CASE WHEN slump_compliant = TRUE THEN 1 END)
      comment: "Number of pours where slump test result was within specification. Numerator for slump compliance rate."
    - name: "slump_non_compliant_pour_count"
      expr: COUNT(CASE WHEN slump_compliant = FALSE THEN 1 END)
      comment: "Number of pours where slump test failed specification. Drives NCR and rework cost exposure."
    - name: "avg_slump_test_result_mm"
      expr: AVG(CAST(slump_test_result_mm AS DOUBLE))
      comment: "Average slump test result in millimetres across all pours. Indicates concrete workability and mix consistency."
    - name: "avg_specified_strength_mpa"
      expr: AVG(CAST(specified_strength_mpa AS DOUBLE))
      comment: "Average specified compressive strength in MPa across pours. Supports mix design adequacy review."
    - name: "qc_hold_pour_count"
      expr: COUNT(CASE WHEN qc_hold_status IS NOT NULL AND qc_hold_status <> '' THEN 1 END)
      comment: "Number of pours currently under a QC hold. High values signal systemic quality issues requiring management intervention."
    - name: "avg_ambient_temperature_c"
      expr: AVG(CAST(ambient_temperature_c AS DOUBLE))
      comment: "Average ambient temperature at time of pour. Used to assess hot/cold weather concreting risk and curing adequacy."
    - name: "avg_concrete_temperature_c"
      expr: AVG(CAST(concrete_temperature_c AS DOUBLE))
      comment: "Average concrete temperature at placement. Compliance with temperature limits is a structural quality requirement."
    - name: "avg_relative_humidity_pct"
      expr: AVG(CAST(relative_humidity_pct AS DOUBLE))
      comment: "Average relative humidity during pours. Informs curing method selection and evaporation risk management."
    - name: "avg_wind_speed_kmh"
      expr: AVG(CAST(wind_speed_kmh AS DOUBLE))
      comment: "Average wind speed during pours. High wind speeds increase evaporation risk and may require pour suspension."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`site_crew_deployment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Measures crew productivity, overtime exposure, and labour efficiency across site deployments. Used by site managers and project controls to optimise workforce allocation and identify productivity losses."
  source: "`vibe_construction_v1`.`site`.`crew_deployment`"
  dimensions:
    - name: "deployment_date"
      expr: deployment_date
      comment: "Date of crew deployment — enables daily and weekly labour trend analysis."
    - name: "deployment_status"
      expr: deployment_status
      comment: "Status of the deployment record (e.g. Active, Completed, Cancelled) — filters operational vs historical records."
    - name: "crew_type"
      expr: crew_type
      comment: "Type of crew (e.g. Civil, Structural, MEP) — enables trade-level productivity benchmarking."
    - name: "shift_type"
      expr: shift_type
      comment: "Shift type (Day/Night/Weekend) — used to analyse overtime patterns and shift productivity differentials."
    - name: "is_subcontractor_crew"
      expr: is_subcontractor_crew
      comment: "Flag indicating whether the crew is a subcontractor crew — enables direct vs subcontract labour cost comparison."
    - name: "is_overtime"
      expr: is_overtime
      comment: "Flag indicating overtime deployment — used to track overtime frequency and cost exposure."
    - name: "is_weather_impacted"
      expr: is_weather_impacted
      comment: "Flag indicating weather-impacted deployment — supports weather delay cost and productivity impact analysis."
    - name: "weather_condition"
      expr: weather_condition
      comment: "Weather condition during deployment — correlates weather type with productivity outcomes."
    - name: "delay_reason_code"
      expr: delay_reason_code
      comment: "Reason code for deployment delay — enables root cause analysis of productivity losses."
  measures:
    - name: "total_actual_hours"
      expr: SUM(CAST(actual_hours AS DOUBLE))
      comment: "Total actual labour hours deployed. Core workforce utilisation KPI for cost and schedule control."
    - name: "total_planned_hours"
      expr: SUM(CAST(planned_hours AS DOUBLE))
      comment: "Total planned labour hours. Denominator for schedule adherence and productivity variance analysis."
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours incurred. Directly drives premium labour cost and is a leading indicator of schedule pressure."
    - name: "avg_productivity_rate"
      expr: AVG(CAST(productivity_rate AS DOUBLE))
      comment: "Average crew productivity rate (actual production per hour). Key efficiency KPI for benchmarking crew performance."
    - name: "total_actual_production_qty"
      expr: SUM(CAST(actual_production_qty AS DOUBLE))
      comment: "Total actual production quantity achieved across deployments. Measures physical output against plan."
    - name: "total_planned_production_qty"
      expr: SUM(CAST(planned_production_qty AS DOUBLE))
      comment: "Total planned production quantity. Denominator for production achievement rate calculation."
    - name: "deployment_count"
      expr: COUNT(1)
      comment: "Total number of crew deployment records. Baseline activity volume for workforce planning."
    - name: "weather_impacted_deployment_count"
      expr: COUNT(CASE WHEN is_weather_impacted = TRUE THEN 1 END)
      comment: "Number of deployments impacted by weather. Informs weather risk provisions and EOT claim substantiation."
    - name: "overtime_deployment_count"
      expr: COUNT(CASE WHEN is_overtime = TRUE THEN 1 END)
      comment: "Number of deployments involving overtime. Tracks overtime frequency for cost control and fatigue risk management."
    - name: "ppe_compliant_deployment_count"
      expr: COUNT(CASE WHEN ppe_compliance = TRUE THEN 1 END)
      comment: "Number of deployments with full PPE compliance recorded. Safety compliance KPI for HSE reporting."
    - name: "tbm_conducted_deployment_count"
      expr: COUNT(CASE WHEN hse_toolbox_meeting_held = TRUE THEN 1 END)
      comment: "Number of deployments where a toolbox meeting was held. Leading safety indicator for HSE governance."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`site_daily_log`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Aggregates daily site activity, weather impacts, safety events, and production volumes from site daily logs. Used by project managers and site superintendents to monitor daily site performance and identify emerging risks."
  source: "`vibe_construction_v1`.`site`.`daily_log`"
  dimensions:
    - name: "log_date"
      expr: log_date
      comment: "Date of the daily log entry — primary time dimension for daily site performance trending."
    - name: "log_status"
      expr: log_status
      comment: "Approval status of the daily log (e.g. Draft, Submitted, Approved) — filters confirmed vs pending records."
    - name: "shift_type"
      expr: shift_type
      comment: "Shift type (Day/Night) — enables shift-level performance comparison."
    - name: "overall_site_status"
      expr: overall_site_status
      comment: "Overall site status for the day (e.g. Normal, Delayed, Shutdown) — executive-level site health indicator."
    - name: "weather_condition"
      expr: weather_condition
      comment: "Weather condition recorded for the day — used to correlate weather with productivity and safety outcomes."
    - name: "site_access_status"
      expr: site_access_status
      comment: "Site access status (e.g. Open, Restricted, Closed) — tracks access disruptions affecting productivity."
  measures:
    - name: "total_concrete_volume_m3"
      expr: SUM(CAST(concrete_volume_m3 AS DOUBLE))
      comment: "Total concrete volume poured as recorded in daily logs. Tracks structural production throughput over time."
    - name: "total_earthworks_volume_m3"
      expr: SUM(CAST(earthworks_volume_m3 AS DOUBLE))
      comment: "Total earthworks volume moved as recorded in daily logs. Key civil works production KPI."
    - name: "total_precipitation_mm"
      expr: SUM(CAST(precipitation_mm AS DOUBLE))
      comment: "Total rainfall recorded across log days. Used to substantiate weather delay claims and assess site drainage needs."
    - name: "avg_precipitation_mm"
      expr: AVG(CAST(precipitation_mm AS DOUBLE))
      comment: "Average daily rainfall. Baseline for weather risk analysis and seasonal planning."
    - name: "total_delay_duration_hrs"
      expr: SUM(CAST(total_delay_duration_hrs AS DOUBLE))
      comment: "Total delay hours recorded across all daily logs. Directly informs EOT claim quantum and schedule recovery planning."
    - name: "avg_temperature_high_c"
      expr: AVG(CAST(temperature_high_c AS DOUBLE))
      comment: "Average daily high temperature. Used to assess heat stress risk and hot weather concreting compliance."
    - name: "avg_temperature_low_c"
      expr: AVG(CAST(temperature_low_c AS DOUBLE))
      comment: "Average daily low temperature. Used to assess cold weather concreting and frost risk."
    - name: "avg_wind_speed_kmh"
      expr: AVG(CAST(wind_speed_kmh AS DOUBLE))
      comment: "Average wind speed recorded in daily logs. Informs crane lift suspension decisions and weather delay substantiation."
    - name: "log_count"
      expr: COUNT(1)
      comment: "Total number of daily log records. Baseline for log completion rate and site activity coverage."
    - name: "delay_event_day_count"
      expr: COUNT(CASE WHEN has_delay_event = TRUE THEN 1 END)
      comment: "Number of days with a recorded delay event. Tracks delay frequency for schedule risk and EOT substantiation."
    - name: "safety_observation_day_count"
      expr: COUNT(CASE WHEN has_safety_observation = TRUE THEN 1 END)
      comment: "Number of days with safety observations recorded. Leading safety indicator for HSE performance reporting."
    - name: "lti_day_count"
      expr: COUNT(CASE WHEN lti_occurred_flag = TRUE THEN 1 END)
      comment: "Number of days with a Lost Time Injury recorded. Critical safety lagging indicator for executive HSE reporting."
    - name: "ncr_raised_day_count"
      expr: COUNT(CASE WHEN ncr_raised_flag = TRUE THEN 1 END)
      comment: "Number of days with a Non-Conformance Report raised. Quality performance indicator for project governance."
    - name: "tbm_conducted_day_count"
      expr: COUNT(CASE WHEN tbm_conducted_flag = TRUE THEN 1 END)
      comment: "Number of days where a Toolbox Meeting was conducted. Leading safety compliance indicator."
    - name: "cost_impact_day_count"
      expr: COUNT(CASE WHEN cost_impact_flag = TRUE THEN 1 END)
      comment: "Number of days with a cost impact event recorded. Tracks frequency of cost-affecting site events."
    - name: "eot_impact_day_count"
      expr: COUNT(CASE WHEN eot_impact_flag = TRUE THEN 1 END)
      comment: "Number of days with an EOT-impacting event. Supports Extension of Time claim substantiation and schedule risk reporting."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`site_earthwork_volume`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Measures earthworks production volumes, cut/fill balance, and survey accuracy across project areas. Used by project controls and site engineers to track earthworks progress against contract quantities and manage spoil disposal costs."
  source: "`vibe_construction_v1`.`site`.`earthwork_volume`"
  dimensions:
    - name: "measurement_date"
      expr: measurement_date
      comment: "Date of earthworks measurement — primary time dimension for production progress trending."
    - name: "measurement_status"
      expr: measurement_status
      comment: "Status of the measurement record (e.g. Approved, Pending, Rejected) — filters confirmed production quantities."
    - name: "survey_method"
      expr: survey_method
      comment: "Survey method used (e.g. Drone, Total Station, GPS) — enables accuracy and method comparison."
    - name: "material_classification"
      expr: material_classification
      comment: "Material type classification (e.g. Rock, Common, Topsoil) — drives unit rate and disposal cost analysis."
    - name: "work_area_code"
      expr: work_area_code
      comment: "Work area code — enables spatial breakdown of earthworks production by zone."
    - name: "is_variation_order"
      expr: is_variation_order
      comment: "Flag indicating whether the earthworks are under a variation order — separates base contract from variation scope."
    - name: "reporting_period_start"
      expr: reporting_period_start
      comment: "Start of the reporting period — enables period-based production reporting for progress claims."
  measures:
    - name: "total_cut_volume_m3"
      expr: SUM(CAST(cut_volume_m3 AS DOUBLE))
      comment: "Total cut volume in cubic metres. Core earthworks production KPI for schedule and cost control."
    - name: "total_fill_volume_m3"
      expr: SUM(CAST(fill_volume_m3 AS DOUBLE))
      comment: "Total fill volume in cubic metres. Tracks embankment and fill placement progress against design."
    - name: "total_net_movement_m3"
      expr: SUM(CAST(net_movement_m3 AS DOUBLE))
      comment: "Total net earthworks movement (cut minus fill). Indicates mass haul balance and import/export requirements."
    - name: "total_spoil_volume_m3"
      expr: SUM(CAST(spoil_volume_m3 AS DOUBLE))
      comment: "Total spoil volume requiring off-site disposal. Drives disposal cost forecasting and environmental compliance."
    - name: "total_contracted_volume_m3"
      expr: SUM(CAST(contracted_volume_m3 AS DOUBLE))
      comment: "Total contracted earthworks volume. Denominator for production achievement rate against contract scope."
    - name: "total_cumulative_cut_volume_m3"
      expr: SUM(CAST(cumulative_cut_volume_m3 AS DOUBLE))
      comment: "Cumulative cut volume to date. Tracks overall earthworks progress against total contract cut quantity."
    - name: "total_cumulative_fill_volume_m3"
      expr: SUM(CAST(cumulative_fill_volume_m3 AS DOUBLE))
      comment: "Cumulative fill volume to date. Tracks overall fill placement progress against total contract fill quantity."
    - name: "avg_compaction_factor"
      expr: AVG(CAST(compaction_factor AS DOUBLE))
      comment: "Average compaction factor across measurements. Used to validate fill quality and adjust volume calculations."
    - name: "avg_swell_factor"
      expr: AVG(CAST(swell_factor AS DOUBLE))
      comment: "Average swell factor across measurements. Informs mass haul calculations and truck load planning."
    - name: "avg_disposal_distance_km"
      expr: AVG(CAST(disposal_distance_km AS DOUBLE))
      comment: "Average spoil disposal distance in kilometres. Key driver of earthworks haulage cost and schedule."
    - name: "measurement_count"
      expr: COUNT(1)
      comment: "Total number of earthworks measurement records. Baseline for survey frequency and coverage analysis."
    - name: "variation_measurement_count"
      expr: COUNT(CASE WHEN is_variation_order = TRUE THEN 1 END)
      comment: "Number of measurements under variation orders. Tracks scope growth in earthworks for commercial management."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`site_equipment_deployment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks equipment utilisation, fuel consumption, breakdown frequency, and operating cost across site deployments. Used by plant managers and project controls to optimise equipment allocation and minimise idle and breakdown costs."
  source: "`vibe_construction_v1`.`site`.`equipment_deployment`"
  dimensions:
    - name: "deployment_date"
      expr: deployment_date
      comment: "Date of equipment deployment — primary time dimension for utilisation trending."
    - name: "deployment_status"
      expr: deployment_status
      comment: "Status of the deployment (e.g. Active, Completed, Breakdown) — filters operational vs non-productive records."
    - name: "equipment_type"
      expr: equipment_type
      comment: "Type of equipment deployed (e.g. Excavator, Crane, Dozer) — enables fleet-level performance benchmarking."
    - name: "shift_type"
      expr: shift_type
      comment: "Shift type (Day/Night) — enables shift-level utilisation and fuel consumption comparison."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Equipment ownership type (Owned/Rented/Hired) — drives cost allocation and make-vs-buy analysis."
    - name: "fuel_type"
      expr: fuel_type
      comment: "Fuel type (Diesel/Petrol/Electric) — supports carbon emissions reporting and fuel cost analysis."
    - name: "weather_condition"
      expr: weather_condition
      comment: "Weather condition during deployment — correlates weather with equipment utilisation and breakdown rates."
  measures:
    - name: "total_operating_hours"
      expr: SUM(CAST(operating_hours AS DOUBLE))
      comment: "Total equipment operating hours. Primary utilisation KPI for plant management and cost recovery."
    - name: "total_idle_hours"
      expr: SUM(CAST(idle_hours AS DOUBLE))
      comment: "Total idle hours across deployments. High idle hours indicate poor scheduling or access constraints — direct cost waste."
    - name: "total_standby_hours"
      expr: SUM(CAST(standby_hours AS DOUBLE))
      comment: "Total standby hours. Standby costs are often contractually recoverable — tracks claim exposure."
    - name: "total_breakdown_hours"
      expr: SUM(CAST(breakdown_hours AS DOUBLE))
      comment: "Total hours lost to equipment breakdown. Key reliability KPI driving maintenance strategy and fleet replacement decisions."
    - name: "total_fuel_consumption_liters"
      expr: SUM(CAST(fuel_consumption_liters AS DOUBLE))
      comment: "Total fuel consumed in litres. Drives fuel cost forecasting and carbon emissions calculations."
    - name: "avg_hourly_rate"
      expr: AVG(CAST(hourly_rate AS DOUBLE))
      comment: "Average equipment hourly rate. Used for cost benchmarking and rental vs ownership analysis."
    - name: "total_production_quantity"
      expr: SUM(CAST(production_quantity AS DOUBLE))
      comment: "Total production quantity achieved by deployed equipment. Measures equipment output against planned targets."
    - name: "total_planned_production_quantity"
      expr: SUM(CAST(planned_production_quantity AS DOUBLE))
      comment: "Total planned production quantity for deployed equipment. Denominator for equipment productivity achievement rate."
    - name: "deployment_count"
      expr: COUNT(1)
      comment: "Total number of equipment deployment records. Baseline for fleet activity volume analysis."
    - name: "breakdown_deployment_count"
      expr: COUNT(CASE WHEN breakdown_flag = TRUE THEN 1 END)
      comment: "Number of deployments with a breakdown event. Tracks breakdown frequency for reliability and maintenance KPIs."
    - name: "pre_start_check_compliant_count"
      expr: COUNT(CASE WHEN pre_start_check_flag = TRUE THEN 1 END)
      comment: "Number of deployments with a completed pre-start check. Leading safety and compliance indicator for plant operations."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`site_field_progress`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Measures field-level construction progress, earned value, and production achievement against plan. Used by project controls and site managers to track physical percent complete, identify schedule slippage, and manage earned value."
  source: "`vibe_construction_v1`.`site`.`field_progress`"
  dimensions:
    - name: "data_date"
      expr: data_date
      comment: "Progress data date — primary time dimension for earned value and progress trending."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the progress record (e.g. Approved, Pending, Rejected) — filters confirmed vs unverified progress."
    - name: "activity_type"
      expr: activity_type
      comment: "Type of construction activity — enables trade and discipline-level progress breakdown."
    - name: "measurement_method"
      expr: measurement_method
      comment: "Method used to measure progress (e.g. Physical, Weighted Steps, Milestones) — supports measurement quality analysis."
    - name: "measurement_period_type"
      expr: measurement_period_type
      comment: "Period type (Daily/Weekly/Monthly) — enables period-based progress reporting for progress claims."
    - name: "is_critical_path"
      expr: is_critical_path
      comment: "Flag indicating critical path activity — enables focused monitoring of schedule-critical work."
    - name: "is_milestone"
      expr: is_milestone
      comment: "Flag indicating a milestone activity — tracks key contractual milestone achievement."
    - name: "weather_condition"
      expr: weather_condition
      comment: "Weather condition at time of measurement — correlates weather with progress achievement."
  measures:
    - name: "total_installed_quantity"
      expr: SUM(CAST(installed_quantity AS DOUBLE))
      comment: "Total installed quantity to date. Core physical progress KPI for production tracking and progress claim support."
    - name: "total_period_installed_quantity"
      expr: SUM(CAST(period_installed_quantity AS DOUBLE))
      comment: "Total quantity installed in the current period. Measures period production rate for schedule adherence."
    - name: "total_planned_quantity"
      expr: SUM(CAST(planned_quantity AS DOUBLE))
      comment: "Total planned quantity. Denominator for production achievement rate and schedule variance analysis."
    - name: "total_bcwp"
      expr: SUM(CAST(bcwp AS DOUBLE))
      comment: "Total Budgeted Cost of Work Performed (Earned Value). Core EVM KPI for project financial performance."
    - name: "total_budget_at_completion"
      expr: SUM(CAST(budget_at_completion AS DOUBLE))
      comment: "Total Budget at Completion across activities. Denominator for overall project percent complete calculation."
    - name: "avg_reported_percent_complete"
      expr: AVG(CAST(reported_percent_complete AS DOUBLE))
      comment: "Average reported percent complete across activities. High-level progress indicator for executive reporting."
    - name: "avg_progress_delta"
      expr: AVG(CAST(progress_delta AS DOUBLE))
      comment: "Average progress delta (change in percent complete per period). Indicates acceleration or deceleration of progress."
    - name: "total_equipment_hours"
      expr: SUM(CAST(equipment_hours AS DOUBLE))
      comment: "Total equipment hours recorded against field progress entries. Supports resource productivity analysis."
    - name: "progress_record_count"
      expr: COUNT(1)
      comment: "Total number of field progress records. Baseline for progress reporting coverage and frequency."
    - name: "critical_path_activity_count"
      expr: COUNT(CASE WHEN is_critical_path = TRUE THEN 1 END)
      comment: "Number of critical path activities with progress records. Ensures critical path monitoring coverage."
    - name: "milestone_achieved_count"
      expr: COUNT(CASE WHEN is_milestone = TRUE AND reported_percent_complete >= 100 THEN 1 END)
      comment: "Number of milestones recorded as 100% complete. Tracks contractual milestone achievement for payment and governance."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`site_lift_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks crane lift plan safety compliance, capacity utilisation, and approval status across site lifting operations. Used by HSE managers and site engineers to ensure lifting operations are within safe working limits and properly approved."
  source: "`vibe_construction_v1`.`site`.`lift_plan`"
  dimensions:
    - name: "lift_date"
      expr: lift_date
      comment: "Date of the planned lift — primary time dimension for lifting activity trending."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the lift plan (e.g. Approved, Pending, Rejected) — filters safe-to-proceed lifts."
    - name: "lift_type"
      expr: lift_type
      comment: "Type of lift (e.g. Standard, Critical, Complex) — enables risk-tiered lift plan analysis."
    - name: "crane_type"
      expr: crane_type
      comment: "Type of crane used — enables crane-type utilisation and capacity analysis."
    - name: "hse_risk_level"
      expr: hse_risk_level
      comment: "HSE risk level assigned to the lift — enables risk-stratified safety performance reporting."
    - name: "outrigger_mat_required"
      expr: outrigger_mat_required
      comment: "Flag indicating outrigger mat requirement — tracks ground bearing risk mitigation compliance."
    - name: "overhead_obstruction_present"
      expr: overhead_obstruction_present
      comment: "Flag indicating overhead obstruction — tracks high-risk lift conditions for safety governance."
  measures:
    - name: "total_lift_count"
      expr: COUNT(1)
      comment: "Total number of lift plans. Baseline for lifting activity volume and safety governance coverage."
    - name: "approved_lift_count"
      expr: COUNT(CASE WHEN approval_status = 'Approved' THEN 1 END)
      comment: "Number of approved lift plans. Numerator for lift plan approval rate — unapproved lifts are a critical safety risk."
    - name: "avg_capacity_utilisation_pct"
      expr: AVG(CAST(capacity_utilisation_pct AS DOUBLE))
      comment: "Average crane capacity utilisation percentage. Lifts above 90% capacity require enhanced controls — key safety KPI."
    - name: "avg_load_weight_t"
      expr: AVG(CAST(load_weight_t AS DOUBLE))
      comment: "Average load weight in tonnes. Used to assess lift complexity distribution and crane fleet adequacy."
    - name: "total_load_weight_t"
      expr: SUM(CAST(load_weight_t AS DOUBLE))
      comment: "Total load weight lifted in tonnes. Measures overall lifting throughput for plant planning."
    - name: "avg_lift_radius_m"
      expr: AVG(CAST(lift_radius_m AS DOUBLE))
      comment: "Average lift radius in metres. Informs crane positioning and exclusion zone planning."
    - name: "avg_power_line_clearance_m"
      expr: AVG(CAST(power_line_clearance_m AS DOUBLE))
      comment: "Average power line clearance in metres. Clearance below minimum thresholds is a critical safety violation indicator."
    - name: "avg_wind_speed_limit_kmh"
      expr: AVG(CAST(wind_speed_limit_kmh AS DOUBLE))
      comment: "Average wind speed limit specified in lift plans. Used to assess weather suspension risk across the lift programme."
    - name: "high_risk_lift_count"
      expr: COUNT(CASE WHEN hse_risk_level IN ('High', 'Critical', 'Extreme') THEN 1 END)
      comment: "Number of high-risk lift plans. Tracks critical lift frequency for HSE governance and resource allocation."
    - name: "overhead_obstruction_lift_count"
      expr: COUNT(CASE WHEN overhead_obstruction_present = TRUE THEN 1 END)
      comment: "Number of lifts with overhead obstructions present. Tracks elevated-risk lift conditions requiring enhanced controls."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`site_material_delivery`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks material delivery performance, acceptance rates, rejection rates, and delivery value across site receipts. Used by procurement and site managers to monitor supplier delivery compliance and material quality at point of receipt."
  source: "`vibe_construction_v1`.`site`.`material_delivery`"
  dimensions:
    - name: "delivery_date"
      expr: delivery_date
      comment: "Date of material delivery — primary time dimension for delivery performance trending."
    - name: "delivery_status"
      expr: delivery_status
      comment: "Status of the delivery (e.g. Accepted, Rejected, Partial) — filters delivery outcome for performance analysis."
    - name: "material_category"
      expr: material_category
      comment: "Category of material delivered — enables category-level delivery performance and rejection analysis."
    - name: "receipt_condition"
      expr: receipt_condition
      comment: "Condition of goods on receipt (e.g. Good, Damaged, Incomplete) — tracks delivery quality at point of receipt."
    - name: "hazardous_material"
      expr: hazardous_material
      comment: "Flag indicating hazardous material — enables compliance tracking for MSDS and handling requirements."
    - name: "temperature_sensitive"
      expr: temperature_sensitive
      comment: "Flag indicating temperature-sensitive material — tracks cold chain compliance for specialist materials."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the delivery value — enables multi-currency delivery value reporting."
  measures:
    - name: "total_delivery_value"
      expr: SUM(CAST(delivery_value AS DOUBLE))
      comment: "Total value of materials delivered to site. Tracks material cost flow and supports progress payment calculations."
    - name: "total_quantity_delivered"
      expr: SUM(CAST(quantity_delivered AS DOUBLE))
      comment: "Total quantity of materials delivered. Core supply chain throughput KPI."
    - name: "total_quantity_accepted"
      expr: SUM(CAST(quantity_accepted AS DOUBLE))
      comment: "Total quantity accepted on delivery. Numerator for acceptance rate — rejected quantities drive rework and delay costs."
    - name: "total_quantity_rejected"
      expr: SUM(CAST(quantity_rejected AS DOUBLE))
      comment: "Total quantity rejected on delivery. High rejection volumes indicate supplier quality issues requiring intervention."
    - name: "total_quantity_ordered"
      expr: SUM(CAST(quantity_ordered AS DOUBLE))
      comment: "Total quantity ordered per delivery. Denominator for delivery fulfilment rate analysis."
    - name: "avg_unit_rate"
      expr: AVG(CAST(unit_rate AS DOUBLE))
      comment: "Average unit rate of delivered materials. Used for cost benchmarking and procurement performance analysis."
    - name: "delivery_count"
      expr: COUNT(1)
      comment: "Total number of delivery records. Baseline for delivery frequency and logistics planning."
    - name: "hazardous_delivery_count"
      expr: COUNT(CASE WHEN hazardous_material = TRUE THEN 1 END)
      comment: "Number of hazardous material deliveries. Tracks MSDS compliance obligations and site safety risk exposure."
    - name: "rejected_delivery_count"
      expr: COUNT(CASE WHEN quantity_rejected > 0 THEN 1 END)
      comment: "Number of deliveries with any rejected quantity. Tracks supplier non-conformance frequency for vendor management."
    - name: "msds_verified_delivery_count"
      expr: COUNT(CASE WHEN msds_verified = TRUE THEN 1 END)
      comment: "Number of deliveries with MSDS verified at receipt. Safety compliance KPI for hazardous material management."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`site_production_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Measures construction production rates, labour efficiency, and percent complete at the work-front level. Used by project controls and site managers to track daily production against budget and identify underperforming work fronts."
  source: "`vibe_construction_v1`.`site`.`production_entry`"
  dimensions:
    - name: "entry_date"
      expr: entry_date
      comment: "Date of the production entry — primary time dimension for production rate trending."
    - name: "entry_status"
      expr: entry_status
      comment: "Status of the production entry (e.g. Submitted, Approved, Rejected) — filters confirmed production records."
    - name: "production_type"
      expr: production_type
      comment: "Type of production activity — enables trade and discipline-level production analysis."
    - name: "shift_type"
      expr: shift_type
      comment: "Shift type (Day/Night) — enables shift-level production comparison."
    - name: "is_rework"
      expr: is_rework
      comment: "Flag indicating rework production — separates productive from rework quantities for quality cost analysis."
    - name: "is_baseline_revision"
      expr: is_baseline_revision
      comment: "Flag indicating a baseline revision entry — tracks scope changes affecting production targets."
    - name: "weather_condition"
      expr: weather_condition
      comment: "Weather condition during production — correlates weather with production rate outcomes."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for production quantities — enables consistent cross-activity production comparison."
  measures:
    - name: "total_installed_quantity"
      expr: SUM(CAST(installed_quantity AS DOUBLE))
      comment: "Total installed quantity across production entries. Core physical production KPI for progress tracking."
    - name: "total_budgeted_quantity"
      expr: SUM(CAST(budgeted_quantity AS DOUBLE))
      comment: "Total budgeted quantity. Denominator for production achievement rate against plan."
    - name: "total_cumulative_quantity"
      expr: SUM(CAST(cumulative_quantity AS DOUBLE))
      comment: "Total cumulative quantity installed to date. Tracks overall production progress against contract scope."
    - name: "total_labor_hours"
      expr: SUM(CAST(labor_hours AS DOUBLE))
      comment: "Total labour hours expended on production. Core workforce productivity input for unit rate analysis."
    - name: "total_equipment_hours"
      expr: SUM(CAST(equipment_hours AS DOUBLE))
      comment: "Total equipment hours expended on production. Supports plant productivity and cost analysis."
    - name: "avg_production_rate"
      expr: AVG(CAST(production_rate AS DOUBLE))
      comment: "Average production rate per entry. Key efficiency KPI for benchmarking against budgeted production rates."
    - name: "avg_budgeted_production_rate"
      expr: AVG(CAST(budgeted_production_rate AS DOUBLE))
      comment: "Average budgeted production rate. Denominator for production rate variance analysis."
    - name: "avg_percent_complete"
      expr: AVG(CAST(percent_complete AS DOUBLE))
      comment: "Average percent complete across production entries. High-level progress indicator for executive reporting."
    - name: "production_entry_count"
      expr: COUNT(1)
      comment: "Total number of production entries. Baseline for production reporting frequency and coverage."
    - name: "rework_entry_count"
      expr: COUNT(CASE WHEN is_rework = TRUE THEN 1 END)
      comment: "Number of rework production entries. Tracks rework frequency — high rework rates indicate quality and cost issues."
    - name: "avg_temperature_c"
      expr: AVG(CAST(temperature_c AS DOUBLE))
      comment: "Average temperature during production entries. Used to assess weather impact on production rates."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`site_shift_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Aggregates shift-level production, safety, and workforce metrics from shift reports. Used by site managers and project controls to monitor shift performance, safety incidents, and production achievement on a shift-by-shift basis."
  source: "`vibe_construction_v1`.`site`.`shift_report`"
  dimensions:
    - name: "shift_date"
      expr: shift_date
      comment: "Date of the shift — primary time dimension for shift performance trending."
    - name: "shift_type"
      expr: shift_type
      comment: "Shift type (Day/Night/Weekend) — enables shift-type performance comparison."
    - name: "report_status"
      expr: report_status
      comment: "Status of the shift report (e.g. Draft, Submitted, Approved) — filters confirmed vs pending records."
    - name: "weather_condition"
      expr: weather_condition
      comment: "Weather condition during the shift — correlates weather with shift productivity and safety outcomes."
    - name: "delay_cause"
      expr: delay_cause
      comment: "Cause of shift delay — enables root cause analysis of productivity losses by delay type."
    - name: "lti_flag"
      expr: lti_flag
      comment: "Flag indicating a Lost Time Injury occurred during the shift — critical safety lagging indicator."
    - name: "ncr_raised_flag"
      expr: ncr_raised_flag
      comment: "Flag indicating an NCR was raised during the shift — quality performance indicator."
    - name: "tbm_conducted_flag"
      expr: tbm_conducted_flag
      comment: "Flag indicating a Toolbox Meeting was conducted — leading safety compliance indicator."
  measures:
    - name: "total_production_quantity"
      expr: SUM(CAST(production_quantity AS DOUBLE))
      comment: "Total production quantity achieved across shifts. Core shift productivity KPI."
    - name: "total_planned_production_quantity"
      expr: SUM(CAST(planned_production_quantity AS DOUBLE))
      comment: "Total planned production quantity. Denominator for shift production achievement rate."
    - name: "total_labour_hours"
      expr: SUM(CAST(total_labour_hours AS DOUBLE))
      comment: "Total labour hours worked across shifts. Core workforce utilisation KPI for cost and productivity analysis."
    - name: "total_delay_duration_hrs"
      expr: SUM(CAST(delay_duration_hrs AS DOUBLE))
      comment: "Total delay hours recorded across shifts. Tracks delay exposure for EOT claims and schedule recovery planning."
    - name: "total_concrete_volume_m3"
      expr: SUM(CAST(concrete_volume_m3 AS DOUBLE))
      comment: "Total concrete volume poured per shift. Tracks structural production throughput at shift level."
    - name: "total_earthworks_volume_m3"
      expr: SUM(CAST(earthworks_volume_m3 AS DOUBLE))
      comment: "Total earthworks volume moved per shift. Tracks civil production throughput at shift level."
    - name: "avg_equipment_utilisation_pct"
      expr: AVG(CAST(equipment_utilisation_pct AS DOUBLE))
      comment: "Average equipment utilisation percentage per shift. Key plant efficiency KPI for fleet management."
    - name: "avg_temperature_c"
      expr: AVG(CAST(temperature_c AS DOUBLE))
      comment: "Average temperature during shifts. Used to assess heat stress risk and weather impact on productivity."
    - name: "shift_report_count"
      expr: COUNT(1)
      comment: "Total number of shift reports. Baseline for shift reporting coverage and compliance."
    - name: "lti_shift_count"
      expr: COUNT(CASE WHEN lti_flag = TRUE THEN 1 END)
      comment: "Number of shifts with a Lost Time Injury. Critical safety lagging indicator for executive HSE reporting."
    - name: "ncr_raised_shift_count"
      expr: COUNT(CASE WHEN ncr_raised_flag = TRUE THEN 1 END)
      comment: "Number of shifts with an NCR raised. Quality performance indicator for project governance."
    - name: "tbm_conducted_shift_count"
      expr: COUNT(CASE WHEN tbm_conducted_flag = TRUE THEN 1 END)
      comment: "Number of shifts where a Toolbox Meeting was conducted. Leading safety compliance indicator."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`site`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provides a portfolio-level view of construction sites, tracking mobilisation status, site area, safety performance, and operational readiness. Used by portfolio managers and executives to monitor site activation, capacity, and safety across the project portfolio."
  source: "`vibe_construction_v1`.`site`.`site`"
  dimensions:
    - name: "site_status"
      expr: site_status
      comment: "Operational status of the site (e.g. Active, Demobilised, Closed) — primary filter for active site portfolio."
    - name: "site_type"
      expr: site_type
      comment: "Type of construction site (e.g. Civil, Building, Infrastructure) — enables portfolio segmentation by project type."
    - name: "site_category"
      expr: site_category
      comment: "Site category classification — supports portfolio analysis by site complexity and risk profile."
    - name: "country_code"
      expr: country_code
      comment: "Country where the site is located — enables geographic portfolio analysis."
    - name: "region"
      expr: region
      comment: "Region of the site — enables regional portfolio performance comparison."
    - name: "is_mobilized"
      expr: is_mobilized
      comment: "Flag indicating whether the site is currently mobilised — tracks active site count for resource planning."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current inspection status of the site — tracks regulatory compliance and inspection currency."
  measures:
    - name: "total_site_count"
      expr: COUNT(1)
      comment: "Total number of sites in the portfolio. Baseline for portfolio scale and geographic footprint analysis."
    - name: "mobilised_site_count"
      expr: COUNT(CASE WHEN is_mobilized = TRUE THEN 1 END)
      comment: "Number of currently mobilised sites. Tracks active construction footprint for resource and overhead allocation."
    - name: "total_site_area_sqft"
      expr: SUM(CAST(area_sqft AS DOUBLE))
      comment: "Total site area in square feet across the portfolio. Indicates overall construction footprint scale."
    - name: "avg_site_area_sqft"
      expr: AVG(CAST(area_sqft AS DOUBLE))
      comment: "Average site area in square feet. Used for site complexity benchmarking and resource planning norms."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`site_mobilization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks site mobilisation performance, cost variance, schedule adherence, and readiness milestones. Used by project directors and site managers to ensure sites are mobilised on time and within budget, and that all permits and approvals are in place."
  source: "`vibe_construction_v1`.`site`.`site_mobilization`"
  dimensions:
    - name: "mobilization_status"
      expr: mobilization_status
      comment: "Current mobilisation status (e.g. Planned, In Progress, Complete) — primary filter for mobilisation pipeline."
    - name: "mobilization_type"
      expr: mobilization_type
      comment: "Type of mobilisation (e.g. Initial, Remobilisation, Demobilisation) — enables mobilisation type analysis."
    - name: "country_code"
      expr: country_code
      comment: "Country of the mobilisation — enables geographic mobilisation performance comparison."
    - name: "leed_certification_target"
      expr: leed_certification_target
      comment: "LEED certification target for the site — tracks sustainability commitment at mobilisation stage."
    - name: "hse_plan_approved"
      expr: hse_plan_approved
      comment: "Flag indicating HSE plan approval — tracks safety readiness compliance at mobilisation."
    - name: "environmental_permit_obtained"
      expr: environmental_permit_obtained
      comment: "Flag indicating environmental permit obtained — tracks regulatory compliance readiness."
    - name: "access_road_established"
      expr: access_road_established
      comment: "Flag indicating access road establishment — tracks physical site readiness milestone."
  measures:
    - name: "total_cost_actual"
      expr: SUM(CAST(cost_actual AS DOUBLE))
      comment: "Total actual mobilisation cost. Core cost performance KPI for mobilisation budget control."
    - name: "total_cost_budget"
      expr: SUM(CAST(cost_budget AS DOUBLE))
      comment: "Total budgeted mobilisation cost. Denominator for mobilisation cost variance analysis."
    - name: "total_site_area_sqm"
      expr: SUM(CAST(site_area_sqm AS DOUBLE))
      comment: "Total site area in square metres across mobilisations. Indicates scale of construction footprint being activated."
    - name: "mobilization_count"
      expr: COUNT(1)
      comment: "Total number of mobilisation records. Baseline for mobilisation pipeline volume."
    - name: "hse_plan_approved_count"
      expr: COUNT(CASE WHEN hse_plan_approved = TRUE THEN 1 END)
      comment: "Number of mobilisations with approved HSE plans. Safety readiness compliance KPI — unapproved plans block site activation."
    - name: "environmental_permit_obtained_count"
      expr: COUNT(CASE WHEN environmental_permit_obtained = TRUE THEN 1 END)
      comment: "Number of mobilisations with environmental permits obtained. Regulatory compliance readiness KPI."
    - name: "site_fencing_complete_count"
      expr: COUNT(CASE WHEN site_fencing_complete = TRUE THEN 1 END)
      comment: "Number of mobilisations with site fencing complete. Physical security readiness milestone tracker."
    - name: "site_office_established_count"
      expr: COUNT(CASE WHEN site_office_established = TRUE THEN 1 END)
      comment: "Number of mobilisations with site office established. Operational readiness milestone tracker."
    - name: "laydown_area_established_count"
      expr: COUNT(CASE WHEN laydown_area_established = TRUE THEN 1 END)
      comment: "Number of mobilisations with laydown area established. Material management readiness milestone tracker."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`site_permit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks site permit status, expiry risk, and compliance across all permit types. Used by HSE managers and project managers to ensure all site permits are current, properly approved, and renewed before expiry to avoid regulatory non-compliance."
  source: "`vibe_construction_v1`.`site`.`site_permit`"
  dimensions:
    - name: "site_permit_status"
      expr: site_permit_status
      comment: "Current status of the site permit (e.g. Active, Expired, Pending Renewal) — primary filter for permit compliance."
    - name: "permit_type"
      expr: permit_type
      comment: "Type of permit (e.g. Building, Environmental, Occupancy) — enables permit-type compliance analysis."
    - name: "permit_category"
      expr: permit_category
      comment: "Category of permit — supports risk-tiered permit management."
    - name: "is_environmental"
      expr: is_environmental
      comment: "Flag indicating environmental permit — enables focused environmental compliance reporting."
    - name: "is_safety_critical"
      expr: is_safety_critical
      comment: "Flag indicating safety-critical permit — prioritises monitoring of permits with highest safety consequence."
    - name: "issuing_authority"
      expr: issuing_authority
      comment: "Authority that issued the permit — enables authority-level compliance relationship management."
    - name: "extension_requested"
      expr: extension_requested
      comment: "Flag indicating an extension has been requested — tracks permits at risk of expiry."
  measures:
    - name: "total_permit_count"
      expr: COUNT(1)
      comment: "Total number of site permits. Baseline for permit portfolio size and compliance coverage."
    - name: "active_permit_count"
      expr: COUNT(CASE WHEN site_permit_status = 'Active' THEN 1 END)
      comment: "Number of currently active permits. Tracks operational permit coverage — gaps indicate compliance risk."
    - name: "expired_permit_count"
      expr: COUNT(CASE WHEN site_permit_status = 'Expired' THEN 1 END)
      comment: "Number of expired permits. Expired permits represent immediate regulatory non-compliance requiring urgent action."
    - name: "safety_critical_permit_count"
      expr: COUNT(CASE WHEN is_safety_critical = TRUE THEN 1 END)
      comment: "Number of safety-critical permits. Tracks the highest-risk permit obligations for priority management."
    - name: "environmental_permit_count"
      expr: COUNT(CASE WHEN is_environmental = TRUE THEN 1 END)
      comment: "Number of environmental permits. Tracks environmental compliance obligations across the site portfolio."
    - name: "extension_requested_count"
      expr: COUNT(CASE WHEN extension_requested = TRUE THEN 1 END)
      comment: "Number of permits with extension requests pending. Indicates permits at risk of lapsing — requires proactive management."
    - name: "expiration_notice_sent_count"
      expr: COUNT(CASE WHEN expiration_notice_sent = TRUE THEN 1 END)
      comment: "Number of permits where expiration notice has been sent. Tracks renewal process initiation for compliance governance."
    - name: "total_fee_amount"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total permit fee expenditure. Tracks regulatory compliance cost for project budget management."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`site_work_front`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Measures work front progress, production achievement, and resource deployment across active construction fronts. Used by site managers and project controls to monitor front-level performance, identify lagging fronts, and optimise crew and equipment allocation."
  source: "`vibe_construction_v1`.`site`.`work_front`"
  dimensions:
    - name: "front_status"
      expr: front_status
      comment: "Current status of the work front (e.g. Active, Complete, On Hold) — primary filter for active front monitoring."
    - name: "front_type"
      expr: front_type
      comment: "Type of work front (e.g. Civil, Structural, MEP) — enables trade-level front performance analysis."
    - name: "current_phase"
      expr: current_phase
      comment: "Current construction phase of the front — enables phase-level progress and resource analysis."
    - name: "is_critical_path"
      expr: is_critical_path
      comment: "Flag indicating critical path work front — enables focused monitoring of schedule-critical fronts."
    - name: "is_subcontracted"
      expr: is_subcontracted
      comment: "Flag indicating subcontracted work front — enables direct vs subcontract performance comparison."
    - name: "hse_risk_level"
      expr: hse_risk_level
      comment: "HSE risk level of the work front — enables risk-stratified safety resource allocation."
    - name: "environmental_sensitivity"
      expr: environmental_sensitivity
      comment: "Environmental sensitivity classification — tracks fronts with heightened environmental compliance requirements."
    - name: "zone_classification"
      expr: zone_classification
      comment: "Zone classification of the work front — enables spatial analysis of production and safety performance."
  measures:
    - name: "total_actual_production_qty"
      expr: SUM(CAST(actual_production_qty AS DOUBLE))
      comment: "Total actual production quantity across work fronts. Core physical progress KPI for front-level performance."
    - name: "total_planned_production_qty"
      expr: SUM(CAST(planned_production_qty AS DOUBLE))
      comment: "Total planned production quantity. Denominator for front production achievement rate."
    - name: "avg_percent_complete"
      expr: AVG(CAST(percent_complete AS DOUBLE))
      comment: "Average percent complete across work fronts. High-level progress indicator for executive portfolio reporting."
    - name: "total_area_sqm"
      expr: SUM(CAST(area_sqm AS DOUBLE))
      comment: "Total area in square metres covered by work fronts. Indicates physical scope of active construction."
    - name: "work_front_count"
      expr: COUNT(1)
      comment: "Total number of work fronts. Baseline for construction front portfolio size and resource planning."
    - name: "critical_path_front_count"
      expr: COUNT(CASE WHEN is_critical_path = TRUE THEN 1 END)
      comment: "Number of critical path work fronts. Tracks schedule-critical front count for priority resource allocation."
    - name: "subcontracted_front_count"
      expr: COUNT(CASE WHEN is_subcontracted = TRUE THEN 1 END)
      comment: "Number of subcontracted work fronts. Tracks subcontract scope exposure for commercial management."
    - name: "high_risk_front_count"
      expr: COUNT(CASE WHEN hse_risk_level IN ('High', 'Critical', 'Extreme') THEN 1 END)
      comment: "Number of high-risk work fronts. Tracks elevated HSE risk exposure for safety resource prioritisation."
    - name: "avg_elevation_m"
      expr: AVG(CAST(elevation_m AS DOUBLE))
      comment: "Average elevation of work fronts in metres. Informs working-at-height risk assessment and access planning."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`site_work_front_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks workforce assignment coverage and duration across work fronts. Used by site managers and workforce planners to ensure adequate skilled labour coverage on each front and identify assignment gaps."
  source: "`vibe_construction_v1`.`site`.`work_front_assignment`"
  dimensions:
    - name: "assignment_start_date"
      expr: assignment_start_date
      comment: "Start date of the work front assignment — primary time dimension for workforce deployment trending."
    - name: "assignment_end_date"
      expr: assignment_end_date
      comment: "End date of the work front assignment — used to identify active vs completed assignments."
    - name: "role"
      expr: role
      comment: "Role of the assigned craft worker on the work front — enables role-level workforce coverage analysis."
  measures:
    - name: "total_assignment_count"
      expr: COUNT(1)
      comment: "Total number of work front assignments. Baseline for workforce deployment volume and coverage analysis."
    - name: "unique_craft_worker_count"
      expr: COUNT(DISTINCT craft_worker_id)
      comment: "Number of distinct craft workers assigned to work fronts. Tracks workforce breadth and identifies key-person dependency risks."
    - name: "unique_work_front_count"
      expr: COUNT(DISTINCT work_front_id)
      comment: "Number of distinct work fronts with assignments. Tracks assignment coverage across the active front portfolio."
$$;