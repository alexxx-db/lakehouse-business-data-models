-- Metric views for domain: finance | Business: Consumer_Goods | Version: 2 | Generated on: 2026-06-27 07:41:37

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`finance_ap_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts Payable invoice metrics covering invoice liability, payment performance, discount capture, and aging. Used by AP teams and CFOs to manage vendor payment obligations, cash outflow, and working capital."
  source: "`vibe_consumer_goods_v1`.`finance`.`ap_invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the AP invoice (e.g. Open, Paid, Blocked) for filtering and segmentation."
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of the invoice (e.g. Pending, Cleared, Overdue) to track payment lifecycle."
    - name: "payment_method"
      expr: payment_method
      comment: "Method used for payment (e.g. ACH, Wire, Check) to analyze payment channel mix."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency of the invoice for multi-currency analysis."
    - name: "invoice_category"
      expr: invoice_category
      comment: "Category of the invoice (e.g. Goods, Services) to segment AP spend by type."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the invoice for period-over-period financial reporting."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period (month/quarter) of the invoice for sub-annual trend analysis."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Contractual payment terms (e.g. Net 30, Net 60) to analyze compliance and cash flow planning."
    - name: "invoice_date_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Invoice date truncated to month for time-series trending of AP volumes."
    - name: "due_date_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Due date truncated to month for cash outflow forecasting."
    - name: "posting_date_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Posting date truncated to month for GL period alignment."
    - name: "tax_code"
      expr: tax_code
      comment: "Tax code applied to the invoice for tax liability analysis."
    - name: "match_status"
      expr: match_status
      comment: "Three-way match status (e.g. Matched, Unmatched) to identify invoice processing exceptions."
    - name: "payment_block_code"
      expr: payment_block_code
      comment: "Code indicating why a payment is blocked, used to identify and resolve payment holds."
  measures:
    - name: "total_invoice_count"
      expr: COUNT(1)
      comment: "Total number of AP invoices. Baseline volume metric for AP workload and vendor activity tracking."
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross invoice amount representing total AP liability before discounts and taxes. Key cash outflow indicator."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net invoice amount after discounts. Reflects actual AP obligation for cash flow planning."
    - name: "total_outstanding_amount"
      expr: SUM(CAST(outstanding_amount AS DOUBLE))
      comment: "Total outstanding (unpaid) AP balance. Critical for working capital management and cash flow forecasting."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across AP invoices for tax liability reporting and compliance."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount available on AP invoices. Measures potential savings from early payment terms."
    - name: "total_early_payment_discount_taken"
      expr: SUM(CAST(early_payment_discount_taken AS DOUBLE))
      comment: "Total early payment discounts actually captured. Directly measures savings realized from prompt payment."
    - name: "total_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total amount paid against AP invoices. Measures actual cash outflow to vendors."
    - name: "total_withholding_tax_amount"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax deducted from vendor payments. Required for tax compliance reporting."
    - name: "avg_invoice_amount"
      expr: AVG(CAST(gross_amount AS DOUBLE))
      comment: "Average gross invoice amount per AP invoice. Indicates typical transaction size for vendor spend benchmarking."
    - name: "blocked_invoice_count"
      expr: COUNT(CASE WHEN payment_block_code IS NOT NULL AND payment_block_code <> '' THEN 1 END)
      comment: "Number of invoices with a payment block. High counts signal AP processing bottlenecks or compliance issues requiring intervention."
    - name: "unmatched_invoice_count"
      expr: COUNT(CASE WHEN match_status <> 'Matched' THEN 1 END)
      comment: "Number of invoices that have not achieved three-way match. Drives exception resolution workload and payment delay risk."
    - name: "distinct_supplier_count"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of distinct suppliers with AP invoices. Measures vendor base breadth and concentration risk."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`finance_ap_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts Payable payment execution metrics covering payment volumes, discount capture, on-time payment performance, and cash outflow. Used by treasury and AP leadership to optimize payment runs and working capital."
  source: "`vibe_consumer_goods_v1`.`finance`.`ap_payment`"
  dimensions:
    - name: "ap_payment_status"
      expr: ap_payment_status
      comment: "Current status of the AP payment (e.g. Cleared, Pending, Reversed) for payment lifecycle tracking."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used (e.g. ACH, Wire, Check) to analyze channel mix and associated costs."
    - name: "payment_approval_status"
      expr: payment_approval_status
      comment: "Approval status of the payment to track authorization workflow compliance."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for multi-currency payment analysis."
    - name: "local_currency_code"
      expr: local_currency_code
      comment: "Local currency code for functional currency reporting."
    - name: "payment_date_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Payment date truncated to month for cash outflow trend analysis."
    - name: "clearing_date_month"
      expr: DATE_TRUNC('MONTH', clearing_date)
      comment: "Clearing date truncated to month for bank reconciliation and cash position reporting."
    - name: "payment_block_code"
      expr: payment_block_code
      comment: "Code indicating payment block reason to identify and resolve payment holds."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms associated with the payment for DPO and compliance analysis."
    - name: "remittance_advice_sent_flag"
      expr: CAST(remittance_advice_sent_flag AS STRING)
      comment: "Whether remittance advice was sent to the supplier, indicating payment communication compliance."
  measures:
    - name: "total_payment_count"
      expr: COUNT(1)
      comment: "Total number of AP payments processed. Baseline volume metric for payment run efficiency."
    - name: "total_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total gross payment amount disbursed to vendors. Primary cash outflow KPI for treasury management."
    - name: "total_net_payment_amount"
      expr: SUM(CAST(net_payment_amount AS DOUBLE))
      comment: "Total net payment amount after discounts. Reflects actual cash disbursed for working capital reporting."
    - name: "total_local_currency_amount"
      expr: SUM(CAST(local_currency_amount AS DOUBLE))
      comment: "Total payment amount in local/functional currency for consolidated financial reporting."
    - name: "total_discount_amount_captured"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early payment discounts captured on AP payments. Directly measures savings from prompt payment execution."
    - name: "avg_payment_amount"
      expr: AVG(CAST(payment_amount AS DOUBLE))
      comment: "Average payment amount per transaction. Benchmarks typical payment size for anomaly detection."
    - name: "blocked_payment_count"
      expr: COUNT(CASE WHEN payment_block_code IS NOT NULL AND payment_block_code <> '' THEN 1 END)
      comment: "Number of payments currently blocked. High counts indicate AP processing issues requiring management intervention."
    - name: "reversed_payment_count"
      expr: COUNT(CASE WHEN ap_payment_status = 'Reversed' THEN 1 END)
      comment: "Number of reversed payments. Elevated reversals signal payment errors, fraud risk, or vendor disputes."
    - name: "distinct_supplier_count"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of distinct suppliers paid. Measures vendor payment breadth and concentration."
    - name: "remittance_advice_sent_count"
      expr: COUNT(CASE WHEN remittance_advice_sent_flag = TRUE THEN 1 END)
      comment: "Number of payments where remittance advice was sent. Measures supplier communication compliance."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`finance_ar_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts Receivable invoice metrics covering revenue recognition, collections performance, DSO aging, dispute management, and write-off risk. Used by AR leadership, CFOs, and credit managers to optimize cash collection and reduce bad debt."
  source: "`vibe_consumer_goods_v1`.`finance`.`ar_invoice`"
  dimensions:
    - name: "ar_invoice_status"
      expr: ar_invoice_status
      comment: "Current status of the AR invoice (e.g. Open, Paid, Disputed) for collections lifecycle tracking."
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of the AR invoice to segment paid vs. outstanding receivables."
    - name: "invoice_status"
      expr: invoice_status
      comment: "Billing document status for AR invoice processing workflow tracking."
    - name: "currency_code"
      expr: currency_code
      comment: "Invoice currency for multi-currency AR analysis."
    - name: "billing_document_type"
      expr: billing_document_type
      comment: "Type of billing document (e.g. Invoice, Credit Memo, Debit Memo) for AR portfolio composition analysis."
    - name: "dso_aging_bucket"
      expr: dso_aging_bucket
      comment: "DSO aging bucket (e.g. 0-30, 31-60, 61-90, 90+ days) for receivables aging analysis and collections prioritization."
    - name: "dunning_level"
      expr: dunning_level
      comment: "Dunning level indicating escalation stage of collections activity for overdue invoices."
    - name: "dispute_flag"
      expr: CAST(dispute_flag AS STRING)
      comment: "Whether the invoice is under dispute. Disputed invoices require resolution before collection."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method for the AR invoice to analyze collection channel mix."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms (e.g. Net 30) for credit policy compliance and DSO benchmarking."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for period-over-period AR performance reporting."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for sub-annual AR trend analysis."
    - name: "invoice_date_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Invoice date truncated to month for revenue and AR volume trending."
    - name: "due_date_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Due date truncated to month for cash inflow forecasting."
    - name: "sales_organization"
      expr: sales_organization
      comment: "Sales organization responsible for the invoice for regional/channel AR performance analysis."
    - name: "distribution_channel"
      expr: distribution_channel
      comment: "Distribution channel associated with the invoice for channel-level AR analysis."
  measures:
    - name: "total_ar_invoice_count"
      expr: COUNT(1)
      comment: "Total number of AR invoices. Baseline volume metric for billing activity and AR workload."
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross billed amount. Represents total revenue billed to customers before adjustments."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net billed amount after trade discounts. Reflects recognized revenue obligation."
    - name: "total_outstanding_amount"
      expr: SUM(CAST(outstanding_amount AS DOUBLE))
      comment: "Total outstanding AR balance. Primary KPI for collections management and cash flow forecasting."
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total outstanding balance on AR invoices. Used for balance sheet AR reporting and aging analysis."
    - name: "total_amount_received"
      expr: SUM(CAST(amount_received AS DOUBLE))
      comment: "Total cash collected against AR invoices. Measures collections effectiveness and cash inflow."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount billed on AR invoices for tax liability and compliance reporting."
    - name: "total_trade_discount_amount"
      expr: SUM(CAST(trade_discount_amount AS DOUBLE))
      comment: "Total trade discounts granted to customers. Measures revenue leakage from promotional and contractual discounts."
    - name: "total_deduction_amount"
      expr: SUM(CAST(deduction_amount AS DOUBLE))
      comment: "Total customer deductions taken against AR invoices. High deductions indicate trade spend leakage or dispute risk."
    - name: "total_write_off_amount"
      expr: SUM(CAST(write_off_amount AS DOUBLE))
      comment: "Total amount written off as uncollectible. Critical bad debt KPI for credit risk management."
    - name: "disputed_invoice_count"
      expr: COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END)
      comment: "Number of invoices under dispute. Elevated counts signal customer satisfaction or billing accuracy issues."
    - name: "disputed_invoice_amount"
      expr: SUM(CASE WHEN dispute_flag = TRUE THEN CAST(outstanding_amount AS DOUBLE) ELSE 0 END)
      comment: "Total outstanding amount on disputed invoices. Quantifies revenue at risk from unresolved disputes."
    - name: "avg_invoice_amount"
      expr: AVG(CAST(gross_amount AS DOUBLE))
      comment: "Average gross invoice amount per AR invoice. Benchmarks typical transaction size for customer credit analysis."
    - name: "distinct_customer_count"
      expr: COUNT(DISTINCT trade_account_id)
      comment: "Number of distinct customers with AR invoices. Measures customer billing breadth and concentration risk."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`finance_ar_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts Receivable payment receipt metrics covering cash collection performance, deduction management, payment reversals, and short payment analysis. Used by AR and treasury teams to optimize cash application and reduce collection risk."
  source: "`vibe_consumer_goods_v1`.`finance`.`ar_payment`"
  dimensions:
    - name: "ar_payment_status"
      expr: ar_payment_status
      comment: "Current status of the AR payment (e.g. Applied, Unapplied, Reversed) for cash application tracking."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used by the customer (e.g. ACH, Check, Wire) for collection channel analysis."
    - name: "payment_channel"
      expr: payment_channel
      comment: "Channel through which payment was received for digital vs. manual collection analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for multi-currency AR payment analysis."
    - name: "local_currency_code"
      expr: local_currency_code
      comment: "Local/functional currency for consolidated financial reporting."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the payment for period-over-period cash collection reporting."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for sub-annual cash collection trend analysis."
    - name: "payment_date_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Payment date truncated to month for cash inflow trend analysis."
    - name: "posting_date_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Posting date truncated to month for GL period alignment."
    - name: "deduction_reason_code"
      expr: deduction_reason_code
      comment: "Reason code for customer deductions to identify root causes of revenue leakage."
    - name: "reversal_flag"
      expr: CAST(reversal_flag AS STRING)
      comment: "Whether the payment was reversed. Reversals indicate payment errors or fraud requiring investigation."
    - name: "short_payment_flag"
      expr: CAST(short_payment_flag AS STRING)
      comment: "Whether the customer paid less than the invoiced amount. Short payments drive collections follow-up."
    - name: "overpayment_flag"
      expr: CAST(overpayment_flag AS STRING)
      comment: "Whether the customer overpaid. Overpayments require credit memo or refund processing."
  measures:
    - name: "total_payment_count"
      expr: COUNT(1)
      comment: "Total number of AR payments received. Baseline volume metric for cash application workload."
    - name: "total_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total cash received from customers. Primary cash inflow KPI for treasury and AR management."
    - name: "total_applied_amount"
      expr: SUM(CAST(applied_amount AS DOUBLE))
      comment: "Total amount applied to AR invoices. Measures cash application efficiency and unapplied cash risk."
    - name: "total_local_currency_amount"
      expr: SUM(CAST(local_currency_amount AS DOUBLE))
      comment: "Total payment amount in local/functional currency for consolidated financial reporting."
    - name: "total_deduction_amount"
      expr: SUM(CAST(deduction_amount AS DOUBLE))
      comment: "Total customer deductions taken at payment. Measures trade spend leakage and deduction management effectiveness."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early payment discounts taken by customers. Measures cost of early payment incentive programs."
    - name: "reversed_payment_count"
      expr: COUNT(CASE WHEN reversal_flag = TRUE THEN 1 END)
      comment: "Number of reversed AR payments. Elevated reversals signal payment fraud, errors, or NSF checks."
    - name: "short_payment_count"
      expr: COUNT(CASE WHEN short_payment_flag = TRUE THEN 1 END)
      comment: "Number of short payments received. Drives collections follow-up and dispute resolution workload."
    - name: "overpayment_count"
      expr: COUNT(CASE WHEN overpayment_flag = TRUE THEN 1 END)
      comment: "Number of overpayments received. Requires credit memo or refund processing to resolve."
    - name: "avg_payment_amount"
      expr: AVG(CAST(payment_amount AS DOUBLE))
      comment: "Average AR payment amount per transaction. Benchmarks typical customer payment size for anomaly detection."
    - name: "distinct_customer_count"
      expr: COUNT(DISTINCT trade_account_id)
      comment: "Number of distinct customers making payments. Measures active paying customer base."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`finance_journal_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "General ledger journal entry metrics covering posting volumes, debit/credit balances, reversal rates, and intercompany activity. Used by controllers and CFOs to monitor GL integrity, period-close quality, and financial reporting accuracy."
  source: "`vibe_consumer_goods_v1`.`finance`.`journal_entry`"
  dimensions:
    - name: "journal_entry_status"
      expr: journal_entry_status
      comment: "Status of the journal entry (e.g. Posted, Reversed, Parked) for GL integrity monitoring."
    - name: "posting_status"
      expr: posting_status
      comment: "Posting status of the journal entry for period-close completeness tracking."
    - name: "document_type"
      expr: document_type
      comment: "Document type of the journal entry (e.g. SA, KR, DR) for transaction classification."
    - name: "entry_type"
      expr: entry_type
      comment: "Type of journal entry (e.g. Manual, Automatic, Recurring) for control and audit analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for multi-currency GL analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for period-over-period GL volume and balance reporting."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for sub-annual GL trend and period-close analysis."
    - name: "posting_date_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Posting date truncated to month for GL activity trending."
    - name: "intercompany_indicator"
      expr: CAST(intercompany_indicator AS STRING)
      comment: "Whether the journal entry is an intercompany transaction for elimination and consolidation analysis."
    - name: "reversal_flag"
      expr: CAST(reversal_flag AS STRING)
      comment: "Whether the journal entry has been reversed. High reversal rates signal posting errors or control weaknesses."
    - name: "sox_control_flag"
      expr: CAST(sox_control_flag AS STRING)
      comment: "Whether the journal entry is subject to SOX controls for compliance monitoring."
    - name: "transaction_code"
      expr: transaction_code
      comment: "SAP transaction code used to create the entry for process and control analysis."
  measures:
    - name: "total_journal_entry_count"
      expr: COUNT(1)
      comment: "Total number of journal entries posted. Baseline volume metric for GL activity and period-close workload."
    - name: "total_debit_amount"
      expr: SUM(CAST(total_debit_amount AS DOUBLE))
      comment: "Total debit amount across journal entries. Used for GL balance verification and financial statement integrity."
    - name: "total_credit_amount"
      expr: SUM(CAST(total_credit_amount AS DOUBLE))
      comment: "Total credit amount across journal entries. Used alongside total debits to verify GL balance."
    - name: "total_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total transaction amount across journal entries for aggregate GL activity measurement."
    - name: "reversed_entry_count"
      expr: COUNT(CASE WHEN reversal_flag = TRUE THEN 1 END)
      comment: "Number of reversed journal entries. Elevated reversals indicate posting errors or control weaknesses requiring investigation."
    - name: "intercompany_entry_count"
      expr: COUNT(CASE WHEN intercompany_indicator = TRUE THEN 1 END)
      comment: "Number of intercompany journal entries. Used for intercompany elimination and consolidation completeness."
    - name: "sox_controlled_entry_count"
      expr: COUNT(CASE WHEN sox_control_flag = TRUE THEN 1 END)
      comment: "Number of journal entries subject to SOX controls. Measures SOX compliance coverage in the GL."
    - name: "avg_entry_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average transaction amount per journal entry. Used for anomaly detection and unusual entry identification."
    - name: "distinct_gl_account_count"
      expr: COUNT(DISTINCT gl_account_id)
      comment: "Number of distinct GL accounts posted to. Measures GL account utilization and chart of accounts coverage."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`finance_journal_entry_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Journal entry line-item metrics providing granular GL posting analysis including debit/credit splits, tax amounts, and line-level transaction details. Used by controllers and auditors for detailed GL review and SOX testing."
  source: "`vibe_consumer_goods_v1`.`finance`.`journal_entry_line`"
  dimensions:
    - name: "journal_entry_line_status"
      expr: journal_entry_line_status
      comment: "Status of the journal entry line item for GL line-level processing tracking."
    - name: "debit_credit_indicator"
      expr: debit_credit_indicator
      comment: "Debit or credit indicator (D/C) for GL balance analysis and financial statement preparation."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency of the line item for multi-currency GL analysis."
    - name: "company_code_currency_code"
      expr: company_code_currency_code
      comment: "Company code (functional) currency for local GAAP reporting."
    - name: "transaction_currency_code"
      expr: transaction_currency_code
      comment: "Original transaction currency for foreign currency analysis."
    - name: "posting_key"
      expr: posting_key
      comment: "GL posting key determining debit/credit and account type for transaction classification."
    - name: "tax_code"
      expr: tax_code
      comment: "Tax code applied to the line item for tax reporting and compliance."
    - name: "reversal_indicator"
      expr: CAST(reversal_indicator AS STRING)
      comment: "Whether the line item is a reversal entry for GL correction and audit trail analysis."
    - name: "functional_area_code"
      expr: functional_area_code
      comment: "Functional area (e.g. Sales, Manufacturing, Admin) for cost-of-sales and segment reporting."
    - name: "business_area_code"
      expr: business_area_code
      comment: "Business area for segment-level financial reporting."
    - name: "value_date_month"
      expr: DATE_TRUNC('MONTH', value_date)
      comment: "Value date truncated to month for cash flow and liquidity analysis."
    - name: "due_date_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Due date truncated to month for open item aging analysis."
  measures:
    - name: "total_line_count"
      expr: COUNT(1)
      comment: "Total number of journal entry line items. Baseline volume metric for GL posting activity and audit scope."
    - name: "total_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total amount across all journal entry lines. Aggregate GL posting value for financial statement analysis."
    - name: "total_amount_company_code_currency"
      expr: SUM(CAST(amount_company_code_currency AS DOUBLE))
      comment: "Total amount in company code (functional) currency for local GAAP financial reporting."
    - name: "total_amount_group_currency"
      expr: SUM(CAST(amount_group_currency AS DOUBLE))
      comment: "Total amount in group currency for consolidated financial reporting and intercompany elimination."
    - name: "total_amount_transaction_currency"
      expr: SUM(CAST(amount_transaction_currency AS DOUBLE))
      comment: "Total amount in original transaction currency for foreign currency exposure analysis."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on journal entry lines for tax liability and compliance reporting."
    - name: "total_local_amount"
      expr: SUM(CAST(local_amount AS DOUBLE))
      comment: "Total local currency amount for domestic financial reporting."
    - name: "reversal_line_count"
      expr: COUNT(CASE WHEN reversal_indicator = TRUE THEN 1 END)
      comment: "Number of reversal line items. Measures GL correction activity and potential control weaknesses."
    - name: "avg_line_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average amount per journal entry line. Used for anomaly detection and unusual posting identification."
    - name: "distinct_gl_account_count"
      expr: COUNT(DISTINCT gl_account_id)
      comment: "Number of distinct GL accounts posted to at line level. Measures chart of accounts utilization."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`finance_standard_cost`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Standard cost metrics covering product cost composition, cost variance analysis, and cost structure benchmarking. Used by cost accountants, supply chain finance, and operations leadership to manage product profitability and manufacturing efficiency."
  source: "`vibe_consumer_goods_v1`.`finance`.`standard_cost`"
  dimensions:
    - name: "standard_cost_status"
      expr: standard_cost_status
      comment: "Status of the standard cost record (e.g. Active, Released, Obsolete) for cost version management."
    - name: "release_status"
      expr: release_status
      comment: "Release status of the cost estimate for cost rollout and activation tracking."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the standard cost for governance and authorization workflow tracking."
    - name: "costing_type"
      expr: costing_type
      comment: "Type of costing method (e.g. Standard, Moving Average) for cost methodology analysis."
    - name: "costing_version"
      expr: costing_version
      comment: "Version of the cost estimate for cost comparison across planning cycles."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the standard cost for multi-currency cost analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the standard cost for annual cost planning and variance reporting."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for sub-annual cost trend analysis."
    - name: "valid_from_date_month"
      expr: DATE_TRUNC('MONTH', valid_from_date)
      comment: "Effective start date truncated to month for cost validity period analysis."
    - name: "valuation_variant"
      expr: valuation_variant
      comment: "Valuation variant used in cost estimation for costing methodology classification."
    - name: "costing_sheet"
      expr: costing_sheet
      comment: "Costing sheet applied for overhead calculation methodology analysis."
  measures:
    - name: "total_standard_cost"
      expr: SUM(CAST(total_standard_cost AS DOUBLE))
      comment: "Total standard cost across all cost records. Primary cost base KPI for product cost management."
    - name: "total_material_cost"
      expr: SUM(CAST(material_cost AS DOUBLE))
      comment: "Total material cost component. Measures raw material spend contribution to product cost."
    - name: "total_raw_material_cost"
      expr: SUM(CAST(raw_material_cost AS DOUBLE))
      comment: "Total raw material cost. Key input for procurement cost management and make-vs-buy decisions."
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost AS DOUBLE))
      comment: "Total labor cost component. Measures workforce cost contribution to product cost for efficiency analysis."
    - name: "total_direct_labor_cost"
      expr: SUM(CAST(direct_labor_cost AS DOUBLE))
      comment: "Total direct labor cost. Directly tied to manufacturing efficiency and labor productivity KPIs."
    - name: "total_overhead_cost"
      expr: SUM(CAST(overhead_cost AS DOUBLE))
      comment: "Total overhead cost component. Measures fixed and variable overhead absorption for cost structure analysis."
    - name: "total_fixed_overhead_cost"
      expr: SUM(CAST(fixed_overhead_cost AS DOUBLE))
      comment: "Total fixed overhead cost. Used for break-even analysis and capacity utilization costing."
    - name: "total_variable_overhead_cost"
      expr: SUM(CAST(variable_overhead_cost AS DOUBLE))
      comment: "Total variable overhead cost. Measures volume-driven overhead for marginal cost analysis."
    - name: "total_packaging_material_cost"
      expr: SUM(CAST(packaging_material_cost AS DOUBLE))
      comment: "Total packaging material cost. Important for consumer goods where packaging is a significant cost driver."
    - name: "total_freight_in_cost"
      expr: SUM(CAST(freight_in_cost AS DOUBLE))
      comment: "Total inbound freight cost. Measures logistics cost contribution to product cost for supply chain optimization."
    - name: "total_cost_variance_amount"
      expr: SUM(CAST(cost_variance_amount AS DOUBLE))
      comment: "Total cost variance (actual vs. standard). Negative variances indicate cost overruns requiring management action."
    - name: "avg_cost_variance_percentage"
      expr: AVG(CAST(cost_variance_percentage AS DOUBLE))
      comment: "Average cost variance percentage across products. Measures overall standard cost accuracy and manufacturing efficiency."
    - name: "avg_total_standard_cost"
      expr: AVG(CAST(total_standard_cost AS DOUBLE))
      comment: "Average standard cost per SKU/record. Benchmarks typical product cost for portfolio pricing and margin analysis."
    - name: "distinct_sku_count"
      expr: COUNT(DISTINCT primary_standard_sku_id)
      comment: "Number of distinct SKUs with standard costs. Measures cost coverage across the product portfolio."
$$;