-- Metric views for domain: commission | Business: Life Insurance | Version: 1 | Generated on: 2026-05-04 03:35:10

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`commission_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core commission transaction metrics tracking gross and net commission amounts, rates, and payment performance across products, producers, and time periods"
  source: "`life_insurance_ecm`.`commission`.`commission_transaction`"
  dimensions:
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of commission transaction (FYC, renewal, override, etc.)"
    - name: "transaction_status"
      expr: transaction_status
      comment: "Current status of the commission transaction"
    - name: "product_type"
      expr: product_type
      comment: "Product type for the commissioned policy or contract"
    - name: "policy_year"
      expr: policy_year
      comment: "Policy year for commission calculation"
    - name: "hierarchy_level"
      expr: hierarchy_level
      comment: "Distribution hierarchy level of the producer"
    - name: "earning_month"
      expr: DATE_TRUNC('MONTH', earning_date)
      comment: "Month when commission was earned"
    - name: "payment_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Month when commission was paid"
    - name: "is_1099_reportable"
      expr: is_1099_reportable
      comment: "Whether transaction is reportable on IRS Form 1099"
    - name: "advance_repayment_status"
      expr: advance_repayment_status
      comment: "Status of advance repayment for this transaction"
    - name: "split_type"
      expr: split_type
      comment: "Type of commission split arrangement"
  measures:
    - name: "total_gross_commission"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross commission amount before deductions"
    - name: "total_net_commission"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net commission amount after all deductions"
    - name: "total_calculation_basis"
      expr: SUM(CAST(calculation_basis_amount AS DOUBLE))
      comment: "Total premium or other basis used for commission calculation"
    - name: "total_chargeback_amount"
      expr: SUM(CAST(chargeback_amount AS DOUBLE))
      comment: "Total amount charged back due to policy lapses or cancellations"
    - name: "avg_commission_rate"
      expr: AVG(CAST(commission_rate AS DOUBLE))
      comment: "Average commission rate percentage across transactions"
    - name: "commission_yield_pct"
      expr: ROUND(100.0 * SUM(CAST(net_amount AS DOUBLE)) / NULLIF(SUM(CAST(calculation_basis_amount AS DOUBLE)), 0), 2)
      comment: "Net commission as percentage of calculation basis (effective yield)"
    - name: "chargeback_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(chargeback_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_amount AS DOUBLE)), 0), 2)
      comment: "Chargeback amount as percentage of gross commission"
    - name: "transaction_count"
      expr: COUNT(1)
      comment: "Number of commission transactions"
    - name: "unique_producers"
      expr: COUNT(DISTINCT producer_id)
      comment: "Number of distinct producers earning commission"
    - name: "unique_policies"
      expr: COUNT(DISTINCT in_force_policy_id)
      comment: "Number of distinct policies generating commission"
$$;


CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`commission_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Commission payment execution metrics tracking gross-to-net payment amounts, tax withholding, and payment method performance"
  source: "`life_insurance_ecm`.`commission`.`commission_payment`"
  dimensions:
    - name: "payment_type"
      expr: payment_type
      comment: "Type of commission payment (regular, bonus, adjustment, etc.)"
    - name: "payment_status"
      expr: payment_status
      comment: "Current status of the payment"
    - name: "payment_method"
      expr: payment_method
      comment: "Method used for payment (ACH, check, wire, etc.)"
    - name: "payment_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Month when payment was issued"
    - name: "tax_year"
      expr: tax_year
      comment: "Tax year for reporting purposes"
    - name: "backup_withholding_flag"
      expr: backup_withholding_flag
      comment: "Whether backup withholding was applied"
    - name: "chargeback_flag"
      expr: chargeback_flag
      comment: "Whether payment includes chargeback activity"
  measures:
    - name: "total_gross_payment"
      expr: SUM(CAST(gross_payment_amount AS DOUBLE))
      comment: "Total gross payment amount before tax withholding"
    - name: "total_net_payment"
      expr: SUM(CAST(net_payment_amount AS DOUBLE))
      comment: "Total net payment amount after tax withholding"
    - name: "total_federal_tax_withheld"
      expr: SUM(CAST(federal_tax_withheld_amount AS DOUBLE))
      comment: "Total federal tax withheld from payments"
    - name: "total_state_tax_withheld"
      expr: SUM(CAST(state_tax_withheld_amount AS DOUBLE))
      comment: "Total state tax withheld from payments"
    - name: "total_ape_basis"
      expr: SUM(CAST(annualized_premium_equivalent AS DOUBLE))
      comment: "Total annualized premium equivalent basis for payments"
    - name: "total_nbv_basis"
      expr: SUM(CAST(nbv_basis_amount AS DOUBLE))
      comment: "Total new business value basis for payments"
    - name: "avg_gross_payment"
      expr: AVG(CAST(gross_payment_amount AS DOUBLE))
      comment: "Average gross payment amount per payment"
    - name: "tax_withholding_rate_pct"
      expr: ROUND(100.0 * (SUM(CAST(federal_tax_withheld_amount AS DOUBLE)) + SUM(CAST(state_tax_withheld_amount AS DOUBLE))) / NULLIF(SUM(CAST(gross_payment_amount AS DOUBLE)), 0), 2)
      comment: "Total tax withholding as percentage of gross payment"
    - name: "payment_count"
      expr: COUNT(1)
      comment: "Number of commission payments issued"
    - name: "unique_producers_paid"
      expr: COUNT(DISTINCT producer_id)
      comment: "Number of distinct producers receiving payment"
