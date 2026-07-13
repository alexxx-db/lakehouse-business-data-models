-- Metric views for domain: finance | Business: Retail | Version: 2 | Generated on: 2026-07-12 14:06:09

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`finance_ap_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts payable invoice metrics tracking payable volumes, aging, discount capture, tax liability, and three-way match quality to support cash management and procurement efficiency decisions."
  source: "`vibe_retail_v1`.`finance`.`ap_invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current lifecycle status of the AP invoice (e.g. open, cleared, disputed, blocked) for aging and workflow analysis."
    - name: "invoice_type"
      expr: invoice_type
      comment: "Classification of the invoice type (e.g. standard, credit memo, recurring) for payable mix analysis."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used or designated for settlement (e.g. ACH, wire, check) for treasury planning."
    - name: "payment_terms_code"
      expr: payment_terms_code
      comment: "Vendor payment terms code (e.g. Net30, 2/10Net30) for discount capture and cash flow forecasting."
    - name: "three_way_match_status"
      expr: three_way_match_status
      comment: "Status of the three-way match between purchase order, goods receipt, and invoice for procurement control."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency of the invoice for multi-currency payables reporting."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the invoice for period-over-period payables analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the invoice for monthly payables close reporting."
    - name: "invoice_date"
      expr: DATE_TRUNC('month', invoice_date)
      comment: "Invoice date truncated to month for trend analysis of payable volumes."
    - name: "due_date_month"
      expr: DATE_TRUNC('month', due_date)
      comment: "Invoice due date truncated to month for cash outflow forecasting."
    - name: "is_recurring"
      expr: is_recurring
      comment: "Flag indicating whether the invoice is part of a recurring payable schedule."
    - name: "is_edi_received"
      expr: is_edi_received
      comment: "Flag indicating whether the invoice was received via electronic data interchange for automation rate tracking."
    - name: "dispute_reason"
      expr: dispute_reason
      comment: "Reason code for disputed invoices to identify systemic procurement or receiving issues."
  measures:
    - name: "total_gross_payable_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross amount of AP invoices. Core payables volume KPI used in cash flow planning and period-end close."
    - name: "total_net_payable_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net payable amount after discounts and adjustments. Used for actual cash outflow forecasting."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax liability on AP invoices. Used for tax accrual and compliance reporting."
    - name: "total_discount_captured_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early-payment discounts captured. Measures procurement efficiency and working capital optimization."
    - name: "total_chargeback_amount"
      expr: SUM(CAST(chargeback_amount AS DOUBLE))
      comment: "Total chargeback amounts applied against vendors. Indicates vendor compliance issues and recovery performance."
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Total number of AP invoices processed. Baseline volume metric for payables throughput and workload analysis."
    - name: "disputed_invoice_count"
      expr: COUNT(CASE WHEN dispute_reason IS NOT NULL AND dispute_reason <> '' THEN 1 END)
      comment: "Number of invoices in dispute. High dispute rates signal vendor or receiving process quality issues requiring intervention."
    - name: "three_way_match_failed_count"
      expr: COUNT(CASE WHEN three_way_match_status = 'failed' THEN 1 END)
      comment: "Number of invoices failing three-way match. Drives procurement audit and vendor management actions."
    - name: "avg_invoice_gross_amount"
      expr: AVG(CAST(gross_amount AS DOUBLE))
      comment: "Average gross invoice amount. Benchmarks invoice size trends and flags anomalous payable concentrations."
    - name: "edi_received_invoice_count"
      expr: COUNT(CASE WHEN is_edi_received = TRUE THEN 1 END)
      comment: "Number of invoices received via electronic data interchange. Tracks automation adoption rate in AP processing."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`finance_ar_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts receivable invoice metrics covering revenue billed, collections performance, write-offs, dispute management, and DSO drivers to support revenue assurance and credit risk decisions."
  source: "`vibe_retail_v1`.`finance`.`ar_invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current lifecycle status of the AR invoice (e.g. open, cleared, written-off, disputed) for collections prioritization."
    - name: "invoice_type"
      expr: invoice_type
      comment: "Classification of the AR invoice type (e.g. standard, credit memo, debit memo) for revenue mix analysis."
    - name: "billing_category"
      expr: billing_category
      comment: "Billing category grouping invoices by revenue stream (e.g. product sales, services, lease) for revenue recognition analysis."
    - name: "revenue_recognition_status"
      expr: revenue_recognition_status
      comment: "Status of revenue recognition for the invoice (e.g. recognized, deferred, pending) for ASC 606 compliance reporting."
    - name: "dispute_status"
      expr: dispute_status
      comment: "Current dispute status of the invoice for collections and credit risk management."
    - name: "dispute_reason_code"
      expr: dispute_reason_code
      comment: "Reason code for disputed AR invoices to identify systemic billing or fulfillment issues."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency of the AR invoice for multi-currency receivables reporting."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the invoice for period-over-period revenue and collections analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the invoice for monthly AR close and revenue reporting."
    - name: "invoice_date_month"
      expr: DATE_TRUNC('month', invoice_date)
      comment: "Invoice date truncated to month for billing volume trend analysis."
    - name: "dunning_level"
      expr: dunning_level
      comment: "Dunning escalation level for overdue invoices to assess collections intensity and credit risk."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method associated with the AR invoice for collections channel analysis."
    - name: "sales_org_code"
      expr: sales_org_code
      comment: "Sales organization code for revenue attribution and regional AR performance analysis."
  measures:
    - name: "total_gross_billed_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross amount billed to customers. Primary revenue volume KPI for AR and revenue assurance."
    - name: "total_net_receivable_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net receivable amount after discounts. Represents expected cash inflow from outstanding invoices."
    - name: "total_open_receivable_amount"
      expr: SUM(CAST(open_amount AS DOUBLE))
      comment: "Total outstanding open receivable balance. Core DSO driver and liquidity risk indicator."
    - name: "total_applied_amount"
      expr: SUM(CAST(applied_amount AS DOUBLE))
      comment: "Total amount applied (collected) against AR invoices. Measures collections effectiveness."
    - name: "total_write_off_amount"
      expr: SUM(CAST(write_off_amount AS DOUBLE))
      comment: "Total amount written off as uncollectable. Key credit risk and bad debt expense KPI for executive review."
    - name: "total_cash_discount_amount"
      expr: SUM(CAST(cash_discount_amount AS DOUBLE))
      comment: "Total cash discounts granted to customers. Measures cost of early-payment incentive programs."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on AR invoices for tax liability and compliance reporting."
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Total number of AR invoices issued. Baseline billing volume metric for workload and revenue cycle analysis."
    - name: "disputed_invoice_count"
      expr: COUNT(CASE WHEN dispute_status IS NOT NULL AND dispute_status <> '' THEN 1 END)
      comment: "Number of invoices in active dispute. High dispute rates signal billing quality or fulfillment issues."
    - name: "written_off_invoice_count"
      expr: COUNT(CASE WHEN write_off_amount > 0 THEN 1 END)
      comment: "Number of invoices with write-off amounts. Tracks bad debt incidence for credit policy review."
    - name: "avg_invoice_gross_amount"
      expr: AVG(CAST(gross_amount AS DOUBLE))
      comment: "Average gross invoice amount. Benchmarks billing size and flags revenue concentration risks."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`finance_journal_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "General ledger journal entry metrics covering posting volumes, reversal rates, accrual activity, and intercompany transaction patterns to support period-end close quality and audit readiness."
  source: "`vibe_retail_v1`.`finance`.`journal_entry`"
  dimensions:
    - name: "document_type"
      expr: document_type
      comment: "Journal entry document type (e.g. standard, accrual, reversal, intercompany) for close process analysis."
    - name: "entry_type"
      expr: entry_type
      comment: "Entry type classification for segregating manual, automated, and system-generated journal entries."
    - name: "posting_status"
      expr: posting_status
      comment: "Current posting status of the journal entry (e.g. posted, parked, rejected) for close completeness tracking."
    - name: "source_module"
      expr: source_module
      comment: "Source system module that generated the journal entry (e.g. AP, AR, payroll) for sub-ledger reconciliation."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the journal entry for year-over-year close volume analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the journal entry for monthly close workload and quality reporting."
    - name: "posting_date_month"
      expr: DATE_TRUNC('month', posting_date)
      comment: "Posting date truncated to month for journal entry volume trend analysis."
    - name: "debit_credit_indicator"
      expr: debit_credit_indicator
      comment: "Debit or credit indicator for balance verification and ledger integrity checks."
    - name: "accrual_indicator"
      expr: accrual_indicator
      comment: "Flag indicating whether the entry is an accrual for accrual volume and reversal tracking."
    - name: "intercompany_indicator"
      expr: intercompany_indicator
      comment: "Flag indicating intercompany journal entries for elimination and reconciliation analysis."
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Flag indicating whether the entry has been reversed for close quality and error rate analysis."
    - name: "document_currency_code"
      expr: document_currency_code
      comment: "Currency of the journal entry document for multi-currency ledger analysis."
  measures:
    - name: "total_document_amount"
      expr: SUM(CAST(document_amount AS DOUBLE))
      comment: "Total absolute document amount across all journal entries. Measures ledger activity volume for period-end close monitoring."
    - name: "total_local_amount"
      expr: SUM(CAST(local_amount AS DOUBLE))
      comment: "Total local currency amount posted to the general ledger. Used for statutory reporting and ledger balance verification."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount posted via journal entries for tax accrual and compliance reconciliation."
    - name: "journal_entry_count"
      expr: COUNT(1)
      comment: "Total number of journal entries posted. Baseline close workload metric; spikes indicate process inefficiency or error correction activity."
    - name: "reversal_entry_count"
      expr: COUNT(CASE WHEN reversal_indicator = TRUE THEN 1 END)
      comment: "Number of reversed journal entries. High reversal rates signal close quality issues and require process investigation."
    - name: "accrual_entry_count"
      expr: COUNT(CASE WHEN accrual_indicator = TRUE THEN 1 END)
      comment: "Number of accrual journal entries. Tracks accrual volume for period-end completeness and reversal planning."
    - name: "intercompany_entry_count"
      expr: COUNT(CASE WHEN intercompany_indicator = TRUE THEN 1 END)
      comment: "Number of intercompany journal entries. Drives intercompany elimination and reconciliation workload planning."
    - name: "manual_entry_count"
      expr: COUNT(CASE WHEN entry_type = 'manual' THEN 1 END)
      comment: "Number of manually entered journal entries. High manual entry rates increase audit risk and are a key SOX control metric."
    - name: "avg_document_amount"
      expr: AVG(CAST(document_amount AS DOUBLE))
      comment: "Average journal entry document amount. Benchmarks typical entry size and flags unusually large or small postings for review."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`finance_journal_entry_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Journal entry line-level metrics for granular ledger analysis including debit/credit balances, tax postings, and line-item volume by account type and cost object to support reconciliation and audit."
  source: "`vibe_retail_v1`.`finance`.`journal_entry_line`"
  dimensions:
    - name: "account_type"
      expr: account_type
      comment: "GL account type (e.g. asset, liability, revenue, expense) for financial statement line analysis."
    - name: "document_type"
      expr: document_type
      comment: "Document type of the parent journal entry for sub-ledger reconciliation."
    - name: "debit_credit_indicator"
      expr: debit_credit_indicator
      comment: "Debit or credit indicator for balance sheet and P&L balance verification."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the journal entry line for year-over-year ledger analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the journal entry line for monthly close and reconciliation reporting."
    - name: "posting_date_month"
      expr: DATE_TRUNC('month', posting_date)
      comment: "Posting date truncated to month for ledger activity trend analysis."
    - name: "local_currency_code"
      expr: local_currency_code
      comment: "Local currency of the journal entry line for statutory reporting."
    - name: "doc_currency_code"
      expr: doc_currency_code
      comment: "Document currency of the journal entry line for multi-currency ledger analysis."
    - name: "is_reversed"
      expr: is_reversed
      comment: "Flag indicating whether the line has been reversed for close quality tracking."
    - name: "tax_code"
      expr: tax_code
      comment: "Tax code applied to the journal entry line for tax reporting and compliance."
    - name: "posting_key"
      expr: posting_key
      comment: "Posting key determining the account type and debit/credit assignment for ledger integrity analysis."
  measures:
    - name: "total_amount_local_currency"
      expr: SUM(CAST(amount_local_currency AS DOUBLE))
      comment: "Total posted amount in local currency. Core ledger balance metric for statutory financial reporting."
    - name: "total_amount_doc_currency"
      expr: SUM(CAST(amount_doc_currency AS DOUBLE))
      comment: "Total posted amount in document currency. Used for multi-currency reconciliation and FX analysis."
    - name: "total_amount_group_currency"
      expr: SUM(CAST(amount_group_currency AS DOUBLE))
      comment: "Total posted amount in group reporting currency. Used for consolidated financial reporting."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on journal entry lines for tax liability reconciliation and compliance reporting."
    - name: "line_count"
      expr: COUNT(1)
      comment: "Total number of journal entry lines. Measures ledger posting granularity and close workload volume."
    - name: "reversed_line_count"
      expr: COUNT(CASE WHEN is_reversed = TRUE THEN 1 END)
      comment: "Number of reversed journal entry lines. Tracks error correction volume as a close quality indicator."
    - name: "avg_line_amount_local_currency"
      expr: AVG(CAST(amount_local_currency AS DOUBLE))
      comment: "Average local currency amount per journal entry line. Benchmarks typical posting size for anomaly detection."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`finance_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Budget planning and variance metrics tracking planned vs actual vs forecast spend, budget utilization, and variance rates by cost center, profit center, and financial period to drive financial planning decisions."
  source: "`vibe_retail_v1`.`finance`.`finance_budget`"
  dimensions:
    - name: "budget_category"
      expr: budget_category
      comment: "Budget category (e.g. capex, opex, headcount, marketing) for spend mix and allocation analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Budget approval status (e.g. draft, submitted, approved, locked) for planning cycle governance."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the budget for annual planning and year-over-year comparison."
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter of the budget for quarterly planning review and reforecast cycles."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the budget for monthly budget vs actual reporting."
    - name: "channel"
      expr: channel
      comment: "Business channel (e.g. store, e-commerce, wholesale) for channel-level budget allocation analysis."
    - name: "plan_version_type"
      expr: plan_version_type
      comment: "Type of plan version (e.g. original budget, reforecast, stretch) for planning scenario comparison."
    - name: "is_locked"
      expr: is_locked
      comment: "Flag indicating whether the budget is locked for changes, used for planning cycle control."
    - name: "is_reforecast"
      expr: is_reforecast
      comment: "Flag indicating whether this is a reforecast version for distinguishing original budget from revised estimates."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the budget for multi-currency planning and consolidation."
    - name: "plan_start_date_month"
      expr: DATE_TRUNC('month', plan_start_date)
      comment: "Plan start date truncated to month for budget period coverage analysis."
  measures:
    - name: "total_planned_amount"
      expr: SUM(CAST(planned_amount AS DOUBLE))
      comment: "Total planned budget amount. Primary budget baseline KPI for financial planning and resource allocation decisions."
    - name: "total_actual_amount"
      expr: SUM(CAST(actual_amount AS DOUBLE))
      comment: "Total actual spend against budget. Core budget execution metric for period-end financial review."
    - name: "total_forecast_amount"
      expr: SUM(CAST(forecast_amount AS DOUBLE))
      comment: "Total forecast amount for the budget period. Used for full-year landing estimate and reforecast analysis."
    - name: "total_committed_amount"
      expr: SUM(CAST(committed_amount AS DOUBLE))
      comment: "Total committed spend (purchase orders, contracts) against budget. Measures encumbrance and remaining available budget."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total budget variance (actual minus planned). Negative variance signals overspend requiring executive intervention."
    - name: "total_revenue_projection"
      expr: SUM(CAST(revenue_projection AS DOUBLE))
      comment: "Total projected revenue in the budget. Used for top-line planning and P&L scenario analysis."
    - name: "total_gross_margin_projection"
      expr: SUM(CAST(gross_margin_projection AS DOUBLE))
      comment: "Total projected gross margin in the budget. Key profitability planning KPI for executive steering."
    - name: "total_ebitda_projection"
      expr: SUM(CAST(ebitda_projection AS DOUBLE))
      comment: "Total projected EBITDA in the budget. Core earnings planning metric for investor and board reporting."
    - name: "total_cogs_projection"
      expr: SUM(CAST(cogs_projection AS DOUBLE))
      comment: "Total projected cost of goods sold in the budget. Used for gross margin planning and procurement budget alignment."
    - name: "total_otb_amount"
      expr: SUM(CAST(otb_amount AS DOUBLE))
      comment: "Total open-to-buy amount remaining in the budget. Critical for merchandise buying and inventory investment decisions."
    - name: "avg_variance_pct"
      expr: AVG(CAST(variance_pct AS DOUBLE))
      comment: "Average budget variance percentage across budget lines. Measures overall budget accuracy and planning quality."
    - name: "budget_line_count"
      expr: COUNT(1)
      comment: "Total number of budget lines. Measures planning granularity and budget management workload."
    - name: "approved_budget_count"
      expr: COUNT(CASE WHEN approval_status = 'approved' THEN 1 END)
      comment: "Number of approved budget lines. Tracks planning cycle completion rate for governance reporting."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`finance_revenue_recognition_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue recognition metrics tracking recognized revenue, deferred balances, gross margin, and ASC 606 compliance by recognition method, channel, and period to support revenue assurance and audit readiness."
  source: "`vibe_retail_v1`.`finance`.`revenue_recognition_event`"
  dimensions:
    - name: "recognition_status"
      expr: recognition_status
      comment: "Current status of the revenue recognition event (e.g. recognized, deferred, pending) for ASC 606 compliance tracking."
    - name: "recognition_method"
      expr: recognition_method
      comment: "Method used to recognize revenue (e.g. point-in-time, over-time) for accounting policy analysis."
    - name: "revenue_category"
      expr: revenue_category
      comment: "Revenue category (e.g. product, service, lease, loyalty) for revenue stream mix analysis."
    - name: "channel"
      expr: channel
      comment: "Sales channel (e.g. store, e-commerce, wholesale) for channel-level revenue recognition analysis."
    - name: "asc606_step"
      expr: asc606_step
      comment: "ASC 606 five-step model step at which the event was recognized for compliance and audit reporting."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the recognition event for annual revenue reporting."
    - name: "recognition_start_date_month"
      expr: DATE_TRUNC('month', recognition_start_date)
      comment: "Recognition start date truncated to month for revenue trend analysis."
    - name: "posting_date_month"
      expr: DATE_TRUNC('month', posting_date)
      comment: "Posting date truncated to month for period-end revenue close analysis."
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Flag indicating whether the recognition event was reversed for revenue quality and restatement tracking."
    - name: "contract_modification_flag"
      expr: contract_modification_flag
      comment: "Flag indicating contract modification events that triggered re-allocation of transaction price."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the recognition event for multi-currency revenue reporting."
    - name: "source_document_type"
      expr: source_document_type
      comment: "Type of source document (e.g. sales order, lease, subscription) that triggered the recognition event."
  measures:
    - name: "total_recognized_amount"
      expr: SUM(CAST(recognized_amount AS DOUBLE))
      comment: "Total revenue recognized in the period. Primary top-line revenue KPI for financial reporting and investor communications."
    - name: "total_transaction_price"
      expr: SUM(CAST(transaction_price AS DOUBLE))
      comment: "Total transaction price allocated across performance obligations. Used for ASC 606 contract value analysis."
    - name: "total_allocated_transaction_price"
      expr: SUM(CAST(allocated_transaction_price AS DOUBLE))
      comment: "Total allocated transaction price per performance obligation. Measures revenue allocation accuracy under ASC 606."
    - name: "total_deferred_revenue_balance"
      expr: SUM(CAST(deferred_revenue_balance AS DOUBLE))
      comment: "Total deferred revenue balance outstanding. Key balance sheet liability metric for revenue backlog and future recognition planning."
    - name: "total_gross_margin_amount"
      expr: SUM(CAST(gross_margin_amount AS DOUBLE))
      comment: "Total gross margin on recognized revenue events. Core profitability KPI for product and channel margin analysis."
    - name: "total_cogs_amount"
      expr: SUM(CAST(cogs_amount AS DOUBLE))
      comment: "Total cost of goods sold associated with recognized revenue. Used for gross margin calculation and cost control."
    - name: "total_variable_consideration_amount"
      expr: SUM(CAST(variable_consideration_amount AS DOUBLE))
      comment: "Total variable consideration (rebates, returns, discounts) included in transaction price. Measures revenue constraint impact."
    - name: "total_loyalty_point_fair_value"
      expr: SUM(CAST(loyalty_point_fair_value AS DOUBLE))
      comment: "Total fair value of loyalty points issued as a separate performance obligation. Tracks loyalty program revenue deferral."
    - name: "recognition_event_count"
      expr: COUNT(1)
      comment: "Total number of revenue recognition events. Measures recognition activity volume for close workload and audit sampling."
    - name: "reversal_event_count"
      expr: COUNT(CASE WHEN reversal_flag = TRUE THEN 1 END)
      comment: "Number of reversed recognition events. High reversal rates signal revenue quality issues requiring audit attention."
    - name: "avg_recognized_amount"
      expr: AVG(CAST(recognized_amount AS DOUBLE))
      comment: "Average recognized revenue per event. Benchmarks typical recognition size and flags anomalous large or small recognitions."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`finance_tax_posting`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tax posting metrics tracking tax liability volumes, effective tax rates, exempt transactions, and reverse charge activity by jurisdiction and tax type to support tax compliance and planning decisions."
  source: "`vibe_retail_v1`.`finance`.`tax_posting`"
  dimensions:
    - name: "tax_type"
      expr: tax_type
      comment: "Type of tax (e.g. sales tax, VAT, use tax, withholding) for tax liability mix analysis."
    - name: "tax_code"
      expr: tax_code
      comment: "Tax code applied to the posting for detailed tax rate and jurisdiction analysis."
    - name: "tax_direction"
      expr: tax_direction
      comment: "Direction of the tax posting (input/output) for VAT and GST net position analysis."
    - name: "tax_jurisdiction_country"
      expr: tax_jurisdiction_country
      comment: "Country of the tax jurisdiction for cross-border tax liability and compliance reporting."
    - name: "tax_jurisdiction_state"
      expr: tax_jurisdiction_state
      comment: "State or province of the tax jurisdiction for state-level tax compliance and nexus analysis."
    - name: "tax_jurisdiction_code"
      expr: tax_jurisdiction_code
      comment: "Full tax jurisdiction code for granular tax authority reporting and remittance."
    - name: "tax_exempt_flag"
      expr: tax_exempt_flag
      comment: "Flag indicating tax-exempt transactions for exemption certificate management and audit."
    - name: "reverse_charge_flag"
      expr: reverse_charge_flag
      comment: "Flag indicating reverse charge mechanism transactions for VAT compliance in cross-border trade."
    - name: "nexus_indicator"
      expr: nexus_indicator
      comment: "Flag indicating whether the transaction creates tax nexus in the jurisdiction for nexus exposure analysis."
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Flag indicating reversed tax postings for tax adjustment and correction tracking."
    - name: "posting_date_month"
      expr: DATE_TRUNC('month', posting_date)
      comment: "Posting date truncated to month for monthly tax accrual and remittance analysis."
    - name: "document_type"
      expr: document_type
      comment: "Document type of the tax posting for sub-ledger reconciliation and audit trail."
    - name: "local_currency_code"
      expr: local_currency_code
      comment: "Local currency of the tax posting for statutory tax reporting."
  measures:
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount posted in transaction currency. Primary tax liability KPI for compliance reporting and remittance planning."
    - name: "total_tax_amount_local_currency"
      expr: SUM(CAST(tax_amount_local_currency AS DOUBLE))
      comment: "Total tax amount in local currency. Used for statutory tax filing and jurisdiction-level remittance."
    - name: "total_taxable_base_amount"
      expr: SUM(CAST(taxable_base_amount AS DOUBLE))
      comment: "Total taxable base amount on which tax was calculated. Used for effective tax rate analysis and audit verification."
    - name: "avg_tax_rate_percentage"
      expr: AVG(CAST(tax_rate_percentage AS DOUBLE))
      comment: "Average effective tax rate across postings. Benchmarks blended tax rate for planning and jurisdiction mix analysis."
    - name: "tax_posting_count"
      expr: COUNT(1)
      comment: "Total number of tax postings. Measures tax transaction volume for compliance workload and audit sampling."
    - name: "tax_exempt_transaction_count"
      expr: COUNT(CASE WHEN tax_exempt_flag = TRUE THEN 1 END)
      comment: "Number of tax-exempt transactions. Tracks exemption certificate coverage and audit exposure."
    - name: "reverse_charge_transaction_count"
      expr: COUNT(CASE WHEN reverse_charge_flag = TRUE THEN 1 END)
      comment: "Number of reverse charge transactions. Monitors cross-border VAT compliance and self-assessment obligations."
    - name: "nexus_transaction_count"
      expr: COUNT(CASE WHEN nexus_indicator = TRUE THEN 1 END)
      comment: "Number of transactions creating tax nexus. Tracks nexus exposure across jurisdictions for tax registration compliance."
    - name: "reversal_posting_count"
      expr: COUNT(CASE WHEN reversal_flag = TRUE THEN 1 END)
      comment: "Number of reversed tax postings. High reversal rates indicate tax determination errors requiring process review."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`finance_payment_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment run execution metrics tracking total disbursements, success rates, failed payments, and processing efficiency to support treasury operations and cash management decisions."
  source: "`vibe_retail_v1`.`finance`.`payment_run`"
  dimensions:
    - name: "payment_run_status"
      expr: payment_run_status
      comment: "Current status of the payment run (e.g. scheduled, executing, completed, failed) for treasury operations monitoring."
    - name: "run_type"
      expr: run_type
      comment: "Type of payment run (e.g. regular, emergency, reversal) for payment batch classification."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used in the run (e.g. ACH, wire, check) for payment channel mix analysis."
    - name: "payment_channel"
      expr: payment_channel
      comment: "Payment channel for the run for treasury channel efficiency analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the payment run for multi-currency cash management reporting."
    - name: "is_recurring"
      expr: is_recurring
      comment: "Flag indicating whether the payment run is recurring for automated payment scheduling analysis."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Bank reconciliation status of the payment run for treasury close and cash position accuracy."
    - name: "scheduled_date_month"
      expr: DATE_TRUNC('month', scheduled_date)
      comment: "Scheduled payment date truncated to month for cash outflow forecasting."
    - name: "gl_posting_date_month"
      expr: DATE_TRUNC('month', gl_posting_date)
      comment: "GL posting date truncated to month for period-end cash and payables close analysis."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms applied in the run for discount capture and working capital analysis."
  measures:
    - name: "total_payment_amount"
      expr: SUM(CAST(total_payment_amount AS DOUBLE))
      comment: "Total cash disbursed across all payment runs. Primary treasury outflow KPI for cash management and liquidity planning."
    - name: "payment_run_count"
      expr: COUNT(1)
      comment: "Total number of payment runs executed. Measures payment processing throughput and operational workload."
    - name: "avg_payment_run_amount"
      expr: AVG(CAST(total_payment_amount AS DOUBLE))
      comment: "Average disbursement amount per payment run. Benchmarks run size for treasury planning and anomaly detection."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`finance_fixed_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fixed asset metrics tracking net book value, accumulated depreciation, impairment losses, and asset lifecycle status to support capital expenditure planning and asset management decisions."
  source: "`vibe_retail_v1`.`finance`.`fixed_asset`"
  dimensions:
    - name: "asset_status"
      expr: asset_status
      comment: "Current lifecycle status of the fixed asset (e.g. active, retired, disposed) for asset portfolio management."
    - name: "asset_class_code"
      expr: asset_class_code
      comment: "Asset class (e.g. buildings, equipment, vehicles, IT) for capital expenditure mix and depreciation analysis."
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Depreciation method applied (e.g. straight-line, declining balance) for depreciation policy analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the fixed asset for multi-currency asset reporting."
    - name: "acquisition_date_year"
      expr: DATE_TRUNC('year', acquisition_date)
      comment: "Acquisition date truncated to year for capital expenditure vintage analysis."
    - name: "capitalization_date_year"
      expr: DATE_TRUNC('year', capitalization_date)
      comment: "Capitalization date truncated to year for capex activation timing analysis."
    - name: "impairment_indicator_flag"
      expr: impairment_indicator_flag
      comment: "Flag indicating assets with impairment indicators for impairment review and write-down planning."
    - name: "asset_location_code"
      expr: asset_location_code
      comment: "Physical location code of the asset for location-level asset portfolio analysis."
    - name: "depreciation_area"
      expr: depreciation_area
      comment: "Depreciation area (e.g. book, tax, IFRS) for multi-GAAP asset reporting."
  measures:
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total acquisition cost of fixed assets. Primary capex investment KPI for asset portfolio valuation and capital planning."
    - name: "total_net_book_value"
      expr: SUM(CAST(net_book_value AS DOUBLE))
      comment: "Total net book value of fixed assets. Core balance sheet asset metric for financial reporting and impairment assessment."
    - name: "total_accumulated_depreciation"
      expr: SUM(CAST(accumulated_depreciation AS DOUBLE))
      comment: "Total accumulated depreciation on fixed assets. Measures asset aging and remaining useful life for replacement planning."
    - name: "total_impairment_loss_amount"
      expr: SUM(CAST(impairment_loss_amount AS DOUBLE))
      comment: "Total impairment losses recognized on fixed assets. Key P&L impact metric for asset write-down decisions."
    - name: "total_last_depreciation_amount"
      expr: SUM(CAST(last_depreciation_amount AS DOUBLE))
      comment: "Total depreciation charged in the most recent depreciation run. Used for period depreciation expense accrual."
    - name: "total_disposal_proceeds"
      expr: SUM(CAST(disposal_proceeds AS DOUBLE))
      comment: "Total proceeds from asset disposals. Used for gain/loss on disposal analysis and asset recycling performance."
    - name: "total_salvage_value"
      expr: SUM(CAST(salvage_value AS DOUBLE))
      comment: "Total estimated salvage value of fixed assets. Used for depreciation base calculation and residual value planning."
    - name: "asset_count"
      expr: COUNT(1)
      comment: "Total number of fixed assets in the portfolio. Baseline asset inventory metric for asset management and insurance planning."
    - name: "impaired_asset_count"
      expr: COUNT(CASE WHEN impairment_indicator_flag = TRUE THEN 1 END)
      comment: "Number of assets with impairment indicators. Drives impairment review workload and potential write-down exposure."
    - name: "avg_net_book_value"
      expr: AVG(CAST(net_book_value AS DOUBLE))
      comment: "Average net book value per fixed asset. Benchmarks asset value and identifies over/under-invested asset classes."
    - name: "avg_useful_life_years"
      expr: AVG(CAST(useful_life_years AS DOUBLE))
      comment: "Average useful life in years across the asset portfolio. Used for depreciation planning and asset refresh cycle analysis."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`finance_intercompany_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Intercompany transaction metrics tracking gross payable and receivable positions, netting efficiency, reconciliation status, and elimination completeness to support intercompany close and consolidation decisions."
  source: "`vibe_retail_v1`.`finance`.`intercompany_transaction`"
  dimensions:
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of intercompany transaction (e.g. loan, trade, service charge) for intercompany balance analysis."
    - name: "transaction_status"
      expr: transaction_status
      comment: "Current status of the intercompany transaction (e.g. open, settled, eliminated) for close completeness tracking."
    - name: "netting_status"
      expr: netting_status
      comment: "Netting status of the transaction for intercompany netting efficiency analysis."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status between sending and receiving entities for intercompany close quality monitoring."
    - name: "elimination_flag"
      expr: elimination_flag
      comment: "Flag indicating whether the transaction has been eliminated in consolidation for group reporting completeness."
    - name: "settlement_method"
      expr: settlement_method
      comment: "Method used to settle the intercompany transaction (e.g. cash, netting, offset) for treasury analysis."
    - name: "transfer_pricing_method"
      expr: transfer_pricing_method
      comment: "Transfer pricing method applied (e.g. cost-plus, resale price) for transfer pricing compliance analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the intercompany transaction for annual consolidation analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the intercompany transaction for monthly intercompany close reporting."
    - name: "posting_date_month"
      expr: DATE_TRUNC('month', posting_date)
      comment: "Posting date truncated to month for intercompany volume trend analysis."
    - name: "document_currency"
      expr: document_currency
      comment: "Currency of the intercompany transaction document for multi-currency intercompany analysis."
    - name: "sending_company_code"
      expr: sending_company_code
      comment: "Company code of the sending entity for intercompany flow analysis between legal entities."
    - name: "receiving_company_code"
      expr: receiving_company_code
      comment: "Company code of the receiving entity for intercompany flow analysis between legal entities."
  measures:
    - name: "total_transaction_amount"
      expr: SUM(CAST(transaction_amount AS DOUBLE))
      comment: "Total intercompany transaction amount. Primary intercompany exposure KPI for consolidation and elimination planning."
    - name: "total_local_amount_sending"
      expr: SUM(CAST(local_currency_amount_sending AS DOUBLE))
      comment: "Total intercompany amount in the sending entity local currency for statutory reporting of the sending entity."
    - name: "total_local_amount_receiving"
      expr: SUM(CAST(local_currency_amount_receiving AS DOUBLE))
      comment: "Total intercompany amount in the receiving entity local currency for statutory reporting of the receiving entity."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total variance between sending and receiving intercompany amounts. High variance signals reconciliation failures requiring close intervention."
    - name: "transaction_count"
      expr: COUNT(1)
      comment: "Total number of intercompany transactions. Measures intercompany activity volume for close workload planning."
    - name: "unreconciled_transaction_count"
      expr: COUNT(CASE WHEN reconciliation_status <> 'reconciled' AND reconciliation_status IS NOT NULL THEN 1 END)
      comment: "Number of intercompany transactions not yet reconciled. Drives close escalation and intercompany dispute resolution."
    - name: "uneliminated_transaction_count"
      expr: COUNT(CASE WHEN elimination_flag = FALSE THEN 1 END)
      comment: "Number of intercompany transactions not yet eliminated in consolidation. Measures consolidation completeness risk."
    - name: "avg_transaction_amount"
      expr: AVG(CAST(transaction_amount AS DOUBLE))
      comment: "Average intercompany transaction amount. Benchmarks typical intercompany flow size for anomaly detection."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`finance_netting_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Intercompany netting run metrics tracking gross positions, netted amounts, netting efficiency, and reversal activity to support treasury netting program performance and working capital optimization decisions."
  source: "`vibe_retail_v1`.`finance`.`netting_run`"
  dimensions:
    - name: "netting_run_status"
      expr: netting_run_status
      comment: "Current status of the netting run (e.g. initiated, completed, reversed, failed) for treasury operations monitoring."
    - name: "run_type"
      expr: run_type
      comment: "Type of netting run (e.g. regular, ad-hoc, reversal) for netting program analysis."
    - name: "netting_method"
      expr: netting_method
      comment: "Netting method applied (e.g. bilateral, multilateral) for netting efficiency analysis."
    - name: "netting_scope"
      expr: netting_scope
      comment: "Scope of the netting run (e.g. entity group, currency) for netting coverage analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the netting run for multi-currency treasury analysis."
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Flag indicating whether the netting run was reversed for netting quality and error tracking."
    - name: "posted_to_gl_flag"
      expr: posted_to_gl_flag
      comment: "Flag indicating whether the netting run results have been posted to the general ledger."
    - name: "execution_date_month"
      expr: DATE_TRUNC('month', execution_date)
      comment: "Execution date truncated to month for netting run frequency and volume trend analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the netting run for annual netting program performance analysis."
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter of the netting run for quarterly treasury review."
  measures:
    - name: "total_gross_payable_amount"
      expr: SUM(CAST(total_gross_payable_amount AS DOUBLE))
      comment: "Total gross intercompany payable position before netting. Measures gross exposure managed through the netting program."
    - name: "total_gross_receivable_amount"
      expr: SUM(CAST(total_gross_receivable_amount AS DOUBLE))
      comment: "Total gross intercompany receivable position before netting. Measures gross exposure managed through the netting program."
    - name: "total_netted_amount"
      expr: SUM(CAST(total_netted_amount AS DOUBLE))
      comment: "Total net settlement amount after netting. Primary netting efficiency KPI — higher netted amount relative to gross indicates better working capital optimization."
    - name: "netting_run_count"
      expr: COUNT(1)
      comment: "Total number of netting runs executed. Measures netting program activity and treasury operational throughput."
    - name: "reversal_run_count"
      expr: COUNT(CASE WHEN reversal_flag = TRUE THEN 1 END)
      comment: "Number of reversed netting runs. High reversal rates signal netting process quality issues requiring investigation."
    - name: "avg_netted_amount"
      expr: AVG(CAST(total_netted_amount AS DOUBLE))
      comment: "Average net settlement amount per netting run. Benchmarks netting run size for treasury planning."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`finance_lease_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lease contract metrics tracking right-of-use asset values, lease liability balances, monthly rent obligations, and lease portfolio composition to support real estate and IFRS 16/ASC 842 compliance decisions."
  source: "`vibe_retail_v1`.`finance`.`lease_contract`"
  dimensions:
    - name: "lease_status"
      expr: lease_status
      comment: "Current status of the lease contract (e.g. active, expired, terminated, modified) for portfolio management."
    - name: "lease_type"
      expr: lease_type
      comment: "Type of lease (e.g. operating, finance) for IFRS 16/ASC 842 classification and balance sheet impact analysis."
    - name: "leased_asset_category"
      expr: leased_asset_category
      comment: "Category of leased asset (e.g. real estate, equipment, vehicles) for lease portfolio composition analysis."
    - name: "payment_frequency"
      expr: payment_frequency
      comment: "Frequency of lease payments (e.g. monthly, quarterly, annual) for cash flow planning."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the lease contract for multi-currency lease portfolio reporting."
    - name: "short_term_lease_flag"
      expr: short_term_lease_flag
      comment: "Flag indicating short-term leases exempt from balance sheet recognition under IFRS 16/ASC 842."
    - name: "low_value_asset_flag"
      expr: low_value_asset_flag
      comment: "Flag indicating low-value asset leases exempt from balance sheet recognition under IFRS 16."
    - name: "renewal_option_flag"
      expr: renewal_option_flag
      comment: "Flag indicating leases with renewal options for lease term reassessment and portfolio planning."
    - name: "purchase_option_flag"
      expr: purchase_option_flag
      comment: "Flag indicating leases with purchase options for capital planning and lease-vs-buy analysis."
    - name: "commencement_date_year"
      expr: DATE_TRUNC('year', commencement_date)
      comment: "Lease commencement date truncated to year for lease vintage and maturity analysis."
    - name: "expiration_date_year"
      expr: DATE_TRUNC('year', expiration_date)
      comment: "Lease expiration date truncated to year for lease maturity schedule and renewal planning."
  measures:
    - name: "total_rou_asset_carrying_value"
      expr: SUM(CAST(rou_asset_carrying_value AS DOUBLE))
      comment: "Total right-of-use asset carrying value. Core balance sheet metric for IFRS 16/ASC 842 compliance and real estate portfolio valuation."
    - name: "total_lease_liability_balance"
      expr: SUM(CAST(lease_liability_balance AS DOUBLE))
      comment: "Total lease liability balance outstanding. Key balance sheet liability metric for leverage ratio and covenant compliance analysis."
    - name: "total_base_rent_monthly"
      expr: SUM(CAST(base_rent_monthly AS DOUBLE))
      comment: "Total monthly base rent obligation across all active leases. Critical cash flow planning metric for real estate cost management."
    - name: "total_rou_asset_initial_value"
      expr: SUM(CAST(rou_asset_initial_value AS DOUBLE))
      comment: "Total initial right-of-use asset value at lease commencement. Measures total lease investment for portfolio analysis."
    - name: "total_lease_liability_initial"
      expr: SUM(CAST(lease_liability_initial AS DOUBLE))
      comment: "Total initial lease liability recognized at commencement. Measures total lease obligation taken on for financial planning."
    - name: "total_initial_direct_cost"
      expr: SUM(CAST(initial_direct_cost AS DOUBLE))
      comment: "Total initial direct costs capitalized on lease contracts. Measures transaction costs in the lease portfolio."
    - name: "lease_contract_count"
      expr: COUNT(1)
      comment: "Total number of lease contracts. Baseline portfolio size metric for real estate and equipment lease management."
    - name: "avg_weighted_remaining_term"
      expr: AVG(CAST(weighted_avg_remaining_term AS DOUBLE))
      comment: "Average weighted remaining lease term in months. Measures portfolio duration for renewal planning and liability maturity analysis."
    - name: "avg_implicit_rate"
      expr: AVG(CAST(implicit_rate AS DOUBLE))
      comment: "Average implicit interest rate across lease contracts. Used for lease cost benchmarking and financing cost analysis."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`finance_financial_period`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial period management metrics tracking period close status, posting availability, and close cycle timing to support period-end close governance and audit readiness decisions."
  source: "`vibe_retail_v1`.`finance`.`financial_period`"
  dimensions:
    - name: "period_type"
      expr: period_type
      comment: "Type of financial period (e.g. month, quarter, year) for close cycle analysis."
    - name: "close_status"
      expr: close_status
      comment: "Current close status of the financial period (e.g. open, in-close, closed, locked) for period-end governance."
    - name: "posting_status"
      expr: posting_status
      comment: "Posting status of the financial period for sub-ledger availability and close completeness tracking."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the financial period for annual close planning."
    - name: "calendar_type"
      expr: calendar_type
      comment: "Calendar type (e.g. Gregorian, 4-4-5, 4-5-4) for retail calendar alignment analysis."
    - name: "is_quarter_end_period"
      expr: is_quarter_end_period
      comment: "Flag indicating quarter-end periods for enhanced close scrutiny and external reporting."
    - name: "is_year_end_period"
      expr: is_year_end_period
      comment: "Flag indicating year-end periods for annual close and audit planning."
    - name: "is_adjustment_period"
      expr: is_adjustment_period
      comment: "Flag indicating adjustment periods for year-end audit adjustments and true-up entries."
    - name: "gl_posting_allowed"
      expr: gl_posting_allowed
      comment: "Flag indicating whether GL posting is currently allowed in the period for close control."
    - name: "start_date_month"
      expr: DATE_TRUNC('month', start_date)
      comment: "Period start date truncated to month for calendar alignment analysis."
  measures:
    - name: "period_count"
      expr: COUNT(1)
      comment: "Total number of financial periods defined. Baseline metric for fiscal calendar completeness and planning horizon coverage."
    - name: "open_period_count"
      expr: COUNT(CASE WHEN close_status = 'open' THEN 1 END)
      comment: "Number of currently open financial periods. Monitors concurrent open period exposure for close governance and audit risk."
    - name: "closed_period_count"
      expr: COUNT(CASE WHEN close_status = 'closed' THEN 1 END)
      comment: "Number of closed financial periods. Tracks close completion rate for period-end governance reporting."
    - name: "quarter_end_period_count"
      expr: COUNT(CASE WHEN is_quarter_end_period = TRUE THEN 1 END)
      comment: "Number of quarter-end periods in the calendar. Used for external reporting cycle planning."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`finance_revenue_recognition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue recognition metrics tracking ASC 606 compliance, performance obligation satisfaction, and deferred revenue management"
  source: "`vibe_retail_v1`.`finance`.`revenue_recognition_event`"
  dimensions:
    - name: "recognition_status"
      expr: recognition_status
      comment: "Status of revenue recognition"
    - name: "recognition_method"
      expr: recognition_method
      comment: "Method used for revenue recognition"
    - name: "revenue_category"
      expr: revenue_category
      comment: "Category of revenue"
    - name: "asc606_step"
      expr: asc606_step
      comment: "ASC 606 five-step model step"
    - name: "channel"
      expr: channel
      comment: "Sales channel"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of recognition"
    - name: "accounting_period"
      expr: accounting_period
      comment: "Accounting period of recognition"
    - name: "contract_modification_flag"
      expr: contract_modification_flag
      comment: "Whether the contract was modified"
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Whether the recognition was reversed"
    - name: "recognition_month"
      expr: DATE_TRUNC('MONTH', recognition_start_date)
      comment: "Month of revenue recognition start"
  measures:
    - name: "total_recognition_event_count"
      expr: COUNT(1)
      comment: "Total number of revenue recognition events"
    - name: "total_transaction_price"
      expr: SUM(CAST(transaction_price AS DOUBLE))
      comment: "Total transaction price of contracts"
    - name: "total_allocated_transaction_price"
      expr: SUM(CAST(allocated_transaction_price AS DOUBLE))
      comment: "Total allocated transaction price to performance obligations"
    - name: "total_recognized_amount"
      expr: SUM(CAST(recognized_amount AS DOUBLE))
      comment: "Total revenue recognized"
    - name: "total_deferred_revenue_balance"
      expr: SUM(CAST(deferred_revenue_balance AS DOUBLE))
      comment: "Total deferred revenue balance"
    - name: "total_cogs_amount"
      expr: SUM(CAST(cogs_amount AS DOUBLE))
      comment: "Total cost of goods sold"
    - name: "total_gross_margin_amount"
      expr: SUM(CAST(gross_margin_amount AS DOUBLE))
      comment: "Total gross margin"
    - name: "total_variable_consideration"
      expr: SUM(CAST(variable_consideration_amount AS DOUBLE))
      comment: "Total variable consideration amount"
    - name: "total_standalone_selling_price"
      expr: SUM(CAST(standalone_selling_price AS DOUBLE))
      comment: "Total standalone selling price"
    - name: "total_loyalty_points_redeemed"
      expr: SUM(CAST(loyalty_points_redeemed AS DOUBLE))
      comment: "Total loyalty points redeemed"
    - name: "avg_gross_margin_pct"
      expr: ROUND(100.0 * SUM(CAST(gross_margin_amount AS DOUBLE)) / NULLIF(SUM(CAST(recognized_amount AS DOUBLE)), 0), 2)
      comment: "Average gross margin percentage"
    - name: "revenue_recognition_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(recognized_amount AS DOUBLE)) / NULLIF(SUM(CAST(allocated_transaction_price AS DOUBLE)), 0), 2)
      comment: "Percentage of allocated transaction price recognized"
    - name: "deferred_revenue_ratio"
      expr: ROUND(SUM(CAST(deferred_revenue_balance AS DOUBLE)) / NULLIF(SUM(CAST(transaction_price AS DOUBLE)), 0), 2)
      comment: "Ratio of deferred revenue to total transaction price"
    - name: "unique_customers"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique customers with revenue recognition events"
    - name: "contract_modification_count"
      expr: COUNT(CASE WHEN contract_modification_flag = TRUE THEN 1 END)
      comment: "Number of contracts with modifications"
$$;