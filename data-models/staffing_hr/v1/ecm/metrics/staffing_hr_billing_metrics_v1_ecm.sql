-- Metric views for domain: billing | Business: Staffing Hr | Version: 1 | Generated on: 2026-05-02 15:43:14

CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`billing_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core invoice revenue, billing volume, and payment performance metrics for accounts receivable and revenue recognition analysis"
  source: "`staffing_hr_ecm`.`billing`.`invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the invoice (e.g., draft, sent, paid, overdue, void)"
    - name: "billing_model"
      expr: billing_model
      comment: "Billing model type (e.g., hourly, fixed-fee, milestone, retainer)"
    - name: "invoice_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month when invoice was issued"
    - name: "due_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month when payment is due"
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms (e.g., Net 30, Net 60, Due on Receipt)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which invoice is denominated"
    - name: "is_void"
      expr: is_void
      comment: "Whether invoice has been voided"
    - name: "delivery_method"
      expr: delivery_method
      comment: "How invoice was delivered to client (e.g., email, portal, mail)"
  measures:
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Total number of invoices"
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross invoice amount before discounts and taxes"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net invoice amount after discounts and taxes - primary revenue metric"
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total unpaid balance across all invoices - key AR metric"
    - name: "total_amount_paid"
      expr: SUM(CAST(amount_paid AS DOUBLE))
      comment: "Total amount collected across all invoices"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected on invoices"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts applied to invoices"
    - name: "total_hours_billed"
      expr: SUM(CAST(total_hours_billed AS DOUBLE))
      comment: "Total billable hours across all invoices"
    - name: "total_overtime_hours_billed"
      expr: SUM(CAST(overtime_hours_billed AS DOUBLE))
      comment: "Total overtime hours billed"
    - name: "avg_invoice_amount"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average invoice value - indicates typical deal size"
    - name: "avg_outstanding_balance"
      expr: AVG(CAST(outstanding_balance AS DOUBLE))
      comment: "Average unpaid balance per invoice"
    - name: "distinct_client_count"
      expr: COUNT(DISTINCT client_account_id)
      comment: "Number of unique clients invoiced"
    - name: "distinct_assignment_count"
      expr: COUNT(DISTINCT assignment_id)
      comment: "Number of unique assignments billed"
    - name: "collection_rate_numerator"
      expr: SUM(CAST(amount_paid AS DOUBLE))
      comment: "Numerator for collection rate calculation (amount paid)"
    - name: "collection_rate_denominator"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Denominator for collection rate calculation (net amount invoiced)"
$$;


CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`billing_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment collection, cash flow, and receivables performance metrics for treasury and collections management"
  source: "`staffing_hr_ecm`.`billing`.`payment`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Current status of payment (e.g., pending, cleared, failed, reversed)"
    - name: "payment_method"
      expr: payment_method
      comment: "Method used for payment (e.g., ACH, wire, check, credit card)"
    - name: "payment_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Month when payment was received"
    - name: "cleared_month"
      expr: DATE_TRUNC('MONTH', cleared_date)
      comment: "Month when payment cleared the bank"
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Whether payment has been reconciled (e.g., reconciled, pending, unreconciled)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which payment was received"
    - name: "is_overpayment"
      expr: is_overpayment
      comment: "Whether payment exceeds invoice amount"
    - name: "is_partial_payment"
      expr: is_partial_payment
      comment: "Whether payment is less than full invoice amount"
    - name: "channel"
      expr: channel
      comment: "Payment channel or source"
  measures:
    - name: "payment_count"
      expr: COUNT(1)
      comment: "Total number of payment transactions"
    - name: "total_payment_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total cash received across all payments - primary cash flow metric"
    - name: "total_applied_amount"
      expr: SUM(CAST(applied_amount AS DOUBLE))
      comment: "Total amount applied to invoices"
    - name: "total_unapplied_amount"
      expr: SUM(CAST(unapplied_amount AS DOUBLE))
      comment: "Total payment amount not yet applied to invoices - indicates reconciliation backlog"
    - name: "total_discount_taken"
      expr: SUM(CAST(discount_taken AS DOUBLE))
      comment: "Total early payment discounts claimed by clients"
    - name: "avg_payment_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average payment size"
    - name: "distinct_client_count"
      expr: COUNT(DISTINCT client_account_id)
      comment: "Number of unique clients making payments"
    - name: "distinct_invoice_count"
      expr: COUNT(DISTINCT invoice_id)
      comment: "Number of unique invoices paid"
    - name: "application_rate_numerator"
      expr: SUM(CAST(applied_amount AS DOUBLE))
      comment: "Numerator for payment application rate (applied amount)"
    - name: "application_rate_denominator"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Denominator for payment application rate (total payment amount)"
$$;


CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`billing_dispute`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Billing dispute volume, resolution performance, and revenue-at-risk metrics for quality and client satisfaction management"
  source: "`staffing_hr_ecm`.`billing`.`billing_dispute`"
  dimensions:
    - name: "dispute_status"
      expr: dispute_status
      comment: "Current status of dispute (e.g., open, in review, resolved, escalated)"
    - name: "dispute_type"
      expr: dispute_type
      comment: "Category of dispute (e.g., rate, hours, quality, billing error)"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause classification for dispute analysis"
    - name: "resolution_type"
      expr: resolution_type
      comment: "How dispute was resolved (e.g., credit issued, client error, split resolution)"
    - name: "priority"
      expr: priority
      comment: "Dispute priority level"
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether dispute has been escalated"
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Whether dispute resolution exceeded SLA target"
    - name: "collections_hold_flag"
      expr: collections_hold_flag
      comment: "Whether collections activity is on hold due to dispute"
    - name: "open_month"
      expr: DATE_TRUNC('MONTH', open_date)
      comment: "Month when dispute was opened"
    - name: "resolution_month"
      expr: DATE_TRUNC('MONTH', resolution_date)
      comment: "Month when dispute was resolved"
    - name: "billing_model"
      expr: billing_model
      comment: "Billing model associated with disputed invoice"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of disputed amount"
  measures:
    - name: "dispute_count"
      expr: COUNT(1)
      comment: "Total number of billing disputes"
    - name: "total_disputed_amount"
      expr: SUM(CAST(disputed_amount AS DOUBLE))
      comment: "Total revenue at risk due to disputes - key quality and risk metric"
    - name: "total_approved_credit_amount"
      expr: SUM(CAST(approved_credit_amount AS DOUBLE))
      comment: "Total credits approved to resolve disputes - actual revenue loss"
    - name: "total_disputed_hours"
      expr: SUM(CAST(disputed_hours AS DOUBLE))
      comment: "Total hours disputed by clients"
    - name: "total_approved_hours"
      expr: SUM(CAST(approved_hours AS DOUBLE))
      comment: "Total hours approved after dispute resolution"
    - name: "avg_disputed_amount"
      expr: AVG(CAST(disputed_amount AS DOUBLE))
      comment: "Average dispute value"
    - name: "avg_approved_credit_amount"
      expr: AVG(CAST(approved_credit_amount AS DOUBLE))
      comment: "Average credit issued per dispute"
    - name: "distinct_client_count"
      expr: COUNT(DISTINCT client_account_id)
      comment: "Number of unique clients with disputes - indicates quality issues"
    - name: "distinct_invoice_count"
      expr: COUNT(DISTINCT invoice_id)
      comment: "Number of unique invoices disputed"
    - name: "credit_rate_numerator"
      expr: SUM(CAST(approved_credit_amount AS DOUBLE))
      comment: "Numerator for dispute credit rate (approved credits)"
    - name: "credit_rate_denominator"
      expr: SUM(CAST(disputed_amount AS DOUBLE))
      comment: "Denominator for dispute credit rate (disputed amount)"
$$;


CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`billing_placement_fee`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Direct hire and conversion fee revenue, payment performance, and guarantee metrics for permanent placement business"
  source: "`staffing_hr_ecm`.`billing`.`placement_fee`"
  dimensions:
    - name: "fee_type"
      expr: fee_type
      comment: "Type of placement fee (e.g., direct hire, temp-to-perm conversion, retained search)"
    - name: "fee_basis"
      expr: fee_basis
      comment: "Basis for fee calculation (e.g., percentage of salary, flat fee)"
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of fee (e.g., pending, paid, partial, overdue)"
    - name: "dispute_status"
      expr: dispute_status
      comment: "Whether fee is disputed"
    - name: "is_fall_off"
      expr: is_fall_off
      comment: "Whether placement fell off within guarantee period"
    - name: "fall_off_reason"
      expr: fall_off_reason
      comment: "Reason for placement fall-off"
    - name: "replacement_eligible"
      expr: replacement_eligible
      comment: "Whether client is eligible for replacement candidate"
    - name: "split_fee_indicator"
      expr: split_fee_indicator
      comment: "Whether fee is split between multiple recruiters or entities"
    - name: "fee_month"
      expr: DATE_TRUNC('MONTH', fee_date)
      comment: "Month when fee was earned"
    - name: "payment_received_month"
      expr: DATE_TRUNC('MONTH', payment_received_date)
      comment: "Month when fee payment was received"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of placement fee"
  measures:
    - name: "placement_fee_count"
      expr: COUNT(1)
      comment: "Total number of placement fees"
    - name: "total_fee_amount"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total placement fee revenue earned - primary direct hire revenue metric"
    - name: "total_invoiced_amount"
      expr: SUM(CAST(invoiced_amount AS DOUBLE))
      comment: "Total placement fees invoiced to clients"
    - name: "total_paid_amount"
      expr: SUM(CAST(paid_amount AS DOUBLE))
      comment: "Total placement fees collected - cash realization metric"
    - name: "total_credit_memo_amount"
      expr: SUM(CAST(credit_memo_amount AS DOUBLE))
      comment: "Total credits issued for placement fee adjustments or fall-offs"
    - name: "total_candidate_annual_salary"
      expr: SUM(CAST(candidate_annual_salary AS DOUBLE))
      comment: "Total annual salary of placed candidates - indicates placement quality and level"
    - name: "avg_fee_amount"
      expr: AVG(CAST(fee_amount AS DOUBLE))
      comment: "Average placement fee per hire"
    - name: "avg_fee_percentage"
      expr: AVG(CAST(fee_percentage AS DOUBLE))
      comment: "Average fee percentage charged"
    - name: "avg_candidate_salary"
      expr: AVG(CAST(candidate_annual_salary AS DOUBLE))
      comment: "Average salary of placed candidates"
    - name: "distinct_client_count"
      expr: COUNT(DISTINCT client_account_id)
      comment: "Number of unique clients with placement fees"
    - name: "distinct_candidate_count"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique candidates placed"
    - name: "collection_rate_numerator"
      expr: SUM(CAST(paid_amount AS DOUBLE))
      comment: "Numerator for fee collection rate (amount paid)"
    - name: "collection_rate_denominator"
      expr: SUM(CAST(invoiced_amount AS DOUBLE))
      comment: "Denominator for fee collection rate (amount invoiced)"
$$;


CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`billing_spread_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Gross margin, markup, and profitability metrics by assignment for financial performance and pricing analysis"
  source: "`staffing_hr_ecm`.`billing`.`spread_record`"
  dimensions:
    - name: "billing_model"
      expr: billing_model
      comment: "Billing model for the spread calculation"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of spread record"
    - name: "is_commission_eligible"
      expr: is_commission_eligible
      comment: "Whether spread is eligible for commission calculation"
    - name: "overtime_flag"
      expr: overtime_flag
      comment: "Whether spread includes overtime hours"
    - name: "double_time_flag"
      expr: double_time_flag
      comment: "Whether spread includes double-time hours"
    - name: "billing_period_month"
      expr: DATE_TRUNC('MONTH', billing_period_start_date)
      comment: "Month of billing period"
    - name: "revenue_recognition_month"
      expr: DATE_TRUNC('MONTH', revenue_recognition_date)
      comment: "Month when revenue is recognized"
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for billable quantity (e.g., hours, days, units)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of spread amounts"
  measures:
    - name: "spread_record_count"
      expr: COUNT(1)
      comment: "Total number of spread records"
    - name: "total_bill_amount"
      expr: SUM(CAST(total_bill_amount AS DOUBLE))
      comment: "Total amount billed to clients - gross revenue"
    - name: "total_pay_amount"
      expr: SUM(CAST(total_pay_amount AS DOUBLE))
      comment: "Total amount paid to workers - direct cost"
    - name: "total_spread_amount"
      expr: SUM(CAST(total_spread_amount AS DOUBLE))
      comment: "Total spread (bill minus pay) - gross profit before burden"
    - name: "total_gross_margin_amount"
      expr: SUM(CAST(total_gross_margin_amount AS DOUBLE))
      comment: "Total gross margin after burden - net profit metric"
    - name: "total_burdened_cost"
      expr: SUM(CAST(burdened_cost AS DOUBLE))
      comment: "Total fully-loaded cost including burden"
    - name: "total_billable_units"
      expr: SUM(CAST(billable_units AS DOUBLE))
      comment: "Total billable units (hours, days, etc.)"
    - name: "avg_markup_percentage"
      expr: AVG(CAST(markup_percentage AS DOUBLE))
      comment: "Average markup percentage - key pricing metric"
    - name: "avg_gross_margin_percentage"
      expr: AVG(CAST(gross_margin_percentage AS DOUBLE))
      comment: "Average gross margin percentage - profitability indicator"
    - name: "avg_burden_rate"
      expr: AVG(CAST(burden_rate AS DOUBLE))
      comment: "Average burden rate applied"
    - name: "distinct_assignment_count"
      expr: COUNT(DISTINCT assignment_id)
      comment: "Number of unique assignments with spread"
    - name: "distinct_client_count"
      expr: COUNT(DISTINCT client_account_id)
      comment: "Number of unique clients"
    - name: "distinct_worker_count"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique workers generating spread"
    - name: "margin_rate_numerator"
      expr: SUM(CAST(total_gross_margin_amount AS DOUBLE))
      comment: "Numerator for margin rate calculation (gross margin)"
    - name: "margin_rate_denominator"
      expr: SUM(CAST(total_bill_amount AS DOUBLE))
      comment: "Denominator for margin rate calculation (bill amount)"