$$;


CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`commission_chargeback`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Commission chargeback metrics tracking recovery amounts, outstanding balances, and chargeback effectiveness by trigger reason and product"
  source: "`life_insurance_ecm`.`commission`.`chargeback`"
  dimensions:
    - name: "chargeback_status"
      expr: chargeback_status
      comment: "Current status of the chargeback"
    - name: "trigger_reason_code"
      expr: trigger_reason_code
      comment: "Reason code for chargeback trigger (lapse, cancellation, etc.)"
    - name: "product_type"
      expr: product_type
      comment: "Product type for the charged-back policy"
    - name: "distribution_channel"
      expr: distribution_channel
      comment: "Distribution channel of the producer"
    - name: "commission_type"
      expr: commission_type
      comment: "Type of commission being charged back"
    - name: "recovery_method"
      expr: recovery_method
      comment: "Method used to recover chargeback amount"
    - name: "trigger_month"
      expr: DATE_TRUNC('MONTH', trigger_event_date)
      comment: "Month when chargeback was triggered"
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Whether chargeback is under dispute"
    - name: "waiver_flag"
      expr: waiver_flag
      comment: "Whether chargeback was waived"
  measures:
    - name: "total_chargeback_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total chargeback amount assessed"
    - name: "total_recovered_amount"
      expr: SUM(CAST(recovered_amount AS DOUBLE))
      comment: "Total amount successfully recovered from producers"
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total outstanding chargeback balance not yet recovered"
    - name: "total_original_commission"
      expr: SUM(CAST(original_commission_amount AS DOUBLE))
      comment: "Total original commission amount before chargeback"
    - name: "total_dac_adjustment"
      expr: SUM(CAST(dac_adjustment_amount AS DOUBLE))
      comment: "Total deferred acquisition cost adjustment from chargebacks"
    - name: "total_nbv_impact"
      expr: SUM(CAST(nbv_impact_amount AS DOUBLE))
      comment: "Total new business value impact from chargebacks"
    - name: "avg_chargeback_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average chargeback amount per occurrence"
    - name: "recovery_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(recovered_amount AS DOUBLE)) / NULLIF(SUM(CAST(amount AS DOUBLE)), 0), 2)
      comment: "Percentage of chargeback amount successfully recovered"
    - name: "avg_recapture_pct"
      expr: AVG(CAST(recapture_pct AS DOUBLE))
      comment: "Average recapture percentage applied to chargebacks"
    - name: "chargeback_count"
      expr: COUNT(1)
      comment: "Number of chargeback occurrences"
    - name: "unique_producers_charged"
      expr: COUNT(DISTINCT producer_id)
      comment: "Number of distinct producers with chargebacks"
$$;


CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`commission_advance_commission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Commission advance and recovery metrics tracking advance amounts, outstanding balances, recovery performance, and write-off activity"
  source: "`life_insurance_ecm`.`commission`.`advance_commission`"
  dimensions:
    - name: "advance_status"
      expr: advance_status
      comment: "Current status of the commission advance"
    - name: "advance_type"
      expr: advance_type
      comment: "Type of commission advance"
    - name: "product_type"
      expr: product_type
      comment: "Product type for the advanced commission"
    - name: "distribution_channel"
      expr: distribution_channel
      comment: "Distribution channel of the producer"
    - name: "recovery_method"
      expr: recovery_method
      comment: "Method used to recover advance"
    - name: "repayment_schedule_type"
      expr: repayment_schedule_type
      comment: "Type of repayment schedule"
    - name: "advance_month"
      expr: DATE_TRUNC('MONTH', advance_date)
      comment: "Month when advance was issued"
    - name: "chargeback_triggered"
      expr: chargeback_triggered
      comment: "Whether advance triggered a chargeback"
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Whether advance is under dispute"
    - name: "dac_eligible"
      expr: dac_eligible
      comment: "Whether advance is eligible for DAC treatment"
  measures:
    - name: "total_advance_amount"
      expr: SUM(CAST(advance_amount AS DOUBLE))
      comment: "Total commission advance amount issued"
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total outstanding advance balance not yet recovered"
    - name: "total_recovered_amount"
      expr: SUM(CAST(recovered_amount AS DOUBLE))
      comment: "Total amount recovered from producers"
    - name: "total_write_off_amount"
      expr: SUM(CAST(write_off_amount AS DOUBLE))
      comment: "Total advance amount written off as uncollectible"
    - name: "total_fyc_basis"
      expr: SUM(CAST(fyc_basis_amount AS DOUBLE))
      comment: "Total first-year commission basis for advances"
    - name: "total_annualized_premium"
      expr: SUM(CAST(annualized_premium AS DOUBLE))
      comment: "Total annualized premium basis for advances"
    - name: "avg_advance_amount"
      expr: AVG(CAST(advance_amount AS DOUBLE))
      comment: "Average advance amount per occurrence"
    - name: "avg_advance_basis_pct"
      expr: AVG(CAST(advance_basis_pct AS DOUBLE))
      comment: "Average advance percentage of commission basis"
    - name: "recovery_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(recovered_amount AS DOUBLE)) / NULLIF(SUM(CAST(advance_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of advance amount successfully recovered"
    - name: "write_off_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(write_off_amount AS DOUBLE)) / NULLIF(SUM(CAST(advance_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of advance amount written off"
    - name: "advance_count"
      expr: COUNT(1)
      comment: "Number of commission advances issued"
    - name: "unique_producers_advanced"
      expr: COUNT(DISTINCT producer_id)
      comment: "Number of distinct producers receiving advances"
$$;


CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`commission_bonus_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bonus payment metrics tracking gross bonus amounts, tax withholding, net payments, and bonus program effectiveness"
  source: "`life_insurance_ecm`.`commission`.`bonus_payment`"
  dimensions:
    - name: "bonus_type"
      expr: bonus_type
      comment: "Type of bonus payment"
    - name: "payment_status"
      expr: payment_status
      comment: "Current status of the bonus payment"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the bonus payment"
    - name: "payment_method"
      expr: payment_method
      comment: "Method used for bonus payment"
    - name: "bonus_basis"
      expr: bonus_basis
      comment: "Basis used for bonus calculation"
    - name: "payment_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Month when bonus was paid"
    - name: "tax_year"
      expr: tax_year
      comment: "Tax year for bonus reporting"
    - name: "is_1099_reportable"
      expr: is_1099_reportable
      comment: "Whether bonus is reportable on IRS Form 1099"
    - name: "backup_withholding_applied"
      expr: backup_withholding_applied
      comment: "Whether backup withholding was applied"
  measures:
    - name: "total_gross_bonus"
      expr: SUM(CAST(gross_bonus_amount AS DOUBLE))
      comment: "Total gross bonus amount before tax withholding"
    - name: "total_net_payment"
      expr: SUM(CAST(net_payment_amount AS DOUBLE))
      comment: "Total net bonus payment after tax withholding"
    - name: "total_federal_tax_withheld"
      expr: SUM(CAST(federal_tax_withheld AS DOUBLE))
      comment: "Total federal tax withheld from bonus payments"
    - name: "total_state_tax_withheld"
      expr: SUM(CAST(state_tax_withheld AS DOUBLE))
      comment: "Total state tax withheld from bonus payments"
    - name: "total_basis_amount"
      expr: SUM(CAST(basis_amount AS DOUBLE))
      comment: "Total basis amount used for bonus calculation"
    - name: "avg_gross_bonus"
      expr: AVG(CAST(gross_bonus_amount AS DOUBLE))
      comment: "Average gross bonus amount per payment"
    - name: "avg_bonus_rate"
      expr: AVG(CAST(bonus_rate AS DOUBLE))
      comment: "Average bonus rate percentage"
    - name: "bonus_yield_pct"
      expr: ROUND(100.0 * SUM(CAST(gross_bonus_amount AS DOUBLE)) / NULLIF(SUM(CAST(basis_amount AS DOUBLE)), 0), 2)
      comment: "Gross bonus as percentage of basis amount"
    - name: "tax_withholding_rate_pct"
      expr: ROUND(100.0 * (SUM(CAST(federal_tax_withheld AS DOUBLE)) + SUM(CAST(state_tax_withheld AS DOUBLE))) / NULLIF(SUM(CAST(gross_bonus_amount AS DOUBLE)), 0), 2)
      comment: "Total tax withholding as percentage of gross bonus"
    - name: "bonus_payment_count"
      expr: COUNT(1)
      comment: "Number of bonus payments issued"
    - name: "unique_producers_bonused"
      expr: COUNT(DISTINCT producer_id)
      comment: "Number of distinct producers receiving bonus payments"
