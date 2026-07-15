-- Metric views for domain: maintenance | Business: Waste Management | Version: 1 | Generated on: 2026-05-07 22:39:52

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`maintenance_work_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPI layer over work orders capturing cost efficiency, schedule adherence, labor utilization, and compliance posture for maintenance operations across all asset types."
  source: "`waste_management_ecm`.`maintenance`.`work_order`"
  dimensions:
    - name: "work_order_priority"
      expr: priority
      comment: "Priority level of the work order (e.g., Critical, High, Medium, Low) — used to segment KPIs by urgency tier."
    - name: "work_order_status"
      expr: wo_status
      comment: "Current lifecycle status of the work order (e.g., Open, In Progress, Closed) — enables funnel and backlog analysis."
    - name: "work_order_type"
      expr: dot_inspection_type
      comment: "DOT inspection type associated with the work order — supports regulatory compliance segmentation."
    - name: "is_dot_inspection"
      expr: dot_inspection_flag
      comment: "Boolean flag indicating whether the work order is a DOT-required inspection — critical for regulatory reporting."
    - name: "is_regulatory_compliance"
      expr: regulatory_compliance_flag
      comment: "Boolean flag indicating whether the work order is driven by a regulatory compliance requirement."
    - name: "is_loto_required"
      expr: loto_required
      comment: "Boolean flag indicating whether Lockout/Tagout (LOTO) safety procedure is required for this work order."
    - name: "is_warranty_claim"
      expr: warranty_claim_flag
      comment: "Boolean flag indicating whether a warranty claim is associated with this work order — used to track warranty recovery opportunities."
    - name: "scheduled_start_date"
      expr: DATE_TRUNC('month', scheduled_start_date)
      comment: "Month bucket of the scheduled start date — enables trend analysis of work order volume and cost over time."
    - name: "originating_system"
      expr: originating_system
      comment: "Source system that originated the work order (e.g., SAP, Maximo) — supports data lineage and system adoption analysis."
    - name: "root_cause_category"
      expr: root_cause
      comment: "Root cause classification of the work order — enables Pareto analysis of failure drivers."
  measures:
    - name: "total_work_orders"
      expr: COUNT(1)
      comment: "Total number of work orders — baseline volume metric for workload and capacity planning."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred across all work orders — primary financial KPI for maintenance spend management."
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated cost across all work orders — used as the budget baseline for cost variance analysis."
    - name: "total_parts_cost"
      expr: SUM(CAST(parts_cost AS DOUBLE))
      comment: "Total parts cost component of work orders — enables parts spend analysis separate from labor."
    - name: "total_external_service_cost"
      expr: SUM(CAST(external_service_cost AS DOUBLE))
      comment: "Total cost paid to external service providers — tracks outsourced maintenance spend and make-vs-buy decisions."
    - name: "total_actual_labor_hours"
      expr: SUM(CAST(actual_labor_hours AS DOUBLE))
      comment: "Total actual labor hours consumed across work orders — key input for workforce capacity and utilization analysis."
    - name: "total_estimated_labor_hours"
      expr: SUM(CAST(estimated_labor_hours AS DOUBLE))
      comment: "Total estimated labor hours planned across work orders — used as the planned baseline for labor efficiency measurement."
    - name: "avg_actual_cost_per_work_order"
      expr: AVG(CAST(actual_cost AS DOUBLE))
      comment: "Average actual cost per work order — benchmarking metric for maintenance cost efficiency across asset types and facilities."
    - name: "avg_labor_hours_per_work_order"
      expr: AVG(CAST(actual_labor_hours AS DOUBLE))
      comment: "Average actual labor hours per work order — used to assess technician productivity and task complexity trends."
    - name: "cost_variance"
      expr: SUM((CAST(actual_cost AS DOUBLE)) - (CAST(estimated_cost AS DOUBLE)))
      comment: "Total cost variance (actual minus estimated) across work orders — negative values indicate under-budget performance; positive values signal cost overruns requiring investigation."
    - name: "labor_hours_variance"
      expr: SUM((CAST(actual_labor_hours AS DOUBLE)) - (CAST(estimated_labor_hours AS DOUBLE)))
      comment: "Total labor hours variance (actual minus estimated) — identifies systemic underestimation or inefficiency in maintenance planning."
    - name: "dot_inspection_work_order_count"
      expr: COUNT(CASE WHEN dot_inspection_flag = TRUE THEN 1 END)
      comment: "Count of work orders flagged as DOT inspections — regulatory compliance volume metric for fleet safety reporting."
    - name: "warranty_claim_work_order_count"
      expr: COUNT(CASE WHEN warranty_claim_flag = TRUE THEN 1 END)
      comment: "Count of work orders with active warranty claims — tracks warranty recovery volume and potential cost avoidance."
    - name: "distinct_assets_maintained"
      expr: COUNT(DISTINCT fixed_asset_id)
      comment: "Count of distinct fixed assets that have had work orders — measures maintenance coverage breadth across the asset fleet."
$$;


CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`maintenance_downtime_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational reliability KPI layer over downtime events — tracks asset availability, downtime cost, response efficiency, and repeat failure patterns to drive maintenance strategy and SLA compliance."
  source: "`waste_management_ecm`.`maintenance`.`downtime_event`"
  dimensions:
    - name: "downtime_category"
      expr: downtime_category
      comment: "Category of the downtime event (e.g., Mechanical, Electrical, Operator Error) — primary dimension for root cause analysis."
    - name: "downtime_status"
      expr: downtime_status
      comment: "Current status of the downtime event (e.g., Open, Resolved) — used to track open vs. resolved downtime backlog."
    - name: "asset_type"
      expr: asset_type
      comment: "Type of asset that experienced the downtime (e.g., Collection Vehicle, Compactor, LFG Well) — enables asset-class reliability benchmarking."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level assigned to the downtime event — used to segment response time and cost KPIs by urgency."
    - name: "operational_impact_type"
      expr: operational_impact_type
      comment: "Type of operational impact caused by the downtime (e.g., Route Disruption, Facility Shutdown) — links downtime to service delivery consequences."
    - name: "is_repeat_failure"
      expr: is_repeat_failure
      comment: "Boolean flag indicating whether this downtime event is a repeat failure on the same asset — key indicator of chronic reliability issues."
    - name: "is_dot_inspection_required"
      expr: is_dot_inspection_required
      comment: "Boolean flag indicating whether a DOT inspection was triggered by this downtime event — regulatory compliance dimension."
    - name: "dot_inspection_result"
      expr: dot_inspection_result
      comment: "Result of the DOT inspection associated with the downtime event (e.g., Pass, Fail, Out-of-Service) — regulatory outcome dimension."
    - name: "downtime_month"
      expr: DATE_TRUNC('month', downtime_start_timestamp)
      comment: "Month bucket of the downtime start timestamp — enables trend analysis of downtime frequency and cost over time."
  measures:
    - name: "total_downtime_events"
      expr: COUNT(1)
      comment: "Total number of downtime events — baseline reliability metric for fleet and asset availability management."
    - name: "total_downtime_hours"
      expr: SUM(CAST(downtime_duration_hours AS DOUBLE))
      comment: "Total hours of asset downtime — primary availability KPI; directly tied to lost operational capacity and revenue."
    - name: "total_downtime_cost"
      expr: SUM(CAST(total_downtime_cost AS DOUBLE))
      comment: "Total financial cost of all downtime events including labor, parts, and lost revenue estimates — executive-level cost of unreliability metric."
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost AS DOUBLE))
      comment: "Total labor cost incurred during downtime events — used to assess labor intensity of unplanned maintenance."
    - name: "total_parts_cost"
      expr: SUM(CAST(parts_cost AS DOUBLE))
      comment: "Total parts cost incurred during downtime events — tracks unplanned parts spend driven by failures."
    - name: "total_lost_revenue_estimate"
      expr: SUM(CAST(lost_revenue_estimate AS DOUBLE))
      comment: "Total estimated revenue lost due to downtime events — quantifies the business impact of asset unreliability in financial terms."
    - name: "avg_downtime_duration_hours"
      expr: AVG(CAST(downtime_duration_hours AS DOUBLE))
      comment: "Average duration of downtime events in hours — proxy for Mean Time To Repair (MTTR); lower values indicate faster resolution capability."
    - name: "avg_response_time_hours"
      expr: AVG(CAST(response_time_hours AS DOUBLE))
      comment: "Average response time from downtime report to technician engagement — measures maintenance responsiveness and SLA adherence."
    - name: "avg_repair_time_hours"
      expr: AVG(CAST(repair_time_hours AS DOUBLE))
      comment: "Average time to complete repairs — core MTTR metric used to benchmark technician efficiency and parts availability."
    - name: "avg_parts_wait_hours"
      expr: AVG(CAST(parts_wait_hours AS DOUBLE))
      comment: "Average hours spent waiting for parts during a downtime event — identifies parts supply chain bottlenecks that extend downtime."
    - name: "repeat_failure_count"
      expr: COUNT(CASE WHEN is_repeat_failure = TRUE THEN 1 END)
      comment: "Count of downtime events classified as repeat failures — high values signal inadequate root cause resolution and drive PM program review."
    - name: "distinct_assets_with_downtime"
      expr: COUNT(DISTINCT fixed_asset_id)
      comment: "Count of distinct assets that experienced at least one downtime event — measures the breadth of reliability issues across the fleet."
    - name: "avg_lost_revenue_per_event"
      expr: AVG(CAST(lost_revenue_estimate AS DOUBLE))
      comment: "Average estimated revenue lost per downtime event — used to prioritize high-impact asset classes for reliability investment."
