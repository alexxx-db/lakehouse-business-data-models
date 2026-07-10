-- Metric views for domain: insurance | Business: Healthcare | Version: 2 | Generated on: 2026-07-10 14:53:25

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`insurance_capitation_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Value-based capitation payment performance: gross vs net payments, quality withholds, and risk-adjusted amounts for VBC settlement oversight."
  source: "`vibe_healthcare_v1`.`insurance`.`capitation_payment`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Lifecycle status of the capitation payment (e.g. pending, paid, reconciled) for AR aging views."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Whether the capitation payment has been reconciled against contract terms."
    - name: "payment_period_year"
      expr: payment_period_year
      comment: "Contract year the capitation payment applies to, for trending."
    - name: "payment_month"
      expr: DATE_TRUNC('MONTH', payment_due_date)
      comment: "Month bucket of payment due date for time-series analysis."
  measures:
    - name: "Payment Count"
      expr: COUNT(1)
      comment: "Number of capitation payment records — baseline volume."
    - name: "Total Gross Capitation"
      expr: SUM(CAST(gross_capitation_amount AS DOUBLE))
      comment: "Total gross capitation dollars, the top-line PMPM obligation."
    - name: "Total Net Payment"
      expr: SUM(CAST(net_payment_amount AS DOUBLE))
      comment: "Total net dollars actually paid after adjustments and withholds."
    - name: "Total Quality Withhold"
      expr: SUM(CAST(quality_withhold_amount AS DOUBLE))
      comment: "Total dollars withheld pending quality performance — at-risk revenue."
    - name: "Total Adjustment Amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total retroactive adjustments to capitation, indicating reconciliation churn."
    - name: "Avg PMPM Rate"
      expr: AVG(CAST(pmpm_rate AS DOUBLE))
      comment: "Average per-member-per-month rate across payments, benchmark for contract negotiation."
    - name: "Avg Risk Adjustment Factor"
      expr: AVG(CAST(risk_adjustment_factor AS DOUBLE))
      comment: "Average risk score factor applied, driving expected acuity-based revenue."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`insurance_vbc_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Value-based care contract settlement outcomes: shared savings/loss, total cost of care vs benchmark, and quality performance for executive VBC steering."
  source: "`vibe_healthcare_v1`.`insurance`.`vbc_performance`"
  dimensions:
    - name: "settlement_status"
      expr: settlement_status
      comment: "Settlement lifecycle status for tracking VBC reconciliation progress."
    - name: "risk_arrangement_type"
      expr: risk_arrangement_type
      comment: "Upside-only vs two-sided risk arrangement, key to VBC portfolio strategy."
    - name: "measurement_year"
      expr: measurement_year
      comment: "Performance measurement year for year-over-year VBC trending."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Whether the settlement is under dispute — flags reconciliation risk."
  measures:
    - name: "Performance Record Count"
      expr: COUNT(1)
      comment: "Number of VBC performance records — baseline."
    - name: "Total Savings/Loss"
      expr: SUM(CAST(savings_loss_amount AS DOUBLE))
      comment: "Net shared savings (positive) or loss (negative) — the core VBC financial outcome."
    - name: "Total Cost of Care"
      expr: SUM(CAST(total_cost_of_care_amount AS DOUBLE))
      comment: "Total actual cost of care for attributed populations."
    - name: "Total Benchmark TCOC"
      expr: SUM(CAST(benchmark_tcoc_amount AS DOUBLE))
      comment: "Total benchmark total cost of care target — comparison baseline for savings."
    - name: "Total Shared Savings Distribution"
      expr: SUM(CAST(shared_savings_distribution_amount AS DOUBLE))
      comment: "Dollars distributed to providers from shared savings."
    - name: "Total Quality Withhold Earned"
      expr: SUM(CAST(quality_withhold_earned_amount AS DOUBLE))
      comment: "Quality withhold dollars earned back through performance."
    - name: "Total Quality Withhold Forfeited"
      expr: SUM(CAST(quality_withhold_forfeited_amount AS DOUBLE))
      comment: "Quality withhold dollars forfeited due to missed targets — lost revenue."
    - name: "Avg Quality Score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average quality score across contracts, driver of withhold recovery."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`insurance_premium_billing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Premium billing and collections health: total premium billed, outstanding balances, delinquency, and employer/employee contribution split for revenue cycle steering."
  source: "`vibe_healthcare_v1`.`insurance`.`premium_billing`"
  dimensions:
    - name: "billing_status"
      expr: billing_status
      comment: "Billing lifecycle status (invoiced, paid, delinquent) for AR management."
    - name: "billing_type"
      expr: billing_type
      comment: "Type of premium billing (group, individual, COBRA) for segmentation."
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "Billing cadence for cash-flow forecasting."
    - name: "billing_month"
      expr: DATE_TRUNC('MONTH', billing_due_date)
      comment: "Month bucket of billing due date for time-series."
  measures:
    - name: "Billing Record Count"
      expr: COUNT(1)
      comment: "Number of premium billing records — baseline volume."
    - name: "Total Premium Billed"
      expr: SUM(CAST(total_premium_amount AS DOUBLE))
      comment: "Total premium dollars billed — top-line premium revenue."
    - name: "Total Net Premium Due"
      expr: SUM(CAST(net_premium_due AS DOUBLE))
      comment: "Total net premium due after subsidies and adjustments."
    - name: "Total Outstanding Balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total unpaid premium balance — collections exposure."
    - name: "Total Payment Received"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total premium payments collected."
    - name: "Total Employer Contribution"
      expr: SUM(CAST(employer_contribution_amount AS DOUBLE))
      comment: "Total employer-funded premium contributions."
    - name: "Total Employee Contribution"
      expr: SUM(CAST(employee_contribution_amount AS DOUBLE))
      comment: "Total employee-funded premium contributions."
    - name: "Total Subsidy Amount"
      expr: SUM(CAST(subsidy_amount AS DOUBLE))
      comment: "Total premium subsidies (ACA/APTC) applied."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`insurance_risk_adjustment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Risk adjustment revenue and HCC capture: risk scores, payment impact, RADV audit exposure, and recapture rates for actuarial and revenue-integrity steering."
  source: "`vibe_healthcare_v1`.`insurance`.`risk_adjustment`"
  dimensions:
    - name: "submission_status"
      expr: submission_status
      comment: "Status of the risk-adjustment submission to CMS/payer."
    - name: "radv_audit_status"
      expr: radv_audit_status
      comment: "RADV audit status — flags compliance and clawback exposure."
    - name: "payment_year"
      expr: payment_year
      comment: "Payment year for risk-adjustment revenue trending."
    - name: "recapture_flag"
      expr: recapture_flag
      comment: "Whether the HCC was recaptured in the current year — key gap-closure metric."
    - name: "suspect_flag"
      expr: suspect_flag
      comment: "Whether the condition is a suspect (unconfirmed) HCC for chart-chase prioritization."
  measures:
    - name: "Risk Adjustment Record Count"
      expr: COUNT(1)
      comment: "Number of risk-adjustment records — baseline volume."
    - name: "Avg Risk Score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average member risk score, the primary driver of risk-adjusted revenue."
    - name: "Avg Disease Score"
      expr: AVG(CAST(disease_score AS DOUBLE))
      comment: "Average disease component of the risk score for acuity analysis."
    - name: "Total Payment Impact"
      expr: SUM(CAST(payment_impact_amount AS DOUBLE))
      comment: "Total dollar impact of risk adjustment on payments — revenue at stake."
    - name: "Total Payment Amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total risk-adjusted payment dollars."
    - name: "Distinct Members"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct members with risk-adjustment records — population coverage."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`insurance_utilization_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Utilization management performance: review volumes, denial rates, appeal activity, and turnaround-time compliance for UM operations steering."
  source: "`vibe_healthcare_v1`.`insurance`.`utilization_review`"
  dimensions:
    - name: "review_status"
      expr: review_status
      comment: "Status of the utilization review for pipeline management."
    - name: "review_type"
      expr: review_type
      comment: "Prospective/concurrent/retrospective review type for UM segmentation."
    - name: "review_decision"
      expr: review_decision
      comment: "Approval/denial decision, the core UM outcome dimension."
    - name: "regulatory_timeframe_met"
      expr: regulatory_timeframe_met
      comment: "Whether the review met regulatory turnaround requirements — compliance flag."
    - name: "review_month"
      expr: DATE_TRUNC('MONTH', review_completion_date)
      comment: "Month bucket of review completion for trending."
  measures:
    - name: "Review Count"
      expr: COUNT(1)
      comment: "Total utilization reviews performed — baseline UM volume."
    - name: "Denied Review Count"
      expr: COUNT(CASE WHEN denial_reason_code IS NOT NULL THEN 1 END)
      comment: "Count of reviews resulting in a denial — drives appeal and member impact analysis."
    - name: "Appeal Filed Count"
      expr: COUNT(CASE WHEN appeal_filed = TRUE THEN 1 END)
      comment: "Count of reviews where an appeal was filed — downstream workload driver."
    - name: "Timeframe Met Count"
      expr: COUNT(CASE WHEN regulatory_timeframe_met = TRUE THEN 1 END)
      comment: "Reviews meeting regulatory turnaround — numerator for compliance rate."
    - name: "Avg Turnaround Hours"
      expr: AVG(CAST(turnaround_time_hours AS DOUBLE))
      comment: "Average review turnaround in hours — UM efficiency and compliance metric."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`insurance_network_adequacy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Network adequacy compliance: access standards, provider-to-member ratios, and deficiency tracking for regulatory network-adequacy steering."
  source: "`vibe_healthcare_v1`.`insurance`.`network_adequacy`"
  dimensions:
    - name: "adequacy_determination"
      expr: adequacy_determination
      comment: "Whether the network was determined adequate — core regulatory outcome."
    - name: "assessment_status"
      expr: assessment_status
      comment: "Status of the adequacy assessment for workflow tracking."
    - name: "specialty_category"
      expr: specialty_category
      comment: "Specialty grouping to pinpoint access gaps by service line."
    - name: "state_code"
      expr: state_code
      comment: "State of the assessment for regulatory jurisdiction views."
  measures:
    - name: "Assessment Count"
      expr: COUNT(1)
      comment: "Number of adequacy assessments — baseline volume."
    - name: "Avg Pct Members Within Standard"
      expr: AVG(CAST(percentage_members_within_standard AS DOUBLE))
      comment: "Average share of members meeting time/distance standards — headline adequacy KPI."
    - name: "Avg Actual Distance Miles"
      expr: AVG(CAST(actual_average_distance_miles AS DOUBLE))
      comment: "Average actual member travel distance to providers — access burden metric."
    - name: "Avg Actual Provider Member Ratio"
      expr: AVG(CAST(actual_provider_to_member_ratio AS DOUBLE))
      comment: "Average actual provider-to-member ratio, adequacy sufficiency indicator."
    - name: "Adequate Assessment Count"
      expr: COUNT(CASE WHEN essential_community_provider_flag = TRUE THEN 1 END)
      comment: "Assessments including essential community providers — safety-net access indicator."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`insurance_member_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Membership and enrollment health: enrolled member counts, premium and subsidy volumes, and terminations for membership growth steering."
  source: "`vibe_healthcare_v1`.`insurance`.`member_enrollment`"
  dimensions:
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Enrollment lifecycle status (active, termed, pending) for membership tracking."
    - name: "enrollment_type"
      expr: enrollment_type
      comment: "Type of enrollment (new, renewal, special enrollment) for channel analysis."
    - name: "coverage_tier"
      expr: coverage_tier
      comment: "Coverage tier (individual, family) for premium mix analysis."
    - name: "enrollment_channel"
      expr: enrollment_channel
      comment: "Acquisition channel for enrollment marketing ROI."
    - name: "enrollment_month"
      expr: DATE_TRUNC('MONTH', enrollment_effective_date)
      comment: "Month bucket of enrollment effective date for growth trending."
  measures:
    - name: "Enrollment Count"
      expr: COUNT(1)
      comment: "Number of enrollment records — baseline volume."
    - name: "Distinct Enrolled Members"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct enrolled members — headline membership count."
    - name: "Total Premium Amount"
      expr: SUM(CAST(premium_amount AS DOUBLE))
      comment: "Total premium dollars associated with enrollments — recurring revenue base."
    - name: "Total Subsidy Amount"
      expr: SUM(CAST(subsidy_amount AS DOUBLE))
      comment: "Total subsidy dollars supporting enrollment premiums."
    - name: "Terminated Enrollment Count"
      expr: COUNT(CASE WHEN enrollment_termination_date IS NOT NULL THEN 1 END)
      comment: "Enrollments with a termination date — churn/attrition indicator."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`insurance_member_attribution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Population attribution and VBC panel management: attributed members, risk scores, and capitation amounts for value-based population steering."
  source: "`vibe_healthcare_v1`.`insurance`.`member_attribution`"
  dimensions:
    - name: "attribution_status"
      expr: attribution_status
      comment: "Status of member attribution for panel accuracy."
    - name: "attribution_method"
      expr: attribution_method
      comment: "Method used to attribute members (claims-based, prospective) for methodology analysis."
    - name: "attribution_type"
      expr: attribution_type
      comment: "Type of attribution arrangement for VBC segmentation."
    - name: "performance_year"
      expr: performance_year
      comment: "Performance year for attribution trending."
    - name: "shared_savings_eligible"
      expr: shared_savings_eligible
      comment: "Whether the attributed member is shared-savings eligible — VBC revenue driver."
  measures:
    - name: "Attribution Count"
      expr: COUNT(1)
      comment: "Number of attribution records — baseline volume."
    - name: "Distinct Attributed Members"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct attributed members — the managed population size."
    - name: "Avg Risk Score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score of attributed members — panel acuity for capitation adequacy."
    - name: "Total Capitation Amount"
      expr: SUM(CAST(capitation_amount AS DOUBLE))
      comment: "Total capitation dollars tied to attributed members — VBC revenue."
    - name: "Avg Attribution Confidence"
      expr: AVG(CAST(attribution_confidence_score AS DOUBLE))
      comment: "Average attribution confidence score — data-quality/panel-reliability metric."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`insurance_accountable_care_organization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "ACO performance oversight: shared savings vs losses, expenditure against benchmark, and quality scores for ACO program steering."
  source: "`vibe_healthcare_v1`.`insurance`.`accountable_care_organization`"
  dimensions:
    - name: "aco_type"
      expr: aco_type
      comment: "ACO model type for program segmentation."
    - name: "track_level"
      expr: track_level
      comment: "Risk track level (upside vs two-sided) for risk-portfolio analysis."
    - name: "program_model"
      expr: program_model
      comment: "CMS program model (MSSP, REACH) for program comparison."
    - name: "performance_year"
      expr: performance_year
      comment: "Performance year for ACO trending."
  measures:
    - name: "ACO Count"
      expr: COUNT(1)
      comment: "Number of ACO records — baseline."
    - name: "Total Shared Savings"
      expr: SUM(CAST(shared_savings_amount AS DOUBLE))
      comment: "Total shared savings earned by ACOs — headline VBC outcome."
    - name: "Total Shared Loss"
      expr: SUM(CAST(shared_loss_amount AS DOUBLE))
      comment: "Total shared losses owed by ACOs — downside risk realized."
    - name: "Total Actual Expenditure"
      expr: SUM(CAST(actual_expenditure_amount AS DOUBLE))
      comment: "Total actual expenditure for attributed populations."
    - name: "Total Benchmark Expenditure"
      expr: SUM(CAST(benchmark_expenditure_amount AS DOUBLE))
      comment: "Total benchmark expenditure target — savings comparison baseline."
    - name: "Avg Quality Score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average ACO quality score, gate for shared-savings eligibility."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`insurance_accumulator`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Member cost-share accumulator tracking: accumulated amounts, remaining deductible/OOP, and threshold attainment for benefit-utilization steering."
  source: "`vibe_healthcare_v1`.`insurance`.`accumulator`"
  dimensions:
    - name: "accumulator_type"
      expr: accumulator_type
      comment: "Type of accumulator (deductible, OOP max) for cost-share analysis."
    - name: "accumulator_status"
      expr: accumulator_status
      comment: "Status of the accumulator record."
    - name: "coverage_level"
      expr: coverage_level
      comment: "Individual vs family coverage level for cost-share segmentation."
    - name: "benefit_year"
      expr: benefit_year
      comment: "Benefit year for accumulator reset trending."
    - name: "threshold_met_indicator"
      expr: threshold_met_indicator
      comment: "Whether the deductible/OOP threshold has been met — claims-liability signal."
  measures:
    - name: "Accumulator Count"
      expr: COUNT(1)
      comment: "Number of accumulator records — baseline volume."
    - name: "Total Accumulated Amount"
      expr: SUM(CAST(accumulated_amount AS DOUBLE))
      comment: "Total member cost-share accumulated to date."
    - name: "Total Remaining Amount"
      expr: SUM(CAST(remaining_amount AS DOUBLE))
      comment: "Total remaining before thresholds met — forward payer liability exposure."
    - name: "Distinct Members"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct members with accumulators — coverage breadth."
    - name: "Threshold Met Count"
      expr: COUNT(CASE WHEN threshold_met_indicator = TRUE THEN 1 END)
      comment: "Members who met deductible/OOP thresholds — full-liability population."
$$;