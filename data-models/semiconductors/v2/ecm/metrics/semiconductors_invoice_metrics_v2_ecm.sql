-- Metric views for domain: invoice | Business: Semiconductors | Version: 2 | Generated on: 2026-06-28 00:14:33

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`invoice_adjustment_memo`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Credit and debit adjustment memo metrics tracking adjustment volumes, amounts, approval rates, and settlement status. Used by AR management and finance controllers to monitor billing corrections and revenue impact."
  source: "`vibe_semiconductors_v1`.`invoice`.`adjustment_memo`"
  dimensions:
    - name: "adjustment_type"
      expr: adjustment_type
      comment: "Type of adjustment (Credit, Debit, Rebate) for classification and root-cause analysis."
    - name: "adjustment_subtype"
      expr: adjustment_subtype
      comment: "Sub-classification of adjustment for granular billing correction analysis."
    - name: "adjustment_category"
      expr: adjustment_category
      comment: "Business category of the adjustment for financial reporting segmentation."
    - name: "adjustment_memo_status"
      expr: adjustment_memo_status
      comment: "Current lifecycle status of the adjustment memo."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status; pending approvals represent financial exposure."
    - name: "settlement_status"
      expr: settlement_status
      comment: "Settlement status of the adjustment for cash flow impact tracking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the adjustment for multi-currency reporting."
    - name: "memo_date_month"
      expr: DATE_TRUNC('MONTH', memo_date)
      comment: "Month of memo issuance for trend analysis of billing corrections."
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for the adjustment; used to identify systemic billing issues."
    - name: "is_manual"
      expr: is_manual
      comment: "Flag for manually created adjustments; high manual rate indicates process gaps."
  measures:
    - name: "total_adjustment_memos"
      expr: COUNT(1)
      comment: "Total adjustment memos issued; volume indicator of billing correction activity."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total adjustment amount; measures gross revenue impact of billing corrections."
    - name: "total_applied_amount"
      expr: SUM(CAST(applied_amount AS DOUBLE))
      comment: "Total amount applied from adjustment memos; settled correction value."
    - name: "total_approved_amount"
      expr: SUM(CAST(approved_amount AS DOUBLE))
      comment: "Total approved adjustment amount; authorized financial exposure from corrections."
    - name: "total_remaining_balance"
      expr: SUM(CAST(remaining_balance AS DOUBLE))
      comment: "Total unapplied balance on adjustment memos; outstanding credit/debit exposure."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax component of adjustments; tax liability correction tracking."
    - name: "avg_adjustment_amount"
      expr: AVG(CAST(adjustment_amount AS DOUBLE))
      comment: "Average adjustment memo value; benchmarks typical correction size."
    - name: "manual_adjustment_count"
      expr: COUNT(CASE WHEN is_manual = TRUE THEN 1 END)
      comment: "Count of manually created adjustments; process automation gap indicator."
    - name: "application_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(applied_amount AS DOUBLE)) / NULLIF(SUM(CAST(adjustment_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of adjustment amount applied; measures settlement completeness."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`invoice_ar_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core accounts receivable invoice metrics tracking revenue, collections, and invoice lifecycle performance"
  source: "`vibe_semiconductors_v1`.`invoice`.`ar_invoice`"
  dimensions:
    - name: "invoice_date"
      expr: invoice_date
      comment: "Date the invoice was issued"
    - name: "invoice_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month of invoice issuance for period analysis"
    - name: "invoice_quarter"
      expr: DATE_TRUNC('QUARTER', invoice_date)
      comment: "Quarter of invoice issuance for quarterly reporting"
    - name: "due_date"
      expr: due_date
      comment: "Payment due date for aging analysis"
    - name: "posting_date"
      expr: posting_date
      comment: "Date invoice was posted to GL"
    - name: "ar_invoice_status"
      expr: ar_invoice_status
      comment: "Current status of the invoice (open, paid, cancelled, etc.)"
    - name: "payment_status"
      expr: payment_status
      comment: "Payment collection status"
    - name: "collection_status"
      expr: collection_status
      comment: "Collections workflow status"
    - name: "currency_code"
      expr: currency_code
      comment: "Invoice currency for multi-currency analysis"
    - name: "document_type"
      expr: document_type
      comment: "Type of invoice document"
    - name: "is_credit_memo"
      expr: is_credit_memo
      comment: "Flag indicating if this is a credit memo"
    - name: "is_proforma"
      expr: is_proforma
      comment: "Flag indicating if this is a proforma invoice"
    - name: "export_control_flag"
      expr: export_control_flag
      comment: "Flag for export-controlled transactions"
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment for the invoice"
    - name: "tax_code"
      expr: tax_code
      comment: "Tax code applied to the invoice"
  measures:
    - name: "invoice_count"
      expr: COUNT(DISTINCT ar_invoice_id)
      comment: "Total number of unique invoices"
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross invoice amount before discounts and taxes"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net invoice amount after discounts before tax"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across all invoices"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount given"
    - name: "total_late_fee_amount"
      expr: SUM(CAST(late_fee_amount AS DOUBLE))
      comment: "Total late payment fees assessed"
    - name: "avg_invoice_value"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net invoice value"
    - name: "avg_days_to_due"
      expr: AVG(DATEDIFF(due_date, invoice_date))
      comment: "Average number of days from invoice to due date"
    - name: "discount_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of gross amount given as discounts"
    - name: "tax_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(tax_amount AS DOUBLE)) / NULLIF(SUM(CAST(net_amount AS DOUBLE)), 0), 2)
      comment: "Effective tax rate as percentage of net amount"
    - name: "customer_count"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique customers invoiced"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`invoice_credit_hold`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Credit risk and hold management metrics for accounts receivable risk mitigation"
  source: "`vibe_semiconductors_v1`.`invoice`.`credit_hold`"
  dimensions:
    - name: "hold_start_date"
      expr: hold_start_date
      comment: "Date the credit hold was placed"
    - name: "hold_month"
      expr: DATE_TRUNC('MONTH', hold_start_date)
      comment: "Month the hold was placed for trend analysis"
    - name: "hold_release_date"
      expr: hold_release_date
      comment: "Date the credit hold was released"
    - name: "placed_date"
      expr: placed_date
      comment: "Date hold was placed"
    - name: "released_date"
      expr: released_date
      comment: "Date hold was released"
    - name: "credit_hold_status"
      expr: credit_hold_status
      comment: "Current status of the credit hold"
    - name: "hold_status"
      expr: hold_status
      comment: "Status of the hold"
    - name: "hold_reason"
      expr: hold_reason
      comment: "Reason for placing the credit hold"
    - name: "hold_reason_code"
      expr: hold_reason_code
      comment: "Coded reason for the hold"
    - name: "hold_category"
      expr: hold_category
      comment: "Category of credit hold"
    - name: "block_level"
      expr: block_level
      comment: "Level of blocking applied"
    - name: "notification_status"
      expr: notification_status
      comment: "Status of customer notification"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of credit amounts"
  measures:
    - name: "credit_hold_count"
      expr: COUNT(DISTINCT credit_hold_id)
      comment: "Total number of credit holds placed"
    - name: "total_hold_amount"
      expr: SUM(CAST(hold_amount AS DOUBLE))
      comment: "Total amount of orders on credit hold"
    - name: "total_overdue_amount"
      expr: SUM(CAST(overdue_amount AS DOUBLE))
      comment: "Total overdue amount triggering holds"
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Total credit limit across held accounts"
    - name: "avg_hold_amount"
      expr: AVG(CAST(hold_amount AS DOUBLE))
      comment: "Average amount per credit hold"
    - name: "avg_hold_duration_days"
      expr: AVG(DATEDIFF(COALESCE(hold_release_date, CURRENT_DATE()), hold_start_date))
      comment: "Average number of days accounts are on credit hold"
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score of accounts on hold"
    - name: "credit_utilization_pct"
      expr: ROUND(100.0 * SUM(CAST(hold_amount AS DOUBLE)) / NULLIF(SUM(CAST(credit_limit AS DOUBLE)), 0), 2)
      comment: "Percentage of credit limit utilized by held amounts"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`invoice_customer_credit_limit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer credit limit metrics tracking credit availability, utilization, overdue exposure, and risk classification. Used by credit management and CFO to govern credit policy and manage portfolio risk."
  source: "`vibe_semiconductors_v1`.`invoice`.`customer_credit_limit`"
  dimensions:
    - name: "credit_limit_status"
      expr: credit_limit_status
      comment: "Status of the credit limit record (Active, Suspended, Expired)."
    - name: "credit_limit_type"
      expr: credit_limit_type
      comment: "Type of credit limit (Standard, Secured, Insured) for policy segmentation."
    - name: "credit_rating"
      expr: credit_rating
      comment: "Customer credit rating for risk-tier analysis."
    - name: "credit_risk_classification"
      expr: credit_risk_classification
      comment: "Risk classification (Low, Medium, High) for portfolio risk management."
    - name: "credit_currency"
      expr: credit_currency
      comment: "Currency of the credit limit for multi-currency portfolio management."
    - name: "business_unit"
      expr: business_unit
      comment: "Business unit owning the credit relationship for organizational reporting."
    - name: "region_code"
      expr: region_code
      comment: "Geographic region for regional credit risk analysis."
    - name: "credit_hold_flag"
      expr: credit_hold_flag
      comment: "Flag indicating customer is currently on credit hold."
    - name: "review_date_month"
      expr: DATE_TRUNC('MONTH', review_date)
      comment: "Month of next credit review for proactive risk management scheduling."
  measures:
    - name: "total_credit_limit_amount"
      expr: SUM(CAST(credit_limit_amount AS DOUBLE))
      comment: "Total credit limit extended across all customers; portfolio credit exposure."
    - name: "total_credit_used_amount"
      expr: SUM(CAST(credit_used_amount AS DOUBLE))
      comment: "Total credit currently utilized; outstanding AR exposure against limits."
    - name: "total_available_credit"
      expr: SUM(CAST(available_credit AS DOUBLE))
      comment: "Total available credit headroom; capacity for additional business without credit risk."
    - name: "total_overdue_amount"
      expr: SUM(CAST(overdue_amount AS DOUBLE))
      comment: "Total overdue amount across credit-limited customers; collections urgency."
    - name: "avg_credit_utilization_pct"
      expr: AVG(CAST(credit_utilization_pct AS DOUBLE))
      comment: "Average credit utilization percentage; portfolio-level credit stress indicator."
    - name: "avg_credit_limit_amount"
      expr: AVG(CAST(credit_limit_amount AS DOUBLE))
      comment: "Average credit limit per customer; benchmarks credit policy generosity."
    - name: "credit_hold_customer_count"
      expr: COUNT(CASE WHEN credit_hold_flag = TRUE THEN 1 END)
      comment: "Count of customers currently on credit hold; revenue risk from blocked orders."
    - name: "portfolio_utilization_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(credit_used_amount AS DOUBLE)) / NULLIF(SUM(CAST(credit_limit_amount AS DOUBLE)), 0), 2)
      comment: "Portfolio-wide credit utilization rate; key credit risk management KPI for CFO."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`invoice_dispute`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Invoice dispute and resolution metrics for customer satisfaction and process improvement"
  source: "`vibe_semiconductors_v1`.`invoice`.`dispute`"
  dimensions:
    - name: "opened_date"
      expr: opened_date
      comment: "Date the dispute was opened"
    - name: "dispute_month"
      expr: DATE_TRUNC('MONTH', opened_date)
      comment: "Month dispute was opened for trend analysis"
    - name: "resolved_date"
      expr: resolved_date
      comment: "Date the dispute was resolved"
    - name: "resolution_date"
      expr: resolution_date
      comment: "Date of resolution"
    - name: "expected_settlement_date"
      expr: expected_settlement_date
      comment: "Expected date for settlement"
    - name: "actual_settlement_date"
      expr: actual_settlement_date
      comment: "Actual settlement date"
    - name: "dispute_status"
      expr: dispute_status
      comment: "Current status of the dispute"
    - name: "resolution_status"
      expr: resolution_status
      comment: "Status of dispute resolution"
    - name: "dispute_type"
      expr: dispute_type
      comment: "Type of dispute (pricing, quality, delivery, etc.)"
    - name: "reason"
      expr: reason
      comment: "Reason for the dispute"
    - name: "reason_code"
      expr: reason_code
      comment: "Coded reason for dispute"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category for analysis"
    - name: "priority"
      expr: priority
      comment: "Priority level of the dispute"
    - name: "escalation_level"
      expr: escalation_level
      comment: "Level of escalation"
    - name: "channel"
      expr: channel
      comment: "Channel through which dispute was raised"
    - name: "source"
      expr: source
      comment: "Source of the dispute"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of disputed amounts"
  measures:
    - name: "dispute_count"
      expr: COUNT(DISTINCT dispute_id)
      comment: "Total number of invoice disputes"
    - name: "total_disputed_amount"
      expr: SUM(CAST(disputed_amount AS DOUBLE))
      comment: "Total amount under dispute"
    - name: "total_settlement_amount"
      expr: SUM(CAST(settlement_amount AS DOUBLE))
      comment: "Total amount settled in dispute resolutions"
    - name: "avg_disputed_amount"
      expr: AVG(CAST(disputed_amount AS DOUBLE))
      comment: "Average amount per dispute"
    - name: "avg_settlement_amount"
      expr: AVG(CAST(settlement_amount AS DOUBLE))
      comment: "Average settlement amount per dispute"
    - name: "avg_resolution_days"
      expr: AVG(DATEDIFF(resolved_date, opened_date))
      comment: "Average number of days to resolve disputes"
    - name: "settlement_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(settlement_amount AS DOUBLE)) / NULLIF(SUM(CAST(disputed_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of disputed amount that was settled"
    - name: "dispute_rate_per_customer"
      expr: COUNT(DISTINCT dispute_id) / NULLIF(COUNT(DISTINCT account_id), 0)
      comment: "Average number of disputes per customer"
    - name: "customer_count"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique customers with disputes"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`invoice_dunning_notice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Collections dunning and escalation metrics for overdue account management"
  source: "`vibe_semiconductors_v1`.`invoice`.`dunning_notice`"
  dimensions:
    - name: "notice_date"
      expr: notice_date
      comment: "Date the dunning notice was sent"
    - name: "notice_month"
      expr: DATE_TRUNC('MONTH', notice_date)
      comment: "Month notice was sent for trend analysis"
    - name: "original_due_date"
      expr: original_due_date
      comment: "Original due date of the overdue invoice"
    - name: "next_action_date"
      expr: next_action_date
      comment: "Date for next collection action"
    - name: "response_date"
      expr: response_date
      comment: "Date customer responded to notice"
    - name: "dunning_notice_status"
      expr: dunning_notice_status
      comment: "Status of the dunning notice"
    - name: "notice_status"
      expr: notice_status
      comment: "Current status of notice"
    - name: "dunning_level"
      expr: dunning_level
      comment: "Escalation level of dunning (1st notice, 2nd notice, final, etc.)"
    - name: "delivery_method"
      expr: delivery_method
      comment: "Method used to deliver notice (email, mail, phone, etc.)"
    - name: "response_status"
      expr: response_status
      comment: "Status of customer response"
    - name: "credit_hold_flag"
      expr: credit_hold_flag
      comment: "Flag indicating if account is on credit hold"
    - name: "legal_hold_flag"
      expr: legal_hold_flag
      comment: "Flag indicating if legal action is pending"
    - name: "dunning_fee_applied"
      expr: dunning_fee_applied
      comment: "Flag indicating if dunning fee was applied"
    - name: "escalation_threshold_exceeded"
      expr: escalation_threshold_exceeded
      comment: "Flag indicating escalation threshold breach"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of overdue amounts"
  measures:
    - name: "dunning_notice_count"
      expr: COUNT(DISTINCT dunning_notice_id)
      comment: "Total number of dunning notices sent"
    - name: "total_overdue_amount"
      expr: SUM(CAST(overdue_amount AS DOUBLE))
      comment: "Total overdue amount across all notices"
    - name: "total_due_amount"
      expr: SUM(CAST(total_due AS DOUBLE))
      comment: "Total amount due including fees and interest"
    - name: "total_interest_amount"
      expr: SUM(CAST(interest_amount AS DOUBLE))
      comment: "Total interest charged on overdue amounts"
    - name: "total_dunning_charge"
      expr: SUM(CAST(dunning_charge AS DOUBLE))
      comment: "Total dunning fees charged"
    - name: "avg_overdue_amount"
      expr: AVG(CAST(overdue_amount AS DOUBLE))
      comment: "Average overdue amount per notice"
    - name: "avg_interest_rate"
      expr: AVG(CAST(interest_rate_percent AS DOUBLE))
      comment: "Average interest rate applied"
    - name: "avg_days_overdue"
      expr: AVG(DATEDIFF(notice_date, original_due_date))
      comment: "Average number of days overdue at notice date"
    - name: "interest_to_principal_pct"
      expr: ROUND(100.0 * SUM(CAST(interest_amount AS DOUBLE)) / NULLIF(SUM(CAST(overdue_amount AS DOUBLE)), 0), 2)
      comment: "Interest as percentage of overdue principal"
    - name: "customer_count"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique customers receiving dunning notices"
    - name: "invoice_count"
      expr: COUNT(DISTINCT ar_invoice_id)
      comment: "Number of unique invoices in dunning process"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`invoice_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-level invoice metrics enabling revenue decomposition by product, charge type, sales channel, and region. Used by revenue operations, product finance, and sales leadership to analyze billing mix and margin contribution."
  source: "`vibe_semiconductors_v1`.`invoice`.`invoice_line`"
  dimensions:
    - name: "charge_type"
      expr: charge_type
      comment: "Type of charge on the line (Product, NRE, Royalty, Service) for revenue mix analysis."
    - name: "line_status"
      expr: line_status
      comment: "Processing status of the invoice line for billing completeness tracking."
    - name: "sales_channel"
      expr: sales_channel
      comment: "Sales channel (Direct, Distribution, Online) for channel revenue attribution."
    - name: "sales_region"
      expr: sales_region
      comment: "Geographic sales region for regional revenue reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Line-level billing currency for multi-currency analysis."
    - name: "revenue_recognition_category"
      expr: revenue_recognition_category
      comment: "ASC 606 revenue recognition category for compliance and financial reporting."
    - name: "billing_period_start_month"
      expr: DATE_TRUNC('MONTH', billing_period_start)
      comment: "Billing period start month for period-over-period revenue trending."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure (Units, Wafers, Dies) for volume analysis."
    - name: "is_tax_exempt"
      expr: is_tax_exempt
      comment: "Flag for tax-exempt line items; used in tax compliance reporting."
    - name: "is_discount_applied"
      expr: is_discount_applied
      comment: "Flag indicating whether a discount was applied to the line."
  measures:
    - name: "total_line_items"
      expr: COUNT(1)
      comment: "Total invoice line items; billing volume baseline."
    - name: "total_gross_line_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross billed amount across all lines; top-line revenue by segment."
    - name: "total_net_line_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net billed amount after discounts; primary revenue measure at line level."
    - name: "total_extended_amount"
      expr: SUM(CAST(extended_amount AS DOUBLE))
      comment: "Total extended amount (quantity × unit price); validates pricing accuracy."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount granted at line level; measures pricing compliance."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax charged at line level; supports tax liability reconciliation."
    - name: "total_quantity_billed"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total units/wafers/dies billed; volume throughput metric."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price across billed lines; pricing trend and ASP (average selling price) indicator."
    - name: "avg_royalty_rate_pct"
      expr: AVG(CAST(royalty_rate_percent AS DOUBLE))
      comment: "Average royalty rate applied on billed lines; IP monetization effectiveness."
    - name: "line_discount_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_amount AS DOUBLE)), 0), 2)
      comment: "Discount as a percentage of gross line amount; line-level pricing discipline metric."
    - name: "tax_exempt_line_count"
      expr: COUNT(CASE WHEN is_tax_exempt = TRUE THEN 1 END)
      comment: "Count of tax-exempt line items; compliance exposure and revenue mix indicator."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`invoice_nre_billing_milestone`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "NRE (Non-Recurring Engineering) billing milestone metrics tracking milestone amounts, billing status, and schedule adherence. Used by program finance, sales, and CFO to manage NRE revenue recognition and project billing compliance."
  source: "`vibe_semiconductors_v1`.`invoice`.`nre_billing_milestone`"
  dimensions:
    - name: "milestone_status"
      expr: milestone_status
      comment: "Current status of the NRE milestone (Planned, In Progress, Completed, Billed)."
    - name: "nre_billing_milestone_status"
      expr: nre_billing_milestone_status
      comment: "Billing-specific status of the NRE milestone for revenue recognition tracking."
    - name: "billing_trigger_type"
      expr: billing_trigger_type
      comment: "Trigger type for billing (Milestone Completion, Date, Delivery) for schedule analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of NRE billing for multi-currency program finance."
    - name: "planned_date_month"
      expr: DATE_TRUNC('MONTH', planned_date)
      comment: "Planned billing month for NRE schedule adherence tracking."
    - name: "actual_date_month"
      expr: DATE_TRUNC('MONTH', actual_date)
      comment: "Actual billing month for schedule variance analysis."
    - name: "is_recurring"
      expr: is_recurring
      comment: "Flag for recurring NRE milestones vs. one-time events."
    - name: "recurring_interval"
      expr: recurring_interval
      comment: "Recurrence interval for recurring NRE billing schedules."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms applicable to the NRE milestone."
  measures:
    - name: "total_nre_milestones"
      expr: COUNT(1)
      comment: "Total NRE billing milestones; program billing activity volume."
    - name: "total_milestone_amount"
      expr: SUM(CAST(milestone_amount AS DOUBLE))
      comment: "Total NRE milestone amount; contracted NRE revenue pipeline."
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross NRE billed amount; top-line NRE revenue."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net NRE billed amount after adjustments; recognized NRE revenue."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax on NRE billings; tax liability for NRE revenue."
    - name: "avg_milestone_amount"
      expr: AVG(CAST(milestone_amount AS DOUBLE))
      comment: "Average NRE milestone value; benchmarks NRE deal size and program scope."
    - name: "billed_milestone_count"
      expr: COUNT(CASE WHEN nre_billing_milestone_status = 'Billed' THEN 1 END)
      comment: "Count of milestones successfully billed; NRE revenue realization rate."
    - name: "billing_completion_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(net_amount AS DOUBLE)) / NULLIF(SUM(CAST(milestone_amount AS DOUBLE)), 0), 2)
      comment: "Net billed amount as a percentage of contracted milestone amount; NRE billing realization rate."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`invoice_payment_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment collection and cash application metrics for accounts receivable performance"
  source: "`vibe_semiconductors_v1`.`invoice`.`payment_receipt`"
  dimensions:
    - name: "payment_date"
      expr: payment_date
      comment: "Date payment was received"
    - name: "payment_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Month of payment receipt for period analysis"
    - name: "receipt_date"
      expr: receipt_date
      comment: "Date receipt was recorded"
    - name: "payment_status"
      expr: payment_status
      comment: "Status of the payment"
    - name: "receipt_status"
      expr: receipt_status
      comment: "Status of the receipt record"
    - name: "payment_method"
      expr: payment_method
      comment: "Method used for payment (wire, check, ACH, etc.)"
    - name: "payment_type"
      expr: payment_type
      comment: "Type of payment transaction"
    - name: "payment_channel"
      expr: payment_channel
      comment: "Channel through which payment was received"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the payment"
    - name: "on_account_payment_flag"
      expr: on_account_payment_flag
      comment: "Flag indicating payment on account without specific invoice"
    - name: "overpayment_flag"
      expr: overpayment_flag
      comment: "Flag indicating overpayment received"
    - name: "partial_payment_flag"
      expr: partial_payment_flag
      comment: "Flag indicating partial payment of invoice"
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Flag indicating payment reversal"
    - name: "compliance_check_status"
      expr: compliance_check_status
      comment: "Status of compliance checks on payment"
  measures:
    - name: "payment_count"
      expr: COUNT(DISTINCT payment_receipt_id)
      comment: "Total number of payment receipts"
    - name: "total_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total amount of payments received"
    - name: "total_amount_received"
      expr: SUM(CAST(amount_received AS DOUBLE))
      comment: "Total amount received including all components"
    - name: "total_allocated_amount"
      expr: SUM(CAST(allocated_amount_total AS DOUBLE))
      comment: "Total amount allocated to invoices"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net payment amount"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early payment discounts taken"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount in payments"
    - name: "total_residual_open_amount"
      expr: SUM(CAST(residual_open_amount AS DOUBLE))
      comment: "Total remaining open amount after allocation"
    - name: "avg_payment_amount"
      expr: AVG(CAST(payment_amount AS DOUBLE))
      comment: "Average payment amount per receipt"
    - name: "allocation_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(allocated_amount_total AS DOUBLE)) / NULLIF(SUM(CAST(amount_received AS DOUBLE)), 0), 2)
      comment: "Percentage of received amount successfully allocated to invoices"
    - name: "discount_taken_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(payment_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of payment amount representing early payment discounts"
    - name: "customer_count"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique customers making payments"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`invoice_payment_term`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment term configuration metrics tracking discount rates, penalty rates, and term policy coverage. Used by credit management and finance to govern payment policy and optimize cash collection incentives."
  source: "`vibe_semiconductors_v1`.`invoice`.`payment_term`"
  dimensions:
    - name: "payment_term_status"
      expr: payment_term_status
      comment: "Status of the payment term (Active, Inactive, Deprecated)."
    - name: "term_type"
      expr: term_type
      comment: "Type of payment term (Net, Installment, Letter of Credit) for policy classification."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency applicable to the payment term."
    - name: "applicable_to_customer_type"
      expr: applicable_to_customer_type
      comment: "Customer type the term applies to for segmented policy analysis."
    - name: "is_active"
      expr: is_active
      comment: "Flag for currently active payment terms."
    - name: "is_default"
      expr: is_default
      comment: "Flag for default payment terms; policy standardization indicator."
    - name: "letter_of_credit_required"
      expr: letter_of_credit_required
      comment: "Flag for terms requiring letter of credit; high-risk customer policy."
    - name: "tax_inclusive"
      expr: tax_inclusive
      comment: "Flag for tax-inclusive payment terms."
  measures:
    - name: "total_payment_terms"
      expr: COUNT(1)
      comment: "Total payment term configurations; policy portfolio size."
    - name: "avg_discount_percent"
      expr: AVG(CAST(discount_percent AS DOUBLE))
      comment: "Average early-payment discount percentage; cash acceleration cost benchmark."
    - name: "avg_early_payment_discount_percent"
      expr: AVG(CAST(early_payment_discount_percent AS DOUBLE))
      comment: "Average early-payment discount rate; incentive program effectiveness."
    - name: "avg_late_payment_penalty_percent"
      expr: AVG(CAST(late_payment_penalty_percent AS DOUBLE))
      comment: "Average late payment penalty rate; collections deterrence effectiveness."
    - name: "total_credit_limit_amount"
      expr: SUM(CAST(credit_limit_amount AS DOUBLE))
      comment: "Total credit limit amount embedded in payment terms; credit policy exposure."
    - name: "letter_of_credit_term_count"
      expr: COUNT(CASE WHEN letter_of_credit_required = TRUE THEN 1 END)
      comment: "Count of terms requiring letter of credit; high-risk customer policy coverage."
    - name: "active_term_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Count of currently active payment terms; policy portfolio health."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`invoice_performance_obligation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "ASC 606 performance obligation metrics tracking allocated amounts, recognition progress, and obligation fulfillment. Used by accounting and revenue operations to ensure compliant multi-element arrangement accounting."
  source: "`vibe_semiconductors_v1`.`invoice`.`performance_obligation`"
  dimensions:
    - name: "obligation_status"
      expr: obligation_status
      comment: "Current status of the performance obligation (Open, Partially Satisfied, Fully Satisfied)."
    - name: "performance_obligation_status"
      expr: performance_obligation_status
      comment: "Detailed obligation status for ASC 606 compliance tracking."
    - name: "obligation_type"
      expr: obligation_type
      comment: "Type of obligation (Product Delivery, Service, License, NRE) for revenue policy classification."
    - name: "revenue_recognition_method"
      expr: revenue_recognition_method
      comment: "Recognition method (Point-in-Time, Over-Time) for accounting policy compliance."
    - name: "satisfaction_method"
      expr: satisfaction_method
      comment: "Method of obligation satisfaction for audit documentation."
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "Billing frequency for recurring obligation revenue scheduling."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the obligation for multi-currency revenue management."
    - name: "effective_start_date_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month obligation became effective for cohort analysis."
    - name: "measurement_unit"
      expr: measurement_unit
      comment: "Unit of measurement for obligation progress tracking."
  measures:
    - name: "total_performance_obligations"
      expr: COUNT(1)
      comment: "Total performance obligations; ASC 606 contract portfolio size."
    - name: "total_allocated_amount"
      expr: SUM(CAST(allocated_amount AS DOUBLE))
      comment: "Total transaction price allocated to obligations; contracted revenue by obligation."
    - name: "total_recognized_amount"
      expr: SUM(CAST(recognized_amount AS DOUBLE))
      comment: "Total amount recognized from obligations; revenue realization progress."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax on performance obligations; tax liability tracking."
    - name: "total_target_quantity"
      expr: SUM(CAST(target_quantity AS DOUBLE))
      comment: "Total target quantity across obligations; contracted volume commitment."
    - name: "total_actual_quantity"
      expr: SUM(CAST(actual_quantity AS DOUBLE))
      comment: "Total actual quantity delivered against obligations; fulfillment progress."
    - name: "avg_allocated_amount"
      expr: AVG(CAST(allocated_amount AS DOUBLE))
      comment: "Average allocated amount per obligation; benchmarks obligation size."
    - name: "recognition_completion_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(recognized_amount AS DOUBLE)) / NULLIF(SUM(CAST(allocated_amount AS DOUBLE)), 0), 2)
      comment: "Recognized amount as a percentage of allocated amount; obligation fulfillment and revenue realization rate."
    - name: "quantity_fulfillment_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_quantity AS DOUBLE)) / NULLIF(SUM(CAST(target_quantity AS DOUBLE)), 0), 2)
      comment: "Actual quantity delivered as a percentage of target; delivery obligation fulfillment rate."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`invoice_pricing_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer pricing agreement metrics tracking contracted prices, rebate accruals, discount rates, and commitment fulfillment. Used by sales finance, pricing, and commercial leadership to manage pricing compliance and rebate liability."
  source: "`vibe_semiconductors_v1`.`invoice`.`pricing_agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the pricing agreement (Active, Expired, Pending Approval)."
    - name: "pricing_agreement_status"
      expr: pricing_agreement_status
      comment: "Detailed pricing agreement status for commercial management."
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of pricing agreement (Volume, Tiered, Fixed, Rebate) for commercial analysis."
    - name: "pricing_model"
      expr: pricing_model
      comment: "Pricing model applied (Cost-Plus, Market-Based, Negotiated) for margin analysis."
    - name: "rebate_type"
      expr: rebate_type
      comment: "Type of rebate (Volume, Growth, Loyalty) for rebate program management."
    - name: "settlement_frequency"
      expr: settlement_frequency
      comment: "Rebate settlement frequency (Monthly, Quarterly, Annual) for cash flow planning."
    - name: "currency_code"
      expr: currency_code
      comment: "Agreement currency for multi-currency pricing management."
    - name: "effective_start_date_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month agreement became effective for cohort and renewal analysis."
    - name: "is_exclusive"
      expr: is_exclusive
      comment: "Flag for exclusive pricing agreements; strategic customer relationship indicator."
    - name: "is_confidential"
      expr: is_confidential
      comment: "Flag for confidential pricing agreements; compliance and access control."
  measures:
    - name: "total_pricing_agreements"
      expr: COUNT(1)
      comment: "Total active pricing agreements; commercial portfolio size."
    - name: "total_price_amount"
      expr: SUM(CAST(price_amount AS DOUBLE))
      comment: "Total contracted price amount across agreements; pricing portfolio value."
    - name: "total_minimum_commitment"
      expr: SUM(CAST(minimum_commitment_amount AS DOUBLE))
      comment: "Total minimum purchase commitments; contracted revenue floor."
    - name: "total_maximum_commitment"
      expr: SUM(CAST(maximum_commitment_amount AS DOUBLE))
      comment: "Total maximum purchase commitments; contracted revenue ceiling."
    - name: "total_rebate_accrued"
      expr: SUM(CAST(rebate_accrued_amount AS DOUBLE))
      comment: "Total rebate liability accrued; balance sheet rebate payable exposure."
    - name: "total_rebate_settled"
      expr: SUM(CAST(rebate_settled_amount AS DOUBLE))
      comment: "Total rebate amounts settled; cash outflow from rebate programs."
    - name: "avg_discount_rate_pct"
      expr: AVG(CAST(discount_rate AS DOUBLE))
      comment: "Average discount rate across pricing agreements; pricing discipline benchmark."
    - name: "avg_rebate_rate_pct"
      expr: AVG(CAST(rebate_rate AS DOUBLE))
      comment: "Average rebate rate across agreements; rebate program cost benchmark."
    - name: "rebate_settlement_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(rebate_settled_amount AS DOUBLE)) / NULLIF(SUM(CAST(rebate_accrued_amount AS DOUBLE)), 0), 2)
      comment: "Rebate settled as a percentage of accrued; rebate liability resolution rate."
    - name: "volume_threshold_total"
      expr: SUM(CAST(volume_threshold AS DOUBLE))
      comment: "Total volume thresholds across tiered agreements; contracted volume commitment portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`invoice_recognition_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue recognition schedule metrics tracking scheduled vs. recognized amounts and schedule adherence. Used by accounting and revenue operations to manage deferred revenue amortization and period-close accuracy."
  source: "`vibe_semiconductors_v1`.`invoice`.`recognition_schedule`"
  dimensions:
    - name: "schedule_status"
      expr: schedule_status
      comment: "Current status of the recognition schedule (Active, Completed, Cancelled)."
    - name: "recognition_schedule_status"
      expr: recognition_schedule_status
      comment: "Detailed recognition schedule status for close management."
    - name: "schedule_type"
      expr: schedule_type
      comment: "Type of recognition schedule (Straight-Line, Milestone, Usage-Based)."
    - name: "recognition_method"
      expr: recognition_method
      comment: "Revenue recognition method applied on the schedule."
    - name: "frequency"
      expr: frequency
      comment: "Recognition frequency (Monthly, Quarterly, Annual) for schedule management."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the recognition schedule."
    - name: "scheduled_date_month"
      expr: DATE_TRUNC('MONTH', scheduled_date)
      comment: "Month of scheduled recognition for period-close planning."
    - name: "recognized_flag"
      expr: recognized_flag
      comment: "Flag indicating whether the scheduled amount has been recognized."
    - name: "is_prorated"
      expr: is_prorated
      comment: "Flag for prorated recognition schedules; partial-period revenue accuracy."
  measures:
    - name: "total_recognition_schedules"
      expr: COUNT(1)
      comment: "Total recognition schedule records; deferred revenue amortization portfolio size."
    - name: "total_scheduled_amount"
      expr: SUM(CAST(scheduled_amount AS DOUBLE))
      comment: "Total amount scheduled for recognition; deferred revenue pipeline."
    - name: "total_amount_per_period"
      expr: SUM(CAST(amount_per_period AS DOUBLE))
      comment: "Total periodic recognition amount; revenue run-rate from scheduled recognition."
    - name: "avg_amount_per_period"
      expr: AVG(CAST(amount_per_period AS DOUBLE))
      comment: "Average periodic recognition amount; benchmarks deferred revenue amortization rate."
    - name: "recognized_schedule_count"
      expr: COUNT(CASE WHEN recognized_flag = TRUE THEN 1 END)
      comment: "Count of schedules where recognition has been completed; close completeness indicator."
    - name: "recognition_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN recognized_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of scheduled recognition events completed; period-close accuracy KPI."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`invoice_revenue_recognition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue recognition metrics for financial reporting and compliance with accounting standards"
  source: "`vibe_semiconductors_v1`.`invoice`.`revenue_recognition_event`"
  dimensions:
    - name: "recognition_date"
      expr: recognition_date
      comment: "Date revenue was recognized"
    - name: "recognition_month"
      expr: DATE_TRUNC('MONTH', recognition_date)
      comment: "Month of revenue recognition for period reporting"
    - name: "recognition_quarter"
      expr: DATE_TRUNC('QUARTER', recognition_date)
      comment: "Quarter of revenue recognition for quarterly reporting"
    - name: "accounting_period"
      expr: accounting_period
      comment: "Accounting period for the recognition event"
    - name: "period_start_date"
      expr: period_start_date
      comment: "Start date of the recognition period"
    - name: "period_end_date"
      expr: period_end_date
      comment: "End date of the recognition period"
    - name: "event_type"
      expr: event_type
      comment: "Type of revenue recognition event"
    - name: "event_status"
      expr: event_status
      comment: "Status of the recognition event"
    - name: "revenue_recognition_event_status"
      expr: revenue_recognition_event_status
      comment: "Detailed status of revenue recognition"
    - name: "recognition_method"
      expr: recognition_method
      comment: "Method used for revenue recognition (point-in-time, over-time, etc.)"
    - name: "revenue_category"
      expr: revenue_category
      comment: "Category of revenue for classification"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the revenue"
    - name: "is_reversed"
      expr: is_reversed
      comment: "Flag indicating if the recognition was reversed"
  measures:
    - name: "recognition_event_count"
      expr: COUNT(DISTINCT revenue_recognition_event_id)
      comment: "Total number of revenue recognition events"
    - name: "total_revenue_amount"
      expr: SUM(CAST(revenue_amount AS DOUBLE))
      comment: "Total revenue recognized in the period"
    - name: "total_recognized_amount"
      expr: SUM(CAST(recognized_amount AS DOUBLE))
      comment: "Total amount recognized across all events"
    - name: "total_deferred_amount"
      expr: SUM(CAST(deferred_amount AS DOUBLE))
      comment: "Total amount deferred for future recognition"
    - name: "total_cogs_amount"
      expr: SUM(CAST(cost_of_goods_sold_amount AS DOUBLE))
      comment: "Total cost of goods sold associated with recognized revenue"
    - name: "total_profit_amount"
      expr: SUM(CAST(profit_amount AS DOUBLE))
      comment: "Total profit from recognized revenue"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on recognized revenue"
    - name: "avg_revenue_per_event"
      expr: AVG(CAST(revenue_amount AS DOUBLE))
      comment: "Average revenue amount per recognition event"
    - name: "gross_margin_pct"
      expr: ROUND(100.0 * SUM(CAST(profit_amount AS DOUBLE)) / NULLIF(SUM(CAST(revenue_amount AS DOUBLE)), 0), 2)
      comment: "Gross margin percentage on recognized revenue"
    - name: "deferral_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(deferred_amount AS DOUBLE)) / NULLIF(SUM(CAST(revenue_amount AS DOUBLE)) + SUM(CAST(deferred_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of total revenue that is deferred"
    - name: "customer_count"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique customers with revenue recognition"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`invoice_revenue_recognition_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "ASC 606 revenue recognition event metrics tracking recognized amounts, deferred revenue, COGS, and profit by period. Used by accounting, CFO, and external auditors to ensure compliant revenue recognition and financial reporting accuracy."
  source: "`vibe_semiconductors_v1`.`invoice`.`revenue_recognition_event`"
  dimensions:
    - name: "event_status"
      expr: event_status
      comment: "Status of the recognition event (Pending, Recognized, Reversed, Deferred)."
    - name: "revenue_recognition_event_status"
      expr: revenue_recognition_event_status
      comment: "Detailed recognition event status for ASC 606 compliance tracking."
    - name: "event_type"
      expr: event_type
      comment: "Type of recognition event (Point-in-Time, Over-Time) for revenue policy classification."
    - name: "recognition_method"
      expr: recognition_method
      comment: "Revenue recognition method applied (Percentage Completion, Milestone, Delivery)."
    - name: "revenue_category"
      expr: revenue_category
      comment: "Revenue category (Product, Service, License, NRE) for P&L line reporting."
    - name: "accounting_period"
      expr: accounting_period
      comment: "Accounting period for financial close and period-over-period analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of recognition events for multi-currency financial reporting."
    - name: "recognition_date_month"
      expr: DATE_TRUNC('MONTH', recognition_date)
      comment: "Month of revenue recognition for trend and close analysis."
    - name: "is_reversed"
      expr: is_reversed
      comment: "Flag for reversed recognition events; audit trail and restatement risk."
  measures:
    - name: "total_recognition_events"
      expr: COUNT(1)
      comment: "Total revenue recognition events; financial close activity volume."
    - name: "total_recognized_amount"
      expr: SUM(CAST(recognized_amount AS DOUBLE))
      comment: "Total revenue recognized; primary top-line revenue KPI for financial reporting."
    - name: "total_revenue_amount"
      expr: SUM(CAST(revenue_amount AS DOUBLE))
      comment: "Total revenue amount from recognition events; P&L revenue line."
    - name: "total_deferred_amount"
      expr: SUM(CAST(deferred_amount AS DOUBLE))
      comment: "Total deferred revenue balance; balance sheet liability and future revenue pipeline."
    - name: "total_cogs_amount"
      expr: SUM(CAST(cost_of_goods_sold_amount AS DOUBLE))
      comment: "Total cost of goods sold recognized; gross margin calculation input."
    - name: "total_profit_amount"
      expr: SUM(CAST(profit_amount AS DOUBLE))
      comment: "Total profit from recognized revenue events; gross profit KPI."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax on recognized revenue; tax provision accuracy."
    - name: "avg_recognized_amount"
      expr: AVG(CAST(recognized_amount AS DOUBLE))
      comment: "Average recognized amount per event; benchmarks recognition transaction size."
    - name: "reversal_count"
      expr: COUNT(CASE WHEN is_reversed = TRUE THEN 1 END)
      comment: "Count of reversed recognition events; restatement risk and audit flag."
    - name: "gross_margin_pct"
      expr: ROUND(100.0 * SUM(CAST(profit_amount AS DOUBLE)) / NULLIF(SUM(CAST(revenue_amount AS DOUBLE)), 0), 2)
      comment: "Gross margin percentage from recognized revenue events; profitability KPI for CFO and board."
    - name: "deferred_revenue_ratio_pct"
      expr: ROUND(100.0 * SUM(CAST(deferred_amount AS DOUBLE)) / NULLIF(SUM(CAST(revenue_amount AS DOUBLE)), 0), 2)
      comment: "Deferred revenue as a percentage of total revenue; forward revenue visibility and balance sheet health."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`invoice_royalty_billing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Intellectual property royalty billing metrics for licensing revenue management"
  source: "`vibe_semiconductors_v1`.`invoice`.`royalty_billing`"
  dimensions:
    - name: "billing_date"
      expr: billing_date
      comment: "Date the royalty billing was generated"
    - name: "billing_month"
      expr: DATE_TRUNC('MONTH', billing_date)
      comment: "Month of royalty billing for period analysis"
    - name: "billing_quarter"
      expr: DATE_TRUNC('QUARTER', billing_date)
      comment: "Quarter of royalty billing for quarterly reporting"
    - name: "billing_period_start"
      expr: billing_period_start
      comment: "Start date of the billing period"
    - name: "billing_period_end"
      expr: billing_period_end
      comment: "End date of the billing period"
    - name: "royalty_period_start"
      expr: royalty_period_start
      comment: "Start date of the royalty period"
    - name: "royalty_period_end"
      expr: royalty_period_end
      comment: "End date of the royalty period"
    - name: "due_date"
      expr: due_date
      comment: "Payment due date"
    - name: "billing_status"
      expr: billing_status
      comment: "Status of the royalty billing"
    - name: "royalty_billing_status"
      expr: royalty_billing_status
      comment: "Detailed royalty billing status"
    - name: "royalty_type"
      expr: royalty_type
      comment: "Type of royalty (per-unit, revenue-based, etc.)"
    - name: "royalty_calculation_method"
      expr: royalty_calculation_method
      comment: "Method used to calculate royalty"
    - name: "tier_level"
      expr: tier_level
      comment: "Tier level for tiered royalty structures"
    - name: "region_code"
      expr: region_code
      comment: "Geographic region for the royalty"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of royalty billing"
    - name: "audit_status"
      expr: audit_status
      comment: "Audit status of the royalty billing"
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status"
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Flag indicating if billing is disputed"
  measures:
    - name: "royalty_billing_count"
      expr: COUNT(DISTINCT royalty_billing_id)
      comment: "Total number of royalty billing records"
    - name: "total_royalty_amount"
      expr: SUM(CAST(royalty_amount AS DOUBLE))
      comment: "Total royalty amount billed"
    - name: "total_royalty_amount_gross"
      expr: SUM(CAST(royalty_amount_gross AS DOUBLE))
      comment: "Total gross royalty amount before adjustments"
    - name: "total_royalty_amount_net"
      expr: SUM(CAST(royalty_amount_net AS DOUBLE))
      comment: "Total net royalty amount after adjustments"
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total adjustments to royalty amounts"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax on royalty billings"
    - name: "total_units_shipped"
      expr: SUM(CAST(units_shipped AS BIGINT))
      comment: "Total units shipped triggering royalty"
    - name: "total_units_sold"
      expr: SUM(CAST(units_sold AS BIGINT))
      comment: "Total units sold for royalty calculation"
    - name: "avg_royalty_rate"
      expr: AVG(CAST(royalty_rate AS DOUBLE))
      comment: "Average royalty rate across billings"
    - name: "avg_royalty_per_unit"
      expr: SUM(CAST(royalty_amount AS DOUBLE)) / NULLIF(SUM(CAST(units_sold AS BIGINT)), 0)
      comment: "Average royalty amount per unit sold"
    - name: "effective_royalty_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(royalty_amount_net AS DOUBLE)) / NULLIF(SUM(CAST(royalty_amount_gross AS DOUBLE)), 0), 2)
      comment: "Effective royalty rate after adjustments"
    - name: "customer_count"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique licensees billed"
    - name: "ip_core_count"
      expr: COUNT(DISTINCT product_ip_core_id)
      comment: "Number of unique IP cores generating royalties"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`invoice_tax_determination`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tax determination metrics tracking tax amounts, rates, withholding, and exemptions by jurisdiction. Used by tax, finance, and compliance teams to manage tax liability, audit readiness, and regulatory reporting."
  source: "`vibe_semiconductors_v1`.`invoice`.`tax_determination`"
  dimensions:
    - name: "tax_type"
      expr: tax_type
      comment: "Type of tax (VAT, GST, Sales Tax, Withholding) for tax liability classification."
    - name: "tax_category"
      expr: tax_category
      comment: "Tax category for financial reporting and tax provision segmentation."
    - name: "tax_jurisdiction"
      expr: tax_jurisdiction
      comment: "Tax jurisdiction for geographic tax liability analysis."
    - name: "tax_jurisdiction_type"
      expr: tax_jurisdiction_type
      comment: "Jurisdiction type (Federal, State, Local) for tax authority reporting."
    - name: "tax_line_status"
      expr: tax_line_status
      comment: "Processing status of the tax determination line."
    - name: "tax_calculation_method"
      expr: tax_calculation_method
      comment: "Method used for tax calculation (Inclusive, Exclusive, Reverse Charge)."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of tax determination for multi-currency tax reporting."
    - name: "tax_reporting_period_month"
      expr: DATE_TRUNC('MONTH', tax_reporting_period)
      comment: "Tax reporting period month for periodic tax filing."
    - name: "is_tax_exempt"
      expr: is_tax_exempt
      comment: "Flag for tax-exempt transactions; exemption compliance tracking."
    - name: "tax_is_reverse_charge"
      expr: tax_is_reverse_charge
      comment: "Flag for reverse charge mechanism transactions; VAT compliance."
    - name: "tax_withholding_flag"
      expr: tax_withholding_flag
      comment: "Flag for withholding tax transactions; cross-border payment compliance."
    - name: "tax_credit_eligible"
      expr: tax_credit_eligible
      comment: "Flag for tax credit eligible transactions; tax optimization opportunity."
  measures:
    - name: "total_tax_determinations"
      expr: COUNT(1)
      comment: "Total tax determination records; tax transaction volume baseline."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount determined; primary tax liability KPI for tax provision."
    - name: "total_taxable_amount"
      expr: SUM(CAST(taxable_amount AS DOUBLE))
      comment: "Total taxable base amount; tax exposure basis for audit."
    - name: "total_tax_base_amount"
      expr: SUM(CAST(tax_base_amount AS DOUBLE))
      comment: "Total tax base amount for rate verification and audit reconciliation."
    - name: "total_withholding_amount"
      expr: SUM(CAST(withholding_amount AS DOUBLE))
      comment: "Total withholding tax amount; cross-border payment tax compliance."
    - name: "total_tax_credit_amount"
      expr: SUM(CAST(tax_credit_amount AS DOUBLE))
      comment: "Total tax credits applied; tax optimization and net liability reduction."
    - name: "avg_tax_rate_pct"
      expr: AVG(CAST(tax_rate AS DOUBLE))
      comment: "Average effective tax rate applied; tax rate compliance benchmark."
    - name: "avg_withholding_rate_pct"
      expr: AVG(CAST(withholding_rate AS DOUBLE))
      comment: "Average withholding tax rate; cross-border tax cost benchmark."
    - name: "effective_tax_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(tax_amount AS DOUBLE)) / NULLIF(SUM(CAST(taxable_amount AS DOUBLE)), 0), 2)
      comment: "Effective tax rate as a percentage of taxable amount; tax burden and compliance KPI."
    - name: "reverse_charge_count"
      expr: COUNT(CASE WHEN tax_is_reverse_charge = TRUE THEN 1 END)
      comment: "Count of reverse charge mechanism transactions; VAT compliance exposure."
    - name: "tax_exempt_transaction_count"
      expr: COUNT(CASE WHEN is_tax_exempt = TRUE THEN 1 END)
      comment: "Count of tax-exempt transactions; exemption certificate compliance tracking."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`invoice_write_off`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bad debt write-off metrics for credit loss analysis and financial reporting"
  source: "`vibe_semiconductors_v1`.`invoice`.`write_off`"
  dimensions:
    - name: "write_off_date"
      expr: write_off_date
      comment: "Date the write-off was recorded"
    - name: "write_off_month"
      expr: DATE_TRUNC('MONTH', write_off_date)
      comment: "Month of write-off for trend analysis"
    - name: "write_off_quarter"
      expr: DATE_TRUNC('QUARTER', write_off_date)
      comment: "Quarter of write-off for quarterly reporting"
    - name: "effective_date"
      expr: effective_date
      comment: "Effective date of the write-off"
    - name: "reversal_date"
      expr: reversal_date
      comment: "Date of write-off reversal if applicable"
    - name: "write_off_status"
      expr: write_off_status
      comment: "Status of the write-off"
    - name: "write_off_type"
      expr: write_off_type
      comment: "Type of write-off (bad debt, adjustment, etc.)"
    - name: "write_off_category"
      expr: write_off_category
      comment: "Category of write-off"
    - name: "reason"
      expr: reason
      comment: "Reason for the write-off"
    - name: "reason_code"
      expr: reason_code
      comment: "Coded reason for write-off"
    - name: "write_off_reason"
      expr: write_off_reason
      comment: "Detailed write-off reason"
    - name: "method"
      expr: method
      comment: "Method used for write-off"
    - name: "recovery_status"
      expr: recovery_status
      comment: "Status of recovery attempts"
    - name: "recovery_flag"
      expr: recovery_flag
      comment: "Flag indicating if recovery is possible"
    - name: "is_reversed"
      expr: is_reversed
      comment: "Flag indicating if write-off was reversed"
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Flag for compliance requirements"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of write-off amounts"
    - name: "region_code"
      expr: region_code
      comment: "Geographic region of write-off"
    - name: "financial_period"
      expr: financial_period
      comment: "Financial period for the write-off"
  measures:
    - name: "write_off_count"
      expr: COUNT(DISTINCT write_off_id)
      comment: "Total number of write-off transactions"
    - name: "total_write_off_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total amount written off as bad debt"
    - name: "total_amount_gross"
      expr: SUM(CAST(amount_gross AS DOUBLE))
      comment: "Total gross amount before adjustments"
    - name: "total_amount_net"
      expr: SUM(CAST(amount_net AS DOUBLE))
      comment: "Total net amount written off"
    - name: "total_amount_adjustment"
      expr: SUM(CAST(amount_adjustment AS DOUBLE))
      comment: "Total adjustments to write-off amounts"
    - name: "total_tax_effect_amount"
      expr: SUM(CAST(tax_effect_amount AS DOUBLE))
      comment: "Total tax effect of write-offs"
    - name: "avg_write_off_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average amount per write-off"
    - name: "customer_count"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique customers with write-offs"
    - name: "invoice_count"
      expr: COUNT(DISTINCT ar_invoice_id)
      comment: "Number of unique invoices written off"
$$;
