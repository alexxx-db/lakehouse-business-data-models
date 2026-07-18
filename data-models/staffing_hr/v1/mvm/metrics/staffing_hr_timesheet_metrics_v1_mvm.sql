-- Metric views for domain: timesheet | Business: Staffing Hr | Version: 1 | Generated on: 2026-05-02 22:27:45

CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`timesheet`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core timesheet KPI layer tracking worker hours, billing, pay, and approval outcomes across all placements. Primary operational and financial steering view for workforce utilization and revenue recognition."
  source: "`staffing_hr_ecm_v1`.`timesheet`.`timesheet`"
  dimensions:
    - name: "approval_status"
      expr: approval_status
      comment: "Current approval state of the timesheet (e.g. Approved, Pending, Rejected) — used to segment KPIs by workflow stage."
    - name: "worker_type"
      expr: worker_type
      comment: "Classification of the worker (e.g. Temp, Contract, Direct Hire) — key segmentation for workforce mix analysis."
    - name: "pay_period_type"
      expr: pay_period_type
      comment: "Type of pay period (e.g. Weekly, Bi-Weekly) — used to normalize hour and revenue metrics across different pay cycles."
    - name: "flsa_classification"
      expr: flsa_classification
      comment: "FLSA exemption status (Exempt / Non-Exempt) — critical for overtime compliance and labor cost analysis."
    - name: "is_disputed"
      expr: is_disputed
      comment: "Flag indicating whether the timesheet is under dispute — used to isolate disputed revenue and hours from clean totals."
    - name: "is_late_submission"
      expr: is_late_submission
      comment: "Flag indicating whether the timesheet was submitted after the deadline — used to track submission compliance rates."
    - name: "pay_period_id"
      expr: pay_period_id
      comment: "Foreign key to the pay period — used to group KPIs by pay cycle for period-over-period trending."
    - name: "submitted_week"
      expr: DATE_TRUNC('week', submitted_timestamp)
      comment: "Week bucket derived from submission timestamp — enables weekly trend analysis of timesheet volume and hours."
    - name: "approved_week"
      expr: DATE_TRUNC('week', approved_timestamp)
      comment: "Week bucket derived from approval timestamp — enables weekly trend analysis of approval throughput."
  measures:
    - name: "total_timesheets"
      expr: COUNT(1)
      comment: "Total number of timesheet records submitted. Baseline volume metric for workforce activity and operational throughput."
    - name: "total_regular_hours"
      expr: SUM(CAST(regular_hours AS DOUBLE))
      comment: "Total straight-time hours worked across all timesheets. Core input to labor cost and billing revenue calculations."
    - name: "total_ot_hours"
      expr: SUM(CAST(ot_hours AS DOUBLE))
      comment: "Total overtime hours worked. Elevated OT signals scheduling inefficiency or understaffing and directly inflates labor cost."
    - name: "total_dt_hours"
      expr: SUM(CAST(dt_hours AS DOUBLE))
      comment: "Total double-time hours worked. High DT hours indicate premium labor cost exposure requiring management intervention."
    - name: "total_billable_hours"
      expr: SUM(CAST(billable_hours AS DOUBLE))
      comment: "Total hours eligible for client billing. Primary revenue driver metric — directly tied to invoiced revenue."
    - name: "total_holiday_hours"
      expr: SUM(CAST(holiday_hours AS DOUBLE))
      comment: "Total holiday hours recorded. Used to assess premium pay exposure and plan holiday staffing costs."
    - name: "total_pto_hours"
      expr: SUM(CAST(pto_hours AS DOUBLE))
      comment: "Total PTO hours consumed across timesheets. Tracks paid leave liability and workforce availability impact."
    - name: "total_unpaid_absence_hours"
      expr: SUM(CAST(unpaid_absence_hours AS DOUBLE))
      comment: "Total unpaid absence hours. Indicates unplanned workforce gaps that may affect client service delivery."
    - name: "total_hours"
      expr: SUM(CAST(total_hours AS DOUBLE))
      comment: "Total hours (all types) across all timesheets. Aggregate workforce engagement volume for capacity planning."
    - name: "avg_regular_hours_per_timesheet"
      expr: AVG(CAST(regular_hours AS DOUBLE))
      comment: "Average regular hours per timesheet submission. Benchmarks typical worker engagement level per pay period."
    - name: "avg_ot_hours_per_timesheet"
      expr: AVG(CAST(ot_hours AS DOUBLE))
      comment: "Average overtime hours per timesheet. Tracks overtime intensity per worker-period for cost control."
    - name: "total_bill_rate_weighted_sum"
      expr: SUM(CAST(bill_rate AS DOUBLE))
      comment: "Sum of bill rates across timesheets. Used as numerator for weighted average bill rate calculations in BI."
    - name: "avg_bill_rate"
      expr: AVG(CAST(bill_rate AS DOUBLE))
      comment: "Average bill rate per timesheet. Tracks pricing trends and rate mix across client engagements."
    - name: "avg_pay_rate"
      expr: AVG(CAST(pay_rate AS DOUBLE))
      comment: "Average pay rate per timesheet. Monitors labor cost trends and pay rate competitiveness."
    - name: "avg_ot_bill_rate"
      expr: AVG(CAST(ot_bill_rate AS DOUBLE))
      comment: "Average overtime bill rate. Tracks premium billing rate levels for OT-heavy engagements."
    - name: "avg_ot_pay_rate"
      expr: AVG(CAST(ot_pay_rate AS DOUBLE))
      comment: "Average overtime pay rate. Monitors OT pay cost exposure across the workforce."
    - name: "total_per_diem_amount"
      expr: SUM(CAST(per_diem_amount AS DOUBLE))
      comment: "Total per diem amounts claimed on timesheets. Tracks non-wage compensation expense for budget management."
    - name: "total_expense_amount"
      expr: SUM(CAST(expense_amount AS DOUBLE))
      comment: "Total expense amounts recorded on timesheets. Monitors reimbursable cost exposure across placements."
    - name: "disputed_timesheet_count"
      expr: COUNT(CASE WHEN is_disputed = TRUE THEN 1 END)
      comment: "Number of timesheets currently under dispute. High dispute volume signals billing accuracy or approval process issues."
    - name: "late_submission_count"
      expr: COUNT(CASE WHEN is_late_submission = TRUE THEN 1 END)
      comment: "Number of timesheets submitted after the deadline. Tracks submission compliance — late submissions delay payroll and billing cycles."
    - name: "approved_timesheet_count"
      expr: COUNT(CASE WHEN approval_status = 'Approved' THEN 1 END)
      comment: "Number of timesheets in Approved status. Numerator for approval rate KPI — measures workflow throughput."
    - name: "distinct_workers_with_timesheets"
      expr: COUNT(DISTINCT profile_id)
      comment: "Count of unique workers who submitted timesheets. Measures active workforce size within the selected period."
    - name: "distinct_client_accounts"
      expr: COUNT(DISTINCT client_account_id)
      comment: "Count of distinct client accounts with timesheet activity. Measures breadth of active client engagements."
