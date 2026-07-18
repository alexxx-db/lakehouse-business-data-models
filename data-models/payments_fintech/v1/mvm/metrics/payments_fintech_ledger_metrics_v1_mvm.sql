-- Metric views for domain: ledger | Business: Payments Fintech | Version: 1 | Generated on: 2026-05-03 21:26:52

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`ledger_journal_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core financial transaction KPIs derived from journal entries"
  source: "`payments_fintech_ecm`.`ledger`.`journal_entry`"
  dimensions:
    - name: "accounting_period_id"
      expr: accounting_period_id
      comment: "Identifier of the accounting period"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the entry"
    - name: "entry_type"
      expr: entry_type
      comment: "Type of journal entry (e.g., adjustment, regular)"
    - name: "segment_code"
      expr: segment_code
      comment: "Business segment code associated with the entry"
    - name: "source_system"
      expr: source_system
      comment: "Source system that generated the journal entry"
  measures:
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Sum of net amounts (debits minus credits) for journal entries"
    - name: "entry_count"
      expr: COUNT(1)
      comment: "Number of journal entry records"
$$;


CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`ledger_gl_balance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Balance sheet snapshot KPIs from GL balances"
  source: "`payments_fintech_ecm`.`ledger`.`gl_balance`"
  dimensions:
    - name: "accounting_period_id"
      expr: accounting_period_id
      comment: "Accounting period identifier"
    - name: "balance_type"
      expr: balance_type
      comment: "Type of balance (e.g., actual, budget)"
    - name: "is_consolidated"
      expr: is_consolidated
      comment: "Flag indicating if balance is consolidated"
    - name: "period_start_date"
      expr: period_start_date
      comment: "Start date of the balance period"
    - name: "period_end_date"
      expr: period_end_date
      comment: "End date of the balance period"
  measures:
    - name: "total_closing_balance"
      expr: SUM(CAST(closing_balance AS DOUBLE))
      comment: "Sum of closing balances for the period"
    - name: "total_opening_balance"
      expr: SUM(CAST(opening_balance AS DOUBLE))
      comment: "Sum of opening balances for the period"
    - name: "average_closing_balance"
      expr: AVG(CAST(closing_balance AS DOUBLE))
      comment: "Average closing balance per GL account"
    - name: "balance_record_count"
      expr: COUNT(1)
      comment: "Number of GL balance records"
$$;


CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`ledger_account_reconciliation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key reconciliation performance metrics"
  source: "`payments_fintech_ecm`.`ledger`.`account_reconciliation`"
  dimensions:
    - name: "accounting_period_id"
      expr: accounting_period_id
      comment: "Accounting period identifier"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the reconciliation"
    - name: "account_reconciliation_status"
      expr: account_reconciliation_status
      comment: "Current status of the reconciliation"
    - name: "is_auto_reconciled"
      expr: is_auto_reconciled
      comment: "Indicates if reconciliation was performed automatically"
    - name: "is_consolidated"
      expr: is_consolidated
      comment: "Indicates if reconciliation is consolidated across entities"
  measures:
    - name: "total_adjusted_balance"
      expr: SUM(CAST(adjusted_balance AS DOUBLE))
      comment: "Sum of adjusted balances after reconciliation"
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Sum of variance amounts identified during reconciliation"
    - name: "average_variance_amount"
      expr: AVG(CAST(variance_amount AS DOUBLE))
      comment: "Average variance amount per reconciliation"
    - name: "reconciliation_count"
      expr: COUNT(1)
      comment: "Number of reconciliation records"
$$;


CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`ledger_revenue_recognition_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue recognition KPIs for financial reporting"
  source: "`payments_fintech_ecm`.`ledger`.`revenue_recognition_event`"
  dimensions:
    - name: "accounting_period_id"
      expr: accounting_period_id
      comment: "Accounting period identifier"
    - name: "recognition_status"
      expr: recognition_status
      comment: "Status of the revenue recognition (e.g., recognized, pending)"
    - name: "is_manual_entry"
      expr: is_manual_entry
      comment: "Flag indicating if the entry was entered manually"
    - name: "source_system"
      expr: source_system
      comment: "Source system that generated the recognition event"
  measures:
    - name: "total_recognized_amount"
      expr: SUM(CAST(recognized_amount AS DOUBLE))
      comment: "Sum of revenue recognized in the period"
    - name: "total_remaining_deferred_amount"
      expr: SUM(CAST(remaining_deferred_amount AS DOUBLE))
      comment: "Sum of revenue still deferred"
    - name: "average_recognized_amount"
      expr: AVG(CAST(recognized_amount AS DOUBLE))
      comment: "Average recognized amount per event"
    - name: "recognition_event_count"
      expr: COUNT(1)
      comment: "Number of revenue recognition events"
$$;


CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`ledger_payable`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payable processing efficiency and cost metrics"
  source: "`payments_fintech_ecm`.`ledger`.`payable`"
  dimensions:
    - name: "legal_entity_id"
      expr: legal_entity_id
      comment: "Legal entity responsible for the payable"
    - name: "party_id"
      expr: party_id
      comment: "Vendor party identifier"
    - name: "payment_method"
      expr: payment_method
      comment: "Method used to settle the payable"
    - name: "is_early_payment_discount_applied"
      expr: is_early_payment_discount_applied
      comment: "Flag indicating early‑payment discount usage"
    - name: "is_tax_exempt"
      expr: is_tax_exempt
      comment: "Flag indicating tax‑exempt status"
  measures:
    - name: "total_invoice_amount"
      expr: SUM(CAST(invoice_amount AS DOUBLE))
      comment: "Sum of invoice amounts for payables"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Sum of net payable amounts after discounts and taxes"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Sum of early‑payment discounts applied"
    - name: "average_days_to_payment"
      expr: AVG(DATEDIFF(payment_date, due_date))
      comment: "Average number of days between due date and actual payment date"
    - name: "payable_count"
      expr: COUNT(1)
      comment: "Number of payable records"
$$;


CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`ledger_receivable`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Receivable collection performance metrics"
  source: "`payments_fintech_ecm`.`ledger`.`receivable`"
  dimensions:
    - name: "legal_entity_id"
      expr: legal_entity_id
      comment: "Legal entity owning the receivable"
    - name: "party_id"
      expr: party_id
      comment: "Customer party identifier"
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used by the customer"
  measures:
    - name: "total_invoice_amount"
      expr: SUM(CAST(invoice_amount AS DOUBLE))
      comment: "Sum of invoice amounts for receivables"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Sum of net receivable amounts after taxes and fees"
    - name: "average_days_to_due"
      expr: AVG(DATEDIFF(due_date, invoice_date))
      comment: "Average number of days between invoice date and due date"
    - name: "receivable_count"
      expr: COUNT(1)
      comment: "Number of receivable records"
$$;
