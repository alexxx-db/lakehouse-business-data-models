-- Metric views for domain: finance | Business: Pharmaceuticals | Version: 1 | Generated on: 2026-05-05 17:46:18

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`finance_accounts_payable`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts payable metrics tracking vendor payment obligations, cash flow timing, and payment efficiency"
  source: "`pharmaceuticals_ecm`.`finance`.`accounts_payable`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Current payment status of the invoice (paid, pending, overdue)"
    - name: "vendor_category"
      expr: vendor_category
      comment: "Category of vendor for spend analysis"
    - name: "therapeutic_area"
      expr: therapeutic_area
      comment: "Therapeutic area for R&D and product cost allocation"
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of invoice (standard, credit memo, debit memo)"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for period-over-period analysis"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly/quarterly tracking"
    - name: "company_code"
      expr: company_code
      comment: "Company code for multi-entity reporting"
    - name: "is_rd_capitalized"
      expr: is_rd_capitalized
      comment: "Flag indicating if expense is capitalized R&D"
    - name: "invoice_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Invoice month for time-series analysis"
  measures:
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross invoice amount before discounts and taxes"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net payable amount after discounts"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early payment discounts captured"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on payables"
    - name: "avg_payment_cycle_days"
      expr: AVG(CAST(DATEDIFF(payment_date, invoice_date) AS DOUBLE))
      comment: "Average days from invoice to payment (cash conversion efficiency)"
    - name: "discount_capture_rate"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of available discounts captured (working capital efficiency)"
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Total number of payable invoices"
    - name: "unique_vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique vendors with payables"
$$;


CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`finance_accounts_receivable`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts receivable metrics tracking customer payment performance, revenue collection, and credit risk"
  source: "`pharmaceuticals_ecm`.`finance`.`accounts_receivable`"
  dimensions:
    - name: "ar_status"
      expr: ar_status
      comment: "Current AR status (open, cleared, written off)"
    - name: "customer_segment"
      expr: customer_segment
      comment: "Customer segment for receivables analysis"
    - name: "therapeutic_area"
      expr: therapeutic_area
      comment: "Therapeutic area for product revenue tracking"
    - name: "sales_territory"
      expr: sales_territory
      comment: "Sales territory for regional collection performance"
    - name: "days_overdue"
      expr: days_overdue
      comment: "Days overdue bucket for aging analysis"
    - name: "dunning_level"
      expr: dunning_level
      comment: "Dunning level indicating collection escalation stage"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for period analysis"
    - name: "revenue_recognition_type"
      expr: revenue_recognition_type
      comment: "Revenue recognition method (point-in-time, over-time)"
    - name: "billing_month"
      expr: DATE_TRUNC('MONTH', billing_date)
      comment: "Billing month for time-series revenue analysis"
  measures:
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross receivable amount before adjustments"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net receivable amount after adjustments"
    - name: "total_open_amount"
      expr: SUM(CAST(open_amount AS DOUBLE))
      comment: "Total outstanding receivable balance (key liquidity metric)"
    - name: "total_chargeback_amount"
      expr: SUM(CAST(chargeback_amount AS DOUBLE))
      comment: "Total chargeback deductions from gross to net sales"
    - name: "total_rebate_amount"
      expr: SUM(CAST(rebate_amount AS DOUBLE))
      comment: "Total rebate deductions impacting net revenue"
    - name: "avg_days_to_collect"
      expr: AVG(CAST(DATEDIFF(payment_receipt_date, billing_date) AS DOUBLE))
      comment: "Average days from billing to payment receipt (DSO proxy)"
    - name: "collection_effectiveness"
      expr: ROUND(100.0 * (SUM(CAST(gross_amount AS DOUBLE)) - SUM(CAST(open_amount AS DOUBLE))) / NULLIF(SUM(CAST(gross_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of billed amount collected (collection efficiency KPI)"
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Total number of receivable invoices"
    - name: "unique_customer_count"
      expr: COUNT(DISTINCT business_partner_id)
      comment: "Number of unique customers with receivables"
$$;


CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`finance_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Budget performance metrics tracking planned vs actual spend, variance analysis, and budget utilization across cost centers and programs"
  source: "`pharmaceuticals_ecm`.`finance`.`budget`"
  dimensions:
    - name: "budget_type"
      expr: budget_type
      comment: "Type of budget (operating, capital, R&D)"
    - name: "budget_category"
      expr: budget_category
      comment: "Budget category for spend classification"
    - name: "budget_status"
      expr: budget_status
      comment: "Current budget status (draft, approved, active, closed)"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual budget tracking"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly/quarterly budget monitoring"
    - name: "company_code"
      expr: company_code
      comment: "Company code for multi-entity budget consolidation"
    - name: "is_capitalized"
      expr: is_capitalized
      comment: "Flag indicating if budget is for capitalized assets"
    - name: "capitalization_stage"
      expr: capitalization_stage
      comment: "Development stage for R&D capitalization tracking"
    - name: "geography_code"
      expr: geography_code
      comment: "Geographic region for regional budget analysis"
  measures:
    - name: "total_planned_amount"
      expr: SUM(CAST(planned_amount AS DOUBLE))
      comment: "Total planned budget allocation"
    - name: "total_actual_amount"
      expr: SUM(CAST(actual_amount AS DOUBLE))
      comment: "Total actual spend against budget"
    - name: "total_committed_amount"
      expr: SUM(CAST(committed_amount AS DOUBLE))
      comment: "Total committed but not yet spent amount"
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total budget variance (actual minus planned)"
    - name: "budget_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_amount AS DOUBLE)) / NULLIF(SUM(CAST(planned_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of budget utilized (spend efficiency KPI)"
    - name: "budget_remaining"
      expr: SUM((CAST(planned_amount AS DOUBLE)) - (CAST(actual_amount AS DOUBLE)))
      comment: "Total remaining budget available for allocation"
    - name: "avg_variance_pct"
      expr: AVG(CAST(variance_pct AS DOUBLE))
      comment: "Average variance percentage across budget lines"
    - name: "budget_line_count"
      expr: COUNT(1)
      comment: "Total number of budget line items"
$$;


CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`finance_cogs_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost of goods sold metrics tracking manufacturing costs, cost variances, and product profitability by therapeutic area and production facility"
  source: "`pharmaceuticals_ecm`.`finance`.`cogs_entry`"
  dimensions:
    - name: "cost_component_type"
      expr: cost_component_type
      comment: "Type of cost component (material, labor, overhead)"
    - name: "costing_type"
      expr: costing_type
      comment: "Costing method (standard, actual, planned)"
    - name: "therapeutic_area"
      expr: therapeutic_area
      comment: "Therapeutic area for product cost analysis"
    - name: "brand_name"
      expr: brand_name
      comment: "Brand name for product-level profitability"
    - name: "market_country_code"
      expr: market_country_code
      comment: "Market country for geographic cost analysis"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual cost trending"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly cost tracking"
    - name: "cmo_indicator"
      expr: cmo_indicator
      comment: "Flag indicating contract manufacturing organization production"
    - name: "variance_category"
      expr: variance_category
      comment: "Category of cost variance for root cause analysis"
    - name: "posting_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Posting month for time-series cost analysis"
  measures:
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost_amount AS DOUBLE))
      comment: "Total actual cost of goods sold"
    - name: "total_standard_cost"
      expr: SUM(CAST(standard_cost_amount AS DOUBLE))
      comment: "Total standard cost baseline"
    - name: "total_material_cost"
      expr: SUM(CAST(material_cost_amount AS DOUBLE))
      comment: "Total material cost component"
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost_amount AS DOUBLE))
      comment: "Total labor cost component"
    - name: "total_overhead_absorbed"
      expr: SUM(CAST(overhead_absorbed_amount AS DOUBLE))
      comment: "Total overhead allocated to production"
    - name: "total_cost_variance"
      expr: SUM(CAST(cost_variance_amount AS DOUBLE))
      comment: "Total cost variance (actual minus standard)"
    - name: "total_quantity_produced"
      expr: SUM(CAST(quantity_produced AS DOUBLE))
      comment: "Total units produced"
    - name: "avg_cost_per_unit"
      expr: AVG(CAST(cost_per_unit AS DOUBLE))
      comment: "Average cost per unit produced"
    - name: "cost_variance_rate"
      expr: ROUND(100.0 * SUM(CAST(cost_variance_amount AS DOUBLE)) / NULLIF(SUM(CAST(standard_cost_amount AS DOUBLE)), 0), 2)
      comment: "Cost variance as percentage of standard cost (manufacturing efficiency KPI)"
    - name: "cogs_entry_count"
      expr: COUNT(1)
      comment: "Total number of COGS entries"