$$;


CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`timesheet_approved_hours_summary`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Approved hours summary KPI layer providing authoritative billing and payroll totals after approval. Drives gross margin, billing transmission, and payroll release decisions."
  source: "`staffing_hr_ecm_v1`.`timesheet`.`approved_hours_summary`"
  dimensions:
    - name: "approval_status"
      expr: approval_status
      comment: "Approval state of the hours summary record — used to filter to fully approved records for revenue recognition."
    - name: "worker_type"
      expr: worker_type
      comment: "Worker classification (Temp, Contract, etc.) — key dimension for workforce mix and margin analysis."
    - name: "work_location_type"
      expr: work_location_type
      comment: "On-site vs. remote work location type — used to analyze billing and margin by work arrangement."
    - name: "flsa_exemption_status"
      expr: flsa_exemption_status
      comment: "FLSA exemption classification — critical for overtime compliance cost segmentation."
    - name: "billing_transmission_status"
      expr: billing_transmission_status
      comment: "Status of billing transmission to client systems — used to track billing pipeline and identify stuck records."
    - name: "payroll_transmission_status"
      expr: payroll_transmission_status
      comment: "Status of payroll transmission — used to monitor payroll release pipeline and identify processing delays."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the billing and pay amounts — required for multi-currency financial reporting."
    - name: "is_amended"
      expr: is_amended
      comment: "Flag indicating whether the summary has been amended — used to isolate amended records for audit and reconciliation."
    - name: "pay_period_start_date"
      expr: DATE_TRUNC('week', pay_period_start_date)
      comment: "Week bucket of pay period start — enables period-over-period trending of approved hours and billing."
    - name: "pay_period_end_date_month"
      expr: DATE_TRUNC('month', pay_period_end_date)
      comment: "Month bucket of pay period end date — supports monthly financial close and billing cycle reporting."
  measures:
    - name: "total_approved_summaries"
      expr: COUNT(1)
      comment: "Total number of approved hours summary records. Baseline volume metric for billing and payroll pipeline."
    - name: "total_regular_hours"
      expr: SUM(CAST(regular_hours AS DOUBLE))
      comment: "Total approved regular hours. Primary input to straight-time billing and payroll calculations."
    - name: "total_ot_hours"
      expr: SUM(CAST(ot_hours AS DOUBLE))
      comment: "Total approved overtime hours. Tracks OT cost exposure and premium billing volume."
    - name: "total_dt_hours"
      expr: SUM(CAST(dt_hours AS DOUBLE))
      comment: "Total approved double-time hours. Monitors premium labor cost at the approved/payable level."
    - name: "total_holiday_hours"
      expr: SUM(CAST(holiday_hours AS DOUBLE))
      comment: "Total approved holiday hours. Tracks holiday premium pay liability across the workforce."
    - name: "total_pto_hours"
      expr: SUM(CAST(pto_hours AS DOUBLE))
      comment: "Total approved PTO hours. Measures paid leave consumption impacting workforce availability and cost."
    - name: "total_hours"
      expr: SUM(CAST(total_hours AS DOUBLE))
      comment: "Total approved hours across all pay types. Aggregate workforce engagement volume for capacity and billing."
    - name: "total_billable_amount"
      expr: SUM(CAST(total_billable_amount AS DOUBLE))
      comment: "Total billable revenue amount from approved hours. Primary top-line revenue metric for the staffing business."
    - name: "total_payable_amount"
      expr: SUM(CAST(total_payable_amount AS DOUBLE))
      comment: "Total payable amount to workers from approved hours. Primary labor cost metric for gross margin calculation."
    - name: "total_gross_margin_amount"
      expr: SUM(CAST(gross_margin_amount AS DOUBLE))
      comment: "Total gross margin dollars (bill minus pay). Core profitability metric — directly steers pricing and cost management decisions."
    - name: "avg_bill_rate"
      expr: AVG(CAST(bill_rate AS DOUBLE))
      comment: "Average bill rate per approved summary. Tracks pricing trends and rate adequacy across client engagements."
    - name: "avg_pay_rate"
      expr: AVG(CAST(pay_rate AS DOUBLE))
      comment: "Average pay rate per approved summary. Monitors labor cost trends and pay competitiveness."
    - name: "avg_ot_bill_rate"
      expr: AVG(CAST(ot_bill_rate AS DOUBLE))
      comment: "Average OT bill rate. Tracks premium billing rate levels for overtime-heavy engagements."
    - name: "avg_dt_bill_rate"
      expr: AVG(CAST(dt_bill_rate AS DOUBLE))
      comment: "Average double-time bill rate. Monitors double-time billing rate adequacy for premium shift coverage."
    - name: "avg_burden_rate_pct"
      expr: AVG(CAST(burden_rate_pct AS DOUBLE))
      comment: "Average burden rate percentage. Tracks employer cost loading on pay rates — key input to true labor cost and margin."
    - name: "total_per_diem_amount"
      expr: SUM(CAST(per_diem_rate AS DOUBLE) * CAST(per_diem_units AS DOUBLE))
      comment: "Total per diem expense (rate × units) across approved summaries. Tracks non-wage compensation cost for budget control."
    - name: "amended_summary_count"
      expr: COUNT(CASE WHEN is_amended = TRUE THEN 1 END)
      comment: "Number of approved summaries that have been amended. High amendment rates signal timesheet accuracy or approval process issues."
    - name: "distinct_workers_billed"
      expr: COUNT(DISTINCT profile_id)
      comment: "Count of unique workers with approved billable hours. Measures active billable headcount for revenue capacity analysis."
    - name: "distinct_clients_billed"
      expr: COUNT(DISTINCT client_account_id)
      comment: "Count of distinct clients with approved billable hours. Measures revenue-generating client breadth."
