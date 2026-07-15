-- Metric views for domain: commission | Business: Life Insurance | Version: 1 | Generated on: 2026-05-04 06:54:29

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`commission_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core commission transaction KPIs measuring earned commission volume, rates, advance exposure, and split activity. This is the primary fact table for commission economics and producer payout analysis."
  source: "`life_insurance_ecm`.`commission`.`transaction`"
  dimensions:
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of commission transaction (e.g., FYC, renewal, override, service fee) used to segment commission economics by event category."
    - name: "commission_status"
      expr: transaction_status
      comment: "Current processing status of the commission transaction (e.g., pending, paid, reversed) for pipeline and aging analysis."
    - name: "product_type"
      expr: product_type
      comment: "Product type associated with the commission transaction enabling commission cost analysis by product line."
    - name: "distribution_hierarchy_level"
      expr: hierarchy_level
      comment: "Distribution hierarchy level (e.g., agent, GA, MGA) for commission cost attribution across the distribution structure."
    - name: "policy_year"
      expr: policy_year
      comment: "Policy year of the commission transaction, critical for distinguishing first-year commission (FYC) from renewal commission economics."
    - name: "tax_year"
      expr: tax_year
      comment: "Tax year for 1099 reporting and regulatory compliance segmentation."
    - name: "split_type"
      expr: split_type
      comment: "Type of commission split arrangement (e.g., co-agent, override) for split commission governance analysis."
    - name: "earning_date_month"
      expr: DATE_TRUNC('MONTH', earning_date)
      comment: "Month in which commission was earned, used for trend analysis and accrual period alignment."
    - name: "payment_date_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Month in which commission payment was released, used for cash flow and payment cycle analysis."
    - name: "is_1099_reportable"
      expr: is_1099_reportable
      comment: "Flag indicating whether the transaction is reportable on IRS Form 1099, used for tax compliance segmentation."
  measures:
    - name: "total_gross_commission_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross commission earned across all transactions before deductions. Primary revenue-side KPI for commission cost management and producer compensation analysis."
    - name: "total_net_commission_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net commission paid after chargebacks and adjustments. Represents actual cash outflow for commission expense reporting."
    - name: "total_chargeback_amount"
      expr: SUM(CAST(chargeback_amount AS DOUBLE))
      comment: "Total chargeback amounts applied against commission transactions. Tracks recapture effectiveness and lapse-driven commission recovery."
    - name: "total_advance_outstanding_balance"
      expr: SUM(CAST(advance_outstanding_balance AS DOUBLE))
      comment: "Total outstanding advance commission balances across all transactions. Critical for credit risk and advance recovery monitoring."
    - name: "avg_commission_rate"
      expr: AVG(CAST(commission_rate AS DOUBLE))
      comment: "Average commission rate across transactions. Used to benchmark compensation cost efficiency and detect rate anomalies by product or channel."
    - name: "avg_split_percentage"
      expr: AVG(CAST(split_percentage AS DOUBLE))
      comment: "Average commission split percentage across split transactions. Monitors distribution of commission across co-agents and hierarchy levels."
    - name: "total_calculation_basis_amount"
      expr: SUM(CAST(calculation_basis_amount AS DOUBLE))
      comment: "Total premium or annuity basis on which commissions are calculated. Used to derive effective commission cost ratios against premium volume."
    - name: "net_to_gross_commission_ratio"
      expr: ROUND(100.0 * SUM(CAST(net_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_amount AS DOUBLE)), 0), 2)
      comment: "Ratio of net commission paid to gross commission earned, expressed as a percentage. Measures the impact of chargebacks and deductions on commission payouts — a key efficiency and quality indicator."
    - name: "chargeback_to_gross_commission_ratio"
      expr: ROUND(100.0 * SUM(CAST(chargeback_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_amount AS DOUBLE)), 0), 2)
      comment: "Chargeback amount as a percentage of gross commission. Measures lapse and termination-driven recapture intensity — a leading indicator of policy persistency quality."
    - name: "commission_transaction_count"
      expr: COUNT(1)
      comment: "Total number of commission transactions processed. Used as a volume baseline for per-transaction cost and throughput analysis."
    - name: "distinct_producer_count"
      expr: COUNT(DISTINCT producer_id)
      comment: "Number of distinct producers receiving commission in the period. Measures active distribution footprint and compensation reach."
$$;


CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`commission_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Commission payment disbursement KPIs covering gross and net payout volumes, tax withholding, and payment method distribution. Supports treasury, tax compliance, and producer satisfaction analysis."
  source: "`life_insurance_ecm`.`commission`.`payment`"
  dimensions:
    - name: "payment_type"
      expr: payment_type
      comment: "Type of commission payment (e.g., FYC, renewal, bonus, override) for payment mix and cost attribution analysis."
    - name: "payment_status"
      expr: payment_status
      comment: "Current status of the payment (e.g., pending, issued, returned, voided) for payment cycle and exception management."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment disbursement method (e.g., ACH, check, wire) for treasury operations and payment modernization tracking."
    - name: "payment_date_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Month of payment disbursement for cash flow forecasting and period-over-period payment trend analysis."
    - name: "tax_year"
      expr: tax_year
      comment: "Tax year associated with the payment for 1099 reporting and regulatory compliance."
    - name: "override_level"
      expr: override_level
      comment: "Hierarchy level at which override commission is paid, enabling override cost analysis by distribution tier."
    - name: "chargeback_flag"
      expr: chargeback_flag
      comment: "Indicates whether the payment includes a chargeback component, used to segment clean payments from recovery-impacted disbursements."
    - name: "commission_year"
      expr: commission_year
      comment: "Commission year for multi-year cohort analysis of payout patterns and renewal commission tracking."
    - name: "period_start_month"
      expr: DATE_TRUNC('MONTH', period_start_date)
      comment: "Start of the commission earning period for accrual alignment and period-based payout analysis."
  measures:
    - name: "total_gross_payment_amount"
      expr: SUM(CAST(gross_payment_amount AS DOUBLE))
      comment: "Total gross commission disbursed before tax withholding. Primary cash outflow KPI for commission expense management and budget variance analysis."
    - name: "total_net_payment_amount"
      expr: SUM(CAST(net_payment_amount AS DOUBLE))
      comment: "Total net commission paid after all withholdings. Represents actual producer take-home and is the key treasury cash management metric."
    - name: "total_federal_tax_withheld"
      expr: SUM(CAST(federal_tax_withheld_amount AS DOUBLE))
      comment: "Total federal tax withheld from commission payments. Required for IRS compliance reporting and backup withholding monitoring."
    - name: "total_state_tax_withheld"
      expr: SUM(CAST(state_tax_withheld_amount AS DOUBLE))
      comment: "Total state tax withheld from commission payments. Supports multi-state tax compliance and remittance obligations."
    - name: "total_nbv_basis_amount"
      expr: SUM(CAST(nbv_basis_amount AS DOUBLE))
      comment: "Total new business value basis used for commission calculation. Links commission cost to new business production value for profitability analysis."
    - name: "total_annualized_premium_equivalent"
      expr: SUM(CAST(annualized_premium_equivalent AS DOUBLE))
      comment: "Total annualized premium equivalent (APE) associated with commission payments. Standard industry production metric for benchmarking commission cost as a percentage of APE."
    - name: "commission_cost_as_pct_of_ape"
      expr: ROUND(100.0 * SUM(CAST(gross_payment_amount AS DOUBLE)) / NULLIF(SUM(CAST(annualized_premium_equivalent AS DOUBLE)), 0), 2)
      comment: "Gross commission paid as a percentage of annualized premium equivalent. Industry-standard KPI for measuring distribution cost efficiency — directly used in pricing and profitability reviews."
    - name: "effective_withholding_rate"
      expr: ROUND(100.0 * SUM(CAST(federal_tax_withheld_amount AS DOUBLE) + CAST(state_tax_withheld_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_payment_amount AS DOUBLE)), 0), 2)
      comment: "Combined federal and state tax withholding as a percentage of gross payment. Monitors withholding compliance and flags anomalies in backup withholding application."
    - name: "payment_count"
      expr: COUNT(1)
      comment: "Total number of commission payments issued. Volume baseline for payment operations throughput and per-payment cost analysis."
    - name: "distinct_payee_count"
      expr: COUNT(DISTINCT payee_id)
      comment: "Number of distinct payees receiving commission payments. Measures active compensation reach and supports payee master data governance."
