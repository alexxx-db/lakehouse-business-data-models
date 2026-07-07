-- Metric views for domain: finance | Business: Ngo | Version: 2 | Generated on: 2026-07-03 05:04:58

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`finance_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic budget performance metrics for NGO finance leadership. Tracks approved funding, actual expenditure, variance, and burn rate across grants, cost centers, and fiscal periods. Sourced from finance.budget which is the primary budget control record aligned with donor award ceilings (SAP / SAP S/4HANA, eTools)."
  source: "`vibe_ngo_v1`.`finance`.`budget`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the budget for time-series analysis of funding and expenditure trends."
    - name: "budget_status"
      expr: CAST(budget_status AS STRING)
      comment: "Current lifecycle status of the budget (e.g., draft, approved, closed) — drives pipeline and approval reporting."
    - name: "budget_type"
      expr: CAST(budget_type AS STRING)
      comment: "Classification of budget type (e.g., operational, project, grant) for segmented financial analysis."
    - name: "program_code"
      expr: program_code
      comment: "Program code linking the budget to a specific humanitarian program or intervention."
    - name: "owner"
      expr: owner
      comment: "Budget owner responsible for financial stewardship and variance accountability."
    - name: "donor_reporting_frequency"
      expr: donor_reporting_frequency
      comment: "Frequency at which donor financial reports are required — informs reporting calendar planning."
    - name: "period_start_date"
      expr: DATE_TRUNC('month', period_start_date)
      comment: "Budget period start month for time-bucketed trend analysis."
    - name: "period_end_date"
      expr: DATE_TRUNC('month', period_end_date)
      comment: "Budget period end month for pipeline and closeout planning."
  measures:
    - name: "total_approved_budget"
      expr: SUM(CAST(total_approved_amount AS DOUBLE))
      comment: "Total approved budget amount across all selected budgets. Core funding envelope metric used in board and donor reporting."
    - name: "total_actual_expenditure"
      expr: SUM(CAST(total_actual_expenditure AS DOUBLE))
      comment: "Total actual expenditure recorded against approved budgets. Drives burn-rate and absorption analysis."
    - name: "total_budget_variance"
      expr: SUM(CAST(total_variance_amount AS DOUBLE))
      comment: "Aggregate variance between approved budget and actual expenditure. Negative variance signals underspend risk; positive signals overspend risk."
    - name: "total_direct_cost_budget"
      expr: SUM(CAST(direct_cost_budget AS DOUBLE))
      comment: "Total direct program cost budget. Used to assess program delivery investment versus indirect/overhead costs."
    - name: "total_indirect_cost_budget"
      expr: SUM(CAST(indirect_cost_budget AS DOUBLE))
      comment: "Total indirect cost (overhead/ICR) budget. Compared against NICRA rate compliance thresholds."
    - name: "total_cost_share_requirement"
      expr: SUM(CAST(cost_share_requirement_amount AS DOUBLE))
      comment: "Total cost-share (match) requirement across budgets. Tracks compliance with donor co-financing obligations."
    - name: "avg_burn_rate_percentage"
      expr: AVG(CAST(burn_rate_percentage AS DOUBLE))
      comment: "Average budget burn rate percentage across selected budgets. A key operational health indicator — low burn late in a period signals absorption risk."
    - name: "avg_icr_rate_applied"
      expr: AVG(CAST(icr_rate_applied AS DOUBLE))
      comment: "Average indirect cost recovery rate applied across budgets. Monitors compliance with negotiated NICRA rates."
    - name: "total_award_ceiling"
      expr: SUM(CAST(award_ceiling_amount AS DOUBLE))
      comment: "Total award ceiling amount across all budgets. Represents the maximum allowable expenditure under donor agreements."
    - name: "budget_count"
      expr: COUNT(1)
      comment: "Number of active budget records. Used to assess portfolio breadth and workload distribution across finance teams."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`finance_budget_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Granular budget line-level metrics for cost category analysis, cost-share tracking, and allowability compliance. Enables drill-down from budget totals to individual line items by expense category, cost type, and donor budget category. Aligned with SAP budget line structures and USAID/UN donor budget templates."
  source: "`vibe_ngo_v1`.`finance`.`budget_line`"
  dimensions:
    - name: "expense_category"
      expr: expense_category
      comment: "Expense category of the budget line (e.g., personnel, travel, supplies) for functional cost analysis."
    - name: "cost_type"
      expr: cost_type
      comment: "Direct or indirect cost classification — critical for NICRA compliance and donor allowability reviews."
    - name: "is_cost_share"
      expr: is_cost_share
      comment: "Flags budget lines that represent donor-required cost-share (match) contributions."
    - name: "is_allowable"
      expr: is_allowable
      comment: "Indicates whether the budget line cost is allowable under the applicable donor agreement — key for audit readiness."
    - name: "allocation_method"
      expr: allocation_method
      comment: "Method used to allocate costs across funding sources (e.g., direct, proportional) — informs cost allocation governance."
    - name: "budget_line_status"
      expr: CAST(budget_line_status AS STRING)
      comment: "Lifecycle status of the budget line (e.g., draft, approved, revised)."
    - name: "donor_budget_category"
      expr: CAST(donor_budget_category AS STRING)
      comment: "Donor-defined budget category for external reporting alignment (e.g., USAID budget categories)."
    - name: "program_code"
      expr: program_code
      comment: "Program code for cross-program budget line analysis."
    - name: "cost_share_source"
      expr: cost_share_source
      comment: "Source of cost-share funding (e.g., organizational, third-party) for match compliance tracking."
  measures:
    - name: "total_original_budget"
      expr: SUM(CAST(original_amount AS DOUBLE))
      comment: "Total original approved budget line amounts before any revisions. Baseline for modification tracking."
    - name: "total_revised_budget"
      expr: SUM(CAST(revised_amount AS DOUBLE))
      comment: "Total revised budget line amounts after approved modifications. Reflects current authorized spending envelope."
    - name: "total_budget_modification"
      expr: SUM(CAST(revised_amount AS DOUBLE) - CAST(original_amount AS DOUBLE))
      comment: "Net budget modification amount (revised minus original). Tracks cumulative budget realignment activity."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost across budget lines. Benchmarks cost efficiency for recurring cost categories (e.g., staff daily rates, commodity unit costs)."
    - name: "total_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity of units budgeted across lines. Supports unit-cost and volume analysis for procurement planning."
    - name: "avg_indirect_cost_rate"
      expr: AVG(CAST(indirect_cost_rate AS DOUBLE))
      comment: "Average indirect cost rate applied across budget lines. Monitors consistency with negotiated NICRA rates."
    - name: "avg_allocation_percentage"
      expr: AVG(CAST(allocation_percentage AS DOUBLE))
      comment: "Average cost allocation percentage across multi-funded budget lines. Informs shared-cost governance."
    - name: "budget_line_count"
      expr: COUNT(1)
      comment: "Total number of budget lines. Indicates budget complexity and granularity of financial planning."
    - name: "cost_share_line_count"
      expr: COUNT(CASE WHEN is_cost_share = TRUE THEN 1 END)
      comment: "Number of budget lines designated as cost-share. Tracks match obligation coverage across the budget."
    - name: "unallowable_line_count"
      expr: COUNT(CASE WHEN is_allowable = FALSE THEN 1 END)
      comment: "Number of budget lines flagged as unallowable. A non-zero value is an audit risk indicator requiring immediate review."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`finance_journal_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "General ledger journal entry metrics for financial control, compliance monitoring, and audit readiness. Tracks posting volumes, compliance flags, reversal activity, and inter-company transactions. Sourced from finance.journal_entry — the core GL posting record in SAP/S4HANA and equivalent NGO ERP systems."
  source: "`vibe_ngo_v1`.`finance`.`journal_entry`"
  dimensions:
    - name: "document_type"
      expr: document_type
      comment: "Journal entry document type (e.g., vendor invoice, payroll, accrual) for transaction classification."
    - name: "posting_status"
      expr: posting_status
      comment: "Current posting status of the journal entry (e.g., posted, parked, reversed) — drives GL completeness reporting."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Boolean flag indicating whether the journal entry has a compliance issue — critical for donor audit readiness."
    - name: "is_adjustment"
      expr: is_adjustment
      comment: "Identifies adjustment entries — high volumes signal data quality or period-close issues."
    - name: "is_inter_company"
      expr: is_inter_company
      comment: "Flags inter-company/inter-entity transactions for elimination and consolidation reporting."
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Indicates whether the journal entry has been reversed — reversal rates are a financial control quality metric."
    - name: "functional_area"
      expr: functional_area
      comment: "Functional area classification (e.g., program, G&A, fundraising) for functional expense reporting per FASB ASC 958."
    - name: "posting_date_month"
      expr: DATE_TRUNC('month', posting_date)
      comment: "Month of GL posting date for period-over-period financial trend analysis."
    - name: "ledger_group"
      expr: ledger_group
      comment: "Ledger group (e.g., leading ledger, donor ledger) for multi-ledger reporting environments."
    - name: "company_code"
      expr: company_code
      comment: "Legal entity company code for multi-entity NGO consolidation reporting."
  measures:
    - name: "journal_entry_count"
      expr: COUNT(1)
      comment: "Total number of journal entries posted. Baseline volume metric for GL activity monitoring and period-close completeness."
    - name: "compliance_flagged_entry_count"
      expr: COUNT(CASE WHEN compliance_flag = TRUE THEN 1 END)
      comment: "Number of journal entries flagged for compliance issues. A key audit risk indicator — any non-zero value requires investigation before donor reporting."
    - name: "reversal_entry_count"
      expr: COUNT(CASE WHEN reversal_indicator = TRUE THEN 1 END)
      comment: "Number of reversed journal entries. High reversal rates signal data entry errors or process control weaknesses."
    - name: "adjustment_entry_count"
      expr: COUNT(CASE WHEN is_adjustment = TRUE THEN 1 END)
      comment: "Number of adjustment journal entries. Elevated adjustment volumes late in a period indicate period-close quality issues."
    - name: "inter_company_entry_count"
      expr: COUNT(CASE WHEN is_inter_company = TRUE THEN 1 END)
      comment: "Number of inter-company journal entries requiring elimination in consolidated financial statements."
    - name: "avg_exchange_rate"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average exchange rate applied across journal entries. Monitors FX rate consistency and potential revaluation exposure."
    - name: "avg_indirect_cost_rate"
      expr: AVG(CAST(indirect_cost_rate AS DOUBLE))
      comment: "Average indirect cost rate applied on journal entries. Validates NICRA rate application consistency across postings."
    - name: "compliance_flag_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of journal entries with compliance flags. A rate above 0% is a red flag for donor audits and internal controls reviews."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`finance_journal_entry_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "GL line-level financial metrics for expenditure analysis, cost allowability, and donor restriction compliance. Provides the most granular view of actual financial flows by GL account, fund, cost center, and expense category. Essential for USAID SF-425, UN FACE form, and IATI financial reporting."
  source: "`vibe_ngo_v1`.`finance`.`journal_entry_line`"
  dimensions:
    - name: "functional_expense_category"
      expr: functional_expense_category
      comment: "Functional expense category (e.g., program services, management, fundraising) for FASB ASC 958 functional expense reporting."
    - name: "natural_account_classification"
      expr: natural_account_classification
      comment: "Natural account classification (e.g., salaries, travel, supplies) for object-code expenditure analysis."
    - name: "donor_restriction_type"
      expr: donor_restriction_type
      comment: "Donor restriction type (restricted/unrestricted/temporarily restricted) — critical for net asset classification and donor compliance."
    - name: "allowable_cost_flag"
      expr: allowable_cost_flag
      comment: "Indicates whether the line item cost is allowable under the applicable donor agreement — key for audit and disallowance risk."
    - name: "direct_cost_flag"
      expr: direct_cost_flag
      comment: "Distinguishes direct program costs from indirect/overhead costs for NICRA base calculation."
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Flags reversed journal entry lines — used to identify and exclude reversals from net expenditure calculations."
    - name: "intercompany_flag"
      expr: intercompany_flag
      comment: "Identifies inter-entity transactions requiring elimination in consolidated reporting."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the journal entry line — unapproved lines represent financial control gaps."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the journal entry line for annual financial reporting."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly financial close and period-over-period variance analysis."
    - name: "posting_date_month"
      expr: DATE_TRUNC('month', posting_date)
      comment: "Month of posting date for trend analysis of expenditure patterns."
    - name: "program_code"
      expr: program_code
      comment: "Program code for cross-program expenditure analysis and donor financial reporting."
  measures:
    - name: "total_debit_amount"
      expr: SUM(CAST(debit_amount AS DOUBLE))
      comment: "Total debit amount across journal entry lines. Represents gross expenditure and asset increases in the GL."
    - name: "total_credit_amount"
      expr: SUM(CAST(credit_amount AS DOUBLE))
      comment: "Total credit amount across journal entry lines. Represents revenue recognition, liability increases, and expenditure reversals."
    - name: "net_expenditure_amount"
      expr: SUM(CAST(debit_amount AS DOUBLE) - CAST(credit_amount AS DOUBLE))
      comment: "Net expenditure (debits minus credits) — the primary measure of actual program and operational spend for donor financial reports."
    - name: "unallowable_cost_amount"
      expr: SUM(CASE WHEN allowable_cost_flag = FALSE THEN debit_amount ELSE 0 END)
      comment: "Total amount of unallowable costs posted to the GL. Non-zero values represent disallowance risk and potential donor clawback exposure."
    - name: "direct_cost_amount"
      expr: SUM(CASE WHEN direct_cost_flag = TRUE THEN debit_amount ELSE 0 END)
      comment: "Total direct program cost expenditure. Used to calculate the NICRA indirect cost base and program efficiency ratios."
    - name: "indirect_cost_amount"
      expr: SUM(CASE WHEN direct_cost_flag = FALSE THEN debit_amount ELSE 0 END)
      comment: "Total indirect/overhead cost expenditure. Compared against NICRA rate caps and donor overhead limits."
    - name: "reversal_amount"
      expr: SUM(CASE WHEN reversal_flag = TRUE THEN debit_amount ELSE 0 END)
      comment: "Total amount of reversed journal entry lines. High reversal amounts signal data quality or process control issues."
    - name: "avg_indirect_cost_rate"
      expr: AVG(CAST(indirect_cost_rate AS DOUBLE))
      comment: "Average indirect cost rate applied across journal entry lines. Validates NICRA rate consistency at the line level."
    - name: "unallowable_cost_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN allowable_cost_flag = FALSE THEN debit_amount ELSE 0 END) / NULLIF(SUM(CAST(debit_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of total expenditure classified as unallowable. A critical donor audit risk metric — any non-zero rate requires immediate remediation."
    - name: "direct_cost_ratio"
      expr: ROUND(100.0 * SUM(CASE WHEN direct_cost_flag = TRUE THEN debit_amount ELSE 0 END) / NULLIF(SUM(CAST(debit_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of total expenditure classified as direct program costs. Donors and boards use this to assess program efficiency versus overhead."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`finance_payable`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts payable metrics for cash flow management, vendor payment performance, and grant expenditure tracking. Monitors outstanding liabilities, payment timeliness, and three-way match compliance. Critical for NGO treasury management and donor expenditure reporting (SAP AP module, ICON procurement)."
  source: "`vibe_ngo_v1`.`finance`.`payable`"
  dimensions:
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the payable (e.g., pending, approved, on-hold) — drives payment authorization workflow monitoring."
    - name: "payment_status"
      expr: CAST(payment_status AS STRING)
      comment: "Current payment status (e.g., unpaid, partial, paid) for cash flow and aging analysis."
    - name: "three_way_match_status"
      expr: three_way_match_status
      comment: "Three-way match status (PO/GR/invoice match) — a key procurement control indicator for audit readiness."
    - name: "is_grant_eligible"
      expr: is_grant_eligible
      comment: "Flags payables chargeable to a grant award — used to segregate grant-funded from unrestricted expenditures."
    - name: "is_restricted_fund"
      expr: is_restricted_fund
      comment: "Indicates the payable is funded from a restricted donor fund — requires compliance with donor use restrictions."
    - name: "due_date_month"
      expr: DATE_TRUNC('month', due_date)
      comment: "Month the payable is due — used for cash flow forecasting and payment scheduling."
    - name: "invoice_date_month"
      expr: DATE_TRUNC('month', invoice_date)
      comment: "Month of invoice date for expenditure accrual and period-close analysis."
  measures:
    - name: "total_invoice_gross_amount"
      expr: SUM(CAST(invoice_gross_amount AS DOUBLE))
      comment: "Total gross invoice amount across all payables. Represents total vendor liability before discounts and taxes."
    - name: "total_invoice_net_amount"
      expr: SUM(CAST(invoice_net_amount AS DOUBLE))
      comment: "Total net invoice amount after discounts. The primary accounts payable liability balance for balance sheet reporting."
    - name: "total_functional_currency_amount"
      expr: SUM(CAST(functional_currency_amount AS DOUBLE))
      comment: "Total payable amount in functional (reporting) currency. Used for consolidated financial statements and donor reports."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on payables. Monitors VAT/tax recoverability and compliance with local tax regulations."
    - name: "total_withholding_tax_amount"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax deducted from vendor payments. Tracks statutory withholding compliance."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early payment discounts captured. Measures treasury efficiency in optimizing payment timing."
    - name: "outstanding_payable_count"
      expr: COUNT(CASE WHEN CAST(payment_status AS STRING) != 'paid' THEN 1 END)
      comment: "Number of unpaid payables. Drives cash flow planning and vendor relationship management."
    - name: "three_way_match_failure_count"
      expr: COUNT(CASE WHEN three_way_match_status != 'matched' THEN 1 END)
      comment: "Number of payables failing three-way match (PO/GR/invoice). A procurement control quality metric — failures block payment and signal process breakdowns."
    - name: "avg_indirect_cost_rate"
      expr: AVG(CAST(indirect_cost_rate AS DOUBLE))
      comment: "Average indirect cost rate applied to payables. Validates NICRA rate application on vendor invoices."
    - name: "grant_eligible_payable_amount"
      expr: SUM(CASE WHEN is_grant_eligible = TRUE THEN invoice_net_amount ELSE 0 END)
      comment: "Total net payable amount eligible for grant reimbursement. Critical for grant drawdown requests and donor financial reporting."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`finance_receivable`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts receivable and grant drawdown metrics for revenue recognition, collection performance, and donor cash flow management. Tracks outstanding receivables, write-offs, and dispute resolution. Essential for NGO liquidity management and grant financial reporting."
  source: "`vibe_ngo_v1`.`finance`.`receivable`"
  dimensions:
    - name: "collection_status"
      expr: collection_status
      comment: "Collection status of the receivable (e.g., current, overdue, in-dispute, written-off) — drives collections prioritization."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Indicates whether the receivable is in dispute — disputed receivables require escalation and may affect donor relationships."
    - name: "receipt_method"
      expr: receipt_method
      comment: "Method of receipt (e.g., wire transfer, check, ACH) for cash management and reconciliation analysis."
    - name: "invoice_delivery_method"
      expr: invoice_delivery_method
      comment: "Invoice delivery method (e.g., email, portal, mail) — informs billing process efficiency analysis."
    - name: "program_code"
      expr: program_code
      comment: "Program code for cross-program receivable and revenue analysis."
    - name: "due_date_month"
      expr: DATE_TRUNC('month', due_date)
      comment: "Month the receivable is due — used for aging analysis and cash flow forecasting."
    - name: "invoice_date_month"
      expr: DATE_TRUNC('month', invoice_date)
      comment: "Month of invoice date for revenue recognition and billing trend analysis."
    - name: "revenue_recognition_date_month"
      expr: DATE_TRUNC('month', revenue_recognition_date)
      comment: "Month of revenue recognition for GAAP/IFRS revenue reporting and donor fund utilization tracking."
  measures:
    - name: "total_invoice_amount"
      expr: SUM(CAST(invoice_amount AS DOUBLE))
      comment: "Total invoiced amount across all receivables. Represents gross revenue billed to donors and grantors."
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total outstanding receivable balance. The primary AR balance metric for liquidity and cash flow management."
    - name: "total_functional_currency_amount"
      expr: SUM(CAST(functional_currency_amount AS DOUBLE))
      comment: "Total receivable amount in functional currency. Used for consolidated financial statements."
    - name: "total_write_off_amount"
      expr: SUM(CAST(write_off_amount AS DOUBLE))
      comment: "Total amount written off as uncollectible. Tracks credit loss exposure and donor payment reliability."
    - name: "total_allowance_for_doubtful_accounts"
      expr: SUM(CAST(allowance_for_doubtful_accounts AS DOUBLE))
      comment: "Total allowance for doubtful accounts. Represents estimated uncollectible receivables for balance sheet provisioning."
    - name: "disputed_receivable_amount"
      expr: SUM(CASE WHEN dispute_flag = TRUE THEN outstanding_balance ELSE 0 END)
      comment: "Total outstanding balance of disputed receivables. Elevated values signal donor relationship or billing quality issues."
    - name: "write_off_rate"
      expr: ROUND(100.0 * SUM(CAST(write_off_amount AS DOUBLE)) / NULLIF(SUM(CAST(invoice_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of invoiced amounts written off as uncollectible. A key credit quality and donor reliability metric."
    - name: "dispute_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of receivables in dispute. High dispute rates indicate billing accuracy or donor relationship issues."
    - name: "avg_exchange_rate"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average exchange rate applied to receivables. Monitors FX exposure on multi-currency donor receivables."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`finance_receivable_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Donor cash receipt and grant drawdown metrics for revenue recognition, restricted fund tracking, and matching gift analysis. Tracks actual cash inflows from donors and grantors. Critical for NGO cash management, fund accounting, and donor stewardship reporting."
  source: "`vibe_ngo_v1`.`finance`.`receivable_receipt`"
  dimensions:
    - name: "receipt_method"
      expr: receipt_method
      comment: "Payment method used by the donor/grantor (e.g., wire, check, ACH) for cash management and reconciliation."
    - name: "receipt_channel"
      expr: receipt_channel
      comment: "Channel through which the receipt was received (e.g., online, bank, mail) for fundraising channel analysis."
    - name: "receipt_status"
      expr: receipt_status
      comment: "Current status of the receipt (e.g., posted, pending, reversed) — drives cash posting completeness monitoring."
    - name: "restriction_type"
      expr: restriction_type
      comment: "Donor restriction type (restricted/unrestricted) — fundamental for fund accounting and net asset classification."
    - name: "is_matching_gift"
      expr: is_matching_gift
      comment: "Flags receipts from corporate matching gift programs — used to track match fulfillment and cost-share compliance."
    - name: "is_in_kind_conversion"
      expr: is_in_kind_conversion
      comment: "Identifies in-kind contributions converted to cash equivalents — important for GAAP in-kind revenue recognition."
    - name: "is_refund"
      expr: is_refund
      comment: "Flags refund receipts — refunds reduce net revenue and require separate tracking for donor reporting."
    - name: "receipt_date_month"
      expr: DATE_TRUNC('month', receipt_date)
      comment: "Month of receipt for cash flow trend analysis and donor giving pattern reporting."
    - name: "revenue_recognition_date_month"
      expr: DATE_TRUNC('month', revenue_recognition_date)
      comment: "Month of revenue recognition for GAAP/IFRS revenue reporting."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Bank reconciliation status of the receipt — unreconciled receipts represent a financial control gap."
  measures:
    - name: "total_receipt_amount"
      expr: SUM(CAST(receipt_amount AS DOUBLE))
      comment: "Total cash received from donors and grantors. The primary revenue inflow metric for NGO financial management."
    - name: "total_functional_currency_amount"
      expr: SUM(CAST(functional_currency_amount AS DOUBLE))
      comment: "Total receipt amount in functional (reporting) currency. Used for consolidated financial statements and donor reports."
    - name: "matching_gift_receipt_amount"
      expr: SUM(CASE WHEN is_matching_gift = TRUE THEN receipt_amount ELSE 0 END)
      comment: "Total receipts from corporate matching gift programs. Tracks match fulfillment against cost-share commitments."
    - name: "restricted_receipt_amount"
      expr: SUM(CASE WHEN restriction_type = 'restricted' THEN receipt_amount ELSE 0 END)
      comment: "Total restricted donor receipts. Monitors restricted fund inflows for compliance with donor use restrictions."
    - name: "refund_amount"
      expr: SUM(CASE WHEN is_refund = TRUE THEN receipt_amount ELSE 0 END)
      comment: "Total refund amounts processed. Refunds reduce net revenue and may indicate donor dissatisfaction or billing errors."
    - name: "avg_receipt_amount"
      expr: AVG(CAST(receipt_amount AS DOUBLE))
      comment: "Average receipt amount per transaction. Benchmarks donor giving levels and grant drawdown sizes."
    - name: "receipt_count"
      expr: COUNT(1)
      comment: "Total number of receipts processed. Baseline volume metric for cash posting workload and donor activity."
    - name: "unreconciled_receipt_count"
      expr: COUNT(CASE WHEN reconciliation_status != 'reconciled' THEN 1 END)
      comment: "Number of receipts not yet reconciled to bank statements. A financial control quality metric — high counts signal reconciliation backlogs."
    - name: "avg_exchange_rate"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average exchange rate applied to receipts. Monitors FX exposure on multi-currency donor receipts."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`finance_bank_reconciliation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bank reconciliation quality and financial control metrics. Monitors reconciliation completeness, variance amounts, outstanding items, and compliance flags. A critical internal control metric for NGO finance teams and external auditors (SAP bank reconciliation, ICON treasury)."
  source: "`vibe_ngo_v1`.`finance`.`bank_reconciliation`"
  dimensions:
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Current status of the bank reconciliation (e.g., in-progress, completed, approved) — drives period-close completeness monitoring."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Boolean flag indicating a compliance issue with the reconciliation — any flagged reconciliation requires immediate review."
    - name: "is_restricted_fund"
      expr: is_restricted_fund
      comment: "Indicates the reconciliation covers a restricted donor fund account — restricted fund reconciliations have heightened audit scrutiny."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the reconciliation for annual audit and financial reporting."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly reconciliation completeness tracking."
    - name: "reconciliation_date_month"
      expr: DATE_TRUNC('month', reconciliation_date)
      comment: "Month of reconciliation completion for timeliness trend analysis."
    - name: "approved_by"
      expr: approved_by
      comment: "Approver of the reconciliation — used for segregation of duties and approval workflow monitoring."
  measures:
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total reconciliation variance (GL balance vs. bank statement). Non-zero aggregate variance is a financial control red flag requiring investigation."
    - name: "total_outstanding_checks"
      expr: SUM(CAST(outstanding_checks_amount AS DOUBLE))
      comment: "Total outstanding checks not yet cleared. Elevated amounts indicate stale checks or payment processing delays."
    - name: "total_outstanding_deposits"
      expr: SUM(CAST(outstanding_deposits_amount AS DOUBLE))
      comment: "Total deposits in transit not yet reflected in bank statements. Monitors timing differences in cash posting."
    - name: "total_unrecorded_bank_charges"
      expr: SUM(CAST(unrecorded_bank_charges_amount AS DOUBLE))
      comment: "Total bank charges not yet recorded in the GL. Unrecorded charges represent an accrual gap affecting financial statement accuracy."
    - name: "total_unrecorded_bank_credits"
      expr: SUM(CAST(unrecorded_bank_credits_amount AS DOUBLE))
      comment: "Total bank credits not yet recorded in the GL. Unrecorded credits may represent unrecognized revenue or donor receipts."
    - name: "compliance_flagged_reconciliation_count"
      expr: COUNT(CASE WHEN compliance_flag = TRUE THEN 1 END)
      comment: "Number of reconciliations with compliance flags. Any non-zero count is an audit risk indicator requiring escalation."
    - name: "reconciliation_count"
      expr: COUNT(1)
      comment: "Total number of bank reconciliations completed. Baseline metric for reconciliation coverage and period-close completeness."
    - name: "avg_variance_amount"
      expr: AVG(CAST(variance_amount AS DOUBLE))
      comment: "Average reconciliation variance per account. Benchmarks reconciliation quality across the bank account portfolio."
    - name: "compliance_flag_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reconciliations with compliance flags. A rate above 0% triggers internal audit review."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`finance_payment_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment run execution metrics for treasury operations, payment success rates, and financial control monitoring. Tracks batch payment performance, failure rates, and compliance. Critical for NGO cash management and vendor payment SLA monitoring (SAP payment runs, ICON disbursements)."
  source: "`vibe_ngo_v1`.`finance`.`payment_run`"
  dimensions:
    - name: "payment_run_status"
      expr: payment_run_status
      comment: "Current status of the payment run (e.g., scheduled, executing, completed, failed) — drives treasury operations monitoring."
    - name: "run_type"
      expr: run_type
      comment: "Type of payment run (e.g., vendor, payroll, grant disbursement) for payment category analysis."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Boolean flag indicating a compliance issue with the payment run — flagged runs must be investigated before release."
    - name: "is_recurring"
      expr: is_recurring
      comment: "Identifies recurring payment runs (e.g., monthly payroll, standing orders) for automation and scheduling analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the payment run for annual expenditure reporting."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly payment volume and cash flow analysis."
    - name: "scheduled_date_month"
      expr: DATE_TRUNC('month', scheduled_date)
      comment: "Month the payment run was scheduled — used for cash flow forecasting and treasury planning."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status of the payment run — unreconciled runs represent a financial control gap."
  measures:
    - name: "total_payment_amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total amount disbursed across all payment runs. Primary cash outflow metric for treasury management."
    - name: "total_successful_amount"
      expr: SUM(CAST(successful_amount AS DOUBLE))
      comment: "Total amount of successfully processed payments. Measures effective cash disbursement."
    - name: "total_failed_amount"
      expr: SUM(CAST(failed_amount AS DOUBLE))
      comment: "Total amount of failed payments. Failed payment amounts represent unmet vendor obligations and operational risk."
    - name: "total_successful_payment_count"
      expr: SUM(CAST(successful_payment_count AS DOUBLE))
      comment: "Total number of successfully processed individual payments across all runs."
    - name: "total_failed_payment_count"
      expr: SUM(CAST(failed_payment_count AS DOUBLE))
      comment: "Total number of failed individual payments. High failure counts signal payment processing or data quality issues."
    - name: "payment_success_rate"
      expr: ROUND(100.0 * SUM(CAST(successful_payment_count AS DOUBLE)) / NULLIF(SUM(CAST(total_payment_count AS DOUBLE)), 0), 2)
      comment: "Percentage of payments successfully processed. A key treasury operations KPI — rates below 95% require process investigation."
    - name: "payment_failure_rate"
      expr: ROUND(100.0 * SUM(CAST(failed_payment_count AS DOUBLE)) / NULLIF(SUM(CAST(total_payment_count AS DOUBLE)), 0), 2)
      comment: "Percentage of payments that failed. Elevated failure rates indicate vendor data quality issues or banking system problems."
    - name: "compliance_flagged_run_count"
      expr: COUNT(CASE WHEN compliance_flag = TRUE THEN 1 END)
      comment: "Number of payment runs with compliance flags. Flagged runs must be reviewed before funds are released — a critical financial control metric."
    - name: "payment_run_count"
      expr: COUNT(1)
      comment: "Total number of payment runs executed. Baseline metric for treasury operations workload and automation coverage."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`finance_cost_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost allocation metrics for indirect cost recovery, NICRA compliance, and multi-fund cost sharing governance. Tracks allocated amounts, allocation rates, and compliance flags across cost pools, funds, and project sites. Essential for USAID NICRA audits and UN cost-sharing frameworks."
  source: "`vibe_ngo_v1`.`finance`.`cost_allocation`"
  dimensions:
    - name: "allocation_method"
      expr: allocation_method
      comment: "Cost allocation method (e.g., direct, proportional, square footage) — informs allocation governance and audit defensibility."
    - name: "allocation_basis"
      expr: allocation_basis
      comment: "Basis used for cost allocation (e.g., headcount, square footage, direct costs) — must align with NICRA agreement terms."
    - name: "allocation_status"
      expr: allocation_status
      comment: "Current status of the cost allocation (e.g., pending, posted, reversed) — drives period-close completeness monitoring."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Boolean flag indicating a compliance issue with the allocation — flagged allocations represent NICRA audit risk."
    - name: "cost_category"
      expr: cost_category
      comment: "Cost category of the allocated amount (e.g., facilities, administration, program) for functional expense analysis."
    - name: "cost_pool"
      expr: cost_pool
      comment: "Cost pool from which costs are allocated — aligns with NICRA cost pool structure."
    - name: "is_fa_cost"
      expr: is_fa_cost
      comment: "Identifies facilities and administrative (F&A) costs — critical for NICRA rate calculation and donor overhead reporting."
    - name: "is_restricted_fund"
      expr: is_restricted_fund
      comment: "Indicates allocation to a restricted donor fund — restricted fund allocations require donor compliance verification."
    - name: "allocation_date_month"
      expr: DATE_TRUNC('month', allocation_date)
      comment: "Month of cost allocation for period-over-period indirect cost trend analysis."
  measures:
    - name: "total_allocated_amount"
      expr: SUM(CAST(allocated_amount AS DOUBLE))
      comment: "Total cost allocated across all allocation records. Primary metric for indirect cost recovery and shared cost governance."
    - name: "avg_allocation_rate"
      expr: AVG(CAST(allocation_rate AS DOUBLE))
      comment: "Average allocation rate applied. Validates consistency with negotiated NICRA rates and donor-approved overhead percentages."
    - name: "total_allocation_basis_quantity"
      expr: SUM(CAST(allocation_basis_quantity AS DOUBLE))
      comment: "Total allocation basis quantity (e.g., total headcount, square footage) used to drive cost allocations. Validates allocation base integrity."
    - name: "fa_cost_allocated_amount"
      expr: SUM(CASE WHEN is_fa_cost = TRUE THEN allocated_amount ELSE 0 END)
      comment: "Total F&A (facilities and administrative) costs allocated. Core metric for NICRA rate calculation and donor overhead reporting."
    - name: "restricted_fund_allocated_amount"
      expr: SUM(CASE WHEN is_restricted_fund = TRUE THEN allocated_amount ELSE 0 END)
      comment: "Total costs allocated to restricted donor funds. Monitors restricted fund overhead compliance."
    - name: "compliance_flagged_allocation_count"
      expr: COUNT(CASE WHEN compliance_flag = TRUE THEN 1 END)
      comment: "Number of cost allocations with compliance flags. Non-zero counts represent NICRA audit findings risk."
    - name: "allocation_count"
      expr: COUNT(1)
      comment: "Total number of cost allocation transactions. Baseline metric for allocation activity volume and process efficiency."
    - name: "compliance_flag_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cost allocations with compliance flags. A rate above 0% is a NICRA audit risk indicator."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`finance_grant_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Grant budget performance metrics for award financial management, cost-share tracking, and donor compliance. Monitors total award amounts, direct vs. indirect cost splits, NICRA rate application, and budget modification activity. Aligned with USAID, UN, and EU grant financial reporting requirements (eTools, InSight, RAM)."
  source: "`vibe_ngo_v1`.`finance`.`budget`"
  dimensions:
    - name: "budget_status"
      expr: CAST(budget_status AS STRING)
      comment: "Current status of the grant budget (e.g., draft, approved, closed) — drives grant portfolio pipeline reporting."
  measures:
    - name: "total_direct_cost_budget"
      expr: SUM(CAST(direct_cost_budget AS DOUBLE))
      comment: "Total direct program cost budget across grants. Used to assess program delivery investment."
    - name: "total_indirect_cost_budget"
      expr: SUM(CAST(indirect_cost_budget AS DOUBLE))
      comment: "Total indirect cost (ICR/overhead) budget across grants. Compared against NICRA rate caps."
    - name: "grant_budget_count"
      expr: COUNT(1)
      comment: "Total number of grant budgets. Baseline metric for grant portfolio breadth."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`finance_fund`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fund accounting metrics for restricted and unrestricted fund management, compliance monitoring, and donor reporting. Tracks fund balances, expenditure rates, match fulfillment, and audit requirements. Core to NGO fund accounting (SAP Fund Management, Blackbaud Financial Edge NXT)."
  source: "`vibe_ngo_v1`.`finance`.`finance_fund`"
  dimensions:
    - name: "fund_type"
      expr: fund_type
      comment: "Fund type classification (e.g., restricted, unrestricted, temporarily restricted, endowment) — fundamental for net asset reporting."
    - name: "fund_status"
      expr: fund_status
      comment: "Current status of the fund (e.g., active, closed, suspended) — drives fund portfolio management."
    - name: "restriction_type"
      expr: restriction_type
      comment: "Donor restriction type — determines allowable uses and reporting requirements."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Boolean flag indicating a fund compliance issue — flagged funds require immediate donor notification and remediation."
    - name: "audit_required_flag"
      expr: audit_required_flag
      comment: "Indicates whether the fund requires a separate audit — drives audit planning and resource allocation."
    - name: "donor_reporting_frequency"
      expr: donor_reporting_frequency
      comment: "Frequency of donor financial reporting required for the fund — informs reporting calendar and staff workload."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual fund performance reporting."
    - name: "program_code"
      expr: program_code
      comment: "Program code linking the fund to a specific humanitarian program."
    - name: "effective_start_date_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the fund became effective — used for fund lifecycle and portfolio age analysis."
  measures:
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budgeted amount across all funds. Represents the total authorized funding envelope."
    - name: "total_expended_amount"
      expr: SUM(CAST(expended_amount AS DOUBLE))
      comment: "Total amount expended from funds. Primary expenditure metric for fund utilization reporting."
    - name: "total_committed_amount"
      expr: SUM(CAST(committed_amount AS DOUBLE))
      comment: "Total committed (obligated but not yet expended) amount. Represents future cash outflow obligations."
    - name: "total_current_balance"
      expr: SUM(CAST(current_balance AS DOUBLE))
      comment: "Total current fund balance. The primary liquidity metric for fund portfolio management."
    - name: "total_match_requirement"
      expr: SUM(CAST(match_requirement_percentage AS DOUBLE))
      comment: "Total match requirement percentage across funds. Tracks co-financing obligation scope."
    - name: "total_match_fulfilled"
      expr: SUM(CAST(match_fulfilled_amount AS DOUBLE))
      comment: "Total match amount fulfilled. Compared against match requirements to assess co-financing compliance."
    - name: "fund_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(expended_amount AS DOUBLE)) / NULLIF(SUM(CAST(budget_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of budgeted funds expended. A key absorption rate metric — low utilization late in a period signals underspend risk and potential donor clawback."
    - name: "avg_indirect_cost_rate"
      expr: AVG(CAST(indirect_cost_rate AS DOUBLE))
      comment: "Average indirect cost rate applied across funds. Validates NICRA rate consistency across the fund portfolio."
    - name: "compliance_flagged_fund_count"
      expr: COUNT(CASE WHEN compliance_flag = TRUE THEN 1 END)
      comment: "Number of funds with compliance flags. Any non-zero count requires immediate donor notification and remediation planning."
    - name: "audit_required_fund_count"
      expr: COUNT(CASE WHEN audit_required_flag = TRUE THEN 1 END)
      comment: "Number of funds requiring separate audits. Drives audit planning, resource allocation, and external auditor engagement."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`finance_nicra_rate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "NICRA (Negotiated Indirect Cost Rate Agreement) metrics for indirect cost recovery governance and compliance. Tracks negotiated rates, facilities and administrative rates, fringe benefit rates, and agreement status. Critical for USAID and US federal grant compliance (2 CFR 200 Subpart E)."
  source: "`vibe_ngo_v1`.`finance`.`nicra_rate`"
  dimensions:
    - name: "rate_type"
      expr: rate_type
      comment: "NICRA rate type (e.g., predetermined, fixed, provisional) — determines how rates are applied and adjusted."
    - name: "rate_category"
      expr: rate_category
      comment: "Rate category (e.g., on-campus, off-campus, other sponsored) for rate applicability analysis."
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the NICRA agreement (e.g., active, expired, pending) — expired agreements create compliance risk."
    - name: "is_active"
      expr: is_active
      comment: "Indicates whether the NICRA rate is currently active — inactive rates should not be applied to new awards."
    - name: "de_minimis_rate_flag"
      expr: de_minimis_rate_flag
      comment: "Flags organizations using the de minimis 10% MTDC rate — relevant for smaller NGOs without a negotiated rate."
    - name: "cost_base_type"
      expr: cost_base_type
      comment: "Cost base type used for indirect cost calculation (e.g., MTDC, TDC, salaries) — must align with 2 CFR 200 definitions."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the NICRA rate for year-over-year rate trend analysis."
    - name: "cognizant_agency_name"
      expr: cognizant_agency_name
      comment: "Name of the cognizant federal agency (e.g., USAID, HHS) that negotiated the rate — informs compliance jurisdiction."
    - name: "effective_start_date_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the NICRA rate became effective — used for rate timeline and transition planning."
  measures:
    - name: "avg_rate_percentage"
      expr: AVG(CAST(rate_percentage AS DOUBLE))
      comment: "Average negotiated indirect cost rate percentage. Benchmarks overhead recovery against sector norms and donor caps."
    - name: "avg_administrative_rate"
      expr: AVG(CAST(administrative_rate AS DOUBLE))
      comment: "Average administrative cost rate. Monitors administrative overhead levels against donor expectations."
    - name: "avg_facilities_rate"
      expr: AVG(CAST(facilities_rate AS DOUBLE))
      comment: "Average facilities cost rate. Tracks facilities overhead recovery across NICRA agreements."
    - name: "avg_fringe_benefit_rate"
      expr: AVG(CAST(fringe_benefit_rate AS DOUBLE))
      comment: "Average fringe benefit rate. Used for staff cost budgeting and payroll cost allocation accuracy."
    - name: "total_carryforward_adjustment"
      expr: SUM(CAST(carryforward_adjustment_amount AS DOUBLE))
      comment: "Total carryforward adjustment amounts from prior NICRA periods. Tracks cumulative rate true-up obligations."
    - name: "active_rate_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Number of currently active NICRA rates. Organizations should have exactly one active rate per applicable category — multiple active rates signal a governance issue."
    - name: "expired_rate_count"
      expr: COUNT(CASE WHEN agreement_status = 'expired' THEN 1 END)
      comment: "Number of expired NICRA agreements. Expired agreements without successors create compliance risk for ongoing awards."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`finance_bank_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bank transaction metrics for cash flow analysis, reconciliation monitoring, and financial control. Tracks transaction volumes, credit/debit flows, running balances, and reconciliation status. Supports NGO treasury management and donor fund segregation (SAP bank accounting, ICON treasury)."
  source: "`vibe_ngo_v1`.`finance`.`bank_transaction`"
  dimensions:
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of bank transaction (e.g., payment, receipt, transfer, fee) for cash flow categorization."
    - name: "transaction_status"
      expr: transaction_status
      comment: "Current status of the transaction (e.g., pending, cleared, reversed) — drives reconciliation completeness monitoring."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Bank reconciliation status of the transaction — unreconciled transactions represent a financial control gap."
    - name: "is_indirect_cost"
      expr: is_indirect_cost
      comment: "Flags transactions representing indirect/overhead costs — used for NICRA base calculation."
    - name: "is_restricted_fund"
      expr: is_restricted_fund
      comment: "Indicates the transaction is associated with a restricted donor fund — requires compliance with donor use restrictions."
    - name: "restriction_type"
      expr: restriction_type
      comment: "Donor restriction type on the transaction — informs fund accounting classification."
    - name: "transaction_date_month"
      expr: DATE_TRUNC('month', transaction_date)
      comment: "Month of transaction date for cash flow trend analysis."
    - name: "value_date_month"
      expr: DATE_TRUNC('month', value_date)
      comment: "Month of value date (actual settlement date) for cash position reporting."
  measures:
    - name: "total_transaction_amount"
      expr: SUM(CAST(transaction_amount AS DOUBLE))
      comment: "Total transaction amount across all bank transactions. Primary cash flow volume metric."
    - name: "total_credit_amount"
      expr: SUM(CAST(credit_amount AS DOUBLE))
      comment: "Total credit (inflow) amount. Represents cash received from donors, grantors, and other sources."
    - name: "total_debit_amount"
      expr: SUM(CAST(debit_amount AS DOUBLE))
      comment: "Total debit (outflow) amount. Represents cash disbursed for program activities, vendor payments, and operations."
    - name: "net_cash_flow"
      expr: SUM(CAST(credit_amount AS DOUBLE) - CAST(debit_amount AS DOUBLE))
      comment: "Net cash flow (credits minus debits). The primary treasury metric for cash position management."
    - name: "unreconciled_transaction_count"
      expr: COUNT(CASE WHEN reconciliation_status != 'reconciled' THEN 1 END)
      comment: "Number of unreconciled bank transactions. High counts signal reconciliation backlogs and financial control weaknesses."
    - name: "restricted_fund_transaction_amount"
      expr: SUM(CASE WHEN is_restricted_fund = TRUE THEN transaction_amount ELSE 0 END)
      comment: "Total transaction amount associated with restricted donor funds. Monitors restricted fund cash flows for compliance."
    - name: "transaction_count"
      expr: COUNT(1)
      comment: "Total number of bank transactions. Baseline volume metric for cash activity and reconciliation workload."
    - name: "avg_running_balance"
      expr: AVG(CAST(running_balance AS DOUBLE))
      comment: "Average running bank balance across transactions. Monitors liquidity levels and minimum balance compliance."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`finance_exchange_rate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Foreign exchange rate metrics for multi-currency financial management, FX risk monitoring, and donor rate compliance. Tracks rate variances, UN operational rates, and donor-required rates. Critical for NGOs operating in multiple currencies with donor-specific rate requirements (UN operational rates, OANDA, Bloomberg)."
  source: "`vibe_ngo_v1`.`finance`.`exchange_rate`"
  dimensions:
    - name: "rate_type"
      expr: rate_type
      comment: "Exchange rate type (e.g., spot, average, UN operational, donor-required) — determines applicability for different transaction types."
    - name: "rate_status"
      expr: rate_status
      comment: "Current status of the exchange rate (e.g., active, expired, superseded) — expired rates must not be applied to new transactions."
    - name: "rate_source"
      expr: rate_source
      comment: "Source of the exchange rate (e.g., UN Treasury, central bank, Bloomberg) — informs rate governance and audit defensibility."
    - name: "un_operational_rate_flag"
      expr: un_operational_rate_flag
      comment: "Identifies UN operational rates — required for UN agency grant reporting and FACE form submissions."
    - name: "donor_required_rate_flag"
      expr: donor_required_rate_flag
      comment: "Flags donor-mandated exchange rates — non-compliance with donor rate requirements is an audit finding."
    - name: "mid_market_rate_flag"
      expr: mid_market_rate_flag
      comment: "Identifies mid-market rates — used as benchmarks for FX spread analysis."
    - name: "approval_required_flag"
      expr: approval_required_flag
      comment: "Indicates whether the rate requires approval before use — unapproved rates represent a financial control gap."
    - name: "effective_date_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the exchange rate became effective — used for rate trend and FX exposure analysis."
    - name: "usage_context"
      expr: usage_context
      comment: "Context in which the rate is used (e.g., transaction, reporting, revaluation) — informs rate governance."
  measures:
    - name: "avg_exchange_rate_value"
      expr: AVG(CAST(value AS DOUBLE))
      comment: "Average exchange rate value across selected rates. Benchmarks FX rate levels for budget planning and variance analysis."
    - name: "avg_variance_from_prior_rate"
      expr: AVG(CAST(variance_from_prior_rate AS DOUBLE))
      comment: "Average variance from the prior exchange rate. Monitors FX rate volatility — high variance increases financial reporting risk."
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average percentage variance from prior rates. A key FX risk metric — large percentage variances trigger revaluation and budget revision needs."
    - name: "avg_spread_percentage"
      expr: AVG(CAST(spread_percentage AS DOUBLE))
      comment: "Average FX spread percentage. Monitors transaction cost efficiency and bank FX pricing."
    - name: "avg_inverse_rate"
      expr: AVG(CAST(inverse_rate_value AS DOUBLE))
      comment: "Average inverse exchange rate. Used for reverse currency conversion validation and rate consistency checks."
    - name: "active_rate_count"
      expr: COUNT(CASE WHEN rate_status = 'active' THEN 1 END)
      comment: "Number of currently active exchange rates. Ensures adequate rate coverage for all operational currencies."
    - name: "donor_required_rate_count"
      expr: COUNT(CASE WHEN donor_required_rate_flag = TRUE THEN 1 END)
      comment: "Number of donor-mandated exchange rates in use. Tracks compliance with donor-specific rate requirements."
    - name: "unapproved_rate_count"
      expr: COUNT(CASE WHEN approval_required_flag = TRUE AND rate_status != 'approved' THEN 1 END)
      comment: "Number of rates requiring approval that have not yet been approved. Unapproved rates applied to transactions create audit findings."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`finance_fund_compliance_tracking`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Donor fund compliance tracking metrics for requirement fulfillment monitoring, waiver management, and audit readiness. Tracks compliance status across donor requirements, waiver activity, and verification timelines. Essential for NGO donor compliance programs and single audit preparation."
  source: "`vibe_ngo_v1`.`finance`.`fund_compliance_tracking`"
  dimensions:
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status (e.g., compliant, non-compliant, pending, waived) — drives compliance risk prioritization."
    - name: "waiver_status"
      expr: waiver_status
      comment: "Status of any waiver request (e.g., pending, approved, denied) — approved waivers reduce compliance risk; denied waivers require remediation."
    - name: "requirement_applicability_start_month"
      expr: DATE_TRUNC('month', requirement_applicability_start_date)
      comment: "Month the donor requirement became applicable — used for compliance timeline analysis."
    - name: "requirement_applicability_end_month"
      expr: DATE_TRUNC('month', requirement_applicability_end_date)
      comment: "Month the donor requirement expires — used for compliance calendar and renewal planning."
    - name: "last_verification_date_month"
      expr: DATE_TRUNC('month', last_verification_date)
      comment: "Month of last compliance verification — stale verification dates indicate compliance monitoring gaps."
  measures:
    - name: "total_compliance_tracking_records"
      expr: COUNT(1)
      comment: "Total number of fund compliance tracking records. Baseline metric for compliance monitoring portfolio breadth."
    - name: "non_compliant_count"
      expr: COUNT(CASE WHEN compliance_status = 'non-compliant' THEN 1 END)
      comment: "Number of non-compliant fund requirements. Any non-zero count represents active donor compliance risk requiring immediate remediation."
    - name: "pending_waiver_count"
      expr: COUNT(CASE WHEN waiver_status = 'pending' THEN 1 END)
      comment: "Number of pending waiver requests. Pending waivers represent unresolved compliance risk — requires follow-up with donors."
    - name: "non_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_status = 'non-compliant' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of tracked requirements in non-compliant status. A key donor audit risk metric — any non-zero rate requires escalation to leadership."
    - name: "waiver_approval_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN waiver_status = 'approved' THEN 1 END) / NULLIF(COUNT(CASE WHEN waiver_status IN ('approved', 'denied') THEN 1 END), 0), 2)
      comment: "Percentage of waiver requests that were approved. Low approval rates indicate donor inflexibility or weak waiver justifications."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`finance_budget_version`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Budget version control metrics for tracking budget modifications, approval workflows, and version lifecycle management. Monitors baseline vs. revised budgets, lock status, and modification frequency. Supports donor prior approval compliance and budget governance."
  source: "`vibe_ngo_v1`.`finance`.`budget_version`"
  dimensions:
    - name: "budget_version_status"
      expr: budget_version_status
      comment: "Current status of the budget version (e.g., draft, submitted, approved, locked) — drives budget approval workflow monitoring."
    - name: "version_type"
      expr: version_type
      comment: "Type of budget version (e.g., original, amendment, reforecast) — tracks modification history and donor prior approval requirements."
    - name: "is_baseline"
      expr: is_baseline
      comment: "Identifies the baseline (original approved) budget version — baseline vs. current comparison drives variance analysis."
    - name: "is_locked"
      expr: is_locked
      comment: "Indicates whether the budget version is locked from further modification — locked versions are the authoritative financial plan."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the budget version for annual financial planning analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for sub-annual budget version tracking."
    - name: "effective_start_date_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the budget version became effective — used for version timeline analysis."
    - name: "approved_by"
      expr: approved_by
      comment: "Approver of the budget version — used for approval authority and segregation of duties monitoring."
  measures:
    - name: "total_budget_amount"
      expr: SUM(CAST(total_budget_amount AS DOUBLE))
      comment: "Total budget amount across all versions. Tracks cumulative budget evolution from baseline to current."
    - name: "total_expense_budget"
      expr: SUM(CAST(expense_budget_amount AS DOUBLE))
      comment: "Total expense budget amount. Primary expenditure planning metric for financial management."
    - name: "total_revenue_budget"
      expr: SUM(CAST(revenue_budget_amount AS DOUBLE))
      comment: "Total revenue budget amount. Tracks expected income against expense plans for surplus/deficit forecasting."
    - name: "budget_version_count"
      expr: COUNT(1)
      comment: "Total number of budget versions. High version counts indicate frequent modifications — may signal scope instability or donor prior approval issues."
    - name: "amendment_version_count"
      expr: COUNT(CASE WHEN version_type = 'amendment' THEN 1 END)
      comment: "Number of amendment budget versions. Tracks donor prior approval activity and budget modification frequency."
    - name: "locked_version_count"
      expr: COUNT(CASE WHEN is_locked = TRUE THEN 1 END)
      comment: "Number of locked budget versions. Locked versions represent finalized financial plans — ratio to total versions indicates governance maturity."
    - name: "avg_total_budget_amount"
      expr: AVG(CAST(total_budget_amount AS DOUBLE))
      comment: "Average budget amount per version. Benchmarks typical budget size for resource planning."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`finance_face_form`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "FACE (Funding Authorization and Certificate of Expenditure) form metrics for UN agency grant financial reporting. Tracks authorized amounts, expenditures, liquidations, and balances for UNDP/UNICEF/UNFPA implementing partner financial reporting. Aligned with HACT (Harmonized Approach to Cash Transfers) framework."
  source: "`vibe_ngo_v1`.`finance`.`finance_face_form`"
  dimensions:
    - name: "face_form_status"
      expr: face_form_status
      comment: "Current status of the FACE form (e.g., draft, submitted, certified, approved) — drives UN agency reporting completeness monitoring."
    - name: "ip_transfer_modality"
      expr: ip_transfer_modality
      comment: "Implementing partner transfer modality (e.g., direct cash transfer, direct payment, reimbursement) — determines HACT risk and reporting requirements."
    - name: "certified_flag"
      expr: certified_flag
      comment: "Indicates whether the FACE form has been certified by the implementing partner — uncertified forms cannot be submitted to UN agencies."
    - name: "reporting_quarter"
      expr: reporting_quarter
      comment: "Reporting quarter for quarterly FACE form submission tracking."
    - name: "reporting_period_start_month"
      expr: DATE_TRUNC('month', reporting_period_start_date)
      comment: "Month the FACE form reporting period starts — used for UN agency reporting calendar management."
    - name: "reporting_period_end_month"
      expr: DATE_TRUNC('month', reporting_period_end_date)
      comment: "Month the FACE form reporting period ends — used for submission deadline tracking."
  measures:
    - name: "total_authorized_amount"
      expr: SUM(CAST(authorized_amount AS DOUBLE))
      comment: "Total amount authorized for disbursement across FACE forms. Represents UN agency cash transfer commitments to implementing partners."
    - name: "total_expenditure_amount"
      expr: SUM(CAST(expenditure_amount AS DOUBLE))
      comment: "Total expenditure reported on FACE forms. Primary metric for UN agency grant utilization reporting."
    - name: "total_liquidated_amount"
      expr: SUM(CAST(liquidated_amount AS DOUBLE))
      comment: "Total amount liquidated (reconciled against advances) on FACE forms. Tracks advance clearance and financial accountability."
    - name: "total_balance_amount"
      expr: SUM(CAST(balance_amount AS DOUBLE))
      comment: "Total outstanding balance on FACE forms. Represents unliquidated advances requiring future reporting."
    - name: "expenditure_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(expenditure_amount AS DOUBLE)) / NULLIF(SUM(CAST(authorized_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of authorized funds expended. A key HACT absorption metric — low utilization triggers UN agency programme review."
    - name: "liquidation_rate"
      expr: ROUND(100.0 * SUM(CAST(liquidated_amount AS DOUBLE)) / NULLIF(SUM(CAST(authorized_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of authorized advances liquidated. Low liquidation rates indicate advance management weaknesses and HACT compliance risk."
    - name: "face_form_count"
      expr: COUNT(1)
      comment: "Total number of FACE forms. Baseline metric for UN agency reporting volume and implementing partner portfolio size."
    - name: "uncertified_form_count"
      expr: COUNT(CASE WHEN certified_flag = FALSE THEN 1 END)
      comment: "Number of FACE forms not yet certified. Uncertified forms cannot be submitted to UN agencies — a reporting completeness risk."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`finance_budget_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Budget execution and variance metrics for financial planning, grant compliance, and resource allocation decisions"
  source: "`vibe_ngo_v1`.`finance`.`budget`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the budget"
    - name: "budget_status"
      expr: budget_status
      comment: "Current status of the budget"
    - name: "budget_type"
      expr: budget_type
      comment: "Type of budget (e.g., program, operational, grant)"
    - name: "program_code"
      expr: program_code
      comment: "Program associated with the budget"
    - name: "period_start_date"
      expr: period_start_date
      comment: "Start date of budget period"
    - name: "period_end_date"
      expr: period_end_date
      comment: "End date of budget period"
    - name: "approving_authority"
      expr: approving_authority
      comment: "Authority that approved the budget"
  measures:
    - name: "total_approved_budget"
      expr: SUM(CAST(total_approved_amount AS DOUBLE))
      comment: "Total approved budget amount for planning baseline"
    - name: "total_actual_expenditure"
      expr: SUM(CAST(total_actual_expenditure AS DOUBLE))
      comment: "Total actual spending against budgets"
    - name: "total_budget_variance"
      expr: SUM(CAST(total_variance_amount AS DOUBLE))
      comment: "Total variance between approved and actual for performance monitoring"
    - name: "total_direct_cost_budget"
      expr: SUM(CAST(direct_cost_budget AS DOUBLE))
      comment: "Total direct cost budget allocation"
    - name: "total_indirect_cost_budget"
      expr: SUM(CAST(indirect_cost_budget AS DOUBLE))
      comment: "Total indirect cost budget allocation"
    - name: "avg_burn_rate_percentage"
      expr: AVG(CAST(burn_rate_percentage AS DOUBLE))
      comment: "Average budget burn rate for pacing analysis"
    - name: "budget_count"
      expr: COUNT(1)
      comment: "Number of active budgets"
    - name: "avg_icr_rate_applied"
      expr: AVG(CAST(icr_rate_applied AS DOUBLE))
      comment: "Average indirect cost recovery rate applied"
$$;