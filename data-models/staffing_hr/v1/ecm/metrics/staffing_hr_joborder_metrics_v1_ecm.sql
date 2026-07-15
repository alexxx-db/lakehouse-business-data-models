-- Metric views for domain: joborder | Business: Staffing Hr | Version: 1 | Generated on: 2026-05-02 15:43:14

CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`joborder_order_header`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core job order performance metrics tracking order volume, fill rates, time-to-fill, and rate economics across client accounts, locations, and job categories"
  source: "`staffing_hr_ecm`.`joborder`.`order_header`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the job order (open, filled, cancelled, on-hold)"
    - name: "employment_classification"
      expr: employment_classification
      comment: "Worker classification type (W2, 1099, temp, temp-to-perm, permanent)"
    - name: "position_type"
      expr: position_type
      comment: "Type of position being filled (contract, direct hire, contract-to-hire)"
    - name: "priority_level"
      expr: priority_level
      comment: "Business priority level of the order (critical, high, medium, low)"
    - name: "work_location_type"
      expr: work_location_type
      comment: "Work arrangement type (on-site, remote, hybrid)"
    - name: "shift_type"
      expr: shift_type
      comment: "Shift schedule type (day, night, swing, rotating)"
    - name: "originating_source"
      expr: originating_source
      comment: "Source channel where the order originated (VMS, direct, MSP, referral)"
    - name: "is_temp_to_perm"
      expr: is_temp_to_perm
      comment: "Flag indicating if position has temp-to-perm conversion option"
    - name: "is_backfill"
      expr: is_backfill
      comment: "Flag indicating if order is backfilling a previous placement"
    - name: "intake_month"
      expr: DATE_TRUNC('MONTH', intake_date)
      comment: "Month when order was received (intake date truncated to month)"
    - name: "intake_quarter"
      expr: DATE_TRUNC('QUARTER', intake_date)
      comment: "Quarter when order was received"
    - name: "target_start_month"
      expr: DATE_TRUNC('MONTH', target_start_date)
      comment: "Target month for assignment start"
    - name: "assignment_end_month"
      expr: DATE_TRUNC('MONTH', assignment_end_date)
      comment: "Planned assignment end month"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for all rate and financial fields"
    - name: "bgc_required"
      expr: bgc_required
      comment: "Flag indicating if background check is required"
    - name: "drug_screen_required"
      expr: drug_screen_required
      comment: "Flag indicating if drug screening is required"
    - name: "clearance_required"
      expr: clearance_required
      comment: "Security clearance level required (if any)"
  measures:
    - name: "total_orders"
      expr: COUNT(1)
      comment: "Total number of job orders"
    - name: "total_headcount_target"
      expr: SUM(CAST(headcount_target AS DOUBLE))
      comment: "Total target headcount across all orders"
    - name: "total_headcount_filled"
      expr: SUM(CAST(headcount_filled AS DOUBLE))
      comment: "Total headcount filled across all orders"
    - name: "total_headcount_remaining"
      expr: SUM(CAST(headcount_remaining AS DOUBLE))
      comment: "Total unfilled headcount remaining across all orders"
    - name: "avg_bill_rate"
      expr: AVG(CAST(bill_rate AS DOUBLE))
      comment: "Average bill rate per hour across orders"
    - name: "avg_pay_rate"
      expr: AVG(CAST(pay_rate AS DOUBLE))
      comment: "Average pay rate per hour across orders"
    - name: "avg_markup_percentage"
      expr: AVG(CAST(markup_percentage AS DOUBLE))
      comment: "Average markup percentage across orders"
    - name: "avg_spread"
      expr: AVG(CAST(bill_rate AS DOUBLE) - CAST(pay_rate AS DOUBLE))
      comment: "Average gross margin spread (bill rate minus pay rate) per hour"
    - name: "total_conversion_fees"
      expr: SUM(CAST(conversion_fee AS DOUBLE))
      comment: "Total conversion fees for temp-to-perm conversions"
    - name: "avg_hours_per_week"
      expr: AVG(CAST(hours_per_week AS DOUBLE))
      comment: "Average weekly hours per order"
    - name: "avg_ot_bill_rate"
      expr: AVG(CAST(ot_bill_rate AS DOUBLE))
      comment: "Average overtime bill rate per hour"
    - name: "avg_ot_pay_rate"
      expr: AVG(CAST(ot_pay_rate AS DOUBLE))
      comment: "Average overtime pay rate per hour"
    - name: "avg_per_diem_rate"
      expr: AVG(CAST(per_diem_rate AS DOUBLE))
      comment: "Average per diem allowance rate"
    - name: "distinct_clients"
      expr: COUNT(DISTINCT client_account_id)
      comment: "Number of distinct client accounts with orders"
    - name: "distinct_client_locations"
      expr: COUNT(DISTINCT location_id)
      comment: "Number of distinct client work locations"
    - name: "distinct_suppliers"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of distinct suppliers engaged on orders"