$$;


CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`commission_chargeback`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Commission chargeback KPIs tracking recapture volumes, recovery rates, outstanding balances, and NBV impact. Critical for lapse management, distribution quality, and DAC asset governance."
  source: "`life_insurance_ecm`.`commission`.`chargeback`"
  dimensions:
    - name: "chargeback_status"
      expr: chargeback_status
      comment: "Current status of the chargeback (e.g., initiated, recovered, waived, disputed) for pipeline and resolution tracking."
    - name: "trigger_reason_code"
      expr: trigger_reason_code
      comment: "Root cause code triggering the chargeback (e.g., lapse, surrender, death claim) for cause-of-chargeback analysis and distribution quality management."
    - name: "product_type"
      expr: product_type
      comment: "Product type associated with the chargeback for product-level lapse and recapture analysis."
    - name: "distribution_channel"
      expr: distribution_channel
      comment: "Distribution channel of the original sale for channel-level chargeback rate benchmarking."
    - name: "distribution_tier"
      expr: distribution_tier
      comment: "Distribution tier (e.g., GA, MGA, direct) for hierarchy-level chargeback attribution."
    - name: "commission_type"
      expr: commission_type
      comment: "Type of commission subject to chargeback (e.g., FYC, advance) for chargeback composition analysis."
    - name: "recovery_method"
      expr: recovery_method
      comment: "Method used to recover chargeback (e.g., offset, installment, direct payment) for recovery operations analysis."
    - name: "waiver_flag"
      expr: waiver_flag
      comment: "Indicates whether the chargeback was waived, used to monitor waiver frequency and financial impact on recapture."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Indicates whether the chargeback is under dispute, used for dispute resolution pipeline management."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the chargeback became effective for trend analysis of lapse-driven recapture activity."
    - name: "hierarchy_level"
      expr: hierarchy_level
      comment: "Hierarchy level at which the chargeback is assessed for distribution-level quality and accountability analysis."
  measures:
    - name: "total_chargeback_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total commission chargeback amount initiated. Primary KPI for measuring the financial scale of commission recapture obligations driven by policy lapses and terminations."
    - name: "total_recovered_amount"
      expr: SUM(CAST(recovered_amount AS DOUBLE))
      comment: "Total commission successfully recovered from producers. Measures recapture effectiveness and cash recovery from the chargeback portfolio."
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total unrecovered chargeback balance outstanding. A key credit risk and balance sheet exposure metric for commission receivables."
    - name: "total_nbv_impact_amount"
      expr: SUM(CAST(nbv_impact_amount AS DOUBLE))
      comment: "Total new business value impact from chargebacks. Quantifies how lapse-driven recaptures erode the new business value of the in-force portfolio."
    - name: "total_dac_adjustment_amount"
      expr: SUM(CAST(dac_adjustment_amount AS DOUBLE))
      comment: "Total deferred acquisition cost (DAC) adjustment triggered by chargebacks. Required for actuarial and financial reporting under GAAP/IFRS 17."
    - name: "total_original_commission_amount"
      expr: SUM(CAST(original_commission_amount AS DOUBLE))
      comment: "Total original commission paid that is now subject to chargeback. Provides the gross exposure baseline for recapture rate calculation."
    - name: "chargeback_recovery_rate"
      expr: ROUND(100.0 * SUM(CAST(recovered_amount AS DOUBLE)) / NULLIF(SUM(CAST(amount AS DOUBLE)), 0), 2)
      comment: "Percentage of chargeback amount successfully recovered. Core KPI for evaluating recapture program effectiveness and producer credit quality."
    - name: "avg_recapture_percentage"
      expr: AVG(CAST(recapture_pct AS DOUBLE))
      comment: "Average recapture percentage applied across chargebacks. Benchmarks recapture schedule aggressiveness and policy duration mix."
    - name: "chargeback_count"
      expr: COUNT(1)
      comment: "Total number of chargeback events initiated. Volume indicator for lapse activity and distribution quality monitoring."
    - name: "distinct_producer_chargeback_count"
      expr: COUNT(DISTINCT producer_id)
      comment: "Number of distinct producers with active chargebacks. Identifies concentration of chargeback risk within the distribution force."
