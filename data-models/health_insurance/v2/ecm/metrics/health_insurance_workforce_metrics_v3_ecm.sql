-- Metric views for domain: workforce | Business: Health_Insurance | Version: 3 | Generated on: 2026-07-10 20:04:11

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`workforce_employee`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core workforce headcount and demographic metrics. Tracks active employee population, compensation distribution, and workforce composition for executive workforce planning and HR steering decisions."
  source: "`vibe_health_insurance_v1`.`workforce`.`employee`"
  dimensions:
    - name: "employment_status"
      expr: employment_status
      comment: "Current employment status (Active, Terminated, Leave, etc.) for workforce segmentation."
    - name: "employment_type"
      expr: employment_type
      comment: "Full-time, part-time, contractor classification for workforce composition analysis."
    - name: "department"
      expr: department
      comment: "Organizational department for departmental headcount and cost analysis."
    - name: "gender"
      expr: gender
      comment: "Gender dimension for DEI workforce composition reporting."
    - name: "ethnicity"
      expr: ethnicity
      comment: "Ethnicity dimension for DEI workforce diversity reporting."
    - name: "organization_level"
      expr: organization_level
      comment: "Organizational hierarchy level for span-of-control and leadership pipeline analysis."
    - name: "pay_frequency"
      expr: pay_frequency
      comment: "Pay frequency (weekly, bi-weekly, monthly) for payroll planning segmentation."
    - name: "hire_year"
      expr: DATE_TRUNC('YEAR', hire_date)
      comment: "Year of hire for cohort tenure analysis and attrition trending."
    - name: "termination_year"
      expr: DATE_TRUNC('YEAR', termination_date)
      comment: "Year of termination for attrition cohort analysis."
    - name: "health_plan_eligible"
      expr: health_plan_eligible
      comment: "Whether the employee is eligible for health plan benefits, for benefits cost planning."
    - name: "bonus_eligible"
      expr: bonus_eligible
      comment: "Whether the employee is eligible for bonus, for incentive compensation planning."
    - name: "state"
      expr: state
      comment: "State of employment for geographic workforce distribution and compliance analysis."
  measures:
    - name: "total_headcount"
      expr: COUNT(1)
      comment: "Total number of employee records. Primary headcount KPI for workforce sizing and capacity planning."
    - name: "active_headcount"
      expr: COUNT(CASE WHEN employment_status = 'Active' THEN 1 END)
      comment: "Count of currently active employees. Core operational headcount metric used in staffing dashboards and executive workforce reviews."
    - name: "total_salary_amount"
      expr: SUM(CAST(salary_amount AS DOUBLE))
      comment: "Total annualized salary spend across all employees. Key input for compensation budget management and cost-of-workforce analysis."
    - name: "avg_salary_amount"
      expr: AVG(CAST(salary_amount AS DOUBLE))
      comment: "Average salary per employee. Used for compensation benchmarking, equity analysis, and pay-band calibration."
    - name: "health_plan_eligible_headcount"
      expr: COUNT(CASE WHEN health_plan_eligible = TRUE THEN 1 END)
      comment: "Number of employees eligible for health plan benefits. Drives benefits cost forecasting and ACA compliance tracking."
    - name: "health_plan_eligibility_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN health_plan_eligible = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of workforce eligible for health plan benefits. Informs benefits program design and cost exposure."
    - name: "terminated_headcount"
      expr: COUNT(CASE WHEN employment_status = 'Terminated' THEN 1 END)
      comment: "Count of terminated employees in the period. Used to compute attrition rates and workforce stability metrics."
    - name: "attrition_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN employment_status = 'Terminated' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of workforce that has been terminated. Critical retention KPI tracked by CHRO and executive leadership."
    - name: "hipaa_training_compliant_headcount"
      expr: COUNT(CASE WHEN hipaa_training_completion_date IS NOT NULL THEN 1 END)
      comment: "Number of employees with completed HIPAA training. Regulatory compliance KPI for health insurance workforce."
    - name: "hipaa_training_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN hipaa_training_completion_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of employees with completed HIPAA training. Directly tied to regulatory compliance risk and audit readiness."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`workforce_payroll_disbursement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payroll cost and labor hour metrics derived from individual disbursement records. Supports payroll budget management, overtime cost control, and labor efficiency analysis."
  source: "`vibe_health_insurance_v1`.`workforce`.`payroll_disbursement`"
  dimensions:
    - name: "pay_period_start_date"
      expr: DATE_TRUNC('MONTH', pay_period_start_date)
      comment: "Pay period month for payroll trend analysis."
    - name: "pay_date_month"
      expr: DATE_TRUNC('MONTH', pay_date)
      comment: "Month of actual pay disbursement for cash flow and payroll timing analysis."
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost center for departmental payroll cost allocation and budget variance analysis."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method (direct deposit, check, etc.) for payroll operations management."
    - name: "payroll_status"
      expr: payroll_status
      comment: "Status of the payroll disbursement for reconciliation and exception management."
    - name: "payroll_disbursement_type"
      expr: payroll_disbursement_type
      comment: "Type of disbursement (regular, bonus, commission, etc.) for compensation mix analysis."
    - name: "lob_code"
      expr: lob_code
      comment: "Line of business code for cross-LOB labor cost allocation."
    - name: "tax_exempt_flag"
      expr: tax_exempt_flag
      comment: "Whether the disbursement is tax-exempt, for tax liability reporting."
  measures:
    - name: "total_gross_pay_amount"
      expr: SUM(CAST(gross_pay_amount AS DOUBLE))
      comment: "Total gross payroll disbursed. Primary payroll cost KPI for budget management and financial reporting."
    - name: "total_net_pay_amount"
      expr: SUM(CAST(net_pay_amount AS DOUBLE))
      comment: "Total net pay after deductions. Cash flow KPI for treasury and payroll operations."
    - name: "avg_gross_pay_amount"
      expr: AVG(CAST(gross_pay_amount AS DOUBLE))
      comment: "Average gross pay per disbursement. Used for compensation benchmarking and anomaly detection."
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours worked. Key labor efficiency KPI — high overtime signals understaffing or workload imbalance."
    - name: "total_regular_hours"
      expr: SUM(CAST(regular_hours AS DOUBLE))
      comment: "Total regular hours worked. Baseline labor input metric for productivity and capacity analysis."
    - name: "overtime_rate"
      expr: ROUND(100.0 * SUM(CAST(overtime_hours AS DOUBLE)) / NULLIF(SUM(CAST(regular_hours AS DOUBLE)), 0), 2)
      comment: "Overtime hours as a percentage of regular hours. Operational efficiency KPI — elevated rates trigger staffing reviews."
    - name: "total_federal_tax_withheld"
      expr: SUM(CAST(federal_tax_withheld AS DOUBLE))
      comment: "Total federal tax withheld across all disbursements. Tax compliance and liability reporting metric."
    - name: "total_state_tax_withheld"
      expr: SUM(CAST(state_tax_withheld AS DOUBLE))
      comment: "Total state tax withheld. Multi-state tax compliance metric for health insurance organizations operating across states."
    - name: "total_other_deductions"
      expr: SUM(CAST(other_deductions_total AS DOUBLE))
      comment: "Total non-tax deductions (benefits, garnishments, etc.). Benefits cost and deduction management KPI."
    - name: "disbursement_count"
      expr: COUNT(1)
      comment: "Total number of payroll disbursements processed. Volume metric for payroll operations capacity and audit completeness."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`workforce_payroll_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payroll run-level financial summary metrics. Tracks total payroll cost, tax burden, and deduction volumes per payroll cycle for financial close and budget variance analysis."
  source: "`vibe_health_insurance_v1`.`workforce`.`payroll_run`"
  dimensions:
    - name: "pay_date_month"
      expr: DATE_TRUNC('MONTH', pay_date)
      comment: "Month of payroll run for trend and budget variance analysis."
    - name: "payroll_cycle_code"
      expr: payroll_cycle_code
      comment: "Payroll cycle (weekly, bi-weekly, semi-monthly, monthly) for cycle-level cost analysis."
    - name: "payroll_type"
      expr: payroll_type
      comment: "Type of payroll run (regular, off-cycle, bonus) for payroll mix analysis."
    - name: "payroll_run_status"
      expr: payroll_run_status
      comment: "Status of the payroll run (Pending, Processed, Posted) for operational monitoring."
    - name: "is_manual_run"
      expr: is_manual_run
      comment: "Whether the run was manually triggered. Manual runs indicate exceptions and carry higher error risk."
    - name: "period_start_month"
      expr: DATE_TRUNC('MONTH', period_start_date)
      comment: "Pay period start month for period-over-period payroll cost comparison."
  measures:
    - name: "total_gross_payroll_amount"
      expr: SUM(CAST(total_gross_amount AS DOUBLE))
      comment: "Total gross payroll cost across all runs. Primary financial KPI for payroll budget management and P&L reporting."
    - name: "total_net_payroll_amount"
      expr: SUM(CAST(total_net_amount AS DOUBLE))
      comment: "Total net payroll disbursed. Cash outflow KPI for treasury management."
    - name: "total_employer_tax_amount"
      expr: SUM(CAST(total_employer_tax AS DOUBLE))
      comment: "Total employer-side payroll tax liability. Tax planning and compliance KPI."
    - name: "total_employee_deductions_amount"
      expr: SUM(CAST(total_employee_deductions AS DOUBLE))
      comment: "Total employee deductions (benefits, retirement, etc.). Benefits program cost and participation metric."
    - name: "avg_gross_payroll_per_run"
      expr: AVG(CAST(total_gross_amount AS DOUBLE))
      comment: "Average gross payroll per run. Baseline for detecting anomalous payroll runs that warrant investigation."
    - name: "manual_run_count"
      expr: COUNT(CASE WHEN is_manual_run = TRUE THEN 1 END)
      comment: "Number of manually triggered payroll runs. Elevated counts signal process exceptions and control risk."
    - name: "manual_run_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_manual_run = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of payroll runs that are manual. Payroll process quality KPI — high rates indicate control weaknesses."
    - name: "payroll_run_count"
      expr: COUNT(1)
      comment: "Total number of payroll runs executed. Volume metric for payroll operations capacity planning."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`workforce_compensation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Employee compensation structure and cost metrics. Supports compensation equity analysis, budget planning, and incentive program effectiveness evaluation."
  source: "`vibe_health_insurance_v1`.`workforce`.`compensation`"
  dimensions:
    - name: "compensation_type"
      expr: compensation_type
      comment: "Type of compensation (salary, hourly, commission) for compensation mix analysis."
    - name: "pay_grade"
      expr: pay_grade
      comment: "Pay grade for compensation band analysis and equity review."
    - name: "bonus_type"
      expr: bonus_type
      comment: "Type of bonus (performance, retention, signing) for incentive program analysis."
    - name: "bonus_frequency"
      expr: bonus_frequency
      comment: "Frequency of bonus payments for incentive cost forecasting."
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost center for departmental compensation cost allocation."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of compensation for multi-currency workforce cost analysis."
    - name: "is_exempt"
      expr: is_exempt
      comment: "FLSA exempt status for overtime liability and compliance analysis."
    - name: "compensation_status"
      expr: compensation_status
      comment: "Status of the compensation record (Active, Pending, Expired) for data quality monitoring."
    - name: "effective_year"
      expr: DATE_TRUNC('YEAR', effective_date)
      comment: "Year compensation became effective for year-over-year compensation trend analysis."
    - name: "equity_type"
      expr: equity_type
      comment: "Type of equity compensation (RSU, options, etc.) for equity program cost analysis."
  measures:
    - name: "total_base_compensation_amount"
      expr: SUM(CAST(base_amount AS DOUBLE))
      comment: "Total base compensation cost. Primary compensation budget KPI for financial planning."
    - name: "avg_base_compensation_amount"
      expr: AVG(CAST(base_amount AS DOUBLE))
      comment: "Average base compensation per employee record. Used for pay equity analysis and market benchmarking."
    - name: "total_bonus_amount"
      expr: SUM(CAST(bonus_amount AS DOUBLE))
      comment: "Total bonus compensation cost. Incentive program cost KPI for budget management."
    - name: "avg_bonus_amount"
      expr: AVG(CAST(bonus_amount AS DOUBLE))
      comment: "Average bonus per employee. Used to evaluate incentive program generosity and competitiveness."
    - name: "total_equity_amount"
      expr: SUM(CAST(equity_amount AS DOUBLE))
      comment: "Total equity compensation value. Long-term incentive cost KPI for retention program evaluation."
    - name: "avg_incentive_target_pct"
      expr: AVG(CAST(incentive_target_pct AS DOUBLE))
      comment: "Average incentive target as a percentage of base. Measures incentive program leverage across the workforce."
    - name: "salary_range_spread_avg"
      expr: AVG(CAST(salary_range_max AS DOUBLE) - CAST(salary_range_min AS DOUBLE))
      comment: "Average salary band width (max minus min). Wider spreads indicate more flexibility; used in compensation structure design."
    - name: "compensation_record_count"
      expr: COUNT(1)
      comment: "Total compensation records. Volume metric for compensation program coverage and data completeness."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`workforce_performance_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Employee performance rating and merit increase metrics. Supports talent management decisions, succession planning, and compensation-performance alignment analysis."
  source: "`vibe_health_insurance_v1`.`workforce`.`performance_review`"
  dimensions:
    - name: "review_type"
      expr: review_type
      comment: "Type of performance review (annual, mid-year, probationary) for review program analysis."
    - name: "review_status"
      expr: review_status
      comment: "Status of the review (Draft, Submitted, Finalized) for completion tracking."
    - name: "overall_rating"
      expr: overall_rating
      comment: "Overall performance rating for talent distribution and calibration analysis."
    - name: "calibration_status"
      expr: calibration_status
      comment: "Whether the review has been calibrated. Calibration completion is a talent management process KPI."
    - name: "department"
      expr: department
      comment: "Department for departmental performance distribution analysis."
    - name: "job_role"
      expr: job_role
      comment: "Job role for role-level performance benchmarking."
    - name: "review_period_start_year"
      expr: DATE_TRUNC('YEAR', review_period_start)
      comment: "Review period year for year-over-year performance trend analysis."
    - name: "performance_improvement_plan_flag"
      expr: performance_improvement_plan_flag
      comment: "Whether the employee is on a PIP. PIP rate is a talent risk and management effectiveness KPI."
    - name: "is_finalized"
      expr: is_finalized
      comment: "Whether the review is finalized. Completion rate drives HR process compliance."
  measures:
    - name: "total_reviews"
      expr: COUNT(1)
      comment: "Total performance reviews conducted. Volume metric for review program coverage and HR process compliance."
    - name: "finalized_review_count"
      expr: COUNT(CASE WHEN is_finalized = TRUE THEN 1 END)
      comment: "Number of finalized reviews. Completion KPI for performance management cycle governance."
    - name: "review_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_finalized = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reviews finalized. HR process compliance KPI — low rates indicate management accountability gaps."
    - name: "avg_goal_rating"
      expr: AVG(CAST(average_goal_rating AS DOUBLE))
      comment: "Average goal achievement rating across all reviews. Workforce performance quality KPI for executive talent reviews."
    - name: "avg_merit_increase_pct"
      expr: AVG(CAST(merit_increase_percentage AS DOUBLE))
      comment: "Average merit increase percentage. Compensation-performance linkage KPI for pay-for-performance program evaluation."
    - name: "total_merit_increase_amount"
      expr: SUM(CAST(merit_increase_recommendation_amount AS DOUBLE))
      comment: "Total recommended merit increase spend. Budget impact KPI for compensation planning cycles."
    - name: "pip_employee_count"
      expr: COUNT(CASE WHEN performance_improvement_plan_flag = TRUE THEN 1 END)
      comment: "Number of employees on performance improvement plans. Talent risk KPI — elevated counts signal workforce quality issues."
    - name: "pip_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN performance_improvement_plan_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reviewed employees on PIPs. Management effectiveness and talent risk KPI."
    - name: "avg_salary_adjustment_amount"
      expr: AVG(CAST(salary_adjustment_amount AS DOUBLE))
      comment: "Average salary adjustment per review. Measures the financial impact of performance-driven compensation changes."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`workforce_leave_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Employee leave utilization and approval metrics. Tracks leave patterns, FMLA exposure, and payroll impact for workforce availability and compliance management."
  source: "`vibe_health_insurance_v1`.`workforce`.`leave_request`"
  dimensions:
    - name: "leave_type"
      expr: leave_type
      comment: "Type of leave (FMLA, PTO, sick, parental, etc.) for leave program utilization analysis."
    - name: "leave_status"
      expr: leave_status
      comment: "Status of the leave request (Pending, Approved, Denied) for leave management operations."
    - name: "fmla_eligible"
      expr: fmla_eligible
      comment: "Whether the leave qualifies for FMLA protection. FMLA exposure is a legal compliance KPI."
    - name: "intermittent"
      expr: intermittent
      comment: "Whether the leave is intermittent. Intermittent leave patterns affect scheduling and productivity."
    - name: "payroll_impact"
      expr: payroll_impact
      comment: "Whether the leave has a payroll impact. Drives payroll cost forecasting during leave periods."
    - name: "ada_accommodation_required"
      expr: ada_accommodation_required
      comment: "Whether ADA accommodation is required. ADA compliance exposure KPI."
    - name: "request_year"
      expr: DATE_TRUNC('YEAR', request_timestamp)
      comment: "Year of leave request for year-over-year leave trend analysis."
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost center for departmental leave utilization and coverage cost analysis."
  measures:
    - name: "total_leave_requests"
      expr: COUNT(1)
      comment: "Total leave requests submitted. Volume metric for leave program utilization and HR workload."
    - name: "approved_leave_count"
      expr: COUNT(CASE WHEN leave_status = 'Approved' THEN 1 END)
      comment: "Number of approved leave requests. Workforce availability impact metric."
    - name: "leave_approval_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN leave_status = 'Approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of leave requests approved. HR process consistency and manager behavior KPI."
    - name: "total_requested_days"
      expr: SUM(CAST(requested_days AS DOUBLE))
      comment: "Total leave days requested. Workforce availability and coverage planning KPI."
    - name: "total_approved_days"
      expr: SUM(CAST(approved_days AS DOUBLE))
      comment: "Total leave days approved. Actual workforce availability impact metric for capacity planning."
    - name: "avg_approved_days_per_request"
      expr: AVG(CAST(approved_days AS DOUBLE))
      comment: "Average approved leave duration per request. Benchmarks leave generosity and identifies outlier approvals."
    - name: "fmla_leave_count"
      expr: COUNT(CASE WHEN fmla_eligible = TRUE THEN 1 END)
      comment: "Number of FMLA-eligible leave requests. Legal compliance exposure KPI for HR and legal teams."
    - name: "fmla_leave_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN fmla_eligible = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of leave requests that are FMLA-eligible. Regulatory compliance risk indicator."
    - name: "total_payroll_impact_amount"
      expr: SUM(CAST(payroll_amount AS DOUBLE))
      comment: "Total payroll cost associated with leave. Financial impact KPI for leave program cost management."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`workforce_training_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Employee training completion and compliance metrics. Tracks training program effectiveness, certification currency, and regulatory training compliance for health insurance workforce."
  source: "`vibe_health_insurance_v1`.`workforce`.`training_record`"
  dimensions:
    - name: "training_record_status"
      expr: training_record_status
      comment: "Status of the training record (Completed, In Progress, Failed) for training program monitoring."
    - name: "training_type"
      expr: training_type
      comment: "Type of training (compliance, technical, leadership) for training mix analysis."
    - name: "delivery_method"
      expr: delivery_method
      comment: "Training delivery method (online, classroom, on-the-job) for program effectiveness analysis."
    - name: "pass_fail_status"
      expr: pass_fail_status
      comment: "Pass/fail outcome for training quality and effectiveness measurement."
    - name: "is_expired"
      expr: is_expired
      comment: "Whether the training certification has expired. Expired certifications represent compliance risk."
    - name: "recertification_required"
      expr: recertification_required
      comment: "Whether recertification is required. Drives proactive compliance management."
    - name: "completion_year"
      expr: DATE_TRUNC('YEAR', completion_timestamp)
      comment: "Year of training completion for annual compliance reporting."
  measures:
    - name: "total_training_completions"
      expr: COUNT(1)
      comment: "Total training records. Volume metric for training program reach and compliance coverage."
    - name: "passed_training_count"
      expr: COUNT(CASE WHEN pass_fail_status = 'Pass' THEN 1 END)
      comment: "Number of training completions with a passing result. Training effectiveness KPI."
    - name: "training_pass_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN pass_fail_status = 'Pass' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of training completions that resulted in a pass. Program quality and employee readiness KPI."
    - name: "expired_certification_count"
      expr: COUNT(CASE WHEN is_expired = TRUE THEN 1 END)
      comment: "Number of expired training certifications. Compliance risk KPI — expired certs in regulated roles create audit exposure."
    - name: "expired_certification_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_expired = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of training certifications that are expired. Regulatory compliance risk indicator for health insurance workforce."
    - name: "total_training_hours"
      expr: SUM(CAST(training_hours AS DOUBLE))
      comment: "Total training hours invested. Learning and development investment KPI for workforce capability building."
    - name: "avg_training_hours_per_completion"
      expr: AVG(CAST(training_hours AS DOUBLE))
      comment: "Average training hours per completion. Program depth and investment-per-employee metric."
    - name: "avg_assessment_score"
      expr: AVG(CAST(assessment_score AS DOUBLE))
      comment: "Average assessment score across all training completions. Training quality and workforce competency KPI."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`workforce_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Professional certification currency and compliance metrics for the workforce. Tracks certification coverage, expiration risk, and renewal compliance critical for health insurance regulatory requirements."
  source: "`vibe_health_insurance_v1`.`workforce`.`workforce_certification`"
  dimensions:
    - name: "workforce_certification_type"
      expr: workforce_certification_type
      comment: "Type of certification (clinical, compliance, technical) for certification portfolio analysis."
    - name: "workforce_certification_category"
      expr: workforce_certification_category
      comment: "Category of certification for grouping and compliance reporting."
    - name: "workforce_certification_status"
      expr: workforce_certification_status
      comment: "Current status of the certification (Active, Expired, Suspended) for compliance monitoring."
    - name: "issuing_organization"
      expr: issuing_organization
      comment: "Organization that issued the certification for credential source analysis."
    - name: "is_mandatory"
      expr: is_mandatory
      comment: "Whether the certification is mandatory for the role. Mandatory cert gaps are compliance violations."
    - name: "renewal_required"
      expr: renewal_required
      comment: "Whether renewal is required. Drives proactive renewal management."
    - name: "renewal_status"
      expr: renewal_status
      comment: "Status of certification renewal for renewal pipeline management."
    - name: "verification_status"
      expr: verification_status
      comment: "Whether the certification has been verified. Unverified certifications represent credentialing risk."
    - name: "effective_year"
      expr: DATE_TRUNC('YEAR', effective_date)
      comment: "Year certification became effective for certification cohort analysis."
  measures:
    - name: "total_certifications"
      expr: COUNT(1)
      comment: "Total certification records. Coverage metric for workforce credentialing program."
    - name: "active_certification_count"
      expr: COUNT(CASE WHEN workforce_certification_status = 'Active' THEN 1 END)
      comment: "Number of currently active certifications. Core compliance KPI for credentialed workforce management."
    - name: "active_certification_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN workforce_certification_status = 'Active' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of certifications that are currently active. Workforce compliance health KPI."
    - name: "mandatory_certification_gap_count"
      expr: COUNT(CASE WHEN is_mandatory = TRUE AND workforce_certification_status != 'Active' THEN 1 END)
      comment: "Number of mandatory certifications that are not active. Critical compliance risk KPI — gaps in mandatory certs create regulatory exposure."
    - name: "verified_certification_count"
      expr: COUNT(CASE WHEN verification_status = 'Verified' THEN 1 END)
      comment: "Number of verified certifications. Credentialing integrity KPI for audit and accreditation purposes."
    - name: "verification_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN verification_status = 'Verified' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of certifications that have been verified. Credentialing quality KPI for NCQA and regulatory audits."
    - name: "total_certification_cost_amount"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost of workforce certifications. Learning and development investment KPI for budget management."
    - name: "avg_certification_cost_amount"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average cost per certification. Benchmarks certification program cost efficiency."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`workforce_background_check`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pre-employment and periodic background screening metrics. Tracks screening compliance, OIG exclusion risk, and adjudication outcomes critical for health insurance regulatory requirements."
  source: "`vibe_health_insurance_v1`.`workforce`.`background_check`"
  dimensions:
    - name: "screening_type"
      expr: screening_type
      comment: "Type of background screening (criminal, OIG, credit, etc.) for screening program analysis."
    - name: "background_check_status"
      expr: background_check_status
      comment: "Status of the background check (Ordered, In Progress, Complete) for operational monitoring."
    - name: "adjudication_decision"
      expr: adjudication_decision
      comment: "Adjudication outcome (Clear, Adverse, Pending) for hiring decision analysis."
    - name: "result"
      expr: result
      comment: "Background check result for compliance and risk reporting."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the background check for regulatory audit readiness."
    - name: "is_oig_exclusion_flag"
      expr: is_oig_exclusion_flag
      comment: "Whether the individual is flagged on the OIG exclusion list. OIG exclusions are a critical compliance violation in health insurance."
    - name: "is_federal_program_access"
      expr: is_federal_program_access
      comment: "Whether the role requires federal program access. Drives enhanced screening requirements."
    - name: "order_year"
      expr: DATE_TRUNC('YEAR', order_timestamp)
      comment: "Year background check was ordered for annual screening volume and compliance trend analysis."
  measures:
    - name: "total_background_checks"
      expr: COUNT(1)
      comment: "Total background checks ordered. Volume metric for screening program coverage."
    - name: "oig_exclusion_flag_count"
      expr: COUNT(CASE WHEN is_oig_exclusion_flag = TRUE THEN 1 END)
      comment: "Number of individuals flagged on the OIG exclusion list. Critical compliance KPI — employing excluded individuals in federal programs is a regulatory violation."
    - name: "oig_exclusion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_oig_exclusion_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of screened individuals with OIG exclusion flags. Regulatory risk KPI for CMS compliance."
    - name: "adverse_action_count"
      expr: COUNT(CASE WHEN adjudication_decision = 'Adverse' THEN 1 END)
      comment: "Number of adverse adjudication decisions. Hiring risk and workforce quality KPI."
    - name: "adverse_action_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN adjudication_decision = 'Adverse' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of background checks resulting in adverse action. Workforce risk and hiring quality KPI."
    - name: "total_screening_cost_amount"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost of background screening program. HR operations cost KPI for vendor management and budget control."
    - name: "avg_screening_cost_amount"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average cost per background check. Vendor cost efficiency KPI for screening program management."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`workforce_headcount_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce planning and headcount budget metrics. Tracks FTE budget utilization, vacancy rates, and recruitment pipeline efficiency for strategic workforce planning."
  source: "`vibe_health_insurance_v1`.`workforce`.`headcount_plan`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual headcount planning and budget cycle analysis."
    - name: "plan_status"
      expr: plan_status
      comment: "Status of the headcount plan (Draft, Approved, Active) for planning governance."
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost center for departmental headcount budget allocation analysis."
    - name: "department_code"
      expr: department_code
      comment: "Department code for organizational headcount distribution analysis."
    - name: "is_contractor"
      expr: is_contractor
      comment: "Whether the planned position is for a contractor. Contractor vs. employee mix is a workforce strategy KPI."
    - name: "diversity_hiring_indicator"
      expr: diversity_hiring_indicator
      comment: "Whether the position has a diversity hiring target. DEI hiring program tracking."
    - name: "planning_period"
      expr: planning_period
      comment: "Planning period (Q1, Q2, annual, etc.) for period-level headcount analysis."
    - name: "effective_from_year"
      expr: DATE_TRUNC('YEAR', effective_from)
      comment: "Year the headcount plan takes effect for annual planning cycle analysis."
  measures:
    - name: "total_approved_fte"
      expr: SUM(CAST(approved_fte AS DOUBLE))
      comment: "Total approved FTE budget. Primary workforce capacity KPI for executive workforce planning."
    - name: "total_filled_fte"
      expr: SUM(CAST(filled_fte AS DOUBLE))
      comment: "Total filled FTE positions. Actual workforce capacity metric for capacity utilization analysis."
    - name: "total_vacant_fte"
      expr: SUM(CAST(vacant_fte AS DOUBLE))
      comment: "Total vacant FTE positions. Workforce gap KPI — high vacancy rates signal recruiting challenges or budget underutilization."
    - name: "fte_fill_rate"
      expr: ROUND(100.0 * SUM(CAST(filled_fte AS DOUBLE)) / NULLIF(SUM(CAST(approved_fte AS DOUBLE)), 0), 2)
      comment: "Percentage of approved FTE positions that are filled. Core workforce capacity utilization KPI for executive workforce reviews."
    - name: "total_budget_variance_amount"
      expr: SUM(CAST(budget_variance_amount AS DOUBLE))
      comment: "Total headcount budget variance (actual vs. planned). Financial discipline KPI for workforce cost management."
    - name: "avg_budget_variance_pct"
      expr: AVG(CAST(budget_variance_percent AS DOUBLE))
      comment: "Average budget variance percentage. Workforce planning accuracy KPI for finance and HR leadership."
    - name: "diversity_hiring_plan_count"
      expr: COUNT(CASE WHEN diversity_hiring_indicator = TRUE THEN 1 END)
      comment: "Number of headcount plans with diversity hiring targets. DEI program commitment KPI."
    - name: "diversity_hiring_plan_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN diversity_hiring_indicator = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of headcount plans with diversity hiring targets. DEI strategic commitment KPI for executive reporting."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`workforce_recruitment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Talent acquisition efficiency and cost metrics. Tracks time-to-fill, offer acceptance rates, and recruitment cost for strategic talent pipeline management."
  source: "`vibe_health_insurance_v1`.`workforce`.`workforce_recruitment`"
  dimensions:
    - name: "requisition_status"
      expr: requisition_status
      comment: "Status of the recruitment requisition (Open, Filled, Cancelled) for pipeline management."
    - name: "source_of_hire"
      expr: source_of_hire
      comment: "Source channel of hire (referral, job board, agency, etc.) for recruiting channel effectiveness analysis."
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost center for departmental recruiting cost allocation."
    - name: "department_code"
      expr: department_code
      comment: "Department for departmental hiring velocity and demand analysis."
    - name: "is_remote"
      expr: is_remote
      comment: "Whether the position is remote. Remote vs. on-site mix affects talent pool size and cost."
    - name: "job_level"
      expr: job_level
      comment: "Job level (entry, mid, senior, executive) for hiring mix and pipeline analysis."
    - name: "compensation_type"
      expr: compensation_type
      comment: "Compensation type for the recruited position for workforce cost planning."
    - name: "job_posting_year"
      expr: DATE_TRUNC('YEAR', job_posting_date)
      comment: "Year of job posting for annual recruiting volume trend analysis."
  measures:
    - name: "total_requisitions"
      expr: COUNT(1)
      comment: "Total recruitment requisitions. Volume metric for talent acquisition demand and HR capacity planning."
    - name: "filled_requisition_count"
      expr: COUNT(CASE WHEN requisition_status = 'Filled' THEN 1 END)
      comment: "Number of filled requisitions. Recruiting effectiveness KPI for talent acquisition performance."
    - name: "requisition_fill_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN requisition_status = 'Filled' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of requisitions successfully filled. Core talent acquisition effectiveness KPI."
    - name: "total_salary_offer_amount"
      expr: SUM(CAST(salary_offer_amount AS DOUBLE))
      comment: "Total salary offered across all recruitment. Compensation budget commitment KPI for workforce cost planning."
    - name: "avg_salary_offer_amount"
      expr: AVG(CAST(salary_offer_amount AS DOUBLE))
      comment: "Average salary offer. Market competitiveness KPI for talent acquisition strategy."
    - name: "total_salary_adjustment_amount"
      expr: SUM(CAST(salary_adjustment_amount AS DOUBLE))
      comment: "Total salary adjustments made during recruitment. Negotiation cost KPI for compensation management."
    - name: "offer_accepted_count"
      expr: COUNT(CASE WHEN offer_accepted_date IS NOT NULL THEN 1 END)
      comment: "Number of offers accepted. Offer acceptance is a key talent acquisition quality KPI."
    - name: "offer_acceptance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN offer_accepted_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(CASE WHEN offer_extended_date IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of extended offers that were accepted. Recruiting competitiveness and employer brand KPI."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`workforce_time_and_attendance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Labor time utilization and attendance compliance metrics. Tracks overtime exposure, absence patterns, and FLSA compliance for operational workforce management."
  source: "`vibe_health_insurance_v1`.`workforce`.`time_and_attendance`"
  dimensions:
    - name: "time_and_attendance_status"
      expr: time_and_attendance_status
      comment: "Status of the time record (Submitted, Approved, Rejected) for timesheet compliance monitoring."
    - name: "manager_approval_status"
      expr: manager_approval_status
      comment: "Manager approval status for timesheet governance and compliance."
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost center for departmental labor hour allocation and cost analysis."
    - name: "department_code"
      expr: department_code
      comment: "Department for departmental attendance and overtime analysis."
    - name: "flsa_compliance"
      expr: flsa_compliance
      comment: "Whether the time record is FLSA compliant. FLSA violations carry significant legal and financial risk."
    - name: "overtime_eligibility"
      expr: overtime_eligibility
      comment: "Whether the employee is eligible for overtime. Drives overtime cost exposure analysis."
    - name: "period_start_month"
      expr: DATE_TRUNC('MONTH', period_start_date)
      comment: "Pay period month for monthly labor utilization trend analysis."
    - name: "time_entry_method"
      expr: time_entry_method
      comment: "Method of time entry (mobile, web, badge) for time capture compliance analysis."
  measures:
    - name: "total_regular_hours"
      expr: SUM(CAST(regular_hours AS DOUBLE))
      comment: "Total regular hours worked. Baseline labor input metric for productivity and capacity analysis."
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours. Key labor cost and workforce adequacy KPI — high overtime signals understaffing."
    - name: "overtime_to_regular_ratio"
      expr: ROUND(100.0 * SUM(CAST(overtime_hours AS DOUBLE)) / NULLIF(SUM(CAST(regular_hours AS DOUBLE)), 0), 2)
      comment: "Overtime hours as a percentage of regular hours. Operational efficiency KPI — elevated ratios trigger staffing reviews."
    - name: "total_pto_used_hours"
      expr: SUM(CAST(pto_used_hours AS DOUBLE))
      comment: "Total PTO hours used. Leave utilization KPI for workforce availability and benefits cost management."
    - name: "total_sick_hours_used"
      expr: SUM(CAST(sick_hours_used AS DOUBLE))
      comment: "Total sick hours used. Absenteeism KPI — elevated sick hours signal workforce health or engagement issues."
    - name: "flsa_non_compliant_count"
      expr: COUNT(CASE WHEN flsa_compliance = FALSE THEN 1 END)
      comment: "Number of time records with FLSA compliance violations. Legal risk KPI — FLSA violations expose the organization to wage and hour litigation."
    - name: "flsa_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN flsa_compliance = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of time records that are FLSA compliant. Regulatory compliance KPI for labor law adherence."
    - name: "total_gross_pay_amount"
      expr: SUM(CAST(gross_pay_amount AS DOUBLE))
      comment: "Total gross pay associated with time records. Labor cost KPI for budget management and cost allocation."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`workforce_disciplinary_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Employee disciplinary action frequency and severity metrics. Tracks policy violations, repeat offenses, and appeal outcomes for workforce conduct management and legal risk mitigation."
  source: "`vibe_health_insurance_v1`.`workforce`.`disciplinary_action`"
  dimensions:
    - name: "action_type"
      expr: action_type
      comment: "Type of disciplinary action (verbal warning, written warning, suspension, termination) for severity analysis."
    - name: "disciplinary_action_category"
      expr: disciplinary_action_category
      comment: "Category of the disciplinary action for policy violation pattern analysis."
    - name: "disciplinary_action_status"
      expr: disciplinary_action_status
      comment: "Status of the disciplinary action for case management monitoring."
    - name: "appeal_status"
      expr: appeal_status
      comment: "Status of any appeal filed against the action. Appeal rates indicate fairness and process quality."
    - name: "is_repeat_offense"
      expr: is_repeat_offense
      comment: "Whether this is a repeat offense. Repeat offenders represent elevated workforce risk."
    - name: "policy_violated"
      expr: policy_violated
      comment: "Policy that was violated for compliance gap and training needs analysis."
    - name: "action_year"
      expr: DATE_TRUNC('YEAR', action_date)
      comment: "Year of disciplinary action for trend analysis and year-over-year comparison."
  measures:
    - name: "total_disciplinary_actions"
      expr: COUNT(1)
      comment: "Total disciplinary actions taken. Workforce conduct KPI for HR and legal risk management."
    - name: "repeat_offense_count"
      expr: COUNT(CASE WHEN is_repeat_offense = TRUE THEN 1 END)
      comment: "Number of repeat offense disciplinary actions. Elevated counts signal ineffective corrective action programs."
    - name: "repeat_offense_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_repeat_offense = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of disciplinary actions involving repeat offenders. Program effectiveness KPI for HR leadership."
    - name: "appeal_filed_count"
      expr: COUNT(CASE WHEN appeal_status IS NOT NULL AND appeal_status != 'None' THEN 1 END)
      comment: "Number of disciplinary actions with appeals filed. Appeal rate indicates perceived fairness of disciplinary process."
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total financial penalties assessed through disciplinary actions. Financial impact KPI for workforce conduct management."
    - name: "avg_penalty_amount"
      expr: AVG(CAST(penalty_amount AS DOUBLE))
      comment: "Average penalty per disciplinary action. Benchmarks disciplinary severity and consistency."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`workforce_rbac_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Role-based access control assignment metrics. Tracks access provisioning, temporary access exposure, and access risk levels critical for PHI security and HIPAA compliance in health insurance."
  source: "`vibe_health_insurance_v1`.`workforce`.`rbac_assignment`"
  dimensions:
    - name: "rbac_assignment_status"
      expr: rbac_assignment_status
      comment: "Status of the RBAC assignment (Active, Expired, Revoked) for access governance monitoring."
    - name: "access_level"
      expr: access_level
      comment: "Level of access granted for access privilege distribution analysis."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level of the access assignment. High-risk access requires enhanced monitoring for HIPAA compliance."
    - name: "is_temporary"
      expr: is_temporary
      comment: "Whether the access is temporary. Temporary access that is not revoked on time is a security risk."
    - name: "system_name"
      expr: system_name
      comment: "System to which access is granted for system-level access risk analysis."
    - name: "compliance_framework"
      expr: compliance_framework
      comment: "Compliance framework governing the access (HIPAA, SOX, etc.) for regulatory access control reporting."
    - name: "access_scope"
      expr: access_scope
      comment: "Scope of access granted for least-privilege compliance analysis."
    - name: "effective_year"
      expr: DATE_TRUNC('YEAR', effective_date)
      comment: "Year access was granted for access provisioning trend analysis."
  measures:
    - name: "total_access_assignments"
      expr: COUNT(1)
      comment: "Total RBAC assignments. Access provisioning volume metric for security governance."
    - name: "active_access_count"
      expr: COUNT(CASE WHEN rbac_assignment_status = 'Active' THEN 1 END)
      comment: "Number of currently active access assignments. Active access footprint KPI for security risk management."
    - name: "high_risk_access_count"
      expr: COUNT(CASE WHEN risk_level = 'High' THEN 1 END)
      comment: "Number of high-risk access assignments. Critical security KPI — high-risk PHI access requires enhanced monitoring for HIPAA compliance."
    - name: "high_risk_access_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN risk_level = 'High' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of access assignments classified as high risk. Security posture KPI for CISO and compliance reporting."
    - name: "temporary_access_count"
      expr: COUNT(CASE WHEN is_temporary = TRUE THEN 1 END)
      comment: "Number of temporary access assignments. Temporary access volume is a security hygiene KPI."
    - name: "temporary_access_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_temporary = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of access assignments that are temporary. Elevated rates may indicate over-reliance on exception-based access."
    - name: "revoked_access_count"
      expr: COUNT(CASE WHEN rbac_assignment_status = 'Revoked' THEN 1 END)
      comment: "Number of revoked access assignments. Access revocation completeness is a security compliance KPI."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`workforce_compliance_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce compliance event tracking metrics. Monitors compliance obligation completion rates, overdue events, and remediation outcomes for regulatory workforce compliance management."
  source: "`vibe_health_insurance_v1`.`workforce`.`compliance_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of compliance event (training, certification, audit, etc.) for compliance program analysis."
    - name: "compliance_event_status"
      expr: compliance_event_status
      comment: "Status of the compliance event (Pending, Complete, Overdue) for compliance monitoring."
    - name: "compliance_outcome"
      expr: compliance_outcome
      comment: "Outcome of the compliance event (Pass, Fail, Remediated) for compliance effectiveness analysis."
    - name: "due_year"
      expr: DATE_TRUNC('YEAR', due_date)
      comment: "Year compliance event is due for annual compliance calendar management."
    - name: "completion_year"
      expr: DATE_TRUNC('YEAR', completion_date)
      comment: "Year compliance event was completed for completion trend analysis."
  measures:
    - name: "total_compliance_events"
      expr: COUNT(1)
      comment: "Total compliance events tracked. Volume metric for compliance program scope and coverage."
    - name: "completed_event_count"
      expr: COUNT(CASE WHEN compliance_event_status = 'Complete' THEN 1 END)
      comment: "Number of completed compliance events. Compliance program execution KPI."
    - name: "compliance_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_event_status = 'Complete' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of compliance events completed. Core regulatory compliance KPI for health insurance workforce management."
    - name: "overdue_event_count"
      expr: COUNT(CASE WHEN compliance_event_status = 'Overdue' THEN 1 END)
      comment: "Number of overdue compliance events. Compliance risk KPI — overdue events create regulatory audit exposure."
    - name: "overdue_event_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_event_status = 'Overdue' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of compliance events that are overdue. Regulatory risk indicator for compliance leadership."
$$;