$$;


CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`joborder_fte_actuals`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce capacity and utilization metrics tracking actual FTE deployment, hours worked, attrition, and financial performance against plan"
  source: "`staffing_hr_ecm`.`joborder`.`fte_actuals`"
  dimensions:
    - name: "snapshot_month"
      expr: DATE_TRUNC('MONTH', snapshot_date)
      comment: "Month of the FTE snapshot"
    - name: "snapshot_quarter"
      expr: DATE_TRUNC('QUARTER', snapshot_date)
      comment: "Quarter of the FTE snapshot"
    - name: "snapshot_year"
      expr: YEAR(snapshot_date)
      comment: "Year of the FTE snapshot"
    - name: "snapshot_period_type"
      expr: snapshot_period_type
      comment: "Period type of snapshot (daily, weekly, monthly, quarterly)"
    - name: "snapshot_status"
      expr: snapshot_status
      comment: "Status of the snapshot (preliminary, final, adjusted)"
    - name: "worker_classification"
      expr: worker_classification
      comment: "Worker classification (W2, 1099, contractor, employee)"
    - name: "workforce_mix_type"
      expr: workforce_mix_type
      comment: "Workforce mix category (contingent, permanent, hybrid)"
    - name: "work_location_type"
      expr: work_location_type
      comment: "Work arrangement (on-site, remote, hybrid)"
    - name: "shift_type"
      expr: shift_type
      comment: "Shift schedule type"
    - name: "department_name"
      expr: department_name
      comment: "Department or business unit name"
    - name: "union_status"
      expr: union_status
      comment: "Union membership status (union, non-union)"
    - name: "data_source"
      expr: data_source
      comment: "Source system of the FTE data"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for financial metrics"
  measures:
    - name: "total_actual_fte"
      expr: SUM(CAST(actual_fte AS DOUBLE))
      comment: "Total actual full-time equivalent headcount"
    - name: "total_planned_fte"
      expr: SUM(CAST(planned_fte AS DOUBLE))
      comment: "Total planned full-time equivalent headcount"
    - name: "total_actual_headcount"
      expr: SUM(CAST(actual_headcount AS DOUBLE))
      comment: "Total actual headcount (individual workers)"
    - name: "total_fte_variance"
      expr: SUM(CAST(fte_variance AS DOUBLE))
      comment: "Total FTE variance (actual minus planned)"
    - name: "avg_fte_variance_percentage"
      expr: AVG(CAST(fte_variance_percentage AS DOUBLE))
      comment: "Average FTE variance as percentage of plan"
    - name: "avg_utilization_rate"
      expr: AVG(CAST(utilization_rate AS DOUBLE))
      comment: "Average utilization rate (billable hours / total hours)"
    - name: "avg_attrition_rate"
      expr: AVG(CAST(attrition_rate AS DOUBLE))
      comment: "Average attrition rate percentage"
    - name: "total_billable_hours"
      expr: SUM(CAST(billable_hours AS DOUBLE))
      comment: "Total billable hours worked"
    - name: "total_non_billable_hours"
      expr: SUM(CAST(non_billable_hours AS DOUBLE))
      comment: "Total non-billable hours (bench, training, PTO)"
    - name: "total_hours_worked"
      expr: SUM(CAST(total_hours_worked AS DOUBLE))
      comment: "Total hours worked (all types)"
    - name: "total_regular_hours"
      expr: SUM(CAST(regular_hours AS DOUBLE))
      comment: "Total regular hours worked"
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours worked"
    - name: "total_double_time_hours"
      expr: SUM(CAST(double_time_hours AS DOUBLE))
      comment: "Total double-time hours worked"
    - name: "total_new_hires"
      expr: SUM(CAST(new_hire_count AS DOUBLE))
      comment: "Total new hires in period"
    - name: "total_terminations"
      expr: SUM(CAST(termination_count AS DOUBLE))
      comment: "Total terminations in period"
    - name: "total_redeployments"
      expr: SUM(CAST(redeployment_count AS DOUBLE))
      comment: "Total workers redeployed to new assignments"
    - name: "total_bench_count"
      expr: SUM(CAST(bench_count AS DOUBLE))
      comment: "Total workers on bench (available but not assigned)"
    - name: "total_projected_revenue"
      expr: SUM(CAST(projected_revenue AS DOUBLE))
      comment: "Total projected revenue for the period"
    - name: "total_projected_cost"
      expr: SUM(CAST(projected_cost AS DOUBLE))
      comment: "Total projected cost for the period"
    - name: "total_projected_gross_margin"
      expr: SUM(CAST(projected_gross_margin AS DOUBLE))
      comment: "Total projected gross margin (revenue minus cost)"
    - name: "avg_bill_rate"
      expr: AVG(CAST(average_bill_rate AS DOUBLE))
      comment: "Average bill rate per hour"
    - name: "avg_pay_rate"
      expr: AVG(CAST(average_pay_rate AS DOUBLE))
      comment: "Average pay rate per hour"
    - name: "avg_markup_percentage"
      expr: AVG(CAST(average_markup_percentage AS DOUBLE))
      comment: "Average markup percentage"
    - name: "avg_spread"
      expr: AVG(CAST(average_spread AS DOUBLE))
      comment: "Average gross margin spread per hour"
    - name: "distinct_clients"
      expr: COUNT(DISTINCT client_account_id)
      comment: "Number of distinct client accounts"
    - name: "distinct_suppliers"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of distinct suppliers"
    - name: "distinct_programs"
      expr: COUNT(DISTINCT managed_program_id)
      comment: "Number of distinct managed programs"