$$;


CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`commission_statement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Commission statement metrics tracking gross commission, deductions, net payable amounts, and statement delivery performance"
  source: "`life_insurance_ecm`.`commission`.`statement`"
  dimensions:
    - name: "statement_status"
      expr: statement_status
      comment: "Current status of the commission statement"
    - name: "delivery_status"
      expr: delivery_status
      comment: "Delivery status of the statement"
    - name: "delivery_method"
      expr: delivery_method
      comment: "Method used to deliver statement"
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method for commissions on statement"
    - name: "agent_type"
      expr: agent_type
      comment: "Type of agent receiving statement"
    - name: "hierarchy_level"
      expr: hierarchy_level
      comment: "Distribution hierarchy level of producer"
    - name: "statement_month"
      expr: DATE_TRUNC('MONTH', statement_date)
      comment: "Month of statement issuance"
    - name: "tax_year"
      expr: tax_year
      comment: "Tax year for statement"
    - name: "is_1099_reportable"
      expr: is_1099_reportable
      comment: "Whether statement amounts are 1099 reportable"
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Whether statement is under dispute"
  measures:
    - name: "total_gross_commission"
      expr: SUM(CAST(gross_commission_amount AS DOUBLE))
      comment: "Total gross commission amount on statements"
    - name: "total_net_payable"
      expr: SUM(CAST(net_payable_amount AS DOUBLE))
      comment: "Total net payable amount after all deductions"
    - name: "total_fyc_amount"
      expr: SUM(CAST(fyc_amount AS DOUBLE))
      comment: "Total first-year commission amount"
    - name: "total_renewal_commission"
      expr: SUM(CAST(renewal_commission_amount AS DOUBLE))
      comment: "Total renewal commission amount"
    - name: "total_override_commission"
      expr: SUM(CAST(override_commission_amount AS DOUBLE))
      comment: "Total override commission amount"
    - name: "total_bonus_amount"
      expr: SUM(CAST(bonus_amount AS DOUBLE))
      comment: "Total bonus amount on statements"
    - name: "total_service_fee"
      expr: SUM(CAST(service_fee_amount AS DOUBLE))
      comment: "Total service fee amount"
    - name: "total_adjustment_amount"
      expr: SUM(CAST(total_adjustment_amount AS DOUBLE))
      comment: "Total adjustment amount (positive or negative)"
    - name: "total_chargeback_amount"
      expr: SUM(CAST(total_chargeback_amount AS DOUBLE))
      comment: "Total chargeback amount deducted"
    - name: "total_advance_recoupment"
      expr: SUM(CAST(advance_recoupment_amount AS DOUBLE))
      comment: "Total advance recoupment amount deducted"
    - name: "total_withholding"
      expr: SUM(CAST(withholding_amount AS DOUBLE))
      comment: "Total tax withholding amount"
    - name: "total_ytd_gross_commission"
      expr: SUM(CAST(ytd_gross_commission_amount AS DOUBLE))
      comment: "Total year-to-date gross commission"
    - name: "total_ytd_net_paid"
      expr: SUM(CAST(ytd_net_paid_amount AS DOUBLE))
      comment: "Total year-to-date net paid amount"
    - name: "avg_net_payable"
      expr: AVG(CAST(net_payable_amount AS DOUBLE))
      comment: "Average net payable amount per statement"
    - name: "net_payout_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(net_payable_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_commission_amount AS DOUBLE)), 0), 2)
      comment: "Net payable as percentage of gross commission"
    - name: "statement_count"
      expr: COUNT(1)
      comment: "Number of commission statements issued"
    - name: "unique_producers_stated"
      expr: COUNT(DISTINCT producer_id)
      comment: "Number of distinct producers receiving statements"
$$;


CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`commission_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Commission run execution metrics tracking gross commission, deductions, net payable, processing volume, and run performance"
  source: "`life_insurance_ecm`.`commission`.`run`"
  dimensions:
    - name: "run_status"
      expr: run_status
      comment: "Current status of the commission run"
    - name: "run_type"
      expr: run_type
      comment: "Type of commission run (regular, off-cycle, correction, etc.)"
    - name: "frequency"
      expr: frequency
      comment: "Frequency of commission run (monthly, quarterly, etc.)"
    - name: "distribution_channel"
      expr: distribution_channel
      comment: "Distribution channel for the run"
    - name: "product_line"
      expr: product_line
      comment: "Product line processed in the run"
    - name: "payment_release_status"
      expr: payment_release_status
      comment: "Status of payment release for the run"
    - name: "accounting_period"
      expr: accounting_period
      comment: "Accounting period for the run"
    - name: "tax_year"
      expr: tax_year
      comment: "Tax year for the run"
    - name: "is_test_run"
      expr: is_test_run
      comment: "Whether this is a test run"
    - name: "run_month"
      expr: DATE_TRUNC('MONTH', scheduled_run_date)
      comment: "Month of scheduled run date"
  measures:
    - name: "total_gross_commission"
      expr: SUM(CAST(gross_commission_amount AS DOUBLE))
      comment: "Total gross commission amount processed in runs"
    - name: "total_net_payable"
      expr: SUM(CAST(net_payable_amount AS DOUBLE))
      comment: "Total net payable amount after all deductions"
    - name: "total_fyc_amount"
      expr: SUM(CAST(fyc_amount AS DOUBLE))
      comment: "Total first-year commission amount"
    - name: "total_renewal_commission"
      expr: SUM(CAST(renewal_commission_amount AS DOUBLE))
      comment: "Total renewal commission amount"
    - name: "total_override_commission"
      expr: SUM(CAST(override_commission_amount AS DOUBLE))
      comment: "Total override commission amount"
    - name: "total_bonus_incentive"
      expr: SUM(CAST(bonus_incentive_amount AS DOUBLE))
      comment: "Total bonus and incentive amount"
    - name: "total_adjustment_amount"
      expr: SUM(CAST(total_adjustment_amount AS DOUBLE))
      comment: "Total adjustment amount (positive or negative)"
    - name: "total_chargeback_amount"
      expr: SUM(CAST(total_chargeback_amount AS DOUBLE))
      comment: "Total chargeback amount deducted"
    - name: "total_advance_recovery"
      expr: SUM(CAST(advance_recovery_amount AS DOUBLE))
      comment: "Total advance recovery amount"
    - name: "total_tax_withheld"
      expr: SUM(CAST(total_tax_withheld_amount AS DOUBLE))
      comment: "Total tax withheld from payments"
    - name: "total_policies_processed"
      expr: SUM(CAST(policies_processed_count AS BIGINT))
      comment: "Total number of policies processed across runs"
    - name: "total_agents_processed"
      expr: SUM(CAST(agents_processed_count AS BIGINT))
      comment: "Total number of agents processed across runs"
    - name: "total_transactions_generated"
      expr: SUM(CAST(transactions_generated_count AS BIGINT))
      comment: "Total number of transactions generated across runs"
    - name: "total_error_count"
      expr: SUM(CAST(error_count AS BIGINT))
      comment: "Total number of errors encountered in runs"
    - name: "net_payout_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(net_payable_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_commission_amount AS DOUBLE)), 0), 2)
      comment: "Net payable as percentage of gross commission"
    - name: "run_count"
      expr: COUNT(1)
      comment: "Number of commission runs executed"
