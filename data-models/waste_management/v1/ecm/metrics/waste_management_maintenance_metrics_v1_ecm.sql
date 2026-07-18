-- Metric views for domain: maintenance | Business: Waste Management | Version: 1 | Generated on: 2026-05-07 19:57:14

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`maintenance_work_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core maintenance work order KPIs tracking labor efficiency, cost performance, downtime impact, and regulatory compliance across all asset types"
  source: "`waste_management_ecm`.`maintenance`.`work_order`"
  dimensions:
    - name: "work_order_status"
      expr: wo_status
      comment: "Current status of the work order (open, in progress, completed, closed)"
    - name: "work_order_priority"
      expr: priority
      comment: "Priority level of the work order (critical, high, medium, low)"
    - name: "work_order_type"
      expr: type_id
      comment: "Type of maintenance work (preventive, corrective, emergency, regulatory)"
    - name: "dot_inspection_flag"
      expr: dot_inspection_flag
      comment: "Whether this work order is related to DOT inspection compliance"
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Whether this work order is driven by regulatory compliance requirements"
    - name: "warranty_claim_flag"
      expr: warranty_claim_flag
      comment: "Whether this work order includes warranty claim activity"
    - name: "loto_required"
      expr: loto_required
      comment: "Whether lockout/tagout procedures are required for safety"
    - name: "requested_year"
      expr: YEAR(requested_date)
      comment: "Year the work order was requested"
    - name: "requested_month"
      expr: DATE_TRUNC('MONTH', requested_date)
      comment: "Month the work order was requested"
    - name: "scheduled_start_year"
      expr: YEAR(scheduled_start_date)
      comment: "Year the work order is scheduled to start"
    - name: "scheduled_start_month"
      expr: DATE_TRUNC('MONTH', scheduled_start_date)
      comment: "Month the work order is scheduled to start"
  measures:
    - name: "total_work_orders"
      expr: COUNT(1)
      comment: "Total number of work orders"
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred across all work orders"
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated cost for all work orders"
    - name: "total_parts_cost"
      expr: SUM(CAST(parts_cost AS DOUBLE))
      comment: "Total cost of parts used across all work orders"
    - name: "total_external_service_cost"
      expr: SUM(CAST(external_service_cost AS DOUBLE))
      comment: "Total cost of external subcontractor services"
    - name: "total_actual_labor_hours"
      expr: SUM(CAST(actual_labor_hours AS DOUBLE))
      comment: "Total actual labor hours spent on work orders"
    - name: "total_estimated_labor_hours"
      expr: SUM(CAST(estimated_labor_hours AS DOUBLE))
      comment: "Total estimated labor hours for work orders"
    - name: "avg_actual_cost_per_work_order"
      expr: AVG(CAST(actual_cost AS DOUBLE))
      comment: "Average actual cost per work order"
    - name: "avg_actual_labor_hours_per_work_order"
      expr: AVG(CAST(actual_labor_hours AS DOUBLE))
      comment: "Average actual labor hours per work order"
    - name: "cost_variance_total"
      expr: SUM((CAST(actual_cost AS DOUBLE)) - (CAST(estimated_cost AS DOUBLE)))
      comment: "Total cost variance (actual minus estimated) across all work orders"
    - name: "labor_hours_variance_total"
      expr: SUM((CAST(actual_labor_hours AS DOUBLE)) - (CAST(estimated_labor_hours AS DOUBLE)))
      comment: "Total labor hours variance (actual minus estimated)"
    - name: "regulatory_compliance_work_orders"
      expr: SUM(CASE WHEN regulatory_compliance_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of work orders driven by regulatory compliance"
    - name: "dot_inspection_work_orders"
      expr: SUM(CASE WHEN dot_inspection_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of work orders related to DOT inspections"
    - name: "warranty_claim_work_orders"
      expr: SUM(CASE WHEN warranty_claim_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of work orders involving warranty claims"
$$;


CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`maintenance_downtime_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Asset downtime and availability KPIs measuring operational impact, response efficiency, and financial consequences of equipment failures"
  source: "`waste_management_ecm`.`maintenance`.`downtime_event`"
  dimensions:
    - name: "downtime_status"
      expr: downtime_status
      comment: "Current status of the downtime event"
    - name: "downtime_category"
      expr: downtime_category
      comment: "Category of downtime (planned, unplanned, emergency)"
    - name: "asset_type"
      expr: asset_type
      comment: "Type of asset experiencing downtime"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level assigned to the downtime event"
    - name: "operational_impact_type"
      expr: operational_impact_type
      comment: "Type of operational impact caused by the downtime"
    - name: "is_repeat_failure"
      expr: is_repeat_failure
      comment: "Whether this is a recurring failure on the same asset"
    - name: "is_dot_inspection_required"
      expr: is_dot_inspection_required
      comment: "Whether DOT inspection is required due to this downtime"
    - name: "downtime_start_year"
      expr: YEAR(downtime_start_timestamp)
      comment: "Year the downtime event started"
    - name: "downtime_start_month"
      expr: DATE_TRUNC('MONTH', downtime_start_timestamp)
      comment: "Month the downtime event started"
  measures:
    - name: "total_downtime_events"
      expr: COUNT(1)
      comment: "Total number of downtime events"
    - name: "total_downtime_hours"
      expr: SUM(CAST(downtime_duration_hours AS DOUBLE))
      comment: "Total hours of asset downtime across all events"
    - name: "total_downtime_cost"
      expr: SUM(CAST(total_downtime_cost AS DOUBLE))
      comment: "Total financial cost of all downtime events"
    - name: "total_lost_revenue"
      expr: SUM(CAST(lost_revenue_estimate AS DOUBLE))
      comment: "Total estimated revenue lost due to downtime"
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost AS DOUBLE))
      comment: "Total labor cost for responding to downtime events"
    - name: "total_parts_cost"
      expr: SUM(CAST(parts_cost AS DOUBLE))
      comment: "Total parts cost for resolving downtime events"
    - name: "total_repair_time_hours"
      expr: SUM(CAST(repair_time_hours AS DOUBLE))
      comment: "Total hours spent on repairs during downtime"
    - name: "total_parts_wait_hours"
      expr: SUM(CAST(parts_wait_hours AS DOUBLE))
      comment: "Total hours waiting for parts during downtime"
    - name: "total_response_time_hours"
      expr: SUM(CAST(response_time_hours AS DOUBLE))
      comment: "Total response time from event report to technician arrival"
    - name: "avg_downtime_hours_per_event"
      expr: AVG(CAST(downtime_duration_hours AS DOUBLE))
      comment: "Average downtime duration per event"
    - name: "avg_downtime_cost_per_event"
      expr: AVG(CAST(total_downtime_cost AS DOUBLE))
      comment: "Average financial cost per downtime event"
    - name: "avg_response_time_hours"
      expr: AVG(CAST(response_time_hours AS DOUBLE))
      comment: "Average response time to downtime events"
    - name: "avg_repair_time_hours"
      expr: AVG(CAST(repair_time_hours AS DOUBLE))
      comment: "Average repair time per downtime event"
    - name: "repeat_failure_events"
      expr: SUM(CASE WHEN is_repeat_failure = TRUE THEN 1 ELSE 0 END)
      comment: "Count of downtime events that are repeat failures"
    - name: "distinct_assets_with_downtime"
      expr: COUNT(DISTINCT COALESCE(CAST(vehicle_id AS STRING), CAST(fixed_asset_id AS STRING), CAST(boiler_unit_id AS STRING), CAST(turbine_generator_id AS STRING)))
      comment: "Number of distinct assets that experienced downtime"