$$;


CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`billing_credit_memo`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Credit memo issuance, application, and revenue adjustment metrics for billing quality and customer satisfaction analysis"
  source: "`staffing_hr_ecm`.`billing`.`credit_memo`"
  dimensions:
    - name: "applied_status"
      expr: applied_status
      comment: "Application status of credit memo (e.g., unapplied, partially applied, fully applied)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of credit memo"
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for credit memo issuance"
    - name: "reason_description"
      expr: reason_description
      comment: "Detailed reason for credit memo"
    - name: "is_void_and_rebill"
      expr: is_void_and_rebill
      comment: "Whether credit is part of void-and-rebill process"
    - name: "client_notified"
      expr: client_notified
      comment: "Whether client has been notified of credit"
    - name: "billing_model"
      expr: billing_model
      comment: "Billing model associated with credit"
    - name: "issue_month"
      expr: DATE_TRUNC('MONTH', issue_date)
      comment: "Month when credit memo was issued"
    - name: "applied_month"
      expr: DATE_TRUNC('MONTH', applied_date)
      comment: "Month when credit was applied"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of credit memo"
  measures:
    - name: "credit_memo_count"
      expr: COUNT(1)
      comment: "Total number of credit memos issued - billing quality indicator"
    - name: "total_credit_amount"
      expr: SUM(CAST(credit_amount AS DOUBLE))
      comment: "Total credit issued - revenue adjustment and quality cost metric"
    - name: "total_applied_amount"
      expr: SUM(CAST(applied_amount AS DOUBLE))
      comment: "Total credit applied to invoices"
    - name: "total_unapplied_amount"
      expr: SUM(CAST(unapplied_amount AS DOUBLE))
      comment: "Total credit not yet applied - indicates reconciliation backlog"
    - name: "total_credited_hours"
      expr: SUM(CAST(credited_hours AS DOUBLE))
      comment: "Total hours credited back to clients"
    - name: "total_tax_adjustment_amount"
      expr: SUM(CAST(tax_adjustment_amount AS DOUBLE))
      comment: "Total tax adjustments on credits"
    - name: "avg_credit_amount"
      expr: AVG(CAST(credit_amount AS DOUBLE))
      comment: "Average credit memo value"
    - name: "distinct_client_count"
      expr: COUNT(DISTINCT client_account_id)
      comment: "Number of unique clients receiving credits - quality issue breadth"
    - name: "distinct_invoice_count"
      expr: COUNT(DISTINCT invoice_id)
      comment: "Number of unique invoices credited"
    - name: "application_rate_numerator"
      expr: SUM(CAST(applied_amount AS DOUBLE))
      comment: "Numerator for credit application rate (applied amount)"
    - name: "application_rate_denominator"
      expr: SUM(CAST(credit_amount AS DOUBLE))
      comment: "Denominator for credit application rate (total credit amount)"
