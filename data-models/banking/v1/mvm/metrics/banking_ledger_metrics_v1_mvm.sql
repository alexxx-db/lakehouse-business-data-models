-- Metric views for domain: ledger | Business: Banking | Version: 1 | Generated on: 2026-05-03 02:23:20

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`ledger_journal_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core journal entry activity and financial impact metrics"
  source: "`banking_ecm`.`ledger`.`journal_entry`"
  dimensions:
    - name: "accounting_period_id"
      expr: accounting_period_id
      comment: "Foreign key to accounting period"
    - name: "posting_status"
      expr: posting_status
      comment: "Current posting status of the journal entry"
    - name: "intercompany_indicator"
      expr: intercompany_indicator
      comment: "Flag indicating intercompany nature"
    - name: "journal_category"
      expr: journal_category
      comment: "Category of the journal entry"
  measures:
    - name: "total_journal_entries"
      expr: COUNT(1)
      comment: "Count of journal entries"
    - name: "total_debit_amount"
      expr: SUM(CAST(total_debit_amount AS DOUBLE))
      comment: "Sum of debit amounts across all journal entries"
    - name: "total_credit_amount"
      expr: SUM(CAST(total_credit_amount AS DOUBLE))
      comment: "Sum of credit amounts across all journal entries"
    - name: "average_debit_amount"
      expr: AVG(CAST(total_debit_amount AS DOUBLE))
      comment: "Average debit amount per journal entry"
    - name: "average_credit_amount"
      expr: AVG(CAST(total_credit_amount AS DOUBLE))
      comment: "Average credit amount per journal entry"
    - name: "intercompany_journal_count"
      expr: SUM(CASE WHEN intercompany_indicator THEN 1 ELSE 0 END)
      comment: "Number of intercompany journal entries"
$$;


CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`ledger_journal_entry_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Detailed line‑level financial activity metrics"
  source: "`banking_ecm`.`ledger`.`journal_entry_line`"
  dimensions:
    - name: "accounting_period_id"
      expr: accounting_period_id
      comment: "Accounting period for the line"
    - name: "gl_account_id"
      expr: gl_account_id
      comment: "GL account referenced"
    - name: "cost_center_id"
      expr: cost_center_id
      comment: "Cost center associated with the line"
    - name: "profit_center_id"
      expr: profit_center_id
      comment: "Profit center associated with the line"
    - name: "instrument_id"
      expr: instrument_id
      comment: "Financial instrument identifier"
    - name: "channel_id"
      expr: channel_id
      comment: "Banking channel used"
    - name: "posting_date"
      expr: posting_date
      comment: "Date the line was posted (time dimension)"
    - name: "line_description"
      expr: line_description
      comment: "Narrative description of the line"
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Indicates if the line is a reversal"
    - name: "statistical_unit"
      expr: statistical_unit
      comment: "Statistical unit for regulatory reporting"
  measures:
    - name: "total_journal_entry_lines"
      expr: COUNT(1)
      comment: "Count of journal entry line records"
    - name: "total_debit_amount"
      expr: SUM(CAST(debit_amount AS DOUBLE))
      comment: "Sum of debit amounts on journal entry lines"
    - name: "total_credit_amount"
      expr: SUM(CAST(credit_amount AS DOUBLE))
      comment: "Sum of credit amounts on journal entry lines"
    - name: "total_statistical_amount"
      expr: SUM(CAST(statistical_amount AS DOUBLE))
      comment: "Sum of statistical amounts (used for regulatory reporting)"
    - name: "average_debit_amount"
      expr: AVG(CAST(debit_amount AS DOUBLE))
      comment: "Average debit amount per line"
    - name: "distinct_gl_accounts"
      expr: COUNT(DISTINCT gl_account_id)
      comment: "Number of unique GL accounts referenced"
$$;


CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`ledger_trial_balance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Consolidated balance sheet snapshot metrics"
  source: "`banking_ecm`.`ledger`.`trial_balance`"
  dimensions:
    - name: "accounting_period_id"
      expr: accounting_period_id
      comment: "Accounting period for the trial balance"
    - name: "legal_entity_id"
      expr: legal_entity_id
      comment: "Legal entity of the balance"
    - name: "gl_account_id"
      expr: gl_account_id
      comment: "GL account represented"
    - name: "cost_center_id"
      expr: cost_center_id
      comment: "Cost center associated"
    - name: "profit_center_id"
      expr: profit_center_id
      comment: "Profit center associated"
    - name: "currency_id"
      expr: currency_id
      comment: "Currency of the balances"
    - name: "balance_type"
      expr: balance_type
      comment: "Type of balance (e.g., actual, budget)"
    - name: "balance_status"
      expr: balance_status
      comment: "Status of the balance record"
  measures:
    - name: "total_trial_balance_records"
      expr: COUNT(1)
      comment: "Count of trial balance rows"
    - name: "total_opening_balance_debit"
      expr: SUM(CAST(opening_balance_debit AS DOUBLE))
      comment: "Sum of opening debit balances"
    - name: "total_opening_balance_credit"
      expr: SUM(CAST(opening_balance_credit AS DOUBLE))
      comment: "Sum of opening credit balances"
    - name: "total_closing_balance_debit"
      expr: SUM(CAST(closing_balance_debit AS DOUBLE))
      comment: "Sum of closing debit balances"
    - name: "total_closing_balance_credit"
      expr: SUM(CAST(closing_balance_credit AS DOUBLE))
      comment: "Sum of closing credit balances"
    - name: "total_period_debit_activity"
      expr: SUM(CAST(period_debit_activity AS DOUBLE))
      comment: "Sum of debit activity during the period"
    - name: "total_period_credit_activity"
      expr: SUM(CAST(period_credit_activity AS DOUBLE))
      comment: "Sum of credit activity during the period"
    - name: "intercompany_balance_flagged"
      expr: SUM(CASE WHEN intercompany_flag THEN 1 ELSE 0 END)
      comment: "Count of intercompany balance rows"
$$;


CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`ledger_intercompany_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key intercompany transaction performance and tax metrics"
  source: "`banking_ecm`.`ledger`.`intercompany_transaction`"
  dimensions:
    - name: "accounting_period_id"
      expr: accounting_period_id
      comment: "Accounting period of the transaction"
    - name: "legal_entity_id"
      expr: legal_entity_id
      comment: "Legal entity that originated the transaction"
    - name: "counterparty_legal_entity_id"
      expr: primary_intercompany_counterparty_legal_entity_id
      comment: "Counterparty legal entity"
    - name: "transaction_type"
      expr: transaction_type
      comment: "Business type of the transaction"
    - name: "settlement_date"
      expr: settlement_date
      comment: "Date the transaction settled (time dimension)"
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Indicates if the transaction was reversed"
    - name: "transfer_pricing_method"
      expr: transfer_pricing_method
      comment: "Method used for transfer pricing"
  measures:
    - name: "total_intercompany_transactions"
      expr: COUNT(1)
      comment: "Count of intercompany transactions"
    - name: "total_transaction_amount"
      expr: SUM(CAST(transaction_amount AS DOUBLE))
      comment: "Sum of transaction amounts in functional currency"
    - name: "total_withholding_tax_amount"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Sum of withholding tax amounts"
    - name: "average_transaction_amount"
      expr: AVG(CAST(transaction_amount AS DOUBLE))
      comment: "Average transaction amount"
    - name: "reversed_transactions"
      expr: SUM(CASE WHEN reversal_flag THEN 1 ELSE 0 END)
      comment: "Count of reversed intercompany transactions"
$$;


CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`ledger_gl_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "GL account governance and risk metrics"
  source: "`banking_ecm`.`ledger`.`gl_account`"
  dimensions:
    - name: "account_type"
      expr: account_type
      comment: "Classification of the account (e.g., asset, liability)"
    - name: "account_category"
      expr: account_category
      comment: "Higher‑level category for reporting"
    - name: "posting_allowed_flag"
      expr: posting_allowed_flag
      comment: "Indicates if posting is permitted"
    - name: "intercompany_flag"
      expr: intercompany_flag
      comment: "Flag for intercompany accounts"
    - name: "statistical_account_flag"
      expr: statistical_account_flag
      comment: "Statistical account indicator"
  measures:
    - name: "total_gl_accounts"
      expr: COUNT(1)
      comment: "Count of GL accounts"
    - name: "total_materiality_threshold"
      expr: SUM(CAST(materiality_threshold_amount AS DOUBLE))
      comment: "Sum of materiality thresholds across accounts"
    - name: "average_materiality_threshold"
      expr: AVG(CAST(materiality_threshold_amount AS DOUBLE))
      comment: "Average materiality threshold per account"
    - name: "reconciliation_required_count"
      expr: SUM(CASE WHEN reconciliation_required_flag THEN 1 ELSE 0 END)
      comment: "Number of accounts requiring reconciliation"
$$;