$$;


CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`finance_fixed_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fixed asset metrics tracking capital investment, depreciation, asset utilization, and GMP-critical equipment for pharmaceutical operations"
  source: "`pharmaceuticals_ecm`.`finance`.`fixed_asset`"
  dimensions:
    - name: "asset_class_code"
      expr: asset_class_code
      comment: "Asset class for capital allocation analysis"
    - name: "asset_status"
      expr: asset_status
      comment: "Current asset status (active, retired, under construction)"
    - name: "company_code"
      expr: company_code
      comment: "Company code for multi-entity asset tracking"
    - name: "is_gmp_critical"
      expr: is_gmp_critical
      comment: "Flag indicating GMP-critical equipment requiring validation"
    - name: "is_rd_equipment"
      expr: is_rd_equipment
      comment: "Flag indicating R&D equipment for innovation investment tracking"
    - name: "business_area_code"
      expr: business_area_code
      comment: "Business area for asset allocation by function"
    - name: "acquisition_year"
      expr: YEAR(acquisition_date)
      comment: "Year of acquisition for capital investment trending"
  measures:
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total capital invested in fixed assets"
    - name: "total_net_book_value"
      expr: SUM(CAST(net_book_value AS DOUBLE))
      comment: "Total current book value of asset base"
    - name: "total_accumulated_depreciation"
      expr: SUM(CAST(accumulated_depreciation AS DOUBLE))
      comment: "Total depreciation charged to date"
    - name: "total_insured_value"
      expr: SUM(CAST(insured_value AS DOUBLE))
      comment: "Total insured value of asset portfolio"
    - name: "avg_remaining_useful_life"
      expr: AVG(CAST(remaining_useful_life_years AS DOUBLE))
      comment: "Average remaining useful life in years (asset refresh planning metric)"
    - name: "depreciation_rate"
      expr: ROUND(100.0 * SUM(CAST(accumulated_depreciation AS DOUBLE)) / NULLIF(SUM(CAST(acquisition_cost AS DOUBLE)), 0), 2)
      comment: "Percentage of asset base depreciated (asset age indicator)"
    - name: "asset_count"
      expr: COUNT(1)
      comment: "Total number of fixed assets"
    - name: "avg_asset_age_years"
      expr: AVG(CAST(DATEDIFF(CURRENT_DATE(), acquisition_date) AS DOUBLE) / 365.25)
      comment: "Average age of asset base in years (capital refresh urgency metric)"
$$;


CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`finance_general_ledger`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "General ledger metrics tracking account balances, period activity, and financial statement line items across the chart of accounts"
  source: "`pharmaceuticals_ecm`.`finance`.`general_ledger`"
  dimensions:
    - name: "account_type"
      expr: account_type
      comment: "Account type (asset, liability, equity, revenue, expense)"
    - name: "account_group"
      expr: account_group
      comment: "Account group for financial statement classification"
    - name: "company_code"
      expr: company_code
      comment: "Company code for multi-entity consolidation"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual financial reporting"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly/quarterly close"
    - name: "cost_center"
      expr: cost_center
      comment: "Cost center for departmental P&L"
    - name: "profit_center"
      expr: profit_center
      comment: "Profit center for business unit performance"
    - name: "balance_sheet_account"
      expr: balance_sheet_account
      comment: "Flag indicating balance sheet vs P&L account"
    - name: "sox_relevant"
      expr: sox_relevant
      comment: "Flag indicating SOX-relevant account requiring controls"
    - name: "rd_capitalization_flag"
      expr: rd_capitalization_flag
      comment: "Flag indicating R&D capitalization account"
    - name: "intercompany_flag"
      expr: intercompany_flag
      comment: "Flag indicating intercompany elimination account"
  measures:
    - name: "total_debit_amount"
      expr: SUM(CAST(debit_amount AS DOUBLE))
      comment: "Total debit activity in period"
    - name: "total_credit_amount"
      expr: SUM(CAST(credit_amount AS DOUBLE))
      comment: "Total credit activity in period"
    - name: "total_opening_balance"
      expr: SUM(CAST(opening_balance AS DOUBLE))
      comment: "Total opening balance for period"
    - name: "total_closing_balance"
      expr: SUM(CAST(closing_balance AS DOUBLE))
      comment: "Total closing balance for period (key financial position metric)"
    - name: "net_period_activity"
      expr: SUM((CAST(debit_amount AS DOUBLE)) - (CAST(credit_amount AS DOUBLE)))
      comment: "Net debit/credit activity in period"
    - name: "account_count"
      expr: COUNT(1)
      comment: "Total number of GL account records"
    - name: "unique_gl_account_count"
      expr: COUNT(DISTINCT gl_account_number)
      comment: "Number of unique GL accounts with activity"
$$;


CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`finance_intercompany_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Intercompany transaction metrics tracking cross-entity transfers, transfer pricing, elimination status, and SOX compliance for consolidation"
  source: "`pharmaceuticals_ecm`.`finance`.`intercompany_transaction`"
  dimensions:
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of intercompany transaction (goods, services, loan, royalty)"
    - name: "transaction_status"
      expr: transaction_status
      comment: "Current transaction status (posted, cleared, eliminated)"
    - name: "elimination_status"
      expr: elimination_status
      comment: "Consolidation elimination status for financial reporting"
    - name: "sending_company_code"
      expr: sending_company_code
      comment: "Sending legal entity for intercompany flow analysis"
    - name: "receiving_company_code"
      expr: receiving_company_code
      comment: "Receiving legal entity for intercompany flow analysis"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual intercompany reconciliation"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly intercompany close"
    - name: "sox_control_flag"
      expr: sox_control_flag
      comment: "Flag indicating SOX-controlled intercompany transaction"
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Flag indicating reversed transaction"
    - name: "therapeutic_area"
      expr: therapeutic_area
      comment: "Therapeutic area for product-level intercompany analysis"
    - name: "transaction_month"
      expr: DATE_TRUNC('MONTH', transaction_date)
      comment: "Transaction month for time-series intercompany trending"
  measures:
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross intercompany transaction value"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net intercompany amount after adjustments"
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total intercompany adjustments"
    - name: "total_withholding_tax"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax on intercompany transactions"
    - name: "total_group_currency_amount"
      expr: SUM(CAST(group_currency_amount AS DOUBLE))
      comment: "Total intercompany value in group reporting currency"
    - name: "avg_loan_interest_rate"
      expr: AVG(CAST(loan_interest_rate AS DOUBLE))
      comment: "Average interest rate on intercompany loans"
    - name: "transaction_count"
      expr: COUNT(1)
      comment: "Total number of intercompany transactions"
    - name: "unique_entity_pair_count"
      expr: COUNT(DISTINCT CONCAT(sending_company_code, '-', receiving_company_code))
      comment: "Number of unique intercompany trading relationships"
