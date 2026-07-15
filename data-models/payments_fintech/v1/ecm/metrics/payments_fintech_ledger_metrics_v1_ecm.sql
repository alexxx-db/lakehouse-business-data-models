-- Metric views for domain: ledger | Business: Payments Fintech | Version: 1 | Generated on: 2026-05-03 18:22:09

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`ledger_account_reconciliation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core reconciliation performance metrics used by finance leadership to monitor accuracy and automation"
  source: "`payments_fintech_ecm`.`ledger`.`account_reconciliation`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the reconciliation"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period identifier"
    - name: "currency_id"
      expr: currency_id
      comment: "Currency of the reconciliation amounts"
    - name: "gl_account_id"
      expr: gl_account_id
      comment: "General ledger account involved"
    - name: "is_auto_reconciled"
      expr: is_auto_reconciled
      comment: "Flag indicating if the reconciliation was performed automatically"
    - name: "account_reconciliation_status"
      expr: account_reconciliation_status
      comment: "Current status of the reconciliation"
  measures:
    - name: "total_reconciliations"
      expr: COUNT(1)
      comment: "Number of reconciliation records"
    - name: "total_adjusted_balance"
      expr: SUM(CAST(adjusted_balance AS DOUBLE))
      comment: "Sum of adjusted balances across reconciliations"
    - name: "avg_variance_amount"
      expr: AVG(CAST(variance_amount AS DOUBLE))
      comment: "Average variance amount per reconciliation"
    - name: "auto_reconciled_count"
      expr: SUM(CASE WHEN is_auto_reconciled THEN 1 ELSE 0 END)
      comment: "Count of reconciliations that were auto‑reconciled"
$$;


CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`ledger_gl_balance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Balance sheet health indicators for each GL account and cost center"
  source: "`payments_fintech_ecm`.`ledger`.`gl_balance`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the balance"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period"
    - name: "gl_account_id"
      expr: gl_account_id
      comment: "GL account identifier"
    - name: "cost_center_id"
      expr: cost_center_id
      comment: "Cost center associated with the balance"
    - name: "currency_id"
      expr: currency_id
      comment: "Currency of the balance amounts"
    - name: "balance_type"
      expr: balance_type
      comment: "Type of balance (e.g., actual, budget)"
    - name: "is_consolidated"
      expr: is_consolidated
      comment: "Indicates if the balance is consolidated across entities"
  measures:
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of GL balance rows"
    - name: "total_opening_balance"
      expr: SUM(CAST(opening_balance AS DOUBLE))
      comment: "Sum of opening balances for the period"
    - name: "total_closing_balance"
      expr: SUM(CAST(closing_balance AS DOUBLE))
      comment: "Sum of closing balances for the period"
    - name: "total_period_credits"
      expr: SUM(CAST(period_credits AS DOUBLE))
      comment: "Total credit amount posted in the period"
    - name: "total_period_debits"
      expr: SUM(CAST(period_debits AS DOUBLE))
      comment: "Total debit amount posted in the period"
$$;


CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`ledger_payable`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payable efficiency and cash‑flow impact metrics for treasury and finance teams"
  source: "`payments_fintech_ecm`.`ledger`.`payable`"
  dimensions:
    - name: "fiscal_year"
      expr: DATE_TRUNC('year', due_date)
      comment: "Fiscal year derived from due date"
    - name: "currency_id"
      expr: currency_id
      comment: "Currency of the payable"
    - name: "vendor_id"
      expr: vendor_id
      comment: "Vendor associated with the payable"
    - name: "payment_status"
      expr: payment_status
      comment: "Current payment status"
    - name: "is_consolidated"
      expr: is_consolidated
      comment: "Whether the payable is part of a consolidated view"
  measures:
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of payable records"
    - name: "total_invoice_amount"
      expr: SUM(CAST(invoice_amount AS DOUBLE))
      comment: "Total invoiced amount for payables"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net amount after discounts and taxes"
    - name: "avg_days_to_pay"
      expr: AVG(DATEDIFF(payment_date, due_date))
      comment: "Average number of days taken to pay invoices"
    - name: "overdue_count"
      expr: SUM(CASE WHEN payment_date > due_date THEN 1 ELSE 0 END)
      comment: "Count of invoices paid after the due date"
    - name: "total_overdue_amount"
      expr: SUM(CASE WHEN payment_date > due_date THEN net_amount ELSE 0 END)
      comment: "Total net amount of overdue payments"
$$;


CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`ledger_receivable`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key revenue collection metrics used by credit and collections leadership"
  source: "`payments_fintech_ecm`.`ledger`.`receivable`"
  dimensions:
    - name: "fiscal_year"
      expr: DATE_TRUNC('year', due_date)
      comment: "Fiscal year derived from due date"
    - name: "currency_id"
      expr: currency_id
      comment: "Currency of the receivable"
    - name: "merchant_id"
      expr: merchant_id
      comment: "Merchant associated with the receivable"
    - name: "segment_code"
      expr: segment_code
      comment: "Business segment code"
    - name: "payment_channel"
      expr: payment_channel
      comment: "Channel through which payment is expected"
  measures:
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of receivable records"
    - name: "total_invoice_amount"
      expr: SUM(CAST(invoice_amount AS DOUBLE))
      comment: "Total invoiced amount for receivables"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net amount expected from customers"
    - name: "avg_days_outstanding"
      expr: AVG(DATEDIFF(CURRENT_DATE, due_date))
      comment: "Average days receivables have been outstanding"
    - name: "overdue_amount"
      expr: SUM(CASE WHEN due_date < CURRENT_DATE THEN net_amount ELSE 0 END)
      comment: "Total net amount that is past due"