$$;


CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`timesheet_shift`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shift-level KPI layer tracking actual vs. scheduled hours, overtime, per diem, and attendance compliance at the individual shift grain. Enables operational workforce management and scheduling efficiency analysis."
  source: "`staffing_hr_ecm_v1`.`timesheet`.`shift`"
  dimensions:
    - name: "shift_type"
      expr: shift_type
      comment: "Type of shift (Day, Evening, Night, etc.) — used to analyze hours, cost, and compliance by shift pattern."
    - name: "shift_status"
      expr: shift_status
      comment: "Current status of the shift record (Worked, Absent, Cancelled, etc.) — used to filter active vs. missed shifts."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval state of the shift — used to isolate approved shifts for billing and payroll processing."
    - name: "is_holiday"
      expr: is_holiday
      comment: "Flag indicating a holiday shift — used to segment premium pay and billing exposure."
    - name: "is_weekend"
      expr: is_weekend
      comment: "Flag indicating a weekend shift — used to analyze weekend premium cost and scheduling patterns."
    - name: "per_diem_eligible"
      expr: per_diem_eligible
      comment: "Flag indicating per diem eligibility for the shift — used to track per diem cost exposure."
    - name: "geofence_verified"
      expr: geofence_verified
      comment: "Flag indicating whether the worker's location was geofence-verified at punch — used for attendance integrity analysis."
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost center associated with the shift — enables cost allocation and departmental labor analysis."
    - name: "shift_date_week"
      expr: DATE_TRUNC('week', shift_date)
      comment: "Week bucket of the shift date — enables weekly workforce utilization and scheduling trend analysis."
    - name: "shift_date_month"
      expr: DATE_TRUNC('month', shift_date)
      comment: "Month bucket of the shift date — supports monthly labor cost and scheduling efficiency reporting."
  measures:
    - name: "total_shifts"
      expr: COUNT(1)
      comment: "Total number of shift records. Baseline volume metric for workforce scheduling and attendance tracking."
    - name: "total_worked_hours"
      expr: SUM(CAST(worked_hours AS DOUBLE))
      comment: "Total actual hours worked across all shifts. Primary measure of workforce output and billable activity."
    - name: "total_scheduled_hours"
      expr: SUM(CAST(scheduled_hours AS DOUBLE))
      comment: "Total hours scheduled across all shifts. Denominator for utilization rate — measures planned workforce capacity."
    - name: "total_billable_hours"
      expr: SUM(CAST(billable_hours AS DOUBLE))
      comment: "Total billable hours from shifts. Directly drives client invoice amounts and revenue recognition."
    - name: "total_payable_hours"
      expr: SUM(CAST(payable_hours AS DOUBLE))
      comment: "Total payable hours from shifts. Primary labor cost driver — used for payroll processing and cost control."
    - name: "total_ot_hours"
      expr: SUM(CAST(ot_hours AS DOUBLE))
      comment: "Total overtime hours across shifts. Tracks OT exposure — high OT signals scheduling gaps or demand spikes."
    - name: "total_dt_hours"
      expr: SUM(CAST(dt_hours AS DOUBLE))
      comment: "Total double-time hours across shifts. Monitors premium labor cost at the shift level."
    - name: "total_regular_hours"
      expr: SUM(CAST(regular_hours AS DOUBLE))
      comment: "Total regular (straight-time) hours across shifts. Core labor volume metric for standard billing and pay."
    - name: "total_per_diem_amount"
      expr: SUM(CAST(per_diem_amount AS DOUBLE))
      comment: "Total per diem amounts claimed across shifts. Tracks non-wage compensation expense for budget management."
    - name: "avg_worked_hours_per_shift"
      expr: AVG(CAST(worked_hours AS DOUBLE))
      comment: "Average hours worked per shift. Benchmarks shift productivity and identifies under-utilization patterns."
    - name: "avg_schedule_variance_minutes"
      expr: AVG(CAST(schedule_variance_minutes AS DOUBLE))
      comment: "Average schedule variance in minutes per shift. Measures scheduling accuracy — high variance indicates attendance or scheduling discipline issues."
    - name: "geofence_verified_shift_count"
      expr: COUNT(CASE WHEN geofence_verified = TRUE THEN 1 END)
      comment: "Number of shifts with geofence-verified attendance. Tracks location-based attendance integrity compliance."
    - name: "holiday_shift_count"
      expr: COUNT(CASE WHEN is_holiday = TRUE THEN 1 END)
      comment: "Number of holiday shifts worked. Used to quantify premium pay exposure and holiday staffing coverage."
    - name: "distinct_workers_scheduled"
      expr: COUNT(DISTINCT profile_id)
      comment: "Count of unique workers with shift records. Measures active scheduled headcount for capacity planning."
