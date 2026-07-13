-- Metric views for domain: workforce | Business: Shipping_Ports | Version: 2 | Generated on: 2026-07-13 07:51:56

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`workforce_gang_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational productivity and labour efficiency metrics for stevedoring gang deployments. Tracks moves-per-hour, TEU throughput, overtime, and stoppage performance at the gang-deployment level — the primary operational KPI surface for terminal labour management."
  source: "`vibe_shipping_ports_v1`.`workforce`.`gang_assignment`"
  dimensions:
    - name: "deployment_date"
      expr: deployment_date
      comment: "Date of the gang deployment, used to trend productivity over time."
    - name: "operation_type"
      expr: operation_type
      comment: "Type of cargo operation (discharge, load, shift, etc.) for segmenting productivity by work type."
    - name: "gang_type"
      expr: gang_type
      comment: "Classification of the gang (crane, hatch, lashing, etc.) for comparing productivity across gang specialisations."
    - name: "shift_type"
      expr: shift_type
      comment: "Day/night/weekend shift classification to analyse productivity variation by shift."
    - name: "cargo_type"
      expr: cargo_type
      comment: "Cargo category handled (container, bulk, RoRo, etc.) for throughput segmentation."
    - name: "deployment_status"
      expr: deployment_status
      comment: "Current status of the deployment (active, completed, cancelled) for filtering live vs historical records."
    - name: "imdg_cargo_flag"
      expr: imdg_cargo_flag
      comment: "Indicates whether the deployment involved IMDG dangerous goods, enabling DG-specific productivity and safety analysis."
    - name: "is_overtime_approved"
      expr: is_overtime_approved
      comment: "Whether overtime was pre-approved, used to distinguish planned vs unplanned overtime cost."
  measures:
    - name: "total_deployments"
      expr: COUNT(1)
      comment: "Total number of gang deployments. Baseline volume metric for labour demand analysis."
    - name: "total_teu_handled"
      expr: SUM(CAST(teu_handled AS DOUBLE))
      comment: "Total TEU throughput across all gang deployments. Primary terminal throughput KPI directly linked to revenue and berth utilisation."
    - name: "avg_teu_per_gang_hour"
      expr: AVG(CAST(teu_per_gang_hour AS DOUBLE))
      comment: "Average TEU handled per gang-hour. Core stevedoring productivity KPI used in SLA compliance and gang performance benchmarking."
    - name: "total_gross_hours_worked"
      expr: SUM(CAST(gross_hours_worked AS DOUBLE))
      comment: "Total gross labour hours consumed across all deployments. Drives labour cost and capacity planning decisions."
    - name: "total_net_hours_worked"
      expr: SUM(CAST(net_hours_worked AS DOUBLE))
      comment: "Total productive (net) labour hours after deducting stoppages. Used to compute effective utilisation rate."
    - name: "total_stoppage_hours"
      expr: SUM(CAST(stoppage_hours AS DOUBLE))
      comment: "Total hours lost to stoppages (equipment breakdown, weather, industrial action). High stoppage hours signal operational risk and cost overrun."
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours incurred. Directly drives penalty-rate labour cost and is a key input to payroll variance analysis."
    - name: "avg_moves_per_hour"
      expr: AVG(CAST(moves_per_hour AS DOUBLE))
      comment: "Average crane/gang moves per hour. Standard KPI for benchmarking terminal operational efficiency against industry norms (e.g. 25–30 MPH for modern container terminals)."
    - name: "safety_incident_deployments"
      expr: SUM(CAST(CASE WHEN is_safety_incident = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Count of deployments where a safety incident was recorded. Safety frequency rate input; triggers HSE investigation and corrective action workflows."
    - name: "stoppage_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(stoppage_hours AS DOUBLE)) / NULLIF(SUM(CAST(gross_hours_worked AS DOUBLE)), 0), 2)
      comment: "Percentage of gross hours lost to stoppages. Operational efficiency KPI — high stoppage rate indicates equipment reliability or industrial relations issues requiring management intervention."
    - name: "overtime_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(overtime_hours AS DOUBLE)) / NULLIF(SUM(CAST(gross_hours_worked AS DOUBLE)), 0), 2)
      comment: "Overtime as a percentage of total gross hours. Labour cost control KPI — sustained high overtime signals under-resourcing or poor roster planning."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`workforce_payroll_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payroll cost and compliance metrics at the payroll-run level. Enables finance and HR leadership to monitor total labour cost, tax liability, pension obligations, union dues, and MLC payroll compliance across pay periods and organisational units."
  source: "`vibe_shipping_ports_v1`.`workforce`.`payroll_run`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the payroll run for annual cost trend analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period (month/quarter) for periodic payroll cost reporting."
    - name: "pay_frequency"
      expr: pay_frequency
      comment: "Pay frequency (weekly, fortnightly, monthly) to segment payroll cost by pay cycle type."
    - name: "pay_group_code"
      expr: pay_group_code
      comment: "Pay group classification (stevedores, pilots, admin, etc.) for cost allocation by workforce segment."
    - name: "run_type"
      expr: run_type
      comment: "Type of payroll run (regular, supplementary, reversal) to isolate normal vs exception payroll costs."
    - name: "run_status"
      expr: run_status
      comment: "Current status of the payroll run (draft, approved, posted, reversed) for pipeline monitoring."
    - name: "mlc_compliant"
      expr: mlc_compliant
      comment: "Whether the payroll run is MLC-compliant. Maritime Labour Convention compliance flag for regulatory reporting."
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Indicates a reversal run, used to exclude or isolate corrections from trend analysis."
    - name: "cost_centre_code"
      expr: cost_centre_code
      comment: "Cost centre for financial allocation of payroll costs to operational units."
  measures:
    - name: "total_payroll_runs"
      expr: COUNT(1)
      comment: "Total number of payroll runs processed. Baseline operational volume metric."
    - name: "total_gross_pay"
      expr: SUM(CAST(gross_pay_total AS DOUBLE))
      comment: "Total gross payroll cost across all runs. Primary labour cost KPI for budget vs actual variance reporting."
    - name: "total_net_pay"
      expr: SUM(CAST(net_pay_total AS DOUBLE))
      comment: "Total net pay disbursed to employees. Cash flow planning metric for treasury management."
    - name: "total_base_pay"
      expr: SUM(CAST(total_base_pay AS DOUBLE))
      comment: "Total base salary component. Used to isolate fixed labour cost from variable allowances and overtime."
    - name: "total_overtime_pay"
      expr: SUM(CAST(total_overtime_pay AS DOUBLE))
      comment: "Total overtime pay cost. High overtime pay signals roster inefficiency or operational surge — key input to workforce planning decisions."
    - name: "total_allowances"
      expr: SUM(CAST(total_allowances AS DOUBLE))
      comment: "Total allowances paid (shift, danger, meal, etc.). Tracks variable pay components that inflate total labour cost beyond base salary."
    - name: "total_deductions"
      expr: SUM(CAST(total_deductions AS DOUBLE))
      comment: "Total deductions (tax, pension, union dues, other). Reconciliation metric for payroll accuracy audits."
    - name: "total_tax_withheld"
      expr: SUM(CAST(total_tax_withheld AS DOUBLE))
      comment: "Total income tax withheld. Regulatory compliance metric for tax authority reporting."
    - name: "total_pension_deductions"
      expr: SUM(CAST(total_pension_deductions AS DOUBLE))
      comment: "Total pension/superannuation deductions. Tracks retirement benefit obligations and MLC social security compliance."
    - name: "total_union_dues"
      expr: SUM(CAST(total_union_dues AS DOUBLE))
      comment: "Total union dues deducted. Labour relations metric — tracks union membership cost and compliance with labour agreement remittance obligations."
    - name: "total_employer_contributions"
      expr: SUM(CAST(total_employer_contributions AS DOUBLE))
      comment: "Total employer-side contributions (pension, insurance, etc.). Full employment cost metric beyond gross pay for true labour cost accounting."
    - name: "overtime_pay_pct_of_gross"
      expr: ROUND(100.0 * SUM(CAST(total_overtime_pay AS DOUBLE)) / NULLIF(SUM(CAST(gross_pay_total AS DOUBLE)), 0), 2)
      comment: "Overtime pay as a percentage of total gross pay. Structural labour cost efficiency KPI — sustained high ratio indicates chronic under-staffing or poor shift planning."
    - name: "avg_gross_pay_per_run"
      expr: AVG(CAST(gross_pay_total AS DOUBLE))
      comment: "Average gross payroll cost per run. Useful for detecting anomalous payroll runs that deviate significantly from the norm."
    - name: "mlc_non_compliant_runs"
      expr: SUM(CAST(CASE WHEN mlc_compliant = FALSE THEN 1 ELSE 0 END AS INT))
      comment: "Count of payroll runs flagged as MLC non-compliant. Maritime Labour Convention regulatory risk metric — non-compliant runs expose the port operator to PSC detention and flag-state sanctions."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`workforce_time_attendance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce attendance, hours, and MLC rest-hour compliance metrics. Enables operations and HR to monitor actual vs scheduled hours, overtime incidence, MLC rest-hour violations, and absenteeism patterns across shifts, berths, and port locations."
  source: "`vibe_shipping_ports_v1`.`workforce`.`time_attendance`"
  dimensions:
    - name: "attendance_date"
      expr: attendance_date
      comment: "Date of the attendance record for daily and weekly trend analysis."
    - name: "shift_type"
      expr: shift_type
      comment: "Shift classification (day, night, weekend) for attendance pattern analysis by shift."
    - name: "attendance_status"
      expr: attendance_status
      comment: "Attendance outcome (present, absent, late, partial) for absenteeism and punctuality reporting."
    - name: "absence_type"
      expr: absence_type
      comment: "Category of absence (sick, leave, AWOL, etc.) for absence root-cause analysis."
    - name: "mlc_rest_hours_compliant"
      expr: mlc_rest_hours_compliant
      comment: "MLC rest-hour compliance flag. Maritime Labour Convention requirement — non-compliance triggers regulatory risk and crew welfare concerns."
    - name: "is_public_holiday"
      expr: is_public_holiday
      comment: "Public holiday indicator for isolating penalty-rate cost drivers."
    - name: "biometric_verified"
      expr: biometric_verified
      comment: "Whether attendance was verified biometrically. Data quality and fraud-prevention dimension."
    - name: "payroll_processed"
      expr: payroll_processed
      comment: "Whether the attendance record has been processed in payroll. Used to identify unprocessed records that may cause payroll errors."
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost centre for labour cost allocation of attendance hours."
  measures:
    - name: "total_attendance_records"
      expr: COUNT(1)
      comment: "Total attendance records. Baseline volume metric for workforce presence tracking."
    - name: "total_hours_worked"
      expr: SUM(CAST(hours_worked AS DOUBLE))
      comment: "Total productive hours worked. Primary labour input metric for throughput-per-hour and cost-per-TEU calculations."
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours across all attendance records. Labour cost escalation indicator — high overtime drives penalty-rate payroll cost."
    - name: "avg_hours_worked_per_shift"
      expr: AVG(CAST(hours_worked AS DOUBLE))
      comment: "Average hours worked per attendance record/shift. Detects systematic under- or over-utilisation of scheduled labour."
    - name: "avg_rest_hours_before_shift"
      expr: AVG(CAST(rest_hours_before_shift AS DOUBLE))
      comment: "Average rest hours preceding each shift. MLC Title 2 compliance metric — average below 10 hours signals systemic fatigue risk requiring roster redesign."
    - name: "mlc_rest_violation_count"
      expr: SUM(CAST(CASE WHEN mlc_rest_hours_compliant = FALSE THEN 1 ELSE 0 END AS INT))
      comment: "Count of attendance records where MLC minimum rest hours were violated. Regulatory compliance KPI — each violation is a potential PSC deficiency and crew welfare liability."
    - name: "mlc_rest_violation_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN mlc_rest_hours_compliant = FALSE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of shifts with MLC rest-hour violations. Trend metric for fatigue management programme effectiveness — target should be 0%."
    - name: "absenteeism_count"
      expr: SUM(CAST(CASE WHEN attendance_status = 'absent' THEN 1 ELSE 0 END AS INT))
      comment: "Count of absent shifts. Absenteeism volume metric — high absenteeism degrades gang complement and terminal throughput."
    - name: "overtime_incidence_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN overtime_hours > 0 THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of shifts where overtime was worked. Structural overtime dependency indicator — high rate signals chronic under-staffing."
    - name: "unprocessed_payroll_records"
      expr: SUM(CAST(CASE WHEN payroll_processed = FALSE THEN 1 ELSE 0 END AS INT))
      comment: "Count of attendance records not yet processed in payroll. Payroll accuracy risk metric — unprocessed records lead to underpayment and MLC wage compliance failures."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`workforce_headcount_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce planning and headcount budget vs actual metrics. Enables HR and operations leadership to monitor staffing gaps, labour cost variances, and planning accuracy across organisational units, port locations, and fiscal periods."
  source: "`vibe_shipping_ports_v1`.`workforce`.`headcount_plan`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the headcount plan for annual workforce planning cycle analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly/quarterly headcount tracking against budget."
    - name: "employment_type"
      expr: employment_type
      comment: "Employment type (permanent, casual, contract) for workforce composition analysis."
    - name: "employment_category"
      expr: employment_category
      comment: "Employment category (stevedore, pilot, admin, etc.) for functional headcount segmentation."
    - name: "job_family"
      expr: job_family
      comment: "Job family grouping for skills-based workforce planning analysis."
    - name: "plan_status"
      expr: plan_status
      comment: "Status of the headcount plan (draft, approved, active, closed) for pipeline monitoring."
    - name: "isps_clearance_required"
      expr: isps_clearance_required
      comment: "Whether ISPS security clearance is required for the planned positions. Security-sensitive headcount planning dimension."
    - name: "mlc_compliant"
      expr: mlc_compliant
      comment: "MLC compliance flag for the headcount plan. Ensures planned workforce meets Maritime Labour Convention requirements."
    - name: "cost_centre_code"
      expr: cost_centre_code
      comment: "Cost centre for financial allocation of planned headcount costs."
  measures:
    - name: "total_budgeted_headcount"
      expr: SUM(CAST(budgeted_headcount AS DOUBLE))
      comment: "Total budgeted headcount positions. Primary workforce capacity planning metric — drives recruitment, training, and labour cost budgets."
    - name: "total_actual_headcount"
      expr: SUM(CAST(actual_headcount AS DOUBLE))
      comment: "Total actual filled headcount. Compared against budget to identify staffing gaps that risk throughput targets."
    - name: "total_headcount_variance"
      expr: SUM(CAST(variance_headcount AS DOUBLE))
      comment: "Total variance between budgeted and actual headcount. Negative variance indicates under-staffing risk; positive indicates over-staffing cost."
    - name: "total_budgeted_labour_cost"
      expr: SUM(CAST(budgeted_labour_cost AS DOUBLE))
      comment: "Total budgeted labour cost. Primary financial planning metric for labour cost management."
    - name: "total_actual_labour_cost"
      expr: SUM(CAST(actual_labour_cost AS DOUBLE))
      comment: "Total actual labour cost incurred. Compared against budget to identify cost overruns requiring management action."
    - name: "labour_cost_variance"
      expr: SUM((CAST(actual_labour_cost AS DOUBLE)) - (CAST(budgeted_labour_cost AS DOUBLE)))
      comment: "Actual minus budgeted labour cost. Positive value indicates cost overrun; negative indicates underspend. Key financial control metric."
    - name: "headcount_fill_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_headcount AS DOUBLE)) / NULLIF(SUM(CAST(budgeted_headcount AS DOUBLE)), 0), 2)
      comment: "Actual headcount as a percentage of budgeted headcount. Staffing adequacy KPI — below 90% signals material risk to operational throughput and SLA delivery."
    - name: "avg_productivity_target_teu_per_gang_hour"
      expr: AVG(CAST(productivity_target_teu_per_gang_hour AS DOUBLE))
      comment: "Average planned TEU-per-gang-hour productivity target. Benchmarking metric linking workforce planning to throughput commitments."
    - name: "labour_cost_variance_pct"
      expr: ROUND(100.0 * (SUM(CAST(actual_labour_cost AS DOUBLE)) - SUM(CAST(budgeted_labour_cost AS DOUBLE))) / NULLIF(SUM(CAST(budgeted_labour_cost AS DOUBLE)), 0), 2)
      comment: "Labour cost variance as a percentage of budget. Normalised cost control KPI enabling comparison across cost centres and periods."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`workforce_training_enrolment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Training completion, compliance, and effectiveness metrics. Enables HR and compliance leadership to monitor mandatory training completion rates, STCW/ISPS/MLC certification compliance, training cost, and assessment pass rates across the workforce."
  source: "`vibe_shipping_ports_v1`.`workforce`.`training_enrolment`"
  dimensions:
    - name: "enrolment_status"
      expr: enrolment_status
      comment: "Status of the training enrolment (enrolled, in-progress, completed, withdrawn, failed) for pipeline and completion analysis."
    - name: "training_delivery_method"
      expr: training_delivery_method
      comment: "Delivery mode (classroom, e-learning, simulator, on-the-job) for cost and effectiveness comparison."
    - name: "mandatory_compliance_flag"
      expr: mandatory_compliance_flag
      comment: "Whether the training is mandatory for compliance (STCW, ISPS, MLC). Separates regulatory-critical training from developmental training."
    - name: "isps_compliant"
      expr: isps_compliant
      comment: "ISPS compliance flag for the training record. Port security regulatory compliance dimension."
    - name: "mlc_compliant"
      expr: mlc_compliant
      comment: "MLC compliance flag for the training record. Maritime Labour Convention regulatory compliance dimension."
    - name: "certification_issued_flag"
      expr: certification_issued_flag
      comment: "Whether a certification was issued upon completion. Distinguishes training that produces a regulatory credential from awareness training."
    - name: "recertification_required_flag"
      expr: recertification_required_flag
      comment: "Whether recertification is required. Used to forecast future training demand and cost."
    - name: "enrolment_date"
      expr: enrolment_date
      comment: "Date of enrolment for training demand trend analysis."
    - name: "cost_centre_code"
      expr: cost_centre_code
      comment: "Cost centre for training cost allocation."
  measures:
    - name: "total_enrolments"
      expr: COUNT(1)
      comment: "Total training enrolments. Baseline training activity volume metric."
    - name: "completed_enrolments"
      expr: SUM(CAST(CASE WHEN enrolment_status = 'completed' THEN 1 ELSE 0 END AS INT))
      comment: "Count of completed training enrolments. Primary training delivery effectiveness metric."
    - name: "training_completion_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN enrolment_status = 'completed' THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of enrolments completed. Core training KPI — low completion rate on mandatory courses creates regulatory compliance risk (STCW, ISPS, MLC)."
    - name: "certification_issuance_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN certification_issued_flag = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of enrolments resulting in a certification. Measures training programme effectiveness in producing regulatory credentials."
    - name: "total_training_cost"
      expr: SUM(CAST(training_cost_amount AS DOUBLE))
      comment: "Total training expenditure. Primary training budget metric — enables cost-per-certification and ROI analysis."
    - name: "avg_training_cost_per_enrolment"
      expr: AVG(CAST(training_cost_amount AS DOUBLE))
      comment: "Average training cost per enrolment. Cost efficiency benchmark for comparing delivery methods and providers."
    - name: "total_training_hours"
      expr: SUM(CAST(training_hours AS DOUBLE))
      comment: "Total training hours delivered. Workforce development investment metric — tracks learning hours per employee and against regulatory minimums."
    - name: "avg_assessment_score"
      expr: AVG(CAST(assessment_score AS DOUBLE))
      comment: "Average assessment score across completed enrolments. Training quality and workforce competency level indicator."
    - name: "withdrawal_count"
      expr: SUM(CAST(CASE WHEN enrolment_status = 'withdrawn' THEN 1 ELSE 0 END AS INT))
      comment: "Count of training withdrawals. High withdrawal rate on mandatory courses signals scheduling conflicts or operational pressure overriding compliance obligations."
    - name: "avg_attendance_percentage"
      expr: AVG(CAST(attendance_percentage AS DOUBLE))
      comment: "Average attendance percentage across enrolments. Training engagement metric — low attendance predicts poor assessment outcomes and certification failure."
    - name: "mandatory_completion_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN mandatory_compliance_flag = TRUE AND enrolment_status = 'completed' THEN 1 ELSE 0 END AS INT)) / NULLIF(SUM(CAST(CASE WHEN mandatory_compliance_flag = TRUE THEN 1 ELSE 0 END AS INT)), 0), 2)
      comment: "Completion rate for mandatory compliance training only (STCW, ISPS, MLC). Regulatory risk KPI — below 100% indicates employees operating without required certifications, exposing the port to PSC detention and flag-state sanctions."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`workforce_employee_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Employee certification currency, compliance, and expiry risk metrics. Enables HR and compliance teams to monitor STCW, ISPS, and MLC certification status, identify expiring credentials, and ensure the workforce maintains required regulatory qualifications."
  source: "`vibe_shipping_ports_v1`.`workforce`.`employee_certification`"
  dimensions:
    - name: "certification_type"
      expr: certification_type
      comment: "Type of certification (STCW, ISPS, MLC, medical, pilotage, etc.) for compliance segmentation."
    - name: "certification_status"
      expr: certification_status
      comment: "Current status of the certification (active, expired, suspended, revoked) for compliance risk monitoring."
    - name: "isps_compliant_flag"
      expr: isps_compliant_flag
      comment: "ISPS compliance flag for the certification. Port security regulatory compliance dimension."
    - name: "mlc_compliant_flag"
      expr: mlc_compliant_flag
      comment: "MLC compliance flag for the certification. Maritime Labour Convention regulatory compliance dimension."
    - name: "stcw_compliant_flag"
      expr: stcw_compliant_flag
      comment: "STCW compliance flag. Standards of Training, Certification and Watchkeeping regulatory compliance dimension."
    - name: "mandatory_flag"
      expr: mandatory_flag
      comment: "Whether the certification is mandatory for the role. Separates regulatory-critical credentials from optional qualifications."
    - name: "deployment_eligible_flag"
      expr: deployment_eligible_flag
      comment: "Whether the employee is eligible for deployment based on this certification. Operational readiness dimension."
    - name: "issuing_authority"
      expr: issuing_authority
      comment: "Authority that issued the certification for quality and recognition analysis."
    - name: "expiry_date"
      expr: expiry_date
      comment: "Certification expiry date for time-based compliance risk analysis."
  measures:
    - name: "total_certifications"
      expr: COUNT(1)
      comment: "Total certification records. Baseline credential inventory metric."
    - name: "active_certifications"
      expr: SUM(CAST(CASE WHEN certification_status = 'active' THEN 1 ELSE 0 END AS INT))
      comment: "Count of currently active certifications. Workforce compliance readiness metric."
    - name: "expired_certifications"
      expr: SUM(CAST(CASE WHEN certification_status = 'expired' THEN 1 ELSE 0 END AS INT))
      comment: "Count of expired certifications. Regulatory risk metric — expired mandatory certifications (STCW, ISPS) mean employees cannot legally perform their duties."
    - name: "certification_currency_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN certification_status = 'active' THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of certifications that are currently active/current. Workforce compliance health KPI — below 95% on mandatory certifications is a regulatory red flag."
    - name: "renewal_notification_pending"
      expr: SUM(CAST(CASE WHEN renewal_notification_sent_flag = FALSE AND certification_status = 'active' THEN 1 ELSE 0 END AS INT))
      comment: "Count of active certifications where renewal notification has not been sent. Proactive compliance risk metric — identifies certifications at risk of lapsing without employee awareness."
    - name: "avg_assessment_score"
      expr: AVG(CAST(assessment_score AS DOUBLE))
      comment: "Average assessment score at certification. Workforce competency quality metric — low scores indicate training effectiveness issues."
    - name: "deployment_ineligible_count"
      expr: SUM(CAST(CASE WHEN deployment_eligible_flag = FALSE THEN 1 ELSE 0 END AS INT))
      comment: "Count of certifications where the employee is not deployment-eligible. Operational capacity risk metric — high count reduces available gang complement."
    - name: "mandatory_expired_count"
      expr: SUM(CAST(CASE WHEN mandatory_flag = TRUE AND certification_status = 'expired' THEN 1 ELSE 0 END AS INT))
      comment: "Count of expired mandatory certifications. Critical compliance risk KPI — each expired mandatory cert represents an employee who cannot legally perform their role, creating operational and regulatory liability."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`workforce_performance_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Employee performance rating distribution, compensation adjustment, and succession pipeline metrics. Enables HR and executive leadership to monitor workforce performance health, identify high-potential talent, and manage compensation adjustment decisions."
  source: "`vibe_shipping_ports_v1`.`workforce`.`performance_review`"
  dimensions:
    - name: "review_type"
      expr: review_type
      comment: "Type of performance review (annual, mid-year, probation, etc.) for segmenting review cycles."
    - name: "review_status"
      expr: review_status
      comment: "Status of the review (draft, submitted, calibrated, finalised) for pipeline monitoring."
    - name: "overall_performance_rating"
      expr: overall_performance_rating
      comment: "Overall performance rating category (exceeds, meets, below expectations, etc.) for rating distribution analysis."
    - name: "review_period_end_date"
      expr: review_period_end_date
      comment: "End date of the review period for annual and periodic performance trend analysis."
    - name: "high_potential_flag"
      expr: high_potential_flag
      comment: "High-potential employee flag for talent pipeline and succession planning analysis."
    - name: "succession_candidate_flag"
      expr: succession_candidate_flag
      comment: "Succession candidate flag for leadership pipeline depth analysis."
    - name: "promotion_readiness_flag"
      expr: promotion_readiness_flag
      comment: "Promotion readiness flag for internal mobility and career progression planning."
    - name: "performance_improvement_plan_flag"
      expr: performance_improvement_plan_flag
      comment: "Whether the employee is on a performance improvement plan. Risk indicator for involuntary attrition and operational capability gaps."
    - name: "bonus_eligibility_flag"
      expr: bonus_eligibility_flag
      comment: "Bonus eligibility flag for compensation cost forecasting."
  measures:
    - name: "total_reviews"
      expr: COUNT(1)
      comment: "Total performance reviews. Baseline metric for review cycle completion tracking."
    - name: "completed_reviews"
      expr: SUM(CAST(CASE WHEN review_status = 'finalised' THEN 1 ELSE 0 END AS INT))
      comment: "Count of finalised performance reviews. Review completion rate input — incomplete reviews delay compensation decisions and succession planning."
    - name: "avg_overall_rating_score"
      expr: AVG(CAST(overall_rating_score AS DOUBLE))
      comment: "Average overall performance rating score. Workforce performance health KPI — declining average signals talent quality or engagement issues."
    - name: "high_potential_count"
      expr: SUM(CAST(CASE WHEN high_potential_flag = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Count of employees identified as high-potential. Talent pipeline depth metric — critical for succession planning at hub ports with complex operations."
    - name: "succession_candidate_count"
      expr: SUM(CAST(CASE WHEN succession_candidate_flag = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Count of employees identified as succession candidates. Leadership pipeline metric — low count signals key-person dependency risk."
    - name: "performance_improvement_plan_count"
      expr: SUM(CAST(CASE WHEN performance_improvement_plan_flag = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Count of employees on performance improvement plans. Workforce risk metric — high PIP count indicates systemic performance issues or management effectiveness problems."
    - name: "avg_compensation_adjustment_pct"
      expr: AVG(CAST(compensation_adjustment_percentage AS DOUBLE))
      comment: "Average recommended compensation adjustment percentage. Compensation planning metric — drives salary budget requirements for the next fiscal year."
    - name: "compensation_adjustment_recommended_count"
      expr: SUM(CAST(CASE WHEN compensation_adjustment_recommended = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Count of reviews recommending a compensation adjustment. Compensation budget planning metric — drives total salary increase cost projections."
    - name: "review_completion_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN review_status = 'finalised' THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reviews finalised. HR process effectiveness KPI — low completion rate delays compensation cycles and succession decisions."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`workforce_leave_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Leave utilisation, approval, and operational impact metrics. Enables HR and operations to monitor leave consumption, approval cycle times, gang complement impacts, and MLC shore leave compliance across the workforce."
  source: "`vibe_shipping_ports_v1`.`workforce`.`leave_request`"
  dimensions:
    - name: "leave_type"
      expr: leave_type
      comment: "Type of leave (annual, sick, parental, shore leave, etc.) for leave liability and utilisation analysis."
    - name: "leave_category"
      expr: leave_category
      comment: "Leave category for grouping related leave types in reporting."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status (pending, approved, rejected, cancelled) for leave pipeline monitoring."
    - name: "mlc_shore_leave_flag"
      expr: mlc_shore_leave_flag
      comment: "MLC shore leave flag. Maritime Labour Convention Title 2.4 compliance dimension — shore leave is a seafarer right."
    - name: "operational_impact_flag"
      expr: operational_impact_flag
      comment: "Whether the leave request has an operational impact (gang complement below minimum). Operational risk dimension."
    - name: "gang_complement_affected"
      expr: gang_complement_affected
      comment: "Whether the leave reduces gang complement below required levels. Throughput risk indicator."
    - name: "medical_certificate_required"
      expr: medical_certificate_required
      comment: "Whether a medical certificate is required for the leave type. Compliance and absence management dimension."
    - name: "leave_year"
      expr: leave_year
      comment: "Leave year for annual leave liability and entitlement tracking."
  measures:
    - name: "total_leave_requests"
      expr: COUNT(1)
      comment: "Total leave requests submitted. Baseline leave demand metric."
    - name: "total_requested_days"
      expr: SUM(CAST(requested_days AS DOUBLE))
      comment: "Total leave days requested. Leave demand volume metric for capacity planning."
    - name: "total_approved_days"
      expr: SUM(CAST(approved_days AS DOUBLE))
      comment: "Total leave days approved. Actual leave liability metric — drives workforce availability planning."
    - name: "leave_approval_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN approval_status = 'approved' THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of leave requests approved. Leave management effectiveness metric — very low approval rate may indicate MLC shore leave compliance risk."
    - name: "operational_impact_requests"
      expr: SUM(CAST(CASE WHEN operational_impact_flag = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Count of leave requests with operational impact. Throughput risk metric — high count indicates insufficient workforce buffer for leave coverage."
    - name: "avg_leave_balance_at_request"
      expr: AVG(CAST(leave_balance_at_request AS DOUBLE))
      comment: "Average leave balance at time of request. Leave liability management metric — high average balance indicates accrued leave liability on the balance sheet."
    - name: "mlc_shore_leave_requests"
      expr: SUM(CAST(CASE WHEN mlc_shore_leave_flag = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Count of MLC shore leave requests. Maritime Labour Convention compliance metric — tracking shore leave requests and approvals demonstrates MLC Title 2.4 compliance."
    - name: "medical_cert_missing_count"
      expr: SUM(CAST(CASE WHEN medical_certificate_required = TRUE AND medical_certificate_received = FALSE THEN 1 ELSE 0 END AS INT))
      comment: "Count of leave records where a medical certificate was required but not received. Absence management compliance metric — missing certificates expose the organisation to fraudulent sick leave claims."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`workforce_disciplinary_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Disciplinary case volume, severity, resolution, and compliance metrics. Enables HR and legal to monitor workforce conduct risk, case resolution timeliness, ISPS security-related incidents, and MLC compliance across the port workforce."
  source: "`vibe_shipping_ports_v1`.`workforce`.`disciplinary_case`"
  dimensions:
    - name: "case_type"
      expr: case_type
      comment: "Type of disciplinary case (misconduct, gross misconduct, performance, etc.) for risk categorisation."
    - name: "case_status"
      expr: case_status
      comment: "Current status of the case (open, under investigation, hearing scheduled, closed) for pipeline monitoring."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the disciplinary matter for risk-weighted reporting."
    - name: "allegation_category"
      expr: allegation_category
      comment: "Category of the allegation (theft, harassment, safety breach, etc.) for root-cause analysis."
    - name: "outcome_decision"
      expr: outcome_decision
      comment: "Outcome of the disciplinary process (warning, dismissal, no action, etc.) for outcome distribution analysis."
    - name: "isps_security_related_flag"
      expr: isps_security_related_flag
      comment: "Whether the case is ISPS security-related. Port security compliance dimension — ISPS-related cases require specific reporting to port security authority."
    - name: "safety_incident_related_flag"
      expr: safety_incident_related_flag
      comment: "Whether the case relates to a safety incident. HSE compliance dimension for cross-referencing with safety investigation outcomes."
    - name: "mlc_compliance_flag"
      expr: mlc_compliance_flag
      comment: "MLC compliance flag for the disciplinary case. Maritime Labour Convention grievance and disciplinary procedure compliance dimension."
    - name: "appeal_filed_flag"
      expr: appeal_filed_flag
      comment: "Whether an appeal was filed. Legal risk indicator — high appeal rate signals procedural fairness issues."
  measures:
    - name: "total_cases"
      expr: COUNT(1)
      comment: "Total disciplinary cases. Baseline workforce conduct risk volume metric."
    - name: "open_cases"
      expr: SUM(CAST(CASE WHEN case_status = 'open' THEN 1 ELSE 0 END AS INT))
      comment: "Count of currently open disciplinary cases. Active risk exposure metric — high open case count signals HR capacity or process bottlenecks."
    - name: "isps_related_cases"
      expr: SUM(CAST(CASE WHEN isps_security_related_flag = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Count of ISPS security-related disciplinary cases. Port security compliance metric — ISPS cases require mandatory reporting and may trigger security clearance review."
    - name: "safety_related_cases"
      expr: SUM(CAST(CASE WHEN safety_incident_related_flag = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Count of safety-incident-related disciplinary cases. HSE accountability metric — tracks whether safety violations result in disciplinary action."
    - name: "appeal_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN appeal_filed_flag = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cases where an appeal was filed. Procedural fairness KPI — high appeal rate indicates inconsistent disciplinary process application, creating legal liability."
    - name: "tribunal_escalation_count"
      expr: SUM(CAST(CASE WHEN escalated_to_tribunal_flag = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Count of cases escalated to an external tribunal. Legal risk metric — tribunal escalations represent significant cost, reputational risk, and management time."
    - name: "suspension_cases"
      expr: SUM(CAST(CASE WHEN suspension_paid_flag IS NOT NULL THEN 1 ELSE 0 END AS INT))
      comment: "Count of cases involving employee suspension. Operational capacity impact metric — suspended employees reduce available workforce complement."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`workforce_payslip`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Individual payslip-level compensation composition and MLC compliance metrics. Enables HR and finance to analyse pay component distribution, overtime dependency, and MLC wage compliance at the employee-payslip level."
  source: "`vibe_shipping_ports_v1`.`workforce`.`payslip`"
  dimensions:
    - name: "pay_frequency"
      expr: pay_frequency
      comment: "Pay frequency (weekly, fortnightly, monthly) for payslip volume and cost segmentation."
    - name: "employment_type"
      expr: employment_type
      comment: "Employment type (permanent, casual, contract) for compensation structure analysis by workforce category."
    - name: "pay_grade"
      expr: pay_grade
      comment: "Pay grade for compensation benchmarking and grade-band cost analysis."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method (bank transfer, cheque, etc.) for payroll disbursement analysis."
    - name: "payslip_status"
      expr: payslip_status
      comment: "Status of the payslip (generated, issued, disputed) for payroll quality monitoring."
    - name: "is_mlc_compliant"
      expr: is_mlc_compliant
      comment: "MLC compliance flag at the payslip level. Maritime Labour Convention wage compliance dimension."
    - name: "pay_period_end_date"
      expr: pay_period_end_date
      comment: "Pay period end date for time-series compensation trend analysis."
  measures:
    - name: "total_payslips"
      expr: COUNT(1)
      comment: "Total payslips issued. Baseline payroll volume metric."
    - name: "total_gross_pay"
      expr: SUM(CAST(gross_pay AS DOUBLE))
      comment: "Total gross pay across all payslips. Aggregate labour cost metric at the individual payslip level."
    - name: "total_net_pay"
      expr: SUM(CAST(net_pay AS DOUBLE))
      comment: "Total net pay disbursed. Cash outflow metric for treasury planning."
    - name: "total_overtime_pay"
      expr: SUM(CAST(overtime_pay AS DOUBLE))
      comment: "Total overtime pay component. Variable labour cost driver — high overtime pay indicates structural under-staffing."
    - name: "total_danger_allowance"
      expr: SUM(CAST(danger_allowance AS DOUBLE))
      comment: "Total danger/hazard allowance paid. IMDG and safety-critical operations cost metric — tracks premium pay for dangerous goods and hazardous work."
    - name: "avg_gross_pay_per_payslip"
      expr: AVG(CAST(gross_pay AS DOUBLE))
      comment: "Average gross pay per payslip. Compensation benchmarking metric — significant deviation from norm flags payroll errors or grade anomalies."
    - name: "avg_overtime_hours"
      expr: AVG(CAST(overtime_hours AS DOUBLE))
      comment: "Average overtime hours per payslip. Workforce fatigue and cost efficiency metric — high average overtime signals roster design issues."
    - name: "mlc_non_compliant_payslips"
      expr: SUM(CAST(CASE WHEN is_mlc_compliant = FALSE THEN 1 ELSE 0 END AS INT))
      comment: "Count of payslips flagged as MLC non-compliant. Maritime Labour Convention wage compliance risk metric — each non-compliant payslip is a potential seafarer complaint and PSC deficiency."
    - name: "overtime_pay_pct_of_gross"
      expr: ROUND(100.0 * SUM(CAST(overtime_pay AS DOUBLE)) / NULLIF(SUM(CAST(gross_pay AS DOUBLE)), 0), 2)
      comment: "Overtime pay as a percentage of total gross pay at payslip level. Structural overtime dependency KPI — sustained high ratio indicates chronic under-resourcing."
    - name: "total_ytd_gross_pay"
      expr: SUM(CAST(ytd_gross_pay AS DOUBLE))
      comment: "Total year-to-date gross pay. Annual compensation accrual metric for budget tracking and bonus eligibility calculations."
$$;