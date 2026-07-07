-- Metric views for domain: housekeeping | Business: Travel Hospitality | Version: 2 | Generated on: 2026-06-28 00:14:33

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`housekeeping_attendant`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Attendant workforce metrics measuring productivity, performance ratings, and labor efficiency to support staffing decisions, training investments, and workforce planning."
  source: "`vibe_travel_hospitality_v1`.`housekeeping`.`attendant`"
  dimensions:
    - name: "role_type"
      expr: role_type
      comment: "Role type of the attendant (room attendant, supervisor, inspector) for workforce segmentation."
    - name: "employment_status"
      expr: employment_status
      comment: "Employment status (active, terminated, on-leave) for active workforce analysis."
    - name: "shift_assignment"
      expr: shift_assignment
      comment: "Shift assignment (AM, PM, overnight) for shift-level productivity analysis."
    - name: "union_member_flag"
      expr: union_member_flag
      comment: "Flag indicating union membership for labor relations and compliance reporting."
    - name: "ada_accommodation_flag"
      expr: ada_accommodation_flag
      comment: "Flag indicating ADA accommodation requirements for workforce planning."
    - name: "performance_rating"
      expr: performance_rating
      comment: "Performance rating category for talent management and training prioritization."
    - name: "section_assignment"
      expr: section_assignment
      comment: "Section assignment for geographic workload distribution analysis."
  measures:
    - name: "total_active_attendants"
      expr: COUNT(CASE WHEN active_flag = TRUE THEN 1 END)
      comment: "Total number of active attendants. Core workforce capacity metric for scheduling and staffing decisions."
    - name: "avg_credits_per_shift"
      expr: AVG(CAST(average_credits_per_shift AS DOUBLE))
      comment: "Average credits earned per shift across attendants. Primary productivity benchmark for housekeeping workforce management."
    - name: "productivity_vs_target_pct"
      expr: ROUND(100.0 * AVG(CAST(average_credits_per_shift AS DOUBLE)) / NULLIF(AVG(CAST(target_credits_per_shift AS DOUBLE)), 0), 2)
      comment: "Average actual credits as a percentage of target credits. Measures workforce productivity against labor standards for operational steering."
    - name: "total_target_credits_per_shift"
      expr: SUM(CAST(target_credits_per_shift AS DOUBLE))
      comment: "Total target credits per shift across all attendants. Used for capacity planning and labor budget forecasting."
    - name: "union_member_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN union_member_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of attendants who are union members. Informs labor relations strategy and contract compliance monitoring."
    - name: "ada_accommodation_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN ada_accommodation_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of attendants with ADA accommodations. Supports compliance reporting and inclusive workforce planning."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`housekeeping_cleaning_task`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Task-level housekeeping execution KPIs: SLA compliance, quality checkpoint rates, supply consumption, and exception rates. Enables granular operational performance management and labor efficiency analysis."
  source: "`vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task`"
  dimensions:
    - name: "task_type"
      expr: task_type
      comment: "Type of cleaning task (departure, stayover, turndown, deep clean) for workload mix analysis."
    - name: "task_status"
      expr: task_status
      comment: "Current status of the task; used to monitor completion pipeline and identify bottlenecks."
    - name: "task_priority"
      expr: task_priority
      comment: "Priority level of the task; used to assess urgency distribution and scheduling effectiveness."
    - name: "service_type"
      expr: service_type
      comment: "Service type associated with the task; used for service mix and cost analysis."
    - name: "sla_compliance_flag"
      expr: sla_compliance_flag
      comment: "Indicates whether the task met its SLA target; primary operational compliance dimension."
    - name: "exception_flag"
      expr: exception_flag
      comment: "Indicates an exception occurred during the task; used to identify operational disruptions."
    - name: "is_quality_checkpoint"
      expr: is_quality_checkpoint
      comment: "Indicates the task is a quality checkpoint; used to measure quality gate coverage."
    - name: "property_id"
      expr: property_id
      comment: "Property identifier for cross-property task performance benchmarking."
  measures:
    - name: "total_tasks"
      expr: COUNT(1)
      comment: "Total cleaning tasks executed; baseline volume for labor planning and scheduling."
    - name: "sla_compliant_task_count"
      expr: COUNT(CASE WHEN sla_compliance_flag = TRUE THEN 1 END)
      comment: "Number of tasks completed within SLA; numerator for SLA compliance rate, a key operational KPI."
    - name: "exception_task_count"
      expr: COUNT(CASE WHEN exception_flag = TRUE THEN 1 END)
      comment: "Number of tasks with exceptions; high exception rates signal scheduling, staffing, or process issues."
    - name: "total_credit_weight"
      expr: SUM(CAST(credit_weight AS DOUBLE))
      comment: "Total credit weight of all tasks; measures aggregate labor value delivered, used in credit-based payroll models."
    - name: "avg_credit_weight_per_task"
      expr: AVG(CAST(credit_weight AS DOUBLE))
      comment: "Average credit weight per task; used to assess task complexity mix and labor cost per task."
    - name: "total_supply_quantity_used"
      expr: SUM(CAST(supply_quantity_used AS DOUBLE))
      comment: "Total supply quantity consumed across tasks; drives procurement demand forecasting and cost control."
    - name: "maintenance_request_generated_count"
      expr: COUNT(CASE WHEN maintenance_request_generated = TRUE THEN 1 END)
      comment: "Number of tasks that generated a maintenance request; links cleaning operations to asset maintenance demand pipeline."
    - name: "quality_checkpoint_task_count"
      expr: COUNT(CASE WHEN is_quality_checkpoint = TRUE THEN 1 END)
      comment: "Number of quality checkpoint tasks; used to measure quality gate coverage across the floor."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`housekeeping_deep_clean_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Deep clean program KPIs: completion rates, labor cost vs. estimate, PIP compliance, and maintenance issue discovery rates. Enables capital planning and brand standard compliance management."
  source: "`vibe_travel_hospitality_v1`.`housekeeping`.`deep_clean_plan`"
  dimensions:
    - name: "deep_clean_plan_status"
      expr: deep_clean_plan_status
      comment: "Status of the deep clean plan (scheduled, in-progress, completed, cancelled) for pipeline monitoring."
    - name: "area_type"
      expr: area_type
      comment: "Type of area being deep cleaned (guestroom, public area, spa, F&B) for program scope analysis."
    - name: "priority"
      expr: priority
      comment: "Priority level of the deep clean plan; used to assess urgency distribution and resource allocation."
    - name: "pip_compliance_flag"
      expr: pip_compliance_flag
      comment: "Indicates PIP compliance requirement; used for brand standard and franchise audit tracking."
    - name: "ffe_inspection_performed"
      expr: ffe_inspection_performed
      comment: "Indicates FF&E inspection was performed during deep clean; links to capital asset condition assessment."
    - name: "maintenance_issues_identified"
      expr: maintenance_issues_identified
      comment: "Indicates maintenance issues were found; used to measure deep clean program value in asset management."
    - name: "planned_date"
      expr: planned_date
      comment: "Planned date of the deep clean; used to trend program execution against schedule."
    - name: "property_id"
      expr: property_id
      comment: "Property identifier for cross-property deep clean program benchmarking."
  measures:
    - name: "total_deep_clean_plans"
      expr: COUNT(1)
      comment: "Total deep clean plans; baseline volume for program coverage and scheduling analysis."
    - name: "total_actual_labor_hours"
      expr: SUM(CAST(actual_labor_hours AS DOUBLE))
      comment: "Total actual labor hours consumed by deep clean plans; primary labor cost driver for deep clean program budgeting."
    - name: "total_estimated_labor_hours"
      expr: SUM(CAST(estimated_labor_hours AS DOUBLE))
      comment: "Total estimated labor hours; used with actual hours to compute labor estimation accuracy."
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost AS DOUBLE))
      comment: "Total labor cost of deep clean plans; key input to property maintenance budget and CapEx planning."
    - name: "total_supply_cost"
      expr: SUM(CAST(supply_cost AS DOUBLE))
      comment: "Total supply cost of deep clean plans; used for procurement demand planning and cost control."
    - name: "total_deep_clean_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total all-in cost of deep clean plans; primary financial KPI for deep clean program ROI analysis."
    - name: "avg_completion_percentage"
      expr: AVG(CAST(completion_percentage AS DOUBLE))
      comment: "Average completion percentage across deep clean plans; used to monitor program execution progress."
    - name: "maintenance_issues_discovered_count"
      expr: COUNT(CASE WHEN maintenance_issues_identified = TRUE THEN 1 END)
      comment: "Number of deep clean plans that discovered maintenance issues; measures the asset inspection value of the deep clean program."
    - name: "pip_compliant_plan_count"
      expr: COUNT(CASE WHEN pip_compliance_flag = TRUE THEN 1 END)
      comment: "Number of PIP-compliant deep clean plans; used in franchise and brand standard compliance reporting."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`housekeeping_hk_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational KPIs for housekeeping room assignments: throughput, room credit yield, VIP and DND service rates, and inspection outcomes. Drives daily floor management and labor allocation decisions."
  source: "`vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment`"
  dimensions:
    - name: "assignment_date"
      expr: assignment_date
      comment: "Calendar date of the housekeeping assignment; used to trend daily workload and staffing."
    - name: "assignment_type"
      expr: assignment_type
      comment: "Type of assignment (e.g., stayover, departure, turndown) for workload mix analysis."
    - name: "completion_status"
      expr: completion_status
      comment: "Completion status of the assignment (completed, skipped, reassigned) for SLA tracking."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the assignment; used to assess urgency distribution across the floor."
    - name: "vip_indicator"
      expr: vip_indicator
      comment: "Flag indicating VIP guest assignment; used to segment service quality metrics."
    - name: "dnd_flag"
      expr: dnd_flag
      comment: "Do-not-disturb flag; used to measure service deferral rates."
    - name: "linen_change_flag"
      expr: linen_change_flag
      comment: "Indicates whether a linen change was performed; used for linen consumption analysis."
    - name: "property_id"
      expr: property_id
      comment: "Property identifier for cross-property benchmarking."
  measures:
    - name: "total_assignments"
      expr: COUNT(1)
      comment: "Total number of housekeeping assignments; baseline volume measure for staffing and scheduling decisions."
    - name: "completed_assignments"
      expr: COUNT(CASE WHEN completion_status = 'completed' THEN 1 END)
      comment: "Count of assignments completed successfully; numerator for completion rate KPI."
    - name: "total_room_credits"
      expr: SUM(CAST(room_credits AS DOUBLE))
      comment: "Total room credits earned across all assignments; primary labor productivity measure used in credit-based compensation models."
    - name: "avg_room_credits_per_assignment"
      expr: AVG(CAST(room_credits AS DOUBLE))
      comment: "Average room credits per assignment; measures attendant productivity and workload balance."
    - name: "vip_assignment_count"
      expr: COUNT(CASE WHEN vip_indicator = TRUE THEN 1 END)
      comment: "Number of VIP assignments; used to ensure premium service capacity is adequately staffed."
    - name: "dnd_deferral_count"
      expr: COUNT(CASE WHEN dnd_flag = TRUE THEN 1 END)
      comment: "Number of assignments deferred due to DND; informs re-scheduling and guest satisfaction risk."
    - name: "inspection_required_count"
      expr: COUNT(CASE WHEN inspection_required_flag = TRUE THEN 1 END)
      comment: "Number of assignments requiring quality inspection; drives inspector workload planning."
    - name: "reassignment_rate_numerator"
      expr: SUM(CAST(reassignment_count AS DOUBLE))
      comment: "Sum of reassignment counts across assignments; used with total_assignments to compute reassignment rate, a proxy for scheduling efficiency."
    - name: "maintenance_request_flag_count"
      expr: COUNT(CASE WHEN maintenance_request_flag = TRUE THEN 1 END)
      comment: "Number of assignments that generated a maintenance request; links housekeeping operations to asset maintenance demand."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`housekeeping_hk_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Scheduling efficiency and labor budget KPIs: headcount planning, overtime risk, labor budget utilization, and CPOR targets. Enables proactive labor cost management and occupancy-driven staffing decisions."
  source: "`vibe_travel_hospitality_v1`.`housekeeping`.`hk_schedule`"
  dimensions:
    - name: "schedule_date"
      expr: schedule_date
      comment: "Date of the housekeeping schedule; used to trend labor planning and occupancy alignment."
    - name: "schedule_status"
      expr: schedule_status
      comment: "Status of the schedule (draft, published, closed); used to monitor scheduling pipeline."
    - name: "shift_type"
      expr: shift_type
      comment: "Type of shift (AM, PM, overnight); used for shift mix and labor cost analysis."
    - name: "occupancy_forecast_tier"
      expr: occupancy_forecast_tier
      comment: "Occupancy forecast tier driving the schedule; used to assess staffing responsiveness to demand."
    - name: "turndown_service_flag"
      expr: turndown_service_flag
      comment: "Indicates turndown service is scheduled; used to measure turndown program coverage."
    - name: "pip_compliance_flag"
      expr: pip_compliance_flag
      comment: "Indicates PIP compliance requirement on the schedule; used for brand standard audit tracking."
    - name: "property_id"
      expr: property_id
      comment: "Property identifier for cross-property scheduling benchmarking."
  measures:
    - name: "total_schedules"
      expr: COUNT(1)
      comment: "Total schedules created; baseline volume for scheduling program coverage."
    - name: "total_labor_budget_amount"
      expr: SUM(CAST(labor_budget_amount AS DOUBLE))
      comment: "Total labor budget allocated across schedules; primary labor cost planning KPI for finance and operations."
    - name: "avg_labor_budget_per_schedule"
      expr: AVG(CAST(labor_budget_amount AS DOUBLE))
      comment: "Average labor budget per schedule day; used to benchmark daily labor spend against occupancy."
    - name: "total_cpor_target"
      expr: SUM(CAST(cpor_target AS DOUBLE))
      comment: "Sum of CPOR (cost per occupied room) targets; used to assess aggregate labor efficiency targets."
    - name: "avg_cpor_target"
      expr: AVG(CAST(cpor_target AS DOUBLE))
      comment: "Average CPOR target per schedule; key hospitality labor efficiency benchmark used in executive reviews."
    - name: "total_section_credit_value"
      expr: SUM(CAST(section_credit_value AS DOUBLE))
      comment: "Total credit value of all scheduled sections; measures planned labor output in credit-based models."
    - name: "avg_overtime_threshold_hours"
      expr: AVG(CAST(overtime_threshold_hours AS DOUBLE))
      comment: "Average overtime threshold hours per schedule; used to monitor overtime risk and labor compliance."
    - name: "turndown_schedule_count"
      expr: COUNT(CASE WHEN turndown_service_flag = TRUE THEN 1 END)
      comment: "Number of schedules with turndown service; used to measure turndown program deployment rate."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`housekeeping_training_completion`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Training and certification KPIs for housekeeping staff: completion rates, certification coverage, scores, and compliance training hours. Enables workforce readiness and regulatory compliance management."
  source: "`vibe_travel_hospitality_v1`.`housekeeping`.`housekeeping_training_completion`"
  dimensions:
    - name: "completion_status"
      expr: completion_status
      comment: "Training completion status (completed, in-progress, failed, expired) for workforce readiness monitoring."
    - name: "bloodborne_pathogen_certified_flag"
      expr: bloodborne_pathogen_certified_flag
      comment: "Indicates bloodborne pathogen certification; mandatory compliance certification tracked by HR and compliance."
    - name: "chemical_handling_certified_flag"
      expr: chemical_handling_certified_flag
      comment: "Indicates chemical handling certification; safety compliance requirement for housekeeping staff."
    - name: "vip_certified_flag"
      expr: vip_certified_flag
      comment: "Indicates VIP service certification; used to ensure adequate VIP-qualified staff coverage."
    - name: "suite_qualified_flag"
      expr: suite_qualified_flag
      comment: "Indicates suite cleaning qualification; used to ensure premium room coverage by qualified staff."
    - name: "certificate_issued_flag"
      expr: certificate_issued_flag
      comment: "Indicates a certificate was issued; used to track formal certification completion."
    - name: "completion_date"
      expr: completion_date
      comment: "Date training was completed; used to trend certification pipeline and identify expiry risks."
  measures:
    - name: "total_training_completions"
      expr: COUNT(1)
      comment: "Total training completion records; baseline volume for workforce training program coverage."
    - name: "completed_training_count"
      expr: COUNT(CASE WHEN completion_status = 'completed' THEN 1 END)
      comment: "Number of successfully completed training records; numerator for completion rate KPI used in HR and compliance reporting."
    - name: "avg_training_score"
      expr: AVG(CAST(score AS DOUBLE))
      comment: "Average training assessment score; measures workforce knowledge quality and training program effectiveness."
    - name: "total_training_hours"
      expr: SUM(CAST(training_hours_completed AS DOUBLE))
      comment: "Total training hours completed; used to measure workforce development investment and regulatory compliance hours."
    - name: "avg_training_hours_per_completion"
      expr: AVG(CAST(training_hours_completed AS DOUBLE))
      comment: "Average training hours per completion record; used to benchmark training program intensity."
    - name: "bloodborne_pathogen_certified_count"
      expr: COUNT(CASE WHEN bloodborne_pathogen_certified_flag = TRUE THEN 1 END)
      comment: "Number of staff with bloodborne pathogen certification; mandatory compliance coverage metric."
    - name: "chemical_handling_certified_count"
      expr: COUNT(CASE WHEN chemical_handling_certified_flag = TRUE THEN 1 END)
      comment: "Number of staff with chemical handling certification; safety compliance coverage metric."
    - name: "vip_certified_count"
      expr: COUNT(CASE WHEN vip_certified_flag = TRUE THEN 1 END)
      comment: "Number of VIP-certified staff; used to ensure premium service capacity meets demand."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`housekeeping_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality assurance KPIs derived from room and area inspections: cleanliness scores, deficiency rates, reclean rates, and VIP pass rates. Core metrics for brand standard compliance and guest satisfaction management."
  source: "`vibe_travel_hospitality_v1`.`housekeeping`.`inspection`"
  dimensions:
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection (arrival, departure, spot-check, deep-clean) for quality program segmentation."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current status of the inspection (passed, failed, pending) for pipeline monitoring."
    - name: "scheduled_date"
      expr: scheduled_date
      comment: "Date the inspection was scheduled; used for trend analysis of quality over time."
    - name: "vip_flag"
      expr: vip_flag
      comment: "Indicates VIP room inspection; used to segment quality scores for premium guests."
    - name: "reclean_required_flag"
      expr: reclean_required_flag
      comment: "Flag indicating a reclean was required; key quality failure indicator."
    - name: "maintenance_issue_flag"
      expr: maintenance_issue_flag
      comment: "Flag indicating a maintenance issue was found during inspection; links quality to asset condition."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the inspection; used to assess urgency distribution."
    - name: "property_id"
      expr: property_id
      comment: "Property identifier for cross-property quality benchmarking."
  measures:
    - name: "total_inspections"
      expr: COUNT(1)
      comment: "Total inspections conducted; baseline volume for quality program coverage analysis."
    - name: "avg_cleanliness_score"
      expr: AVG(CAST(cleanliness_score AS DOUBLE))
      comment: "Average cleanliness score across all inspections; primary brand standard KPI tracked by GMs and QA teams."
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average overall quality score per inspection; composite quality KPI used in executive dashboards."
    - name: "reclean_count"
      expr: COUNT(CASE WHEN reclean_required_flag = TRUE THEN 1 END)
      comment: "Number of inspections resulting in a reclean; numerator for reclean rate, a direct cost and quality metric."
    - name: "maintenance_issue_count"
      expr: COUNT(CASE WHEN maintenance_issue_flag = TRUE THEN 1 END)
      comment: "Number of inspections identifying maintenance issues; drives preventive maintenance prioritization."
    - name: "failed_inspection_count"
      expr: COUNT(CASE WHEN inspection_status = 'failed' THEN 1 END)
      comment: "Count of failed inspections; numerator for failure rate KPI used in quality steering meetings."
    - name: "vip_inspection_count"
      expr: COUNT(CASE WHEN vip_flag = TRUE THEN 1 END)
      comment: "Number of VIP room inspections; used to ensure premium quality standards are consistently applied."
    - name: "room_release_count"
      expr: COUNT(CASE WHEN room_release_flag = TRUE THEN 1 END)
      comment: "Number of rooms released for sale after inspection; directly impacts revenue availability."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`housekeeping_inspection_deficiency`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Deficiency management KPIs: resolution times, escalation rates, cost of remediation, and recurring deficiency patterns. Enables root-cause analysis and preventive quality investment decisions."
  source: "`vibe_travel_hospitality_v1`.`housekeeping`.`inspection_deficiency`"
  dimensions:
    - name: "deficiency_category"
      expr: deficiency_category
      comment: "Category of deficiency (linen, bathroom, amenity, maintenance) for root-cause segmentation."
    - name: "deficiency_subcategory"
      expr: deficiency_subcategory
      comment: "Subcategory for granular deficiency analysis and targeted corrective action."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity of the deficiency; used to prioritize remediation resources."
    - name: "resolution_status"
      expr: resolution_status
      comment: "Current resolution status; used to track open vs. closed deficiency pipeline."
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Indicates whether the deficiency was escalated; used to measure escalation rate."
    - name: "guest_impacting_flag"
      expr: guest_impacting_flag
      comment: "Indicates guest-impacting deficiencies; directly linked to satisfaction and compensation risk."
    - name: "blocks_room_sale_flag"
      expr: blocks_room_sale_flag
      comment: "Indicates deficiency blocks room from sale; directly impacts revenue availability."
    - name: "property_id"
      expr: property_id
      comment: "Property identifier for cross-property deficiency benchmarking."
  measures:
    - name: "total_deficiencies"
      expr: COUNT(1)
      comment: "Total deficiencies identified; baseline volume for quality program health assessment."
    - name: "escalated_deficiency_count"
      expr: COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END)
      comment: "Number of escalated deficiencies; high escalation rates signal systemic quality failures requiring leadership intervention."
    - name: "guest_impacting_deficiency_count"
      expr: COUNT(CASE WHEN guest_impacting_flag = TRUE THEN 1 END)
      comment: "Number of deficiencies directly impacting guests; linked to satisfaction scores and compensation costs."
    - name: "room_blocking_deficiency_count"
      expr: COUNT(CASE WHEN blocks_room_sale_flag = TRUE THEN 1 END)
      comment: "Number of deficiencies blocking room sales; quantifies revenue at risk from quality failures."
    - name: "recurring_deficiency_count"
      expr: COUNT(CASE WHEN recurring_deficiency_flag = TRUE THEN 1 END)
      comment: "Count of recurring deficiencies; high recurrence indicates systemic issues requiring process or training investment."
    - name: "total_resolution_cost"
      expr: SUM(CAST(resolution_cost_amount AS DOUBLE))
      comment: "Total cost of resolving deficiencies; key input to quality-cost trade-off analysis and budget planning."
    - name: "avg_resolution_cost"
      expr: AVG(CAST(resolution_cost_amount AS DOUBLE))
      comment: "Average cost per deficiency resolution; used to benchmark remediation efficiency across properties."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`housekeeping_laundry_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Laundry operations KPIs: cost per item, turnaround time, SLA compliance, and total spend. Enables vendor performance management and linen cost optimization decisions."
  source: "`vibe_travel_hospitality_v1`.`housekeeping`.`laundry_order`"
  dimensions:
    - name: "order_type"
      expr: order_type
      comment: "Type of laundry order (guest, house, uniform) for cost allocation and volume analysis."
    - name: "order_status"
      expr: order_status
      comment: "Current status of the laundry order; used to monitor pipeline and SLA compliance."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the order; used to assess rush order rates and associated cost premiums."
    - name: "sla_compliance_flag"
      expr: sla_compliance_flag
      comment: "Indicates whether the order met its SLA; primary vendor performance KPI."
    - name: "pricing_method"
      expr: pricing_method
      comment: "Pricing method (per item, per pound) for cost structure analysis."
    - name: "property_id"
      expr: property_id
      comment: "Property identifier for cross-property laundry cost benchmarking."
  measures:
    - name: "total_laundry_orders"
      expr: COUNT(1)
      comment: "Total laundry orders placed; baseline volume for vendor capacity and cost planning."
    - name: "total_laundry_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total laundry spend; primary cost KPI for linen operations budget management."
    - name: "avg_cost_per_item"
      expr: AVG(CAST(cost_per_item AS DOUBLE))
      comment: "Average cost per laundry item; used to benchmark vendor pricing and identify cost reduction opportunities."
    - name: "avg_cost_per_pound"
      expr: AVG(CAST(cost_per_pound AS DOUBLE))
      comment: "Average cost per pound of laundry; alternative pricing benchmark for vendor negotiations."
    - name: "avg_turnaround_time_hours"
      expr: AVG(CAST(turnaround_time_hours AS DOUBLE))
      comment: "Average turnaround time in hours; key vendor SLA metric directly impacting linen availability and guest service."
    - name: "total_weight_lbs"
      expr: SUM(CAST(total_weight_lbs AS DOUBLE))
      comment: "Total weight of laundry processed; used for vendor capacity planning and per-pound cost analysis."
    - name: "sla_compliant_order_count"
      expr: COUNT(CASE WHEN sla_compliance_flag = TRUE THEN 1 END)
      comment: "Number of orders meeting SLA; numerator for vendor SLA compliance rate used in contract reviews."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`housekeeping_lost_and_found`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lost and found management KPIs: item volumes, high-value item rates, claim rates, estimated value at risk, and shipping costs. Enables guest service recovery and compliance risk management."
  source: "`vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found`"
  dimensions:
    - name: "lost_and_found_status"
      expr: lost_and_found_status
      comment: "Current status of the lost and found item (found, claimed, disposed, shipped) for pipeline monitoring."
    - name: "item_category"
      expr: item_category
      comment: "Category of lost item (electronics, jewelry, clothing, documents) for risk and value analysis."
    - name: "disposition_type"
      expr: disposition_type
      comment: "How the item was disposed (returned, donated, discarded, shipped) for compliance and guest service analysis."
    - name: "is_high_value_item"
      expr: is_high_value_item
      comment: "Indicates a high-value item; used to segment risk exposure and special handling requirements."
    - name: "requires_special_handling"
      expr: requires_special_handling
      comment: "Indicates special handling required; used to assess operational complexity and compliance risk."
    - name: "discovery_date"
      expr: discovery_date
      comment: "Date item was discovered; used to trend lost and found volumes and identify seasonal patterns."
    - name: "property_id"
      expr: property_id
      comment: "Property identifier for cross-property lost and found benchmarking."
  measures:
    - name: "total_lost_and_found_items"
      expr: COUNT(1)
      comment: "Total lost and found items logged; baseline volume for guest service and compliance program management."
    - name: "high_value_item_count"
      expr: COUNT(CASE WHEN is_high_value_item = TRUE THEN 1 END)
      comment: "Number of high-value items in lost and found; measures financial risk exposure and special handling workload."
    - name: "total_estimated_value"
      expr: SUM(CAST(estimated_value_amount AS DOUBLE))
      comment: "Total estimated value of lost and found items; quantifies financial liability and insurance exposure."
    - name: "total_shipping_cost"
      expr: SUM(CAST(shipping_cost_amount AS DOUBLE))
      comment: "Total shipping cost for returned items; used to manage guest service recovery costs."
    - name: "claimed_item_count"
      expr: COUNT(CASE WHEN claim_status = 'claimed' THEN 1 END)
      comment: "Number of items successfully claimed by guests; numerator for claim rate KPI measuring guest service effectiveness."
    - name: "unclaimed_high_value_count"
      expr: COUNT(CASE WHEN is_high_value_item = TRUE AND lost_and_found_status != 'claimed' THEN 1 END)
      comment: "Number of unclaimed high-value items; measures ongoing financial liability and compliance risk from unclaimed valuables."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`housekeeping_maintenance_handoff`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Maintenance handoff metrics measuring cross-department coordination efficiency, cost accuracy, safety hazard resolution, and guest impact to optimize the housekeeping-to-engineering workflow."
  source: "`vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_handoff`"
  dimensions:
    - name: "handoff_status"
      expr: handoff_status
      comment: "Status of the maintenance handoff (pending, acknowledged, in-progress, completed) for workflow tracking."
    - name: "defect_type"
      expr: defect_type
      comment: "Type of defect reported (plumbing, electrical, FF&E, HVAC) for root-cause and investment analysis."
    - name: "urgency_level"
      expr: urgency_level
      comment: "Urgency level of the handoff for SLA and escalation analysis."
    - name: "safety_hazard"
      expr: safety_hazard
      comment: "Flag indicating a safety hazard requiring immediate action and compliance reporting."
    - name: "guest_impacted"
      expr: guest_impacted
      comment: "Flag indicating the defect impacted a guest, linking maintenance to satisfaction outcomes."
    - name: "ada_compliance_issue"
      expr: ada_compliance_issue
      comment: "Flag indicating an ADA compliance issue, requiring regulatory attention."
    - name: "requires_vendor"
      expr: requires_vendor
      comment: "Flag indicating external vendor is required, for outsourced maintenance cost tracking."
    - name: "ffe_category"
      expr: ffe_category
      comment: "FF&E category of the defect for capital asset management and PIP planning."
  measures:
    - name: "total_handoffs"
      expr: COUNT(1)
      comment: "Total number of maintenance handoffs from housekeeping. Baseline cross-department coordination metric."
    - name: "safety_hazard_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN safety_hazard = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of handoffs flagged as safety hazards. Critical compliance KPI requiring immediate management escalation."
    - name: "guest_impact_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN guest_impacted = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of handoffs where a guest was impacted. Links property condition to guest satisfaction and service recovery costs."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost of maintenance handoffs. Core financial metric for maintenance budget and vendor management."
    - name: "cost_accuracy_pct"
      expr: ROUND(100.0 * SUM(CAST(estimated_cost AS DOUBLE)) / NULLIF(SUM(CAST(actual_cost AS DOUBLE)), 0), 2)
      comment: "Ratio of estimated to actual maintenance cost. Measures cost estimation accuracy for budget planning and vendor contract management."
    - name: "vendor_required_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN requires_vendor = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of handoffs requiring an external vendor. Informs outsourced maintenance spend and vendor contract scope."
    - name: "ada_compliance_issue_count"
      expr: COUNT(CASE WHEN ada_compliance_issue = TRUE THEN 1 END)
      comment: "Number of handoffs with ADA compliance issues. Regulatory compliance KPI requiring tracking and remediation reporting."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`housekeeping_maintenance_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Maintenance demand and resolution KPIs: request volumes, cost of repairs, SLA compliance, safety hazard rates, and room out-of-order impact. Critical for asset management and revenue protection decisions."
  source: "`vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_request`"
  dimensions:
    - name: "maintenance_request_category"
      expr: maintenance_request_category
      comment: "Category of maintenance request (plumbing, electrical, HVAC, FF&E) for asset investment prioritization."
    - name: "request_type"
      expr: request_type
      comment: "Type of request (preventive, corrective, emergency) for maintenance program mix analysis."
    - name: "maintenance_request_status"
      expr: maintenance_request_status
      comment: "Current status of the request; used to monitor open pipeline and SLA compliance."
    - name: "priority"
      expr: priority
      comment: "Priority level of the maintenance request; used to assess urgency distribution and resource allocation."
    - name: "safety_hazard_flag"
      expr: safety_hazard_flag
      comment: "Indicates a safety hazard; safety-related requests require immediate escalation and tracking."
    - name: "room_out_of_order_flag"
      expr: room_out_of_order_flag
      comment: "Indicates room is out of order; directly impacts sellable inventory and revenue."
    - name: "guest_impact_flag"
      expr: guest_impact_flag
      comment: "Indicates guest-impacting maintenance issue; linked to satisfaction and compensation risk."
    - name: "property_id"
      expr: property_id
      comment: "Property identifier for cross-property maintenance benchmarking."
  measures:
    - name: "total_maintenance_requests"
      expr: COUNT(1)
      comment: "Total maintenance requests; baseline volume for asset condition and maintenance demand planning."
    - name: "safety_hazard_request_count"
      expr: COUNT(CASE WHEN safety_hazard_flag = TRUE THEN 1 END)
      comment: "Number of safety hazard requests; zero-tolerance KPI tracked by GMs and compliance teams."
    - name: "room_out_of_order_count"
      expr: COUNT(CASE WHEN room_out_of_order_flag = TRUE THEN 1 END)
      comment: "Number of requests causing rooms to go out of order; directly quantifies revenue at risk from maintenance failures."
    - name: "guest_impacting_request_count"
      expr: COUNT(CASE WHEN guest_impact_flag = TRUE THEN 1 END)
      comment: "Number of guest-impacting maintenance requests; linked to satisfaction scores and service recovery costs."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost_amount AS DOUBLE))
      comment: "Total actual cost of maintenance; primary maintenance spend KPI for budget management and CapEx planning."
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost_amount AS DOUBLE))
      comment: "Total estimated cost of maintenance; used with actual cost to compute cost variance and forecast accuracy."
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost_amount AS DOUBLE))
      comment: "Total labor cost component of maintenance; used to analyze labor vs. materials cost mix."
    - name: "total_materials_cost"
      expr: SUM(CAST(materials_cost_amount AS DOUBLE))
      comment: "Total materials cost component of maintenance; used to analyze procurement spend driven by maintenance demand."
    - name: "recurring_issue_count"
      expr: COUNT(CASE WHEN recurring_issue_flag = TRUE THEN 1 END)
      comment: "Count of recurring maintenance issues; high recurrence signals asset replacement or systemic repair investment need."
    - name: "warranty_claim_count"
      expr: COUNT(CASE WHEN warranty_claim_flag = TRUE THEN 1 END)
      comment: "Number of warranty claims filed; used to recover costs from vendors and track asset warranty utilization."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`housekeeping_supply_consumption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supply consumption KPIs: total spend, unit cost trends, variance from PAR, waste rates, and replenishment triggers. Enables procurement cost control and sustainability program management."
  source: "`vibe_travel_hospitality_v1`.`housekeeping`.`supply_consumption`"
  dimensions:
    - name: "consumption_date"
      expr: consumption_date
      comment: "Date of supply consumption; used to trend supply spend and identify seasonal patterns."
    - name: "amenity_type"
      expr: amenity_type
      comment: "Type of amenity consumed (toiletries, linen, cleaning chemicals) for category-level cost analysis."
    - name: "consumption_reason"
      expr: consumption_reason
      comment: "Reason for consumption (standard, guest request, waste) for demand driver analysis."
    - name: "occupancy_status"
      expr: occupancy_status
      comment: "Room occupancy status at time of consumption; used to normalize supply costs per occupied room."
    - name: "guest_charged_indicator"
      expr: guest_charged_indicator
      comment: "Indicates whether the supply cost was charged to the guest; used for revenue recovery analysis."
    - name: "waste_indicator"
      expr: waste_indicator
      comment: "Indicates wasteful consumption; used to track sustainability and cost reduction program effectiveness."
    - name: "reorder_triggered"
      expr: reorder_triggered
      comment: "Indicates a reorder was triggered; used to monitor PAR level management effectiveness."
    - name: "property_id"
      expr: property_id
      comment: "Property identifier for cross-property supply cost benchmarking."
  measures:
    - name: "total_supply_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total supply cost consumed; primary housekeeping supply spend KPI for budget management."
    - name: "total_quantity_consumed"
      expr: SUM(CAST(quantity_consumed AS DOUBLE))
      comment: "Total quantity of supplies consumed; used for procurement demand forecasting and PAR level calibration."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost of supplies consumed; used to benchmark procurement pricing and identify cost trends."
    - name: "total_variance_from_par"
      expr: SUM(CAST(variance_from_par AS DOUBLE))
      comment: "Total variance from PAR levels; negative values indicate stockouts, positive values indicate overstock — both drive procurement action."
    - name: "waste_consumption_count"
      expr: COUNT(CASE WHEN waste_indicator = TRUE THEN 1 END)
      comment: "Number of waste consumption events; used to measure sustainability program effectiveness and reduce unnecessary spend."
    - name: "reorder_trigger_count"
      expr: COUNT(CASE WHEN reorder_triggered = TRUE THEN 1 END)
      comment: "Number of reorder triggers; used to assess PAR level accuracy and procurement responsiveness."
    - name: "total_replenishment_quantity"
      expr: SUM(CAST(replenishment_quantity AS DOUBLE))
      comment: "Total replenishment quantity ordered; used to measure supply chain responsiveness and inventory management efficiency."
    - name: "guest_charged_supply_count"
      expr: COUNT(CASE WHEN guest_charged_indicator = TRUE THEN 1 END)
      comment: "Number of supply consumption events charged to guests; used to track ancillary revenue recovery from supply costs."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`housekeeping_work_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Work order execution KPIs: labor and supply costs, inspection scores, VIP service rates, and completion pipeline. Enables operational efficiency and service quality management at the work order level."
  source: "`vibe_travel_hospitality_v1`.`housekeeping`.`work_order`"
  dimensions:
    - name: "work_order_type"
      expr: work_order_type
      comment: "Type of work order (cleaning, maintenance, amenity, linen) for workload mix analysis."
    - name: "work_order_status"
      expr: work_order_status
      comment: "Current status of the work order; used to monitor completion pipeline and identify bottlenecks."
    - name: "priority"
      expr: priority
      comment: "Priority level of the work order; used to assess urgency distribution and resource allocation."
    - name: "vip_service"
      expr: vip_service
      comment: "Indicates VIP service work order; used to segment quality and cost metrics for premium guests."
    - name: "linen_change_required"
      expr: linen_change_required
      comment: "Indicates linen change is required; used for linen demand forecasting."
    - name: "amenity_replenishment_required"
      expr: amenity_replenishment_required
      comment: "Indicates amenity replenishment is required; used for supply demand forecasting."
    - name: "scheduled_start_date"
      expr: scheduled_start_date
      comment: "Scheduled start date of the work order; used to trend workload and scheduling effectiveness."
    - name: "property_id"
      expr: property_id
      comment: "Property identifier for cross-property work order benchmarking."
  measures:
    - name: "total_work_orders"
      expr: COUNT(1)
      comment: "Total work orders created; baseline volume for operational workload and staffing analysis."
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost_amount AS DOUBLE))
      comment: "Total labor cost across work orders; primary cost KPI for housekeeping operations budget management."
    - name: "total_supply_cost"
      expr: SUM(CAST(supply_cost_amount AS DOUBLE))
      comment: "Total supply cost across work orders; used for procurement demand planning and cost control."
    - name: "avg_inspection_score"
      expr: AVG(CAST(inspection_score AS DOUBLE))
      comment: "Average inspection score across completed work orders; measures service quality delivered at the work order level."
    - name: "vip_work_order_count"
      expr: COUNT(CASE WHEN vip_service = TRUE THEN 1 END)
      comment: "Number of VIP service work orders; used to ensure premium service capacity and quality standards."
    - name: "linen_change_work_order_count"
      expr: COUNT(CASE WHEN linen_change_required = TRUE THEN 1 END)
      comment: "Number of work orders requiring linen change; used for linen inventory and laundry demand forecasting."
    - name: "maintenance_handoff_required_count"
      expr: COUNT(CASE WHEN maintenance_handoff_required = TRUE THEN 1 END)
      comment: "Number of work orders requiring maintenance handoff; measures the volume of issues escalated from housekeeping to engineering."
$$;