$$;


CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`commission_statement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Commission statement KPIs providing a producer-level view of gross earnings, net payouts, adjustments, and YTD performance. Supports producer compensation governance, dispute management, and 1099 tax reporting."
  source: "`life_insurance_ecm`.`commission`.`statement`"
  dimensions:
    - name: "statement_status"
      expr: statement_status
      comment: "Current status of the commission statement (e.g., draft, approved, delivered, disputed) for statement lifecycle management."
    - name: "agent_type"
      expr: agent_type
      comment: "Type of agent receiving the statement (e.g., captive, independent, broker-dealer) for channel-level compensation analysis."
    - name: "delivery_method"
      expr: delivery_method
      comment: "Method used to deliver the statement (e.g., email, portal, mail) for digital adoption and delivery cost analysis."
    - name: "delivery_status"
      expr: delivery_status
      comment: "Delivery status of the statement for SLA compliance and producer communication quality monitoring."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method associated with the statement for treasury and payment modernization analysis."
    - name: "frequency"
      expr: frequency
      comment: "Statement frequency (e.g., weekly, bi-weekly, monthly) for payment cycle and operational cadence analysis."
    - name: "hierarchy_level"
      expr: hierarchy_level
      comment: "Distribution hierarchy level of the statement recipient for compensation cost attribution across the distribution structure."
    - name: "is_1099_reportable"
      expr: is_1099_reportable
      comment: "Flag indicating whether the statement is subject to 1099 reporting for tax compliance segmentation."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Indicates whether the statement is under dispute, used for dispute resolution pipeline and producer relations management."
    - name: "statement_date_month"
      expr: DATE_TRUNC('MONTH', statement_date)
      comment: "Month of statement issuance for period-over-period compensation trend analysis."
    - name: "tax_year"
      expr: tax_year
      comment: "Tax year for 1099 compliance and annual compensation reporting."
  measures:
    - name: "total_gross_commission_amount"
      expr: SUM(CAST(gross_commission_amount AS DOUBLE))
      comment: "Total gross commission on statements before deductions. Primary compensation cost KPI for distribution expense management and budget variance reporting."
    - name: "total_net_payable_amount"
      expr: SUM(CAST(net_payable_amount AS DOUBLE))
      comment: "Total net amount payable to producers after all deductions. Represents actual cash disbursement obligation and is the key treasury planning metric."
    - name: "total_fyc_amount"
      expr: SUM(CAST(fyc_amount AS DOUBLE))
      comment: "Total first-year commission (FYC) on statements. Core new business production cost metric used in pricing, profitability, and DAC capitalization analysis."
    - name: "total_renewal_commission_amount"
      expr: SUM(CAST(renewal_commission_amount AS DOUBLE))
      comment: "Total renewal commission on statements. Measures the in-force book's ongoing commission cost and persistency-driven compensation obligations."
    - name: "total_bonus_amount"
      expr: SUM(CAST(bonus_amount AS DOUBLE))
      comment: "Total bonus commission on statements. Tracks incentive program cost and its contribution to total compensation expense."
    - name: "total_override_commission_amount"
      expr: SUM(CAST(override_commission_amount AS DOUBLE))
      comment: "Total override commission on statements. Measures the cost of hierarchical override arrangements across the distribution structure."
    - name: "total_chargeback_amount"
      expr: SUM(CAST(total_chargeback_amount AS DOUBLE))
      comment: "Total chargeback deductions on statements. Tracks recapture impact on producer net pay and statement-level chargeback exposure."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(total_adjustment_amount AS DOUBLE))
      comment: "Total commission adjustments on statements. Monitors correction volume and financial impact of post-calculation adjustments."
    - name: "total_withholding_amount"
      expr: SUM(CAST(withholding_amount AS DOUBLE))
      comment: "Total tax withholding on statements. Required for IRS backup withholding compliance and state tax remittance reporting."
    - name: "total_ytd_gross_commission"
      expr: SUM(CAST(ytd_gross_commission_amount AS DOUBLE))
      comment: "Total year-to-date gross commission across all statements. Provides cumulative compensation cost view for annual budget tracking and 1099 preparation."
    - name: "net_to_gross_payout_ratio"
      expr: ROUND(100.0 * SUM(CAST(net_payable_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_commission_amount AS DOUBLE)), 0), 2)
      comment: "Net payable as a percentage of gross commission on statements. Measures the combined impact of chargebacks, adjustments, and withholdings on producer take-home — a key compensation quality indicator."
    - name: "statement_count"
      expr: COUNT(1)
      comment: "Total number of commission statements issued. Volume baseline for statement operations throughput and per-statement processing cost analysis."
    - name: "distinct_producer_count"
      expr: COUNT(DISTINCT producer_id)
      comment: "Number of distinct producers receiving statements. Measures active compensation reach and supports producer master data governance."
$$;


CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`commission_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Commission run execution KPIs measuring processing throughput, financial totals, error rates, and payment release performance. Supports operations management, financial close, and run quality governance."
  source: "`life_insurance_ecm`.`commission`.`run`"
  filter: is_test_run = False
  dimensions:
    - name: "run_type"
      expr: run_type
      comment: "Type of commission run (e.g., regular, off-cycle, adjustment, bonus) for run mix and operational cadence analysis."
    - name: "run_status"
      expr: run_status
      comment: "Current status of the commission run (e.g., scheduled, in-progress, completed, failed) for operational pipeline monitoring."
    - name: "payment_release_status"
      expr: payment_release_status
      comment: "Status of payment release for the run (e.g., held, released, partial) for treasury and payment operations management."
    - name: "distribution_channel"
      expr: distribution_channel
      comment: "Distribution channel processed in the run for channel-level commission cost and throughput analysis."
    - name: "product_line"
      expr: product_line
      comment: "Product line processed in the run for product-level commission cost attribution."
    - name: "frequency"
      expr: frequency
      comment: "Run frequency (e.g., weekly, monthly) for payment cycle and operational cadence analysis."
    - name: "accounting_period"
      expr: accounting_period
      comment: "Accounting period of the run for financial close alignment and period-based commission expense reporting."
    - name: "tax_year"
      expr: tax_year
      comment: "Tax year of the run for annual compensation reporting and 1099 preparation."
    - name: "period_start_month"
      expr: DATE_TRUNC('MONTH', period_start_date)
      comment: "Start month of the commission earning period for trend analysis and accrual alignment."
  measures:
    - name: "total_gross_commission_amount"
      expr: SUM(CAST(gross_commission_amount AS DOUBLE))
      comment: "Total gross commission calculated across all runs. Primary financial close KPI for commission expense recognition and budget variance reporting."
    - name: "total_net_payable_amount"
      expr: SUM(CAST(net_payable_amount AS DOUBLE))
      comment: "Total net commission payable after all deductions across runs. Key treasury cash management metric for payment release planning."
    - name: "total_fyc_amount"
      expr: SUM(CAST(fyc_amount AS DOUBLE))
      comment: "Total first-year commission calculated in runs. Core new business production cost metric for pricing and DAC capitalization."
    - name: "total_renewal_commission_amount"
      expr: SUM(CAST(renewal_commission_amount AS DOUBLE))
      comment: "Total renewal commission calculated in runs. Measures ongoing in-force book commission cost and persistency-driven compensation."
    - name: "total_override_commission_amount"
      expr: SUM(CAST(override_commission_amount AS DOUBLE))
      comment: "Total override commission calculated in runs. Tracks hierarchical override cost across the distribution structure."
    - name: "total_bonus_incentive_amount"
      expr: SUM(CAST(bonus_incentive_amount AS DOUBLE))
      comment: "Total bonus and incentive commission calculated in runs. Measures incentive program cost and its contribution to total compensation expense."
    - name: "total_chargeback_amount"
      expr: SUM(CAST(total_chargeback_amount AS DOUBLE))
      comment: "Total chargeback amounts processed in runs. Tracks recapture volume and its offset against gross commission expense."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(total_adjustment_amount AS DOUBLE))
      comment: "Total adjustment amounts processed in runs. Monitors correction volume and financial impact of post-calculation adjustments on run totals."
    - name: "total_advance_recovery_amount"
      expr: SUM(CAST(advance_recovery_amount AS DOUBLE))
      comment: "Total advance commission recovered in runs. Tracks repayment of advance commission obligations and reduces net payable exposure."
    - name: "total_tax_withheld_amount"
      expr: SUM(CAST(total_tax_withheld_amount AS DOUBLE))
      comment: "Total tax withheld across all runs. Required for IRS and state tax remittance compliance and backup withholding monitoring."
    - name: "run_count"
      expr: COUNT(1)
      comment: "Total number of commission runs executed. Volume baseline for operations throughput and run frequency governance."