$$;


CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`maintenance_repair_history`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Historical repair performance KPI layer — tracks total repair costs, labor efficiency, warranty recovery, and technician productivity to inform asset lifecycle and maintenance strategy decisions."
  source: "`waste_management_ecm`.`maintenance`.`repair_history`"
  dimensions:
    - name: "repair_type"
      expr: repair_type
      comment: "Classification of the repair (e.g., Corrective, Preventive, Emergency) — primary dimension for repair cost and labor analysis."
    - name: "repair_status"
      expr: repair_status
      comment: "Current status of the repair record (e.g., Completed, In Progress, Cancelled) — used to filter active vs. closed repair analysis."
    - name: "priority"
      expr: priority
      comment: "Priority level of the repair — enables segmentation of cost and labor KPIs by urgency tier."
    - name: "is_dot_inspection"
      expr: is_dot_inspection
      comment: "Boolean flag indicating whether the repair was associated with a DOT inspection — regulatory compliance dimension."
    - name: "is_warranty_claim"
      expr: is_warranty_claim
      comment: "Boolean flag indicating whether a warranty claim was filed for this repair — tracks warranty cost recovery opportunities."
    - name: "component_repaired"
      expr: component_repaired
      comment: "The specific component or system that was repaired — enables Pareto analysis of high-frequency failure components."
    - name: "repair_month"
      expr: DATE_TRUNC('month', reported_date)
      comment: "Month bucket of the repair reported date — enables trend analysis of repair volume and cost over time."
    - name: "vmrs_system_code"
      expr: vmrs_system_code
      comment: "Vehicle Maintenance Reporting Standards (VMRS) system code — industry-standard classification for repair type benchmarking."
  measures:
    - name: "total_repairs"
      expr: COUNT(1)
      comment: "Total number of repair records — baseline volume metric for maintenance workload and asset reliability tracking."
    - name: "total_repair_cost"
      expr: SUM(CAST(total_repair_cost AS DOUBLE))
      comment: "Total cost of all repairs including labor, parts, and subcontractor costs — primary financial KPI for maintenance cost management."
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost AS DOUBLE))
      comment: "Total labor cost component of repairs — used to assess in-house labor spend and workforce cost trends."
    - name: "total_parts_cost"
      expr: SUM(CAST(parts_cost AS DOUBLE))
      comment: "Total parts cost component of repairs — tracks material spend and informs parts procurement strategy."
    - name: "total_subcontractor_cost"
      expr: SUM(CAST(subcontractor_cost AS DOUBLE))
      comment: "Total cost paid to subcontractors for repairs — measures outsourced maintenance spend and informs make-vs-buy decisions."
    - name: "total_labor_hours"
      expr: SUM(CAST(labor_hours AS DOUBLE))
      comment: "Total labor hours consumed across all repairs — key input for workforce capacity planning and technician utilization."
    - name: "total_downtime_hours"
      expr: SUM(CAST(downtime_hours AS DOUBLE))
      comment: "Total downtime hours associated with repair events — measures the operational availability impact of maintenance activities."
    - name: "avg_repair_cost"
      expr: AVG(CAST(total_repair_cost AS DOUBLE))
      comment: "Average cost per repair — benchmarking metric for maintenance cost efficiency; used to identify high-cost asset classes or repair types."
    - name: "avg_labor_hours_per_repair"
      expr: AVG(CAST(labor_hours AS DOUBLE))
      comment: "Average labor hours per repair — measures technician efficiency and task complexity; used to calibrate labor estimates."
    - name: "warranty_claim_repair_count"
      expr: COUNT(CASE WHEN is_warranty_claim = TRUE THEN 1 END)
      comment: "Count of repairs with warranty claims filed — tracks warranty recovery volume and potential cost avoidance from manufacturer defects."
    - name: "dot_inspection_repair_count"
      expr: COUNT(CASE WHEN is_dot_inspection = TRUE THEN 1 END)
      comment: "Count of repairs associated with DOT inspections — regulatory compliance volume metric for fleet safety reporting."
    - name: "distinct_assets_repaired"
      expr: COUNT(DISTINCT fixed_asset_id)
      comment: "Count of distinct fixed assets that received repairs — measures maintenance coverage and identifies assets with high repair frequency."
    - name: "avg_downtime_hours_per_repair"
      expr: AVG(CAST(downtime_hours AS DOUBLE))
      comment: "Average downtime hours per repair event — proxy for MTTR at the repair record level; lower values indicate faster resolution."