$$;


CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`commission_hold`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Commission hold metrics tracking held amounts, release performance, write-offs, and hold reason analysis"
  source: "`life_insurance_ecm`.`commission`.`hold`"
  dimensions:
    - name: "hold_status"
      expr: hold_status
      comment: "Current status of the commission hold"
    - name: "hold_type"
      expr: hold_type
      comment: "Type of commission hold (compliance, licensing, documentation, etc.)"
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for the hold"
    - name: "commission_type"
      expr: commission_type
      comment: "Type of commission being held"
    - name: "product_type"
      expr: product_type
      comment: "Product type for the held commission"
    - name: "priority"
      expr: priority
      comment: "Priority level of the hold"
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Whether hold is under dispute"
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether hold has been escalated"
    - name: "producer_notified_flag"
      expr: producer_notified_flag
      comment: "Whether producer has been notified of hold"
    - name: "hold_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month when hold was initiated"
  measures:
    - name: "total_held_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total commission amount currently held"
    - name: "total_released_amount"
      expr: SUM(CAST(released_amount AS DOUBLE))
      comment: "Total commission amount released from hold"
    - name: "total_written_off_amount"
      expr: SUM(CAST(written_off_amount AS DOUBLE))
      comment: "Total commission amount written off from hold"
    - name: "avg_held_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average commission amount per hold"
    - name: "release_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(released_amount AS DOUBLE)) / NULLIF(SUM(CAST(amount AS DOUBLE)), 0), 2)
      comment: "Percentage of held amount successfully released"
    - name: "write_off_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(written_off_amount AS DOUBLE)) / NULLIF(SUM(CAST(amount AS DOUBLE)), 0), 2)
      comment: "Percentage of held amount written off"
    - name: "hold_count"
      expr: COUNT(1)
      comment: "Number of commission holds"
    - name: "unique_producers_held"
      expr: COUNT(DISTINCT producer_id)
      comment: "Number of distinct producers with holds"