$$;


CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`maintenance_pm_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Preventive maintenance program effectiveness KPIs tracking schedule adherence, cost efficiency, and regulatory compliance"
  source: "`waste_management_ecm`.`maintenance`.`pm_schedule`"
  dimensions:
    - name: "schedule_status"
      expr: schedule_status
      comment: "Current status of the PM schedule (active, suspended, expired)"
    - name: "asset_category"
      expr: asset_category
      comment: "Category of asset covered by this PM schedule"
    - name: "work_order_type"
      expr: work_order_type
      comment: "Type of work order generated by this PM schedule"
    - name: "priority"
      expr: priority
      comment: "Priority level of the PM schedule"
    - name: "frequency_unit"
      expr: frequency_unit
      comment: "Unit of frequency for PM execution (days, hours, miles)"
    - name: "is_dot_inspection"
      expr: is_dot_inspection
      comment: "Whether this PM schedule is for DOT inspection compliance"
    - name: "is_epa_required"
      expr: is_epa_required
      comment: "Whether this PM schedule is required by EPA regulations"
    - name: "is_osha_required"
      expr: is_osha_required
      comment: "Whether this PM schedule is required by OSHA regulations"
    - name: "auto_wo_generation"
      expr: auto_wo_generation
      comment: "Whether work orders are automatically generated from this schedule"
    - name: "next_due_year"
      expr: YEAR(next_due_date)
      comment: "Year the next PM is due"
    - name: "next_due_month"
      expr: DATE_TRUNC('MONTH', next_due_date)
      comment: "Month the next PM is due"
    - name: "last_performed_year"
      expr: YEAR(last_performed_date)
      comment: "Year the PM was last performed"
  measures:
    - name: "total_pm_schedules"
      expr: COUNT(1)
      comment: "Total number of preventive maintenance schedules"
    - name: "total_estimated_labor_cost"
      expr: SUM(CAST(estimated_labor_cost AS DOUBLE))
      comment: "Total estimated labor cost for all PM schedules"
    - name: "total_estimated_parts_cost"
      expr: SUM(CAST(estimated_parts_cost AS DOUBLE))
      comment: "Total estimated parts cost for all PM schedules"
    - name: "total_estimated_duration_hours"
      expr: SUM(CAST(estimated_duration_hours AS DOUBLE))
      comment: "Total estimated duration hours for all PM activities"
    - name: "avg_estimated_labor_cost_per_schedule"
      expr: AVG(CAST(estimated_labor_cost AS DOUBLE))
      comment: "Average estimated labor cost per PM schedule"
    - name: "avg_estimated_parts_cost_per_schedule"
      expr: AVG(CAST(estimated_parts_cost AS DOUBLE))
      comment: "Average estimated parts cost per PM schedule"
    - name: "avg_estimated_duration_hours_per_schedule"
      expr: AVG(CAST(estimated_duration_hours AS DOUBLE))
      comment: "Average estimated duration per PM schedule"
    - name: "regulatory_pm_schedules"
      expr: SUM(CASE WHEN is_epa_required = TRUE OR is_osha_required = TRUE OR is_dot_inspection = TRUE THEN 1 ELSE 0 END)
      comment: "Count of PM schedules driven by regulatory requirements"
    - name: "dot_inspection_schedules"
      expr: SUM(CASE WHEN is_dot_inspection = TRUE THEN 1 ELSE 0 END)
      comment: "Count of PM schedules for DOT inspections"
    - name: "epa_required_schedules"
      expr: SUM(CASE WHEN is_epa_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of PM schedules required by EPA"
    - name: "osha_required_schedules"
      expr: SUM(CASE WHEN is_osha_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of PM schedules required by OSHA"
    - name: "auto_generated_wo_schedules"
      expr: SUM(CASE WHEN auto_wo_generation = TRUE THEN 1 ELSE 0 END)
      comment: "Count of PM schedules with automatic work order generation enabled"
    - name: "distinct_assets_on_pm"
      expr: COUNT(DISTINCT COALESCE(CAST(vehicle_id AS STRING), CAST(fixed_asset_id AS STRING), CAST(boiler_unit_id AS STRING), CAST(turbine_generator_id AS STRING), CAST(site_id AS STRING)))
      comment: "Number of distinct assets covered by PM schedules"
$$;


CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`maintenance_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Maintenance budget performance KPIs tracking spend variance, budget utilization, and cost control across maintenance categories"
  source: "`waste_management_ecm`.`maintenance`.`budget`"
  dimensions:
    - name: "budget_status"
      expr: budget_status
      comment: "Current status of the budget (approved, pending, revised, closed)"
    - name: "maintenance_category"
      expr: maintenance_category
      comment: "Category of maintenance covered by this budget"
    - name: "asset_class"
      expr: asset_class
      comment: "Class of assets covered by this budget"
    - name: "budget_source"
      expr: budget_source
      comment: "Source of budget funding"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the budget"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period within the year"
    - name: "region_code"
      expr: region_code
      comment: "Geographic region for this budget"
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost center responsible for this budget"
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Whether this budget is for regulatory compliance activities"
    - name: "dot_inspection_budget_flag"
      expr: dot_inspection_budget_flag
      comment: "Whether this budget is allocated for DOT inspections"
  measures:
    - name: "total_budgets"
      expr: COUNT(1)
      comment: "Total number of maintenance budgets"
    - name: "total_original_budget"
      expr: SUM(CAST(original_budget_amount AS DOUBLE))
      comment: "Total original budget amount allocated"
    - name: "total_revised_budget"
      expr: SUM(CAST(revised_budget_amount AS DOUBLE))
      comment: "Total revised budget amount after adjustments"
    - name: "total_actual_spend"
      expr: SUM(CAST(actual_spend_amount AS DOUBLE))
      comment: "Total actual spend against budgets"
    - name: "total_remaining_budget"
      expr: SUM(CAST(remaining_budget_amount AS DOUBLE))
      comment: "Total remaining budget available"
    - name: "total_encumbered_amount"
      expr: SUM(CAST(encumbered_amount AS DOUBLE))
      comment: "Total amount encumbered (committed but not yet spent)"
    - name: "total_labor_budget"
      expr: SUM(CAST(labor_budget_amount AS DOUBLE))
      comment: "Total budget allocated for labor"
    - name: "total_parts_budget"
      expr: SUM(CAST(parts_budget_amount AS DOUBLE))
      comment: "Total budget allocated for parts"
    - name: "total_subcontract_budget"
      expr: SUM(CAST(subcontract_budget_amount AS DOUBLE))
      comment: "Total budget allocated for subcontractor services"
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total budget variance (actual vs revised budget)"
    - name: "avg_spend_to_budget_pct"
      expr: AVG(CAST(spend_to_budget_pct AS DOUBLE))
      comment: "Average percentage of budget spent"
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average variance percentage across budgets"
    - name: "regulatory_compliance_budgets"
      expr: SUM(CASE WHEN regulatory_compliance_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of budgets allocated for regulatory compliance"
    - name: "dot_inspection_budgets"
      expr: SUM(CASE WHEN dot_inspection_budget_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of budgets allocated for DOT inspections"
$$;


CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`maintenance_parts_usage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Parts consumption and inventory efficiency KPIs tracking usage patterns, cost control, and reorder triggers"
  source: "`waste_management_ecm`.`maintenance`.`parts_usage`"
  dimensions:
    - name: "issue_status"
      expr: issue_status
      comment: "Status of the parts issue transaction"
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of parts transaction (issue, return, adjustment)"
    - name: "part_category"
      expr: part_category
      comment: "Category of part used"
    - name: "asset_type"
      expr: asset_type
      comment: "Type of asset the part was used on"
    - name: "work_order_type"
      expr: work_order_type
      comment: "Type of work order the part was used for"
    - name: "dot_inspection_related"
      expr: dot_inspection_related
      comment: "Whether the parts usage is related to DOT inspection"
    - name: "hazmat_part_flag"
      expr: hazmat_part_flag
      comment: "Whether the part is classified as hazardous material"
    - name: "warranty_claim_flag"
      expr: warranty_claim_flag
      comment: "Whether the parts usage is part of a warranty claim"
    - name: "reorder_triggered_flag"
      expr: reorder_triggered_flag
      comment: "Whether this usage triggered a reorder point"
    - name: "issue_year"
      expr: YEAR(issue_date)
      comment: "Year the part was issued"
    - name: "issue_month"
      expr: DATE_TRUNC('MONTH', issue_date)
      comment: "Month the part was issued"
  measures:
    - name: "total_parts_transactions"
      expr: COUNT(1)
      comment: "Total number of parts usage transactions"
    - name: "total_parts_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total cost of all parts used"
    - name: "total_quantity_issued"
      expr: SUM(CAST(quantity_issued AS DOUBLE))
      comment: "Total quantity of parts issued"
    - name: "total_quantity_requested"
      expr: SUM(CAST(quantity_requested AS DOUBLE))
      comment: "Total quantity of parts requested"
    - name: "total_quantity_returned"
      expr: SUM(CAST(quantity_returned AS DOUBLE))
      comment: "Total quantity of parts returned to inventory"
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost per part"
    - name: "avg_parts_cost_per_transaction"
      expr: AVG(CAST(total_cost AS DOUBLE))
      comment: "Average total cost per parts transaction"
    - name: "distinct_parts_used"
      expr: COUNT(DISTINCT part_number)
      comment: "Number of distinct part numbers used"
    - name: "distinct_work_orders_with_parts"
      expr: COUNT(DISTINCT work_order_id)
      comment: "Number of distinct work orders that consumed parts"
    - name: "hazmat_parts_transactions"
      expr: SUM(CASE WHEN hazmat_part_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of transactions involving hazardous material parts"
    - name: "warranty_claim_parts_transactions"
      expr: SUM(CASE WHEN warranty_claim_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of parts transactions related to warranty claims"
    - name: "reorder_triggered_transactions"
      expr: SUM(CASE WHEN reorder_triggered_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of transactions that triggered inventory reorder"
$$;


CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`maintenance_technician_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Technician productivity and labor efficiency KPIs tracking utilization, overtime, and skill deployment"
  source: "`waste_management_ecm`.`maintenance`.`technician_assignment`"
  dimensions:
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current status of the technician assignment"
    - name: "assignment_type"
      expr: assignment_type
      comment: "Type of assignment (scheduled, emergency, callback)"
    - name: "work_order_type"
      expr: work_order_type
      comment: "Type of work order assigned"
    - name: "work_order_priority"
      expr: work_order_priority
      comment: "Priority level of the assigned work order"
    - name: "asset_type"
      expr: asset_type
      comment: "Type of asset being worked on"
    - name: "craft_code"
      expr: craft_code
      comment: "Craft or trade code of the technician"
    - name: "skill_level"
      expr: skill_level
      comment: "Skill level of the technician"
    - name: "shift_code"
      expr: shift_code
      comment: "Shift during which the work was performed"
    - name: "dot_inspection_flag"
      expr: dot_inspection_flag
      comment: "Whether the assignment is for DOT inspection work"
    - name: "hazmat_work_flag"
      expr: hazmat_work_flag
      comment: "Whether the assignment involves hazardous materials"
    - name: "labor_confirmed_flag"
      expr: labor_confirmed_flag
      comment: "Whether the labor hours have been confirmed"
    - name: "scheduled_start_year"
      expr: YEAR(scheduled_start_datetime)
      comment: "Year the assignment was scheduled to start"
    - name: "scheduled_start_month"
      expr: DATE_TRUNC('MONTH', scheduled_start_datetime)
      comment: "Month the assignment was scheduled to start"
  measures:
    - name: "total_assignments"
      expr: COUNT(1)
      comment: "Total number of technician assignments"
    - name: "total_actual_labor_hours"
      expr: SUM(CAST(actual_labor_hours AS DOUBLE))
      comment: "Total actual labor hours worked"
    - name: "total_scheduled_labor_hours"
      expr: SUM(CAST(scheduled_labor_hours AS DOUBLE))
      comment: "Total scheduled labor hours"
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours worked"
    - name: "total_travel_time_hours"
      expr: SUM(CAST(travel_time_hours AS DOUBLE))
      comment: "Total travel time hours"
    - name: "total_downtime_hours"
      expr: SUM(CAST(downtime_hours AS DOUBLE))
      comment: "Total asset downtime hours during assignments"
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost AS DOUBLE))
      comment: "Total labor cost for all assignments"
    - name: "avg_actual_labor_hours_per_assignment"
      expr: AVG(CAST(actual_labor_hours AS DOUBLE))
      comment: "Average actual labor hours per assignment"
    - name: "avg_labor_cost_per_assignment"
      expr: AVG(CAST(labor_cost AS DOUBLE))
      comment: "Average labor cost per assignment"
    - name: "avg_labor_rate"
      expr: AVG(CAST(labor_rate AS DOUBLE))
      comment: "Average labor rate per hour"
    - name: "labor_hours_variance_total"
      expr: SUM((CAST(actual_labor_hours AS DOUBLE)) - (CAST(scheduled_labor_hours AS DOUBLE)))
      comment: "Total variance between actual and scheduled labor hours"
    - name: "distinct_technicians"
      expr: COUNT(DISTINCT employee_id)
      comment: "Number of distinct technicians assigned"
    - name: "distinct_work_orders"
      expr: COUNT(DISTINCT work_order_id)
      comment: "Number of distinct work orders with technician assignments"
    - name: "hazmat_work_assignments"
      expr: SUM(CASE WHEN hazmat_work_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of assignments involving hazardous materials work"
    - name: "confirmed_labor_assignments"
      expr: SUM(CASE WHEN labor_confirmed_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of assignments with confirmed labor hours"
$$;


CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`maintenance_warranty_claim`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Warranty recovery and claim management KPIs tracking claim success rates, reimbursement efficiency, and vendor performance"
  source: "`waste_management_ecm`.`maintenance`.`warranty_claim`"
  dimensions:
    - name: "claim_status"
      expr: claim_status
      comment: "Current status of the warranty claim (submitted, approved, denied, paid)"
    - name: "coverage_type"
      expr: coverage_type
      comment: "Type of warranty coverage (manufacturer, extended, service contract)"
    - name: "appeal_flag"
      expr: appeal_flag
      comment: "Whether the claim has been appealed"
    - name: "appeal_outcome"
      expr: appeal_outcome
      comment: "Outcome of the appeal process"
    - name: "denial_reason_code"
      expr: denial_reason_code
      comment: "Code indicating reason for claim denial"
    - name: "return_required_flag"
      expr: return_required_flag
      comment: "Whether failed part return is required for claim"
    - name: "dot_inspection_related_flag"
      expr: dot_inspection_related_flag
      comment: "Whether the claim is related to DOT inspection findings"
    - name: "submission_year"
      expr: YEAR(submission_date)
      comment: "Year the claim was submitted"
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_date)
      comment: "Month the claim was submitted"
    - name: "failure_year"
      expr: YEAR(failure_date)
      comment: "Year the failure occurred"
  measures:
    - name: "total_warranty_claims"
      expr: COUNT(1)
      comment: "Total number of warranty claims submitted"
    - name: "total_claimed_amount"
      expr: SUM(CAST(claimed_amount AS DOUBLE))
      comment: "Total amount claimed across all warranty claims"
    - name: "total_approved_amount"
      expr: SUM(CAST(approved_amount AS DOUBLE))
      comment: "Total amount approved by warranty providers"
    - name: "total_reimbursed_amount"
      expr: SUM(CAST(reimbursed_amount AS DOUBLE))
      comment: "Total amount actually reimbursed to date"
    - name: "total_labor_cost_claimed"
      expr: SUM(CAST(labor_cost_claimed AS DOUBLE))
      comment: "Total labor cost claimed in warranty claims"
    - name: "total_parts_cost_claimed"
      expr: SUM(CAST(parts_cost_claimed AS DOUBLE))
      comment: "Total parts cost claimed in warranty claims"
    - name: "avg_claimed_amount_per_claim"
      expr: AVG(CAST(claimed_amount AS DOUBLE))
      comment: "Average amount claimed per warranty claim"
    - name: "avg_approved_amount_per_claim"
      expr: AVG(CAST(approved_amount AS DOUBLE))
      comment: "Average amount approved per warranty claim"
    - name: "avg_reimbursed_amount_per_claim"
      expr: AVG(CAST(reimbursed_amount AS DOUBLE))
      comment: "Average amount reimbursed per warranty claim"
    - name: "distinct_vendors"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of distinct warranty providers/vendors"
    - name: "distinct_assets_with_claims"
      expr: COUNT(DISTINCT COALESCE(CAST(vehicle_id AS STRING), CAST(fixed_asset_id AS STRING)))
      comment: "Number of distinct assets with warranty claims"
    - name: "appealed_claims"
      expr: SUM(CASE WHEN appeal_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of warranty claims that were appealed"
    - name: "claims_requiring_part_return"
      expr: SUM(CASE WHEN return_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of claims requiring failed part return"
$$;