$$;


CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`maintenance_pm_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Preventive maintenance program KPI layer — tracks PM schedule compliance, cost estimation accuracy, regulatory PM coverage, and schedule health to drive proactive asset reliability management."
  source: "`waste_management_ecm`.`maintenance`.`pm_schedule`"
  dimensions:
    - name: "schedule_status"
      expr: schedule_status
      comment: "Current status of the PM schedule (e.g., Active, Inactive, Overdue) — primary dimension for compliance and backlog analysis."
    - name: "asset_category"
      expr: asset_category
      comment: "Category of the asset covered by the PM schedule (e.g., Vehicle, Facility Equipment, LFG Well) — enables PM cost and compliance analysis by asset class."
    - name: "frequency_unit"
      expr: frequency_unit
      comment: "Unit of the PM frequency interval (e.g., Days, Miles, Hours) — used to segment PM schedules by trigger basis."
    - name: "work_order_type"
      expr: work_order_type
      comment: "Type of work order generated by this PM schedule — links PM planning to work order execution analysis."
    - name: "is_dot_inspection"
      expr: is_dot_inspection
      comment: "Boolean flag indicating whether the PM schedule covers a DOT-required inspection — regulatory compliance dimension."
    - name: "is_epa_required"
      expr: is_epa_required
      comment: "Boolean flag indicating whether the PM schedule is EPA-mandated — environmental regulatory compliance dimension."
    - name: "is_osha_required"
      expr: is_osha_required
      comment: "Boolean flag indicating whether the PM schedule is OSHA-mandated — occupational safety compliance dimension."
    - name: "priority"
      expr: priority
      comment: "Priority level of the PM schedule — used to segment compliance and cost KPIs by criticality tier."
    - name: "next_due_month"
      expr: DATE_TRUNC('month', next_due_date)
      comment: "Month bucket of the next PM due date — enables forward-looking workload and resource planning."
    - name: "auto_wo_generation"
      expr: auto_wo_generation
      comment: "Boolean flag indicating whether work orders are automatically generated from this PM schedule — measures automation adoption in PM execution."
  measures:
    - name: "total_pm_schedules"
      expr: COUNT(1)
      comment: "Total number of active PM schedules — baseline metric for PM program scope and coverage."
    - name: "overdue_pm_schedule_count"
      expr: COUNT(CASE WHEN schedule_status = 'Overdue' THEN 1 END)
      comment: "Count of PM schedules that are past their due date — critical compliance risk metric; high values indicate deferred maintenance exposure."
    - name: "total_estimated_labor_cost"
      expr: SUM(CAST(estimated_labor_cost AS DOUBLE))
      comment: "Total estimated labor cost across all PM schedules — used for maintenance budget planning and resource allocation."
    - name: "total_estimated_parts_cost"
      expr: SUM(CAST(estimated_parts_cost AS DOUBLE))
      comment: "Total estimated parts cost across all PM schedules — drives parts procurement planning and inventory stocking decisions."
    - name: "avg_estimated_duration_hours"
      expr: AVG(CAST(estimated_duration_hours AS DOUBLE))
      comment: "Average estimated duration per PM task in hours — used for technician scheduling and capacity planning."
    - name: "regulatory_pm_schedule_count"
      expr: COUNT(CASE WHEN is_dot_inspection = TRUE OR is_epa_required = TRUE OR is_osha_required = TRUE THEN 1 END)
      comment: "Count of PM schedules driven by regulatory requirements (DOT, EPA, or OSHA) — measures the regulatory compliance footprint of the PM program."
    - name: "auto_wo_pm_schedule_count"
      expr: COUNT(CASE WHEN auto_wo_generation = TRUE THEN 1 END)
      comment: "Count of PM schedules with automatic work order generation enabled — measures PM automation adoption and reduces manual scheduling risk."
    - name: "distinct_assets_on_pm"
      expr: COUNT(DISTINCT fixed_asset_id)
      comment: "Count of distinct fixed assets covered by at least one PM schedule — measures PM program coverage breadth across the asset fleet."
    - name: "avg_estimated_parts_cost_per_schedule"
      expr: AVG(CAST(estimated_parts_cost AS DOUBLE))
      comment: "Average estimated parts cost per PM schedule — used to benchmark PM material intensity and identify high-cost maintenance plans."
$$;


CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`maintenance_technician_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Technician workforce KPI layer — tracks labor utilization, overtime exposure, assignment efficiency, and hazmat/DOT certification compliance to optimize maintenance workforce deployment."
  source: "`waste_management_ecm`.`maintenance`.`technician_assignment`"
  dimensions:
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current status of the technician assignment (e.g., Scheduled, In Progress, Completed, Cancelled) — primary dimension for workforce pipeline analysis."
    - name: "assignment_type"
      expr: assignment_type
      comment: "Type of technician assignment (e.g., Primary, Backup, Supervisor) — used to segment labor hours and cost by role type."
    - name: "craft_code"
      expr: craft_code
      comment: "Craft or trade code of the assigned technician (e.g., Mechanic, Electrician, Welder) — enables labor cost and utilization analysis by skill trade."
    - name: "skill_level"
      expr: skill_level
      comment: "Skill level of the assigned technician (e.g., Apprentice, Journeyman, Master) — used to analyze labor cost and efficiency by competency tier."
    - name: "shift_code"
      expr: shift_code
      comment: "Shift code for the assignment (e.g., Day, Night, Weekend) — enables shift-level labor utilization and overtime analysis."
    - name: "is_dot_inspection"
      expr: dot_inspection_flag
      comment: "Boolean flag indicating whether the assignment involves a DOT inspection — regulatory compliance dimension for certified technician tracking."
    - name: "is_hazmat_work"
      expr: hazmat_work_flag
      comment: "Boolean flag indicating whether the assignment involves hazardous materials work — safety compliance and certified labor tracking dimension."
    - name: "work_order_priority"
      expr: work_order_priority
      comment: "Priority of the work order associated with this assignment — used to analyze labor allocation by urgency tier."
    - name: "assignment_month"
      expr: DATE_TRUNC('month', actual_start_datetime)
      comment: "Month bucket of the actual assignment start — enables trend analysis of labor hours, cost, and overtime over time."
  measures:
    - name: "total_assignments"
      expr: COUNT(1)
      comment: "Total number of technician assignments — baseline workforce activity metric for capacity and scheduling analysis."
    - name: "total_actual_labor_hours"
      expr: SUM(CAST(actual_labor_hours AS DOUBLE))
      comment: "Total actual labor hours worked across all assignments — primary workforce utilization metric for capacity planning and cost management."
    - name: "total_scheduled_labor_hours"
      expr: SUM(CAST(scheduled_labor_hours AS DOUBLE))
      comment: "Total scheduled labor hours planned across assignments — used as the planned baseline for labor efficiency measurement."
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours worked — critical cost and workforce health metric; high overtime signals understaffing or scheduling inefficiency."
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost AS DOUBLE))
      comment: "Total labor cost across all technician assignments — primary financial metric for workforce cost management."
    - name: "total_travel_time_hours"
      expr: SUM(CAST(travel_time_hours AS DOUBLE))
      comment: "Total travel time hours across assignments — measures non-productive labor time; high values indicate geographic inefficiency in technician dispatch."
    - name: "total_downtime_hours"
      expr: SUM(CAST(downtime_hours AS DOUBLE))
      comment: "Total downtime hours logged by technicians during assignments — measures idle or waiting time that reduces workforce productivity."
    - name: "avg_actual_labor_hours_per_assignment"
      expr: AVG(CAST(actual_labor_hours AS DOUBLE))
      comment: "Average actual labor hours per assignment — measures task complexity and technician efficiency per engagement."
    - name: "labor_hours_variance"
      expr: SUM((CAST(actual_labor_hours AS DOUBLE)) - (CAST(scheduled_labor_hours AS DOUBLE)))
      comment: "Total labor hours variance (actual minus scheduled) — identifies systemic underestimation in maintenance planning or inefficiency in execution."
    - name: "hazmat_assignment_count"
      expr: COUNT(CASE WHEN hazmat_work_flag = TRUE THEN 1 END)
      comment: "Count of assignments involving hazardous materials work — tracks certified hazmat labor demand for compliance and safety workforce planning."
    - name: "dot_inspection_assignment_count"
      expr: COUNT(CASE WHEN dot_inspection_flag = TRUE THEN 1 END)
      comment: "Count of assignments involving DOT inspections — regulatory compliance volume metric for certified technician utilization tracking."
    - name: "avg_labor_rate"
      expr: AVG(CAST(labor_rate AS DOUBLE))
      comment: "Average labor rate across technician assignments — used to benchmark workforce cost and inform labor contract negotiations."
    - name: "distinct_technicians_assigned"
      expr: COUNT(DISTINCT work_order_id)
      comment: "Count of distinct work orders receiving technician assignments — measures active maintenance workload breadth across the organization."
