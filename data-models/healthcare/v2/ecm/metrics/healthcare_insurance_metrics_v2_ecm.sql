-- Metric views for domain: insurance | Business: Healthcare | Version: 2 | Generated on: 2026-07-02 07:21:53

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`insurance_premium_billing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Premium billing and collections KPIs used by finance leadership to monitor cash collection, subsidy exposure, and delinquency risk across employer groups and health plans."
  source: "`vibe_healthcare_v1`.`insurance`.`premium_billing`"
  dimensions:
    - name: "billing_status"
      expr: billing_status
      comment: "Lifecycle state of the premium invoice (e.g. paid, open, delinquent) for collections segmentation."
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "Cadence of premium billing (monthly, quarterly) for cash-flow cadence analysis."
    - name: "payment_method"
      expr: payment_method
      comment: "Method of premium payment (EFT, check) for payment-channel efficiency analysis."
    - name: "billing_month"
      expr: DATE_TRUNC('MONTH', billing_date)
      comment: "Billing period bucketed to month for premium-revenue trending."
  measures:
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Number of premium invoices - baseline volume for billing operations."
    - name: "total_amount_due"
      expr: SUM(CAST(total_amount_due AS DOUBLE))
      comment: "Total premium billed - drives topline premium revenue expectations."
    - name: "total_amount_paid"
      expr: SUM(CAST(amount_paid AS DOUBLE))
      comment: "Total premium collected - core cash-collection KPI for finance."
    - name: "total_subsidy_amount"
      expr: SUM(CAST(subsidy_amount AS DOUBLE))
      comment: "Total subsidy applied - quantifies exchange/subsidy exposure for reconciliation."
    - name: "total_late_fee_amount"
      expr: SUM(CAST(late_fee_amount AS DOUBLE))
      comment: "Total late fees assessed - indicator of delinquency and collection friction."
    - name: "avg_amount_due_per_invoice"
      expr: AVG(CAST(amount_due AS DOUBLE))
      comment: "Average amount due per invoice - premium intensity per member/group."
    - name: "collection_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(amount_paid AS DOUBLE)) / NULLIF(SUM(CAST(total_amount_due AS DOUBLE)), 0), 2)
      comment: "Percent of billed premium collected - primary revenue-cycle health KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`insurance_capitation_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capitation payment KPIs for value-based contracting leadership to monitor PMPM spend, quality bonus/withhold flow, and net financial exposure to at-risk provider arrangements."
  source: "`vibe_healthcare_v1`.`insurance`.`capitation_payment`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "State of the capitation payment (issued, pending) for payment-operations tracking."
    - name: "payment_method"
      expr: payment_method
      comment: "Disbursement method for capitation payments."
    - name: "adjustment_reason"
      expr: adjustment_reason
      comment: "Reason for payment adjustment - drives reconciliation and dispute analysis."
    - name: "payment_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Payment date bucketed to month for capitation spend trending."
  measures:
    - name: "payment_count"
      expr: COUNT(1)
      comment: "Number of capitation payments - baseline disbursement volume."
    - name: "total_net_payment"
      expr: SUM(CAST(net_payment_amount AS DOUBLE))
      comment: "Total net capitation paid - core at-risk cost KPI for VBC finance."
    - name: "total_base_capitation"
      expr: SUM(CAST(base_capitation_amount AS DOUBLE))
      comment: "Total base capitation before adjustments - baseline PMPM commitment."
    - name: "total_quality_bonus"
      expr: SUM(CAST(quality_bonus_amount AS DOUBLE))
      comment: "Total quality bonus paid - quantifies performance-incentive spend."
    - name: "total_quality_withhold"
      expr: SUM(CAST(quality_withhold_amount AS DOUBLE))
      comment: "Total quality withhold - dollars held pending performance, key exposure metric."
    - name: "total_risk_adjustment"
      expr: SUM(CAST(risk_adjustment_amount AS DOUBLE))
      comment: "Total risk adjustment applied - measures acuity-driven payment shift."
    - name: "avg_net_payment"
      expr: AVG(CAST(net_payment_amount AS DOUBLE))
      comment: "Average net payment per capitation cycle - unit economics of at-risk contracts."
    - name: "quality_bonus_share_pct"
      expr: ROUND(100.0 * SUM(CAST(quality_bonus_amount AS DOUBLE)) / NULLIF(SUM(CAST(net_payment_amount AS DOUBLE)), 0), 2)
      comment: "Quality bonus as percent of net payment - shows performance-incentive weighting."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`insurance_vbc_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Value-based care performance KPIs for population-health and network executives to monitor quality attainment vs benchmark, shared-savings capture, and total cost of care."
  source: "`vibe_healthcare_v1`.`insurance`.`vbc_performance`"
  dimensions:
    - name: "performance_status"
      expr: performance_status
      comment: "Overall VBC performance status for contract-level scorecarding."
    - name: "performance_tier"
      expr: performance_tier
      comment: "Performance tier classification for provider ranking and bonus banding."
    - name: "measure_name"
      expr: measure_name
      comment: "Quality measure being evaluated for measure-level performance analysis."
    - name: "measurement_period"
      expr: measurement_period
      comment: "Reporting period label for period-over-period VBC comparison."
  measures:
    - name: "performance_record_count"
      expr: COUNT(1)
      comment: "Number of performance evaluations - baseline VBC reporting volume."
    - name: "total_shared_savings"
      expr: SUM(CAST(shared_savings_amount AS DOUBLE))
      comment: "Total shared savings earned - headline financial upside of VBC arrangements."
    - name: "total_bonus_amount"
      expr: SUM(CAST(bonus_amount AS DOUBLE))
      comment: "Total quality bonus earned across measures - incentive capture KPI."
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total penalties incurred - downside risk realized in VBC contracts."
    - name: "total_cost_of_care"
      expr: SUM(CAST(total_cost_of_care_amount AS DOUBLE))
      comment: "Aggregate total cost of care - denominator for savings and efficiency analysis."
    - name: "avg_performance_score"
      expr: AVG(CAST(performance_score AS DOUBLE))
      comment: "Average performance score - overall quality attainment indicator."
    - name: "avg_actual_performance_rate"
      expr: AVG(CAST(actual_performance_rate AS DOUBLE))
      comment: "Average actual performance rate across measures for quality steering."
    - name: "avg_benchmark_rate"
      expr: AVG(CAST(benchmark_rate AS DOUBLE))
      comment: "Average benchmark rate - comparison line for performance gap analysis."
    - name: "performance_vs_benchmark_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_performance_rate AS DOUBLE)) / NULLIF(SUM(CAST(benchmark_rate AS DOUBLE)), 0), 2)
      comment: "Actual performance relative to benchmark - core VBC quality attainment KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`insurance_risk_adjustment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Risk-adjustment KPIs for actuarial and revenue-integrity leaders to monitor RAF scores, HCC capture, and CMS submission completeness that drive risk-based revenue."
  source: "`vibe_healthcare_v1`.`insurance`.`risk_adjustment`"
  dimensions:
    - name: "risk_model"
      expr: risk_model
      comment: "Risk-adjustment model applied (e.g. HCC) for methodology-level analysis."
    - name: "risk_score_category"
      expr: risk_score_category
      comment: "RAF score band for member-acuity segmentation."
    - name: "submission_status"
      expr: submission_status
      comment: "CMS submission state - drives revenue-integrity completeness tracking."
    - name: "measurement_year"
      expr: measurement_year
      comment: "Measurement year for year-over-year RAF trending."
  measures:
    - name: "risk_record_count"
      expr: COUNT(1)
      comment: "Number of risk-adjustment records - baseline population coverage."
    - name: "member_count"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct members risk-scored - denominator for average acuity KPIs."
    - name: "avg_raf_score"
      expr: AVG(CAST(raf_score AS DOUBLE))
      comment: "Average RAF score - headline acuity metric driving risk-based revenue."
    - name: "max_raf_score"
      expr: MAX(CAST(raf_score AS DOUBLE))
      comment: "Highest RAF score - identifies most acute members for care management."
    - name: "total_raf_score"
      expr: SUM(CAST(raf_score AS DOUBLE))
      comment: "Sum of RAF scores - aggregate acuity used with member count for weighted averages."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`insurance_utilization_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Utilization-review KPIs for medical-management leadership to monitor authorization decisions, denial rates, appeals, and regulatory turnaround compliance."
  source: "`vibe_healthcare_v1`.`insurance`.`utilization_review`"
  dimensions:
    - name: "review_type"
      expr: review_type
      comment: "Type of UR review (prospective, concurrent, retrospective) for workload segmentation."
    - name: "review_decision"
      expr: review_decision
      comment: "Outcome of the review (approved, denied, partial) - core decision KPI dimension."
    - name: "review_status"
      expr: review_status
      comment: "Current status of the review case for pipeline monitoring."
    - name: "denial_reason_code"
      expr: denial_reason_code
      comment: "Reason code for denials - drives root-cause and provider-education analysis."
    - name: "review_month"
      expr: DATE_TRUNC('MONTH', review_initiation_date)
      comment: "Review initiation bucketed to month for UR volume trending."
  measures:
    - name: "review_count"
      expr: COUNT(1)
      comment: "Number of utilization reviews - baseline UR workload volume."
    - name: "denied_review_count"
      expr: COUNT(CASE WHEN review_decision = 'Denied' THEN 1 END)
      comment: "Count of denied reviews - numerator for denial-rate KPI."
    - name: "appeal_count"
      expr: COUNT(CASE WHEN appeal_filed = TRUE THEN 1 END)
      comment: "Count of reviews with an appeal filed - measures member/provider dispute pressure."
    - name: "denial_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN review_decision = 'Denied' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of reviews denied - key medical-management and abrasion KPI."
    - name: "regulatory_timeframe_met_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN regulatory_timeframe_met = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of reviews meeting regulatory turnaround - compliance-risk KPI."
    - name: "peer_to_peer_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN peer_to_peer_requested = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of reviews escalated to peer-to-peer - indicator of clinical-dispute intensity."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`insurance_member_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Member enrollment KPIs for growth and membership leaders to monitor active membership, premium revenue base, subsidy mix, and churn drivers by plan and channel."
  source: "`vibe_healthcare_v1`.`insurance`.`member_enrollment`"
  dimensions:
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Current enrollment state (active, terminated) for membership counts."
    - name: "enrollment_type"
      expr: enrollment_type
      comment: "Type of enrollment (new, renewal, special) for growth-mix analysis."
    - name: "enrollment_channel"
      expr: enrollment_channel
      comment: "Acquisition channel for enrollment - channel-efficiency segmentation."
    - name: "coverage_tier"
      expr: coverage_tier
      comment: "Coverage tier (individual, family) for premium-mix analysis."
    - name: "termination_reason"
      expr: termination_reason
      comment: "Reason for termination - drives churn root-cause analysis."
    - name: "enrollment_month"
      expr: DATE_TRUNC('MONTH', enrollment_effective_date)
      comment: "Effective date bucketed to month for enrollment trending."
  measures:
    - name: "enrollment_count"
      expr: COUNT(1)
      comment: "Number of enrollment records - baseline membership volume."
    - name: "distinct_member_count"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct enrolled members - core membership-size KPI for growth steering."
    - name: "terminated_enrollment_count"
      expr: COUNT(CASE WHEN enrollment_status = 'Terminated' THEN 1 END)
      comment: "Count of terminated enrollments - numerator for churn analysis."
    - name: "churn_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN enrollment_status = 'Terminated' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of enrollments terminated - membership retention KPI."
    - name: "total_premium_amount"
      expr: SUM(CAST(premium_amount AS DOUBLE))
      comment: "Total premium across enrollments - membership-driven revenue base."
    - name: "total_subsidy_amount"
      expr: SUM(CAST(subsidy_amount AS DOUBLE))
      comment: "Total subsidy amount - exchange/subsidy exposure of the book."
    - name: "avg_premium_amount"
      expr: AVG(CAST(premium_amount AS DOUBLE))
      comment: "Average premium per enrollment - premium yield per member."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`insurance_accumulator`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Benefit-accumulator KPIs for actuarial and member-experience teams to monitor deductible and out-of-pocket progression, remaining exposure, and cost-sharing burden."
  source: "`vibe_healthcare_v1`.`insurance`.`accumulator`"
  dimensions:
    - name: "accumulator_type"
      expr: accumulator_type
      comment: "Type of accumulator (deductible, OOP) for cost-sharing segmentation."
    - name: "service_category"
      expr: service_category
      comment: "Service category the accumulator applies to for spend-category analysis."
    - name: "network_tier"
      expr: network_tier
      comment: "Network tier for in vs out-of-network cost-share analysis."
    - name: "in_network_flag"
      expr: in_network_flag
      comment: "Whether accumulation is in-network - drives network-steerage insight."
  measures:
    - name: "accumulator_count"
      expr: COUNT(1)
      comment: "Number of accumulator records - baseline coverage volume."
    - name: "total_deductible_accumulated"
      expr: SUM(CAST(deductible_accumulated_amount AS DOUBLE))
      comment: "Total deductible met across members - member cost-burden indicator."
    - name: "total_oop_accumulated"
      expr: SUM(CAST(oop_accumulated_amount AS DOUBLE))
      comment: "Total out-of-pocket accumulated - member financial-burden KPI."
    - name: "total_oop_remaining"
      expr: SUM(CAST(oop_remaining_amount AS DOUBLE))
      comment: "Total remaining out-of-pocket exposure - forward liability estimate."
    - name: "avg_deductible_remaining"
      expr: AVG(CAST(deductible_remaining_amount AS DOUBLE))
      comment: "Average remaining deductible per member - cost-share progression indicator."
    - name: "oop_utilization_pct"
      expr: ROUND(100.0 * SUM(CAST(oop_accumulated_amount AS DOUBLE)) / NULLIF(SUM(CAST(limit_amount AS DOUBLE)), 0), 2)
      comment: "Accumulated OOP as percent of limit - shows how far members are through cost-share caps."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`insurance_coordination_of_benefits`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Coordination-of-benefits KPIs for payment-integrity teams to monitor primary vs secondary payer recovery and COB determination coverage."
  source: "`vibe_healthcare_v1`.`insurance`.`coordination_of_benefits`"
  dimensions:
    - name: "cob_status"
      expr: cob_status
      comment: "Status of the COB determination for payment-integrity tracking."
    - name: "cob_type"
      expr: cob_type
      comment: "Type of coordination (primary, secondary) for recovery analysis."
    - name: "cob_determination_method"
      expr: cob_determination_method
      comment: "Method used to determine COB order - drives automation-vs-manual analysis."
    - name: "cob_determination_month"
      expr: DATE_TRUNC('MONTH', cob_determination_date)
      comment: "Determination date bucketed to month for COB trending."
  measures:
    - name: "cob_record_count"
      expr: COUNT(1)
      comment: "Number of COB records - baseline coordination volume."
    - name: "total_primary_paid"
      expr: SUM(CAST(primary_payer_paid_amount AS DOUBLE))
      comment: "Total paid by primary payer - primary-liability spend."
    - name: "total_other_paid"
      expr: SUM(CAST(other_payer_paid_amount AS DOUBLE))
      comment: "Total paid by other payers - COB recovery/offset amount."
    - name: "avg_primary_paid"
      expr: AVG(CAST(primary_payer_paid_amount AS DOUBLE))
      comment: "Average primary payer payment per COB record."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`insurance_capitation_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capitation-contract KPIs for network-strategy leaders to monitor PMPM rate structure, quality-withhold exposure, and stop-loss protection across at-risk contracts."
  source: "`vibe_healthcare_v1`.`insurance`.`capitation_contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Contract lifecycle state for active at-risk portfolio tracking."
    - name: "risk_arrangement_type"
      expr: risk_arrangement_type
      comment: "Type of risk arrangement (full-risk, shared) for portfolio-risk segmentation."
    - name: "payment_frequency"
      expr: payment_frequency
      comment: "Capitation payment cadence for cash-flow planning."
    - name: "quality_bonus_eligible"
      expr: quality_bonus_eligible
      comment: "Whether the contract is quality-bonus eligible - incentive-design analysis."
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Contract effective year for cohort-based contract analysis."
  measures:
    - name: "contract_count"
      expr: COUNT(1)
      comment: "Number of capitation contracts - baseline at-risk contract volume."
    - name: "avg_pmpm_rate"
      expr: AVG(CAST(capitation_rate_pmpm AS DOUBLE))
      comment: "Average PMPM capitation rate - core at-risk pricing KPI."
    - name: "avg_quality_withhold_pct"
      expr: AVG(CAST(quality_withhold_percentage AS DOUBLE))
      comment: "Average quality withhold percentage - performance-at-risk design metric."
    - name: "avg_stop_loss_threshold"
      expr: AVG(CAST(stop_loss_threshold AS DOUBLE))
      comment: "Average stop-loss threshold - catastrophic-risk protection level."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`insurance_network_adequacy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Network-adequacy KPIs for network-management and compliance leaders to monitor time/distance standard attainment and provider-to-member ratios by specialty and region."
  source: "`vibe_healthcare_v1`.`insurance`.`network_adequacy`"
  dimensions:
    - name: "adequacy_status"
      expr: adequacy_status
      comment: "Overall adequacy status for compliance scorecarding."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Regulatory compliance status of the network assessment."
    - name: "specialty_type"
      expr: specialty_type
      comment: "Specialty being assessed for adequacy - drives gap targeting."
    - name: "geographic_region"
      expr: geographic_region
      comment: "Region of the adequacy assessment for geographic gap analysis."
    - name: "assessment_month"
      expr: DATE_TRUNC('MONTH', assessment_date)
      comment: "Assessment date bucketed to month for adequacy trending."
  measures:
    - name: "assessment_count"
      expr: COUNT(1)
      comment: "Number of adequacy assessments - baseline compliance workload."
    - name: "distance_standard_met_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN distance_standard_met = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of assessments meeting distance standards - core adequacy-compliance KPI."
    - name: "time_standard_met_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN time_standard_met = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of assessments meeting wait-time standards - access-compliance KPI."
    - name: "avg_max_distance_miles"
      expr: AVG(CAST(max_distance_miles AS DOUBLE))
      comment: "Average max distance to nearest provider - member-access burden indicator."
    - name: "avg_provider_to_member_ratio"
      expr: AVG(CAST(provider_to_member_ratio AS DOUBLE))
      comment: "Average provider-to-member ratio - network-capacity adequacy metric."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`insurance_network_participation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provider network-participation KPIs for network-operations leaders to monitor credentialing status, panel openness, and recredentialing pipeline health."
  source: "`vibe_healthcare_v1`.`insurance`.`insurance_network_participation`"
  dimensions:
    - name: "participation_status"
      expr: participation_status
      comment: "Provider participation status for active-network sizing."
    - name: "credentialing_status"
      expr: credentialing_status
      comment: "Credentialing state - drives onboarding-pipeline analysis."
    - name: "network_tier"
      expr: network_tier
      comment: "Network tier of participation for tiered-network analysis."
    - name: "panel_status"
      expr: panel_status
      comment: "Panel open/closed status for access and steerage analysis."
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Participation effective date bucketed to month for network-growth trending."
  measures:
    - name: "participation_count"
      expr: COUNT(1)
      comment: "Number of participation records - baseline network-size volume."
    - name: "distinct_provider_count"
      expr: COUNT(DISTINCT clinician_id)
      comment: "Distinct participating clinicians - core network-breadth KPI."
    - name: "accepting_new_patients_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN accepting_new_patients = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of providers accepting new patients - member-access KPI."
    - name: "directory_visible_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN directory_visible = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of providers visible in directory - directory-accuracy/compliance indicator."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`insurance_member_attribution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Member-attribution KPIs for population-health leaders to monitor attributed panel size, attribution churn, and method mix underlying VBC financial arrangements."
  source: "`vibe_healthcare_v1`.`insurance`.`member_attribution`"
  dimensions:
    - name: "attribution_status"
      expr: attribution_status
      comment: "Current attribution status for active-panel sizing."
    - name: "attribution_method"
      expr: attribution_method
      comment: "Method of attribution (claims-based, selection) for methodology analysis."
    - name: "attribution_type"
      expr: attribution_type
      comment: "Type of attribution for VBC-arrangement segmentation."
    - name: "measurement_year"
      expr: measurement_year
      comment: "Measurement year for year-over-year attributed-panel trending."
  measures:
    - name: "attribution_count"
      expr: COUNT(1)
      comment: "Number of attribution records - baseline attribution volume."
    - name: "attributed_member_count"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct attributed members - core attributed-panel-size KPI for VBC."
    - name: "attributed_provider_count"
      expr: COUNT(DISTINCT clinician_id)
      comment: "Distinct providers with attributed members - panel-distribution indicator."
    - name: "active_attribution_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN attribution_status = 'Active' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of attributions currently active - attribution-stability KPI."
$$;