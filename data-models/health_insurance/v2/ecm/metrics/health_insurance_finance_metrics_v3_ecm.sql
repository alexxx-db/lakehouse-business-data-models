-- Metric views for domain: finance | Business: Health_Insurance | Version: 3 | Generated on: 2026-07-10 20:04:11

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`finance_premium_revenue`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for premium revenue performance — earned premium, net earned premium, written premium, reinsurance ceded, and risk-adjusted revenue metrics. Core financial steering metrics for health plan profitability."
  source: "`vibe_health_insurance_v1`.`finance`.`premium_revenue`"
  dimensions:
    - name: "accounting_period"
      expr: accounting_period
      comment: "Accounting period (e.g., 2024-01) for period-over-period revenue trending."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual revenue reporting and board-level comparisons."
    - name: "fiscal_month"
      expr: fiscal_month
      comment: "Fiscal month for monthly revenue cadence analysis."
    - name: "line_of_business"
      expr: lob
      comment: "Line of business (e.g., Commercial, Medicare, Medicaid) for revenue segmentation by product line."
    - name: "market_segment"
      expr: market_segment
      comment: "Market segment (e.g., Individual, Small Group, Large Group) for revenue mix analysis."
    - name: "premium_type"
      expr: premium_type
      comment: "Type of premium (e.g., standard, COBRA, continuation) for revenue composition analysis."
    - name: "is_capitated"
      expr: is_capitated
      comment: "Flag indicating capitated vs. fee-for-service revenue model for payment model mix analysis."
    - name: "mlr_denominator_flag"
      expr: mlr_denominator_flag
      comment: "Flag indicating whether the premium record is included in MLR denominator for regulatory compliance tracking."
    - name: "revenue_date"
      expr: DATE_TRUNC('month', revenue_date)
      comment: "Revenue recognition date truncated to month for time-series analysis."
    - name: "premium_revenue_status"
      expr: premium_revenue_status
      comment: "Status of the premium revenue record for filtering active vs. voided entries."
  measures:
    - name: "total_written_premium"
      expr: SUM(CAST(written_premium AS DOUBLE))
      comment: "Total written premium — the gross premium billed before any adjustments. Core top-line revenue metric for executive dashboards and board reporting."
    - name: "total_earned_premium"
      expr: SUM(CAST(earned_premium AS DOUBLE))
      comment: "Total earned premium — premium recognized as revenue for the coverage period. Primary revenue KPI for P&L reporting and MLR denominator."
    - name: "total_net_earned_premium"
      expr: SUM(CAST(net_earned_premium AS DOUBLE))
      comment: "Total net earned premium after reinsurance ceded — the retained revenue base for profitability analysis."
    - name: "total_reinsurance_ceded_premium"
      expr: SUM(CAST(reinsurance_ceded_premium AS DOUBLE))
      comment: "Total premium ceded to reinsurers — measures risk transfer cost and reinsurance program utilization."
    - name: "total_capitation_amount"
      expr: SUM(CAST(capitation_amount AS DOUBLE))
      comment: "Total capitation payments made to providers — key metric for capitated payment model financial management."
    - name: "total_unearned_premium_reserve"
      expr: SUM(CAST(unearned_premium_reserve AS DOUBLE))
      comment: "Total unearned premium reserve — liability for coverage not yet delivered. Critical for balance sheet accuracy and regulatory solvency reporting."
    - name: "total_risk_corridor_adjustment"
      expr: SUM(CAST(risk_corridor_adjustment AS DOUBLE))
      comment: "Total ACA risk corridor adjustments — measures regulatory risk-sharing program impact on net revenue."
    - name: "total_vbc_shared_savings"
      expr: SUM(CAST(vbc_shared_savings_amount AS DOUBLE))
      comment: "Total value-based care shared savings amounts — tracks VBC program financial performance and provider incentive payouts."
    - name: "avg_risk_adjustment_factor"
      expr: AVG(CAST(risk_adjustment_factor AS DOUBLE))
      comment: "Average risk adjustment factor across the premium portfolio — indicates population health acuity and ACA risk adjustment program impact."
    - name: "reinsurance_cession_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(reinsurance_ceded_premium AS DOUBLE)) / NULLIF(SUM(CAST(written_premium AS DOUBLE)), 0), 2)
      comment: "Percentage of written premium ceded to reinsurers — measures reinsurance program scale and risk transfer efficiency."
    - name: "net_retention_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(net_earned_premium AS DOUBLE)) / NULLIF(SUM(CAST(earned_premium AS DOUBLE)), 0), 2)
      comment: "Net premium retention rate after reinsurance — key indicator of how much earned revenue the organization retains vs. cedes."
    - name: "premium_tax_base_total"
      expr: SUM(CAST(premium_tax_base AS DOUBLE))
      comment: "Total premium tax base — used for state premium tax liability calculations and regulatory filings."
    - name: "deficiency_reserve_total"
      expr: SUM(CAST(deficiency_reserve AS DOUBLE))
      comment: "Total deficiency reserve — additional reserve required when expected future claims exceed unearned premium. Signals underpricing risk."
    - name: "member_months"
      expr: COUNT(1)
      comment: "Count of premium revenue records as a proxy for member-months — denominator for PMPM calculations and enrollment volume tracking."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`finance_actuarial_reserve`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Actuarial reserve adequacy and liability metrics — reserve estimates, confidence intervals, paid claims, and LAE. Essential for solvency monitoring, regulatory capital reporting, and CFO/Chief Actuary decision-making."
  source: "`vibe_health_insurance_v1`.`finance`.`actuarial_reserve`"
  dimensions:
    - name: "reserve_type"
      expr: reserve_type
      comment: "Type of reserve (e.g., IBNR, IBNER, LAE) for reserve composition analysis."
    - name: "reserve_period"
      expr: DATE_TRUNC('month', reserve_period)
      comment: "Reserve period truncated to month for trend analysis of reserve development."
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business for reserve segmentation by product line."
    - name: "product_type"
      expr: product_type
      comment: "Product type for reserve analysis by insurance product category."
    - name: "development_method"
      expr: development_method
      comment: "Actuarial development method used (e.g., chain-ladder, Bornhuetter-Ferguson) for methodology comparison."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the reserve for multi-currency reporting."
    - name: "mlr_flag"
      expr: mlr_flag
      comment: "Flag indicating whether the reserve is included in MLR calculations for regulatory compliance."
    - name: "pmpm_flag"
      expr: pmpm_flag
      comment: "Flag indicating PMPM-basis reserves for per-member cost analysis."
    - name: "actuarial_reserve_status"
      expr: actuarial_reserve_status
      comment: "Status of the reserve record (e.g., draft, approved, posted) for workflow tracking."
    - name: "effective_from"
      expr: DATE_TRUNC('quarter', effective_from)
      comment: "Reserve effective start date truncated to quarter for quarterly reserve development reporting."
  measures:
    - name: "total_reserve_estimate"
      expr: SUM(CAST(reserve_estimate_amount AS DOUBLE))
      comment: "Total actuarial reserve estimate — primary liability metric for balance sheet and solvency reporting. Drives regulatory capital requirements."
    - name: "total_liability_amount"
      expr: SUM(CAST(total_liability_amount AS DOUBLE))
      comment: "Total liability amount including all reserve components — comprehensive liability position for CFO and board reporting."
    - name: "total_paid_claims"
      expr: SUM(CAST(paid_claims_amount AS DOUBLE))
      comment: "Total paid claims amount — actual claims paid, used as the basis for reserve development and IBNR estimation."
    - name: "total_paid_lae"
      expr: SUM(CAST(paid_lae_amount AS DOUBLE))
      comment: "Total paid loss adjustment expenses — administrative cost of claims processing, tracked separately for expense ratio analysis."
    - name: "avg_confidence_interval_high"
      expr: AVG(CAST(confidence_interval_high AS DOUBLE))
      comment: "Average upper bound of actuarial confidence interval — measures reserve adequacy risk and potential adverse development exposure."
    - name: "avg_confidence_interval_low"
      expr: AVG(CAST(confidence_interval_low AS DOUBLE))
      comment: "Average lower bound of actuarial confidence interval — measures best-case reserve release potential."
    - name: "avg_risk_adjustment_factor"
      expr: AVG(CAST(risk_adjustment_factor AS DOUBLE))
      comment: "Average risk adjustment factor applied to reserves — indicates population risk profile used in reserve calculations."
    - name: "reserve_to_paid_claims_ratio"
      expr: ROUND(SUM(CAST(reserve_estimate_amount AS DOUBLE)) / NULLIF(SUM(CAST(paid_claims_amount AS DOUBLE)), 0), 4)
      comment: "Ratio of reserve estimate to paid claims — key actuarial adequacy indicator. Values significantly above or below 1.0 signal potential over/under-reserving."
    - name: "confidence_interval_spread"
      expr: AVG(CAST(confidence_interval_high AS DOUBLE) - CAST(confidence_interval_low AS DOUBLE))
      comment: "Average spread between high and low confidence interval bounds — measures actuarial uncertainty and reserve estimation precision."
    - name: "reserve_record_count"
      expr: COUNT(1)
      comment: "Count of actuarial reserve records — used to track reserve development completeness across periods and lines of business."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`finance_ap_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts payable invoice metrics — invoice volumes, amounts, payment status, and processing efficiency. Drives vendor payment management, cash flow forecasting, and AP operational performance."
  source: "`vibe_health_insurance_v1`.`finance`.`ap_invoice`"
  dimensions:
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of AP invoice (e.g., standard, credit memo, recurring) for invoice composition analysis."
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status (e.g., pending, paid, voided) for AP aging and cash flow management."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method (e.g., ACH, check, wire) for payment channel optimization."
    - name: "approval_status"
      expr: approval_status
      comment: "Invoice approval status for AP workflow monitoring and bottleneck identification."
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business for AP spend allocation by product line."
    - name: "currency_code"
      expr: currency_code
      comment: "Invoice currency for multi-currency AP reporting."
    - name: "invoice_date_month"
      expr: DATE_TRUNC('month', invoice_date)
      comment: "Invoice date truncated to month for monthly AP volume and spend trending."
    - name: "ap_invoice_status"
      expr: ap_invoice_status
      comment: "Overall invoice status for AP pipeline and backlog analysis."
    - name: "void_flag"
      expr: void_flag
      comment: "Flag indicating voided invoices for exclusion from active AP metrics."
    - name: "gl_posting_flag"
      expr: gl_posting_flag
      comment: "Flag indicating whether the invoice has been posted to the general ledger for close process monitoring."
  measures:
    - name: "total_gross_invoice_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross AP invoice amount — primary AP spend metric for vendor cost management and cash flow forecasting."
    - name: "total_net_invoice_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net AP invoice amount after discounts and taxes — actual cash outflow metric for treasury management."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on AP invoices — tracks tax liability for compliance and tax planning."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early payment discounts captured — measures AP discount optimization and vendor terms utilization."
    - name: "avg_invoice_amount"
      expr: AVG(CAST(gross_amount AS DOUBLE))
      comment: "Average AP invoice amount — baseline for anomaly detection and vendor spend benchmarking."
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Total number of AP invoices — volume metric for AP processing capacity and workload planning."
    - name: "void_invoice_count"
      expr: COUNT(CASE WHEN void_flag = TRUE THEN 1 END)
      comment: "Count of voided invoices — measures AP error rate and rework volume."
    - name: "void_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN void_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of invoices that were voided — key AP quality metric; high void rates indicate data entry errors or vendor disputes."
    - name: "discount_capture_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_amount AS DOUBLE)), 0), 2)
      comment: "Discount amount as a percentage of gross invoice amount — measures effectiveness of early payment discount programs."
    - name: "unposted_invoice_amount"
      expr: SUM(CASE WHEN gl_posting_flag = FALSE THEN CAST(net_amount AS DOUBLE) ELSE 0 END)
      comment: "Total net amount of invoices not yet posted to GL — critical for period-close completeness and financial statement accuracy."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`finance_ap_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts payable payment execution metrics — payment volumes, amounts, foreign currency exposure, and reconciliation status. Drives treasury operations, vendor relationship management, and cash management."
  source: "`vibe_health_insurance_v1`.`finance`.`ap_payment`"
  dimensions:
    - name: "payment_type"
      expr: payment_type
      comment: "Type of payment (e.g., standard, advance, final) for payment composition analysis."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method (e.g., ACH, check, wire) for payment channel mix analysis."
    - name: "payment_channel"
      expr: payment_channel
      comment: "Payment channel for electronic vs. paper payment optimization."
    - name: "ap_payment_status"
      expr: ap_payment_status
      comment: "Payment status for AP payment pipeline monitoring."
    - name: "is_foreign_currency"
      expr: is_foreign_currency
      comment: "Flag for foreign currency payments — used to segment FX exposure and hedging needs."
    - name: "is_reconciled"
      expr: is_reconciled
      comment: "Flag indicating whether the payment has been bank-reconciled — critical for cash management accuracy."
    - name: "currency_code"
      expr: currency_code
      comment: "Payment currency for multi-currency cash flow analysis."
    - name: "payment_date_month"
      expr: DATE_TRUNC('month', payment_date)
      comment: "Payment date truncated to month for monthly cash outflow trending."
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business for payment allocation by product line."
    - name: "void_flag"
      expr: void_flag
      comment: "Flag indicating voided payments for exclusion from active cash flow metrics."
  measures:
    - name: "total_gross_payment_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross payment amount — primary cash outflow metric for treasury and vendor payment management."
    - name: "total_net_payment_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net payment amount after discounts and taxes — actual cash disbursed for bank reconciliation and cash flow reporting."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total payment discounts taken — measures early payment discount program effectiveness."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax withheld on payments — tracks 1099 and tax withholding compliance."
    - name: "payment_count"
      expr: COUNT(1)
      comment: "Total number of AP payments — volume metric for payment processing capacity planning."
    - name: "unreconciled_payment_amount"
      expr: SUM(CASE WHEN is_reconciled = FALSE AND void_flag = FALSE THEN CAST(net_amount AS DOUBLE) ELSE 0 END)
      comment: "Total amount of payments not yet bank-reconciled — key treasury risk metric; large unreconciled balances indicate cash management gaps."
    - name: "foreign_currency_payment_amount"
      expr: SUM(CASE WHEN is_foreign_currency = TRUE THEN CAST(gross_amount AS DOUBLE) ELSE 0 END)
      comment: "Total foreign currency payment amount — measures FX exposure requiring hedging or exchange rate risk management."
    - name: "avg_exchange_rate"
      expr: AVG(CASE WHEN is_foreign_currency = TRUE THEN CAST(exchange_rate AS DOUBLE) END)
      comment: "Average exchange rate applied to foreign currency payments — used for FX cost analysis and hedging effectiveness evaluation."
    - name: "void_payment_count"
      expr: COUNT(CASE WHEN void_flag = TRUE THEN 1 END)
      comment: "Count of voided payments — measures payment error rate and rework in AP operations."
    - name: "reconciliation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_reconciled = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN void_flag = FALSE THEN 1 END), 0), 2)
      comment: "Percentage of non-voided payments that have been bank-reconciled — measures treasury close process completeness and cash management quality."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`finance_ar_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts receivable invoice metrics — billed revenue, collections, aging, and write-off performance. Drives revenue cycle management, collections strategy, and cash flow optimization."
  source: "`vibe_health_insurance_v1`.`finance`.`ar_invoice`"
  dimensions:
    - name: "ar_invoice_status"
      expr: ar_invoice_status
      comment: "AR invoice status (e.g., open, paid, overdue, written-off) for receivables aging and collections prioritization."
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status for collections pipeline monitoring."
    - name: "collection_status"
      expr: collection_status
      comment: "Collections status for delinquency management and bad debt forecasting."
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business for AR segmentation by product line."
    - name: "party_type"
      expr: party_type
      comment: "Type of billing party (e.g., employer group, individual member) for AR portfolio segmentation."
    - name: "billing_cycle"
      expr: billing_cycle
      comment: "Billing cycle (e.g., monthly, quarterly) for revenue recognition timing analysis."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method for collections channel analysis."
    - name: "invoice_date_month"
      expr: DATE_TRUNC('month', invoice_date)
      comment: "Invoice date truncated to month for monthly AR volume and revenue trending."
    - name: "is_void"
      expr: is_void
      comment: "Flag for voided invoices for exclusion from active AR metrics."
    - name: "is_written_off"
      expr: is_written_off
      comment: "Flag for written-off invoices for bad debt analysis."
  measures:
    - name: "total_gross_billed_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross AR billed amount — top-line revenue billed to customers. Primary revenue cycle metric for CFO and revenue management."
    - name: "total_net_billed_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net AR amount after discounts and taxes — expected cash collection amount for cash flow forecasting."
    - name: "total_unapplied_amount"
      expr: SUM(CAST(unapplied_amount AS DOUBLE))
      comment: "Total unapplied cash — payments received but not matched to invoices. High unapplied balances indicate cash application process failures."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts granted on AR invoices — measures revenue leakage from discount programs."
    - name: "total_written_off_amount"
      expr: SUM(CASE WHEN is_written_off = TRUE THEN CAST(net_amount AS DOUBLE) ELSE 0 END)
      comment: "Total amount written off as bad debt — key credit risk metric for reserve adequacy and collections effectiveness evaluation."
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Total AR invoice count — volume metric for billing operations capacity planning."
    - name: "write_off_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_written_off = TRUE THEN CAST(net_amount AS DOUBLE) ELSE 0 END) / NULLIF(SUM(CAST(net_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of net billed amount written off as bad debt — critical credit quality metric; rising write-off rates signal deteriorating collections performance."
    - name: "avg_invoice_amount"
      expr: AVG(CAST(gross_amount AS DOUBLE))
      comment: "Average AR invoice amount — baseline for billing anomaly detection and customer segment benchmarking."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on AR invoices — tracks premium tax and other tax liabilities for regulatory reporting."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`finance_journal_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "General ledger journal entry metrics — posting volumes, amounts, intercompany activity, and close process quality. Drives financial close management, GL integrity monitoring, and audit readiness."
  source: "`vibe_health_insurance_v1`.`finance`.`journal_entry`"
  dimensions:
    - name: "entry_type"
      expr: entry_type
      comment: "Journal entry type (e.g., standard, adjusting, closing) for GL activity composition analysis."
    - name: "entry_status"
      expr: entry_status
      comment: "Journal entry status (e.g., draft, posted, reversed) for close process monitoring."
    - name: "posting_status"
      expr: posting_status
      comment: "GL posting status for period-close completeness tracking."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status for journal entry workflow and SOX control monitoring."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual GL activity reporting."
    - name: "fiscal_month"
      expr: fiscal_month
      comment: "Fiscal month for monthly close activity trending."
    - name: "accounting_period"
      expr: accounting_period
      comment: "Accounting period for period-specific GL analysis."
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business for GL activity segmentation by product line."
    - name: "is_intercompany"
      expr: is_intercompany
      comment: "Flag for intercompany journal entries for elimination and consolidation analysis."
    - name: "is_consolidation_elimination"
      expr: is_consolidation_elimination
      comment: "Flag for consolidation elimination entries for consolidated financial statement preparation."
    - name: "source_module"
      expr: source_module
      comment: "Source system module that generated the journal entry for subledger reconciliation."
  measures:
    - name: "total_debit_amount"
      expr: SUM(CAST(total_debit_amount AS DOUBLE))
      comment: "Total debit amount across all journal entries — measures GL activity volume and is used for trial balance verification."
    - name: "total_credit_amount"
      expr: SUM(CAST(total_credit_amount AS DOUBLE))
      comment: "Total credit amount across all journal entries — paired with total debits for GL balance verification."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net journal entry amount — measures net financial impact of all GL postings for period reporting."
    - name: "journal_entry_count"
      expr: COUNT(1)
      comment: "Total number of journal entries — volume metric for close process workload and GL activity monitoring."
    - name: "intercompany_entry_count"
      expr: COUNT(CASE WHEN is_intercompany = TRUE THEN 1 END)
      comment: "Count of intercompany journal entries — measures intercompany transaction volume requiring elimination in consolidation."
    - name: "intercompany_amount"
      expr: SUM(CASE WHEN is_intercompany = TRUE THEN CAST(net_amount AS DOUBLE) ELSE 0 END)
      comment: "Total net amount of intercompany journal entries — key consolidation metric for eliminating intercompany profit and balances."
    - name: "unposted_entry_count"
      expr: COUNT(CASE WHEN posting_status != 'POSTED' THEN 1 END)
      comment: "Count of journal entries not yet posted to GL — critical period-close metric; high unposted counts delay financial statement preparation."
    - name: "unapproved_entry_count"
      expr: COUNT(CASE WHEN approval_status != 'APPROVED' THEN 1 END)
      comment: "Count of journal entries pending approval — SOX control metric for segregation of duties and authorization compliance."
    - name: "debit_credit_balance"
      expr: ROUND(SUM(CAST(total_debit_amount AS DOUBLE)) - SUM(CAST(total_credit_amount AS DOUBLE)), 2)
      comment: "Net difference between total debits and credits — should be zero for a balanced GL; non-zero values indicate posting errors requiring investigation."
    - name: "avg_journal_entry_amount"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average journal entry net amount — baseline for anomaly detection and unusual entry identification in audit processes."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`finance_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Budget performance and variance metrics — budgeted vs. actual amounts, variance analysis, and budget utilization. Core financial planning and control metrics for CFO, department heads, and board reporting."
  source: "`vibe_health_insurance_v1`.`finance`.`budget`"
  dimensions:
    - name: "budget_type"
      expr: budget_type
      comment: "Budget type (e.g., operating, capital, project) for budget portfolio segmentation."
    - name: "budget_status"
      expr: budget_status
      comment: "Budget status (e.g., draft, approved, active) for budget lifecycle management."
    - name: "fiscal_year"
      expr: year
      comment: "Fiscal year of the budget for annual planning cycle analysis."
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business for budget allocation analysis by product line."
    - name: "department_code"
      expr: department_code
      comment: "Department code for departmental budget performance analysis."
    - name: "division_code"
      expr: division_code
      comment: "Division code for divisional budget allocation and variance reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Budget currency for multi-currency budget consolidation."
    - name: "approval_timestamp_month"
      expr: DATE_TRUNC('month', approval_timestamp)
      comment: "Budget approval date truncated to month for budget cycle timing analysis."
  measures:
    - name: "total_budgeted_amount"
      expr: SUM(CAST(total_budgeted_amount AS DOUBLE))
      comment: "Total budgeted amount — primary financial planning metric for resource allocation and spending authority."
    - name: "total_adjusted_budget_amount"
      expr: SUM(CAST(total_adjusted_amount AS DOUBLE))
      comment: "Total budget after mid-year adjustments — reflects current approved spending authority after revisions."
    - name: "total_net_budget_amount"
      expr: SUM(CAST(total_net_amount AS DOUBLE))
      comment: "Total net budget amount — final budget position after all adjustments for period-end reporting."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total budget variance (actual vs. budget) — primary budget performance metric; negative variance indicates overspend requiring management action."
    - name: "total_prior_year_actual"
      expr: SUM(CAST(prior_year_actual_amount AS DOUBLE))
      comment: "Total prior year actual spend — year-over-year comparison baseline for budget growth analysis."
    - name: "budget_count"
      expr: COUNT(1)
      comment: "Count of budget records — measures budget planning completeness across departments and lines of business."
    - name: "avg_variance_amount"
      expr: AVG(CAST(variance_amount AS DOUBLE))
      comment: "Average budget variance per budget record — identifies systematic over/under-budgeting patterns across the organization."
    - name: "yoy_budget_growth_amount"
      expr: ROUND(SUM(CAST(total_budgeted_amount AS DOUBLE)) - SUM(CAST(prior_year_actual_amount AS DOUBLE)), 2)
      comment: "Year-over-year budget growth vs. prior year actuals — measures how aggressively the organization is planning growth or cost reduction."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`finance_vbc_settlement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Value-based care settlement performance metrics — shared savings, quality scores, benchmark vs. actual expenditure, and settlement outcomes. Critical for VBC program ROI evaluation and provider incentive management."
  source: "`vibe_health_insurance_v1`.`finance`.`vbc_settlement`"
  dimensions:
    - name: "settlement_type"
      expr: settlement_type
      comment: "Type of VBC settlement (e.g., shared savings, shared risk, capitation) for program model analysis."
    - name: "settlement_status"
      expr: settlement_status
      comment: "Settlement status (e.g., pending, finalized, disputed) for settlement pipeline management."
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status for VBC settlement cash flow tracking."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method for VBC settlement disbursement analysis."
    - name: "is_shared_risk"
      expr: is_shared_risk
      comment: "Flag indicating shared risk vs. shared savings only arrangements — key for risk model portfolio analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Settlement currency for multi-currency VBC program reporting."
    - name: "performance_period_start_year"
      expr: DATE_TRUNC('year', performance_period_start)
      comment: "Performance period start year for annual VBC program cycle analysis."
    - name: "settlement_timestamp_month"
      expr: DATE_TRUNC('month', settlement_timestamp)
      comment: "Settlement date truncated to month for settlement timing and cash flow analysis."
  measures:
    - name: "total_savings_amount"
      expr: SUM(CAST(savings_amount AS DOUBLE))
      comment: "Total savings generated vs. benchmark — primary VBC program ROI metric. Positive savings indicate the program is reducing total cost of care."
    - name: "total_final_settlement_amount"
      expr: SUM(CAST(final_settlement_amount AS DOUBLE))
      comment: "Total final settlement payments to providers — actual VBC incentive disbursements for cash flow and provider relationship management."
    - name: "total_benchmark_expenditure"
      expr: SUM(CAST(benchmark_expenditure_amount AS DOUBLE))
      comment: "Total benchmark expenditure target — the expected cost baseline against which actual performance is measured."
    - name: "total_actual_expenditure"
      expr: SUM(CAST(actual_expenditure_amount AS DOUBLE))
      comment: "Total actual expenditure under VBC arrangements — measures real cost of care delivery vs. benchmark."
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average quality score across VBC settlements — measures clinical quality performance that gates shared savings eligibility."
    - name: "avg_shared_savings_percentage"
      expr: AVG(CAST(shared_savings_percentage AS DOUBLE))
      comment: "Average shared savings percentage — measures the proportion of savings shared with providers under VBC contracts."
    - name: "avg_risk_adjustment_factor"
      expr: AVG(CAST(risk_adjustment_factor AS DOUBLE))
      comment: "Average risk adjustment factor applied to VBC settlements — measures population risk profile adjustments in performance calculations."
    - name: "savings_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(savings_amount AS DOUBLE)) / NULLIF(SUM(CAST(benchmark_expenditure_amount AS DOUBLE)), 0), 2)
      comment: "Savings as a percentage of benchmark expenditure — key VBC program efficiency metric; higher rates indicate stronger cost reduction performance."
    - name: "settlement_count"
      expr: COUNT(1)
      comment: "Count of VBC settlements — measures VBC program scale and provider participation volume."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`finance_reinsurance_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reinsurance transaction metrics — ceded premium, ceded losses, recoveries, and risk transfer effectiveness. Essential for reinsurance program management, solvency monitoring, and catastrophic risk mitigation."
  source: "`vibe_health_insurance_v1`.`finance`.`reinsurance_transaction`"
  dimensions:
    - name: "transaction_type"
      expr: transaction_type
      comment: "Reinsurance transaction type (e.g., cession, assumption, recovery) for transaction composition analysis."
    - name: "transaction_status"
      expr: transaction_status
      comment: "Transaction status for reinsurance settlement pipeline monitoring."
    - name: "attachment_point_type"
      expr: attachment_point_type
      comment: "Attachment point type (e.g., per-occurrence, aggregate) for reinsurance structure analysis."
    - name: "is_ceded"
      expr: is_ceded
      comment: "Flag for ceded transactions — separates outgoing risk transfer from assumed risk."
    - name: "is_assumed"
      expr: is_assumed
      comment: "Flag for assumed reinsurance transactions — measures inbound risk assumption activity."
    - name: "is_stop_loss"
      expr: is_stop_loss
      comment: "Flag for stop-loss reinsurance — tracks catastrophic risk protection utilization."
    - name: "is_quota_share"
      expr: is_quota_share
      comment: "Flag for quota share arrangements — tracks proportional risk sharing program activity."
    - name: "reporting_category"
      expr: reporting_category
      comment: "Reporting category for regulatory Schedule F and statutory reporting segmentation."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for multi-currency reinsurance program reporting."
    - name: "effective_date_year"
      expr: DATE_TRUNC('year', effective_date)
      comment: "Effective date truncated to year for annual reinsurance program performance analysis."
  measures:
    - name: "total_ceded_premium"
      expr: SUM(CAST(ceded_premium_amount AS DOUBLE))
      comment: "Total premium ceded to reinsurers — primary cost of reinsurance metric for program ROI evaluation."
    - name: "total_ceded_loss"
      expr: SUM(CAST(ceded_loss_amount AS DOUBLE))
      comment: "Total losses ceded to reinsurers — measures reinsurance recovery on claims, key for evaluating risk transfer effectiveness."
    - name: "total_recovery_amount"
      expr: SUM(CAST(recovery_amount AS DOUBLE))
      comment: "Total reinsurance recoveries received — actual cash recovered from reinsurers for catastrophic or large claims."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net reinsurance transaction amount — net cost/benefit of the reinsurance program after premiums and recoveries."
    - name: "total_rbc_credit"
      expr: SUM(CAST(rbc_credit_amount AS DOUBLE))
      comment: "Total risk-based capital credit from reinsurance — measures regulatory capital relief provided by the reinsurance program."
    - name: "avg_attachment_point"
      expr: AVG(CAST(attachment_point_amount AS DOUBLE))
      comment: "Average reinsurance attachment point — measures the threshold at which reinsurance coverage activates, indicating risk retention level."
    - name: "avg_limit_amount"
      expr: AVG(CAST(limit_amount AS DOUBLE))
      comment: "Average reinsurance limit amount — measures maximum coverage per arrangement for catastrophic exposure management."
    - name: "loss_recovery_ratio"
      expr: ROUND(SUM(CAST(recovery_amount AS DOUBLE)) / NULLIF(SUM(CAST(ceded_loss_amount AS DOUBLE)), 0), 4)
      comment: "Ratio of recoveries to ceded losses — measures reinsurance collection effectiveness; values below 1.0 indicate uncollected reinsurance receivables."
    - name: "reinsurance_transaction_count"
      expr: COUNT(1)
      comment: "Count of reinsurance transactions — measures reinsurance program activity volume and settlement complexity."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`finance_mlr_financial_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Medical Loss Ratio financial entry metrics — incurred claims, earned premium, quality improvement expenses, and MLR compliance. Core ACA regulatory compliance metrics for CMS reporting and rebate liability management."
  source: "`vibe_health_insurance_v1`.`finance`.`mlr_financial_entry`"
  dimensions:
    - name: "reporting_year"
      expr: reporting_year
      comment: "MLR reporting year for annual CMS submission and year-over-year compliance trending."
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business (e.g., Individual, Small Group, Large Group) for MLR segmentation per ACA market segment rules."
    - name: "market_segment"
      expr: market_segment
      comment: "Market segment for MLR calculation per ACA regulatory requirements."
    - name: "state_code"
      expr: state_code
      comment: "State code for state-level MLR reporting and rebate calculation."
    - name: "mlr_financial_entry_status"
      expr: mlr_financial_entry_status
      comment: "Entry status for MLR submission pipeline monitoring."
    - name: "submission_status"
      expr: submission_status
      comment: "CMS submission status for regulatory filing compliance tracking."
    - name: "calculation_date_month"
      expr: DATE_TRUNC('month', calculation_date)
      comment: "MLR calculation date truncated to month for calculation cycle monitoring."
  measures:
    - name: "total_incurred_claims"
      expr: SUM(CAST(incurred_claims_amount AS DOUBLE))
      comment: "Total incurred claims amount — MLR numerator component. Primary driver of MLR ratio and rebate liability."
    - name: "total_earned_premium"
      expr: SUM(CAST(total_earned_premium AS DOUBLE))
      comment: "Total earned premium — MLR denominator. Required for ACA MLR ratio calculation and CMS reporting."
    - name: "total_quality_improvement_expenses"
      expr: SUM(CAST(quality_improvement_expenses AS DOUBLE))
      comment: "Total quality improvement expenses — added to MLR numerator per ACA rules. Measures investment in care quality programs."
    - name: "total_rebate_liability"
      expr: SUM(CAST(rebate_liability_amount AS DOUBLE))
      comment: "Total MLR rebate liability — amount owed to members/employers when MLR falls below ACA minimum thresholds. Critical regulatory compliance metric."
    - name: "avg_mlr_percentage"
      expr: AVG(CAST(mlr_percentage AS DOUBLE))
      comment: "Average MLR percentage — the core ACA compliance metric. Values below 80% (individual/small group) or 85% (large group) trigger rebate obligations."
    - name: "minimum_mlr_threshold_avg"
      expr: AVG(CAST(minimum_mlr_threshold AS DOUBLE))
      comment: "Average minimum MLR threshold applicable — reference value for compliance gap analysis."
    - name: "mlr_compliance_gap"
      expr: ROUND(AVG(CAST(mlr_percentage AS DOUBLE)) - AVG(CAST(minimum_mlr_threshold AS DOUBLE)), 4)
      comment: "Average gap between actual MLR and minimum threshold — positive values indicate compliance; negative values indicate rebate obligation. Key regulatory risk metric."
    - name: "mlr_entry_count"
      expr: COUNT(1)
      comment: "Count of MLR financial entries — measures reporting completeness across market segments and states."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`finance_tax_filing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tax filing compliance and liability metrics — tax liabilities, payment status, filing timeliness, and amendment tracking. Drives tax compliance management, regulatory risk monitoring, and treasury planning."
  source: "`vibe_health_insurance_v1`.`finance`.`tax_filing`"
  dimensions:
    - name: "tax_type"
      expr: tax_type
      comment: "Tax type (e.g., premium tax, income tax, payroll tax) for tax liability segmentation."
    - name: "tax_category"
      expr: tax_category
      comment: "Tax category for detailed tax classification and reporting."
    - name: "tax_year"
      expr: tax_year
      comment: "Tax year for annual tax liability trending and year-over-year comparison."
    - name: "tax_jurisdiction_code"
      expr: tax_jurisdiction_code
      comment: "Tax jurisdiction (state/federal) for multi-jurisdiction tax liability analysis."
    - name: "filing_status"
      expr: filing_status
      comment: "Filing status (e.g., filed, pending, overdue) for compliance monitoring."
    - name: "tax_payment_status"
      expr: tax_payment_status
      comment: "Tax payment status for cash flow and penalty risk management."
    - name: "is_amended"
      expr: is_amended
      comment: "Flag for amended filings — tracks restatement frequency and tax position changes."
    - name: "filing_method"
      expr: filing_method
      comment: "Filing method (e.g., electronic, paper) for e-filing adoption tracking."
    - name: "filing_date_month"
      expr: DATE_TRUNC('month', filing_date)
      comment: "Filing date truncated to month for filing timeliness analysis."
  measures:
    - name: "total_tax_liability"
      expr: SUM(CAST(tax_liability_amount AS DOUBLE))
      comment: "Total tax liability amount — primary tax compliance metric for treasury planning and regulatory risk management."
    - name: "total_final_tax_due"
      expr: SUM(CAST(final_tax_due_amount AS DOUBLE))
      comment: "Total final tax due after estimated payments — net tax obligation for cash flow planning."
    - name: "total_estimated_payments"
      expr: SUM(CAST(estimated_payments_amount AS DOUBLE))
      comment: "Total estimated tax payments made — measures prepayment adequacy and potential underpayment penalty exposure."
    - name: "total_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total tax payments made — actual cash outflow for tax obligations."
    - name: "total_taxable_base"
      expr: SUM(CAST(taxable_base_amount AS DOUBLE))
      comment: "Total taxable base amount — measures the revenue/income subject to taxation across all jurisdictions."
    - name: "avg_tax_rate_pct"
      expr: AVG(CAST(tax_rate_percent AS DOUBLE))
      comment: "Average effective tax rate — measures overall tax burden and identifies jurisdictions with high tax rates."
    - name: "tax_filing_count"
      expr: COUNT(1)
      comment: "Total number of tax filings — measures compliance completeness across jurisdictions and tax types."
    - name: "amended_filing_count"
      expr: COUNT(CASE WHEN is_amended = TRUE THEN 1 END)
      comment: "Count of amended tax filings — measures tax position restatement frequency; high amendment rates indicate tax reporting quality issues."
    - name: "amendment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_amended = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of tax filings that required amendment — key tax compliance quality metric; high rates signal systemic tax reporting errors."
    - name: "effective_tax_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(tax_liability_amount AS DOUBLE)) / NULLIF(SUM(CAST(taxable_base_amount AS DOUBLE)), 0), 2)
      comment: "Effective tax rate as a percentage of taxable base — measures actual tax burden vs. statutory rates for tax planning and optimization."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`finance_bank_reconciliation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bank reconciliation quality and completeness metrics — reconciled balances, unreconciled items, and reconciliation timeliness. Drives treasury controls, cash management accuracy, and audit readiness."
  source: "`vibe_health_insurance_v1`.`finance`.`bank_reconciliation`"
  dimensions:
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status (e.g., in-progress, completed, approved) for close process monitoring."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status for reconciliation SOX control compliance."
    - name: "reconciliation_type"
      expr: reconciliation_type
      comment: "Type of reconciliation (e.g., monthly, interim) for reconciliation cadence analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for multi-currency reconciliation reporting."
    - name: "is_adjusted"
      expr: is_adjusted
      comment: "Flag indicating whether adjustments were required — measures reconciliation complexity and error frequency."
    - name: "reconciliation_period_start_month"
      expr: DATE_TRUNC('month', reconciliation_period_start)
      comment: "Reconciliation period start truncated to month for monthly reconciliation cycle tracking."
  measures:
    - name: "total_reconciled_balance"
      expr: SUM(CAST(reconciled_balance AS DOUBLE))
      comment: "Total reconciled bank balance — confirmed cash position after reconciliation. Primary treasury accuracy metric."
    - name: "total_unreconciled_items_amount"
      expr: SUM(CAST(unreconciled_items_amount AS DOUBLE))
      comment: "Total unreconciled items amount — measures outstanding reconciliation breaks. High values indicate cash management control failures."
    - name: "total_outstanding_checks"
      expr: SUM(CAST(outstanding_checks_amount AS DOUBLE))
      comment: "Total outstanding checks not yet cleared — measures float and timing differences in cash position."
    - name: "total_deposits_in_transit"
      expr: SUM(CAST(deposits_in_transit_amount AS DOUBLE))
      comment: "Total deposits in transit not yet cleared — measures timing differences between recorded and bank-confirmed cash."
    - name: "gl_to_bank_variance"
      expr: ROUND(SUM(CAST(gl_balance AS DOUBLE)) - SUM(CAST(bank_statement_balance AS DOUBLE)), 2)
      comment: "Difference between GL balance and bank statement balance — key reconciliation quality metric; non-zero values require investigation and resolution."
    - name: "reconciliation_count"
      expr: COUNT(1)
      comment: "Total number of bank reconciliations — measures reconciliation completeness across all bank accounts."
    - name: "adjusted_reconciliation_count"
      expr: COUNT(CASE WHEN is_adjusted = TRUE THEN 1 END)
      comment: "Count of reconciliations requiring adjustments — measures reconciliation error frequency and cash management quality."
    - name: "adjustment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_adjusted = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reconciliations requiring adjustments — key internal controls metric; high rates indicate systematic cash recording errors."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`finance_regulatory_filing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory filing compliance metrics — filing status, tax liabilities, submission timeliness, and amendment tracking. Note: per VREQ-086, this product is being renamed to regulatory_filing. Drives regulatory compliance management and penalty risk mitigation."
  source: "`vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing`"
  dimensions:
    - name: "filing_type"
      expr: filing_type
      comment: "Type of regulatory filing (e.g., annual statement, premium tax, MLR) for compliance portfolio analysis."
    - name: "filing_category"
      expr: filing_category
      comment: "Filing category for regulatory reporting segmentation."
    - name: "filing_status"
      expr: filing_status
      comment: "Filing status (e.g., submitted, accepted, rejected) for compliance pipeline monitoring."
    - name: "jurisdiction_code"
      expr: jurisdiction_code
      comment: "Regulatory jurisdiction for multi-state compliance tracking."
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory body (e.g., CMS, state DOI) for regulator-specific compliance analysis."
    - name: "filing_is_amended"
      expr: filing_is_amended
      comment: "Flag for amended filings — tracks restatement frequency and regulatory position changes."
    - name: "filing_submission_method"
      expr: filing_submission_method
      comment: "Submission method (e.g., electronic, paper) for e-filing adoption tracking."
    - name: "filing_period_start_year"
      expr: DATE_TRUNC('year', filing_period_start)
      comment: "Filing period start truncated to year for annual compliance cycle analysis."
  measures:
    - name: "total_tax_liability"
      expr: SUM(CAST(tax_liability_amount AS DOUBLE))
      comment: "Total tax liability reported in regulatory filings — primary financial compliance metric for premium tax and other regulatory obligations."
    - name: "total_final_tax_due"
      expr: SUM(CAST(final_tax_due_amount AS DOUBLE))
      comment: "Total final tax due across all regulatory filings — net tax obligation for cash flow and penalty risk management."
    - name: "total_estimated_payment"
      expr: SUM(CAST(estimated_payment_amount AS DOUBLE))
      comment: "Total estimated payments reported — measures prepayment adequacy and underpayment penalty exposure."
    - name: "total_taxable_base"
      expr: SUM(CAST(taxable_base_amount AS DOUBLE))
      comment: "Total taxable base amount across regulatory filings — measures the revenue base subject to regulatory taxation."
    - name: "avg_tax_rate_pct"
      expr: AVG(CAST(tax_rate_percent AS DOUBLE))
      comment: "Average tax rate across regulatory filings — measures effective regulatory tax burden by jurisdiction."
    - name: "filing_count"
      expr: COUNT(1)
      comment: "Total number of regulatory filings — measures compliance completeness across jurisdictions and filing types."
    - name: "rejected_filing_count"
      expr: COUNT(CASE WHEN filing_status = 'REJECTED' THEN 1 END)
      comment: "Count of rejected regulatory filings — measures compliance quality; rejections require resubmission and may trigger penalties."
    - name: "rejection_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN filing_status = 'REJECTED' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of regulatory filings rejected — key compliance quality metric; high rejection rates indicate systemic filing errors and regulatory risk."
    - name: "amended_filing_count"
      expr: COUNT(CASE WHEN filing_is_amended = TRUE THEN 1 END)
      comment: "Count of amended regulatory filings — measures regulatory position restatement frequency and compliance accuracy."
$$;