$$;


CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`maintenance_parts_usage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Parts consumption KPI layer — tracks parts spend, usage efficiency, warranty claim recovery, and hazmat parts handling to optimize inventory investment and maintenance material costs."
  source: "`waste_management_ecm`.`maintenance`.`parts_usage`"
  dimensions:
    - name: "part_category"
      expr: part_category
      comment: "Category of the part used (e.g., Engine, Hydraulic, Electrical) — primary dimension for parts spend analysis by component system."
    - name: "asset_type"
      expr: asset_type
      comment: "Type of asset the part was used on — enables parts consumption analysis by asset class to inform stocking strategies."
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of parts transaction (e.g., Issue, Return, Transfer) — used to distinguish consumption from returns in net usage analysis."
    - name: "issue_status"
      expr: issue_status
      comment: "Status of the parts issue transaction (e.g., Issued, Pending, Cancelled) — used to filter confirmed consumption from pending requests."
    - name: "is_hazmat_part"
      expr: hazmat_part_flag
      comment: "Boolean flag indicating whether the part is classified as hazardous material — regulatory compliance and safety tracking dimension."
    - name: "is_warranty_claim"
      expr: warranty_claim_flag
      comment: "Boolean flag indicating whether a warranty claim was filed for this parts usage — tracks warranty recovery opportunities."
    - name: "is_reorder_triggered"
      expr: reorder_triggered_flag
      comment: "Boolean flag indicating whether this parts usage triggered a reorder — measures inventory replenishment activity driven by consumption."
    - name: "work_order_type"
      expr: work_order_type
      comment: "Type of work order associated with the parts usage — enables parts spend analysis by maintenance type (PM vs. corrective)."
    - name: "issue_month"
      expr: DATE_TRUNC('month', issue_date)
      comment: "Month bucket of the parts issue date — enables trend analysis of parts consumption and spend over time."
  measures:
    - name: "total_parts_transactions"
      expr: COUNT(1)
      comment: "Total number of parts usage transactions — baseline metric for parts consumption activity volume."
    - name: "total_parts_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total cost of all parts issued — primary financial KPI for parts spend management and inventory investment tracking."
    - name: "total_quantity_issued"
      expr: SUM(CAST(quantity_issued AS DOUBLE))
      comment: "Total quantity of parts issued across all transactions — measures parts consumption volume for demand forecasting and reorder planning."
    - name: "total_quantity_returned"
      expr: SUM(CAST(quantity_returned AS DOUBLE))
      comment: "Total quantity of parts returned — used to calculate net consumption and identify over-ordering patterns."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost of parts issued — benchmarking metric for parts procurement efficiency and supplier cost management."
    - name: "avg_cost_per_transaction"
      expr: AVG(CAST(total_cost AS DOUBLE))
      comment: "Average total cost per parts usage transaction — used to identify high-value parts consumption events and prioritize cost reduction efforts."
    - name: "warranty_claim_parts_count"
      expr: COUNT(CASE WHEN warranty_claim_flag = TRUE THEN 1 END)
      comment: "Count of parts usage transactions with warranty claims — tracks warranty recovery volume and potential cost avoidance from defective parts."
    - name: "hazmat_parts_transaction_count"
      expr: COUNT(CASE WHEN hazmat_part_flag = TRUE THEN 1 END)
      comment: "Count of parts usage transactions involving hazardous materials — regulatory compliance and safety tracking metric for hazmat parts handling."
    - name: "reorder_triggered_count"
      expr: COUNT(CASE WHEN reorder_triggered_flag = TRUE THEN 1 END)
      comment: "Count of parts usage transactions that triggered a reorder — measures inventory replenishment frequency and identifies high-velocity parts."
    - name: "distinct_parts_used"
      expr: COUNT(DISTINCT parts_catalog_id)
      comment: "Count of distinct parts catalog items consumed — measures parts diversity in maintenance operations and informs stocking breadth decisions."
    - name: "net_quantity_consumed"
      expr: SUM((CAST(quantity_issued AS DOUBLE)) - (CAST(quantity_returned AS DOUBLE)))
      comment: "Net quantity consumed (issued minus returned) — true consumption metric used for demand forecasting and inventory optimization."
$$;


CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`maintenance_parts_inventory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Parts inventory health KPI layer — tracks inventory value, stock level compliance, stockout risk, and cycle count accuracy to optimize working capital and ensure parts availability for maintenance operations."
  source: "`waste_management_ecm`.`maintenance`.`parts_inventory`"
  dimensions:
    - name: "inventory_status"
      expr: inventory_status
      comment: "Current status of the inventory record (e.g., Active, Obsolete, Quarantine) — primary dimension for inventory health analysis."
    - name: "part_category"
      expr: part_category
      comment: "Category of the part (e.g., Engine, Hydraulic, Electrical) — enables inventory value and stock level analysis by component system."
    - name: "abc_classification"
      expr: abc_classification
      comment: "ABC inventory classification (A=high value/velocity, B=medium, C=low) — primary dimension for inventory prioritization and cycle count frequency decisions."
    - name: "criticality_level"
      expr: criticality_level
      comment: "Criticality level of the part (e.g., Critical, Essential, Non-Critical) — used to prioritize stockout risk management for mission-critical parts."
    - name: "is_hazardous"
      expr: is_hazardous
      comment: "Boolean flag indicating whether the inventory item is a hazardous material — regulatory compliance and safety tracking dimension."
    - name: "valuation_method"
      expr: valuation_method
      comment: "Inventory valuation method (e.g., FIFO, LIFO, Average Cost) — financial reporting dimension for inventory value analysis."
    - name: "cycle_count_frequency"
      expr: cycle_count_frequency
      comment: "Frequency of cycle counts for this inventory item (e.g., Monthly, Quarterly, Annual) — used to assess inventory accuracy program rigor."
  measures:
    - name: "total_inventory_value"
      expr: SUM(CAST(inventory_value AS DOUBLE))
      comment: "Total dollar value of parts inventory on hand — primary working capital metric for maintenance inventory investment management."
    - name: "total_quantity_on_hand"
      expr: SUM(CAST(quantity_on_hand AS DOUBLE))
      comment: "Total quantity of parts on hand across all inventory records — baseline stock level metric for supply availability analysis."
    - name: "total_quantity_on_order"
      expr: SUM(CAST(quantity_on_order AS DOUBLE))
      comment: "Total quantity of parts currently on order — measures replenishment pipeline volume and inbound supply coverage."
    - name: "total_quantity_reserved"
      expr: SUM(CAST(quantity_reserved AS DOUBLE))
      comment: "Total quantity of parts reserved for open work orders — measures committed inventory that is not available for new demand."
    - name: "total_quantity_available"
      expr: SUM(CAST(quantity_available AS DOUBLE))
      comment: "Total quantity of parts available for immediate use (on hand minus reserved) — key availability metric for maintenance planning."
    - name: "below_min_stock_count"
      expr: COUNT(CASE WHEN quantity_on_hand < min_stock_level THEN 1 END)
      comment: "Count of inventory items where quantity on hand is below the minimum stock level — stockout risk metric; high values indicate supply chain gaps that could delay maintenance."
    - name: "total_count_variance_quantity"
      expr: SUM(CAST(count_variance_quantity AS DOUBLE))
      comment: "Total cycle count variance quantity across all inventory items — measures inventory accuracy; large variances indicate shrinkage, theft, or process failures."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost across inventory items — used to benchmark parts procurement efficiency and identify high-cost inventory categories."
    - name: "avg_inventory_value_per_item"
      expr: AVG(CAST(inventory_value AS DOUBLE))
      comment: "Average inventory value per parts record — used to identify high-value inventory items requiring tighter control and cycle count priority."
    - name: "total_annual_usage_quantity"
      expr: SUM(CAST(annual_usage_quantity AS DOUBLE))
      comment: "Total annual usage quantity across all inventory items — demand volume metric used for reorder point optimization and safety stock calculations."
    - name: "distinct_parts_stocked"
      expr: COUNT(DISTINCT parts_catalog_id)
      comment: "Count of distinct parts catalog items stocked in inventory — measures inventory breadth and informs rationalization decisions to reduce SKU complexity."