$$;


CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`commission_persistency_credit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Persistency credit metrics tracking milestone achievement, credit amounts, and policy retention performance"
  source: "`life_insurance_ecm`.`commission`.`persistency_credit`"
  dimensions:
    - name: "credit_status"
      expr: credit_status
      comment: "Current status of the persistency credit"
    - name: "credit_type"
      expr: credit_type
      comment: "Type of persistency credit"
    - name: "persistency_milestone"
      expr: persistency_milestone
      comment: "Persistency milestone achieved (12-month, 24-month, etc.)"
    - name: "product_type"
      expr: product_type
      comment: "Product type for the persistent policy"
    - name: "distribution_channel"
      expr: distribution_channel
      comment: "Distribution channel of the producer"
    - name: "policy_year"
      expr: policy_year
      comment: "Policy year when credit was earned"
    - name: "calculation_basis"
      expr: calculation_basis
      comment: "Basis used for credit calculation"
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Whether credit is under dispute"
    - name: "tax_reportable_flag"
      expr: tax_reportable_flag
      comment: "Whether credit is tax reportable"
    - name: "milestone_month"
      expr: DATE_TRUNC('MONTH', milestone_evaluation_date)
      comment: "Month when milestone was evaluated"
  measures:
    - name: "total_gross_credit"
      expr: SUM(CAST(gross_credit_amount AS DOUBLE))
      comment: "Total gross persistency credit amount"
    - name: "total_net_credit"
      expr: SUM(CAST(net_credit_amount AS DOUBLE))
      comment: "Total net persistency credit amount after adjustments"
    - name: "total_calculation_basis"
      expr: SUM(CAST(calculation_basis_amount AS DOUBLE))
      comment: "Total basis amount used for credit calculation"
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total adjustment amount applied to credits"
    - name: "total_override_credit"
      expr: SUM(CAST(override_credit_amount AS DOUBLE))
      comment: "Total override credit amount"
    - name: "total_nbv_basis"
      expr: SUM(CAST(nbv_basis_amount AS DOUBLE))
      comment: "Total new business value basis for credits"
    - name: "total_dac_adjustment"
      expr: SUM(CAST(dac_adjustment_amount AS DOUBLE))
      comment: "Total deferred acquisition cost adjustment"
    - name: "avg_credit_rate"
      expr: AVG(CAST(credit_rate AS DOUBLE))
      comment: "Average persistency credit rate percentage"
    - name: "avg_lapse_risk_score"
      expr: AVG(CAST(lapse_risk_score AS DOUBLE))
      comment: "Average lapse risk score for persistent policies"
    - name: "credit_yield_pct"
      expr: ROUND(100.0 * SUM(CAST(gross_credit_amount AS DOUBLE)) / NULLIF(SUM(CAST(calculation_basis_amount AS DOUBLE)), 0), 2)
      comment: "Gross credit as percentage of calculation basis"
    - name: "persistency_credit_count"
      expr: COUNT(1)
      comment: "Number of persistency credits issued"
    - name: "unique_producers_credited"
      expr: COUNT(DISTINCT producer_id)
      comment: "Number of distinct producers earning persistency credits"
$$;