$$;


CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`ledger_financial_statement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic performance snapshot for executive review"
  source: "`payments_fintech_ecm`.`ledger`.`financial_statement`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the statement"
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter"
    - name: "statement_type"
      expr: statement_type
      comment: "Type of financial statement (e.g., balance_sheet, income_statement)"
    - name: "legal_entity_id"
      expr: legal_entity_id
      comment: "Legal entity the statement belongs to"
  measures:
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of financial statement rows"
    - name: "total_revenue"
      expr: SUM(CAST(revenue AS DOUBLE))
      comment: "Total revenue reported"
    - name: "total_expense"
      expr: SUM(CAST(expense AS DOUBLE))
      comment: "Total expense reported"
    - name: "total_net_income"
      expr: SUM(CAST(net_income AS DOUBLE))
      comment: "Total net income (profit) reported"
    - name: "total_assets"
      expr: SUM(CAST(total_assets AS DOUBLE))
      comment: "Total assets reported"
    - name: "total_liabilities"
      expr: SUM(CAST(total_liabilities AS DOUBLE))
      comment: "Total liabilities reported"
    - name: "cash_flow_operations"
      expr: SUM(CAST(cash_flow_from_operations AS DOUBLE))
      comment: "Cash flow from operating activities"
    - name: "cash_flow_investing"
      expr: SUM(CAST(cash_flow_from_investing AS DOUBLE))
      comment: "Cash flow from investing activities"
    - name: "cash_flow_financing"
      expr: SUM(CAST(cash_flow_from_financing AS DOUBLE))
      comment: "Cash flow from financing activities"
$$;


CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`ledger_intercompany_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Intercompany transaction monitoring for consolidation and tax compliance"
  source: "`payments_fintech_ecm`.`ledger`.`intercompany_transaction`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the transaction"
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter"
    - name: "legal_entity_id"
      expr: legal_entity_id
      comment: "Legal entity originating the transaction"
    - name: "receiving_entity_legal_entity_id"
      expr: receiving_entity_legal_entity_id
      comment: "Legal entity receiving the transaction"
    - name: "elimination_flag"
      expr: elimination_flag
      comment: "Whether the transaction is marked for elimination"
    - name: "approval_status"
      expr: approval_status
      comment: "Current approval status"
  measures:
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of intercompany transaction rows"
    - name: "total_gross_amount"
      expr: SUM(CAST(amount_gross AS DOUBLE))
      comment: "Total gross amount of intercompany transactions"
    - name: "total_net_amount"
      expr: SUM(CAST(amount_net AS DOUBLE))
      comment: "Total net amount after adjustments"
    - name: "total_fee_amount"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total fees associated with intercompany transactions"
    - name: "elimination_flagged_count"
      expr: SUM(CASE WHEN elimination_flag THEN 1 ELSE 0 END)
      comment: "Count of transactions flagged for elimination"
$$;


CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`ledger_fx_revaluation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "FX impact metrics for treasury risk management"
  source: "`payments_fintech_ecm`.`ledger`.`fx_revaluation`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the revaluation"
    - name: "currency_id"
      expr: currency_id
      comment: "Currency being revalued"
    - name: "gl_account_id"
      expr: gl_account_id
      comment: "GL account affected by revaluation"
  measures:
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of FX revaluation rows"
    - name: "total_unrealized_gain_loss"
      expr: SUM(CAST(unrealized_gain_loss_amount AS DOUBLE))
      comment: "Total unrealized gain/loss from FX revaluation"
    - name: "total_original_balance"
      expr: SUM(CAST(original_balance AS DOUBLE))
      comment: "Sum of original balances before revaluation"
    - name: "total_revalued_balance"
      expr: SUM(CAST(revalued_balance AS DOUBLE))
      comment: "Sum of balances after revaluation"
$$;


CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`ledger_tax_provision`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tax provision health indicators for finance and tax compliance"
  source: "`payments_fintech_ecm`.`ledger`.`tax_provision`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the tax provision"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period"
    - name: "legal_entity_id"
      expr: legal_entity_id
      comment: "Legal entity the provision applies to"
    - name: "tax_type"
      expr: tax_type
      comment: "Type of tax (e.g., income, sales)"
  measures:
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of tax provision rows"
    - name: "total_current_tax_expense"
      expr: SUM(CAST(current_tax_expense AS DOUBLE))
      comment: "Total current period tax expense"
    - name: "total_deferred_tax_asset"
      expr: SUM(CAST(deferred_tax_asset AS DOUBLE))
      comment: "Total deferred tax assets"
    - name: "total_deferred_tax_liability"
      expr: SUM(CAST(deferred_tax_liability AS DOUBLE))
      comment: "Total deferred tax liabilities"
    - name: "avg_effective_tax_rate"
      expr: AVG(CAST(effective_tax_rate AS DOUBLE))
      comment: "Average effective tax rate across provisions"
$$;
