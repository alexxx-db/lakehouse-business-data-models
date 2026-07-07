-- Metric views for domain: production | Business: Media_Broadcasting | Version: 2 | Generated on: 2026-06-30 04:55:25

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`production_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Production project portfolio KPIs covering budget vs spend, greenlight status, and delivery performance for slate-level steering decisions."
  source: "`vibe_media_broadcasting_v1`.`production`.`project`"
  dimensions:
    - name: "project_type"
      expr: project_type
      comment: "Type of production project (scripted, unscripted, film, etc.) for slate composition analysis."
    - name: "production_phase"
      expr: production_phase
      comment: "Current production lifecycle phase (development, pre-production, principal photography, post)."
    - name: "greenlight_status"
      expr: greenlight_status
      comment: "Greenlight decision status used to track pipeline conversion."
    - name: "production_country"
      expr: production_country
      comment: "Country of production for geographic cost/incentive analysis."
    - name: "co_production_flag"
      expr: co_production_flag
      comment: "Whether the project is a co-production, relevant for cost-sharing and rights complexity."
    - name: "greenlight_month"
      expr: DATE_TRUNC('MONTH', greenlight_date)
      comment: "Greenlight month for slate-velocity trend analysis."
  measures:
    - name: "project_count"
      expr: COUNT(1)
      comment: "Number of production projects, the base volume of the active slate."
    - name: "total_approved_budget"
      expr: SUM(CAST(approved_budget_usd AS DOUBLE))
      comment: "Total approved budget across projects, the committed investment in the slate."
    - name: "total_actual_spend"
      expr: SUM(CAST(actual_spend_usd AS DOUBLE))
      comment: "Total actual spend, used with approved budget to monitor cost overrun risk."
    - name: "avg_approved_budget"
      expr: AVG(CAST(approved_budget_usd AS DOUBLE))
      comment: "Average approved budget per project, indicating typical project investment scale."
    - name: "greenlit_project_count"
      expr: COUNT(DISTINCT CASE WHEN greenlight_status = 'Greenlit' THEN project_id END)
      comment: "Count of greenlit projects to track pipeline conversion into active production."
    - name: "co_production_count"
      expr: COUNT(DISTINCT CASE WHEN co_production_flag = true THEN project_id END)
      comment: "Number of co-productions, relevant for partner-funded slate share."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`production_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Production budget control KPIs comparing approved, committed, forecast, and actual amounts to surface variance and contingency exposure."
  source: "`vibe_media_broadcasting_v1`.`production`.`budget`"
  dimensions:
    - name: "approval_status"
      expr: approval_status
      comment: "Budget approval status for governance and unapproved-spend monitoring."
    - name: "production_phase"
      expr: production_phase
      comment: "Production phase the budget applies to for phase-level cost analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the budget for period-over-period comparison."
    - name: "is_locked"
      expr: is_locked
      comment: "Whether the budget is locked, relevant for change-control discipline."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the budget amounts for FX-normalized reporting."
  measures:
    - name: "budget_count"
      expr: COUNT(1)
      comment: "Number of budget records, the base volume of budget plans."
    - name: "total_approved_amount"
      expr: SUM(CAST(approved_amount AS DOUBLE))
      comment: "Total approved budget amount, the sanctioned spend ceiling."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost_amount AS DOUBLE))
      comment: "Total actual cost booked against budgets, for overrun detection."
    - name: "total_committed_amount"
      expr: SUM(CAST(committed_amount AS DOUBLE))
      comment: "Total committed amount, the contractual obligations against budget."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total variance amount, the aggregate gap between plan and actual."
    - name: "total_contingency_amount"
      expr: SUM(CAST(contingency_amount AS DOUBLE))
      comment: "Total contingency reserve held, indicating risk buffer in the slate."
    - name: "avg_contingency_pct"
      expr: AVG(CAST(contingency_percentage AS DOUBLE))
      comment: "Average contingency percentage, a risk-buffer adequacy indicator."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`production_budget_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-level budget detail KPIs for above/below-the-line and union-labor cost steering."
  source: "`vibe_media_broadcasting_v1`.`production`.`budget_line`"
  dimensions:
    - name: "cost_category"
      expr: cost_category
      comment: "Cost category of the budget line for spend composition analysis."
    - name: "line_status"
      expr: line_status
      comment: "Status of the budget line for completion/closure tracking."
    - name: "is_above_the_line"
      expr: is_above_the_line
      comment: "Above-the-line vs below-the-line classification, key cost-structure dimension."
    - name: "is_union_labor"
      expr: is_union_labor
      comment: "Whether the line is union labor, relevant for fringe and compliance cost."
    - name: "production_phase"
      expr: production_phase
      comment: "Production phase the line belongs to for phase cost allocation."
  measures:
    - name: "budget_line_count"
      expr: COUNT(1)
      comment: "Number of budget lines, the granularity of cost planning."
    - name: "total_budgeted_amount"
      expr: SUM(CAST(budgeted_amount AS DOUBLE))
      comment: "Total budgeted amount at line level for bottom-up plan totals."
    - name: "total_actual_amount"
      expr: SUM(CAST(actual_amount AS DOUBLE))
      comment: "Total actual amount booked at line level for variance analysis."
    - name: "total_committed_amount"
      expr: SUM(CAST(committed_amount AS DOUBLE))
      comment: "Total committed amount at line level reflecting contractual exposure."
    - name: "total_accrued_amount"
      expr: SUM(CAST(accrued_amount AS DOUBLE))
      comment: "Total accrued amount, supporting period-end financial accuracy."
    - name: "union_labor_line_count"
      expr: COUNT(DISTINCT CASE WHEN is_union_labor = true THEN budget_line_id END)
      comment: "Count of union-labor budget lines for guild cost exposure monitoring."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`production_cost_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Production cost transaction KPIs for actual spend tracking, payment status, and tax exposure."
  source: "`vibe_media_broadcasting_v1`.`production`.`cost_transaction`"
  dimensions:
    - name: "cost_category_name"
      expr: cost_category_name
      comment: "Cost category name for spend categorization."
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of cost transaction for spend pattern analysis."
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status to track outstanding vs settled obligations."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for period-level spend reporting."
    - name: "transaction_month"
      expr: DATE_TRUNC('MONTH', transaction_date)
      comment: "Transaction month for spend trend analysis."
  measures:
    - name: "transaction_count"
      expr: COUNT(1)
      comment: "Number of cost transactions, the base volume of production spend events."
    - name: "total_transaction_amount"
      expr: SUM(CAST(transaction_amount AS DOUBLE))
      comment: "Total transaction amount, the gross production spend."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net amount excluding tax for true cost analysis."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount for tax recovery and incentive analysis."
    - name: "avg_transaction_amount"
      expr: AVG(CAST(transaction_amount AS DOUBLE))
      comment: "Average transaction value to detect high-cost outliers."
    - name: "unpaid_transaction_count"
      expr: COUNT(DISTINCT CASE WHEN payment_status <> 'Paid' THEN cost_transaction_id END)
      comment: "Count of unpaid transactions, indicating outstanding payment workload."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`production_shoot_day`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shoot-day productivity and efficiency KPIs covering pages, setups, overtime, and on-set safety."
  source: "`vibe_media_broadcasting_v1`.`production`.`shoot_day`"
  dimensions:
    - name: "shoot_day_status"
      expr: shoot_day_status
      comment: "Status of the shoot day for completion tracking."
    - name: "unit_type"
      expr: unit_type
      comment: "Production unit type (main, second unit) for unit-level efficiency."
    - name: "is_overtime_incurred"
      expr: is_overtime_incurred
      comment: "Whether overtime was incurred, a key cost-control flag."
    - name: "shoot_month"
      expr: DATE_TRUNC('MONTH', actual_date)
      comment: "Month of the shoot day for production schedule trend analysis."
  measures:
    - name: "shoot_day_count"
      expr: COUNT(1)
      comment: "Number of shoot days, the base volume of principal photography activity."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost_amount AS DOUBLE))
      comment: "Total actual shoot-day cost for daily-spend control."
    - name: "total_budget_allocated"
      expr: SUM(CAST(budget_allocated_amount AS DOUBLE))
      comment: "Total budget allocated to shoot days for plan vs actual comparison."
    - name: "total_pages_completed"
      expr: SUM(CAST(script_pages_completed AS DOUBLE))
      comment: "Total script pages completed, a key production-velocity output."
    - name: "total_footage_shot_minutes"
      expr: SUM(CAST(footage_shot_minutes AS DOUBLE))
      comment: "Total footage shot in minutes, reflecting capture productivity."
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours incurred, a direct cost and crew-fatigue indicator."
    - name: "avg_pages_per_day"
      expr: AVG(CAST(script_pages_completed AS DOUBLE))
      comment: "Average pages completed per shoot day, a core productivity metric."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`production_qc_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality-control KPIs measuring pass rates, error counts, and remediation burden across deliverables."
  source: "`vibe_media_broadcasting_v1`.`production`.`qc_review`"
  dimensions:
    - name: "qc_result"
      expr: qc_result
      comment: "QC outcome (pass/fail) for quality pass-rate analysis."
    - name: "qc_type"
      expr: qc_type
      comment: "Type of QC review for workflow-level quality monitoring."
    - name: "final_approval_status"
      expr: final_approval_status
      comment: "Final approval status for delivery-readiness tracking."
    - name: "remediation_required_flag"
      expr: remediation_required_flag
      comment: "Whether remediation was required, key rework indicator."
    - name: "review_month"
      expr: DATE_TRUNC('MONTH', review_date)
      comment: "Month of QC review for quality-trend analysis."
  measures:
    - name: "qc_review_count"
      expr: COUNT(1)
      comment: "Number of QC reviews performed, the base QC workload."
    - name: "total_error_count"
      expr: SUM(CAST(total_error_count AS DOUBLE))
      comment: "Total errors found across reviews, an overall quality indicator. (Note: column is string-typed; cast for aggregation.)"
    - name: "total_critical_errors"
      expr: SUM(CAST(p1_critical_error_count AS DOUBLE))
      comment: "Total P1 critical errors, the most severe quality defects requiring action."
    - name: "avg_review_duration_minutes"
      expr: AVG(CAST(review_duration_minutes AS DOUBLE))
      comment: "Average QC review duration, a process-efficiency metric."
    - name: "remediation_required_count"
      expr: COUNT(DISTINCT CASE WHEN remediation_required_flag = true THEN qc_review_id END)
      comment: "Count of reviews requiring remediation, the rework pipeline size."
    - name: "avg_loudness_lufs"
      expr: AVG(CAST(loudness_lufs AS DOUBLE))
      comment: "Average measured loudness in LUFS for broadcast-compliance monitoring."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`production_crew_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Crew assignment KPIs covering contracted rates, overtime eligibility, and union/guild composition."
  source: "`vibe_media_broadcasting_v1`.`production`.`crew_assignment`"
  dimensions:
    - name: "assignment_status"
      expr: assignment_status
      comment: "Status of the crew assignment for staffing pipeline tracking."
    - name: "department"
      expr: department
      comment: "Production department for departmental cost and headcount analysis."
    - name: "deal_type"
      expr: deal_type
      comment: "Type of deal (daily, weekly, flat) for compensation structure analysis."
    - name: "union_guild_affiliation"
      expr: union_guild_affiliation
      comment: "Union or guild affiliation for labor compliance and cost analysis."
    - name: "overtime_eligible"
      expr: overtime_eligible
      comment: "Whether crew member is overtime-eligible, relevant for cost exposure."
  measures:
    - name: "crew_assignment_count"
      expr: COUNT(1)
      comment: "Number of crew assignments, the base staffing volume."
    - name: "total_contracted_rate"
      expr: SUM(CAST(contracted_rate AS DOUBLE))
      comment: "Total contracted rate across crew, the labor cost commitment."
    - name: "avg_contracted_rate"
      expr: AVG(CAST(contracted_rate AS DOUBLE))
      comment: "Average contracted crew rate for benchmarking labor cost."
    - name: "total_per_diem"
      expr: SUM(CAST(per_diem_rate AS DOUBLE))
      comment: "Total per-diem rate exposure for travel-cost planning."
    - name: "distinct_crew_count"
      expr: COUNT(DISTINCT talent_profile_id)
      comment: "Distinct crew members assigned, true headcount independent of duplicate rows."
    - name: "overtime_eligible_count"
      expr: COUNT(DISTINCT CASE WHEN overtime_eligible = true THEN crew_assignment_id END)
      comment: "Count of overtime-eligible assignments for OT cost-risk monitoring."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`production_deliverable`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Deliverable fulfillment KPIs covering delivery status, on-time performance, QC pass rate, and delivery cost."
  source: "`vibe_media_broadcasting_v1`.`production`.`deliverable`"
  dimensions:
    - name: "deliverable_type"
      expr: deliverable_type
      comment: "Type of deliverable for asset-mix and delivery analysis."
    - name: "delivery_status"
      expr: delivery_status
      comment: "Delivery status to monitor outstanding vs completed deliveries."
    - name: "delivery_method"
      expr: delivery_method
      comment: "Delivery method (file transfer, physical, etc.) for logistics analysis."
    - name: "qc_pass_flag"
      expr: qc_pass_flag
      comment: "Whether the deliverable passed QC, key quality gate."
    - name: "due_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Due month for delivery-schedule trend analysis."
  measures:
    - name: "deliverable_count"
      expr: COUNT(1)
      comment: "Number of deliverables, the base volume of fulfillment obligations."
    - name: "total_cost_amount"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total deliverable cost for fulfillment-cost control."
    - name: "qc_passed_count"
      expr: COUNT(DISTINCT CASE WHEN qc_pass_flag = true THEN deliverable_id END)
      comment: "Count of deliverables passing QC for first-pass quality analysis."
    - name: "delivered_count"
      expr: COUNT(DISTINCT CASE WHEN delivery_status = 'Delivered' THEN deliverable_id END)
      comment: "Count of completed deliveries for fulfillment rate calculation."
    - name: "total_duration_seconds"
      expr: SUM(CAST(duration_seconds AS DOUBLE))
      comment: "Total content duration delivered, a throughput indicator."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`production_post_production_task`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Post-production task KPIs tracking cost, duration, QC pass rate, and schedule adherence."
  source: "`vibe_media_broadcasting_v1`.`production`.`post_production_task`"
  dimensions:
    - name: "task_type"
      expr: task_type
      comment: "Type of post-production task for workflow analysis."
    - name: "task_status"
      expr: task_status
      comment: "Status of the task for pipeline progress tracking."
    - name: "priority"
      expr: priority
      comment: "Task priority for resource-prioritization analysis."
    - name: "qc_pass_flag"
      expr: qc_pass_flag
      comment: "Whether the task output passed QC, a quality indicator."
  measures:
    - name: "task_count"
      expr: COUNT(1)
      comment: "Number of post-production tasks, the base post-pipeline volume."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost_amount AS DOUBLE))
      comment: "Total actual post-production cost for budget tracking."
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost_amount AS DOUBLE))
      comment: "Total estimated post cost for plan vs actual comparison."
    - name: "avg_actual_duration_hours"
      expr: AVG(CAST(actual_duration_hours AS DOUBLE))
      comment: "Average actual task duration, a throughput-efficiency metric."
    - name: "qc_passed_task_count"
      expr: COUNT(DISTINCT CASE WHEN qc_pass_flag = true THEN post_production_task_id END)
      comment: "Count of QC-passed tasks for quality pass-rate analysis."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`production_facility_booking`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Facility/studio booking KPIs covering booking cost, cancellation exposure, and utilization signals."
  source: "`vibe_media_broadcasting_v1`.`production`.`facility_booking`"
  dimensions:
    - name: "booking_status"
      expr: booking_status
      comment: "Status of the booking for utilization and cancellation tracking."
    - name: "facility_type"
      expr: facility_type
      comment: "Type of facility for facility-mix analysis."
    - name: "rate_type"
      expr: rate_type
      comment: "Rate type (hourly, daily) for cost-structure analysis."
    - name: "is_exclusive"
      expr: is_exclusive
      comment: "Whether the booking is exclusive use, relevant for capacity planning."
  measures:
    - name: "booking_count"
      expr: COUNT(1)
      comment: "Number of facility bookings, the base utilization volume."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual facility cost for facility-spend control."
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated facility cost for plan vs actual analysis."
    - name: "total_cancellation_fee"
      expr: SUM(CAST(cancellation_fee AS DOUBLE))
      comment: "Total cancellation fees, a waste/leakage indicator."
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total facility overtime hours, a cost-overrun signal."
    - name: "cancelled_booking_count"
      expr: COUNT(DISTINCT CASE WHEN booking_status = 'Cancelled' THEN facility_booking_id END)
      comment: "Count of cancelled bookings to monitor planning churn."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`production_daily_production_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Daily production report KPIs measuring on-set productivity, crew hours, overtime, and safety incidents."
  source: "`vibe_media_broadcasting_v1`.`production`.`daily_production_report`"
  dimensions:
    - name: "report_status"
      expr: report_status
      comment: "Status of the daily report for completeness tracking."
    - name: "production_unit"
      expr: production_unit
      comment: "Production unit reporting for unit-level productivity analysis."
    - name: "accidents_incidents_flag"
      expr: accidents_incidents_flag
      comment: "Whether an accident/incident occurred, key safety indicator."
    - name: "report_month"
      expr: DATE_TRUNC('MONTH', report_date)
      comment: "Month of the report for productivity trend analysis."
  measures:
    - name: "report_count"
      expr: COUNT(1)
      comment: "Number of daily production reports, the base on-set activity volume."
    - name: "total_pages_shot"
      expr: SUM(CAST(pages_shot AS DOUBLE))
      comment: "Total script pages shot, a core production-velocity output."
    - name: "total_crew_hours"
      expr: SUM(CAST(total_crew_hours AS DOUBLE))
      comment: "Total crew hours worked, a labor-cost and capacity indicator."
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours, a direct cost and fatigue indicator."
    - name: "avg_schedule_variance_days"
      expr: AVG(CAST(schedule_variance_days AS DOUBLE))
      comment: "Average schedule variance in days, a schedule-adherence metric."
    - name: "incident_report_count"
      expr: COUNT(DISTINCT CASE WHEN accidents_incidents_flag = true THEN daily_production_report_id END)
      comment: "Count of reports with safety incidents for risk monitoring."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`production_vfx_shot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "VFX shot KPIs comparing bid, approved, and actual costs and tracking delivery and revision burden."
  source: "`vibe_media_broadcasting_v1`.`production`.`vfx_shot`"
  dimensions:
    - name: "shot_status"
      expr: shot_status
      comment: "Status of the VFX shot for pipeline progress tracking."
    - name: "vfx_category"
      expr: vfx_category
      comment: "VFX category for complexity-mix analysis."
    - name: "complexity_tier"
      expr: complexity_tier
      comment: "Complexity tier of the shot, a key cost/effort driver."
  measures:
    - name: "vfx_shot_count"
      expr: COUNT(1)
      comment: "Number of VFX shots, the base VFX pipeline volume."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual VFX cost for budget control."
    - name: "total_approved_cost"
      expr: SUM(CAST(approved_cost AS DOUBLE))
      comment: "Total approved VFX cost for plan vs actual comparison."
    - name: "total_bid_cost"
      expr: SUM(CAST(bid_cost AS DOUBLE))
      comment: "Total vendor bid cost for bid-vs-actual leakage analysis."
    - name: "avg_actual_cost"
      expr: AVG(CAST(actual_cost AS DOUBLE))
      comment: "Average cost per VFX shot for benchmarking."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`production_equipment_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Equipment allocation KPIs covering rental cost, damage exposure, and insurance value of allocated gear."
  source: "`vibe_media_broadcasting_v1`.`production`.`equipment_allocation`"
  dimensions:
    - name: "allocation_status"
      expr: allocation_status
      comment: "Status of the allocation for utilization tracking."
    - name: "equipment_category"
      expr: equipment_category
      comment: "Equipment category for gear-mix analysis."
    - name: "rental_rate_type"
      expr: rental_rate_type
      comment: "Rental rate type for cost-structure analysis."
    - name: "is_owned_asset"
      expr: is_owned_asset
      comment: "Whether the equipment is owned vs rented, key make-vs-buy dimension."
  measures:
    - name: "allocation_count"
      expr: COUNT(1)
      comment: "Number of equipment allocations, the base gear-utilization volume."
    - name: "total_rental_rate"
      expr: SUM(CAST(rental_rate_amount AS DOUBLE))
      comment: "Total rental rate exposure for equipment-cost control."
    - name: "total_damage_claim"
      expr: SUM(CAST(damage_claim_amount AS DOUBLE))
      comment: "Total damage claim amount, a loss/risk indicator."
    - name: "total_insurance_value"
      expr: SUM(CAST(insurance_value AS DOUBLE))
      comment: "Total insured equipment value for risk and coverage analysis."
    - name: "rented_allocation_count"
      expr: COUNT(DISTINCT CASE WHEN is_owned_asset = false THEN equipment_allocation_id END)
      comment: "Count of rented (non-owned) allocations for rental-spend analysis."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`production_broadcast`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational view of broadcast occurrences"
  source: "`vibe_media_broadcasting_v1`.`production`.`broadcast`"
  dimensions:
    - name: "platform_type"
      expr: platform_type
      comment: "Distribution platform (e.g., linear, streaming)"
    - name: "broadcast_status"
      expr: broadcast_status
      comment: "Current status of the broadcast"
    - name: "broadcast_date"
      expr: broadcast_date
      comment: "Date of the broadcast"
  measures:
    - name: "broadcast_count"
      expr: COUNT(1)
      comment: "Number of broadcast events"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`production_episode`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial performance per production episode"
  source: "`vibe_media_broadcasting_v1`.`production`.`production_episode`"
  dimensions:
    - name: "title_id"
      expr: title_id
      comment: "Title identifier for the episode"
    - name: "production_status"
      expr: production_status
      comment: "Current production status of the episode"
    - name: "first_air_date"
      expr: first_air_date
      comment: "First air date of the episode"
    - name: "content_type"
      expr: content_type
      comment: "Type of content (e.g., series, special)"
  measures:
    - name: "total_actual_cost_usd"
      expr: SUM(CAST(actual_cost_usd AS DOUBLE))
      comment: "Total actual cost for episodes"
    - name: "total_approved_budget_usd"
      expr: SUM(CAST(approved_budget_usd AS DOUBLE))
      comment: "Total approved budget for episodes"
$$;