$$;


CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`billing_write_off`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bad debt write-off and recovery metrics for credit risk, collections effectiveness, and financial reserve analysis"
  source: "`staffing_hr_ecm`.`billing`.`write_off`"
  dimensions:
    - name: "write_off_status"
      expr: write_off_status
      comment: "Status of write-off (e.g., pending, approved, reversed)"
    - name: "reason"
      expr: reason
      comment: "Primary reason for write-off (e.g., bankruptcy, uncollectible, client dispute)"
    - name: "reason_detail"
      expr: reason_detail
      comment: "Detailed reason for write-off"
    - name: "recovery_status"
      expr: recovery_status
      comment: "Status of recovery efforts (e.g., no recovery, partial recovery, full recovery)"
    - name: "ar_aging_bucket"
      expr: ar_aging_bucket
      comment: "Aging bucket at time of write-off (e.g., 90+, 120+, 180+)"
    - name: "approval_level"
      expr: approval_level
      comment: "Approval level required for write-off"
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Whether write-off has been reversed"
    - name: "tax_impact_flag"
      expr: tax_impact_flag
      comment: "Whether write-off has tax implications"
    - name: "billing_model"
      expr: billing_model
      comment: "Billing model of written-off receivable"
    - name: "write_off_month"
      expr: DATE_TRUNC('MONTH', write_off_date)
      comment: "Month when write-off was recorded"
    - name: "recovery_month"
      expr: DATE_TRUNC('MONTH', recovery_date)
      comment: "Month when recovery was received"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of write-off"
  measures:
    - name: "write_off_count"
      expr: COUNT(1)
      comment: "Total number of write-offs - credit risk and collections failure indicator"
    - name: "total_write_off_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total bad debt written off - primary credit loss metric"
    - name: "total_original_invoice_amount"
      expr: SUM(CAST(original_invoice_amount AS DOUBLE))
      comment: "Total original invoice amount for written-off receivables"
    - name: "total_partial_payment_received"
      expr: SUM(CAST(partial_payment_received AS DOUBLE))
      comment: "Total partial payments received before write-off"
    - name: "total_recovered_amount"
      expr: SUM(CAST(recovered_amount AS DOUBLE))
      comment: "Total amount recovered after write-off - collections effectiveness metric"
    - name: "avg_write_off_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average write-off amount per incident"
    - name: "distinct_client_count"
      expr: COUNT(DISTINCT client_account_id)
      comment: "Number of unique clients with write-offs - credit risk concentration"
    - name: "distinct_invoice_count"
      expr: COUNT(DISTINCT invoice_id)
      comment: "Number of unique invoices written off"
    - name: "recovery_rate_numerator"
      expr: SUM(CAST(recovered_amount AS DOUBLE))
      comment: "Numerator for recovery rate calculation (recovered amount)"
    - name: "recovery_rate_denominator"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Denominator for recovery rate calculation (write-off amount)"
    - name: "net_loss_amount"
      expr: SUM((CAST(amount AS DOUBLE)) - (CAST(recovered_amount AS DOUBLE)))
      comment: "Net loss after recoveries - true bad debt cost"