$$;


CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`finance_journal_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Journal entry metrics tracking posting activity, tax amounts, and subledger integration for financial close and audit trail"
  source: "`pharmaceuticals_ecm`.`finance`.`journal_entry`"
  dimensions:
    - name: "document_type"
      expr: document_type
      comment: "Type of journal entry document"
    - name: "posting_status"
      expr: posting_status
      comment: "Current posting status (posted, parked, reversed)"
    - name: "debit_credit_indicator"
      expr: debit_credit_indicator
      comment: "Debit or credit indicator for line item"
    - name: "company_code"
      expr: company_code
      comment: "Company code for multi-entity journal tracking"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual audit trail"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly close tracking"
    - name: "cost_center"
      expr: cost_center
      comment: "Cost center for departmental expense tracking"
    - name: "profit_center"
      expr: profit_center
      comment: "Profit center for business unit P&L"
    - name: "is_reversal"
      expr: is_reversal
      comment: "Flag indicating reversal entry"
    - name: "subledger_type"
      expr: subledger_type
      comment: "Subledger source (AP, AR, FA, inventory)"
    - name: "posting_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Posting month for time-series journal analysis"
  measures:
    - name: "total_transaction_amount"
      expr: SUM(CAST(amount_transaction_currency AS DOUBLE))
      comment: "Total journal entry amount in transaction currency"
    - name: "total_local_amount"
      expr: SUM(CAST(amount_local_currency AS DOUBLE))
      comment: "Total journal entry amount in local currency"
    - name: "total_group_amount"
      expr: SUM(CAST(amount_group_currency AS DOUBLE))
      comment: "Total journal entry amount in group reporting currency"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on journal entries"
    - name: "total_withholding_tax"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax on journal entries"
    - name: "journal_entry_count"
      expr: COUNT(1)
      comment: "Total number of journal entry line items"
    - name: "unique_document_count"
      expr: COUNT(DISTINCT document_number)
      comment: "Number of unique journal entry documents"
$$;


CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`finance_milestone_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Milestone payment metrics tracking development milestone achievements, licensing payments, and contingent liabilities for R&D partnerships"
  source: "`pharmaceuticals_ecm`.`finance`.`milestone_payment`"
  dimensions:
    - name: "milestone_type"
      expr: milestone_type
      comment: "Type of milestone (regulatory, development, commercial)"
    - name: "payment_status"
      expr: payment_status
      comment: "Current payment status (pending, paid, accrued)"
    - name: "payment_direction"
      expr: payment_direction
      comment: "Payment direction (inbound, outbound)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status for payment authorization"
    - name: "development_stage"
      expr: development_stage
      comment: "Development stage when milestone triggered"
    - name: "therapeutic_area"
      expr: therapeutic_area
      comment: "Therapeutic area for R&D investment tracking"
    - name: "is_capitalized"
      expr: is_capitalized
      comment: "Flag indicating if milestone payment is capitalized"
    - name: "is_contingent_liability"
      expr: is_contingent_liability
      comment: "Flag indicating contingent liability for financial reporting"
    - name: "accounting_treatment"
      expr: accounting_treatment
      comment: "Accounting treatment (expense, capitalize, liability)"
    - name: "triggering_event"
      expr: triggering_event
      comment: "Event that triggered milestone payment"
  measures:
    - name: "total_contractual_amount"
      expr: SUM(CAST(contractual_amount AS DOUBLE))
      comment: "Total contractual milestone payment amount"
    - name: "total_net_payment"
      expr: SUM(CAST(net_payment_amount AS DOUBLE))
      comment: "Total net milestone payment after withholding tax"
    - name: "total_withholding_tax"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax on milestone payments"
    - name: "total_functional_currency_amount"
      expr: SUM(CAST(functional_currency_amount AS DOUBLE))
      comment: "Total milestone payments in functional currency"
    - name: "avg_fx_rate"
      expr: AVG(CAST(fx_rate AS DOUBLE))
      comment: "Average foreign exchange rate for milestone payments"
    - name: "milestone_count"
      expr: COUNT(1)
      comment: "Total number of milestone payments"
    - name: "unique_project_count"
      expr: COUNT(DISTINCT project_id)
      comment: "Number of unique projects with milestone payments"
