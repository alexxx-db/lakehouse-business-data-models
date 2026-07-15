-- Metric views for domain: finance | Business: Staffing Hr | Version: 1 | Generated on: 2026-05-02 15:43:14

CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`finance_ar_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts receivable performance metrics tracking aging, credit utilization, and collection effectiveness"
  source: "`staffing_hr_ecm`.`finance`.`ar_account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current status of the AR account (active, closed, suspended)"
    - name: "collection_status"
      expr: collection_status
      comment: "Collection status indicating recovery stage"
    - name: "credit_hold_flag"
      expr: credit_hold_flag
      comment: "Whether account is on credit hold"
    - name: "dunning_level"
      expr: dunning_level
      comment: "Escalation level for collections activity"
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms agreed with customer"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the AR account"
    - name: "billing_cycle"
      expr: billing_cycle
      comment: "Billing cycle frequency"
  measures:
    - name: "total_ar_balance"
      expr: SUM(CAST(current_balance AS DOUBLE))
      comment: "Total outstanding accounts receivable balance"
    - name: "total_aging_current"
      expr: SUM(CAST(current_bucket_amount AS DOUBLE))
      comment: "Total AR in current aging bucket (not yet due)"
    - name: "total_aging_30_days"
      expr: SUM(CAST(aging_30_days_amount AS DOUBLE))
      comment: "Total AR aged 1-30 days past due"
    - name: "total_aging_60_days"
      expr: SUM(CAST(aging_60_days_amount AS DOUBLE))
      comment: "Total AR aged 31-60 days past due"
    - name: "total_aging_90_days"
      expr: SUM(CAST(aging_90_days_amount AS DOUBLE))
      comment: "Total AR aged 61-90 days past due"
    - name: "total_aging_over_90_days"
      expr: SUM(CAST(aging_over_90_days_amount AS DOUBLE))
      comment: "Total AR aged over 90 days past due"
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Total credit limit extended to customers"
    - name: "total_available_credit"
      expr: SUM(CAST(available_credit AS DOUBLE))
      comment: "Total available credit remaining for customers"
    - name: "total_bad_debt_reserve"
      expr: SUM(CAST(bad_debt_reserve AS DOUBLE))
      comment: "Total bad debt reserve allocated"
    - name: "total_disputed_amount"
      expr: SUM(CAST(disputed_amount AS DOUBLE))
      comment: "Total amount currently in dispute"
    - name: "total_write_off_amount"
      expr: SUM(CAST(write_off_amount AS DOUBLE))
      comment: "Total amount written off as uncollectible"
    - name: "credit_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(current_balance AS DOUBLE)) / NULLIF(SUM(CAST(credit_limit AS DOUBLE)), 0), 2)
      comment: "Percentage of credit limit currently utilized"
    - name: "past_due_rate"
      expr: ROUND(100.0 * (SUM(CAST(aging_30_days_amount AS DOUBLE)) + SUM(CAST(aging_60_days_amount AS DOUBLE)) + SUM(CAST(aging_90_days_amount AS DOUBLE)) + SUM(CAST(aging_over_90_days_amount AS DOUBLE))) / NULLIF(SUM(CAST(current_balance AS DOUBLE)), 0), 2)
      comment: "Percentage of AR balance that is past due"
    - name: "severely_aged_rate"
      expr: ROUND(100.0 * SUM(CAST(aging_over_90_days_amount AS DOUBLE)) / NULLIF(SUM(CAST(current_balance AS DOUBLE)), 0), 2)
      comment: "Percentage of AR balance aged over 90 days"
    - name: "bad_debt_reserve_coverage"
      expr: ROUND(100.0 * SUM(CAST(bad_debt_reserve AS DOUBLE)) / NULLIF(SUM(CAST(current_balance AS DOUBLE)), 0), 2)
      comment: "Bad debt reserve as percentage of total AR balance"
    - name: "dispute_rate"
      expr: ROUND(100.0 * SUM(CAST(disputed_amount AS DOUBLE)) / NULLIF(SUM(CAST(current_balance AS DOUBLE)), 0), 2)
      comment: "Percentage of AR balance currently disputed"
    - name: "account_count"
      expr: COUNT(1)
      comment: "Total number of AR accounts"
    - name: "unique_clients"
      expr: COUNT(DISTINCT client_account_id)
      comment: "Number of unique clients with AR accounts"
    - name: "accounts_on_credit_hold"
      expr: SUM(CASE WHEN credit_hold_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of accounts currently on credit hold"
    - name: "accounts_with_disputes"
      expr: SUM(CASE WHEN dispute_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of accounts with active disputes"
$$;


CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`finance_ap_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts payable performance metrics tracking aging, payment obligations, and vendor relationships"
  source: "`staffing_hr_ecm`.`finance`.`ap_account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current status of the AP account"
    - name: "account_type"
      expr: account_type
      comment: "Type of AP account"
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms negotiated with vendor"
    - name: "payment_method"
      expr: payment_method
      comment: "Method used for payments"
    - name: "payment_priority"
      expr: payment_priority
      comment: "Priority level for payment processing"
    - name: "vendor_category"
      expr: vendor_category
      comment: "Category of vendor"
    - name: "hold_payment_flag"
      expr: hold_payment_flag
      comment: "Whether payments are on hold"
    - name: "is_msp_vms_vendor"
      expr: is_msp_vms_vendor
      comment: "Whether vendor is MSP/VMS managed"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the AP account"
  measures:
    - name: "total_ap_balance"
      expr: SUM(CAST(current_balance AS DOUBLE))
      comment: "Total outstanding accounts payable balance"
    - name: "total_aging_current"
      expr: SUM(CAST(aging_current AS DOUBLE))
      comment: "Total AP in current aging bucket (not yet due)"
    - name: "total_aging_31_60"
      expr: SUM(CAST(aging_31_60 AS DOUBLE))
      comment: "Total AP aged 31-60 days"
    - name: "total_aging_61_90"
      expr: SUM(CAST(aging_61_90 AS DOUBLE))
      comment: "Total AP aged 61-90 days"
    - name: "total_aging_over_90"
      expr: SUM(CAST(aging_over_90 AS DOUBLE))
      comment: "Total AP aged over 90 days"
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Total credit limit extended by vendors"
    - name: "total_lifetime_payments"
      expr: SUM(CAST(lifetime_payment_total AS DOUBLE))
      comment: "Total lifetime payments made to vendors"
    - name: "total_ytd_payments"
      expr: SUM(CAST(ytd_payment_total AS DOUBLE))
      comment: "Total year-to-date payments made to vendors"
    - name: "overdue_rate"
      expr: ROUND(100.0 * (SUM(CAST(aging_31_60 AS DOUBLE)) + SUM(CAST(aging_61_90 AS DOUBLE)) + SUM(CAST(aging_over_90 AS DOUBLE))) / NULLIF(SUM(CAST(current_balance AS DOUBLE)), 0), 2)
      comment: "Percentage of AP balance that is overdue"
    - name: "severely_overdue_rate"
      expr: ROUND(100.0 * SUM(CAST(aging_over_90 AS DOUBLE)) / NULLIF(SUM(CAST(current_balance AS DOUBLE)), 0), 2)
      comment: "Percentage of AP balance aged over 90 days"
    - name: "avg_payment_amount"
      expr: AVG(CAST(last_payment_amount AS DOUBLE))
      comment: "Average payment amount per account"
    - name: "account_count"
      expr: COUNT(1)
      comment: "Total number of AP accounts"
    - name: "unique_suppliers"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of unique suppliers with AP accounts"
    - name: "accounts_on_payment_hold"
      expr: SUM(CASE WHEN hold_payment_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of accounts with payments on hold"
    - name: "msp_vms_vendor_count"
      expr: SUM(CASE WHEN is_msp_vms_vendor = TRUE THEN 1 ELSE 0 END)
      comment: "Number of MSP/VMS managed vendor accounts"
$$;


CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`finance_revenue_recognition_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue recognition metrics tracking earned revenue, deferred balances, and performance obligations"
  source: "`staffing_hr_ecm`.`finance`.`revenue_recognition_event`"
  dimensions:
    - name: "recognition_status"
      expr: recognition_status
      comment: "Status of the revenue recognition event"
    - name: "recognition_method"
      expr: recognition_method
      comment: "Method used for revenue recognition"
    - name: "revenue_category"
      expr: revenue_category
      comment: "Category of revenue"
    - name: "revenue_stream"
      expr: revenue_stream
      comment: "Revenue stream classification"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the revenue"
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Whether this is a reversal event"
    - name: "recognition_year"
      expr: YEAR(recognition_date)
      comment: "Year of revenue recognition"
    - name: "recognition_quarter"
      expr: CONCAT('Q', QUARTER(recognition_date), '-', YEAR(recognition_date))
      comment: "Quarter of revenue recognition"
    - name: "recognition_month"
      expr: DATE_TRUNC('MONTH', recognition_date)
      comment: "Month of revenue recognition"
  measures:
    - name: "total_recognized_revenue"
      expr: SUM(CAST(recognized_revenue_amount AS DOUBLE))
      comment: "Total revenue recognized in the period"
    - name: "total_billed_amount"
      expr: SUM(CAST(billed_amount AS DOUBLE))
      comment: "Total amount billed to customers"
    - name: "total_deferred_revenue"
      expr: SUM(CAST(deferred_revenue_amount AS DOUBLE))
      comment: "Total revenue deferred for future recognition"
    - name: "total_unbilled_receivable"
      expr: SUM(CAST(unbilled_receivable_amount AS DOUBLE))
      comment: "Total revenue recognized but not yet billed"
    - name: "total_contract_liability"
      expr: SUM(CAST(contract_liability_amount AS DOUBLE))
      comment: "Total contract liability (advance payments)"
    - name: "revenue_realization_rate"
      expr: ROUND(100.0 * SUM(CAST(recognized_revenue_amount AS DOUBLE)) / NULLIF(SUM(CAST(billed_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of billed amount recognized as revenue"
    - name: "deferral_rate"
      expr: ROUND(100.0 * SUM(CAST(deferred_revenue_amount AS DOUBLE)) / NULLIF(SUM(CAST(billed_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of billed amount deferred"
    - name: "avg_percentage_complete"
      expr: AVG(CAST(percentage_complete AS DOUBLE))
      comment: "Average completion percentage across performance obligations"
    - name: "recognition_event_count"
      expr: COUNT(1)
      comment: "Total number of revenue recognition events"
    - name: "unique_clients"
      expr: COUNT(DISTINCT client_account_id)
      comment: "Number of unique clients with revenue recognition"
    - name: "unique_invoices"
      expr: COUNT(DISTINCT invoice_id)
      comment: "Number of unique invoices with revenue recognition"
    - name: "reversal_count"
      expr: SUM(CASE WHEN reversal_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of revenue recognition reversals"
$$;


CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`finance_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Budget performance metrics tracking allocations, utilization, and variance management"
  source: "`staffing_hr_ecm`.`finance`.`budget`"
  dimensions:
    - name: "budget_status"
      expr: budget_status
      comment: "Current status of the budget"
    - name: "budget_type"
      expr: budget_type
      comment: "Type of budget (operating, capital, project)"
    - name: "budget_category"
      expr: budget_category
      comment: "Category of budget"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the budget"
    - name: "period"
      expr: period
      comment: "Budget period (monthly, quarterly, annual)"
    - name: "is_capital_expenditure"
      expr: is_capital_expenditure
      comment: "Whether budget is for capital expenditure"
    - name: "is_active"
      expr: is_active
      comment: "Whether budget is currently active"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the budget"
    - name: "allocation_method"
      expr: allocation_method
      comment: "Method used for budget allocation"
  measures:
    - name: "total_budgeted_amount"
      expr: SUM(CAST(budgeted_amount AS DOUBLE))
      comment: "Total budgeted amount across all budgets"
    - name: "total_headcount_fte"
      expr: SUM(CAST(headcount_fte AS DOUBLE))
      comment: "Total full-time equivalent headcount budgeted"
    - name: "avg_variance_threshold"
      expr: AVG(CAST(variance_threshold_percent AS DOUBLE))
      comment: "Average variance threshold percentage"
    - name: "budget_count"
      expr: COUNT(1)
      comment: "Total number of budgets"
    - name: "active_budget_count"
      expr: SUM(CASE WHEN is_active = TRUE THEN 1 ELSE 0 END)
      comment: "Number of active budgets"
    - name: "capex_budget_count"
      expr: SUM(CASE WHEN is_capital_expenditure = TRUE THEN 1 ELSE 0 END)
      comment: "Number of capital expenditure budgets"
    - name: "unique_cost_centers"
      expr: COUNT(DISTINCT cost_center_id)
      comment: "Number of unique cost centers with budgets"
    - name: "unique_business_units"
      expr: COUNT(DISTINCT business_unit_id)
      comment: "Number of unique business units with budgets"
    - name: "unique_clients"
      expr: COUNT(DISTINCT client_account_id)
      comment: "Number of unique clients with budgets"
$$;


CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`finance_journal_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Journal entry metrics tracking posting activity, adjustments, and accounting accuracy"
  source: "`staffing_hr_ecm`.`finance`.`journal_entry`"
  dimensions:
    - name: "posting_status"
      expr: posting_status
      comment: "Posting status of the journal entry"
    - name: "journal_type"
      expr: journal_type
      comment: "Type of journal entry (standard, adjusting, closing, reversing)"
    - name: "recurring_flag"
      expr: recurring_flag
      comment: "Whether this is a recurring journal entry"
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Whether this is a reversal entry"
    - name: "intercompany_flag"
      expr: intercompany_flag
      comment: "Whether this is an intercompany transaction"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the journal entry"
    - name: "source_system"
      expr: source_system
      comment: "Source system of the journal entry"
    - name: "posting_year"
      expr: YEAR(posting_date)
      comment: "Year of posting"
    - name: "posting_quarter"
      expr: CONCAT('Q', QUARTER(posting_date), '-', YEAR(posting_date))
      comment: "Quarter of posting"
    - name: "posting_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month of posting"
  measures:
    - name: "total_debit_amount"
      expr: SUM(CAST(total_debit_amount AS DOUBLE))
      comment: "Total debit amount across all journal entries"
    - name: "total_credit_amount"
      expr: SUM(CAST(total_credit_amount AS DOUBLE))
      comment: "Total credit amount across all journal entries"
    - name: "journal_entry_count"
      expr: COUNT(1)
      comment: "Total number of journal entries"
    - name: "posted_entry_count"
      expr: SUM(CASE WHEN posting_status = 'Posted' THEN 1 ELSE 0 END)
      comment: "Number of posted journal entries"
    - name: "recurring_entry_count"
      expr: SUM(CASE WHEN recurring_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of recurring journal entries"
    - name: "reversal_entry_count"
      expr: SUM(CASE WHEN reversal_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of reversal journal entries"
    - name: "intercompany_entry_count"
      expr: SUM(CASE WHEN intercompany_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of intercompany journal entries"
    - name: "unique_accounting_periods"
      expr: COUNT(DISTINCT accounting_period_id)
      comment: "Number of unique accounting periods with journal entries"
    - name: "unique_business_units"
      expr: COUNT(DISTINCT business_unit_id)
      comment: "Number of unique business units with journal entries"
    - name: "unique_legal_entities"
      expr: COUNT(DISTINCT legal_entity_id)
      comment: "Number of unique legal entities with journal entries"
$$;


CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`finance_cash_flow`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cash flow metrics tracking liquidity, transaction velocity, and treasury performance"
  source: "`staffing_hr_ecm`.`finance`.`bank_transaction`"
  dimensions:
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of bank transaction"
    - name: "debit_credit_indicator"
      expr: debit_credit_indicator
      comment: "Whether transaction is debit or credit"
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status of the transaction"
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Whether this is a reversal transaction"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the transaction"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the transaction"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the transaction"
    - name: "transaction_year"
      expr: YEAR(transaction_date)
      comment: "Year of transaction"
    - name: "transaction_quarter"
      expr: CONCAT('Q', QUARTER(transaction_date), '-', YEAR(transaction_date))
      comment: "Quarter of transaction"
    - name: "transaction_month"
      expr: DATE_TRUNC('MONTH', transaction_date)
      comment: "Month of transaction"
  measures:
    - name: "total_transaction_amount"
      expr: SUM(CAST(transaction_amount AS DOUBLE))
      comment: "Total transaction amount across all bank transactions"
    - name: "total_functional_currency_amount"
      expr: SUM(CAST(functional_currency_amount AS DOUBLE))
      comment: "Total transaction amount in functional currency"
    - name: "net_cash_flow"
      expr: SUM(CASE WHEN debit_credit_indicator = 'Credit' THEN CAST(transaction_amount AS DOUBLE) ELSE -CAST(transaction_amount AS DOUBLE) END)
      comment: "Net cash flow (credits minus debits)"
    - name: "total_cash_inflows"
      expr: SUM(CASE WHEN debit_credit_indicator = 'Credit' THEN CAST(transaction_amount AS DOUBLE) ELSE 0 END)
      comment: "Total cash inflows (credit transactions)"
    - name: "total_cash_outflows"
      expr: SUM(CASE WHEN debit_credit_indicator = 'Debit' THEN CAST(transaction_amount AS DOUBLE) ELSE 0 END)
      comment: "Total cash outflows (debit transactions)"
    - name: "avg_transaction_amount"
      expr: AVG(CAST(transaction_amount AS DOUBLE))
      comment: "Average transaction amount"
    - name: "transaction_count"
      expr: COUNT(1)
      comment: "Total number of bank transactions"
    - name: "reconciled_transaction_count"
      expr: SUM(CASE WHEN reconciliation_status = 'Reconciled' THEN 1 ELSE 0 END)
      comment: "Number of reconciled transactions"
    - name: "unreconciled_transaction_count"
      expr: SUM(CASE WHEN reconciliation_status != 'Reconciled' THEN 1 ELSE 0 END)
      comment: "Number of unreconciled transactions"
    - name: "reversal_transaction_count"
      expr: SUM(CASE WHEN reversal_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of reversal transactions"
    - name: "unique_bank_accounts"
      expr: COUNT(DISTINCT bank_account_id)
      comment: "Number of unique bank accounts with transactions"
    - name: "unique_legal_entities"
      expr: COUNT(DISTINCT legal_entity_id)
      comment: "Number of unique legal entities with transactions"
$$;


CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`finance_fixed_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fixed asset metrics tracking capital investments, depreciation, and asset lifecycle management"
  source: "`staffing_hr_ecm`.`finance`.`fixed_asset`"
  dimensions:
    - name: "asset_status"
      expr: asset_status
      comment: "Current status of the fixed asset"
    - name: "asset_category"
      expr: asset_category
      comment: "Category of fixed asset"
    - name: "asset_subcategory"
      expr: asset_subcategory
      comment: "Subcategory of fixed asset"
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Depreciation method used"
    - name: "lease_flag"
      expr: lease_flag
      comment: "Whether asset is leased"
    - name: "impairment_flag"
      expr: impairment_flag
      comment: "Whether asset has been impaired"
    - name: "acquisition_year"
      expr: YEAR(acquisition_date)
      comment: "Year of asset acquisition"
  measures:
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total acquisition cost of fixed assets"
    - name: "total_accumulated_depreciation"
      expr: SUM(CAST(accumulated_depreciation AS DOUBLE))
      comment: "Total accumulated depreciation"
    - name: "total_net_book_value"
      expr: SUM(CAST(net_book_value AS DOUBLE))
      comment: "Total net book value of fixed assets"
    - name: "total_salvage_value"
      expr: SUM(CAST(salvage_value AS DOUBLE))
      comment: "Total salvage value of fixed assets"
    - name: "total_disposal_proceeds"
      expr: SUM(CAST(disposal_proceeds AS DOUBLE))
      comment: "Total proceeds from asset disposals"
    - name: "total_gain_loss_on_disposal"
      expr: SUM(CAST(gain_loss_on_disposal AS DOUBLE))
      comment: "Total gain or loss on asset disposals"
    - name: "total_impairment_loss"
      expr: SUM(CAST(impairment_loss_amount AS DOUBLE))
      comment: "Total impairment loss recognized"
    - name: "depreciation_rate"
      expr: ROUND(100.0 * SUM(CAST(accumulated_depreciation AS DOUBLE)) / NULLIF(SUM(CAST(acquisition_cost AS DOUBLE)), 0), 2)
      comment: "Percentage of acquisition cost depreciated"
    - name: "avg_useful_life_months"
      expr: AVG(CAST(useful_life_months AS DOUBLE))
      comment: "Average useful life in months"
    - name: "asset_count"
      expr: COUNT(1)
      comment: "Total number of fixed assets"
    - name: "leased_asset_count"
      expr: SUM(CASE WHEN lease_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of leased assets"
    - name: "impaired_asset_count"
      expr: SUM(CASE WHEN impairment_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of impaired assets"
    - name: "unique_cost_centers"
      expr: COUNT(DISTINCT cost_center_id)
      comment: "Number of unique cost centers with fixed assets"
    - name: "unique_departments"
      expr: COUNT(DISTINCT department_id)
      comment: "Number of unique departments with fixed assets"
$$;


CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`finance_intercompany_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Intercompany transaction metrics tracking cross-entity transfers, reconciliation, and elimination accuracy"
  source: "`staffing_hr_ecm`.`finance`.`intercompany_transaction`"
  dimensions:
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of intercompany transaction"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the transaction"
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status between entities"
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of the transaction"
    - name: "elimination_flag"
      expr: elimination_flag
      comment: "Whether transaction should be eliminated in consolidation"
    - name: "is_reversal"
      expr: is_reversal
      comment: "Whether this is a reversal transaction"
    - name: "transaction_currency_code"
      expr: transaction_currency_code
      comment: "Currency of the transaction"
    - name: "reporting_currency_code"
      expr: reporting_currency_code
      comment: "Reporting currency"
    - name: "transfer_pricing_method"
      expr: transfer_pricing_method
      comment: "Transfer pricing method used"
    - name: "transaction_year"
      expr: YEAR(transaction_date)
      comment: "Year of transaction"
    - name: "transaction_quarter"
      expr: CONCAT('Q', QUARTER(transaction_date), '-', YEAR(transaction_date))
      comment: "Quarter of transaction"
    - name: "transaction_month"
      expr: DATE_TRUNC('MONTH', transaction_date)
      comment: "Month of transaction"
  measures:
    - name: "total_transaction_amount"
      expr: SUM(CAST(transaction_amount AS DOUBLE))
      comment: "Total intercompany transaction amount in transaction currency"
    - name: "total_reporting_amount"
      expr: SUM(CAST(reporting_amount AS DOUBLE))
      comment: "Total intercompany transaction amount in reporting currency"
    - name: "total_withholding_tax"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax on intercompany transactions"
    - name: "avg_exchange_rate"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average exchange rate used"
    - name: "avg_withholding_tax_rate"
      expr: AVG(CAST(withholding_tax_rate AS DOUBLE))
      comment: "Average withholding tax rate"
    - name: "transaction_count"
      expr: COUNT(1)
      comment: "Total number of intercompany transactions"
    - name: "approved_transaction_count"
      expr: SUM(CASE WHEN approval_status = 'Approved' THEN 1 ELSE 0 END)
      comment: "Number of approved transactions"
    - name: "reconciled_transaction_count"
      expr: SUM(CASE WHEN reconciliation_status = 'Reconciled' THEN 1 ELSE 0 END)
      comment: "Number of reconciled transactions"
    - name: "elimination_transaction_count"
      expr: SUM(CASE WHEN elimination_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of transactions requiring elimination"
    - name: "reversal_transaction_count"
      expr: SUM(CASE WHEN is_reversal = TRUE THEN 1 ELSE 0 END)
      comment: "Number of reversal transactions"
    - name: "unique_originating_entities"
      expr: COUNT(DISTINCT legal_entity_id)
      comment: "Number of unique originating legal entities"
    - name: "unique_receiving_entities"
      expr: COUNT(DISTINCT receiving_legal_entity_id)
      comment: "Number of unique receiving legal entities"
    - name: "unique_accounting_periods"
      expr: COUNT(DISTINCT accounting_period_id)
      comment: "Number of unique accounting periods with intercompany transactions"
$$;
