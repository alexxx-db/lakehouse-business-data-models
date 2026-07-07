-- Metric views for domain: workforce | Business: Ngo | Version: 2 | Generated on: 2026-07-03 05:04:58

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`workforce_staff_member`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core workforce headcount and compensation analytics. Source of record for active staff population, salary benchmarking, and demographic composition. Relevant to SAP HCM / Workday HRIS systems used by INGOs. Supports executive headcount dashboards, donor audit staffing schedules, and budget planning."
  source: "`vibe_ngo_v1`.`workforce`.`staff_member`"
  dimensions:
    - name: "employment_status"
      expr: employment_status
      comment: "Current employment status (Active, On Leave, Separated) — primary filter for headcount reporting."
    - name: "employment_type"
      expr: employment_type
      comment: "Contract modality (National Staff, International Staff, Consultant, Volunteer) — drives compensation benchmarking and donor reporting."
    - name: "contract_type"
      expr: contract_type
      comment: "Contract category (Fixed-Term, Open-Ended, Short-Term) — used for workforce planning and risk assessment."
    - name: "department"
      expr: department
      comment: "Organizational department — enables headcount and cost analysis by functional area."
    - name: "duty_station_country"
      expr: duty_station_country
      comment: "Country of duty station — critical for field vs. HQ split and country-level workforce planning."
    - name: "gender"
      expr: gender
      comment: "Staff gender — required for gender parity KPIs and donor diversity reporting."
    - name: "job_grade"
      expr: job_grade
      comment: "Salary grade band — used for compensation equity analysis and budget forecasting."
    - name: "job_title"
      expr: job_title
      comment: "Current job title — supports role-level workforce composition analysis."
    - name: "nationality"
      expr: nationality
      comment: "Staff nationality — used for national/international staff ratio reporting and visa compliance tracking."
    - name: "salary_currency"
      expr: salary_currency
      comment: "Currency of base salary — needed for multi-currency payroll cost consolidation."
    - name: "separation_type"
      expr: separation_type
      comment: "Type of separation (Resignation, Termination, End of Contract) — drives attrition analysis."
    - name: "hire_year"
      expr: DATE_TRUNC('YEAR', hire_date)
      comment: "Year of hire — enables cohort-based tenure and retention analysis."
  measures:
    - name: "total_active_headcount"
      expr: COUNT(CASE WHEN employment_status = 'Active' THEN staff_member_id END)
      comment: "Total number of currently active staff members. Primary workforce sizing KPI used in board decks, donor staffing schedules, and budget planning."
    - name: "total_headcount"
      expr: COUNT(staff_member_id)
      comment: "Total staff records including all statuses. Used as denominator for attrition rate and other ratio KPIs."
    - name: "total_base_salary_usd"
      expr: SUM(CAST(base_salary_amount AS DOUBLE))
      comment: "Sum of all base salary amounts. Core payroll cost KPI used in budget vs. actuals and grant cost allocation reporting."
    - name: "avg_base_salary_usd"
      expr: AVG(CAST(base_salary_amount AS DOUBLE))
      comment: "Average base salary across staff. Used for compensation equity analysis and benchmarking against INGO salary scales."
    - name: "total_separated_staff"
      expr: COUNT(CASE WHEN employment_status = 'Separated' THEN staff_member_id END)
      comment: "Count of staff who have separated. Numerator for attrition rate calculation — triggers HR intervention when elevated."
    - name: "total_fte"
      expr: SUM(CAST(fte_percentage AS DOUBLE))
      comment: "Sum of FTE percentages across all active staff. Used for capacity planning, grant effort allocation, and donor reporting on staffing levels."
    - name: "avg_fte_percentage"
      expr: AVG(CAST(fte_percentage AS DOUBLE))
      comment: "Average FTE percentage per staff record. Identifies part-time workforce concentration and informs workforce restructuring decisions."
    - name: "international_staff_count"
      expr: COUNT(CASE WHEN employment_type = 'International' THEN staff_member_id END)
      comment: "Count of international staff. Used for expat cost tracking, visa compliance, and national/international staff ratio reporting."
    - name: "national_staff_count"
      expr: COUNT(CASE WHEN employment_type = 'National' THEN staff_member_id END)
      comment: "Count of national staff. Supports localization strategy KPIs and donor requirements for national staff percentage targets."
    - name: "rehire_eligible_count"
      expr: COUNT(CASE WHEN rehire_eligible = TRUE THEN staff_member_id END)
      comment: "Count of separated staff eligible for rehire. Informs talent pipeline and surge capacity planning for emergency response."
    - name: "exit_interview_completion_count"
      expr: COUNT(CASE WHEN exit_interview_completed = TRUE THEN staff_member_id END)
      comment: "Count of separated staff with completed exit interviews. Measures HR process compliance and data quality for attrition analysis."
    - name: "total_final_settlement_usd"
      expr: SUM(CAST(final_settlement_amount AS DOUBLE))
      comment: "Total final settlement amounts paid to separated staff. Key financial liability KPI for HR and finance leadership."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`workforce_employment_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Employment contract lifecycle and compensation analytics. Tracks contract types, salary structures, allowances, and amendment activity. Supports grant-funded position tracking, INGO salary scale compliance, and donor audit requirements. Relevant to SAP HCM, Workday, and eZHACT contract management systems."
  source: "`vibe_ngo_v1`.`workforce`.`employment_contract`"
  dimensions:
    - name: "contract_type"
      expr: contract_type
      comment: "Contract modality (Fixed-Term, Open-Ended, Consultancy) — primary segmentation for compensation analysis."
    - name: "contract_status"
      expr: contract_status
      comment: "Current contract status (Active, Expired, Terminated, Amended) — used to filter active workforce cost base."
    - name: "staff_category"
      expr: staff_category
      comment: "Staff category (International Professional, National Professional, General Service) — drives salary scale and allowance eligibility."
    - name: "duty_station_country_code"
      expr: duty_station_country_code
      comment: "Country of duty station — enables country-level compensation cost analysis."
    - name: "salary_currency"
      expr: salary_currency
      comment: "Currency of salary payment — required for multi-currency cost consolidation."
    - name: "salary_grade"
      expr: salary_grade
      comment: "Salary grade — used for pay equity analysis and INGO salary scale compliance."
    - name: "is_expatriate"
      expr: is_expatriate
      comment: "Flag indicating expatriate status — drives expat package cost tracking and budget forecasting."
    - name: "hardship_tier"
      expr: hardship_tier
      comment: "Hardship classification of duty station — used for allowance cost analysis and staff welfare reporting."
    - name: "funding_source_code"
      expr: funding_source_code
      comment: "Funding source for the position — enables grant-funded vs. core-funded staff cost split."
    - name: "start_year"
      expr: DATE_TRUNC('YEAR', start_date)
      comment: "Year contract started — used for cohort analysis and workforce planning trend reporting."
  measures:
    - name: "total_active_contracts"
      expr: COUNT(CASE WHEN contract_status = 'Active' THEN employment_contract_id END)
      comment: "Total number of active employment contracts. Primary workforce sizing metric for budget and grant reporting."
    - name: "total_base_salary_cost"
      expr: SUM(CAST(base_salary_amount AS DOUBLE))
      comment: "Total base salary cost across all contracts. Core payroll budget KPI used in grant budget vs. actuals and donor financial reports."
    - name: "avg_base_salary"
      expr: AVG(CAST(base_salary_amount AS DOUBLE))
      comment: "Average base salary per contract. Used for compensation benchmarking against INGO salary scales and pay equity analysis."
    - name: "total_hardship_allowance_cost"
      expr: SUM(CAST(hardship_allowance_amount AS DOUBLE))
      comment: "Total hardship allowance expenditure. Tracks field deployment cost premium — informs duty station risk/cost trade-off decisions."
    - name: "total_housing_allowance_cost"
      expr: SUM(CAST(housing_allowance_amount AS DOUBLE))
      comment: "Total housing allowance cost. Significant expat cost component tracked separately for grant budget compliance."
    - name: "total_education_allowance_cost"
      expr: SUM(CAST(education_allowance_amount AS DOUBLE))
      comment: "Total education allowance expenditure. Expat benefit cost tracked for grant compliance and total compensation reporting."
    - name: "total_relocation_allowance_cost"
      expr: SUM(CAST(relocation_allowance_amount AS DOUBLE))
      comment: "Total relocation allowance paid. One-time cost tracked for budget planning and grant prior approval compliance."
    - name: "total_contracts"
      expr: COUNT(employment_contract_id)
      comment: "Total contract records. Used as denominator for amendment rate and other contract lifecycle KPIs."
    - name: "amended_contract_count"
      expr: COUNT(CASE WHEN amendment_number IS NOT NULL THEN employment_contract_id END)
      comment: "Count of contracts with amendments. High amendment rates signal instability in funding or organizational restructuring."
    - name: "expatriate_contract_count"
      expr: COUNT(CASE WHEN is_expatriate = TRUE THEN employment_contract_id END)
      comment: "Count of expatriate contracts. Drives expat cost tracking and localization strategy KPIs."
    - name: "avg_icr_rate"
      expr: AVG(CAST(icr_rate AS DOUBLE))
      comment: "Average indirect cost recovery rate across contracts. Used for grant budget planning and NICRA compliance reporting."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`workforce_payroll_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payroll execution and cost analytics. Tracks gross pay, deductions, employer contributions, and tax withholding by country, fund, and grant. Critical for grant financial reporting, NICRA compliance, and donor audit. Relevant to SAP Payroll, Workday Payroll, and ICON financial systems used by INGOs."
  source: "`vibe_ngo_v1`.`workforce`.`payroll_run`"
  dimensions:
    - name: "country_code"
      expr: country_code
      comment: "Country of payroll run — enables country-level payroll cost analysis and statutory compliance tracking."
    - name: "run_status"
      expr: run_status
      comment: "Payroll run status (Draft, Approved, Posted, Reversed) — used to filter to finalized payroll data."
    - name: "run_type"
      expr: run_type
      comment: "Type of payroll run (Regular, Off-Cycle, Retroactive, Correction) — identifies non-standard payroll activity."
    - name: "pay_frequency"
      expr: pay_frequency
      comment: "Payroll frequency (Monthly, Bi-Weekly) — used for payroll cycle analysis."
    - name: "payroll_group"
      expr: payroll_group
      comment: "Payroll group (International Staff, National Staff, Consultants) — enables staff category cost split."
    - name: "currency_code"
      expr: currency_code
      comment: "Payroll currency — required for multi-currency cost consolidation."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of payroll run — used for annual payroll cost trend analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period (month) — enables monthly payroll cost tracking against budget."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of payroll run — used to identify unapproved or pending payroll runs."
    - name: "is_retroactive"
      expr: is_retroactive
      comment: "Flag for retroactive payroll runs — retroactive runs indicate corrections and carry audit risk."
    - name: "pay_period_start"
      expr: DATE_TRUNC('MONTH', pay_period_start_date)
      comment: "Pay period start month — used for monthly payroll trend analysis."
  measures:
    - name: "total_gross_pay"
      expr: SUM(CAST(total_gross_pay AS DOUBLE))
      comment: "Total gross payroll cost across all runs. Primary payroll budget KPI used in grant financial reports and donor audits."
    - name: "total_net_pay"
      expr: SUM(CAST(total_net_pay AS DOUBLE))
      comment: "Total net pay disbursed to staff. Used for cash flow planning and bank reconciliation."
    - name: "total_tax_withheld"
      expr: SUM(CAST(total_tax_withheld AS DOUBLE))
      comment: "Total tax withheld across payroll runs. Statutory compliance KPI — triggers review if deviates from expected rates."
    - name: "total_employer_contributions"
      expr: SUM(CAST(total_employer_contributions AS DOUBLE))
      comment: "Total employer benefit contributions (pension, social security). Fringe benefit cost KPI used in NICRA rate calculations."
    - name: "total_deductions"
      expr: SUM(CAST(total_deductions AS DOUBLE))
      comment: "Total employee deductions. Used for payroll reconciliation and statutory compliance reporting."
    - name: "total_payroll_runs"
      expr: COUNT(payroll_run_id)
      comment: "Total number of payroll runs. Used as denominator for retroactive run rate and off-cycle run frequency analysis."
    - name: "retroactive_run_count"
      expr: COUNT(CASE WHEN is_retroactive = TRUE THEN payroll_run_id END)
      comment: "Count of retroactive payroll runs. High retroactive run frequency signals payroll process quality issues and audit risk."
    - name: "avg_gross_pay_per_run"
      expr: AVG(CAST(total_gross_pay AS DOUBLE))
      comment: "Average gross pay per payroll run. Used for payroll cost trend monitoring and anomaly detection."
    - name: "avg_exchange_rate"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average exchange rate applied across payroll runs. Used for multi-currency payroll cost analysis and FX risk monitoring."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`workforce_payslip`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Individual payslip-level compensation analytics. Enables per-staff compensation breakdown, allowance analysis, and payroll correction tracking. Supports grant effort certification, NICRA fringe benefit rate validation, and donor audit. Relevant to SAP Payroll and Workday Payroll systems."
  source: "`vibe_ngo_v1`.`workforce`.`payslip`"
  dimensions:
    - name: "country_code"
      expr: country_code
      comment: "Country of payslip — enables country-level compensation cost analysis."
    - name: "payroll_group"
      expr: payroll_group
      comment: "Payroll group (International, National) — drives staff category cost split."
    - name: "payslip_status"
      expr: payslip_status
      comment: "Payslip status (Draft, Approved, Paid, Reversed) — used to filter to finalized payslips."
    - name: "is_correction"
      expr: is_correction
      comment: "Flag for correction payslips — high correction rates indicate payroll data quality issues."
    - name: "is_off_cycle"
      expr: is_off_cycle
      comment: "Flag for off-cycle payslips — off-cycle payments carry additional processing cost and audit scrutiny."
    - name: "local_currency_code"
      expr: local_currency_code
      comment: "Local currency of payslip — required for multi-currency payroll cost analysis."
    - name: "program_code"
      expr: program_code
      comment: "Program code charged — enables program-level payroll cost analysis for grant reporting."
    - name: "pay_period_month"
      expr: DATE_TRUNC('MONTH', pay_period_start_date)
      comment: "Pay period month — used for monthly payroll cost trend analysis."
  measures:
    - name: "total_gross_salary"
      expr: SUM(CAST(gross_salary AS DOUBLE))
      comment: "Total gross salary across all payslips. Core payroll cost KPI for grant financial reporting and budget vs. actuals."
    - name: "total_net_pay_local"
      expr: SUM(CAST(net_pay_local AS DOUBLE))
      comment: "Total net pay in local currency. Used for cash disbursement planning and bank reconciliation."
    - name: "total_hardship_allowance"
      expr: SUM(CAST(hardship_allowance AS DOUBLE))
      comment: "Total hardship allowance paid. Field deployment cost premium — tracked for duty station cost analysis."
    - name: "total_housing_allowance"
      expr: SUM(CAST(housing_allowance AS DOUBLE))
      comment: "Total housing allowance paid. Significant expat cost component tracked for grant budget compliance."
    - name: "total_transport_allowance"
      expr: SUM(CAST(transport_allowance AS DOUBLE))
      comment: "Total transport allowance paid. Operational cost component tracked for budget management."
    - name: "total_expat_allowance"
      expr: SUM(CAST(expat_allowance AS DOUBLE))
      comment: "Total expatriate allowances paid. Tracks expat premium cost for localization strategy and budget decisions."
    - name: "total_field_allowance"
      expr: SUM(CAST(field_allowance AS DOUBLE))
      comment: "Total field allowance paid. Measures field deployment cost premium for operational budget planning."
    - name: "total_income_tax_deduction"
      expr: SUM(CAST(income_tax_deduction AS DOUBLE))
      comment: "Total income tax withheld. Statutory compliance KPI — used for tax authority reporting and audit."
    - name: "total_pension_deduction"
      expr: SUM(CAST(pension_deduction AS DOUBLE))
      comment: "Total employee pension deductions. Used for pension fund reconciliation and benefit cost reporting."
    - name: "total_employer_pension_contribution"
      expr: SUM(CAST(employer_pension_contribution AS DOUBLE))
      comment: "Total employer pension contributions. Fringe benefit cost KPI used in NICRA rate calculations and grant budgets."
    - name: "total_employer_social_security"
      expr: SUM(CAST(employer_social_security AS DOUBLE))
      comment: "Total employer social security contributions. Statutory cost KPI for country-level compliance reporting."
    - name: "total_allowances"
      expr: SUM(CAST(total_allowances AS DOUBLE))
      comment: "Total allowances paid across all payslips. Used for total compensation analysis and grant budget compliance."
    - name: "total_statutory_deductions"
      expr: SUM(CAST(total_statutory_deductions AS DOUBLE))
      comment: "Total statutory deductions. Used for compliance reporting and payroll reconciliation."
    - name: "correction_payslip_count"
      expr: COUNT(CASE WHEN is_correction = TRUE THEN payslip_id END)
      comment: "Count of correction payslips. High correction rates signal payroll data quality issues and increase audit risk."
    - name: "total_payslips"
      expr: COUNT(payslip_id)
      comment: "Total payslip records. Used as denominator for correction rate and off-cycle rate KPIs."
    - name: "avg_gross_salary"
      expr: AVG(CAST(gross_salary AS DOUBLE))
      comment: "Average gross salary per payslip. Used for compensation benchmarking and anomaly detection."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`workforce_benefit_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Staff benefit enrollment analytics. Tracks enrollment rates, contribution costs, and coverage tiers. Supports total compensation reporting, fringe benefit rate calculations for NICRA, and benefit plan utilization analysis. Relevant to Workday Benefits and SAP HR benefit administration modules."
  source: "`vibe_ngo_v1`.`workforce`.`benefit_enrollment`"
  dimensions:
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Benefit enrollment status (Active, Terminated, Waived, Pending) — primary filter for active benefit cost analysis."
    - name: "plan_type"
      expr: plan_type
      comment: "Benefit plan type (Medical, Dental, Life Insurance, Pension, Medevac) — enables cost analysis by benefit category."
    - name: "coverage_tier"
      expr: coverage_tier
      comment: "Coverage tier (Employee Only, Employee + Spouse, Family) — drives cost differentiation analysis."
    - name: "staff_category"
      expr: staff_category
      comment: "Staff category — enables benefit cost analysis by employment category."
    - name: "duty_station_country"
      expr: duty_station_country
      comment: "Country of duty station — used for country-level benefit cost analysis."
    - name: "contribution_frequency"
      expr: contribution_frequency
      comment: "Contribution frequency (Monthly, Annual) — used for cash flow planning."
    - name: "is_dependent_coverage"
      expr: is_dependent_coverage
      comment: "Flag for dependent coverage — dependent coverage significantly increases benefit cost."
    - name: "cobra_eligible"
      expr: cobra_eligible
      comment: "COBRA eligibility flag — relevant for US-based staff benefit compliance."
    - name: "enrollment_year"
      expr: DATE_TRUNC('YEAR', enrollment_date)
      comment: "Year of enrollment — used for annual benefit enrollment trend analysis."
  measures:
    - name: "total_active_enrollments"
      expr: COUNT(CASE WHEN enrollment_status = 'Active' THEN benefit_enrollment_id END)
      comment: "Total active benefit enrollments. Primary benefit utilization KPI used in total compensation reporting."
    - name: "total_employee_contribution"
      expr: SUM(CAST(employee_contribution_amount AS DOUBLE))
      comment: "Total employee benefit contributions. Used for net compensation analysis and benefit cost sharing reporting."
    - name: "total_employer_contribution"
      expr: SUM(CAST(employer_contribution_amount AS DOUBLE))
      comment: "Total employer benefit contributions. Core fringe benefit cost KPI used in NICRA rate calculations and grant budgets."
    - name: "total_life_insurance_coverage"
      expr: SUM(CAST(life_insurance_coverage_amount AS DOUBLE))
      comment: "Total life insurance coverage amount across enrolled staff. Used for insurance liability and benefit adequacy reporting."
    - name: "avg_employee_contribution"
      expr: AVG(CAST(employee_contribution_amount AS DOUBLE))
      comment: "Average employee contribution per enrollment. Used for benefit affordability analysis and plan design decisions."
    - name: "avg_employer_contribution"
      expr: AVG(CAST(employer_contribution_amount AS DOUBLE))
      comment: "Average employer contribution per enrollment. Used for per-capita fringe benefit cost benchmarking."
    - name: "dependent_coverage_enrollment_count"
      expr: COUNT(CASE WHEN is_dependent_coverage = TRUE THEN benefit_enrollment_id END)
      comment: "Count of enrollments with dependent coverage. Dependent coverage drives higher benefit costs — tracked for budget planning."
    - name: "waived_enrollment_count"
      expr: COUNT(CASE WHEN enrollment_status = 'Waived' THEN benefit_enrollment_id END)
      comment: "Count of waived benefit enrollments. High waiver rates may indicate benefit plan design issues or affordability concerns."
    - name: "avg_pension_contribution_rate"
      expr: AVG(CAST(pension_contribution_rate_pct AS DOUBLE))
      comment: "Average pension contribution rate percentage. Used for pension cost forecasting and NICRA fringe benefit rate validation."
    - name: "total_enrollments"
      expr: COUNT(benefit_enrollment_id)
      comment: "Total benefit enrollment records. Used as denominator for waiver rate and dependent coverage rate KPIs."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`workforce_leave_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Staff leave utilization and balance analytics. Tracks leave consumption, balances, and approval patterns. Supports workforce availability planning, R&R compliance for field staff, and leave liability reporting. Relevant to Workday Absence Management and SAP HR leave modules used by INGOs."
  source: "`vibe_ngo_v1`.`workforce`.`leave_request`"
  dimensions:
    - name: "leave_type"
      expr: leave_type
      comment: "Type of leave (Annual, Sick, Maternity, R&R, Compassionate) — primary segmentation for leave utilization analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Leave approval status (Approved, Pending, Rejected, Cancelled) — used to filter to approved leave for utilization reporting."
    - name: "staff_category"
      expr: staff_category
      comment: "Staff category — enables leave utilization analysis by employment category."
    - name: "duty_station_country"
      expr: duty_station_country
      comment: "Country of duty station — used for country-level leave pattern analysis."
    - name: "contract_type"
      expr: contract_type
      comment: "Contract type — leave entitlements vary by contract type."
    - name: "is_rnr_eligible"
      expr: is_rnr_eligible
      comment: "R&R eligibility flag — R&R leave is a mandatory field staff welfare entitlement tracked separately."
    - name: "is_retroactive"
      expr: is_retroactive
      comment: "Retroactive leave flag — retroactive requests indicate process compliance issues."
    - name: "leave_year"
      expr: leave_year
      comment: "Leave year — used for annual leave utilization trend analysis."
    - name: "request_month"
      expr: DATE_TRUNC('MONTH', requested_start_date)
      comment: "Month of leave request — used for seasonal leave pattern analysis and workforce availability planning."
  measures:
    - name: "total_approved_leave_requests"
      expr: COUNT(CASE WHEN approval_status = 'Approved' THEN leave_request_id END)
      comment: "Total approved leave requests. Primary leave utilization KPI used in workforce availability planning."
    - name: "total_days_taken"
      expr: SUM(CAST(actual_days_taken AS DOUBLE))
      comment: "Total actual leave days consumed. Core leave liability and workforce availability KPI."
    - name: "total_days_requested"
      expr: SUM(CAST(requested_days AS DOUBLE))
      comment: "Total leave days requested. Used as denominator for approval rate and to assess leave demand vs. availability."
    - name: "avg_days_per_request"
      expr: AVG(CAST(actual_days_taken AS DOUBLE))
      comment: "Average leave days per approved request. Used for workforce availability planning and leave pattern analysis."
    - name: "total_leave_balance_after"
      expr: SUM(CAST(leave_balance_after AS DOUBLE))
      comment: "Total remaining leave balance across staff. Represents accrued leave liability — a financial obligation tracked by finance."
    - name: "total_carry_forward_days"
      expr: SUM(CAST(carry_forward_days AS DOUBLE))
      comment: "Total leave days carried forward. High carry-forward balances indicate staff are not taking adequate rest — a welfare and liability risk."
    - name: "total_toil_hours_accrued"
      expr: SUM(CAST(toil_hours_accrued AS DOUBLE))
      comment: "Total time-off-in-lieu hours accrued. TOIL accumulation indicates overtime burden and potential staff welfare issues."
    - name: "total_entitlement_days"
      expr: SUM(CAST(entitlement_days AS DOUBLE))
      comment: "Total leave entitlement days across staff. Used as denominator for leave utilization rate calculation."
    - name: "rnr_leave_request_count"
      expr: COUNT(CASE WHEN is_rnr_eligible = TRUE THEN leave_request_id END)
      comment: "Count of R&R leave requests. R&R compliance is a mandatory field staff welfare requirement — low counts trigger HR intervention."
    - name: "retroactive_request_count"
      expr: COUNT(CASE WHEN is_retroactive = TRUE THEN leave_request_id END)
      comment: "Count of retroactive leave requests. High retroactive rates indicate process compliance issues."
    - name: "total_leave_requests"
      expr: COUNT(leave_request_id)
      comment: "Total leave requests. Used as denominator for approval rate and retroactive rate KPIs."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`workforce_performance_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Staff performance review analytics. Tracks rating distributions, completion rates, PIP triggers, and promotion recommendations. Supports talent management decisions, succession planning, and organizational effectiveness reporting. Relevant to Workday Performance and SAP SuccessFactors used by INGOs."
  source: "`vibe_ngo_v1`.`workforce`.`performance_review`"
  dimensions:
    - name: "review_status"
      expr: review_status
      comment: "Review status (Draft, Submitted, Calibrated, Acknowledged, Closed) — used to filter to completed reviews."
    - name: "overall_rating"
      expr: overall_rating
      comment: "Overall performance rating (Exceeds, Meets, Below Expectations) — primary performance distribution dimension."
    - name: "review_cycle_type"
      expr: review_cycle_type
      comment: "Review cycle type (Annual, Mid-Year, Probation) — used to segment performance data by review type."
    - name: "staff_category"
      expr: staff_category
      comment: "Staff category — enables performance analysis by employment category."
    - name: "duty_station_country_code"
      expr: duty_station_country_code
      comment: "Country of duty station — used for country-level performance analysis."
    - name: "pip_required"
      expr: pip_required
      comment: "Flag indicating PIP is required — used to identify underperforming staff requiring intervention."
    - name: "promotion_recommendation"
      expr: promotion_recommendation
      comment: "Promotion recommendation flag — used for succession planning and talent pipeline analysis."
    - name: "retention_risk_flag"
      expr: retention_risk_flag
      comment: "Retention risk flag — identifies staff at risk of leaving, enabling proactive retention interventions."
    - name: "employee_disagreement_flag"
      expr: employee_disagreement_flag
      comment: "Flag for employee disagreement with review — high disagreement rates indicate management quality issues."
    - name: "review_period_year"
      expr: DATE_TRUNC('YEAR', review_period_start_date)
      comment: "Review period year — used for annual performance trend analysis."
  measures:
    - name: "total_completed_reviews"
      expr: COUNT(CASE WHEN review_status = 'Closed' THEN performance_review_id END)
      comment: "Total completed performance reviews. Primary review completion KPI — low completion rates indicate process compliance issues."
    - name: "total_reviews"
      expr: COUNT(performance_review_id)
      comment: "Total performance review records. Used as denominator for completion rate and PIP rate KPIs."
    - name: "avg_overall_rating_score"
      expr: AVG(CAST(overall_rating_score AS DOUBLE))
      comment: "Average overall performance rating score. Tracks organizational performance level — used in talent calibration and compensation decisions."
    - name: "avg_competency_rating_score"
      expr: AVG(CAST(competency_rating_score AS DOUBLE))
      comment: "Average competency rating score. Used for skills gap analysis and learning investment prioritization."
    - name: "avg_objective_achievement_score"
      expr: AVG(CAST(objective_achievement_score AS DOUBLE))
      comment: "Average objective achievement score. Measures organizational goal attainment — directly linked to program delivery effectiveness."
    - name: "pip_required_count"
      expr: COUNT(CASE WHEN pip_required = TRUE THEN performance_review_id END)
      comment: "Count of reviews requiring a Performance Improvement Plan. Elevated PIP rates signal organizational performance or management issues."
    - name: "promotion_recommended_count"
      expr: COUNT(CASE WHEN promotion_recommendation = TRUE THEN performance_review_id END)
      comment: "Count of staff recommended for promotion. Used for succession planning and career development investment decisions."
    - name: "retention_risk_count"
      expr: COUNT(CASE WHEN retention_risk_flag = TRUE THEN performance_review_id END)
      comment: "Count of staff flagged as retention risks. Triggers proactive retention interventions — high counts signal organizational health issues."
    - name: "employee_acknowledged_count"
      expr: COUNT(CASE WHEN employee_acknowledged = TRUE THEN performance_review_id END)
      comment: "Count of reviews acknowledged by the employee. Measures review process completion and employee engagement."
    - name: "employee_disagreement_count"
      expr: COUNT(CASE WHEN employee_disagreement_flag = TRUE THEN performance_review_id END)
      comment: "Count of reviews with employee disagreement. High disagreement rates indicate management quality or fairness concerns."
    - name: "avg_values_alignment_rating"
      expr: AVG(CAST(values_alignment_rating AS DOUBLE))
      comment: "Average values alignment rating score. Critical for INGOs — values alignment is a core competency and safeguarding indicator."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`workforce_recruitment_requisition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Recruitment pipeline and time-to-fill analytics. Tracks vacancy management, recruitment efficiency, and funding confirmation rates. Supports workforce planning, surge capacity management, and grant-funded position tracking. Relevant to Workday Recruiting and applicant tracking systems used by INGOs."
  source: "`vibe_ngo_v1`.`workforce`.`recruitment_requisition`"
  dimensions:
    - name: "requisition_status"
      expr: requisition_status
      comment: "Requisition status (Open, In Progress, Filled, Cancelled, On Hold) — primary pipeline status dimension."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status — used to filter to approved requisitions for active pipeline analysis."
    - name: "staff_category"
      expr: staff_category
      comment: "Staff category — enables recruitment analysis by employment category."
    - name: "duty_station_country_code"
      expr: duty_station_country_code
      comment: "Country of duty station — used for country-level recruitment pipeline analysis."
    - name: "employment_type"
      expr: employment_type
      comment: "Employment type — used to segment recruitment by contract modality."
    - name: "recruitment_type"
      expr: recruitment_type
      comment: "Recruitment type (Internal, External, Surge) — used for sourcing strategy analysis."
    - name: "funding_confirmed"
      expr: funding_confirmed
      comment: "Funding confirmation flag — unfunded open requisitions represent budget risk."
    - name: "is_emergency_surge"
      expr: is_emergency_surge
      comment: "Emergency surge flag — surge requisitions require expedited processing and are tracked separately."
    - name: "gender_marker"
      expr: gender_marker
      comment: "Gender marker on requisition — used for gender-targeted recruitment tracking and diversity reporting."
    - name: "opened_year"
      expr: DATE_TRUNC('YEAR', opened_date)
      comment: "Year requisition was opened — used for annual recruitment volume trend analysis."
  measures:
    - name: "total_open_requisitions"
      expr: COUNT(CASE WHEN requisition_status = 'Open' THEN recruitment_requisition_id END)
      comment: "Total open recruitment requisitions. Primary vacancy pipeline KPI — high open counts signal workforce capacity risk."
    - name: "total_requisitions"
      expr: COUNT(recruitment_requisition_id)
      comment: "Total recruitment requisitions. Used as denominator for fill rate and cancellation rate KPIs."
    - name: "total_filled_requisitions"
      expr: COUNT(CASE WHEN requisition_status = 'Filled' THEN recruitment_requisition_id END)
      comment: "Total filled requisitions. Used for fill rate calculation and recruitment effectiveness reporting."
    - name: "total_cancelled_requisitions"
      expr: COUNT(CASE WHEN requisition_status = 'Cancelled' THEN recruitment_requisition_id END)
      comment: "Count of cancelled requisitions. High cancellation rates indicate budget instability or organizational planning issues."
    - name: "total_budgeted_salary_cost"
      expr: SUM(CAST(budgeted_annual_salary AS DOUBLE))
      comment: "Total budgeted annual salary for open requisitions. Represents committed future payroll cost — used in budget forecasting."
    - name: "avg_budgeted_salary"
      expr: AVG(CAST(budgeted_annual_salary AS DOUBLE))
      comment: "Average budgeted salary per requisition. Used for compensation benchmarking and salary scale compliance."
    - name: "emergency_surge_requisition_count"
      expr: COUNT(CASE WHEN is_emergency_surge = TRUE THEN recruitment_requisition_id END)
      comment: "Count of emergency surge requisitions. Tracks emergency response staffing demand — used for surge capacity planning."
    - name: "unfunded_open_requisition_count"
      expr: COUNT(CASE WHEN funding_confirmed = FALSE AND requisition_status = 'Open' THEN recruitment_requisition_id END)
      comment: "Count of open requisitions without confirmed funding. Represents budget risk — triggers finance review and recruitment hold decisions."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`workforce_job_application`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Recruitment funnel and candidate quality analytics. Tracks application volumes, interview scores, offer acceptance rates, and safeguarding check completion. Supports diversity hiring analysis, recruitment quality improvement, and safeguarding compliance. Relevant to Workday Recruiting and applicant tracking systems."
  source: "`vibe_ngo_v1`.`workforce`.`job_application`"
  dimensions:
    - name: "application_status"
      expr: application_status
      comment: "Application status (Submitted, Screening, Interview, Offer, Hired, Rejected, Withdrawn) — primary funnel stage dimension."
    - name: "application_stage"
      expr: application_stage
      comment: "Current stage in recruitment pipeline — used for funnel conversion analysis."
    - name: "hiring_decision"
      expr: hiring_decision
      comment: "Final hiring decision (Hired, Rejected, Withdrawn) — used for offer acceptance and rejection analysis."
    - name: "staff_category"
      expr: staff_category
      comment: "Staff category of applied position — enables recruitment analysis by employment category."
    - name: "duty_station_country_code"
      expr: duty_station_country_code
      comment: "Country of duty station — used for country-level recruitment pipeline analysis."
    - name: "source_channel"
      expr: source_channel
      comment: "Recruitment source channel (Job Board, Referral, LinkedIn, Internal) — used for sourcing effectiveness analysis."
    - name: "gender_self_identified"
      expr: gender_self_identified
      comment: "Self-identified gender of applicant — used for diversity pipeline analysis and gender parity reporting."
    - name: "safeguarding_check_status"
      expr: safeguarding_check_status
      comment: "Safeguarding check status — mandatory compliance check; incomplete checks block hiring decisions."
    - name: "background_check_status"
      expr: background_check_status
      comment: "Background check status — used for compliance tracking and hiring decision gating."
    - name: "application_year"
      expr: DATE_TRUNC('YEAR', application_date)
      comment: "Year of application — used for annual recruitment volume trend analysis."
  measures:
    - name: "total_applications"
      expr: COUNT(job_application_id)
      comment: "Total job applications received. Primary recruitment volume KPI — used for sourcing effectiveness and pipeline sizing."
    - name: "total_hired"
      expr: COUNT(CASE WHEN hiring_decision = 'Hired' THEN job_application_id END)
      comment: "Total applicants hired. Used as numerator for offer acceptance rate and overall hire rate calculations."
    - name: "avg_interview_score"
      expr: AVG(CAST(interview_score AS DOUBLE))
      comment: "Average interview score across candidates. Used for candidate quality benchmarking and interview panel calibration."
    - name: "avg_screening_score"
      expr: AVG(CAST(screening_score AS DOUBLE))
      comment: "Average screening score. Used for screening criteria calibration and candidate quality analysis."
    - name: "avg_written_assessment_score"
      expr: AVG(CAST(written_assessment_score AS DOUBLE))
      comment: "Average written assessment score. Used for technical competency benchmarking across candidate pools."
    - name: "avg_proposed_salary"
      expr: AVG(CAST(proposed_salary AS DOUBLE))
      comment: "Average proposed salary for hired candidates. Used for compensation benchmarking and salary scale compliance."
    - name: "safeguarding_check_incomplete_count"
      expr: COUNT(CASE WHEN safeguarding_check_status NOT IN ('Cleared', 'Completed') AND hiring_decision = 'Hired' THEN job_application_id END)
      comment: "Count of hired staff with incomplete safeguarding checks. Critical compliance KPI — any non-zero value triggers immediate HR and safeguarding review."
    - name: "avg_years_of_experience"
      expr: AVG(CAST(years_of_experience AS DOUBLE))
      comment: "Average years of experience of applicants. Used for candidate pool quality assessment and job profile calibration."
    - name: "total_applications_with_offer"
      expr: COUNT(CASE WHEN offer_extended_date IS NOT NULL THEN job_application_id END)
      comment: "Count of applications that received an offer. Used as denominator for offer acceptance rate calculation."
    - name: "total_offers_accepted"
      expr: COUNT(CASE WHEN offer_accepted_date IS NOT NULL THEN job_application_id END)
      comment: "Count of offers accepted. Used as numerator for offer acceptance rate — low acceptance rates signal compensation or role attractiveness issues."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`workforce_timesheet`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Staff time and effort analytics. Tracks billable hours, overtime, and effort certification compliance. Critical for grant effort reporting, NICRA compliance, and OMB Uniform Guidance 2 CFR 200 effort certification requirements. Relevant to SAP CATS, Workday Time Tracking, and ICON financial systems."
  source: "`vibe_ngo_v1`.`workforce`.`timesheet`"
  dimensions:
    - name: "timesheet_status"
      expr: timesheet_status
      comment: "Timesheet status (Draft, Submitted, Approved, Rejected) — used to filter to approved timesheets for effort reporting."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status — used to identify unapproved timesheets that may affect grant effort certification."
    - name: "program_code"
      expr: program_code
      comment: "Program code — enables effort analysis by program for grant reporting."
    - name: "work_location"
      expr: work_location
      comment: "Work location — used for field vs. HQ effort analysis."
    - name: "is_overtime"
      expr: is_overtime
      comment: "Overtime flag — overtime hours carry additional cost and may require prior approval under grant rules."
    - name: "effort_certification_flag"
      expr: effort_certification_flag
      comment: "Effort certification flag — certified effort is required for grant compliance under 2 CFR 200."
    - name: "period_month"
      expr: DATE_TRUNC('MONTH', period_start_date)
      comment: "Timesheet period month — used for monthly effort trend analysis."
  measures:
    - name: "total_hours_worked"
      expr: SUM(CAST(total_hours AS DOUBLE))
      comment: "Total hours worked across all timesheets. Primary effort volume KPI used in grant effort reporting and workforce capacity analysis."
    - name: "total_billable_hours"
      expr: SUM(CAST(billable_hours AS DOUBLE))
      comment: "Total billable hours charged to grants/programs. Core grant effort KPI — used in donor financial reports and effort certification."
    - name: "total_non_billable_hours"
      expr: SUM(CAST(non_billable_hours AS DOUBLE))
      comment: "Total non-billable hours. Used for indirect cost analysis and NICRA rate calculations."
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours. Elevated overtime signals workforce capacity issues and may trigger grant prior approval requirements."
    - name: "avg_total_hours_per_timesheet"
      expr: AVG(CAST(total_hours AS DOUBLE))
      comment: "Average total hours per timesheet. Used for workforce utilization benchmarking and anomaly detection."
    - name: "effort_certified_timesheet_count"
      expr: COUNT(CASE WHEN effort_certification_flag = TRUE THEN timesheet_id END)
      comment: "Count of effort-certified timesheets. Effort certification compliance is mandatory for grant-funded positions under 2 CFR 200."
    - name: "total_timesheets"
      expr: COUNT(timesheet_id)
      comment: "Total timesheet records. Used as denominator for effort certification rate and approval rate KPIs."
    - name: "approved_timesheet_count"
      expr: COUNT(CASE WHEN approval_status = 'Approved' THEN timesheet_id END)
      comment: "Count of approved timesheets. Unapproved timesheets cannot be used for grant effort reporting — low approval rates are a compliance risk."
    - name: "overtime_timesheet_count"
      expr: COUNT(CASE WHEN is_overtime = TRUE THEN timesheet_id END)
      comment: "Count of timesheets with overtime. Used for overtime frequency analysis and workforce capacity planning."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`workforce_staff_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Staff deployment and assignment analytics. Tracks effort allocation, field deployments, surge assignments, and cost-sharing arrangements. Critical for grant effort allocation reporting, field capacity planning, and donor staffing schedule compliance. Relevant to Workday, SAP, and eTools project management systems."
  source: "`vibe_ngo_v1`.`workforce`.`workforce_staff_assignment`"
  dimensions:
    - name: "assignment_status"
      expr: assignment_status
      comment: "Assignment status (Active, Completed, Cancelled, On Hold) — primary filter for active deployment analysis."
    - name: "assignment_type"
      expr: assignment_type
      comment: "Assignment type (Primary, Secondary, TDY, Surge) — used to segment deployment by modality."
    - name: "staff_category"
      expr: staff_category
      comment: "Staff category — enables assignment analysis by employment category."
    - name: "duty_country_code"
      expr: duty_country_code
      comment: "Country of assignment — used for country-level deployment analysis."
    - name: "funding_source_type"
      expr: funding_source_type
      comment: "Funding source type (Grant, Core, Cost-Share) — enables grant-funded vs. core-funded assignment split."
    - name: "is_field_deployment"
      expr: is_field_deployment
      comment: "Field deployment flag — used for field vs. HQ assignment analysis."
    - name: "is_surge_deployment"
      expr: is_surge_deployment
      comment: "Surge deployment flag — surge deployments are tracked separately for emergency response capacity reporting."
    - name: "is_cost_shared"
      expr: is_cost_shared
      comment: "Cost-sharing flag — cost-shared positions require separate tracking for grant compliance."
    - name: "effort_certification_required"
      expr: effort_certification_required
      comment: "Effort certification requirement flag — grant-funded positions require effort certification under 2 CFR 200."
    - name: "raci_role"
      expr: raci_role
      comment: "RACI role on assignment — used for accountability and responsibility analysis."
    - name: "assignment_start_year"
      expr: DATE_TRUNC('YEAR', start_date)
      comment: "Year assignment started — used for annual deployment trend analysis."
  measures:
    - name: "total_active_assignments"
      expr: COUNT(CASE WHEN assignment_status = 'Active' THEN workforce_staff_assignment_id END)
      comment: "Total active staff assignments. Primary deployment capacity KPI used in field operations and grant staffing schedule reporting."
    - name: "total_assignments"
      expr: COUNT(workforce_staff_assignment_id)
      comment: "Total staff assignment records. Used as denominator for field deployment rate and surge rate KPIs."
    - name: "total_effort_percent"
      expr: SUM(CAST(effort_percent AS DOUBLE))
      comment: "Total effort percentage allocated across assignments. Used for grant effort allocation reporting and over-allocation detection."
    - name: "avg_effort_percent"
      expr: AVG(CAST(effort_percent AS DOUBLE))
      comment: "Average effort percentage per assignment. Used for workforce utilization analysis and grant budget planning."
    - name: "total_fte_equivalent"
      expr: SUM(CAST(fte_equivalent AS DOUBLE))
      comment: "Total FTE equivalent across assignments. Core workforce capacity KPI used in grant staffing schedules and donor reports."
    - name: "field_deployment_count"
      expr: COUNT(CASE WHEN is_field_deployment = TRUE THEN workforce_staff_assignment_id END)
      comment: "Count of field deployments. Used for field capacity analysis and field vs. HQ staffing ratio reporting."
    - name: "surge_deployment_count"
      expr: COUNT(CASE WHEN is_surge_deployment = TRUE THEN workforce_staff_assignment_id END)
      comment: "Count of surge deployments. Tracks emergency response staffing capacity — used in humanitarian response reporting."
    - name: "cost_shared_assignment_count"
      expr: COUNT(CASE WHEN is_cost_shared = TRUE THEN workforce_staff_assignment_id END)
      comment: "Count of cost-shared assignments. Cost-sharing arrangements require separate tracking for grant compliance and donor reporting."
    - name: "effort_certification_required_count"
      expr: COUNT(CASE WHEN effort_certification_required = TRUE THEN workforce_staff_assignment_id END)
      comment: "Count of assignments requiring effort certification. Used to scope effort certification compliance workload for grant-funded positions."
    - name: "safeguarding_training_completed_count"
      expr: COUNT(CASE WHEN safeguarding_training_completed = TRUE THEN workforce_staff_assignment_id END)
      comment: "Count of assignments where safeguarding training is completed. Safeguarding training compliance is mandatory for all field deployments."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`workforce_separation_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Staff attrition and separation analytics. Tracks separation types, financial settlements, clearance completion, and repatriation. Supports attrition analysis, exit process compliance, and financial liability reporting. Relevant to Workday HCM and SAP HR separation management modules."
  source: "`vibe_ngo_v1`.`workforce`.`separation_event`"
  dimensions:
    - name: "separation_type"
      expr: separation_type
      comment: "Type of separation (Resignation, End of Contract, Termination, Retirement) — primary attrition analysis dimension."
    - name: "separation_reason"
      expr: separation_reason
      comment: "Reason for separation — used for root cause analysis of attrition patterns."
    - name: "staff_category"
      expr: staff_category
      comment: "Staff category — enables attrition analysis by employment category."
    - name: "duty_station_country_code"
      expr: duty_station_country_code
      comment: "Country of duty station — used for country-level attrition analysis."
    - name: "is_involuntary"
      expr: is_involuntary
      comment: "Involuntary separation flag — involuntary separations carry higher legal and reputational risk."
    - name: "clearance_status"
      expr: clearance_status
      comment: "Exit clearance status — incomplete clearances represent compliance and asset recovery risk."
    - name: "repatriation_required"
      expr: repatriation_required
      comment: "Repatriation requirement flag — repatriation carries significant cost and logistical complexity."
    - name: "rehire_eligible"
      expr: rehire_eligible
      comment: "Rehire eligibility flag — used for talent pipeline and surge capacity planning."
    - name: "separation_year"
      expr: DATE_TRUNC('YEAR', effective_date)
      comment: "Year of separation — used for annual attrition trend analysis."
  measures:
    - name: "total_separations"
      expr: COUNT(separation_event_id)
      comment: "Total staff separations. Primary attrition volume KPI used in workforce planning and organizational health reporting."
    - name: "involuntary_separation_count"
      expr: COUNT(CASE WHEN is_involuntary = TRUE THEN separation_event_id END)
      comment: "Count of involuntary separations. Elevated involuntary separation rates signal organizational or management issues and carry legal risk."
    - name: "total_final_settlement_amount"
      expr: SUM(CAST(final_settlement_amount AS DOUBLE))
      comment: "Total final settlement amounts paid. Key financial liability KPI — used in budget planning and grant closeout financial reporting."
    - name: "avg_final_settlement_amount"
      expr: AVG(CAST(final_settlement_amount AS DOUBLE))
      comment: "Average final settlement per separation. Used for separation cost benchmarking and budget forecasting."
    - name: "total_severance_amount"
      expr: SUM(CAST(severance_amount AS DOUBLE))
      comment: "Total severance paid. Significant financial liability — tracked for budget management and grant compliance."
    - name: "total_leave_encashment_amount"
      expr: SUM(CAST(leave_encashment_amount AS DOUBLE))
      comment: "Total leave encashment paid on separation. Represents accrued leave liability converted to cash — tracked for financial planning."
    - name: "total_leave_encashment_days"
      expr: SUM(CAST(leave_encashment_days AS DOUBLE))
      comment: "Total leave days encashed on separation. Used for leave liability analysis and leave management policy effectiveness."
    - name: "total_repatriation_grant_amount"
      expr: SUM(CAST(repatriation_grant_amount AS DOUBLE))
      comment: "Total repatriation grants paid. Significant expat separation cost — tracked for budget planning and grant compliance."
    - name: "exit_interview_completed_count"
      expr: COUNT(CASE WHEN exit_interview_completed = TRUE THEN separation_event_id END)
      comment: "Count of separations with completed exit interviews. Exit interview completion rate measures HR process quality and attrition data capture."
    - name: "clearance_completed_count"
      expr: COUNT(CASE WHEN clearance_status = 'Completed' THEN separation_event_id END)
      comment: "Count of separations with completed clearance. Incomplete clearances represent asset recovery and access security risks."
    - name: "rehire_eligible_count"
      expr: COUNT(CASE WHEN rehire_eligible = TRUE THEN separation_event_id END)
      comment: "Count of separated staff eligible for rehire. Informs talent pipeline and surge capacity planning."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`workforce_learning_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Staff learning and development analytics. Tracks training completion rates, certification attainment, mandatory training compliance, and learning investment. Supports safeguarding training compliance, donor capacity building reporting, and organizational capability development. Relevant to Workday Learning, Cornerstone, and DHIS2 training tracking systems."
  source: "`vibe_ngo_v1`.`workforce`.`learning_enrollment`"
  dimensions:
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Enrollment status (Enrolled, In Progress, Completed, Failed, Withdrawn) — primary completion analysis dimension."
    - name: "course_category"
      expr: course_category
      comment: "Course category (Safeguarding, Technical, Leadership, Compliance) — enables training investment analysis by category."
    - name: "delivery_mode"
      expr: delivery_mode
      comment: "Delivery mode (Online, In-Person, Blended) — used for learning modality effectiveness analysis."
    - name: "is_mandatory"
      expr: is_mandatory
      comment: "Mandatory training flag — mandatory training compliance is tracked separately for donor and regulatory reporting."
    - name: "is_certified"
      expr: is_certified
      comment: "Certification attainment flag — used for certification rate analysis."
    - name: "pass_fail_status"
      expr: pass_fail_status
      comment: "Pass/fail outcome — used for training effectiveness and quality analysis."
    - name: "staff_type"
      expr: staff_type
      comment: "Staff type — enables training analysis by employment category."
    - name: "country_code"
      expr: country_code
      comment: "Country of enrollment — used for country-level training compliance analysis."
    - name: "provider_type"
      expr: provider_type
      comment: "Training provider type (Internal, External, UN Agency) — used for provider effectiveness and cost analysis."
    - name: "enrollment_year"
      expr: DATE_TRUNC('YEAR', enrollment_date)
      comment: "Year of enrollment — used for annual training volume trend analysis."
  measures:
    - name: "total_enrollments"
      expr: COUNT(learning_enrollment_id)
      comment: "Total learning enrollments. Primary training volume KPI used in capacity building and donor reporting."
    - name: "total_completed_enrollments"
      expr: COUNT(CASE WHEN enrollment_status = 'Completed' THEN learning_enrollment_id END)
      comment: "Total completed training enrollments. Used as numerator for completion rate — core training effectiveness KPI."
    - name: "mandatory_training_completed_count"
      expr: COUNT(CASE WHEN is_mandatory = TRUE AND enrollment_status = 'Completed' THEN learning_enrollment_id END)
      comment: "Count of completed mandatory training enrollments. Mandatory training compliance is required for donor reporting and safeguarding standards."
    - name: "mandatory_training_total_count"
      expr: COUNT(CASE WHEN is_mandatory = TRUE THEN learning_enrollment_id END)
      comment: "Total mandatory training enrollments. Used as denominator for mandatory training completion rate."
    - name: "total_training_cost"
      expr: SUM(CAST(training_cost AS DOUBLE))
      comment: "Total training investment cost. Used for learning budget management and cost-per-learner analysis."
    - name: "avg_training_cost_per_enrollment"
      expr: AVG(CAST(training_cost AS DOUBLE))
      comment: "Average training cost per enrollment. Used for learning investment efficiency analysis and budget planning."
    - name: "total_hours_completed"
      expr: SUM(CAST(actual_hours_spent AS DOUBLE))
      comment: "Total learning hours completed. Used for capacity building reporting and donor training deliverable tracking."
    - name: "avg_score"
      expr: AVG(CAST(score AS DOUBLE))
      comment: "Average assessment score across enrollments. Used for training effectiveness analysis and curriculum quality improvement."
    - name: "certified_count"
      expr: COUNT(CASE WHEN is_certified = TRUE THEN learning_enrollment_id END)
      comment: "Count of enrollments resulting in certification. Used for certification attainment rate and professional development reporting."
    - name: "failed_enrollment_count"
      expr: COUNT(CASE WHEN pass_fail_status = 'Fail' THEN learning_enrollment_id END)
      comment: "Count of failed training enrollments. High failure rates indicate training quality or prerequisite issues requiring curriculum review."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`workforce_expat_package`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Expatriate compensation package analytics. Tracks total package costs, allowance components, and hardship classifications. Critical for expat cost management, localization strategy decisions, and grant budget compliance. Relevant to Workday Compensation and SAP HR expat management modules used by INGOs."
  source: "`vibe_ngo_v1`.`workforce`.`expat_package`"
  dimensions:
    - name: "package_status"
      expr: package_status
      comment: "Package status (Active, Expired, Pending) — used to filter to active expat packages for cost analysis."
    - name: "package_type"
      expr: package_type
      comment: "Package type (Standard, Hardship, Emergency) — used for package cost analysis by type."
    - name: "assignment_country_code"
      expr: assignment_country_code
      comment: "Country of assignment — enables country-level expat cost analysis."
    - name: "home_country_code"
      expr: home_country_code
      comment: "Home country of expat — used for nationality-based cost analysis."
    - name: "hardship_classification"
      expr: hardship_classification
      comment: "Hardship classification (A, B, C, D, E) — drives hardship allowance levels and is a key cost driver."
    - name: "currency_code"
      expr: currency_code
      comment: "Package currency — required for multi-currency cost consolidation."
    - name: "effective_start_year"
      expr: DATE_TRUNC('YEAR', effective_start_date)
      comment: "Year package became effective — used for annual expat cost trend analysis."
  measures:
    - name: "total_package_cost_usd"
      expr: SUM(CAST(total_package_cost_usd AS DOUBLE))
      comment: "Total expat package cost in USD. Primary expat cost KPI used in budget planning, localization strategy, and grant compliance."
    - name: "avg_package_cost_usd"
      expr: AVG(CAST(total_package_cost_usd AS DOUBLE))
      comment: "Average expat package cost per assignment. Used for cost benchmarking and localization ROI analysis."
    - name: "total_hardship_allowance"
      expr: SUM(CAST(hardship_allowance_amount AS DOUBLE))
      comment: "Total hardship allowance paid. Field deployment cost premium — used for duty station risk/cost analysis."
    - name: "total_housing_allowance"
      expr: SUM(CAST(housing_allowance_amount AS DOUBLE))
      comment: "Total housing allowance paid. Largest expat cost component — tracked for budget management and grant compliance."
    - name: "total_education_allowance"
      expr: SUM(CAST(education_allowance_amount AS DOUBLE))
      comment: "Total education allowance paid. Significant expat benefit cost tracked for grant compliance."
    - name: "total_mobility_premium"
      expr: SUM(CAST(mobility_premium_amount AS DOUBLE))
      comment: "Total mobility premium paid. Incentive cost for accepting difficult assignments — tracked for compensation strategy analysis."
    - name: "total_danger_pay"
      expr: SUM(CAST(danger_pay_amount AS DOUBLE))
      comment: "Total danger pay paid. Security-related cost tracked for high-risk duty station analysis and budget planning."
    - name: "total_rnr_travel_allowance"
      expr: SUM(CAST(rnr_travel_allowance_amount AS DOUBLE))
      comment: "Total R&R travel allowance paid. Mandatory field staff welfare cost — tracked for compliance and budget management."
    - name: "total_repatriation_grant"
      expr: SUM(CAST(repatriation_grant_amount AS DOUBLE))
      comment: "Total repatriation grants accrued. End-of-assignment liability — tracked for financial planning and grant compliance."
    - name: "total_relocation_allowance"
      expr: SUM(CAST(relocation_allowance_amount AS DOUBLE))
      comment: "Total relocation allowances paid. One-time assignment cost tracked for budget planning and grant prior approval compliance."
    - name: "active_expat_package_count"
      expr: COUNT(CASE WHEN package_status = 'Active' THEN expat_package_id END)
      comment: "Count of active expat packages. Primary expat headcount KPI used in localization strategy and budget planning."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`workforce_disciplinary_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Disciplinary case and misconduct analytics. Tracks case volumes, outcomes, PSEA-related cases, and process timeliness. Critical for organizational accountability, safeguarding compliance, and donor reporting on misconduct management. Relevant to Primero case management and HR disciplinary tracking systems used by INGOs."
  source: "`vibe_ngo_v1`.`workforce`.`disciplinary_case`"
  dimensions:
    - name: "case_status"
      expr: case_status
      comment: "Case status (Open, Under Investigation, Closed, Appealed) — primary case pipeline dimension."
    - name: "misconduct_type"
      expr: misconduct_type
      comment: "Type of misconduct (PSEA, Fraud, Harassment, Abuse of Authority) — used for misconduct pattern analysis."
    - name: "allegation_category"
      expr: allegation_category
      comment: "Allegation category — used for case classification and trend analysis."
    - name: "decision_outcome"
      expr: decision_outcome
      comment: "Decision outcome (Substantiated, Unsubstantiated, Inconclusive) — used for case resolution analysis."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level (Low, Medium, High, Critical) — used for risk prioritization and escalation analysis."
    - name: "is_psea_related"
      expr: is_psea_related
      comment: "PSEA-related flag — PSEA cases require mandatory donor reporting and are tracked with highest priority."
    - name: "staff_category"
      expr: staff_category
      comment: "Staff category of subject — used for misconduct pattern analysis by employment category."
    - name: "duty_station_country_code"
      expr: duty_station_country_code
      comment: "Country of duty station — used for country-level misconduct analysis."
    - name: "confidentiality_level"
      expr: confidentiality_level
      comment: "Confidentiality level — used for access control and reporting scope management."
    - name: "case_opened_year"
      expr: DATE_TRUNC('YEAR', case_opened_date)
      comment: "Year case was opened — used for annual misconduct trend analysis."
  measures:
    - name: "total_open_cases"
      expr: COUNT(CASE WHEN case_status = 'Open' THEN disciplinary_case_id END)
      comment: "Total open disciplinary cases. Primary case pipeline KPI — high open case counts signal accountability process bottlenecks."
    - name: "total_cases"
      expr: COUNT(disciplinary_case_id)
      comment: "Total disciplinary cases. Used as denominator for substantiation rate and PSEA rate KPIs."
    - name: "psea_case_count"
      expr: COUNT(CASE WHEN is_psea_related = TRUE THEN disciplinary_case_id END)
      comment: "Count of PSEA-related disciplinary cases. PSEA cases require mandatory donor reporting — any increase triggers immediate leadership review."
    - name: "substantiated_case_count"
      expr: COUNT(CASE WHEN decision_outcome = 'Substantiated' THEN disciplinary_case_id END)
      comment: "Count of substantiated cases. Used for misconduct accountability reporting and organizational risk assessment."
    - name: "legal_counsel_engaged_count"
      expr: COUNT(CASE WHEN legal_counsel_engaged = TRUE THEN disciplinary_case_id END)
      comment: "Count of cases with legal counsel engaged. Indicates high-severity cases with legal risk — tracked for organizational liability management."
    - name: "appeal_submitted_count"
      expr: COUNT(CASE WHEN appeal_submitted_date IS NOT NULL THEN disciplinary_case_id END)
      comment: "Count of cases with appeals submitted. High appeal rates may indicate process fairness issues."
    - name: "union_representative_present_count"
      expr: COUNT(CASE WHEN union_representative_present = TRUE THEN disciplinary_case_id END)
      comment: "Count of cases with union representation. Used for labor relations analysis and process compliance tracking."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`workforce_position`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Position management and vacancy analytics. Tracks authorized positions, vacancy rates, budgeted costs, and FTE allocation. Supports workforce planning, grant staffing schedule compliance, and organizational design decisions. Relevant to Workday HCM position management and SAP Organizational Management modules."
  source: "`vibe_ngo_v1`.`workforce`.`position`"
  dimensions:
    - name: "position_status"
      expr: position_status
      comment: "Position status (Active, Frozen, Abolished) — used to filter to active authorized positions."
    - name: "position_type"
      expr: position_type
      comment: "Position type (Permanent, Fixed-Term, Surge) — used for workforce planning analysis."
    - name: "staff_category"
      expr: staff_category
      comment: "Staff category — enables position analysis by employment category."
    - name: "duty_station_country_code"
      expr: duty_station_country_code
      comment: "Country of duty station — used for country-level position analysis."
    - name: "is_vacant"
      expr: is_vacant
      comment: "Vacancy flag — vacant positions represent workforce capacity gaps and budget risk."
    - name: "is_field_position"
      expr: is_field_position
      comment: "Field position flag — used for field vs. HQ position analysis."
    - name: "is_supervisory"
      expr: is_supervisory
      comment: "Supervisory position flag — used for management span of control analysis."
    - name: "funding_source_type"
      expr: funding_source_type
      comment: "Funding source type — enables grant-funded vs. core-funded position split."
    - name: "pay_grade_band"
      expr: pay_grade_band
      comment: "Pay grade band — used for compensation structure analysis."
    - name: "icr_applicable"
      expr: icr_applicable
      comment: "ICR applicability flag — positions subject to indirect cost recovery are tracked for NICRA compliance."
  measures:
    - name: "total_authorized_positions"
      expr: COUNT(CASE WHEN position_status = 'Active' THEN position_id END)
      comment: "Total authorized positions. Primary workforce capacity KPI used in organizational design and grant staffing schedule reporting."
    - name: "total_vacant_positions"
      expr: COUNT(CASE WHEN is_vacant = TRUE THEN position_id END)
      comment: "Total vacant positions. Vacancy count is a critical workforce capacity risk indicator — high vacancy rates affect program delivery."
    - name: "total_budgeted_annual_cost"
      expr: SUM(CAST(budgeted_annual_cost AS DOUBLE))
      comment: "Total budgeted annual cost across all positions. Core workforce budget KPI used in grant budget planning and donor financial reports."
    - name: "avg_budgeted_annual_cost"
      expr: AVG(CAST(budgeted_annual_cost AS DOUBLE))
      comment: "Average budgeted annual cost per position. Used for compensation benchmarking and budget planning."
    - name: "total_fte_allocation"
      expr: SUM(CAST(fte_allocation AS DOUBLE))
      comment: "Total FTE allocation across positions. Used for workforce capacity planning and grant effort allocation reporting."
    - name: "avg_fte_allocation"
      expr: AVG(CAST(fte_allocation AS DOUBLE))
      comment: "Average FTE allocation per position. Used for part-time position analysis and workforce planning."
    - name: "field_position_count"
      expr: COUNT(CASE WHEN is_field_position = TRUE THEN position_id END)
      comment: "Count of field positions. Used for field vs. HQ staffing ratio analysis and field capacity planning."
    - name: "supervisory_position_count"
      expr: COUNT(CASE WHEN is_supervisory = TRUE THEN position_id END)
      comment: "Count of supervisory positions. Used for management span of control analysis and organizational design decisions."
    - name: "total_max_salary_budget"
      expr: SUM(CAST(max_salary AS DOUBLE))
      comment: "Total maximum salary budget across positions. Used for worst-case payroll cost scenario planning."
$$;