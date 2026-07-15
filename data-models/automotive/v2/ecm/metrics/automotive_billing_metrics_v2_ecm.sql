-- Metric views for domain: billing | Business: Automotive | Version: 2 | Generated on: 2026-07-14 01:46:32

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`billing_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core invoice metrics tracking revenue, payment performance, and dispute rates across sales channels and vehicle programs"
  source: "`vibe_automotive_v1`.`billing`.`invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the invoice (open, paid, cancelled, disputed)"
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of invoice (vehicle sale, parts, service, fleet, etc.)"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the invoice for period-over-period analysis"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period (month) for trend analysis"
    - name: "invoice_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Invoice date truncated to month for time-series analysis"
    - name: "sales_region_code"
      expr: sales_region_code
      comment: "Sales region for geographic performance analysis"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the invoice for multi-currency reporting"
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment (wire, check, credit card, financing)"
    - name: "model_year"
      expr: model_year
      comment: "Vehicle model year for product mix analysis"
    - name: "billing_entity_code"
      expr: billing_entity_code
      comment: "Legal entity issuing the invoice for consolidation reporting"
  measures:
    - name: "Total Invoices"
      expr: COUNT(1)
      comment: "Total number of invoices issued"
    - name: "Total Gross Amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Sum of gross invoice amounts before discounts and taxes"
    - name: "Total Net Amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Sum of net invoice amounts after discounts and before taxes - primary revenue metric"
    - name: "Total Tax Amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Sum of tax amounts collected on invoices"
    - name: "Total Discount Amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Sum of discounts applied to invoices"
    - name: "Total Outstanding Amount"
      expr: SUM(CAST(outstanding_amount AS DOUBLE))
      comment: "Sum of amounts still owed on invoices - key AR metric"
    - name: "Total Paid Amount"
      expr: SUM(CAST(paid_amount AS DOUBLE))
      comment: "Sum of amounts already paid on invoices"
    - name: "Avg Invoice Net Amount"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net invoice value - indicator of deal size"
    - name: "Disputed Invoices"
      expr: COUNT(CASE WHEN dispute_reason IS NOT NULL THEN 1 END)
      comment: "Count of invoices with disputes - quality and satisfaction indicator"
    - name: "Cancelled Invoices"
      expr: COUNT(CASE WHEN invoice_status = 'cancelled' THEN 1 END)
      comment: "Count of cancelled invoices - process efficiency indicator"
    - name: "Discount Rate Pct"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of gross amount given as discounts - pricing strategy effectiveness"
    - name: "Collection Rate Pct"
      expr: ROUND(100.0 * SUM(CAST(paid_amount AS DOUBLE)) / NULLIF(SUM(CAST(net_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of net amount collected - cash conversion efficiency"
    - name: "Dispute Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN dispute_reason IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of invoices disputed - customer satisfaction and billing quality indicator"
$$;


CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`billing_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment performance metrics tracking cash collection, reconciliation efficiency, and payment channel effectiveness"
  source: "`vibe_automotive_v1`.`billing`.`payment`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Current status of the payment (cleared, pending, returned, disputed)"
    - name: "payment_method"
      expr: method
      comment: "Payment method (wire, check, ACH, credit card, lockbox)"
    - name: "payment_channel"
      expr: channel
      comment: "Channel through which payment was received"
    - name: "payment_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Payment date truncated to month for time-series analysis"
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Status of payment reconciliation to invoices"
    - name: "currency"
      expr: currency
      comment: "Currency of the payment"
    - name: "payer_entity_type"
      expr: payer_entity_type
      comment: "Type of entity making payment (dealer, fleet, individual, corporate)"
    - name: "processor"
      expr: processor
      comment: "Payment processor used"
  measures:
    - name: "Total Payments"
      expr: COUNT(1)
      comment: "Total number of payment transactions received"
    - name: "Total Payment Amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total cash received - primary cash flow metric"
    - name: "Total Applied Amount"
      expr: SUM(CAST(applied_amount AS DOUBLE))
      comment: "Total amount successfully applied to invoices"
    - name: "Total Unapplied Amount"
      expr: SUM(CAST(unapplied_amount AS DOUBLE))
      comment: "Total amount not yet applied to invoices - reconciliation backlog indicator"
    - name: "Total Discount Taken"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early payment discounts taken by customers"
    - name: "Avg Payment Amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average payment transaction size"
    - name: "Returned Payments"
      expr: COUNT(CASE WHEN return_reason_code IS NOT NULL THEN 1 END)
      comment: "Count of payments returned (NSF, stop payment, etc.) - credit risk indicator"
    - name: "Disputed Payments"
      expr: COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END)
      comment: "Count of payments under dispute"
    - name: "Application Rate Pct"
      expr: ROUND(100.0 * SUM(CAST(applied_amount AS DOUBLE)) / NULLIF(SUM(CAST(amount AS DOUBLE)), 0), 2)
      comment: "Percentage of received payments successfully applied - reconciliation efficiency"
    - name: "Return Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN return_reason_code IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of payments returned - credit quality and process risk indicator"
    - name: "Unique Payers"
      expr: COUNT(DISTINCT party_id)
      comment: "Count of distinct parties making payments - customer base breadth"
$$;


CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`billing_receivable`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts receivable aging and collection performance metrics for working capital management"
  source: "`vibe_automotive_v1`.`billing`.`receivable`"
  dimensions:
    - name: "receivable_status"
      expr: receivable_status
      comment: "Current status of the receivable (open, closed, written off)"
    - name: "aging_bucket"
      expr: aging_bucket
      comment: "Aging category (current, 30, 60, 90, 90+ days) for DSO analysis"
    - name: "collection_status"
      expr: collection_status
      comment: "Collection activity status (active, on hold, legal, etc.)"
    - name: "dunning_level"
      expr: dunning_level
      comment: "Escalation level of collection notices sent"
    - name: "sales_region"
      expr: sales_region
      comment: "Sales region for geographic collection performance"
    - name: "customer_type"
      expr: customer_type
      comment: "Type of customer (dealer, fleet, retail, etc.)"
    - name: "credit_hold_flag"
      expr: credit_hold_flag
      comment: "Whether account is on credit hold due to delinquency"
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Whether receivable is under dispute"
  measures:
    - name: "Total Receivables"
      expr: COUNT(1)
      comment: "Total number of open receivable records"
    - name: "Total Outstanding Balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total accounts receivable balance - key working capital metric"
    - name: "Total Original Amount"
      expr: SUM(CAST(original_amount AS DOUBLE))
      comment: "Total original invoice amounts for receivables"
    - name: "Total Write Off Amount"
      expr: SUM(CAST(write_off_amount AS DOUBLE))
      comment: "Total amount written off as uncollectible - bad debt indicator"
    - name: "Avg Outstanding Balance"
      expr: AVG(CAST(outstanding_balance AS DOUBLE))
      comment: "Average receivable balance per account"
    - name: "Avg Days Past Due"
      expr: AVG(CAST(days_past_due AS DOUBLE))
      comment: "Average number of days invoices are overdue - collection effectiveness indicator"
    - name: "Disputed Receivables"
      expr: COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END)
      comment: "Count of receivables under dispute - quality and satisfaction indicator"
    - name: "Credit Hold Accounts"
      expr: COUNT(CASE WHEN credit_hold_flag = TRUE THEN 1 END)
      comment: "Count of accounts on credit hold - credit risk exposure"
    - name: "Written Off Receivables"
      expr: COUNT(CASE WHEN write_off_flag = TRUE THEN 1 END)
      comment: "Count of receivables written off as uncollectible"
    - name: "Write Off Rate Pct"
      expr: ROUND(100.0 * SUM(CAST(write_off_amount AS DOUBLE)) / NULLIF(SUM(CAST(original_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of original amount written off - bad debt rate and credit quality indicator"
    - name: "Dispute Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of receivables disputed - billing quality indicator"
    - name: "Credit Hold Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN credit_hold_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of accounts on credit hold - credit risk concentration"
    - name: "Unique Debtors"
      expr: COUNT(DISTINCT account_id)
      comment: "Count of distinct accounts with outstanding receivables"
$$;


CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`billing_credit_memo`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Credit memo metrics tracking returns, adjustments, and customer satisfaction through credit issuance patterns"
  source: "`vibe_automotive_v1`.`billing`.`credit_memo`"
  dimensions:
    - name: "credit_memo_status"
      expr: credit_memo_status
      comment: "Current status of the credit memo (pending, approved, rejected, posted)"
    - name: "credit_type"
      expr: credit_type
      comment: "Type of credit (warranty, goodwill, return, pricing adjustment, etc.)"
    - name: "credit_reason_code"
      expr: credit_reason_code
      comment: "Reason code for the credit issuance"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for period analysis"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for trend analysis"
    - name: "issue_month"
      expr: DATE_TRUNC('MONTH', issue_date)
      comment: "Credit memo issue date truncated to month"
    - name: "sales_organization"
      expr: sales_organization
      comment: "Sales organization issuing the credit"
    - name: "model_year"
      expr: model_year
      comment: "Vehicle model year associated with the credit"
    - name: "approval_status"
      expr: CASE WHEN approval_date IS NOT NULL THEN 'Approved' WHEN rejection_reason IS NOT NULL THEN 'Rejected' ELSE 'Pending' END
      comment: "Derived approval status for workflow analysis"
  measures:
    - name: "Total Credit Memos"
      expr: COUNT(1)
      comment: "Total number of credit memos issued"
    - name: "Total Gross Credit Amount"
      expr: SUM(CAST(gross_credit_amount AS DOUBLE))
      comment: "Total gross credit amount before taxes"
    - name: "Total Net Credit Amount"
      expr: SUM(CAST(net_credit_amount AS DOUBLE))
      comment: "Total net credit amount issued - primary revenue reversal metric"
    - name: "Total Tax Credit Amount"
      expr: SUM(CAST(tax_credit_amount AS DOUBLE))
      comment: "Total tax amount credited back"
    - name: "Avg Credit Amount"
      expr: AVG(CAST(net_credit_amount AS DOUBLE))
      comment: "Average credit memo value - indicator of issue severity"
    - name: "Approved Credit Memos"
      expr: COUNT(CASE WHEN approval_date IS NOT NULL THEN 1 END)
      comment: "Count of approved credit memos"
    - name: "Rejected Credit Memos"
      expr: COUNT(CASE WHEN rejection_reason IS NOT NULL THEN 1 END)
      comment: "Count of rejected credit memo requests"
    - name: "Approval Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN approval_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of credit memos approved - policy adherence and control effectiveness"
    - name: "Unique Credited Parties"
      expr: COUNT(DISTINCT credit_party_id)
      comment: "Count of distinct parties receiving credits - breadth of quality issues"
    - name: "Warranty Related Credits"
      expr: COUNT(CASE WHEN aftersales_warranty_claim_id IS NOT NULL THEN 1 END)
      comment: "Count of credits related to warranty claims - product quality indicator"
    - name: "Recall Related Credits"
      expr: COUNT(CASE WHEN recall_campaign_id IS NOT NULL THEN 1 END)
      comment: "Count of credits related to recall campaigns - safety and compliance cost"
$$;


CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`billing_dispute`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Billing dispute metrics tracking customer satisfaction, billing quality, and resolution effectiveness"
  source: "`vibe_automotive_v1`.`billing`.`dispute`"
  dimensions:
    - name: "dispute_status"
      expr: dispute_status
      comment: "Current status of the dispute (open, in review, resolved, escalated)"
    - name: "dispute_type"
      expr: dispute_type
      comment: "Type of dispute (pricing, quantity, quality, delivery, etc.)"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category for systemic issue identification"
    - name: "resolution_type"
      expr: resolution_type
      comment: "How the dispute was resolved (credit, adjustment, rejected, etc.)"
    - name: "escalation_level"
      expr: escalation_level
      comment: "Level of escalation (L1, L2, executive, legal)"
    - name: "priority"
      expr: priority
      comment: "Priority level of the dispute"
    - name: "business_unit"
      expr: business_unit
      comment: "Business unit responsible for resolution"
    - name: "region_code"
      expr: region_code
      comment: "Geographic region for regional quality analysis"
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Whether dispute resolution breached SLA"
  measures:
    - name: "Total Disputes"
      expr: COUNT(1)
      comment: "Total number of billing disputes raised - customer satisfaction indicator"
    - name: "Total Disputed Amount"
      expr: SUM(CAST(disputed_amount AS DOUBLE))
      comment: "Total dollar value under dispute - revenue at risk"
    - name: "Total Credited Amount"
      expr: SUM(CAST(credited_amount AS DOUBLE))
      comment: "Total amount credited to resolve disputes - cost of quality issues"
    - name: "Avg Disputed Amount"
      expr: AVG(CAST(disputed_amount AS DOUBLE))
      comment: "Average dispute value - indicator of issue materiality"
    - name: "Open Disputes"
      expr: COUNT(CASE WHEN dispute_status IN ('open', 'in review', 'escalated') THEN 1 END)
      comment: "Count of unresolved disputes - current backlog"
    - name: "Resolved Disputes"
      expr: COUNT(CASE WHEN resolution_date IS NOT NULL THEN 1 END)
      comment: "Count of resolved disputes"
    - name: "Escalated Disputes"
      expr: COUNT(CASE WHEN escalation_date IS NOT NULL THEN 1 END)
      comment: "Count of disputes requiring escalation - complexity indicator"
    - name: "SLA Breached Disputes"
      expr: COUNT(CASE WHEN sla_breach_flag = TRUE THEN 1 END)
      comment: "Count of disputes that breached resolution SLA - service quality indicator"
    - name: "Resolution Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN resolution_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of disputes resolved - resolution effectiveness"
    - name: "Escalation Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN escalation_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of disputes requiring escalation - first-contact resolution effectiveness"
    - name: "SLA Breach Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sla_breach_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of disputes breaching SLA - service level performance"
    - name: "Credit Recovery Rate Pct"
      expr: ROUND(100.0 * SUM(CAST(credited_amount AS DOUBLE)) / NULLIF(SUM(CAST(disputed_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of disputed amount ultimately credited - dispute validity indicator"
    - name: "Unique Disputing Parties"
      expr: COUNT(DISTINCT party_id)
      comment: "Count of distinct parties raising disputes - breadth of dissatisfaction"
$$;


CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`billing_rebate_accrual`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rebate accrual metrics tracking incentive program costs and dealer performance against volume targets"
  source: "`vibe_automotive_v1`.`billing`.`rebate_accrual`"
  dimensions:
    - name: "accrual_status"
      expr: accrual_status
      comment: "Status of the accrual (draft, posted, settled, reversed)"
    - name: "accrual_basis"
      expr: accrual_basis
      comment: "Basis for accrual calculation (volume, revenue, margin, etc.)"
    - name: "rebate_rate_type"
      expr: rebate_rate_type
      comment: "Type of rebate rate (flat, tiered, percentage, etc.)"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for period analysis"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for trend analysis"
    - name: "accrual_month"
      expr: DATE_TRUNC('MONTH', accrual_period_start_date)
      comment: "Accrual period start truncated to month"
    - name: "sales_region_code"
      expr: sales_region_code
      comment: "Sales region for geographic program analysis"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the accrual"
    - name: "settlement_status"
      expr: CASE WHEN settlement_date IS NOT NULL THEN 'Settled' ELSE 'Unsettled' END
      comment: "Whether accrual has been settled with payment"
  measures:
    - name: "Total Accruals"
      expr: COUNT(1)
      comment: "Total number of rebate accrual records"
    - name: "Total Accrued Amount"
      expr: SUM(CAST(accrued_amount AS DOUBLE))
      comment: "Total rebate amount accrued - incentive program cost"
    - name: "Total Accrued Units"
      expr: SUM(CAST(accrued_units AS DOUBLE))
      comment: "Total units qualifying for rebates"
    - name: "Total Cumulative Accrued Amount"
      expr: SUM(CAST(cumulative_accrued_amount AS DOUBLE))
      comment: "Total cumulative accrued amounts across all periods"
    - name: "Avg Accrued Amount"
      expr: AVG(CAST(accrued_amount AS DOUBLE))
      comment: "Average accrual amount per record"
    - name: "Avg Rebate Rate"
      expr: AVG(CAST(rebate_rate AS DOUBLE))
      comment: "Average rebate rate across accruals"
    - name: "Settled Accruals"
      expr: COUNT(CASE WHEN settlement_date IS NOT NULL THEN 1 END)
      comment: "Count of accruals settled with payment"
    - name: "Unsettled Accruals"
      expr: COUNT(CASE WHEN settlement_date IS NULL THEN 1 END)
      comment: "Count of accruals not yet settled - outstanding liability"
    - name: "Reversed Accruals"
      expr: COUNT(CASE WHEN reversal_date IS NOT NULL THEN 1 END)
      comment: "Count of accruals reversed - adjustment indicator"
    - name: "Settlement Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN settlement_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of accruals settled - payment processing efficiency"
    - name: "Unique Beneficiaries"
      expr: COUNT(DISTINCT rebate_party_id)
      comment: "Count of distinct parties receiving rebates - program participation breadth"
    - name: "Unique Agreements"
      expr: COUNT(DISTINCT rebate_agreement_id)
      comment: "Count of distinct rebate agreements active"
$$;


CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`billing_dealer_statement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dealer statement metrics tracking dealer account health, payment performance, and multi-revenue stream consolidation"
  source: "`vibe_automotive_v1`.`billing`.`dealer_statement`"
  dimensions:
    - name: "statement_status"
      expr: statement_status
      comment: "Status of the dealer statement (draft, issued, paid, disputed)"
    - name: "statement_type"
      expr: statement_type
      comment: "Type of statement (monthly, quarterly, ad-hoc, etc.)"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for period analysis"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for trend analysis"
    - name: "statement_month"
      expr: DATE_TRUNC('MONTH', statement_date)
      comment: "Statement date truncated to month"
    - name: "sales_organization_code"
      expr: sales_organization_code
      comment: "Sales organization for organizational analysis"
    - name: "billing_cycle_code"
      expr: billing_cycle_code
      comment: "Billing cycle for the statement"
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Whether statement is under dispute"
    - name: "floorplan_financing_flag"
      expr: floorplan_financing_flag
      comment: "Whether dealer uses floorplan financing"
  measures:
    - name: "Total Statements"
      expr: COUNT(1)
      comment: "Total number of dealer statements issued"
    - name: "Total Closing Balance"
      expr: SUM(CAST(closing_balance_amount AS DOUBLE))
      comment: "Total closing balance across all dealer statements - total dealer AR"
    - name: "Total Opening Balance"
      expr: SUM(CAST(opening_balance_amount AS DOUBLE))
      comment: "Total opening balance for the period"
    - name: "Total Vehicle Sales"
      expr: SUM(CAST(total_vehicle_sales_amount AS DOUBLE))
      comment: "Total vehicle sales billed to dealers"
    - name: "Total Parts Sales"
      expr: SUM(CAST(total_parts_sales_amount AS DOUBLE))
      comment: "Total parts sales to dealers"
    - name: "Total Service Charges"
      expr: SUM(CAST(total_service_charges_amount AS DOUBLE))
      comment: "Total service charges billed"
    - name: "Total Warranty Reimbursement"
      expr: SUM(CAST(total_warranty_reimbursement_amount AS DOUBLE))
      comment: "Total warranty reimbursements paid to dealers"
    - name: "Total Incentive Amount"
      expr: SUM(CAST(total_incentive_amount AS DOUBLE))
      comment: "Total incentives paid to dealers"
    - name: "Total Payments Received"
      expr: SUM(CAST(total_payment_received_amount AS DOUBLE))
      comment: "Total payments received from dealers - cash collection"
    - name: "Total Adjustments"
      expr: SUM(CAST(total_adjustment_amount AS DOUBLE))
      comment: "Total adjustments (credits and debits)"
    - name: "Total Dispute Amount"
      expr: SUM(CAST(dispute_amount AS DOUBLE))
      comment: "Total amount under dispute"
    - name: "Avg Closing Balance"
      expr: AVG(CAST(closing_balance_amount AS DOUBLE))
      comment: "Average dealer closing balance - typical dealer AR exposure"
    - name: "Disputed Statements"
      expr: COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END)
      comment: "Count of statements under dispute - dealer satisfaction indicator"
    - name: "Dispute Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of statements disputed - billing quality and dealer relationship health"
    - name: "Unique Dealers"
      expr: COUNT(DISTINCT dealership_id)
      comment: "Count of distinct dealers with statements - active dealer network size"
$$;