$$;


CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`joborder_headcount_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Headcount planning and budgeting metrics tracking target headcount, budget allocation, approval status, and rate targets by client and job category"
  source: "`staffing_hr_ecm`.`joborder`.`headcount_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the headcount plan (draft, submitted, approved, rejected, active, closed)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status"
    - name: "plan_type"
      expr: plan_type
      comment: "Type of headcount plan (annual, quarterly, project-based, ad-hoc)"
    - name: "employment_type"
      expr: employment_type
      comment: "Employment type for planned headcount (temp, temp-to-perm, permanent)"
    - name: "worker_classification"
      expr: worker_classification
      comment: "Worker classification (W2, 1099, contractor)"
    - name: "work_location_type"
      expr: work_location_type
      comment: "Work arrangement type (on-site, remote, hybrid)"
    - name: "shift_type"
      expr: shift_type
      comment: "Shift schedule type"
    - name: "priority_level"
      expr: priority_level
      comment: "Business priority level of the plan"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the plan"
    - name: "rate_type"
      expr: rate_type
      comment: "Rate unit type (hourly, daily, weekly, monthly, annual)"
    - name: "is_active"
      expr: is_active
      comment: "Flag indicating if plan is currently active"
    - name: "planning_period_start_month"
      expr: DATE_TRUNC('MONTH', planning_period_start_date)
      comment: "Start month of planning period"
    - name: "planning_period_end_month"
      expr: DATE_TRUNC('MONTH', planning_period_end_date)
      comment: "End month of planning period"
    - name: "approval_month"
      expr: DATE_TRUNC('MONTH', approval_date)
      comment: "Month when plan was approved"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for budget and rate fields"
    - name: "supplier_diversity_requirement"
      expr: supplier_diversity_requirement
      comment: "Supplier diversity requirement level"
  measures:
    - name: "total_plans"
      expr: COUNT(1)
      comment: "Total number of headcount plans"
    - name: "total_target_headcount"
      expr: SUM(CAST(target_headcount AS DOUBLE))
      comment: "Total target headcount across all plans"
    - name: "total_minimum_headcount"
      expr: SUM(CAST(minimum_headcount AS DOUBLE))
      comment: "Total minimum acceptable headcount"
    - name: "total_maximum_headcount"
      expr: SUM(CAST(maximum_headcount AS DOUBLE))
      comment: "Total maximum allowable headcount"
    - name: "total_current_filled_headcount"
      expr: SUM(CAST(current_filled_headcount AS DOUBLE))
      comment: "Total currently filled headcount"
    - name: "total_remaining_headcount"
      expr: SUM(CAST(remaining_headcount AS DOUBLE))
      comment: "Total remaining headcount to fill"
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budget allocated across all plans"
    - name: "avg_target_bill_rate"
      expr: AVG(CAST(target_bill_rate AS DOUBLE))
      comment: "Average target bill rate per hour"
    - name: "avg_target_pay_rate"
      expr: AVG(CAST(target_pay_rate AS DOUBLE))
      comment: "Average target pay rate per hour"
    - name: "avg_target_markup_percentage"
      expr: AVG(CAST(target_markup_percentage AS DOUBLE))
      comment: "Average target markup percentage"
    - name: "avg_target_gross_margin_percentage"
      expr: AVG(CAST(target_gross_margin_percentage AS DOUBLE))
      comment: "Average target gross margin percentage"
    - name: "avg_fte_percentage"
      expr: AVG(CAST(fte_percentage AS DOUBLE))
      comment: "Average FTE percentage (for part-time positions)"
    - name: "avg_hours_per_week"
      expr: AVG(CAST(hours_per_week AS DOUBLE))
      comment: "Average planned hours per week"
    - name: "distinct_clients"
      expr: COUNT(DISTINCT client_account_id)
      comment: "Number of distinct client accounts in plans"
    - name: "distinct_suppliers"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of distinct suppliers in plans"
    - name: "distinct_job_categories"
      expr: COUNT(DISTINCT job_category_id)
      comment: "Number of distinct job categories planned"
    - name: "distinct_programs"
      expr: COUNT(DISTINCT managed_program_id)
      comment: "Number of distinct managed programs"