$$;


CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`billing_collection_activity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Collections effort, promise-to-pay performance, and AR aging metrics for receivables management and cash forecasting"
  source: "`staffing_hr_ecm`.`billing`.`collection_activity`"
  dimensions:
    - name: "activity_type"
      expr: activity_type
      comment: "Type of collection activity (e.g., phone call, email, letter, legal notice)"
    - name: "collection_activity_status"
      expr: collection_activity_status
      comment: "Status of collection activity"
    - name: "outcome"
      expr: outcome
      comment: "Outcome of collection activity (e.g., promise to pay, dispute, no contact)"
    - name: "contact_method"
      expr: contact_method
      comment: "Method used to contact client"
    - name: "aging_bucket"
      expr: aging_bucket
      comment: "AR aging bucket at time of activity"
    - name: "escalation_level"
      expr: escalation_level
      comment: "Escalation level of collection activity"
    - name: "legal_action_flag"
      expr: legal_action_flag
      comment: "Whether legal action is being pursued"
    - name: "credit_memo_issued_flag"
      expr: credit_memo_issued_flag
      comment: "Whether credit memo was issued as result of activity"
    - name: "write_off_recommended_flag"
      expr: write_off_recommended_flag
      comment: "Whether write-off is recommended"
    - name: "activity_month"
      expr: DATE_TRUNC('MONTH', activity_date)
      comment: "Month when collection activity occurred"
    - name: "promise_to_pay_month"
      expr: DATE_TRUNC('MONTH', promise_to_pay_date)
      comment: "Month when client promised to pay"
  measures:
    - name: "activity_count"
      expr: COUNT(1)
      comment: "Total number of collection activities - collections effort metric"
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total AR balance under collection"
    - name: "total_promise_to_pay_amount"
      expr: SUM(CAST(promise_to_pay_amount AS DOUBLE))
      comment: "Total amount clients promised to pay - cash forecast input"
    - name: "total_payment_received_amount"
      expr: SUM(CAST(payment_received_amount AS DOUBLE))
      comment: "Total payments received as result of collection activity"
    - name: "avg_outstanding_balance"
      expr: AVG(CAST(outstanding_balance AS DOUBLE))
      comment: "Average balance per collection activity"
    - name: "avg_promise_to_pay_amount"
      expr: AVG(CAST(promise_to_pay_amount AS DOUBLE))
      comment: "Average promise-to-pay amount"
    - name: "distinct_client_count"
      expr: COUNT(DISTINCT client_account_id)
      comment: "Number of unique clients requiring collection activity"
    - name: "distinct_invoice_count"
      expr: COUNT(DISTINCT invoice_id)
      comment: "Number of unique invoices under collection"
    - name: "promise_fulfillment_numerator"
      expr: SUM(CAST(payment_received_amount AS DOUBLE))
      comment: "Numerator for promise fulfillment rate (payments received)"
    - name: "promise_fulfillment_denominator"
      expr: SUM(CAST(promise_to_pay_amount AS DOUBLE))
      comment: "Denominator for promise fulfillment rate (promised amount)"
$$;