$$;


CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`commission_adjustment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Commission adjustment KPIs measuring correction volumes, financial impact, DAC effects, and NBV impact. Supports financial control, audit governance, and commission accuracy management."
  source: "`life_insurance_ecm`.`commission`.`adjustment`"
  dimensions:
    - name: "adjustment_type"
      expr: adjustment_type
      comment: "Type of commission adjustment (e.g., rate correction, split change, reversal) for adjustment cause analysis and financial control."
    - name: "adjustment_status"
      expr: adjustment_status
      comment: "Current status of the adjustment (e.g., pending, approved, processed, reversed) for adjustment pipeline management."
    - name: "commission_type"
      expr: commission_type
      comment: "Type of commission being adjusted (e.g., FYC, renewal, override) for adjustment impact analysis by commission category."
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for the adjustment for root cause analysis and process improvement targeting."
    - name: "distribution_channel"
      expr: distribution_channel
      comment: "Distribution channel of the adjusted commission for channel-level adjustment rate benchmarking."
    - name: "product_type"
      expr: product_type
      comment: "Product type associated with the adjustment for product-level commission accuracy analysis."
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Indicates whether the adjustment is a reversal of a prior transaction, used to measure reversal frequency and financial impact."
    - name: "direction"
      expr: direction
      comment: "Direction of the adjustment (e.g., increase, decrease) for net financial impact analysis."
    - name: "hierarchy_level"
      expr: hierarchy_level
      comment: "Distribution hierarchy level of the adjustment for attribution across the distribution structure."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the adjustment became effective for trend analysis of correction activity."
    - name: "accounting_period"
      expr: accounting_period
      comment: "Accounting period of the adjustment for financial close and period-based correction reporting."
  measures:
    - name: "total_adjustment_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total financial amount of commission adjustments. Primary KPI for measuring the scale of post-calculation corrections and their impact on commission expense."
    - name: "total_adjusted_commission_amount"
      expr: SUM(CAST(adjusted_commission_amount AS DOUBLE))
      comment: "Total adjusted commission amount after correction. Represents the corrected commission obligation and is used to reconcile against original calculations."
    - name: "total_original_commission_amount"
      expr: SUM(CAST(original_commission_amount AS DOUBLE))
      comment: "Total original commission amount before adjustment. Provides the pre-correction baseline for measuring adjustment magnitude and accuracy rates."
    - name: "total_dac_adjustment_amount"
      expr: SUM(CAST(dac_adjustment_amount AS DOUBLE))
      comment: "Total DAC asset adjustment triggered by commission adjustments. Required for actuarial and financial reporting under GAAP/IFRS 17 DAC amortization."
    - name: "total_nbv_impact_amount"
      expr: SUM(CAST(nbv_impact_amount AS DOUBLE))
      comment: "Total new business value impact from commission adjustments. Quantifies how corrections affect the reported new business value of the in-force portfolio."
    - name: "total_tax_withholding_amount"
      expr: SUM(CAST(tax_withholding_amount AS DOUBLE))
      comment: "Total tax withholding adjustments. Supports tax compliance reconciliation and backup withholding correction monitoring."
    - name: "adjustment_to_original_commission_ratio"
      expr: ROUND(100.0 * SUM(CAST(amount AS DOUBLE)) / NULLIF(SUM(CAST(original_commission_amount AS DOUBLE)), 0), 2)
      comment: "Adjustment amount as a percentage of original commission. Measures commission calculation accuracy — a high ratio signals systemic calculation errors or data quality issues requiring process intervention."
    - name: "avg_adjusted_commission_rate"
      expr: AVG(CAST(adjusted_commission_rate AS DOUBLE))
      comment: "Average commission rate after adjustment. Used to detect systematic rate correction patterns and benchmark against scheduled rates."
    - name: "adjustment_count"
      expr: COUNT(1)
      comment: "Total number of commission adjustments processed. Volume indicator for commission calculation quality and operational correction workload."
    - name: "reversal_count"
      expr: SUM(CASE WHEN reversal_flag = True THEN 1 ELSE 0 END)
      comment: "Number of adjustments that are reversals of prior transactions. Measures reversal frequency as an indicator of commission processing quality and error rates."
$$;


CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`commission_bonus_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bonus payment KPIs measuring incentive program payout volumes, tax withholding, and payment quality. Supports incentive program ROI analysis, tax compliance, and producer motivation management."
  source: "`life_insurance_ecm`.`commission`.`payment`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Current status of the bonus payment (e.g., pending, issued, returned) for payment pipeline and exception management."
    - name: "payment_method"
      expr: payment_method
      comment: "Disbursement method for the bonus payment for treasury operations and payment modernization tracking."
    - name: "payment_date_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Month of bonus payment disbursement for cash flow forecasting and incentive program timing analysis."
    - name: "tax_year"
      expr: tax_year
      comment: "Tax year for 1099 reporting and annual bonus compensation reporting."
  measures:
    - name: "total_net_payment_amount"
      expr: SUM(CAST(net_payment_amount AS DOUBLE))
      comment: "Total net bonus paid after tax withholding. Represents actual producer take-home from incentive programs and is the key treasury disbursement metric."
    - name: "bonus_payment_count"
      expr: COUNT(1)
      comment: "Total number of bonus payments issued. Volume baseline for incentive program reach and payment operations throughput."
