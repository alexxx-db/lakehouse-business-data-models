-- Metric views for domain: hr | Business: Construction | Version: 2 | Generated on: 2026-06-28 00:14:33

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`hr_application`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Recruitment funnel and candidate conversion metrics. Enables talent acquisition leadership to monitor application volumes, offer acceptance rates, and interview-to-hire conversion to optimise the hiring pipeline."
  source: "`vibe_construction_v1`.`hr`.`application`"
  dimensions:
    - name: "application_status"
      expr: application_status
      comment: "Current stage of the application (Screening, Interview, Offer, Hired, Rejected) for funnel stage analysis."
    - name: "source"
      expr: source
      comment: "Recruitment source channel (Job Board, Referral, Agency, LinkedIn) for sourcing effectiveness analysis."
    - name: "rejection_reason"
      expr: rejection_reason
      comment: "Reason for application rejection for candidate quality and process improvement analysis."
    - name: "application_month"
      expr: DATE_TRUNC('month', application_date)
      comment: "Month of application for recruitment volume trend analysis."
    - name: "offer_accepted"
      expr: offer_accepted
      comment: "Whether the offer was accepted, for offer acceptance rate and compensation competitiveness analysis."
    - name: "assessment_result"
      expr: assessment_result
      comment: "Outcome of candidate assessment for screening effectiveness analysis."
  measures:
    - name: "total_applications"
      expr: COUNT(application_id)
      comment: "Total applications received. Baseline for recruitment funnel volume and sourcing reach."
    - name: "offer_acceptance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN offer_accepted = TRUE THEN application_id END) / NULLIF(COUNT(CASE WHEN application_status = 'Offer' OR offer_accepted IS NOT NULL THEN application_id END), 0), 2)
      comment: "Percentage of offers accepted by candidates. Low acceptance rates indicate compensation or employer brand issues."
    - name: "avg_interview_score"
      expr: AVG(CAST(interview_score AS DOUBLE))
      comment: "Average interview score across all applications. Indicates candidate quality and screening effectiveness."
    - name: "avg_offer_salary_gross"
      expr: AVG(CAST(offer_salary_gross AS DOUBLE))
      comment: "Average gross salary offered to candidates. Used for compensation benchmarking and budget planning."
    - name: "total_offers_made"
      expr: COUNT(CASE WHEN offer_salary_gross > 0 THEN application_id END)
      comment: "Total number of offers extended to candidates. Measures hiring pipeline conversion to offer stage."
    - name: "hired_count"
      expr: COUNT(CASE WHEN offer_accepted = TRUE THEN application_id END)
      comment: "Total candidates hired (offer accepted). Primary output metric of the recruitment process."
    - name: "avg_salary_adjustment"
      expr: AVG(CAST(salary_adjustment AS DOUBLE))
      comment: "Average salary adjustment from initial offer. Indicates negotiation patterns and compensation flexibility in hiring."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`hr_recruitment_funnel`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Recruitment funnel metrics to monitor hiring efficiency"
  source: "`construction_ecm`.`hr`.`application`"
  dimensions:
    - name: "application_status"
      expr: application_status
      comment: "Current status of the application"
  measures:
    - name: "total_applications"
      expr: COUNT(1)
      comment: "Total number of job applications received"
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`hr_benefit_cost_share`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Benefit enrollment cost sharing analysis"
  source: "`construction_ecm`.`hr`.`benefit_enrollment`"
  dimensions:
    - name: "plan_type"
      expr: plan_type
      comment: "Type of benefit plan"
  measures:
    - name: "total_employee_contribution"
      expr: SUM(CAST(elected_contribution_amount AS DOUBLE))
      comment: "Total employee elected contributions"
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`hr_benefit_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Benefits programme participation and cost metrics for total rewards management. Enables HR and finance leadership to monitor enrollment rates, employer contribution costs, and benefits programme utilisation."
  source: "`vibe_construction_v1`.`hr`.`benefit_enrollment`"
  dimensions:
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Current enrollment status (Active, Terminated, Waived) for benefits coverage monitoring."
    - name: "plan_type"
      expr: plan_type
      comment: "Type of benefit plan (Health, Dental, Life, Pension) for benefits mix and cost analysis."
    - name: "coverage_tier"
      expr: coverage_tier
      comment: "Coverage tier (Employee Only, Employee + Spouse, Family) for cost tier distribution analysis."
    - name: "plan_year"
      expr: plan_year
      comment: "Benefits plan year for annual enrolment and cost trend analysis."
    - name: "waiver_flag"
      expr: waiver_flag
      comment: "Whether the employee waived benefits, for opt-out rate and benefits take-up analysis."
    - name: "open_enrollment_flag"
      expr: open_enrollment_flag
      comment: "Whether the enrollment occurred during open enrollment period for enrolment timing analysis."
  measures:
    - name: "total_enrollments"
      expr: COUNT(benefit_enrollment_id)
      comment: "Total benefit enrollments. Baseline for benefits programme participation and coverage analysis."
    - name: "active_enrollments"
      expr: COUNT(CASE WHEN enrollment_status = 'Active' THEN benefit_enrollment_id END)
      comment: "Number of currently active benefit enrollments. Measures current benefits coverage across the workforce."
    - name: "total_employer_contribution"
      expr: SUM(CAST(employer_contribution_amount AS DOUBLE))
      comment: "Total employer contribution to employee benefits. Major component of total compensation cost beyond base salary."
    - name: "total_employee_contribution"
      expr: SUM(CAST(elected_contribution_amount AS DOUBLE))
      comment: "Total employee-elected contribution amounts. Used for benefits cost-sharing analysis and plan design optimisation."
    - name: "waiver_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN waiver_flag = TRUE THEN benefit_enrollment_id END) / NULLIF(COUNT(benefit_enrollment_id), 0), 2)
      comment: "Percentage of eligible employees who waived benefits. High waiver rates may indicate plan design or affordability issues."
    - name: "avg_employer_contribution"
      expr: AVG(CAST(employer_contribution_amount AS DOUBLE))
      comment: "Average employer contribution per enrollment. Used for per-head benefits cost benchmarking and budget planning."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`hr_compensation_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compensation review cycle metrics for pay equity, budget management, and reward strategy. Enables HR and finance leadership to monitor salary increase rates, budget utilisation, and promotion-linked compensation changes."
  source: "`vibe_construction_v1`.`hr`.`compensation_review`"
  dimensions:
    - name: "review_cycle"
      expr: review_cycle
      comment: "Compensation review cycle (Annual, Mid-Year, Off-Cycle) for temporal analysis of pay decisions."
    - name: "review_status"
      expr: review_status
      comment: "Status of the compensation review (Draft, Submitted, Approved, Rejected) for process governance."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the compensation change for governance and audit trail."
    - name: "increase_type"
      expr: increase_type
      comment: "Type of salary increase (Merit, Promotion, Market Adjustment, Equity) for reward programme analysis."
    - name: "department_code"
      expr: department_code
      comment: "Department for compensation equity and budget allocation analysis."
    - name: "grade_level"
      expr: grade_level
      comment: "Job grade level for pay band compliance and internal equity analysis."
    - name: "review_year"
      expr: review_year
      comment: "Year of the compensation review for annual pay cycle trend analysis."
  measures:
    - name: "total_reviews"
      expr: COUNT(compensation_review_id)
      comment: "Total compensation reviews conducted. Baseline for review programme coverage and HR workload."
    - name: "avg_increase_percentage"
      expr: AVG(CAST(increase_percentage AS DOUBLE))
      comment: "Average salary increase percentage awarded. Core pay competitiveness metric used in compensation strategy benchmarking."
    - name: "total_salary_increase_amount"
      expr: SUM(CAST(new_salary AS DOUBLE) - CAST(current_salary AS DOUBLE))
      comment: "Total incremental salary cost from compensation reviews. Used for compensation budget impact and run-rate cost analysis."
    - name: "total_budget_consumed"
      expr: SUM(CAST(budget_consumed_amount AS DOUBLE))
      comment: "Total compensation budget consumed across all reviews. Tracks budget utilisation against approved compensation pools."
    - name: "total_budget_remaining"
      expr: SUM(CAST(budget_remaining_amount AS DOUBLE))
      comment: "Total compensation budget remaining. Enables real-time budget burn monitoring during review cycles."
    - name: "promotion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_promoted = TRUE THEN compensation_review_id END) / NULLIF(COUNT(compensation_review_id), 0), 2)
      comment: "Percentage of compensation reviews linked to a promotion. Indicates internal career progression velocity and talent pipeline health."
    - name: "avg_market_rate"
      expr: AVG(CAST(market_rate AS DOUBLE))
      comment: "Average market rate for reviewed positions. Used for pay competitiveness benchmarking against external market data."
    - name: "avg_internal_equity_score"
      expr: AVG(CAST(internal_equity_score AS DOUBLE))
      comment: "Average internal equity score across reviews. Low scores indicate pay equity issues requiring corrective action."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`hr_disciplinary_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Disciplinary case management metrics for workforce conduct governance. Enables HR and legal leadership to monitor case volumes, severity, resolution rates, and appeal outcomes to manage conduct risk and legal exposure."
  source: "`vibe_construction_v1`.`hr`.`disciplinary_case`"
  dimensions:
    - name: "disciplinary_case_status"
      expr: disciplinary_case_status
      comment: "Current status of the disciplinary case (Open, Under Investigation, Closed) for case pipeline monitoring."
    - name: "case_type"
      expr: case_type
      comment: "Type of disciplinary case (Misconduct, Performance, Attendance, Safety Violation) for conduct risk categorisation."
    - name: "outcome"
      expr: outcome
      comment: "Final outcome of the case (Warning, Suspension, Termination, No Action) for disciplinary effectiveness analysis."
    - name: "case_priority"
      expr: case_priority
      comment: "Priority level of the case for resource allocation in HR case management."
    - name: "appeal_filed"
      expr: appeal_filed
      comment: "Whether an appeal was filed against the disciplinary decision, indicating contested outcomes."
    - name: "case_raised_year"
      expr: YEAR(raised_timestamp)
      comment: "Year the case was raised for annual conduct trend analysis."
  measures:
    - name: "total_cases"
      expr: COUNT(disciplinary_case_id)
      comment: "Total disciplinary cases raised. Baseline for workforce conduct risk monitoring."
    - name: "open_cases"
      expr: COUNT(CASE WHEN disciplinary_case_status = 'Open' THEN disciplinary_case_id END)
      comment: "Number of currently open disciplinary cases. High open case counts indicate HR capacity constraints or complex investigations."
    - name: "appeal_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN appeal_filed = TRUE THEN disciplinary_case_id END) / NULLIF(COUNT(disciplinary_case_id), 0), 2)
      comment: "Percentage of disciplinary cases where an appeal was filed. High appeal rates indicate inconsistent or contested disciplinary decisions."
    - name: "avg_case_resolution_days"
      expr: AVG(DATEDIFF(case_closed_date, raised_timestamp))
      comment: "Average days from case raised to case closed. Long resolution times increase legal risk and employee relations impact."
    - name: "termination_outcome_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN outcome = 'Termination' THEN disciplinary_case_id END) / NULLIF(COUNT(CASE WHEN disciplinary_case_status = 'Closed' THEN disciplinary_case_id END), 0), 2)
      comment: "Percentage of closed cases resulting in termination. Indicates severity of conduct issues and disciplinary process outcomes."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`hr_grievance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Employee grievance and workplace relations metrics for organisational health monitoring. Enables HR and executive leadership to track grievance volumes, resolution rates, escalation patterns, and compensation outcomes to manage employment relations risk."
  source: "`vibe_construction_v1`.`hr`.`grievance`"
  dimensions:
    - name: "grievance_status"
      expr: grievance_status
      comment: "Current status of the grievance (Open, Under Investigation, Resolved, Escalated) for case pipeline monitoring."
    - name: "grievance_category"
      expr: grievance_category
      comment: "Category of grievance (Harassment, Discrimination, Pay, Working Conditions) for systemic issue identification."
    - name: "resolution_outcome"
      expr: resolution_outcome
      comment: "Outcome of grievance resolution for effectiveness and fairness analysis."
    - name: "investigation_status"
      expr: investigation_status
      comment: "Status of the investigation process for case management monitoring."
    - name: "location_code"
      expr: location_code
      comment: "Location where the grievance was raised for site-level workplace relations analysis."
    - name: "grievance_year"
      expr: YEAR(lodged_timestamp)
      comment: "Year the grievance was lodged for annual trend analysis."
  measures:
    - name: "total_grievances"
      expr: COUNT(grievance_id)
      comment: "Total grievances lodged. Primary indicator of workforce relations health and organisational culture issues."
    - name: "open_grievances"
      expr: COUNT(CASE WHEN grievance_status = 'Open' THEN grievance_id END)
      comment: "Number of currently open grievances. High open counts indicate HR capacity constraints or complex cases with legal risk."
    - name: "avg_resolution_days"
      expr: AVG(DATEDIFF(resolution_date, lodged_timestamp))
      comment: "Average days from grievance lodgement to resolution. Long resolution times increase legal exposure and employee dissatisfaction."
    - name: "escalation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN escalated_grievance_id IS NOT NULL THEN grievance_id END) / NULLIF(COUNT(grievance_id), 0), 2)
      comment: "Percentage of grievances that were escalated. High escalation rates indicate first-line resolution failures and elevated legal risk."
    - name: "total_compensation_awarded"
      expr: SUM(CAST(compensation_amount AS DOUBLE))
      comment: "Total financial compensation awarded in grievance resolutions. Quantifies the direct financial cost of unresolved workplace relations issues."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`hr_leave_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Leave management metrics for workforce availability and productivity planning. Enables HR and operations leadership to monitor leave volumes, approval rates, and leave type distribution to manage site and project staffing levels."
  source: "`vibe_construction_v1`.`hr`.`leave_request`"
  dimensions:
    - name: "leave_type"
      expr: leave_type
      comment: "Type of leave requested (Annual, Sick, Parental, Unpaid) for leave pattern analysis."
    - name: "leave_status"
      expr: leave_status
      comment: "Current status of the leave request (Approved, Pending, Rejected, Cancelled) for approval pipeline monitoring."
    - name: "approval_decision"
      expr: approval_decision
      comment: "Final approval decision for leave request outcome analysis."
    - name: "is_paid_leave"
      expr: is_paid_leave
      comment: "Whether the leave is paid or unpaid, for payroll impact and cost analysis."
    - name: "leave_year"
      expr: leave_year
      comment: "Leave year for annual leave utilisation and accrual compliance reporting."
    - name: "start_month"
      expr: DATE_TRUNC('month', start_date)
      comment: "Month leave starts for seasonal absence pattern analysis relevant to project scheduling."
  measures:
    - name: "total_leave_requests"
      expr: COUNT(leave_request_id)
      comment: "Total number of leave requests submitted. Baseline for leave demand and HR workload analysis."
    - name: "total_leave_days_requested"
      expr: SUM(CAST(total_days AS DOUBLE))
      comment: "Total calendar days of leave requested. Directly impacts workforce availability for project scheduling."
    - name: "avg_leave_days_per_request"
      expr: AVG(CAST(total_days AS DOUBLE))
      comment: "Average duration of leave requests. Indicates typical absence length for workforce planning models."
    - name: "leave_approval_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN approval_decision = 'Approved' THEN leave_request_id END) / NULLIF(COUNT(leave_request_id), 0), 2)
      comment: "Percentage of leave requests approved. Low rates may indicate policy issues or manager discretion inconsistencies."
    - name: "pending_leave_requests"
      expr: COUNT(CASE WHEN leave_status = 'Pending' THEN leave_request_id END)
      comment: "Number of leave requests awaiting decision. High backlogs indicate HR processing bottlenecks affecting employee experience."
    - name: "paid_leave_days"
      expr: SUM(CASE WHEN is_paid_leave = TRUE THEN CAST(total_days AS DOUBLE) ELSE 0 END)
      comment: "Total paid leave days taken. Directly contributes to payroll cost and is used in leave liability calculations."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`hr_leave_utilization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Leave request volume and utilization"
  source: "`construction_ecm`.`hr`.`leave_request`"
  dimensions:
    - name: "leave_type"
      expr: leave_type
      comment: "Type of leave (e.g., Vacation, Sick)"
  measures:
    - name: "total_leave_requests"
      expr: COUNT(1)
      comment: "Number of leave requests submitted"
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`hr_onboarding_checklist`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Onboarding completion and compliance metrics for new hire integration effectiveness. Enables HR and operations leadership to monitor onboarding completion rates, safety training compliance, and time-to-productivity for new construction workforce members."
  source: "`vibe_construction_v1`.`hr`.`onboarding_checklist`"
  dimensions:
    - name: "overall_status"
      expr: overall_status
      comment: "Overall onboarding status (In Progress, Completed, Overdue) for pipeline monitoring."
    - name: "location_code"
      expr: location_code
      comment: "Location where onboarding is occurring for site-level onboarding coverage analysis."
    - name: "visa_status"
      expr: visa_status
      comment: "Visa status of the onboarding employee for compliance and right-to-work monitoring."
    - name: "requires_security_clearance"
      expr: requires_security_clearance
      comment: "Whether the role requires security clearance, for clearance backlog and risk monitoring."
    - name: "start_month"
      expr: DATE_TRUNC('month', start_date)
      comment: "Month onboarding started for new hire cohort analysis and onboarding capacity planning."
  measures:
    - name: "total_onboarding_checklists"
      expr: COUNT(onboarding_checklist_id)
      comment: "Total onboarding checklists initiated. Baseline for new hire volume and onboarding programme scale."
    - name: "onboarding_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN overall_status = 'Completed' THEN onboarding_checklist_id END) / NULLIF(COUNT(onboarding_checklist_id), 0), 2)
      comment: "Percentage of onboarding checklists fully completed. Low rates indicate onboarding process gaps affecting new hire productivity."
    - name: "avg_completion_percentage"
      expr: AVG(CAST(completion_percentage AS DOUBLE))
      comment: "Average onboarding completion percentage across all active checklists. Tracks overall onboarding programme progress."
    - name: "health_safety_training_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN health_safety_training_completed = TRUE THEN onboarding_checklist_id END) / NULLIF(COUNT(onboarding_checklist_id), 0), 2)
      comment: "Percentage of new hires who completed health and safety training during onboarding. Critical construction safety KPI; non-compliance is a regulatory and liability risk."
    - name: "background_check_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN background_check_completed = TRUE THEN onboarding_checklist_id END) / NULLIF(COUNT(onboarding_checklist_id), 0), 2)
      comment: "Percentage of new hires with completed background checks. Compliance KPI for workforce vetting and site security requirements."
    - name: "payroll_setup_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN payroll_setup_completed = TRUE THEN onboarding_checklist_id END) / NULLIF(COUNT(onboarding_checklist_id), 0), 2)
      comment: "Percentage of new hires with payroll setup completed. Incomplete payroll setup causes payment errors and employee dissatisfaction."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`hr_payroll_cost`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payroll cost analysis by payroll group and period"
  source: "`construction_ecm`.`hr`.`payroll_record`"
  dimensions:
    - name: "All Records"
      expr: "1"
  measures:
    - name: "total_gross_salary"
      expr: SUM(CAST(gross_salary AS DOUBLE))
      comment: "Total gross salary paid in the period"
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`hr_payroll_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payroll cost and compensation metrics for financial control and workforce cost management. Enables finance and HR leadership to monitor gross payroll, net pay, tax obligations, overtime costs, and off-cycle payment anomalies."
  source: "`vibe_construction_v1`.`hr`.`payroll_record`"
  dimensions:
    - name: "pay_period_start"
      expr: DATE_TRUNC('month', pay_period_start)
      comment: "Pay period start month for trend analysis of payroll costs over time."
    - name: "payroll_status"
      expr: payroll_status
      comment: "Status of the payroll record (Processed, Pending, Reversed) for payroll run quality monitoring."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the payroll record for multi-currency payroll analysis."
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment (Bank Transfer, Cheque, etc.) for payment operations analysis."
    - name: "bonus_type"
      expr: bonus_type
      comment: "Type of bonus paid (Performance, Retention, Sign-on) for incentive cost analysis."
    - name: "is_off_cycle"
      expr: is_off_cycle
      comment: "Flag indicating off-cycle payroll runs, which carry higher processing cost and compliance risk."
    - name: "tax_year"
      expr: tax_year
      comment: "Tax year for annual payroll cost and tax liability reporting."
  measures:
    - name: "total_gross_salary"
      expr: SUM(CAST(gross_salary AS DOUBLE))
      comment: "Total gross payroll cost across all records. Primary labour cost metric for budget vs actual analysis."
    - name: "total_net_pay"
      expr: SUM(CAST(net_pay AS DOUBLE))
      comment: "Total net pay disbursed to employees. Represents actual cash outflow for treasury and cash flow planning."
    - name: "total_deduction_tax"
      expr: SUM(CAST(deduction_tax AS DOUBLE))
      comment: "Total tax deducted from payroll. Used for tax liability reporting and regulatory compliance."
    - name: "total_overtime_cost"
      expr: SUM(CAST(overtime_hours AS DOUBLE) * CAST(overtime_rate AS DOUBLE))
      comment: "Total overtime cost (hours × rate). High overtime signals understaffing or schedule pressure on construction projects."
    - name: "total_bonus_amount"
      expr: SUM(CAST(bonus_amount AS DOUBLE))
      comment: "Total bonus payments made. Used to track incentive spend against budget and evaluate reward programme effectiveness."
    - name: "avg_net_pay"
      expr: AVG(CAST(net_pay AS DOUBLE))
      comment: "Average net pay per payroll record. Benchmark for compensation equity and cost-per-head analysis."
    - name: "off_cycle_payroll_count"
      expr: COUNT(CASE WHEN is_off_cycle = TRUE THEN payroll_record_id END)
      comment: "Number of off-cycle payroll records. High off-cycle counts indicate payroll process inefficiency and elevated processing costs."
    - name: "total_ytd_gross"
      expr: SUM(CAST(year_to_date_gross AS DOUBLE))
      comment: "Sum of year-to-date gross pay across all employees. Used for annual labour cost tracking and budget burn rate analysis."
    - name: "total_site_allowances"
      expr: SUM(CAST(allowance_site AS DOUBLE))
      comment: "Total site allowances paid. Construction-specific cost for field workforce deployment, tracked against project budgets."
    - name: "total_project_allowances"
      expr: SUM(CAST(allowance_project AS DOUBLE))
      comment: "Total project-specific allowances paid. Directly attributable to project cost and used in project cost reconciliation."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`hr_payroll_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payroll run-level metrics for payroll operations governance. Enables payroll and finance leadership to monitor run volumes, gross/net totals, and payroll cycle efficiency."
  source: "`vibe_construction_v1`.`hr`.`payroll_run`"
  dimensions:
    - name: "payroll_run_status"
      expr: payroll_run_status
      comment: "Status of the payroll run (Completed, In Progress, Failed) for operational monitoring."
    - name: "payroll_type"
      expr: payroll_type
      comment: "Type of payroll run (Regular, Supplemental, Bonus) for cost categorisation."
    - name: "pay_cycle"
      expr: pay_cycle
      comment: "Pay cycle frequency (Weekly, Fortnightly, Monthly) for payroll operations planning."
    - name: "pay_date_month"
      expr: DATE_TRUNC('month', pay_date)
      comment: "Month of pay date for trend analysis of payroll run volumes and costs."
    - name: "tax_year"
      expr: tax_year
      comment: "Tax year for annual payroll reporting and compliance."
    - name: "is_manual"
      expr: is_manual
      comment: "Flag for manually processed payroll runs, which carry higher error risk and audit scrutiny."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the payroll run for multi-currency operations."
  measures:
    - name: "total_payroll_runs"
      expr: COUNT(payroll_run_id)
      comment: "Total number of payroll runs executed. Baseline for payroll operations volume and frequency analysis."
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross payroll amount across all runs. Primary labour cost aggregation for financial reporting."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net payroll disbursed. Represents actual cash outflow for treasury management."
    - name: "total_deductions_amount"
      expr: SUM(CAST(deductions_amount AS DOUBLE))
      comment: "Total deductions across all payroll runs. Used for statutory compliance and benefits cost tracking."
    - name: "manual_run_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_manual = TRUE THEN payroll_run_id END) / NULLIF(COUNT(payroll_run_id), 0), 2)
      comment: "Percentage of payroll runs that are manual. High manual rates indicate automation gaps and elevated error/compliance risk."
    - name: "avg_gross_per_run"
      expr: AVG(CAST(gross_amount AS DOUBLE))
      comment: "Average gross payroll amount per run. Used to detect anomalous runs that deviate significantly from the norm."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`hr_performance_rating`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Performance review outcomes and competency scores"
  source: "`construction_ecm`.`hr`.`performance_review`"
  dimensions:
    - name: "overall_performance_rating"
      expr: overall_performance_rating
      comment: "Overall rating assigned in the review"
  measures:
    - name: "total_reviews"
      expr: COUNT(1)
      comment: "Total number of performance reviews completed"
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`hr_performance_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Performance management metrics for talent strategy and workforce quality assessment. Enables HR and executive leadership to monitor rating distributions, promotion eligibility, and compensation change linkage across the workforce."
  source: "`vibe_construction_v1`.`hr`.`performance_review`"
  dimensions:
    - name: "review_cycle"
      expr: review_cycle
      comment: "Performance review cycle (Annual, Mid-Year, Quarterly) for temporal performance trend analysis."
    - name: "review_type"
      expr: review_type
      comment: "Type of review (Annual, Probation, Project-End) for review programme coverage analysis."
    - name: "overall_performance_rating"
      expr: overall_performance_rating
      comment: "Final performance rating category for rating distribution and talent segmentation."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle status of the review (Draft, Submitted, Approved, Closed) for process completion monitoring."
    - name: "hr_approval_status"
      expr: hr_approval_status
      comment: "HR approval status for governance and compliance tracking of the review process."
    - name: "review_period_start_year"
      expr: YEAR(review_period_start)
      comment: "Year of the review period for year-over-year performance trend analysis."
    - name: "calibration_status"
      expr: calibration_status
      comment: "Calibration status of the review for rating fairness and consistency governance."
  measures:
    - name: "total_reviews_completed"
      expr: COUNT(CASE WHEN lifecycle_status = 'Closed' THEN performance_review_id END)
      comment: "Total completed performance reviews. Measures review programme execution completeness."
    - name: "avg_rating_score"
      expr: AVG(CAST(rating_score AS DOUBLE))
      comment: "Average performance rating score across the workforce. Key indicator of overall workforce performance level and talent quality."
    - name: "avg_goal_achievement_score"
      expr: AVG(CAST(goal_achievement_score AS DOUBLE))
      comment: "Average goal achievement score. Measures how effectively the workforce is delivering against set objectives."
    - name: "avg_technical_competency"
      expr: AVG(CAST(technical_competency AS DOUBLE))
      comment: "Average technical competency score. Critical for construction workforce where technical skills directly impact project quality and safety."
    - name: "avg_safety_competency"
      expr: AVG(CAST(safety_competency AS DOUBLE))
      comment: "Average safety competency score. Construction-critical KPI; low scores indicate elevated site safety risk."
    - name: "promotion_eligibility_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN promotion_eligibility = TRUE THEN performance_review_id END) / NULLIF(COUNT(performance_review_id), 0), 2)
      comment: "Percentage of reviewed employees eligible for promotion. Indicates internal talent pipeline depth and succession readiness."
    - name: "compensation_change_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN compensation_change_flag = TRUE THEN performance_review_id END) / NULLIF(COUNT(performance_review_id), 0), 2)
      comment: "Percentage of reviews resulting in a compensation change. Links performance outcomes to reward decisions for pay-for-performance analysis."
    - name: "bonus_eligible_count"
      expr: COUNT(CASE WHEN bonus_eligible = TRUE THEN performance_review_id END)
      comment: "Number of employees eligible for bonus based on performance review. Drives bonus budget planning and incentive programme sizing."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`hr_recruitment_requisition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Recruitment pipeline metrics for talent acquisition effectiveness and workforce gap management. Enables HR and operations leadership to monitor open roles, time-to-fill, and hiring budget utilisation."
  source: "`vibe_construction_v1`.`hr`.`recruitment_requisition`"
  dimensions:
    - name: "recruitment_requisition_status"
      expr: recruitment_requisition_status
      comment: "Current status of the requisition (Open, Filled, Cancelled, On Hold) for pipeline stage analysis."
    - name: "employment_type"
      expr: employment_type
      comment: "Employment type being recruited for (Full-Time, Contract, Casual) for workforce mix planning."
    - name: "priority_level"
      expr: priority_level
      comment: "Recruitment priority (Critical, High, Medium, Low) for resource allocation in talent acquisition."
    - name: "job_grade"
      expr: job_grade
      comment: "Job grade of the open position for compensation band and seniority analysis."
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost centre requesting the hire for budget accountability and headcount cost allocation."
    - name: "posting_month"
      expr: DATE_TRUNC('month', posting_date)
      comment: "Month the requisition was posted for recruitment volume trend analysis."
    - name: "remote_option"
      expr: remote_option
      comment: "Whether the role allows remote work, for workforce flexibility and talent pool analysis."
  measures:
    - name: "total_open_requisitions"
      expr: COUNT(CASE WHEN recruitment_requisition_status = 'Open' THEN recruitment_requisition_id END)
      comment: "Total open recruitment requisitions. Primary indicator of unfilled workforce demand and hiring backlog."
    - name: "total_requisitions"
      expr: COUNT(recruitment_requisition_id)
      comment: "Total requisitions across all statuses. Baseline for recruitment volume and hiring programme scale."
    - name: "total_approved_fte"
      expr: SUM(CAST(expected_fte AS DOUBLE))
      comment: "Total approved FTE across all requisitions. Measures planned workforce growth and hiring investment."
    - name: "avg_salary_midpoint"
      expr: AVG((CAST(salary_min AS DOUBLE) + CAST(salary_max AS DOUBLE)) / 2.0)
      comment: "Average salary midpoint of open requisitions. Used for compensation budget forecasting and market competitiveness assessment."
    - name: "avg_days_to_close"
      expr: AVG(DATEDIFF(closing_date, posting_date))
      comment: "Average days from posting to closing date. Proxy for time-to-fill; high values indicate recruitment process inefficiency or talent scarcity."
    - name: "critical_open_requisitions"
      expr: COUNT(CASE WHEN recruitment_requisition_status = 'Open' AND priority_level = 'Critical' THEN recruitment_requisition_id END)
      comment: "Number of open critical-priority requisitions. Unfilled critical roles directly risk project delivery and safety compliance."
    - name: "external_posting_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN external_job_posting = TRUE THEN recruitment_requisition_id END) / NULLIF(COUNT(recruitment_requisition_id), 0), 2)
      comment: "Percentage of requisitions posted externally. Indicates reliance on external talent market vs internal mobility."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`hr_separation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Employee attrition and separation metrics for workforce retention strategy. Enables HR and executive leadership to monitor turnover volumes, separation types, severance costs, and exit interview insights to reduce attrition risk."
  source: "`vibe_construction_v1`.`hr`.`separation`"
  dimensions:
    - name: "separation_type"
      expr: separation_type
      comment: "Type of separation (Resignation, Redundancy, Termination, Retirement) for attrition cause analysis."
    - name: "termination_reason"
      expr: termination_reason
      comment: "Specific reason for termination for root cause analysis of workforce attrition."
    - name: "separation_status"
      expr: separation_status
      comment: "Current status of the separation process for offboarding completion monitoring."
    - name: "rehire_eligibility_flag"
      expr: rehire_eligibility_flag
      comment: "Whether the employee is eligible for rehire, for talent pool and boomerang employee strategy."
    - name: "exit_interview_theme"
      expr: exit_interview_theme
      comment: "Thematic category from exit interview for systemic retention issue identification."
    - name: "separation_year"
      expr: YEAR(effective_separation_date)
      comment: "Year of separation for annual attrition trend analysis."
    - name: "separation_month"
      expr: DATE_TRUNC('month', effective_separation_date)
      comment: "Month of separation for seasonal attrition pattern analysis."
  measures:
    - name: "total_separations"
      expr: COUNT(separation_id)
      comment: "Total employee separations. Primary attrition volume metric used to calculate turnover rates."
    - name: "voluntary_separation_count"
      expr: COUNT(CASE WHEN separation_type = 'Resignation' THEN separation_id END)
      comment: "Number of voluntary resignations. Voluntary attrition is the most actionable retention metric for leadership."
    - name: "total_severance_paid"
      expr: SUM(CAST(severance_pay_amount AS DOUBLE))
      comment: "Total severance payments made. Significant cost of attrition used in retention ROI calculations."
    - name: "total_final_pay"
      expr: SUM(CAST(final_pay_amount AS DOUBLE))
      comment: "Total final pay disbursed to separated employees. Used for offboarding cost tracking and cash flow planning."
    - name: "exit_interview_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN exit_interview_completed = TRUE THEN separation_id END) / NULLIF(COUNT(separation_id), 0), 2)
      comment: "Percentage of separations with a completed exit interview. Low rates reduce insight into attrition drivers."
    - name: "rehire_eligible_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN rehire_eligibility_flag = TRUE THEN separation_id END) / NULLIF(COUNT(separation_id), 0), 2)
      comment: "Percentage of separated employees eligible for rehire. Indicates quality of departures and potential for talent re-engagement."
    - name: "avg_severance_amount"
      expr: AVG(CAST(severance_pay_amount AS DOUBLE))
      comment: "Average severance payment per separation. Used for severance budget forecasting and policy benchmarking."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`hr_training_completion`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Training enrollment and completion effectiveness"
  source: "`construction_ecm`.`hr`.`training_enrollment`"
  dimensions:
    - name: "training_type"
      expr: training_type
      comment: "Type of training (e.g., Safety, Technical)"
  measures:
    - name: "total_enrollments"
      expr: COUNT(1)
      comment: "Total number of training enrollments"
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`hr_training_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Training completion and compliance metrics for workforce capability development. Enables HR and operations leadership to monitor training completion rates, compliance training coverage, and certification issuance critical for construction site safety."
  source: "`vibe_construction_v1`.`hr`.`training_enrollment`"
  dimensions:
    - name: "training_enrollment_status"
      expr: training_enrollment_status
      comment: "Current status of the training enrollment (Enrolled, Completed, Failed, Cancelled) for completion pipeline monitoring."
    - name: "training_type"
      expr: training_type
      comment: "Type of training (Safety, Technical, Compliance, Leadership) for training investment analysis by category."
    - name: "delivery_method"
      expr: delivery_method
      comment: "Training delivery method (Classroom, Online, On-the-Job) for learning modality effectiveness analysis."
    - name: "pass_fail_outcome"
      expr: pass_fail_outcome
      comment: "Assessment outcome (Pass/Fail) for training effectiveness and quality analysis."
    - name: "compliance_required"
      expr: compliance_required
      comment: "Whether the training is mandatory for compliance, enabling compliance gap identification."
    - name: "scheduled_month"
      expr: DATE_TRUNC('month', scheduled_delivery_date)
      comment: "Month training is scheduled for capacity planning and training programme pacing."
    - name: "location_code"
      expr: location_code
      comment: "Location where training is delivered for site-level training coverage analysis."
  measures:
    - name: "total_enrollments"
      expr: COUNT(training_enrollment_id)
      comment: "Total training enrollments. Baseline for training programme scale and workforce development investment."
    - name: "training_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN training_enrollment_status = 'Completed' THEN training_enrollment_id END) / NULLIF(COUNT(training_enrollment_id), 0), 2)
      comment: "Percentage of enrollments completed. Core training effectiveness KPI; low rates indicate engagement or scheduling issues."
    - name: "compliance_training_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_required = TRUE AND training_enrollment_status = 'Completed' THEN training_enrollment_id END) / NULLIF(COUNT(CASE WHEN compliance_required = TRUE THEN training_enrollment_id END), 0), 2)
      comment: "Completion rate for mandatory compliance training. Critical regulatory KPI for construction; non-compliance risks project shutdowns and penalties."
    - name: "pass_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN pass_fail_outcome = 'Pass' THEN training_enrollment_id END) / NULLIF(COUNT(CASE WHEN pass_fail_outcome IS NOT NULL THEN training_enrollment_id END), 0), 2)
      comment: "Percentage of assessed training enrollments that resulted in a pass. Measures training quality and workforce capability acquisition."
    - name: "total_training_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost of training enrollments. Used for L&D budget management and cost-per-head training investment analysis."
    - name: "avg_assessment_score"
      expr: AVG(CAST(assessment_score AS DOUBLE))
      comment: "Average assessment score across all training enrollments. Indicates workforce learning effectiveness and training programme quality."
    - name: "certificates_issued"
      expr: COUNT(CASE WHEN certificate_issued = TRUE THEN training_enrollment_id END)
      comment: "Total certifications issued through training. Tracks workforce credential accumulation critical for site access and regulatory compliance."
    - name: "total_training_hours"
      expr: SUM(CAST(hours AS DOUBLE))
      comment: "Total training hours delivered. Measures workforce development investment in time and is used for CPD reporting."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`hr_workforce_headcount_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce planning accuracy and FTE variance metrics for strategic headcount management. Enables HR and operations leadership to monitor planned vs actual FTE, attrition forecasting accuracy, and workforce plan execution."
  source: "`vibe_construction_v1`.`hr`.`workforce_headcount_plan`"
  dimensions:
    - name: "workforce_headcount_plan_status"
      expr: workforce_headcount_plan_status
      comment: "Status of the headcount plan (Draft, Approved, Active, Closed) for plan governance monitoring."
    - name: "plan_type"
      expr: plan_type
      comment: "Type of headcount plan (Annual, Quarterly, Project-Based) for planning horizon analysis."
    - name: "job_family"
      expr: job_family
      comment: "Job family for workforce composition and skills gap analysis."
    - name: "job_grade"
      expr: job_grade
      comment: "Job grade for seniority mix and compensation cost planning."
    - name: "period"
      expr: period
      comment: "Planning period for temporal headcount trend analysis."
    - name: "effective_start_year"
      expr: YEAR(effective_start_date)
      comment: "Year the headcount plan takes effect for annual planning cycle analysis."
  measures:
    - name: "total_planned_fte"
      expr: SUM(CAST(planned_fte AS DOUBLE))
      comment: "Total planned FTE across all headcount plans. Primary workforce demand metric for capacity and cost planning."
    - name: "total_actual_fte"
      expr: SUM(CAST(actual_fte AS DOUBLE))
      comment: "Total actual FTE achieved. Compared against planned FTE to measure workforce plan execution accuracy."
    - name: "total_fte_variance"
      expr: SUM(CAST(variance_fte AS DOUBLE))
      comment: "Total FTE variance (planned minus actual). Negative variance indicates understaffing risk; positive indicates overstaffing cost."
    - name: "avg_attrition_rate"
      expr: AVG(CAST(attrition_rate_percent AS DOUBLE))
      comment: "Average planned attrition rate across headcount plans. Used to calibrate replacement hiring volumes and retention investment."
    - name: "fte_plan_accuracy_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_fte AS DOUBLE)) / NULLIF(SUM(CAST(planned_fte AS DOUBLE)), 0), 2)
      comment: "Ratio of actual to planned FTE as a percentage. Measures workforce planning accuracy; deviations drive corrective hiring or cost reduction actions."
$$;