$$;


CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`maintenance_failure_mode`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Failure mode risk and reliability KPI layer — tracks FMEA risk scores, estimated downtime and cost exposure, regulatory reportability, and safety risk concentration to drive proactive reliability engineering decisions."
  source: "`waste_management_ecm`.`maintenance`.`failure_mode`"
  dimensions:
    - name: "failure_category"
      expr: failure_category
      comment: "Category of the failure mode (e.g., Mechanical, Electrical, Structural) — primary dimension for reliability risk analysis by failure type."
    - name: "failure_mode_group"
      expr: failure_mode_group
      comment: "Grouping of related failure modes — enables aggregate risk analysis across families of related failures."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of the failure mode (e.g., Critical, Major, Minor) — primary risk segmentation dimension for prioritizing corrective actions."
    - name: "component_system"
      expr: component_system
      comment: "The component system associated with the failure mode (e.g., Engine, Hydraulics, Brakes) — enables reliability analysis by asset subsystem."
    - name: "failure_mode_status"
      expr: failure_mode_status
      comment: "Current status of the failure mode record (e.g., Active, Retired, Under Review) — used to filter analysis to current vs. historical failure modes."
    - name: "is_dot_reportable"
      expr: dot_reportable_flag
      comment: "Boolean flag indicating whether the failure mode is DOT-reportable — regulatory compliance dimension for fleet safety risk tracking."
    - name: "is_epa_reportable"
      expr: epa_reportable_flag
      comment: "Boolean flag indicating whether the failure mode is EPA-reportable — environmental regulatory compliance dimension."
    - name: "is_safety_risk"
      expr: safety_risk_flag
      comment: "Boolean flag indicating whether the failure mode poses a safety risk — critical safety management dimension for risk prioritization."
    - name: "is_hazmat"
      expr: hazmat_flag
      comment: "Boolean flag indicating whether the failure mode involves hazardous materials — safety and regulatory compliance dimension."
    - name: "recurrence_risk"
      expr: recurrence_risk
      comment: "Recurrence risk classification of the failure mode (e.g., High, Medium, Low) — used to prioritize PM program investments for chronic failure prevention."
  measures:
    - name: "total_failure_modes"
      expr: COUNT(1)
      comment: "Total number of defined failure modes — baseline metric for reliability program scope and FMEA coverage."
    - name: "total_estimated_downtime_hours"
      expr: SUM(CAST(estimated_downtime_hours AS DOUBLE))
      comment: "Total estimated downtime hours across all failure modes — aggregate availability risk exposure metric used to prioritize reliability investments."
    - name: "total_estimated_parts_cost"
      expr: SUM(CAST(estimated_parts_cost AS DOUBLE))
      comment: "Total estimated parts cost exposure across all failure modes — financial risk metric for maintenance budget planning and parts stocking strategy."
    - name: "avg_mean_time_between_failures"
      expr: AVG(CAST(mean_time_between_failures AS DOUBLE))
      comment: "Average Mean Time Between Failures (MTBF) across failure modes — core reliability metric; higher values indicate more reliable asset performance."
    - name: "avg_mean_time_to_repair"
      expr: AVG(CAST(mean_time_to_repair AS DOUBLE))
      comment: "Average Mean Time To Repair (MTTR) across failure modes — core maintainability metric; lower values indicate faster recovery capability."
    - name: "safety_risk_failure_mode_count"
      expr: COUNT(CASE WHEN safety_risk_flag = TRUE THEN 1 END)
      comment: "Count of failure modes classified as safety risks — measures the safety risk footprint of the asset fleet; drives PPE, LOTO, and training investments."
    - name: "dot_reportable_failure_mode_count"
      expr: COUNT(CASE WHEN dot_reportable_flag = TRUE THEN 1 END)
      comment: "Count of DOT-reportable failure modes — regulatory compliance risk metric for fleet safety management and DOT reporting obligations."
    - name: "epa_reportable_failure_mode_count"
      expr: COUNT(CASE WHEN epa_reportable_flag = TRUE THEN 1 END)
      comment: "Count of EPA-reportable failure modes — environmental regulatory risk metric for compliance program management."
    - name: "avg_estimated_downtime_per_failure_mode"
      expr: AVG(CAST(estimated_downtime_hours AS DOUBLE))
      comment: "Average estimated downtime hours per failure mode — used to benchmark downtime impact severity and prioritize high-impact failure mode mitigation."
$$;