$$;


CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`timesheet_time_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Time entry KPI layer at the individual punch/entry grain. Tracks hours worked, pay rates, compliance (meal/rest breaks), and entry quality. Enables granular labor cost, compliance, and data quality analysis."
  source: "`staffing_hr_ecm_v1`.`timesheet`.`time_entry`"
  dimensions:
    - name: "entry_status"
      expr: entry_status
      comment: "Processing status of the time entry (Submitted, Approved, Rejected, etc.) — used to filter to valid entries for KPI calculation."
    - name: "entry_source"
      expr: entry_source
      comment: "Source system or method of time entry (Mobile, Web, Kronos, VMS, etc.) — used to analyze entry channel mix and data quality."
    - name: "pay_type"
      expr: pay_type
      comment: "Pay type classification (Regular, OT, DT, Holiday, PTO, etc.) — key dimension for labor cost segmentation."
    - name: "shift_type"
      expr: shift_type
      comment: "Type of shift associated with the time entry — used to analyze hours and cost by shift pattern."
    - name: "is_billable"
      expr: is_billable
      comment: "Flag indicating whether the time entry is billable to the client — used to separate billable from non-billable hours."
    - name: "is_payable"
      expr: is_payable
      comment: "Flag indicating whether the time entry is payable to the worker — used to identify non-payable entries for audit."
    - name: "meal_break_compliant"
      expr: meal_break_compliant
      comment: "Flag indicating meal break compliance — used to track labor law compliance and identify violation risk."
    - name: "rest_break_compliant"
      expr: rest_break_compliant
      comment: "Flag indicating rest break compliance — used to monitor rest break law adherence and compliance risk."
    - name: "state_code"
      expr: state_code
      comment: "State where work was performed — used for state-level labor law compliance and cost analysis."
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost center associated with the time entry — enables departmental labor cost allocation."
    - name: "entry_date_week"
      expr: DATE_TRUNC('week', entry_date)
      comment: "Week bucket of the entry date — enables weekly labor hours and compliance trend analysis."
    - name: "entry_date_month"
      expr: DATE_TRUNC('month', entry_date)
      comment: "Month bucket of the entry date — supports monthly labor cost and compliance reporting."
  measures:
    - name: "total_time_entries"
      expr: COUNT(1)
      comment: "Total number of time entry records. Baseline volume metric for time capture activity and data pipeline health."
    - name: "total_net_hours_worked"
      expr: SUM(CAST(net_hours_worked AS DOUBLE))
      comment: "Total net hours worked (after break deductions) across all time entries. Most accurate measure of actual labor delivered."
    - name: "avg_net_hours_per_entry"
      expr: AVG(CAST(net_hours_worked AS DOUBLE))
      comment: "Average net hours per time entry. Benchmarks typical daily/shift work duration for scheduling and cost planning."
    - name: "total_pto_hours"
      expr: SUM(CAST(pto_hours AS DOUBLE))
      comment: "Total PTO hours recorded in time entries. Tracks paid leave consumption at the entry level for liability management."
    - name: "total_per_diem_amount"
      expr: SUM(CAST(per_diem_amount AS DOUBLE))
      comment: "Total per diem amounts claimed in time entries. Monitors non-wage compensation expense at the granular entry level."
    - name: "avg_pay_rate"
      expr: AVG(CAST(pay_rate AS DOUBLE))
      comment: "Average pay rate across time entries. Tracks pay rate trends and cost competitiveness at the entry level."
    - name: "total_schedule_variance_hours"
      expr: SUM(CAST(schedule_variance_hours AS DOUBLE))
      comment: "Total schedule variance hours (actual vs. scheduled). Measures scheduling accuracy and attendance discipline across the workforce."
    - name: "avg_schedule_variance_hours"
      expr: AVG(CAST(schedule_variance_hours AS DOUBLE))
      comment: "Average schedule variance hours per entry. Identifies systematic over- or under-work patterns for scheduling optimization."
    - name: "meal_break_non_compliant_count"
      expr: COUNT(CASE WHEN meal_break_compliant = FALSE THEN 1 END)
      comment: "Number of time entries with meal break violations. Tracks labor law compliance risk — violations can trigger penalties and litigation."
    - name: "rest_break_non_compliant_count"
      expr: COUNT(CASE WHEN rest_break_compliant = FALSE THEN 1 END)
      comment: "Number of time entries with rest break violations. Monitors rest break law adherence — key compliance risk indicator."
    - name: "billable_entry_count"
      expr: COUNT(CASE WHEN is_billable = TRUE THEN 1 END)
      comment: "Number of billable time entries. Measures billable activity volume — numerator for billable utilization rate."
    - name: "non_billable_entry_count"
      expr: COUNT(CASE WHEN is_billable = FALSE THEN 1 END)
      comment: "Number of non-billable time entries. High non-billable volume signals revenue leakage or misclassification issues."
    - name: "distinct_workers_with_entries"
      expr: COUNT(DISTINCT profile_id)
      comment: "Count of unique workers with time entries. Measures active workforce size at the entry level for capacity analysis."
$$;


CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`timesheet_absence_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Absence record KPI layer tracking workforce absenteeism, FMLA usage, PTO consumption, and compliance. Enables absence management, leave liability, and workforce availability analysis."
  source: "`staffing_hr_ecm_v1`.`timesheet`.`absence_record`"
  dimensions:
    - name: "absence_type"
      expr: absence_type
      comment: "Type of absence (FMLA, PTO, Unexcused, Medical, etc.) — primary dimension for absence pattern analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval state of the absence record — used to separate approved from pending/rejected absences."
    - name: "fmla_qualifying"
      expr: fmla_qualifying
      comment: "Flag indicating FMLA-qualifying absence — used to track protected leave usage and compliance obligations."
    - name: "is_paid"
      expr: is_paid
      comment: "Flag indicating whether the absence is paid — used to segment paid vs. unpaid leave for cost analysis."
    - name: "is_partial_day"
      expr: is_partial_day
      comment: "Flag indicating a partial-day absence — used to distinguish full-day from intermittent leave patterns."
    - name: "unexcused_flag"
      expr: unexcused_flag
      comment: "Flag indicating an unexcused absence — used to track attendance policy violations and termination risk."
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Flag indicating an SLA breach related to the absence — used to monitor client notification and documentation SLA compliance."
    - name: "leave_reason_code"
      expr: leave_reason_code
      comment: "Coded reason for the absence — used to categorize absence causes for workforce health and policy analysis."
    - name: "absence_start_week"
      expr: DATE_TRUNC('week', absence_start_date)
      comment: "Week bucket of absence start date — enables weekly absenteeism trend analysis."
    - name: "absence_start_month"
      expr: DATE_TRUNC('month', absence_start_date)
      comment: "Month bucket of absence start date — supports monthly absence rate and leave liability reporting."
  measures:
    - name: "total_absence_records"
      expr: COUNT(1)
      comment: "Total number of absence records. Baseline absenteeism volume metric for workforce availability analysis."
    - name: "total_absence_hours"
      expr: SUM(CAST(absence_hours AS DOUBLE))
      comment: "Total hours lost to absence. Primary measure of workforce availability impact — directly affects client service delivery."
    - name: "total_absence_duration_days"
      expr: SUM(CAST(absence_duration_days AS DOUBLE))
      comment: "Total calendar days of absence. Measures workforce availability loss for capacity planning and client impact assessment."
    - name: "avg_absence_duration_days"
      expr: AVG(CAST(absence_duration_days AS DOUBLE))
      comment: "Average absence duration in days. Benchmarks typical absence length — longer averages may indicate serious health or engagement issues."
    - name: "total_fmla_hours_used"
      expr: SUM(CAST(fmla_hours_used AS DOUBLE))
      comment: "Total FMLA hours consumed. Tracks protected leave liability and remaining FMLA entitlement exposure."
    - name: "total_pto_hours_consumed"
      expr: SUM(CAST(pto_hours_consumed AS DOUBLE))
      comment: "Total PTO hours consumed through absences. Tracks paid leave liability drawdown and accrual balance management."
    - name: "avg_pto_balance_before_absence"
      expr: AVG(CAST(pto_balance_before AS DOUBLE))
      comment: "Average PTO balance at time of absence. Monitors leave balance adequacy — low balances signal potential unpaid leave risk."
    - name: "total_scheduled_hours_missed"
      expr: SUM(CAST(scheduled_hours AS DOUBLE))
      comment: "Total scheduled hours missed due to absence. Measures the operational gap created by absenteeism for staffing and backfill planning."
    - name: "unexcused_absence_count"
      expr: COUNT(CASE WHEN unexcused_flag = TRUE THEN 1 END)
      comment: "Number of unexcused absences. High unexcused counts signal attendance policy violations and potential termination triggers."
    - name: "fmla_qualifying_absence_count"
      expr: COUNT(CASE WHEN fmla_qualifying = TRUE THEN 1 END)
      comment: "Number of FMLA-qualifying absences. Tracks protected leave volume for compliance monitoring and legal risk management."
    - name: "sla_breach_absence_count"
      expr: COUNT(CASE WHEN sla_breach_flag = TRUE THEN 1 END)
      comment: "Number of absences that triggered an SLA breach. Measures absence management process compliance — breaches risk client penalties."
    - name: "replacement_requested_count"
      expr: COUNT(CASE WHEN replacement_requested = TRUE THEN 1 END)
      comment: "Number of absences where a replacement worker was requested. Measures operational impact severity and backfill demand."
    - name: "distinct_absent_workers"
      expr: COUNT(DISTINCT profile_id)
      comment: "Count of unique workers with absence records. Measures breadth of absenteeism across the workforce for pattern analysis."