$$;


CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`joborder_demand_forecast`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Demand forecasting metrics tracking projected headcount needs, revenue, cost, and talent availability across forecast periods and confidence levels"
  source: "`staffing_hr_ecm`.`joborder`.`demand_forecast`"
  dimensions:
    - name: "forecast_status"
      expr: forecast_status
      comment: "Current status of the forecast (draft, submitted, approved, active, archived)"
    - name: "forecast_method"
      expr: forecast_method
      comment: "Forecasting methodology used (statistical, judgmental, hybrid, ML-based)"
    - name: "forecast_confidence_level"
      expr: forecast_confidence_level
      comment: "Confidence level of the forecast (high, medium, low)"
    - name: "forecast_granularity"
      expr: forecast_granularity
      comment: "Time granularity of forecast (weekly, monthly, quarterly, annual)"
    - name: "employment_type"
      expr: employment_type
      comment: "Employment type forecasted (temp, temp-to-perm, permanent)"
    - name: "worker_classification"
      expr: worker_classification
      comment: "Worker classification (W2, 1099, contractor)"
    - name: "work_location_type"
      expr: work_location_type
      comment: "Work arrangement type (on-site, remote, hybrid)"
    - name: "shift_type"
      expr: shift_type
      comment: "Shift schedule type"
    - name: "skill_category"
      expr: skill_category
      comment: "Skill category or job family"
    - name: "market_demand_indicator"
      expr: market_demand_indicator
      comment: "Market demand level indicator (high, medium, low, declining)"
    - name: "is_active"
      expr: is_active
      comment: "Flag indicating if forecast is currently active"
    - name: "forecast_period_start_month"
      expr: DATE_TRUNC('MONTH', forecast_period_start_date)
      comment: "Start month of forecast period"
    - name: "forecast_period_end_month"
      expr: DATE_TRUNC('MONTH', forecast_period_end_date)
      comment: "End month of forecast period"
    - name: "forecast_created_month"
      expr: DATE_TRUNC('MONTH', forecast_created_date)
      comment: "Month when forecast was created"
    - name: "forecast_approved_month"
      expr: DATE_TRUNC('MONTH', forecast_approved_date)
      comment: "Month when forecast was approved"
    - name: "rate_currency_code"
      expr: rate_currency_code
      comment: "Currency code for rate and financial fields"
    - name: "rate_unit"
      expr: rate_unit
      comment: "Rate unit (hourly, daily, weekly, monthly)"
    - name: "data_source"
      expr: data_source
      comment: "Source system or method of forecast data"
  measures:
    - name: "total_forecasts"
      expr: COUNT(1)
      comment: "Total number of demand forecasts"
    - name: "total_forecasted_headcount"
      expr: SUM(CAST(forecasted_headcount AS DOUBLE))
      comment: "Total forecasted headcount demand"
    - name: "total_forecasted_fte"
      expr: SUM(CAST(forecasted_fte AS DOUBLE))
      comment: "Total forecasted full-time equivalent demand"
    - name: "total_baseline_headcount"
      expr: SUM(CAST(baseline_headcount AS DOUBLE))
      comment: "Total baseline headcount (current state)"
    - name: "avg_demand_variance_percentage"
      expr: AVG(CAST(demand_variance_percentage AS DOUBLE))
      comment: "Average demand variance percentage from baseline"
    - name: "total_projected_revenue"
      expr: SUM(CAST(projected_revenue AS DOUBLE))
      comment: "Total projected revenue from forecasted demand"
    - name: "total_projected_cost"
      expr: SUM(CAST(projected_cost AS DOUBLE))
      comment: "Total projected cost for forecasted demand"
    - name: "total_projected_gross_margin"
      expr: SUM(CAST(projected_gross_margin AS DOUBLE))
      comment: "Total projected gross margin (revenue minus cost)"
    - name: "avg_bill_rate"
      expr: AVG(CAST(average_bill_rate AS DOUBLE))
      comment: "Average forecasted bill rate per hour"
    - name: "avg_pay_rate"
      expr: AVG(CAST(average_pay_rate AS DOUBLE))
      comment: "Average forecasted pay rate per hour"
    - name: "avg_talent_availability_score"
      expr: AVG(CAST(talent_availability_score AS DOUBLE))
      comment: "Average talent availability score (market supply indicator)"
    - name: "distinct_clients"
      expr: COUNT(DISTINCT client_account_id)
      comment: "Number of distinct client accounts in forecasts"
    - name: "distinct_suppliers"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of distinct suppliers in forecasts"
    - name: "distinct_job_categories"
      expr: COUNT(DISTINCT job_category_id)
      comment: "Number of distinct job categories forecasted"
    - name: "distinct_programs"
      expr: COUNT(DISTINCT managed_program_id)
      comment: "Number of distinct managed programs"