$$;


CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`finance_payment_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment run metrics tracking payment processing efficiency, reconciliation status, and cash disbursement execution"
  source: "`pharmaceuticals_ecm`.`finance`.`payment_run`"
  dimensions:
    - name: "status"
      expr: status
      comment: "Current payment run status (scheduled, executed, reconciled)"
    - name: "run_type"
      expr: run_type
      comment: "Type of payment run (automatic, manual, emergency)"
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method (wire, ACH, check, card)"
    - name: "payment_category"
      expr: payment_category
      comment: "Category of payments (vendor, employee, tax, other)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status for payment authorization"
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Bank reconciliation status"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual cash flow analysis"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly cash management"
    - name: "is_test_run"
      expr: is_test_run
      comment: "Flag indicating test payment run"
    - name: "execution_month"
      expr: DATE_TRUNC('MONTH', execution_timestamp)
      comment: "Execution month for time-series payment analysis"
  measures:
    - name: "total_payment_amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total amount disbursed in payment runs (key cash flow metric)"
    - name: "avg_payment_amount"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average payment run amount"
    - name: "total_payment_count"
      expr: SUM(CAST(payment_count AS DOUBLE))
      comment: "Total number of individual payments processed"
    - name: "total_error_count"
      expr: SUM(CAST(error_count AS DOUBLE))
      comment: "Total number of payment errors"
    - name: "payment_run_count"
      expr: COUNT(1)
      comment: "Total number of payment runs executed"
    - name: "avg_processing_time_days"
      expr: AVG(CAST(DATEDIFF(execution_timestamp, scheduled_date) AS DOUBLE))
      comment: "Average days from scheduled to execution (payment processing efficiency)"
    - name: "error_rate"
      expr: ROUND(100.0 * SUM(CAST(error_count AS DOUBLE)) / NULLIF(SUM(CAST(payment_count AS DOUBLE)), 0), 2)
      comment: "Payment error rate as percentage of total payments (quality metric)"
$$;


CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`finance_rd_capitalization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "R&D capitalization metrics tracking capitalized development costs, amortization, impairment, and asset lifecycle for pharmaceutical innovation investments"
  source: "`pharmaceuticals_ecm`.`finance`.`rd_capitalization`"
  dimensions:
    - name: "capitalization_type"
      expr: capitalization_type
      comment: "Type of R&D capitalization (IPR&D, development, regulatory)"
    - name: "capitalization_status"
      expr: capitalization_status
      comment: "Current status (active, fully amortized, impaired)"
    - name: "development_phase"
      expr: development_phase
      comment: "Development phase when capitalized (Phase I, II, III, NDA)"
    - name: "accounting_standard"
      expr: accounting_standard
      comment: "Accounting standard applied (US GAAP, IFRS)"
    - name: "amortization_method"
      expr: amortization_method
      comment: "Amortization method (straight-line, accelerated)"
    - name: "impairment_indicator"
      expr: impairment_indicator
      comment: "Flag indicating impairment assessment required"
    - name: "geography_code"
      expr: geography_code
      comment: "Geographic region for regional R&D investment"
    - name: "milestone_trigger"
      expr: milestone_trigger
      comment: "Milestone event that triggered capitalization"
    - name: "capitalization_year"
      expr: YEAR(capitalization_date)
      comment: "Year of capitalization for vintage analysis"
  measures:
    - name: "total_capitalized_amount"
      expr: SUM(CAST(capitalized_amount AS DOUBLE))
      comment: "Total R&D costs capitalized (key innovation investment metric)"
    - name: "total_net_book_value"
      expr: SUM(CAST(net_book_value AS DOUBLE))
      comment: "Total current book value of capitalized R&D assets"
    - name: "total_accumulated_amortization"
      expr: SUM(CAST(accumulated_amortization AS DOUBLE))
      comment: "Total amortization charged to date"
    - name: "total_annual_amortization"
      expr: SUM(CAST(annual_amortization_amount AS DOUBLE))
      comment: "Total annual amortization expense"
    - name: "total_impairment_loss"
      expr: SUM(CAST(impairment_loss_amount AS DOUBLE))
      comment: "Total impairment losses recognized (R&D failure cost)"
    - name: "avg_useful_life_years"
      expr: AVG(CAST(useful_life_years AS DOUBLE))
      comment: "Average useful life of capitalized R&D assets"
    - name: "capitalization_count"
      expr: COUNT(1)
      comment: "Total number of R&D capitalization records"
    - name: "unique_project_count"
      expr: COUNT(DISTINCT project_id)
      comment: "Number of unique projects with capitalized R&D"
    - name: "impairment_rate"
      expr: ROUND(100.0 * SUM(CAST(impairment_loss_amount AS DOUBLE)) / NULLIF(SUM(CAST(capitalized_amount AS DOUBLE)), 0), 2)
      comment: "Impairment as percentage of capitalized amount (R&D success rate proxy)"
