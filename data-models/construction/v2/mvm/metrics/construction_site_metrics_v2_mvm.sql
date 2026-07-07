-- Metric views for domain: site | Business: Construction | Version: 2 | Generated on: 2026-06-27 01:50:09

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`site_concrete_pour`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Governs concrete pour quality, volume throughput, and QC compliance KPIs. Used by site engineers, QA managers, and project directors to monitor structural integrity and pour performance."
  source: "`vibe_construction_v1`.`site`.`concrete_pour`"
  dimensions:
    - name: "pour_date"
      expr: pour_date
      comment: "Date the concrete pour was executed — primary time dimension for trend analysis."
    - name: "pour_type"
      expr: pour_type
      comment: "Type of pour (e.g. slab, column, footing) — used to segment volume and quality metrics by structural element category."
    - name: "pour_status"
      expr: pour_status
      comment: "Current status of the pour record (e.g. completed, on-hold, rejected) — used to filter active vs. closed pours."
    - name: "structure_element"
      expr: structure_element
      comment: "Structural element being poured (e.g. beam, wall, deck) — enables quality and volume analysis by element type."
    - name: "placement_method"
      expr: placement_method
      comment: "Method used to place concrete (e.g. pump, crane bucket, direct chute) — used to correlate placement method with quality outcomes."
    - name: "curing_method"
      expr: curing_method
      comment: "Curing technique applied after pour — relevant to strength compliance analysis."
    - name: "qc_hold_status"
      expr: qc_hold_status
      comment: "QC hold flag status — identifies pours under quality investigation or hold."
    - name: "weather_condition"
      expr: weather_condition
      comment: "Ambient weather condition at time of pour — used to correlate environmental factors with quality outcomes."
    - name: "slump_compliant"
      expr: slump_compliant
      comment: "Boolean indicating whether the slump test result was within specified limits — primary QC pass/fail dimension."
  measures:
    - name: "total_volume_poured_m3"
      expr: SUM(CAST(volume_poured_m3 AS DOUBLE))
      comment: "Total concrete volume poured in cubic metres. Core throughput KPI for production tracking and schedule performance."
    - name: "avg_volume_per_pour_m3"
      expr: AVG(CAST(volume_poured_m3 AS DOUBLE))
      comment: "Average volume per pour event. Indicates pour batch sizing efficiency and resource utilisation per pour."
    - name: "total_pour_count"
      expr: COUNT(1)
      comment: "Total number of concrete pour events. Baseline activity count for normalising quality and volume KPIs."
    - name: "slump_compliant_pour_count"
      expr: COUNT(CASE WHEN slump_compliant = TRUE THEN 1 END)
      comment: "Number of pours where slump test result was within specification. Numerator for slump compliance rate."
    - name: "slump_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN slump_compliant = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of pours passing slump specification. Critical QC KPI — low compliance signals mix design or delivery issues requiring immediate intervention."
    - name: "avg_slump_test_result_mm"
      expr: AVG(CAST(slump_test_result_mm AS DOUBLE))
      comment: "Average slump test result in millimetres across all pours. Tracks concrete workability trends and mix consistency."
    - name: "avg_specified_strength_mpa"
      expr: AVG(CAST(specified_strength_mpa AS DOUBLE))
      comment: "Average specified compressive strength in MPa. Used to profile the structural demand mix across pour types and elements."
    - name: "avg_concrete_temperature_c"
      expr: AVG(CAST(concrete_temperature_c AS DOUBLE))
      comment: "Average concrete temperature at time of pour. Elevated or low temperatures indicate risk to hydration and strength gain."
    - name: "avg_ambient_temperature_c"
      expr: AVG(CAST(ambient_temperature_c AS DOUBLE))
      comment: "Average ambient temperature during pours. Used to assess environmental risk to concrete quality."
    - name: "qc_hold_pour_count"
      expr: COUNT(CASE WHEN qc_hold_status IS NOT NULL AND qc_hold_status != 'NONE' THEN 1 END)
      comment: "Number of pours currently or previously placed on QC hold. Elevated count signals systemic quality issues requiring management escalation."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`site_crew_deployment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce productivity, utilisation, and compliance KPIs for crew deployments. Used by project managers, workforce planners, and HSE leads to optimise labour allocation and safety compliance."
  source: "`vibe_construction_v1`.`site`.`crew_deployment`"
  dimensions:
    - name: "deployment_date"
      expr: deployment_date
      comment: "Date of crew deployment — primary time dimension for workforce trend analysis."
    - name: "crew_type"
      expr: crew_type
      comment: "Type of crew deployed (e.g. civil, structural, electrical) — used to segment productivity and hours by trade."
    - name: "shift_type"
      expr: shift_type
      comment: "Shift classification (e.g. day, night, extended) — used to analyse productivity and overtime patterns by shift."
    - name: "deployment_status"
      expr: deployment_status
      comment: "Current status of the deployment record — used to filter active, completed, or cancelled deployments."
    - name: "is_subcontractor_crew"
      expr: is_subcontractor_crew
      comment: "Boolean indicating whether the crew is a subcontractor — enables direct vs. subcontract labour cost and productivity comparison."
    - name: "is_overtime"
      expr: is_overtime
      comment: "Boolean indicating whether overtime was worked — used to track overtime exposure and cost risk."
    - name: "is_weather_impacted"
      expr: is_weather_impacted
      comment: "Boolean indicating weather-related disruption — used to quantify weather impact on labour productivity."
    - name: "weather_condition"
      expr: weather_condition
      comment: "Weather condition during deployment — used to correlate environmental conditions with productivity outcomes."
    - name: "delay_reason_code"
      expr: delay_reason_code
      comment: "Coded reason for any deployment delay — used to identify systemic causes of lost productivity."
    - name: "wbs_code"
      expr: wbs_code
      comment: "Work Breakdown Structure code — enables productivity and hours analysis by project work package."
  measures:
    - name: "total_actual_hours"
      expr: SUM(CAST(actual_hours AS DOUBLE))
      comment: "Total actual labour hours worked across all deployments. Core workforce utilisation KPI for cost and schedule tracking."
    - name: "total_planned_hours"
      expr: SUM(CAST(planned_hours AS DOUBLE))
      comment: "Total planned labour hours across all deployments. Baseline for schedule adherence and resource planning."
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours worked. Elevated overtime signals schedule pressure, resource shortfalls, or poor planning — directly impacts labour cost."
    - name: "hours_variance"
      expr: SUM((CAST(actual_hours AS DOUBLE)) - (CAST(planned_hours AS DOUBLE)))
      comment: "Difference between actual and planned hours (actual minus planned). Positive variance indicates overrun; negative indicates underutilisation."
    - name: "overtime_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(overtime_hours AS DOUBLE)) / NULLIF(SUM(CAST(actual_hours AS DOUBLE)), 0), 2)
      comment: "Overtime hours as a percentage of total actual hours. High overtime rate is a leading indicator of cost overrun and workforce fatigue risk."
    - name: "total_actual_production_qty"
      expr: SUM(CAST(actual_production_qty AS DOUBLE))
      comment: "Total actual production quantity delivered by deployed crews. Measures output volume for productivity benchmarking."
    - name: "total_planned_production_qty"
      expr: SUM(CAST(planned_production_qty AS DOUBLE))
      comment: "Total planned production quantity for deployed crews. Baseline for production performance measurement."
    - name: "production_achievement_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_production_qty AS DOUBLE)) / NULLIF(SUM(CAST(planned_production_qty AS DOUBLE)), 0), 2)
      comment: "Actual production as a percentage of planned production. Core productivity KPI — below 80% triggers workforce or method review."
    - name: "avg_productivity_rate"
      expr: AVG(CAST(productivity_rate AS DOUBLE))
      comment: "Average productivity rate per deployment record. Used to benchmark crew performance across trades, shifts, and work fronts."
    - name: "ppe_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN ppe_compliance = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deployments with full PPE compliance recorded. Critical HSE KPI — non-compliance triggers immediate safety intervention."
    - name: "toolbox_meeting_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN hse_toolbox_meeting_held = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deployments where a toolbox meeting was conducted. Measures HSE pre-work briefing compliance — a leading safety indicator."
    - name: "weather_impacted_deployment_count"
      expr: COUNT(CASE WHEN is_weather_impacted = TRUE THEN 1 END)
      comment: "Number of deployments disrupted by weather. Used to quantify weather risk exposure and support extension-of-time claims."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`site_daily_log`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Daily site performance, safety event, and delay KPIs derived from site daily logs. Used by project managers, site superintendents, and executives to monitor day-to-day site health."
  source: "`vibe_construction_v1`.`site`.`daily_log`"
  dimensions:
    - name: "log_date"
      expr: log_date
      comment: "Date of the daily site log — primary time dimension for daily operational trend analysis."
    - name: "log_status"
      expr: log_status
      comment: "Approval status of the daily log (e.g. draft, approved, rejected) — used to filter verified vs. unverified records."
    - name: "shift_type"
      expr: shift_type
      comment: "Shift type recorded in the log (e.g. day, night) — used to segment site activity by shift."
    - name: "weather_condition"
      expr: weather_condition
      comment: "Weather condition recorded for the day — used to correlate weather with delays and productivity."
    - name: "overall_site_status"
      expr: overall_site_status
      comment: "Overall site operational status for the day — executive-level site health indicator."
    - name: "site_access_status"
      expr: site_access_status
      comment: "Site access condition for the day — used to identify access-related disruptions."
    - name: "wbs_code"
      expr: wbs_code
      comment: "Work Breakdown Structure code — enables daily performance analysis by project work package."
  measures:
    - name: "total_delay_duration_hrs"
      expr: SUM(CAST(total_delay_duration_hrs AS DOUBLE))
      comment: "Total delay hours recorded across all daily logs. Core schedule risk KPI — high cumulative delay drives extension-of-time claims and cost overruns."
    - name: "avg_daily_delay_hrs"
      expr: AVG(CAST(total_delay_duration_hrs AS DOUBLE))
      comment: "Average delay hours per site day. Tracks chronic delay patterns that may not be visible in cumulative totals."
    - name: "total_concrete_volume_m3"
      expr: SUM(CAST(concrete_volume_m3 AS DOUBLE))
      comment: "Total concrete volume recorded in daily logs. Tracks daily concrete production throughput for schedule and cost monitoring."
    - name: "total_earthworks_volume_m3"
      expr: SUM(CAST(earthworks_volume_m3 AS DOUBLE))
      comment: "Total earthworks volume recorded in daily logs. Key production KPI for civil and bulk earthworks projects."
    - name: "delay_day_count"
      expr: COUNT(CASE WHEN has_delay_event = TRUE THEN 1 END)
      comment: "Number of site days with at least one delay event recorded. Frequency metric for schedule risk assessment."
    - name: "delay_day_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN has_delay_event = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of site days with a delay event. High rate signals systemic schedule risk requiring management intervention."
    - name: "lti_day_count"
      expr: COUNT(CASE WHEN lti_occurred_flag = TRUE THEN 1 END)
      comment: "Number of days on which a Lost Time Injury occurred. Critical safety KPI — any LTI triggers executive review and regulatory reporting."
    - name: "ncr_raised_day_count"
      expr: COUNT(CASE WHEN ncr_raised_flag = TRUE THEN 1 END)
      comment: "Number of days on which a Non-Conformance Report was raised. Tracks quality event frequency — high NCR rate signals systemic quality issues."
    - name: "safety_observation_day_count"
      expr: COUNT(CASE WHEN has_safety_observation = TRUE THEN 1 END)
      comment: "Number of days with safety observations recorded. Leading safety indicator — high observation rate reflects proactive safety culture."
    - name: "tbm_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN tbm_conducted_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of site days where a Toolbox Meeting was conducted. HSE compliance KPI — below target triggers safety management review."
    - name: "avg_precipitation_mm"
      expr: AVG(CAST(precipitation_mm AS DOUBLE))
      comment: "Average daily precipitation in millimetres. Used to quantify weather exposure and support weather-related delay and EOT claims."
    - name: "cost_impact_day_count"
      expr: COUNT(CASE WHEN cost_impact_flag = TRUE THEN 1 END)
      comment: "Number of days with a cost impact event recorded. Tracks frequency of cost-affecting site events for commercial management."
    - name: "eot_impact_day_count"
      expr: COUNT(CASE WHEN eot_impact_flag = TRUE THEN 1 END)
      comment: "Number of days with an Extension of Time impact recorded. Tracks EOT exposure — critical for contract administration and claims management."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`site_equipment_deployment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Equipment utilisation, productivity, and cost KPIs for site equipment deployments. Used by plant managers, project controllers, and executives to optimise fleet performance and cost."
  source: "`vibe_construction_v1`.`site`.`equipment_deployment`"
  dimensions:
    - name: "deployment_date"
      expr: deployment_date
      comment: "Date of equipment deployment — primary time dimension for fleet utilisation trend analysis."
    - name: "equipment_type"
      expr: equipment_type
      comment: "Type of equipment deployed (e.g. excavator, crane, dozer) — used to segment utilisation and cost by equipment category."
    - name: "shift_type"
      expr: shift_type
      comment: "Shift classification for the deployment — used to analyse equipment utilisation patterns by shift."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Equipment ownership type (e.g. owned, rented, hired) — used to compare cost and utilisation across ownership models."
    - name: "deployment_status"
      expr: deployment_status
      comment: "Current status of the equipment deployment record — used to filter active vs. completed deployments."
    - name: "weather_condition"
      expr: weather_condition
      comment: "Weather condition during deployment — used to correlate environmental factors with equipment downtime."
    - name: "fuel_type"
      expr: fuel_type
      comment: "Fuel type used by the equipment — used for fuel cost and emissions analysis."
    - name: "breakdown_flag"
      expr: breakdown_flag
      comment: "Boolean indicating whether a breakdown occurred during the deployment — used to identify unreliable equipment."
  measures:
    - name: "total_operating_hours"
      expr: SUM(CAST(operating_hours AS DOUBLE))
      comment: "Total productive operating hours across all equipment deployments. Core fleet utilisation KPI."
    - name: "total_idle_hours"
      expr: SUM(CAST(idle_hours AS DOUBLE))
      comment: "Total idle hours across all equipment deployments. High idle hours indicate poor scheduling or site coordination — directly impacts cost."
    - name: "total_standby_hours"
      expr: SUM(CAST(standby_hours AS DOUBLE))
      comment: "Total standby hours across all equipment deployments. Standby costs are often charged at full rate — tracking is critical for cost control."
    - name: "total_breakdown_hours"
      expr: SUM(CAST(breakdown_hours AS DOUBLE))
      comment: "Total hours lost to equipment breakdowns. High breakdown hours signal maintenance failures and schedule risk."
    - name: "equipment_utilisation_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(operating_hours AS DOUBLE)) / NULLIF(SUM(CAST(operating_hours AS DOUBLE)) + SUM(CAST(idle_hours AS DOUBLE)) + SUM(CAST(standby_hours AS DOUBLE)) + SUM(CAST(breakdown_hours AS DOUBLE)), 0), 2)
      comment: "Operating hours as a percentage of total available hours (operating + idle + standby + breakdown). Core fleet efficiency KPI — below 70% triggers fleet management review."
    - name: "breakdown_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN breakdown_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deployments with a breakdown event. High rate indicates fleet reliability issues requiring maintenance strategy review."
    - name: "total_fuel_consumption_liters"
      expr: SUM(CAST(fuel_consumption_liters AS DOUBLE))
      comment: "Total fuel consumed across all equipment deployments. Key cost and environmental KPI for fleet management."
    - name: "avg_fuel_consumption_per_operating_hour"
      expr: ROUND(SUM(CAST(fuel_consumption_liters AS DOUBLE)) / NULLIF(SUM(CAST(operating_hours AS DOUBLE)), 0), 2)
      comment: "Average fuel consumption per operating hour. Efficiency ratio — spikes indicate equipment inefficiency or idling issues."
    - name: "total_production_quantity"
      expr: SUM(CAST(production_quantity AS DOUBLE))
      comment: "Total production output quantity delivered by deployed equipment. Measures equipment productivity against planned targets."
    - name: "production_achievement_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(production_quantity AS DOUBLE)) / NULLIF(SUM(CAST(planned_production_quantity AS DOUBLE)), 0), 2)
      comment: "Actual production quantity as a percentage of planned. Equipment productivity KPI — below target triggers plant management review."
    - name: "pre_start_check_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN pre_start_check_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deployments with a pre-start safety check completed. Critical HSE compliance KPI — non-compliance is a regulatory and safety risk."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`site_field_progress`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Field progress measurement, earned value, and schedule performance KPIs. Used by project managers, project controls, and executives to track physical completion and schedule adherence."
  source: "`vibe_construction_v1`.`site`.`field_progress`"
  dimensions:
    - name: "measurement_date"
      expr: measurement_date
      comment: "Date of the field progress measurement — primary time dimension for progress trend analysis."
    - name: "data_date"
      expr: data_date
      comment: "Data date for the progress snapshot — used to align progress records to reporting periods."
    - name: "activity_type"
      expr: activity_type
      comment: "Type of construction activity being measured — used to segment progress by work type."
    - name: "measurement_period_type"
      expr: measurement_period_type
      comment: "Period type for the measurement (e.g. daily, weekly, monthly) — used to align metrics to reporting cadence."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the progress measurement — used to filter certified vs. pending progress claims."
    - name: "is_critical_path"
      expr: is_critical_path
      comment: "Boolean indicating whether the activity is on the critical path — used to prioritise progress monitoring for schedule-critical work."
    - name: "is_milestone"
      expr: is_milestone
      comment: "Boolean indicating whether the progress record relates to a project milestone — used to track milestone achievement."
    - name: "measurement_method"
      expr: measurement_method
      comment: "Method used to measure progress (e.g. quantity survey, percent complete estimate) — used to assess measurement reliability."
    - name: "weather_condition"
      expr: weather_condition
      comment: "Weather condition at time of measurement — used to contextualise progress against environmental conditions."
    - name: "quantity_unit_of_measure"
      expr: quantity_unit_of_measure
      comment: "Unit of measure for installed quantities — used to ensure consistent aggregation across work types."
  measures:
    - name: "total_installed_quantity"
      expr: SUM(CAST(installed_quantity AS DOUBLE))
      comment: "Total cumulative installed quantity across all progress records. Core physical progress KPI for production tracking."
    - name: "total_period_installed_quantity"
      expr: SUM(CAST(period_installed_quantity AS DOUBLE))
      comment: "Total quantity installed in the current measurement period. Tracks production rate for schedule performance assessment."
    - name: "total_planned_quantity"
      expr: SUM(CAST(planned_quantity AS DOUBLE))
      comment: "Total planned quantity across all progress records. Baseline for production performance measurement."
    - name: "quantity_achievement_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(installed_quantity AS DOUBLE)) / NULLIF(SUM(CAST(planned_quantity AS DOUBLE)), 0), 2)
      comment: "Installed quantity as a percentage of planned quantity. Physical progress performance ratio — below 90% triggers schedule recovery planning."
    - name: "avg_reported_percent_complete"
      expr: AVG(CAST(reported_percent_complete AS DOUBLE))
      comment: "Average reported percent complete across all progress records. High-level completion indicator for executive dashboards."
    - name: "avg_progress_delta"
      expr: AVG(CAST(progress_delta AS DOUBLE))
      comment: "Average period-over-period progress change. Tracks acceleration or deceleration of construction progress — negative trend triggers intervention."
    - name: "total_bcwp"
      expr: SUM(CAST(bcwp AS DOUBLE))
      comment: "Total Budgeted Cost of Work Performed (Earned Value). Core earned value KPI — used with BCWS to calculate Schedule Performance Index."
    - name: "total_budget_at_completion"
      expr: SUM(CAST(budget_at_completion AS DOUBLE))
      comment: "Total Budget at Completion across all progress records. Baseline for earned value and cost performance analysis."
    - name: "total_equipment_hours"
      expr: SUM(CAST(equipment_hours AS DOUBLE))
      comment: "Total equipment hours recorded against field progress entries. Used to correlate equipment resource consumption with physical progress."
    - name: "critical_path_activity_count"
      expr: COUNT(CASE WHEN is_critical_path = TRUE THEN 1 END)
      comment: "Number of progress records on the critical path. Used to monitor the volume of schedule-critical work being tracked."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`site_material_delivery`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Material delivery performance, acceptance quality, and supply chain KPIs. Used by procurement managers, site engineers, and project controllers to manage material flow and supplier performance."
  source: "`vibe_construction_v1`.`site`.`material_delivery`"
  dimensions:
    - name: "delivery_date"
      expr: delivery_date
      comment: "Date of material delivery — primary time dimension for supply chain trend analysis."
    - name: "delivery_status"
      expr: delivery_status
      comment: "Status of the delivery (e.g. accepted, rejected, partial) — used to filter and segment delivery outcomes."
    - name: "material_category"
      expr: material_category
      comment: "Category of material delivered (e.g. concrete, steel, formwork) — used to segment delivery performance by material type."
    - name: "receipt_condition"
      expr: receipt_condition
      comment: "Condition of material on receipt (e.g. good, damaged, non-conforming) — used to assess supplier quality."
    - name: "hazardous_material"
      expr: hazardous_material
      comment: "Boolean indicating whether the delivered material is classified as hazardous — used for HSE compliance tracking."
    - name: "temperature_sensitive"
      expr: temperature_sensitive
      comment: "Boolean indicating whether the material requires temperature-controlled handling — used to flag cold-chain compliance risk."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the delivery value — used for multi-currency cost analysis."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for delivered quantities — used to ensure consistent aggregation across material types."
    - name: "wbs_code"
      expr: wbs_code
      comment: "Work Breakdown Structure code — enables delivery performance analysis by project work package."
  measures:
    - name: "total_quantity_delivered"
      expr: SUM(CAST(quantity_delivered AS DOUBLE))
      comment: "Total quantity of material delivered to site. Core supply chain throughput KPI."
    - name: "total_quantity_accepted"
      expr: SUM(CAST(quantity_accepted AS DOUBLE))
      comment: "Total quantity of material accepted after inspection. Used with quantity delivered to calculate acceptance rate."
    - name: "total_quantity_rejected"
      expr: SUM(CAST(quantity_rejected AS DOUBLE))
      comment: "Total quantity of material rejected on delivery. High rejection volume signals supplier quality issues and supply chain risk."
    - name: "material_acceptance_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(quantity_accepted AS DOUBLE)) / NULLIF(SUM(CAST(quantity_delivered AS DOUBLE)), 0), 2)
      comment: "Accepted quantity as a percentage of delivered quantity. Supplier quality KPI — low acceptance rate triggers supplier review and potential re-sourcing."
    - name: "total_delivery_value"
      expr: SUM(CAST(delivery_value AS DOUBLE))
      comment: "Total value of materials delivered to site. Key cost tracking KPI for procurement and project cost control."
    - name: "avg_unit_rate"
      expr: AVG(CAST(unit_rate AS DOUBLE))
      comment: "Average unit rate across all deliveries. Used to benchmark supplier pricing and identify rate anomalies."
    - name: "on_time_delivery_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN delivery_date <= expected_delivery_date THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deliveries arriving on or before the expected delivery date. Supply chain reliability KPI — low rate signals procurement or logistics issues impacting site schedule."
    - name: "total_delivery_count"
      expr: COUNT(1)
      comment: "Total number of material delivery events. Baseline activity count for normalising acceptance and on-time KPIs."
    - name: "msds_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN msds_verified = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deliveries where Material Safety Data Sheet was verified on receipt. HSE compliance KPI — non-compliance is a regulatory risk."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`site_mobilization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Project mobilisation readiness, cost performance, and schedule adherence KPIs. Used by project directors, commercial managers, and executives to assess project start-up performance."
  source: "`vibe_construction_v1`.`site`.`mobilization`"
  dimensions:
    - name: "mobilization_status"
      expr: mobilization_status
      comment: "Current status of the mobilisation (e.g. planned, in-progress, complete) — used to filter and segment mobilisation pipeline."
    - name: "mobilization_type"
      expr: mobilization_type
      comment: "Type of mobilisation (e.g. initial, remobilisation, demobilisation) — used to segment mobilisation activity by type."
    - name: "country_code"
      expr: country_code
      comment: "Country where the mobilisation is occurring — used for geographic segmentation of project start-up performance."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of mobilisation costs — used for multi-currency cost analysis."
    - name: "hse_plan_approved"
      expr: hse_plan_approved
      comment: "Boolean indicating whether the HSE plan was approved before mobilisation — critical safety readiness indicator."
    - name: "environmental_permit_obtained"
      expr: environmental_permit_obtained
      comment: "Boolean indicating whether the environmental permit was obtained — regulatory compliance readiness indicator."
    - name: "site_office_established"
      expr: site_office_established
      comment: "Boolean indicating whether the site office was established — infrastructure readiness indicator."
    - name: "leed_certification_target"
      expr: leed_certification_target
      comment: "Target LEED certification level — used to segment projects by sustainability ambition."
  measures:
    - name: "total_cost_actual"
      expr: SUM(CAST(cost_actual AS DOUBLE))
      comment: "Total actual mobilisation cost across all projects. Core cost tracking KPI for project start-up expenditure."
    - name: "total_cost_budget"
      expr: SUM(CAST(cost_budget AS DOUBLE))
      comment: "Total budgeted mobilisation cost across all projects. Baseline for mobilisation cost performance measurement."
    - name: "mobilization_cost_variance"
      expr: SUM((CAST(cost_actual AS DOUBLE)) - (CAST(cost_budget AS DOUBLE)))
      comment: "Difference between actual and budgeted mobilisation cost (actual minus budget). Positive variance indicates cost overrun — triggers commercial review."
    - name: "mobilization_cost_performance_index"
      expr: ROUND(SUM(CAST(cost_budget AS DOUBLE)) / NULLIF(SUM(CAST(cost_actual AS DOUBLE)), 0), 3)
      comment: "Budget divided by actual mobilisation cost. CPI > 1.0 indicates under-budget performance; < 1.0 indicates overrun. Executive cost efficiency KPI."
    - name: "total_site_area_sqm"
      expr: SUM(CAST(site_area_sqm AS DOUBLE))
      comment: "Total site area in square metres across all mobilisations. Used to normalise mobilisation cost and resource metrics by site scale."
    - name: "hse_plan_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN hse_plan_approved = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of mobilisations with an approved HSE plan. Critical safety governance KPI — unapproved HSE plans represent regulatory and liability risk."
    - name: "environmental_permit_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN environmental_permit_obtained = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of mobilisations with environmental permit obtained. Regulatory compliance KPI — non-compliance can result in project shutdown and penalties."
    - name: "site_readiness_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN site_office_established = TRUE AND site_fencing_complete = TRUE AND laydown_area_established = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of mobilisations with all three core site infrastructure elements established (office, fencing, laydown). Composite site readiness KPI."
    - name: "total_mobilization_count"
      expr: COUNT(1)
      comment: "Total number of mobilisation records. Baseline count for normalising readiness and cost KPIs."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`site_permit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Site permit compliance, expiry risk, and regulatory status KPIs. Used by project managers, HSE leads, and compliance officers to manage permit obligations and avoid regulatory breaches."
  source: "`vibe_construction_v1`.`site`.`permit`"
  dimensions:
    - name: "permit_type"
      expr: permit_type
      comment: "Type of permit (e.g. building, environmental, access) — used to segment compliance metrics by permit category."
    - name: "site_permit_status"
      expr: site_permit_status
      comment: "Current status of the permit (e.g. active, expired, pending renewal) — primary compliance status dimension."
    - name: "issuing_authority"
      expr: issuing_authority
      comment: "Authority that issued the permit — used to segment compliance by regulatory body."
    - name: "is_environmental"
      expr: is_environmental
      comment: "Boolean indicating whether the permit is an environmental permit — used to isolate environmental compliance metrics."
    - name: "is_safety_critical"
      expr: is_safety_critical
      comment: "Boolean indicating whether the permit is safety-critical — used to prioritise monitoring of high-risk permits."
    - name: "extension_requested"
      expr: extension_requested
      comment: "Boolean indicating whether a permit extension has been requested — used to track permits at risk of expiry."
    - name: "expiration_notice_sent"
      expr: expiration_notice_sent
      comment: "Boolean indicating whether an expiration notice has been sent — used to track permit renewal process compliance."
    - name: "application_date"
      expr: application_date
      comment: "Date the permit application was submitted — used to analyse permit lead times and approval cycle performance."
  measures:
    - name: "total_permit_count"
      expr: COUNT(1)
      comment: "Total number of site permits. Baseline count for normalising compliance and expiry KPIs."
    - name: "active_permit_count"
      expr: COUNT(CASE WHEN site_permit_status = 'ACTIVE' THEN 1 END)
      comment: "Number of currently active permits. Tracks the live regulatory authorisation portfolio for the site."
    - name: "expired_permit_count"
      expr: COUNT(CASE WHEN site_permit_status = 'EXPIRED' THEN 1 END)
      comment: "Number of expired permits. Expired permits represent immediate regulatory non-compliance — requires urgent remediation."
    - name: "safety_critical_permit_count"
      expr: COUNT(CASE WHEN is_safety_critical = TRUE THEN 1 END)
      comment: "Number of safety-critical permits. Used to size the high-risk permit portfolio requiring priority monitoring."
    - name: "total_fee_amount"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total permit fees across all permits. Tracks regulatory cost exposure for project cost control."
    - name: "avg_approval_lead_time_days"
      expr: AVG(DATEDIFF(approval_date, application_date))
      comment: "Average number of days between permit application and approval. Long lead times signal regulatory bottlenecks that can delay project start."
    - name: "extension_request_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN extension_requested = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of permits with an extension request. High rate indicates poor permit lifecycle management and expiry risk."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`site_production_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Production output, efficiency, and quality KPIs from site production entries. Used by project managers, production engineers, and executives to track construction output rates and rework exposure."
  source: "`vibe_construction_v1`.`site`.`production_entry`"
  dimensions:
    - name: "entry_date"
      expr: entry_date
      comment: "Date of the production entry — primary time dimension for production trend analysis."
    - name: "production_type"
      expr: production_type
      comment: "Type of production activity (e.g. excavation, concrete, steel erection) — used to segment output by work type."
    - name: "entry_status"
      expr: entry_status
      comment: "Approval status of the production entry — used to filter verified vs. pending production records."
    - name: "shift_type"
      expr: shift_type
      comment: "Shift type for the production entry — used to analyse output patterns by shift."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for production quantities — used to ensure consistent aggregation within work types."
    - name: "is_rework"
      expr: is_rework
      comment: "Boolean indicating whether the entry records rework activity — used to isolate rework cost and volume."
    - name: "weather_condition"
      expr: weather_condition
      comment: "Weather condition during production — used to correlate environmental factors with output rates."
    - name: "wbs_code"
      expr: wbs_code
      comment: "Work Breakdown Structure code — enables production analysis by project work package."
    - name: "work_front_location"
      expr: work_front_location
      comment: "Physical location of the work front — used to segment production performance by site area."
  measures:
    - name: "total_installed_quantity"
      expr: SUM(CAST(installed_quantity AS DOUBLE))
      comment: "Total quantity installed across all production entries. Core physical output KPI for production tracking."
    - name: "total_budgeted_quantity"
      expr: SUM(CAST(budgeted_quantity AS DOUBLE))
      comment: "Total budgeted quantity across all production entries. Baseline for production performance measurement."
    - name: "production_quantity_achievement_pct"
      expr: ROUND(100.0 * SUM(CAST(installed_quantity AS DOUBLE)) / NULLIF(SUM(CAST(budgeted_quantity AS DOUBLE)), 0), 2)
      comment: "Installed quantity as a percentage of budgeted quantity. Production efficiency KPI — below 85% triggers production recovery planning."
    - name: "total_labor_hours"
      expr: SUM(CAST(labor_hours AS DOUBLE))
      comment: "Total labour hours consumed across all production entries. Used to calculate unit labour productivity rates."
    - name: "total_equipment_hours"
      expr: SUM(CAST(equipment_hours AS DOUBLE))
      comment: "Total equipment hours consumed across all production entries. Used to calculate unit equipment productivity rates."
    - name: "avg_production_rate"
      expr: AVG(CAST(production_rate AS DOUBLE))
      comment: "Average production rate per entry. Tracks construction output velocity — declining rate is an early warning of schedule risk."
    - name: "avg_budgeted_production_rate"
      expr: AVG(CAST(budgeted_production_rate AS DOUBLE))
      comment: "Average budgeted production rate per entry. Baseline for production rate performance comparison."
    - name: "production_rate_efficiency_pct"
      expr: ROUND(100.0 * AVG(CAST(production_rate AS DOUBLE)) / NULLIF(AVG(CAST(budgeted_production_rate AS DOUBLE)), 0), 2)
      comment: "Actual production rate as a percentage of budgeted rate. Efficiency ratio — below 80% triggers method statement and resource review."
    - name: "avg_percent_complete"
      expr: AVG(CAST(percent_complete AS DOUBLE))
      comment: "Average percent complete across all production entries. High-level completion indicator for executive progress dashboards."
    - name: "rework_entry_count"
      expr: COUNT(CASE WHEN is_rework = TRUE THEN 1 END)
      comment: "Number of production entries flagged as rework. Rework directly inflates cost and erodes schedule — a critical quality KPI."
    - name: "rework_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_rework = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of production entries that are rework. High rework rate signals systemic quality failures requiring root cause analysis."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`site_work_front`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Work front progress, productivity, and risk KPIs. Used by project managers, site superintendents, and executives to monitor active construction fronts and identify schedule and safety risks."
  source: "`vibe_construction_v1`.`site`.`work_front`"
  dimensions:
    - name: "front_status"
      expr: front_status
      comment: "Current status of the work front (e.g. active, suspended, complete) — primary status dimension for work front portfolio management."
    - name: "front_type"
      expr: front_type
      comment: "Type of work front (e.g. civil, structural, MEP) — used to segment performance metrics by construction discipline."
    - name: "current_phase"
      expr: current_phase
      comment: "Current construction phase of the work front — used to track phase-level progress across the project."
    - name: "hse_risk_level"
      expr: hse_risk_level
      comment: "HSE risk classification of the work front (e.g. low, medium, high, critical) — used to prioritise safety monitoring."
    - name: "is_critical_path"
      expr: is_critical_path
      comment: "Boolean indicating whether the work front is on the critical path — used to prioritise schedule monitoring."
    - name: "is_subcontracted"
      expr: is_subcontracted
      comment: "Boolean indicating whether the work front is subcontracted — used to compare direct vs. subcontract performance."
    - name: "zone_classification"
      expr: zone_classification
      comment: "Zone classification of the work front — used to segment performance by site zone or area."
    - name: "environmental_sensitivity"
      expr: environmental_sensitivity
      comment: "Environmental sensitivity classification of the work front — used to flag fronts requiring enhanced environmental controls."
    - name: "shift_pattern"
      expr: shift_pattern
      comment: "Shift pattern operating on the work front — used to analyse productivity by shift arrangement."
  measures:
    - name: "total_actual_production_qty"
      expr: SUM(CAST(actual_production_qty AS DOUBLE))
      comment: "Total actual production quantity across all work fronts. Core output KPI for site-wide production tracking."
    - name: "total_planned_production_qty"
      expr: SUM(CAST(planned_production_qty AS DOUBLE))
      comment: "Total planned production quantity across all work fronts. Baseline for production performance measurement."
    - name: "production_achievement_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_production_qty AS DOUBLE)) / NULLIF(SUM(CAST(planned_production_qty AS DOUBLE)), 0), 2)
      comment: "Actual production as a percentage of planned across all work fronts. Portfolio-level productivity KPI — below 85% triggers site-wide recovery planning."
    - name: "avg_percent_complete"
      expr: AVG(CAST(percent_complete AS DOUBLE))
      comment: "Average percent complete across all work fronts. Executive-level portfolio completion indicator."
    - name: "total_area_sqm"
      expr: SUM(CAST(area_sqm AS DOUBLE))
      comment: "Total area in square metres across all work fronts. Used to normalise production and resource metrics by work front scale."
    - name: "critical_path_front_count"
      expr: COUNT(CASE WHEN is_critical_path = TRUE THEN 1 END)
      comment: "Number of work fronts on the critical path. Used to size the schedule-critical work portfolio requiring priority resource allocation."
    - name: "high_risk_front_count"
      expr: COUNT(CASE WHEN hse_risk_level IN ('HIGH', 'CRITICAL') THEN 1 END)
      comment: "Number of work fronts classified as high or critical HSE risk. Used to size the high-risk work portfolio requiring enhanced safety oversight."
    - name: "subcontracted_front_count"
      expr: COUNT(CASE WHEN is_subcontracted = TRUE THEN 1 END)
      comment: "Number of subcontracted work fronts. Used to track subcontract exposure and manage subcontractor performance."
    - name: "total_work_front_count"
      expr: COUNT(1)
      comment: "Total number of work fronts. Baseline count for normalising performance and risk KPIs across the site portfolio."
$$;