-- Metric views for domain: billing | Business: Water_Utilities | Version: 2 | Generated on: 2026-07-02 04:05:05

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`billing_adjustment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial impact and governance of billing adjustments"
  source: "`vibe_water_utilities_v1`.`billing`.`adjustment`"
  dimensions:
    - name: "adjustment_type"
      expr: adjustment_type
      comment: "Category of the adjustment (e.g., credit, surcharge)"
    - name: "adjustment_status"
      expr: adjustment_status
      comment: "Current status of the adjustment"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the adjustment amount"
    - name: "service_type"
      expr: service_type
      comment: "Service type to which the adjustment applies"
    - name: "billing_period_month"
      expr: DATE_TRUNC('month', billing_period_start_date)
      comment: "Month of the billing period for the adjustment"
  measures:
    - name: "total_adjustment_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Sum of all adjustment amounts"
    - name: "adjustment_count"
      expr: COUNT(1)
      comment: "Number of adjustment records"
    - name: "average_adjustment_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average amount per adjustment"
    - name: "total_approval_threshold"
      expr: SUM(CAST(approval_threshold_amount AS DOUBLE))
      comment: "Sum of approval threshold amounts for adjustments"
    - name: "reversal_adjustment_amount"
      expr: SUM(CASE WHEN reversal_flag THEN amount ELSE 0 END)
      comment: "Total amount of adjustments that were reversed"
    - name: "reversal_adjustment_count"
      expr: SUM(CASE WHEN reversal_flag THEN 1 ELSE 0 END)
      comment: "Count of reversed adjustments"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`billing_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Overall financial health of billing accounts"
  source: "`vibe_water_utilities_v1`.`billing`.`billing_account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Operational status of the account"
    - name: "account_type"
      expr: account_type
      comment: "Classification of the account (e.g., residential, commercial)"
    - name: "tax_exempt"
      expr: tax_exempt
      comment: "Flag indicating tax‑exempt status"
    - name: "autopay_enrolled"
      expr: autopay_enrolled
      comment: "Flag indicating enrollment in auto‑pay"
    - name: "paperless_billing"
      expr: paperless_billing
      comment: "Flag indicating paperless billing preference"
  measures:
    - name: "total_current_balance"
      expr: SUM(CAST(current_balance AS DOUBLE))
      comment: "Aggregate current balance across billing accounts"
    - name: "total_current_charges"
      expr: SUM(CAST(current_charges AS DOUBLE))
      comment: "Aggregate current charges across billing accounts"
    - name: "total_past_due_amount"
      expr: SUM(CAST(past_due_amount AS DOUBLE))
      comment: "Total past‑due amount across accounts"
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Sum of credit limits assigned to accounts"
    - name: "average_current_balance"
      expr: AVG(CAST(current_balance AS DOUBLE))
      comment: "Average current balance per account"
    - name: "billing_account_count"
      expr: COUNT(1)
      comment: "Number of billing accounts"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`billing_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key invoice financial and timeliness metrics"
  source: "`vibe_water_utilities_v1`.`billing`.`invoice`"
  dimensions:
    - name: "customer_account_id"
      expr: customer_account_id
      comment: "Identifier of the customer account"
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the invoice"
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type/category of the invoice"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for the invoice amounts"
    - name: "billing_month"
      expr: DATE_TRUNC('month', billing_period_start_date)
      comment: "Month of the billing period start"
  measures:
    - name: "total_invoice_amount"
      expr: SUM(CAST(total_amount_due AS DOUBLE))
      comment: "Sum of total amount due across all invoices"
    - name: "total_water_charge"
      expr: SUM(CAST(water_charge_amount AS DOUBLE))
      comment: "Sum of water charge amounts"
    - name: "total_wastewater_charge"
      expr: SUM(CAST(wastewater_charge_amount AS DOUBLE))
      comment: "Sum of wastewater charge amounts"
    - name: "total_stormwater_charge"
      expr: SUM(CAST(stormwater_charge_amount AS DOUBLE))
      comment: "Sum of stormwater charge amounts"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Sum of tax amounts across invoices"
    - name: "average_invoice_amount"
      expr: AVG(CAST(total_amount_due AS DOUBLE))
      comment: "Average total amount due per invoice"
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Number of invoices"
    - name: "average_days_to_due"
      expr: AVG(DATEDIFF(due_date, invoice_date))
      comment: "Average number of days between invoice date and due date"
    - name: "final_invoice_count"
      expr: SUM(CASE WHEN is_final THEN 1 ELSE 0 END)
      comment: "Count of invoices marked as final"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`billing_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment collection and performance metrics"
  source: "`vibe_water_utilities_v1`.`billing`.`payment`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Current processing status of the payment"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the payment"
    - name: "payment_type"
      expr: payment_type
      comment: "Classification of payment (e.g., auto-pay, one-time)"
    - name: "is_auto_pay"
      expr: is_auto_pay
      comment: "Flag indicating if payment is part of an auto‑pay enrollment"
    - name: "payment_month"
      expr: DATE_TRUNC('month', payment_date)
      comment: "Month in which the payment was made"
  measures:
    - name: "total_payment_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total amount of payments received"
    - name: "total_applied_amount"
      expr: SUM(CAST(applied_amount AS DOUBLE))
      comment: "Total amount of payments applied to invoices"
    - name: "payment_count"
      expr: COUNT(1)
      comment: "Number of payment records"
    - name: "average_payment_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average payment amount per transaction"
    - name: "total_nsf_fee_amount"
      expr: SUM(CAST(nsf_fee_amount AS DOUBLE))
      comment: "Total non-sufficient funds fees assessed"
    - name: "nsf_fee_count"
      expr: SUM(CASE WHEN nsf_indicator THEN 1 ELSE 0 END)
      comment: "Count of payments flagged with NSF"
    - name: "total_unapplied_amount"
      expr: SUM(CAST(unapplied_amount AS DOUBLE))
      comment: "Total amount of payments not yet applied"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`billing_revenue_recognition_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key revenue recognition performance indicators"
  source: "`vibe_water_utilities_v1`.`billing`.`revenue_recognition_event`"
  dimensions:
    - name: "revenue_class"
      expr: revenue_class
      comment: "Revenue classification (e.g., water, wastewater, stormwater)"
    - name: "service_type"
      expr: service_type
      comment: "Type of service associated with the revenue"
    - name: "event_type"
      expr: event_type
      comment: "Category of the revenue event"
    - name: "event_status"
      expr: event_status
      comment: "Current status of the revenue event"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the revenue amounts"
    - name: "accounting_period"
      expr: accounting_period
      comment: "Fiscal accounting period identifier"
  measures:
    - name: "total_recognized_revenue"
      expr: SUM(CAST(recognized_revenue_amount AS DOUBLE))
      comment: "Sum of revenue that has been recognized"
    - name: "total_deferred_revenue"
      expr: SUM(CAST(deferred_revenue_amount AS DOUBLE))
      comment: "Sum of revenue deferred to future periods"
    - name: "total_accrued_revenue"
      expr: SUM(CAST(accrued_revenue_amount AS DOUBLE))
      comment: "Sum of accrued revenue amounts"
    - name: "total_unbilled_revenue"
      expr: SUM(CAST(unbilled_revenue_amount AS DOUBLE))
      comment: "Sum of revenue that has not yet been billed"
    - name: "revenue_event_count"
      expr: COUNT(1)
      comment: "Number of revenue recognition events"
    - name: "average_recognized_revenue"
      expr: AVG(CAST(recognized_revenue_amount AS DOUBLE))
      comment: "Average recognized revenue per event"
$$;