-- Metric views for domain: billing | Business: Legal | Version: 1 | Generated on: 2026-05-07 11:54:14

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`billing_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core invoice performance metrics tracking revenue, collections, and billing efficiency across matters, clients, and practice areas"
  source: "`legal_ecm`.`billing`.`invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the invoice (draft, sent, paid, disputed, written off)"
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of invoice (standard, interim, final, supplemental)"
    - name: "fee_arrangement_type"
      expr: fee_arrangement_type
      comment: "Fee arrangement governing this invoice (hourly, fixed, contingency, blended)"
    - name: "invoice_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month the invoice was issued"
    - name: "invoice_year"
      expr: YEAR(invoice_date)
      comment: "Year the invoice was issued"
    - name: "due_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month the invoice payment is due"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the invoice is denominated"
    - name: "billing_office_code"
      expr: billing_office_code
      comment: "Office that issued the invoice"
    - name: "ebilling_submission_status"
      expr: ebilling_submission_status
      comment: "Status of electronic billing submission (accepted, rejected, pending)"
    - name: "is_electronic_billing"
      expr: is_electronic_billing
      comment: "Whether invoice was submitted via electronic billing portal"
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms for the invoice (Net 30, Net 60, etc.)"
  measures:
    - name: "total_invoice_count"
      expr: COUNT(1)
      comment: "Total number of invoices"
    - name: "total_fees_billed"
      expr: SUM(CAST(fees_amount AS DOUBLE))
      comment: "Total professional fees billed across all invoices"
    - name: "total_disbursements_billed"
      expr: SUM(CAST(disbursements_amount AS DOUBLE))
      comment: "Total disbursements and expenses billed"
    - name: "total_tax_billed"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount billed"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net invoice amount (fees + disbursements + tax - discounts)"
    - name: "total_amount_paid"
      expr: SUM(CAST(amount_paid AS DOUBLE))
      comment: "Total amount collected on invoices"
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total outstanding receivables across all invoices"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts applied to invoices"
    - name: "total_write_off_amount"
      expr: SUM(CAST(write_off_amount AS DOUBLE))
      comment: "Total amount written off from invoices"
    - name: "avg_invoice_value"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average invoice value across all invoices"
    - name: "avg_days_to_payment"
      expr: AVG(DATEDIFF(approved_date, invoice_date))
      comment: "Average number of days from invoice date to approval"
    - name: "collection_rate_numerator"
      expr: SUM(CAST(amount_paid AS DOUBLE))
      comment: "Numerator for collection rate calculation (total collected)"
    - name: "collection_rate_denominator"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Denominator for collection rate calculation (total billed)"
    - name: "write_off_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(write_off_amount AS DOUBLE)) / NULLIF(SUM(CAST(net_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of billed amount written off"
    - name: "discount_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(net_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of billed amount discounted"
    - name: "distinct_matters_billed"
      expr: COUNT(DISTINCT matter_id)
      comment: "Number of unique matters invoiced"
    - name: "distinct_clients_billed"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique clients invoiced"
    - name: "ebilling_rejection_count"
      expr: COUNT(CASE WHEN ebilling_submission_status = 'rejected' THEN 1 END)
      comment: "Number of invoices rejected by electronic billing portals"
$$;


CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`billing_ar_balance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts receivable aging and collections performance metrics tracking outstanding balances, aging buckets, and collection effectiveness"
  source: "`legal_ecm`.`billing`.`ar_balance`"
  dimensions:
    - name: "collection_status"
      expr: collection_status
      comment: "Current collection status (current, overdue, in collections, legal action)"
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Whether the AR balance is under dispute"
    - name: "dispute_reason"
      expr: dispute_reason
      comment: "Reason for dispute if flagged"
    - name: "fee_arrangement_type"
      expr: fee_arrangement_type
      comment: "Fee arrangement type for the matter"
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "Billing frequency for the client/matter"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the AR balance"
    - name: "credit_terms_days"
      expr: credit_terms_days
      comment: "Credit terms in days (Net 30, Net 60, etc.)"
    - name: "days_outstanding_bucket"
      expr: days_outstanding
      comment: "Days outstanding bucket for aging analysis"
    - name: "due_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month the balance was due"
    - name: "last_payment_month"
      expr: DATE_TRUNC('MONTH', last_payment_date)
      comment: "Month of last payment received"
    - name: "iolta_flag"
      expr: iolta_flag
      comment: "Whether balance is subject to IOLTA trust accounting rules"
  measures:
    - name: "total_ar_records"
      expr: COUNT(1)
      comment: "Total number of AR balance records"
    - name: "total_current_balance"
      expr: SUM(CAST(current_balance AS DOUBLE))
      comment: "Total outstanding AR balance across all records"
    - name: "total_original_invoice_amount"
      expr: SUM(CAST(original_invoice_amount AS DOUBLE))
      comment: "Total original invoice amount before payments and adjustments"
    - name: "total_payments_applied"
      expr: SUM(CAST(total_payments_applied AS DOUBLE))
      comment: "Total payments applied to AR balances"
    - name: "total_credits_applied"
      expr: SUM(CAST(total_credits_applied AS DOUBLE))
      comment: "Total credits applied to AR balances"
    - name: "total_interest_accrued"
      expr: SUM(CAST(interest_accrued AS DOUBLE))
      comment: "Total interest accrued on overdue balances"
    - name: "total_last_payment_amount"
      expr: SUM(CAST(last_payment_amount AS DOUBLE))
      comment: "Total of most recent payments received"
    - name: "total_bucket_0_30"
      expr: SUM(CAST(bucket_0_30_amount AS DOUBLE))
      comment: "Total AR balance aged 0-30 days"
    - name: "total_bucket_31_60"
      expr: SUM(CAST(bucket_31_60_amount AS DOUBLE))
      comment: "Total AR balance aged 31-60 days"
    - name: "total_bucket_61_90"
      expr: SUM(CAST(bucket_61_90_amount AS DOUBLE))
      comment: "Total AR balance aged 61-90 days"
    - name: "total_bucket_over_90"
      expr: SUM(CAST(bucket_over_90_amount AS DOUBLE))
      comment: "Total AR balance aged over 90 days"
    - name: "avg_current_balance"
      expr: AVG(CAST(current_balance AS DOUBLE))
      comment: "Average outstanding balance per AR record"
    - name: "collection_effectiveness_pct"
      expr: ROUND(100.0 * SUM(CAST(total_payments_applied AS DOUBLE)) / NULLIF(SUM(CAST(original_invoice_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of original invoice amount collected"
    - name: "aging_over_90_pct"
      expr: ROUND(100.0 * SUM(CAST(bucket_over_90_amount AS DOUBLE)) / NULLIF(SUM(CAST(current_balance AS DOUBLE)), 0), 2)
      comment: "Percentage of current AR balance aged over 90 days"
    - name: "disputed_balance_count"
      expr: COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END)
      comment: "Number of AR balances under dispute"
    - name: "disputed_balance_amount"
      expr: SUM(CASE WHEN dispute_flag = TRUE THEN CAST(current_balance AS DOUBLE) ELSE 0 END)
      comment: "Total AR balance amount under dispute"
    - name: "distinct_clients_with_ar"
      expr: COUNT(DISTINCT organisation_id)
      comment: "Number of unique clients with outstanding AR"
    - name: "distinct_matters_with_ar"
      expr: COUNT(DISTINCT matter_id)
      comment: "Number of unique matters with outstanding AR"
$$;


CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`billing_time_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Timekeeper productivity and billing realization metrics tracking hours worked, billable utilization, and fee realization rates"
  source: "`legal_ecm`.`billing`.`time_entry`"
  dimensions:
    - name: "entry_status"
      expr: entry_status
      comment: "Status of time entry (draft, submitted, approved, billed, written off)"
    - name: "is_billable"
      expr: is_billable
      comment: "Whether the time entry is billable to client"
    - name: "is_contingency"
      expr: is_contingency
      comment: "Whether time is tracked under contingency arrangement"
    - name: "no_charge"
      expr: no_charge
      comment: "Whether time is provided at no charge to client"
    - name: "fee_arrangement_type"
      expr: fee_arrangement_type
      comment: "Fee arrangement type for the matter"
    - name: "work_month"
      expr: DATE_TRUNC('MONTH', work_date)
      comment: "Month the work was performed"
    - name: "work_year"
      expr: YEAR(work_date)
      comment: "Year the work was performed"
    - name: "billing_period_month"
      expr: DATE_TRUNC('MONTH', billing_period_start)
      comment: "Billing period month for the time entry"
    - name: "office_code"
      expr: office_code
      comment: "Office where the work was performed"
    - name: "practice_group_code"
      expr: practice_group_code
      comment: "Practice group performing the work"
    - name: "phase_code"
      expr: phase_code
      comment: "Matter phase code (UTBMS or custom)"
    - name: "utbms_task_code"
      expr: utbms_task_code
      comment: "UTBMS task code for the work performed"
    - name: "utbms_activity_code"
      expr: utbms_activity_code
      comment: "UTBMS activity code for the work performed"
    - name: "pro_bono_category"
      expr: pro_bono_category
      comment: "Pro bono category if applicable"
    - name: "entry_method"
      expr: entry_method
      comment: "Method used to enter time (manual, mobile, voice, AI)"
    - name: "billing_guideline_compliant"
      expr: billing_guideline_compliant
      comment: "Whether time entry complies with client billing guidelines"
    - name: "lpp_protected"
      expr: lpp_protected
      comment: "Whether time entry is protected by legal professional privilege"
  measures:
    - name: "total_time_entries"
      expr: COUNT(1)
      comment: "Total number of time entries"
    - name: "total_hours_worked"
      expr: SUM(CAST(hours_worked AS DOUBLE))
      comment: "Total hours worked across all time entries"
    - name: "total_billable_hours"
      expr: SUM(CAST(billable_hours AS DOUBLE))
      comment: "Total billable hours recorded"
    - name: "total_wip_amount"
      expr: SUM(CAST(wip_amount AS DOUBLE))
      comment: "Total work-in-progress value at standard rates"
    - name: "total_write_down_amount"
      expr: SUM(CAST(write_down_amount AS DOUBLE))
      comment: "Total amount written down from standard rates"
    - name: "avg_hours_per_entry"
      expr: AVG(CAST(hours_worked AS DOUBLE))
      comment: "Average hours per time entry"
    - name: "avg_wip_per_hour"
      expr: AVG(CAST(wip_amount AS DOUBLE) / NULLIF(CAST(hours_worked AS DOUBLE), 0))
      comment: "Average WIP value per hour worked"
    - name: "billable_utilization_pct"
      expr: ROUND(100.0 * SUM(CAST(billable_hours AS DOUBLE)) / NULLIF(SUM(CAST(hours_worked AS DOUBLE)), 0), 2)
      comment: "Percentage of worked hours that are billable"
    - name: "realization_rate_pct"
      expr: ROUND(100.0 * (SUM(CAST(wip_amount AS DOUBLE)) - SUM(CAST(write_down_amount AS DOUBLE))) / NULLIF(SUM(CAST(wip_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of standard WIP value realized after write-downs"
    - name: "billable_entries_count"
      expr: COUNT(CASE WHEN is_billable = TRUE THEN 1 END)
      comment: "Number of billable time entries"
    - name: "non_billable_entries_count"
      expr: COUNT(CASE WHEN is_billable = FALSE THEN 1 END)
      comment: "Number of non-billable time entries"
    - name: "no_charge_hours"
      expr: SUM(CASE WHEN no_charge = TRUE THEN CAST(hours_worked AS DOUBLE) ELSE 0 END)
      comment: "Total hours provided at no charge"
    - name: "guideline_compliant_count"
      expr: COUNT(CASE WHEN billing_guideline_compliant = TRUE THEN 1 END)
      comment: "Number of time entries compliant with billing guidelines"
    - name: "guideline_violation_count"
      expr: COUNT(CASE WHEN billing_guideline_compliant = FALSE THEN 1 END)
      comment: "Number of time entries violating billing guidelines"
    - name: "distinct_timekeepers"
      expr: COUNT(DISTINCT timekeeper_id)
      comment: "Number of unique timekeepers recording time"
    - name: "distinct_matters_worked"
      expr: COUNT(DISTINCT matter_id)
      comment: "Number of unique matters with time recorded"
    - name: "distinct_clients_served"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique clients served"
$$;


CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`billing_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment processing and cash application metrics tracking payment velocity, methods, and trust compliance"
  source: "`legal_ecm`.`billing`.`billing_payment`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Current status of payment (received, applied, cleared, reversed)"
    - name: "payment_type"
      expr: payment_type
      comment: "Type of payment (client payment, retainer draw, trust transfer)"
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment (check, wire, ACH, credit card, trust)"
    - name: "allocation_type"
      expr: allocation_type
      comment: "How payment is allocated (invoice, retainer, on-account)"
    - name: "is_reversed"
      expr: is_reversed
      comment: "Whether payment has been reversed"
    - name: "is_trust_payment"
      expr: is_trust_payment
      comment: "Whether payment is from trust account"
    - name: "is_multi_matter"
      expr: is_multi_matter
      comment: "Whether payment applies to multiple matters"
    - name: "aml_screening_status"
      expr: aml_screening_status
      comment: "Anti-money laundering screening status"
    - name: "received_month"
      expr: DATE_TRUNC('MONTH', received_date)
      comment: "Month payment was received"
    - name: "applied_month"
      expr: DATE_TRUNC('MONTH', applied_date)
      comment: "Month payment was applied to invoices"
    - name: "gl_period"
      expr: gl_period
      comment: "General ledger period for accounting"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of payment"
    - name: "fee_arrangement_type"
      expr: fee_arrangement_type
      comment: "Fee arrangement type for the matter"
  measures:
    - name: "total_payment_count"
      expr: COUNT(1)
      comment: "Total number of payment transactions"
    - name: "total_received_amount"
      expr: SUM(CAST(received_amount AS DOUBLE))
      comment: "Total amount received across all payments"
    - name: "total_applied_amount"
      expr: SUM(CAST(applied_amount AS DOUBLE))
      comment: "Total amount applied to invoices"
    - name: "total_unapplied_amount"
      expr: SUM(CAST(unapplied_amount AS DOUBLE))
      comment: "Total amount received but not yet applied"
    - name: "total_overpayment_amount"
      expr: SUM(CAST(overpayment_amount AS DOUBLE))
      comment: "Total overpayment amount requiring refund or credit"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount applied at payment"
    - name: "total_write_off_amount"
      expr: SUM(CAST(write_off_amount AS DOUBLE))
      comment: "Total amount written off at payment application"
    - name: "total_wip_cleared_amount"
      expr: SUM(CAST(wip_cleared_amount AS DOUBLE))
      comment: "Total WIP cleared by payments"
    - name: "total_functional_currency_amount"
      expr: SUM(CAST(functional_currency_amount AS DOUBLE))
      comment: "Total payment amount in firm functional currency"
    - name: "avg_payment_amount"
      expr: AVG(CAST(received_amount AS DOUBLE))
      comment: "Average payment amount per transaction"
    - name: "avg_days_to_apply"
      expr: AVG(DATEDIFF(applied_date, received_date))
      comment: "Average days from payment receipt to application"
    - name: "application_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(applied_amount AS DOUBLE)) / NULLIF(SUM(CAST(received_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of received payments applied to invoices"
    - name: "reversed_payment_count"
      expr: COUNT(CASE WHEN is_reversed = TRUE THEN 1 END)
      comment: "Number of payments that were reversed"
    - name: "trust_payment_count"
      expr: COUNT(CASE WHEN is_trust_payment = TRUE THEN 1 END)
      comment: "Number of payments from trust accounts"
    - name: "multi_matter_payment_count"
      expr: COUNT(CASE WHEN is_multi_matter = TRUE THEN 1 END)
      comment: "Number of payments allocated across multiple matters"
    - name: "distinct_paying_clients"
      expr: COUNT(DISTINCT organisation_id)
      comment: "Number of unique clients making payments"
    - name: "distinct_matters_paid"
      expr: COUNT(DISTINCT matter_id)
      comment: "Number of unique matters receiving payments"
$$;


CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`billing_wip_ledger`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Work-in-progress inventory and aging metrics tracking unbilled time and expenses, WIP aging, and billing velocity"
  source: "`legal_ecm`.`billing`.`wip_ledger`"
  dimensions:
    - name: "wip_status"
      expr: wip_status
      comment: "Status of WIP entry (active, prebilled, billed, written off)"
    - name: "wip_type"
      expr: wip_type
      comment: "Type of WIP (time, disbursement, expense)"
    - name: "aging_bucket"
      expr: aging_bucket
      comment: "Aging bucket for WIP (0-30, 31-60, 61-90, 90+)"
    - name: "wip_age_days"
      expr: wip_age_days
      comment: "Age of WIP in days"
    - name: "is_billable"
      expr: is_billable
      comment: "Whether WIP is billable to client"
    - name: "is_contingency_accrual"
      expr: is_contingency_accrual
      comment: "Whether WIP is contingency accrual"
    - name: "entry_month"
      expr: DATE_TRUNC('MONTH', entry_date)
      comment: "Month WIP was entered"
    - name: "work_month"
      expr: DATE_TRUNC('MONTH', work_date)
      comment: "Month work was performed"
    - name: "phase_code"
      expr: phase_code
      comment: "Matter phase code"
    - name: "utbms_task_code"
      expr: utbms_task_code
      comment: "UTBMS task code"
    - name: "utbms_activity_code"
      expr: utbms_activity_code
      comment: "UTBMS activity code"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of WIP"
  measures:
    - name: "total_wip_entries"
      expr: COUNT(1)
      comment: "Total number of WIP entries"
    - name: "total_wip_amount"
      expr: SUM(CAST(wip_amount AS DOUBLE))
      comment: "Total WIP value at standard rates"
    - name: "total_wip_firm_currency"
      expr: SUM(CAST(wip_amount_firm_currency AS DOUBLE))
      comment: "Total WIP value in firm functional currency"
    - name: "total_standard_amount"
      expr: SUM(CAST(standard_amount AS DOUBLE))
      comment: "Total standard amount before adjustments"
    - name: "total_write_up_down_amount"
      expr: SUM(CAST(write_up_down_amount AS DOUBLE))
      comment: "Total write-up/write-down adjustments"
    - name: "total_write_off_amount"
      expr: SUM(CAST(write_off_amount AS DOUBLE))
      comment: "Total WIP written off"
    - name: "total_hours_worked"
      expr: SUM(CAST(hours_worked AS DOUBLE))
      comment: "Total hours in WIP inventory"
    - name: "avg_wip_amount"
      expr: AVG(CAST(wip_amount AS DOUBLE))
      comment: "Average WIP value per entry"
    - name: "avg_billing_rate"
      expr: AVG(CAST(billing_rate AS DOUBLE))
      comment: "Average billing rate across WIP entries"
    - name: "avg_standard_rate"
      expr: AVG(CAST(standard_rate AS DOUBLE))
      comment: "Average standard rate across WIP entries"
    - name: "realization_rate_pct"
      expr: ROUND(100.0 * (SUM(CAST(wip_amount AS DOUBLE)) - SUM(CAST(write_off_amount AS DOUBLE))) / NULLIF(SUM(CAST(standard_amount AS DOUBLE)), 0), 2)
      comment: "WIP realization rate after write-offs"
    - name: "billable_wip_count"
      expr: COUNT(CASE WHEN is_billable = TRUE THEN 1 END)
      comment: "Number of billable WIP entries"
    - name: "billable_wip_amount"
      expr: SUM(CASE WHEN is_billable = TRUE THEN CAST(wip_amount AS DOUBLE) ELSE 0 END)
      comment: "Total billable WIP value"
    - name: "contingency_wip_amount"
      expr: SUM(CASE WHEN is_contingency_accrual = TRUE THEN CAST(wip_amount AS DOUBLE) ELSE 0 END)
      comment: "Total contingency accrual WIP"
    - name: "distinct_matters_with_wip"
      expr: COUNT(DISTINCT matter_id)
      comment: "Number of unique matters with WIP"
    - name: "distinct_timekeepers_with_wip"
      expr: COUNT(DISTINCT primary_wip_timekeeper_id)
      comment: "Number of unique timekeepers with WIP"
    - name: "distinct_clients_with_wip"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique clients with WIP"
$$;


CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`billing_collection_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Collections effectiveness and recovery metrics tracking collection activities, outcomes, and recovery rates"
  source: "`legal_ecm`.`billing`.`collection_action`"
  dimensions:
    - name: "action_type"
      expr: action_type
      comment: "Type of collection action (call, email, letter, legal, settlement)"
    - name: "action_status"
      expr: action_status
      comment: "Status of collection action (pending, completed, escalated)"
    - name: "outcome"
      expr: outcome
      comment: "Outcome of collection action (payment received, promise to pay, dispute, no response)"
    - name: "contact_method"
      expr: contact_method
      comment: "Method used to contact client (phone, email, letter, in-person)"
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether action was escalated"
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Whether client disputed the balance"
    - name: "payment_plan_flag"
      expr: payment_plan_flag
      comment: "Whether payment plan was established"
    - name: "write_off_approval_flag"
      expr: write_off_approval_flag
      comment: "Whether write-off was approved"
    - name: "action_month"
      expr: DATE_TRUNC('MONTH', action_date)
      comment: "Month collection action was taken"
    - name: "resolution_month"
      expr: DATE_TRUNC('MONTH', resolution_date)
      comment: "Month collection action was resolved"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of amounts"
    - name: "next_action_type"
      expr: next_action_type
      comment: "Planned next collection action type"
  measures:
    - name: "total_collection_actions"
      expr: COUNT(1)
      comment: "Total number of collection actions taken"
    - name: "total_amount_recovered"
      expr: SUM(CAST(amount_recovered AS DOUBLE))
      comment: "Total amount recovered through collection actions"
    - name: "total_write_off_amount"
      expr: SUM(CAST(write_off_amount AS DOUBLE))
      comment: "Total amount written off after collection efforts"
    - name: "avg_amount_recovered"
      expr: AVG(CAST(amount_recovered AS DOUBLE))
      comment: "Average amount recovered per collection action"
    - name: "avg_days_to_resolution"
      expr: AVG(DATEDIFF(resolution_date, action_date))
      comment: "Average days from action to resolution"
    - name: "recovery_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(amount_recovered AS DOUBLE)) / NULLIF(SUM(CAST(amount_recovered AS DOUBLE)) + SUM(CAST(write_off_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of targeted amount recovered vs written off"
    - name: "escalated_action_count"
      expr: COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END)
      comment: "Number of actions that were escalated"
    - name: "disputed_action_count"
      expr: COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END)
      comment: "Number of actions resulting in dispute"
    - name: "payment_plan_count"
      expr: COUNT(CASE WHEN payment_plan_flag = TRUE THEN 1 END)
      comment: "Number of payment plans established"
    - name: "write_off_approved_count"
      expr: COUNT(CASE WHEN write_off_approval_flag = TRUE THEN 1 END)
      comment: "Number of write-offs approved"
    - name: "resolved_action_count"
      expr: COUNT(CASE WHEN resolution_date IS NOT NULL THEN 1 END)
      comment: "Number of collection actions resolved"
    - name: "distinct_clients_contacted"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique clients contacted for collections"
    - name: "distinct_matters_in_collections"
      expr: COUNT(DISTINCT matter_id)
      comment: "Number of unique matters in collections"
    - name: "distinct_invoices_in_collections"
      expr: COUNT(DISTINCT invoice_id)
      comment: "Number of unique invoices in collections"
$$;


CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`billing_write_off`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Write-off and revenue leakage metrics tracking write-off reasons, approval patterns, and financial impact"
  source: "`legal_ecm`.`billing`.`write_off`"
  dimensions:
    - name: "write_off_status"
      expr: write_off_status
      comment: "Status of write-off (pending, approved, posted, reversed)"
    - name: "write_off_type"
      expr: write_off_type
      comment: "Type of write-off (rate adjustment, courtesy discount, bad debt, guideline compliance)"
    - name: "write_off_category"
      expr: write_off_category
      comment: "Category of write-off for reporting"
    - name: "reason_code"
      expr: reason_code
      comment: "Standardized reason code for write-off"
    - name: "is_reversal"
      expr: is_reversal
      comment: "Whether this is a reversal of prior write-off"
    - name: "requires_secondary_approval"
      expr: requires_secondary_approval
      comment: "Whether secondary approval is required"
    - name: "fee_arrangement_type"
      expr: fee_arrangement_type
      comment: "Fee arrangement type for the matter"
    - name: "write_off_month"
      expr: DATE_TRUNC('MONTH', write_off_date)
      comment: "Month write-off was recorded"
    - name: "approval_month"
      expr: DATE_TRUNC('MONTH', approval_date)
      comment: "Month write-off was approved"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for accounting"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of write-off"
    - name: "office_code"
      expr: office_code
      comment: "Office where write-off originated"
    - name: "utbms_task_code"
      expr: utbms_task_code
      comment: "UTBMS task code for written-off work"
  measures:
    - name: "total_write_off_count"
      expr: COUNT(1)
      comment: "Total number of write-off transactions"
    - name: "total_write_off_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total amount written off"
    - name: "total_functional_currency_amount"
      expr: SUM(CAST(functional_currency_amount AS DOUBLE))
      comment: "Total write-off in firm functional currency"
    - name: "total_original_amount"
      expr: SUM(CAST(original_amount AS DOUBLE))
      comment: "Total original amount before write-off"
    - name: "total_write_down_amount"
      expr: SUM(CAST(write_down_amount AS DOUBLE))
      comment: "Total write-down amount"
    - name: "total_hours_written_off"
      expr: SUM(CAST(hours_written_off AS DOUBLE))
      comment: "Total hours written off"
    - name: "avg_write_off_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average write-off amount per transaction"
    - name: "avg_standard_rate"
      expr: AVG(CAST(standard_rate AS DOUBLE))
      comment: "Average standard rate for written-off work"
    - name: "avg_client_agreed_rate"
      expr: AVG(CAST(client_agreed_rate AS DOUBLE))
      comment: "Average client-agreed rate for written-off work"
    - name: "write_off_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(amount AS DOUBLE)) / NULLIF(SUM(CAST(original_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of original amount written off"
    - name: "reversal_count"
      expr: COUNT(CASE WHEN is_reversal = TRUE THEN 1 END)
      comment: "Number of write-off reversals"
    - name: "secondary_approval_count"
      expr: COUNT(CASE WHEN requires_secondary_approval = TRUE THEN 1 END)
      comment: "Number of write-offs requiring secondary approval"
    - name: "approved_write_off_count"
      expr: COUNT(CASE WHEN approval_date IS NOT NULL THEN 1 END)
      comment: "Number of approved write-offs"
    - name: "avg_days_to_approval"
      expr: AVG(DATEDIFF(approval_date, write_off_date))
      comment: "Average days from write-off to approval"
    - name: "distinct_matters_with_writeoffs"
      expr: COUNT(DISTINCT matter_id)
      comment: "Number of unique matters with write-offs"
    - name: "distinct_clients_with_writeoffs"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique clients with write-offs"
    - name: "distinct_timekeepers_with_writeoffs"
      expr: COUNT(DISTINCT primary_write_timekeeper_id)
      comment: "Number of unique timekeepers with write-offs"
$$;
