-- Metric views for domain: contract | Business: Health_Insurance | Version: 3 | Generated on: 2026-07-10 20:04:11

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`contract_provider_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core provider contract metrics tracking contract volume, capitation rates, and contract lifecycle by payment methodology, contract type, and network tier"
  source: "`vibe_health_insurance_v1`.`contract`.`provider_contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Current status of the provider contract (active, terminated, pending, etc.)"
    - name: "contract_type"
      expr: contract_type
      comment: "Type of provider contract (professional, facility, ancillary, etc.)"
    - name: "payment_methodology"
      expr: payment_methodology
      comment: "Payment methodology used in the contract (FFS, capitation, bundled, VBC, etc.)"
    - name: "lob_applicability"
      expr: lob_applicability
      comment: "Line of business applicability (Commercial, Medicare, Medicaid, etc.)"
    - name: "contract_tier"
      expr: contract_tier
      comment: "Contract tier classification (Tier 1, Tier 2, Tier 3, etc.)"
    - name: "provider_type"
      expr: provider_type
      comment: "Type of provider (PCP, specialist, hospital, ancillary, etc.)"
    - name: "vbc_flag"
      expr: vbc_flag
      comment: "Indicates whether the contract includes value-based care arrangements"
    - name: "capitation_flag"
      expr: CASE WHEN capitation_rate_pmpm > 0 THEN TRUE ELSE FALSE END
      comment: "Indicates whether the contract includes capitation payment"
    - name: "risk_sharing_model"
      expr: risk_sharing_model
      comment: "Risk sharing model type (upside only, downside only, two-sided, etc.)"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the contract became effective"
    - name: "effective_quarter"
      expr: CONCAT('Q', QUARTER(effective_date), '-', YEAR(effective_date))
      comment: "Quarter and year the contract became effective"
    - name: "contract_age_days"
      expr: DATEDIFF(CURRENT_DATE(), effective_date)
      comment: "Number of days since contract effective date"
  measures:
    - name: "total_contracts"
      expr: COUNT(DISTINCT provider_contract_id)
      comment: "Total number of unique provider contracts"
    - name: "active_contracts"
      expr: COUNT(DISTINCT CASE WHEN contract_status = 'Active' THEN provider_contract_id END)
      comment: "Number of active provider contracts"
    - name: "avg_capitation_rate_pmpm"
      expr: AVG(CAST(capitation_rate_pmpm AS DOUBLE))
      comment: "Average capitation rate per member per month across contracts"
    - name: "total_capitation_value"
      expr: SUM(CAST(capitation_rate_pmpm AS DOUBLE))
      comment: "Total capitation rate value across all contracts"
    - name: "vbc_contract_count"
      expr: COUNT(DISTINCT CASE WHEN vbc_flag = TRUE THEN provider_contract_id END)
      comment: "Number of contracts with value-based care arrangements"
    - name: "vbc_penetration_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN vbc_flag = TRUE THEN provider_contract_id END) / NULLIF(COUNT(DISTINCT provider_contract_id), 0), 2)
      comment: "Percentage of contracts that include value-based care arrangements"
    - name: "capitation_contract_count"
      expr: COUNT(DISTINCT CASE WHEN capitation_rate_pmpm > 0 THEN provider_contract_id END)
      comment: "Number of contracts with capitation payment methodology"
    - name: "avg_contract_age_days"
      expr: AVG(CAST(DATEDIFF(CURRENT_DATE(), effective_date) AS DOUBLE))
      comment: "Average age of contracts in days since effective date"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`contract_capitation_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capitation payment financial metrics tracking payment volume, PMPM rates, risk adjustment, and withhold amounts by LOB, payment status, and time period"
  source: "`vibe_health_insurance_v1`.`contract`.`capitation_payment`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Status of the capitation payment (paid, pending, voided, etc.)"
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment (ACH, check, wire, etc.)"
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business for the capitation payment"
    - name: "payment_type"
      expr: payment_type
      comment: "Type of capitation payment (regular, adjustment, settlement, etc.)"
    - name: "vbc_contract_flag"
      expr: vbc_contract_flag
      comment: "Indicates whether payment is under a value-based care contract"
    - name: "prior_period_adjustment_flag"
      expr: prior_period_adjustment_flag
      comment: "Indicates whether payment includes prior period adjustments"
    - name: "payment_year"
      expr: YEAR(payment_date)
      comment: "Year the payment was made"
    - name: "payment_quarter"
      expr: CONCAT('Q', QUARTER(payment_date), '-', YEAR(payment_date))
      comment: "Quarter and year the payment was made"
    - name: "payment_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Month the payment was made"
    - name: "service_period_year"
      expr: YEAR(payment_period_start_date)
      comment: "Year of the service period covered by the payment"
  measures:
    - name: "total_payments"
      expr: COUNT(DISTINCT capitation_payment_id)
      comment: "Total number of capitation payments"
    - name: "total_gross_payment_amount"
      expr: SUM(CAST(gross_payment_amount AS DOUBLE))
      comment: "Total gross capitation payment amount before adjustments"
    - name: "total_net_payment_amount"
      expr: SUM(CAST(net_payment_amount AS DOUBLE))
      comment: "Total net capitation payment amount after all adjustments"
    - name: "avg_pmpm_rate"
      expr: AVG(CAST(pmpm_rate AS DOUBLE))
      comment: "Average per member per month capitation rate"
    - name: "avg_risk_adjusted_pmpm"
      expr: AVG(CAST(risk_adjusted_pmpm_rate AS DOUBLE))
      comment: "Average risk-adjusted per member per month rate"
    - name: "total_quality_withhold"
      expr: SUM(CAST(quality_withhold_amount AS DOUBLE))
      comment: "Total amount withheld for quality performance"
    - name: "total_risk_pool_withhold"
      expr: SUM(CAST(risk_pool_withhold_amount AS DOUBLE))
      comment: "Total amount withheld for risk pool participation"
    - name: "total_enrollment_adjustment"
      expr: SUM(CAST(enrollment_adjustment_amount AS DOUBLE))
      comment: "Total enrollment adjustment amount across payments"
    - name: "total_stop_loss_recovery"
      expr: SUM(CAST(stop_loss_recovery_amount AS DOUBLE))
      comment: "Total stop loss recovery amount"
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across capitation payments"
    - name: "withhold_rate"
      expr: ROUND(100.0 * SUM(CAST(quality_withhold_amount AS DOUBLE) + CAST(risk_pool_withhold_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_payment_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of gross payment withheld for quality and risk pool"
    - name: "net_payment_yield"
      expr: ROUND(100.0 * SUM(CAST(net_payment_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_payment_amount AS DOUBLE)), 0), 2)
      comment: "Net payment as percentage of gross payment"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`contract_fee_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fee schedule metrics tracking schedule volume, conversion factors, and payment methodology by LOB, network tier, and schedule type"
  source: "`vibe_health_insurance_v1`.`contract`.`fee_schedule`"
  dimensions:
    - name: "schedule_status"
      expr: schedule_status
      comment: "Current status of the fee schedule (active, inactive, pending, superseded)"
    - name: "schedule_type"
      expr: schedule_type
      comment: "Type of fee schedule (professional, facility, ancillary, etc.)"
    - name: "payment_basis"
      expr: payment_basis
      comment: "Payment basis for the fee schedule (Medicare, UCR, custom, etc.)"
    - name: "lob_code"
      expr: lob_code
      comment: "Line of business code"
    - name: "service_category"
      expr: service_category
      comment: "Service category covered by the fee schedule"
    - name: "state_code"
      expr: state_code
      comment: "State code for geographic applicability"
    - name: "drg_applicable"
      expr: drg_applicable
      comment: "Indicates whether DRG-based payment applies"
    - name: "anesthesia_applicable"
      expr: anesthesia_applicable
      comment: "Indicates whether anesthesia conversion factors apply"
    - name: "stop_loss_applicable"
      expr: stop_loss_applicable
      comment: "Indicates whether stop loss thresholds apply"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the fee schedule became effective"
    - name: "cms_fee_schedule_year"
      expr: cms_fee_schedule_year
      comment: "CMS fee schedule year used as basis"
  measures:
    - name: "total_fee_schedules"
      expr: COUNT(DISTINCT fee_schedule_id)
      comment: "Total number of unique fee schedules"
    - name: "active_fee_schedules"
      expr: COUNT(DISTINCT CASE WHEN schedule_status = 'Active' THEN fee_schedule_id END)
      comment: "Number of active fee schedules"
    - name: "avg_conversion_factor"
      expr: AVG(CAST(conversion_factor AS DOUBLE))
      comment: "Average conversion factor across fee schedules"
    - name: "avg_payment_basis_pct"
      expr: AVG(CAST(payment_basis_pct AS DOUBLE))
      comment: "Average payment basis percentage (e.g., percent of Medicare)"
    - name: "avg_drg_base_rate"
      expr: AVG(CAST(drg_base_rate AS DOUBLE))
      comment: "Average DRG base rate for facility fee schedules"
    - name: "avg_anesthesia_conversion_factor"
      expr: AVG(CAST(anesthesia_conversion_factor AS DOUBLE))
      comment: "Average anesthesia conversion factor"
    - name: "avg_stop_loss_threshold"
      expr: AVG(CAST(stop_loss_threshold_amt AS DOUBLE))
      comment: "Average stop loss threshold amount"
    - name: "avg_outlier_threshold"
      expr: AVG(CAST(outlier_threshold_amt AS DOUBLE))
      comment: "Average outlier threshold amount"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`contract_vbc_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Value-based care contract performance metrics tracking shared savings, shared losses, quality performance, and financial reconciliation by VBC model type, LOB, and performance period"
  source: "`vibe_health_insurance_v1`.`contract`.`vbc_contract`"
  dimensions:
    - name: "vbc_model_type"
      expr: vbc_model_type
      comment: "Type of value-based care model (ACO, bundled payment, episode-based, etc.)"
    - name: "risk_arrangement_type"
      expr: risk_arrangement_type
      comment: "Risk arrangement type (upside only, downside only, two-sided risk)"
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business for the VBC contract"
    - name: "cms_program_track"
      expr: cms_program_track
      comment: "CMS program track (MSSP Track 1, Track 2, etc.)"
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Status of financial reconciliation (pending, in progress, completed)"
    - name: "quality_gate_met"
      expr: quality_gate_met
      comment: "Indicates whether quality gate requirements were met"
    - name: "performance_year"
      expr: performance_year
      comment: "Performance year for the VBC contract"
    - name: "episode_type"
      expr: episode_type
      comment: "Type of episode for episode-based VBC contracts"
    - name: "savings_achieved"
      expr: CASE WHEN shared_savings_amount > 0 THEN TRUE ELSE FALSE END
      comment: "Indicates whether shared savings were achieved"
    - name: "losses_incurred"
      expr: CASE WHEN benchmark_expenditure_target - actual_expenditure < 0 THEN TRUE ELSE FALSE END
      comment: "Indicates whether losses were incurred (actual exceeded benchmark)"
  measures:
    - name: "total_vbc_contracts"
      expr: COUNT(DISTINCT vbc_contract_id)
      comment: "Total number of value-based care contracts"
    - name: "total_shared_savings"
      expr: SUM(CAST(shared_savings_amount AS DOUBLE))
      comment: "Total shared savings amount earned across VBC contracts"
    - name: "total_benchmark_target"
      expr: SUM(CAST(benchmark_expenditure_target AS DOUBLE))
      comment: "Total benchmark expenditure target across VBC contracts"
    - name: "total_actual_expenditure"
      expr: SUM(CAST(actual_expenditure AS DOUBLE))
      comment: "Total actual expenditure across VBC contracts"
    - name: "total_episode_target_price"
      expr: SUM(CAST(episode_target_price AS DOUBLE))
      comment: "Total episode target price for episode-based VBC contracts"
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average quality score across VBC contracts"
    - name: "avg_savings_sharing_rate"
      expr: AVG(CAST(savings_sharing_rate AS DOUBLE))
      comment: "Average savings sharing rate percentage"
    - name: "avg_max_shared_savings_rate"
      expr: AVG(CAST(max_shared_savings_rate AS DOUBLE))
      comment: "Average maximum shared savings rate percentage"
    - name: "avg_max_shared_loss_rate"
      expr: AVG(CAST(max_shared_loss_rate AS DOUBLE))
      comment: "Average maximum shared loss rate percentage"
    - name: "savings_rate"
      expr: ROUND(100.0 * SUM(CAST(benchmark_expenditure_target AS DOUBLE) - CAST(actual_expenditure AS DOUBLE)) / NULLIF(SUM(CAST(benchmark_expenditure_target AS DOUBLE)), 0), 2)
      comment: "Percentage savings achieved relative to benchmark target"
    - name: "quality_gate_pass_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN quality_gate_met = TRUE THEN vbc_contract_id END) / NULLIF(COUNT(DISTINCT vbc_contract_id), 0), 2)
      comment: "Percentage of VBC contracts that met quality gate requirements"
    - name: "contracts_with_savings"
      expr: COUNT(DISTINCT CASE WHEN shared_savings_amount > 0 THEN vbc_contract_id END)
      comment: "Number of VBC contracts that achieved shared savings"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`contract_amendment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contract amendment metrics tracking amendment volume, rate changes, and approval cycle time by amendment type, approval status, and initiating party"
  source: "`vibe_health_insurance_v1`.`contract`.`amendment`"
  dimensions:
    - name: "amendment_type"
      expr: amendment_type
      comment: "Type of contract amendment (rate change, scope change, term extension, etc.)"
    - name: "approval_status"
      expr: approval_status
      comment: "Current approval status of the amendment"
    - name: "initiating_party"
      expr: initiating_party
      comment: "Party that initiated the amendment (provider, health plan, regulatory)"
    - name: "payment_methodology"
      expr: payment_methodology
      comment: "Payment methodology affected by the amendment"
    - name: "lob_code"
      expr: lob_code
      comment: "Line of business code affected by the amendment"
    - name: "network_tier"
      expr: network_tier
      comment: "Network tier affected by the amendment"
    - name: "regulatory_mandate_flag"
      expr: regulatory_mandate_flag
      comment: "Indicates whether amendment is driven by regulatory mandate"
    - name: "retroactive_flag"
      expr: retroactive_flag
      comment: "Indicates whether amendment has retroactive effect"
    - name: "claims_reprocess_required"
      expr: claims_reprocess_required
      comment: "Indicates whether claims reprocessing is required"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the amendment became effective"
    - name: "effective_quarter"
      expr: CONCAT('Q', QUARTER(effective_date), '-', YEAR(effective_date))
      comment: "Quarter and year the amendment became effective"
    - name: "negotiation_outcome"
      expr: negotiation_outcome
      comment: "Outcome of amendment negotiation (accepted, rejected, modified)"
  measures:
    - name: "total_amendments"
      expr: COUNT(DISTINCT amendment_id)
      comment: "Total number of contract amendments"
    - name: "approved_amendments"
      expr: COUNT(DISTINCT CASE WHEN approval_status = 'Approved' THEN amendment_id END)
      comment: "Number of approved amendments"
    - name: "avg_rate_change_pct"
      expr: AVG(CAST(rate_change_pct AS DOUBLE))
      comment: "Average rate change percentage across amendments"
    - name: "avg_capitation_rate_pmpm"
      expr: AVG(CAST(capitation_rate_pmpm AS DOUBLE))
      comment: "Average capitation rate PMPM in amendments"
    - name: "avg_risk_share_pct"
      expr: AVG(CAST(risk_share_pct AS DOUBLE))
      comment: "Average risk share percentage in amendments"
    - name: "avg_approval_cycle_days"
      expr: AVG(CAST(DATEDIFF(approved_date, submitted_date) AS DOUBLE))
      comment: "Average number of days from submission to approval"
    - name: "regulatory_amendment_count"
      expr: COUNT(DISTINCT CASE WHEN regulatory_mandate_flag = TRUE THEN amendment_id END)
      comment: "Number of amendments driven by regulatory mandates"
    - name: "retroactive_amendment_count"
      expr: COUNT(DISTINCT CASE WHEN retroactive_flag = TRUE THEN amendment_id END)
      comment: "Number of amendments with retroactive effect"
    - name: "claims_reprocess_amendment_count"
      expr: COUNT(DISTINCT CASE WHEN claims_reprocess_required = TRUE THEN amendment_id END)
      comment: "Number of amendments requiring claims reprocessing"
    - name: "approval_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN approval_status = 'Approved' THEN amendment_id END) / NULLIF(COUNT(DISTINCT amendment_id), 0), 2)
      comment: "Percentage of amendments that were approved"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`contract_dispute`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contract dispute metrics tracking dispute volume, resolution time, financial impact, and escalation by dispute type, status, and priority level"
  source: "`vibe_health_insurance_v1`.`contract`.`contract_dispute`"
  dimensions:
    - name: "dispute_status"
      expr: dispute_status
      comment: "Current status of the contract dispute"
    - name: "dispute_type"
      expr: dispute_type
      comment: "Type of contract dispute (payment, scope, quality, etc.)"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the dispute (high, medium, low)"
    - name: "resolution_outcome"
      expr: resolution_outcome
      comment: "Outcome of dispute resolution (provider favor, plan favor, compromise, etc.)"
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Indicates whether dispute was escalated"
    - name: "legal_counsel_involved"
      expr: legal_counsel_involved
      comment: "Indicates whether legal counsel was involved"
    - name: "sla_met_flag"
      expr: sla_met_flag
      comment: "Indicates whether SLA resolution time was met"
    - name: "regulatory_reporting_required"
      expr: regulatory_reporting_required
      comment: "Indicates whether regulatory reporting is required"
    - name: "lob_code"
      expr: lob_code
      comment: "Line of business code for the dispute"
    - name: "initiation_year"
      expr: YEAR(initiation_date)
      comment: "Year the dispute was initiated"
    - name: "initiation_quarter"
      expr: CONCAT('Q', QUARTER(initiation_date), '-', YEAR(initiation_date))
      comment: "Quarter and year the dispute was initiated"
  measures:
    - name: "total_disputes"
      expr: COUNT(DISTINCT contract_dispute_id)
      comment: "Total number of contract disputes"
    - name: "resolved_disputes"
      expr: COUNT(DISTINCT CASE WHEN dispute_status = 'Resolved' THEN contract_dispute_id END)
      comment: "Number of resolved disputes"
    - name: "total_disputed_amount"
      expr: SUM(CAST(disputed_amount AS DOUBLE))
      comment: "Total amount in dispute across all disputes"
    - name: "total_resolution_amount"
      expr: SUM(CAST(resolution_amount AS DOUBLE))
      comment: "Total resolution amount across resolved disputes"
    - name: "avg_disputed_amount"
      expr: AVG(CAST(disputed_amount AS DOUBLE))
      comment: "Average amount in dispute per dispute"
    - name: "avg_resolution_days"
      expr: AVG(CAST(DATEDIFF(resolution_date, initiation_date) AS DOUBLE))
      comment: "Average number of days to resolve disputes"
    - name: "escalation_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN escalation_flag = TRUE THEN contract_dispute_id END) / NULLIF(COUNT(DISTINCT contract_dispute_id), 0), 2)
      comment: "Percentage of disputes that were escalated"
    - name: "sla_compliance_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN sla_met_flag = TRUE THEN contract_dispute_id END) / NULLIF(COUNT(DISTINCT contract_dispute_id), 0), 2)
      comment: "Percentage of disputes resolved within SLA"
    - name: "legal_involvement_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN legal_counsel_involved = TRUE THEN contract_dispute_id END) / NULLIF(COUNT(DISTINCT contract_dispute_id), 0), 2)
      comment: "Percentage of disputes requiring legal counsel involvement"
    - name: "resolution_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN dispute_status = 'Resolved' THEN contract_dispute_id END) / NULLIF(COUNT(DISTINCT contract_dispute_id), 0), 2)
      comment: "Percentage of disputes that have been resolved"
    - name: "recovery_rate"
      expr: ROUND(100.0 * SUM(CAST(resolution_amount AS DOUBLE)) / NULLIF(SUM(CAST(disputed_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of disputed amount recovered through resolution"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`contract_incentive_arrangement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provider incentive arrangement metrics tracking incentive earnings, withhold pools, quality performance, and payout by arrangement type, LOB, and performance period"
  source: "`vibe_health_insurance_v1`.`contract`.`incentive_arrangement`"
  dimensions:
    - name: "arrangement_status"
      expr: arrangement_status
      comment: "Current status of the incentive arrangement"
    - name: "arrangement_type"
      expr: arrangement_type
      comment: "Type of incentive arrangement (quality, utilization, VBC, etc.)"
    - name: "earned_status"
      expr: earned_status
      comment: "Status of incentive earnings (earned, forfeited, pending)"
    - name: "lob_code"
      expr: lob_code
      comment: "Line of business code"
    - name: "performance_year"
      expr: performance_year
      comment: "Performance year for the incentive arrangement"
    - name: "quality_gate_met"
      expr: quality_gate_met
      comment: "Indicates whether quality gate requirements were met"
    - name: "aco_arrangement_flag"
      expr: aco_arrangement_flag
      comment: "Indicates whether arrangement is part of ACO program"
    - name: "vbc_program_name"
      expr: vbc_program_name
      comment: "Name of the value-based care program"
    - name: "withhold_pool_type"
      expr: withhold_pool_type
      comment: "Type of withhold pool (quality, risk, performance)"
    - name: "performance_threshold_tier"
      expr: performance_threshold_tier
      comment: "Performance threshold tier achieved"
  measures:
    - name: "total_arrangements"
      expr: COUNT(DISTINCT incentive_arrangement_id)
      comment: "Total number of incentive arrangements"
    - name: "total_maximum_incentive"
      expr: SUM(CAST(maximum_incentive_amount AS DOUBLE))
      comment: "Total maximum incentive amount available"
    - name: "total_maximum_penalty"
      expr: SUM(CAST(maximum_penalty_amount AS DOUBLE))
      comment: "Total maximum penalty amount at risk"
    - name: "total_withheld_amount"
      expr: SUM(CAST(total_withheld_amount AS DOUBLE))
      comment: "Total amount withheld across arrangements"
    - name: "total_amount_released"
      expr: SUM(CAST(amount_released AS DOUBLE))
      comment: "Total amount released from withhold pools"
    - name: "total_amount_forfeited"
      expr: SUM(CAST(amount_forfeited AS DOUBLE))
      comment: "Total amount forfeited from withhold pools"
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average quality score across incentive arrangements"
    - name: "avg_withhold_percentage"
      expr: AVG(CAST(withhold_percentage AS DOUBLE))
      comment: "Average withhold percentage across arrangements"
    - name: "avg_shared_savings_rate"
      expr: AVG(CAST(shared_savings_rate AS DOUBLE))
      comment: "Average shared savings rate percentage"
    - name: "avg_shared_loss_rate"
      expr: AVG(CAST(shared_loss_rate AS DOUBLE))
      comment: "Average shared loss rate percentage"
    - name: "quality_gate_pass_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN quality_gate_met = TRUE THEN incentive_arrangement_id END) / NULLIF(COUNT(DISTINCT incentive_arrangement_id), 0), 2)
      comment: "Percentage of arrangements that met quality gate requirements"
    - name: "withhold_release_rate"
      expr: ROUND(100.0 * SUM(CAST(amount_released AS DOUBLE)) / NULLIF(SUM(CAST(total_withheld_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of withheld amount that was released"
    - name: "withhold_forfeiture_rate"
      expr: ROUND(100.0 * SUM(CAST(amount_forfeited AS DOUBLE)) / NULLIF(SUM(CAST(total_withheld_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of withheld amount that was forfeited"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`contract_financial_summary`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contract financial summary metrics tracking total payments, allowed amounts, withhold balances, and reconciliation status by contract type, payment methodology, and summary period"
  source: "`vibe_health_insurance_v1`.`contract`.`financial_summary`"
  dimensions:
    - name: "financial_summary_status"
      expr: financial_summary_status
      comment: "Status of the financial summary"
    - name: "contract_type"
      expr: contract_type
      comment: "Type of contract"
    - name: "payment_methodology"
      expr: payment_methodology
      comment: "Payment methodology used"
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Status of financial reconciliation"
    - name: "summary_period_type"
      expr: summary_period_type
      comment: "Type of summary period (monthly, quarterly, annual)"
    - name: "summary_year"
      expr: YEAR(summary_period_start)
      comment: "Year of the summary period"
    - name: "summary_quarter"
      expr: CONCAT('Q', QUARTER(summary_period_start), '-', YEAR(summary_period_start))
      comment: "Quarter and year of the summary period"
  measures:
    - name: "total_summaries"
      expr: COUNT(DISTINCT financial_summary_id)
      comment: "Total number of financial summaries"
    - name: "total_allowed_amount"
      expr: SUM(CAST(total_allowed_amount AS DOUBLE))
      comment: "Total allowed amount across all summaries"
    - name: "total_paid_amount"
      expr: SUM(CAST(total_paid_amount AS DOUBLE))
      comment: "Total paid amount across all summaries"
    - name: "total_capitation_accrual"
      expr: SUM(CAST(capitation_accrual_balance AS DOUBLE))
      comment: "Total capitation accrual balance"
    - name: "total_withhold_pool_balance"
      expr: SUM(CAST(withhold_pool_balance AS DOUBLE))
      comment: "Total withhold pool balance"
    - name: "total_ibnr_estimate"
      expr: SUM(CAST(ibnr_estimate_amount AS DOUBLE))
      comment: "Total incurred but not reported estimate amount"
    - name: "total_incentive_earned"
      expr: SUM(CAST(incentive_earned_amount AS DOUBLE))
      comment: "Total incentive amount earned"
    - name: "total_mrl_allocation"
      expr: SUM(CAST(mrl_allocation_amount AS DOUBLE))
      comment: "Total medical reserve liability allocation amount"
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average quality score across financial summaries"
    - name: "avg_risk_share_percentage"
      expr: AVG(CAST(risk_share_percentage AS DOUBLE))
      comment: "Average risk share percentage"
    - name: "payment_rate"
      expr: ROUND(100.0 * SUM(CAST(total_paid_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_allowed_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of allowed amount that was paid"
$$;