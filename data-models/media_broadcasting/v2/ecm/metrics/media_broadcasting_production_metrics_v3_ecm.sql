-- Metric views for domain: production | Business: Media_Broadcasting | Version: 3 | Generated on: 2026-07-10 19:06:42

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`production_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial performance metrics for production budgets, tracking spend variance, forecast accuracy, and budget utilization across projects and fiscal periods. Used by production finance leads and studio executives to govern greenlight decisions and cost control."
  source: "`vibe_media_broadcasting_v1`.`production`.`budget`"
  dimensions:
    - name: "approval_status"
      expr: approval_status
      comment: "Current approval state of the budget (e.g., Approved, Pending, Rejected) for filtering active vs. in-flight budgets."
    - name: "production_phase"
      expr: production_phase
      comment: "Phase of production (Pre-Production, Principal Photography, Post-Production) enabling phase-level cost analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the budget for year-over-year financial comparisons."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period (month/quarter) for intra-year budget tracking."
    - name: "cost_category_name"
      expr: cost_category_name
      comment: "Cost category (e.g., Above-the-Line, Below-the-Line, Post) for granular spend analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the budget for multi-currency portfolio analysis."
    - name: "is_greenlight_budget"
      expr: is_greenlight_budget
      comment: "Flag indicating whether this is the greenlight-approved budget version, separating official budgets from working drafts."
    - name: "is_locked"
      expr: is_locked
      comment: "Indicates whether the budget is locked against further changes, useful for tracking finalized vs. open budgets."
    - name: "period_start_date"
      expr: DATE_TRUNC('month', period_start_date)
      comment: "Budget period start month for time-series trending of spend."
  measures:
    - name: "total_approved_amount"
      expr: SUM(CAST(approved_amount AS DOUBLE))
      comment: "Total approved budget across all selected budgets. Core financial baseline for production investment decisions."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost_amount AS DOUBLE))
      comment: "Total actual costs incurred. Compared against approved amount to assess spend performance."
    - name: "total_forecast_amount"
      expr: SUM(CAST(forecast_amount AS DOUBLE))
      comment: "Total forecasted spend. Used by finance to project final cost-at-completion and flag overruns early."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total budget variance (approved minus actual). Negative values signal cost overruns requiring executive intervention."
    - name: "total_committed_amount"
      expr: SUM(CAST(committed_amount AS DOUBLE))
      comment: "Total committed spend (POs, contracts signed but not yet invoiced). Critical for cash flow forecasting."
    - name: "total_contingency_amount"
      expr: SUM(CAST(contingency_amount AS DOUBLE))
      comment: "Total contingency reserves held across budgets. Tracks risk buffer consumption at portfolio level."
    - name: "avg_contingency_percentage"
      expr: AVG(CAST(contingency_percentage AS DOUBLE))
      comment: "Average contingency percentage held across budgets. Benchmarks risk provisioning discipline across productions."
    - name: "budget_utilization_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_cost_amount AS DOUBLE)) / NULLIF(SUM(CAST(approved_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of approved budget consumed by actual costs. Key efficiency KPI for production finance reviews — values above 100% signal overrun."
    - name: "forecast_vs_approved_pct"
      expr: ROUND(100.0 * SUM(CAST(forecast_amount AS DOUBLE)) / NULLIF(SUM(CAST(approved_amount AS DOUBLE)), 0), 2)
      comment: "Forecast spend as a percentage of approved budget. Early warning indicator for cost overruns before actuals are posted."
    - name: "total_revised_amount"
      expr: SUM(CAST(revised_amount AS DOUBLE))
      comment: "Total revised budget amounts reflecting approved change orders. Tracks scope creep and budget amendment frequency."
    - name: "budget_count"
      expr: COUNT(1)
      comment: "Number of budget records in scope. Used as denominator for per-budget averages and portfolio sizing."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`production_budget_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-level production cost metrics enabling granular cost category analysis, above-the-line vs. below-the-line split, union labor cost tracking, and forecast accuracy at the budget line level. Used by production accountants and department heads."
  source: "`vibe_media_broadcasting_v1`.`production`.`budget_line`"
  dimensions:
    - name: "cost_category"
      expr: cost_category
      comment: "High-level cost category (e.g., Cast, Crew, Equipment, Locations) for departmental spend analysis."
    - name: "cost_sub_category"
      expr: cost_sub_category
      comment: "Sub-category within cost category for granular line-item analysis."
    - name: "production_phase"
      expr: production_phase
      comment: "Production phase associated with this budget line for phase-level cost tracking."
    - name: "is_above_the_line"
      expr: is_above_the_line
      comment: "Distinguishes above-the-line (creative talent) from below-the-line (crew/technical) costs — a fundamental production finance split."
    - name: "is_union_labor"
      expr: is_union_labor
      comment: "Flags union labor lines for guild compliance cost tracking and residuals liability estimation."
    - name: "line_status"
      expr: line_status
      comment: "Current status of the budget line (Active, Closed, On-Hold) for filtering actionable lines."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the budget line for multi-currency production cost analysis."
    - name: "tax_credit_eligible"
      expr: tax_credit_eligible
      comment: "Flags lines eligible for production tax credits — critical for incentive optimization and jurisdiction selection."
    - name: "shoot_date_start"
      expr: DATE_TRUNC('month', shoot_date_start)
      comment: "Shoot start month for time-phased cost analysis aligned to production calendar."
  measures:
    - name: "total_budgeted_amount"
      expr: SUM(CAST(budgeted_amount AS DOUBLE))
      comment: "Total budgeted amount across selected lines. Baseline for cost category investment decisions."
    - name: "total_actual_amount"
      expr: SUM(CAST(actual_amount AS DOUBLE))
      comment: "Total actual spend posted against budget lines. Core cost performance indicator."
    - name: "total_forecast_amount"
      expr: SUM(CAST(forecast_amount AS DOUBLE))
      comment: "Total forecasted spend at completion for selected lines. Used for cost-at-completion projections."
    - name: "total_committed_amount"
      expr: SUM(CAST(committed_amount AS DOUBLE))
      comment: "Total committed spend (contracted but not yet invoiced). Essential for cash flow and liability management."
    - name: "total_accrued_amount"
      expr: SUM(CAST(accrued_amount AS DOUBLE))
      comment: "Total accrued costs for period-end financial close accuracy."
    - name: "line_variance_amount"
      expr: SUM((CAST(budgeted_amount AS DOUBLE)) - (CAST(actual_amount AS DOUBLE)))
      comment: "Aggregate variance between budgeted and actual amounts. Positive = under budget; negative = overrun. Drives corrective action."
    - name: "line_utilization_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_amount AS DOUBLE)) / NULLIF(SUM(CAST(budgeted_amount AS DOUBLE)), 0), 2)
      comment: "Actual spend as a percentage of budgeted amount per line. Identifies cost categories running hot or cold."
    - name: "avg_unit_rate"
      expr: AVG(CAST(unit_rate AS DOUBLE))
      comment: "Average unit rate across budget lines. Benchmarks rate negotiation effectiveness against plan."
    - name: "total_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity of units across budget lines. Used with unit rate to validate cost build-up integrity."
    - name: "avg_fringe_rate_pct"
      expr: AVG(CAST(fringe_rate_pct AS DOUBLE))
      comment: "Average fringe/burden rate applied to labor lines. Tracks labor overhead cost efficiency."
    - name: "revised_vs_budgeted_pct"
      expr: ROUND(100.0 * SUM(CAST(revised_budgeted_amount AS DOUBLE)) / NULLIF(SUM(CAST(budgeted_amount AS DOUBLE)), 0), 2)
      comment: "Revised budget as a percentage of original budget. Measures scope change magnitude and budget discipline."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`production_cost_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Actual cost transaction metrics for production spend tracking, payment performance, and financial close accuracy. Used by production accountants, finance controllers, and studio CFOs to monitor cash outflows and vendor payment health."
  source: "`vibe_media_broadcasting_v1`.`production`.`cost_transaction`"
  dimensions:
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of cost transaction (Invoice, PO, Accrual, Journal) for spend category analysis."
    - name: "cost_category_name"
      expr: cost_category_name
      comment: "Cost category of the transaction for departmental spend attribution."
    - name: "production_phase"
      expr: production_phase
      comment: "Production phase when the cost was incurred for phase-level financial analysis."
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status (Paid, Pending, Overdue) for accounts payable management and cash flow forecasting."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method (Wire, Check, ACH) for treasury and payment operations analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for multi-currency cost consolidation."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the transaction for annual cost reporting."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for period-level cost close and accrual management."
    - name: "transaction_date"
      expr: DATE_TRUNC('month', transaction_date)
      comment: "Transaction month for time-series spend trend analysis."
  measures:
    - name: "total_transaction_amount"
      expr: SUM(CAST(transaction_amount AS DOUBLE))
      comment: "Total gross transaction amount. Primary measure of production cash outflow."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net amount after adjustments and discounts. Used for accurate cost-of-production reporting."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax paid across transactions. Supports tax credit optimization and jurisdiction cost analysis."
    - name: "total_reporting_currency_amount"
      expr: SUM(CAST(reporting_currency_amount AS DOUBLE))
      comment: "Total spend in reporting currency (USD equivalent). Enables consolidated multi-currency portfolio cost reporting."
    - name: "avg_exchange_rate"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average FX exchange rate applied to transactions. Monitors FX exposure and hedging effectiveness."
    - name: "transaction_count"
      expr: COUNT(1)
      comment: "Number of cost transactions. Used to assess transaction volume and processing load."
    - name: "distinct_payee_count"
      expr: COUNT(DISTINCT payee_name)
      comment: "Number of distinct vendors/payees paid. Tracks vendor concentration risk and procurement diversity."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`production_shoot_day`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational efficiency metrics for production shoot days, tracking schedule adherence, cost per shoot day, overtime incidence, and footage yield. Used by production supervisors and studio operations to optimize principal photography efficiency."
  source: "`vibe_media_broadcasting_v1`.`production`.`shoot_day`"
  dimensions:
    - name: "shoot_day_status"
      expr: shoot_day_status
      comment: "Status of the shoot day (Completed, Cancelled, Postponed) for operational performance filtering."
    - name: "unit_type"
      expr: unit_type
      comment: "Production unit type (Main Unit, Second Unit, Splinter Unit) for unit-level efficiency comparison."
    - name: "weather_condition"
      expr: weather_condition
      comment: "Weather conditions on shoot day. Correlates weather disruption with cost overruns and schedule variance."
    - name: "is_overtime_incurred"
      expr: is_overtime_incurred
      comment: "Flags shoot days where overtime was incurred — key driver of above-budget costs."
    - name: "dailies_delivered_flag"
      expr: dailies_delivered_flag
      comment: "Indicates whether dailies were delivered on schedule — a proxy for post-production pipeline health."
    - name: "scheduled_date"
      expr: DATE_TRUNC('week', scheduled_date)
      comment: "Scheduled shoot week for production calendar analysis and schedule compression tracking."
  measures:
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost_amount AS DOUBLE))
      comment: "Total actual cost across shoot days. Primary financial KPI for principal photography spend."
    - name: "total_budget_allocated"
      expr: SUM(CAST(budget_allocated_amount AS DOUBLE))
      comment: "Total budget allocated to shoot days. Baseline for cost variance analysis."
    - name: "shoot_day_cost_variance"
      expr: SUM((CAST(budget_allocated_amount AS DOUBLE)) - (CAST(actual_cost_amount AS DOUBLE)))
      comment: "Aggregate variance between allocated budget and actual shoot day costs. Negative values signal overruns requiring production management intervention."
    - name: "cost_per_shoot_day"
      expr: ROUND(SUM(CAST(actual_cost_amount AS DOUBLE)) / NULLIF(COUNT(1), 0), 2)
      comment: "Average actual cost per shoot day. Benchmarks production efficiency and informs future budget planning."
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours incurred across shoot days. High overtime is a leading indicator of schedule pressure and cost overrun risk."
    - name: "avg_footage_shot_minutes"
      expr: AVG(CAST(footage_shot_minutes AS DOUBLE))
      comment: "Average footage captured per shoot day. Measures production throughput and crew efficiency."
    - name: "total_footage_shot_minutes"
      expr: SUM(CAST(footage_shot_minutes AS DOUBLE))
      comment: "Total footage captured across all shoot days. Tracks raw material yield for post-production planning."
    - name: "avg_script_pages_completed"
      expr: AVG(CAST(script_pages_completed AS DOUBLE))
      comment: "Average script pages completed per shoot day. Core schedule efficiency metric — below-plan values trigger schedule reviews."
    - name: "schedule_completion_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(script_pages_completed AS DOUBLE)) / NULLIF(SUM(CAST(script_pages_scheduled AS DOUBLE)), 0), 2)
      comment: "Percentage of scheduled script pages actually completed. Measures schedule adherence — below 90% signals production risk."
    - name: "scene_completion_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(scenes_completed_count AS DOUBLE)) / NULLIF(SUM(CAST(scenes_scheduled_count AS DOUBLE)), 0), 2)
      comment: "Percentage of scheduled scenes completed per shoot day. Operational efficiency KPI used in daily production reports."
    - name: "overtime_incidence_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_overtime_incurred = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of shoot days where overtime was incurred. High rates indicate scheduling inefficiency and drive labor cost overruns."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`production_deliverable`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Delivery performance and quality metrics for production deliverables, tracking on-time delivery rates, QC pass rates, and cost per deliverable. Used by post-production supervisors, distribution operations, and studio executives to ensure content reaches platforms on schedule."
  source: "`vibe_media_broadcasting_v1`.`production`.`deliverable`"
  dimensions:
    - name: "deliverable_type"
      expr: deliverable_type
      comment: "Type of deliverable (Master, Promo, Trailer, Localized Version) for delivery pipeline analysis."
    - name: "delivery_status"
      expr: delivery_status
      comment: "Current delivery status (Delivered, Pending, Failed, In-QC) for operational pipeline management."
    - name: "delivery_method"
      expr: delivery_method
      comment: "Delivery method (FTP, Aspera, Physical, API) for logistics and cost analysis."
    - name: "qc_pass_flag"
      expr: qc_pass_flag
      comment: "Whether the deliverable passed quality control — key quality gate metric."
    - name: "language_code"
      expr: language_code
      comment: "Language of the deliverable for localization coverage analysis."
    - name: "content_rating"
      expr: content_rating
      comment: "Content rating of the deliverable for compliance and platform eligibility analysis."
    - name: "audio_description_flag"
      expr: audio_description_flag
      comment: "Flags deliverables with audio description tracks for accessibility compliance tracking."
    - name: "due_date"
      expr: DATE_TRUNC('month', due_date)
      comment: "Delivery due month for pipeline capacity planning and deadline management."
  measures:
    - name: "total_deliverable_count"
      expr: COUNT(1)
      comment: "Total number of deliverables in scope. Baseline for delivery pipeline sizing and throughput analysis."
    - name: "qc_pass_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN qc_pass_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deliverables passing QC on first submission. Core quality KPI — low rates signal post-production quality issues and drive rework costs."
    - name: "on_time_delivery_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN actual_delivery_timestamp <= scheduled_delivery_timestamp THEN 1 ELSE 0 END) / NULLIF(COUNT(CASE WHEN actual_delivery_timestamp IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of deliverables delivered on or before scheduled timestamp. Critical SLA metric for platform and distribution partner relationships."
    - name: "total_delivery_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost of deliverable production and delivery. Tracks post-production spend and delivery logistics costs."
    - name: "avg_delivery_cost"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average cost per deliverable. Benchmarks delivery efficiency and informs future post-production budgeting."
    - name: "avg_duration_seconds"
      expr: AVG(CAST(duration_seconds AS DOUBLE))
      comment: "Average deliverable duration in seconds. Used for encoding time estimation and storage capacity planning."
    - name: "total_file_size_bytes"
      expr: SUM(CAST(file_size_bytes AS DOUBLE))
      comment: "Total file size of all deliverables in bytes. Drives storage infrastructure and bandwidth capacity planning."
    - name: "compliance_certificate_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN compliance_certificate_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deliverables with compliance certificates issued. Tracks regulatory readiness for broadcast and distribution clearance."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`production_crew_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Crew cost and workforce metrics for production staffing, tracking contracted rates, overtime eligibility, union labor composition, and per-diem costs. Used by production managers and studio HR to optimize crew spend and ensure guild compliance."
  source: "`vibe_media_broadcasting_v1`.`production`.`crew_assignment`"
  dimensions:
    - name: "department"
      expr: department
      comment: "Production department (Camera, Lighting, Sound, Art, etc.) for departmental crew cost analysis."
    - name: "role_title"
      expr: role_title
      comment: "Crew role title for rate benchmarking and headcount analysis by position."
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current assignment status (Active, Completed, Cancelled) for workforce pipeline management."
    - name: "deal_type"
      expr: deal_type
      comment: "Deal structure (Daily, Weekly, Run-of-Show) for contract type cost analysis."
    - name: "union_guild_affiliation"
      expr: union_guild_affiliation
      comment: "Union or guild affiliation (IATSE, SAG-AFTRA, Teamsters) for labor compliance and residuals liability tracking."
    - name: "overtime_eligible"
      expr: overtime_eligible
      comment: "Flags crew members eligible for overtime — key input for labor cost risk modeling."
    - name: "residuals_eligible"
      expr: residuals_eligible
      comment: "Flags crew eligible for residuals payments — tracks long-tail labor liability."
    - name: "filming_location_country"
      expr: filming_location_country
      comment: "Country where filming occurs for tax incentive eligibility and work permit compliance analysis."
    - name: "start_date"
      expr: DATE_TRUNC('month', start_date)
      comment: "Assignment start month for crew ramp-up and workforce planning analysis."
  measures:
    - name: "total_contracted_rate"
      expr: SUM(CAST(contracted_rate AS DOUBLE))
      comment: "Total contracted crew rates across assignments. Primary labor cost commitment metric for production budgeting."
    - name: "avg_contracted_rate"
      expr: AVG(CAST(contracted_rate AS DOUBLE))
      comment: "Average contracted rate per crew assignment. Benchmarks rate negotiation outcomes against guild minimums and market rates."
    - name: "total_per_diem_cost"
      expr: SUM(CAST(per_diem_rate AS DOUBLE))
      comment: "Total per diem costs across crew assignments. Tracks travel and living expense liability for location shoots."
    - name: "total_travel_allowance"
      expr: SUM(CAST(travel_allowance AS DOUBLE))
      comment: "Total travel allowances committed to crew. Monitors location shoot logistics costs."
    - name: "avg_overtime_rate_multiplier"
      expr: AVG(CAST(overtime_rate_multiplier AS DOUBLE))
      comment: "Average overtime rate multiplier across eligible crew. Higher values indicate premium overtime exposure."
    - name: "crew_assignment_count"
      expr: COUNT(1)
      comment: "Total crew assignments. Measures production workforce scale and headcount for capacity planning."
    - name: "union_crew_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN union_guild_affiliation IS NOT NULL AND union_guild_affiliation != '' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of crew assignments covered by union/guild agreements. Tracks union labor composition for compliance and cost modeling."
    - name: "safety_certified_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN safety_training_certified = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of crew with current safety training certification. Tracks on-set safety compliance and insurance risk exposure."
    - name: "avg_turnaround_hours"
      expr: AVG(CAST(turnaround_hours AS DOUBLE))
      comment: "Average crew turnaround hours between shifts. Below-minimum turnaround triggers guild penalties — a key labor compliance KPI."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`production_vfx_shot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "VFX production cost and delivery metrics tracking bid-to-actual cost variance, delivery schedule adherence, and complexity distribution. Used by VFX supervisors and production finance to manage vendor relationships and control post-production costs."
  source: "`vibe_media_broadcasting_v1`.`production`.`vfx_shot`"
  dimensions:
    - name: "shot_status"
      expr: shot_status
      comment: "Current VFX shot status (In-Progress, Delivered, Approved, Rejected) for pipeline management."
    - name: "vfx_category"
      expr: vfx_category
      comment: "VFX category (Compositing, CG, Motion Capture, etc.) for cost analysis by work type."
    - name: "complexity_tier"
      expr: complexity_tier
      comment: "Shot complexity tier (Simple, Medium, Complex, Hero) for cost benchmarking and vendor capacity planning."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of VFX costs for multi-vendor, multi-currency cost consolidation."
    - name: "scheduled_delivery_date"
      expr: DATE_TRUNC('month', scheduled_delivery_date)
      comment: "Scheduled delivery month for VFX pipeline capacity and deadline management."
  measures:
    - name: "total_bid_cost"
      expr: SUM(CAST(bid_cost AS DOUBLE))
      comment: "Total bid cost across VFX shots. Baseline for vendor cost commitment and budget allocation."
    - name: "total_approved_cost"
      expr: SUM(CAST(approved_cost AS DOUBLE))
      comment: "Total approved VFX cost. Reflects negotiated and approved spend after bid review."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual VFX spend. Core financial performance metric for post-production cost control."
    - name: "vfx_cost_variance"
      expr: SUM((CAST(approved_cost AS DOUBLE)) - (CAST(actual_cost AS DOUBLE)))
      comment: "Variance between approved and actual VFX costs. Negative values indicate vendor overruns requiring renegotiation."
    - name: "bid_accuracy_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_cost AS DOUBLE)) / NULLIF(SUM(CAST(bid_cost AS DOUBLE)), 0), 2)
      comment: "Actual cost as a percentage of bid cost. Measures vendor bid accuracy — values above 110% signal systematic under-bidding."
    - name: "on_time_delivery_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN actual_delivery_date <= scheduled_delivery_date THEN 1 ELSE 0 END) / NULLIF(COUNT(CASE WHEN actual_delivery_date IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of VFX shots delivered on or before scheduled date. Tracks vendor delivery performance and post-production schedule risk."
    - name: "vfx_shot_count"
      expr: COUNT(1)
      comment: "Total VFX shots in scope. Measures VFX workload volume for vendor capacity and pipeline planning."
    - name: "avg_cost_per_shot"
      expr: ROUND(AVG(CAST(actual_cost AS DOUBLE)), 2)
      comment: "Average actual cost per VFX shot. Benchmarks vendor efficiency and informs future VFX budget modeling."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`production_qc_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality control performance metrics for post-production content review, tracking error rates, QC pass rates, review cycle times, and compliance adherence. Used by post-production supervisors and technical operations to maintain delivery quality standards."
  source: "`vibe_media_broadcasting_v1`.`production`.`qc_review`"
  dimensions:
    - name: "qc_type"
      expr: qc_type
      comment: "Type of QC review (Technical, Compliance, Accessibility, Final) for quality gate analysis."
    - name: "qc_result"
      expr: qc_result
      comment: "Overall QC result (Pass, Fail, Conditional Pass) for quality performance tracking."
    - name: "final_approval_status"
      expr: final_approval_status
      comment: "Final approval status for tracking content cleared for distribution."
    - name: "qc_platform"
      expr: qc_platform
      comment: "QC platform or tool used (Cerify, Vidchecker, etc.) for platform-level quality analysis."
    - name: "remediation_required_flag"
      expr: remediation_required_flag
      comment: "Flags reviews requiring remediation — tracks rework volume and associated cost."
    - name: "closed_caption_compliance_flag"
      expr: closed_caption_compliance_flag
      comment: "Closed caption compliance status for accessibility regulatory tracking."
    - name: "loudness_compliance_flag"
      expr: loudness_compliance_flag
      comment: "Loudness compliance status (CALM Act / EBU R128) for broadcast regulatory compliance."
    - name: "review_date"
      expr: DATE_TRUNC('month', review_date)
      comment: "Review month for QC throughput trend analysis."
  measures:
    - name: "qc_pass_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN qc_result = 'Pass' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of QC reviews resulting in a pass. Primary quality KPI — declining rates signal systemic post-production quality issues."
    - name: "remediation_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN remediation_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of QC reviews requiring remediation. High rates indicate upstream production quality problems and drive rework costs."
    - name: "avg_review_duration_minutes"
      expr: AVG(CAST(review_duration_minutes AS DOUBLE))
      comment: "Average QC review duration in minutes. Tracks QC throughput efficiency and capacity planning for post-production pipelines."
    - name: "avg_loudness_lufs"
      expr: AVG(CAST(loudness_lufs AS DOUBLE))
      comment: "Average loudness level in LUFS across reviewed content. Monitors broadcast compliance with CALM Act and EBU R128 standards."
    - name: "closed_caption_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN closed_caption_compliance_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of QC reviews passing closed caption compliance. Tracks accessibility regulatory adherence — failures carry FCC penalty risk."
    - name: "loudness_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN loudness_compliance_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of QC reviews passing loudness compliance. Tracks CALM Act adherence — failures risk broadcast regulatory action."
    - name: "qc_review_count"
      expr: COUNT(1)
      comment: "Total QC reviews conducted. Measures post-production quality gate throughput volume."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`production_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic production project portfolio metrics tracking greenlight status, budget performance, delivery schedule adherence, and co-production activity. Used by studio executives and production leadership for portfolio investment decisions and greenlight reviews."
  source: "`vibe_media_broadcasting_v1`.`production`.`project`"
  dimensions:
    - name: "production_phase"
      expr: production_phase
      comment: "Current production phase (Development, Pre-Production, Principal Photography, Post-Production, Delivered) for portfolio stage-gate analysis."
    - name: "greenlight_status"
      expr: greenlight_status
      comment: "Greenlight approval status for tracking projects through the studio approval pipeline."
    - name: "project_type"
      expr: project_type
      comment: "Project type (Series, Feature, Documentary, Short) for portfolio composition analysis."
    - name: "content_genre"
      expr: content_genre
      comment: "Content genre for genre-level investment and performance analysis."
    - name: "production_country"
      expr: production_country
      comment: "Country of production for tax incentive optimization and international co-production tracking."
    - name: "co_production_flag"
      expr: co_production_flag
      comment: "Flags co-productions for partnership cost-sharing and rights structure analysis."
    - name: "drm_required"
      expr: drm_required
      comment: "Flags projects requiring DRM for content protection cost and platform eligibility analysis."
    - name: "greenlight_date"
      expr: DATE_TRUNC('quarter', greenlight_date)
      comment: "Greenlight quarter for investment pipeline and slate planning analysis."
  measures:
    - name: "total_approved_budget"
      expr: SUM(CAST(approved_budget_usd AS DOUBLE))
      comment: "Total approved production budget across projects in USD. Primary portfolio investment metric for studio financial planning."
    - name: "total_actual_spend"
      expr: SUM(CAST(actual_spend_usd AS DOUBLE))
      comment: "Total actual spend across production projects. Tracks portfolio cost performance against approved budgets."
    - name: "portfolio_cost_variance"
      expr: SUM((CAST(approved_budget_usd AS DOUBLE)) - (CAST(actual_spend_usd AS DOUBLE)))
      comment: "Aggregate variance between approved budgets and actual spend across the portfolio. Negative values signal portfolio-level overrun requiring executive intervention."
    - name: "budget_utilization_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_spend_usd AS DOUBLE)) / NULLIF(SUM(CAST(approved_budget_usd AS DOUBLE)), 0), 2)
      comment: "Actual spend as a percentage of approved budget across the portfolio. Core portfolio financial health KPI."
    - name: "project_count"
      expr: COUNT(1)
      comment: "Total number of production projects. Measures portfolio scale and production slate size."
    - name: "avg_approved_budget"
      expr: AVG(CAST(approved_budget_usd AS DOUBLE))
      comment: "Average approved budget per project. Benchmarks investment scale and informs future greenlight budget setting."
    - name: "on_time_delivery_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN actual_delivery_date <= target_delivery_date THEN 1 ELSE 0 END) / NULLIF(COUNT(CASE WHEN actual_delivery_date IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of projects delivered on or before target delivery date. Tracks production schedule discipline — a key studio operational KPI."
    - name: "co_production_count"
      expr: SUM(CASE WHEN co_production_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of co-production projects. Tracks partnership-funded content volume for rights and revenue sharing analysis."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`production_rental_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Equipment rental cost and contract performance metrics for production asset management. Tracks rental spend, agreement status, and renewal patterns. Used by production managers and finance to optimize equipment procurement and vendor relationships."
  source: "`vibe_media_broadcasting_v1`.`production`.`rental_agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the rental agreement (Active, Expired, Cancelled) for contract portfolio management."
    - name: "rental_type"
      expr: rental_type
      comment: "Type of rental (Camera, Lighting, Grip, Sound, Vehicle) for equipment category cost analysis."
    - name: "rate_frequency"
      expr: rate_frequency
      comment: "Rental rate frequency (Daily, Weekly, Monthly) for rate structure analysis and cost optimization."
    - name: "auto_renewal"
      expr: auto_renewal
      comment: "Flags agreements with auto-renewal clauses — tracks unmanaged contract rollover risk."
    - name: "insurance_required"
      expr: insurance_required
      comment: "Flags agreements requiring insurance coverage for risk management and compliance tracking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the rental agreement for multi-currency cost consolidation."
    - name: "effective_start_date"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Agreement start month for rental spend trend analysis and seasonal equipment demand planning."
  measures:
    - name: "total_estimated_rental_cost"
      expr: SUM(CAST(estimated_total_amount AS DOUBLE))
      comment: "Total estimated rental cost across agreements. Primary equipment procurement cost commitment metric."
    - name: "total_deposit_amount"
      expr: SUM(CAST(deposit_amount AS DOUBLE))
      comment: "Total deposits held across rental agreements. Tracks cash tied up in equipment rental security deposits."
    - name: "total_damage_waiver_fee"
      expr: SUM(CAST(damage_waiver_fee AS DOUBLE))
      comment: "Total damage waiver fees paid. Tracks insurance cost for rented equipment and risk management spend."
    - name: "avg_rental_rate"
      expr: AVG(CAST(rental_rate AS DOUBLE))
      comment: "Average rental rate across agreements. Benchmarks vendor rate negotiation effectiveness."
    - name: "rental_agreement_count"
      expr: COUNT(1)
      comment: "Total rental agreements in scope. Measures equipment procurement volume and vendor relationship breadth."
    - name: "auto_renewal_exposure_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN auto_renewal = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of rental agreements with auto-renewal clauses. High values indicate unmanaged contract rollover risk and potential budget overcommitment."
$$;