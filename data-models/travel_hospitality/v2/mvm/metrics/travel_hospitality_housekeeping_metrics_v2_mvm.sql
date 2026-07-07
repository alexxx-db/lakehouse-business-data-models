-- Metric views for domain: housekeeping | Business: Travel_Hospitality | Version: 2 | Generated on: 2026-06-27 02:47:23

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`housekeeping_hk_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational KPIs for housekeeping assignments — tracks workload distribution, room credit yield, inspection outcomes, and service efficiency across attendants, properties, and assignment types."
  source: "`vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment`"
  dimensions:
    - name: "assignment_date"
      expr: assignment_date
      comment: "Calendar date of the housekeeping assignment, used for daily and weekly trend analysis."
    - name: "assignment_type"
      expr: assignment_type
      comment: "Type of housekeeping assignment (e.g., stayover, departure, deep clean) for workload segmentation."
    - name: "completion_status"
      expr: completion_status
      comment: "Current completion status of the assignment (e.g., completed, pending, skipped) for operational monitoring."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority tier of the assignment, enabling triage and escalation analysis."
    - name: "room_status_before"
      expr: room_status_before
      comment: "Room status at the start of the assignment, used to understand incoming workload condition."
    - name: "room_status_after"
      expr: room_status_after
      comment: "Room status after assignment completion, used to measure throughput and readiness."
    - name: "inspection_result"
      expr: inspection_result
      comment: "Outcome of the post-assignment inspection (e.g., pass, fail, reclean) for quality tracking."
    - name: "linen_change_flag"
      expr: linen_change_flag
      comment: "Indicates whether a linen change was performed, supporting sustainability and cost analysis."
    - name: "dnd_flag"
      expr: dnd_flag
      comment: "Do-Not-Disturb flag indicating the assignment was blocked by guest preference."
    - name: "maintenance_request_flag"
      expr: maintenance_request_flag
      comment: "Indicates whether a maintenance request was raised during the assignment."
    - name: "property_id"
      expr: property_id
      comment: "Property identifier for cross-property performance benchmarking."
    - name: "attendant_id"
      expr: attendant_id
      comment: "Attendant identifier for individual productivity and workload analysis."
  measures:
    - name: "total_assignments"
      expr: COUNT(1)
      comment: "Total number of housekeeping assignments — baseline volume metric for staffing and capacity planning."
    - name: "total_room_credits"
      expr: SUM(CAST(room_credits AS DOUBLE))
      comment: "Total room credits earned across all assignments — primary labor productivity currency in housekeeping operations."
    - name: "avg_room_credits_per_assignment"
      expr: AVG(CAST(room_credits AS DOUBLE))
      comment: "Average room credits per assignment — measures workload intensity and credit yield per task unit."
    - name: "completed_assignments"
      expr: COUNT(CASE WHEN completion_status = 'completed' THEN 1 END)
      comment: "Count of fully completed assignments — numerator for completion rate KPI used in SLA and staffing reviews."
    - name: "dnd_blocked_assignments"
      expr: COUNT(CASE WHEN dnd_flag = TRUE THEN 1 END)
      comment: "Number of assignments blocked by Do-Not-Disturb — tracks service access loss and impacts occupancy-adjusted productivity."
    - name: "maintenance_triggered_assignments"
      expr: COUNT(CASE WHEN maintenance_request_flag = TRUE THEN 1 END)
      comment: "Assignments that generated a maintenance request — leading indicator of asset condition and engineering workload."
    - name: "inspection_required_assignments"
      expr: COUNT(CASE WHEN inspection_required_flag = TRUE THEN 1 END)
      comment: "Assignments flagged for mandatory inspection — used to manage quality control throughput and inspector scheduling."
    - name: "reassignment_count_total"
      expr: COUNT(CASE WHEN reassignment_count IS NOT NULL AND reassignment_count != '0' THEN 1 END)
      comment: "Number of assignments that were reassigned at least once — measures scheduling instability and attendant availability issues."
    - name: "linen_change_assignments"
      expr: COUNT(CASE WHEN linen_change_flag = TRUE THEN 1 END)
      comment: "Assignments with linen changes performed — supports laundry cost forecasting and sustainability reporting."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`housekeeping_cleaning_task`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Granular KPIs for individual cleaning tasks — measures task execution efficiency, SLA compliance, supply consumption, and quality outcomes at the task level."
  source: "`vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task`"
  dimensions:
    - name: "task_type"
      expr: task_type
      comment: "Category of cleaning task (e.g., full clean, turndown, spot clean) for workload type analysis."
    - name: "task_status"
      expr: task_status
      comment: "Current execution status of the task (e.g., completed, in-progress, skipped) for real-time operational monitoring."
    - name: "task_priority"
      expr: task_priority
      comment: "Priority level of the task, enabling triage and escalation tracking."
    - name: "service_type"
      expr: service_type
      comment: "Service category (e.g., room service, public area, event space) for cross-segment performance comparison."
    - name: "room_type_code"
      expr: room_type_code
      comment: "Room type associated with the task, enabling productivity benchmarking by room category."
    - name: "sla_compliance_flag"
      expr: sla_compliance_flag
      comment: "Indicates whether the task was completed within the defined SLA window — core quality and compliance dimension."
    - name: "exception_flag"
      expr: exception_flag
      comment: "Flags tasks with exceptions (e.g., guest refusal, access issue) for exception rate analysis."
    - name: "guest_request_flag"
      expr: guest_request_flag
      comment: "Indicates the task was triggered by a guest request — used to measure demand-driven service volume."
    - name: "inspection_required"
      expr: inspection_required
      comment: "Whether the task requires a post-completion inspection — used for quality control scheduling."
    - name: "maintenance_request_generated"
      expr: maintenance_request_generated
      comment: "Whether the task generated a maintenance request — links cleaning operations to engineering workload."
    - name: "attendant_id"
      expr: attendant_id
      comment: "Attendant who performed the task — enables individual productivity and quality benchmarking."
    - name: "property_id"
      expr: property_id
      comment: "Property identifier for cross-property task performance comparison."
  measures:
    - name: "total_cleaning_tasks"
      expr: COUNT(1)
      comment: "Total cleaning tasks executed — baseline volume metric for capacity planning and staffing models."
    - name: "total_credit_weight"
      expr: SUM(CAST(credit_weight AS DOUBLE))
      comment: "Total credit weight across all tasks — measures aggregate labor value delivered by the housekeeping team."
    - name: "avg_credit_weight_per_task"
      expr: AVG(CAST(credit_weight AS DOUBLE))
      comment: "Average credit weight per task — benchmarks task complexity and labor intensity across room types and service categories."
    - name: "sla_compliant_tasks"
      expr: COUNT(CASE WHEN sla_compliance_flag = TRUE THEN 1 END)
      comment: "Tasks completed within SLA — numerator for SLA compliance rate, a key brand standard and franchise compliance KPI."
    - name: "exception_tasks"
      expr: COUNT(CASE WHEN exception_flag = TRUE THEN 1 END)
      comment: "Tasks flagged with exceptions — tracks service disruptions that impact guest satisfaction and room availability."
    - name: "guest_requested_tasks"
      expr: COUNT(CASE WHEN guest_request_flag = TRUE THEN 1 END)
      comment: "Tasks initiated by guest requests — measures demand-driven service volume and responsiveness."
    - name: "maintenance_requests_generated"
      expr: COUNT(CASE WHEN maintenance_request_generated = TRUE THEN 1 END)
      comment: "Cleaning tasks that triggered a maintenance request — leading indicator of asset degradation and engineering demand."
    - name: "total_supply_quantity_used"
      expr: SUM(CAST(supply_quantity_used AS DOUBLE))
      comment: "Total supply units consumed across all tasks — drives supply chain forecasting and cost-per-clean analysis."
    - name: "avg_supply_quantity_per_task"
      expr: AVG(CAST(supply_quantity_used AS DOUBLE))
      comment: "Average supply consumption per task — benchmarks supply efficiency and identifies over-consumption outliers."
    - name: "distinct_attendants_active"
      expr: COUNT(DISTINCT attendant_id)
      comment: "Number of distinct attendants performing tasks — measures active workforce utilization in a given period."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`housekeeping_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality assurance KPIs for housekeeping inspections — tracks cleanliness scores, deficiency rates, reclean requirements, and room release efficiency to drive brand standard compliance."
  source: "`vibe_travel_hospitality_v1`.`housekeeping`.`inspection`"
  dimensions:
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection (e.g., routine, VIP, pre-arrival) for segmented quality analysis."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current status of the inspection (e.g., completed, pending, failed) for workflow monitoring."
    - name: "outcome"
      expr: outcome
      comment: "Final inspection outcome (e.g., pass, fail, reclean required) — primary quality classification dimension."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority tier of the inspection, used to assess urgency and resource allocation."
    - name: "reclean_required_flag"
      expr: reclean_required_flag
      comment: "Indicates whether the room was sent back for recleaning — key quality failure indicator."
    - name: "maintenance_issue_flag"
      expr: maintenance_issue_flag
      comment: "Flags inspections where a maintenance issue was identified — links quality control to engineering escalation."
    - name: "vip_flag"
      expr: vip_flag
      comment: "Indicates the inspection was for a VIP guest room — enables premium service quality tracking."
    - name: "room_release_flag"
      expr: room_release_flag
      comment: "Whether the room was released for occupancy after inspection — directly impacts front desk room availability."
    - name: "scheduled_date"
      expr: scheduled_date
      comment: "Scheduled date of the inspection for daily quality throughput analysis."
    - name: "property_id"
      expr: property_id
      comment: "Property identifier for cross-property quality benchmarking."
    - name: "attendant_id"
      expr: attendant_id
      comment: "Attendant whose work was inspected — enables individual quality performance tracking."
  measures:
    - name: "total_inspections"
      expr: COUNT(1)
      comment: "Total inspections conducted — baseline volume metric for quality control capacity planning."
    - name: "avg_cleanliness_score"
      expr: AVG(CAST(cleanliness_score AS DOUBLE))
      comment: "Average cleanliness score across all inspections — primary brand standard quality KPI reported to ownership and franchise."
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average overall quality score per inspection — composite quality metric used in QA dashboards and performance reviews."
    - name: "reclean_required_count"
      expr: COUNT(CASE WHEN reclean_required_flag = TRUE THEN 1 END)
      comment: "Number of inspections resulting in a reclean — measures first-pass quality failure rate and rework cost."
    - name: "maintenance_issues_identified"
      expr: COUNT(CASE WHEN maintenance_issue_flag = TRUE THEN 1 END)
      comment: "Inspections where a maintenance issue was found — tracks asset condition discovery rate through the QA process."
    - name: "rooms_released"
      expr: COUNT(CASE WHEN room_release_flag = TRUE THEN 1 END)
      comment: "Rooms released for occupancy after passing inspection — directly measures housekeeping throughput and front-of-house readiness."
    - name: "vip_inspections"
      expr: COUNT(CASE WHEN vip_flag = TRUE THEN 1 END)
      comment: "Inspections conducted for VIP guest rooms — tracks premium service quality assurance volume."
    - name: "total_deficiency_count"
      expr: COUNT(CASE WHEN deficiency_count IS NOT NULL AND deficiency_count != '0' THEN 1 END)
      comment: "Inspections with at least one deficiency recorded — measures quality failure incidence rate across the property."
    - name: "critical_deficiency_inspections"
      expr: COUNT(CASE WHEN critical_deficiency_count IS NOT NULL AND critical_deficiency_count != '0' THEN 1 END)
      comment: "Inspections with critical deficiencies — highest-severity quality failures requiring immediate escalation and remediation."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`housekeeping_maintenance_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Maintenance operations KPIs — tracks request volume, cost, resolution time, safety hazards, and recurring issues to drive asset management and guest impact minimization."
  source: "`vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_request`"
  dimensions:
    - name: "request_type"
      expr: request_type
      comment: "Type of maintenance request (e.g., plumbing, electrical, HVAC) for category-level cost and volume analysis."
    - name: "maintenance_request_status"
      expr: maintenance_request_status
      comment: "Current status of the request (e.g., open, in-progress, closed) for backlog and throughput monitoring."
    - name: "priority"
      expr: priority
      comment: "Priority level of the maintenance request — used to assess SLA adherence and resource prioritization."
    - name: "safety_hazard_flag"
      expr: safety_hazard_flag
      comment: "Flags requests involving a safety hazard — critical for risk management and regulatory compliance reporting."
    - name: "guest_impact_flag"
      expr: guest_impact_flag
      comment: "Indicates the issue directly impacted a guest — links maintenance performance to guest satisfaction outcomes."
    - name: "recurring_issue_flag"
      expr: recurring_issue_flag
      comment: "Flags recurring maintenance issues — identifies chronic asset failures requiring capital investment decisions."
    - name: "room_out_of_order_flag"
      expr: room_out_of_order_flag
      comment: "Indicates the room was taken out of order — directly impacts revenue through lost room nights."
    - name: "inspection_required_flag"
      expr: inspection_required_flag
      comment: "Whether a post-repair inspection is required — used to manage quality sign-off workflow."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of cost amounts for multi-currency property portfolio analysis."
    - name: "property_id"
      expr: property_id
      comment: "Property identifier for cross-property maintenance cost and performance benchmarking."
  measures:
    - name: "total_maintenance_requests"
      expr: COUNT(1)
      comment: "Total maintenance requests submitted — baseline volume metric for engineering staffing and backlog management."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost_amount AS DOUBLE))
      comment: "Total actual maintenance cost incurred — primary financial KPI for asset management budget tracking."
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost_amount AS DOUBLE))
      comment: "Total labor cost component of maintenance — used for workforce cost allocation and make-vs-buy analysis."
    - name: "total_materials_cost"
      expr: SUM(CAST(materials_cost_amount AS DOUBLE))
      comment: "Total materials cost for maintenance — drives procurement forecasting and inventory planning."
    - name: "avg_actual_cost_per_request"
      expr: AVG(CAST(actual_cost_amount AS DOUBLE))
      comment: "Average cost per maintenance request — benchmarks efficiency and identifies high-cost outlier categories."
    - name: "safety_hazard_requests"
      expr: COUNT(CASE WHEN safety_hazard_flag = TRUE THEN 1 END)
      comment: "Requests involving safety hazards — critical risk metric for regulatory compliance and liability management."
    - name: "guest_impacting_requests"
      expr: COUNT(CASE WHEN guest_impact_flag = TRUE THEN 1 END)
      comment: "Maintenance requests that directly impacted guests — links operational failures to guest satisfaction and potential compensation costs."
    - name: "rooms_out_of_order"
      expr: COUNT(CASE WHEN room_out_of_order_flag = TRUE THEN 1 END)
      comment: "Requests that took a room out of order — measures revenue-impacting maintenance events for ownership reporting."
    - name: "recurring_issue_requests"
      expr: COUNT(CASE WHEN recurring_issue_flag = TRUE THEN 1 END)
      comment: "Recurring maintenance issues — identifies chronic asset failures that justify capital replacement decisions."
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost_amount AS DOUBLE))
      comment: "Total estimated maintenance cost — used for budget forecasting and variance analysis against actual costs."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`housekeeping_work_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Work order execution KPIs — tracks service delivery cost, inspection quality, VIP service fulfillment, and operational throughput for housekeeping and facilities work orders."
  source: "`vibe_travel_hospitality_v1`.`housekeeping`.`work_order`"
  dimensions:
    - name: "work_order_type"
      expr: work_order_type
      comment: "Type of work order (e.g., cleaning, repair, setup) for workload category analysis."
    - name: "work_order_status"
      expr: work_order_status
      comment: "Current status of the work order (e.g., open, completed, cancelled) for backlog and throughput monitoring."
    - name: "priority"
      expr: priority
      comment: "Priority level of the work order — used for SLA adherence and resource prioritization analysis."
    - name: "vip_service"
      expr: vip_service
      comment: "Indicates the work order is for a VIP guest — enables premium service delivery tracking."
    - name: "linen_change_required"
      expr: linen_change_required
      comment: "Whether a linen change is required — supports laundry operations planning and cost forecasting."
    - name: "amenity_replenishment_required"
      expr: amenity_replenishment_required
      comment: "Whether amenity replenishment is required — tracks consumable demand and procurement needs."
    - name: "maintenance_handoff_required"
      expr: maintenance_handoff_required
      comment: "Whether the work order requires handoff to maintenance — measures cross-department coordination volume."
    - name: "room_status_before"
      expr: room_status_before
      comment: "Room status at work order initiation — used to understand incoming condition and workload context."
    - name: "room_status_after"
      expr: room_status_after
      comment: "Room status after work order completion — measures throughput and room readiness outcomes."
    - name: "scheduled_start_date"
      expr: scheduled_start_date
      comment: "Scheduled start date of the work order for daily workload planning and scheduling analysis."
    - name: "property_id"
      expr: property_id
      comment: "Property identifier for cross-property work order performance benchmarking."
  measures:
    - name: "total_work_orders"
      expr: COUNT(1)
      comment: "Total work orders created — baseline volume metric for operational capacity and staffing planning."
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost_amount AS DOUBLE))
      comment: "Total labor cost across all work orders — primary cost driver for housekeeping P&L and budget variance analysis."
    - name: "total_supply_cost"
      expr: SUM(CAST(supply_cost_amount AS DOUBLE))
      comment: "Total supply cost across all work orders — drives procurement budget and cost-per-occupied-room calculations."
    - name: "avg_inspection_score"
      expr: AVG(CAST(inspection_score AS DOUBLE))
      comment: "Average inspection score across completed work orders — measures service delivery quality and brand standard adherence."
    - name: "vip_work_orders"
      expr: COUNT(CASE WHEN vip_service = TRUE THEN 1 END)
      comment: "Work orders flagged for VIP service — tracks premium service fulfillment volume and resource allocation."
    - name: "maintenance_handoff_work_orders"
      expr: COUNT(CASE WHEN maintenance_handoff_required = TRUE THEN 1 END)
      comment: "Work orders requiring maintenance handoff — measures cross-department escalation volume and coordination overhead."
    - name: "avg_labor_cost_per_work_order"
      expr: AVG(CAST(labor_cost_amount AS DOUBLE))
      comment: "Average labor cost per work order — benchmarks labor efficiency and identifies high-cost service categories."
    - name: "avg_supply_cost_per_work_order"
      expr: AVG(CAST(supply_cost_amount AS DOUBLE))
      comment: "Average supply cost per work order — benchmarks supply consumption efficiency across room types and service categories."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`housekeeping_hk_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Labor planning and schedule efficiency KPIs — tracks budget adherence, credit targets, overtime risk, and schedule compliance to optimize housekeeping labor costs."
  source: "`vibe_travel_hospitality_v1`.`housekeeping`.`hk_schedule`"
  dimensions:
    - name: "schedule_date"
      expr: schedule_date
      comment: "Date of the housekeeping schedule for daily labor planning and trend analysis."
    - name: "schedule_status"
      expr: schedule_status
      comment: "Publication and execution status of the schedule (e.g., draft, published, closed) for workflow monitoring."
    - name: "shift_type"
      expr: shift_type
      comment: "Type of shift (e.g., AM, PM, overnight) for shift-level productivity and cost analysis."
    - name: "assignment_method"
      expr: assignment_method
      comment: "Method used to assign rooms to attendants (e.g., manual, automated) for scheduling efficiency analysis."
    - name: "occupancy_forecast_tier"
      expr: occupancy_forecast_tier
      comment: "Occupancy forecast tier (e.g., low, medium, high) used to align labor supply with demand."
    - name: "turndown_service_flag"
      expr: turndown_service_flag
      comment: "Indicates whether turndown service is scheduled — used for evening labor planning and amenity cost forecasting."
    - name: "pip_compliance_flag"
      expr: pip_compliance_flag
      comment: "Property Improvement Plan compliance flag — tracks adherence to brand standard labor requirements."
    - name: "section_code"
      expr: section_code
      comment: "Section of the property assigned in this schedule — enables section-level workload balancing analysis."
    - name: "property_id"
      expr: property_id
      comment: "Property identifier for cross-property labor planning benchmarking."
  measures:
    - name: "total_schedules"
      expr: COUNT(1)
      comment: "Total schedule records — baseline count for schedule coverage and planning completeness analysis."
    - name: "total_labor_budget"
      expr: SUM(CAST(labor_budget_amount AS DOUBLE))
      comment: "Total labor budget allocated across schedules — primary financial planning metric for housekeeping cost management."
    - name: "avg_labor_budget_per_schedule"
      expr: AVG(CAST(labor_budget_amount AS DOUBLE))
      comment: "Average labor budget per schedule day — benchmarks daily labor spend against occupancy and productivity targets."
    - name: "total_cpor_target"
      expr: SUM(CAST(cpor_target AS DOUBLE))
      comment: "Sum of cost-per-occupied-room targets across schedules — used to validate budget alignment with occupancy forecasts."
    - name: "avg_cpor_target"
      expr: AVG(CAST(cpor_target AS DOUBLE))
      comment: "Average CPOR target — key labor efficiency benchmark used by GMs and ownership to evaluate housekeeping cost competitiveness."
    - name: "total_section_credit_value"
      expr: SUM(CAST(section_credit_value AS DOUBLE))
      comment: "Total credit value assigned across all sections — measures planned labor output in credit units for productivity planning."
    - name: "avg_overtime_threshold_hours"
      expr: AVG(CAST(overtime_threshold_hours AS DOUBLE))
      comment: "Average overtime threshold hours across schedules — monitors overtime risk exposure and labor cost control."
    - name: "pip_compliant_schedules"
      expr: COUNT(CASE WHEN pip_compliance_flag = TRUE THEN 1 END)
      comment: "Schedules meeting PIP compliance requirements — tracks brand standard adherence for franchise and ownership reporting."
    - name: "turndown_service_schedules"
      expr: COUNT(CASE WHEN turndown_service_flag = TRUE THEN 1 END)
      comment: "Schedules with turndown service activated — measures premium evening service deployment frequency and associated cost."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`housekeeping_attendant`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce KPIs for housekeeping attendants — tracks productivity benchmarks, credit performance, workforce composition, and staffing health to support labor management decisions."
  source: "`vibe_travel_hospitality_v1`.`housekeeping`.`attendant`"
  dimensions:
    - name: "employment_status"
      expr: employment_status
      comment: "Current employment status (e.g., active, terminated, on-leave) for workforce composition analysis."
    - name: "role_type"
      expr: role_type
      comment: "Role classification of the attendant (e.g., room attendant, supervisor, inspector) for role-level productivity benchmarking."
    - name: "shift_assignment"
      expr: shift_assignment
      comment: "Assigned shift (e.g., AM, PM) for shift-level workforce and productivity analysis."
    - name: "section_assignment"
      expr: section_assignment
      comment: "Section of the property assigned to the attendant — enables section-level workload and performance analysis."
    - name: "union_member_flag"
      expr: union_member_flag
      comment: "Indicates union membership — used for labor relations reporting and contract compliance tracking."
    - name: "union_classification"
      expr: union_classification
      comment: "Union classification of the attendant — supports collective bargaining agreement compliance and cost analysis."
    - name: "active_flag"
      expr: active_flag
      comment: "Whether the attendant is currently active — used to filter active workforce for productivity and scheduling analysis."
    - name: "ada_accommodation_flag"
      expr: ada_accommodation_flag
      comment: "Indicates ADA accommodation requirements — used for compliance reporting and assignment planning."
    - name: "performance_rating"
      expr: performance_rating
      comment: "Performance rating tier of the attendant — used for talent management and incentive program analysis."
    - name: "property_id"
      expr: property_id
      comment: "Property identifier for cross-property workforce benchmarking."
  measures:
    - name: "total_attendants"
      expr: COUNT(1)
      comment: "Total attendant headcount — baseline workforce size metric for staffing ratio and capacity planning."
    - name: "active_attendants"
      expr: COUNT(CASE WHEN active_flag = TRUE THEN 1 END)
      comment: "Currently active attendants — measures deployable workforce size for scheduling and coverage analysis."
    - name: "avg_credits_per_shift"
      expr: AVG(CAST(average_credits_per_shift AS DOUBLE))
      comment: "Average credits earned per shift across attendants — primary individual productivity benchmark used in performance reviews and incentive programs."
    - name: "total_target_credits_per_shift"
      expr: SUM(CAST(target_credits_per_shift AS DOUBLE))
      comment: "Sum of target credits per shift across all attendants — measures aggregate planned productivity output for the workforce."
    - name: "avg_target_credits_per_shift"
      expr: AVG(CAST(target_credits_per_shift AS DOUBLE))
      comment: "Average target credits per shift — benchmarks productivity expectations and identifies over/under-target attendants."
    - name: "union_member_count"
      expr: COUNT(CASE WHEN union_member_flag = TRUE THEN 1 END)
      comment: "Number of union member attendants — tracks union workforce proportion for labor relations and contract compliance reporting."
    - name: "ada_accommodation_count"
      expr: COUNT(CASE WHEN ada_accommodation_flag = TRUE THEN 1 END)
      comment: "Attendants with ADA accommodations — supports compliance reporting and assignment planning for accessible room sections."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`housekeeping_lost_and_found`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lost and found operations KPIs — tracks item volume, estimated value, claim rates, high-value item handling, and disposition outcomes to manage guest trust and regulatory compliance."
  source: "`vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found`"
  dimensions:
    - name: "lost_and_found_status"
      expr: lost_and_found_status
      comment: "Current status of the lost and found item (e.g., found, claimed, disposed) for case management monitoring."
    - name: "claim_status"
      expr: claim_status
      comment: "Status of the guest claim (e.g., claimed, unclaimed, pending) — used to track claim resolution rates."
    - name: "disposition_type"
      expr: disposition_type
      comment: "How the item was ultimately disposed of (e.g., returned, donated, discarded) for compliance and policy reporting."
    - name: "item_category"
      expr: item_category
      comment: "Category of the lost item (e.g., electronics, clothing, documents) for volume and value trend analysis."
    - name: "discovery_location_type"
      expr: discovery_location_type
      comment: "Type of location where the item was found (e.g., guest room, lobby, restaurant) for hotspot identification."
    - name: "is_high_value_item"
      expr: is_high_value_item
      comment: "Flags high-value items requiring special handling — used for risk management and security protocol compliance."
    - name: "requires_special_handling"
      expr: requires_special_handling
      comment: "Indicates items requiring special handling procedures — tracks compliance with handling protocols."
    - name: "guest_notification_status"
      expr: guest_notification_status
      comment: "Status of guest notification (e.g., notified, pending, unable to contact) — measures guest communication responsiveness."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of estimated item value for multi-currency portfolio analysis."
    - name: "discovery_date"
      expr: discovery_date
      comment: "Date the item was discovered — used for volume trend analysis and retention period compliance tracking."
    - name: "property_id"
      expr: property_id
      comment: "Property identifier for cross-property lost and found volume and value benchmarking."
  measures:
    - name: "total_items_found"
      expr: COUNT(1)
      comment: "Total lost and found items logged — baseline volume metric for operational workload and guest trust management."
    - name: "total_estimated_value"
      expr: SUM(CAST(estimated_value_amount AS DOUBLE))
      comment: "Total estimated value of all lost items — measures financial liability and risk exposure from unclaimed items."
    - name: "avg_estimated_value_per_item"
      expr: AVG(CAST(estimated_value_amount AS DOUBLE))
      comment: "Average estimated value per lost item — benchmarks item value profile and informs handling protocol thresholds."
    - name: "high_value_items"
      expr: COUNT(CASE WHEN is_high_value_item = TRUE THEN 1 END)
      comment: "Number of high-value items in lost and found — tracks premium item volume requiring enhanced security and handling protocols."
    - name: "claimed_items"
      expr: COUNT(CASE WHEN claim_status = 'claimed' THEN 1 END)
      comment: "Items successfully claimed by guests — numerator for claim rate KPI measuring guest recovery success."
    - name: "total_shipping_cost"
      expr: SUM(CAST(shipping_cost_amount AS DOUBLE))
      comment: "Total shipping cost incurred for returning items to guests — operational cost metric for lost and found program management."
    - name: "items_requiring_special_handling"
      expr: COUNT(CASE WHEN requires_special_handling = TRUE THEN 1 END)
      comment: "Items requiring special handling — measures compliance workload and protocol adherence requirements."
$$;