$$;


CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`joborder_capacity_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce capacity planning metrics tracking available capacity, utilization, demand gaps, and sourcing pipeline by skill pool and geography"
  source: "`staffing_hr_ecm`.`joborder`.`capacity_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the capacity plan (draft, approved, active, closed)"
    - name: "plan_type"
      expr: plan_type
      comment: "Type of capacity plan (strategic, tactical, operational)"
    - name: "approval_required_flag"
      expr: approval_required_flag
      comment: "Flag indicating if plan requires approval"
    - name: "skill_pool_name"
      expr: skill_pool_name
      comment: "Name of the skill pool or talent pool"
    - name: "labor_category"
      expr: labor_category
      comment: "Labor category or job family"
    - name: "geography_type"
      expr: geography_type
      comment: "Geographic scope type (national, regional, metro, local)"
    - name: "country_code"
      expr: country_code
      comment: "Country code for capacity planning"
    - name: "state_province"
      expr: state_province
      comment: "State or province"
    - name: "metro_area"
      expr: metro_area
      comment: "Metropolitan area"
    - name: "rate_type"
      expr: rate_type
      comment: "Rate unit type (hourly, daily, weekly, monthly)"
    - name: "planning_period_start_month"
      expr: DATE_TRUNC('MONTH', planning_period_start_date)
      comment: "Start month of planning period"
    - name: "planning_period_end_month"
      expr: DATE_TRUNC('MONTH', planning_period_end_date)
      comment: "End month of planning period"
    - name: "approval_month"
      expr: DATE_TRUNC('MONTH', approval_date)
      comment: "Month when plan was approved"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for rate fields"
    - name: "onet_code"
      expr: onet_code
      comment: "O*NET occupation code"
    - name: "soc_code"
      expr: soc_code
      comment: "Standard Occupational Classification code"
  measures:
    - name: "total_capacity_plans"
      expr: COUNT(1)
      comment: "Total number of capacity plans"
    - name: "total_available_capacity_fte"
      expr: SUM(CAST(available_capacity_fte AS DOUBLE))
      comment: "Total available capacity in FTE"
    - name: "total_committed_capacity_fte"
      expr: SUM(CAST(committed_capacity_fte AS DOUBLE))
      comment: "Total committed capacity in FTE"
    - name: "total_uncommitted_capacity_fte"
      expr: SUM(CAST(uncommitted_capacity_fte AS DOUBLE))
      comment: "Total uncommitted (available) capacity in FTE"
    - name: "total_forecasted_demand_fte"
      expr: SUM(CAST(forecasted_demand_fte AS DOUBLE))
      comment: "Total forecasted demand in FTE"
    - name: "total_capacity_gap_fte"
      expr: SUM(CAST(capacity_gap_fte AS DOUBLE))
      comment: "Total capacity gap (demand minus available capacity) in FTE"
    - name: "total_bench_capacity_fte"
      expr: SUM(CAST(bench_capacity_fte AS DOUBLE))
      comment: "Total bench capacity (unassigned workers) in FTE"
    - name: "total_redeployment_capacity_fte"
      expr: SUM(CAST(redeployment_capacity_fte AS DOUBLE))
      comment: "Total redeployment capacity (workers available for reassignment) in FTE"
    - name: "total_sourcing_pipeline_fte"
      expr: SUM(CAST(sourcing_pipeline_fte AS DOUBLE))
      comment: "Total sourcing pipeline capacity (candidates in process) in FTE"
    - name: "avg_capacity_utilization_percentage"
      expr: AVG(CAST(capacity_utilization_percentage AS DOUBLE))
      comment: "Average capacity utilization percentage (committed / available)"
    - name: "avg_target_utilization_percentage"
      expr: AVG(CAST(target_utilization_percentage AS DOUBLE))
      comment: "Average target utilization percentage"
    - name: "avg_bill_rate"
      expr: AVG(CAST(average_bill_rate AS DOUBLE))
      comment: "Average bill rate per hour"
    - name: "avg_pay_rate"
      expr: AVG(CAST(average_pay_rate AS DOUBLE))
      comment: "Average pay rate per hour"
    - name: "avg_markup_percentage"
      expr: AVG(CAST(average_markup_percentage AS DOUBLE))
      comment: "Average markup percentage"
    - name: "distinct_suppliers"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of distinct suppliers in capacity plans"
    - name: "distinct_job_categories"
      expr: COUNT(DISTINCT job_category_id)
      comment: "Number of distinct job categories in capacity plans"
    - name: "distinct_programs"
      expr: COUNT(DISTINCT managed_program_id)
      comment: "Number of distinct managed programs"