$$;


CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`finance_royalty_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Royalty agreement metrics tracking licensing terms, royalty rates, minimum payments, and intellectual property monetization"
  source: "`pharmaceuticals_ecm`.`finance`.`royalty_agreement`"
  dimensions:
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of royalty agreement (in-license, out-license, cross-license)"
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current agreement status (active, expired, terminated)"
    - name: "royalty_rate_type"
      expr: royalty_rate_type
      comment: "Royalty rate structure (flat, tiered, milestone-based)"
    - name: "payment_frequency"
      expr: payment_frequency
      comment: "Frequency of royalty payments (monthly, quarterly, annual)"
    - name: "therapeutic_area"
      expr: therapeutic_area
      comment: "Therapeutic area for IP portfolio analysis"
    - name: "territory"
      expr: territory
      comment: "Geographic territory covered by agreement"
    - name: "sublicensing_rights_flag"
      expr: sublicensing_rights_flag
      comment: "Flag indicating sublicensing rights granted"
    - name: "audit_rights_flag"
      expr: audit_rights_flag
      comment: "Flag indicating audit rights for royalty verification"
    - name: "governing_law_country"
      expr: governing_law_country
      comment: "Country whose law governs the agreement"
  measures:
    - name: "avg_base_royalty_rate"
      expr: AVG(CAST(base_royalty_rate_pct AS DOUBLE))
      comment: "Average base royalty rate percentage"
    - name: "total_minimum_annual_royalty"
      expr: SUM(CAST(minimum_annual_royalty_amount AS DOUBLE))
      comment: "Total minimum annual royalty commitments"
    - name: "total_upfront_license_fee"
      expr: SUM(CAST(upfront_license_fee_amount AS DOUBLE))
      comment: "Total upfront license fees paid/received"
    - name: "avg_tier1_threshold"
      expr: AVG(CAST(tier1_threshold_amount AS DOUBLE))
      comment: "Average tier 1 sales threshold for tiered royalties"
    - name: "avg_tier2_royalty_rate"
      expr: AVG(CAST(tier2_royalty_rate_pct AS DOUBLE))
      comment: "Average tier 2 royalty rate percentage"
    - name: "avg_sublicense_royalty_rate"
      expr: AVG(CAST(sublicense_royalty_rate_pct AS DOUBLE))
      comment: "Average sublicense royalty rate percentage"
    - name: "avg_withholding_tax_rate"
      expr: AVG(CAST(withholding_tax_rate_pct AS DOUBLE))
      comment: "Average withholding tax rate on royalty payments"
    - name: "agreement_count"
      expr: COUNT(1)
      comment: "Total number of royalty agreements"
    - name: "unique_licensor_count"
      expr: COUNT(DISTINCT business_partner_id)
      comment: "Number of unique licensors/licensees"
$$;


CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`finance_tax_posting`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tax posting metrics tracking tax liabilities, deductibility, jurisdictional compliance, and tax return reconciliation"
  source: "`pharmaceuticals_ecm`.`finance`.`tax_posting`"
  dimensions:
    - name: "tax_type"
      expr: tax_type
      comment: "Type of tax (VAT, sales, withholding, excise)"
    - name: "posting_type"
      expr: posting_type
      comment: "Posting type (input tax, output tax, adjustment)"
    - name: "posting_status"
      expr: posting_status
      comment: "Current posting status (posted, cleared, reversed)"
    - name: "country_code"
      expr: country_code
      comment: "Country for jurisdictional tax analysis"
    - name: "tax_jurisdiction_code"
      expr: tax_jurisdiction_code
      comment: "Tax jurisdiction for compliance reporting"
    - name: "is_deductible"
      expr: is_deductible
      comment: "Flag indicating tax deductibility"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual tax return"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly/quarterly tax filing"
    - name: "tax_reporting_period"
      expr: tax_reporting_period
      comment: "Tax reporting period for return filing"
    - name: "therapeutic_area"
      expr: therapeutic_area
      comment: "Therapeutic area for product tax analysis"
    - name: "posting_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Posting month for time-series tax analysis"
  measures:
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount posted (key tax liability metric)"
    - name: "total_tax_base_amount"
      expr: SUM(CAST(tax_base_amount AS DOUBLE))
      comment: "Total tax base amount (taxable revenue/expense)"
    - name: "avg_tax_rate"
      expr: AVG(CAST(tax_rate AS DOUBLE))
      comment: "Average effective tax rate"
    - name: "avg_deductible_pct"
      expr: AVG(CAST(deductible_pct AS DOUBLE))
      comment: "Average deductibility percentage"
    - name: "effective_tax_rate"
      expr: ROUND(100.0 * SUM(CAST(tax_amount AS DOUBLE)) / NULLIF(SUM(CAST(tax_base_amount AS DOUBLE)), 0), 2)
      comment: "Effective tax rate as percentage of tax base (tax efficiency metric)"
    - name: "tax_posting_count"
      expr: COUNT(1)
      comment: "Total number of tax postings"
    - name: "unique_jurisdiction_count"
      expr: COUNT(DISTINCT tax_jurisdiction_code)
      comment: "Number of unique tax jurisdictions with activity"
$$;


CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`finance_transfer_price`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Transfer pricing metrics tracking intercompany pricing policies, arm's length compliance, markup rates, and tax authority documentation"
  source: "`pharmaceuticals_ecm`.`finance`.`transfer_price`"
  dimensions:
    - name: "pricing_method"
      expr: pricing_method
      comment: "Transfer pricing method (cost-plus, resale-minus, CUP, TNMM)"
    - name: "record_status"
      expr: record_status
      comment: "Current record status (active, expired, superseded)"
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of intercompany transaction (goods, services, IP)"
    - name: "product_type"
      expr: product_type
      comment: "Product type for transfer pricing segmentation"
    - name: "product_lifecycle_stage"
      expr: product_lifecycle_stage
      comment: "Product lifecycle stage affecting pricing"
    - name: "sending_country_code"
      expr: sending_country_code
      comment: "Sending country for cross-border pricing analysis"
    - name: "receiving_country_code"
      expr: receiving_country_code
      comment: "Receiving country for cross-border pricing analysis"
    - name: "therapeutic_area"
      expr: therapeutic_area
      comment: "Therapeutic area for product transfer pricing"
    - name: "withholding_tax_applicable"
      expr: withholding_tax_applicable
      comment: "Flag indicating withholding tax applies"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year transfer price became effective"
  measures:
    - name: "avg_approved_price"
      expr: AVG(CAST(approved_price AS DOUBLE))
      comment: "Average approved transfer price"
    - name: "avg_markup_pct"
      expr: AVG(CAST(markup_pct AS DOUBLE))
      comment: "Average markup percentage on cost base"
    - name: "avg_cost_base"
      expr: AVG(CAST(cost_base_amount AS DOUBLE))
      comment: "Average cost base for transfer pricing"
    - name: "avg_arm_length_range_min"
      expr: AVG(CAST(arm_length_range_min AS DOUBLE))
      comment: "Average minimum arm's length range"
    - name: "avg_arm_length_range_max"
      expr: AVG(CAST(arm_length_range_max AS DOUBLE))
      comment: "Average maximum arm's length range"
    - name: "avg_withholding_tax_rate"
      expr: AVG(CAST(withholding_tax_rate_pct AS DOUBLE))
      comment: "Average withholding tax rate on transfer prices"
    - name: "transfer_price_count"
      expr: COUNT(1)
      comment: "Total number of transfer price records"
    - name: "unique_product_count"
      expr: COUNT(DISTINCT drug_product_id)
      comment: "Number of unique products with transfer pricing"
    - name: "unique_country_pair_count"
      expr: COUNT(DISTINCT CONCAT(sending_country_code, '-', receiving_country_code))
      comment: "Number of unique country pairs with transfer pricing"
$$;


CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`finance_wbs_element`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Work breakdown structure metrics tracking project budgets, capital investment programs, and R&D project financial planning"
  source: "`pharmaceuticals_ecm`.`finance`.`wbs_element`"
  dimensions:
    - name: "wbs_element_type"
      expr: wbs_element_type
      comment: "Type of WBS element (project, phase, work package)"
    - name: "status"
      expr: status
      comment: "Current WBS element status (active, closed, on-hold)"
    - name: "wbs_level"
      expr: wbs_level
      comment: "Hierarchical level in WBS structure"
    - name: "planning_element_flag"
      expr: planning_element_flag
      comment: "Flag indicating planning-only element"
    - name: "billing_element_flag"
      expr: billing_element_flag
      comment: "Flag indicating billable element"
    - name: "account_assignment_element_flag"
      expr: account_assignment_element_flag
      comment: "Flag indicating cost assignment element"
    - name: "capitalization_eligible_flag"
      expr: capitalization_eligible_flag
      comment: "Flag indicating capitalization eligibility"
    - name: "statistical_flag"
      expr: statistical_flag
      comment: "Flag indicating statistical (non-financial) element"
    - name: "priority_code"
      expr: priority_code
      comment: "Priority code for resource allocation"
    - name: "start_year"
      expr: YEAR(start_date)
      comment: "Year WBS element started"
  measures:
    - name: "total_planning_budget"
      expr: SUM(CAST(planning_budget_amount AS DOUBLE))
      comment: "Total planned budget for WBS elements (key project investment metric)"
    - name: "avg_planning_budget"
      expr: AVG(CAST(planning_budget_amount AS DOUBLE))
      comment: "Average budget per WBS element"
    - name: "wbs_element_count"
      expr: COUNT(1)
      comment: "Total number of WBS elements"
    - name: "unique_project_count"
      expr: COUNT(DISTINCT project_id)
      comment: "Number of unique projects with WBS structure"
    - name: "avg_project_duration_days"
      expr: AVG(CAST(DATEDIFF(end_date, start_date) AS DOUBLE))
      comment: "Average project duration in days"
$$;