$$;


CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`commission_bonus_qualification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bonus qualification KPIs measuring producer attainment against incentive thresholds, qualification rates, and production gaps. Supports incentive program design, producer coaching, and sales management."
  source: "`life_insurance_ecm`.`commission`.`bonus_qualification`"
  dimensions:
    - name: "qualification_status"
      expr: qualification_status
      comment: "Current qualification status (e.g., qualified, pending, disqualified) for incentive program pipeline and attainment analysis."
    - name: "bonus_tier"
      expr: bonus_tier
      comment: "Bonus tier achieved by the producer for tiered incentive program cost and attainment distribution analysis."
    - name: "channel_type"
      expr: channel_type
      comment: "Distribution channel type for channel-level qualification rate benchmarking and incentive program effectiveness analysis."
    - name: "product_line"
      expr: product_line
      comment: "Product line associated with the qualification for product-level production attainment analysis."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Indicates whether the qualification is under dispute for dispute resolution pipeline management."
    - name: "all_thresholds_met"
      expr: all_thresholds_met
      comment: "Indicates whether all qualification thresholds were met, used to segment fully qualified producers from partial attainment."
    - name: "manual_adjustment_flag"
      expr: manual_adjustment_flag
      comment: "Indicates whether a manual adjustment was applied to the qualification for governance and audit monitoring."
    - name: "period_start_month"
      expr: DATE_TRUNC('MONTH', period_start_date)
      comment: "Start month of the qualification period for trend analysis of incentive program attainment over time."
    - name: "as_of_date_month"
      expr: DATE_TRUNC('MONTH', as_of_date)
      comment: "Month of the qualification snapshot for point-in-time attainment analysis and mid-period coaching interventions."
  measures:
    - name: "total_cumulative_ape"
      expr: SUM(CAST(cumulative_ape AS DOUBLE))
      comment: "Total cumulative annualized premium equivalent (APE) produced by qualifying producers. Primary production volume KPI for incentive program attainment and sales performance management."
    - name: "total_cumulative_nbv"
      expr: SUM(CAST(cumulative_nbv AS DOUBLE))
      comment: "Total cumulative new business value produced by qualifying producers. Links production volume to value creation for incentive program ROI analysis."
    - name: "total_estimated_bonus_amount"
      expr: SUM(CAST(estimated_bonus_amount AS DOUBLE))
      comment: "Total estimated bonus liability for qualifying producers. Used for incentive program accrual, budget forecasting, and financial close preparation."
    - name: "avg_ape_attainment_pct"
      expr: AVG(CAST(ape_attainment_pct AS DOUBLE))
      comment: "Average APE attainment percentage across qualifying producers. Measures how close the distribution force is to incentive thresholds — a key sales management and coaching metric."
    - name: "total_ape_gap_to_threshold"
      expr: SUM(CAST(ape_gap_to_threshold AS DOUBLE))
      comment: "Total APE gap remaining for producers to reach qualification thresholds. Quantifies the incremental production opportunity and informs targeted sales coaching interventions."
    - name: "avg_persistency_rate"
      expr: AVG(CAST(persistency_rate AS DOUBLE))
      comment: "Average persistency rate across qualifying producers. Measures policy retention quality as a qualification criterion and leading indicator of chargeback risk."
    - name: "qualification_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN qualification_status = 'QUALIFIED' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of producers who achieved full qualification. Core incentive program effectiveness KPI — a low rate signals threshold calibration issues or production shortfalls requiring management action."
    - name: "qualification_count"
      expr: COUNT(1)
      comment: "Total number of bonus qualification records. Volume baseline for incentive program participation and producer engagement analysis."
    - name: "distinct_qualified_producer_count"
      expr: COUNT(DISTINCT CASE WHEN qualification_status = 'QUALIFIED' THEN producer_id END)
      comment: "Number of distinct producers who achieved full qualification. Measures incentive program reach and the breadth of the qualified distribution force."
$$;


CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`commission_override`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Override commission KPIs measuring hierarchical override volumes, rates, and eligibility. Supports distribution cost management, hierarchy governance, and override program ROI analysis."
  source: "`life_insurance_ecm`.`commission`.`override_commission`"
  dimensions:
    - name: "commission_status"
      expr: commission_status
      comment: "Current status of the override commission (e.g., pending, paid, reversed) for pipeline and payment cycle management."
    - name: "commission_type"
      expr: commission_type
      comment: "Type of override commission (e.g., production override, persistency override) for override cost attribution by category."
    - name: "override_level"
      expr: override_level
      comment: "Hierarchy level at which the override is paid (e.g., GA, MGA, SGA) for distribution tier cost analysis."
    - name: "product_type"
      expr: product_type
      comment: "Product type associated with the override for product-level override cost analysis."
    - name: "is_eligible"
      expr: is_eligible
      comment: "Indicates whether the override is eligible for payment, used to monitor eligibility compliance and licensing verification."
    - name: "licensing_verified"
      expr: licensing_verified
      comment: "Indicates whether producer licensing was verified before override payment, critical for regulatory compliance monitoring."
    - name: "tax_reportable"
      expr: tax_reportable
      comment: "Indicates whether the override is tax reportable for 1099 compliance segmentation."
    - name: "policy_year"
      expr: policy_year
      comment: "Policy year of the underlying policy for distinguishing first-year from renewal override economics."
    - name: "accounting_period"
      expr: accounting_period
      comment: "Accounting period of the override for financial close and period-based override expense reporting."
    - name: "commission_event_date_month"
      expr: DATE_TRUNC('MONTH', commission_event_date)
      comment: "Month of the commission event triggering the override for trend analysis of override activity."
  measures:
    - name: "total_override_amount"
      expr: SUM(CAST(override_amount AS DOUBLE))
      comment: "Total override commission earned. Primary KPI for measuring the cost of hierarchical override arrangements and their contribution to total distribution expense."
    - name: "total_net_override_amount"
      expr: SUM(CAST(net_override_amount AS DOUBLE))
      comment: "Total net override commission after chargebacks. Represents actual override cash outflow and is the key treasury metric for override disbursements."
    - name: "total_base_commission_amount"
      expr: SUM(CAST(base_commission_amount AS DOUBLE))
      comment: "Total base commission on which overrides are calculated. Provides the production basis for computing override cost as a percentage of base commission."
    - name: "total_chargeback_amount"
      expr: SUM(CAST(chargeback_amount AS DOUBLE))
      comment: "Total chargeback amounts applied against override commissions. Tracks recapture impact on override payouts."
    - name: "total_nbv_amount"
      expr: SUM(CAST(nbv_amount AS DOUBLE))
      comment: "Total new business value associated with override commissions. Links override cost to value creation for override program ROI analysis."
    - name: "total_annualized_premium"
      expr: SUM(CAST(annualized_premium AS DOUBLE))
      comment: "Total annualized premium associated with override commissions. Used to compute override cost as a percentage of APE for distribution cost benchmarking."
    - name: "avg_override_percentage"
      expr: AVG(CAST(override_percentage AS DOUBLE))
      comment: "Average override percentage applied. Benchmarks override rate generosity and detects rate anomalies across hierarchy levels and programs."
    - name: "override_to_base_commission_ratio"
      expr: ROUND(100.0 * SUM(CAST(override_amount AS DOUBLE)) / NULLIF(SUM(CAST(base_commission_amount AS DOUBLE)), 0), 2)
      comment: "Override commission as a percentage of base commission. Measures the hierarchical override cost burden relative to direct agent compensation — a key distribution cost efficiency metric."
    - name: "override_commission_count"
      expr: COUNT(1)
      comment: "Total number of override commission records. Volume baseline for override program activity and hierarchy engagement analysis."
    - name: "distinct_override_producer_count"
      expr: COUNT(DISTINCT producer_id)
      comment: "Number of distinct producers receiving override commissions. Measures the breadth of the override-eligible distribution hierarchy."
$$;


CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`commission_compensation_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compensation contract KPIs measuring contract portfolio health, rate structures, advance exposure, and compliance status. Supports distribution governance, contract lifecycle management, and regulatory compliance."
  source: "`life_insurance_ecm`.`commission`.`compensation_contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Current status of the compensation contract (e.g., active, terminated, suspended) for contract portfolio health monitoring."
    - name: "contract_type"
      expr: contract_type
      comment: "Type of compensation contract (e.g., agent, GA, broker-dealer) for contract mix and distribution structure analysis."
    - name: "distribution_channel"
      expr: distribution_channel
      comment: "Distribution channel of the contract for channel-level contract portfolio and rate structure analysis."
    - name: "product_line"
      expr: product_line
      comment: "Product line covered by the contract for product-level compensation structure analysis."
    - name: "hierarchy_level"
      expr: hierarchy_level
      comment: "Distribution hierarchy level of the contract for tier-level compensation governance."
    - name: "compensation_basis"
      expr: compensation_basis
      comment: "Basis for commission calculation (e.g., target premium, APE, face amount) for compensation structure analysis."
    - name: "advance_eligible"
      expr: advance_eligible
      comment: "Indicates whether the contract allows advance commission, used to monitor advance program exposure and eligibility."
    - name: "bonus_eligible"
      expr: bonus_eligible
      comment: "Indicates whether the contract is eligible for bonus programs for incentive program reach analysis."
    - name: "tax_reportable"
      expr: tax_reportable
      comment: "Indicates whether the contract is subject to tax reporting for 1099 compliance segmentation."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the contract became effective for contract vintage and cohort analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the contract for governance and authorization workflow monitoring."
  measures:
    - name: "avg_fyc_rate"
      expr: AVG(CAST(fyc_rate AS DOUBLE))
      comment: "Average first-year commission rate across active contracts. Benchmarks FYC rate generosity and detects rate anomalies across channels and product lines — directly impacts pricing and profitability."
    - name: "avg_renewal_commission_rate"
      expr: AVG(CAST(renewal_commission_rate AS DOUBLE))
      comment: "Average renewal commission rate across contracts. Measures ongoing in-force commission cost structure and its impact on long-term profitability."
    - name: "avg_override_rate"
      expr: AVG(CAST(override_rate AS DOUBLE))
      comment: "Average override commission rate across contracts. Benchmarks hierarchical override cost and detects rate anomalies across distribution tiers."
    - name: "avg_advance_rate"
      expr: AVG(CAST(advance_rate AS DOUBLE))
      comment: "Average advance commission rate for advance-eligible contracts. Monitors advance program generosity and its impact on advance recovery risk."
    - name: "active_contract_count"
      expr: SUM(CASE WHEN contract_status = 'ACTIVE' THEN 1 ELSE 0 END)
      comment: "Number of active compensation contracts. Measures the size of the active distribution force under contract and is a key distribution capacity metric."
    - name: "advance_eligible_contract_count"
      expr: SUM(CASE WHEN advance_eligible = True THEN 1 ELSE 0 END)
      comment: "Number of contracts eligible for advance commission. Quantifies advance program exposure and the population at risk for advance recovery obligations."
    - name: "contract_count"
      expr: COUNT(1)
      comment: "Total number of compensation contracts. Volume baseline for distribution force size and contract portfolio management."
    - name: "distinct_producer_count"
      expr: COUNT(DISTINCT producer_id)
      comment: "Number of distinct producers under compensation contract. Measures active distribution force size and supports producer master data governance."
$$;
