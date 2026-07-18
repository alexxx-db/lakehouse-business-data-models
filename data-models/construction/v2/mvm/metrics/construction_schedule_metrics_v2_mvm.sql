-- Metric views for domain: schedule | Business: Construction | Version: 2 | Generated on: 2026-07-10 14:32:32

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`schedule_activity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core schedule activity performance metrics tracking progress, duration variance, and critical path status for construction activities."
  source: "`vibe_construction_v1`.`schedule`.`activity`"
  dimensions:
    - name: "activity_status"
      expr: activity_status
      comment: "Current status of the activity (e.g., Not Started, In Progress, Complete)"
    - name: "activity_type"
      expr: activity_type
      comment: "Type classification of the activity"
    - name: "critical_path_flag"
      expr: critical_path_flag
      comment: "Boolean indicator whether activity is on the critical path"
    - name: "constraint_type"
      expr: constraint_type
      comment: "Type of schedule constraint applied to the activity"
    - name: "planned_start_month"
      expr: DATE_TRUNC('MONTH', planned_start_date)
      comment: "Month of planned activity start for time-series analysis"
    - name: "actual_start_month"
      expr: DATE_TRUNC('MONTH', actual_start_date)
      comment: "Month of actual activity start for time-series analysis"
    - name: "activity_code"
      expr: activity_code
      comment: "Activity code identifier"
  measures:
    - name: "total_activities"
      expr: COUNT(1)
      comment: "Total count of activities"
    - name: "avg_percent_complete"
      expr: AVG(CAST(percent_complete AS DOUBLE))
      comment: "Average percent complete across activities, key indicator of overall schedule progress"
    - name: "critical_path_activity_count"
      expr: SUM(CASE WHEN critical_path_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of activities on the critical path, essential for schedule risk management"
    - name: "avg_remaining_duration_days"
      expr: AVG(CAST(remaining_duration_days AS DOUBLE))
      comment: "Average remaining duration in days, forecasts time to completion"
    - name: "avg_total_float_days"
      expr: AVG(CAST(total_float_days AS DOUBLE))
      comment: "Average total float in days, measures schedule flexibility and risk buffer"
    - name: "behind_schedule_count"
      expr: SUM(CASE WHEN actual_start_date > planned_start_date THEN 1 ELSE 0 END)
      comment: "Count of activities that started late, key indicator of schedule adherence"
    - name: "completed_activity_count"
      expr: SUM(CASE WHEN percent_complete = 100 THEN 1 ELSE 0 END)
      comment: "Count of fully completed activities"
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`schedule_delay_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Delay event impact metrics tracking schedule disruptions, cost impacts, and extension of time claims for construction projects."
  source: "`vibe_construction_v1`.`schedule`.`delay_event`"
  dimensions:
    - name: "delay_category"
      expr: delay_category
      comment: "Category classification of the delay event"
    - name: "delay_event_status"
      expr: delay_event_status
      comment: "Current status of the delay event"
    - name: "event_type"
      expr: event_type
      comment: "Type of delay event"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of the delay event"
    - name: "impact_on_critical_path"
      expr: impact_on_critical_path
      comment: "Boolean indicator whether delay impacts the critical path"
    - name: "eot_claim_status"
      expr: eot_claim_status
      comment: "Status of extension of time claim associated with delay"
    - name: "event_start_month"
      expr: DATE_TRUNC('MONTH', CAST(event_start_timestamp AS DATE))
      comment: "Month when delay event started for time-series analysis"
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating assigned to the delay event"
  measures:
    - name: "total_delay_events"
      expr: COUNT(1)
      comment: "Total count of delay events"
    - name: "total_cost_impact"
      expr: SUM(CAST(impact_on_cost_amount AS DOUBLE))
      comment: "Total cost impact of all delay events, critical for project financial management"
    - name: "avg_cost_impact_per_event"
      expr: AVG(CAST(impact_on_cost_amount AS DOUBLE))
      comment: "Average cost impact per delay event, measures typical delay cost exposure"
    - name: "total_delay_duration_calendar_days"
      expr: SUM(CAST(delay_duration_calendar_days AS DOUBLE))
      comment: "Total calendar days of delay across all events"
    - name: "total_delay_duration_working_days"
      expr: SUM(CAST(delay_duration_working_days AS DOUBLE))
      comment: "Total working days of delay across all events, key metric for schedule performance"
    - name: "avg_delay_duration_working_days"
      expr: AVG(CAST(delay_duration_working_days AS DOUBLE))
      comment: "Average working days per delay event"
    - name: "critical_path_impact_count"
      expr: SUM(CASE WHEN impact_on_critical_path = TRUE THEN 1 ELSE 0 END)
      comment: "Count of delay events impacting critical path, essential for schedule risk assessment"
    - name: "critical_path_impact_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN impact_on_critical_path = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of delay events that impact critical path, key indicator of schedule vulnerability"
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`schedule_progress_update`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Earned value and schedule performance metrics tracking BCWS, BCWP, SPI, and schedule variance for project control."
  source: "`vibe_construction_v1`.`schedule`.`progress_update`"
  dimensions:
    - name: "progress_update_status"
      expr: progress_update_status
      comment: "Status of the progress update"
    - name: "reporting_status"
      expr: reporting_status
      comment: "Reporting status of the progress update"
    - name: "update_source"
      expr: update_source
      comment: "Source system or method of the progress update"
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Frequency of progress reporting"
    - name: "reporting_month"
      expr: DATE_TRUNC('MONTH', reporting_date)
      comment: "Month of progress reporting for time-series analysis"
    - name: "is_critical_path_changed"
      expr: is_critical_path_changed
      comment: "Boolean indicator whether critical path changed in this update"
    - name: "path_drift_indicator"
      expr: path_drift_indicator
      comment: "Indicator of critical path drift"
  measures:
    - name: "total_progress_updates"
      expr: COUNT(1)
      comment: "Total count of progress updates"
    - name: "total_bcws"
      expr: SUM(CAST(bcws AS DOUBLE))
      comment: "Total Budgeted Cost of Work Scheduled, baseline planned value for earned value analysis"
    - name: "total_bcwp"
      expr: SUM(CAST(bcwp AS DOUBLE))
      comment: "Total Budgeted Cost of Work Performed (earned value), measures actual value delivered"
    - name: "avg_spi"
      expr: AVG(CAST(spi AS DOUBLE))
      comment: "Average Schedule Performance Index, critical indicator of schedule efficiency (>1 ahead, <1 behind)"
    - name: "total_schedule_variance"
      expr: SUM(CAST(sv AS DOUBLE))
      comment: "Total Schedule Variance (BCWP - BCWS), measures cumulative schedule performance in cost terms"
    - name: "avg_schedule_variance_percent"
      expr: AVG(CAST(sv_percent AS DOUBLE))
      comment: "Average schedule variance as percentage, normalized schedule performance metric"
    - name: "avg_percent_complete_duration"
      expr: AVG(CAST(percent_complete_duration AS DOUBLE))
      comment: "Average percent complete by duration across updates"
    - name: "avg_percent_complete_units"
      expr: AVG(CAST(percent_complete_units AS DOUBLE))
      comment: "Average percent complete by units across updates"
    - name: "avg_total_float"
      expr: AVG(CAST(total_float AS DOUBLE))
      comment: "Average total float across activities, measures schedule flexibility"
    - name: "critical_path_change_count"
      expr: SUM(CASE WHEN is_critical_path_changed = TRUE THEN 1 ELSE 0 END)
      comment: "Count of updates where critical path changed, indicator of schedule instability"
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`schedule_lookahead_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lookahead planning and Last Planner System metrics tracking PPC, constraint removal, and short-term schedule reliability."
  source: "`vibe_construction_v1`.`schedule`.`lookahead_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Status of the lookahead plan"
    - name: "readiness_status"
      expr: readiness_status
      comment: "Overall readiness status of the plan"
    - name: "constraint_type"
      expr: constraint_type
      comment: "Type of constraint affecting the plan"
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned to the lookahead plan"
    - name: "is_lps_enabled"
      expr: is_lps_enabled
      comment: "Boolean indicator whether Last Planner System is enabled"
    - name: "critical_path_flag"
      expr: critical_path_flag
      comment: "Boolean indicator whether plan includes critical path activities"
    - name: "plan_month"
      expr: DATE_TRUNC('MONTH', plan_date)
      comment: "Month of lookahead plan for time-series analysis"
    - name: "material_ready_flag"
      expr: material_ready_flag
      comment: "Boolean indicator whether materials are ready"
    - name: "crew_ready_flag"
      expr: crew_ready_flag
      comment: "Boolean indicator whether crew is ready"
    - name: "equipment_ready_flag"
      expr: equipment_ready_flag
      comment: "Boolean indicator whether equipment is ready"
  measures:
    - name: "total_lookahead_plans"
      expr: COUNT(1)
      comment: "Total count of lookahead plans"
    - name: "avg_ppc_actual"
      expr: AVG(CAST(ppc_actual_percent AS DOUBLE))
      comment: "Average Percent Plan Complete (PPC) actual, critical Last Planner System reliability metric"
    - name: "avg_ppc_target"
      expr: AVG(CAST(ppc_target_percent AS DOUBLE))
      comment: "Average PPC target percentage"
    - name: "ppc_achievement_rate"
      expr: ROUND(100.0 * AVG(CAST(ppc_actual_percent AS DOUBLE)) / NULLIF(AVG(CAST(ppc_target_percent AS DOUBLE)), 0), 2)
      comment: "PPC achievement rate (actual vs target), measures planning reliability performance"
    - name: "avg_percent_plan_complete"
      expr: AVG(CAST(percent_plan_complete AS DOUBLE))
      comment: "Average percent complete of lookahead plans"
    - name: "total_planned_cost"
      expr: SUM(CAST(planned_cost AS DOUBLE))
      comment: "Total planned cost across lookahead plans"
    - name: "avg_planned_cost"
      expr: AVG(CAST(planned_cost AS DOUBLE))
      comment: "Average planned cost per lookahead plan"
    - name: "material_ready_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN material_ready_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of plans with materials ready, key constraint removal metric"
    - name: "crew_ready_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN crew_ready_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of plans with crew ready, key constraint removal metric"
    - name: "equipment_ready_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN equipment_ready_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of plans with equipment ready, key constraint removal metric"
    - name: "fully_ready_plan_count"
      expr: SUM(CASE WHEN material_ready_flag = TRUE AND crew_ready_flag = TRUE AND equipment_ready_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of plans with all constraints removed (material, crew, equipment ready), measures work readiness"
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`schedule_activity_resource_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Resource assignment cost and variance metrics tracking planned vs actual resource utilization and cost performance."
  source: "`vibe_construction_v1`.`schedule`.`activity_resource_assignment`"
  dimensions:
    - name: "assignment_status"
      expr: assignment_status
      comment: "Status of the resource assignment"
    - name: "resource_type"
      expr: resource_type
      comment: "Type of resource assigned (labor, equipment, material)"
    - name: "resource_role"
      expr: resource_role
      comment: "Role of the resource in the activity"
    - name: "labor_category"
      expr: labor_category
      comment: "Category of labor resource"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the resource assignment"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the resource assignment"
    - name: "safety_risk_level"
      expr: safety_risk_level
      comment: "Safety risk level associated with the resource assignment"
    - name: "is_critical_path"
      expr: is_critical_path
      comment: "Boolean indicator whether assignment is on critical path"
    - name: "assignment_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month of resource assignment start for time-series analysis"
  measures:
    - name: "total_resource_assignments"
      expr: COUNT(1)
      comment: "Total count of resource assignments"
    - name: "total_planned_cost"
      expr: SUM(CAST(planned_cost AS DOUBLE))
      comment: "Total planned cost of resource assignments"
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost of resource assignments, key metric for cost control"
    - name: "total_remaining_cost"
      expr: SUM(CAST(remaining_cost AS DOUBLE))
      comment: "Total remaining cost to complete resource assignments"
    - name: "total_cost_variance"
      expr: SUM((CAST(actual_cost AS DOUBLE)) - (CAST(planned_cost AS DOUBLE)))
      comment: "Total cost variance (actual minus planned), critical indicator of cost performance"
    - name: "cost_variance_rate"
      expr: ROUND(100.0 * (SUM(CAST(actual_cost AS DOUBLE)) - SUM(CAST(planned_cost AS DOUBLE))) / NULLIF(SUM(CAST(planned_cost AS DOUBLE)), 0), 2)
      comment: "Cost variance as percentage of planned, measures cost overrun or underrun rate"
    - name: "total_planned_quantity"
      expr: SUM(CAST(planned_quantity AS DOUBLE))
      comment: "Total planned quantity of resources"
    - name: "total_actual_quantity"
      expr: SUM(CAST(actual_quantity AS DOUBLE))
      comment: "Total actual quantity of resources used"
    - name: "total_remaining_quantity"
      expr: SUM(CAST(remaining_quantity AS DOUBLE))
      comment: "Total remaining quantity of resources needed"
    - name: "quantity_variance"
      expr: SUM((CAST(actual_quantity AS DOUBLE)) - (CAST(planned_quantity AS DOUBLE)))
      comment: "Total quantity variance (actual minus planned), measures resource efficiency"
    - name: "total_overtime_cost"
      expr: SUM(CAST(overtime_quantity AS DOUBLE) * CAST(overtime_rate AS DOUBLE))
      comment: "Total overtime cost, key indicator of schedule pressure and labor cost escalation"
    - name: "avg_cost_rate"
      expr: AVG(CAST(cost_rate AS DOUBLE))
      comment: "Average cost rate per resource unit"
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`schedule_milestone`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Milestone achievement and variance metrics tracking key project dates, liquidated damages exposure, and schedule performance."
  source: "`vibe_construction_v1`.`schedule`.`schedule_milestone`"
  dimensions:
    - name: "schedule_milestone_status"
      expr: schedule_milestone_status
      comment: "Current status of the schedule milestone"
    - name: "schedule_milestone_type"
      expr: schedule_milestone_type
      comment: "Type classification of the milestone"
    - name: "critical_path_flag"
      expr: critical_path_flag
      comment: "Boolean indicator whether milestone is on critical path"
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned to the milestone"
    - name: "ld_exposure_flag"
      expr: ld_exposure_flag
      comment: "Boolean indicator whether milestone has liquidated damages exposure"
    - name: "planned_month"
      expr: DATE_TRUNC('MONTH', planned_date)
      comment: "Month of planned milestone date for time-series analysis"
    - name: "actual_month"
      expr: DATE_TRUNC('MONTH', actual_date)
      comment: "Month of actual milestone date for time-series analysis"
    - name: "location"
      expr: location
      comment: "Location of the milestone"
  measures:
    - name: "total_milestones"
      expr: COUNT(1)
      comment: "Total count of schedule milestones"
    - name: "completed_milestone_count"
      expr: COUNT(DISTINCT CASE WHEN actual_date IS NOT NULL THEN schedule_milestone_id END)
      comment: "Count of completed milestones (with actual date)"
    - name: "milestone_completion_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN actual_date IS NOT NULL THEN schedule_milestone_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of milestones completed, key indicator of schedule progress"
    - name: "avg_variance_days"
      expr: AVG(CAST(variance_days AS DOUBLE))
      comment: "Average variance in days between planned and actual milestone dates, measures schedule adherence"
    - name: "late_milestone_count"
      expr: SUM(CASE WHEN CAST(variance_days AS DOUBLE) > 0 THEN 1 ELSE 0 END)
      comment: "Count of milestones completed late, critical indicator of schedule performance"
    - name: "on_time_milestone_count"
      expr: SUM(CASE WHEN CAST(variance_days AS DOUBLE) <= 0 AND actual_date IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of milestones completed on time or early"
    - name: "on_time_delivery_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN CAST(variance_days AS DOUBLE) <= 0 AND actual_date IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(DISTINCT CASE WHEN actual_date IS NOT NULL THEN schedule_milestone_id END), 0), 2)
      comment: "Percentage of completed milestones delivered on time, key performance indicator for schedule reliability"
    - name: "total_ld_exposure"
      expr: SUM(CAST(ld_rate_per_day AS DOUBLE) * GREATEST(CAST(variance_days AS DOUBLE), 0))
      comment: "Total liquidated damages exposure based on late milestones, critical financial risk metric"
    - name: "ld_exposed_milestone_count"
      expr: SUM(CASE WHEN ld_exposure_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of milestones with liquidated damages exposure"
    - name: "critical_path_milestone_count"
      expr: SUM(CASE WHEN critical_path_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of milestones on critical path, measures schedule risk concentration"
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`schedule_resource`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Resource utilization and cost metrics tracking availability, billing rates, and resource efficiency across the project."
  source: "`vibe_construction_v1`.`schedule`.`resource`"
  dimensions:
    - name: "resource_type"
      expr: resource_type
      comment: "Type of resource (labor, equipment, material)"
    - name: "resource_status"
      expr: resource_status
      comment: "Current status of the resource"
    - name: "resource_role"
      expr: resource_role
      comment: "Role classification of the resource"
    - name: "labor_category"
      expr: labor_category
      comment: "Category of labor resource"
    - name: "material_category"
      expr: material_category
      comment: "Category of material resource"
    - name: "is_external"
      expr: is_external
      comment: "Boolean indicator whether resource is external (subcontractor/vendor)"
    - name: "is_overtime_allowed"
      expr: is_overtime_allowed
      comment: "Boolean indicator whether overtime is allowed for this resource"
    - name: "safety_rating"
      expr: safety_rating
      comment: "Safety rating of the resource"
    - name: "site_location"
      expr: site_location
      comment: "Site location where resource is deployed"
    - name: "procurement_source"
      expr: procurement_source
      comment: "Source of resource procurement"
  measures:
    - name: "total_resources"
      expr: COUNT(1)
      comment: "Total count of resources"
    - name: "avg_availability_percentage"
      expr: AVG(CAST(availability_percentage AS DOUBLE))
      comment: "Average availability percentage across resources, measures resource capacity"
    - name: "avg_utilization_rate"
      expr: AVG(CAST(utilization_rate AS DOUBLE))
      comment: "Average utilization rate across resources, critical efficiency metric for resource management"
    - name: "avg_billing_rate"
      expr: AVG(CAST(billing_rate_per_hour AS DOUBLE))
      comment: "Average billing rate per hour across resources"
    - name: "avg_price_per_unit"
      expr: AVG(CAST(price_per_unit AS DOUBLE))
      comment: "Average price per unit for material resources"
    - name: "avg_overtime_factor"
      expr: AVG(CAST(overtime_factor AS DOUBLE))
      comment: "Average overtime multiplier factor, measures overtime cost premium"
    - name: "avg_environmental_impact_score"
      expr: AVG(CAST(environmental_impact_score AS DOUBLE))
      comment: "Average environmental impact score across resources"
    - name: "avg_depreciation_rate"
      expr: AVG(CAST(depreciation_rate AS DOUBLE))
      comment: "Average depreciation rate for equipment resources"
    - name: "external_resource_count"
      expr: SUM(CASE WHEN is_external = TRUE THEN 1 ELSE 0 END)
      comment: "Count of external resources (subcontractors/vendors)"
    - name: "external_resource_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_external = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of resources that are external, measures subcontracting dependency"
    - name: "overtime_allowed_count"
      expr: SUM(CASE WHEN is_overtime_allowed = TRUE THEN 1 ELSE 0 END)
      comment: "Count of resources where overtime is allowed"
$$;