$$;


CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`joborder_order_status_history`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Order lifecycle and SLA performance metrics tracking status transitions, time-to-fill, time-to-submit, escalations, and milestone achievement"
  source: "`staffing_hr_ecm`.`joborder`.`order_status_history`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of status event (status_change, milestone, escalation, notification)"
    - name: "milestone_type"
      expr: milestone_type
      comment: "Type of milestone reached (intake, first_submittal, interview, offer, start)"
    - name: "new_status"
      expr: new_status
      comment: "New status after transition"
    - name: "previous_status"
      expr: previous_status
      comment: "Previous status before transition"
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for status change"
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Flag indicating if event was escalated"
    - name: "escalation_level"
      expr: escalation_level
      comment: "Escalation level (L1, L2, L3, executive)"
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Flag indicating if SLA was breached"
    - name: "sla_breach_severity"
      expr: sla_breach_severity
      comment: "Severity of SLA breach (minor, major, critical)"
    - name: "is_active"
      expr: is_active
      comment: "Flag indicating if this is the current active status"
    - name: "notification_sent_flag"
      expr: notification_sent_flag
      comment: "Flag indicating if notification was sent"
    - name: "transition_month"
      expr: DATE_TRUNC('MONTH', transition_timestamp)
      comment: "Month of status transition"
    - name: "transition_quarter"
      expr: DATE_TRUNC('QUARTER', transition_timestamp)
      comment: "Quarter of status transition"
    - name: "target_month"
      expr: DATE_TRUNC('MONTH', target_date)
      comment: "Target month for milestone"
    - name: "actual_completion_month"
      expr: DATE_TRUNC('MONTH', actual_completion_date)
      comment: "Actual completion month"
    - name: "triggering_system"
      expr: triggering_system
      comment: "System that triggered the status change"
  measures:
    - name: "total_status_events"
      expr: COUNT(1)
      comment: "Total number of status change events"
    - name: "total_escalations"
      expr: SUM(CASE WHEN escalation_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Total number of escalated events"
    - name: "total_sla_breaches"
      expr: SUM(CASE WHEN sla_breach_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Total number of SLA breaches"
    - name: "distinct_orders"
      expr: COUNT(DISTINCT order_header_id)
      comment: "Number of distinct orders with status events"
    - name: "distinct_assignments"
      expr: COUNT(DISTINCT assignment_id)
      comment: "Number of distinct assignments with status events"
    - name: "distinct_candidates"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of distinct candidates involved in status events"
$$;


CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`joborder_sla_commitment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service level agreement performance metrics tracking SLA targets, fill rates, submittal windows, quality scores, and penalty enforcement by supplier and program"
  source: "`staffing_hr_ecm`.`joborder`.`sla_commitment`"
  dimensions:
    - name: "sla_status"
      expr: sla_status
      comment: "Current status of the SLA commitment (active, expired, suspended, terminated)"
    - name: "sla_tier"
      expr: sla_tier
      comment: "SLA tier level (platinum, gold, silver, bronze)"
    - name: "is_active"
      expr: is_active
      comment: "Flag indicating if SLA is currently active"
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Flag indicating if SLA auto-renews"
    - name: "exclusive_submittal_period_flag"
      expr: exclusive_submittal_period_flag
      comment: "Flag indicating if supplier has exclusive submittal period"
    - name: "rtr_enforcement_flag"
      expr: rtr_enforcement_flag
      comment: "Flag indicating if right-to-represent enforcement is active"
    - name: "waiver_granted_flag"
      expr: waiver_granted_flag
      comment: "Flag indicating if SLA waiver was granted"
    - name: "measurement_methodology"
      expr: measurement_methodology
      comment: "Methodology for measuring SLA performance"
    - name: "business_days_definition"
      expr: business_days_definition
      comment: "Definition of business days for SLA calculation"
    - name: "duplicate_submittal_prevention_rule"
      expr: duplicate_submittal_prevention_rule
      comment: "Rule for preventing duplicate submittals"
    - name: "sla_effective_month"
      expr: DATE_TRUNC('MONTH', sla_effective_date)
      comment: "Month when SLA became effective"
    - name: "sla_expiration_month"
      expr: DATE_TRUNC('MONTH', sla_expiration_date)
      comment: "Month when SLA expires"
    - name: "exclusive_period_end_month"
      expr: DATE_TRUNC('MONTH', exclusive_period_end_date)
      comment: "End month of exclusive submittal period"
    - name: "submittal_window_open_month"
      expr: DATE_TRUNC('MONTH', submittal_window_open_date)
      comment: "Month when submittal window opens"
    - name: "submittal_window_close_month"
      expr: DATE_TRUNC('MONTH', submittal_window_close_date)
      comment: "Month when submittal window closes"
    - name: "waiver_approved_month"
      expr: DATE_TRUNC('MONTH', waiver_approved_date)
      comment: "Month when waiver was approved"
    - name: "penalty_breach_fee_currency"
      expr: penalty_breach_fee_currency
      comment: "Currency for penalty breach fees"
  measures:
    - name: "total_sla_commitments"
      expr: COUNT(1)
      comment: "Total number of SLA commitments"
    - name: "avg_fill_rate_target_percentage"
      expr: AVG(CAST(fill_rate_target_percentage AS DOUBLE))
      comment: "Average fill rate target percentage"
    - name: "avg_interview_to_offer_ratio_target"
      expr: AVG(CAST(interview_to_offer_ratio_target AS DOUBLE))
      comment: "Average interview-to-offer ratio target"
    - name: "avg_qos_minimum_score"
      expr: AVG(CAST(qos_minimum_score AS DOUBLE))
      comment: "Average quality of service minimum score"
    - name: "total_penalty_breach_fees"
      expr: SUM(CAST(penalty_breach_fee_amount AS DOUBLE))
      comment: "Total penalty breach fee amounts"
    - name: "distinct_suppliers"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of distinct suppliers with SLA commitments"
    - name: "distinct_orders"
      expr: COUNT(DISTINCT order_header_id)
      comment: "Number of distinct orders with SLA commitments"
    - name: "distinct_programs"
      expr: COUNT(DISTINCT managed_program_id)
      comment: "Number of distinct managed programs with SLAs"
$$;