$$;


CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`timesheet_adjustment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Timesheet adjustment KPI layer tracking billing and payroll corrections, retroactive changes, and adjustment financial impact. Enables billing accuracy, dispute resolution, and payroll integrity analysis."
  source: "`staffing_hr_ecm_v1`.`timesheet`.`adjustment`"
  dimensions:
    - name: "adjustment_type"
      expr: adjustment_type
      comment: "Type of adjustment (Rate Correction, Hours Correction, Retroactive, etc.) — primary dimension for adjustment root cause analysis."
    - name: "adjustment_status"
      expr: adjustment_status
      comment: "Current processing status of the adjustment — used to track adjustment pipeline and identify stuck records."
    - name: "reason_code"
      expr: reason_code
      comment: "Coded reason for the adjustment — used to categorize adjustment causes for process improvement analysis."
    - name: "affects_billing"
      expr: affects_billing
      comment: "Flag indicating whether the adjustment impacts billing — used to isolate billing-impacting adjustments for revenue reconciliation."
    - name: "affects_payroll"
      expr: affects_payroll
      comment: "Flag indicating whether the adjustment impacts payroll — used to isolate payroll-impacting adjustments for cost reconciliation."
    - name: "is_retroactive"
      expr: is_retroactive
      comment: "Flag indicating a retroactive adjustment — retroactive adjustments signal prior-period errors and compliance risk."
    - name: "approval_level"
      expr: approval_level
      comment: "Approval authority level required for the adjustment — used to analyze adjustment complexity and escalation patterns."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the adjustment amounts — required for multi-currency financial reconciliation."
    - name: "work_date_week"
      expr: DATE_TRUNC('week', work_date)
      comment: "Week bucket of the work date being adjusted — enables trending of adjustment volume by original work period."
    - name: "submitted_month"
      expr: DATE_TRUNC('month', submitted_timestamp)
      comment: "Month bucket of adjustment submission — supports monthly adjustment volume and financial impact reporting."
  measures:
    - name: "total_adjustments"
      expr: COUNT(1)
      comment: "Total number of adjustment records. Baseline metric for billing and payroll correction volume — high counts signal process quality issues."
    - name: "total_bill_amount_adjusted"
      expr: SUM(CAST(bill_amount_adjusted AS DOUBLE))
      comment: "Total adjusted billing amounts. Measures the financial magnitude of billing corrections — key revenue reconciliation metric."
    - name: "total_pay_amount_adjusted"
      expr: SUM(CAST(pay_amount_adjusted AS DOUBLE))
      comment: "Total adjusted payroll amounts. Measures the financial magnitude of payroll corrections — key labor cost reconciliation metric."
    - name: "total_bill_amount_delta"
      expr: SUM(CAST(bill_amount_adjusted AS DOUBLE) - CAST(bill_amount_original AS DOUBLE))
      comment: "Net change in billing amount due to adjustments (adjusted minus original). Measures net revenue impact of all billing corrections."
    - name: "total_pay_amount_delta"
      expr: SUM(CAST(pay_amount_adjusted AS DOUBLE) - CAST(pay_amount_original AS DOUBLE))
      comment: "Net change in pay amount due to adjustments (adjusted minus original). Measures net labor cost impact of all payroll corrections."
    - name: "total_hours_adjusted"
      expr: SUM(CAST(hours_adjusted AS DOUBLE))
      comment: "Total hours in adjusted records. Measures the volume of hours subject to correction for timesheet accuracy analysis."
    - name: "total_hours_delta"
      expr: SUM(CAST(hours_adjusted AS DOUBLE) - CAST(hours_original AS DOUBLE))
      comment: "Net change in hours due to adjustments (adjusted minus original). Measures net hours correction volume for accuracy tracking."
    - name: "retroactive_adjustment_count"
      expr: COUNT(CASE WHEN is_retroactive = TRUE THEN 1 END)
      comment: "Number of retroactive adjustments. High retroactive counts signal prior-period errors with compliance and financial restatement risk."
    - name: "billing_adjustment_count"
      expr: COUNT(CASE WHEN affects_billing = TRUE THEN 1 END)
      comment: "Number of adjustments impacting billing. Measures billing correction frequency — key indicator of invoice accuracy."
    - name: "payroll_adjustment_count"
      expr: COUNT(CASE WHEN affects_payroll = TRUE THEN 1 END)
      comment: "Number of adjustments impacting payroll. Measures payroll correction frequency — key indicator of pay accuracy and compliance."
    - name: "distinct_workers_adjusted"
      expr: COUNT(DISTINCT profile_id)
      comment: "Count of unique workers with adjustment records. Measures breadth of adjustment impact across the workforce."
$$;


CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`timesheet_approval_workflow`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Approval workflow KPI layer tracking timesheet approval cycle performance, SLA compliance, dispute rates, and billing/payroll release throughput. Enables approval process efficiency and SLA governance analysis."
  source: "`staffing_hr_ecm_v1`.`timesheet`.`approval_workflow`"
  dimensions:
    - name: "approval_status"
      expr: approval_status
      comment: "Current approval status of the workflow record — primary dimension for pipeline stage analysis."
    - name: "approval_stage"
      expr: approval_stage
      comment: "Stage in the multi-step approval workflow — used to identify bottlenecks in the approval process."
    - name: "approval_action"
      expr: approval_action
      comment: "Action taken at this workflow step (Approved, Rejected, Escalated, etc.) — used to analyze approval decision patterns."
    - name: "approver_role"
      expr: approver_role
      comment: "Role of the approver (Client Manager, Staffing Coordinator, etc.) — used to analyze approval throughput by role."
    - name: "approval_channel"
      expr: approval_channel
      comment: "Channel used for approval (Email, Portal, VMS, Mobile, etc.) — used to analyze channel adoption and efficiency."
    - name: "sla_compliant_flag"
      expr: sla_compliant_flag
      comment: "Flag indicating whether the approval met its SLA — primary dimension for SLA compliance analysis."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Flag indicating a disputed timesheet in the workflow — used to isolate disputed approvals for resolution tracking."
    - name: "final_approved_flag"
      expr: final_approved_flag
      comment: "Flag indicating final approval completion — used to measure end-to-end approval completion rates."
    - name: "billing_released_flag"
      expr: billing_released_flag
      comment: "Flag indicating billing has been released post-approval — used to track billing pipeline throughput."
    - name: "payroll_released_flag"
      expr: payroll_released_flag
      comment: "Flag indicating payroll has been released post-approval — used to track payroll pipeline throughput."
    - name: "work_week_end_date_week"
      expr: DATE_TRUNC('week', work_week_end_date)
      comment: "Week bucket of the work week end date — enables weekly approval throughput and SLA trend analysis."
  measures:
    - name: "total_workflow_records"
      expr: COUNT(1)
      comment: "Total number of approval workflow records. Baseline metric for approval activity volume and pipeline size."
    - name: "total_regular_hours_approved"
      expr: SUM(CAST(total_regular_hours AS DOUBLE))
      comment: "Total regular hours flowing through the approval workflow. Measures approved straight-time labor volume for billing and payroll."
    - name: "total_ot_hours_approved"
      expr: SUM(CAST(total_ot_hours AS DOUBLE))
      comment: "Total overtime hours flowing through the approval workflow. Tracks OT volume approved for billing and payroll processing."
    - name: "total_dt_hours_approved"
      expr: SUM(CAST(total_dt_hours AS DOUBLE))
      comment: "Total double-time hours flowing through the approval workflow. Monitors premium labor volume approved for processing."
    - name: "avg_bill_rate"
      expr: AVG(CAST(bill_rate AS DOUBLE))
      comment: "Average bill rate across workflow records. Tracks pricing levels flowing through the approval pipeline."
    - name: "avg_pay_rate"
      expr: AVG(CAST(pay_rate AS DOUBLE))
      comment: "Average pay rate across workflow records. Monitors labor cost levels in the approval pipeline."
    - name: "total_per_diem_amount"
      expr: SUM(CAST(per_diem_amount AS DOUBLE))
      comment: "Total per diem amounts in the approval workflow. Tracks non-wage compensation flowing through approval for cost management."
    - name: "sla_compliant_count"
      expr: COUNT(CASE WHEN sla_compliant_flag = TRUE THEN 1 END)
      comment: "Number of workflow records meeting SLA. Numerator for SLA compliance rate — measures approval process timeliness."
    - name: "sla_breach_count"
      expr: COUNT(CASE WHEN sla_compliant_flag = FALSE THEN 1 END)
      comment: "Number of workflow records breaching SLA. High SLA breach counts risk client penalties and payroll delays."
    - name: "disputed_workflow_count"
      expr: COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END)
      comment: "Number of disputed timesheet workflow records. Tracks dispute volume — high disputes signal billing accuracy or client relationship issues."
    - name: "final_approved_count"
      expr: COUNT(CASE WHEN final_approved_flag = TRUE THEN 1 END)
      comment: "Number of workflow records reaching final approval. Measures end-to-end approval completion throughput."
    - name: "billing_released_count"
      expr: COUNT(CASE WHEN billing_released_flag = TRUE THEN 1 END)
      comment: "Number of records with billing released. Measures billing pipeline throughput post-approval — key revenue cycle metric."
    - name: "payroll_released_count"
      expr: COUNT(CASE WHEN payroll_released_flag = TRUE THEN 1 END)
      comment: "Number of records with payroll released. Measures payroll pipeline throughput post-approval — key worker pay timeliness metric."
    - name: "distinct_clients_in_workflow"
      expr: COUNT(DISTINCT client_account_id)
      comment: "Count of distinct clients with active approval workflow records. Measures breadth of approval activity across the client base."
$$;


CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`timesheet_pay_period`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pay period configuration KPI layer tracking pay period structure, OT/DT thresholds, and payroll cycle characteristics. Enables payroll governance, compliance threshold monitoring, and period management analysis."
  source: "`staffing_hr_ecm_v1`.`timesheet`.`pay_period`"
  dimensions:
    - name: "period_type"
      expr: period_type
      comment: "Type of pay period (Weekly, Bi-Weekly, Semi-Monthly, Monthly) — primary dimension for payroll cycle analysis."
    - name: "period_status"
      expr: period_status
      comment: "Current status of the pay period (Open, Closed, Processing, etc.) — used to filter active vs. closed periods."
    - name: "payroll_run_type"
      expr: payroll_run_type
      comment: "Type of payroll run (Regular, Off-Cycle, Correction, etc.) — used to segment standard vs. exception payroll activity."
    - name: "is_current_period"
      expr: is_current_period
      comment: "Flag indicating the currently active pay period — used to filter real-time operational dashboards."
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter of the pay period — used for quarterly financial reporting and period-over-period analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the pay period — used for annual financial reporting and year-over-year trending."
    - name: "client_segment"
      expr: client_segment
      comment: "Client segment associated with the pay period — used to analyze payroll cycle characteristics by client tier."
    - name: "start_date_month"
      expr: DATE_TRUNC('month', start_date)
      comment: "Month bucket of pay period start date — enables monthly payroll cycle volume and threshold analysis."
  measures:
    - name: "total_pay_periods"
      expr: COUNT(1)
      comment: "Total number of pay period records. Baseline metric for payroll cycle volume and configuration completeness."
    - name: "avg_ot_threshold_hours"
      expr: AVG(CAST(ot_threshold_hours AS DOUBLE))
      comment: "Average OT threshold hours across pay periods. Monitors consistency of overtime thresholds — deviations may indicate compliance configuration errors."
    - name: "avg_dt_threshold_hours"
      expr: AVG(CAST(dt_threshold_hours AS DOUBLE))
      comment: "Average DT threshold hours across pay periods. Tracks double-time threshold configuration for compliance governance."
    - name: "avg_standard_hours"
      expr: AVG(CAST(standard_hours AS DOUBLE))
      comment: "Average standard hours per pay period. Benchmarks expected work hours per period for utilization and scheduling planning."
    - name: "active_pay_period_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Number of currently active pay periods. Monitors concurrent active periods — multiple active periods may indicate configuration issues."
    - name: "holiday_adjusted_period_count"
      expr: COUNT(CASE WHEN holiday_adjustment_flag = TRUE THEN 1 END)
      comment: "Number of pay periods with holiday adjustments. Tracks holiday-impacted payroll cycles for premium pay planning."
$$;


CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`timesheet_offboarding_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Offboarding record KPI layer tracking worker separation patterns, redeployment rates, PTO payouts, and offboarding process completion. Enables workforce attrition analysis, redeployment efficiency, and separation cost management."
  source: "`staffing_hr_ecm_v1`.`timesheet`.`offboarding_record`"
  dimensions:
    - name: "offboarding_type"
      expr: offboarding_type
      comment: "Type of offboarding (Assignment End, Resignation, Termination, Conversion, etc.) — primary dimension for attrition analysis."
    - name: "offboarding_status"
      expr: offboarding_status
      comment: "Current status of the offboarding process — used to track completion rates and identify stuck offboardings."
    - name: "exit_reason_category"
      expr: exit_reason_category
      comment: "Categorized reason for exit — used to analyze attrition drivers and inform retention strategies."
    - name: "rehire_eligibility"
      expr: rehire_eligibility
      comment: "Rehire eligibility status of the departing worker — used to manage talent pool quality and future placement potential."
    - name: "redeployment_flag"
      expr: redeployment_flag
      comment: "Flag indicating whether the worker was redeployed to another assignment — key metric for talent retention and revenue continuity."
    - name: "conversion_to_perm_flag"
      expr: conversion_to_perm_flag
      comment: "Flag indicating conversion to permanent employment — tracks temp-to-perm conversion rate, a key client value metric."
    - name: "final_timesheet_status"
      expr: final_timesheet_status
      comment: "Status of the final timesheet at offboarding — used to ensure clean payroll close and identify outstanding pay obligations."
    - name: "separation_month"
      expr: DATE_TRUNC('month', separation_date)
      comment: "Month bucket of separation date — enables monthly attrition trend analysis and workforce planning."
    - name: "last_day_worked_month"
      expr: DATE_TRUNC('month', last_day_worked)
      comment: "Month bucket of last day worked — used for workforce availability and billing impact analysis."
  measures:
    - name: "total_offboardings"
      expr: COUNT(1)
      comment: "Total number of offboarding records. Baseline attrition volume metric — tracks workforce turnover rate."
    - name: "total_pto_payout_amount"
      expr: SUM(CAST(pto_payout_amount AS DOUBLE))
      comment: "Total PTO payout amounts at separation. Measures accrued leave liability paid out — key separation cost metric."
    - name: "total_pto_payout_hours"
      expr: SUM(CAST(pto_payout_hours AS DOUBLE))
      comment: "Total PTO hours paid out at separation. Tracks leave liability drawdown volume at offboarding."
    - name: "avg_offboarding_checklist_completion_pct"
      expr: AVG(CAST(offboarding_checklist_completion_pct AS DOUBLE))
      comment: "Average offboarding checklist completion percentage. Measures process compliance — low completion rates signal compliance and access revocation risks."
    - name: "redeployment_count"
      expr: COUNT(CASE WHEN redeployment_flag = TRUE THEN 1 END)
      comment: "Number of workers redeployed to new assignments. Measures talent retention success — redeployment preserves revenue and reduces recruitment cost."
    - name: "conversion_to_perm_count"
      expr: COUNT(CASE WHEN conversion_to_perm_flag = TRUE THEN 1 END)
      comment: "Number of temp-to-perm conversions. Tracks a key client value delivery metric — conversions generate placement fees and demonstrate staffing quality."
    - name: "system_access_not_revoked_count"
      expr: COUNT(CASE WHEN system_access_revoked = FALSE THEN 1 END)
      comment: "Number of offboardings where system access was not revoked. Critical security compliance metric — unrevoked access is a data breach risk."
    - name: "rehire_eligible_count"
      expr: COUNT(CASE WHEN rehire_eligibility = 'Eligible' THEN 1 END)
      comment: "Number of departing workers eligible for rehire. Measures quality of the redeployable talent pool for future placement opportunities."
    - name: "distinct_clients_with_offboardings"
      expr: COUNT(DISTINCT client_account_id)
      comment: "Count of distinct clients with offboarding activity. Measures breadth of attrition impact across the client portfolio."
$$;
