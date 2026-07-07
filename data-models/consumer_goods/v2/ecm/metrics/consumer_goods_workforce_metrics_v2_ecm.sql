-- Metric views for domain: workforce | Business: Consumer Goods | Version: 2 | Generated on: 2026-06-28 00:14:33

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`workforce_applicant_pipeline`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key applicant pipeline metrics to monitor recruitment efficiency and conversion."
  source: "`consumer_goods_ecm`.`workforce`.`applicant`"
  dimensions:
    - name: "application_status"
      expr: application_status
      comment: "Current status of the application"
    - name: "department_applied"
      expr: department_applied
      comment: "Department the applicant applied to"
    - name: "source_channel"
      expr: source_channel
      comment: "Recruitment source channel"
    - name: "country"
      expr: country
      comment: "Applicant country"
    - name: "state"
      expr: state
      comment: "Applicant state"
    - name: "application_month"
      expr: DATE_TRUNC('month', application_date)
      comment: "Month of application"
  measures:
    - name: "total_applicants"
      expr: COUNT(1)
      comment: "Total number of applicant records"
    - name: "applications_with_offer"
      expr: COUNT(offer_date)
      comment: "Number of applicants who received an offer"
    - name: "avg_time_to_hire_days"
      expr: AVG(DATEDIFF(hire_date, application_date))
      comment: "Average days between application and hire date for hired applicants"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`workforce_benefit_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Employee benefits enrollment and cost metrics. Drives decisions on benefits program design, cost management, COBRA exposure, and enrollment compliance."
  source: "`vibe_consumer_goods_v1`.`workforce`.`benefit_enrollment`"
  dimensions:
    - name: "benefit_type"
      expr: benefit_type
      comment: "Type of benefit (medical, dental, vision, 401k) for benefits portfolio analysis."
    - name: "benefit_category"
      expr: benefit_category
      comment: "Benefit category for cost grouping and program design decisions."
    - name: "benefit_enrollment_status"
      expr: benefit_enrollment_status
      comment: "Enrollment status (active, waived, terminated) for coverage tracking."
    - name: "coverage_level"
      expr: coverage_level
      comment: "Coverage level (employee-only, employee+spouse, family) for cost tier analysis."
    - name: "coverage_tier"
      expr: coverage_tier
      comment: "Coverage tier for premium cost segmentation."
    - name: "cobra_eligible_flag"
      expr: cobra_eligible_flag
      comment: "Whether the enrollment is COBRA-eligible. Tracks COBRA liability exposure."
    - name: "enrollment_event_type"
      expr: enrollment_event_type
      comment: "Open enrollment, qualifying life event, new hire for enrollment trigger analysis."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month enrollment became effective for benefits cost accrual analysis."
    - name: "tax_treatment"
      expr: tax_treatment
      comment: "Pre-tax or post-tax treatment for benefits tax optimization analysis."
  measures:
    - name: "total_enrollments"
      expr: COUNT(DISTINCT benefit_enrollment_id)
      comment: "Total benefit enrollments. Baseline for benefits program participation and coverage tracking."
    - name: "total_employee_contribution"
      expr: SUM(CAST(employee_contribution AS DOUBLE))
      comment: "Total employee benefit contributions. Measures employee cost-sharing and benefits affordability."
    - name: "total_employer_contribution"
      expr: SUM(CAST(employer_contribution AS DOUBLE))
      comment: "Total employer benefit contributions. Primary benefits cost KPI for HR budget and total compensation analysis."
    - name: "total_annual_election_amount"
      expr: SUM(CAST(annual_election_amount AS DOUBLE))
      comment: "Total annual benefit elections (e.g., FSA/HSA). Tracks voluntary benefit utilization and tax-advantaged savings."
    - name: "avg_employee_contribution"
      expr: AVG(CAST(employee_contribution AS DOUBLE))
      comment: "Average employee contribution per enrollment. Benchmarks benefits affordability and cost-sharing design."
    - name: "avg_employer_contribution"
      expr: AVG(CAST(employer_contribution AS DOUBLE))
      comment: "Average employer contribution per enrollment. Benchmarks benefits generosity against market and budget."
    - name: "cobra_eligible_count"
      expr: COUNT(DISTINCT CASE WHEN cobra_eligible_flag = TRUE THEN benefit_enrollment_id END)
      comment: "Count of COBRA-eligible enrollments. Tracks COBRA liability and compliance notification obligations."
    - name: "waived_enrollment_count"
      expr: COUNT(DISTINCT CASE WHEN benefit_enrollment_status = 'Waived' THEN benefit_enrollment_id END)
      comment: "Count of waived benefit enrollments. High waiver rate signals benefits program relevance or affordability issues."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`workforce_employee`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core workforce headcount and composition metrics. Drives executive decisions on staffing levels, workforce mix, retention risk, and organizational structure."
  source: "`vibe_consumer_goods_v1`.`workforce`.`employee`"
  dimensions:
    - name: "employment_status"
      expr: employment_status
      comment: "Active, terminated, on-leave status for workforce segmentation."
    - name: "employment_type"
      expr: employment_type
      comment: "Full-time, part-time, contractor classification for workforce mix analysis."
    - name: "department"
      expr: department
      comment: "Organizational department for headcount and cost attribution."
    - name: "job_title"
      expr: job_title
      comment: "Job title for role-level workforce analysis."
    - name: "country_code"
      expr: country_code
      comment: "Country of employment for geographic workforce distribution."
    - name: "pay_grade"
      expr: pay_grade
      comment: "Compensation grade band for pay equity and budget analysis."
    - name: "union_membership_flag"
      expr: union_membership_flag
      comment: "Whether the employee is a union member, for labor relations segmentation."
    - name: "flsa_classification"
      expr: flsa_classification
      comment: "FLSA exempt/non-exempt classification for compliance and overtime cost analysis."
    - name: "hire_date_month"
      expr: DATE_TRUNC('MONTH', hire_date)
      comment: "Month of hire for cohort and tenure analysis."
    - name: "termination_date_month"
      expr: DATE_TRUNC('MONTH', termination_date)
      comment: "Month of termination for attrition trend analysis."
    - name: "contract_type"
      expr: contract_type
      comment: "Permanent vs fixed-term contract type for workforce stability analysis."
  measures:
    - name: "total_headcount"
      expr: COUNT(DISTINCT employee_id)
      comment: "Total number of distinct employees. Primary workforce sizing KPI used in every executive headcount review."
    - name: "active_headcount"
      expr: COUNT(DISTINCT CASE WHEN employment_status = 'Active' THEN employee_id END)
      comment: "Count of currently active employees. Drives capacity planning and budget allocation decisions."
    - name: "terminated_headcount"
      expr: COUNT(DISTINCT CASE WHEN termination_date IS NOT NULL THEN employee_id END)
      comment: "Count of employees with a termination date. Used to compute attrition rate and assess retention risk."
    - name: "avg_standard_working_hours_per_week"
      expr: AVG(CAST(standard_working_hours_per_week AS DOUBLE))
      comment: "Average contracted weekly hours across the workforce. Signals part-time vs full-time workforce mix and capacity."
    - name: "union_member_headcount"
      expr: COUNT(DISTINCT CASE WHEN union_membership_flag = TRUE THEN employee_id END)
      comment: "Count of union-represented employees. Critical for labor relations strategy and CBA negotiation planning."
    - name: "contractor_headcount"
      expr: COUNT(DISTINCT CASE WHEN employment_type = 'Contractor' THEN employee_id END)
      comment: "Count of contractor employees. Informs make-vs-buy workforce decisions and contingent labor spend."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`workforce_employee_turnover`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Employee turnover and tenure metrics for workforce planning."
  source: "`consumer_goods_ecm`.`workforce`.`employee`"
  dimensions:
    - name: "department"
      expr: department
      comment: "Department of the employee"
    - name: "work_location_country"
      expr: work_location_country_code
      comment: "Country of work location"
    - name: "employment_status"
      expr: employment_status
      comment: "Current employment status"
    - name: "hire_year"
      expr: YEAR(hire_date)
      comment: "Year of hire"
    - name: "termination_year"
      expr: YEAR(termination_date)
      comment: "Year of termination (if any)"
  measures:
    - name: "total_employees"
      expr: COUNT(1)
      comment: "Total employee records"
    - name: "total_terminations"
      expr: COUNT(termination_date)
      comment: "Number of employees who have a termination date"
    - name: "avg_tenure_days"
      expr: AVG(DATEDIFF(COALESCE(termination_date, CURRENT_DATE()), hire_date))
      comment: "Average tenure in days, using termination date or current date"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`workforce_job_application`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Recruiting funnel and candidate pipeline metrics. Drives decisions on sourcing channel effectiveness, offer acceptance rates, diversity, and time-to-hire."
  source: "`vibe_consumer_goods_v1`.`workforce`.`job_application`"
  dimensions:
    - name: "application_status"
      expr: application_status
      comment: "Current status of the application in the recruiting funnel."
    - name: "application_stage"
      expr: application_stage
      comment: "Stage in the hiring process (screening, interview, offer) for funnel conversion analysis."
    - name: "source_channel"
      expr: source_channel
      comment: "Sourcing channel (job board, referral, agency) for channel effectiveness and cost-per-hire analysis."
    - name: "internal_candidate_flag"
      expr: internal_candidate_flag
      comment: "Whether the applicant is an internal employee. Tracks internal mobility rate."
    - name: "offer_accepted_flag"
      expr: offer_accepted_flag
      comment: "Whether the offer was accepted. Drives offer acceptance rate KPI."
    - name: "offer_extended_flag"
      expr: offer_extended_flag
      comment: "Whether an offer was extended. Tracks offer conversion rate from interview stage."
    - name: "application_date_month"
      expr: DATE_TRUNC('MONTH', application_date)
      comment: "Month of application for pipeline volume trend analysis."
    - name: "rejection_reason_code"
      expr: rejection_reason_code
      comment: "Reason for rejection for candidate quality and process improvement analysis."
  measures:
    - name: "total_applications"
      expr: COUNT(DISTINCT job_application_id)
      comment: "Total job applications received. Primary recruiting pipeline volume KPI."
    - name: "offers_extended_count"
      expr: COUNT(DISTINCT CASE WHEN offer_extended_flag = TRUE THEN job_application_id END)
      comment: "Count of offers extended. Measures recruiting funnel conversion from candidate to offer stage."
    - name: "offers_accepted_count"
      expr: COUNT(DISTINCT CASE WHEN offer_accepted_flag = TRUE THEN job_application_id END)
      comment: "Count of offers accepted. Offer acceptance rate is a key employer brand and compensation competitiveness KPI."
    - name: "avg_interview_score"
      expr: AVG(CAST(interview_score AS DOUBLE))
      comment: "Average interview score across all applications. Benchmarks candidate quality by source channel and role."
    - name: "avg_offered_salary"
      expr: AVG(CAST(offered_salary AS DOUBLE))
      comment: "Average offered salary. Tracks compensation competitiveness and budget utilization in talent acquisition."
    - name: "avg_phone_screen_score"
      expr: AVG(CAST(phone_screen_score AS DOUBLE))
      comment: "Average phone screen score. Measures early-stage candidate quality and sourcing channel effectiveness."
    - name: "internal_candidate_applications"
      expr: COUNT(DISTINCT CASE WHEN internal_candidate_flag = TRUE THEN job_application_id END)
      comment: "Count of internal candidate applications. Tracks internal mobility pipeline depth."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`workforce_labor_relation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Labor relations and grievance management metrics. Drives decisions on union relations strategy, grievance resolution efficiency, and CBA compliance risk."
  source: "`vibe_consumer_goods_v1`.`workforce`.`labor_relation`"
  dimensions:
    - name: "case_type"
      expr: case_type
      comment: "Type of labor relations case (grievance, arbitration, negotiation) for case portfolio analysis."
    - name: "case_status"
      expr: case_status
      comment: "Current status of the labor relations case for workload and resolution tracking."
    - name: "grievance_type"
      expr: grievance_type
      comment: "Type of grievance for root cause and pattern analysis."
    - name: "grievance_status"
      expr: grievance_status
      comment: "Status of the grievance for resolution pipeline monitoring."
    - name: "arbitration_flag"
      expr: arbitration_flag
      comment: "Whether the case has escalated to arbitration. Arbitration rate signals labor relations health."
    - name: "union_name"
      expr: union_name
      comment: "Union name for union-specific relations analysis and CBA compliance tracking."
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of labor agreement for CBA portfolio management."
    - name: "filed_date_month"
      expr: DATE_TRUNC('MONTH', filed_date)
      comment: "Month case was filed for trend analysis of labor relations activity."
    - name: "resolution_status"
      expr: resolution_status
      comment: "Resolution outcome for case disposition analysis."
  measures:
    - name: "total_labor_cases"
      expr: COUNT(DISTINCT labor_relation_id)
      comment: "Total labor relations cases. Primary KPI for labor relations workload and union activity monitoring."
    - name: "open_cases"
      expr: COUNT(DISTINCT CASE WHEN case_status = 'Open' THEN labor_relation_id END)
      comment: "Count of open labor relations cases. Open case backlog signals labor relations capacity and risk."
    - name: "arbitration_cases"
      expr: COUNT(DISTINCT CASE WHEN arbitration_flag = TRUE THEN labor_relation_id END)
      comment: "Count of cases escalated to arbitration. Arbitration rate is a key labor relations health and cost indicator."
    - name: "grievance_count"
      expr: COUNT(DISTINCT CASE WHEN grievance_number IS NOT NULL THEN labor_relation_id END)
      comment: "Count of formal grievances filed. Grievance rate per employee is a primary union relations health KPI."
    - name: "resolved_cases"
      expr: COUNT(DISTINCT CASE WHEN resolution_date IS NOT NULL THEN labor_relation_id END)
      comment: "Count of resolved labor relations cases. Measures resolution throughput and case management effectiveness."
    - name: "distinct_employees_with_cases"
      expr: COUNT(DISTINCT employee_id)
      comment: "Count of distinct employees involved in labor relations cases. Identifies concentration of labor relations activity."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`workforce_org_unit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Organizational structure and budget metrics. Drives decisions on org design, budget allocation, headcount capacity, and structural efficiency."
  source: "`vibe_consumer_goods_v1`.`workforce`.`org_unit`"
  dimensions:
    - name: "org_unit_type"
      expr: org_unit_type
      comment: "Type of org unit (department, division, team) for structural analysis."
    - name: "org_unit_status"
      expr: org_unit_status
      comment: "Active, inactive status for org structure health monitoring."
    - name: "hierarchy_level"
      expr: hierarchy_level
      comment: "Level in the org hierarchy for span-of-control and structural depth analysis."
    - name: "country_code"
      expr: country_code
      comment: "Country of the org unit for geographic org structure analysis."
    - name: "is_commercial_unit"
      expr: is_commercial_unit
      comment: "Whether the unit is a commercial (revenue-generating) unit for P&L structure analysis."
    - name: "is_manufacturing_unit"
      expr: is_manufacturing_unit
      comment: "Whether the unit is a manufacturing unit for operations org analysis."
    - name: "union_representation_flag"
      expr: union_representation_flag
      comment: "Whether the org unit has union representation for labor relations planning."
    - name: "effective_from_month"
      expr: DATE_TRUNC('MONTH', effective_from)
      comment: "Month the org unit became effective for org change trend analysis."
  measures:
    - name: "total_org_units"
      expr: COUNT(DISTINCT org_unit_id)
      comment: "Total number of org units. Baseline for organizational complexity and span-of-control analysis."
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budgeted amount across all org units. Primary org-level budget allocation KPI for finance and HR leadership."
    - name: "avg_budget_per_org_unit"
      expr: AVG(CAST(budget_amount AS DOUBLE))
      comment: "Average budget per org unit. Benchmarks resource allocation equity across the organization."
    - name: "union_represented_unit_count"
      expr: COUNT(DISTINCT CASE WHEN union_representation_flag = TRUE THEN org_unit_id END)
      comment: "Count of org units with union representation. Tracks union footprint for labor relations strategy."
    - name: "commercial_unit_count"
      expr: COUNT(DISTINCT CASE WHEN is_commercial_unit = TRUE THEN org_unit_id END)
      comment: "Count of commercial org units. Measures revenue-generating organizational footprint."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`workforce_payroll_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payroll cost and compensation metrics. Drives executive decisions on total labor cost, overtime exposure, tax liability, and payroll efficiency."
  source: "`vibe_consumer_goods_v1`.`workforce`.`payroll_record`"
  dimensions:
    - name: "pay_frequency"
      expr: pay_frequency
      comment: "Payroll frequency (weekly, bi-weekly, monthly) for payroll cycle analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of payroll for multi-currency cost consolidation."
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost center for labor cost attribution and budget variance analysis."
    - name: "payroll_record_status"
      expr: payroll_record_status
      comment: "Processing status of the payroll record for payroll run quality monitoring."
    - name: "payment_method"
      expr: payment_method
      comment: "Direct deposit, check, etc. for payroll operations analysis."
    - name: "pay_period_start_date_month"
      expr: DATE_TRUNC('MONTH', pay_period_start_date)
      comment: "Month of pay period start for trend analysis of payroll costs."
    - name: "pay_date_month"
      expr: DATE_TRUNC('MONTH', pay_date)
      comment: "Month of actual pay date for cash flow and accrual analysis."
  measures:
    - name: "total_gross_pay"
      expr: SUM(CAST(gross_pay AS DOUBLE))
      comment: "Total gross payroll cost. Primary labor cost KPI for executive P&L and budget reviews."
    - name: "total_net_pay"
      expr: SUM(CAST(net_pay AS DOUBLE))
      comment: "Total net pay disbursed. Drives cash flow planning and treasury management."
    - name: "total_overtime_pay"
      expr: SUM(CAST(overtime_pay_amount AS DOUBLE))
      comment: "Total overtime pay cost. High overtime signals understaffing or scheduling inefficiency and triggers operational intervention."
    - name: "total_bonus_amount"
      expr: SUM(CAST(bonus_amount AS DOUBLE))
      comment: "Total bonus payments. Tracks variable compensation spend against budget and incentive plan effectiveness."
    - name: "total_commission_amount"
      expr: SUM(CAST(commission_amount AS DOUBLE))
      comment: "Total commission payments. Measures sales incentive cost and alignment with revenue performance."
    - name: "total_deductions"
      expr: SUM(CAST(total_deductions AS DOUBLE))
      comment: "Total payroll deductions (benefits, taxes, garnishments). Used for benefits cost analysis and compliance."
    - name: "total_federal_tax_withheld"
      expr: SUM(CAST(federal_tax_withheld_amount AS DOUBLE))
      comment: "Total federal tax withheld. Required for tax compliance reporting and liability management."
    - name: "total_hours_worked"
      expr: SUM(CAST(hours_worked AS DOUBLE))
      comment: "Total hours worked across all payroll records. Drives labor productivity and cost-per-hour analysis."
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours. Overtime rate relative to regular hours is a key operational efficiency KPI."
    - name: "total_regular_hours"
      expr: SUM(CAST(regular_hours AS DOUBLE))
      comment: "Total regular (non-overtime) hours worked. Baseline for labor utilization and scheduling efficiency."
    - name: "avg_gross_pay_per_record"
      expr: AVG(CAST(gross_pay AS DOUBLE))
      comment: "Average gross pay per payroll record. Benchmarks compensation levels and detects anomalies in payroll runs."
    - name: "ytd_gross_pay"
      expr: SUM(CAST(year_to_date_gross_pay AS DOUBLE))
      comment: "Sum of year-to-date gross pay across all records. Tracks cumulative labor cost against annual budget."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`workforce_payroll_summary`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Aggregated payroll financials for cost analysis."
  source: "`consumer_goods_ecm`.`workforce`.`payroll_record`"
  dimensions:
    - name: "pay_date_month"
      expr: DATE_TRUNC('month', pay_date)
      comment: "Payroll month"
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost center identifier"
    - name: "payroll_status"
      expr: payroll_status
      comment: "Status of the payroll record"
    - name: "pay_currency"
      expr: pay_currency_code
      comment: "Currency of payroll amounts"
  measures:
    - name: "total_gross_pay"
      expr: SUM(CAST(gross_pay_amount AS DOUBLE))
      comment: "Total gross pay amount"
    - name: "total_net_pay"
      expr: SUM(CAST(net_pay_amount AS DOUBLE))
      comment: "Total net pay amount"
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours_worked AS DOUBLE))
      comment: "Total overtime hours worked"
    - name: "total_deductions"
      expr: SUM(CAST(total_deductions_amount AS DOUBLE))
      comment: "Total deductions across all payroll records"
    - name: "avg_gross_pay_per_record"
      expr: AVG(CAST(gross_pay_amount AS DOUBLE))
      comment: "Average gross pay per payroll record"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`workforce_payroll_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payroll run execution metrics. Monitors payroll processing quality, cost totals per run, and run-level efficiency for payroll operations leadership."
  source: "`vibe_consumer_goods_v1`.`workforce`.`payroll_run`"
  dimensions:
    - name: "payroll_run_status"
      expr: payroll_run_status
      comment: "Status of the payroll run (completed, failed, in-progress) for operational monitoring."
    - name: "payroll_type"
      expr: payroll_type
      comment: "Regular, off-cycle, correction run type for payroll quality analysis."
    - name: "payroll_frequency"
      expr: payroll_frequency
      comment: "Frequency of the payroll run for cycle-level cost aggregation."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the payroll run for multi-currency consolidation."
    - name: "jurisdiction_country"
      expr: jurisdiction_country
      comment: "Country jurisdiction for cross-border payroll compliance analysis."
    - name: "run_date_month"
      expr: DATE_TRUNC('MONTH', run_date)
      comment: "Month of payroll run for trend analysis of payroll volumes and costs."
  measures:
    - name: "total_payroll_runs"
      expr: COUNT(DISTINCT payroll_run_id)
      comment: "Total number of payroll runs executed. Baseline for payroll operations volume and frequency monitoring."
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross payroll amount across all runs. Primary labor cost KPI for finance and HR leadership."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net payroll disbursed. Drives cash flow forecasting and treasury planning."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total payroll tax liability across all runs. Required for tax compliance and employer cost analysis."
    - name: "total_employees_paid"
      expr: COUNT(DISTINCT employee_id)
      comment: "Count of distinct employees included in payroll runs. Validates payroll coverage and detects missed employees."
    - name: "total_hours_processed"
      expr: SUM(CAST(total_hours AS DOUBLE))
      comment: "Total hours processed across all payroll runs. Enables cost-per-hour benchmarking."
    - name: "avg_gross_amount_per_run"
      expr: AVG(CAST(gross_amount AS DOUBLE))
      comment: "Average gross payroll amount per run. Detects anomalous run sizes that may indicate errors or off-cycle corrections."
    - name: "correction_run_count"
      expr: COUNT(DISTINCT CASE WHEN correction_payroll_run_id IS NOT NULL THEN payroll_run_id END)
      comment: "Count of payroll runs that are corrections. High correction rate signals payroll process quality issues requiring intervention."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`workforce_performance_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Employee performance and talent management metrics. Drives decisions on merit increases, promotions, PIPs, and succession planning."
  source: "`vibe_consumer_goods_v1`.`workforce`.`performance_review`"
  dimensions:
    - name: "review_type"
      expr: review_type
      comment: "Annual, mid-year, probationary review type for performance cycle analysis."
    - name: "performance_review_status"
      expr: performance_review_status
      comment: "Status of the review (draft, submitted, finalized) for completion rate monitoring."
    - name: "review_period"
      expr: review_period
      comment: "Performance review period for year-over-year trend analysis."
    - name: "pip_flag"
      expr: pip_flag
      comment: "Whether the employee is on a Performance Improvement Plan. PIP rate is a key talent risk indicator."
    - name: "promotion_recommendation_flag"
      expr: promotion_recommendation_flag
      comment: "Whether the employee is recommended for promotion. Drives succession and talent pipeline decisions."
    - name: "compensation_change_flag"
      expr: compensation_change_flag
      comment: "Whether a compensation change is associated with this review. Links performance to pay decisions."
    - name: "is_finalized"
      expr: is_finalized
      comment: "Whether the review is finalized. Tracks review cycle completion rate."
    - name: "review_date_month"
      expr: DATE_TRUNC('MONTH', review_date)
      comment: "Month of review for cycle completion trend analysis."
    - name: "calibration_status"
      expr: calibration_status
      comment: "Calibration status for rating distribution fairness monitoring."
  measures:
    - name: "total_reviews"
      expr: COUNT(DISTINCT performance_review_id)
      comment: "Total number of performance reviews. Baseline for review cycle coverage and completion tracking."
    - name: "avg_overall_rating"
      expr: AVG(CAST(overall_rating AS DOUBLE))
      comment: "Average overall performance rating. Primary talent quality KPI used in calibration and succession planning."
    - name: "avg_rating_score"
      expr: AVG(CAST(rating_score AS DOUBLE))
      comment: "Average numeric rating score. Enables cross-department and cross-period performance benchmarking."
    - name: "avg_goals_met_pct"
      expr: AVG(CAST(goals_met_pct AS DOUBLE))
      comment: "Average percentage of goals met. Measures workforce goal attainment and drives MBO program effectiveness decisions."
    - name: "total_merit_increase_amount"
      expr: SUM(CAST(merit_increase_amount AS DOUBLE))
      comment: "Total merit increase dollars awarded. Tracks variable compensation spend against performance budget."
    - name: "avg_merit_increase_pct"
      expr: AVG(CAST(merit_increase_percentage AS DOUBLE))
      comment: "Average merit increase percentage. Benchmarks pay-for-performance generosity and budget utilization."
    - name: "pip_employee_count"
      expr: COUNT(DISTINCT CASE WHEN pip_flag = TRUE THEN performance_review_id END)
      comment: "Count of employees on PIPs. High PIP count signals talent quality risk and potential involuntary attrition."
    - name: "promotion_recommended_count"
      expr: COUNT(DISTINCT CASE WHEN promotion_recommendation_flag = TRUE THEN performance_review_id END)
      comment: "Count of employees recommended for promotion. Drives succession pipeline depth and internal mobility decisions."
    - name: "finalized_review_count"
      expr: COUNT(DISTINCT CASE WHEN is_finalized = TRUE THEN performance_review_id END)
      comment: "Count of finalized reviews. Tracks review cycle completion rate against HR compliance targets."
    - name: "avg_goal_actual_achievement"
      expr: AVG(CAST(goal_actual_achievement AS DOUBLE))
      comment: "Average actual goal achievement score. Measures execution effectiveness against set objectives."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`workforce_position`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Organizational position vacancy, FTE allocation, and headcount capacity metrics for workforce planning and organizational design."
  source: "`vibe_consumer_goods_v1`.`workforce`.`position`"
  dimensions:
    - name: "position_status"
      expr: position_status
      comment: "Active, frozen, eliminated position status for org design and headcount planning."
    - name: "position_type"
      expr: position_type
      comment: "Position type for workforce structure analysis."
    - name: "employment_type"
      expr: employment_type
      comment: "Full-time, part-time, contractor for workforce mix planning."
    - name: "is_vacant"
      expr: is_vacant
      comment: "Vacancy flag for open position tracking and talent acquisition prioritization."
    - name: "critical_position_flag"
      expr: critical_position_flag
      comment: "Critical position indicator for succession planning and risk management."
    - name: "job_family"
      expr: job_family
      comment: "Job family for workforce capability and skills gap analysis."
    - name: "job_level"
      expr: job_level
      comment: "Job level for organizational hierarchy and compensation band analysis."
    - name: "pay_grade"
      expr: pay_grade
      comment: "Pay grade for compensation equity and budget planning."
    - name: "remote_work_eligible_flag"
      expr: remote_work_eligible_flag
      comment: "Remote work eligibility for location strategy and talent pool analysis."
    - name: "union_eligible_flag"
      expr: union_eligible_flag
      comment: "Union eligibility for labor relations planning."
    - name: "flsa_classification"
      expr: flsa_classification
      comment: "FLSA classification for overtime compliance and cost planning."
  measures:
    - name: "total_positions"
      expr: COUNT(DISTINCT position_id)
      comment: "Total authorized positions; organizational capacity baseline for workforce planning."
    - name: "vacant_positions"
      expr: COUNT(DISTINCT CASE WHEN is_vacant = TRUE THEN position_id END)
      comment: "Count of vacant positions; talent gap metric driving recruiting prioritization and cost-of-vacancy analysis."
    - name: "vacancy_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_vacant = TRUE THEN position_id END) / NULLIF(COUNT(DISTINCT position_id), 0), 2)
      comment: "Percentage of positions currently vacant; organizational health and talent acquisition urgency KPI."
    - name: "critical_vacant_positions"
      expr: COUNT(DISTINCT CASE WHEN is_vacant = TRUE AND critical_position_flag = TRUE THEN position_id END)
      comment: "Count of vacant critical positions; high-priority succession and business continuity risk metric."
    - name: "total_budgeted_headcount"
      expr: SUM(CAST(budgeted_headcount AS DOUBLE))
      comment: "Total budgeted headcount across positions; workforce plan vs. actual gap analysis input."
    - name: "total_fte_allocation"
      expr: SUM(CAST(fte_allocation AS DOUBLE))
      comment: "Total FTE allocation across positions; labor cost planning and organizational capacity metric."
    - name: "avg_fte_per_position"
      expr: AVG(CAST(fte AS DOUBLE))
      comment: "Average FTE per position; workforce efficiency and part-time/full-time mix analysis metric."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`workforce_recruiting_requisition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Talent acquisition pipeline metrics. Drives decisions on hiring velocity, open role risk, sourcing effectiveness, and workforce planning."
  source: "`vibe_consumer_goods_v1`.`workforce`.`recruiting_requisition`"
  dimensions:
    - name: "requisition_status"
      expr: requisition_status
      comment: "Open, filled, cancelled status for pipeline health monitoring."
    - name: "requisition_type"
      expr: requisition_type
      comment: "New hire, backfill, or expansion requisition type for workforce planning analysis."
    - name: "employment_type"
      expr: employment_type
      comment: "Full-time, part-time, contractor for workforce mix planning."
    - name: "priority_level"
      expr: priority_level
      comment: "Requisition priority for resource allocation in talent acquisition."
    - name: "remote_work_eligible"
      expr: remote_work_eligible
      comment: "Whether the role is remote-eligible for talent pool and location strategy decisions."
    - name: "open_date_month"
      expr: DATE_TRUNC('MONTH', open_date)
      comment: "Month requisition was opened for hiring velocity trend analysis."
    - name: "filled_date_month"
      expr: DATE_TRUNC('MONTH', filled_date)
      comment: "Month requisition was filled for time-to-fill trend analysis."
    - name: "education_level_required"
      expr: education_level_required
      comment: "Required education level for talent pool sizing and sourcing strategy."
  measures:
    - name: "total_requisitions"
      expr: COUNT(DISTINCT recruiting_requisition_id)
      comment: "Total number of recruiting requisitions. Baseline for hiring pipeline volume and capacity planning."
    - name: "open_requisitions"
      expr: COUNT(DISTINCT CASE WHEN requisition_status = 'Open' THEN recruiting_requisition_id END)
      comment: "Count of currently open requisitions. Open role count is a primary workforce gap and risk indicator."
    - name: "filled_requisitions"
      expr: COUNT(DISTINCT CASE WHEN requisition_status = 'Filled' THEN recruiting_requisition_id END)
      comment: "Count of filled requisitions. Measures recruiting team throughput and hiring success rate."
    - name: "avg_salary_range_maximum"
      expr: AVG(CAST(salary_range_maximum AS DOUBLE))
      comment: "Average maximum salary range across open requisitions. Informs compensation budget planning and market competitiveness."
    - name: "avg_salary_range_minimum"
      expr: AVG(CAST(salary_range_minimum AS DOUBLE))
      comment: "Average minimum salary range. Benchmarks entry-level compensation against market and internal equity."
    - name: "evergreen_requisition_count"
      expr: COUNT(DISTINCT CASE WHEN evergreen_requisition = TRUE THEN recruiting_requisition_id END)
      comment: "Count of evergreen (always-open) requisitions. Signals chronic hard-to-fill roles requiring sourcing strategy changes."
    - name: "internal_only_posting_count"
      expr: COUNT(DISTINCT CASE WHEN internal_posting_only = TRUE THEN recruiting_requisition_id END)
      comment: "Count of internal-only postings. Tracks internal mobility investment and promotion-from-within culture."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`workforce_safety_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workplace safety and OSHA compliance metrics. Drives decisions on safety program investment, incident prevention, and regulatory compliance risk."
  source: "`vibe_consumer_goods_v1`.`workforce`.`safety_incident`"
  dimensions:
    - name: "incident_type"
      expr: incident_type
      comment: "Type of safety incident (injury, near-miss, property damage) for risk categorization."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity of the incident for risk prioritization and corrective action planning."
    - name: "osha_recordable_flag"
      expr: osha_recordable_flag
      comment: "Whether the incident is OSHA recordable. OSHA recordable rate is a primary regulatory compliance KPI."
    - name: "lost_time_flag"
      expr: lost_time_flag
      comment: "Whether the incident resulted in lost work time. Lost-time incident rate drives workers comp and productivity analysis."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category for systemic safety improvement decisions."
    - name: "osha_300_classification"
      expr: osha_300_classification
      comment: "OSHA 300 log classification for regulatory reporting compliance."
    - name: "incident_date_month"
      expr: DATE_TRUNC('MONTH', incident_date)
      comment: "Month of incident for trend analysis and seasonal safety pattern detection."
    - name: "safety_incident_status"
      expr: safety_incident_status
      comment: "Current status of the incident investigation and resolution."
    - name: "investigation_status"
      expr: investigation_status
      comment: "Status of the root cause investigation for corrective action tracking."
  measures:
    - name: "total_incidents"
      expr: COUNT(DISTINCT safety_incident_id)
      comment: "Total safety incidents. Primary safety performance KPI for executive safety reviews and regulatory reporting."
    - name: "osha_recordable_incidents"
      expr: COUNT(DISTINCT CASE WHEN osha_recordable_flag = TRUE THEN safety_incident_id END)
      comment: "Count of OSHA recordable incidents. Directly drives OSHA 300 log compliance and regulatory risk exposure."
    - name: "lost_time_incidents"
      expr: COUNT(DISTINCT CASE WHEN lost_time_flag = TRUE THEN safety_incident_id END)
      comment: "Count of lost-time incidents. Lost-time incident rate is a primary workers compensation and productivity KPI."
    - name: "total_medical_cost"
      expr: SUM(CAST(medical_cost AS DOUBLE))
      comment: "Total medical costs from safety incidents. Drives safety program ROI and insurance cost management decisions."
    - name: "total_indemnity_cost"
      expr: SUM(CAST(indemnity_cost AS DOUBLE))
      comment: "Total indemnity (wage replacement) costs. Measures financial impact of lost-time incidents on labor cost."
    - name: "total_incident_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total all-in cost of safety incidents. Primary financial KPI for safety program investment justification."
    - name: "avg_incident_cost"
      expr: AVG(CAST(total_cost AS DOUBLE))
      comment: "Average cost per safety incident. Benchmarks incident severity and guides risk-based safety investment."
    - name: "modified_duty_incident_count"
      expr: COUNT(DISTINCT CASE WHEN modified_duty_flag = TRUE THEN safety_incident_id END)
      comment: "Count of incidents resulting in modified duty. Tracks return-to-work program effectiveness and productivity impact."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`workforce_shift_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shift scheduling and labor capacity metrics. Drives decisions on shift coverage, overtime risk, scheduling efficiency, and production staffing."
  source: "`vibe_consumer_goods_v1`.`workforce`.`shift_schedule`"
  dimensions:
    - name: "shift_type"
      expr: shift_type
      comment: "Day, evening, night shift type for shift mix and premium pay analysis."
    - name: "schedule_type"
      expr: schedule_type
      comment: "Fixed, rotating, flexible schedule type for workforce flexibility analysis."
    - name: "schedule_status"
      expr: schedule_status
      comment: "Active, inactive schedule status for capacity planning."
    - name: "shift_differential_flag"
      expr: shift_differential_flag
      comment: "Whether the shift carries a differential premium. Tracks premium labor cost exposure."
    - name: "labor_category"
      expr: labor_category
      comment: "Labor category for cost allocation and workforce classification."
    - name: "shift_date_month"
      expr: DATE_TRUNC('MONTH', shift_date)
      comment: "Month of shift for scheduling trend and capacity analysis."
    - name: "effective_start_date_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month schedule became effective for scheduling change trend analysis."
  measures:
    - name: "total_scheduled_hours"
      expr: SUM(CAST(scheduled_hours AS DOUBLE))
      comment: "Total scheduled hours across all shift schedules. Primary labor capacity planning KPI."
    - name: "avg_scheduled_hours_per_shift"
      expr: AVG(CAST(scheduled_hours AS DOUBLE))
      comment: "Average scheduled hours per shift. Benchmarks shift length and identifies scheduling anomalies."
    - name: "total_max_hours_per_week"
      expr: SUM(CAST(max_hours_per_week AS DOUBLE))
      comment: "Sum of maximum weekly hours across all schedules. Measures total authorized labor capacity."
    - name: "shift_differential_schedule_count"
      expr: COUNT(DISTINCT CASE WHEN shift_differential_flag = TRUE THEN shift_schedule_id END)
      comment: "Count of schedules with shift differentials. Tracks premium pay exposure in the scheduling portfolio."
    - name: "avg_shift_differential_rate"
      expr: AVG(CAST(shift_differential_rate AS DOUBLE))
      comment: "Average shift differential rate. Benchmarks premium pay cost and informs shift design decisions."
    - name: "avg_overtime_multiplier"
      expr: AVG(CAST(overtime_multiplier AS DOUBLE))
      comment: "Average overtime multiplier across schedules. Tracks overtime cost exposure in the scheduling structure."
    - name: "total_distinct_employees_scheduled"
      expr: COUNT(DISTINCT employee_id)
      comment: "Count of distinct employees with active shift schedules. Measures scheduling coverage and identifies unscheduled employees."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`workforce_time_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Time and attendance metrics. Drives decisions on labor utilization, overtime cost, absence management, and FMLA/OSHA compliance exposure."
  source: "`vibe_consumer_goods_v1`.`workforce`.`time_entry`"
  dimensions:
    - name: "entry_type"
      expr: entry_type
      comment: "Type of time entry (regular, overtime, absence, holiday) for labor category analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of time entries for payroll readiness and compliance monitoring."
    - name: "shift_type"
      expr: shift_type
      comment: "Shift type for shift-differential cost and scheduling analysis."
    - name: "absence_type"
      expr: absence_type
      comment: "Type of absence (sick, vacation, FMLA) for absence pattern and cost analysis."
    - name: "fmla_eligible_flag"
      expr: fmla_eligible_flag
      comment: "Whether the entry is FMLA-eligible for compliance exposure tracking."
    - name: "osha_recordable_flag"
      expr: osha_recordable_flag
      comment: "Whether the time entry is linked to an OSHA recordable incident."
    - name: "work_date_month"
      expr: DATE_TRUNC('MONTH', work_date)
      comment: "Month of work date for trend analysis of hours and absence."
    - name: "weekend_flag"
      expr: weekend_flag
      comment: "Whether the entry falls on a weekend for premium pay and scheduling analysis."
    - name: "holiday_flag"
      expr: holiday_flag
      comment: "Whether the entry falls on a holiday for premium pay cost analysis."
    - name: "labor_category_code"
      expr: labor_category_code
      comment: "Labor category for cost allocation and workforce classification analysis."
  measures:
    - name: "total_hours_worked"
      expr: SUM(CAST(hours_worked AS DOUBLE))
      comment: "Total hours worked across all time entries. Primary labor utilization KPI for operations and finance."
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours. Overtime exposure drives cost and scheduling intervention decisions."
    - name: "total_regular_hours"
      expr: SUM(CAST(regular_hours AS DOUBLE))
      comment: "Total regular hours worked. Baseline for labor capacity and utilization benchmarking."
    - name: "total_paid_time_off_hours"
      expr: SUM(CAST(paid_time_off_hours AS DOUBLE))
      comment: "Total PTO hours taken. Tracks PTO liability consumption and workforce availability impact."
    - name: "total_unpaid_time_off_hours"
      expr: SUM(CAST(unpaid_time_off_hours AS DOUBLE))
      comment: "Total unpaid time off hours. Signals workforce availability gaps and potential engagement issues."
    - name: "total_overtime_1_5x_hours"
      expr: SUM(CAST(overtime_hours_1_5x AS DOUBLE))
      comment: "Total 1.5x overtime hours. Drives premium labor cost analysis and scheduling optimization."
    - name: "total_overtime_2x_hours"
      expr: SUM(CAST(overtime_hours_2x AS DOUBLE))
      comment: "Total double-time overtime hours. High double-time signals critical understaffing or emergency operations."
    - name: "unapproved_entry_count"
      expr: COUNT(DISTINCT CASE WHEN approval_status != 'Approved' THEN time_entry_id END)
      comment: "Count of time entries not yet approved. Unapproved entries block payroll processing and signal compliance risk."
    - name: "fmla_entry_count"
      expr: COUNT(DISTINCT CASE WHEN fmla_eligible_flag = TRUE THEN time_entry_id END)
      comment: "Count of FMLA-eligible time entries. Tracks FMLA utilization and compliance exposure."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`workforce_training_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Employee training completion and certification metrics. Drives decisions on compliance training coverage, skill development investment, and certification expiry risk."
  source: "`vibe_consumer_goods_v1`.`workforce`.`training_record`"
  dimensions:
    - name: "completion_status"
      expr: completion_status
      comment: "Training completion status (completed, in-progress, not-started) for coverage analysis."
    - name: "pass_fail_status"
      expr: pass_fail_status
      comment: "Pass/fail outcome for training effectiveness and quality analysis."
    - name: "training_type"
      expr: training_type
      comment: "Type of training (compliance, technical, leadership) for investment allocation analysis."
    - name: "recertification_required"
      expr: recertification_required
      comment: "Whether recertification is required. Drives compliance calendar and expiry risk management."
    - name: "completion_date_month"
      expr: DATE_TRUNC('MONTH', completion_date)
      comment: "Month of training completion for trend analysis of training throughput."
    - name: "certification_expiry_date_month"
      expr: DATE_TRUNC('MONTH', certification_expiry_date)
      comment: "Month of certification expiry for proactive compliance risk management."
    - name: "training_record_status"
      expr: training_record_status
      comment: "Overall status of the training record for compliance audit readiness."
  measures:
    - name: "total_training_records"
      expr: COUNT(DISTINCT training_record_id)
      comment: "Total training records. Baseline for training program coverage and throughput."
    - name: "completed_training_count"
      expr: COUNT(DISTINCT CASE WHEN completion_status = 'Completed' THEN training_record_id END)
      comment: "Count of completed training records. Drives training completion rate KPI for compliance and development programs."
    - name: "passed_training_count"
      expr: COUNT(DISTINCT CASE WHEN pass_flag = TRUE THEN training_record_id END)
      comment: "Count of training records with a passing result. Measures training effectiveness and employee competency attainment."
    - name: "total_training_hours"
      expr: SUM(CAST(training_hours AS DOUBLE))
      comment: "Total training hours delivered. Tracks learning investment and compliance hour requirements."
    - name: "avg_training_score"
      expr: AVG(CAST(score AS DOUBLE))
      comment: "Average assessment score across training completions. Measures training program quality and employee knowledge retention."
    - name: "expiring_certifications_count"
      expr: COUNT(DISTINCT CASE WHEN certification_expiry_date <= DATE_ADD(CURRENT_DATE(), 90) AND certification_expiry_date >= CURRENT_DATE() THEN training_record_id END)
      comment: "Count of certifications expiring within 90 days. Proactive compliance risk KPI that triggers recertification actions."
    - name: "expired_certifications_count"
      expr: COUNT(DISTINCT CASE WHEN certification_expiry_date < CURRENT_DATE() THEN training_record_id END)
      comment: "Count of already-expired certifications. Measures active compliance gap and regulatory risk exposure."
$$;
